ASM=nasm
ASM_FLAGS_OBJ=-f elf64 
ASM_FLAGS_BIN=-f bin

CC=gcc
CFLAGS=-ffreestanding -c 

BUILD_DIR=build
KERNEL_DIR=src/kernel

# Files
BOOT_LOADER=src/boot_loader/boot.asm
BOOT_BIN=$(BUILD_DIR)/boot.bin

ENTRY_SRC=$(KERNEL_DIR)/entry.asm
ENTRY_OBJ=$(KERNEL_DIR)/entry.o

KERNEL_SRC=$(KERNEL_DIR)/kernel.c
KERNEL_OBJ=$(KERNEL_DIR)/kernel.o

KERNEL_BIN=$(BUILD_DIR)/kernel.bin
TARGET=$(BUILD_DIR)/os-image

# Linker
LINKER=ld
LINKER_FLAGS=-Ttext 0x1000 --oformat binary

# qemu
QEMU=qemu-system-x86_64

all: $(TARGET)

$(TARGET): $(BOOT_BIN) $(KERNEL_BIN)
	cat $^ > $(TARGET)

$(BOOT_BIN): $(BOOT_LOADER) | $(BUILD_DIR)
	$(ASM) $< $(ASM_FLAGS_BIN) -o $@

$(ENTRY_OBJ): $(ENTRY_SRC)
	$(ASM) $< $(ASM_FLAGS_OBJ) -o $@

$(KERNEL_OBJ): $(KERNEL_SRC)
	$(CC) $(CFLAGS) $< -o $@

$(KERNEL_BIN): $(ENTRY_OBJ) $(KERNEL_OBJ)
	$(LINKER) $(LINKER_FLAGS) $^ -o $@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR) $(OBJ_FILES)

run: $(TARGET)
	$(QEMU) -drive format=raw,file=$< -display gtk
	
