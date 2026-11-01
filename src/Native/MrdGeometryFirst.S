.set noreorder
.set noat
.set gp=64
.set hardfloat
.option pic0
.section .boot.MrdGeometryFirst,"ax",@progbits
.global MrdGeometryFirst_start
MrdGeometryFirst_start:
	addiu	$sp,$sp,-32
	sq	$t0,0($sp)
	.word 0xFBBA0010
	lui	$t0,%lo(Mrd_mode_rawHi)
	ori	$t0,$t0,%lo(Mrd_mode)
	lw	$t0,0($t0)
	bnez	$t0,.L_livePosition
	sll	$zero,$zero,0x0
	lui	$t0,%lo(Mrd_position_rawHi)
	ori	$t0,$t0,%lo(Mrd_position)
	.word 0xD91A0000
	.word 0x4BFA7EAC
	beqz	$zero,.L_runGeometry
	sll	$zero,$zero,0x0
.L_livePosition:
	.word 0x4BED7EAC
.L_runGeometry:
	.word 0x4A000E38
	.word 0x48400001
	.word 0xDBBA0010
	lq	$t0,0($sp)
	addiu	$sp,$sp,32
	.word 0x48400001
	j	Game_geometryFirstResume
	sll	$zero,$zero,0x0
