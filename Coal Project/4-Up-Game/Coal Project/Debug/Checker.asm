INCLUDE Irvine32.inc
INCLUDE shared.inc

.data

line_1 BYTE "__________.__                                         ____            .__               ",0
line_2 BYTE "\______   \  | _____  ___.__. ___________            /_   |   __  _  _|__| ____   ______",0
line_3 BYTE " |     ___/  | \__  \<   |  |/ __ \_  __ \   ______   |   |   \ \/ \/ /  |/    \ /  ___/",0
line_4 BYTE " |    |   |  |__/ __ \\___  \  ___/|  | \/  /_____/   |   |    \     /|  |   |  \\___ \ ",0
line_5 BYTE " |____|   |____(____  / ____|\___  >__|               |___|     \/\_/ |__|___|  /____  >",0
line_6 BYTE "                   \/\/         \/                                           \/     \/  ",0

Buffer_1 DWORD OFFSET Line_1,OFFSET Line_2,OFFSET Line_3,OFFSET Line_4,OFFSET Line_5,OFFSET Line_6

line_7 BYTE "__________.__                                        ________             .__               ",0
line_8 BYTE "\______   \  | _____  ___.__. ___________            \_____  \    __  _  _|__| ____   ______",0
line_9 BYTE " |     ___/  | \__  \<   |  |/ __ \_  __ \   ______   /  ____/    \ \/ \/ /  |/    \ /  ___/",0
line_10 BYTE " |    |   |  |__/ __ \\___  \  ___/|  | \/  /_____/  /       \     \     /|  |   |  \\___ \ ",0
line_11 BYTE" |____|   |____(____  / ____|\___  >__|              \_______ \     \/\_/ |__|___|  /____  >",0
line_12 BYTE"                    \/\/         \/                          \/                   \/     \/ ",0

Buffer_2 DWORD OFFSET Line_7,OFFSET Line_8,OFFSET Line_9,OFFSET Line_10,OFFSET Line_11,OFFSET Line_12


rows = 6                   
cols = 7    

EXTERN Board_Layout: BYTE           ; Declare the game_board as external
EXTERN Current_Iteration:DWORD

.code




Winner PROC

mov eax, Current_Iteration
call Clrscr
mov ecx, 6

shr eax,1
jc Player_1


Player_2:

mov esi, 0
mov eax, 14 
call SetTextColor
L1:

	mov edx,Buffer_1[esi]
	call WriteString
	add esi,4
	call Crlf
	loop L1
mov eax,15
call SetTextColor

jmp _End

Player_1:

mov esi,0

mov eax, 4
call SetTextColor

L2:
	mov edx,Buffer_2[esi]
	call WriteString
	add esi,4
	call Crlf
	loop L2

mov eax,15
call SetTextColor

_End:

call ReadDec

ret
Winner ENDP




;Check_Diagonal PROC COLUMN:DWORD,ROW:DWORD,INDEX:DWORD



;Check_Diagonal ENDP


Check_Vertical PROC ROW:DWORD, INDEX:DWORD

mov edi,ROW

cmp edi,3
jg _End

mov ecx,3

mov esi, INDEX

L1:

	add esi, rows+1
	cmp Board_Layout[esi],al	
	jne _End
	loop L1

call Winner

_End:

ret
Check_Vertical ENDP


Check_Horizontal PROC COLUMN:DWORD, INDEX:DWORD


mov edx,1
mov esi,COLUMN
mov edi,INDEX

Going_Right:
	inc edi
	inc esi
	cmp esi,cols
	jge Going_Right_End
	;Counter to check if edx = 4 then winner
	cmp Board_Layout[edi],al
	jne Going_Right_End
	
	inc edx

	jmp Going_Right

Going_Right_End:
mov esi,COLUMN
mov edi, INDEX

Going_Left:
	dec edi
	dec esi
	cmp esi,0
	jl Going_Left_End
	cmp Board_Layout[edi],al
	jne Going_Left_End

	inc edx
	jmp Going_Left

Going_Left_End:

cmp edx,4
jb _End

call Winner

_End:

ret
Check_Horizontal ENDP


Checker PROC COLUMN:DWORD

LOCAL ROW:DWORD,INDEX:DWORD
mov ROW,0

;Maximum number of moves possible in the game

cmp Current_Iteration,42
ja Draw

;We are going start comparision after 4
cmp Current_Iteration,8
jl _End

;Check which row in column was it inserted into

mov esi,COLUMN

Check_Row:

	cmp Board_Layout[esi],0
	jne End_Check_Row
	inc ROW
	add esi, (rows+1)
	jmp Check_Row

End_Check_Row:

mov INDEX,esi

;For which character to compare with
mov al, Board_Layout[esi]

; As we know the games winning condition is if there are four in a row, so we are going to check only 3 blocks down,right, left and diagonals (up-left,up-right,down-left,down-right)

INVOKE Check_Horizontal, COLUMN, INDEX

INVOKE Check_Vertical, ROW, INDEX

;INVOKE Check_Diagonal, COLUMN,ROW,INDEX

jmp _End


Draw:




_End:

ret
Checker ENDP
END

