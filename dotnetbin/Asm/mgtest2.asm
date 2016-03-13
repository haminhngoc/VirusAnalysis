

; Mutagen Test Program - version 2.00
; by MnemoniX 1994
;
; This is a sample program which will encrypt itself differently each time
; it is run.

extrn   _mutagen:near

MGEN_SIZE        equ     1938           ; version 2.0

code    segment byte    public  'code'
        org     100h
        assume  cs:code

start:                                  
        call    $+3                     ; calculate current address
        pop     bp                      ; (address changes due to
        sub     bp,(offset $-1)         ;  variable decryption engine size)

        lea     si,[bp + offset runs]   ; keep track of how many
        mov     di,si                   ; times this program is run
        lodsw

        inc     ah
        cmp     ah,3Ah
        jne     run_counter
        inc     al
        mov     ah,30h

run_counter:
        stosw
        lea     si,[bp + offset start]
        lea     di,[bp + PROG_END]      ; calculate end of program
        mov     cx,PROG_SIZE            ; address, and encrypt this
        mov     dx,100h                 ; program
        
        push    bp
        call    _mutagen
        pop     bp

        push    cx
        mov     ah,3Ch                  ; recreate MUT_TEST.COM
        lea     dx,[bp + offset file_name]
        xor     cx,cx
        int     21h

        mov     bx,ax                   ; and write new encrypted code
        mov     ah,40h                  ; to it
        pop     cx
        lea     dx,[bp + PROG_END]
        int     21h

        mov     ah,3Eh                  ; close file
        int     21h

        mov     ah,9                    ; display string
        lea     dx,[bp + offset msg]
        int     21h

        mov     ah,4Ch                  ; and terminate
        int     21h

file_name       db      'MUT_TEST.COM',0
msg             db      'MutaGen Test Program - Runs : '
runs            dw      '00'
                db      '$'
program_end:

PROG_END        equ     offset program_end + MGEN_SIZE
PROG_SIZE       equ     (offset program_end - offset start) + MGEN_SIZE

code    ends
        end     start

