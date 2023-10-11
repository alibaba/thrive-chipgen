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
module decode_logic
(
    //input wire  clk,
    //input wire  rstn,

    input wire [1/*valid*/ + `NOU_SID_WIDTH + `NOU_XOCC_CMD_WIDTH + `NOU_UOV_SIZE - 1 : 0]
                    entry_input,
    input wire      rd_port_vld,

    // Invalid Request Register (IRR):
    output wire                                 irr_vld,
    output wire [`NOU_SID_WIDTH-1:0]            irr_sid,
    output wire [`NOU_REQ_TYPE_ID_WIDTH-1:0]    irr_rtype,

    // Buffer Request Register (BRR):
    output wire                                 brr_vld,
    output wire [`NOU_SID_WIDTH-1:0]            brr_sid,
    output wire [`NOU_BUF_OP_TYPE_WIDTH-1:0]    brr_op_type,
    output wire [`NOU_BUF_ID_WIDTH-1:0]         brr_buf_id,
    output wire [`NOU_BUF_ADDR_WIDTH-1:0]       brr_buf_addr,
    output wire [`NOU_BUF_SZ_WIDTH-1:0]         brr_buf_size,
    output wire [`NOU_BUF_RM_WIDTH-1:0]         brr_rm, //reclaim mode

    // Packet Whitelist Request Register (PWRR):
    output wire                             pwrr_vld,
    output wire [`NOU_SID_WIDTH-1:0]        pwrr_sid,
    output wire [`NOU_WL_OP_TYPE_WIDTH-1:0] pwrr_op_type,
    output wire [`NOU_PKT_ID_WIDTH-1:0]     pwrr_pkt_id,
    output wire [`NOU_WL_RM_WIDTH-1:0]      pwrr_rm, //reclaim mode

    // Send Packet ID Register (SPIDR):
    output wire                             spidr_vld,
    output wire [`NOU_SID_WIDTH-1:0]        spidr_sid,
    output wire [`NOU_PKT_ID_WIDTH-1:0]     spidr_pkt_id,
    output wire [`NOU_TILE_ID_WIDTH-1:0]    spidr_src_tile_id,
    output wire [`NOU_TILE_ID_WIDTH-1:0]    spidr_dst_tile_id,

    // Send Packet Request Register (SPRR):
    output wire                                     sprr_vld,
    output wire [`NOU_SID_WIDTH-1:0]                sprr_sid,
    output wire [`NOU_PKT_HEADER_ADDR_WIDTH-1:0]    sprr_pkt_header_addr,
    output wire [`NOU_PKT_HEADER_SZ_WIDTH-1:0]      sprr_pkt_header_size,
    output wire [`NOU_PKT_DATA_ADDR_WIDTH-1:0]      sprr_pkt_data_addr,
    output wire [`NOU_PKT_DATA_SZ_WIDTH-1:0]        sprr_pkt_data_size
);

/********** SIGNAL DECLARE **************/

wire [`NOU_SID_WIDTH-1:0]           sid;
wire [`NOU_REQ_TYPE_ID_WIDTH-1:0]   rtype;
//wire [`NOU_XOCC_CMD_WIDTH - `NOU_REQ_TYPE_ID_WIDTH - 1 : 0] rdata;
wire [`NOU_XOCC_CMD_WIDTH - 1 : 0]  rtypedata;
wire [`NOU_UOV_SIZE-1:0]            unit_mask;


// determine fields in XRQ entry:
assign sid = entry_input[1+`NOU_SID_WIDTH-1 : 1];
assign rtype = entry_input[1+`NOU_SID_WIDTH+`NOU_REQ_TYPE_ID_WIDTH-1 : 1+`NOU_SID_WIDTH];
//assign rdata = entry_input[1+`NOU_SID_WIDTH+`NOU_XOCC_CMD_WIDTH-1 : 1+`NOU_SID_WIDTH+`NOU_REQ_TYPE_ID_WIDTH];
assign rtypedata = entry_input[1+`NOU_SID_WIDTH+`NOU_XOCC_CMD_WIDTH-1 : 1+`NOU_SID_WIDTH];
assign unit_mask = entry_input[1/*valid*/ + `NOU_SID_WIDTH + `NOU_XOCC_CMD_WIDTH + `NOU_UOV_SIZE - 1 : 1/*valid*/ + `NOU_SID_WIDTH + `NOU_XOCC_CMD_WIDTH];


// determine valid signals:
assign irr_vld = rd_port_vld & unit_mask[0];
assign brr_vld = rd_port_vld & unit_mask[1];
assign pwrr_vld = rd_port_vld & unit_mask[2];
assign spidr_vld = rd_port_vld & unit_mask[3];
assign sprr_vld = rd_port_vld & unit_mask[4];


// decode IRR fields:
assign irr_sid = sid;
assign irr_rtype = rtype;

// decode BRR fields:
assign brr_sid = sid;
assign brr_op_type = (rtype == 0) ? 0 : 1; // brr_op_type: 0 is grant buffer; 1 is reclaim buffer
assign brr_buf_id = (brr_op_type == 0) ? rtypedata[4+`NOU_BUF_ID_WIDTH-1 : 4] : rtypedata[32+`NOU_BUF_ID_WIDTH-1 : 32];
assign brr_buf_addr = rtypedata[32+`NOU_BUF_ADDR_WIDTH-1 : 32]; // buf_addr is only valid when brr_op_type == 0 (grant buffer)
assign brr_buf_size = rtypedata[12+`NOU_BUF_SZ_WIDTH-1 : 12]; // buf_size is only valid when brr_op_type == 0 (grant buffer)
assign brr_rm = rtypedata[4+`NOU_BUF_RM_WIDTH-1 : 4]; // rm is only valid when brr_op_type == 1 (reclaim buffer)

// decode PWRR fields:
assign pwrr_sid = sid;
assign pwrr_op_type = (rtype == 1) ? 0 : 1; // pwrr_op_type: 0 is grant packet whitelist; 1 is reclaim packet whitelist
assign pwrr_pkt_id = rtypedata[32+`NOU_PKT_ID_WIDTH-1 : 32];
assign pwrr_rm = rtypedata[4+`NOU_WL_RM_WIDTH-1 : 4]; // rm is only valid when pwrr_op_type == 1 (reclaim buffer)

// decode SPIDR fields:
assign spidr_sid = sid;
assign spidr_src_tile_id = rtypedata[4+`NOU_TILE_ID_WIDTH-1:4];
assign spidr_dst_tile_id = rtypedata[14+`NOU_TILE_ID_WIDTH-1:14];
assign spidr_pkt_id = rtypedata[32+`NOU_PKT_ID_WIDTH-1 : 32];

// decode SPRR fields:
assign sprr_sid = sid;
assign sprr_pkt_data_size = rtypedata[4+`NOU_PKT_DATA_SZ_WIDTH-1:4];
assign sprr_pkt_data_addr = rtypedata[10+`NOU_PKT_DATA_ADDR_WIDTH-1:10];
assign sprr_pkt_header_size = rtypedata[32+`NOU_PKT_HEADER_SZ_WIDTH-1:32];
assign sprr_pkt_header_addr = rtypedata[40+`NOU_PKT_HEADER_ADDR_WIDTH-1:40];


endmodule

