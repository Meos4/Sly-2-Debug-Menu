#include SLY_PROFILE_OFFSETS
.set noreorder
.set noat
.set gp=64
.set hardfloat
.option pic0
.section .native.MrdReset,"ax",@progbits
.global MrdReset_start
MrdReset_start:
	addiu	$sp,$sp,-32
	sq	$t0,0($sp)
	sq	$t1,16($sp)
	lui	$t0,%lo(Game_nativeCamera_rawHi)
	ori	$t0,$t0,%lo(Game_nativeCamera)
	bne	$s2,$t0,.L_resumeCameraReset
	sll	$zero,$zero,0x0
	lui	$t0,%lo(Mrd_mode_rawHi)
	ori	$t0,$t0,%lo(Mrd_mode)
	addiu	$t1,$zero,-1
	sw	$t1,0($t0)
.L_resumeCameraReset:
	lq	$t0,0($sp)
	lq	$t1,16($sp)
	sw	$v0,PROFILE_CAMERA_MRD_MODE($s2)
	swc1	$f0,PROFILE_CAMERA_MRD_VALUE($s2)
	j	Game_cameraResetResume
	addiu	$sp,$sp,32
