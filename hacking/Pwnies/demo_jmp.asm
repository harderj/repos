;nasm -f elf32 demo_jmp.asm
;ld -melf_i386 -o demo_jmp demo_jmp.o
;./demo


[bits 32]

section .text
global _start


_start:
;load counter to the lower part of eax
mov al, [counter]

;beginning of loop
loop:
;if counter > 9 then exit
cmp al, 0x9
ja exit 
;write to fd 1
mov eax, 0x4
mov ebx, 0x1
mov ecx, str
mov edx, 0xb
int 0x80

;increment counter
mov al, [counter]
add al, 1
mov [counter], al

;jump back to the comparison
jmp loop
;out of the loop

exit:
mov eax, 0x1
mov ebx, 0x0
int 0x80

section .data
str: db 'hej verden', 0x0a
counter: db 0x0
