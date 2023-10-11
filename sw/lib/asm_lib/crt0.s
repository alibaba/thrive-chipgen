/*Copyright 2020-2021 T-Head Semiconductor Co., Ltd.

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
.text
.global	__start
__start:


#enable btb & bht
#  csrr x3, mhcr
#  ori x3, x3, 0x20
#  csrw mhcr, x3
#
#  li x3, 0x1000
#  csrrs x0, mhcr, x3

#la x3, 0x20000
  la  x2, __kernel_stack
#Init_Stack:
#
#  sw x0, 0(x2)
#  addi x2, x2, -4
#  addi x3, x3, -4
#  bnez x3, Init_Stack

#  la x3, __erodata
#  la x4, __data_start__
#  la x5, __data_end__
#
#  sub x5, x5, x4
#  beqz x5, L_loop0_done
#
#L_loop0:
#   lw x6, 0(x3)
#   sw x6, 0(x4)
#   addi x3, x3, 0x4
#   addi x4, x4, 0x4
#   addi x5, x5, -4
#   bnez x5, L_loop0
#
#L_loop0_done:
#   la x3, __data_end__
#   la x4, __bss_end__
#
#   li x5, 0
#   sub x4, x4, x3
#   beqz x4, L_loop1_done
#
#L_loop1:
#   sw x5, 0(x3)
#   addi x3, x3, 0x4
#   addi x4, x4, -4
#   bnez x4, L_loop1  
#
#
#L_loop1_done:
#  
#  la x3, trap_handler
#  csrw mtvec, x3
#
#  la x3, vector_table
#  addi x3, x3, 64
#  csrw mtvt, x3
#
#
#  li a5, 0xeffff000
#  li a6, 0x20000
#  sw a6, 0(a5)
#  li a7, 0xc
#  sw a7, 4(a5)
#
#  li a6, 0x40000
#  li a7, 0xc
#  sw a6, 8(a5)
#  sw a7, 12(a5)
#  
#  li a6, 0x50000
#  li a7, 0x10
#  sw a6, 16(a5)
#  sw a7, 20(a5)
#
#  li a5, 0x40011000
#  li a6, 0xff
#  sw a6, 0(a5)
#  li a6, 0x3
#  sw a6, 8(a5)
#  lw a6, 4(a5)


# enable mie
  li   x3,0x88 
  csrw mstatus,x3

# enable fpu
  li x3, 0x2000
  csrs mstatus,x3

  li   x3,0x103f
  csrw mhcr,x3
  li   x3,0x400c
  csrw mhint,x3
  
__to_main:
  jal main


  .global __exit
__exit:
  fence.i
  fence
  nop

  .global __fail
__fail:
  fence.i
  fence
  nop

  .align 6  
  .global trap_handler
trap_handler:
  j __synchronous_exception
  .align 2  
  j __fail
 
__synchronous_exception:
  sw   x13,-4(x2)
  sw   x14,-8(x2)
  sw   x15,-12(x2)
  csrr x14,mcause
  andi x15,x14,0xff  #cause
  srli x14,x14,0x1b   #int
  andi x14,x14,0x10   #mask bit
  add  x14,x14,x15    #{int,cause}

  slli x14,x14,0x2  #offset
  la   x15,vector_table
  add  x15,x14,x15  #target pc
  lw   x14, 0(x15)  #get exception addr
  lw   x13, -4(x2)  #recover x16
  lw   x15, -12(x2) #recover x15
#addi x14,x14,-4
  jr   x14


  .global vector_table
  .align  6
vector_table:	#totally 256 entries
	.rept   256
	.long   __dummy
	.endr

  .global __dummy
__dummy:  
  j __fail
  
  .data
  .long 0
