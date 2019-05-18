;Castle Defender data relocator

.local datareloc

loadarea	equ $8000
	org loadarea
;waves
z1	ins "waves\L1W1.bin.deflate"
z2	ins "waves\L1W2.bin.deflate"
z3	ins "waves\L1W3.bin.deflate"
z4	ins "waves\L1W4.bin.deflate"
z5	ins "waves\L1W5.bin.deflate"
z6	ins "waves\L2W1.bin.deflate"
z7	ins "waves\L2W2.bin.deflate"
z8	ins "waves\L2W3.bin.deflate"
z9	ins "waves\L2W4.bin.deflate"
z10	ins "waves\L2W5.bin.deflate"
z11	ins "waves\L3W1.bin.deflate"
z12	ins "waves\L3W2.bin.deflate"
z13	ins "waves\L3W3.bin.deflate"
z14	ins "waves\L3W4.bin.deflate"
z15	ins "waves\L3W5.bin.deflate"
z16	ins "waves\L4W1.bin.deflate"
z17	ins "waves\L4W2.bin.deflate"
z18	ins "waves\L4W3.bin.deflate"
z19	ins "waves\L4W4.bin.deflate"
z20	ins "waves\L4W5.bin.deflate"

dataend

moveto	equ $e000
w1	equ $c0
w2	equ $c2
portb	equ $d301 ;ff-no basic rom, fe-no rom at all
nmien	equ $d40e

relocode	lda:cmp:req 20
        	lda #$00
        	sta nmien
        	sei		;disallow IRQ
	mva #$fe portb
	ldx #1 ;no of pages (zero based)
	ldy #0
	mwa #loadarea w1
	mwa #moveto w2
x1	mva (w1),y (w2),y
	iny
	bne x1	
	inc w1+1
	inc w2+1
	dex
	bpl x1
	
	mva #$ff portb ;continue loading
	cli
	mva #$c0 nmien
	rts
	ini relocode
.endl	
