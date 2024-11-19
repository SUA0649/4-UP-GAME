; main_game_file.asm
INCLUDE Irvine32.inc
INCLUDE shared.inc

EXITPROCESS PROTO

.code

main_game PROC uses eax ebx ecx edx esi edi


    call GameLoop               ; Display the board
    
ret
main_game ENDP

EXTERN game_board: BYTE           ; Declare the game_board as external

.data
prompt BYTE "Enter column number: ", 0

END
