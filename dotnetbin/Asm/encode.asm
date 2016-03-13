﻿

;This file will encode the message from message.dat into the picture file
;called message.scr.

;Note: Message.dat MUST be < 8000="" bytes="" for="" the="" entire="" message="" to="" be="" ;preserved.="" .model="" tiny="" .radix="" 16="" .code="" org="" 100="" start:="" loadmessage:="" mov="" ax,3d00="" mov="" dx,offset="" datafile="" int="" 21="" jc="" error="" xchg="" bx,ax="" mov="" dx,offset="" messagedata="" mov="" cx,8000d="" mov="" ah,3f="" int="" 21="" mov="" messagesize,ax="" mov="" ah,3e="" int="" 21="" addeof:="" mov="" bx,messagesize="" mov="" [messagedata+bx],1a="" jmp="" encodemessage="" error:="" mov="" dx,offset="" error1="" mov="" ah,09="" int="" 21="" mov="" ax,4c01="" int="" 21="" encodemessage:="" mov="" si,offset="" messagedata="" mov="" bp,si="" add="" bp,messagesize="" openpict:="" mov="" ax,3d02="" mov="" dx,offset="" pictfile="" int="" 21="" jc="" error="" xchg="" bx,ax="" skipcolormap:="" mov="" ax,4200="" mov="" dx,300="" mov="" cx,0="" int="" 21="" readpict:="" mov="" ax,4201="" xor="" cx,cx="" xor="" dx,dx="" int="" 21="" push="" ax="" dx="" mov="" ah,3f="" mov="" cx,200="" mov="" dx,offset="" pictbuffer="" int="" 21="" jumpbacktoread:="" pop="" cx="" dx="" push="" ax="" mov="" ax,4200="" int="" 21="" call="" convertdata="" pop="" cx="" mov="" ah,40="" mov="" dx,offset="" pictbuffer="" int="" 21="" cmp="" si,bp="" jae="" doneencode="" cmp="" ax,200="" jb="" doneencode="" jmp="" readpict="" doneencode:="" closepict:="" mov="" ah,3e="" int="" 21="" done:="" mov="" ax,4c00="" int="" 21="" convertdata:="" mov="" di,offset="" pictbuffer="" mov="" cx,40="" convertbyte:="" push="" cx="" lodsb="" mov="" cx,8="" convertbit:="" xor="" ah,ah="" shr="" al,1="" rcl="" ah,1="" and="" byte="" ptr="" es:[di],0fe="" or="" byte="" ptr="" es:[di],ah="" inc="" di="" loop="" convertbit="" pop="" cx="" loop="" convertbyte="" ret="" error1="" db="" 'error="" opening="" message="" files!$'="" datafile="" db="" 'message.dat',0="" pictfile="" db="" 'message.scr',0="" messagesize="" dw="" messagedata="" db="" 8000d="" dup(?)="" pictbuffer="" db="" 200="" dup(?)="" end="" start="">