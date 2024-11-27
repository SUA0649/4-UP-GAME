Include Irvine32.inc
Include shared.inc

ExitProcess PROTO, dwExitCode:DWORD
PlaySoundA PROTO, pszSound:PTR BYTE, hmod:DWORD, fdwSound:DWORD

.data
wav_file BYTE "sound.wav", 0

.code
main PROC
INVOKE PlaySoundA, ADDR wav_file, NULL, 00020001h 
L1:
call main_menu_p
cmp eax,-2
je END_LOOP_1
jmp L1
END_LOOP_1:

INVOKE PlaySoundA, NULL, NULL, 0

main ENDP
END main