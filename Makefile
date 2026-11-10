TARGET := MAIN

OPT := -Og -g3

BUILD_DIR := build


C_SOURCES := src/main.c

ASM_SOURCES := startup/startup_stm32h743xx.s

CC := arm-none-eabi-gcc
AS := arm-none-eabi-gcc -x assembler-with-cpp
CP := arm-none-eabi-objcopy
SZ := arm-none-eabi-size

CPU := -mcpu=cortex-m7

FPU := -mfpu=fpv5-sp-d16

FLOAT_ABI := -mfloat-abi=hard

MCU := $(CPU) -mthumb $(FPU) $(FLOAT_ABI)

C_DEFS = -DUSE_PWR_LDO_SUPPLY \
				 -DSTM32H743xx

C_INCLUDES = -Ithird_party/CMSIS/Core \
						 -Ithird_party/CMSIS/Device \
						 -Isrc

AS_DEFS := 
AS_INCLUDES :=

ASFLAGS := $(MCU) $(AS_DEFS) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

CFLAGS := $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -Wextra -fdata-sections -ffunction-sections -MMD -MP \
					-std=gnu11

OBJECTS := $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))

vpath %.c src
vpath %.s startup

all: $(OBJECTS)

$(BUILD_DIR)/%.o: %.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: %.s | $(BUILD_DIR)
	$(AS) $(ASFLAGS) -c $< -o $@

$(BUILD_DIR):
	mkdir $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean

-include $(wildcard $(BUILD_DIR)/*.d)

