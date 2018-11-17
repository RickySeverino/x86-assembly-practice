
%include 	'../functions.asm'

section .data
msg 	db 	' remainder '

section .text
global 	_start

_start:
	mov 	eax, 75
	mov 	ebx, 6
	div 	ebx
	call 	iprint
	mov 	eax, msg
	call 	sprint
	mov 	eax, edx
	call 	iprintLF

	call 	quit