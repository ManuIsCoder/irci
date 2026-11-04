ASM ?= rtm32.asm

.PHONY: all snake_16x10 snake_32x16 clean

all: snake_16x10.bin snake_32x16.bin

snake_16x10: snake_16x10.bin

snake_32x16: snake_32x16.bin

snake_16x10.bin: snake_16x10.rtm
	$(ASM) $< -o $@

snake_32x16.bin: snake_32x16.rtm
	$(ASM) $< -o $@

clean:
	rm -f snake_16x10.bin snake_32x16.bin
