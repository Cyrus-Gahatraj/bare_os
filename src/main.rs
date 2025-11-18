#![no_std] // Disabling the Rust standard Library
#![no_main] // Disabling the Rust-level entry point

use core::panic::PanicInfo;

static HELLO: &[u8] = b"Hello World!";

#[unsafe(no_mangle)]
pub extern "C" fn _start() -> ! {
    // Kernel entry point

    // VGA buffer is located at the adddress 0xb80000
    let vga_buffer = 0xb8000 as *mut u8;

    for (i, &byte) in HELLO.iter().enumerate() {
        unsafe {
            *vga_buffer.offset(i as isize * 2) = byte; // ASCII byte 
            *vga_buffer.offset(i as isize * 2 + 1) = 0xb; // Color byte
        }
    }

    loop {}
}

/// This function is called on panic.
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
