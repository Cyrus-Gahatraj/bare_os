; Load the code exactly in 0x7c00
; which is the sector which the BIOS looks to load
[org 0x7c00] 

start:
	mov ax, 0x03	; Set video mode to 3 (clear screen)
	int 0x10
	jmp main

main:
	mov dl, [BOOT_DRIVE]
	mov cl, 0x02	; Start reading from 2nd sector
	mov al, 0x01	; Number of sector
	call disk_load

	jmp second_sector

	; Loop for eternity
	loop:
		hlt
		jmp loop

; Include the .asm file
%include "./src/boot_loader/print.asm"
%include "./src/boot_loader/disk.asm"

; 0 for floppy
; 0x80 for hard drive (for qemu)
BOOT_DRIVE: db 0x80
SECOND_SEC: db "In second sector"
	
; 510 bytes and the magic number
times 510 - ($ - $$) db 0
dw 0xaa55

second_sector:
	mov si, SECOND_SEC
	call print_string

; Extra Sector
times 512 db 0

