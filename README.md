# V-Elf-Disc-Drive-Lighter
A tiny PPC Elf file (entirely handwritten from scratch) that will initiate the disc drive light on the Wii. The Elf file size is only 0x64 bytes!

Requirements: HBC version 1.1.0 or later (elf will NOT run from Bootmii)

Version: 0.3

Author: Vega

V-Elf = Handwritten PPC Wii ELF file by VegaASM (Vega of MKWii.com)

HOW TO COMPILE:

1. Use PyiiASMH (RAW ASM option) to compile elf.s. Currently, the source has not been tested for compilation on devkitPPC binutils.

2. Once compiled, make a binary file (named boot.elf) on a Hex Editor using the compiled byte code.

3. Drag boot.elf into /hbc folder. Place /hbc folder in the /apps folder of your SD/USB. Launch HBC. Select the V-Elf-Disc-Drive-Lighter app, launch it. To stop the app, you will need to reboot your Wii manually.

NOTE: Alternate method to compile (using devkitPPC binutils on linux)
- cd /whereyouinstalleddevkitinto/devkitpro/devkitPPC/bin
- ./powerpc-eabi-as -mregnames -mbroadway /home/yourusername/V-Elf-Disc-Drive-Lighter-master/elf.s -o /home/yourusername/V-Elf-Disc-Drive-Lighter-master/elf.o
- ./powerpc-eabi-objcopy -O binary /home/yourusername/V-Elf-Disc-Drive-Lighter-master/elf.o /home/yourusername/V-Elf-Disc-Drive-Lighter-master/boot.elf

History:

Apr 1, 2021 - Minor fix (had a virtual address listed for p_paddr, fixed it)

Aug 31, 2019 - Initial Release (v0.1)

Feb 28, 2020 - Elf Size cut down to 0x64 bytes (v0.2)
