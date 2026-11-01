.set noreorder
.set noat
.set gp=64
.set hardfloat
.option pic0
.section .native.MrdRegions,"ax",@progbits
.global MrdRegions_start
MrdRegions_start:
	addiu	$sp,$sp,-16
	sq	$t0,0($sp)
	lui	$t0,%lo(Mrd_mode_rawHi)
	ori	$t0,$t0,%lo(Mrd_mode)
	lw	$t0,0($t0)
	bnez	$t0,.L_readLiveRegions
	sll	$zero,$zero,0x0
	lui	$t0,%lo(Mrd_mask_rawHi)
	ori	$t0,$t0,%lo(Mrd_mask)
	lw	$s5,0($t0)
	lui	$t0,%lo(Mrd_position_rawHi)
	ori	$t0,$t0,%lo(Mrd_position)
	lq	$v0,0($t0)
	beqz	$zero,.L_resumeRegions
	sll	$zero,$zero,0x0
.L_readLiveRegions:
	lw	$s5,20($v0)
	lq	$v0,144($v0)
.L_resumeRegions:
	lq	$t0,0($sp)
	j	Game_regionsFirstResume
	addiu	$sp,$sp,16
