
%include 	'../functions.asm'

section .text
global 	_start

_start:
	mov 	eax, 78
	mov 	ebx, 32
	sub 	eax, ebx
	call 	iprintLF

	call 	quit