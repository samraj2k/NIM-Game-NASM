%include "io.mac"
SECTION .data
sta    db  'Welcome to NIM Game:', 0

msg     db  'The current status of piles are:', 0

p1     db 'Player 1 turn:', 0

p2     db 'Player 2 turn:', 0

pin db 'Select the index of pile to remove stones:',0

rem db 'Select number of stones to remvove from chosen pile:',0

win1     db  'No stones left for Player 2 to remove, Player 1 WIN', 0

win2     db  'No stones left for Player 1 to remove, Player 2 WIN', 0

warn1 db 'Index should be between 1 to 10 and number of stones > 0, enter correctly again:',0
warn2 db 'Value should be greater than zero and less equal to value of pile chosen, enter correctly again:',0

lastmove  dd 1  
idx     db  0
val     db  0
endl db 0xA, 0xD
lenendl equ $ -endl
sz dd 10
spc db ' ',0

piles    DD  0,0,0,0,0,0,0,0,0,0
lenpiles equ ($ - piles)

rand dd 23
 
SECTION .text
global  _start
 
_start:                         ;Start of code
 
    PutStr sta
    nwln
    nwln
    
    sub esi, esi
    mov ecx, [sz]
random:                         ;Generaring random stones in piles
    rdtsc
    mov dx,0
    mov bx,[rand]
    div bx

    mov [piles + esi*4], dx;
    inc esi
    dec ecx
    cmp ecx, 0
    jne random
    
fill:                           ;Put size in ecx register for loop
    PutStr msg
    nwln
    mov ecx,[sz]
    sub eax, eax
    sub esi, esi
    sub ebx,ebx
show:                           ;Loop to print the current status of the piles
    mov ebx, [piles + esi*4]
    inc esi
    PutLInt ebx
    dec ecx
    add eax,ebx
    PutStr spc    
    cmp ecx,0
    jne show
    nwln
      
    cmp eax,0
    je Winner
    
    mov eax, [lastmove]
    cmp eax, 1
    jne Play2
    
Play1:                         ;Check whose move
    nwln 
    PutStr p1
    nwln
    jmp TakeXOR

Play2:                         ;Check whose move
    nwln
    PutStr p2 
    nwln        

TakeXOR:                       ;Swap the move after each turn
    mov eax, [lastmove]
    xor eax, 1
    mov [lastmove], eax

    PutStr pin
    nwln 
    jmp TakeIDX

ErrorIDX:                      ;Error in taking Index
    PutStr warn1
    nwln
TakeIDX:                       ;Take the index of the pile from which stones to remove
    GetLInt ebx
    cmp ebx,1
    jl ErrorIDX
    cmp ebx,10
    jg ErrorIDX
    mov eax, [piles + 4*ebx - 4]
    cmp eax,0
    je ErrorIDX
    PutStr rem 
    nwln
    jmp TakeVAL
ErrorVAL:                      ;Error in taking value of stones to remove
    PutStr warn2
    nwln
TakeVAL:                       ;Take input value of number of piles to remove
    GetLInt ecx
    mov eax,[piles + 4 * ebx - 4]
    cmp ecx, eax
    jg ErrorVAL
    cmp ecx,1
    jl ErrorVAL
    sub eax, ecx
    mov [piles + 4 * ebx - 4], eax
    mov eax,0
    nwln
    jmp fill

Winner:                        ;We have a winner
    mov eax, [lastmove]
    nwln
    cmp eax,0
    jne Winner2
    jmp Winner1      
Winner1:                       ;Player 1 is winnner
    PutStr win1
    jmp exit
    
Winner2:                       ;Player 2 is winnner
    PutStr win1
    
exit:                          ;End of code
    mov eax,1            
    mov ebx,0            
    int 80h
