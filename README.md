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

### Running on Windows Ubuntu Bash

Because Docker is not supported on Windows Ubuntu, we will install a dummy `docker` command to intervene manually during the build. Run these commands inside `pxt-maker`:

```bash
chmod +x scripts/docker
sudo cp scripts/docker /usr/local/bin/
pxt serve --localbuild --no-browser
```

The build will pause at the `docker` step like this:
```log
building libs/base
building libs/core
building libs/core---stm32bluepill
building libs/stm32bluepill
[run] cd built/dockercodal; docker run --rm -v /mnt/c/maker.makecode.com/pxt-maker/libs/stm32bluepill/built/dockercodal/:/src -w /src -u build pext/yotta:latest python build.py
***** Paused in dummy docker script. Press Enter to continue build...
```

Look for the folder name before `:/src`. In a new shell, manually `cd` to the folder and continue the build in that folder like this:
```bash
cd /mnt/c/maker.makecode.com/pxt-maker/libs/stm32bluepill/built/dockercodal/
export VERBOSE=1
python build.py
```

Eventually the `libs/stm32bluepill` build will succeed...
```log
Entering directory `/mnt/c/maker.makecode.com/pxt-maker/libs/stm32bluepill/built/dockercodal/build'
[ 99%] converting to hex file.
...
[100%] converting to bin file.
...
[100%] Built target STM32_BLUE_PILL_hex
[100%] Built target STM32_BLUE_PILL_bin
```

Return to the `pxt-maker` shell and press Enter.  It will continue the build.

When the build pauses in a different folder like `libs/blocksprj/built/dockercodal`, repeat the above steps to run `python build.py` in the paused folder.

Here are the folders that require manual building:

```
pxt-maker/libs/stm32bluepill/built/dockercodal
pxt-maker/libs/blocksprj/built/dockercodal
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
