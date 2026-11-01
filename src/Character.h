#ifndef SLY_CHARACTER_H
#define SLY_CHARACTER_H

#include "MenuData.h"

void Character_load(u32 object, u32 stream);
void Character_build(u32 matchCurrentCharacter);
u32 Character_callVirtual(u32 object, u32 slot, u32 argument);
void Character_activate(MenuData_Entry* item);

extern const char Character_text[2][64];

#endif
