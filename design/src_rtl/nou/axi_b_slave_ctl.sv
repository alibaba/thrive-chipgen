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
module axi_b_slave_ctl 
(
    input wire clk, 
    input wire rstn, 

    output logic wr_done, 
    output logic wr_err, 

    input logic [`NOU_PKT_DATA_SZ_WIDTH+4-1:0] data_flit_num,
    input logic [`NOU_PKT_HEADER_SZ_WIDTH+1-6-1:0] header_flit_num,

    input logic [1:0] axi_bresp,
    input logic axi_bvld,
    output logic axi_brdy
);

    parameter [1:0] IDLE = 2'd0,
                    B_OK = 2'd1,
                    B_ERR = 2'd2;

    logic [1:0] state;
    logic [1:0] next;
    logic plus_one;
    logic rst_cnt;
    logic [31:0] b_counter;

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
            b_counter <= 0;
        end
        else begin
            if (rst_cnt == 1'b1) b_counter <= 0;
            else if (plus_one == 1'b1) b_counter <= b_counter + 1; 
        end
    end

    always @*
    begin
        next = IDLE;
        plus_one = 0;
        wr_done = 0;
        wr_err = 0;
        axi_brdy = 0;
        rst_cnt = 0;

        case (state)
            IDLE: begin
                rst_cnt = 1;
                if (axi_bvld & (axi_bresp == 2'b00)) begin
                    rst_cnt = 0;
                    axi_brdy = 1;
                    plus_one = 1;
                end

                if (axi_bvld & (axi_bresp == 2'b00)) next = B_OK;     
            end
            B_OK: begin
                if (axi_bvld)
                    axi_brdy = 1;
                else 
                    axi_brdy = 0;
                plus_one = axi_bvld & axi_brdy;
                wr_done = b_counter == (header_flit_num + data_flit_num);

                if (axi_bvld & (axi_bresp == 2'b01)) next = B_ERR;
                else if (b_counter == (header_flit_num + data_flit_num)) next = IDLE;
                else next = state;
            end
            B_ERR: begin
                next = IDLE;
                wr_err = 1;
                axi_brdy = 1;
            end
        endcase
    end

endmodule
