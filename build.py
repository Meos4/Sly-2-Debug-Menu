import argparse
import hashlib
import json
import os
import re
import shutil
import struct
import subprocess
from pathlib import Path

ELF_HEADER_SIZE = 52
SECTION_NAME = 0
SECTION_OFFSET = 4

SHF_ALLOC = 2
SHF_EXECINSTR = 4
SHT_NOBITS = 8


class Elf:
    def __init__(self, path):
        self.data = data = Path(path).read_bytes()

        if len(data) < ELF_HEADER_SIZE or data[:6] != b'\x7fELF\x01\x01':
            raise ValueError('Expected an ELF32 little-endian executable.')

        section_table_offset = struct.unpack_from('<I', data, 32)[0]
        section_header_size, section_count, names_index = struct.unpack_from(
            '<3H', data, 46
        )
        headers = [
            struct.unpack_from(
                '<10I', data, section_table_offset + i * section_header_size
            )
            for i in range(section_count)
        ]

        names_offset = headers[names_index][SECTION_OFFSET]
        self.sections = []

        for header in headers:
            name_offset = names_offset + header[SECTION_NAME]
            name = data[name_offset:].split(b'\0', 1)[0].decode('ascii')

            self.sections.append(dict(
                name=name,
                type=header[1],
                flags=header[2],
                vaddr=header[3],
                offset=header[4],
                size=header[5],
            ))


ROOT = Path(__file__).resolve().parent

FLAGS = [
    '-march=r5900', '-mabi=32', '-msoft-float', '-mfix-r5900', '-G0',
    '-mno-abicalls', '-fno-pic', '-ffreestanding', '-fno-builtin',
    '-fno-stack-protector', '-fno-asynchronous-unwind-tables',
    '-fno-jump-tables', '-fno-tree-switch-conversion',
    '-Os', '-Wall', '-Wextra', '-Werror', '-std=c11',
]


def _require(condition, message):
    if not condition:
        raise ValueError(message)


def build(gcc_executable, profile_name, output_path, base_address):
    if not re.fullmatch(r'[A-Za-z][A-Za-z0-9_]*', profile_name):
        raise ValueError('Invalid profile name.')

    profile_path = (
        ROOT / 'src/Profiles' / profile_name / (profile_name + '.json')
    )
    profile = json.loads(profile_path.read_text(encoding='utf-8'))

    patch_version = (ROOT / 'src/Version.txt').read_text(
        encoding='utf-8'
    ).strip()

    _require(
        re.fullmatch(r'\d+\.\d+\.\d+', patch_version),
        'Invalid patch version in src/Version.txt (expected X.Y.Z).',
    )

    output_root = (
        Path(output_path).expanduser().resolve()
        if output_path
        else ROOT / profile['output']
    )
    build_directory = output_root / 'src' / profile_name
    build_directory.mkdir(parents=True, exist_ok=True)

    compiler = gcc_executable or os.environ.get('MIPS_GCC')
    if compiler:
        compiler = shutil.which(compiler) or compiler
    else:
        compiler = shutil.which('mipsel-none-elf-gcc')
    gcc = Path(compiler).expanduser().resolve() if compiler else None

    if gcc is None or not gcc.is_file():
        raise SystemExit(
            'Set MIPS_GCC or add mipsel-none-elf-gcc to PATH.'
        )

    commands = []

    def run(args):
        commands.append([str(a) for a in args])
        result = subprocess.run(args, cwd=ROOT, text=True, capture_output=True)

        if result.returncode:
            raise SystemExit(result.stdout + result.stderr)

        return result.stdout

    def tool(name):
        return str(gcc.with_name(gcc.name.replace('gcc', name)))

    compiler_version = run([
        str(gcc), '--version',
    ]).splitlines()[0]

    sources = sorted(
        p for p in (ROOT / 'src').rglob('*')
        if p.suffix in ('.c', '.S') and 'Profiles' not in p.parts
    )
    sources += [ROOT / p for p in profile['sources']]

    includes = [
        '-Isrc',
        f'-DSLY_PROFILE_HEADER="{profile["header"]}"',
        f'-DSLY_PROFILE_OFFSETS="{profile["offsets_header"]}"',
    ]

    if base_address is not None:
        _require(
            base_address % 0x10000 == 0,
            'The patch base must be a 64 KiB aligned address.',
        )
        includes.append(f'-DSLY_PATCH_BASE=0x{base_address:08X}')

    linker = build_directory / 'layout.ld'
    run([
        str(gcc), *includes, '-E', '-P', '-undef', '-x', 'c',
        'src/Linker.ld', '-o', str(linker),
    ])

    objects = []

    for source in sources:
        obj = build_directory / (source.stem + '.o')
        objects.append(obj)

        run([
            str(gcc), *FLAGS, *includes, '-g', '-c',
            str(source), '-o', str(obj),
        ])

        if source.suffix == '.c':
            assembly_path = build_directory / (source.stem.lower() + '.s')

            run([
                str(gcc), *FLAGS, *includes, '-S', str(source),
                '-o', str(assembly_path),
            ])

            frames = re.findall(
                r'\.frame\s+\$sp,(\d+),',
                assembly_path.read_text(encoding='utf-8'),
            )
            _require(
                all(int(n) % 16 == 0 for n in frames),
                f'Unaligned EE stack frame in {source.name}.',
            )

    # Link order determines addresses within the shared C control section
    link_priority = {'Menu.o': 0, 'Camera.o': 1}
    objects.sort(key=lambda p: (link_priority.get(p.name, 2), p.name))

    run([
        str(gcc), *FLAGS, '-nostdlib', '-nostartfiles',
        '-Wl,--build-id=none', '-Wl,--fatal-warnings',
        '-Wl,-Map=' + str(build_directory / 'menu.map'),
        '-T', str(linker), '-T', profile['linker'],
        *[str(p) for p in objects], '-o', str(build_directory / 'menu.elf'),
    ])

    symbols = {}

    for line in run([
        tool('nm'), '-n', '--defined-only', str(build_directory / 'menu.elf'),
    ]).splitlines():
        fields = line.split()

        if len(fields) == 3:
            symbols[fields[2]] = int(fields[0], 16)

    _require(
        not run([
            tool('nm'), '-u', str(build_directory / 'menu.elf'),
        ]).strip(),
        'The linked ELF contains undefined symbols.',
    )

    (build_directory / 'disassembly.txt').write_text(
        run([
            tool('objdump'), '-d', '-S', '-m', 'mips:5900',
            str(build_directory / 'menu.elf'),
        ]),
        encoding='utf-8',
    )

    elf = Elf(build_directory / 'menu.elf')
    recurring_writes = {}
    boot_writes = {}
    initial_writes = {}
    sections = []

    def insert(table, address, value):
        _require(
            address % 4 == 0 and address not in table,
            f'Duplicate or unaligned write at {address:08X}.',
        )
        table[address] = value

    for section in elf.sections:
        name = section['name']
        size = section['size']
        data = elf.data[section['offset']:section['offset'] + size]

        if name == '.initializers':
            _require(size % 16 == 0, 'Invalid initializer section size.')

            for address, count, stride, value in struct.iter_unpack(
                '<4I', data
            ):
                _require(
                    count > 0 and stride % 4 == 0,
                    f'Invalid initializer at {address:08X}.',
                )

                for index in range(count):
                    insert(initial_writes, address + index * stride, value)

            continue

        if not (section['flags'] & SHF_ALLOC) or not size:
            continue

        _require(
            section['type'] != SHT_NOBITS,
            'Uninitialized C storage is not exported.',
        )

        address = section['vaddr']
        _require(
            address % 4 == 0 and size % 4 == 0,
            f'Unaligned ELF section: {name}.',
        )

        for offset in range(0, size, 4):
            value = int.from_bytes(data[offset:offset + 4], 'little')
            insert(recurring_writes, address + offset, value)

            if name.startswith('.boot.'):
                insert(boot_writes, address + offset, value)

        sections.append(dict(
            name=name,
            address=address,
            size=size,
            executable=bool(section['flags'] & SHF_EXECINSTR),
        ))

    _require(
        not initial_writes.keys() & recurring_writes.keys(),
        'Initializers overlap regularly applied code or data.',
    )

    pnach = output_root / (
        f'{profile["crc"]} ({profile["title"]} Debug Menu).pnach'
    )

    lines = [
        'gametitle=' + profile['title'],
        'comment=Debug menu v' + patch_version,
        '',
    ]
    lines += [
        f'patch=1,EE,{address:08X},word,{value:08X}'
        for address, value in sorted(recurring_writes.items())
    ]
    lines += [
        f'patch=0,EE,{address:08X},word,{value:08X}'
        for address, value in sorted((boot_writes | initial_writes).items())
    ]

    pnach.write_text('\n'.join(lines) + '\n', encoding='utf-8', newline='\n')

    manifest = dict(
        profile=profile['id'],
        patch_version=patch_version,
        patch_base=symbols['__patchBase'],
        patch_end=symbols['__patchEnd'],
        target=dict(
            serial=profile['serial'],
            build=profile['build'],
            crc=profile['crc'],
        ),
        patches={
            str(address): value
            for address, value in sorted(recurring_writes.items())
        },
        initial_control={
            str(address): value
            for address, value in sorted(initial_writes.items())
        },
        boot_code_patches={
            str(address): value
            for address, value in sorted(boot_writes.items())
        },
        code_size=symbols['__controlEnd'] - symbols['__controlStart'],
        c_project=dict(
            compiler=compiler_version,
            compiler_sha256=hashlib.sha256(gcc.read_bytes()).hexdigest(),
            flags=FLAGS,
            sections=sections,
            symbols=symbols,
            commands=commands,
            adapter_size=(
                symbols['RenderAdapter_end'] - symbols['RenderAdapter_start']
            ),
            sources={
                str(p.relative_to(ROOT)): hashlib.sha256(
                    p.read_bytes()).hexdigest()
                for p in sorted((ROOT / 'src').rglob('*')) if p.is_file()
            },
        ),
        pnach_sha256=hashlib.sha256(pnach.read_bytes()).hexdigest(),
    )

    (build_directory / 'manifest.json').write_text(
        json.dumps(manifest, indent=2, ensure_ascii=False) + '\n',
        encoding='utf-8',
    )

    print(f'Profile {profile_name}: {len(sources)} sources compiled')

def main():
    profiles = sorted(
        path.name for path in (ROOT / 'src/Profiles').iterdir()
        if (path / (path.name + '.json')).is_file()
    )

    parser = argparse.ArgumentParser()
    parser.add_argument('--gcc', help='R5900 mipsel-none-elf-gcc executable')
    parser.add_argument(
        '--profile',
        choices=['all', *profiles],
        default='all',
        help='Target profile (default: all)',
    )
    parser.add_argument(
        '--output',
        help='Output root for PNACH files and src/<profile> '
             'compilation directories',
    )
    parser.add_argument(
        '--base-address',
        type=lambda value: int(value, 0),
        help='Override SLY_PATCH_BASE from PatchConfig.h',
    )

    args = parser.parse_args()

    try:
        selected = profiles if args.profile == 'all' else [args.profile]

        for profile in selected:
            build(args.gcc, profile, args.output, args.base_address)

    except (OSError, ValueError) as error:
        parser.exit(1, f'Build failed: {error}\n')


if __name__ == '__main__':
    main()
