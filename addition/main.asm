
%include 	'../functions.asm'

section .text
global 	_start

_start:
	mov 	eax, 100
	mov 	ebx, 24
	add 	eax, ebx
	call 	iprintLF

	call 	quit