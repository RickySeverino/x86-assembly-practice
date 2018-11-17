
%include 	'../functions.asm'

section .text
global 	_start

_start:
	pop 	ecx 		; first value on the stack is the number of arguments
	xor 	edx, edx

nextArg:
	cmp 	ecx, 0x00 	; check to see if we have any arguments left
	jz 		noMoreArgs
	pop 	eax 		; pop the next argument off the stack
	call 	atoi
	add 	edx, eax
	dec 	ecx
	jmp 	nextArg

noMoreArgs:
	mov 	eax, edx 	; move our data result into eax for printing
	call 	iprintLF
	call 	quit