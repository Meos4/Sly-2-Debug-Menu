#include "MenuActions.h"

#include "Camera.h"
#include "Character.h"
#include "Destinations.h"
#include "Entry.h"
#include "Game.h"
#include "Jobs.h"
#include "Menu.h"
#include "Profile.h"
#include "Warps.h"

#define STACK_ACTION __attribute__((section(".menuActions"), noinline))
#define UNUSED __attribute__((unused))

static void MenuActions_openList(const char* title, Menu_Action action)
{
	u32 index;
	MenuData_Entry* const rows = (MenuData_Entry*)DEST_TABLE;

	PAD_FRAME(2);

	for (index = 0; index < WORD(DEST_COUNT); ++index)
	{
		rows[index].action = rows[index].data ? action : 0;

		if (action == MenuActions_checkpoint)
		{
			rows[index].argument = rows[index].data != 0;
		}
	}

	Menu_push(title, WORD(DEST_COUNT), rows);
}

STACK_ACTION void MenuActions_submenu(MenuData_Entry* item)
{
	PAD_FRAME(2);

	Menu_push(item->label, item->argument, (const MenuData_Entry*)item->data);
}

void MenuActions_loadList(UNUSED MenuData_Entry* item)
{
	PAD_FRAME(2);

	Game_listWorlds();
	MenuActions_openList(MenuData_destinations[6], MenuActions_load);
}

void MenuActions_destinations(MenuData_Entry* item)
{
	const u32 mode = item->argument;

	PAD_FRAME(2);

	Game_listDestinations(mode);

	const char* const title = MenuData_destinations[mode - DEST_CHECKPOINTS];
	const Menu_Action action = mode == DEST_CHECKPOINTS ? MenuActions_checkpoint : MenuActions_entrance;

	MenuActions_openList(title, action);
}

void MenuActions_warps(UNUSED MenuData_Entry* item)
{
	PAD_FRAME(2);

	Warps_build();
	MenuActions_openList(Warps_text[0], Warps_activate);
}

void MenuActions_characters(MenuData_Entry* item)
{
	PAD_FRAME(2);

	Character_build(item->argument);
	MenuActions_openList(Character_text[0], Character_activate);
}

STACK_ACTION void MenuActions_jobs(UNUSED MenuData_Entry* item)
{
	PAD_FRAME(2);

	Jobs_build(0, 0);
	Menu_push(Jobs_text[0], WORD(DEST_COUNT), (const MenuData_Entry*)DEST_TABLE);
}

STACK_ACTION void MenuActions_group(MenuData_Entry* item)
{
	PAD_FRAME(2);

	Jobs_build(item->data, item->argument);
	Menu_replace(0, WORD(DEST_COUNT), (const MenuData_Entry*)DEST_TABLE);

	item->flags |= MENU_KEEP_OPEN;
}

STACK_ACTION void MenuActions_task(MenuData_Entry* item)
{
	PAD_FRAME(2);

	Jobs_select(item);
	Menu_push((const char*)WORD(JOBS_TITLE), WORD(DEST_COUNT), (const MenuData_Entry*)TASK_TABLE);
}

void MenuActions_checkpoint(MenuData_Entry* item)
{
	const u32 object = item->data;

	PAD_FRAME(2);

	Game_setCheckpoint(WORLD, object);
	Game_applyCheckpoint(object);
}

void MenuActions_load(MenuData_Entry* item)
{
	Entry_load(WORLD, item->data, ENTRY_LOAD_MENU_ENTRANCE_OID, ENTRY_LOAD_NO_FILTER, 0, ENTRY_LOAD_DIRECT);
}

void MenuActions_entrance(MenuData_Entry* item)
{
	Entry_load(WORLD, 0, item->argument, ENTRY_LOAD_NO_FILTER, 0, ENTRY_LOAD_DIRECT);
}

void MenuActions_reset(MenuData_Entry* item)
{
	Game_reset(item->argument);
}

void MenuActions_hp(MenuData_Entry* item)
{
	const u32 object = WORD(ACTIVE_CHARACTER);

	if (object && Game_isKind(object, PROFILE_BUD_CLASS))
	{
		Game_hp(object, item->argument);
	}
}

void MenuActions_camera(MenuData_Entry* item)
{
	Game_camera(CAMERA_OBJECT, item->argument);
}

void MenuActions_mrd(MenuData_Entry* item)
{
	Camera_setMrd(item->argument);
}
