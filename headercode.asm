; Set up some variables
;atari replace {
;spritesize = 4*14*4   ; Size of sprites in bytes
spritesize = 14*18 ;252
; }
enemyno = 64          ; Number of enemies in a wave
towrno = 16           ; Maximum number of towers
;sgsize = 32*28        ; Size of screen grid
nosprites = 4         ; Number of different sprites
path = $3900          ; Location of path
;screengrid = path-sgsize      ; Location of screen gridpal1
txpos = path-towrno          ; Location of tower x pos table
typos = txpos-towrno          ; Location of tower y pos table
ehealth = typos-enemyno  ; Location of enemy health table
eshield = ehealth-enemyno     ; Location of enemy shield table
;etype = eshield-enemyno       ; Location of enemy type table - not supersceeded by wave data
ttype = eshield-towrno          ; Location of tower type table
tfcount = ttype-towrno        ; Location of tower fire count table
tftarget = tfcount-towrno     ; Location of tower fire target table
tftargetx = tftarget-towrno   ; Location of tower fire target x position table
tftargety = tftargetx-towrno  ; Location of tower fire target y position table
sprites = tftargety-(nosprites*spritesize)     ; Location sprites will be loaded
expl = sprites-(spritesize*4)     ; Location of second explosion 
tempsprite=$3000-40
activetowers=$3ffe

zspos=$70
zsoff=$78
zt=$80
sx=$81
sy=$80
sprows=14
lastplotidx=$82
lastplot=$83

gamevram	equ $4000

	org expl
	ins 'srcdata\$.Explode'
	
	org expl+(spritesize*3)
	ins 'srcdata\S.1' ;workaround
	
	org typos ;level data+picture background
	ins 'srcdata\L.1',0,$4000-typos

	org gamevram
;:7600	dta 255 ;white background	
	ins 'reverse engineered attempt\L1.fnt',($4000-typos)/2

	;org $9400 ;default font
	;ins 'default.fnt'
	
	org $a000 ;sprites
.rept 8,#+1
spr:1	ins 'sprites\S:1.fnt'
.endr

; debug: only 1 sprite loaded, rest zeros
/*
spr1	ins 'sprites\S1.fnt'
.rept 7, #+2
spr:1	equ $c000
.endr	
*/
	org $3012
;guard expl
score	dta 00,00,00,00	; ,00
wave	dta $a1		; a because it's blank - to be plotted.
level	dta $a1
enemieskilled 
	.word 0

attractmode
	dta 0
lives	dta $00
gold	  dta $00,$00,$99
enemystart	
	dta 0
enemyend
	dta 1
enemytimer
	dta 0
enemyoffset
	.word $3800

lastkeypressed	dta 0

currentlocation	dta 0

leftupdaterequired	dta 0

remaincounter	dta 0

maxlocation=$3ffe
;dta 19

pathendx	dta 0
pathendy	dta 0

enemyatend	dta 0

fcoldl	dta 0,0,0,0,0,0,0,0
fcoldh	dta 0,0,0,0,0,0,0,0
fcnewl	dta 0,0,0,0,0,0,0,0
fcnewh	dta 0,0,0,0,0,0,0,0
fctype	dta 0,0,0,0,0,0,0,0
fcstore	.word 0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0

textcolour	dta $ff

previoustower	dta $ff

cursordisplayed	dta 0
cursorcount	dta 0

gamespeed	dta 0

scoretoadd	dta $00,$00,$00,$00	;,$00

loadfileblock
	dta 0
	dta 0		;Filename pointer
	dta 0
	dta 0	;Load address pointer (4 bytes)
	.word 0
	.word 0,0
	.word 0,0
	.word 0,0

openfile	dta 0

firesoundtype	dta 0

lasthitsprite	dta 0

startdelay	dta 0

wavedata	; Wave data structure?
; Enemy Data
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $03,$05,$07,$09
enemystrengths		;BCD
	dta $50,$40,$30,$20
enemyshields		;BCD
	dta $0,$3,$6,$11
enemyspeed
	dta 30			; distance between enemies in frames
	dta 0
spritenumbers  ; Types of enemy
	dta "1122"
spritecolours
	dta 0,0,0
	dta 0,0,0
	dta 0,0,0
	dta 0,0,0
numberofenemies
	dta 0
etype			; Enemy type list - reserve bytes
:enemyno	dta 0 ;SKIP enemyno
wavedataend
varend	

	org wavedata ;wave file
	ins 'srcdata\W.1',0,wavedataend-wavedata
	
