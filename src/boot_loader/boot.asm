; Load the code exactly in 0x7c00
; which is the sector which the BIOS looks to load
[bits 16]			; Currently on 16 real mode
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

	cli		; clear all interrup
	lgdt  [GDT_descriptor]

	; Change last bit of cr0 to 1
	mov eax, cr0
	or eax, 1
	mov cr0, eax	; Now CPU on 32 bit protected mode

	; Jump to another segment (far jump)
	jmp CODE_SEG:start_protected_mode

; Include the .asm file
%include "./src/boot_loader/print.asm"
%include "./src/boot_loader/disk.asm"
%include "./src/boot_loader/gdt.asm"
%include "./src/boot_loader/protected.asm"

; 0 for floppy
; 0x80 for hard drive (for qemu)
BOOT_DRIVE: db 0x80
	
; 510 bytes and the magic number
times 510 - ($ - $$) db 0
dw 0xaa55

; Extra Sector
times 512 db 0

