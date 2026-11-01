#ifndef SLY_MENU_H
#define SLY_MENU_H

#include "Common/Buttons.h"
#include "Common/Types.h"
#include "MenuData.h"

#define WORD(address) (*(volatile u32*)(u32)(address))

/* EE needs 16-byte stack frames O32 only gives 8 */
#define PAD_FRAME(words) u32 framePadding[words]; __asm__ volatile ("" : "=m"(framePadding))

enum
{
	SELECT = PAD_SELECT,
	R1 = PAD_R1,
	TRIANGLE = PAD_TRIANGLE,
	CROSS = PAD_CROSS
};

/* Inlined, each caller lives in its own reserved code range */
static inline __attribute__((always_inline)) void Menu_clearEntry(u32 entry)
{
	u32 offset;

	for (offset = 0; offset < sizeof(MenuData_Entry); offset += 4)
	{
		WORD(entry + offset) = 0;
	}
}

Menu_State* Menu_current(void);
void Menu_push(const char* title, u32 count, const MenuData_Entry* entries);
void Menu_replace(const char* title, u32 count, const MenuData_Entry* entries);
void Menu_pop(u32 callCancelAction);
void Menu_close(u32 callCancelAction);
void Menu_frame(void);

#endif
