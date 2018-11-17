
; Add Two Integers
; Ricky Severino

; Not a very good calculator; the sum cannot exceed 9


SYS_EXIT    equ     1
SYS_READ    equ     3
SYS_WRITE   equ     4
STDIN       equ     0
STDOUT      equ     1

section .data

in_val      db      0x0A, 'Enter a digit (0-9): '
len1        equ     $-in_val

in_val2     db      0x0A, 'Enter a second digit (0-9): '
len2        equ     $-in_val2

out_val     db      0x0A, 'The sum is: '
len3        equ     $-out_val

section .bss

a       resd    1
b       resd    1
sum     resd    1


%macro  _print  2

        mov     edx, %2
        mov     ecx, %1
        mov     ebx, STDOUT
        mov     eax, SYS_WRITE
        int     0x80

%endmacro

%macro  _store  2

        mov     edx, %2
        mov     ecx, %1
        mov     ebx, STDIN
        mov     eax, SYS_READ
        int     0x80

%endmacro

section .text
        
        global _start

_start:
        _print  in_val,  len1       ; ask for digit 1

        _store  a, 2                ; store digit 1

        _print  in_val2, len2

        _store  b, 2

        _print  out_val, len3       ; "The sum is: "

        call    _atoi               ; convert ascii to int

        mov     ebx, 0              ; sys exit call
        mov     eax, SYS_EXIT
        int     0x80

_atoi:
        sub     dword [a], 0x30
        sub     dword [b], 0x30
        mov     eax, dword [a]
        mov     ebx, dword [b]
        add     eax, ebx
        add     eax, 0x30
        mov     dword[sum], eax
        mov     [sum+1], dword 0x0A
        _print  sum, 4              ; print the sum
        ret

