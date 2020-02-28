# V-Elf-Disc-Drive-Lighter
A tiny PPC Elf file (entirely handwritten from scratch) that will initiate the disc drive light on the Wii. The Elf file size is only 0x64 bytes!

Version: 0.2

Author: Vega

V-Elf = Handwritten PPC Wii ELF file by VegaASM (Vega of MKWii.com)

HOW TO COMPILE:

1. Use PyiiASMH (RAW ASM option) to compile elf.s. Currently, the source has not been tested for compilation on devkitPPC binutils.

2. Once compiled, make a binary file (named boot.elf) on a Hex Editor using the compiled byte code.

3. Drag boot.elf into /hbc folder. Place /hbc folder in the /apps folder of your SD/USB. Launch HBC. Select the V-Elf-Disc-Drive-Lighter app, launch it. To stop the app, you will need to reboot your Wii manually.

History:

Aug 31, 2019 - Initial Release
Feb 28, 2020 - Elf Size cut down to 0x64 bytes
