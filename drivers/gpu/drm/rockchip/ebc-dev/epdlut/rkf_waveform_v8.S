// SPDX-License-Identifier: GPL-2.0
/*
 * Copyright (c) 2020 Rockchip Electronics Co. Ltd.
 *
 * Author: Zorro Liu <zorro.liu@rock-chips.com>
 */

	.text
	.file	"rkf_waveform.c"
	.file	1 "/home/lyx/rk-android14/kernel-6.1" "drivers/gpu/drm/rockchip/ebc-dev/epdlut/epd_lut.h"
	.file	2 "/home/lyx/rk-android14/kernel-6.1" "drivers/gpu/drm/rockchip/ebc-dev/epdlut/rkf_waveform.c"
	.file	3 "/home/lyx/rk-android14/kernel-6.1" "./include/linux/stddef.h"
	.file	4 "/home/lyx/rk-android14/kernel-6.1" "./include/linux/slab.h"
	.file	5 "/home/lyx/rk-android14/kernel-6.1" "./include/uapi/asm-generic/int-ll64.h"
	.file	6 "/home/lyx/rk-android14/kernel-6.1" "./include/asm-generic/int-ll64.h"
	.file	7 "/home/lyx/rk-android14/kernel-6.1" "./include/linux/types.h"
	.globl	rkf_wf_input
	.p2align	2
	.type	rkf_wf_input,@function
rkf_wf_input:
.Lfunc_begin0:
	.loc	2 128 0
	.cfi_sections .debug_frame
	.cfi_startproc
	str	x30, [x18], #8
	.cfi_escape 0x16, 0x12, 0x02, 0x82, 0x78
	stp	x29, x30, [sp, #-64]!
	stp	x24, x23, [sp, #16]
	mov	x29, sp
	stp	x22, x21, [sp, #32]
	stp	x20, x19, [sp, #48]
	.cfi_def_cfa w29, 64
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w30, -56
	.cfi_offset w29, -64
.Ltmp0:
	.loc	2 132 6 prologue_end
	adrp	x22, global_waveform
	ldr	x8, [x22, :lo12:global_waveform]
.Ltmp1:
	.loc	2 132 6 is_stmt 0
	cbz	x8, .LBB0_3
.Ltmp2:
	.loc	2 0 6
	mov	w0, #-16
.Ltmp3:
.LBB0_2:
	.loc	2 152 1 is_stmt 1
	ldp	x20, x19, [sp, #48]
	ldp	x22, x21, [sp, #32]
	ldp	x24, x23, [sp, #16]
	ldp	x29, x30, [sp], #64
	ldr	x30, [x18, #-8]!
	ret
.Ltmp4:
.LBB0_3:
	.loc	2 93 6
	adrp	x1, .L.str.5
	mov	x19, x0
.Ltmp5:
	.loc	2 135 28
	add	x0, x0, #4
.Ltmp6:
	.loc	2 93 6
	add	x1, x1, :lo12:.L.str.5
	mov	w2, #12
	bl	strncmp
.Ltmp7:
	.loc	2 93 6 is_stmt 0
	cbnz	w0, .LBB0_12
.Ltmp8:
	.loc	2 106 16 is_stmt 1
	ldr	w23, [x19]
.Ltmp9:
	.loc	2 106 6 is_stmt 0
	cmp	w23, #64, lsl #12
	b.gt	.LBB0_14
.Ltmp10:
	.loc	2 0 6
	sxtw	x8, w23
.Ltmp11:
	.loc	2 83 2 is_stmt 1
	adrp	x21, crc32_table
	add	x21, x21, :lo12:crc32_table
	mov	w1, wzr
	mov	x0, x21
	mov	w2, #1024
.Ltmp12:
	.loc	2 109 12
	ldr	w20, [x19, x8]
.Ltmp13:
	.loc	2 0 12 is_stmt 0
	mov	w24, #3511
	movk	w24, #1217, lsl #16
.Ltmp14:
	.loc	2 83 2 is_stmt 1
	bl	memset
.Ltmp15:
	.loc	2 0 2 is_stmt 0
	mov	w13, #28088
	mov	w14, #14044
	mov	w15, #7022
	mov	w8, wzr
	mov	w9, wzr
	mov	w10, wzr
	mov	w11, wzr
	mov	x12, xzr
	movk	w13, #9736, lsl #16
	movk	w14, #4868, lsl #16
	movk	w15, #2434, lsl #16
	mov	w16, #-2147483648
	mov	w17, #1073741824
	mov	w0, #536870912
	mov	w1, #268435456
.Ltmp16:
.LBB0_6:
	.loc	2 68 8 is_stmt 1
	lsl	w2, w12, #24
	tst	w12, #0x40
	and	w2, w13, w2, asr #31
.Ltmp17:
	eor	w3, w2, w14
	csel	w2, w2, w3, eq
	tst	w12, #0x20
	eor	w3, w2, w15
	csel	w2, w2, w3, eq
	tst	w12, #0x10
	eor	w3, w2, w24
	csel	w2, w2, w3, eq
.Ltmp18:
	.loc	2 68 16 is_stmt 0
	eor	w3, w2, w8
.Ltmp19:
	.loc	2 68 8
	lsl	w2, w2, #1
.Ltmp20:
	eor	w4, w2, w24
	cmp	w3, #0
	csel	w2, w2, w4, ge
.Ltmp21:
	.loc	2 64 16 is_stmt 1
	add	w8, w8, w1
.Ltmp22:
	.loc	2 68 16
	eor	w3, w2, w9
.Ltmp23:
	.loc	2 68 8 is_stmt 0
	lsl	w2, w2, #1
.Ltmp24:
	eor	w4, w2, w24
	cmp	w3, #0
	csel	w2, w2, w4, ge
.Ltmp25:
	.loc	2 64 16 is_stmt 1
	add	w9, w9, w0
.Ltmp26:
	.loc	2 68 16
	eor	w3, w2, w10
.Ltmp27:
	.loc	2 68 8 is_stmt 0
	lsl	w2, w2, #1
.Ltmp28:
	eor	w4, w2, w24
	cmp	w3, #0
	csel	w2, w2, w4, ge
.Ltmp29:
	.loc	2 64 16 is_stmt 1
	add	w10, w10, w17
.Ltmp30:
	.loc	2 68 16
	eor	w3, w2, w11
.Ltmp31:
	.loc	2 68 8 is_stmt 0
	lsl	w2, w2, #1
.Ltmp32:
	eor	w4, w2, w24
	cmp	w3, #0
	csel	w2, w2, w4, ge
.Ltmp33:
	.loc	2 64 16 is_stmt 1
	add	w11, w11, w16
.Ltmp34:
	.loc	2 74 16
	str	w2, [x21, x12, lsl #2]
.Ltmp35:
	.loc	2 64 24
	add	x12, x12, #1
.Ltmp36:
	.loc	2 64 2 is_stmt 0
	cmp	x12, #256
	b.ne	.LBB0_6
.Ltmp37:
	.loc	2 0 2
	mov	w2, wzr
.Ltmp38:
	.loc	2 85 2 is_stmt 1
	cbz	w23, .LBB0_10
.Ltmp39:
	.loc	2 0 2 is_stmt 0
	mov	x8, x19
.Ltmp40:
.LBB0_9:
	.loc	2 86 60 is_stmt 1
	ldrb	w9, [x8], #1
.Ltmp41:
	.loc	2 85 16
	subs	w23, w23, #1
	.loc	2 86 58
	eor	w9, w9, w2, lsr #24
	.loc	2 86 30 is_stmt 0
	ldr	w9, [x21, w9, uxtw #2]
	.loc	2 86 28
	eor	w2, w9, w2, lsl #8
.Ltmp42:
	.loc	2 85 2 is_stmt 1
	b.ne	.LBB0_9
.Ltmp43:
.LBB0_10:
	.loc	2 112 6
	cmp	w20, w2
	b.ne	.LBB0_13
.Ltmp44:
	.loc	2 147 2
	adrp	x0, .L.str.2
	add	x1, x19, #20
	add	x0, x0, :lo12:.L.str.2
	bl	_printk
.Ltmp45:
	.loc	2 0 2 is_stmt 0
	mov	w0, wzr
.Ltmp46:
	.loc	2 149 18 is_stmt 1
	str	x19, [x22, :lo12:global_waveform]
	b	.LBB0_2
.Ltmp47:
.LBB0_12:
	.loc	2 96 3
	adrp	x0, .L.str.6
	add	x0, x0, :lo12:.L.str.6
	bl	_printk
.Ltmp48:
	.loc	2 137 3
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	b	.LBB0_15
.Ltmp49:
.LBB0_13:
	.loc	2 113 3
	adrp	x0, .L.str.7
	mov	w1, w20
	add	x0, x0, :lo12:.L.str.7
	bl	_printk
.Ltmp50:
.LBB0_14:
	.loc	2 143 3
	adrp	x0, .L.str.1
	add	x0, x0, :lo12:.L.str.1
.Ltmp51:
.LBB0_15:
	.loc	2 0 0 is_stmt 0
	bl	_printk
.Ltmp52:
	mov	w0, #-1
	b	.LBB0_2
.Ltmp53:
.Lfunc_end0:
	.size	rkf_wf_input, .Lfunc_end0-rkf_wf_input
	.cfi_endproc

	.globl	rkf_wf_get_version
	.p2align	2
	.type	rkf_wf_get_version,@function
rkf_wf_get_version:
.Lfunc_begin1:
	.loc	2 161 0 is_stmt 1
	.cfi_startproc
	.loc	2 162 7 prologue_end
	adrp	x8, global_waveform
	ldr	x8, [x8, :lo12:global_waveform]
.Ltmp54:
	.loc	2 162 6 is_stmt 0
	add	x9, x8, #84
	cmp	x8, #0
	csel	x0, xzr, x9, eq
	.loc	2 166 1 is_stmt 1
	ret
.Ltmp55:
.Lfunc_end1:
	.size	rkf_wf_get_version, .Lfunc_end1-rkf_wf_get_version
	.cfi_endproc

	.globl	rkf_wf_get_lut
	.p2align	2
	.type	rkf_wf_get_lut,@function
rkf_wf_get_lut:
.Lfunc_begin2:
	.loc	2 595 0
	.cfi_startproc
	str	x30, [x18], #8
	.cfi_escape 0x16, 0x12, 0x02, 0x82, 0x78
	stp	x29, x30, [sp, #-80]!
	str	x25, [sp, #16]
	mov	x29, sp
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	.cfi_def_cfa w29, 80
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w25, -64
	.cfi_offset w30, -72
	.cfi_offset w29, -80
.Ltmp56:
	.loc	2 601 7 prologue_end
	adrp	x8, global_waveform
	ldr	x8, [x8, :lo12:global_waveform]
.Ltmp57:
	.loc	2 601 6 is_stmt 0
	cbz	x8, .LBB2_22
.Ltmp58:
	.loc	2 0 6
	mov	x20, x0
.Ltmp59:
	.loc	2 604 6 is_stmt 1
	cbz	x0, .LBB2_23
.Ltmp60:
	.loc	2 607 6
	cmp	w3, #32
	b.eq	.LBB2_30
.Ltmp61:
	.loc	2 618 28
	adrp	x23, rkf_wf_get_lut.sftemp
	.loc	2 618 19 is_stmt 0
	mov	w8, #26215
	movk	w8, #26214, lsl #16
.Ltmp62:
	.loc	2 612 6 is_stmt 1
	cmp	w1, #8
	mov	w11, #5
	mov	w19, w2
.Ltmp63:
	.loc	2 618 28
	ldrsw	x9, [x23, :lo12:rkf_wf_get_lut.sftemp]
	.loc	2 618 19 is_stmt 0
	smull	x10, w2, w8
.Ltmp64:
	.loc	2 612 6 is_stmt 1
	csel	w21, w11, w1, eq
.Ltmp65:
	.loc	2 0 6 is_stmt 0
	adrp	x25, rkf_wf_get_lut.stype
.Ltmp66:
	.loc	2 618 35 is_stmt 1
	mul	x8, x9, x8
	.loc	2 618 19 is_stmt 0
	lsr	x9, x10, #63
	asr	x10, x10, #33
	add	w24, w10, w9
	.loc	2 618 35
	lsr	x9, x8, #63
	asr	x8, x8, #33
	add	w8, w8, w9
	.loc	2 618 41
	cmp	w24, w8
	b.ne	.LBB2_5
.Ltmp67:
	.loc	2 0 41
	ldr	w9, [x25, :lo12:rkf_wf_get_lut.stype]
	.loc	2 618 41
	cmp	w9, w21
	b.eq	.LBB2_74
.Ltmp68:
.LBB2_5:
	.loc	2 621 6 is_stmt 1
	cmp	w21, #10
	b.eq	.LBB2_73
.Ltmp69:
	.loc	2 623 15
	ldr	x0, [x20, #8]
.Ltmp70:
	.loc	2 623 7 is_stmt 0
	cbz	x0, .LBB2_8
.Ltmp71:
	.loc	2 624 4 is_stmt 1
	bl	kfree
.Ltmp72:
	.loc	2 625 17
	str	xzr, [x20, #8]
.Ltmp73:
.LBB2_8:
	.loc	2 628 15
	mov	x0, x20
	mov	w1, w21
	mov	w2, w19
	bl	parse_wf_data
.Ltmp74:
	.loc	2 629 7
	tbnz	w0, #31, .LBB2_80
.Ltmp75:
	.loc	2 0 0 is_stmt 0
	mov	w22, w0
.Ltmp76:
	.loc	2 633 33 is_stmt 1
	ldr	x1, [x20, #16]
	.loc	2 633 3 is_stmt 0
	mov	x0, x20
	mov	w2, w22
	bl	rkf_lut_init_wf_table
.Ltmp77:
	.loc	2 635 7 is_stmt 1
	cmp	w21, #1
	b.eq	.LBB2_24
.Ltmp78:
	cmp	w21, #7
	b.ne	.LBB2_72
.Ltmp79:
	.loc	2 537 2
	cbz	w22, .LBB2_72
.Ltmp80:
	.loc	2 537 16 is_stmt 0
	mov	w10, w22
	mov	x9, xzr
.Ltmp81:
	.loc	2 0 0
	ldr	x8, [x20, #16]
.Ltmp82:
	.loc	2 537 2
	lsl	x10, x10, #10
.Ltmp83:
.LBB2_13:
	.loc	2 538 20 is_stmt 1
	add	x11, x8, w9, sxtw
.Ltmp84:
	.loc	2 537 16
	add	x9, x9, #1024
.Ltmp85:
	.loc	2 537 2 is_stmt 0
	cmp	x10, x9
.Ltmp86:
	.loc	2 539 38 is_stmt 1
	ldrb	w12, [x11, #960]
	.loc	2 541 38
	ldrb	w13, [x11, #30]
	.loc	2 539 36
	strb	w12, [x11, #992]
	.loc	2 540 36
	strb	w12, [x11, #928]
	.loc	2 541 36
	strb	w13, [x11, #62]
.Ltmp87:
	.loc	2 537 2
	b.ne	.LBB2_13
.Ltmp88:
	.loc	2 0 2 is_stmt 0
	sub	w9, w22, #1
.Ltmp89:
	.loc	2 544 2 is_stmt 1
	cmp	w9, #1
	b.lt	.LBB2_19
.Ltmp90:
	cmp	w9, #1
	b.ne	.LBB2_31
.Ltmp91:
	.loc	2 0 2 is_stmt 0
	mov	x10, xzr
.Ltmp92:
.LBB2_17:
	.loc	2 544 2
	sub	x9, x9, x10
	lsl	w10, w10, #10
	mov	w11, #2
	mov	w12, #1
.Ltmp93:
.LBB2_18:
	.loc	2 545 20 is_stmt 1
	add	x13, x8, w10, sxtw
.Ltmp94:
	.loc	2 544 16
	subs	x9, x9, #1
	add	w10, w10, #1024
.Ltmp95:
	.loc	2 546 36
	strb	w11, [x13, #1022]
	.loc	2 547 36
	strb	w12, [x13, #32]
.Ltmp96:
	.loc	2 544 2
	b.ne	.LBB2_18
.Ltmp97:
.LBB2_19:
	.loc	2 0 2 is_stmt 0
	sub	w9, w22, #3
.Ltmp98:
	.loc	2 550 2 is_stmt 1
	cmp	w9, #4
	b.lt	.LBB2_72
.Ltmp99:
	.loc	2 0 2 is_stmt 0
	add	x8, x8, #958
.Ltmp100:
	.loc	2 550 2
	sub	x11, x9, #3
	cmp	x11, #2
	b.hs	.LBB2_41
.Ltmp101:
	.loc	2 0 2
	mov	w10, #3
	b	.LBB2_47
.Ltmp102:
.LBB2_22:
	mov	w0, #-19
.Ltmp103:
	b	.LBB2_79
.Ltmp104:
.LBB2_23:
	mov	w0, #-22
	b	.LBB2_79
.Ltmp105:
.LBB2_24:
	.loc	2 563 2 is_stmt 1
	cbz	w22, .LBB2_72
.Ltmp106:
	.loc	2 563 16 is_stmt 0
	mov	w10, w22
	mov	x9, xzr
.Ltmp107:
	.loc	2 0 0
	ldr	x8, [x20, #16]
.Ltmp108:
	.loc	2 563 2
	lsl	x10, x10, #10
.Ltmp109:
.LBB2_26:
	.loc	2 564 20 is_stmt 1
	add	x11, x8, w9, sxtw
.Ltmp110:
	.loc	2 563 16
	add	x9, x9, #1024
.Ltmp111:
	.loc	2 563 2 is_stmt 0
	cmp	x10, x9
.Ltmp112:
	.loc	2 565 38 is_stmt 1
	ldrb	w12, [x11, #960]
	.loc	2 567 38
	ldrb	w13, [x11, #30]
	.loc	2 565 36
	strb	w12, [x11, #992]
	.loc	2 566 36
	strb	w12, [x11, #928]
	.loc	2 567 36
	strb	w13, [x11, #62]
.Ltmp113:
	.loc	2 563 2
	b.ne	.LBB2_26
.Ltmp114:
	.loc	2 0 2 is_stmt 0
	sub	w9, w22, #4
.Ltmp115:
	.loc	2 570 2 is_stmt 1
	cmp	w9, #5
	b.lt	.LBB2_61
.Ltmp116:
	sub	x11, x9, #4
.Ltmp117:
	cmp	x11, #2
	b.hs	.LBB2_49
.Ltmp118:
	.loc	2 0 2 is_stmt 0
	mov	w10, #4
	b	.LBB2_59
.Ltmp119:
.LBB2_30:
	.loc	2 608 3 is_stmt 1
	adrp	x0, .L.str.3
	add	x0, x0, :lo12:.L.str.3
	bl	_printk
.Ltmp120:
	.loc	2 0 3 is_stmt 0
	mov	w0, #-22
	b	.LBB2_79
.Ltmp121:
.LBB2_31:
	.loc	2 544 2 is_stmt 1
	sub	x12, x9, #1
	mov	x10, xzr
	and	x11, x12, #0xffffffff
.Ltmp122:
	lsl	x14, x11, #10
	tst	x14, #0xffffffff00000000
	cset	w13, ne
	cmp	xzr, x12, lsr #54
	cset	w11, ne
	tbnz	w14, #31, .LBB2_17
.Ltmp123:
	.loc	2 0 2 is_stmt 0
	tbnz	w13, #0, .LBB2_17
.Ltmp124:
	lsr	x13, x12, #32
	cbnz	x13, .LBB2_17
.Ltmp125:
	add	x13, x8, #1022
	lsl	x12, x12, #10
	add	x14, x13, x12
	cmp	x14, x13
	b.lo	.LBB2_17
.Ltmp126:
	tbnz	w11, #0, .LBB2_17
.Ltmp127:
	add	x13, x8, #32
	add	x12, x13, x12
	cmp	x12, x13
	b.lo	.LBB2_17
.Ltmp128:
	tbnz	w11, #0, .LBB2_17
.Ltmp129:
	.loc	2 544 2
	and	x10, x9, #0xfffffffe
	mov	w11, #1024
	mov	w12, #2
	mov	w13, #1
	mov	x14, x10
.Ltmp130:
.LBB2_39:
	.loc	2 544 34
	sub	w15, w11, #1024
	add	x16, x8, w11, sxtw
	subs	x14, x14, #2
	add	w11, w11, #2048
	add	x15, x8, w15, sxtw
	strb	w12, [x16, #1022]
	strb	w13, [x16, #32]
	strb	w12, [x15, #1022]
	strb	w13, [x15, #32]
	b.ne	.LBB2_39
.Ltmp131:
	.loc	2 544 2
	cmp	x10, x9
	b.ne	.LBB2_17
	b	.LBB2_19
.Ltmp132:
.LBB2_41:
	.loc	2 550 2 is_stmt 1
	sub	x12, x9, #4
	and	x10, x12, #0xffffffff
	lsl	x14, x10, #10
	mov	w10, #58367
	tst	x14, #0xffffffff00000000
	movk	w10, #32767, lsl #16
	cset	w13, ne
	orr	w15, w10, #0x1000
	mov	w10, #3
	cmp	w14, w15
	b.hi	.LBB2_47
.Ltmp133:
	.loc	2 0 2 is_stmt 0
	tbnz	w13, #0, .LBB2_47
.Ltmp134:
	lsr	x12, x12, #32
	cbnz	x12, .LBB2_47
.Ltmp135:
	.loc	2 550 2
	and	x12, x11, #0xfffffffffffffffe
	mov	w13, #4096
	add	x10, x12, #3
	mov	w14, #2
	mov	x15, x12
.Ltmp136:
.LBB2_45:
	.loc	2 551 25 is_stmt 1
	sub	w16, w13, #1024
	.loc	2 552 36
	strb	w14, [x8, w13, sxtw]
	add	w13, w13, #2048
	subs	x15, x15, #2
	strb	w14, [x8, w16, sxtw]
	b.ne	.LBB2_45
.Ltmp137:
	.loc	2 550 2
	cmp	x11, x12
	b.eq	.LBB2_72
.Ltmp138:
.LBB2_47:
	sub	x9, x9, x10
	lsl	w10, w10, #10
	mov	w11, #2
.Ltmp139:
.LBB2_48:
	.loc	2 552 36
	strb	w11, [x8, w10, sxtw]
.Ltmp140:
	.loc	2 550 16
	subs	x9, x9, #1
	add	w10, w10, #1024
.Ltmp141:
	.loc	2 550 2 is_stmt 0
	b.ne	.LBB2_48
	b	.LBB2_72
.Ltmp142:
.LBB2_49:
	.loc	2 570 2 is_stmt 1
	sub	x13, x9, #5
	and	x10, x13, #0xffffffff
	lsl	x15, x10, #10
	mov	w10, #58367
	tst	x15, #0xffffffff00000000
	movk	w10, #32767, lsl #16
	cset	w14, ne
	cmp	xzr, x13, lsr #54
	orr	w16, w10, #0xc00
	cset	w12, ne
	mov	w10, #4
	cmp	w15, w16
	b.hi	.LBB2_59
.Ltmp143:
	.loc	2 0 2 is_stmt 0
	tbnz	w14, #0, .LBB2_59
.Ltmp144:
	lsr	x14, x13, #32
	cbnz	x14, .LBB2_59
.Ltmp145:
	mov	w14, #5118
	lsl	x13, x13, #10
	add	x14, x8, x14
	add	x15, x14, x13
	cmp	x15, x14
	b.lo	.LBB2_59
.Ltmp146:
	tbnz	w12, #0, .LBB2_59
.Ltmp147:
	mov	w14, #4128
	add	x14, x8, x14
	add	x13, x14, x13
	cmp	x13, x14
	b.lo	.LBB2_59
.Ltmp148:
	tbnz	w12, #0, .LBB2_59
.Ltmp149:
	.loc	2 570 2
	and	x12, x11, #0xfffffffffffffffe
	mov	w13, #5120
	add	x10, x12, #4
	mov	w14, #2
	mov	w15, #1
	mov	x16, x12
.Ltmp150:
.LBB2_57:
	.loc	2 571 25 is_stmt 1
	sub	w17, w13, #1024
	.loc	2 571 20 is_stmt 0
	add	x0, x8, w13, sxtw
	add	w13, w13, #2048
	subs	x16, x16, #2
	add	x17, x8, w17, sxtw
	.loc	2 572 36 is_stmt 1
	strb	w14, [x0, #1022]
	.loc	2 573 36
	strb	w15, [x0, #32]
	.loc	2 572 36
	strb	w14, [x17, #1022]
	.loc	2 573 36
	strb	w15, [x17, #32]
	b.ne	.LBB2_57
.Ltmp151:
	.loc	2 570 2
	cmp	x11, x12
	b.eq	.LBB2_61
.Ltmp152:
.LBB2_59:
	sub	x9, x9, x10
	lsl	w10, w10, #10
	mov	w11, #2
	mov	w12, #1
.Ltmp153:
.LBB2_60:
	.loc	2 571 20
	add	x13, x8, w10, sxtw
.Ltmp154:
	.loc	2 570 16
	subs	x9, x9, #1
	add	w10, w10, #1024
.Ltmp155:
	.loc	2 572 36
	strb	w11, [x13, #1022]
	.loc	2 573 36
	strb	w12, [x13, #32]
.Ltmp156:
	.loc	2 570 2
	b.ne	.LBB2_60
.Ltmp157:
.LBB2_61:
	.loc	2 0 2 is_stmt 0
	sub	w9, w22, #7
.Ltmp158:
	.loc	2 576 2 is_stmt 1
	cmp	w9, #8
	b.lt	.LBB2_72
.Ltmp159:
	.loc	2 0 2 is_stmt 0
	add	x8, x8, #958
.Ltmp160:
	.loc	2 576 2
	sub	x11, x9, #7
	cmp	x11, #2
	b.hs	.LBB2_64
.Ltmp161:
	.loc	2 0 2
	mov	w10, #7
	b	.LBB2_70
.Ltmp162:
.LBB2_64:
	.loc	2 576 2
	sub	x12, x9, #8
	mov	w15, #58367
	and	x10, x12, #0xffffffff
	movk	w15, #32767, lsl #16
	lsl	x14, x10, #10
	mov	w10, #7
	tst	x14, #0xffffffff00000000
	cset	w13, ne
	cmp	w14, w15
	b.hi	.LBB2_70
.Ltmp163:
	.loc	2 0 2
	tbnz	w13, #0, .LBB2_70
.Ltmp164:
	lsr	x12, x12, #32
	cbnz	x12, .LBB2_70
.Ltmp165:
	.loc	2 576 2
	and	x12, x11, #0xfffffffffffffffe
	mov	w13, #8192
	add	x10, x12, #7
	mov	w14, #2
	mov	x15, x12
.Ltmp166:
.LBB2_68:
	.loc	2 577 25 is_stmt 1
	sub	w16, w13, #1024
	.loc	2 578 36
	strb	w14, [x8, w13, sxtw]
	add	w13, w13, #2048
	subs	x15, x15, #2
	strb	w14, [x8, w16, sxtw]
	b.ne	.LBB2_68
.Ltmp167:
	.loc	2 576 2
	cmp	x11, x12
	b.eq	.LBB2_72
.Ltmp168:
.LBB2_70:
	sub	x9, x9, x10
	lsl	w10, w10, #10
	mov	w11, #2
.Ltmp169:
.LBB2_71:
	.loc	2 578 36
	strb	w11, [x8, w10, sxtw]
.Ltmp170:
	.loc	2 576 16
	subs	x9, x9, #1
	add	w10, w10, #1024
.Ltmp171:
	.loc	2 576 2 is_stmt 0
	b.ne	.LBB2_71
.Ltmp172:
.LBB2_72:
	.loc	2 640 21 is_stmt 1
	ldrb	w8, [x20, #1]
	mov	w9, #26215
	movk	w9, #26214, lsl #16
	.loc	2 641 21
	orr	w8, w22, w8, lsl #8
	str	w8, [x20]
.Ltmp173:
	.loc	2 645 27
	ldrsw	x8, [x23, :lo12:rkf_wf_get_lut.sftemp]
.Ltmp174:
	.loc	2 642 9
	str	w21, [x25, :lo12:rkf_wf_get_lut.stype]
.Ltmp175:
	.loc	2 645 34
	mul	x8, x8, x9
	lsr	x9, x8, #63
	asr	x8, x8, #33
	add	w8, w8, w9
.Ltmp176:
.LBB2_73:
	.loc	2 645 6 is_stmt 0
	cmp	w24, w8
	b.ne	.LBB2_75
.Ltmp177:
.LBB2_74:
	.loc	2 0 6
	mov	w0, wzr
	b	.LBB2_79
.Ltmp178:
.LBB2_75:
	.loc	2 647 15 is_stmt 1
	ldr	x0, [x20, #8]
.Ltmp179:
	.loc	2 647 7 is_stmt 0
	cbz	x0, .LBB2_77
.Ltmp180:
	.loc	2 648 4 is_stmt 1
	bl	kfree
.Ltmp181:
	.loc	2 649 17
	str	xzr, [x20, #8]
.Ltmp182:
.LBB2_77:
	.loc	2 651 17
	bl	epd_overlay_lut
.Ltmp183:
	mov	w1, w0
.Ltmp184:
	.loc	2 652 15
	mov	x0, x20
	mov	w2, w19
	bl	parse_wf_data
.Ltmp185:
	.loc	2 653 7
	tbnz	w0, #31, .LBB2_80
.Ltmp186:
	.loc	2 0 0 is_stmt 0
	mov	w21, w0
.Ltmp187:
	.loc	2 657 33 is_stmt 1
	ldr	x1, [x20, #24]
	.loc	2 657 3 is_stmt 0
	mov	x0, x20
	mov	w2, w21
	bl	rkf_lut_init_wf_table
.Ltmp188:
	.loc	2 659 21 is_stmt 1
	ldrb	w8, [x20]
	mov	w0, wzr
	.loc	2 660 21
	bfi	w8, w21, #8, #24
	str	w8, [x20]
	.loc	2 661 10
	str	w19, [x23, :lo12:rkf_wf_get_lut.sftemp]
.Ltmp189:
.LBB2_79:
	.loc	2 665 1
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldr	x25, [sp, #16]
	ldp	x29, x30, [sp], #80
	ldr	x30, [x18, #-8]!
	ret
.LBB2_80:
.Ltmp190:
	.loc	2 0 0 is_stmt 0
	adrp	x0, .L.str.4
.Ltmp191:
	add	x0, x0, :lo12:.L.str.4
	bl	_printk
.Ltmp192:
	mov	w0, #-5
	b	.LBB2_79
.Ltmp193:
.Lfunc_end2:
	.size	rkf_wf_get_lut, .Lfunc_end2-rkf_wf_get_lut
	.cfi_endproc

	.p2align	2
	.type	parse_wf_data,@function
parse_wf_data:
.Lfunc_begin3:
	.loc	2 466 0 is_stmt 1
	.cfi_startproc
	str	x30, [x18], #8
	.cfi_escape 0x16, 0x12, 0x02, 0x82, 0x78
	stp	x29, x30, [sp, #-64]!
	stp	x24, x23, [sp, #16]
	mov	x29, sp
	stp	x22, x21, [sp, #32]
	stp	x20, x19, [sp, #48]
	.cfi_def_cfa w29, 64
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w30, -56
	.cfi_offset w29, -64
.Ltmp194:
	.loc	2 470 2 prologue_end
	cmp	w1, #7
	b.hi	.LBB3_14
.Ltmp195:
	.loc	2 0 2 is_stmt 0
	adrp	x9, .LJTI3_0
	mov	w8, w1
	add	x9, x9, :lo12:.LJTI3_0
	mov	x19, x0
.Ltmp196:
	adr	x10, .LBB3_2
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
.Ltmp197:
.LBB3_2:
	.loc	2 188 34 is_stmt 1
	adrp	x8, global_waveform
.Ltmp198:
	.loc	2 173 9
	bic	w10, w2, w2, asr #31
.Ltmp199:
	.loc	2 174 9
	cmp	w10, #50
	mov	w11, #50
	mov	x9, xzr
.Ltmp200:
	csel	w10, w10, w11, lo
.Ltmp201:
	.loc	2 188 34
	ldr	x8, [x8, :lo12:global_waveform]
.Ltmp202:
	.loc	2 176 2
	add	x11, x8, #148
.Ltmp203:
.LBB3_3:
	.loc	2 177 14
	ldrb	w12, [x11, x9]
.Ltmp204:
	.loc	2 177 7 is_stmt 0
	cmp	w12, w10, uxtb
	b.hi	.LBB3_6
.Ltmp205:
	.loc	2 176 23 is_stmt 1
	add	x9, x9, #1
.Ltmp206:
	.loc	2 176 2 is_stmt 0
	cmp	x9, #50
	b.ne	.LBB3_3
.Ltmp207:
	.loc	2 0 2
	mov	x9, xzr
.Ltmp208:
.LBB3_6:
	.loc	2 229 14 is_stmt 1
	add	x9, x8, x9, lsl #2
.Ltmp209:
	.loc	4 558 9
	mov	w1, #3520
.Ltmp210:
	.loc	2 229 14
	ldr	w9, [x9, #596]
.Ltmp211:
	.loc	2 230 19
	add	x24, x8, x9
.Ltmp212:
	.loc	2 237 9
	ldrb	w20, [x24]
.Ltmp213:
	.loc	2 333 11
	add	x23, x20, #15
	.loc	2 333 39 is_stmt 0
	lsr	x8, x23, #2
.Ltmp214:
	and	x22, x8, #0x7c
.Ltmp215:
	.loc	4 558 9 is_stmt 1
	mov	x0, x22
	bl	__kmalloc
.Ltmp216:
	.loc	2 246 6
	cbz	x0, .LBB3_14
.Ltmp217:
	.loc	2 249 36
	add	x1, x24, #4
	.loc	2 249 2 is_stmt 0
	mov	x2, x22
	.loc	2 0 0
	mov	x21, x0
.Ltmp218:
	.loc	2 249 2
	bl	memcpy
.Ltmp219:
	.loc	2 265 27 is_stmt 1
	lsl	w8, w23, #6
.Ltmp220:
	.loc	4 558 9
	mov	w1, #3520
.Ltmp221:
	.loc	2 265 27
	and	w0, w8, #0x7c00
.Ltmp222:
	.loc	4 558 9
	bl	__kmalloc
.Ltmp223:
	.loc	2 266 6
	cbz	x0, .LBB3_52
.Ltmp224:
	.loc	2 269 2
	cbz	w20, .LBB3_13
.Ltmp225:
	.loc	2 0 0 is_stmt 0
	lsr	w11, w23, #4
.Ltmp226:
	mov	w10, #16384
.Ltmp227:
	.loc	2 269 2
	cmp	w11, #1
	mov	w12, #1365
	mov	w8, wzr
	mov	w9, wzr
	movk	w10, #21, lsl #16
	csinc	w11, w11, wzr, gt
.Ltmp228:
	.loc	2 0 2
	movk	w12, #5440, lsl #16
	mov	x13, x21
.Ltmp229:
.LBB3_10:
	mov	w15, wzr
	mov	w14, wzr
.Ltmp230:
	.loc	2 270 15 is_stmt 1
	ldr	w16, [x13]
.Ltmp231:
.LBB3_11:
	.loc	2 272 26
	asr	w17, w16, w15
	.loc	2 272 31 is_stmt 0
	add	w3, w8, w14
	.loc	2 272 36
	and	w1, w17, #0x3
.Ltmp232:
	.loc	2 276 26 is_stmt 1
	lsl	w17, w17, #30
.Ltmp233:
	.loc	2 279 13
	add	w4, w3, #3
.Ltmp234:
	.loc	2 271 17
	add	w14, w14, #16
.Ltmp235:
	.loc	2 0 17 is_stmt 0
	mul	w2, w1, w10
	.loc	2 271 17
	add	w15, w15, #2
.Ltmp236:
	.loc	2 276 19 is_stmt 1
	bfi	w17, w1, #12, #2
.Ltmp237:
	.loc	2 271 3
	cmp	w14, #256
.Ltmp238:
	.loc	2 276 19
	orr	w17, w17, w2
.Ltmp239:
	.loc	2 279 13
	add	w2, w3, #1
.Ltmp240:
	.loc	2 276 19
	madd	w17, w1, w12, w17
.Ltmp241:
	.loc	2 279 13
	add	w1, w3, #2
	.loc	2 279 20 is_stmt 0
	str	w17, [x0, w2, sxtw #2]
.Ltmp242:
	.loc	2 279 13
	add	w2, w3, #4
	.loc	2 279 20
	str	w17, [x0, w1, sxtw #2]
.Ltmp243:
	.loc	2 279 13
	add	w1, w3, #5
	.loc	2 279 20
	str	w17, [x0, w4, sxtw #2]
.Ltmp244:
	.loc	2 279 13
	add	w4, w3, #6
	.loc	2 279 20
	str	w17, [x0, w2, sxtw #2]
.Ltmp245:
	.loc	2 279 13
	add	w2, w3, #7
	.loc	2 279 20
	str	w17, [x0, w1, sxtw #2]
.Ltmp246:
	.loc	2 279 13
	add	w1, w3, #8
	.loc	2 279 20
	str	w17, [x0, w4, sxtw #2]
.Ltmp247:
	.loc	2 279 13
	add	w4, w3, #9
	.loc	2 279 20
	str	w17, [x0, w2, sxtw #2]
.Ltmp248:
	.loc	2 279 13
	add	w2, w3, #10
	.loc	2 279 20
	str	w17, [x0, w1, sxtw #2]
.Ltmp249:
	.loc	2 279 13
	add	w1, w3, #11
	.loc	2 279 20
	str	w17, [x0, w4, sxtw #2]
.Ltmp250:
	str	w17, [x0, w2, sxtw #2]
.Ltmp251:
	.loc	2 279 13
	add	w2, w3, #12
	.loc	2 279 20
	str	w17, [x0, w1, sxtw #2]
.Ltmp252:
	.loc	2 279 13
	add	w1, w3, #13
	.loc	2 279 20
	str	w17, [x0, w3, sxtw #2]
.Ltmp253:
	str	w17, [x0, w2, sxtw #2]
.Ltmp254:
	.loc	2 279 13
	add	w2, w3, #14
	.loc	2 279 20
	str	w17, [x0, w1, sxtw #2]
.Ltmp255:
	.loc	2 279 13
	add	w1, w3, #15
	.loc	2 279 20
	str	w17, [x0, w2, sxtw #2]
.Ltmp256:
	str	w17, [x0, w1, sxtw #2]
.Ltmp257:
	.loc	2 271 3 is_stmt 1
	b.ne	.LBB3_11
.Ltmp258:
	.loc	2 270 21
	add	x13, x13, #4
.Ltmp259:
	.loc	2 269 24
	add	w9, w9, #1
.Ltmp260:
	.loc	2 269 2 is_stmt 0
	add	w8, w8, w14
	cmp	w9, w11
	b.ne	.LBB3_10
.Ltmp261:
.LBB3_13:
	.loc	2 341 15 is_stmt 1
	str	x0, [x19, #8]
	.loc	2 0 0 is_stmt 0
	mov	x0, x21
	bl	kfree
.Ltmp262:
	b	.LBB3_51
.Ltmp263:
.LBB3_14:
	mov	w20, #-1
	b	.LBB3_51
.Ltmp264:
.LBB3_15:
	.loc	2 188 34 is_stmt 1
	adrp	x8, global_waveform
.Ltmp265:
	.loc	2 173 9
	bic	w10, w2, w2, asr #31
.Ltmp266:
	.loc	2 174 9
	cmp	w10, #50
	mov	w11, #50
	mov	x9, xzr
.Ltmp267:
	csel	w10, w10, w11, lo
.Ltmp268:
	.loc	2 188 34
	ldr	x8, [x8, :lo12:global_waveform]
.Ltmp269:
	.loc	2 176 2
	add	x11, x8, #468
.Ltmp270:
.LBB3_16:
	.loc	2 177 14
	ldrb	w12, [x11, x9]
.Ltmp271:
	.loc	2 177 7 is_stmt 0
	cmp	w12, w10, uxtb
	b.hi	.LBB3_19
.Ltmp272:
	.loc	2 176 23 is_stmt 1
	add	x9, x9, #1
.Ltmp273:
	.loc	2 176 2 is_stmt 0
	cmp	x9, #50
	b.ne	.LBB3_16
.Ltmp274:
	.loc	2 0 2
	mov	x9, xzr
.Ltmp275:
.LBB3_19:
	.loc	2 229 14 is_stmt 1
	add	x9, x8, x9, lsl #2
	ldr	w9, [x9, #1876]
.Ltmp276:
	.loc	2 0 14 is_stmt 0
	b	.LBB3_48
.Ltmp277:
.LBB3_20:
	.loc	2 188 34 is_stmt 1
	adrp	x8, global_waveform
.Ltmp278:
	.loc	2 173 9
	bic	w10, w2, w2, asr #31
.Ltmp279:
	.loc	2 174 9
	cmp	w10, #50
	mov	w11, #50
	mov	x9, xzr
.Ltmp280:
	csel	w10, w10, w11, lo
.Ltmp281:
	.loc	2 188 34
	ldr	x8, [x8, :lo12:global_waveform]
.Ltmp282:
	.loc	2 176 2
	add	x11, x8, #212
.Ltmp283:
.LBB3_21:
	.loc	2 177 14
	ldrb	w12, [x11, x9]
.Ltmp284:
	.loc	2 177 7 is_stmt 0
	cmp	w12, w10, uxtb
	b.hi	.LBB3_27
.Ltmp285:
	.loc	2 176 23 is_stmt 1
	add	x9, x9, #1
.Ltmp286:
	.loc	2 176 2 is_stmt 0
	cmp	x9, #50
	b.ne	.LBB3_21
	b	.LBB3_26
.Ltmp287:
.LBB3_23:
	.loc	2 188 34 is_stmt 1
	adrp	x8, global_waveform
.Ltmp288:
	.loc	2 173 9
	bic	w10, w2, w2, asr #31
.Ltmp289:
	.loc	2 174 9
	cmp	w10, #50
	mov	w11, #50
	mov	x9, xzr
.Ltmp290:
	csel	w10, w10, w11, lo
.Ltmp291:
	.loc	2 188 34
	ldr	x8, [x8, :lo12:global_waveform]
.Ltmp292:
	.loc	2 176 2
	add	x11, x8, #212
.Ltmp293:
.LBB3_24:
	.loc	2 177 14
	ldrb	w12, [x11, x9]
.Ltmp294:
	.loc	2 177 7 is_stmt 0
	cmp	w12, w10, uxtb
	b.hi	.LBB3_27
.Ltmp295:
	.loc	2 176 23 is_stmt 1
	add	x9, x9, #1
.Ltmp296:
	.loc	2 176 2 is_stmt 0
	cmp	x9, #50
	b.ne	.LBB3_24
.Ltmp297:
.LBB3_26:
	.loc	2 0 2
	mov	x9, xzr
.Ltmp298:
.LBB3_27:
	add	x9, x8, x9, lsl #2
	ldr	w9, [x9, #852]
	b	.LBB3_48
.Ltmp299:
.LBB3_28:
	.loc	2 188 34 is_stmt 1
	adrp	x8, global_waveform
.Ltmp300:
	.loc	2 173 9
	bic	w10, w2, w2, asr #31
.Ltmp301:
	.loc	2 174 9
	cmp	w10, #50
	mov	w11, #50
	mov	x9, xzr
.Ltmp302:
	csel	w10, w10, w11, lo
.Ltmp303:
	.loc	2 188 34
	ldr	x8, [x8, :lo12:global_waveform]
.Ltmp304:
	.loc	2 176 2
	add	x11, x8, #276
.Ltmp305:
.LBB3_29:
	.loc	2 177 14
	ldrb	w12, [x11, x9]
.Ltmp306:
	.loc	2 177 7 is_stmt 0
	cmp	w12, w10, uxtb
	b.hi	.LBB3_32
.Ltmp307:
	.loc	2 176 23 is_stmt 1
	add	x9, x9, #1
.Ltmp308:
	.loc	2 176 2 is_stmt 0
	cmp	x9, #50
	b.ne	.LBB3_29
.Ltmp309:
	.loc	2 0 2
	mov	x9, xzr
.Ltmp310:
.LBB3_32:
	.loc	2 229 14 is_stmt 1
	add	x9, x8, x9, lsl #2
	ldr	w9, [x9, #1108]
.Ltmp311:
	.loc	2 0 14 is_stmt 0
	b	.LBB3_48
.Ltmp312:
.LBB3_33:
	.loc	2 188 34 is_stmt 1
	adrp	x8, global_waveform
.Ltmp313:
	.loc	2 173 9
	bic	w10, w2, w2, asr #31
.Ltmp314:
	.loc	2 174 9
	cmp	w10, #50
	mov	w11, #50
	mov	x9, xzr
.Ltmp315:
	csel	w10, w10, w11, lo
.Ltmp316:
	.loc	2 188 34
	ldr	x8, [x8, :lo12:global_waveform]
.Ltmp317:
	.loc	2 176 2
	add	x11, x8, #340
.Ltmp318:
.LBB3_34:
	.loc	2 177 14
	ldrb	w12, [x11, x9]
.Ltmp319:
	.loc	2 177 7 is_stmt 0
	cmp	w12, w10, uxtb
	b.hi	.LBB3_37
.Ltmp320:
	.loc	2 176 23 is_stmt 1
	add	x9, x9, #1
.Ltmp321:
	.loc	2 176 2 is_stmt 0
	cmp	x9, #50
	b.ne	.LBB3_34
.Ltmp322:
	.loc	2 0 2
	mov	x9, xzr
.Ltmp323:
.LBB3_37:
	.loc	2 229 14 is_stmt 1
	add	x9, x8, x9, lsl #2
	ldr	w9, [x9, #1364]
.Ltmp324:
	.loc	2 0 14 is_stmt 0
	b	.LBB3_48
.Ltmp325:
.LBB3_38:
	.loc	2 188 34 is_stmt 1
	adrp	x8, global_waveform
.Ltmp326:
	.loc	2 173 9
	bic	w10, w2, w2, asr #31
.Ltmp327:
	.loc	2 174 9
	cmp	w10, #50
	mov	w11, #50
	mov	x9, xzr
.Ltmp328:
	csel	w10, w10, w11, lo
.Ltmp329:
	.loc	2 188 34
	ldr	x8, [x8, :lo12:global_waveform]
.Ltmp330:
	.loc	2 176 2
	add	x11, x8, #404
.Ltmp331:
.LBB3_39:
	.loc	2 177 14
	ldrb	w12, [x11, x9]
.Ltmp332:
	.loc	2 177 7 is_stmt 0
	cmp	w12, w10, uxtb
	b.hi	.LBB3_42
.Ltmp333:
	.loc	2 176 23 is_stmt 1
	add	x9, x9, #1
.Ltmp334:
	.loc	2 176 2 is_stmt 0
	cmp	x9, #50
	b.ne	.LBB3_39
.Ltmp335:
	.loc	2 0 2
	mov	x9, xzr
.Ltmp336:
.LBB3_42:
	.loc	2 229 14 is_stmt 1
	add	x9, x8, x9, lsl #2
	ldr	w9, [x9, #1620]
.Ltmp337:
	.loc	2 0 14 is_stmt 0
	b	.LBB3_48
.Ltmp338:
.LBB3_43:
	.loc	2 188 34 is_stmt 1
	adrp	x8, global_waveform
.Ltmp339:
	.loc	2 173 9
	bic	w10, w2, w2, asr #31
.Ltmp340:
	.loc	2 174 9
	cmp	w10, #50
	mov	w11, #50
	mov	x9, xzr
.Ltmp341:
	csel	w10, w10, w11, lo
.Ltmp342:
	.loc	2 188 34
	ldr	x8, [x8, :lo12:global_waveform]
.Ltmp343:
	.loc	2 176 2
	add	x11, x8, #532
.Ltmp344:
.LBB3_44:
	.loc	2 177 14
	ldrb	w12, [x11, x9]
.Ltmp345:
	.loc	2 177 7 is_stmt 0
	cmp	w12, w10, uxtb
	b.hi	.LBB3_47
.Ltmp346:
	.loc	2 176 23 is_stmt 1
	add	x9, x9, #1
.Ltmp347:
	.loc	2 176 2 is_stmt 0
	cmp	x9, #50
	b.ne	.LBB3_44
.Ltmp348:
	.loc	2 0 2
	mov	x9, xzr
.Ltmp349:
.LBB3_47:
	.loc	2 229 14 is_stmt 1
	add	x9, x8, x9, lsl #2
	ldr	w9, [x9, #2132]
.Ltmp350:
.LBB3_48:
	.loc	2 0 0 is_stmt 0
	add	x23, x8, x9
.Ltmp351:
	mov	w1, #3520
.Ltmp352:
	ldrb	w22, [x23]
	lsl	x20, x22, #6
.Ltmp353:
	mov	x0, x20
	bl	__kmalloc
.Ltmp354:
	cbz	x0, .LBB3_50
.Ltmp355:
	add	x1, x23, #4
	mov	x2, x20
	mov	x21, x0
.Ltmp356:
	bl	memcpy
.Ltmp357:
	mov	w20, w22
.Ltmp358:
	str	x21, [x19, #8]
.Ltmp359:
	b	.LBB3_51
.Ltmp360:
.LBB3_50:
	mov	w20, #-1
.Ltmp361:
	str	xzr, [x19, #8]
.Ltmp362:
.LBB3_51:
	.loc	2 530 1 is_stmt 1
	mov	w0, w20
	ldp	x20, x19, [sp, #48]
	ldp	x22, x21, [sp, #32]
	ldp	x24, x23, [sp, #16]
	ldp	x29, x30, [sp], #64
	ldr	x30, [x18, #-8]!
	ret
.LBB3_52:
.Ltmp363:
	.loc	2 0 0 is_stmt 0
	mov	x0, x21
	.loc	2 341 15 is_stmt 1
	str	xzr, [x19, #8]
	.loc	2 0 0 is_stmt 0
	bl	kfree
.Ltmp364:
	mov	w20, #-1
.Ltmp365:
	b	.LBB3_51
.Ltmp366:
.Lfunc_end3:
	.size	parse_wf_data, .Lfunc_end3-parse_wf_data
	.cfi_endproc
	.section	.rodata,"a",@progbits
.LJTI3_0:
	.byte	(.LBB3_2-.LBB3_2)>>2
	.byte	(.LBB3_15-.LBB3_2)>>2
	.byte	(.LBB3_20-.LBB3_2)>>2
	.byte	(.LBB3_23-.LBB3_2)>>2
	.byte	(.LBB3_28-.LBB3_2)>>2
	.byte	(.LBB3_33-.LBB3_2)>>2
	.byte	(.LBB3_38-.LBB3_2)>>2
	.byte	(.LBB3_43-.LBB3_2)>>2
	.file	8 "/home/lyx/rk-android14/kernel-6.1" "./include/uapi/asm-generic/posix_types.h"

	.text
	.p2align	2
	.type	rkf_lut_init_wf_table,@function
rkf_lut_init_wf_table:
.Lfunc_begin4:
	.loc	2 448 0 is_stmt 1
	.cfi_startproc
	.loc	2 452 2 prologue_end
	cmp	w2, #1
	b.lt	.LBB4_5
.Ltmp367:
	.loc	2 0 2 is_stmt 0
	mov	w8, wzr
	mov	w9, wzr
	mov	x10, xzr
.Ltmp368:
	.loc	2 452 14
	mov	w11, w2
.Ltmp369:
	.loc	2 452 2
	add	x12, x1, #7
.Ltmp370:
.LBB4_2:
	.loc	2 453 34 is_stmt 1
	ldr	x15, [x0, #8]
.Ltmp371:
	and	x14, x8, #0x7ffffff
	mov	x13, xzr
	add	x14, x12, x14, lsl #5
.Ltmp372:
	.loc	2 454 3
	add	x15, x15, w9, sxtw #2
.Ltmp373:
.LBB4_3:
	.loc	2 0 3 is_stmt 0
	add	x16, x15, x13
.Ltmp374:
	.loc	2 454 31
	add	x13, x13, #4
.Ltmp375:
	.loc	2 454 3
	cmp	x13, #64
.Ltmp376:
	.loc	2 456 16 is_stmt 1
	ldrb	w17, [x16]
	.loc	2 456 15 is_stmt 0
	and	w17, w17, #0x3
.Ltmp377:
	.loc	2 457 54 is_stmt 1
	sturb	w17, [x14, #-7]
.Ltmp378:
	.loc	2 456 16
	ldrb	w17, [x16]
	.loc	2 456 15 is_stmt 0
	ubfx	w17, w17, #2, #2
.Ltmp379:
	.loc	2 457 54 is_stmt 1
	sturb	w17, [x14, #-6]
.Ltmp380:
	.loc	2 456 16
	ldrb	w17, [x16]
	.loc	2 456 15 is_stmt 0
	ubfx	w17, w17, #4, #2
.Ltmp381:
	.loc	2 457 54 is_stmt 1
	sturb	w17, [x14, #-5]
.Ltmp382:
	.loc	2 456 16
	ldrb	w17, [x16]
	.loc	2 456 15 is_stmt 0
	lsr	w17, w17, #6
.Ltmp383:
	.loc	2 457 54 is_stmt 1
	sturb	w17, [x14, #-4]
.Ltmp384:
	.loc	2 456 16
	ldrb	w17, [x16, #1]
	.loc	2 456 15 is_stmt 0
	and	w17, w17, #0x3
.Ltmp385:
	.loc	2 457 54 is_stmt 1
	sturb	w17, [x14, #-3]
.Ltmp386:
	.loc	2 456 16
	ldr	w17, [x16]
	.loc	2 456 15 is_stmt 0
	ubfx	w17, w17, #10, #2
.Ltmp387:
	.loc	2 457 54 is_stmt 1
	sturb	w17, [x14, #-2]
.Ltmp388:
	.loc	2 456 16
	ldr	w17, [x16]
	.loc	2 456 15 is_stmt 0
	ubfx	w17, w17, #12, #2
.Ltmp389:
	.loc	2 457 54 is_stmt 1
	sturb	w17, [x14, #-1]
.Ltmp390:
	.loc	2 456 16
	ldr	w17, [x16]
	.loc	2 456 15 is_stmt 0
	ubfx	w17, w17, #14, #2
.Ltmp391:
	.loc	2 457 54 is_stmt 1
	strb	w17, [x14]
.Ltmp392:
	.loc	2 456 16
	ldrb	w17, [x16, #2]
	.loc	2 456 15 is_stmt 0
	and	w17, w17, #0x3
.Ltmp393:
	.loc	2 457 54 is_stmt 1
	strb	w17, [x14, #1]
.Ltmp394:
	.loc	2 456 16
	ldr	w17, [x16]
	.loc	2 456 15 is_stmt 0
	ubfx	w17, w17, #18, #2
.Ltmp395:
	.loc	2 457 54 is_stmt 1
	strb	w17, [x14, #2]
.Ltmp396:
	.loc	2 456 16
	ldr	w17, [x16]
	.loc	2 456 15 is_stmt 0
	ubfx	w17, w17, #20, #2
.Ltmp397:
	.loc	2 457 54 is_stmt 1
	strb	w17, [x14, #3]
.Ltmp398:
	.loc	2 456 16
	ldr	w17, [x16]
	.loc	2 456 15 is_stmt 0
	ubfx	w17, w17, #22, #2
.Ltmp399:
	.loc	2 457 54 is_stmt 1
	strb	w17, [x14, #4]
.Ltmp400:
	.loc	2 456 16
	ldrb	w17, [x16, #3]
	.loc	2 456 15 is_stmt 0
	and	w17, w17, #0x3
.Ltmp401:
	.loc	2 457 54 is_stmt 1
	strb	w17, [x14, #5]
.Ltmp402:
	.loc	2 456 16
	ldr	w17, [x16]
	.loc	2 456 15 is_stmt 0
	ubfx	w17, w17, #26, #2
.Ltmp403:
	.loc	2 457 54 is_stmt 1
	strb	w17, [x14, #6]
.Ltmp404:
	.loc	2 456 16
	ldr	w17, [x16]
	.loc	2 456 15 is_stmt 0
	ubfx	w17, w17, #28, #2
.Ltmp405:
	.loc	2 457 54 is_stmt 1
	strb	w17, [x14, #7]
.Ltmp406:
	.loc	2 456 16
	ldr	w16, [x16]
	.loc	2 456 39 is_stmt 0
	lsr	w16, w16, #30
.Ltmp407:
	.loc	2 457 54 is_stmt 1
	strb	w16, [x14, #8]
.Ltmp408:
	.loc	2 454 31
	add	x14, x14, #32
.Ltmp409:
	.loc	2 454 3 is_stmt 0
	b.ne	.LBB4_3
.Ltmp410:
	.loc	2 452 28 is_stmt 1
	add	x10, x10, #1
.Ltmp411:
	.loc	2 452 2 is_stmt 0
	add	w9, w9, #16
	add	w8, w8, #32
	cmp	x10, x11
	b.ne	.LBB4_2
.Ltmp412:
.LBB4_5:
	.loc	2 462 2 is_stmt 1
	ret
.Ltmp413:
.Lfunc_end4:
	.size	rkf_lut_init_wf_table, .Lfunc_end4-rkf_lut_init_wf_table
	.cfi_endproc

	.type	global_waveform,@object
	.local	global_waveform
	.comm	global_waveform,8,8
	.type	.L.str,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"rkf: failed to check RKF file format\n"
	.size	.L.str, 38

	.type	.L.str.1,@object
.L.str.1:
	.asciz	"rkf: failed to check crc RKF waveform\n"
	.size	.L.str.1, 39

	.type	.L.str.2,@object
.L.str.2:
	.asciz	"rkf file version: %s\n"
	.size	.L.str.2, 22

	.type	rkf_wf_get_lut.stype,@object
	.data
	.p2align	2
rkf_wf_get_lut.stype:
	.word	11
	.size	rkf_wf_get_lut.stype, 4

	.type	rkf_wf_get_lut.sftemp,@object
	.p2align	2
rkf_wf_get_lut.sftemp:
	.word	4294967295
	.size	rkf_wf_get_lut.sftemp, 4

	.type	.L.str.3,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.3:
	.asciz	"rkf: not support 5bit waveform\n"
	.size	.L.str.3, 32

	.type	.L.str.4,@object
.L.str.4:
	.asciz	"rkf waveform get frame number failed\n"
	.size	.L.str.4, 38

	.type	.L.str.5,@object
.L.str.5:
	.asciz	"rkf waveform"
	.size	.L.str.5, 13

	.type	.L.str.6,@object
.L.str.6:
	.asciz	"rkf: check format failed\n"
	.size	.L.str.6, 26

	.type	.L.str.7,@object
.L.str.7:
	.asciz	"[EINK]: waveform crc err readcrc = %x crccheck = %x\n"
	.size	.L.str.7, 53

	.type	crc32_table,@object
	.local	crc32_table
	.comm	crc32_table,1024,4
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
	.xword	.Lfunc_begin0-.Lfunc_begin0
	.xword	.Ltmp3-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp4-.Lfunc_begin0
	.xword	.Ltmp5-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp5-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc1:
	.xword	.Ltmp0-.Lfunc_begin0
	.xword	.Ltmp1-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp1-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc2:
	.xword	.Ltmp1-.Lfunc_begin0
	.xword	.Ltmp3-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp4-.Lfunc_begin0
	.xword	.Ltmp8-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp8-.Lfunc_begin0
	.xword	.Ltmp44-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	127
	.byte	159
	.xword	.Ltmp44-.Lfunc_begin0
	.xword	.Ltmp48-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp48-.Lfunc_begin0
	.xword	.Ltmp50-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	127
	.byte	159
	.xword	.Ltmp50-.Lfunc_begin0
	.xword	.Ltmp51-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc3:
	.xword	.Ltmp6-.Lfunc_begin0
	.xword	.Ltmp7-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc4:
	.xword	.Ltmp8-.Lfunc_begin0
	.xword	.Ltmp44-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp49-.Lfunc_begin0
	.xword	.Ltmp50-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc5:
	.xword	.Ltmp8-.Lfunc_begin0
	.xword	.Ltmp43-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp43-.Lfunc_begin0
	.xword	.Ltmp44-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp49-.Lfunc_begin0
	.xword	.Ltmp50-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc6:
	.xword	.Ltmp8-.Lfunc_begin0
	.xword	.Ltmp13-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp13-.Lfunc_begin0
	.xword	.Ltmp44-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	.Ltmp49-.Lfunc_begin0
	.xword	.Ltmp50-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	0
	.xword	0
.Ldebug_loc7:
	.xword	.Ltmp14-.Lfunc_begin0
	.xword	.Ltmp40-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp40-.Lfunc_begin0
	.xword	.Ltmp43-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc8:
	.xword	.Ltmp14-.Lfunc_begin0
	.xword	.Ltmp40-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc9:
	.xword	.Ltmp14-.Lfunc_begin0
	.xword	.Ltmp40-.Lfunc_begin0
	.hword	1
	.byte	103
	.xword	0
	.xword	0
.Ldebug_loc10:
	.xword	.Ltmp14-.Lfunc_begin0
	.xword	.Ltmp40-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp40-.Lfunc_begin0
	.xword	.Ltmp43-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc11:
	.xword	.Ltmp16-.Lfunc_begin0
	.xword	.Ltmp17-.Lfunc_begin0
	.hword	5
	.byte	124
	.byte	0
	.byte	72
	.byte	36
	.byte	159
	.xword	.Ltmp17-.Lfunc_begin0
	.xword	.Ltmp18-.Lfunc_begin0
	.hword	5
	.byte	124
	.byte	0
	.byte	75
	.byte	36
	.byte	159
	.xword	.Ltmp18-.Lfunc_begin0
	.xword	.Ltmp21-.Lfunc_begin0
	.hword	5
	.byte	124
	.byte	0
	.byte	76
	.byte	36
	.byte	159
	.xword	.Ltmp21-.Lfunc_begin0
	.xword	.Ltmp25-.Lfunc_begin0
	.hword	5
	.byte	124
	.byte	0
	.byte	77
	.byte	36
	.byte	159
	.xword	.Ltmp25-.Lfunc_begin0
	.xword	.Ltmp29-.Lfunc_begin0
	.hword	5
	.byte	124
	.byte	0
	.byte	78
	.byte	36
	.byte	159
	.xword	.Ltmp29-.Lfunc_begin0
	.xword	.Ltmp33-.Lfunc_begin0
	.hword	5
	.byte	124
	.byte	0
	.byte	79
	.byte	36
	.byte	159
	.xword	.Ltmp33-.Lfunc_begin0
	.xword	.Ltmp36-.Lfunc_begin0
	.hword	7
	.byte	124
	.byte	0
	.byte	79
	.byte	36
	.byte	49
	.byte	36
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc12:
	.xword	.Ltmp16-.Lfunc_begin0
	.xword	.Ltmp17-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp18-.Lfunc_begin0
	.xword	.Ltmp20-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp21-.Lfunc_begin0
	.xword	.Ltmp24-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp25-.Lfunc_begin0
	.xword	.Ltmp28-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp29-.Lfunc_begin0
	.xword	.Ltmp32-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp33-.Lfunc_begin0
	.xword	.Ltmp37-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc13:
	.xword	.Ltmp16-.Lfunc_begin0
	.xword	.Ltmp17-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp17-.Lfunc_begin0
	.xword	.Ltmp18-.Lfunc_begin0
	.hword	2
	.byte	51
	.byte	159
	.xword	.Ltmp18-.Lfunc_begin0
	.xword	.Ltmp21-.Lfunc_begin0
	.hword	2
	.byte	52
	.byte	159
	.xword	.Ltmp21-.Lfunc_begin0
	.xword	.Ltmp25-.Lfunc_begin0
	.hword	2
	.byte	53
	.byte	159
	.xword	.Ltmp25-.Lfunc_begin0
	.xword	.Ltmp29-.Lfunc_begin0
	.hword	2
	.byte	54
	.byte	159
	.xword	.Ltmp29-.Lfunc_begin0
	.xword	.Ltmp33-.Lfunc_begin0
	.hword	2
	.byte	55
	.byte	159
	.xword	.Ltmp33-.Lfunc_begin0
	.xword	.Ltmp37-.Lfunc_begin0
	.hword	2
	.byte	56
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc14:
	.xword	.Lfunc_begin2-.Lfunc_begin0
	.xword	.Ltmp59-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp59-.Lfunc_begin0
	.xword	.Ltmp102-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	.Ltmp102-.Lfunc_begin0
	.xword	.Ltmp103-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp104-.Lfunc_begin0
	.xword	.Ltmp189-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	.Ltmp190-.Lfunc_begin0
	.xword	.Lfunc_end2-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	0
	.xword	0
.Ldebug_loc15:
	.xword	.Lfunc_begin2-.Lfunc_begin0
	.xword	.Ltmp65-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp65-.Lfunc_begin0
	.xword	.Ltmp102-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	.Ltmp102-.Lfunc_begin0
	.xword	.Ltmp105-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp105-.Lfunc_begin0
	.xword	.Ltmp119-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	.Ltmp119-.Lfunc_begin0
	.xword	.Ltmp120-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp120-.Lfunc_begin0
	.xword	.Ltmp121-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp121-.Lfunc_begin0
	.xword	.Ltmp187-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	.Ltmp190-.Lfunc_begin0
	.xword	.Lfunc_end2-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	0
	.xword	0
.Ldebug_loc16:
	.xword	.Lfunc_begin2-.Lfunc_begin0
	.xword	.Ltmp63-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp63-.Lfunc_begin0
	.xword	.Ltmp102-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp102-.Lfunc_begin0
	.xword	.Ltmp105-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp105-.Lfunc_begin0
	.xword	.Ltmp119-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp119-.Lfunc_begin0
	.xword	.Ltmp120-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp121-.Lfunc_begin0
	.xword	.Ltmp189-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp190-.Lfunc_begin0
	.xword	.Lfunc_end2-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc17:
	.xword	.Lfunc_begin2-.Lfunc_begin0
	.xword	.Ltmp72-.Lfunc_begin0
	.hword	1
	.byte	83
	.xword	.Ltmp72-.Lfunc_begin0
	.xword	.Ltmp73-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	83
	.byte	159
	.xword	.Ltmp102-.Lfunc_begin0
	.xword	.Ltmp105-.Lfunc_begin0
	.hword	1
	.byte	83
	.xword	.Ltmp119-.Lfunc_begin0
	.xword	.Ltmp120-.Lfunc_begin0
	.hword	1
	.byte	83
	.xword	.Ltmp120-.Lfunc_begin0
	.xword	.Ltmp121-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	83
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc18:
	.xword	.Ltmp57-.Lfunc_begin0
	.xword	.Ltmp74-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp74-.Lfunc_begin0
	.xword	.Ltmp76-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp76-.Lfunc_begin0
	.xword	.Ltmp102-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	.Ltmp102-.Lfunc_begin0
	.xword	.Ltmp105-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp105-.Lfunc_begin0
	.xword	.Ltmp119-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	.Ltmp119-.Lfunc_begin0
	.xword	.Ltmp121-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp121-.Lfunc_begin0
	.xword	.Ltmp176-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	.Ltmp185-.Lfunc_begin0
	.xword	.Ltmp187-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp187-.Lfunc_begin0
	.xword	.Ltmp189-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	.Ltmp190-.Lfunc_begin0
	.xword	.Ltmp191-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc19:
	.xword	.Ltmp57-.Lfunc_begin0
	.xword	.Ltmp184-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp184-.Lfunc_begin0
	.xword	.Ltmp185-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	0
	.xword	0
.Ldebug_loc20:
	.xword	.Ltmp82-.Lfunc_begin0
	.xword	.Ltmp100-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp121-.Lfunc_begin0
	.xword	.Ltmp132-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc21:
	.xword	.Ltmp79-.Lfunc_begin0
	.xword	.Ltmp101-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	.Ltmp121-.Lfunc_begin0
	.xword	.Ltmp142-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	0
	.xword	0
.Ldebug_loc22:
	.xword	.Ltmp79-.Lfunc_begin0
	.xword	.Ltmp83-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp83-.Lfunc_begin0
	.xword	.Ltmp85-.Lfunc_begin0
	.hword	7
	.byte	121
	.byte	0
	.byte	17
	.byte	128
	.byte	8
	.byte	27
	.byte	159
	.xword	.Ltmp87-.Lfunc_begin0
	.xword	.Ltmp89-.Lfunc_begin0
	.hword	10
	.byte	121
	.byte	0
	.byte	17
	.byte	128
	.byte	8
	.byte	27
	.byte	17
	.byte	1
	.byte	34
	.byte	159
	.xword	.Ltmp89-.Lfunc_begin0
	.xword	.Ltmp93-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp98-.Lfunc_begin0
	.xword	.Ltmp101-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	3
	.byte	159
	.xword	.Ltmp121-.Lfunc_begin0
	.xword	.Ltmp132-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp132-.Lfunc_begin0
	.xword	.Ltmp139-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	3
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc23:
	.xword	.Ltmp79-.Lfunc_begin0
	.xword	.Ltmp83-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp84-.Lfunc_begin0
	.xword	.Ltmp92-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp94-.Lfunc_begin0
	.xword	.Ltmp97-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp121-.Lfunc_begin0
	.xword	.Ltmp122-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp139-.Lfunc_begin0
	.xword	.Ltmp142-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc24:
	.xword	.Ltmp108-.Lfunc_begin0
	.xword	.Ltmp118-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp142-.Lfunc_begin0
	.xword	.Ltmp160-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc25:
	.xword	.Ltmp105-.Lfunc_begin0
	.xword	.Ltmp118-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	.Ltmp142-.Lfunc_begin0
	.xword	.Ltmp172-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	0
	.xword	0
.Ldebug_loc26:
	.xword	.Ltmp105-.Lfunc_begin0
	.xword	.Ltmp109-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp110-.Lfunc_begin0
	.xword	.Ltmp117-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp154-.Lfunc_begin0
	.xword	.Ltmp157-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp169-.Lfunc_begin0
	.xword	.Ltmp172-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc27:
	.xword	.Ltmp105-.Lfunc_begin0
	.xword	.Ltmp109-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp109-.Lfunc_begin0
	.xword	.Ltmp111-.Lfunc_begin0
	.hword	7
	.byte	121
	.byte	0
	.byte	17
	.byte	128
	.byte	8
	.byte	27
	.byte	159
	.xword	.Ltmp113-.Lfunc_begin0
	.xword	.Ltmp115-.Lfunc_begin0
	.hword	10
	.byte	121
	.byte	0
	.byte	17
	.byte	128
	.byte	8
	.byte	27
	.byte	17
	.byte	1
	.byte	34
	.byte	159
	.xword	.Ltmp115-.Lfunc_begin0
	.xword	.Ltmp118-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	4
	.byte	159
	.xword	.Ltmp142-.Lfunc_begin0
	.xword	.Ltmp153-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	4
	.byte	159
	.xword	.Ltmp158-.Lfunc_begin0
	.xword	.Ltmp169-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	7
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc28:
	.xword	.Lfunc_begin3-.Lfunc_begin0
	.xword	.Ltmp196-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp196-.Lfunc_begin0
	.xword	.Ltmp263-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp264-.Lfunc_begin0
	.xword	.Ltmp362-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp363-.Lfunc_begin0
	.xword	.Lfunc_end3-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc29:
	.xword	.Lfunc_begin3-.Lfunc_begin0
	.xword	.Ltmp210-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp210-.Lfunc_begin0
	.xword	.Ltmp263-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp264-.Lfunc_begin0
	.xword	.Ltmp352-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp352-.Lfunc_begin0
	.xword	.Ltmp362-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp363-.Lfunc_begin0
	.xword	.Lfunc_end3-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc30:
	.xword	.Lfunc_begin3-.Lfunc_begin0
	.xword	.Ltmp216-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp216-.Lfunc_begin0
	.xword	.Ltmp263-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	82
	.byte	159
	.xword	.Ltmp264-.Lfunc_begin0
	.xword	.Ltmp354-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp354-.Lfunc_begin0
	.xword	.Ltmp362-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	82
	.byte	159
	.xword	.Ltmp363-.Lfunc_begin0
	.xword	.Lfunc_end3-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	82
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc31:
	.xword	.Ltmp194-.Lfunc_begin0
	.xword	.Ltmp262-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	127
	.byte	159
	.xword	.Ltmp262-.Lfunc_begin0
	.xword	.Ltmp263-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	.Ltmp263-.Lfunc_begin0
	.xword	.Ltmp359-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	127
	.byte	159
	.xword	.Ltmp360-.Lfunc_begin0
	.xword	.Ltmp361-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	127
	.byte	159
	.xword	.Ltmp363-.Lfunc_begin0
	.xword	.Ltmp365-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	127
	.byte	159
	.xword	.Ltmp365-.Lfunc_begin0
	.xword	.Lfunc_end3-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	0
	.xword	0
.Ldebug_loc32:
	.xword	.Ltmp199-.Lfunc_begin0
	.xword	.Ltmp201-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	.Ltmp202-.Lfunc_begin0
	.xword	.Ltmp207-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc33:
	.xword	.Ltmp200-.Lfunc_begin0
	.xword	.Ltmp202-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp202-.Lfunc_begin0
	.xword	.Ltmp214-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc34:
	.xword	.Ltmp200-.Lfunc_begin0
	.xword	.Ltmp217-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc35:
	.xword	.Ltmp200-.Lfunc_begin0
	.xword	.Ltmp216-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc36:
	.xword	.Ltmp200-.Lfunc_begin0
	.xword	.Ltmp215-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp215-.Lfunc_begin0
	.xword	.Ltmp263-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	.Ltmp363-.Lfunc_begin0
	.xword	.Lfunc_end3-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	0
	.xword	0
.Ldebug_loc37:
	.xword	.Ltmp200-.Lfunc_begin0
	.xword	.Ltmp213-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp213-.Lfunc_begin0
	.xword	.Ltmp263-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	.Ltmp363-.Lfunc_begin0
	.xword	.Ltmp365-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	0
	.xword	0
.Ldebug_loc38:
	.xword	.Ltmp200-.Lfunc_begin0
	.xword	.Ltmp212-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp212-.Lfunc_begin0
	.xword	.Ltmp263-.Lfunc_begin0
	.hword	1
	.byte	104
	.xword	.Ltmp363-.Lfunc_begin0
	.xword	.Lfunc_end3-.Lfunc_begin0
	.hword	1
	.byte	104
	.xword	0
	.xword	0
.Ldebug_loc39:
	.xword	.Ltmp200-.Lfunc_begin0
	.xword	.Ltmp219-.Lfunc_begin0
	.hword	12
	.byte	48
	.byte	159
	.byte	147
	.byte	4
	.byte	48
	.byte	159
	.byte	147
	.byte	4
	.byte	48
	.byte	159
	.byte	147
	.byte	8
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp263-.Lfunc_begin0
	.hword	10
	.byte	100
	.byte	147
	.byte	4
	.byte	48
	.byte	159
	.byte	147
	.byte	4
	.byte	101
	.byte	147
	.byte	8
	.xword	.Ltmp363-.Lfunc_begin0
	.xword	.Ltmp365-.Lfunc_begin0
	.hword	10
	.byte	100
	.byte	147
	.byte	4
	.byte	48
	.byte	159
	.byte	147
	.byte	4
	.byte	101
	.byte	147
	.byte	8
	.xword	.Ltmp365-.Lfunc_begin0
	.xword	.Lfunc_end3-.Lfunc_begin0
	.hword	9
	.byte	147
	.byte	4
	.byte	48
	.byte	159
	.byte	147
	.byte	4
	.byte	101
	.byte	147
	.byte	8
	.xword	0
	.xword	0
.Ldebug_loc40:
	.xword	.Ltmp200-.Lfunc_begin0
	.xword	.Ltmp216-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc41:
	.xword	.Ltmp200-.Lfunc_begin0
	.xword	.Ltmp263-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp363-.Lfunc_begin0
	.xword	.Lfunc_end3-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc42:
	.xword	.Ltmp202-.Lfunc_begin0
	.xword	.Ltmp203-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp203-.Lfunc_begin0
	.xword	.Ltmp207-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	0
	.xword	0
.Ldebug_loc43:
	.xword	.Ltmp202-.Lfunc_begin0
	.xword	.Ltmp207-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc44:
	.xword	.Ltmp202-.Lfunc_begin0
	.xword	.Ltmp212-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp212-.Lfunc_begin0
	.xword	.Ltmp217-.Lfunc_begin0
	.hword	1
	.byte	104
	.xword	0
	.xword	0
.Ldebug_loc45:
	.xword	.Ltmp202-.Lfunc_begin0
	.xword	.Ltmp208-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc46:
	.xword	.Ltmp202-.Lfunc_begin0
	.xword	.Ltmp211-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc47:
	.xword	.Ltmp202-.Lfunc_begin0
	.xword	.Ltmp207-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	148
	.byte	1
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc48:
	.xword	.Ltmp202-.Lfunc_begin0
	.xword	.Ltmp217-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc49:
	.xword	.Ltmp202-.Lfunc_begin0
	.xword	.Ltmp217-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc50:
	.xword	.Ltmp215-.Lfunc_begin0
	.xword	.Ltmp217-.Lfunc_begin0
	.hword	4
	.byte	16
	.byte	192
	.byte	27
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc51:
	.xword	.Ltmp215-.Lfunc_begin0
	.xword	.Ltmp217-.Lfunc_begin0
	.hword	4
	.byte	16
	.byte	192
	.byte	25
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc52:
	.xword	.Ltmp215-.Lfunc_begin0
	.xword	.Ltmp216-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp216-.Lfunc_begin0
	.xword	.Ltmp218-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp218-.Lfunc_begin0
	.xword	.Ltmp224-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	0
	.xword	0
.Ldebug_loc53:
	.xword	.Ltmp215-.Lfunc_begin0
	.xword	.Ltmp224-.Lfunc_begin0
	.hword	1
	.byte	104
	.xword	0
	.xword	0
.Ldebug_loc54:
	.xword	.Ltmp215-.Lfunc_begin0
	.xword	.Ltmp217-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	0
	.xword	0
.Ldebug_loc55:
	.xword	.Ltmp215-.Lfunc_begin0
	.xword	.Ltmp217-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	0
	.xword	0
.Ldebug_loc56:
	.xword	.Ltmp215-.Lfunc_begin0
	.xword	.Ltmp224-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	0
	.xword	0
.Ldebug_loc57:
	.xword	.Ltmp220-.Lfunc_begin0
	.xword	.Ltmp222-.Lfunc_begin0
	.hword	15
	.byte	120
	.byte	0
	.byte	16
	.byte	128
	.byte	248
	.byte	1
	.byte	26
	.byte	16
	.byte	255
	.byte	255
	.byte	255
	.byte	255
	.byte	15
	.byte	26
	.byte	159
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Ltmp223-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc58:
	.xword	.Ltmp220-.Lfunc_begin0
	.xword	.Ltmp222-.Lfunc_begin0
	.hword	15
	.byte	120
	.byte	0
	.byte	16
	.byte	128
	.byte	248
	.byte	1
	.byte	26
	.byte	16
	.byte	255
	.byte	255
	.byte	255
	.byte	255
	.byte	15
	.byte	26
	.byte	159
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Ltmp223-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc59:
	.xword	.Ltmp226-.Lfunc_begin0
	.xword	.Ltmp228-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	0
	.xword	0
.Ldebug_loc60:
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp229-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp229-.Lfunc_begin0
	.xword	.Ltmp231-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp231-.Lfunc_begin0
	.xword	.Ltmp235-.Lfunc_begin0
	.hword	12
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	120
	.byte	0
	.byte	34
	.byte	159
	.xword	.Ltmp242-.Lfunc_begin0
	.xword	.Ltmp243-.Lfunc_begin0
	.hword	15
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	2
	.byte	120
	.byte	0
	.byte	34
	.byte	34
	.byte	159
	.xword	.Ltmp243-.Lfunc_begin0
	.xword	.Ltmp244-.Lfunc_begin0
	.hword	15
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	3
	.byte	120
	.byte	0
	.byte	34
	.byte	34
	.byte	159
	.xword	.Ltmp244-.Lfunc_begin0
	.xword	.Ltmp245-.Lfunc_begin0
	.hword	15
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	4
	.byte	120
	.byte	0
	.byte	34
	.byte	34
	.byte	159
	.xword	.Ltmp245-.Lfunc_begin0
	.xword	.Ltmp246-.Lfunc_begin0
	.hword	15
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	5
	.byte	120
	.byte	0
	.byte	34
	.byte	34
	.byte	159
	.xword	.Ltmp246-.Lfunc_begin0
	.xword	.Ltmp247-.Lfunc_begin0
	.hword	15
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	6
	.byte	120
	.byte	0
	.byte	34
	.byte	34
	.byte	159
	.xword	.Ltmp247-.Lfunc_begin0
	.xword	.Ltmp248-.Lfunc_begin0
	.hword	15
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	7
	.byte	120
	.byte	0
	.byte	34
	.byte	34
	.byte	159
	.xword	.Ltmp248-.Lfunc_begin0
	.xword	.Ltmp249-.Lfunc_begin0
	.hword	15
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	8
	.byte	120
	.byte	0
	.byte	34
	.byte	34
	.byte	159
	.xword	.Ltmp249-.Lfunc_begin0
	.xword	.Ltmp250-.Lfunc_begin0
	.hword	15
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	9
	.byte	120
	.byte	0
	.byte	34
	.byte	34
	.byte	159
	.xword	.Ltmp250-.Lfunc_begin0
	.xword	.Ltmp251-.Lfunc_begin0
	.hword	15
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	10
	.byte	120
	.byte	0
	.byte	34
	.byte	34
	.byte	159
	.xword	.Ltmp251-.Lfunc_begin0
	.xword	.Ltmp252-.Lfunc_begin0
	.hword	15
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	11
	.byte	120
	.byte	0
	.byte	34
	.byte	34
	.byte	159
	.xword	.Ltmp252-.Lfunc_begin0
	.xword	.Ltmp253-.Lfunc_begin0
	.hword	15
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	12
	.byte	120
	.byte	0
	.byte	34
	.byte	34
	.byte	159
	.xword	.Ltmp253-.Lfunc_begin0
	.xword	.Ltmp254-.Lfunc_begin0
	.hword	15
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	1
	.byte	120
	.byte	0
	.byte	34
	.byte	34
	.byte	159
	.xword	.Ltmp254-.Lfunc_begin0
	.xword	.Ltmp255-.Lfunc_begin0
	.hword	15
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	13
	.byte	120
	.byte	0
	.byte	34
	.byte	34
	.byte	159
	.xword	.Ltmp255-.Lfunc_begin0
	.xword	.Ltmp256-.Lfunc_begin0
	.hword	15
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	14
	.byte	120
	.byte	0
	.byte	34
	.byte	34
	.byte	159
	.xword	.Ltmp256-.Lfunc_begin0
	.xword	.Ltmp257-.Lfunc_begin0
	.hword	15
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	15
	.byte	120
	.byte	0
	.byte	34
	.byte	34
	.byte	159
	.xword	.Ltmp257-.Lfunc_begin0
	.xword	.Ltmp260-.Lfunc_begin0
	.hword	15
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	16
	.byte	120
	.byte	0
	.byte	34
	.byte	34
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc61:
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp229-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp231-.Lfunc_begin0
	.xword	.Ltmp261-.Lfunc_begin0
	.hword	1
	.byte	96
	.xword	0
	.xword	0
.Ldebug_loc62:
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp229-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc63:
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp229-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp232-.Lfunc_begin0
	.xword	.Ltmp241-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	15
	.byte	159
	.xword	.Ltmp241-.Lfunc_begin0
	.xword	.Ltmp261-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	16
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc64:
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp229-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp231-.Lfunc_begin0
	.xword	.Ltmp235-.Lfunc_begin0
	.hword	6
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	159
	.xword	.Ltmp257-.Lfunc_begin0
	.xword	.Ltmp261-.Lfunc_begin0
	.hword	9
	.byte	126
	.byte	0
	.byte	17
	.byte	16
	.byte	27
	.byte	17
	.byte	1
	.byte	34
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc65:
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp229-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp229-.Lfunc_begin0
	.xword	.Ltmp261-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	0
	.xword	0
.Ldebug_loc66:
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp223-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp223-.Lfunc_begin0
	.xword	.Ltmp261-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc67:
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp229-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	0
	.xword	0
.Ldebug_loc68:
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Ltmp224-.Lfunc_begin0
	.hword	4
	.byte	16
	.byte	192
	.byte	27
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc69:
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Ltmp224-.Lfunc_begin0
	.hword	4
	.byte	16
	.byte	192
	.byte	25
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc70:
	.xword	.Ltmp231-.Lfunc_begin0
	.xword	.Ltmp232-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp232-.Lfunc_begin0
	.xword	.Ltmp233-.Lfunc_begin0
	.hword	5
	.byte	129
	.byte	0
	.byte	51
	.byte	26
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc71:
	.xword	.Ltmp241-.Lfunc_begin0
	.xword	.Ltmp258-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	0
	.xword	0
.Ldebug_loc72:
	.xword	.Ltmp266-.Lfunc_begin0
	.xword	.Ltmp268-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	.Ltmp269-.Lfunc_begin0
	.xword	.Ltmp274-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc73:
	.xword	.Ltmp267-.Lfunc_begin0
	.xword	.Ltmp269-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp269-.Lfunc_begin0
	.xword	.Ltmp277-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc74:
	.xword	.Ltmp267-.Lfunc_begin0
	.xword	.Ltmp277-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	1
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc75:
	.xword	.Ltmp267-.Lfunc_begin0
	.xword	.Ltmp277-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc76:
	.xword	.Ltmp267-.Lfunc_begin0
	.xword	.Ltmp277-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc77:
	.xword	.Ltmp267-.Lfunc_begin0
	.xword	.Ltmp277-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc78:
	.xword	.Ltmp267-.Lfunc_begin0
	.xword	.Ltmp277-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc79:
	.xword	.Ltmp267-.Lfunc_begin0
	.xword	.Ltmp277-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc80:
	.xword	.Ltmp267-.Lfunc_begin0
	.xword	.Ltmp277-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc81:
	.xword	.Ltmp269-.Lfunc_begin0
	.xword	.Ltmp270-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp270-.Lfunc_begin0
	.xword	.Ltmp274-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	0
	.xword	0
.Ldebug_loc82:
	.xword	.Ltmp269-.Lfunc_begin0
	.xword	.Ltmp274-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc83:
	.xword	.Ltmp269-.Lfunc_begin0
	.xword	.Ltmp277-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc84:
	.xword	.Ltmp269-.Lfunc_begin0
	.xword	.Ltmp275-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc85:
	.xword	.Ltmp269-.Lfunc_begin0
	.xword	.Ltmp276-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc86:
	.xword	.Ltmp269-.Lfunc_begin0
	.xword	.Ltmp274-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	212
	.byte	3
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc87:
	.xword	.Ltmp269-.Lfunc_begin0
	.xword	.Ltmp277-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	212
	.byte	14
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc88:
	.xword	.Ltmp269-.Lfunc_begin0
	.xword	.Ltmp277-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	212
	.byte	3
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc89:
	.xword	.Ltmp279-.Lfunc_begin0
	.xword	.Ltmp281-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	.Ltmp282-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc90:
	.xword	.Ltmp280-.Lfunc_begin0
	.xword	.Ltmp282-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp282-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc91:
	.xword	.Ltmp280-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	2
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc92:
	.xword	.Ltmp280-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc93:
	.xword	.Ltmp280-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc94:
	.xword	.Ltmp280-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc95:
	.xword	.Ltmp280-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc96:
	.xword	.Ltmp280-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	2
	.byte	50
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc97:
	.xword	.Ltmp280-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc98:
	.xword	.Ltmp280-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc99:
	.xword	.Ltmp282-.Lfunc_begin0
	.xword	.Ltmp283-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp283-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	0
	.xword	0
.Ldebug_loc100:
	.xword	.Ltmp282-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc101:
	.xword	.Ltmp282-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc102:
	.xword	.Ltmp282-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc103:
	.xword	.Ltmp282-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc104:
	.xword	.Ltmp282-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	212
	.byte	1
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc105:
	.xword	.Ltmp282-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	212
	.byte	6
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc106:
	.xword	.Ltmp282-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	212
	.byte	1
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc107:
	.xword	.Ltmp289-.Lfunc_begin0
	.xword	.Ltmp291-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	.Ltmp292-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc108:
	.xword	.Ltmp290-.Lfunc_begin0
	.xword	.Ltmp292-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp292-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc109:
	.xword	.Ltmp290-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	2
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc110:
	.xword	.Ltmp290-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc111:
	.xword	.Ltmp290-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc112:
	.xword	.Ltmp290-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc113:
	.xword	.Ltmp290-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc114:
	.xword	.Ltmp290-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	2
	.byte	50
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc115:
	.xword	.Ltmp290-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc116:
	.xword	.Ltmp290-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc117:
	.xword	.Ltmp292-.Lfunc_begin0
	.xword	.Ltmp293-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp293-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	0
	.xword	0
.Ldebug_loc118:
	.xword	.Ltmp292-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc119:
	.xword	.Ltmp292-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc120:
	.xword	.Ltmp292-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc121:
	.xword	.Ltmp292-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc122:
	.xword	.Ltmp292-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	212
	.byte	1
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc123:
	.xword	.Ltmp292-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	212
	.byte	6
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc124:
	.xword	.Ltmp292-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	212
	.byte	1
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc125:
	.xword	.Ltmp301-.Lfunc_begin0
	.xword	.Ltmp303-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	.Ltmp304-.Lfunc_begin0
	.xword	.Ltmp309-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc126:
	.xword	.Ltmp302-.Lfunc_begin0
	.xword	.Ltmp304-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp304-.Lfunc_begin0
	.xword	.Ltmp312-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc127:
	.xword	.Ltmp302-.Lfunc_begin0
	.xword	.Ltmp312-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	3
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc128:
	.xword	.Ltmp302-.Lfunc_begin0
	.xword	.Ltmp312-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc129:
	.xword	.Ltmp302-.Lfunc_begin0
	.xword	.Ltmp312-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc130:
	.xword	.Ltmp302-.Lfunc_begin0
	.xword	.Ltmp312-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc131:
	.xword	.Ltmp302-.Lfunc_begin0
	.xword	.Ltmp312-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc132:
	.xword	.Ltmp302-.Lfunc_begin0
	.xword	.Ltmp312-.Lfunc_begin0
	.hword	2
	.byte	51
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc133:
	.xword	.Ltmp302-.Lfunc_begin0
	.xword	.Ltmp312-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc134:
	.xword	.Ltmp302-.Lfunc_begin0
	.xword	.Ltmp312-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc135:
	.xword	.Ltmp304-.Lfunc_begin0
	.xword	.Ltmp305-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp305-.Lfunc_begin0
	.xword	.Ltmp309-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	0
	.xword	0
.Ldebug_loc136:
	.xword	.Ltmp304-.Lfunc_begin0
	.xword	.Ltmp309-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc137:
	.xword	.Ltmp304-.Lfunc_begin0
	.xword	.Ltmp312-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc138:
	.xword	.Ltmp304-.Lfunc_begin0
	.xword	.Ltmp310-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc139:
	.xword	.Ltmp304-.Lfunc_begin0
	.xword	.Ltmp311-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc140:
	.xword	.Ltmp304-.Lfunc_begin0
	.xword	.Ltmp309-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	148
	.byte	2
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc141:
	.xword	.Ltmp304-.Lfunc_begin0
	.xword	.Ltmp312-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	212
	.byte	8
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc142:
	.xword	.Ltmp304-.Lfunc_begin0
	.xword	.Ltmp312-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	148
	.byte	2
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc143:
	.xword	.Ltmp314-.Lfunc_begin0
	.xword	.Ltmp316-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	.Ltmp317-.Lfunc_begin0
	.xword	.Ltmp322-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc144:
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp317-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp317-.Lfunc_begin0
	.xword	.Ltmp325-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc145:
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp325-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	4
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc146:
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp325-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc147:
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp325-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc148:
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp325-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc149:
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp325-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc150:
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp325-.Lfunc_begin0
	.hword	2
	.byte	52
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc151:
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp325-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc152:
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp325-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc153:
	.xword	.Ltmp317-.Lfunc_begin0
	.xword	.Ltmp318-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp318-.Lfunc_begin0
	.xword	.Ltmp322-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	0
	.xword	0
.Ldebug_loc154:
	.xword	.Ltmp317-.Lfunc_begin0
	.xword	.Ltmp322-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc155:
	.xword	.Ltmp317-.Lfunc_begin0
	.xword	.Ltmp325-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc156:
	.xword	.Ltmp317-.Lfunc_begin0
	.xword	.Ltmp323-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc157:
	.xword	.Ltmp317-.Lfunc_begin0
	.xword	.Ltmp324-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc158:
	.xword	.Ltmp317-.Lfunc_begin0
	.xword	.Ltmp322-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	212
	.byte	2
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc159:
	.xword	.Ltmp317-.Lfunc_begin0
	.xword	.Ltmp325-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	212
	.byte	10
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc160:
	.xword	.Ltmp317-.Lfunc_begin0
	.xword	.Ltmp325-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	212
	.byte	2
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc161:
	.xword	.Ltmp327-.Lfunc_begin0
	.xword	.Ltmp329-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	.Ltmp330-.Lfunc_begin0
	.xword	.Ltmp335-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc162:
	.xword	.Ltmp328-.Lfunc_begin0
	.xword	.Ltmp330-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp330-.Lfunc_begin0
	.xword	.Ltmp338-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc163:
	.xword	.Ltmp328-.Lfunc_begin0
	.xword	.Ltmp338-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	5
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc164:
	.xword	.Ltmp328-.Lfunc_begin0
	.xword	.Ltmp338-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc165:
	.xword	.Ltmp328-.Lfunc_begin0
	.xword	.Ltmp338-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc166:
	.xword	.Ltmp328-.Lfunc_begin0
	.xword	.Ltmp338-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc167:
	.xword	.Ltmp328-.Lfunc_begin0
	.xword	.Ltmp338-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc168:
	.xword	.Ltmp328-.Lfunc_begin0
	.xword	.Ltmp338-.Lfunc_begin0
	.hword	2
	.byte	53
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc169:
	.xword	.Ltmp328-.Lfunc_begin0
	.xword	.Ltmp338-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc170:
	.xword	.Ltmp328-.Lfunc_begin0
	.xword	.Ltmp338-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc171:
	.xword	.Ltmp330-.Lfunc_begin0
	.xword	.Ltmp331-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp331-.Lfunc_begin0
	.xword	.Ltmp335-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	0
	.xword	0
.Ldebug_loc172:
	.xword	.Ltmp330-.Lfunc_begin0
	.xword	.Ltmp335-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc173:
	.xword	.Ltmp330-.Lfunc_begin0
	.xword	.Ltmp338-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc174:
	.xword	.Ltmp330-.Lfunc_begin0
	.xword	.Ltmp336-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc175:
	.xword	.Ltmp330-.Lfunc_begin0
	.xword	.Ltmp337-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc176:
	.xword	.Ltmp330-.Lfunc_begin0
	.xword	.Ltmp335-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	148
	.byte	3
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc177:
	.xword	.Ltmp330-.Lfunc_begin0
	.xword	.Ltmp338-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	212
	.byte	12
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc178:
	.xword	.Ltmp330-.Lfunc_begin0
	.xword	.Ltmp338-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	148
	.byte	3
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc179:
	.xword	.Ltmp340-.Lfunc_begin0
	.xword	.Ltmp342-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	.Ltmp343-.Lfunc_begin0
	.xword	.Ltmp348-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc180:
	.xword	.Ltmp341-.Lfunc_begin0
	.xword	.Ltmp343-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp343-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc181:
	.xword	.Ltmp341-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	6
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc182:
	.xword	.Ltmp341-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc183:
	.xword	.Ltmp341-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc184:
	.xword	.Ltmp341-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc185:
	.xword	.Ltmp341-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc186:
	.xword	.Ltmp341-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	0
	.xword	0
.Ldebug_loc187:
	.xword	.Ltmp341-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc188:
	.xword	.Ltmp343-.Lfunc_begin0
	.xword	.Ltmp344-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp344-.Lfunc_begin0
	.xword	.Ltmp348-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	0
	.xword	0
.Ldebug_loc189:
	.xword	.Ltmp343-.Lfunc_begin0
	.xword	.Ltmp348-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc190:
	.xword	.Ltmp343-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc191:
	.xword	.Ltmp343-.Lfunc_begin0
	.xword	.Ltmp349-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc192:
	.xword	.Ltmp343-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc193:
	.xword	.Ltmp343-.Lfunc_begin0
	.xword	.Ltmp348-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	148
	.byte	4
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc194:
	.xword	.Ltmp343-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	212
	.byte	16
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc195:
	.xword	.Ltmp343-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	148
	.byte	4
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc196:
	.xword	.Lfunc_begin4-.Lfunc_begin0
	.xword	.Ltmp370-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp370-.Lfunc_begin0
	.xword	.Ltmp412-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	0
	.xword	0
.Ldebug_loc197:
	.xword	.Lfunc_begin4-.Lfunc_begin0
	.xword	.Ltmp370-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp371-.Lfunc_begin0
	.xword	.Ltmp373-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp373-.Lfunc_begin0
	.xword	.Ltmp375-.Lfunc_begin0
	.hword	6
	.byte	125
	.byte	0
	.byte	17
	.byte	4
	.byte	27
	.byte	159
	.xword	.Ltmp408-.Lfunc_begin0
	.xword	.Ltmp412-.Lfunc_begin0
	.hword	9
	.byte	125
	.byte	0
	.byte	17
	.byte	4
	.byte	27
	.byte	17
	.byte	1
	.byte	34
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc198:
	.xword	.Lfunc_begin4-.Lfunc_begin0
	.xword	.Ltmp370-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp374-.Lfunc_begin0
	.xword	.Ltmp378-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp378-.Lfunc_begin0
	.xword	.Ltmp380-.Lfunc_begin0
	.hword	2
	.byte	49
	.byte	159
	.xword	.Ltmp380-.Lfunc_begin0
	.xword	.Ltmp382-.Lfunc_begin0
	.hword	2
	.byte	50
	.byte	159
	.xword	.Ltmp382-.Lfunc_begin0
	.xword	.Ltmp384-.Lfunc_begin0
	.hword	2
	.byte	51
	.byte	159
	.xword	.Ltmp384-.Lfunc_begin0
	.xword	.Ltmp386-.Lfunc_begin0
	.hword	2
	.byte	52
	.byte	159
	.xword	.Ltmp386-.Lfunc_begin0
	.xword	.Ltmp388-.Lfunc_begin0
	.hword	2
	.byte	53
	.byte	159
	.xword	.Ltmp388-.Lfunc_begin0
	.xword	.Ltmp390-.Lfunc_begin0
	.hword	2
	.byte	54
	.byte	159
	.xword	.Ltmp390-.Lfunc_begin0
	.xword	.Ltmp392-.Lfunc_begin0
	.hword	2
	.byte	55
	.byte	159
	.xword	.Ltmp392-.Lfunc_begin0
	.xword	.Ltmp394-.Lfunc_begin0
	.hword	2
	.byte	56
	.byte	159
	.xword	.Ltmp394-.Lfunc_begin0
	.xword	.Ltmp396-.Lfunc_begin0
	.hword	2
	.byte	57
	.byte	159
	.xword	.Ltmp396-.Lfunc_begin0
	.xword	.Ltmp398-.Lfunc_begin0
	.hword	2
	.byte	58
	.byte	159
	.xword	.Ltmp398-.Lfunc_begin0
	.xword	.Ltmp400-.Lfunc_begin0
	.hword	2
	.byte	59
	.byte	159
	.xword	.Ltmp400-.Lfunc_begin0
	.xword	.Ltmp402-.Lfunc_begin0
	.hword	2
	.byte	60
	.byte	159
	.xword	.Ltmp402-.Lfunc_begin0
	.xword	.Ltmp404-.Lfunc_begin0
	.hword	2
	.byte	61
	.byte	159
	.xword	.Ltmp404-.Lfunc_begin0
	.xword	.Ltmp406-.Lfunc_begin0
	.hword	2
	.byte	62
	.byte	159
	.xword	.Ltmp406-.Lfunc_begin0
	.xword	.Ltmp408-.Lfunc_begin0
	.hword	2
	.byte	63
	.byte	159
	.xword	.Ltmp408-.Lfunc_begin0
	.xword	.Ltmp412-.Lfunc_begin0
	.hword	2
	.byte	64
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc199:
	.xword	.Ltmp370-.Lfunc_begin0
	.xword	.Ltmp371-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp371-.Lfunc_begin0
	.xword	.Ltmp373-.Lfunc_begin0
	.hword	21
	.byte	127
	.byte	0
	.byte	122
	.byte	0
	.byte	52
	.byte	36
	.byte	18
	.byte	16
	.byte	31
	.byte	37
	.byte	48
	.byte	32
	.byte	30
	.byte	16
	.byte	32
	.byte	36
	.byte	33
	.byte	52
	.byte	30
	.byte	34
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc200:
	.xword	.Ltmp374-.Lfunc_begin0
	.xword	.Ltmp377-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp377-.Lfunc_begin0
	.xword	.Ltmp378-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp378-.Lfunc_begin0
	.xword	.Ltmp379-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp379-.Lfunc_begin0
	.xword	.Ltmp380-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp380-.Lfunc_begin0
	.xword	.Ltmp381-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp381-.Lfunc_begin0
	.xword	.Ltmp382-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp382-.Lfunc_begin0
	.xword	.Ltmp383-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp384-.Lfunc_begin0
	.xword	.Ltmp385-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp385-.Lfunc_begin0
	.xword	.Ltmp386-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp386-.Lfunc_begin0
	.xword	.Ltmp387-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp387-.Lfunc_begin0
	.xword	.Ltmp388-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp388-.Lfunc_begin0
	.xword	.Ltmp389-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp389-.Lfunc_begin0
	.xword	.Ltmp390-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp390-.Lfunc_begin0
	.xword	.Ltmp391-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp391-.Lfunc_begin0
	.xword	.Ltmp392-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp392-.Lfunc_begin0
	.xword	.Ltmp393-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp393-.Lfunc_begin0
	.xword	.Ltmp394-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp394-.Lfunc_begin0
	.xword	.Ltmp395-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp395-.Lfunc_begin0
	.xword	.Ltmp396-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp396-.Lfunc_begin0
	.xword	.Ltmp397-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp397-.Lfunc_begin0
	.xword	.Ltmp398-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp398-.Lfunc_begin0
	.xword	.Ltmp399-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp399-.Lfunc_begin0
	.xword	.Ltmp400-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp400-.Lfunc_begin0
	.xword	.Ltmp401-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp401-.Lfunc_begin0
	.xword	.Ltmp402-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp402-.Lfunc_begin0
	.xword	.Ltmp403-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp403-.Lfunc_begin0
	.xword	.Ltmp404-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp404-.Lfunc_begin0
	.xword	.Ltmp405-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp405-.Lfunc_begin0
	.xword	.Ltmp406-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp406-.Lfunc_begin0
	.xword	.Ltmp407-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
	.section	.debug_abbrev,"",@progbits
	.byte	1
	.byte	17
	.byte	1
	.byte	37
	.byte	14
	.byte	19
	.byte	5
	.byte	3
	.byte	14
	.byte	16
	.byte	23
	.byte	27
	.byte	14
	.byte	17
	.byte	1
	.byte	18
	.byte	6
	.byte	0
	.byte	0
	.byte	2
	.byte	46
	.byte	1
	.byte	17
	.byte	1
	.byte	18
	.byte	6
	.byte	64
	.byte	24
	.ascii	"\227B"
	.byte	25
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	5
	.byte	39
	.byte	25
	.byte	73
	.byte	19
	.byte	63
	.byte	25
	.byte	0
	.byte	0
	.byte	3
	.byte	52
	.byte	0
	.byte	3
	.byte	14
	.byte	73
	.byte	19
	.byte	58
	.byte	11
	.byte	59
	.byte	5
	.byte	2
	.byte	24
	.byte	0
	.byte	0
	.byte	4
	.byte	5
	.byte	0
	.byte	2
	.byte	23
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	5
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	5
	.byte	52
	.byte	0
	.byte	2
	.byte	23
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	5
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	6
	.byte	29
	.byte	1
	.byte	49
	.byte	19
	.byte	85
	.byte	23
	.byte	88
	.byte	11
	.byte	89
	.byte	5
	.byte	87
	.byte	11
	.byte	0
	.byte	0
	.byte	7
	.byte	5
	.byte	0
	.byte	2
	.byte	23
	.byte	49
	.byte	19
	.byte	0
	.byte	0
	.byte	8
	.byte	52
	.byte	0
	.byte	2
	.byte	23
	.byte	49
	.byte	19
	.byte	0
	.byte	0
	.byte	9
	.ascii	"\211\202\001"
	.byte	0
	.byte	49
	.byte	19
	.byte	17
	.byte	1
	.byte	0
	.byte	0
	.byte	10
	.ascii	"\211\202\001"
	.byte	1
	.byte	49
	.byte	19
	.byte	17
	.byte	1
	.byte	0
	.byte	0
	.byte	11
	.ascii	"\212\202\001"
	.byte	0
	.byte	2
	.byte	24
	.ascii	"\221B"
	.byte	24
	.byte	0
	.byte	0
	.byte	12
	.byte	4
	.byte	1
	.byte	73
	.byte	19
	.byte	3
	.byte	14
	.byte	11
	.byte	11
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	0
	.byte	0
	.byte	13
	.byte	40
	.byte	0
	.byte	3
	.byte	14
	.byte	28
	.byte	15
	.byte	0
	.byte	0
	.byte	14
	.byte	36
	.byte	0
	.byte	3
	.byte	14
	.byte	62
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	0
	.byte	15
	.byte	52
	.byte	0
	.byte	3
	.byte	14
	.byte	73
	.byte	19
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	2
	.byte	24
	.byte	0
	.byte	0
	.byte	16
	.byte	15
	.byte	0
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	17
	.byte	19
	.byte	1
	.byte	3
	.byte	14
	.byte	11
	.byte	5
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	0
	.byte	0
	.byte	18
	.byte	13
	.byte	0
	.byte	3
	.byte	14
	.byte	73
	.byte	19
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	56
	.byte	11
	.byte	0
	.byte	0
	.byte	19
	.byte	13
	.byte	0
	.byte	3
	.byte	14
	.byte	73
	.byte	19
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	56
	.byte	5
	.byte	0
	.byte	0
	.byte	20
	.byte	1
	.byte	1
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	21
	.byte	33
	.byte	0
	.byte	73
	.byte	19
	.byte	55
	.byte	11
	.byte	0
	.byte	0
	.byte	22
	.byte	36
	.byte	0
	.byte	3
	.byte	14
	.byte	11
	.byte	11
	.byte	62
	.byte	11
	.byte	0
	.byte	0
	.byte	23
	.byte	33
	.byte	0
	.byte	73
	.byte	19
	.byte	55
	.byte	5
	.byte	0
	.byte	0
	.byte	24
	.byte	4
	.byte	1
	.byte	73
	.byte	19
	.byte	11
	.byte	11
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	0
	.byte	0
	.byte	25
	.byte	4
	.byte	1
	.byte	73
	.byte	19
	.byte	3
	.byte	14
	.byte	11
	.byte	11
	.byte	58
	.byte	11
	.byte	59
	.byte	5
	.byte	0
	.byte	0
	.byte	26
	.byte	38
	.byte	0
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	27
	.byte	22
	.byte	0
	.byte	73
	.byte	19
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	0
	.byte	0
	.byte	28
	.byte	15
	.byte	0
	.byte	0
	.byte	0
	.byte	29
	.byte	46
	.byte	1
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	39
	.byte	25
	.byte	73
	.byte	19
	.byte	32
	.byte	11
	.byte	0
	.byte	0
	.byte	30
	.byte	5
	.byte	0
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	31
	.byte	52
	.byte	0
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	32
	.byte	46
	.byte	1
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	39
	.byte	25
	.byte	32
	.byte	11
	.byte	0
	.byte	0
	.byte	33
	.byte	46
	.byte	1
	.byte	17
	.byte	1
	.byte	18
	.byte	6
	.byte	64
	.byte	24
	.ascii	"\227B"
	.byte	25
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	39
	.byte	25
	.byte	73
	.byte	19
	.byte	63
	.byte	25
	.byte	0
	.byte	0
	.byte	34
	.byte	5
	.byte	0
	.byte	2
	.byte	23
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	35
	.byte	52
	.byte	0
	.byte	2
	.byte	23
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	36
	.byte	29
	.byte	1
	.byte	49
	.byte	19
	.byte	85
	.byte	23
	.byte	88
	.byte	11
	.byte	89
	.byte	11
	.byte	87
	.byte	11
	.byte	0
	.byte	0
	.byte	37
	.byte	29
	.byte	1
	.byte	49
	.byte	19
	.byte	17
	.byte	1
	.byte	18
	.byte	6
	.byte	88
	.byte	11
	.byte	89
	.byte	11
	.byte	87
	.byte	11
	.byte	0
	.byte	0
	.byte	38
	.byte	5
	.byte	0
	.byte	28
	.byte	15
	.byte	49
	.byte	19
	.byte	0
	.byte	0
	.byte	39
	.byte	52
	.byte	0
	.byte	2
	.byte	24
	.byte	49
	.byte	19
	.byte	0
	.byte	0
	.byte	40
	.byte	46
	.byte	0
	.byte	17
	.byte	1
	.byte	18
	.byte	6
	.byte	64
	.byte	24
	.ascii	"\227B"
	.byte	25
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	39
	.byte	25
	.byte	73
	.byte	19
	.byte	63
	.byte	25
	.byte	0
	.byte	0
	.byte	41
	.byte	46
	.byte	1
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	5
	.byte	39
	.byte	25
	.byte	73
	.byte	19
	.byte	32
	.byte	11
	.byte	0
	.byte	0
	.byte	42
	.byte	5
	.byte	0
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	5
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	43
	.byte	52
	.byte	0
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	5
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	44
	.byte	46
	.byte	1
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	39
	.byte	25
	.byte	60
	.byte	25
	.byte	63
	.byte	25
	.byte	0
	.byte	0
	.byte	45
	.byte	5
	.byte	0
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	46
	.byte	38
	.byte	0
	.byte	0
	.byte	0
	.byte	47
	.byte	46
	.byte	1
	.byte	17
	.byte	1
	.byte	18
	.byte	6
	.byte	64
	.byte	24
	.ascii	"\227B"
	.byte	25
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	5
	.byte	39
	.byte	25
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	48
	.byte	11
	.byte	1
	.byte	17
	.byte	1
	.byte	18
	.byte	6
	.byte	0
	.byte	0
	.byte	49
	.byte	52
	.byte	0
	.byte	28
	.byte	13
	.byte	49
	.byte	19
	.byte	0
	.byte	0
	.byte	50
	.byte	29
	.byte	1
	.byte	49
	.byte	19
	.byte	17
	.byte	1
	.byte	18
	.byte	6
	.byte	88
	.byte	11
	.byte	89
	.byte	5
	.byte	87
	.byte	11
	.byte	0
	.byte	0
	.byte	51
	.byte	5
	.byte	0
	.byte	2
	.byte	24
	.byte	49
	.byte	19
	.byte	0
	.byte	0
	.byte	52
	.byte	11
	.byte	1
	.byte	85
	.byte	23
	.byte	0
	.byte	0
	.byte	53
	.byte	5
	.byte	0
	.byte	2
	.byte	24
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	5
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	54
	.byte	46
	.byte	0
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	39
	.byte	25
	.byte	73
	.byte	19
	.byte	60
	.byte	25
	.byte	63
	.byte	25
	.byte	0
	.byte	0
	.byte	55
	.byte	19
	.byte	1
	.byte	3
	.byte	14
	.byte	11
	.byte	11
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	0
	.byte	0
	.byte	56
	.byte	11
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.word	.Ldebug_info_end0-.Ldebug_info_start0
.Ldebug_info_start0:
	.hword	4
	.word	.debug_abbrev
	.byte	8
	.byte	1
	.word	.Linfo_string0
	.hword	12
	.word	.Linfo_string1
	.word	.Lline_table_start0
	.word	.Linfo_string2
	.xword	.Lfunc_begin0
	.word	.Lfunc_end4-.Lfunc_begin0
	.byte	2
	.xword	.Lfunc_begin2
	.word	.Lfunc_end2-.Lfunc_begin2
	.byte	1
	.byte	109

	.word	.Linfo_string139
	.byte	2
	.hword	594

	.word	556

	.byte	3
	.word	.Linfo_string3
	.word	458
	.byte	2
	.hword	596
	.byte	9
	.byte	3
	.xword	rkf_wf_get_lut.stype
	.byte	3
	.word	.Linfo_string19
	.word	556
	.byte	2
	.hword	597
	.byte	9
	.byte	3
	.xword	rkf_wf_get_lut.sftemp
	.byte	4
	.word	.Ldebug_loc14
	.word	.Linfo_string102
	.byte	2
	.hword	594
	.word	4546
	.byte	4
	.word	.Ldebug_loc15
	.word	.Linfo_string135
	.byte	2
	.hword	594
	.word	458
	.byte	4
	.word	.Ldebug_loc16
	.word	.Linfo_string145
	.byte	2
	.hword	594
	.word	556
	.byte	4
	.word	.Ldebug_loc17
	.word	.Linfo_string146
	.byte	2
	.hword	594
	.word	556
	.byte	5
	.word	.Ldebug_loc18
	.word	.Linfo_string87
	.byte	2
	.hword	599
	.word	556
	.byte	5
	.word	.Ldebug_loc19
	.word	.Linfo_string147
	.byte	2
	.hword	598
	.word	556
	.byte	6
	.word	1648
	.word	.Ldebug_ranges3
	.byte	2
	.hword	636
	.byte	4
	.byte	7
	.word	.Ldebug_loc20
	.word	1661
	.byte	7
	.word	.Ldebug_loc21
	.word	1673
	.byte	8
	.word	.Ldebug_loc22
	.word	1685
	.byte	8
	.word	.Ldebug_loc23
	.word	1697
	.byte	0
	.byte	6
	.word	1710
	.word	.Ldebug_ranges4
	.byte	2
	.hword	638
	.byte	4
	.byte	7
	.word	.Ldebug_loc24
	.word	1723
	.byte	7
	.word	.Ldebug_loc25
	.word	1735
	.byte	8
	.word	.Ldebug_loc26
	.word	1747
	.byte	8
	.word	.Ldebug_loc27
	.word	1759
	.byte	0
	.byte	9
	.word	1772
	.xword	.Ltmp72
	.byte	10
	.word	1791
	.xword	.Ltmp74
	.byte	11
	.byte	1
	.byte	82
	.byte	2
	.byte	131
	.byte	0
	.byte	11
	.byte	1
	.byte	81
	.byte	2
	.byte	133
	.byte	0
	.byte	11
	.byte	1
	.byte	80
	.byte	2
	.byte	132
	.byte	0
	.byte	0
	.byte	10
	.word	4171
	.xword	.Ltmp77
	.byte	11
	.byte	1
	.byte	82
	.byte	2
	.byte	134
	.byte	0
	.byte	11
	.byte	1
	.byte	80
	.byte	2
	.byte	132
	.byte	0
	.byte	0
	.byte	9
	.word	1772
	.xword	.Ltmp181
	.byte	9
	.word	4348
	.xword	.Ltmp183
	.byte	10
	.word	1791
	.xword	.Ltmp185
	.byte	11
	.byte	1
	.byte	82
	.byte	2
	.byte	131
	.byte	0
	.byte	11
	.byte	1
	.byte	80
	.byte	2
	.byte	132
	.byte	0
	.byte	0
	.byte	10
	.word	4171
	.xword	.Ltmp188
	.byte	11
	.byte	1
	.byte	82
	.byte	2
	.byte	133
	.byte	0
	.byte	11
	.byte	1
	.byte	80
	.byte	2
	.byte	132
	.byte	0
	.byte	0
	.byte	0
	.byte	12
	.word	549
	.word	.Linfo_string18
	.byte	4
	.byte	1
	.byte	15
	.byte	13
	.word	.Linfo_string5
	.byte	0
	.byte	13
	.word	.Linfo_string6
	.byte	1
	.byte	13
	.word	.Linfo_string7
	.byte	2
	.byte	13
	.word	.Linfo_string8
	.byte	3
	.byte	13
	.word	.Linfo_string9
	.byte	4
	.byte	13
	.word	.Linfo_string10
	.byte	5
	.byte	13
	.word	.Linfo_string11
	.byte	6
	.byte	13
	.word	.Linfo_string12
	.byte	7
	.byte	13
	.word	.Linfo_string13
	.byte	8
	.byte	13
	.word	.Linfo_string14
	.byte	9
	.byte	13
	.word	.Linfo_string15
	.byte	10
	.byte	13
	.word	.Linfo_string16
	.byte	11
	.byte	13
	.word	.Linfo_string17
	.byte	12
	.byte	0
	.byte	14
	.word	.Linfo_string4
	.byte	7
	.byte	4
	.byte	14
	.word	.Linfo_string20
	.byte	5
	.byte	4
	.byte	15
	.word	.Linfo_string21
	.word	584
	.byte	2
	.byte	55
	.byte	9
	.byte	3
	.xword	global_waveform
	.byte	16
	.word	589
	.byte	17
	.word	.Linfo_string45
	.hword	2388
	.byte	2
	.byte	30
	.byte	18
	.word	.Linfo_string22
	.word	556
	.byte	2
	.byte	31
	.byte	0
	.byte	18
	.word	.Linfo_string23
	.word	863
	.byte	2
	.byte	32
	.byte	4
	.byte	18
	.word	.Linfo_string26
	.word	863
	.byte	2
	.byte	33
	.byte	20
	.byte	18
	.word	.Linfo_string27
	.word	863
	.byte	2
	.byte	34
	.byte	36
	.byte	18
	.word	.Linfo_string28
	.word	863
	.byte	2
	.byte	35
	.byte	52
	.byte	18
	.word	.Linfo_string29
	.word	863
	.byte	2
	.byte	36
	.byte	68
	.byte	18
	.word	.Linfo_string30
	.word	889
	.byte	2
	.byte	37
	.byte	84
	.byte	18
	.word	.Linfo_string31
	.word	889
	.byte	2
	.byte	38
	.byte	148
	.byte	18
	.word	.Linfo_string32
	.word	889
	.byte	2
	.byte	39
	.byte	212
	.byte	19
	.word	.Linfo_string33
	.word	889
	.byte	2
	.byte	40
	.hword	276
	.byte	19
	.word	.Linfo_string34
	.word	889
	.byte	2
	.byte	41
	.hword	340
	.byte	19
	.word	.Linfo_string35
	.word	889
	.byte	2
	.byte	42
	.hword	404
	.byte	19
	.word	.Linfo_string36
	.word	889
	.byte	2
	.byte	43
	.hword	468
	.byte	19
	.word	.Linfo_string37
	.word	889
	.byte	2
	.byte	44
	.hword	532
	.byte	19
	.word	.Linfo_string38
	.word	901
	.byte	2
	.byte	45
	.hword	596
	.byte	19
	.word	.Linfo_string39
	.word	901
	.byte	2
	.byte	46
	.hword	852
	.byte	19
	.word	.Linfo_string40
	.word	901
	.byte	2
	.byte	47
	.hword	1108
	.byte	19
	.word	.Linfo_string41
	.word	901
	.byte	2
	.byte	48
	.hword	1364
	.byte	19
	.word	.Linfo_string42
	.word	901
	.byte	2
	.byte	49
	.hword	1620
	.byte	19
	.word	.Linfo_string43
	.word	901
	.byte	2
	.byte	50
	.hword	1876
	.byte	19
	.word	.Linfo_string44
	.word	901
	.byte	2
	.byte	51
	.hword	2132
	.byte	0
	.byte	20
	.word	875
	.byte	21
	.word	882
	.byte	16
	.byte	0
	.byte	14
	.word	.Linfo_string24
	.byte	8
	.byte	1
	.byte	22
	.word	.Linfo_string25
	.byte	8
	.byte	7
	.byte	20
	.word	875
	.byte	21
	.word	882
	.byte	64
	.byte	0
	.byte	20
	.word	549
	.byte	21
	.word	882
	.byte	64
	.byte	0
	.byte	15
	.word	.Linfo_string46
	.word	934
	.byte	2
	.byte	56
	.byte	9
	.byte	3
	.xword	crc32_table
	.byte	20
	.word	549
	.byte	23
	.word	882
	.hword	256
	.byte	0
	.byte	12
	.word	549
	.word	.Linfo_string54
	.byte	4
	.byte	2
	.byte	20
	.byte	13
	.word	.Linfo_string47
	.byte	0
	.byte	13
	.word	.Linfo_string48
	.byte	1
	.byte	13
	.word	.Linfo_string49
	.byte	2
	.byte	13
	.word	.Linfo_string50
	.byte	3
	.byte	13
	.word	.Linfo_string51
	.byte	4
	.byte	13
	.word	.Linfo_string52
	.byte	5
	.byte	13
	.word	.Linfo_string53
	.byte	6
	.byte	0
	.byte	24
	.word	549
	.byte	4
	.byte	3
	.byte	10
	.byte	13
	.word	.Linfo_string55
	.byte	0
	.byte	13
	.word	.Linfo_string56
	.byte	1
	.byte	0
	.byte	25
	.word	549
	.word	.Linfo_string62
	.byte	4
	.byte	4
	.hword	332
	.byte	13
	.word	.Linfo_string57
	.byte	0
	.byte	13
	.word	.Linfo_string58
	.byte	0
	.byte	13
	.word	.Linfo_string59
	.byte	1
	.byte	13
	.word	.Linfo_string60
	.byte	2
	.byte	13
	.word	.Linfo_string61
	.byte	3
	.byte	0
	.byte	16
	.word	1072
	.byte	26
	.word	875
	.byte	16
	.word	1082
	.byte	27
	.word	1093
	.word	.Linfo_string64
	.byte	6
	.byte	21
	.byte	27
	.word	549
	.word	.Linfo_string63
	.byte	5
	.byte	27
	.byte	16
	.word	875
	.byte	16
	.word	1114
	.byte	14
	.word	.Linfo_string65
	.byte	8
	.byte	1
	.byte	16
	.word	1126
	.byte	26
	.word	1114
	.byte	27
	.word	549
	.word	.Linfo_string66
	.byte	7
	.byte	148
	.byte	16
	.word	549
	.byte	28
	.byte	29
	.word	.Linfo_string67
	.byte	2
	.byte	91

	.word	556
	.byte	1
	.byte	30
	.word	.Linfo_string68
	.byte	2
	.byte	91
	.word	1172
	.byte	0
	.byte	16
	.word	1177
	.byte	27
	.word	1188
	.word	.Linfo_string70
	.byte	6
	.byte	17
	.byte	27
	.word	1114
	.word	.Linfo_string69
	.byte	5
	.byte	21
	.byte	29
	.word	.Linfo_string71
	.byte	2
	.byte	101

	.word	556
	.byte	1
	.byte	30
	.word	.Linfo_string72
	.byte	2
	.byte	101
	.word	584
	.byte	31
	.word	.Linfo_string73
	.byte	2
	.byte	103
	.word	1082
	.byte	31
	.word	.Linfo_string74
	.byte	2
	.byte	104
	.word	1082
	.byte	0
	.byte	29
	.word	.Linfo_string75
	.byte	2
	.byte	78

	.word	549
	.byte	1
	.byte	30
	.word	.Linfo_string76
	.byte	2
	.byte	78
	.word	1109
	.byte	30
	.word	.Linfo_string77
	.byte	2
	.byte	78
	.word	549
	.byte	31
	.word	.Linfo_string78
	.byte	2
	.byte	81
	.word	549
	.byte	31
	.word	.Linfo_string79
	.byte	2
	.byte	80
	.word	549
	.byte	0
	.byte	32
	.word	.Linfo_string80
	.byte	2
	.byte	58

	.byte	1
	.byte	30
	.word	.Linfo_string81
	.byte	2
	.byte	58
	.word	549
	.byte	30
	.word	.Linfo_string82
	.byte	2
	.byte	58
	.word	1142
	.byte	31
	.word	.Linfo_string79
	.byte	2
	.byte	60
	.word	549
	.byte	31
	.word	.Linfo_string83
	.byte	2
	.byte	61
	.word	549
	.byte	31
	.word	.Linfo_string78
	.byte	2
	.byte	62
	.word	549
	.byte	31
	.word	.Linfo_string84
	.byte	2
	.byte	60
	.word	549
	.byte	0
	.byte	33
	.xword	.Lfunc_begin0
	.word	.Lfunc_end0-.Lfunc_begin0
	.byte	1
	.byte	109

	.word	.Linfo_string137
	.byte	2
	.byte	127

	.word	556

	.byte	34
	.word	.Ldebug_loc0
	.word	.Linfo_string142
	.byte	2
	.byte	127
	.word	1147
	.byte	35
	.word	.Ldebug_loc1
	.word	.Linfo_string143
	.byte	2
	.byte	130
	.word	584
	.byte	35
	.word	.Ldebug_loc2
	.word	.Linfo_string144
	.byte	2
	.byte	129
	.word	556
	.byte	36
	.word	1148
	.word	.Ldebug_ranges0
	.byte	2
	.byte	135
	.byte	8
	.byte	7
	.word	.Ldebug_loc3
	.word	1160
	.byte	0
	.byte	36
	.word	1199
	.word	.Ldebug_ranges1
	.byte	2
	.byte	141
	.byte	8
	.byte	7
	.word	.Ldebug_loc4
	.word	1211
	.byte	8
	.word	.Ldebug_loc5
	.word	1222
	.byte	8
	.word	.Ldebug_loc6
	.word	1233
	.byte	36
	.word	1245
	.word	.Ldebug_ranges2
	.byte	2
	.byte	110
	.byte	13
	.byte	7
	.word	.Ldebug_loc10
	.word	1257
	.byte	7
	.word	.Ldebug_loc9
	.word	1268
	.byte	8
	.word	.Ldebug_loc7
	.word	1279
	.byte	8
	.word	.Ldebug_loc8
	.word	1290
	.byte	37
	.word	1302
	.xword	.Ltmp16
	.word	.Ltmp37-.Ltmp16
	.byte	2
	.byte	84
	.byte	2
	.byte	38
	.ascii	"\267\233\204&"
	.word	1310
	.byte	39
	.byte	1
	.byte	92
	.word	1332
	.byte	8
	.word	.Ldebug_loc11
	.word	1343
	.byte	8
	.word	.Ldebug_loc12
	.word	1354
	.byte	8
	.word	.Ldebug_loc13
	.word	1365
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	40
	.xword	.Lfunc_begin1
	.word	.Lfunc_end1-.Lfunc_begin1
	.byte	1
	.byte	111

	.word	.Linfo_string138
	.byte	2
	.byte	160

	.word	1067

	.byte	41
	.word	.Linfo_string85
	.byte	2
	.hword	532

	.word	556
	.byte	1
	.byte	42
	.word	.Linfo_string86
	.byte	2
	.hword	532
	.word	1172
	.byte	42
	.word	.Linfo_string87
	.byte	2
	.hword	532
	.word	556
	.byte	43
	.word	.Linfo_string88
	.byte	2
	.hword	534
	.word	556
	.byte	43
	.word	.Linfo_string89
	.byte	2
	.hword	535
	.word	1172
	.byte	0
	.byte	41
	.word	.Linfo_string90
	.byte	2
	.hword	558

	.word	556
	.byte	1
	.byte	42
	.word	.Linfo_string86
	.byte	2
	.hword	558
	.word	1172
	.byte	42
	.word	.Linfo_string87
	.byte	2
	.hword	558
	.word	556
	.byte	43
	.word	.Linfo_string89
	.byte	2
	.hword	561
	.word	1172
	.byte	43
	.word	.Linfo_string88
	.byte	2
	.hword	560
	.word	556
	.byte	0
	.byte	44
	.word	.Linfo_string91
	.byte	4
	.byte	196



	.byte	45
	.word	1785
	.byte	0
	.byte	16
	.word	1790
	.byte	46
	.byte	47
	.xword	.Lfunc_begin3
	.word	.Lfunc_end3-.Lfunc_begin3
	.byte	1
	.byte	109

	.word	.Linfo_string140
	.byte	2
	.hword	465

	.word	556
	.byte	4
	.word	.Ldebug_loc28
	.word	.Linfo_string102
	.byte	2
	.hword	465
	.word	4546
	.byte	4
	.word	.Ldebug_loc29
	.word	.Linfo_string135
	.byte	2
	.hword	465
	.word	458
	.byte	4
	.word	.Ldebug_loc30
	.word	.Linfo_string145
	.byte	2
	.hword	465
	.word	556
	.byte	5
	.word	.Ldebug_loc31
	.word	.Linfo_string87
	.byte	2
	.hword	467
	.word	556
	.byte	6
	.word	4460
	.word	.Ldebug_ranges5
	.byte	2
	.hword	472
	.byte	15
	.byte	7
	.word	.Ldebug_loc41
	.word	4473
	.byte	7
	.word	.Ldebug_loc40
	.word	4485
	.byte	8
	.word	.Ldebug_loc36
	.word	4497
	.byte	8
	.word	.Ldebug_loc37
	.word	4509
	.byte	8
	.word	.Ldebug_loc38
	.word	4521
	.byte	8
	.word	.Ldebug_loc39
	.word	4533
	.byte	6
	.word	4359
	.word	.Ldebug_ranges6
	.byte	2
	.hword	329
	.byte	9
	.byte	7
	.word	.Ldebug_loc35
	.word	4371
	.byte	7
	.word	.Ldebug_loc34
	.word	4382
	.byte	8
	.word	.Ldebug_loc33
	.word	4393
	.byte	8
	.word	.Ldebug_loc44
	.word	4404
	.byte	8
	.word	.Ldebug_loc45
	.word	4415
	.byte	8
	.word	.Ldebug_loc46
	.word	4426
	.byte	8
	.word	.Ldebug_loc48
	.word	4437
	.byte	8
	.word	.Ldebug_loc49
	.word	4448
	.byte	36
	.word	4608
	.word	.Ldebug_ranges7
	.byte	2
	.byte	228
	.byte	7
	.byte	7
	.word	.Ldebug_loc47
	.word	4620
	.byte	7
	.word	.Ldebug_loc32
	.word	4631
	.byte	8
	.word	.Ldebug_loc42
	.word	4642
	.byte	8
	.word	.Ldebug_loc43
	.word	4653
	.byte	48
	.xword	.Ltmp199
	.word	.Ltmp201-.Ltmp199
	.byte	49
	.byte	50
	.word	4689
	.byte	49
	.byte	0
	.word	4700
	.byte	0
	.byte	0
	.byte	0
	.byte	6
	.word	4843
	.word	.Ldebug_ranges8
	.byte	2
	.hword	334
	.byte	15
	.byte	7
	.word	.Ldebug_loc53
	.word	4855
	.byte	7
	.word	.Ldebug_loc56
	.word	4866
	.byte	8
	.word	.Ldebug_loc52
	.word	4877
	.byte	36
	.word	4805
	.word	.Ldebug_ranges9
	.byte	2
	.byte	245
	.byte	8
	.byte	7
	.word	.Ldebug_loc55
	.word	4818
	.byte	7
	.word	.Ldebug_loc51
	.word	4830
	.byte	6
	.word	4713
	.word	.Ldebug_ranges10
	.byte	4
	.hword	689
	.byte	9
	.byte	7
	.word	.Ldebug_loc54
	.word	4726
	.byte	7
	.word	.Ldebug_loc50
	.word	4738
	.byte	0
	.byte	0
	.byte	0
	.byte	50
	.word	4889
	.xword	.Ltmp212
	.word	.Ltmp213-.Ltmp212
	.byte	2
	.hword	330
	.byte	14
	.byte	51
	.byte	1
	.byte	104
	.word	4901
	.byte	0
	.byte	6
	.word	4913
	.word	.Ldebug_ranges11
	.byte	2
	.hword	341
	.byte	17
	.byte	8
	.word	.Ldebug_loc59
	.word	4936
	.byte	8
	.word	.Ldebug_loc60
	.word	4948
	.byte	8
	.word	.Ldebug_loc61
	.word	4960
	.byte	8
	.word	.Ldebug_loc62
	.word	4972
	.byte	8
	.word	.Ldebug_loc63
	.word	4984
	.byte	8
	.word	.Ldebug_loc64
	.word	4996
	.byte	8
	.word	.Ldebug_loc65
	.word	5008
	.byte	8
	.word	.Ldebug_loc66
	.word	5020
	.byte	8
	.word	.Ldebug_loc67
	.word	5032
	.byte	6
	.word	4805
	.word	.Ldebug_ranges12
	.byte	2
	.hword	265
	.byte	10
	.byte	7
	.word	.Ldebug_loc58
	.word	4818
	.byte	7
	.word	.Ldebug_loc69
	.word	4830
	.byte	6
	.word	4713
	.word	.Ldebug_ranges13
	.byte	4
	.hword	689
	.byte	9
	.byte	7
	.word	.Ldebug_loc57
	.word	4726
	.byte	7
	.word	.Ldebug_loc68
	.word	4738
	.byte	0
	.byte	0
	.byte	52
	.word	.Ldebug_ranges14
	.byte	8
	.word	.Ldebug_loc70
	.word	5045
	.byte	8
	.word	.Ldebug_loc71
	.word	5057
	.byte	0
	.byte	0
	.byte	0
	.byte	50
	.word	5071
	.xword	.Ltmp264
	.word	.Ltmp277-.Ltmp264
	.byte	2
	.hword	508
	.byte	15
	.byte	7
	.word	.Ldebug_loc80
	.word	5084
	.byte	7
	.word	.Ldebug_loc79
	.word	5096
	.byte	8
	.word	.Ldebug_loc76
	.word	5108
	.byte	8
	.word	.Ldebug_loc77
	.word	5120
	.byte	8
	.word	.Ldebug_loc78
	.word	5132
	.byte	50
	.word	4359
	.xword	.Ltmp264
	.word	.Ltmp277-.Ltmp264
	.byte	2
	.hword	377
	.byte	9
	.byte	7
	.word	.Ldebug_loc75
	.word	4371
	.byte	7
	.word	.Ldebug_loc74
	.word	4382
	.byte	8
	.word	.Ldebug_loc73
	.word	4393
	.byte	8
	.word	.Ldebug_loc83
	.word	4404
	.byte	8
	.word	.Ldebug_loc84
	.word	4415
	.byte	8
	.word	.Ldebug_loc85
	.word	4426
	.byte	8
	.word	.Ldebug_loc87
	.word	4437
	.byte	8
	.word	.Ldebug_loc88
	.word	4448
	.byte	36
	.word	4608
	.word	.Ldebug_ranges15
	.byte	2
	.byte	228
	.byte	7
	.byte	7
	.word	.Ldebug_loc86
	.word	4620
	.byte	7
	.word	.Ldebug_loc72
	.word	4631
	.byte	8
	.word	.Ldebug_loc81
	.word	4642
	.byte	8
	.word	.Ldebug_loc82
	.word	4653
	.byte	48
	.xword	.Ltmp266
	.word	.Ltmp268-.Ltmp266
	.byte	49
	.byte	50
	.word	4689
	.byte	39
	.byte	1
	.byte	90
	.word	4700
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	50
	.word	5145
	.xword	.Ltmp277
	.word	.Ltmp287-.Ltmp277
	.byte	2
	.hword	502
	.byte	15
	.byte	7
	.word	.Ldebug_loc98
	.word	5158
	.byte	7
	.word	.Ldebug_loc97
	.word	5170
	.byte	7
	.word	.Ldebug_loc96
	.word	5182
	.byte	8
	.word	.Ldebug_loc93
	.word	5194
	.byte	8
	.word	.Ldebug_loc94
	.word	5206
	.byte	8
	.word	.Ldebug_loc95
	.word	5218
	.byte	50
	.word	4359
	.xword	.Ltmp277
	.word	.Ltmp287-.Ltmp277
	.byte	2
	.hword	358
	.byte	9
	.byte	7
	.word	.Ldebug_loc92
	.word	4371
	.byte	7
	.word	.Ldebug_loc91
	.word	4382
	.byte	8
	.word	.Ldebug_loc90
	.word	4393
	.byte	8
	.word	.Ldebug_loc101
	.word	4404
	.byte	8
	.word	.Ldebug_loc102
	.word	4415
	.byte	8
	.word	.Ldebug_loc103
	.word	4426
	.byte	8
	.word	.Ldebug_loc105
	.word	4437
	.byte	8
	.word	.Ldebug_loc106
	.word	4448
	.byte	36
	.word	4608
	.word	.Ldebug_ranges16
	.byte	2
	.byte	228
	.byte	7
	.byte	7
	.word	.Ldebug_loc104
	.word	4620
	.byte	7
	.word	.Ldebug_loc89
	.word	4631
	.byte	8
	.word	.Ldebug_loc99
	.word	4642
	.byte	8
	.word	.Ldebug_loc100
	.word	4653
	.byte	48
	.xword	.Ltmp279
	.word	.Ltmp281-.Ltmp279
	.byte	49
	.byte	50
	.word	4689
	.byte	39
	.byte	1
	.byte	90
	.word	4700
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	50
	.word	5145
	.xword	.Ltmp287
	.word	.Ltmp297-.Ltmp287
	.byte	2
	.hword	478
	.byte	15
	.byte	7
	.word	.Ldebug_loc116
	.word	5158
	.byte	7
	.word	.Ldebug_loc115
	.word	5170
	.byte	7
	.word	.Ldebug_loc114
	.word	5182
	.byte	8
	.word	.Ldebug_loc111
	.word	5194
	.byte	8
	.word	.Ldebug_loc112
	.word	5206
	.byte	8
	.word	.Ldebug_loc113
	.word	5218
	.byte	50
	.word	4359
	.xword	.Ltmp287
	.word	.Ltmp297-.Ltmp287
	.byte	2
	.hword	358
	.byte	9
	.byte	7
	.word	.Ldebug_loc110
	.word	4371
	.byte	7
	.word	.Ldebug_loc109
	.word	4382
	.byte	8
	.word	.Ldebug_loc108
	.word	4393
	.byte	8
	.word	.Ldebug_loc119
	.word	4404
	.byte	8
	.word	.Ldebug_loc120
	.word	4415
	.byte	8
	.word	.Ldebug_loc121
	.word	4426
	.byte	8
	.word	.Ldebug_loc123
	.word	4437
	.byte	8
	.word	.Ldebug_loc124
	.word	4448
	.byte	36
	.word	4608
	.word	.Ldebug_ranges17
	.byte	2
	.byte	228
	.byte	7
	.byte	7
	.word	.Ldebug_loc122
	.word	4620
	.byte	7
	.word	.Ldebug_loc107
	.word	4631
	.byte	8
	.word	.Ldebug_loc117
	.word	4642
	.byte	8
	.word	.Ldebug_loc118
	.word	4653
	.byte	48
	.xword	.Ltmp289
	.word	.Ltmp291-.Ltmp289
	.byte	49
	.byte	50
	.word	4689
	.byte	39
	.byte	1
	.byte	90
	.word	4700
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	50
	.word	5145
	.xword	.Ltmp299
	.word	.Ltmp312-.Ltmp299
	.byte	2
	.hword	484
	.byte	15
	.byte	7
	.word	.Ldebug_loc134
	.word	5158
	.byte	7
	.word	.Ldebug_loc133
	.word	5170
	.byte	7
	.word	.Ldebug_loc132
	.word	5182
	.byte	8
	.word	.Ldebug_loc129
	.word	5194
	.byte	8
	.word	.Ldebug_loc130
	.word	5206
	.byte	8
	.word	.Ldebug_loc131
	.word	5218
	.byte	50
	.word	4359
	.xword	.Ltmp299
	.word	.Ltmp312-.Ltmp299
	.byte	2
	.hword	358
	.byte	9
	.byte	7
	.word	.Ldebug_loc128
	.word	4371
	.byte	7
	.word	.Ldebug_loc127
	.word	4382
	.byte	8
	.word	.Ldebug_loc126
	.word	4393
	.byte	8
	.word	.Ldebug_loc137
	.word	4404
	.byte	8
	.word	.Ldebug_loc138
	.word	4415
	.byte	8
	.word	.Ldebug_loc139
	.word	4426
	.byte	8
	.word	.Ldebug_loc141
	.word	4437
	.byte	8
	.word	.Ldebug_loc142
	.word	4448
	.byte	36
	.word	4608
	.word	.Ldebug_ranges18
	.byte	2
	.byte	228
	.byte	7
	.byte	7
	.word	.Ldebug_loc140
	.word	4620
	.byte	7
	.word	.Ldebug_loc125
	.word	4631
	.byte	8
	.word	.Ldebug_loc135
	.word	4642
	.byte	8
	.word	.Ldebug_loc136
	.word	4653
	.byte	48
	.xword	.Ltmp301
	.word	.Ltmp303-.Ltmp301
	.byte	49
	.byte	50
	.word	4689
	.byte	39
	.byte	1
	.byte	90
	.word	4700
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	50
	.word	5145
	.xword	.Ltmp312
	.word	.Ltmp325-.Ltmp312
	.byte	2
	.hword	490
	.byte	15
	.byte	7
	.word	.Ldebug_loc152
	.word	5158
	.byte	7
	.word	.Ldebug_loc151
	.word	5170
	.byte	7
	.word	.Ldebug_loc150
	.word	5182
	.byte	8
	.word	.Ldebug_loc147
	.word	5194
	.byte	8
	.word	.Ldebug_loc148
	.word	5206
	.byte	8
	.word	.Ldebug_loc149
	.word	5218
	.byte	50
	.word	4359
	.xword	.Ltmp312
	.word	.Ltmp325-.Ltmp312
	.byte	2
	.hword	358
	.byte	9
	.byte	7
	.word	.Ldebug_loc146
	.word	4371
	.byte	7
	.word	.Ldebug_loc145
	.word	4382
	.byte	8
	.word	.Ldebug_loc144
	.word	4393
	.byte	8
	.word	.Ldebug_loc155
	.word	4404
	.byte	8
	.word	.Ldebug_loc156
	.word	4415
	.byte	8
	.word	.Ldebug_loc157
	.word	4426
	.byte	8
	.word	.Ldebug_loc159
	.word	4437
	.byte	8
	.word	.Ldebug_loc160
	.word	4448
	.byte	36
	.word	4608
	.word	.Ldebug_ranges19
	.byte	2
	.byte	228
	.byte	7
	.byte	7
	.word	.Ldebug_loc158
	.word	4620
	.byte	7
	.word	.Ldebug_loc143
	.word	4631
	.byte	8
	.word	.Ldebug_loc153
	.word	4642
	.byte	8
	.word	.Ldebug_loc154
	.word	4653
	.byte	48
	.xword	.Ltmp314
	.word	.Ltmp316-.Ltmp314
	.byte	49
	.byte	50
	.word	4689
	.byte	39
	.byte	1
	.byte	90
	.word	4700
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	50
	.word	5145
	.xword	.Ltmp325
	.word	.Ltmp338-.Ltmp325
	.byte	2
	.hword	496
	.byte	15
	.byte	7
	.word	.Ldebug_loc170
	.word	5158
	.byte	7
	.word	.Ldebug_loc169
	.word	5170
	.byte	7
	.word	.Ldebug_loc168
	.word	5182
	.byte	8
	.word	.Ldebug_loc165
	.word	5194
	.byte	8
	.word	.Ldebug_loc166
	.word	5206
	.byte	8
	.word	.Ldebug_loc167
	.word	5218
	.byte	50
	.word	4359
	.xword	.Ltmp325
	.word	.Ltmp338-.Ltmp325
	.byte	2
	.hword	358
	.byte	9
	.byte	7
	.word	.Ldebug_loc164
	.word	4371
	.byte	7
	.word	.Ldebug_loc163
	.word	4382
	.byte	8
	.word	.Ldebug_loc162
	.word	4393
	.byte	8
	.word	.Ldebug_loc173
	.word	4404
	.byte	8
	.word	.Ldebug_loc174
	.word	4415
	.byte	8
	.word	.Ldebug_loc175
	.word	4426
	.byte	8
	.word	.Ldebug_loc177
	.word	4437
	.byte	8
	.word	.Ldebug_loc178
	.word	4448
	.byte	36
	.word	4608
	.word	.Ldebug_ranges20
	.byte	2
	.byte	228
	.byte	7
	.byte	7
	.word	.Ldebug_loc176
	.word	4620
	.byte	7
	.word	.Ldebug_loc161
	.word	4631
	.byte	8
	.word	.Ldebug_loc171
	.word	4642
	.byte	8
	.word	.Ldebug_loc172
	.word	4653
	.byte	48
	.xword	.Ltmp327
	.word	.Ltmp329-.Ltmp327
	.byte	49
	.byte	50
	.word	4689
	.byte	39
	.byte	1
	.byte	90
	.word	4700
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	50
	.word	5231
	.xword	.Ltmp338
	.word	.Ltmp350-.Ltmp338
	.byte	2
	.hword	520
	.byte	15
	.byte	7
	.word	.Ldebug_loc187
	.word	5244
	.byte	7
	.word	.Ldebug_loc186
	.word	5256
	.byte	8
	.word	.Ldebug_loc183
	.word	5268
	.byte	8
	.word	.Ldebug_loc184
	.word	5280
	.byte	8
	.word	.Ldebug_loc185
	.word	5292
	.byte	50
	.word	4359
	.xword	.Ltmp338
	.word	.Ltmp350-.Ltmp338
	.byte	2
	.hword	435
	.byte	9
	.byte	7
	.word	.Ldebug_loc182
	.word	4371
	.byte	7
	.word	.Ldebug_loc181
	.word	4382
	.byte	8
	.word	.Ldebug_loc180
	.word	4393
	.byte	8
	.word	.Ldebug_loc190
	.word	4404
	.byte	8
	.word	.Ldebug_loc191
	.word	4415
	.byte	8
	.word	.Ldebug_loc192
	.word	4426
	.byte	8
	.word	.Ldebug_loc194
	.word	4437
	.byte	8
	.word	.Ldebug_loc195
	.word	4448
	.byte	36
	.word	4608
	.word	.Ldebug_ranges21
	.byte	2
	.byte	228
	.byte	7
	.byte	7
	.word	.Ldebug_loc193
	.word	4620
	.byte	7
	.word	.Ldebug_loc179
	.word	4631
	.byte	8
	.word	.Ldebug_loc188
	.word	4642
	.byte	8
	.word	.Ldebug_loc189
	.word	4653
	.byte	48
	.xword	.Ltmp340
	.word	.Ltmp342-.Ltmp340
	.byte	49
	.byte	50
	.word	4689
	.byte	39
	.byte	1
	.byte	90
	.word	4700
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	10
	.word	1772
	.xword	.Ltmp262
	.byte	11
	.byte	1
	.byte	80
	.byte	2
	.byte	133
	.byte	0
	.byte	0
	.byte	10
	.word	1772
	.xword	.Ltmp364
	.byte	11
	.byte	1
	.byte	80
	.byte	2
	.byte	133
	.byte	0
	.byte	0
	.byte	0
	.byte	47
	.xword	.Lfunc_begin4
	.word	.Lfunc_end4-.Lfunc_begin4
	.byte	1
	.byte	111

	.word	.Linfo_string141
	.byte	2
	.hword	447

	.word	556
	.byte	53
	.byte	1
	.byte	80
	.word	.Linfo_string103
	.byte	2
	.hword	447
	.word	4546
	.byte	53
	.byte	1
	.byte	81
	.word	.Linfo_string86
	.byte	2
	.hword	447
	.word	1172
	.byte	53
	.byte	1
	.byte	82
	.word	.Linfo_string87
	.byte	2
	.hword	447
	.word	556
	.byte	5
	.word	.Ldebug_loc196
	.word	.Linfo_string79
	.byte	2
	.hword	449
	.word	556
	.byte	5
	.word	.Ldebug_loc197
	.word	.Linfo_string148
	.byte	2
	.hword	450
	.word	1082
	.byte	5
	.word	.Ldebug_loc198
	.word	.Linfo_string149
	.byte	2
	.hword	450
	.word	1082
	.byte	48
	.xword	.Ltmp370
	.word	.Ltmp410-.Ltmp370
	.byte	5
	.word	.Ldebug_loc199
	.word	.Linfo_string150
	.byte	2
	.hword	453
	.word	1142
	.byte	48
	.xword	.Ltmp376
	.word	.Ltmp408-.Ltmp376
	.byte	5
	.word	.Ldebug_loc200
	.word	.Linfo_string151
	.byte	2
	.hword	456
	.word	1177
	.byte	0
	.byte	0
	.byte	0
	.byte	54
	.word	.Linfo_string92
	.byte	1
	.byte	47

	.word	556


	.byte	29
	.word	.Linfo_string93
	.byte	2
	.byte	186

	.word	1121
	.byte	1
	.byte	30
	.word	.Linfo_string94
	.byte	2
	.byte	186
	.word	556
	.byte	30
	.word	.Linfo_string95
	.byte	2
	.byte	186
	.word	556
	.byte	31
	.word	.Linfo_string72
	.byte	2
	.byte	188
	.word	584
	.byte	31
	.word	.Linfo_string96
	.byte	2
	.byte	193
	.word	1147
	.byte	31
	.word	.Linfo_string97
	.byte	2
	.byte	192
	.word	549
	.byte	31
	.word	.Linfo_string98
	.byte	2
	.byte	191
	.word	549
	.byte	31
	.word	.Linfo_string99
	.byte	2
	.byte	189
	.word	1142
	.byte	31
	.word	.Linfo_string100
	.byte	2
	.byte	190
	.word	1104
	.byte	0
	.byte	41
	.word	.Linfo_string101
	.byte	2
	.hword	321

	.word	556
	.byte	1
	.byte	42
	.word	.Linfo_string102
	.byte	2
	.hword	321
	.word	4546
	.byte	42
	.word	.Linfo_string94
	.byte	2
	.hword	321
	.word	556
	.byte	43
	.word	.Linfo_string22
	.byte	2
	.hword	326
	.word	549
	.byte	43
	.word	.Linfo_string87
	.byte	2
	.hword	325
	.word	549
	.byte	43
	.word	.Linfo_string96
	.byte	2
	.hword	324
	.word	1121
	.byte	43
	.word	.Linfo_string105
	.byte	2
	.hword	323
	.word	4551
	.byte	0
	.byte	16
	.word	4551
	.byte	55
	.word	.Linfo_string104
	.byte	32
	.byte	1
	.byte	32
	.byte	18
	.word	.Linfo_string87
	.word	549
	.byte	1
	.byte	33
	.byte	0
	.byte	18
	.word	.Linfo_string103
	.word	1142
	.byte	1
	.byte	34
	.byte	8
	.byte	18
	.word	.Linfo_string86
	.word	4596
	.byte	1
	.byte	35
	.byte	16
	.byte	0
	.byte	20
	.word	1172
	.byte	21
	.word	882
	.byte	2
	.byte	0
	.byte	29
	.word	.Linfo_string106
	.byte	2
	.byte	168

	.word	556
	.byte	1
	.byte	30
	.word	.Linfo_string99
	.byte	2
	.byte	168
	.word	1104
	.byte	30
	.word	.Linfo_string94
	.byte	2
	.byte	168
	.word	556
	.byte	31
	.word	.Linfo_string79
	.byte	2
	.byte	171
	.word	556
	.byte	31
	.word	.Linfo_string107
	.byte	2
	.byte	170
	.word	556
	.byte	56
	.byte	31
	.word	.Linfo_string108
	.byte	2
	.byte	173
	.word	556
	.byte	31
	.word	.Linfo_string109
	.byte	2
	.byte	173
	.word	556
	.byte	0
	.byte	56
	.byte	31
	.word	.Linfo_string110
	.byte	2
	.byte	174
	.word	556
	.byte	31
	.word	.Linfo_string111
	.byte	2
	.byte	174
	.word	556
	.byte	0
	.byte	0
	.byte	41
	.word	.Linfo_string112
	.byte	4
	.hword	539

	.word	1147
	.byte	1
	.byte	42
	.word	.Linfo_string113
	.byte	4
	.hword	539
	.word	4765
	.byte	42
	.word	.Linfo_string118
	.byte	4
	.hword	539
	.word	1131
	.byte	56
	.byte	43
	.word	.Linfo_string119
	.byte	4
	.hword	543
	.word	549
	.byte	0
	.byte	0
	.byte	27
	.word	4776
	.word	.Linfo_string117
	.byte	7
	.byte	55
	.byte	27
	.word	4787
	.word	.Linfo_string116
	.byte	8
	.byte	72
	.byte	27
	.word	4798
	.word	.Linfo_string115
	.byte	8
	.byte	16
	.byte	14
	.word	.Linfo_string114
	.byte	7
	.byte	8
	.byte	41
	.word	.Linfo_string120
	.byte	4
	.hword	687

	.word	1147
	.byte	1
	.byte	42
	.word	.Linfo_string113
	.byte	4
	.hword	687
	.word	4765
	.byte	42
	.word	.Linfo_string118
	.byte	4
	.hword	687
	.word	1131
	.byte	0
	.byte	29
	.word	.Linfo_string121
	.byte	2
	.byte	240

	.word	1142
	.byte	1
	.byte	30
	.word	.Linfo_string96
	.byte	2
	.byte	240
	.word	1121
	.byte	30
	.word	.Linfo_string22
	.byte	2
	.byte	241
	.word	549
	.byte	31
	.word	.Linfo_string122
	.byte	2
	.byte	243
	.word	1109
	.byte	0
	.byte	29
	.word	.Linfo_string123
	.byte	2
	.byte	235

	.word	1114
	.byte	1
	.byte	30
	.word	.Linfo_string96
	.byte	2
	.byte	235
	.word	1121
	.byte	0
	.byte	29
	.word	.Linfo_string124
	.byte	2
	.byte	254

	.word	1142
	.byte	1
	.byte	30
	.word	.Linfo_string105
	.byte	2
	.byte	254
	.word	4546
	.byte	43
	.word	.Linfo_string125
	.byte	2
	.hword	260
	.word	556
	.byte	43
	.word	.Linfo_string126
	.byte	2
	.hword	259
	.word	556
	.byte	43
	.word	.Linfo_string127
	.byte	2
	.hword	258
	.word	556
	.byte	43
	.word	.Linfo_string128
	.byte	2
	.hword	257
	.word	556
	.byte	43
	.word	.Linfo_string129
	.byte	2
	.hword	257
	.word	556
	.byte	43
	.word	.Linfo_string84
	.byte	2
	.hword	257
	.word	556
	.byte	43
	.word	.Linfo_string79
	.byte	2
	.hword	257
	.word	556
	.byte	43
	.word	.Linfo_string130
	.byte	2
	.hword	256
	.word	1142
	.byte	43
	.word	.Linfo_string131
	.byte	2
	.hword	256
	.word	1142
	.byte	56
	.byte	43
	.word	.Linfo_string94
	.byte	2
	.hword	272
	.word	556
	.byte	43
	.word	.Linfo_string132
	.byte	2
	.hword	273
	.word	556
	.byte	0
	.byte	0
	.byte	41
	.word	.Linfo_string133
	.byte	2
	.hword	370

	.word	556
	.byte	1
	.byte	42
	.word	.Linfo_string102
	.byte	2
	.hword	370
	.word	4546
	.byte	42
	.word	.Linfo_string94
	.byte	2
	.hword	370
	.word	556
	.byte	43
	.word	.Linfo_string22
	.byte	2
	.hword	374
	.word	549
	.byte	43
	.word	.Linfo_string87
	.byte	2
	.hword	373
	.word	549
	.byte	43
	.word	.Linfo_string96
	.byte	2
	.hword	372
	.word	1121
	.byte	0
	.byte	41
	.word	.Linfo_string134
	.byte	2
	.hword	351

	.word	556
	.byte	1
	.byte	42
	.word	.Linfo_string102
	.byte	2
	.hword	351
	.word	4546
	.byte	42
	.word	.Linfo_string94
	.byte	2
	.hword	351
	.word	556
	.byte	42
	.word	.Linfo_string135
	.byte	2
	.hword	351
	.word	947
	.byte	43
	.word	.Linfo_string22
	.byte	2
	.hword	355
	.word	549
	.byte	43
	.word	.Linfo_string87
	.byte	2
	.hword	354
	.word	549
	.byte	43
	.word	.Linfo_string96
	.byte	2
	.hword	353
	.word	1121
	.byte	0
	.byte	41
	.word	.Linfo_string136
	.byte	2
	.hword	429

	.word	556
	.byte	1
	.byte	42
	.word	.Linfo_string102
	.byte	2
	.hword	429
	.word	4546
	.byte	42
	.word	.Linfo_string94
	.byte	2
	.hword	429
	.word	556
	.byte	43
	.word	.Linfo_string22
	.byte	2
	.hword	433
	.word	549
	.byte	43
	.word	.Linfo_string87
	.byte	2
	.hword	432
	.word	549
	.byte	43
	.word	.Linfo_string96
	.byte	2
	.hword	431
	.word	1121
	.byte	0
	.byte	0
.Ldebug_info_end0:
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.xword	.Ltmp4-.Lfunc_begin0
	.xword	.Ltmp5-.Lfunc_begin0
	.xword	.Ltmp6-.Lfunc_begin0
	.xword	.Ltmp8-.Lfunc_begin0
	.xword	.Ltmp47-.Lfunc_begin0
	.xword	.Ltmp48-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges1:
	.xword	.Ltmp8-.Lfunc_begin0
	.xword	.Ltmp44-.Lfunc_begin0
	.xword	.Ltmp49-.Lfunc_begin0
	.xword	.Ltmp50-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges2:
	.xword	.Ltmp11-.Lfunc_begin0
	.xword	.Ltmp12-.Lfunc_begin0
	.xword	.Ltmp14-.Lfunc_begin0
	.xword	.Ltmp43-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges3:
	.xword	.Ltmp79-.Lfunc_begin0
	.xword	.Ltmp81-.Lfunc_begin0
	.xword	.Ltmp82-.Lfunc_begin0
	.xword	.Ltmp101-.Lfunc_begin0
	.xword	.Ltmp121-.Lfunc_begin0
	.xword	.Ltmp142-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges4:
	.xword	.Ltmp105-.Lfunc_begin0
	.xword	.Ltmp107-.Lfunc_begin0
	.xword	.Ltmp108-.Lfunc_begin0
	.xword	.Ltmp118-.Lfunc_begin0
	.xword	.Ltmp142-.Lfunc_begin0
	.xword	.Ltmp172-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges5:
	.xword	.Ltmp197-.Lfunc_begin0
	.xword	.Ltmp263-.Lfunc_begin0
	.xword	.Ltmp363-.Lfunc_begin0
	.xword	.Ltmp366-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges6:
	.xword	.Ltmp197-.Lfunc_begin0
	.xword	.Ltmp209-.Lfunc_begin0
	.xword	.Ltmp210-.Lfunc_begin0
	.xword	.Ltmp212-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges7:
	.xword	.Ltmp198-.Lfunc_begin0
	.xword	.Ltmp201-.Lfunc_begin0
	.xword	.Ltmp202-.Lfunc_begin0
	.xword	.Ltmp207-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges8:
	.xword	.Ltmp209-.Lfunc_begin0
	.xword	.Ltmp210-.Lfunc_begin0
	.xword	.Ltmp215-.Lfunc_begin0
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges9:
	.xword	.Ltmp209-.Lfunc_begin0
	.xword	.Ltmp210-.Lfunc_begin0
	.xword	.Ltmp215-.Lfunc_begin0
	.xword	.Ltmp216-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges10:
	.xword	.Ltmp209-.Lfunc_begin0
	.xword	.Ltmp210-.Lfunc_begin0
	.xword	.Ltmp215-.Lfunc_begin0
	.xword	.Ltmp216-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges11:
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp225-.Lfunc_begin0
	.xword	.Ltmp227-.Lfunc_begin0
	.xword	.Ltmp261-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges12:
	.xword	.Ltmp220-.Lfunc_begin0
	.xword	.Ltmp221-.Lfunc_begin0
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Ltmp223-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges13:
	.xword	.Ltmp220-.Lfunc_begin0
	.xword	.Ltmp221-.Lfunc_begin0
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Ltmp223-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges14:
	.xword	.Ltmp231-.Lfunc_begin0
	.xword	.Ltmp234-.Lfunc_begin0
	.xword	.Ltmp236-.Lfunc_begin0
	.xword	.Ltmp237-.Lfunc_begin0
	.xword	.Ltmp238-.Lfunc_begin0
	.xword	.Ltmp257-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges15:
	.xword	.Ltmp265-.Lfunc_begin0
	.xword	.Ltmp268-.Lfunc_begin0
	.xword	.Ltmp269-.Lfunc_begin0
	.xword	.Ltmp274-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges16:
	.xword	.Ltmp278-.Lfunc_begin0
	.xword	.Ltmp281-.Lfunc_begin0
	.xword	.Ltmp282-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges17:
	.xword	.Ltmp288-.Lfunc_begin0
	.xword	.Ltmp291-.Lfunc_begin0
	.xword	.Ltmp292-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges18:
	.xword	.Ltmp300-.Lfunc_begin0
	.xword	.Ltmp303-.Lfunc_begin0
	.xword	.Ltmp304-.Lfunc_begin0
	.xword	.Ltmp309-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges19:
	.xword	.Ltmp313-.Lfunc_begin0
	.xword	.Ltmp316-.Lfunc_begin0
	.xword	.Ltmp317-.Lfunc_begin0
	.xword	.Ltmp322-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges20:
	.xword	.Ltmp326-.Lfunc_begin0
	.xword	.Ltmp329-.Lfunc_begin0
	.xword	.Ltmp330-.Lfunc_begin0
	.xword	.Ltmp335-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges21:
	.xword	.Ltmp339-.Lfunc_begin0
	.xword	.Ltmp342-.Lfunc_begin0
	.xword	.Ltmp343-.Lfunc_begin0
	.xword	.Ltmp348-.Lfunc_begin0
	.xword	0
	.xword	0
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"Android (8508608, based on r450784e) clang version 14.0.7 (https://android.googlesource.com/toolchain/llvm-project 4c603efb0cca074e9238af8b4106c30add4418f6)"
.Linfo_string1:
	.asciz	"drivers/gpu/drm/rockchip/ebc-dev/epdlut/rkf_waveform.c"
.Linfo_string2:
	.asciz	"/home/lyx/rk-android14/kernel-6.1"
.Linfo_string3:
	.asciz	"stype"
.Linfo_string4:
	.asciz	"unsigned int"
.Linfo_string5:
	.asciz	"WF_TYPE_RESET"
.Linfo_string6:
	.asciz	"WF_TYPE_GRAY2"
.Linfo_string7:
	.asciz	"WF_TYPE_GRAY4"
.Linfo_string8:
	.asciz	"WF_TYPE_GC16"
.Linfo_string9:
	.asciz	"WF_TYPE_GL16"
.Linfo_string10:
	.asciz	"WF_TYPE_GLR16"
.Linfo_string11:
	.asciz	"WF_TYPE_GLD16"
.Linfo_string12:
	.asciz	"WF_TYPE_A2"
.Linfo_string13:
	.asciz	"WF_TYPE_GCC16"
.Linfo_string14:
	.asciz	"PVI_WF_MAX"
.Linfo_string15:
	.asciz	"WF_TYPE_AUTO"
.Linfo_string16:
	.asciz	"WF_TYPE_MAX"
.Linfo_string17:
	.asciz	"WF_TYPE_GRAY16"
.Linfo_string18:
	.asciz	"epd_lut_type"
.Linfo_string19:
	.asciz	"sftemp"
.Linfo_string20:
	.asciz	"int"
.Linfo_string21:
	.asciz	"global_waveform"
.Linfo_string22:
	.asciz	"length"
.Linfo_string23:
	.asciz	"format"
.Linfo_string24:
	.asciz	"char"
.Linfo_string25:
	.asciz	"__ARRAY_SIZE_TYPE__"
.Linfo_string26:
	.asciz	"version"
.Linfo_string27:
	.asciz	"timeandday"
.Linfo_string28:
	.asciz	"panel_name"
.Linfo_string29:
	.asciz	"panel_info"
.Linfo_string30:
	.asciz	"full_version"
.Linfo_string31:
	.asciz	"reset_temp_list"
.Linfo_string32:
	.asciz	"gc16_temp_list"
.Linfo_string33:
	.asciz	"gl16_temp_list"
.Linfo_string34:
	.asciz	"glr16_temp_list"
.Linfo_string35:
	.asciz	"gld16_temp_list"
.Linfo_string36:
	.asciz	"du_temp_list"
.Linfo_string37:
	.asciz	"a2_temp_list"
.Linfo_string38:
	.asciz	"reset_list"
.Linfo_string39:
	.asciz	"gc16_list"
.Linfo_string40:
	.asciz	"gl16_list"
.Linfo_string41:
	.asciz	"glr16_list"
.Linfo_string42:
	.asciz	"gld16_list"
.Linfo_string43:
	.asciz	"du_list"
.Linfo_string44:
	.asciz	"a2_list"
.Linfo_string45:
	.asciz	"rkf_waveform"
.Linfo_string46:
	.asciz	"crc32_table"
.Linfo_string47:
	.asciz	"RKF_WF_RESET"
.Linfo_string48:
	.asciz	"RKF_WF_DU"
.Linfo_string49:
	.asciz	"RKF_WF_GC16"
.Linfo_string50:
	.asciz	"RKF_WF_GL16"
.Linfo_string51:
	.asciz	"RKF_WF_GLR16"
.Linfo_string52:
	.asciz	"RKF_WF_GLD16"
.Linfo_string53:
	.asciz	"RKF_WF_A2"
.Linfo_string54:
	.asciz	"rkf_waveform_type"
.Linfo_string55:
	.asciz	"false"
.Linfo_string56:
	.asciz	"true"
.Linfo_string57:
	.asciz	"KMALLOC_NORMAL"
.Linfo_string58:
	.asciz	"KMALLOC_DMA"
.Linfo_string59:
	.asciz	"KMALLOC_CGROUP"
.Linfo_string60:
	.asciz	"KMALLOC_RECLAIM"
.Linfo_string61:
	.asciz	"NR_KMALLOC_TYPES"
.Linfo_string62:
	.asciz	"kmalloc_cache_type"
.Linfo_string63:
	.asciz	"__u32"
.Linfo_string64:
	.asciz	"u32"
.Linfo_string65:
	.asciz	"unsigned char"
.Linfo_string66:
	.asciz	"gfp_t"
.Linfo_string67:
	.asciz	"check_wf_format"
.Linfo_string68:
	.asciz	"buf"
.Linfo_string69:
	.asciz	"__u8"
.Linfo_string70:
	.asciz	"u8"
.Linfo_string71:
	.asciz	"check_wf_crc"
.Linfo_string72:
	.asciz	"waveform"
.Linfo_string73:
	.asciz	"crccheck"
.Linfo_string74:
	.asciz	"readcrc"
.Linfo_string75:
	.asciz	"crc_32"
.Linfo_string76:
	.asciz	"a_data"
.Linfo_string77:
	.asciz	"a_size"
.Linfo_string78:
	.asciz	"n_accum"
.Linfo_string79:
	.asciz	"i"
.Linfo_string80:
	.asciz	"crc_build_table32"
.Linfo_string81:
	.asciz	"a_poly"
.Linfo_string82:
	.asciz	"crc_table"
.Linfo_string83:
	.asciz	"n_data"
.Linfo_string84:
	.asciz	"j"
.Linfo_string85:
	.asciz	"rkf_wf_a2_repair"
.Linfo_string86:
	.asciz	"wf_table"
.Linfo_string87:
	.asciz	"frame_num"
.Linfo_string88:
	.asciz	"f"
.Linfo_string89:
	.asciz	"table"
.Linfo_string90:
	.asciz	"rkf_wf_gray2_repair"
.Linfo_string91:
	.asciz	"kfree"
.Linfo_string92:
	.asciz	"epd_overlay_lut"
.Linfo_string93:
	.asciz	"get_wf_buf"
.Linfo_string94:
	.asciz	"temp"
.Linfo_string95:
	.asciz	"mode"
.Linfo_string96:
	.asciz	"pbuf"
.Linfo_string97:
	.asciz	"pt"
.Linfo_string98:
	.asciz	"wf_offset"
.Linfo_string99:
	.asciz	"list"
.Linfo_string100:
	.asciz	"templist"
.Linfo_string101:
	.asciz	"parse_wf_reset"
.Linfo_string102:
	.asciz	"output"
.Linfo_string103:
	.asciz	"data"
.Linfo_string104:
	.asciz	"epd_lut_data"
.Linfo_string105:
	.asciz	"input"
.Linfo_string106:
	.asciz	"get_wf_level"
.Linfo_string107:
	.asciz	"level"
.Linfo_string108:
	.asciz	"__UNIQUE_ID___x346"
.Linfo_string109:
	.asciz	"__UNIQUE_ID___y347"
.Linfo_string110:
	.asciz	"__UNIQUE_ID___y349"
.Linfo_string111:
	.asciz	"__UNIQUE_ID___x348"
.Linfo_string112:
	.asciz	"kmalloc"
.Linfo_string113:
	.asciz	"size"
.Linfo_string114:
	.asciz	"unsigned long"
.Linfo_string115:
	.asciz	"__kernel_ulong_t"
.Linfo_string116:
	.asciz	"__kernel_size_t"
.Linfo_string117:
	.asciz	"size_t"
.Linfo_string118:
	.asciz	"flags"
.Linfo_string119:
	.asciz	"index"
.Linfo_string120:
	.asciz	"kzalloc"
.Linfo_string121:
	.asciz	"decode_wf_data"
.Linfo_string122:
	.asciz	"out"
.Linfo_string123:
	.asciz	"get_wf_frm_num"
.Linfo_string124:
	.asciz	"decode_wf_reset"
.Linfo_string125:
	.asciz	"len"
.Linfo_string126:
	.asciz	"num"
.Linfo_string127:
	.asciz	"temp_data"
.Linfo_string128:
	.asciz	"h"
.Linfo_string129:
	.asciz	"k"
.Linfo_string130:
	.asciz	"odata"
.Linfo_string131:
	.asciz	"idata"
.Linfo_string132:
	.asciz	"temp1"
.Linfo_string133:
	.asciz	"parse_wf_gray2"
.Linfo_string134:
	.asciz	"parse_wf_gray16"
.Linfo_string135:
	.asciz	"lut_type"
.Linfo_string136:
	.asciz	"parse_wf_a2"
.Linfo_string137:
	.asciz	"rkf_wf_input"
.Linfo_string138:
	.asciz	"rkf_wf_get_version"
.Linfo_string139:
	.asciz	"rkf_wf_get_lut"
.Linfo_string140:
	.asciz	"parse_wf_data"
.Linfo_string141:
	.asciz	"rkf_lut_init_wf_table"
.Linfo_string142:
	.asciz	"waveform_file"
.Linfo_string143:
	.asciz	"wf"
.Linfo_string144:
	.asciz	"ret"
.Linfo_string145:
	.asciz	"temperture"
.Linfo_string146:
	.asciz	"pic"
.Linfo_string147:
	.asciz	"overlay_lut"
.Linfo_string148:
	.asciz	"old_gray"
.Linfo_string149:
	.asciz	"new_gray"
.Linfo_string150:
	.asciz	"lut_data"
.Linfo_string151:
	.asciz	"pix0"
	.ident	"Android (8508608, based on r450784e) clang version 14.0.7 (https://android.googlesource.com/toolchain/llvm-project 4c603efb0cca074e9238af8b4106c30add4418f6)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.section	.debug_line,"",@progbits
.Lline_table_start0:
