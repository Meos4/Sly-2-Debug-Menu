#include "Menu.h"

#include "Entry.h"
#include "Game.h"
#include "Jobs.h"
#include "Profile.h"

#define STACK ((Menu_Stack*)MENU_STACK)
#define CURRENT_STATE (&STACK->states[STACK->depth - 1])
#define PREVIOUS_BUTTONS WORD(CONTROL + 4)
#define MENU_OPEN WORD(CONTROL + 8)

Menu_State* Menu_current(void)
{
	return CURRENT_STATE;
}

void Menu_replace(const char* title, u32 count, const MenuData_Entry* entries)
{
	Menu_State* const state = CURRENT_STATE;
	u32 index;

	if (title)
	{
		for (index = 0; index < 48; ++index)
		{
			state->title[index] = *title;

			if (*title)
			{
				++title;
			}
		}
	}

	state->count = count;
	state->entries = (MenuData_Entry*)entries;
}

void Menu_push(const char* title, u32 count, const MenuData_Entry* entries)
{
	u32* const stateWords = (u32*)&STACK->states[STACK->depth++];
	u32 index;

	/* Clears only the new frame, parent selection and scroll survive */
	for (index = 0; index < sizeof(Menu_State) / 4; ++index)
	{
		stateWords[index] = 0;
	}

	Menu_replace(title, count, entries);
}

void Menu_pop(u32 callCancelAction)
{
	MenuData_Entry* entry = 0;
	Menu_State* const root = &STACK->states[0];
	s32 index;

	--STACK->depth;

	if (!STACK->depth && callCancelAction == 1)
	{
		/* Invokes the last root entry marked as a cancellation action */
		for (index = 0; index < root->count; ++index)
		{
			if (root->entries[index].flags & MENU_CANCEL_ACTION)
			{
				entry = &root->entries[index];
			}
		}

		if (entry && entry->action)
		{
			entry->action(entry);
		}
	}
}

void Menu_close(u32 callCancelAction)
{
	while (STACK->depth > 0)
	{
		Menu_pop(callCancelAction);
	}
}

static void Menu_update(u32 pressed)
{
	const u32 pad = (u32)&Game_realPad;
	Menu_State* const state = Menu_current();
	MenuData_Entry* entry;
	s32 direction;
	s32 next;

	Game_consumeButtons(pad, SELECT | TRIANGLE | CROSS);

	if (pressed & SELECT)
	{
		Menu_close(1);
		return;
	}

	if (pressed & TRIANGLE)
	{
		Menu_pop(1);
		return;
	}

	if (pressed & CROSS)
	{
		entry = &state->entries[state->selected];

		if (entry->action)
		{
			entry->action(entry);
		}

		if (!(entry->flags & MENU_KEEP_OPEN))
		{
			if (entry->flags & MENU_RETURN)
			{
				Menu_pop(0);
			}
			else
			{
				Menu_close(0);
			}
		}

		return;
	}

	direction = WORD(NAVIGATION);
	WORD(NAVIGATION) = 0;

	if (direction > 0)
	{
		next = state->selected + 1;
		state->selected = next < state->count ? next : 0;
	}
	else if (direction < 0)
	{
		next = state->selected - 1;
		state->selected = next < 0 ? state->count - 1 : next;
	}

	if (state->selected < state->firstVisible)
	{
		state->firstVisible = state->selected;
	}
	else if (state->selected >= state->firstVisible + 12)
	{
		state->firstVisible = state->selected - 11;
	}
}

static void Menu_pauseSync(void)
{
	const u32 open = STACK->depth != 0;

	PAD_FRAME(2);

	MENU_OPEN = open;

	if (open == WORD(PAUSE_OWNED))
	{
		return;
	}

	if (open)
	{
		Entry_clock(CLOCK, 2, 0);
		Game_pause(WORLD, 0);
	}
	else
	{
		Entry_clock(CLOCK, 2, 0x3F800000u);
		Game_resume(WORLD, 0);
	}

	WORD(PAUSE_OWNED) = open;
}

void Menu_frame(void)
{
	u32 held;
	u32 pressed;

	PAD_FRAME(2);

	if (WORD(MARKER) != MENU_INIT_MARKER)
	{
		PREVIOUS_BUTTONS = WORD(CAPTURE);
		STACK->depth = 0;
		MENU_OPEN = 0;
		WORD(PAUSE_OWNED) = 0;
		WORD(MARKER) = MENU_INIT_MARKER;
	}

	Jobs_attachRows();

	/* Pause the new world if the menu stayed open during loading */
	Menu_pauseSync();

	held = WORD(CAPTURE);
	pressed = held & ~PREVIOUS_BUTTONS;
	PREVIOUS_BUTTONS = held;

	if ((pressed & SELECT) && (held & R1))
	{
		Game_consumeButtons((u32)&Game_realPad, SELECT);

		if (STACK->depth)
		{
			Menu_close(1);
		}
		else
		{
			Menu_push(MenuData_title, 7, MenuData_rootEntries);
		}
	}
	else if (STACK->depth)
	{
		Menu_update(pressed);
	}

	Menu_pauseSync();
}
