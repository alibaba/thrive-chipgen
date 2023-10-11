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
module mem_sub_sys_top (
	mem_sub_sys_clk,
	s_0_axi_araddr,
	s_0_axi_arburst,
	s_0_axi_arcache,
	mem_sub_sys_rstn,
	s_0_axi_arid,
	s_0_axi_arlen,
	s_0_axi_arlock,
	s_0_axi_arprot,
	s_0_axi_arqos,
	s_0_axi_awqos,
	s_0_axi_arready,
	s_0_axi_arsize,
	s_0_axi_arvalid,
	s_0_axi_awaddr,
	s_0_axi_awburst,
	s_0_axi_awcache,
	s_0_axi_awid,
	s_0_axi_awlen,
	s_0_axi_awlock,
	s_0_axi_awprot,
	s_0_axi_awready,
	s_0_axi_awsize,
	s_0_axi_awvalid,
	s_0_axi_bid,
	s_0_axi_bready,
	s_0_axi_bresp,
	s_0_axi_bvalid,
	s_0_axi_rdata,
	s_0_axi_rid,
	s_0_axi_rlast,
	s_0_axi_rready,
	s_0_axi_rresp,
	s_0_axi_rvalid,
	s_0_axi_wdata,
	s_0_axi_wlast,
	s_0_axi_wready,
	s_0_axi_wstrb,
	s_0_axi_wvalid,
	s_1_axi_araddr,
	s_1_axi_arburst,
	s_1_axi_arcache,
	s_1_axi_arid,
	s_1_axi_arlen,
	s_1_axi_arlock,
	s_1_axi_arprot,
	s_1_axi_arqos,
	s_1_axi_awqos,
	s_1_axi_arready,
	s_1_axi_arsize,
	s_1_axi_arvalid,
	s_1_axi_awaddr,
	s_1_axi_awburst,
	s_1_axi_awcache,
	s_1_axi_awid,
	s_1_axi_awlen,
	s_1_axi_awlock,
	s_1_axi_awprot,
	s_1_axi_awready,
	s_1_axi_awsize,
	s_1_axi_awvalid,
	s_1_axi_bid,
	s_1_axi_bready,
	s_1_axi_bresp,
	s_1_axi_bvalid,
	s_1_axi_rdata,
	s_1_axi_rid,
	s_1_axi_rlast,
	s_1_axi_rready,
	s_1_axi_rresp,
	s_1_axi_rvalid,
	s_1_axi_wdata,
	s_1_axi_wlast,
	s_1_axi_wready,
	s_1_axi_wstrb,
	s_1_axi_wvalid,
	s_2_axi_araddr,
	s_2_axi_arburst,
	s_2_axi_arcache,
	s_2_axi_arid,
	s_2_axi_arlen,
	s_2_axi_arlock,
	s_2_axi_arprot,
	s_2_axi_arqos,
	s_2_axi_awqos,
	s_2_axi_arready,
	s_2_axi_arsize,
	s_2_axi_arvalid,
	s_2_axi_awaddr,
	s_2_axi_awburst,
	s_2_axi_awcache,
	s_2_axi_awid,
	s_2_axi_awlen,
	s_2_axi_awlock,
	s_2_axi_awprot,
	s_2_axi_awready,
	s_2_axi_awsize,
	s_2_axi_awvalid,
	s_2_axi_bid,
	s_2_axi_bready,
	s_2_axi_bresp,
	s_2_axi_bvalid,
	s_2_axi_rdata,
	s_2_axi_rid,
	s_2_axi_rlast,
	s_2_axi_rready,
	s_2_axi_rresp,
	s_2_axi_rvalid,
	s_2_axi_wdata,
	s_2_axi_wlast,
	s_2_axi_wready,
	s_2_axi_wstrb,
	s_2_axi_wvalid,
	s_3_axi_araddr,
	s_3_axi_arburst,
	s_3_axi_arcache,
	s_3_axi_arid,
	s_3_axi_arlen,
	s_3_axi_arlock,
	s_3_axi_arprot,
	s_3_axi_arqos,
	s_3_axi_awqos,
	s_3_axi_arready,
	s_3_axi_arsize,
	s_3_axi_arvalid,
	s_3_axi_awaddr,
	s_3_axi_awburst,
	s_3_axi_awcache,
	s_3_axi_awid,
	s_3_axi_awlen,
	s_3_axi_awlock,
	s_3_axi_awprot,
	s_3_axi_awready,
	s_3_axi_awsize,
	s_3_axi_awvalid,
	s_3_axi_bid,
	s_3_axi_bready,
	s_3_axi_bresp,
	s_3_axi_bvalid,
	s_3_axi_rdata,
	s_3_axi_rid,
	s_3_axi_rlast,
	s_3_axi_rready,
	s_3_axi_rresp,
	s_3_axi_rvalid,
	s_3_axi_wdata,
	s_3_axi_wlast,
	s_3_axi_wready,
	s_3_axi_wstrb,
	s_3_axi_wvalid
);

// &Ports; @17
input   [0:0]             mem_sub_sys_clk;
input   [20-1:0]          s_0_axi_araddr; 
input   [1:0]             s_0_axi_arburst;
input   [3:0]             s_0_axi_arcache;
input   [0:0]             mem_sub_sys_rstn;
input   [8-1:0]           s_0_axi_arid;   
input   [7:0]             s_0_axi_arlen;  
input   [0:0]             s_0_axi_arlock; 
input   [2:0]             s_0_axi_arprot; 
input   [3:0]             s_0_axi_arqos;  
input   [3:0]             s_0_axi_awqos;  
output  [0:0]             s_0_axi_arready;
input   [2:0]             s_0_axi_arsize; 
input   [0:0]             s_0_axi_arvalid;
input   [20-1:0]          s_0_axi_awaddr; 
input   [1:0]             s_0_axi_awburst;
input   [3:0]             s_0_axi_awcache;
input   [8-1:0]           s_0_axi_awid;   
input   [7:0]             s_0_axi_awlen;  
input   [0:0]             s_0_axi_awlock; 
input   [2:0]             s_0_axi_awprot; 
output  [0:0]             s_0_axi_awready;
input   [2:0]             s_0_axi_awsize; 
input   [0:0]             s_0_axi_awvalid;
output  [8-1:0]           s_0_axi_bid;    
input   [0:0]             s_0_axi_bready; 
output  [1:0]             s_0_axi_bresp;  
output  [0:0]             s_0_axi_bvalid; 
output  [1024-1:0]        s_0_axi_rdata;  
output  [8-1:0]           s_0_axi_rid;    
output  [0:0]             s_0_axi_rlast;  
input   [0:0]             s_0_axi_rready; 
output  [1:0]             s_0_axi_rresp;  
output  [0:0]             s_0_axi_rvalid; 
input   [1024-1:0]        s_0_axi_wdata;  
input   [0:0]             s_0_axi_wlast;  
output  [0:0]             s_0_axi_wready; 
input   [(1024/8)-1:0]    s_0_axi_wstrb;  
input   [0:0]             s_0_axi_wvalid; 
input   [20-1:0]          s_1_axi_araddr; 
input   [1:0]             s_1_axi_arburst;
input   [3:0]             s_1_axi_arcache;
input   [8-1:0]           s_1_axi_arid;   
input   [7:0]             s_1_axi_arlen;  
input   [0:0]             s_1_axi_arlock; 
input   [2:0]             s_1_axi_arprot; 
input   [3:0]             s_1_axi_arqos;  
input   [3:0]             s_1_axi_awqos;  
output  [0:0]             s_1_axi_arready;
input   [2:0]             s_1_axi_arsize; 
input   [0:0]             s_1_axi_arvalid;
input   [20-1:0]          s_1_axi_awaddr; 
input   [1:0]             s_1_axi_awburst;
input   [3:0]             s_1_axi_awcache;
input   [8-1:0]           s_1_axi_awid;   
input   [7:0]             s_1_axi_awlen;  
input   [0:0]             s_1_axi_awlock; 
input   [2:0]             s_1_axi_awprot; 
output  [0:0]             s_1_axi_awready;
input   [2:0]             s_1_axi_awsize; 
input   [0:0]             s_1_axi_awvalid;
output  [8-1:0]           s_1_axi_bid;    
input   [0:0]             s_1_axi_bready; 
output  [1:0]             s_1_axi_bresp;  
output  [0:0]             s_1_axi_bvalid; 
output  [1024-1:0]        s_1_axi_rdata;  
output  [8-1:0]           s_1_axi_rid;    
output  [0:0]             s_1_axi_rlast;  
input   [0:0]             s_1_axi_rready; 
output  [1:0]             s_1_axi_rresp;  
output  [0:0]             s_1_axi_rvalid; 
input   [1024-1:0]        s_1_axi_wdata;  
input   [0:0]             s_1_axi_wlast;  
output  [0:0]             s_1_axi_wready; 
input   [(1024/8)-1:0]    s_1_axi_wstrb;  
input   [0:0]             s_1_axi_wvalid; 
input   [20-1:0]          s_2_axi_araddr; 
input   [1:0]             s_2_axi_arburst;
input   [3:0]             s_2_axi_arcache;
input   [8-1:0]           s_2_axi_arid;   
input   [7:0]             s_2_axi_arlen;  
input   [0:0]             s_2_axi_arlock; 
input   [2:0]             s_2_axi_arprot; 
input   [3:0]             s_2_axi_arqos;  
input   [3:0]             s_2_axi_awqos;  
output  [0:0]             s_2_axi_arready;
input   [2:0]             s_2_axi_arsize; 
input   [0:0]             s_2_axi_arvalid;
input   [20-1:0]          s_2_axi_awaddr; 
input   [1:0]             s_2_axi_awburst;
input   [3:0]             s_2_axi_awcache;
input   [8-1:0]           s_2_axi_awid;   
input   [7:0]             s_2_axi_awlen;  
input   [0:0]             s_2_axi_awlock; 
input   [2:0]             s_2_axi_awprot; 
output  [0:0]             s_2_axi_awready;
input   [2:0]             s_2_axi_awsize; 
input   [0:0]             s_2_axi_awvalid;
output  [8-1:0]           s_2_axi_bid;    
input   [0:0]             s_2_axi_bready; 
output  [1:0]             s_2_axi_bresp;  
output  [0:0]             s_2_axi_bvalid; 
output  [1024-1:0]        s_2_axi_rdata;  
output  [8-1:0]           s_2_axi_rid;    
output  [0:0]             s_2_axi_rlast;  
input   [0:0]             s_2_axi_rready; 
output  [1:0]             s_2_axi_rresp;  
output  [0:0]             s_2_axi_rvalid; 
input   [1024-1:0]        s_2_axi_wdata;  
input   [0:0]             s_2_axi_wlast;  
output  [0:0]             s_2_axi_wready; 
input   [(1024/8)-1:0]    s_2_axi_wstrb;  
input   [0:0]             s_2_axi_wvalid; 
input   [20-1:0]          s_3_axi_araddr; 
input   [1:0]             s_3_axi_arburst;
input   [3:0]             s_3_axi_arcache;
input   [8-1:0]           s_3_axi_arid;   
input   [7:0]             s_3_axi_arlen;  
input   [0:0]             s_3_axi_arlock; 
input   [2:0]             s_3_axi_arprot; 
input   [3:0]             s_3_axi_arqos;  
input   [3:0]             s_3_axi_awqos;  
output  [0:0]             s_3_axi_arready;
input   [2:0]             s_3_axi_arsize; 
input   [0:0]             s_3_axi_arvalid;
input   [20-1:0]          s_3_axi_awaddr; 
input   [1:0]             s_3_axi_awburst;
input   [3:0]             s_3_axi_awcache;
input   [8-1:0]           s_3_axi_awid;   
input   [7:0]             s_3_axi_awlen;  
input   [0:0]             s_3_axi_awlock; 
input   [2:0]             s_3_axi_awprot; 
output  [0:0]             s_3_axi_awready;
input   [2:0]             s_3_axi_awsize; 
input   [0:0]             s_3_axi_awvalid;
output  [8-1:0]           s_3_axi_bid;    
input   [0:0]             s_3_axi_bready; 
output  [1:0]             s_3_axi_bresp;  
output  [0:0]             s_3_axi_bvalid; 
output  [1024-1:0]        s_3_axi_rdata;  
output  [8-1:0]           s_3_axi_rid;    
output  [0:0]             s_3_axi_rlast;  
input   [0:0]             s_3_axi_rready; 
output  [1:0]             s_3_axi_rresp;  
output  [0:0]             s_3_axi_rvalid; 
input   [1024-1:0]        s_3_axi_wdata;  
input   [0:0]             s_3_axi_wlast;  
output  [0:0]             s_3_axi_wready; 
input   [(1024/8)-1:0]    s_3_axi_wstrb;  
input   [0:0]             s_3_axi_wvalid; 



// &Instance("axi_uram_top", "x_axi_uram_0"); @19
axi_uram_top x_axi_uram_0 (
	.s_axi_aclk   (mem_sub_sys_clk ),
	.s_axi_araddr (s_0_axi_araddr  ),
	.s_axi_arburst(s_0_axi_arburst ),
	.s_axi_arcache(s_0_axi_arcache ),
	.s_axi_aresetn(mem_sub_sys_rstn),
	.s_axi_arid   (s_0_axi_arid    ),
	.s_axi_arlen  (s_0_axi_arlen   ),
	.s_axi_arlock (s_0_axi_arlock  ),
	.s_axi_arprot (s_0_axi_arprot  ),
	.s_axi_arqos  (s_0_axi_arqos   ),
	.s_axi_awqos  (s_0_axi_awqos   ),
	.s_axi_arready(s_0_axi_arready ),
	.s_axi_arsize (s_0_axi_arsize  ),
	.s_axi_arvalid(s_0_axi_arvalid ),
	.s_axi_awaddr (s_0_axi_awaddr  ),
	.s_axi_awburst(s_0_axi_awburst ),
	.s_axi_awcache(s_0_axi_awcache ),
	.s_axi_awid   (s_0_axi_awid    ),
	.s_axi_awlen  (s_0_axi_awlen   ),
	.s_axi_awlock (s_0_axi_awlock  ),
	.s_axi_awprot (s_0_axi_awprot  ),
	.s_axi_awready(s_0_axi_awready ),
	.s_axi_awsize (s_0_axi_awsize  ),
	.s_axi_awvalid(s_0_axi_awvalid ),
	.s_axi_bid    (s_0_axi_bid     ),
	.s_axi_bready (s_0_axi_bready  ),
	.s_axi_bresp  (s_0_axi_bresp   ),
	.s_axi_bvalid (s_0_axi_bvalid  ),
	.s_axi_rdata  (s_0_axi_rdata   ),
	.s_axi_rid    (s_0_axi_rid     ),
	.s_axi_rlast  (s_0_axi_rlast   ),
	.s_axi_rready (s_0_axi_rready  ),
	.s_axi_rresp  (s_0_axi_rresp   ),
	.s_axi_rvalid (s_0_axi_rvalid  ),
	.s_axi_wdata  (s_0_axi_wdata   ),
	.s_axi_wlast  (s_0_axi_wlast   ),
	.s_axi_wready (s_0_axi_wready  ),
	.s_axi_wstrb  (s_0_axi_wstrb   ),
	.s_axi_wvalid (s_0_axi_wvalid  )
);
// @20 &ConnRule(r's_axi', r's_0_axi');
// @21 &Connect(
// @22     .s_axi_aclk (mem_sub_sys_clk),
// @23     .s_axi_aresetn (mem_sub_sys_rstn),
// @24 );

// &Instance("axi_uram_top", "x_axi_uram_1"); @26
axi_uram_top x_axi_uram_1 (
	.s_axi_aclk   (mem_sub_sys_clk ),
	.s_axi_araddr (s_1_axi_araddr  ),
	.s_axi_arburst(s_1_axi_arburst ),
	.s_axi_arcache(s_1_axi_arcache ),
	.s_axi_aresetn(mem_sub_sys_rstn),
	.s_axi_arid   (s_1_axi_arid    ),
	.s_axi_arlen  (s_1_axi_arlen   ),
	.s_axi_arlock (s_1_axi_arlock  ),
	.s_axi_arprot (s_1_axi_arprot  ),
	.s_axi_arqos  (s_1_axi_arqos   ),
	.s_axi_awqos  (s_1_axi_awqos   ),
	.s_axi_arready(s_1_axi_arready ),
	.s_axi_arsize (s_1_axi_arsize  ),
	.s_axi_arvalid(s_1_axi_arvalid ),
	.s_axi_awaddr (s_1_axi_awaddr  ),
	.s_axi_awburst(s_1_axi_awburst ),
	.s_axi_awcache(s_1_axi_awcache ),
	.s_axi_awid   (s_1_axi_awid    ),
	.s_axi_awlen  (s_1_axi_awlen   ),
	.s_axi_awlock (s_1_axi_awlock  ),
	.s_axi_awprot (s_1_axi_awprot  ),
	.s_axi_awready(s_1_axi_awready ),
	.s_axi_awsize (s_1_axi_awsize  ),
	.s_axi_awvalid(s_1_axi_awvalid ),
	.s_axi_bid    (s_1_axi_bid     ),
	.s_axi_bready (s_1_axi_bready  ),
	.s_axi_bresp  (s_1_axi_bresp   ),
	.s_axi_bvalid (s_1_axi_bvalid  ),
	.s_axi_rdata  (s_1_axi_rdata   ),
	.s_axi_rid    (s_1_axi_rid     ),
	.s_axi_rlast  (s_1_axi_rlast   ),
	.s_axi_rready (s_1_axi_rready  ),
	.s_axi_rresp  (s_1_axi_rresp   ),
	.s_axi_rvalid (s_1_axi_rvalid  ),
	.s_axi_wdata  (s_1_axi_wdata   ),
	.s_axi_wlast  (s_1_axi_wlast   ),
	.s_axi_wready (s_1_axi_wready  ),
	.s_axi_wstrb  (s_1_axi_wstrb   ),
	.s_axi_wvalid (s_1_axi_wvalid  )
);
// @27 &ConnRule(r's_axi', r's_1_axi');
// @28 &Connect(
// @29     .s_axi_aclk (mem_sub_sys_clk),
// @30     .s_axi_aresetn (mem_sub_sys_rstn),
// @31 );

// &Instance("axi_uram_top", "x_axi_uram_2"); @33
axi_uram_top x_axi_uram_2 (
	.s_axi_aclk   (mem_sub_sys_clk ),
	.s_axi_araddr (s_2_axi_araddr  ),
	.s_axi_arburst(s_2_axi_arburst ),
	.s_axi_arcache(s_2_axi_arcache ),
	.s_axi_aresetn(mem_sub_sys_rstn),
	.s_axi_arid   (s_2_axi_arid    ),
	.s_axi_arlen  (s_2_axi_arlen   ),
	.s_axi_arlock (s_2_axi_arlock  ),
	.s_axi_arprot (s_2_axi_arprot  ),
	.s_axi_arqos  (s_2_axi_arqos   ),
	.s_axi_awqos  (s_2_axi_awqos   ),
	.s_axi_arready(s_2_axi_arready ),
	.s_axi_arsize (s_2_axi_arsize  ),
	.s_axi_arvalid(s_2_axi_arvalid ),
	.s_axi_awaddr (s_2_axi_awaddr  ),
	.s_axi_awburst(s_2_axi_awburst ),
	.s_axi_awcache(s_2_axi_awcache ),
	.s_axi_awid   (s_2_axi_awid    ),
	.s_axi_awlen  (s_2_axi_awlen   ),
	.s_axi_awlock (s_2_axi_awlock  ),
	.s_axi_awprot (s_2_axi_awprot  ),
	.s_axi_awready(s_2_axi_awready ),
	.s_axi_awsize (s_2_axi_awsize  ),
	.s_axi_awvalid(s_2_axi_awvalid ),
	.s_axi_bid    (s_2_axi_bid     ),
	.s_axi_bready (s_2_axi_bready  ),
	.s_axi_bresp  (s_2_axi_bresp   ),
	.s_axi_bvalid (s_2_axi_bvalid  ),
	.s_axi_rdata  (s_2_axi_rdata   ),
	.s_axi_rid    (s_2_axi_rid     ),
	.s_axi_rlast  (s_2_axi_rlast   ),
	.s_axi_rready (s_2_axi_rready  ),
	.s_axi_rresp  (s_2_axi_rresp   ),
	.s_axi_rvalid (s_2_axi_rvalid  ),
	.s_axi_wdata  (s_2_axi_wdata   ),
	.s_axi_wlast  (s_2_axi_wlast   ),
	.s_axi_wready (s_2_axi_wready  ),
	.s_axi_wstrb  (s_2_axi_wstrb   ),
	.s_axi_wvalid (s_2_axi_wvalid  )
);
// @34 &ConnRule(r's_axi', r's_2_axi');
// @35 &Connect(
// @36     .s_axi_aclk (mem_sub_sys_clk),
// @37     .s_axi_aresetn (mem_sub_sys_rstn),
// @38 );

// &Instance("axi_uram_top", "x_axi_uram_3"); @40
axi_uram_top x_axi_uram_3 (
	.s_axi_aclk   (mem_sub_sys_clk ),
	.s_axi_araddr (s_3_axi_araddr  ),
	.s_axi_arburst(s_3_axi_arburst ),
	.s_axi_arcache(s_3_axi_arcache ),
	.s_axi_aresetn(mem_sub_sys_rstn),
	.s_axi_arid   (s_3_axi_arid    ),
	.s_axi_arlen  (s_3_axi_arlen   ),
	.s_axi_arlock (s_3_axi_arlock  ),
	.s_axi_arprot (s_3_axi_arprot  ),
	.s_axi_arqos  (s_3_axi_arqos   ),
	.s_axi_awqos  (s_3_axi_awqos   ),
	.s_axi_arready(s_3_axi_arready ),
	.s_axi_arsize (s_3_axi_arsize  ),
	.s_axi_arvalid(s_3_axi_arvalid ),
	.s_axi_awaddr (s_3_axi_awaddr  ),
	.s_axi_awburst(s_3_axi_awburst ),
	.s_axi_awcache(s_3_axi_awcache ),
	.s_axi_awid   (s_3_axi_awid    ),
	.s_axi_awlen  (s_3_axi_awlen   ),
	.s_axi_awlock (s_3_axi_awlock  ),
	.s_axi_awprot (s_3_axi_awprot  ),
	.s_axi_awready(s_3_axi_awready ),
	.s_axi_awsize (s_3_axi_awsize  ),
	.s_axi_awvalid(s_3_axi_awvalid ),
	.s_axi_bid    (s_3_axi_bid     ),
	.s_axi_bready (s_3_axi_bready  ),
	.s_axi_bresp  (s_3_axi_bresp   ),
	.s_axi_bvalid (s_3_axi_bvalid  ),
	.s_axi_rdata  (s_3_axi_rdata   ),
	.s_axi_rid    (s_3_axi_rid     ),
	.s_axi_rlast  (s_3_axi_rlast   ),
	.s_axi_rready (s_3_axi_rready  ),
	.s_axi_rresp  (s_3_axi_rresp   ),
	.s_axi_rvalid (s_3_axi_rvalid  ),
	.s_axi_wdata  (s_3_axi_wdata   ),
	.s_axi_wlast  (s_3_axi_wlast   ),
	.s_axi_wready (s_3_axi_wready  ),
	.s_axi_wstrb  (s_3_axi_wstrb   ),
	.s_axi_wvalid (s_3_axi_wvalid  )
);
// @41 &ConnRule(r's_axi', r's_3_axi');
// @42 &Connect(
// @43     .s_axi_aclk (mem_sub_sys_clk),
// @44     .s_axi_aresetn (mem_sub_sys_rstn),
// @45 );


endmodule
