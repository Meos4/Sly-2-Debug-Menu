#include SLY_PROFILE_OFFSETS
.set noreorder
.set noat
.set gp=64
.set hardfloat
.option pic0
.section .native.CameraBegin,"ax",@progbits
.global CameraBegin_start
CameraBegin_start:
	sw	$zero,PROFILE_CONTROLLER_TARGET($a0)
	jr	$ra
	sll	$zero,$zero,0x0
	sll	$zero,$zero,0x0
