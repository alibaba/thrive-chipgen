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

`timescale 1ps/1ps

`define NUMBER_OF_MASTER    4
//maximum out-of-order transactions for each master
`define MAX_OOO_TRANS       16
//`define AXI_MASTER_ID_WIDTH $clog2(`MAX_OOO_TRANS)
//`define AXI_SLAVE_ID_WIDTH  `AXI_MASTER_ID_WIDTH + $clog2(`NUMBER_OF_MASTER)
`define AXI_MASTER_ID_WIDTH 4
`define AXI_SLAVE_ID_WIDTH  8


//XoCC channel width

/* dmu */
`define DMU_XOCC_REQ_WIDTH  96
`define DMU_XOCC_RSP_WIDTH  32

/* gemm */
`define GEMM_XOCC_REQ_WIDTH  96
`define GEMM_XOCC_RSP_WIDTH  32


`define SRAM_ADDR_WIDTH 20
`define CSR_ADDR_WIDTH 12

//Memory Map 
`define CSR_S_ADDR 32'hc000_0000
`define XPM_S_ADDR 32'h0200_0000

