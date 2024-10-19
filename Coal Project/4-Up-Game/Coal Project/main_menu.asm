Include C:/irvine/Irvine32.inc
Include shared.inc

.data

;General

	;Using cordiantes for the Instruction (Gotoxy DH = row, DL = col)
	Line_X BYTE 10
	Line_Y BYTE 5
	Arrow BYTE "->",0	
	;Making a temp variable to store and reuse for ecx (counting)
	temp DWORD ? 



;Players
	Player_1 BYTE "Player 1: ",0
	Player_2 BYTE "Player 2: ",0

;Menu


	Current_Option BYTE 0


	Line_1 BYTE "  _  _          _    _          _____                      ",0
	Line_2 BYTE " | || |        | |  | |        / ____|                     ",0
	Line_3 BYTE " | || |_ ______| |  | |_ __   | |  __  __ _ _ __ ___   ___ ",0
	Line_4 BYTE " |__   _|______| |  | | '_ \  | | |_ |/ _` | '_ ` _ \ / _ \",0
	Line_5 BYTE "    | |        | |__| | |_) | | |__| | (_| | | | | | |  __/",0
	Line_6 BYTE "    |_|         \____/| .__/   \_____|\__,_|_| |_| |_|\___|",0
	Line_7 BYTE "                      | |                                  ",0
	Line_8 BYTE "                      |_|                                  ",0

	Option_1 BYTE "Play",0
	Option_2 BYTE "How To Play",0
	Option_3 BYTE "Exit",0

	Buffer_menu DWORD OFFSET Line_1,OFFSET Line_2,OFFSET Line_3,OFFSET Line_4,OFFSET Line_5,OFFSET Line_6,OFFSET Line_7,OFFSET Line_8

;How_To_Play

	
	How_To_Play_Line_1 BYTE"  _    _                 _______      _____  _             ",0
	How_To_Play_Line_2 BYTE" | |  | |               |__   __|    |  __ \| |            ",0
	How_To_Play_Line_3 BYTE" | |__| | _____      __    | | ___   | |__) | | __ _ _   _ ",0
	How_To_Play_Line_4 BYTE" |  __  |/ _ \ \ /\ / /    | |/ _ \  |  ___/| |/ _` | | | |",0
	How_To_Play_Line_5 BYTE" | |  | | (_) \ V  V /     | | (_) | | |    | | (_| | |_| |",0
	How_To_Play_Line_6 BYTE" |_|  |_|\___/ \_/\_/      |_|\___/  |_|    |_|\__,_|\__, |",0
	How_To_Play_Line_7 BYTE"                                                      __/ |",0
	How_To_Play_Line_8 BYTE"                                                     |___/ ",0

	Buffer_How_To_Play DWORD OFFSET How_To_Play_Line_1,OFFSET How_To_Play_Line_2,OFFSET How_To_Play_Line_3,OFFSET How_To_Play_Line_4,OFFSET How_To_Play_Line_5,OFFSET How_To_Play_Line_6,OFFSET How_To_Play_Line_7,OFFSET How_To_Play_Line_8

	How_To_Play_Statement BYTE "You should play like this and that",0

.code
main_menu_p PROC

;First lets initiate the registers to 0

mov ecx,0
mov edx,0
mov ebx,0
mov eax,0


;Printing Main Menu here

Main_Menu: 

	call Clrscr

	mov ecx, Lengthof Buffer_menu
	mov eax,0
	
	mov Line_X,10
	mov Line_Y,5

	Display:	
		
		;We have to Call the Gotoxy instruciion everytime since the cursor resets whenever we want to print anything again, remember to change y-axis too
		mov edx,0
		mov dl,Line_X
		mov dh,Line_Y
		inc Line_Y
		call Gotoxy
		
		mov edx, Buffer_menu[eax]
		add eax,4
		call WriteString
		call Crlf
		loop Display

	add Line_X, 30
	add Line_Y, 2
	mov dl, Line_X
	mov dh,Line_Y
	call Gotoxy
	mov edx,OFFSET Option_1
	call WriteString
	call Crlf

	inc Line_Y
	mov dl,Line_X
	mov dh,Line_Y
	call Gotoxy
	mov edx,OFFSET Option_2
	call WriteString
	call Crlf

	inc Line_Y
	mov dl,Line_X
	mov dh,Line_Y
	call Gotoxy
	mov edx,OFFSET Option_3
	call WriteString
	call Crlf


	;move back to play
	sub Line_Y,2
	mov ah,01
	Select: 
		
		;Formatting for the arrow key
		sub Line_X, 10
		
		mov dl,Line_X
		mov dh,Line_Y
		add dh,Current_Option

		call Gotoxy
		mov edx,OFFSET Arrow
		call WriteString

		call ReadChar

		;Comparing for 	options

			Comparision_1:
				cmp eax, 5000h ; Even though 0x28 == down arrow key, when i manually checked by debugging i saw that when i press down i got a value of 4800h, simil
				jne Comparision_2
				cmp Current_Option, 2
				je Main_Menu
				inc Current_Option ; Using a seperatble variable so that we can check what option the player has selected and show them things according to that
				jmp Main_Menu

			Comparision_2:
				cmp eax, 4800h ; 0x26 == up arrow key
				jne Comparision_3
				cmp Current_Option, 0
				je Main_Menu
				dec Current_Option
				jmp Main_Menu

			Comparision_3:
				cmp eax,1C0Dh ; normally 0x0D == enter
				je Check_Option 

		jmp Main_Menu


		;I HAVE NOT MADE ANY DECISIONS OR COMPARISION WITH PLAY so if your pc crash not my fault

	Check_Option:
		;Now we can use the Current_Option variable
		
		cmp Current_Option,2 ;If 2 we close, if 1 we print how to play , if 0 we start the game
		je last
		cmp Current_Option,0
		call board
		ret
		cmp Current_Option,1
		je How_To_Play

	How_To_Play:
			
		mov Line_X,10
		mov Line_Y,5

		call Clrscr
		mov ecx,lengthof Buffer_How_To_Play

		mov eax,0

		Display_How:
			mov edx,0
			mov dl,Line_X
			mov dh,Line_Y
			inc Line_Y
			call Gotoxy

			mov edx,Buffer_How_To_Play[eax]
			add eax,4
			call WriteString
			call Crlf
			loop Display_How
		
		add Line_X, 5
		mov dl, Line_X
		mov dh, Line_Y

		call Gotoxy

		mov edx,OFFSET How_To_Play_Statement
		call WriteString

		call ReadChar	
		jmp Main_Menu



Last: ;For some reason i couldn't name my label to End

exit
main_menu_p ENDP
END