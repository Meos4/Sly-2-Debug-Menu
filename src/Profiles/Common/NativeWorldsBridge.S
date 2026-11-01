#include "Common/Bridges.inc"
.set noreorder
.set noat
.set gp=64
.option pic0
.section .profile.NativeWorlds,"ax",@progbits
.global NativeWorldsBridge_build
NativeWorldsBridge_build:
	CALLEE_SAVED_BRIDGE NativeWorlds_build
