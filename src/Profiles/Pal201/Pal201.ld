native_clock = 0x0014D1F8;
native_load = 0x0022BCB0;
Game_pause = 0x0020F7B8;
Game_resume = 0x0020F828;
Game_hp = 0x001441C8;
Game_reset = 0x0014C168;
Game_setCheckpoint = 0x00165D88;
Game_applyCheckpoint = 0x001654B0;
Game_isKind = 0x00132B10;
Game_warp = 0x00228990;
Game_stopScript = 0x001E0678;
Game_stopVoice = 0x001FEEF8;
Game_setBinocState = 0x0019CCC0;
Game_pauseExtra = 0x0020F990;
Game_pauseInput = 0x0020F8B8;
Game_isVoicePlaying = 0x001FF008;
Game_classObjects = 0x0015E3D0;
Game_clearSubtitles = 0x00227FA8;
Game_loadSo = 0x001F39A0;
Game_allocate = 0x001AE4F0;
Game_allocatePermanent = 0x001AE670;
Game_arenaInitMutex = 0x0021F848;
Game_arenaResetResume = 0x001AE480;
Game_nameArena_rawHi = 0x00000030;
Profile_nameArenaInit = 0x001AE32C;
Profile_nameArenaReset = 0x001AE478;
SECTIONS { .hook.NameArenaInit Profile_nameArenaInit : { KEEP(*(.hook.NameArenaInit)) } }
SECTIONS { .hook.NameArenaReset Profile_nameArenaReset : { KEEP(*(.hook.NameArenaReset)) } }
Game_taskWalk = 0x00164068;
Game_setTaskState = 0x001647D0;
Game_refreshJobs = 0x00164948;
Game_jobState = 0x00163388;
Profile_jobName = 0x00162520;
SECTIONS { .hook.JobName Profile_jobName : { KEEP(*(.hook.JobName)) } }
Profile_characterNameLoad = 0x001C403C;
Profile_characterNameSkip = 0x001C4044;
SECTIONS { .hook.CharacterNameLoad Profile_characterNameLoad : { KEEP(*(.hook.CharacterNameLoad)) } }
SECTIONS { .hook.CharacterNameSkip Profile_characterNameSkip : { KEEP(*(.hook.CharacterNameSkip)) } }
Game_resumeInput = 0x0020F8E8;
Game_resumeSound = 0x0020F958;
Game_resumeExtra = 0x0020F9A0;

Profile_warpNameLoad = 0x0022896C;
Profile_warpNameSkip = 0x00228974;
SECTIONS { .hook.WarpNameLoad Profile_warpNameLoad : { KEEP(*(.hook.WarpNameLoad)) } }
SECTIONS { .hook.WarpNameSkip Profile_warpNameSkip : { KEEP(*(.hook.WarpNameSkip)) } }

Game_readBytes = 0x00117968;
Game_readNameLength = 0x00117C20;
Game_skipName = 0x00118420;
Game_buildEuler = 0x0011B628;
Game_yawPitchMatrix = 0x0011B720;
Game_vectorAngles = 0x0011BC88;
Game_extractEuler = 0x0011BFF0;
Game_wrapAngle = 0x0011CF60;
Game_compareFloat = 0x0011D4D0;
Game_regionsFirstResume = 0x00147FC8;
Game_regionsSecondResume = 0x00148384;
Game_cameraResetResume = 0x0014D8C8;
Game_dirtyCamera = 0x0014D8E8;
Game_applyCameraMatrix = 0x0014E190;
Game_recenterCamera = 0x0014E1D0;
Game_addController = 0x0014E350;
Game_removeController = 0x0014E4F0;
Game_setFov = 0x0014F5C8;
Game_distanceResume = 0x0014F8C8;
Game_cameraBaseBegin = 0x0014FCF0;
Game_cameraBaseEnd = 0x0014FD10;
Game_enumEntrances = 0x0015E9F0;
Game_pushTextScale = 0x0015F0A0;
Game_popTextScale = 0x0015F0E8;
Game_initText = 0x0015F950;
Game_measureText = 0x0015FF68;
Game_drawText = 0x0015FFF8;
Game_compareCheckpoints = 0x00165BA0;
Game_enumCheckpoints = 0x00165C10;
Game_geometryFirstResume = 0x00168714;
Game_geometrySecondResume = 0x001689F4;
Game_readPad = 0x00187920;
Game_consumeButtons = 0x00187D08;
Game_isOrbitCandidate = 0x001A6180;
Game_objectPosition = 0x001A62C8;
Game_scopeBegin = 0x001AE5F0;
Game_scopeEnd = 0x001AE618;
Game_getPlayerPosition = 0x001C4AA8;
Game_drawRectangle = 0x001CD860;
Game_geometryThirdResume = 0x001D5C08;
Game_loadAlo = 0x00231990;
Game_sort = 0x00234108;
Game_sin = 0x00245858;
Game_copyQuad = 0x00256EF8;
Game_clock = 0x002E52D0;
Game_nativeCamera = 0x002E5340;
Game_cameraOrientation = 0x002E53A0;
Game_activeControllerSlot = 0x002E5654;
Game_fontContext = 0x002E5B60;
Game_displayContext = 0x002E5E00;
Game_realPad = 0x002E7000;
Game_world = 0x003E4C90;
Game_worldNodeHead = 0x003E4CBC;
Game_worldNodeTail = 0x003E4CC0;
Game_currentCheckpoint = 0x003E87A4;
Game_worldCount = 0x003E9428;
Profile_hookMrdRegions = 0x00147FC0;
SECTIONS { .hook.MrdRegions Profile_hookMrdRegions : { KEEP(*(.hook.MrdRegions)) } }
Profile_hookMrdRegionsSlot = 0x00147FC4;
SECTIONS { .hook.MrdRegionsSlot Profile_hookMrdRegionsSlot : { KEEP(*(.hook.MrdRegionsSlot)) } }
Profile_hookMrdRegionsPlayer = 0x00147FC8;
SECTIONS { .hook.MrdRegionsPlayer Profile_hookMrdRegionsPlayer : { KEEP(*(.hook.MrdRegionsPlayer)) } }
Profile_hookMrdRegionsSecond = 0x0014837C;
SECTIONS { .hook.MrdRegionsSecond Profile_hookMrdRegionsSecond : { KEEP(*(.hook.MrdRegionsSecond)) } }
Profile_hookMrdRegionsSecondSlot = 0x00148380;
SECTIONS { .hook.MrdRegionsSecondSlot Profile_hookMrdRegionsSecondSlot : { KEEP(*(.hook.MrdRegionsSecondSlot)) } }
Profile_hookMrdRegionsSecondPlayer = 0x00148384;
SECTIONS { .hook.MrdRegionsSecondPlayer Profile_hookMrdRegionsSecondPlayer : { KEEP(*(.hook.MrdRegionsSecondPlayer)) } }
Profile_hookMrdReset = 0x0014D8C0;
SECTIONS { .hook.MrdReset Profile_hookMrdReset : { KEEP(*(.hook.MrdReset)) } }
Profile_hookMrdResetSlot = 0x0014D8C4;
SECTIONS { .hook.MrdResetSlot Profile_hookMrdResetSlot : { KEEP(*(.hook.MrdResetSlot)) } }
Profile_hookClockSpeed = 0x0014D190;
SECTIONS { .hook.ClockSpeed Profile_hookClockSpeed : { KEEP(*(.hook.ClockSpeed)) } }
Profile_hookMrdDistance = 0x0014F8C0;
SECTIONS { .hook.MrdDistance Profile_hookMrdDistance : { KEEP(*(.hook.MrdDistance)) } }
Profile_hookMrdDistanceSlot = 0x0014F8C4;
SECTIONS { .hook.MrdDistanceSlot Profile_hookMrdDistanceSlot : { KEEP(*(.hook.MrdDistanceSlot)) } }
Profile_cloneNames = 0x0013E588;
Game_cloneNamesResume = 0x0013E594;
SECTIONS { .hook.CloneNames Profile_cloneNames : { KEEP(*(.hook.CloneNames)) } }
Profile_hookTaskName = 0x00163714;
SECTIONS { .hook.TaskName Profile_hookTaskName : { KEEP(*(.hook.TaskName)) } }
Profile_hookMrdGeometryFirst = 0x0016870C;
SECTIONS { .boot.hook.MrdGeometryFirst Profile_hookMrdGeometryFirst : { KEEP(*(.boot.hook.MrdGeometryFirst)) } }
Profile_hookMrdGeometryFirstSlot = 0x00168710;
SECTIONS { .boot.hook.MrdGeometryFirstSlot Profile_hookMrdGeometryFirstSlot : { KEEP(*(.boot.hook.MrdGeometryFirstSlot)) } }
Profile_hookMrdGeometrySecond = 0x001689EC;
SECTIONS { .boot.hook.MrdGeometrySecond Profile_hookMrdGeometrySecond : { KEEP(*(.boot.hook.MrdGeometrySecond)) } }
Profile_hookMrdGeometrySecondSlot = 0x001689F0;
SECTIONS { .boot.hook.MrdGeometrySecondSlot Profile_hookMrdGeometrySecondSlot : { KEEP(*(.boot.hook.MrdGeometrySecondSlot)) } }
Profile_hookPadCapture = 0x001874D4;
SECTIONS { .hook.PadCapture Profile_hookPadCapture : { KEEP(*(.hook.PadCapture)) } }
Profile_hookCameraActive = 0x0014FD78;
SECTIONS { .hook.CameraActive Profile_hookCameraActive : { KEEP(*(.hook.CameraActive)) } }
Profile_hookCameraActiveSlot = 0x0014FD7C;
SECTIONS { .hook.CameraActiveSlot Profile_hookCameraActiveSlot : { KEEP(*(.hook.CameraActiveSlot)) } }
Profile_hookPadFold = 0x00187AAC;
SECTIONS { .hook.PadFold Profile_hookPadFold : { KEEP(*(.hook.PadFold)) } }
Profile_hookPadFoldSlot = 0x00187AB0;
SECTIONS { .hook.PadFoldSlot Profile_hookPadFoldSlot : { KEEP(*(.hook.PadFoldSlot)) } }
Profile_hookMrdGeometryThird = 0x001D5C00;
SECTIONS { .boot.hook.MrdGeometryThird Profile_hookMrdGeometryThird : { KEEP(*(.boot.hook.MrdGeometryThird)) } }
Profile_hookMrdGeometryThirdSlot = 0x001D5C04;
SECTIONS { .boot.hook.MrdGeometryThirdSlot Profile_hookMrdGeometryThirdSlot : { KEEP(*(.boot.hook.MrdGeometryThirdSlot)) } }
Profile_hookMenuTick = 0x001D9B74;
SECTIONS { .hook.MenuTick Profile_hookMenuTick : { KEEP(*(.hook.MenuTick)) } }
Profile_hookEntranceName = 0x00228F4C;
SECTIONS { .hook.EntranceName Profile_hookEntranceName : { KEEP(*(.hook.EntranceName)) } }
Profile_hookEntranceNameSkip = 0x00228F54;
SECTIONS { .hook.EntranceNameSkip Profile_hookEntranceNameSkip : { KEEP(*(.hook.EntranceNameSkip)) } }
Profile_hookMrdMicrocode = 0x0025AA44;
SECTIONS { .boot.hook.MrdMicrocode Profile_hookMrdMicrocode : { KEEP(*(.boot.hook.MrdMicrocode)) } }

SECTIONS { .profile.NativeWorlds (__patchBase + 0x3000) : { KEEP(*(.profile.NativeWorlds)) } }
ASSERT(SIZEOF(.profile.Worlds) == 0, "Native enumeration must not include a foreign world catalog")
ASSERT(SIZEOF(.profile.NativeWorlds) <= 0x400, "Native world list overlaps text adapter")

SECTIONS { .profile.WorldNames (__patchBase + 0x3780) : { KEEP(*(.profile.WorldNames)) . = ALIGN(4); } }
ASSERT(SIZEOF(.profile.WorldNames) <= 0x380, "World names overlap Warps")

Game_menuHorizontal = 0x00187E10;
Game_menuVertical = 0x00188060;
