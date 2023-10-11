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

module nou_decode
(
    input wire  clk,
    input wire  rstn,

    // from/to fetch stage
    input wire [1/*valid*/ + `NOU_SID_WIDTH + `NOU_XOCC_CMD_WIDTH + `NOU_UOV_SIZE - 1 : 0]
                                            entry_input,
    input wire                              entry_input_valid,
    output wire                             decode_issue_ack,

    // UOV from retire stage
    input wire [`NOU_UOV_SIZE-1:0]          unit_output_vector,

    // Invalid Request Register (IRR):
    output wire                                 decode_irr_vld,
    output wire [`NOU_SID_WIDTH-1:0]            decode_irr_sid,
    output wire [`NOU_REQ_TYPE_ID_WIDTH-1:0]    decode_irr_rtype,

    // Buffer Request Register (BRR):
    output wire                                 decode_brr_vld,
    output wire [`NOU_SID_WIDTH-1:0]            decode_brr_sid,
    output wire [`NOU_BUF_OP_TYPE_WIDTH-1:0]    decode_brr_op_type,
    output wire [`NOU_BUF_ID_WIDTH-1:0]         decode_brr_buf_id,
    output wire [`NOU_BUF_ADDR_WIDTH-1:0]       decode_brr_buf_addr,
    output wire [`NOU_BUF_SZ_WIDTH-1:0]         decode_brr_buf_size,
    output wire [`NOU_BUF_RM_WIDTH-1:0]         decode_brr_rm, //reclaim mode

    // Packet Whitelist Request Register (PWRR):
    output wire                                 decode_pwrr_vld,
    output wire [`NOU_SID_WIDTH-1:0]            decode_pwrr_sid,
    output wire [`NOU_WL_OP_TYPE_WIDTH-1:0]     decode_pwrr_op_type,
    output wire [`NOU_PKT_ID_WIDTH-1:0]         decode_pwrr_pkt_id,
    output wire [`NOU_WL_RM_WIDTH-1:0]          decode_pwrr_rm, //reclaim mode

    // Send Packet ID Register (SPIDR):
    output wire                                 decode_spidr_vld,
    output wire [`NOU_SID_WIDTH-1:0]            decode_spidr_sid,
    output wire [`NOU_PKT_ID_WIDTH-1:0]         decode_spidr_pkt_id,
    output wire [`NOU_TILE_ID_WIDTH-1:0]        decode_spidr_src_tile_id,
    output wire [`NOU_TILE_ID_WIDTH-1:0]        decode_spidr_dst_tile_id,

    // Send Packet Request Register (SPRR):
    output wire                                     decode_sprr_vld,
    output wire [`NOU_SID_WIDTH-1:0]                decode_sprr_sid,
    output wire [`NOU_PKT_HEADER_ADDR_WIDTH-1:0]    decode_sprr_pkt_header_addr,
    output wire [`NOU_PKT_HEADER_SZ_WIDTH-1:0]      decode_sprr_pkt_header_size,
    output wire [`NOU_PKT_DATA_ADDR_WIDTH-1:0]      decode_sprr_pkt_data_addr,
    output wire [`NOU_PKT_DATA_SZ_WIDTH-1:0]        decode_sprr_pkt_data_size
);

/********** SIGNAL DECLARE **************/

wire                                rd_port_vld;

wire                                irr_vld;
wire [`NOU_SID_WIDTH-1:0]           irr_sid;
wire [`NOU_REQ_TYPE_ID_WIDTH-1:0]   irr_rtype;

wire                                brr_vld;
wire [`NOU_SID_WIDTH-1:0]           brr_sid;
wire [`NOU_BUF_OP_TYPE_WIDTH-1:0]   brr_op_type;
wire [`NOU_BUF_ID_WIDTH-1:0]        brr_buf_id;
wire [`NOU_BUF_ADDR_WIDTH-1:0]      brr_buf_addr;
wire [`NOU_BUF_SZ_WIDTH-1:0]        brr_buf_size;
wire [`NOU_BUF_RM_WIDTH-1:0]        brr_rm; //reclaim mode

wire                                pwrr_vld;
wire [`NOU_SID_WIDTH-1:0]           pwrr_sid;
wire [`NOU_WL_OP_TYPE_WIDTH-1:0]    pwrr_op_type;
wire [`NOU_PKT_ID_WIDTH-1:0]        pwrr_pkt_id;
wire [`NOU_WL_RM_WIDTH-1:0]         pwrr_rm; //reclaim mode

wire                                spidr_vld;
wire [`NOU_SID_WIDTH-1:0]           spidr_sid;
wire [`NOU_PKT_ID_WIDTH-1:0]        spidr_pkt_id;
wire [`NOU_TILE_ID_WIDTH-1:0]       spidr_src_tile_id;
wire [`NOU_TILE_ID_WIDTH-1:0]       spidr_dst_tile_id;

wire                                sprr_vld;
wire [`NOU_SID_WIDTH-1:0]           sprr_sid;
wire [`NOU_PKT_HEADER_ADDR_WIDTH-1:0]   sprr_pkt_header_addr;
wire [`NOU_PKT_HEADER_SZ_WIDTH-1:0]     sprr_pkt_header_size;
wire [`NOU_PKT_DATA_ADDR_WIDTH-1:0]     sprr_pkt_data_addr;
wire [`NOU_PKT_DATA_SZ_WIDTH-1:0]       sprr_pkt_data_size;


// Decode read port
decode_rd_port
u_decode_rd_port(
    .clk(clk),
    .rstn(rstn),

    .entry_input_vld(entry_input_valid),
    .unit_mask(entry_input[1/*valid*/ + `NOU_SID_WIDTH + `NOU_XOCC_CMD_WIDTH + `NOU_UOV_SIZE - 1 : 1/*valid*/ + `NOU_SID_WIDTH + `NOU_XOCC_CMD_WIDTH]),
    .decode_issue_ack(decode_issue_ack),

    .rd_port_vld(rd_port_vld),

    .unit_output_vector(unit_output_vector)
);

// Decode logic
decode_logic
u_decode_logic(
    .entry_input(entry_input),
    .rd_port_vld(rd_port_vld),

    .irr_vld(irr_vld),
    .irr_sid(irr_sid),
    .irr_rtype(irr_rtype),

    .brr_vld(brr_vld),
    .brr_sid(brr_sid),
    .brr_op_type(brr_op_type),
    .brr_buf_id(brr_buf_id),
    .brr_buf_addr(brr_buf_addr),
    .brr_buf_size(brr_buf_size),
    .brr_rm(brr_rm),

    .pwrr_vld(pwrr_vld),
    .pwrr_sid(pwrr_sid),
    .pwrr_op_type(pwrr_op_type),
    .pwrr_pkt_id(pwrr_pkt_id),
    .pwrr_rm(pwrr_rm),

    .spidr_vld(spidr_vld),
    .spidr_sid(spidr_sid),
    .spidr_pkt_id(spidr_pkt_id),
    .spidr_src_tile_id(spidr_src_tile_id),
    .spidr_dst_tile_id(spidr_dst_tile_id),

    .sprr_vld(sprr_vld),
    .sprr_sid(sprr_sid),
    .sprr_pkt_header_addr(sprr_pkt_header_addr),
    .sprr_pkt_header_size(sprr_pkt_header_size),
    .sprr_pkt_data_addr(sprr_pkt_data_addr),
    .sprr_pkt_data_size(sprr_pkt_data_size)
);

// Decode registers
decode_reg
u_decode_reg(
    .clk(clk),
    .rstn(rstn),

    // IRR inputs:
    .irr_vld(irr_vld),
    .irr_sid(irr_sid),
    .irr_rtype(irr_rtype),
    // IRR outputs:
    .irr_vld_q(decode_irr_vld),
    .irr_sid_q(decode_irr_sid),
    .irr_rtype_q(decode_irr_rtype),

    // BRR inputs:
    .brr_vld(brr_vld),
    .brr_sid(brr_sid),
    .brr_op_type(brr_op_type),
    .brr_buf_id(brr_buf_id),
    .brr_buf_addr(brr_buf_addr),
    .brr_buf_size(brr_buf_size),
    .brr_rm(brr_rm),
    // BRR outputs:
    .brr_vld_q(decode_brr_vld),
    .brr_sid_q(decode_brr_sid),
    .brr_op_type_q(decode_brr_op_type),
    .brr_buf_id_q(decode_brr_buf_id),
    .brr_buf_addr_q(decode_brr_buf_addr),
    .brr_buf_size_q(decode_brr_buf_size),
    .brr_rm_q(decode_brr_rm),

    // PWRR inputs:
    .pwrr_vld(pwrr_vld),
    .pwrr_sid(pwrr_sid),
    .pwrr_op_type(pwrr_op_type),
    .pwrr_pkt_id(pwrr_pkt_id),
    .pwrr_rm(pwrr_rm),
    // PWRR outputs:
    .pwrr_vld_q(decode_pwrr_vld),
    .pwrr_sid_q(decode_pwrr_sid),
    .pwrr_op_type_q(decode_pwrr_op_type),
    .pwrr_pkt_id_q(decode_pwrr_pkt_id),
    .pwrr_rm_q(decode_pwrr_rm),

    // SPIDR inputs:
    .spidr_vld(spidr_vld),
    .spidr_sid(spidr_sid),
    .spidr_pkt_id(spidr_pkt_id),
    .spidr_src_tile_id(spidr_src_tile_id),
    .spidr_dst_tile_id(spidr_dst_tile_id),
    // SPIDR outputs:
    .spidr_vld_q(decode_spidr_vld),
    .spidr_sid_q(decode_spidr_sid),
    .spidr_pkt_id_q(decode_spidr_pkt_id),
    .spidr_src_tile_id_q(decode_spidr_src_tile_id),
    .spidr_dst_tile_id_q(decode_spidr_dst_tile_id),

    // SPRR inputs:
    .sprr_vld(sprr_vld),
    .sprr_sid(sprr_sid),
    .sprr_pkt_header_addr(sprr_pkt_header_addr),
    .sprr_pkt_header_size(sprr_pkt_header_size),
    .sprr_pkt_data_addr(sprr_pkt_data_addr),
    .sprr_pkt_data_size(sprr_pkt_data_size),
    // SPRR outputs:
    .sprr_vld_q(decode_sprr_vld),
    .sprr_sid_q(decode_sprr_sid),
    .sprr_pkt_header_addr_q(decode_sprr_pkt_header_addr),
    .sprr_pkt_header_size_q(decode_sprr_pkt_header_size),
    .sprr_pkt_data_addr_q(decode_sprr_pkt_data_addr),
    .sprr_pkt_data_size_q(decode_sprr_pkt_data_size)
);


endmodule

