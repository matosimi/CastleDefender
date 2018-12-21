	; Move code out of $900
	; Create a screen clear at $900
	; Create a clear of the enemy sprites for a level load
	; use vairables for the pallette and timer offsets
	; Create routine to enable/disable blanking of screen (possible include sprite clear...) 
	; clear and then track number of enemies killed
	;Updated wave/level box display time
	;Correct level 3 first tower location
	; changed colour of upgrade dits
	; Reload instead of rate
	; Gold score bug (/10)



	ORG $1b00
;  GUARD $3000-40	; So we can load code without losing it between screen modes.
	icl "headercode.asm"
codeoffset=$0900
.print "Assembling for ",codeoffset

	;38.12

start

	;; Turn sound on/off for attract mode
	ldy #0
	ldx attractmode
	lda #$d2
	jsr $fff4

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
	lda #19
	jsr $fff4
	lda #1
	sta intflag
	; One per Game setup

	jsr loadexplosions

	;Reset score
	lda #0
	sta score
	sta score+1
	sta score+2
	sta score+3
	;:sta score+4

	; Reset enemies killed
	sta enemieskilled
	sta enemieskilled+1

	lda #$a1
	sta wave
	;sta level	; Level set by basic

	; Once per "Screen" setups

newlevel
	jsr clearstatusbox
	jsr showwave

	;load screen (should include screen $ Path $ tower positions)
	jsr loadscreen

	; Clear tower types structures
	ldx #towrno-1
	lda #0

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

	lda attractmode
	bne skipblanktowers		; Don't plot towers in attact mode

	lda #$13
	jsr bongsound

	lda #11
	jsr delay

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

	; Open the wave file
	lda level
	and #15			; Strip top bits used for display
	ora #$30		; add '0' to make this ascii
	sta wavefilenumber
	lda #$40
	ldx #<(wavefilename)
	ldy #>(wavefilename)
	jsr $ffce
	sta openfile

	; Wave base setups setups
newwave
	; Clear sprite row
	jsr deletestatusrows

	lda #15
	sta remaincounter
	lda #$ff
	sta previoustower
	jsr clearstatusbox
	jsr showwave

	; Clear Sprite storage area
	ldx #0
	lda #0
clearspritesloop
	sta sprites,X
	sta sprites+spritesize,X
	sta sprites+spritesize*2,X
	sta sprites+spritesize*3,X
	inx
	cpx #spritesize
	bne clearspritesloop

	;Setup status display
	jsr printgold
	jsr printlives
	jsr printscore

	; Load wave data
	jsr loadwave

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
	lda #$3ffe % 256
	sta $70
	lda #$3ffe / 256
	sta $71
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
	jsr loadspritefile

	lda #<(expl+(spritesize*3))
	sta $70
	lda #>(expl+(spritesize*3))
	sta $71         ; Store where sprites are coped from

	lda $88
	asl @
	asl @     ; Multiply location by 4 for table
	tax             ; Move to X for offset.
	lda spritelowtable,X
	sta $72
	lda spritehightable,x
	sta $73         ; Store where the result needs to be put
	ldy #spritesize-1
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
finishloadsprites


	;draw wave sprites
	lda #1
	ldy #enemyno-1
	sta etype,Y
	sty $8d
	lda #16
	sta sx
	lda #212
	sta sy
	jsr plotter

	inc etype+enemyno-1
	lda #16+64
	sta sx
	lda #212
	sta sy
	jsr plotter

	inc etype+enemyno-1
	lda #16+64+64
	sta sx
	lda #212
	sta sy
	jsr plotter

	inc etype+enemyno-1
	lda #16+64+64+64
	sta sx
	lda #212
	sta sy
	jsr plotter

	;Print enemy health values
	lda #%00001111
	sta textcolour 
	lda #8
	sta $70
	lda #27
	sta $77
	lda #(enemystrengths) % 256
	sta $74
	lda #(enemystrengths) / 256
	sta $75
	ldx #0
	jsr numberplot          

	lda #24
	sta $70
	;lda #27:sta $77
	lda #(enemystrengths+1) % 256
	sta $74
	lda #(enemystrengths+1) / 256
	sta $75
	ldx #0
	jsr numberplot          

	lda #40
	sta $70
	;lda #27:sta $77
	lda #(enemystrengths+2) % 256
	sta $74
	lda #(enemystrengths+2) / 256
	sta $75
	ldx #0
	jsr numberplot          

	lda #56
	sta $70
	;lda #27:sta $77
	lda #(enemystrengths+3) % 256
	sta $74
	lda #(enemystrengths+3) / 256
	sta $75
	ldx #0
	jsr numberplot          

	; Print enemy shield values
	lda #%11111111
	sta textcolour 
	lda #11
	sta $70
	;lda #27:sta $77
	lda #(enemyshields) % 256
	sta $74
	lda #(enemyshields) / 256
	sta $75
	ldx #0
	jsr numberplot          

	lda #27
	sta $70
	;lda #27:sta $77
	lda #(enemyshields+1) % 256
	sta $74
	lda #(enemyshields+1) / 256
	sta $75
	ldx #0
	jsr numberplot          

	lda #43
	sta $70
	;lda #27:sta $77
	lda #(enemyshields+2) % 256
	sta $74
	lda #(enemyshields+2) / 256
	sta $75
	ldx #0
	jsr numberplot          

	lda #59
	sta $70
	;lda #27:sta $77
	lda #(enemyshields+3) % 256
	sta $74
	lda #(enemyshields+3) / 256
	sta $75
	ldx #0
	jsr numberplot          

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

	;jmp gameover       ; this will be removed in normal operation

mainloop             ;Main processing loop
	lDA #0
	sta vsynccount       ; Reset frame counter
	sta leftupdaterequired	; Reset if we need up date the number left
	sTA lastplotidx       ; Reset the last plotted index position
	sTA lastplot          ; Reset the last plotted position
	sta enemyatend        ; index of an enemy that has reached the end

	ldx startdelay		; Pause before we get going
	beq notinstartdelay
	dex
	stx startdelay
	cpx #25
	bne instartdelay
	jsr levelstartsound	; Make start sound	Slightly before start to sync enemies appearing
	jsr forceprinttowerinfo
	jmp instartdelay
	cpx #1		; Are we on the last frame?
	bne instartdelay
	ldx #0
	stx startdelay			; and set delay to zero
notinstartdelay

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
	beq gameover		; If there are zero lives then game over

	lda attractmode
	beq notgameover		; Don't check for a key if we're not in attract mode
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

	;Close wave file
	lda #0
	ldy openfile
	sta openfile
	jsr $ffce

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
	jmp newlevel

gameover
	; We're dead - finish and return.
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

	jsr showloselogo

returntobasic
	lda #0
	sta intflag

	rTS                   ; Return back to basic.

winner
	;We've won.

	jsr showwinlogo
	jmp returntobasic

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
;WE have an end sitiuation - Check if enemy there
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
	jsr loselifesound

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
//  \ USE 8E8F AS PLOT START
//  \ USE 8D AS COUNTER
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
	lda #$20
	sta zspos+1 ; screen offset divided by 2
	lda sx                ; find X coordinate
	and #%11111100        ; Clear bottom bits
	asl @                 ; Multiply by 2 -> 512 bytes/line
	sta zspos
  ;asl zspos               ; Multiply by 2 -> 512 bytes/line
	rol zspos+1               ; Seems much simpler???
	lda sy                ; Get y coordinate
	and #%11111000        ; strip low bits
	lsr @
	lsr @           ; divide by 4 to give line positions
	adc zspos+1               ; Add to high byte
	sta zspos+1
	lda sy
	and #%00000111        ; Get lower bits 
	adc zspos             ; add row offset to low byte
	sta zspos             ; and save
	lda sx
	and #%00000011        ; Get the offset
	sta zt                ; store for later
  
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
	and #%111111
	sta etype,y	; Clear the 64 bit and store for next time
	and #%11111
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
	asl @           ; multiply by 4 (4 bytes accoss)
	aDC zt                ; and add in the horizontal shift
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

	lDY #0                ; Line counter
	lDA zspos             ; get screen position
	aND #7                ; and take bottom 4 bytes for position in nolumn
	sTA zt                ; save for later
	lDA #8                ; work out how many more bytes to plot
	sEC
	sBC zt
	tAX                   ; use as loop counter
spriteloop1          ; plot loop for first block of 8
	lDA(zsoff),Y
	sTA(zspos),Y
	lDA(zsoff+2),Y
	sTA(zspos+2),Y
	lDA(zsoff+4),Y
	sTA(zspos+4),Y
	lDA(zsoff+6),Y
	sTA(zspos+6),Y        ; move sprite data
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
	lDA(zsoff+6),Y
	sTA(zspos+6),Y        ; move sprite data
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
	lDA(zsoff+6),Y
	sTA(zspos+6),Y        ; plot the sprite
	iNY
	cPY #sprows           ;check if we've finished (can never be 8)
	bNE spriteloop3       
spritefinish
	rTS

spmoverow             ; sprite row increment routine zt contains number of rows to subtract
	lDA zspos             ; get screen low 
	aND #$F8              ; clear bottom 8 bits to round to new segment (important for first row - not for second
	sEC
	sBC zt                ; Subtract number of rows that we have already plotted
	sTA zspos             ; save
	lDA zspos+1           ; and move the carry
	sBC #0                ; reduce high byte of required
	aDC #1                ; add row (512 bytes)
	sTA zspos+1           ; save final value
	cLC
;  FOR C,0,4,2           ; copy the start screen and aprite addresses to the following 3 addresses for
.rept	3,#*2
	lDA zspos+:1           ; each of the 4 sprite bytes accross
	aDC #8
	sTA zspos+:1+2
	lDA zspos+:1+1
	aDC #0
	sTA zspos+:1+3
.endr
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
	sta tftargetx,y
	lda sy
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
	sbc #3    ; Find top left
	asl @         ; multiply by 2 (since four pixles per byte)
	asl @ ;:asl @   ; Now multiply by 2 -
	asl @         ; and finish multiplaction to 8 - first time we could wrap
	sta $70       ; Store result
	rol $71       ; Set the bit in top byte if required
	lda typos,X   ; Get y position - this will be 0 - 63 - does not need to be divided to 512 - towers can't be at half positions
	sec
	sbc #3    ; Find top left
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
	txa
	pha         ; Save x for later
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
	ldy #47        ; 24/4*8
towerdrawloop
	lda ($72),Y
	;eor #$ff
	sta ($70),Y    ; draw sprite
	dey
	bpl towerdrawloop
	lda $71 
	clc
	adc #2    ; increase screen row
	sta $71
	lda $72       ; incrase offset into sprite
	adc #48       ; number of bytes just plotted
	sta $72
	lda $73       ; Add the carry as necessary
	adc #0
	sta $73
	dex
	bne towerrowloop

  ; Decrement the gold amount?
	pla
	tax         ; Get x back.
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
	asl @	; Multiply by 16 to give byte offset (each column)
	tay			; Store in index.

	; draw dot. (c3, 3c)
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

nodotstodraw

	jmp printgold		; implied RTS

	;rts

towerfire
  ; Routine to action tower fire list and to update the status of each
	lda #0
	sta firesoundtype
	ldx activetowers ;start at the end and work backwards
towerfireloop
	lda ttype,X   ; Check if tower defined
	beq skiptowerfire     ; skip if not
  ; Don't need to check fire count if we have a target
	ldy tftarget,X ;Do we have a target?
	beq skiptowerfire     ; skip if not
  ; We now have an active tower with a target that's ready to fire - Y is target

  ; load location of screen position to $70,71
	lda #0
	sta $71
	lda tftargetx,X        ; move x coordinate to A
	clc
	adc #7            ; Get middle of target
	and #%11111100        ; Clear bottom bits
	sta $70
	asl $70               ; Multiply by 2 -> 512 bytes/line
	rol $71               ; Seems much simpler???

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
	lsr @           ; divide by 4 to give line positions
	adc $71               ; Add to high byte
	sta $71
  ;lda tftargety,X
  ;adc #7                ; middle
  ;and #%00000100        ; fudge middle approximation
  ;adc $70:sta $70
	lda #$42               ; Add screen offset + 2 to move one pixel down
	adc $71
	sta $71       
  ; Draw "hit"
	stx $74         ; Save X for later
	;       Determine if we have space in the tower table to store the hit data
	ldy #0
findhitspace
	lda fctype,Y
	beq storehit
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
	bpl towerfireloop
	; Play a sound of a firing tower
	jmp firesound


storehit
	lda $70
	sta fcnewl,Y            ; Store location of new plot
	lda $71
	sta fcnewh,Y            ; Store high location of new plot
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
	asl @
	asl @
	asl @   ; A = 0 to 511 + carry
	sta $70
	rol $71               ; Seems much simpler???
	inc $70
	inc $70
	inc $70
	lda $79              ; Get y coordinate (0-63)
	and #%00111110        ; strip low bits
	clc
	adc $71          ; Add to high byte
	sta $71
	lda #$40               ; Add screen offset
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

	ldx $74
	jmp finishfireplot


drawbullets
	;Routine to draw inflight bullets
	ldx #7

bulletloop
	lda fctype,X   ; Check if location is zero
	beq skipbullet  ; skip whole process if it is.
	lda fcoldl,X
	sta $70
	lda fcoldh,X
	sta $71
	lda fcnewl,X
	sta $72
	lda fcnewh,X
	sta $73         ; old and new screen addresses copied.

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
bls4

	ldx $74
	lda #0
	sta fctype,X

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
	jsr explodesound
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

	jsr readshift
	bvc notescape ; Escape pressed - but not shift.
	pla
	pla			; Pull return address off stack
	jmp gameover

readshift
	clv
	clc
	jmp ($228)

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

	jsr upgradesound	; Upgrade Sound
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
	lda $ec
	cmp #98+128		; Is Space being pressed?
	bne nospacepressed	
	lda #0
	sta gamespeed
nospacepressed
	lda lastkeypressed
	beq nokeypressed        ; Check if there was a key pressed last time we were here.
	cmp $ec
	beq keystillpressed     
	cmp $ed
	beq keystillpressed
nokeypressed
	; We're only going to work with the last key pressed (ec)
	lda $ec
	cmp #48+128
	beq press1            ; 1
	cmp #49+128
	beq press2            ; 2
	cmp #17+128
	beq press3            ; 3

	cmp #53+128
	beq upgradetower      ; U pressed - Upgrade

	cmp #112+128
	beq escape		; Escape pressed

	cmp #25+128             ; Left Cursor
	beq moveleft
	cmp #121+128            ; Right cursor
	beq moveright
	cmp #57+128
	beq moveup              ; Up cursor
	cmp #41+128
	beq movedown            ; Down cursor

notescape
	lda $ec
	sta lastkeypressed
	rts                   ; Exit to prevent update of tower information.

moveleft
	jsr movesound
	ldx currentlocation
	jsr erasebox     ; Erase current box
	dex
	bpl knotzero
	ldx maxlocation
knotzero
	stx currentlocation
	jsr plotbox     ; Re-draw box
	jmp finishkeyboard

moveright
	jsr movesound
	ldx currentlocation
	jsr erasebox     ; Erase current box
	inx
	cpx maxlocation
	bcc knotmax
	beq knotmax
	ldx #0
knotmax
	stx currentlocation
	jsr plotbox     ; Re-draw box
	jmp finishkeyboard

moveup
	jsr movesound
	ldx currentlocation
	jsr erasebox     ; Erase current box
	lda txpos,x     ; Get current tower x position.
kfindhigher
	dex
	bpl kmoveupnotzero  ; Move backwards through the towers
	ldx maxlocation
kmoveupnotzero
	cmp txpos,x     ; See if the current location is the same as this one
	bne kfindhigher         ; Loop back if not
	; No need to check total number of loops as we know that the current = current
	stx currentlocation     ; Store the new location
	jsr plotbox
	jmp finishkeyboard

movedown
	jsr movesound
	ldx currentlocation
	jsr erasebox     ; Erase current box
	lda txpos,x     ; Get current tower x position.
kfindlower
	inx
	cpx maxlocation ; move forwards
	bcc kmovedownnotzero
	beq kmovedownnotzero
	ldx #0
kmovedownnotzero
	cmp txpos,x     ; See if the current location is the same as this one
	bne kfindlower         ; Loop back if not
	; No need to check total number of loops as we know that the current = current
	stx currentlocation     ; Store the new location
	jsr plotbox
	jmp finishkeyboard

maketower
	ldx currentlocation
	lda ttype,x
	bne toweralreadyhere      ; Tower already at this location.
	tya
	;asl @:asl @             ; Muliply a by 4 to make tower type
	sta ttype,X             ; Change tower type to be Y
	jsr erasebox             ; Erase box
	jsr buildsound		; Make tower being built sound (will be cancelled if not afforadable)
	jsr plottower           ; Create tower
	ldx currentlocation
	jsr plotbox             ; redraw box

finishkeyboard
	lda $ec
	sta lastkeypressed
	jsr printtowerinfo
	rts

toweralreadyhere
	jsr errorsound
	jmp finishkeyboard

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

explodesound
	txa
	pha
	tya
	pha
	lda #7
	ldx #<(explodesoundparams)
	ldy #>(explodesoundparams)
	jsr $FFF1
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
	jsr $FFF1
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
	jmp $FFF1

movesoundparams
	dta $13,0	; channel (with buffer flush)
	.word -10	; Envelope
	dta 150,0	; Pitch
	dta 1,0	; Duration

errorsound
	lda #7
	ldx #<(errorsoundparams)
	ldy #>(errorsoundparams)
	jmp $FFF1


errorsoundparams
	dta $12,0	; channel (with buffer flush)
	.word -15	; Envelope
	dta 10,0	; Pitch
	dta 8,0	; Duration


loselifesound
	/*
	txa:pha:tya:pha
	lda #$12:ldx #20:ldy #8
	jsr bongsound
	lda #2:ldx #4:ldy #16
	jsr bongsound
	pla:tay:pla:tax
	*/
	rts

sadsound	; Play sadder "string" sound
	/*pha
	lda #4:sta bongparams+2
	*/
	jmp playsound

longsound	; Play a longer "trumpet" sound
	/*pha
	lda #3:sta bongparams+2
	*/
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
	jmp $FFF1


bongparams
	/*dta $10,0	; channel (with buffer flush)
	dta 1,0	; Envelope
	dta 6,0	; Pitch
	dta 15,0	; Duration
	*/
buildsound
	/*pha:tya:pha:txa:pha
	lda #$12:ldx #128:ldy #5
	jsr bongsound
	lda #$02:ldx #164:ldy #5
	jsr bongsound
	lda #$02:ldx #148:ldy #10
	jsr bongsound
	pla:tax:pla:tay:pla
	*/
	rts


upgradesound
	/*pha:tya:pha:txa:pha
	lda #$12:ldx #128:ldy #5
	jsr bongsound
	lda #$02:ldx #164:ldy #10
	jsr bongsound
	pla:tax:pla:tay:pla
	*/
	rts

levelstartsound
	;lda #50
	;jsr delay

	ldx #0
levelstartsoundloop
	/*txa:pha
	ldy levelstartsounddurations,x
	lda levelstartsoundpitches,x
	tax
	lda #1:jsr longsound
	pla:tax
	inx
	cpx #4
	bne levelstartsoundloop

	;lda #125
	;jmp delay		; RTS implies
*/
	rts

levelstartsoundpitches
	dta 80,80,80,100
levelstartsounddurations
	dta 6,3,3,12


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

	dey
	tay
	and #%11                        ; Tower level
	ora #$a0
	sta towertempnum
	lda #29
	sta $77
	jsr printtoweractive            ; print one row of information

	lda #$CD
	sta towertempnum
	lda #19
	sta $70
	ldx #00
	jsr numberplot          ; keyboard         

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
	lda #$ab
	sta towertempnum
	lda #19
	sta $70
	ldx #00
	jsr numberplot          ; keyboard         

	;jmp delrow3

delrow2
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

printtowerbasicsloop

	lda #$a0
	sta towertempnum
	jsr printtoweractive            ; print one row of information

	tya
	lsr @
	lsr @
	ora #$a0
	sta towertempnum
	lda #19
	sta $70
	ldx #00
	jsr numberplot          ; keyboard         

	inc $77
	tya
	clc
	adc #%100
	tay
	cmp #%10000
	bne printtowerbasicsloop

	rts

printtoweractive               ; display one row of active tower info - removed from main loop.
	lda #%00001111
	sta textcolour   ;draw in green
	lda #23
	sta $70
	lda #towertempnum % 256
	sta $74
	lda #towertempnum / 256
	sta $75
	ldx #00
	jsr numberplot          ; plot tower level         

	lda towershield-4,y
	sta towertempnum
	lda #33
	sta $70
	ldx #00
	jsr numberplot          ; plot tower shield damage

	lda towerfiredisplayspeed-4,y
	sta towertempnum
	lda #43
	sta $70
	ldx #00
	jsr numberplot          ; plot tower rate

	lda #%11111111
	sta textcolour   ;draw in yellow
	lda towercosts,y
	sta towertempnum
	lda #48
	sta $70
	ldx #01
	jsr numberplot          ; plot tower cost

	lda #%11110000
	sta textcolour   ; Draw in green
	lda towerphysical-4,y
	sta towertempnum
	lda #28
	sta $70
	ldx #00
	jsr numberplot          ; plot tower physical damage         

	lda towerranges-4,y
	sta towertempnum
	lda #38
	sta $70
	ldx #00
	jmp numberplot          ; plot tower range	rts implied
	;rts/


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
	txa:pha

	lda #$20        
	sta $71       ; clear screen start in high byte
	lda txpos,X   ; a conains value 0-63 ish - assumed to be top left of tower.
	sec
	sbc #3    ; Find top left
	asl @         ; multiply by 2 (since four pixles per byte)
	asl @ ;:asl @   ; Now multiply by 2 -
	asl @         ; and finish multiplaction to 8 - first time we could wrap
	sta $70       ; Store result
	rol $71       ; Set the bit in top byte if required
	lda typos,X   ; Get y position - this will be 0 - 63 - does not need to be divided to 512 - towers can't be at half positions
	sec
	sbc #3    ; Find top left
	;asl @
	clc
	adc $71   ; Add to the x offset high byte 
	sta $71       ; And save $70 and $71 now point to the top left of the tower box

	ldy #4		;#4
boxtopleft
	;lda #%10001000
	lda #%11000000
	eor ($70),Y
	sta ($70),Y
	dey
	bne boxtopleft
	;lda #255
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
	adc #4      ; 2 lines down
	sta $71
	ldy #3		;3
boxbotleft
	;lda #%10001000
	lda #%11000000
	eor ($70),Y
	sta ($70),Y
	iny
	cpy #6
	bne boxbotleft
	;lda #255
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
	adc #8*5        ; Width of towers
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


	;Top Right
	lda $71
	sec
	sbc #4      ; 2 lines up
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


	pla
	tax
	rts

	;Routine to print the levels and waves
showwave ;$28f5

	;Set up for the copy
	lda #<(wavetext) ;$2ce2
	sta $70
	lda #>(wavetext)
	sta $71			; Origin text
	lda #<($8000-256-48-512)
	sta $72
	lda #>($8000-256-48-512)
	sta $73
	ldy #144
showwaveloop
	dey
	lda ($70),y
	sta ($72),y
	cpy #0
	bne showwaveloop

	lda #%00001111
	sta textcolour 
	lda #32
	sta $70
	lda #30
	sta $77
	lda #level % 256
	sta $74
	lda #level / 256
	sta $75
	ldx #0
	jsr numberplot   

	lda #42
	sta $70
	lda #30
	sta $77
	lda #wave % 256
	sta $74
	lda #wave / 256
	sta $75
	ldx #0
	jmp numberplot   
	;rts

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
	sta $4000+512*29+19*8,x
	sta $4000+512*30+19*8,x
	sta $4000+512*31+19*8,x
	bne clearstatusboxloop

	;write the "decenders"
	; $7af0=192 $7b40=192
	lda #192
	sta $7af0
	sta $7b40
	pla
	tax
	pla
	rts


loadwave
	; Uses OSBGET to read byte so we can have multiples waves per file.
	ldy openfile
	ldx #0
loadwaveloop
	jsr $ffd7
	sta wavedata,x
	inx
	cpx #wavedataend-wavedata			; Level data structure size
	bne loadwaveloop
	rts

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
	jsr $ffdd

	rts


	; Colour definitions
	green=%10000
	red=%00001
	cyan=%10001

printscore
	; Routine to print score to screen.
	; Uses number print - so $70-$75 - does not preserve registers
	lda #%00001111
	sta textcolour 
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

printgold
	; Routine to print gold value to screen.
	; Uses number print - so $70-$75 - does not preserve registers
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

showstatus
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


	; Number plot routine.
	; Expects length of number string in X (in bytes) - zero relative
	; .textcolour = and mask for colour
	; $70 and $77 as screen location x=0 to 63, y=0 to 31
	; Also expects number location in $74,$75
	; Uses 70 and 71 as font location and 72 $ 73 as screen location

numberplot
	tya
	pha
	lda textcolour
	sta $76

	txa
	asl @
	adc $70          ;Add the length * 2 to the x coordinate
	asl @
	asl @     ; Multiply by 4 (%00111111 to %11111100)
	sta $72         ; Store in screen location
	lda #$20        ; screen start / 2
	;sta $73         ; Save in high byte
	asl $72
	rol @   ; Multiply by 2 (total 8)
	sta $73
	lda $77
	asl @           ; Multiply by 2 to make 512
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
	and $76         ; Change colour
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
	lda $72
	clc
	adc #8      ; Update screen location
	sta $72
	lda $73
	adc #0  ; screen high
	sta $73         
	ldy #7
digit2loop
	lda ($70),Y     ; Get byte
	and $76         ; Change colour
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

levellosesoundpitches
	dta 88,80,80,68,60,52
levellosesounddurations
	dta 20,15,5,10,10,20

showloselogo
	lda #75
	jsr delay

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

	lda #<($5678)
	sta golscreenaddress
	lda #>($5678)
	sta golscreenaddress+1

	jsr gologo

	;lda #25:jsr delay
	lda #250
	jmp delay

	;pla:tax
	;dex
	;bne loseloop

	;rts

showlevlogo
	lda #25
	jsr delay

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

	lda #<($6878)
	sta golscreenaddress
	lda #>($6878)
	sta golscreenaddress+1

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





showwinlogo

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

	lda #<($5670)
	sta golscreenaddress
	lda #>($5670)
	sta golscreenaddress+1

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
	ldy #14*4-1
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

alreadydonehit
	lda #>(tempsprite)
	sta zsoff+1
	lda #<(tempsprite)
	sta zsoff
	pla
	tax
	pla
	tay
	rts

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

loadscreen
	lda #$27
	sta palt
	lda #$a7
	sta palt+1
	lda #$87
	sta palt+2			; Set pallette to black

	lda #((32*8*64-64)-512) / 256
	sta firsttime+1
	lda #((7*4*64+32)+512) / 256
	sta secondtime+1


	jsr deletestatusrows


	lda level
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

deletestatusrows		; Delete sprite status rows
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


levelwinsoundpitches
	dta 108,124,136,124,128
levelwinsounddurations
	dta 5,5,5,5,10


wavetext	;2ce2
.print "wavetext (supposed to be $2ce2): ",wavetext
;	incbin "/home/chris/bem/spriter/leveltext.bin"
towers	equ wavetext+$2d72-$2ce2 ;2d72
;	iNCBIN "/home/chris/bem/spriter/towers.bin"
.print "Towers ",towers
notower	equ wavetext+$2f22-$2ce2 ;2f22
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


endage

	ORG codeoffset
;	guard codeoffset+$ff

	jmp initinterrupts

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

	;vsynctotop=(32*8*64-64)-2
	;secondtime=(7*4*64+32)-2

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

numberend

eventend

	org codeoffset+$100
.print "org codeoffset+$100: ",codeoffset+$100
;	guard codeoffset+$1ff
	
	;INCBIN "/home/chris/bem/spriter/numbers.bin"
	dta     $44,$AA,$AA,$AA,$AA,$AA,$44,$00,$44,$CC,$44,$44,$44,$44,$EE
	dta $00,$44,$AA,$22,$44,$88,$88,$EE,$00,$CC,$22,$22,$CC,$22,$22,$CC
	dta $00,$88,$88,$88,$88,$AA,$EE,$22,$00,$EE,$88,$88,$CC,$22,$AA,$44
	dta $00,$66,$88,$88,$CC,$AA,$AA,$44,$00,$EE,$22,$22,$44,$44,$44,$44
	dta $00,$44,$AA,$AA,$44,$AA,$AA,$44,$00,$44,$AA,$AA,$66,$22,$22,$CC
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$99,$99,$99,$99,$99,$99,$77
	dta $00,$66,$44,$00,$00,$00,$44,$66,$00,$33,$11,$00,$00,$00,$11,$33
	dta $00			;0A6F 00

	;.savedtowerdist
	;  dta 100
	;.towerdistance
	;  dta 100

spritelowtable
  ;for x,0,nosprites-1
  ;for y,0,3
.rept nosprites
?x=#
.rept 4
?y=#
  dta [sprites+14*?y*4+?x*14*4*4] % 256
  ;next
  ;next
.endr
.endr
  
  ;for x,0,3
  ;for y,0,3
.rept 4
?x=#
.rept 4
?y=#
  dta [expl+14*?y*4+?x*14*4*4] % 256
  ;next
  ;next
.endr
.endr

spritehightable
  ;for x,0,nosprites-1
  ;for y,0,3
.rept nosprites
?x=#
.rept 4
?y=#
  dta [sprites+14*?y*4+?x*14*4*4] / 256
  ;next
  ;next
.endr
.endr
  
  ;for x,0,3
  ;for y,0,3
.rept 4
?x=#
.rept 4
?y=#
  dta [expl+14*?y*4+?x*14*4*4] / 256
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

printleft
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

printlives
	; Routine to print lives to screen.
	; Uses number print - so $70-$75 - does not preserve registers
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
  .word towers ;2d72
  .word towers+24*6 ; 24x24/4 ppb
  .word towers+24*6*2 ; 24x24/4 ppb

colourtable
	dta %0001,%10000,%10001

towertempnum
	dta 00,$0a		; Needs to be defined because od $0a

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

firetypes
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



lowcodeend

	;  PRINT "Event Code End ",eventend
	;  PRINT "Enemy health ",ehealth
	;  PRINT "Enemy shield ",eshield
	;  PrINT "Enemy type ",etype
	;  PRINT "Tower x pos ",txpos
	;  PRINT "Tower y pos ",typos
	;  PRINT "Tower type ",ttype
	;  PRINT "Tower fire count ",tfcount
	;  PRINT "Tower fire target ",tftarget
	;  PRINT "Sprites ",sprites
	;  PRINT "Explosions ",expl
	;  print "Lives ",lives
	;  print "Score ",score
	;  print "Wave ",wave
	;  print "Level ",level

	;  PRINT ".setup ",setup
  ;PRINT ".mainloop ",mainjump
  ;PRINT ".plotlots ",plotjump
  ;print ".plottower ",towerjump
  ;print ".numberplot",numberplot, " to ",numberend
  ;print ".drawbox",boxjump
.print "Main Code ",start," - ",endage," (",endage-start,")"
.print "Low code ",codeoffset," - ",lowcodeend," (",lowcodeend-codeoffset,")"
.print "Free space: Main = ",$3000-32-endage," Variables = ",expl-varend," etype location = ",etype,"-",varend
.print "interrupts $ Numbers = ",codeoffset+$ff-numberend," ",numberend 
.print "table data ",codeoffset+$3ff-lowcodeend
.print "level data size = ",varend-wavedata
.print "A Page",codeoffset+$1ff-apage," ",apage
.print "pal ",palt
.print "firsttime ",firsttime
.print "secondtime ",secondtime
.print "intflag",intflag

/*	if codeoffset=$900
	save "CDCode",start,end
	save "LowCode",$900,lowcodeend
	else
	save "CDCodeM",start,end
	save "LowCodM",$E00,lowcodeend
	endif

	clear start,end
*/


