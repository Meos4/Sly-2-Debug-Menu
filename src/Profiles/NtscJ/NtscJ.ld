native_clock = 0x0014D628;
native_load = 0x0022D008;
Game_pause = 0x00210480;
Game_resume = 0x002104F0;
Game_hp = 0x00144600;
Game_reset = 0x0014C598;
Game_setCheckpoint = 0x001667C0;
Game_applyCheckpoint = 0x00165EE8;
Game_isKind = 0x00132E60;
Game_warp = 0x00229CE8;
Game_stopScript = 0x001E1438;
Game_stopVoice = 0x001FFB38;
Game_setBinocState = 0x0019D6F8;
Game_pauseExtra = 0x00210658;
Game_pauseInput = 0x00210580;
Game_isVoicePlaying = 0x001FFC48;
Game_classObjects = 0x0015E858;
Game_clearSubtitles = 0x002292E8;
Game_loadSo = 0x001F45E0;
Game_allocate = 0x001AF0F0;
Game_allocatePermanent = 0x001AF270;
Game_arenaInitMutex = 0x00220B88;
Game_arenaResetResume = 0x001AF080;
Game_nameArena_rawHi = 0x00000030;
Profile_nameArenaInit = 0x001AEF2C;
Profile_nameArenaReset = 0x001AF078;
SECTIONS { .hook.NameArenaInit Profile_nameArenaInit : { KEEP(*(.hook.NameArenaInit)) } }
SECTIONS { .hook.NameArenaReset Profile_nameArenaReset : { KEEP(*(.hook.NameArenaReset)) } }
Game_taskWalk = 0x00164AF0;
Game_setTaskState = 0x00165258;
Game_refreshJobs = 0x001653D0;
Game_jobState = 0x00163E10;
Profile_jobName = 0x00162FA8;
SECTIONS { .hook.JobName Profile_jobName : { KEEP(*(.hook.JobName)) } }
Profile_characterNameLoad = 0x001C4C6C;
Profile_characterNameSkip = 0x001C4C74;
SECTIONS { .hook.CharacterNameLoad Profile_characterNameLoad : { KEEP(*(.hook.CharacterNameLoad)) } }
SECTIONS { .hook.CharacterNameSkip Profile_characterNameSkip : { KEEP(*(.hook.CharacterNameSkip)) } }
Game_resumeInput = 0x002105B0;
Game_resumeSound = 0x00210620;
Game_resumeExtra = 0x00210668;

Profile_warpNameLoad = 0x00229CC4;
Profile_warpNameSkip = 0x00229CCC;
SECTIONS { .hook.WarpNameLoad Profile_warpNameLoad : { KEEP(*(.hook.WarpNameLoad)) } }
SECTIONS { .hook.WarpNameSkip Profile_warpNameSkip : { KEEP(*(.hook.WarpNameSkip)) } }

Game_readBytes = 0x001179D8;
Game_readNameLength = 0x00117C90;
Game_skipName = 0x00118490;
Game_buildEuler = 0x0011B970;
Game_yawPitchMatrix = 0x0011BA68;
Game_vectorAngles = 0x0011BFD0;
Game_extractEuler = 0x0011C338;
Game_wrapAngle = 0x0011D2A8;
Game_compareFloat = 0x0011D818;
Game_regionsFirstResume = 0x00148400;
Game_regionsSecondResume = 0x001487BC;
Game_cameraResetResume = 0x0014DCF8;
Game_dirtyCamera = 0x0014DD18;
Game_applyCameraMatrix = 0x0014E5C0;
Game_recenterCamera = 0x0014E600;
Game_addController = 0x0014E780;
Game_removeController = 0x0014E920;
Game_setFov = 0x0014F9F8;
Game_distanceResume = 0x0014FCF8;
Game_cameraBaseBegin = 0x00150120;
Game_cameraBaseEnd = 0x00150140;
Game_enumEntrances = 0x0015EE78;
Game_pushTextScale = 0x0015F958;
Game_popTextScale = 0x0015F9A0;
Profile_nativeInitText = 0x00160220;
Profile_nativeMeasureText = 0x001609F0;
Profile_nativeDrawText = 0x00160A80;
Game_compareCheckpoints = 0x001665D8;
Game_enumCheckpoints = 0x00166648;
Game_geometryFirstResume = 0x0016914C;
Game_geometrySecondResume = 0x0016942C;
Game_readPad = 0x00188358;
Game_consumeButtons = 0x00188740;
Game_isOrbitCandidate = 0x001A6D60;
Game_objectPosition = 0x001A6EA8;
Game_scopeBegin = 0x001AF1F0;
Game_scopeEnd = 0x001AF218;
Game_getPlayerPosition = 0x001C56D8;
Game_drawRectangle = 0x001CE490;
Game_geometryThirdResume = 0x001D6830;
Game_loadAlo = 0x00232CE8;
Game_sort = 0x00235438;
Game_sin = 0x00246990;
Game_copyQuad = 0x00258038;
Game_clock = 0x002E7150;
Game_nativeCamera = 0x002E71C0;
Game_cameraOrientation = 0x002E7220;
Game_activeControllerSlot = 0x002E74D4;
Game_fontContext = 0x002E79E0;
Game_displayContext = 0x002E7C80;
Game_realPad = 0x002E8E80;
Game_world = 0x003E6C90;
Game_worldNodeHead = 0x003E6CBC;
Game_worldNodeTail = 0x003E6CC0;
Game_currentCheckpoint = 0x003EA9A4;
Game_worldCount = 0x003EB628;
Profile_hookMrdRegions = 0x001483F8;
SECTIONS { .hook.MrdRegions Profile_hookMrdRegions : { KEEP(*(.hook.MrdRegions)) } }
Profile_hookMrdRegionsSlot = 0x001483FC;
SECTIONS { .hook.MrdRegionsSlot Profile_hookMrdRegionsSlot : { KEEP(*(.hook.MrdRegionsSlot)) } }
Profile_hookMrdRegionsPlayer = 0x00148400;
SECTIONS { .hook.MrdRegionsPlayer Profile_hookMrdRegionsPlayer : { KEEP(*(.hook.MrdRegionsPlayer)) } }
Profile_hookMrdRegionsSecond = 0x001487B4;
SECTIONS { .hook.MrdRegionsSecond Profile_hookMrdRegionsSecond : { KEEP(*(.hook.MrdRegionsSecond)) } }
Profile_hookMrdRegionsSecondSlot = 0x001487B8;
SECTIONS { .hook.MrdRegionsSecondSlot Profile_hookMrdRegionsSecondSlot : { KEEP(*(.hook.MrdRegionsSecondSlot)) } }
Profile_hookMrdRegionsSecondPlayer = 0x001487BC;
SECTIONS { .hook.MrdRegionsSecondPlayer Profile_hookMrdRegionsSecondPlayer : { KEEP(*(.hook.MrdRegionsSecondPlayer)) } }
Profile_hookMrdReset = 0x0014DCF0;
SECTIONS { .hook.MrdReset Profile_hookMrdReset : { KEEP(*(.hook.MrdReset)) } }
Profile_hookMrdResetSlot = 0x0014DCF4;
SECTIONS { .hook.MrdResetSlot Profile_hookMrdResetSlot : { KEEP(*(.hook.MrdResetSlot)) } }
Profile_hookClockSpeed = 0x0014D5C0;
SECTIONS { .hook.ClockSpeed Profile_hookClockSpeed : { KEEP(*(.hook.ClockSpeed)) } }
Profile_hookMrdDistance = 0x0014FCF0;
SECTIONS { .hook.MrdDistance Profile_hookMrdDistance : { KEEP(*(.hook.MrdDistance)) } }
Profile_hookMrdDistanceSlot = 0x0014FCF4;
SECTIONS { .hook.MrdDistanceSlot Profile_hookMrdDistanceSlot : { KEEP(*(.hook.MrdDistanceSlot)) } }
Profile_cloneNames = 0x0013E9C0;
Game_cloneNamesResume = 0x0013E9CC;
SECTIONS { .hook.CloneNames Profile_cloneNames : { KEEP(*(.hook.CloneNames)) } }
Profile_hookTaskName = 0x0016419C;
SECTIONS { .hook.TaskName Profile_hookTaskName : { KEEP(*(.hook.TaskName)) } }
Profile_hookMrdGeometryFirst = 0x00169144;
SECTIONS { .boot.hook.MrdGeometryFirst Profile_hookMrdGeometryFirst : { KEEP(*(.boot.hook.MrdGeometryFirst)) } }
Profile_hookMrdGeometryFirstSlot = 0x00169148;
SECTIONS { .boot.hook.MrdGeometryFirstSlot Profile_hookMrdGeometryFirstSlot : { KEEP(*(.boot.hook.MrdGeometryFirstSlot)) } }
Profile_hookMrdGeometrySecond = 0x00169424;
SECTIONS { .boot.hook.MrdGeometrySecond Profile_hookMrdGeometrySecond : { KEEP(*(.boot.hook.MrdGeometrySecond)) } }
Profile_hookMrdGeometrySecondSlot = 0x00169428;
SECTIONS { .boot.hook.MrdGeometrySecondSlot Profile_hookMrdGeometrySecondSlot : { KEEP(*(.boot.hook.MrdGeometrySecondSlot)) } }
Profile_hookPadCapture = 0x00187F0C;
SECTIONS { .hook.PadCapture Profile_hookPadCapture : { KEEP(*(.hook.PadCapture)) } }
Profile_hookCameraActive = 0x001501A8;
SECTIONS { .hook.CameraActive Profile_hookCameraActive : { KEEP(*(.hook.CameraActive)) } }
Profile_hookCameraActiveSlot = 0x001501AC;
SECTIONS { .hook.CameraActiveSlot Profile_hookCameraActiveSlot : { KEEP(*(.hook.CameraActiveSlot)) } }
Profile_hookPadFold = 0x001884E4;
SECTIONS { .hook.PadFold Profile_hookPadFold : { KEEP(*(.hook.PadFold)) } }
Profile_hookPadFoldSlot = 0x001884E8;
SECTIONS { .hook.PadFoldSlot Profile_hookPadFoldSlot : { KEEP(*(.hook.PadFoldSlot)) } }
Profile_hookMrdGeometryThird = 0x001D6828;
SECTIONS { .boot.hook.MrdGeometryThird Profile_hookMrdGeometryThird : { KEEP(*(.boot.hook.MrdGeometryThird)) } }
Profile_hookMrdGeometryThirdSlot = 0x001D682C;
SECTIONS { .boot.hook.MrdGeometryThirdSlot Profile_hookMrdGeometryThirdSlot : { KEEP(*(.boot.hook.MrdGeometryThirdSlot)) } }
Profile_hookMenuTick = 0x001DA7CC;
SECTIONS { .hook.MenuTick Profile_hookMenuTick : { KEEP(*(.hook.MenuTick)) } }
Profile_hookEntranceName = 0x0022A2A4;
SECTIONS { .hook.EntranceName Profile_hookEntranceName : { KEEP(*(.hook.EntranceName)) } }
Profile_hookEntranceNameSkip = 0x0022A2AC;
SECTIONS { .hook.EntranceNameSkip Profile_hookEntranceNameSkip : { KEEP(*(.hook.EntranceNameSkip)) } }
Profile_hookMrdMicrocode = 0x0025BB84;
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

Game_menuHorizontal = 0x00188848;
Game_menuVertical = 0x00188A98;
