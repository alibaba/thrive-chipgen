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


module nou_retire
(
    // IRUR Interface
    input  wire                                             irur_retire_vld,
    input  wire [`NOU_SID_WIDTH-1:0]                        irur_retire_sid,
    input  wire [`NOU_RSP_TYPE_ID_WIDTH-1:0]                irur_retire_rsp_type,
    input  wire [`NOU_REQ_TYPE_ID_WIDTH-1:0]                irur_retire_req_type,

    // BURR Interface
    input  wire                                             burr_retire_vld,
    input  wire [`NOU_SID_WIDTH-1:0]                        burr_retire_sid,
    input  wire [`NOU_RSP_TYPE_ID_WIDTH-1:0]                burr_retire_rsp_type,
    input  wire [`NOU_BUF_ID_WIDTH-1:0]                     burr_retire_buf_id,
    input  wire                                             burr_retire_status,
    input  wire [`NOU_ERR_CODE_WIDTH-1:0]                   burr_retire_err_code,
    input  wire [`NOU_BUF_RM_WIDTH-1:0]                     burr_retire_rm,

    // PWUR Interface
    input  wire                                             pwur_retire_vld,
    input  wire [`NOU_SID_WIDTH-1:0]                        pwur_retire_sid,
    input  wire [`NOU_RSP_TYPE_ID_WIDTH-1:0]                pwur_retire_rsp_type,
    input  wire [`NOU_PKT_ID_WIDTH-1:0]                     pwur_retire_pkt_id,
    input  wire                                             pwur_retire_status,
    input  wire [`NOU_ERR_CODE_WIDTH-1:0]                   pwur_retire_err_code,
    input  wire [`NOU_BUF_RM_WIDTH-1:0]                     pwur_retire_rm,

    // SPUR Interface
    input  wire                                             spur_retire_vld,
    input  wire [`NOU_SID_WIDTH-1:0]                        spur_retire_sid,
    input  wire [`NOU_RSP_TYPE_ID_WIDTH-1:0]                spur_retire_rsp_type,
    input  wire [`NOU_PKT_ID_WIDTH-1:0]                     spur_retire_pkt_id,
    input  wire                                             spur_retire_status,
    input  wire [`NOU_ERR_CODE_WIDTH-1:0]                   spur_retire_err_code,

    // RPU Interface
    input  wire                                             rpu_retire_rcv_pkt_rsp_vld,
    input  wire [`NOU_XOCC_CMD_WIDTH-1:0]                   rpu_retire_rcv_pkt_rsp_bus,
    output wire                                             retire_rpu_gnt_rcv_pkt_rsp,

    // RV Response FIFO Interface
    input  wire                                             rsp_fifo_retire_full,
    output wire                                             retire_rsp_fifo_wr_en,
    output wire [`NOU_XOCC_CMD_WIDTH-1:0]                   retire_rsp_fifo_data,

    // Unit Output Vector to decode stage
    output wire [4:0]                                       retire_decode_uov,

    // Keep signals
    output wire                                             retire_irur_keep,
    output wire                                             retire_burr_keep,
    output wire                                             retire_pwur_keep,
    output wire                                             retire_spur_keep
);

    /********** SIGNAL DECLARE **************/
    wire [2:0]                  or_sel;

    retire_ctl
    u_retire_ctl(
        .irur_vld(irur_retire_vld),
        .irur_sid(irur_retire_sid),
        .burr_vld(burr_retire_vld),
        .burr_sid(burr_retire_sid),
        .pwur_vld(pwur_retire_vld),
        .pwur_sid(pwur_retire_sid),
        .spur_vld(spur_retire_vld),
        .spur_sid(spur_retire_sid),
        .rpu_rcv_pkt_rsp_vld(rpu_retire_rcv_pkt_rsp_vld),

        .gnt_rcv_pkt_rsp(retire_rpu_gnt_rcv_pkt_rsp),

        .rsp_fifo_full(rsp_fifo_retire_full),
        .rsp_fifo_wr_en(retire_rsp_fifo_wr_en),

        .or_sel(or_sel),

        .out_unit_vec(retire_decode_uov),

        .irur_keep(retire_irur_keep),
        .burr_keep(retire_burr_keep),
        .pwur_keep(retire_pwur_keep),
        .spur_keep(retire_spur_keep)
    );

    retire_dp
    u_retire_dp(
        .irur_rsp_type(irur_retire_rsp_type),
        .irur_req_type(irur_retire_req_type),

        .burr_rsp_type(burr_retire_rsp_type),
        .burr_buf_id(burr_retire_buf_id),
        .burr_status(burr_retire_status),
        .burr_err_code(burr_retire_err_code),
        .burr_rm(burr_retire_rm),

        .pwur_rsp_type(pwur_retire_rsp_type),
        .pwur_pkt_id(pwur_retire_pkt_id),
        .pwur_status(pwur_retire_status),
        .pwur_err_code(pwur_retire_err_code),
        .pwur_rm(pwur_retire_rm),

        .spur_rsp_type(spur_retire_rsp_type),
        .spur_pkt_id(spur_retire_pkt_id),
        .spur_status(spur_retire_status),
        .spur_err_code(spur_retire_err_code),

        .rpu_rsp_data(rpu_retire_rcv_pkt_rsp_bus),
        .or_sel(or_sel),

        .rsp_fifo_data(retire_rsp_fifo_data)
    );

endmodule
