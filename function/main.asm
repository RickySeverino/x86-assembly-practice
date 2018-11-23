
%include 	'../functions.asm'

section .data

msg 	db 	'The sum is: ', 0x00

section .text
global _start

_myFunction:
	push 	ebp
	mov 	ebp, esp
	sub 	esp, 16 				; allocate space for local vars (each var is 4 bytes)
	mov 	eax, dword [ebp+8] 		; eax = first parameter (not +4 because +4 is the return address)
	add 	eax, 3 					; first parameter + 3
	mov 	dword [ebp-4], eax 		; store value of eax into var1
	mov 	eax, dword [ebp+12] 	; eax = second paramter
	add 	eax, 3
	mov 	dword [ebp-8], eax 		; store value of eax into var2
	mov 	eax, dword [ebp+16]
	add 	eax, 3
	mov 	dword [ebp-12], eax
	mov 	eax, dword [ebp-4] 		; store var1 into eax
	mov 	ebx, dword [ebp-8]
	lea 	eax, [eax+ebx] 			; store sum of var1 and var2 into eax
	add 	eax, dword [ebp-12] 	; add var3 to eax = total sum
	mov 	dword [ebp-16], eax 	; var4 = total sum
	mov 	eax, dword [ebp-16] 	; store total sum in eax so the function can return it
	mov 	esp, ebp 				; deallocate local variables
	pop 	ebp						; restore caller's base pointer
	ret

_start:
	mov 	edx, 3 					; third parameter
	push 	edx 					; push so the function can reference it
	mov 	ecx, 2 					; second parameter
	push 	ecx
	mov 	ebx, 1 					; first parameter
	push 	ebx
	call 	_myFunction
	add 	esp, 12 				; clean up the stack (3 params * 4 bytes)
	push 	eax 					; preserve the return value for later use
	mov 	eax, msg
	call 	sprint
	pop 	eax
	call 	iprintLF
	call 	quit