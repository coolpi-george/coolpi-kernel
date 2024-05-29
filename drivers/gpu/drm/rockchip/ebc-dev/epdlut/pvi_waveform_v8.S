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
	.loc	3 310 0
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
	.loc	3 318 7 prologue_end
	adrp	x24, global_waveform
	ldr	x8, [x24, :lo12:global_waveform]
.Ltmp1:
	.loc	3 318 6 is_stmt 0
	cbz	x8, .LBB0_10
.Ltmp2:
	.loc	3 0 6
	mov	w19, w2
.Ltmp3:
	mov	w21, w1
.Ltmp4:
	mov	x20, x0
.Ltmp5:
	.loc	3 321 14 is_stmt 1
	cbnz	x0, .LBB0_3
.Ltmp6:
	.loc	3 0 14 is_stmt 0
	mov	w9, #16
	.loc	3 321 18
	ldr	x9, [x9]
.Ltmp7:
	.loc	3 321 6
	cbz	x9, .LBB0_11
.Ltmp8:
.LBB0_3:
	.loc	3 326 28 is_stmt 1
	adrp	x23, pvi_wf_get_lut.sftemp
	.loc	3 326 19 is_stmt 0
	mov	w9, #21846
	movk	w9, #21845, lsl #16
	adrp	x26, pvi_wf_get_lut.stype
	.loc	3 326 28
	ldrsw	x10, [x23, :lo12:pvi_wf_get_lut.sftemp]
	.loc	3 326 19
	smull	x11, w19, w9
	ldr	w13, [x26, :lo12:pvi_wf_get_lut.stype]
	.loc	3 326 35
	mul	x9, x10, x9
	.loc	3 326 19
	lsr	x10, x11, #63
	lsr	x11, x11, #32
	.loc	3 326 35
	lsr	x12, x9, #63
	lsr	x9, x9, #32
	.loc	3 326 19
	add	w25, w11, w10
	.loc	3 326 35
	add	w9, w9, w12
	.loc	3 326 41
	cmp	w25, w9
	ccmp	w13, w21, #0, eq
	b.eq	.LBB0_107
.Ltmp9:
	.loc	3 329 11 is_stmt 1
	adrp	x10, need_pic
	.loc	3 331 6
	cmp	w21, #10
	.loc	3 329 11
	str	w3, [x10, :lo12:need_pic]
	.loc	3 331 6
	b.eq	.LBB0_106
.Ltmp10:
	.loc	3 333 18
	ldr	x10, [x20, #16]
	.loc	3 333 16 is_stmt 0
	adrp	x11, waveformdata
.Ltmp11:
	.loc	3 203 34 is_stmt 1
	ldrb	w9, [x8, #38]
.Ltmp12:
	.loc	3 333 16
	str	x10, [x11, :lo12:waveformdata]
.Ltmp13:
	.loc	3 207 2
	cbz	w9, .LBB0_12
.Ltmp14:
	.loc	3 0 2 is_stmt 0
	mov	x10, xzr
	.loc	3 207 2
	add	x11, x8, #48
.Ltmp15:
.LBB0_7:
	.loc	3 208 21 is_stmt 1
	ldrb	w12, [x11, x10]
.Ltmp16:
	.loc	3 208 7 is_stmt 0
	cmp	w12, w19
	b.ge	.LBB0_13
.Ltmp17:
	.loc	3 207 29 is_stmt 1
	add	x10, x10, #1
.Ltmp18:
	.loc	3 207 2 is_stmt 0
	cmp	x9, x10
	b.ne	.LBB0_7
.Ltmp19:
	.loc	3 0 2
	mov	w11, #-1
	mov	w10, w9
.Ltmp20:
	b	.LBB0_14
.Ltmp21:
.LBB0_10:
	mov	w0, #-19
.Ltmp22:
	b	.LBB0_130
.Ltmp23:
.LBB0_11:
	mov	w0, #-22
	b	.LBB0_130
.Ltmp24:
.LBB0_12:
	mov	w10, wzr
	mov	w11, #-1
	b	.LBB0_14
.Ltmp25:
.LBB0_13:
	mov	w11, w10
.Ltmp26:
.LBB0_14:
	sub	w12, w10, #1
	.loc	3 214 6 is_stmt 1
	cmp	w10, w9
	csel	w22, w12, w11, eq
.Ltmp27:
	.loc	3 188 6
	cmp	w21, #11
	b.hs	.LBB0_58
.Ltmp28:
	.loc	3 168 20
	ldrb	w10, [x8, #16]
.Ltmp29:
	.loc	3 191 13
	mov	w8, w21
.Ltmp30:
	.loc	3 168 2
	sub	w9, w10, #9
	cmp	w9, #75
	b.hi	.LBB0_18
.Ltmp31:
	.loc	3 0 2 is_stmt 0
	adrp	x10, .LJTI0_0
	add	x10, x10, :lo12:.LJTI0_0
	adr	x11, .LBB0_17
	ldrb	w12, [x10, x9]
	add	x11, x11, x12, lsl #2
	adrp	x9, pvi_mode_table
	add	x9, x9, :lo12:pvi_mode_table
	br	x11
.Ltmp32:
.LBB0_17:
	adrp	x9, pvi_mode_table+30
	add	x9, x9, :lo12:pvi_mode_table+30
.Ltmp33:
	b	.LBB0_26
.Ltmp34:
.LBB0_18:
	.loc	3 168 2
	cmp	w10, #114
	b.ne	.LBB0_20
.Ltmp35:
	.loc	3 0 2
	adrp	x9, pvi_mode_table+70
	add	x9, x9, :lo12:pvi_mode_table+70
	b	.LBB0_26
.Ltmp36:
.LBB0_20:
	adrp	x9, pvi_mode_table+80
	add	x9, x9, :lo12:pvi_mode_table+80
	b	.LBB0_26
.Ltmp37:
.LBB0_21:
	adrp	x9, pvi_mode_table+10
	add	x9, x9, :lo12:pvi_mode_table+10
	b	.LBB0_26
.Ltmp38:
.LBB0_22:
	adrp	x9, pvi_mode_table+20
	add	x9, x9, :lo12:pvi_mode_table+20
	b	.LBB0_26
.Ltmp39:
.LBB0_23:
	adrp	x9, pvi_mode_table+40
	add	x9, x9, :lo12:pvi_mode_table+40
	b	.LBB0_26
.Ltmp40:
.LBB0_24:
	adrp	x9, pvi_mode_table+50
	add	x9, x9, :lo12:pvi_mode_table+50
	b	.LBB0_26
.Ltmp41:
.LBB0_25:
	adrp	x9, pvi_mode_table+60
	add	x9, x9, :lo12:pvi_mode_table+60
.Ltmp42:
.LBB0_26:
	.loc	3 198 9 is_stmt 1
	ldrb	w0, [x9, x8]
.Ltmp43:
.LBB0_27:
	.loc	3 336 15
	mov	w1, w22
	bl	get_wf_frm_num
.Ltmp44:
	.loc	3 337 7
	tbnz	w0, #31, .LBB0_131
.Ltmp45:
	.loc	3 342 7
	cmp	w21, #1
	b.eq	.LBB0_37
.Ltmp46:
	cmp	w21, #6
	b.eq	.LBB0_43
.Ltmp47:
	cmp	w21, #7
	b.ne	.LBB0_105
.Ltmp48:
	.loc	3 249 2
	cbz	w0, .LBB0_105
.Ltmp49:
	.loc	3 249 16 is_stmt 0
	mov	w10, w0
	mov	x9, xzr
.Ltmp50:
	.loc	3 0 0
	ldr	x8, [x20, #16]
.Ltmp51:
	.loc	3 249 2
	lsl	x10, x10, #10
.Ltmp52:
.LBB0_33:
	.loc	3 250 20 is_stmt 1
	add	x11, x8, w9, sxtw
.Ltmp53:
	.loc	3 249 16
	add	x9, x9, #1024
.Ltmp54:
	.loc	3 249 2 is_stmt 0
	cmp	x10, x9
.Ltmp55:
	.loc	3 251 38 is_stmt 1
	ldrb	w12, [x11, #960]
	.loc	3 253 38
	ldrb	w13, [x11, #30]
	.loc	3 251 36
	strb	w12, [x11, #992]
	.loc	3 252 36
	strb	w12, [x11, #928]
	.loc	3 253 36
	strb	w13, [x11, #62]
.Ltmp56:
	.loc	3 249 2
	b.ne	.LBB0_33
.Ltmp57:
	.loc	3 0 2 is_stmt 0
	sub	w10, w0, #1
.Ltmp58:
	.loc	3 256 2 is_stmt 1
	cmp	w10, #2
	b.lt	.LBB0_71
.Ltmp59:
	sub	x12, x10, #1
	mov	w9, #1
	cmp	x12, #2
	b.hs	.LBB0_59
.Ltmp60:
	.loc	3 0 2 is_stmt 0
	mov	w11, #1
	b	.LBB0_69
.Ltmp61:
.LBB0_37:
	.loc	3 275 2 is_stmt 1
	cbz	w0, .LBB0_105
.Ltmp62:
	.loc	3 275 16 is_stmt 0
	mov	w10, w0
	mov	x9, xzr
.Ltmp63:
	.loc	3 0 0
	ldr	x8, [x20, #16]
.Ltmp64:
	.loc	3 275 2
	lsl	x10, x10, #10
.Ltmp65:
.LBB0_39:
	.loc	3 276 20 is_stmt 1
	add	x11, x8, w9, sxtw
.Ltmp66:
	.loc	3 275 16
	add	x9, x9, #1024
.Ltmp67:
	.loc	3 275 2 is_stmt 0
	cmp	x10, x9
.Ltmp68:
	.loc	3 277 38 is_stmt 1
	ldrb	w12, [x11, #960]
	.loc	3 279 38
	ldrb	w13, [x11, #30]
	.loc	3 277 36
	strb	w12, [x11, #992]
	.loc	3 278 36
	strb	w12, [x11, #928]
	.loc	3 279 36
	strb	w13, [x11, #62]
.Ltmp69:
	.loc	3 275 2
	b.ne	.LBB0_39
.Ltmp70:
	.loc	3 0 2 is_stmt 0
	sub	w9, w0, #9
.Ltmp71:
	.loc	3 282 2 is_stmt 1
	cmp	w9, #4
	b.lt	.LBB0_86
.Ltmp72:
	sub	x11, x9, #3
.Ltmp73:
	cmp	x11, #2
	b.hs	.LBB0_74
.Ltmp74:
	.loc	3 0 2 is_stmt 0
	mov	w10, #3
	b	.LBB0_84
.Ltmp75:
.LBB0_43:
	.loc	3 301 2 is_stmt 1
	cbz	w0, .LBB0_105
.Ltmp76:
	.loc	3 0 0 is_stmt 0
	ldr	x8, [x20, #16]
.Ltmp77:
	.loc	3 301 16
	mov	w9, w0
.Ltmp78:
	.loc	3 301 2
	cmp	w0, #1
	b.ne	.LBB0_46
.Ltmp79:
	.loc	3 0 2
	mov	x10, xzr
	b	.LBB0_56
.Ltmp80:
.LBB0_46:
	.loc	3 301 2
	sub	x12, x9, #1
	mov	x10, xzr
	and	x11, x12, #0xffffffff
	lsl	x14, x11, #10
	tst	x14, #0xffffffff00000000
	cset	w13, ne
	cmp	xzr, x12, lsr #54
	cset	w11, ne
	tbnz	w14, #31, .LBB0_56
.Ltmp81:
	.loc	3 0 2
	tbnz	w13, #0, .LBB0_56
.Ltmp82:
	lsr	x13, x12, #32
	cbnz	x13, .LBB0_56
.Ltmp83:
	add	x13, x8, #1021
	lsl	x12, x12, #10
	add	x14, x13, x12
	cmp	x14, x13
	b.lo	.LBB0_56
.Ltmp84:
	tbnz	w11, #0, .LBB0_56
.Ltmp85:
	add	x13, x8, #989
	add	x12, x13, x12
	cmp	x12, x13
	b.lo	.LBB0_56
.Ltmp86:
	tbnz	w11, #0, .LBB0_56
.Ltmp87:
	.loc	3 301 2
	and	x10, x9, #0xfffffffe
	mov	w11, #1024
	mov	x12, x10
.Ltmp88:
.LBB0_54:
	.loc	3 301 30
	sub	w13, w11, #1024
	add	x14, x8, w11, sxtw
	subs	x12, x12, #2
	add	w11, w11, #2048
	add	x13, x8, w13, sxtw
	ldrb	w16, [x14, #1021]
	ldrb	w15, [x13, #1021]
	strb	w16, [x14, #989]
	strb	w15, [x13, #989]
	b.ne	.LBB0_54
.Ltmp89:
	.loc	3 301 2
	cmp	x10, x9
	b.eq	.LBB0_105
.Ltmp90:
.LBB0_56:
	sub	x9, x9, x10
	lsl	w10, w10, #10
.Ltmp91:
.LBB0_57:
	.loc	3 302 20 is_stmt 1
	add	x11, x8, w10, sxtw
.Ltmp92:
	.loc	3 301 16
	subs	x9, x9, #1
	add	w10, w10, #1024
.Ltmp93:
	.loc	3 303 38
	ldrb	w12, [x11, #1021]
	.loc	3 303 36 is_stmt 0
	strb	w12, [x11, #989]
.Ltmp94:
	.loc	3 301 2 is_stmt 1
	b.ne	.LBB0_57
	b	.LBB0_105
.Ltmp95:
.LBB0_58:
	.loc	3 189 3
	adrp	x0, .L.str.3
	add	x0, x0, :lo12:.L.str.3
	bl	_printk
.Ltmp96:
	.loc	3 0 3 is_stmt 0
	mov	w0, #255
	b	.LBB0_27
.Ltmp97:
.LBB0_59:
	.loc	3 256 2 is_stmt 1
	sub	x14, x10, #2
	and	x11, x14, #0xffffffff
.Ltmp98:
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
	b.hi	.LBB0_69
.Ltmp99:
	.loc	3 0 2 is_stmt 0
	tbnz	w15, #0, .LBB0_69
.Ltmp100:
	lsr	x15, x14, #32
	cbnz	x15, .LBB0_69
.Ltmp101:
	add	x15, x8, #2046
	lsl	x14, x14, #10
	add	x16, x15, x14
	cmp	x16, x15
	b.lo	.LBB0_69
.Ltmp102:
	tbnz	w13, #0, .LBB0_69
.Ltmp103:
	add	x15, x8, #1056
	add	x14, x15, x14
	cmp	x14, x15
	b.lo	.LBB0_69
.Ltmp104:
	tbnz	w13, #0, .LBB0_69
.Ltmp105:
	.loc	3 256 2
	and	x13, x12, #0xfffffffffffffffe
	orr	x11, x12, #0x1
	mov	w14, #2048
	mov	w15, #2
	mov	w16, #1
	mov	x17, x13
.Ltmp106:
.LBB0_67:
	.loc	3 257 25 is_stmt 1
	sub	w1, w14, #1024
	.loc	3 257 20 is_stmt 0
	add	x2, x8, w14, sxtw
	add	w14, w14, #2048
	subs	x17, x17, #2
	add	x1, x8, w1, sxtw
	.loc	3 258 36 is_stmt 1
	strb	w15, [x2, #1022]
	.loc	3 259 36
	strb	w16, [x2, #32]
	.loc	3 258 36
	strb	w15, [x1, #1022]
	.loc	3 259 36
	strb	w16, [x1, #32]
	b.ne	.LBB0_67
.Ltmp107:
	.loc	3 256 2
	cmp	x12, x13
	b.eq	.LBB0_71
.Ltmp108:
.LBB0_69:
	sub	x10, x10, x11
	lsl	w11, w11, #10
	mov	w12, #2
.Ltmp109:
.LBB0_70:
	.loc	3 257 20
	add	x13, x8, w11, sxtw
.Ltmp110:
	.loc	3 256 16
	subs	x10, x10, #1
	add	w11, w11, #1024
.Ltmp111:
	.loc	3 258 36
	strb	w12, [x13, #1022]
	.loc	3 259 36
	strb	w9, [x13, #32]
.Ltmp112:
	.loc	3 256 2
	b.ne	.LBB0_70
.Ltmp113:
.LBB0_71:
	.loc	3 0 2 is_stmt 0
	sub	w9, w0, #2
.Ltmp114:
	.loc	3 262 2 is_stmt 1
	cmp	w9, #2
	b.lt	.LBB0_105
.Ltmp115:
	.loc	3 0 2 is_stmt 0
	add	x8, x8, #958
.Ltmp116:
	.loc	3 262 2
	sub	x11, x9, #1
	cmp	x11, #2
	b.hs	.LBB0_89
.Ltmp117:
	.loc	3 0 2
	mov	w10, #1
	b	.LBB0_95
.Ltmp118:
.LBB0_74:
	.loc	3 282 2 is_stmt 1
	sub	x13, x9, #4
	mov	w16, #62463
	and	x10, x13, #0xffffffff
	movk	w16, #32767, lsl #16
	lsl	x15, x10, #10
	mov	w10, #3
	tst	x15, #0xffffffff00000000
	cset	w14, ne
	cmp	xzr, x13, lsr #54
	cset	w12, ne
	cmp	w15, w16
	b.hi	.LBB0_84
.Ltmp119:
	.loc	3 0 2 is_stmt 0
	tbnz	w14, #0, .LBB0_84
.Ltmp120:
	lsr	x14, x13, #32
	cbnz	x14, .LBB0_84
.Ltmp121:
	add	x14, x8, #4094
	lsl	x13, x13, #10
	add	x15, x14, x13
	cmp	x15, x14
	b.lo	.LBB0_84
.Ltmp122:
	tbnz	w12, #0, .LBB0_84
.Ltmp123:
	add	x14, x8, #3104
	add	x13, x14, x13
	cmp	x13, x14
	b.lo	.LBB0_84
.Ltmp124:
	tbnz	w12, #0, .LBB0_84
.Ltmp125:
	.loc	3 282 2
	and	x12, x11, #0xfffffffffffffffe
	mov	w13, #4096
	add	x10, x12, #3
	mov	w14, #2
	mov	w15, #1
	mov	x16, x12
.Ltmp126:
.LBB0_82:
	.loc	3 283 25 is_stmt 1
	sub	w17, w13, #1024
	.loc	3 283 20 is_stmt 0
	add	x1, x8, w13, sxtw
	add	w13, w13, #2048
	subs	x16, x16, #2
	add	x17, x8, w17, sxtw
	.loc	3 284 36 is_stmt 1
	strb	w14, [x1, #1022]
	.loc	3 285 36
	strb	w15, [x1, #32]
	.loc	3 284 36
	strb	w14, [x17, #1022]
	.loc	3 285 36
	strb	w15, [x17, #32]
	b.ne	.LBB0_82
.Ltmp127:
	.loc	3 282 2
	cmp	x11, x12
	b.eq	.LBB0_86
.Ltmp128:
.LBB0_84:
	sub	x9, x9, x10
	lsl	w10, w10, #10
	mov	w11, #2
	mov	w12, #1
.Ltmp129:
.LBB0_85:
	.loc	3 283 20
	add	x13, x8, w10, sxtw
.Ltmp130:
	.loc	3 282 16
	subs	x9, x9, #1
	add	w10, w10, #1024
.Ltmp131:
	.loc	3 284 36
	strb	w11, [x13, #1022]
	.loc	3 285 36
	strb	w12, [x13, #32]
.Ltmp132:
	.loc	3 282 2
	b.ne	.LBB0_85
.Ltmp133:
.LBB0_86:
	.loc	3 0 2 is_stmt 0
	sub	w9, w0, #12
.Ltmp134:
	.loc	3 288 2 is_stmt 1
	cmp	w9, #4
	b.lt	.LBB0_105
.Ltmp135:
	.loc	3 0 2 is_stmt 0
	add	x8, x8, #958
.Ltmp136:
	.loc	3 288 2
	sub	x11, x9, #3
	cmp	x11, #2
	b.hs	.LBB0_97
.Ltmp137:
	.loc	3 0 2
	mov	w10, #3
	b	.LBB0_103
.Ltmp138:
.LBB0_89:
	.loc	3 262 2 is_stmt 1
	sub	x12, x9, #2
	and	x10, x12, #0xffffffff
	lsl	x14, x10, #10
	mov	w10, #62463
	tst	x14, #0xffffffff00000000
	movk	w10, #32767, lsl #16
	cset	w13, ne
	orr	w15, w10, #0x800
	mov	w10, #1
	cmp	w14, w15
	b.hi	.LBB0_95
.Ltmp139:
	.loc	3 0 2 is_stmt 0
	tbnz	w13, #0, .LBB0_95
.Ltmp140:
	lsr	x12, x12, #32
	cbnz	x12, .LBB0_95
.Ltmp141:
	.loc	3 262 2
	and	x12, x11, #0xfffffffffffffffe
	orr	x10, x11, #0x1
	mov	w13, #2048
	mov	w14, #2
	mov	x15, x12
.Ltmp142:
.LBB0_93:
	.loc	3 263 25 is_stmt 1
	sub	w16, w13, #1024
	.loc	3 264 36
	strb	w14, [x8, w13, sxtw]
	add	w13, w13, #2048
	subs	x15, x15, #2
	strb	w14, [x8, w16, sxtw]
	b.ne	.LBB0_93
.Ltmp143:
	.loc	3 262 2
	cmp	x11, x12
	b.eq	.LBB0_105
.Ltmp144:
.LBB0_95:
	sub	x9, x9, x10
	lsl	w10, w10, #10
	mov	w11, #2
.Ltmp145:
.LBB0_96:
	.loc	3 264 36
	strb	w11, [x8, w10, sxtw]
.Ltmp146:
	.loc	3 262 16
	subs	x9, x9, #1
	add	w10, w10, #1024
.Ltmp147:
	.loc	3 262 2 is_stmt 0
	b.ne	.LBB0_96
	b	.LBB0_105
.Ltmp148:
.LBB0_97:
	.loc	3 288 2 is_stmt 1
	sub	x12, x9, #4
	mov	w15, #62463
	and	x10, x12, #0xffffffff
	movk	w15, #32767, lsl #16
	lsl	x14, x10, #10
	mov	w10, #3
	tst	x14, #0xffffffff00000000
	cset	w13, ne
	cmp	w14, w15
	b.hi	.LBB0_103
.Ltmp149:
	.loc	3 0 2 is_stmt 0
	tbnz	w13, #0, .LBB0_103
.Ltmp150:
	lsr	x12, x12, #32
	cbnz	x12, .LBB0_103
.Ltmp151:
	.loc	3 288 2
	and	x12, x11, #0xfffffffffffffffe
	mov	w13, #4096
	add	x10, x12, #3
	mov	w14, #2
	mov	x15, x12
.Ltmp152:
.LBB0_101:
	.loc	3 289 25 is_stmt 1
	sub	w16, w13, #1024
	.loc	3 290 36
	strb	w14, [x8, w13, sxtw]
	add	w13, w13, #2048
	subs	x15, x15, #2
	strb	w14, [x8, w16, sxtw]
	b.ne	.LBB0_101
.Ltmp153:
	.loc	3 288 2
	cmp	x11, x12
	b.eq	.LBB0_105
.Ltmp154:
.LBB0_103:
	sub	x9, x9, x10
	lsl	w10, w10, #10
	mov	w11, #2
.Ltmp155:
.LBB0_104:
	.loc	3 290 36
	strb	w11, [x8, w10, sxtw]
.Ltmp156:
	.loc	3 288 16
	subs	x9, x9, #1
	add	w10, w10, #1024
.Ltmp157:
	.loc	3 288 2 is_stmt 0
	b.ne	.LBB0_104
.Ltmp158:
.LBB0_105:
	.loc	3 349 21 is_stmt 1
	ldrb	w8, [x20, #1]
	mov	w9, #21846
	movk	w9, #21845, lsl #16
	.loc	3 350 21
	orr	w8, w0, w8, lsl #8
	str	w8, [x20]
.Ltmp159:
	.loc	3 354 27
	ldrsw	x8, [x23, :lo12:pvi_wf_get_lut.sftemp]
.Ltmp160:
	.loc	3 351 9
	str	w21, [x26, :lo12:pvi_wf_get_lut.stype]
.Ltmp161:
	.loc	3 354 34
	mul	x8, x8, x9
	lsr	x9, x8, #63
	lsr	x8, x8, #32
	add	w9, w8, w9
.Ltmp162:
.LBB0_106:
	.loc	3 354 6 is_stmt 0
	cmp	w25, w9
	b.ne	.LBB0_108
.Ltmp163:
.LBB0_107:
	.loc	3 0 6
	mov	w0, wzr
	b	.LBB0_130
.Ltmp164:
.LBB0_108:
	.loc	3 356 18 is_stmt 1
	ldr	x8, [x20, #24]
	.loc	3 356 16 is_stmt 0
	adrp	x9, waveformdata
	str	x8, [x9, :lo12:waveformdata]
	.loc	3 357 17 is_stmt 1
	bl	epd_overlay_lut
.Ltmp165:
	.loc	3 203 17
	ldr	x8, [x24, :lo12:global_waveform]
	.loc	3 203 34 is_stmt 0
	ldrb	w9, [x8, #38]
.Ltmp166:
	.loc	3 207 2 is_stmt 1
	cbz	w9, .LBB0_113
.Ltmp167:
	.loc	3 0 2 is_stmt 0
	mov	x10, xzr
	.loc	3 207 2
	add	x11, x8, #48
.Ltmp168:
.LBB0_110:
	.loc	3 208 21 is_stmt 1
	ldrb	w12, [x11, x10]
.Ltmp169:
	.loc	3 208 7 is_stmt 0
	cmp	w12, w19
	b.ge	.LBB0_114
.Ltmp170:
	.loc	3 207 29 is_stmt 1
	add	x10, x10, #1
.Ltmp171:
	.loc	3 207 2 is_stmt 0
	cmp	x9, x10
	b.ne	.LBB0_110
.Ltmp172:
	.loc	3 0 2
	mov	w11, #-1
	mov	w10, w9
.Ltmp173:
	b	.LBB0_115
.Ltmp174:
.LBB0_113:
	mov	w10, wzr
	mov	w11, #-1
	b	.LBB0_115
.Ltmp175:
.LBB0_114:
	mov	w11, w10
.Ltmp176:
.LBB0_115:
	sub	w12, w10, #1
	.loc	3 214 6 is_stmt 1
	cmp	w10, w9
	csel	w21, w12, w11, eq
.Ltmp177:
	.loc	3 188 6
	cmp	w0, #11
	b.hs	.LBB0_132
.Ltmp178:
	.loc	3 168 20
	ldrb	w10, [x8, #16]
.Ltmp179:
	.loc	3 191 13
	cmp	w0, #10
	mov	w8, #3
	csel	w8, w8, w0, eq
.Ltmp180:
	.loc	3 168 2
	sub	w9, w10, #9
	cmp	w9, #75
	b.hi	.LBB0_119
.Ltmp181:
	.loc	3 0 2 is_stmt 0
	adrp	x10, .LJTI0_1
	add	x10, x10, :lo12:.LJTI0_1
	adr	x11, .LBB0_118
	ldrb	w12, [x10, x9]
	add	x11, x11, x12, lsl #2
	adrp	x9, pvi_mode_table
	add	x9, x9, :lo12:pvi_mode_table
	br	x11
.Ltmp182:
.LBB0_118:
	adrp	x9, pvi_mode_table+30
	add	x9, x9, :lo12:pvi_mode_table+30
.Ltmp183:
	b	.LBB0_127
.Ltmp184:
.LBB0_119:
	.loc	3 168 2
	cmp	w10, #114
	b.ne	.LBB0_121
.Ltmp185:
	.loc	3 0 2
	adrp	x9, pvi_mode_table+70
	add	x9, x9, :lo12:pvi_mode_table+70
	b	.LBB0_127
.Ltmp186:
.LBB0_121:
	adrp	x9, pvi_mode_table+80
	add	x9, x9, :lo12:pvi_mode_table+80
	b	.LBB0_127
.Ltmp187:
.LBB0_122:
	adrp	x9, pvi_mode_table+10
	add	x9, x9, :lo12:pvi_mode_table+10
	b	.LBB0_127
.Ltmp188:
.LBB0_123:
	adrp	x9, pvi_mode_table+20
	add	x9, x9, :lo12:pvi_mode_table+20
	b	.LBB0_127
.Ltmp189:
.LBB0_124:
	adrp	x9, pvi_mode_table+40
	add	x9, x9, :lo12:pvi_mode_table+40
	b	.LBB0_127
.Ltmp190:
.LBB0_125:
	adrp	x9, pvi_mode_table+50
	add	x9, x9, :lo12:pvi_mode_table+50
	b	.LBB0_127
.Ltmp191:
.LBB0_126:
	adrp	x9, pvi_mode_table+60
	add	x9, x9, :lo12:pvi_mode_table+60
.Ltmp192:
.LBB0_127:
	.loc	3 198 9 is_stmt 1
	ldrb	w0, [x9, x8]
.Ltmp193:
.LBB0_128:
	.loc	3 360 15
	mov	w1, w21
	bl	get_wf_frm_num
.Ltmp194:
	.loc	3 361 7
	tbnz	w0, #31, .LBB0_131
.Ltmp195:
	.loc	3 365 21
	ldrb	w8, [x20]
	.loc	3 366 21
	bfi	w8, w0, #8, #24
	mov	w0, wzr
.Ltmp196:
	str	w8, [x20]
	.loc	3 367 10
	str	w19, [x23, :lo12:pvi_wf_get_lut.sftemp]
.Ltmp197:
.LBB0_130:
	.loc	3 371 1
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x29, x30, [sp], #80
	ldr	x30, [x18, #-8]!
	ret
.LBB0_131:
.Ltmp198:
	.loc	3 0 0 is_stmt 0
	adrp	x0, .L.str
.Ltmp199:
	add	x0, x0, :lo12:.L.str
	bl	_printk
.Ltmp200:
	mov	w0, #-5
	b	.LBB0_130
.Ltmp201:
.LBB0_132:
	.loc	3 189 3 is_stmt 1
	adrp	x0, .L.str.3
.Ltmp202:
	add	x0, x0, :lo12:.L.str.3
	bl	_printk
.Ltmp203:
	.loc	3 0 3 is_stmt 0
	mov	w0, #255
	b	.LBB0_128
.Ltmp204:
.Lfunc_end0:
	.size	pvi_wf_get_lut, .Lfunc_end0-pvi_wf_get_lut
	.cfi_endproc
	.section	.rodata,"a",@progbits
.LJTI0_0:
	.byte	(.LBB0_26-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_21-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_22-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_17-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_23-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_17-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_24-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_20-.LBB0_17)>>2
	.byte	(.LBB0_25-.LBB0_17)>>2
.LJTI0_1:
	.byte	(.LBB0_127-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_122-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_123-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_118-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_124-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_118-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_125-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_121-.LBB0_118)>>2
	.byte	(.LBB0_126-.LBB0_118)>>2

	.text
	.p2align	2
	.type	get_wf_frm_num,@function
get_wf_frm_num:
.Lfunc_begin1:
	.loc	3 221 0 is_stmt 1
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
.Ltmp205:
	.loc	3 222 45 prologue_end
	adrp	x8, global_waveform
	.loc	3 226 37
	lsl	w9, w0, #2
	.loc	3 222 45
	ldr	x14, [x8, :lo12:global_waveform]
.Ltmp206:
	.loc	3 224 32
	ldrb	w8, [x14, #32]
.Ltmp207:
	.loc	3 226 21
	add	x8, x14, x8
.Ltmp208:
	.loc	3 226 30 is_stmt 0
	add	x8, x8, x9
.Ltmp209:
	.loc	3 227 22 is_stmt 1
	ldrb	w9, [x8]
	.loc	3 227 35 is_stmt 0
	ldrb	w10, [x8, #1]
	.loc	3 227 48
	ldrb	w11, [x8, #2]
	.loc	3 227 6
	ldrb	w12, [x8, #3]
	.loc	3 227 33
	add	w9, w10, w9
	.loc	3 227 46
	add	w9, w9, w11
.Ltmp210:
	.loc	3 227 6
	cmp	w12, w9, uxtb
	b.ne	.LBB1_36
.Ltmp211:
	.loc	3 0 6
	ldr	w8, [x8]
.Ltmp212:
	.loc	3 233 43 is_stmt 1
	lsl	w9, w1, #2
	.loc	3 231 28
	and	x8, x8, #0xffffff
.Ltmp213:
	.loc	3 233 21
	add	x8, x14, x8
.Ltmp214:
	.loc	3 233 30 is_stmt 0
	add	x8, x8, w9, sxtw
.Ltmp215:
	.loc	3 234 22 is_stmt 1
	ldrb	w9, [x8]
	.loc	3 234 35 is_stmt 0
	ldrb	w10, [x8, #1]
	.loc	3 234 48
	ldrb	w11, [x8, #2]
	.loc	3 234 6
	ldrb	w12, [x8, #3]
	.loc	3 234 33
	add	w9, w10, w9
	.loc	3 234 46
	add	w9, w9, w11
.Ltmp216:
	.loc	3 234 6
	cmp	w12, w9, uxtb
	b.ne	.LBB1_37
.Ltmp217:
	.loc	3 55 7 is_stmt 1
	adrp	x20, waveformdata
	ldr	x10, [x20, :lo12:waveformdata]
.Ltmp218:
	.loc	3 55 6 is_stmt 0
	cbz	x10, .LBB1_39
.Ltmp219:
	.loc	3 0 6
	adrp	x21, need_pic
.Ltmp220:
	.loc	3 60 6 is_stmt 1
	adrp	x22, maxpic
	ldr	w15, [x8]
	mov	w16, #5
	mov	w0, #32
.Ltmp221:
	.loc	3 0 6 is_stmt 0
	mov	w13, wzr
	ldr	w9, [x21, :lo12:need_pic]
	mov	w11, wzr
	.loc	3 60 6
	ldrb	w8, [x22, :lo12:maxpic]
.Ltmp222:
	.loc	3 0 0
	and	x15, x15, #0xffffff
.Ltmp223:
	add	x14, x14, x15
.Ltmp224:
	mov	w19, wzr
	cmp	w9, #32
	mov	w12, wzr
	cset	w17, eq
	bics	w15, w17, w8
.Ltmp225:
	mov	w17, #16
	cinc	w16, w16, ne
	cmp	w8, #0
	csel	w17, w0, w17, ne
	mov	w0, #1
.Ltmp226:
	b	.LBB1_6
.Ltmp227:
.LBB1_4:
	mov	w0, #1
.Ltmp228:
.LBB1_5:
	add	w11, w11, #1
.Ltmp229:
	.loc	3 64 7 is_stmt 1
	cmp	w19, #254
	b.hi	.LBB1_18
.Ltmp230:
.LBB1_6:
	.loc	3 69 7
	ldrb	w3, [x14, w11, uxtw]
.Ltmp231:
	.loc	3 69 7 is_stmt 0
	cmp	w3, #252
	b.eq	.LBB1_11
.Ltmp232:
	cmp	w3, #255
	b.eq	.LBB1_19
.Ltmp233:
	.loc	3 79 7 is_stmt 1
	tbnz	w0, #0, .LBB1_12
.Ltmp234:
.LBB1_9:
	.loc	3 114 44
	add	w0, w13, #1
.Ltmp235:
	.loc	3 114 75 is_stmt 0
	lsl	w1, w12, w15
.Ltmp236:
	.loc	3 114 47
	lsl	w2, w13, w16
	.loc	3 114 35
	add	w1, w1, w19, lsl #10
	.loc	3 115 47 is_stmt 1
	lsl	w0, w0, w16
.Ltmp237:
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
.Ltmp238:
	.loc	3 115 88 is_stmt 0
	strb	w5, [x10, w0, uxtw]
	.loc	3 116 44 is_stmt 1
	add	w0, w13, #3
.Ltmp239:
	.loc	3 116 47 is_stmt 0
	lsl	w2, w2, w16
	.loc	3 117 47 is_stmt 1
	lsl	w0, w0, w16
.Ltmp240:
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
.Ltmp241:
	.loc	3 116 88 is_stmt 1
	strb	w4, [x10, w2, uxtw]
	.loc	3 120 8
	cmp	w13, w17
	.loc	3 117 88
	strb	w1, [x10, w0, uxtw]
.Ltmp242:
	.loc	3 0 88 is_stmt 0
	mov	w0, wzr
	.loc	3 120 8 is_stmt 1
	b.lo	.LBB1_5
.Ltmp243:
	.loc	3 122 9
	add	w1, w12, #1
.Ltmp244:
	.loc	3 0 9 is_stmt 0
	mov	w13, wzr
	.loc	3 122 18
	cmp	w1, w17
.Ltmp245:
	.loc	3 122 9
	csinc	w12, wzr, w12, hs
	cinc	w19, w19, hs
.Ltmp246:
	.loc	3 0 9
	b	.LBB1_5
.Ltmp247:
.LBB1_11:
	.loc	3 76 10 is_stmt 1
	add	w11, w11, #1
.Ltmp248:
	.loc	3 0 0 is_stmt 0
	ldrb	w3, [x14, w11, uxtw]
.Ltmp249:
	.loc	3 79 7 is_stmt 1
	tbnz	w0, #0, .LBB1_9
.Ltmp250:
.LBB1_12:
	.loc	3 81 44
	add	w0, w13, #1
.Ltmp251:
	.loc	3 81 75 is_stmt 0
	lsl	w1, w12, w15
.Ltmp252:
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
.Ltmp253:
	.loc	3 82 106
	ubfx	w1, w3, #2, #2
	.loc	3 81 88
	strb	w0, [x10, w2, uxtw]
	.loc	3 82 44
	add	w2, w13, #2
.Ltmp254:
	.loc	3 82 88 is_stmt 0
	strb	w1, [x10, w5, uxtw]
	.loc	3 83 44 is_stmt 1
	add	w5, w13, #3
.Ltmp255:
	.loc	3 83 47 is_stmt 0
	lsl	w2, w2, w16
	.loc	3 84 47 is_stmt 1
	lsl	w5, w5, w16
.Ltmp256:
	.loc	3 83 65
	add	w6, w4, w2
	.loc	3 83 106 is_stmt 0
	ubfx	w2, w3, #4, #2
	.loc	3 84 65 is_stmt 1
	add	w4, w4, w5
	.loc	3 84 100 is_stmt 0
	lsr	w3, w3, #6
.Ltmp257:
	.loc	3 84 44
	add	w13, w13, #4
.Ltmp258:
	.loc	3 87 8 is_stmt 1
	cmp	w13, w17
	.loc	3 83 88
	strb	w2, [x10, w6, uxtw]
	.loc	3 84 88
	strb	w3, [x10, w4, uxtw]
.Ltmp259:
	.loc	3 87 8
	b.lo	.LBB1_14
.Ltmp260:
	.loc	3 89 9
	add	w4, w12, #1
.Ltmp261:
	.loc	3 0 9 is_stmt 0
	mov	w13, wzr
	.loc	3 89 18
	cmp	w4, w17
.Ltmp262:
	.loc	3 89 9
	csinc	w12, wzr, w12, hs
	cinc	w19, w19, hs
.Ltmp263:
.LBB1_14:
	.loc	3 0 0
	add	w11, w11, #1
.Ltmp264:
	.loc	3 95 8 is_stmt 1
	ldrb	w4, [x14, w11, uxtw]
.Ltmp265:
	.loc	3 96 4
	cbnz	w4, .LBB1_16
	b	.LBB1_4
.Ltmp266:
.LBB1_15:
	.loc	3 96 19 is_stmt 0
	sub	w4, w4, #1
.Ltmp267:
	tst	w4, #0xff
.Ltmp268:
	.loc	3 96 4
	b.eq	.LBB1_4
.Ltmp269:
.LBB1_16:
	.loc	3 97 45 is_stmt 1
	add	w5, w13, #1
.Ltmp270:
	.loc	3 97 76 is_stmt 0
	lsl	w6, w12, w15
	.loc	3 98 45 is_stmt 1
	add	w23, w13, #2
.Ltmp271:
	.loc	3 99 45
	add	w24, w13, #3
.Ltmp272:
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
.Ltmp273:
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
.Ltmp274:
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
.Ltmp275:
	.loc	3 103 10
	add	w5, w12, #1
.Ltmp276:
	.loc	3 0 10 is_stmt 0
	mov	w13, wzr
	.loc	3 103 19
	cmp	w5, w17
.Ltmp277:
	.loc	3 103 10
	csinc	w12, wzr, w12, hs
	cinc	w19, w19, hs
.Ltmp278:
	.loc	3 0 10
	b	.LBB1_15
.Ltmp279:
.LBB1_18:
	.loc	3 65 4 is_stmt 1
	adrp	x0, .L.str.6
	add	x0, x0, :lo12:.L.str.6
	bl	_printk
.Ltmp280:
	.loc	3 130 6
	ldrb	w8, [x22, :lo12:maxpic]
	ldr	w9, [x21, :lo12:need_pic]
.Ltmp281:
.LBB1_19:
	.loc	3 130 24 is_stmt 0
	cbz	w8, .LBB1_26
.Ltmp282:
	cmp	w9, #16
	b.ne	.LBB1_26
.Ltmp283:
	.loc	3 132 3 is_stmt 1
	cbz	w19, .LBB1_41
.Ltmp284:
	.loc	3 0 3 is_stmt 0
	ldr	x13, [x20, :lo12:waveformdata]
	mov	w10, wzr
	mov	w11, wzr
	.loc	3 132 3
	add	x12, x13, #16
	add	x13, x13, #7
.Ltmp285:
.LBB1_23:
	.loc	3 0 3
	mov	w15, w10
	mov	x16, #-2
.Ltmp286:
	add	x14, x12, x15
	and	x15, x15, #0xffffffe0
	add	x15, x13, x15
.Ltmp287:
.LBB1_24:
	.loc	3 135 17 is_stmt 1
	ldurb	w17, [x14, #-16]
.Ltmp288:
	.loc	3 133 28
	add	x16, x16, #2
.Ltmp289:
	.loc	3 133 4 is_stmt 0
	cmp	x16, #30
.Ltmp290:
	.loc	3 136 61 is_stmt 1
	sturb	w17, [x15, #-7]
.Ltmp291:
	.loc	3 135 17
	ldurb	w17, [x14, #-14]
.Ltmp292:
	.loc	3 136 61
	sturb	w17, [x15, #-6]
.Ltmp293:
	.loc	3 135 17
	ldurb	w17, [x14, #-12]
.Ltmp294:
	.loc	3 136 61
	sturb	w17, [x15, #-5]
.Ltmp295:
	.loc	3 135 17
	ldurb	w17, [x14, #-10]
.Ltmp296:
	.loc	3 136 61
	sturb	w17, [x15, #-4]
.Ltmp297:
	.loc	3 135 17
	ldurb	w17, [x14, #-8]
.Ltmp298:
	.loc	3 136 61
	sturb	w17, [x15, #-3]
.Ltmp299:
	.loc	3 135 17
	ldurb	w17, [x14, #-6]
.Ltmp300:
	.loc	3 136 61
	sturb	w17, [x15, #-2]
.Ltmp301:
	.loc	3 135 17
	ldurb	w17, [x14, #-4]
.Ltmp302:
	.loc	3 136 61
	sturb	w17, [x15, #-1]
.Ltmp303:
	.loc	3 135 17
	ldurb	w17, [x14, #-2]
.Ltmp304:
	.loc	3 136 61
	strb	w17, [x15]
.Ltmp305:
	.loc	3 135 17
	ldrb	w17, [x14]
.Ltmp306:
	.loc	3 136 61
	strb	w17, [x15, #1]
.Ltmp307:
	.loc	3 135 17
	ldrb	w17, [x14, #2]
.Ltmp308:
	.loc	3 136 61
	strb	w17, [x15, #2]
.Ltmp309:
	.loc	3 135 17
	ldrb	w17, [x14, #4]
.Ltmp310:
	.loc	3 136 61
	strb	w17, [x15, #3]
.Ltmp311:
	.loc	3 135 17
	ldrb	w17, [x14, #6]
.Ltmp312:
	.loc	3 136 61
	strb	w17, [x15, #4]
.Ltmp313:
	.loc	3 135 17
	ldrb	w17, [x14, #8]
.Ltmp314:
	.loc	3 136 61
	strb	w17, [x15, #5]
.Ltmp315:
	.loc	3 135 17
	ldrb	w17, [x14, #10]
.Ltmp316:
	.loc	3 136 61
	strb	w17, [x15, #6]
.Ltmp317:
	.loc	3 135 17
	ldrb	w17, [x14, #12]
.Ltmp318:
	.loc	3 136 61
	strb	w17, [x15, #7]
.Ltmp319:
	.loc	3 135 17
	ldrb	w17, [x14, #14]
.Ltmp320:
	.loc	3 133 28
	add	x14, x14, #64
.Ltmp321:
	.loc	3 136 61
	strb	w17, [x15, #8]
.Ltmp322:
	.loc	3 133 28
	add	x15, x15, #32
.Ltmp323:
	.loc	3 133 4 is_stmt 0
	b.lo	.LBB1_24
.Ltmp324:
	.loc	3 132 31 is_stmt 1
	add	w11, w11, #1
.Ltmp325:
	.loc	3 132 3 is_stmt 0
	add	w10, w10, #1024
.Ltmp326:
	cmp	w19, w11, uxtb
	b.hi	.LBB1_23
.Ltmp327:
.LBB1_26:
	.loc	3 0 3
	cmp	w9, #32
	cset	w9, eq
.Ltmp328:
	.loc	3 142 24 is_stmt 1
	and	w8, w8, w9
	cmp	w8, #1
	b.ne	.LBB1_41
.Ltmp329:
	.loc	3 144 3
	cbz	w19, .LBB1_41
.Ltmp330:
	.loc	3 0 3 is_stmt 0
	ldr	x8, [x20, :lo12:waveformdata]
	mov	x9, xzr
	.loc	3 144 3
	subs	w10, w19, #1
	b.eq	.LBB1_34
.Ltmp331:
	neg	w11, w19
	tst	w11, #0xff
	b.eq	.LBB1_34
.Ltmp332:
	.loc	3 0 3
	cmp	w10, #255
	b.hi	.LBB1_34
.Ltmp333:
	add	x10, x10, #1
	mov	x12, x8
	.loc	3 144 3
	and	x9, x10, #0x1fffffffe
	mov	x11, x9
.Ltmp334:
.LBB1_32:
	.loc	3 144 15
	strb	wzr, [x12, #989]
	subs	x11, x11, #2
	strb	wzr, [x12, #2013]
	add	x12, x12, #2048
	b.ne	.LBB1_32
.Ltmp335:
	.loc	3 144 3
	cmp	x10, x9
	b.eq	.LBB1_41
.Ltmp336:
.LBB1_34:
	add	x8, x8, x9, lsl #10
	add	w9, w9, #1
	add	x8, x8, #989
.Ltmp337:
.LBB1_35:
	add	w10, w9, #1
	cmp	w19, w9, uxtb
.Ltmp338:
	.loc	3 145 45 is_stmt 1
	strb	wzr, [x8]
.Ltmp339:
	.loc	3 144 3
	add	x8, x8, #1024
	mov	w9, w10
	b.hi	.LBB1_35
	b	.LBB1_41
.Ltmp340:
.LBB1_36:
	.loc	3 228 3
	adrp	x0, .L.str.4
.Ltmp341:
	adrp	x1, .L__func__.get_wf_frm_num
.Ltmp342:
	add	x0, x0, :lo12:.L.str.4
	add	x1, x1, :lo12:.L__func__.get_wf_frm_num
	mov	w2, #228
	b	.LBB1_38
.Ltmp343:
.LBB1_37:
	.loc	3 235 3
	adrp	x0, .L.str.4
.Ltmp344:
	adrp	x1, .L__func__.get_wf_frm_num
.Ltmp345:
	add	x0, x0, :lo12:.L.str.4
	add	x1, x1, :lo12:.L__func__.get_wf_frm_num
	mov	w2, #235
.Ltmp346:
.LBB1_38:
	.loc	3 0 0 is_stmt 0
	bl	_printk
.Ltmp347:
	b	.LBB1_40
.Ltmp348:
.LBB1_39:
	.loc	3 56 3 is_stmt 1
	adrp	x0, .L.str.5
.Ltmp349:
	add	x0, x0, :lo12:.L.str.5
	bl	_printk
.Ltmp350:
.LBB1_40:
	.loc	3 0 3 is_stmt 0
	mov	w19, #-22
.Ltmp351:
.LBB1_41:
	.loc	3 242 1 is_stmt 1
	mov	w0, w19
	ldp	x20, x19, [sp, #48]
	ldp	x22, x21, [sp, #32]
	ldp	x24, x23, [sp, #16]
	ldp	x29, x30, [sp], #64
	ldr	x30, [x18, #-8]!
	ret
.Ltmp352:
.Lfunc_end1:
	.size	get_wf_frm_num, .Lfunc_end1-get_wf_frm_num
	.cfi_endproc
	.file	6 "/home/lyx/rk-android14/kernel-6.1" "./include/linux/types.h"

	.globl	pvi_wf_input
	.p2align	2
	.type	pvi_wf_input,@function
pvi_wf_input:
.Lfunc_begin2:
	.loc	3 380 0
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
.Ltmp353:
	.loc	3 383 6 prologue_end
	adrp	x20, global_waveform
	ldr	x8, [x20, :lo12:global_waveform]
.Ltmp354:
	.loc	3 383 6 is_stmt 0
	cbz	x8, .LBB2_3
.Ltmp355:
	.loc	3 0 6
	mov	w0, #-16
.Ltmp356:
.LBB2_2:
	.loc	3 413 1 is_stmt 1
	ldp	x20, x19, [sp, #16]
	ldp	x29, x30, [sp], #32
	ldr	x30, [x18, #-8]!
	ret
.Ltmp357:
.LBB2_3:
	.loc	3 0 1 is_stmt 0
	mov	x19, x0
.Ltmp358:
	.loc	3 386 2 is_stmt 1
	ldrb	w1, [x0, #16]
	adrp	x0, .L.str.1
	add	x0, x0, :lo12:.L.str.1
	bl	_printk
.Ltmp359:
	.loc	3 389 18
	ldrb	w1, [x19, #16]
	.loc	3 389 2 is_stmt 0
	sub	w8, w1, #9
	cmp	w8, #105
	b.hi	.LBB2_7
.Ltmp360:
	.loc	3 0 2
	adrp	x9, .LJTI2_0
	add	x9, x9, :lo12:.LJTI2_0
	adr	x10, .LBB2_5
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
.Ltmp361:
.LBB2_5:
	.loc	3 397 10 is_stmt 1
	adrp	x8, maxpic
	mov	w9, #1
	strb	w9, [x8, :lo12:maxpic]
.Ltmp362:
.LBB2_6:
	.loc	3 0 10 is_stmt 0
	mov	w0, wzr
	.loc	3 410 18 is_stmt 1
	str	x19, [x20, :lo12:global_waveform]
	b	.LBB2_2
.Ltmp363:
.LBB2_7:
	.loc	3 405 3
	adrp	x0, .L.str.2
	ldrb	w2, [x19, #22]
	add	x0, x0, :lo12:.L.str.2
	bl	_printk
.Ltmp364:
	.loc	3 0 3 is_stmt 0
	mov	w0, #-8
	b	.LBB2_2
.Ltmp365:
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
	.loc	3 422 0 is_stmt 1
	.cfi_startproc
	.loc	3 423 39 prologue_end
	adrp	x8, global_waveform
	ldr	x8, [x8, :lo12:global_waveform]
.Ltmp366:
	.loc	3 426 6
	cbz	x8, .LBB3_2
.Ltmp367:
	.loc	3 429 2
	adrp	x0, pvi_wf_get_version.spi_id_buffer
	ldur	x9, [x8, #73]
	ldr	x10, [x8, #88]
	add	x0, x0, :lo12:pvi_wf_get_version.spi_id_buffer
	ldur	x11, [x8, #81]
	ldur	x8, [x8, #65]
.Ltmp368:
	stur	x10, [x0, #23]
	stp	x9, x11, [x0, #8]
	str	x8, [x0]
	.loc	3 430 20
	strb	wzr, [x0, #31]
	.loc	3 433 1
	ret
.LBB3_2:
.Ltmp369:
	.loc	3 0 1 is_stmt 0
	mov	x0, xzr
	.loc	3 433 1
	ret
.Ltmp370:
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
	.xword	.Ltmp21-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	.Ltmp21-.Lfunc_begin0
	.xword	.Ltmp22-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp23-.Lfunc_begin0
	.xword	.Ltmp197-.Lfunc_begin0
	.hword	1
	.byte	100
	.xword	.Ltmp198-.Lfunc_begin0
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
	.xword	.Ltmp21-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	.Ltmp21-.Lfunc_begin0
	.xword	.Ltmp23-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp23-.Lfunc_begin0
	.xword	.Ltmp177-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	.Ltmp177-.Lfunc_begin0
	.xword	.Ltmp197-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp201-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
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
	.xword	.Ltmp21-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp21-.Lfunc_begin0
	.xword	.Ltmp23-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp23-.Lfunc_begin0
	.xword	.Ltmp197-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp198-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc3:
	.xword	.Lfunc_begin0-.Lfunc_begin0
	.xword	.Ltmp43-.Lfunc_begin0
	.hword	1
	.byte	83
	.xword	.Ltmp95-.Lfunc_begin0
	.xword	.Ltmp96-.Lfunc_begin0
	.hword	1
	.byte	83
	.xword	.Ltmp96-.Lfunc_begin0
	.xword	.Ltmp97-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	83
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc4:
	.xword	.Ltmp1-.Lfunc_begin0
	.xword	.Ltmp166-.Lfunc_begin0
	.hword	3
	.byte	48
	.byte	32
	.byte	159
	.xword	.Ltmp166-.Lfunc_begin0
	.xword	.Ltmp193-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp201-.Lfunc_begin0
	.xword	.Ltmp202-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc5:
	.xword	.Ltmp1-.Lfunc_begin0
	.xword	.Ltmp44-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp44-.Lfunc_begin0
	.xword	.Ltmp95-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp95-.Lfunc_begin0
	.xword	.Ltmp97-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp97-.Lfunc_begin0
	.xword	.Ltmp162-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp194-.Lfunc_begin0
	.xword	.Ltmp196-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp198-.Lfunc_begin0
	.xword	.Ltmp199-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc6:
	.xword	.Ltmp1-.Lfunc_begin0
	.xword	.Ltmp43-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp43-.Lfunc_begin0
	.xword	.Ltmp44-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp95-.Lfunc_begin0
	.xword	.Ltmp97-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp193-.Lfunc_begin0
	.xword	.Ltmp194-.Lfunc_begin0
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
	.xword	.Ltmp162-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	.Ltmp177-.Lfunc_begin0
	.xword	.Ltmp197-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	.Ltmp201-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	0
	.xword	0
.Ldebug_loc8:
	.xword	.Ltmp13-.Lfunc_begin0
	.xword	.Ltmp21-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp24-.Lfunc_begin0
	.xword	.Ltmp28-.Lfunc_begin0
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
	.xword	.Ltmp20-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	.Ltmp24-.Lfunc_begin0
	.xword	.Ltmp25-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp25-.Lfunc_begin0
	.xword	.Ltmp26-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	0
	.xword	0
.Ldebug_loc10:
	.xword	.Ltmp12-.Lfunc_begin0
	.xword	.Ltmp21-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	127
	.byte	159
	.xword	.Ltmp24-.Lfunc_begin0
	.xword	.Ltmp26-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	127
	.byte	159
	.xword	.Ltmp26-.Lfunc_begin0
	.xword	.Ltmp27-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp27-.Lfunc_begin0
	.xword	.Ltmp28-.Lfunc_begin0
	.hword	1
	.byte	102
	.xword	0
	.xword	0
.Ldebug_loc11:
	.xword	.Ltmp13-.Lfunc_begin0
	.xword	.Ltmp21-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp24-.Lfunc_begin0
	.xword	.Ltmp28-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc12:
	.xword	.Ltmp27-.Lfunc_begin0
	.xword	.Ltmp30-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp95-.Lfunc_begin0
	.xword	.Ltmp97-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc13:
	.xword	.Ltmp27-.Lfunc_begin0
	.xword	.Ltmp42-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp42-.Lfunc_begin0
	.xword	.Ltmp43-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	.Ltmp95-.Lfunc_begin0
	.xword	.Ltmp97-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc14:
	.xword	.Ltmp27-.Lfunc_begin0
	.xword	.Ltmp43-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	.Ltmp95-.Lfunc_begin0
	.xword	.Ltmp97-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	0
	.xword	0
.Ldebug_loc15:
	.xword	.Ltmp30-.Lfunc_begin0
	.xword	.Ltmp33-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp33-.Lfunc_begin0
	.xword	.Ltmp34-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	.Ltmp34-.Lfunc_begin0
	.xword	.Ltmp35-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc16:
	.xword	.Ltmp51-.Lfunc_begin0
	.xword	.Ltmp60-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp97-.Lfunc_begin0
	.xword	.Ltmp116-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc17:
	.xword	.Ltmp48-.Lfunc_begin0
	.xword	.Ltmp60-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp97-.Lfunc_begin0
	.xword	.Ltmp117-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp138-.Lfunc_begin0
	.xword	.Ltmp148-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc18:
	.xword	.Ltmp48-.Lfunc_begin0
	.xword	.Ltmp52-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp53-.Lfunc_begin0
	.xword	.Ltmp60-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp97-.Lfunc_begin0
	.xword	.Ltmp98-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp110-.Lfunc_begin0
	.xword	.Ltmp113-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp145-.Lfunc_begin0
	.xword	.Ltmp148-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc19:
	.xword	.Ltmp48-.Lfunc_begin0
	.xword	.Ltmp52-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp52-.Lfunc_begin0
	.xword	.Ltmp54-.Lfunc_begin0
	.hword	7
	.byte	121
	.byte	0
	.byte	17
	.byte	128
	.byte	8
	.byte	27
	.byte	159
	.xword	.Ltmp56-.Lfunc_begin0
	.xword	.Ltmp58-.Lfunc_begin0
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
	.xword	.Ltmp58-.Lfunc_begin0
	.xword	.Ltmp60-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	1
	.byte	159
	.xword	.Ltmp97-.Lfunc_begin0
	.xword	.Ltmp109-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	1
	.byte	159
	.xword	.Ltmp114-.Lfunc_begin0
	.xword	.Ltmp117-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	1
	.byte	159
	.xword	.Ltmp138-.Lfunc_begin0
	.xword	.Ltmp145-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	1
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc20:
	.xword	.Ltmp64-.Lfunc_begin0
	.xword	.Ltmp74-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp118-.Lfunc_begin0
	.xword	.Ltmp136-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc21:
	.xword	.Ltmp61-.Lfunc_begin0
	.xword	.Ltmp74-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp118-.Lfunc_begin0
	.xword	.Ltmp137-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp148-.Lfunc_begin0
	.xword	.Ltmp158-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc22:
	.xword	.Ltmp61-.Lfunc_begin0
	.xword	.Ltmp65-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp66-.Lfunc_begin0
	.xword	.Ltmp73-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp130-.Lfunc_begin0
	.xword	.Ltmp133-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp155-.Lfunc_begin0
	.xword	.Ltmp158-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc23:
	.xword	.Ltmp61-.Lfunc_begin0
	.xword	.Ltmp65-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp65-.Lfunc_begin0
	.xword	.Ltmp67-.Lfunc_begin0
	.hword	7
	.byte	121
	.byte	0
	.byte	17
	.byte	128
	.byte	8
	.byte	27
	.byte	159
	.xword	.Ltmp69-.Lfunc_begin0
	.xword	.Ltmp71-.Lfunc_begin0
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
	.xword	.Ltmp71-.Lfunc_begin0
	.xword	.Ltmp74-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	3
	.byte	159
	.xword	.Ltmp118-.Lfunc_begin0
	.xword	.Ltmp129-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	3
	.byte	159
	.xword	.Ltmp134-.Lfunc_begin0
	.xword	.Ltmp137-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	3
	.byte	159
	.xword	.Ltmp148-.Lfunc_begin0
	.xword	.Ltmp155-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	3
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc24:
	.xword	.Ltmp77-.Lfunc_begin0
	.xword	.Ltmp95-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc25:
	.xword	.Ltmp75-.Lfunc_begin0
	.xword	.Ltmp91-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp92-.Lfunc_begin0
	.xword	.Ltmp95-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	0
	.xword	0
.Ldebug_loc26:
	.xword	.Ltmp75-.Lfunc_begin0
	.xword	.Ltmp91-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc27:
	.xword	.Ltmp166-.Lfunc_begin0
	.xword	.Ltmp178-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc28:
	.xword	.Ltmp166-.Lfunc_begin0
	.xword	.Ltmp178-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	0
	.xword	0
.Ldebug_loc29:
	.xword	.Ltmp166-.Lfunc_begin0
	.xword	.Ltmp168-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp168-.Lfunc_begin0
	.xword	.Ltmp173-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	.Ltmp174-.Lfunc_begin0
	.xword	.Ltmp175-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp175-.Lfunc_begin0
	.xword	.Ltmp176-.Lfunc_begin0
	.hword	1
	.byte	90
	.xword	0
	.xword	0
.Ldebug_loc30:
	.xword	.Ltmp166-.Lfunc_begin0
	.xword	.Ltmp176-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	127
	.byte	159
	.xword	.Ltmp176-.Lfunc_begin0
	.xword	.Ltmp177-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp177-.Lfunc_begin0
	.xword	.Ltmp178-.Lfunc_begin0
	.hword	1
	.byte	101
	.xword	0
	.xword	0
.Ldebug_loc31:
	.xword	.Ltmp177-.Lfunc_begin0
	.xword	.Ltmp180-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp201-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc32:
	.xword	.Ltmp177-.Lfunc_begin0
	.xword	.Ltmp192-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp192-.Lfunc_begin0
	.xword	.Ltmp193-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	.Ltmp201-.Lfunc_begin0
	.xword	.Lfunc_end0-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc33:
	.xword	.Ltmp177-.Lfunc_begin0
	.xword	.Ltmp193-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp201-.Lfunc_begin0
	.xword	.Ltmp202-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	0
	.xword	0
.Ldebug_loc34:
	.xword	.Ltmp180-.Lfunc_begin0
	.xword	.Ltmp183-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp183-.Lfunc_begin0
	.xword	.Ltmp184-.Lfunc_begin0
	.hword	1
	.byte	89
	.xword	.Ltmp184-.Lfunc_begin0
	.xword	.Ltmp185-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc35:
	.xword	.Lfunc_begin1-.Lfunc_begin0
	.xword	.Ltmp221-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp221-.Lfunc_begin0
	.xword	.Ltmp340-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	80
	.byte	159
	.xword	.Ltmp340-.Lfunc_begin0
	.xword	.Ltmp341-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp341-.Lfunc_begin0
	.xword	.Ltmp343-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	80
	.byte	159
	.xword	.Ltmp343-.Lfunc_begin0
	.xword	.Ltmp344-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp344-.Lfunc_begin0
	.xword	.Ltmp348-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	80
	.byte	159
	.xword	.Ltmp348-.Lfunc_begin0
	.xword	.Ltmp349-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp349-.Lfunc_begin0
	.xword	.Lfunc_end1-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	80
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc36:
	.xword	.Lfunc_begin1-.Lfunc_begin0
	.xword	.Ltmp227-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp236-.Lfunc_begin0
	.xword	.Ltmp243-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp252-.Lfunc_begin0
	.xword	.Ltmp260-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp340-.Lfunc_begin0
	.xword	.Ltmp342-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp342-.Lfunc_begin0
	.xword	.Ltmp343-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp343-.Lfunc_begin0
	.xword	.Ltmp345-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp345-.Lfunc_begin0
	.xword	.Ltmp348-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	.Ltmp348-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp350-.Lfunc_begin0
	.xword	.Ltmp351-.Lfunc_begin0
	.hword	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc37:
	.xword	.Ltmp205-.Lfunc_begin0
	.xword	.Ltmp206-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp206-.Lfunc_begin0
	.xword	.Ltmp224-.Lfunc_begin0
	.hword	1
	.byte	94
	.xword	.Ltmp340-.Lfunc_begin0
	.xword	.Ltmp347-.Lfunc_begin0
	.hword	1
	.byte	94
	.xword	.Ltmp348-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	1
	.byte	94
	.xword	0
	.xword	0
.Ldebug_loc38:
	.xword	.Ltmp206-.Lfunc_begin0
	.xword	.Ltmp207-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp207-.Lfunc_begin0
	.xword	.Ltmp208-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp213-.Lfunc_begin0
	.xword	.Ltmp214-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp223-.Lfunc_begin0
	.xword	.Ltmp225-.Lfunc_begin0
	.hword	1
	.byte	95
	.xword	0
	.xword	0
.Ldebug_loc39:
	.xword	.Ltmp206-.Lfunc_begin0
	.xword	.Ltmp209-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp209-.Lfunc_begin0
	.xword	.Ltmp212-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp215-.Lfunc_begin0
	.xword	.Ltmp217-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp224-.Lfunc_begin0
	.xword	.Ltmp280-.Lfunc_begin0
	.hword	1
	.byte	94
	.xword	.Ltmp340-.Lfunc_begin0
	.xword	.Ltmp347-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	0
	.xword	0
.Ldebug_loc40:
	.xword	.Ltmp228-.Lfunc_begin0
	.xword	.Ltmp280-.Lfunc_begin0
	.hword	1
	.byte	94
	.xword	0
	.xword	0
.Ldebug_loc41:
	.xword	.Ltmp217-.Lfunc_begin0
	.xword	.Ltmp227-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp229-.Lfunc_begin0
	.xword	.Ltmp235-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp235-.Lfunc_begin0
	.xword	.Ltmp237-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp238-.Lfunc_begin0
	.xword	.Ltmp239-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp239-.Lfunc_begin0
	.xword	.Ltmp240-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp241-.Lfunc_begin0
	.xword	.Ltmp242-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp242-.Lfunc_begin0
	.xword	.Ltmp247-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp247-.Lfunc_begin0
	.xword	.Ltmp251-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp251-.Lfunc_begin0
	.xword	.Ltmp253-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp254-.Lfunc_begin0
	.xword	.Ltmp255-.Lfunc_begin0
	.hword	1
	.byte	82
	.xword	.Ltmp255-.Lfunc_begin0
	.xword	.Ltmp256-.Lfunc_begin0
	.hword	1
	.byte	85
	.xword	.Ltmp258-.Lfunc_begin0
	.xword	.Ltmp260-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp260-.Lfunc_begin0
	.xword	.Ltmp263-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp264-.Lfunc_begin0
	.xword	.Ltmp270-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp270-.Lfunc_begin0
	.xword	.Ltmp271-.Lfunc_begin0
	.hword	1
	.byte	85
	.xword	.Ltmp271-.Lfunc_begin0
	.xword	.Ltmp272-.Lfunc_begin0
	.hword	1
	.byte	103
	.xword	.Ltmp272-.Lfunc_begin0
	.xword	.Ltmp273-.Lfunc_begin0
	.hword	1
	.byte	104
	.xword	.Ltmp274-.Lfunc_begin0
	.xword	.Ltmp275-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp275-.Lfunc_begin0
	.xword	.Ltmp279-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp279-.Lfunc_begin0
	.xword	.Ltmp280-.Lfunc_begin0
	.hword	1
	.byte	93
	.xword	.Ltmp286-.Lfunc_begin0
	.xword	.Ltmp287-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp287-.Lfunc_begin0
	.xword	.Ltmp322-.Lfunc_begin0
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
	.xword	.Ltmp322-.Lfunc_begin0
	.xword	.Ltmp326-.Lfunc_begin0
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
	.xword	.Ltmp348-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc42:
	.xword	.Ltmp217-.Lfunc_begin0
	.xword	.Ltmp227-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp229-.Lfunc_begin0
	.xword	.Ltmp244-.Lfunc_begin0
	.hword	1
	.byte	92
	.xword	.Ltmp244-.Lfunc_begin0
	.xword	.Ltmp247-.Lfunc_begin0
	.hword	1
	.byte	81
	.xword	.Ltmp247-.Lfunc_begin0
	.xword	.Ltmp261-.Lfunc_begin0
	.hword	1
	.byte	92
	.xword	.Ltmp261-.Lfunc_begin0
	.xword	.Ltmp263-.Lfunc_begin0
	.hword	1
	.byte	84
	.xword	.Ltmp264-.Lfunc_begin0
	.xword	.Ltmp276-.Lfunc_begin0
	.hword	1
	.byte	92
	.xword	.Ltmp276-.Lfunc_begin0
	.xword	.Ltmp279-.Lfunc_begin0
	.hword	1
	.byte	85
	.xword	.Ltmp279-.Lfunc_begin0
	.xword	.Ltmp280-.Lfunc_begin0
	.hword	1
	.byte	92
	.xword	.Ltmp287-.Lfunc_begin0
	.xword	.Ltmp291-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp291-.Lfunc_begin0
	.xword	.Ltmp293-.Lfunc_begin0
	.hword	2
	.byte	50
	.byte	159
	.xword	.Ltmp293-.Lfunc_begin0
	.xword	.Ltmp295-.Lfunc_begin0
	.hword	2
	.byte	52
	.byte	159
	.xword	.Ltmp295-.Lfunc_begin0
	.xword	.Ltmp297-.Lfunc_begin0
	.hword	2
	.byte	54
	.byte	159
	.xword	.Ltmp297-.Lfunc_begin0
	.xword	.Ltmp299-.Lfunc_begin0
	.hword	2
	.byte	56
	.byte	159
	.xword	.Ltmp299-.Lfunc_begin0
	.xword	.Ltmp301-.Lfunc_begin0
	.hword	2
	.byte	58
	.byte	159
	.xword	.Ltmp301-.Lfunc_begin0
	.xword	.Ltmp303-.Lfunc_begin0
	.hword	2
	.byte	60
	.byte	159
	.xword	.Ltmp303-.Lfunc_begin0
	.xword	.Ltmp305-.Lfunc_begin0
	.hword	2
	.byte	62
	.byte	159
	.xword	.Ltmp305-.Lfunc_begin0
	.xword	.Ltmp307-.Lfunc_begin0
	.hword	2
	.byte	64
	.byte	159
	.xword	.Ltmp307-.Lfunc_begin0
	.xword	.Ltmp309-.Lfunc_begin0
	.hword	2
	.byte	66
	.byte	159
	.xword	.Ltmp309-.Lfunc_begin0
	.xword	.Ltmp311-.Lfunc_begin0
	.hword	2
	.byte	68
	.byte	159
	.xword	.Ltmp311-.Lfunc_begin0
	.xword	.Ltmp313-.Lfunc_begin0
	.hword	2
	.byte	70
	.byte	159
	.xword	.Ltmp313-.Lfunc_begin0
	.xword	.Ltmp315-.Lfunc_begin0
	.hword	2
	.byte	72
	.byte	159
	.xword	.Ltmp315-.Lfunc_begin0
	.xword	.Ltmp317-.Lfunc_begin0
	.hword	2
	.byte	74
	.byte	159
	.xword	.Ltmp317-.Lfunc_begin0
	.xword	.Ltmp319-.Lfunc_begin0
	.hword	2
	.byte	76
	.byte	159
	.xword	.Ltmp319-.Lfunc_begin0
	.xword	.Ltmp322-.Lfunc_begin0
	.hword	2
	.byte	78
	.byte	159
	.xword	.Ltmp322-.Lfunc_begin0
	.xword	.Ltmp327-.Lfunc_begin0
	.hword	3
	.byte	16
	.byte	32
	.byte	159
	.xword	.Ltmp348-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc43:
	.xword	.Ltmp217-.Lfunc_begin0
	.xword	.Ltmp227-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp229-.Lfunc_begin0
	.xword	.Ltmp246-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp247-.Lfunc_begin0
	.xword	.Ltmp263-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp264-.Lfunc_begin0
	.xword	.Ltmp278-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp279-.Lfunc_begin0
	.xword	.Ltmp340-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	.Ltmp348-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc44:
	.xword	.Ltmp217-.Lfunc_begin0
	.xword	.Ltmp227-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp229-.Lfunc_begin0
	.xword	.Ltmp242-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp247-.Lfunc_begin0
	.xword	.Ltmp259-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp264-.Lfunc_begin0
	.xword	.Ltmp280-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp348-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc45:
	.xword	.Ltmp217-.Lfunc_begin0
	.xword	.Ltmp227-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp234-.Lfunc_begin0
	.xword	.Ltmp247-.Lfunc_begin0
	.hword	1
	.byte	83
	.xword	.Ltmp250-.Lfunc_begin0
	.xword	.Ltmp257-.Lfunc_begin0
	.hword	1
	.byte	83
	.xword	.Ltmp288-.Lfunc_begin0
	.xword	.Ltmp327-.Lfunc_begin0
	.hword	1
	.byte	97
	.xword	.Ltmp348-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc46:
	.xword	.Ltmp217-.Lfunc_begin0
	.xword	.Ltmp227-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp266-.Lfunc_begin0
	.xword	.Ltmp279-.Lfunc_begin0
	.hword	1
	.byte	84
	.xword	.Ltmp283-.Lfunc_begin0
	.xword	.Ltmp285-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp285-.Lfunc_begin0
	.xword	.Ltmp327-.Lfunc_begin0
	.hword	1
	.byte	91
	.xword	.Ltmp329-.Lfunc_begin0
	.xword	.Ltmp337-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp348-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc47:
	.xword	.Ltmp217-.Lfunc_begin0
	.xword	.Ltmp226-.Lfunc_begin0
	.hword	2
	.byte	49
	.byte	159
	.xword	.Ltmp247-.Lfunc_begin0
	.xword	.Ltmp248-.Lfunc_begin0
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
	.xword	.Ltmp348-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	2
	.byte	49
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc48:
	.xword	.Ltmp217-.Lfunc_begin0
	.xword	.Ltmp226-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	.Ltmp226-.Lfunc_begin0
	.xword	.Ltmp227-.Lfunc_begin0
	.hword	1
	.byte	95
	.xword	.Ltmp228-.Lfunc_begin0
	.xword	.Ltmp280-.Lfunc_begin0
	.hword	1
	.byte	95
	.xword	.Ltmp348-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
	.hword	3
	.byte	17
	.byte	0
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc49:
	.xword	.Lfunc_begin2-.Lfunc_begin0
	.xword	.Ltmp356-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp357-.Lfunc_begin0
	.xword	.Ltmp358-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp358-.Lfunc_begin0
	.xword	.Lfunc_end2-.Lfunc_begin0
	.hword	1
	.byte	99
	.xword	0
	.xword	0
.Ldebug_loc50:
	.xword	.Ltmp353-.Lfunc_begin0
	.xword	.Ltmp354-.Lfunc_begin0
	.hword	1
	.byte	80
	.xword	.Ltmp354-.Lfunc_begin0
	.xword	.Lfunc_end2-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	0
	.xword	0
.Ldebug_loc51:
	.xword	.Lfunc_begin3-.Lfunc_begin0
	.xword	.Ltmp366-.Lfunc_begin0
	.hword	2
	.byte	48
	.byte	159
	.xword	.Ltmp366-.Lfunc_begin0
	.xword	.Ltmp368-.Lfunc_begin0
	.hword	1
	.byte	88
	.xword	.Ltmp369-.Lfunc_begin0
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
	.byte	17
	.byte	5
	.byte	0
	.byte	2
	.byte	24
	.byte	49
	.byte	19
	.byte	0
	.byte	0
	.byte	18
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
	.byte	19
	.ascii	"\211\202\001"
	.byte	1
	.byte	49
	.byte	19
	.byte	17
	.byte	1
	.byte	0
	.byte	0
	.byte	20
	.ascii	"\212\202\001"
	.byte	0
	.byte	2
	.byte	24
	.ascii	"\221B"
	.byte	24
	.byte	0
	.byte	0
	.byte	21
	.ascii	"\211\202\001"
	.byte	0
	.byte	49
	.byte	19
	.byte	17
	.byte	1
	.byte	0
	.byte	0
	.byte	22
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
	.byte	23
	.byte	40
	.byte	0
	.byte	3
	.byte	14
	.byte	28
	.byte	15
	.byte	0
	.byte	0
	.byte	24
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
	.byte	25
	.byte	15
	.byte	0
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	26
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
	.byte	27
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
	.byte	28
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
	.byte	5
	.byte	39
	.byte	25
	.byte	73
	.byte	19
	.byte	32
	.byte	11
	.byte	0
	.byte	0
	.byte	33
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
	.byte	34
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
	.byte	35
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
	.byte	36
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
	.byte	37
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

	.word	.Linfo_string92
	.byte	3
	.hword	309

	.word	854

	.byte	10
	.word	.Linfo_string8
	.word	756
	.byte	3
	.hword	311
	.byte	9
	.byte	3
	.xword	pvi_wf_get_lut.stype
	.byte	10
	.word	.Linfo_string24
	.word	854
	.byte	3
	.hword	312
	.byte	9
	.byte	3
	.xword	pvi_wf_get_lut.sftemp
	.byte	11
	.word	.Ldebug_loc0
	.word	.Linfo_string96
	.byte	3
	.hword	309
	.word	2190
	.byte	11
	.word	.Ldebug_loc1
	.word	.Linfo_string68
	.byte	3
	.hword	309
	.word	756
	.byte	11
	.word	.Ldebug_loc2
	.word	.Linfo_string57
	.byte	3
	.hword	309
	.word	854
	.byte	11
	.word	.Ldebug_loc3
	.word	.Linfo_string98
	.byte	3
	.hword	309
	.word	854
	.byte	12
	.word	.Ldebug_loc4
	.word	.Linfo_string99
	.byte	3
	.hword	316
	.word	756
	.byte	12
	.word	.Ldebug_loc5
	.word	.Linfo_string75
	.byte	3
	.hword	315
	.word	854
	.byte	12
	.word	.Ldebug_loc6
	.word	.Linfo_string100
	.byte	3
	.hword	314
	.word	854
	.byte	12
	.word	.Ldebug_loc7
	.word	.Linfo_string101
	.byte	3
	.hword	313
	.word	854
	.byte	13
	.word	1471
	.word	.Ldebug_ranges0
	.byte	3
	.hword	334
	.byte	16
	.byte	14
	.word	.Ldebug_loc11
	.word	1483
	.byte	15
	.word	.Ldebug_loc8
	.word	1494
	.byte	15
	.word	.Ldebug_loc9
	.word	1505
	.byte	15
	.word	.Ldebug_loc10
	.word	1516
	.byte	0
	.byte	13
	.word	1528
	.word	.Ldebug_ranges1
	.byte	3
	.hword	335
	.byte	16
	.byte	14
	.word	.Ldebug_loc14
	.word	1540
	.byte	15
	.word	.Ldebug_loc12
	.word	1551
	.byte	15
	.word	.Ldebug_loc13
	.word	1562
	.byte	16
	.word	1579
	.word	.Ldebug_ranges2
	.byte	3
	.byte	196
	.byte	14
	.byte	15
	.word	.Ldebug_loc15
	.word	1602
	.byte	0
	.byte	0
	.byte	13
	.word	1614
	.word	.Ldebug_ranges3
	.byte	3
	.hword	343
	.byte	4
	.byte	14
	.word	.Ldebug_loc16
	.word	1626
	.byte	14
	.word	.Ldebug_loc17
	.word	1637
	.byte	15
	.word	.Ldebug_loc18
	.word	1648
	.byte	15
	.word	.Ldebug_loc19
	.word	1659
	.byte	0
	.byte	13
	.word	1671
	.word	.Ldebug_ranges4
	.byte	3
	.hword	345
	.byte	4
	.byte	14
	.word	.Ldebug_loc20
	.word	1684
	.byte	14
	.word	.Ldebug_loc21
	.word	1696
	.byte	15
	.word	.Ldebug_loc22
	.word	1708
	.byte	15
	.word	.Ldebug_loc23
	.word	1720
	.byte	0
	.byte	13
	.word	1733
	.word	.Ldebug_ranges5
	.byte	3
	.hword	347
	.byte	4
	.byte	14
	.word	.Ldebug_loc24
	.word	1746
	.byte	17
	.byte	1
	.byte	80
	.word	1758
	.byte	15
	.word	.Ldebug_loc25
	.word	1770
	.byte	15
	.word	.Ldebug_loc26
	.word	1782
	.byte	0
	.byte	18
	.word	1471
	.xword	.Ltmp165
	.word	.Ltmp177-.Ltmp165
	.byte	3
	.hword	358
	.byte	16
	.byte	14
	.word	.Ldebug_loc27
	.word	1483
	.byte	15
	.word	.Ldebug_loc28
	.word	1494
	.byte	15
	.word	.Ldebug_loc29
	.word	1505
	.byte	15
	.word	.Ldebug_loc30
	.word	1516
	.byte	0
	.byte	13
	.word	1528
	.word	.Ldebug_ranges6
	.byte	3
	.hword	359
	.byte	16
	.byte	14
	.word	.Ldebug_loc33
	.word	1540
	.byte	15
	.word	.Ldebug_loc31
	.word	1551
	.byte	15
	.word	.Ldebug_loc32
	.word	1562
	.byte	16
	.word	1579
	.word	.Ldebug_ranges7
	.byte	3
	.byte	196
	.byte	14
	.byte	15
	.word	.Ldebug_loc34
	.word	1602
	.byte	0
	.byte	0
	.byte	19
	.word	1795
	.xword	.Ltmp44
	.byte	20
	.byte	1
	.byte	81
	.byte	2
	.byte	134
	.byte	0
	.byte	0
	.byte	21
	.word	1990
	.xword	.Ltmp165
	.byte	19
	.word	1795
	.xword	.Ltmp194
	.byte	20
	.byte	1
	.byte	81
	.byte	2
	.byte	133
	.byte	0
	.byte	0
	.byte	0
	.byte	22
	.word	847
	.word	.Linfo_string23
	.byte	4
	.byte	4
	.byte	15
	.byte	23
	.word	.Linfo_string10
	.byte	0
	.byte	23
	.word	.Linfo_string11
	.byte	1
	.byte	23
	.word	.Linfo_string12
	.byte	2
	.byte	23
	.word	.Linfo_string13
	.byte	3
	.byte	23
	.word	.Linfo_string14
	.byte	4
	.byte	23
	.word	.Linfo_string15
	.byte	5
	.byte	23
	.word	.Linfo_string16
	.byte	6
	.byte	23
	.word	.Linfo_string17
	.byte	7
	.byte	23
	.word	.Linfo_string18
	.byte	8
	.byte	23
	.word	.Linfo_string19
	.byte	9
	.byte	23
	.word	.Linfo_string20
	.byte	10
	.byte	23
	.word	.Linfo_string21
	.byte	11
	.byte	23
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
	.xword	.Lfunc_begin3
	.word	.Lfunc_end3-.Lfunc_begin3
	.byte	1
	.byte	111

	.word	.Linfo_string95
	.byte	3
	.hword	421

	.word	1451

	.byte	10
	.word	.Linfo_string26
	.word	926
	.byte	3
	.hword	424
	.byte	9
	.byte	3
	.xword	pvi_wf_get_version.spi_id_buffer
	.byte	12
	.word	.Ldebug_loc51
	.word	.Linfo_string72
	.byte	3
	.hword	423
	.word	1451
	.byte	0
	.byte	3
	.word	938
	.byte	4
	.word	115
	.byte	32
	.byte	0
	.byte	7
	.word	.Linfo_string27
	.byte	8
	.byte	1
	.byte	24
	.word	.Linfo_string28
	.word	966
	.byte	3
	.byte	40
	.byte	9
	.byte	3
	.xword	waveformdata
	.byte	25
	.word	86
	.byte	24
	.word	.Linfo_string29
	.word	992
	.byte	3
	.byte	42
	.byte	9
	.byte	3
	.xword	global_waveform
	.byte	25
	.word	997
	.byte	26
	.word	.Linfo_string58
	.byte	52
	.byte	3
	.byte	13
	.byte	27
	.word	.Linfo_string30
	.word	1282
	.byte	3
	.byte	14
	.byte	0
	.byte	27
	.word	.Linfo_string33
	.word	1282
	.byte	3
	.byte	15
	.byte	4
	.byte	27
	.word	.Linfo_string34
	.word	1282
	.byte	3
	.byte	16
	.byte	8
	.byte	27
	.word	.Linfo_string35
	.word	86
	.byte	3
	.byte	17
	.byte	12
	.byte	27
	.word	.Linfo_string36
	.word	86
	.byte	3
	.byte	18
	.byte	13
	.byte	27
	.word	.Linfo_string37
	.word	1304
	.byte	3
	.byte	19
	.byte	14
	.byte	27
	.word	.Linfo_string41
	.word	86
	.byte	3
	.byte	20
	.byte	16
	.byte	27
	.word	.Linfo_string42
	.word	86
	.byte	3
	.byte	21
	.byte	17
	.byte	27
	.word	.Linfo_string43
	.word	86
	.byte	3
	.byte	22
	.byte	18
	.byte	27
	.word	.Linfo_string44
	.word	86
	.byte	3
	.byte	23
	.byte	19
	.byte	27
	.word	.Linfo_string45
	.word	86
	.byte	3
	.byte	24
	.byte	20
	.byte	27
	.word	.Linfo_string46
	.word	86
	.byte	3
	.byte	25
	.byte	21
	.byte	27
	.word	.Linfo_string47
	.word	86
	.byte	3
	.byte	26
	.byte	22
	.byte	27
	.word	.Linfo_string48
	.word	86
	.byte	3
	.byte	27
	.byte	23
	.byte	27
	.word	.Linfo_string49
	.word	1282
	.byte	3
	.byte	28
	.byte	24
	.byte	27
	.word	.Linfo_string50
	.word	86
	.byte	3
	.byte	29
	.byte	28
	.byte	27
	.word	.Linfo_string51
	.word	1333
	.byte	3
	.byte	30
	.byte	29
	.byte	27
	.word	.Linfo_string52
	.word	86
	.byte	3
	.byte	31
	.byte	32
	.byte	27
	.word	.Linfo_string53
	.word	1345
	.byte	3
	.byte	32
	.byte	33
	.byte	27
	.word	.Linfo_string54
	.word	86
	.byte	3
	.byte	33
	.byte	37
	.byte	27
	.word	.Linfo_string55
	.word	86
	.byte	3
	.byte	34
	.byte	38
	.byte	27
	.word	.Linfo_string56
	.word	1357
	.byte	3
	.byte	35
	.byte	39
	.byte	27
	.word	.Linfo_string57
	.word	1369
	.byte	3
	.byte	36
	.byte	48
	.byte	0
	.byte	6
	.word	1293
	.word	.Linfo_string32
	.byte	2
	.byte	21
	.byte	6
	.word	847
	.word	.Linfo_string31
	.byte	1
	.byte	27
	.byte	6
	.word	1315
	.word	.Linfo_string40
	.byte	2
	.byte	19
	.byte	6
	.word	1326
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
	.byte	24
	.word	.Linfo_string59
	.word	854
	.byte	3
	.byte	43
	.byte	9
	.byte	3
	.xword	need_pic
	.byte	24
	.word	.Linfo_string60
	.word	854
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
	.byte	28
	.word	847
	.byte	4
	.byte	5
	.byte	10
	.byte	23
	.word	.Linfo_string61
	.byte	0
	.byte	23
	.word	.Linfo_string62
	.byte	1
	.byte	0
	.byte	25
	.word	1456
	.byte	5
	.word	938
	.byte	25
	.word	108
	.byte	25
	.word	854
	.byte	29
	.word	.Linfo_string63
	.byte	3
	.byte	201

	.word	854
	.byte	1
	.byte	30
	.word	.Linfo_string57
	.byte	3
	.byte	201
	.word	854
	.byte	31
	.word	.Linfo_string64
	.byte	3
	.byte	203
	.word	854
	.byte	31
	.word	.Linfo_string65
	.byte	3
	.byte	205
	.word	854
	.byte	31
	.word	.Linfo_string66
	.byte	3
	.byte	204
	.word	854
	.byte	0
	.byte	29
	.word	.Linfo_string67
	.byte	3
	.byte	183

	.word	86
	.byte	1
	.byte	30
	.word	.Linfo_string68
	.byte	3
	.byte	183
	.word	756
	.byte	31
	.word	.Linfo_string69
	.byte	3
	.byte	186
	.word	854
	.byte	31
	.word	.Linfo_string70
	.byte	3
	.byte	185
	.word	1574
	.byte	0
	.byte	25
	.word	81
	.byte	29
	.word	.Linfo_string71
	.byte	3
	.byte	165

	.word	1574
	.byte	1
	.byte	30
	.word	.Linfo_string72
	.byte	3
	.byte	165
	.word	992
	.byte	31
	.word	.Linfo_string70
	.byte	3
	.byte	167
	.word	1574
	.byte	0
	.byte	29
	.word	.Linfo_string73
	.byte	3
	.byte	244

	.word	854
	.byte	1
	.byte	30
	.word	.Linfo_string74
	.byte	3
	.byte	244
	.word	966
	.byte	30
	.word	.Linfo_string75
	.byte	3
	.byte	244
	.word	854
	.byte	31
	.word	.Linfo_string76
	.byte	3
	.byte	247
	.word	966
	.byte	31
	.word	.Linfo_string77
	.byte	3
	.byte	246
	.word	854
	.byte	0
	.byte	32
	.word	.Linfo_string78
	.byte	3
	.hword	270

	.word	854
	.byte	1
	.byte	33
	.word	.Linfo_string74
	.byte	3
	.hword	270
	.word	966
	.byte	33
	.word	.Linfo_string75
	.byte	3
	.hword	270
	.word	854
	.byte	34
	.word	.Linfo_string76
	.byte	3
	.hword	273
	.word	966
	.byte	34
	.word	.Linfo_string77
	.byte	3
	.hword	272
	.word	854
	.byte	0
	.byte	32
	.word	.Linfo_string79
	.byte	3
	.hword	296

	.word	854
	.byte	1
	.byte	33
	.word	.Linfo_string74
	.byte	3
	.hword	296
	.word	966
	.byte	33
	.word	.Linfo_string75
	.byte	3
	.hword	296
	.word	854
	.byte	34
	.word	.Linfo_string76
	.byte	3
	.hword	299
	.word	966
	.byte	34
	.word	.Linfo_string77
	.byte	3
	.hword	298
	.word	854
	.byte	0
	.byte	35
	.xword	.Lfunc_begin1
	.word	.Lfunc_end1-.Lfunc_begin1
	.byte	1
	.byte	109

	.word	.Linfo_string93
	.byte	3
	.byte	220

	.word	854
	.byte	36
	.word	.Ldebug_loc35
	.word	.Linfo_string69
	.byte	3
	.byte	220
	.word	854
	.byte	36
	.word	.Ldebug_loc36
	.word	.Linfo_string101
	.byte	3
	.byte	220
	.word	854
	.byte	37
	.word	.Ldebug_loc37
	.word	.Linfo_string72
	.byte	3
	.byte	222
	.word	1461
	.byte	37
	.word	.Ldebug_loc38
	.word	.Linfo_string86
	.byte	3
	.byte	224
	.word	854
	.byte	37
	.word	.Ldebug_loc39
	.word	.Linfo_string102
	.byte	3
	.byte	223
	.word	1461
	.byte	16
	.word	2001
	.word	.Ldebug_ranges8
	.byte	3
	.byte	241
	.byte	9
	.byte	14
	.word	.Ldebug_loc40
	.word	2013
	.byte	15
	.word	.Ldebug_loc41
	.word	2024
	.byte	15
	.word	.Ldebug_loc42
	.word	2035
	.byte	15
	.word	.Ldebug_loc43
	.word	2046
	.byte	15
	.word	.Ldebug_loc44
	.word	2057
	.byte	15
	.word	.Ldebug_loc45
	.word	2068
	.byte	15
	.word	.Ldebug_loc46
	.word	2079
	.byte	15
	.word	.Ldebug_loc47
	.word	2090
	.byte	15
	.word	.Ldebug_loc48
	.word	2101
	.byte	0
	.byte	0
	.byte	38
	.word	.Linfo_string80
	.byte	4
	.byte	47

	.word	854


	.byte	29
	.word	.Linfo_string81
	.byte	3
	.byte	45

	.word	854
	.byte	1
	.byte	30
	.word	.Linfo_string82
	.byte	3
	.byte	45
	.word	1461
	.byte	31
	.word	.Linfo_string83
	.byte	3
	.byte	47
	.word	847
	.byte	31
	.word	.Linfo_string84
	.byte	3
	.byte	47
	.word	847
	.byte	31
	.word	.Linfo_string85
	.byte	3
	.byte	48
	.word	847
	.byte	31
	.word	.Linfo_string86
	.byte	3
	.byte	49
	.word	847
	.byte	31
	.word	.Linfo_string87
	.byte	3
	.byte	50
	.word	108
	.byte	31
	.word	.Linfo_string65
	.byte	3
	.byte	51
	.word	108
	.byte	31
	.word	.Linfo_string88
	.byte	3
	.byte	52
	.word	2113
	.byte	31
	.word	.Linfo_string91
	.byte	3
	.byte	53
	.word	854
	.byte	0
	.byte	6
	.word	2124
	.word	.Linfo_string90
	.byte	6
	.byte	30
	.byte	7
	.word	.Linfo_string89
	.byte	2
	.byte	1
	.byte	9
	.xword	.Lfunc_begin2
	.word	.Lfunc_end2-.Lfunc_begin2
	.byte	1
	.byte	109

	.word	.Linfo_string94
	.byte	3
	.hword	379

	.word	854

	.byte	11
	.word	.Ldebug_loc49
	.word	.Linfo_string103
	.byte	3
	.hword	379
	.word	2257
	.byte	12
	.word	.Ldebug_loc50
	.word	.Linfo_string104
	.byte	3
	.hword	381
	.word	992
	.byte	0
	.byte	25
	.word	2195
	.byte	26
	.word	.Linfo_string97
	.byte	32
	.byte	4
	.byte	32
	.byte	27
	.word	.Linfo_string75
	.word	847
	.byte	4
	.byte	33
	.byte	0
	.byte	27
	.word	.Linfo_string82
	.word	2240
	.byte	4
	.byte	34
	.byte	8
	.byte	27
	.word	.Linfo_string74
	.word	2245
	.byte	4
	.byte	35
	.byte	16
	.byte	0
	.byte	25
	.word	847
	.byte	3
	.word	966
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
	.xword	.Ltmp27-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges1:
	.xword	.Ltmp27-.Lfunc_begin0
	.xword	.Ltmp43-.Lfunc_begin0
	.xword	.Ltmp95-.Lfunc_begin0
	.xword	.Ltmp97-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges2:
	.xword	.Ltmp28-.Lfunc_begin0
	.xword	.Ltmp29-.Lfunc_begin0
	.xword	.Ltmp30-.Lfunc_begin0
	.xword	.Ltmp35-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges3:
	.xword	.Ltmp48-.Lfunc_begin0
	.xword	.Ltmp50-.Lfunc_begin0
	.xword	.Ltmp51-.Lfunc_begin0
	.xword	.Ltmp60-.Lfunc_begin0
	.xword	.Ltmp97-.Lfunc_begin0
	.xword	.Ltmp117-.Lfunc_begin0
	.xword	.Ltmp138-.Lfunc_begin0
	.xword	.Ltmp148-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges4:
	.xword	.Ltmp61-.Lfunc_begin0
	.xword	.Ltmp63-.Lfunc_begin0
	.xword	.Ltmp64-.Lfunc_begin0
	.xword	.Ltmp74-.Lfunc_begin0
	.xword	.Ltmp118-.Lfunc_begin0
	.xword	.Ltmp137-.Lfunc_begin0
	.xword	.Ltmp148-.Lfunc_begin0
	.xword	.Ltmp158-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges5:
	.xword	.Ltmp75-.Lfunc_begin0
	.xword	.Ltmp76-.Lfunc_begin0
	.xword	.Ltmp77-.Lfunc_begin0
	.xword	.Ltmp95-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges6:
	.xword	.Ltmp177-.Lfunc_begin0
	.xword	.Ltmp193-.Lfunc_begin0
	.xword	.Ltmp201-.Lfunc_begin0
	.xword	.Ltmp204-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges7:
	.xword	.Ltmp178-.Lfunc_begin0
	.xword	.Ltmp179-.Lfunc_begin0
	.xword	.Ltmp180-.Lfunc_begin0
	.xword	.Ltmp185-.Lfunc_begin0
	.xword	0
	.xword	0
.Ldebug_ranges8:
	.xword	.Ltmp217-.Lfunc_begin0
	.xword	.Ltmp222-.Lfunc_begin0
	.xword	.Ltmp228-.Lfunc_begin0
	.xword	.Ltmp340-.Lfunc_begin0
	.xword	.Ltmp348-.Lfunc_begin0
	.xword	.Ltmp350-.Lfunc_begin0
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
	.asciz	"get_wf_mode_index"
.Linfo_string68:
	.asciz	"lut_type"
.Linfo_string69:
	.asciz	"mode"
.Linfo_string70:
	.asciz	"pvi_modes"
.Linfo_string71:
	.asciz	"parse_mode_version"
.Linfo_string72:
	.asciz	"waveform"
.Linfo_string73:
	.asciz	"pvi_wf_a2_repair"
.Linfo_string74:
	.asciz	"wf_table"
.Linfo_string75:
	.asciz	"frame_num"
.Linfo_string76:
	.asciz	"table"
.Linfo_string77:
	.asciz	"f"
.Linfo_string78:
	.asciz	"pvi_wf_gray2_repair"
.Linfo_string79:
	.asciz	"pvi_wf_regal_fix"
.Linfo_string80:
	.asciz	"epd_overlay_lut"
.Linfo_string81:
	.asciz	"decodewaveform"
.Linfo_string82:
	.asciz	"data"
.Linfo_string83:
	.asciz	"oldpic"
.Linfo_string84:
	.asciz	"newpic"
.Linfo_string85:
	.asciz	"frame_tmp"
.Linfo_string86:
	.asciz	"offset"
.Linfo_string87:
	.asciz	"tempdata"
.Linfo_string88:
	.asciz	"israr"
.Linfo_string89:
	.asciz	"_Bool"
.Linfo_string90:
	.asciz	"bool"
.Linfo_string91:
	.asciz	"shift_n"
.Linfo_string92:
	.asciz	"pvi_wf_get_lut"
.Linfo_string93:
	.asciz	"get_wf_frm_num"
.Linfo_string94:
	.asciz	"pvi_wf_input"
.Linfo_string95:
	.asciz	"pvi_wf_get_version"
.Linfo_string96:
	.asciz	"output"
.Linfo_string97:
	.asciz	"epd_lut_data"
.Linfo_string98:
	.asciz	"pic"
.Linfo_string99:
	.asciz	"overlay_lut"
.Linfo_string100:
	.asciz	"mode_index"
.Linfo_string101:
	.asciz	"temp_index"
.Linfo_string102:
	.asciz	"wf_data"
.Linfo_string103:
	.asciz	"waveform_file"
.Linfo_string104:
	.asciz	"pvi_wf"
	.ident	"Android (8508608, based on r450784e) clang version 14.0.7 (https://android.googlesource.com/toolchain/llvm-project 4c603efb0cca074e9238af8b4106c30add4418f6)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym pvi_wf_get_version.spi_id_buffer
	.section	.debug_line,"",@progbits
.Lline_table_start0:
