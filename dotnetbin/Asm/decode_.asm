

;Disk Decoder program for Virus Book Zoo Disk

MAIN    SEGMENT BYTE
        ASSUME  CS:MAIN,DS:MAIN,SS:NOTHING

        ORG     100H

START:
        mov     ah,9                    ;display the start message
        mov     dx,OFFSET START_MSG
        int     21H
Q1:     mov     ah,1
        int     21H                     ;get a character
        and     al,0DFH                 ;make it upper case
        cmp     al,'N'
        jz      FINISH                  ;answered No, so just terminate
        cmp     al,'Y'
        jz      Q2                      ;answered Yes, so continue
        mov     dl,7                    ;else beep, backspace and try again
        mov     ah,2
        int     21H
        mov     dl,8
        mov     ah,2
        int     21H
        mov     dl,' '
        mov     ah,2
        int     21H
        mov     dl,8
        mov     ah,2
        int     21H
        jmp     Q1
Q2:

FINISH: mov     ah,4CH
        mov     al,0
        int     21H                     ;terminate normally with DOS

START_MSG:
        DB      13,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
        DB      10,10,10,10,10
        DB      'WARNING - This diskette contains computer viruses of many different',13,10
        DB      'kinds. Improper or unskilled use could constitute a serious threat to',13,10
        DB      'data and programs on your computer system and on other computer systems as',13,10
        DB      'well. You could be held criminally liable for viral infections which you',13,10
        DB      'initiate, either maliciously or through your own negligence.',13,10,10
        DB      'This program is designed to safeguard you by encoding the data on this diskette',13,10
        DB      'so that it cannot be used unless this program is executed to decode it. In',13,10
        DB      'executing this program you must agree to the following statements:',13,10,10
        DB      '    1. I agree to take full responsibility for the use of programs on this',13,10
        DB      '       diskette. I will in no way hold companies or',13,10
        DB      '       authors responsible for any data destruction or infection caused',13,10
        DB      '       by any program on this diskette.',13,10,10
        DB      '    2. I understand that the programs on this diskette are dangerous and',13,10
        DB      '       infectious, and I agree to take adequate precautions to prevent the',13,10
        DB      '       spread of infections to computers which are not under my authority.',13,10,10
        DB      '    3. I understand that use of the programs contained on this disk may be',13,10
        DB      '       illegal in certain circumstances, and I take full responsibility for',13,10
        DB      '       making sure that any use I put them to is within the bounds of the law.',13,10,10
        DB      'I agree to the above statements (Y/N) : $'


MAIN    ENDS


        END START

