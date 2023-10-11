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

// &ModuleBeg; @16
module rv_cluster_top (
	regular_0_clk,
	regular_0_rstn,
	regular_1_clk,
	regular_1_rstn,
	dispatcher_xocc_2_cmd_buffer,
	dispatcher_xocc_2_rsp_buffer,
	dispatcher_xocc_2_cmd_empty,
	dispatcher_xocc_2_rsp_full,
	dispatcher_xocc_2_cmd_rd_en,
	dispatcher_xocc_2_rsp_wr_en,
	dispatcher_xocc_2_clk,
	dispatcher_xocc_2_rst,
	dispatcher_xocc_3_cmd_buffer,
	dispatcher_xocc_3_rsp_buffer,
	dispatcher_xocc_3_cmd_empty,
	dispatcher_xocc_3_rsp_full,
	dispatcher_xocc_3_cmd_rd_en,
	dispatcher_xocc_3_rsp_wr_en,
	dispatcher_xocc_3_clk,
	dispatcher_xocc_3_rst,
	dispatcher_m_axi_awid,
	dispatcher_m_axi_awlen,
	dispatcher_m_axi_awsize,
	dispatcher_m_axi_awburst,
	dispatcher_m_axi_awcache,
	dispatcher_m_axi_awaddr,
	dispatcher_m_axi_awprot,
	dispatcher_m_axi_awqos,
	dispatcher_m_axi_awvalid,
	dispatcher_m_axi_awready,
	dispatcher_m_axi_awlock,
	dispatcher_m_axi_wdata,
	dispatcher_m_axi_wstrb,
	dispatcher_m_axi_wlast,
	dispatcher_m_axi_wvalid,
	dispatcher_m_axi_wready,
	dispatcher_m_axi_bid,
	dispatcher_m_axi_bresp,
	dispatcher_m_axi_bvalid,
	dispatcher_m_axi_bready,
	dispatcher_m_axi_arid,
	dispatcher_m_axi_arlen,
	dispatcher_m_axi_arsize,
	dispatcher_m_axi_arburst,
	dispatcher_m_axi_arprot,
	dispatcher_m_axi_arqos,
	dispatcher_m_axi_arcache,
	dispatcher_m_axi_arvalid,
	dispatcher_m_axi_araddr,
	dispatcher_m_axi_arlock,
	dispatcher_m_axi_arready,
	dispatcher_m_axi_rid,
	dispatcher_m_axi_rdata,
	dispatcher_m_axi_rresp,
	dispatcher_m_axi_rvalid,
	dispatcher_m_axi_rlast,
	dispatcher_m_axi_rready,
	dispatcher_retire_pc,
	dispatcher_rst_addr,
	dispatcher_clk,
	dispatcher_rstn,
	regular_0_xocc_4_cmd_buffer,
	regular_0_xocc_4_rsp_buffer,
	regular_0_xocc_4_cmd_empty,
	regular_0_xocc_4_rsp_full,
	regular_0_xocc_4_cmd_rd_en,
	regular_0_xocc_4_rsp_wr_en,
	regular_0_xocc_4_clk,
	regular_0_xocc_4_rst,
	regular_0_m_axi_awid,
	regular_0_m_axi_awlen,
	regular_0_m_axi_awsize,
	regular_0_m_axi_awburst,
	regular_0_m_axi_awcache,
	regular_0_m_axi_awaddr,
	regular_0_m_axi_awprot,
	regular_0_m_axi_awqos,
	regular_0_m_axi_awvalid,
	regular_0_m_axi_awready,
	regular_0_m_axi_awlock,
	regular_0_m_axi_wdata,
	regular_0_m_axi_wstrb,
	regular_0_m_axi_wlast,
	regular_0_m_axi_wvalid,
	regular_0_m_axi_wready,
	regular_0_m_axi_bid,
	regular_0_m_axi_bresp,
	regular_0_m_axi_bvalid,
	regular_0_m_axi_bready,
	regular_0_m_axi_arid,
	regular_0_m_axi_arlen,
	regular_0_m_axi_arsize,
	regular_0_m_axi_arburst,
	regular_0_m_axi_arprot,
	regular_0_m_axi_arqos,
	regular_0_m_axi_arcache,
	regular_0_m_axi_arvalid,
	regular_0_m_axi_araddr,
	regular_0_m_axi_arlock,
	regular_0_m_axi_arready,
	regular_0_m_axi_rid,
	regular_0_m_axi_rdata,
	regular_0_m_axi_rresp,
	regular_0_m_axi_rvalid,
	regular_0_m_axi_rlast,
	regular_0_m_axi_rready,
	regular_0_retire_pc,
	regular_0_rst_addr,
	regular_1_xocc_5_cmd_buffer,
	regular_1_xocc_5_rsp_buffer,
	regular_1_xocc_5_cmd_empty,
	regular_1_xocc_5_rsp_full,
	regular_1_xocc_5_cmd_rd_en,
	regular_1_xocc_5_rsp_wr_en,
	regular_1_xocc_5_clk,
	regular_1_xocc_5_rst,
	regular_1_m_axi_awid,
	regular_1_m_axi_awlen,
	regular_1_m_axi_awsize,
	regular_1_m_axi_awburst,
	regular_1_m_axi_awcache,
	regular_1_m_axi_awaddr,
	regular_1_m_axi_awprot,
	regular_1_m_axi_awqos,
	regular_1_m_axi_awvalid,
	regular_1_m_axi_awready,
	regular_1_m_axi_awlock,
	regular_1_m_axi_wdata,
	regular_1_m_axi_wstrb,
	regular_1_m_axi_wlast,
	regular_1_m_axi_wvalid,
	regular_1_m_axi_wready,
	regular_1_m_axi_bid,
	regular_1_m_axi_bresp,
	regular_1_m_axi_bvalid,
	regular_1_m_axi_bready,
	regular_1_m_axi_arid,
	regular_1_m_axi_arlen,
	regular_1_m_axi_arsize,
	regular_1_m_axi_arburst,
	regular_1_m_axi_arprot,
	regular_1_m_axi_arqos,
	regular_1_m_axi_arcache,
	regular_1_m_axi_arvalid,
	regular_1_m_axi_araddr,
	regular_1_m_axi_arlock,
	regular_1_m_axi_arready,
	regular_1_m_axi_rid,
	regular_1_m_axi_rdata,
	regular_1_m_axi_rresp,
	regular_1_m_axi_rvalid,
	regular_1_m_axi_rlast,
	regular_1_m_axi_rready,
	regular_1_retire_pc,
	regular_1_rst_addr
);

// &Ports; @17
input   [0:0]     regular_0_clk;              
input   [0:0]     regular_0_rstn;             
input   [0:0]     regular_1_clk;              
input   [0:0]     regular_1_rstn;             
output  [64-1:0]  dispatcher_xocc_2_cmd_buffer;
input   [64-1:0]  dispatcher_xocc_2_rsp_buffer;
output  [0:0]     dispatcher_xocc_2_cmd_empty;
output  [0:0]     dispatcher_xocc_2_rsp_full; 
input   [0:0]     dispatcher_xocc_2_cmd_rd_en;
input   [0:0]     dispatcher_xocc_2_rsp_wr_en;
input   [0:0]     dispatcher_xocc_2_clk;      
input   [0:0]     dispatcher_xocc_2_rst;      
output  [32-1:0]  dispatcher_xocc_3_cmd_buffer;
input   [32-1:0]  dispatcher_xocc_3_rsp_buffer;
output  [0:0]     dispatcher_xocc_3_cmd_empty;
output  [0:0]     dispatcher_xocc_3_rsp_full; 
input   [0:0]     dispatcher_xocc_3_cmd_rd_en;
input   [0:0]     dispatcher_xocc_3_rsp_wr_en;
input   [0:0]     dispatcher_xocc_3_clk;      
input   [0:0]     dispatcher_xocc_3_rst;      
output  [3:0]     dispatcher_m_axi_awid;      
output  [7:0]     dispatcher_m_axi_awlen;     
output  [2:0]     dispatcher_m_axi_awsize;    
output  [1:0]     dispatcher_m_axi_awburst;   
output  [3:0]     dispatcher_m_axi_awcache;   
output  [31:0]    dispatcher_m_axi_awaddr;    
output  [2:0]     dispatcher_m_axi_awprot;    
output  [3:0]     dispatcher_m_axi_awqos;     
output  [0:0]     dispatcher_m_axi_awvalid;   
input   [0:0]     dispatcher_m_axi_awready;   
output  [0:0]     dispatcher_m_axi_awlock;    
output  [31:0]    dispatcher_m_axi_wdata;     
output  [3:0]     dispatcher_m_axi_wstrb;     
output  [0:0]     dispatcher_m_axi_wlast;     
output  [0:0]     dispatcher_m_axi_wvalid;    
input   [0:0]     dispatcher_m_axi_wready;    
input   [3:0]     dispatcher_m_axi_bid;       
input   [1:0]     dispatcher_m_axi_bresp;     
input   [0:0]     dispatcher_m_axi_bvalid;    
output  [0:0]     dispatcher_m_axi_bready;    
output  [3:0]     dispatcher_m_axi_arid;      
output  [7:0]     dispatcher_m_axi_arlen;     
output  [2:0]     dispatcher_m_axi_arsize;    
output  [1:0]     dispatcher_m_axi_arburst;   
output  [2:0]     dispatcher_m_axi_arprot;    
output  [3:0]     dispatcher_m_axi_arqos;     
output  [3:0]     dispatcher_m_axi_arcache;   
output  [0:0]     dispatcher_m_axi_arvalid;   
output  [31:0]    dispatcher_m_axi_araddr;    
output  [0:0]     dispatcher_m_axi_arlock;    
input   [0:0]     dispatcher_m_axi_arready;   
input   [3:0]     dispatcher_m_axi_rid;       
input   [31:0]    dispatcher_m_axi_rdata;     
input   [1:0]     dispatcher_m_axi_rresp;     
input   [0:0]     dispatcher_m_axi_rvalid;    
input   [0:0]     dispatcher_m_axi_rlast;     
output  [0:0]     dispatcher_m_axi_rready;    
output  [31:0]    dispatcher_retire_pc;       
input   [31:0]    dispatcher_rst_addr;        
input   [0:0]     dispatcher_clk;             
input   [0:0]     dispatcher_rstn;            
output  [96-1:0]  regular_0_xocc_4_cmd_buffer;
input   [32-1:0]  regular_0_xocc_4_rsp_buffer;
output  [0:0]     regular_0_xocc_4_cmd_empty; 
output  [0:0]     regular_0_xocc_4_rsp_full;  
input   [0:0]     regular_0_xocc_4_cmd_rd_en; 
input   [0:0]     regular_0_xocc_4_rsp_wr_en; 
input   [0:0]     regular_0_xocc_4_clk;       
input   [0:0]     regular_0_xocc_4_rst;       
output  [3:0]     regular_0_m_axi_awid;       
output  [7:0]     regular_0_m_axi_awlen;      
output  [2:0]     regular_0_m_axi_awsize;     
output  [1:0]     regular_0_m_axi_awburst;    
output  [3:0]     regular_0_m_axi_awcache;    
output  [31:0]    regular_0_m_axi_awaddr;     
output  [2:0]     regular_0_m_axi_awprot;     
output  [3:0]     regular_0_m_axi_awqos;      
output  [0:0]     regular_0_m_axi_awvalid;    
input   [0:0]     regular_0_m_axi_awready;    
output  [0:0]     regular_0_m_axi_awlock;     
output  [31:0]    regular_0_m_axi_wdata;      
output  [3:0]     regular_0_m_axi_wstrb;      
output  [0:0]     regular_0_m_axi_wlast;      
output  [0:0]     regular_0_m_axi_wvalid;     
input   [0:0]     regular_0_m_axi_wready;     
input   [3:0]     regular_0_m_axi_bid;        
input   [1:0]     regular_0_m_axi_bresp;      
input   [0:0]     regular_0_m_axi_bvalid;     
output  [0:0]     regular_0_m_axi_bready;     
output  [3:0]     regular_0_m_axi_arid;       
output  [7:0]     regular_0_m_axi_arlen;      
output  [2:0]     regular_0_m_axi_arsize;     
output  [1:0]     regular_0_m_axi_arburst;    
output  [2:0]     regular_0_m_axi_arprot;     
output  [3:0]     regular_0_m_axi_arqos;      
output  [3:0]     regular_0_m_axi_arcache;    
output  [0:0]     regular_0_m_axi_arvalid;    
output  [31:0]    regular_0_m_axi_araddr;     
output  [0:0]     regular_0_m_axi_arlock;     
input   [0:0]     regular_0_m_axi_arready;    
input   [3:0]     regular_0_m_axi_rid;        
input   [31:0]    regular_0_m_axi_rdata;      
input   [1:0]     regular_0_m_axi_rresp;      
input   [0:0]     regular_0_m_axi_rvalid;     
input   [0:0]     regular_0_m_axi_rlast;      
output  [0:0]     regular_0_m_axi_rready;     
output  [31:0]    regular_0_retire_pc;        
input   [31:0]    regular_0_rst_addr;         
output  [32-1:0]  regular_1_xocc_5_cmd_buffer;
input   [32-1:0]  regular_1_xocc_5_rsp_buffer;
output  [0:0]     regular_1_xocc_5_cmd_empty; 
output  [0:0]     regular_1_xocc_5_rsp_full;  
input   [0:0]     regular_1_xocc_5_cmd_rd_en; 
input   [0:0]     regular_1_xocc_5_rsp_wr_en; 
input   [0:0]     regular_1_xocc_5_clk;       
input   [0:0]     regular_1_xocc_5_rst;       
output  [3:0]     regular_1_m_axi_awid;       
output  [7:0]     regular_1_m_axi_awlen;      
output  [2:0]     regular_1_m_axi_awsize;     
output  [1:0]     regular_1_m_axi_awburst;    
output  [3:0]     regular_1_m_axi_awcache;    
output  [31:0]    regular_1_m_axi_awaddr;     
output  [2:0]     regular_1_m_axi_awprot;     
output  [3:0]     regular_1_m_axi_awqos;      
output  [0:0]     regular_1_m_axi_awvalid;    
input   [0:0]     regular_1_m_axi_awready;    
output  [0:0]     regular_1_m_axi_awlock;     
output  [31:0]    regular_1_m_axi_wdata;      
output  [3:0]     regular_1_m_axi_wstrb;      
output  [0:0]     regular_1_m_axi_wlast;      
output  [0:0]     regular_1_m_axi_wvalid;     
input   [0:0]     regular_1_m_axi_wready;     
input   [3:0]     regular_1_m_axi_bid;        
input   [1:0]     regular_1_m_axi_bresp;      
input   [0:0]     regular_1_m_axi_bvalid;     
output  [0:0]     regular_1_m_axi_bready;     
output  [3:0]     regular_1_m_axi_arid;       
output  [7:0]     regular_1_m_axi_arlen;      
output  [2:0]     regular_1_m_axi_arsize;     
output  [1:0]     regular_1_m_axi_arburst;    
output  [2:0]     regular_1_m_axi_arprot;     
output  [3:0]     regular_1_m_axi_arqos;      
output  [3:0]     regular_1_m_axi_arcache;    
output  [0:0]     regular_1_m_axi_arvalid;    
output  [31:0]    regular_1_m_axi_araddr;     
output  [0:0]     regular_1_m_axi_arlock;     
input   [0:0]     regular_1_m_axi_arready;    
input   [3:0]     regular_1_m_axi_rid;        
input   [31:0]    regular_1_m_axi_rdata;      
input   [1:0]     regular_1_m_axi_rresp;      
input   [0:0]     regular_1_m_axi_rvalid;     
input   [0:0]     regular_1_m_axi_rlast;      
output  [0:0]     regular_1_m_axi_rready;     
output  [31:0]    regular_1_retire_pc;        
input   [31:0]    regular_1_rst_addr;         

wire    [32-1:0]  dispatcher_xocc_0_cmd_buffer;
wire    [0:0]     dispatcher_xocc_0_cmd_rd_en;
wire    [0:0]     dispatcher_xocc_0_rsp_wr_en;
wire    [32-1:0]  dispatcher_xocc_0_rsp_buffer;
wire    [0:0]     dispatcher_xocc_0_cmd_empty;
wire    [0:0]     dispatcher_xocc_0_rsp_full; 
wire    [0:0]     dispatcher_xocc_1_rsp_full; 
wire    [0:0]     dispatcher_xocc_1_cmd_rd_en;
wire    [0:0]     dispatcher_xocc_1_rsp_wr_en;
wire    [32-1:0]  dispatcher_xocc_1_rsp_buffer;
wire    [0:0]     dispatcher_xocc_1_cmd_empty;
wire    [32-1:0]  dispatcher_xocc_1_cmd_buffer;
wire    [0:0]     regular_0_xocc_0_rsp_wr_en; 
wire    [0:0]     regular_0_xocc_0_rsp_full;  
wire    [0:0]     regular_0_xocc_0_cmd_rd_en; 
wire    [32-1:0]  regular_0_xocc_0_cmd_buffer;
wire    [32-1:0]  regular_0_xocc_0_rsp_buffer;
wire    [0:0]     regular_0_xocc_0_cmd_empty; 
wire    [0:0]     regular_1_xocc_1_rsp_full;  
wire    [0:0]     regular_1_xocc_1_rsp_wr_en; 
wire    [0:0]     regular_1_xocc_1_cmd_empty; 
wire    [32-1:0]  regular_1_xocc_1_cmd_buffer;
wire    [32-1:0]  regular_1_xocc_1_rsp_buffer;
wire    [0:0]     regular_1_xocc_1_cmd_rd_en; 


// Init RV: dispatcher
// &Instance("dispatcher_rv_wrapper"); @20
dispatcher_rv_wrapper x_dispatcher_rv_wrapper (
	.xocc_0_cmd_buffer(dispatcher_xocc_0_cmd_buffer),
	.xocc_0_rsp_buffer(dispatcher_xocc_0_rsp_buffer),
	.xocc_0_cmd_empty (dispatcher_xocc_0_cmd_empty ),
	.xocc_0_rsp_full  (dispatcher_xocc_0_rsp_full  ),
	.xocc_0_cmd_rd_en (dispatcher_xocc_0_cmd_rd_en ),
	.xocc_0_rsp_wr_en (dispatcher_xocc_0_rsp_wr_en ),
	.xocc_0_clk       (regular_0_clk               ),
	.xocc_0_rst       (regular_0_rstn              ),
	.xocc_1_cmd_buffer(dispatcher_xocc_1_cmd_buffer),
	.xocc_1_rsp_buffer(dispatcher_xocc_1_rsp_buffer),
	.xocc_1_cmd_empty (dispatcher_xocc_1_cmd_empty ),
	.xocc_1_rsp_full  (dispatcher_xocc_1_rsp_full  ),
	.xocc_1_cmd_rd_en (dispatcher_xocc_1_cmd_rd_en ),
	.xocc_1_rsp_wr_en (dispatcher_xocc_1_rsp_wr_en ),
	.xocc_1_clk       (regular_1_clk               ),
	.xocc_1_rst       (regular_1_rstn              ),
	.xocc_2_cmd_buffer(dispatcher_xocc_2_cmd_buffer),
	.xocc_2_rsp_buffer(dispatcher_xocc_2_rsp_buffer),
	.xocc_2_cmd_empty (dispatcher_xocc_2_cmd_empty ),
	.xocc_2_rsp_full  (dispatcher_xocc_2_rsp_full  ),
	.xocc_2_cmd_rd_en (dispatcher_xocc_2_cmd_rd_en ),
	.xocc_2_rsp_wr_en (dispatcher_xocc_2_rsp_wr_en ),
	.xocc_2_clk       (dispatcher_xocc_2_clk       ),
	.xocc_2_rst       (dispatcher_xocc_2_rst       ),
	.xocc_3_cmd_buffer(dispatcher_xocc_3_cmd_buffer),
	.xocc_3_rsp_buffer(dispatcher_xocc_3_rsp_buffer),
	.xocc_3_cmd_empty (dispatcher_xocc_3_cmd_empty ),
	.xocc_3_rsp_full  (dispatcher_xocc_3_rsp_full  ),
	.xocc_3_cmd_rd_en (dispatcher_xocc_3_cmd_rd_en ),
	.xocc_3_rsp_wr_en (dispatcher_xocc_3_rsp_wr_en ),
	.xocc_3_clk       (dispatcher_xocc_3_clk       ),
	.xocc_3_rst       (dispatcher_xocc_3_rst       ),
	.m_axi_awid       (dispatcher_m_axi_awid       ),
	.m_axi_awlen      (dispatcher_m_axi_awlen      ),
	.m_axi_awsize     (dispatcher_m_axi_awsize     ),
	.m_axi_awburst    (dispatcher_m_axi_awburst    ),
	.m_axi_awcache    (dispatcher_m_axi_awcache    ),
	.m_axi_awaddr     (dispatcher_m_axi_awaddr     ),
	.m_axi_awprot     (dispatcher_m_axi_awprot     ),
	.m_axi_awqos      (dispatcher_m_axi_awqos      ),
	.m_axi_awvalid    (dispatcher_m_axi_awvalid    ),
	.m_axi_awready    (dispatcher_m_axi_awready    ),
	.m_axi_awlock     (dispatcher_m_axi_awlock     ),
	.m_axi_wdata      (dispatcher_m_axi_wdata      ),
	.m_axi_wstrb      (dispatcher_m_axi_wstrb      ),
	.m_axi_wlast      (dispatcher_m_axi_wlast      ),
	.m_axi_wvalid     (dispatcher_m_axi_wvalid     ),
	.m_axi_wready     (dispatcher_m_axi_wready     ),
	.m_axi_bid        (dispatcher_m_axi_bid        ),
	.m_axi_bresp      (dispatcher_m_axi_bresp      ),
	.m_axi_bvalid     (dispatcher_m_axi_bvalid     ),
	.m_axi_bready     (dispatcher_m_axi_bready     ),
	.m_axi_arid       (dispatcher_m_axi_arid       ),
	.m_axi_arlen      (dispatcher_m_axi_arlen      ),
	.m_axi_arsize     (dispatcher_m_axi_arsize     ),
	.m_axi_arburst    (dispatcher_m_axi_arburst    ),
	.m_axi_arprot     (dispatcher_m_axi_arprot     ),
	.m_axi_arqos      (dispatcher_m_axi_arqos      ),
	.m_axi_arcache    (dispatcher_m_axi_arcache    ),
	.m_axi_arvalid    (dispatcher_m_axi_arvalid    ),
	.m_axi_araddr     (dispatcher_m_axi_araddr     ),
	.m_axi_arlock     (dispatcher_m_axi_arlock     ),
	.m_axi_arready    (dispatcher_m_axi_arready    ),
	.m_axi_rid        (dispatcher_m_axi_rid        ),
	.m_axi_rdata      (dispatcher_m_axi_rdata      ),
	.m_axi_rresp      (dispatcher_m_axi_rresp      ),
	.m_axi_rvalid     (dispatcher_m_axi_rvalid     ),
	.m_axi_rlast      (dispatcher_m_axi_rlast      ),
	.m_axi_rready     (dispatcher_m_axi_rready     ),
	.biu_pad_retire_pc(dispatcher_retire_pc        ),
	.pad_cpu_rst_addr (dispatcher_rst_addr         ),
	.i_pad_clk        (dispatcher_clk              ),
	.i_pad_rst_b      (dispatcher_rstn             )
);
// @21 &ConnRule(r'^xocc_0', r'dispatcher_xocc_0');
// @22 &ConnRule(r'^xocc_1', r'dispatcher_xocc_1');
// @23 &ConnRule(r'^xocc_2', r'dispatcher_xocc_2');
// @24 &ConnRule(r'^xocc_3', r'dispatcher_xocc_3');
// @25 &ConnRule(r'm_axi', r'dispatcher_m_axi');
// @26 &Connect(
// @27     .biu_pad_retire_pc (dispatcher_retire_pc),
// @28     .i_pad_clk (dispatcher_clk),
// @29     .i_pad_rst_b (dispatcher_rstn),
// @30     .pad_cpu_rst_addr (dispatcher_rst_addr),
// @31     .xocc_0_clk (regular_0_clk),
// @32     .xocc_0_rst (regular_0_rstn),
// @33     .xocc_1_clk (regular_1_clk),
// @34     .xocc_1_rst (regular_1_rstn),
// @35 );
// @36 &Force("output", "dispatcher_retire_pc");

// Init RV: regular_0
// &Instance("regular_0_rv_wrapper"); @39
regular_0_rv_wrapper x_regular_0_rv_wrapper (
	.xocc_0_cmd_buffer(regular_0_xocc_0_cmd_buffer),
	.xocc_0_rsp_buffer(regular_0_xocc_0_rsp_buffer),
	.xocc_0_cmd_empty (regular_0_xocc_0_cmd_empty ),
	.xocc_0_rsp_full  (regular_0_xocc_0_rsp_full  ),
	.xocc_0_cmd_rd_en (regular_0_xocc_0_cmd_rd_en ),
	.xocc_0_rsp_wr_en (regular_0_xocc_0_rsp_wr_en ),
	.xocc_0_clk       (dispatcher_clk             ),
	.xocc_0_rst       (dispatcher_rstn            ),
	.xocc_1_cmd_buffer(regular_0_xocc_4_cmd_buffer),
	.xocc_1_rsp_buffer(regular_0_xocc_4_rsp_buffer),
	.xocc_1_cmd_empty (regular_0_xocc_4_cmd_empty ),
	.xocc_1_rsp_full  (regular_0_xocc_4_rsp_full  ),
	.xocc_1_cmd_rd_en (regular_0_xocc_4_cmd_rd_en ),
	.xocc_1_rsp_wr_en (regular_0_xocc_4_rsp_wr_en ),
	.xocc_1_clk       (regular_0_xocc_4_clk       ),
	.xocc_1_rst       (regular_0_xocc_4_rst       ),
	.m_axi_awid       (regular_0_m_axi_awid       ),
	.m_axi_awlen      (regular_0_m_axi_awlen      ),
	.m_axi_awsize     (regular_0_m_axi_awsize     ),
	.m_axi_awburst    (regular_0_m_axi_awburst    ),
	.m_axi_awcache    (regular_0_m_axi_awcache    ),
	.m_axi_awaddr     (regular_0_m_axi_awaddr     ),
	.m_axi_awprot     (regular_0_m_axi_awprot     ),
	.m_axi_awqos      (regular_0_m_axi_awqos      ),
	.m_axi_awvalid    (regular_0_m_axi_awvalid    ),
	.m_axi_awready    (regular_0_m_axi_awready    ),
	.m_axi_awlock     (regular_0_m_axi_awlock     ),
	.m_axi_wdata      (regular_0_m_axi_wdata      ),
	.m_axi_wstrb      (regular_0_m_axi_wstrb      ),
	.m_axi_wlast      (regular_0_m_axi_wlast      ),
	.m_axi_wvalid     (regular_0_m_axi_wvalid     ),
	.m_axi_wready     (regular_0_m_axi_wready     ),
	.m_axi_bid        (regular_0_m_axi_bid        ),
	.m_axi_bresp      (regular_0_m_axi_bresp      ),
	.m_axi_bvalid     (regular_0_m_axi_bvalid     ),
	.m_axi_bready     (regular_0_m_axi_bready     ),
	.m_axi_arid       (regular_0_m_axi_arid       ),
	.m_axi_arlen      (regular_0_m_axi_arlen      ),
	.m_axi_arsize     (regular_0_m_axi_arsize     ),
	.m_axi_arburst    (regular_0_m_axi_arburst    ),
	.m_axi_arprot     (regular_0_m_axi_arprot     ),
	.m_axi_arqos      (regular_0_m_axi_arqos      ),
	.m_axi_arcache    (regular_0_m_axi_arcache    ),
	.m_axi_arvalid    (regular_0_m_axi_arvalid    ),
	.m_axi_araddr     (regular_0_m_axi_araddr     ),
	.m_axi_arlock     (regular_0_m_axi_arlock     ),
	.m_axi_arready    (regular_0_m_axi_arready    ),
	.m_axi_rid        (regular_0_m_axi_rid        ),
	.m_axi_rdata      (regular_0_m_axi_rdata      ),
	.m_axi_rresp      (regular_0_m_axi_rresp      ),
	.m_axi_rvalid     (regular_0_m_axi_rvalid     ),
	.m_axi_rlast      (regular_0_m_axi_rlast      ),
	.m_axi_rready     (regular_0_m_axi_rready     ),
	.biu_pad_retire_pc(regular_0_retire_pc        ),
	.pad_cpu_rst_addr (regular_0_rst_addr         ),
	.i_pad_clk        (regular_0_clk              ),
	.i_pad_rst_b      (regular_0_rstn             )
);
// @40 &ConnRule(r'^xocc_0', r'regular_0_xocc_0');
// @41 &ConnRule(r'^xocc_1', r'regular_0_xocc_4');
// @42 &ConnRule(r'm_axi', r'regular_0_m_axi');
// @43 &Connect(
// @44     .biu_pad_retire_pc (regular_0_retire_pc),
// @45     .i_pad_clk (regular_0_clk),
// @46     .i_pad_rst_b (regular_0_rstn),
// @47     .pad_cpu_rst_addr (regular_0_rst_addr),
// @48     .xocc_0_clk (dispatcher_clk),
// @49     .xocc_0_rst (dispatcher_rstn),
// @50 );
// @51 &Force("output", "regular_0_retire_pc");

// Init RV: regular_1
// &Instance("regular_1_rv_wrapper"); @54
regular_1_rv_wrapper x_regular_1_rv_wrapper (
	.xocc_0_cmd_buffer(regular_1_xocc_1_cmd_buffer),
	.xocc_0_rsp_buffer(regular_1_xocc_1_rsp_buffer),
	.xocc_0_cmd_empty (regular_1_xocc_1_cmd_empty ),
	.xocc_0_rsp_full  (regular_1_xocc_1_rsp_full  ),
	.xocc_0_cmd_rd_en (regular_1_xocc_1_cmd_rd_en ),
	.xocc_0_rsp_wr_en (regular_1_xocc_1_rsp_wr_en ),
	.xocc_0_clk       (dispatcher_clk             ),
	.xocc_0_rst       (dispatcher_rstn            ),
	.xocc_1_cmd_buffer(regular_1_xocc_5_cmd_buffer),
	.xocc_1_rsp_buffer(regular_1_xocc_5_rsp_buffer),
	.xocc_1_cmd_empty (regular_1_xocc_5_cmd_empty ),
	.xocc_1_rsp_full  (regular_1_xocc_5_rsp_full  ),
	.xocc_1_cmd_rd_en (regular_1_xocc_5_cmd_rd_en ),
	.xocc_1_rsp_wr_en (regular_1_xocc_5_rsp_wr_en ),
	.xocc_1_clk       (regular_1_xocc_5_clk       ),
	.xocc_1_rst       (regular_1_xocc_5_rst       ),
	.m_axi_awid       (regular_1_m_axi_awid       ),
	.m_axi_awlen      (regular_1_m_axi_awlen      ),
	.m_axi_awsize     (regular_1_m_axi_awsize     ),
	.m_axi_awburst    (regular_1_m_axi_awburst    ),
	.m_axi_awcache    (regular_1_m_axi_awcache    ),
	.m_axi_awaddr     (regular_1_m_axi_awaddr     ),
	.m_axi_awprot     (regular_1_m_axi_awprot     ),
	.m_axi_awqos      (regular_1_m_axi_awqos      ),
	.m_axi_awvalid    (regular_1_m_axi_awvalid    ),
	.m_axi_awready    (regular_1_m_axi_awready    ),
	.m_axi_awlock     (regular_1_m_axi_awlock     ),
	.m_axi_wdata      (regular_1_m_axi_wdata      ),
	.m_axi_wstrb      (regular_1_m_axi_wstrb      ),
	.m_axi_wlast      (regular_1_m_axi_wlast      ),
	.m_axi_wvalid     (regular_1_m_axi_wvalid     ),
	.m_axi_wready     (regular_1_m_axi_wready     ),
	.m_axi_bid        (regular_1_m_axi_bid        ),
	.m_axi_bresp      (regular_1_m_axi_bresp      ),
	.m_axi_bvalid     (regular_1_m_axi_bvalid     ),
	.m_axi_bready     (regular_1_m_axi_bready     ),
	.m_axi_arid       (regular_1_m_axi_arid       ),
	.m_axi_arlen      (regular_1_m_axi_arlen      ),
	.m_axi_arsize     (regular_1_m_axi_arsize     ),
	.m_axi_arburst    (regular_1_m_axi_arburst    ),
	.m_axi_arprot     (regular_1_m_axi_arprot     ),
	.m_axi_arqos      (regular_1_m_axi_arqos      ),
	.m_axi_arcache    (regular_1_m_axi_arcache    ),
	.m_axi_arvalid    (regular_1_m_axi_arvalid    ),
	.m_axi_araddr     (regular_1_m_axi_araddr     ),
	.m_axi_arlock     (regular_1_m_axi_arlock     ),
	.m_axi_arready    (regular_1_m_axi_arready    ),
	.m_axi_rid        (regular_1_m_axi_rid        ),
	.m_axi_rdata      (regular_1_m_axi_rdata      ),
	.m_axi_rresp      (regular_1_m_axi_rresp      ),
	.m_axi_rvalid     (regular_1_m_axi_rvalid     ),
	.m_axi_rlast      (regular_1_m_axi_rlast      ),
	.m_axi_rready     (regular_1_m_axi_rready     ),
	.biu_pad_retire_pc(regular_1_retire_pc        ),
	.pad_cpu_rst_addr (regular_1_rst_addr         ),
	.i_pad_clk        (regular_1_clk              ),
	.i_pad_rst_b      (regular_1_rstn             )
);
// @55 &ConnRule(r'^xocc_0', r'regular_1_xocc_1');
// @56 &ConnRule(r'^xocc_1', r'regular_1_xocc_5');
// @57 &ConnRule(r'm_axi', r'regular_1_m_axi');
// @58 &Connect(
// @59     .biu_pad_retire_pc (regular_1_retire_pc),
// @60     .i_pad_clk (regular_1_clk),
// @61     .i_pad_rst_b (regular_1_rstn),
// @62     .pad_cpu_rst_addr (regular_1_rst_addr),
// @63     .xocc_0_clk (dispatcher_clk),
// @64     .xocc_0_rst (dispatcher_rstn),
// @65 );
// @66 &Force("output", "regular_1_retire_pc");


// Init XoCC Connect from dispatcher to regular_0
// &Instance("xocc_connect", "x_xocc_connect_0"); @70
xocc_connect x_xocc_connect_0 (
	.clk              (regular_0_clk               ),
	.m_xocc_cmd_buffer(dispatcher_xocc_0_cmd_buffer),
	.m_xocc_cmd_empty (dispatcher_xocc_0_cmd_empty ),
	.m_xocc_cmd_rd_en (dispatcher_xocc_0_cmd_rd_en ),
	.m_xocc_rsp_full  (dispatcher_xocc_0_rsp_full  ),
	.m_xocc_rsp_wr_en (dispatcher_xocc_0_rsp_wr_en ),
	.rstn             (regular_0_rstn              ),
	.s_xocc_cmd_buffer(regular_0_xocc_0_cmd_buffer ),
	.s_xocc_cmd_empty (regular_0_xocc_0_cmd_empty  ),
	.s_xocc_cmd_rd_en (regular_0_xocc_0_cmd_rd_en  ),
	.s_xocc_rsp_full  (regular_0_xocc_0_rsp_full   ),
	.s_xocc_rsp_wr_en (regular_0_xocc_0_rsp_wr_en  ),
	.xocc_m_rsp_buffer(dispatcher_xocc_0_rsp_buffer),
	.xocc_s_rsp_buffer(regular_0_xocc_0_rsp_buffer )
);
// @71 &ConnRule(r'xocc_s', r'regular_0_xocc_0');
// @72 &ConnRule(r's_xocc', r'regular_0_xocc_0');
// @73 &ConnRule(r'm_xocc', r'dispatcher_xocc_0');
// @74 &ConnRule(r'xocc_m', r'dispatcher_xocc_0');
// @75 &Connect(
// @76     .clk (regular_0_clk),
// @77     .rstn (regular_0_rstn),
// @78 );
// @79 &Force("input", "regular_0_clk");
// @80 &Force("input", "regular_0_rstn");

// Init XoCC Connect from dispatcher to regular_1
// &Instance("xocc_connect", "x_xocc_connect_1"); @83
xocc_connect x_xocc_connect_1 (
	.clk              (regular_1_clk               ),
	.m_xocc_cmd_buffer(dispatcher_xocc_1_cmd_buffer),
	.m_xocc_cmd_empty (dispatcher_xocc_1_cmd_empty ),
	.m_xocc_cmd_rd_en (dispatcher_xocc_1_cmd_rd_en ),
	.m_xocc_rsp_full  (dispatcher_xocc_1_rsp_full  ),
	.m_xocc_rsp_wr_en (dispatcher_xocc_1_rsp_wr_en ),
	.rstn             (regular_1_rstn              ),
	.s_xocc_cmd_buffer(regular_1_xocc_1_cmd_buffer ),
	.s_xocc_cmd_empty (regular_1_xocc_1_cmd_empty  ),
	.s_xocc_cmd_rd_en (regular_1_xocc_1_cmd_rd_en  ),
	.s_xocc_rsp_full  (regular_1_xocc_1_rsp_full   ),
	.s_xocc_rsp_wr_en (regular_1_xocc_1_rsp_wr_en  ),
	.xocc_m_rsp_buffer(dispatcher_xocc_1_rsp_buffer),
	.xocc_s_rsp_buffer(regular_1_xocc_1_rsp_buffer )
);
// @84 &ConnRule(r'xocc_s', r'regular_1_xocc_1');
// @85 &ConnRule(r's_xocc', r'regular_1_xocc_1');
// @86 &ConnRule(r'm_xocc', r'dispatcher_xocc_1');
// @87 &ConnRule(r'xocc_m', r'dispatcher_xocc_1');
// @88 &Connect(
// @89     .clk (regular_1_clk),
// @90     .rstn (regular_1_rstn),
// @91 );
// @92 &Force("input", "regular_1_clk");
// @93 &Force("input", "regular_1_rstn");


endmodule
