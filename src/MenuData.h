#ifndef SLY_MENU_DATA_H
#define SLY_MENU_DATA_H

#include "Common/Types.h"

#include <stddef.h>

typedef struct MenuData_Entry MenuData_Entry;
typedef void (*Menu_Action)(MenuData_Entry* item);

enum
{
	MENU_RETURN = 1,
	MENU_KEEP_OPEN = 2,
	MENU_CANCEL_ACTION = 4
};

struct MenuData_Entry
{
	char label[48];
	Menu_Action action;
	u32 argument;
	u32 data;
	u32 flags;
};

typedef struct
{
	char title[48];
	s32 count;
	MenuData_Entry* entries;
	s32 firstVisible;
	s32 selected;
} Menu_State;

typedef struct
{
	u32 nativeHeader[8];
	s32 depth;
	Menu_State states[3];
} Menu_Stack;

_Static_assert(sizeof(MenuData_Entry) == 64, "MenuData_Entry size");
_Static_assert(offsetof(MenuData_Entry, action) == 0x30, "MenuData_Entry.action offset");
_Static_assert(offsetof(MenuData_Entry, argument) == 0x34, "MenuData_Entry.argument offset");
_Static_assert(offsetof(MenuData_Entry, data) == 0x38, "MenuData_Entry.data offset");
_Static_assert(offsetof(MenuData_Entry, flags) == 0x3C, "MenuData_Entry.flags offset");
_Static_assert(sizeof(Menu_State) == 64, "Menu_State size");
_Static_assert(offsetof(Menu_Stack, depth) == 0x20, "Menu_Stack.depth offset");
_Static_assert(offsetof(Menu_Stack, states) == 0x24, "Menu_Stack.states offset");
_Static_assert(sizeof(Menu_Stack) <= 0x200, "Menu stack overlaps render constants");

extern const char MenuData_title[64];
extern const char MenuData_destinations[8][64];
extern MenuData_Entry MenuData_rootEntries[7];
extern MenuData_Entry MenuData_speedEntries[8];
extern MenuData_Entry MenuData_characterEntries[4];
extern MenuData_Entry MenuData_resetEntries[4];
extern MenuData_Entry MenuData_cameraEntries[6];

#endif
