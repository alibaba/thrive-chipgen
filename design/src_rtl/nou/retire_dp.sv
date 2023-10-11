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


module retire_dp
(
    input wire [`NOU_RSP_TYPE_ID_WIDTH-1:0]         irur_rsp_type,
    input wire [`NOU_REQ_TYPE_ID_WIDTH-1:0]         irur_req_type,

    input wire [`NOU_RSP_TYPE_ID_WIDTH-1:0]         burr_rsp_type,
    input wire [`NOU_BUF_ID_WIDTH-1:0]              burr_buf_id,
    input wire                                      burr_status,
    input wire [`NOU_ERR_CODE_WIDTH-1:0]            burr_err_code,
    input wire [`NOU_BUF_RM_WIDTH-1:0]              burr_rm,        // buffer reclaim mode

    input wire [`NOU_RSP_TYPE_ID_WIDTH-1:0]         pwur_rsp_type,
    input wire [`NOU_PKT_ID_WIDTH-1:0]              pwur_pkt_id,
    input wire                                      pwur_status,
    input wire [`NOU_ERR_CODE_WIDTH-1:0]            pwur_err_code,
    input wire [`NOU_WL_RM_WIDTH-1:0]               pwur_rm,        // packet reclaim mode

    input wire [`NOU_RSP_TYPE_ID_WIDTH-1:0]         spur_rsp_type,
    input wire [`NOU_PKT_ID_WIDTH-1:0]              spur_pkt_id,
    input wire                                      spur_status,
    input wire [`NOU_ERR_CODE_WIDTH-1:0]            spur_err_code,

    input wire [`NOU_XOCC_CMD_WIDTH-1:0]            rpu_rsp_data,

    input wire [2:0]                                or_sel,

    // RV Response FIFO Interface
    output reg [`NOU_XOCC_CMD_WIDTH-1:0]           rsp_fifo_data
);

    localparam GRANT_IRUR = 3'b000;
    localparam GRANT_BURR = 3'b001;
    localparam GRANT_PWUR = 3'b010;
    localparam GRANT_SPUR = 3'b011;
    localparam GRANT_RPU  = 3'b100;

    wire [`NOU_XOCC_CMD_WIDTH-1:0]  irur_or_data0;
    wire [`NOU_XOCC_CMD_WIDTH-1:0]  burr_or_data1;
    wire [`NOU_BUF_RM_WIDTH-1:0]    buf_rm;
    wire [`NOU_XOCC_CMD_WIDTH-1:0]  pwur_or_data2;
    wire [`NOU_WL_RM_WIDTH-1:0]     wl_rm;
    wire [`NOU_XOCC_CMD_WIDTH-1:0]  spur_or_data3;

    assign irur_or_data0 = {{54{1'b0}}, irur_req_type, {2{1'b0}}, irur_rsp_type};

    assign buf_rm = (burr_rsp_type == `REL_BUF_RSP_TYPE) ? burr_rm : {2{1'b0}};
    assign burr_or_data1 = {{24{1'b0}}, burr_buf_id, {20{1'b0}}, buf_rm, burr_err_code, burr_status, burr_rsp_type};

    assign wl_rm = (pwur_rsp_type == `REL_WL_RSP_TYPE) ? pwur_rm : {2{1'b0}};
    assign pwur_or_data2 = {pwur_pkt_id, {20{1'b0}}, wl_rm, pwur_err_code, pwur_status, pwur_rsp_type};

    assign spur_or_data3 = {spur_pkt_id, {22{1'b0}}, spur_err_code, spur_status, spur_rsp_type};

    always_comb
    begin
        unique case (or_sel)
            GRANT_RPU : rsp_fifo_data = rpu_rsp_data;
            GRANT_IRUR: rsp_fifo_data = irur_or_data0;
            GRANT_BURR: rsp_fifo_data = burr_or_data1;
            GRANT_PWUR: rsp_fifo_data = pwur_or_data2;
            GRANT_SPUR: rsp_fifo_data = spur_or_data3;
            default   : rsp_fifo_data = {64{1'b0}};
        endcase
    end

endmodule
