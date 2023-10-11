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

module nou_rpu 
(
    input  wire                                 clk,
    input  wire                                 rstn,

    // Outbound response channel to router
    output logic                                or_valid,
    output logic [`NOU_TID_WIDTH-1:0]           or_dat_tid,
    output logic [`NOU_TYPE_WIDTH-1:0]          or_dat_type,
    output logic [`NOU_NOC_RSP_WIDTH-1:0]       or_dat_data,
    input logic                                 or_ready,

    // Inbound data channel from router
    input logic                                 id_valid,
    input logic [`NOU_TID_WIDTH-1:0]            id_dat_tid,
    input logic [`NOU_TYPE_WIDTH-1:0]           id_dat_type,
    input logic [`NOU_NOC_DATA_WIDTH-1:0]       id_dat_data,
    output logic                                id_ready,

    // Signals to/from retire unit
    output logic [`NOU_XOCC_CMD_WIDTH-1:0]      rcv_pkt_rsp_bus,
    output logic                                rcv_pkt_rsp_vld,
    input logic                                 gnt_rcv_pkt_rsp,

    // Signals to buffer unit
    output logic                                req_buf_vld,
    output logic [`NOU_PKT_HEADER_SZ_WIDTH-1:0] req_buf_header_size,
    output logic [`NOU_PKT_DATA_SZ_WIDTH-1:0]   req_buf_data_size,

    // Signals from buffer unit
    input logic                                 gnt_buf_vld,
    input logic                                 gnt_buf_status,
    input logic [`NOU_PKT_HEADER_ADDR_WIDTH-1:0] header_buf_addr,
    input logic [`NOU_PKT_DATA_ADDR_WIDTH-1:0]  data_buf_addr,
    input logic [`NOU_ERR_CODE_WIDTH-1:0]       err_code,

    // Signals to packet whitelist unit
    output logic                                chk_pkt_vld,
    output logic [`NOU_PKT_ID_WIDTH-1:0]        chk_pkt_id,

    // Signals from packet whitelist unit
    input logic                                 gnt_pkt_vld,
    input logic                                 gnt_pkt_status,

    // Signals to/from AXI interface
    output logic [`NOU_AXI_ID_WIDTH-1:0]        axi_awid,
    output logic [`NOU_AXI_ADDR_WIDTH-1:0]      axi_awaddr,
    output logic [7:0]                          axi_awlen,
    output logic [2:0]                          axi_awsize,
    output logic [1:0]                          axi_awburst,
    output logic [0:0]                          axi_awlock,
    output logic [3:0]                          axi_awcache,
    output logic [2:0]                          axi_awprot,
    output logic [3:0]                          axi_awqos,
    output logic [3:0]                          axi_awregion,
    output logic [`NOU_AXI_USER_WIDTH-1:0]      axi_awuser,
    output logic                                axi_awvld,
    input  logic                                axi_awrdy,

    output logic [`NOU_AXI_DATA_WIDTH-1:0]      axi_wdata,
    output logic [`NOU_AXI_DATA_BYTE_WIDTH-1:0] axi_wstrb,
    output logic                                axi_wlast,
    output logic                                axi_wuser, 
    output logic                                axi_wvld,
    input  logic                                axi_wrdy,
    
    input logic [`NOU_AXI_ID_WIDTH-1:0]         axi_bid,
    input logic                                 axi_buser,
    input logic [1:0]                           axi_bresp,
    input logic                                 axi_bvld,
    output logic                                axi_brdy
);

/********** SIGNAL DECLARE **************/

    logic ib_vld;
    logic [`NOU_TYPE_WIDTH-1:0] ib_type;
    logic lreg_vld;
    logic [`NOU_TID_WIDTH-1:0] trans_id;
    logic [`NOU_TILE_ID_WIDTH-1:0] local_tile_id;
    logic [`NOU_TILE_ID_WIDTH-1:0] dst_tile_id;
    logic [`NOU_PKT_ID_WIDTH-1:0] pkt_id;
    logic [`NOU_PKT_HEADER_SZ_WIDTH-1:0] header_size;
    logic [`NOU_PKT_DATA_SZ_WIDTH-1:0] data_size;
    logic [`NOU_FLIT_SZ_WIDTH-1:0] flit_num;

    logic [`NOU_TID_WIDTH-1:0] rpur_trans_id;
    logic [`NOU_TILE_ID_WIDTH-1:0] rpur_local_tile_id;
    logic [`NOU_TILE_ID_WIDTH-1:0] rpur_dst_tile_id;
    logic [`NOU_PKT_ID_WIDTH-1:0] rpur_pkt_id;
    logic [`NOU_PKT_HEADER_SZ_WIDTH-1:0] rpur_pkt_header_size;
    logic [`NOU_PKT_DATA_SZ_WIDTH-1:0] rpur_pkt_data_size;
    logic [`NOU_PKT_HEADER_ADDR_WIDTH-1:0] rpur_header_buf_addr;
    logic [`NOU_PKT_DATA_ADDR_WIDTH-1:0] rpur_data_buf_addr;
    logic [`NOU_FLIT_SZ_WIDTH-1:0] rpur_pkt_flit_num;

    logic ob_rsp_vld;
    logic [`NOU_TYPE_WIDTH-1:0] ob_rsp_type;
    logic ob_rsp_status;
    logic [`NOU_ERR_CODE_WIDTH-1:0] ob_rsp_err;

    logic [`NOU_XOCC_CMD_WIDTH-1:0] rcv_pkt_encode_out;
    logic [`NOU_XOCC_CMD_WIDTH-1:0] rcv_pkt_id_encode_out;
    logic rcv_pkt_id_vld;
    logic rcv_pkt_vld;
    logic sel_rcv_rsp;

    logic start_aw;
    logic pb_full;
    logic pb_empty;
    logic wr_en;
    logic rd_en;
    logic write_done;
    logic write_err;
    logic [`NOU_NOC_DATA_WIDTH-1:0] pb_data;

    // Inbound data channel decoder
    rpu_ibd_decoder i_ibd_decoder (
        // inputs
        .id_valid(id_valid),
        .id_dat_tid(id_dat_tid),
        .id_dat_type(id_dat_type),
        .id_dat_data(id_dat_data),
        .id_ready(id_ready),
        // outputs 
        .ib_vld(ib_vld),
        .ib_type(ib_type),
        .lreg_vld(lreg_vld),
        .trans_id(trans_id),
        .local_tile_id(local_tile_id),
        .dst_tile_id(dst_tile_id),
        .pkt_id(pkt_id),
        .pkt_header_size(header_size),
        .pkt_data_size(data_size),
        .pkt_flit_num(flit_num)
    );

    rpu_reg i_reg (
        // inputs
        .clk(clk),
        .rstn(rstn),
        .lreg_vld(lreg_vld),
        .trans_id(trans_id),
        .local_tile_id(local_tile_id),
        .dst_tile_id(dst_tile_id),
        .pkt_id(pkt_id),
        .pkt_header_size(header_size),
        .pkt_data_size(data_size),
        .pkt_flit_num(flit_num),
        .gnt_buf_vld(gnt_buf_vld),
        .gnt_buf_status(gnt_buf_status),
        .header_buf_addr(header_buf_addr),
        .data_buf_addr(data_buf_addr),
        // outputs
        .trans_id_q(rpur_trans_id),
        .local_tile_id_q(rpur_local_tile_id),
        .dst_tile_id_q(rpur_dst_tile_id),
        .pkt_id_q(rpur_pkt_id),
        .pkt_header_size_q(rpur_pkt_header_size),
        .pkt_data_size_q(rpur_pkt_data_size),
        .pkt_flit_num_q(rpur_pkt_flit_num),
        .header_buf_addr_q(rpur_header_buf_addr),
        .data_buf_addr_q(rpur_data_buf_addr)
    );

    rpu_or_encode i_or_encode (
        // inputs
        .ob_rsp_vld(ob_rsp_vld),
        .ob_rsp_type(ob_rsp_type),
        .ob_rsp_status(ob_rsp_status),
        .ob_rsp_err(ob_rsp_err),
        .cur_trans_id(rpur_trans_id),
        .cur_dst_tile_id(rpur_dst_tile_id),
        // outputs
        .or_valid(or_valid),
        .or_dat_tid(or_dat_tid),
        .or_dat_type(or_dat_type),
        .or_dat_data(or_dat_data)
    );

    rpu_rcv_pkt_encode i_rcv_pkt_encode (
        // inputs
        .pkt_header_size(rpur_pkt_header_size),
        .pkt_data_size(rpur_pkt_data_size),
        .header_buf_addr(rpur_header_buf_addr),
        .data_buf_addr(rpur_data_buf_addr),
        // outputs
        .rcv_pkt_encode_out(rcv_pkt_encode_out)
    );

    rpu_rcv_pkt_id_encode i_rcv_pkt_id_encode (
        // inputs
        .local_tile_id(rpur_local_tile_id),
        .dst_tile_id(rpur_dst_tile_id),
        .pkt_id(rpur_pkt_id),
        // outputs
        .rcv_pkt_id_encode_out(rcv_pkt_id_encode_out)
    );

    rpu_ctl i_ctl (
        .clk(clk),
        .rstn(rstn),

        .start_aw(start_aw),

        .or_ready(or_ready),
        .ob_rsp_vld(ob_rsp_vld),
        .ob_rsp_type(ob_rsp_type),
        .ob_rsp_status(ob_rsp_status),
        .ob_rsp_err(ob_rsp_err),

        .ib_vld(ib_vld),
        .ib_type(ib_type),
        .pb_full(pb_full),
        .write_done(write_done),
        .write_err(write_err),
        .wr_en(wr_en),
        .id_ready(id_ready),

        .gnt_buf_vld(gnt_buf_vld),
        .gnt_buf_status(gnt_buf_status),
        .err_code(err_code),
        .gnt_pkt_vld(gnt_pkt_vld),
        .gnt_pkt_status(gnt_pkt_status),
        .chk_pkt_vld(chk_pkt_vld),
        .req_buf_vld(req_buf_vld),

        .gnt_rcv_pkt_rsp(gnt_rcv_pkt_rsp),
        .rcv_pkt_id_vld(rcv_pkt_id_vld),
        .rcv_pkt_vld(rcv_pkt_vld),
        .sel_rcv_rsp(sel_rcv_rsp)
    );

    axi_write_master i_axi_write_master (
        .clk(clk),
        .rstn(rstn),
        .start_aw(start_aw),
        .wr_done(write_done),
        .wr_err(write_err),
        .pkt_header_addr(rpur_header_buf_addr),
        .pkt_header_sz(rpur_pkt_header_size),
        .pkt_data_addr(rpur_data_buf_addr),
        .pkt_data_sz(rpur_pkt_data_size),
        .pb_empty(pb_empty),
        .pb_rd_en(rd_en),
        .data_flit(pb_data),

        .axi_awid(axi_awid),
        .axi_awaddr(axi_awaddr),
        .axi_awlen(axi_awlen),
        .axi_awsize(axi_awsize),
        .axi_awburst(axi_awburst),
        .axi_awlock(axi_awlock),
        .axi_awcache(axi_awcache),
        .axi_awprot(axi_awprot),
        .axi_awqos(axi_awqos),
        .axi_awregion(axi_awregion),
        .axi_awuser(axi_awuser),
        .axi_awvld(axi_awvld),
        .axi_awrdy(axi_awrdy),

        .axi_wdata(axi_wdata),
        .axi_wstrb(axi_wstrb),
        .axi_wlast(axi_wlast),
        .axi_wuser(axi_wuser),
        .axi_wvld(axi_wvld),
        .axi_wrdy(axi_wrdy),

        .axi_bid(axi_bid),
        .axi_buser(axi_buser),
        .axi_bresp(axi_bresp),
        .axi_bvld(axi_bvld),
        .axi_brdy(axi_brdy)
    );

`ifdef XILINX_FPGA
    packet_buffer_512x16 i_packet_buffer (
      .clk(clk),              // input wire wr_clk
      .srst(~rstn),              // input wire wr_rst
      .din(id_dat_data),                    // input wire [511 : 0] din
      .wr_en(wr_en),                // input wire wr_en
      .rd_en(rd_en),                // input wire rd_en
      .dout(pb_data),                  // output wire [511 : 0] dout
      .full(pb_full),                  // output wire full
      .almost_full(),    // output wire almost_full
      .empty(pb_empty),                // output wire empty
      .almost_empty()  // output wire almost_empty
    );
`else
    fwft_fifo #(
        .WIDTH(`NOU_AXI_DATA_WIDTH),
        .DEPTH(`NOU_PKT_BUF_SIZE_LOG2)
    ) i_packet_buffer (
        .clk(clk),              // input wire wr_clk
        .rstn(rstn),              // input wire wr_rst
        .din(id_dat_data),                    // input wire [511 : 0] din
        .wr_en(wr_en),                // input wire wr_en
        .rd_en(rd_en),                // input wire rd_en
        .dout(pb_data),                  // output wire [511 : 0] dout
        .full(pb_full),                  // output wire full
        .empty(pb_empty)                // output wire empty
    );
`endif

    assign chk_pkt_id = rpur_pkt_id;
    assign req_buf_header_size = rpur_pkt_header_size;
    assign req_buf_data_size = rpur_pkt_data_size;

    assign rcv_pkt_rsp_bus = sel_rcv_rsp ? rcv_pkt_encode_out : rcv_pkt_id_encode_out;
    assign rcv_pkt_rsp_vld = sel_rcv_rsp ? rcv_pkt_vld : rcv_pkt_id_vld; 

endmodule
