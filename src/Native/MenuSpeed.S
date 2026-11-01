.set noreorder
.set noat
.set gp=64
.set hardfloat
.option pic0
.section .native.MenuSpeed,"ax",@progbits
.global MenuActions_speed
MenuActions_speed:
	addiu $sp,$sp,-16
	lui $at,0x3C23
	ori $at,$at,0xD70A
	mtc1 $at,$f12
	sd $ra,0($sp)
	lui $v0,%hi(native_clock)
	addiu $v0,$v0,%lo(native_clock)
	addiu $a1,$zero,3
	lwc1 $f0,0x34($a0)
	cvt.s.w $f0,$f0
	lui $a0,%hi(Game_clock)
	addiu $a0,$a0,%lo(Game_clock)
	jalr $v0
	mul.s $f12,$f0,$f12
	ld $ra,0($sp)
	jr $ra
	addiu $sp,$sp,16
	nop
