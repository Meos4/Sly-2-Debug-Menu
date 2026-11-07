#include SLY_PROFILE_OFFSETS
.set noreorder
.set noat
.set gp=64
.set hardfloat
.option pic0
.section .native.CameraActive,"ax",@progbits
.global CameraActive_start
CameraActive_start:
	lui	$v1,%lo(Game_activeControllerSlot_rawHi)
	ori	$v1,$v1,%lo(Game_activeControllerSlot)
	lw	$v1,0($v1)
	beq	$v1,$a0,.L_controllerActive
	lui	$v0,%lo(Game_nativeCamera_rawHi)
	ori	$v0,$v0,%lo(Game_nativeCamera)
	addiu	$v0,$v0,PROFILE_CAMERA_DEBUG_CONTROLLER
	bne	$a0,$v0,.L_controllerInactive
	lui	$v0,%lo(Camera_controller_rawHi)
	ori	$v0,$v0,%lo(Camera_controller)
	beq	$v1,$v0,.L_controllerActive
	sll	$zero,$zero,0x0
.L_controllerInactive:
	jr	$ra
	daddu	$v0,$zero,$zero
.L_controllerActive:
	jr	$ra
	addiu	$v0,$zero,1

.global PadFold_start
PadFold_start:
	lw	$v1,PROFILE_CAMERA_ACTIVE_CONTROLLER($v0)
	addiu	$v0,$v0,PROFILE_CAMERA_DEBUG_CONTROLLER
	beq	$v1,$v0,.L_foldCompared
	sll	$zero,$zero,0x0
	lui	$v0,%lo(Camera_controller_rawHi)
	ori	$v0,$v0,%lo(Camera_controller)
.L_foldCompared:
	jr	$ra
	sll	$zero,$zero,0x0

.global CameraPad_start
CameraPad_start:
	lui	$v0,%lo(Menu_open_rawHi)
	ori	$v0,$v0,%lo(Menu_open)
	lw	$v0,0($v0)
	bnez	$v0,.L_padChosen
	sll	$zero,$zero,0x0
	lui	$s4,%lo(Game_realPad_rawHi)
	ori	$s4,$s4,%lo(Game_realPad)
.L_padChosen:
	jr	$ra
	sll	$zero,$zero,0x0
