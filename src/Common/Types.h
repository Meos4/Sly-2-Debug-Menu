#ifndef SLY_TYPES_H
#define SLY_TYPES_H

#include <stdint.h>

typedef uint16_t u16;
typedef int16_t s16;
typedef int32_t s32;
typedef uint32_t u32;

_Static_assert(sizeof(u16) == 2, "u16 must be 16 bits");
_Static_assert(sizeof(s16) == 2, "s16 must be 16 bits");
_Static_assert(sizeof(s32) == 4, "s32 must be 32 bits");
_Static_assert(sizeof(u32) == 4, "u32 must be 32 bits");
_Static_assert(sizeof(void*) == 4, "The EE build needs 32-bit pointers");

#endif
