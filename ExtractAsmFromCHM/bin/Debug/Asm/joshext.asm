

; File: JOSHEXT.BIN
; File Type: BIN
; Processor: 8086/88
; Range: 06000h to 071ffh
; Subroutines:    7
 
k00021          EQU     00021H 
key_status1     EQU     00017H                  ;<00417> keyboard status byte 1
dsk_motor_stat  EQU     0003FH                  ;<0043f> disk motor status
.RADIX 16
 
dseg0000        SEGMENT at 00000 
dseg0000        ENDS
 
dseg0040        SEGMENT at 00040 
dseg0040        ENDS
 
sseg            SEGMENT para stack 
sseg            ENDS
 
dsegb800        SEGMENT at 0B800 
dsegb800        ENDS
 
                ORG     00H
sseg            SEGMENT para stack 
                ASSUME CS:sseg
o06000          PROC NEAR
;<es =="" 0600="">
;<cs =="" 0600="">
;<ss =="" 0600="">
;<ds =="" 0600="">
                CLI                             ;06000 Turn OFF Interrupts
                PUSH    CS                      ;06001 
                POP     DS                      ;06002 ds=cs
                MOV     AX,SEG dseg0000 ;abs    ;06003 >>xref=<00000>< ;="" ;at="" 00000=""><es =="" 0000="">
                MOV     ES,AX                   ;06006 es=0
                ASSUME DS:sseg
                MOV     BYTE PTR DS:d0628b,00   ;06008 zero out data areas
                MOV     BYTE PTR DS:d0628c,00   ;0600D 
                MOV     BYTE PTR DS:d06292,00   ;06012 
                MOV     BYTE PTR DS:d06293,00   ;06017 
                MOV     BYTE PTR DS:d0628d,00   ;0601C 
                MOV     BYTE PTR DS:d062b0,00   ;06021 
                MOV     AX,0008H                ;06026 
                MOV     BX,0004H                ;06029 
                MUL     BX                      ;0602C 
                MOV     SI,AX                   ;0602E 
                MOV     AX,01CEH                ;06030 
                CMP     AX,WORD PTR ES:[SI]     ;06033 
                JNE     b06043                  ;06036 Jump not equal(ZF=0)
                MOV     AX,CS                   ;06038 
                CMP     AX,WORD PTR ES:[SI+02]  ;0603A 
                JNE     b06043                  ;0603E Jump not equal(ZF=0)
                JMP     SHORT b0605e            ;06040 
                NOP                             ;06042 
b06043:         MOV     DI,027FH                ;06043 
                MOV     AX,WORD PTR ES:[SI]     ;06046 
                MOV     WORD PTR [DI],AX        ;06049 
                MOV     AX,WORD PTR ES:[SI+02]  ;0604B 
                MOV     WORD PTR [DI+02],AX     ;0604F 
                MOV     AX,01CEH                ;06052 
                MOV     WORD PTR ES:[SI],AX     ;06055 
                MOV     AX,CS                   ;06058 
                MOV     WORD PTR ES:[SI+02],AX  ;0605A 
b0605e:         MOV     AX,0009H                ;0605E 
                MOV     BX,0004H                ;06061 
                MUL     BX                      ;06064 
                MOV     SI,AX                   ;06066 
                MOV     AX,010AH                ;06068 
                CMP     AX,WORD PTR ES:[SI]     ;0606B 
                JNE     b0607b                  ;0606E Jump not equal(ZF=0)
                MOV     AX,CS                   ;06070 
                CMP     AX,WORD PTR ES:[SI+02]  ;06072 
                JNE     b0607b                  ;06076 Jump not equal(ZF=0)
                JMP     SHORT b06096            ;06078 
                NOP                             ;0607A 
b0607b:         MOV     DI,01CAH                ;0607B 
                MOV     AX,WORD PTR ES:[SI]     ;0607E 
                MOV     WORD PTR [DI],AX        ;06081 
                MOV     AX,WORD PTR ES:[SI+02]  ;06083 
                MOV     WORD PTR [DI+02],AX     ;06087 
                MOV     AX,010AH                ;0608A 
                MOV     WORD PTR ES:[SI],AX     ;0608D 
                MOV     AX,CS                   ;06090 
                MOV     WORD PTR ES:[SI+02],AX  ;06092 
b06096:         MOV     AX,0013H                ;06096 
                MOV     BX,0004H                ;06099 
                MUL     BX                      ;0609C 
                MOV     SI,AX                   ;0609E 
                MOV     AX,04FAH                ;060A0 
                CMP     AX,WORD PTR ES:[SI]     ;060A3 
                JNE     b060b3                  ;060A6 Jump not equal(ZF=0)
                MOV     AX,CS                   ;060A8 
                CMP     AX,WORD PTR ES:[SI+02]  ;060AA 
                JNE     b060b3                  ;060AE Jump not equal(ZF=0)
                JMP     SHORT b060ce            ;060B0 
                NOP                             ;060B2 
b060b3:         MOV     DI,07ACH                ;060B3 
                MOV     AX,WORD PTR ES:[SI]     ;060B6 
                MOV     WORD PTR [DI],AX        ;060B9 
                MOV     AX,WORD PTR ES:[SI+02]  ;060BB 
                MOV     WORD PTR [DI+02],AX     ;060BF 
                MOV     AX,04FAH                ;060C2 
                MOV     WORD PTR ES:[SI],AX     ;060C5 
                MOV     AX,CS                   ;060C8 
                MOV     WORD PTR ES:[SI+02],AX  ;060CA 
b060ce:         MOV     AX,SEG dseg0000 ;abs    ;060CE >>xref=<00000>< ;="" ;at="" 00000=""><ds =="" 0000="">
                MOV     DS,AX                   ;060D1 
                MOV     SI,0000H                ;060D3 
                PUSH    CS                      ;060D6 
;<es =="" 0600="">
                POP     ES                      ;060D7 
                MOV     DI,1000H                ;060D8 
                MOV     CX,0400H                ;060DB 
                CLD                             ;060DE Forward String Opers
                REP     MOVSB                   ;060DF Mov DS:[SI]->ES:[DI]
                PUSH    CS                      ;060E1 
;<es =="" 0600="">
                POP     ES                      ;060E2 
                MOV     DI,0287H                ;060E3 
                MOV     CX,0004H                ;060E6 
                MOV     AL,01                   ;060E9 
                REP     STOSB                   ;060EB Store AL at ES:[DI]
                PUSH    CS                      ;060ED 
;<ds =="" 0600="">
                POP     DS                      ;060EE 
                MOV     SI,0E00H                ;060EF 
                MOV     AX,SEG dseg0000 ;abs    ;060F2 >>xref=<00000>< ;="" ;at="" 00000=""><es =="" 0000="">
                MOV     ES,AX                   ;060F5 
                MOV     DI,7C00H                ;060F7 
                MOV     CX,0200H                ;060FA 
                CLD                             ;060FD Forward String Opers
                REP     MOVSB                   ;060FE Mov DS:[SI]->ES:[DI]
                MOV     AX,0000H                ;06100 
                PUSH    AX                      ;06103 
                MOV     AX,7C00H                ;06104 
                PUSH    AX                      ;06107 
                STI                             ;06108 Turn ON Interrupts
;<es =="" 0600="">
                RETF                            ;06109 
;-----------------------------------------------------
                PUSHF                           ;0610A Push flags on Stack
                PUSH    AX                      ;0610B 
                PUSH    BP                      ;0610C Save Argument Pointr
                PUSH    BX                      ;0610D 
                PUSH    CX                      ;0610E 
                PUSH    DI                      ;0610F 
                PUSH    DS                      ;06110 
                PUSH    DX                      ;06111 
                PUSH    ES                      ;06112 
                PUSH    SI                      ;06113 
                PUSH    CS                      ;06114 
                POP     DS                      ;06115 
                IN      AL,60H                  ;06116 060-067:8042 keyboar-
                                                ;     d
                MOV     BYTE PTR DS:d06294,AL   ;06118 
                CMP     BYTE PTR DS:d06293,00   ;0611B 
                JE      b06125                  ;06120 Jump if equal (ZF=1)
                JMP     NEAR PTR m061b0         ;06122 
b06125:         MOV     AX,SEG dseg0040 ;abs    ;06125 >>xref=<00400>< ;="" ;at="" 00040=""><es =="" 0040="">
                MOV     ES,AX                   ;06128 
                ASSUME ES:dseg0040
                MOV     AL,BYTE PTR ES:key_status1 ;
                                                ;0612A >>xref=<00417>< ;="" ;keyboard="" status="" byte="" ;="" 1="" and="" al,0ch="" ;0612e="" cmp="" al,0ch="" ;06130="" jne="" b0613f="" ;06132="" jump="" not="" equal(zf="0)" push="" cs="" ;06134="" pop="" ds="" ;06135="" mov="" al,byte="" ptr="" ds:d06294="" ;06136="" and="" al,7fh="" ;06139="" cmp="" al,53h="" ;(s)="" ;0613b="" je="" b0614e="" ;0613d="" jump="" if="" equal="" (zf="1)" b0613f:="" pop="" si="" ;0613f=""><es =="" 0600="">
                POP     ES                      ;06140 
                POP     DX                      ;06141 
                POP     DS                      ;06142 
                POP     DI                      ;06143 
                POP     CX                      ;06144 
                POP     BX                      ;06145 
                POP     BP                      ;06146 Restore Arg Pointer
                POP     AX                      ;06147 
                POPF                            ;06148 Pop flags off Stack
                JMP     DWORD PTR CS:d061ca     ;06149 
b0614e:         CLI                             ;0614E Turn OFF Interrupts
                MOV     DX,0061H                ;0614F 
                IN      AL,DX                   ;06152 060-067:8042 keyboar-
                                                ;     d
                OR      AL,80H                  ;06153 
                OUT     DX,AL                   ;06155 060-067:8042 keyboar-
                                                ;     d
                XOR     AL,80H                  ;06156 
                OUT     DX,AL                   ;06158 060-067:8042 keyboar-
                                                ;     d
                MOV     AL,20H                  ;06159 
                OUT     20H,AL                  ;0615B 020-027:pic 1 master
                POP     SI                      ;0615D 
                POP     ES                      ;0615E 
                POP     DX                      ;0615F 
                POP     DS                      ;06160 
                POP     DI                      ;06161 
                POP     CX                      ;06162 
                POP     BX                      ;06163 
                POP     BP                      ;06164 Restore Arg Pointer
                POP     AX                      ;06165 
                POPF                            ;06166 Pop flags off Stack
                CLI                             ;06167 Turn OFF Interrupts
                PUSH    CS                      ;06168 
                POP     DS                      ;06169 
                MOV     SI,1000H                ;0616A 
                MOV     AX,SEG dseg0000 ;abs    ;0616D >>xref=<00000>< ;="" ;at="" 00000=""><es =="" 0000="">
                MOV     ES,AX                   ;06170 
                MOV     DI,AX                   ;06172 
                MOV     CX,0400H                ;06174 
                CLD                             ;06177 Forward String Opers
                REP     MOVSB                   ;06178 Mov DS:[SI]->ES:[DI]
                STI                             ;0617A Turn ON Interrupts
                MOV     AH,00                   ;0617B 
                MOV     AL,02                   ;0617D 
                INT     10H                     ;0617F CRT:00-set video 
                                                ;     mode, AL=mode
                MOV     AL,08                   ;06181 
                OUT     61H,AL                  ;06183 060-067:8042 keyboar-
                                                ;     d
                MOV     AX,0004H                ;06185 
b06188:         MOV     CX,0FFFFH               ;06188 
b0618b:         LOOP    b0618b                  ;0618B Dec CX;Loop if CX>0
                DEC     AX                      ;0618D 
                JNE     b06188                  ;0618E Jump not equal(ZF=0)
                MOV     AL,0C8H                 ;06190 
                OUT     61H,AL                  ;06192 060-067:8042 keyboar-
                                                ;     d
                MOV     AL,48H                  ;06194 
                OUT     61H,AL                  ;06196 060-067:8042 keyboar-
                                                ;     d
                MOV     AX,0008H                ;06198 
b0619b:         MOV     CX,0FFFFH               ;0619B 
b0619e:         LOOP    b0619e                  ;0619E Dec CX;Loop if CX>0
                DEC     AX                      ;061A0 
                JNE     b0619b                  ;061A1 Jump not equal(ZF=0)
                MOV     AX,SEG dseg0040 ;abs    ;061A3 >>xref=<00400>< ;="" ;at="" 00040=""><es =="" 0040="">
                MOV     ES,AX                   ;061A6 
                MOV     BYTE PTR ES:key_status1,00 ;
                                                ;061A8 >>xref=<00417>< ;="" ;keyboard="" status="" byte="" ;="" 1="" int="" 19h="" ;061ae="" bootstrap="" bios="" m061b0:="" cli="" ;061b0="" turn="" off="" interrupts="" mov="" dx,0061h="" ;061b1="" in="" al,dx="" ;061b4="" 060-067:8042="" keyboar-="" ;="" d="" or="" al,80h="" ;061b5="" out="" dx,al="" ;061b7="" 060-067:8042="" keyboar-="" ;="" d="" xor="" al,80h="" ;061b8="" out="" dx,al="" ;061ba="" 060-067:8042="" keyboar-="" ;="" d="" mov="" al,20h="" ;061bb="" out="" 20h,al="" ;061bd="" 020-027:pic="" 1="" master="" pop="" si="" ;061bf="" pop="" es="" ;061c0="" pop="" dx="" ;061c1="" pop="" ds="" ;061c2="" pop="" di="" ;061c3="" pop="" cx="" ;061c4="" pop="" bx="" ;061c5="" pop="" bp="" ;061c6="" restore="" arg="" pointer="" pop="" ax="" ;061c7="" popf="" ;061c8="" pop="" flags="" off="" stack=""><es =="" 0600="">
                IRET                            ;061C9 POP flags and Return
d061ca          EQU     $
                XCHG    BP,CX                   ;061CA 
                ADD     AL,DH                   ;061CC 
                PUSHF                           ;061CE Push flags on Stack
                PUSH    AX                      ;061CF 
                PUSH    BP                      ;061D0 Save Argument Pointr
                PUSH    BX                      ;061D1 
                PUSH    CX                      ;061D2 
                PUSH    DI                      ;061D3 
                PUSH    DS                      ;061D4 
                PUSH    DX                      ;061D5 
                PUSH    ES                      ;061D6 
                PUSH    SI                      ;061D7 
                PUSH    CS                      ;061D8 
                POP     DS                      ;061D9 
                MOV     BL,00                   ;061DA 
b061dc:         MOV     AX,SEG dseg0040 ;abs    ;061DC >>xref=<00400>< ;="" ;at="" 00040=""><es =="" 0040="">
                MOV     ES,AX                   ;061DF 
                MOV     CL,BL                   ;061E1 
                MOV     AH,01                   ;061E3 
                SHL     AH,CL                   ;061E5 Multiply by 2's
                MOV     AL,BYTE PTR ES:dsk_motor_stat ;
                                                ;061E7 >>xref=<0043f>< ;="" ;disk="" motor="" status="" and="" al,ah="" ;061eb="" je="" b061f2="" ;061ed="" jump="" if="" equal="" (zf="1)" jmp="" short="" b061fb="" ;061ef="" nop="" ;061f1="" b061f2:="" and="" bx,01="" ;061f2="" mov="" si,0287h="" ;061f5="" mov="" byte="" ptr="" [bx+si],01="" ;061f8="" b061fb:="" inc="" bl="" ;061fb="" cmp="" bl,02="" ;061fd="" jb="" b061dc="" ;06200="" jump="" if="">< (no="" sign)="" push="" cs="" ;06202="" pop="" ds="" ;06203="" mov="" ax,seg="" dseg0000="" ;abs="" ;06204="">>xref=<00000>< ;="" ;at="" 00000=""><es =="" 0000="">
                MOV     ES,AX                   ;06207 
                MOV     AX,OFFSET k00021 ;es    ;06209 >>xref=<00021>< ;="" ;="" t="" 00000="" mov="" bx,0004h="" ;0620c="" mul="" bx="" ;0620f="" mov="" di,ax="" ;06211="" push="" di="" ;06213="" mov="" si,ax="" ;06214="" add="" si,1000h="" ;06216="" mov="" cx,0004h="" ;0621a="" cld="" ;0621d="" forward="" string="" opers="" repz="" cmpsb="" ;0621e="" flgs="DS:[SI]-ES:[DI]" pop="" di="" ;06220="" je="" b06252="" ;06221="" jump="" if="" equal="" (zf="1)" mov="" byte="" ptr="" ds:d0628b,01="" ;06223="" cmp="" byte="" ptr="" ds:d0628c,00="" ;06228="" jne="" b06270="" ;0622d="" jump="" not="" equal(zf="0)" cli="" ;0622f="" turn="" off="" interrupts="" mov="" ax,word="" ptr="" es:[di]="" ;06230="" mov="" word="" ptr="" ds:d062b4,ax="" ;06233="" mov="" ax,word="" ptr="" es:[di+02]="" ;06236="" mov="" word="" ptr="" ds:d062b6,ax="" ;0623a="" mov="" ax,02b8h="" ;0623d="" mov="" word="" ptr="" es:[di],ax="" ;06240="" mov="" ax,cs="" ;06243="" mov="" word="" ptr="" es:[di+02],ax="" ;06245="" mov="" byte="" ptr="" ds:d0628c,01="" ;06249="" sti="" ;0624e="" turn="" on="" interrupts="" jmp="" short="" b06270="" ;0624f="" nop="" ;06251="" b06252:="" mov="" byte="" ptr="" ds:d0628b,00="" ;06252="" mov="" byte="" ptr="" ds:d0628c,00="" ;06257="" mov="" byte="" ptr="" ds:d06292,00="" ;0625c="" mov="" byte="" ptr="" ds:d06293,00="" ;06261="" mov="" byte="" ptr="" ds:d0628d,00="" ;06266="" mov="" byte="" ptr="" ds:d062b0,00="" ;0626b="" b06270:="" pop="" si="" ;06270=""><es =="" 0600="">
                POP     ES                      ;06271 
                POP     DX                      ;06272 
                POP     DS                      ;06273 
                POP     DI                      ;06274 
                POP     CX                      ;06275 
                POP     BX                      ;06276 
                POP     BP                      ;06277 Restore Arg Pointer
                POP     AX                      ;06278 
                POPF                            ;06279 Pop flags off Stack
                JMP     DWORD PTR CS:d0627f     ;0627A 
;-----------------------------------------------------
d0627f          DB      0A5,0FE,00,0F0          ;0627F ....
                DB      6D DUP (00H)            ;06283 (.)
                DB      01,01                   ;06289 ..
d0628b          DB      00                      ;0628B .
d0628c          DB      00                      ;0628C .
d0628d          DB      5D DUP (00H)            ;0628D (.)
d06292          DB      00                      ;06292 .
d06293          DB      00                      ;06293 .
d06294          DB      9DH,23,1E,19,19,15      ;06294 .#....
                DB      39,30,17,13,14,23       ;0629A 90...#
                DB      20,1E,15,39,24,18       ;062A0  ..9$.
                DB      1F,23,17,00             ;062A6 .#..
d062aa          DW      00                      ;062AA ..
d062ac          DB      00                      ;062AC .
d062ad          DB      00                      ;062AD .
d062ae          DB      00                      ;062AE .
d062af          DB      00                      ;062AF .
d062b0          DB      00                      ;062B0 .
;-----------------------------------------------------
                JS      b062d7                  ;062B1 Jump if neg.  (SF=1)
d062b4          EQU     $+01H
                ADD     BYTE PTR [BX+SI+14H],AH ;062B3 
d062b6          EQU     $
                CMP     AL,BYTE PTR [BP+SI]     ;062B6 
                PUSHF                           ;062B8 Push flags on Stack
                PUSH    AX                      ;062B9 
                PUSH    BP                      ;062BA Save Argument Pointr
                PUSH    BX                      ;062BB 
                PUSH    CX                      ;062BC 
                PUSH    DI                      ;062BD 
                PUSH    DS                      ;062BE 
                PUSH    DX                      ;062BF 
                PUSH    ES                      ;062C0 
                PUSH    SI                      ;062C1 
                CMP     AH,48H                  ;062C2 
                JE      b062e8                  ;062C5 Jump if equal (ZF=1)
                CMP     AH,49H                  ;062C7 
                JE      b062e8                  ;062CA Jump if equal (ZF=1)
                CMP     AH,4AH                  ;062CC 
                JE      b062e8                  ;062CF Jump if equal (ZF=1)
                CMP     AH,2AH                  ;062D1 
                JE      b062e8                  ;062D4 Jump if equal (ZF=1)
b062d7          EQU     $+01H
                CMP     AH,2BH                  ;062D6 
                JE      b062e8                  ;062D9 Jump if equal (ZF=1)
                CMP     AH,2CH                  ;062DB 
                JE      b062e8                  ;062DE Jump if equal (ZF=1)
                CMP     AH,2DH                  ;062E0 
                JE      b062e8                  ;062E3 Jump if equal (ZF=1)
                JMP     SHORT b06310            ;062E5 
                NOP                             ;062E7 
b062e8:         POP     SI                      ;062E8 
                POP     ES                      ;062E9 
                POP     DX                      ;062EA 
                POP     DS                      ;062EB 
                POP     DI                      ;062EC 
                POP     CX                      ;062ED 
                POP     BX                      ;062EE 
                POP     BP                      ;062EF Restore Arg Pointer
                POP     AX                      ;062F0 
                POPF                            ;062F1 Pop flags off Stack
                PUSHF                           ;062F2 Push flags on Stack
                CALL    DWORD PTR CS:d062b4     ;062F3 
                PUSH    BP                      ;062F8 Save Argument Pointr
                PUSH    AX                      ;062F9 
                PUSHF                           ;062FA Push flags on Stack
                POP     AX                      ;062FB 
                MOV     BP,SP                   ;062FC 
                MOV     WORD PTR [BP+08],AX     ;062FE 
                POP     AX                      ;06301 
                POP     BP                      ;06302 Restore Arg Pointer
                PUSHF                           ;06303 Push flags on Stack
                PUSH    AX                      ;06304 
                PUSH    BP                      ;06305 Save Argument Pointr
                PUSH    BX                      ;06306 
                PUSH    CX                      ;06307 
                PUSH    DI                      ;06308 
                PUSH    DS                      ;06309 
                PUSH    DX                      ;0630A 
                PUSH    ES                      ;0630B 
                PUSH    SI                      ;0630C 
                JMP     SHORT b0631f            ;0630D 
                NOP                             ;0630F 
b06310:         POP     SI                      ;06310 
                POP     ES                      ;06311 
                POP     DX                      ;06312 
                POP     DS                      ;06313 
                POP     DI                      ;06314 
                POP     CX                      ;06315 
                POP     BX                      ;06316 
                POP     BP                      ;06317 Restore Arg Pointer
                POP     AX                      ;06318 
                POPF                            ;06319 Pop flags off Stack
                JMP     DWORD PTR CS:d062b4     ;0631A 
b0631f:         MOV     AH,2AH                  ;0631F 
                PUSHF                           ;06321 Push flags on Stack
                CALL    DWORD PTR CS:d062b4     ;06322 
                PUSH    CS                      ;06327 
                POP     DS                      ;06328 
                CMP     DL,05                   ;06329 
                JE      b06331                  ;0632C Jump if equal (ZF=1)
                JMP     NEAR PTR m063d8         ;0632E 
b06331:         CMP     DH,01                   ;06331 
                JE      b06339                  ;06334 Jump if equal (ZF=1)
                JMP     NEAR PTR m063d8         ;06336 
b06339:         CMP     BYTE PTR DS:d06292,00   ;06339 
                JE      b06343                  ;0633E Jump if equal (ZF=1)
                JMP     NEAR PTR m063e4         ;06340 
b06343:         PUSH    CS                      ;06343 
                POP     DS                      ;06344 
                MOV     AH,48H                  ;06345 
                MOV     BX,0400H                ;06347 
                PUSHF                           ;0634A Push flags on Stack
                CALL    DWORD PTR CS:d062b4     ;0634B 
                JNB     b06355                  ;06350 Jump if >= (no sign)
                JMP     NEAR PTR m063e4         ;06352 
b06355:         PUSH    CS                      ;06355 
                POP     DS                      ;06356 
                MOV     WORD PTR DS:d062aa,AX   ;06357 
                CALL    NEAR PTR s1             ;0635A >>xref=<0640d>< push="" cs="" ;0635d="" pop="" ds="" ;0635e="" mov="" byte="" ptr="" ds:d06294,00="" ;0635f="" mov="" byte="" ptr="" ds:d06293,01="" ;06364="" sti="" ;06369="" turn="" on="" interrupts="" b0636a:="" mov="" si,0295h="" ;0636a="" b0636d:="" mov="" al,byte="" ptr="" [si]="" ;0636d="" cmp="" al,00="" ;0636f="" je="" b063b7="" ;06371="" jump="" if="" equal="" (zf="1)" b06373:="" mov="" ah,byte="" ptr="" ds:d06294="" ;06373="" cmp="" ah,00="" ;06377="" je="" b06373="" ;0637a="" jump="" if="" equal="" (zf="1)" and="" ah,7fh="" ;0637c="" cmp="" ah,2ah="" ;0637f="" je="" b06373="" ;06382="" jump="" if="" equal="" (zf="1)" cmp="" ah,36h="" ;06384="" je="" b06373="" ;06387="" jump="" if="" equal="" (zf="1)" cmp="" ah,1dh="" ;06389="" je="" b06373="" ;0638c="" jump="" if="" equal="" (zf="1)" cmp="" ah,38h="" ;0638e="" je="" b06373="" ;06391="" jump="" if="" equal="" (zf="1)" cmp="" ah,3ah="" ;06393="" je="" b06373="" ;06396="" jump="" if="" equal="" (zf="1)" cmp="" ah,45h="" ;06398="" je="" b06373="" ;0639b="" jump="" if="" equal="" (zf="1)" cmp="" ah,46h="" ;0639d="" je="" b06373="" ;063a0="" jump="" if="" equal="" (zf="1)" mov="" ah,byte="" ptr="" ds:d06294="" ;063a2="" mov="" byte="" ptr="" ds:d06294,00="" ;063a6="" test="" ah,80h="" ;063ab="" flags="Arg1" and="" arg2="" jne="" b06373="" ;063ae="" jump="" not="" equal(zf="0)" cmp="" ah,al="" ;063b0="" jne="" b0636a="" ;063b2="" jump="" not="" equal(zf="0)" inc="" si="" ;063b4="" jmp="" short="" b0636d="" ;063b5="" b063b7:="" call="" near="" ptr="" s2="" ;063b7="">>xref=<064c7>< push="" cs="" ;063ba="" pop="" ds="" ;063bb="" mov="" byte="" ptr="" ds:d06293,00="" ;063bc="" mov="" byte="" ptr="" ds:d06292,01="" ;063c1="" push="" cs="" ;063c6="" pop="" ds="" ;063c7="" mov="" ax,word="" ptr="" ds:d062aa="" ;063c8="" mov="" es,ax="" ;063cb="" mov="" ah,49h="" ;063cd="" pushf="" ;063cf="" push="" flags="" on="" stack="" call="" dword="" ptr="" cs:d062b4="" ;063d0="" jmp="" short="" m063e4="" ;063d5="" nop="" ;063d7="" m063d8:="" push="" cs="" ;063d8="" pop="" ds="" ;063d9="" mov="" byte="" ptr="" ds:d06292,00="" ;063da="" mov="" byte="" ptr="" ds:d06293,00="" ;063df="" m063e4:="" pop="" si="" ;063e4="" pop="" es="" ;063e5="" pop="" dx="" ;063e6="" pop="" ds="" ;063e7="" pop="" di="" ;063e8="" pop="" cx="" ;063e9="" pop="" bx="" ;063ea="" pop="" bp="" ;063eb="" restore="" arg="" pointer="" pop="" ax="" ;063ec="" popf="" ;063ed="" pop="" flags="" off="" stack="" iret="" ;063ee="" pop="" flags="" and="" return="" ;-----------------------------------------------------="" db="" 'type="" "happy="" birthday="" '="" ;063ef="" db="" 'joshi"="" !$'="" ;06404="" ;-----------------------------------------------------="" o06000="" endp=""><0640d>
s1              PROC NEAR
                MOV     AX,SEG dsegb800 ;abs    ;0640D >>xref=<b8000>< ;="" ;at="" 0b800=""><ds =="" b800="">
                MOV     DS,AX                   ;06410 
                MOV     AX,WORD PTR CS:d062aa   ;06412 
;<es =="" b800="">
                MOV     ES,AX                   ;06416 
                MOV     SI,0000H                ;06418 
                MOV     DI,0000H                ;0641B 
                MOV     CX,4000H                ;0641E 
                CLD                             ;06421 Forward String Opers
                REP     MOVSB                   ;06422 Mov DS:[SI]->ES:[DI]
                MOV     AH,0FH                  ;06424 
                INT     10H                     ;06426 CRT:0f-get video 
                                                ;     mode, AL=mode
                PUSH    CS                      ;06428 
;<ds =="" 0600="">
                POP     DS                      ;06429 
                MOV     BYTE PTR DS:d062ae,AL   ;0642A 
                MOV     BYTE PTR DS:d062af,BH   ;0642D 
                MOV     AH,03                   ;06431 
                INT     10H                     ;06433 CRT:03-get cursor 
                                                ;     positn,DX=y,x
                PUSH    CS                      ;06435 
;<ds =="" 0600="">
                POP     DS                      ;06436 
                MOV     BYTE PTR DS:d062ac,DH   ;06437 
                MOV     BYTE PTR DS:d062ad,DL   ;0643B 
                MOV     AH,00                   ;0643F 
                MOV     AL,01                   ;06441 
                INT     10H                     ;06443 CRT:00-set video 
                                                ;     mode, AL=mode
                PUSH    CS                      ;06445 
;<ds =="" 0600="">
                POP     DS                      ;06446 
                MOV     AH,02                   ;06447 
                MOV     BH,00                   ;06449 
                MOV     DH,19H                  ;0644B 
                MOV     DL,01                   ;0644D 
                INT     10H                     ;0644F CRT:02-set cursor 
                                                ;     positn,DX=y,x
                MOV     AX,SEG dsegb800 ;abs    ;06451 >>xref=<b8000>< ;="" ;at="" 0b800="" mov="" es,ax="" ;06454="" mov="" di,0001h="" ;06456="" mov="" cx,03e8h="" ;06459="" mov="" al,3ch="" ;0645c="" cld="" ;0645e="" forward="" string="" opers="" b0645f:="" stosb="" ;0645f="" store="" al="" at="" es:[di]="" inc="" di="" ;06460="" loop="" b0645f="" ;06461="" dec="" cx;loop="" if="" cx="">0
                MOV     DI,0002H                ;06463 
                MOV     CX,0026H                ;06466 
                MOV     AL,0CDH                 ;06469 
                MOV     AH,3FH                  ;0646B 
                CLD                             ;0646D Forward String Opers
b0646e:         MOV     WORD PTR ES:[DI],AX     ;0646E 
                ASSUME ES:dsegb800
                MOV     WORD PTR ES:db8780[DI],AX ;
                                                ;06471 
                INC     DI                      ;06476 
                INC     DI                      ;06477 
                LOOP    b0646e                  ;06478 Dec CX;Loop if CX>0
                MOV     DI,0050H                ;0647A 
                MOV     CX,0017H                ;0647D 
                MOV     AL,0BAH                 ;06480 
                MOV     AH,3FH                  ;06482 
                CLD                             ;06484 Forward String Opers
b06485:         MOV     WORD PTR ES:[DI],AX     ;06485 
                MOV     WORD PTR ES:[DI+4EH],AX ;06488 
                ADD     DI,50H                  ;0648C 
                LOOP    b06485                  ;0648F Dec CX;Loop if CX>0
                MOV     AL,0C9H                 ;06491 
                MOV     AH,3FH                  ;06493 
                MOV     WORD PTR ES:db8000,AX   ;06495 
                MOV     AL,0BBH                 ;06499 
                MOV     AH,3FH                  ;0649B 
                MOV     WORD PTR ES:db804e,AX   ;0649D 
                MOV     AL,0C8H                 ;064A1 
                MOV     AH,3FH                  ;064A3 
                MOV     WORD PTR ES:db8780,AX   ;064A5 
                MOV     AL,0BCH                 ;064A9 
                MOV     AH,3FH                  ;064AB 
                MOV     WORD PTR ES:db87ce,AX   ;064AD 
                PUSH    CS                      ;064B1 
;<ds =="" 0600="">
                POP     DS                      ;064B2 
                MOV     SI,03EFH                ;064B3 
                MOV     DI,0378H                ;064B6 
                MOV     CX,00FFH                ;064B9 
                MOV     AH,70H                  ;064BC 
b064be:         LODSB                           ;064BE Load AL with DS:[SI]
                CMP     AL,24H ;($)             ;064BF 
                JE      b064c6                  ;064C1 Jump if equal (ZF=1)
                STOSW                           ;064C3 Store AX at ES:[DI]
                LOOP    b064be                  ;064C4 Dec CX;Loop if CX>0
;<es =="" 0600="">
b064c6:         RETN                            ;064C6 
s1              ENDP
 
;<064c7>
s2              PROC NEAR
                PUSH    CS                      ;064C7 
                POP     DS                      ;064C8 
                MOV     AH,00                   ;064C9 
                MOV     AL,BYTE PTR DS:d062ae   ;064CB 
                INT     10H                     ;064CE CRT:00-set video 
                                                ;     mode, AL=mode
                PUSH    CS                      ;064D0 
                POP     DS                      ;064D1 
                MOV     AH,02                   ;064D2 
                MOV     BH,BYTE PTR DS:d062af   ;064D4 
                MOV     DH,BYTE PTR DS:d062ac   ;064D8 
                MOV     DL,BYTE PTR DS:d062ad   ;064DC 
                INT     10H                     ;064E0 CRT:02-set cursor 
                                                ;     positn,DX=y,x
                MOV     AX,SEG dsegb800 ;abs    ;064E2 >>xref=<b8000>< ;="" ;at="" 0b800=""><es =="" b800="">
                MOV     ES,AX                   ;064E5 
                MOV     AX,WORD PTR CS:d062aa   ;064E7 
;<ds =="" b800="">
                MOV     DS,AX                   ;064EB 
                MOV     SI,0000H                ;064ED 
                MOV     DI,0000H                ;064F0 
                MOV     CX,4000H                ;064F3 
                CLD                             ;064F6 Forward String Opers
                REP     MOVSB                   ;064F7 Mov DS:[SI]->ES:[DI]
;<es =="" 0600="">
                RETN                            ;064F9 
;<ds =="" 0600="">
m064fa:         PUSHF                           ;064FA Push flags on Stack
                PUSH    AX                      ;064FB 
                PUSH    BP                      ;064FC Save Argument Pointr
                PUSH    BX                      ;064FD 
                PUSH    CX                      ;064FE 
                PUSH    DI                      ;064FF 
                PUSH    DS                      ;06500 
                PUSH    DX                      ;06501 
                PUSH    ES                      ;06502 
                PUSH    SI                      ;06503 
                PUSH    DX                      ;06504 
                MOV     AX,CS                   ;06505 
                MOV     DS,AX                   ;06507 
                MOV     ES,AX                   ;06509 
                CMP     DL,02                   ;0650B 
                JB      b0651d                  ;0650E Jump if < (no="" sign)="" cmp="" dl,80h="" ;06510="" je="" b0651d="" ;06513="" jump="" if="" equal="" (zf="1)" cmp="" dl,81h="" ;06515="" je="" b0651d="" ;06518="" jump="" if="" equal="" (zf="1)" jmp="" near="" ptr="" m0679c="" ;0651a="" b0651d:="" mov="" si,dx="" ;0651d="" and="" si,00ffh="" ;0651f="" cmp="" si,0080h="" ;06523="" jb="" b0652f="" ;06527="" jump="" if="">< (no="" sign)="" and="" si,01="" ;06529="" add="" si,02="" ;0652c="" b0652f:="" and="" si,03="" ;0652f="" add="" si,0287h="" ;06532="" cmp="" byte="" ptr="" [si],00="" ;06536="" jne="" b06561="" ;06539="" jump="" not="" equal(zf="0)" cmp="" ah,02="" ;0653b="" je="" b06554="" ;0653e="" jump="" if="" equal="" (zf="1)" cmp="" ah,03="" ;06540="" je="" b06554="" ;06543="" jump="" if="" equal="" (zf="1)" cmp="" ah,04="" ;06545="" je="" b06554="" ;06548="" jump="" if="" equal="" (zf="1)" cmp="" ah,0ah="" ;0654a="" je="" b06554="" ;0654d="" jump="" if="" equal="" (zf="1)" cmp="" ah,0bh="" ;0654f="" je="" b06554="" ;06552="" jump="" if="" equal="" (zf="1)" b06554:="" cmp="" dh,00="" ;06554="" jne="" b0655e="" ;06557="" jump="" not="" equal(zf="0)" cmp="" cx,01="" ;06559="" je="" b06561="" ;0655c="" jump="" if="" equal="" (zf="1)" b0655e:="" jmp="" near="" ptr="" m0679c="" ;0655e="" b06561:="" mov="" ah,00="" ;06561="" call="" near="" ptr="" s3="" ;06563="">>xref=<067b0>< pop="" dx="" ;06566="" pop="" si="" ;06567="" pop="" es="" ;06568="" pop="" dx="" ;06569="" pop="" ds="" ;0656a="" pop="" di="" ;0656b="" pop="" cx="" ;0656c="" pop="" bx="" ;0656d="" pop="" bp="" ;0656e="" restore="" arg="" pointer="" pop="" ax="" ;0656f="" popf="" ;06570="" pop="" flags="" off="" stack="" pushf="" ;06571="" push="" flags="" on="" stack="" push="" ax="" ;06572="" push="" bp="" ;06573="" save="" argument="" pointr="" push="" bx="" ;06574="" push="" cx="" ;06575="" push="" di="" ;06576="" push="" ds="" ;06577="" push="" dx="" ;06578="" push="" es="" ;06579="" push="" si="" ;0657a="" push="" dx="" ;0657b="" push="" cs="" ;0657c="" pop="" es="" ;0657d="" mov="" ah,02="" ;0657e="" mov="" al,01="" ;06580="" mov="" ch,00="" ;06582="" mov="" cl,01="" ;06584="" mov="" dh,00="" ;06586="" mov="" bx,0e00h="" ;06588="" call="" near="" ptr="" s3="" ;0658b="">>xref=<067b0>< mov="" bp,sp="" ;0658e="" jnb="" b0659d="" ;06590="" jump="" if="">= (no sign)
                MOV     WORD PTR [BP+12H],AX    ;06592 
                PUSHF                           ;06595 Push flags on Stack
                POP     AX                      ;06596 
                MOV     WORD PTR [BP+1AH],AX    ;06597 
                JMP     NEAR PTR m066e1         ;0659A 
b0659d:         POP     DX                      ;0659D 
                POP     SI                      ;0659E 
                POP     ES                      ;0659F 
                POP     DX                      ;065A0 
                POP     DS                      ;065A1 
                POP     DI                      ;065A2 
                POP     CX                      ;065A3 
                POP     BX                      ;065A4 
                POP     BP                      ;065A5 Restore Arg Pointer
                POP     AX                      ;065A6 
                POPF                            ;065A7 Pop flags off Stack
                PUSHF                           ;065A8 Push flags on Stack
                PUSH    AX                      ;065A9 
                PUSH    BP                      ;065AA Save Argument Pointr
                PUSH    BX                      ;065AB 
                PUSH    CX                      ;065AC 
                PUSH    DI                      ;065AD 
                PUSH    DS                      ;065AE 
                PUSH    DX                      ;065AF 
                PUSH    ES                      ;065B0 
                PUSH    SI                      ;065B1 
                PUSH    DX                      ;065B2 
                CALL    NEAR PTR s4             ;065B3 >>xref=<067b7>< pop="" dx="" ;065b6="" pop="" si="" ;065b7="" pop="" es="" ;065b8="" pop="" dx="" ;065b9="" pop="" ds="" ;065ba="" pop="" di="" ;065bb="" pop="" cx="" ;065bc="" pop="" bx="" ;065bd="" pop="" bp="" ;065be="" restore="" arg="" pointer="" pop="" ax="" ;065bf="" popf="" ;065c0="" pop="" flags="" off="" stack="" pushf="" ;065c1="" push="" flags="" on="" stack="" push="" ax="" ;065c2="" push="" bp="" ;065c3="" save="" argument="" pointr="" push="" bx="" ;065c4="" push="" cx="" ;065c5="" push="" di="" ;065c6="" push="" ds="" ;065c7="" push="" dx="" ;065c8="" push="" es="" ;065c9="" push="" si="" ;065ca="" push="" dx="" ;065cb="" push="" cs="" ;065cc="" pop="" ds="" ;065cd="" pop="" si="" ;065ce="" push="" si="" ;065cf="" and="" si,00ffh="" ;065d0="" cmp="" si,0080h="" ;065d4="" jb="" b065e0="" ;065d8="" jump="" if="">< (no="" sign)="" and="" si,01="" ;065da="" add="" si,02="" ;065dd="" b065e0:="" and="" si,03="" ;065e0="" add="" si,0287h="" ;065e3="" mov="" byte="" ptr="" [si],00="" ;065e7="" mov="" si,0e02h="" ;065ea="" mov="" ax,cs="" ;065ed="" sub="" ax,0020h="" ;065ef="" mov="" es,ax="" ;065f2="" mov="" di,0002h="" ;065f4="" mov="" bh,00="" ;065f7="" mov="" bl,byte="" ptr="" es:[di-01]="" ;065f9="" add="" di,bx="" ;065fd="" add="" si,bx="" ;065ff="" mov="" cx,0179h="" ;06601="" sub="" cx,di="" ;06604="" cld="" ;06606="" forward="" string="" opers="" repz="" cmpsb="" ;06607="" flgs="DS:[SI]-ES:[DI]" je="" b0660e="" ;06609="" jump="" if="" equal="" (zf="1)" jmp="" near="" ptr="" m066f0="" ;0660b="" b0660e:="" pop="" dx="" ;0660e="" pop="" si="" ;0660f="" pop="" es="" ;06610="" pop="" dx="" ;06611="" pop="" ds="" ;06612="" pop="" di="" ;06613="" pop="" cx="" ;06614="" pop="" bx="" ;06615="" pop="" bp="" ;06616="" restore="" arg="" pointer="" pop="" ax="" ;06617="" popf="" ;06618="" pop="" flags="" off="" stack="" pushf="" ;06619="" push="" flags="" on="" stack="" push="" ax="" ;0661a="" push="" bp="" ;0661b="" save="" argument="" pointr="" push="" bx="" ;0661c="" push="" cx="" ;0661d="" push="" di="" ;0661e="" push="" ds="" ;0661f="" push="" dx="" ;06620="" push="" es="" ;06621="" push="" si="" ;06622="" push="" dx="" ;06623="" cmp="" ah,02="" ;06624="" je="" b06640="" ;06627="" jump="" if="" equal="" (zf="1)" cmp="" ah,03="" ;06629="" je="" b06640="" ;0662c="" jump="" if="" equal="" (zf="1)" cmp="" ah,04="" ;0662e="" je="" b06640="" ;06631="" jump="" if="" equal="" (zf="1)" cmp="" ah,0ah="" ;06633="" je="" b06640="" ;06636="" jump="" if="" equal="" (zf="1)" cmp="" ah,0bh="" ;06638="" je="" b06640="" ;0663b="" jump="" if="" equal="" (zf="1)" jmp="" near="" ptr="" m066ed="" ;0663d="" b06640:="" cmp="" ch,00="" ;06640="" je="" b06648="" ;06643="" jump="" if="" equal="" (zf="1)" jmp="" near="" ptr="" m066ed="" ;06645="" b06648:="" cmp="" cl,01="" ;06648="" je="" b06650="" ;0664b="" jump="" if="" equal="" (zf="1)" jmp="" near="" ptr="" m066ed="" ;0664d="" b06650:="" cmp="" dh,00="" ;06650="" je="" b06658="" ;06653="" jump="" if="" equal="" (zf="1)" jmp="" near="" ptr="" m066ed="" ;06655="" b06658:="" push="" ax="" ;06658="" push="" es="" ;06659="" push="" bx="" ;0665a="" mov="" ax,cs="" ;0665b="" sub="" ax,0020h="" ;0665d="" mov="" es,ax="" ;06660="" mov="" di,0002h="" ;06662="" mov="" bh,00="" ;06665="" mov="" bl,byte="" ptr="" es:[di-01]="" ;06667="" add="" di,bx="" ;0666b="" mov="" ch,byte="" ptr="" es:[di-03]="" ;0666d="" mov="" cl,byte="" ptr="" es:[di-02]="" ;06671="" add="" cl,07="" ;06675="" pop="" bx="" ;06678="" pop="" es="" ;06679="" pop="" ax="" ;0667a="" mov="" al,01="" ;0667b="" call="" near="" ptr="" s3="" ;0667d="">>xref=<067b0>< mov="" bp,sp="" ;06680="" mov="" cx,word="" ptr="" [bp+12h]="" ;06682="" mov="" word="" ptr="" [bp+12h],ax="" ;06685="" pushf="" ;06688="" push="" flags="" on="" stack="" pop="" ax="" ;06689="" mov="" word="" ptr="" [bp+1ah],ax="" ;0668a="" jnb="" b06692="" ;0668d="" jump="" if="">= (no sign)
                JMP     SHORT m066e1            ;0668F 
                NOP                             ;06691 
b06692:         CMP     CL,01                   ;06692 
                JNE     b0669a                  ;06695 Jump not equal(ZF=0)
                JMP     SHORT m066e1            ;06697 
                NOP                             ;06699 
b0669a:         DEC     CL                      ;0669A 
                MOV     WORD PTR [BP+12H],CX    ;0669C 
                POP     DX                      ;0669F 
                POP     SI                      ;066A0 
                POP     ES                      ;066A1 
                POP     DX                      ;066A2 
                POP     DS                      ;066A3 
                POP     DI                      ;066A4 
                POP     CX                      ;066A5 
                POP     BX                      ;066A6 
                POP     BP                      ;066A7 Restore Arg Pointer
                POP     AX                      ;066A8 
                POPF                            ;066A9 Pop flags off Stack
                PUSHF                           ;066AA Push flags on Stack
                PUSH    AX                      ;066AB 
                PUSH    BP                      ;066AC Save Argument Pointr
                PUSH    BX                      ;066AD 
                PUSH    CX                      ;066AE 
                PUSH    DI                      ;066AF 
                PUSH    DS                      ;066B0 
                PUSH    DX                      ;066B1 
                PUSH    ES                      ;066B2 
                PUSH    SI                      ;066B3 
                PUSH    DX                      ;066B4 
                INC     CL                      ;066B5 
                ADD     BX,0200H                ;066B7 
                CALL    NEAR PTR s3             ;066BB >>xref=<067b0>< mov="" bp,sp="" ;066be="" pushf="" ;066c0="" push="" flags="" on="" stack="" pop="" cx="" ;066c1="" mov="" word="" ptr="" [bp+1ah],cx="" ;066c2="" jnb="" b066ce="" ;066c5="" jump="" if="">= (no sign)
                MOV     AH,04                   ;066C7 
                MOV     AL,00                   ;066C9 
                JMP     SHORT b066d0            ;066CB 
                NOP                             ;066CD 
b066ce:         INC     AL                      ;066CE 
b066d0:         MOV     WORD PTR [BP+12H],AX    ;066D0 
                MOV     AX,0001H                ;066D3 
                MOV     WORD PTR [BP+0CH],AX    ;066D6 
                MOV     AX,WORD PTR [BP+06]     ;066D9 
                MOV     AH,00                   ;066DC 
                MOV     WORD PTR [BP+06],AX     ;066DE 
m066e1:         POP     DX                      ;066E1 
                POP     SI                      ;066E2 
                POP     ES                      ;066E3 
                POP     DX                      ;066E4 
                POP     DS                      ;066E5 
                POP     DI                      ;066E6 
                POP     CX                      ;066E7 
                POP     BX                      ;066E8 
                POP     BP                      ;066E9 Restore Arg Pointer
                POP     AX                      ;066EA 
                POPF                            ;066EB Pop flags off Stack
                IRET                            ;066EC POP flags and Return
m066ed:         JMP     NEAR PTR m0679c         ;066ED 
m066f0:         PUSH    CS                      ;066F0 
                POP     DS                      ;066F1 
                MOV     AH,00                   ;066F2 
                CALL    NEAR PTR s3             ;066F4 >>xref=<067b0>< mov="" cx,0004h="" ;066f7="" b066fa:="" push="" cs="" ;066fa="" pop="" ds="" ;066fb="" pop="" dx="" ;066fc="" push="" dx="" ;066fd="" cmp="" dx,0080h="" ;066fe="" jnb="" b06733="" ;06702="" jump="" if="">= (no sign)
                MOV     AX,CS                   ;06704 
                SUB     AX,0020H                ;06706 
                MOV     ES,AX                   ;06709 
                MOV     DI,0002H                ;0670B 
                MOV     BH,00                   ;0670E 
                MOV     BL,BYTE PTR ES:[DI-01]  ;06710 
                ADD     DI,BX                   ;06714 
                PUSH    CX                      ;06716 
                MOV     AH,05                   ;06717 
                MOV     AL,01                   ;06719 
                MOV     CH,BYTE PTR ES:[DI-03]  ;0671B 
                MOV     CL,01                   ;0671F 
                MOV     DH,00                   ;06721 
                PUSH    CS                      ;06723 
                POP     ES                      ;06724 
                MOV     BX,0836H                ;06725 
                CALL    NEAR PTR s3             ;06728 >>xref=<067b0>< pop="" cx="" ;0672b="" jnb="" b06733="" ;0672c="" jump="" if="">= (no sign)
                LOOP    b066fa                  ;0672E Dec CX;Loop if CX>0
                JMP     SHORT m0679c            ;06730 
                NOP                             ;06732 
b06733:         MOV     CX,0008H                ;06733 
b06736:         POP     DX                      ;06736 
                PUSH    DX                      ;06737 
                PUSH    CX                      ;06738 
                MOV     AX,CS                   ;06739 
                SUB     AX,0020H                ;0673B 
                MOV     ES,AX                   ;0673E 
                MOV     DI,0002H                ;06740 
                MOV     BH,00                   ;06743 
                MOV     BL,BYTE PTR ES:[DI-01]  ;06745 
                ADD     DI,BX                   ;06749 
                MOV     AH,03                   ;0674B 
                MOV     AL,08                   ;0674D 
                MOV     CH,BYTE PTR ES:[DI-03]  ;0674F 
                MOV     CL,BYTE PTR ES:[DI-02]  ;06753 
                MOV     DH,00                   ;06757 
                PUSH    CS                      ;06759 
                POP     ES                      ;0675A 
                MOV     BX,0000H                ;0675B 
                CALL    NEAR PTR s3             ;0675E >>xref=<067b0>< pop="" cx="" ;06761="" jnb="" b06769="" ;06762="" jump="" if="">= (no sign)
                LOOP    b06736                  ;06764 Dec CX;Loop if CX>0
                JMP     SHORT m0679c            ;06766 
                NOP                             ;06768 
b06769:         MOV     CX,0004H                ;06769 
b0676c:         POP     DX                      ;0676C 
                PUSH    DX                      ;0676D 
                PUSH    CX                      ;0676E 
                MOV     AX,CS                   ;0676F 
                SUB     AX,0020H                ;06771 
                MOV     ES,AX                   ;06774 
                MOV     BX,0000H                ;06776 
                MOV     AH,03                   ;06779 
                MOV     AL,01                   ;0677B 
                MOV     CH,00                   ;0677D 
                MOV     CL,01                   ;0677F 
                MOV     DH,00                   ;06781 
                CALL    NEAR PTR s3             ;06783 >>xref=<067b0>< pop="" cx="" ;06786="" jb="" b06797="" ;06787="" jump="" if="">< (no="" sign)="" pop="" dx="" ;06789="" pop="" si="" ;0678a="" pop="" es="" ;0678b="" pop="" dx="" ;0678c="" pop="" ds="" ;0678d="" pop="" di="" ;0678e="" pop="" cx="" ;0678f="" pop="" bx="" ;06790="" pop="" bp="" ;06791="" restore="" arg="" pointer="" pop="" ax="" ;06792="" popf="" ;06793="" pop="" flags="" off="" stack="" jmp="" near="" ptr="" m064fa="" ;06794="" b06797:="" loop="" b0676c="" ;06797="" dec="" cx;loop="" if="" cx="">0
                JMP     SHORT m0679c            ;06799 
                NOP                             ;0679B 
m0679c:         POP     DX                      ;0679C 
                POP     SI                      ;0679D 
                POP     ES                      ;0679E 
                POP     DX                      ;0679F 
                POP     DS                      ;067A0 
                POP     DI                      ;067A1 
                POP     CX                      ;067A2 
                POP     BX                      ;067A3 
                POP     BP                      ;067A4 Restore Arg Pointer
                POP     AX                      ;067A5 
                POPF                            ;067A6 Pop flags off Stack
                JMP     DWORD PTR CS:d067ac     ;067A7 
d067ac          EQU     $
                POP     CX                      ;067AC 
                IN      AL,DX                   ;067AD 7f8-7ff:Breakpoint
                ADD     AL,DH                   ;067AE 
s2              ENDP
 
;<067b0>
s3              PROC NEAR
                PUSHF                           ;067B0 Push flags on Stack
                CALL    DWORD PTR CS:d067ac     ;067B1 
                RETN                            ;067B6 
s3              ENDP
 
;<067b7>
s4              PROC NEAR
                PUSH    DX                      ;067B7 
                MOV     AX,CS                   ;067B8 
                SUB     AX,0020H                ;067BA 
                MOV     ES,AX                   ;067BD 
                MOV     DI,0002H                ;067BF 
                MOV     BH,00                   ;067C2 
                MOV     BL,BYTE PTR ES:[DI-01]  ;067C4 
                ADD     DI,BX                   ;067C8 
                CMP     DL,80H                  ;067CA 
                JB      b067e1                  ;067CD Jump if < (no="" sign)="" mov="" byte="" ptr="" es:[di-03],00="" ;067cf="" mov="" byte="" ptr="" es:[di-02],02="" ;067d4="" mov="" byte="" ptr="" es:[di-01],80h="" ;067d9="" jmp="" short="" b06804="" ;067de="" nop="" ;067e0="" b067e1:="" mov="" byte="" ptr="" es:[di-02],01="" ;067e1="" mov="" byte="" ptr="" es:[di-01],00="" ;067e6="" mov="" byte="" ptr="" es:[di-03],28h="" ;067eb="" mov="" ah,04="" ;067f0="" mov="" al,01="" ;067f2="" mov="" ch,00="" ;067f4="" mov="" cl,0fh="" ;067f6="" mov="" dh,00="" ;067f8="" call="" near="" ptr="" s3="" ;067fa="">>xref=<067b0>< jb="" b06804="" ;067fd="" jump="" if="">< (no="" sign)="" mov="" byte="" ptr="" es:[di-03],50h="" ;067ff="" b06804:="" push="" di="" ;06804="" push="" cs="" ;06805="" pop="" ds="" ;06806="" mov="" si,0e03h="" ;06807="" mov="" cx,di="" ;0680a="" sub="" cx,06="" ;0680c="" mov="" di,0003h="" ;0680f="" cld="" ;06812="" forward="" string="" opers="" rep="" movsb="" ;06813="" mov="" ds:[si]-="">ES:[DI]
                MOV     SI,0F79H                ;06815 
                MOV     DI,0179H                ;06818 
                MOV     CX,0087H                ;0681B 
                CLD                             ;0681E Forward String Opers
                REP     MOVSB                   ;0681F Mov DS:[SI]->ES:[DI]
                POP     DI                      ;06821 
                MOV     AL,BYTE PTR ES:[DI-03]  ;06822 
                PUSH    CS                      ;06826 
                POP     ES                      ;06827 
                MOV     DI,0836H                ;06828 
                MOV     CX,0008H                ;0682B 
b0682e:         STOSB                           ;0682E Store AL at ES:[DI]
                INC     DI                      ;0682F 
                INC     DI                      ;06830 
                INC     DI                      ;06831 
                LOOP    b0682e                  ;06832 Dec CX;Loop if CX>0
                POP     DX                      ;06834 
                RETN                            ;06835 
;-----------------------------------------------------
                DB      28,00,01,02,28,00       ;06836 (...(.
                DB      02,02,28,00,03,02       ;0683C ..(...
                DB      28,00,04,02,28,00       ;06842 (...(.
                DB      05,02,28,00,06,02       ;06848 ..(...
                DB      28,00,07,02,28,00       ;0684E (...(.
                DB      08,02,1F                ;06854 ...
;-----------------------------------------------------
                DEC     DI                      ;06857 
                ADD     SP,02                   ;06858 
                MOV     WORD PTR [BP-02],AX     ;0685B 
                MOV     AX,WORD PTR DS:d06dc8   ;0685E 
                MOV     WORD PTR DS:d06dc2,AX   ;06861 
                CMP     WORD PTR [BP-02],00     ;06864 
                JE      b0686f                  ;06868 Jump if equal (ZF=1)
                MOV     AX,0857H                ;0686A 
                JMP     SHORT b06872            ;0686D 
;-----------------------------------------------------
b0686f:         DB      0B8,60,08               ;0686F .`.
b06872:         DB      50,9A,98,03,0BA,48      ;06872 P....H
                DB      83,0C4,02,0FF,06,0B6    ;06878 ......
                DB      0DH,0C7,06,0B8,0DH,0F   ;0687E ......
                DB      00,0B8,69,08,50,9A      ;06884 ..i.P.
                DB      98,03,0BA,48,83,0C4     ;0688A ...H..
                DB      02,83,7E,0FE,00,75      ;06890 .....u
                DB      12,0A1,0C8,0DH,0A3,0C2  ;06896 ......
                DB      0DH,0B8,8C,08,50,9A     ;0689C ....P.
                DB      98,03,0BA,48,83,0C4     ;068A2 ...H..
                DB      02,0A1,0C8,0DH,0A3,0C2  ;068A8 ......
                DB      0DH,0B8,91,08,50,9A     ;068AE ....P.
                DB      98,03,0BA,48,83,0C4     ;068B4 ...H..
                DB      02,0B8,96,08,50,9A      ;068BA ....P.
                DB      98,03,0BA,48,83,0C4     ;068C0 ...H..
                DB      02,0C7,06,0B6,0DH,12    ;068C6 ......
                DB      00,0B8,0D0,1BH,50,9A    ;068CC ....P.
                DB      71,03,0BA,48,83,0C4     ;068D2 q..H..
                DB      02,0FF,06,0B6,0DH,0B8   ;068D8 ......
                DB      0F8,1BH,50,9A,71,03     ;068DE ..P.q.
                DB      0BA,48,83,0C4,02,0C7    ;068E4 .H....
                DB      06,0B6,0DH,0F,00,0C7    ;068EA ......
                DB      06,0B8,0DH,23,00,0A1    ;068F0 ...#..
                DB      0C8,0DH,0A3,0C2,0DH,0C7 ;068F6 ......
                DB      06,0BA,0DH,0F,00,0C7    ;068FC ......
                DB      06,0BC,0DH,23,00,0B8    ;06902 ...#..
                DB      04,4A,50,9A,98,03       ;06908 .JP...
                DB      0BA,48,8BH,0E5,5DH,0C3  ;0690E .H..].
                DB      55,8BH,0EC,9A,03,0C     ;06914 U.....
                DB      0C2,36,0C7,06,0B6,0DH   ;0691A .6....
                DB      02,00,0B8,0A8,08,50     ;06920 .....P
                DB      9A,0CBH,04,0C2,36,83    ;06926 ....6.
                DB      0C4,02,0C7,06,0B6,0DH   ;0692C ......
                DB      09,00,0A1,0C8,0DH,0A3   ;06932 ......
                DB      0C2,0DH,0B8,0C2,08,50   ;06938 .....P
                DB      9A,71,03,0BA,48,83      ;0693E .q..H.
                DB      0C4,02,83,06,0B6,0DH    ;06944 ......
                DB      02,0A1,0C8,0DH,0A3,0C2  ;0694A ......
                DB      0DH,0B8,0DF,08,50,9A    ;06950 ....P.
                DB      71,03,0BA,48,83,0C4     ;06956 q..H..
                DB      02,0FF,06,0B6,0DH,0A1   ;0695C ......
                DB      0C8,0DH,0A3,0C2,0DH,0B8 ;06962 ......
                DB      0FE,08,50,9A,71,03      ;06968 ..P.q.
                DB      0BA,48,83,0C4,02,9A     ;0696E .H....
                DB      0BH,00,23,4A,0C7,06     ;06974 ..#J..
                DB      0B6,0DH,13,00,0C7,06    ;0697A ......
                DB      0B8,0DH,00,00,9A,06     ;06980 ......
                DB      00,1C,3DH,8BH,0E5,5DH   ;06986 ..=..]
                DB      0C3,55,8BH,0EC,83,0EC   ;0698C .U....
                DB      3E,0A1,0E6,0DH,89,46    ;06992 >....F
                DB      0C2,48,89,46,0C8,83     ;06998 .H.F..
                DB      3E,0E6,0DH,00,75,3BH    ;0699E >...u;
                DB      0C7,06,0E4,0DH,00,00    ;069A4 ......
                DB      0B8,1C,09,50,0B8,0E4    ;069AA ...P..
                DB      0DH,50,0B8,04,4A,50     ;069B0 .P..JP
                DB      9A,0E,00,8E,37,83       ;069B6 ....7.
                DB      0C4,06,0E8,0B8,05,0BH   ;069BC ......
                DB      0C0,75,09,0E8,4C,0FF    ;069C2 .u..L.
                DB      0B8,01,00,0E9,4C,02     ;069C8 ....L.
                DB      0E8,4DH,02,0BH,0C0,74   ;069CE .M...t
                DB      0F3,9A,56,06,20,3DH     ;069D4 ..V. =
                DB      2BH,0C0,0E9,3BH,02,0C7  ;069DA +..;..
                DB      46,0C4,01,00,0A1,0E6    ;069E0 F.....
                DB      0DH,39,46,0C8,74,25     ;069E6 .9F.t%
                DB      9A                      ;069EC .
;-----------------------------------------------------
                MOV     WORD PTR [BP+DI],3D20H  ;069ED 
                MOV     AX,4A04H                ;069F1 
                PUSH    AX                      ;069F4 
                MOV     AX,0DE4H                ;069F5 
                PUSH    AX                      ;069F8 
                PUSH    WORD PTR DS:d0a96e      ;069F9 
                PUSH    WORD PTR DS:d15a6c      ;069FD 
                SUB     AX,AX                   ;06A01 Load register w/ 
                                                ;     0
;<ss =="" 0000="">
                MOV     SS,AX                   ;06A03 
;<es =="" 0000="">
                MOV     ES,AX                   ;06A05 
;<ds =="" 0000="">
                MOV     DS,AX                   ;06A07 
                MOV     AX,7C00H                ;06A09 
                MOV     SP,AX                   ;06A0C 
                STI                             ;06A0E Turn ON Interrupts
                MOV     SI,AX                   ;06A0F 
                MOV     DI,7E00H                ;06A11 
                CLD                             ;06A14 Forward String Opers
                MOV     CX,0100H                ;06A15 
                REP     MOVSW                   ;06A18 Mov DS:[SI]->ES:[DI]
                JMP     NEAR PTR m06c1d         ;06A1A 
                MOV     CX,0010H                ;06A1D 
                ASSUME DS:dseg0000
                MOV     SI,WORD PTR DS:d07e85   ;06A20 
b06a24:         TEST    BYTE PTR [SI],80H       ;06A24 Flags=Arg1 AND Arg2
                JNE     b06a31                  ;06A27 Jump not equal(ZF=0)
                SUB     SI,10H                  ;06A29 
                LOOP    b06a24                  ;06A2C Dec CX;Loop if CX>0
                JMP     SHORT b06a67            ;06A2E 
                NOP                             ;06A30 
b06a31:         MOV     DI,07BEH                ;06A31 
                PUSH    DI                      ;06A34 
                MOV     CX,0008H                ;06A35 
                REP     MOVSW                   ;06A38 Mov DS:[SI]->ES:[DI]
                POP     SI                      ;06A3A 
                MOV     BX,7C00H                ;06A3B 
                MOV     DX,WORD PTR [SI]        ;06A3E 
                MOV     CX,WORD PTR [SI+02]     ;06A40 
                MOV     BP,0005H                ;06A43 
b06a46:         MOV     AX,0201H                ;06A46 
                INT     13H                     ;06A49 DSK:02-read sector, 
                                                ;     into ES:BX
                JNB     b06a56                  ;06A4B Jump if >= (no sign)
                SUB     AX,AX                   ;06A4D Load register w/ 
                                                ;     0
                INT     13H                     ;06A4F DSK:00-reset, DL=dri-
                                                ;     ve
                DEC     BP                      ;06A51 
                JE      b06a6d                  ;06A52 Jump if equal (ZF=1)
                JMP     SHORT b06a46            ;06A54 
b06a56:         MOV     SI,7DFEH                ;06A56 
                LODSW                           ;06A59 Load AX with DS:[SI]
                CMP     AX,0AA55H               ;06A5A 
                JNE     b06a73                  ;06A5D Jump not equal(ZF=0)
                MOV     SI,07BEH                ;06A5F 
;<es =="" 0600="">
;<ss =="" 0600="">
;<ds =="" 0600="">
                DB      0EA,00,7C,00,00 ;(# 5)jmp far ptr m07C00 ;
                                                ;06A62 
                ASSUME DS:sseg
b06a67:         MOV     SI,WORD PTR DS:d0de87   ;06A67 
                JMP     SHORT b06a77            ;06A6B 
b06a6d:         MOV     SI,WORD PTR DS:d0de89   ;06A6D 
                JMP     SHORT b06a77            ;06A71 
b06a73:         MOV     SI,WORD PTR DS:d0de8b   ;06A73 
b06a77:         LODSB                           ;06A77 Load AL with DS:[SI]
                OR      AL,AL                   ;06A78 Set Flags
b06a7a:         JE      b06a7a                  ;06A7A Jump if equal (ZF=1)
                MOV     BX,0007H                ;06A7C 
                MOV     AH,0EH                  ;06A7F 
                INT     10H                     ;06A81 CRT:0e-wr Teletype 
                                                ;     mode,AL=char
                JMP     SHORT b06a77            ;06A83 
;-----------------------------------------------------
                DB      0EE,7F,8DH,7E,0A7,7E    ;06A85 ......
                DB      0C8                     ;06A8B .
                DB      7E,0DH,0A               ;06A8C ...
                DB      'Invalid Partition Tab' ;06A8F 
                DB      'le'                    ;06AA4 
                DB      00,0DH,0A               ;06AA6 ...
                DB      'Error Loading Operati' ;06AA9 
                DB      'ng System'             ;06ABE 
                DB      00,0DH,0A               ;06AC7 ...
                DB      'Missing Operating Sys' ;06ACA 
                DB      'tem'                   ;06ADF 
                DB      26D DUP (00H)           ;06AE2 (.)
                DB      0AA,55                  ;06AFC .U
                DB      192D DUP (00H)          ;06AFE (.)
                DB      80,01,01,00,01,08       ;06BBE ......
                DB      51,0A6,11,00,00,00      ;06BC4 Q.....
                DB      0BE,0FC,00,00,00,00     ;06BCA ......
                DB      41,0A7,51,08,0D1,9BH    ;06BD0 A.Q...
                DB      0CF,0FC,00,00,6DH,2BH   ;06BD6 ....m+
                DB      01                      ;06BDC .
                DB      33D DUP (00H)           ;06BDD (.)
                DB      55,0AA                  ;06BFE U.
                DB      29D DUP (0F6H)          ;06C00 (.)
m06c1d:         DB      421D DUP (0F6H)         ;06C1D (.)
d06dc2          DB      6D DUP (0F6H)           ;06DC2 (.)
d06dc8          DB      56D DUP (0F6H)          ;06DC8 (.)
                DB      0EBH,3C,90,4DH,53,44    ;06E00 .<.msd db="" 4f,53,35,2e,30,00="" ;06e06="" os5.0.="" db="" 02,02,01,00,02,70="" ;06e0c="" .....p="" db="" 00,0d0,02,0fdh,02,00="" ;06e12="" ......="" db="" 09,00,02="" ;06e18="" ...="" db="" 11d="" dup="" (00h)="" ;06e1b="" (.)="" db="" 29,0f7,10,27,1c="" ;06e26="" )..'.="" db="" 'joshi="" fat12="" '="" ;06e2b="" ;-----------------------------------------------------="" cli="" ;06e3e="" turn="" off="" interrupts="" xor="" ax,ax="" ;06e3f="" load="" register="" w/="" ;="" 0=""></.msd><ss =="" 0000="">
                MOV     SS,AX                   ;06E41 
                MOV     SP,7C00H                ;06E43 
                PUSH    SS                      ;06E46 
                POP     ES                      ;06E47 
                MOV     BX,0078H                ;06E48 
                LDS     SI,DWORD PTR SS:[BX]    ;06E4B 
                PUSH    DS                      ;06E4E 
                PUSH    SI                      ;06E4F 
                PUSH    SS                      ;06E50 
                PUSH    BX                      ;06E51 
                MOV     DI,7C3EH                ;06E52 
                MOV     CX,000BH                ;06E55 
                CLD                             ;06E58 Forward String Opers
                REP     MOVSB                   ;06E59 Mov DS:[SI]->ES:[DI]
                PUSH    ES                      ;06E5B 
                POP     DS                      ;06E5C 
                MOV     BYTE PTR [DI-02],0FH    ;06E5D 
                MOV     CX,WORD PTR DS:d0dc18   ;06E61 
                MOV     BYTE PTR [DI-07],CL     ;06E65 
                MOV     WORD PTR [BX+02],AX     ;06E68 
                MOV     WORD PTR [BX],7C3EH     ;06E6B 
                STI                             ;06E6F Turn ON Interrupts
                INT     13H                     ;06E70 DSK:00-reset, DL=dri-
                                                ;     ve
                JB      b06eed                  ;06E72 Jump if < (no="" sign)="" xor="" ax,ax="" ;06e74="" load="" register="" w/="" ;="" 0="" cmp="" word="" ptr="" ds:d0dc13,ax="" ;06e76="" je="" b06e84="" ;06e7a="" jump="" if="" equal="" (zf="1)" mov="" cx,word="" ptr="" ds:d0dc13="" ;06e7c="" mov="" word="" ptr="" ds:d0dc20,cx="" ;06e80="" b06e84:="" mov="" al,byte="" ptr="" ds:d0dc10="" ;06e84="" mul="" word="" ptr="" ds:d0dc16="" ;06e87="" add="" ax,word="" ptr="" ds:d0dc1c="" ;06e8b="" adc="" dx,word="" ptr="" ds:d0dc1e="" ;06e8f="" add="" ax,word="" ptr="" ds:d0dc0e="" ;06e93="" adc="" dx,00="" ;06e97="" mov="" word="" ptr="" ds:d0dc50,ax="" ;06e9a="" mov="" word="" ptr="" ds:d0dc52,dx="" ;06e9d="" mov="" word="" ptr="" ds:d0dc49,ax="" ;06ea1="" mov="" word="" ptr="" ds:d0dc4b,dx="" ;06ea4="" mov="" ax,0020h="" ;06ea8="" mul="" word="" ptr="" ds:d0dc11="" ;06eab="" mov="" bx,word="" ptr="" ds:d0dc0b="" ;06eaf="" add="" ax,bx="" ;06eb3="" dec="" ax="" ;06eb5="" div="" bx="" ;06eb6="" add="" word="" ptr="" ds:d0dc49,ax="" ;06eb8="" adc="" word="" ptr="" ds:d0dc4b,00="" ;06ebc="" mov="" bx,0500h="" ;06ec1="" mov="" dx,word="" ptr="" ds:d0dc52="" ;06ec4="" mov="" ax,word="" ptr="" ds:d0dc50="" ;06ec8="" call="" near="" ptr="" s6="" ;06ecb="">>xref=<06f60>< jb="" b06eed="" ;06ece="" jump="" if="">< (no="" sign)="" mov="" al,01="" ;06ed0="" call="" near="" ptr="" s7="" ;06ed2="">>xref=<06f81>< jb="" b06eed="" ;06ed5="" jump="" if="">< (no="" sign)="" mov="" di,bx="" ;06ed7="" mov="" cx,000bh="" ;06ed9="" mov="" si,7de6h="" ;06edc="" repz="" cmpsb="" ;06edf="" flgs="DS:[SI]-ES:[DI]" jne="" b06eed="" ;06ee1="" jump="" not="" equal(zf="0)" lea="" di,word="" ptr="" [bx+20h]="" ;06ee3="" load="" memory="" offset="" mov="" cx,000bh="" ;06ee6="" repz="" cmpsb="" ;06ee9="" flgs="DS:[SI]-ES:[DI]" je="" b06f05="" ;06eeb="" jump="" if="" equal="" (zf="1)" b06eed:="" mov="" si,7d9eh="" ;06eed="" call="" near="" ptr="" crt0e="" ;06ef0="">>xref=<06f52>< ;="" ;wr="" teletype="" mode,al="c-" ;="" har="" xor="" ax,ax="" ;06ef3="" load="" register="" w/="" ;="" 0="" int="" 16h="" ;06ef5="" kbd:00-read="" char,="" ;="" al="char" pop="" si="" ;06ef7="" pop="" ds="" ;06ef8="" pop="" word="" ptr="" [si]="" ;06ef9="" pop="" word="" ptr="" [si+02]="" ;06efb="" int="" 19h="" ;06efe="" bootstrap="" bios="" pop="" ax="" ;06f00="" pop="" ax="" ;06f01="" pop="" ax="" ;06f02="" jmp="" short="" b06eed="" ;06f03="" ;-----------------------------------------------------="" b06f05:="" db="" 8bh,47,1a,48,48,8a="" ;06f05="" .g.hh.="" db="" 1e,0dh,7c,32,0ff,0f7="" ;06f0b="" ..|2..="" db="" 0e3,03,06,49,7c,13="" ;06f11="" ...i|.="" db="" 16,4bh,7c,0bbh,00,07="" ;06f17="" .k|...="" db="" 0b9,03,00,50,52,51="" ;06f1d="" ...prq="" db="" 0e8,3a,00,72,0d8,0b0="" ;06f23="" .:.r..="" db="" 01,0e8,54,00,59,5a="" ;06f29="" ..t.yz="" db="" 58,72,0bbh,05,01,00="" ;06f2f="" xr....="" db="" 83,0d2,00,03,1e,0bh="" ;06f35="" ......="" db="" 7c,0e2,0e2,8a,2e,15="" ;06f3b="" |.....="" db="" 7c,8a,16,24,7c,8bh="" ;06f41="" |..$|.="" db="" 1e,49,7c,0a1,4bh,7c="" ;06f47="" .i|.k|="" db="" 0ea,00="" ;06f4d="" ..="" ;-----------------------------------------------------="" add="" byte="" ptr="" [bx+si+00],dh="" ;06f4f="" s4="" endp=""><06f52> wr Teletype mode,AL=char
CRT0e           PROC NEAR
                LODSB                           ;06F52 Load AL with DS:[SI]
                OR      AL,AL                   ;06F53 Set Flags
                JE      b06f80                  ;06F55 Jump if equal (ZF=1)
                MOV     AH,0EH                  ;06F57 
                MOV     BX,0007H                ;06F59 
                INT     10H                     ;06F5C CRT:0e-wr Teletype 
                                                ;     mode,AL=char
                JMP     SHORT CRT0e             ;06F5E >>xref=<06f52>< ;="" ;wr="" teletype="" mode,al="c-" ;="" har="" crt0e="" endp=""><06f60>
s6              PROC NEAR
                CMP     DX,WORD PTR DS:d0dc18   ;06F60 
                JNB     b06f7f                  ;06F64 Jump if >= (no sign)
                DIV     WORD PTR DS:d0dc18      ;06F66 
                INC     DL                      ;06F6A 
                MOV     BYTE PTR DS:d0dc4f,DL   ;06F6C 
                XOR     DX,DX                   ;06F70 Load register w/ 
                                                ;     0
                DIV     WORD PTR DS:d0dc1a      ;06F72 
                MOV     BYTE PTR DS:d0dc25,DL   ;06F76 
                MOV     WORD PTR DS:d0dc4d,AX   ;06F7A 
                CLC                             ;06F7D 
;<ss =="" 0600="">
                RETN                            ;06F7E 
b06f7f:         STC                             ;06F7F 
b06f80:         RETN                            ;06F80 
s6              ENDP
 
;<06f81>
s7              PROC NEAR
                MOV     AH,02                   ;06F81 
                MOV     DX,WORD PTR DS:d0dc4d   ;06F83 
                MOV     CL,06                   ;06F87 
                SHL     DH,CL                   ;06F89 Multiply by 2's
                OR      DH,BYTE PTR DS:d0dc4f   ;06F8B 
                MOV     CX,DX                   ;06F8F 
                XCHG    CH,CL                   ;06F91 
                MOV     DL,BYTE PTR DS:d0dc24   ;06F93 
                MOV     DH,BYTE PTR DS:d0dc25   ;06F97 
                INT     13H                     ;06F9B DSK:02-read sector, 
                                                ;     into ES:BX
                RETN                            ;06F9D 
;-----------------------------------------------------
                DB      0DH,0A                  ;06F9E ..
                DB      'Non-System disk or di' ;06FA0 
                DB      'sk error'              ;06FB5 
                DB      0DH,0A                  ;06FBD ..
                DB      'Replace and press any' ;06FBF 
                DB      ' key when ready'       ;06FD4 
                DB      0DH,0A,00               ;06FE3 ...
                DB      'IO      SYSMSDOS   SY' ;06FE6 
                DB      'S'                     ;06FFB 
                DB      00,00                   ;06FFC ..
                DB      55,0AA                  ;06FFE U.
                DB      512D DUP (00H)          ;07000 (.)
s7              ENDP
 
sseg            ENDS
 
M07c00          EQU     07C00H 
d07e85          EQU     07E85H 
d0a96e          EQU     0496EH 
d0dc0b          EQU     07C0BH 
d0dc0e          EQU     07C0EH 
d0dc10          EQU     07C10H 
d0dc11          EQU     07C11H 
d0dc13          EQU     07C13H 
d0dc16          EQU     07C16H 
d0dc18          EQU     07C18H 
d0dc1a          EQU     07C1AH 
d0dc1c          EQU     07C1CH 
d0dc1e          EQU     07C1EH 
d0dc20          EQU     07C20H 
d0dc24          EQU     07C24H 
d0dc25          EQU     07C25H 
d0dc49          EQU     07C49H 
d0dc4b          EQU     07C4BH 
d0dc4d          EQU     07C4DH 
d0dc4f          EQU     07C4FH 
d0dc50          EQU     07C50H 
d0dc52          EQU     07C52H 
d0de87          EQU     07E87H 
d0de89          EQU     07E89H 
d0de8b          EQU     07E8BH 
d15a6c          EQU     0FA6CH 
db8000          EQU     00000H 
db804e          EQU     0004EH 
db8780          EQU     00780H 
db87ce          EQU     007CEH 
                END     o06000
 

</06f81></ss></06f60></06f52></06f52></06f52></06f81></06f60></ss></ds></ss></es></ds></es></ss></067b0></067b7></067b0></067b0></067b0></067b0></067b0></067b0></067b0></067b7></067b0></067b0></ds></es></ds></es></b8000></064c7></es></ds></b8000></ds></ds></ds></es></ds></b8000></0640d></064c7></0640d></es></00021></es></00000></0043f></es></00400></es></00417></es></00400></es></00000></es></00417></es></00400></es></es></00000></ds></es></es></ds></00000></es></00000></ds></ss></cs></es></0043f></00417>