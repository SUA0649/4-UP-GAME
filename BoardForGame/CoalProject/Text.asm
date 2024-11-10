INCLUDE Irvine32.inc

.data
rows DWORD 6                   
cols DWORD 7                   
board DWORD 42 DUP(0)          ; 6 rows x 7 columns = 42 cells is a more doable logic 
                               ; but different logic can be used the stage is set
tempRow DWORD ?

promptMsg BYTE "Enter column (0-6): ", 0
invalidMsg BYTE "Invalid column! Try again.", 0
fullColumnMsg BYTE "Column is full! Try again.", 0
emptyBox BYTE "|___|", 0
Player1Box BYTE "|_0_|", 0
Player2Box BYTE "|_x_|", 0
newLine BYTE "-----------------------------------", 0

.code
main PROC
    call GameLoop
    exit
main ENDP

GameLoop PROC
    mov ecx, 10            

GameLoopStart:
    call DisplayBoard
    mov ebx, eax         ; was making the logic but shaheer is more creative

    cmp ebx, 0
    jl InvalidInput
    cmp ebx, cols
    jge InvalidInput

    ; Place piece in selected column
    call PlacePiece

    jmp GameLoopStart

InvalidInput:
    mov edx, OFFSET invalidMsg
    call WriteString
    call Crlf
    jmp GameLoopStart 
GameLoop ENDP

DisplayBoard PROC
    mov ecx, rows               
    mov esi, 0                 
RowLoop:
    mov tempRow, ecx
    mov edx, OFFSET newLine
    call WriteString
    call Crlf
    mov edx, cols     
    mov edi, esi    
    mov ecx, 0            

ColLoop:
    mov eax, [board + edi]    

    cmp eax, 0
    je EmptyCell         

    cmp eax, 1
    je Player1Cell         

    cmp eax, 2
    je Player2Cell            

EmptyCell:
    mov edx, OFFSET emptyBox    
    call WriteString
    jmp NextColumn

Player1Cell:
    mov edx, OFFSET Player1Box   
    call WriteString
    jmp NextColumn

Player2Cell:
    mov edx, OFFSET Player2Box  
    call WriteString
    jmp NextColumn

NextColumn:
    add edi, 4              
    inc ecx
    cmp ecx, cols
    jl ColLoop

    call Crlf                
    mov ecx, tempRow
    cmp ecx, 0
    jne L2
    call GetColumnSelection
    ret
    L2:
    loop RowLoop    
DisplayBoard ENDP

GetColumnSelection PROC
    mov edx, OFFSET newLine
    call WriteString
    call Crlf
    call WaitMsg
    call Clrscr
    mov edx, OFFSET promptMsg
    call WriteString
    call ReadInt         
    ret
GetColumnSelection ENDP

PlacePiece PROC
    
; logic for adding elements to board
    ret
PlacePiece ENDP

END main