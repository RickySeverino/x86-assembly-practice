all: main

main.o: main.asm
	nasm -f elf main.asm

main: main.o
	ld -m elf_i386 -o main main.o

.PHONY: clean
clean:
	rm main.o
	rm main
.PHONY: raw
raw:
	printf '\\x'
	printf '\\x' && objdump -d main | grep "^ " | cut -f2 | tr -d ' ' | tr -d '\n' | sed 's/.\{2\}/&\\x /g'| head -c-3 | tr -d ' ' && echo ' '