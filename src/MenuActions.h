#ifndef SLY_MENU_ACTIONS_H
#define SLY_MENU_ACTIONS_H

#include "MenuData.h"

void MenuActions_submenu(MenuData_Entry* item);
void MenuActions_loadList(MenuData_Entry* item);
void MenuActions_destinations(MenuData_Entry* item);
void MenuActions_warps(MenuData_Entry* item);
void MenuActions_characters(MenuData_Entry* item);
void MenuActions_jobs(MenuData_Entry* item);
void MenuActions_group(MenuData_Entry* item);
void MenuActions_task(MenuData_Entry* item);
void MenuActions_checkpoint(MenuData_Entry* item);
void MenuActions_load(MenuData_Entry* item);
void MenuActions_entrance(MenuData_Entry* item);
void MenuActions_reset(MenuData_Entry* item);
void MenuActions_hp(MenuData_Entry* item);
void MenuActions_camera(MenuData_Entry* item);
void MenuActions_mrd(MenuData_Entry* item);
void MenuActions_speed(MenuData_Entry* item);

#endif
