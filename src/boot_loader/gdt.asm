; Global Descriptor Table on Flat Memory Model

; Code Segment 
;
; Property
; base: Its descript the starting location of the segment (i.e. 0)
; limit: Its descript the size of the segment, which is a 20 (0xfffff) bit property
;
; present: A single bit value for, if the segment is used, (i.e. 1)
; privilage: Two bit value for privilages from 0 to 3 (highest being 0 and lowest being 3)
; type: A single bit value for if it a code or a data segment
; so pres, priv, type: 1001 (00 is priv 0)
;
; Flags
; Type Flag
;	Is a code segment: 1 
;	Conforming (i.e. code can be execute from lower privilages): 0
;	Is segment readable: 1
;	Accessed (It is used by CPU, to know the segment is currently on use): 0
;	So type flag = 1010
; Other Flag
;	Granularity (if 1 then limit is multiplied by 0x1000): 1
;	Is the segment use 32 bit memory: 1
;	(Last two bits don't come in use so 0)
;	So other flag = 1100

; Data Segment
; Data Segment is similar, only different is in type flag
; Type Flag
;	Is a code segment: 0
;	Is expand down segment (grows downward): 0
;	Is writable: 1 
;	Is accessed: 0
; So type flag: 0010
; pres, priv, type: 1001
; other flag: 1100


GDT_start:
	null_descriptor:
		dd 0
		dd 0
	code_descriptor:
		dw 0xffff	; first 16 bits of the limit

		; 24 bit of the base
		dw 0		; 8 bits
		db 0		; 16 bits	
	
		; 1 byte of pres, priv, type and type flag 
		; First four bits are pres, priv and type
		; Second four bits are type flags
		db 0b10011010

		; 1 byte of other flags and the rest of the limit
		db 0b11001111

		db 0		; Last 8 bit of the base

	data_descriptor:
		; Same as the code descriptor 
		dw 0xffff
		dw 0
		db 0
		; Only difference here for type flags
		db 0b10010010
		db 0b11001111
		db 0

GDT_end:

GDT_descriptor:
	dw GDT_end - GDT_start - 1	; size
	dd GDT_start				; start

CODE_SEG equ code_descriptor - GDT_start
DATA_SEG equ data_descriptor - GDT_start


