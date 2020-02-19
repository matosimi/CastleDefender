;CastleDefender SAP module 2 - MatoSimi 19.02.2020	
	org $2000
	
.local	rmt
PLAYER	equ *+$400
	icl "..\rmtplayr.a65"
.endl

.proc	music_init
	tax
	lda songline,x
	ldx #<music2
	ldy #>music2
	jsr rmt.rmt_init	;initialize the music
	jsr rmt.set_stereo
	rts
songline	dta 0,3,6,8
.endp

music	equ $a071 ;to $a528	
music2	equ $a529 ;to $aaff
	
	org music2
	ins "..\game_stripped_a529.rmt",+6
	
.print	"init:",music_init
.print	"player:",rmt.rmt_play
