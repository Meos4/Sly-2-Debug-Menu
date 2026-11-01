#include SLY_PROFILE_OFFSETS
.set noreorder
.set noat
.set gp=64
.set hardfloat
.option pic0
.section .native.CameraPressure,"ax",@progbits
.global CameraPressure_start
CameraPressure_start:
	lui	$v0,%lo(Camera_pressureMasks_signedHi)
	sll	$v1,$a1,0x1
	addiu	$v0,$v0,%lo(Camera_pressureMasks)
	daddu	$a2,$a0,$zero
	addu	$v1,$v1,$v0
	lhu	$a0,0($v1)
	lw	$v0,PROFILE_PAD_HELD($a2)
	and	$v0,$v0,$a0
	beqz	$v0,.L_pressureReleased
	sll	$zero,$zero,0x0
	lw	$v0,PROFILE_PAD_STATE($a2)
	slti	$v0,$v0,PROFILE_PAD_STATE_PRESSURE
	bnez	$v0,.L_digitalPressure
	addu	$v1,$a2,$a1
	addiu	$v0,$zero,1
	lbu	$a0,PROFILE_PAD_PRESSURE($v1)
	lui	$at,0x3b80
	ori	$at,$at,0x8081
	mtc1	$at,$f1
	slt	$v1,$v0,$a0
	movn	$v0,$a0,$v1
	mtc1	$v0,$f0
	cvt.s.w	$f0,$f0
	jr	$ra
	mul.s	$f0,$f0,$f1
.L_digitalPressure:
	lui	$at,0x3f80
	mtc1	$at,$f0
	jr	$ra
	sll	$zero,$zero,0x0
.L_pressureReleased:
	mtc1	$zero,$f0
	jr	$ra
	sll	$zero,$zero,0x0
.global Camera_noop
Camera_noop:
	jr	$ra
	sll	$zero,$zero,0x0
