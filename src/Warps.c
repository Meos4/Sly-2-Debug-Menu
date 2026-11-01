#include "Warps.h"

#include "Character.h"
#include "Destinations.h"
#include "Entry.h"
#include "Game.h"
#include "Menu.h"
#include "Names.h"
#include "Profile.h"

#define LIST_CODE __attribute__((section(".warps")))
#define ACTION_CODE __attribute__((section(".warpsAction")))
#define VOICE_CODE __attribute__((section(".warpsVoice"), noinline))
#define BINOC_CODE __attribute__((section(".warpsBinoc"), noinline))
#define SILENT_CODE __attribute__((section(".warpsSilent"), noinline))
#define CAPTURE_CODE __attribute__((section(".warpsCapture"), noinline))
#define WARP_CAPACITY 64u
#define NAME_LIMIT 47u
#define MATRIX_SIZE 64u

static LIST_CODE void Warps_copyLabel(u32 entry, const char* name)
{
	u32 index = 0;
	char* const label = (char*)entry;

	while (index < NAME_LIMIT && name[index])
	{
		label[index] = name[index];
		++index;
	}
}

static LIST_CODE void Warps_clearEntry(u32 entry)
{
	Menu_clearEntry(entry);
}

static LIST_CODE s32 Warps_compare(const char* left, const char* right)
{
	u32 leftCharacter;
	u32 rightCharacter;

	do
	{
		leftCharacter = (unsigned char)*left++;
		rightCharacter = (unsigned char)*right++;

		if (leftCharacter >= 'a' && leftCharacter <= 'z')
		{
			leftCharacter -= 'a' - 'A';
		}

		if (rightCharacter >= 'a' && rightCharacter <= 'z')
		{
			rightCharacter -= 'a' - 'A';
		}

		if (leftCharacter != rightCharacter)
		{
			return leftCharacter - rightCharacter;
		}
	}
	while (leftCharacter);

	return 0;
}

static LIST_CODE void Warps_sort(u32 count)
{
	u32 index;
	u32 cursor;
	u32 offset;
	u32 swap;
	u32 entryAddress;

	for (index = 1; index < count; ++index)
	{
		cursor = index;

		while (cursor)
		{
			entryAddress = DEST_TABLE + cursor * sizeof(MenuData_Entry);

			if (Warps_compare((const char*)(entryAddress - sizeof(MenuData_Entry)), (const char*)entryAddress) <= 0)
			{
				break;
			}

			for (offset = 0; offset < sizeof(MenuData_Entry); offset += 4)
			{
				swap = WORD(entryAddress + offset);
				WORD(entryAddress + offset) = WORD(entryAddress - sizeof(MenuData_Entry) + offset);
				WORD(entryAddress - sizeof(MenuData_Entry) + offset) = swap;
			}

			--cursor;
		}
	}
}

static CAPTURE_CODE void Warps_capture(const u32* objects, u32 count)
{
	u32 index;
	u32 offset;
	u32 matrix;
	u32 slot;

	PAD_FRAME(2);

	WORD(WARPS_STALE) = 0;

	for (offset = 0; offset < WARPS_SHADOW_SIZE; offset += 4)
	{
		WORD(WARPS_SHADOW + offset) = 0;
	}

	WORD(WARPS_SHADOW + PROFILE_CHARACTER_VTABLE) = WORD(objects[0] + PROFILE_CHARACTER_VTABLE);

	for (index = 0; index < count; ++index)
	{
		slot = WARPS_MATRICES + index * MATRIX_SIZE;
		matrix = Character_callVirtual(objects[index], PROFILE_WARP_GET_MATRIX, 0);

		for (offset = 0; offset < MATRIX_SIZE; offset += 4)
		{
			WORD(slot + offset) = WORD(matrix + offset);
		}

		((MenuData_Entry*)DEST_TABLE)[index].argument = slot;
	}
}

static CAPTURE_CODE void Warps_moveToCapture(u32 character, u32 slot)
{
	u32 offset;

	PAD_FRAME(2);

	for (offset = 0; offset < MATRIX_SIZE; offset += 4)
	{
		WORD(WARPS_SHADOW + PROFILE_WARP_MATRIX + offset) = WORD(slot + offset);
	}

	Character_callVirtual(character, PROFILE_CHARACTER_MATCH, WARPS_SHADOW);
}

LIST_CODE void Warps_build(void)
{
	volatile MenuData_Entry* item;
	u32 objects[WARP_CAPACITY + 4] __attribute__((aligned(16)));
	u32 index;
	u32 entryAddress;
	u32 count;
	const char* name;

	PAD_FRAME(4);

	WORD(DEST_COUNT) = 0;
	WORD(DEST_FIRST) = 0;
	count = Entry_enumObjects(WORLD, 5, PROFILE_WARP_CLASS, 0, WARP_CAPACITY, objects);

	if ((s32)count < 0)
	{
		count = 0;
	}

	if (count > WARP_CAPACITY)
	{
		count = WARP_CAPACITY;
	}

	for (index = 0; index < count; ++index)
	{
		name = Destinations_name(objects[index]);

		if (!name)
		{
			Warps_clearEntry(DEST_TABLE);
			Warps_copyLabel(DEST_TABLE, (const char*)DEST_MISSING_NAMES);
			WORD(DEST_COUNT) = 1;
			return;
		}

		name = Names_skipPrefix(name, Warps_text[2]);

		entryAddress = DEST_TABLE + index * sizeof(MenuData_Entry);

		item = (volatile MenuData_Entry*)entryAddress;
		Warps_clearEntry(entryAddress);
		Warps_copyLabel(entryAddress, name);
		item->data = objects[index];
	}

	if (count)
	{
		Warps_capture(objects, count);
		Warps_sort(count);
	}
	else
	{
		count = 1;
		Warps_clearEntry(DEST_TABLE);
		Warps_copyLabel(DEST_TABLE, Warps_text[1]);
	}

	WORD(DEST_COUNT) = count;
}

static BINOC_CODE void Warps_closeBinoc(u32 character)
{
	const u32 binoc = character + PROFILE_BUD_BINOC;

	PAD_FRAME(2);

	/* Warp may have cleared the pause counters while Binocucom is still open */
	if (WORD(binoc + PROFILE_BINOC_STATE) != 0xFFFFFFFFu && WORD(binoc + PROFILE_BINOC_MODE) == 1)
	{
		if (!WORD(WORLD + PROFILE_WORLD_INPUT_PAUSE_COUNT))
		{
			Game_pauseInput(WORLD);
		}

		if (!WORD(WORLD + PROFILE_WORLD_EXTRA_PAUSE_COUNT))
		{
			Game_pauseExtra(WORLD);
		}
	}

	Game_setBinocState(binoc, -1);
}

static SILENT_CODE void Warps_stopSilentDialogue(u32 character)
{
	u32 script;
	u32 node;
	const u32 binoc = character + PROFILE_BUD_BINOC;

	PAD_FRAME(2);

	if (WORD(binoc + PROFILE_BINOC_STATE) == 0xFFFFFFFFu)
	{
		return;
	}

	/* Warp also leaves ordinary binoculars */
	if (WORD(binoc + PROFILE_BINOC_MODE) != 1)
	{
		Warps_closeBinoc(character);
		return;
	}

	script = WORD(Game_classObjects(WORLD, PROFILE_SCRIPT_CLASS));

	while (script)
	{
		node = WORD(script + PROFILE_SCRIPT_NODES);

		while (node && WORD(node + PROFILE_SCRIPT_BINOC_BUD) != character)
		{
			node = WORD(node + PROFILE_SCRIPT_NODE_NEXT);
		}

		if (node)
		{
			Game_stopScript(script);
			break;
		}

		script = WORD(script + PROFILE_OBJECT_NEXT);
	}

	Warps_closeBinoc(character);
	Game_clearSubtitles(SUBTITLE_MANAGER);
}

static SILENT_CODE u32 Warps_findVoiceScript(u32 script)
{
	u32 node;
	u32 instruction;

	PAD_FRAME(2);

	while (script)
	{
		node = WORD(script + PROFILE_SCRIPT_NODES);

		while (node)
		{
			instruction = WORD(node + PROFILE_SCRIPT_WAIT);

			if (instruction && WORD(instruction) == PROFILE_SCRIPT_SAY_OPCODE
				&& Game_isVoicePlaying(VOICE_MANAGER, WORD(instruction + PROFILE_SCRIPT_SAY_ID)))
			{
				return script;
			}

			node = WORD(node + PROFILE_SCRIPT_NODE_NEXT);
		}

		script = WORD(script + PROFILE_OBJECT_NEXT);
	}

	return 0;
}

static VOICE_CODE void Warps_stopVoice(u32 character)
{
	u32 script;

	PAD_FRAME(4);

	if (!Game_isVoicePlaying(VOICE_MANAGER, 0xFFFFFFFFu))
	{
		Warps_stopSilentDialogue(character);
		return;
	}

	script = Warps_findVoiceScript(WORD(Game_classObjects(WORLD, PROFILE_SCRIPT_CLASS)));

	if (script)
	{
		Game_stopScript(script);
	}

	Warps_closeBinoc(character);
	Game_stopVoice(VOICE_MANAGER);
	Game_clearSubtitles(SUBTITLE_MANAGER);
}

ACTION_CODE void Warps_activate(MenuData_Entry* item)
{
	u32 warpObject;
	u32 script;
	const u32 character = WORD(ACTIVE_CHARACTER);

	warpObject = item->data;

	if (!character)
	{
		return;
	}

	if (Game_isKind(character, PROFILE_BUD_CLASS))
	{
		Warps_stopVoice(character);

		script = WORD(character + PROFILE_BUD_SCRIPT);

		if (script)
		{
			Game_stopScript(WORD(script + PROFILE_SCRIPT_OWNER));
		}

		Character_callVirtual(character, PROFILE_BUD_MOVEMENT_RESET, 0);
	}

	if (!Game_isKind(character, PROFILE_WARP_STATIONARY_CLASS))
	{
		if (WORD(WARPS_STALE))
		{
			Warps_moveToCapture(character, item->argument);
		}
		else
		{
			Game_warp(warpObject);
		}

		Game_dirtyCamera(NATIVE_CAMERA);
	}

	while ((s32)WORD(WORLD + PROFILE_WORLD_PAUSE_COUNT) >= 2)
	{
		Game_resume(WORLD, 0);
	}

	while ((s32)WORD(WORLD + PROFILE_WORLD_INPUT_PAUSE_COUNT) > 0)
	{
		Game_resumeInput(WORLD);
	}

	while ((s32)WORD(WORLD + PROFILE_WORLD_SOUND_PAUSE_COUNT) > 0)
	{
		Game_resumeSound(WORLD);
	}

	while ((s32)WORD(WORLD + PROFILE_WORLD_EXTRA_PAUSE_COUNT) > 0)
	{
		Game_resumeExtra(WORLD);
	}
}

const char Warps_text[3][64] __attribute__((section(".menu.Warps"), used, aligned(4))) =
{
	"Warp...",
	"(No Warp Positions)",
	"warp_",
};
