
%include 	'../functions.asm'

section .data

msg         db      'NO VM DETECTED!', 0xA, 0x0
len         equ     $-msg

vm_msg      db      'VM DETECTED!', 0xA, 0x0
vm_msg_len  equ     $-vm_msg

section .text

global _start

_start:
    xor     eax, eax
    inc     eax
    cpuid
    bt      ecx, 0x1f   ; the 31st bit of ECX on a physical machine will be equal to 0. On a guest VM it will equal to 1.
    jc      _yesVM      ; call function if vm is detected

_noVM:                  ; ; no vm detected
    mov     eax, msg
    jmp     _printAndExit

_yesVM:                 ; vm detected
    mov     eax, vm_msg
    jmp     _printAndExit

_printAndExit:
    call    sprint
    call    quit