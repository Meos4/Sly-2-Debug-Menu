#include "Common/Bridges.inc"
.set noreorder
.set noat
.set gp=64
.option pic0
.section .cacheBridges,"ax",@progbits

.global Entry_nameSlot
Entry_nameSlot:
	CALLEE_SAVED_BRIDGE NameCache_slot

.global Entry_resetNames
Entry_resetNames:
	addiu $sp,$sp,-0x200
	SAVE_ALL_GPRS 0x10
	jal NameCache_reset
	nop
	jal Jobs_detachRows
	nop
	LOAD_ALL_GPRS 0x10
	jr $ra
	addiu $sp,$sp,0x200

.global Entry_initArenaNames
Entry_initArenaNames:
	addiu $sp,$sp,-16
	sd $ra,0($sp)
	jal Entry_resetNames
	nop
	ld $ra,0($sp)
	addiu $sp,$sp,16
	j Game_arenaInitMutex
	nop

.global Entry_resetArenaNames
Entry_resetArenaNames:
	addiu $sp,$sp,-16
	sd $ra,0($sp)
	jal Entry_resetNames
	nop
	ld $ra,0($sp)
	addiu $sp,$sp,16
	lui $v0,%lo(Game_nameArena_rawHi)
	lui $a0,%lo(Game_nameArena_rawHi)
	j Game_arenaResetResume
	nop

.section .hook.NameArenaInit,"ax",@progbits
	jal Entry_initArenaNames
.section .hook.NameArenaReset,"ax",@progbits
	j Entry_resetArenaNames
	nop

.section .cloneBridge,"ax",@progbits
.global Entry_cloneNames
Entry_cloneNames:
	addiu $sp,$sp,-0x200
	SAVE_ALL_GPRS 0x10
	move $a0,$s0
	jal NameCache_clone
	move $a1,$s1
	LOAD_ALL_GPRS 0x10
	j Game_cloneNamesResume
	addiu $sp,$sp,0x200

.section .hook.CloneNames,"ax",@progbits
	j Entry_cloneNames
