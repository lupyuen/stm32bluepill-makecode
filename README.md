# stm32bluepill-makecode: MakeCode for STM32 Blue Pill
MakeCode visual programming tool for STM32 Blue Pill based on libopencm3

This is an experimental code editor for STM32 Blue Pill - try it at https://lupyuen.github.io/pxt-maker

* See https://medium.com/@ly.lee/work-in-progress-stm32-blue-pill-visual-programming-with-makecode-codal-and-libopencm3-422d308f252e
* [Read the docs](https://maker.makecode.com/about)

### Setup

1. Make sure you installed the GNU Toolchain for Windows / Mac / Linux: https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads

1. On Windows, use the Windows Ubuntu bash shell: https://docs.microsoft.com/en-us/windows/wsl/about

1. Install [Node.js](https://nodejs.org/) 8.9.4 or higher.

1. Install [ninja](https://ninja-build.org/). For Ubuntu and Windows Ubuntu, run `sudo apt install ninja-build`

1. For Mac and Linux: Install [Docker](https://www.docker.com/). For Ubuntu (but not Windows Ubuntu), run `sudo apt install docker.io`. Do not install Docker for Windows.

1. Clone the `stm32bluepill-makecode` super-repository, which includes `pxt, pxt-common-packages` and `pxt-maker`.

       git clone --recurse-submodules https://github.com/lupyuen/stm32bluepill-makecode
       cd stm32bluepill-makecode

1. Install the dependencies of ``pxt`` and build it

       cd pxt
       npm install
       npm run build
       cd ..

1. Install the ``pxt-common-packages`` repository

       cd pxt-common-packages
       npm install
       cd ..

1. Install the pxt-maker dependencies.

       cd pxt-maker
       npm install

1. Install the PXT command line

       npm install -g pxt

1. Link pxt-maker back to base pxt repo

       npm link ../pxt
       npm link ../pxt-common-packages
       
Note the above command assumes the folder structure of   

```
       stm32bluepill-makecode
          |
  ----------------------------------
  |       |                        |
 pxt      pxt-common-packages  pxt-maker
```

### Running

Run this command from inside `pxt-maker` to open a local web server
```
pxt serve --localbuild 
```
If the local server opens in the wrong browser, make sure to copy the URL containing the local token. 
Otherwise, the editor will not be able to load the projects.

While fixing the build you may suppress the browser like this:
```
pxt serve --localbuild --no-browser
```

Because Docker is not supported on Windows Ubuntu, and the build runs on faster on macOS without Docker, set the following environment variables to disable Docker:

```
export PXT_DEBUG=1          # - display extensive logging info
export PXT_FORCE_LOCAL=1    # - compile C++ on the local machine, not the cloud service
export PXT_NODOCKER=1       # - don't use Docker image, and instead use host's arm-none-eabi-gcc (doesn't apply to Linux targets)
export PXT_RUNTIME_DEV=     # - DISABLED: always rebuild the C++ runtime, allowing for modification in the lower level runtime if any
export PXT_ASMDEBUG=1       # - embed additional information in generated binary.asm file
```

You may find these build and debugging scripts useful:

https://github.com/lupyuen/pxt-maker/tree/master/scripts

The build scripts are also accessible as Visual Studio Code tasks when you open the workspace files `stm32bluepill-makecode/build.code-workspace` (for faster builds, with Intellisense disabled) or `stm32bluepill-makecode/workspace.code-workspace` (for easier coding, with Intllisense enabled):

https://github.com/lupyuen/stm32bluepill-makecode/blob/master/.vscode/tasks.json

### Building the Blink sample

In the `pxt-maker` folder enter these commands:

```
cd projects/blink
./build.sh
cd ../..
```

This creates a ROM file `projects/blink/built/flash.bin` that contains the ROM image of the Blink executable.  You may flash the Blue Pill to run it, or run it with the `qemu_stm32` emulator.

The ELF file (before linking with the Blink code) is located in `pxt-maker/projects/blink/built/codal/build/STM32_BLUE_PILL`. To dump the contents of the file:

```
arm-none-eabi-objdump -t -S projects/blink/built/codal/build/STM32_BLUE_PILL >STM32_BLUE_PILL.dump
```

### Updates

Make sure to pull changes from all repos regularly. More instructions are at https://github.com/Microsoft/pxt#running-a-target-from-localhost

## Repos 

This pxt target for STM32 Blue Pill depends on several other repos. The main ones are:
- https://github.com/lupyuen/pxt-maker, MakeCode target for STM32 Blue Pill
- https://github.com/lupyuen/codal-libopencm3, CODAL framework ported to libopencm3 for STM32 Blue Pill
- https://github.com/Microsoft/pxt, the PXT framework
- https://github.com/Microsoft/pxt-common-packages, common APIs accross various MakeCode editors
- https://github.com/lancaster-university/codal-core, CODAL core project
