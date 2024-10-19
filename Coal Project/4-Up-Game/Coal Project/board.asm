; main.asm
INCLUDE Irvine32.inc
INCLUDE shared.inc

EXITPROCESS PROTO

.code
board PROC
    call clrscr
    call main_game           ; Call the game logic
    exit
board ENDP

_display PROC uses ecx edx eax ebx esi
    mov ecx, 6              ; Number of rows
    mov esi, 0
    mov edx, OFFSET space

L1:
    push ecx
    mov ecx, 7              ; Number of columns

L2:
    mov al, game_board[esi]  ; Get the character from the board
    call WriteChar           ; Print the character
    call WriteString         ; Print space
    inc esi
    loop L2

    call crlf                ; Newline after each row
    pop ecx
    loop L1
    ret
_display ENDP
.data
PUBLIC game_board           ; Make game_board public
game_board BYTE 6 DUP(7 DUP('-'))  ; 6x7 board initialized with '-'
PUBLIC space
space BYTE " ", 0

END 
