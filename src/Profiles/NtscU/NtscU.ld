native_clock = 0x14D1D0;
native_load = 0x22B490;
Game_pause = 0x20EFC0;
Game_resume = 0x20F030;
Game_hp = 0x144188;
Game_reset = 0x14C140;
Game_setCheckpoint = 0x165E10;
Game_applyCheckpoint = 0x165538;
Game_isKind = 0x132B10;
Game_warp = 0x228170;
Game_stopScript = 0x1DFEB8;
Game_stopVoice = 0x1FE738;
Game_setBinocState = 0x19CD38;
Game_pauseExtra = 0x20F198;
Game_pauseInput = 0x20F0C0;
Game_isVoicePlaying = 0x1FE848;
Game_classObjects = 0x15E3A8;
Game_clearSubtitles = 0x227788;
Game_loadSo = 0x1F31E0;
Game_allocate = 0x1AE378;
Game_allocatePermanent = 0x1AE4F8;
Game_arenaInitMutex = 0x21F028;
Game_arenaResetResume = 0x1AE308;
Game_nameArena_rawHi = 0x2F;
Profile_nameArenaInit = 0x1AE1B4;
Profile_nameArenaReset = 0x1AE300;
SECTIONS { .hook.NameArenaInit Profile_nameArenaInit : { KEEP(*(.hook.NameArenaInit)) } }
SECTIONS { .hook.NameArenaReset Profile_nameArenaReset : { KEEP(*(.hook.NameArenaReset)) } }
Game_taskWalk = 0x164100;
Game_setTaskState = 0x164858;
Game_refreshJobs = 0x1649D0;
Game_jobState = 0x163430;
Profile_jobName = 0x1625C8;
SECTIONS { .hook.JobName Profile_jobName : { KEEP(*(.hook.JobName)) } }
Profile_characterNameLoad = 0x1C3DD4;
Profile_characterNameSkip = 0x1C3DDC;
SECTIONS { .hook.CharacterNameLoad Profile_characterNameLoad : { KEEP(*(.hook.CharacterNameLoad)) } }
SECTIONS { .hook.CharacterNameSkip Profile_characterNameSkip : { KEEP(*(.hook.CharacterNameSkip)) } }
Game_resumeInput = 0x20F0F0;
Game_resumeSound = 0x20F160;
Game_resumeExtra = 0x20F1A8;

Profile_warpNameLoad = 0x22814C;
Profile_warpNameSkip = 0x228154;
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
Game_regionsFirstResume = 0x00147F88;
Game_regionsSecondResume = 0x00148344;
Game_cameraResetResume = 0x0014D8A0;
Game_dirtyCamera = 0x0014D8C0;
Game_applyCameraMatrix = 0x0014E168;
Game_recenterCamera = 0x0014E1A8;
Game_addController = 0x0014E328;
Game_removeController = 0x0014E4C8;
Game_setFov = 0x0014F5A0;
Game_distanceResume = 0x0014F8A0;
Game_cameraBaseBegin = 0x0014FCC8;
Game_cameraBaseEnd = 0x0014FCE8;
Game_enumEntrances = 0x0015E9C8;
Game_pushTextScale = 0x0015F078;
Game_popTextScale = 0x0015F0C0;
Game_initText = 0x0015F928;
Game_measureText = 0x0015FF40;
Game_drawText = 0x0015FFD0;
Game_compareCheckpoints = 0x00165C28;
Game_enumCheckpoints = 0x00165C98;
Game_geometryFirstResume = 0x0016878C;
Game_geometrySecondResume = 0x00168A6C;
Game_readPad = 0x00187998;
Game_consumeButtons = 0x00187D80;
Game_isOrbitCandidate = 0x001A61A0;
Game_objectPosition = 0x001A62E8;
Game_scopeBegin = 0x001AE478;
Game_scopeEnd = 0x001AE4A0;
Game_getPlayerPosition = 0x001C4840;
Game_drawRectangle = 0x001CD5F0;
Game_geometryThirdResume = 0x001D5990;
Game_loadAlo = 0x00231170;
Game_sort = 0x002338C0;
Game_sin = 0x00244E10;
Game_copyQuad = 0x002564A8;
Game_clock = 0x002DDED0;
Game_nativeCamera = 0x002DDF40;
Game_cameraOrientation = 0x002DDFA0;
Game_activeControllerSlot = 0x002DE254;
Game_fontContext = 0x002DE760;
Game_displayContext = 0x002DEA00;
Game_realPad = 0x002DFC00;
Game_world = 0x003DD490;
Game_worldNodeHead = 0x003DD4BC;
Game_worldNodeTail = 0x003DD4C0;
Game_currentCheckpoint = 0x003E0FA4;
Game_worldCount = 0x003E1C38;
Profile_hookMrdRegions = 0x00147F80;
SECTIONS { .hook.MrdRegions Profile_hookMrdRegions : { KEEP(*(.hook.MrdRegions)) } }
Profile_hookMrdRegionsSlot = 0x00147F84;
SECTIONS { .hook.MrdRegionsSlot Profile_hookMrdRegionsSlot : { KEEP(*(.hook.MrdRegionsSlot)) } }
Profile_hookMrdRegionsPlayer = 0x00147F88;
SECTIONS { .hook.MrdRegionsPlayer Profile_hookMrdRegionsPlayer : { KEEP(*(.hook.MrdRegionsPlayer)) } }
Profile_hookMrdRegionsSecond = 0x0014833C;
SECTIONS { .hook.MrdRegionsSecond Profile_hookMrdRegionsSecond : { KEEP(*(.hook.MrdRegionsSecond)) } }
Profile_hookMrdRegionsSecondSlot = 0x00148340;
SECTIONS { .hook.MrdRegionsSecondSlot Profile_hookMrdRegionsSecondSlot : { KEEP(*(.hook.MrdRegionsSecondSlot)) } }
Profile_hookMrdRegionsSecondPlayer = 0x00148344;
SECTIONS { .hook.MrdRegionsSecondPlayer Profile_hookMrdRegionsSecondPlayer : { KEEP(*(.hook.MrdRegionsSecondPlayer)) } }
Profile_hookMrdReset = 0x0014D898;
SECTIONS { .hook.MrdReset Profile_hookMrdReset : { KEEP(*(.hook.MrdReset)) } }
Profile_hookMrdResetSlot = 0x0014D89C;
SECTIONS { .hook.MrdResetSlot Profile_hookMrdResetSlot : { KEEP(*(.hook.MrdResetSlot)) } }
Profile_hookClockSpeed = 0x0014D168;
SECTIONS { .hook.ClockSpeed Profile_hookClockSpeed : { KEEP(*(.hook.ClockSpeed)) } }
Profile_hookMrdDistance = 0x0014F898;
SECTIONS { .hook.MrdDistance Profile_hookMrdDistance : { KEEP(*(.hook.MrdDistance)) } }
Profile_hookMrdDistanceSlot = 0x0014F89C;
SECTIONS { .hook.MrdDistanceSlot Profile_hookMrdDistanceSlot : { KEEP(*(.hook.MrdDistanceSlot)) } }
Profile_cloneNames = 0x0013E570;
Game_cloneNamesResume = 0x0013E57C;
SECTIONS { .hook.CloneNames Profile_cloneNames : { KEEP(*(.hook.CloneNames)) } }
Profile_hookTaskName = 0x001637AC;
SECTIONS { .hook.TaskName Profile_hookTaskName : { KEEP(*(.hook.TaskName)) } }
Profile_hookMrdGeometryFirst = 0x00168784;
SECTIONS { .boot.hook.MrdGeometryFirst Profile_hookMrdGeometryFirst : { KEEP(*(.boot.hook.MrdGeometryFirst)) } }
Profile_hookMrdGeometryFirstSlot = 0x00168788;
SECTIONS { .boot.hook.MrdGeometryFirstSlot Profile_hookMrdGeometryFirstSlot : { KEEP(*(.boot.hook.MrdGeometryFirstSlot)) } }
Profile_hookMrdGeometrySecond = 0x00168A64;
SECTIONS { .boot.hook.MrdGeometrySecond Profile_hookMrdGeometrySecond : { KEEP(*(.boot.hook.MrdGeometrySecond)) } }
Profile_hookMrdGeometrySecondSlot = 0x00168A68;
SECTIONS { .boot.hook.MrdGeometrySecondSlot Profile_hookMrdGeometrySecondSlot : { KEEP(*(.boot.hook.MrdGeometrySecondSlot)) } }
Profile_hookPadCapture = 0x0018754C;
SECTIONS { .hook.PadCapture Profile_hookPadCapture : { KEEP(*(.hook.PadCapture)) } }
Profile_hookCameraActive = 0x0014FD50;
SECTIONS { .hook.CameraActive Profile_hookCameraActive : { KEEP(*(.hook.CameraActive)) } }
Profile_hookCameraActiveSlot = 0x0014FD54;
SECTIONS { .hook.CameraActiveSlot Profile_hookCameraActiveSlot : { KEEP(*(.hook.CameraActiveSlot)) } }
Profile_hookPadFold = 0x00187B24;
SECTIONS { .hook.PadFold Profile_hookPadFold : { KEEP(*(.hook.PadFold)) } }
Profile_hookPadFoldSlot = 0x00187B28;
SECTIONS { .hook.PadFoldSlot Profile_hookPadFoldSlot : { KEEP(*(.hook.PadFoldSlot)) } }
Profile_hookMrdGeometryThird = 0x001D5988;
SECTIONS { .boot.hook.MrdGeometryThird Profile_hookMrdGeometryThird : { KEEP(*(.boot.hook.MrdGeometryThird)) } }
Profile_hookMrdGeometryThirdSlot = 0x001D598C;
SECTIONS { .boot.hook.MrdGeometryThirdSlot Profile_hookMrdGeometryThirdSlot : { KEEP(*(.boot.hook.MrdGeometryThirdSlot)) } }
Profile_hookMenuTick = 0x001D982C;
SECTIONS { .hook.MenuTick Profile_hookMenuTick : { KEEP(*(.hook.MenuTick)) } }
Profile_hookEntranceName = 0x0022872C;
SECTIONS { .hook.EntranceName Profile_hookEntranceName : { KEEP(*(.hook.EntranceName)) } }
Profile_hookEntranceNameSkip = 0x00228734;
SECTIONS { .hook.EntranceNameSkip Profile_hookEntranceNameSkip : { KEEP(*(.hook.EntranceNameSkip)) } }
Profile_hookMrdMicrocode = 0x00259FF4;
SECTIONS { .boot.hook.MrdMicrocode Profile_hookMrdMicrocode : { KEEP(*(.boot.hook.MrdMicrocode)) } }

Game_menuHorizontal = 0x00187E88;
Game_menuVertical = 0x001880D8;
