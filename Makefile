CC=nasm
FLAGS=-f bin
SRC=boot_sec.asm
BIN=boot_sec.bin

all: $(BIN)

$(BIN): $(SRC)
	$(CC) $(SRC) $(FLAGS) -o $(BIN)

clean:
	rm -f $(BIN)

run: $(BIN)
	qemu-system-x86_64 -drive format=raw,file=$(BIN) -display gtk
