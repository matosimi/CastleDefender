/***************************************/
/*  Use MADS http://mads.atari8.info/  */
/*  Mode: DLI (char mode)              */
/***************************************/

	icl "cd_title.h"

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
	org $2000\ mva #$ff portb\ rts\ ini $2000

; ---	MAIN PROGRAM
	org $2000
ant	dta $F0
	dta $C4,a(scr),$84,$84,$04,$84,$84,$04,$70,$70,$70,$70,$70,$70,$70,$70,$70
	dta $70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70
	dta $41,a(ant)

scr	ins "cd_title.scr"

	.ALIGN $0400
fnt	ins "cd_title.fnt"

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
	mva >pmg pmbase		;missiles and players data address
	mva #$03 pmcntl		;enable players and missiles
	eif

	lda:cmp:req $14		;wait 1 frame

	sei			;stop IRQ interrupts
	mva #$00 nmien		;stop NMI interrupts
	sta dmactl
	mva #$fe portb		;switch off ROM to get 16k more ram

	mwa #NMI $fffa		;new NMI handler

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

	DLINEW dli6

	eif

dli_start

dli6
	sta regA

	sta wsync		;line=8
c6	lda #$FC
	sta wsync		;line=9
	sta color0
	DLINEW dli7 1 0 0

dli7
	sta regA

	sta wsync		;line=16
	sta wsync		;line=17
	sta wsync		;line=18
c7	lda #$FA
	sta wsync		;line=19
	sta color0
c8	lda #$FE
	sta wsync		;line=20
	sta color0
c9	lda #$FA
	sta wsync		;line=21
	sta color0
	DLINEW dli8 1 0 0

dli8
	sta regA
	stx regX

	sta wsync		;line=24
	sta wsync		;line=25
c10	lda #$14
c11	ldx #$2A
	sta wsync		;line=26
	sta color1
	stx color2
	DLINEW dli9 1 1 0

dli9
	sta regA
	stx regX

	sta wsync		;line=32
	sta wsync		;line=33
	sta wsync		;line=34
	sta wsync		;line=35
	sta wsync		;line=36
	sta wsync		;line=37
c12	lda #$18
	sta wsync		;line=38
	sta color0
c13	lda #$16
c14	ldx #$28
	sta wsync		;line=39
	sta color0
	stx color2
	sta wsync		;line=40
	sta wsync		;line=41
	sta wsync		;line=42
	sta wsync		;line=43
	sta wsync		;line=44
c15	lda #$24
	sta wsync		;line=45
	sta color1
	DLINEW DLI.dli2 1 1 0

dli2
	sta regA
	lda >fnt+$400*$01
	sta wsync		;line=48
	sta chbase
	sta wsync		;line=49
c16	lda #$26
	sta wsync		;line=50
	sta color2
c17	lda #$2C
	sta wsync		;line=51
	sta color2
c18	lda #$26
	sta wsync		;line=52
	sta color2
	DLINEW dli3 1 0 0

dli3
	sta regA
	stx regX
	sty regY
	lda >fnt+$400*$00
	sta wsync		;line=56
	sta chbase
	sta wsync		;line=57
	sta wsync		;line=58
	sta wsync		;line=59
c19	lda #$20
	sta wsync		;line=60
	sta color1
	sta color2
c20	lda #$02
c21	ldx #$04
c22	ldy #$06
	sta wsync		;line=61
	sta color0
	stx color1
	sty color2
c23	lda #$0A
	sta color3

	lda regA
	ldx regX
	ldy regY
	rti

.endl

; ---

CHANGES = 1
FADECHR	= 0

; ---

.proc	NMI

	bit nmist
	bpl VBL

	jmp DLI.dli_start
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
	lda #$02
	sta chrctl
	lda #$04
	sta gtictl
c1	lda #$F4
	sta color0
c2	lda #$F2
	sta color1
c3	lda #$28
	sta color2
c4	lda #$F6
	sta color3
s0	lda #$03
	sta sizep0
x0	lda #$00
	sta hposp0
c5	lda #$F0
	sta colpm0
x1	lda #$00
	sta hposp1
	sta hposp2
	sta hposp3
	sta hposm0
	sta hposm1
	sta hposm2
	sta hposm3
	sta sizep1
	sta sizep2
	sta sizep3
	sta sizem
	sta colpm1
	sta colpm2
	sta colpm3

	mwa #DLI.dli_start dliv	;set the first address of DLI interrupt

;this area is for yours routines

quit
	lda regA
	ldx regX
	ldy regY
	rti

.endp

; ---
	run main
; ---

	opt l-

.MACRO	SPRITES
missiles
	.ds $100
player0
	.ds $100
player1
	.ds $100
player2
	.ds $100
player3
	.ds $100
.ENDM

USESPRITES = 0

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

