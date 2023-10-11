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

module decode_reg
(
    input wire  clk,
    input wire  rstn,

    // Invalid Request Register (IRR):
    input wire                              irr_vld,
    input wire [`NOU_SID_WIDTH-1:0]         irr_sid,
    input wire [`NOU_REQ_TYPE_ID_WIDTH-1:0] irr_rtype,
    output wire                                 irr_vld_q,
    output wire [`NOU_SID_WIDTH-1:0]            irr_sid_q,
    output wire [`NOU_REQ_TYPE_ID_WIDTH-1:0]    irr_rtype_q,

    // Buffer Request Register (BRR):
    input wire                              brr_vld,
    input wire [`NOU_SID_WIDTH-1:0]         brr_sid,
    input wire [`NOU_BUF_OP_TYPE_WIDTH-1:0] brr_op_type,
    input wire [`NOU_BUF_ID_WIDTH-1:0]      brr_buf_id,
    input wire [`NOU_BUF_ADDR_WIDTH-1:0]    brr_buf_addr,
    input wire [`NOU_BUF_SZ_WIDTH-1:0]      brr_buf_size,
    input wire [`NOU_BUF_RM_WIDTH-1:0]      brr_rm, //reclaim mode
    output wire                                 brr_vld_q,
    output wire [`NOU_SID_WIDTH-1:0]            brr_sid_q,
    output wire [`NOU_BUF_OP_TYPE_WIDTH-1:0]    brr_op_type_q,
    output wire [`NOU_BUF_ID_WIDTH-1:0]         brr_buf_id_q,
    output wire [`NOU_BUF_ADDR_WIDTH-1:0]       brr_buf_addr_q,
    output wire [`NOU_BUF_SZ_WIDTH-1:0]         brr_buf_size_q,
    output wire [`NOU_BUF_RM_WIDTH-1:0]         brr_rm_q, //reclaim mode

    // Packet Whitelist Request Register (PWRR):
    input wire                              pwrr_vld,
    input wire [`NOU_SID_WIDTH-1:0]         pwrr_sid,
    input wire [`NOU_WL_OP_TYPE_WIDTH-1:0]  pwrr_op_type,
    input wire [`NOU_PKT_ID_WIDTH-1:0]      pwrr_pkt_id,
    input wire [`NOU_WL_RM_WIDTH-1:0]       pwrr_rm, //reclaim mode
    output wire                                 pwrr_vld_q,
    output wire [`NOU_SID_WIDTH-1:0]            pwrr_sid_q,
    output wire [`NOU_WL_OP_TYPE_WIDTH-1:0]     pwrr_op_type_q,
    output wire [`NOU_PKT_ID_WIDTH-1:0]         pwrr_pkt_id_q,
    output wire [`NOU_WL_RM_WIDTH-1:0]          pwrr_rm_q, //reclaim mode

    // Send Packet ID Register (SPIDR):
    input wire                              spidr_vld,
    input wire [`NOU_SID_WIDTH-1:0]         spidr_sid,
    input wire [`NOU_PKT_ID_WIDTH-1:0]      spidr_pkt_id,
    input wire [`NOU_TILE_ID_WIDTH-1:0]     spidr_src_tile_id,
    input wire [`NOU_TILE_ID_WIDTH-1:0]     spidr_dst_tile_id,
    output wire                                 spidr_vld_q,
    output wire [`NOU_SID_WIDTH-1:0]            spidr_sid_q,
    output wire [`NOU_PKT_ID_WIDTH-1:0]         spidr_pkt_id_q,
    output wire [`NOU_TILE_ID_WIDTH-1:0]        spidr_src_tile_id_q,
    output wire [`NOU_TILE_ID_WIDTH-1:0]        spidr_dst_tile_id_q,

    // Send Packet Request Register (SPRR):
    input wire                              sprr_vld,
    input wire [`NOU_SID_WIDTH-1:0]         sprr_sid,
    input wire [`NOU_PKT_HEADER_ADDR_WIDTH-1:0] sprr_pkt_header_addr,
    input wire [`NOU_PKT_HEADER_SZ_WIDTH-1:0]   sprr_pkt_header_size,
    input wire [`NOU_PKT_DATA_ADDR_WIDTH-1:0]   sprr_pkt_data_addr,
    input wire [`NOU_PKT_DATA_SZ_WIDTH-1:0]     sprr_pkt_data_size,
    output wire                                     sprr_vld_q,
    output wire [`NOU_SID_WIDTH-1:0]                sprr_sid_q,
    output wire [`NOU_PKT_HEADER_ADDR_WIDTH-1:0]    sprr_pkt_header_addr_q,
    output wire [`NOU_PKT_HEADER_SZ_WIDTH-1:0]      sprr_pkt_header_size_q,
    output wire [`NOU_PKT_DATA_ADDR_WIDTH-1:0]      sprr_pkt_data_addr_q,
    output wire [`NOU_PKT_DATA_SZ_WIDTH-1:0]        sprr_pkt_data_size_q
);

/********** SIGNAL DECLARE **************/

dffr #(1)               ff_irr_vld(
                        .clk(clk),
                        .rn(rstn),
                        .g (1'b1),
                        .d (irr_vld),
                        .q (irr_vld_q)
                        );

dffr #(`NOU_SID_WIDTH)  ff_irr_sid(
                        .clk(clk),
                        .rn(rstn),
                        .g (irr_vld),
                        .d (irr_sid[`NOU_SID_WIDTH-1:0]),
                        .q (irr_sid_q[`NOU_SID_WIDTH-1:0])
                        );

dffr #(`NOU_REQ_TYPE_ID_WIDTH)  ff_irr_rtype(
                        .clk(clk),
                        .rn(rstn),
                        .g (irr_vld),
                        .d (irr_rtype[`NOU_REQ_TYPE_ID_WIDTH-1:0]),
                        .q (irr_rtype_q[`NOU_REQ_TYPE_ID_WIDTH-1:0])
                        );

dffr #(1)               ff_brr_vld(
                        .clk(clk),
                        .rn(rstn),
                        .g (1'b1),
                        .d (brr_vld),
                        .q (brr_vld_q)
                        );

dffr #(`NOU_SID_WIDTH)  ff_brr_sid(
                        .clk(clk),
                        .rn(rstn),
                        .g (brr_vld),
                        .d (brr_sid[`NOU_SID_WIDTH-1:0]),
                        .q (brr_sid_q[`NOU_SID_WIDTH-1:0])
                        );

dffr #(`NOU_BUF_OP_TYPE_WIDTH)  ff_brr_op_type(
                        .clk(clk),
                        .rn(rstn),
                        .g (brr_vld),
                        .d (brr_op_type[`NOU_BUF_OP_TYPE_WIDTH-1:0]),
                        .q (brr_op_type_q[`NOU_BUF_OP_TYPE_WIDTH-1:0])
                        );

dffr #(`NOU_BUF_ID_WIDTH)  ff_brr_buf_id(
                        .clk(clk),
                        .rn(rstn),
                        .g (brr_vld),
                        .d (brr_buf_id[`NOU_BUF_ID_WIDTH-1:0]),
                        .q (brr_buf_id_q[`NOU_BUF_ID_WIDTH-1:0])
                        );

dffr #(`NOU_BUF_ADDR_WIDTH)  ff_brr_buf_addr(
                        .clk(clk),
                        .rn(rstn),
                        .g (brr_vld),
                        .d (brr_buf_addr[`NOU_BUF_ADDR_WIDTH-1:0]),
                        .q (brr_buf_addr_q[`NOU_BUF_ADDR_WIDTH-1:0])
                        );

dffr #(`NOU_BUF_SZ_WIDTH)  ff_brr_buf_size(
                        .clk(clk),
                        .rn(rstn),
                        .g (brr_vld),
                        .d (brr_buf_size[`NOU_BUF_SZ_WIDTH-1:0]),
                        .q (brr_buf_size_q[`NOU_BUF_SZ_WIDTH-1:0])
                        );

dffr #(`NOU_BUF_RM_WIDTH)  ff_brr_rm(
                        .clk(clk),
                        .rn(rstn),
                        .g (brr_vld),
                        .d (brr_rm[`NOU_BUF_RM_WIDTH-1:0]),
                        .q (brr_rm_q[`NOU_BUF_RM_WIDTH-1:0])
                        );

dffr #(1)               ff_pwrr_vld(
                        .clk(clk),
                        .rn(rstn),
                        .g (1'b1),
                        .d (pwrr_vld),
                        .q (pwrr_vld_q)
                        );

dffr #(`NOU_SID_WIDTH)  ff_pwrr_sid(
                        .clk(clk),
                        .rn(rstn),
                        .g (pwrr_vld),
                        .d (pwrr_sid[`NOU_SID_WIDTH-1:0]),
                        .q (pwrr_sid_q[`NOU_SID_WIDTH-1:0])
                        );

dffr #(`NOU_WL_OP_TYPE_WIDTH)  ff_pwrr_op_type(
                        .clk(clk),
                        .rn(rstn),
                        .g (pwrr_vld),
                        .d (pwrr_op_type[`NOU_WL_OP_TYPE_WIDTH-1:0]),
                        .q (pwrr_op_type_q[`NOU_WL_OP_TYPE_WIDTH-1:0])
                        );

dffr #(`NOU_PKT_ID_WIDTH)  ff_pwrr_pkt_id(
                        .clk(clk),
                        .rn(rstn),
                        .g (pwrr_vld),
                        .d (pwrr_pkt_id[`NOU_PKT_ID_WIDTH-1:0]),
                        .q (pwrr_pkt_id_q[`NOU_PKT_ID_WIDTH-1:0])
                        );

dffr #(`NOU_WL_RM_WIDTH)  ff_pwrr_rm(
                        .clk(clk),
                        .rn(rstn),
                        .g (pwrr_vld),
                        .d (pwrr_rm[`NOU_WL_RM_WIDTH-1:0]),
                        .q (pwrr_rm_q[`NOU_WL_RM_WIDTH-1:0])
                        );

dffr #(1)               ff_spidr_vld(
                        .clk(clk),
                        .rn(rstn),
                        .g (1'b1),
                        .d (spidr_vld),
                        .q (spidr_vld_q)
                        );

dffr #(`NOU_SID_WIDTH)  ff_spidr_sid(
                        .clk(clk),
                        .rn(rstn),
                        .g (spidr_vld),
                        .d (spidr_sid[`NOU_SID_WIDTH-1:0]),
                        .q (spidr_sid_q[`NOU_SID_WIDTH-1:0])
                        );

dffr #(`NOU_PKT_ID_WIDTH)  ff_spidr_pkt_id(
                        .clk(clk),
                        .rn(rstn),
                        .g (spidr_vld),
                        .d (spidr_pkt_id[`NOU_PKT_ID_WIDTH-1:0]),
                        .q (spidr_pkt_id_q[`NOU_PKT_ID_WIDTH-1:0])
                        );

dffr #(`NOU_TILE_ID_WIDTH)  ff_spidr_src_tile_id(
                        .clk(clk),
                        .rn(rstn),
                        .g (spidr_vld),
                        .d (spidr_src_tile_id[`NOU_TILE_ID_WIDTH-1:0]),
                        .q (spidr_src_tile_id_q[`NOU_TILE_ID_WIDTH-1:0])
                        );

dffr #(`NOU_TILE_ID_WIDTH)  ff_spidr_dst_tile_id(
                        .clk(clk),
                        .rn(rstn),
                        .g (spidr_vld),
                        .d (spidr_dst_tile_id[`NOU_TILE_ID_WIDTH-1:0]),
                        .q (spidr_dst_tile_id_q[`NOU_TILE_ID_WIDTH-1:0])
                        );

dffr #(1)               ff_sprr_vld(
                        .clk(clk),
                        .rn(rstn),
                        .g (1'b1),
                        .d (sprr_vld),
                        .q (sprr_vld_q)
                        );

dffr #(`NOU_SID_WIDTH)  ff_sprr_sid(
                        .clk(clk),
                        .rn(rstn),
                        .g (sprr_vld),
                        .d (sprr_sid[`NOU_SID_WIDTH-1:0]),
                        .q (sprr_sid_q[`NOU_SID_WIDTH-1:0])
                        );

dffr #(`NOU_PKT_HEADER_ADDR_WIDTH)  ff_sprr_pkt_header_addr(
                        .clk(clk),
                        .rn(rstn),
                        .g (sprr_vld),
                        .d (sprr_pkt_header_addr[`NOU_PKT_HEADER_ADDR_WIDTH-1:0]),
                        .q (sprr_pkt_header_addr_q[`NOU_PKT_HEADER_ADDR_WIDTH-1:0])
                        );

dffr #(`NOU_PKT_HEADER_SZ_WIDTH)  ff_sprr_pkt_header_size(
                        .clk(clk),
                        .rn(rstn),
                        .g (sprr_vld),
                        .d (sprr_pkt_header_size[`NOU_PKT_HEADER_SZ_WIDTH-1:0]),
                        .q (sprr_pkt_header_size_q[`NOU_PKT_HEADER_SZ_WIDTH-1:0])
                        );

dffr #(`NOU_PKT_DATA_ADDR_WIDTH)  ff_sprr_pkt_data_addr(
                        .clk(clk),
                        .rn(rstn),
                        .g (sprr_vld),
                        .d (sprr_pkt_data_addr[`NOU_PKT_DATA_ADDR_WIDTH-1:0]),
                        .q (sprr_pkt_data_addr_q[`NOU_PKT_DATA_ADDR_WIDTH-1:0])
                        );

dffr #(`NOU_PKT_DATA_SZ_WIDTH)  ff_sprr_pkt_data_size(
                        .clk(clk),
                        .rn(rstn),
                        .g (sprr_vld),
                        .d (sprr_pkt_data_size[`NOU_PKT_DATA_SZ_WIDTH-1:0]),
                        .q (sprr_pkt_data_size_q[`NOU_PKT_DATA_SZ_WIDTH-1:0])
                        );

endmodule

