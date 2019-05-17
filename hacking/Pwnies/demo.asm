;nasm -f elf32 demo.asm
;ld -melf_i386 -o demo demo.o
;./demo


[bits 32]

section .text
global _start


_start:
;write to fd 1
mov eax, 0x4
mov ebx, 0x1
mov ecx, str
mov edx, 0xb
int 0x80

;exit
mov eax, 0x1
mov ebx, 0x0
int 0x80

section .data
str: db 'hej verden', 0x0a

