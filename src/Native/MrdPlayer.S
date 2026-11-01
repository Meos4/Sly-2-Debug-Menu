.set noreorder
.set noat
.set gp=64
.set hardfloat
.option pic0
.section .native.MrdPlayer,"ax",@progbits
.global MrdPlayer_start
MrdPlayer_start:
	addiu	$sp,$sp,-16
	sq	$t0,0($sp)
	lui	$t0,%lo(Mrd_mode_rawHi)
	ori	$t0,$t0,%lo(Mrd_mode)
	lw	$t0,0($t0)
	bnez	$t0,.L_readPlayerPosition
	sll	$zero,$zero,0x0
	lq	$t0,0($sp)
	addiu	$sp,$sp,16
	jr	$ra
	daddu	$v0,$zero,$zero
.L_readPlayerPosition:
	lq	$t0,0($sp)
	addiu	$sp,$sp,16
	j	Game_getPlayerPosition
	sll	$zero,$zero,0x0
