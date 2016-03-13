

-l 7C00 1 0 1
-u 7c00 7dff
14F7:7C00 EB34          JMP	7C36                               
14F7:7C02 90            NOP	                                   
14F7:7C03 49            DEC	CX                                 
14F7:7C04 42            INC	DX                                 
14F7:7C05 4D            DEC	BP                                 
14F7:7C06 2020          AND	[BX+SI],AH                         
14F7:7C08 332E3300      XOR	BP,[0033]                          
14F7:7C0C 0202          ADD	AL,[BP+SI]                         
14F7:7C0E 0100          ADD	[BX+SI],AX                         
14F7:7C10 027000        ADD	DH,[BX+SI+00]                      
14F7:7C13 D002          ROL	BYTE PTR [BP+SI],1                 
14F7:7C15 FD            STD	                                   
14F7:7C16 0200          ADD	AL,[BX+SI]                         
14F7:7C18 0900          OR	[BX+SI],AX                         
14F7:7C1A 0200          ADD	AL,[BX+SI]                         
14F7:7C1C 0000          ADD	[BX+SI],AL                         
14F7:7C1E 0000          ADD	[BX+SI],AL                         
14F7:7C20 0000          ADD	[BX+SI],AL                         
14F7:7C22 0000          ADD	[BX+SI],AL                         
14F7:7C24 0000          ADD	[BX+SI],AL                         
14F7:7C26 0000          ADD	[BX+SI],AL                         
14F7:7C28 0000          ADD	[BX+SI],AL                         
14F7:7C2A 0000          ADD	[BX+SI],AL                         
14F7:7C2C 0000          ADD	[BX+SI],AL                         
14F7:7C2E 0012          ADD	[BP+SI],DL                         
14F7:7C30 0000          ADD	[BX+SI],AL                         
14F7:7C32 0000          ADD	[BX+SI],AL                         
14F7:7C34 0100          ADD	[BX+SI],AX                         
14F7:7C36 FA            CLI	                                   
14F7:7C37 33C0          XOR	AX,AX                              
14F7:7C39 8ED0          MOV	SS,AX                              
14F7:7C3B BC007C        MOV	SP,7C00                            
14F7:7C3E 16            PUSH	SS                                 
14F7:7C3F 07            POP	ES                                 
14F7:7C40 BB7800        MOV	BX,0078                            
14F7:7C43 36            SS:	                                   
14F7:7C44 C537          LDS	SI,[BX]                            
14F7:7C46 1E            PUSH	DS                                 
14F7:7C47 56            PUSH	SI                                 
14F7:7C48 16            PUSH	SS                                 
14F7:7C49 53            PUSH	BX                                 
14F7:7C4A BF2B7C        MOV	DI,7C2B                            
14F7:7C4D B90B00        MOV	CX,000B                            
14F7:7C50 FC            CLD	                                   
14F7:7C51 AC            LODSB	                                   
14F7:7C52 26            ES:	                                   
14F7:7C53 803D00        CMP	BYTE PTR [DI],00                   
14F7:7C56 7403          JZ	7C5B                               
14F7:7C58 26            ES:	                                   
14F7:7C59 8A05          MOV	AL,[DI]                            
14F7:7C5B AA            STOSB	                                   
14F7:7C5C 8AC4          MOV	AL,AH                              
14F7:7C5E E2F1          LOOP	7C51                               
14F7:7C60 06            PUSH	ES                                 
14F7:7C61 1F            POP	DS                                 
14F7:7C62 894702        MOV	[BX+02],AX                         
14F7:7C65 C7072B7C      MOV	WORD PTR [BX],7C2B                 
14F7:7C69 FB            STI	                                   
14F7:7C6A CD13          INT	13                                 
14F7:7C6C 7267          JB	7CD5                               
14F7:7C6E A0107C        MOV	AL,[7C10]                          
14F7:7C71 98            CBW	                                   
14F7:7C72 F726167C      MUL	WORD PTR [7C16]                    
14F7:7C76 03061C7C      ADD	AX,[7C1C]                          
14F7:7C7A 03060E7C      ADD	AX,[7C0E]                          
14F7:7C7E A33F7C        MOV	[7C3F],AX                          
14F7:7C81 A3377C        MOV	[7C37],AX                          
14F7:7C84 B82000        MOV	AX,0020                            
14F7:7C87 F726117C      MUL	WORD PTR [7C11]                    
14F7:7C8B 8B1E0B7C      MOV	BX,[7C0B]                          
14F7:7C8F 03C3          ADD	AX,BX                              
14F7:7C91 48            DEC	AX                                 
14F7:7C92 F7F3          DIV	BX                                 
14F7:7C94 0106377C      ADD	[7C37],AX                          
14F7:7C98 BB0005        MOV	BX,0500                            
14F7:7C9B A13F7C        MOV	AX,[7C3F]                          
14F7:7C9E E89F00        CALL	7D40                               
14F7:7CA1 B80102        MOV	AX,0201                            
14F7:7CA4 E8B300        CALL	7D5A                               
14F7:7CA7 7219          JB	7CC2                               
14F7:7CA9 8BFB          MOV	DI,BX                              
14F7:7CAB B90B00        MOV	CX,000B                            
14F7:7CAE BED67D        MOV	SI,7DD6                            
14F7:7CB1 F3            REPZ	                                   
14F7:7CB2 A6            CMPSB	                                   
14F7:7CB3 750D          JNZ	7CC2                               
14F7:7CB5 8D7F20        LEA	DI,[BX+20]                         
14F7:7CB8 BEE17D        MOV	SI,7DE1                            
14F7:7CBB B90B00        MOV	CX,000B                            
14F7:7CBE F3            REPZ	                                   
14F7:7CBF A6            CMPSB	                                   
14F7:7CC0 7418          JZ	7CDA                               
14F7:7CC2 BE777D        MOV	SI,7D77                            
14F7:7CC5 E86A00        CALL	7D32                               
14F7:7CC8 32E4          XOR	AH,AH                              
14F7:7CCA CD16          INT	16                                 
14F7:7CCC 5E            POP	SI                                 
14F7:7CCD 1F            POP	DS                                 
14F7:7CCE 8F04          POP	[SI]                               
14F7:7CD0 8F4402        POP	[SI+02]                            
14F7:7CD3 CD19          INT	19                                 
14F7:7CD5 BEC07D        MOV	SI,7DC0                            
14F7:7CD8 EBEB          JMP	7CC5                               
14F7:7CDA A11C05        MOV	AX,[051C]                          
14F7:7CDD 33D2          XOR	DX,DX                              
14F7:7CDF F7360B7C      DIV	WORD PTR [7C0B]                    
14F7:7CE3 FEC0          INC	AL                                 
14F7:7CE5 A23C7C        MOV	[7C3C],AL                          
14F7:7CE8 A1377C        MOV	AX,[7C37]                          
14F7:7CEB A33D7C        MOV	[7C3D],AX                          
14F7:7CEE BB0007        MOV	BX,0700                            
14F7:7CF1 A1377C        MOV	AX,[7C37]                          
14F7:7CF4 E84900        CALL	7D40                               
14F7:7CF7 A1187C        MOV	AX,[7C18]                          
14F7:7CFA 2A063B7C      SUB	AL,[7C3B]                          
14F7:7CFE 40            INC	AX                                 
14F7:7CFF 38063C7C      CMP	[7C3C],AL                          
14F7:7D03 7303          JNB	7D08                               
14F7:7D05 A03C7C        MOV	AL,[7C3C]                          
14F7:7D08 50            PUSH	AX                                 
14F7:7D09 E84E00        CALL	7D5A                               
14F7:7D0C 58            POP	AX                                 
14F7:7D0D 72C6          JB	7CD5                               
14F7:7D0F 28063C7C      SUB	[7C3C],AL                          
14F7:7D13 740C          JZ	7D21                               
14F7:7D15 0106377C      ADD	[7C37],AX                          
14F7:7D19 F7260B7C      MUL	WORD PTR [7C0B]                    
14F7:7D1D 03D8          ADD	BX,AX                              
14F7:7D1F EBD0          JMP	7CF1                               
14F7:7D21 8A2E157C      MOV	CH,[7C15]                          
14F7:7D25 8A16FD7D      MOV	DL,[7DFD]                          
14F7:7D29 8B1E3D7C      MOV	BX,[7C3D]                          
14F7:7D2D EA00007000    JMP	0070:0000                          
14F7:7D32 AC            LODSB	                                   
14F7:7D33 0AC0          OR	AL,AL                              
14F7:7D35 7422          JZ	7D59                               
14F7:7D37 B40E          MOV	AH,0E                              
14F7:7D39 BB0700        MOV	BX,0007                            
14F7:7D3C CD10          INT	10                                 
14F7:7D3E EBF2          JMP	7D32                               
14F7:7D40 33D2          XOR	DX,DX                              
14F7:7D42 F736187C      DIV	WORD PTR [7C18]                    
14F7:7D46 FEC2          INC	DL                                 
14F7:7D48 88163B7C      MOV	[7C3B],DL                          
14F7:7D4C 33D2          XOR	DX,DX                              
14F7:7D4E F7361A7C      DIV	WORD PTR [7C1A]                    
14F7:7D52 88162A7C      MOV	[7C2A],DL                          
14F7:7D56 A3397C        MOV	[7C39],AX                          
14F7:7D59 C3            RET	                                   
14F7:7D5A B402          MOV	AH,02                              
14F7:7D5C 8B16397C      MOV	DX,[7C39]                          
14F7:7D60 B106          MOV	CL,06                              
14F7:7D62 D2E6          SHL	DH,CL                              
14F7:7D64 0A363B7C      OR	DH,[7C3B]                          
14F7:7D68 8BCA          MOV	CX,DX                              
14F7:7D6A 86E9          XCHG	CH,CL                              
14F7:7D6C 8A16FD7D      MOV	DL,[7DFD]                          
14F7:7D70 8A362A7C      MOV	DH,[7C2A]                          
14F7:7D74 CD13          INT	13                                 
14F7:7D76 C3            RET	                                   
14F7:7D77 0D0A4E        OR	AX,4E0A                            
14F7:7D7A 6F            DB	6F                                 
14F7:7D7B 6E            DB	6E                                 
14F7:7D7C 2D5379        SUB	AX,7953                            
14F7:7D7F 7374          JNB	7DF5                               
14F7:7D81 65            DB	65                                 
14F7:7D82 6D            DB	6D                                 
14F7:7D83 206469        AND	[SI+69],AH                         
14F7:7D86 736B          JNB	7DF3                               
14F7:7D88 206F72        AND	[BX+72],CH                         
14F7:7D8B 206469        AND	[SI+69],AH                         
14F7:7D8E 736B          JNB	7DFB                               
14F7:7D90 206572        AND	[DI+72],AH                         
14F7:7D93 726F          JB	7E04                               
14F7:7D95 720D          JB	7DA4                               
14F7:7D97 0A5265        OR	DL,[BP+SI+65]                      
14F7:7D9A 706C          JO	7E08                               
14F7:7D9C 61            DB	61                                 
14F7:7D9D 63            DB	63                                 
14F7:7D9E 65            DB	65                                 
14F7:7D9F 20616E        AND	[BX+DI+6E],AH                      
14F7:7DA2 64            DB	64                                 
14F7:7DA3 207374        AND	[BP+DI+74],DH                      
14F7:7DA6 7269          JB	7E11                               
14F7:7DA8 6B            DB	6B                                 
14F7:7DA9 65            DB	65                                 
14F7:7DAA 20616E        AND	[BX+DI+6E],AH                      
14F7:7DAD 7920          JNS	7DCF                               
14F7:7DAF 6B            DB	6B                                 
14F7:7DB0 65            DB	65                                 
14F7:7DB1 7920          JNS	7DD3                               
14F7:7DB3 7768          JA	7E1D                               
14F7:7DB5 65            DB	65                                 
14F7:7DB6 6E            DB	6E                                 
14F7:7DB7 207265        AND	[BP+SI+65],DH                      
14F7:7DBA 61            DB	61                                 
14F7:7DBB 64            DB	64                                 
14F7:7DBC 790D          JNS	7DCB                               
14F7:7DBE 0A00          OR	AL,[BX+SI]                         
14F7:7DC0 0D0A44        OR	AX,440A                            
14F7:7DC3 69            DB	69                                 
14F7:7DC4 736B          JNB	7E31                               
14F7:7DC6 20426F        AND	[BP+SI+6F],AL                      
14F7:7DC9 6F            DB	6F                                 
14F7:7DCA 7420          JZ	7DEC                               
14F7:7DCC 66            DB	66                                 
14F7:7DCD 61            DB	61                                 
14F7:7DCE 69            DB	69                                 
14F7:7DCF 6C            DB	6C                                 
14F7:7DD0 7572          JNZ	7E44                               
14F7:7DD2 65            DB	65                                 
14F7:7DD3 0D0A00        OR	AX,000A                            
14F7:7DD6 49            DEC	CX                                 
14F7:7DD7 42            INC	DX                                 
14F7:7DD8 4D            DEC	BP                                 
14F7:7DD9 42            INC	DX                                 
14F7:7DDA 49            DEC	CX                                 
14F7:7DDB 4F            DEC	DI                                 
14F7:7DDC 2020          AND	[BX+SI],AH                         
14F7:7DDE 43            INC	BX                                 
14F7:7DDF 4F            DEC	DI                                 
14F7:7DE0 4D            DEC	BP                                 
14F7:7DE1 49            DEC	CX                                 
14F7:7DE2 42            INC	DX                                 
14F7:7DE3 4D            DEC	BP                                 
14F7:7DE4 44            INC	SP                                 
14F7:7DE5 4F            DEC	DI                                 
14F7:7DE6 53            PUSH	BX                                 
14F7:7DE7 2020          AND	[BX+SI],AH                         
14F7:7DE9 43            INC	BX                                 
14F7:7DEA 4F            DEC	DI                                 
14F7:7DEB 4D            DEC	BP                                 
14F7:7DEC 0000          ADD	[BX+SI],AL                         
14F7:7DEE 0000          ADD	[BX+SI],AL                         
14F7:7DF0 0000          ADD	[BX+SI],AL                         
14F7:7DF2 0000          ADD	[BX+SI],AL                         
14F7:7DF4 0000          ADD	[BX+SI],AL                         
14F7:7DF6 0000          ADD	[BX+SI],AL                         
14F7:7DF8 0000          ADD	[BX+SI],AL                         
14F7:7DFA 0000          ADD	[BX+SI],AL                         
14F7:7DFC 0000          ADD	[BX+SI],AL                         
14F7:7DFE 55            PUSH	BP                                 
14F7:7DFF AA            STOSB	                                   
-d 7c00 7dff
14F7:7C00  EB 34 90 49 42 4D 20 20-33 2E 33 00 02 02 01 00   .4.IBM  3.3.....
14F7:7C10  02 70 00 D0 02 FD 02 00-09 00 02 00 00 00 00 00   .p..............
14F7:7C20  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 12   ................
14F7:7C30  00 00 00 00 01 00 FA 33-C0 8E D0 BC 00 7C 16 07   .......3.....|..
14F7:7C40  BB 78 00 36 C5 37 1E 56-16 53 BF 2B 7C B9 0B 00   .x.6.7.V.S.+|...
14F7:7C50  FC AC 26 80 3D 00 74 03-26 8A 05 AA 8A C4 E2 F1   ..&.=.t.&.......
14F7:7C60  06 1F 89 47 02 C7 07 2B-7C FB CD 13 72 67 A0 10   ...G...+|...rg..
14F7:7C70  7C 98 F7 26 16 7C 03 06-1C 7C 03 06 0E 7C A3 3F   |..&.|...|...|.?
14F7:7C80  7C A3 37 7C B8 20 00 F7-26 11 7C 8B 1E 0B 7C 03   |.7|. ..&.|...|.
14F7:7C90  C3 48 F7 F3 01 06 37 7C-BB 00 05 A1 3F 7C E8 9F   .H....7|....?|..
14F7:7CA0  00 B8 01 02 E8 B3 00 72-19 8B FB B9 0B 00 BE D6   .......r........
14F7:7CB0  7D F3 A6 75 0D 8D 7F 20-BE E1 7D B9 0B 00 F3 A6   }..u... ..}.....
14F7:7CC0  74 18 BE 77 7D E8 6A 00-32 E4 CD 16 5E 1F 8F 04   t..w}.j.2...^...
14F7:7CD0  8F 44 02 CD 19 BE C0 7D-EB EB A1 1C 05 33 D2 F7   .D.....}.....3..
14F7:7CE0  36 0B 7C FE C0 A2 3C 7C-A1 37 7C A3 3D 7C BB 00   6.|...<|.7|.=|.. 14f7:7cf0="" 07="" a1="" 37="" 7c="" e8="" 49="" 00="" a1-18="" 7c="" 2a="" 06="" 3b="" 7c="" 40="" 38="" ..7|.i...|*.;|@8="" 14f7:7d00="" 06="" 3c="" 7c="" 73="" 03="" a0="" 3c="" 7c-50="" e8="" 4e="" 00="" 58="" 72="" c6="" 28=""></|.7|.=|..><><|p.n.xr.( 14f7:7d10="" 06="" 3c="" 7c="" 74="" 0c="" 01="" 06="" 37-7c="" f7="" 26="" 0b="" 7c="" 03="" d8="" eb=""></|p.n.xr.(><|t...7|.&.|... 14f7:7d20="" d0="" 8a="" 2e="" 15="" 7c="" 8a="" 16="" fd-7d="" 8b="" 1e="" 3d="" 7c="" ea="" 00="" 00="" ....|...}..="|..." 14f7:7d30="" 70="" 00="" ac="" 0a="" c0="" 74="" 22="" b4-0e="" bb="" 07="" 00="" cd="" 10="" eb="" f2="" p....t".........="" 14f7:7d40="" 33="" d2="" f7="" 36="" 18="" 7c="" fe="" c2-88="" 16="" 3b="" 7c="" 33="" d2="" f7="" 36="" 3..6.|....;|3..6="" 14f7:7d50="" 1a="" 7c="" 88="" 16="" 2a="" 7c="" a3="" 39-7c="" c3="" b4="" 02="" 8b="" 16="" 39="" 7c="" .|..*|.9|.....9|="" 14f7:7d60="" b1="" 06="" d2="" e6="" 0a="" 36="" 3b="" 7c-8b="" ca="" 86="" e9="" 8a="" 16="" fd="" 7d="" .....6;|.......}="" 14f7:7d70="" 8a="" 36="" 2a="" 7c="" cd="" 13="" c3="" 0d-0a="" 4e="" 6f="" 6e="" 2d="" 53="" 79="" 73="" .6*|.....non-sys="" 14f7:7d80="" 74="" 65="" 6d="" 20="" 64="" 69="" 73="" 6b-20="" 6f="" 72="" 20="" 64="" 69="" 73="" 6b="" tem="" disk="" or="" disk="" 14f7:7d90="" 20="" 65="" 72="" 72="" 6f="" 72="" 0d="" 0a-52="" 65="" 70="" 6c="" 61="" 63="" 65="" 20="" error..replace="" 14f7:7da0="" 61="" 6e="" 64="" 20="" 73="" 74="" 72="" 69-6b="" 65="" 20="" 61="" 6e="" 79="" 20="" 6b="" and="" strike="" any="" k="" 14f7:7db0="" 65="" 79="" 20="" 77="" 68="" 65="" 6e="" 20-72="" 65="" 61="" 64="" 79="" 0d="" 0a="" 00="" ey="" when="" ready...="" 14f7:7dc0="" 0d="" 0a="" 44="" 69="" 73="" 6b="" 20="" 42-6f="" 6f="" 74="" 20="" 66="" 61="" 69="" 6c="" ..disk="" boot="" fail="" 14f7:7dd0="" 75="" 72="" 65="" 0d="" 0a="" 00="" 49="" 42-4d="" 42="" 49="" 4f="" 20="" 20="" 43="" 4f="" ure...ibmbio="" co="" 14f7:7de0="" 4d="" 49="" 42="" 4d="" 44="" 4f="" 53="" 20-20="" 43="" 4f="" 4d="" 00="" 00="" 00="" 00="" mibmdos="" com....="" 14f7:7df0="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" 00-00="" 00="" 00="" 00="" 00="" 00="" 55="" aa="" ..............u.="" -q=""></|t...7|.&.|...>