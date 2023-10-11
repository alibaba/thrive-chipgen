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

// NOU (vld-rdy handshake protocol) to router (credit protocol) interface
`include "network_define.h"

module nou_in_interface_unit 
#(
    parameter WIDTH = `DATA_WIDTH,
    parameter DAT_WIDTH = `DAT_DAT_WIDTH,
    parameter CRED_BITS = 2,
    parameter CRED_SIZE = 1 
) 

(
    input logic clk,
    input logic rst,

    input logic [`TID_WIDTH-1:0] nou_niiu_tid,
    input logic [`TYPE_WIDTH-1:0] nou_niiu_type,
    input logic [DAT_WIDTH-1:0] nou_niiu_data,
    input logic nou_niiu_valid,
    output logic niiu_nou_ready,
    
    output logic [WIDTH-1:0] niiu_router_data,
    output logic niiu_router_valid,
    input logic router_niiu_yummy
);

    logic [CRED_BITS-1:0] cred_cnt;

    assign niiu_nou_ready = |cred_cnt;
    assign niiu_router_valid = niiu_nou_ready & nou_niiu_valid;
    assign niiu_router_data = {nou_niiu_tid, nou_niiu_type, nou_niiu_data};

    always @(posedge clk or negedge rst)
    begin
        if (!rst)
            cred_cnt <= CRED_SIZE;
        else if (niiu_router_valid & router_niiu_yummy)
            cred_cnt <= cred_cnt;
        else if (niiu_router_valid & !router_niiu_yummy)
            cred_cnt <= cred_cnt - 1;
        else if (!niiu_router_valid & router_niiu_yummy)
            cred_cnt <= cred_cnt + 1;
    end

endmodule
