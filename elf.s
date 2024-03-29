/*
Copyright 2019 - 2021 VegaASM

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

#~~~~~~~~~~~#
# START ELF #
#~~~~~~~~~~~#

#

#~~~~~~~~~~~~#
# ELF HEADER #
#~~~~~~~~~~~~#

ehdr:

    #Elf Magic#
    
    .long 0x7F454C46 #Elf magic "0x7F ELF" aka EI_MAG0, EI_MAG1, EIMAG2, EIMAG3
    
    #Elf Identifier#
    
    .byte 0x01 #ei_class, 0 = Invalid, 1 = 32 bit, 2 = 64 bit
    .byte 0x02 #ei_data, Bit Encoding. 0 = Invalid, 1 = Little Endian (LSB), 2 = Big Endian (MSB)
    .byte 0x01 #ei_version, Read e_version below. HBC requires this to always be 1
    .byte 0x00 #ei_osabi, OS or ABI specific Elf extensions. HBC doesn't care about this byte
    
    #Elf Padding#

    #e_ident_pad not used/read by HBC, Let's place the start point here, we have room for two instructions
_start:
    lis r3, 0xCD80
    b continue_code
        
    #Elf Contents for Machine, Version, and Point of Entry#

    .short 0x0002 #e_type, Elf Type. 2 = Executable
    .short 0x0014 #e_machine, Machine Architecture. 0x14 = PowerPC

    .long 0x00000001 #e_version, Elf Version 1 for Current. 0 = Invalid, 2+ = Version Num Increase. HBC requires this to always be 1

    .long 0x80004000 #e_entry, Entry Point Address, where assembler contents will be placed into Virtual Memory
    
    #Elf Contents for Flags, Program Headers, and Section Headers#

    .long phdr_off #e_phoff, Offset from start of ELF to 1st Program Header
    .long 0x00000000 #e_shoff, Address Offset to 1st Section Header, leave Null since no Section Headers are used
    
    .long 0x80000000 #e_flags, OS Specific Flags for the Elf Header, PowerPC embedded flag is 0x80000000 but HBC doesn't care about this value

    .short ehdrsize #e_ehsize, size in bytes of ELF Header
    .short phdrsize #e_phentsize, size in bytes of Program Header

    .short 0x0001 #e_phnum, Amount of program headers
    .short 0x0000 #e_shentsize, 1st Section Header size, Null since no Section Headers are used
    
    .short 0x0000 #e_shnum, Amount of Section Headers
    .short 0x0000 #e_shstrndx, Address Offset to a specific Section Header within the Sectino Header Table

    ehdrsize = $ - ehdr #This macro calculates the size of the Elf Header in Bytes

#~~~~~~~~~~~~~~~~#
# PROGRAM HEADER #
#~~~~~~~~~~~~~~~~#

    phdr_off = phdr - ehdr #This macro calculates the e_phoff value in the Elf Header
    start_off = _start - ehdr #This macro calculates the p_offset value in the Program Header

phdr:

    .long 0x00000001 #p_type aka p_load, The type of Program Loader. When this is set to 1, HBC then knows this is the program header that will have the p_offset value that points to entry point of assembly execution
    .long start_off #p_offset, Offset to next Program Header. However since this is the program header with the p_load value of 1, this must be set to the offset from start of ELF to where beginning of the assembler contents are located at
    .long 0x80004000 #p_vaddr, Virtual Address to start of Program Header, put Virtual entry point if only 1 Header is used
    .long 0x00004000 #p_paddr, Physical Address to start of Program header, put Physical entry point if only 1 Header is used

    .long filesize #p_filesz, Program Header needs the File Size
    .long filesize #p_memsz, Program Header needs the Memory Size

    .long 0x00000005 #p_flags, OS Specific Flags for the Program Header. 1 (Readable) OR'd 4 (Executable) = 5. Do NOT set the Writeable flag (2) or else the program header will be used as a data section instead of a text section
    .long 0x00000000 #p_align, Align the Program Header. No alignment needed for this source

    phdrsize = $ - phdr #This macro calculates the size of the Program Header in Bytes

#~~~~~~~~~~~~~~~~~~~~#
# ASSEMBLER CONTENTS #
#~~~~~~~~~~~~~~~~~~~~#

    continue_code:
    li r4, 0x0020
    stw r4, 0x00C0 (r3) #Let an exception occur, just need the disc drive to be lit
        
#~~~~~~~~~~~#
# FILE SIZE #
#~~~~~~~~~~~#

    filesize = $ - ehdr #This macro calculates the size of the entire ELF file in Bytes

#

#~~~~~~~~~#
# END ELF #
#~~~~~~~~~#
