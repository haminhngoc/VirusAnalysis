

; Rutina que muestra un texto en la pantalla

      mov dx,offset texto2
      mov ah,9
      int 021h
      ret
texto2 db 'Poner aca el texto deseado'
nosacar db '$' ; Marca el fin del texto

