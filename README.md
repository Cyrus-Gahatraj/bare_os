# Bare_os

A minimal operating system written in Rust for learning purposes,
from Philipp Oppermann’s [Writing an OS in Rust](https://os.phil-opp.com/) series.

## Prerequisite
- **Rust** nightly toolchain
- **QEMU** (x86_64 emulator)
- **bootimage** tool (for creating bootable disk images)

##  Target Architecture

| Field  | Meaning                           |
| ------ | --------------------------------- |
| arch   | thumb (ARM Thumb instruction set) |
| sub    | v7em (Cortex-M4 / M7)             |
| vendor | none                              |
| sys    | (bare-metal / no OS)              |
| env    | eabihf (Embedded ABI, hard-float) |


## Build Instructions
1. Adding Rust Target

```bash
rustup target add thumbv7em-none-eabihf
```

2. Build the OS kernel
```bash
cargo build --target thumbv7em-none-eabihf
```

3. Run the Kernel

```bash
cargo run
```
* Manual (using Qemu directly)
```bash
qemu-system-x86_64 -drive format=raw,file=target/x86_64-bare_os/debug/bootimage-bare_os.bin        
```