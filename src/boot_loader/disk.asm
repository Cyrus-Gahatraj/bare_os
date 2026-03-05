; load DH sectors to ES : BX from drive DL
disk_load:
	pusha
	mov ah, 0x02	; BIOS read sector function
	mov ch, 0x00	; Select track/cylinder 0
	mov dh, 0x00	; Select head 0

	push bx			; Store BX on stack
	mov bx, 0
	mov es, bx
	pop bx			; Restore BX from the stack
	mov bx, 0x7e00	; 512 bytes after 0x7c00
	int 0x13		; BIOS interrupt for disk

	jc disk_error	; Jump if error ( i.e. carry flag set )
	popa
	ret

disk_error:			; When a error occur
	mov bx, DISK_ERROR_MSG
	call print_string
	jmp $

DISK_ERROR_MSG db " Disk read error!" , 0
