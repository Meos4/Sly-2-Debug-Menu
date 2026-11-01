#include "MenuData.h"

#include "Destinations.h"
#include "MenuActions.h"
#include "Payload.h"
#include "Profile.h"

#define SECTION(name) __attribute__((section(name), used, aligned(4)))

const char MenuData_title[64] SECTION(".menu.Root") = PROFILE_BUILD_TITLE;

const char MenuData_destinations[8][64] SECTION(".menu.Destinations") =
{
	"Checkpoints...",
	"Reset at Entrance...",
	"(No Checkpoints)",
	"(No /CLS:ENTRANCE objects)",
	" (current)",
	"(Names unavailable; restart game)",
	"Load World...",
	"(No Worlds)",
};

MenuData_Entry MenuData_rootEntries[7] SECTION(".menu.RootEntries") =
{
	{ "Reset...", MenuActions_submenu, 4, (u32)MenuData_resetEntries, MENU_KEEP_OPEN },
	{ "Load...", MenuActions_loadList, 0, 0, MENU_KEEP_OPEN },
	{ "Camera...", MenuActions_submenu, 6, (u32)MenuData_cameraEntries, MENU_KEEP_OPEN },
	{ "Warps...", MenuActions_warps, 0, 0, MENU_KEEP_OPEN },
	{ "Character...", MenuActions_submenu, 4, (u32)MenuData_characterEntries, MENU_KEEP_OPEN },
	{ "Speed...", MenuActions_submenu, 8, (u32)MenuData_speedEntries, MENU_KEEP_OPEN },
	{ "Jobs/Tasks...", MenuActions_jobs, 0, 0, MENU_KEEP_OPEN },
};

MenuData_Entry MenuData_speedEntries[8] SECTION(".menu.SpeedEntries") =
{
	{ "0x", MenuActions_speed, 0, 0, 0 },
	{ "1/10x", MenuActions_speed, 10, 0, 0 },
	{ "1/5x", MenuActions_speed, 20, 0, 0 },
	{ "1/2x", MenuActions_speed, 50, 0, 0 },
	{ "1x", MenuActions_speed, 100, 0, 0 },
	{ "1.5x", MenuActions_speed, 150, 0, 0 },
	{ "2x", MenuActions_speed, 200, 0, 0 },
	{ "5x", MenuActions_speed, 500, 0, 0 },
};

MenuData_Entry MenuData_characterEntries[4] SECTION(".menu.CharacterEntries") =
{
	{ "Set 1 HP", MenuActions_hp, 1, 0, 0 },
	{ "Set Max HP", MenuActions_hp, 0x7FFFFFFF, 0, 0 },
	{ "Set Current Character", MenuActions_characters, 0, 0, MENU_KEEP_OPEN },
	{ "Set Current Character with Match", MenuActions_characters, 1, 0, MENU_KEEP_OPEN },
};

MenuData_Entry MenuData_resetEntries[4] SECTION(".menu.ResetEntries") =
{
	{ "Reset", MenuActions_reset, 0, 0, 0 },
	{ "Reset with Cleared Game State", MenuActions_reset, 1, 0, 0 },
	{ "Reset to Checkpoint...", MenuActions_destinations, DEST_CHECKPOINTS, 0, MENU_KEEP_OPEN },
	{ "Reset at Entrance...", MenuActions_destinations, DEST_ENTRANCES, 0, MENU_KEEP_OPEN },
};

MenuData_Entry MenuData_cameraEntries[6] SECTION(".menu.CameraEntries") =
{
	{ "Default", MenuActions_camera, ~0u, 0, 0 },
	{ "Truck (Stick=Pan)", MenuActions_camera, 0, 0, 0 },
	{ "Pan (Stick=Truck)", MenuActions_camera, 1, 0, 0 },
	{ "Orbit (LR=Switch)", MenuActions_camera, 2, 0, 0 },
	{ "Lock MRD", MenuActions_mrd, 0, 0, 0 },
	{ "Unlock MRD", MenuActions_mrd, ~0u, 0, 0 },
};

const u32 MenuData_renderConstants[5] SECTION(".menu.RenderConstants") =
{
	0x41200000u,
	0x41200000u,
	0x40A00000u,
	0x0000000Cu,
	0x41000000u,
};

const u32 MenuData_palette[5] SECTION(".menu.Palette") =
{
	0x80000000u,
	0xFFC0C0C0u,
	0xFF308030u,
	0xFF80FF80u,
	0xFF60C060u,
};

const u32 MenuData_zeroVector[4] SECTION(".menu.ZeroVector") =
{
	0x00000000u,
	0x00000000u,
	0x00000000u,
	0x00000000u,
};

const u16 MenuData_pressureMasks[12] SECTION(".menu.PressureMasks") =
{
	0x2000u, 0x8000u, 0x1000u, 0x4000u, 0x0010u, 0x0020u, 0x0040u, 0x0080u, 0x0004u, 0x0008u, 0x0001u, 0x0002u,
};

extern void Game_cameraBaseBegin(void);
extern void Game_cameraBaseEnd(void);
extern void PrototypeCamera_start(void);
extern void Camera_noop(void);
extern void CameraBegin_start(void);

const u32 MenuData_cameraVtable[16] SECTION(".menu.CameraVtable") =
{
	0,
	0,
	0,
	(u32)CameraBegin_start,
	0,
	(u32)Game_cameraBaseBegin,
	0,
	(u32)Game_cameraBaseEnd,
	0,
	(u32)Camera_noop,
	0,
	(u32)Camera_noop,
	0,
	(u32)PrototypeCamera_start,
	0,
	(u32)Camera_noop,
};

const Payload_Initializer MenuData_initializers[] SECTION(".initializers") =
{
	{ NAME_CACHE, 256, 64, 0 },
	{ NAME_OVERFLOW, 4, 4, 0 },
	{ CAMERA_OBJECT, 3, 4, 0 },
	{ CAMERA_OBJECT + 12, 1, 4, (u32)MenuData_cameraVtable },
	{ CAMERA_OBJECT + 16, 1, 4, 0xFFFFFFFFu },
	{ CAMERA_OBJECT + 20, 3, 4, 0 },
	{ MRD_POSITION, 4, 4, 0 },
	{ MRD_MASK, 1, 4, 0 },
	{ MRD_MODE, 1, 4, 0xFFFFFFFFu },
	{ ORBIT_ACTIVITY, 2, 4, 0 },
	{ ORBIT_PENDING, 1, 4, 0 },
	{ ORBIT_PREVIOUS, 1, 4, 0 },
	{ CAPTURE, 3, 4, 0 },
	{ DEST_COUNT, 3, 4, 0 },
	{ WARPS_STALE, 1, 4, 0 },
	{ JOBS_STALE, 1, 4, 0 },
	{ PAUSE_OWNED, 3, 4, 0 },
	{ MENU_STACK, sizeof(Menu_Stack) / 4, 4, 0 },
	{ TASK_TABLE, TASK_TABLE_ROWS * sizeof(MenuData_Entry) / 4, 4, 0 },
	{ MARKER, 1, 4, 0 },
	{ CONTROL, 4, 4, 0 },
};
