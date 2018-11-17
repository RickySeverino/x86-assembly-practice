
%include 	'../functions.asm'

section .data
fizz	db 	'Fizz', 0x00
buzz 	db 	'Buzz', 0x00

section .text
global 	_start

_start:
	xor 	esi, esi
	xor 	edi, edi
	xor 	ecx, ecx

nextNumber:
	inc 	ecx

.checkFizz:
	xor 	edx, edx 		; clear the edx register - this will hold our remainder after division
	mov 	eax, ecx 		; move the value of our counter into eax for division
	mov 	ebx, 3 			; move our number to divide by into ebx (in this case the value is 3)
	div 	ebx
	mov 	edi, edx 		; move our remainder into edi (our checkFizz boolean variable
	cmp 	edi, 0
	jne 	.checkBuzz 		; if the remainder is not equal to zero jump to local label checkBuzz
	mov 	eax, fizz
	call 	sprint

.checkBuzz:
	xor 	edx, edx
	mov 	eax, ecx
	mov 	ebx, 5
	div 	ebx
	mov 	esi, edx
	cmp 	esi, 0
	jne 	.checkInt
	mov 	eax, buzz
	call 	sprint

.checkInt:
	cmp 	edi, 0 			; edi contains the remainder after the division in checkFizz
	je 		.continue
	cmp 	esi, 0
	je 		.continue
	mov 	eax, ecx
	call 	iprint

.continue:
	mov 	eax, 0x0A
	push 	eax
	mov 	eax, esp
	call 	sprint
	pop 	eax
	cmp 	ecx, 100 		; compare if our counter is equal to 100
	jne 	nextNumber 		; if not equal jump to the start of the loop

	call 	quit