; main_game_file.asm
INCLUDE Irvine32.inc
INCLUDE shared.inc

EXITPROCESS PROTO

.code

main_game PROC uses eax ebx ecx edx esi edi


    call GameLoop               ; Display the board
    
ret
main_game ENDP
END
