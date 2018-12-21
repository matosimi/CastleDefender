
Deprecated: The each() function is deprecated. This message will be suppressed on further calls in C:\!atari\prg\CastleDefender\rsdis.php on line 33
;
; File 'cd.obx', size $2844 (10308) bytes
;
; Block $0900-$0CFE ($03FF)
; Block $0E00-$11FE ($03FF)
; Block $1B00-$2FB1 ($14B2)
; Block $6000-$637F ($0380)
; Block $4000-$47FF ($0800)
;
; RUNADR=$0900
;
;
; EXTRARUNADR=$1B00
; EXTRARUNADR=$0952
; EXTRARUNADR=$0903
; EXTRARUNADR=$0E00
; EXTRARUNADR=$0E03
; EXTRARUNADR=$0E52
;
;--------------------------------
;
ZP_70	equ $70
ZP_71	equ $71
ZP_72	equ $72
ZP_73	equ $73
ZP_74	equ $74
ZP_75	equ $75
ZP_76	equ $76
ZP_77	equ $77
ZP_78	equ $78
ZP_79	equ $79
ZP_7A	equ $7A
ZP_7B	equ $7B
ZP_7C	equ $7C
ZP_7D	equ $7D
ZP_7E	equ $7E
ZP_7F	equ $7F
ZP_80	equ $80
ZP_81	equ $81
ZP_82	equ $82
ZP_83	equ $83
ZP_86	equ $86
ZP_87	equ $87
ZP_88	equ $88
ZP_8B	equ $8B
ZP_8C	equ $8C
ZP_8D	equ $8D
ZP_8E	equ $8E
ZP_8F	equ $8F
ZP_EC	equ $EC
ZP_ED	equ $ED
L_0204	equ $0204
L_0205	equ $0205
L_0228	equ $0228
;
		org $0900
;
L_0900	jmp L_091D		;0900 4C 1D 09
L_0903	lda #$00		;0903 A9 00
		sta ZP_70		;0905 85 70
		lda #$30		;0907 A9 30
		sta ZP_71		;0909 85 71
		lda #$00		;090B A9 00
		ldy #$00		;090D A0 00
L_090F	sta (ZP_70),Y	;090F 91 70
		dey				;0911 88
		bne L_090F		;0912 D0 FB
		inc ZP_71		;0914 E6 71
		ldx ZP_71		;0916 A6 71
		cpx #$80		;0918 E0 80
		bne L_090F		;091A D0 F3
		rts				;091C 60
L_091D	sei				;091D 78
		lda L_0204		;091E AD 04 02
		sta L_09E3		;0921 8D E3 09
		lda L_0205		;0924 AD 05 02
		sta L_09E4		;0927 8D E4 09
		lda #$52		;092A A9 52
		sta L_0204		;092C 8D 04 02
		lda #$09		;092F A9 09
		sta L_0205		;0931 8D 05 02
		lda #$20		;0934 A9 20
		sta L_FE6E		;0936 8D 6E FE
		sta L_FE6D		;0939 8D 6D FE
		lda #$04		;093C A9 04
		sta L_FE6C		;093E 8D 6C FE
		lda #$00		;0941 A9 00
		sta L_FE6B		;0943 8D 6B FE
		lda #$FE		;0946 A9 FE
		sta L_FE44		;0948 8D 44 FE
		lda #$26		;094B A9 26
		sta L_FE45		;094D 8D 45 FE
		cli				;0950 58
		rts				;0951 60
L_0952	lda L_FE4D		;0952 AD 4D FE
		and #$02		;0955 29 02
		beq L_0972		;0957 F0 19
		lda L_09DF		;0959 AD DF 09
		sta L_FE68		;095C 8D 68 FE
		lda L_09E0		;095F AD E0 09
		sta L_FE69		;0962 8D 69 FE
		lda #$A0		;0965 A9 A0
		sta L_FE6E		;0967 8D 6E FE
		lda L_09E7		;096A AD E7 09
		beq L_096F		;096D F0 00
L_096F	jmp (L_09E3)	;096F 6C E3 09
L_0972	lda L_FE6D		;0972 AD 6D FE
		and #$20		;0975 29 20
		beq L_096F		;0977 F0 F6
		sta L_FE6D		;0979 8D 6D FE
		lda L_09E7		;097C AD E7 09
		beq L_096F		;097F F0 EE
		lda L_09E5		;0981 AD E5 09
		bne L_09AF		;0984 D0 29
		inc L_09E5		;0986 EE E5 09
		inc L_09E6		;0989 EE E6 09
		lda #$A4		;098C A9 A4
		jsr L_09C9		;098E 20 C9 09
		lda #$20		;0991 A9 20
		jsr L_09C9		;0993 20 C9 09
		lda #$85		;0996 A9 85
		jsr L_09C9		;0998 20 C9 09
		lda L_09E1		;099B AD E1 09
		sta L_FE68		;099E 8D 68 FE
		lda L_09E2		;09A1 AD E2 09
		sta L_FE69		;09A4 8D 69 FE
		lda #$A0		;09A7 A9 A0
		sta L_FE6E		;09A9 8D 6E FE
		jmp (L_09E3)	;09AC 6C E3 09
L_09AF	lda L_09DC		;09AF AD DC 09
		jsr L_09C9		;09B2 20 C9 09
		lda L_09DD		;09B5 AD DD 09
		jsr L_09C9		;09B8 20 C9 09
		lda L_09DE		;09BB AD DE 09
		jsr L_09C9		;09BE 20 C9 09
		lda #$00		;09C1 A9 00
		sta L_09E5		;09C3 8D E5 09
		jmp (L_09E3)	;09C6 6C E3 09
L_09C9	sta L_FE21		;09C9 8D 21 FE
		eor #$10		;09CC 49 10
		sta L_FE21		;09CE 8D 21 FE
		eor #$40		;09D1 49 40
		sta L_FE21		;09D3 8D 21 FE
		eor #$10		;09D6 49 10
		sta L_FE21		;09D8 8D 21 FE
		rts				;09DB 60
L_09DC	dta $26			;09DC 26 & F
L_09DD	dta $A1			;09DD A1 ! A
L_09DE	dta $85			;09DE 85   %
L_09DF	dta $BE			;09DF BE > ^
L_09E0	dta $3F			;09E0 3F ? _
L_09E1	dta $1E			;09E1 1E   >
L_09E2	dta $07			;09E2 07   '
L_09E3	dta $00			;09E3 00    
L_09E4	dta $00			;09E4 00    
L_09E5	dta $00			;09E5 00    
L_09E6	dta $00			;09E6 00    
L_09E7	dta $00			;09E7 00    
L_09E8	dta $74,$7C,$74,$6C,$74,$80,$94
;asc	dta c"t|tlt",$80,$94
;vid	dta d"t|tlt",d" 4"*
L_09EF	dta $07
	dta $04,$07,$07,$07,$08,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $07,$04,$07,$07,$07,$08,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"'$'''(0         "
;$0a00
		dta $00,$44,$AA,$AA,$AA,$AA,$AA,$44,$00,$44,$CC,$44,$44,$44,$44,$EE
;asc	dta $00,c"D",c"*****"*,c"D",$00,c"D",c"L"*,c"DDDD",c"n"*
;vid	dta d" ",$44,d"JJJJJ"*,$44,d" ",$44,$CC,$44,$44,$44,$44,d"n"*
		dta $00,$44,$AA,$22,$44,$88,$88,$EE,$00,$CC,$22,$22,$CC,$22,$22,$CC
;asc	dta $00,c"D",c"*"*,c"""D",$88,$88,c"n"*,$00,c"L"*,c"""""",c"L"*,c"""""",c"L"*
;vid	dta d" ",$44,d"J"*,d"B",$44,d"((n"*,d" ",$CC,d"BB",$CC,d"BB",$CC
		dta $00,$88,$88,$88,$88,$AA,$EE,$22,$00,$EE,$88,$88,$CC,$22,$AA,$44
;asc	dta $00,$88,$88,$88,$88,c"*n"*,c"""",$00,c"n"*,$88,$88,c"L"*,c"""",c"*"*,c"D"
;vid	dta d" ",d"((((Jn"*,d"B ",d"n(("*,$CC,d"B",d"J"*,$44
		dta $00,$66,$88,$88,$CC,$AA,$AA,$44,$00,$EE,$22,$22,$44,$44,$44,$44
;asc	dta $00,c"f",$88,$88,c"L**"*,c"D",$00,c"n"*,c"""""DDDD"
;vid	dta d" f",d"(("*,$CC,d"JJ"*,$44,d" ",d"n"*,d"BB",$44,$44,$44,$44
		dta $00,$44,$AA,$AA,$44,$AA,$AA,$44,$00,$44,$AA,$AA,$66,$22,$22,$CC
;asc	dta $00,c"D",c"**"*,c"D",c"**"*,c"D",$00,c"D",c"**"*,c"f""""",c"L"*
;vid	dta d" ",$44,d"JJ"*,$44,d"JJ"*,$44,d" ",$44,d"JJ"*,d"fBB",$CC
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$99,$99,$99,$99,$99,$99,$77
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$99,$99,$99,$99,$99,$99,c"w"
;vid	dta d"         ",d"999999"*,d"w"
		dta $00,$66,$44,$00,$00,$00,$44,$66,$00,$33,$11,$00,$00,$00,$11,$33
;asc	dta $00,c"fD",$00,$00,$00,c"Df",$00,c"3",$11,$00,$00,$00,$11,c"3"
;vid	dta d" f",$44,d"   ",$44,d"f S1   1S"
		dta $00			;0A6F 00    
L_0A70	dta $90,$C8,$00,$38,$70,$A8,$E0,$18,$50,$88,$C0,$F8,$30,$68,$A0,$D8
;asc	dta $90,c"H"*,$00,c"8p",c"(`"*,$18,c"P",$88,c"@x"*,c"0h",c" X"*
;vid	dta d"0"*,$C8,d" Xp",d"H`"*,d"8",$50,d"("*,$C0,d"x"*,d"Ph",d"@"*,$D8
		dta $10,$48,$80,$B8,$F0,$28,$60,$98,$D0,$08,$40,$78,$B0,$E8,$20,$58
;asc	dta $10,c"H",$80,c"8p"*,c"(`",$98,c"P"*,$08,c"@x",c"0h"*,c" X"
;vid	dta d"0",$48,d" Xp"*,d"H`",d"8"*,$D0,d"(",$40,d"x",d"Ph"*,d"@",$58
L_0A90	dta $34,$34,$35,$35,$35,$35,$35,$36,$36,$36,$36,$36,$37,$37,$37,$37
;asc	dta c"4455555666667777"
;vid	dta d"TTUUUUUVVVVVWWWW"
		dta $31,$31,$31,$31,$31,$32,$32,$32,$32,$33,$33,$33,$33,$33,$34,$34
;asc	dta c"1111122223333344"
;vid	dta d"QQQQQRRRRSSSSSTT"
L_0AB0	dta $00,$01,$04,$09,$10,$19,$24,$31,$40,$51,$64,$79,$90,$A9,$C4,$E1
;asc	dta $00,$01,$04,$09,$10,$19,c"$1@Qdy",$90,c")Da"*
;vid	dta d" !$)09DQ",$40,$51,d"dy",d"0I"*,$C4,d"a"*
		dta $53,$2E
;asc	dta c"S."
;vid	dta $53,d"N"
L_0AC2	dta $31,$0D,$4C,$2E
;asc	dta c"1",$0D,c"L."
;vid	dta d"Q-",$4C,d"N"
L_0AC6	dta $31,$0D
;asc	dta c"1",$0D
;vid	dta d"Q-"
L_0AC8	lda #$FF		;0AC8 A9 FF
		sta L_3060		;0ACA 8D 60 30
		lda #$3D		;0ACD A9 3D
		sta ZP_70		;0ACF 85 70
		lda #$1F		;0AD1 A9 1F
		sta ZP_77		;0AD3 85 77
		lda #$9D		;0AD5 A9 9D
		sta ZP_74		;0AD7 85 74
		lda #$30		;0AD9 A9 30
		sta ZP_75		;0ADB 85 75
		ldx #$00		;0ADD A2 00
		jmp L_2A08		;0ADF 4C 08 2A
L_0AE2	lda #$F0		;0AE2 A9 F0
		sta L_3060		;0AE4 8D 60 30
		lda #$08		;0AE7 A9 08
		sta ZP_70		;0AE9 85 70
		lda #$1D		;0AEB A9 1D
		sta ZP_77		;0AED 85 77
		lda #$08		;0AEF A9 08
		sta ZP_74		;0AF1 85 74
		lda #$30		;0AF3 A9 30
		sta ZP_75		;0AF5 85 75
		ldx #$00		;0AF7 A2 00
		jmp L_2A08		;0AF9 4C 08 2A
		dta $00,$00,$00,$00
;asc	dta $00,$00,$00,$00
;vid	dta d"    "
L_0B00	dta $00,$00,$00,$00,$14,$15,$22,$35,$20,$23,$28,$40
;asc	dta $00,$00,$00,$00,$14,$15,c"""5 #(@"
;vid	dta d"    45BU@CH",$40
L_0B0C	dta $37,$43,$55,$75,$15,$18,$21,$24,$21,$23,$25,$27
;asc	dta c"7CUu",$15,$18,c"!$!#%'"
;vid	dta d"W",$43,$55,d"u58ADACEG"
L_0B18	dta $25,$27,$29,$31,$48,$5A,$6E,$90,$84,$90,$9C,$A9
;asc	dta c"%')1HZn",$90,$84,$90,$9C,c")"*
;vid	dta d"EGIQ",$48,$5A,d"n",d"0$0<I"*
L_0B24	dta $9C,$B6,$D2,$F0,$02,$03,$05,$07,$00,$00,$00,$01
;asc	dta $9C,c"6Rp"*,$02,$03,$05,$07,$00,$00,$00,$01
;vid	dta d"<V"*,$D2,d"p"*,d"""#%'   !"
L_0B30	dta $06,$11,$17,$25,$00,$00,$00,$01,$04,$07,$10,$15
;asc	dta $06,$11,$17,c"%",$00,$00,$00,$01,$04,$07,$10,$15
;vid	dta d"&17E   !$'05"
L_0B3C	dta $01,$02,$04,$07,$16,$15,$14,$13,$20,$17,$15,$12
;asc	dta $01,$02,$04,$07,$16,$15,$14,$13,c" ",$17,$15,$12
;vid	dta d"!""$'6543@752"
L_0B48	dta $30,$27,$22,$18,$63,$67,$71,$77,$50,$59,$67,$83,$33,$37,$45,$56
;asc	dta c"0'""",$18,c"cgqwPYg",$83,c"37EV"
;vid	dta d"PGB8cgqw",$50,$59,d"g",d"#"*,d"SW",$45,$56
L_0B58	dta $22,$2F,$72,$2D,$02,$2E,$92,$2E
;asc	dta c"""/r-",$02,c".",$92,c"."
;vid	dta d"BOrM""N",d"2"*,d"N"
L_0B60	dta $01,$10
;asc	dta $01,$10
;vid	dta d"!0"
L_0B62	dta $11			;0B62 11   1
L_0B63	dta $00,$0A,$45,$58,$50,$4C,$4F,$44,$45,$0D,$57,$2E
;asc	dta $00,$0A,c"EXPLODE",$0D,c"W."
;vid	dta d" *",$45,$58,$50,$4C,$4F,$44,$45,d"-",$57,d"N"
L_0B6F	dta $31,$0D,$00,$00,$AA,$00,$50,$CC,$A0,$A8,$A8,$E4,$D8,$55,$00,$54
;asc	dta c"1",$0D,$00,$00,c"*"*,$00,c"P",c"L ((dX"*,c"U",$00,c"T"
;vid	dta d"Q-  ",d"J"*,d" ",$50,$CC,d"@HHd"*,$D8,$55,d" ",$54
		dta $03,$06,$50,$0C,$A0,$AC,$AC,$A0,$54,$0C,$A0,$AA,$E4,$D8,$5D,$08
;asc	dta $03,$06,c"P",$0C,c" ,, "*,c"T",$0C,c" *dX"*,c"]",$08
;vid	dta d"#&",$50,d",",d"@LL@"*,$54,d",",d"@Jd"*,$D8,$5D,d"("
		dta $E4,$D8,$00,$00,$00,$00,$0E,$0C,$01,$0C,$08,$05,$00,$06,$0C,$05
;asc	dta c"dX"*,$00,$00,$00,$00,$0E,$0C,$01,$0C,$08,$05,$00,$06,$0C,$05
;vid	dta d"d"*,$D8,d"    .,!,(% &,%"
		dta $00,$01,$0C,$09,$01,$0C,$02,$0A,$0A,$0A,$55,$0C,$02,$0A,$06,$0C
;asc	dta $00,$01,$0C,$09,$01,$0C,$02,$0A,$0A,$0A,c"U",$0C,$02,$0A,$06,$0C
;vid	dta d" !,)!,""***",$55,d",""*&,"
		dta $01,$08,$06,$0C,$00,$00
;asc	dta $01,$08,$06,$0C,$00,$00
;vid	dta d"!(&,  "
L_0BB5	dta $5C,$F8,$00,$00,$50,$BC,$14,$3C,$00,$00,$00,$00,$00,$00,$00,$54
;asc	dta c"\",c"x"*,$00,$00,c"P",c"<"*,$14,c"<",$00,$00,$00,$00,$00,$00,$00,c"T"
;vid	dta $5C,d"x"*,d"  ",$50,d"\"*,d"4\       ",$54
		dta $FC,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta c"|"*,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"|"*,d"               "
		dta $FC,$A8,$01,$FF,$A8,$00,$FD,$0A,$55,$FF,$00,$D4,$BD,$0F,$7E,$E8
;asc	dta c"|("*,$01,$FF,c"("*,$00,c"}"*,$0A,c"U",$FF,$00,c"T="*,$0F,c"~",c"h"*
;vid	dta d"|H"*,d"!",$FF,d"H"*,d" ",d"}"*,d"*",$55,$FF,d" ",$D4,d"]"*,d"/~",d"h"*
		dta $05,$5F,$FF,$0F,$D4,$BD,$0F,$7E,$E8,$55,$FF,$B4,$0B,$15,$FE,$00
;asc	dta $05,c"_",$FF,$0F,c"T="*,$0F,c"~",c"h"*,c"U",$FF,c"4"*,$0B,$15,c"~"*,$00
;vid	dta d"%",$5F,$FF,d"/",$D4,d"]"*,d"/~",d"h"*,$55,$FF,d"T"*,d"+5",d"~"*,d" "
		dta $54,$AA,$FF,$AA,$00,$15,$FF,$D5,$AB,$00,$55,$FF,$00,$FF,$AA,$00
;asc	dta c"T",c"*"*,$FF,c"*"*,$00,$15,$FF,c"U+"*,$00,c"U",$FF,$00,$FF,c"*"*,$00
;vid	dta $54,d"J"*,$FF,d"J"*,d" 5",$FF,$D5,d"K"*,d" ",$55,$FF,d" ",$FF,d"J"*,d" "
		dta $40,$C0,$00,$55,$FF,$00,$FF,$AA,$00,$55,$FF,$55,$FF,$00,$00,$00
;asc	dta c"@",c"@"*,$00,c"U",$FF,$00,$FF,c"*"*,$00,c"U",$FF,c"U",$FF,$00,$00,$00
;vid	dta $40,$C0,d" ",$55,$FF,d" ",$FF,d"J"*,d" ",$55,$FF,$55,$FF,d"   "
		dta $7F,$EA,$BF,$00,$3F,$2A,$00,$00,$1F,$3F,$00,$00,$15,$3F,$00,$05
;asc	dta $7F,c"j?"*,$00,c"?*",$00,$00,$1F,c"?",$00,$00,$15,c"?",$00,$05
;vid	dta $7F,d"j_"*,d" _J  ?_  5_ %"
		dta $1F,$3C,$2F,$0A,$00,$05,$3F,$3C,$05,$1F,$3C,$2F,$0A,$15,$3F,$00
;asc	dta $1F,c"</",$0A,$00,$05,c"?<",$05,$1F,c"</",$0A,$15,c"?",$00
;vid	dta d"?\O* %_\%?\O*5_ "
		dta $00,$00,$05,$FF,$0A,$00,$3F,$2A,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$05,$FF,$0A,$00,c"?*",$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"  %",$FF,d"* _J        "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$14,$3D,$0B,$00,$00,$00,$00,$54,$FC,$FC,$FC,$F8,$E0
;asc	dta $00,$00,$00,$14,c"=",$0B,$00,$00,$00,$00,c"T",c"|||x`"*
;vid	dta d"   4]+    ",$54,d"|||x`"*
		dta $00,$00,$00,$00,$00,$00,$00,$FD,$AF,$0A,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,c"}/"*,$0A,$00,$00,$00,$00,$00,$00
;vid	dta d"       ",d"}O"*,d"*      "
		dta $00,$00,$00,$00,$00,$00,$FC,$A8,$00,$FC,$A8,$55,$FF,$00,$00,$07
;asc	dta $00,$00,$00,$00,$00,$00,c"|("*,$00,c"|("*,c"U",$FF,$00,$00,$07
;vid	dta d"      ",d"|H"*,d" ",d"|H"*,$55,$FF,d"  '"
		dta $FF,$A8,$D4,$BD,$0F,$7E,$E8,$05,$FF,$AF,$0A,$D4,$BD,$0F,$7E,$E8
;asc	dta $FF,c"(T="*,$0F,c"~",c"h"*,$05,$FF,c"/"*,$0A,c"T="*,$0F,c"~",c"h"*
;vid	dta $FF,d"H"*,$D4,d"]"*,d"/~",d"h"*,d"%",$FF,d"O"*,d"*",$D4,d"]"*,d"/~",d"h"*
		dta $10,$3D,$0F,$5F,$FC,$00,$0F,$FF,$AF,$0A,$FF,$AA,$55,$FF,$00,$00
;asc	dta $10,c"=",$0F,c"_",c"|"*,$00,$0F,$FF,c"/"*,$0A,$FF,c"*"*,c"U",$FF,$00,$00
;vid	dta d"0]/",$5F,d"|"*,d" /",$FF,d"O"*,d"*",$FF,d"J"*,$55,$FF,d"  "
		dta $D0,$FF,$2A,$FF,$AF,$0F,$4F,$CF,$00,$FF,$AA,$00,$FF,$AF,$0F,$4F
;asc	dta c"P"*,$FF,c"*",$FF,c"/"*,$0F,c"O",c"O"*,$00,$FF,c"*"*,$00,$FF,c"/"*,$0F,c"O"
;vid	dta $D0,$FF,d"J",$FF,d"O"*,d"/",$4F,$CF,d" ",$FF,d"J"*,d" ",$FF,d"O"*,d"/",$4F
		dta $CF,$50,$FC,$0B,$57,$FF,$00,$00,$FF,$AA,$00,$3F,$2A,$15,$3F,$3F
;asc	dta c"O"*,c"P",c"|"*,$0B,c"W",$FF,$00,$00,$FF,c"*"*,$00,c"?*",$15,c"??"
;vid	dta $CF,$50,d"|"*,d"+",$57,$FF,d"  ",$FF,d"J"*,d" _J5__"
		dta $3F,$2F,$0B,$00,$05,$1F,$3C,$2F,$0A,$00,$3F,$2A,$00,$05,$1F,$3C
;asc	dta c"?/",$0B,$00,$05,$1F,c"</",$0A,$00,c"?*",$00,$05,$1F,c"<"
;vid	dta d"_O+ %?\O* _J %?\"
		dta $2F,$0A,$05,$3F,$3C,$1F,$3F,$00,$00,$1F,$3E,$28,$3F,$2A
;asc	dta c"/",$0A,$05,c"?<",$1F,c"?",$00,$00,$1F,c">(?*"
;vid	dta d"O*%_\?_  ?^H_J"
L_0CE3	dta $00,$33,$CC,$FF,$00,$30,$C0,$F0,$00,$03,$0C,$0F
;asc	dta $00,c"3",c"L"*,$FF,$00,c"0",c"@p"*,$00,$03,$0C,$0F
;vid	dta d" S",$CC,$FF,d" P",$C0,d"p"*,d" #,/"
L_0CEF	dta $00			;0CEF 00    
L_0CF0	dta $03			;0CF0 03   #
L_0CF1	dta $0C			;0CF1 0C   ,
L_0CF2	dta $0F,$00,$06,$06,$00,$09,$66,$66,$09,$99,$06,$06,$99
;asc	dta $0F,$00,$06,$06,$00,$09,c"ff",$09,$99,$06,$06,$99
;vid	dta d"/ && )ff)",d"9"*,d"&&",d"9"*
;
		org $0E00
;
L_0E00	jmp L_0E1D		;0E00 4C 1D 0E
L_0E03	lda #$00		;0E03 A9 00
		sta ZP_70		;0E05 85 70
		lda #$30		;0E07 A9 30
		sta ZP_71		;0E09 85 71
		lda #$00		;0E0B A9 00
		ldy #$00		;0E0D A0 00
L_0E0F	sta (ZP_70),Y	;0E0F 91 70
		dey				;0E11 88
		bne L_0E0F		;0E12 D0 FB
		inc ZP_71		;0E14 E6 71
		ldx ZP_71		;0E16 A6 71
		cpx #$80		;0E18 E0 80
		bne L_0E0F		;0E1A D0 F3
		rts				;0E1C 60
L_0E1D	sei				;0E1D 78
		lda L_0204		;0E1E AD 04 02
		sta L_0EE3		;0E21 8D E3 0E
		lda L_0205		;0E24 AD 05 02
		sta L_0EE4		;0E27 8D E4 0E
		lda #$52		;0E2A A9 52
		sta L_0204		;0E2C 8D 04 02
		lda #$0E		;0E2F A9 0E
		sta L_0205		;0E31 8D 05 02
		lda #$20		;0E34 A9 20
		sta L_FE6E		;0E36 8D 6E FE
		sta L_FE6D		;0E39 8D 6D FE
		lda #$04		;0E3C A9 04
		sta L_FE6C		;0E3E 8D 6C FE
		lda #$00		;0E41 A9 00
		sta L_FE6B		;0E43 8D 6B FE
		lda #$FE		;0E46 A9 FE
		sta L_FE44		;0E48 8D 44 FE
		lda #$26		;0E4B A9 26
		sta L_FE45		;0E4D 8D 45 FE
		cli				;0E50 58
		rts				;0E51 60
L_0E52	lda L_FE4D		;0E52 AD 4D FE
		and #$02		;0E55 29 02
		beq L_0E72		;0E57 F0 19
		lda L_0EDF		;0E59 AD DF 0E
		sta L_FE68		;0E5C 8D 68 FE
		lda L_0EE0		;0E5F AD E0 0E
		sta L_FE69		;0E62 8D 69 FE
		lda #$A0		;0E65 A9 A0
		sta L_FE6E		;0E67 8D 6E FE
		lda L_0EE7		;0E6A AD E7 0E
		beq L_0E6F		;0E6D F0 00
L_0E6F	jmp (L_0EE3)	;0E6F 6C E3 0E
L_0E72	lda L_FE6D		;0E72 AD 6D FE
		and #$20		;0E75 29 20
		beq L_0E6F		;0E77 F0 F6
		sta L_FE6D		;0E79 8D 6D FE
		lda L_0EE7		;0E7C AD E7 0E
		beq L_0E6F		;0E7F F0 EE
		lda L_0EE5		;0E81 AD E5 0E
		bne L_0EAF		;0E84 D0 29
		inc L_0EE5		;0E86 EE E5 0E
		inc L_0EE6		;0E89 EE E6 0E
		lda #$A4		;0E8C A9 A4
		jsr L_0EC9		;0E8E 20 C9 0E
		lda #$20		;0E91 A9 20
		jsr L_0EC9		;0E93 20 C9 0E
		lda #$85		;0E96 A9 85
		jsr L_0EC9		;0E98 20 C9 0E
		lda L_0EE1		;0E9B AD E1 0E
		sta L_FE68		;0E9E 8D 68 FE
		lda L_0EE2		;0EA1 AD E2 0E
		sta L_FE69		;0EA4 8D 69 FE
		lda #$A0		;0EA7 A9 A0
		sta L_FE6E		;0EA9 8D 6E FE
		jmp (L_0EE3)	;0EAC 6C E3 0E
L_0EAF	lda L_0EDC		;0EAF AD DC 0E
		jsr L_0EC9		;0EB2 20 C9 0E
		lda L_0EDD		;0EB5 AD DD 0E
		jsr L_0EC9		;0EB8 20 C9 0E
		lda L_0EDE		;0EBB AD DE 0E
		jsr L_0EC9		;0EBE 20 C9 0E
		lda #$00		;0EC1 A9 00
		sta L_0EE5		;0EC3 8D E5 0E
		jmp (L_0EE3)	;0EC6 6C E3 0E
L_0EC9	sta L_FE21		;0EC9 8D 21 FE
		eor #$10		;0ECC 49 10
		sta L_FE21		;0ECE 8D 21 FE
		eor #$40		;0ED1 49 40
		sta L_FE21		;0ED3 8D 21 FE
		eor #$10		;0ED6 49 10
		sta L_FE21		;0ED8 8D 21 FE
		rts				;0EDB 60
L_0EDC	dta $26			;0EDC 26 & F
L_0EDD	dta $A1			;0EDD A1 ! A
L_0EDE	dta $85			;0EDE 85   %
L_0EDF	dta $BE			;0EDF BE > ^
L_0EE0	dta $3F			;0EE0 3F ? _
L_0EE1	dta $1E			;0EE1 1E   >
L_0EE2	dta $07			;0EE2 07   '
L_0EE3	dta $00			;0EE3 00    
L_0EE4	dta $00			;0EE4 00    
L_0EE5	dta $00			;0EE5 00    
L_0EE6	dta $00			;0EE6 00    
L_0EE7	dta $00,$74,$7C,$74,$6C,$74,$80,$94,$07,$04,$07,$07,$07,$08,$10,$00
;asc	dta $00,c"t|tlt",$80,$94,$07,$04,$07,$07,$07,$08,$10,$00
;vid	dta d" t|tlt",d" 4"*,d"'$'''(0 "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$44,$AA,$AA,$AA,$AA,$AA,$44
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,c"D",c"*****"*,c"D"
;vid	dta d"         ",$44,d"JJJJJ"*,$44
		dta $00,$44,$CC,$44,$44,$44,$44,$EE,$00,$44,$AA,$22,$44,$88,$88,$EE
;asc	dta $00,c"D",c"L"*,c"DDDD",c"n"*,$00,c"D",c"*"*,c"""D",$88,$88,c"n"*
;vid	dta d" ",$44,$CC,$44,$44,$44,$44,d"n"*,d" ",$44,d"J"*,d"B",$44,d"((n"*
		dta $00,$CC,$22,$22,$CC,$22,$22,$CC,$00,$88,$88,$88,$88,$AA,$EE,$22
;asc	dta $00,c"L"*,c"""""",c"L"*,c"""""",c"L"*,$00,$88,$88,$88,$88,c"*n"*,c""""
;vid	dta d" ",$CC,d"BB",$CC,d"BB",$CC,d" ",d"((((Jn"*,d"B"
		dta $00,$EE,$88,$88,$CC,$22,$AA,$44,$00,$66,$88,$88,$CC,$AA,$AA,$44
;asc	dta $00,c"n"*,$88,$88,c"L"*,c"""",c"*"*,c"D",$00,c"f",$88,$88,c"L**"*,c"D"
;vid	dta d" ",d"n(("*,$CC,d"B",d"J"*,$44,d" f",d"(("*,$CC,d"JJ"*,$44
		dta $00,$EE,$22,$22,$44,$44,$44,$44,$00,$44,$AA,$AA,$44,$AA,$AA,$44
;asc	dta $00,c"n"*,c"""""DDDD",$00,c"D",c"**"*,c"D",c"**"*,c"D"
;vid	dta d" ",d"n"*,d"BB",$44,$44,$44,$44,d" ",$44,d"JJ"*,$44,d"JJ"*,$44
		dta $00,$44,$AA,$AA,$66,$22,$22,$CC,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,c"D",c"**"*,c"f""""",c"L"*,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d" ",$44,d"JJ"*,d"fBB",$CC,d"        "
		dta $00,$99,$99,$99,$99,$99,$99,$77,$00,$66,$44,$00,$00,$00,$44,$66
;asc	dta $00,$99,$99,$99,$99,$99,$99,c"w",$00,c"fD",$00,$00,$00,c"Df"
;vid	dta d" ",d"999999"*,d"w f",$44,d"   ",$44,d"f"
		dta $00,$33,$11,$00,$00,$00,$11,$33,$00,$90,$C8,$00,$38,$70,$A8,$E0
;asc	dta $00,c"3",$11,$00,$00,$00,$11,c"3",$00,$90,c"H"*,$00,c"8p",c"(`"*
;vid	dta d" S1   1S ",d"0"*,$C8,d" Xp",d"H`"*
		dta $18,$50,$88,$C0,$F8,$30,$68,$A0,$D8,$10,$48,$80,$B8,$F0,$28,$60
;asc	dta $18,c"P",$88,c"@x"*,c"0h",c" X"*,$10,c"H",$80,c"8p"*,c"(`"
;vid	dta d"8",$50,d"("*,$C0,d"x"*,d"Ph",d"@"*,$D8,d"0",$48,d" Xp"*,d"H`"
		dta $98,$D0,$08,$40,$78,$B0,$E8,$20,$58,$34,$34,$35,$35,$35,$35,$35
;asc	dta $98,c"P"*,$08,c"@x",c"0h"*,c" X4455555"
;vid	dta d"8"*,$D0,d"(",$40,d"x",d"Ph"*,d"@",$58,d"TTUUUUU"
		dta $36,$36,$36,$36,$36,$37,$37,$37,$37,$31,$31,$31,$31,$31,$32,$32
;asc	dta c"6666677771111122"
;vid	dta d"VVVVVWWWWQQQQQRR"
		dta $32,$32,$33,$33,$33,$33,$33,$34,$34,$00,$01,$04,$09,$10,$19,$24
;asc	dta c"223333344",$00,$01,$04,$09,$10,$19,c"$"
;vid	dta d"RRSSSSSTT !$)09D"
		dta $31,$40,$51,$64,$79,$90,$A9,$C4,$E1,$53,$2E,$31,$0D,$4C,$2E,$31
;asc	dta c"1@Qdy",$90,c")Da"*,c"S.1",$0D,c"L.1"
;vid	dta d"Q",$40,$51,d"dy",d"0I"*,$C4,d"a"*,$53,d"NQ-",$4C,d"NQ"
		dta $0D,$A9,$FF,$8D,$60,$30,$A9,$3D,$85,$70,$A9,$1F,$85,$77,$A9,$9D
;asc	dta $0D,c")"*,$FF,$8D,c"`0",c")"*,c"=",$85,c"p",c")"*,$1F,$85,c"w",c")"*,$9D
;vid	dta d"-",d"I"*,$FF,d"-"*,d"`P",d"I"*,d"]",d"%"*,d"p",d"I"*,d"?",d"%"*,d"w",d"I="*
		dta $85,$74,$A9,$30,$85,$75,$A2,$00,$4C,$08,$2A,$A9,$F0,$8D,$60,$30
;asc	dta $85,c"t",c")"*,c"0",$85,c"u",c""""*,$00,c"L",$08,c"*",c")p"*,$8D,c"`0"
;vid	dta d"%"*,d"t",d"I"*,d"P",d"%"*,d"u",d"B"*,d" ",$4C,d"(J",d"Ip-"*,d"`P"
		dta $A9,$08,$85,$70,$A9,$1D,$85,$77,$A9,$08,$85,$74,$A9,$30,$85,$75
;asc	dta c")"*,$08,$85,c"p",c")"*,$1D,$85,c"w",c")"*,$08,$85,c"t",c")"*,c"0",$85,c"u"
;vid	dta d"I"*,d"(",d"%"*,d"p",d"I"*,d"=",d"%"*,d"w",d"I"*,d"(",d"%"*,d"t",d"I"*,d"P",d"%"*,d"u"
		dta $A2,$00,$4C,$08,$2A,$00,$00,$00,$00,$00,$00,$00,$00,$14,$15,$22
;asc	dta c""""*,$00,c"L",$08,c"*",$00,$00,$00,$00,$00,$00,$00,$00,$14,$15,c""""
;vid	dta d"B"*,d" ",$4C,d"(J        45B"
		dta $35,$20,$23,$28,$40,$37,$43,$55,$75,$15,$18,$21,$24,$21,$23,$25
;asc	dta c"5 #(@7CUu",$15,$18,c"!$!#%"
;vid	dta d"U@CH",$40,d"W",$43,$55,d"u58ADACE"
		dta $27,$25,$27,$29,$31,$48,$5A,$6E,$90,$84,$90,$9C,$A9,$9C,$B6,$D2
;asc	dta c"'%')1HZn",$90,$84,$90,$9C,c")"*,$9C,c"6R"*
;vid	dta d"GEGIQ",$48,$5A,d"n",d"0$0<I<V"*,$D2
		dta $F0,$02,$03,$05,$07,$00,$00,$00,$01,$06,$11,$17,$25,$00,$00,$00
;asc	dta c"p"*,$02,$03,$05,$07,$00,$00,$00,$01,$06,$11,$17,c"%",$00,$00,$00
;vid	dta d"p"*,d"""#%'   !&17E   "
		dta $01,$04,$07,$10,$15,$01,$02,$04,$07,$16,$15,$14,$13,$20,$17,$15
;asc	dta $01,$04,$07,$10,$15,$01,$02,$04,$07,$16,$15,$14,$13,c" ",$17,$15
;vid	dta d"!$'05!""$'6543@75"
		dta $12,$30,$27,$22,$18,$63,$67,$71,$77,$50,$59,$67,$83,$33,$37,$45
;asc	dta $12,c"0'""",$18,c"cgqwPYg",$83,c"37E"
;vid	dta d"2PGB8cgqw",$50,$59,d"g",d"#"*,d"SW",$45
		dta $56,$22,$2F,$72,$2D,$02,$2E,$92,$2E,$01,$10,$11,$00,$0A,$45,$58
;asc	dta c"V""/r-",$02,c".",$92,c".",$01,$10,$11,$00,$0A,c"EX"
;vid	dta $56,d"BOrM""N",d"2"*,d"N!01 *",$45,$58
		dta $50,$4C,$4F,$44,$45,$0D,$57,$2E,$31,$0D,$00,$00,$AA,$00,$50,$CC
;asc	dta c"PLODE",$0D,c"W.1",$0D,$00,$00,c"*"*,$00,c"P",c"L"*
;vid	dta $50,$4C,$4F,$44,$45,d"-",$57,d"NQ-  ",d"J"*,d" ",$50,$CC
		dta $A0,$A8,$A8,$E4,$D8,$55,$00,$54,$03,$06,$50,$0C,$A0,$AC,$AC,$A0
;asc	dta c" ((dX"*,c"U",$00,c"T",$03,$06,c"P",$0C,c" ,, "*
;vid	dta d"@HHd"*,$D8,$55,d" ",$54,d"#&",$50,d",",d"@LL@"*
		dta $54,$0C,$A0,$AA,$E4,$D8,$5D,$08,$E4,$D8,$00,$00,$00,$00,$0E,$0C
;asc	dta c"T",$0C,c" *dX"*,c"]",$08,c"dX"*,$00,$00,$00,$00,$0E,$0C
;vid	dta $54,d",",d"@Jd"*,$D8,$5D,d"(",d"d"*,$D8,d"    .,"
		dta $01,$0C,$08,$05,$00,$06,$0C,$05,$00,$01,$0C,$09,$01,$0C,$02,$0A
;asc	dta $01,$0C,$08,$05,$00,$06,$0C,$05,$00,$01,$0C,$09,$01,$0C,$02,$0A
;vid	dta d"!,(% &,% !,)!,""*"
		dta $0A,$0A,$55,$0C,$02,$0A,$06,$0C,$01,$08,$06,$0C,$00,$00,$5C,$F8
;asc	dta $0A,$0A,c"U",$0C,$02,$0A,$06,$0C,$01,$08,$06,$0C,$00,$00,c"\",c"x"*
;vid	dta d"**",$55,d",""*&,!(&,  ",$5C,d"x"*
		dta $00,$00,$50,$BC,$14,$3C,$00,$00,$00,$00,$00,$00,$00,$54,$FC,$00
;asc	dta $00,$00,c"P",c"<"*,$14,c"<",$00,$00,$00,$00,$00,$00,$00,c"T",c"|"*,$00
;vid	dta d"  ",$50,d"\"*,d"4\       ",$54,d"|"*,d" "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$FC,$A8
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,c"|("*
;vid	dta d"              ",d"|H"*
		dta $01,$FF,$A8,$00,$FD,$0A,$55,$FF,$00,$D4,$BD,$0F,$7E,$E8,$05,$5F
;asc	dta $01,$FF,c"("*,$00,c"}"*,$0A,c"U",$FF,$00,c"T="*,$0F,c"~",c"h"*,$05,c"_"
;vid	dta d"!",$FF,d"H"*,d" ",d"}"*,d"*",$55,$FF,d" ",$D4,d"]"*,d"/~",d"h"*,d"%",$5F
		dta $FF,$0F,$D4,$BD,$0F,$7E,$E8,$55,$FF,$B4,$0B,$15,$FE,$00,$54,$AA
;asc	dta $FF,$0F,c"T="*,$0F,c"~",c"h"*,c"U",$FF,c"4"*,$0B,$15,c"~"*,$00,c"T",c"*"*
;vid	dta $FF,d"/",$D4,d"]"*,d"/~",d"h"*,$55,$FF,d"T"*,d"+5",d"~"*,d" ",$54,d"J"*
		dta $FF,$AA,$00,$15,$FF,$D5,$AB,$00,$55,$FF,$00,$FF,$AA,$00,$40,$C0
;asc	dta $FF,c"*"*,$00,$15,$FF,c"U+"*,$00,c"U",$FF,$00,$FF,c"*"*,$00,c"@",c"@"*
;vid	dta $FF,d"J"*,d" 5",$FF,$D5,d"K"*,d" ",$55,$FF,d" ",$FF,d"J"*,d" ",$40,$C0
		dta $00,$55,$FF,$00,$FF,$AA,$00,$55,$FF,$55,$FF,$00,$00,$00,$7F,$EA
;asc	dta $00,c"U",$FF,$00,$FF,c"*"*,$00,c"U",$FF,c"U",$FF,$00,$00,$00,$7F,c"j"*
;vid	dta d" ",$55,$FF,d" ",$FF,d"J"*,d" ",$55,$FF,$55,$FF,d"   ",$7F,d"j"*
		dta $BF,$00,$3F,$2A,$00,$00,$1F,$3F,$00,$00,$15,$3F,$00,$05,$1F,$3C
;asc	dta c"?"*,$00,c"?*",$00,$00,$1F,c"?",$00,$00,$15,c"?",$00,$05,$1F,c"<"
;vid	dta d"_"*,d" _J  ?_  5_ %?\"
		dta $2F,$0A,$00,$05,$3F,$3C,$05,$1F,$3C,$2F,$0A,$15,$3F,$00,$00,$00
;asc	dta c"/",$0A,$00,$05,c"?<",$05,$1F,c"</",$0A,$15,c"?",$00,$00,$00
;vid	dta d"O* %_\%?\O*5_   "
		dta $05,$FF,$0A,$00,$3F,$2A,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $05,$FF,$0A,$00,c"?*",$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"%",$FF,d"* _J          "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$14,$3D,$0B,$00,$00,$00,$00,$54,$FC,$FC,$FC,$F8,$E0,$00,$00
;asc	dta $00,$14,c"=",$0B,$00,$00,$00,$00,c"T",c"|||x`"*,$00,$00
;vid	dta d" 4]+    ",$54,d"|||x`"*,d"  "
		dta $00,$00,$00,$00,$00,$FD,$AF,$0A,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,c"}/"*,$0A,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"     ",d"}O"*,d"*        "
		dta $00,$00,$00,$00,$FC,$A8,$00,$FC,$A8,$55,$FF,$00,$00,$07,$FF,$A8
;asc	dta $00,$00,$00,$00,c"|("*,$00,c"|("*,c"U",$FF,$00,$00,$07,$FF,c"("*
;vid	dta d"    ",d"|H"*,d" ",d"|H"*,$55,$FF,d"  '",$FF,d"H"*
		dta $D4,$BD,$0F,$7E,$E8,$05,$FF,$AF,$0A,$D4,$BD,$0F,$7E,$E8,$10,$3D
;asc	dta c"T="*,$0F,c"~",c"h"*,$05,$FF,c"/"*,$0A,c"T="*,$0F,c"~",c"h"*,$10,c"="
;vid	dta $D4,d"]"*,d"/~",d"h"*,d"%",$FF,d"O"*,d"*",$D4,d"]"*,d"/~",d"h"*,d"0]"
		dta $0F,$5F,$FC,$00,$0F,$FF,$AF,$0A,$FF,$AA,$55,$FF,$00,$00,$D0,$FF
;asc	dta $0F,c"_",c"|"*,$00,$0F,$FF,c"/"*,$0A,$FF,c"*"*,c"U",$FF,$00,$00,c"P"*,$FF
;vid	dta d"/",$5F,d"|"*,d" /",$FF,d"O"*,d"*",$FF,d"J"*,$55,$FF,d"  ",$D0,$FF
		dta $2A,$FF,$AF,$0F,$4F,$CF,$00,$FF,$AA,$00,$FF,$AF,$0F,$4F,$CF,$50
;asc	dta c"*",$FF,c"/"*,$0F,c"O",c"O"*,$00,$FF,c"*"*,$00,$FF,c"/"*,$0F,c"O",c"O"*,c"P"
;vid	dta d"J",$FF,d"O"*,d"/",$4F,$CF,d" ",$FF,d"J"*,d" ",$FF,d"O"*,d"/",$4F,$CF,$50
		dta $FC,$0B,$57,$FF,$00,$00,$FF,$AA,$00,$3F,$2A,$15,$3F,$3F,$3F,$2F
;asc	dta c"|"*,$0B,c"W",$FF,$00,$00,$FF,c"*"*,$00,c"?*",$15,c"???/"
;vid	dta d"|"*,d"+",$57,$FF,d"  ",$FF,d"J"*,d" _J5___O"
		dta $0B,$00,$05,$1F,$3C,$2F,$0A,$00,$3F,$2A,$00,$05,$1F,$3C,$2F,$0A
;asc	dta $0B,$00,$05,$1F,c"</",$0A,$00,c"?*",$00,$05,$1F,c"</",$0A
;vid	dta d"+ %?\O* _J %?\O*"
		dta $05,$3F,$3C,$1F,$3F,$00,$00,$1F,$3E,$28,$3F,$2A,$00,$33,$CC,$FF
;asc	dta $05,c"?<",$1F,c"?",$00,$00,$1F,c">(?*",$00,c"3",c"L"*,$FF
;vid	dta d"%_\?_  ?^H_J S",$CC,$FF
		dta $00,$30,$C0,$F0,$00,$03,$0C,$0F,$00,$03,$0C,$0F,$00,$06,$06,$00
;asc	dta $00,c"0",c"@p"*,$00,$03,$0C,$0F,$00,$03,$0C,$0F,$00,$06,$06,$00
;vid	dta d" P",$C0,d"p"*,d" #,/ #,/ && "
		dta $09,$66,$66,$09,$99,$06,$06,$99
;asc	dta $09,c"ff",$09,$99,$06,$06,$99
;vid	dta d")ff)",d"9"*,d"&&",d"9"*
;
		org $1B00
;
L_1B00	lda #$01		;1B00 A9 01
		sta L_09E7		;1B02 8D E7 09
		jsr L_2C22		;1B05 20 22 2C
		lda #$00		;1B08 A9 00
		sta L_3000		;1B0A 8D 00 30
		sta L_3001		;1B0D 8D 01 30
		sta L_3002		;1B10 8D 02 30
		sta L_3003		;1B13 8D 03 30
		sta L_3006		;1B16 8D 06 30
		sta L_3007		;1B19 8D 07 30
		lda #$A1		;1B1C A9 A1
		sta L_3004		;1B1E 8D 04 30
L_1B21	jsr L_293F		;1B21 20 3F 29
		jsr L_28F5		;1B24 20 F5 28
		jsr L_2C39		;1B27 20 39 2C
		ldx #$0F		;1B2A A2 0F
		lda #$00		;1B2C A9 00
L_1B2E	sta L_3850,X	;1B2E 9D 50 38
		dex				;1B31 CA
		bpl L_1B2E		;1B32 10 FA
		lda L_3005		;1B34 AD 05 30
		and #$07		;1B37 29 07
		asl @			;1B39 0A
		asl @			;1B3A 0A
		tax				;1B3B AA
		lda L_1EB7,X	;1B3C BD B7 1E
		sta L_3009		;1B3F 8D 09 30
		lda L_1EB8,X	;1B42 BD B8 1E
		sta L_300A		;1B45 8D 0A 30
		lda L_1EB9,X	;1B48 BD B9 1E
		sta L_300B		;1B4B 8D 0B 30
		lda #$20		;1B4E A9 20
		sta L_3008		;1B50 8D 08 30
		ldx L_3FFE		;1B53 AE FE 3F
		lda #$64		;1B56 A9 64
		sta L_3061		;1B58 8D 61 30
L_1B5B	txa				;1B5B 8A
		pha				;1B5C 48
		jsr L_216E		;1B5D 20 6E 21
		lda L_3061		;1B60 AD 61 30
		clc				;1B63 18
		adc #$08		;1B64 69 08
		sta L_3061		;1B66 8D 61 30
		tax				;1B69 AA
		ldy #$05		;1B6A A0 05
		lda #$13		;1B6C A9 13
		jsr L_2699		;1B6E 20 99 26
		lda #$0B		;1B71 A9 0B
		jsr L_1EDA		;1B73 20 DA 1E
		pla				;1B76 68
		tax				;1B77 AA
		dex				;1B78 CA
		bpl L_1B5B		;1B79 10 E0
		ldx #$00		;1B7B A2 00
		stx L_3062		;1B7D 8E 62 30
		stx L_3063		;1B80 8E 63 30
		stx L_3012		;1B83 8E 12 30
		lda L_3005		;1B86 AD 05 30
		and #$0F		;1B89 29 0F
		ora #$30		;1B8B 09 30
		sta L_0B6F		;1B8D 8D 6F 0B
		lda #$40		;1B90 A9 40
		ldx #$6D		;1B92 A2 6D
		ldy #$0B		;1B94 A0 0B
		jsr L_FFCE		;1B96 20 CE FF
		sta L_307B		;1B99 8D 7B 30
L_1B9C	jsr L_2C94		;1B9C 20 94 2C
		lda #$0F		;1B9F A9 0F
		sta L_3014		;1BA1 8D 14 30
		lda #$FF		;1BA4 A9 FF
		sta L_3061		;1BA6 8D 61 30
		jsr L_293F		;1BA9 20 3F 29
		jsr L_28F5		;1BAC 20 F5 28
		ldx #$00		;1BAF A2 00
		lda #$00		;1BB1 A9 00
L_1BB3	sta L_3490,X	;1BB3 9D 90 34
		sta L_3570,X	;1BB6 9D 70 35
		sta L_3650,X	;1BB9 9D 50 36
		sta L_3730,X	;1BBC 9D 30 37
		inx				;1BBF E8
		cpx #$E0		;1BC0 E0 E0
		bne L_1BB3		;1BC2 D0 EF
		jsr L_29B0		;1BC4 20 B0 29
		jsr L_0AE2		;1BC7 20 E2 0A
		jsr L_2996		;1BCA 20 96 29
		jsr L_295D		;1BCD 20 5D 29
		jsr L_0AC8		;1BD0 20 C8 0A
		lda #$00		;1BD3 A9 00
		sta L_300F		;1BD5 8D 0F 30
		lda #$39		;1BD8 A9 39
		sta L_3010		;1BDA 8D 10 30
		lda #$01		;1BDD A9 01
		sta L_300D		;1BDF 8D 0D 30
		lda L_308B		;1BE2 AD 8B 30
		sta L_300E		;1BE5 8D 0E 30
		lda #$FF		;1BE8 A9 FF
		sta L_307D		;1BEA 8D 7D 30
		ldx #$0F		;1BED A2 0F
		lda #$00		;1BEF A9 00
L_1BF1	sta L_3840,X	;1BF1 9D 40 38
		sta L_3830,X	;1BF4 9D 30 38
		sta L_3820,X	;1BF7 9D 20 38
		sta L_3810,X	;1BFA 9D 10 38
		dex				;1BFD CA
		bpl L_1BF1		;1BFE 10 F1
		lda #$FE		;1C00 A9 FE
		sta ZP_70		;1C02 85 70
		lda #$3F		;1C04 A9 3F
		sta ZP_71		;1C06 85 71
L_1C08	ldy #$01		;1C08 A0 01
		lda (ZP_70),Y	;1C0A B1 70
		cmp #$FF		;1C0C C9 FF
		bne L_1C20		;1C0E D0 10
		lda ZP_70		;1C10 A5 70
		sec				;1C12 38
		sbc #$02		;1C13 E9 02
		sta ZP_70		;1C15 85 70
		lda ZP_71		;1C17 A5 71
		sbc #$00		;1C19 E9 00
		sta ZP_71		;1C1B 85 71
		jmp L_1C08		;1C1D 4C 08 1C
L_1C20	sta L_3016		;1C20 8D 16 30
		dey				;1C23 88
		lda (ZP_70),Y	;1C24 B1 70
		sta L_3015		;1C26 8D 15 30
		lda #$03		;1C29 A9 03
		sta ZP_88		;1C2B 85 88
L_1C2D	ldx ZP_88		;1C2D A6 88
		lda L_308D,X	;1C2F BD 8D 30
		sta L_0AC2		;1C32 8D C2 0A
		jsr L_296E		;1C35 20 6E 29
		lda #$B0		;1C38 A9 B0
		sta ZP_70		;1C3A 85 70
		lda #$33		;1C3C A9 33
		sta ZP_71		;1C3E 85 71
		lda ZP_88		;1C40 A5 88
		asl @			;1C42 0A
		asl @			;1C43 0A
		tax				;1C44 AA
		lda L_0A70,X	;1C45 BD 70 0A
		sta ZP_72		;1C48 85 72
		lda L_0A90,X	;1C4A BD 90 0A
		sta ZP_73		;1C4D 85 73
		ldy #$DF		;1C4F A0 DF
		lda #$00		;1C51 A9 00
		sta (ZP_72),Y	;1C53 91 72
L_1C55	lda ZP_88		;1C55 A5 88
		asl @			;1C57 0A
		adc ZP_88		;1C58 65 88
		adc #$02		;1C5A 69 02
		sta ZP_87		;1C5C 85 87
		lda #$02		;1C5E A9 02
		sta ZP_86		;1C60 85 86
L_1C62	ldx ZP_86		;1C62 A6 86
		lda L_0B60,X	;1C64 BD 60 0B
		sta ZP_80		;1C67 85 80
		lda L_0B62		;1C69 AD 62 0B
		sta ZP_82		;1C6C 85 82
		ldx ZP_87		;1C6E A6 87
		lda L_3091,X	;1C70 BD 91 30
		sta ZP_81		;1C73 85 81
		ldx #$04		;1C75 A2 04
L_1C77	lda (ZP_70),Y	;1C77 B1 70
		and ZP_82		;1C79 25 82
		beq L_1C87		;1C7B F0 0A
		eor ZP_80		;1C7D 45 80
		bne L_1C87		;1C7F D0 06
		lda (ZP_72),Y	;1C81 B1 72
		ora ZP_81		;1C83 05 81
		sta (ZP_72),Y	;1C85 91 72
L_1C87	asl ZP_80		;1C87 06 80
		asl ZP_81		;1C89 06 81
		asl ZP_82		;1C8B 06 82
		dex				;1C8D CA
		bne L_1C77		;1C8E D0 E7
		dec ZP_87		;1C90 C6 87
		dec ZP_86		;1C92 C6 86
		bpl L_1C62		;1C94 10 CC
		lda #$00		;1C96 A9 00
		sta (ZP_70),Y	;1C98 91 70
		dey				;1C9A 88
		bne L_1C55		;1C9B D0 B8
		dec ZP_88		;1C9D C6 88
		bmi L_1CA4		;1C9F 30 03
		jmp L_1C2D		;1CA1 4C 2D 1C
L_1CA4	lda #$01		;1CA4 A9 01
		ldy #$3F		;1CA6 A0 3F
		sta L_309E,Y	;1CA8 99 9E 30
		sty ZP_8D		;1CAB 84 8D
		lda #$10		;1CAD A9 10
		sta ZP_81		;1CAF 85 81
		lda #$D4		;1CB1 A9 D4
		sta ZP_80		;1CB3 85 80
		jsr L_1FB2		;1CB5 20 B2 1F
		inc L_30DD		;1CB8 EE DD 30
		lda #$50		;1CBB A9 50
		sta ZP_81		;1CBD 85 81
		lda #$D4		;1CBF A9 D4
		sta ZP_80		;1CC1 85 80
		jsr L_1FB2		;1CC3 20 B2 1F
		inc L_30DD		;1CC6 EE DD 30
		lda #$90		;1CC9 A9 90
		sta ZP_81		;1CCB 85 81
		lda #$D4		;1CCD A9 D4
		sta ZP_80		;1CCF 85 80
		jsr L_1FB2		;1CD1 20 B2 1F
		inc L_30DD		;1CD4 EE DD 30
		lda #$D0		;1CD7 A9 D0
		sta ZP_81		;1CD9 85 81
		lda #$D4		;1CDB A9 D4
		sta ZP_80		;1CDD 85 80
		jsr L_1FB2		;1CDF 20 B2 1F
		lda #$0F		;1CE2 A9 0F
		sta L_3060		;1CE4 8D 60 30
		lda #$08		;1CE7 A9 08
		sta ZP_70		;1CE9 85 70
		lda #$1B		;1CEB A9 1B
		sta ZP_77		;1CED 85 77
		lda #$83		;1CEF A9 83
		sta ZP_74		;1CF1 85 74
		lda #$30		;1CF3 A9 30
		sta ZP_75		;1CF5 85 75
		ldx #$00		;1CF7 A2 00
		jsr L_2A08		;1CF9 20 08 2A
		lda #$18		;1CFC A9 18
		sta ZP_70		;1CFE 85 70
		lda #$84		;1D00 A9 84
		sta ZP_74		;1D02 85 74
		lda #$30		;1D04 A9 30
		sta ZP_75		;1D06 85 75
		ldx #$00		;1D08 A2 00
		jsr L_2A08		;1D0A 20 08 2A
		lda #$28		;1D0D A9 28
		sta ZP_70		;1D0F 85 70
		lda #$85		;1D11 A9 85
		sta ZP_74		;1D13 85 74
		lda #$30		;1D15 A9 30
		sta ZP_75		;1D17 85 75
		ldx #$00		;1D19 A2 00
		jsr L_2A08		;1D1B 20 08 2A
		lda #$38		;1D1E A9 38
		sta ZP_70		;1D20 85 70
		lda #$86		;1D22 A9 86
		sta ZP_74		;1D24 85 74
		lda #$30		;1D26 A9 30
		sta ZP_75		;1D28 85 75
		ldx #$00		;1D2A A2 00
		jsr L_2A08		;1D2C 20 08 2A
		lda #$FF		;1D2F A9 FF
		sta L_3060		;1D31 8D 60 30
		lda #$0B		;1D34 A9 0B
		sta ZP_70		;1D36 85 70
		lda #$87		;1D38 A9 87
		sta ZP_74		;1D3A 85 74
		lda #$30		;1D3C A9 30
		sta ZP_75		;1D3E 85 75
		ldx #$00		;1D40 A2 00
		jsr L_2A08		;1D42 20 08 2A
		lda #$1B		;1D45 A9 1B
		sta ZP_70		;1D47 85 70
		lda #$88		;1D49 A9 88
		sta ZP_74		;1D4B 85 74
		lda #$30		;1D4D A9 30
		sta ZP_75		;1D4F 85 75
		ldx #$00		;1D51 A2 00
		jsr L_2A08		;1D53 20 08 2A
		lda #$2B		;1D56 A9 2B
		sta ZP_70		;1D58 85 70
		lda #$89		;1D5A A9 89
		sta ZP_74		;1D5C 85 74
		lda #$30		;1D5E A9 30
		sta ZP_75		;1D60 85 75
		ldx #$00		;1D62 A2 00
		jsr L_2A08		;1D64 20 08 2A
		lda #$3B		;1D67 A9 3B
		sta ZP_70		;1D69 85 70
		lda #$8A		;1D6B A9 8A
		sta ZP_74		;1D6D 85 74
		lda #$30		;1D6F A9 30
		sta ZP_75		;1D71 85 75
		ldx #$00		;1D73 A2 00
		jsr L_2A08		;1D75 20 08 2A
		lda #$00		;1D78 A9 00
		ldy #$3F		;1D7A A0 3F
		sta L_309E,Y	;1D7C 99 9E 30
		ldx #$00		;1D7F A2 00
L_1D81	lda #$00		;1D81 A9 00
		sta L_38A0,X	;1D83 9D A0 38
		sta L_3860,X	;1D86 9D 60 38
		ldy L_309E,X	;1D89 BC 9E 30
		beq L_1D9B		;1D8C F0 0D
		dey				;1D8E 88
		lda L_3083,Y	;1D8F B9 83 30
		sta L_38A0,X	;1D92 9D A0 38
		lda L_3087,Y	;1D95 B9 87 30
		sta L_3860,X	;1D98 9D 60 38
L_1D9B	inx				;1D9B E8
		cpx #$40		;1D9C E0 40
		bne L_1D81		;1D9E D0 E1
		lda #$00		;1DA0 A9 00
		sta L_300C		;1DA2 8D 0C 30
		lda #$AF		;1DA5 A9 AF
		sta L_307E		;1DA7 8D 7E 30
L_1DAA	lda #$00		;1DAA A9 00
		sta L_09E6		;1DAC 8D E6 09
		sta L_3013		;1DAF 8D 13 30
		sta ZP_82		;1DB2 85 82
		sta ZP_83		;1DB4 85 83
		sta L_3017		;1DB6 8D 17 30
		ldx L_307E		;1DB9 AE 7E 30
		beq L_1DD8		;1DBC F0 1A
		dex				;1DBE CA
		stx L_307E		;1DBF 8E 7E 30
		cpx #$19		;1DC2 E0 19
		bne L_1DE4		;1DC4 D0 1E
		jsr L_26FD		;1DC6 20 FD 26
		jsr L_2750		;1DC9 20 50 27
		jmp L_1DE4		;1DCC 4C E4 1D
		dta $E0,$01,$D0,$11,$A2,$00,$8E,$7E,$30
;asc	dta c"`"*,$01,c"P"*,$11,c""""*,$00,$8E,c"~0"
;vid	dta d"`"*,d"!",$D0,d"1",d"B"*,d" ",d"."*,d"~P"
L_1DD8	jsr L_1F5F		;1DD8 20 5F 1F
		jsr L_23A6		;1DDB 20 A6 23
		jsr L_227A		;1DDE 20 7A 22
		jsr L_1EE7		;1DE1 20 E7 1E
L_1DE4	jsr L_24FD		;1DE4 20 FD 24
		jsr L_29CA		;1DE7 20 CA 29
		jsr L_1E91		;1DEA 20 91 1E
		lda L_3013		;1DED AD 13 30
		beq L_1DF5		;1DF0 F0 03
		jsr L_0AC8		;1DF2 20 C8 0A
L_1DF5	lda L_09E6		;1DF5 AD E6 09
		cmp L_3064		;1DF8 CD 64 30
		bcc L_1DF5		;1DFB 90 F8
		lda L_3008		;1DFD AD 08 30
		beq L_1E7E		;1E00 F0 7C
		lda L_309D		;1E02 AD 9D 30
		bne L_1E0C		;1E05 D0 05
		dec L_3014		;1E07 CE 14 30
		beq L_1E13		;1E0A F0 07
L_1E0C	lda L_300C		;1E0C AD 0C 30
		cmp #$3F		;1E0F C9 3F
		bne L_1DAA		;1E11 D0 97
L_1E13	ldx #$03		;1E13 A2 03
L_1E15	lda L_3008,X	;1E15 BD 08 30
		sta L_3064,X	;1E18 9D 64 30
		dex				;1E1B CA
		bne L_1E15		;1E1C D0 F7
		jsr L_271D		;1E1E 20 1D 27
		ldx L_3004		;1E21 AE 04 30
L_1E24	lda L_3008		;1E24 AD 08 30
		pha				;1E27 48
		jsr L_25E8		;1E28 20 E8 25
		pla				;1E2B 68
		pha				;1E2C 48
		jsr L_25E8		;1E2D 20 E8 25
		pla				;1E30 68
		pha				;1E31 48
		jsr L_25E8		;1E32 20 E8 25
		pla				;1E35 68
		pha				;1E36 48
		jsr L_25E8		;1E37 20 E8 25
		pla				;1E3A 68
		dex				;1E3B CA
		cpx #$A0		;1E3C E0 A0
		bne L_1E24		;1E3E D0 E4
		ldx L_3004		;1E40 AE 04 30
		inx				;1E43 E8
		cpx #$A6		;1E44 E0 A6
		beq L_1E4E		;1E46 F0 06
		stx L_3004		;1E48 8E 04 30
		jmp L_1B9C		;1E4B 4C 9C 1B
L_1E4E	jsr L_2AC3		;1E4E 20 C3 2A
		lda #$A1		;1E51 A9 A1
		sta L_3004		;1E53 8D 04 30
		lda #$00		;1E56 A9 00
		ldy L_307B		;1E58 AC 7B 30
		sta L_307B		;1E5B 8D 7B 30
		jsr L_FFCE		;1E5E 20 CE FF
		lda L_3008		;1E61 AD 08 30
		sta L_3066		;1E64 8D 66 30
		jsr L_271D		;1E67 20 1D 27
		ldx L_3005		;1E6A AE 05 30
		inx				;1E6D E8
		stx L_3005		;1E6E 8E 05 30
		cpx #$A5		;1E71 E0 A5
		beq L_1E78		;1E73 F0 03
		jmp L_1B21		;1E75 4C 21 1B
L_1E78	jsr L_2B11		;1E78 20 11 2B
		jmp L_1E8B		;1E7B 4C 8B 1E
L_1E7E	ldy L_307B		;1E7E AC 7B 30
		beq L_1E88		;1E81 F0 05
		lda #$00		;1E83 A9 00
		jsr L_FFCE		;1E85 20 CE FF
L_1E88	jsr L_2A7F		;1E88 20 7F 2A
L_1E8B	lda #$00		;1E8B A9 00
		sta L_09E7		;1E8D 8D E7 09
		rts				;1E90 60
L_1E91	inc L_3063		;1E91 EE 63 30
		lda L_3063		;1E94 AD 63 30
		cmp #$0C		;1E97 C9 0C
		bcs L_1EA6		;1E99 B0 0B
		lda L_3062		;1E9B AD 62 30
		bne L_1EBA		;1E9E D0 1A
		ldx L_3012		;1EA0 AE 12 30
		jmp L_2848		;1EA3 4C 48 28
L_1EA6	cmp #$14		;1EA6 C9 14
		beq L_1EB5		;1EA8 F0 0B
		lda L_3062		;1EAA AD 62 30
		beq L_1EBA		;1EAD F0 0B
		ldx L_3012		;1EAF AE 12 30
		jmp L_283A		;1EB2 4C 3A 28
L_1EB5	lda #$00		;1EB5 A9 00
L_1EB7	sta L_3063		;1EB7 8D 63 30
L_1EB8	equ *-2			;!
L_1EB9	equ *-1			;!
L_1EBA	rts				;1EBA 60
		dta $00,$02,$80,$00,$00,$05,$50,$00,$00,$12,$00,$00,$00,$17,$00,$00
;asc	dta $00,$02,$80,$00,$00,$05,c"P",$00,$00,$12,$00,$00,$00,$17,$00,$00
;vid	dta d" """,d" "*,d"  %",$50,d"  2   7  "
L_1ECB	sed				;1ECB F8
		lda L_309D		;1ECC AD 9D 30
		sta L_3013		;1ECF 8D 13 30
		sec				;1ED2 38
		sbc #$01		;1ED3 E9 01
		sta L_309D		;1ED5 8D 9D 30
		cld				;1ED8 D8
		rts				;1ED9 60
L_1EDA	pha				;1EDA 48
		lda #$00		;1EDB A9 00
		sta L_09E6		;1EDD 8D E6 09
		pla				;1EE0 68
L_1EE1	cmp L_09E6		;1EE1 CD E6 09
		bcs L_1EE1		;1EE4 B0 FB
		rts				;1EE6 60
L_1EE7	inc L_300F		;1EE7 EE 0F 30
		inc L_300F		;1EEA EE 0F 30
		bne L_1EF2		;1EED D0 03
		inc L_3010		;1EEF EE 10 30
L_1EF2	dec L_300E		;1EF2 CE 0E 30
		bne L_1F1A		;1EF5 D0 23
		lda L_308B		;1EF7 AD 8B 30
		sta L_300E		;1EFA 8D 0E 30
		ldx L_300D		;1EFD AE 0D 30
		cpx #$3F		;1F00 E0 3F
		beq L_1F1A		;1F02 F0 16
		inx				;1F04 E8
		stx L_300D		;1F05 8E 0D 30
		lda L_300F		;1F08 AD 0F 30
		sec				;1F0B 38
		sbc L_308C		;1F0C ED 8C 30
		sta L_300F		;1F0F 8D 0F 30
		lda L_3010		;1F12 AD 10 30
		sbc #$00		;1F15 E9 00
		sta L_3010		;1F17 8D 10 30
L_1F1A	lda ZP_83		;1F1A A5 83
		cmp #$FF		;1F1C C9 FF
		bne L_1F5E		;1F1E D0 3E
		inc L_300C		;1F20 EE 0C 30
		ldx L_3017		;1F23 AE 17 30
		beq L_1F5E		;1F26 F0 36
		lda L_309E,X	;1F28 BD 9E 30
		and #$1F		;1F2B 29 1F
		beq L_1F47		;1F2D F0 18
		cmp #$10		;1F2F C9 10
		bcs L_1F47		;1F31 B0 14
		jsr L_1ECB		;1F33 20 CB 1E
		lda L_3008		;1F36 AD 08 30
		sed				;1F39 F8
		sec				;1F3A 38
		sbc #$01		;1F3B E9 01
		sta L_3008		;1F3D 8D 08 30
		cld				;1F40 D8
		jsr L_0AE2		;1F41 20 E2 0A
		jsr L_266C		;1F44 20 6C 26
L_1F47	lda L_3015		;1F47 AD 15 30
		sta ZP_81		;1F4A 85 81
		lda L_3016		;1F4C AD 16 30
		sta ZP_80		;1F4F 85 80
		ldx L_3017		;1F51 AE 17 30
		lda #$1C		;1F54 A9 1C
		sta L_309E,X	;1F56 9D 9E 30
		stx ZP_8D		;1F59 86 8D
		jsr L_1FB2		;1F5B 20 B2 1F
L_1F5E	rts				;1F5E 60
L_1F5F	lda L_300F		;1F5F AD 0F 30
		sta ZP_8E		;1F62 85 8E
		lda L_3010		;1F64 AD 10 30
		sta ZP_8F		;1F67 85 8F
		ldx L_300D		;1F69 AE 0D 30
L_1F6C	stx ZP_8D		;1F6C 86 8D
		ldy #$00		;1F6E A0 00
		lda (ZP_8E),Y	;1F70 B1 8E
		sta ZP_81		;1F72 85 81
		iny				;1F74 C8
		lda (ZP_8E),Y	;1F75 B1 8E
		sta ZP_80		;1F77 85 80
		sta ZP_83		;1F79 85 83
		cmp #$FF		;1F7B C9 FF
		bne L_1F88		;1F7D D0 09
		lda L_309E,X	;1F7F BD 9E 30
		stx L_3017		;1F82 8E 17 30
		jmp L_1F9B		;1F85 4C 9B 1F
L_1F88	lda L_309E,X	;1F88 BD 9E 30
		beq L_1F9B		;1F8B F0 0E
		and #$1F		;1F8D 29 1F
		cmp #$10		;1F8F C9 10
		bcs L_1F98		;1F91 B0 05
		stx ZP_82		;1F93 86 82
		jsr L_20FA		;1F95 20 FA 20
L_1F98	jsr L_1FB2		;1F98 20 B2 1F
L_1F9B	clc				;1F9B 18
		lda ZP_8E		;1F9C A5 8E
		adc L_308C		;1F9E 6D 8C 30
		sta ZP_8E		;1FA1 85 8E
		lda #$00		;1FA3 A9 00
		adc ZP_8F		;1FA5 65 8F
		sta ZP_8F		;1FA7 85 8F
		ldx ZP_8D		;1FA9 A6 8D
		dex				;1FAB CA
		cpx L_300C		;1FAC EC 0C 30
		bne L_1F6C		;1FAF D0 BB
		rts				;1FB1 60
L_1FB2	lda #$20		;1FB2 A9 20
		sta ZP_71		;1FB4 85 71
		lda ZP_81		;1FB6 A5 81
		and #$FC		;1FB8 29 FC
		asl @			;1FBA 0A
		sta ZP_70		;1FBB 85 70
		rol ZP_71		;1FBD 26 71
		lda ZP_80		;1FBF A5 80
		and #$F8		;1FC1 29 F8
		lsr @			;1FC3 4A
		lsr @			;1FC4 4A
		adc ZP_71		;1FC5 65 71
		sta ZP_71		;1FC7 85 71
		lda ZP_80		;1FC9 A5 80
		and #$07		;1FCB 29 07
		adc ZP_70		;1FCD 65 70
		sta ZP_70		;1FCF 85 70
		lda ZP_81		;1FD1 A5 81
		and #$03		;1FD3 29 03
		sta ZP_80		;1FD5 85 80
		ldy ZP_8D		;1FD7 A4 8D
		lda L_309E,Y	;1FD9 B9 9E 30
		cmp #$20		;1FDC C9 20
		bcc L_1FF7		;1FDE 90 17
		pha				;1FE0 48
		and #$40		;1FE1 29 40
		beq L_1FF0		;1FE3 F0 0B
		pla				;1FE5 68
		and #$3F		;1FE6 29 3F
		sta L_309E,Y	;1FE8 99 9E 30
		and #$1F		;1FEB 29 1F
		jmp L_200E		;1FED 4C 0E 20
L_1FF0	pla				;1FF0 68
		jsr L_2BCA		;1FF1 20 CA 2B
		jmp L_2020		;1FF4 4C 20 20
L_1FF7	cmp #$10		;1FF7 C9 10
		bcc L_200E		;1FF9 90 13
		pha				;1FFB 48
		clc				;1FFC 18
		adc #$01		;1FFD 69 01
		cmp #$1D		;1FFF C9 1D
		bcc L_2005		;2001 90 02
		lda #$00		;2003 A9 00
L_2005	sta L_309E,Y	;2005 99 9E 30
		pla				;2008 68
		lsr @			;2009 4A
		lsr @			;200A 4A
		clc				;200B 18
		adc #$01		;200C 69 01
L_200E	sec				;200E 38
		sbc #$01		;200F E9 01
		asl @			;2011 0A
		asl @			;2012 0A
		adc ZP_80		;2013 65 80
		tax				;2015 AA
		lda L_0A70,X	;2016 BD 70 0A
		sta ZP_78		;2019 85 78
		lda L_0A90,X	;201B BD 90 0A
		sta ZP_79		;201E 85 79
L_2020	clc				;2020 18
		lda ZP_70		;2021 A5 70
		adc #$08		;2023 69 08
		sta ZP_72		;2025 85 72
		lda ZP_71		;2027 A5 71
		adc #$00		;2029 69 00
		sta ZP_73		;202B 85 73
		lda ZP_78		;202D A5 78
		adc #$0E		;202F 69 0E
		sta ZP_7A		;2031 85 7A
		lda ZP_79		;2033 A5 79
		adc #$00		;2035 69 00
		sta ZP_7B		;2037 85 7B
		lda ZP_72		;2039 A5 72
		adc #$08		;203B 69 08
		sta ZP_74		;203D 85 74
		lda ZP_73		;203F A5 73
		adc #$00		;2041 69 00
		sta ZP_75		;2043 85 75
		lda ZP_7A		;2045 A5 7A
		adc #$0E		;2047 69 0E
		sta ZP_7C		;2049 85 7C
		lda ZP_7B		;204B A5 7B
		adc #$00		;204D 69 00
		sta ZP_7D		;204F 85 7D
		lda ZP_74		;2051 A5 74
		adc #$08		;2053 69 08
		sta ZP_76		;2055 85 76
		lda ZP_75		;2057 A5 75
		adc #$00		;2059 69 00
		sta ZP_77		;205B 85 77
		lda ZP_7C		;205D A5 7C
		adc #$0E		;205F 69 0E
		sta ZP_7E		;2061 85 7E
		lda ZP_7D		;2063 A5 7D
		adc #$00		;2065 69 00
		sta ZP_7F		;2067 85 7F
		ldy #$00		;2069 A0 00
		lda ZP_70		;206B A5 70
		and #$07		;206D 29 07
		sta ZP_80		;206F 85 80
		lda #$08		;2071 A9 08
		sec				;2073 38
		sbc ZP_80		;2074 E5 80
		tax				;2076 AA
L_2077	lda (ZP_78),Y	;2077 B1 78
		sta (ZP_70),Y	;2079 91 70
		lda (ZP_7A),Y	;207B B1 7A
		sta (ZP_72),Y	;207D 91 72
		lda (ZP_7C),Y	;207F B1 7C
		sta (ZP_74),Y	;2081 91 74
		lda (ZP_7E),Y	;2083 B1 7E
		sta (ZP_76),Y	;2085 91 76
		iny				;2087 C8
		dex				;2088 CA
		bne L_2077		;2089 D0 EC
		sty ZP_80		;208B 84 80
		jsr L_20C3		;208D 20 C3 20
		ldx #$08		;2090 A2 08
L_2092	lda (ZP_78),Y	;2092 B1 78
		sta (ZP_70),Y	;2094 91 70
		lda (ZP_7A),Y	;2096 B1 7A
		sta (ZP_72),Y	;2098 91 72
		lda (ZP_7C),Y	;209A B1 7C
		sta (ZP_74),Y	;209C 91 74
		lda (ZP_7E),Y	;209E B1 7E
		sta (ZP_76),Y	;20A0 91 76
		iny				;20A2 C8
		cpy #$0E		;20A3 C0 0E
		beq L_20C2		;20A5 F0 1B
		dex				;20A7 CA
		bne L_2092		;20A8 D0 E8
		jsr L_20C3		;20AA 20 C3 20
L_20AD	lda (ZP_78),Y	;20AD B1 78
		sta (ZP_70),Y	;20AF 91 70
		lda (ZP_7A),Y	;20B1 B1 7A
		sta (ZP_72),Y	;20B3 91 72
		lda (ZP_7C),Y	;20B5 B1 7C
		sta (ZP_74),Y	;20B7 91 74
		lda (ZP_7E),Y	;20B9 B1 7E
		sta (ZP_76),Y	;20BB 91 76
		iny				;20BD C8
		cpy #$0E		;20BE C0 0E
		bne L_20AD		;20C0 D0 EB
L_20C2	rts				;20C2 60
L_20C3	lda ZP_70		;20C3 A5 70
		and #$F8		;20C5 29 F8
		sec				;20C7 38
		sbc ZP_80		;20C8 E5 80
		sta ZP_70		;20CA 85 70
		lda ZP_71		;20CC A5 71
		sbc #$00		;20CE E9 00
		adc #$01		;20D0 69 01
		sta ZP_71		;20D2 85 71
		clc				;20D4 18
		lda ZP_70		;20D5 A5 70
		adc #$08		;20D7 69 08
		sta ZP_72		;20D9 85 72
		lda ZP_71		;20DB A5 71
		adc #$00		;20DD 69 00
		sta ZP_73		;20DF 85 73
		lda ZP_72		;20E1 A5 72
		adc #$08		;20E3 69 08
		sta ZP_74		;20E5 85 74
		lda ZP_73		;20E7 A5 73
		adc #$00		;20E9 69 00
		sta ZP_75		;20EB 85 75
		lda ZP_74		;20ED A5 74
		adc #$08		;20EF 69 08
		sta ZP_76		;20F1 85 76
		lda ZP_75		;20F3 A5 75
		adc #$00		;20F5 69 00
		sta ZP_77		;20F7 85 77
		rts				;20F9 60
L_20FA	ldy L_3FFE		;20FA AC FE 3F
L_20FD	lda L_3850,Y	;20FD B9 50 38
		beq L_216A		;2100 F0 68
		lda L_3840,Y	;2102 B9 40 38
		bne L_216A		;2105 D0 63
		lda ZP_81		;2107 A5 81
		clc				;2109 18
		adc #$06		;210A 69 06
		lsr @			;210C 4A
		lsr @			;210D 4A
		sta ZP_71		;210E 85 71
		lda L_38F0,Y	;2110 B9 F0 38
		cmp ZP_71		;2113 C5 71
		bcs L_211C		;2115 B0 05
		tax				;2117 AA
		lda ZP_71		;2118 A5 71
		stx ZP_71		;211A 86 71
L_211C	sec				;211C 38
		sbc ZP_71		;211D E5 71
		cmp #$10		;211F C9 10
		bcs L_216A		;2121 B0 47
		tax				;2123 AA
		lda L_0AB0,X	;2124 BD B0 0A
		sta ZP_71		;2127 85 71
		lda ZP_80		;2129 A5 80
		adc #$07		;212B 69 07
		lsr @			;212D 4A
		lsr @			;212E 4A
		sta ZP_70		;212F 85 70
		lda L_38E0,Y	;2131 B9 E0 38
		cmp ZP_70		;2134 C5 70
		bcs L_213D		;2136 B0 05
		tax				;2138 AA
		lda ZP_70		;2139 A5 70
		stx ZP_70		;213B 86 70
L_213D	sec				;213D 38
		sbc ZP_70		;213E E5 70
		sta ZP_70		;2140 85 70
		cmp #$10		;2142 C9 10
		bcs L_216A		;2144 B0 24
		tax				;2146 AA
		lda L_0AB0,X	;2147 BD B0 0A
		adc ZP_71		;214A 65 71
		bcs L_216A		;214C B0 1C
		sta ZP_71		;214E 85 71
		lda L_3850,Y	;2150 B9 50 38
		tax				;2153 AA
		lda ZP_71		;2154 A5 71
		cmp L_0B18,X	;2156 DD 18 0B
		bcs L_216A		;2159 B0 0F
		lda ZP_8D		;215B A5 8D
		sta L_3830,Y	;215D 99 30 38
		lda ZP_81		;2160 A5 81
		sta L_3820,Y	;2162 99 20 38
		lda ZP_80		;2165 A5 80
		sta L_3810,Y	;2167 99 10 38
L_216A	dey				;216A 88
		bpl L_20FD		;216B 10 90
		rts				;216D 60
L_216E	lda L_3009		;216E AD 09 30
		cmp #$00		;2171 C9 00
		bne L_21B2		;2173 D0 3D
		lda L_300A		;2175 AD 0A 30
		cmp #$10		;2178 C9 10
		bcs L_21B2		;217A B0 36
		sta ZP_70		;217C 85 70
		lda L_300B		;217E AD 0B 30
		sta ZP_71		;2181 85 71
		lsr ZP_70		;2183 46 70
		ror ZP_71		;2185 66 71
		lsr ZP_70		;2187 46 70
		ror ZP_71		;2189 66 71
		lsr ZP_70		;218B 46 70
		ror ZP_71		;218D 66 71
		lsr ZP_70		;218F 46 70
		ror ZP_71		;2191 66 71
		ldy L_3850,X	;2193 BC 50 38
		lda ZP_71		;2196 A5 71
		cmp L_0B00,Y	;2198 D9 00 0B
		bcs L_21B2		;219B B0 15
		tya				;219D 98
		and #$03		;219E 29 03
		beq L_21AA		;21A0 F0 08
		dey				;21A2 88
		tya				;21A3 98
		sta L_3850,X	;21A4 9D 50 38
		jmp L_265B		;21A7 4C 5B 26
L_21AA	lda #$00		;21AA A9 00
		sta L_3850,X	;21AC 9D 50 38
		jmp L_265B		;21AF 4C 5B 26
L_21B2	lda #$20		;21B2 A9 20
		sta ZP_71		;21B4 85 71
		lda L_38F0,X	;21B6 BD F0 38
		sec				;21B9 38
		sbc #$03		;21BA E9 03
		asl @			;21BC 0A
		asl @			;21BD 0A
		asl @			;21BE 0A
		sta ZP_70		;21BF 85 70
		rol ZP_71		;21C1 26 71
		lda L_38E0,X	;21C3 BD E0 38
		sec				;21C6 38
		sbc #$03		;21C7 E9 03
		clc				;21C9 18
		adc ZP_71		;21CA 65 71
		sta ZP_71		;21CC 85 71
		lda L_3850,X	;21CE BD 50 38
		beq L_21D9		;21D1 F0 06
		lda L_0B3C,Y	;21D3 B9 3C 0B
		sta L_3840,X	;21D6 9D 40 38
L_21D9	txa				;21D9 8A
		pha				;21DA 48
		lda L_3850,X	;21DB BD 50 38
		lsr @			;21DE 4A
		and #$FE		;21DF 29 FE
		tax				;21E1 AA
		lda L_0B58,X	;21E2 BD 58 0B
		sta ZP_72		;21E5 85 72
		inx				;21E7 E8
		lda L_0B58,X	;21E8 BD 58 0B
		sta ZP_73		;21EB 85 73
		ldx #$03		;21ED A2 03
L_21EF	ldy #$2F		;21EF A0 2F
L_21F1	lda (ZP_72),Y	;21F1 B1 72
		sta (ZP_70),Y	;21F3 91 70
		dey				;21F5 88
		bpl L_21F1		;21F6 10 F9
		lda ZP_71		;21F8 A5 71
		clc				;21FA 18
		adc #$02		;21FB 69 02
		sta ZP_71		;21FD 85 71
		lda ZP_72		;21FF A5 72
		adc #$30		;2201 69 30
		sta ZP_72		;2203 85 72
		lda ZP_73		;2205 A5 73
		adc #$00		;2207 69 00
		sta ZP_73		;2209 85 73
		dex				;220B CA
		bne L_21EF		;220C D0 E1
		pla				;220E 68
		tax				;220F AA
		ldy L_3850,X	;2210 BC 50 38
		lda L_0B00,Y	;2213 B9 00 0B
		asl @			;2216 0A
		asl @			;2217 0A
		asl @			;2218 0A
		asl @			;2219 0A
		sta ZP_72		;221A 85 72
		sed				;221C F8
		lda L_300B		;221D AD 0B 30
		sec				;2220 38
		sbc ZP_72		;2221 E5 72
		sta L_300B		;2223 8D 0B 30
		lda L_300A		;2226 AD 0A 30
		sbc #$00		;2229 E9 00
		sta L_300A		;222B 8D 0A 30
		lda L_3009		;222E AD 09 30
		sbc #$00		;2231 E9 00
		sta L_3009		;2233 8D 09 30
		lda L_0B00,Y	;2236 B9 00 0B
		lsr @			;2239 4A
		lsr @			;223A 4A
		lsr @			;223B 4A
		lsr @			;223C 4A
		sta ZP_72		;223D 85 72
		lda L_300A		;223F AD 0A 30
		sec				;2242 38
		sbc ZP_72		;2243 E5 72
		sta L_300A		;2245 8D 0A 30
		lda L_3009		;2248 AD 09 30
		sbc #$00		;224B E9 00
		sta L_3009		;224D 8D 09 30
		cld				;2250 D8
		inc ZP_70		;2251 E6 70
		lda L_3850,X	;2253 BD 50 38
		beq L_2277		;2256 F0 1F
		and #$03		;2258 29 03
		beq L_2277		;225A F0 1B
		sec				;225C 38
		sbc #$01		;225D E9 01
		asl @			;225F 0A
		asl @			;2260 0A
		asl @			;2261 0A
		asl @			;2262 0A
		tay				;2263 A8
		lda #$83		;2264 A9 83
		sta (ZP_70),Y	;2266 91 70
		iny				;2268 C8
		sta (ZP_70),Y	;2269 91 70
		tya				;226B 98
		clc				;226C 18
		adc #$07		;226D 69 07
		tay				;226F A8
		lda #$38		;2270 A9 38
		sta (ZP_70),Y	;2272 91 70
		iny				;2274 C8
		sta (ZP_70),Y	;2275 91 70
L_2277	jmp L_29B0		;2277 4C B0 29
L_227A	lda #$00		;227A A9 00
		sta L_307C		;227C 8D 7C 30
		ldx L_3FFE		;227F AE FE 3F
L_2282	lda L_3850,X	;2282 BD 50 38
		beq L_22EB		;2285 F0 64
		ldy L_3830,X	;2287 BC 30 38
		beq L_22EB		;228A F0 5F
		lda #$00		;228C A9 00
		sta ZP_71		;228E 85 71
		lda L_3820,X	;2290 BD 20 38
		clc				;2293 18
		adc #$07		;2294 69 07
		and #$FC		;2296 29 FC
		sta ZP_70		;2298 85 70
		asl ZP_70		;229A 06 70
		rol ZP_71		;229C 26 71
		lda L_3810,X	;229E BD 10 38
		and #$02		;22A1 29 02
		adc ZP_70		;22A3 65 70
		sta ZP_70		;22A5 85 70
		lda L_3810,X	;22A7 BD 10 38
		and #$F8		;22AA 29 F8
		lsr @			;22AC 4A
		lsr @			;22AD 4A
		adc ZP_71		;22AE 65 71
		sta ZP_71		;22B0 85 71
		lda #$42		;22B2 A9 42
		adc ZP_71		;22B4 65 71
		sta ZP_71		;22B6 85 71
		stx ZP_74		;22B8 86 74
		ldy #$00		;22BA A0 00
L_22BC	lda L_3038,Y	;22BC B9 38 30
		beq L_2303		;22BF F0 42
		iny				;22C1 C8
		cpy #$08		;22C2 C0 08
		bne L_22BC		;22C4 D0 F6
L_22C6	lda L_3850,X	;22C6 BD 50 38
		sta L_307C		;22C9 8D 7C 30
		and #$FC		;22CC 29 FC
		tax				;22CE AA
		lda L_0CEF,X	;22CF BD EF 0C
		ldy #$00		;22D2 A0 00
		sta (ZP_70),Y	;22D4 91 70
		iny				;22D6 C8
		lda L_0CF0,X	;22D7 BD F0 0C
		sta (ZP_70),Y	;22DA 91 70
		iny				;22DC C8
		lda L_0CF1,X	;22DD BD F1 0C
		sta (ZP_70),Y	;22E0 91 70
		iny				;22E2 C8
		lda L_0CF2,X	;22E3 BD F2 0C
		sta (ZP_70),Y	;22E6 91 70
		jsr L_242C		;22E8 20 2C 24
L_22EB	lda #$00		;22EB A9 00
		sta L_3830,X	;22ED 9D 30 38
		lda L_3840,X	;22F0 BD 40 38
		beq L_22FD		;22F3 F0 08
		sed				;22F5 F8
		sec				;22F6 38
		sbc #$01		;22F7 E9 01
		sta L_3840,X	;22F9 9D 40 38
		cld				;22FC D8
L_22FD	dex				;22FD CA
		bpl L_2282		;22FE 10 82
		jmp L_262B		;2300 4C 2B 26
L_2303	lda ZP_70		;2303 A5 70
		sta L_3028,Y	;2305 99 28 30
		lda ZP_71		;2308 A5 71
		sta L_3030,Y	;230A 99 30 30
		lda L_3850,X	;230D BD 50 38
		and #$FC		;2310 29 FC
		sta L_3038,Y	;2312 99 38 30
		sty ZP_77		;2315 84 77
		lda L_38F0,X	;2317 BD F0 38
		sta ZP_78		;231A 85 78
		lda L_3820,X	;231C BD 20 38
		clc				;231F 18
		adc #$06		;2320 69 06
		lsr @			;2322 4A
		lsr @			;2323 4A
		cmp ZP_78		;2324 C5 78
		bcs L_232D		;2326 B0 05
		ldy ZP_78		;2328 A4 78
		sta ZP_78		;232A 85 78
		tya				;232C 98
L_232D	sec				;232D 38
		sbc ZP_78		;232E E5 78
		lsr @			;2330 4A
		clc				;2331 18
		adc ZP_78		;2332 65 78
		sta ZP_78		;2334 85 78
		lda L_38E0,X	;2336 BD E0 38
		sta ZP_79		;2339 85 79
		lda L_3810,X	;233B BD 10 38
		clc				;233E 18
		adc #$06		;233F 69 06
		lsr @			;2341 4A
		lsr @			;2342 4A
		cmp ZP_79		;2343 C5 79
		bcs L_234C		;2345 B0 05
		ldy ZP_79		;2347 A4 79
		sta ZP_79		;2349 85 79
		tya				;234B 98
L_234C	sec				;234C 38
		sbc ZP_79		;234D E5 79
		lsr @			;234F 4A
		clc				;2350 18
		adc ZP_79		;2351 65 79
		sta ZP_79		;2353 85 79
		lda #$00		;2355 A9 00
		sta ZP_71		;2357 85 71
		lda ZP_78		;2359 A5 78
		asl @			;235B 0A
		asl @			;235C 0A
		asl @			;235D 0A
		sta ZP_70		;235E 85 70
		rol ZP_71		;2360 26 71
		inc ZP_70		;2362 E6 70
		inc ZP_70		;2364 E6 70
		inc ZP_70		;2366 E6 70
		lda ZP_79		;2368 A5 79
		and #$3E		;236A 29 3E
		clc				;236C 18
		adc ZP_71		;236D 65 71
		sta ZP_71		;236F 85 71
		lda #$40		;2371 A9 40
		adc ZP_71		;2373 65 71
		sta ZP_71		;2375 85 71
		lda ZP_77		;2377 A5 77
		asl @			;2379 0A
		asl @			;237A 0A
		tax				;237B AA
		ldy #$00		;237C A0 00
		lda (ZP_70),Y	;237E B1 70
		sta L_3040,X	;2380 9D 40 30
		iny				;2383 C8
		lda (ZP_70),Y	;2384 B1 70
		sta L_3041,X	;2386 9D 41 30
		iny				;2389 C8
		lda (ZP_70),Y	;238A B1 70
		sta L_3042,X	;238C 9D 42 30
		iny				;238F C8
		lda (ZP_70),Y	;2390 B1 70
		sta L_3043,X	;2392 9D 43 30
		ldy ZP_77		;2395 A4 77
		lda ZP_70		;2397 A5 70
		sta L_3018,Y	;2399 99 18 30
		lda ZP_71		;239C A5 71
		sta L_3020,Y	;239E 99 20 30
		ldx ZP_74		;23A1 A6 74
		jmp L_22C6		;23A3 4C C6 22
L_23A6	ldx #$07		;23A6 A2 07
L_23A8	lda L_3038,X	;23A8 BD 38 30
		beq L_2425		;23AB F0 78
		lda L_3018,X	;23AD BD 18 30
		sta ZP_70		;23B0 85 70
		lda L_3020,X	;23B2 BD 20 30
		sta ZP_71		;23B5 85 71
		lda L_3028,X	;23B7 BD 28 30
		sta ZP_72		;23BA 85 72
		lda L_3030,X	;23BC BD 30 30
		sta ZP_73		;23BF 85 73
		stx ZP_74		;23C1 86 74
		txa				;23C3 8A
		asl @			;23C4 0A
		asl @			;23C5 0A
		sta ZP_75		;23C6 85 75
		lda L_3038,X	;23C8 BD 38 30
		tax				;23CB AA
		stx ZP_76		;23CC 86 76
		ldy #$00		;23CE A0 00
		lda L_0CEF,X	;23D0 BD EF 0C
		sta (ZP_72),Y	;23D3 91 72
		cmp (ZP_70),Y	;23D5 D1 70
		bne L_23E2		;23D7 D0 09
		ldx ZP_75		;23D9 A6 75
		lda L_3040,X	;23DB BD 40 30
		sta (ZP_70),Y	;23DE 91 70
		ldx ZP_76		;23E0 A6 76
L_23E2	ldy #$01		;23E2 A0 01
		lda L_0CF0,X	;23E4 BD F0 0C
		sta (ZP_72),Y	;23E7 91 72
		cmp (ZP_70),Y	;23E9 D1 70
		bne L_23F6		;23EB D0 09
		ldx ZP_75		;23ED A6 75
		lda L_3041,X	;23EF BD 41 30
		sta (ZP_70),Y	;23F2 91 70
		ldx ZP_76		;23F4 A6 76
L_23F6	ldy #$02		;23F6 A0 02
		lda L_0CF1,X	;23F8 BD F1 0C
		sta (ZP_72),Y	;23FB 91 72
		cmp (ZP_70),Y	;23FD D1 70
		bne L_240A		;23FF D0 09
		ldx ZP_75		;2401 A6 75
		lda L_3042,X	;2403 BD 42 30
		sta (ZP_70),Y	;2406 91 70
		ldx ZP_76		;2408 A6 76
L_240A	ldy #$03		;240A A0 03
		lda L_0CF2,X	;240C BD F2 0C
		sta (ZP_72),Y	;240F 91 72
		cmp (ZP_70),Y	;2411 D1 70
		bne L_241E		;2413 D0 09
		ldx ZP_75		;2415 A6 75
		lda L_3043,X	;2417 BD 43 30
		ldx ZP_76		;241A A6 76
		sta (ZP_70),Y	;241C 91 70
L_241E	ldx ZP_74		;241E A6 74
		lda #$00		;2420 A9 00
		sta L_3038,X	;2422 9D 38 30
L_2425	dex				;2425 CA
		bmi L_242B		;2426 30 03
		jmp L_23A8		;2428 4C A8 23
L_242B	rts				;242B 60
L_242C	ldx ZP_74		;242C A6 74
		ldy L_3850,X	;242E BC 50 38
		lda L_0B3C,Y	;2431 B9 3C 0B
		sta L_3840,X	;2434 9D 40 38
		stx ZP_80		;2437 86 80
		lda L_3830,X	;2439 BD 30 38
		tax				;243C AA
		lda L_309E,X	;243D BD 9E 30
		and #$1F		;2440 29 1F
		cmp #$10		;2442 C9 10
		bcs L_24B3		;2444 B0 6D
		lda L_309E,X	;2446 BD 9E 30
		cmp #$10		;2449 C9 10
		beq L_24B3		;244B F0 66
		ora #$60		;244D 09 60
		sta L_309E,X	;244F 9D 9E 30
		sed				;2452 F8
		lda L_0B24,Y	;2453 B9 24 0B
		sec				;2456 38
		sbc L_3860,X	;2457 FD 60 38
		bcs L_245E		;245A B0 02
		lda #$00		;245C A9 00
L_245E	sta ZP_71		;245E 85 71
		lda L_38A0,X	;2460 BD A0 38
		sec				;2463 38
		sbc ZP_71		;2464 E5 71
		beq L_246A		;2466 F0 02
		bcs L_24A1		;2468 B0 37
L_246A	tya				;246A 98
		pha				;246B 48
		lda L_309E,X	;246C BD 9E 30
		and #$1F		;246F 29 1F
		tay				;2471 A8
		dey				;2472 88
		lda L_307F,Y	;2473 B9 7F 30
		php				;2476 08
		jsr L_25E8		;2477 20 E8 25
		lda L_3083,Y	;247A B9 83 30
		sta L_3068		;247D 8D 68 30
		lda L_3087,Y	;2480 B9 87 30
		sta L_3067		;2483 8D 67 30
		jsr L_271D		;2486 20 1D 27
		inc L_3006		;2489 EE 06 30
		bne L_2491		;248C D0 03
		inc L_3007		;248E EE 07 30
L_2491	plp				;2491 28
		pla				;2492 68
		tay				;2493 A8
		lda #$10		;2494 A9 10
		sta L_309E,X	;2496 9D 9E 30
		jsr L_1ECB		;2499 20 CB 1E
		jsr L_2611		;249C 20 11 26
		lda #$00		;249F A9 00
L_24A1	sta L_38A0,X	;24A1 9D A0 38
		lda L_3860,X	;24A4 BD 60 38
		sec				;24A7 38
		sbc L_0B30,Y	;24A8 F9 30 0B
		bcs L_24AF		;24AB B0 02
		lda #$00		;24AD A9 00
L_24AF	sta L_3860,X	;24AF 9D 60 38
		cld				;24B2 D8
L_24B3	ldx ZP_80		;24B3 A6 80
L_24B5	rts				;24B5 60
L_24B6	ldy #$04		;24B6 A0 04
		jmp L_25BE		;24B8 4C BE 25
L_24BB	ldy #$08		;24BB A0 08
		jmp L_25BE		;24BD 4C BE 25
L_24C0	ldy #$0C		;24C0 A0 0C
		jmp L_25BE		;24C2 4C BE 25
L_24C5	jsr L_24CF		;24C5 20 CF 24
		bvc L_2540		;24C8 50 76
		pla				;24CA 68
		pla				;24CB 68
		jmp L_1E7E		;24CC 4C 7E 1E
L_24CF	clv				;24CF B8
		clc				;24D0 18
		jmp (L_0228)	;24D1 6C 28 02
L_24D4	ldx L_3012		;24D4 AE 12 30
		lda L_3850,X	;24D7 BD 50 38
		beq L_24F7		;24DA F0 1B
		and #$03		;24DC 29 03
		cmp #$03		;24DE C9 03
		beq L_24F7		;24E0 F0 15
		inc L_3850,X	;24E2 FE 50 38
		jsr L_283A		;24E5 20 3A 28
		jsr L_26E0		;24E8 20 E0 26
		jsr L_216E		;24EB 20 6E 21
		ldx L_3012		;24EE AE 12 30
		jsr L_2848		;24F1 20 48 28
		jmp L_25D9		;24F4 4C D9 25
L_24F7	jsr L_265B		;24F7 20 5B 26
		jmp L_25D9		;24FA 4C D9 25
L_24FD	lda #$02		;24FD A9 02
		sta L_3064		;24FF 8D 64 30
		lda ZP_EC		;2502 A5 EC
		cmp #$E2		;2504 C9 E2
		bne L_250D		;2506 D0 05
		lda #$00		;2508 A9 00
		sta L_3064		;250A 8D 64 30
L_250D	lda L_3011		;250D AD 11 30
		beq L_251A		;2510 F0 08
		cmp ZP_EC		;2512 C5 EC
		beq L_24B5		;2514 F0 9F
		cmp ZP_ED		;2516 C5 ED
		beq L_24B5		;2518 F0 9B
L_251A	lda ZP_EC		;251A A5 EC
		cmp #$B0		;251C C9 B0
		beq L_24B6		;251E F0 96
		cmp #$B1		;2520 C9 B1
		beq L_24BB		;2522 F0 97
		cmp #$91		;2524 C9 91
		beq L_24C0		;2526 F0 98
		cmp #$B5		;2528 C9 B5
		beq L_24D4		;252A F0 A8
		cmp #$F0		;252C C9 F0
		beq L_24C5		;252E F0 95
		cmp #$99		;2530 C9 99
		beq L_2546		;2532 F0 12
		cmp #$F9		;2534 C9 F9
		beq L_255E		;2536 F0 26
		cmp #$B9		;2538 C9 B9
		beq L_257A		;253A F0 3E
		cmp #$A9		;253C C9 A9
		beq L_259A		;253E F0 5A
L_2540	lda ZP_EC		;2540 A5 EC
		sta L_3011		;2542 8D 11 30
		rts				;2545 60
L_2546	jsr L_264A		;2546 20 4A 26
		ldx L_3012		;2549 AE 12 30
		jsr L_283A		;254C 20 3A 28
		dex				;254F CA
		bpl L_2555		;2550 10 03
		ldx L_3FFE		;2552 AE FE 3F
L_2555	stx L_3012		;2555 8E 12 30
		jsr L_2848		;2558 20 48 28
		jmp L_25D9		;255B 4C D9 25
L_255E	jsr L_264A		;255E 20 4A 26
		ldx L_3012		;2561 AE 12 30
		jsr L_283A		;2564 20 3A 28
		inx				;2567 E8
		cpx L_3FFE		;2568 EC FE 3F
		bcc L_2571		;256B 90 04
		beq L_2571		;256D F0 02
		ldx #$00		;256F A2 00
L_2571	stx L_3012		;2571 8E 12 30
		jsr L_2848		;2574 20 48 28
		jmp L_25D9		;2577 4C D9 25
L_257A	jsr L_264A		;257A 20 4A 26
		ldx L_3012		;257D AE 12 30
		jsr L_283A		;2580 20 3A 28
		lda L_38F0,X	;2583 BD F0 38
L_2586	dex				;2586 CA
		bpl L_258C		;2587 10 03
		ldx L_3FFE		;2589 AE FE 3F
L_258C	cmp L_38F0,X	;258C DD F0 38
		bne L_2586		;258F D0 F5
		stx L_3012		;2591 8E 12 30
		jsr L_2848		;2594 20 48 28
		jmp L_25D9		;2597 4C D9 25
L_259A	jsr L_264A		;259A 20 4A 26
		ldx L_3012		;259D AE 12 30
		jsr L_283A		;25A0 20 3A 28
		lda L_38F0,X	;25A3 BD F0 38
L_25A6	inx				;25A6 E8
		cpx L_3FFE		;25A7 EC FE 3F
		bcc L_25B0		;25AA 90 04
		beq L_25B0		;25AC F0 02
		ldx #$00		;25AE A2 00
L_25B0	cmp L_38F0,X	;25B0 DD F0 38
		bne L_25A6		;25B3 D0 F1
		stx L_3012		;25B5 8E 12 30
		jsr L_2848		;25B8 20 48 28
		jmp L_25D9		;25BB 4C D9 25
L_25BE	ldx L_3012		;25BE AE 12 30
		lda L_3850,X	;25C1 BD 50 38
		bne L_25E2		;25C4 D0 1C
		tya				;25C6 98
		sta L_3850,X	;25C7 9D 50 38
		jsr L_283A		;25CA 20 3A 28
		jsr L_26BA		;25CD 20 BA 26
		jsr L_216E		;25D0 20 6E 21
		ldx L_3012		;25D3 AE 12 30
		jsr L_2848		;25D6 20 48 28
L_25D9	lda ZP_EC		;25D9 A5 EC
		sta L_3011		;25DB 8D 11 30
		jsr L_2744		;25DE 20 44 27
		rts				;25E1 60
L_25E2	jsr L_265B		;25E2 20 5B 26
		jmp L_25D9		;25E5 4C D9 25
L_25E8	sta ZP_70		;25E8 85 70
		txa				;25EA 8A
		pha				;25EB 48
		tya				;25EC 98
		pha				;25ED 48
		lda ZP_70		;25EE A5 70
		sed				;25F0 F8
		clc				;25F1 18
		adc L_300B		;25F2 6D 0B 30
		sta L_300B		;25F5 8D 0B 30
		lda #$00		;25F8 A9 00
		adc L_300A		;25FA 6D 0A 30
		sta L_300A		;25FD 8D 0A 30
		lda #$00		;2600 A9 00
		adc L_3009		;2602 6D 09 30
		sta L_3009		;2605 8D 09 30
		cld				;2608 D8
		jsr L_29B0		;2609 20 B0 29
		pla				;260C 68
		tay				;260D A8
		pla				;260E 68
		tax				;260F AA
		rts				;2610 60
L_2611	txa				;2611 8A
		pha				;2612 48
		tya				;2613 98
		pha				;2614 48
		lda #$07		;2615 A9 07
		ldx #$23		;2617 A2 23
		ldy #$26		;2619 A0 26
		jsr L_FFF1		;261B 20 F1 FF
		pla				;261E 68
		tay				;261F A8
		pla				;2620 68
		tax				;2621 AA
		rts				;2622 60
		dta $10,$00,$01,$00,$06,$00,$0F,$00
;asc	dta $10,$00,$01,$00,$06,$00,$0F,$00
;vid	dta d"0 ! & / "
L_262B	lda L_307C		;262B AD 7C 30
		beq L_2641		;262E F0 11
		and #$0C		;2630 29 0C
		asl @			;2632 0A
		ora #$C0		;2633 09 C0
		sta L_2646		;2635 8D 46 26
		ldx #$42		;2638 A2 42
		ldy #$26		;263A A0 26
		lda #$07		;263C A9 07
		jsr L_FFF1		;263E 20 F1 FF
L_2641	rts				;2641 60
		dta $11,$00,$02,$00
;asc	dta $11,$00,$02,$00
;vid	dta d"1 "" "
L_2646	dta $06,$00,$02,$00
;asc	dta $06,$00,$02,$00
;vid	dta d"& "" "
L_264A	lda #$07		;264A A9 07
		ldx #$53		;264C A2 53
		ldy #$26		;264E A0 26
		jmp L_FFF1		;2650 4C F1 FF
		dta $13,$00,$F6,$FF,$96,$00,$01,$00
;asc	dta $13,$00,c"v"*,$FF,$96,$00,$01,$00
;vid	dta d"3 ",d"v"*,$FF,d"6"*,d" ! "
L_265B	lda #$07		;265B A9 07
		ldx #$64		;265D A2 64
		ldy #$26		;265F A0 26
		jmp L_FFF1		;2661 4C F1 FF
		dta $12,$00,$F1,$FF,$0A,$00,$08,$00
;asc	dta $12,$00,c"q"*,$FF,$0A,$00,$08,$00
;vid	dta d"2 ",d"q"*,$FF,d"* ( "
L_266C	txa				;266C 8A
		pha				;266D 48
		tya				;266E 98
		pha				;266F 48
		lda #$12		;2670 A9 12
		ldx #$14		;2672 A2 14
		ldy #$08		;2674 A0 08
		jsr L_2699		;2676 20 99 26
		lda #$02		;2679 A9 02
		ldx #$04		;267B A2 04
		ldy #$10		;267D A0 10
		jsr L_2699		;267F 20 99 26
		pla				;2682 68
		tay				;2683 A8
		pla				;2684 68
		tax				;2685 AA
		rts				;2686 60
L_2687	pha				;2687 48
		lda #$04		;2688 A9 04
		sta L_26B4		;268A 8D B4 26
		jmp L_269F		;268D 4C 9F 26
L_2690	pha				;2690 48
		lda #$03		;2691 A9 03
		sta L_26B4		;2693 8D B4 26
		jmp L_269F		;2696 4C 9F 26
L_2699	pha				;2699 48
		lda #$01		;269A A9 01
		sta L_26B4		;269C 8D B4 26
L_269F	pla				;269F 68
		sta L_26B2		;26A0 8D B2 26
		stx L_26B6		;26A3 8E B6 26
		sty L_26B8		;26A6 8C B8 26
		lda #$07		;26A9 A9 07
		ldx #$B2		;26AB A2 B2
		ldy #$26		;26AD A0 26
		jmp L_FFF1		;26AF 4C F1 FF
L_26B2	dta $10,$00
;asc	dta $10,$00
;vid	dta d"0 "
L_26B4	dta $01,$00
;asc	dta $01,$00
;vid	dta d"! "
L_26B6	dta $06,$00
;asc	dta $06,$00
;vid	dta d"& "
L_26B8	dta $0F,$00
;asc	dta $0F,$00
;vid	dta d"/ "
L_26BA	pha				;26BA 48
		tya				;26BB 98
		pha				;26BC 48
		txa				;26BD 8A
		pha				;26BE 48
		lda #$12		;26BF A9 12
		ldx #$80		;26C1 A2 80
		ldy #$05		;26C3 A0 05
		jsr L_2699		;26C5 20 99 26
		lda #$02		;26C8 A9 02
		ldx #$A4		;26CA A2 A4
		ldy #$05		;26CC A0 05
		jsr L_2699		;26CE 20 99 26
		lda #$02		;26D1 A9 02
		ldx #$94		;26D3 A2 94
		ldy #$0A		;26D5 A0 0A
		jsr L_2699		;26D7 20 99 26
		pla				;26DA 68
		tax				;26DB AA
		pla				;26DC 68
		tay				;26DD A8
		pla				;26DE 68
		rts				;26DF 60
L_26E0	pha				;26E0 48
		tya				;26E1 98
		pha				;26E2 48
		txa				;26E3 8A
		pha				;26E4 48
		lda #$12		;26E5 A9 12
		ldx #$80		;26E7 A2 80
		ldy #$05		;26E9 A0 05
		jsr L_2699		;26EB 20 99 26
		lda #$02		;26EE A9 02
		ldx #$A4		;26F0 A2 A4
		ldy #$0A		;26F2 A0 0A
		jsr L_2699		;26F4 20 99 26
		pla				;26F7 68
		tax				;26F8 AA
		pla				;26F9 68
		tay				;26FA A8
		pla				;26FB 68
		rts				;26FC 60
L_26FD	ldx #$00		;26FD A2 00
L_26FF	txa				;26FF 8A
		pha				;2700 48
		ldy L_2719,X	;2701 BC 19 27
		lda L_2715,X	;2704 BD 15 27
		tax				;2707 AA
		lda #$01		;2708 A9 01
		jsr L_2690		;270A 20 90 26
		pla				;270D 68
		tax				;270E AA
		inx				;270F E8
		cpx #$04		;2710 E0 04
		bne L_26FF		;2712 D0 EB
		rts				;2714 60
L_2715	dta $50,$50,$50,$64
;asc	dta c"PPPd"
;vid	dta $50,$50,$50,d"d"
L_2719	dta $06,$03,$03,$0C
;asc	dta $06,$03,$03,$0C
;vid	dta d"&##,"
L_271D	txa				;271D 8A
		pha				;271E 48
		tya				;271F 98
		pha				;2720 48
		sed				;2721 F8
		ldx #$04		;2722 A2 04
		clc				;2724 18
L_2725	lda L_2FFF,X	;2725 BD FF 2F
		adc L_3064,X	;2728 7D 64 30
		sta L_2FFF,X	;272B 9D FF 2F
		dex				;272E CA
		bne L_2725		;272F D0 F4
		lda #$00		;2731 A9 00
		ldx #$04		;2733 A2 04
L_2735	sta L_3064,X	;2735 9D 64 30
		dex				;2738 CA
		bne L_2735		;2739 D0 FA
		cld				;273B D8
		jsr L_2996		;273C 20 96 29
		pla				;273F 68
		tay				;2740 A8
		pla				;2741 68
		tax				;2742 AA
		rts				;2743 60
L_2744	ldx L_3012		;2744 AE 12 30
		lda L_3850,X	;2747 BD 50 38
		cmp L_3061		;274A CD 61 30
		bne L_2756		;274D D0 07
		rts				;274F 60
L_2750	ldx L_3012		;2750 AE 12 30
		lda L_3850,X	;2753 BD 50 38
L_2756	jsr L_293F		;2756 20 3F 29
		sta L_3061		;2759 8D 61 30
		cmp #$00		;275C C9 00
		beq L_27A4		;275E F0 44
		dey				;2760 88
		tay				;2761 A8
		and #$03		;2762 29 03
		ora #$A0		;2764 09 A0
		sta L_0B63		;2766 8D 63 0B
		lda #$1D		;2769 A9 1D
		sta ZP_77		;276B 85 77
		jsr L_27CF		;276D 20 CF 27
		lda #$CD		;2770 A9 CD
		sta L_0B63		;2772 8D 63 0B
		lda #$13		;2775 A9 13
		sta ZP_70		;2777 85 70
		ldx #$00		;2779 A2 00
		jsr L_2A08		;277B 20 08 2A
		tya				;277E 98
		and #$03		;277F 29 03
		cmp #$03		;2781 C9 03
		beq L_27A3		;2783 F0 1E
		iny				;2785 C8
		tya				;2786 98
		and #$03		;2787 29 03
		ora #$A0		;2789 09 A0
		sta L_0B63		;278B 8D 63 0B
		lda #$1E		;278E A9 1E
		sta ZP_77		;2790 85 77
		jsr L_27CF		;2792 20 CF 27
		lda #$AB		;2795 A9 AB
		sta L_0B63		;2797 8D 63 0B
		lda #$13		;279A A9 13
		sta ZP_70		;279C 85 70
		ldx #$00		;279E A2 00
		jsr L_2A08		;27A0 20 08 2A
L_27A3	rts				;27A3 60
L_27A4	ldy #$04		;27A4 A0 04
		lda #$1D		;27A6 A9 1D
		sta ZP_77		;27A8 85 77
L_27AA	lda #$A0		;27AA A9 A0
		sta L_0B63		;27AC 8D 63 0B
		jsr L_27CF		;27AF 20 CF 27
		tya				;27B2 98
		lsr @			;27B3 4A
		lsr @			;27B4 4A
		ora #$A0		;27B5 09 A0
		sta L_0B63		;27B7 8D 63 0B
		lda #$13		;27BA A9 13
		sta ZP_70		;27BC 85 70
		ldx #$00		;27BE A2 00
		jsr L_2A08		;27C0 20 08 2A
		inc ZP_77		;27C3 E6 77
		tya				;27C5 98
		clc				;27C6 18
		adc #$04		;27C7 69 04
		tay				;27C9 A8
		cmp #$10		;27CA C9 10
		bne L_27AA		;27CC D0 DC
		rts				;27CE 60
L_27CF	lda #$0F		;27CF A9 0F
		sta L_3060		;27D1 8D 60 30
		lda #$17		;27D4 A9 17
		sta ZP_70		;27D6 85 70
		lda #$63		;27D8 A9 63
		sta ZP_74		;27DA 85 74
		lda #$0B		;27DC A9 0B
		sta ZP_75		;27DE 85 75
		ldx #$00		;27E0 A2 00
		jsr L_2A08		;27E2 20 08 2A
		lda L_0B30,Y	;27E5 B9 30 0B
		sta L_0B63		;27E8 8D 63 0B
		lda #$21		;27EB A9 21
		sta ZP_70		;27ED 85 70
		ldx #$00		;27EF A2 00
		jsr L_2A08		;27F1 20 08 2A
		lda L_0B48,Y	;27F4 B9 48 0B
		sta L_0B63		;27F7 8D 63 0B
		lda #$2B		;27FA A9 2B
		sta ZP_70		;27FC 85 70
		ldx #$00		;27FE A2 00
		jsr L_2A08		;2800 20 08 2A
		lda #$FF		;2803 A9 FF
		sta L_3060		;2805 8D 60 30
		lda L_0B00,Y	;2808 B9 00 0B
		sta L_0B63		;280B 8D 63 0B
		lda #$30		;280E A9 30
		sta ZP_70		;2810 85 70
		ldx #$01		;2812 A2 01
		jsr L_2A08		;2814 20 08 2A
		lda #$F0		;2817 A9 F0
		sta L_3060		;2819 8D 60 30
		lda L_0B24,Y	;281C B9 24 0B
		sta L_0B63		;281F 8D 63 0B
		lda #$1C		;2822 A9 1C
		sta ZP_70		;2824 85 70
		ldx #$00		;2826 A2 00
		jsr L_2A08		;2828 20 08 2A
		lda L_0B0C,Y	;282B B9 0C 0B
		sta L_0B63		;282E 8D 63 0B
		lda #$26		;2831 A9 26
		sta ZP_70		;2833 85 70
		ldx #$00		;2835 A2 00
		jmp L_2A08		;2837 4C 08 2A
L_283A	lda L_3062		;283A AD 62 30
		beq L_2847		;283D F0 08
		jsr L_2855		;283F 20 55 28
		lda #$00		;2842 A9 00
		sta L_3062		;2844 8D 62 30
L_2847	rts				;2847 60
L_2848	lda #$01		;2848 A9 01
		sta L_3062		;284A 8D 62 30
		lda #$00		;284D A9 00
		sta L_3063		;284F 8D 63 30
		jmp L_2855		;2852 4C 55 28
L_2855	txa				;2855 8A
		pha				;2856 48
		lda #$20		;2857 A9 20
		sta ZP_71		;2859 85 71
		lda L_38F0,X	;285B BD F0 38
		sec				;285E 38
		sbc #$03		;285F E9 03
		asl @			;2861 0A
		asl @			;2862 0A
		asl @			;2863 0A
		sta ZP_70		;2864 85 70
		rol ZP_71		;2866 26 71
		lda L_38E0,X	;2868 BD E0 38
		sec				;286B 38
		sbc #$03		;286C E9 03
		clc				;286E 18
		adc ZP_71		;286F 65 71
		sta ZP_71		;2871 85 71
		ldy #$04		;2873 A0 04
L_2875	lda #$C0		;2875 A9 C0
		eor (ZP_70),Y	;2877 51 70
		sta (ZP_70),Y	;2879 91 70
		dey				;287B 88
		bne L_2875		;287C D0 F7
		lda #$F0		;287E A9 F0
		eor (ZP_70),Y	;2880 51 70
		sta (ZP_70),Y	;2882 91 70
		iny				;2884 C8
		lda #$30		;2885 A9 30
		eor (ZP_70),Y	;2887 51 70
		sta (ZP_70),Y	;2889 91 70
		lda ZP_71		;288B A5 71
		clc				;288D 18
		adc #$04		;288E 69 04
		sta ZP_71		;2890 85 71
		ldy #$03		;2892 A0 03
L_2894	lda #$C0		;2894 A9 C0
		eor (ZP_70),Y	;2896 51 70
		sta (ZP_70),Y	;2898 91 70
		iny				;289A C8
		cpy #$06		;289B C0 06
		bne L_2894		;289D D0 F5
		lda #$F0		;289F A9 F0
		eor (ZP_70),Y	;28A1 51 70
		sta (ZP_70),Y	;28A3 91 70
		iny				;28A5 C8
		lda #$F0		;28A6 A9 F0
		eor (ZP_70),Y	;28A8 51 70
		sta (ZP_70),Y	;28AA 91 70
		clc				;28AC 18
		lda ZP_70		;28AD A5 70
		adc #$28		;28AF 69 28
		sta ZP_70		;28B1 85 70
		lda #$00		;28B3 A9 00
		adc ZP_71		;28B5 65 71
		sta ZP_71		;28B7 85 71
		ldy #$03		;28B9 A0 03
L_28BB	lda #$30		;28BB A9 30
		eor (ZP_70),Y	;28BD 51 70
		sta (ZP_70),Y	;28BF 91 70
		iny				;28C1 C8
		cpy #$06		;28C2 C0 06
		bne L_28BB		;28C4 D0 F5
		lda #$F0		;28C6 A9 F0
		eor (ZP_70),Y	;28C8 51 70
		sta (ZP_70),Y	;28CA 91 70
		iny				;28CC C8
		lda #$F0		;28CD A9 F0
		eor (ZP_70),Y	;28CF 51 70
		sta (ZP_70),Y	;28D1 91 70
		lda ZP_71		;28D3 A5 71
		sec				;28D5 38
		sbc #$04		;28D6 E9 04
		sta ZP_71		;28D8 85 71
		ldy #$04		;28DA A0 04
L_28DC	lda #$30		;28DC A9 30
		eor (ZP_70),Y	;28DE 51 70
		sta (ZP_70),Y	;28E0 91 70
		dey				;28E2 88
		bne L_28DC		;28E3 D0 F7
		lda #$F0		;28E5 A9 F0
		eor (ZP_70),Y	;28E7 51 70
		sta (ZP_70),Y	;28E9 91 70
		iny				;28EB C8
		lda #$C0		;28EC A9 C0
		eor (ZP_70),Y	;28EE 51 70
		sta (ZP_70),Y	;28F0 91 70
		pla				;28F2 68
		tax				;28F3 AA
		rts				;28F4 60
L_28F5	lda #$E2		;28F5 A9 E2
		sta ZP_70		;28F7 85 70
		lda #$2C		;28F9 A9 2C
		sta ZP_71		;28FB 85 71
		lda #$D0		;28FD A9 D0
		sta ZP_72		;28FF 85 72
		lda #$7C		;2901 A9 7C
		sta ZP_73		;2903 85 73
		ldy #$90		;2905 A0 90
L_2907	dey				;2907 88
		lda (ZP_70),Y	;2908 B1 70
		sta (ZP_72),Y	;290A 91 72
		cpy #$00		;290C C0 00
		bne L_2907		;290E D0 F7
		lda #$0F		;2910 A9 0F
		sta L_3060		;2912 8D 60 30
		lda #$20		;2915 A9 20
		sta ZP_70		;2917 85 70
		lda #$1E		;2919 A9 1E
		sta ZP_77		;291B 85 77
		lda #$05		;291D A9 05
		sta ZP_74		;291F 85 74
		lda #$30		;2921 A9 30
		sta ZP_75		;2923 85 75
		ldx #$00		;2925 A2 00
		jsr L_2A08		;2927 20 08 2A
		lda #$2A		;292A A9 2A
		sta ZP_70		;292C 85 70
		lda #$1E		;292E A9 1E
		sta ZP_77		;2930 85 77
		lda #$04		;2932 A9 04
		sta ZP_74		;2934 85 74
		lda #$30		;2936 A9 30
		sta ZP_75		;2938 85 75
		ldx #$00		;293A A2 00
		jmp L_2A08		;293C 4C 08 2A
L_293F	pha				;293F 48
		txa				;2940 8A
		pha				;2941 48
		ldx #$00		;2942 A2 00
		txa				;2944 8A
L_2945	dex				;2945 CA
		sta L_7A98,X	;2946 9D 98 7A
		sta L_7C98,X	;2949 9D 98 7C
		sta L_7E98,X	;294C 9D 98 7E
		bne L_2945		;294F D0 F4
		lda #$C0		;2951 A9 C0
		sta L_7AF0		;2953 8D F0 7A
		sta L_7B40		;2956 8D 40 7B
		pla				;2959 68
		tax				;295A AA
		pla				;295B 68
		rts				;295C 60
L_295D	ldy L_307B		;295D AC 7B 30
		ldx #$00		;2960 A2 00
L_2962	jsr L_FFD7		;2962 20 D7 FF
		sta L_307F,X	;2965 9D 7F 30
		inx				;2968 E8
		cpx #$5F		;2969 E0 5F
		bne L_2962		;296B D0 F5
		rts				;296D 60
L_296E	lda #$C0		;296E A9 C0
		sta L_3069		;2970 8D 69 30
		lda #$0A		;2973 A9 0A
		sta L_306A		;2975 8D 6A 30
		lda #$B0		;2978 A9 B0
		sta L_306B		;297A 8D 6B 30
		lda #$33		;297D A9 33
		sta L_306C		;297F 8D 6C 30
L_2982	ldy #$0D		;2982 A0 0D
		lda #$00		;2984 A9 00
L_2986	sta L_306D,Y	;2986 99 6D 30
		dey				;2989 88
		bne L_2986		;298A D0 FA
		ldx #$69		;298C A2 69
		ldy #$30		;298E A0 30
		lda #$FF		;2990 A9 FF
		jsr L_FFDD		;2992 20 DD FF
		rts				;2995 60
L_2996	lda #$0F		;2996 A9 0F
		sta L_3060		;2998 8D 60 30
		lda #$08		;299B A9 08
		sta ZP_70		;299D 85 70
		lda #$1F		;299F A9 1F
		sta ZP_77		;29A1 85 77
		lda #$00		;29A3 A9 00
		sta ZP_74		;29A5 85 74
		lda #$30		;29A7 A9 30
		sta ZP_75		;29A9 85 75
		ldx #$03		;29AB A2 03
		jmp L_2A08		;29AD 4C 08 2A
L_29B0	lda #$FF		;29B0 A9 FF
		sta L_3060		;29B2 8D 60 30
		lda #$08		;29B5 A9 08
		sta ZP_70		;29B7 85 70
		lda #$1E		;29B9 A9 1E
		sta ZP_77		;29BB 85 77
		lda #$09		;29BD A9 09
		sta ZP_74		;29BF 85 74
		lda #$30		;29C1 A9 30
		sta ZP_75		;29C3 85 75
		ldx #$02		;29C5 A2 02
		jmp L_2A08		;29C7 4C 08 2A
L_29CA	lda #$F0		;29CA A9 F0
		sta L_3060		;29CC 8D 60 30
		lda #$3D		;29CF A9 3D
		sta ZP_70		;29D1 85 70
		lda #$1D		;29D3 A9 1D
		sta ZP_77		;29D5 85 77
		lda #$A0		;29D7 A9 A0
		clc				;29D9 18
		adc ZP_82		;29DA 65 82
		sta ZP_74		;29DC 85 74
		lda #$38		;29DE A9 38
		adc #$00		;29E0 69 00
		sta ZP_75		;29E2 85 75
		ldx #$00		;29E4 A2 00
		jsr L_2A08		;29E6 20 08 2A
		lda #$0F		;29E9 A9 0F
		sta L_3060		;29EB 8D 60 30
		lda #$3D		;29EE A9 3D
		sta ZP_70		;29F0 85 70
		lda #$1E		;29F2 A9 1E
		sta ZP_77		;29F4 85 77
		lda #$60		;29F6 A9 60
		clc				;29F8 18
		adc ZP_82		;29F9 65 82
		sta ZP_74		;29FB 85 74
		lda #$38		;29FD A9 38
		adc #$00		;29FF 69 00
		sta ZP_75		;2A01 85 75
		ldx #$00		;2A03 A2 00
		jmp L_2A08		;2A05 4C 08 2A
L_2A08	tya				;2A08 98
		pha				;2A09 48
		lda L_3060		;2A0A AD 60 30
		sta ZP_76		;2A0D 85 76
		txa				;2A0F 8A
		asl @			;2A10 0A
		adc ZP_70		;2A11 65 70
		asl @			;2A13 0A
		asl @			;2A14 0A
		sta ZP_72		;2A15 85 72
		lda #$20		;2A17 A9 20
		asl ZP_72		;2A19 06 72
		rol @			;2A1B 2A
		sta ZP_73		;2A1C 85 73
		lda ZP_77		;2A1E A5 77
		asl @			;2A20 0A
		adc ZP_73		;2A21 65 73
		sta ZP_73		;2A23 85 73
		lda #$0A		;2A25 A9 0A
		sta ZP_71		;2A27 85 71
L_2A29	txa				;2A29 8A
		tay				;2A2A A8
		lda (ZP_74),Y	;2A2B B1 74
		lsr @			;2A2D 4A
		and #$78		;2A2E 29 78
		sta ZP_70		;2A30 85 70
		ldy #$07		;2A32 A0 07
L_2A34	lda (ZP_70),Y	;2A34 B1 70
		and ZP_76		;2A36 25 76
		sta (ZP_72),Y	;2A38 91 72
		dey				;2A3A 88
		bpl L_2A34		;2A3B 10 F7
		txa				;2A3D 8A
		tay				;2A3E A8
		lda (ZP_74),Y	;2A3F B1 74
		asl @			;2A41 0A
		asl @			;2A42 0A
		asl @			;2A43 0A
		and #$78		;2A44 29 78
		sta ZP_70		;2A46 85 70
		lda ZP_72		;2A48 A5 72
		clc				;2A4A 18
		adc #$08		;2A4B 69 08
		sta ZP_72		;2A4D 85 72
		lda ZP_73		;2A4F A5 73
		adc #$00		;2A51 69 00
		sta ZP_73		;2A53 85 73
		ldy #$07		;2A55 A0 07
L_2A57	lda (ZP_70),Y	;2A57 B1 70
		and ZP_76		;2A59 25 76
		sta (ZP_72),Y	;2A5B 91 72
		dey				;2A5D 88
		bpl L_2A57		;2A5E 10 F7
		sec				;2A60 38
		lda ZP_72		;2A61 A5 72
		sbc #$18		;2A63 E9 18
		sta ZP_72		;2A65 85 72
		lda ZP_73		;2A67 A5 73
		sbc #$00		;2A69 E9 00
		sta ZP_73		;2A6B 85 73
		dex				;2A6D CA
		bpl L_2A29		;2A6E 10 B9
		pla				;2A70 68
		tay				;2A71 A8
		rts				;2A72 60
L_2A73	dta $58,$50,$50,$44,$3C,$34
;asc	dta c"XPPD<4"
;vid	dta $58,$50,$50,$44,d"\T"
L_2A79	dta $14,$0F,$05,$0A,$0A,$14
;asc	dta $14,$0F,$05,$0A,$0A,$14
;vid	dta d"4/%**4"
L_2A7F	lda #$4B		;2A7F A9 4B
		jsr L_1EDA		;2A81 20 DA 1E
		ldx #$00		;2A84 A2 00
L_2A86	txa				;2A86 8A
		pha				;2A87 48
		ldy L_2A79,X	;2A88 BC 79 2A
		lda L_2A73,X	;2A8B BD 73 2A
		tax				;2A8E AA
		lda #$03		;2A8F A9 03
		jsr L_2687		;2A91 20 87 26
		pla				;2A94 68
		tax				;2A95 AA
		inx				;2A96 E8
		cpx #$06		;2A97 E0 06
		bne L_2A86		;2A99 D0 EB
		lda #$84		;2A9B A9 84
		sta L_2BAE		;2A9D 8D AE 2B
		lda #$08		;2AA0 A9 08
		sta L_2BC1		;2AA2 8D C1 2B
		lda #$5F		;2AA5 A9 5F
		sta L_2B80		;2AA7 8D 80 2B
		lda #$0C		;2AAA A9 0C
		sta L_2B81		;2AAC 8D 81 2B
		lda #$00		;2AAF A9 00
		sta ZP_73		;2AB1 85 73
		lda #$78		;2AB3 A9 78
		sta ZP_70		;2AB5 85 70
		lda #$56		;2AB7 A9 56
		sta ZP_71		;2AB9 85 71
		jsr L_2B6B		;2ABB 20 6B 2B
		lda #$FA		;2ABE A9 FA
		jmp L_1EDA		;2AC0 4C DA 1E
L_2AC3	lda #$19		;2AC3 A9 19
		jsr L_1EDA		;2AC5 20 DA 1E
		lda #$44		;2AC8 A9 44
		sta L_2BAE		;2ACA 8D AE 2B
		lda #$10		;2ACD A9 10
		sta L_2BC1		;2ACF 8D C1 2B
		lda #$71		;2AD2 A9 71
		sta L_2B80		;2AD4 8D 80 2B
		lda #$0B		;2AD7 A9 0B
		sta L_2B81		;2AD9 8D 81 2B
		lda #$00		;2ADC A9 00
		sta ZP_73		;2ADE 85 73
		lda #$78		;2AE0 A9 78
		sta ZP_70		;2AE2 85 70
		lda #$68		;2AE4 A9 68
		sta ZP_71		;2AE6 85 71
		lda #$EB		;2AE8 A9 EB
		sta L_2B96		;2AEA 8D 96 2B
		lda #$0C		;2AED A9 0C
		sta L_2B97		;2AEF 8D 97 2B
		jsr L_2B75		;2AF2 20 75 2B
		ldx #$00		;2AF5 A2 00
L_2AF7	txa				;2AF7 8A
		pha				;2AF8 48
		ldy L_2CDD,X	;2AF9 BC DD 2C
		lda L_2CD8,X	;2AFC BD D8 2C
		tax				;2AFF AA
		lda #$03		;2B00 A9 03
		jsr L_2699		;2B02 20 99 26
		pla				;2B05 68
		tax				;2B06 AA
		inx				;2B07 E8
		cpx #$05		;2B08 E0 05
		bne L_2AF7		;2B0A D0 EB
		lda #$FA		;2B0C A9 FA
		jmp L_1EDA		;2B0E 4C DA 1E
L_2B11	ldx #$00		;2B11 A2 00
L_2B13	txa				;2B13 8A
		pha				;2B14 48
		ldy L_09EF,X	;2B15 BC EF 09
		lda L_09E8,X	;2B18 BD E8 09
		tax				;2B1B AA
		lda #$03		;2B1C A9 03
		jsr L_2699		;2B1E 20 99 26
		pla				;2B21 68
		tax				;2B22 AA
		pha				;2B23 48
		ldy L_09EF,X	;2B24 BC EF 09
		lda L_09E8,X	;2B27 BD E8 09
		tax				;2B2A AA
		lda #$01		;2B2B A9 01
		jsr L_2699		;2B2D 20 99 26
		pla				;2B30 68
		tax				;2B31 AA
		inx				;2B32 E8
		cpx #$07		;2B33 E0 07
		bne L_2B13		;2B35 D0 DC
		lda #$AA		;2B37 A9 AA
		sta L_2BAE		;2B39 8D AE 2B
		lda #$10		;2B3C A9 10
		sta L_2BC1		;2B3E 8D C1 2B
		lda #$B5		;2B41 A9 B5
		sta L_2B80		;2B43 8D 80 2B
		lda #$0B		;2B46 A9 0B
		sta L_2B81		;2B48 8D 81 2B
		ldx #$0F		;2B4B A2 0F
L_2B4D	txa				;2B4D 8A
		pha				;2B4E 48
		and #$01		;2B4F 29 01
		asl @			;2B51 0A
		asl @			;2B52 0A
		sta ZP_73		;2B53 85 73
		lda #$70		;2B55 A9 70
		sta ZP_70		;2B57 85 70
		lda #$56		;2B59 A9 56
		sta ZP_71		;2B5B 85 71
		jsr L_2B6B		;2B5D 20 6B 2B
		lda #$19		;2B60 A9 19
		jsr L_1EDA		;2B62 20 DA 1E
		pla				;2B65 68
		tax				;2B66 AA
		dex				;2B67 CA
		bne L_2B4D		;2B68 D0 E3
		rts				;2B6A 60
L_2B6B	lda #$E3		;2B6B A9 E3
		sta L_2B96		;2B6D 8D 96 2B
		lda #$0C		;2B70 A9 0C
		sta L_2B97		;2B72 8D 97 2B
L_2B75	ldx #$00		;2B75 A2 00
		stx ZP_77		;2B77 86 77
L_2B79	ldy #$00		;2B79 A0 00
		sty ZP_72		;2B7B 84 72
L_2B7D	ldx ZP_77		;2B7D A6 77
		lda L_0BB5,X	;2B7F BD B5 0B
L_2B80	equ *-2			;!
L_2B81	equ *-1			;!
		sta ZP_74		;2B82 85 74
		lda #$04		;2B84 A9 04
		sta ZP_78		;2B86 85 78
L_2B88	lda ZP_74		;2B88 A5 74
		and #$03		;2B8A 29 03
		clc				;2B8C 18
		adc ZP_73		;2B8D 65 73
		tax				;2B8F AA
		lda #$00		;2B90 A9 00
		sta (ZP_70),Y	;2B92 91 70
		iny				;2B94 C8
		lda L_0CE3,X	;2B95 BD E3 0C
L_2B96	equ *-2			;!
L_2B97	equ *-1			;!
		sta (ZP_70),Y	;2B98 91 70
		lsr ZP_74		;2B9A 46 74
		lsr ZP_74		;2B9C 46 74
		iny				;2B9E C8
		lda ZP_73		;2B9F A5 73
		eor #$04		;2BA1 49 04
		sta ZP_73		;2BA3 85 73
		dec ZP_78		;2BA5 C6 78
		bne L_2B88		;2BA7 D0 DF
		inc ZP_77		;2BA9 E6 77
		lda ZP_77		;2BAB A5 77
		cmp #$BE		;2BAD C9 BE
L_2BAE	equ *-1			;!
		beq L_2BC9		;2BAF F0 18
		lda ZP_72		;2BB1 A5 72
		bne L_2BC0		;2BB3 D0 0B
		cpy #$00		;2BB5 C0 00
		bne L_2B7D		;2BB7 D0 C4
		inc ZP_72		;2BB9 E6 72
		inc ZP_71		;2BBB E6 71
		jmp L_2B7D		;2BBD 4C 7D 2B
L_2BC0	cpy #$30		;2BC0 C0 30
L_2BC1	equ *-1			;!
		bcc L_2B7D		;2BC2 90 B9
		inc ZP_71		;2BC4 E6 71
		jmp L_2B79		;2BC6 4C 79 2B
L_2BC9	rts				;2BC9 60
L_2BCA	and #$1F		;2BCA 29 1F
		sta L_309E,Y	;2BCC 99 9E 30
		tya				;2BCF 98
		pha				;2BD0 48
		txa				;2BD1 8A
		pha				;2BD2 48
		lda L_309E,Y	;2BD3 B9 9E 30
		sec				;2BD6 38
		sbc #$01		;2BD7 E9 01
		asl @			;2BD9 0A
		asl @			;2BDA 0A
		adc ZP_80		;2BDB 65 80
		cmp L_307D		;2BDD CD 7D 30
		beq L_2C15		;2BE0 F0 33
		sta L_307D		;2BE2 8D 7D 30
		tax				;2BE5 AA
		lda L_0A70,X	;2BE6 BD 70 0A
		sta ZP_78		;2BE9 85 78
		lda L_0A90,X	;2BEB BD 90 0A
		sta ZP_79		;2BEE 85 79
		ldy #$37		;2BF0 A0 37
L_2BF2	ldx #$04		;2BF2 A2 04
		lda #$11		;2BF4 A9 11
		sta ZP_72		;2BF6 85 72
		lda #$00		;2BF8 A9 00
		sta ZP_73		;2BFA 85 73
L_2BFC	lda (ZP_78),Y	;2BFC B1 78
		and ZP_72		;2BFE 25 72
		beq L_2C08		;2C00 F0 06
		lda ZP_73		;2C02 A5 73
		ora ZP_72		;2C04 05 72
		sta ZP_73		;2C06 85 73
L_2C08	asl ZP_72		;2C08 06 72
		dex				;2C0A CA
		bne L_2BFC		;2C0B D0 EF
		lda ZP_73		;2C0D A5 73
		sta L_2FC8,Y	;2C0F 99 C8 2F
		dey				;2C12 88
		bpl L_2BF2		;2C13 10 DD
L_2C15	lda #$2F		;2C15 A9 2F
		sta ZP_79		;2C17 85 79
		lda #$C8		;2C19 A9 C8
		sta ZP_78		;2C1B 85 78
		pla				;2C1D 68
		tax				;2C1E AA
		pla				;2C1F 68
		tay				;2C20 A8
		rts				;2C21 60
L_2C22	lda #$65		;2C22 A9 65
		sta L_3069		;2C24 8D 69 30
		lda #$0B		;2C27 A9 0B
		sta L_306A		;2C29 8D 6A 30
		lda #$10		;2C2C A9 10
		sta L_306B		;2C2E 8D 6B 30
		lda #$31		;2C31 A9 31
		sta L_306C		;2C33 8D 6C 30
		jmp L_2982		;2C36 4C 82 29
L_2C39	lda #$27		;2C39 A9 27
		sta L_09DC		;2C3B 8D DC 09
		lda #$A7		;2C3E A9 A7
		sta L_09DD		;2C40 8D DD 09
		lda #$87		;2C43 A9 87
		sta L_09DE		;2C45 8D DE 09
		lda #$3D		;2C48 A9 3D
		sta L_09E0		;2C4A 8D E0 09
		lda #$09		;2C4D A9 09
		sta L_09E2		;2C4F 8D E2 09
		jsr L_2C94		;2C52 20 94 2C
		lda L_3005		;2C55 AD 05 30
		and #$0F		;2C58 29 0F
		ora #$30		;2C5A 09 30
		sta L_0AC6		;2C5C 8D C6 0A
		lda #$C4		;2C5F A9 C4
		sta L_3069		;2C61 8D 69 30
		lda #$0A		;2C64 A9 0A
		sta L_306A		;2C66 8D 6A 30
		lda #$E0		;2C69 A9 E0
		sta L_306B		;2C6B 8D 6B 30
		lda #$38		;2C6E A9 38
		sta L_306C		;2C70 8D 6C 30
		jsr L_2982		;2C73 20 82 29
		lda #$26		;2C76 A9 26
		sta L_09DC		;2C78 8D DC 09
		lda #$A1		;2C7B A9 A1
		sta L_09DD		;2C7D 8D DD 09
		lda #$85		;2C80 A9 85
		sta L_09DE		;2C82 8D DE 09
		lda #$3F		;2C85 A9 3F
		sta L_09E0		;2C87 8D E0 09
		lda #$07		;2C8A A9 07
		sta L_09E2		;2C8C 8D E2 09
		lda #$32		;2C8F A9 32
		jmp L_1EDA		;2C91 4C DA 1E
L_2C94	lda #$05		;2C94 A9 05
		sta ZP_8E		;2C96 85 8E
		lda #$74		;2C98 A9 74
		sta ZP_8F		;2C9A 85 8F
		lda #$03		;2C9C A9 03
		sta ZP_8D		;2C9E 85 8D
		lda #$0C		;2CA0 A9 0C
		sta ZP_8B		;2CA2 85 8B
L_2CA4	lda ZP_8E		;2CA4 A5 8E
		sta ZP_8C		;2CA6 85 8C
		lda ZP_8F		;2CA8 A5 8F
		sta ZP_8D		;2CAA 85 8D
		ldx #$40		;2CAC A2 40
		ldy #$00		;2CAE A0 00
L_2CB0	tya				;2CB0 98
		sta (ZP_8C),Y	;2CB1 91 8C
		lda ZP_8C		;2CB3 A5 8C
		clc				;2CB5 18
		adc #$08		;2CB6 69 08
		sta ZP_8C		;2CB8 85 8C
		lda ZP_8D		;2CBA A5 8D
		adc #$00		;2CBC 69 00
		sta ZP_8D		;2CBE 85 8D
		dex				;2CC0 CA
		bne L_2CB0		;2CC1 D0 ED
		lda ZP_8E		;2CC3 A5 8E
		cmp #$07		;2CC5 C9 07
		bne L_2CD1		;2CC7 D0 08
		inc ZP_8F		;2CC9 E6 8F
		inc ZP_8F		;2CCB E6 8F
		lda #$FF		;2CCD A9 FF
		sta ZP_8E		;2CCF 85 8E
L_2CD1	inc ZP_8E		;2CD1 E6 8E
		dec ZP_8B		;2CD3 C6 8B
		bne L_2CA4		;2CD5 D0 CD
		rts				;2CD7 60
L_2CD8	dta $6C,$7C,$88,$7C,$80
;asc	dta c"l|",$88,c"|",$80
;vid	dta d"l|",d"("*,d"|",d" "*
L_2CDD	dta $05,$05,$05,$05,$0A,$07,$02,$02,$02,$02,$02,$07,$00,$00,$00,$00
;asc	dta $05,$05,$05,$05,$0A,$07,$02,$02,$02,$02,$02,$07,$00,$00,$00,$00
;vid	dta d"%%%%*'""""""""""'    "
		dta $00,$00,$02,$0E,$00,$00,$00,$06,$09,$0F,$08,$07,$00,$00,$00,$05
;asc	dta $00,$00,$02,$0E,$00,$00,$00,$06,$09,$0F,$08,$07,$00,$00,$00,$05
;vid	dta d"  "".   &)/('   %"
		dta $05,$05,$05,$02,$00,$00,$00,$03,$04,$07,$04,$03,$00,$06,$02,$02
;asc	dta $05,$05,$05,$02,$00,$00,$00,$03,$04,$07,$04,$03,$00,$06,$02,$02
;vid	dta d"%%%""   #$'$# &"""""
		dta $0A,$0A,$02,$09,$00,$F0,$91,$91,$91,$91,$91,$F0,$00,$F0,$98,$98
;asc	dta $0A,$0A,$02,$09,$00,c"p"*,$91,$91,$91,$91,$91,c"p"*,$00,c"p"*,$98,$98
;vid	dta d"**"") ",d"p11111p"*,d" ",d"p88"*
		dta $98,$98,$98,$F0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $98,$98,$98,c"p"*,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"888p"*,d"            "
		dta $00,$00,$00,$00,$00,$03,$01,$01,$00,$00,$00,$00,$00,$08,$00,$00
;asc	dta $00,$00,$00,$00,$00,$03,$01,$01,$00,$00,$00,$00,$00,$08,$00,$00
;vid	dta d"     #!!     (  "
		dta $0A,$0A,$07,$05,$00,$0E,$04,$04,$09,$09,$01,$00,$00,$00,$00,$0C
;asc	dta $0A,$0A,$07,$05,$00,$0E,$04,$04,$09,$09,$01,$00,$00,$00,$00,$0C
;vid	dta d"**'% .$$))!    ,"
		dta $02,$02,$02,$0E,$00,$00,$00,$0A,$0A,$0A,$0A,$04,$00,$00,$00,$06
;asc	dta $02,$02,$02,$0E,$00,$00,$00,$0A,$0A,$0A,$0A,$04,$00,$00,$00,$06
;vid	dta d""""""".   ****$   &"
		dta $09,$0F,$08,$07,$00,$F0,$91,$91,$91,$91,$91,$F0,$00,$F0,$98,$98
;asc	dta $09,$0F,$08,$07,$00,c"p"*,$91,$91,$91,$91,$91,c"p"*,$00,c"p"*,$98,$98
;vid	dta d")/(' ",d"p11111p"*,d" ",d"p88"*
		dta $98,$98,$98,$F0,$00,$F0,$F0,$F0,$E0,$E0,$E0,$E0,$E0,$F0,$80,$66
;asc	dta $98,$98,$98,c"p"*,$00,c"ppp`````p"*,$80,c"f"
;vid	dta d"888p"*,d" ",d"ppp`````p "*,d"f"
		dta $CC,$8A,$05,$0B,$07,$C0,$D1,$C0,$01,$84,$4B,$2D,$5A,$10,$D8,$10
;asc	dta c"L"*,$8A,$05,$0B,$07,c"@Q@"*,$01,$84,c"K-Z",$10,c"X"*,$10
;vid	dta $CC,d"*"*,d"%+'",$C0,$D1,$C0,d"!",d"$"*,$4B,d"M",$5A,d"0",$D8,d"0"
		dta $0C,$01,$0F,$A5,$5A,$F0,$80,$B1,$10,$0A,$49,$A4,$5A,$F0,$F0,$70
;asc	dta $0C,$01,$0F,c"%"*,c"Z",c"p"*,$80,c"1"*,$10,$0A,c"I",c"$"*,c"Z",c"pp"*,c"p"
;vid	dta d",!/",d"E"*,$5A,d"p Q"*,d"0*",$49,d"D"*,$5A,d"pp"*,d"p"
		dta $B8,$B0,$30,$38,$30,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$8B,$DC,$66
;asc	dta c"80"*,c"080",c"````````"*,$8B,c"\"*,c"f"
;vid	dta d"XP"*,d"PXP",d"````````+"*,$DC,d"f"
		dta $08,$86,$4A,$C3,$4A,$A5,$5A,$84,$59,$84,$41,$09,$0E,$A5,$5A,$01
;asc	dta $08,$86,c"J",c"C"*,c"J",c"%"*,c"Z",$84,c"Y",$84,c"A",$09,$0E,c"%"*,c"Z",$01
;vid	dta d"(",d"&"*,$4A,$C3,$4A,d"E"*,$5A,d"$"*,$59,d"$"*,$41,d").",d"E"*,$5A,d"!"
		dta $D8,$01,$1C,$0C,$03,$A4,$58,$B1,$08,$83,$02,$0F,$0A,$B0,$B8,$30
;asc	dta c"X"*,$01,$1C,$0C,$03,c"$"*,c"X",c"1"*,$08,$83,$02,$0F,$0A,c"08"*,c"0"
;vid	dta $D8,d"!<,#",d"D"*,$58,d"Q"*,d"(",d"#"*,d"""/*",d"PX"*,d"P"
		dta $38,$30,$38,$30,$38,$C0,$A0,$C0,$A0,$D0,$A0,$D0,$E0,$E0,$4A,$E0
;asc	dta c"80808",c"@ @ P P``"*,c"J",c"`"*
;vid	dta d"XPXPX",$C0,d"@"*,$C0,d"@"*,$D0,d"@"*,$D0,d"``"*,$4A,d"`"*
		dta $4B,$61,$43,$21,$80,$07,$07,$07,$0E,$0C,$1C,$0C,$10,$07,$0F,$07
;asc	dta c"KaC!",$80,$07,$07,$07,$0E,$0C,$1C,$0C,$10,$07,$0F,$07
;vid	dta $4B,d"a",$43,d"A",d" "*,d"'''.,<,0'/'"
		dta $03,$01,$41,$81,$C0,$01,$02,$01,$0E,$0D,$0A,$0C,$00,$10,$28,$10
;asc	dta $03,$01,c"A",$81,c"@"*,$01,$02,$01,$0E,$0D,$0A,$0C,$00,$10,c"(",$10
;vid	dta d"#!",$41,d"!"*,$C0,d"!""!.-*, 0H0"
		dta $28,$10,$20,$50,$B0,$80,$77,$00,$61,$43,$00,$27,$00,$70,$B8,$30
;asc	dta c"(",$10,c" P",c"0"*,$80,c"w",$00,c"aC",$00,c"'",$00,c"p",c"8"*,c"0"
;vid	dta d"H0@",$50,d"P "*,d"w a",$43,d" G p",d"X"*,d"P"
		dta $38,$08,$06,$1D,$15,$F0,$E0,$D1,$B3,$66,$FE,$CC,$FE,$F0,$70,$B8
;asc	dta c"8",$08,$06,$1D,$15,c"p`Q3"*,c"f",c"~L~p"*,c"p",c"8"*
;vid	dta d"X(&=5",d"p`"*,$D1,d"S"*,d"f",d"~"*,$CC,d"~p"*,d"p",d"X"*
		dta $D8,$20,$D8,$20,$D9,$E0,$D1,$C0,$D0,$10,$26,$93,$02,$10,$EE,$00
;asc	dta c"X"*,c" ",c"X"*,c" ",c"Y`Q@P"*,$10,c"&",$93,$02,$10,c"n"*,$00
;vid	dta $D8,d"@",$D8,d"@",$D9,d"`"*,$D1,$C0,$D0,d"0F",d"3"*,d"""0",d"n"*,d" "
		dta $86,$0E,$00,$0E,$00,$77,$77,$00,$43,$61,$43,$61,$43,$99,$8A,$23
;asc	dta $86,$0E,$00,$0E,$00,c"ww",$00,c"CaCaC",$99,$8A,c"#"
;vid	dta d"&"*,d". . ww ",$43,d"a",$43,d"a",$43,d"9*"*,d"C"
		dta $1B,$08,$0F,$0F,$03,$88,$FA,$00,$5F,$00,$0F,$1F,$2E,$22,$D8,$00
;asc	dta $1B,$08,$0F,$0F,$03,$88,c"z"*,$00,c"_",$00,$0F,$1F,c".""",c"X"*,$00
;vid	dta d";(//#",d"(z"*,d" ",$5F,d" /?NB",$D8,d" "
		dta $0F,$00,$0F,$8F,$47,$91,$15,$0C,$1C,$10,$0F,$0F,$0C,$EE,$EE,$00
;asc	dta $0F,$00,$0F,$8F,c"G",$91,$15,$0C,$1C,$10,$0F,$0F,$0C,c"nn"*,$00
;vid	dta d"/ /",d"/"*,$47,d"1"*,d"5,<0//,",d"nn"*,d" "
		dta $86,$0C,$0E,$0C,$0A,$60,$42,$60,$42,$61,$83,$A1,$C0,$CD,$C9,$C1
;asc	dta $86,$0C,$0E,$0C,$0A,c"`B`Ba",$83,c"!@MIA"*
;vid	dta d"&"*,d",.,*`",$42,d"`",$42,d"a",d"#A"*,$C0,$CD,$C9,$C1
		dta $01,$0F,$0F,$0F,$00,$4C,$4C,$88,$88,$88,$A8,$98,$70,$23,$23,$11
;asc	dta $01,$0F,$0F,$0F,$00,c"LL",$88,$88,$88,c"("*,$98,c"p##",$11
;vid	dta d"!/// ",$4C,$4C,d"(((H8"*,d"pCC1"
		dta $11,$11,$91,$51,$E0,$3B,$3A,$38,$08,$0F,$0E,$05,$00,$04,$02,$04
;asc	dta $11,$11,$91,c"Q",c"`"*,c";:8",$08,$0F,$0E,$05,$00,$04,$02,$04
;vid	dta d"11",d"1"*,$51,d"`"*,d"[ZX(/.% $""$"
		dta $02,$04,$18,$14,$30,$80,$77,$00,$70,$70,$00,$77,$77,$70,$B8,$30
;asc	dta $02,$04,$18,$14,c"0",$80,c"w",$00,c"pp",$00,c"wwp",c"8"*,c"0"
;vid	dta d"""$84P",d" "*,d"w pp wwp",d"X"*,d"P"
		dta $80,$F0,$77,$BB,$B9,$F0,$C0,$B3,$00,$F0,$FF,$CC,$BB,$F0,$30,$DC
;asc	dta $80,c"p"*,c"w",c";9p@3"*,$00,c"p"*,$FF,c"L;p"*,c"0",c"\"*
;vid	dta d" p"*,d"w",d"[Yp"*,$C0,d"S"*,d" ",d"p"*,$FF,$CC,d"[p"*,d"P",$DC
		dta $00,$F0,$FF,$33,$DD,$E0,$D1,$C0,$10,$F0,$EE,$DD,$DD,$10,$EE,$00
;asc	dta $00,c"p"*,$FF,c"3",c"]`Q@"*,$10,c"pn]]"*,$10,c"n"*,$00
;vid	dta d" ",d"p"*,$FF,d"S",$DD,d"`"*,$D1,$C0,d"0",d"pn"*,$DD,$DD,d"0",d"n"*,d" "
		dta $E0,$E0,$00,$EE,$EE,$00,$75,$76,$75,$66,$44,$44,$44,$30,$B0,$88
;asc	dta c"``"*,$00,c"nn"*,$00,c"uvufDDD0",c"0"*,$88
;vid	dta d"``"*,d" ",d"nn"*,d" uvuf",$44,$44,$44,d"P",d"P("*
		dta $F5,$D8,$C4,$C8,$C4,$88,$B1,$32,$F5,$FA,$F5,$EB,$C6,$10,$D4,$C8
;asc	dta c"uXDHD"*,$88,c"1"*,c"2",c"uzukF"*,$10,c"TH"*
;vid	dta d"u"*,$D8,$C4,$C8,$C4,d"(Q"*,d"R",d"uzuk"*,$C6,d"0",$D4,$C8
		dta $F5,$FA,$F5,$7A,$35,$CC,$D5,$10,$F5,$BA,$31,$32,$31,$00,$E4,$EA
;asc	dta c"uzu"*,c"z5",c"LU"*,$10,c"u:"*,c"121",$00,c"dj"*
;vid	dta d"uzu"*,d"zU",$CC,$D5,d"0",d"uZ"*,d"QRQ ",d"dj"*
		dta $EC,$66,$20,$22,$20,$47,$65,$56,$21,$54,$20,$90,$C0,$CB,$E5,$DA
;asc	dta c"l"*,c"f "" GeV!T ",$90,c"@KeZ"*
;vid	dta d"l"*,d"f@B@",$47,d"e",$56,d"A",$54,d"@",d"0"*,$C0,$CB,d"e"*,$DA
		dta $E5,$52,$A0,$50,$00,$8C,$80,$08,$00,$11,$22,$50,$F0,$12,$11,$01
;asc	dta c"e"*,c"R",c" "*,c"P",$00,$8C,$80,$08,$00,$11,c"""P",c"p"*,$12,$11,$01
;vid	dta d"e"*,$52,d"@"*,$50,d" ",d", "*,d"( 1B",$50,d"p"*,d"21!"
		dta $00,$44,$AA,$40,$F0,$3E,$B5,$7A,$B5,$7A,$A0,$50,$00,$2E,$A4,$48
;asc	dta $00,c"D",c"*"*,c"@",c"p"*,c">",c"5"*,c"z",c"5"*,c"z",c" "*,c"P",$00,c".",c"$"*,c"H"
;vid	dta d" ",$44,d"J"*,$40,d"p"*,d"^",d"U"*,d"z",d"U"*,d"z",d"@"*,$50,d" N",d"D"*,$48
		dta $A4,$40,$A0,$50,$30,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
;asc	dta c"$"*,c"@",c" "*,c"P0",c"ppppppppppp"*
;vid	dta d"D"*,$40,d"@"*,$50,d"P",d"ppppppppppp"*
		dta $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
;asc	dta c"pppppppppppppppp"*
;vid	dta d"pppppppppppppppp"*
		dta $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
;asc	dta c"pppppppppppppppp"*
;vid	dta d"pppppppppppppppp"*
		dta $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
;asc	dta c"pppppppppppppppp"*
;vid	dta d"pppppppppppppppp"*
		dta $E0,$D0,$A0,$D0,$A0,$F0,$F0,$D0,$A0,$70,$F0,$E0,$F0,$F0,$F0,$50
;asc	dta c"`P P ppP "*,c"p",c"p`ppp"*,c"P"
;vid	dta d"`"*,$D0,d"@"*,$D0,d"@pp"*,$D0,d"@"*,d"p",d"p`ppp"*,$50
		dta $A0,$F0,$F0,$30,$F0,$F0,$F0,$F0,$B0,$50,$A0,$D0,$A0,$F0,$F0,$F0
;asc	dta c" pp"*,c"0",c"pppp0"*,c"P",c" P ppp"*
;vid	dta d"@pp"*,d"P",d"ppppP"*,$50,d"@"*,$D0,d"@ppp"*
		dta $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$D0,$E0,$F0
;asc	dta c"pppppppppppppP`p"*
;vid	dta d"ppppppppppppp"*,$D0,d"`p"*
		dta $F0,$F0,$F0,$F0,$F0,$70,$A0,$D0,$F0,$F0,$F0,$F0,$F0,$F0,$A0,$50
;asc	dta c"ppppp"*,c"p",c" Ppppppp "*,c"P"
;vid	dta d"ppppp"*,d"p",d"@"*,$D0,d"pppppp@"*,$50
		dta $F0,$F0,$F0,$F0,$F0,$50,$B0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
;asc	dta c"ppppp"*,c"P",c"0ppppppppp"*
;vid	dta d"ppppp"*,$50,d"Pppppppppp"*
		dta $F0,$F0,$F0,$F0,$F0
;asc	dta c"ppppp"*
;vid	dta d"ppppp"*
L_2FC8	equ $2FC8
L_2FFF	equ $2FFF
L_3000	equ $3000
L_3001	equ $3001
L_3002	equ $3002
L_3003	equ $3003
L_3004	equ $3004
L_3005	equ $3005
L_3006	equ $3006
L_3007	equ $3007
L_3008	equ $3008
L_3009	equ $3009
L_300A	equ $300A
L_300B	equ $300B
L_300C	equ $300C
L_300D	equ $300D
L_300E	equ $300E
L_300F	equ $300F
L_3010	equ $3010
L_3011	equ $3011
L_3012	equ $3012
L_3013	equ $3013
L_3014	equ $3014
L_3015	equ $3015
L_3016	equ $3016
L_3017	equ $3017
L_3018	equ $3018
L_3020	equ $3020
L_3028	equ $3028
L_3030	equ $3030
L_3038	equ $3038
L_3040	equ $3040
L_3041	equ $3041
L_3042	equ $3042
L_3043	equ $3043
L_3060	equ $3060
L_3061	equ $3061
L_3062	equ $3062
L_3063	equ $3063
L_3064	equ $3064
L_3066	equ $3066
L_3067	equ $3067
L_3068	equ $3068
L_3069	equ $3069
L_306A	equ $306A
L_306B	equ $306B
L_306C	equ $306C
L_306D	equ $306D
L_307B	equ $307B
L_307C	equ $307C
L_307D	equ $307D
L_307E	equ $307E
L_307F	equ $307F
L_3083	equ $3083
L_3087	equ $3087
L_308B	equ $308B
L_308C	equ $308C
L_308D	equ $308D
L_3091	equ $3091
L_309D	equ $309D
L_309E	equ $309E
L_30DD	equ $30DD
L_3490	equ $3490
L_3570	equ $3570
L_3650	equ $3650
L_3730	equ $3730
L_3810	equ $3810
L_3820	equ $3820
L_3830	equ $3830
L_3840	equ $3840
L_3850	equ $3850
L_3860	equ $3860
L_38A0	equ $38A0
L_38E0	equ $38E0
L_38F0	equ $38F0
L_3FFE	equ $3FFE
;
		org $4000
;
		dta $00,$00,$00,$00,$00,$00,$03,$04,$00,$00,$00,$00,$00,$00,$0F,$00
;asc	dta $00,$00,$00,$00,$00,$00,$03,$04,$00,$00,$00,$00,$00,$00,$0F,$00
;vid	dta d"      #$      / "
		dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$00,$00,$00,$00,$0F,$00
;asc	dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$00,$00,$00,$00,$0F,$00
;vid	dta d"      /       / "
		dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$00,$00,$00,$00,$0F,$00
;asc	dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$00,$00,$00,$00,$0F,$00
;vid	dta d"      /       / "
		dta $00,$00,$70,$80,$60,$10,$E0,$00,$00,$00,$40,$60,$40,$40,$20,$00
;asc	dta $00,$00,c"p",$80,c"`",$10,c"`"*,$00,$00,$00,c"@`@@ ",$00
;vid	dta d"  p",d" "*,d"`0",d"`"*,d"   ",$40,d"`",$40,$40,d"@ "
		dta $00,$00,$00,$C0,$60,$A0,$60,$00,$00,$00,$80,$D0,$90,$90,$40,$00
;asc	dta $00,$00,$00,c"@"*,c"`",c" "*,c"`",$00,$00,$00,$80,c"P"*,$90,$90,c"@",$00
;vid	dta d"   ",$C0,d"`",d"@"*,d"`   ",d" "*,$D0,d"00"*,$40,d" "
		dta $00,$00,$00,$40,$50,$40,$D0,$00,$00,$00,$00,$C0,$00,$C0,$83,$00
;asc	dta $00,$00,$00,c"@P@",c"P"*,$00,$00,$00,$00,c"@"*,$00,c"@"*,$83,$00
;vid	dta d"   ",$40,$50,$40,$D0,d"    ",$C0,d" ",$C0,d"#"*,d" "
		dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$00,$00,$00,$00,$0F,$00
;asc	dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$00,$00,$00,$00,$0F,$00
;vid	dta d"      /       / "
		dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$00,$00,$00,$00,$0F,$00
;asc	dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$00,$00,$00,$00,$0F,$00
;vid	dta d"      /       / "
		dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$00,$00,$00,$00,$08,$05
;asc	dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$00,$00,$00,$00,$08,$05
;vid	dta d"      /       (%"
		dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$00,$00,$00,$00,$0F,$00
;asc	dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$00,$00,$00,$00,$0F,$00
;vid	dta d"      /       / "
		dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$00,$00,$00,$00,$0F,$00
;asc	dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$00,$00,$00,$00,$0F,$00
;vid	dta d"      /       / "
		dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$80,$80,$80,$80,$E0,$00
;asc	dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$80,$80,$80,$80,c"`"*,$00
;vid	dta d"      /   ",d"    `"*,d" "
		dta $00,$00,$00,$A0,$A0,$A0,$40,$00,$00,$00,$80,$80,$80,$80,$87,$00
;asc	dta $00,$00,$00,c"   "*,c"@",$00,$00,$00,$80,$80,$80,$80,$87,$00
;vid	dta d"   ",d"@@@"*,$40,d"   ",d"    '"*,d" "
		dta $00,$00,$10,$10,$10,$10,$1E,$00,$00,$00,$E0,$10,$10,$10,$E0,$00
;asc	dta $00,$00,$10,$10,$10,$10,$1E,$00,$00,$00,c"`"*,$10,$10,$10,c"`"*,$00
;vid	dta d"  0000>   ",d"`"*,d"000",d"`"*,d" "
		dta $00,$00,$00,$70,$50,$50,$50,$00,$00,$00,$00,$80,$50,$50,$40,$00
;asc	dta $00,$00,$00,c"pPPP",$00,$00,$00,$00,$80,c"PP@",$00
;vid	dta d"   p",$50,$50,$50,d"    ",d" "*,$50,$50,$40,d" "
		dta $00,$00,$00,$C0,$20,$20,$E1,$20,$00,$00,$00,$00,$00,$00,$0F,$00
;asc	dta $00,$00,$00,c"@"*,c"  ",c"a"*,c" ",$00,$00,$00,$00,$00,$00,$0F,$00
;vid	dta d"   ",$C0,d"@@",d"a"*,d"@      / "
		dta $00,$00,$70,$80,$60,$10,$E0,$00,$00,$00,$40,$60,$50,$50,$50,$00
;asc	dta $00,$00,c"p",$80,c"`",$10,c"`"*,$00,$00,$00,c"@`PPP",$00
;vid	dta d"  p",d" "*,d"`0",d"`"*,d"   ",$40,d"`",$50,$50,$50,d" "
		dta $00,$00,$40,$40,$50,$50,$40,$00,$00,$00,$20,$E0,$20,$20,$E1,$00
;asc	dta $00,$00,c"@@PP@",$00,$00,$00,c" ",c"`"*,c"  ",c"a"*,$00
;vid	dta d"  ",$40,$40,$50,$50,$40,d"   @",d"`"*,d"@@",d"a"*,d" "
		dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$70,$40,$70,$40,$48,$00
;asc	dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,c"p@p@H",$00
;vid	dta d"      /   p",$40,d"p",$40,$48,d" "
		dta $00,$00,$80,$50,$90,$50,$50,$00,$00,$00,$00,$80,$50,$50,$40,$00
;asc	dta $00,$00,$80,c"P",$90,c"PP",$00,$00,$00,$00,$80,c"PP@",$00
;vid	dta d"  ",d" "*,$50,d"0"*,$50,$50,d"    ",d" "*,$50,$50,$40,d" "
		dta $00,$00,$00,$C0,$20,$20,$E1,$20,$00,$00,$10,$10,$10,$10,$1E,$00
;asc	dta $00,$00,$00,c"@"*,c"  ",c"a"*,c" ",$00,$00,$10,$10,$10,$10,$1E,$00
;vid	dta d"   ",$C0,d"@@",d"a"*,d"@  0000> "
		dta $00,$00,$E0,$10,$E0,$10,$10,$00,$00,$00,$00,$60,$30,$50,$30,$00
;asc	dta $00,$00,c"`"*,$10,c"`"*,$10,$10,$00,$00,$00,$00,c"`0P0",$00
;vid	dta d"  ",d"`"*,d"0",d"`"*,d"00    `P",$50,d"P "
		dta $00,$00,$40,$60,$40,$40,$20,$00,$00,$00,$00,$40,$A0,$C0,$61,$00
;asc	dta $00,$00,c"@`@@ ",$00,$00,$00,$00,c"@",c" @"*,c"a",$00
;vid	dta d"  ",$40,d"`",$40,$40,d"@    ",$40,d"@"*,$C0,d"a "
		dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$30,$40,$40,$40,$38,$00
;asc	dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,c"0@@@8",$00
;vid	dta d"      /   P",$40,$40,$40,d"X "
		dta $00,$00,$80,$10,$20,$20,$90,$00,$00,$00,$00,$80,$50,$40,$90,$00
;asc	dta $00,$00,$80,$10,c"  ",$90,$00,$00,$00,$00,$80,c"P@",$90,$00
;vid	dta d"  ",d" "*,d"0@@",d"0"*,d"    ",d" "*,$50,$40,d"0"*,d" "
		dta $00,$00,$10,$D0,$10,$D0,$80,$00,$00,$00,$00,$80,$00,$00,$87,$00
;asc	dta $00,$00,$10,c"P"*,$10,c"P"*,$80,$00,$00,$00,$00,$80,$00,$00,$87,$00
;vid	dta d"  0",$D0,d"0",$D0,d" "*,d"    ",d" "*,d"  ",d"'"*,d" "
		dta $00,$00,$00,$00,$00,$00,$0C,$02,$00,$00,$00,$00,$00,$00,$07,$08
;asc	dta $00,$00,$00,$00,$00,$00,$0C,$02,$00,$00,$00,$00,$00,$00,$07,$08
;vid	dta d"      ,""      '("
		dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$F0,$80,$E0,$80,$F0,$00
;asc	dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,c"p"*,$80,c"`"*,$80,c"p"*,$00
;vid	dta d"      /   ",d"p ` p"*,d" "
		dta $00,$00,$00,$60,$50,$50,$50,$00,$00,$00,$00,$20,$50,$60,$30,$00
;asc	dta $00,$00,$00,c"`PPP",$00,$00,$00,$00,c" P`0",$00
;vid	dta d"   `",$50,$50,$50,d"    @",$50,d"`P "
		dta $00,$00,$00,$70,$50,$50,$50,$00,$00,$00,$00,$90,$50,$50,$50,$00
;asc	dta $00,$00,$00,c"pPPP",$00,$00,$00,$00,$90,c"PPP",$00
;vid	dta d"   p",$50,$50,$50,d"    ",d"0"*,$50,$50,$50,d" "
		dta $00,$00,$00,$40,$40,$40,$C3,$40,$00,$00,$00,$00,$00,$00,$0F,$00
;asc	dta $00,$00,$00,c"@@@",c"C"*,c"@",$00,$00,$00,$00,$00,$00,$0F,$00
;vid	dta d"   ",$40,$40,$40,$C3,$40,d"      / "
		dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$00,$00,$00,$00,$0C,$02
;asc	dta $00,$00,$00,$00,$00,$00,$0F,$00,$00,$00,$00,$00,$00,$00,$0C,$02
;vid	dta d"      /       ,"""
		dta $08,$08,$08,$08,$08,$08,$08,$08,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $08,$08,$08,$08,$08,$08,$08,$08,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"((((((((        "
		dta $80,$80,$80,$80,$80,$80,$F0,$00,$40,$00,$50,$50,$50,$50,$40,$00
;asc	dta $80,$80,$80,$80,$80,$80,c"p"*,$00,c"@",$00,c"PPPP@",$00
;vid	dta d"      p"*,d" ",$40,d" ",$50,$50,$50,$50,$40,d" "
		dta $00,$00,$40,$50,$50,$50,$80,$00,$00,$00,$C0,$20,$E0,$00,$C0,$00
;asc	dta $00,$00,c"@PPP",$80,$00,$00,$00,c"@"*,c" ",c"`"*,$00,c"@"*,$00
;vid	dta d"  ",$40,$50,$50,$50,d" "*,d"   ",$C0,d"@",d"`"*,d" ",$C0,d" "
		dta $00,$00,$70,$80,$60,$10,$E0,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,c"p",$80,c"`",$10,c"`"*,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"  p",d" "*,d"`0",d"`"*,d"         "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$02,$02,$02,$02,$02,$02,$02,$02
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$02,$02,$02,$02,$02,$02,$02,$02
;vid	dta d"        """""""""""""""""
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $C0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta c"@"*,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta $C0,d"               "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $C0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta c"@"*,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta $C0,d"               "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $01,$01,$01,$01,$01,$01,$01,$01,$20,$20,$20,$30,$20,$20,$20,$00
;asc	dta $01,$01,$01,$01,$01,$01,$01,$01,c"   0   ",$00
;vid	dta d"!!!!!!!!@@@P@@@ "
		dta $10,$10,$10,$F0,$10,$10,$10,$00,$00,$00,$30,$40,$70,$40,$30,$00
;asc	dta $10,$10,$10,c"p"*,$10,$10,$10,$00,$00,$00,c"0@p@0",$00
;vid	dta d"000",d"p"*,d"000   P",$40,d"p",$40,d"P "
		dta $00,$00,$10,$80,$90,$20,$10,$00,$10,$10,$90,$50,$D0,$50,$D0,$00
;asc	dta $00,$00,$10,$80,$90,c" ",$10,$00,$10,$10,$90,c"P",c"P"*,c"P",c"P"*,$00
;vid	dta d"  0",d" 0"*,d"@0 00",d"0"*,$50,$D0,$50,$D0,d" "
		dta $40,$40,$60,$40,$40,$40,$20,$00,$90,$80,$A0,$D0,$90,$90,$90,$00
;asc	dta c"@@`@@@ ",$00,$90,$80,c" P"*,$90,$90,$90,$00
;vid	dta $40,$40,d"`",$40,$40,$40,d"@ ",d"0 @"*,$D0,d"000"*,d" "
		dta $80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d" "*,d"               "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01
;vid	dta d"        !!!!!!!!"
		dta $08,$08,$08,$08,$08,$08,$08,$08,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $08,$08,$08,$08,$08,$08,$08,$08,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"((((((((        "
		dta $11,$22,$22,$22,$22,$22,$11,$00,$EE,$11,$00,$77,$11,$33,$DD,$00
;asc	dta $11,c"""""""""""",$11,$00,c"n"*,$11,$00,c"w",$11,c"3",c"]"*,$00
;vid	dta d"1BBBBB1 ",d"n"*,d"1 w1S",$DD,d" "
		dta $00,$00,$33,$44,$44,$44,$33,$00,$22,$22,$22,$AA,$AA,$AA,$22,$00
;asc	dta $00,$00,c"3DDD3",$00,c"""""""",c"***"*,c"""",$00
;vid	dta d"  S",$44,$44,$44,d"S BBB",d"JJJ"*,d"B "
		dta $11,$11,$77,$99,$99,$99,$77,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $11,$11,c"w",$99,$99,$99,c"w",$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"11w",d"999"*,d"w         "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$02,$02,$02,$02,$02,$02,$02,$02
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$02,$02,$02,$02,$02,$02,$02,$02
;vid	dta d"        """""""""""""""""
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"!!!!!!!!        "
		dta $07,$08,$08,$07,$00,$08,$07,$00,$02,$0A,$02,$03,$0A,$0A,$02,$00
;asc	dta $07,$08,$08,$07,$00,$08,$07,$00,$02,$0A,$02,$03,$0A,$0A,$02,$00
;vid	dta d"'((' (' ""*""#**"" "
		dta $01,$00,$09,$05,$05,$05,$05,$00,$00,$00,$03,$04,$07,$04,$03,$00
;asc	dta $01,$00,$09,$05,$05,$05,$05,$00,$00,$00,$03,$04,$07,$04,$03,$00
;vid	dta d"! )%%%%   #$'$# "
		dta $02,$02,$02,$0A,$0A,$02,$02,$00,$01,$01,$07,$09,$09,$09,$07,$00
;asc	dta $02,$02,$02,$0A,$0A,$02,$02,$00,$01,$01,$07,$09,$09,$09,$07,$00
;vid	dta d"""""""**"""" !!')))' "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01
;vid	dta d"        !!!!!!!!"
		dta $08,$08,$08,$08,$08,$08,$08,$08,$03,$04,$04,$03,$00,$04,$03,$00
;asc	dta $08,$08,$08,$08,$08,$08,$08,$08,$03,$04,$04,$03,$00,$04,$03,$00
;vid	dta d"((((((((#$$# $# "
		dta $08,$04,$00,$09,$05,$05,$08,$00,$00,$00,$0C,$02,$00,$02,$0C,$00
;asc	dta $08,$04,$00,$09,$05,$05,$08,$00,$00,$00,$0C,$02,$00,$02,$0C,$00
;vid	dta d"($ )%%(   ,"" "", "
		dta $00,$00,$06,$09,$09,$09,$06,$00,$00,$00,$06,$04,$04,$04,$04,$00
;asc	dta $00,$00,$06,$09,$09,$09,$06,$00,$00,$00,$06,$04,$04,$04,$04,$00
;vid	dta d"  &)))&   &$$$$ "
		dta $00,$00,$06,$09,$0F,$08,$06,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$06,$09,$0F,$08,$06,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"  &)/(&         "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$02,$02,$02,$02,$02,$02,$02,$02
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$02,$02,$02,$02,$02,$02,$02,$02
;vid	dta d"        """""""""""""""""
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"!!!!!!!!        "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$11,$11,$11,$11,$11,$11,$11,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$11,$11,$11,$11,$11,$11,$11,$00
;vid	dta d"        1111111 "
		dta $00,$00,$00,$00,$00,$00,$EE,$00,$00,$00,$66,$99,$FF,$88,$66,$00
;asc	dta $00,$00,$00,$00,$00,$00,c"n"*,$00,$00,$00,c"f",$99,$FF,$88,c"f",$00
;vid	dta d"      ",d"n"*,d"   f",d"9"*,$FF,d"("*,d"f "
		dta $33,$44,$44,$66,$44,$44,$44,$00,$44,$44,$66,$44,$44,$44,$22,$00
;asc	dta c"3DDfDDD",$00,c"DDfDDD""",$00
;vid	dta d"S",$44,$44,d"f",$44,$44,$44,d" ",$44,$44,d"f",$44,$44,$44,d"B "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01
;vid	dta d"        !!!!!!!!"
;
		org $6000
;
		dta $00,$00,$00,$22,$11,$01,$03,$03,$01,$11,$22,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,c"""",$11,$01,$03,$03,$01,$11,c"""",$00,$00,$00,$00,$00
;vid	dta d"   B1!##!1B     "
		dta $00,$06,$0F,$FF,$FF,$FF,$FF,$0F,$06,$00,$00,$00,$00,$00,$00,$44
;asc	dta $00,$06,$0F,$FF,$FF,$FF,$FF,$0F,$06,$00,$00,$00,$00,$00,$00,c"D"
;vid	dta d" &/",$FF,$FF,$FF,$FF,d"/&      ",$44
		dta $88,$08,$0C,$0C,$08,$88,$44,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $88,$08,$0C,$0C,$08,$88,c"D",$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"("*,d"(,,(",d"("*,$44,d"         "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$11,$00,$00,$01,$01
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$11,$00,$00,$01,$01
;vid	dta d"           1  !!"
		dta $00,$00,$11,$00,$00,$00,$00,$00,$00,$03,$8F,$7F,$7F,$7F,$7F,$8F
;asc	dta $00,$00,$11,$00,$00,$00,$00,$00,$00,$03,$8F,$7F,$7F,$7F,$7F,$8F
;vid	dta d"  1      #",d"/"*,$7F,$7F,$7F,$7F,d"/"*
		dta $03,$00,$00,$00,$00,$00,$00,$22,$4C,$8C,$8E,$8E,$8C,$4C,$22,$00
;asc	dta $03,$00,$00,$00,$00,$00,$00,c"""L",$8C,$8E,$8E,$8C,c"L""",$00
;vid	dta d"#      B",$4C,d",..,"*,$4C,d"B "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$89,$47,$37,$3F,$3F,$37,$47,$89,$00,$00,$00,$00,$00,$00,$19
;asc	dta $00,$89,c"G7??7G",$89,$00,$00,$00,$00,$00,$00,$19
;vid	dta d" ",d")"*,$47,d"W__W",$47,d")"*,d"      9"
		dta $2E,$CE,$CF,$CF,$CE,$2E,$19,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta c".",c"NOON"*,c".",$19,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"N",$CE,$CF,$CF,$CE,d"N9         "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$44,$23,$13,$17,$17,$13,$23
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,c"D#",$13,$17,$17,$13,c"#"
;vid	dta d"         ",$44,d"C3773C"
		dta $44,$00,$00,$00,$00,$00,$00,$0C,$1F,$EF,$EF,$EF,$EF,$1F,$0C,$00
;asc	dta c"D",$00,$00,$00,$00,$00,$00,$0C,$1F,c"oooo"*,$1F,$0C,$00
;vid	dta $44,d"      ,?",d"oooo"*,d"?, "
		dta $00,$00,$00,$00,$00,$88,$00,$00,$08,$08,$00,$00,$88,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$88,$00,$00,$08,$08,$00,$00,$88,$00,$00,$00
;vid	dta d"     ",d"("*,d"  ((  ",d"("*,d"   "
		dta $00,$00,$04,$22,$11,$13,$03,$03,$13,$11,$22,$04,$00,$00,$00,$00
;asc	dta $00,$00,$04,c"""",$11,$13,$03,$03,$13,$11,c"""",$04,$00,$00,$00,$00
;vid	dta d"  $B13##31B$    "
		dta $00,$0F,$9F,$06,$09,$09,$06,$9F,$0F,$00,$00,$00,$00,$00,$02,$44
;asc	dta $00,$0F,$9F,$06,$09,$09,$06,$9F,$0F,$00,$00,$00,$00,$00,$02,c"D"
;vid	dta d" /",d"?"*,d"&))&",d"?"*,d"/     """,$44
		dta $88,$8C,$0C,$0C,$8C,$88,$44,$02,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $88,$8C,$0C,$0C,$8C,$88,c"D",$02,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"(,"*,d",,",d",("*,$44,d"""        "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$11,$00,$01,$01,$01
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$11,$00,$01,$01,$01
;vid	dta d"          ""1 !!!"
		dta $01,$00,$11,$02,$00,$00,$00,$00,$00,$07,$CF,$8B,$0C,$0C,$8B,$CF
;asc	dta $01,$00,$11,$02,$00,$00,$00,$00,$00,$07,c"O"*,$8B,$0C,$0C,$8B,c"O"*
;vid	dta d"! 1""     '",$CF,d"+"*,d",,",d"+"*,$CF
		dta $07,$00,$00,$00,$00,$00,$01,$2A,$CC,$46,$0E,$0E,$46,$CC,$2A,$01
;asc	dta $07,$00,$00,$00,$00,$00,$01,c"*",c"L"*,c"F",$0E,$0E,c"F",c"L"*,c"*",$01
;vid	dta d"'     !J",$CC,$46,d"..",$46,$CC,d"J!"
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$01,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00,$00
;asc	dta $00,$00,$01,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00,$00
;vid	dta d"  !        !    "
		dta $00,$8B,$67,$4D,$0E,$0E,$4D,$67,$8B,$00,$00,$00,$00,$00,$00,$1D
;asc	dta $00,$8B,c"gM",$0E,$0E,c"Mg",$8B,$00,$00,$00,$00,$00,$00,$1D
;vid	dta d" ",d"+"*,d"g",$4D,d"..",$4D,d"g",d"+"*,d"      ="
		dta $6E,$2B,$07,$07,$2B,$6E,$1D,$00,$00,$00,$00,$00,$08,$00,$00,$00
;asc	dta c"n+",$07,$07,c"+n",$1D,$00,$00,$00,$00,$00,$08,$00,$00,$00
;vid	dta d"nK''Kn=     (   "
		dta $00,$00,$00,$00,$00,$08,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$08,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"     (          "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$08,$45,$33,$26,$07,$07,$26,$33
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$08,c"E3&",$07,$07,c"&3"
;vid	dta d"        (",$45,d"SF''FS"
		dta $45,$08,$00,$00,$00,$00,$00,$0E,$3F,$1D,$03,$03,$1D,$3F,$0E,$00
;asc	dta c"E",$08,$00,$00,$00,$00,$00,$0E,c"?",$1D,$03,$03,$1D,c"?",$0E,$00
;vid	dta $45,d"(     ._=##=_. "
		dta $00,$00,$00,$00,$04,$88,$00,$08,$08,$08,$08,$00,$88,$04,$00,$00
;asc	dta $00,$00,$00,$00,$04,$88,$00,$08,$08,$08,$08,$00,$88,$04,$00,$00
;vid	dta d"    $",d"("*,d" (((( ",d"("*,d"$  "
		dta $00,$00,$04,$01,$02,$02,$04,$04,$02,$02,$01,$04,$00,$00,$00,$00
;asc	dta $00,$00,$04,$01,$02,$02,$04,$04,$02,$02,$01,$04,$00,$00,$00,$00
;vid	dta d"  $!""""$$""""!$    "
		dta $06,$09,$00,$09,$00,$00,$09,$00,$09,$06,$00,$00,$00,$00,$02,$08
;asc	dta $06,$09,$00,$09,$00,$00,$09,$00,$09,$06,$00,$00,$00,$00,$02,$08
;vid	dta d"&) )  ) )&    ""("
		dta $04,$04,$02,$02,$04,$04,$08,$02,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $04,$04,$02,$02,$04,$04,$08,$02,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"$$""""$$(""        "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$00,$01,$01,$02,$02
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$00,$01,$01,$02,$02
;vid	dta d"          "" !!"""""
		dta $01,$01,$00,$02,$00,$00,$00,$00,$03,$0C,$00,$04,$00,$00,$04,$00
;asc	dta $01,$01,$00,$02,$00,$00,$00,$00,$03,$0C,$00,$04,$00,$00,$04,$00
;vid	dta d"!! ""    #, $  $ "
		dta $0C,$03,$00,$00,$00,$00,$01,$0C,$02,$0A,$01,$01,$0A,$02,$0C,$01
;asc	dta $0C,$03,$00,$00,$00,$00,$01,$0C,$02,$0A,$01,$01,$0A,$02,$0C,$01
;vid	dta d",#    !,""*!!*"",!"
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$01,$00,$00,$00,$01,$01,$00,$00,$00,$01,$00,$00,$00,$00
;asc	dta $00,$00,$01,$00,$00,$00,$01,$01,$00,$00,$00,$01,$00,$00,$00,$00
;vid	dta d"  !   !!   !    "
		dta $01,$06,$08,$0A,$00,$00,$0A,$08,$06,$01,$00,$00,$00,$00,$08,$06
;asc	dta $01,$06,$08,$0A,$00,$00,$0A,$08,$06,$01,$00,$00,$00,$00,$08,$06
;vid	dta d"!&(*  *(&!    (&"
		dta $01,$05,$00,$00,$05,$01,$06,$08,$00,$00,$00,$00,$08,$00,$00,$00
;asc	dta $01,$05,$00,$00,$05,$01,$06,$08,$00,$00,$00,$00,$08,$00,$00,$00
;vid	dta d"!%  %!&(    (   "
		dta $08,$08,$00,$00,$00,$08,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $08,$08,$00,$00,$00,$08,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"((   (          "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$08,$03,$04,$05,$08,$08,$05,$04
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$08,$03,$04,$05,$08,$08,$05,$04
;vid	dta d"        (#$%((%$"
		dta $03,$08,$00,$00,$00,$00,$0C,$03,$00,$02,$00,$00,$02,$00,$03,$0C
;asc	dta $03,$08,$00,$00,$00,$00,$0C,$03,$00,$02,$00,$00,$02,$00,$03,$0C
;vid	dta d"#(    ,# ""  "" #,"
		dta $00,$00,$00,$00,$04,$00,$08,$08,$04,$04,$08,$08,$00,$04,$00,$00
;asc	dta $00,$00,$00,$00,$04,$00,$08,$08,$04,$04,$08,$08,$00,$04,$00,$00
;vid	dta d"    $ (($$(( $  "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
		dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;asc	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;vid	dta d"                "
L_7A98	equ $7A98
L_7AF0	equ $7AF0
L_7B40	equ $7B40
L_7C98	equ $7C98
L_7E98	equ $7E98
L_FE21	equ $FE21
L_FE44	equ $FE44
L_FE45	equ $FE45
L_FE4D	equ $FE4D
L_FE68	equ $FE68
L_FE69	equ $FE69
L_FE6B	equ $FE6B
L_FE6C	equ $FE6C
L_FE6D	equ $FE6D
L_FE6E	equ $FE6E
L_FFCE	equ $FFCE
L_FFD7	equ $FFD7
L_FFDD	equ $FFDD
L_FFF1	equ $FFF1
;
;--------------------------------
;
