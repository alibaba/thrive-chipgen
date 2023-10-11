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

module rpu_ibd_decoder 
(
    // Inbound data channel from router
    input logic id_valid,
    input logic [`NOU_TID_WIDTH-1:0] id_dat_tid,
    input logic [`NOU_TYPE_WIDTH-1:0] id_dat_type,
    input logic [`NOU_NOC_DATA_WIDTH-1:0] id_dat_data,
    input logic id_ready,

    // Signals to RPU controller 
    output logic ib_vld,
    output logic [`NOU_TYPE_WIDTH-1:0] ib_type,

    // Signals to RPU register 
    output logic lreg_vld,
    output logic [`NOU_TID_WIDTH-1:0] trans_id,
    output logic [`NOU_TILE_ID_WIDTH-1:0] local_tile_id,
    output logic [`NOU_TILE_ID_WIDTH-1:0] dst_tile_id,
    output logic [`NOU_PKT_ID_WIDTH-1:0] pkt_id,
    output logic [`NOU_PKT_HEADER_SZ_WIDTH-1:0] pkt_header_size,
    output logic [`NOU_PKT_DATA_SZ_WIDTH-1:0] pkt_data_size,
    output logic [`NOU_FLIT_SZ_WIDTH-1:0] pkt_flit_num
);

/********** SIGNAL DECLARE **************/

    assign ib_vld = id_valid;
    assign ib_type = id_dat_type;
    assign lreg_vld = id_valid & id_ready & (ib_type==`HEAD_FLIT_TYPE);
    assign trans_id = id_dat_tid;
    assign local_tile_id = id_dat_data[9:0];
    assign dst_tile_id = id_dat_data[19:10];
    assign pkt_flit_num = id_dat_data[31:20];
    assign pkt_header_size = id_dat_data[39:32];
    assign pkt_data_size = id_dat_data[45:40];
    assign pkt_id = id_dat_data[95:64];

endmodule
