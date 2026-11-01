#ifndef SLY_ENTRY_H
#define SLY_ENTRY_H

#include "Common/Types.h"

enum
{
	ENTRY_LOAD_MENU_ENTRANCE_OID = 0x189u,
	ENTRY_LOAD_NO_FILTER = ~0u,
	ENTRY_LOAD_DIRECT = ~0u
};

void Entry_taskWalk(u32 object, u32* count, u32* objects, u32 depth, u32 groupDepth);
void Entry_clock(u32 clock, u32 slot, u32 floatBits);
void Entry_load(u32 world, u32 descriptor, u32 entranceOid, u32 entranceFilter, u32 flags, u32 routeSelector);
u32 Entry_enumObjects(u32 world, u32 list, u32 kind, u32 flags, u32 capacity, u32* objects);

#endif
