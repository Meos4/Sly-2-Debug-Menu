#include "Common/Bridges.inc"
.set noreorder
.set noat
.set hardfloat
.option pic0
.section .entry,"ax",@progbits
.globl Entry_entry
.ent Entry_entry
Entry_entry:
	addiu $sp,$sp,-0x300
	SAVE_ALL_GPRS 0x40
	.set offset,0x220
	.irp reg,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
	  swc1 $f\reg,offset($sp)
	  .set offset,offset+4
	.endr
	pmfhi $8
	sq $8,0x2A0($sp)
	pmflo $8
	sq $8,0x2B0($sp)
	mfsa $8
	sw $8,0x2C0($sp)
	cfc1 $8,$31
	sw $8,0x2C4($sp)
	jal Menu_frame
	nop
	jal Menu_draw
	nop
	lq $8,0x2A0($sp)
	pmthi $8
	lq $8,0x2B0($sp)
	pmtlo $8
	lw $8,0x2C0($sp)
	mtsa $8
	lw $8,0x2C4($sp)
	ctc1 $8,$31
	.set offset,0x220
	.irp reg,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
	  lwc1 $f\reg,offset($sp)
	  .set offset,offset+4
	.endr
	LOAD_ALL_GPRS 0x40
	jr $ra
	addiu $sp,$sp,0x300
.end Entry_entry

.section .bridges,"ax",@progbits
.globl Entry_load
.ent Entry_load
Entry_load:
	lw $t0,16($sp)
	lw $t1,20($sp)
	j native_load
	nop
.end Entry_load
.globl Entry_clock
.ent Entry_clock
Entry_clock:
	mtc1 $a2,$f12
	j native_clock
	nop
.end Entry_clock

.global Entry_enumObjects
.ent Entry_enumObjects
Entry_enumObjects:
	lw $t0,16($sp)
	lw $t1,20($sp)
	j Game_enumEntrances
	nop
.end Entry_enumObjects

.global Entry_taskWalk
Entry_taskWalk:
	lw $t0,16($sp)
	j Game_taskWalk
	nop

.global Entry_taskName
Entry_taskName:
	move $a1,$s2
	j Destinations_capture
	nop
.global Entry_jobName
Entry_jobName:
	move $a1,$s1
	j Destinations_capture
	nop

.global Entry_characterLoad
Entry_characterLoad:
	CALLEE_SAVED_BRIDGE Character_load
