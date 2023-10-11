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


module bu_buf_slot
(
    input wire clk,
    input wire rstn,

    input wire [`NOU_BUF_SLOT_STATUS_WIDTH-1:0]     rst_buf_status,
    input wire [`NOU_BUF_ADDR_WIDTH-1:0]            rst_buf_addr,
    input wire [`NOU_BUF_SZ_WIDTH-1:0]              rst_buf_size,

    input wire [`NOU_BUF_SLOT_STATUS_WIDTH-1:0]     buf_status,
    input wire [`NOU_BUF_ADDR_WIDTH-1:0]            buf_addr,
    input wire [`NOU_BUF_SZ_WIDTH-1:0]              buf_size,

    input wire                                      wr_en,

    output reg [`NOU_BUF_SLOT_STATUS_WIDTH-1:0]     buf_status_q,
    output reg [`NOU_BUF_ADDR_WIDTH-1:0]            buf_addr_q,
    output reg [`NOU_BUF_SZ_WIDTH-1:0]              buf_size_q
);

    always_ff @(posedge clk or negedge rstn)
    begin: dff_blk
        if (!rstn)
        begin
            buf_status_q <= rst_buf_status;
            buf_addr_q   <= rst_buf_addr;
            buf_size_q   <= rst_buf_size;
        end
        else if (wr_en == 1'b1)
        begin
            buf_status_q <= buf_status;
            buf_addr_q   <= buf_addr;
            buf_size_q   <= buf_size;
        end
    end

endmodule
