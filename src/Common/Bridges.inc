/* Every GPR except $0 and $sp, as 128-bit values */
.macro SAVE_ALL_GPRS base
	.set offset,\base
	.irp reg,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,30,31
		sq $\reg,offset($sp)
		.set offset,offset+16
	.endr
.endm

.macro LOAD_ALL_GPRS base
	.set offset,\base
	.irp reg,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,30,31
		lq $\reg,offset($sp)
		.set offset,offset+16
	.endr
.endm

/* Calls C code from a native caller that relies on the upper half of its saved registers */
.macro CALLEE_SAVED_BRIDGE target
	addiu $sp,$sp,-0xB0
	sd $ra,0xA0($sp)
	.set offset,0x10
	.irp reg,16,17,18,19,20,21,22,23,30
		sq $\reg,offset($sp)
		.set offset,offset+16
	.endr
	jal \target
	nop
	.set offset,0x10
	.irp reg,16,17,18,19,20,21,22,23,30
		lq $\reg,offset($sp)
		.set offset,offset+16
	.endr
	ld $ra,0xA0($sp)
	jr $ra
	addiu $sp,$sp,0xB0
.endm
