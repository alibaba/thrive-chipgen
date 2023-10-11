#/*Copyright 2020-2021 T-Head Semiconductor Co., Ltd.
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.
#*/

# the compiler toolset setting
CC      = ${TOOL_EXTENSION}/riscv64-unknown-elf-gcc
AS      = ${TOOL_EXTENSION}/riscv64-unknown-elf-as
LINK    = ${TOOL_EXTENSION}/riscv64-unknown-elf-ld
OBJDUMP = ${TOOL_EXTENSION}/riscv64-unknown-elf-objdump
OBJCOPY = ${TOOL_EXTENSION}/riscv64-unknown-elf-objcopy
CONVERT =./Srec2vmem

SSRC = $(wildcard *.S)
sSRC = $(wildcard *.s)
CSRC = $(wildcard *.c)

OBJECTS = $(SSRC:%.S=%.o) $(sSRC:%.s=%.o) $(CSRC:%.c=%.o)

FLAG_ABI = 
FLAG_MARCH = -mtune=e906 
#CPU_ARCH_FLAG_0 => CPU Arch: e906, e906f, e906d
#CPU_ARCH_FLAG_1 => DSP: dsp, nodsp 
ifeq (${CPU_ARCH_FLAG_1}, nodsp)
  ifeq (${CPU_ARCH_FLAG_0}, e906f)
    FLAG_MARCH += -march=rv32imafc
    FLAG_ABI   = -mabi=ilp32f
  else
    ifeq (${CPU_ARCH_FLAG_0}, e906d)
      FLAG_MARCH += -march=rv32imafdc
      FLAG_ABI   = -mabi=ilp32d
    else
      FLAG_MARCH += -march=rv32imac
      FLAG_ABI   = -mabi=ilp32
    endif
  endif
else 
  ifeq (${CPU_ARCH_FLAG_0}, e906f)
    FLAG_MARCH += -march=rv32imafcpzp64
    FLAG_ABI   = -mabi=ilp32f
  else
    ifeq (${CPU_ARCH_FLAG_0}, e906d)
      FLAG_MARCH += -march=rv32imafdcpzp64
      FLAG_ABI   = -mabi=ilp32d
    else
      FLAG_MARCH += -march=rv32imacpzp64
      FLAG_ABI   = -mabi=ilp32
    endif
  endif
endif
CFLAGS = ${FLAG_MARCH} ${FLAG_ABI} 

CFLAGS += -c -v -O2
CFLAGS += -I. -I ${CINC} -I ${ASMINC} -I ${SW_INCLUDE}

LINKFLAGS = -T ${LINKFILE}.lcf -nostartfiles ${FLAG_MARCH} ${FLAG_ABI} -v

LINKLIBS = -lc -lgcc

LIBFILES = $(filter-out rv_0.o rv_1.o rv_2.o rv_3.o vpu.o, $(OBJECTS))
LIBFILES += ${FILE}.o

OBJDUMPFLAGS = -S -Mnumeric

HEXFLAGS	= -O srec

%.o : %.c
	${CC} -c ${CFLAGS} -o $@ $<

%.o : %.s
	${CC} -c ${CFLAGS} -o $@ $<

%.o : %.S
	${CC} -c ${CFLAGS} -o $@ $<

${FILE}.elf : ${LIBFILES} ${LINKFILE}.lcf
	${CC} ${LINKFLAGS} ${LINKLIBS} ${LIBFILES} -o $@ -lm 

${FILE}.obj : ${FILE}.elf
	${OBJDUMP} ${OBJDUMPFLAGS} $< > $@

INST_HEX = ${FILE}_inst.hex
DATA_HEX = ${FILE}_data.hex
FILE_HEX = ${FILE}.hex

${FILE}.hex : ${FILE}.elf
	${OBJCOPY} ${HEXFLAGS} $< ${INST_HEX} -j .text*  -j .rodata* -j .eh_frame*
	${OBJCOPY} ${HEXFLAGS} $< ${DATA_HEX} -j .data*  -j .bss -j .COMMON
	${OBJCOPY} ${HEXFLAGS} $< $@ 

INST_PAT = ${FILE}_inst.pat
DATA_PAT = ${FILE}_data.pat
FILE_PAT = ${FILE}.pat

%.pat	: %.hex
	${CONVERT} ${INST_HEX} ${INST_PAT}
	${CONVERT} ${DATA_HEX} ${DATA_PAT}
	${CONVERT} ${FILE_HEX} ${FILE_PAT}


#--------------------------------------------------------------------
# target setting
.PHONY :all
all : ${FILE}.pat ${FILE}.hex ${FILE}.elf ${FILE}.obj

#---------------------------------------------------------------------
# clean some medium code and .pat
.PHONY :clean 
clean:
	rm -rf *.o *.pat  *.obj *.hex

