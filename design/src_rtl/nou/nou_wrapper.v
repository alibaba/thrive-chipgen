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

`include "xocc_define.h"
`include "nou_define.h"

module nou_wrapper (
	nou_clk,
	nou_rstn,
	dsa_xocc_cmd_in,
    dsa_cmd_fifo_empty,
    dsa_rsp_fifo_full,
	dsa_cmd_fifo_rd_en,
	dsa_rsp_fifo_wr_en,
	dsa_xocc_cmd_out,

    //	Outbound Data Interface
	nou_noc_data_vld,
	noc_nou_data_rdy,
	nou_noc_data_tid,
	nou_noc_data_type,
	nou_noc_data,
    
    //	Outbound Response Interface
	nou_noc_rsp_vld,
	noc_nou_rsp_rdy,
	nou_noc_rsp_tid,
	nou_noc_rsp_type,
	nou_noc_rsp,
    
    //	Inbound Data Interface
	noc_nou_data_vld,
	nou_noc_data_rdy,
	noc_nou_data_tid,
	noc_nou_data_type,
	noc_nou_data,
    
    //	Inbound Response Interface
	noc_nou_rsp_vld,
	nou_noc_rsp_rdy,
	noc_nou_rsp_tid,
	noc_nou_rsp_type,
	noc_nou_rsp,

	//	Ports of Axi Master Bus Interface m_AXI
	m_axi_awid,
	m_axi_awaddr,
	m_axi_awlen,
	m_axi_awsize,
	m_axi_awburst,
	m_axi_awlock,
	m_axi_awcache,
	m_axi_awprot,
	m_axi_awqos,
	m_axi_awregion,
	m_axi_awvalid,
	m_axi_awready,
	m_axi_wdata,
	m_axi_wstrb,
	m_axi_wlast,
	m_axi_wvalid,
	m_axi_wready,
	m_axi_bid,
	m_axi_bresp,
	m_axi_bvalid,
	m_axi_bready,
	m_axi_arid,
	m_axi_araddr,
	m_axi_arlen,
	m_axi_arsize,
	m_axi_arburst,
	m_axi_arlock,
	m_axi_arcache,
	m_axi_arprot,
	m_axi_arqos,
	m_axi_arregion,
	m_axi_arvalid,
	m_axi_arready,
	m_axi_rid,
	m_axi_rdata,
	m_axi_rresp,
	m_axi_rlast,
	m_axi_rvalid,
	m_axi_rready
	);

input   nou_clk;
input   nou_rstn;
input   [`NOU_XOCC_CMD_WIDTH-1:0] dsa_xocc_cmd_in;
input   dsa_cmd_fifo_empty;
input   dsa_rsp_fifo_full;
output   dsa_cmd_fifo_rd_en;
output   dsa_rsp_fifo_wr_en;
output  [`NOU_XOCC_CMD_WIDTH-1:0] dsa_xocc_cmd_out;

output                                   nou_noc_data_vld;
input                                    noc_nou_data_rdy;
output  [`NOU_TID_WIDTH-1:0]             nou_noc_data_tid;
output  [`NOU_TYPE_WIDTH-1:0]            nou_noc_data_type;
output  [`NOU_NOC_DATA_WIDTH-1:0]        nou_noc_data;

output                                   nou_noc_rsp_vld;
input                                    noc_nou_rsp_rdy;
output  [`NOU_TID_WIDTH-1:0]             nou_noc_rsp_tid;
output  [`NOU_TYPE_WIDTH-1:0]            nou_noc_rsp_type;
output  [`NOU_NOC_RSP_WIDTH-1:0]         nou_noc_rsp;

input                                    noc_nou_data_vld;
output                                   nou_noc_data_rdy;
input   [`NOU_TID_WIDTH-1:0]             noc_nou_data_tid;
input   [`NOU_TYPE_WIDTH-1:0]            noc_nou_data_type;
input   [`NOU_NOC_DATA_WIDTH-1:0]        noc_nou_data;

input                                    noc_nou_rsp_vld;
output                                   nou_noc_rsp_rdy;
input   [`NOU_TID_WIDTH-1:0]             noc_nou_rsp_tid;
input   [1:0]                            noc_nou_rsp_type;
input   [`NOU_NOC_RSP_WIDTH-1:0]         noc_nou_rsp;

// Ports of Axi Master Bus Interface m_AXI
output  [`NOU_AXI_ID_WIDTH-1 : 0] m_axi_awid;
output  [`NOU_AXI_ADDR_WIDTH-1 : 0] m_axi_awaddr;
output  [7 : 0] m_axi_awlen;
output  [2 : 0] m_axi_awsize;
output  [1 : 0] m_axi_awburst;
output  [0 : 0] m_axi_awlock;
output  [3 : 0] m_axi_awcache;
output  [2 : 0] m_axi_awprot;
output  [3 : 0] m_axi_awqos;
output  [3 : 0] m_axi_awregion;
output   m_axi_awvalid;
input   m_axi_awready;
output  [`NOU_AXI_DATA_WIDTH-1 : 0] m_axi_wdata;
output  [(`NOU_AXI_DATA_WIDTH/8)-1 : 0] m_axi_wstrb;
output   m_axi_wlast;
output   m_axi_wvalid;
input   m_axi_wready;
input  [`NOU_AXI_ID_WIDTH-1 : 0] m_axi_bid;
input  [1 : 0] m_axi_bresp;
input   m_axi_bvalid;
output   m_axi_bready;
output  [`NOU_AXI_ID_WIDTH-1 : 0] m_axi_arid;
output  [`NOU_AXI_ADDR_WIDTH-1 : 0] m_axi_araddr;
output  [7 : 0] m_axi_arlen;
output  [2 : 0] m_axi_arsize;
output  [1 : 0] m_axi_arburst;
output  [0 : 0] m_axi_arlock;
output  [3 : 0] m_axi_arcache;
output  [2 : 0] m_axi_arprot;
output  [3 : 0] m_axi_arqos;
output  [3 : 0] m_axi_arregion;
output   m_axi_arvalid;
input   m_axi_arready;
input  [`NOU_AXI_ID_WIDTH-1 : 0] m_axi_rid;
input  [`NOU_AXI_DATA_WIDTH-1 : 0] m_axi_rdata;
input  [1 : 0] m_axi_rresp;
input   m_axi_rlast;
input   m_axi_rvalid;
output   m_axi_rready;

nou u_nou_0 (
	.nou_clk(nou_clk),
	.nou_rstn(nou_rstn),
	.req_fifo_nou_data_f1(dsa_xocc_cmd_in),
	.req_fifo_nou_empty_f0(dsa_cmd_fifo_empty),
	.nou_req_fifo_rd_en_f0(dsa_cmd_fifo_rd_en),
	.rsp_fifo_nou_full(dsa_rsp_fifo_full),
	.nou_rsp_fifo_wr_en(dsa_rsp_fifo_wr_en),
	.nou_rsp_fifo_data(dsa_xocc_cmd_out),
	.nou_noc_data_vld(nou_noc_data_vld),
	.noc_nou_data_rdy(noc_nou_data_rdy),
	.nou_noc_data_tid(nou_noc_data_tid),
	.nou_noc_data_type(nou_noc_data_type),
	.nou_noc_data(nou_noc_data),
	.nou_noc_rsp_vld(nou_noc_rsp_vld),
	.noc_nou_rsp_rdy(noc_nou_rsp_rdy),
	.nou_noc_rsp_tid(nou_noc_rsp_tid),
	.nou_noc_rsp_type(nou_noc_rsp_type),
	.nou_noc_rsp(nou_noc_rsp),
	.noc_nou_data_vld(noc_nou_data_vld),
	.nou_noc_data_rdy(nou_noc_data_rdy),
	.noc_nou_data_tid(noc_nou_data_tid),
	.noc_nou_data_type(noc_nou_data_type),
	.noc_nou_data(noc_nou_data),
	.noc_nou_rsp_vld(noc_nou_rsp_vld),
	.nou_noc_rsp_rdy(nou_noc_rsp_rdy),
	.noc_nou_rsp_tid(noc_nou_rsp_tid),
	.noc_nou_rsp_type(noc_nou_rsp_type),
	.noc_nou_rsp(noc_nou_rsp),
	.nou_axi_arid(m_axi_arid),
	.nou_axi_araddr(m_axi_araddr),
	.nou_axi_arlen(m_axi_arlen),
	.nou_axi_arsize(m_axi_arsize),
	.nou_axi_arburst(m_axi_arburst),
	.nou_axi_arlock(m_axi_arlock),
	.nou_axi_arcache(m_axi_arcache),
	.nou_axi_arprot(m_axi_arprot),
	.nou_axi_arqos(m_axi_arqos),
	.nou_axi_arregion(m_axi_arregion),
	.nou_axi_aruser(m_axi_aruser),
	.nou_axi_arvld(m_axi_arvalid),
	.axi_nou_arrdy(m_axi_arready),
	.axi_nou_rid(m_axi_rid),
	.axi_nou_rdata(m_axi_rdata),
	.axi_nou_rrsp(m_axi_rresp),
	.axi_nou_rlast(m_axi_rlast),
	.axi_nou_ruser('0), 
	.axi_nou_rvld(m_axi_rvalid),
	.nou_axi_rrdy(m_axi_rready),
	.nou_axi_awid(m_axi_awid),
	.nou_axi_awaddr(m_axi_awaddr),
	.nou_axi_awlen(m_axi_awlen),
	.nou_axi_awsize(m_axi_awsize),
	.nou_axi_awburst(m_axi_awburst),
	.nou_axi_awlock(m_axi_awlock),
	.nou_axi_awcache(m_axi_awcache),
	.nou_axi_awprot(m_axi_awprot),
	.nou_axi_awqos(m_axi_awqos),
	.nou_axi_awregion(m_axi_awregion),
	.nou_axi_awuser(m_axi_awuser),
	.nou_axi_awvld(m_axi_awvalid),
	.axi_nou_awrdy(m_axi_awready),
	.nou_axi_wdata(m_axi_wdata),
	.nou_axi_wstrb(m_axi_wstrb),
	.nou_axi_wlast(m_axi_wlast),
	.nou_axi_wuser(m_axi_wuser),
	.nou_axi_wvld(m_axi_wvalid),
	.axi_nou_wrdy(m_axi_wready),
	.axi_nou_bid(m_axi_bid),
	.axi_nou_brsp(m_axi_bresp),
	.axi_nou_buser('0),
	.axi_nou_bvld(m_axi_bvalid),
    .nou_axi_brdy(m_axi_bready)
);

endmodule
