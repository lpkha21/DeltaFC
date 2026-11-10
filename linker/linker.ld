ENTRY(Reset_Handler)

MEMORY
{
    FLASH (rx)        : ORIGIN = 0x08000000, LENGTH = 512K
    FLASH_CONFIG (r)  : ORIGIN = 0x08160000, LENGTH = 128K

    ITCM_RAM (rwx)    : ORIGIN = 0x00000000, LENGTH = 64K
    DTCM_RAM (rwx)    : ORIGIN = 0x20000000, LENGTH = 128K
    RAM (rwx)         : ORIGIN = 0x24000000, LENGTH = 512K
    D2_RAM (rwx)      : ORIGIN = 0x30000000, LENGTH = 256K /* SRAM1 + SRAM2 */
}

REGION_ALIAS("FASTRAM", DTCM_RAM)

_estack = ORIGIN(DTCM_RAM) + LENGTH(DTCM_RAM);

__config_start = ORIGIN(FLASH_CONFIG);
__config_end = ORIGIN(FLASH_CONFIG) + LENGTH(FLASH_CONFIG);

_Min_Heap_Size = 0;
_Min_Stack_Size = 0x800; /* required amount of stack */



