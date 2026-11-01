#include "NativeWorlds.h"

#include "Common/Types.h"
#include "Layout.h"
#include "Menu.h"

#define WORLD_CODE __attribute__((section(".profile.NativeWorlds")))

extern const u32 Game_worldCount[];

static const char NativeWorlds_prefix[] = "World 0x";
static const char NativeWorlds_empty[] = "(No Worlds)";

static WORLD_CODE const char* NativeWorlds_name(u32 fid)
{
	const char* record = NativeWorlds_names;
	u32 recordFid;

	while (*record)
	{
		recordFid = (unsigned char)*record++;

		if (recordFid == fid)
		{
			return record;
		}

		while (*record)
		{
			++record;
		}

		++record;
	}

	return 0;
}

WORLD_CODE void NativeWorlds_build(void)
{
	const u32 count = Game_worldCount[0];
	const u32 table = Game_worldCount[2];
	u32 index;
	u32 offset;
	u32 entryAddress;
	volatile MenuData_Entry* item;
	u32 descriptor;
	u32 fid;
	u32 digit;
	u32 listed = 0;
	char* label;
	const char* name;

	WORD(DEST_COUNT) = 0;
	WORD(DEST_FIRST) = 0;
	WORD(DEST_FIRST + 4) = 0;

	if (table && count <= 256)
	{
		for (index = 0; index < count; ++index)
		{
			descriptor = table + index * 64;
			fid = WORD(descriptor + 8) ^ WORD(descriptor + 56);

			if (!fid || !(WORD(descriptor + 4) ^ WORD(descriptor + 60)))
			{
				continue;
			}

			entryAddress = DEST_TABLE + listed * 64;
			item = (volatile MenuData_Entry*)entryAddress;

			Menu_clearEntry(entryAddress);

			label = (char*)entryAddress;
			name = NativeWorlds_name(fid);

			if (name)
			{
				for (offset = 0; offset < 47 && name[offset]; ++offset)
				{
					label[offset] = name[offset];
				}
			}
			else
			{
				/* Unknown FIDs keep a numeric label */
				for (offset = 0; offset < sizeof(NativeWorlds_prefix) - 1; ++offset)
				{
					label[offset] = NativeWorlds_prefix[offset];
				}

				for (offset = 0; offset < 8; ++offset)
				{
					digit = (fid >> (28 - offset * 4)) & 15;
					label[8 + offset] = (char)(digit < 10 ? '0' + digit : 'A' + digit - 10);
				}
			}

			item->argument = fid;
			item->data = descriptor;
			++listed;
		}
	}

	if (!listed)
	{
		Menu_clearEntry(DEST_TABLE);

		label = (char*)DEST_TABLE;

		for (offset = 0; offset < sizeof(NativeWorlds_empty); ++offset)
		{
			label[offset] = NativeWorlds_empty[offset];
		}

		listed = 1;
	}

	WORD(DEST_COUNT) = listed;
}
