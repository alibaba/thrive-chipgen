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

module rpu_rcv_pkt_id_encode (
    // inputs
    input logic [`NOU_TILE_ID_WIDTH-1:0] local_tile_id,
    input logic [`NOU_TILE_ID_WIDTH-1:0] dst_tile_id,
    input logic [`NOU_PKT_ID_WIDTH-1:0] pkt_id,

    // outputs
    output logic [`NOU_XOCC_CMD_WIDTH-1:0] rcv_pkt_id_encode_out
);

    assign rcv_pkt_id_encode_out = {pkt_id, {8{1'b0}}, dst_tile_id, local_tile_id, `RCV_PKT_RID_RSP_TYPE};

endmodule
