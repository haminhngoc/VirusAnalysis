

;FUNKYBOM sound effect for VCL.  This sound is real close
;to one of the sounds (the FUNKY BOMB, I think) 
;in Wendell Hicken's SCORCH 1.1 artillery/tank
;game. (free plug: I love it - get a copy for yourself, you won't regret it.)
;And, for the moment, it completes this pack of sound fx handily made so
;you can jack them right into your favorite kustom VCL virus and assemble
;with TASM. [Notice, too, that FUNKYBOM uses almost exactly the same
;routines as ARCADEZ.]

code_seg        segment
        assume  cs:code_seg
        
        org     100h
        
        jmp     start

tone1    dw     0

start   proc    near
        
        call    arcade_a             ;call arcade_a, dummeh!
        call    arcade_b             ;call arcade_b
        jmp     start                ;do it again

start   endp
;-------------------------------------------
arcade_a        proc    near
        cli                          ;no interrupts
        mov     si,2                 ;do whole thing twice
agin1:  mov     bp,20                ;we want 20 cycles of sound
        mov     al,10110110b         ;must address channel 2
        out     43h,al               ;mode 3 - send it
        mov     bx,100               ;start frequency very high
agin2:  mov     ax,bx                ;place in (ax)
        out     42h,al               ;send LSB
        mov     al,ah                ;move MSB into (al)
        out     42h,al               ;send it to port
        in      al,61h               ;get value from speaker port
        or      al,00000011b         ;ORing turns speaker on
        out     61h,al               ;send it
        mov     cx,30000             ;our delay count 
looperq:loop    looperq              ;do nothing loop so we can hear sound
        add     bx,50                ;lower frequency a bit for next pass
        in      al,61h               ;get value from port
        and     al,11111100b         ;turns speaker off 
        out     61h,al               ;send it
        dec     bp                   ;decrement cycle count
        jnz     agin2                ;if not = 0 do again
        dec     si                   ;else decrement repeat count
        jnz     agin1                ;if not = 0 do whole thing again
                                     ;and leave
        ret
arcade_a        endp
;-------------------------------------
arcade_b        proc    near
        
        mov     di,4                 ;do sequence four times
agin3:  mov     bp,20                ;do twenty cycles of sound
        mov     al,10110110b         ;our magic number
        out     43h,al               ;send it to timer port
        mov     bx,1000              ;start frequency at 1000
agin4:  mov     ax,bx                ;put it in (ax)
        out     42h,al               ;send LSB
        mov     al,ah                ;put MSB in (al)
        out     42h,al               ;send it
        in      al,61h               ;get value from port
        or      al,00000011b         ;ORing turns speaker on
        out     61h,al               ;send it
        mov     cx,15000             ;our delay count
looperx:loop    looperx              ;do nothing loop so we can hear sound
        sub     bx,50                ;subtract 50 from frequency number
        in      al,61h               ;get port value
        and     al,11111100b         ;turns speaker on
        out     61h,al               ;send it
        dec     bp                   ;decrement cycle count
        jnz     agin4                ;if not = 0 do again
        dec     di                   ;else decrement repeat count
        jnz     agin3                ;if not = 0 do again
        ret                          ;and leave
arcade_b        endp
;----------------------------------
code_seg        ends
     end        start

