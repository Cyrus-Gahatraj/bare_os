#![no_std] // Disabling the Rust standard Library
#![no_main] // Disabling the Rust-level entry point

mod vga_buffer;

use core::panic::PanicInfo;

#[unsafe(no_mangle)]
pub extern "C" fn _start() -> ! {
    // Kernel entry point
    println!("Hello World{}", "!");
    loop {}
}

/// This function is called on panic.
#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    println!("{}", info);
    loop {}
}
