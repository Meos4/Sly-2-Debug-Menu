#ifndef SLY_NAME_CACHE_H
#define SLY_NAME_CACHE_H

#include "Common/Types.h"

enum
{
	CACHE_OBJECT_OFFSET = 0,
	CACHE_OID_OFFSET = 4,
	CACHE_NAME_OFFSET = 8,
	CACHE_VISIBILITY_OFFSET = 56,
	CACHE_RESERVED_OFFSET = 60,
	CACHE_NEXT_OFFSET = 64
};

u32 NameCache_slot(u32 object);
const char* NameCache_lookup(u32 object);
void NameCache_reset(void);
u32 NameCache_find(u32 oid);
void NameCache_clone(u32 destination, u32 source);

#endif
