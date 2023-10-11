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


module nou_pwu
(
    input wire clk,
    input wire rstn,

    // Packet Whitelist Request Register (PWRR) Interface
    input  wire                                 pwrr_pwu_vld,
    input  wire [`NOU_SID_WIDTH-1:0]            pwrr_pwu_sid,
    input  wire [`NOU_WL_OP_TYPE_WIDTH-1:0]     pwrr_pwu_op_type,
    input  wire [`NOU_PKT_ID_WIDTH-1:0]         pwrr_pwu_pkt_id,
    input  wire [`NOU_WL_RM_WIDTH-1:0]          pwrr_pwu_rm,

    // Receive Packet Unit (RPU) Interface
    input  wire                                 rpu_pwu_chk_pkt_vld,
    input  wire [`NOU_PKT_ID_WIDTH-1:0]         rpu_pwu_pkt_id,
    output wire                                 pwu_rpu_gnt_pkt_vld,
    output wire                                 pwu_rpu_gnt_pkt_status,

    // Result Register (PWUR) Interface
    input  wire                                 retire_pwur_keep,
    output wire                                 pwur_retire_vld,
    output wire [`NOU_SID_WIDTH-1:0]            pwur_retire_sid,
    output wire [`NOU_RSP_TYPE_ID_WIDTH-1:0]    pwur_retire_rsp_type,
    output wire [`NOU_PKT_ID_WIDTH-1:0]         pwur_retire_pkt_id,
    output wire                                 pwur_retire_status,
    output wire [`NOU_ERR_CODE_WIDTH-1:0]       pwur_retire_err_code,
    output wire [`NOU_WL_RM_WIDTH-1:0]          pwur_retire_rm
);

assign pwu_rpu_gnt_pkt_vld = rpu_pwu_chk_pkt_vld;
assign pwu_rpu_gnt_pkt_status = `RSP_STATUS_OK;


// TODO: implement request handling logic and reconnect wires
pwu_pwur
u_pwur(
    .clk(clk),
    .rstn(rstn),

    .retire_keep(retire_pwur_keep),
    .vld(1'b0),
    .sid(pwrr_pwu_sid),
    .rsp_type(`NOU_RSP_TYPE_ID_WIDTH'd0),
    .pkt_id(rpu_pwu_pkt_id),
    .status(`RSP_STATUS_OK),
    .err_code(`NOU_ERR_CODE_WIDTH'd0),
    .rm(pwrr_pwu_rm),

    .vld_q(pwur_retire_vld),
    .sid_q(pwur_retire_sid),
    .rsp_type_q(pwur_retire_rsp_type),
    .pkt_id_q(pwur_retire_pkt_id),
    .status_q(pwur_retire_status),
    .err_code_q(pwur_retire_err_code),
    .rm_q(pwur_retire_rm)
);

endmodule
