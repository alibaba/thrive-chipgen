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

#ifndef DSA_H
#define DSA_H
#endif

#include "xocc_asm.h"
#include "qid.h"

// [TODO] Currently, Only support homogeneous auto-generation

% if chip.type == "homogeneous":
<% pe = pes[0] %>\
    % for ind, rv in enumerate(pe.rvs.dispatcher + pe.rvs.regular):
        % for qid, dat in rv.qid_map.items():
/*
 * ${rv.name} -> ${dat[1]}
 */
<%
push_cnt = int(dat[0][0]/32)
pop_cnt = int(dat[0][1]/32)
str_push_list = []
str_pop_list = []
for i in range(push_cnt):
    str_push_list.append("unsigned int w" + str(i))
for i in range(pop_cnt):
    str_pop_list.append("unsigned int *w" + str(i))
str_push_cmd = ", ".join([str(e) for e in str_push_list])
str_pop_rsp = ", ".join([str(e) for e in str_pop_list])
%>\
static inline void ${rv.name}_push_${dat[1]}_cmd(${str_push_cmd}){
    unsigned int result;
    unsigned int ready = 0;
    % for i in range(push_cnt):
    FUNC_WRITE_CMD(result, w${i}, IMM12(${"{:0>2d}".format(i)}, RV_${ind}_QID_${qid}));
    % endfor
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, RV_${ind}_QID_${qid})); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, RV_${ind}_QID_${qid}));
}

static inline void ${rv.name}_pop_${dat[1]}_rsp(${str_pop_rsp}){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, RV_${ind}_QID_${qid}));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, RV_${ind}_QID_${qid}));
    % for i in range(pop_cnt):
    FUNC_READ_RSP(*w${i}, result, IMM12(${"{:0>2d}".format(i)}, RV_${ind}_QID_${qid}));
    % endfor
}

        % endfor
    % endfor
% endif
