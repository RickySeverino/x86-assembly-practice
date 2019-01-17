
%include 	'../functions.asm'

section .data
msg		db 	'This is a for loop!', 0x00

section .text
global 	_start

_start:
	xor 	ecx, ecx

.loop:
	inc 	ecx
	cmp 	ecx, 11
	jge 	.exit
	mov 	eax, msg
	call 	sprintLF
	jmp 	.loop

.exit:
	call 	quit

