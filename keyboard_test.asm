;keyboard test - keyboard handling code
	
	run $2000
	
kbcode	equ $d209
irqen	equ $d20e
skctl	equ $d20f
nmien	equ $d40e
	
keystat	equ $b9
keypres	equ $ba
keytable	equ $3000 ;table of keycodes
keybuf	equ $bc40+80	

	org $2000
	
	sei
	lda #$00 
	;sta nmien
	sta irqen 	;disable interupts (klavesy)
	
	;keyboard init
	ldy #$7f
copykeytab
        	lda ($79),y ; pointer to keytable in osrom
        	sta keytable,y
        	dey
        	bpl copykeytab
        	
        	
loop	
	spacepressed
	sta $bc50
	
	mva 20 $bc42
	getkeypressed
	
	cmp #255
	beq cont
	inc index
	ldy index
	sta keybuf,y
	
cont	ldx skctl
	stx $bc41
	
	sta $bc40
	a_in #"P" #"Y" n1 ;handle numbers
	

	jmp loop

n1	sub #"P"
	ora #$10
	sta $bc40+40
	jmp loop
        	
index	dta 0
	icl 'matosimi_macros.asx'
	
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
	
keynotpressed
	mva #0 keystat
	
stillpressed
	lda #255
	rts
	
readkey	lda #1
	sta keystat

	ldx kbcode
	lda keytable,x
	sta keypres
	rts
.endp

.proc	spacepressed ;toggle
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
