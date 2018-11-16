
section .text

global  _start

_start:
        xor     eax,    eax
        push    eax
        push    0x68732f2f      ; push /bin//sh
        push    0x6e69622f
        mov     ebx,    esp     ; set ebx to out cmd
        mov     ecx,    eax     ; no args
        mov     edx,    eax     ; no args
        mov     al,     0xb     ; set sys_execve (executes the program pointed to by filename)
        int     0x80
