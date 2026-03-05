print_string:
	; Push all register to stack
	pusha
	; BIOS teletype
	; Print sing character on screen and advance the cursor
	mov ah, 0x0e
.next_char:
	lodsb
	cmp al, 0
	je .done

	; BIOS's screen-related ISR (interrupt service routines)
	int 0x10
	jmp .next_char
.done:
	;pop all register from stack
	popa
	ret

HEX_OUT: db '0x0000', 0
print_hex:
	; Loop counter
	mov cx, 4

	; Last character of the HEX_OUT
	; 0 x 0 0 0 0
	; 0 1 2 3 4 5
	mov bx, HEX_OUT + 5 

	.hex_loop:
	mov al, 0xf
	and al, dl
	cmp al, 0xa
	jl .is_digit
	; Add 7 too if it's not a digit
	add al, 7

	.is_digit: 
	add al, '0'

	mov [bx], al
	dec bx
	; Shift the byte right 
	shr dx, 4

	dec cx
	jnz .hex_loop  ; Jump Not Equal Zero 

	; Print the HEX_OUT
	mov si, HEX_OUT
	call print_string
	ret
