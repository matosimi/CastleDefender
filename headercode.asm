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
;expl = sprites-(spritesize*4)     ; Location of second explosion 
;atari replace {
;tempsprite=$3000-40
tempsprite	equ $1000
; }
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

	org typos ;level data
	ins 'levels\L1data.bin'
	;ins 'levels\L2data.bin'

	org gamevram
;:7600	dta 255 ;white background	
	ins 'levels\L1.fnt'
	;ins 'levels\L2.fnt'
:256	dta 0
	ins 'scoreboard\scoreboard.fnt'
	
	org $a000 ;sprites
allsprites	;4*explosions, 19*enemies
	ins 'sprites\allsprites.fnt'

/*
.rept 8,#+1
spr:1	ins 'sprites\S:1.fnt'
.endr	
.rept 4,#+1
exp:1	ins 'sprites\E:1.fnt'
.endr
*/
expl	;4*spritesize


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
fcnewright
:8	dta 0
fcoldright
:8	dta 0

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
	dta $00,$00,$00,$00
enemystrengths		;BCD
	dta $00,$00,$00,$00
enemyshields		;BCD
	dta $00,$00,$00,$00
enemyspeed
	dta 0		         ; distance between enemies in frames
	dta 0
spritenumbers  ; Types of enemy
	dta $00,$00,$00,$00          ;string with 4 numbers 
/*atari remove
spritecolours
	dta 0,0,0
	dta 0,0,0
	dta 0,0,0
	dta 0,0,0
*/
numberofenemies
	dta 0
etype			; Enemy type list - reserve bytes
:enemyno	dta 0 ;SKIP enemyno
wavedataend
varend	

	org wavedata ;wave file   - TODO: this will eventually be inflated 
	;ins 'waves\L1W1.bin'
	ins 'waves\L1W3.bin'
	
