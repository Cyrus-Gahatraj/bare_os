CC=nasm
FLAGS=-f bin
BUILD=build
SRC=src/boot_loader/boot.asm
BIN=$(BUILD)/boot.bin

all: $(BIN)

$(BIN): $(SRC)
	mkdir $(BUILD)
	$(CC) $(SRC) $(FLAGS) -o $(BIN)

clean:
	rm -rf $(BUILD)

run: $(BIN)
	qemu-system-x86_64 -drive format=raw,file=$(BIN) -display gtk
