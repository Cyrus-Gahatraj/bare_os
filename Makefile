ASM=nasm
ASM_FLAGS=-f bin
BUILD_DIR=build
BOOT_LOADER=src/boot_loader/boot.asm
BOOT_BIN=$(BUILD_DIR)/boot.bin

CC=gcc
FLAGS=-ffreestanding -c
KERNEL=src/kernel/kernel.c
OBJ_FILE=src/kernel/kernel.o
LINKER=ld
LINKER_FLAGS=-Ttext 0x1000 --oformat binary
KERNEL_BIN=$(BUILD_DIR)/kernel.bin

TARGET=$(BUILD_DIR)/os-image

all: $(TARGET)

$(TARGET): $(BOOT_BIN) $(KERNEL_BIN)
	cat $(BOOT_BIN) $(KERNEL_BIN) > $(TARGET)

$(BOOT_BIN): $(BOOT_LOADER) | $(BUILD_DIR)
	$(ASM) $(BOOT_LOADER) $(ASM_FLAGS) -o $@

$(OBJ_FILE): $(KERNEL)
	$(CC) $(FLAGS) $(KERNEL) -o $(OBJ_FILE)

$(KERNEL_BIN): $(OBJ_FILE)
	$(LINKER) $(LINKER_FLAGS) $< -o $@

$(BUILD_DIR): 
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR) $(KERNEL_BIN) $(OBJ_FILE)

run: $(TARGET)
	qemu-system-x86_64 -drive format=raw,file=$(TARGET) -display gtk
	
