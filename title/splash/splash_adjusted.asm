/***************************************/
/*  Use MADS http://mads.atari8.info/  */
/*  Mode: DLI (char mode)              */
/***************************************/

	icl "splash.h"

	org $f0

fcnt	.ds 2
fadr	.ds 2
fhlp	.ds 2
cloc	.ds 1
regA	.ds 1
regX	.ds 1
regY	.ds 1

WIDTH	= 40
HEIGHT	= 30

; ---	BASIC switch OFF
;	org $2000\ mva #$ff portb\ rts\ ini $2000

scr	equ splashlogoscr
fnt	equ splashlogofnt

; ---	MAIN PROGRAM
	org g2fsplash_org
ant	dta $44,a(scr)
	dta $04,$04,$04,$04,$04,$84,$84,$84,$84,$04,$04,$84,$04,$84,$04,$84
	dta $04,$84,$84,$04,$84,$04,$04,$04,$84,$04,$84,$04,$04
	dta $41,a(ant)

;scrdef	ins "splash.scr.deflate" ;inserted outside

	;.ALIGN $0400
fntdef	equ fontpack
	;ins "splash.fnt.deflate" ;inserted outside

;pmgdef	ins "splash.pmg.deflate" ;inserted outside 

	ift USESPRITES
	;.ALIGN $0800
pmg	equ splashlogopmg
	;.ds $0300
	ift FADECHR = 0
	;SPRITES
	els
	.ds $500
	eif
	eif

main
; ---	init PMG

	ift USESPRITES
	mva >pmg pmbase		;missiles and players data address
	mva #$03 pmcntl		;enable players and missiles
	eif

	lda:cmp:req $14		;wait 1 frame

	sei			;stop IRQ interrupts
	mva #$00 nmien		;stop NMI interrupts
	sta dmactl
	mva #$fe portb		;switch off ROM to get 16k more ram

	mwa #NMI $fffa		;new NMI handler

	;inflate fnt and scr
	;mwa #scrdef inflater.inputPointer
	;mwa #scr inflater.outputPointer
	;jsr inflater.inflate
	;$0480->$092f

	mwa #fntdef inflater.inputPointer
	mwa #fnt inflater.outputPointer
	jsr inflater.inflate
	;$4000->$67ff
	
	;inflate pmg
	;mwa #pmgdef inflater.inputPointer
	;mwa #mypmbase-$100 inflater.outputPointer
	;jsr inflater.inflate
	;$1b00->$1fff

	mva #$c0 nmien		;switch on NMI+DLI again
	ift CHANGES		;if label CHANGES defined

_lp	lda trig0		; FIRE #0
	beq stop

	lda trig1		; FIRE #1
	beq stop

	lda consol		; START
	and #1
	beq stop

	lda skctl
	and #$04
	bne _lp			;wait to press any key; here you can put any own routine

	els

null	jmp DLI.dli1		;CPU is busy here, so no more routines allowed

	eif


stop
	mva #$00 pmcntl		;PMG disabled
	tax
	sta:rne hposp0,x+

	mva #$ff portb		;ROM switch on
	mva #$40 nmien		;only NMI interrupts, DLI disabled
	cli			;IRQ enabled

	rts			;return to ... DOS

; ---	DLI PROGRAM

.local	DLI

	?old_dli = *

	ift !CHANGES

dli1	lda trig0		; FIRE #0
	beq stop

	lda trig1		; FIRE #1
	beq stop

	lda consol		; START
	and #1
	beq stop

	lda skctl
	and #$04
	beq stop

	lda vcount
	cmp #$02
	bne dli1

	:3 sta wsync

	sta wsync		;line=0
	sta wsync		;line=1
c9	lda #$16
	sta wsync		;line=2
	sta color1
	sta wsync		;line=3
c10	lda #$72
	sta wsync		;line=4
	sta color0
c11	lda #$14
	sta wsync		;line=5
	sta color1
c12	lda #$16
	sta wsync		;line=6
	sta color1
c13	lda #$18
	sta wsync		;line=7
	sta color1
c14	lda #$1A
	sta wsync		;line=8
	sta color1
c15	lda #$74
c16	ldx #$04
	sta wsync		;line=9
	sta color0
	stx color3
	sta wsync		;line=10
	sta wsync		;line=11
c17	lda #$1C
	sta wsync		;line=12
	sta color1
c18	lda #$76
c19	ldx #$0E
	sta wsync		;line=13
	sta color0
	stx color1
c20	lda #$1E
	sta wsync		;line=14
	sta color1
c21	lda #$1C
	sta wsync		;line=15
	sta color1
c22	lda #$1A
	sta wsync		;line=16
	sta color1
c23	lda #$78
	sta wsync		;line=17
	sta color0
	sta wsync		;line=18
	sta wsync		;line=19
c24	lda #$18
	sta wsync		;line=20
	sta color1
c25	lda #$16
	sta wsync		;line=21
	sta color1
c26	lda #$7A
c27	ldx #$18
	sta wsync		;line=22
	sta color0
	stx color1
c28	lda #$78
c29	ldx #$1A
	sta wsync		;line=23
	sta color0
	stx color1
	lda >fnt+$400*$01
c30	ldx #$7A
c31	ldy #$18
	sta wsync		;line=24
	sta chbase
	stx color0
	sty color1
	sta wsync		;line=25
c32	lda #$16
	sta wsync		;line=26
	sta color1
c33	lda #$7C
c34	ldx #$14
c35	ldy #$06
	sta wsync		;line=27
	sta color0
	stx color1
	sty color3
c36	lda #$7A
c37	ldx #$12
	sta wsync		;line=28
	sta color0
	stx color1
c38	lda #$16
	sta wsync		;line=29
	sta color1
c39	lda #$7C
c40	ldx #$06
	sta wsync		;line=30
	sta color0
	stx color1
c41	lda #$7A
c42	ldx #$26
	sta wsync		;line=31
	sta color0
	stx color1
c43	lda #$7C
c44	ldx #$2A
	sta wsync		;line=32
	sta color0
	stx color2
	lda #$02
	sta wsync		;line=33
	sta gtictl
	mwa #null null+1
	
	;ntsc 1/6 frame skip
	lda ntsctimer
	cmp #5
	beq @+
	jsr rmt.rmt_play ;music plays between line 33-56, no glitch on NTSC!
@	jmp null

	eif

dli_start

dli2
	sta regA
	stx regX
	sty regY
	lda >fnt+$400*$02
c45	ldx #$7A
	sta wsync		;line=56
	sta chbase
	stx color3
	lda #$08
x7	ldx #$BC
c46	ldy #$0E
	sta wsync		;line=57
	sta gtictl
	stx hposp0
	sty colpm0
	DLINEW dli8 1 1 1

dli8
	sta regA

	sta wsync		;line=64
	sta wsync		;line=65
	sta wsync		;line=66
	lda #$04
	sta wsync		;line=67
	sta gtictl
	DLINEW dli9 1 0 0

dli9
	sta regA
	stx regX
	sty regY

	sta wsync		;line=72
	sta wsync		;line=73
	sta wsync		;line=74
c47	lda #$26
x8	ldx #$79
c48	ldy #$2A
	sta wsync		;line=75
	sta color2
	stx hposp0
	sty colpm0
c49	lda #$C4
	sta wsync		;line=76
	sta color1
	DLINEW dli10 1 1 1

dli10
	sta regA
	stx regX
	sty regY

	sta wsync		;line=80
c50	lda #$6C
	sta wsync		;line=81
	sta color0
c51	lda #$7C
	sta wsync		;line=82
	sta color0
c52	lda #$6C
	sta wsync		;line=83
	sta color0
s5	lda #$01
x9	ldx #$36
c53	ldy #$C6
	sta wsync		;line=84
	sta sizep1
	stx hposp1
	sty colpm1
c54	lda #$7C
	sta wsync		;line=85
	sta color0
c55	lda #$6C
	sta wsync		;line=86
	sta color0
c56	lda #$5C
	sta wsync		;line=87
	sta color0
	lda >fnt+$400*$03
	sta wsync		;line=88
	sta chbase
c57	lda #$4C
	sta wsync		;line=89
	sta color0
c58	lda #$5C
	sta wsync		;line=90
	sta color0
c59	lda #$4C
	sta wsync		;line=91
	sta color0
x10	lda #$69
c60	ldx #$4A
	sta wsync		;line=92
	sta hposp0
	stx colpm0
c61	lda #$06
c62	ldx #$78
	sta wsync		;line=93
	sta color0
	stx color3
c63	lda #$7A
	sta wsync		;line=94
	sta color3
c64	lda #$78
	sta wsync		;line=95
	sta color3
	sta wsync		;line=96
	sta wsync		;line=97
	sta wsync		;line=98
c65	lda #$08
c66	ldx #$76
	sta wsync		;line=99
	sta color0
	stx color3
c67	lda #$78
	sta wsync		;line=100
	sta color3
c68	lda #$76
	sta wsync		;line=101
	sta color3
	DLINEW dli11 1 1 1

dli11
	sta regA
	stx regX
	sty regY

	sta wsync		;line=104
c69	lda #$0A
x11	ldx #$B6
c70	ldy #$08
	sta wsync		;line=105
	sta color0
	stx hposp1
	sty colpm1
c71	lda #$C6
	sta wsync		;line=106
	sta color2
	sta wsync		;line=107
	sta wsync		;line=108
	sta wsync		;line=109
	sta wsync		;line=110
c72	lda #$7A
x12	ldx #$6A
c73	ldy #$12
	sta wsync		;line=111
	sta color3
	stx hposp0
	sty colpm0
	lda >fnt+$400*$04
c74	ldx #$E8
	sta wsync		;line=112
	sta chbase
	stx color3
	sta wsync		;line=113
	sta wsync		;line=114
	sta wsync		;line=115
	sta wsync		;line=116
c75	lda #$C6
c76	ldx #$C4
	sta wsync		;line=117
	sta color1
	stx color2
	DLINEW dli12 1 1 1

dli12
	sta regA
	stx regX
	sty regY

	sta wsync		;line=120
c77	lda #$08
s6	ldx #$00
s7	ldy #$01
	sta wsync		;line=121
	sta color0
	stx sizep1
	sty sizem
x13	lda #$68
	sta hposp0
x14	lda #$B8
	sta hposp1
c78	lda #$14
	sta colpm0
c79	lda #$0A
	sta colpm1
	sta wsync		;line=122
	sta wsync		;line=123
	sta wsync		;line=124
	sta wsync		;line=125
	sta wsync		;line=126
c80	lda #$C2
	sta wsync		;line=127
	sta color2
x15	lda #$5F
c81	ldx #$B8
	sta wsync		;line=128
	sta hposp3
	stx colpm3
s8	lda #$05
x16	ldx #$42
	sta wsync		;line=129
	sta sizem
	stx hposm1
	sta wsync		;line=130
	sta wsync		;line=131
c82	lda #$E6
	sta wsync		;line=132
	sta color3
	DLINEW dli3 1 1 1

dli3
	sta regA
	stx regX
	sty regY
	lda >fnt+$400*$05
	sta wsync		;line=136
	sta chbase
c83	lda #$E4
	sta wsync		;line=137
	sta color3
c84	lda #$0A
	sta wsync		;line=138
	sta color0
	sta wsync		;line=139
	sta wsync		;line=140
c85	lda #$16
	sta wsync		;line=141
	sta color3
c86	lda #$14
	sta wsync		;line=142
	sta color3
x17	lda #$BF
c87	ldx #$0C
	sta wsync		;line=143
	sta hposp0
	stx colpm0
c88	lda #$16
	sta wsync		;line=144
	sta color3
c89	lda #$14
	sta wsync		;line=145
	sta color3
c90	lda #$16
	sta wsync		;line=146
	sta color3
s9	lda #$01
x18	ldx #$68
c91	ldy #$18
	sta wsync		;line=147
	sta sizep2
	stx hposp2
	sty colpm2
	DLINEW dli13 1 1 1

dli13
	sta regA
	stx regX
	sty regY

	sta wsync		;line=152
c92	lda #$C4
s10	ldx #$01
x19	ldy #$BE
	sta wsync		;line=153
	sta color2
	stx sizep1
	sty hposp1
c93	lda #$08
	sta wsync		;line=154
	sta color0
	sta wsync		;line=155
	sta wsync		;line=156
x20	lda #$8A
	sta wsync		;line=157
	sta hposp2
	DLINEW dli4 1 1 1

dli4
	sta regA
	stx regX
	sty regY
	lda >fnt+$400*$06
	sta wsync		;line=160
	sta chbase
c94	lda #$18
s11	ldx #$00
x21	ldy #$79
	sta wsync		;line=161
	sta color3
	stx sizem
	sty hposp0
x22	lda #$9D
	sta hposm0
c95	lda #$0A
	sta colpm0
c96	lda #$16
	sta wsync		;line=162
	sta color3
	sta wsync		;line=163
c97	lda #$18
s12	ldx #$00
x23	ldy #$AA
	sta wsync		;line=164
	sta color3
	stx sizep1
	sty hposp1
c98	lda #$E6
	sta colpm1
x24	lda #$A8
	sta wsync		;line=165
	sta hposm1
c99	lda #$16
	sta wsync		;line=166
	sta color3
c100	lda #$E4
c101	ldx #$18
x25	ldy #$B2
	sta wsync		;line=167
	sta color0
	stx color3
	sty hposp0
c102	lda #$E8
	sta colpm0
	sta wsync		;line=168
	lda #$02
x26	ldx #$5C
c103	ldy #$C8
	sta wsync		;line=169
	sta gtictl
	stx hposp2
	sty colpm2
	sta wsync		;line=170
	sta wsync		;line=171
	sta wsync		;line=172
x27	lda #$C8
c104	ldx #$E8
	sta wsync		;line=173
	sta hposp3
	stx colpm3
	DLINEW dli14 1 1 1

dli14
	sta regA
	stx regX
	sty regY

	sta wsync		;line=176
	sta wsync		;line=177
s13	lda #$00
x28	ldx #$C0
c105	ldy #$E6
	sta wsync		;line=178
	sta sizep2
	stx hposp2
	sty colpm2
	sta wsync		;line=179
	sta wsync		;line=180
	sta wsync		;line=181
	sta wsync		;line=182
s14	lda #$01
x29	ldx #$8E
c106	ldy #$1A
	sta wsync		;line=183
	sta sizep0
	stx hposp0
	sty colpm0
	lda >fnt+$400*$07
	sta wsync		;line=184
	sta chbase
	sta wsync		;line=185
	sta wsync		;line=186
	sta wsync		;line=187
s15	lda #$03
x30	ldx #$A8
c107	ldy #$16
	sta wsync		;line=188
	sta sizep1
	stx hposp1
	sty colpm1
	sta wsync		;line=189
	sta wsync		;line=190
c108	lda #$94
	sta wsync		;line=191
	sta color0
	sta wsync		;line=192
	sta wsync		;line=193
	lda #$08
	sta wsync		;line=194
	sta gtictl
c109	lda #$C8
s16	ldx #$03
x31	ldy #$78
	sta wsync		;line=195
	sta color1
	stx sizep2
	sty hposp2
c110	lda #$C6
	sta colpm2
c111	lda #$96
	sta wsync		;line=196
	sta color0
	sta wsync		;line=197
s17	lda #$00
x32	ldx #$72
c112	ldy #$0C
	sta wsync		;line=198
	sta sizep0
	stx hposp0
	sty colpm0
	sta wsync		;line=199
	sta wsync		;line=200
c113	lda #$98
s18	ldx #$00
x33	ldy #$97
	sta wsync		;line=201
	sta color3
	stx sizep1
	sty hposp1
c114	lda #$E4
	sta colpm1
c115	lda #$98
	sta wsync		;line=202
	sta color0
c116	lda #$9A
x34	ldx #$33
c117	ldy #$F6
	sta wsync		;line=203
	sta color3
	stx hposp3
	sty colpm3
	DLINEW dli5 1 1 1

dli5
	sta regA
	stx regX
	sty regY
	lda >fnt+$400*$08
	sta wsync		;line=208
	sta chbase
	sta wsync		;line=209
s19	lda #$00
x35	ldx #$97
c118	ldy #$1A
	sta wsync		;line=210
	sta sizep2
	stx hposp2
	sty colpm2
	sta wsync		;line=211
	sta wsync		;line=212
	sta wsync		;line=213
c119	lda #$9C
	sta wsync		;line=214
	sta color3
	DLINEW dli15 1 1 1

dli15
	sta regA
	stx regX
	sty regY

	sta wsync		;line=224
	lda #$04
	sta wsync		;line=225
	sta gtictl
s20	lda #$03
x36	ldx #$40
c120	ldy #$CA
	sta wsync		;line=226
	sta sizep0
	stx hposp0
	sty colpm0
c121	lda #$9A
	sta wsync		;line=227
	sta color0
	sta wsync		;line=228
	sta wsync		;line=229
	sta wsync		;line=230
c122	lda #$9E
	sta wsync		;line=231
	sta color3
	lda >fnt+$400*$09
	sta wsync		;line=232
	sta chbase

	lda regA
	ldx regX
	ldy regY
	rti

.endl

; ---

CHANGES = 0
FADECHR	= 0

; ---

.proc	NMI

	bit nmist
	bpl VBL

	jmp DLI.dli2
dliv	equ *-2

VBL
	sta regA
	stx regX
	sty regY

	sta nmist		;reset NMI flag

	mwa #ant dlptr		;ANTIC address program

	mva #scr40 dmactl	;set new screen width

	inc cloc		;little timer

; Initial values

	lda >fnt+$400*$00
	sta chbase
c0	lda #$00
	sta colbak
c1	lda #$70
	sta color0
c2	lda #$1A
	sta color1
c3	lda #$0C
	sta color2
c4	lda #$02
	sta color3
	sta chrctl
	lda #$04
	sta gtictl
s0	lda #$00
	sta sizep0
x0	lda #$5D
	sta hposp0
c5	lda #$7A
	sta colpm0
s1	lda #$00
	sta sizep1
x1	lda #$46
	sta hposp1
c6	lda #$7A
	sta colpm1
s2	lda #$04
	sta sizem
x2	lda #$CA
	sta hposm1
s3	lda #$00
	sta sizep3
x3	lda #$A4
	sta hposp3
c7	lda #$E6
	sta colpm3
x4	lda #$70
	sta hposm0
s4	lda #$00
	sta sizep2
x5	lda #$C4
	sta hposp2
c8	lda #$0A
	sta colpm2
x6	lda #$00
	sta hposm2
	sta hposm3

	mwa #DLI.dli2 dliv	;set the first address of DLI interrupt
	mwa #DLI.dli1 null+1	;synchronization for the first screen line

;this area is for yours routines
	;jsr rmt.rmt_play	;moved to DLI (line 33)
	lda palsystem
	beq quit
	;ntsc part
	inc ntsctimer
	lda ntsctimer
	cmp #6
	bne quit
	mva #0 ntsctimer
quit
	lda regA
	ldx regX
	ldy regY
	rti

.endp

; ---
	;ini main
; ---

	opt l-

/*
.MACRO	SPRITES
missiles
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 08 08 08 08 08 08 00 08 00 0C 0C 0C 04 0C 04
	.he 04 03 03 03 03 03 03 00 02 0F 0D 0D 0F 0F 0E 00
	.he 01 03 03 03 03 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 03 03 03 03 03 04 04
	.he 04 0C 0C 0C 0C 0C 0C 0C 0C 04 04 04 04 04 04 04
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
player0
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 08 00 08 08 08 08 18
	.he 1C 1C 1C 3C 3C 3C 3C 3E 7E 7E 7E 7E FE FF FF FF
	.he 1F BF DF 6F 77 3B 3D 1E 9E 8E 8E 00 00 00 00 00
	.he 00 00 00 87 87 87 87 87 87 87 87 80 87 1F 7F FF
	.he FF FF FF FF 00 1F 1F 1F 1F 1F 1F 1F 0F 0A 05 02
	.he 00 00 00 00 00 00 00 FF FF FF FF FF FF FF FF FF
	.he FF FF FF DF ED FC FE FF FF FF 7E BF DF DF FF DF
	.he BF FE 7E FE BE 00 00 FE FF FF FF FF FE FD FB F7
	.he 00 00 00 00 00 00 00 00 00 7B F9 FC FD FD 00 B0
	.he 78 4C 44 64 74 FC FC 78 78 3C 3C 3C 3C 1C 1C 08
	.he 00 3C 1E 7F 3F FE FE 7C 38 10 00 00 00 00 80 1C
	.he BE 7E 7F FF FF FF 7F 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 FF FF FF FF FF FF
	.he FF FF FF FF FF FF FF FF 00 00 00 00 00 00 00 00
player1
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 08 08 08 08 08 1C 1C 1C 1C 3E 3E 3E 3E 7E
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 FF FF FF FF
	.he FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
	.he 00 7F 3F BF 9F DF DF CF 6F 6B 6B 6B 6F 6B 0F 0B
	.he CF F3 FB FD FC FE FE FE 7F 7F 7F 3F 3F 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 FD FD FD FD FD FD FD 00 00 00 00 00 40 10 41
	.he 53 46 EE F6 EB 67 D7 5F 9F 37 A7 E6 B6 FE FC FC
	.he F8 F0 E0 00 00 00 00 04 0E 1F 1F 3F 7F 7F 3F 1F
	.he 09 FF EF EF DF DF DF DF 5D DF F7 F7 F6 F6 B6 BE
	.he B7 BE FF DB DB EB E3 73 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
player2
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 F0 FF FF FF FF 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 FF FF FF FF FF
	.he FF FF FF FF 7F FF 87 FF FF FF FF FF FF FF 7F 7F
	.he 3F FF FF FF FF FF FF FF FF FF C0 C0 81 13 17 15
	.he 45 57 17 17 1F 0D 06 06 00 00 00 FC FE FE 1F 3F
	.he BF BF BF 00 00 00 00 00 00 00 FF FF FF FF FF FF
	.he FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
player3
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 DF 6F 61 35 BA DA 9F 2E
	.he FF FE 1E 4F 7F 6F 33 00 FF FF FF FF FF FF FF FF
	.he FF FF FF FF FE 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 3C 7C 7E 7E DE D1 E3 F3 FB FD
	.he FF DF DB 5F 5D 7D 7E 6F 6F 37 1E 28 78 77 37 76
	.he 34 22 10 BB 7B 7B 7B 7B 63 6B 7B 7B 7B 7B 7B 7B
	.he 7B 3D BF BF DE DA D2 D2 90 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
.ENDM
*/

USESPRITES = 1

.MACRO	DLINEW
	mva <:1 NMI.dliv
	ift [>?old_dli]<>[>:1]
	mva >:1 NMI.dliv+1
	eif

	ift :2
	lda regA
	eif

	ift :3
	ldx regX
	eif

	ift :4
	ldy regY
	eif

	rti

	.def ?old_dli = *
.ENDM

