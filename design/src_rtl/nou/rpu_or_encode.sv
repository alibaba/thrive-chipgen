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

module rpu_or_encode
(
    // inputs
    input logic ob_rsp_vld,
    input logic [`NOU_TYPE_WIDTH-1:0] ob_rsp_type,
    input logic ob_rsp_status,
    input logic [`NOU_ERR_CODE_WIDTH-1:0] ob_rsp_err,
    input logic [`NOU_TID_WIDTH-1:0] cur_trans_id,
    input logic [`NOU_TILE_ID_WIDTH-1:0] cur_dst_tile_id,
    // outputs
    output logic or_valid,
    output logic [`NOU_TID_WIDTH-1:0] or_dat_tid,
    output logic [`NOU_TYPE_WIDTH-1:0] or_dat_type,
    output logic [`NOU_NOC_RSP_WIDTH-1:0] or_dat_data
);

    logic [`NOU_NOC_RSP_WIDTH-1:0] outbound_rsp_with_err;
    logic [`NOU_NOC_RSP_WIDTH-1:0] outbound_rsp_no_err;

    assign outbound_rsp_with_err = {{16{1'b0}}, ob_rsp_err, ob_rsp_status, cur_dst_tile_id};
    assign outbound_rsp_no_err = {{16{1'b0}}, {5{1'b0}}, ob_rsp_status, cur_dst_tile_id};
    assign or_valid = ob_rsp_vld;
    assign or_dat_tid = cur_trans_id;
    assign or_dat_type = ob_rsp_type;
    assign or_dat_data = ob_rsp_status ? outbound_rsp_with_err : outbound_rsp_no_err; 

endmodule
