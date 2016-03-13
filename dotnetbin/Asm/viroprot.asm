


; VIROPROT v2.1 - (copyshit) ûirogen '95
; ÄÄÄÄ 02-05-95
; Assemble: TASM /M
;           TLINK /T

cseg   segment
          assume cs:cseg, ds:cseg, es:cseg, ss:cseg

OSP         equ  7dh          ; Offspring
ASEX        equ  7fh          ; Asexual
PINWORM_    equ  0FA01h       ; Pinworm
OSP_REPLY   equ  0FCh         ; Offspring
ASEX_REPLY  equ  0fah         ; Asexual
chk_us  equ  0FAF1h
chk_us_ret equ 0BBACh
cr      equ  0dh
lf      equ  0ah

org     100h
start:

main      proc

         jmp    main2
         db     0                       ; Protects From Pinworm Infection
         db     3 dup(0C3h)

new21     proc

          pushf
          push bp
          cmp   ax,chk_us
          jz    toggle_active
          cmp   cs:active,1
          jnz   end_21
          cmp   ah,OSP
          jz    send_osp
          cmp   ah,ASEX
          jz    send_asex
          cmp   ax,PINWORM_
          jnz   end_21
  send_pinworm:
          lea   bp,pinworm
          call  disp
          xor   si,si
          jmp   end_int0
  send_osp:
          lea   bp,offspring
          call  disp
          mov   ah,OSP_REPLY
          jmp   end_int0
  send_asex:
          lea    bp,asexual
          mov    ah,ASEX_REPLY
  end_int0:
          call   beep
  end_int:
          pop bp
          popf
          iret

  end_21:
        pop bp
        popf
        db 0Eah
 old21_ofs dw 0
 old21_seg dw 0
 active db 1

 beep:
        push ax dx
        mov dl,7
        mov ah,2
        int 21h
        pop dx ax
        ret

 toggle_active:
        push dx ds
        push cs
        pop ds
        cmp active,0
        jz  enable_
        lea dx,disable
        mov active,0
        jmp do_tog
enable_: lea dx,enable
        mov active,1
do_tog: mov ah,9
        int 21h
        pop ds dx
        mov ax,chk_us_ret
        jmp end_int

 disp:
        push ax bx cx dx es
        push cs
        pop es
        mov ah,3
        mov bh,0
        int 10h
        push dx
        mov bl,17h
        xor dx,dx
        mov cx,11
        mov ax,1300h
        int 10h
        pop dx
        mov ah,2
        int 10h
        pop es dx cx bx ax
        ret

new21  endp
pinworm db   ' Pinworm   '
offspring db ' Offspring '
asexual db   ' Asexual   '
simplex db   ' Simplex   '
enable db  ' þ Already Installed. Status: ACTIVE',cr,lf,'$'
disable db ' þ Already Installed. Status: OFF.',cr,lf,'$'
end_prog:
main2:
         mov    ah,09
         lea    dx,msg
         int    21h
         mov    ax,chk_us
         int    21h
         cmp    ax,chk_us_ret
         jnz    not_installed
         ret
not_installed:
         xor    ax,ax
         mov    es,ax
         mov    ax,es:[21h*4+2]
         mov    bx,es:[21h*4]
         mov    ds:old21_seg,ax
         mov    ds:old21_ofs,bx
         cli
         mov    es:[21h*4+2],ds
         lea    ax,new21
         mov    es:[21h*4],ax
         sti
         push   ds
         pop    es

         lea      dx,end_prog+1
         int      27h

main     endp

msg    db  'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ',cr,lf
       db  'VIROPROT v2.1 - (c)1995 ûirogen Enterprises',cr,lf
       db  'Prevention Software For:                                                 ',cr,lf
       db  ' Offspring [0.82/0.89]',cr,lf
       db  ' Asexual   [0.99/1.00]',cr,lf
       db  ' PinWorm   [1.0/1.5/1.6/1.7]',cr,lf
       db  'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ',cr,lf,'$'

cseg ends
        end start

