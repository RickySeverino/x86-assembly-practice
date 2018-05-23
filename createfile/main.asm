
; Create a file and write text to it

section .text

global  _start

_start:

        ; Create and open file
        mov     eax, 8          ; put the system call sys_creat() number 8, in the EAX register
        mov     ebx, file       ; put the file name in the EBX register
        mov     ecx, 644o       ; put the file permissions in the ECX register
        int     0x80            ; call kernel

        mov     [fd_out], eax

        ; Write to file
        mov     edx, len        ; number of bytes
        mov     ecx, msg        ; messge to write
        mov     ebx, [fd_out]   ; stdout
        mov     eax, 4          ; system call number, sys_write()
        int     0x80            

        ; Close the file
        mov     eax, 6          ; put the system call sys_close() number 6, in the EAX register
        mov     ebx, [fd_out]   ; put the file descriptor in the EBX register
        int     0x80            

        ; System exit
        mov     eax, 1          ; system exit call
        int     0x80            

section .data

file    db      'test.txt', 0
msg     db      'This message was written to file with assembly', 0xA
len     equ      $-msg

section .bss

fd_out  resb    1

