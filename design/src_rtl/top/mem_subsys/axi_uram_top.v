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

module axi_uram_top(
  s_axi_aclk,
  s_axi_araddr,
  s_axi_arburst,
  s_axi_arcache,
  s_axi_aresetn,
  s_axi_arid,
  s_axi_arlen,
  s_axi_arlock,
  s_axi_arprot,
  s_axi_arqos,
  s_axi_awqos,
  s_axi_arready,
  s_axi_arsize,
  s_axi_arvalid,
  s_axi_awaddr,
  s_axi_awburst,
  s_axi_awcache,
  s_axi_awid,
  s_axi_awlen,
  s_axi_awlock,
  s_axi_awprot,
  s_axi_awready,
  s_axi_awsize,
  s_axi_awvalid,
  s_axi_bid,
  s_axi_bready,
  s_axi_bresp,
  s_axi_bvalid,
  s_axi_rdata,
  s_axi_rid,
  s_axi_rlast,
  s_axi_rready,
  s_axi_rresp,
  s_axi_rvalid,
  s_axi_wdata,
  s_axi_wlast,
  s_axi_wready,
  s_axi_wstrb,
  s_axi_wvalid
);

parameter MEMORY_INIT_FILE = "none";
parameter integer C_S_AXI_ID_WIDTH	= 8;
// Width of S_AXI data bus
parameter integer C_S_AXI_DATA_WIDTH	= 1024;
// Width of S_AXI address bus
parameter integer C_S_AXI_ADDR_WIDTH	= 20; //8MB

input             s_axi_aclk;   
input   [C_S_AXI_ADDR_WIDTH-1  :0]  s_axi_araddr; 
input   [1   :0]  s_axi_arburst; 
input   [3   :0]  s_axi_arcache; 
input             s_axi_aresetn; 
input   [C_S_AXI_ID_WIDTH-1:0]  s_axi_arid;   
input   [7   :0]  s_axi_arlen;  
input             s_axi_arlock; 
input   [2   :0]  s_axi_arprot; 
input   [2   :0]  s_axi_arsize; 
input             s_axi_arvalid; 
input   [C_S_AXI_ADDR_WIDTH-1  :0]  s_axi_awaddr; 
input   [1   :0]  s_axi_awburst; 
input   [3   :0]  s_axi_awcache; 
input   [C_S_AXI_ID_WIDTH-1:0]  s_axi_awid;   
input   [7   :0]  s_axi_awlen;  
input             s_axi_awlock; 
input   [2   :0]  s_axi_awprot; 
input   [2   :0]  s_axi_awsize; 
input             s_axi_awvalid; 
input             s_axi_bready; 
input             s_axi_rready; 
input   [C_S_AXI_DATA_WIDTH-1:0]  s_axi_wdata;  
input             s_axi_wlast;  
input   [(C_S_AXI_DATA_WIDTH/8)-1 :0]  s_axi_wstrb;  
input             s_axi_wvalid; 
output            s_axi_arready; 
output            s_axi_awready; 
output  [C_S_AXI_ID_WIDTH-1:0]  s_axi_bid;    
output  [1   :0]  s_axi_bresp;  
output            s_axi_bvalid; 
output  [C_S_AXI_DATA_WIDTH-1:0]  s_axi_rdata;  
output  [C_S_AXI_ID_WIDTH-1:0]  s_axi_rid;    
output            s_axi_rlast;  
output  [1   :0]  s_axi_rresp;  
output            s_axi_rvalid; 
output            s_axi_wready; 
input  	 [3:0]  s_axi_arqos;
input  	 [3:0]  s_axi_awqos;

wire              s_axi_aclk;   
wire    [C_S_AXI_ADDR_WIDTH-1  :0]  s_axi_araddr; 
wire    [1   :0]  s_axi_arburst; 
wire    [3   :0]  s_axi_arcache; 
wire              s_axi_aresetn; 
wire    [C_S_AXI_ID_WIDTH-1:0]  s_axi_arid;   
wire    [7   :0]  s_axi_arlen;  
wire              s_axi_arlock; 
wire    [2   :0]  s_axi_arprot; 
wire              s_axi_arready; 
wire    [2   :0]  s_axi_arsize; 
wire              s_axi_arvalid; 
wire    [C_S_AXI_ADDR_WIDTH-1  :0]  s_axi_awaddr; 
wire    [1   :0]  s_axi_awburst; 
wire    [3   :0]  s_axi_awcache; 
wire    [C_S_AXI_ID_WIDTH-1:0]  s_axi_awid;   
wire    [7   :0]  s_axi_awlen;  
wire              s_axi_awlock; 
wire    [2   :0]  s_axi_awprot; 
wire              s_axi_awready; 
wire    [2   :0]  s_axi_awsize; 
wire              s_axi_awvalid; 
wire    [C_S_AXI_ID_WIDTH-1:0]  s_axi_bid;    
wire              s_axi_bready; 
wire    [1   :0]  s_axi_bresp;  
wire              s_axi_bvalid; 
wire    [C_S_AXI_DATA_WIDTH-1:0]  s_axi_rdata;  
wire    [C_S_AXI_ID_WIDTH-1:0]  s_axi_rid;    
wire              s_axi_rlast;  
wire              s_axi_rready; 
wire    [1   :0]  s_axi_rresp;  
wire              s_axi_rvalid; 
wire    [C_S_AXI_DATA_WIDTH-1:0]  s_axi_wdata;  
wire              s_axi_wlast;  
wire              s_axi_wready; 
wire    [(C_S_AXI_DATA_WIDTH/8)-1 :0]  s_axi_wstrb;  
wire              s_axi_wvalid; 


axi_uram  #(
    .MEMORY_INIT_FILE(MEMORY_INIT_FILE),
    .URAM_LATENCY(1),
    .MAX_OUTSTANDING_TRANX(16),
    .C_S_AXI_ID_WIDTH(C_S_AXI_ID_WIDTH),
    .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
    .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
) x_axi_uram (
  .s_axi_aclk    (s_axi_aclk   ),
  .s_axi_araddr  (s_axi_araddr ),
  .s_axi_arburst (s_axi_arburst),
  .s_axi_arcache (s_axi_arcache),
  .s_axi_aresetn (s_axi_aresetn),
  .s_axi_arid    (s_axi_arid   ),
  .s_axi_arlen   (s_axi_arlen  ),
  .s_axi_arlock  (s_axi_arlock ),
  .s_axi_arprot  (s_axi_arprot ),
  .s_axi_arready (s_axi_arready),
  .s_axi_arsize  (s_axi_arsize ),
  .s_axi_arvalid (s_axi_arvalid),
  .s_axi_awaddr  (s_axi_awaddr ),
  .s_axi_awburst (s_axi_awburst),
  .s_axi_awcache (s_axi_awcache),
  .s_axi_awid    (s_axi_awid   ),
  .s_axi_awlen   (s_axi_awlen  ),
  .s_axi_awlock  (s_axi_awlock ),
  .s_axi_awprot  (s_axi_awprot ),
  .s_axi_awready (s_axi_awready),
  .s_axi_awsize  (s_axi_awsize ),
  .s_axi_awvalid (s_axi_awvalid),
  .s_axi_bid     (s_axi_bid    ),
  .s_axi_bready  (s_axi_bready ),
  .s_axi_bresp   (s_axi_bresp  ),
  .s_axi_bvalid  (s_axi_bvalid ),
  .s_axi_rdata   (s_axi_rdata  ),
  .s_axi_rid     (s_axi_rid    ),
  .s_axi_rlast   (s_axi_rlast  ),
  .s_axi_rready  (s_axi_rready ),
  .s_axi_rresp   (s_axi_rresp  ),
  .s_axi_rvalid  (s_axi_rvalid ),
  .s_axi_wdata   (s_axi_wdata  ),
  .s_axi_wlast   (s_axi_wlast  ),
  .s_axi_wready  (s_axi_wready ),
  .s_axi_wstrb   (s_axi_wstrb  ),
  .s_axi_wvalid  (s_axi_wvalid )
);

endmodule


