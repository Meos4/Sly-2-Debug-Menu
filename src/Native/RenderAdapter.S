.set noreorder
.set noat
.set gp=64
.set hardfloat
.option pic0
.section .native.RenderAdapter,"ax",@progbits
.global RenderAdapter_start
RenderAdapter_start:
	addiu	$sp,$sp,-32
	sd	$ra,16($sp)
	lui	$t0,%lo(Menu_control_rawHi)
	ori	$t0,$t0,%lo(Menu_control)
	lw	$t1,8($t0)
	beqz	$t1,.L_drawReturn
	sll	$zero,$zero,0x0
	lui	$t0,%lo(Game_displayContext_rawHi)
	ori	$t0,$t0,%lo(Game_displayContext)
	lw	$t1,12($t0)
	beqz	$t1,.L_drawReturn
	sll	$zero,$zero,0x0
	lw	$t1,76($t0)
	beqz	$t1,.L_drawReturn
	sll	$zero,$zero,0x0
	lui	$t0,%lo(Game_fontContext_rawHi)
	ori	$t0,$t0,%lo(Game_fontContext)
	lw	$t1,0($t0)
	beqz	$t1,.L_drawReturn
	sll	$zero,$zero,0x0
	lw	$t2,312($t1)
	beqz	$t2,.L_drawReturn
	sll	$zero,$zero,0x0
	lw	$t2,316($t1)
	beqz	$t2,.L_drawReturn
	sll	$zero,$zero,0x0
	lui $a0,%lo(Menu_stack_rawHi)
	ori $a0,$a0,%lo(Menu_stack)
	jal PrototypeRender_start
	nop
.L_drawReturn:
	ld	$ra,16($sp)
	jr	$ra
	addiu	$sp,$sp,32

.global RenderAdapter_end
RenderAdapter_end:
