;nasm -f elf32 demo.asm
;ld -melf_i386 -o demo demo.o
;./demo

[bits 32]
	
xor edx, edx
push edx
push word '-l'
mov edx, esp

xor ebx, ebx
push ebx
push byte 's'
push word '/l'
push '/bin'
mov ebx, esp

xor ecx, ecx
push ecx
push edx
push ebx
mov ecx, esp

xor eax, eax
mov al, 0xb

xor edx, edx

int 0x80