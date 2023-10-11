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

module nou_spu 
(
    input  wire clk,
    input  wire rstn,

// SPIDR Interface
    input  wire                                             spidr_spu_vld,
    input  wire [`NOU_SID_WIDTH-1:0]                        spidr_spu_sid,
    input  wire [`NOU_PKT_ID_WIDTH-1:0]                     spidr_spu_pkt_id,
    input  wire [`NOU_TILE_ID_WIDTH-1:0]                    spidr_spu_src_tile_id, 
    input  wire [`NOU_TILE_ID_WIDTH-1:0]                    spidr_spu_dst_tile_id,

// SPRR Interface
    input  wire                                             sprr_spu_vld,
    input  wire [`NOU_SID_WIDTH-1:0]                        sprr_spu_sid,
    input  wire [`NOU_PKT_HEADER_ADDR_WIDTH-1:0]            sprr_pkt_header_addr,
    input  wire [`NOU_PKT_HEADER_SZ_WIDTH-1:0]              sprr_pkt_header_sz,
    input  wire [`NOU_PKT_DATA_ADDR_WIDTH-1:0]              sprr_pkt_data_addr,
    input  wire [`NOU_PKT_DATA_SZ_WIDTH-1:0]                sprr_pkt_data_sz,

// Outbound Data Interface
    output wire                                             spu_noc_data_vld,
    input  wire                                             noc_spu_data_rdy,
    output wire [`NOU_TID_WIDTH-1:0]                        spu_noc_data_tid,
    output wire [1:0]                                       spu_noc_data_type,
    output wire [`NOU_NOC_DATA_WIDTH-1:0]                   spu_noc_data,

// Inbound Response Interface
    input  wire                                             noc_spu_rsp_vld,
    output wire                                             spu_noc_rsp_rdy,
    input  wire [`NOU_TID_WIDTH-1:0]                        noc_spu_rsp_tid,
    input  wire [1:0]                                       noc_spu_rsp_type,
    input  wire [`NOU_NOC_RSP_WIDTH-1:0]                    noc_spu_rsp,

// NOU AXI Read Address Interface
    output wire [`NOU_AXI_ID_WIDTH-1:0]                     spu_axi_arid,
    output wire [`NOU_AXI_ADDR_WIDTH-1:0]                   spu_axi_araddr,
    output wire [7:0]                                       spu_axi_arlen,
    output wire [2:0]                                       spu_axi_arsize,
    output wire [1:0]                                       spu_axi_arburst,
    output wire [0:0]                                       spu_axi_arlock,
    output wire [3:0]                                       spu_axi_arcache,
    output wire [2:0]                                       spu_axi_arprot,
    output wire [3:0]                                       spu_axi_arqos,
    output wire [3:0]                                       spu_axi_arregion,
    output wire [`NOU_AXI_USER_WIDTH-1:0]                   spu_axi_aruser,
    output wire                                             spu_axi_arvld,
    input  wire                                             axi_spu_arrdy,

// NOU AXI Read Data interface
    input  wire  [`NOU_AXI_ID_WIDTH-1:0]                        axi_spu_rid,
    input  wire  [`NOU_AXI_DATA_WIDTH-1:0]                      axi_spu_rdata,
    input  wire  [1:0]                                      axi_spu_rrsp,
    input  wire                                             axi_spu_rlast,
    input  wire                                             axi_spu_ruser, 
    input  wire                                             axi_spu_rvld,
    output wire                                             spu_axi_rrdy,

// SPUR interface
    input  wire                                             retire_spur_keep,
    output wire                                             spur_retire_vld,
    output wire  [`NOU_SID_WIDTH-1:0]                       spur_retire_sid,
    output wire  [`NOU_RSP_TYPE_ID_WIDTH-1:0]               spur_retire_rsp_type,
    output wire  [`NOU_PKT_ID_WIDTH-1:0]                    spur_retire_pkt_id,
    output wire                                             spur_retire_status,
    output wire  [`NOU_ERR_CODE_WIDTH-1:0]                  spur_retire_err_code

);

/********** SIGNAL DECLARE **************/
wire [`NOU_SID_WIDTH-1:0]     spu_reg_sid;
wire [`NOU_PKT_ID_WIDTH-1:0]  spu_reg_pkt_id;
wire [`NOU_TILE_ID_WIDTH-1:0] spu_reg_src_tile_id; 
wire [`NOU_TILE_ID_WIDTH-1:0] spu_reg_dst_tile_id;

wire [`NOU_PKT_HEADER_ADDR_WIDTH-1:0] spu_reg_pkt_header_addr;
wire [`NOU_PKT_HEADER_SZ_WIDTH-1:0]   spu_reg_pkt_header_sz;
wire [`NOU_PKT_DATA_ADDR_WIDTH-1:0]   spu_reg_pkt_data_addr;
wire [`NOU_PKT_DATA_SZ_WIDTH-1:0]     spu_reg_pkt_data_sz;
wire [`NOU_TID_WIDTH-1:0]             spu_reg_trans_id;

wire [`NOU_TID_WIDTH-1:0]        ibr_reg_trans_id;
wire [`NOU_TILE_ID_WIDTH-1:0]    ibr_reg_dst_tile_id;
wire                             ibr_reg_status;
wire [`NOU_ERR_CODE_WIDTH-1:0]   ibr_reg_err_code;

wire sel_outbound;
wire head_flt_vld;
wire [`NOU_NOC_DATA_WIDTH-1:0] head_flt_data;
wire data_flt_vld;
wire rd_pb_en;
wire pb_empty;
wire almost_pb_empty;
wire pb_full;
wire almost_pb_full;
wire wr_pb_en;
wire [`NOU_NOC_DATA_WIDTH-1:0]  arm_pb_data_flt;
wire [`NOU_NOC_DATA_WIDTH-1:0]  pb_data_flt;
wire data_flt_gate;

wire start_read_sram;
wire read_sram_done;
wire read_sram_err;

wire head_flt_to;
wire data_flt_to; 
wire read_sram_to; 
wire pkt_req_to;
wire read_sram_error; 
wire miss_routing_req;

wire pkt_result_ok;
wire pkt_result_err;
wire head_flt_rsp_to;
wire data_flt_rsp_to;
wire trans_id_mismatch;
wire tile_id_mismatch;

wire pkt_res_vld;
wire [`NOU_SID_WIDTH-1:0]         pkt_res_sid;
wire [`NOU_PKT_ID_WIDTH-1:0]      pkt_res_pkid;
wire [`NOU_RSP_TYPE_ID_WIDTH-1:0] pkt_res_type;
wire pkt_res_status;
wire [`NOU_ERR_CODE_WIDTH-1:0]    pkt_res_err_code; 

wire [`NOU_PKT_FLIT_WIDTH-1:0]      header_flits;
wire [`NOU_PKT_HEADER_SZ_WIDTH : 0] ext_header_sz;
wire [`NOU_PKT_FLIT_WIDTH-1:0]      data_flits; 
wire [`NOU_PKT_FLIT_WIDTH-1:0]      packet_flits;
assign ext_header_sz = {1'b0, spu_reg_pkt_header_sz};
assign header_flits  = (ext_header_sz + 8'h40) >> 6;
assign data_flits    = ({6'b0, spu_reg_pkt_data_sz} + 1'b1) << 4;
assign packet_flits  = header_flits + data_flits;
 
spu_reg
u_reg(
    .clk(clk),
    .rstn(rstn),
    .spidr_vld(spidr_spu_vld),
    .spidr_sid(spidr_spu_sid),
    .spidr_pkt_id(spidr_spu_pkt_id),
    .spidr_src_tile_id(spidr_spu_src_tile_id),
    .spidr_dst_tile_id(spidr_spu_dst_tile_id),

    .sprr_vld(sprr_spu_vld),
    .sprr_sid(sprr_spu_sid),
    .sprr_pkt_header_addr(sprr_pkt_header_addr),
    .sprr_pkt_header_sz(sprr_pkt_header_sz),
    .sprr_pkt_data_addr(sprr_pkt_data_addr),
    .sprr_pkt_data_sz(sprr_pkt_data_sz),

    .sid_q(spu_reg_sid),
    .pkt_id_q(spu_reg_pkt_id),
    .src_tile_id_q(spu_reg_src_tile_id), 
    .dst_tile_id_q(spu_reg_dst_tile_id),

    .pkt_header_addr_q(spu_reg_pkt_header_addr),
    .pkt_header_sz_q(spu_reg_pkt_header_sz),
    .pkt_data_addr_q(spu_reg_pkt_data_addr),
    .pkt_data_sz_q(spu_reg_pkt_data_sz),
    .trans_id_q(spu_reg_trans_id)
);

spu_ibr_reg
u_ibr_reg(
     .clk(clk),
     .rstn(rstn),
     
     .ib_rsp_vld(noc_spu_rsp_vld),
     .ib_rsp_tid(noc_spu_rsp_tid), 
     .ib_rsp(noc_spu_rsp), 

     .trans_id_q(ibr_reg_trans_id), 
     .dst_tile_id_q(ibr_reg_dst_tile_id), 
     .rsp_status_q(ibr_reg_status), 
     .rsp_err_code_q(ibr_reg_err_code)
);

spu_ctl
u_sctl(
      .clk(clk), 
      .rstn(rstn), 
      
      .spidr_vld(spidr_spu_vld), 
      .sprr_vld(sprr_spu_vld), 
      .retire_keep(retire_spur_keep),
        
      .sel_od(sel_outbound),
      .head_flt_vld(head_flt_vld), 
      .data_flt_vld(data_flt_vld), 
      .od_vld(spu_noc_data_vld), 
      .od_rdy(noc_spu_data_rdy), 

      .rd_pb_en(rd_pb_en),
      .pb_empty(pb_empty),
      .start_read_sram(start_read_sram), 
      .read_sram_done(read_sram_done), 
      .read_sram_err(read_sram_err), 
    
      .head_flt_timeout(head_flt_to),
      .data_flt_timeout(data_flt_to), 
      .read_sram_timeout(read_sram_to), 
      .pkt_req_timeout(pkt_req_to),
      .read_sram_error(read_sram_error), 
      .miss_routing_req(miss_routing_req)
      );

axi_read_master
u_axi_read(
          .clk(clk), 
          .rstn(rstn),
        
          .start_rd(start_read_sram),   
          .rd_done(read_sram_done), 
          .rd_err(read_sram_err), 
          
          .pkt_header_addr(spu_reg_pkt_header_addr),
          .pkt_header_sz(spu_reg_pkt_header_sz),
          .pkt_data_addr(spu_reg_pkt_data_addr), 
          .pkt_data_sz(spu_reg_pkt_data_sz),
          
          .pb_full(pb_full),
          .wr_pb_en(wr_pb_en),
          .data_flt(arm_pb_data_flt),
        
          .axi_arid(spu_axi_arid), 
          .axi_araddr(spu_axi_araddr),
          .axi_arlen(spu_axi_arlen), 
          .axi_arsize(spu_axi_arsize),
          .axi_arburst(spu_axi_arburst),
          .axi_arlock(spu_axi_arlock),
          .axi_arcache(spu_axi_arcache),
          .axi_arprot(spu_axi_arprot),
          .axi_arqos(spu_axi_arqos),
          .axi_arregion(spu_axi_arregion),
          .axi_aruser(spu_axi_aruser), 
          .axi_arvld(spu_axi_arvld),
          .axi_arrdy(axi_spu_arrdy),
          
          .axi_rid(axi_spu_rid),
          .axi_rdata(axi_spu_rdata),
          .axi_rrsp(axi_spu_rrsp),
          .axi_rlast(axi_spu_rlast), 
          .axi_ruser(axi_spu_ruser), 
          .axi_rvld(axi_spu_rvld),
          .axi_rrdy(spu_axi_rrdy)
          );

`ifdef XILINX_FPGA
packet_buffer_512x16 u_pb (
  .clk(clk),              // input wire wr_clk
  .srst(~rstn),              // input wire wr_rst
  .din(arm_pb_data_flt),                    // input wire [511 : 0] din
  .wr_en(wr_pb_en),                // input wire wr_en
  .rd_en(rd_pb_en),                // input wire rd_en
  .dout(pb_data_flt),                  // output wire [511 : 0] dout
  .full(pb_full),                  // output wire full
  .almost_full(),    // output wire almost_full
  .empty(pb_empty),                // output wire empty
  .almost_empty()  // output wire almost_empty
);
`else
fwft_fifo #(`NOU_AXI_DATA_WIDTH, `NOU_PKT_BUF_SIZE_LOG2) //sim model
u_pb(
  .clk(clk),              // input wire wr_clk
  .rstn(rstn),            // input wire wr_rst
  .din(arm_pb_data_flt),  // input wire [511 : 0] din
  .wr_en(wr_pb_en),       // input wire wr_en
  .rd_en(rd_pb_en),       // input wire rd_en
  .dout(pb_data_flt),     // output wire [511 : 0] dout
  .full(pb_full),         // output wire full
  .empty(pb_empty)        // output wire empty
);
`endif

spu_result_encode 
u_result_encode (
    .sid(spu_reg_sid),
    .pkt_id(spu_reg_pkt_id), 
    .rsp_err_code(ibr_reg_err_code),

    .pkt_result_ok(pkt_result_ok),
    .pkt_result_err(pkt_result_err),
    .head_flt_rsp_to(head_flt_rsp_to), 
    .data_flt_rsp_to(data_flt_rsp_to), 
    .trans_id_mismatch(trans_id_mismatch), 
    .tile_id_mismatch(tile_id_mismatch), 
    
    .snd_head_flt_timeout(head_flt_to), 
    .snd_data_flt_timeout(data_flt_to), 
    .read_sram_timeout(read_sram_to), 
    .miss_pkt_req(pkt_req_to), 
    .read_sram_error(read_sram_error), 
    .miss_routing_req(miss_routing_req),
    
    .result_vld(pkt_res_vld), 
    .res_sid(pkt_res_sid),
    .res_type(pkt_res_type),
    .res_pkt_id(pkt_res_pkid),
    .res_status(pkt_res_status),
    .res_err_code(pkt_res_err_code)
);

spu_spur
u_spur (
    .clk(clk),
    .rstn(rstn),

    .vld(pkt_res_vld), 
    .retire_keep(retire_spur_keep), 
    .sid(pkt_res_sid), 
    .rtype(pkt_res_type), 
    .pkt_id(pkt_res_pkid),
    .status(pkt_res_status), 
    .err_code(pkt_res_err_code), 

    .vld_q(spur_retire_vld), 
    .sid_q(spur_retire_sid), 
    .rtype_q(spur_retire_rsp_type), 
    .pkt_id_q(spur_retire_pkt_id), 
    .status_q(spur_retire_status), 
    .err_code_q(spur_retire_err_code)
);


spu_ibr_ctl
u_ibr_ctl(
         .clk(clk), 
         .rstn(rstn), 
         .retire_keep(retire_spur_keep),          
         .ib_rsp_vld(noc_spu_rsp_vld), 
         .ib_rsp_rdy(spu_noc_rsp_rdy),

         .ib_rsp_type(noc_spu_rsp_type), 
         .ib_rsp_tid(ibr_reg_trans_id),
         .ib_rsp_dst_tile_id(ibr_reg_dst_tile_id),
         .ib_rsp_status(ibr_reg_status), 
         
         .req_trans_id(spu_reg_trans_id), 
         .local_tile_id(spu_reg_src_tile_id),
         .pkt_result_ok(pkt_result_ok),
         .pkt_result_err(pkt_result_err), 
         .head_flt_rsp_to(head_flt_rsp_to), 
         .data_flt_rsp_to(data_flt_rsp_to), 
         .trans_id_mismatch(trans_id_mismatch), 
         .tile_id_mismatch(tile_id_mismatch)
         );

assign spu_noc_data_vld = (sel_outbound) ?  data_flt_vld : head_flt_vld; 
assign spu_noc_data_tid = spu_reg_trans_id;
assign spu_noc_data_type = (sel_outbound) ? `DATA_FLIT_TYPE : `HEAD_FLIT_TYPE;
assign head_flt_data[9:0]    = spu_reg_dst_tile_id;
assign head_flt_data[19:10]  = spu_reg_src_tile_id;
assign head_flt_data[31:20]  = packet_flits;
assign head_flt_data[39:32]  = spu_reg_pkt_header_sz;
assign head_flt_data[45:40]  = spu_reg_pkt_data_sz;
assign head_flt_data[95:64]  = spu_reg_pkt_id;
assign spu_noc_data = (sel_outbound) ? pb_data_flt : head_flt_data; 

endmodule

