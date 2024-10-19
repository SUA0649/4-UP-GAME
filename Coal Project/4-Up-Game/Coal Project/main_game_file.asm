; main_game_file.asm
INCLUDE Irvine32.inc
INCLUDE shared.inc

EXITPROCESS PROTO

.code

main_game PROC uses eax ebx ecx edx esi edi
    mov edx, OFFSET prompt
    call WriteString
    call ReadDec            ; Read the column number into EAX

    mov ecx, 0
L1:
    cmp game_board[eax], '-'  ; Check if the cell is empty
    jne L2
    mov game_board[eax], 'y'  ; Place 'y' in the selected column

    cmp ecx, 5
    je L2
    add eax, 7                ; Move to the next row in the same column

    cmp game_board[eax], '-'  ; Check the next row
    jne L2
    mov game_board[eax - 7], '-'  ; Reset the previous row if current is occupied
    jmp L1

L2:
    call _display               ; Display the board
    ret
main_game ENDP

EXTERN game_board: BYTE           ; Declare the game_board as external

.data
prompt BYTE "Enter column number: ", 0

END
