

;ARCADEZ effect for VCL. 
;Maddening, if it goes on forever or shows up at inappropriate time.

code_seg        segment
        assume  cs:code_seg
        
        org     100h
        
        jmp     start

start   proc    near
        
        call    arcade_a             ;call arcade_a, dummeh!
        call    arcade_b             ;call arcade_b
        jmp     start                ;do it again

start   endp
;-------------------------------------------
arcade_a        proc    near
        cli                          ;off the interrupts 
        mov     di,2                 ;repeat whole thing twice
agin1:  mov     bp,20                ;20 cycles of sound
        mov     al,10110110b         ;magic number
        out     43h,al               ;send it to timer
        mov     bx,1000              ;start frequency high
agin2:  mov     ax,bx                ;place it in (ax)
        out     42h,al               ;send LSB 
        mov     al,ah                ;place MSB in al
        out     42h,al               ;now we send it
        in      al,61h               ;get value from port
        or      al,00000011b         ;ORing turns on speaker
        out     61h,al               ;send it to port
        mov     cx,35000             ;our delay count
looperx:loop    looperx              ;do nothing loop so we can hear sound
        add     bx,50                ;to lower frequency for next pass
        in      al,61h               ;get value from speaker port
        and     al,11111100b         ;turns speaker off
        out     61h,al               ;send it
        dec     bp                   ;decrement cycle count
        jnz     agin2                ;if not = 0 do again
        mov     cx,60000             ;else load (cx) for 2nd delay
looperf:loop    looperf              ;do nothing loop
        dec     di                   ;decrement repeat count
        jnz     agin1                ;do hole thing again if not = 0
                                     ;and leave
        ret
arcade_a        endp
;-------------------------------------
arcade_b        proc    near
         
        mov     di,2                 ;repeat whole thing twice
agin3:  mov     bp,20                ;20 cycles of sound
        mov     al,10110110b         ;magic number
        out     43h,al               ;send it to timer
        mov     bx,2000              ;start frequency low
agin4:  mov     ax,bx                ;place it in (ax)
        out     42h,al               ;send LSB 
        mov     al,ah                ;place MSB in al
        out     42h,al               ;now we send it
        in      al,61h               ;get value from port
        or      al,00000011b         ;ORing turns on speaker
        out     61h,al               ;send it to port
        mov     cx,35000             ;our delay count
looperl:loop    looperl              ;do nothing loop so we can hear sound
        sub     bx,50                ;to rise frequency for next pass
        in      al,61h               ;get value from speaker port
        and     al,11111100b         ;turn speaker off
        out     61h,al               ;send it
        dec     bp                   ;decrement cycle count
        jnz     agin4                ;if not = 0 do again
        mov     cx,60000             ;else load (cx) for 2nd delay
looperk:loop    looperk              ;do nothing loop
        dec     di                   ;decrement repeat count
        jnz     agin3                ;do hole thing again if not = 0
                                     ;and leave
        ret
arcade_b        endp
;-------------------------------------
code_seg        ends
     end        start

