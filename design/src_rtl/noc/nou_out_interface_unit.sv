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

// Router (credit protocol) to NOU (vld-rdy protocol) interface
`include "network_define.h"

module nou_out_interface_unit 
#(
    parameter WIDTH = `DATA_WIDTH,
    parameter DAT_WIDTH = `DAT_DAT_WIDTH
) 

(
    input logic clk,
    input logic rst,

// vld-rdy protocol
    output logic [`TID_WIDTH-1:0] noiu_nou_tid,
    output logic [`TYPE_WIDTH-1:0] noiu_nou_type,
    output logic [DAT_WIDTH-1:0] noiu_nou_data,
    output logic noiu_nou_valid,
    input logic nou_noiu_ready,

// credit protocol
    input logic [WIDTH-1:0] router_noiu_data,
    input logic router_noiu_valid,
    output logic noiu_router_yummy
);

    logic [`TID_WIDTH-1:0] tid_reg;
    logic [`TYPE_WIDTH-1:0] type_reg;
    logic [DAT_WIDTH-1:0] data_reg;
    logic vld_reg;
    logic reg_gate;

    always @(posedge clk or negedge rst)
    begin
        if (!rst) begin
            tid_reg <= 0;
            type_reg <= 0;
            data_reg <= 0;
            vld_reg  <= 1'b0;
        end
        else begin
            if (reg_gate) begin
                tid_reg <= router_noiu_data[WIDTH-1:WIDTH-`TID_WIDTH];
                type_reg <= router_noiu_data[WIDTH-`TID_WIDTH-1:WIDTH-`TID_WIDTH-`TYPE_WIDTH];
                data_reg <= router_noiu_data[WIDTH-`TID_WIDTH-`TYPE_WIDTH-1:0];
                vld_reg  <= router_noiu_valid;
            end
        end
    end

    assign reg_gate = !noiu_nou_valid || (noiu_nou_valid && nou_noiu_ready);
    assign noiu_nou_tid = tid_reg;
    assign noiu_nou_type = type_reg;
    assign noiu_nou_data = data_reg;
    assign noiu_nou_valid = vld_reg;
    assign noiu_router_yummy = noiu_nou_valid & nou_noiu_ready;

endmodule
