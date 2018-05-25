
%macro print 2              ; macro name and # of args

        mov     edx, %2
        mov     ecx, %1
        mov     ebx, 1
        mov     eax, 4
        int     0x80

%endmacro

section .text

        global _start

_start:
        print   msg1, len1  ; call macro with args
        print   msg2, len2
        print   msg3, len3

        mov     eax, 1      ; sys exit call
        mov     ebx, 0
        int     0x80

section .data

msg1    db  'Somebody', 0x0A
len1    equ $-msg1

msg2    db  'once', 0x0A
len2    equ $-msg2

msg3    db  'told me', 0x0A
len3    equ $-msg3

