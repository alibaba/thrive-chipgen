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


module pwu_pwur
(
    input  wire clk,
    input  wire rstn,

    input  wire                                 retire_keep,
    input  wire                                 vld,
    input  wire [`NOU_SID_WIDTH-1:0]            sid,
    input  wire [`NOU_RSP_TYPE_ID_WIDTH-1:0]    rsp_type,
    input  wire [`NOU_PKT_ID_WIDTH-1:0]         pkt_id,
    input  wire                                 status,
    input  wire [`NOU_ERR_CODE_WIDTH-1:0]       err_code,
    input  wire [`NOU_WL_RM_WIDTH-1:0]          rm,

    output wire                                 vld_q,
    output wire [`NOU_SID_WIDTH-1:0]            sid_q,
    output wire [`NOU_RSP_TYPE_ID_WIDTH-1:0]    rsp_type_q,
    output wire [`NOU_PKT_ID_WIDTH-1:0]         pkt_id_q,
    output wire                                 status_q,
    output wire [`NOU_ERR_CODE_WIDTH-1:0]       err_code_q,
    output wire [`NOU_WL_RM_WIDTH-1:0]          rm_q
);

    dffr ff_vld(
        .clk (clk),
        .rn  (rstn),
        .g   (~retire_keep),
        .d   (vld),
        .q   (vld_q)
    );

    dffr #(`NOU_SID_WIDTH) ff_sid(
        .clk (clk),
        .rn  (rstn),
        .g   (~retire_keep),
        .d   (sid),
        .q   (sid_q)
    );

    dffr #(`NOU_RSP_TYPE_ID_WIDTH) ff_rsp_type(
        .clk (clk),
        .rn  (rstn),
        .g   (~retire_keep),
        .d   (rsp_type),
        .q   (rsp_type_q)
    );

    dffr #(`NOU_PKT_ID_WIDTH) ff_pkt_id(
        .clk (clk),
        .rn  (rstn),
        .g   (~retire_keep),
        .d   (pkt_id),
        .q   (pkt_id_q)
    );

    dffr ff_status(
        .clk (clk),
        .rn  (rstn),
        .g   (~retire_keep),
        .d   (status),
        .q   (status_q)
    );

    dffr #(`NOU_ERR_CODE_WIDTH) ff_err_code(
        .clk (clk),
        .rn  (rstn),
        .g   (~retire_keep),
        .d   (err_code),
        .q   (err_code_q)
    );

    dffr #(`NOU_WL_RM_WIDTH) ff_rm(
        .clk (clk),
        .rn  (rstn),
        .g   (~retire_keep),
        .d   (rm),
        .q   (rm_q)
    );

endmodule
