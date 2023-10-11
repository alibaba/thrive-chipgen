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
module decode_rd_port
(
    input wire  clk,
    input wire  rstn,

    // from/to fetch stage
    input wire          entry_input_vld,
    input wire [`NOU_UOV_SIZE-1:0]  unit_mask,
    output wire         decode_issue_ack,

    output wire         rd_port_vld,

    // UOV from retire stage
    input wire [`NOU_UOV_SIZE-1:0]  unit_output_vector
);

/********** SIGNAL DECLARE **************/

reg [`NOU_UOV_SIZE-1:0]         unit_busy_reg; // UBR
wire                            decode_stall;


// determine vld signals
assign rd_port_vld = entry_input_vld & ~decode_stall;
assign decode_issue_ack = rd_port_vld;

// determine decode_stall
assign decode_stall = |(unit_busy_reg & ~unit_output_vector & unit_mask);
//assign decode_stall = 1'b0;

// determine UBR (for next cycle)
always @(posedge clk or negedge rstn)
begin
    if (!rstn)
    begin
        unit_busy_reg <= {`NOU_UOV_SIZE{1'b0}};
    end
    else
    begin
        unit_busy_reg <= unit_mask | (~unit_mask & unit_busy_reg & ~unit_output_vector);
    end
end


endmodule

