

jmp main
texto db 13,10
      db 'Soy un COM infectado!!'
      db 13,10,'$'
main:
      mov ah,9
      mov dx,offset texto
      int 021h
      mov ah,04ch
      int 021h

