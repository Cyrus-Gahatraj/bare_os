; Load the code exactly in 0x7c00
; which is the sector which the BIOS looks to load
[org 0x7c00] 

; 0001 1111 1011 0110
mov dx, 0x7c00
call print_hex

; Loop for eternity
loop:
	hlt
	jmp loop

; Include the .asm file
%include "print.asm"
	
; 510 bytes and the magic number
times 510 - ($ - $$) db 0
dw 0xaa55
