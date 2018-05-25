
section .data

file        db      'file.txt', 0
prompt      db      0x0A, 'Enter text to write to file: '
len         equ     $-prompt
confirm     db      0x0A, 'Write to file successfull', 0x0A
len_conf    equ     $-confirm

section .bss

msg     resb    100
fd_out  resb    1

section .text

global  _start

_start:
        mov     ecx, 644o
        mov     ebx, file
        mov     eax, 8
        int     0x80

        mov     [fd_out], eax
        
        mov     edx, len
        mov     ecx, prompt
        mov     ebx, 1
        mov     eax, 4
        int     0x80

        mov     edx, 100
        mov     ecx, msg
        mov     ebx, 0
        mov     eax, 3
        int     0x80

        mov     edx, 100
        mov     ecx, msg
        mov     ebx, [fd_out]
        mov     eax, 4
        int     0x80

        mov     edx, len_conf
        mov     ecx, confirm
        mov     ebx, 1
        mov     eax, 4
        int     0x80

        mov     ebx, [fd_out]
        mov     eax, 6
        int     0x80

        mov     eax, 1
        mov     ebx, 0
        int     0x80

