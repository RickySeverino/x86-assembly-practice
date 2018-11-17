
; integer printing function (itoa)

iprint:
	push 	eax 			; preserve eax on the stack to be restored after function runs
	push 	ecx 			
	push 	edx
	push 	esi
	xor 	ecx, ecx 		; counter of how many bytes we need to print in the end

divideLoop:
	inc 	ecx 			; count each byte to print - number of characters
	xor 	edx, edx 		; empty edx
	mov 	esi, 10 		
	idiv 	esi 			; divide eax by esi
	add 	edx, 48 		; convert edx to it's ascii representation - edx holds the remainder after a divide instruction
	push 	edx 			; push edx (string representation of an intger) onto the stack
	cmp 	eax, 0 			; can the integer be divided anymore?
	jnz 	divideLoop

printLoop:
	dec 	ecx 			; count down each byte that we put on the stack
	mov 	eax, esp 		; mov the stack pointer into eax for printing
	call 	sprint
	pop 	eax 			; remove last character from the stack to move esp forward
	cmp 	ecx, 0
	jnz 	printLoop

	pop 	esi 			; restore esi from the value we pushed onto the stack at the start
	pop 	edx
	pop 	ecx
	pop 	eax
	ret

; integer printing function with linefeed (itoa)

iprintLF:
	call	iprint
	push 	eax
	mov 	eax, 0x0A 		; move 0xA into eax - 0xA is the ascii character for a linefeed
	push 	eax 			; push the linefeed onto the stack so we can get the address
	mov 	eax, esp 		; move the address of the current stack pointer into eax for sprint
	call 	sprint
	pop 	eax
	pop 	eax
	ret

; string length calculation function

slen:
	push 	ebx
	mov 	ebx, eax

nextChar:
	cmp 	byte [eax], 0
	jz 		finished
	inc 	eax
	jmp 	nextChar

finished:
	sub 	eax, ebx
	pop 	ebx
	ret

; string printing function

sprint:
	push 	edx
	push 	ecx
	push 	ebx
	push 	eax
	call 	slen

	mov 	edx, eax
	pop 	eax

	mov 	ecx, eax
	mov 	ebx, 1
	mov 	eax, 4
	int 	0x80

	pop 	ebx
	pop 	ecx
	pop 	edx
	ret

; string printing with line feed function

sprintLF:
	call 	sprint
	push 	eax
	mov 	eax, 0x0A
	push 	eax
	mov 	eax, esp
	call 	sprint
	pop 	eax
	pop 	eax
	ret

; exit program and restore resources

quit:
	xor 	ebx, ebx
	mov 	eax, 1
	int 	0x80