
; Ask user for number, then display that number

section .data

msg         db      0x0A, 'Enter a number: '
lenMsg      equ     $-msg
disMsg      db      0x0A, 'You entered: '
lenDisMsg   equ     $-disMsg 

section .bss

num     resb    5

section .text

global  _start

_start:
        ; Ask user for number
        mov     edx, lenMsg
        mov     ecx, msg
        mov     ebx, 1
        mov     eax, 4
        int     0x80

        ; Get and store user number
        mov     edx, 5
        mov     ecx, num
        mov     ebx, 0
        mov     eax, 3
        int     0x80

        ; Output confirmation message
        mov     edx, lenDisMsg
        mov     ecx, disMsg
        mov     ebx, 1
        mov     eax, 4
        int     0x80

        ; Display user number
        mov     edx, 5
        mov     ecx, num
        mov     ebx, 1
        mov     eax, 4
        int     0x80

        ; Exit call
        mov     eax, 1
        mov     ebx, 0
        int     0x80

