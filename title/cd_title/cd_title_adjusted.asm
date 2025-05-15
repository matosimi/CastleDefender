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
;	org $2000\ mva #$ff portb\ rts\ ini $2000

scr	equ titlelogoscr
fnt	equ titlelogofnt

; ---	MAIN PROGRAM
	org g2ftitle_org
ant	dta $F0
	dta $C4,a(scr),$84,$84,$04,$84,$84,$04
	
	;dta $1,a(title_screen.dlcont)
	
	dta $80
	dta $42+32
tcptr	dta a(title_scroll)
:12	dta 2+32
:4	dta 2+32+$80
:3	dta 2+32
	dta 2+$80,$42,a(title_scroll)
	;dta $44,a(title_logo+96)
	dta $41,a(g2ftitle.ant)
	
	
	;dta $70,$70,$70,$70,$70,$70,$70,$70,$70
	;dta $70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70
	;dta $41,a(ant)

;scr	ins "cd_title.scr" ;this is to be inflated...
scrdef	ins "cd_title.scr.deflate"

;	.ALIGN $0400
;fnt	ins "cd_title.fnt"
fntdef	ins "cd_title.fnt.deflate"

/*	ift USESPRITES
	.ALIGN $0800
pmg	.ds $0300
	ift FADECHR = 0
	SPRITES
	els
	.ds $500
	eif
	eif
*/
main
; ---	init PMG
/*
	ift USESPRITES
	mva >pmg pmbase		;missiles and players data address
	mva #$03 pmcntl		;enable players and missiles
	eif
*/
	convert_colors_to_ntsc
	;lda:cmp:req $14		;wait 1 frame
	lda #0			;prevents VSYNC signal being shaved (by switching off DMACTL fetch midscreen)
@	cmp vcount
	bne @-
	
	;sei			;stop IRQ interrupts
	mva #$00 nmien		;stop NMI interrupts
	sta dmactl
	;mva #$fe portb		;switch off ROM to get 16k more ram

	mwa #NMI $fffa		;new NMI handler
	
	;inflate fnt and scr
	mwa #scrdef inflater.inputPointer
	mwa #scr inflater.outputPointer
	jsr inflater.inflate
	;$0480->$07xx

	mwa #fntdef inflater.inputPointer
	mwa #fnt inflater.outputPointer
	jsr inflater.inflate
	;$0800->$0fff

	mva #$40 nmien ;prevents crashing
	lda:cmp:req 20 
	mva #$c0 nmien		;switch on NMI+DLI again
	jmp title_screen.continue
/*
	ift CHANGES		;if label CHANGES defined

_lp	lda trig0		; FIRE #0
	beq stop

	lda trig1		; FIRE #1
	beq stop

	lda consol		; START
	and #1
	beq stop

	;additional stuff

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
*/
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
	;lda >fnt+$400*$00
	sta wsync		;line=56
	;sta chbase
	sta wsync		;line=57
	sta wsync		;line=58
	sta wsync		;line=59
c19	lda #$20
	sta wsync		;line=60
	sta color1
	sta color2
/*c20	lda #$02
c21	ldx #$04
c22	ldy #$06
	sta wsync		;line=61
	sta color0
	stx color1
	sty color2
c23	lda #$0A
	sta color3
*/
	DLINEW title_screen.dlix1 1 1 1
;continues in main source file


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
	inc 20
	;inc cloc		;little timer
	
	
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

/*	lda palsystem
	beq play
	;ntsc part
	inc ntsctimer
	lda ntsctimer
	cmp #6
	bne play
	mva #0 ntsctimer
	jmp quit
	
play	;inc 20
;	mva #$0f colpf0+4
;	jsr rmt.rmt_play
;	mva #$00 colpf0+4
quit
*/
	lda regA
	ldx regX
	ldy regY
	rti

.endp

; PAL->NTSC color rewrite routines
;128 color table that matches PAL colors to NTSC
ntsccolors128
:8	dta #*2
:8	dta #*2+$20	;$10
:8	dta #*2+$30
:8	dta #*2+$40
:8	dta #*2+$50
:8	dta #*2+$60
:8	dta #*2+$70
:8	dta #*2+$80
:8	dta #*2+$90	;$80
:8	dta #*2+$a0	;$90 pal
:8	dta #*2+$b0	;$a0 pal
:5	dta #*2+$d0+2	;$b0 pal
:3	dta #*2+$d0+$a	;$b0 pal second part
:4	dta #*2+$e0+2	;$c0 pal
:4	dta #*2+$e0+8	;$c0 pal second part
:4	dta #*2+$12	;$d0 pal
	dta $e8,$1a,$1c,$1e	;$d0 pal second part 
:8	dta #*2+$f0	;$e0 pal
:8	dta #*2+$20	;$f0 pal	

;returns ntsc color in A based on input pal color (in case ntsc is used)
.proc	getcolor (.byte a) .reg
pptr	lsr @
	stx ntsccolor	;save X-register for DLI calls
	tax
	lda ntsccolors128,x
	ldx ntsccolor
	rts

.proc	setpal
	mva #{rts} pptr
	rts	
.endp
.endp

;one time recolor of menu title screen and ingame screen 
.proc	convert_colors_to_ntsc
begin	lda palsystem
	jeq x0

	;recolor for ntsc
	ldy #0
colorloop	jsr getbyte
	sta w1
	jsr getbyte
	sta w1+1
	lda (w1),y
	getcolor
	sta (w1),y
	
	;check for end of colors
	lda colorindex
	cmp <colors_end
	jne colorloop
	lda colorindex+1
	cmp >colors_end
	jne colorloop
		
x0	mva #{rts} begin	;do not run this anymore
	rts

getbyte	lda colorindex:colors
	inw colorindex
	rts


colors
:6	dta a(NMI.c:1 + 1)
.rept 19-5, #+6
	dta a(DLI.c:1 + 1)
.endr
:16	dta a(title_screen.c_:1 + 1)
:4	dta a(title_screen.tclr:1)
:2	dta a(update_selection.c_:1)
:3	dta a(gameVbi.c_:1)
:6	dta a(gameDli.c_:1)
:4	dta a(color.data0 + :1)
:16	dta a(color.data1 + :1)
	dta a(show_enemybar.c_0)
	dta a(logo.show_defeat.c_0)
	dta a(logo.show_victory.c_0)
	dta a(logo.show_level_complete.c_0)
colors_end
.endp

; ---
	;run main
; ---

	opt l-
/*
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
*/
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


