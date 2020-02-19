;CastleDefender SAP module 1 - MatoSimi 19.02.2020	
	org $2000
	
.local	rmt
PLAYER	equ *+$400
	icl "..\rmtplayr.a65"
.endl

.proc	music_init
	jsr rmt.set_stereo
	ldx #<music
	ldy #>music
	lda #0
	jsr rmt.rmt_init	;initialize the music
	rts
.endp

music	equ $a071 ;to $a528	
music2	equ $a529 ;to $aaff
	
	org music
	ins "..\menu_stripped_a071.rmt",+6
	
.print	"init:",music_init
.print	"player:",rmt.rmt_play
