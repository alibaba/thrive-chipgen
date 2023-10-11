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
module axi_read_addr_ctl
(
    input wire clk, 
    input wire rstn, 

    input wire start_rd,
    input wire [`NOU_PKT_FLIT_WIDTH-1:0]    header_flit_num,
    input wire [`NOU_PKT_FLIT_WIDTH-1:0]    data_flit_num,
    input wire [`NOU_PKT_FLIT_WIDTH-1:0]    addr_counter,

    input wire                              axi_arrdy,
    input wire                              axi_arvld,
    
    output reg                              addr_vld,
    output reg                              sel_pkt_addr,
    output reg                              sel_incr_addr,
    output reg                              sel_base_addr,
    output reg                              plug_one,
    output reg                              rst_cnt
);
    
    localparam IDLE                   = 4'b0001,
               READ_HEADER_FLIT0      = 4'b0010,
               READ_HEADER_FLIT1      = 4'b0100,
               READ_DATA_FLIT         = 4'b1000;

    reg [3:0] ar_state, ar_state_nxt;
    
    // Combinational always block for the state machine and output
    always @(*)
    begin
        // assign default values;
        ar_state_nxt = ar_state;
        sel_pkt_addr  = 1'b0;
        sel_base_addr = 1'b0;
        sel_incr_addr = 1'b0;
        addr_vld      = 1'b0;
        plug_one      = 1'b0;
        rst_cnt       = 1'b0;

        case (ar_state)
        IDLE: begin
            rst_cnt = 1'b1;
            if (start_rd) 
                ar_state_nxt = READ_HEADER_FLIT0;
        end
        READ_HEADER_FLIT0: begin
            ar_state_nxt  = READ_HEADER_FLIT1;
            sel_pkt_addr  = 1'b0;
            sel_base_addr = 1'b1;
            sel_incr_addr = 1'b0;
            addr_vld      = 1'b1;
            plug_one      = 1'b0;
        end
        READ_HEADER_FLIT1: begin
            if (addr_counter < header_flit_num - 1'b1) begin
                sel_base_addr = 1'b0;
                sel_incr_addr = 1'b1;
                addr_vld      = 1'b1;
                plug_one      = axi_arvld & axi_arrdy;
            end
            else begin
                sel_pkt_addr   = 1'b1;
                sel_base_addr  = 1'b1;
                sel_incr_addr  = 1'b0;
                addr_vld       = 1'b1;
                ar_state_nxt   = (axi_arvld & axi_arrdy) ? READ_DATA_FLIT : READ_HEADER_FLIT1;
                plug_one       = 1'b0;
                rst_cnt        = axi_arvld & axi_arrdy;
            end
        end
        READ_DATA_FLIT:  begin
            if (addr_counter < data_flit_num -1'b1) begin
                sel_base_addr = 1'b0;
                sel_incr_addr = 1'b1;
                addr_vld      = 1'b1;
                plug_one      = axi_arvld & axi_arrdy;
            end
            else begin
                ar_state_nxt = (axi_arvld & axi_arrdy) ? IDLE : READ_DATA_FLIT;  //assure the last one is received
                rst_cnt      = axi_arvld & axi_arrdy;
            end

        end
        default: begin
        end
        endcase
    end

    // Flops Inference
    always @(posedge clk or negedge rstn)
    begin
        if (!rstn)
           ar_state <= IDLE;
        else
           ar_state <= ar_state_nxt; 
    end

endmodule
