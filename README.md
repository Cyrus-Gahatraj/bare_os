# Bare_os

A minimal operating system written in Rust for learning purposes,
from Philipp Oppermann’s [Writing an OS in Rust](https://os.phil-opp.com/) series.

## Prerequisite
- **Rust** nightly toolchain
- **QEMU** (x86_64 emulator)
- **bootimage** tool (for creating bootable disk images)
- **llvm tool** to build the bootimage from [x86_64-bare_os.json](https://github.com/Cyrus-Gahatraj/bare_os/blob/main/x86_64-bare_os.json)
    ```bash
    rustup component add llvm-tools-preview
    ```


## Build Instructions
1. Building the kernel
```bash
cargo build 
```

2. Run the Kernel
- Run using Cargo (Recommended)
```bash
cargo run
```
- Run manually (using Qemu directly)
```bash
qemu-system-x86_64 -drive format=raw,file=target/x86_64-bare_os/debug/bootimage-bare_os.bin        
```
