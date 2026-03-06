[bits 32]
VIDEO_MEMORY equ 0xb8000	; VGA pointer
WHITE_ON_BLACK equ 0x0f		; White text on black bg	

print_on_protected_mode:
	pusha
	mov edx, VIDEO_MEMORY

print_loop:
	mov al, [ebx]
	mov ah, WHITE_ON_BLACK	

	cmp al, 0
	jz end_print

	mov [edx], ax

	add ebx, 1
	add edx, 2

	jmp print_loop

end_print:
	popa
	ret

start_protected_mode:
	mov ax, DATA_SEG
	mov ss, ax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov esp, 0x9000
	mov ebp, esp

	mov ebx, PROTECTED_MODE
	call print_on_protected_mode
	call KERNEL_OFFSET

	.loop:
		hlt
		jmp .loop 

