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

module nou 
(
	nou_clk,
	nou_rstn,

// XoCC Request Interface
	req_fifo_nou_data_f1,
	req_fifo_nou_empty_f0,
	nou_req_fifo_rd_en_f0,

// XoCC Response Interface
	rsp_fifo_nou_full,
	nou_rsp_fifo_wr_en,
	nou_rsp_fifo_data,

// Outbound Data Interface
	nou_noc_data_vld,
	noc_nou_data_rdy,
	nou_noc_data_tid,
	nou_noc_data_type,
	nou_noc_data,

// Outbound Response Interface
	nou_noc_rsp_vld,
	noc_nou_rsp_rdy,
	nou_noc_rsp_tid,
	nou_noc_rsp_type,
	nou_noc_rsp,

// Inbound Data Interface
	noc_nou_data_vld,
	nou_noc_data_rdy,
	noc_nou_data_tid,
	noc_nou_data_type,
	noc_nou_data,

// Inbound Response Interface
	noc_nou_rsp_vld,
	nou_noc_rsp_rdy,
	noc_nou_rsp_tid,
	noc_nou_rsp_type,
	noc_nou_rsp,

// NOU AXI Read Address Interface
	nou_axi_arid,
	nou_axi_araddr,
	nou_axi_arlen,
	nou_axi_arsize,
	nou_axi_arburst,
	nou_axi_arlock,
	nou_axi_arcache,
	nou_axi_arprot,
	nou_axi_arqos,
	nou_axi_arregion,
	nou_axi_aruser,
	nou_axi_arvld,
	axi_nou_arrdy,

// NOU AXI Read Data interface
	axi_nou_rid,
	axi_nou_rdata,
	axi_nou_rrsp,
	axi_nou_rlast,
	axi_nou_ruser, 
	axi_nou_rvld,
	nou_axi_rrdy,


// NOU AXI Write Address Interface
	nou_axi_awid,
	nou_axi_awaddr,
	nou_axi_awlen,
	nou_axi_awsize,
	nou_axi_awburst,
	nou_axi_awlock,
	nou_axi_awcache,
	nou_axi_awprot,
	nou_axi_awqos,
	nou_axi_awregion,
	nou_axi_awuser,
	nou_axi_awvld,
	axi_nou_awrdy,

// NOU AXI Write Data Interface
	nou_axi_wdata,
	nou_axi_wstrb,
	nou_axi_wlast,
	nou_axi_wuser,
	nou_axi_wvld,
	axi_nou_wrdy,

// NOU AXI Write Response Interface
	axi_nou_bid,
	axi_nou_brsp,
	axi_nou_buser,
	axi_nou_bvld,
    nou_axi_brdy
);

/********** SIGNAL DECLARE **************/

    input   nou_clk;
    input   nou_rstn;

// XoCC Request Interface
    input   [`NOU_XOCC_CMD_WIDTH-1:0]        req_fifo_nou_data_f1;
    input                                    req_fifo_nou_empty_f0;
    output                                   nou_req_fifo_rd_en_f0;

// XoCC Response Interface
    input                                    rsp_fifo_nou_full;
    output                                   nou_rsp_fifo_wr_en;
    output  [`NOU_XOCC_CMD_WIDTH-1:0]        nou_rsp_fifo_data;

// Outbound Data Interface
    output                                   nou_noc_data_vld;
    input                                    noc_nou_data_rdy;
    output  [`NOU_TID_WIDTH-1:0]             nou_noc_data_tid;
    output  [`NOU_TYPE_WIDTH-1:0]            nou_noc_data_type;
    output  [`NOU_NOC_DATA_WIDTH-1:0]        nou_noc_data;

// Outbound Response Interface
    output                                   nou_noc_rsp_vld;
    input                                    noc_nou_rsp_rdy;
    output  [`NOU_TID_WIDTH-1:0]             nou_noc_rsp_tid;
    output  [`NOU_TYPE_WIDTH-1:0]            nou_noc_rsp_type;
    output  [`NOU_NOC_RSP_WIDTH-1:0]         nou_noc_rsp;

// Inbound Data Interface
    input                                    noc_nou_data_vld;
    output                                   nou_noc_data_rdy;
    input   [`NOU_TID_WIDTH-1:0]             noc_nou_data_tid;
    input   [`NOU_TYPE_WIDTH-1:0]            noc_nou_data_type;
    input   [`NOU_NOC_DATA_WIDTH-1:0]        noc_nou_data;

// Inbound Response Interface
    input                                    noc_nou_rsp_vld;
    output                                   nou_noc_rsp_rdy;
    input   [`NOU_TID_WIDTH-1:0]             noc_nou_rsp_tid;
    input   [1:0]                            noc_nou_rsp_type;
    input   [`NOU_NOC_RSP_WIDTH-1:0]         noc_nou_rsp;

// NOU AXI Read Address Interface
    output  [`NOU_AXI_ID_WIDTH-1:0]          nou_axi_arid;
    output  [`NOU_AXI_ADDR_WIDTH-1:0]        nou_axi_araddr;
    output  [7:0]                            nou_axi_arlen;
    output  [2:0]                            nou_axi_arsize;
    output  [1:0]                            nou_axi_arburst;
    output  [0:0]                            nou_axi_arlock;
    output  [3:0]                            nou_axi_arcache;
    output  [2:0]                            nou_axi_arprot;
    output  [3:0]                            nou_axi_arqos;
    output  [3:0]                            nou_axi_arregion;
    output  [`NOU_AXI_USER_WIDTH-1:0]        nou_axi_aruser;
    output                                   nou_axi_arvld;
    input                                    axi_nou_arrdy;

// NOU AXI Read Data interface
    input    [`NOU_AXI_ID_WIDTH-1:0]         axi_nou_rid;
    input    [`NOU_AXI_DATA_WIDTH-1:0]       axi_nou_rdata;
    input    [1:0]                           axi_nou_rrsp;
    input                                    axi_nou_rlast;
    input                                    axi_nou_ruser; 
    input                                    axi_nou_rvld;
    output                                   nou_axi_rrdy;


// NOU AXI Write Address Interface
    output   [`NOU_AXI_ID_WIDTH-1:0]         nou_axi_awid;
    output   [`NOU_AXI_ADDR_WIDTH-1:0]       nou_axi_awaddr;
    output   [7:0]                           nou_axi_awlen;
    output   [2:0]                           nou_axi_awsize;
    output   [1:0]                           nou_axi_awburst;
    output   [0:0]                           nou_axi_awlock;
    output   [3:0]                           nou_axi_awcache;
    output   [2:0]                           nou_axi_awprot;
    output   [3:0]                           nou_axi_awqos;
    output   [3:0]                           nou_axi_awregion;
    output   [`NOU_AXI_USER_WIDTH-1:0]       nou_axi_awuser;
    output                                   nou_axi_awvld;
    input                                    axi_nou_awrdy;

// NOU AXI Write Data Interface
    output   [`NOU_AXI_DATA_WIDTH-1:0]       nou_axi_wdata;
    output   [`NOU_AXI_DATA_BYTE_WIDTH-1:0]  nou_axi_wstrb;
    output                                   nou_axi_wlast;
    output                                   nou_axi_wuser;
    output                                   nou_axi_wvld;
    input                                    axi_nou_wrdy;

// NOU AXI Write Response Interface
    input    [`NOU_AXI_ID_WIDTH-1:0]         axi_nou_bid;
    input    [1:0]                           axi_nou_brsp;
    input                                    axi_nou_buser;
    input                                    axi_nou_bvld;
    output                                   nou_axi_brdy;

// Fetch Stage Signals:
wire [1/*valid*/ + `NOU_SID_WIDTH + `NOU_XOCC_CMD_WIDTH + `NOU_UOV_SIZE - 1 : 0]
                xrq_entry_output;
wire            xrq_entry_output_valid;
wire            decode_issue_ack;


// Decode Stage Signals:

// Invalid Request Register (IRR):
wire                                    decode_irr_vld;
wire [`NOU_SID_WIDTH-1:0]               decode_irr_sid;
wire [`NOU_REQ_TYPE_ID_WIDTH-1:0]       decode_irr_rtype;

// Buffer Request Register (BRR):
wire                                    decode_brr_vld;
wire [`NOU_SID_WIDTH-1:0]               decode_brr_sid;
wire [`NOU_BUF_OP_TYPE_WIDTH-1:0]       decode_brr_op_type;
wire [`NOU_BUF_ID_WIDTH-1:0]            decode_brr_buf_id;
wire [`NOU_BUF_ADDR_WIDTH-1:0]          decode_brr_buf_addr;
wire [`NOU_BUF_SZ_WIDTH-1:0]            decode_brr_buf_size;
wire [`NOU_BUF_RM_WIDTH-1:0]            decode_brr_rm; //reclaim mode

// Packet Whitelist Request Register (PWRR):
wire                                    decode_pwrr_vld;
wire [`NOU_SID_WIDTH-1:0]               decode_pwrr_sid;
wire [`NOU_WL_OP_TYPE_WIDTH-1:0]        decode_pwrr_op_type;
wire [`NOU_PKT_ID_WIDTH-1:0]            decode_pwrr_pkt_id;
wire [`NOU_WL_RM_WIDTH-1:0]             decode_pwrr_rm; //reclaim mode

// Send Packet ID Register (SPIDR):
wire                                    decode_spidr_vld;
wire [`NOU_SID_WIDTH-1:0]               decode_spidr_sid;
wire [`NOU_PKT_ID_WIDTH-1:0]            decode_spidr_pkt_id;
wire [`NOU_TILE_ID_WIDTH-1:0]           decode_spidr_src_tile_id;
wire [`NOU_TILE_ID_WIDTH-1:0]           decode_spidr_dst_tile_id;

// Send Packet Request Register (SPRR):
wire                                    decode_sprr_vld;
wire [`NOU_SID_WIDTH-1:0]               decode_sprr_sid;
wire [`NOU_PKT_HEADER_ADDR_WIDTH-1:0]   decode_sprr_pkt_header_addr;
wire [`NOU_PKT_HEADER_SZ_WIDTH-1:0]     decode_sprr_pkt_header_size;
wire [`NOU_PKT_DATA_ADDR_WIDTH-1:0]     decode_sprr_pkt_data_addr;
wire [`NOU_PKT_DATA_SZ_WIDTH-1:0]       decode_sprr_pkt_data_size;

// Buffer Unit and RPU Interface
wire                                    rpu_bu_req_buf_vld;
wire [`NOU_PKT_HEADER_SZ_WIDTH-1:0]     rpu_bu_req_buf_header_size;
wire [`NOU_PKT_DATA_SZ_WIDTH-1:0]       rpu_bu_req_buf_data_size;
wire                                    bu_rpu_gnt_buf_vld;
wire                                    bu_rpu_gnt_buf_status;
wire [`NOU_PKT_HEADER_ADDR_WIDTH-1:0]   bu_rpu_header_buf_addr;
wire [`NOU_PKT_DATA_ADDR_WIDTH-1:0]     bu_rpu_data_buf_addr;
wire [`NOU_ERR_CODE_WIDTH-1:0]          bu_rpu_gnt_buf_err_code;

// Packet Whitelist Unit and RPU Interface
wire                                    rpu_pwu_chk_pkt_vld;
wire [`NOU_PKT_ID_WIDTH-1:0]            rpu_pwu_pkt_id;
wire                                    pwu_rpu_gnt_pkt_vld;
wire                                    pwu_rpu_gnt_pkt_status;

// Retire Stage Signals:

wire [`NOU_UOV_SIZE-1:0]                 retire_decode_uov;

wire                                     retire_irur_keep;
wire                                     irur_retire_vld;
wire [`NOU_SID_WIDTH-1:0]                irur_retire_sid;
wire [`NOU_RSP_TYPE_ID_WIDTH-1:0]        irur_retire_rsp_type;
wire [`NOU_REQ_TYPE_ID_WIDTH-1:0]        irur_retire_req_type;

wire                                     retire_burr_keep;
wire                                     burr_retire_vld;
wire [`NOU_SID_WIDTH-1:0]                burr_retire_sid;
wire [`NOU_RSP_TYPE_ID_WIDTH-1:0]        burr_retire_rsp_type;
wire [`NOU_BUF_ID_WIDTH-1:0]             burr_retire_buf_id;
wire                                     burr_retire_status;
wire [`NOU_ERR_CODE_WIDTH-1:0]           burr_retire_err_code;
wire [`NOU_BUF_RM_WIDTH-1:0]             burr_retire_rm;

wire                                     retire_pwur_keep;
wire                                     pwur_retire_vld;
wire [`NOU_SID_WIDTH-1:0]                pwur_retire_sid;
wire [`NOU_RSP_TYPE_ID_WIDTH-1:0]        pwur_retire_rsp_type;
wire [`NOU_PKT_ID_WIDTH-1:0]             pwur_retire_pkt_id;
wire                                     pwur_retire_status;
wire [`NOU_ERR_CODE_WIDTH-1:0]           pwur_retire_err_code;
wire [`NOU_BUF_RM_WIDTH-1:0]             pwur_retire_rm;

wire                                     retire_spur_keep;   
wire                                     spur_retire_vld;
wire  [`NOU_SID_WIDTH-1:0]               spur_retire_sid;
wire  [`NOU_RSP_TYPE_ID_WIDTH-1:0]       spur_retire_rsp_type;
wire  [`NOU_PKT_ID_WIDTH-1:0]            spur_retire_pkt_id;
wire                                     spur_retire_status;
wire  [`NOU_ERR_CODE_WIDTH-1:0]          spur_retire_err_code;

wire                                     rpu_retire_rcv_pkt_rsp_vld;
wire [`NOU_XOCC_CMD_WIDTH-1:0]           rpu_retire_rcv_pkt_rsp_bus;
wire                                     retire_rpu_gnt_rcv_pkt_rsp;


/********** MODULE INSTANCE DECLARE **************/

// TODO: Add IRU module to handle these signals, connect to ground for now
assign irur_retire_vld = 1'b0;
assign irur_retire_sid = {`NOU_SID_WIDTH{1'b0}};
assign irur_retire_req_type = {`NOU_REQ_TYPE_ID_WIDTH{1'b0}};
assign irur_retire_rsp_type = {`NOU_RSP_TYPE_ID_WIDTH{1'b0}};

nou_fetch
u_fetch(
    .clk(nou_clk),
    .rstn(nou_rstn),

    .req_fifo_nou_data_f1(req_fifo_nou_data_f1),
    .req_fifo_nou_empty_f0(req_fifo_nou_empty_f0),
    .nou_req_fifo_rd_en_f0(nou_req_fifo_rd_en_f0),

    .xrq_entry_output(xrq_entry_output),
    .xrq_entry_output_valid(xrq_entry_output_valid),
    .decode_issue_ack_in(decode_issue_ack)
);


nou_decode
u_decode(
    .clk(nou_clk),
    .rstn(nou_rstn),

    .entry_input(xrq_entry_output),
    .entry_input_valid(xrq_entry_output_valid),
    .decode_issue_ack(decode_issue_ack),
    .unit_output_vector(retire_decode_uov),

    .decode_irr_vld(decode_irr_vld),
    .decode_irr_sid(decode_irr_sid),
    .decode_irr_rtype(decode_irr_rtype),

    .decode_brr_vld(decode_brr_vld),
    .decode_brr_sid(decode_brr_sid),
    .decode_brr_op_type(decode_brr_op_type),
    .decode_brr_buf_id(decode_brr_buf_id),
    .decode_brr_buf_addr(decode_brr_buf_addr),
    .decode_brr_buf_size(decode_brr_buf_size),
    .decode_brr_rm(decode_brr_rm),

    .decode_pwrr_vld(decode_pwrr_vld),
    .decode_pwrr_sid(decode_pwrr_sid),
    .decode_pwrr_op_type(decode_pwrr_op_type),
    .decode_pwrr_pkt_id(decode_pwrr_pkt_id),
    .decode_pwrr_rm(decode_pwrr_rm),

    .decode_spidr_vld(decode_spidr_vld),
    .decode_spidr_sid(decode_spidr_sid),
    .decode_spidr_pkt_id(decode_spidr_pkt_id),
    .decode_spidr_src_tile_id(decode_spidr_src_tile_id),
    .decode_spidr_dst_tile_id(decode_spidr_dst_tile_id),

    .decode_sprr_vld(decode_sprr_vld),
    .decode_sprr_sid(decode_sprr_sid),
    .decode_sprr_pkt_header_addr(decode_sprr_pkt_header_addr),
    .decode_sprr_pkt_header_size(decode_sprr_pkt_header_size),
    .decode_sprr_pkt_data_addr(decode_sprr_pkt_data_addr),
    .decode_sprr_pkt_data_size(decode_sprr_pkt_data_size)
);


nou_bu
u_bu(
    .clk(nou_clk),
    .rstn(nou_rstn),

    .brr_bu_vld(decode_brr_vld),
    .brr_bu_sid(decode_brr_sid),
    .brr_bu_op_type(decode_brr_op_type),
    .brr_bu_buf_id(decode_brr_buf_id),
    .brr_bu_buf_addr(decode_brr_buf_addr),
    .brr_bu_buf_size(decode_brr_buf_size),
    .brr_bu_rm(decode_brr_rm),

    .rpu_bu_req_buf_vld(rpu_bu_req_buf_vld),
    .rpu_bu_req_buf_header_size(rpu_bu_req_buf_header_size),
    .rpu_bu_req_buf_data_size(rpu_bu_req_buf_data_size),
    .bu_rpu_gnt_buf_vld(bu_rpu_gnt_buf_vld),
    .bu_rpu_gnt_buf_status(bu_rpu_gnt_buf_status),
    .bu_rpu_header_buf_addr(bu_rpu_header_buf_addr),
    .bu_rpu_data_buf_addr(bu_rpu_data_buf_addr),
    .bu_rpu_gnt_buf_err_code(bu_rpu_gnt_buf_err_code),

    .retire_burr_keep(retire_burr_keep),
    .burr_retire_vld(burr_retire_vld),
    .burr_retire_sid(burr_retire_sid),
    .burr_retire_rsp_type(burr_retire_rsp_type),
    .burr_retire_buf_id(burr_retire_buf_id),
    .burr_retire_status(burr_retire_status),
    .burr_retire_err_code(burr_retire_err_code),
    .burr_retire_rm(burr_retire_rm)
);


nou_pwu
u_pwu(
    .clk(nou_clk),
    .rstn(nou_rstn),

    .pwrr_pwu_vld(decode_pwrr_vld),
    .pwrr_pwu_sid(decode_pwrr_sid),
    .pwrr_pwu_op_type(decode_pwrr_op_type),
    .pwrr_pwu_pkt_id(decode_pwrr_pkt_id),
    .pwrr_pwu_rm(decode_pwrr_rm),

    .rpu_pwu_chk_pkt_vld(rpu_pwu_chk_pkt_vld),
    .rpu_pwu_pkt_id(rpu_pwu_pkt_id),
    .pwu_rpu_gnt_pkt_vld(pwu_rpu_gnt_pkt_vld),
    .pwu_rpu_gnt_pkt_status(pwu_rpu_gnt_pkt_status),

    .retire_pwur_keep(retire_pwur_keep),
    .pwur_retire_vld(pwur_retire_vld),
    .pwur_retire_sid(pwur_retire_sid),
    .pwur_retire_rsp_type(pwur_retire_rsp_type),
    .pwur_retire_pkt_id(pwur_retire_pkt_id),
    .pwur_retire_status(pwur_retire_status),
    .pwur_retire_err_code(pwur_retire_err_code),
    .pwur_retire_rm(pwur_retire_rm)
);

nou_spu
u_spu(
   .clk(nou_clk),
   .rstn(nou_rstn),
   
   .spidr_spu_vld(decode_spidr_vld),
   .spidr_spu_sid(decode_spidr_sid),
   .spidr_spu_pkt_id(decode_spidr_pkt_id),
   .spidr_spu_src_tile_id(decode_spidr_src_tile_id),
   .spidr_spu_dst_tile_id(decode_spidr_dst_tile_id),
   
   .sprr_spu_vld(decode_sprr_vld),
   .sprr_spu_sid(decode_sprr_sid),
   .sprr_pkt_header_addr(decode_sprr_pkt_header_addr),
   .sprr_pkt_header_sz(decode_sprr_pkt_header_size),
   .sprr_pkt_data_addr(decode_sprr_pkt_data_addr),
   .sprr_pkt_data_sz(decode_sprr_pkt_data_size),

   .spu_noc_data_vld(nou_noc_data_vld),
   .noc_spu_data_rdy(noc_nou_data_rdy),
   .spu_noc_data_tid(nou_noc_data_tid),
   .spu_noc_data_type(nou_noc_data_type),
   .spu_noc_data(nou_noc_data),

   .noc_spu_rsp_vld(noc_nou_rsp_vld),
   .spu_noc_rsp_rdy(nou_noc_rsp_rdy),
   .noc_spu_rsp_tid(noc_nou_rsp_tid),
   .noc_spu_rsp_type(noc_nou_rsp_type), 
   .noc_spu_rsp(noc_nou_rsp),

   .spu_axi_arid(nou_axi_arid),
   .spu_axi_araddr(nou_axi_araddr),
   .spu_axi_arlen(nou_axi_arlen),
   .spu_axi_arsize(nou_axi_arsize),
   .spu_axi_arburst(nou_axi_arburst),
   .spu_axi_arlock(nou_axi_arlock),
   .spu_axi_arcache(nou_axi_arcache),
   .spu_axi_arprot(nou_axi_arprot),
   .spu_axi_arqos(nou_axi_arqos),
   .spu_axi_arregion(nou_axi_arregion),
   .spu_axi_aruser(nou_axi_aruser),
   .spu_axi_arvld(nou_axi_arvld),
   .axi_spu_arrdy(axi_nou_arrdy),

//
   .axi_spu_rid(axi_nou_rid),
   .axi_spu_rdata(axi_nou_rdata),
   .axi_spu_rrsp(axi_nou_rrsp),
   .axi_spu_rlast(axi_nou_rlast),
   .axi_spu_ruser(axi_nou_ruser), 
   .axi_spu_rvld(axi_nou_rvld),
   .spu_axi_rrdy(nou_axi_rrdy),

//
   .retire_spur_keep(retire_spur_keep),
   .spur_retire_vld(spur_retire_vld),
   .spur_retire_sid(spur_retire_sid),
   .spur_retire_rsp_type(spur_retire_rsp_type),
   .spur_retire_pkt_id(spur_retire_pkt_id),
   .spur_retire_status(spur_retire_status),
   .spur_retire_err_code(spur_retire_err_code)

   );

nou_retire
u_retire(
    .irur_retire_vld(irur_retire_vld),
    .irur_retire_sid(irur_retire_sid),
    .irur_retire_rsp_type(irur_retire_rsp_type),
    .irur_retire_req_type(irur_retire_req_type),

    .burr_retire_vld(burr_retire_vld),
    .burr_retire_sid(burr_retire_sid),
    .burr_retire_rsp_type(burr_retire_rsp_type),
    .burr_retire_buf_id(burr_retire_buf_id),
    .burr_retire_status(burr_retire_status),
    .burr_retire_err_code(burr_retire_err_code),
    .burr_retire_rm(burr_retire_rm),

    .pwur_retire_vld(pwur_retire_vld),
    .pwur_retire_sid(pwur_retire_sid),
    .pwur_retire_rsp_type(pwur_retire_rsp_type),
    .pwur_retire_pkt_id(pwur_retire_pkt_id),
    .pwur_retire_status(pwur_retire_status),
    .pwur_retire_err_code(pwur_retire_err_code),
    .pwur_retire_rm(pwur_retire_rm),

    .spur_retire_vld(spur_retire_vld),
    .spur_retire_sid(spur_retire_sid),
    .spur_retire_rsp_type(spur_retire_rsp_type),
    .spur_retire_pkt_id(spur_retire_pkt_id),
    .spur_retire_status(spur_retire_status),
    .spur_retire_err_code(spur_retire_err_code),

    .rpu_retire_rcv_pkt_rsp_vld(rpu_retire_rcv_pkt_rsp_vld),
    .rpu_retire_rcv_pkt_rsp_bus(rpu_retire_rcv_pkt_rsp_bus),
    .retire_rpu_gnt_rcv_pkt_rsp(retire_rpu_gnt_rcv_pkt_rsp),

    .rsp_fifo_retire_full(rsp_fifo_nou_full),
    .retire_rsp_fifo_wr_en(nou_rsp_fifo_wr_en),
    .retire_rsp_fifo_data(nou_rsp_fifo_data),

    .retire_decode_uov(retire_decode_uov),

    .retire_irur_keep(retire_irur_keep),
    .retire_burr_keep(retire_burr_keep),
    .retire_pwur_keep(retire_pwur_keep),
    .retire_spur_keep(retire_spur_keep)
);

nou_rpu
u_rpu(
    .clk(nou_clk),
    .rstn(nou_rstn),

    .or_valid(nou_noc_rsp_vld),
    .or_dat_tid(nou_noc_rsp_tid),
    .or_dat_type(nou_noc_rsp_type),
    .or_dat_data(nou_noc_rsp),
    .or_ready(noc_nou_rsp_rdy),

    .id_valid(noc_nou_data_vld),
    .id_dat_tid(noc_nou_data_tid),
    .id_dat_type(noc_nou_data_type),
    .id_dat_data(noc_nou_data),
    .id_ready(nou_noc_data_rdy),

    .rcv_pkt_rsp_bus(rpu_retire_rcv_pkt_rsp_bus),
    .rcv_pkt_rsp_vld(rpu_retire_rcv_pkt_rsp_vld),
    .gnt_rcv_pkt_rsp(retire_rpu_gnt_rcv_pkt_rsp),

    .req_buf_vld(rpu_bu_req_buf_vld),
    .req_buf_header_size(rpu_bu_req_buf_header_size),
    .req_buf_data_size(rpu_bu_req_buf_data_size),
    .gnt_buf_vld(bu_rpu_gnt_buf_vld),
    .gnt_buf_status(bu_rpu_gnt_buf_status),
    .header_buf_addr(bu_rpu_header_buf_addr),
    .data_buf_addr(bu_rpu_data_buf_addr),
    .err_code(bu_rpu_gnt_buf_err_code),

    .chk_pkt_vld(rpu_pwu_chk_pkt_vld),
    .chk_pkt_id(rpu_pwu_pkt_id),
    .gnt_pkt_vld(pwu_rpu_gnt_pkt_vld),
    .gnt_pkt_status(pwu_rpu_gnt_pkt_status),

    .axi_awid(nou_axi_awid),
    .axi_awaddr(nou_axi_awaddr),
    .axi_awlen(nou_axi_awlen),
    .axi_awsize(nou_axi_awsize),
    .axi_awburst(nou_axi_awburst),
    .axi_awlock(nou_axi_awlock),
    .axi_awcache(nou_axi_awcache),
    .axi_awprot(nou_axi_awprot),
    .axi_awqos(nou_axi_awqos),
    .axi_awregion(nou_axi_awregion),
    .axi_awuser(nou_axi_awuser),
    .axi_awvld(nou_axi_awvld),
    .axi_awrdy(axi_nou_awrdy),

    .axi_wdata(nou_axi_wdata),
    .axi_wstrb(nou_axi_wstrb),
    .axi_wlast(nou_axi_wlast),
    .axi_wuser(nou_axi_wuser), 
    .axi_wvld(nou_axi_wvld),
    .axi_wrdy(axi_nou_wrdy),

    .axi_bid(axi_nou_bid),
    .axi_buser(axi_nou_buser),
    .axi_bresp(axi_nou_brsp),
    .axi_bvld(axi_nou_bvld),
    .axi_brdy(nou_axi_brdy)
);


endmodule

