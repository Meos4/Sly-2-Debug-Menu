#include "NameCache.h"

#include "Game.h"
#include "Menu.h"
#include "Profile.h"

#define SLOT_CODE __attribute__((section(".nameSlot")))
#define LOOKUP_CODE __attribute__((section(".nameLookup")))
#define RESET_CODE __attribute__((section(".nameReset")))
#define FIND_CODE __attribute__((section(".jobsStale")))
#define FIXED_COUNT 256u
#define RECORD_SIZE 64u
#define OVERFLOW_SIZE 80u

SLOT_CODE u32 NameCache_slot(u32 object)
{
	u32 index;
	u32 record;
	u32 firstFreeRecord = 0;
	u32 cursor;
	u32 limit;

	PAD_FRAME(2);

	for (index = 0; index < FIXED_COUNT; ++index)
	{
		record = NAME_CACHE + index * RECORD_SIZE;

		if (WORD(record + CACHE_OBJECT_OFFSET) == object)
		{
			return record;
		}

		if (!firstFreeRecord && !WORD(record + CACHE_OBJECT_OFFSET))
		{
			firstFreeRecord = record;
		}
	}

	for (record = WORD(NAME_OVERFLOW); record; record = WORD(record + CACHE_NEXT_OFFSET))
	{
		if (WORD(record + CACHE_OBJECT_OFFSET) == object)
		{
			return record;
		}
	}

	if (firstFreeRecord)
	{
		return firstFreeRecord;
	}

	cursor = (WORD(PROFILE_NAME_ARENA_CURSOR) + 15) & ~15u;
	limit = WORD(PROFILE_NAME_ARENA_LIMIT);

	if (!cursor || limit < cursor || limit - cursor < OVERFLOW_SIZE)
	{
		return 0;
	}

	record = Game_allocatePermanent(OVERFLOW_SIZE);

	if (record)
	{
		WORD(record + CACHE_NEXT_OFFSET) = WORD(NAME_OVERFLOW);
		WORD(NAME_OVERFLOW) = record;
	}

	return record;
}

LOOKUP_CODE const char* NameCache_lookup(u32 object)
{
	u32 index;
	u32 record;
	const u32 oid = WORD(object + PROFILE_OBJECT_OID);

	for (index = 0; index < FIXED_COUNT; ++index)
	{
		record = NAME_CACHE + index * RECORD_SIZE;

		if (WORD(record + CACHE_OBJECT_OFFSET) == object && WORD(record + CACHE_OID_OFFSET) == oid)
		{
			return (const char*)(record + CACHE_NAME_OFFSET);
		}
	}

	for (record = WORD(NAME_OVERFLOW); record; record = WORD(record + CACHE_NEXT_OFFSET))
	{
		if (WORD(record + CACHE_OBJECT_OFFSET) == object && WORD(record + CACHE_OID_OFFSET) == oid)
		{
			return (const char*)(record + CACHE_NAME_OFFSET);
		}
	}

	return 0;
}

FIND_CODE u32 NameCache_find(u32 oid)
{
	u32 record;

	for (record = NAME_CACHE; record < NAME_CACHE + FIXED_COUNT * RECORD_SIZE; record += RECORD_SIZE)
	{
		if (WORD(record + CACHE_OBJECT_OFFSET) && WORD(record + CACHE_OID_OFFSET) == oid)
		{
			return WORD(record + CACHE_OBJECT_OFFSET);
		}
	}

	for (record = WORD(NAME_OVERFLOW); record; record = WORD(record + CACHE_NEXT_OFFSET))
	{
		if (WORD(record + CACHE_OID_OFFSET) == oid)
		{
			return WORD(record + CACHE_OBJECT_OFFSET);
		}
	}

	return 0;
}

RESET_CODE void NameCache_reset(void)
{
	u32 record;

	WORD(NAME_OVERFLOW) = 0;
	WORD(PAUSE_OWNED) = 0;
	WORD(WARPS_STALE) = 1;

	for (record = NAME_CACHE; record < NAME_CACHE + FIXED_COUNT * RECORD_SIZE; record += RECORD_SIZE)
	{
		WORD(record + CACHE_OBJECT_OFFSET) = 0;
	}
}

__attribute__((section(".nameClone"))) void NameCache_clone(u32 destination, u32 source)
{
	u32 record;
	u32 offset;
	const char* name;

	if (!destination || !source || destination == source)
	{
		return;
	}

	name = NameCache_lookup(source);

	if (!name)
	{
		return;
	}

	record = NameCache_slot(destination);

	if (!record)
	{
		return;
	}

	WORD(record + CACHE_OBJECT_OFFSET) = destination;
	WORD(record + CACHE_OID_OFFSET) = WORD(destination + PROFILE_OBJECT_OID);

	for (offset = 0; offset < 48; offset += 4)
	{
		WORD(record + CACHE_NAME_OFFSET + offset) = WORD((u32)name + offset);
	}

	WORD(record + CACHE_VISIBILITY_OFFSET) = 0;
	WORD(record + CACHE_RESERVED_OFFSET) = 0;
}
