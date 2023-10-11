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

module rpu_rcv_pkt_encode (
    // inputs
    input logic [`NOU_PKT_HEADER_SZ_WIDTH-1:0] pkt_header_size,
    input logic [`NOU_PKT_DATA_SZ_WIDTH-1:0] pkt_data_size,
    input logic [`NOU_PKT_HEADER_ADDR_WIDTH-1:0] header_buf_addr,
    input logic [`NOU_PKT_DATA_ADDR_WIDTH-1:0] data_buf_addr,

    // outputs
    output logic [`NOU_XOCC_CMD_WIDTH-1:0] rcv_pkt_encode_out

);

    assign rcv_pkt_encode_out = {{12{1'b0}}, header_buf_addr, pkt_header_size, {10{1'b0}}, data_buf_addr, pkt_data_size, `RCV_PKT_RSP_TYPE};

endmodule
