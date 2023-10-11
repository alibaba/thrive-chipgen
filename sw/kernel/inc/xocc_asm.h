/* 
*Copyright (c) 2021, Alibaba Group;
*Licensed under the Apache License, Version 2.0 (the "License");
*you may not use this file except in compliance with the License.
*You may obtain a copy of the License at

*   http://www.apache.org/licenses/LICENSE-2.0

*Unless required by applicable law or agreed to in writing, software
*distributed under the License is distributed on an "AS IS" BASIS,
*WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*See the License for the specific language governing permissions and
*limitations under the License.
*/

#ifndef XOCC_ASM_H
#define XOCC_ASM_H

#define _IMM12(word, queue) 0x ## word ## queue
#define _STR(token) #token
#define IMM12(word, queue) _IMM12(word, queue)

#define FUNC_PUSH_RDY(result,data,imm12) ( { \
 asm volatile(\
 "push_rdy %[rd],%[rs1]," _STR(imm12) \
 : [rd] "=r"(result) \
 : [rs1] "r" (data)); } )

#define FUNC_POP_RDY(result,data,imm12) ( { \
 asm volatile(\
 "pop_rdy %[rd],%[rs1]," _STR(imm12) \
 : [rd] "=r"(result) \
 : [rs1] "r" (data)); } )

#define FUNC_PUSH_CMD(result,data,imm12) ( { \
 asm volatile(\
 "push_cmd %[rd],%[rs1]," _STR(imm12) \
 : [rd] "=r"(result) \
 : [rs1] "r" (data)); } )

#define FUNC_POP_RSP(result,data,imm12) ( { \
 asm volatile(\
 "pop_rsp %[rd],%[rs1]," _STR(imm12) \
 : [rd] "=r"(result) \
 : [rs1] "r" (data)); } )

#define FUNC_WRITE_CMD(result,data,imm12) ( { \
 asm volatile(\
 "write_cmd %[rd],%[rs1]," _STR(imm12) \
 : [rd] "=r"(result) \
 : [rs1] "r" (data)); } )

#define FUNC_READ_RSP(result,data,imm12) ( { \
 asm volatile(\
 "read_rsp %[rd],%[rs1]," _STR(imm12) \
 : [rd] "=r"(result) \
 : [rs1] "r" (data)); } )

#endif
