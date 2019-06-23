;Castle Defender data relocator

.local datareloc

w1	equ $c0
w2	equ $c2
portb	equ $d301 ;ff-no basic rom, fe-no rom at all
nmien	equ $d40e

loadarea	equ $8000
moveto	equ $d800 ;to $ffff
moveto2	equ $ac00 ;to $cfff

C_PAGES	equ $27
C_PAGES2	equ $23

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
;level fonts
l1f	ins "levels\L1.fnt.deflate"
l2f	ins "levels\L2.fnt.deflate"
;level data
l1d	ins "levels\L1data.bin.deflate"
l2d	ins "levels\L2data.bin.deflate"
;pm overlay
p1	ins "pmg\lvl1.pmg.deflate"
p2	ins "pmg\lvl2.pmg.deflate"
p3	ins "pmg\lvl3.pmg.deflate"
p4	ins "pmg\lvl4_1.pmg.deflate"

dataend

.print "relocate from:",loadarea,"-",dataend," (",dataend-loadarea,")"
.print "relocate to:  ",moveto,"-",moveto+dataend-loadarea, " (",[dataend-loadarea]/256, " pages)"

relocode	lda:cmp:req 20
        	lda #$00
        	sta nmien
        	sei		;disallow IRQ
	mva #$fe portb
	ldx #C_PAGES ;no of pages (zero based)
	ldy #0
	mwa #loadarea w1
	mwa #moveto w2
x1	mva (w1),y (w2),y
	iny
	bne x1	
	inc w1+1
	inc w2+1
	dex
	bne x1
;last page (partial copy only)
	ldy #0
x2	mva (w1),y (w2),y
	iny
	cpy #<dataend
	bne x2	

	mva #$ff portb ;continue loading
	cli
	mva #$c0 nmien
	rts
	ini relocode
	
	org loadarea
;level fonts
l3f	ins "levels\L3.fnt.deflate"
l4f	ins "levels\L41.fnt.deflate"
;level data
l3d	ins "levels\L3data.bin.deflate"
l4d	ins "levels\L4data.bin.deflate"
sboard	ins "scoreboard\scoreboard.fnt.deflate"
allsprit	ins "sprites\allsprites.fnt.deflate"

dataend2
.print "relocate from:",loadarea,"-",dataend2," (",dataend2-loadarea,")"
.print "relocate to:  ",moveto2,"-",moveto2+dataend2-loadarea, " (",[dataend2-loadarea]/256, " pages)"

.local
relocode	lda:cmp:req 20
        	lda #$00
        	sta nmien
        	sei		;disallow IRQ
	mva #$fe portb
	ldx #C_PAGES2 ;no of pages (zero based)
	ldy #0
	mwa #loadarea w1
	mwa #moveto2 w2
x1	mva (w1),y (w2),y
	iny
	bne x1	
	inc w1+1
	inc w2+1
	dex
	bne x1

;last page (partial copy only)
	ldy #0
x2	mva (w1),y (w2),y
	iny
	cpy #<dataend2
	bne x2	

	mva #$ff portb ;continue loading
	cli
	mva #$c0 nmien
	rts
	ini relocode
.endl

.endl	
