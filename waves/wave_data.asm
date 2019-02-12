; wavedata generator
                    
          org $1000  
; ****** LEVEL 1 ********

.local
wavedata
;Level 1 Wave 1

goldvalues      ;Values of gold for each enemy (bcd)    
          dta $17,$20,$18,$21
enemystrengths		;BCD
          dta $14,$20,$28,$35
enemyshields		;BCD
	dta $00,$0,$0,$0
enemyspeed
	dta 50,100			; distance between enemies in frames (zero needed)
spritenumbers  ; Types of enemy
	dta "acde"
enemynumber
	dta $34
; Enemy type list? - reserve ebytes?
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
;	dta 0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,0,0,0,0,1,1,1,1,0
	dta 0,0,0,1,0,0,1,0,0,1,0,1,0,0,0,1,0,1,1,0,0,0,2,0,1,1,0,0,2,1,0,1,1,0,0,2,2,1,1,0,0,3,0,0,3,1,1,2,1,1,1,0,0,4,2,2,2,0,0,4,3,3,3,0
.endl

.local
;Level 1 Wave 2
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $14,$18,$15,$19
enemystrengths		;BCD
	dta $20,$29,$38,$45
enemyshields		;BCD
	dta $00,$0,$0,$00
enemyspeed
	dta 44,88			; distance between enemies in frames
spritenumbers  ; Types of enemy
	dta "acde"
enemynumber
	dta $45
; Enemy type list? - reserve ebytes?
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,3,1,1,3,0,0,0,4,2,2,4,0,0,0,3,2,2,2,3,0,0,4,2,4,2,4,0,0,3,3,1,3,3,0,0,4,4,3,4,4,0,0,3,4,3,3,3,4,3,0,0,4,4,4,3,4,4,4,0,3,4,3,0
.endl
.local
;Level 1 Wave 3
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $03,$05,$10,$15
enemystrengths		;BCD
	dta $25,$33,$45,$55
enemyshields		;BCD
	dta $0,$0,$0,$0
enemyspeed
	dta 30,60			; distance between enemies in frames
spritenumbers  ; Types of enemy
	dta "mnad"
enemynumber
	dta $51
; Enemy type list? - reserve ebytes?
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,1,1,1,0,2,2,2,0,1,1,1,1,0,3,3,3,2,2,2,0,0,4,1,2,1,2,1,4,0,3,3,2,2,1,1,4,4,0,0,4,4,4,4,4,0,0,3,1,2,1,3,1,2,1,0,4,1,4,2,4,3,4,0
.endl
.local
;Level 1 Wave 4
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $03,$10,$15,$25
enemystrengths		;BCD
	dta $45,$55,$65,$25
enemyshields		;BCD
	dta $0,$0,$0,$10
enemyspeed
	dta 39,78			; distance between enemies in frames
spritenumbers  ; Types of enemy
	dta "maeg"
enemynumber
	dta $49
; Enemy type list? - reserve ebytes?
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,1,1,1,1,1,0,3,2,2,2,2,3,0,3,3,2,2,3,3,0,1,1,1,1,1,0,0,4,0,0,2,4,2,0,0,4,1,1,1,4,0,3,4,4,0,4,4,3,0,1,2,3,4,4,3,2,1,0,4,4,4,4,0
.endl
.local
;Level 1 Wave 5 (234)
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $15,$20,$28,$33
enemystrengths		;BCD
	dta $65,$75,$40,$50
enemyshields		;BCD
	dta $0,$0,$15,$20
enemyspeed
	dta 33,66			; distance between enemies in frames
spritenumbers  ; Types of enemy
	dta "aegh"
enemynumber
	dta $55
; Enemy type list? - reserve ebytes?
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,1,1,2,2,1,1,2,2,0,3,1,1,3,0,4,2,2,4,0,2,1,3,1,4,1,3,3,2,4,4,2,1,0,2,2,2,2,0,1,1,1,1,1,0,3,3,3,3,3,3,0,4,4,4,4,4,4,2,2,1,2,2,0


.endl



; ****** LEVEL 2 ********

.local
;Level 2 Wave 1

goldvalues      ;Values of gold for each enemy (bcd)    
	dta $11,$20,$25,$30
enemystrengths		;BCD
	dta $15,$23,$10,$20
enemyshields		;BCD
	dta $5,$7,$12,$23
enemyspeed
	dta 60,120		; distance between enemies in frames (zero needed)
spritenumbers  ; Types of enemy
	dta "nfho"
enemynumber
	dta $36
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,0,0,1,0,1,0,0,2,1,1,0,0,3,1,1,0,0,3,2,2,1,0,0,0,3,1,1,3,1,1,3,0,0,0,4,0,0,0,3,4,3,0,0,0,4,1,1,4,0,0,0,4,4,0,0,2,2,4,2,4,2,4,0
.endl

.local          
;Level 2 Wave 2
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $12,$15,$30,$50
enemystrengths		;BCD
	dta $15,$20,$25,$45
enemyshields		;BCD
	dta $11,$16,$22,$30
enemyspeed
	dta 42,84			; distance between enemies in frames
spritenumbers  ; Types of enemy
	dta "ahop"
enemynumber
	dta $41
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,1,1,1,0,0,2,2,0,0,1,1,2,2,1,1,0,0,0,3,1,1,1,3,0,0,0,3,2,2,2,3,0,0,2,1,2,1,2,1,2,1,0,0,3,3,3,0,0,4,0,0,1,3,3,1,0,0,4,4,0,4,4,0
.endl

.local
;Level 2 Wave 3
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $15,$24,$34,$60
enemystrengths		;BCD
	dta $20,$25,$35,$50
enemyshields		;BCD
	dta $15,$20,$25,$35
enemyspeed
	dta 38,74			; distance between enemies in frames
spritenumbers  ; Types of enemy
	dta "cmhp"
enemynumber
	dta $47
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,2,2,0,1,1,0,2,2,0,1,2,1,0,2,2,1,2,2,0,3,3,0,1,3,3,2,2,3,3,1,0,0,4,4,0,0,1,1,4,4,2,2,3,3,1,1,0,0,0,4,1,4,0,4,2,4,3,4,0,4,4,4,0
.endl

.local
;Level 2 Wave 4
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $09,$13,$18,$24
enemystrengths		;BCD
	dta $65,$73,$85,$99
enemyshields		;BCD
	dta $0,$0,$00,$00
enemyspeed
	dta 36,72			; distance between enemies in frames
spritenumbers  ; Types of enemy
	dta "nmad"
enemynumber
	dta $56
; Enemy type list? - reserve ebytes?
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,1,1,2,1,1,0,2,2,1,1,2,2,0,3,3,2,2,3,3,1,1,3,3,0,4,1,2,3,2,1,4,0,0,4,4,3,3,3,4,4,3,3,3,4,4,0,1,1,1,2,2,2,3,3,3,3,4,4,4,4,4,4,0
.endl

.local
;Level 2 Wave 5 (468)
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $12,$20,$35,$60
enemystrengths		;BCD
	dta $35,$45,$55,$75
enemyshields		;BCD
	dta $22,$28,$37,$60
enemyspeed
	dta 30,60			; distance between enemies in frames
spritenumbers  ; Types of enemy
	dta "dgoi"
enemynumber
	dta $54
; Enemy type list? - reserve ebytes?
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,1,2,1,2,1,0,2,3,2,3,2,0,1,1,2,2,3,3,1,1,2,2,3,3,2,2,1,1,0,3,3,3,2,2,2,3,3,3,0,3,1,3,2,3,1,3,0,0,1,1,1,4,0,2,2,4,4,0,3,3,4,4,0
.endl


; ****** LEVEL 3 ********

.local
;Level 3 Wave 1

goldvalues      ;Values of gold for each enemy (bcd)    
	dta $14,$18,$23,$28
enemystrengths		;BCD
	dta $15,$25,$35,$40
enemyshields		;BCD
	dta $7,$7,$09,$13
enemyspeed
	dta 52,104			; distance between enemies in frames (zero needed)
spritenumbers  ; Types of enemy
	dta "amgq"
enemynumber
	dta $43
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,0,0,1,1,0,0,2,2,0,0,1,2,2,1,0,0,3,3,0,0,1,3,2,3,1,0,0,1,2,2,3,3,2,2,1,1,0,0,4,1,4,0,0,4,4,2,2,4,4,0,0,3,4,4,3,2,2,3,0,4,4,4,0
.endl


.local
;Level 3 Wave 2
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $16,$20,$25,$35
enemystrengths		;BCD
	dta $15,$25,$35,$45
enemyshields		;BCD
	dta $13,$18,$23,$30
enemyspeed
	dta 41,82			; distance between enemies in frames
spritenumbers  ; Types of enemy
	dta "dhor"
enemynumber
	dta $45
; Enemy type list? - reserve ebytes?
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,2,2,2,0,0,3,1,1,1,0,0,2,1,2,1,0,3,1,3,1,0,0,1,3,3,4,3,3,1,0,2,2,0,4,0,2,2,0,0,4,4,0,0,4,1,4,0,2,4,0,4,2,0,4,1,1,2,2,3,3,4,4,0
.endl

.local
;Level 3 Wave 3
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $18,$25,$30,$40
enemystrengths		;BCD
	dta $75,$43,$57,$65
enemyshields		;BCD
	dta $00,$25,$32,$45
enemyspeed
	dta 36,72			; distance between enemies in frames
spritenumbers  ; Types of enemy
	dta "cmqi"
enemynumber
	dta $43
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,1,0,1,0,1,0,1,1,1,1,1,1,1,1,0,0,0,2,0,2,0,1,2,2,1,0,0,3,0,1,3,3,3,1,0,0,2,3,3,2,2,1,1,0,0,4,0,0,1,1,1,4,4,1,1,1,0,0,3,3,4,4,0
.endl

.local 
;Level 3 Wave 4 ****
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $20,$26,$33,$44
enemystrengths		;BCD
	dta $45,$50,$60,$70
enemyshields		;BCD
	dta $20,$30,$35,$45
enemyspeed
	dta 33,66			; distance between enemies in frames
spritenumbers  ; Types of enemy
	dta "mgos"
enemynumber
	dta $49
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,3,0,0,1,1,1,0,2,2,2,0,0,4,0,0,4,4,0,0,2,2,3,3,2,2,0,1,1,4,4,1,1,0,2,3,4,4,4,3,2,0,1,1,1,2,2,2,3,3,3,4,4,4,0,1,1,4,4,4,4,3,3,0
.endl

.local
;Level 3 Wave 5 (697)
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $30,$40,$50,$70
enemystrengths		;BCD
	dta $50,$55,$65,$75
enemyshields		;BCD
	dta $25,$35,$45,$65
enemyspeed
	dta 28,56			; distance between enemies in frames
spritenumbers  ; Types of enemy
	dta "nrsj"
enemynumber
	dta $48
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,1,1,1,0,1,1,1,0,2,2,0,3,2,2,0,3,3,1,1,1,3,3,0,0,4,0,0,1,1,1,4,4,1,1,1,0,0,1,2,2,4,4,2,2,1,0,0,3,3,4,4,4,3,3,0,0,3,2,4,4,2,3,0
.endl



; ****** LEVEL 4 ********

.local
;Level 4 Wave 1

goldvalues      ;Values of gold for each enemy (bcd)    
	dta $25,$30,$38,$52
enemystrengths		;BCD
	dta $20,$23,$27,$33
enemyshields		;BCD
	dta $20,$26,$32,$40
enemyspeed
	dta 50,100		; distance between enemies in frames (zero needed)
spritenumbers  ; Types of enemy
	dta "bmqs"
enemynumber
	dta $46
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,0,0,1,1,0,0,1,1,0,0,1,1,1,2,0,0,1,1,2,0,2,2,3,0,1,4,1,0,0,4,4,2,2,0,3,3,4,1,0,4,4,4,0,1,1,2,2,1,1,3,3,0,4,4,2,2,4,4,3,3,4,4,0
.endl

.local
;Level 4 Wave 2
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $25,$32,$40,$60
enemystrengths		;BCD
	dta $30,$28,$40,$55
enemyshields		;BCD
	dta $25,$33,$38,$65
enemyspeed
	dta 37,74			; distance between enemies in frames
spritenumbers  ; Types of enemy
	dta "dosk"
enemynumber
	dta $48
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,1,1,2,2,1,1,0,0,2,2,2,1,1,2,2,2,0,3,3,1,1,1,3,3,0,0,2,2,3,1,3,2,2,0,0,3,1,3,1,3,0,0,4,0,0,1,1,4,1,1,0,0,2,2,4,4,3,3,0,4,4,4,0
.endl

.local
;Level 4 Wave 3 
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $23,$30,$35,$65
enemystrengths		;BCD
	dta $35,$45,$55,$65
enemyshields		;BCD
	dta $30,$35,$45,$70
enemyspeed
	dta 30,60			; distance between enemies in frames
spritenumbers  ; Types of enemy
	dta "mrsl"
enemynumber
	dta $50
; Enemy type list? - reserve ebytes?
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,4,0,0,2,2,2,0,1,1,1,1,0,0,3,1,3,1,3,0,1,2,1,2,1,2,0,4,3,3,4,0,0,4,4,3,3,4,4,0,0,1,1,1,2,2,3,3,4,3,3,2,2,1,1,1,0,4,4,4,3,2,1,0
.endl

.local
;Level 4 Wave 4 ***NEXT
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $20,$22,$25,$30
enemystrengths		;BCD
	dta $40,$50,$60,$70
enemyshields		;BCD
	dta $35,$40,$45,$50
enemyspeed
	dta 40,80			; distance between enemies in frames
spritenumbers  ; Types of enemy
	dta "goqs"
enemynumber
	dta $62
; Enemy type list? - reserve ebytes?
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,1,1,1,2,1,1,3,1,1,2,2,1,1,3,2,3,2,1,1,2,2,3,4,3,4,2,2,2,3,3,3,1,1,2,2,3,3,4,4,1,1,4,1,1,3,1,1,2,2,4,4,3,2,4,2,3,4,4,4,3,2,1,0
.endl

.local
;Level 4 Wave 5 (941)
goldvalues      ;Values of gold for each enemy (bcd)    
	dta $20,$65,$75,$95
enemystrengths		;BCD
	dta $50,$70,$80,$99
enemyshields		;BCD
	dta $40,$60,$70,$99
enemyspeed
	dta 24,48			; distance between enemies in frames
spritenumbers  ; Types of enemy
	dta "aikl"
enemynumber
	dta $39
; Enemy type list? - reserve ebytes?
; level data - paths
;             1 2 3 4 5 6 7 8 910 1 2 3 4 5 6 7 8 920 1 2 3 4 5 6 7 8 930 1 2 3 4 5 6 7 8 940 1 2 3 4 5 6 7 8 950 1 2 3 4 5 6 7 8 960 1 2 3 4
	dta 0,1,1,1,1,0,0,2,0,0,2,0,0,3,0,0,3,0,0,2,0,2,0,3,0,3,0,0,2,2,3,3,0,0,1,1,1,4,4,1,1,1,0,0,4,0,4,0,4,4,4,0,0,2,3,4,2,3,4,2,3,4,4,0
.endl

