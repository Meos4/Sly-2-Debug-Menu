<img width="1916" height="1439" alt="Screen" src="https://github.com/user-attachments/assets/1f29d16b-d764-4ceb-936c-68e61bb108b6" />

&nbsp;

Brings the debug menu from the March 2004 prototype back to every retail release. Load world, warp around a level, free camera, swap characters, and force jobs states.

It's C and R5900 assembly that gets compiled into a `.pnach` patch for PCSX2.

# Versions

| Version  | Build       | PCSX2 CRC  | Profile  |
|----------|-------------|------------|----------|
| NTSC-U   | `0813.0032` | `07652DD9` | `NtscU`  |
| PAL 1.0  | `0914.1846` | `FDA1CBF6` | `Pal`    |
| PAL 2.01 | `1006.2123` | `15DD1F6F` | `Pal201` |
| NTSC-J   | `0121.1144` | `615EA2DB` | `NtscJ`  |
| NTSC-K   | `1221.1745` | `518DD841` | `NtscK`  |

# Building

- Python 3.10 or newer.
- A `mipsel-none-elf-gcc` toolchain with R5900 support, including `nm` and `objdump`.

| Argument                | Default                    | What it does                                                                                        |
|-------------------------|----------------------------|-----------------------------------------------------------------------------------------------------|
| `--profile <name>`      | `all`                      | Version to build: `all`, `NtscU`, `Pal`, `Pal201`, `NtscJ`, `NtscK`                                 |
| `--gcc <path>`          | `MIPS_GCC`, then `PATH`    | Path to `mipsel-none-elf-gcc`                                                                       |
| `--output <folder>`     | `build`                    | Where to write the `.pnach` files and the `src/<profile>/` folders                                  |
| `--base-address <addr>` | `0x000F0000`               | Moves the 64 KiB block the menu lives in (has to be a multiple of `0x10000`)                        |

# How to use

**R1 + Select** to open the menu
