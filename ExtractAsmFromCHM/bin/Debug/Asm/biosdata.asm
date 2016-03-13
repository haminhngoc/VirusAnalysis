

;*******************************************************************************
;* This module contains BIOS data for use in protected mode BIOS functions.    *
;* It is used by those functions just as it would be in DOS                    *
;*******************************************************************************

;To be used with V86.ASM, etc.




BIOS_DATA       SEGMENT USE16 AT 0

                ORG     449H            ;VIDEO FUNCTIONS

VID_MODE        DB      ?               ;Current video mode
SCR_WIDTH       DW      ?               ;Current screen width in columns
REGEN_LENGTH    DW      ?               ;Size of a screen page, in bytes
VIDEO_OFFSET    DW      ?               ;Offset of current page screen location
C_POS           DW      8 dup (?)       ;Cursor position on screen (Col in low byte, row in high)
CURSOR_SIZE     DW      ?               ;Size of cursor (First in high, last in low)
ACTIVE_PAGE     DB      ?               ;Active page
PORT_6845       DW      ?               ;Port address of 6845 controller
CRT_MODE        DB      ?               ;CRT mode setting
PALETTE_MASK    DB      ?               ;Color palette mask setting

BIOS_DATA       ENDS

