// SPDX-License-Identifier: GPL-2.0
/*
 * Copyright (c) 2020 Rockchip Electronics Co. Ltd.
 *
 * Author: Zorro Liu <zorro.liu@rock-chips.com>
 */

	.text
	.file	"pvi_waveform.c"
	.file	1 "/home/lyx/rk-android14/kernel-6.1" "./include/uapi/asm-generic/int-ll64.h"
	.file	2 "/home/lyx/rk-android14/kernel-6.1" "./include/asm-generic/int-ll64.h"
	.file	3 "/home/lyx/rk-android14/kernel-6.1" "drivers/gpu/drm/rockchip/ebc-dev/epdlut/pvi_waveform.c"
	.file	4 "/home/lyx/rk-android14/kernel-6.1" "drivers/gpu/drm/rockchip/ebc-dev/epdlut/epd_lut.h"
	.file	5 "/home/lyx/rk-android14/kernel-6.1" "./include/linux/stddef.h"
	.globl	pvi_wf_get_lut
	.p2align	2
	.type	pvi_wf_get_lut,@function
pvi_wf_get_lut:
.Lfunc_begin0:
	.loc	3 348 0
	.cfi_sections .debug_frame
	.cfi_startproc
	str	x30, [x18], #8
	.cfi_escape 0x16, 0x12, 0x02, 0x82, 0x78
	stp	x29, x30, [sp, #-96]!
	str	x27, [sp, #16]
	mov	x29, sp
	stp	x26, x25, [sp, #32]
	stp	x24, x23, [sp, #48]
	stp	x22, x21, [sp, #64]
	stp	x20, x19, [sp, #80]
	.cfi_def_cfa w29, 96
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w25, -56
	.cfi_offset w26, -64
	.cfi_offset w27, -80
	.cfi_offset w30, -88
	.cfi_offset w29, -96
.Ltmp0:
	.loc	3 356 7 prologue_end
	adrp	x25, global_waveform
	ldr	x8, [x25, :lo12:global_waveform]
.Ltmp1:
	.loc	3 356 6 is_stmt 0
	cbz	x8, .LBB0_10
.Ltmp2:
	.loc	3 0 6
	mov	w22, w4
.Ltmp3:
	mov	w19, w2
.Ltmp4:
	mov	w21, w1
.Ltmp5:
	mov	x20, x0
.Ltmp6:
	.loc	3 359 14 is_stmt 1
	cbnz	x0, .LBB0_3
.Ltmp7:
	.loc	3 0 14 is_stmt 0
	mov	w9, #16
	.loc	3 359 18
	ldr	x9, [x9]
.Ltmp8:
	.loc	3 359 6
	cbz	x9, .LBB0_11
.Ltmp9:
.LBB0_3:
	.loc	3 364 28 is_stmt 1
	adrp	x24, pvi_wf_get_lut.sftemp
	.loc	3 364 19 is_stmt 0
	mov	w9, #21846
	movk	w9, #21845, lsl #16
	adrp	x27, pvi_wf_get_lut.stype
	.loc	3 364 28
	ldrsw	x10, [x24, :lo12:pvi_wf_get_lut.sftemp]
	.loc	3 364 19
	smull	x11, w19, w9
	ldr	w13, [x27, :lo12:pvi_wf_get_lut.stype]
	.loc	3 364 35
	mul	x9, x10, x9
	.loc	3 364 19
	lsr	x10, x11, #63
	lsr	x11, x11, #32
	.loc	3 364 35
	lsr	x12, x9, #63
	lsr	x9, x9, #32
	.loc	3 364 19
	add	w26, w11, w10
	.loc	3 364 35
	add	w10, w9, w12
	.loc	3 364 41
	cmp	w26, w10
	ccmp	w13, w21, #0, eq
	b.eq	.LBB0_111
.Ltmp10:
	.loc	3 367 11 is_stmt 1
	adrp	x11, need_pic
	.loc	3 369 6
	subs	w9, w21, #10
	.loc	3 367 11
	str	w3, [x11, :lo12:need_pic]
	.loc	3 369 6
	b.eq	.LBB0_110
.Ltmp11:
	.loc	3 371 18
	ldr	x11, [x20, #16]
	.loc	3 371 16 is_stmt 0
	adrp	x12, waveformdata
.Ltmp12:
	.loc	3 207 34 is_stmt 1
	ldrb	w10, [x8, #38]
.Ltmp13:
	.loc	3 371 16
	str	x11, [x12, :lo12:waveformdata]
.Ltmp14:
	.loc	3 211 2
	cbz	w10, .LBB0_12
.Ltmp15:
	.loc	3 0 2 is_stmt 0
	mov	x11, xzr
	.loc	3 211 2
	add	x12, x8, #48
.Ltmp16:
.LBB0_7:
	.loc	3 212 21 is_stmt 1
	ldrb	w13, [x12, x11]
.Ltmp17:
	.loc	3 212 7 is_stmt 0
	cmp	w13, w19
	b.ge	.LBB0_13
.Ltmp18:
	.loc	3 211 29 is_stmt 1
	add	x11, x11, #1
.Ltmp19:
	.loc	3 211 2 is_stmt 0
	cmp	x10, x11
	b.ne	.LBB0_7
.Ltmp20:
	.loc	3 0 2
	mov	w12, #-1
	mov	w11, w10
.Ltmp21:
	b	.LBB0_14
.Ltmp22:
.LBB0_10:
	mov	w0, #-19
.Ltmp23:
	b	.LBB0_137
.Ltmp24:
.LBB0_11:
	mov	w0, #-22
	b	.LBB0_137
.Ltmp25:
.LBB0_12:
	mov	w11, wzr
	mov	w12, #-1
	b	.LBB0_14
.Ltmp26:
.LBB0_13:
	mov	w12, w11
.Ltmp27:
.LBB0_14:
	sub	w13, w11, #1
	.loc	3 218 6 is_stmt 1
	cmp	w11, w10
	csel	w23, w13, w12, eq
.Ltmp28:
	.loc	3 188 6
	cmp	w21, #13
	b.hs	.LBB0_59
.Ltmp29:
	.loc	3 191 13
	cmp	w9, #3
	b.hs	.LBB0_17
.Ltmp30:
	adrp	x10, .Lswitch.table.pvi_wf_get_lut.7
	add	x10, x10, :lo12:.Lswitch.table.pvi_wf_get_lut.7
	ldr	x9, [x10, w9, sxtw #3]
	b	.LBB0_18
.Ltmp31:
.LBB0_17:
	.loc	3 0 13 is_stmt 0
	mov	w9, w21
.Ltmp32:
.LBB0_18:
	.loc	3 168 20 is_stmt 1
	ldrb	w10, [x8, #16]
	.loc	3 168 2 is_stmt 0
	sub	w8, w10, #9
.Ltmp33:
	cmp	w8, #75
	b.hi	.LBB0_21
.Ltmp34:
	.loc	3 0 2
	adrp	x10, .LJTI0_0
	add	x10, x10, :lo12:.LJTI0_0
	adr	x11, .LBB0_20
	ldrb	w12, [x10, x8]
	add	x11, x11, x12, lsl #2
	adrp	x8, pvi_mode_table
	add	x8, x8, :lo12:pvi_mode_table
	br	x11
.Ltmp35:
.LBB0_20:
	adrp	x8, pvi_mode_table+30
	add	x8, x8, :lo12:pvi_mode_table+30
.Ltmp36:
	b	.LBB0_29
.Ltmp37:
.LBB0_21:
	.loc	3 168 2
	cmp	w10, #114
	b.ne	.LBB0_23
.Ltmp38:
	.loc	3 0 2
	adrp	x8, pvi_mode_table+70
	add	x8, x8, :lo12:pvi_mode_table+70
	b	.LBB0_29
.Ltmp39:
.LBB0_23:
	adrp	x8, pvi_mode_table+80
	add	x8, x8, :lo12:pvi_mode_table+80
	b	.LBB0_29
.Ltmp40:
.LBB0_24:
	adrp	x8, pvi_mode_table+10
	add	x8, x8, :lo12:pvi_mode_table+10
	b	.LBB0_29
.Ltmp41:
.LBB0_25:
	adrp	x8, pvi_mode_table+20
	add	x8, x8, :lo12:pvi_mode_table+20
	b	.LBB0_29
.Ltmp42:
.LBB0_26:
	adrp	x8, pvi_mode_table+40
	add	x8, x8, :lo12:pvi_mode_table+40
	b	.LBB0_29
.Ltmp43:
.LBB0_27:
	adrp	x8, pvi_mode_table+50
	add	x8, x8, :lo12:pvi_mode_table+50
	b	.LBB0_29
.Ltmp44:
.LBB0_28:
	adrp	x8, pvi_mode_table+60
	add	x8, x8, :lo12:pvi_mode_table+60
.Ltmp45:
.LBB0_29:
	.loc	3 202 9 is_stmt 1
	ldrb	w0, [x8, x9]
.Ltmp46:
.LBB0_30:
	.loc	3 374 15
	mov	w1, w23
	bl	get_wf_frm_num
.Ltmp47:
	.loc	3 375 7
	tbnz	w0, #31, .LBB0_138
.Ltmp48:
	.loc	3 380 7
	cmp	w21, #1
	b.eq	.LBB0_39
.Ltmp49:
	cmp	w21, #7
	b.ne	.LBB0_45
.Ltmp50:
	.loc	3 381 21
	ldr	x8, [x20, #16]
.Ltmp51:
	.loc	3 253 2
	cbz	w0, .LBB0_98
.Ltmp52:
	.loc	3 253 16 is_stmt 0
	mov	w10, w0
	mov	x9, xzr
.Ltmp53:
	.loc	3 253 2
	lsl	x10, x10, #10
.Ltmp54:
.LBB0_35:
	.loc	3 254 20 is_stmt 1
	add	x11, x8, w9, sxtw
.Ltmp55:
	.loc	3 253 16
	add	x9, x9, #1024
.Ltmp56:
	.loc	3 253 2 is_stmt 0
	cmp	x10, x9
.Ltmp57:
	.loc	3 255 38 is_stmt 1
	ldrb	w12, [x11, #960]
	.loc	3 258 38
	ldrb	w13, [x11, #30]
	.loc	3 255 36
	strb	w12, [x11, #992]
	.loc	3 256 36
	strb	w12, [x11, #928]
	.loc	3 257 36
	strb	w12, [x11, #864]
	.loc	3 258 36
	strb	w13, [x11, #62]
.Ltmp58:
	.loc	3 253 2
	b.ne	.LBB0_35
.Ltmp59:
	.loc	3 0 2 is_stmt 0
	sub	w10, w0, #1
.Ltmp60:
	.loc	3 261 2 is_stmt 1
	cmp	w10, #2
	b.lt	.LBB0_72
.Ltmp61:
	sub	x12, x10, #1
	mov	w9, #1
	cmp	x12, #2
	b.hs	.LBB0_60
.Ltmp62:
	.loc	3 0 2 is_stmt 0
	mov	w11, #1
	b	.LBB0_70
.Ltmp63:
.LBB0_39:
	.loc	3 383 24 is_stmt 1
	ldr	x9, [x20, #16]
	mov	w8, #4990
.Ltmp64:
	.loc	3 0 0 is_stmt 0
	add	x8, x9, x8
.Ltmp65:
	.loc	3 287 2 is_stmt 1
	cbz	w0, .LBB0_107
.Ltmp66:
	.loc	3 287 16 is_stmt 0
	mov	w11, w0
	mov	x10, xzr
.Ltmp67:
	.loc	3 287 2
	lsl	x11, x11, #10
.Ltmp68:
.LBB0_41:
	.loc	3 288 20 is_stmt 1
	add	x12, x9, w10, sxtw
.Ltmp69:
	.loc	3 287 16
	add	x10, x10, #1024
.Ltmp70:
	.loc	3 287 2 is_stmt 0
	cmp	x11, x10
.Ltmp71:
	.loc	3 289 38 is_stmt 1
	ldrb	w13, [x12, #960]
	.loc	3 292 38
	ldrb	w14, [x12, #30]
	.loc	3 289 36
	strb	w13, [x12, #992]
	.loc	3 290 36
	strb	w13, [x12, #928]
	.loc	3 291 36
	strb	w13, [x12, #864]
	.loc	3 292 36
	strb	w14, [x12, #62]
.Ltmp72:
	.loc	3 287 2
	b.ne	.LBB0_41
.Ltmp73:
	.loc	3 0 2 is_stmt 0
	sub	w10, w0, #9
.Ltmp74:
	.loc	3 295 2 is_stmt 1
	cmp	w10, #4
	b.lt	.LBB0_87
.Ltmp75:
	sub	x12, x10, #3
.Ltmp76:
	cmp	x12, #2
	b.hs	.LBB0_75
.Ltmp77:
	.loc	3 0 2 is_stmt 0
	mov	w11, #3
	b	.LBB0_85
.Ltmp78:
.LBB0_45:
	sub	w8, w21, #5
.Ltmp79:
	.loc	3 384 22 is_stmt 1
	cmp	w8, #1
	b.hi	.LBB0_52
.Ltmp80:
	cbz	w22, .LBB0_52
.Ltmp81:
	.loc	3 321 2
	cbz	w0, .LBB0_109
.Ltmp82:
	.loc	3 0 0 is_stmt 0
	ldr	x8, [x20, #16]
.Ltmp83:
	.loc	3 321 16
	mov	w9, w0
.Ltmp84:
	.loc	3 321 2
	cmp	w0, #1
	b.ne	.LBB0_140
.Ltmp85:
	.loc	3 0 2
	mov	x10, xzr
.Ltmp86:
.LBB0_50:
	.loc	3 321 2
	sub	x9, x9, x10
	lsl	w10, w10, #10
.Ltmp87:
.LBB0_51:
	.loc	3 322 20 is_stmt 1
	add	x11, x8, w10, sxtw
.Ltmp88:
	.loc	3 321 16
	subs	x9, x9, #1
	add	w10, w10, #1024
.Ltmp89:
	.loc	3 323 38
	ldrb	w12, [x11, #1021]
	.loc	3 323 36 is_stmt 0
	strb	w12, [x11, #989]
.Ltmp90:
	.loc	3 321 2 is_stmt 1
	b.ne	.LBB0_51
	b	.LBB0_109
.Ltmp91:
.LBB0_52:
	.loc	3 0 2 is_stmt 0
	sub	w8, w21, #11
.Ltmp92:
	.loc	3 386 22 is_stmt 1
	cmp	w8, #1
	b.hi	.LBB0_109
.Ltmp93:
	cbz	w22, .LBB0_109
.Ltmp94:
	.loc	3 334 2
	cbz	w0, .LBB0_109
.Ltmp95:
	.loc	3 0 0 is_stmt 0
	ldr	x8, [x20, #16]
.Ltmp96:
	.loc	3 334 16
	mov	w9, w0
.Ltmp97:
	.loc	3 334 2
	cmp	w0, #1
	b.ne	.LBB0_150
.Ltmp98:
	.loc	3 0 2
	mov	x10, xzr
.Ltmp99:
.LBB0_57:
	.loc	3 334 2
	sub	x9, x9, x10
	lsl	w10, w10, #10
.Ltmp100:
.LBB0_58:
	.loc	3 335 20 is_stmt 1
	add	x11, x8, w10, sxtw
.Ltmp101:
	.loc	3 334 16
	subs	x9, x9, #1
.Ltmp102:
	.loc	3 338 3
	add	x12, x11, #1021
.Ltmp103:
	.loc	3 334 16
	add	w10, w10, #1024
.Ltmp104:
	.loc	3 336 36
	strb	wzr, [x11, #989]
	.loc	3 337 36
	strb	wzr, [x11, #991]
	.loc	3 338 36
	strh	wzr, [x12]
	.loc	3 341 36
	strh	wzr, [x11, #958]
.Ltmp105:
	.loc	3 334 2
	b.ne	.LBB0_58
	b	.LBB0_109
.Ltmp106:
.LBB0_59:
	.loc	3 189 3
	adrp	x0, .L.str.3
	add	x0, x0, :lo12:.L.str.3
	bl	_printk
.Ltmp107:
	.loc	3 0 3 is_stmt 0
	mov	w0, #255
	b	.LBB0_30
.Ltmp108:
.LBB0_60:
	.loc	3 261 2 is_stmt 1
	sub	x14, x10, #2
	and	x11, x14, #0xffffffff
.Ltmp109:
	lsl	x16, x11, #10
	mov	w11, #62463
	tst	x16, #0xffffffff00000000
	movk	w11, #32767, lsl #16
	cset	w15, ne
	cmp	xzr, x14, lsr #54
	orr	w17, w11, #0x800
	cset	w13, ne
	mov	w11, #1
	cmp	w16, w17
	b.hi	.LBB0_70
.Ltmp110:
	.loc	3 0 2 is_stmt 0
	tbnz	w15, #0, .LBB0_70
.Ltmp111:
	lsr	x15, x14, #32
	cbnz	x15, .LBB0_70
.Ltmp112:
	add	x15, x8, #2046
	lsl	x14, x14, #10
	add	x16, x15, x14
	cmp	x16, x15
	b.lo	.LBB0_70
.Ltmp113:
	tbnz	w13, #0, .LBB0_70
.Ltmp114:
	add	x15, x8, #1056
	add	x14, x15, x14
	cmp	x14, x15
	b.lo	.LBB0_70
.Ltmp115:
	tbnz	w13, #0, .LBB0_70
.Ltmp116:
	.loc	3 261 2
	and	x13, x12, #0xfffffffffffffffe
	orr	x11, x12, #0x1
	mov	w14, #2048
	mov	w15, #2
	mov	w16, #1
	mov	x17, x13
.Ltmp117:
.LBB0_68:
	.loc	3 262 25 is_stmt 1
	sub	w1, w14, #1024
	.loc	3 262 20 is_stmt 0
	add	x2, x8, w14, sxtw
	add	w14, w14, #2048
	subs	x17, x17, #2
	add	x1, x8, w1, sxtw
	.loc	3 263 36 is_stmt 1
	strb	w15, [x2, #1022]
	.loc	3 264 36
	strb	w16, [x2, #32]
	.loc	3 263 36
	strb	w15, [x1, #1022]
	.loc	3 264 36
	strb	w16, [x1, #32]
	b.ne	.LBB0_68
.Ltmp118:
	.loc	3 261 2
	cmp	x12, x13
	b.eq	.LBB0_72
.Ltmp119:
.LBB0_70:
	sub	x10, x10, x11
	lsl	w11, w11, #10
	mov	w12, #2
.Ltmp120:
.LBB0_71:
	.loc	3 262 20
	add	x13, x8, w11, sxtw
.Ltmp121:
	.loc	3 261 16
	subs	x10, x10, #1
	add	w11, w11, #1024
.Ltmp122:
	.loc	3 263 36
	strb	w12, [x13, #1022]
	.loc	3 264 36
	strb	w9, [x13, #32]
.Ltmp123:
	.loc	3 261 2
	b.ne	.LBB0_71
.Ltmp124:
.LBB0_72:
	.loc	3 0 2 is_stmt 0
	sub	w10, w0, #2
.Ltmp125:
	.loc	3 267 2 is_stmt 1
	cmp	w10, #2
	b.lt	.LBB0_98
.Ltmp126:
	.loc	3 0 2 is_stmt 0
	add	x9, x8, #958
	.loc	3 267 2
	sub	x12, x10, #1
	cmp	x12, #2
	b.hs	.LBB0_90
.Ltmp127:
	.loc	3 0 2
	mov	w11, #1
	b	.LBB0_96
.Ltmp128:
.LBB0_75:
	.loc	3 295 2 is_stmt 1
	sub	x14, x10, #4
	mov	w17, #62463
	and	x11, x14, #0xffffffff
	movk	w17, #32767, lsl #16
	lsl	x16, x11, #10
	mov	w11, #3
	tst	x16, #0xffffffff00000000
	cset	w15, ne
	cmp	xzr, x14, lsr #54
	cset	w13, ne
	cmp	w16, w17
	b.hi	.LBB0_85
.Ltmp129:
	.loc	3 0 2 is_stmt 0
	tbnz	w15, #0, .LBB0_85
.Ltmp130:
	lsr	x15, x14, #32
	cbnz	x15, .LBB0_85
.Ltmp131:
	add	x15, x9, #4094
	lsl	x14, x14, #10
	add	x16, x15, x14
	cmp	x16, x15
	b.lo	.LBB0_85
.Ltmp132:
	tbnz	w13, #0, .LBB0_85
.Ltmp133:
	add	x15, x9, #3104
	add	x14, x15, x14
	cmp	x14, x15
	b.lo	.LBB0_85
.Ltmp134:
	tbnz	w13, #0, .LBB0_85
.Ltmp135:
	.loc	3 295 2
	and	x13, x12, #0xfffffffffffffffe
	mov	w14, #4096
	add	x11, x13, #3
	mov	w15, #2
	mov	w16, #1
	mov	x17, x13
.Ltmp136:
.LBB0_83:
	.loc	3 296 25 is_stmt 1
	sub	w1, w14, #1024
	.loc	3 296 20 is_stmt 0
	add	x2, x9, w14, sxtw
	add	w14, w14, #2048
	subs	x17, x17, #2
	add	x1, x9, w1, sxtw
	.loc	3 297 36 is_stmt 1
	strb	w15, [x2, #1022]
	.loc	3 298 36
	strb	w16, [x2, #32]
	.loc	3 297 36
	strb	w15, [x1, #1022]
	.loc	3 298 36
	strb	w16, [x1, #32]
	b.ne	.LBB0_83
.Ltmp137:
	.loc	3 295 2
	cmp	x12, x13
	b.eq	.LBB0_87
.Ltmp138:
.LBB0_85:
	sub	x10, x10, x11
	lsl	w11, w11, #10
	mov	w12, #2
	mov	w13, #1
.Ltmp139:
.LBB0_86:
	.loc	3 296 20
	add	x14, x9, w11, sxtw
.Ltmp140:
	.loc	3 295 16
	subs	x10, x10, #1
	add	w11, w11, #1024
.Ltmp141:
	.loc	3 297 36
	strb	w12, [x14, #1022]
	.loc	3 298 36
	strb	w13, [x14, #32]
.Ltmp142:
	.loc	3 295 2
	b.ne	.LBB0_86
.Ltmp143:
.LBB0_87:
	.loc	3 0 2 is_stmt 0
	sub	w10, w0, #12
.Ltmp144:
	.loc	3 301 2 is_stmt 1
	cmp	w10, #4
	b.lt	.LBB0_107
.Ltmp145:
	.loc	3 0 2 is_stmt 0
	add	x9, x9, #958
.Ltmp146:
	.loc	3 301 2
	sub	x12, x10, #3
	cmp	x12, #2
	b.hs	.LBB0_99
.Ltmp147:
	.loc	3 0 2
	mov	w11, #3
	b	.LBB0_105
.Ltmp148:
.LBB0_90:
	.loc	3 267 2 is_stmt 1
	sub	x13, x10, #2
	and	x11, x13, #0xffffffff
	lsl	x15, x11, #10
	mov	w11, #62463
	tst	x15, #0xffffffff00000000
	movk	w11, #32767, lsl #16
	cset	w14, ne
	orr	w16, w11, #0x800
	mov	w11, #1
	cmp	w15, w16
	b.hi	.LBB0_96
.Ltmp149:
	.loc	3 0 2 is_stmt 0
	tbnz	w14, #0, .LBB0_96
.Ltmp150:
	lsr	x13, x13, #32
	cbnz	x13, .LBB0_96
.Ltmp151:
	.loc	3 267 2
	and	x13, x12, #0xfffffffffffffffe
	orr	x11, x12, #0x1
	mov	w14, #2048
	mov	w15, #2
	mov	x16, x13
.Ltmp152:
.LBB0_94:
	.loc	3 268 25 is_stmt 1
	sub	w17, w14, #1024
	.loc	3 269 36
	strb	w15, [x9, w14, sxtw]
	add	w14, w14, #2048
	subs	x16, x16, #2
	strb	w15, [x9, w17, sxtw]
	b.ne	.LBB0_94
.Ltmp153:
	.loc	3 267 2
	cmp	x12, x13
	b.eq	.LBB0_98
.Ltmp154:
.LBB0_96:
	sub	x10, x10, x11
	lsl	w11, w11, #10
	mov	w12, #2
.Ltmp155:
.LBB0_97:
	.loc	3 269 36
	strb	w12, [x9, w11, sxtw]
.Ltmp156:
	.loc	3 267 16
	subs	x10, x10, #1
	add	w11, w11, #1024
.Ltmp157:
	.loc	3 267 2 is_stmt 0
	b.ne	.LBB0_97
.Ltmp158:
.LBB0_98:
	.loc	3 0 2
	mov	w10, #1
	mov	w11, #2
.Ltmp159:
	.loc	3 277 2 is_stmt 1
	add	x9, x8, #3966
	.loc	3 273 35
	strb	w10, [x8, #1918]
	.loc	3 275 35
	strb	w11, [x8, #2942]
.Ltmp160:
	.loc	3 0 35 is_stmt 0
	b	.LBB0_108
.Ltmp161:
.LBB0_99:
	.loc	3 301 2 is_stmt 1
	sub	x13, x10, #4
	mov	w16, #62463
	and	x11, x13, #0xffffffff
	movk	w16, #32767, lsl #16
	lsl	x15, x11, #10
	mov	w11, #3
	tst	x15, #0xffffffff00000000
	cset	w14, ne
	cmp	w15, w16
	b.hi	.LBB0_105
.Ltmp162:
	.loc	3 0 2 is_stmt 0
	tbnz	w14, #0, .LBB0_105
.Ltmp163:
	lsr	x13, x13, #32
	cbnz	x13, .LBB0_105
.Ltmp164:
	.loc	3 301 2
	and	x13, x12, #0xfffffffffffffffe
	mov	w14, #4096
	add	x11, x13, #3
	mov	w15, #2
	mov	x16, x13
.Ltmp165:
.LBB0_103:
	.loc	3 302 25 is_stmt 1
	sub	w17, w14, #1024
	.loc	3 303 36
	strb	w15, [x9, w14, sxtw]
	add	w14, w14, #2048
	subs	x16, x16, #2
	strb	w15, [x9, w17, sxtw]
	b.ne	.LBB0_103
.Ltmp166:
	.loc	3 301 2
	cmp	x12, x13
	b.eq	.LBB0_107
.Ltmp167:
.LBB0_105:
	sub	x10, x10, x11
	lsl	w11, w11, #10
	mov	w12, #2
.Ltmp168:
.LBB0_106:
	.loc	3 303 36
	strb	w12, [x9, w11, sxtw]
.Ltmp169:
	.loc	3 301 16
	subs	x10, x10, #1
	add	w11, w11, #1024
.Ltmp170:
	.loc	3 301 2 is_stmt 0
	b.ne	.LBB0_106
.Ltmp171:
.LBB0_107:
	.loc	3 0 2
	mov	w10, #1
	mov	w11, #2
.Ltmp172:
	.loc	3 311 2 is_stmt 1
	add	x9, x8, #2048
	.loc	3 307 35
	strb	w10, [x8]
	.loc	3 309 35
	strb	w11, [x8, #1024]
.Ltmp173:
.LBB0_108:
	.loc	3 0 35 is_stmt 0
	mov	w8, #2
	strb	w8, [x9]
.Ltmp174:
.LBB0_109:
	.loc	3 389 21 is_stmt 1
	ldrb	w8, [x20, #1]
	mov	w9, #21846
	movk	w9, #21845, lsl #16
	.loc	3 390 21
	orr	w8, w0, w8, lsl #8
	str	w8, [x20]
.Ltmp175:
	.loc	3 394 27
	ldrsw	x8, [x24, :lo12:pvi_wf_get_lut.sftemp]
.Ltmp176:
	.loc	3 391 9
	str	w21, [x27, :lo12:pvi_wf_get_lut.stype]
.Ltmp177:
	.loc	3 394 34
	mul	x8, x8, x9
	lsr	x9, x8, #63
	lsr	x8, x8, #32
	add	w10, w8, w9
.Ltmp178:
.LBB0_110:
	.loc	3 394 6 is_stmt 0
	cmp	w26, w10
	b.ne	.LBB0_112
.Ltmp179:
.LBB0_111:
	.loc	3 0 6
	mov	w0, wzr
	b	.LBB0_137
.Ltmp180:
.LBB0_112:
	.loc	3 396 18 is_stmt 1
	ldr	x8, [x20, #24]
	.loc	3 396 16 is_stmt 0
	adrp	x9, waveformdata
	str	x8, [x9, :lo12:waveformdata]
	.loc	3 397 17 is_stmt 1
	bl	epd_overlay_lut
.Ltmp181:
	.loc	3 207 17
	ldr	x8, [x25, :lo12:global_waveform]
	.loc	3 207 34 is_stmt 0
	ldrb	w9, [x8, #38]
.Ltmp182:
	.loc	3 211 2 is_stmt 1
	cbz	w9, .LBB0_117
.Ltmp183:
	.loc	3 0 2 is_stmt 0
	mov	x10, xzr
	.loc	3 211 2
	add	x11, x8, #48
.Ltmp184:
.LBB0_114:
	.loc	3 212 21 is_stmt 1
	ldrb	w12, [x11, x10]
.Ltmp185:
	.loc	3 212 7 is_stmt 0
	cmp	w12, w19
	b.ge	.LBB0_118
.Ltmp186:
	.loc	3 211 29 is_stmt 1
	add	x10, x10, #1
.Ltmp187:
	.loc	3 211 2 is_stmt 0
	cmp	x9, x10
	b.ne	.LBB0_114
.Ltmp188:
	.loc	3 0 2
	mov	w11, #-1
	mov	w10, w9
.Ltmp189:
	b	.LBB0_119
.Ltmp190:
.LBB0_117:
	mov	w10, wzr
	mov	w11, #-1
	b	.LBB0_119
.Ltmp191:
.LBB0_118:
	mov	w11, w10
.Ltmp192:
.LBB0_119:
	sub	w12, w10, #1
	.loc	3 218 6 is_stmt 1
	cmp	w10, w9
	csel	w21, w12, w11, eq
.Ltmp193:
	.loc	3 188 6
	cmp	w0, #13
	b.hs	.LBB0_139
.Ltmp194:
	.loc	3 191 13
	sub	w9, w0, #10
	cmp	w9, #3
	b.hs	.LBB0_122
.Ltmp195:
	adrp	x10, .Lswitch.table.pvi_wf_get_lut.7
	add	x10, x10, :lo12:.Lswitch.table.pvi_wf_get_lut.7
	ldr	x9, [x10, w9, sxtw #3]
	b	.LBB0_123
.Ltmp196:
.LBB0_122:
	.loc	3 0 13 is_stmt 0
	mov	w9, w0
.Ltmp197:
.LBB0_123:
	.loc	3 168 20 is_stmt 1
	ldrb	w10, [x8, #16]
	.loc	3 168 2 is_stmt 0
	sub	w8, w10, #9
.Ltmp198:
	cmp	w8, #75
	b.hi	.LBB0_126
.Ltmp199:
	.loc	3 0 2
	adrp	x10, .LJTI0_1
	add	x10, x10, :lo12:.LJTI0_1
	adr	x11, .LBB0_125
	ldrb	w12, [x10, x8]
	add	x11, x11, x12, lsl #2
	adrp	x8, pvi_mode_table
	add	x8, x8, :lo12:pvi_mode_table
	br	x11
.Ltmp200:
.LBB0_125:
	adrp	x8, pvi_mode_table+30
	add	x8, x8, :lo12:pvi_mode_table+30
.Ltmp201:
	b	.LBB0_134
.Ltmp202:
.LBB0_126:
	.loc	3 168 2
	cmp	w10, #114
	b.ne	.LBB0_128
.Ltmp203:
	.loc	3 0 2
	adrp	x8, pvi_mode_table+70
	add	x8, x8, :lo12:pvi_mode_table+70
	b	.LBB0_134
.Ltmp204:
.LBB0_128:
	adrp	x8, pvi_mode_table+80
	add	x8, x8, :lo12:pvi_mode_table+80
	b	.LBB0_134
.Ltmp205:
.LBB0_129:
	adrp	x8, pvi_mode_table+10
	add	x8, x8, :lo12:pvi_mode_table+10
	b	.LBB0_134
.Ltmp206:
.LBB0_130:
	adrp	x8, pvi_mode_table+20
	add	x8, x8, :lo12:pvi_mode_table+20
	b	.LBB0_134
.Ltmp207:
.LBB0_131:
	adrp	x8, pvi_mode_table+40
	add	x8, x8, :lo12:pvi_mode_table+40
	b	.LBB0_134
.Ltmp208:
.LBB0_132:
	adrp	x8, pvi_mode_table+50
	add	x8, x8, :lo12:pvi_mode_table+50
	b	.LBB0_134
.Ltmp209:
.LBB0_133:
	adrp	x8, pvi_mode_table+60
	add	x8, x8, :lo12:pvi_mode_table+60
.Ltmp210:
.LBB0_134:
	.loc	3 202 9 is_stmt 1
	ldrb	w0, [x8, x9]
.Ltmp211:
.LBB0_135:
	.loc	3 400 15
	mov	w1, w21
	bl	get_wf_frm_num
.Ltmp212:
	.loc	3 401 7
	tbnz	w0, #31, .LBB0_138
.Ltmp213:
	.loc	3 405 21
	ldrb	w8, [x20]
	.loc	3 406 21
	bfi	w8, w0, #8, #24
	mov	w0, wzr
.Ltmp214:
	str	w8, [x20]
	.loc	3 407 10
	str	w19, [x24, :lo12:pvi_wf_get_lut.sftemp]
.Ltmp215:
.LBB0_137:
	.loc	3 411 1
	ldp	x20, x19, [sp, #80]
	ldp	x22, x21, [sp, #64]
	ldp	x24, x23, [sp, #48]
	ldp	x26, x25, [sp, #32]
	ldr	x27, [sp, #16]
	ldp	x29, x30, [sp], #96
	ldr	x30, [x18, #-8]!
	ret
.LBB0_138:
.Ltmp216:
	.loc	3 0 0 is_stmt 0
	adrp	x0, .L.str
.Ltmp217:
	add	x0, x0, :lo12:.L.str
	bl	_printk
.Ltmp218:
	mov	w0, #-5
	b	.LBB0_137
.Ltmp219:
.LBB0_139:
	.loc	3 189 3 is_stmt 1
	adrp	x0, .L.str.3
.Ltmp220:
	add	x0, x0, :lo12:.L.str.3
	bl	_printk
.Ltmp221:
	.loc	3 0 3 is_stmt 0
	mov	w0, #255
	b	.LBB0_135
.Ltmp222:
.LBB0_140:
	.loc	3 321 2 is_stmt 1
	sub	x12, x9, #1
	mov	x10, xzr
	and	x11, x12, #0xffffffff
	lsl	x14, x11, #10
	tst	x14, #0xffffffff00000000
	cset	w13, ne
	cmp	xzr, x12, lsr #54
	cset	w11, ne
	tbnz	w14, #31, .LBB0_50
.Ltmp223:
	.loc	3 0 2 is_stmt 0
	tbnz	w13, #0, .LBB0_50
.Ltmp224:
	lsr	x13, x12, #32
	cbnz	x13, .LBB0_50
.Ltmp225:
	add	x13, x8, #1021
	lsl	x12, x12, #10
	add	x14, x13, x12
	cmp	x14, x13
	b.lo	.LBB0_50
.Ltmp226:
	tbnz	w11, #0, .LBB0_50
.Ltmp227:
	add	x13, x8, #989
	add	x12, x13, x12
	cmp	x12, x13
	b.lo	.LBB0_50
.Ltmp228:
	tbnz	w11, #0, .LBB0_50
.Ltmp229:
	.loc	3 321 2
	and	x10, x9, #0xfffffffe
	mov	w11, #1024
	mov	x12, x10
.Ltmp230:
.LBB0_148:
	.loc	3 321 30
	sub	w13, w11, #1024
	add	x14, x8, w11, sxtw
	subs	x12, x12, #2
	add	w11, w11, #2048
	add	x13, x8, w13, sxtw
	ldrb	w16, [x14, #1021]
	ldrb	w15, [x13, #1021]
	strb	w16, [x14, #989]
	strb	w15, [x13, #989]
	b.ne	.LBB0_148
.Ltmp231:
	.loc	3 321 2
	cmp	x10, x9
	b.ne	.LBB0_50
	b	.LBB0_109
.Ltmp232:
.LBB0_150:
	.loc	3 334 2 is_stmt 1
	sub	x12, x9, #1
	mov	x10, xzr
	and	x11, x12, #0xffffffff
	lsl	x14, x11, #10
	tst	x14, #0xffffffff00000000
	cset	w13, ne
	cmp	xzr, x12, lsr #54
	cset	w11, ne
	tbnz	w14, #31, .LBB0_57
.Ltmp233:
	.loc	3 0 2 is_stmt 0
	tbnz	w13, #0, .LBB0_57
.Ltmp234:
	lsr	x13, x12, #32
	cbnz	x13, .LBB0_57
.Ltmp235:
	add	x13, x8, #959
	lsl	x12, x12, #10
	add	x14, x13, x12
	cmp	x14, x13
	b.lo	.LBB0_57
.Ltmp236:
	tbnz	w11, #0, .LBB0_57
.Ltmp237:
	add	x13, x8, #958
	add	x14, x13, x12
	cmp	x14, x13
	b.lo	.LBB0_57
.Ltmp238:
	tbnz	w11, #0, .LBB0_57
.Ltmp239:
	add	x13, x8, #1022
	add	x14, x13, x12
	cmp	x14, x13
	b.lo	.LBB0_57
.Ltmp240:
	tbnz	w11, #0, .LBB0_57
.Ltmp241:
	add	x13, x8, #1021
	add	x14, x13, x12
	cmp	x14, x13
	b.lo	.LBB0_57
.Ltmp242:
	tbnz	w11, #0, .LBB0_57
.Ltmp243:
	add	x13, x8, #991
	add	x14, x13, x12
	cmp	x14, x13
	b.lo	.LBB0_57
.Ltmp244:
	tbnz	w11, #0, .LBB0_57
.Ltmp245:
	add	x13, x8, #989
	add	x12, x13, x12
	cmp	x12, x13
	b.lo	.LBB0_57
.Ltmp246:
	tbnz	w11, #0, .LBB0_57
.Ltmp247:
	.loc	3 334 2
	and	x10, x9, #0xfffffffe
	mov	w11, #1024
	mov	x12, x10
.Ltmp248:
.LBB0_166:
	.loc	3 334 30
	add	x13, x8, w11, sxtw
	sub	w14, w11, #1024
	add	x15, x13, #1021
	subs	x12, x12, #2
	add	x14, x8, w14, sxtw
	add	w11, w11, #2048
	strb	wzr, [x13, #989]
	strh	wzr, [x15]
	add	x15, x14, #1021
	strb	wzr, [x13, #991]
	strb	wzr, [x14, #989]
	strb	wzr, [x14, #991]
	strh	wzr, [x14, #958]
	strh	wzr, [x15]
	strh	wzr, [x13, #958]
	b.ne	.LBB0_166
.Ltmp249:
	.loc	3 334 2
	cmp	x10, x9
	b.ne	.LBB0_57
	b	.LBB0_109
.Ltmp250:
.Lfunc_end0:
	.size	pvi_wf_get_lut, .Lfunc_end0-pvi_wf_get_lut
	.cfi_endproc
	.section	.rodata,"a",@progbits
.LJTI0_0:
	.byte	(.LBB0_29-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_24-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_25-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_20-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_26-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_20-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_27-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_23-.LBB0_20)>>2
	.byte	(.LBB0_28-.LBB0_20)>>2
.LJTI0_1:
	.byte	(.LBB0_134-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_129-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_130-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_125-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_131-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_125-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_132-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_128-.LBB0_125)>>2
	.byte	(.LBB0_133-.LBB0_125)>>2

	.text
	.p2align	2
	.type	get_wf_frm_num,@function
get_wf_frm_num:
.Lfunc_begin1:
	.loc	3 225 0 is_stmt 1
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
.Ltmp251:
	.loc	3 226 45 prologue_end
	adrp	x8, global_waveform
	.loc	3 230 37
	lsl	w9, w0, #2
	.loc	3 226 45
	ldr	x14, [x8, :lo12:global_waveform]
.Ltmp252:
	.loc	3 228 32
	ldrb	w8, [x14, #32]
.Ltmp253:
	.loc	3 230 21
	add	x8, x14, x8
.Ltmp254:
	.loc	3 230 30 is_stmt 0
	add	x8, x8, x9
.Ltmp255:
	.loc	3 231 22 is_stmt 1
	ldrb	w9, [x8]
	.loc	3 231 35 is_stmt 0
	ldrb	w10, [x8, #1]
	.loc	3 231 48
	ldrb	w11, [x8, #2]
	.loc	3 231 6
	ldrb	w12, [x8, #3]
	.loc	3 231 33
	add	w9, w10, w9
	.loc	3 231 46
	add	w9, w9, w11
.Ltmp256:
	.loc	3 231 6
	cmp	w12, w9, uxtb
	b.ne	.LBB1_36
.Ltmp257:
	.loc	3 0 6
	ldr	w8, [x8]
.Ltmp258:
	.loc	3 237 43 is_stmt 1
	lsl	w9, w1, #2
	.loc	3 235 28
	and	x8, x8, #0xffffff
.Ltmp259:
	.loc	3 237 21
	add	x8, x14, x8
.Ltmp260:
	.loc	3 237 30 is_stmt 0
	add	x8, x8, w9, sxtw
.Ltmp261:
	.loc	3 238 22 is_stmt 1
	ldrb	w9, [x8]
	.loc	3 238 35 is_stmt 0
	ldrb	w10, [x8, #1]
	.loc	3 238 48
	ldrb	w11, [x8, #2]
	.loc	3 238 6
	ldrb	w12, [x8, #3]
	.loc	3 238 33
	add	w9, w10, w9
	.loc	3 238 46
	add	w9, w9, w11
.Ltmp262:
	.loc	3 238 6
	cmp	w12, w9, uxtb
	b.ne	.LBB1_37
.Ltmp263:
	.loc	3 55 7 is_stmt 1
	adrp	x20, waveformdata
	ldr	x10, [x20, :lo12:waveformdata]
.Ltmp264:
	.loc	3 55 6 is_stmt 0
	cbz	x10, .LBB1_39
.Ltmp265:
	.loc	3 0 6
	adrp	x21, need_pic
.Ltmp266:
	.loc	3 60 6 is_stmt 1
	adrp	x22, maxpic
	ldr	w15, [x8]
	mov	w16, #5
	mov	w0, #32
.Ltmp267:
	.loc	3 0 6 is_stmt 0
	mov	w13, wzr
	ldr	w9, [x21, :lo12:need_pic]
	mov	w11, wzr
	.loc	3 60 6
	ldrb	w8, [x22, :lo12:maxpic]
.Ltmp268:
	.loc	3 0 0
	and	x15, x15, #0xffffff
.Ltmp269:
	add	x14, x14, x15
.Ltmp270:
	mov	w19, wzr
	cmp	w9, #32
	mov	w12, wzr
	cset	w17, eq
	bics	w15, w17, w8
.Ltmp271:
	mov	w17, #16
	cinc	w16, w16, ne
	cmp	w8, #0
	csel	w17, w0, w17, ne
	mov	w0, #1
.Ltmp272:
	b	.LBB1_6
.Ltmp273:
.LBB1_4:
	mov	w0, #1
.Ltmp274:
.LBB1_5:
	add	w11, w11, #1
.Ltmp275:
	.loc	3 64 7 is_stmt 1
	cmp	w19, #254
	b.hi	.LBB1_18
.Ltmp276:
.LBB1_6:
	.loc	3 69 7
	ldrb	w3, [x14, w11, uxtw]
.Ltmp277:
	.loc	3 69 7 is_stmt 0
	cmp	w3, #252
	b.eq	.LBB1_11
.Ltmp278:
	cmp	w3, #255
	b.eq	.LBB1_19
.Ltmp279:
	.loc	3 79 7 is_stmt 1
	tbnz	w0, #0, .LBB1_12
.Ltmp280:
.LBB1_9:
	.loc	3 114 44
	add	w0, w13, #1
.Ltmp281:
	.loc	3 114 75 is_stmt 0
	lsl	w1, w12, w15
.Ltmp282:
	.loc	3 114 47
	lsl	w2, w13, w16
	.loc	3 114 35
	add	w1, w1, w19, lsl #10
	.loc	3 115 47 is_stmt 1
	lsl	w0, w0, w16
.Ltmp283:
	.loc	3 114 65
	add	w2, w1, w2
	.loc	3 115 65
	add	w0, w1, w0
	.loc	3 114 99
	and	w4, w3, #0x3
	.loc	3 115 106
	ubfx	w5, w3, #2, #2
	.loc	3 114 88
	strb	w4, [x10, w2, uxtw]
	.loc	3 115 44
	add	w2, w13, #2
.Ltmp284:
	.loc	3 115 88 is_stmt 0
	strb	w5, [x10, w0, uxtw]
	.loc	3 116 44 is_stmt 1
	add	w0, w13, #3
.Ltmp285:
	.loc	3 116 47 is_stmt 0
	lsl	w2, w2, w16
	.loc	3 117 47 is_stmt 1
	lsl	w0, w0, w16
.Ltmp286:
	.loc	3 116 65
	add	w2, w1, w2
	.loc	3 117 65
	add	w0, w1, w0
	.loc	3 116 106
	ubfx	w4, w3, #4, #2
	.loc	3 117 100
	lsr	w1, w3, #6
	.loc	3 117 44 is_stmt 0
	add	w13, w13, #4
.Ltmp287:
	.loc	3 116 88 is_stmt 1
	strb	w4, [x10, w2, uxtw]
	.loc	3 120 8
	cmp	w13, w17
	.loc	3 117 88
	strb	w1, [x10, w0, uxtw]
.Ltmp288:
	.loc	3 0 88 is_stmt 0
	mov	w0, wzr
	.loc	3 120 8 is_stmt 1
	b.lo	.LBB1_5
.Ltmp289:
	.loc	3 122 9
	add	w1, w12, #1
.Ltmp290:
	.loc	3 0 9 is_stmt 0
	mov	w13, wzr
	.loc	3 122 18
	cmp	w1, w17
.Ltmp291:
	.loc	3 122 9
	csinc	w12, wzr, w12, hs
	cinc	w19, w19, hs
.Ltmp292:
	.loc	3 0 9
	b	.LBB1_5
.Ltmp293:
.LBB1_11:
	.loc	3 76 10 is_stmt 1
	add	w11, w11, #1
.Ltmp294:
	.loc	3 0 0 is_stmt 0
	ldrb	w3, [x14, w11, uxtw]
.Ltmp295:
	.loc	3 79 7 is_stmt 1
	tbnz	w0, #0, .LBB1_9
.Ltmp296:
.LBB1_12:
	.loc	3 81 44
	add	w0, w13, #1
.Ltmp297:
	.loc	3 81 75 is_stmt 0
	lsl	w1, w12, w15
.Ltmp298:
	.loc	3 81 47
	lsl	w2, w13, w16
	.loc	3 81 35
	add	w4, w1, w19, lsl #10
	.loc	3 82 47 is_stmt 1
	lsl	w1, w0, w16
	.loc	3 81 65
	add	w2, w4, w2
	.loc	3 82 65
	add	w5, w4, w1
	.loc	3 81 99
	and	w0, w3, #0x3
.Ltmp299:
	.loc	3 82 106
	ubfx	w1, w3, #2, #2
	.loc	3 81 88
	strb	w0, [x10, w2, uxtw]
	.loc	3 82 44
	add	w2, w13, #2
.Ltmp300:
	.loc	3 82 88 is_stmt 0
	strb	w1, [x10, w5, uxtw]
	.loc	3 83 44 is_stmt 1
	add	w5, w13, #3
.Ltmp301:
	.loc	3 83 47 is_stmt 0
	lsl	w2, w2, w16
	.loc	3 84 47 is_stmt 1
	lsl	w5, w5, w16
.Ltmp302:
	.loc	3 83 65
	add	w6, w4, w2
	.loc	3 83 106 is_stmt 0
	ubfx	w2, w3, #4, #2
	.loc	3 84 65 is_stmt 1
	add	w4, w4, w5
	.loc	3 84 100 is_stmt 0
	lsr	w3, w3, #6
.Ltmp303:
	.loc	3 84 44
	add	w13, w13, #4
.Ltmp304:
	.loc	3 87 8 is_stmt 1
	cmp	w13, w17
	.loc	3 83 88
	strb	w2, [x10, w6, uxtw]
	.loc	3 84 88
	strb	w3, [x10, w4, uxtw]
.Ltmp305:
	.loc	3 87 8
	b.lo	.LBB1_14
.Ltmp306:
	.loc	3 89 9
	add	w4, w12, #1
.Ltmp307:
	.loc	3 0 9 is_stmt 0
	mov	w13, wzr
	.loc	3 89 18
	cmp	w4, w17
.Ltmp308:
	.loc	3 89 9
	csinc	w12, wzr, w12, hs
	cinc	w19, w19, hs
.Ltmp309:
.LBB1_14:
	.loc	3 0 0
	add	w11, w11, #1
.Ltmp310:
	.loc	3 95 8 is_stmt 1
	ldrb	w4, [x14, w11, uxtw]
.Ltmp311:
	.loc	3 96 4
	cbnz	w4, .LBB1_16
	b	.LBB1_4
.Ltmp312:
.LBB1_15:
	.loc	3 96 19 is_stmt 0
	sub	w4, w4, #1
.Ltmp313:
	tst	w4, #0xff
.Ltmp314:
	.loc	3 96 4
	b.eq	.LBB1_4
.Ltmp315:
.LBB1_16:
	.loc	3 97 45 is_stmt 1
	add	w5, w13, #1
.Ltmp316:
	.loc	3 97 76 is_stmt 0
	lsl	w6, w12, w15
	.loc	3 98 45 is_stmt 1
	add	w23, w13, #2
.Ltmp317:
	.loc	3 99 45
	add	w24, w13, #3
.Ltmp318:
	.loc	3 97 48
	lsl	w7, w13, w16
	.loc	3 97 36 is_stmt 0
	add	w6, w6, w19, lsl #10
	.loc	3 98 48 is_stmt 1
	lsl	w5, w5, w16
	.loc	3 99 48
	lsl	w23, w23, w16
	.loc	3 100 48
	lsl	w24, w24, w16
.Ltmp319:
	.loc	3 97 66
	add	w7, w6, w7
	.loc	3 98 66
	add	w5, w6, w5
	.loc	3 99 66
	add	w23, w6, w23
	.loc	3 100 66
	add	w6, w6, w24
	.loc	3 100 45 is_stmt 0
	add	w13, w13, #4
.Ltmp320:
	.loc	3 101 9 is_stmt 1
	cmp	w13, w17
	.loc	3 97 89
	strb	w0, [x10, w7, uxtw]
	.loc	3 98 89
	strb	w1, [x10, w5, uxtw]
	.loc	3 99 89
	strb	w2, [x10, w23, uxtw]
	.loc	3 100 89
	strb	w3, [x10, w6, uxtw]
	.loc	3 101 9
	b.lo	.LBB1_15
.Ltmp321:
	.loc	3 103 10
	add	w5, w12, #1
.Ltmp322:
	.loc	3 0 10 is_stmt 0
	mov	w13, wzr
	.loc	3 103 19
	cmp	w5, w17
.Ltmp323:
	.loc	3 103 10
	csinc	w12, wzr, w12, hs
	cinc	w19, w19, hs
.Ltmp324:
	.loc	3 0 10
	b	.LBB1_15
.Ltmp325:
.LBB1_18:
	.loc	3 65 4 is_stmt 1
	adrp	x0, .L.str.6
	add	x0, x0, :lo12:.L.str.6
	bl	_printk
.Ltmp326:
	.loc	3 130 6
	ldrb	w8, [x22, :lo12:maxpic]
	ldr	w9, [x21, :lo12:need_pic]
.Ltmp327:
.LBB1_19:
	.loc	3 130 24 is_stmt 0
	cbz	w8, .LBB1_26
.Ltmp328:
	cmp	w9, #16
	b.ne	.LBB1_26
.Ltmp329:
	.loc	3 132 3 is_stmt 1
	cbz	w19, .LBB1_41
.Ltmp330:
	.loc	3 0 3 is_stmt 0
	ldr	x13, [x20, :lo12:waveformdata]
	mov	w10, wzr
	mov	w11, wzr
	.loc	3 132 3
	add	x12, x13, #16
	add	x13, x13, #7
.Ltmp331:
.LBB1_23:
	.loc	3 0 3
	mov	w15, w10
	mov	x16, #-2
.Ltmp332:
	add	x14, x12, x15
	and	x15, x15, #0xffffffe0
	add	x15, x13, x15
.Ltmp333:
.LBB1_24:
	.loc	3 135 17 is_stmt 1
	ldurb	w17, [x14, #-16]
.Ltmp334:
	.loc	3 133 28
	add	x16, x16, #2
.Ltmp335:
	.loc	3 133 4 is_stmt 0
	cmp	x16, #30
.Ltmp336:
	.loc	3 136 61 is_stmt 1
	sturb	w17, [x15, #-7]
.Ltmp337:
	.loc	3 135 17
	ldurb	w17, [x14, #-14]
.Ltmp338:
	.loc	3 136 61
	sturb	w17, [x15, #-6]
.Ltmp339:
	.loc	3 135 17
	ldurb	w17, [x14, #-12]
.Ltmp340:
	.loc	3 136 61
	sturb	w17, [x15, #-5]
.Ltmp341:
	.loc	3 135 17
	ldurb	w17, [x14, #-10]
.Ltmp342:
	.loc	3 136 61
	sturb	w17, [x15, #-4]
.Ltmp343:
	.loc	3 135 17
	ldurb	w17, [x14, #-8]
.Ltmp344:
	.loc	3 136 61
	sturb	w17, [x15, #-3]
.Ltmp345:
	.loc	3 135 17
	ldurb	w17, [x14, #-6]
.Ltmp346:
	.loc	3 136 61
	sturb	w17, [x15, #-2]
.Ltmp347:
	.loc	3 135 17
	ldurb	w17, [x14, #-4]
.Ltmp348:
	.loc	3 136 61
	sturb	w17, [x15, #-1]
.Ltmp349:
	.loc	3 135 17
	ldurb	w17, [x14, #-2]
.Ltmp350:
	.loc	3 136 61
	strb	w17, [x15]
.Ltmp351:
	.loc	3 135 17
	ldrb	w17, [x14]
.Ltmp352:
	.loc	3 136 61
	strb	w17, [x15, #1]
.Ltmp353:
	.loc	3 135 17
	ldrb	w17, [x14, #2]
.Ltmp354:
	.loc	3 136 61
	strb	w17, [x15, #2]
.Ltmp355:
	.loc	3 135 17
	ldrb	w17, [x14, #4]
.Ltmp356:
	.loc	3 136 61
	strb	w17, [x15, #3]
.Ltmp357:
	.loc	3 135 17
	ldrb	w17, [x14, #6]
.Ltmp358:
	.loc	3 136 61
	strb	w17, [x15, #4]
.Ltmp359:
	.loc	3 135 17
	ldrb	w17, [x14, #8]
.Ltmp360:
	.loc	3 136 61
	strb	w17, [x15, #5]
.Ltmp361:
	.loc	3 135 17
	ldrb	w17, [x14, #10]
.Ltmp362:
	.loc	3 136 61
	strb	w17, [x15, #6]
.Ltmp363:
	.loc	3 135 17
	ldrb	w17, [x14, #12]
.Ltmp364:
	.loc	3 136 61
	strb	w17, [x15, #7]
.Ltmp365:
	.loc	3 135 17
	ldrb	w17, [x14, #14]
.Ltmp366:
	.loc	3 133 28
	add	x14, x14, #64
.Ltmp367:
	.loc	3 136 61
	strb	w17, [x15, #8]
.Ltmp368:
	.loc	3 133 28
	add	x15, x15, #32
.Ltmp369:
	.loc	3 133 4 is_stmt 0
	b.lo	.LBB1_24
.Ltmp370:
	.loc	3 132 31 is_stmt 1
	add	w11, w11, #1
.Ltmp371:
	.loc	3 132 3 is_stmt 0
	add	w10, w10, #1024
.Ltmp372:
	cmp	w19, w11, uxtb
	b.hi	.LBB1_23
.Ltmp373:
.LBB1_26:
	.loc	3 0 3
	cmp	w9, #32
	cset	w9, eq
.Ltmp374:
	.loc	3 142 24 is_stmt 1
	and	w8, w8, w9
	cmp	w8, #1
	b.ne	.LBB1_41
.Ltmp375:
	.loc	3 144 3
	cbz	w19, .LBB1_41
.Ltmp376:
	.loc	3 0 3 is_stmt 0
	ldr	x8, [x20, :lo12:waveformdata]
	mov	x9, xzr
	.loc	3 144 3
	subs	w10, w19, #1
	b.eq	.LBB1_34
.Ltmp377:
	neg	w11, w19
	tst	w11, #0xff
	b.eq	.LBB1_34
.Ltmp378:
	.loc	3 0 3
	cmp	w10, #255
	b.hi	.LBB1_34
.Ltmp379:
	add	x10, x10, #1
	mov	x12, x8
	.loc	3 144 3
	and	x9, x10, #0x1fffffffe
	mov	x11, x9
.Ltmp380:
.LBB1_32:
	.loc	3 144 15
	strb	wzr, [x12, #989]
	subs	x11, x11, #2
	strb	wzr, [x12, #2013]
	add	x12, x12, #2048
	b.ne	.LBB1_32
.Ltmp381:
	.loc	3 144 3
	cmp	x10, x9
	b.eq	.LBB1_41
.Ltmp382:
.LBB1_34:
	add	x8, x8, x9, lsl #10
	add	w9, w9, #1
	add	x8, x8, #989
.Ltmp383:
.LBB1_35:
	add	w10, w9, #1
	cmp	w19, w9, uxtb
.Ltmp384:
	.loc	3 145 45 is_stmt 1
	strb	wzr, [x8]
.Ltmp385:
	.loc	3 144 3
	add	x8, x8, #1024
	mov	w9, w10
	b.hi	.LBB1_35
	b	.LBB1_41
.Ltmp386:
.LBB1_36:
	.loc	3 232 3
	adrp	x0, .L.str.4
.Ltmp387:
	adrp	x1, .L__func__.get_wf_frm_num
.Ltmp388:
	add	x0, x0, :lo12:.L.str.4
	add	x1, x1, :lo12:.L__func__.get_wf_frm_num
	mov	w2, #232
	b	.LBB1_38
.Ltmp389:
.LBB1_37:
	.loc	3 239 3
	adrp	x0, .L.str.4
.Ltmp390:
	adrp	x1, .L__func__.get_wf_frm_num
.Ltmp391:
	add	x0, x0, :lo12:.L.str.4
	add	x1, x1, :lo12:.L__func__.get_wf_frm_num
	mov	w2, #239
.Ltmp392:
.LBB1_38:
	.loc	3 0 0 is_stmt 0
	bl	_printk
.Ltmp393:
	b	.LBB1_40
.Ltmp394:
.LBB1_39:
	.loc	3 56 3 is_stmt 1
	adrp	x0, .L.str.5
.Ltmp395:
	add	x0, x0, :lo12:.L.str.5
	bl	_printk
.Ltmp396:
.LBB1_40:
	.loc	3 0 3 is_stmt 0
	mov	w19, #-22
.Ltmp397:
.LBB1_41:
	.loc	3 246 1 is_stmt 1
	mov	w0, w19
	ldp	x20, x19, [sp, #48]
	ldp	x22, x21, [sp, #32]
	ldp	x24, x23, [sp, #16]
	ldp	x29, x30, [sp], #64
	ldr	x30, [x18, #-8]!
	ret
.Ltmp398:
.Lfunc_end1:
	.size	get_wf_frm_num, .Lfunc_end1-get_wf_frm_num
	.cfi_endproc
	.file	6 "/home/lyx/rk-android14/kernel-6.1" "./include/linux/types.h"

	.globl	pvi_wf_input
	.p2align	2
	.type	pvi_wf_input,@function
pvi_wf_input:
.Lfunc_begin2:
	.loc	3 420 0
	.cfi_startproc
	str	x30, [x18], #8
	.cfi_escape 0x16, 0x12, 0x02, 0x82, 0x78
	stp	x29, x30, [sp, #-32]!
	stp	x20, x19, [sp, #16]
	mov	x29, sp
	.cfi_def_cfa w29, 32
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w30, -24
	.cfi_offset w29, -32
.Ltmp399:
	.loc	3 423 6 prologue_end
	adrp	x20, global_waveform
	ldr	x8, [x20, :lo12:global_waveform]
.Ltmp400:
	.loc	3 423 6 is_stmt 0
	cbz	x8, .LBB2_3
.Ltmp401:
	.loc	3 0 6
	mov	w0, #-16
.Ltmp402:
.LBB2_2:
	.loc	3 453 1 is_stmt 1
	ldp	x20, x19, [sp, #16]
	ldp	x29, x30, [sp], #32
	ldr	x30, [x18, #-8]!
	ret
.Ltmp403:
.LBB2_3:
	.loc	3 0 1 is_stmt 0
	mov	x19, x0
.Ltmp404:
	.loc	3 426 2 is_stmt 1
	ldrb	w1, [x0, #16]
	adrp	x0, .L.str.1
	add	x0, x0, :lo12:.L.str.1
	bl	_printk
.Ltmp405:
	.loc	3 429 18
	ldrb	w1, [x19, #16]
	.loc	3 429 2 is_stmt 0
	sub	w8, w1, #9
	cmp	w8, #105
	b.hi	.LBB2_7
.Ltmp406:
	.loc	3 0 2
	adrp	x9, .LJTI2_0
	add	x9, x9, :lo12:.LJTI2_0
	adr	x10, .LBB2_5
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
.Ltmp407:
.LBB2_5:
	.loc	3 437 10 is_stmt 1
	adrp	x8, maxpic
	mov	w9, #1
	strb	w9, [x8, :lo12:maxpic]
.Ltmp408:
.LBB2_6:
	.loc	3 0 10 is_stmt 0
	mov	w0, wzr
	.loc	3 450 18 is_stmt 1
	str	x19, [x20, :lo12:global_waveform]
	b	.LBB2_2
.Ltmp409:
.LBB2_7:
	.loc	3 445 3
	adrp	x0, .L.str.2
	ldrb	w2, [x19, #22]
	add	x0, x0, :lo12:.L.str.2
	bl	_printk
.Ltmp410:
	.loc	3 0 3 is_stmt 0
	mov	w0, #-8
	b	.LBB2_2
.Ltmp411:
.Lfunc_end2:
	.size	pvi_wf_input, .Lfunc_end2-pvi_wf_input
	.cfi_endproc
	.section	.rodata,"a",@progbits
.LJTI2_0:
	.byte	(.LBB2_6-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_6-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_5-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_5-.LBB2_5)>>2
	.byte	(.LBB2_5-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_5-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_6-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_5-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_5-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_6-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_7-.LBB2_5)>>2
	.byte	(.LBB2_5-.LBB2_5)>>2

	.text
	.globl	pvi_wf_get_version
	.p2align	2
	.type	pvi_wf_get_version,@function
pvi_wf_get_version:
.Lfunc_begin3:
	.loc	3 462 0 is_stmt 1
	.cfi_startproc
	.loc	3 463 39 prologue_end
	adrp	x8, global_waveform
	ldr	x8, [x8, :lo12:global_waveform]
.Ltmp412:
	.loc	3 466 6
	cbz	x8, .LBB3_2
.Ltmp413:
	.loc	3 469 2
	adrp	x0, pvi_wf_get_version.spi_id_buffer
	ldur	x9, [x8, #73]
	ldr	x10, [x8, #88]
	add	x0, x0, :lo12:pvi_wf_get_version.spi_id_buffer
	ldur	x11, [x8, #81]
	ldur	x8, [x8, #65]
.Ltmp414:
	stur	x10, [x0, #23]
	stp	x9, x11, [x0, #8]
	str	x8, [x0]
	.loc	3 470 20
	strb	wzr, [x0, #31]
	.loc	3 473 1
	ret
.LBB3_2:
.Ltmp415:
	.loc	3 0 1 is_stmt 0
	mov	x0, xzr
	.loc	3 473 1
	ret
.Ltmp416:
.Lfunc_end3:
	.size	pvi_wf_get_version, .Lfunc_end3-pvi_wf_get_version
	.cfi_endproc

	.type	pvi_mode_table,@object
	.section	.rodata,"a",@progbits
	.globl	pvi_mode_table
pvi_mode_table:
	.asciz	"\000\001\001\002\003\003\003\004\003"
	.asciz	"\000\001\007\003\003\005\006\004\005"
	.asciz	"\000\001\001\002\003\004\004\006\005"
	.asciz	"\000\001\007\002\003\004\005\006\004"
	.asciz	"\000\001\005\002\003\003\003\004\003"
	.asciz	"\000\001\001\002\003\004\004\006\004"
	.asciz	"\000\001\001\002\003\004\004\005\004"
	.asciz	"\000\001\001\002\003\004\013\006\n"
	.asciz	"\000\001\001\002\003\004\005\006\004"
	.size	pvi_mode_table, 90

	.type	pvi_wf_get_lut.stype,@object
	.data
	.p2align	2
pvi_wf_get_lut.stype:
	.word	13
	.size	pvi_wf_get_lut.stype, 4

	.type	pvi_wf_get_lut.sftemp,@object
	.p2align	2
pvi_wf_get_lut.sftemp:
	.word	4294967295
	.size	pvi_wf_get_lut.sftemp, 4

	.type	global_waveform,@object
	.local	global_waveform
	.comm	global_waveform,8,8
	.type	need_pic,@object
	.p2align	2
need_pic:
	.word	16
	.size	need_pic, 4

	.type	waveformdata,@object
	.local	waveformdata
	.comm	waveformdata,8,8
	.type	.L.str,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"pvi waveform get frame number failed\n"
	.size	.L.str, 38

	.type	.L.str.1,@object
.L.str.1:
	.asciz	"pvi : input waveform version 0x%x\n"
	.size	.L.str.1, 35

	.type	maxpic,@object
	.local	maxpic
	.comm	maxpic,1,4
	.type	.L.str.2,@object
.L.str.2:
	.asciz	"pvi : Unknow waveform version 0x%x, 0x%x, may be wrong waveform file\n"
	.size	.L.str.2, 70

	.type	pvi_wf_get_version.spi_id_buffer,@object
	.local	pvi_wf_get_version.spi_id_buffer
	.comm	pvi_wf_get_version.spi_id_buffer,32,1
	.type	.L.str.3,@object
.L.str.3:
	.asciz	"pvi: unspport PVI waveform type"
	.size	.L.str.3, 32

	.type	.L.str.4,@object
.L.str.4:
	.asciz	"pvi: %s %d check error\n"
	.size	.L.str.4, 24

	.type	.L__func__.get_wf_frm_num,@object
.L__func__.get_wf_frm_num:
	.asciz	"get_wf_frm_num"
	.size	.L__func__.get_wf_frm_num, 15

	.type	.L.str.5,@object
.L.str.5:
	.asciz	"waveformdata is NULL\n"
	.size	.L.str.5, 22

	.type	.L.str.6,@object
.L.str.6:
	.asciz	"pvi: decodec waveform error, framenum err\n"
	.size	.L.str.6, 43

	.type	.Lswitch.table.pvi_wf_get_lut.7,@object
	.section	.rodata,"a",@progbits
	.p2align	3
.Lswitch.table.pvi_wf_get_lut.7:
	.xword	3
	.xword	5
	.xword	6
	.size	.Lswitch.table.pvi_wf_get_lut.7, 24

	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
	.xword	.Lfunc_begin0-.Lfunc_begin0
	.xword	.Ltmp6-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp6-.Lfunc_begin0
	.xword	.Ltmp22-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	.Ltmp22-.Lfunc_begin0
	.xword	.Ltmp23-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp24-.Lfunc_begin0
	.xword	.Ltmp215-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	.Ltmp216-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	0
	.xword	0
.Ldebug_loc1:
	.xword	.Lfunc_begin0-.Lfunc_begin0
	.xword	.Ltmp5-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp5-.Lfunc_begin0
	.xword	.Ltmp22-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	.Ltmp22-.Lfunc_begin0
	.xword	.Ltmp24-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp24-.Lfunc_begin0
	.xword	.Ltmp193-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	.Ltmp193-.Lfunc_begin0
	.xword	.Ltmp215-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp222-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	0
	.xword	0
.Ldebug_loc2:
	.xword	.Lfunc_begin0-.Lfunc_begin0
	.xword	.Ltmp4-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp4-.Lfunc_begin0
	.xword	.Ltmp22-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp22-.Lfunc_begin0
	.xword	.Ltmp24-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp24-.Lfunc_begin0
	.xword	.Ltmp215-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp216-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc3:
	.xword	.Lfunc_begin0-.Lfunc_begin0
	.xword	.Ltmp46-.Lfunc_begin0
	.hword	1
	.byte	83
	.xword	.Ltmp106-.Lfunc_begin0
	.xword	.Ltmp107-.Lfunc_begin0
	.hword	1
	.byte	83
	.xword	.Ltmp107-.Lfunc_begin0
	.xword	.Ltmp108-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	83
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc4:
	.xword	.Lfunc_begin0-.Lfunc_begin0
	.xword	.Ltmp3-.Lfunc_begin0
	.hword	1
	.byte	84
	.xword	.Ltmp3-.Lfunc_begin0
	.xword	.Ltmp22-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	.Ltmp22-.Lfunc_begin0
	.xword	.Ltmp24-.Lfunc_begin0
	.hword	1
	.byte	84
	.xword	.Ltmp24-.Lfunc_begin0
	.xword	.Ltmp215-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	.Ltmp216-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	0
	.xword	0
.Ldebug_loc5:
	.xword	.Ltmp1-.Lfunc_begin0
	.xword	.Ltmp182-.Lfunc_begin0
	.hword	3
	.byte	48
	.byte	32
	.byte	159
	.xword	.Ltmp182-.Lfunc_begin0
	.xword	.Ltmp211-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp220-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	3
	.byte	48
	.byte	32
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc6:
	.xword	.Ltmp1-.Lfunc_begin0
	.xword	.Ltmp47-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp47-.Lfunc_begin0
	.xword	.Ltmp106-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp106-.Lfunc_begin0
	.xword	.Ltmp108-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp108-.Lfunc_begin0
	.xword	.Ltmp178-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp212-.Lfunc_begin0
	.xword	.Ltmp214-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp216-.Lfunc_begin0
	.xword	.Ltmp217-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc7:
	.xword	.Ltmp1-.Lfunc_begin0
	.xword	.Ltmp46-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp46-.Lfunc_begin0
	.xword	.Ltmp47-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp106-.Lfunc_begin0
	.xword	.Ltmp108-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp211-.Lfunc_begin0
	.xword	.Ltmp212-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc8:
	.xword	.Ltmp1-.Lfunc_begin0
	.xword	.Ltmp28-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp28-.Lfunc_begin0
	.xword	.Ltmp178-.Lfunc_begin0
	.hword	1
	.byte	103
	.xword	.Ltmp193-.Lfunc_begin0
	.xword	.Ltmp215-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp222-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	1
	.byte	103
	.xword	0
	.xword	0
.Ldebug_loc9:
	.xword	.Ltmp14-.Lfunc_begin0
	.xword	.Ltmp22-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp25-.Lfunc_begin0
	.xword	.Ltmp29-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc10:
	.xword	.Ltmp13-.Lfunc_begin0
	.xword	.Ltmp16-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp16-.Lfunc_begin0
	.xword	.Ltmp21-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp25-.Lfunc_begin0
	.xword	.Ltmp26-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp26-.Lfunc_begin0
	.xword	.Ltmp27-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	0
	.xword	0
.Ldebug_loc11:
	.xword	.Ltmp13-.Lfunc_begin0
	.xword	.Ltmp22-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	127
	.byte	159
	.xword	.Ltmp25-.Lfunc_begin0
	.xword	.Ltmp27-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	127
	.byte	159
	.xword	.Ltmp27-.Lfunc_begin0
	.xword	.Ltmp28-.Lfunc_begin0
	.hword	1
	.byte	92
	.xword	.Ltmp28-.Lfunc_begin0
	.xword	.Ltmp29-.Lfunc_begin0
	.hword	1
	.byte	103
	.xword	0
	.xword	0
.Ldebug_loc12:
	.xword	.Ltmp14-.Lfunc_begin0
	.xword	.Ltmp22-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp25-.Lfunc_begin0
	.xword	.Ltmp29-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc13:
	.xword	.Ltmp28-.Lfunc_begin0
	.xword	.Ltmp31-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp31-.Lfunc_begin0
	.xword	.Ltmp32-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	.Ltmp106-.Lfunc_begin0
	.xword	.Ltmp108-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc14:
	.xword	.Ltmp28-.Lfunc_begin0
	.xword	.Ltmp45-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp45-.Lfunc_begin0
	.xword	.Ltmp46-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp106-.Lfunc_begin0
	.xword	.Ltmp108-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc15:
	.xword	.Ltmp28-.Lfunc_begin0
	.xword	.Ltmp46-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	.Ltmp106-.Lfunc_begin0
	.xword	.Ltmp108-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	0
	.xword	0
.Ldebug_loc16:
	.xword	.Ltmp32-.Lfunc_begin0
	.xword	.Ltmp33-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc17:
	.xword	.Ltmp32-.Lfunc_begin0
	.xword	.Ltmp36-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp36-.Lfunc_begin0
	.xword	.Ltmp37-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp37-.Lfunc_begin0
	.xword	.Ltmp38-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc18:
	.xword	.Ltmp51-.Lfunc_begin0
	.xword	.Ltmp54-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp54-.Lfunc_begin0
	.xword	.Ltmp56-.Lfunc_begin0
	.hword	7
	.byte	121
	.byte	0
	.byte	17
	.byte	128
	.byte	8
	.byte	27
	.byte	159
	.xword	.Ltmp58-.Lfunc_begin0
	.xword	.Ltmp60-.Lfunc_begin0
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
	.xword	.Ltmp60-.Lfunc_begin0
	.xword	.Ltmp62-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	1
	.byte	159
	.xword	.Ltmp108-.Lfunc_begin0
	.xword	.Ltmp120-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	1
	.byte	159
	.xword	.Ltmp125-.Lfunc_begin0
	.xword	.Ltmp127-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	1
	.byte	159
	.xword	.Ltmp148-.Lfunc_begin0
	.xword	.Ltmp155-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	1
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc19:
	.xword	.Ltmp51-.Lfunc_begin0
	.xword	.Ltmp54-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp55-.Lfunc_begin0
	.xword	.Ltmp62-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp108-.Lfunc_begin0
	.xword	.Ltmp109-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp121-.Lfunc_begin0
	.xword	.Ltmp124-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp155-.Lfunc_begin0
	.xword	.Ltmp158-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	.Ltmp158-.Lfunc_begin0
	.xword	.Ltmp159-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	128
	.byte	8
	.byte	159
	.xword	.Ltmp159-.Lfunc_begin0
	.xword	.Ltmp160-.Lfunc_begin0
	.hword	4
	.byte	120
	.byte	128
	.byte	16
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc20:
	.xword	.Ltmp51-.Lfunc_begin0
	.xword	.Ltmp62-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp108-.Lfunc_begin0
	.xword	.Ltmp127-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp148-.Lfunc_begin0
	.xword	.Ltmp161-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc21:
	.xword	.Ltmp51-.Lfunc_begin0
	.xword	.Ltmp62-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp108-.Lfunc_begin0
	.xword	.Ltmp127-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp148-.Lfunc_begin0
	.xword	.Ltmp161-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc22:
	.xword	.Ltmp65-.Lfunc_begin0
	.xword	.Ltmp68-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp68-.Lfunc_begin0
	.xword	.Ltmp70-.Lfunc_begin0
	.hword	7
	.byte	122
	.byte	0
	.byte	17
	.byte	128
	.byte	8
	.byte	27
	.byte	159
	.xword	.Ltmp72-.Lfunc_begin0
	.xword	.Ltmp74-.Lfunc_begin0
	.hword	10
	.byte	122
	.byte	0
	.byte	17
	.byte	128
	.byte	8
	.byte	27
	.byte	17
	.byte	1
	.byte	34
	.byte	159
	.xword	.Ltmp74-.Lfunc_begin0
	.xword	.Ltmp77-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	3
	.byte	159
	.xword	.Ltmp128-.Lfunc_begin0
	.xword	.Ltmp139-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	3
	.byte	159
	.xword	.Ltmp144-.Lfunc_begin0
	.xword	.Ltmp147-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	3
	.byte	159
	.xword	.Ltmp161-.Lfunc_begin0
	.xword	.Ltmp168-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	3
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc23:
	.xword	.Ltmp65-.Lfunc_begin0
	.xword	.Ltmp68-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp69-.Lfunc_begin0
	.xword	.Ltmp76-.Lfunc_begin0
	.hword	1
	.byte	92
	.xword	.Ltmp140-.Lfunc_begin0
	.xword	.Ltmp143-.Lfunc_begin0
	.hword	1
	.byte	94
	.xword	.Ltmp168-.Lfunc_begin0
	.xword	.Ltmp171-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	0
	.xword	0
.Ldebug_loc24:
	.xword	.Ltmp65-.Lfunc_begin0
	.xword	.Ltmp77-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp128-.Lfunc_begin0
	.xword	.Ltmp147-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp161-.Lfunc_begin0
	.xword	.Ltmp173-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc25:
	.xword	.Ltmp65-.Lfunc_begin0
	.xword	.Ltmp77-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	.Ltmp128-.Lfunc_begin0
	.xword	.Ltmp146-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	0
	.xword	0
.Ldebug_loc26:
	.xword	.Ltmp83-.Lfunc_begin0
	.xword	.Ltmp91-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Ltmp232-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc27:
	.xword	.Ltmp81-.Lfunc_begin0
	.xword	.Ltmp91-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Ltmp232-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc28:
	.xword	.Ltmp81-.Lfunc_begin0
	.xword	.Ltmp87-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp88-.Lfunc_begin0
	.xword	.Ltmp91-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Ltmp232-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc29:
	.xword	.Ltmp81-.Lfunc_begin0
	.xword	.Ltmp87-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Ltmp232-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc30:
	.xword	.Ltmp96-.Lfunc_begin0
	.xword	.Ltmp106-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp232-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc31:
	.xword	.Ltmp94-.Lfunc_begin0
	.xword	.Ltmp106-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp232-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc32:
	.xword	.Ltmp94-.Lfunc_begin0
	.xword	.Ltmp100-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp101-.Lfunc_begin0
	.xword	.Ltmp106-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp232-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc33:
	.xword	.Ltmp94-.Lfunc_begin0
	.xword	.Ltmp100-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp232-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc34:
	.xword	.Ltmp182-.Lfunc_begin0
	.xword	.Ltmp194-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc35:
	.xword	.Ltmp182-.Lfunc_begin0
	.xword	.Ltmp194-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	0
	.xword	0
.Ldebug_loc36:
	.xword	.Ltmp182-.Lfunc_begin0
	.xword	.Ltmp184-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp184-.Lfunc_begin0
	.xword	.Ltmp189-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	.Ltmp190-.Lfunc_begin0
	.xword	.Ltmp191-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp191-.Lfunc_begin0
	.xword	.Ltmp192-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	0
	.xword	0
.Ldebug_loc37:
	.xword	.Ltmp182-.Lfunc_begin0
	.xword	.Ltmp192-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	127
	.byte	159
	.xword	.Ltmp192-.Lfunc_begin0
	.xword	.Ltmp193-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp193-.Lfunc_begin0
	.xword	.Ltmp194-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	0
	.xword	0
.Ldebug_loc38:
	.xword	.Ltmp193-.Lfunc_begin0
	.xword	.Ltmp196-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp196-.Lfunc_begin0
	.xword	.Ltmp197-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp222-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc39:
	.xword	.Ltmp193-.Lfunc_begin0
	.xword	.Ltmp210-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp210-.Lfunc_begin0
	.xword	.Ltmp211-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp222-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc40:
	.xword	.Ltmp193-.Lfunc_begin0
	.xword	.Ltmp211-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp220-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc41:
	.xword	.Ltmp197-.Lfunc_begin0
	.xword	.Ltmp198-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc42:
	.xword	.Ltmp197-.Lfunc_begin0
	.xword	.Ltmp201-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp201-.Lfunc_begin0
	.xword	.Ltmp202-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp202-.Lfunc_begin0
	.xword	.Ltmp203-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc43:
	.xword	.Lfunc_begin1-.Lfunc_begin0
	.xword	.Ltmp267-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp267-.Lfunc_begin0
	.xword	.Ltmp386-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	80
	.byte	159
	.xword	.Ltmp386-.Lfunc_begin0
	.xword	.Ltmp387-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp387-.Lfunc_begin0
	.xword	.Ltmp389-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	80
	.byte	159
	.xword	.Ltmp389-.Lfunc_begin0
	.xword	.Ltmp390-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp390-.Lfunc_begin0
	.xword	.Ltmp394-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	80
	.byte	159
	.xword	.Ltmp394-.Lfunc_begin0
	.xword	.Ltmp395-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp395-.Lfunc_begin0
	.xword	.Lfunc_end1-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	80
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc44:
	.xword	.Lfunc_begin1-.Lfunc_begin0
	.xword	.Ltmp273-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp282-.Lfunc_begin0
	.xword	.Ltmp289-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp298-.Lfunc_begin0
	.xword	.Ltmp306-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp386-.Lfunc_begin0
	.xword	.Ltmp388-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp388-.Lfunc_begin0
	.xword	.Ltmp389-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp389-.Lfunc_begin0
	.xword	.Ltmp391-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp391-.Lfunc_begin0
	.xword	.Ltmp394-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp394-.Lfunc_begin0
	.xword	.Ltmp396-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp396-.Lfunc_begin0
	.xword	.Ltmp397-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc45:
	.xword	.Ltmp251-.Lfunc_begin0
	.xword	.Ltmp252-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp252-.Lfunc_begin0
	.xword	.Ltmp270-.Lfunc_begin0
	.hword	1
	.byte	94
	.xword	.Ltmp386-.Lfunc_begin0
	.xword	.Ltmp393-.Lfunc_begin0
	.hword	1
	.byte	94
	.xword	.Ltmp394-.Lfunc_begin0
	.xword	.Ltmp396-.Lfunc_begin0
	.hword	1
	.byte	94
	.xword	0
	.xword	0
.Ldebug_loc46:
	.xword	.Ltmp252-.Lfunc_begin0
	.xword	.Ltmp253-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp253-.Lfunc_begin0
	.xword	.Ltmp254-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp259-.Lfunc_begin0
	.xword	.Ltmp260-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp269-.Lfunc_begin0
	.xword	.Ltmp271-.Lfunc_begin0
	.hword	1
	.byte	95
	.xword	0
	.xword	0
.Ldebug_loc47:
	.xword	.Ltmp252-.Lfunc_begin0
	.xword	.Ltmp255-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp255-.Lfunc_begin0
	.xword	.Ltmp258-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp261-.Lfunc_begin0
	.xword	.Ltmp263-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp270-.Lfunc_begin0
	.xword	.Ltmp326-.Lfunc_begin0
	.hword	1
	.byte	94
	.xword	.Ltmp386-.Lfunc_begin0
	.xword	.Ltmp393-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc48:
	.xword	.Ltmp274-.Lfunc_begin0
	.xword	.Ltmp326-.Lfunc_begin0
	.hword	1
	.byte	94
	.xword	0
	.xword	0
.Ldebug_loc49:
	.xword	.Ltmp263-.Lfunc_begin0
	.xword	.Ltmp273-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp275-.Lfunc_begin0
	.xword	.Ltmp281-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp281-.Lfunc_begin0
	.xword	.Ltmp283-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp284-.Lfunc_begin0
	.xword	.Ltmp285-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp285-.Lfunc_begin0
	.xword	.Ltmp286-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp287-.Lfunc_begin0
	.xword	.Ltmp288-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp288-.Lfunc_begin0
	.xword	.Ltmp293-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp293-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp297-.Lfunc_begin0
	.xword	.Ltmp299-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp300-.Lfunc_begin0
	.xword	.Ltmp301-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp301-.Lfunc_begin0
	.xword	.Ltmp302-.Lfunc_begin0
	.hword	1
	.byte	85
	.xword	.Ltmp304-.Lfunc_begin0
	.xword	.Ltmp306-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp306-.Lfunc_begin0
	.xword	.Ltmp309-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp310-.Lfunc_begin0
	.xword	.Ltmp316-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp316-.Lfunc_begin0
	.xword	.Ltmp317-.Lfunc_begin0
	.hword	1
	.byte	85
	.xword	.Ltmp317-.Lfunc_begin0
	.xword	.Ltmp318-.Lfunc_begin0
	.hword	1
	.byte	103
	.xword	.Ltmp318-.Lfunc_begin0
	.xword	.Ltmp319-.Lfunc_begin0
	.hword	1
	.byte	104
	.xword	.Ltmp320-.Lfunc_begin0
	.xword	.Ltmp321-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp321-.Lfunc_begin0
	.xword	.Ltmp325-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp325-.Lfunc_begin0
	.xword	.Ltmp326-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp332-.Lfunc_begin0
	.xword	.Ltmp333-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp333-.Lfunc_begin0
	.xword	.Ltmp368-.Lfunc_begin0
	.hword	10
	.byte	122
	.byte	0
	.byte	17
	.byte	128
	.byte	8
	.byte	27
	.byte	17
	.byte	2
	.byte	30
	.byte	159
	.xword	.Ltmp368-.Lfunc_begin0
	.xword	.Ltmp372-.Lfunc_begin0
	.hword	13
	.byte	122
	.byte	0
	.byte	17
	.byte	128
	.byte	8
	.byte	27
	.byte	17
	.byte	2
	.byte	30
	.byte	17
	.byte	2
	.byte	34
	.byte	159
	.xword	.Ltmp394-.Lfunc_begin0
	.xword	.Ltmp396-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc50:
	.xword	.Ltmp263-.Lfunc_begin0
	.xword	.Ltmp273-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp275-.Lfunc_begin0
	.xword	.Ltmp290-.Lfunc_begin0
	.hword	1
	.byte	92
	.xword	.Ltmp290-.Lfunc_begin0
	.xword	.Ltmp293-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp293-.Lfunc_begin0
	.xword	.Ltmp307-.Lfunc_begin0
	.hword	1
	.byte	92
	.xword	.Ltmp307-.Lfunc_begin0
	.xword	.Ltmp309-.Lfunc_begin0
	.hword	1
	.byte	84
	.xword	.Ltmp310-.Lfunc_begin0
	.xword	.Ltmp322-.Lfunc_begin0
	.hword	1
	.byte	92
	.xword	.Ltmp322-.Lfunc_begin0
	.xword	.Ltmp325-.Lfunc_begin0
	.hword	1
	.byte	85
	.xword	.Ltmp325-.Lfunc_begin0
	.xword	.Ltmp326-.Lfunc_begin0
	.hword	1
	.byte	92
	.xword	.Ltmp333-.Lfunc_begin0
	.xword	.Ltmp337-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp337-.Lfunc_begin0
	.xword	.Ltmp339-.Lfunc_begin0
	.hword	2
	.byte	50
	.byte	159
	.xword	.Ltmp339-.Lfunc_begin0
	.xword	.Ltmp341-.Lfunc_begin0
	.hword	2
	.byte	52
	.byte	159
	.xword	.Ltmp341-.Lfunc_begin0
	.xword	.Ltmp343-.Lfunc_begin0
	.hword	2
	.byte	54
	.byte	159
	.xword	.Ltmp343-.Lfunc_begin0
	.xword	.Ltmp345-.Lfunc_begin0
	.hword	2
	.byte	56
	.byte	159
	.xword	.Ltmp345-.Lfunc_begin0
	.xword	.Ltmp347-.Lfunc_begin0
	.hword	2
	.byte	58
	.byte	159
	.xword	.Ltmp347-.Lfunc_begin0
	.xword	.Ltmp349-.Lfunc_begin0
	.hword	2
	.byte	60
	.byte	159
	.xword	.Ltmp349-.Lfunc_begin0
	.xword	.Ltmp351-.Lfunc_begin0
	.hword	2
	.byte	62
	.byte	159
	.xword	.Ltmp351-.Lfunc_begin0
	.xword	.Ltmp353-.Lfunc_begin0
	.hword	2
	.byte	64
	.byte	159
	.xword	.Ltmp353-.Lfunc_begin0
	.xword	.Ltmp355-.Lfunc_begin0
	.hword	2
	.byte	66
	.byte	159
	.xword	.Ltmp355-.Lfunc_begin0
	.xword	.Ltmp357-.Lfunc_begin0
	.hword	2
	.byte	68
	.byte	159
	.xword	.Ltmp357-.Lfunc_begin0
	.xword	.Ltmp359-.Lfunc_begin0
	.hword	2
	.byte	70
	.byte	159
	.xword	.Ltmp359-.Lfunc_begin0
	.xword	.Ltmp361-.Lfunc_begin0
	.hword	2
	.byte	72
	.byte	159
	.xword	.Ltmp361-.Lfunc_begin0
	.xword	.Ltmp363-.Lfunc_begin0
	.hword	2
	.byte	74
	.byte	159
	.xword	.Ltmp363-.Lfunc_begin0
	.xword	.Ltmp365-.Lfunc_begin0
	.hword	2
	.byte	76
	.byte	159
	.xword	.Ltmp365-.Lfunc_begin0
	.xword	.Ltmp368-.Lfunc_begin0
	.hword	2
	.byte	78
	.byte	159
	.xword	.Ltmp368-.Lfunc_begin0
	.xword	.Ltmp373-.Lfunc_begin0
	.hword	3
	.byte	16
	.byte	32
	.byte	159
	.xword	.Ltmp394-.Lfunc_begin0
	.xword	.Ltmp396-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc51:
	.xword	.Ltmp263-.Lfunc_begin0
	.xword	.Ltmp273-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp275-.Lfunc_begin0
	.xword	.Ltmp292-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp293-.Lfunc_begin0
	.xword	.Ltmp309-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp310-.Lfunc_begin0
	.xword	.Ltmp324-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp325-.Lfunc_begin0
	.xword	.Ltmp386-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp394-.Lfunc_begin0
	.xword	.Ltmp396-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc52:
	.xword	.Ltmp263-.Lfunc_begin0
	.xword	.Ltmp273-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp275-.Lfunc_begin0
	.xword	.Ltmp288-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp293-.Lfunc_begin0
	.xword	.Ltmp305-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp310-.Lfunc_begin0
	.xword	.Ltmp326-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp394-.Lfunc_begin0
	.xword	.Ltmp396-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc53:
	.xword	.Ltmp263-.Lfunc_begin0
	.xword	.Ltmp273-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp280-.Lfunc_begin0
	.xword	.Ltmp293-.Lfunc_begin0
	.hword	1
	.byte	83
	.xword	.Ltmp296-.Lfunc_begin0
	.xword	.Ltmp303-.Lfunc_begin0
	.hword	1
	.byte	83
	.xword	.Ltmp334-.Lfunc_begin0
	.xword	.Ltmp373-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp394-.Lfunc_begin0
	.xword	.Ltmp396-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc54:
	.xword	.Ltmp263-.Lfunc_begin0
	.xword	.Ltmp273-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp312-.Lfunc_begin0
	.xword	.Ltmp325-.Lfunc_begin0
	.hword	1
	.byte	84
	.xword	.Ltmp329-.Lfunc_begin0
	.xword	.Ltmp331-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp331-.Lfunc_begin0
	.xword	.Ltmp373-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp375-.Lfunc_begin0
	.xword	.Ltmp383-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp394-.Lfunc_begin0
	.xword	.Ltmp396-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc55:
	.xword	.Ltmp263-.Lfunc_begin0
	.xword	.Ltmp272-.Lfunc_begin0
	.hword	2
	.byte	49
	.byte	159
	.xword	.Ltmp293-.Lfunc_begin0
	.xword	.Ltmp294-.Lfunc_begin0
	.hword	9
	.byte	112
	.byte	0
	.byte	48
	.byte	32
	.byte	39
	.byte	16
	.byte	1
	.byte	26
	.byte	159
	.xword	.Ltmp394-.Lfunc_begin0
	.xword	.Ltmp396-.Lfunc_begin0
	.hword	2
	.byte	49
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc56:
	.xword	.Ltmp263-.Lfunc_begin0
	.xword	.Ltmp272-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp272-.Lfunc_begin0
	.xword	.Ltmp273-.Lfunc_begin0
	.hword	1
	.byte	95
	.xword	.Ltmp274-.Lfunc_begin0
	.xword	.Ltmp326-.Lfunc_begin0
	.hword	1
	.byte	95
	.xword	.Ltmp394-.Lfunc_begin0
	.xword	.Ltmp396-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc57:
	.xword	.Lfunc_begin2-.Lfunc_begin0
	.xword	.Ltmp402-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp403-.Lfunc_begin0
	.xword	.Ltmp404-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp404-.Lfunc_begin0
	.xword	.Lfunc_end2-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc58:
	.xword	.Ltmp399-.Lfunc_begin0
	.xword	.Ltmp400-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp400-.Lfunc_begin0
	.xword	.Lfunc_end2-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc59:
	.xword	.Lfunc_begin3-.Lfunc_begin0
	.xword	.Ltmp412-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp412-.Lfunc_begin0
	.xword	.Ltmp414-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp415-.Lfunc_begin0
	.xword	.Lfunc_end3-.Lfunc_begin0
	.hword	1
	.byte	88
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
	.byte	52
	.byte	0
	.byte	3
	.byte	14
	.byte	73
	.byte	19
	.byte	63
	.byte	25
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	2
	.byte	24
	.byte	0
	.byte	0
	.byte	3
	.byte	1
	.byte	1
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	4
	.byte	33
	.byte	0
	.byte	73
	.byte	19
	.byte	55
	.byte	11
	.byte	0
	.byte	0
	.byte	5
	.byte	38
	.byte	0
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	6
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
	.byte	7
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
	.byte	8
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
	.byte	9
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
	.byte	10
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
	.byte	11
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
	.byte	12
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
	.byte	13
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
	.byte	14
	.byte	5
	.byte	0
	.byte	2
	.byte	23
	.byte	49
	.byte	19
	.byte	0
	.byte	0
	.byte	15
	.byte	52
	.byte	0
	.byte	2
	.byte	23
	.byte	49
	.byte	19
	.byte	0
	.byte	0
	.byte	16
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
	.byte	17
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
	.byte	18
	.ascii	"\211\202\001"
	.byte	1
	.byte	49
	.byte	19
	.byte	17
	.byte	1
	.byte	0
	.byte	0
	.byte	19
	.ascii	"\212\202\001"
	.byte	0
	.byte	2
	.byte	24
	.ascii	"\221B"
	.byte	24
	.byte	0
	.byte	0
	.byte	20
	.ascii	"\211\202\001"
	.byte	0
	.byte	49
	.byte	19
	.byte	17
	.byte	1
	.byte	0
	.byte	0
	.byte	21
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
	.byte	22
	.byte	40
	.byte	0
	.byte	3
	.byte	14
	.byte	28
	.byte	15
	.byte	0
	.byte	0
	.byte	23
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
	.byte	24
	.byte	15
	.byte	0
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	25
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
	.byte	26
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
	.byte	27
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
	.byte	28
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
	.byte	29
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
	.byte	30
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
	.byte	31
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
	.byte	32
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
	.byte	33
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
	.byte	34
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
	.byte	0
	.byte	0
	.byte	35
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
	.byte	36
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
	.byte	37
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
	.byte	38
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
	.byte	39
	.byte	15
	.byte	0
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
	.word	.Lfunc_end3-.Lfunc_begin0
	.byte	2
	.word	.Linfo_string3
	.word	63

	.byte	3
	.byte	153
	.byte	9
	.byte	3
	.xword	pvi_mode_table
	.byte	3
	.word	81
	.byte	4
	.word	115
	.byte	9
	.byte	4
	.word	115
	.byte	10
	.byte	0
	.byte	5
	.word	86
	.byte	6
	.word	97
	.word	.Linfo_string6
	.byte	2
	.byte	17
	.byte	6
	.word	108
	.word	.Linfo_string5
	.byte	1
	.byte	21
	.byte	7
	.word	.Linfo_string4
	.byte	8
	.byte	1
	.byte	8
	.word	.Linfo_string7
	.byte	8
	.byte	7
	.byte	9
	.xword	.Lfunc_begin0
	.word	.Lfunc_end0-.Lfunc_begin0
	.byte	1
	.byte	109

	.word	.Linfo_string95
	.byte	3
	.hword	347

	.word	968

	.byte	10
	.word	.Linfo_string8
	.word	858
	.byte	3
	.hword	349
	.byte	9
	.byte	3
	.xword	pvi_wf_get_lut.stype
	.byte	10
	.word	.Linfo_string26
	.word	968
	.byte	3
	.hword	350
	.byte	9
	.byte	3
	.xword	pvi_wf_get_lut.sftemp
	.byte	11
	.word	.Ldebug_loc0
	.word	.Linfo_string99
	.byte	3
	.hword	347
	.word	2366
	.byte	11
	.word	.Ldebug_loc1
	.word	.Linfo_string70
	.byte	3
	.hword	347
	.word	858
	.byte	11
	.word	.Ldebug_loc2
	.word	.Linfo_string59
	.byte	3
	.hword	347
	.word	968
	.byte	11
	.word	.Ldebug_loc3
	.word	.Linfo_string101
	.byte	3
	.hword	347
	.word	968
	.byte	11
	.word	.Ldebug_loc4
	.word	.Linfo_string102
	.byte	3
	.hword	347
	.word	968
	.byte	12
	.word	.Ldebug_loc5
	.word	.Linfo_string103
	.byte	3
	.hword	354
	.word	858
	.byte	12
	.word	.Ldebug_loc6
	.word	.Linfo_string77
	.byte	3
	.hword	353
	.word	968
	.byte	12
	.word	.Ldebug_loc7
	.word	.Linfo_string104
	.byte	3
	.hword	352
	.word	968
	.byte	12
	.word	.Ldebug_loc8
	.word	.Linfo_string105
	.byte	3
	.hword	351
	.word	968
	.byte	13
	.word	1585
	.word	.Ldebug_ranges0
	.byte	3
	.hword	372
	.byte	16
	.byte	14
	.word	.Ldebug_loc12
	.word	1597
	.byte	15
	.word	.Ldebug_loc9
	.word	1608
	.byte	15
	.word	.Ldebug_loc10
	.word	1619
	.byte	15
	.word	.Ldebug_loc11
	.word	1630
	.byte	0
	.byte	13
	.word	1642
	.word	.Ldebug_ranges1
	.byte	3
	.hword	373
	.byte	16
	.byte	14
	.word	.Ldebug_loc15
	.word	1654
	.byte	15
	.word	.Ldebug_loc13
	.word	1665
	.byte	15
	.word	.Ldebug_loc14
	.word	1676
	.byte	16
	.word	1693
	.xword	.Ltmp32
	.word	.Ltmp38-.Ltmp32
	.byte	3
	.byte	200
	.byte	14
	.byte	14
	.word	.Ldebug_loc16
	.word	1705
	.byte	15
	.word	.Ldebug_loc17
	.word	1716
	.byte	0
	.byte	0
	.byte	13
	.word	1728
	.word	.Ldebug_ranges2
	.byte	3
	.hword	381
	.byte	4
	.byte	14
	.word	.Ldebug_loc21
	.word	1740
	.byte	14
	.word	.Ldebug_loc20
	.word	1751
	.byte	15
	.word	.Ldebug_loc18
	.word	1762
	.byte	15
	.word	.Ldebug_loc19
	.word	1773
	.byte	0
	.byte	13
	.word	1785
	.word	.Ldebug_ranges3
	.byte	3
	.hword	383
	.byte	4
	.byte	14
	.word	.Ldebug_loc25
	.word	1798
	.byte	14
	.word	.Ldebug_loc24
	.word	1810
	.byte	15
	.word	.Ldebug_loc22
	.word	1822
	.byte	15
	.word	.Ldebug_loc23
	.word	1834
	.byte	0
	.byte	13
	.word	1847
	.word	.Ldebug_ranges4
	.byte	3
	.hword	385
	.byte	4
	.byte	14
	.word	.Ldebug_loc26
	.word	1860
	.byte	14
	.word	.Ldebug_loc27
	.word	1872
	.byte	15
	.word	.Ldebug_loc28
	.word	1884
	.byte	15
	.word	.Ldebug_loc29
	.word	1896
	.byte	0
	.byte	13
	.word	1909
	.word	.Ldebug_ranges5
	.byte	3
	.hword	387
	.byte	4
	.byte	14
	.word	.Ldebug_loc30
	.word	1922
	.byte	14
	.word	.Ldebug_loc31
	.word	1934
	.byte	15
	.word	.Ldebug_loc32
	.word	1946
	.byte	15
	.word	.Ldebug_loc33
	.word	1958
	.byte	0
	.byte	17
	.word	1585
	.xword	.Ltmp181
	.word	.Ltmp193-.Ltmp181
	.byte	3
	.hword	398
	.byte	16
	.byte	14
	.word	.Ldebug_loc34
	.word	1597
	.byte	15
	.word	.Ldebug_loc35
	.word	1608
	.byte	15
	.word	.Ldebug_loc36
	.word	1619
	.byte	15
	.word	.Ldebug_loc37
	.word	1630
	.byte	0
	.byte	13
	.word	1642
	.word	.Ldebug_ranges6
	.byte	3
	.hword	399
	.byte	16
	.byte	14
	.word	.Ldebug_loc40
	.word	1654
	.byte	15
	.word	.Ldebug_loc38
	.word	1665
	.byte	15
	.word	.Ldebug_loc39
	.word	1676
	.byte	16
	.word	1693
	.xword	.Ltmp197
	.word	.Ltmp203-.Ltmp197
	.byte	3
	.byte	200
	.byte	14
	.byte	14
	.word	.Ldebug_loc41
	.word	1705
	.byte	15
	.word	.Ldebug_loc42
	.word	1716
	.byte	0
	.byte	0
	.byte	18
	.word	1971
	.xword	.Ltmp47
	.byte	19
	.byte	1
	.byte	81
	.byte	2
	.byte	135
	.byte	0
	.byte	0
	.byte	20
	.word	2166
	.xword	.Ltmp181
	.byte	18
	.word	1971
	.xword	.Ltmp212
	.byte	19
	.byte	1
	.byte	81
	.byte	2
	.byte	133
	.byte	0
	.byte	0
	.byte	0
	.byte	21
	.word	961
	.word	.Linfo_string25
	.byte	4
	.byte	4
	.byte	15
	.byte	22
	.word	.Linfo_string10
	.byte	0
	.byte	22
	.word	.Linfo_string11
	.byte	1
	.byte	22
	.word	.Linfo_string12
	.byte	2
	.byte	22
	.word	.Linfo_string13
	.byte	3
	.byte	22
	.word	.Linfo_string14
	.byte	4
	.byte	22
	.word	.Linfo_string15
	.byte	5
	.byte	22
	.word	.Linfo_string16
	.byte	6
	.byte	22
	.word	.Linfo_string17
	.byte	7
	.byte	22
	.word	.Linfo_string18
	.byte	8
	.byte	22
	.word	.Linfo_string19
	.byte	9
	.byte	22
	.word	.Linfo_string20
	.byte	10
	.byte	22
	.word	.Linfo_string21
	.byte	11
	.byte	22
	.word	.Linfo_string22
	.byte	12
	.byte	22
	.word	.Linfo_string23
	.byte	13
	.byte	22
	.word	.Linfo_string24
	.byte	14
	.byte	0
	.byte	7
	.word	.Linfo_string9
	.byte	7
	.byte	4
	.byte	7
	.word	.Linfo_string27
	.byte	5
	.byte	4
	.byte	9
	.xword	.Lfunc_begin3
	.word	.Lfunc_end3-.Lfunc_begin3
	.byte	1
	.byte	111

	.word	.Linfo_string98
	.byte	3
	.hword	461

	.word	1565

	.byte	10
	.word	.Linfo_string28
	.word	1040
	.byte	3
	.hword	464
	.byte	9
	.byte	3
	.xword	pvi_wf_get_version.spi_id_buffer
	.byte	12
	.word	.Ldebug_loc59
	.word	.Linfo_string74
	.byte	3
	.hword	463
	.word	1565
	.byte	0
	.byte	3
	.word	1052
	.byte	4
	.word	115
	.byte	32
	.byte	0
	.byte	7
	.word	.Linfo_string29
	.byte	8
	.byte	1
	.byte	23
	.word	.Linfo_string30
	.word	1080
	.byte	3
	.byte	40
	.byte	9
	.byte	3
	.xword	waveformdata
	.byte	24
	.word	86
	.byte	23
	.word	.Linfo_string31
	.word	1106
	.byte	3
	.byte	42
	.byte	9
	.byte	3
	.xword	global_waveform
	.byte	24
	.word	1111
	.byte	25
	.word	.Linfo_string60
	.byte	52
	.byte	3
	.byte	13
	.byte	26
	.word	.Linfo_string32
	.word	1396
	.byte	3
	.byte	14
	.byte	0
	.byte	26
	.word	.Linfo_string35
	.word	1396
	.byte	3
	.byte	15
	.byte	4
	.byte	26
	.word	.Linfo_string36
	.word	1396
	.byte	3
	.byte	16
	.byte	8
	.byte	26
	.word	.Linfo_string37
	.word	86
	.byte	3
	.byte	17
	.byte	12
	.byte	26
	.word	.Linfo_string38
	.word	86
	.byte	3
	.byte	18
	.byte	13
	.byte	26
	.word	.Linfo_string39
	.word	1418
	.byte	3
	.byte	19
	.byte	14
	.byte	26
	.word	.Linfo_string43
	.word	86
	.byte	3
	.byte	20
	.byte	16
	.byte	26
	.word	.Linfo_string44
	.word	86
	.byte	3
	.byte	21
	.byte	17
	.byte	26
	.word	.Linfo_string45
	.word	86
	.byte	3
	.byte	22
	.byte	18
	.byte	26
	.word	.Linfo_string46
	.word	86
	.byte	3
	.byte	23
	.byte	19
	.byte	26
	.word	.Linfo_string47
	.word	86
	.byte	3
	.byte	24
	.byte	20
	.byte	26
	.word	.Linfo_string48
	.word	86
	.byte	3
	.byte	25
	.byte	21
	.byte	26
	.word	.Linfo_string49
	.word	86
	.byte	3
	.byte	26
	.byte	22
	.byte	26
	.word	.Linfo_string50
	.word	86
	.byte	3
	.byte	27
	.byte	23
	.byte	26
	.word	.Linfo_string51
	.word	1396
	.byte	3
	.byte	28
	.byte	24
	.byte	26
	.word	.Linfo_string52
	.word	86
	.byte	3
	.byte	29
	.byte	28
	.byte	26
	.word	.Linfo_string53
	.word	1447
	.byte	3
	.byte	30
	.byte	29
	.byte	26
	.word	.Linfo_string54
	.word	86
	.byte	3
	.byte	31
	.byte	32
	.byte	26
	.word	.Linfo_string55
	.word	1459
	.byte	3
	.byte	32
	.byte	33
	.byte	26
	.word	.Linfo_string56
	.word	86
	.byte	3
	.byte	33
	.byte	37
	.byte	26
	.word	.Linfo_string57
	.word	86
	.byte	3
	.byte	34
	.byte	38
	.byte	26
	.word	.Linfo_string58
	.word	1471
	.byte	3
	.byte	35
	.byte	39
	.byte	26
	.word	.Linfo_string59
	.word	1483
	.byte	3
	.byte	36
	.byte	48
	.byte	0
	.byte	6
	.word	1407
	.word	.Linfo_string34
	.byte	2
	.byte	21
	.byte	6
	.word	961
	.word	.Linfo_string33
	.byte	1
	.byte	27
	.byte	6
	.word	1429
	.word	.Linfo_string42
	.byte	2
	.byte	19
	.byte	6
	.word	1440
	.word	.Linfo_string41
	.byte	1
	.byte	24
	.byte	7
	.word	.Linfo_string40
	.byte	7
	.byte	2
	.byte	3
	.word	86
	.byte	4
	.word	115
	.byte	3
	.byte	0
	.byte	3
	.word	86
	.byte	4
	.word	115
	.byte	4
	.byte	0
	.byte	3
	.word	86
	.byte	4
	.word	115
	.byte	9
	.byte	0
	.byte	3
	.word	86
	.byte	4
	.word	115
	.byte	1
	.byte	0
	.byte	23
	.word	.Linfo_string61
	.word	968
	.byte	3
	.byte	43
	.byte	9
	.byte	3
	.xword	need_pic
	.byte	23
	.word	.Linfo_string62
	.word	968
	.byte	3
	.byte	41
	.byte	16
	.byte	3
	.xword	maxpic
	.byte	148
	.byte	1
	.byte	64
	.byte	30
	.byte	64
	.byte	34
	.byte	159
	.byte	27
	.word	961
	.byte	4
	.byte	5
	.byte	10
	.byte	22
	.word	.Linfo_string63
	.byte	0
	.byte	22
	.word	.Linfo_string64
	.byte	1
	.byte	0
	.byte	24
	.word	1570
	.byte	5
	.word	1052
	.byte	24
	.word	108
	.byte	24
	.word	968
	.byte	28
	.word	.Linfo_string65
	.byte	3
	.byte	205

	.word	968
	.byte	1
	.byte	29
	.word	.Linfo_string59
	.byte	3
	.byte	205
	.word	968
	.byte	30
	.word	.Linfo_string66
	.byte	3
	.byte	207
	.word	968
	.byte	30
	.word	.Linfo_string67
	.byte	3
	.byte	209
	.word	968
	.byte	30
	.word	.Linfo_string68
	.byte	3
	.byte	208
	.word	968
	.byte	0
	.byte	28
	.word	.Linfo_string69
	.byte	3
	.byte	183

	.word	86
	.byte	1
	.byte	29
	.word	.Linfo_string70
	.byte	3
	.byte	183
	.word	858
	.byte	30
	.word	.Linfo_string71
	.byte	3
	.byte	186
	.word	968
	.byte	30
	.word	.Linfo_string72
	.byte	3
	.byte	185
	.word	1688
	.byte	0
	.byte	24
	.word	81
	.byte	28
	.word	.Linfo_string73
	.byte	3
	.byte	165

	.word	1688
	.byte	1
	.byte	29
	.word	.Linfo_string74
	.byte	3
	.byte	165
	.word	1106
	.byte	30
	.word	.Linfo_string72
	.byte	3
	.byte	167
	.word	1688
	.byte	0
	.byte	28
	.word	.Linfo_string75
	.byte	3
	.byte	248

	.word	968
	.byte	1
	.byte	29
	.word	.Linfo_string76
	.byte	3
	.byte	248
	.word	1080
	.byte	29
	.word	.Linfo_string77
	.byte	3
	.byte	248
	.word	968
	.byte	30
	.word	.Linfo_string78
	.byte	3
	.byte	250
	.word	968
	.byte	30
	.word	.Linfo_string79
	.byte	3
	.byte	251
	.word	1080
	.byte	0
	.byte	31
	.word	.Linfo_string80
	.byte	3
	.hword	282

	.word	968
	.byte	1
	.byte	32
	.word	.Linfo_string76
	.byte	3
	.hword	282
	.word	1080
	.byte	32
	.word	.Linfo_string77
	.byte	3
	.hword	282
	.word	968
	.byte	33
	.word	.Linfo_string78
	.byte	3
	.hword	284
	.word	968
	.byte	33
	.word	.Linfo_string79
	.byte	3
	.hword	285
	.word	1080
	.byte	0
	.byte	31
	.word	.Linfo_string81
	.byte	3
	.hword	316

	.word	968
	.byte	1
	.byte	32
	.word	.Linfo_string76
	.byte	3
	.hword	316
	.word	1080
	.byte	32
	.word	.Linfo_string77
	.byte	3
	.hword	316
	.word	968
	.byte	33
	.word	.Linfo_string79
	.byte	3
	.hword	319
	.word	1080
	.byte	33
	.word	.Linfo_string78
	.byte	3
	.hword	318
	.word	968
	.byte	0
	.byte	31
	.word	.Linfo_string82
	.byte	3
	.hword	329

	.word	968
	.byte	1
	.byte	32
	.word	.Linfo_string76
	.byte	3
	.hword	329
	.word	1080
	.byte	32
	.word	.Linfo_string77
	.byte	3
	.hword	329
	.word	968
	.byte	33
	.word	.Linfo_string79
	.byte	3
	.hword	332
	.word	1080
	.byte	33
	.word	.Linfo_string78
	.byte	3
	.hword	331
	.word	968
	.byte	0
	.byte	34
	.xword	.Lfunc_begin1
	.word	.Lfunc_end1-.Lfunc_begin1
	.byte	1
	.byte	109

	.word	.Linfo_string96
	.byte	3
	.byte	224

	.word	968
	.byte	35
	.word	.Ldebug_loc43
	.word	.Linfo_string71
	.byte	3
	.byte	224
	.word	968
	.byte	35
	.word	.Ldebug_loc44
	.word	.Linfo_string105
	.byte	3
	.byte	224
	.word	968
	.byte	36
	.word	.Ldebug_loc45
	.word	.Linfo_string74
	.byte	3
	.byte	226
	.word	1575
	.byte	36
	.word	.Ldebug_loc46
	.word	.Linfo_string89
	.byte	3
	.byte	228
	.word	968
	.byte	36
	.word	.Ldebug_loc47
	.word	.Linfo_string106
	.byte	3
	.byte	227
	.word	1575
	.byte	37
	.word	2177
	.word	.Ldebug_ranges7
	.byte	3
	.byte	245
	.byte	9
	.byte	14
	.word	.Ldebug_loc48
	.word	2189
	.byte	15
	.word	.Ldebug_loc49
	.word	2200
	.byte	15
	.word	.Ldebug_loc50
	.word	2211
	.byte	15
	.word	.Ldebug_loc51
	.word	2222
	.byte	15
	.word	.Ldebug_loc52
	.word	2233
	.byte	15
	.word	.Ldebug_loc53
	.word	2244
	.byte	15
	.word	.Ldebug_loc54
	.word	2255
	.byte	15
	.word	.Ldebug_loc55
	.word	2266
	.byte	15
	.word	.Ldebug_loc56
	.word	2277
	.byte	0
	.byte	0
	.byte	38
	.word	.Linfo_string83
	.byte	4
	.byte	49

	.word	968


	.byte	28
	.word	.Linfo_string84
	.byte	3
	.byte	45

	.word	968
	.byte	1
	.byte	29
	.word	.Linfo_string85
	.byte	3
	.byte	45
	.word	1575
	.byte	30
	.word	.Linfo_string86
	.byte	3
	.byte	47
	.word	961
	.byte	30
	.word	.Linfo_string87
	.byte	3
	.byte	47
	.word	961
	.byte	30
	.word	.Linfo_string88
	.byte	3
	.byte	48
	.word	961
	.byte	30
	.word	.Linfo_string89
	.byte	3
	.byte	49
	.word	961
	.byte	30
	.word	.Linfo_string90
	.byte	3
	.byte	50
	.word	108
	.byte	30
	.word	.Linfo_string67
	.byte	3
	.byte	51
	.word	108
	.byte	30
	.word	.Linfo_string91
	.byte	3
	.byte	52
	.word	2289
	.byte	30
	.word	.Linfo_string94
	.byte	3
	.byte	53
	.word	968
	.byte	0
	.byte	6
	.word	2300
	.word	.Linfo_string93
	.byte	6
	.byte	30
	.byte	7
	.word	.Linfo_string92
	.byte	2
	.byte	1
	.byte	9
	.xword	.Lfunc_begin2
	.word	.Lfunc_end2-.Lfunc_begin2
	.byte	1
	.byte	109

	.word	.Linfo_string97
	.byte	3
	.hword	419

	.word	968

	.byte	11
	.word	.Ldebug_loc57
	.word	.Linfo_string107
	.byte	3
	.hword	419
	.word	2433
	.byte	12
	.word	.Ldebug_loc58
	.word	.Linfo_string108
	.byte	3
	.hword	421
	.word	1106
	.byte	0
	.byte	24
	.word	2371
	.byte	25
	.word	.Linfo_string100
	.byte	32
	.byte	4
	.byte	34
	.byte	26
	.word	.Linfo_string77
	.word	961
	.byte	4
	.byte	35
	.byte	0
	.byte	26
	.word	.Linfo_string85
	.word	2416
	.byte	4
	.byte	36
	.byte	8
	.byte	26
	.word	.Linfo_string76
	.word	2421
	.byte	4
	.byte	37
	.byte	16
	.byte	0
	.byte	24
	.word	961
	.byte	3
	.word	1080
	.byte	4
	.word	115
	.byte	2
	.byte	0
	.byte	39
	.byte	0
.Ldebug_info_end0:
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.xword	.Ltmp12-.Lfunc_begin0
	.xword	.Ltmp13-.Lfunc_begin0
	.xword	.Ltmp14-.Lfunc_begin0
	.xword	.Ltmp28-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges1:
	.xword	.Ltmp28-.Lfunc_begin0
	.xword	.Ltmp46-.Lfunc_begin0
	.xword	.Ltmp106-.Lfunc_begin0
	.xword	.Ltmp108-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges2:
	.xword	.Ltmp51-.Lfunc_begin0
	.xword	.Ltmp62-.Lfunc_begin0
	.xword	.Ltmp108-.Lfunc_begin0
	.xword	.Ltmp127-.Lfunc_begin0
	.xword	.Ltmp148-.Lfunc_begin0
	.xword	.Ltmp161-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges3:
	.xword	.Ltmp64-.Lfunc_begin0
	.xword	.Ltmp77-.Lfunc_begin0
	.xword	.Ltmp128-.Lfunc_begin0
	.xword	.Ltmp147-.Lfunc_begin0
	.xword	.Ltmp161-.Lfunc_begin0
	.xword	.Ltmp173-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges4:
	.xword	.Ltmp81-.Lfunc_begin0
	.xword	.Ltmp82-.Lfunc_begin0
	.xword	.Ltmp83-.Lfunc_begin0
	.xword	.Ltmp91-.Lfunc_begin0
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Ltmp232-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges5:
	.xword	.Ltmp94-.Lfunc_begin0
	.xword	.Ltmp95-.Lfunc_begin0
	.xword	.Ltmp96-.Lfunc_begin0
	.xword	.Ltmp106-.Lfunc_begin0
	.xword	.Ltmp232-.Lfunc_begin0
	.xword	.Ltmp250-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges6:
	.xword	.Ltmp193-.Lfunc_begin0
	.xword	.Ltmp211-.Lfunc_begin0
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges7:
	.xword	.Ltmp263-.Lfunc_begin0
	.xword	.Ltmp268-.Lfunc_begin0
	.xword	.Ltmp274-.Lfunc_begin0
	.xword	.Ltmp386-.Lfunc_begin0
	.xword	.Ltmp394-.Lfunc_begin0
	.xword	.Ltmp396-.Lfunc_begin0
	.xword	0
	.xword	0
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"Android (8508608, based on r450784e) clang version 14.0.7 (https://android.googlesource.com/toolchain/llvm-project 4c603efb0cca074e9238af8b4106c30add4418f6)"
.Linfo_string1:
	.asciz	"drivers/gpu/drm/rockchip/ebc-dev/epdlut/pvi_waveform.c"
.Linfo_string2:
	.asciz	"/home/lyx/rk-android14/kernel-6.1"
.Linfo_string3:
	.asciz	"pvi_mode_table"
.Linfo_string4:
	.asciz	"unsigned char"
.Linfo_string5:
	.asciz	"__u8"
.Linfo_string6:
	.asciz	"u8"
.Linfo_string7:
	.asciz	"__ARRAY_SIZE_TYPE__"
.Linfo_string8:
	.asciz	"stype"
.Linfo_string9:
	.asciz	"unsigned int"
.Linfo_string10:
	.asciz	"WF_TYPE_RESET"
.Linfo_string11:
	.asciz	"WF_TYPE_GRAY2"
.Linfo_string12:
	.asciz	"WF_TYPE_GRAY4"
.Linfo_string13:
	.asciz	"WF_TYPE_GC16"
.Linfo_string14:
	.asciz	"WF_TYPE_GL16"
.Linfo_string15:
	.asciz	"WF_TYPE_GLR16"
.Linfo_string16:
	.asciz	"WF_TYPE_GLD16"
.Linfo_string17:
	.asciz	"WF_TYPE_A2"
.Linfo_string18:
	.asciz	"WF_TYPE_GCC16"
.Linfo_string19:
	.asciz	"PVI_WF_MAX"
.Linfo_string20:
	.asciz	"WF_TYPE_AUTO"
.Linfo_string21:
	.asciz	"WF_TYPE_RK_GLR16"
.Linfo_string22:
	.asciz	"WF_TYPE_RK_GLD16"
.Linfo_string23:
	.asciz	"WF_TYPE_MAX"
.Linfo_string24:
	.asciz	"WF_TYPE_GRAY16"
.Linfo_string25:
	.asciz	"epd_lut_type"
.Linfo_string26:
	.asciz	"sftemp"
.Linfo_string27:
	.asciz	"int"
.Linfo_string28:
	.asciz	"spi_id_buffer"
.Linfo_string29:
	.asciz	"char"
.Linfo_string30:
	.asciz	"waveformdata"
.Linfo_string31:
	.asciz	"global_waveform"
.Linfo_string32:
	.asciz	"checksum"
.Linfo_string33:
	.asciz	"__u32"
.Linfo_string34:
	.asciz	"u32"
.Linfo_string35:
	.asciz	"file_length"
.Linfo_string36:
	.asciz	"serial"
.Linfo_string37:
	.asciz	"run_type"
.Linfo_string38:
	.asciz	"fpl_platform"
.Linfo_string39:
	.asciz	"fpl_lot"
.Linfo_string40:
	.asciz	"unsigned short"
.Linfo_string41:
	.asciz	"__u16"
.Linfo_string42:
	.asciz	"u16"
.Linfo_string43:
	.asciz	"mode_version"
.Linfo_string44:
	.asciz	"wf_version"
.Linfo_string45:
	.asciz	"wf_subversion"
.Linfo_string46:
	.asciz	"wf_type"
.Linfo_string47:
	.asciz	"panel_size"
.Linfo_string48:
	.asciz	"amepd_part_number"
.Linfo_string49:
	.asciz	"wfm_rev"
.Linfo_string50:
	.asciz	"frame_rate"
.Linfo_string51:
	.asciz	"reserved"
.Linfo_string52:
	.asciz	"vcom_offset"
.Linfo_string53:
	.asciz	"xwia"
.Linfo_string54:
	.asciz	"sc1"
.Linfo_string55:
	.asciz	"unknown1"
.Linfo_string56:
	.asciz	"modenumber"
.Linfo_string57:
	.asciz	"temperaturenumber"
.Linfo_string58:
	.asciz	"unknown2"
.Linfo_string59:
	.asciz	"temperture"
.Linfo_string60:
	.asciz	"pvi_waveform"
.Linfo_string61:
	.asciz	"need_pic"
.Linfo_string62:
	.asciz	"maxpic"
.Linfo_string63:
	.asciz	"false"
.Linfo_string64:
	.asciz	"true"
.Linfo_string65:
	.asciz	"get_wf_temp_index"
.Linfo_string66:
	.asciz	"temp_num"
.Linfo_string67:
	.asciz	"i"
.Linfo_string68:
	.asciz	"level"
.Linfo_string69:
	.asciz	"get_wf_mode_index"
.Linfo_string70:
	.asciz	"lut_type"
.Linfo_string71:
	.asciz	"mode"
.Linfo_string72:
	.asciz	"pvi_modes"
.Linfo_string73:
	.asciz	"parse_mode_version"
.Linfo_string74:
	.asciz	"waveform"
.Linfo_string75:
	.asciz	"pvi_wf_a2_repair"
.Linfo_string76:
	.asciz	"wf_table"
.Linfo_string77:
	.asciz	"frame_num"
.Linfo_string78:
	.asciz	"f"
.Linfo_string79:
	.asciz	"table"
.Linfo_string80:
	.asciz	"pvi_wf_gray2_repair"
.Linfo_string81:
	.asciz	"pvi_wf_regal_fix"
.Linfo_string82:
	.asciz	"pvi_wf_rpart_fix"
.Linfo_string83:
	.asciz	"epd_overlay_lut"
.Linfo_string84:
	.asciz	"decodewaveform"
.Linfo_string85:
	.asciz	"data"
.Linfo_string86:
	.asciz	"oldpic"
.Linfo_string87:
	.asciz	"newpic"
.Linfo_string88:
	.asciz	"frame_tmp"
.Linfo_string89:
	.asciz	"offset"
.Linfo_string90:
	.asciz	"tempdata"
.Linfo_string91:
	.asciz	"israr"
.Linfo_string92:
	.asciz	"_Bool"
.Linfo_string93:
	.asciz	"bool"
.Linfo_string94:
	.asciz	"shift_n"
.Linfo_string95:
	.asciz	"pvi_wf_get_lut"
.Linfo_string96:
	.asciz	"get_wf_frm_num"
.Linfo_string97:
	.asciz	"pvi_wf_input"
.Linfo_string98:
	.asciz	"pvi_wf_get_version"
.Linfo_string99:
	.asciz	"output"
.Linfo_string100:
	.asciz	"epd_lut_data"
.Linfo_string101:
	.asciz	"pic"
.Linfo_string102:
	.asciz	"regal_pix"
.Linfo_string103:
	.asciz	"overlay_lut"
.Linfo_string104:
	.asciz	"mode_index"
.Linfo_string105:
	.asciz	"temp_index"
.Linfo_string106:
	.asciz	"wf_data"
.Linfo_string107:
	.asciz	"waveform_file"
.Linfo_string108:
	.asciz	"pvi_wf"
	.ident	"Android (8508608, based on r450784e) clang version 14.0.7 (https://android.googlesource.com/toolchain/llvm-project 4c603efb0cca074e9238af8b4106c30add4418f6)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym pvi_wf_get_version.spi_id_buffer
	.section	.debug_line,"",@progbits
.Lline_table_start0:
