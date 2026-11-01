#include "Common/Buttons.h"
#include "Layout.h"
#include SLY_PROFILE_OFFSETS
.set noreorder
.set noat
.set gp=64
.set hardfloat
.option pic0
.section .native.PadCapture,"ax",@progbits
.global PadCapture_start
PadCapture_start:
	addiu	$sp,$sp,-80
	sd	$ra,32($sp)
	sq	$s0,16($sp)
	sq	$t2,48($sp)
	sq	$t3,64($sp)
	daddu	$s0,$a0,$zero
	jal	Game_readPad
	sll	$zero,$zero,0x0
	lui	$t0,%lo(Game_realPad_rawHi)
	ori	$t0,$t0,%lo(Game_realPad)
	bne	$s0,$t0,.L_restorePadRegisters
	sll	$zero,$zero,0x0
	lui	$t0,%lo(Pad_capture_rawHi)
	ori	$t0,$t0,%lo(Pad_capture)
	lw	$t1,PROFILE_PAD_HELD($s0)
	sw	$t1,0($t0)
	lw	$t1,4($t0)
	addiu	$t1,$t1,1
	sw	$t1,4($t0)
	sd	$v0,40($sp)
	lw	$t1,0xF8($t0)
	bnez	$t1,.L_menuOpenPad
	move	$a0,$s0
	j	.L_menuOpenStart
	nop
.L_menuConsumeStart:
	jal	Game_consumeButtons
	ori	$a1,$zero,PAD_START
	ld	$v0,40($sp)
.L_menuStartDone:
	lui	$t0,%lo(Orbit_pending_rawHi)
	ori	$t0,$t0,%lo(Orbit_pending)
	lw	$t2,8($t0)
	lw	$t1,PROFILE_PAD_HELD($s0)
	sw	$t1,8($t0)
	nor	$t2,$t2,$zero
	and	$t1,$t1,$t2
	andi	$t1,$t1,PAD_ORBIT_SWITCH
	lui	$t2,%lo(Game_activeControllerSlot_rawHi)
	ori	$t2,$t2,%lo(Game_activeControllerSlot)
	lw	$t2,0($t2)
	lui	$t3,%lo(Camera_controller_rawHi)
	ori	$t3,$t3,%lo(Camera_controller)
	bne	$t2,$t3,.L_clearOrbitButtons
	sll	$zero,$zero,0x0
	lw	$t2,16($t3)
	addiu	$t3,$zero,2
	bne	$t2,$t3,.L_clearOrbitButtons
	sll	$zero,$zero,0x0
	lui	$t2,%lo(Menu_open_rawHi)
	ori	$t2,$t2,%lo(Menu_open)
	lw	$t2,0($t2)
	bnez	$t2,.L_clearOrbitButtons
	sll	$zero,$zero,0x0
	lw	$t2,0($t0)
	or	$t1,$t1,$t2
	sw	$t1,0($t0)
	beqz	$zero,.L_restorePadRegisters
	sll	$zero,$zero,0x0
.L_clearOrbitButtons:
	sw	$zero,0($t0)
.L_restorePadRegisters:
	lq	$s0,16($sp)
	ld	$ra,32($sp)
	lq	$t2,48($sp)
	lq	$t3,64($sp)
	jr	$ra
	addiu	$sp,$sp,80

.section .native.MenuStart,"ax",@progbits
.L_menuOpenStart:
	lw	$t1,0xE0($t0)
	lui	$t2,%hi(MENU_INIT_MARKER)
	ori	$t2,$t2,%lo(MENU_INIT_MARKER)
	bne	$t1,$t2,.L_menuStartDone
	nop
	lw	$t1,0($t0)
	andi	$t1,$t1,PAD_MENU_CHORD
	ori	$t2,$zero,PAD_MENU_CHORD
	bne	$t1,$t2,.L_menuStartDone
	nop
	lw	$t1,0xF4($t0)
	andi	$t1,$t1,PAD_SELECT
	bnez	$t1,.L_menuStartDone
	nop
	j	.L_menuConsumeStart
	nop
.L_menuOpenPad:
	jal	Game_consumeButtons
	ori	$a1,$zero,PAD_START|PAD_SELECT|PAD_TRIANGLE|PAD_CROSS
	jal	Game_menuHorizontal
	move	$a0,$s0
	jal	Game_menuVertical
	move	$a0,$s0
	lui	$t0,%lo(Pad_capture_rawHi)
	ori	$t0,$t0,%lo(Pad_capture)
	sw	$v0,8($t0)
	j	.L_menuStartDone
	ld	$v0,40($sp)
