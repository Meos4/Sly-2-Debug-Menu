.set noreorder
.set noat
.set gp=64
.option pic0
.section .profile.WideText,"ax",@progbits
.global WideText_init
WideText_init:
	lui $t0,%hi(Profile_textBuffer)
	addiu $t0,$t0,%lo(Profile_textBuffer)
	move $a3,$t0
	li $t1,127
.L_widen:
	lbu $v0,0($a1)
	sh $v0,0($t0)
	beqz $v0,.L_wide_done
	addiu $t0,$t0,2
	addiu $t1,$t1,-1
	bnez $t1,.L_widen
	addiu $a1,$a1,1
	sh $zero,0($t0)
.L_wide_done:
	move $a1,$a3
	lui $a0,%hi(Profile_textRecord)
	j Profile_nativeInitText
	addiu $a0,$a0,%lo(Profile_textRecord)
.global WideText_measure
WideText_measure:
	lui $a0,%hi(Profile_textRecord)
	j Profile_nativeMeasureText
	addiu $a0,$a0,%lo(Profile_textRecord)
.global WideText_draw
WideText_draw:
	lui $a0,%hi(Profile_textRecord)
	j Profile_nativeDrawText
	addiu $a0,$a0,%lo(Profile_textRecord)
