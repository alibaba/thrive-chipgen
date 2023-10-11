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
module axi_aw_master_ctl
(
    input wire clk, 
    input wire rstn, 

    input logic start_aw,
    input logic [`NOU_PKT_DATA_SZ_WIDTH+4-1:0] data_flit_num,
    input logic [`NOU_PKT_HEADER_SZ_WIDTH+1-6-1:0] header_flit_num,
    input logic axi_awrdy,
    input logic axi_awvld,

    output logic sel_pkt_addr,
    output logic sel_incr_addr,
    output logic sel_base_addr,
    output logic addr_valid
);

    parameter [2:0] IDLE = 3'd0,
                    AW_HEAD_0 = 3'd1,
                    AW_HEAD_1 = 3'd2,
                    AW_DATA = 3'd3;

    logic [2:0] state;
    logic [2:0] next;
    logic plus_one;
    logic rst_cnt;
    logic [31:0] addr_counter;

    always @(posedge clk or negedge rstn)
    begin
        if (!rstn) begin
            state <= IDLE;
        end
        else begin
            state <= next;
        end
    end

    always @(posedge clk or negedge rstn)
    begin
        if (!rstn) begin
            addr_counter <= 0;
        end
        else begin
            if ((rst_cnt == 1'b1) && (plus_one == 1'b1)) begin
                addr_counter <= 1;
            end
            else if ((rst_cnt == 1'b1) && (plus_one != 1'b1)) begin
                addr_counter <= 0;
            end
            else if ((rst_cnt != 1'b1) && (plus_one == 1'b1)) begin 
                addr_counter <= addr_counter + 1;
            end
        end
    end

    always @*
    begin
        next = state;
        addr_valid = 0;
        sel_pkt_addr = 0;
        sel_base_addr = 0;
        sel_incr_addr = 0;
        plus_one = 0;
        rst_cnt = 0;

        case (state)
            IDLE: begin
                rst_cnt = 1;

                if (start_aw) next = AW_HEAD_0;
            end
            AW_HEAD_0: begin
                addr_valid = 1;
                sel_pkt_addr = 0;
                sel_base_addr = 1;
                sel_incr_addr = 0;
                plus_one = 0;

                next = AW_HEAD_1;
            end
            AW_HEAD_1: begin
                if (addr_counter == header_flit_num-1) begin
                    rst_cnt = axi_awvld & axi_awrdy;
                    plus_one = 0;
                    addr_valid = 1;
                    sel_pkt_addr = 1;
                    sel_base_addr = 1;
                    sel_incr_addr = 0;

                    if (axi_awvld & axi_awrdy) next = AW_DATA;
                end
                else begin
                    plus_one = axi_awvld & axi_awrdy;
                    addr_valid = 1;
                    sel_pkt_addr = 0;
                    sel_base_addr = 0;
                    sel_incr_addr = 1;
                end
            end
            AW_DATA: begin
                if (addr_counter == data_flit_num-1) begin
                    rst_cnt = axi_awvld & axi_awrdy;

                    if (axi_awvld & axi_awrdy) next = IDLE;
                end
                else begin
                    plus_one = axi_awvld & axi_awrdy;
                    addr_valid = 1;
                    sel_pkt_addr = 1;
                    sel_base_addr = 0;
                    sel_incr_addr = 1;
                end
            end
        endcase
    end

endmodule
