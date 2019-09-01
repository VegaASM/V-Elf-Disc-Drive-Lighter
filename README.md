# V-Elf-Disc-Drive-Lighter
A tiny PPC Elf file (entirely handwritten from scratch) that will initiate the disc drive light on the Wii.

Version: 0.1

Author: Vega

Build Date: Aug 31, 2019

V-Elf = Handwritten PPC Wii ELF file by VegaASM (Vega of MKWii.com)

HOW TO COMPILE:

1. Use PyiiASMH (RAW ASM option) to compile elf.s. Currently, the source will NOT compile on devkitPPC binutils.

2. Once compiled, make a binary file (named boot.elf) on a Hex Editor using the compiled byte code.

3. Drag boot.elf into /hbc folder. Place /hbc folder in the /apps folder of your SD/USB. Launch HBC. Select the V-Elf-Disc-Drive-Lighter app, launch it.
