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
module pe_top (
	regular_0_clk,
	regular_0_rstn,
	regular_1_clk,
	regular_1_rstn,
	nou_clk,
	nou_rstn,
	dsa_2_clk,
	dsa_2_rstn,
	dispatcher_clk,
	dispatcher_rstn,
	dsa_0_clk,
	dsa_0_rstn,
	dsa_1_clk,
	dsa_1_rstn,
	dsa_0_m_dsa_0_clk,
	dsa_0_m_dsa_0_rstn,
	dsa_1_m_dsa_1_clk,
	dsa_1_m_dsa_1_rstn,
	dsa_2_m_dsa_2_clk,
	dsa_2_m_dsa_2_rstn,
	mem_sub_sys_clk,
	mem_sub_sys_rstn,
	myLocX,
	myLocY,
	myChipID,
	dat_W_out,
	dat_vld_W_out,
	dat_yummy_W_in,
	dat_W_in,
	dat_vld_W_in,
	dat_yummy_W_out,
	rsp_W_out,
	rsp_vld_W_out,
	rsp_yummy_W_in,
	rsp_W_in,
	rsp_vld_W_in,
	rsp_yummy_W_out,
	dat_E_out,
	dat_vld_E_out,
	dat_yummy_E_in,
	dat_E_in,
	dat_vld_E_in,
	dat_yummy_E_out,
	rsp_E_out,
	rsp_vld_E_out,
	rsp_yummy_E_in,
	rsp_E_in,
	rsp_vld_E_in,
	rsp_yummy_E_out,
	dat_N_out,
	dat_vld_N_out,
	dat_yummy_N_in,
	dat_N_in,
	dat_vld_N_in,
	dat_yummy_N_out,
	rsp_N_out,
	rsp_vld_N_out,
	rsp_yummy_N_in,
	rsp_N_in,
	rsp_vld_N_in,
	rsp_yummy_N_out,
	dat_S_out,
	dat_vld_S_out,
	dat_yummy_S_in,
	dat_S_in,
	dat_vld_S_in,
	dat_yummy_S_out,
	rsp_S_out,
	rsp_vld_S_out,
	rsp_yummy_S_in,
	rsp_S_in,
	rsp_vld_S_in,
	rsp_yummy_S_out,
	sys_clk,
	sys_rstn,
	S_HOST_AXI_aclk,
	S_HOST_AXI_araddr,
	S_HOST_AXI_arburst,
	S_HOST_AXI_arcache,
	S_HOST_AXI_aresetn,
	S_HOST_AXI_arid,
	S_HOST_AXI_arlen,
	S_HOST_AXI_arlock,
	S_HOST_AXI_arprot,
	S_HOST_AXI_arqos,
	S_HOST_AXI_arsize,
	S_HOST_AXI_arvalid,
	S_HOST_AXI_awaddr,
	S_HOST_AXI_awburst,
	S_HOST_AXI_awcache,
	S_HOST_AXI_awid,
	S_HOST_AXI_awlen,
	S_HOST_AXI_awlock,
	S_HOST_AXI_awprot,
	S_HOST_AXI_awqos,
	S_HOST_AXI_awsize,
	S_HOST_AXI_awvalid,
	S_HOST_AXI_bready,
	S_HOST_AXI_rready,
	S_HOST_AXI_wdata,
	S_HOST_AXI_wlast,
	S_HOST_AXI_wstrb,
	S_HOST_AXI_wvalid,
	S_HOST_AXI_arready,
	S_HOST_AXI_awready,
	S_HOST_AXI_bid,
	S_HOST_AXI_bresp,
	S_HOST_AXI_bvalid,
	S_HOST_AXI_rdata,
	S_HOST_AXI_rid,
	S_HOST_AXI_rlast,
	S_HOST_AXI_rresp,
	S_HOST_AXI_rvalid,
	S_HOST_AXI_wready
);

// &Ports; @17
input   [0:0]                           regular_0_clk;    
input   [0:0]                           regular_0_rstn;   
input   [0:0]                           regular_1_clk;    
input   [0:0]                           regular_1_rstn;   
input   [0:0]                           nou_clk;          
input   [0:0]                           nou_rstn;         
input   [0:0]                           dsa_2_clk;        
input   [0:0]                           dsa_2_rstn;       
input   [0:0]                           dispatcher_clk;   
input   [0:0]                           dispatcher_rstn;  
input   [0:0]                           dsa_0_clk;        
input   [0:0]                           dsa_0_rstn;       
input   [0:0]                           dsa_1_clk;        
input   [0:0]                           dsa_1_rstn;       
input   [0:0]                           dsa_0_m_dsa_0_clk;
input   [0:0]                           dsa_0_m_dsa_0_rstn;
input   [0:0]                           dsa_1_m_dsa_1_clk;
input   [0:0]                           dsa_1_m_dsa_1_rstn;
input   [0:0]                           dsa_2_m_dsa_2_clk;
input   [0:0]                           dsa_2_m_dsa_2_rstn;
input   [0:0]                           mem_sub_sys_clk;  
input   [0:0]                           mem_sub_sys_rstn; 
input   [`XY_WIDTH-1:0]                 myLocX;           
input   [`XY_WIDTH-1:0]                 myLocY;           
input   [`CHIP_ID_WIDTH-1:0]            myChipID;         
output  [`DATA_WIDTH-1:0]               dat_W_out;        
output  [0:0]                           dat_vld_W_out;    
input   [0:0]                           dat_yummy_W_in;   
input   [`DATA_WIDTH-1:0]               dat_W_in;         
input   [0:0]                           dat_vld_W_in;     
output  [0:0]                           dat_yummy_W_out;  
output  [`RSP_WIDTH-1:0]                rsp_W_out;        
output  [0:0]                           rsp_vld_W_out;    
input   [0:0]                           rsp_yummy_W_in;   
input   [`RSP_WIDTH-1:0]                rsp_W_in;         
input   [0:0]                           rsp_vld_W_in;     
output  [0:0]                           rsp_yummy_W_out;  
output  [`DATA_WIDTH-1:0]               dat_E_out;        
output  [0:0]                           dat_vld_E_out;    
input   [0:0]                           dat_yummy_E_in;   
input   [`DATA_WIDTH-1:0]               dat_E_in;         
input   [0:0]                           dat_vld_E_in;     
output  [0:0]                           dat_yummy_E_out;  
output  [`RSP_WIDTH-1:0]                rsp_E_out;        
output  [0:0]                           rsp_vld_E_out;    
input   [0:0]                           rsp_yummy_E_in;   
input   [`RSP_WIDTH-1:0]                rsp_E_in;         
input   [0:0]                           rsp_vld_E_in;     
output  [0:0]                           rsp_yummy_E_out;  
output  [`DATA_WIDTH-1:0]               dat_N_out;        
output  [0:0]                           dat_vld_N_out;    
input   [0:0]                           dat_yummy_N_in;   
input   [`DATA_WIDTH-1:0]               dat_N_in;         
input   [0:0]                           dat_vld_N_in;     
output  [0:0]                           dat_yummy_N_out;  
output  [`RSP_WIDTH-1:0]                rsp_N_out;        
output  [0:0]                           rsp_vld_N_out;    
input   [0:0]                           rsp_yummy_N_in;   
input   [`RSP_WIDTH-1:0]                rsp_N_in;         
input   [0:0]                           rsp_vld_N_in;     
output  [0:0]                           rsp_yummy_N_out;  
output  [`DATA_WIDTH-1:0]               dat_S_out;        
output  [0:0]                           dat_vld_S_out;    
input   [0:0]                           dat_yummy_S_in;   
input   [`DATA_WIDTH-1:0]               dat_S_in;         
input   [0:0]                           dat_vld_S_in;     
output  [0:0]                           dat_yummy_S_out;  
output  [`RSP_WIDTH-1:0]                rsp_S_out;        
output  [0:0]                           rsp_vld_S_out;    
input   [0:0]                           rsp_yummy_S_in;   
input   [`RSP_WIDTH-1:0]                rsp_S_in;         
input   [0:0]                           rsp_vld_S_in;     
output  [0:0]                           rsp_yummy_S_out;  
input   [0:0]                           sys_clk;          
input   [0:0]                           sys_rstn;         
input   [0:0]                           S_HOST_AXI_aclk;  
input   [31:0]                          S_HOST_AXI_araddr;
input   [1:0]                           S_HOST_AXI_arburst;
input   [3:0]                           S_HOST_AXI_arcache;
input   [0:0]                           S_HOST_AXI_aresetn;
input   [`AXI_MASTER_ID_WIDTH-1:0]      S_HOST_AXI_arid;  
input   [7:0]                           S_HOST_AXI_arlen; 
input   [0:0]                           S_HOST_AXI_arlock;
input   [2:0]                           S_HOST_AXI_arprot;
input   [3:0]                           S_HOST_AXI_arqos; 
input   [2:0]                           S_HOST_AXI_arsize;
input   [0:0]                           S_HOST_AXI_arvalid;
input   [31:0]                          S_HOST_AXI_awaddr;
input   [1:0]                           S_HOST_AXI_awburst;
input   [3:0]                           S_HOST_AXI_awcache;
input   [`AXI_MASTER_ID_WIDTH-1:0]      S_HOST_AXI_awid;  
input   [7:0]                           S_HOST_AXI_awlen; 
input   [0:0]                           S_HOST_AXI_awlock;
input   [2:0]                           S_HOST_AXI_awprot;
input   [3:0]                           S_HOST_AXI_awqos; 
input   [2:0]                           S_HOST_AXI_awsize;
input   [0:0]                           S_HOST_AXI_awvalid;
input   [0:0]                           S_HOST_AXI_bready;
input   [0:0]                           S_HOST_AXI_rready;
input   [1023:0]                        S_HOST_AXI_wdata; 
input   [0:0]                           S_HOST_AXI_wlast; 
input   [127:0]                         S_HOST_AXI_wstrb; 
input   [0:0]                           S_HOST_AXI_wvalid;
output  [0:0]                           S_HOST_AXI_arready;
output  [0:0]                           S_HOST_AXI_awready;
output  [`AXI_MASTER_ID_WIDTH-1:0]      S_HOST_AXI_bid;   
output  [1:0]                           S_HOST_AXI_bresp; 
output  [0:0]                           S_HOST_AXI_bvalid;
output  [1023:0]                        S_HOST_AXI_rdata; 
output  [`AXI_MASTER_ID_WIDTH-1:0]      S_HOST_AXI_rid;   
output  [0:0]                           S_HOST_AXI_rlast; 
output  [1:0]                           S_HOST_AXI_rresp; 
output  [0:0]                           S_HOST_AXI_rvalid;
output  [0:0]                           S_HOST_AXI_wready;

wire    [96-1:0]                           regular_0_xocc_4_cmd_buffer;
wire    [32-1:0]                           regular_0_xocc_4_rsp_buffer;
wire    [0:0]                              regular_0_xocc_4_rsp_full;  
wire    [0:0]                              regular_0_xocc_4_rsp_wr_en; 
wire    [0:0]                              regular_0_xocc_4_cmd_rd_en; 
wire    [0:0]                              regular_0_xocc_4_cmd_empty; 
wire    [32-1:0]                           regular_1_xocc_5_cmd_buffer;
wire    [0:0]                              regular_1_xocc_5_cmd_rd_en; 
wire    [0:0]                              regular_1_xocc_5_rsp_wr_en; 
wire    [0:0]                              regular_1_xocc_5_rsp_full;  
wire    [32-1:0]                           regular_1_xocc_5_rsp_buffer;
wire    [0:0]                              regular_1_xocc_5_cmd_empty; 
wire    [0:0]                              dispatcher_xocc_3_cmd_rd_en;
wire    [32-1:0]                           dispatcher_xocc_3_cmd_buffer;
wire    [0:0]                              dispatcher_xocc_3_rsp_full; 
wire    [32-1:0]                           dispatcher_xocc_3_rsp_buffer;
wire    [0:0]                              dispatcher_xocc_3_rsp_wr_en;
wire    [0:0]                              dispatcher_xocc_3_cmd_empty;
wire    [0:0]                              dispatcher_xocc_2_cmd_rd_en;
wire    [64-1:0]                           dispatcher_xocc_2_cmd_buffer;
wire    [0:0]                              dispatcher_xocc_2_rsp_wr_en;
wire    [64-1:0]                           dispatcher_xocc_2_rsp_buffer;
wire    [0:0]                              dispatcher_xocc_2_rsp_full; 
wire    [0:0]                              dispatcher_xocc_2_cmd_empty;
wire    [31:0]                             regular_1_pc;               
wire    [31:0]                             regular_0_rst_addr;         
wire    [31:0]                             regular_0_pc;               
wire    [31:0]                             dispatcher_pc;              
wire    [31:0]                             dispatcher_rst_addr;        
wire    [31:0]                             regular_1_rst_addr;         
wire    [0:0]                              dispatcher_m_axi_arvalid;   
wire    [31:0]                             regular_1_m_axi_wdata;      
wire    [3:0]                              regular_0_m_axi_awqos;      
wire    [0:0]                              regular_1_m_axi_awlock;     
wire    [0:0]                              dispatcher_m_axi_wready;    
wire    [31:0]                             regular_1_m_axi_awaddr;     
wire    [2:0]                              regular_0_m_axi_arprot;     
wire    [3:0]                              regular_1_m_axi_arqos;      
wire    [0:0]                              dispatcher_m_axi_arready;   
wire    [0:0]                              dispatcher_m_axi_arlock;    
wire    [0:0]                              dispatcher_m_axi_awvalid;   
wire    [1:0]                              regular_0_m_axi_awburst;    
wire    [0:0]                              regular_0_m_axi_rready;     
wire    [2:0]                              dispatcher_m_axi_awsize;    
wire    [3:0]                              dispatcher_m_axi_arid;      
wire    [2:0]                              regular_0_m_axi_arsize;     
wire    [0:0]                              regular_0_m_axi_bready;     
wire    [0:0]                              regular_1_m_axi_rvalid;     
wire    [0:0]                              regular_1_m_axi_rready;     
wire    [3:0]                              dispatcher_m_axi_awqos;     
wire    [2:0]                              dispatcher_m_axi_awprot;    
wire    [3:0]                              regular_1_m_axi_wstrb;      
wire    [0:0]                              regular_1_m_axi_wvalid;     
wire    [31:0]                             dispatcher_m_axi_araddr;    
wire    [7:0]                              regular_1_m_axi_awlen;      
wire    [0:0]                              regular_0_m_axi_rlast;      
wire    [0:0]                              regular_1_m_axi_rlast;      
wire    [0:0]                              regular_0_m_axi_arlock;     
wire    [7:0]                              dispatcher_m_axi_awlen;     
wire    [3:0]                              regular_1_m_axi_rid;        
wire    [2:0]                              regular_1_m_axi_awsize;     
wire    [31:0]                             regular_0_m_axi_wdata;      
wire    [0:0]                              regular_0_m_axi_wready;     
wire    [1:0]                              regular_1_m_axi_bresp;      
wire    [0:0]                              regular_0_m_axi_bvalid;     
wire    [3:0]                              regular_1_m_axi_awid;       
wire    [2:0]                              regular_0_m_axi_awsize;     
wire    [31:0]                             regular_1_m_axi_araddr;     
wire    [2:0]                              dispatcher_m_axi_arprot;    
wire    [0:0]                              regular_0_m_axi_wvalid;     
wire    [7:0]                              regular_0_m_axi_arlen;      
wire    [0:0]                              regular_1_m_axi_awready;    
wire    [3:0]                              regular_0_m_axi_rid;        
wire    [3:0]                              regular_1_m_axi_awcache;    
wire    [3:0]                              regular_0_m_axi_wstrb;      
wire    [3:0]                              dispatcher_m_axi_rid;       
wire    [3:0]                              dispatcher_m_axi_arqos;     
wire    [3:0]                              regular_0_m_axi_bid;        
wire    [0:0]                              regular_1_m_axi_bvalid;     
wire    [1:0]                              regular_1_m_axi_arburst;    
wire    [0:0]                              dispatcher_m_axi_bready;    
wire    [1:0]                              regular_0_m_axi_rresp;      
wire    [0:0]                              dispatcher_m_axi_wvalid;    
wire    [1:0]                              dispatcher_m_axi_arburst;   
wire    [3:0]                              dispatcher_m_axi_awcache;   
wire    [0:0]                              regular_1_m_axi_arvalid;    
wire    [3:0]                              regular_0_m_axi_arcache;    
wire    [0:0]                              regular_0_m_axi_awlock;     
wire    [0:0]                              regular_0_m_axi_rvalid;     
wire    [3:0]                              regular_1_m_axi_awqos;      
wire    [31:0]                             regular_0_m_axi_araddr;     
wire    [0:0]                              regular_0_m_axi_awvalid;    
wire    [3:0]                              regular_0_m_axi_awid;       
wire    [3:0]                              regular_1_m_axi_bid;        
wire    [3:0]                              regular_0_m_axi_arqos;      
wire    [1:0]                              regular_0_m_axi_arburst;    
wire    [31:0]                             regular_1_m_axi_rdata;      
wire    [1:0]                              regular_1_m_axi_rresp;      
wire    [7:0]                              regular_0_m_axi_awlen;      
wire    [1:0]                              regular_0_m_axi_bresp;      
wire    [0:0]                              regular_0_m_axi_arready;    
wire    [0:0]                              regular_1_m_axi_arready;    
wire    [1:0]                              dispatcher_m_axi_rresp;     
wire    [2:0]                              regular_1_m_axi_awprot;     
wire    [0:0]                              dispatcher_m_axi_rvalid;    
wire    [0:0]                              regular_1_m_axi_awvalid;    
wire    [31:0]                             dispatcher_m_axi_rdata;     
wire    [2:0]                              regular_1_m_axi_arprot;     
wire    [3:0]                              dispatcher_m_axi_arcache;   
wire    [3:0]                              regular_0_m_axi_awcache;    
wire    [0:0]                              regular_0_m_axi_wlast;      
wire    [1:0]                              dispatcher_m_axi_bresp;     
wire    [0:0]                              regular_1_m_axi_bready;     
wire    [2:0]                              regular_0_m_axi_awprot;     
wire    [0:0]                              regular_0_m_axi_arvalid;    
wire    [0:0]                              dispatcher_m_axi_rlast;     
wire    [1:0]                              regular_1_m_axi_awburst;    
wire    [2:0]                              regular_1_m_axi_arsize;     
wire    [3:0]                              dispatcher_m_axi_wstrb;     
wire    [31:0]                             regular_0_m_axi_rdata;      
wire    [31:0]                             regular_0_m_axi_awaddr;     
wire    [3:0]                              regular_0_m_axi_arid;       
wire    [3:0]                              dispatcher_m_axi_bid;       
wire    [2:0]                              dispatcher_m_axi_arsize;    
wire    [0:0]                              regular_1_m_axi_wready;     
wire    [7:0]                              regular_1_m_axi_arlen;      
wire    [3:0]                              regular_1_m_axi_arcache;    
wire    [1:0]                              dispatcher_m_axi_awburst;   
wire    [31:0]                             dispatcher_m_axi_awaddr;    
wire    [0:0]                              dispatcher_m_axi_rready;    
wire    [0:0]                              regular_1_m_axi_arlock;     
wire    [0:0]                              regular_0_m_axi_awready;    
wire    [3:0]                              dispatcher_m_axi_awid;      
wire    [0:0]                              dispatcher_m_axi_awlock;    
wire    [0:0]                              dispatcher_m_axi_wlast;     
wire    [0:0]                              dispatcher_m_axi_bvalid;    
wire    [7:0]                              dispatcher_m_axi_arlen;     
wire    [0:0]                              dispatcher_m_axi_awready;   
wire    [31:0]                             dispatcher_m_axi_wdata;     
wire    [0:0]                              regular_1_m_axi_wlast;      
wire    [3:0]                              regular_1_m_axi_arid;       
wire    [0:0]                              dsa_0_m_axi_awvalid;        
wire    [1:0]                              dsa_0_m_axi_arburst;        
wire    [2:0]                              dsa_0_m_axi_awprot;         
wire    [3:0]                              dsa_0_m_axi_arcache;        
wire    [2:0]                              dsa_0_m_axi_arsize;         
wire    [0:0]                              dsa_0_m_axi_wvalid;         
wire    [0:0]                              dsa_0_m_axi_arlock;         
wire    [1:0]                              dsa_0_m_axi_awburst;        
wire    [32-1:0]                           dsa_0_m_axi_araddr;         
wire    [32-1:0]                           dsa_0_m_axi_awaddr;         
wire    [1024/8-1:0]                       dsa_0_m_axi_wstrb;          
wire    [0:0]                              dsa_0_m_axi_bready;         
wire    [2:0]                              dsa_0_m_axi_arprot;         
wire    [0:0]                              dsa_0_m_axi_wlast;          
wire    [7:0]                              dsa_0_m_axi_awlen;          
wire    [0:0]                              dsa_0_m_axi_awready;        
wire    [1:0]                              dsa_0_m_axi_rresp;          
wire    [0:0]                              dsa_0_m_axi_rvalid;         
wire    [0:0]                              dsa_0_m_axi_arvalid;        
wire    [3:0]                              dsa_0_m_axi_awqos;          
wire    [`AXI_MASTER_ID_WIDTH-1:0]         dsa_0_m_axi_awid;           
wire    [1:0]                              dsa_0_m_axi_bresp;          
wire    [0:0]                              dsa_0_m_axi_bvalid;         
wire    [0:0]                              dsa_0_m_axi_rlast;          
wire    [3:0]                              dsa_0_m_axi_awcache;        
wire    [2:0]                              dsa_0_m_axi_awsize;         
wire    [0:0]                              dsa_0_m_axi_rready;         
wire    [`AXI_MASTER_ID_WIDTH-1:0]         dsa_0_m_axi_bid;            
wire    [0:0]                              dsa_0_m_axi_wready;         
wire    [0:0]                              dsa_0_m_axi_awlock;         
wire    [1024-1:0]                         dsa_0_m_axi_rdata;          
wire    [7:0]                              dsa_0_m_axi_arlen;          
wire    [0:0]                              dsa_0_m_axi_arready;        
wire    [1024-1:0]                         dsa_0_m_axi_wdata;          
wire    [3:0]                              dsa_0_m_axi_arqos;          
wire    [`AXI_MASTER_ID_WIDTH-1:0]         dsa_0_m_axi_rid;            
wire    [`AXI_MASTER_ID_WIDTH-1:0]         dsa_0_m_axi_arid;           
wire    [0:0]                              dsa_1_m_axi_rvalid;         
wire    [`AXI_MASTER_ID_WIDTH-1:0]         dsa_1_m_axi_awid;           
wire    [7:0]                              dsa_1_m_axi_arlen;          
wire    [1:0]                              dsa_1_m_axi_rresp;          
wire    [2:0]                              dsa_1_m_axi_arprot;         
wire    [3:0]                              dsa_1_m_axi_awqos;          
wire    [0:0]                              dsa_1_m_axi_bready;         
wire    [0:0]                              dsa_1_m_axi_awvalid;        
wire    [1:0]                              dsa_1_m_axi_awburst;        
wire    [1024/8-1:0]                       dsa_1_m_axi_wstrb;          
wire    [3:0]                              dsa_1_m_axi_awcache;        
wire    [2:0]                              dsa_1_m_axi_awprot;         
wire    [0:0]                              dsa_1_m_axi_arlock;         
wire    [32-1:0]                           dsa_1_m_axi_awaddr;         
wire    [3:0]                              dsa_1_m_axi_arcache;        
wire    [7:0]                              dsa_1_m_axi_awlen;          
wire    [1024-1:0]                         dsa_1_m_axi_wdata;          
wire    [1:0]                              dsa_1_m_axi_bresp;          
wire    [0:0]                              dsa_1_m_axi_wready;         
wire    [`AXI_MASTER_ID_WIDTH-1:0]         dsa_1_m_axi_bid;            
wire    [1:0]                              dsa_1_m_axi_arburst;        
wire    [3:0]                              dsa_1_m_axi_arqos;          
wire    [0:0]                              dsa_1_m_axi_bvalid;         
wire    [0:0]                              dsa_1_m_axi_rlast;          
wire    [`AXI_MASTER_ID_WIDTH-1:0]         dsa_1_m_axi_arid;           
wire    [0:0]                              dsa_1_m_axi_rready;         
wire    [0:0]                              dsa_1_m_axi_arvalid;        
wire    [0:0]                              dsa_1_m_axi_awlock;         
wire    [2:0]                              dsa_1_m_axi_awsize;         
wire    [32-1:0]                           dsa_1_m_axi_araddr;         
wire    [0:0]                              dsa_1_m_axi_wlast;          
wire    [0:0]                              dsa_1_m_axi_wvalid;         
wire    [0:0]                              dsa_1_m_axi_arready;        
wire    [1024-1:0]                         dsa_1_m_axi_rdata;          
wire    [0:0]                              dsa_1_m_axi_awready;        
wire    [`AXI_MASTER_ID_WIDTH-1:0]         dsa_1_m_axi_rid;            
wire    [2:0]                              dsa_1_m_axi_arsize;         
wire    [1:0]                              dsa_2_m_axi_bresp;          
wire    [0:0]                              dsa_2_m_axi_wready;         
wire    [32-1:0]                           dsa_2_m_axi_awaddr;         
wire    [3:0]                              dsa_2_m_axi_awcache;        
wire    [3:0]                              dsa_2_m_axi_arqos;          
wire    [`AXI_MASTER_ID_WIDTH-1:0]         dsa_2_m_axi_awid;           
wire    [0:0]                              dsa_2_m_axi_rvalid;         
wire    [0:0]                              dsa_2_m_axi_wvalid;         
wire    [1024-1:0]                         dsa_2_m_axi_rdata;          
wire    [1:0]                              dsa_2_m_axi_awburst;        
wire    [1:0]                              dsa_2_m_axi_rresp;          
wire    [32-1:0]                           dsa_2_m_axi_araddr;         
wire    [0:0]                              dsa_2_m_axi_bready;         
wire    [1024/8-1:0]                       dsa_2_m_axi_wstrb;          
wire    [0:0]                              dsa_2_m_axi_bvalid;         
wire    [2:0]                              dsa_2_m_axi_arprot;         
wire    [0:0]                              dsa_2_m_axi_awready;        
wire    [2:0]                              dsa_2_m_axi_awsize;         
wire    [0:0]                              dsa_2_m_axi_arready;        
wire    [2:0]                              dsa_2_m_axi_awprot;         
wire    [0:0]                              dsa_2_m_axi_arlock;         
wire    [1:0]                              dsa_2_m_axi_arburst;        
wire    [2:0]                              dsa_2_m_axi_arsize;         
wire    [7:0]                              dsa_2_m_axi_arlen;          
wire    [3:0]                              dsa_2_m_axi_arcache;        
wire    [7:0]                              dsa_2_m_axi_awlen;          
wire    [0:0]                              dsa_2_m_axi_wlast;          
wire    [1024-1:0]                         dsa_2_m_axi_wdata;          
wire    [`AXI_MASTER_ID_WIDTH-1:0]         dsa_2_m_axi_rid;            
wire    [`AXI_MASTER_ID_WIDTH-1:0]         dsa_2_m_axi_arid;           
wire    [3:0]                              dsa_2_m_axi_awqos;          
wire    [0:0]                              dsa_2_m_axi_rlast;          
wire    [0:0]                              dsa_2_m_axi_awvalid;        
wire    [`AXI_MASTER_ID_WIDTH-1:0]         dsa_2_m_axi_bid;            
wire    [0:0]                              dsa_2_m_axi_awlock;         
wire    [0:0]                              dsa_2_m_axi_arvalid;        
wire    [0:0]                              dsa_2_m_axi_rready;         
wire    [`NOU_TYPE_WIDTH-1:0]              nou_noc_rsp_type;           
wire    [`NOU_NOC_DATA_WIDTH-1:0]          noc_nou_data;               
wire    [0:0]                              nou_noc_rsp_ready;          
wire    [`NOU_TID_WIDTH-1:0]               nou_noc_rsp_tid;            
wire    [0:0]                              noc_nou_data_ready;         
wire    [`NOU_NOC_RSP_WIDTH-1:0]           noc_nou_rsp;                
wire    [`NOU_TID_WIDTH-1:0]               noc_nou_data_tid;           
wire    [`NOU_TID_WIDTH-1:0]               noc_nou_rsp_tid;            
wire    [0:0]                              noc_nou_rsp_valid;          
wire    [0:0]                              noc_nou_data_valid;         
wire    [`NOU_TID_WIDTH-1:0]               nou_noc_data_tid;           
wire    [0:0]                              nou_noc_data_ready;         
wire    [`NOU_NOC_RSP_WIDTH-1:0]           nou_noc_rsp;                
wire    [0:0]                              noc_nou_rsp_ready;          
wire    [`NOU_NOC_DATA_WIDTH-1:0]          nou_noc_data;               
wire    [0:0]                              nou_noc_data_valid;         
wire    [0:0]                              nou_noc_rsp_valid;          
wire    [`NOU_TYPE_WIDTH-1:0]              noc_nou_data_type;          
wire    [1:0]                              noc_nou_rsp_type;           
wire    [`NOU_TYPE_WIDTH-1:0]              nou_noc_data_type;          
wire    [1:0]                              nou_m_axi_bresp;            
wire    [0:0]                              nou_m_axi_wready;           
wire    [1:0]                              nou_m_axi_awburst;          
wire    [`NOU_AXI_DATA_WIDTH-1:0]          nou_m_axi_rdata;            
wire    [0:0]                              nou_m_axi_awlock;           
wire    [2:0]                              nou_m_axi_arsize;           
wire    [3:0]                              nou_m_axi_arqos;            
wire    [`NOU_AXI_ID_WIDTH-1:0]            nou_m_axi_awid;             
wire    [3:0]                              nou_m_axi_awqos;            
wire    [`NOU_AXI_ADDR_WIDTH-1:0]          nou_m_axi_awaddr;           
wire    [2:0]                              nou_m_axi_arprot;           
wire    [`NOU_AXI_ID_WIDTH-1:0]            nou_m_axi_bid;              
wire    [0:0]                              nou_m_axi_bready;           
wire    [`NOU_AXI_ID_WIDTH-1:0]            nou_m_axi_rid;              
wire    [`NOU_AXI_DATA_WIDTH-1:0]          nou_m_axi_wdata;            
wire    [0:0]                              nou_m_axi_rready;           
wire    [0:0]                              nou_m_axi_wvalid;           
wire    [0:0]                              nou_m_axi_arvalid;          
wire    [7:0]                              nou_m_axi_awlen;            
wire    [2:0]                              nou_m_axi_awprot;           
wire    [2:0]                              nou_m_axi_awsize;           
wire    [0:0]                              nou_m_axi_awready;          
wire    [0:0]                              nou_m_axi_wlast;            
wire    [(`NOU_AXI_DATA_WIDTH/8)-1:0]      nou_m_axi_wstrb;            
wire    [7:0]                              nou_m_axi_arlen;            
wire    [0:0]                              nou_m_axi_arlock;           
wire    [1:0]                              nou_m_axi_arburst;          
wire    [0:0]                              nou_m_axi_rvalid;           
wire    [0:0]                              nou_m_axi_arready;          
wire    [`NOU_AXI_ADDR_WIDTH-1:0]          nou_m_axi_araddr;           
wire    [0:0]                              nou_m_axi_rlast;            
wire    [`NOU_AXI_ID_WIDTH-1:0]            nou_m_axi_arid;             
wire    [0:0]                              nou_m_axi_bvalid;           
wire    [3:0]                              nou_m_axi_awcache;          
wire    [0:0]                              nou_m_axi_awvalid;          
wire    [3:0]                              nou_m_axi_arcache;          
wire    [1:0]                              nou_m_axi_rresp;            
wire    [0:0]                              s_1_axi_bvalid;             
wire    [7:0]                              s_0_axi_arlen;              
wire    [1:0]                              s_1_axi_rresp;              
wire    [0:0]                              s_1_axi_awready;            
wire    [3:0]                              s_2_axi_awcache;            
wire    [0:0]                              s_2_axi_wlast;              
wire    [0:0]                              s_1_axi_rready;             
wire    [0:0]                              s_1_axi_awvalid;            
wire    [0:0]                              s_2_axi_awready;            
wire    [3:0]                              s_1_axi_arcache;            
wire    [8-1:0]                            s_0_axi_awid;               
wire    [0:0]                              s_3_axi_bvalid;             
wire    [0:0]                              s_1_axi_bready;             
wire    [7:0]                              s_3_axi_awlen;              
wire    [2:0]                              s_0_axi_awsize;             
wire    [3:0]                              s_3_axi_awcache;            
wire    [1024-1:0]                         s_2_axi_rdata;              
wire    [8-1:0]                            s_3_axi_arid;               
wire    [1:0]                              s_2_axi_awburst;            
wire    [0:0]                              s_0_axi_awready;            
wire    [3:0]                              s_1_axi_awqos;              
wire    [2:0]                              s_3_axi_awprot;             
wire    [7:0]                              s_0_axi_awlen;              
wire    [1024-1:0]                         s_2_axi_wdata;              
wire    [0:0]                              s_0_axi_rready;             
wire    [0:0]                              s_0_axi_bready;             
wire    [0:0]                              s_2_axi_bready;             
wire    [0:0]                              s_1_axi_arvalid;            
wire    [8-1:0]                            s_0_axi_bid;                
wire    [0:0]                              s_2_axi_awvalid;            
wire    [3:0]                              s_3_axi_arqos;              
wire    [1:0]                              s_2_axi_bresp;              
wire    [8-1:0]                            s_0_axi_rid;                
wire    [0:0]                              s_2_axi_bvalid;             
wire    [1:0]                              s_3_axi_awburst;            
wire    [0:0]                              s_3_axi_wlast;              
wire    [3:0]                              s_2_axi_awqos;              
wire    [20-1:0]                           s_3_axi_awaddr;             
wire    [1:0]                              s_3_axi_bresp;              
wire    [2:0]                              s_3_axi_awsize;             
wire    [0:0]                              s_2_axi_arvalid;            
wire    [0:0]                              s_0_axi_arready;            
wire    [8-1:0]                            s_1_axi_arid;               
wire    [1:0]                              s_0_axi_rresp;              
wire    [0:0]                              s_1_axi_arlock;             
wire    [8-1:0]                            s_3_axi_rid;                
wire    [8-1:0]                            s_3_axi_awid;               
wire    [0:0]                              s_0_axi_bvalid;             
wire    [0:0]                              s_1_axi_arready;            
wire    [0:0]                              s_3_axi_bready;             
wire    [2:0]                              s_2_axi_arsize;             
wire    [1024-1:0]                         s_1_axi_rdata;              
wire    [2:0]                              s_0_axi_arsize;             
wire    [0:0]                              s_3_axi_wready;             
wire    [20-1:0]                           s_0_axi_araddr;             
wire    [0:0]                              s_0_axi_arvalid;            
wire    [8-1:0]                            s_1_axi_rid;                
wire    [0:0]                              s_0_axi_rlast;              
wire    [2:0]                              s_1_axi_awprot;             
wire    [3:0]                              s_0_axi_arqos;              
wire    [3:0]                              s_3_axi_awqos;              
wire    [1:0]                              s_0_axi_bresp;              
wire    [7:0]                              s_2_axi_awlen;              
wire    [8-1:0]                            s_2_axi_bid;                
wire    [2:0]                              s_2_axi_awprot;             
wire    [0:0]                              s_3_axi_wvalid;             
wire    [2:0]                              s_1_axi_arsize;             
wire    [2:0]                              s_2_axi_arprot;             
wire    [1024-1:0]                         s_3_axi_wdata;              
wire    [1024-1:0]                         s_1_axi_wdata;              
wire    [0:0]                              s_1_axi_rlast;              
wire    [1024-1:0]                         s_3_axi_rdata;              
wire    [1:0]                              s_1_axi_arburst;            
wire    [0:0]                              s_0_axi_awvalid;            
wire    [3:0]                              s_0_axi_awcache;            
wire    [0:0]                              s_1_axi_wready;             
wire    [0:0]                              s_2_axi_rvalid;             
wire    [1:0]                              s_1_axi_bresp;              
wire    [0:0]                              s_2_axi_rlast;              
wire    [1:0]                              s_2_axi_rresp;              
wire    [3:0]                              s_2_axi_arcache;            
wire    [0:0]                              s_2_axi_wready;             
wire    [0:0]                              s_3_axi_arlock;             
wire    [0:0]                              s_0_axi_rvalid;             
wire    [0:0]                              s_1_axi_wvalid;             
wire    [3:0]                              s_1_axi_arqos;              
wire    [2:0]                              s_0_axi_arprot;             
wire    [3:0]                              s_0_axi_awqos;              
wire    [(1024/8)-1:0]                     s_0_axi_wstrb;              
wire    [3:0]                              s_0_axi_arcache;            
wire    [0:0]                              s_3_axi_arready;            
wire    [0:0]                              s_3_axi_rvalid;             
wire    [0:0]                              s_1_axi_awlock;             
wire    [1:0]                              s_1_axi_awburst;            
wire    [(1024/8)-1:0]                     s_3_axi_wstrb;              
wire    [8-1:0]                            s_1_axi_awid;               
wire    [3:0]                              s_3_axi_arcache;            
wire    [8-1:0]                            s_3_axi_bid;                
wire    [1024-1:0]                         s_0_axi_rdata;              
wire    [0:0]                              s_3_axi_awready;            
wire    [20-1:0]                           s_1_axi_araddr;             
wire    [0:0]                              s_3_axi_awvalid;            
wire    [0:0]                              s_2_axi_wvalid;             
wire    [1024-1:0]                         s_0_axi_wdata;              
wire    [20-1:0]                           s_1_axi_awaddr;             
wire    [1:0]                              s_2_axi_arburst;            
wire    [0:0]                              s_2_axi_arready;            
wire    [(1024/8)-1:0]                     s_1_axi_wstrb;              
wire    [2:0]                              s_3_axi_arprot;             
wire    [7:0]                              s_2_axi_arlen;              
wire    [0:0]                              s_3_axi_awlock;             
wire    [0:0]                              s_0_axi_wvalid;             
wire    [8-1:0]                            s_2_axi_awid;               
wire    [8-1:0]                            s_2_axi_rid;                
wire    [8-1:0]                            s_2_axi_arid;               
wire    [0:0]                              s_2_axi_awlock;             
wire    [1:0]                              s_0_axi_awburst;            
wire    [2:0]                              s_2_axi_awsize;             
wire    [0:0]                              s_3_axi_arvalid;            
wire    [0:0]                              s_0_axi_wlast;              
wire    [3:0]                              s_1_axi_awcache;            
wire    [0:0]                              s_3_axi_rready;             
wire    [2:0]                              s_1_axi_arprot;             
wire    [8-1:0]                            s_1_axi_bid;                
wire    [2:0]                              s_1_axi_awsize;             
wire    [1:0]                              s_3_axi_arburst;            
wire    [0:0]                              s_3_axi_rlast;              
wire    [7:0]                              s_1_axi_arlen;              
wire    [20-1:0]                           s_0_axi_awaddr;             
wire    [(1024/8)-1:0]                     s_2_axi_wstrb;              
wire    [0:0]                              s_0_axi_wready;             
wire    [0:0]                              s_1_axi_rvalid;             
wire    [0:0]                              s_2_axi_arlock;             
wire    [20-1:0]                           s_2_axi_awaddr;             
wire    [0:0]                              s_0_axi_awlock;             
wire    [0:0]                              s_2_axi_rready;             
wire    [20-1:0]                           s_3_axi_araddr;             
wire    [3:0]                              s_2_axi_arqos;              
wire    [7:0]                              s_3_axi_arlen;              
wire    [1:0]                              s_0_axi_arburst;            
wire    [8-1:0]                            s_0_axi_arid;               
wire    [2:0]                              s_0_axi_awprot;             
wire    [7:0]                              s_1_axi_awlen;              
wire    [0:0]                              s_0_axi_arlock;             
wire    [0:0]                              s_1_axi_wlast;              
wire    [1:0]                              s_3_axi_rresp;              
wire    [2:0]                              s_3_axi_arsize;             
wire    [20-1:0]                           s_2_axi_araddr;             
wire    [0:0]                              csr_axi_awlock;             
wire    [0:0]                              csr_axi_wvalid;             
wire    [1:0]                              csr_axi_bresp;              
wire    [1:0]                              csr_axi_arburst;            
wire    [0:0]                              csr_axi_wready;             
wire    [0:0]                              csr_axi_bready;             
wire    [8-1:0]                            csr_axi_awid;               
wire    [32-1:0]                           csr_axi_rdata;              
wire    [0:0]                              csr_axi_arready;            
wire    [2:0]                              csr_axi_arsize;             
wire    [1:0]                              csr_axi_awburst;            
wire    [3:0]                              csr_axi_arqos;              
wire    [12-1:0]                           csr_axi_awaddr;             
wire    [3:0]                              csr_axi_awcache;            
wire    [12-1:0]                           csr_axi_araddr;             
wire    [7:0]                              csr_axi_arlen;              
wire    [0:0]                              csr_axi_arlock;             
wire    [0:0]                              csr_axi_awvalid;            
wire    [(32/8)-1:0]                       csr_axi_wstrb;              
wire    [8-1:0]                            csr_axi_arid;               
wire    [3:0]                              csr_axi_arcache;            
wire    [0:0]                              csr_axi_rlast;              
wire    [0:0]                              csr_axi_rvalid;             
wire    [0:0]                              csr_axi_wlast;              
wire    [8-1:0]                            csr_axi_rid;                
wire    [3:0]                              csr_axi_awqos;              
wire    [0:0]                              csr_axi_bvalid;             
wire    [0:0]                              csr_axi_awready;            
wire    [0:0]                              csr_axi_rready;             
wire    [7:0]                              csr_axi_awlen;              
wire    [32-1:0]                           csr_axi_wdata;              
wire    [2:0]                              csr_axi_arprot;             
wire    [1:0]                              csr_axi_rresp;              
wire    [2:0]                              csr_axi_awsize;             
wire    [8-1:0]                            csr_axi_bid;                
wire    [0:0]                              csr_axi_arvalid;            
wire    [2:0]                              csr_axi_awprot;             


// Inst RV Cluster
// &Instance("rv_cluster_top"); @20
rv_cluster_top x_rv_cluster_top (
	.regular_0_clk               (regular_0_clk               ),
	.regular_0_rstn              (regular_0_rstn              ),
	.regular_1_clk               (regular_1_clk               ),
	.regular_1_rstn              (regular_1_rstn              ),
	.dispatcher_xocc_2_cmd_buffer(dispatcher_xocc_2_cmd_buffer),
	.dispatcher_xocc_2_rsp_buffer(dispatcher_xocc_2_rsp_buffer),
	.dispatcher_xocc_2_cmd_empty (dispatcher_xocc_2_cmd_empty ),
	.dispatcher_xocc_2_rsp_full  (dispatcher_xocc_2_rsp_full  ),
	.dispatcher_xocc_2_cmd_rd_en (dispatcher_xocc_2_cmd_rd_en ),
	.dispatcher_xocc_2_rsp_wr_en (dispatcher_xocc_2_rsp_wr_en ),
	.dispatcher_xocc_2_clk       (nou_clk                     ),
	.dispatcher_xocc_2_rst       (nou_rstn                    ),
	.dispatcher_xocc_3_cmd_buffer(dispatcher_xocc_3_cmd_buffer),
	.dispatcher_xocc_3_rsp_buffer(dispatcher_xocc_3_rsp_buffer),
	.dispatcher_xocc_3_cmd_empty (dispatcher_xocc_3_cmd_empty ),
	.dispatcher_xocc_3_rsp_full  (dispatcher_xocc_3_rsp_full  ),
	.dispatcher_xocc_3_cmd_rd_en (dispatcher_xocc_3_cmd_rd_en ),
	.dispatcher_xocc_3_rsp_wr_en (dispatcher_xocc_3_rsp_wr_en ),
	.dispatcher_xocc_3_clk       (dsa_2_clk                   ),
	.dispatcher_xocc_3_rst       (dsa_2_rstn                  ),
	.dispatcher_m_axi_awid       (dispatcher_m_axi_awid       ),
	.dispatcher_m_axi_awlen      (dispatcher_m_axi_awlen      ),
	.dispatcher_m_axi_awsize     (dispatcher_m_axi_awsize     ),
	.dispatcher_m_axi_awburst    (dispatcher_m_axi_awburst    ),
	.dispatcher_m_axi_awcache    (dispatcher_m_axi_awcache    ),
	.dispatcher_m_axi_awaddr     (dispatcher_m_axi_awaddr     ),
	.dispatcher_m_axi_awprot     (dispatcher_m_axi_awprot     ),
	.dispatcher_m_axi_awqos      (dispatcher_m_axi_awqos      ),
	.dispatcher_m_axi_awvalid    (dispatcher_m_axi_awvalid    ),
	.dispatcher_m_axi_awready    (dispatcher_m_axi_awready    ),
	.dispatcher_m_axi_awlock     (dispatcher_m_axi_awlock     ),
	.dispatcher_m_axi_wdata      (dispatcher_m_axi_wdata      ),
	.dispatcher_m_axi_wstrb      (dispatcher_m_axi_wstrb      ),
	.dispatcher_m_axi_wlast      (dispatcher_m_axi_wlast      ),
	.dispatcher_m_axi_wvalid     (dispatcher_m_axi_wvalid     ),
	.dispatcher_m_axi_wready     (dispatcher_m_axi_wready     ),
	.dispatcher_m_axi_bid        (dispatcher_m_axi_bid        ),
	.dispatcher_m_axi_bresp      (dispatcher_m_axi_bresp      ),
	.dispatcher_m_axi_bvalid     (dispatcher_m_axi_bvalid     ),
	.dispatcher_m_axi_bready     (dispatcher_m_axi_bready     ),
	.dispatcher_m_axi_arid       (dispatcher_m_axi_arid       ),
	.dispatcher_m_axi_arlen      (dispatcher_m_axi_arlen      ),
	.dispatcher_m_axi_arsize     (dispatcher_m_axi_arsize     ),
	.dispatcher_m_axi_arburst    (dispatcher_m_axi_arburst    ),
	.dispatcher_m_axi_arprot     (dispatcher_m_axi_arprot     ),
	.dispatcher_m_axi_arqos      (dispatcher_m_axi_arqos      ),
	.dispatcher_m_axi_arcache    (dispatcher_m_axi_arcache    ),
	.dispatcher_m_axi_arvalid    (dispatcher_m_axi_arvalid    ),
	.dispatcher_m_axi_araddr     (dispatcher_m_axi_araddr     ),
	.dispatcher_m_axi_arlock     (dispatcher_m_axi_arlock     ),
	.dispatcher_m_axi_arready    (dispatcher_m_axi_arready    ),
	.dispatcher_m_axi_rid        (dispatcher_m_axi_rid        ),
	.dispatcher_m_axi_rdata      (dispatcher_m_axi_rdata      ),
	.dispatcher_m_axi_rresp      (dispatcher_m_axi_rresp      ),
	.dispatcher_m_axi_rvalid     (dispatcher_m_axi_rvalid     ),
	.dispatcher_m_axi_rlast      (dispatcher_m_axi_rlast      ),
	.dispatcher_m_axi_rready     (dispatcher_m_axi_rready     ),
	.dispatcher_retire_pc        (dispatcher_pc               ),
	.dispatcher_rst_addr         (dispatcher_rst_addr         ),
	.dispatcher_clk              (dispatcher_clk              ),
	.dispatcher_rstn             (dispatcher_rstn             ),
	.regular_0_xocc_4_cmd_buffer (regular_0_xocc_4_cmd_buffer ),
	.regular_0_xocc_4_rsp_buffer (regular_0_xocc_4_rsp_buffer ),
	.regular_0_xocc_4_cmd_empty  (regular_0_xocc_4_cmd_empty  ),
	.regular_0_xocc_4_rsp_full   (regular_0_xocc_4_rsp_full   ),
	.regular_0_xocc_4_cmd_rd_en  (regular_0_xocc_4_cmd_rd_en  ),
	.regular_0_xocc_4_rsp_wr_en  (regular_0_xocc_4_rsp_wr_en  ),
	.regular_0_xocc_4_clk        (dsa_0_clk                   ),
	.regular_0_xocc_4_rst        (dsa_0_rstn                  ),
	.regular_0_m_axi_awid        (regular_0_m_axi_awid        ),
	.regular_0_m_axi_awlen       (regular_0_m_axi_awlen       ),
	.regular_0_m_axi_awsize      (regular_0_m_axi_awsize      ),
	.regular_0_m_axi_awburst     (regular_0_m_axi_awburst     ),
	.regular_0_m_axi_awcache     (regular_0_m_axi_awcache     ),
	.regular_0_m_axi_awaddr      (regular_0_m_axi_awaddr      ),
	.regular_0_m_axi_awprot      (regular_0_m_axi_awprot      ),
	.regular_0_m_axi_awqos       (regular_0_m_axi_awqos       ),
	.regular_0_m_axi_awvalid     (regular_0_m_axi_awvalid     ),
	.regular_0_m_axi_awready     (regular_0_m_axi_awready     ),
	.regular_0_m_axi_awlock      (regular_0_m_axi_awlock      ),
	.regular_0_m_axi_wdata       (regular_0_m_axi_wdata       ),
	.regular_0_m_axi_wstrb       (regular_0_m_axi_wstrb       ),
	.regular_0_m_axi_wlast       (regular_0_m_axi_wlast       ),
	.regular_0_m_axi_wvalid      (regular_0_m_axi_wvalid      ),
	.regular_0_m_axi_wready      (regular_0_m_axi_wready      ),
	.regular_0_m_axi_bid         (regular_0_m_axi_bid         ),
	.regular_0_m_axi_bresp       (regular_0_m_axi_bresp       ),
	.regular_0_m_axi_bvalid      (regular_0_m_axi_bvalid      ),
	.regular_0_m_axi_bready      (regular_0_m_axi_bready      ),
	.regular_0_m_axi_arid        (regular_0_m_axi_arid        ),
	.regular_0_m_axi_arlen       (regular_0_m_axi_arlen       ),
	.regular_0_m_axi_arsize      (regular_0_m_axi_arsize      ),
	.regular_0_m_axi_arburst     (regular_0_m_axi_arburst     ),
	.regular_0_m_axi_arprot      (regular_0_m_axi_arprot      ),
	.regular_0_m_axi_arqos       (regular_0_m_axi_arqos       ),
	.regular_0_m_axi_arcache     (regular_0_m_axi_arcache     ),
	.regular_0_m_axi_arvalid     (regular_0_m_axi_arvalid     ),
	.regular_0_m_axi_araddr      (regular_0_m_axi_araddr      ),
	.regular_0_m_axi_arlock      (regular_0_m_axi_arlock      ),
	.regular_0_m_axi_arready     (regular_0_m_axi_arready     ),
	.regular_0_m_axi_rid         (regular_0_m_axi_rid         ),
	.regular_0_m_axi_rdata       (regular_0_m_axi_rdata       ),
	.regular_0_m_axi_rresp       (regular_0_m_axi_rresp       ),
	.regular_0_m_axi_rvalid      (regular_0_m_axi_rvalid      ),
	.regular_0_m_axi_rlast       (regular_0_m_axi_rlast       ),
	.regular_0_m_axi_rready      (regular_0_m_axi_rready      ),
	.regular_0_retire_pc         (regular_0_pc                ),
	.regular_0_rst_addr          (regular_0_rst_addr          ),
	.regular_1_xocc_5_cmd_buffer (regular_1_xocc_5_cmd_buffer ),
	.regular_1_xocc_5_rsp_buffer (regular_1_xocc_5_rsp_buffer ),
	.regular_1_xocc_5_cmd_empty  (regular_1_xocc_5_cmd_empty  ),
	.regular_1_xocc_5_rsp_full   (regular_1_xocc_5_rsp_full   ),
	.regular_1_xocc_5_cmd_rd_en  (regular_1_xocc_5_cmd_rd_en  ),
	.regular_1_xocc_5_rsp_wr_en  (regular_1_xocc_5_rsp_wr_en  ),
	.regular_1_xocc_5_clk        (dsa_1_clk                   ),
	.regular_1_xocc_5_rst        (dsa_1_rstn                  ),
	.regular_1_m_axi_awid        (regular_1_m_axi_awid        ),
	.regular_1_m_axi_awlen       (regular_1_m_axi_awlen       ),
	.regular_1_m_axi_awsize      (regular_1_m_axi_awsize      ),
	.regular_1_m_axi_awburst     (regular_1_m_axi_awburst     ),
	.regular_1_m_axi_awcache     (regular_1_m_axi_awcache     ),
	.regular_1_m_axi_awaddr      (regular_1_m_axi_awaddr      ),
	.regular_1_m_axi_awprot      (regular_1_m_axi_awprot      ),
	.regular_1_m_axi_awqos       (regular_1_m_axi_awqos       ),
	.regular_1_m_axi_awvalid     (regular_1_m_axi_awvalid     ),
	.regular_1_m_axi_awready     (regular_1_m_axi_awready     ),
	.regular_1_m_axi_awlock      (regular_1_m_axi_awlock      ),
	.regular_1_m_axi_wdata       (regular_1_m_axi_wdata       ),
	.regular_1_m_axi_wstrb       (regular_1_m_axi_wstrb       ),
	.regular_1_m_axi_wlast       (regular_1_m_axi_wlast       ),
	.regular_1_m_axi_wvalid      (regular_1_m_axi_wvalid      ),
	.regular_1_m_axi_wready      (regular_1_m_axi_wready      ),
	.regular_1_m_axi_bid         (regular_1_m_axi_bid         ),
	.regular_1_m_axi_bresp       (regular_1_m_axi_bresp       ),
	.regular_1_m_axi_bvalid      (regular_1_m_axi_bvalid      ),
	.regular_1_m_axi_bready      (regular_1_m_axi_bready      ),
	.regular_1_m_axi_arid        (regular_1_m_axi_arid        ),
	.regular_1_m_axi_arlen       (regular_1_m_axi_arlen       ),
	.regular_1_m_axi_arsize      (regular_1_m_axi_arsize      ),
	.regular_1_m_axi_arburst     (regular_1_m_axi_arburst     ),
	.regular_1_m_axi_arprot      (regular_1_m_axi_arprot      ),
	.regular_1_m_axi_arqos       (regular_1_m_axi_arqos       ),
	.regular_1_m_axi_arcache     (regular_1_m_axi_arcache     ),
	.regular_1_m_axi_arvalid     (regular_1_m_axi_arvalid     ),
	.regular_1_m_axi_araddr      (regular_1_m_axi_araddr      ),
	.regular_1_m_axi_arlock      (regular_1_m_axi_arlock      ),
	.regular_1_m_axi_arready     (regular_1_m_axi_arready     ),
	.regular_1_m_axi_rid         (regular_1_m_axi_rid         ),
	.regular_1_m_axi_rdata       (regular_1_m_axi_rdata       ),
	.regular_1_m_axi_rresp       (regular_1_m_axi_rresp       ),
	.regular_1_m_axi_rvalid      (regular_1_m_axi_rvalid      ),
	.regular_1_m_axi_rlast       (regular_1_m_axi_rlast       ),
	.regular_1_m_axi_rready      (regular_1_m_axi_rready      ),
	.regular_1_retire_pc         (regular_1_pc                ),
	.regular_1_rst_addr          (regular_1_rst_addr          )
);
// @21 &ConnRule(r'_retire_pc', r'_pc')
// @22 &Connect(
// @23     .dispatcher_xocc_2_clk (nou_clk),
// @24     .dispatcher_xocc_2_rst (nou_rstn),
// @25     .dispatcher_xocc_3_clk (dsa_2_clk),
// @26     .dispatcher_xocc_3_rst (dsa_2_rstn),
// @27     .regular_0_xocc_4_clk (dsa_0_clk),
// @28     .regular_0_xocc_4_rst (dsa_0_rstn),
// @29     .regular_1_xocc_5_clk (dsa_1_clk),
// @30     .regular_1_xocc_5_rst (dsa_1_rstn),
// @31 );

// Inst dsa_0 
// &Instance("dummy_dsa_top_wrapper", "x_dsa_0_top_wrapper"); @34
dummy_dsa_top_wrapper x_dsa_0_top_wrapper (
	.rv_xocc_cmd_buffer(regular_0_xocc_4_cmd_buffer),
	.rv_xocc_cmd_empty (regular_0_xocc_4_cmd_empty ),
	.rv_xocc_rsp_full  (regular_0_xocc_4_rsp_full  ),
	.rv_xocc_cmd_rd_en (regular_0_xocc_4_cmd_rd_en ),
	.rv_xocc_rsp_wr_en (regular_0_xocc_4_rsp_wr_en ),
	.rv_xocc_rsp_buffer(regular_0_xocc_4_rsp_buffer),
	.axi_aclk          (dsa_0_m_dsa_0_clk          ),
	.axi_aresetn       (dsa_0_m_dsa_0_rstn         ),
	.axi_awid          (dsa_0_m_axi_awid           ),
	.axi_awaddr        (dsa_0_m_axi_awaddr         ),
	.axi_awlen         (dsa_0_m_axi_awlen          ),
	.axi_awsize        (dsa_0_m_axi_awsize         ),
	.axi_awburst       (dsa_0_m_axi_awburst        ),
	.axi_awlock        (dsa_0_m_axi_awlock         ),
	.axi_awcache       (dsa_0_m_axi_awcache        ),
	.axi_awprot        (dsa_0_m_axi_awprot         ),
	.axi_awqos         (dsa_0_m_axi_awqos          ),
	.axi_awvalid       (dsa_0_m_axi_awvalid        ),
	.axi_awready       (dsa_0_m_axi_awready        ),
	.axi_wdata         (dsa_0_m_axi_wdata          ),
	.axi_wstrb         (dsa_0_m_axi_wstrb          ),
	.axi_wlast         (dsa_0_m_axi_wlast          ),
	.axi_wvalid        (dsa_0_m_axi_wvalid         ),
	.axi_wready        (dsa_0_m_axi_wready         ),
	.axi_bid           (dsa_0_m_axi_bid            ),
	.axi_bresp         (dsa_0_m_axi_bresp          ),
	.axi_bvalid        (dsa_0_m_axi_bvalid         ),
	.axi_bready        (dsa_0_m_axi_bready         ),
	.axi_arid          (dsa_0_m_axi_arid           ),
	.axi_araddr        (dsa_0_m_axi_araddr         ),
	.axi_arlen         (dsa_0_m_axi_arlen          ),
	.axi_arsize        (dsa_0_m_axi_arsize         ),
	.axi_arburst       (dsa_0_m_axi_arburst        ),
	.axi_arlock        (dsa_0_m_axi_arlock         ),
	.axi_arcache       (dsa_0_m_axi_arcache        ),
	.axi_arprot        (dsa_0_m_axi_arprot         ),
	.axi_arqos         (dsa_0_m_axi_arqos          ),
	.axi_arvalid       (dsa_0_m_axi_arvalid        ),
	.axi_arready       (dsa_0_m_axi_arready        ),
	.axi_rid           (dsa_0_m_axi_rid            ),
	.axi_rdata         (dsa_0_m_axi_rdata          ),
	.axi_rresp         (dsa_0_m_axi_rresp          ),
	.axi_rlast         (dsa_0_m_axi_rlast          ),
	.axi_rvalid        (dsa_0_m_axi_rvalid         ),
	.axi_rready        (dsa_0_m_axi_rready         )
);
// @35 &ConnRule(r'rv_xocc', r'regular_0_xocc_4');
// @36 &ConnRule(r'axi', r'dsa_0_m_axi');
// @37 &ConnRule(r'axi_aclk', r'dsa_0_clk');
// @38 &ConnRule(r'axi_aresetn', r'dsa_0_rstn');

// Inst dsa_1 
// &Instance("dummy_dsa_top_wrapper", "x_dsa_1_top_wrapper"); @41
dummy_dsa_top_wrapper x_dsa_1_top_wrapper (
	.rv_xocc_cmd_buffer(regular_1_xocc_5_cmd_buffer),
	.rv_xocc_cmd_empty (regular_1_xocc_5_cmd_empty ),
	.rv_xocc_rsp_full  (regular_1_xocc_5_rsp_full  ),
	.rv_xocc_cmd_rd_en (regular_1_xocc_5_cmd_rd_en ),
	.rv_xocc_rsp_wr_en (regular_1_xocc_5_rsp_wr_en ),
	.rv_xocc_rsp_buffer(regular_1_xocc_5_rsp_buffer),
	.axi_aclk          (dsa_1_m_dsa_1_clk          ),
	.axi_aresetn       (dsa_1_m_dsa_1_rstn         ),
	.axi_awid          (dsa_1_m_axi_awid           ),
	.axi_awaddr        (dsa_1_m_axi_awaddr         ),
	.axi_awlen         (dsa_1_m_axi_awlen          ),
	.axi_awsize        (dsa_1_m_axi_awsize         ),
	.axi_awburst       (dsa_1_m_axi_awburst        ),
	.axi_awlock        (dsa_1_m_axi_awlock         ),
	.axi_awcache       (dsa_1_m_axi_awcache        ),
	.axi_awprot        (dsa_1_m_axi_awprot         ),
	.axi_awqos         (dsa_1_m_axi_awqos          ),
	.axi_awvalid       (dsa_1_m_axi_awvalid        ),
	.axi_awready       (dsa_1_m_axi_awready        ),
	.axi_wdata         (dsa_1_m_axi_wdata          ),
	.axi_wstrb         (dsa_1_m_axi_wstrb          ),
	.axi_wlast         (dsa_1_m_axi_wlast          ),
	.axi_wvalid        (dsa_1_m_axi_wvalid         ),
	.axi_wready        (dsa_1_m_axi_wready         ),
	.axi_bid           (dsa_1_m_axi_bid            ),
	.axi_bresp         (dsa_1_m_axi_bresp          ),
	.axi_bvalid        (dsa_1_m_axi_bvalid         ),
	.axi_bready        (dsa_1_m_axi_bready         ),
	.axi_arid          (dsa_1_m_axi_arid           ),
	.axi_araddr        (dsa_1_m_axi_araddr         ),
	.axi_arlen         (dsa_1_m_axi_arlen          ),
	.axi_arsize        (dsa_1_m_axi_arsize         ),
	.axi_arburst       (dsa_1_m_axi_arburst        ),
	.axi_arlock        (dsa_1_m_axi_arlock         ),
	.axi_arcache       (dsa_1_m_axi_arcache        ),
	.axi_arprot        (dsa_1_m_axi_arprot         ),
	.axi_arqos         (dsa_1_m_axi_arqos          ),
	.axi_arvalid       (dsa_1_m_axi_arvalid        ),
	.axi_arready       (dsa_1_m_axi_arready        ),
	.axi_rid           (dsa_1_m_axi_rid            ),
	.axi_rdata         (dsa_1_m_axi_rdata          ),
	.axi_rresp         (dsa_1_m_axi_rresp          ),
	.axi_rlast         (dsa_1_m_axi_rlast          ),
	.axi_rvalid        (dsa_1_m_axi_rvalid         ),
	.axi_rready        (dsa_1_m_axi_rready         )
);
// @42 &ConnRule(r'rv_xocc', r'regular_1_xocc_5');
// @43 &ConnRule(r'axi', r'dsa_1_m_axi');
// @44 &ConnRule(r'axi_aclk', r'dsa_1_clk');
// @45 &ConnRule(r'axi_aresetn', r'dsa_1_rstn');

// Inst dsa_2 
// &Instance("dummy_dsa_top_wrapper", "x_dsa_2_top_wrapper"); @48
dummy_dsa_top_wrapper x_dsa_2_top_wrapper (
	.rv_xocc_cmd_buffer(dispatcher_xocc_3_cmd_buffer),
	.rv_xocc_cmd_empty (dispatcher_xocc_3_cmd_empty ),
	.rv_xocc_rsp_full  (dispatcher_xocc_3_rsp_full  ),
	.rv_xocc_cmd_rd_en (dispatcher_xocc_3_cmd_rd_en ),
	.rv_xocc_rsp_wr_en (dispatcher_xocc_3_rsp_wr_en ),
	.rv_xocc_rsp_buffer(dispatcher_xocc_3_rsp_buffer),
	.axi_aclk          (dsa_2_m_dsa_2_clk           ),
	.axi_aresetn       (dsa_2_m_dsa_2_rstn          ),
	.axi_awid          (dsa_2_m_axi_awid            ),
	.axi_awaddr        (dsa_2_m_axi_awaddr          ),
	.axi_awlen         (dsa_2_m_axi_awlen           ),
	.axi_awsize        (dsa_2_m_axi_awsize          ),
	.axi_awburst       (dsa_2_m_axi_awburst         ),
	.axi_awlock        (dsa_2_m_axi_awlock          ),
	.axi_awcache       (dsa_2_m_axi_awcache         ),
	.axi_awprot        (dsa_2_m_axi_awprot          ),
	.axi_awqos         (dsa_2_m_axi_awqos           ),
	.axi_awvalid       (dsa_2_m_axi_awvalid         ),
	.axi_awready       (dsa_2_m_axi_awready         ),
	.axi_wdata         (dsa_2_m_axi_wdata           ),
	.axi_wstrb         (dsa_2_m_axi_wstrb           ),
	.axi_wlast         (dsa_2_m_axi_wlast           ),
	.axi_wvalid        (dsa_2_m_axi_wvalid          ),
	.axi_wready        (dsa_2_m_axi_wready          ),
	.axi_bid           (dsa_2_m_axi_bid             ),
	.axi_bresp         (dsa_2_m_axi_bresp           ),
	.axi_bvalid        (dsa_2_m_axi_bvalid          ),
	.axi_bready        (dsa_2_m_axi_bready          ),
	.axi_arid          (dsa_2_m_axi_arid            ),
	.axi_araddr        (dsa_2_m_axi_araddr          ),
	.axi_arlen         (dsa_2_m_axi_arlen           ),
	.axi_arsize        (dsa_2_m_axi_arsize          ),
	.axi_arburst       (dsa_2_m_axi_arburst         ),
	.axi_arlock        (dsa_2_m_axi_arlock          ),
	.axi_arcache       (dsa_2_m_axi_arcache         ),
	.axi_arprot        (dsa_2_m_axi_arprot          ),
	.axi_arqos         (dsa_2_m_axi_arqos           ),
	.axi_arvalid       (dsa_2_m_axi_arvalid         ),
	.axi_arready       (dsa_2_m_axi_arready         ),
	.axi_rid           (dsa_2_m_axi_rid             ),
	.axi_rdata         (dsa_2_m_axi_rdata           ),
	.axi_rresp         (dsa_2_m_axi_rresp           ),
	.axi_rlast         (dsa_2_m_axi_rlast           ),
	.axi_rvalid        (dsa_2_m_axi_rvalid          ),
	.axi_rready        (dsa_2_m_axi_rready          )
);
// @49 &ConnRule(r'rv_xocc', r'dispatcher_xocc_3');
// @50 &ConnRule(r'axi', r'dsa_2_m_axi');
// @51 &ConnRule(r'axi_aclk', r'dsa_2_clk');
// @52 &ConnRule(r'axi_aresetn', r'dsa_2_rstn');

// Inst nou 
// &Instance("nou_top_wrapper", "x_nou_top_wrapper"); @55
nou_top_wrapper x_nou_top_wrapper (
	.nou_clk           (nou_clk                     ),
	.nou_rstn          (nou_rstn                    ),
	.rv_xocc_cmd_buffer(dispatcher_xocc_2_cmd_buffer),
	.rv_xocc_cmd_empty (dispatcher_xocc_2_cmd_empty ),
	.rv_xocc_rsp_full  (dispatcher_xocc_2_rsp_full  ),
	.rv_xocc_cmd_rd_en (dispatcher_xocc_2_cmd_rd_en ),
	.rv_xocc_rsp_wr_en (dispatcher_xocc_2_rsp_wr_en ),
	.rv_xocc_rsp_buffer(dispatcher_xocc_2_rsp_buffer),
	.nou_noc_data_valid(nou_noc_data_valid          ),
	.noc_nou_data_ready(noc_nou_data_ready          ),
	.nou_noc_data_tid  (nou_noc_data_tid            ),
	.nou_noc_data_type (nou_noc_data_type           ),
	.nou_noc_data      (nou_noc_data                ),
	.nou_noc_rsp_valid (nou_noc_rsp_valid           ),
	.noc_nou_rsp_ready (noc_nou_rsp_ready           ),
	.nou_noc_rsp_tid   (nou_noc_rsp_tid             ),
	.nou_noc_rsp_type  (nou_noc_rsp_type            ),
	.nou_noc_rsp       (nou_noc_rsp                 ),
	.noc_nou_data_valid(noc_nou_data_valid          ),
	.nou_noc_data_ready(nou_noc_data_ready          ),
	.noc_nou_data_tid  (noc_nou_data_tid            ),
	.noc_nou_data_type (noc_nou_data_type           ),
	.noc_nou_data      (noc_nou_data                ),
	.noc_nou_rsp_valid (noc_nou_rsp_valid           ),
	.nou_noc_rsp_ready (nou_noc_rsp_ready           ),
	.noc_nou_rsp_tid   (noc_nou_rsp_tid             ),
	.noc_nou_rsp_type  (noc_nou_rsp_type            ),
	.noc_nou_rsp       (noc_nou_rsp                 ),
	.axi_awid          (nou_m_axi_awid              ),
	.axi_awaddr        (nou_m_axi_awaddr            ),
	.axi_awlen         (nou_m_axi_awlen             ),
	.axi_awsize        (nou_m_axi_awsize            ),
	.axi_awburst       (nou_m_axi_awburst           ),
	.axi_awlock        (nou_m_axi_awlock            ),
	.axi_awcache       (nou_m_axi_awcache           ),
	.axi_awprot        (nou_m_axi_awprot            ),
	.axi_awqos         (nou_m_axi_awqos             ),
	.axi_awvalid       (nou_m_axi_awvalid           ),
	.axi_awready       (nou_m_axi_awready           ),
	.axi_wdata         (nou_m_axi_wdata             ),
	.axi_wstrb         (nou_m_axi_wstrb             ),
	.axi_wlast         (nou_m_axi_wlast             ),
	.axi_wvalid        (nou_m_axi_wvalid            ),
	.axi_wready        (nou_m_axi_wready            ),
	.axi_bid           (nou_m_axi_bid               ),
	.axi_bresp         (nou_m_axi_bresp             ),
	.axi_bvalid        (nou_m_axi_bvalid            ),
	.axi_bready        (nou_m_axi_bready            ),
	.axi_arid          (nou_m_axi_arid              ),
	.axi_araddr        (nou_m_axi_araddr            ),
	.axi_arlen         (nou_m_axi_arlen             ),
	.axi_arsize        (nou_m_axi_arsize            ),
	.axi_arburst       (nou_m_axi_arburst           ),
	.axi_arlock        (nou_m_axi_arlock            ),
	.axi_arcache       (nou_m_axi_arcache           ),
	.axi_arprot        (nou_m_axi_arprot            ),
	.axi_arqos         (nou_m_axi_arqos             ),
	.axi_arvalid       (nou_m_axi_arvalid           ),
	.axi_arready       (nou_m_axi_arready           ),
	.axi_rid           (nou_m_axi_rid               ),
	.axi_rdata         (nou_m_axi_rdata             ),
	.axi_rresp         (nou_m_axi_rresp             ),
	.axi_rlast         (nou_m_axi_rlast             ),
	.axi_rvalid        (nou_m_axi_rvalid            ),
	.axi_rready        (nou_m_axi_rready            )
);
// @56 &ConnRule(r'rv_xocc', r'dispatcher_xocc_2');
// @57 &ConnRule(r'axi', r'nou_m_axi');
// @58 &ConnRule(r'axi_aclk', r'nou_clk');
// @59 &ConnRule(r'axi_aresetn', r'nou_rstn');


// Mem SS
// &Instance("mem_sub_sys_top"); @63
mem_sub_sys_top x_mem_sub_sys_top (
	.mem_sub_sys_clk (mem_sub_sys_clk ),
	.s_0_axi_araddr  (s_0_axi_araddr  ),
	.s_0_axi_arburst (s_0_axi_arburst ),
	.s_0_axi_arcache (s_0_axi_arcache ),
	.mem_sub_sys_rstn(mem_sub_sys_rstn),
	.s_0_axi_arid    (s_0_axi_arid    ),
	.s_0_axi_arlen   (s_0_axi_arlen   ),
	.s_0_axi_arlock  (s_0_axi_arlock  ),
	.s_0_axi_arprot  (s_0_axi_arprot  ),
	.s_0_axi_arqos   (s_0_axi_arqos   ),
	.s_0_axi_awqos   (s_0_axi_awqos   ),
	.s_0_axi_arready (s_0_axi_arready ),
	.s_0_axi_arsize  (s_0_axi_arsize  ),
	.s_0_axi_arvalid (s_0_axi_arvalid ),
	.s_0_axi_awaddr  (s_0_axi_awaddr  ),
	.s_0_axi_awburst (s_0_axi_awburst ),
	.s_0_axi_awcache (s_0_axi_awcache ),
	.s_0_axi_awid    (s_0_axi_awid    ),
	.s_0_axi_awlen   (s_0_axi_awlen   ),
	.s_0_axi_awlock  (s_0_axi_awlock  ),
	.s_0_axi_awprot  (s_0_axi_awprot  ),
	.s_0_axi_awready (s_0_axi_awready ),
	.s_0_axi_awsize  (s_0_axi_awsize  ),
	.s_0_axi_awvalid (s_0_axi_awvalid ),
	.s_0_axi_bid     (s_0_axi_bid     ),
	.s_0_axi_bready  (s_0_axi_bready  ),
	.s_0_axi_bresp   (s_0_axi_bresp   ),
	.s_0_axi_bvalid  (s_0_axi_bvalid  ),
	.s_0_axi_rdata   (s_0_axi_rdata   ),
	.s_0_axi_rid     (s_0_axi_rid     ),
	.s_0_axi_rlast   (s_0_axi_rlast   ),
	.s_0_axi_rready  (s_0_axi_rready  ),
	.s_0_axi_rresp   (s_0_axi_rresp   ),
	.s_0_axi_rvalid  (s_0_axi_rvalid  ),
	.s_0_axi_wdata   (s_0_axi_wdata   ),
	.s_0_axi_wlast   (s_0_axi_wlast   ),
	.s_0_axi_wready  (s_0_axi_wready  ),
	.s_0_axi_wstrb   (s_0_axi_wstrb   ),
	.s_0_axi_wvalid  (s_0_axi_wvalid  ),
	.s_1_axi_araddr  (s_1_axi_araddr  ),
	.s_1_axi_arburst (s_1_axi_arburst ),
	.s_1_axi_arcache (s_1_axi_arcache ),
	.s_1_axi_arid    (s_1_axi_arid    ),
	.s_1_axi_arlen   (s_1_axi_arlen   ),
	.s_1_axi_arlock  (s_1_axi_arlock  ),
	.s_1_axi_arprot  (s_1_axi_arprot  ),
	.s_1_axi_arqos   (s_1_axi_arqos   ),
	.s_1_axi_awqos   (s_1_axi_awqos   ),
	.s_1_axi_arready (s_1_axi_arready ),
	.s_1_axi_arsize  (s_1_axi_arsize  ),
	.s_1_axi_arvalid (s_1_axi_arvalid ),
	.s_1_axi_awaddr  (s_1_axi_awaddr  ),
	.s_1_axi_awburst (s_1_axi_awburst ),
	.s_1_axi_awcache (s_1_axi_awcache ),
	.s_1_axi_awid    (s_1_axi_awid    ),
	.s_1_axi_awlen   (s_1_axi_awlen   ),
	.s_1_axi_awlock  (s_1_axi_awlock  ),
	.s_1_axi_awprot  (s_1_axi_awprot  ),
	.s_1_axi_awready (s_1_axi_awready ),
	.s_1_axi_awsize  (s_1_axi_awsize  ),
	.s_1_axi_awvalid (s_1_axi_awvalid ),
	.s_1_axi_bid     (s_1_axi_bid     ),
	.s_1_axi_bready  (s_1_axi_bready  ),
	.s_1_axi_bresp   (s_1_axi_bresp   ),
	.s_1_axi_bvalid  (s_1_axi_bvalid  ),
	.s_1_axi_rdata   (s_1_axi_rdata   ),
	.s_1_axi_rid     (s_1_axi_rid     ),
	.s_1_axi_rlast   (s_1_axi_rlast   ),
	.s_1_axi_rready  (s_1_axi_rready  ),
	.s_1_axi_rresp   (s_1_axi_rresp   ),
	.s_1_axi_rvalid  (s_1_axi_rvalid  ),
	.s_1_axi_wdata   (s_1_axi_wdata   ),
	.s_1_axi_wlast   (s_1_axi_wlast   ),
	.s_1_axi_wready  (s_1_axi_wready  ),
	.s_1_axi_wstrb   (s_1_axi_wstrb   ),
	.s_1_axi_wvalid  (s_1_axi_wvalid  ),
	.s_2_axi_araddr  (s_2_axi_araddr  ),
	.s_2_axi_arburst (s_2_axi_arburst ),
	.s_2_axi_arcache (s_2_axi_arcache ),
	.s_2_axi_arid    (s_2_axi_arid    ),
	.s_2_axi_arlen   (s_2_axi_arlen   ),
	.s_2_axi_arlock  (s_2_axi_arlock  ),
	.s_2_axi_arprot  (s_2_axi_arprot  ),
	.s_2_axi_arqos   (s_2_axi_arqos   ),
	.s_2_axi_awqos   (s_2_axi_awqos   ),
	.s_2_axi_arready (s_2_axi_arready ),
	.s_2_axi_arsize  (s_2_axi_arsize  ),
	.s_2_axi_arvalid (s_2_axi_arvalid ),
	.s_2_axi_awaddr  (s_2_axi_awaddr  ),
	.s_2_axi_awburst (s_2_axi_awburst ),
	.s_2_axi_awcache (s_2_axi_awcache ),
	.s_2_axi_awid    (s_2_axi_awid    ),
	.s_2_axi_awlen   (s_2_axi_awlen   ),
	.s_2_axi_awlock  (s_2_axi_awlock  ),
	.s_2_axi_awprot  (s_2_axi_awprot  ),
	.s_2_axi_awready (s_2_axi_awready ),
	.s_2_axi_awsize  (s_2_axi_awsize  ),
	.s_2_axi_awvalid (s_2_axi_awvalid ),
	.s_2_axi_bid     (s_2_axi_bid     ),
	.s_2_axi_bready  (s_2_axi_bready  ),
	.s_2_axi_bresp   (s_2_axi_bresp   ),
	.s_2_axi_bvalid  (s_2_axi_bvalid  ),
	.s_2_axi_rdata   (s_2_axi_rdata   ),
	.s_2_axi_rid     (s_2_axi_rid     ),
	.s_2_axi_rlast   (s_2_axi_rlast   ),
	.s_2_axi_rready  (s_2_axi_rready  ),
	.s_2_axi_rresp   (s_2_axi_rresp   ),
	.s_2_axi_rvalid  (s_2_axi_rvalid  ),
	.s_2_axi_wdata   (s_2_axi_wdata   ),
	.s_2_axi_wlast   (s_2_axi_wlast   ),
	.s_2_axi_wready  (s_2_axi_wready  ),
	.s_2_axi_wstrb   (s_2_axi_wstrb   ),
	.s_2_axi_wvalid  (s_2_axi_wvalid  ),
	.s_3_axi_araddr  (s_3_axi_araddr  ),
	.s_3_axi_arburst (s_3_axi_arburst ),
	.s_3_axi_arcache (s_3_axi_arcache ),
	.s_3_axi_arid    (s_3_axi_arid    ),
	.s_3_axi_arlen   (s_3_axi_arlen   ),
	.s_3_axi_arlock  (s_3_axi_arlock  ),
	.s_3_axi_arprot  (s_3_axi_arprot  ),
	.s_3_axi_arqos   (s_3_axi_arqos   ),
	.s_3_axi_awqos   (s_3_axi_awqos   ),
	.s_3_axi_arready (s_3_axi_arready ),
	.s_3_axi_arsize  (s_3_axi_arsize  ),
	.s_3_axi_arvalid (s_3_axi_arvalid ),
	.s_3_axi_awaddr  (s_3_axi_awaddr  ),
	.s_3_axi_awburst (s_3_axi_awburst ),
	.s_3_axi_awcache (s_3_axi_awcache ),
	.s_3_axi_awid    (s_3_axi_awid    ),
	.s_3_axi_awlen   (s_3_axi_awlen   ),
	.s_3_axi_awlock  (s_3_axi_awlock  ),
	.s_3_axi_awprot  (s_3_axi_awprot  ),
	.s_3_axi_awready (s_3_axi_awready ),
	.s_3_axi_awsize  (s_3_axi_awsize  ),
	.s_3_axi_awvalid (s_3_axi_awvalid ),
	.s_3_axi_bid     (s_3_axi_bid     ),
	.s_3_axi_bready  (s_3_axi_bready  ),
	.s_3_axi_bresp   (s_3_axi_bresp   ),
	.s_3_axi_bvalid  (s_3_axi_bvalid  ),
	.s_3_axi_rdata   (s_3_axi_rdata   ),
	.s_3_axi_rid     (s_3_axi_rid     ),
	.s_3_axi_rlast   (s_3_axi_rlast   ),
	.s_3_axi_rready  (s_3_axi_rready  ),
	.s_3_axi_rresp   (s_3_axi_rresp   ),
	.s_3_axi_rvalid  (s_3_axi_rvalid  ),
	.s_3_axi_wdata   (s_3_axi_wdata   ),
	.s_3_axi_wlast   (s_3_axi_wlast   ),
	.s_3_axi_wready  (s_3_axi_wready  ),
	.s_3_axi_wstrb   (s_3_axi_wstrb   ),
	.s_3_axi_wvalid  (s_3_axi_wvalid  )
);

// NoC
// &Instance("noc_wrapper"); @66
noc_wrapper x_noc_wrapper (
	.nou_clk           (nou_clk           ),
	.nou_rstn          (nou_rstn          ),
	.myLocX            (myLocX            ),
	.myLocY            (myLocY            ),
	.myChipID          (myChipID          ),
	.nou_noc_data_tid  (nou_noc_data_tid  ),
	.nou_noc_data_type (nou_noc_data_type ),
	.nou_noc_data      (nou_noc_data      ),
	.nou_noc_data_valid(nou_noc_data_valid),
	.noc_nou_data_ready(noc_nou_data_ready),
	.noc_nou_data_tid  (noc_nou_data_tid  ),
	.noc_nou_data_type (noc_nou_data_type ),
	.noc_nou_data      (noc_nou_data      ),
	.noc_nou_data_valid(noc_nou_data_valid),
	.nou_noc_data_ready(nou_noc_data_ready),
	.nou_noc_rsp_tid   (nou_noc_rsp_tid   ),
	.nou_noc_rsp_type  (nou_noc_rsp_type  ),
	.nou_noc_rsp       (nou_noc_rsp       ),
	.nou_noc_rsp_valid (nou_noc_rsp_valid ),
	.noc_nou_rsp_ready (noc_nou_rsp_ready ),
	.noc_nou_rsp_tid   (noc_nou_rsp_tid   ),
	.noc_nou_rsp_type  (noc_nou_rsp_type  ),
	.noc_nou_rsp       (noc_nou_rsp       ),
	.noc_nou_rsp_valid (noc_nou_rsp_valid ),
	.nou_noc_rsp_ready (nou_noc_rsp_ready ),
	.dat_W_out         (dat_W_out         ),
	.dat_vld_W_out     (dat_vld_W_out     ),
	.dat_yummy_W_in    (dat_yummy_W_in    ),
	.dat_W_in          (dat_W_in          ),
	.dat_vld_W_in      (dat_vld_W_in      ),
	.dat_yummy_W_out   (dat_yummy_W_out   ),
	.rsp_W_out         (rsp_W_out         ),
	.rsp_vld_W_out     (rsp_vld_W_out     ),
	.rsp_yummy_W_in    (rsp_yummy_W_in    ),
	.rsp_W_in          (rsp_W_in          ),
	.rsp_vld_W_in      (rsp_vld_W_in      ),
	.rsp_yummy_W_out   (rsp_yummy_W_out   ),
	.dat_E_out         (dat_E_out         ),
	.dat_vld_E_out     (dat_vld_E_out     ),
	.dat_yummy_E_in    (dat_yummy_E_in    ),
	.dat_E_in          (dat_E_in          ),
	.dat_vld_E_in      (dat_vld_E_in      ),
	.dat_yummy_E_out   (dat_yummy_E_out   ),
	.rsp_E_out         (rsp_E_out         ),
	.rsp_vld_E_out     (rsp_vld_E_out     ),
	.rsp_yummy_E_in    (rsp_yummy_E_in    ),
	.rsp_E_in          (rsp_E_in          ),
	.rsp_vld_E_in      (rsp_vld_E_in      ),
	.rsp_yummy_E_out   (rsp_yummy_E_out   ),
	.dat_N_out         (dat_N_out         ),
	.dat_vld_N_out     (dat_vld_N_out     ),
	.dat_yummy_N_in    (dat_yummy_N_in    ),
	.dat_N_in          (dat_N_in          ),
	.dat_vld_N_in      (dat_vld_N_in      ),
	.dat_yummy_N_out   (dat_yummy_N_out   ),
	.rsp_N_out         (rsp_N_out         ),
	.rsp_vld_N_out     (rsp_vld_N_out     ),
	.rsp_yummy_N_in    (rsp_yummy_N_in    ),
	.rsp_N_in          (rsp_N_in          ),
	.rsp_vld_N_in      (rsp_vld_N_in      ),
	.rsp_yummy_N_out   (rsp_yummy_N_out   ),
	.dat_S_out         (dat_S_out         ),
	.dat_vld_S_out     (dat_vld_S_out     ),
	.dat_yummy_S_in    (dat_yummy_S_in    ),
	.dat_S_in          (dat_S_in          ),
	.dat_vld_S_in      (dat_vld_S_in      ),
	.dat_yummy_S_out   (dat_yummy_S_out   ),
	.rsp_S_out         (rsp_S_out         ),
	.rsp_vld_S_out     (rsp_vld_S_out     ),
	.rsp_yummy_S_in    (rsp_yummy_S_in    ),
	.rsp_S_in          (rsp_S_in          ),
	.rsp_vld_S_in      (rsp_vld_S_in      ),
	.rsp_yummy_S_out   (rsp_yummy_S_out   )
);

// CSR
// &Instance("axi_csr", "x_csr"); @69
axi_csr x_csr (
	.aclk               (sys_clk            ),
	.arstn              (sys_rstn           ),
	.dispatcher_pc      (dispatcher_pc      ),
	.dispatcher_rst_addr(dispatcher_rst_addr),
	.regular_0_pc       (regular_0_pc       ),
	.regular_0_rst_addr (regular_0_rst_addr ),
	.regular_1_pc       (regular_1_pc       ),
	.regular_1_rst_addr (regular_1_rst_addr ),
	.axi_araddr         (csr_axi_araddr     ),
	.axi_arburst        (csr_axi_arburst    ),
	.axi_arcache        (csr_axi_arcache    ),
	.axi_arid           (csr_axi_arid       ),
	.axi_arlen          (csr_axi_arlen      ),
	.axi_arlock         (csr_axi_arlock     ),
	.axi_arprot         (csr_axi_arprot     ),
	.axi_arqos          (csr_axi_arqos      ),
	.axi_arsize         (csr_axi_arsize     ),
	.axi_arvalid        (csr_axi_arvalid    ),
	.axi_awaddr         (csr_axi_awaddr     ),
	.axi_awburst        (csr_axi_awburst    ),
	.axi_awcache        (csr_axi_awcache    ),
	.axi_awid           (csr_axi_awid       ),
	.axi_awlen          (csr_axi_awlen      ),
	.axi_awlock         (csr_axi_awlock     ),
	.axi_awprot         (csr_axi_awprot     ),
	.axi_awqos          (csr_axi_awqos      ),
	.axi_awsize         (csr_axi_awsize     ),
	.axi_awvalid        (csr_axi_awvalid    ),
	.axi_bready         (csr_axi_bready     ),
	.axi_rready         (csr_axi_rready     ),
	.axi_wdata          (csr_axi_wdata      ),
	.axi_wlast          (csr_axi_wlast      ),
	.axi_wstrb          (csr_axi_wstrb      ),
	.axi_wvalid         (csr_axi_wvalid     ),
	.axi_arready        (csr_axi_arready    ),
	.axi_awready        (csr_axi_awready    ),
	.axi_bid            (csr_axi_bid        ),
	.axi_bresp          (csr_axi_bresp      ),
	.axi_bvalid         (csr_axi_bvalid     ),
	.axi_rdata          (csr_axi_rdata      ),
	.axi_rid            (csr_axi_rid        ),
	.axi_rlast          (csr_axi_rlast      ),
	.axi_rresp          (csr_axi_rresp      ),
	.axi_rvalid         (csr_axi_rvalid     ),
	.axi_wready         (csr_axi_wready     )
);
// @70 &ConnRule(r'axi_', r'csr_axi_');
// @71 &Connect(
// @72     .aclk (sys_clk),
// @73     .arstn (sys_rstn),
// @74 );

// XBar
// &Instance("xbar_top"); @77
xbar_top x_xbar_top (
	.M00_AXI_aclk      (mem_sub_sys_clk         ),
	.M00_AXI_aresetn   (mem_sub_sys_rstn        ),
	.M00_AXI_arready   (s_0_axi_arready         ),
	.M00_AXI_awready   (s_0_axi_awready         ),
	.M00_AXI_bid       (s_0_axi_bid             ),
	.M00_AXI_bresp     (s_0_axi_bresp           ),
	.M00_AXI_bvalid    (s_0_axi_bvalid          ),
	.M00_AXI_rdata     (s_0_axi_rdata           ),
	.M00_AXI_rid       (s_0_axi_rid             ),
	.M00_AXI_rlast     (s_0_axi_rlast           ),
	.M00_AXI_rresp     (s_0_axi_rresp           ),
	.M00_AXI_rvalid    (s_0_axi_rvalid          ),
	.M00_AXI_wready    (s_0_axi_wready          ),
	.M00_AXI_araddr    (s_0_axi_araddr          ),
	.M00_AXI_arburst   (s_0_axi_arburst         ),
	.M00_AXI_arcache   (s_0_axi_arcache         ),
	.M00_AXI_arid      (s_0_axi_arid            ),
	.M00_AXI_arlen     (s_0_axi_arlen           ),
	.M00_AXI_arlock    (s_0_axi_arlock          ),
	.M00_AXI_arprot    (s_0_axi_arprot          ),
	.M00_AXI_arqos     (s_0_axi_arqos           ),
	.M00_AXI_arsize    (s_0_axi_arsize          ),
	.M00_AXI_arvalid   (s_0_axi_arvalid         ),
	.M00_AXI_awaddr    (s_0_axi_awaddr          ),
	.M00_AXI_awburst   (s_0_axi_awburst         ),
	.M00_AXI_awcache   (s_0_axi_awcache         ),
	.M00_AXI_awid      (s_0_axi_awid            ),
	.M00_AXI_awlen     (s_0_axi_awlen           ),
	.M00_AXI_awlock    (s_0_axi_awlock          ),
	.M00_AXI_awprot    (s_0_axi_awprot          ),
	.M00_AXI_awqos     (s_0_axi_awqos           ),
	.M00_AXI_awsize    (s_0_axi_awsize          ),
	.M00_AXI_awvalid   (s_0_axi_awvalid         ),
	.M00_AXI_bready    (s_0_axi_bready          ),
	.M00_AXI_rready    (s_0_axi_rready          ),
	.M00_AXI_wdata     (s_0_axi_wdata           ),
	.M00_AXI_wlast     (s_0_axi_wlast           ),
	.M00_AXI_wstrb     (s_0_axi_wstrb           ),
	.M00_AXI_wvalid    (s_0_axi_wvalid          ),
	.M01_AXI_aclk      (mem_sub_sys_clk         ),
	.M01_AXI_aresetn   (mem_sub_sys_rstn        ),
	.M01_AXI_arready   (s_1_axi_arready         ),
	.M01_AXI_awready   (s_1_axi_awready         ),
	.M01_AXI_bid       (s_1_axi_bid             ),
	.M01_AXI_bresp     (s_1_axi_bresp           ),
	.M01_AXI_bvalid    (s_1_axi_bvalid          ),
	.M01_AXI_rdata     (s_1_axi_rdata           ),
	.M01_AXI_rid       (s_1_axi_rid             ),
	.M01_AXI_rlast     (s_1_axi_rlast           ),
	.M01_AXI_rresp     (s_1_axi_rresp           ),
	.M01_AXI_rvalid    (s_1_axi_rvalid          ),
	.M01_AXI_wready    (s_1_axi_wready          ),
	.M01_AXI_araddr    (s_1_axi_araddr          ),
	.M01_AXI_arburst   (s_1_axi_arburst         ),
	.M01_AXI_arcache   (s_1_axi_arcache         ),
	.M01_AXI_arid      (s_1_axi_arid            ),
	.M01_AXI_arlen     (s_1_axi_arlen           ),
	.M01_AXI_arlock    (s_1_axi_arlock          ),
	.M01_AXI_arprot    (s_1_axi_arprot          ),
	.M01_AXI_arqos     (s_1_axi_arqos           ),
	.M01_AXI_arsize    (s_1_axi_arsize          ),
	.M01_AXI_arvalid   (s_1_axi_arvalid         ),
	.M01_AXI_awaddr    (s_1_axi_awaddr          ),
	.M01_AXI_awburst   (s_1_axi_awburst         ),
	.M01_AXI_awcache   (s_1_axi_awcache         ),
	.M01_AXI_awid      (s_1_axi_awid            ),
	.M01_AXI_awlen     (s_1_axi_awlen           ),
	.M01_AXI_awlock    (s_1_axi_awlock          ),
	.M01_AXI_awprot    (s_1_axi_awprot          ),
	.M01_AXI_awqos     (s_1_axi_awqos           ),
	.M01_AXI_awsize    (s_1_axi_awsize          ),
	.M01_AXI_awvalid   (s_1_axi_awvalid         ),
	.M01_AXI_bready    (s_1_axi_bready          ),
	.M01_AXI_rready    (s_1_axi_rready          ),
	.M01_AXI_wdata     (s_1_axi_wdata           ),
	.M01_AXI_wlast     (s_1_axi_wlast           ),
	.M01_AXI_wstrb     (s_1_axi_wstrb           ),
	.M01_AXI_wvalid    (s_1_axi_wvalid          ),
	.M02_AXI_aclk      (mem_sub_sys_clk         ),
	.M02_AXI_aresetn   (mem_sub_sys_rstn        ),
	.M02_AXI_arready   (s_2_axi_arready         ),
	.M02_AXI_awready   (s_2_axi_awready         ),
	.M02_AXI_bid       (s_2_axi_bid             ),
	.M02_AXI_bresp     (s_2_axi_bresp           ),
	.M02_AXI_bvalid    (s_2_axi_bvalid          ),
	.M02_AXI_rdata     (s_2_axi_rdata           ),
	.M02_AXI_rid       (s_2_axi_rid             ),
	.M02_AXI_rlast     (s_2_axi_rlast           ),
	.M02_AXI_rresp     (s_2_axi_rresp           ),
	.M02_AXI_rvalid    (s_2_axi_rvalid          ),
	.M02_AXI_wready    (s_2_axi_wready          ),
	.M02_AXI_araddr    (s_2_axi_araddr          ),
	.M02_AXI_arburst   (s_2_axi_arburst         ),
	.M02_AXI_arcache   (s_2_axi_arcache         ),
	.M02_AXI_arid      (s_2_axi_arid            ),
	.M02_AXI_arlen     (s_2_axi_arlen           ),
	.M02_AXI_arlock    (s_2_axi_arlock          ),
	.M02_AXI_arprot    (s_2_axi_arprot          ),
	.M02_AXI_arqos     (s_2_axi_arqos           ),
	.M02_AXI_arsize    (s_2_axi_arsize          ),
	.M02_AXI_arvalid   (s_2_axi_arvalid         ),
	.M02_AXI_awaddr    (s_2_axi_awaddr          ),
	.M02_AXI_awburst   (s_2_axi_awburst         ),
	.M02_AXI_awcache   (s_2_axi_awcache         ),
	.M02_AXI_awid      (s_2_axi_awid            ),
	.M02_AXI_awlen     (s_2_axi_awlen           ),
	.M02_AXI_awlock    (s_2_axi_awlock          ),
	.M02_AXI_awprot    (s_2_axi_awprot          ),
	.M02_AXI_awqos     (s_2_axi_awqos           ),
	.M02_AXI_awsize    (s_2_axi_awsize          ),
	.M02_AXI_awvalid   (s_2_axi_awvalid         ),
	.M02_AXI_bready    (s_2_axi_bready          ),
	.M02_AXI_rready    (s_2_axi_rready          ),
	.M02_AXI_wdata     (s_2_axi_wdata           ),
	.M02_AXI_wlast     (s_2_axi_wlast           ),
	.M02_AXI_wstrb     (s_2_axi_wstrb           ),
	.M02_AXI_wvalid    (s_2_axi_wvalid          ),
	.M03_AXI_aclk      (mem_sub_sys_clk         ),
	.M03_AXI_aresetn   (mem_sub_sys_rstn        ),
	.M03_AXI_arready   (s_3_axi_arready         ),
	.M03_AXI_awready   (s_3_axi_awready         ),
	.M03_AXI_bid       (s_3_axi_bid             ),
	.M03_AXI_bresp     (s_3_axi_bresp           ),
	.M03_AXI_bvalid    (s_3_axi_bvalid          ),
	.M03_AXI_rdata     (s_3_axi_rdata           ),
	.M03_AXI_rid       (s_3_axi_rid             ),
	.M03_AXI_rlast     (s_3_axi_rlast           ),
	.M03_AXI_rresp     (s_3_axi_rresp           ),
	.M03_AXI_rvalid    (s_3_axi_rvalid          ),
	.M03_AXI_wready    (s_3_axi_wready          ),
	.M03_AXI_araddr    (s_3_axi_araddr          ),
	.M03_AXI_arburst   (s_3_axi_arburst         ),
	.M03_AXI_arcache   (s_3_axi_arcache         ),
	.M03_AXI_arid      (s_3_axi_arid            ),
	.M03_AXI_arlen     (s_3_axi_arlen           ),
	.M03_AXI_arlock    (s_3_axi_arlock          ),
	.M03_AXI_arprot    (s_3_axi_arprot          ),
	.M03_AXI_arqos     (s_3_axi_arqos           ),
	.M03_AXI_arsize    (s_3_axi_arsize          ),
	.M03_AXI_arvalid   (s_3_axi_arvalid         ),
	.M03_AXI_awaddr    (s_3_axi_awaddr          ),
	.M03_AXI_awburst   (s_3_axi_awburst         ),
	.M03_AXI_awcache   (s_3_axi_awcache         ),
	.M03_AXI_awid      (s_3_axi_awid            ),
	.M03_AXI_awlen     (s_3_axi_awlen           ),
	.M03_AXI_awlock    (s_3_axi_awlock          ),
	.M03_AXI_awprot    (s_3_axi_awprot          ),
	.M03_AXI_awqos     (s_3_axi_awqos           ),
	.M03_AXI_awsize    (s_3_axi_awsize          ),
	.M03_AXI_awvalid   (s_3_axi_awvalid         ),
	.M03_AXI_bready    (s_3_axi_bready          ),
	.M03_AXI_rready    (s_3_axi_rready          ),
	.M03_AXI_wdata     (s_3_axi_wdata           ),
	.M03_AXI_wlast     (s_3_axi_wlast           ),
	.M03_AXI_wstrb     (s_3_axi_wstrb           ),
	.M03_AXI_wvalid    (s_3_axi_wvalid          ),
	.M04_AXI_aclk      (sys_clk                 ),
	.M04_AXI_aresetn   (sys_rstn                ),
	.M04_AXI_arready   (csr_axi_arready         ),
	.M04_AXI_awready   (csr_axi_awready         ),
	.M04_AXI_bid       (csr_axi_bid             ),
	.M04_AXI_bresp     (csr_axi_bresp           ),
	.M04_AXI_bvalid    (csr_axi_bvalid          ),
	.M04_AXI_rdata     (csr_axi_rdata           ),
	.M04_AXI_rid       (csr_axi_rid             ),
	.M04_AXI_rlast     (csr_axi_rlast           ),
	.M04_AXI_rresp     (csr_axi_rresp           ),
	.M04_AXI_rvalid    (csr_axi_rvalid          ),
	.M04_AXI_wready    (csr_axi_wready          ),
	.M04_AXI_araddr    (csr_axi_araddr          ),
	.M04_AXI_arburst   (csr_axi_arburst         ),
	.M04_AXI_arcache   (csr_axi_arcache         ),
	.M04_AXI_arid      (csr_axi_arid            ),
	.M04_AXI_arlen     (csr_axi_arlen           ),
	.M04_AXI_arlock    (csr_axi_arlock          ),
	.M04_AXI_arprot    (csr_axi_arprot          ),
	.M04_AXI_arqos     (csr_axi_arqos           ),
	.M04_AXI_arsize    (csr_axi_arsize          ),
	.M04_AXI_arvalid   (csr_axi_arvalid         ),
	.M04_AXI_awaddr    (csr_axi_awaddr          ),
	.M04_AXI_awburst   (csr_axi_awburst         ),
	.M04_AXI_awcache   (csr_axi_awcache         ),
	.M04_AXI_awid      (csr_axi_awid            ),
	.M04_AXI_awlen     (csr_axi_awlen           ),
	.M04_AXI_awlock    (csr_axi_awlock          ),
	.M04_AXI_awprot    (csr_axi_awprot          ),
	.M04_AXI_awqos     (csr_axi_awqos           ),
	.M04_AXI_awsize    (csr_axi_awsize          ),
	.M04_AXI_awvalid   (csr_axi_awvalid         ),
	.M04_AXI_bready    (csr_axi_bready          ),
	.M04_AXI_rready    (csr_axi_rready          ),
	.M04_AXI_wdata     (csr_axi_wdata           ),
	.M04_AXI_wlast     (csr_axi_wlast           ),
	.M04_AXI_wstrb     (csr_axi_wstrb           ),
	.M04_AXI_wvalid    (csr_axi_wvalid          ),
	.S_HOST_AXI_aclk   (S_HOST_AXI_aclk         ),
	.S_HOST_AXI_araddr (S_HOST_AXI_araddr       ),
	.S_HOST_AXI_arburst(S_HOST_AXI_arburst      ),
	.S_HOST_AXI_arcache(S_HOST_AXI_arcache      ),
	.S_HOST_AXI_aresetn(S_HOST_AXI_aresetn      ),
	.S_HOST_AXI_arid   (S_HOST_AXI_arid         ),
	.S_HOST_AXI_arlen  (S_HOST_AXI_arlen        ),
	.S_HOST_AXI_arlock (S_HOST_AXI_arlock       ),
	.S_HOST_AXI_arprot (S_HOST_AXI_arprot       ),
	.S_HOST_AXI_arqos  (S_HOST_AXI_arqos        ),
	.S_HOST_AXI_arsize (S_HOST_AXI_arsize       ),
	.S_HOST_AXI_arvalid(S_HOST_AXI_arvalid      ),
	.S_HOST_AXI_awaddr (S_HOST_AXI_awaddr       ),
	.S_HOST_AXI_awburst(S_HOST_AXI_awburst      ),
	.S_HOST_AXI_awcache(S_HOST_AXI_awcache      ),
	.S_HOST_AXI_awid   (S_HOST_AXI_awid         ),
	.S_HOST_AXI_awlen  (S_HOST_AXI_awlen        ),
	.S_HOST_AXI_awlock (S_HOST_AXI_awlock       ),
	.S_HOST_AXI_awprot (S_HOST_AXI_awprot       ),
	.S_HOST_AXI_awqos  (S_HOST_AXI_awqos        ),
	.S_HOST_AXI_awsize (S_HOST_AXI_awsize       ),
	.S_HOST_AXI_awvalid(S_HOST_AXI_awvalid      ),
	.S_HOST_AXI_bready (S_HOST_AXI_bready       ),
	.S_HOST_AXI_rready (S_HOST_AXI_rready       ),
	.S_HOST_AXI_wdata  (S_HOST_AXI_wdata        ),
	.S_HOST_AXI_wlast  (S_HOST_AXI_wlast        ),
	.S_HOST_AXI_wstrb  (S_HOST_AXI_wstrb        ),
	.S_HOST_AXI_wvalid (S_HOST_AXI_wvalid       ),
	.S_HOST_AXI_arready(S_HOST_AXI_arready      ),
	.S_HOST_AXI_awready(S_HOST_AXI_awready      ),
	.S_HOST_AXI_bid    (S_HOST_AXI_bid          ),
	.S_HOST_AXI_bresp  (S_HOST_AXI_bresp        ),
	.S_HOST_AXI_bvalid (S_HOST_AXI_bvalid       ),
	.S_HOST_AXI_rdata  (S_HOST_AXI_rdata        ),
	.S_HOST_AXI_rid    (S_HOST_AXI_rid          ),
	.S_HOST_AXI_rlast  (S_HOST_AXI_rlast        ),
	.S_HOST_AXI_rresp  (S_HOST_AXI_rresp        ),
	.S_HOST_AXI_rvalid (S_HOST_AXI_rvalid       ),
	.S_HOST_AXI_wready (S_HOST_AXI_wready       ),
	.S00_AXI_aclk      (dispatcher_clk          ),
	.S00_AXI_araddr    (dispatcher_m_axi_araddr ),
	.S00_AXI_arburst   (dispatcher_m_axi_arburst),
	.S00_AXI_arcache   (dispatcher_m_axi_arcache),
	.S00_AXI_aresetn   (dispatcher_rstn         ),
	.S00_AXI_arid      (dispatcher_m_axi_arid   ),
	.S00_AXI_arlen     (dispatcher_m_axi_arlen  ),
	.S00_AXI_arlock    (dispatcher_m_axi_arlock ),
	.S00_AXI_arprot    (dispatcher_m_axi_arprot ),
	.S00_AXI_arqos     (dispatcher_m_axi_arqos  ),
	.S00_AXI_arsize    (dispatcher_m_axi_arsize ),
	.S00_AXI_arvalid   (dispatcher_m_axi_arvalid),
	.S00_AXI_awaddr    (dispatcher_m_axi_awaddr ),
	.S00_AXI_awburst   (dispatcher_m_axi_awburst),
	.S00_AXI_awcache   (dispatcher_m_axi_awcache),
	.S00_AXI_awid      (dispatcher_m_axi_awid   ),
	.S00_AXI_awlen     (dispatcher_m_axi_awlen  ),
	.S00_AXI_awlock    (dispatcher_m_axi_awlock ),
	.S00_AXI_awprot    (dispatcher_m_axi_awprot ),
	.S00_AXI_awqos     (dispatcher_m_axi_awqos  ),
	.S00_AXI_awsize    (dispatcher_m_axi_awsize ),
	.S00_AXI_awvalid   (dispatcher_m_axi_awvalid),
	.S00_AXI_bready    (dispatcher_m_axi_bready ),
	.S00_AXI_rready    (dispatcher_m_axi_rready ),
	.S00_AXI_wdata     (dispatcher_m_axi_wdata  ),
	.S00_AXI_wlast     (dispatcher_m_axi_wlast  ),
	.S00_AXI_wstrb     (dispatcher_m_axi_wstrb  ),
	.S00_AXI_wvalid    (dispatcher_m_axi_wvalid ),
	.S00_AXI_arready   (dispatcher_m_axi_arready),
	.S00_AXI_awready   (dispatcher_m_axi_awready),
	.S00_AXI_bid       (dispatcher_m_axi_bid    ),
	.S00_AXI_bresp     (dispatcher_m_axi_bresp  ),
	.S00_AXI_bvalid    (dispatcher_m_axi_bvalid ),
	.S00_AXI_rdata     (dispatcher_m_axi_rdata  ),
	.S00_AXI_rid       (dispatcher_m_axi_rid    ),
	.S00_AXI_rlast     (dispatcher_m_axi_rlast  ),
	.S00_AXI_rresp     (dispatcher_m_axi_rresp  ),
	.S00_AXI_rvalid    (dispatcher_m_axi_rvalid ),
	.S00_AXI_wready    (dispatcher_m_axi_wready ),
	.S01_AXI_aclk      (regular_0_clk           ),
	.S01_AXI_araddr    (regular_0_m_axi_araddr  ),
	.S01_AXI_arburst   (regular_0_m_axi_arburst ),
	.S01_AXI_arcache   (regular_0_m_axi_arcache ),
	.S01_AXI_aresetn   (regular_0_rstn          ),
	.S01_AXI_arid      (regular_0_m_axi_arid    ),
	.S01_AXI_arlen     (regular_0_m_axi_arlen   ),
	.S01_AXI_arlock    (regular_0_m_axi_arlock  ),
	.S01_AXI_arprot    (regular_0_m_axi_arprot  ),
	.S01_AXI_arqos     (regular_0_m_axi_arqos   ),
	.S01_AXI_arsize    (regular_0_m_axi_arsize  ),
	.S01_AXI_arvalid   (regular_0_m_axi_arvalid ),
	.S01_AXI_awaddr    (regular_0_m_axi_awaddr  ),
	.S01_AXI_awburst   (regular_0_m_axi_awburst ),
	.S01_AXI_awcache   (regular_0_m_axi_awcache ),
	.S01_AXI_awid      (regular_0_m_axi_awid    ),
	.S01_AXI_awlen     (regular_0_m_axi_awlen   ),
	.S01_AXI_awlock    (regular_0_m_axi_awlock  ),
	.S01_AXI_awprot    (regular_0_m_axi_awprot  ),
	.S01_AXI_awqos     (regular_0_m_axi_awqos   ),
	.S01_AXI_awsize    (regular_0_m_axi_awsize  ),
	.S01_AXI_awvalid   (regular_0_m_axi_awvalid ),
	.S01_AXI_bready    (regular_0_m_axi_bready  ),
	.S01_AXI_rready    (regular_0_m_axi_rready  ),
	.S01_AXI_wdata     (regular_0_m_axi_wdata   ),
	.S01_AXI_wlast     (regular_0_m_axi_wlast   ),
	.S01_AXI_wstrb     (regular_0_m_axi_wstrb   ),
	.S01_AXI_wvalid    (regular_0_m_axi_wvalid  ),
	.S01_AXI_arready   (regular_0_m_axi_arready ),
	.S01_AXI_awready   (regular_0_m_axi_awready ),
	.S01_AXI_bid       (regular_0_m_axi_bid     ),
	.S01_AXI_bresp     (regular_0_m_axi_bresp   ),
	.S01_AXI_bvalid    (regular_0_m_axi_bvalid  ),
	.S01_AXI_rdata     (regular_0_m_axi_rdata   ),
	.S01_AXI_rid       (regular_0_m_axi_rid     ),
	.S01_AXI_rlast     (regular_0_m_axi_rlast   ),
	.S01_AXI_rresp     (regular_0_m_axi_rresp   ),
	.S01_AXI_rvalid    (regular_0_m_axi_rvalid  ),
	.S01_AXI_wready    (regular_0_m_axi_wready  ),
	.S02_AXI_aclk      (regular_1_clk           ),
	.S02_AXI_araddr    (regular_1_m_axi_araddr  ),
	.S02_AXI_arburst   (regular_1_m_axi_arburst ),
	.S02_AXI_arcache   (regular_1_m_axi_arcache ),
	.S02_AXI_aresetn   (regular_1_rstn          ),
	.S02_AXI_arid      (regular_1_m_axi_arid    ),
	.S02_AXI_arlen     (regular_1_m_axi_arlen   ),
	.S02_AXI_arlock    (regular_1_m_axi_arlock  ),
	.S02_AXI_arprot    (regular_1_m_axi_arprot  ),
	.S02_AXI_arqos     (regular_1_m_axi_arqos   ),
	.S02_AXI_arsize    (regular_1_m_axi_arsize  ),
	.S02_AXI_arvalid   (regular_1_m_axi_arvalid ),
	.S02_AXI_awaddr    (regular_1_m_axi_awaddr  ),
	.S02_AXI_awburst   (regular_1_m_axi_awburst ),
	.S02_AXI_awcache   (regular_1_m_axi_awcache ),
	.S02_AXI_awid      (regular_1_m_axi_awid    ),
	.S02_AXI_awlen     (regular_1_m_axi_awlen   ),
	.S02_AXI_awlock    (regular_1_m_axi_awlock  ),
	.S02_AXI_awprot    (regular_1_m_axi_awprot  ),
	.S02_AXI_awqos     (regular_1_m_axi_awqos   ),
	.S02_AXI_awsize    (regular_1_m_axi_awsize  ),
	.S02_AXI_awvalid   (regular_1_m_axi_awvalid ),
	.S02_AXI_bready    (regular_1_m_axi_bready  ),
	.S02_AXI_rready    (regular_1_m_axi_rready  ),
	.S02_AXI_wdata     (regular_1_m_axi_wdata   ),
	.S02_AXI_wlast     (regular_1_m_axi_wlast   ),
	.S02_AXI_wstrb     (regular_1_m_axi_wstrb   ),
	.S02_AXI_wvalid    (regular_1_m_axi_wvalid  ),
	.S02_AXI_arready   (regular_1_m_axi_arready ),
	.S02_AXI_awready   (regular_1_m_axi_awready ),
	.S02_AXI_bid       (regular_1_m_axi_bid     ),
	.S02_AXI_bresp     (regular_1_m_axi_bresp   ),
	.S02_AXI_bvalid    (regular_1_m_axi_bvalid  ),
	.S02_AXI_rdata     (regular_1_m_axi_rdata   ),
	.S02_AXI_rid       (regular_1_m_axi_rid     ),
	.S02_AXI_rlast     (regular_1_m_axi_rlast   ),
	.S02_AXI_rresp     (regular_1_m_axi_rresp   ),
	.S02_AXI_rvalid    (regular_1_m_axi_rvalid  ),
	.S02_AXI_wready    (regular_1_m_axi_wready  ),
	.S03_AXI_aclk      (dsa_0_clk               ),
	.S03_AXI_araddr    (dsa_0_m_axi_araddr      ),
	.S03_AXI_arburst   (dsa_0_m_axi_arburst     ),
	.S03_AXI_arcache   (dsa_0_m_axi_arcache     ),
	.S03_AXI_aresetn   (dsa_0_rstn              ),
	.S03_AXI_arid      (dsa_0_m_axi_arid        ),
	.S03_AXI_arlen     (dsa_0_m_axi_arlen       ),
	.S03_AXI_arlock    (dsa_0_m_axi_arlock      ),
	.S03_AXI_arprot    (dsa_0_m_axi_arprot      ),
	.S03_AXI_arqos     (dsa_0_m_axi_arqos       ),
	.S03_AXI_arsize    (dsa_0_m_axi_arsize      ),
	.S03_AXI_arvalid   (dsa_0_m_axi_arvalid     ),
	.S03_AXI_awaddr    (dsa_0_m_axi_awaddr      ),
	.S03_AXI_awburst   (dsa_0_m_axi_awburst     ),
	.S03_AXI_awcache   (dsa_0_m_axi_awcache     ),
	.S03_AXI_awid      (dsa_0_m_axi_awid        ),
	.S03_AXI_awlen     (dsa_0_m_axi_awlen       ),
	.S03_AXI_awlock    (dsa_0_m_axi_awlock      ),
	.S03_AXI_awprot    (dsa_0_m_axi_awprot      ),
	.S03_AXI_awqos     (dsa_0_m_axi_awqos       ),
	.S03_AXI_awsize    (dsa_0_m_axi_awsize      ),
	.S03_AXI_awvalid   (dsa_0_m_axi_awvalid     ),
	.S03_AXI_bready    (dsa_0_m_axi_bready      ),
	.S03_AXI_rready    (dsa_0_m_axi_rready      ),
	.S03_AXI_wdata     (dsa_0_m_axi_wdata       ),
	.S03_AXI_wlast     (dsa_0_m_axi_wlast       ),
	.S03_AXI_wstrb     (dsa_0_m_axi_wstrb       ),
	.S03_AXI_wvalid    (dsa_0_m_axi_wvalid      ),
	.S03_AXI_arready   (dsa_0_m_axi_arready     ),
	.S03_AXI_awready   (dsa_0_m_axi_awready     ),
	.S03_AXI_bid       (dsa_0_m_axi_bid         ),
	.S03_AXI_bresp     (dsa_0_m_axi_bresp       ),
	.S03_AXI_bvalid    (dsa_0_m_axi_bvalid      ),
	.S03_AXI_rdata     (dsa_0_m_axi_rdata       ),
	.S03_AXI_rid       (dsa_0_m_axi_rid         ),
	.S03_AXI_rlast     (dsa_0_m_axi_rlast       ),
	.S03_AXI_rresp     (dsa_0_m_axi_rresp       ),
	.S03_AXI_rvalid    (dsa_0_m_axi_rvalid      ),
	.S03_AXI_wready    (dsa_0_m_axi_wready      ),
	.S04_AXI_aclk      (dsa_1_clk               ),
	.S04_AXI_araddr    (dsa_1_m_axi_araddr      ),
	.S04_AXI_arburst   (dsa_1_m_axi_arburst     ),
	.S04_AXI_arcache   (dsa_1_m_axi_arcache     ),
	.S04_AXI_aresetn   (dsa_1_rstn              ),
	.S04_AXI_arid      (dsa_1_m_axi_arid        ),
	.S04_AXI_arlen     (dsa_1_m_axi_arlen       ),
	.S04_AXI_arlock    (dsa_1_m_axi_arlock      ),
	.S04_AXI_arprot    (dsa_1_m_axi_arprot      ),
	.S04_AXI_arqos     (dsa_1_m_axi_arqos       ),
	.S04_AXI_arsize    (dsa_1_m_axi_arsize      ),
	.S04_AXI_arvalid   (dsa_1_m_axi_arvalid     ),
	.S04_AXI_awaddr    (dsa_1_m_axi_awaddr      ),
	.S04_AXI_awburst   (dsa_1_m_axi_awburst     ),
	.S04_AXI_awcache   (dsa_1_m_axi_awcache     ),
	.S04_AXI_awid      (dsa_1_m_axi_awid        ),
	.S04_AXI_awlen     (dsa_1_m_axi_awlen       ),
	.S04_AXI_awlock    (dsa_1_m_axi_awlock      ),
	.S04_AXI_awprot    (dsa_1_m_axi_awprot      ),
	.S04_AXI_awqos     (dsa_1_m_axi_awqos       ),
	.S04_AXI_awsize    (dsa_1_m_axi_awsize      ),
	.S04_AXI_awvalid   (dsa_1_m_axi_awvalid     ),
	.S04_AXI_bready    (dsa_1_m_axi_bready      ),
	.S04_AXI_rready    (dsa_1_m_axi_rready      ),
	.S04_AXI_wdata     (dsa_1_m_axi_wdata       ),
	.S04_AXI_wlast     (dsa_1_m_axi_wlast       ),
	.S04_AXI_wstrb     (dsa_1_m_axi_wstrb       ),
	.S04_AXI_wvalid    (dsa_1_m_axi_wvalid      ),
	.S04_AXI_arready   (dsa_1_m_axi_arready     ),
	.S04_AXI_awready   (dsa_1_m_axi_awready     ),
	.S04_AXI_bid       (dsa_1_m_axi_bid         ),
	.S04_AXI_bresp     (dsa_1_m_axi_bresp       ),
	.S04_AXI_bvalid    (dsa_1_m_axi_bvalid      ),
	.S04_AXI_rdata     (dsa_1_m_axi_rdata       ),
	.S04_AXI_rid       (dsa_1_m_axi_rid         ),
	.S04_AXI_rlast     (dsa_1_m_axi_rlast       ),
	.S04_AXI_rresp     (dsa_1_m_axi_rresp       ),
	.S04_AXI_rvalid    (dsa_1_m_axi_rvalid      ),
	.S04_AXI_wready    (dsa_1_m_axi_wready      ),
	.S05_AXI_aclk      (dsa_2_clk               ),
	.S05_AXI_araddr    (dsa_2_m_axi_araddr      ),
	.S05_AXI_arburst   (dsa_2_m_axi_arburst     ),
	.S05_AXI_arcache   (dsa_2_m_axi_arcache     ),
	.S05_AXI_aresetn   (dsa_2_rstn              ),
	.S05_AXI_arid      (dsa_2_m_axi_arid        ),
	.S05_AXI_arlen     (dsa_2_m_axi_arlen       ),
	.S05_AXI_arlock    (dsa_2_m_axi_arlock      ),
	.S05_AXI_arprot    (dsa_2_m_axi_arprot      ),
	.S05_AXI_arqos     (dsa_2_m_axi_arqos       ),
	.S05_AXI_arsize    (dsa_2_m_axi_arsize      ),
	.S05_AXI_arvalid   (dsa_2_m_axi_arvalid     ),
	.S05_AXI_awaddr    (dsa_2_m_axi_awaddr      ),
	.S05_AXI_awburst   (dsa_2_m_axi_awburst     ),
	.S05_AXI_awcache   (dsa_2_m_axi_awcache     ),
	.S05_AXI_awid      (dsa_2_m_axi_awid        ),
	.S05_AXI_awlen     (dsa_2_m_axi_awlen       ),
	.S05_AXI_awlock    (dsa_2_m_axi_awlock      ),
	.S05_AXI_awprot    (dsa_2_m_axi_awprot      ),
	.S05_AXI_awqos     (dsa_2_m_axi_awqos       ),
	.S05_AXI_awsize    (dsa_2_m_axi_awsize      ),
	.S05_AXI_awvalid   (dsa_2_m_axi_awvalid     ),
	.S05_AXI_bready    (dsa_2_m_axi_bready      ),
	.S05_AXI_rready    (dsa_2_m_axi_rready      ),
	.S05_AXI_wdata     (dsa_2_m_axi_wdata       ),
	.S05_AXI_wlast     (dsa_2_m_axi_wlast       ),
	.S05_AXI_wstrb     (dsa_2_m_axi_wstrb       ),
	.S05_AXI_wvalid    (dsa_2_m_axi_wvalid      ),
	.S05_AXI_arready   (dsa_2_m_axi_arready     ),
	.S05_AXI_awready   (dsa_2_m_axi_awready     ),
	.S05_AXI_bid       (dsa_2_m_axi_bid         ),
	.S05_AXI_bresp     (dsa_2_m_axi_bresp       ),
	.S05_AXI_bvalid    (dsa_2_m_axi_bvalid      ),
	.S05_AXI_rdata     (dsa_2_m_axi_rdata       ),
	.S05_AXI_rid       (dsa_2_m_axi_rid         ),
	.S05_AXI_rlast     (dsa_2_m_axi_rlast       ),
	.S05_AXI_rresp     (dsa_2_m_axi_rresp       ),
	.S05_AXI_rvalid    (dsa_2_m_axi_rvalid      ),
	.S05_AXI_wready    (dsa_2_m_axi_wready      ),
	.S06_AXI_aclk      (nou_clk                 ),
	.S06_AXI_araddr    (nou_m_axi_araddr        ),
	.S06_AXI_arburst   (nou_m_axi_arburst       ),
	.S06_AXI_arcache   (nou_m_axi_arcache       ),
	.S06_AXI_aresetn   (nou_rstn                ),
	.S06_AXI_arid      (nou_m_axi_arid          ),
	.S06_AXI_arlen     (nou_m_axi_arlen         ),
	.S06_AXI_arlock    (nou_m_axi_arlock        ),
	.S06_AXI_arprot    (nou_m_axi_arprot        ),
	.S06_AXI_arqos     (nou_m_axi_arqos         ),
	.S06_AXI_arsize    (nou_m_axi_arsize        ),
	.S06_AXI_arvalid   (nou_m_axi_arvalid       ),
	.S06_AXI_awaddr    (nou_m_axi_awaddr        ),
	.S06_AXI_awburst   (nou_m_axi_awburst       ),
	.S06_AXI_awcache   (nou_m_axi_awcache       ),
	.S06_AXI_awid      (nou_m_axi_awid          ),
	.S06_AXI_awlen     (nou_m_axi_awlen         ),
	.S06_AXI_awlock    (nou_m_axi_awlock        ),
	.S06_AXI_awprot    (nou_m_axi_awprot        ),
	.S06_AXI_awqos     (nou_m_axi_awqos         ),
	.S06_AXI_awsize    (nou_m_axi_awsize        ),
	.S06_AXI_awvalid   (nou_m_axi_awvalid       ),
	.S06_AXI_bready    (nou_m_axi_bready        ),
	.S06_AXI_rready    (nou_m_axi_rready        ),
	.S06_AXI_wdata     (nou_m_axi_wdata         ),
	.S06_AXI_wlast     (nou_m_axi_wlast         ),
	.S06_AXI_wstrb     (nou_m_axi_wstrb         ),
	.S06_AXI_wvalid    (nou_m_axi_wvalid        ),
	.S06_AXI_arready   (nou_m_axi_arready       ),
	.S06_AXI_awready   (nou_m_axi_awready       ),
	.S06_AXI_bid       (nou_m_axi_bid           ),
	.S06_AXI_bresp     (nou_m_axi_bresp         ),
	.S06_AXI_bvalid    (nou_m_axi_bvalid        ),
	.S06_AXI_rdata     (nou_m_axi_rdata         ),
	.S06_AXI_rid       (nou_m_axi_rid           ),
	.S06_AXI_rlast     (nou_m_axi_rlast         ),
	.S06_AXI_rresp     (nou_m_axi_rresp         ),
	.S06_AXI_rvalid    (nou_m_axi_rvalid        ),
	.S06_AXI_wready    (nou_m_axi_wready        )
);

// @79 &ConnRule(r'S00_AXI', r'dispatcher_m_axi');
// @80 &ConnRule(r'S01_AXI', r'regular_0_m_axi');
// @81 &ConnRule(r'S02_AXI', r'regular_1_m_axi');
// @82 &ConnRule(r'S03_AXI', r'dsa_0_m_axi');
// @83 &ConnRule(r'S04_AXI', r'dsa_1_m_axi');
// @84 &ConnRule(r'S05_AXI', r'dsa_2_m_axi');
// @85 &ConnRule(r'S06_AXI', r'nou_m_axi');
// @86 &ConnRule(r'M00_AXI', r's_0_axi');
// @87 &ConnRule(r'M01_AXI', r's_1_axi');
// @88 &ConnRule(r'M02_AXI', r's_2_axi');
// @89 &ConnRule(r'M03_AXI', r's_3_axi');
// @90 &ConnRule(r'M04_AXI', r'csr_axi');

// @92 &Connect(
// @93     .S00_AXI_aclk (dispatcher_clk),
// @94     .S00_AXI_aresetn (dispatcher_rstn),
// @95     .S01_AXI_aclk (regular_0_clk),
// @96     .S01_AXI_aresetn (regular_0_rstn),
// @97     .S02_AXI_aclk (regular_1_clk),
// @98     .S02_AXI_aresetn (regular_1_rstn),
// @99     .S03_AXI_aclk (dsa_0_clk),
// @100     .S03_AXI_aresetn (dsa_0_rstn),
// @101     .S04_AXI_aclk (dsa_1_clk),
// @102     .S04_AXI_aresetn (dsa_1_rstn),
// @103     .S05_AXI_aclk (dsa_2_clk),
// @104     .S05_AXI_aresetn (dsa_2_rstn),
// @105     .S06_AXI_aclk (nou_clk),
// @106     .S06_AXI_aresetn (nou_rstn),
// @107     .M00_AXI_aclk (mem_sub_sys_clk),
// @108     .M00_AXI_aresetn (mem_sub_sys_rstn),
// @109     .M01_AXI_aclk (mem_sub_sys_clk),
// @110     .M01_AXI_aresetn (mem_sub_sys_rstn),
// @111     .M02_AXI_aclk (mem_sub_sys_clk),
// @112     .M02_AXI_aresetn (mem_sub_sys_rstn),
// @113     .M03_AXI_aclk (mem_sub_sys_clk),
// @114     .M03_AXI_aresetn (mem_sub_sys_rstn),
// @115     .M04_AXI_aclk (sys_clk),
// @116     .M04_AXI_aresetn (sys_rstn),
// @117 );


endmodule
