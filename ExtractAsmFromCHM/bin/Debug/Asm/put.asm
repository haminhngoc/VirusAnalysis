

;Put the sector at track 0, head 0, sector 1 into sector 10 on a specially
;formatted track. This works on drive B only!


MAIN    SEGMENT BYTE
        ASSUME  CS:MAIN,DS:MAIN,SS:NOTHING

        ORG     100H

DRIVE_A EQU     0
DRIVE_B EQU     1
DRIVE   EQU     DRIVE_B         ;drive to be used for operation

START:
        push    cs
        pop     es
        mov     bx,OFFSET DISK_BUFFER   ;es:bx=buffer to use
        mov     dh,0                    ;dh=head, dl=drive
        mov     dl,DRIVE
        mov     cx,0001H                ;ch=track, cl=sector
        mov     ax,0209H                ;ah=read, al=9 sectors to read
        int     13H                     ;and go read Track 0, Head 0, Sector 1




        mov     dh,0                    ;write sectors 2 through 8 back to disk
        mov     dl,DRIVE
        mov     cx,0002H
        mov     bx,OFFSET DISK_BUFFER + 512
        mov     ax,0308H
        int     13H

        mov     bx,OFFSET DISK_BUFFER
        mov     dh,00H
        mov     dl,drive
        mov     cx,000AH                ;now write that sector to
        mov     ax,0301H                ;Track 0, head 0, Sector 10
        int     13H

FINISH: mov     ah,4CH
        mov     al,0
        int     21H                     ;terminate normally with DOS

DISK_BUFFER:
        DB      512*9 dup (?)

MAIN    ENDS


        END START

