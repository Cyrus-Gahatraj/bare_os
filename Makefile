CC=nasm
FLAGS=-f bin
BUILD_DIR=build
SRC=src/boot_loader/boot.asm
TARGET=$(BUILD_DIR)/boot.bin

all: $(TARGET)

$(TARGET): $(SRC) | $(BUILD_DIR)
	$(CC) $(SRC) $(FLAGS) -o $(TARGET)

$(BUILD_DIR): 
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)

run: $(TARGET)
	qemu-system-x86_64 -drive format=raw,file=$(TARGET) -display gtk
	
