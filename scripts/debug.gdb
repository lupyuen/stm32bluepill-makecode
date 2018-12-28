# GDB script for debugging programs in STM32 Blue Pill.

# Set architecture to ARM 32-bit. Needed for gdb-multiarch on Ubuntu.
set architecture arm

# Send GDB commands to OpenOCD, which listens on port 3333.  Extend the timeout.
set remotetimeout 100000
# target remote :3333
target remote :1234

# Disable all messages.
# set verbose off
# set complaints 0
# set confirm off
# set exec-done-display off
# show exec-done-display
# set trace-commands off
# set debug displaced off 
# set debug expression 0
# set debug frame 0
# set debug infrun 0
# set debug observer 0
# set debug overload 0
# set pagination off
# set print address off
# set print symbol-filename off
# set print symbol off
# set print pretty off
# set print object off
# set debug parser off
# set debug remote 0

# Print demangled symbols by default.
set print asm-demangle on

# Enable ARM semihosting to show debug console output in OpenOCD console.
# monitor arm semihosting enable

# Reset the device.
# monitor reset init
# monitor reset
# monitor sleep 1000
# monitor halt
# monitor sleep 1000

# Rewrite pathnames from /mnt/c/stm32bluepill-makecode/... to ./...
set substitute-path /mnt/c/stm32bluepill-makecode .
set substitute-path /src/libraries ./pxt-maker/projects/blink/built/dockercodal/libraries

# Specify the target program to be debugged.  Must be specified here (not the command line) otherwise the break command below will not work.
file pxt-maker/projects/blink/built/dockercodal/build/STM32_BLUE_PILL

# Load the above program into device memory.  Note: This will overwrite the memory used by the program specified at command line.
# load

# Set breakpoint at the main() function.
# break main

# Run the program and stop at the main() function.
# continue

# Remove the breakpoint at the main() function.
# clear stm32_blue_pill_rust::main

# Step into the first line of the main() function. Else gdb will complain about "entry macros" file missing.
# step
