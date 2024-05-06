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
	.loc	3 295 0
	.cfi_sections .debug_frame
	.cfi_startproc
	str	x30, [x18], #8
	.cfi_escape 0x16, 0x12, 0x02, 0x82, 0x78
	stp	x29, x30, [sp, #-80]!
	stp	x26, x25, [sp, #16]
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
	.cfi_offset w25, -56
	.cfi_offset w26, -64
	.cfi_offset w30, -72
	.cfi_offset w29, -80
.Ltmp0:
	.loc	3 303 7 prologue_end
	adrp	x24, global_waveform
	ldr	x8, [x24, :lo12:global_waveform]
.Ltmp1:
	.loc	3 303 6 is_stmt 0
	cbz	x8, .LBB0_10
.Ltmp2:
	.loc	3 0 6
	mov	w19, w2
.Ltmp3:
	mov	w21, w1
.Ltmp4:
	mov	x20, x0
.Ltmp5:
	.loc	3 306 14 is_stmt 1
	cbnz	x0, .LBB0_3
.Ltmp6:
	.loc	3 0 14 is_stmt 0
	mov	w9, #16
	.loc	3 306 18
	ldr	x9, [x9]
.Ltmp7:
	.loc	3 306 6
	cbz	x9, .LBB0_11
.Ltmp8:
.LBB0_3:
	.loc	3 311 28 is_stmt 1
	adrp	x23, pvi_wf_get_lut.sftemp
	.loc	3 311 19 is_stmt 0
	mov	w9, #21846
	movk	w9, #21845, lsl #16
	adrp	x26, pvi_wf_get_lut.stype
	.loc	3 311 28
	ldrsw	x10, [x23, :lo12:pvi_wf_get_lut.sftemp]
	.loc	3 311 19
	smull	x11, w19, w9
	ldr	w13, [x26, :lo12:pvi_wf_get_lut.stype]
	.loc	3 311 35
	mul	x9, x10, x9
	.loc	3 311 19
	lsr	x10, x11, #63
	lsr	x11, x11, #32
	.loc	3 311 35
	lsr	x12, x9, #63
	lsr	x9, x9, #32
	.loc	3 311 19
	add	w25, w11, w10
	.loc	3 311 35
	add	w9, w9, w12
	.loc	3 311 41
	cmp	w25, w9
	ccmp	w13, w21, #0, eq
	b.eq	.LBB0_77
.Ltmp9:
	.loc	3 314 11 is_stmt 1
	adrp	x10, need_pic
	.loc	3 316 6
	cmp	w21, #10
	.loc	3 314 11
	str	w3, [x10, :lo12:need_pic]
	.loc	3 316 6
	b.eq	.LBB0_76
.Ltmp10:
	.loc	3 318 18
	ldr	x10, [x20, #16]
	.loc	3 318 16 is_stmt 0
	adrp	x11, waveformdata
.Ltmp11:
	.loc	3 201 34 is_stmt 1
	ldrb	w9, [x8, #38]
.Ltmp12:
	.loc	3 318 16
	str	x10, [x11, :lo12:waveformdata]
.Ltmp13:
	.loc	3 205 2
	cbz	w9, .LBB0_12
.Ltmp14:
	.loc	3 0 2 is_stmt 0
	mov	x10, xzr
	.loc	3 205 2
	add	x8, x8, #48
.Ltmp15:
.LBB0_7:
	.loc	3 206 21 is_stmt 1
	ldrb	w11, [x8, x10]
.Ltmp16:
	.loc	3 206 7 is_stmt 0
	cmp	w11, w19
	b.ge	.LBB0_13
.Ltmp17:
	.loc	3 205 29 is_stmt 1
	add	x10, x10, #1
.Ltmp18:
	.loc	3 205 2 is_stmt 0
	cmp	x9, x10
	b.ne	.LBB0_7
.Ltmp19:
	.loc	3 0 2
	mov	w8, #-1
	mov	w10, w9
	b	.LBB0_14
.Ltmp20:
.LBB0_10:
	mov	w0, #-19
.Ltmp21:
	b	.LBB0_87
.Ltmp22:
.LBB0_11:
	mov	w0, #-22
	b	.LBB0_87
.Ltmp23:
.LBB0_12:
	mov	w10, wzr
	mov	w8, #-1
	b	.LBB0_14
.Ltmp24:
.LBB0_13:
	mov	w8, w10
.Ltmp25:
.LBB0_14:
	.loc	3 320 16 is_stmt 1
	mov	w0, w21
	sub	w11, w10, #1
.Ltmp26:
	.loc	3 212 6
	cmp	w10, w9
	csel	w22, w11, w8, eq
.Ltmp27:
	.loc	3 320 16
	bl	get_wf_mode_index
.Ltmp28:
	and	w0, w0, #0xff
.Ltmp29:
	.loc	3 321 15
	mov	w1, w22
	bl	get_wf_frm_num
.Ltmp30:
	.loc	3 322 7
	tbnz	w0, #31, .LBB0_88
.Ltmp31:
	.loc	3 327 7
	cmp	w21, #1
	b.eq	.LBB0_28
.Ltmp32:
	cmp	w21, #7
	b.ne	.LBB0_75
.Ltmp33:
	.loc	3 247 2
	cbz	w0, .LBB0_75
.Ltmp34:
	.loc	3 247 16 is_stmt 0
	mov	w10, w0
	mov	x9, xzr
.Ltmp35:
	.loc	3 0 0
	ldr	x8, [x20, #16]
.Ltmp36:
	.loc	3 247 2
	lsl	x10, x10, #10
.Ltmp37:
.LBB0_19:
	.loc	3 248 20 is_stmt 1
	add	x11, x8, w9, sxtw
.Ltmp38:
	.loc	3 247 16
	add	x9, x9, #1024
.Ltmp39:
	.loc	3 247 2 is_stmt 0
	cmp	x10, x9
.Ltmp40:
	.loc	3 249 38 is_stmt 1
	ldrb	w12, [x11, #960]
	.loc	3 251 38
	ldrb	w13, [x11, #30]
	.loc	3 249 36
	strb	w12, [x11, #992]
	.loc	3 250 36
	strb	w12, [x11, #928]
	.loc	3 251 36
	strb	w13, [x11, #62]
.Ltmp41:
	.loc	3 247 2
	b.ne	.LBB0_19
.Ltmp42:
	.loc	3 0 2 is_stmt 0
	sub	w9, w0, #1
.Ltmp43:
	.loc	3 254 2 is_stmt 1
	cmp	w9, #1
	b.lt	.LBB0_25
.Ltmp44:
	cmp	w9, #1
	b.ne	.LBB0_34
.Ltmp45:
	.loc	3 0 2 is_stmt 0
	mov	x10, xzr
.Ltmp46:
.LBB0_23:
	.loc	3 254 2
	sub	x9, x9, x10
	lsl	w10, w10, #10
	mov	w11, #2
	mov	w12, #1
.Ltmp47:
.LBB0_24:
	.loc	3 255 20 is_stmt 1
	add	x13, x8, w10, sxtw
.Ltmp48:
	.loc	3 254 16
	subs	x9, x9, #1
	add	w10, w10, #1024
.Ltmp49:
	.loc	3 256 36
	strb	w11, [x13, #1022]
	.loc	3 257 36
	strb	w12, [x13, #32]
.Ltmp50:
	.loc	3 254 2
	b.ne	.LBB0_24
.Ltmp51:
.LBB0_25:
	.loc	3 0 2 is_stmt 0
	sub	w9, w0, #3
.Ltmp52:
	.loc	3 260 2 is_stmt 1
	cmp	w9, #4
	b.lt	.LBB0_75
.Ltmp53:
	.loc	3 0 2 is_stmt 0
	add	x8, x8, #958
.Ltmp54:
	.loc	3 260 2
	sub	x11, x9, #3
	cmp	x11, #2
	b.hs	.LBB0_44
.Ltmp55:
	.loc	3 0 2
	mov	w10, #3
	b	.LBB0_50
.Ltmp56:
.LBB0_28:
	.loc	3 273 2 is_stmt 1
	cbz	w0, .LBB0_75
.Ltmp57:
	.loc	3 273 16 is_stmt 0
	mov	w10, w0
	mov	x9, xzr
.Ltmp58:
	.loc	3 0 0
	ldr	x8, [x20, #16]
.Ltmp59:
	.loc	3 273 2
	lsl	x10, x10, #10
.Ltmp60:
.LBB0_30:
	.loc	3 274 20 is_stmt 1
	add	x11, x8, w9, sxtw
.Ltmp61:
	.loc	3 273 16
	add	x9, x9, #1024
.Ltmp62:
	.loc	3 273 2 is_stmt 0
	cmp	x10, x9
.Ltmp63:
	.loc	3 275 38 is_stmt 1
	ldrb	w12, [x11, #960]
	.loc	3 277 38
	ldrb	w13, [x11, #30]
	.loc	3 275 36
	strb	w12, [x11, #992]
	.loc	3 276 36
	strb	w12, [x11, #928]
	.loc	3 277 36
	strb	w13, [x11, #62]
.Ltmp64:
	.loc	3 273 2
	b.ne	.LBB0_30
.Ltmp65:
	.loc	3 0 2 is_stmt 0
	sub	w9, w0, #4
.Ltmp66:
	.loc	3 280 2 is_stmt 1
	cmp	w9, #5
	b.lt	.LBB0_64
.Ltmp67:
	sub	x11, x9, #4
.Ltmp68:
	cmp	x11, #2
	b.hs	.LBB0_52
.Ltmp69:
	.loc	3 0 2 is_stmt 0
	mov	w10, #4
	b	.LBB0_62
.Ltmp70:
.LBB0_34:
	.loc	3 254 2 is_stmt 1
	sub	x12, x9, #1
	mov	x10, xzr
	and	x11, x12, #0xffffffff
.Ltmp71:
	lsl	x14, x11, #10
	tst	x14, #0xffffffff00000000
	cset	w13, ne
	cmp	xzr, x12, lsr #54
	cset	w11, ne
	tbnz	w14, #31, .LBB0_23
.Ltmp72:
	.loc	3 0 2 is_stmt 0
	tbnz	w13, #0, .LBB0_23
.Ltmp73:
	lsr	x13, x12, #32
	cbnz	x13, .LBB0_23
.Ltmp74:
	add	x13, x8, #1022
	lsl	x12, x12, #10
	add	x14, x13, x12
	cmp	x14, x13
	b.lo	.LBB0_23
.Ltmp75:
	tbnz	w11, #0, .LBB0_23
.Ltmp76:
	add	x13, x8, #32
	add	x12, x13, x12
	cmp	x12, x13
	b.lo	.LBB0_23
.Ltmp77:
	tbnz	w11, #0, .LBB0_23
.Ltmp78:
	.loc	3 254 2
	and	x10, x9, #0xfffffffe
	mov	w11, #1024
	mov	w12, #2
	mov	w13, #1
	mov	x14, x10
.Ltmp79:
.LBB0_42:
	.loc	3 254 34
	sub	w15, w11, #1024
	add	x16, x8, w11, sxtw
	subs	x14, x14, #2
	add	w11, w11, #2048
	add	x15, x8, w15, sxtw
	strb	w12, [x16, #1022]
	strb	w13, [x16, #32]
	strb	w12, [x15, #1022]
	strb	w13, [x15, #32]
	b.ne	.LBB0_42
.Ltmp80:
	.loc	3 254 2
	cmp	x10, x9
	b.ne	.LBB0_23
	b	.LBB0_25
.Ltmp81:
.LBB0_44:
	.loc	3 260 2 is_stmt 1
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
	b.hi	.LBB0_50
.Ltmp82:
	.loc	3 0 2 is_stmt 0
	tbnz	w13, #0, .LBB0_50
.Ltmp83:
	lsr	x12, x12, #32
	cbnz	x12, .LBB0_50
.Ltmp84:
	.loc	3 260 2
	and	x12, x11, #0xfffffffffffffffe
	mov	w13, #4096
	add	x10, x12, #3
	mov	w14, #2
	mov	x15, x12
.Ltmp85:
.LBB0_48:
	.loc	3 261 25 is_stmt 1
	sub	w16, w13, #1024
	.loc	3 262 36
	strb	w14, [x8, w13, sxtw]
	add	w13, w13, #2048
	subs	x15, x15, #2
	strb	w14, [x8, w16, sxtw]
	b.ne	.LBB0_48
.Ltmp86:
	.loc	3 260 2
	cmp	x11, x12
	b.eq	.LBB0_75
.Ltmp87:
.LBB0_50:
	sub	x9, x9, x10
	lsl	w10, w10, #10
	mov	w11, #2
.Ltmp88:
.LBB0_51:
	.loc	3 262 36
	strb	w11, [x8, w10, sxtw]
.Ltmp89:
	.loc	3 260 16
	subs	x9, x9, #1
	add	w10, w10, #1024
.Ltmp90:
	.loc	3 260 2 is_stmt 0
	b.ne	.LBB0_51
	b	.LBB0_75
.Ltmp91:
.LBB0_52:
	.loc	3 280 2 is_stmt 1
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
	b.hi	.LBB0_62
.Ltmp92:
	.loc	3 0 2 is_stmt 0
	tbnz	w14, #0, .LBB0_62
.Ltmp93:
	lsr	x14, x13, #32
	cbnz	x14, .LBB0_62
.Ltmp94:
	mov	w14, #5118
	lsl	x13, x13, #10
	add	x14, x8, x14
	add	x15, x14, x13
	cmp	x15, x14
	b.lo	.LBB0_62
.Ltmp95:
	tbnz	w12, #0, .LBB0_62
.Ltmp96:
	mov	w14, #4128
	add	x14, x8, x14
	add	x13, x14, x13
	cmp	x13, x14
	b.lo	.LBB0_62
.Ltmp97:
	tbnz	w12, #0, .LBB0_62
.Ltmp98:
	.loc	3 280 2
	and	x12, x11, #0xfffffffffffffffe
	mov	w13, #5120
	add	x10, x12, #4
	mov	w14, #2
	mov	w15, #1
	mov	x16, x12
.Ltmp99:
.LBB0_60:
	.loc	3 281 25 is_stmt 1
	sub	w17, w13, #1024
	.loc	3 281 20 is_stmt 0
	add	x1, x8, w13, sxtw
	add	w13, w13, #2048
	subs	x16, x16, #2
	add	x17, x8, w17, sxtw
	.loc	3 282 36 is_stmt 1
	strb	w14, [x1, #1022]
	.loc	3 283 36
	strb	w15, [x1, #32]
	.loc	3 282 36
	strb	w14, [x17, #1022]
	.loc	3 283 36
	strb	w15, [x17, #32]
	b.ne	.LBB0_60
.Ltmp100:
	.loc	3 280 2
	cmp	x11, x12
	b.eq	.LBB0_64
.Ltmp101:
.LBB0_62:
	sub	x9, x9, x10
	lsl	w10, w10, #10
	mov	w11, #2
	mov	w12, #1
.Ltmp102:
.LBB0_63:
	.loc	3 281 20
	add	x13, x8, w10, sxtw
.Ltmp103:
	.loc	3 280 16
	subs	x9, x9, #1
	add	w10, w10, #1024
.Ltmp104:
	.loc	3 282 36
	strb	w11, [x13, #1022]
	.loc	3 283 36
	strb	w12, [x13, #32]
.Ltmp105:
	.loc	3 280 2
	b.ne	.LBB0_63
.Ltmp106:
.LBB0_64:
	.loc	3 0 2 is_stmt 0
	sub	w9, w0, #7
.Ltmp107:
	.loc	3 286 2 is_stmt 1
	cmp	w9, #8
	b.lt	.LBB0_75
.Ltmp108:
	.loc	3 0 2 is_stmt 0
	add	x8, x8, #958
.Ltmp109:
	.loc	3 286 2
	sub	x11, x9, #7
	cmp	x11, #2
	b.hs	.LBB0_67
.Ltmp110:
	.loc	3 0 2
	mov	w10, #7
	b	.LBB0_73
.Ltmp111:
.LBB0_67:
	.loc	3 286 2
	sub	x12, x9, #8
	mov	w15, #58367
	and	x10, x12, #0xffffffff
	movk	w15, #32767, lsl #16
	lsl	x14, x10, #10
	mov	w10, #7
	tst	x14, #0xffffffff00000000
	cset	w13, ne
	cmp	w14, w15
	b.hi	.LBB0_73
.Ltmp112:
	.loc	3 0 2
	tbnz	w13, #0, .LBB0_73
.Ltmp113:
	lsr	x12, x12, #32
	cbnz	x12, .LBB0_73
.Ltmp114:
	.loc	3 286 2
	and	x12, x11, #0xfffffffffffffffe
	mov	w13, #8192
	add	x10, x12, #7
	mov	w14, #2
	mov	x15, x12
.Ltmp115:
.LBB0_71:
	.loc	3 287 25 is_stmt 1
	sub	w16, w13, #1024
	.loc	3 288 36
	strb	w14, [x8, w13, sxtw]
	add	w13, w13, #2048
	subs	x15, x15, #2
	strb	w14, [x8, w16, sxtw]
	b.ne	.LBB0_71
.Ltmp116:
	.loc	3 286 2
	cmp	x11, x12
	b.eq	.LBB0_75
.Ltmp117:
.LBB0_73:
	sub	x9, x9, x10
	lsl	w10, w10, #10
	mov	w11, #2
.Ltmp118:
.LBB0_74:
	.loc	3 288 36
	strb	w11, [x8, w10, sxtw]
.Ltmp119:
	.loc	3 286 16
	subs	x9, x9, #1
	add	w10, w10, #1024
.Ltmp120:
	.loc	3 286 2 is_stmt 0
	b.ne	.LBB0_74
.Ltmp121:
.LBB0_75:
	.loc	3 332 21 is_stmt 1
	ldrb	w8, [x20, #1]
	mov	w9, #21846
	movk	w9, #21845, lsl #16
	.loc	3 333 21
	orr	w8, w0, w8, lsl #8
	str	w8, [x20]
.Ltmp122:
	.loc	3 337 27
	ldrsw	x8, [x23, :lo12:pvi_wf_get_lut.sftemp]
.Ltmp123:
	.loc	3 334 9
	str	w21, [x26, :lo12:pvi_wf_get_lut.stype]
.Ltmp124:
	.loc	3 337 34
	mul	x8, x8, x9
	lsr	x9, x8, #63
	lsr	x8, x8, #32
	add	w9, w8, w9
.Ltmp125:
.LBB0_76:
	.loc	3 337 6 is_stmt 0
	cmp	w25, w9
	b.ne	.LBB0_78
.Ltmp126:
.LBB0_77:
	.loc	3 0 6
	mov	w0, wzr
	b	.LBB0_87
.Ltmp127:
.LBB0_78:
	.loc	3 339 18 is_stmt 1
	ldr	x8, [x20, #24]
	.loc	3 339 16 is_stmt 0
	adrp	x9, waveformdata
	str	x8, [x9, :lo12:waveformdata]
	.loc	3 340 17 is_stmt 1
	bl	epd_overlay_lut
.Ltmp128:
	.loc	3 201 17
	ldr	x10, [x24, :lo12:global_waveform]
	.loc	3 201 34 is_stmt 0
	ldrb	w8, [x10, #38]
.Ltmp129:
	.loc	3 205 2 is_stmt 1
	cbz	w8, .LBB0_83
.Ltmp130:
	.loc	3 0 2 is_stmt 0
	mov	x9, xzr
	.loc	3 205 2
	add	x10, x10, #48
.Ltmp131:
.LBB0_80:
	.loc	3 206 21 is_stmt 1
	ldrb	w11, [x10, x9]
.Ltmp132:
	.loc	3 206 7 is_stmt 0
	cmp	w11, w19
	b.ge	.LBB0_84
.Ltmp133:
	.loc	3 205 29 is_stmt 1
	add	x9, x9, #1
.Ltmp134:
	.loc	3 205 2 is_stmt 0
	cmp	x8, x9
	b.ne	.LBB0_80
.Ltmp135:
	.loc	3 0 2
	mov	w10, #-1
	mov	w9, w8
.Ltmp136:
	b	.LBB0_85
.Ltmp137:
.LBB0_83:
	mov	w9, wzr
	mov	w10, #-1
	b	.LBB0_85
.Ltmp138:
.LBB0_84:
	mov	w10, w9
.Ltmp139:
.LBB0_85:
	sub	w11, w9, #1
	.loc	3 212 6 is_stmt 1
	cmp	w9, w8
	csel	w21, w11, w10, eq
.Ltmp140:
	.loc	3 342 16
	bl	get_wf_mode_index
.Ltmp141:
	and	w0, w0, #0xff
.Ltmp142:
	.loc	3 343 15
	mov	w1, w21
	bl	get_wf_frm_num
.Ltmp143:
	.loc	3 344 7
	tbnz	w0, #31, .LBB0_88
.Ltmp144:
	.loc	3 348 21
	ldrb	w8, [x20]
	.loc	3 349 21
	bfi	w8, w0, #8, #24
	mov	w0, wzr
.Ltmp145:
	str	w8, [x20]
	.loc	3 350 10
	str	w19, [x23, :lo12:pvi_wf_get_lut.sftemp]
.Ltmp146:
.LBB0_87:
	.loc	3 354 1
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x29, x30, [sp], #80
	ldr	x30, [x18, #-8]!
	ret
.LBB0_88:
.Ltmp147:
	.loc	3 0 0 is_stmt 0
	adrp	x0, .L.str
.Ltmp148:
	add	x0, x0, :lo12:.L.str
	bl	_printk
.Ltmp149:
	mov	w0, #-5
	b	.LBB0_87
.Ltmp150:
.Lfunc_end0:
	.size	pvi_wf_get_lut, .Lfunc_end0-pvi_wf_get_lut
	.cfi_endproc

	.p2align	2
	.type	get_wf_mode_index,@function
get_wf_mode_index:
.Lfunc_begin1:
	.loc	3 182 0 is_stmt 1
	.cfi_startproc
	str	x30, [x18], #8
	.cfi_escape 0x16, 0x12, 0x02, 0x82, 0x78
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
.Ltmp151:
	.loc	3 186 6 prologue_end
	cmp	w0, #11
	b.hs	.LBB1_12
.Ltmp152:
	.loc	3 194 33
	adrp	x8, global_waveform
.Ltmp153:
	.loc	3 189 13
	cmp	w0, #10
.Ltmp154:
	.loc	3 194 33
	ldr	x8, [x8, :lo12:global_waveform]
.Ltmp155:
	.loc	3 167 20
	ldrb	w9, [x8, #16]
	mov	w8, #3
.Ltmp156:
	.loc	3 189 13
	csel	w8, w8, w0, eq
.Ltmp157:
	.loc	3 167 2
	sub	w9, w9, #9
	cmp	w9, #75
	b.hi	.LBB1_4
.Ltmp158:
	.loc	3 0 2 is_stmt 0
	adrp	x10, .LJTI1_0
	add	x10, x10, :lo12:.LJTI1_0
	adr	x11, .LBB1_3
	ldrb	w12, [x10, x9]
	add	x11, x11, x12, lsl #2
	adrp	x9, pvi_mode_table
	add	x9, x9, :lo12:pvi_mode_table
	br	x11
.Ltmp159:
.LBB1_3:
	adrp	x9, pvi_mode_table+30
	add	x9, x9, :lo12:pvi_mode_table+30
	b	.LBB1_10
.Ltmp160:
.LBB1_4:
	adrp	x9, pvi_mode_table+70
	add	x9, x9, :lo12:pvi_mode_table+70
	b	.LBB1_10
.Ltmp161:
.LBB1_5:
	adrp	x9, pvi_mode_table+10
	add	x9, x9, :lo12:pvi_mode_table+10
	b	.LBB1_10
.Ltmp162:
.LBB1_6:
	adrp	x9, pvi_mode_table+20
	add	x9, x9, :lo12:pvi_mode_table+20
	b	.LBB1_10
.Ltmp163:
.LBB1_7:
	adrp	x9, pvi_mode_table+40
	add	x9, x9, :lo12:pvi_mode_table+40
	b	.LBB1_10
.Ltmp164:
.LBB1_8:
	adrp	x9, pvi_mode_table+50
	add	x9, x9, :lo12:pvi_mode_table+50
	b	.LBB1_10
.Ltmp165:
.LBB1_9:
	adrp	x9, pvi_mode_table+60
	add	x9, x9, :lo12:pvi_mode_table+60
.Ltmp166:
.LBB1_10:
	.loc	3 196 9 is_stmt 1
	ldrb	w0, [x9, x8]
.Ltmp167:
.LBB1_11:
	.loc	3 197 1
	ldp	x29, x30, [sp], #16
	ldr	x30, [x18, #-8]!
	ret
.Ltmp168:
.LBB1_12:
	.loc	3 187 3
	adrp	x0, .L.str.3
.Ltmp169:
	add	x0, x0, :lo12:.L.str.3
	bl	_printk
.Ltmp170:
	.loc	3 0 3 is_stmt 0
	mov	w0, #255
	b	.LBB1_11
.Ltmp171:
.Lfunc_end1:
	.size	get_wf_mode_index, .Lfunc_end1-get_wf_mode_index
	.cfi_endproc
	.section	.rodata,"a",@progbits
.LJTI1_0:
	.byte	(.LBB1_10-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_5-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_6-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_3-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_7-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_3-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_8-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_4-.LBB1_3)>>2
	.byte	(.LBB1_9-.LBB1_3)>>2

	.text
	.p2align	2
	.type	get_wf_frm_num,@function
get_wf_frm_num:
.Lfunc_begin2:
	.loc	3 219 0 is_stmt 1
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
.Ltmp172:
	.loc	3 220 45 prologue_end
	adrp	x8, global_waveform
	.loc	3 224 37
	lsl	w9, w0, #2
	.loc	3 220 45
	ldr	x14, [x8, :lo12:global_waveform]
.Ltmp173:
	.loc	3 222 32
	ldrb	w8, [x14, #32]
.Ltmp174:
	.loc	3 224 21
	add	x8, x14, x8
.Ltmp175:
	.loc	3 224 30 is_stmt 0
	add	x8, x8, x9
.Ltmp176:
	.loc	3 225 22 is_stmt 1
	ldrb	w9, [x8]
	.loc	3 225 35 is_stmt 0
	ldrb	w10, [x8, #1]
	.loc	3 225 48
	ldrb	w11, [x8, #2]
	.loc	3 225 6
	ldrb	w12, [x8, #3]
	.loc	3 225 33
	add	w9, w10, w9
	.loc	3 225 46
	add	w9, w9, w11
.Ltmp177:
	.loc	3 225 6
	cmp	w12, w9, uxtb
	b.ne	.LBB2_36
.Ltmp178:
	.loc	3 0 6
	ldr	w8, [x8]
.Ltmp179:
	.loc	3 231 43 is_stmt 1
	lsl	w9, w1, #2
	.loc	3 229 28
	and	x8, x8, #0xffffff
.Ltmp180:
	.loc	3 231 21
	add	x8, x14, x8
.Ltmp181:
	.loc	3 231 30 is_stmt 0
	add	x8, x8, w9, sxtw
.Ltmp182:
	.loc	3 232 22 is_stmt 1
	ldrb	w9, [x8]
	.loc	3 232 35 is_stmt 0
	ldrb	w10, [x8, #1]
	.loc	3 232 48
	ldrb	w11, [x8, #2]
	.loc	3 232 6
	ldrb	w12, [x8, #3]
	.loc	3 232 33
	add	w9, w10, w9
	.loc	3 232 46
	add	w9, w9, w11
.Ltmp183:
	.loc	3 232 6
	cmp	w12, w9, uxtb
	b.ne	.LBB2_37
.Ltmp184:
	.loc	3 55 7 is_stmt 1
	adrp	x20, waveformdata
	ldr	x10, [x20, :lo12:waveformdata]
.Ltmp185:
	.loc	3 55 6 is_stmt 0
	cbz	x10, .LBB2_39
.Ltmp186:
	.loc	3 0 6
	adrp	x21, need_pic
.Ltmp187:
	.loc	3 60 6 is_stmt 1
	adrp	x22, maxpic
	ldr	w15, [x8]
	mov	w16, #5
	mov	w0, #32
.Ltmp188:
	.loc	3 0 6 is_stmt 0
	mov	w13, wzr
	ldr	w9, [x21, :lo12:need_pic]
	mov	w11, wzr
	.loc	3 60 6
	ldrb	w8, [x22, :lo12:maxpic]
.Ltmp189:
	.loc	3 0 0
	and	x15, x15, #0xffffff
.Ltmp190:
	add	x14, x14, x15
.Ltmp191:
	mov	w19, wzr
	cmp	w9, #32
	mov	w12, wzr
	cset	w17, eq
	bics	w15, w17, w8
.Ltmp192:
	mov	w17, #16
	cinc	w16, w16, ne
	cmp	w8, #0
	csel	w17, w0, w17, ne
	mov	w0, #1
.Ltmp193:
	b	.LBB2_6
.Ltmp194:
.LBB2_4:
	mov	w0, #1
.Ltmp195:
.LBB2_5:
	add	w11, w11, #1
.Ltmp196:
	.loc	3 64 7 is_stmt 1
	cmp	w19, #254
	b.hi	.LBB2_18
.Ltmp197:
.LBB2_6:
	.loc	3 69 7
	ldrb	w3, [x14, w11, uxtw]
.Ltmp198:
	.loc	3 69 7 is_stmt 0
	cmp	w3, #252
	b.eq	.LBB2_11
.Ltmp199:
	cmp	w3, #255
	b.eq	.LBB2_19
.Ltmp200:
	.loc	3 79 7 is_stmt 1
	tbnz	w0, #0, .LBB2_12
.Ltmp201:
.LBB2_9:
	.loc	3 114 44
	add	w0, w13, #1
.Ltmp202:
	.loc	3 114 75 is_stmt 0
	lsl	w1, w12, w15
.Ltmp203:
	.loc	3 114 47
	lsl	w2, w13, w16
	.loc	3 114 35
	add	w1, w1, w19, lsl #10
	.loc	3 115 47 is_stmt 1
	lsl	w0, w0, w16
.Ltmp204:
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
.Ltmp205:
	.loc	3 115 88 is_stmt 0
	strb	w5, [x10, w0, uxtw]
	.loc	3 116 44 is_stmt 1
	add	w0, w13, #3
.Ltmp206:
	.loc	3 116 47 is_stmt 0
	lsl	w2, w2, w16
	.loc	3 117 47 is_stmt 1
	lsl	w0, w0, w16
.Ltmp207:
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
.Ltmp208:
	.loc	3 116 88 is_stmt 1
	strb	w4, [x10, w2, uxtw]
	.loc	3 120 8
	cmp	w13, w17
	.loc	3 117 88
	strb	w1, [x10, w0, uxtw]
.Ltmp209:
	.loc	3 0 88 is_stmt 0
	mov	w0, wzr
	.loc	3 120 8 is_stmt 1
	b.lo	.LBB2_5
.Ltmp210:
	.loc	3 122 9
	add	w1, w12, #1
.Ltmp211:
	.loc	3 0 9 is_stmt 0
	mov	w13, wzr
	.loc	3 122 18
	cmp	w1, w17
.Ltmp212:
	.loc	3 122 9
	csinc	w12, wzr, w12, hs
	cinc	w19, w19, hs
.Ltmp213:
	.loc	3 0 9
	b	.LBB2_5
.Ltmp214:
.LBB2_11:
	.loc	3 76 10 is_stmt 1
	add	w11, w11, #1
.Ltmp215:
	.loc	3 0 0 is_stmt 0
	ldrb	w3, [x14, w11, uxtw]
.Ltmp216:
	.loc	3 79 7 is_stmt 1
	tbnz	w0, #0, .LBB2_9
.Ltmp217:
.LBB2_12:
	.loc	3 81 44
	add	w0, w13, #1
.Ltmp218:
	.loc	3 81 75 is_stmt 0
	lsl	w1, w12, w15
.Ltmp219:
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
.Ltmp220:
	.loc	3 82 106
	ubfx	w1, w3, #2, #2
	.loc	3 81 88
	strb	w0, [x10, w2, uxtw]
	.loc	3 82 44
	add	w2, w13, #2
.Ltmp221:
	.loc	3 82 88 is_stmt 0
	strb	w1, [x10, w5, uxtw]
	.loc	3 83 44 is_stmt 1
	add	w5, w13, #3
.Ltmp222:
	.loc	3 83 47 is_stmt 0
	lsl	w2, w2, w16
	.loc	3 84 47 is_stmt 1
	lsl	w5, w5, w16
.Ltmp223:
	.loc	3 83 65
	add	w6, w4, w2
	.loc	3 83 106 is_stmt 0
	ubfx	w2, w3, #4, #2
	.loc	3 84 65 is_stmt 1
	add	w4, w4, w5
	.loc	3 84 100 is_stmt 0
	lsr	w3, w3, #6
.Ltmp224:
	.loc	3 84 44
	add	w13, w13, #4
.Ltmp225:
	.loc	3 87 8 is_stmt 1
	cmp	w13, w17
	.loc	3 83 88
	strb	w2, [x10, w6, uxtw]
	.loc	3 84 88
	strb	w3, [x10, w4, uxtw]
.Ltmp226:
	.loc	3 87 8
	b.lo	.LBB2_14
.Ltmp227:
	.loc	3 89 9
	add	w4, w12, #1
.Ltmp228:
	.loc	3 0 9 is_stmt 0
	mov	w13, wzr
	.loc	3 89 18
	cmp	w4, w17
.Ltmp229:
	.loc	3 89 9
	csinc	w12, wzr, w12, hs
	cinc	w19, w19, hs
.Ltmp230:
.LBB2_14:
	.loc	3 0 0
	add	w11, w11, #1
.Ltmp231:
	.loc	3 95 8 is_stmt 1
	ldrb	w4, [x14, w11, uxtw]
.Ltmp232:
	.loc	3 96 4
	cbnz	w4, .LBB2_16
	b	.LBB2_4
.Ltmp233:
.LBB2_15:
	.loc	3 96 19 is_stmt 0
	sub	w4, w4, #1
.Ltmp234:
	tst	w4, #0xff
.Ltmp235:
	.loc	3 96 4
	b.eq	.LBB2_4
.Ltmp236:
.LBB2_16:
	.loc	3 97 45 is_stmt 1
	add	w5, w13, #1
.Ltmp237:
	.loc	3 97 76 is_stmt 0
	lsl	w6, w12, w15
	.loc	3 98 45 is_stmt 1
	add	w23, w13, #2
.Ltmp238:
	.loc	3 99 45
	add	w24, w13, #3
.Ltmp239:
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
.Ltmp240:
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
.Ltmp241:
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
	b.lo	.LBB2_15
.Ltmp242:
	.loc	3 103 10
	add	w5, w12, #1
.Ltmp243:
	.loc	3 0 10 is_stmt 0
	mov	w13, wzr
	.loc	3 103 19
	cmp	w5, w17
.Ltmp244:
	.loc	3 103 10
	csinc	w12, wzr, w12, hs
	cinc	w19, w19, hs
.Ltmp245:
	.loc	3 0 10
	b	.LBB2_15
.Ltmp246:
.LBB2_18:
	.loc	3 65 4 is_stmt 1
	adrp	x0, .L.str.6
	add	x0, x0, :lo12:.L.str.6
	bl	_printk
.Ltmp247:
	.loc	3 130 6
	ldrb	w8, [x22, :lo12:maxpic]
	ldr	w9, [x21, :lo12:need_pic]
.Ltmp248:
.LBB2_19:
	.loc	3 130 24 is_stmt 0
	cbz	w8, .LBB2_26
.Ltmp249:
	cmp	w9, #16
	b.ne	.LBB2_26
.Ltmp250:
	.loc	3 132 3 is_stmt 1
	cbz	w19, .LBB2_41
.Ltmp251:
	.loc	3 0 3 is_stmt 0
	ldr	x13, [x20, :lo12:waveformdata]
	mov	w10, wzr
	mov	w11, wzr
	.loc	3 132 3
	add	x12, x13, #16
	add	x13, x13, #7
.Ltmp252:
.LBB2_23:
	.loc	3 0 3
	mov	w15, w10
	mov	x16, #-2
.Ltmp253:
	add	x14, x12, x15
	and	x15, x15, #0xffffffe0
	add	x15, x13, x15
.Ltmp254:
.LBB2_24:
	.loc	3 135 17 is_stmt 1
	ldurb	w17, [x14, #-16]
.Ltmp255:
	.loc	3 133 28
	add	x16, x16, #2
.Ltmp256:
	.loc	3 133 4 is_stmt 0
	cmp	x16, #30
.Ltmp257:
	.loc	3 136 61 is_stmt 1
	sturb	w17, [x15, #-7]
.Ltmp258:
	.loc	3 135 17
	ldurb	w17, [x14, #-14]
.Ltmp259:
	.loc	3 136 61
	sturb	w17, [x15, #-6]
.Ltmp260:
	.loc	3 135 17
	ldurb	w17, [x14, #-12]
.Ltmp261:
	.loc	3 136 61
	sturb	w17, [x15, #-5]
.Ltmp262:
	.loc	3 135 17
	ldurb	w17, [x14, #-10]
.Ltmp263:
	.loc	3 136 61
	sturb	w17, [x15, #-4]
.Ltmp264:
	.loc	3 135 17
	ldurb	w17, [x14, #-8]
.Ltmp265:
	.loc	3 136 61
	sturb	w17, [x15, #-3]
.Ltmp266:
	.loc	3 135 17
	ldurb	w17, [x14, #-6]
.Ltmp267:
	.loc	3 136 61
	sturb	w17, [x15, #-2]
.Ltmp268:
	.loc	3 135 17
	ldurb	w17, [x14, #-4]
.Ltmp269:
	.loc	3 136 61
	sturb	w17, [x15, #-1]
.Ltmp270:
	.loc	3 135 17
	ldurb	w17, [x14, #-2]
.Ltmp271:
	.loc	3 136 61
	strb	w17, [x15]
.Ltmp272:
	.loc	3 135 17
	ldrb	w17, [x14]
.Ltmp273:
	.loc	3 136 61
	strb	w17, [x15, #1]
.Ltmp274:
	.loc	3 135 17
	ldrb	w17, [x14, #2]
.Ltmp275:
	.loc	3 136 61
	strb	w17, [x15, #2]
.Ltmp276:
	.loc	3 135 17
	ldrb	w17, [x14, #4]
.Ltmp277:
	.loc	3 136 61
	strb	w17, [x15, #3]
.Ltmp278:
	.loc	3 135 17
	ldrb	w17, [x14, #6]
.Ltmp279:
	.loc	3 136 61
	strb	w17, [x15, #4]
.Ltmp280:
	.loc	3 135 17
	ldrb	w17, [x14, #8]
.Ltmp281:
	.loc	3 136 61
	strb	w17, [x15, #5]
.Ltmp282:
	.loc	3 135 17
	ldrb	w17, [x14, #10]
.Ltmp283:
	.loc	3 136 61
	strb	w17, [x15, #6]
.Ltmp284:
	.loc	3 135 17
	ldrb	w17, [x14, #12]
.Ltmp285:
	.loc	3 136 61
	strb	w17, [x15, #7]
.Ltmp286:
	.loc	3 135 17
	ldrb	w17, [x14, #14]
.Ltmp287:
	.loc	3 133 28
	add	x14, x14, #64
.Ltmp288:
	.loc	3 136 61
	strb	w17, [x15, #8]
.Ltmp289:
	.loc	3 133 28
	add	x15, x15, #32
.Ltmp290:
	.loc	3 133 4 is_stmt 0
	b.lo	.LBB2_24
.Ltmp291:
	.loc	3 132 31 is_stmt 1
	add	w11, w11, #1
.Ltmp292:
	.loc	3 132 3 is_stmt 0
	add	w10, w10, #1024
.Ltmp293:
	cmp	w19, w11, uxtb
	b.hi	.LBB2_23
.Ltmp294:
.LBB2_26:
	.loc	3 0 3
	cmp	w9, #32
	cset	w9, eq
.Ltmp295:
	.loc	3 142 24 is_stmt 1
	and	w8, w8, w9
	cmp	w8, #1
	b.ne	.LBB2_41
.Ltmp296:
	.loc	3 144 3
	cbz	w19, .LBB2_41
.Ltmp297:
	.loc	3 0 3 is_stmt 0
	ldr	x8, [x20, :lo12:waveformdata]
	mov	x9, xzr
	.loc	3 144 3
	subs	w10, w19, #1
	b.eq	.LBB2_34
.Ltmp298:
	neg	w11, w19
	tst	w11, #0xff
	b.eq	.LBB2_34
.Ltmp299:
	.loc	3 0 3
	cmp	w10, #255
	b.hi	.LBB2_34
.Ltmp300:
	add	x10, x10, #1
	mov	x12, x8
	.loc	3 144 3
	and	x9, x10, #0x1fffffffe
	mov	x11, x9
.Ltmp301:
.LBB2_32:
	.loc	3 144 15
	strb	wzr, [x12, #989]
	subs	x11, x11, #2
	strb	wzr, [x12, #2013]
	add	x12, x12, #2048
	b.ne	.LBB2_32
.Ltmp302:
	.loc	3 144 3
	cmp	x10, x9
	b.eq	.LBB2_41
.Ltmp303:
.LBB2_34:
	add	x8, x8, x9, lsl #10
	add	w9, w9, #1
	add	x8, x8, #989
.Ltmp304:
.LBB2_35:
	add	w10, w9, #1
	cmp	w19, w9, uxtb
.Ltmp305:
	.loc	3 145 45 is_stmt 1
	strb	wzr, [x8]
.Ltmp306:
	.loc	3 144 3
	add	x8, x8, #1024
	mov	w9, w10
	b.hi	.LBB2_35
	b	.LBB2_41
.Ltmp307:
.LBB2_36:
	.loc	3 226 3
	adrp	x0, .L.str.4
.Ltmp308:
	adrp	x1, .L__func__.get_wf_frm_num
.Ltmp309:
	add	x0, x0, :lo12:.L.str.4
	add	x1, x1, :lo12:.L__func__.get_wf_frm_num
	mov	w2, #226
	b	.LBB2_38
.Ltmp310:
.LBB2_37:
	.loc	3 233 3
	adrp	x0, .L.str.4
.Ltmp311:
	adrp	x1, .L__func__.get_wf_frm_num
.Ltmp312:
	add	x0, x0, :lo12:.L.str.4
	add	x1, x1, :lo12:.L__func__.get_wf_frm_num
	mov	w2, #233
.Ltmp313:
.LBB2_38:
	.loc	3 0 0 is_stmt 0
	bl	_printk
.Ltmp314:
	b	.LBB2_40
.Ltmp315:
.LBB2_39:
	.loc	3 56 3 is_stmt 1
	adrp	x0, .L.str.5
.Ltmp316:
	add	x0, x0, :lo12:.L.str.5
	bl	_printk
.Ltmp317:
.LBB2_40:
	.loc	3 0 3 is_stmt 0
	mov	w19, #-22
.Ltmp318:
.LBB2_41:
	.loc	3 240 1 is_stmt 1
	mov	w0, w19
	ldp	x20, x19, [sp, #48]
	ldp	x22, x21, [sp, #32]
	ldp	x24, x23, [sp, #16]
	ldp	x29, x30, [sp], #64
	ldr	x30, [x18, #-8]!
	ret
.Ltmp319:
.Lfunc_end2:
	.size	get_wf_frm_num, .Lfunc_end2-get_wf_frm_num
	.cfi_endproc
	.file	6 "/home/lyx/rk-android14/kernel-6.1" "./include/linux/types.h"

	.globl	pvi_wf_input
	.p2align	2
	.type	pvi_wf_input,@function
pvi_wf_input:
.Lfunc_begin3:
	.loc	3 363 0
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
.Ltmp320:
	.loc	3 366 6 prologue_end
	adrp	x20, global_waveform
	ldr	x8, [x20, :lo12:global_waveform]
.Ltmp321:
	.loc	3 366 6 is_stmt 0
	cbz	x8, .LBB3_3
.Ltmp322:
	.loc	3 0 6
	mov	w0, #-16
.Ltmp323:
.LBB3_2:
	.loc	3 395 1 is_stmt 1
	ldp	x20, x19, [sp, #16]
	ldp	x29, x30, [sp], #32
	ldr	x30, [x18, #-8]!
	ret
.Ltmp324:
.LBB3_3:
	.loc	3 0 1 is_stmt 0
	mov	x19, x0
.Ltmp325:
	.loc	3 369 2 is_stmt 1
	ldrb	w1, [x0, #16]
	adrp	x0, .L.str.1
	add	x0, x0, :lo12:.L.str.1
	bl	_printk
.Ltmp326:
	.loc	3 372 18
	ldrb	w1, [x19, #16]
	.loc	3 372 2 is_stmt 0
	sub	w8, w1, #9
	cmp	w8, #75
	b.hi	.LBB3_7
.Ltmp327:
	.loc	3 0 2
	adrp	x9, .LJTI3_0
	add	x9, x9, :lo12:.LJTI3_0
	adr	x10, .LBB3_5
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
.Ltmp328:
.LBB3_5:
	.loc	3 379 10 is_stmt 1
	adrp	x8, maxpic
	mov	w9, #1
	strb	w9, [x8, :lo12:maxpic]
.Ltmp329:
.LBB3_6:
	.loc	3 0 10 is_stmt 0
	mov	w0, wzr
	.loc	3 392 18 is_stmt 1
	str	x19, [x20, :lo12:global_waveform]
	b	.LBB3_2
.Ltmp330:
.LBB3_7:
	.loc	3 387 3
	adrp	x0, .L.str.2
	ldrb	w2, [x19, #22]
	add	x0, x0, :lo12:.L.str.2
	bl	_printk
.Ltmp331:
	.loc	3 0 3 is_stmt 0
	mov	w0, #-8
	b	.LBB3_2
.Ltmp332:
.Lfunc_end3:
	.size	pvi_wf_input, .Lfunc_end3-pvi_wf_input
	.cfi_endproc
	.section	.rodata,"a",@progbits
.LJTI3_0:
	.byte	(.LBB3_6-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_6-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_5-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_5-.LBB3_5)>>2
	.byte	(.LBB3_5-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_5-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_6-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_5-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_5-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_7-.LBB3_5)>>2
	.byte	(.LBB3_6-.LBB3_5)>>2

	.text
	.globl	pvi_wf_get_version
	.p2align	2
	.type	pvi_wf_get_version,@function
pvi_wf_get_version:
.Lfunc_begin4:
	.loc	3 404 0 is_stmt 1
	.cfi_startproc
	.loc	3 405 39 prologue_end
	adrp	x8, global_waveform
	ldr	x8, [x8, :lo12:global_waveform]
.Ltmp333:
	.loc	3 408 6
	cbz	x8, .LBB4_2
.Ltmp334:
	.loc	3 411 2
	adrp	x0, pvi_wf_get_version.spi_id_buffer
	ldur	x9, [x8, #73]
	ldr	x10, [x8, #88]
	add	x0, x0, :lo12:pvi_wf_get_version.spi_id_buffer
	ldur	x11, [x8, #81]
	ldur	x8, [x8, #65]
.Ltmp335:
	stur	x10, [x0, #23]
	stp	x9, x11, [x0, #8]
	str	x8, [x0]
	.loc	3 412 20
	strb	wzr, [x0, #31]
	.loc	3 415 1
	ret
.LBB4_2:
.Ltmp336:
	.loc	3 0 1 is_stmt 0
	mov	x0, xzr
	.loc	3 415 1
	ret
.Ltmp337:
.Lfunc_end4:
	.size	pvi_wf_get_version, .Lfunc_end4-pvi_wf_get_version
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
	.asciz	"\000\001\001\002\003\004\005\006\004"
	.size	pvi_mode_table, 80

	.type	pvi_wf_get_lut.stype,@object
	.data
	.p2align	2
pvi_wf_get_lut.stype:
	.word	11
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

	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
	.xword	.Lfunc_begin0-.Lfunc_begin0
	.xword	.Ltmp5-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp5-.Lfunc_begin0
	.xword	.Ltmp20-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	.Ltmp20-.Lfunc_begin0
	.xword	.Ltmp21-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp22-.Lfunc_begin0
	.xword	.Ltmp146-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	.Ltmp147-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	0
	.xword	0
.Ldebug_loc1:
	.xword	.Lfunc_begin0-.Lfunc_begin0
	.xword	.Ltmp4-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp4-.Lfunc_begin0
	.xword	.Ltmp20-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	.Ltmp20-.Lfunc_begin0
	.xword	.Ltmp22-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp22-.Lfunc_begin0
	.xword	.Ltmp140-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	.Ltmp140-.Lfunc_begin0
	.xword	.Ltmp146-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc2:
	.xword	.Lfunc_begin0-.Lfunc_begin0
	.xword	.Ltmp3-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp3-.Lfunc_begin0
	.xword	.Ltmp20-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp20-.Lfunc_begin0
	.xword	.Ltmp22-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp22-.Lfunc_begin0
	.xword	.Ltmp146-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp147-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc3:
	.xword	.Lfunc_begin0-.Lfunc_begin0
	.xword	.Ltmp28-.Lfunc_begin0
	.hword	1
	.byte	83
	.xword	.Ltmp28-.Lfunc_begin0
	.xword	.Ltmp125-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	83
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc4:
	.xword	.Ltmp1-.Lfunc_begin0
	.xword	.Ltmp129-.Lfunc_begin0
	.hword	3
	.byte	48
	.byte	32
	.byte	159
	.xword	.Ltmp129-.Lfunc_begin0
	.xword	.Ltmp141-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc5:
	.xword	.Ltmp1-.Lfunc_begin0
	.xword	.Ltmp30-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp30-.Lfunc_begin0
	.xword	.Ltmp125-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp143-.Lfunc_begin0
	.xword	.Ltmp145-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp147-.Lfunc_begin0
	.xword	.Ltmp148-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc6:
	.xword	.Ltmp1-.Lfunc_begin0
	.xword	.Ltmp29-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp29-.Lfunc_begin0
	.xword	.Ltmp30-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp142-.Lfunc_begin0
	.xword	.Ltmp143-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc7:
	.xword	.Ltmp1-.Lfunc_begin0
	.xword	.Ltmp27-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp27-.Lfunc_begin0
	.xword	.Ltmp125-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	.Ltmp140-.Lfunc_begin0
	.xword	.Ltmp146-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	0
	.xword	0
.Ldebug_loc8:
	.xword	.Ltmp13-.Lfunc_begin0
	.xword	.Ltmp19-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp25-.Lfunc_begin0
	.xword	.Ltmp31-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc9:
	.xword	.Ltmp12-.Lfunc_begin0
	.xword	.Ltmp15-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp15-.Lfunc_begin0
	.xword	.Ltmp19-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	0
	.xword	0
.Ldebug_loc10:
	.xword	.Ltmp12-.Lfunc_begin0
	.xword	.Ltmp19-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	127
	.byte	159
	.xword	.Ltmp25-.Lfunc_begin0
	.xword	.Ltmp27-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp27-.Lfunc_begin0
	.xword	.Ltmp31-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	0
	.xword	0
.Ldebug_loc11:
	.xword	.Ltmp13-.Lfunc_begin0
	.xword	.Ltmp19-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp25-.Lfunc_begin0
	.xword	.Ltmp31-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc12:
	.xword	.Ltmp36-.Lfunc_begin0
	.xword	.Ltmp54-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp70-.Lfunc_begin0
	.xword	.Ltmp81-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc13:
	.xword	.Ltmp33-.Lfunc_begin0
	.xword	.Ltmp55-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp70-.Lfunc_begin0
	.xword	.Ltmp91-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc14:
	.xword	.Ltmp33-.Lfunc_begin0
	.xword	.Ltmp37-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp38-.Lfunc_begin0
	.xword	.Ltmp46-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp48-.Lfunc_begin0
	.xword	.Ltmp51-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp70-.Lfunc_begin0
	.xword	.Ltmp71-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp88-.Lfunc_begin0
	.xword	.Ltmp91-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc15:
	.xword	.Ltmp33-.Lfunc_begin0
	.xword	.Ltmp37-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp37-.Lfunc_begin0
	.xword	.Ltmp39-.Lfunc_begin0
	.hword	7
	.byte	121
	.byte	0
	.byte	17
	.byte	128
	.byte	8
	.byte	27
	.byte	159
	.xword	.Ltmp41-.Lfunc_begin0
	.xword	.Ltmp43-.Lfunc_begin0
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
	.xword	.Ltmp43-.Lfunc_begin0
	.xword	.Ltmp47-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp52-.Lfunc_begin0
	.xword	.Ltmp55-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	3
	.byte	159
	.xword	.Ltmp70-.Lfunc_begin0
	.xword	.Ltmp81-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp81-.Lfunc_begin0
	.xword	.Ltmp88-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	3
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc16:
	.xword	.Ltmp59-.Lfunc_begin0
	.xword	.Ltmp69-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp91-.Lfunc_begin0
	.xword	.Ltmp109-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc17:
	.xword	.Ltmp56-.Lfunc_begin0
	.xword	.Ltmp69-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp91-.Lfunc_begin0
	.xword	.Ltmp121-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc18:
	.xword	.Ltmp56-.Lfunc_begin0
	.xword	.Ltmp60-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp61-.Lfunc_begin0
	.xword	.Ltmp68-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp103-.Lfunc_begin0
	.xword	.Ltmp106-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp118-.Lfunc_begin0
	.xword	.Ltmp121-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc19:
	.xword	.Ltmp56-.Lfunc_begin0
	.xword	.Ltmp60-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp60-.Lfunc_begin0
	.xword	.Ltmp62-.Lfunc_begin0
	.hword	7
	.byte	121
	.byte	0
	.byte	17
	.byte	128
	.byte	8
	.byte	27
	.byte	159
	.xword	.Ltmp64-.Lfunc_begin0
	.xword	.Ltmp66-.Lfunc_begin0
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
	.xword	.Ltmp66-.Lfunc_begin0
	.xword	.Ltmp69-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	4
	.byte	159
	.xword	.Ltmp91-.Lfunc_begin0
	.xword	.Ltmp102-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	4
	.byte	159
	.xword	.Ltmp107-.Lfunc_begin0
	.xword	.Ltmp118-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	7
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc20:
	.xword	.Ltmp129-.Lfunc_begin0
	.xword	.Ltmp144-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc21:
	.xword	.Ltmp129-.Lfunc_begin0
	.xword	.Ltmp141-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc22:
	.xword	.Ltmp129-.Lfunc_begin0
	.xword	.Ltmp131-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp131-.Lfunc_begin0
	.xword	.Ltmp136-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	.Ltmp137-.Lfunc_begin0
	.xword	.Ltmp138-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp138-.Lfunc_begin0
	.xword	.Ltmp139-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	0
	.xword	0
.Ldebug_loc23:
	.xword	.Ltmp129-.Lfunc_begin0
	.xword	.Ltmp139-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	127
	.byte	159
	.xword	.Ltmp139-.Lfunc_begin0
	.xword	.Ltmp140-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	.Ltmp140-.Lfunc_begin0
	.xword	.Ltmp144-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	0
	.xword	0
.Ldebug_loc24:
	.xword	.Lfunc_begin1-.Lfunc_begin0
	.xword	.Ltmp167-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp167-.Lfunc_begin0
	.xword	.Ltmp168-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	80
	.byte	159
	.xword	.Ltmp168-.Lfunc_begin0
	.xword	.Ltmp169-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp169-.Lfunc_begin0
	.xword	.Lfunc_end1-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	80
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc25:
	.xword	.Ltmp151-.Lfunc_begin0
	.xword	.Ltmp166-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp166-.Lfunc_begin0
	.xword	.Ltmp167-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	.Ltmp168-.Lfunc_begin0
	.xword	.Lfunc_end1-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc26:
	.xword	.Ltmp151-.Lfunc_begin0
	.xword	.Ltmp157-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp168-.Lfunc_begin0
	.xword	.Lfunc_end1-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc27:
	.xword	.Ltmp155-.Lfunc_begin0
	.xword	.Ltmp156-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc28:
	.xword	.Lfunc_begin2-.Lfunc_begin0
	.xword	.Ltmp188-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp188-.Lfunc_begin0
	.xword	.Ltmp307-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	80
	.byte	159
	.xword	.Ltmp307-.Lfunc_begin0
	.xword	.Ltmp308-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp308-.Lfunc_begin0
	.xword	.Ltmp310-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	80
	.byte	159
	.xword	.Ltmp310-.Lfunc_begin0
	.xword	.Ltmp311-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp311-.Lfunc_begin0
	.xword	.Ltmp315-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	80
	.byte	159
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp316-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp316-.Lfunc_begin0
	.xword	.Lfunc_end2-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	80
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc29:
	.xword	.Lfunc_begin2-.Lfunc_begin0
	.xword	.Ltmp194-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp203-.Lfunc_begin0
	.xword	.Ltmp210-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp219-.Lfunc_begin0
	.xword	.Ltmp227-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp307-.Lfunc_begin0
	.xword	.Ltmp309-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp309-.Lfunc_begin0
	.xword	.Ltmp310-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp310-.Lfunc_begin0
	.xword	.Ltmp312-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp312-.Lfunc_begin0
	.xword	.Ltmp315-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp317-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp317-.Lfunc_begin0
	.xword	.Ltmp318-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc30:
	.xword	.Ltmp172-.Lfunc_begin0
	.xword	.Ltmp173-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp173-.Lfunc_begin0
	.xword	.Ltmp191-.Lfunc_begin0
	.hword	1
	.byte	94
	.xword	.Ltmp307-.Lfunc_begin0
	.xword	.Ltmp314-.Lfunc_begin0
	.hword	1
	.byte	94
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp317-.Lfunc_begin0
	.hword	1
	.byte	94
	.xword	0
	.xword	0
.Ldebug_loc31:
	.xword	.Ltmp173-.Lfunc_begin0
	.xword	.Ltmp174-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp174-.Lfunc_begin0
	.xword	.Ltmp175-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp180-.Lfunc_begin0
	.xword	.Ltmp181-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp190-.Lfunc_begin0
	.xword	.Ltmp192-.Lfunc_begin0
	.hword	1
	.byte	95
	.xword	0
	.xword	0
.Ldebug_loc32:
	.xword	.Ltmp173-.Lfunc_begin0
	.xword	.Ltmp176-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp176-.Lfunc_begin0
	.xword	.Ltmp179-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp182-.Lfunc_begin0
	.xword	.Ltmp184-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp191-.Lfunc_begin0
	.xword	.Ltmp247-.Lfunc_begin0
	.hword	1
	.byte	94
	.xword	.Ltmp307-.Lfunc_begin0
	.xword	.Ltmp314-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc33:
	.xword	.Ltmp195-.Lfunc_begin0
	.xword	.Ltmp247-.Lfunc_begin0
	.hword	1
	.byte	94
	.xword	0
	.xword	0
.Ldebug_loc34:
	.xword	.Ltmp184-.Lfunc_begin0
	.xword	.Ltmp194-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp196-.Lfunc_begin0
	.xword	.Ltmp202-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp202-.Lfunc_begin0
	.xword	.Ltmp204-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp205-.Lfunc_begin0
	.xword	.Ltmp206-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp206-.Lfunc_begin0
	.xword	.Ltmp207-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp208-.Lfunc_begin0
	.xword	.Ltmp209-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp209-.Lfunc_begin0
	.xword	.Ltmp214-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp214-.Lfunc_begin0
	.xword	.Ltmp218-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp218-.Lfunc_begin0
	.xword	.Ltmp220-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp221-.Lfunc_begin0
	.xword	.Ltmp222-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Ltmp223-.Lfunc_begin0
	.hword	1
	.byte	85
	.xword	.Ltmp225-.Lfunc_begin0
	.xword	.Ltmp227-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp227-.Lfunc_begin0
	.xword	.Ltmp230-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp231-.Lfunc_begin0
	.xword	.Ltmp237-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp237-.Lfunc_begin0
	.xword	.Ltmp238-.Lfunc_begin0
	.hword	1
	.byte	85
	.xword	.Ltmp238-.Lfunc_begin0
	.xword	.Ltmp239-.Lfunc_begin0
	.hword	1
	.byte	103
	.xword	.Ltmp239-.Lfunc_begin0
	.xword	.Ltmp240-.Lfunc_begin0
	.hword	1
	.byte	104
	.xword	.Ltmp241-.Lfunc_begin0
	.xword	.Ltmp242-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp242-.Lfunc_begin0
	.xword	.Ltmp246-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp246-.Lfunc_begin0
	.xword	.Ltmp247-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp253-.Lfunc_begin0
	.xword	.Ltmp254-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp254-.Lfunc_begin0
	.xword	.Ltmp289-.Lfunc_begin0
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
	.xword	.Ltmp289-.Lfunc_begin0
	.xword	.Ltmp293-.Lfunc_begin0
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
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp317-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc35:
	.xword	.Ltmp184-.Lfunc_begin0
	.xword	.Ltmp194-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp196-.Lfunc_begin0
	.xword	.Ltmp211-.Lfunc_begin0
	.hword	1
	.byte	92
	.xword	.Ltmp211-.Lfunc_begin0
	.xword	.Ltmp214-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp214-.Lfunc_begin0
	.xword	.Ltmp228-.Lfunc_begin0
	.hword	1
	.byte	92
	.xword	.Ltmp228-.Lfunc_begin0
	.xword	.Ltmp230-.Lfunc_begin0
	.hword	1
	.byte	84
	.xword	.Ltmp231-.Lfunc_begin0
	.xword	.Ltmp243-.Lfunc_begin0
	.hword	1
	.byte	92
	.xword	.Ltmp243-.Lfunc_begin0
	.xword	.Ltmp246-.Lfunc_begin0
	.hword	1
	.byte	85
	.xword	.Ltmp246-.Lfunc_begin0
	.xword	.Ltmp247-.Lfunc_begin0
	.hword	1
	.byte	92
	.xword	.Ltmp254-.Lfunc_begin0
	.xword	.Ltmp258-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp258-.Lfunc_begin0
	.xword	.Ltmp260-.Lfunc_begin0
	.hword	2
	.byte	50
	.byte	159
	.xword	.Ltmp260-.Lfunc_begin0
	.xword	.Ltmp262-.Lfunc_begin0
	.hword	2
	.byte	52
	.byte	159
	.xword	.Ltmp262-.Lfunc_begin0
	.xword	.Ltmp264-.Lfunc_begin0
	.hword	2
	.byte	54
	.byte	159
	.xword	.Ltmp264-.Lfunc_begin0
	.xword	.Ltmp266-.Lfunc_begin0
	.hword	2
	.byte	56
	.byte	159
	.xword	.Ltmp266-.Lfunc_begin0
	.xword	.Ltmp268-.Lfunc_begin0
	.hword	2
	.byte	58
	.byte	159
	.xword	.Ltmp268-.Lfunc_begin0
	.xword	.Ltmp270-.Lfunc_begin0
	.hword	2
	.byte	60
	.byte	159
	.xword	.Ltmp270-.Lfunc_begin0
	.xword	.Ltmp272-.Lfunc_begin0
	.hword	2
	.byte	62
	.byte	159
	.xword	.Ltmp272-.Lfunc_begin0
	.xword	.Ltmp274-.Lfunc_begin0
	.hword	2
	.byte	64
	.byte	159
	.xword	.Ltmp274-.Lfunc_begin0
	.xword	.Ltmp276-.Lfunc_begin0
	.hword	2
	.byte	66
	.byte	159
	.xword	.Ltmp276-.Lfunc_begin0
	.xword	.Ltmp278-.Lfunc_begin0
	.hword	2
	.byte	68
	.byte	159
	.xword	.Ltmp278-.Lfunc_begin0
	.xword	.Ltmp280-.Lfunc_begin0
	.hword	2
	.byte	70
	.byte	159
	.xword	.Ltmp280-.Lfunc_begin0
	.xword	.Ltmp282-.Lfunc_begin0
	.hword	2
	.byte	72
	.byte	159
	.xword	.Ltmp282-.Lfunc_begin0
	.xword	.Ltmp284-.Lfunc_begin0
	.hword	2
	.byte	74
	.byte	159
	.xword	.Ltmp284-.Lfunc_begin0
	.xword	.Ltmp286-.Lfunc_begin0
	.hword	2
	.byte	76
	.byte	159
	.xword	.Ltmp286-.Lfunc_begin0
	.xword	.Ltmp289-.Lfunc_begin0
	.hword	2
	.byte	78
	.byte	159
	.xword	.Ltmp289-.Lfunc_begin0
	.xword	.Ltmp294-.Lfunc_begin0
	.hword	3
	.byte	16
	.byte	32
	.byte	159
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp317-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc36:
	.xword	.Ltmp184-.Lfunc_begin0
	.xword	.Ltmp194-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp196-.Lfunc_begin0
	.xword	.Ltmp213-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp214-.Lfunc_begin0
	.xword	.Ltmp230-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp231-.Lfunc_begin0
	.xword	.Ltmp245-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp246-.Lfunc_begin0
	.xword	.Ltmp307-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp317-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc37:
	.xword	.Ltmp184-.Lfunc_begin0
	.xword	.Ltmp194-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp196-.Lfunc_begin0
	.xword	.Ltmp209-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp214-.Lfunc_begin0
	.xword	.Ltmp226-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp231-.Lfunc_begin0
	.xword	.Ltmp247-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp317-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc38:
	.xword	.Ltmp184-.Lfunc_begin0
	.xword	.Ltmp194-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp201-.Lfunc_begin0
	.xword	.Ltmp214-.Lfunc_begin0
	.hword	1
	.byte	83
	.xword	.Ltmp217-.Lfunc_begin0
	.xword	.Ltmp224-.Lfunc_begin0
	.hword	1
	.byte	83
	.xword	.Ltmp255-.Lfunc_begin0
	.xword	.Ltmp294-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp317-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc39:
	.xword	.Ltmp184-.Lfunc_begin0
	.xword	.Ltmp194-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp233-.Lfunc_begin0
	.xword	.Ltmp246-.Lfunc_begin0
	.hword	1
	.byte	84
	.xword	.Ltmp250-.Lfunc_begin0
	.xword	.Ltmp252-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp252-.Lfunc_begin0
	.xword	.Ltmp294-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp296-.Lfunc_begin0
	.xword	.Ltmp304-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp317-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc40:
	.xword	.Ltmp184-.Lfunc_begin0
	.xword	.Ltmp193-.Lfunc_begin0
	.hword	2
	.byte	49
	.byte	159
	.xword	.Ltmp214-.Lfunc_begin0
	.xword	.Ltmp215-.Lfunc_begin0
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
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp317-.Lfunc_begin0
	.hword	2
	.byte	49
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc41:
	.xword	.Ltmp184-.Lfunc_begin0
	.xword	.Ltmp193-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp193-.Lfunc_begin0
	.xword	.Ltmp194-.Lfunc_begin0
	.hword	1
	.byte	95
	.xword	.Ltmp195-.Lfunc_begin0
	.xword	.Ltmp247-.Lfunc_begin0
	.hword	1
	.byte	95
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp317-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc42:
	.xword	.Lfunc_begin3-.Lfunc_begin0
	.xword	.Ltmp323-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp324-.Lfunc_begin0
	.xword	.Ltmp325-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp325-.Lfunc_begin0
	.xword	.Lfunc_end3-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc43:
	.xword	.Ltmp320-.Lfunc_begin0
	.xword	.Ltmp321-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp321-.Lfunc_begin0
	.xword	.Lfunc_end3-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc44:
	.xword	.Lfunc_begin4-.Lfunc_begin0
	.xword	.Ltmp333-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp333-.Lfunc_begin0
	.xword	.Ltmp335-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp336-.Lfunc_begin0
	.xword	.Lfunc_end4-.Lfunc_begin0
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
	.byte	5
	.byte	87
	.byte	11
	.byte	0
	.byte	0
	.byte	17
	.ascii	"\211\202\001"
	.byte	1
	.byte	49
	.byte	19
	.byte	17
	.byte	1
	.byte	0
	.byte	0
	.byte	18
	.ascii	"\212\202\001"
	.byte	0
	.byte	2
	.byte	24
	.ascii	"\221B"
	.byte	24
	.byte	0
	.byte	0
	.byte	19
	.ascii	"\211\202\001"
	.byte	0
	.byte	49
	.byte	19
	.byte	17
	.byte	1
	.byte	0
	.byte	0
	.byte	20
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
	.byte	21
	.byte	40
	.byte	0
	.byte	3
	.byte	14
	.byte	28
	.byte	15
	.byte	0
	.byte	0
	.byte	22
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
	.byte	23
	.byte	15
	.byte	0
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	24
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
	.byte	25
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
	.byte	26
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
	.byte	27
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
	.byte	28
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
	.byte	29
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
	.byte	30
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
	.byte	31
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
	.byte	32
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
	.byte	52
	.byte	0
	.byte	28
	.byte	15
	.byte	49
	.byte	19
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
	.word	.Lfunc_end4-.Lfunc_begin0
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
	.byte	8
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

	.word	.Linfo_string88
	.byte	3
	.hword	294

	.word	713

	.byte	10
	.word	.Linfo_string8
	.word	615
	.byte	3
	.hword	296
	.byte	9
	.byte	3
	.xword	pvi_wf_get_lut.stype
	.byte	10
	.word	.Linfo_string24
	.word	713
	.byte	3
	.hword	297
	.byte	9
	.byte	3
	.xword	pvi_wf_get_lut.sftemp
	.byte	11
	.word	.Ldebug_loc0
	.word	.Linfo_string93
	.byte	3
	.hword	294
	.word	2040
	.byte	11
	.word	.Ldebug_loc1
	.word	.Linfo_string95
	.byte	3
	.hword	294
	.word	615
	.byte	11
	.word	.Ldebug_loc2
	.word	.Linfo_string57
	.byte	3
	.hword	294
	.word	713
	.byte	11
	.word	.Ldebug_loc3
	.word	.Linfo_string96
	.byte	3
	.hword	294
	.word	713
	.byte	12
	.word	.Ldebug_loc4
	.word	.Linfo_string97
	.byte	3
	.hword	301
	.word	615
	.byte	12
	.word	.Ldebug_loc5
	.word	.Linfo_string69
	.byte	3
	.hword	300
	.word	713
	.byte	12
	.word	.Ldebug_loc6
	.word	.Linfo_string98
	.byte	3
	.hword	299
	.word	713
	.byte	12
	.word	.Ldebug_loc7
	.word	.Linfo_string99
	.byte	3
	.hword	298
	.word	713
	.byte	13
	.word	1330
	.word	.Ldebug_ranges0
	.byte	3
	.hword	319
	.byte	16
	.byte	14
	.word	.Ldebug_loc11
	.word	1342
	.byte	15
	.word	.Ldebug_loc8
	.word	1353
	.byte	15
	.word	.Ldebug_loc9
	.word	1364
	.byte	15
	.word	.Ldebug_loc10
	.word	1375
	.byte	0
	.byte	13
	.word	1387
	.word	.Ldebug_ranges1
	.byte	3
	.hword	328
	.byte	4
	.byte	14
	.word	.Ldebug_loc12
	.word	1399
	.byte	14
	.word	.Ldebug_loc13
	.word	1410
	.byte	15
	.word	.Ldebug_loc14
	.word	1421
	.byte	15
	.word	.Ldebug_loc15
	.word	1432
	.byte	0
	.byte	13
	.word	1444
	.word	.Ldebug_ranges2
	.byte	3
	.hword	330
	.byte	4
	.byte	14
	.word	.Ldebug_loc16
	.word	1457
	.byte	14
	.word	.Ldebug_loc17
	.word	1469
	.byte	15
	.word	.Ldebug_loc18
	.word	1481
	.byte	15
	.word	.Ldebug_loc19
	.word	1493
	.byte	0
	.byte	16
	.word	1330
	.xword	.Ltmp128
	.word	.Ltmp140-.Ltmp128
	.byte	3
	.hword	341
	.byte	16
	.byte	14
	.word	.Ldebug_loc20
	.word	1342
	.byte	15
	.word	.Ldebug_loc21
	.word	1353
	.byte	15
	.word	.Ldebug_loc22
	.word	1364
	.byte	15
	.word	.Ldebug_loc23
	.word	1375
	.byte	0
	.byte	17
	.word	1506
	.xword	.Ltmp28
	.byte	18
	.byte	1
	.byte	80
	.byte	2
	.byte	133
	.byte	0
	.byte	0
	.byte	17
	.word	1605
	.xword	.Ltmp30
	.byte	18
	.byte	1
	.byte	81
	.byte	2
	.byte	134
	.byte	0
	.byte	0
	.byte	19
	.word	1800
	.xword	.Ltmp128
	.byte	19
	.word	1506
	.xword	.Ltmp141
	.byte	17
	.word	1605
	.xword	.Ltmp143
	.byte	18
	.byte	1
	.byte	81
	.byte	2
	.byte	133
	.byte	0
	.byte	0
	.byte	0
	.byte	20
	.word	706
	.word	.Linfo_string23
	.byte	4
	.byte	4
	.byte	15
	.byte	21
	.word	.Linfo_string10
	.byte	0
	.byte	21
	.word	.Linfo_string11
	.byte	1
	.byte	21
	.word	.Linfo_string12
	.byte	2
	.byte	21
	.word	.Linfo_string13
	.byte	3
	.byte	21
	.word	.Linfo_string14
	.byte	4
	.byte	21
	.word	.Linfo_string15
	.byte	5
	.byte	21
	.word	.Linfo_string16
	.byte	6
	.byte	21
	.word	.Linfo_string17
	.byte	7
	.byte	21
	.word	.Linfo_string18
	.byte	8
	.byte	21
	.word	.Linfo_string19
	.byte	9
	.byte	21
	.word	.Linfo_string20
	.byte	10
	.byte	21
	.word	.Linfo_string21
	.byte	11
	.byte	21
	.word	.Linfo_string22
	.byte	12
	.byte	0
	.byte	7
	.word	.Linfo_string9
	.byte	7
	.byte	4
	.byte	7
	.word	.Linfo_string25
	.byte	5
	.byte	4
	.byte	9
	.xword	.Lfunc_begin4
	.word	.Lfunc_end4-.Lfunc_begin4
	.byte	1
	.byte	111

	.word	.Linfo_string92
	.byte	3
	.hword	403

	.word	1310

	.byte	10
	.word	.Linfo_string26
	.word	785
	.byte	3
	.hword	406
	.byte	9
	.byte	3
	.xword	pvi_wf_get_version.spi_id_buffer
	.byte	12
	.word	.Ldebug_loc44
	.word	.Linfo_string75
	.byte	3
	.hword	405
	.word	1310
	.byte	0
	.byte	3
	.word	797
	.byte	4
	.word	115
	.byte	32
	.byte	0
	.byte	7
	.word	.Linfo_string27
	.byte	8
	.byte	1
	.byte	22
	.word	.Linfo_string28
	.word	825
	.byte	3
	.byte	40
	.byte	9
	.byte	3
	.xword	waveformdata
	.byte	23
	.word	86
	.byte	22
	.word	.Linfo_string29
	.word	851
	.byte	3
	.byte	42
	.byte	9
	.byte	3
	.xword	global_waveform
	.byte	23
	.word	856
	.byte	24
	.word	.Linfo_string58
	.byte	52
	.byte	3
	.byte	13
	.byte	25
	.word	.Linfo_string30
	.word	1141
	.byte	3
	.byte	14
	.byte	0
	.byte	25
	.word	.Linfo_string33
	.word	1141
	.byte	3
	.byte	15
	.byte	4
	.byte	25
	.word	.Linfo_string34
	.word	1141
	.byte	3
	.byte	16
	.byte	8
	.byte	25
	.word	.Linfo_string35
	.word	86
	.byte	3
	.byte	17
	.byte	12
	.byte	25
	.word	.Linfo_string36
	.word	86
	.byte	3
	.byte	18
	.byte	13
	.byte	25
	.word	.Linfo_string37
	.word	1163
	.byte	3
	.byte	19
	.byte	14
	.byte	25
	.word	.Linfo_string41
	.word	86
	.byte	3
	.byte	20
	.byte	16
	.byte	25
	.word	.Linfo_string42
	.word	86
	.byte	3
	.byte	21
	.byte	17
	.byte	25
	.word	.Linfo_string43
	.word	86
	.byte	3
	.byte	22
	.byte	18
	.byte	25
	.word	.Linfo_string44
	.word	86
	.byte	3
	.byte	23
	.byte	19
	.byte	25
	.word	.Linfo_string45
	.word	86
	.byte	3
	.byte	24
	.byte	20
	.byte	25
	.word	.Linfo_string46
	.word	86
	.byte	3
	.byte	25
	.byte	21
	.byte	25
	.word	.Linfo_string47
	.word	86
	.byte	3
	.byte	26
	.byte	22
	.byte	25
	.word	.Linfo_string48
	.word	86
	.byte	3
	.byte	27
	.byte	23
	.byte	25
	.word	.Linfo_string49
	.word	1141
	.byte	3
	.byte	28
	.byte	24
	.byte	25
	.word	.Linfo_string50
	.word	86
	.byte	3
	.byte	29
	.byte	28
	.byte	25
	.word	.Linfo_string51
	.word	1192
	.byte	3
	.byte	30
	.byte	29
	.byte	25
	.word	.Linfo_string52
	.word	86
	.byte	3
	.byte	31
	.byte	32
	.byte	25
	.word	.Linfo_string53
	.word	1204
	.byte	3
	.byte	32
	.byte	33
	.byte	25
	.word	.Linfo_string54
	.word	86
	.byte	3
	.byte	33
	.byte	37
	.byte	25
	.word	.Linfo_string55
	.word	86
	.byte	3
	.byte	34
	.byte	38
	.byte	25
	.word	.Linfo_string56
	.word	1216
	.byte	3
	.byte	35
	.byte	39
	.byte	25
	.word	.Linfo_string57
	.word	1228
	.byte	3
	.byte	36
	.byte	48
	.byte	0
	.byte	6
	.word	1152
	.word	.Linfo_string32
	.byte	2
	.byte	21
	.byte	6
	.word	706
	.word	.Linfo_string31
	.byte	1
	.byte	27
	.byte	6
	.word	1174
	.word	.Linfo_string40
	.byte	2
	.byte	19
	.byte	6
	.word	1185
	.word	.Linfo_string39
	.byte	1
	.byte	24
	.byte	7
	.word	.Linfo_string38
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
	.byte	22
	.word	.Linfo_string59
	.word	713
	.byte	3
	.byte	43
	.byte	9
	.byte	3
	.xword	need_pic
	.byte	22
	.word	.Linfo_string60
	.word	713
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
	.byte	26
	.word	706
	.byte	4
	.byte	5
	.byte	10
	.byte	21
	.word	.Linfo_string61
	.byte	0
	.byte	21
	.word	.Linfo_string62
	.byte	1
	.byte	0
	.byte	23
	.word	1315
	.byte	5
	.word	797
	.byte	23
	.word	108
	.byte	23
	.word	713
	.byte	27
	.word	.Linfo_string63
	.byte	3
	.byte	199

	.word	713
	.byte	1
	.byte	28
	.word	.Linfo_string57
	.byte	3
	.byte	199
	.word	713
	.byte	29
	.word	.Linfo_string64
	.byte	3
	.byte	201
	.word	713
	.byte	29
	.word	.Linfo_string65
	.byte	3
	.byte	203
	.word	713
	.byte	29
	.word	.Linfo_string66
	.byte	3
	.byte	202
	.word	713
	.byte	0
	.byte	27
	.word	.Linfo_string67
	.byte	3
	.byte	242

	.word	713
	.byte	1
	.byte	28
	.word	.Linfo_string68
	.byte	3
	.byte	242
	.word	825
	.byte	28
	.word	.Linfo_string69
	.byte	3
	.byte	242
	.word	713
	.byte	29
	.word	.Linfo_string70
	.byte	3
	.byte	245
	.word	825
	.byte	29
	.word	.Linfo_string71
	.byte	3
	.byte	244
	.word	713
	.byte	0
	.byte	30
	.word	.Linfo_string72
	.byte	3
	.hword	268

	.word	713
	.byte	1
	.byte	31
	.word	.Linfo_string68
	.byte	3
	.hword	268
	.word	825
	.byte	31
	.word	.Linfo_string69
	.byte	3
	.hword	268
	.word	713
	.byte	32
	.word	.Linfo_string70
	.byte	3
	.hword	271
	.word	825
	.byte	32
	.word	.Linfo_string71
	.byte	3
	.hword	270
	.word	713
	.byte	0
	.byte	33
	.xword	.Lfunc_begin1
	.word	.Lfunc_end1-.Lfunc_begin1
	.byte	1
	.byte	109

	.word	.Linfo_string89
	.byte	3
	.byte	181

	.word	86
	.byte	34
	.word	.Ldebug_loc24
	.word	.Linfo_string95
	.byte	3
	.byte	181
	.word	615
	.byte	35
	.word	.Ldebug_loc25
	.word	.Linfo_string76
	.byte	3
	.byte	183
	.word	1846
	.byte	35
	.word	.Ldebug_loc26
	.word	.Linfo_string100
	.byte	3
	.byte	184
	.word	713
	.byte	36
	.word	1811
	.word	.Ldebug_ranges3
	.byte	3
	.byte	194
	.byte	14
	.byte	14
	.word	.Ldebug_loc27
	.word	1823
	.byte	37
	.byte	0
	.word	1834
	.byte	0
	.byte	0
	.byte	33
	.xword	.Lfunc_begin2
	.word	.Lfunc_end2-.Lfunc_begin2
	.byte	1
	.byte	109

	.word	.Linfo_string90
	.byte	3
	.byte	218

	.word	713
	.byte	34
	.word	.Ldebug_loc28
	.word	.Linfo_string100
	.byte	3
	.byte	218
	.word	713
	.byte	34
	.word	.Ldebug_loc29
	.word	.Linfo_string99
	.byte	3
	.byte	218
	.word	713
	.byte	35
	.word	.Ldebug_loc30
	.word	.Linfo_string75
	.byte	3
	.byte	220
	.word	1320
	.byte	35
	.word	.Ldebug_loc31
	.word	.Linfo_string82
	.byte	3
	.byte	222
	.word	713
	.byte	35
	.word	.Ldebug_loc32
	.word	.Linfo_string101
	.byte	3
	.byte	221
	.word	1320
	.byte	36
	.word	1851
	.word	.Ldebug_ranges4
	.byte	3
	.byte	239
	.byte	9
	.byte	14
	.word	.Ldebug_loc33
	.word	1863
	.byte	15
	.word	.Ldebug_loc34
	.word	1874
	.byte	15
	.word	.Ldebug_loc35
	.word	1885
	.byte	15
	.word	.Ldebug_loc36
	.word	1896
	.byte	15
	.word	.Ldebug_loc37
	.word	1907
	.byte	15
	.word	.Ldebug_loc38
	.word	1918
	.byte	15
	.word	.Ldebug_loc39
	.word	1929
	.byte	15
	.word	.Ldebug_loc40
	.word	1940
	.byte	15
	.word	.Ldebug_loc41
	.word	1951
	.byte	0
	.byte	0
	.byte	38
	.word	.Linfo_string73
	.byte	4
	.byte	47

	.word	713


	.byte	27
	.word	.Linfo_string74
	.byte	3
	.byte	164

	.word	1846
	.byte	1
	.byte	28
	.word	.Linfo_string75
	.byte	3
	.byte	164
	.word	851
	.byte	29
	.word	.Linfo_string76
	.byte	3
	.byte	166
	.word	1846
	.byte	0
	.byte	23
	.word	81
	.byte	27
	.word	.Linfo_string77
	.byte	3
	.byte	45

	.word	713
	.byte	1
	.byte	28
	.word	.Linfo_string78
	.byte	3
	.byte	45
	.word	1320
	.byte	29
	.word	.Linfo_string79
	.byte	3
	.byte	47
	.word	706
	.byte	29
	.word	.Linfo_string80
	.byte	3
	.byte	47
	.word	706
	.byte	29
	.word	.Linfo_string81
	.byte	3
	.byte	48
	.word	706
	.byte	29
	.word	.Linfo_string82
	.byte	3
	.byte	49
	.word	706
	.byte	29
	.word	.Linfo_string83
	.byte	3
	.byte	50
	.word	108
	.byte	29
	.word	.Linfo_string65
	.byte	3
	.byte	51
	.word	108
	.byte	29
	.word	.Linfo_string84
	.byte	3
	.byte	52
	.word	1963
	.byte	29
	.word	.Linfo_string87
	.byte	3
	.byte	53
	.word	713
	.byte	0
	.byte	6
	.word	1974
	.word	.Linfo_string86
	.byte	6
	.byte	30
	.byte	7
	.word	.Linfo_string85
	.byte	2
	.byte	1
	.byte	9
	.xword	.Lfunc_begin3
	.word	.Lfunc_end3-.Lfunc_begin3
	.byte	1
	.byte	109

	.word	.Linfo_string91
	.byte	3
	.hword	362

	.word	713

	.byte	11
	.word	.Ldebug_loc42
	.word	.Linfo_string102
	.byte	3
	.hword	362
	.word	2107
	.byte	12
	.word	.Ldebug_loc43
	.word	.Linfo_string103
	.byte	3
	.hword	364
	.word	851
	.byte	0
	.byte	23
	.word	2045
	.byte	24
	.word	.Linfo_string94
	.byte	32
	.byte	4
	.byte	32
	.byte	25
	.word	.Linfo_string69
	.word	706
	.byte	4
	.byte	33
	.byte	0
	.byte	25
	.word	.Linfo_string78
	.word	2090
	.byte	4
	.byte	34
	.byte	8
	.byte	25
	.word	.Linfo_string68
	.word	2095
	.byte	4
	.byte	35
	.byte	16
	.byte	0
	.byte	23
	.word	706
	.byte	3
	.word	825
	.byte	4
	.word	115
	.byte	2
	.byte	0
	.byte	39
	.byte	0
.Ldebug_info_end0:
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.xword	.Ltmp11-.Lfunc_begin0
	.xword	.Ltmp12-.Lfunc_begin0
	.xword	.Ltmp13-.Lfunc_begin0
	.xword	.Ltmp19-.Lfunc_begin0
	.xword	.Ltmp26-.Lfunc_begin0
	.xword	.Ltmp27-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges1:
	.xword	.Ltmp33-.Lfunc_begin0
	.xword	.Ltmp35-.Lfunc_begin0
	.xword	.Ltmp36-.Lfunc_begin0
	.xword	.Ltmp55-.Lfunc_begin0
	.xword	.Ltmp70-.Lfunc_begin0
	.xword	.Ltmp91-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges2:
	.xword	.Ltmp56-.Lfunc_begin0
	.xword	.Ltmp58-.Lfunc_begin0
	.xword	.Ltmp59-.Lfunc_begin0
	.xword	.Ltmp69-.Lfunc_begin0
	.xword	.Ltmp91-.Lfunc_begin0
	.xword	.Ltmp121-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges3:
	.xword	.Ltmp155-.Lfunc_begin0
	.xword	.Ltmp156-.Lfunc_begin0
	.xword	.Ltmp157-.Lfunc_begin0
	.xword	.Ltmp158-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges4:
	.xword	.Ltmp184-.Lfunc_begin0
	.xword	.Ltmp189-.Lfunc_begin0
	.xword	.Ltmp195-.Lfunc_begin0
	.xword	.Ltmp307-.Lfunc_begin0
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp317-.Lfunc_begin0
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
	.asciz	"WF_TYPE_MAX"
.Linfo_string22:
	.asciz	"WF_TYPE_GRAY16"
.Linfo_string23:
	.asciz	"epd_lut_type"
.Linfo_string24:
	.asciz	"sftemp"
.Linfo_string25:
	.asciz	"int"
.Linfo_string26:
	.asciz	"spi_id_buffer"
.Linfo_string27:
	.asciz	"char"
.Linfo_string28:
	.asciz	"waveformdata"
.Linfo_string29:
	.asciz	"global_waveform"
.Linfo_string30:
	.asciz	"checksum"
.Linfo_string31:
	.asciz	"__u32"
.Linfo_string32:
	.asciz	"u32"
.Linfo_string33:
	.asciz	"file_length"
.Linfo_string34:
	.asciz	"serial"
.Linfo_string35:
	.asciz	"run_type"
.Linfo_string36:
	.asciz	"fpl_platform"
.Linfo_string37:
	.asciz	"fpl_lot"
.Linfo_string38:
	.asciz	"unsigned short"
.Linfo_string39:
	.asciz	"__u16"
.Linfo_string40:
	.asciz	"u16"
.Linfo_string41:
	.asciz	"mode_version"
.Linfo_string42:
	.asciz	"wf_version"
.Linfo_string43:
	.asciz	"wf_subversion"
.Linfo_string44:
	.asciz	"wf_type"
.Linfo_string45:
	.asciz	"panel_size"
.Linfo_string46:
	.asciz	"amepd_part_number"
.Linfo_string47:
	.asciz	"wfm_rev"
.Linfo_string48:
	.asciz	"frame_rate"
.Linfo_string49:
	.asciz	"reserved"
.Linfo_string50:
	.asciz	"vcom_offset"
.Linfo_string51:
	.asciz	"xwia"
.Linfo_string52:
	.asciz	"sc1"
.Linfo_string53:
	.asciz	"unknown1"
.Linfo_string54:
	.asciz	"modenumber"
.Linfo_string55:
	.asciz	"temperaturenumber"
.Linfo_string56:
	.asciz	"unknown2"
.Linfo_string57:
	.asciz	"temperture"
.Linfo_string58:
	.asciz	"pvi_waveform"
.Linfo_string59:
	.asciz	"need_pic"
.Linfo_string60:
	.asciz	"maxpic"
.Linfo_string61:
	.asciz	"false"
.Linfo_string62:
	.asciz	"true"
.Linfo_string63:
	.asciz	"get_wf_temp_index"
.Linfo_string64:
	.asciz	"temp_num"
.Linfo_string65:
	.asciz	"i"
.Linfo_string66:
	.asciz	"level"
.Linfo_string67:
	.asciz	"pvi_wf_a2_repair"
.Linfo_string68:
	.asciz	"wf_table"
.Linfo_string69:
	.asciz	"frame_num"
.Linfo_string70:
	.asciz	"table"
.Linfo_string71:
	.asciz	"f"
.Linfo_string72:
	.asciz	"pvi_wf_gray2_repair"
.Linfo_string73:
	.asciz	"epd_overlay_lut"
.Linfo_string74:
	.asciz	"parse_mode_version"
.Linfo_string75:
	.asciz	"waveform"
.Linfo_string76:
	.asciz	"pvi_modes"
.Linfo_string77:
	.asciz	"decodewaveform"
.Linfo_string78:
	.asciz	"data"
.Linfo_string79:
	.asciz	"oldpic"
.Linfo_string80:
	.asciz	"newpic"
.Linfo_string81:
	.asciz	"frame_tmp"
.Linfo_string82:
	.asciz	"offset"
.Linfo_string83:
	.asciz	"tempdata"
.Linfo_string84:
	.asciz	"israr"
.Linfo_string85:
	.asciz	"_Bool"
.Linfo_string86:
	.asciz	"bool"
.Linfo_string87:
	.asciz	"shift_n"
.Linfo_string88:
	.asciz	"pvi_wf_get_lut"
.Linfo_string89:
	.asciz	"get_wf_mode_index"
.Linfo_string90:
	.asciz	"get_wf_frm_num"
.Linfo_string91:
	.asciz	"pvi_wf_input"
.Linfo_string92:
	.asciz	"pvi_wf_get_version"
.Linfo_string93:
	.asciz	"output"
.Linfo_string94:
	.asciz	"epd_lut_data"
.Linfo_string95:
	.asciz	"lut_type"
.Linfo_string96:
	.asciz	"pic"
.Linfo_string97:
	.asciz	"overlay_lut"
.Linfo_string98:
	.asciz	"mode_index"
.Linfo_string99:
	.asciz	"temp_index"
.Linfo_string100:
	.asciz	"mode"
.Linfo_string101:
	.asciz	"wf_data"
.Linfo_string102:
	.asciz	"waveform_file"
.Linfo_string103:
	.asciz	"pvi_wf"
	.ident	"Android (8508608, based on r450784e) clang version 14.0.7 (https://android.googlesource.com/toolchain/llvm-project 4c603efb0cca074e9238af8b4106c30add4418f6)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym pvi_wf_get_version.spi_id_buffer
	.section	.debug_line,"",@progbits
.Lline_table_start0:
