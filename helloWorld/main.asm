
section .data

msg     db      'Hello world!', 0xA
len     equ     $-msg
 
section .text

global  _start

_start: 
        mov     edx, len        ; message length into edx
        mov     ecx, msg        ; message into ecx
        mov     ebx, 1          ; file descriptor (standard out)
        mov     eax, 4          ; system call (system write)
        int     0x80            ; call kernel
 
        mov     ebx, 0          ; process exit code
        mov     eax, 1          ; system call (system exit)
        int     0x80            ; call kernel
