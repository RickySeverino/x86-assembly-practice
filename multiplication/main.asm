
%include 	'../functions.asm'

section .text
global 	_start

_start:
	mov 	eax, 12
	mov 	ebx, 5
	mul 	ebx 		; multiply eax by ebx
	call 	iprintLF

	call 	quit