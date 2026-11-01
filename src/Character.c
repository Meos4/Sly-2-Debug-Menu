#include "Character.h"

#include "Destinations.h"
#include "Game.h"
#include "Menu.h"
#include "Profile.h"

#define LIST_CODE __attribute__((section(".characters")))
#define ACTION_CODE __attribute__((section(".characterAction")))
#define MATCH_CURRENT_CHARACTER 8u

typedef u32 (*Character_Method)(u32 object, u32 argument);

void Character_load(u32 object, u32 stream)
{
	Game_loadSo(object, stream);
	Destinations_capture(stream, object);
}

LIST_CODE void Character_build(u32 matchCurrentCharacter)
{
	volatile MenuData_Entry* item;
	u32 index;
	u32 offset;
	u32 object;
	u32 entryAddress;
	char* label;
	const char* name;
	const u32 count = WORD(WORLD + PROFILE_WORLD_CHARACTER_COUNT);

	PAD_FRAME(2);

	WORD(DEST_FIRST) = 0;
	WORD(DEST_COUNT) = 0;

	if (count > PROFILE_CHARACTER_CAPACITY)
	{
		return;
	}

	for (index = 0; index < (count ? count : 1); ++index)
	{
		entryAddress = DEST_TABLE + index * sizeof(MenuData_Entry);
		item = (volatile MenuData_Entry*)entryAddress;
		label = (char*)item->label;

		Menu_clearEntry(entryAddress);

		object = count ? WORD(WORLD + PROFILE_WORLD_CHARACTERS + index * 4) : 0;
		name = object ? Destinations_name(object) : Character_text[1];

		if (!name)
		{
			name = (const char*)DEST_MISSING_NAMES;
			object = 0;
		}

		for (offset = 0; offset < 47 && name[offset]; ++offset)
		{
			label[offset] = name[offset];
		}

		item->argument = object ? WORD(object + PROFILE_OBJECT_OID) : 0;
		item->data = object;
		item->flags = matchCurrentCharacter ? MATCH_CURRENT_CHARACTER : 0;
	}

	WORD(DEST_COUNT) = count ? count : 1;
}

ACTION_CODE u32 Character_callVirtual(u32 object, u32 slot, u32 argument)
{
	const u32 vtable = WORD(object + PROFILE_CHARACTER_VTABLE);
	const s32 thisAdjustment = *(const s16*)(vtable + slot);
	const Character_Method method = (Character_Method)WORD(vtable + slot + 4);

	return method(object + thisAdjustment, argument);
}

static ACTION_CODE u32 Character_find(const MenuData_Entry* item)
{
	u32 index;
	u32 object;
	u32 found = 0;
	const u32 count = WORD(WORLD + PROFILE_WORLD_CHARACTER_COUNT);

	for (index = 0; index < count; ++index)
	{
		object = WORD(WORLD + PROFILE_WORLD_CHARACTERS + index * 4);

		if (WORD(object + PROFILE_OBJECT_OID) == item->argument)
		{
			if (object == item->data)
			{
				return object;
			}

			if (!found)
			{
				found = object;
			}
		}
	}

	return found;
}

ACTION_CODE void Character_activate(MenuData_Entry* item)
{
	u32 nextCharacter;
	u32 currentIsStationary;
	u32 nextIsStationary;
	const u32 currentCharacter = WORD(ACTIVE_CHARACTER);

	PAD_FRAME(2);

	nextCharacter = Character_find(item);

	if (!nextCharacter)
	{
		item->flags |= MENU_KEEP_OPEN;
		return;
	}

	if (nextCharacter == currentCharacter)
	{
		return;
	}

	currentIsStationary = currentCharacter && Game_isKind(currentCharacter, PROFILE_WARP_STATIONARY_CLASS);
	nextIsStationary = Game_isKind(nextCharacter, PROFILE_WARP_STATIONARY_CLASS);
	Character_callVirtual(nextCharacter, PROFILE_CHARACTER_ADD, 0);

	if ((item->flags & MATCH_CURRENT_CHARACTER) && currentCharacter && !currentIsStationary && !nextIsStationary)
	{
		Character_callVirtual(nextCharacter, PROFILE_CHARACTER_MATCH, currentCharacter);
	}

	if (currentCharacter && !currentIsStationary)
	{
		Character_callVirtual(currentCharacter, PROFILE_CHARACTER_REMOVE, 0);
	}

	Character_callVirtual(nextCharacter, PROFILE_CHARACTER_CONTROL, 1);

	if (Game_isKind(nextCharacter, PROFILE_BUD_CLASS))
	{
		Character_callVirtual(nextCharacter, PROFILE_BUD_MOVEMENT_RESET, 0);
	}

	Game_dirtyCamera(NATIVE_CAMERA);
}

const char Character_text[2][64] __attribute__((section(".characterText"), used, aligned(4))) =
{
	"Set Current Character...",
	"(No playable characters)",
};
