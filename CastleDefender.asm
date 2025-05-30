;Castle Defender v1.4 - Martin Simecek, http://matosimi.atari.org

hposp0	equ $d000
hposm0	equ $d004
sizep0	equ $d008
sizem	equ $d00c
trig0	equ $d010
colpm0	equ $d012
colpf0	equ $d016
colbk	equ $d01a
prior	equ $d01b
vdelay	equ $d01c ;shift PM by 1 scanline, first missiles,then players(bits)
gractl	equ $d01d ;BIT1-ACTIV.PMG
consol	equ $d01f
audctl	equ $d208
kbcode	equ $d209
random	equ $d20a
irqen	equ $d20e
skctl	equ $d20f
porta	equ $d300 ;stick 0,1
portb	equ $d301
dmactl	equ $d400
dlistl	equ $d402
hscrol	equ $d404
vscrol	equ $d405
pmbase	equ $d407
chbase	equ $d409
wsync	equ $d40a
vcount	equ $d40b
nmien	equ $d40e
nmist	equ $d40f
sdlstl	equ $0230 ;dl vector when osrom is on
color0	equ $02c4	;color0 when osrom is on

;zero page:
ntsccolor	equ $6f ;to store x-register for pal->ntsc recolor (in splash_adjusted.asm)
                  ;and cd_title_adjusted.asm
zspos	equ $70 ;8bytes
zsoff	equ $78 ;8bytes
zt	equ $80
sy	equ $80
sx	equ $81
lastplotidx	equ $82
lastplot	equ $83

inflate_zp	equ $a0	;10 bytes for inflater
starting_level	equ $ae
unlocked_level	equ $af	
vbi_ptr	equ $b0 ;vbi vector
dli_ptr	equ $b2 ;dli vector
w1	equ $b4 
w2	equ $b6
xshift	equ $b8 ;contains horizontal sprite shift
keystat	equ $b9
keypres	equ $ba
b1	equ $bc
bulright	equ $bd ;bullet on right part of char
b2	equ $be
sbarvisib	equ $bf ;status bar visible = 1(top),2(bottom),0(none)
sbarselec	equ $c0 ;status bar selection = 0(none selected)
sbarmax	equ $c1 ;status bar - max line index to select
sbarmin	equ $c2 ;status bar - min line index to select
stick	equ $c3 ;stick status (no repeat)
trig	equ $c4 ;trig status (no repeat)
vsynccount	equ $c5 ;some original counter
spritefilenumber	equ $c6 ;some original counter
ntsctimer	equ $c7 ;0-5 frame counter of NTSC->PAL speed
palsystem	equ $c8 ;0-pal, 1-ntsc
mono	equ $c9 ;0-mono, $ff-stereo
fastloop	equ $ca ;if fire is held 20 cycles -> same as space pressed
;$cb-$de RMT player
;$f0-$ff G2F

;memory areas
lephtmp	equ $0200 ;temp space for level,phase text
temppage	equ $0300 ;temporary page (loading)
keytable	equ $0400 ;128 bytes - table of keycodes 
leveldata	equ $0480 ;where leveldata to be inflated
		;until $1aad
mypmbase	equ $1c00 ;$1b00-$1fff
maincode	equ $2000 ;where code starts (until $3fff)
gamevram	equ $4000 ;videoram (until $5fff)+$100 for additional buffer
gamevram.logo	equ gamevram+$0c00
gamevram.enemies	equ gamevram+$1b00
gamevram.status	equ gamevram+$1d00
scorebrd	equ gamevram+$1c00

;different code loop with data on same spot at gamevram
titlelogoscr	equ leveldata		;280 bytes
titlelogofnt	equ leveldata+$380		;$0800-$0fff 
;music		equ $1000			;$1000-$14ff


title_scroll	equ gamevram
title_static	equ title_scroll+$1000
titlefont		equ title_scroll+$1800	;to $57ff+$400

;3rd data rewrite (splash screen)
;splashlogoscr	equ leveldata		;to $0930: 1200 bytes
;watch out!, music is still inplace from $1000-$14ff
splashlogofnt	equ gamevram

code2	equ $6880 ;continue of code
;splash picture reaches 67ff, its deflated part goes to 687f

;space until $ab00

;deflated data (data_relocator.asm)
;	    $ab00 - $cfff
;	    $d800 - $fff6



;constants (from headercode.asm)
sprows	equ 14
spritesiz	equ sprows*18 	; 252 Size of sprites in bytes
enemyno	equ 64          	; Number of enemies in a wave
towrno 	equ 16           	; Maximum number of towers
nosprites equ 4		; Number of different sprites

	org leveldata
;initialized (inflated) data
typos	.ds towrno	; Location of tower y pos table
txpos	.ds towrno	; Location of tower x pos table
path	.ds 1790		; Location of path (length 1790)
maxlocation
activetowers .ds 2		; number of active towers
;uninitialized data
ehealth	.ds enemyno	; Location of enemy health table
eshield	.ds enemyno	; Location of enemy shield table
ttype	.ds towrno	; Location of tower type table
tfcount	.ds towrno	; Location of tower fire count table
tftarget	.ds towrno	; Location of tower fire target table
tftargetx	.ds towrno	; Location of tower fire target x position table
tftargety	.ds towrno	; Location of tower fire target y position table
sprites	.ds nosprites*spritesiz ;Location of preshifted sprites
expl	.ds 4*spritesiz	; Location of preshifted explosions
tempsprit .ds 6*sprows	; Location of tempsprite (hit sprite)

leveldata_end

score		.ds 4
wave		.ds 1
level		.ds 1
enemieskilled	.ds 2
;attractmode	.ds 1
lives		.ds 1
gold		.ds 3
enemystart 	.ds 1
enemyend		.ds 1
enemytimer 	.ds 1
enemyoffset 	.ds 2
lastkeypressed 	.ds 1
currentlocation 	.ds 1
leftupdaterequired 	.ds 1
remaincounter 	.ds 1

pathendx		.ds 1
pathendy		.ds 1
enemyatend 	.ds 1
fcoldl		.ds 8
fcoldh		.ds 8
fcnewl		.ds 8
fcnewh		.ds 8
fctype		.ds 8
fcstore		.ds 32
fcnewright 	.ds 8
fcoldright 	.ds 8
textcolour 	.ds 1
previoustower 	.ds 1
cursordisplayed 	.ds 1
cursorcount	.ds 1
gamespeed		.ds 1
scoretoadd	.ds 4
loadfileblock	.ds 18
openfile		.ds 1
firesoundtype	.ds 1
lasthitsprite	.ds 1
startdelay	.ds 1

wavedata	; Wave data structure - inflated
goldvalues	.ds 4 ; Values of gold for each enemy (bcd)
enemystrengths	.ds 4
enemyshields	.ds 4
enemyspeed	.ds 2 ; distance between enemies in frames
spritenumbers	.ds 4 ; Types of enemy
numberofenemies	.ds 1
etype		.ds enemyno ; Enemy type list - reserve bytes

wavedataend

allsprites	.ds 644 ;sprite gfx - inflated
varend

.print "leveldata_from:",leveldata
.print "leveldata_end:",leveldata_end
.print "wavedata: ",wavedata
.print "wavedata_end: ",wavedataend
.print "var_end:      ",varend
	
	;do not allow uninitialized data reach the pmbase (missile area)
	guard mypmbase-$100
	;do not allow uninitialized data reach the maincode
	guard maincode 
	
	icl "matosimi_macros.asx"
	
	;initialization - loading screen
.local loading_screen
	org gamevram+$400
lodl	dta $70
	dta $4a,a(lodata)
:47	dta 10
	dta $42,a(lotext)
	dta $10	
:4	dta $4f,a($2000+:1*$800)
:8	dta $4f,a($6400+:1*$800)
:5	dta $4f,a($ab00+:1*$800)
:5	dta $4f,a($d800+:1*$800)
	dta $41,a(lodl)
lodata	ins "uh6.gr5",0,20*50 ;"cd.gr5"
lotext	dta d"    Castle Defender v1.4 - 15.05.2025   "

loading	mva #>lofont 756
	mva #$0e color0
	mva #$94 color0+1
	mva #$9a color0+2
	mva #$00 color0+4
	mva #$ff portb	;turn off basicrom	
	mwa #lodl sdlstl
	pause 1
;detect_stereo
	; By Draco
	; http://drac030.krap.pl/en-si-info.php
	sei
	mvx #0 SKCTL
	stx SKCTL+$10
	mvy #3 SKCTL+$10
	:2 sta WSYNC
	lda RANDOM
detect_loop
	and RANDOM
	inx
	bne detect_loop
	sty SKCTL
	cmp #$FF
	beq stereo_detected
	mva #0 mono
stereo_detected
	sta mono
;detect video system
	mva #0 palsystem
	sta ntsctimer
	ldx 20
	inx
	inx
x1	lda vcount
	a_lt palsystem x2
	sta palsystem
x2	cpx 20
	bne x1
	lda palsystem
	a_lt #140 sys_ntsc
	mva #0 palsystem
	cli
	rts
sys_ntsc	mva #1 palsystem
	cli
	rts
	ini loading

	org gamevram
lofont	ins "title\title.fnt"
	
.endl
	
	icl "data_relocator.asm"
	
	run maincode
	org maincode
;  GUARD $3000-40	; So we can load code without losing it between screen modes.
;atari remove	codeoffset=$0900
;.print "Assembling for ",codeoffset

	;38.12

start
	sei
	;keyboard init
	ldy #$7f
copykeytab
        	lda ($79),y ; pointer to keytable in osrom
        	sta keytable,y
        	dey
        	bpl copykeytab

	pause 1
	
	mva #$00 nmien
	sta irqen 	;disable interupts (keyboard)
	mva #$fe portb	;turn off osrom and basicrom	
	
	lda #0		;init pokey(s) to continue playing 
			;music without additional rmt.init after loading
	sta audctl
	sta audctl + $10
	ldy #3
	sty skctl
	sty skctl + $10
	
	mva #8 consol	;reset consol
	gameparams_init
	
gameloop	title_screen
	game_init
	
	;; Turn sound on/off for attract mode
/* atari off
	ldy #0
	ldx attractmode
	lda #$d2
	jsr $fff4
*/
	; ORG $1c20
	;.setjump
	;jMP setup
	;.mainjump
	;jMP mainloop
	;.plotjump
	;jMP plotlots
	;.towerjump
	;jMP plottower
	;.boxjump
	;jmp drawbox

  ; Main loop
setup
	;Turn on interrupts

	;Set up palette
	;lda #$26:sta pal1
	;lda #$a1:sta pal2

	;jsr initinterrupts

/* atari off - explosions loaded as data block
	lda #19
	jsr $fff4
	lda #1
	sta intflag
	; One per Game setup

	jsr loadexplosions
*/
	color.black
	
	/* already initialized to 0
	;Reset score
	lda #0
	sta score
	sta score+1
	sta score+2
	sta score+3

	; Reset enemies killed
	sta enemieskilled
	sta enemieskilled+1
*/

	lda #$a1 ;debug a5
	sta wave
	lda #$a0
	ora starting_level
	sta level	; Level set by basic (not anymore)
	;TODO:check the level stuff from acorn basic
	
	; Once per "Screen" setups

newlevel
;atari debug {
	;jsr showlevlogo
	;jmp *
; }

	;jsr clearstatusbox  ;3 lines at the bottom
	;showwave 	;Level 1 Wave 1 (in the box)
	;load screen (should include screen $ Path $ tower positions)
	sfx.next_level
	jsr loadscreen
	level_pmg
	; Clear tower types structures
	ldx #towrno-1
	lda #0
	sta fastloop
	sta handle_joystick.repeat

ttypeclear
	sta ttype,X
	dex
	bpl ttypeclear

	; Reset Gold $ Lives

	lda level
	and #$07
	asl @
	asl @
	tax
	lda goldlevels-4,X
	sta gold
	lda goldlevels-4+1,x
	sta gold+1
	lda goldlevels-4+2,X
	sta gold+2

	lda #$20
	sta lives

;atari add {
	;mva #$99 gold+1 ;debug - lot of gold

	lda level
	sub #$a1
	tax
	color.fade_in_from_black
;}


	; Draw blank towers
	ldx activetowers
	lda #100
	sta previoustower
drawblanktowersloop
	;pha
	txa
	pha
	jsr plottower
	lda previoustower
	clc
	adc #8
	sta previoustower
	tax
	ldy #5

/*atari remove
	lda attractmode ;TODO: ???
	bne skipblanktowers		; Don't plot towers in attact mode

	lda #$13
	jsr bongsound

	lda #11
	jsr delay ;atari DEBUG OUT
*/
;atari add {
	pause 5
	ldy #sfx.CURSOR
	sfx.do
; }

skipblanktowers
	pla
	tax
	dex
	bpl drawblanktowersloop

	; Set initial variables. Ideally these should come from the level definition
	ldx #0

	;Set cursor to be "off"
	stx cursordisplayed
	stx cursorcount

	stx currentlocation             ; Draw initial "cursor" - Should be new "screen" rather than wave

	; Wave base setups setups
newwave
	; Clear sprite row
	jsr deletestatusrows
	lda #15
	sta remaincounter
	lda #$ff
	sta previoustower
	jsr clearstatusbox
	showwave

	; Clear Sprite storage area
	ldx #0
	lda #0
clearspritesloop
	sta sprites,X
	sta sprites+spritesiz,X
	sta sprites+spritesiz*2,X
	sta sprites+spritesiz*3,X
	inx
	cpx #spritesiz
	bne clearspritesloop

	;Setup status display
	jsr printgold
	jsr printlives
	jsr printscore

	; Load wave data
	jsr loadwave ;atari off - no operation ATM
	jsr printleft

	; Can this be called once per "wave"?
	lDA #path % 256
	sTA enemyoffset
	lDA #path / 256
	sTA enemyoffset+1
	lda #1
	sta enemyend
	lDA enemyspeed
	sTA enemytimer     ; store the enemy speed (time between enemies) - initial timer value
	lda #255
	sta lasthitsprite	; Reset last hit sprite
	;cLC
	;asl @
	;sTA enemyspeed+1    ; Since the offset is x,y need to store a double speed
	; clear out the fire target and counts
	ldx #towrno-1
	lda #0
setuptclear

	sta tfcount,X 
	sta tftarget,X
	sta tftargetx,X
	sta tftargety,X
	dex
	bpl setuptclear

	; Find the last coordinate in the path that is an actual coordinate
/* atari replace
	lda #$3ffe % 256
	sta $70
	lda #$3ffe / 256
	sta $71
	*/
	mwa #activetowers $70

setupfindendloop
	ldy #1
	lda ($70),Y
	cmp #255
	bne setupfoundend
	lda $70
	sec
	sbc #2
	sta $70
	lda $71
	sbc #0
	sta $71
	jmp setupfindendloop

setupfoundend
	sta pathendy
	dey
	lda ($70),y
	sta pathendx



	;Load and colour sprite
	lda #3
	sta $88         ; Loop counter
loadspriteloop
	ldx $88
	lda spritenumbers,X
	sta spritefilenumber

	; Load sprites for wave
	;jsr loadspritefile
	choose_sprites

	mwa #temppage $70
	;lda #<(expl+(spritesize*4))
	;sta $70
	;lda #>(expl+(spritesize*4))
	;sta $71         ; Store where sprites are coped from

	lda $88
:2	asl @
	asl @     ; Multiply location by 4 for table
	tax             ; Move to X for offset.
	lda spritelowtable,X
	sta $72
	lda spritehightable,x
	sta $73         ; Store where the result needs to be put
	ldy #spritesiz-1
	;ATARI add
coolloop
	mva ($70),y ($72),y
	dey
	bne coolloop
	
	dec $88
	bmi finishloadsprites
	jmp loadspriteloop
	
/* ATARI rest ignored (TEST)
	lda #0
	sta ($72),y      ; Clear destination
colourcopyloop
	lda $88
	asl @
	adc $88           ;Multiply offset by 3
	adc #2          ; Add 2 to get to upper value in table
	sta $87         ; Save offset for later
	lda #2
	sta $86  ; Loop counter for colours         
colourcopyloop2
	ldx $86
	lda colourtable,X      ; Colour table of comparison colours
	sta $80         ; Store for processing
	lda colourtable+2       ; Get pixel mask for pixels
	sta $82         ; store for processing
	ldx $87         ; required destination colour
	lda spritecolours,X
	sta $81         ; Store for processing

	ldx #4          ; Loop counter for pixels in byte
colourcopyloop3
	lda ($70),y     ; Get pixel to be checked
	and $82         ; Mask the bits to be checked
	beq nopixelmatch        ; Skip if there are no pixels
	eor $80         ; if bits are set then xor will make zero
	;cmp $80         ; check if it is the same as the colour
	bne nopixelmatch        ; Skip if not
	lda ($72),y
	ora $81
	sta ($72),Y
nopixelmatch
	asl $80         ; Shift pixel match
	asl $81         ; And colour match
	asl $82         ; And pixel mask
	dex
	bne colourcopyloop3
	dec $87         ; colour offset table
	dec $86         ; Colour loop counter
	bpl colourcopyloop2

	lda #0
	sta ($70),y     ; Clear sprite
	dey
	bne colourcopyloop
	dec $88
	bmi finishloadsprites
	jmp loadspriteloop
*/
finishloadsprites
	;sprite_preshift
;atari add {
;	sprite_test
;	jmp *
;}

	;draw wave sprites
	lda #1
	ldy #enemyno-1
	sta etype,Y
	sty $8d
	lda #3 ;#16
	sta sx
	lda #212
	sta sy
	jsr plotter

	inc etype+enemyno-1
	lda #3+64 ;16+64
	sta sx
	lda #212
	sta sy
	jsr plotter

	inc etype+enemyno-1
	lda #3+64+64 ;16+64+64
	sta sx
	lda #212
	sta sy
	jsr plotter

	inc etype+enemyno-1
	lda #3+64+64+64 ;16+64+64+64
	sta sx
	lda #212
	sta sy
	jsr plotter

	;Print enemy health values
	
;	lda #%00001111
;	sta textcolour 
	lda #4 ;8
	sta $70
	lda #27
	sta $77
	lda #(enemystrengths) % 256
	sta $74
	lda #(enemystrengths) / 256
	sta $75
	ldx #0
;atari replace {
;	jsr numberplot          
	numberplot_atari
; }

	lda #4+16 ;24
	sta $70
	;lda #27:sta $77
	lda #(enemystrengths+1) % 256
	sta $74
	lda #(enemystrengths+1) / 256
	sta $75
	ldx #0
;atari replace {
;	jsr numberplot          
	numberplot_atari
; }         

	lda #4+32 ;40
	sta $70
	;lda #27:sta $77
	lda #(enemystrengths+2) % 256
	sta $74
	lda #(enemystrengths+2) / 256
	sta $75
	ldx #0
;atari replace {
;	jsr numberplot          
	numberplot_atari
; }          

	lda #4+16+32 ;56
	sta $70
	;lda #27:sta $77
	lda #(enemystrengths+3) % 256
	sta $74
	lda #(enemystrengths+3) / 256
	sta $75
	ldx #0
;atari replace {
;	jsr numberplot          
	numberplot_atari
; }         

	; Print enemy shield values
;	lda #%11111111
;	sta textcolour 
	lda #10 ;#11
	sta $70
	;lda #27:sta $77
	lda #(enemyshields) % 256
	sta $74
	lda #(enemyshields) / 256
	sta $75
	ldx #0
;atari replace {
;	jsr numberplot          
	numberplot_atari
	mva #10-2 $70
	ldx #13*8+7
	charplot_atari
; }     
		
	lda #10+16 ;27
	sta $70
	;lda #27:sta $77
	lda #(enemyshields+1) % 256
	sta $74
	lda #(enemyshields+1) / 256
	sta $75
	ldx #0
;atari replace {
;	jsr numberplot          
	numberplot_atari
	mva #10+16-2 $70
	ldx #13*8+7
	charplot_atari
; }          

	lda #10+32 ;43
	sta $70
	;lda #27:sta $77
	lda #(enemyshields+2) % 256
	sta $74
	lda #(enemyshields+2) / 256
	sta $75
	ldx #0
;atari replace {
;	jsr numberplot          
	numberplot_atari
	mva #10+32-2 $70
	ldx #13*8+7
	charplot_atari
; }          

	lda #10+16+32 ;59
	sta $70
	;lda #27:sta $77
	lda #(enemyshields+3) % 256
	sta $74
	lda #(enemyshields+3) / 256
	sta $75
	ldx #0
;atari replace {
;	jsr numberplot          
	numberplot_atari
	mva #10+16+32-2 $70
	ldx #13*8+7
	charplot_atari
; }         

	lda #0
	ldy #enemyno-1
	sta etype,Y

	; Populate shield and health values
	ldx #0
populatehsloop
	lda #0
	sta ehealth,x
	sta eshield,x                   ; Write zero to health and shield
	ldy etype,x
	beq skippopulatehs              ; If no emeny defined skip
	dey
	lda enemystrengths,y
	sta ehealth,x
	lda enemyshields,y
	sta eshield,x
skippopulatehs
	inx
	cpx #enemyno
	bne populatehsloop

	; Wait until sufficcient time has passes
	;.newwavewaitloop
	;lda vsynccount
	;cmp #200
	;bcc newwavewaitloop

	;jsr printtowerinfo

	lda #0
	sta enemystart
	;jsr levelstartsound
	lda #175
	sta startdelay 
;atari add {
	jsr forceprinttowerinfo ;render 1st tower control bar
; }
	;jmp gameover       ; this will be removed in normal operation

mainloop             ;Main processing loop
	lda #0
	sta vsynccount       ; Reset frame counter
	sta leftupdaterequired	; Reset if we need up date the number left
	sta lastplotidx       ; Reset the last plotted index position
	sta lastplot          ; Reset the last plotted position
	sta enemyatend        ; index of an enemy that has reached the end

	ldx startdelay		; Pause before we get going
	beq notinstartdelay
	dex
	stx startdelay
	cpx #75 ;25
	bne instartdelay
/*atari remove {
	jsr levelstartsound	; Make start sound	Slightly before start to sync enemies appearing
*/	sfx.next_phase
	jsr forceprinttowerinfo

	jmp instartdelay
;	cpx #1		; Are we on the last frame?
;	bne instartdelay
;	ldx #0
;	stx startdelay			; and set delay to zero
notinstartdelay
	jsr showwave.restore
	jSR plotlots          ; Plot all the visible sprites
	jsr drawbullets       ; Plot the "in flight" bullets
	jSR towerfire         ; Calculate and plot the firing
	jsr updateenemyline   ; Move the line head and tail

instartdelay
	jsr keyboard          ; Get keyboard input and update towers.
	jsr showstatus        ; Update status bar
	jsr flashcursor

	lda leftupdaterequired
	beq noleftupdate
	jsr printleft

noleftupdate 

	;lda #0
	;sta $7ff8
	;sta $7ff9
	;sta $7ffa
	;sta $7ffb
	;sta $7ffc

	;lda #255
wait
	;lda vsynccount
	;asl @:tax:lda #255
	;sta $7ff8,x
	lda vsynccount
	cmp gamespeed
	bcc wait              ; overall speed <= no. of frames

	lda lives
	jeq gameover		; If there are zero lives then game over

	;lda attractmode
	;beq notgameover		; Don't check for a key if we're not in attract mode
	lda $ec
	bne gameover		; If a key is pressed exit immediatly

notgameover
	lda numberofenemies
	bne enemiesremain
	dec remaincounter
	beq wavefinished

enemiesremain
	lda enemystart
	cmp #enemyno-1
	bne mainloop

wavefinished
	; Wave finished - add gold * 100 to score
	set_status0	;hide status bar if shown
	ldx #3
addgoldtoscoreloop
	lda gold-1,x
	sta scoretoadd-1,x
	dex
	bne addgoldtoscoreloop
	jsr addscore

	ldx wave
wavebonusgoldloop
	lda lives
	pha
	jsr addgold
	pla
	pha
	jsr addgold
	pla
	pha
	jsr addgold
	pla
	pha
	jsr addgold
	pla
	dex
	cpx #$a0
	bne wavebonusgoldloop

	ldx wave
	inx
	cpx #$a6		; 5 Waves per level
	beq nextlevel
	stx wave
	jmp newwave

nextlevel
	; Show new level screen
	jsr showlevlogo

	;Reset Wave Counter
	lda #$a1
	sta wave

/* atari off - TODO: handle next level load

	;Close wave file

	lda #0
	ldy openfile
	sta openfile
	jsr $ffce
*/
	; Add lives $ 10000 to score
	lda lives
	sta scoretoadd+1
	jsr addscore

	;Increment Level counter
	ldx level
	inx
	stx level		; Store level before compare to allow highscore to work.
	cpx #$a5
	beq winner
	x_lt #$a2 @+
	;unlock level
	txa 
	and #$0f
	a_lt unlocked_level @+
	;perform unlock
	sta unlocked_level
		
@	color.fade_out_to_black2
	jmp newlevel

gameover
	; We're dead - finish and return.
/* atari off
	;Close open files
	ldy openfile
	beq noopenfile
	lda #0

	jsr $ffce

noopenfile

	;lda #50
	;jsr delay
	lda attractmode
	bne returntobasic	; Skip "game over" message for attract mode
*/
	jsr showloselogo
/* atari remove
returntobasic
	lda #0
	sta intflag

;	rTS                   ; Return back to basic.
*/

;atari add {
	music_init
	jmp gameloop
;}

winner
	;We've won.
	jsr showwinlogo
	music_init
	jmp gameloop

flashcursor
	inc cursorcount
	lda cursorcount
	cmp #12			; Below 15 the cursor should be on
	bcs cursoroff
	lda cursordisplayed
	bne finishcursor			; If it's not zero then cursor is laready plotted 
	ldx currentlocation
	jmp plotbox			; Plot the cursor and finish
cursoroff
	cmp #20			; Between 15 and 25 cursor is off
	beq resetcursorcount
	lda cursordisplayed
	beq finishcursor
	ldx currentlocation
	jmp erasebox

resetcursorcount
	lda #0
	sta cursorcount
finishcursor
	rts

	;53.25
	;44.05 2714 frames

goldlevels		; Extra byte as padding to allow 4 offset
	dta $00,$02,$80,$00
	dta $00,$05,$50,$00
	dta $00,$12,$00,$00
	dta $00,$17,$00,$00
	;dta $00,$10,$00,$00

reduceleft		; Reduce the number of enemies left
	;pha
	sed
	lda numberofenemies
	sta leftupdaterequired	; Set the flag for a redraw
	sec
	sbc #1
	sta numberofenemies
	cld
	;pla
	rts

delay
	pha
	lda #0
	sta vsynccount
	pla
delayloop
	cmp vsynccount
	bcs delayloop
	rts

updateenemyline
  ; move the line head and tail
	iNC enemyoffset       
	iNC enemyoffset       ; add 2 to enemy offset (will always be on even address(
	bNE eoskiphigh
	iNC enemyoffset+1     ; Incremey high byte
eoskiphigh
	dEC enemytimer        ; Descrement timer
	bNE timernotzero      ; Skip if not zero
	lDA enemyspeed        
	sTA enemytimer        ; Reset timer
	lDX enemyend
	cPX #enemyno-1        ; Check if we are at the end of the enemy list
	bEQ timernotzero      ; Skip extra processing if we are
	iNX                   ; Add one to the last enemy to plot
	sTX enemyend          ; And save
	lDA enemyoffset       ; Reduce the start position in the path
	sEC
  ; enemyspeed +1 = double
	sBC enemyspeed +1
	sTA enemyoffset
	lDA enemyoffset+1
	sBC #0
	sTA enemyoffset+1
timernotzero
	lDA lastplot          ; Check if the last plotted enemy has reached the end of the path
	cMP #255
	bNE notoffend         ; Skip if not there
	iNC enemystart        ; Move the pointer along so that the enemy is not used any more
;WE have an end situation - Check if enemy there
	ldx enemyatend
	beq notoffend    ; if enemy not off end skip
	; - do stuff - loose life etc
	; First compare if the enemy is an explosion
	lda etype,X
	and #%11111			; Clear higher bits
	beq skiplifecheck          ; skip if zero
	cmp #16
	bcs skiplifecheck  ;  greater or equal

	; Reduce lives
	jsr reduceleft
	lda lives
	sed
	sec
	sbc #1
	sta lives
	cld
	jsr printlives
	;jsr loselifesound
	ldy #sfx.ENEMY_RCH
	sfx.do
	; delete plot from screen 
skiplifecheck
	lda pathendx
	sta sx
	lda pathendy
	sta sy
	ldx enemyatend
	lda #16+12
	sta etype,x
	stx $8D
	jsr plotter

notoffend
	rts

plotlots             ; Routine to plot all sprites
;//  \ USE 8E8F AS PLOT START
;//  \ USE 8D AS COUNTER
	lDA enemyoffset       
	sTA $8E
	lDA enemyoffset+1
	sTA $8F               ; Set up zero page as offset pointer
	lDX enemyend          ; load loop counter
plloop
	sTX $8D               ; Save loop counter for later
	;lDA etype,X           ; Get the type of enemy
	;bEQ noplot            ; if zero skip plotting it
	lDY #0
	lDA ($8E),Y           ; Get x coordinate (The path may be more than 256 bytes long)
	sTA sx                ; Store is sx ($80)
	iNY                   
	lDA ($8E),Y           ; get y coordinate
	sTA sy
	sTA lastplot          ;store location of last plot
	cMP #255              ; 255 is used to delinitate end of path
	bne plnt255            ; skip if at end
	lDA etype,X           ; Get the type of enemy
	stx enemyatend        ;
	jmp noplot
plnt255
	lDA etype,X           ; Get the type of enemy
	bEQ noplot            ; if zero skip plotting it
                      ; Non zero emeny has reached end
	and #%11111		; Strip high bits
	cmp #16               ; Is this an explosion?
	bcs nocheck           ; Branch if greater or equal to 16
	stx lastplotidx
	jSR checktowers       ; Check to see if towers are in range
nocheck
	jSR plotter           ; Plot the sprite
noplot
	cLC
	lDA $8E
	aDC enemyspeed+1      ; Use the speed to step through the offsets
	sTA $8E
	lDA #0
	aDC $8F
	sTA $8F               ; Increment the offset counter
	lDX $8D               ; Get out enemy loop counter
	dEX
	cPX enemystart        ; Are we at the start of the tail
	bNE plloop            ; loop round
	rTS

plotter
	; takes sx, sy and $8d as coordinates and enemy number
; atari replace {
;	lda #$20
	lda #>gamevram
; }	
	sta zspos+1 ; screen offset /*divided by 2*/
	lda sx                ; find X coordinate
;atari remove {
;	and #%11111100        ; Clear bottom bits
;	asl @                 ; Multiply by 2 -> 512 bytes/line
; }
;atari add:
	and #%11111000
	
	sta zspos
  ;asl zspos               ; Multiply by 2 -> 512 bytes/line
;atari remove:
;	rol zspos+1               ; Seems much simpler???
	
	lda sy                ; Get y coordinate
	and #%11111000        ; strip low bits
;atari replace {
;	lsr @
:2	lsr @
; }
	lsr @           ; divide by 4 to give line positions
	adc zspos+1               ; Add to high byte
	sta zspos+1
	lda sy
	and #%00000111        ; Get lower bits 
	adc zspos             ; add row offset to low byte
	sta zspos             ; and save
	lda sx
;atari replace {
;	and #%00000011        ; Get the offset
	and #%00000111        ; Get the offset
; }
	sta zt                ; store for later
  	sta xshift
  
;atari note: zspos is calculated correctly

  ;LDA #etype MOD 256
  ;STA $88
  ;LDA #etype DIV 256
  ;STA $89
  ;LDA ($88),Y
;   move sprite pixels by choosing right sprite
	lDY $8D               ; Get enemy  number 
	lda etype,y           ; Get type of enemy (sprite number)
	; Can we use two more bits as a countdown for flash?
	cmp #32
	bcc spritehighbitsnotset ; top bits are not set
	;and #%11011111		; Take out "32"
	pha
	and #64		;store a - and with 64
	beq dohitsprite		; If and with 64=0 then we've got a "hit" condition and need to create a new spirte
	pla
	and #%00111111
	sta etype,y	; Clear the 64 bit and store for next time
	and #%00011111
	jmp plotskipshift ; clear the 32 and 64 bits and go to the plot.
dohitsprite
	pla
	jsr createhitsprite	; Create a copy of the sprite that has been hit
	jmp plotsprite 		; jump to the plot routine
spritehighbitsnotset	
	cmp #16                ; Is the enemy an explosion?
	bcc plotskipshift     ; skip if less than
	pha
	clc
	adc #1              ; Increment explosion frame
	cmp #16+13             ; Check if we've reached the end of the explosion
	bcc plotskipreset       ; skip less than
	lda #0                  ; Reset to zero
/*
;atari add {
	sta etype,y
	pla ;just clean stack
	lda zt
	add #8 
	jmp plotgettable
;}
*/
plotskipreset
	sta etype,y            ; set enemy type as explosion frame or none
	pla
	lsr @
	lsr @             ; divide by 4
	clc
	adc #1             
	;lda#6
plotskipshift
	sEC                   
	sBC #1                ; decrement by 1
	asl @
;atari add {
	asl @ ;add another *2 for 8 shifts on atari
; }
	asl @           ; multiply by 4 (4 bytes accoss)
	aDC zt                ; and add in the horizontal shift
;atari add {
plotgettable
; }
	tAX                   ; X contains sprite number * 4 + HORIZONTAL SHIFT
	lDA spritelowtable,X
	sTA zsoff
	lDA spritehightable,X
	sTA zsoff+1           ; Store offsets to sprite
	;at this point we could recolour the sprite to make "white" for hit
plotsprite
;  \ sprite routine
;  \ $70,$71 are screen pos
;  \ $78,$79 are sprite data pos
	cLC
 ; FOR C,0,4,2           ; copy the start screen and aprite addresses to the following 3 addresses for

/*atari remove
.rept	3,#*2
	lDA zspos+:1           ; each of the 4 sprite bytes accross
	aDC #8
	sTA zspos+:1+2
	lDA zspos+:1+1
	aDC #0
	sTA zspos+:1+3
	lDA zsoff+:1
	aDC #sprows
	sTA zsoff+:1+2
	lDA zsoff+:1+1
	aDC #0
	sTA zsoff+:1+3
.endr
*/

;atari add {
;zsoff - sprite source address (from table)
;zspos - target draw word addresses (1 each column)
;sprows - 14 - sprite vertical size

;calculate rest of target/source addresses 

.rept	2,#*2
	lDA zspos+:1
	aDC #8
	sTA zspos+:1+2
	lDA zspos+:1+1
	aDC #0
	sTA zspos+:1+3
	
	lDA zsoff+:1
	aDC #sprows
	sTA zsoff+:1+2
	lDA zsoff+:1+1
	aDC #0
	sTA zsoff+:1+3
.endr

	lda xshift ;compensation for 3rd drawn char in row
	a_lt #5 notribit
	
	tax
	lda zsoff+2
	add tribitadd,x
	sta zsoff+4

	lda zsoff+3
	adc #0
	sta zsoff+5
notribit
; }

	lDY #0                ; Line counter
	lDA zspos             ; get screen position
	aND #7                ; and take bottom 4 bytes for position in nolumn
	sTA zt                ; save for later
	lDA #8                ; work out how many more bytes to plot
	sEC
	sBC zt
	tAX                   ; use as loop counter
; atari add {
	lda xshift
	a_lt #5 spriteloop1x
; }
spriteloop1          ; plot loop for first block of 8
	lDA(zsoff),Y
	sTA(zspos),Y
	lDA(zsoff+2),Y
	sTA(zspos+2),Y
	lDA(zsoff+4),Y
	sTA(zspos+4),Y
	
; atari remove {
;	lDA(zsoff+4),Y
;	sTA(zspos+4),Y
;	lDA(zsoff+6),Y
;	sTA(zspos+6),Y        ; move sprite data
; }
	iNY
	dEX                   
	bNE spriteloop1       
	sTY zt                ; y is not how many pixels we've plotted
		
	jSR spmoverow         ; change offsets to line up location in sprite data with row data
	lDX #8                ; assume we're plotting 8 rows
spriteloop2          ; plot second (possibly last) row of sprite
	lDA(zsoff),Y
	sTA(zspos),Y
	lDA(zsoff+2),Y
	sTA(zspos+2),Y
	lDA(zsoff+4),Y
	sTA(zspos+4),Y
;	
; atari remove {
;	lDA(zsoff+4),Y
;	sTA(zspos+4),Y
;	lDA(zsoff+6),Y
;	sTA(zspos+6),Y        ; move sprite data
; }
	iNY
	cPY #sprows           ; check if we've finished
	bEQ spritefinish      ; and skip of we have
	dEX                   ; or if we've plotted 8 bytes
	bNE spriteloop2       ; and loop of we haven't
  ;TYA
  ;SEC
  ;SBC #8                ; Take the 8 bytes off of the offset that we've just plotted (since 
  ;STA zt               ; zt contains orignal value

	jSR spmoverow         ; and subtract them from the start of the screen offset
spriteloop3          ; Plot final sprite row
	lDA(zsoff),Y          
	sTA(zspos),Y
	lDA(zsoff+2),Y
	sTA(zspos+2),Y
	lDA(zsoff+4),Y
	sTA(zspos+4),Y
; atari remove {
;	lDA(zsoff+4),Y
;	sTA(zspos+4),Y
;	lDA(zsoff+6),Y
;	sTA(zspos+6),Y        ; move sprite data
; }
	iNY
	cPY #sprows           ;check if we've finished (can never be 8)
	bNE spriteloop3       

spritefinish
	rTS

;atari add {	
spriteloop1x
	lDA(zsoff),Y
	sTA(zspos),Y
	lDA(zsoff+2),Y
	sTA(zspos+2),Y
	iNY
	dEX                   
	bne spriteloop1x       
	sTY zt                ; y is not how many pixels we've plotted
	
	jSR spmoverow         ; change offsets to line up location in sprite data with row data
	lDX #8                ; assume we're plotting 8 rows
spriteloop2x          ; plot second (possibly last) row of sprite
	lDA(zsoff),Y
	sTA(zspos),Y
	lDA(zsoff+2),Y
	sTA(zspos+2),Y
	
	iNY
	cPY #sprows           ; check if we've finished
	bEQ spritefinish      ; and skip of we have
	dEX                   ; or if we've plotted 8 bytes
	bNE spriteloop2x
	
	jSR spmoverow         ; and subtract them from the start of the screen offset
spriteloop3x          ; Plot final sprite row
	lDA(zsoff),Y          
	sTA(zspos),Y
	lDA(zsoff+2),Y
	sTA(zspos+2),Y
	
	iNY
	cPY #sprows           ;check if we've finished (can never be 8)
	bNE spriteloop3x       
	rts
	
tribitadd dta 0,0,0,0
	dta 0,sprows*3,sprows*4,sprows
; }

spmoverow             ; sprite row increment routine zt contains number of rows to subtract

/* atari remove
	lDA zspos             ; get screen low 
	aND #$F8              ; clear bottom 8 bits to round to new segment (important for first row - not for second
	sEC
	sBC zt                ; Subtract number of rows that we have already plotted
	sTA zspos             ; save
	lDA zspos+1           ; and move the carry
	clc
	aDC #1                ; add row (512 bytes)
	sTA zspos+1           ; save final value
	cLC
*/

;atari add {
	lda zspos
	sub #8
	sta zspos
	bcc jumpover
	inc zspos+1
jumpover
; }
	
;  FOR C,0,4,2           ; copy the start screen and aprite addresses to the following 3 addresses for
/* atari remove
.rept	3,#*2
	lDA zspos+:1           ; each of the 4 sprite bytes accross
	aDC #8
	sTA zspos+:1+2
	lDA zspos+:1+1
	aDC #0
	sTA zspos+:1+3
.endr
*/
; atari add {
.rept	2,#*2
	lDA zspos+:1           ; each of the 4 sprite bytes accross
	clc
	aDC #8
	sTA zspos+:1+2
	lDA zspos+:1+1
	aDC #0
	sTA zspos+:1+3
.endr
; }
	rTS

checktowers
;  \Check tower firing
;  \expects sx, sy as enemy x $ y
;  \expects X as offset into enemy tables (Also in $8D) 
  ; uses 70 and 71 as temp variables
	lDY activetowers         ; loop counter to go through towers
towerloop
	lDA ttype,Y           ; Get tower type
	beq skiptower         ; if zero skip tower processing
  ;Also check tower fire count
	lda tfcount,Y         ; Get fire count
	bne skiptower         ; Skip tower not allowed to fire
	lDA sx                ; get enemy x position
	cLC
	aDC #6                ; add 6 to pu into cetre of enemy
	lsr @
;atari add: {
;	lsr @
; }
	lsr @           ; Divide by 4 - Range is now 0-64
	sta $71               ; Save for later
	lda txpos,Y           ; Get tower x position
	cmp $71               ; See if tower position greater or less than x position
	bcs skipxswap         ; if greater or equal skip swapping
	tax
	lda $71
	stx $71               ;Swap a and $71 - might be better way of doing this.
skipxswap
	sec
	sbc $71               ; Subtract a from $71 - should be abs difference between tower and x
	cmp #16               ; If this is greater euqal to  16 skip tower
	bcs skiptower
	tax                   ; Transfer a to x to use as index
	lda squaretable,x     ; Get square of a
	sta $71               ; Store in 71 for safekeeping.
	lda sy                ; Now do y azis
	;clc
	adc #7                ; Again middle of enemy assume 
	lsr @
; atari add {
;	lsr @
; }
	lsr @           ; Divide by 4
	sta $70               ; Store in 70 for later
	lda typos,Y           ; Get ower y position
	cmp $70               ; See if tower position greater of less that y position
	bcs skipyswap         ; if greater or equal skip swapping
	tax
	lda $70
	stx $70               ; Swap a and $70
skipyswap
	sec
	sbc $70               ; Subtract a from $70 - should be abs difference between tower and y
	sta $70               ; debug
	cmp #16               ; If this is greater equal to  16 skip tower
	bcs skiptower
	tax                   ; Transfer a to x to use as index
	lda squaretable,x     ; Get square of a
	adc $71               ; Add to 71 for pythagoras - carry is clear
	bcs skiptower         ; Answer is greater than 255 - max distance is 16.
	sta $71
	lda ttype,Y           ; Get towertype into x - this is used as an index into the tower level difinitions
	;sec:sbc #4                ; Carry will be clear at this point - subtract 4 to corrrect index
	tax
	lda $71
	cmp towerrangesactual-4,X
	bcs skiptower         ; if greater or equal out of range so skip tower

	lda $8d               ; We have fire candidate so write to fire table.  First get index to write
	sta tftarget,y
	lda sx
;atari add {
;	lsr @
; }
	sta tftargetx,y
	lda sy
;atari add {
;	lsr @
; }
	sta tftargety,y       ; Write fire targets and locations
skiptower
	dEY
	bPL towerloop
	rTS

  ; Plot tower routine and data structure initialise.
  ; Takes X tower index.assumes that x any y positions are the positions/4
  ; Also that tower type is pre-populated
  ; Uses $70-$73 and destroys registers apart from X
plottower
	; First we need to work out if we can afford the tower.
	lda gold
	cmp #0
	bne canafford		; We have more than 9999 gold
	lda gold+1
	cmp #$10
	bcs canafford		; We have more than 1000 gold.
	sta $70
	lda gold+2
	sta $71
	lsr $70
	ror $71
	lsr $70
	ror $71
	lsr $70
	ror $71
	lsr $70
	ror $71         ; Move gold value into a single byte for comparison with table
	ldy ttype,X
	lda $71
	cmp towercosts,Y        ; Get tower cost
	bcs canafford           ; Gold value greater or equal to cost
	tya                     ; Can't afford tower - need to backout change and/or quit
	and #3
	beq toweriszeroalready
	dey                     ; Reduce the already increaed tower type.
	tya
	sta ttype,X               ; Save back again
	jmp errorsound		; Play error sound and exit
toweriszeroalready
	lda #0                  ; Clear tower type - should have been zero as we can't afford
	sta ttype,X
	jmp errorsound		; Play error sound and exit
	;rts
canafford
  ; First we need to calculate screen output address
	lda #$20        
	sta $71       ; clear screen start in high byte
	lda txpos,X   ; a conains value 0-63 ish - assumed to be top left of tower.
	sec
/* atari remove
	sbc #3    ; Find top left
	asl @         ; multiply by 2 (since four pixles per byte)
*/
;atari add {
	sbc #4    ; Find top left
; }
	asl @ ;:asl @   ; Now multiply by 2 -
	asl @         ; and finish multiplaction to 8 - first time we could wrap
	sta $70       ; Store result
	rol $71       ; Set the bit in top byte if required
	lda typos,X   ; Get y position - this will be 0 - 63 - does not need to be divided to 512 - towers can't be at half positions
;atari add {
	lsr @
; }
	sec
/*atari remove
	sbc #3    ; Find top left
*/
;atari add {
	sbc #1    ; Find top left
; }
	;asl @
	clc
	adc $71   ; Add to the x offset high byte 
	sta $71       ; And save
 
	;At this point we should look up the tower "abilities" and store them

	lda ttype,X
	beq starttowerplot      ; Skip if this is a zero tower (i.e a marker)
  
	lda towerfirespeed-4,Y       ; Get initial fire count
	sta tfcount,X

starttowerplot
;atari replace {
;	txa
;	pha         ; Save x for later
	stx draw_3x3_tower.xstore
; }

;*atari add {
	lda txpos,x
	and #$01
	beq towcont4
	draw_3x3_tower
	jmp printgold
	
towcont4	;continue with 4x3 tower
; }

  ; move the location of hte tower sprite data into $72,$73  
	lda ttype,X   ; Get the tower type
	lsr @         ; shift it to the right once
	and #%11111110 ;Clear the bottom bit
	tax
	lda towerlocations,X
  ;lda #towers mod 256
	sta $72
	inx
	lda towerlocations,X
  ;lda #towers div 256
	sta $73
  ; Now draw the damn thing!
	ldx #3         ; 3 rows
towerrowloop
/*atari remove
	ldy #47        ; 24/4*8
*/
;atari add {
	ldy #23+8
	mwa #towermask w1
; }
towerdrawloop
	lda ($70),Y
	;eor #$ff ;debug
;atari add {
	and (w1),y     ;towermasking
	ora ($72),y	
; }	
	sta ($70),Y    ; draw sprite
	dey
	bpl towerdrawloop
	lda $71 
	clc
/*atari remove
	adc #2    ; increase screen row
*/
;atari add
	adc #1
	
	sta $71
	lda $72       ; incrase offset into sprite
/* atari remove
	adc #48       ; number of bytes just plotted
*/
;atari add {
	adc #24+8
; }
	sta $72
	lda $73       ; Add the carry as necessary
	adc #0
	sta $73
	
;atari add {
	;masking
	inw w1
; }	
	dex
	bne towerrowloop
	
  ; Decrement the gold amount?
/*atari remove
;atari replace { 
;	pla
;	tax         ; Get x back.
	ldx draw_3x3_tower.xstore
; }
	ldy ttype,X   ; Get the tower type
	lda towercosts,Y        ; Get the gold cost - this is /10
	asl @
	asl @
	asl @
	asl @ ; Multiply by 10 *BCD
	sta $72                 ; Save for later
	sed
	lda gold+2
	sec
	sbc $72
	sta gold+2
	lda gold+1
	sbc #0
	sta gold+1
	lda gold
	sbc #0         ; subtract from gold - might be better way
	sta gold
	lda towercosts,Y
	lsr @
	lsr @
	lsr @
	lsr @ ; Divide by 10
	sta $72
	lda gold+1
	sec
	sbc $72
	sta gold+1
	lda gold
	sbc #0
	sta gold                ; subtract rest of value
	cld
*/
;atari add {
	decrement_gold ;buy tower
;}
	; Now draw dots under tower for level $70,$71 points at row beneath first tower
	inc $70
			; Allow a pixel difference

	;add dot offset
	lda ttype,X
	beq notoweratall	; Don't draw dots for no tower
	and #3			; Find out tower level
	beq nodotstodraw		; Don't draw dots for level zero
	sec
	sbc #1		; Subtract 1 to give 0-2 index.
	asl @
	asl @
	asl @
/*atari remove
	asl @	; Multiply by 16 to give byte offset (each column)
*/
	tay			; Store in index.

	; draw dot. (c3, 3c)
/*atari remove
	lda #$83
	sta ($70),Y
	iny
	sta ($70),Y
	tya
	clc
	adc #7
	tay
	lda #$38
	sta ($70),Y
	iny
	sta ($70),y
*/
;atari add {
	lda #%11111100
	and ($70),y
	sta ($70),y
	iny
	sta ($70),y
	tya
	add #7
	tay
	lda #%00011111
	and ($70),y
	sta ($70),y
	iny
	sta ($70),y

	ldy #sfx.TOWER_UPG
	sfx.do
	jmp printgold
; }

nodotstodraw

	ldy #sfx.TOWER_BLD
	sfx.do

notoweratall	
	jmp printgold		; implied RTS

	;rts

towerfire
  ; Routine to action tower fire list and to update the status of each
	lda #0
	sta firesoundtype
	ldx activetowers ;start at the end and work backwards
towerfireloop
	lda ttype,X   ; Check if tower defined
	jeq skiptowerfire     ; skip if not
  ; Don't need to check fire count if we have a target
	ldy tftarget,X ;Do we have a target?
	jeq skiptowerfire     ; skip if not
  ; We now have an active tower with a target that's ready to fire - Y is target

  ; load location of screen position to $70,71
	lda #0
	sta $71
	
;atari info: tftargetx,y contains absolute position in pixels 256*256 range (top left corner of enemy)
	lda tftargetx,X        ; move x coordinate to A
	clc
	adc #7            ; Get middle of target
; atari replace {
;	and #%11111100        ; Clear bottom bits
	sta b1
	and #%00000100
	sta bulright	;bullet on right part of char
	lda b1
	and #%11111000
; }
	sta $70
; atari remove {	
;	asl $70               ; Multiply by 2 -> 512 bytes/line
;	rol $71               ; Seems much simpler???
; }
; this part of code places the bullet into the target (enemy)
; so next redraw of target will also clear the bullet sprite leftovers
	lda tftargety,X
	and #%10		; Take component of y and add it to the target offset (0 or 2 - avoids very top and bottom)
	adc $70
	sta $70

	;lda #0:adc $70:sta $70
	;inc $70:inc $70:inc $70
	lda tftargety,X       ; Get y coordinate
	;clc:adc #4            ; Find the middle
	and #%11111000        ; strip low bits
	lsr @
;atari add {
	lsr @ ;by 8
; }
	lsr @           ; divide by 4 to give line positions
	adc $71               ; Add to high byte
	sta $71
  ;lda tftargety,X
  ;adc #7                ; middle
  ;and #%00000100        ; fudge middle approximation
  ;adc $70:sta $70
; atari replace {  
;	lda #$42              ; Add screen offset + 2 to move one pixel down
	lda #>gamevram+$01	;add screen offset + 1 to move one char down
; }
	adc $71
	sta $71       
  ; Draw "hit"
	stx $74         ; Save X for later
	;       Determine if we have space in the tower table to store the hit data
	ldy #0
findhitspace
	lda fctype,Y
	jeq storehit
	iny
	cpy #8		; 8 fire locations
	bne findhitspace

finishfireplot
	lda ttype,X             ; Vary "Hit" based on tower type
	sta firesoundtype	; Store the tower type in the firetype sound
	and #%11111100            ; strip the "level" bits
	;sec:sbc #4
	tax

	; Plot "Middle" bullet position.
; atari add {
	lda bulright
	beq midbulletleft

.local midbulletright

	ldy #0

.rept 4,#-4
     	;lda firetypes_right+:1,X
	;sta ($70),Y
	;iny
	lda ($70),Y
	and #$f0
	ora firetypes_right+:1,X
	sta ($70),Y
	iny
.endr

/*	lda firetypes_right-4,X
	ldy #0
	sta ($70),Y
	iny
	lda firetypes_right-3,X
	sta ($70),Y
	iny
	lda firetypes_right-2,X
	sta ($70),Y
	iny
	lda firetypes_right-1,X
	sta ($70),Y
	*/
;	waittostart

	jsr reduceenemystats
	jmp skiptowerfire
.endl

midbulletleft
; }

/*atari remove
	lda firetypes-4,X
	ldy #0
	sta ($70),Y
	iny
	lda firetypes-3,X
	sta ($70),Y
	iny
	lda firetypes-2,X
	sta ($70),Y
	iny
	lda firetypes-1,X
	sta ($70),Y
*/

;atari add {

	ldy #0
	
.rept 4,#-4
     	;lda firetypes+:1,X
	;sta ($70),Y
	;iny
	
	lda ($70),y
	and #$0f
	ora firetypes+:1,X
	sta ($70),Y
	iny

.endr

;	waittostart
; }

	jsr reduceenemystats

skiptowerfire

	lda #0
	sta tftarget,X        ; Reset the fire target

	lda tfcount,X         ; Get the fire count
	beq skiptowerdecrement
	sed
	sec
	sbc #1 
	sta tfcount,X         ; and decrement - BCD flag?
	cld
skiptowerdecrement
	dex
;atari replace {
;	bpl towerfireloop
	jpl towerfireloop
; }
	; Play a sound of a firing tower
	;jmp firesound
	jmp sfx.fire


storehit
	lda $70
	sta fcnewl,Y            ; Store location of new plot (HIT)
	lda $71
	sta fcnewh,Y            ; Store high location of new plot
;atari add {
  	mva bulright fcnewright,y ;save info that bullet is right
; }
	lda ttype,X             ; Vary "Hit" based on tower type
	and #%11111100            ; strip the "level" bits
	sta fctype,Y            ; Store tower type for fire list
	sty $77                 ; Save y

	;Calculate midpoint and store that..... (into $70,$71)

	; do horizontal 
	lda txpos,x             ; Get tower position (0-63)
	sta $78

	lda tftargetx,x
	clc
	adc #6              ; Get middle of target (0-255)
	lsr @
	lsr @             ; Divide by 4 (0-63)
	cmp $78                 ; Compare against tower x pos
	bcs midxnoswap          ; if ge skip swap
	ldy $78
	sta $78
	tya     ; Swap $78 and a
midxnoswap             ; a is now greater than $78
	sec
	sbc $78             ; difference now in A
	lsr @                   ; Divide by two
	clc
	adc $78             ; Add $78 - mid x position now in A
	sta $78                 ; Save


	; Do Vertical
	lda typos,x             ; Get tower position (0-63)
	sta $79

	lda tftargety,x
	clc
	adc #6              ; Get middle of target (0-255)
	lsr @
	lsr @             ; Divide by 4 (0-63)
	cmp $79                 ; Compare against tower y pos
	bcs midynoswap          ; if ge skip swap
	ldy $79
	sta $79
	tya     ; Swap $79 and a
midynoswap             ; a is now greater than $79
	sec
	sbc $79             ; difference now in A
	lsr @                   ; Divide by two
	clc
	adc $79             ; Add $79 - mid x position now in A
	sta $79                 ; Save

	; $78 and $79 now contain mid x,y positions in tower coordinates.  Now multiply into screen space

	lda #0
	sta $71
	lda $78               ; move x (0-63) coordinate to A
;atari add {
	and #$01
	sta bulright	;decide if bullet is on right side of char
	lda $78
; }
	asl @
/* atari remove
	asl @
*/
	asl @   ; A = 0 to 511 + carry
	sta $70
/* atari remove
	rol $71               ; Seems much simpler???

	inc $70
	inc $70
	inc $70
*/
	lda $79              ; Get y coordinate (0-63)
; atari replace {
;	and #%00111110        ; strip low bits
	lsr @
; }
	clc
	adc $71          ; Add to high byte
	sta $71
; atari replace {
;	lda #$40               ; Add screen offset
	lda #>gamevram
; }
	adc $71
	sta $71       

	lda $77                 ; get saved y into a
	asl @
	asl @
	tax         ; Multiply by 4 and move to X - offset into FCSTORE
	ldy #0
	lda ($70),Y
	sta fcstore,X
	iny
	lda ($70),Y
	sta fcstore+1,X
	iny
	lda ($70),Y
	sta fcstore+2,X
	iny
	lda ($70),Y
	sta fcstore+3,X

	ldy $77                 ; Restore y

	lda $70
	sta fcoldl,Y            ; Store old location
	lda $71
	sta fcoldh,Y            ; Store old location
; atari add {
	mva bulright fcoldright,y	;save right MID info
	;probably not even needed to store fcoldright,y
; }
	ldx $74
	jmp finishfireplot

/* atari remove temporary */
drawbullets
	;Routine to draw inflight bullets
	ldx #7

bulletloop
	lda fctype,X   ; Check if location is zero
;atari replace {
;	beq skipbullet  ; skip whole process if it is.
	jeq skipbullet  ; skip whole process if it is.
; }
	lda fcoldl,X   ;(MID)
	sta $70
	lda fcoldh,X
	sta $71
	lda fcnewl,X   ; (HIT)
	sta $72
	lda fcnewh,X
	sta $73         ; old and new screen addresses copied.
;atari add {
	mva fcnewright,x bulright ;HIT right         
; }
	stx $74         ; Save x for later
	txa
	asl @
	asl @
	sta $75 ; Store 4 time X for later

	lda fctype,X             ; Vary "Hit" based on tower type
	;sec:sbc #4              ; correct for zero offset
	tax
	stx $76             ; Store type offset for later

	ldy #0
	
; atari add {
	lda bulright
	beq bls0	;bullet on left side of char
	
.local	bullet_on_right

.rept 4,#-4,#+1,#
	;lda firetypes_right+:1,X
	;sta ($72),Y
	lda ($72),y
	and #$f0
	ora firetypes_right+:1,x
	sta ($72),y
	
	ldx $75
	lda fcstore+:3,X
	sta ($70),Y
	ldx $76

	ldy #:2
.endr

/*
	lda firetypes_right-4,X
	sta ($72),Y
	ldx $75
	lda fcstore,X
	sta ($70),Y
	ldx $76

	ldy #1
	lda firetypes_right-3,X
	sta ($72),Y
	ldx $75
	lda fcstore+1,X
	sta ($70),Y
	ldx $76

	ldy #2
	lda firetypes_right-2,X
	sta ($72),Y
	ldx $75
	lda fcstore+2,X
	sta ($70),Y
	ldx $76

	ldy #3
	lda firetypes_right-1,X
	sta ($72),Y
	ldx $75
	lda fcstore+3,X
	ldx $76
	sta ($70),Y
*/
	jmp bls4	;continue
.endl

bls0
; }	
	
;atari add {
.rept 4,#-4,#+1,#
	;lda firetypes+:1,X
	;sta ($72),Y
	lda ($72),y
	and #$0f
	ora firetypes+:1,X
	sta ($72),y
	
	ldx $75
	lda fcstore+:3,X
	sta ($70),Y
	ldx $76
	ldy #:2
.endr
;}
	
/* atari remove	
	lda firetypes-4,X
	sta ($72),Y
	cmp ($70),Y
	bne bls1
	ldx $75
	lda fcstore,X
	sta ($70),Y
	ldx $76
bls1
	ldy #1
	lda firetypes-3,X
	sta ($72),Y
	cmp ($70),Y
	bne bls2
	ldx $75
	lda fcstore+1,X
	sta ($70),Y
	ldx $76
bls2
	ldy #2
	lda firetypes-2,X
	sta ($72),Y
	cmp ($70),Y
	bne bls3
	ldx $75
	lda fcstore+2,X
	sta ($70),Y
	ldx $76
bls3
	ldy #3
	lda firetypes-1,X
	sta ($72),Y
	cmp ($70),Y
	bne bls4
	ldx $75
	lda fcstore+3,X
	ldx $76
	sta ($70),Y
*/
bls4

	ldx $74
	lda #0
	sta fctype,X

; atari add {
;	waittostart ;debug
; }

skipbullet
	dex
	bmi finishbullet
	jmp bulletloop
finishbullet
	rts

reduceenemystats
	; Enemy stat reduction taken out to make fire loop small enough for branches.

	ldx $74                 ; Restore X

	ldy ttype,X
	;sec:sbc #4
	;tay                   ; Tower type now as offset into tables
	lda towerfirespeed-4,Y
	sta tfcount,X         ; update fire count

	stx $80               ;Save current X  
  ; reduce health $ shields
	lda tftarget,X        ; get sprite to work with.
	tax                   ; X is now sprite offset, Y is tower type offset

	lda etype,x
	and #%11111
	cmp #16			; Check if the enemy type is an explosion
	bcs skipstatreduction	; If so skip reducing stats adding gold - we have a double hit

	; At this point set the "top bits" of the enemy sprite data to indicate a count to make white?
	lda etype,x		; Get the enemy type
	cmp #16
	beq skipstatreduction	; Skipsetting the top bits if this is an explosion.
	ora #%1100000		; Set the two bits
	sta etype,x		; Store the enemy type

	sed                   ; We're working in BCD for easy display
	lda towerphysical-4,Y
	sec
	sbc eshield,X     ; Reduce damage by shield value
	bcs healthgtzero
	lda #0                ; set health damage to zero if below zero
healthgtzero
	sta $71               ; Store new damage amount temporarily
	lda ehealth,X         ; get health to reduce.
	sec
	sbc $71          ; Reduce health by damage amount
	beq healthiszero
	bcs stillalive

healthiszero
	;Add gold
	tya
	pha                         ; Save Y
	lda etype,x                    ; Get gold type based on enemy
	and #%11111
	tay			; Strip remiaining top bits
	dey
	lda goldvalues,y
	php
	jsr addgold
	lda enemystrengths,y
	sta scoretoadd+3
	lda enemyshields,y
	sta scoretoadd+2
	jsr addscore
	inc enemieskilled
	bne noenemieskilledcarry
	inc enemieskilled+1
noenemieskilledcarry
	plp
	pla
	tay

	lda #16                ; Set enemy type as 16 - explosion.
	sta etype,X
	jsr reduceleft
	;jsr explodesound
	phr
	ldy #sfx.ENEMY_KIL
	sfx.do
	plr
	lda #0

stillalive           ; you're dying and I'm still alive.
	sta ehealth,X
	lda eshield,X
	sec
	sbc towershield-4,Y ; Reduce shields by 
	bcs shieldgtzero
	lda #0
shieldgtzero
	sta eshield,X
	cld

skipstatreduction
	ldx $80  

keystillpressed        ; Exit from keyobard routine. Not great programming....
	rts

	; Keyboard routine.  Spread around entry point for branch issues
press1
	ldy #4
	jmp maketower
press2
	ldy #8
	jmp maketower
press3
	ldy #12
	jmp maketower

escape			;Escape has been pressed.
	jsr showwave.restore	;prevents glitches on fast quit
;TODO: fix this (crash)
/*atari remove
	jsr readshift
	jvc notescape ; Escape pressed - but not shift.
*/
	pla
	pla			; Pull return address off stack
	jmp gameover
/*
readshift
	clv
	clc
	jmp ($228)
*/
upgradetower
	; Tower upgrade routine.
	ldx currentlocation
	lda ttype,x
	beq alreadymax          ; No tower here - Upgrade dosen't work.
	and #%11
	cmp #%11                ; Is the tower already at max level?
	beq alreadymax
	inc ttype,x
	jsr erasebox             ; Erase box
	
	;jsr upgradesound	; Upgrade Sound
/*	phr
	ldy #sfx.TOWER_UPG
	sfx.do
	plr
*/	
	jsr plottower           ; Upgrade tower
	ldx currentlocation
	jsr plotbox            ; redraw box
	jmp finishkeyboard
alreadymax
	jsr errorsound
	jmp finishkeyboard

keyboard
	; Keyboard input routine and tower plot/update
	lda #2
	sta gamespeed
	
	lda fastloop ;allow holding fire to speed up
	bne gofast 
	
;atari replace {
;	lda $ec ;atari note: $EC is supposed to be code of key just pressed
	spacepressed
; }
	cmp #1		; Is Space being pressed?
	bne nospacepressed	
gofast	lda #0
	sta gamespeed
nospacepressed
/* atari remove

	lda keypres
	beq nokeypressed        ; Check if there was a key pressed last time we were here.
;atari replace {
;	cmp $ec
	getkeypressed
	cmp keypres
; }
	beq keystillpressed     
;atari replace { 
;	cmp $ed
;	beq keystillpressed
	lda skctl
	cmp #255
	bne keystillpressed
; }
nokeypressed
	; We're only going to work with the last key pressed (ec)
*/

;atari replace {
;	lda $ec
;	cmp #48+128
;	beq press1            ; 1
;	cmp #49+128
;	beq press2            ; 2
;	cmp #17+128
;	beq press3            ; 3

;	cmp #53+128
;	beq upgradetower      ; U pressed - Upgrade

;	cmp #112+128
;	beq escape		; Escape pressed

;	cmp #25+128             ; Left Cursor
;	beq moveleft
;	cmp #121+128            ; Right cursor
;	beq moveright
;	cmp #57+128
;	beq moveup              ; Up cursor
;	cmp #41+128
;	beq movedown            ; Down cursor

	handle_joystick
	getkeypressed

keyswitch
	cmp #"1"
	beq press1
	cmp #"2"
	beq press2
	cmp #"3"
	beq press3
	
	cmp #"u"
	beq upgradetower
	
	;cmp #";" ;ESC
	;beq escape

	ldx sbarvisib
	jne sbarcontrols	;if status bar is visible handle controls differently

	cmp #"w"
	jeq moveup
	cmp #45 ;"-"
	jeq moveup
	cmp #"a"
	jeq moveleft
	cmp #43 ;"+"
	jeq moveleft
	cmp #"s"
	jeq movedown
	cmp #61 ;"="
	jeq movedown
	cmp #"d"
	jeq moveright
	cmp #42 ;"*"
	jeq moveright
	cmp #";"* ;return
	jeq returnpressed

;joystick controls
	lda #$01
	bit stick
	jeq moveup
	asl @
	bit stick
	jeq movedown
	asl @
	bit stick
	jeq moveleft
	asl @
	bit stick
	jeq moveright
	lda trig
	jeq returnpressed
	
	lda startdelay ;allow quit couple seconds after game starts
	bne notescape
	lda consol
	jeq escape ;start+select+option pressed 
; }

notescape
;atari replace {
;	lda $ec
;	getkeypressed
;	sta lastkeypressed
; }
	rts                   ; Exit to prevent update of tower information.

moveleft
	lda currentlocation
	asl @
	tax
	lda neighbors+1,x
movegeneric2
	and #$0f
movegeneric
	cmp currentlocation
	jeq finishkeyboard
	pha
	ldx currentlocation
	jsr erasebox
	pla
	tax
	stx currentlocation
	jsr plotbox
	ldy #sfx.CURSOR
	sfx.do
	jmp finishkeyboard

moveright
	lda currentlocation
	asl @
	tax
	lda neighbors,x
	jmp movegeneric2

moveup
	lda currentlocation
	asl @
	tax
	lda neighbors,x
movegeneric3
:4	lsr @
	jmp movegeneric

movedown
	lda currentlocation
	asl @
	tax
	lda neighbors+1,x
	jmp movegeneric3

maketower
	ldx currentlocation
	lda ttype,x
	bne toweralreadyhere      ; Tower already at this location.
	tya
	;asl @:asl @             ; Muliply a by 4 to make tower type
	sta ttype,X             ; Change tower type to be Y
	jsr erasebox             ; Erase box
	;jsr buildsound		; Make tower being built sound (will be cancelled if not afforadable)
;atari add {
/*	phr
	ldy #sfx.TOWER_BLD
	sfx.do
	plr
*/
	jsr showwave.restore
	ldx currentlocation
; }
	jsr plottower           ; Create tower
	ldx currentlocation
	jsr plotbox             ; redraw box

finishkeyboard
;atari replace {
;	lda $ec
	getkeypressed
; }
	;sta lastkeypressed
	jsr printtowerinfo
	rts

toweralreadyhere
	jsr errorsound
	jmp finishkeyboard
	
;atari add {
returnpressed
.local	sbarcontrols_local
	lda sbarvisib
	beq sps1
	;status bar is already shown
	
	lda sbarselec
	cmp sbarmin
	beq sps3 ;hide bar
	
	lda sbarmax
	cmp #3 ;tower select
	bne sps4
	lda #"0"
	add sbarselec
	jmp keyswitch	;press number
	
sps4	cmp #2 ;upgrade possible
	bne sps5
	lda #"u"
	jmp keyswitch
sps5	dta 2 ;error
	
sps3	set_status0
	rts	
sps1	ldx currentlocation
	lda typos,x
	a_ge #32 sps2
	set_status2
	rts
sps2	set_status1
	rts
.endl

sbarcontrols
.local	sbarcontrols_local
         	cmp #"w"
	beq moveup
	cmp #45 ;"-"
	beq moveup
	cmp #"s"
	beq movedown
	cmp #61 ;"="
	beq movedown
	cmp #";"* ;return
	jeq returnpressed
	
	cmp #";" ;ESC
	jeq sps3	;hide statusbar
	
	ldy startdelay
	bne @+
	cmp #$58 ;DEBUG - shift+x
	jeq nextlevel
@
;	cmp #"c" ;DEBUG color
;	jeq color.fade_in_from_black
	
;	cmp #"v" ;DEBUG color
;	jeq color.fade_out_to_black2
	
;joystick controls
	lda #$01
	bit stick
	beq moveup
	asl @
	bit stick
	beq movedown
	lda trig
	jeq returnpressed	
	
	rts
	
moveup	lda sbarselec
	beq x2
	cmp sbarmin
	beq x1
	dec sbarselec
x1	clear_sbarselec
	draw_sbarselec 
	rts
x2	clear_sbarselec
	rts


movedown	lda sbarselec
	cmp sbarmax	;do not go over max line
	beq x1
	inc sbarselec
	clear_sbarselec
	draw_sbarselec 
x0	rts

.proc	draw_sbarselec
     	ldx sbarvisib 
     	beq x0	;do not draw if visible=0
	dex
	ldy sbarselec
	beq x0	;do not draw if selected=0
	lda store_pmg.bars,x
	add lmvidx,y
	tax
	ldy #8
x1	
.rept 4,#
	lda #255
	sta mypmbase+:1*$100,x
.endr	
	dex
	dey
	bne x1
x0	rts
lmvidx	dta 0,16,24,32	;line move index (lines inside statusbar)
.endp

;clear statusbar selection (pmg)
.proc	clear_sbarselec
          ldx sbarvisib
          beq x0	;do not Clear if not drawn
	dex
	lda store_pmg.bars,x
	add #32
	tax
	ldy #32
x1
.rept 4,#
	lda #0
	sta mypmbase+:1*$100,x
.endr		
	dex
	dey
	bne x1
x0     	rts
.endp
.endl
;}


addgold
	; Add A to gold value then update printout
	; Preserves registers apart from A; Assumes A is a BCD Gold value to add
	;php
	STA $70
	txa
	pha
	tya
	pha
	lda $70
	sed
	clc
	adc gold+2
	sta gold+2
	lda #0
	adc gold +1
	sta gold +1
	lda #0
	adc gold 
	sta gold
	cld
	jsr printgold
	pla
	tay
	pla
	tax
	;plp
	rts

/*
explodesound
	txa
	pha
	tya
	pha
	lda #7
	ldx #<(explodesoundparams)
	ldy #>(explodesoundparams)
; atari off
;	jsr $FFF1
	pla
	tay
	pla
	tax
	rts

explodesoundparams
	dta $10,0	; channel (with buffer flush)
	dta 1,0	; Envelope
	dta 6,0	; Pitch
	dta 15,0	; Duration

firesound
	;tya:pha:txa:pha
	lda firesoundtype
	beq nofiresound
	and #%00001100
	asl @
	ora #%11000000	; Pick high note
	sta firesoundparams+4
	ldx #<(firesoundparams)
	ldy #>(firesoundparams)
	lda #7
; atari off
;	jsr $FFF1

	;pla:tax:pla:tay
nofiresound
	rts

firesoundparams
	dta $11,0	; channel (with buffer flush)
	dta 2,0	; Envelope
	dta 6,0	; Pitch
	dta 2,0	; Duration

movesound
	lda #7
	ldx #<(movesoundparams)
	ldy #>(movesoundparams)
; atari off
;	jmp $FFF1
	rts ;atari added


movesoundparams
	dta $13,0	; channel (with buffer flush)
	.word -10	; Envelope
	dta 150,0	; Pitch
	dta 1,0	; Duration
*/
errorsound
	ldy #sfx.ERRSND
	sfx.do
	rts
/*
	lda #7
	ldx #<(errorsoundparams)
	ldy #>(errorsoundparams)
; atari off
;	jmp $FFF1
;	rts


errorsoundparams
	dta $12,0	; channel (with buffer flush)
	.word -15	; Envelope
	dta 10,0	; Pitch
	dta 8,0	; Duration


loselifesound
	txa
	pha
	tya
	pha
	lda #$12
	ldx #20
	ldy #8
	jsr bongsound
	lda #2
	ldx #4
	ldy #16
	jsr bongsound
	pla
	tay
	pla
	tax
	rts

sadsound	; Play sadder "string" sound
	pha
	lda #4
	sta bongparams+2
	jmp playsound

longsound	; Play a longer "trumpet" sound
	pha
	lda #3
	sta bongparams+2
	jmp playsound

bongsound	; Play a "bong" a - channel, x pitch, y duration
	pha
	lda #1
	sta bongparams+2
playsound
	pla
	sta bongparams
	stx bongparams+4
	sty bongparams+6
	lda #7
	ldx #<(bongparams)
	ldy #>(bongparams)
; atari off
;	jmp $FFF1
	rts

bongparams
	dta $10,0	; channel (with buffer flush)
	dta 1,0	; Envelope
	dta 6,0	; Pitch
	dta 15,0	; Duration
	
buildsound
	pha
	tya
	pha
	txa
	pha
	lda #$12
	ldx #128
	ldy #5
	jsr bongsound
	lda #$02
	ldx #164
	ldy #5
	jsr bongsound
	lda #$02
	ldx #148
	ldy #10
	jsr bongsound
	pla
	tax
	pla
	tay
	pla
	rts


upgradesound
	pha
	tya
	pha
	txa
	pha
	lda #$12
	ldx #128
	ldy #5
	jsr bongsound
	lda #$02
	ldx #164
	ldy #10
	jsr bongsound
	pla
	tax
	pla
	tay
	pla
	
	rts

levelstartsound
	pause 50
	;lda #50
	;jsr delay

	ldx #0
levelstartsoundloop
	txa
	pha
	ldy levelstartsounddurations,x
	lda levelstartsoundpitches,x
	tax
	lda #1
	jsr longsound
	pla
	tax
	inx
	cpx #4
	bne levelstartsoundloop

	;lda #125
	;jmp delay		; RTS implies

	rts

levelstartsoundpitches
	dta 80,80,80,100
levelstartsounddurations
	dta 6,3,3,12
*/

addscore
	;Routine to add score.  Uses "scoretoadd" as the score to add.  Preserves registers apart from A
	;php
	txa
	pha
	tya
	pha
	sed
	ldx #4		;5
	clc
scoreaddloop
	lda score-1,x
	adc scoretoadd-1,x
	sta score-1,x
	dex
	bne scoreaddloop
	lda #0
	ldx #4		;5
clearscoreloop		; Clear the add buffer for next time
	sta scoretoadd-1,x
	dex
	bne clearscoreloop
	cld
	jsr printscore
	pla
	tay
	pla
	tax
	;plp
	rts

printtowerinfo
	; Routine to print tower information
	; uses the curren cursot location to determine tower type under cursor
	; if no tower then dispays all tower types
	; if tower then displays current and upgrade info.
	; Tower info - damage, shield, range, speed, cost
	ldx currentlocation
	lda ttype,x
	cmp previoustower
	bne updatetowerinfo     ; Prevent replotting unless required.
	rts
forceprinttowerinfo
	ldx currentlocation
	lda ttype,x
updatetowerinfo
	jsr clearstatusbox
	sta previoustower       ; Store the last plot info
	cmp #0                  ; Compare if there is no tower at the location                
	beq printtowerbasicstats          ; only print base info
;atari add {
	pha
	lda #1
	sta sbarselec
	sta sbarmin
	mva #2 sbarmax
	pla
; }

	dey
	tay
	and #%11                        ; Tower level
	ora #$a0
	sta towertempnum
	lda #29
	sta $77
	jsr printtoweractive            ; print one row of information

	;lda #$CD
	;sta towertempnum
	lda #6 ;19
	sta $70
	;ldx #00
	;jsr numberplot          ; keyboard         
	ldx #13*8-1
	charplot_atari

	tya                             ; Get back the tower offset
	and #%11
	cmp #%11                        ; Check if we are at the maximum tower level
	beq delrow2                     ; We are so blank out rows 2 and 3

                                ; Print the update row.
	iny                             

	tya                             ; put new tower leve into a
	and #%11                        ; Tower level
	ora #$a0
	sta towertempnum
	lda #30
	sta $77
	jsr printtoweractive            ; print one row of information
	;lda #$ab
	;sta towertempnum
	lda #6 ;19
	sta $70
	;ldx #00
	ldx #12*8-1
	;jsr numberplot          ; keyboard
	charplot_atari         
;atari add {		
	sbarcontrols_local.clear_sbarselec
	sbarcontrols_local.draw_sbarselec
	rts
; }
	;jmp delrow3

delrow2
;atari add {
	dec sbarmax
	sbarcontrols_local.clear_sbarselec
	sbarcontrols_local.draw_sbarselec
; }
	;lda #%00000000:sta textcolour 
	;lda #19:sta $70
	;lda #30:sta $77
	;ldx #15:jsr numberplot          ; Delete row 2         

delrow3
	;lda #%00000000:sta textcolour 
	;lda #19:sta $70
	;lda #31:sta $77
	;ldx #15:jsr numberplot          ; Delete row 3

	rts

printtowerbasicstats           ; Print the base tower infor for no tower present

	ldy #%100
	lda #29
	sta $77
;atari add {
	mva #3 sbarmax
	mva #0 sbarmin
	sta sbarselec
;}

printtowerbasicsloop
	lda #$a0
	sta towertempnum
	jsr printtoweractive            ; print one row of information

	tya
	lsr @
	lsr @
	ora #$a0
	sta towertempnum
	lda #4 ; 19
	sta $70
	ldx #00
;atari replace {\
;	jsr numberplot          ; keyboard         
	numberplot_atari
; }
	inc $77
	tya
	clc
	adc #%100
	tay
	cmp #%10000
	bne printtowerbasicsloop

	rts

printtoweractive               ; display one row of active tower info - removed from main loop.
	;lda #%00001111
	;sta textcolour   ;draw in green
	lda #10 ;23
	sta $70
	lda #towertempnum % 256
	sta $74
	lda #towertempnum / 256
	sta $75
	ldx #00
;	jsr numberplot          ; plot tower level         
	numberplot_atari

	;lda #%11110000
	;sta textcolour   ; Draw in green
	lda towerphysical-4,y
	sta towertempnum
	lda #18 ;28
	sta $70
	ldx #00
	;jsr numberplot          ; plot tower physical damage         
	numberplot_atari

	lda towershield-4,y
	sta towertempnum
	lda #26 ;33
	sta $70
	ldx #00
	;jsr numberplot          ; plot tower shield damage
	numberplot_atari
	
	lda towerranges-4,y
	sta towertempnum
	lda #34 ;38
	sta $70
	ldx #00
	;jmp numberplot          ; plot tower range	rts implied
	;rts/
	numberplot_atari
	
	lda towerfiredisplayspeed-4,y
	sta towertempnum
	lda #42 ;43
	sta $70
	ldx #00
	;jsr numberplot          ; plot tower rate
	numberplot_atari

	lda #%11111111
	sta textcolour   ;draw in yellow
	lda towercosts,y
	sta towertempnum
	lda #50 ;48
	sta $70
	ldx #01
;	jsr numberplot          ; plot tower cost
	numberplot_atari
	
	;3rd figure of Cost
	mva #54 $70
	ldx #7
	charplot_atari
	

	rts

erasebox
	lda cursordisplayed
	beq noboxtoerase
	jsr drawbox
	lda #0
	sta cursordisplayed
noboxtoerase
	rts

plotbox
	lda #1
	sta cursordisplayed
	lda #0
	sta cursorcount
	jmp drawbox

drawbox
	; Routine to draw box round outside of tower square.
	; Takes X as index into tower list
	; Preserves X
	; Uses $70 and $71 to store offsets
;atari replace {
;	txa:pha
	stx xstore
; }
	lda #$20        
	sta $71       ; clear screen start in high byte
	lda txpos,X   ; a conains value 0-63 ish - assumed to be top left of tower.
	sec
/* atari remove
	sbc #3    ; Find top left
	asl @         ; multiply by 2 (since four pixles per byte)
*/
; atari add
	sbc #4
; }
	asl @ ;:asl @   ; Now multiply by 2 -
	asl @         ; and finish multiplaction to 8 - first time we could wrap
	sta $70       ; Store result
	rol $71       ; Set the bit in top byte if required
	lda typos,X   ; Get y position - this will be 0 - 63 - does not need to be divided to 512 - towers can't be at half positions
;atari add {
	lsr @
	cmp #1
	bne tfc1
	ldx showwave.shown
	beq tfc1
	mvx #0 topflag
	jmp tfc1x	
tfc1	mvx #$ff topflag
tfc1x
; }
	sec
/* atari remove
	sbc #3    ; Find top left
*/
;atari add {
	sbc #1
; }
	;asl @
	clc
	adc $71   ; Add to the x offset high byte 
	sta $71       ; And save $70 and $71 now point to the top left of the tower box

;atari add {
	lda topflag
	beq tfc2
	
	;decide if even or odd x position
	ldx xstore
	lda txpos,x
	and #$01
	jne oddframe.draw ;alternate frame drawing routine

; }
	ldy #4		;#4
boxtopleft
	;lda #%10001000
;atari replace {
;	lda #%11000000
	lda #%00001100
; }
	eor ($70),Y
	sta ($70),Y
	dey
	bne boxtopleft
	;lda #255
; atari replace {
;	lda #%11110000
	lda #%00001111
; }
	eor ($70),Y
	sta ($70),Y
	iny
; atari replace {
;	lda #%00110000
	lda #%00000011
; }
	eor ($70),Y
	sta ($70),Y

;atari add {
tfc2
;}
	; Bottom left
	lda $71
	clc
/* atari remove
	adc #4      ; 2 lines down
*/
;atari add {
	adc #2
; }
	sta $71	
	ldy #3		;3
boxbotleft
	;lda #%10001000
;atari replace {
;	lda #%11000000
	lda #%00001100
; }
	eor ($70),Y
	sta ($70),Y
	iny
	cpy #6
	bne boxbotleft
	;lda #255
;atari replace {	
;	lda #%11110000
	lda #%00001111
; }
	eor ($70),Y
	sta ($70),Y
	iny
;atari replace {	
;	lda #%11110000
	lda #%00001111
; }
	eor ($70),Y
	sta ($70),Y

	; bottom right
	clc
	lda $70
/* atari remove
	adc #8*5        ; Width of towers
*/ 
;atari add {
	adc #8*3
; }
	sta $70
	lda #0
	adc $71
	sta $71

	ldy #3		; #3
boxbotright
	lda #%00110000
	eor ($70),Y
	sta ($70),Y
	iny
	cpy #6
	bne boxbotright
	;lda #255
	lda #%11110000
	eor ($70),Y
	sta ($70),Y
	iny
	lda #%11110000
	eor ($70),Y
	sta ($70),Y

;atari add {
	lda topflag
	beq tbc3
;}
	;Top Right
	lda $71
	sec
/* atari remove
	sbc #4      ; 2 lines up
*/
;atari add {
	sbc #2
;}
	sta $71

	ldy #4		;#4
boxtopright
	lda #%00110000
	eor ($70),Y
	sta ($70),Y
	dey
	bne boxtopright
	;lda #255
	lda #%11110000
	eor ($70),Y
	sta ($70),Y
	iny 
	lda #%11000000
	eor ($70),Y
	sta ($70),Y


tbc3	;pla
	;tax
	ldx xstore
	rts
topflag	dta 0 ;0=do not draw top part of box
xstore	dta 0 ;stores X register


	;Routine to print the levels and waves
.proc showwave 

	lda shown
	cmp #1
	beq x0 ;do not show if already shown
	mva #1 shown
	pause 1
	;move data under text to temp space
	ldy #0
x1	lda gamevram,y
	sta lephtmp,y
	mva #0 gamevram,y
	dey
	bne x1
	
	;Set up for the copy
	lda #<(wavetext) ;$2ce2
	sta $70
	lda #>(wavetext)
	sta $71			; Origin text
	mwa #gamevram+8*9 $72	;position of text on screen
	ldy #8*12
	
showwaveloop
	dey
	lda ($70),y
	sta ($72),y
	cpy #0
	bne showwaveloop

/*atari remove
	lda #%00001111
	sta textcolour 
*/
	lda #26 ;32
	sta $70
	lda #0 ;30
	sta $77
	lda #level % 256
	sta $74
	lda #level / 256
	sta $75
	ldx #0
;	jsr numberplot   
	numberplot_atari
	
	lda #42 ;42
	sta $70
	lda #0 ;30
	sta $77
	lda #wave % 256
	sta $74
	lda #wave / 256
	sta $75
	ldx #0
;atari add {
	;jsr numberplot
	;jmp * ;temp debug
;}
;	jmp numberplot   
	numberplot_atari
x0	rts
	
restore
	lda shown
	cmp #1
	bne x0
	;move data from temp space back
	ldy #0
x2	lda lephtmp,y
	sta gamevram,y
	dey
	bne x2
	ldx currentlocation
	jsr erasebox
	mva #0 shown
	jsr plotbox
	
	rts	
	
shown	dta 0
.endp

clearstatusbox
	; Clear the status box
	pha
	txa
	pha

	; clear the area
	ldx #0
	txa
clearstatusboxloop
	dex
; atari replace {
	;sta $4000+512*29+19*8,x
	;sta $4000+512*30+19*8,x
	;sta $4000+512*31+19*8,x
	sta gamevram+256*29,x
	sta gamevram+256*30,x
	sta gamevram+256*31,x
	;possible that only part of line needs to be deleted
	;cpx #120
; }
	bne clearstatusboxloop

/* atari remove
	;write the "decenders"
	; $7af0=192 $7b40=192
	lda #192
	sta $7af0
	sta $7b40
*/
	pla
	tax
	pla
	rts


loadwave
	lda level
	and #$0f
	sub #1
	sta tmp
	asl @
	asl @
	add tmp ;(level-1)*5
	sta tmp
	lda wave
	and #$0f
	sub #1
	add tmp
	asl @ 	
	tax
	;X now contains index of wave from packed_waves

	mwa packed_waves,x inflater.inputPointer
	mwa #wavedata inflater.outputPointer
	jsr inflater.inflate

	rts
tmp	dta 0
packed_waves	
.rept 20,#+1
	dta a(datareloc.moveto + datareloc.z:1 - datareloc.loadarea) 
.endr

.proc	choose_sprites
/* atari off
loadspritefile

	lda #<(spritefilename)
	sta loadfileblock
	lda #>(spritefilename)
	sta loadfileblock+1
	lda #<(expl+(spritesize*3))
	sta loadfileblock+2
	lda #>(expl+(spritesize*3))
	sta loadfileblock+3
	; NO JMP BECAUSE NEXT TO LOAD FILE CODE
*/
	lda spritefilenumber
;atari replace {
;	and #$0f
;	sub #1
	sub #'a'
	asl @
	tax
	
	lda sprite_address_table,x
	sta w1
	lda sprite_address_table+1,x
	sta w1+1
	mwa #temppage w2
	
	ldy #sprows*2-1
x1	mva (w1),y (w2),y
	mva #0 sprite_shift.rem2,y
	dey
	bpl x1	
	
	sprite_preshift
	
	rts
sprite_address_table
.rept 19,#
	dta a(allsprites+(2*sprows)*(4+:1))
.endr

.endp
/* atari off - loaded as data block

	;Load a file - assumes load address and filename already provided
loadfile

	ldy #$11-4
	lda #0
clearloadblock
	sta loadfileblock+4,Y
	dey
	bne clearloadblock

	ldx #<(loadfileblock)
	ldy #>(loadfileblock)
	lda #$ff
;   TODO: this is supposed to load several sprite types at the same location one after another
         at this moment only sprite 1 is loaded, rest is not handled at all
	jsr $ffdd

	rts


	; Colour definitions
	green=%10000
	red=%00001
	cyan=%10001
*/
printscore

; atari add {

	mva #$f0 missile_drawchar.mask
	mva #$0f missile_drawchar.mask2
	
	mvx #0 b2
	ldy #56+(6+6+3)*8
pmscoreloop
	lda score,x
:4	lsr @
	missile_drawchar
	ldx b2
	
	lda score,x
	and #$0f
	missile_drawchar
	inc b2
	ldx b2
	cpx #4
	bne pmscoreloop
	rts
; }

	; Routine to print score to screen.
	; Uses number print - so $70-$75 - does not preserve registers
;atari remove {
;	lda #%00001111
;	sta textcolour 
; }
/*
	lda #8
	sta $70
	lda #31
	sta $77
	lda #score % 256
	sta $74
	lda #score / 256
	sta $75
	ldx #3
	jmp numberplot          ;
	;rts
*/

printgold

; atari add {

	mva #$f0 missile_drawchar.mask
	mva #$0f missile_drawchar.mask2
	
	mvx #0 b2
	ldy #56+6*8
pmgoldloop
	lda gold,x
:4	lsr @
	missile_drawchar
	ldx b2
	
	lda gold,x
	and #$0f
	missile_drawchar
	inc b2
	ldx b2
	cpx #3
	bne pmgoldloop
	rts
; }

	; Routine to print gold value to screen.
	; Uses number print - so $70-$75 - does not preserve registers
/*atari remove
	lda #%11111111
	sta textcolour 

	lda #8
	sta $70
	lda #30
	sta $77
	lda #gold % 256
	sta $74
	lda #gold / 256
	sta $75
	ldx #2
	jmp numberplot          ;last plotted index
	;rts
*/
showstatus
; atari add {

	mva #$f0 missile_drawchar.mask2
	mva #$0f missile_drawchar.mask

	ldy #32+7*8
	ldx lastplotidx
	lda ehealth,x
	sta b2
:4	lsr @
	missile_drawchar
	
	lda b2
	and #$0f
	missile_drawchar
	
; }


/* atari remove
	lda #%11110000
	sta textcolour

	lda #61
	sta $70
	lda #29
	sta $77
	lda #ehealth % 256
	clc
	adc lastplotidx
	sta $74
	lda #ehealth / 256
	adc #0
	sta $75
	ldx #0
	jsr numberplot          ;last enemy health
*/
; atari add {

	ldy #32+12*8
	ldx lastplotidx
	lda eshield,x
	sta b2
:4	lsr @
	missile_drawchar
	
	lda b2
	and #$0f
	missile_drawchar
	rts
; }

/* atari remove
	lda #%00001111
	sta textcolour

	lda #61
	sta $70
	lda #30
	sta $77
	lda #eshield % 256
	clc
	adc lastplotidx
	sta $74
	lda #eshield / 256
	adc #0
	sta $75
	ldx #0
	jmp numberplot          ;last enemy shield
	;rts
*/

	; Number plot routine.
	; Expects length of number string in X (in bytes) - zero relative
	; .textcolour = and mask for colour
	; $70 and $77 as screen location x=0 to 63, y=0 to 31
	; Also expects number location in $74,$75
	; Uses 70 and 71 as font location and 72 $ 73 as screen location

/*
numberplot
	tya
	pha
;atari remove
;	lda textcolour
;	sta $76

;atari add {
	lda $70
	and #$01
	bne numberplot2 ;different routine for midchar numbers
; }
	txa
	asl @
	adc $70          ;Add the length * 2 to the x coordinate
;atari remove
;	asl @
	
	asl @     ; Multiply by 4 (%00111111 to %11111100)
	sta $72         ; Store in screen location
	lda #$20        ; screen start / 2
	;sta $73         ; Save in high byte
	asl $72
	rol @   ; Multiply by 2 (total 8)
	sta $73
	lda $77
;atari remove
;	asl @           ; Multiply by 2 to make 512

	adc $73
	sta $73 ; Add to screen address and save
;.if codeoffset=$900
	lda #$a
	sta $71 ; Number high byte
;.else
;	lda #$f
;	sta $71 ; Number high byte
;.endif
numberloop
	txa
	tay         ; Transfer x to y
	lda ($74),Y     ; Load number byte
	lsr @           ; divide by 2
	and #%01111000 ; mask out low bits
	sta $70         ; Store low byte location
	ldy #7          ; Set plot loop
digit1loop
	lda ($70),Y     ; Get byte
;atari replace {
;	and $76         ; Change colour
	and #$f0
; }
	sta ($72),Y     ; Store in screen
	dey
	bpl digit1loop  ; And loop
;atari add {	
	;dex
	;bmi numberplotted
; }
	txa
	tay         ; X to y
	lda ($74),Y     ; Load number byte
	asl @
	asl @
	asl @ ; shift into location
	and #%01111000 ; mask out unused high bits
	sta $70         ; Store loop byte location
; atari remove
;	lda $72
;	clc
;	adc #8      ; Update screen location
;	sta $72
;	lda $73
;	adc #0  ; screen high
;	sta $73 
	ldy #7
digit2loop
	lda ($70),Y     ; Get byte
;atari replace {
;	and $76         ; Change colour
	and #$0f
	ora ($72),y
; }
	sta ($72),Y     ; Store in screen
	dey
	bpl digit2loop  ; And loop
	; Now update screen location to point to old number
	sec
	lda $72
;atari replace {
;	sbc #24 ;Subtract 2 characters
	sbc #8
; }
	sta $72
	lda $73
	sbc #0  ; High byte
	sta $73
	dex
	bpl numberloop
;atari add {
numberplotted
; }
	pla
	tay
	rts

numberplot2

.local	numberplot_2
	txa
	asl @
	adc $70          ;Add the length * 2 to the x coordinate
	asl @     ; Multiply by 4 (%00111111 to %11111100)
	sub #2
	sta $72         ; Store in screen location
	lda #$20        ; screen start / 2
	;sta $73         ; Save in high byte
	asl $72
	rol @   ; Multiply by 2 (total 8)
	sta $73
	lda $77
	adc $73
	sta $73 ; Add to screen address and save
	lda #$a
	sta $71 ; Number high byte
numberloop
	txa
	tay         ; Transfer x to y
	lda ($74),Y     ; Load number byte
	lsr @           ; divide by 2
	and #%01111000 ; mask out low bits
	sta $70         ; Store low byte location
	ldy #7          ; Set plot loop
digit1loop
	lda ($70),Y     ; Get byte
	and #$0f
	sta b1
	lda ($72),y ;half char masking
	and #$f0
	ora b1
	
	sta ($72),Y     ; Store in screen
	dey
	bpl digit1loop  ; And loop
	txa
	tay         ; X to y
	lda ($74),Y     ; Load number byte
	asl @
	asl @
	asl @ ; shift into location
	and #%01111000 ; mask out unused high bits
	sta $70         ; Store loop byte location
	ldy #7

	lda $72
	add #8
	sta $72
	lda $73
	adc #0
	sta $73

digit2loop
	lda ($70),Y     ; Get byte
	and #$f0
	sta b1
	lda ($72),y ;2nd half char masking
	and #$0f
	ora b1
	sta ($72),Y     ; Store in screen
	dey
	bpl digit2loop  ; And loop
	; Now update screen location to point to old number
	sec
	lda $72
	sbc #24 ;Subtract 2 characters
	sta $72
	lda $73
	sbc #0  ; High byte
	sta $73
	dex
	bpl numberloop
	pla
	tay
	rts

.endl
*/
	;Game over prety picture

	golscreenaddress = $70
	golineflag = $72
	gocolflag = $73
	gopixelbyte = $74
	goscreenoffset = $75
	goscreenpos=$5620
	gocolourbyte = $76
	gobitmapoffset = $77
	gobytedecodeloop=$78
/* atari remove
levellosesoundpitches
	dta 88,80,80,68,60,52
levellosesounddurations
	dta 20,15,5,10,10,20
*/
showloselogo
	lda #75
	jsr delay
;atari add {
	logo.show_defeat
	rts
;}
	
/*	atari remove

	ldx #0
levellosesoundloop
	txa
	pha
	ldy levellosesounddurations,x
	lda levellosesoundpitches,x
	tax
	lda #3
	jsr sadsound
	pla
	tax
	inx
	cpx #6
	bne levellosesoundloop

	lda #132
	sta gologolength+1	;Modify the length check

	lda #8		; Modify the second part of line amount
	sta golinelength+1

	lda #<(loselogo)
	sta gologolocation+1
	lda #>(loselogo)	; Modify the code pointing to the logo
	sta gologolocation+2

	;ldx #8
	;.loseloop
	;txa:pha

	;and #1
	;asl @:asl @
	lda #0
	sta gocolflag
;atari replace {
;	lda #<($5678)	;atari - ??? crazy absolute values
;	sta golscreenaddress
;	lda #>($5678)
;	sta golscreenaddress+1
	mwa #gamevram+$700 golscreenaddress
;}
	jsr gologo

	;lda #25:jsr delay
	lda #250
	jmp delay

	;pla:tax
	;dex
	;bne loseloop

	;rts
*/

showlevlogo
	lda #25
	jsr delay

;atari add {
	sfx.level_complete
	logo.show_level_complete
	pause 250
	rts
;}

/* atari remove
	lda #68
	sta gologolength+1	;Modify the length check

	lda #16			; Modify the second part of line amount
	sta golinelength+1

	lda #<(levlogo)
	sta gologolocation+1
	lda #>(levlogo)	; Modify the code pointing to the logo
	sta gologolocation+2

	lda #0
	sta gocolflag

;atari replace {
;	lda #<($6878)	;atari - ??? crazy absolute values
;	sta golscreenaddress
;	lda #>($6878)
;	sta golscreenaddress+1
	mwa #gamevram+$700 golscreenaddress
;TODO: convert gfx
; }

	lda #<(levcolourmap)
	sta gocolourmaplocation+1
	lda #>(levcolourmap)
	sta gocolourmaplocation+2


	jsr gologonocol


	ldx #0
levelwinsoundloop
	txa
	pha
	ldy levelwinsounddurations,x
	lda levelwinsoundpitches,x
	tax
	lda #3
	jsr bongsound
	pla
	tax
	inx
	cpx #5
	bne levelwinsoundloop

	lda #250
	jmp delay


	;rts
*/

showwinlogo
	logo.show_victory
	rts
	
/* atari remove
	ldx #0
gamewinsoundloop
	txa
	pha
	ldy gamewinsounddurations,x
	lda gamewinsoundpitches,x
	tax
	lda #3
	jsr bongsound
	pla
	tax
	pha
	ldy gamewinsounddurations,x
	lda gamewinsoundpitches,x
	tax
	lda #1
	jsr bongsound

	pla
	tax
	inx
	cpx #7
	bne gamewinsoundloop


	lda #170
	sta gologolength+1	;Modify the length check

	lda #16			; Modify the second part of line amount
	sta golinelength+1

	lda #<(winlogo)
	sta gologolocation+1
	lda #>(winlogo)	; Modify the code pointing to the logo
	sta gologolocation+2

	ldx #15
winloop
	txa
	pha

	and #1
	asl @
	asl @
	sta gocolflag

;atari replace {
;	lda #<($5670) ;atari - crazy absolute addressing
;	sta golscreenaddress
;	lda #>($5670)
;	sta golscreenaddress+1
	mwa #gamevram+$700 golscreenaddress
; }
	jsr gologo

	lda #25
	jsr delay

	pla
	tax
	dex
	bne winloop

	rts

gologo
	; Routine to display a pretty game over logo
	; Set up colour map
	lda #<(gocolourmap)
	sta gocolourmaplocation+1
	lda #>(gocolourmap)
	sta gocolourmaplocation+2


gologonocol
	ldx #0		; Offset into logo
	stx gobitmapoffset

goouterloop
	ldy #0		; Screen Address offset
	sty golineflag

	; Loop for line of data
golineloop

	ldx gobitmapoffset
gologolocation
	lda winlogo,x
	sta gopixelbyte

	lda #4
	sta gobytedecodeloop
gobyteloop
	lda gopixelbyte
	and #3
	clc
	adc gocolflag
	tax		; Alternate Colours
	lda #0
	sta (golscreenaddress),y
	iny
gocolourmaplocation
	lda gocolourmap,x
	sta (golscreenaddress),y
	lsr gopixelbyte
	lsr gopixelbyte
	iny
	lda gocolflag
	eor #4
	sta gocolflag
	dec gobytedecodeloop
	bne gobyteloop

	inc gobitmapoffset
	lda gobitmapoffset
gologolength
	cmp #$be
	beq gofinish
	lda golineflag
	bne gosecondpartofline		; are we the first time around?

	cpy #0				; Have we wrapped?
	bne golineloop
	inc golineflag
	inc golscreenaddress+1
	jmp golineloop

gosecondpartofline
golinelength
	cpy #48
	bcc golineloop

	; Increment line
	inc golscreenaddress+1
	jmp goouterloop

gofinish
	rts
*/

createhitsprite
	and #%11111
	sta etype,y	; reset the high bits and store
	tya
	pha
	txa
	pha
	lda etype,y		; Get the type
	sEC                   
	sBC #1                ; decrement by 1
	asl @
	asl @           ; multiply by 4 (4 bytes accoss)
;atari add {	
	asl @
; }
	aDC zt                ; and add in the horizontal shift
	cmp lasthitsprite
	beq alreadydonehit	; We've done this work before - let's not repeat the effort. 
	sta lasthitsprite
	tAX                   ; X contains sprite number * 4 + HORIZONTAL SHIFT
	lDA spritelowtable,X
	sTA zsoff
	lDA spritehightable,X
	sTA zsoff+1           ; Store offsets to sprite
	; We can now copy this sprite to the temporary sprite table
;atari replace {
;	ldy #14*4-1
	
	ldy #sprows*6-1	;6 chars (incl possible 3rd shifts)
; }
/* atari remove
hitspriteloop
	ldx #4
	lda #%10001
	sta zspos+2		; Pixel mask
	lda #0
	sta zspos+3		; Created byte
hitspritebitsloop
	lda (zsoff),y		; Get sprite byte
	and zspos+2		; compare with mask
	beq hitspritebitszero	; if zero skip or-ing
	lda zspos+3		; get created byte
	ora zspos+2		; or "white" into it.
	sta zspos+3		; And store
hitspritebitszero

	asl zspos+2		; Move the mask along
	dex
	bne hitspritebitsloop	; And loop

	lda zspos+3		; Get created byte
	sta tempsprite,y	; Store in new sprite
	dey
	bpl hitspriteloop	; Loop through the pixels
*/
;atari add {
hitspriteloop
	lda (zsoff),y
	and #%01010101 
	sta tempsprit,y
	dey
	bmi alreadydonehit
	lda (zsoff),y
	and #%10101010	;alter the mask to get "checkerboard"
	sta tempsprit,y
	dey
	bpl hitspriteloop

;}

alreadydonehit
	lda #>(tempsprit)
	sta zsoff+1
	lda #<(tempsprit)
	sta zsoff
	pla
	tax
	pla
	tay
	rts

/* atari off - data block
loadexplosions
	lda #<(explosionfilename)
	sta loadfileblock
	lda #>(explosionfilename)
	sta loadfileblock+1
	lda #<(expl)
	sta loadfileblock+2
	lda #>(expl)
	sta loadfileblock+3
	jmp loadfile
*/

loadscreen
/*
	lda #$27
	sta palt
	lda #$a7
	sta palt+1
	lda #$87
	sta palt+2			; Set pallette to black
					;for loading
	lda #((32*8*64-64)-512) / 256
	sta firsttime+1
	lda #((7*4*64+32)+512) / 256
	sta secondtime+1

*/
	jsr deletestatusrows


	lda level
/* atari off - loaded as data block

	and #15
	ora #$30				; Get ascii of of level number
	sta screenfilenumber
	lda #<(screenfilename)
	sta loadfileblock
	lda #>(screenfilename)
	sta loadfileblock+1
	lda #<(typos)
	sta loadfileblock+2
	lda #>(typos)
	sta loadfileblock+3
	jsr loadfile
	lda #$26			; Rest palette
	sta palt
	lda #$a1
	sta palt+1
	lda #$85
	sta palt+2

	lda #((32*8*64-64)-2) / 256
	sta firsttime+1
	lda #((7*4*64+32)-2) / 256
	sta secondtime+1		; Reset timers

	lda #50
	jmp delay

	;rts
*/
	and #$0f
	sub #1
	asl @
	sta tmpx
	tax
	
	;inflate level
	mwa levelptr,x inflater.inputPointer
	mwa #gamevram inflater.outputPointer
	jsr inflater.inflate
	
	;inflate leveldata
	ldx tmpx
	mwa leveldtaptr,x inflater.inputPointer
	mwa #leveldata inflater.outputPointer
	jsr inflater.inflate
	
	;inflate pmg overlay
	ldx tmpx
	mwa levelpmgptr,x inflater.inputPointer
	mwa #mypmbase inflater.outputPointer
	jsr inflater.inflate
	
	;copy tower neighboring schema
	ldx tmpx
	mwa neighbor_ptrs,x neicopy
	ldx #31
@	lda neighbors1,x
neicopy	equ *-2
	sta neighbors,x
	dex
	bpl @-
	
	
	jmp deletestatusrows
	
levelptr	dta a(datareloc.l1f+datareloc.moveto-datareloc.loadarea)
	dta a(datareloc.l2f+datareloc.moveto-datareloc.loadarea)
	dta a(datareloc.l3f+datareloc.moveto2-datareloc.loadarea)
	dta a(datareloc.l4f+datareloc.moveto2-datareloc.loadarea)
	
leveldtaptr
	dta a(datareloc.l1d+datareloc.moveto-datareloc.loadarea)
	dta a(datareloc.l2d+datareloc.moveto-datareloc.loadarea)
	dta a(datareloc.l3d+datareloc.moveto2-datareloc.loadarea)
	dta a(datareloc.l4d+datareloc.moveto2-datareloc.loadarea)
	
levelpmgptr
	dta a(datareloc.p1+datareloc.moveto-datareloc.loadarea)
	dta a(datareloc.p2+datareloc.moveto-datareloc.loadarea)
	dta a(datareloc.p3+datareloc.moveto-datareloc.loadarea)
	dta a(datareloc.p4+datareloc.moveto-datareloc.loadarea)
tmpx	dta 0	
	
deletestatusrows		; Delete sprite status rows

;atari add {
	clear_enemy_list
	rts
; }

/* atari remove
	; Store plot location in $8e and $8f.  8c,8d as line:8b as counter
	lda #(13317+$4000) % 256
	sta $8e
	lda #(13317+$4000) / 256
	sta $8f
	lda #3
	sta $8d
	lda #12
	sta $8b

clearlineouterloop
	lda $8e
	sta $8c
	lda $8f
	sta $8d
	ldx #64
	ldy #0		;80 bytes per line, y=0 for indexed addressing
clearinnerloop
	tya				; y always zero.
	sta ($8c),y	;Clear byte
	lda $8c
	clc
	adc #8
	sta $8c	;increment position along line - 8 bytes as a time;
	lda $8d
	adc #0
	sta $8d		;Do carry
	dex				; dec counter
	bne clearinnerloop		

	lda $8e
	;and #%111
	cmp #7				; Are we at the bottom of a block?
	bne notblockof8
	inc $8f
	inc $8f			; Increment row (512 bytes)
	lda #$ff
	sta $8e		; Store bottom bit ready to increment

notblockof8
	inc $8e				; Increment row start
	dec $8b				; Decrement counter
	bne clearlineouterloop

	rts
*/

;clears the videoram space where enemy types are shown
.proc	clear_enemy_list
	ldx #0
	txa
x1	sta gamevram.enemies,x
	dex
	bne x1
	
x2	lda #0 ;%01010101
	sta gamevram.enemies+$100,x
	sta gamevram.enemies+$100+1,x
	txa
	add #8
	tax
	bne x2
	
x3	lda #0 ;#%01010101
:4	sta gamevram.enemies-$100+4+:1,x
	txa
	add #8
	tax
	bne x3

	rts
.endp

;logo stuff
.local	logo

.proc	show_victory
	;hide the statusbar if shown
	set_status0

	;inflate to statusbar location
	mwa #[datareloc.moveto2+datareloc.windef-datareloc.loadarea] inflater.inputPointer
	mwa #gamevram.status inflater.outputPointer
	jsr inflater.inflate

	;copy logo from statusbar to videoram
	ldx #127
x1	
:4	mva gamevram.status+256*:1,x gamevram.logo+64+256*:1,x
	dex
	bpl x1	

	;set pmg overlay
	mva #32 logo_pmg_bg.lines
	logo_pmg_bg
	
	;set green color of the logo
	mva c_0:#$c4 gameDli.pc15
	sta gameDli.pc14
	
	sfx.victory
	
	ldx #5
x2	pause 250
	dex
	bne x2	
	
	color.fade_out_to_black2
	rts
.endp

;set logo pmg background (overlay)
.proc	logo_pmg_bg
	;set pmg overlay
	ldx #127-1-16
	ldy lines
	lda #$ff
x1	sta mypmbase+$100,x
	sta mypmbase+$200,x
	inx
	dey
	bne x1
	rts
lines	dta 0
.endp

.proc	show_defeat
	;hide the statusbar if shown
	set_status0

	;inflate to statusbar location
	mwa #[datareloc.moveto2+datareloc.windef-datareloc.loadarea] inflater.inputPointer
	mwa #gamevram.status inflater.outputPointer
	jsr inflater.inflate

	;copy logo from statusbar to videoram
	ldx #127
x1	
:4	mva gamevram.status+256*:1+128,x gamevram.logo+64+256*:1,x
	dex
	bpl x1	
	
	;set pmg overlay
	mva #32 logo_pmg_bg.lines
	logo_pmg_bg
	
	;set red color of the logo
	mva c_0:#$34 gameDli.pc15
	sta gameDli.pc14
	
	;mva #250 animate.delay
	;animate
	pause 50
	sfx.defeat
	pause 250

	color.fade_out_to_black2
	rts
.endp
	
.proc	show_level_complete
	;hide the statusbar if shown
	set_status0

	;hide wave info if shown
	jsr showwave.restore

	;inflate to statusbar location
	mwa #[datareloc.moveto2+datareloc.levcomp-datareloc.loadarea] inflater.inputPointer
	mwa #gamevram.status inflater.outputPointer
	jsr inflater.inflate
	
	;set pmg overlay
	mva #16 logo_pmg_bg.lines
	logo_pmg_bg
		
	;copy logo from statusbar to videoram
	ldx #127
x1	
:2	mva gamevram.status+256*:1,x gamevram.logo+64+256*:1,x
	dex
	bpl x1
	
	;set color of the logo
	mva c_0:#$62 gameDli.pc15
	rts
.endp

/*
.proc	animate
	;animate
x3	ldx #127-9-8
x21	txa
	add 20
	and #$01
	bne x22
x23	sta mypmbase+$100,x
	sta mypmbase+$200,x
	inx
	cpx #127+32-9-8
	bne x21	
	pause 0
	dec delay
	bne x3
	rts
	
x22	lda #$ff
	jmp x23
		
delay	equ 0
.endp
*/
.endl

	;.gocolourmap
	;dta %00000000
	;dta %00000011
	;dta %00001100
	;dta %00001111
	;dta %00000000
	;dta %00110000
	;dta %11000000
	;dta %11110000

	;.levcolourmap
	;dta %00000000
	;dta %00110011
	;dta %11001100
	;dta %11111111
	;dta %00000000
	;dta %00110011
	;dta %11001100
	;dta %11111111

/*atari remove
levelwinsoundpitches
	dta 108,124,136,124,128
levelwinsounddurations
	dta 5,5,5,5,10
*/

wavetext	;2ce2
	ins "leveltext\leveltext.fnt",0,12*8
	
/* atari remove
	
.print "wavetext (supposed to be $2ce2): ",wavetext
;	incbin "/home/chris/bem/spriter/leveltext.bin"
;towers	equ wavetext+$2d72-$2ce2 ;2d72
;	iNCBIN "/home/chris/bem/spriter/towers.bin"
.print "Towers ",towers
;notower	equ wavetext+$2f22-$2ce2 ;2f22
;	iNCBIN "/home/chris/bem/spriter/notower.bin"
.print "notower ",notower
	dta $07,$02,$02,$02,$02,$02,$07,$00,$00,$00,$00
	dta $00,$00,$02,$0E,$00,$00,$00,$06,$09,$0F,$08,$07,$00,$00,$00,$05
	dta $05,$05,$05,$02,$00,$00,$00,$03,$04,$07,$04,$03,$00,$06,$02,$02
	dta $0A,$0A,$02,$09,$00,$F0,$91,$91,$91,$91,$91,$F0,$00,$F0,$98,$98
	dta $98,$98,$98,$F0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$03,$01,$01,$00,$00,$00,$00,$00,$08,$00,$00
	dta $0A,$0A,$07,$05,$00,$0E,$04,$04,$09,$09,$01,$00,$00,$00,$00,$0C
	dta $02,$02,$02,$0E,$00,$00,$00,$0A,$0A,$0A,$0A,$04,$00,$00,$00,$06
	dta $09,$0F,$08,$07,$00,$F0,$91,$91,$91,$91,$91,$F0,$00,$F0,$98,$98
	dta $98,$98,$98,$F0,$00,$F0,$F0,$F0,$E0,$E0,$E0,$E0,$E0,$F0,$80,$66
	dta $CC,$8A,$05,$0B,$07,$C0,$D1,$C0,$01,$84,$4B,$2D,$5A,$10,$D8,$10
	dta $0C,$01,$0F,$A5,$5A,$F0,$80,$B1,$10,$0A,$49,$A4,$5A,$F0,$F0,$70
	dta $B8,$B0,$30,$38,$30,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$8B,$DC,$66
	dta $08,$86,$4A,$C3,$4A,$A5,$5A,$84,$59,$84,$41,$09,$0E,$A5,$5A,$01
	dta $D8,$01,$1C,$0C,$03,$A4,$58,$B1,$08,$83,$02,$0F,$0A,$B0,$B8,$30
	dta $38,$30,$38,$30,$38,$C0,$A0,$C0,$A0,$D0,$A0,$D0,$E0,$E0,$4A,$E0
	dta $4B,$61,$43,$21,$80,$07,$07,$07,$0E,$0C,$1C,$0C,$10,$07,$0F,$07
	dta $03,$01,$41,$81,$C0,$01,$02,$01,$0E,$0D,$0A,$0C,$00,$10,$28,$10
	dta $28,$10,$20,$50,$B0,$80,$77,$00,$61,$43,$00,$27,$00,$70,$B8,$30
	dta $38,$08,$06,$1D,$15,$F0,$E0,$D1,$B3,$66,$FE,$CC,$FE,$F0,$70,$B8
	dta $D8,$20,$D8,$20,$D9,$E0,$D1,$C0,$D0,$10,$26,$93,$02,$10,$EE,$00
	dta $86,$0E,$00,$0E,$00,$77,$77,$00,$43,$61,$43,$61,$43,$99,$8A,$23
	dta $1B,$08,$0F,$0F,$03,$88,$FA,$00,$5F,$00,$0F,$1F,$2E,$22,$D8,$00
	dta $0F,$00,$0F,$8F,$47,$91,$15,$0C,$1C,$10,$0F,$0F,$0C,$EE,$EE,$00
	dta $86,$0C,$0E,$0C,$0A,$60,$42,$60,$42,$61,$83,$A1,$C0,$CD,$C9,$C1
	dta $01,$0F,$0F,$0F,$00,$4C,$4C,$88,$88,$88,$A8,$98,$70,$23,$23,$11
	dta $11,$11,$91,$51,$E0,$3B,$3A,$38,$08,$0F,$0E,$05,$00,$04,$02,$04
	dta $02,$04,$18,$14,$30,$80,$77,$00,$70,$70,$00,$77,$77,$70,$B8,$30
	dta $80,$F0,$77,$BB,$B9,$F0,$C0,$B3,$00,$F0,$FF,$CC,$BB,$F0,$30,$DC
	dta $00,$F0,$FF,$33,$DD,$E0,$D1,$C0,$10,$F0,$EE,$DD,$DD,$10,$EE,$00
	dta $E0,$E0,$00,$EE,$EE,$00,$75,$76,$75,$66,$44,$44,$44,$30,$B0,$88
	dta $F5,$D8,$C4,$C8,$C4,$88,$B1,$32,$F5,$FA,$F5,$EB,$C6,$10,$D4,$C8
	dta $F5,$FA,$F5,$7A,$35,$CC,$D5,$10,$F5,$BA,$31,$32,$31,$00,$E4,$EA
	dta $EC,$66,$20,$22,$20,$47,$65,$56,$21,$54,$20,$90,$C0,$CB,$E5,$DA
	dta $E5,$52,$A0,$50,$00,$8C,$80,$08,$00,$11,$22,$50,$F0,$12,$11,$01
	dta $00,$44,$AA,$40,$F0,$3E,$B5,$7A,$B5,$7A,$A0,$50,$00,$2E,$A4,$48
	dta $A4,$40,$A0,$50,$30,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
	dta $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
	dta $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
	dta $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
	dta $E0,$D0,$A0,$D0,$A0,$F0,$F0,$D0,$A0,$70,$F0,$E0,$F0,$F0,$F0,$50
	dta $A0,$F0,$F0,$30,$F0,$F0,$F0,$F0,$B0,$50,$A0,$D0,$A0,$F0,$F0,$F0
	dta $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$D0,$E0,$F0
	dta $F0,$F0,$F0,$F0,$F0,$70,$A0,$D0,$F0,$F0,$F0,$F0,$F0,$F0,$A0,$50
	dta $F0,$F0,$F0,$F0,$F0,$50,$B0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
	dta $F0,$F0,$F0,$F0,$F0
*/

endage

;initialize game parameters
.proc	gameparams_init
	ldx #wavedata-leveldata_end
	lda #0
x1	sta leveldata_end,x
	dex
	bne x1
	sta leveldata_end
	mva #0 unlocked_level
	inx
	stx starting_level
	rts
.endp

;initialization for the game
.proc	game_init

	mwa #NMI $fffa
	
	mwa #dl dlistl
	mwa #gameDli.dli1 dli_ptr ;vdslst
	mwa #gameVbi.vbi vbi_ptr
	;clean up memory areas
	ldx #0
	txa
x1	sta mypmbase-$100,x
	sta leveldata_end,x ;game initialization
	dex
	bne x1
	
	;inflate scoreboard
	mwa #[datareloc.sboard-datareloc.loadarea+datareloc.moveto2] inflater.inputPointer
	mwa #scorebrd inflater.outputPointer
	jsr inflater.inflate

	;inflate allsprites	
	mwa #[datareloc.allsprit-datareloc.loadarea+datareloc.moveto2] inflater.inputPointer
	mwa #allsprites inflater.outputPointer
	jsr inflater.inflate

	preshift_explosion_sprites
	
	;inflate ingame music
	mwa #ingamemusic inflater.inputPointer
	mwa #music2-6 inflater.outputPointer ;-6 because deflated file contains header
	jsr inflater.inflate
	
	lda #$01	;initialize rmt player with silence
	jsr sfx.init
	
	;lda #0
	;cmp:rne vcount	;removes glitch on endgame
	hide_enemybar
	
	mva #$c0 nmien ;80 dli, 40 vbi
	;mva #1+12+32 dmactl ;d400 = 559
	;level_pmg
	rts
.endp

.proc	show_enemybar
	mva c_0:#$32 gameDli.ebc1
	mva #$0f gameDli.ebc2
	rts
.endp

.proc	hide_enemybar
	mva #$00 gameDli.ebc1
	sta gameDli.ebc2
	rts
.endp

;returns pressed key (code)
.proc	getkeypressed
		
	lda skctl
	and #4
	bne keynotpressed
keypressed
	lda keystat
	beq readkey
	bne stillpressed
	dta 2 ;code cannot get here
	jmp *
keynotpressed
	mva #0 keystat
	
stillpressed
	lda #255
	rts
	
readkey	lda #1
	sta keystat

	ldx kbcode
	lda keytable,x
	
	a_in #"P" #"Y" num09 ;handle numbers
	sta keypres
	rts
	
num09	sub #"P"
	ora #$10
	
	sta keypres
	rts
.endp

;returns #1 if space is pressed at the moment
.proc	spacepressed 
	lda keypres ;last key pressed
	cmp #"@"
	bne x0
	lda keystat
	beq x0
	lda #1
	rts
x0	lda #0
	rts
.endp


;set no status bar
.proc	set_status0
	mva >gameDli.dlix gameDli.ptr1h
	mva <gameDli.dlix gameDli.ptr1l
	
	mva >gameDli.dli3 gameDli.ptr3h
	mva <gameDli.dli3 gameDli.ptr3l
	;todo: clear sbar selectio0n
	
	revert_pmg
	mva #0 sbarvisib
	mva sbarmin sbarselec	
	rts
.endp

;set status bar top
.proc	set_status1
	mva >gameDli.dlix3 gameDli.ptr1h
	mva <gameDli.dlix3 gameDli.ptr1l

	mva >gameDli.dli3 gameDli.ptr3h
	mva <gameDli.dli3 gameDli.ptr3l
	mva #1 sbarvisib
	mva sbarmin sbarselec	
	store_pmg
	sbarcontrols_local.draw_sbarselec
	rts
.endp

;set status bar bottom
.proc	set_status2
	mva >gameDli.dli4x gameDli.ptr3h
	mva <gameDli.dli4x gameDli.ptr3l
	
	mva >gameDli.dlix gameDli.ptr1h
	mva <gameDli.dlix gameDli.ptr1l
	mva #2 sbarvisib
	mva sbarmin sbarselec	
	store_pmg
	sbarcontrols_local.draw_sbarselec
	rts
.endp


.local	gameVbi
vbi	phr
	inc 20
	
	;some unknown stuff from orig code
	;inc timerflag ;had something to do with the palette change (like DLI) 
	inc vsynccount
	
	mva #>gamevram chbase
	
	lda >gameDli.dliy
ptryh	equ *-1
	sta dli_ptr+1
	lda <gameDli.dliy
ptryl	equ *-1
	sta dli_ptr
	
	lda showwave.shown
	beq x1 ;if game started then hide level,phase text
	
	mva c_0:#$14 colpf0+2
	mva #$0c colpf0+1 ;white lum
pc00	equ *-4
	lda #$90
pc01	equ *-1
:4	sta colpm0+:1
	mva c_1:#$a6 colpf0+3	;missile color
	mva #$14 prior
	
xplay	lda palsystem
	beq play
	;ntsc part
	inc ntsctimer
	lda ntsctimer
	cmp #6
	bne play
	mva #0 ntsctimer
	jmp quit
	
play	jsr rmt.rmt_play
quit	plr
	rti

; no top textline
x1	mva #$94 colpf0+2
pc04	equ *-4
	mva #$0c colpf0+1 ;white lum
pc02	equ *-4
	lda #$90
pc03	equ *-1
:4	sta colpm0+:1
	mva c_2:#$a6 colpf0+3	;missile color
	mva #$11 prior
	jmp xplay	
	
.endl

.local	gameDli
;first part after leveltext line
dliy	pha
	sta wsync
	mva #$11 prior
	mva #$94 colpf0+2
pc05	equ *-4
	lda >gameDli.dlix
ptr1h	equ *-1
	sta dli_ptr+1
	lda <gameDli.dlix
ptr1l	equ *-1
	sta dli_ptr
	pla
	rti

;second part normal (no statusbar)
dlix	pha
	sta wsync
	mva #>[gamevram+$0400] chbase
	mwa #dli0 dli_ptr
:3	sta wsync
	mva c_0:#$2c colpf0+3	;missile
	pla
	rti

;second part with statusbar top
dlix3	pha
	sta wsync
	mva #$11 prior ;14
	mva #>[gamevram+$1c00] chbase
	mva #$08 colpf0+2
	mva #$08 colpf0+1
	sta wsync
	mva #$06 colpf0+2
	
	lda c_1:#$24 
:4	sta colpm0+:1
	sta wsync	
	
	mva #$0c colpf0+1
:6	sta wsync
	mva #$04 colpf0+2
	
	mwa #dlix2 dli_ptr
	mva c_2:#$2c colpf0+3	;missile
	pla
	rti


;third part (when no statusbar above)
dli0	pha
	sta wsync
	mva #>[gamevram+($400*2)] chbase
	mva #$94 colpf0+2
pc06	equ *-4
	mwa #dli1 dli_ptr
	pla
	rti

;third part (when statusbar top above)	
dlix2	pha
	mva #$11 prior
	lda #$90
pc12	equ *-1
:4	sta colpm0+:1

	mva #$94 colpf0+2
pc07	equ *-4
	mva #>[gamevram+($400*2)] chbase
	mva #$11 prior
	mva #$0c colpf0+1
pc08	equ *-4
	mwa #dli1 dli_ptr
	pla
	rti

;fourth part - logo
.rept 1,#+1,#+2,#+3
dli:1	pha
	sta wsync
	mva #>[gamevram+($400*:3)+$0000] chbase
	
	mva #$00 colpm0+1
pc15	equ *-4
	sta colpm0+2
	lda #>dliulog ;dli:2
ptr:2h	equ *-1
	sta dli_ptr+1
	lda #<dliulog ;dli:2
ptr:2l	equ *-1
	sta dli_ptr
	pla
	rti
.endr

;fourth part (half under level complete logo)
dliulog	pha
	sta wsync
	mva #$00 colpm0+1
pc14	equ *-4
	sta colpm0+2
	mwa #dli2 dli_ptr
	pla
	rti

;fifth (under logo)
.rept 1,#+2,#+3,#+4
dli:1	pha
	sta wsync
	mva #>[gamevram+($400*:3)+$0000] chbase
	
	mva #$0 colpm0+1
pc13	equ *-4
	sta colpm0+2
	lda #>dli:2
ptr:2h	equ *-1
	sta dli_ptr+1
	lda #<dli:2
ptr:2l	equ *-1
	sta dli_ptr
	pla
	rti
.endr

;sixth part
.rept 1,#+3,#+4,#+5
dli:1	pha
	sta wsync
	mva #>[gamevram+($400*:3)+$0000] chbase
	
	lda #>dli:2
ptr:2h	equ *-1
	sta dli_ptr+1
	lda #<dli:2
ptr:2l	equ *-1
	sta dli_ptr
	pla
	rti
.endr

.rept 1,#+1+3,#+2+3,#+3+3
dli:1	pha
	sta wsync
	mva #>[gamevram+($400*:3)+$0000] chbase
	
	lda #>dli:2
ptr:2h	equ *-1
	sta dli_ptr+1
	lda #<dli:2
ptr:2l	equ *-1
	sta dli_ptr

:20	sta wsync
	mva c_3:#$32 colpf0+2 ;enemybar color
ebc1	equ *-4
	mva #$0f colpf0+1 ;white lum
ebc2	equ *-4
	mva #4+16 prior
	pla
	rti
.endr

;bottom statusbar
dli4x	pha
	sta wsync
	mva #$11 prior ;14
	mva #>[gamevram+$1c00] chbase
	mva #$08 colpf0+2
	mva #$08 colpf0+1
	sta wsync
	mva #$06 colpf0+2
	lda c_4:#$24 
:4	sta colpm0+:1
	
	sta wsync
;	mva #$06 colpf0+2
	mva #$0c colpf0+1
:6	sta wsync
	mva #$04 colpf0+2
	mwa #dli5x dli_ptr
	pla
	rti
		
dli5x	pha
	mva #$11 prior
	lda #$90
pc09	equ *-1
:4	sta colpm0+:1	
	
	;enemybar
	mva #>[gamevram+($1800)] chbase
	mva #$94 colpf0+2
pc10	equ *-4
	mva #$0c colpf0+1
pc11	equ *-4
	mwa #dli5 dli_ptr

:20	sta wsync	
	mva c_5:#$32 colpf0+2 ;enemybar color
	mva #$0f colpf0+1 ;white lum
	mva #4+16 prior
	pla
	rti
	
dli5	pha
	sta wsync
	mva #>[gamevram+($400*7)] chbase
:2	sta wsync
	mva #0 colpf0+2 ;hide part right under enemybar
	sta colpf0+1
	pla
	rti 
.endl	


;atari replace
;	ORG codeoffset
codeoffset
;	guard codeoffset+$ff
;atari off
;	jmp initinterrupts

/* atari off

clearscreen
	; Routine to clear the screen data block ($3000 to $7fff)
	; Makes the mode change look better

	lda #00
	sta $70
	lda #$30
	sta $71
	lda #0
	ldy #0
clearscreenloop
	sta ($70),y
	dey
	bne clearscreenloop
	inc $71
	ldx $71
	cpx #$80
	bne clearscreenloop
	rts
	; Interrupt routine
initinterrupts
	;lda #19
	;jsr $fff4

	;ldx #100
	;.intwait
	;dex
	;bne intwait

	sei
	lda $204
	sta prev_irq
	lda $205
	sta prev_irq+1
	lda #inthandler % 256
	sta $204
	lda #inthandler / 256
	sta $205
	lda #$20
	sta $fe6e
	sta $fe6d
	lda #4
	sta $fe6c
	lda #0
	sta $fe6b
	;set timer to be different to vsync
	lda #$fe
	sta $fe44
	lda #$26
	sta $fe45
	cli

	rts
*/
	;vsynctotop=(32*8*64-64)-2
	;secondtime=(7*4*64+32)-2

/* atari off
inthandler

	lda $fe4d
	and #$02
	beq not_vsync

	lda firsttime
	sta $fe68
	lda firsttime+1
	sta $fe69
	lda #$A0
	sta $fe6e

	lda intflag
	beq done

	;lda #$26                ; Palette colour for top of screen
	;jsr set_palette_colour
	;lda #$a1                ; Palette colour for top of screen
	;jsr set_palette_colour
	;lda #$03                ; debug
	;jsr set_palette_colour

	;inc vsynccount

done
	jmp (prev_irq)

not_vsync
	lda $fe6d
	and #$20
	beq done

	sta $fe6d

	lda intflag
	beq done

	lda timerflag
	bne secondcols

	inc timerflag
	inc vsynccount

	lda #$a4                ; Palette colour for bottom of screen
	jsr set_palette_colour
	lda #$20                ; Palette colour for bottom of screen
	jsr set_palette_colour
	lda #$85                ; Palette colour for bottom of screen
	jsr set_palette_colour

	lda secondtime
	sta $fe68
	lda secondtime+1
	sta $fe69
	lda #$A0
	sta $fe6e

	jmp (prev_irq)

secondcols
	lda palt                ; Palette colour for top of screen
	jsr set_palette_colour
	lda palt+1                ; Palette colour for top of screen
	jsr set_palette_colour
	lda palt+2                ; Palette colour for top of screen
	jsr set_palette_colour

	lda #0
	sta timerflag

	jmp (prev_irq)

set_palette_colour
	sta $fe21
	eor #$10
	sta $fe21
	eor #$40
	sta $fe21
	eor #$10
	sta $fe21
	rts

palt
	dta $26
	dta $a1
	dta $85

firsttime
	dta [(32*8*64-64)-2] % 256
	dta [(32*8*64-64)-2] / 256

secondtime
	dta [(7*4*64+32)-2] % 256
	dta [(7*4*64+32)-2] / 256


prev_irq 
	.word 0

timerflag
	dta 0

vsynccount
	dta 0

intflag
	dta 0

gamewinsoundpitches
	dta 116,124,116,108,116,128,148
gamewinsounddurations
	dta 7,4,7,7,7,8,16
*/
numberend

eventend
/*atari remove
	org codeoffset+$100
;	guard codeoffset+$1ff
	ins "srcdata/numbers.bin" ;bin.fnt (for debug)
*/
	;INCBIN "/home/chris/bem/spriter/numbers.bin"
/* atari remove
	dta     $44,$AA,$AA,$AA,$AA,$AA,$44,$00,$44,$CC,$44,$44,$44,$44,$EE
	dta $00,$44,$AA,$22,$44,$88,$88,$EE,$00,$CC,$22,$22,$CC,$22,$22,$CC
	dta $00,$88,$88,$88,$88,$AA,$EE,$22,$00,$EE,$88,$88,$CC,$22,$AA,$44
	dta $00,$66,$88,$88,$CC,$AA,$AA,$44,$00,$EE,$22,$22,$44,$44,$44,$44
	dta $00,$44,$AA,$AA,$44,$AA,$AA,$44,$00,$44,$AA,$AA,$66,$22,$22,$CC
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$99,$99,$99,$99,$99,$99,$77
	dta $00,$66,$44,$00,$00,$00,$44,$66,$00,$33,$11,$00,$00,$00,$11,$33
	dta $00			;0A6F 00
*/
	;.savedtowerdist
	;  dta 100
	;.towerdistance
	;  dta 100

/*
spritefilename
	dta "S."
spritefilenumber
	dta "1"
	dta $0d

screenfilename
	dta "L."
screenfilenumber
	dta "1"
	dta $0d
*/
printleft

; atari add {

	mva #$f0 missile_drawchar.mask2
	mva #$0f missile_drawchar.mask
	
	ldy #32+17*8
	lda numberofenemies
:4	lsr @
	missile_drawchar

	lda numberofenemies
	and #$0f
	missile_drawchar
	
; }

/*atari remove	
	; Routine to print number of enemies left to screen.
	; Uses number print - so $70-$75 - does not preserve registers
	lda #%11111111
	sta textcolour 
	lda #61
	sta $70
	lda #31
	sta $77
	lda #numberofenemies % 256
	sta $74
	lda #numberofenemies / 256
	sta $75
	ldx #0
	jmp numberplot
*/
printlives
	; Routine to print lives to screen.
	; Uses number print - so $70-$75 - does not preserve registers
	
; atari add {
	mva #$f0 missile_drawchar.mask
	mva #$0f missile_drawchar.mask2

	ldy #56+1*8
	lda lives
:4	lsr @
	missile_drawchar
	
	lda lives
	and #$0f
	missile_drawchar
	rts
; }
/* atari remove	
	lda #%11110000
	sta textcolour 
	lda #8
	sta $70
	lda #29
	sta $77
	lda #lives % 256
	sta $74
	lda #lives / 256
	sta $75
	ldx #0
	jmp numberplot          
	;rts

apage

	org codeoffset+$200
*/
;	guard codeoffset+$3ff
  ; Tower cost/damage data structures
  ; Each tower has 4 levels - for each of the three towers
towercosts           ; Divided by 10 - stored as bcd
  dta 0,0,0,0	; Zero padding for the blank tower to allow to be plotted
  dta $14,$15,$22,$35
  dta $20,$23,$28,$40
  dta $37,$43,$55,$75
towerranges          ; BCD for displayt
  dta $15,$18,$21,$24
  dta $21,$23,$25,$27
  dta $25,$27,$29,$31
towerrangesactual    ; Hex for actual square of range/4
  dta 72,90,110,144
  dta 132,144,156,169
  dta 156,182,210,240
towerphysical        ; PHysical damage
  dta $02,$03,$05,$07
  dta $00,$00,$00,$01
  dta $06,$11,$17,$25
towershield          ; Shield Damage
  dta $00,$00,$00,$01
  dta $04,$07,$10,$15
  dta $01,$02,$04,$07
towerfirespeed       ; Time between shots
  dta $16,$15,$14,$13
  dta $20,$17,$15,$12
  dta $30,$27,$22,$18
towerfiredisplayspeed       ; Time between reciprocal
  dta $63,$67,$71,$77
  dta $50,$59,$67,$83
  dta $33,$37,$45,$56

towerlocations		; Locations of tower sprites
  .word notower           ; Padding ;2f22
/*atari replace  
  .word towers ;2d72
  .word towers+24*6 ; 24x24/4 ppb
  .word towers+24*6*2 ; 24x24/4 ppb
*/
:3	.word towers+:1*12*8
towerlocations2
  .word notower2
:3	.word towers2+:1*9*8

/* atari remove
colourtable
	dta %0001,%10000,%10001
*/
towertempnum
	dta 00,$0a		; Needs to be defined because od $0a

/* atari remove
explosionfilename
	dta "EXPLODE"
	dta $0d

wavefilename
	dta "W."
wavefilenumber
	dta "1"
	dta $0d


levlogo ;0b71
.print "levlogo suppose to be $0b71: ",levlogo
	;incbin "/home/chris/bem/spriter/LEVCOMPB"
winlogo 	equ levlogo+$bb4-$b71 ;0bb5
	;incbin "/home/chris/bem/spriter/WINB"
loselogo  equ levlogo+$c5f-$b71 ;0c5f
	;incbin "/home/chris/bem/spriter/LOSEB"

	dta $00,$00,$AA,$00,$50,$CC,$A0,$A8,$A8,$E4,$D8,$55,$00,$54
	dta $03,$06,$50,$0C,$A0,$AC,$AC,$A0,$54,$0C,$A0,$AA,$E4,$D8,$5D,$08
	dta $E4,$D8,$00,$00,$00,$00,$0E,$0C,$01,$0C,$08,$05,$00,$06,$0C,$05
	dta $00,$01,$0C,$09,$01,$0C,$02,$0A,$0A,$0A,$55,$0C,$02,$0A,$06,$0C
	dta $01,$08,$06,$0C,$00,$00
L_0BB5	dta $5C,$F8,$00,$00,$50,$BC,$14,$3C,$00,$00,$00,$00,$00,$00,$00,$54
	dta $FC,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $FC,$A8,$01,$FF,$A8,$00,$FD,$0A,$55,$FF,$00,$D4,$BD,$0F,$7E,$E8
	dta $05,$5F,$FF,$0F,$D4,$BD,$0F,$7E,$E8,$55,$FF,$B4,$0B,$15,$FE,$00
	dta $54,$AA,$FF,$AA,$00,$15,$FF,$D5,$AB,$00,$55,$FF,$00,$FF,$AA,$00
	dta $40,$C0,$00,$55,$FF,$00,$FF,$AA,$00,$55,$FF,$55,$FF,$00,$00,$00
	dta $7F,$EA,$BF,$00,$3F,$2A,$00,$00,$1F,$3F,$00,$00,$15,$3F,$00,$05
	dta $1F,$3C,$2F,$0A,$00,$05,$3F,$3C,$05,$1F,$3C,$2F,$0A,$15,$3F,$00
	dta $00,$00,$05,$FF,$0A,$00,$3F,$2A,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$14,$3D,$0B,$00,$00,$00,$00,$54,$FC,$FC,$FC,$F8,$E0
	dta $00,$00,$00,$00,$00,$00,$00,$FD,$AF,$0A,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$FC,$A8,$00,$FC,$A8,$55,$FF,$00,$00,$07
	dta $FF,$A8,$D4,$BD,$0F,$7E,$E8,$05,$FF,$AF,$0A,$D4,$BD,$0F,$7E,$E8
	dta $10,$3D,$0F,$5F,$FC,$00,$0F,$FF,$AF,$0A,$FF,$AA,$55,$FF,$00,$00
	dta $D0,$FF,$2A,$FF,$AF,$0F,$4F,$CF,$00,$FF,$AA,$00,$FF,$AF,$0F,$4F
	dta $CF,$50,$FC,$0B,$57,$FF,$00,$00,$FF,$AA,$00,$3F,$2A,$15,$3F,$3F
	dta $3F,$2F,$0B,$00,$05,$1F,$3C,$2F,$0A,$00,$3F,$2A,$00,$05,$1F,$3C
	dta $2F,$0A,$05,$3F,$3C,$1F,$3F,$00,$00,$1F,$3E,$28,$3F,$2A

gocolourmap
	dta %00000000
	dta %00110011
	dta %11001100
	dta %11111111
	dta %00000000
	dta %00110000
	dta %11000000
	dta %11110000

levcolourmap
	dta %00000000
	dta %00000011
	dta %00001100
	dta %00001111
	dta %00000000
	dta %00000011
	dta %00001100
	dta %00001111

*/

firetypes		;bullet types data
/*atari remove
	dta %00000000
	dta %00000110
	dta %00000110
	dta %00000000

	dta %00001001
	dta %01100110
	dta %01100110
	dta %00001001

	dta %10011001
	dta %00000110
	dta %00000110
	dta %10011001
*/
;atari add:
	dta %00000000
	dta %01100000
	dta %01100000
	dta %00000000
	
	dta %10010000
:2	dta %01100000
	dta %10010000
	
	dta %11110000
:2	dta %10010000
	dta %11110000

firetypes_right
	dta %00000000
	dta %00000110
	dta %00000110
	dta %00000000
	
	dta %00001001
:2	dta %00000110
	dta %00001001
	
	dta %00001111
:2	dta %00001001
	dta %00001111

;set black for color registers
.proc	PitchBlack
	lda #0
:5	sta colpf0+:1
	rts
.endp

;manipulation with level colors
.local 	color

.proc	set
	mwa #ptrdata1 w1
	ldy #0
	
.rept 3,#
	ldx data2+:1
x1:1	mva (w1),y ptr:1
	iny
	mva (w1),y ptr:1+1
	lda data0+:1
	sta $ffff
ptr:1	equ *-2
	iny
	dex
	bne x1:1
.endr	
	rts
.endp


/*
.proc	fade_out_to_black
x3	ldx #3
	mva #0 flag
x1	lda data0,x
	and #$0f
	bne x2
	
x5	dex
	bpl x1
	
	color.set
	pause 0
	
	lda flag
	bne x3	;repeat until change	
	black
	rts

x2	dec data0,x
	dec data0,x
	inc flag
	jmp x5
	
.endp
*/

.proc	fade_out_to_black2
x3	ldx #15*2
	mva #0 flag
	
x1	lda ptrdata1,x
	sta w1
	lda ptrdata1+1,x
	sta w1+1
	
	ldy #0
	lda (w1),y
	
	and #$0f
	bne x2
	
x5	dex
	dex
	bpl x1
	
	pause 0
	
	lda flag
	bne x3	;repeat until change	
	black
	hide_enemybar
	pause 0	;to be sure that the black is applied 
	rts

x2	lda (w1),y
	sub #2
	sta (w1),y
	inc flag
	jmp x5
.endp

;set black colors
.proc	black
	lda #$00
	sta data0
	sta data0+1
	sta data0+2
	sta data0+3
	color.set
	rts
.endp

;x - level number (0..3)
.proc	fade_in_from_black
	txa
	asl @
	asl @
	add #3
	sta temp
	/*stx temp
	txa
	asl @
	add temp
	add #2
	sta temp ;(data1 index - last color)
	*/
	ldy temp
	ldx #3
x1	lda data1,y
	and #$f0
	sta data0,x
	dey
	dex
	bpl x1
	
	color.set
	pause 0

	;color changes
x5	mva #0 flag
	ldx #3
	ldy temp
x3	lda data0,x
	cmp data1,y
	bne x2 
x4	dey
	dex
	bpl x3
	
	color.set
	pause 0
	
	lda flag
	bne x5	;repeat until no change
	show_enemybar
	rts

;update color
x2	inc data0,x
	inc data0,x
	inc flag
	jmp x4	
	
.endp

data0	dta $0c,$04,$00,$62	;actual colors
	
data1	dta $9c,$94,$90,$62	;blueish
	dta $bc,$b4,$b0,$62	;green
	dta $ec,$e4,$e0,$62	;yellow
	dta $2c,$26,$20,$62	;red
;fadein:	
data2	dta 4,5,7		;amount of ptrdatas
;fadeout:
data2x	dta 4,5,6		;amount of ptrdatas

temp	dta 0
flag	dta 0

;pf1 - white lum (brightest)
ptrdata1	dta a(gamevbi.pc00),a(gamevbi.pc02)
	dta a(gameDli.pc08),a(gamedli.pc11)
;pf2 - midbright color
ptrdata2	dta a(gamevbi.pc04),a(gameDli.pc05)
	dta a(gameDli.pc06),a(gameDli.pc07)
	dta a(gameDli.pc10)
;pmx - pm color (darkest)
ptrdatap	dta a(gamevbi.pc01),a(gamevbi.pc03)
	dta a(gameDli.pc09),a(gameDli.pc12)
	dta a(gameDli.pc13),a(gameDli.pc14)
ptrdatac	dta a(gameDli.pc15)
.endl

lowcodeend
/*
.pRINT "Event Code End ",eventend
.pRINT "Enemy health ",ehealth
.pRINT "Enemy shield ",eshield
.prINT "Enemy type ",etype
.pRINT "Tower x pos ",txpos
.pRINT "Tower y pos ",typos
.pRINT "Tower type ",ttype
.pRINT "Tower fire count ",tfcount
.pRINT "Tower fire target ",tftarget
;.pRINT "Sprites ",sprites
;.pRINT "Explosions ",expl
.print "Lives ",lives
.print "Score ",score
.print "Wave ",wave
.print "Level ",level

	;  PRINT ".setup ",setup
  ;PRINT ".mainloop ",mainjump
  ;PRINT ".plotlots ",plotjump
  ;print ".plottower ",towerjump
  ;print ".numberplot",numberplot, " to ",numberend
  ;print ".drawbox",boxjump
.print "Main Code ",start," - ",endage," (",endage-start,")"
.print "Low code ",codeoffset," - ",lowcodeend," (",lowcodeend-codeoffset,")"
;.print "Free space: Main = ",$3000-32-endage," Variables = ",expl-varend," etype location = ",etype,"-",varend
.print "interrupts $ Numbers = ",codeoffset+$ff-numberend," ",numberend 
.print "table data ",codeoffset+$3ff-lowcodeend
.print "level data size = ",varend-wavedata
.print "A Page",codeoffset+$1ff-apage," ",apage
.print "pal ",palt
*/
/*.print "firsttime ",firsttime
.print "secondtime ",secondtime
.print "intflag",intflag
*/
/*	if codeoffset=$900
	save "CDCode",start,end
	save "LowCode",$900,lowcodeend
	else
	save "CDCodeM",start,end
	save "LowCodM",$E00,lowcodeend
	endif

	clear start,end
*/

;	org notower
;	ins 'towers\notower_shifted.fnt'
	;ins 'towers\towers_shifted.fnt'
temp	dta 0
notower	ins 'towers\notower_shifted.fnt'

towermask	
.rept 3
:8	dta $f0
:16	dta $00
:8	dta $0f
.endr



inflate_data ;	.ds 764 ;inflate buffer
:764	dta 0

;up,right,down,left - tower neighboring data (2 directions 0-f in single byte)
neighbors1	
	dta $02,$51
	dta $10,$33
	dta $24,$40
	dta $15,$63
	dta $24,$75
	dta $04,$93
	dta $35,$88
	dta $4a,$a5
	dta $69,$88
	dta $5a,$98
	dta $7a,$a9

neighbors2
	dta $01,$32
	dta $14,$50
	dta $00,$62
	dta $05,$86
	dta $17,$95
	dta $14,$83
	dta $23,$86
	dta $47,$94
	dta $39,$86
	dta $47,$98
	
neighbors3
	dta $02,$31
	dta $03,$44
	dta $02,$53
	dta $05,$66
	dta $16,$77
	dta $22,$83
	dta $33,$74
	dta $48,$77
	dta $55,$87
	
neighbors4
	dta $01,$42
	dta $13,$50
	dta $20,$44
	dta $35,$51
	dta $25,$64
	dta $35,$74
	dta $47,$64
	dta $55,$76
	
neighbor_ptrs
.rept 4,#+1
	dta a(neighbors:1)	
.endr	

;add starting level option to game menu
.proc	add_starting_level
	ldx #0
@	lda txt,x 
	bmi x1
	sta title_static+16*32+8,x
	inx
	bne @-
x1	lda starting_level
	ora #$10
	sta title_static+16*32+8+1,x
	mva #2 update_selection.max
	rts
txt	dta d"Starting Level",$ff
.endp

;loop through available starting level values
.proc	change_starting_level
	lda starting_level
	cmp unlocked_level
	beq x1
	inc starting_level
x2	add_starting_level
	rts
x1	mva #1 starting_level
	jmp x2
.endp

;highlight selected option in menu
.proc	update_selection
	ldx max
loop	txa
	asl @
	tay
	mwa colrs,y ptr
	cpx title_screen.selected
	bne x1
	lda c_0:#$12
	bne x2 ;shorter than jmp
x1	lda c_1:#$50
x2	sta title_screen.tclr0
ptr	equ *-2
	dex
	bpl loop
p5	pause 5
	jmp title_screen.control_loop
max	dta 1
colrs
:3	dta a(title_screen.tclr:1)

.endp

.print	"end of maincode: ",*,"  free bytes:",gamevram-*
	guard gamevram ;do not allow code reaching the videoram area

	org code2
notower2	ins 'towers\notower.fnt'
towers	ins 'towers\towers_shifted.fnt' ;4x3 chars	
towers2	ins 'towers\towers.fnt'  ;3x3 chars




spritelowtable
  ;for x,0,nosprites-1
  ;for y,0,3
  
.rept nosprites
?x=#
.rept 8 ;4
?y=#
  dta [sprites+14*?y*2+?x*spritesiz] % 256
  ;next
  ;next
.endr
.endr

  ;for x,0,3
  ;for y,0,3
.rept 4
?x=#
.rept 8 ;4
?y=#
  dta [expl+14*?y*2+?x*spritesiz] % 256
  ;next
  ;next
.endr
.endr

spritehightable
  ;for x,0,nosprites-1
  ;for y,0,3
.rept nosprites
?x=#
.rept 8 ;4
?y=#
  dta [sprites+14*?y*2+?x*spritesiz] / 256
  ;next
  ;next
.endr
.endr
  
  ;for x,0,3
  ;for y,0,3
.rept 4
?x=#
.rept 8 ;4
?y=#
  dta [expl+14*?y*2+?x*spritesiz] / 256
  ;next
  ;next
.endr
.endr

squaretable
  ;for s,0,15
.rept 16
?s=#
  dta ?s*?s
  ;next
.endr

;inplace sprite preshift	
.proc     sprite_shift
          ldy #sprows-1
x1        lda data,y
          lsr @
          sta data,y
          lda data+sprows,y
          ror @
          sta data+sprows,y
          lda rem2,y
          ror @
          sta rem2,y
          dey
          bpl x1
          rts

data      
:sprows*2 dta 0
rem2
:sprows	dta 0
rem1
:sprows	dta 0

.endp

.proc	sprite_rem21copy
     	ldx #sprows-1
x1     	mva sprite_shift.rem2,x sprite_shift.rem1,x
     	dex
     	bpl x1
	rts
.endp

.proc	preshift_explosion_sprites
	mva #3 tmp
x3	lda tmp
	asl @
	tax
	
	lda expl_address_table,x
	sta w1
	lda expl_address_table+1,x
	sta w1+1
	mwa #temppage w2
	
	ldy #sprows*2-1
x1	mva (w1),y (w2),y
	mva #0 sprite_shift.rem2,y
	dey
	bpl x1	
	
	sprite_preshift
	
	lda tmp
	add #4	; skip loaded enemy sprites
:3	asl @     ; Multiply location by 8 for table
	tax 
	lda spritelowtable,x ;incorrect
	sta w1
	lda spritehightable,x
	sta w1+1
	
	ldy #spritesiz
x2	mva temppage,y (w1),y
	dey
	bne x2
	dec tmp
	bpl x3
	
	rts
tmp	dta 0
expl_address_table
.rept 4,#
	dta a(allsprites+sprows*2*:1)
.endr
.endp

;main procedure which does all the preshifting of 1 sprite
.proc     sprite_preshift
	mwa #[temppage+sprows*2] w1	;target
          
          ldx #sprows*2-1
x1        lda temppage,x      ;source
	;and #%10111010
	;asl @
	;ora sprites,x
ptr	equ *-1
          sta sprite_shift.data,x
          
	;lda ptr
          ;eor #$ff
          ;sta ptr
          
	dex
          bpl x1

	sprite_shift
	ldx #5	;note that x-register is not used in sprite_storeshift nor sprite_shift 
x2	sprite_storeshift          
          sprite_shift
	dex
	bne x2

          sprite_rem21copy
          sprite_storeshift          
          sprite_shift
          sprite_storeshift          
	sprite_storerem21
          rts
.endp

.proc	sprite_storerem21
     	ldy #sprows*2-1
x1    	lda sprite_shift.rem2,y
     	sta (w1),y
     	dey
     	bpl x1
	rts
.endp

.proc	sprite_storeshift
     	ldy #sprows*2-1
x1     	lda sprite_shift.data,y
     	sta (w1),y
     	dey
     	bpl x1
     	
     	add16 #sprows*2 w1
	rts
.endp

/*	
.proc	sprite_test
	
	mva #3 temp
xloop33	ldy #enemyno-1
	lda temp
	sta etype,Y
	sty $8d
	
	lda #20
	sta sx
	;lda #20
	sta sy
	jsr plotter
	;pause 50
	inc temp
	lda temp
	cmp #5
	bne xloop33
	

	mva #240 temp
loop_x	mva #10 sy
	mva temp sx

	ldy #enemyno-1
	;enemytypes
	;1..4 - enemies
	;5,6,7 - explosion
	
	;+32 - dying enemies
	
	lda #$01+32
	sta etype,y
	sty $8d

	jsr plotter
	dec temp
	pause 2
;	waittostart
	lda temp
	cmp #0
	bne loop_x

.rept 10,#
	lda #$01 
	ldy #enemyno-1
	sta etype,Y
	sty $8d
	lda #28+:1
	sta sx
	lda #8+:1*20
	sta sy
	jsr plotter
	
	;show hit ones as well
	lda #$01+32 
	ldy #enemyno-1
	sta etype,Y
	sty $8d
	lda #28+:1+32
	sta sx
	lda #8+:1*20
	sta sy
	jsr plotter

	pause 50
.endr
	jmp *
	rts
.endp


;wait until start button is pressed and released
.proc	waittostart
x1     	lda consol
     	cmp #6
     	bne x1
x2     	lda consol
     	cmp #6
     	beq x2
	rts
.endp
*/

.proc	level_pmg
	;mva #1+16 prior
	lda #3
:4	sta sizep0+:1
:4	mva #64+:1*32 hposp0+:1
	mva #32+1+12+16 dmactl
	mva #$03 gractl
	mva >mypmbase pmbase
	
:2	mva #196-:1*2 hposm0+:1	;missile positions
:2	mva #60-:1*2 hposm0+2+:1
	
	pmg_status
	;set_status0
	
	;inflate pmg overlay
	/*mwa #[datareloc.p1-datareloc.loadarea+datareloc.moveto] inflater.inputPointer
	mwa #mypmbase inflater.outputPointer
	jsr inflater.inflate
	
	*/
	rts
.endp

;redraw pmg status
.proc	pmg_status
shift	equ 0
	
	;left column
	mva #$f0 missile_drawchar.mask
	mva #$0f missile_drawchar.mask2

	;stats
	mva #18 tmp
	ldy #16+shift
x5	missile_drawchar
	inc tmp
	lda tmp
	cmp #22
	bne x5
	
	lda #10 ;L
	ldy #56+shift
	missile_drawchar
	
	ldy #56+1*8+shift
	lda #2
	missile_drawchar
	lda #0
	missile_drawchar 
	
	lda #11 ;G
	ldy #56+5*8+shift
	missile_drawchar
	
	/*mva #6 tmp
	ldy #56+(6)*8+shift
x2	lda #0
	missile_drawchar
	dec tmp
	bne x2 */
	jsr printgold

	lda #12 ;S
	ldy #56+(6+6+2)*8+shift
	missile_drawchar

	/*mva #8 tmp
	ldy #56+(6+6+3)*8+shift
x3	lda #0
	missile_drawchar
	dec tmp
	bne x3
	*/
	jsr printscore

	;right column
	mva #$f0 missile_drawchar.mask2
	mva #$0f missile_drawchar.mask

	;enemy
	mva #14 tmp
	ldy #16+shift
x4	missile_drawchar
	inc tmp
	lda tmp
	cmp #18
	bne x4

	lda #13 ;H
	ldy #32+6*8
	missile_drawchar
	
	lda #0
	missile_drawchar
	lda #0
	missile_drawchar
	
	lda #12 ;S
	ldy #32+11*8
	missile_drawchar
	
	lda #0
	missile_drawchar
	lda #0
	missile_drawchar
	
	lda #10 ;L
	ldy #32+16*8
	
	missile_drawchar
	
	lda #0
	missile_drawchar
	lda #0
	missile_drawchar
	rts

init	dta 0
tmp	dta 0
.endp

msldata	ins 'status_missiles.fnt',0,23*8


;a = index of char
;y = position
;mask = #$f0 or #$0f (left, right)
;mask2 = inverse to mask1
.proc	missile_drawchar
	asl @
	asl @
	asl @
	tax
	mva #8 count
x1	lda msldata,x
	and #$f0
mask	equ *-1
	sta b1
	lda mypmbase-$100,y
	and #$0f
mask2	equ *-1
	ora b1
	sta mypmbase-$100,y
	inx
	iny
	dec count
	bne x1
	
	rts
count	dta 0
.endp

;store pm data under statusbars and fill the statusbar data
.proc	store_pmg
	ldx sbarvisib
	dex
	lda bars,x
	add #32
	tax
	ldy #32
x1	
.rept 4,#
	lda mypmbase+:1*$100,x
	sta temppage+:1*32,y
	lda #0
	sta mypmbase+:1*$100,x
.endr	
	dex
	dey
	bne x1
	rts
	
bars	dta 45,173 ;pmg positions of top&bottom statusbar
	
.endp

;revert statusbar data
.proc	revert_pmg
          ldx sbarvisib
	dex
	bmi x0	;if not visible, do not revert
	lda store_pmg.bars,x
	add #32
	tax
	ldy #32
x1	
.rept 4,#
	lda temppage+:1*32,y
	sta mypmbase+:1*$100,x
.endr	
	dex
	dey
	bne x1
x0     	rts
.endp

;draw number with atari font
.proc	numberplot_atari

	tya	;store Y - to be compatible with orig.numberplot
	pha
	;calculate target
	lda >gamevram
	add $77 ;y
	sta w1+1
	lda $70 ;x*2
:2	asl @
	sta w1
	
	;print high digit
	ldy #0
	lda ($74),y
;:4	lsr @ ;remove low digit
;:3	asl @ ;*8
	sta b1
	and #$f0
	lsr @
	add #7
	tax
	
	ldy #7
x1	lda atrnfont,x
	sta (w1),y
	dex
	dey
	bpl x1
	
	lda b1
	and #$0f
:3	asl @	;get low digit
	add #7
	tax
	
	add16 #8 w1
	
	ldy #7
x2	lda atrnfont,x
	sta (w1),y
	dex
	dey
	bpl x2
	
	pla	;restore Y from the beginning
	tay
	rts
.endp

;prot 1 character 
;x = contains char*8 from numbers_atari
.proc	charplot_atari

	tya
	pha
	;calculate target
	lda >gamevram
	add $77 ;y
	sta w1+1
	lda $70 ;x*2
:2	asl @
	sta w1
	
	ldy #7
x1	lda atrnfont,x
	sta (w1),y
	dex
	dey
	bpl x1
	
	pla
	tay
	rts
.endp

;apply toggle modifier
.proc	handle_joystick
	lda porta
	cmp old
	bne x1
	mva #$0f stick ;simulate no direction

x2	lda trig0
	cmp old+1
	bne x3
	mva #$01 trig ;simulate no fire
	lda trig0
	bne x0
	lda repeat
	a_ge #20 x4 ;fastloop
	inc repeat
	rts
	
x1	sta old	;set direction
	sta stick
	jmp x2
	
x3	sta old+1 ;fire pressed/released
	sta trig
x0	mva #0 repeat
	sta fastloop
	rts
	
x4	mva #1 fastloop
	rts
	
old	dta 0,0
repeat	dta 0
.endp

;modified plottower procedure for non-shifted towers
.proc	draw_3x3_tower

  ; move the location of hte tower sprite data into $72,$73  
	lda ttype,X   ; Get the tower type
	lsr @         ; shift it to the right once
	and #%11111110 ;Clear the bottom bit
	tax
	lda towerlocations2,X
  ;lda #towers mod 256
	sta $72
	inx
	lda towerlocations2,X
  ;lda #towers div 256
	sta $73
  ; Now draw the damn thing!
	ldx #3         ; 3 rows
	
	;3x3 tower delta offset compared to 4x3
	lda $70
	add #4
	sta $70
	lda #0
	adc $71
	sta $71
	
towerrowloop
	ldy #23 

towerdrawloop
	lda ($72),y	
	sta ($70),Y    ; draw sprite
	dey
	bpl towerdrawloop
	lda $71 
	clc
	adc #1
	
	sta $71
	lda $72       ; increase offset into sprite
	adc #24 
	sta $72
	lda $73       ; Add the carry as necessary
	adc #0
	sta $73
	
	dex
	bne towerrowloop
	
	decrement_gold ;buy tower

	; Now draw dots under tower for level $70,$71 points at row beneath first tower
	inc $70
			; Allow a pixel difference
	;add dot offset
	lda ttype,X
	beq nodotstodraw	; Don't draw dots for no tower
	and #3			; Find out tower level
	beq nodotstodraw		; Don't draw dots for level zero
	sec
	sbc #1		; Subtract 1 to give 0-2 index.
	asl @
	asl @
	asl @
	tay			; Store in index.

	; draw dot. 
	lda #%11000001 
	and ($70),y
	sta ($70),y
	iny
	sta ($70),y

nodotstodraw
	rts
xstore	dta 0	
.endp

.proc	decrement_gold ;buy tower
	; Decrement the gold amount?
	ldx draw_3x3_tower.xstore
	ldy ttype,X   ; Get the tower type
	lda towercosts,Y        ; Get the gold cost - this is /10
	asl @
	asl @
	asl @
	asl @ ; Multiply by 10 *BCD
	sta $72                 ; Save for later
	sed
	lda gold+2
	sec
	sbc $72
	sta gold+2
	lda gold+1
	sbc #0
	sta gold+1
	lda gold
	sbc #0         ; subtract from gold - might be better way
	sta gold
	lda towercosts,Y
	lsr @
	lsr @
	lsr @
	lsr @ ; Divide by 10
	sta $72
	lda gold+1
	sec
	sbc $72
	sta gold+1
	lda gold
	sbc #0
	sta gold                ; subtract rest of value
	cld
	rts
.endp

;alternate frame (cursor) drawing routine
.local	oddframe
draw
	lda $70
	add #4
	sta $70
	lda #0
	add:sta $71
	
	ldy #4
boxtopleft
	lda #%11000000
	eor ($70),Y
	sta ($70),Y
	dey
	bne boxtopleft
	lda #%11110000
	eor ($70),Y
	sta ($70),Y
	iny
	lda #%00110000
	eor ($70),Y
	sta ($70),Y
	; Bottom left
	lda $71
	clc
	adc #2
	sta $71	
	ldy #3		
boxbotleft
	lda #%11000000
	eor ($70),Y
	sta ($70),Y
	iny
	cpy #6
	bne boxbotleft
	lda #%11110000
	eor ($70),Y
	sta ($70),Y
	iny
	lda #%11110000
	eor ($70),Y
	sta ($70),Y
	; bottom right
	clc
	lda $70
	adc #8*2
	sta $70
	lda #0
	adc $71
	sta $71

	ldy #3		
boxbotright
	lda #%00000011
	eor ($70),Y
	sta ($70),Y
	iny
	cpy #6
	bne boxbotright
	lda #%00001111
	eor ($70),Y
	sta ($70),Y
	iny
	lda #%00001111
	eor ($70),Y
	sta ($70),Y
	;Top Right
	lda $71
	sec
	sbc #2
	sta $71
	ldy #4		
boxtopright
	lda #%00000011
	eor ($70),Y
	sta ($70),Y
	dey
	bne boxtopright
	lda #%00001111
	eor ($70),Y
	sta ($70),Y
	iny 
	lda #%00001100
	eor ($70),Y
	sta ($70),Y
	jmp tbc3 ;return back
.endl


.local	inflater
;inflate_data defined at the beginning of this file
;inflate_zp defined at the beginning of this file
	icl "inflate.asm"
.endl

atrnfont	ins "scoreboard/numbers_atari.fnt",0,14*8

.proc	splash_screen
	;mwa #title_screen.packed_music inflater.inputPointer
	;mwa #music-6 inflater.outputPointer ;-6 => "skipping" the header
	;jsr inflater.inflate
	;$1000->$14ff
	;$5b00->$5fxx (old)
	
	ldx #<music
	ldy #>music
	lda #0
	jsr rmt.rmt_init	;initialize the music	
	
	jsr g2fsplash.main
	jsr rmt.rmt_silence
	mva #0 559 ;black screen
	rts
.endp

.proc	title_screen
	;hide pmgs (when back from game)
	
	mva #$00 nmien		
	sta gractl ;PMG disabled
	ldx #7
@	sta hposp0,x
	dex
	bpl @-
	color.black
	
	
	;inflate the title screen stuff
	mwa #packed_text inflater.inputPointer
	mwa #title_scroll inflater.outputPointer
	jsr inflater.inflate
	;$4000->$53xx
	
	mwa #packed_titlefont inflater.inputPointer
	mwa #titlefont inflater.outputPointer
	jsr inflater.inflate
	;$5400->$5800
	
	calculate_score	
	jmp g2ftitle.main
/*
dlcont	dta $80
	dta $42+32
tcptr	dta a(title_scroll)
:12	dta 2+32
:3	dta 2+32+$80
:4	dta 2+32
	dta 2+$80,$42,a(title_scroll)
	;dta $44,a(title_logo+96)
	dta $41,a(g2ftitle.ant)
*/
;logic after title logo is displayed
continue	
	;static screen
	mwa #title_static g2ftitle.tcptr
	mva #0 vscrol
c_13	mva #$50 tclr0
c_14	mva #$12 tclr1
	mva #1 selected
	
	lda unlocked_level
	beq control_loop
	add_starting_level
	
control_loop
	handle_joystick
	getkeypressed
	
	cmp #"w"
	beq moveup
	cmp #45 ;"-"
	beq moveup
	cmp #"s"
	beq movedown
	cmp #61 ;"="
	beq movedown
	cmp #";"* ;return
	beq execute
	;joystick
	lda #$01
	bit stick
	beq moveup
	asl @
	bit stick
	beq movedown
	lda trig
	beq execute
	;consol
	lda consol
	cmp #$06
	beq execute
	cmp #$05
	beq alter
	jmp control_loop

moveup	
	lda selected
	bne @+
pause5	jmp update_selection.p5
@	dec selected
	jmp update_selection

movedown	
	lda selected
	cmp update_selection.max
	beq pause5
	inc selected
	jmp update_selection
	
alter	pause 10
	lda selected
	cmp update_selection.max
	bne movedown
	mva #$ff selected
	bne movedown	;shorter than jmp

execute
	pause 10
	lda selected
	cmp #2
	bne @+
	change_starting_level
	jmp control_loop
	
@
c_15	mva #$50 tclr0
	sta tclr1
	sta tclr2
	lda selected
	beq run_scroll
	
	;start game
	pause 1
	mva #0 nmien
	;sta dmactl
	jsr rmt.rmt_silence
	PitchBlack
	rts

run_scroll

	mwa #title_scroll g2ftitle.tcptr	
	mva #127 counter
	
xx3	ldx #0
	;jmp *
xx1	stx vscrol
	stx scroltmp
	getkeypressed
	cmp #";" ;esc
	jeq continue
	spacepressed
	bne xx2
	lda trig0 ;fire
	beq xx2
	pause 6
xx2	pause 2
	ldx scroltmp
	inx
	cpx #8
	bne xx1
	add16 #32 g2ftitle.tcptr
	
	dec counter	;scroll 15 lines
	bne xx3
	jmp continue
	
counter	dta 0
selected	dta 0
scroltmp	dta 0

;for title screen
.proc	calculate_score
	ldx #0
	ldy #0
x1	lda score,x
	and #$f0
:4	lsr @
	sta last_score,y
	iny
	lda score,x
	and #$0f
	sta last_score,y
	iny
	inx
	cpx #4
	bne x1
	
	;calculate enemies killed percentage
	lda #0
:6	sta enem_killed_bcd+:1	;clear ekp,clear prp
	
	lda enemieskilled
	bne x21
	lda enemieskilled+1
	beq x00 ;0 killed enemies, do not count	

x21	clc
	ldx #3
	sed
x31	lda enem_killed_bcd,x
	adc num,x
	sta enem_killed_bcd,x	
	dex
	bpl x31
	
	cld
	
	dec enemieskilled
	lda enemieskilled
	bne x21
	dec enemieskilled+1
	lda enemieskilled+1
	bpl x21
	
	;calculate progress percentage
	ldx level
	dex
	txa
	and #$0f
	sta tmp
	asl @
	asl @
	add tmp
	sta tmp	;tmp = (zero_based)level*5
	ldx wave
	dex
	txa
	and #$0f
	add tmp
	sta tmp	;tmp = (zb)level*5+(zb)wave
	beq x00   ;tmp == 0 -> go out
	tay
	
	sed ;start decimal mode
x51	clc
	ldx #1
	lda progress_bcd,x
	adc #$05
	sta progress_bcd,x
	dex
	lda progress_bcd,x
	adc #$00
	sta progress_bcd,x
	
	dey
	bne x51
	cld ;close decimal mode
x00
	;compare score with high
	ldx #0
x4	lda last_score,x
	a_lt high_score,x x2
	beq x3
	;save high score
x5	mva last_score,x high_score,x
	inx
	cpx #8
	bne x5
	;save also progress and enemkilled
	ldx #5
x8	mva enem_killed_bcd,x enem_killed_bcd_hi,x
	dex
	bpl x8
	jmp x2
	
x3	;next digit
	inx
	cpx #8
	beq x2
	jmp x4
	;NO new high score or continue

x2	ldx #7
x6	lda last_score,x
	ora #$10
	sta title_static+7*32+19,x
	
	lda high_score,x
	ora #$10
	sta title_static+2*32+19,x
	
	dex
	bpl x6
	
	;write progress
	mwa #progress_bcd w1
	mwa #title_static+9*32+19 w2
	write_progress
	mwa #progress_bcd_hi w1
	mwa #title_static+4*32+19 w2
	write_progress	
	
	;write enemies killed percentage
	mwa #enem_killed_bcd w1
	mwa #title_static+8*32+19 w2
	write_enem_killed
	
	mwa #enem_killed_bcd_hi w1
	mwa #title_static+3*32+19 w2
	write_enem_killed
	rts
		
last_score	dta 0,0,0,0,0,0,0,0
high_score	dta 0,0,0,0,0,0,0,0
enem_killed_bcd	dta 0,0,0,0
progress_bcd	dta 0,0
enem_killed_bcd_hi	dta $00,$00,$00,$00
progress_bcd_hi	dta 0,0
num		dta $00,$00,$10,$63  ; (1/941 * 1000000)
tmp		dta 0
.endp

;expects w1=source BCD, w2=target vram
.proc	write_progress
	ldy #0
	lda (w1),y
	beq x1 ;its less than 100
	mva #$11 (w2),y
	iny
	mva #$10 (w2),y
	jmp x4 ;jump to last digit
	
x1	inw w1
	lda (w1),y
:4	lsr @
	bne x2
	;its zero
	dew w2
	jmp x3
x2	ora #$10
	sta (w2),y
x3	lda (w1),y
	and #$0f
	ora #$10
x4	iny
	sta (w2),y
	iny
	lda #"%"
	sta (w2),y
	rts
.endp

;expects w1=bcd source, w2=vram
.proc	write_enem_killed
	ldy #0
	lda (w1),y
	bne x1 ;its 100,00%
	
	inw w1
	lda (w1),y
:4	lsr @	;tens
	beq x3
	ora #$10
	sta (w2),y
	inw w2	
x3	lda (w1),y
	and #$0f	;ones
	ora #$10
	sta (w2),y
	inw w2
	mva #"." (w2),y
	inw w2
	inw w1
	lda (w1),y
:4	lsr @	;tenths
	ora #$10
	sta (w2),y
	lda (w1),y
	and #$0f	;hundreth
	ora #$10
	iny
	sta (w2),y
	lda #"%"
	iny
	sta (w2),y
	rts
	;100,00%	
x1	ldy #6
x2	mva sto,y (w2),y
	dey
	bpl x2
	rts
sto	dta "100.00%"
.endp
;dli under g2f	
dlix1	pha
	
	mva #1+12+32 dmactl ;narrow
	mva #>titlefont chbase
	sta wsync
c_0	mva #$54 colpf0+2 	;text background
c_1	mva #$04 colpf0+1 	;text luminance
	sta wsync
c_2	mva #$52 colpf0+2 	
c_3	mva #$02 colpf0+1 	
	sta wsync
c_4	mva #$50 colpf0+2 	
c_5	mva #$00 colpf0+1 
	sta wsync
c_6	mva #$0c colpf0+1 
	mwa #dlixa0 g2ftitle.NMI.dliv
	
	phr
	lda palsystem
	beq play
	;ntsc part
	inc ntsctimer
	lda ntsctimer
	cmp #6
	bne play
	mva #0 ntsctimer
	jmp quit
	
play	;mva #$0f colpf0+4
	jsr rmt.rmt_play
	;mva #$00 colpf0+4
quit
	plr
	
	pla
	rti
	


.rept 4,#,#+1
dlixa:1	pha
	sta wsync
	lda #$50 
tclr:1	equ *-1	
	sta colpf0+2
	
	ift :1 < 3
	mwa #dlixa:2 g2ftitle.NMI.dliv
	els
	mwa #dlix2 g2ftitle.NMI.dliv
	eif
	
	pla
	rti	
.endr

dlix2	pha
	sta wsync
c_7	mva #$50 colpf0+2 	 
	sta wsync
c_8	mva #$52 colpf0+2 	
c_9	mva #$02 colpf0+1 	
	sta wsync
c_10	mva #$54 colpf0+2 	;text background
c_11	mva #$04 colpf0+1 	;text luminance
	sta wsync
c_12	mva #$00 colpf0+2
	sta colpf0+1
	pla
	rti
	
packed_text
	ins "title\scrolltext.xex.deflate"
packed_titlefont
	ins "title\title.fnt.deflate"
.endp


;sound effects	
.local	sfx

.proc	next_level
	mva #0 channel
	lda #$f0					;initial value
	sta rmt.RMTSFXVOLUME	
	;sfx note volume * 16 (0,16,32,...,240)
	lda #$00
	jmp init
.endp
.proc	level_complete
	mva #0 channel
	lda #$0b
	jmp init
.endp
.proc	next_phase
	mva #0 channel
	lda #$03
	jmp init
.endp
.proc	victory
	lda #$06
	jmp init
.endp
.proc	defeat
	lda #$08
	jmp init
.endp

ERRSND	equ $01*2
CURSOR	equ $08*2
TOWER_UPG	equ $09*2
TOWER_BLD	equ $0a*2
FIRESND	equ $0b*2
ENEMY_KIL	equ $0c*2
ENEMY_RCH equ $0d*2

;expects Y=instrument(*2)
.proc	do
	turn_channel		;X = 3	channel (0..3 or 0..7 for stereo module)
	lda #12			;A = 12	note (0..60)
	jmp rmt.rmt_sfx	 	;RMT_SFX start tone (It works only if FEAT_SFX is enabled !!!)
x0	rts
	
.endp

.proc	fire
	ldy #FIRESND
	lda firesoundtype
	and #%00001100
	asl @
	asl @
	beq do.x0
	turn_channel
	jmp rmt.rmt_sfx
.endp

.proc	turn_channel
	dec channel
	bpl x1
	mvx #3 channel
x1	ldx channel
	rts
.endp

init	ldx #<music2
	ldy #>music2
	jmp rmt.rmt_init
	
channel	dta 0
.endl

.proc	music_init
	ldx #<music
	ldy #>music
	lda #0
	jsr rmt.rmt_init	;initialize the music
	rts
.endp

;tower neighboring matrix for controls - for current level
neighbors	.ds 32



/*
Score + progress
sc	score=&3012
wa	wave=sc+4
le	level=sc+5
ek	enemieskilled=sc+6

at=sc+8

lc%=((?le) AND 15)-1
lc%=lc%*5+((?wa-1) AND 15)
lc%=(lc%*100)/20
ekp=?ek+(ek?1)*256
ekp=ekp*100/941

"�Progress : "+STR$(lc%)+"%",17)
"�Enemies killed : "+STR$(ekp)+"%",16)

enemies killed percent = 1063*ek;


*/

.print "space before vram: ",vram-*
	guard $7e00 ;vram start
	
.align $100
vram
:128	dta #

dl	dta $50
	dta $c2,a(vram),2,2,$82
:2	dta $42,a(vram),2,2,$82
	dta $42,a(vram),$82,2,$82
:3	dta $42,a(vram),2,2,$82
;:6	dta $42,a(vram),2,2,$82
	dta $42,a(vram)
	dta $41,a(dl)


NMI	bit nmist
	bpl nmi_vbi	;vbi
	jmp (dli_ptr)	;dli
nmi_vbi	jmp (vbi_ptr)

	.align $100

.local	rmt
PLAYER	equ *+$400
	icl "msx\rmtplayr.a65"
.endl


;these blocks are splash screen - could be rewritten after game starts
g2fsplash_org
.local	g2fsplash
	icl "title\splash\splash_adjusted.asm"
.print	"end of code2: ",*," free bytes(not sure):",music2-*
	
	guard $9600
	org $9600
splashlogoscr
	ins "title\splash\splash.scr"
	
	guard $9b00
	org $9b00
splashlogopmg
	ins "title\splash\splash.pmg"
	guard music
	
	;$ab00 guard deflated data
	guard datareloc.moveto2 	
	;5047 is the size of deflated font
	org gamevram+$2800-5000 ;i left 47 bytes out of overlap
fontpack	ins "title\splash\splash.fnt.deflate"
.endl

music	equ $a071 ;to $a528	
music2	equ $9600 ;to $9cbc   - inflated during game init
	
	org music
	ins "msx\menu_stripped_a071.rmt",+6	;until $a528
	
ingamemusic ;deflated
	ins "msx\game_stripped_9600.rmt.deflate" ;until $a8b5

	guard datareloc.moveto2 ;ab00
	
	ini splash_screen
	
	;part that rewrites the splashscreen with title screen
	org g2fsplash_org
g2ftitle_org

.local	g2ftitle
	icl "title\cd_title\cd_title_adjusted.asm"
.endl







