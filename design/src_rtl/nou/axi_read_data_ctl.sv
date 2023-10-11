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

`include "nou_define.h"
module axi_read_data_ctl
(
    input wire clk,
    input wire rstn, 

    input wire [`NOU_PKT_FLIT_WIDTH-1:0]    header_flit_num,
    input wire [`NOU_PKT_FLIT_WIDTH-1:0]    data_flit_num,
    input wire [`NOU_PKT_FLIT_WIDTH-1:0]    data_counter,

    input wire                              pb_full,
    input wire                              axi_rlast,
    input wire [1:0]                        axi_rresp,
    input wire                              axi_rvld,
     
    output wire                             axi_rrdy,
    output wire                             pb_wr_en,
    output wire                             rd_done,
    output wire                             rd_error,
    output wire                             plug_one,
    output wire                             rst_cnt
);
   
    wire     rsp_ok = (axi_rresp == 2'b00);
    wire     vld_not_full_ok = axi_rvld & ~pb_full & rsp_ok;
    wire [`NOU_PKT_FLIT_WIDTH-1:0]  flit_sum = header_flit_num + data_flit_num;

    assign pb_wr_en = vld_not_full_ok;
    assign axi_rrdy = vld_not_full_ok;
    assign plug_one = vld_not_full_ok;
    assign rd_error = axi_rvld & ~rsp_ok;
    assign rd_done  = ((data_counter > 0) && (data_counter == flit_sum)) ? 1'b1 : 1'b0;
    assign rst_cnt  = rd_done;
endmodule

