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

//////////////////////////////////////////////////////////////////////////////
// Author: Zhe Zhang
// 
// General XoCC API: Can be used for heterogenous kernel development
// push API: push_{cmd_len}_{qid}
// pop API: pop_{cmd_len}_{qid}
//
//////////////////////////////////////////////////////////////////////////////

#include "xocc_asm.h"
<%
cmd_len_max = 96
qid_max = 5 
%>\

/*
 * Push
 */
% for cmd_len in range(1, int(cmd_len_max/32)+1):
    % for qid in range(qid_max):
<%
str_list = []
for i in range(cmd_len):
    str_list.append("unsigned int w" + str(i))
str_input = ", ".join([str(e) for e in str_list])
%>\
static inline void push_${int(cmd_len*32)}_${qid}(${str_input}){
    unsigned int result;
    unsigned int ready = 0;
    % for i in range(cmd_len):
    FUNC_WRITE_CMD(result, w${i}, IMM12(${"{:0>2d}".format(i)}, ${qid}));
    % endfor
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, ${qid})); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, ${qid}));
}

    % endfor
% endfor
/*
 * Pop
 */
% for cmd_len in range(1, int(cmd_len_max/32)+1):
    % for qid in range(qid_max):
<%
str_list = []
for i in range(cmd_len):
    str_list.append("unsigned int *w" + str(i))
str_input = ", ".join([str(e) for e in str_list])
%>\
static inline void pop_${int(cmd_len*32)}_${qid}(${str_input}){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, ${qid}));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, ${qid}));
    % for i in range(cmd_len):
    FUNC_READ_RSP(*w${i}, result, IMM12(${"{:0>2d}".format(i)}, ${qid}));
    % endfor
}

    % endfor
% endfor