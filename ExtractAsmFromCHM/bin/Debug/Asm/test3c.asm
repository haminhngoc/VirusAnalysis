﻿

;Stealth Test 3C
;Write drive C boot sector from RAM - 1 sector read

COMSEG  SEGMENT PARA
        ASSUME  CS:COMSEG,DS:COMSEG,ES:COMSEG,SS:COMSEG

        ORG     100H

DO_START:
        mov     bx,OFFSET BOOTBUF
        mov     al,1                            ;1 sector
        mov     ah,3                            ;write
        mov     dx,80H                          ;head 0, drive 80H
        mov     cx,1H                           ;track 0, sector 1
        int     13H

        mov     ax,4C00H                        ;and do a DOS keep
        int     21H

BOOTBUF:
        DB      0FAH,033H,0C0H,08EH,0D0H,0BCH,000H,07CH,08BH,0F4H,050H,007H,050H,01FH,0FBH,0FCH
        DB      0BFH,000H,006H,0B9H,000H,001H,0F2H,0A5H,0EAH,01DH,006H,000H,000H,0BEH,0BEH,007H
        DB      0B3H,004H,080H,03CH,080H,074H,00EH,080H,03CH,000H,075H,01CH,083H,0C6H,010H,0FEH
        DB      0CBH,075H,0EFH,0CDH,018H,08BH,014H,08BH,04CH,002H,08BH,0EEH,083H,0C6H,010H,0FEH
        DB      0CBH,074H,01AH,080H,03CH,000H,074H,0F4H,0BEH,08BH,006H,0ACH,03CH,000H,074H,00BH
        DB      056H,0BBH,007H,000H,0B4H,00EH,0CDH,010H,05EH,0EBH,0F0H,0EBH,0FEH,0BFH,005H,000H
        DB      0BBH,000H,07CH,0B8H,001H,002H,057H,0CDH,013H,05FH,073H,00CH,033H,0C0H,0CDH,013H
        DB      04FH,075H,0EDH,0BEH,0A3H,006H,0EBH,0D3H,0BEH,0C2H,006H,0BFH,0FEH,07DH,081H,03DH
        DB      055H,0AAH,075H,0C7H,08BH,0F5H,0EAH,000H,07CH,000H,000H,049H,06EH,076H,061H,06CH
        DB      069H,064H,020H,070H,061H,072H,074H,069H,074H,069H,06FH,06EH,020H,074H,061H,062H
        DB      06CH,065H,000H,045H,072H,072H,06FH,072H,020H,06CH,06FH,061H,064H,069H,06EH,067H
        DB      020H,06FH,070H,065H,072H,061H,074H,069H,06EH,067H,020H,073H,079H,073H,074H,065H
        DB      06DH,000H,04DH,069H,073H,073H,069H,06EH,067H,020H,06FH,070H,065H,072H,061H,074H
        DB      069H,06EH,067H,020H,073H,079H,073H,074H,065H,06DH,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      040H,040H,040H,040H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,080H,001H
        DB      001H,000H,004H,005H,051H,099H,011H,000H,000H,000H,04BH,0A3H,000H,000H,000H,000H
        DB      041H,09AH,005H,005H,0D1H,032H,05CH,0A3H,000H,000H,0F6H,0A2H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,055H,0AAH

COMSEG  ENDS

        END     DO_START

