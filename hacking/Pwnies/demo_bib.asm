;compile: nasm -f elf32 demo_bib.asm
;link med gcc -m32 demo_bib.o -o demo_bib

[bits 32]

global main
;import printf
extern printf

section .text
main:
;call printf
push str;
call printf

mov eax, 0x1
mov ebx, 0x0
int 0x80

section .data
str: db 'hello world', 0xa, 0x0
