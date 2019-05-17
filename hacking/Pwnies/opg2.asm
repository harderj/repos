;nasm -f elf32 demo.asm
;ld -melf_i386 -o demo demo.o
;./demo


[bits 32]

section .text
global _start

_start:
push byte 0x0
push '/sh'
push '/bin'

;write to fd 1
mov eax, 0x0b
mov ebx, esp
mov ecx, 0
mov edx, 0
int 0x80

;exit
mov eax, 0x1
mov ebx, 0x0
int 0x80