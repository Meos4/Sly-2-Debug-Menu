#ifndef SLY_GAME_H
#define SLY_GAME_H

#include "Common/Types.h"

extern const u32 Game_realPad;

void Game_pause(u32 world, u32 reason);
void Game_resume(u32 world, u32 reason);
void Game_hp(u32 character, u32 hp);
void Game_reset(u32 clear);
void Game_setCheckpoint(u32 world, u32 checkpoint);
void Game_applyCheckpoint(u32 checkpoint);
void Game_camera(u32 object, s32 mode);
void Game_listDestinations(u32 mode);
void Game_listWorlds(void);
s32 Game_isKind(u32 object, u32 kind);
void Game_warp(u32 object);
void Game_stopScript(u32 script);
u32 Game_classObjects(u32 world, u32 kind);
u32 Game_isVoicePlaying(u32 manager, u32 line);
void Game_stopVoice(u32 manager);
void Game_clearSubtitles(u32 manager);
void Game_setBinocState(u32 binoc, s32 state);
void Game_pauseInput(u32 world);
void Game_pauseExtra(u32 world);
void Game_loadSo(u32 object, u32 stream);
u32 Game_allocate(const u32* request);
u32 Game_allocatePermanent(u32 size);
void Game_scopeBegin(u32* scope);
void Game_scopeEnd(u32* scope, u32 mode);
void Game_sort(void* objects, u32 count, u32 size, s32 (*compare)(const void*, const void*));
void Game_setTaskState(u32 object, u32 state, u32 event);
void Game_refreshJobs(void);
u32 Game_jobState(u32 object);
void Game_dirtyCamera(u32 camera);
void Game_resumeInput(u32 world);
void Game_resumeSound(u32 world);
void Game_resumeExtra(u32 world);
u32 Game_consumeButtons(u32 pad, u32 mask);

#endif
