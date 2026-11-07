#include "Layout.h"

__patchBase = SLY_PATCH_BASE;
__patchEnd = __patchBase + 0x10000;
OUTPUT_ARCH(mips)
ENTRY(Entry_entry)
PROVIDE(Profile_characters = (__patchBase + 0x2D00));
PROVIDE(Profile_charactersLimit = 0x160);
PROVIDE(Profile_jobsAction = (__patchBase + 0x7CC0));
SECTIONS {
    __controlStart = (__patchBase + 0x0000);
    .entry (__patchBase + 0x0000) : { KEEP(*(.entry)) }
    ASSERT(SIZEOF(.entry) <= 0x400, "EE entry exceeds its reserved range")
    .text (__patchBase + 0x0400) : { *(.text .text.*) *(.rodata .rodata.*) . = ALIGN(4); }
    ASSERT(ADDR(.text) + SIZEOF(.text) <= (__patchBase + 0x0C00), "C control overlaps cache bridges")
    __controlEnd = ADDR(.text) + SIZEOF(.text);
    .bridges (__patchBase + 0x1E00) : { KEEP(*(.bridges)) }
    ASSERT(SIZEOF(.bridges) <= 0x100, "ABI bridges overlap Binocucom cleanup")
    .warpsBinoc (__patchBase + 0x1F00) : { KEEP(*(.warpsBinoc)) }
    ASSERT(SIZEOF(.warpsBinoc) <= 0x100, "Binocucom cleanup overlaps the pad capture")
    .native.Destinations (__patchBase + 0x1000) : { KEEP(*(.native.Destinations)) }
    ASSERT(SIZEOF(.native.Destinations) == 0x8E8, "Destinations instruction layout changed")
    .warpsVoice (__patchBase + 0x1900) : { KEEP(*(.warpsVoice)) }
    ASSERT(SIZEOF(.warpsVoice) <= 0x100, "Voice cleanup overlaps the render adapter")
    .native.RenderAdapter (__patchBase + 0x1A00) : { KEEP(*(.native.RenderAdapter)) }
    ASSERT(SIZEOF(.native.RenderAdapter) <= 0x90, "RenderAdapter overlaps stack actions")
    .menuActions (__patchBase + 0x1A90) : { KEEP(*(.menuActions)) }
    ASSERT(ADDR(.menuActions) + SIZEOF(.menuActions) <= __patchBase + TASK_TABLE_OFFSET, "Stack actions overlap task entries")
    .native.MenuSpeed (__patchBase + 0x1D80) : { KEEP(*(.native.MenuSpeed)) }
    ASSERT(SIZEOF(.native.MenuSpeed) == 0x48, "March speed action layout changed")
    ASSERT(__patchBase + TASK_TABLE_OFFSET + TASK_TABLE_ROWS * 64 <= ADDR(.native.MenuSpeed), "Task entries overlap speed action")
    .native.PadCapture (__patchBase + 0x2000) : { KEEP(*(.native.PadCapture)) }
    ASSERT(SIZEOF(.native.PadCapture) == 0x100, "PadCapture overlaps job flags")
    .native.MenuStart (__patchBase + 0x2180) : { KEEP(*(.native.MenuStart)) }
    ASSERT(SIZEOF(.native.MenuStart) <= 0x80, "Start priority overlaps name helpers")
    .native.PrototypeRender (__patchBase + 0x2400) : { KEEP(*(.native.PrototypeRender)) }
    ASSERT(SIZEOF(.native.PrototypeRender) == 0x7C0, "PrototypeRender instruction layout changed")
    .native.MrdRegions (__patchBase + 0x5A00) : { KEEP(*(.native.MrdRegions)) }
    ASSERT(SIZEOF(.native.MrdRegions) == 0x50, "MrdRegions instruction layout changed")
    .native.MrdRegionsSecond (__patchBase + 0x5A80) : { KEEP(*(.native.MrdRegionsSecond)) }
    ASSERT(SIZEOF(.native.MrdRegionsSecond) == 0x50, "MrdRegionsSecond instruction layout changed")
    .native.MrdPlayer (__patchBase + 0x5B00) : { KEEP(*(.native.MrdPlayer)) }
    ASSERT(SIZEOF(.native.MrdPlayer) == 0x3C, "MrdPlayer instruction layout changed")
    .native.MrdDistance (__patchBase + 0x5C00) : { KEEP(*(.native.MrdDistance)) }
    ASSERT(SIZEOF(.native.MrdDistance) == 0x68, "MrdDistance instruction layout changed")
    .native.OrbitInput (__patchBase + 0x5D00) : { KEEP(*(.native.OrbitInput)) }
    ASSERT(SIZEOF(.native.OrbitInput) == 0x94, "OrbitInput instruction layout changed")
    .native.MrdReset (__patchBase + 0x5E00) : { KEEP(*(.native.MrdReset)) }
    ASSERT(SIZEOF(.native.MrdReset) == 0x44, "MrdReset instruction layout changed")
    .native.PrototypeCamera (__patchBase + 0x7000) : { KEEP(*(.native.PrototypeCamera)) }
    ASSERT(SIZEOF(.native.PrototypeCamera) == 0x7B0, "PrototypeCamera instruction layout changed")
    .native.CameraPressure (__patchBase + 0x7800) : { KEEP(*(.native.CameraPressure)) }
    ASSERT(SIZEOF(.native.CameraPressure) == 0x88, "CameraPressure instruction layout changed")
    .native.CameraQuery (__patchBase + 0x7890) : { KEEP(*(.native.CameraQuery)) }
    ASSERT(SIZEOF(.native.CameraQuery) == 0x68, "CameraQuery instruction layout changed")
    .native.CameraSetter (__patchBase + 0x7900) : { KEEP(*(.native.CameraSetter)) }
    ASSERT(SIZEOF(.native.CameraSetter) == 0xD8, "CameraSetter instruction layout changed")
    .native.CameraBegin (__patchBase + 0x7A00) : { KEEP(*(.native.CameraBegin)) }
    ASSERT(SIZEOF(.native.CameraBegin) == 0x10, "CameraBegin instruction layout changed")
    .native.CameraActive (__patchBase + 0x7A40) : { KEEP(*(.native.CameraActive)) }
    ASSERT(SIZEOF(.native.CameraActive) <= 0xC0, "CameraActive overlaps warp actions")
    .boot.MrdGeometryFirst (__patchBase + 0x4D40) : { KEEP(*(.boot.MrdGeometryFirst)) }
    ASSERT(SIZEOF(.boot.MrdGeometryFirst) == 0x5C, "MrdGeometryFirst instruction layout changed")
    .boot.MrdGeometrySecond (__patchBase + 0x4DC0) : { KEEP(*(.boot.MrdGeometrySecond)) }
    ASSERT(SIZEOF(.boot.MrdGeometrySecond) == 0x5C, "MrdGeometrySecond instruction layout changed")
    .boot.MrdGeometryThird (__patchBase + 0x4E40) : { KEEP(*(.boot.MrdGeometryThird)) }
    ASSERT(SIZEOF(.boot.MrdGeometryThird) == 0x5C, "MrdGeometryThird instruction layout changed")
    .menu.Root (__patchBase + 0x4000) : { KEEP(*(.menu.Root)) }
    .menu.Destinations (__patchBase + 0x5400) : { KEEP(*(.menu.Destinations)) }
    .menu.RootEntries (__patchBase + 0x6000) : { KEEP(*(.menu.RootEntries)) }
    .menu.SpeedEntries (__patchBase + 0x6200) : { KEEP(*(.menu.SpeedEntries)) }
    .menu.CharacterEntries (__patchBase + 0x6400) : { KEEP(*(.menu.CharacterEntries)) }
    .menu.ResetEntries (__patchBase + 0x6A00) : { KEEP(*(.menu.ResetEntries)) }
    .menu.CameraEntries (__patchBase + 0x6B00) : { KEEP(*(.menu.CameraEntries)) }
    .menu.RenderConstants (__patchBase + 0x6800) : { KEEP(*(.menu.RenderConstants)) }
    .menu.Palette (__patchBase + 0x6900) : { KEEP(*(.menu.Palette)) }
    .menu.ZeroVector (__patchBase + 0x6D20) : { KEEP(*(.menu.ZeroVector)) }
    .menu.PressureMasks (__patchBase + 0x6D30) : { KEEP(*(.menu.PressureMasks)) }
    .menu.CameraVtable (__patchBase + 0x6C80) : { KEEP(*(.menu.CameraVtable)) }
    .profile.Worlds (__patchBase + 0x3000) : { KEEP(*(.profile.Worlds)) }
    .characters Profile_characters : { KEEP(*(.characters)) }
    ASSERT(SIZEOF(.characters) <= Profile_charactersLimit, "Character lists exceed their reserved range")
    .characterAction (__patchBase + 0x4840) : { KEEP(*(.characterAction)) }
    ASSERT(SIZEOF(.characterAction) <= 0x3C0, "Character actions overlap character text")
    .characterText (__patchBase + 0x5700) : { KEEP(*(.characterText)) }
    ASSERT(SIZEOF(.characterText) <= 0x100, "Character title overlaps camera text")
    .warps (__patchBase + 0x3B00) : { KEEP(*(.warps)) }
    ASSERT(SIZEOF(.warps) <= 0x260, "Warps overlap job selection")
    .names (__patchBase + 0x2200) : { KEEP(*(.names)) }
    ASSERT(SIZEOF(.names) <= 0xD0, "Name prefixes overlap name lookup")
    .namesData (__patchBase + 0x56C0) : { KEEP(*(.namesData)) }
    ASSERT(SIZEOF(.namesData) <= 0x140, "Name prefixes overlap camera text")
    .warpsAction (__patchBase + 0x7B00) : { KEEP(*(.warpsAction)) }
    ASSERT(SIZEOF(.warpsAction) <= 0x1C0, "Warp actions overlap job actions")
    .warpsCapture (__patchBase + 0x4040) : { KEEP(*(.warpsCapture)) }
    ASSERT(SIZEOF(.warpsCapture) <= 0x1C0, "Warp capture overlaps job graph collection")
    .menu.Warps (__patchBase + 0x5600) : { KEEP(*(.menu.Warps)) }
    ASSERT(SIZEOF(.menu.Warps) <= 0x200, "Warp text overlaps camera text")
    .jobsFlags (__patchBase + 0x2100) : { KEEP(*(.jobsFlags)) }
    ASSERT(SIZEOF(.jobsFlags) <= 0x80, "Job flags overlap Start priority")
    .jobsCollect (__patchBase + 0x4200) : { KEEP(*(.jobsCollect)) }
    ASSERT(SIZEOF(.jobsCollect) <= 0x200, "Job graph collection overlaps Speed")
    .jobsStale (__patchBase + 0x4400) : { KEEP(*(.jobsStale)) }
    ASSERT(SIZEOF(.jobsStale) <= 0x240, "Stale job rows overlap job colors")
    .jobsSort (__patchBase + 0x2E60) : { KEEP(*(.jobsSort)) }
    ASSERT(SIZEOF(.jobsSort) <= 0x70, "Job sorting overlaps cache reset")
    .jobsEntry (__patchBase + 0x6E00) : { KEEP(*(.jobsEntry)) }
    ASSERT(SIZEOF(.jobsEntry) <= 0x200, "Job rows overlap camera code")
    .jobsList (__patchBase + 0x5140) : { KEEP(*(.jobsList)) }
    ASSERT(SIZEOF(.jobsList) <= 0x1E0, "Job list overlaps task actions")
    .jobsTaskActions (__patchBase + 0x5320) : { KEEP(*(.jobsTaskActions)) }
    ASSERT(SIZEOF(.jobsTaskActions) <= 0xE0, "Task actions overlap destination text")
    .jobsSelect (__patchBase + 0x3D60) : { KEEP(*(.jobsSelect)) }
    ASSERT(SIZEOF(.jobsSelect) <= 0x150, "Task actions overlap silent dialogue cleanup")
    .warpsSilent (__patchBase + 0x3EB0) : { KEEP(*(.warpsSilent)) }
    ASSERT(SIZEOF(.warpsSilent) <= 0x150, "Silent dialogue cleanup overlaps root text")
    .jobsAction Profile_jobsAction : { KEEP(*(.jobsAction)) }
    ASSERT(SIZEOF(.jobsAction) <= 0x100, "Job actions overlap the clone bridge")
    .jobsColors (__patchBase + 0x4640) : { KEEP(*(.jobsColors)) }
    ASSERT(SIZEOF(.jobsColors) <= 0x200, "Job colors overlap character actions")
    .jobsText (__patchBase + 0x4EA0) : { KEEP(*(.jobsText)) }
    ASSERT(SIZEOF(.jobsText) <= 0x160, "Job text overlaps Reset")
    .jobsPalette (__patchBase + 0x5780) : { KEEP(*(.jobsPalette)) }
    ASSERT(SIZEOF(.jobsPalette) <= 0x80, "Job palette overlaps camera text")
    .cacheBridges (__patchBase + 0x0C00) : { KEEP(*(.cacheBridges)) }
    ASSERT(SIZEOF(.cacheBridges) <= 0x400, "Cache bridges overlap destinations")
    .nameSlot (__patchBase + 0x5E60) : { KEEP(*(.nameSlot)) }
    ASSERT(SIZEOF(.nameSlot) <= 0x1A0, "Name slot helper overlaps root entries")
    .nameLookup (__patchBase + 0x22D0) : { KEEP(*(.nameLookup)) }
    ASSERT(SIZEOF(.nameLookup) <= 0x130, "Name lookup overlaps renderer")
    .nameReset (__patchBase + 0x2ED0) : { KEEP(*(.nameReset)) }
    ASSERT(SIZEOF(.nameReset) <= 0x50, "Name reset overlaps clone helper")
    .nameClone (__patchBase + 0x2F20) : { KEEP(*(.nameClone)) }
    ASSERT(SIZEOF(.nameClone) <= 0xE0, "Name clone overlaps world text")
    .cloneBridge (__patchBase + 0x7DC0) : { KEEP(*(.cloneBridge)) }
    ASSERT(SIZEOF(.cloneBridge) <= 0x140, "Name clone bridge overlaps pad state")
    .initializers 0 (INFO) : { KEEP(*(.initializers)) }
    .data : { *(.data .data.* .sdata .sdata.*) }
    .bss (NOLOAD) : { *(.bss .bss.* .sbss .sbss.* COMMON) }
    ASSERT(SIZEOF(.data) == 0 && SIZEOF(.bss) == 0, "Mutable C sections need explicit PNACH initialization")
    /DISCARD/ : { *(.comment .note* .pdr .reginfo .MIPS.abiflags .gnu.attributes .eh_frame*) }
}

Game_camera = CameraSetter_start;
Menu_draw = RenderAdapter_start;
Game_listDestinations = Destinations_build;
Game_listWorlds = Destinations_build_load;

SECTIONS { .native.RenderHelpers (__patchBase + 0x2C00) : { KEEP(*(.native.RenderHelpers)) } }
ASSERT(SIZEOF(.native.RenderHelpers) == 0x88, "Renderer helper layout changed")

Game_addController_signedHi = (Game_addController + 0x8000) >> 16;
Game_cameraOrientation_signedHi = (Game_cameraOrientation + 0x8000) >> 16;
Game_activeControllerSlot_rawHi = (Game_activeControllerSlot) >> 16;
Game_applyCameraMatrix_signedHi = (Game_applyCameraMatrix + 0x8000) >> 16;
Game_buildEuler_signedHi = (Game_buildEuler + 0x8000) >> 16;
Game_clock_signedHi = (Game_clock + 0x8000) >> 16;
Game_compareCheckpoints_rawHi = (Game_compareCheckpoints) >> 16;
Game_compareFloat_signedHi = (Game_compareFloat + 0x8000) >> 16;
Game_copyQuad_signedHi = (Game_copyQuad + 0x8000) >> 16;
Game_currentCheckpoint_rawHi = (Game_currentCheckpoint) >> 16;
Game_dirtyCamera_signedHi = (Game_dirtyCamera + 0x8000) >> 16;
Game_displayContext_rawHi = (Game_displayContext) >> 16;
Game_displayContext_signedHi = (Game_displayContext + 0x8000) >> 16;
Game_extractEuler_signedHi = (Game_extractEuler + 0x8000) >> 16;
Game_fontContext_rawHi = (Game_fontContext) >> 16;
Game_fontContext_signedHi = (Game_fontContext + 0x8000) >> 16;
Game_isOrbitCandidate_signedHi = (Game_isOrbitCandidate + 0x8000) >> 16;
Game_nativeCamera_rawHi = (Game_nativeCamera) >> 16;
Game_nativeCamera_signedHi = (Game_nativeCamera + 0x8000) >> 16;
Game_objectPosition_signedHi = (Game_objectPosition + 0x8000) >> 16;
Game_realPad_rawHi = (Game_realPad) >> 16;
Game_recenterCamera_signedHi = (Game_recenterCamera + 0x8000) >> 16;
Game_removeController_signedHi = (Game_removeController + 0x8000) >> 16;
Game_setFov_signedHi = (Game_setFov + 0x8000) >> 16;
Game_vectorAngles_signedHi = (Game_vectorAngles + 0x8000) >> 16;
Game_worldCount_rawHi = (Game_worldCount) >> 16;
Game_worldNodeHead_signedHi = (Game_worldNodeHead + 0x8000) >> 16;
Game_worldNodeTail_signedHi = (Game_worldNodeTail + 0x8000) >> 16;
Game_world_rawHi = (Game_world) >> 16;
Game_wrapAngle_signedHi = (Game_wrapAngle + 0x8000) >> 16;
Game_yawPitchMatrix_signedHi = (Game_yawPitchMatrix + 0x8000) >> 16;

Destinations_compare_names_rawHi = (Destinations_compare_names) >> 16;
Render_pushTextScale_signedHi = (Render_pushTextScale + 0x8000) >> 16;
Render_initText_signedHi = (Render_initText + 0x8000) >> 16;
Render_measureText_signedHi = (Render_measureText + 0x8000) >> 16;
Render_popTextScale_signedHi = (Render_popTextScale + 0x8000) >> 16;
Render_drawRectangle_signedHi = (Render_drawRectangle + 0x8000) >> 16;
Render_drawText_signedHi = (Render_drawText + 0x8000) >> 16;
Render_sin_signedHi = (Render_sin + 0x8000) >> 16;
Render_setPosition_signedHi = (Render_setPosition + 0x8000) >> 16;
Render_setSize_signedHi = (Render_setSize + 0x8000) >> 16;
Render_setColor_signedHi = (Render_setColor + 0x8000) >> 16;
Render_setField20_signedHi = (Render_setField20 + 0x8000) >> 16;
Render_setField24_signedHi = (Render_setField24 + 0x8000) >> 16;
Render_entryColors_signedHi = (Render_entryColors + 0x8000) >> 16;
Profile_worldCatalog = (__patchBase + 0x3000);
Profile_worldCatalog_rawHi = (Profile_worldCatalog) >> 16;
MenuData_noCheckpoints = (__patchBase + 0x5480);
MenuData_noCheckpoints_rawHi = (MenuData_noCheckpoints) >> 16;
MenuData_noEntrances = (__patchBase + 0x54C0);
MenuData_noEntrances_rawHi = (MenuData_noEntrances) >> 16;
MenuData_currentSuffix = (__patchBase + 0x5500);
MenuData_currentSuffix_rawHi = (MenuData_currentSuffix) >> 16;
MenuData_missingNames = (__patchBase + 0x5540);
MenuData_missingNames_rawHi = (MenuData_missingNames) >> 16;
MenuData_noWorlds = (__patchBase + 0x55C0);
MenuData_noWorlds_rawHi = (MenuData_noWorlds) >> 16;
OrbitInput_start_signedHi = (OrbitInput_start + 0x8000) >> 16;
Menu_stack = (__patchBase + 0x6600);
Menu_stack_rawHi = (Menu_stack) >> 16;
Render_marginX = (__patchBase + 0x6800);
Render_marginX_signedHi = (Render_marginX + 0x8000) >> 16;
Render_marginY = (__patchBase + 0x6804);
Render_marginY_signedHi = (Render_marginY + 0x8000) >> 16;
Render_padding = (__patchBase + 0x6808);
Render_padding_signedHi = (Render_padding + 0x8000) >> 16;
Render_visibleRows = (__patchBase + 0x680C);
Render_visibleRows_signedHi = (Render_visibleRows + 0x8000) >> 16;
Render_blinkRate = (__patchBase + 0x6810);
Render_blinkRate_signedHi = (Render_blinkRate + 0x8000) >> 16;
Render_backgroundColor = (__patchBase + 0x6900);
Render_backgroundColor_signedHi = (Render_backgroundColor + 0x8000) >> 16;
Render_titleColor = (__patchBase + 0x6904);
Render_titleColor_signedHi = (Render_titleColor + 0x8000) >> 16;
Render_normalColor = (__patchBase + 0x6908);
Render_normalColor_signedHi = (Render_normalColor + 0x8000) >> 16;
Render_selectedColor = (__patchBase + 0x690C);
Render_selectedColor_signedHi = (Render_selectedColor + 0x8000) >> 16;
Render_selectedDimColor = (__patchBase + 0x6910);
Render_selectedDimColor_signedHi = (Render_selectedDimColor + 0x8000) >> 16;
Camera_controller = (__patchBase + 0x6D00);
Camera_controller_rawHi = (Camera_controller) >> 16;
Camera_zeroVector = (__patchBase + 0x6D20);
Camera_zeroVector_signedHi = (Camera_zeroVector + 0x8000) >> 16;
Camera_pressureMasks = (__patchBase + 0x6D30);
Camera_pressureMasks_signedHi = (Camera_pressureMasks + 0x8000) >> 16;
Mrd_position = (__patchBase + 0x6D60);
Mrd_position_rawHi = (Mrd_position) >> 16;
Mrd_mask = (__patchBase + 0x6D70);
Mrd_mask_rawHi = (Mrd_mask) >> 16;
Mrd_mode = (__patchBase + 0x6D74);
Mrd_mode_rawHi = (Mrd_mode) >> 16;
Orbit_activity = (__patchBase + 0x6D80);
Orbit_activity_rawHi = (Orbit_activity) >> 16;
Orbit_pending = (__patchBase + 0x6D90);
Orbit_pending_rawHi = (Orbit_pending) >> 16;
CameraPressure_start_signedHi = (CameraPressure_start + 0x8000) >> 16;
Camera_noop_signedHi = (Camera_noop + 0x8000) >> 16;
CameraPad_start_signedHi = (CameraPad_start + 0x8000) >> 16;
CameraQuery_start_signedHi = (CameraQuery_start + 0x8000) >> 16;
Pad_capture = (__patchBase + 0x7F00);
Pad_capture_rawHi = (Pad_capture) >> 16;
Destinations_count = (__patchBase + 0x7F80);
Destinations_count_rawHi = (Destinations_count) >> 16;
Menu_control = (__patchBase + 0x7FF0);
Menu_control_rawHi = (Menu_control) >> 16;
Menu_open = (__patchBase + 0x7FF8);
Menu_open_rawHi = (Menu_open) >> 16;
Destinations_entries = (__patchBase + 0xC000);
Destinations_entries_rawHi = (Destinations_entries) >> 16;
