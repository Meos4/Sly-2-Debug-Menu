#include "Jobs.h"

#include "Destinations.h"
#include "Entry.h"
#include "Game.h"
#include "Menu.h"
#include "MenuActions.h"
#include "NameCache.h"
#include "Profile.h"

#define COLLECT_CODE __attribute__((section(".jobsCollect"), noinline))
#define LIST_CODE __attribute__((section(".jobsList")))
#define ENTRY_CODE __attribute__((section(".jobsEntry")))
#define FLAG_CODE __attribute__((section(".jobsFlags")))
#define SORT_CODE __attribute__((section(".jobsSort")))
#define SELECT_CODE __attribute__((section(".jobsSelect")))
#define ACTION_CODE __attribute__((section(".jobsAction")))
#define COLOR_CODE __attribute__((section(".jobsColors")))
#define STALE_CODE __attribute__((section(".jobsStale")))
#define CAPACITY 256u
#define FOCUS_ROW 1u
#define OID_SHIFT 8
#define ROW_FLAGS 0xFFu

extern const u32 Jobs_palette[6][3];

enum
{
	JOBS_READ_VISIBILITY = -1,
	JOBS_HIDDEN = 1,
	JOBS_VISIBLE = 2
};

enum
{
	JOBS_TEXT_TITLE,
	JOBS_TEXT_EMPTY,
	JOBS_TEXT_AVAILABLE,
	JOBS_TEXT_CLEAR_FOCUS,
	JOBS_TEXT_FORCE_FOCUS,
	JOBS_TEXT_COMPLETE,
	JOBS_TEXT_FINAL,
	JOBS_TEXT_UNAVAILABLE,
	JOBS_TEXT_CHECKPOINT
};

enum
{
	JOBS_FORCE_UNAVAILABLE,
	JOBS_FORCE_AVAILABLE,
	JOBS_FORCE_COMPLETE,
	JOBS_FORCE_FINAL,
	JOBS_FORCE_FOCUS,
	JOBS_CLEAR_FOCUS
};

typedef struct
{
	u32 textIndex;
	u32 argument;
	Menu_Action action;
} Jobs_TaskAction;

static const Jobs_TaskAction Jobs_taskActions[TASK_TABLE_ROWS] __attribute__((section(".jobsTaskActions"), used, aligned(4))) =
{
	{ JOBS_TEXT_AVAILABLE, JOBS_FORCE_AVAILABLE, Jobs_execute },
	{ JOBS_TEXT_FORCE_FOCUS, JOBS_FORCE_FOCUS, Jobs_execute },
	{ JOBS_TEXT_COMPLETE, JOBS_FORCE_COMPLETE, Jobs_execute },
	{ JOBS_TEXT_FINAL, JOBS_FORCE_FINAL, Jobs_execute },
	{ JOBS_TEXT_UNAVAILABLE, JOBS_FORCE_UNAVAILABLE, Jobs_execute },
	{ JOBS_TEXT_CHECKPOINT, 0, MenuActions_checkpoint }
};

static FLAG_CODE u32 Jobs_taskVisibility(u32 object, s32 change)
{
	const char* const name = object ? Destinations_name(object) : 0;
	const u32 visibilityAddress = (u32)name + CACHE_VISIBILITY_OFFSET - CACHE_NAME_OFFSET;

	PAD_FRAME(4);

	if (!name)
	{
		return 0;
	}

	if (change >= 0)
	{
		WORD(visibilityAddress) = change ? JOBS_VISIBLE : JOBS_HIDDEN;
	}

	if (!WORD(visibilityAddress))
	{
		return WORD(object + PROFILE_TASK_GROUP) == 0;
	}

	return WORD(visibilityAddress) == JOBS_VISIBLE;
}

static inline __attribute__((always_inline)) u32 Jobs_isTaskVisible(u32 object)
{
	return Jobs_taskVisibility(object, JOBS_READ_VISIBILITY);
}

static inline __attribute__((always_inline)) void Jobs_setTaskVisible(u32 object, u32 visible)
{
	Jobs_taskVisibility(object, visible != 0);
}

static COLLECT_CODE u32* Jobs_collect(u32* orderedCount)
{
	u32 allocationRequest[2];
	u32* allTasks;
	u32* orderedTasks;
	u32 index;
	u32 enumeratedCount;
	u32 arrayBytes;
	u32 cursor;
	u32 limit;
	const u32 capacity = WORD(WORLD + PROFILE_WORLD_TASK_COUNT);

	PAD_FRAME(4);

	*orderedCount = 0;

	if (!capacity || capacity > 0x3FFFFFFCu)
	{
		return 0;
	}

	enumeratedCount = Entry_enumObjects(WORLD, 5, PROFILE_TASK_CLASS, 0, 0, 0);

	if (enumeratedCount > capacity)
	{
		return 0;
	}

	arrayBytes = (capacity * 4 + 15) & ~15u;
	cursor = WORD(PROFILE_NAME_ARENA_CURSOR);
	limit = WORD(PROFILE_NAME_ARENA_LIMIT) & ~15u;

	/* Reserve room for both task arrays */
	if (!cursor || limit < cursor || arrayBytes > (limit - cursor) / 2)
	{
		return 0;
	}

	allocationRequest[0] = arrayBytes;
	allocationRequest[1] = 16;
	orderedTasks = (u32*)Game_allocate(allocationRequest);
	allTasks = (u32*)Game_allocate(allocationRequest);

	if (!orderedTasks || !allTasks)
	{
		return 0;
	}

	enumeratedCount = Entry_enumObjects(WORLD, 0x105, PROFILE_TASK_CLASS, 0, capacity, allTasks);

	if (enumeratedCount > capacity)
	{
		return 0;
	}

	for (index = 0; index < enumeratedCount; ++index)
	{
		WORD(allTasks[index] + PROFILE_TASK_VISITS) = 0;
	}

	for (index = 0; index < enumeratedCount; ++index)
	{
		if (!WORD(allTasks[index] + PROFILE_TASK_PARENT_COUNT))
		{
			Entry_taskWalk(allTasks[index], orderedCount, orderedTasks, 0, 0);
		}
	}

	return orderedTasks;
}

static SORT_CODE s32 Jobs_compare(const void* left, const void* right)
{
	const u32 leftTask = *(const u32*)left;
	const u32 rightTask = *(const u32*)right;
	const u32 leftGroup = WORD(leftTask + PROFILE_TASK_GROUP);
	const u32 rightGroup = WORD(rightTask + PROFILE_TASK_GROUP);
	const s32 leftGroupId = leftGroup ? (s32)WORD(leftGroup + PROFILE_OBJECT_OID) : -1;
	const s32 rightGroupId = rightGroup ? (s32)WORD(rightGroup + PROFILE_OBJECT_OID) : -1;
	s32 difference = WORD(leftTask + PROFILE_TASK_GROUP_DEPTH) - WORD(rightTask + PROFILE_TASK_GROUP_DEPTH);

	if (!difference)
	{
		difference = leftGroupId - rightGroupId;
	}

	if (!difference)
	{
		difference = WORD(leftTask + PROFILE_TASK_DEPTH) - WORD(rightTask + PROFILE_TASK_DEPTH);
	}

	if (!difference)
	{
		difference = WORD(leftTask + PROFILE_OBJECT_OID) - WORD(rightTask + PROFILE_OBJECT_OID);
	}

	return difference;
}

static ENTRY_CODE void Jobs_append(u32 object, u32 kind, u32 argument, u32 grouped)
{
	u32 cursor = 0;
	const u32 entryAddress = DEST_TABLE + WORD(DEST_COUNT) * sizeof(MenuData_Entry);
	volatile MenuData_Entry* const item = (volatile MenuData_Entry*)entryAddress;
	char* const entryLabel = (char*)item->label;
	const char* const name = object ? Destinations_name(object) : 0;
	const char* label = name ? name : (const char*)DEST_MISSING_NAMES;

	PAD_FRAME(2);

	if (WORD(DEST_COUNT) == CAPACITY)
	{
		return;
	}

	Menu_clearEntry(entryAddress);

	if (grouped && name)
	{
		entryLabel[cursor++] = ' ';
		entryLabel[cursor++] = ' ';

		if (object == WORD(PROFILE_CURRENT_CHECKPOINT))
		{
			entryLabel[cursor++] = '<';
		}
	}

	while (*label && cursor < 47)
	{
		entryLabel[cursor++] = *label++;
	}

	if (grouped && name && cursor < 47 && object == WORD(PROFILE_CURRENT_CHECKPOINT))
	{
		entryLabel[cursor] = '>';
	}

	item->argument = argument;

	if (name)
	{
		item->action = kind == JOBS_GROUP ? MenuActions_group : MenuActions_task;
		item->data = object;
		item->flags = MENU_KEEP_OPEN;
	}

	++WORD(DEST_COUNT);
}

LIST_CODE void Jobs_build(u32 group, u32 showGroupTasks)
{
	u32 scope;
	u32 count;
	u32* tasks;
	u32 index;
	u32 currentGroup = 0;
	u32 task;
	u32 nextGroup;
	u32 remaining = WORD(WORLD + PROFILE_WORLD_TASK_COUNT);

	PAD_FRAME(4);

	WORD(DEST_COUNT) = 0;
	WORD(DEST_FIRST) = 0;
	WORD(JOBS_TITLE) = (u32)Jobs_text[JOBS_TEXT_TITLE];

	for (task = group ? WORD(group + PROFILE_GROUP_TASK_HEAD) : 0; task && remaining; task = WORD(task + PROFILE_TASK_NEXT))
	{
		Jobs_setTaskVisible(task, showGroupTasks);
		--remaining;
	}

	Game_scopeBegin(&scope);
	tasks = Jobs_collect(&count);

	if (count)
	{
		Game_sort(tasks, count, 4, Jobs_compare);
	}

	for (index = 0; index < count; ++index)
	{
		task = tasks[index];
		nextGroup = WORD(task + PROFILE_TASK_GROUP);

		if (currentGroup != nextGroup)
		{
			currentGroup = nextGroup;

			if (currentGroup)
			{
				const u32 firstTask = WORD(currentGroup + PROFILE_GROUP_FIRST_TASK);
				const u32 expandGroup = !Jobs_isTaskVisible(firstTask);

				Jobs_append(currentGroup, JOBS_GROUP, expandGroup, 0);
			}
		}

		if (Jobs_isTaskVisible(task))
		{
			Jobs_append(task, JOBS_TASK, 0, currentGroup != 0);
		}
	}

	if (!WORD(DEST_COUNT))
	{
		Menu_clearEntry(DEST_TABLE);

		for (index = 0; Jobs_text[JOBS_TEXT_EMPTY][index]; ++index)
		{
			((char*)DEST_TABLE)[index] = Jobs_text[JOBS_TEXT_EMPTY][index];
		}

		WORD(DEST_COUNT) = 1;
	}

	Game_scopeEnd(&scope, 2);
}

SELECT_CODE void Jobs_select(MenuData_Entry* item)
{
	volatile MenuData_Entry* taskEntry;
	u32 index;
	u32 rowAddress;
	u32 offset;
	u32 textIndex;
	u32 argument;
	u32 object;
	char* rowLabel;

	PAD_FRAME(2);

	object = item->data;
	WORD(JOBS_TITLE) = (u32)Destinations_name(object);
	WORD(DEST_FIRST) = 0;
	WORD(DEST_COUNT) = WORD(object + PROFILE_TASK_CHECKPOINT) == ~0u ? 5 : 6;

	for (index = 0; index < WORD(DEST_COUNT); ++index)
	{
		rowAddress = TASK_TABLE + index * sizeof(MenuData_Entry);
		taskEntry = (volatile MenuData_Entry*)rowAddress;
		rowLabel = (char*)taskEntry->label;

		Menu_clearEntry(rowAddress);

		textIndex = Jobs_taskActions[index].textIndex;
		argument = Jobs_taskActions[index].argument;

		if (index == FOCUS_ROW && object == WORD(PROFILE_FOCUSED_TASK))
		{
			textIndex = JOBS_TEXT_CLEAR_FOCUS;
			argument = JOBS_CLEAR_FOCUS;
		}

		for (offset = 0; Jobs_text[textIndex][offset]; ++offset)
		{
			rowLabel[offset] = Jobs_text[textIndex][offset];
		}

		taskEntry->action = Jobs_taskActions[index].action;
		taskEntry->argument = argument;
		taskEntry->data = object;
	}
}

ACTION_CODE void Jobs_execute(MenuData_Entry* item)
{
	u32 savedContext;
	u32 savedEvent;
	const u32 object = item->data;

	PAD_FRAME(4);

	savedContext = WORD(object + PROFILE_TASK_CONTEXT);
	savedEvent = WORD(object + PROFILE_TASK_EVENT);
	WORD(object + PROFILE_TASK_CONTEXT) = 4;
	WORD(object + PROFILE_TASK_EVENT) = 0;
	Game_setTaskState(object, item->argument, 0);
	Game_refreshJobs();
	WORD(object + PROFILE_TASK_CONTEXT) = savedContext;
	WORD(object + PROFILE_TASK_EVENT) = savedEvent;
}

COLOR_CODE void Jobs_colors(MenuData_Entry* item, u32* bright, u32* dim, u32* normal)
{
	u32 state;
	u32 focused;
	const u32 object = item->data;
	const Menu_Action action = item->action;

	PAD_FRAME(2);

	if (!object)
	{
		return;
	}

	if (action == MenuActions_task || (action == MenuActions_checkpoint && item->argument))
	{
		state = WORD(object + PROFILE_TASK_STATE);
		focused = object == WORD(PROFILE_FOCUSED_TASK);
	}
	else if (action == MenuActions_group)
	{
		state = Game_jobState(object);
		focused = object == WORD(PROFILE_FOCUSED_JOB);
	}
	else if (action == Jobs_execute)
	{
		state = item->argument;
		focused = 0;
	}
	else
	{
		return;
	}

	if (state < 6)
	{
		*bright = Jobs_palette[state][0];
		*dim = Jobs_palette[state][1];
		*normal = Jobs_palette[state][focused ? 1 : 2];
	}
}

static STALE_CODE void Jobs_visitRows(void (*visit)(MenuData_Entry* item))
{
	s32 depth;
	s32 index;
	MenuData_Entry* item;
	Menu_Action action;
	const Menu_Stack* const stack = (const Menu_Stack*)MENU_STACK;

	PAD_FRAME(4);

	for (depth = 0; depth < stack->depth; ++depth)
	{
		for (index = 0; index < stack->states[depth].count; ++index)
		{
			item = &stack->states[depth].entries[index];
			action = item->action;

			if (action == MenuActions_group || action == MenuActions_task || action == MenuActions_checkpoint || action == Jobs_execute)
			{
				visit(item);
			}
		}
	}
}

static STALE_CODE void Jobs_detachRow(MenuData_Entry* item)
{
	if (item->data)
	{
		item->flags |= WORD(item->data + PROFILE_OBJECT_OID) << OID_SHIFT;
		item->data = 0;
	}
}

static STALE_CODE void Jobs_attachRow(MenuData_Entry* item)
{
	PAD_FRAME(2);

	if (!item->data)
	{
		item->data = NameCache_find(item->flags >> OID_SHIFT);
		item->flags &= ROW_FLAGS;

		if (!item->data)
		{
			item->action = 0;
			item->flags |= MENU_KEEP_OPEN;
		}
	}
}

STALE_CODE void Jobs_detachRows(void)
{
	PAD_FRAME(2);

	Jobs_visitRows(Jobs_detachRow);
	WORD(JOBS_STALE) = 1;
}

STALE_CODE void Jobs_attachRows(void)
{
	PAD_FRAME(2);

	if (WORD(JOBS_STALE))
	{
		WORD(JOBS_STALE) = 0;
		Jobs_visitRows(Jobs_attachRow);
	}
}

const char Jobs_text[9][32] __attribute__((section(".jobsText"), used, aligned(4))) =
{
	[JOBS_TEXT_TITLE] = "Jobs/Tasks...",
	[JOBS_TEXT_EMPTY] = "(No Jobs/Tasks)",
	[JOBS_TEXT_AVAILABLE] = "Force Available",
	[JOBS_TEXT_CLEAR_FOCUS] = "Clear Focus",
	[JOBS_TEXT_FORCE_FOCUS] = "Force Focus",
	[JOBS_TEXT_COMPLETE] = "Force Complete",
	[JOBS_TEXT_FINAL] = "Force Final",
	[JOBS_TEXT_UNAVAILABLE] = "Force Unavailable",
	[JOBS_TEXT_CHECKPOINT] = "Reset To Checkpoint",
};

const u32 Jobs_palette[6][3] __attribute__((section(".jobsPalette"), used, aligned(4))) =
{
	{ 0xFF8080FFu, 0xFF6060C0u, 0xFF303080u },
	{ 0xFF80FF80u, 0xFF60C060u, 0xFF308030u },
	{ 0xFFFF8080u, 0xFFC06060u, 0xFF803030u },
	{ 0xFF808080u, 0xFF606060u, 0xFF303030u },
	{ 0xFFFFFF80u, 0xFFC0C060u, 0xFF808030u },
	{ 0xFF80FFFFu, 0xFF60C0C0u, 0xFF308080u },
};
