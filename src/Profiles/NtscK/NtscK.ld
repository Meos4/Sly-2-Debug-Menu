native_clock = 0x0014DA40;
native_load = 0x0022D1B0;
Game_pause = 0x002104D8;
Game_resume = 0x00210548;
Game_hp = 0x00144A18;
Game_reset = 0x0014C9B0;
Game_setCheckpoint = 0x00166A98;
Game_applyCheckpoint = 0x001661C0;
Game_isKind = 0x00133288;
Game_warp = 0x00229E90;
Game_stopScript = 0x001E1398;
Game_stopVoice = 0x001FFC18;
Game_setBinocState = 0x0019D9D0;
Game_pauseExtra = 0x002106B0;
Game_pauseInput = 0x002105D8;
Game_isVoicePlaying = 0x001FFD28;
Game_classObjects = 0x0015EC40;
Game_clearSubtitles = 0x00229490;
Game_loadSo = 0x001F46C0;
Game_allocate = 0x001AF2C8;
Game_allocatePermanent = 0x001AF448;
Game_arenaInitMutex = 0x00220D30;
Game_arenaResetResume = 0x001AF258;
Game_nameArena_rawHi = 0x00000030;
Profile_nameArenaInit = 0x001AF104;
Profile_nameArenaReset = 0x001AF250;
SECTIONS { .hook.NameArenaInit Profile_nameArenaInit : { KEEP(*(.hook.NameArenaInit)) } }
SECTIONS { .hook.NameArenaReset Profile_nameArenaReset : { KEEP(*(.hook.NameArenaReset)) } }
Game_taskWalk = 0x00164D78;
Game_setTaskState = 0x001654E0;
Game_refreshJobs = 0x00165658;
Game_jobState = 0x00164098;
Profile_jobName = 0x00163230;
SECTIONS { .hook.JobName Profile_jobName : { KEEP(*(.hook.JobName)) } }
Profile_characterNameLoad = 0x001C4DE4;
Profile_characterNameSkip = 0x001C4DEC;
SECTIONS { .hook.CharacterNameLoad Profile_characterNameLoad : { KEEP(*(.hook.CharacterNameLoad)) } }
SECTIONS { .hook.CharacterNameSkip Profile_characterNameSkip : { KEEP(*(.hook.CharacterNameSkip)) } }
Game_resumeInput = 0x00210608;
Game_resumeSound = 0x00210678;
Game_resumeExtra = 0x002106C0;

Profile_warpNameLoad = 0x00229E6C;
Profile_warpNameSkip = 0x00229E74;
SECTIONS { .hook.WarpNameLoad Profile_warpNameLoad : { KEEP(*(.hook.WarpNameLoad)) } }
SECTIONS { .hook.WarpNameSkip Profile_warpNameSkip : { KEEP(*(.hook.WarpNameSkip)) } }

Game_readBytes = 0x001179D0;
Game_readNameLength = 0x00117C88;
Game_skipName = 0x00118488;
Game_buildEuler = 0x0011BD98;
Game_yawPitchMatrix = 0x0011BE90;
Game_vectorAngles = 0x0011C3F8;
Game_extractEuler = 0x0011C760;
Game_wrapAngle = 0x0011D6D0;
Game_compareFloat = 0x0011DC40;
Game_regionsFirstResume = 0x00148818;
Game_regionsSecondResume = 0x00148BD4;
Game_cameraResetResume = 0x0014E110;
Game_dirtyCamera = 0x0014E130;
Game_applyCameraMatrix = 0x0014E9D8;
Game_recenterCamera = 0x0014EA18;
Game_addController = 0x0014EB98;
Game_removeController = 0x0014ED38;
Game_setFov = 0x0014FE10;
Game_distanceResume = 0x00150110;
Game_cameraBaseBegin = 0x00150538;
Game_cameraBaseEnd = 0x00150558;
Game_enumEntrances = 0x0015F260;
Game_pushTextScale = 0x0015F930;
Game_popTextScale = 0x0015F978;
Profile_nativeInitText = 0x001604A8;
Profile_nativeMeasureText = 0x00160C78;
Profile_nativeDrawText = 0x00160D08;
Game_compareCheckpoints = 0x001668B0;
Game_enumCheckpoints = 0x00166920;
Game_geometryFirstResume = 0x00169424;
Game_geometrySecondResume = 0x00169704;
Game_readPad = 0x00188630;
Game_consumeButtons = 0x00188A18;
Game_isOrbitCandidate = 0x001A7010;
Game_objectPosition = 0x001A7158;
Game_scopeBegin = 0x001AF3C8;
Game_scopeEnd = 0x001AF3F0;
Game_getPlayerPosition = 0x001C5850;
Game_drawRectangle = 0x001CE608;
Game_geometryThirdResume = 0x001D69A8;
Game_loadAlo = 0x00232E90;
Game_sort = 0x002355E0;
Game_sin = 0x00246B10;
Game_copyQuad = 0x002581B8;
Game_clock = 0x002E6750;
Game_nativeCamera = 0x002E67C0;
Game_cameraOrientation = 0x002E6820;
Game_activeControllerSlot = 0x002E6AD4;
Game_fontContext = 0x002E6FE0;
Game_displayContext = 0x002E7280;
Game_realPad = 0x002E8480;
Game_world = 0x003E6310;
Game_worldNodeHead = 0x003E633C;
Game_worldNodeTail = 0x003E6340;
Game_currentCheckpoint = 0x003EA024;
Game_worldCount = 0x003EACA8;
Profile_hookMrdRegions = 0x00148810;
SECTIONS { .hook.MrdRegions Profile_hookMrdRegions : { KEEP(*(.hook.MrdRegions)) } }
Profile_hookMrdRegionsSlot = 0x00148814;
SECTIONS { .hook.MrdRegionsSlot Profile_hookMrdRegionsSlot : { KEEP(*(.hook.MrdRegionsSlot)) } }
Profile_hookMrdRegionsPlayer = 0x00148818;
SECTIONS { .hook.MrdRegionsPlayer Profile_hookMrdRegionsPlayer : { KEEP(*(.hook.MrdRegionsPlayer)) } }
Profile_hookMrdRegionsSecond = 0x00148BCC;
SECTIONS { .hook.MrdRegionsSecond Profile_hookMrdRegionsSecond : { KEEP(*(.hook.MrdRegionsSecond)) } }
Profile_hookMrdRegionsSecondSlot = 0x00148BD0;
SECTIONS { .hook.MrdRegionsSecondSlot Profile_hookMrdRegionsSecondSlot : { KEEP(*(.hook.MrdRegionsSecondSlot)) } }
Profile_hookMrdRegionsSecondPlayer = 0x00148BD4;
SECTIONS { .hook.MrdRegionsSecondPlayer Profile_hookMrdRegionsSecondPlayer : { KEEP(*(.hook.MrdRegionsSecondPlayer)) } }
Profile_hookMrdReset = 0x0014E108;
SECTIONS { .hook.MrdReset Profile_hookMrdReset : { KEEP(*(.hook.MrdReset)) } }
Profile_hookMrdResetSlot = 0x0014E10C;
SECTIONS { .hook.MrdResetSlot Profile_hookMrdResetSlot : { KEEP(*(.hook.MrdResetSlot)) } }
Profile_hookClockSpeed = 0x0014D9D8;
SECTIONS { .hook.ClockSpeed Profile_hookClockSpeed : { KEEP(*(.hook.ClockSpeed)) } }
Profile_hookMrdDistance = 0x00150108;
SECTIONS { .hook.MrdDistance Profile_hookMrdDistance : { KEEP(*(.hook.MrdDistance)) } }
Profile_hookMrdDistanceSlot = 0x0015010C;
SECTIONS { .hook.MrdDistanceSlot Profile_hookMrdDistanceSlot : { KEEP(*(.hook.MrdDistanceSlot)) } }
Profile_cloneNames = 0x0013EDD8;
Game_cloneNamesResume = 0x0013EDE4;
SECTIONS { .hook.CloneNames Profile_cloneNames : { KEEP(*(.hook.CloneNames)) } }
Profile_hookTaskName = 0x00164424;
SECTIONS { .hook.TaskName Profile_hookTaskName : { KEEP(*(.hook.TaskName)) } }
Profile_hookMrdGeometryFirst = 0x0016941C;
SECTIONS { .boot.hook.MrdGeometryFirst Profile_hookMrdGeometryFirst : { KEEP(*(.boot.hook.MrdGeometryFirst)) } }
Profile_hookMrdGeometryFirstSlot = 0x00169420;
SECTIONS { .boot.hook.MrdGeometryFirstSlot Profile_hookMrdGeometryFirstSlot : { KEEP(*(.boot.hook.MrdGeometryFirstSlot)) } }
Profile_hookMrdGeometrySecond = 0x001696FC;
SECTIONS { .boot.hook.MrdGeometrySecond Profile_hookMrdGeometrySecond : { KEEP(*(.boot.hook.MrdGeometrySecond)) } }
Profile_hookMrdGeometrySecondSlot = 0x00169700;
SECTIONS { .boot.hook.MrdGeometrySecondSlot Profile_hookMrdGeometrySecondSlot : { KEEP(*(.boot.hook.MrdGeometrySecondSlot)) } }
Profile_hookPadCapture = 0x001881E4;
SECTIONS { .hook.PadCapture Profile_hookPadCapture : { KEEP(*(.hook.PadCapture)) } }
Profile_hookCameraActive = 0x001505C0;
SECTIONS { .hook.CameraActive Profile_hookCameraActive : { KEEP(*(.hook.CameraActive)) } }
Profile_hookCameraActiveSlot = 0x001505C4;
SECTIONS { .hook.CameraActiveSlot Profile_hookCameraActiveSlot : { KEEP(*(.hook.CameraActiveSlot)) } }
Profile_hookPadFold = 0x001887BC;
SECTIONS { .hook.PadFold Profile_hookPadFold : { KEEP(*(.hook.PadFold)) } }
Profile_hookPadFoldSlot = 0x001887C0;
SECTIONS { .hook.PadFoldSlot Profile_hookPadFoldSlot : { KEEP(*(.hook.PadFoldSlot)) } }
Profile_hookMrdGeometryThird = 0x001D69A0;
SECTIONS { .boot.hook.MrdGeometryThird Profile_hookMrdGeometryThird : { KEEP(*(.boot.hook.MrdGeometryThird)) } }
Profile_hookMrdGeometryThirdSlot = 0x001D69A4;
SECTIONS { .boot.hook.MrdGeometryThirdSlot Profile_hookMrdGeometryThirdSlot : { KEEP(*(.boot.hook.MrdGeometryThirdSlot)) } }
Profile_hookMenuTick = 0x001DA92C;
SECTIONS { .hook.MenuTick Profile_hookMenuTick : { KEEP(*(.hook.MenuTick)) } }
Profile_hookEntranceName = 0x0022A44C;
SECTIONS { .hook.EntranceName Profile_hookEntranceName : { KEEP(*(.hook.EntranceName)) } }
Profile_hookEntranceNameSkip = 0x0022A454;
SECTIONS { .hook.EntranceNameSkip Profile_hookEntranceNameSkip : { KEEP(*(.hook.EntranceNameSkip)) } }
Profile_hookMrdMicrocode = 0x0025BD04;
SECTIONS { .boot.hook.MrdMicrocode Profile_hookMrdMicrocode : { KEEP(*(.boot.hook.MrdMicrocode)) } }

Game_initText = WideText_init;
Game_measureText = WideText_measure;
Game_drawText = WideText_draw;

SECTIONS { .profile.NativeWorlds (__patchBase + 0x3000) : { KEEP(*(.profile.NativeWorlds)) } }
ASSERT(SIZEOF(.profile.Worlds) == 0, "Native enumeration must not include a foreign world catalog")
ASSERT(SIZEOF(.profile.NativeWorlds) <= 0x400, "Native world list overlaps text adapter")
SECTIONS { .profile.WideText (__patchBase + 0x3400) : { KEEP(*(.profile.WideText)) } }
ASSERT(SIZEOF(.profile.WideText) <= 0x100, "Text adapter overlaps its private record")
Profile_textRecord = (__patchBase + 0x3500);
Profile_textBuffer = (__patchBase + 0x3680);

SECTIONS { .profile.WorldNames (__patchBase + 0x3780) : { KEEP(*(.profile.WorldNames)) . = ALIGN(4); } }
ASSERT(SIZEOF(.profile.WorldNames) <= 0x380, "World names overlap Warps")

ASSERT(Profile_textRecord >= ADDR(.profile.WideText) + SIZEOF(.profile.WideText), "Text record overlaps adapter code")
ASSERT((Profile_textRecord & 15) == 0, "Text record must be quadword aligned")
ASSERT(Profile_textRecord + 0x180 <= Profile_textBuffer, "Text record overlaps UTF-16 buffer")
ASSERT(Profile_textBuffer + 0x100 <= ADDR(.profile.WorldNames), "UTF-16 buffer overlaps world names")

Game_menuHorizontal = 0x00188B20;
Game_menuVertical = 0x00188D70;
