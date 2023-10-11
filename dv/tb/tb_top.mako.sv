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

// *****************************************************************************
// FILE NAME       : tb_top.sv
// AUTHOR          : Linyong Huang
// FUNCTION        : top testbench
// *****************************************************************************
`timescale 1ps/1ps
`include "tb_define.h"

module tb_top();

// Reset Gen
`include "tb_reset.sv"

// Clock Gen
`include "tb_clock.sv"

// Mem Init
`include "tb_mem_init.sv"

// User Function
`include "tb_func.sv"

// DUT Init
thrive_top_wrapper dut (
% for i, pe in enumerate(chip.pe):
    .${pe.name}_sys_clk (clk),
    % if i == len(chip.pe) - 1:
    .${pe.name}_sys_rstn (sys_rstn)
    % else:
    .${pe.name}_sys_rstn (sys_rstn),
    % endif
% endfor
);

// Finish Condition Control 
`include "tb_finish_mnt.sv"

endmodule
