
%include 	'../functions.asm'

section .data
command 	db 	'/bin/ls', 0x00
arg 		db 	'-l', 0x00
arguments	dd 	command
			dd 	arg 		; arguments to pass to commandline (in this case just one)
			dd 	0x00 		; end the struct
environment	dd 	0x00 		; arguments to pass as environment variables (inthis case none) end the struct

section .text
global _start:

_start:
	mov 	edx, environment
	mov 	ecx, arguments
	mov 	ebx, command
	mov 	eax, 11
	int 	0x80

	call 	quit