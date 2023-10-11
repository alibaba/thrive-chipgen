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

// Ref Model
`define NOISA

// Path Define
// Top 
`define TB                      tb_top
`define DUT                     `TB.dut
`define SHELL                   `DUT.shell
`define PCI_EP                  `SHELL.qdma_pcie_sys.qdma_0.inst

% if chip.type == "homogeneous":
    % for pe in chip.pe:
<% PE = pe.name.upper() %>\
// ${PE}
`define ${PE} `DUT.x_pe_array_top.x_${pe.name}_pe_top
`define ${PE}_SPM `${PE}.x_mem_sub_sys_top
        % for ind in range(4):
`define ${PE}_DPSRAM_${ind} `${PE}.x_mem_sub_sys_top.x_axi_uram_${ind}.x_axi_uram.x_fpga_ram
        % endfor
        % for ind, rv in enumerate(pes[0].rvs.dispatcher + pes[0].rvs.regular):
`define ${PE}_RV_${ind} `${PE}.x_rv_cluster_top.x_${rv.name}_rv_wrapper
`define ${PE}_RV_${ind}_AHB `${PE}_RV_${ind}.x_${rv.name}_cpu_sub_system_ahb
        % endfor
    % endfor
% endif
% if chip.type == "heterogeneous":
    % for pe in pes:
<% PE = pe.name.upper() %>\
// ${PE}
`define ${PE} `DUT.x_pe_array_top.x_${pe.name}_pe_top
`define ${PE}_SPM `${PE}.x_mem_sub_sys_top
        % for ind in range(4):
`define ${PE}_DPSRAM_${ind} `${PE}.x_mem_sub_sys_top.x_axi_uram_${ind}.x_axi_uram.x_fpga_ram
        % endfor
        % for ind, rv in enumerate(pe.rvs.dispatcher + pe.rvs.regular): 
`define ${PE}_RV_${ind} `${PE}.x_${pe.name}_rv_cluster_top.x_${pe.name}_${rv.name}_rv_wrapper
`define ${PE}_RV_${ind}_AHB `${PE}_RV_${ind}.x_${pe.name}_${rv.name}_cpu_sub_system_ahb
        % endfor
    % endfor
% endif

// Used in "tb_finish_mnt.sv"
`define MAX_RUN_TIME 8000000000
`define LAST_CYCLE 500000

// for cpu finish control and printf
`define MAILBOX_ADDR 32'hc00001f8 // finish address
`define PASS_FLAG	32'hffff
`define FAIL_FLAG	32'hdead
