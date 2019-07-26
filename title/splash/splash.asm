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
	org $2000\ mva #$ff $D301\ rts\ ini $2000

; ---	MAIN PROGRAM
	org $2000
ant	dta $44,a(scr)
	dta $04,$04,$04,$04,$84,$84,$84,$84,$84,$04,$84,$84,$04,$84,$04,$84
	dta $84,$84,$84,$04,$84,$84,$84,$84,$84,$84,$84,$04,$04
	dta $41,a(ant)

scr	ins "splash.scr"

	.ALIGN $0400
fnt	ins "splash.fnt"

	ift USESPRITES
	.ALIGN $0800
pmg	.ds $0300
	ift FADECHR = 0
	SPRITES
	els
	.ds $500
	eif
	eif

main
; ---	init PMG

	ift USESPRITES
	mva >pmg $D407		;missiles and players data address
	mva #$03 $D01D		;enable players and missiles
	eif

	lda:cmp:req $14		;wait 1 frame

	sei			;stop IRQ interrupts
	mva #$00 $D40E		;stop NMI interrupts
	sta $D400
	mva #$fe $D301		;switch off ROM to get 16k more ram

	mwa #NMI $fffa		;new NMI handler

	mva #$c0 $D40E		;switch on NMI+DLI again

	ift CHANGES		;if label CHANGES defined

_lp	lda $D010		; FIRE #0
	beq stop

	lda $D011		; FIRE #1
	beq stop

	lda $D01F		; START
	and #1
	beq stop

	lda $D20F
	and #$04
	bne _lp			;wait to press any key; here you can put any own routine

	els

null	jmp DLI.dli1		;CPU is busy here, so no more routines allowed

	eif


stop
	mva #$00 $D01D		;PMG disabled
	tax
	sta:rne $D000,x+

	mva #$ff $D301		;ROM switch on
	mva #$40 $D40E		;only NMI interrupts, DLI disabled
	cli			;IRQ enabled

	rts			;return to ... DOS

; ---	DLI PROGRAM

.local	DLI

	?old_dli = *

	ift !CHANGES

dli1	lda $D010		; FIRE #0
	beq stop

	lda $D011		; FIRE #1
	beq stop

	lda $D01F		; START
	and #1
	beq stop

	lda $D20F
	and #$04
	beq stop

	lda $D40B
	cmp #$02
	bne dli1

	:3 sta $D40A

	sta $D40A		;line=0
c7	lda #$02
	sta $D40A		;line=1
	sta $D019
c8	lda #$16
	sta $D40A		;line=2
	sta $D017
	sta $D40A		;line=3
c9	lda #$72
	sta $D40A		;line=4
	sta $D016
	sta $D40A		;line=5
c10	lda #$18
	sta $D40A		;line=6
	sta $D017
	sta $D40A		;line=7
c11	lda #$1A
	sta $D40A		;line=8
	sta $D017
c12	lda #$74
c13	ldx #$04
	sta $D40A		;line=9
	sta $D016
	stx $D019
	sta $D40A		;line=10
	sta $D40A		;line=11
c14	lda #$1C
	sta $D40A		;line=12
	sta $D017
c15	lda #$76
c16	ldx #$1E
	sta $D40A		;line=13
	sta $D016
	stx $D017
	sta $D40A		;line=14
c17	lda #$1C
	sta $D40A		;line=15
	sta $D017
c18	lda #$1A
	sta $D40A		;line=16
	sta $D017
c19	lda #$78
	sta $D40A		;line=17
	sta $D016
	sta $D40A		;line=18
	sta $D40A		;line=19
c20	lda #$18
	sta $D40A		;line=20
	sta $D017
	sta $D40A		;line=21
c21	lda #$7A
	sta $D40A		;line=22
	sta $D016
c22	lda #$78
	sta $D40A		;line=23
	sta $D016
	lda >fnt+$400*$01
c23	ldx #$7A
	sta $D40A		;line=24
	sta $D409
	stx $D016
c24	lda #$16
	sta $D40A		;line=25
	sta $D017
	sta $D40A		;line=26
c25	lda #$7C
c26	ldx #$14
c27	ldy #$06
	sta $D40A		;line=27
	sta $D016
	stx $D017
	sty $D019
c28	lda #$7A
	sta $D40A		;line=28
	sta $D016
c29	lda #$16
	sta $D40A		;line=29
	sta $D017
c30	lda #$7C
c31	ldx #$06
	sta $D40A		;line=30
	sta $D016
	stx $D017
c32	lda #$7A
c33	ldx #$26
	sta $D40A		;line=31
	sta $D016
	stx $D017
c34	lda #$7C
c35	ldx #$2A
	sta $D40A		;line=32
	sta $D016
	stx $D018
	lda #$02
	sta $D40A		;line=33
	sta $D01B
	mwa #null null+1
	jmp null

	eif

dli_start

dli2
	sta regA
	lda >fnt+$400*$00
	sta $D40A		;line=48
	sta $D409
	DLINEW dli3 1 0 0

dli3
	sta regA
	stx regX
	lda >fnt+$400*$01
c36	ldx #$7A
	sta $D40A		;line=56
	sta $D409
	stx $D019
	lda #$04
	sta $D40A		;line=57
	sta $D01B
	DLINEW dli4 1 1 0

dli4
	sta regA
	lda >fnt+$400*$02
	sta $D40A		;line=64
	sta $D409
	DLINEW dli12 1 0 0

dli12
	sta regA

	sta $D40A		;line=72
	sta $D40A		;line=73
	sta $D40A		;line=74
c37	lda #$26
	sta $D40A		;line=75
	sta $D018
c38	lda #$C4
	sta $D40A		;line=76
	sta $D017
	DLINEW dli13 1 0 0

dli13
	sta regA
	stx regX
	sty regY

	sta $D40A		;line=80
c39	lda #$6C
	sta $D40A		;line=81
	sta $D016
c40	lda #$7C
	sta $D40A		;line=82
	sta $D016
c41	lda #$6C
	sta $D40A		;line=83
	sta $D016
	sta $D40A		;line=84
c42	lda #$7C
	sta $D40A		;line=85
	sta $D016
c43	lda #$6C
	sta $D40A		;line=86
	sta $D016
c44	lda #$5C
	sta $D40A		;line=87
	sta $D016
	sta $D40A		;line=88
c45	lda #$4C
	sta $D40A		;line=89
	sta $D016
c46	lda #$5C
	sta $D40A		;line=90
	sta $D016
c47	lda #$4C
	sta $D40A		;line=91
	sta $D016
	lda #$01
x4	ldx #$69
c48	ldy #$4A
	sta $D40A		;line=92
	sta $D01B
	stx $D000
	sty $D012
c49	lda #$08
c50	ldx #$78
	sta $D40A		;line=93
	sta $D016
	stx $D019
	DLINEW dli5 1 1 1

dli5
	sta regA
	lda >fnt+$400*$03
	sta $D40A		;line=96
	sta $D409
	sta $D40A		;line=97
	sta $D40A		;line=98
c51	lda #$76
	sta $D40A		;line=99
	sta $D019
	DLINEW dli14 1 0 0

dli14
	sta regA
	stx regX
	sty regY

	lda #$04
	sta $D40A		;line=104
	sta $D01B
c52	lda #$0A
	sta $D40A		;line=105
	sta $D016
c53	lda #$C6
	sta $D40A		;line=106
	sta $D018
	sta $D40A		;line=107
	sta $D40A		;line=108
	sta $D40A		;line=109
	sta $D40A		;line=110
c54	lda #$7A
x5	ldx #$6A
c55	ldy #$12
	sta $D40A		;line=111
	sta $D019
	stx $D000
	sty $D012
c56	lda #$E8
	sta $D40A		;line=112
	sta $D019
	sta $D40A		;line=113
	sta $D40A		;line=114
	sta $D40A		;line=115
	sta $D40A		;line=116
c57	lda #$C6
c58	ldx #$C4
	sta $D40A		;line=117
	sta $D017
	stx $D018
	DLINEW dli6 1 1 1

dli6
	sta regA
	stx regX
	sty regY
	lda >fnt+$400*$04
	sta $D40A		;line=120
	sta $D409
c59	lda #$08
x6	ldx #$68
c60	ldy #$14
	sta $D40A		;line=121
	sta $D016
	stx $D000
	sty $D012
	sta $D40A		;line=122
	sta $D40A		;line=123
	sta $D40A		;line=124
	sta $D40A		;line=125
	sta $D40A		;line=126
c61	lda #$C2
	sta $D40A		;line=127
	sta $D018
	sta $D40A		;line=128
	sta $D40A		;line=129
	sta $D40A		;line=130
	sta $D40A		;line=131
c62	lda #$E6
	sta $D40A		;line=132
	sta $D019
	DLINEW dli15 1 1 1

dli15
	sta regA

	sta $D40A		;line=136
c63	lda #$E4
	sta $D40A		;line=137
	sta $D019
c64	lda #$0A
	sta $D40A		;line=138
	sta $D016
	sta $D40A		;line=139
	sta $D40A		;line=140
c65	lda #$16
	sta $D40A		;line=141
	sta $D019
c66	lda #$14
	sta $D40A		;line=142
	sta $D019
	DLINEW dli7 1 0 0

dli7
	sta regA
	stx regX
	lda >fnt+$400*$05
c67	ldx #$16
	sta $D40A		;line=144
	sta $D409
	stx $D019
c68	lda #$14
	sta $D40A		;line=145
	sta $D019
c69	lda #$16
	sta $D40A		;line=146
	sta $D019
	DLINEW dli16 1 1 0

dli16
	sta regA

	sta $D40A		;line=152
	sta $D40A		;line=153
c70	lda #$08
	sta $D40A		;line=154
	sta $D016
	DLINEW dli17 1 0 0

dli17
	sta regA
	stx regX
	sty regY

	sta $D40A		;line=160
c71	lda #$18
	sta $D40A		;line=161
	sta $D019
c72	lda #$16
	sta $D40A		;line=162
	sta $D019
	sta $D40A		;line=163
c73	lda #$18
	ldx #$02
x7	ldy #$AA
	sta $D40A		;line=164
	sta $D019
	stx $D01B
	sty $D001
c74	lda #$E6
	sta $D013
	sta $D40A		;line=165
c75	lda #$16
	sta $D40A		;line=166
	sta $D019
c76	lda #$18
x8	ldx #$B2
c77	ldy #$E8
	sta $D40A		;line=167
	sta $D019
	stx $D000
	sty $D012
	lda >fnt+$400*$06
	sta $D40A		;line=168
	sta $D409
c78	lda #$06
	sta $D40A		;line=169
	sta $D016
	DLINEW dli18 1 1 1

dli18
	sta regA

c79	lda #$04
	sta $D40A		;line=176
	sta $D016
	DLINEW dli19 1 0 0

dli19
	sta regA

	sta $D40A		;line=184
	sta $D40A		;line=185
	sta $D40A		;line=186
	sta $D40A		;line=187
	lda #$04
	sta $D40A		;line=188
	sta $D01B
	sta $D40A		;line=189
c80	lda #$94
	sta $D40A		;line=190
	sta $D016
	DLINEW dli8 1 0 0

dli8
	sta regA
	lda >fnt+$400*$07
	sta $D40A		;line=192
	sta $D409
	sta $D40A		;line=193
	sta $D40A		;line=194
	sta $D40A		;line=195
c81	lda #$96
	sta $D40A		;line=196
	sta $D016
	DLINEW dli20 1 0 0

dli20
	sta regA

	sta $D40A		;line=200
c82	lda #$98
	sta $D40A		;line=201
	sta $D019
c83	lda #$98
	sta $D40A		;line=202
	sta $D016
c84	lda #$9A
	sta $D40A		;line=203
	sta $D019
	DLINEW dli21 1 0 0

dli21
	sta regA

	sta $D40A		;line=208
	sta $D40A		;line=209
	sta $D40A		;line=210
	sta $D40A		;line=211
	sta $D40A		;line=212
	sta $D40A		;line=213
c85	lda #$9C
	sta $D40A		;line=214
	sta $D019
	DLINEW dli9 1 0 0

dli9
	sta regA
	stx regX
	sty regY
	lda >fnt+$400*$08
c86	ldx #$C8
c87	ldy #$C4
	sta $D40A		;line=216
	sta $D409
	stx $D017
	sty $D018
	DLINEW dli22 1 1 1

dli22
	sta regA

	sta $D40A		;line=224
	sta $D40A		;line=225
	sta $D40A		;line=226
c88	lda #$9A
	sta $D40A		;line=227
	sta $D016
	sta $D40A		;line=228
	sta $D40A		;line=229
	sta $D40A		;line=230
c89	lda #$9E
	sta $D40A		;line=231
	sta $D019

	lda regA
	rti

.endl

; ---

CHANGES = 0
FADECHR	= 0

; ---

.proc	NMI

	bit $D40F
	bpl VBL

	jmp DLI.dli2
dliv	equ *-2

VBL
	sta regA
	stx regX
	sty regY

	sta $D40F		;reset NMI flag

	mwa #ant $D402		;ANTIC address program

	mva #%00111110 $D400	;set new screen width

	inc cloc		;little timer

; Initial values

	lda >fnt+$400*$00
	sta $D409
c0	lda #$00
	sta $D01A
c1	lda #$70
	sta $D016
c2	lda #$1A
	sta $D017
c3	lda #$0C
	sta $D018
c4	lda #$04
	sta $D019
	lda #$02
	sta $D401
	lda #$04
	sta $D01B
s0	lda #$00
	sta $D008
x0	lda #$5D
	sta $D000
c5	lda #$7A
	sta $D012
s1	lda #$00
	sta $D009
x1	lda #$46
	sta $D001
c6	lda #$7A
	sta $D013
s2	lda #$01
	sta $D00C
x2	lda #$70
	sta $D004
x3	lda #$00
	sta $D002
	sta $D003
	sta $D005
	sta $D006
	sta $D007
	sta $D00A
	sta $D00B
	sta $D014
	sta $D015

	mwa #DLI.dli2 dliv	;set the first address of DLI interrupt
	mwa #DLI.dli1 null+1	;synchronization for the first screen line

;this area is for yours routines

quit
	lda regA
	ldx regX
	ldy regY
	rti

.endp

; ---
	ini main
; ---

	opt l-

.MACRO	SPRITES
missiles
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 03 03 03 03 03 03 00 02 03 01 01 03 03 02 02
	.he 01 03 03 03 03 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
player0
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 08 08 08 08 08 18 1C
	.he 1C 1C 1C 3C 3C 3C 3C 3E 7E 7E 7E 7E FE FF FF FF
	.he 1F 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 1F 1F 1F 1F 1F 1F 1F 0F 0F 07 02
	.he 00 00 00 00 00 00 00 FF FF FF FF FF FF FF FF FF
	.he FF FF FF DF ED FC FE FF FF FF 7E BF DF DF FF DF
	.he BF FE 7E FE BE 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 F0
	.he 7C 5C 4E 66 77 FF FF 7F 7F 3F 3F 3F 3F 3F 1F 0E
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
player1
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 08 08 08 08 08 1C 1C 1C 1C 3E 3E 3E 3E 7E
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 04 00 00 01
	.he 82 86 EE EE F3 57 17 1F 3E 3E BE BE FE FC FC F8
	.he F8 F0 C0 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
player2
	.ds $100
player3
	.ds $100
.ENDM

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

