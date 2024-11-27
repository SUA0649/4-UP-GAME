INCLUDE Irvine32.inc
INCLUDE shared.inc

.data


rows = 6                   
cols = 7                   
     
emptyBox BYTE "|___|", 0
Player1Box BYTE "|_0_|", 0
Player2Box BYTE "|_X_|", 0


;Don't use numeric numbers else sir hmary sath viva mein kuch change krny ko bola to mary jaengy

PUBLIC Board_Layout
Board_Layout BYTE rows DUP(cols DUP(0))


;0 meaning empty, 1 meaning player_1, 2 meaning player_2

fullColumnMsg BYTE "Column is full! Try again.", 0
newLine BYTE "-----------------------------------", 0

UpArrow BYTE '^','|'

PUBLIC Current_Iteration
Current_Iteration DWORD ?


.code

board PROC
    call clrscr
    call main_game           ; Call the game logic
ret  
board ENDP

DisplayArrow PROC index:BYTE

     ;Gotoxy (DH = row, DL = col) ;This is somewhat confusing, just think of it as DH = how much down from top, and columns = how much right from left

    
    mov dh,cols + 5
    mov dl, 0
    mov eax,' '
    
     call Gotoxy
     call WriteChar

    ;Looping to first set the the whole line after to be completely empty(by Null character)

    mov ecx,40


    ;First Line
    NULLSPACES:
        call Gotoxy   
        call WriteChar
        inc dl
        loop NULLSPACES

    mov ecx,40
    inc dh
    mov dl,0
    ;Second Line
    NULLSPACES_2:
        call Gotoxy   
        call WriteChar
        inc dl
        loop NULLSPACES_2


    ;Now to show arrow C:
    mov dh,cols+5 ;adding constants since characters such as |___| takes more than one space 'f' u yahya, made me do maths

    movzx eax,Index
    call WriteDec


    cmp Index,1
    jbe First_index
    jmp Not_First_index

    First_index:
    mov dl,2
    jmp Format

    Not_First_index:
    mov eax,5
    mul index
    call crlf
    sub eax,3
    mov dl,al
    


    Format:

    call Gotoxy
    ;Formatting to show arrow
    mov al,UpArrow[0]
    call WriteChar

    inc dh
    call Gotoxy
    mov al,UpArrow[1]
    call WriteChar
    
    

    ret
DisplayArrow ENDP



Input PROC Column:BYTE

dec Column
movzx eax,Column
add eax,35 ;Last row index
mov ecx,rows

L1:
    cmp Board_Layout[eax],0
    jz Found_empty
    sub eax,(rows+1)
    jc _end
    loop L1

Found_empty:
    ;Checking which player, if carry it means odd and player 1 or 2 otherwsie
    mov ebx,eax
    mov eax,Current_Iteration
    shr eax,1
    jc for_Player_1

    
    for_Player_2:
        mov Board_Layout[ebx],2
        inc Current_Iteration
        jmp _end

    for_Player_1:
       mov Board_Layout[ebx],1    
       inc Current_Iteration
      
_end:
movzx ebx, Column

ret
Input ENDP




;Starting from here is the main Game logic using Yahya's code

GameLoop PROC uses ecx edx eax ebx esi
   
   Local arrow_index:BYTE
   mov arrow_index,1

   ;Pushing 0 on stack 7 times since that's the number of columns, doing this so that we can find index in O(1) time, instead of finding at which index is empty to be pushed on

   ;The Number of moves running, starting from 1, we can use this to take mods and use it in checking for winner logic, or even highscore, saying that you won in such moves
   mov Current_Iteration,1

   GameLoopStart:
   call Clrscr
  
    push OFFSET emptyBox
    push OFFSET Player1Box
    push OFFSET Player2Box
    call DisplayBoard
  
    
    ;Showing the arrow as asked many times by Shaheer .-. , btw i will not be clearing the whole screen i will just move cursor left and right and fill with white spaces
    ;No need to check for invalid Input, i mean we only have to if it is filled to the brim but otherwise nope
        
        
         Print_Arrow:
                INVOKE DisplayArrow, arrow_index
        
        Input_Loop:
            call ReadChar
            
			Right_Key:
				cmp eax, 4D00h ;Right arrow key 
                jnz Left_Key
                cmp arrow_index,cols
                jae Print_arrow
                inc arrow_index
				jmp Print_Arrow

			Left_Key:
				cmp eax, 4B00h ; 0x26 == up arrow key
                jnz Enter_Key
                cmp arrow_index,1
                jbe Print_arrow
				dec arrow_index
                jmp Print_Arrow
				
			Enter_Key:
				cmp eax,1C0Dh ; normally 0x0D == enter
                jz Take_Input

                jmp Input_Loop


            Take_Input:
                movzx eax,arrow_index
                INVOKE Input, arrow_index
               
             ;Ebx will have the column in which latest input was taken in and from there we check(up,down,left,right and diagonals)
             INVOKE Checker, ebx

             cmp eax,-1
             je GameLoopEnd

            jmp GameLoopStart
    
    GameLoopEnd:
    call Reset_Board
    call clrscr
ret
GameLoop ENDP




DisplayBoard PROC

 ;Better to use stack to store offset than to find their offsets evertime which needs calculations from the pc
    push ebp
    mov ebp,esp

    mov ecx, rows
    mov esi,0
    
;General rule of thumb it is better to print each row left to right as opposed to up to down, since the buffer has to reset everytime to traverse backwards, consider it as an array
;The array will print on O(n) while moving linearly, else it will print in O(n^2 or somewhat i didnt calculate) if column wise
 
RowLoop:
    push ecx
    mov edx, OFFSET newLine
    call WriteString
    call Crlf
    mov edi, esi    
    mov ecx,cols             

ColLoop:
    movzx eax, Board_Layout[edi]    

    cmp eax, 0
    jz EmptyCell         

    cmp eax, 1
    jz Player1Cell         

    cmp eax, 2
    jz Player2Cell            

EmptyCell:
    
    mov edx, [ebp+16]
    call WriteString
    jmp NextColumn

Player1Cell:
    mov eax, 4
    call SetTextColor
    mov edx, [ebp+12]
    call WriteString
    jmp NextColumn

Player2Cell:
    mov eax, 1
    call SetTextColor

    mov edx, [ebp+8]
    call WriteString
    jmp NextColumn

NextColumn:

    mov eax,15
    call SetTextColor

    inc edi
    loop ColLoop
    call Crlf                
    pop ecx
    add esi,cols
    loop RowLoop

pop ebp
ret 12;Emptying 8 bytes from stack
DisplayBoard ENDP

Reset_Board PROC uses esi
    mov ecx,lengthof Board_Layout
    mov esi,0
       L1:
        mov Board_Layout[esi],0
        inc esi
       Loop L1
       ret
Reset_Board ENDP
END 
