
%include 	'../functions.asm'

section .text
global 	_start

_start:
	xor 	ecx, ecx

nextNumber:
	inc 	ecx
	mov 	eax, ecx
	call 	iprintLF
	cmp 	ecx, 10
	jne 	nextNumber

	call 	quit