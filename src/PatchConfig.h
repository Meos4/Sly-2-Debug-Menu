#ifndef SLY_PATCH_CONFIG_H
#define SLY_PATCH_CONFIG_H

#ifndef SLY_PATCH_BASE
#define SLY_PATCH_BASE 0x000F0000
#endif

#if (SLY_PATCH_BASE & 0xFFFF) != 0
#error "SLY_PATCH_BASE must be aligned to 64 KiB"
#endif

#endif
