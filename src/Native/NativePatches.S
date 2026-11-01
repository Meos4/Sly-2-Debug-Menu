.set noreorder
.set noat
.set gp=64
.option pic0

.section .hook.JobName,"ax",@progbits
	jal Entry_jobName
.section .hook.CharacterNameLoad,"ax",@progbits
	jal Entry_characterLoad
.section .hook.CharacterNameSkip,"ax",@progbits
	nop
.section .hook.WarpNameLoad,"ax",@progbits
	jal Destinations_capture_entrance
.section .hook.WarpNameSkip,"ax",@progbits
	nop
.section .hook.MrdRegions,"ax",@progbits
	j MrdRegions_start
.section .hook.MrdRegionsSlot,"ax",@progbits
	nop
.section .hook.MrdRegionsPlayer,"ax",@progbits
	jal MrdPlayer_start
.section .hook.MrdRegionsSecond,"ax",@progbits
	j MrdRegionsSecond_start
.section .hook.MrdRegionsSecondSlot,"ax",@progbits
	nop
.section .hook.MrdRegionsSecondPlayer,"ax",@progbits
	jal MrdPlayer_start
.section .hook.MrdReset,"ax",@progbits
	j MrdReset_start
.section .hook.MrdResetSlot,"ax",@progbits
	nop
.section .hook.MrdDistance,"ax",@progbits
	j MrdDistance_start
.section .hook.MrdDistanceSlot,"ax",@progbits
	nop
.section .hook.ClockSpeed,"ax",@progbits
	nop
.section .hook.TaskName,"ax",@progbits
	jal Entry_taskName
.section .boot.hook.MrdGeometryFirst,"ax",@progbits
	j MrdGeometryFirst_start
.section .boot.hook.MrdGeometryFirstSlot,"ax",@progbits
	nop
.section .boot.hook.MrdGeometrySecond,"ax",@progbits
	j MrdGeometrySecond_start
.section .boot.hook.MrdGeometrySecondSlot,"ax",@progbits
	nop
.section .hook.PadCapture,"ax",@progbits
	jal PadCapture_start
.section .hook.CameraActive,"ax",@progbits
	j CameraActive_start
.section .hook.CameraActiveSlot,"ax",@progbits
	nop
.section .hook.PadFold,"ax",@progbits
	jal PadFold_start
.section .hook.PadFoldSlot,"ax",@progbits
	nop
.section .boot.hook.MrdGeometryThird,"ax",@progbits
	j MrdGeometryThird_start
.section .boot.hook.MrdGeometryThirdSlot,"ax",@progbits
	nop
.section .hook.MenuTick,"ax",@progbits
	jal Entry_entry
.section .hook.EntranceName,"ax",@progbits
	jal Destinations_capture_entrance
.section .hook.EntranceNameSkip,"ax",@progbits
	nop
.section .boot.hook.MrdMicrocode,"ax",@progbits
	# mul.xyz vf21,vf26,vf26 (was vf18)
	.word 0x01DAD56A
