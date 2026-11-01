#include SLY_PROFILE_OFFSETS
.set noreorder
.set noat
.set gp=64
.set hardfloat
.option pic0
.section .native.CameraQuery,"ax",@progbits
.global CameraQuery_start
CameraQuery_start:
	lw	$v0,PROFILE_CAMERA_CONTROLLER_COUNT($a0)
	daddu	$v1,$zero,$zero
	blez	$v0,.L_controllerNotFound
	addiu	$a0,$a0,PROFILE_CAMERA_CONTROLLER_ARRAY
	daddu	$t1,$v0,$zero
	sll	$zero,$zero,0x0
.L_findController:
	lw	$v0,0($a0)
	bnel	$a1,$v0,.L_checkNextController
	addiu	$v1,$v1,1
	lw	$v0,4($a0)
	bne	$a2,$v0,.L_checkNextController
	addiu	$v1,$v1,1
	lw	$v0,8($a0)
	bne	$a3,$v0,.L_checkNextController
	sll	$zero,$zero,0x0
	lw	$v0,12($a0)
	bne	$t0,$v0,.L_advanceController
	slt	$v0,$v1,$t1
	jr	$ra
	addiu	$v0,$zero,1
.L_checkNextController:
	slt	$v0,$v1,$t1
.L_advanceController:
	bnez	$v0,.L_findController
	addiu	$a0,$a0,16
.L_controllerNotFound:
	jr	$ra
	daddu	$v0,$zero,$zero
	sll	$zero,$zero,0x0
