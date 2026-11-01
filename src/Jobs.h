#ifndef SLY_JOBS_H
#define SLY_JOBS_H

#include "MenuData.h"

enum
{
	JOBS_TASK = 1,
	JOBS_GROUP
};

void Jobs_build(u32 group, u32 showGroupTasks);
void Jobs_select(MenuData_Entry* item);
void Jobs_execute(MenuData_Entry* item);
void Jobs_colors(MenuData_Entry* item, u32* bright, u32* dim, u32* normal);
void Jobs_detachRows(void);
void Jobs_attachRows(void);

extern const char Jobs_text[9][32];

#endif
