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
module pe_array_top (
	pe_0_0_regular_0_clk,
	pe_0_0_regular_0_rstn,
	pe_0_0_regular_1_clk,
	pe_0_0_regular_1_rstn,
	pe_0_0_nou_clk,
	pe_0_0_nou_rstn,
	pe_0_0_dsa_2_clk,
	pe_0_0_dsa_2_rstn,
	pe_0_0_dispatcher_clk,
	pe_0_0_dispatcher_rstn,
	pe_0_0_dsa_0_clk,
	pe_0_0_dsa_0_rstn,
	pe_0_0_dsa_1_clk,
	pe_0_0_dsa_1_rstn,
	pe_0_0_dsa_0_m_dsa_0_clk,
	pe_0_0_dsa_0_m_dsa_0_rstn,
	pe_0_0_dsa_1_m_dsa_1_clk,
	pe_0_0_dsa_1_m_dsa_1_rstn,
	pe_0_0_dsa_2_m_dsa_2_clk,
	pe_0_0_dsa_2_m_dsa_2_rstn,
	pe_0_0_mem_sub_sys_clk,
	pe_0_0_mem_sub_sys_rstn,
	pe_0_0_dat_W_out,
	pe_0_0_dat_vld_W_out,
	pe_0_0_dat_yummy_W_in,
	pe_0_0_dat_W_in,
	pe_0_0_dat_vld_W_in,
	pe_0_0_dat_yummy_W_out,
	pe_0_0_rsp_W_out,
	pe_0_0_rsp_vld_W_out,
	pe_0_0_rsp_yummy_W_in,
	pe_0_0_rsp_W_in,
	pe_0_0_rsp_vld_W_in,
	pe_0_0_rsp_yummy_W_out,
	pe_0_0_dat_S_out,
	pe_0_0_dat_vld_S_out,
	pe_0_0_dat_yummy_S_in,
	pe_0_0_dat_S_in,
	pe_0_0_dat_vld_S_in,
	pe_0_0_dat_yummy_S_out,
	pe_0_0_rsp_S_out,
	pe_0_0_rsp_vld_S_out,
	pe_0_0_rsp_yummy_S_in,
	pe_0_0_rsp_S_in,
	pe_0_0_rsp_vld_S_in,
	pe_0_0_rsp_yummy_S_out,
	pe_0_0_sys_clk,
	pe_0_0_sys_rstn,
	pe_0_0_S_HOST_AXI_aclk,
	pe_0_0_S_HOST_AXI_araddr,
	pe_0_0_S_HOST_AXI_arburst,
	pe_0_0_S_HOST_AXI_arcache,
	pe_0_0_S_HOST_AXI_aresetn,
	pe_0_0_S_HOST_AXI_arid,
	pe_0_0_S_HOST_AXI_arlen,
	pe_0_0_S_HOST_AXI_arlock,
	pe_0_0_S_HOST_AXI_arprot,
	pe_0_0_S_HOST_AXI_arqos,
	pe_0_0_S_HOST_AXI_arsize,
	pe_0_0_S_HOST_AXI_arvalid,
	pe_0_0_S_HOST_AXI_awaddr,
	pe_0_0_S_HOST_AXI_awburst,
	pe_0_0_S_HOST_AXI_awcache,
	pe_0_0_S_HOST_AXI_awid,
	pe_0_0_S_HOST_AXI_awlen,
	pe_0_0_S_HOST_AXI_awlock,
	pe_0_0_S_HOST_AXI_awprot,
	pe_0_0_S_HOST_AXI_awqos,
	pe_0_0_S_HOST_AXI_awsize,
	pe_0_0_S_HOST_AXI_awvalid,
	pe_0_0_S_HOST_AXI_bready,
	pe_0_0_S_HOST_AXI_rready,
	pe_0_0_S_HOST_AXI_wdata,
	pe_0_0_S_HOST_AXI_wlast,
	pe_0_0_S_HOST_AXI_wstrb,
	pe_0_0_S_HOST_AXI_wvalid,
	pe_0_0_S_HOST_AXI_arready,
	pe_0_0_S_HOST_AXI_awready,
	pe_0_0_S_HOST_AXI_bid,
	pe_0_0_S_HOST_AXI_bresp,
	pe_0_0_S_HOST_AXI_bvalid,
	pe_0_0_S_HOST_AXI_rdata,
	pe_0_0_S_HOST_AXI_rid,
	pe_0_0_S_HOST_AXI_rlast,
	pe_0_0_S_HOST_AXI_rresp,
	pe_0_0_S_HOST_AXI_rvalid,
	pe_0_0_S_HOST_AXI_wready,
	pe_1_0_regular_0_clk,
	pe_1_0_regular_0_rstn,
	pe_1_0_regular_1_clk,
	pe_1_0_regular_1_rstn,
	pe_1_0_nou_clk,
	pe_1_0_nou_rstn,
	pe_1_0_dsa_2_clk,
	pe_1_0_dsa_2_rstn,
	pe_1_0_dispatcher_clk,
	pe_1_0_dispatcher_rstn,
	pe_1_0_dsa_0_clk,
	pe_1_0_dsa_0_rstn,
	pe_1_0_dsa_1_clk,
	pe_1_0_dsa_1_rstn,
	pe_1_0_dsa_0_m_dsa_0_clk,
	pe_1_0_dsa_0_m_dsa_0_rstn,
	pe_1_0_dsa_1_m_dsa_1_clk,
	pe_1_0_dsa_1_m_dsa_1_rstn,
	pe_1_0_dsa_2_m_dsa_2_clk,
	pe_1_0_dsa_2_m_dsa_2_rstn,
	pe_1_0_mem_sub_sys_clk,
	pe_1_0_mem_sub_sys_rstn,
	pe_1_0_dat_E_out,
	pe_1_0_dat_vld_E_out,
	pe_1_0_dat_yummy_E_in,
	pe_1_0_dat_E_in,
	pe_1_0_dat_vld_E_in,
	pe_1_0_dat_yummy_E_out,
	pe_1_0_rsp_E_out,
	pe_1_0_rsp_vld_E_out,
	pe_1_0_rsp_yummy_E_in,
	pe_1_0_rsp_E_in,
	pe_1_0_rsp_vld_E_in,
	pe_1_0_rsp_yummy_E_out,
	pe_1_0_dat_S_out,
	pe_1_0_dat_vld_S_out,
	pe_1_0_dat_yummy_S_in,
	pe_1_0_dat_S_in,
	pe_1_0_dat_vld_S_in,
	pe_1_0_dat_yummy_S_out,
	pe_1_0_rsp_S_out,
	pe_1_0_rsp_vld_S_out,
	pe_1_0_rsp_yummy_S_in,
	pe_1_0_rsp_S_in,
	pe_1_0_rsp_vld_S_in,
	pe_1_0_rsp_yummy_S_out,
	pe_1_0_sys_clk,
	pe_1_0_sys_rstn,
	pe_1_0_S_HOST_AXI_aclk,
	pe_1_0_S_HOST_AXI_araddr,
	pe_1_0_S_HOST_AXI_arburst,
	pe_1_0_S_HOST_AXI_arcache,
	pe_1_0_S_HOST_AXI_aresetn,
	pe_1_0_S_HOST_AXI_arid,
	pe_1_0_S_HOST_AXI_arlen,
	pe_1_0_S_HOST_AXI_arlock,
	pe_1_0_S_HOST_AXI_arprot,
	pe_1_0_S_HOST_AXI_arqos,
	pe_1_0_S_HOST_AXI_arsize,
	pe_1_0_S_HOST_AXI_arvalid,
	pe_1_0_S_HOST_AXI_awaddr,
	pe_1_0_S_HOST_AXI_awburst,
	pe_1_0_S_HOST_AXI_awcache,
	pe_1_0_S_HOST_AXI_awid,
	pe_1_0_S_HOST_AXI_awlen,
	pe_1_0_S_HOST_AXI_awlock,
	pe_1_0_S_HOST_AXI_awprot,
	pe_1_0_S_HOST_AXI_awqos,
	pe_1_0_S_HOST_AXI_awsize,
	pe_1_0_S_HOST_AXI_awvalid,
	pe_1_0_S_HOST_AXI_bready,
	pe_1_0_S_HOST_AXI_rready,
	pe_1_0_S_HOST_AXI_wdata,
	pe_1_0_S_HOST_AXI_wlast,
	pe_1_0_S_HOST_AXI_wstrb,
	pe_1_0_S_HOST_AXI_wvalid,
	pe_1_0_S_HOST_AXI_arready,
	pe_1_0_S_HOST_AXI_awready,
	pe_1_0_S_HOST_AXI_bid,
	pe_1_0_S_HOST_AXI_bresp,
	pe_1_0_S_HOST_AXI_bvalid,
	pe_1_0_S_HOST_AXI_rdata,
	pe_1_0_S_HOST_AXI_rid,
	pe_1_0_S_HOST_AXI_rlast,
	pe_1_0_S_HOST_AXI_rresp,
	pe_1_0_S_HOST_AXI_rvalid,
	pe_1_0_S_HOST_AXI_wready,
	pe_0_1_regular_0_clk,
	pe_0_1_regular_0_rstn,
	pe_0_1_regular_1_clk,
	pe_0_1_regular_1_rstn,
	pe_0_1_nou_clk,
	pe_0_1_nou_rstn,
	pe_0_1_dsa_2_clk,
	pe_0_1_dsa_2_rstn,
	pe_0_1_dispatcher_clk,
	pe_0_1_dispatcher_rstn,
	pe_0_1_dsa_0_clk,
	pe_0_1_dsa_0_rstn,
	pe_0_1_dsa_1_clk,
	pe_0_1_dsa_1_rstn,
	pe_0_1_dsa_0_m_dsa_0_clk,
	pe_0_1_dsa_0_m_dsa_0_rstn,
	pe_0_1_dsa_1_m_dsa_1_clk,
	pe_0_1_dsa_1_m_dsa_1_rstn,
	pe_0_1_dsa_2_m_dsa_2_clk,
	pe_0_1_dsa_2_m_dsa_2_rstn,
	pe_0_1_mem_sub_sys_clk,
	pe_0_1_mem_sub_sys_rstn,
	pe_0_1_dat_W_out,
	pe_0_1_dat_vld_W_out,
	pe_0_1_dat_yummy_W_in,
	pe_0_1_dat_W_in,
	pe_0_1_dat_vld_W_in,
	pe_0_1_dat_yummy_W_out,
	pe_0_1_rsp_W_out,
	pe_0_1_rsp_vld_W_out,
	pe_0_1_rsp_yummy_W_in,
	pe_0_1_rsp_W_in,
	pe_0_1_rsp_vld_W_in,
	pe_0_1_rsp_yummy_W_out,
	pe_0_1_dat_N_out,
	pe_0_1_dat_vld_N_out,
	pe_0_1_dat_yummy_N_in,
	pe_0_1_dat_N_in,
	pe_0_1_dat_vld_N_in,
	pe_0_1_dat_yummy_N_out,
	pe_0_1_rsp_N_out,
	pe_0_1_rsp_vld_N_out,
	pe_0_1_rsp_yummy_N_in,
	pe_0_1_rsp_N_in,
	pe_0_1_rsp_vld_N_in,
	pe_0_1_rsp_yummy_N_out,
	pe_0_1_sys_clk,
	pe_0_1_sys_rstn,
	pe_0_1_S_HOST_AXI_aclk,
	pe_0_1_S_HOST_AXI_araddr,
	pe_0_1_S_HOST_AXI_arburst,
	pe_0_1_S_HOST_AXI_arcache,
	pe_0_1_S_HOST_AXI_aresetn,
	pe_0_1_S_HOST_AXI_arid,
	pe_0_1_S_HOST_AXI_arlen,
	pe_0_1_S_HOST_AXI_arlock,
	pe_0_1_S_HOST_AXI_arprot,
	pe_0_1_S_HOST_AXI_arqos,
	pe_0_1_S_HOST_AXI_arsize,
	pe_0_1_S_HOST_AXI_arvalid,
	pe_0_1_S_HOST_AXI_awaddr,
	pe_0_1_S_HOST_AXI_awburst,
	pe_0_1_S_HOST_AXI_awcache,
	pe_0_1_S_HOST_AXI_awid,
	pe_0_1_S_HOST_AXI_awlen,
	pe_0_1_S_HOST_AXI_awlock,
	pe_0_1_S_HOST_AXI_awprot,
	pe_0_1_S_HOST_AXI_awqos,
	pe_0_1_S_HOST_AXI_awsize,
	pe_0_1_S_HOST_AXI_awvalid,
	pe_0_1_S_HOST_AXI_bready,
	pe_0_1_S_HOST_AXI_rready,
	pe_0_1_S_HOST_AXI_wdata,
	pe_0_1_S_HOST_AXI_wlast,
	pe_0_1_S_HOST_AXI_wstrb,
	pe_0_1_S_HOST_AXI_wvalid,
	pe_0_1_S_HOST_AXI_arready,
	pe_0_1_S_HOST_AXI_awready,
	pe_0_1_S_HOST_AXI_bid,
	pe_0_1_S_HOST_AXI_bresp,
	pe_0_1_S_HOST_AXI_bvalid,
	pe_0_1_S_HOST_AXI_rdata,
	pe_0_1_S_HOST_AXI_rid,
	pe_0_1_S_HOST_AXI_rlast,
	pe_0_1_S_HOST_AXI_rresp,
	pe_0_1_S_HOST_AXI_rvalid,
	pe_0_1_S_HOST_AXI_wready,
	pe_1_1_regular_0_clk,
	pe_1_1_regular_0_rstn,
	pe_1_1_regular_1_clk,
	pe_1_1_regular_1_rstn,
	pe_1_1_nou_clk,
	pe_1_1_nou_rstn,
	pe_1_1_dsa_2_clk,
	pe_1_1_dsa_2_rstn,
	pe_1_1_dispatcher_clk,
	pe_1_1_dispatcher_rstn,
	pe_1_1_dsa_0_clk,
	pe_1_1_dsa_0_rstn,
	pe_1_1_dsa_1_clk,
	pe_1_1_dsa_1_rstn,
	pe_1_1_dsa_0_m_dsa_0_clk,
	pe_1_1_dsa_0_m_dsa_0_rstn,
	pe_1_1_dsa_1_m_dsa_1_clk,
	pe_1_1_dsa_1_m_dsa_1_rstn,
	pe_1_1_dsa_2_m_dsa_2_clk,
	pe_1_1_dsa_2_m_dsa_2_rstn,
	pe_1_1_mem_sub_sys_clk,
	pe_1_1_mem_sub_sys_rstn,
	pe_1_1_dat_E_out,
	pe_1_1_dat_vld_E_out,
	pe_1_1_dat_yummy_E_in,
	pe_1_1_dat_E_in,
	pe_1_1_dat_vld_E_in,
	pe_1_1_dat_yummy_E_out,
	pe_1_1_rsp_E_out,
	pe_1_1_rsp_vld_E_out,
	pe_1_1_rsp_yummy_E_in,
	pe_1_1_rsp_E_in,
	pe_1_1_rsp_vld_E_in,
	pe_1_1_rsp_yummy_E_out,
	pe_1_1_dat_N_out,
	pe_1_1_dat_vld_N_out,
	pe_1_1_dat_yummy_N_in,
	pe_1_1_dat_N_in,
	pe_1_1_dat_vld_N_in,
	pe_1_1_dat_yummy_N_out,
	pe_1_1_rsp_N_out,
	pe_1_1_rsp_vld_N_out,
	pe_1_1_rsp_yummy_N_in,
	pe_1_1_rsp_N_in,
	pe_1_1_rsp_vld_N_in,
	pe_1_1_rsp_yummy_N_out,
	pe_1_1_sys_clk,
	pe_1_1_sys_rstn,
	pe_1_1_S_HOST_AXI_aclk,
	pe_1_1_S_HOST_AXI_araddr,
	pe_1_1_S_HOST_AXI_arburst,
	pe_1_1_S_HOST_AXI_arcache,
	pe_1_1_S_HOST_AXI_aresetn,
	pe_1_1_S_HOST_AXI_arid,
	pe_1_1_S_HOST_AXI_arlen,
	pe_1_1_S_HOST_AXI_arlock,
	pe_1_1_S_HOST_AXI_arprot,
	pe_1_1_S_HOST_AXI_arqos,
	pe_1_1_S_HOST_AXI_arsize,
	pe_1_1_S_HOST_AXI_arvalid,
	pe_1_1_S_HOST_AXI_awaddr,
	pe_1_1_S_HOST_AXI_awburst,
	pe_1_1_S_HOST_AXI_awcache,
	pe_1_1_S_HOST_AXI_awid,
	pe_1_1_S_HOST_AXI_awlen,
	pe_1_1_S_HOST_AXI_awlock,
	pe_1_1_S_HOST_AXI_awprot,
	pe_1_1_S_HOST_AXI_awqos,
	pe_1_1_S_HOST_AXI_awsize,
	pe_1_1_S_HOST_AXI_awvalid,
	pe_1_1_S_HOST_AXI_bready,
	pe_1_1_S_HOST_AXI_rready,
	pe_1_1_S_HOST_AXI_wdata,
	pe_1_1_S_HOST_AXI_wlast,
	pe_1_1_S_HOST_AXI_wstrb,
	pe_1_1_S_HOST_AXI_wvalid,
	pe_1_1_S_HOST_AXI_arready,
	pe_1_1_S_HOST_AXI_awready,
	pe_1_1_S_HOST_AXI_bid,
	pe_1_1_S_HOST_AXI_bresp,
	pe_1_1_S_HOST_AXI_bvalid,
	pe_1_1_S_HOST_AXI_rdata,
	pe_1_1_S_HOST_AXI_rid,
	pe_1_1_S_HOST_AXI_rlast,
	pe_1_1_S_HOST_AXI_rresp,
	pe_1_1_S_HOST_AXI_rvalid,
	pe_1_1_S_HOST_AXI_wready
);

// &Ports; @17
input   [0:0]                           pe_0_0_regular_0_clk;    
input   [0:0]                           pe_0_0_regular_0_rstn;   
input   [0:0]                           pe_0_0_regular_1_clk;    
input   [0:0]                           pe_0_0_regular_1_rstn;   
input   [0:0]                           pe_0_0_nou_clk;          
input   [0:0]                           pe_0_0_nou_rstn;         
input   [0:0]                           pe_0_0_dsa_2_clk;        
input   [0:0]                           pe_0_0_dsa_2_rstn;       
input   [0:0]                           pe_0_0_dispatcher_clk;   
input   [0:0]                           pe_0_0_dispatcher_rstn;  
input   [0:0]                           pe_0_0_dsa_0_clk;        
input   [0:0]                           pe_0_0_dsa_0_rstn;       
input   [0:0]                           pe_0_0_dsa_1_clk;        
input   [0:0]                           pe_0_0_dsa_1_rstn;       
input   [0:0]                           pe_0_0_dsa_0_m_dsa_0_clk;
input   [0:0]                           pe_0_0_dsa_0_m_dsa_0_rstn;
input   [0:0]                           pe_0_0_dsa_1_m_dsa_1_clk;
input   [0:0]                           pe_0_0_dsa_1_m_dsa_1_rstn;
input   [0:0]                           pe_0_0_dsa_2_m_dsa_2_clk;
input   [0:0]                           pe_0_0_dsa_2_m_dsa_2_rstn;
input   [0:0]                           pe_0_0_mem_sub_sys_clk;  
input   [0:0]                           pe_0_0_mem_sub_sys_rstn; 
output  [`DATA_WIDTH-1:0]               pe_0_0_dat_W_out;        
output  [0:0]                           pe_0_0_dat_vld_W_out;    
input   [0:0]                           pe_0_0_dat_yummy_W_in;   
input   [`DATA_WIDTH-1:0]               pe_0_0_dat_W_in;         
input   [0:0]                           pe_0_0_dat_vld_W_in;     
output  [0:0]                           pe_0_0_dat_yummy_W_out;  
output  [`RSP_WIDTH-1:0]                pe_0_0_rsp_W_out;        
output  [0:0]                           pe_0_0_rsp_vld_W_out;    
input   [0:0]                           pe_0_0_rsp_yummy_W_in;   
input   [`RSP_WIDTH-1:0]                pe_0_0_rsp_W_in;         
input   [0:0]                           pe_0_0_rsp_vld_W_in;     
output  [0:0]                           pe_0_0_rsp_yummy_W_out;  
output  [`DATA_WIDTH-1:0]               pe_0_0_dat_S_out;        
output  [0:0]                           pe_0_0_dat_vld_S_out;    
input   [0:0]                           pe_0_0_dat_yummy_S_in;   
input   [`DATA_WIDTH-1:0]               pe_0_0_dat_S_in;         
input   [0:0]                           pe_0_0_dat_vld_S_in;     
output  [0:0]                           pe_0_0_dat_yummy_S_out;  
output  [`RSP_WIDTH-1:0]                pe_0_0_rsp_S_out;        
output  [0:0]                           pe_0_0_rsp_vld_S_out;    
input   [0:0]                           pe_0_0_rsp_yummy_S_in;   
input   [`RSP_WIDTH-1:0]                pe_0_0_rsp_S_in;         
input   [0:0]                           pe_0_0_rsp_vld_S_in;     
output  [0:0]                           pe_0_0_rsp_yummy_S_out;  
input   [0:0]                           pe_0_0_sys_clk;          
input   [0:0]                           pe_0_0_sys_rstn;         
input   [0:0]                           pe_0_0_S_HOST_AXI_aclk;  
input   [31:0]                          pe_0_0_S_HOST_AXI_araddr;
input   [1:0]                           pe_0_0_S_HOST_AXI_arburst;
input   [3:0]                           pe_0_0_S_HOST_AXI_arcache;
input   [0:0]                           pe_0_0_S_HOST_AXI_aresetn;
input   [`AXI_MASTER_ID_WIDTH-1:0]      pe_0_0_S_HOST_AXI_arid;  
input   [7:0]                           pe_0_0_S_HOST_AXI_arlen; 
input   [0:0]                           pe_0_0_S_HOST_AXI_arlock;
input   [2:0]                           pe_0_0_S_HOST_AXI_arprot;
input   [3:0]                           pe_0_0_S_HOST_AXI_arqos; 
input   [2:0]                           pe_0_0_S_HOST_AXI_arsize;
input   [0:0]                           pe_0_0_S_HOST_AXI_arvalid;
input   [31:0]                          pe_0_0_S_HOST_AXI_awaddr;
input   [1:0]                           pe_0_0_S_HOST_AXI_awburst;
input   [3:0]                           pe_0_0_S_HOST_AXI_awcache;
input   [`AXI_MASTER_ID_WIDTH-1:0]      pe_0_0_S_HOST_AXI_awid;  
input   [7:0]                           pe_0_0_S_HOST_AXI_awlen; 
input   [0:0]                           pe_0_0_S_HOST_AXI_awlock;
input   [2:0]                           pe_0_0_S_HOST_AXI_awprot;
input   [3:0]                           pe_0_0_S_HOST_AXI_awqos; 
input   [2:0]                           pe_0_0_S_HOST_AXI_awsize;
input   [0:0]                           pe_0_0_S_HOST_AXI_awvalid;
input   [0:0]                           pe_0_0_S_HOST_AXI_bready;
input   [0:0]                           pe_0_0_S_HOST_AXI_rready;
input   [1023:0]                        pe_0_0_S_HOST_AXI_wdata; 
input   [0:0]                           pe_0_0_S_HOST_AXI_wlast; 
input   [127:0]                         pe_0_0_S_HOST_AXI_wstrb; 
input   [0:0]                           pe_0_0_S_HOST_AXI_wvalid;
output  [0:0]                           pe_0_0_S_HOST_AXI_arready;
output  [0:0]                           pe_0_0_S_HOST_AXI_awready;
output  [`AXI_MASTER_ID_WIDTH-1:0]      pe_0_0_S_HOST_AXI_bid;   
output  [1:0]                           pe_0_0_S_HOST_AXI_bresp; 
output  [0:0]                           pe_0_0_S_HOST_AXI_bvalid;
output  [1023:0]                        pe_0_0_S_HOST_AXI_rdata; 
output  [`AXI_MASTER_ID_WIDTH-1:0]      pe_0_0_S_HOST_AXI_rid;   
output  [0:0]                           pe_0_0_S_HOST_AXI_rlast; 
output  [1:0]                           pe_0_0_S_HOST_AXI_rresp; 
output  [0:0]                           pe_0_0_S_HOST_AXI_rvalid;
output  [0:0]                           pe_0_0_S_HOST_AXI_wready;
input   [0:0]                           pe_1_0_regular_0_clk;    
input   [0:0]                           pe_1_0_regular_0_rstn;   
input   [0:0]                           pe_1_0_regular_1_clk;    
input   [0:0]                           pe_1_0_regular_1_rstn;   
input   [0:0]                           pe_1_0_nou_clk;          
input   [0:0]                           pe_1_0_nou_rstn;         
input   [0:0]                           pe_1_0_dsa_2_clk;        
input   [0:0]                           pe_1_0_dsa_2_rstn;       
input   [0:0]                           pe_1_0_dispatcher_clk;   
input   [0:0]                           pe_1_0_dispatcher_rstn;  
input   [0:0]                           pe_1_0_dsa_0_clk;        
input   [0:0]                           pe_1_0_dsa_0_rstn;       
input   [0:0]                           pe_1_0_dsa_1_clk;        
input   [0:0]                           pe_1_0_dsa_1_rstn;       
input   [0:0]                           pe_1_0_dsa_0_m_dsa_0_clk;
input   [0:0]                           pe_1_0_dsa_0_m_dsa_0_rstn;
input   [0:0]                           pe_1_0_dsa_1_m_dsa_1_clk;
input   [0:0]                           pe_1_0_dsa_1_m_dsa_1_rstn;
input   [0:0]                           pe_1_0_dsa_2_m_dsa_2_clk;
input   [0:0]                           pe_1_0_dsa_2_m_dsa_2_rstn;
input   [0:0]                           pe_1_0_mem_sub_sys_clk;  
input   [0:0]                           pe_1_0_mem_sub_sys_rstn; 
output  [`DATA_WIDTH-1:0]               pe_1_0_dat_E_out;        
output  [0:0]                           pe_1_0_dat_vld_E_out;    
input   [0:0]                           pe_1_0_dat_yummy_E_in;   
input   [`DATA_WIDTH-1:0]               pe_1_0_dat_E_in;         
input   [0:0]                           pe_1_0_dat_vld_E_in;     
output  [0:0]                           pe_1_0_dat_yummy_E_out;  
output  [`RSP_WIDTH-1:0]                pe_1_0_rsp_E_out;        
output  [0:0]                           pe_1_0_rsp_vld_E_out;    
input   [0:0]                           pe_1_0_rsp_yummy_E_in;   
input   [`RSP_WIDTH-1:0]                pe_1_0_rsp_E_in;         
input   [0:0]                           pe_1_0_rsp_vld_E_in;     
output  [0:0]                           pe_1_0_rsp_yummy_E_out;  
output  [`DATA_WIDTH-1:0]               pe_1_0_dat_S_out;        
output  [0:0]                           pe_1_0_dat_vld_S_out;    
input   [0:0]                           pe_1_0_dat_yummy_S_in;   
input   [`DATA_WIDTH-1:0]               pe_1_0_dat_S_in;         
input   [0:0]                           pe_1_0_dat_vld_S_in;     
output  [0:0]                           pe_1_0_dat_yummy_S_out;  
output  [`RSP_WIDTH-1:0]                pe_1_0_rsp_S_out;        
output  [0:0]                           pe_1_0_rsp_vld_S_out;    
input   [0:0]                           pe_1_0_rsp_yummy_S_in;   
input   [`RSP_WIDTH-1:0]                pe_1_0_rsp_S_in;         
input   [0:0]                           pe_1_0_rsp_vld_S_in;     
output  [0:0]                           pe_1_0_rsp_yummy_S_out;  
input   [0:0]                           pe_1_0_sys_clk;          
input   [0:0]                           pe_1_0_sys_rstn;         
input   [0:0]                           pe_1_0_S_HOST_AXI_aclk;  
input   [31:0]                          pe_1_0_S_HOST_AXI_araddr;
input   [1:0]                           pe_1_0_S_HOST_AXI_arburst;
input   [3:0]                           pe_1_0_S_HOST_AXI_arcache;
input   [0:0]                           pe_1_0_S_HOST_AXI_aresetn;
input   [`AXI_MASTER_ID_WIDTH-1:0]      pe_1_0_S_HOST_AXI_arid;  
input   [7:0]                           pe_1_0_S_HOST_AXI_arlen; 
input   [0:0]                           pe_1_0_S_HOST_AXI_arlock;
input   [2:0]                           pe_1_0_S_HOST_AXI_arprot;
input   [3:0]                           pe_1_0_S_HOST_AXI_arqos; 
input   [2:0]                           pe_1_0_S_HOST_AXI_arsize;
input   [0:0]                           pe_1_0_S_HOST_AXI_arvalid;
input   [31:0]                          pe_1_0_S_HOST_AXI_awaddr;
input   [1:0]                           pe_1_0_S_HOST_AXI_awburst;
input   [3:0]                           pe_1_0_S_HOST_AXI_awcache;
input   [`AXI_MASTER_ID_WIDTH-1:0]      pe_1_0_S_HOST_AXI_awid;  
input   [7:0]                           pe_1_0_S_HOST_AXI_awlen; 
input   [0:0]                           pe_1_0_S_HOST_AXI_awlock;
input   [2:0]                           pe_1_0_S_HOST_AXI_awprot;
input   [3:0]                           pe_1_0_S_HOST_AXI_awqos; 
input   [2:0]                           pe_1_0_S_HOST_AXI_awsize;
input   [0:0]                           pe_1_0_S_HOST_AXI_awvalid;
input   [0:0]                           pe_1_0_S_HOST_AXI_bready;
input   [0:0]                           pe_1_0_S_HOST_AXI_rready;
input   [1023:0]                        pe_1_0_S_HOST_AXI_wdata; 
input   [0:0]                           pe_1_0_S_HOST_AXI_wlast; 
input   [127:0]                         pe_1_0_S_HOST_AXI_wstrb; 
input   [0:0]                           pe_1_0_S_HOST_AXI_wvalid;
output  [0:0]                           pe_1_0_S_HOST_AXI_arready;
output  [0:0]                           pe_1_0_S_HOST_AXI_awready;
output  [`AXI_MASTER_ID_WIDTH-1:0]      pe_1_0_S_HOST_AXI_bid;   
output  [1:0]                           pe_1_0_S_HOST_AXI_bresp; 
output  [0:0]                           pe_1_0_S_HOST_AXI_bvalid;
output  [1023:0]                        pe_1_0_S_HOST_AXI_rdata; 
output  [`AXI_MASTER_ID_WIDTH-1:0]      pe_1_0_S_HOST_AXI_rid;   
output  [0:0]                           pe_1_0_S_HOST_AXI_rlast; 
output  [1:0]                           pe_1_0_S_HOST_AXI_rresp; 
output  [0:0]                           pe_1_0_S_HOST_AXI_rvalid;
output  [0:0]                           pe_1_0_S_HOST_AXI_wready;
input   [0:0]                           pe_0_1_regular_0_clk;    
input   [0:0]                           pe_0_1_regular_0_rstn;   
input   [0:0]                           pe_0_1_regular_1_clk;    
input   [0:0]                           pe_0_1_regular_1_rstn;   
input   [0:0]                           pe_0_1_nou_clk;          
input   [0:0]                           pe_0_1_nou_rstn;         
input   [0:0]                           pe_0_1_dsa_2_clk;        
input   [0:0]                           pe_0_1_dsa_2_rstn;       
input   [0:0]                           pe_0_1_dispatcher_clk;   
input   [0:0]                           pe_0_1_dispatcher_rstn;  
input   [0:0]                           pe_0_1_dsa_0_clk;        
input   [0:0]                           pe_0_1_dsa_0_rstn;       
input   [0:0]                           pe_0_1_dsa_1_clk;        
input   [0:0]                           pe_0_1_dsa_1_rstn;       
input   [0:0]                           pe_0_1_dsa_0_m_dsa_0_clk;
input   [0:0]                           pe_0_1_dsa_0_m_dsa_0_rstn;
input   [0:0]                           pe_0_1_dsa_1_m_dsa_1_clk;
input   [0:0]                           pe_0_1_dsa_1_m_dsa_1_rstn;
input   [0:0]                           pe_0_1_dsa_2_m_dsa_2_clk;
input   [0:0]                           pe_0_1_dsa_2_m_dsa_2_rstn;
input   [0:0]                           pe_0_1_mem_sub_sys_clk;  
input   [0:0]                           pe_0_1_mem_sub_sys_rstn; 
output  [`DATA_WIDTH-1:0]               pe_0_1_dat_W_out;        
output  [0:0]                           pe_0_1_dat_vld_W_out;    
input   [0:0]                           pe_0_1_dat_yummy_W_in;   
input   [`DATA_WIDTH-1:0]               pe_0_1_dat_W_in;         
input   [0:0]                           pe_0_1_dat_vld_W_in;     
output  [0:0]                           pe_0_1_dat_yummy_W_out;  
output  [`RSP_WIDTH-1:0]                pe_0_1_rsp_W_out;        
output  [0:0]                           pe_0_1_rsp_vld_W_out;    
input   [0:0]                           pe_0_1_rsp_yummy_W_in;   
input   [`RSP_WIDTH-1:0]                pe_0_1_rsp_W_in;         
input   [0:0]                           pe_0_1_rsp_vld_W_in;     
output  [0:0]                           pe_0_1_rsp_yummy_W_out;  
output  [`DATA_WIDTH-1:0]               pe_0_1_dat_N_out;        
output  [0:0]                           pe_0_1_dat_vld_N_out;    
input   [0:0]                           pe_0_1_dat_yummy_N_in;   
input   [`DATA_WIDTH-1:0]               pe_0_1_dat_N_in;         
input   [0:0]                           pe_0_1_dat_vld_N_in;     
output  [0:0]                           pe_0_1_dat_yummy_N_out;  
output  [`RSP_WIDTH-1:0]                pe_0_1_rsp_N_out;        
output  [0:0]                           pe_0_1_rsp_vld_N_out;    
input   [0:0]                           pe_0_1_rsp_yummy_N_in;   
input   [`RSP_WIDTH-1:0]                pe_0_1_rsp_N_in;         
input   [0:0]                           pe_0_1_rsp_vld_N_in;     
output  [0:0]                           pe_0_1_rsp_yummy_N_out;  
input   [0:0]                           pe_0_1_sys_clk;          
input   [0:0]                           pe_0_1_sys_rstn;         
input   [0:0]                           pe_0_1_S_HOST_AXI_aclk;  
input   [31:0]                          pe_0_1_S_HOST_AXI_araddr;
input   [1:0]                           pe_0_1_S_HOST_AXI_arburst;
input   [3:0]                           pe_0_1_S_HOST_AXI_arcache;
input   [0:0]                           pe_0_1_S_HOST_AXI_aresetn;
input   [`AXI_MASTER_ID_WIDTH-1:0]      pe_0_1_S_HOST_AXI_arid;  
input   [7:0]                           pe_0_1_S_HOST_AXI_arlen; 
input   [0:0]                           pe_0_1_S_HOST_AXI_arlock;
input   [2:0]                           pe_0_1_S_HOST_AXI_arprot;
input   [3:0]                           pe_0_1_S_HOST_AXI_arqos; 
input   [2:0]                           pe_0_1_S_HOST_AXI_arsize;
input   [0:0]                           pe_0_1_S_HOST_AXI_arvalid;
input   [31:0]                          pe_0_1_S_HOST_AXI_awaddr;
input   [1:0]                           pe_0_1_S_HOST_AXI_awburst;
input   [3:0]                           pe_0_1_S_HOST_AXI_awcache;
input   [`AXI_MASTER_ID_WIDTH-1:0]      pe_0_1_S_HOST_AXI_awid;  
input   [7:0]                           pe_0_1_S_HOST_AXI_awlen; 
input   [0:0]                           pe_0_1_S_HOST_AXI_awlock;
input   [2:0]                           pe_0_1_S_HOST_AXI_awprot;
input   [3:0]                           pe_0_1_S_HOST_AXI_awqos; 
input   [2:0]                           pe_0_1_S_HOST_AXI_awsize;
input   [0:0]                           pe_0_1_S_HOST_AXI_awvalid;
input   [0:0]                           pe_0_1_S_HOST_AXI_bready;
input   [0:0]                           pe_0_1_S_HOST_AXI_rready;
input   [1023:0]                        pe_0_1_S_HOST_AXI_wdata; 
input   [0:0]                           pe_0_1_S_HOST_AXI_wlast; 
input   [127:0]                         pe_0_1_S_HOST_AXI_wstrb; 
input   [0:0]                           pe_0_1_S_HOST_AXI_wvalid;
output  [0:0]                           pe_0_1_S_HOST_AXI_arready;
output  [0:0]                           pe_0_1_S_HOST_AXI_awready;
output  [`AXI_MASTER_ID_WIDTH-1:0]      pe_0_1_S_HOST_AXI_bid;   
output  [1:0]                           pe_0_1_S_HOST_AXI_bresp; 
output  [0:0]                           pe_0_1_S_HOST_AXI_bvalid;
output  [1023:0]                        pe_0_1_S_HOST_AXI_rdata; 
output  [`AXI_MASTER_ID_WIDTH-1:0]      pe_0_1_S_HOST_AXI_rid;   
output  [0:0]                           pe_0_1_S_HOST_AXI_rlast; 
output  [1:0]                           pe_0_1_S_HOST_AXI_rresp; 
output  [0:0]                           pe_0_1_S_HOST_AXI_rvalid;
output  [0:0]                           pe_0_1_S_HOST_AXI_wready;
input   [0:0]                           pe_1_1_regular_0_clk;    
input   [0:0]                           pe_1_1_regular_0_rstn;   
input   [0:0]                           pe_1_1_regular_1_clk;    
input   [0:0]                           pe_1_1_regular_1_rstn;   
input   [0:0]                           pe_1_1_nou_clk;          
input   [0:0]                           pe_1_1_nou_rstn;         
input   [0:0]                           pe_1_1_dsa_2_clk;        
input   [0:0]                           pe_1_1_dsa_2_rstn;       
input   [0:0]                           pe_1_1_dispatcher_clk;   
input   [0:0]                           pe_1_1_dispatcher_rstn;  
input   [0:0]                           pe_1_1_dsa_0_clk;        
input   [0:0]                           pe_1_1_dsa_0_rstn;       
input   [0:0]                           pe_1_1_dsa_1_clk;        
input   [0:0]                           pe_1_1_dsa_1_rstn;       
input   [0:0]                           pe_1_1_dsa_0_m_dsa_0_clk;
input   [0:0]                           pe_1_1_dsa_0_m_dsa_0_rstn;
input   [0:0]                           pe_1_1_dsa_1_m_dsa_1_clk;
input   [0:0]                           pe_1_1_dsa_1_m_dsa_1_rstn;
input   [0:0]                           pe_1_1_dsa_2_m_dsa_2_clk;
input   [0:0]                           pe_1_1_dsa_2_m_dsa_2_rstn;
input   [0:0]                           pe_1_1_mem_sub_sys_clk;  
input   [0:0]                           pe_1_1_mem_sub_sys_rstn; 
output  [`DATA_WIDTH-1:0]               pe_1_1_dat_E_out;        
output  [0:0]                           pe_1_1_dat_vld_E_out;    
input   [0:0]                           pe_1_1_dat_yummy_E_in;   
input   [`DATA_WIDTH-1:0]               pe_1_1_dat_E_in;         
input   [0:0]                           pe_1_1_dat_vld_E_in;     
output  [0:0]                           pe_1_1_dat_yummy_E_out;  
output  [`RSP_WIDTH-1:0]                pe_1_1_rsp_E_out;        
output  [0:0]                           pe_1_1_rsp_vld_E_out;    
input   [0:0]                           pe_1_1_rsp_yummy_E_in;   
input   [`RSP_WIDTH-1:0]                pe_1_1_rsp_E_in;         
input   [0:0]                           pe_1_1_rsp_vld_E_in;     
output  [0:0]                           pe_1_1_rsp_yummy_E_out;  
output  [`DATA_WIDTH-1:0]               pe_1_1_dat_N_out;        
output  [0:0]                           pe_1_1_dat_vld_N_out;    
input   [0:0]                           pe_1_1_dat_yummy_N_in;   
input   [`DATA_WIDTH-1:0]               pe_1_1_dat_N_in;         
input   [0:0]                           pe_1_1_dat_vld_N_in;     
output  [0:0]                           pe_1_1_dat_yummy_N_out;  
output  [`RSP_WIDTH-1:0]                pe_1_1_rsp_N_out;        
output  [0:0]                           pe_1_1_rsp_vld_N_out;    
input   [0:0]                           pe_1_1_rsp_yummy_N_in;   
input   [`RSP_WIDTH-1:0]                pe_1_1_rsp_N_in;         
input   [0:0]                           pe_1_1_rsp_vld_N_in;     
output  [0:0]                           pe_1_1_rsp_yummy_N_out;  
input   [0:0]                           pe_1_1_sys_clk;          
input   [0:0]                           pe_1_1_sys_rstn;         
input   [0:0]                           pe_1_1_S_HOST_AXI_aclk;  
input   [31:0]                          pe_1_1_S_HOST_AXI_araddr;
input   [1:0]                           pe_1_1_S_HOST_AXI_arburst;
input   [3:0]                           pe_1_1_S_HOST_AXI_arcache;
input   [0:0]                           pe_1_1_S_HOST_AXI_aresetn;
input   [`AXI_MASTER_ID_WIDTH-1:0]      pe_1_1_S_HOST_AXI_arid;  
input   [7:0]                           pe_1_1_S_HOST_AXI_arlen; 
input   [0:0]                           pe_1_1_S_HOST_AXI_arlock;
input   [2:0]                           pe_1_1_S_HOST_AXI_arprot;
input   [3:0]                           pe_1_1_S_HOST_AXI_arqos; 
input   [2:0]                           pe_1_1_S_HOST_AXI_arsize;
input   [0:0]                           pe_1_1_S_HOST_AXI_arvalid;
input   [31:0]                          pe_1_1_S_HOST_AXI_awaddr;
input   [1:0]                           pe_1_1_S_HOST_AXI_awburst;
input   [3:0]                           pe_1_1_S_HOST_AXI_awcache;
input   [`AXI_MASTER_ID_WIDTH-1:0]      pe_1_1_S_HOST_AXI_awid;  
input   [7:0]                           pe_1_1_S_HOST_AXI_awlen; 
input   [0:0]                           pe_1_1_S_HOST_AXI_awlock;
input   [2:0]                           pe_1_1_S_HOST_AXI_awprot;
input   [3:0]                           pe_1_1_S_HOST_AXI_awqos; 
input   [2:0]                           pe_1_1_S_HOST_AXI_awsize;
input   [0:0]                           pe_1_1_S_HOST_AXI_awvalid;
input   [0:0]                           pe_1_1_S_HOST_AXI_bready;
input   [0:0]                           pe_1_1_S_HOST_AXI_rready;
input   [1023:0]                        pe_1_1_S_HOST_AXI_wdata; 
input   [0:0]                           pe_1_1_S_HOST_AXI_wlast; 
input   [127:0]                         pe_1_1_S_HOST_AXI_wstrb; 
input   [0:0]                           pe_1_1_S_HOST_AXI_wvalid;
output  [0:0]                           pe_1_1_S_HOST_AXI_arready;
output  [0:0]                           pe_1_1_S_HOST_AXI_awready;
output  [`AXI_MASTER_ID_WIDTH-1:0]      pe_1_1_S_HOST_AXI_bid;   
output  [1:0]                           pe_1_1_S_HOST_AXI_bresp; 
output  [0:0]                           pe_1_1_S_HOST_AXI_bvalid;
output  [1023:0]                        pe_1_1_S_HOST_AXI_rdata; 
output  [`AXI_MASTER_ID_WIDTH-1:0]      pe_1_1_S_HOST_AXI_rid;   
output  [0:0]                           pe_1_1_S_HOST_AXI_rlast; 
output  [1:0]                           pe_1_1_S_HOST_AXI_rresp; 
output  [0:0]                           pe_1_1_S_HOST_AXI_rvalid;
output  [0:0]                           pe_1_1_S_HOST_AXI_wready;

wire    [`DATA_WIDTH-1:0]     pe_0_0_to_pe_1_0_dat;     
wire    [0:0]                 pe_1_0_to_pe_0_0_dat_vld; 
wire    [0:0]                 pe_1_0_to_pe_0_0_rsp_vld; 
wire    [`RSP_WIDTH-1:0]      pe_0_0_to_pe_1_0_rsp;     
wire    [`DATA_WIDTH-1:0]     pe_1_0_to_pe_0_0_dat;     
wire    [0:0]                 pe_1_0_to_pe_0_0_dat_yummy;
wire    [0:0]                 pe_0_0_to_pe_1_0_dat_vld; 
wire    [0:0]                 pe_0_0_to_pe_1_0_dat_yummy;
wire    [`RSP_WIDTH-1:0]      pe_1_0_to_pe_0_0_rsp;     
wire    [0:0]                 pe_0_0_to_pe_1_0_rsp_vld; 
wire    [0:0]                 pe_0_0_to_pe_1_0_rsp_yummy;
wire    [0:0]                 pe_1_0_to_pe_0_0_rsp_yummy;
wire    [`RSP_WIDTH-1:0]      pe_0_0_to_pe_0_1_rsp;     
wire    [0:0]                 pe_0_0_to_pe_0_1_rsp_vld; 
wire    [0:0]                 pe_0_1_to_pe_0_0_rsp_vld; 
wire    [0:0]                 pe_0_1_to_pe_0_0_dat_vld; 
wire    [0:0]                 pe_0_0_to_pe_0_1_dat_vld; 
wire    [0:0]                 pe_0_0_to_pe_0_1_rsp_yummy;
wire    [0:0]                 pe_0_1_to_pe_0_0_rsp_yummy;
wire    [`RSP_WIDTH-1:0]      pe_0_1_to_pe_0_0_rsp;     
wire    [0:0]                 pe_0_1_to_pe_0_0_dat_yummy;
wire    [`DATA_WIDTH-1:0]     pe_0_1_to_pe_0_0_dat;     
wire    [`DATA_WIDTH-1:0]     pe_0_0_to_pe_0_1_dat;     
wire    [0:0]                 pe_0_0_to_pe_0_1_dat_yummy;
wire    [0:0]                 pe_1_1_to_pe_1_0_dat_yummy;
wire    [0:0]                 pe_1_0_to_pe_1_1_dat_vld; 
wire    [0:0]                 pe_1_1_to_pe_1_0_dat_vld; 
wire    [0:0]                 pe_1_0_to_pe_1_1_rsp_vld; 
wire    [0:0]                 pe_1_1_to_pe_1_0_rsp_yummy;
wire    [`DATA_WIDTH-1:0]     pe_1_0_to_pe_1_1_dat;     
wire    [`RSP_WIDTH-1:0]      pe_1_1_to_pe_1_0_rsp;     
wire    [`DATA_WIDTH-1:0]     pe_1_1_to_pe_1_0_dat;     
wire    [0:0]                 pe_1_0_to_pe_1_1_rsp_yummy;
wire    [0:0]                 pe_1_0_to_pe_1_1_dat_yummy;
wire    [`RSP_WIDTH-1:0]      pe_1_0_to_pe_1_1_rsp;     
wire    [0:0]                 pe_1_1_to_pe_1_0_rsp_vld; 
wire    [0:0]                 pe_0_1_to_pe_1_1_rsp_yummy;
wire    [0:0]                 pe_0_1_to_pe_1_1_rsp_vld; 
wire    [0:0]                 pe_0_1_to_pe_1_1_dat_vld; 
wire    [0:0]                 pe_0_1_to_pe_1_1_dat_yummy;
wire    [0:0]                 pe_1_1_to_pe_0_1_dat_vld; 
wire    [`RSP_WIDTH-1:0]      pe_0_1_to_pe_1_1_rsp;     
wire    [0:0]                 pe_1_1_to_pe_0_1_rsp_vld; 
wire    [`DATA_WIDTH-1:0]     pe_0_1_to_pe_1_1_dat;     
wire    [0:0]                 pe_1_1_to_pe_0_1_rsp_yummy;
wire    [`RSP_WIDTH-1:0]      pe_1_1_to_pe_0_1_rsp;     
wire    [`DATA_WIDTH-1:0]     pe_1_1_to_pe_0_1_dat;     
wire    [0:0]                 pe_1_1_to_pe_0_1_dat_yummy;
wire    [`XY_WIDTH-1:0]       pe_0_0_myLocX;            
wire    [`XY_WIDTH-1:0]       pe_0_0_myLocY;            
wire    [`CHIP_ID_WIDTH-1:0]  pe_0_0_myChipID;          
wire    [`XY_WIDTH-1:0]       pe_1_0_myLocX;            
wire    [`XY_WIDTH-1:0]       pe_1_0_myLocY;            
wire    [`CHIP_ID_WIDTH-1:0]  pe_1_0_myChipID;          
wire    [`XY_WIDTH-1:0]       pe_0_1_myLocX;            
wire    [`XY_WIDTH-1:0]       pe_0_1_myLocY;            
wire    [`CHIP_ID_WIDTH-1:0]  pe_0_1_myChipID;          
wire    [`XY_WIDTH-1:0]       pe_1_1_myLocX;            
wire    [`XY_WIDTH-1:0]       pe_1_1_myLocY;            
wire    [`CHIP_ID_WIDTH-1:0]  pe_1_1_myChipID;          


// &Instance("pe_top", "x_pe_0_0_pe_top"); @19
pe_top x_pe_0_0_pe_top (
	.regular_0_clk     (pe_0_0_regular_0_clk      ),
	.regular_0_rstn    (pe_0_0_regular_0_rstn     ),
	.regular_1_clk     (pe_0_0_regular_1_clk      ),
	.regular_1_rstn    (pe_0_0_regular_1_rstn     ),
	.nou_clk           (pe_0_0_nou_clk            ),
	.nou_rstn          (pe_0_0_nou_rstn           ),
	.dsa_2_clk         (pe_0_0_dsa_2_clk          ),
	.dsa_2_rstn        (pe_0_0_dsa_2_rstn         ),
	.dispatcher_clk    (pe_0_0_dispatcher_clk     ),
	.dispatcher_rstn   (pe_0_0_dispatcher_rstn    ),
	.dsa_0_clk         (pe_0_0_dsa_0_clk          ),
	.dsa_0_rstn        (pe_0_0_dsa_0_rstn         ),
	.dsa_1_clk         (pe_0_0_dsa_1_clk          ),
	.dsa_1_rstn        (pe_0_0_dsa_1_rstn         ),
	.dsa_0_m_dsa_0_clk (pe_0_0_dsa_0_m_dsa_0_clk  ),
	.dsa_0_m_dsa_0_rstn(pe_0_0_dsa_0_m_dsa_0_rstn ),
	.dsa_1_m_dsa_1_clk (pe_0_0_dsa_1_m_dsa_1_clk  ),
	.dsa_1_m_dsa_1_rstn(pe_0_0_dsa_1_m_dsa_1_rstn ),
	.dsa_2_m_dsa_2_clk (pe_0_0_dsa_2_m_dsa_2_clk  ),
	.dsa_2_m_dsa_2_rstn(pe_0_0_dsa_2_m_dsa_2_rstn ),
	.mem_sub_sys_clk   (pe_0_0_mem_sub_sys_clk    ),
	.mem_sub_sys_rstn  (pe_0_0_mem_sub_sys_rstn   ),
	.myLocX            (pe_0_0_myLocX             ),
	.myLocY            (pe_0_0_myLocY             ),
	.myChipID          (pe_0_0_myChipID           ),
	.dat_W_out         (pe_0_0_dat_W_out          ),
	.dat_vld_W_out     (pe_0_0_dat_vld_W_out      ),
	.dat_yummy_W_in    (pe_0_0_dat_yummy_W_in     ),
	.dat_W_in          (pe_0_0_dat_W_in           ),
	.dat_vld_W_in      (pe_0_0_dat_vld_W_in       ),
	.dat_yummy_W_out   (pe_0_0_dat_yummy_W_out    ),
	.rsp_W_out         (pe_0_0_rsp_W_out          ),
	.rsp_vld_W_out     (pe_0_0_rsp_vld_W_out      ),
	.rsp_yummy_W_in    (pe_0_0_rsp_yummy_W_in     ),
	.rsp_W_in          (pe_0_0_rsp_W_in           ),
	.rsp_vld_W_in      (pe_0_0_rsp_vld_W_in       ),
	.rsp_yummy_W_out   (pe_0_0_rsp_yummy_W_out    ),
	.dat_E_out         (pe_0_0_to_pe_1_0_dat      ),
	.dat_vld_E_out     (pe_0_0_to_pe_1_0_dat_vld  ),
	.dat_yummy_E_in    (pe_1_0_to_pe_0_0_dat_yummy),
	.dat_E_in          (pe_1_0_to_pe_0_0_dat      ),
	.dat_vld_E_in      (pe_1_0_to_pe_0_0_dat_vld  ),
	.dat_yummy_E_out   (pe_0_0_to_pe_1_0_dat_yummy),
	.rsp_E_out         (pe_0_0_to_pe_1_0_rsp      ),
	.rsp_vld_E_out     (pe_0_0_to_pe_1_0_rsp_vld  ),
	.rsp_yummy_E_in    (pe_1_0_to_pe_0_0_rsp_yummy),
	.rsp_E_in          (pe_1_0_to_pe_0_0_rsp      ),
	.rsp_vld_E_in      (pe_1_0_to_pe_0_0_rsp_vld  ),
	.rsp_yummy_E_out   (pe_0_0_to_pe_1_0_rsp_yummy),
	.dat_N_out         (pe_0_0_to_pe_0_1_dat      ),
	.dat_vld_N_out     (pe_0_0_to_pe_0_1_dat_vld  ),
	.dat_yummy_N_in    (pe_0_1_to_pe_0_0_dat_yummy),
	.dat_N_in          (pe_0_1_to_pe_0_0_dat      ),
	.dat_vld_N_in      (pe_0_1_to_pe_0_0_dat_vld  ),
	.dat_yummy_N_out   (pe_0_0_to_pe_0_1_dat_yummy),
	.rsp_N_out         (pe_0_0_to_pe_0_1_rsp      ),
	.rsp_vld_N_out     (pe_0_0_to_pe_0_1_rsp_vld  ),
	.rsp_yummy_N_in    (pe_0_1_to_pe_0_0_rsp_yummy),
	.rsp_N_in          (pe_0_1_to_pe_0_0_rsp      ),
	.rsp_vld_N_in      (pe_0_1_to_pe_0_0_rsp_vld  ),
	.rsp_yummy_N_out   (pe_0_0_to_pe_0_1_rsp_yummy),
	.dat_S_out         (pe_0_0_dat_S_out          ),
	.dat_vld_S_out     (pe_0_0_dat_vld_S_out      ),
	.dat_yummy_S_in    (pe_0_0_dat_yummy_S_in     ),
	.dat_S_in          (pe_0_0_dat_S_in           ),
	.dat_vld_S_in      (pe_0_0_dat_vld_S_in       ),
	.dat_yummy_S_out   (pe_0_0_dat_yummy_S_out    ),
	.rsp_S_out         (pe_0_0_rsp_S_out          ),
	.rsp_vld_S_out     (pe_0_0_rsp_vld_S_out      ),
	.rsp_yummy_S_in    (pe_0_0_rsp_yummy_S_in     ),
	.rsp_S_in          (pe_0_0_rsp_S_in           ),
	.rsp_vld_S_in      (pe_0_0_rsp_vld_S_in       ),
	.rsp_yummy_S_out   (pe_0_0_rsp_yummy_S_out    ),
	.sys_clk           (pe_0_0_sys_clk            ),
	.sys_rstn          (pe_0_0_sys_rstn           ),
	.S_HOST_AXI_aclk   (pe_0_0_S_HOST_AXI_aclk    ),
	.S_HOST_AXI_araddr (pe_0_0_S_HOST_AXI_araddr  ),
	.S_HOST_AXI_arburst(pe_0_0_S_HOST_AXI_arburst ),
	.S_HOST_AXI_arcache(pe_0_0_S_HOST_AXI_arcache ),
	.S_HOST_AXI_aresetn(pe_0_0_S_HOST_AXI_aresetn ),
	.S_HOST_AXI_arid   (pe_0_0_S_HOST_AXI_arid    ),
	.S_HOST_AXI_arlen  (pe_0_0_S_HOST_AXI_arlen   ),
	.S_HOST_AXI_arlock (pe_0_0_S_HOST_AXI_arlock  ),
	.S_HOST_AXI_arprot (pe_0_0_S_HOST_AXI_arprot  ),
	.S_HOST_AXI_arqos  (pe_0_0_S_HOST_AXI_arqos   ),
	.S_HOST_AXI_arsize (pe_0_0_S_HOST_AXI_arsize  ),
	.S_HOST_AXI_arvalid(pe_0_0_S_HOST_AXI_arvalid ),
	.S_HOST_AXI_awaddr (pe_0_0_S_HOST_AXI_awaddr  ),
	.S_HOST_AXI_awburst(pe_0_0_S_HOST_AXI_awburst ),
	.S_HOST_AXI_awcache(pe_0_0_S_HOST_AXI_awcache ),
	.S_HOST_AXI_awid   (pe_0_0_S_HOST_AXI_awid    ),
	.S_HOST_AXI_awlen  (pe_0_0_S_HOST_AXI_awlen   ),
	.S_HOST_AXI_awlock (pe_0_0_S_HOST_AXI_awlock  ),
	.S_HOST_AXI_awprot (pe_0_0_S_HOST_AXI_awprot  ),
	.S_HOST_AXI_awqos  (pe_0_0_S_HOST_AXI_awqos   ),
	.S_HOST_AXI_awsize (pe_0_0_S_HOST_AXI_awsize  ),
	.S_HOST_AXI_awvalid(pe_0_0_S_HOST_AXI_awvalid ),
	.S_HOST_AXI_bready (pe_0_0_S_HOST_AXI_bready  ),
	.S_HOST_AXI_rready (pe_0_0_S_HOST_AXI_rready  ),
	.S_HOST_AXI_wdata  (pe_0_0_S_HOST_AXI_wdata   ),
	.S_HOST_AXI_wlast  (pe_0_0_S_HOST_AXI_wlast   ),
	.S_HOST_AXI_wstrb  (pe_0_0_S_HOST_AXI_wstrb   ),
	.S_HOST_AXI_wvalid (pe_0_0_S_HOST_AXI_wvalid  ),
	.S_HOST_AXI_arready(pe_0_0_S_HOST_AXI_arready ),
	.S_HOST_AXI_awready(pe_0_0_S_HOST_AXI_awready ),
	.S_HOST_AXI_bid    (pe_0_0_S_HOST_AXI_bid     ),
	.S_HOST_AXI_bresp  (pe_0_0_S_HOST_AXI_bresp   ),
	.S_HOST_AXI_bvalid (pe_0_0_S_HOST_AXI_bvalid  ),
	.S_HOST_AXI_rdata  (pe_0_0_S_HOST_AXI_rdata   ),
	.S_HOST_AXI_rid    (pe_0_0_S_HOST_AXI_rid     ),
	.S_HOST_AXI_rlast  (pe_0_0_S_HOST_AXI_rlast   ),
	.S_HOST_AXI_rresp  (pe_0_0_S_HOST_AXI_rresp   ),
	.S_HOST_AXI_rvalid (pe_0_0_S_HOST_AXI_rvalid  ),
	.S_HOST_AXI_wready (pe_0_0_S_HOST_AXI_wready  )
);
// @20 &ConnRule(r'^(?!pe_)', r'pe_0_0_');
// @21 &ConnRule(r'pe_0_0_(\w+)_E_in', r'pe_1_0_to_pe_0_0_\1');
// @22 &ConnRule(r'pe_0_0_(\w+)_E_out', r'pe_0_0_to_pe_1_0_\1');
// @23 &ConnRule(r'pe_0_0_(\w+)_N_in', r'pe_0_1_to_pe_0_0_\1');
// @24 &ConnRule(r'pe_0_0_(\w+)_N_out', r'pe_0_0_to_pe_0_1_\1');

// @26 &Force("nonport", "pe_0_0_myLocX")
// @27 &Force("nonport", "pe_0_0_myLocY")
// @28 &Force("nonport", "pe_0_0_myChipID")
assign pe_0_0_myLocX = 4'd0;
assign pe_0_0_myLocY = 4'd0;
assign pe_0_0_myChipID = 1'd0;

// &Instance("pe_top", "x_pe_1_0_pe_top"); @33
pe_top x_pe_1_0_pe_top (
	.regular_0_clk     (pe_1_0_regular_0_clk      ),
	.regular_0_rstn    (pe_1_0_regular_0_rstn     ),
	.regular_1_clk     (pe_1_0_regular_1_clk      ),
	.regular_1_rstn    (pe_1_0_regular_1_rstn     ),
	.nou_clk           (pe_1_0_nou_clk            ),
	.nou_rstn          (pe_1_0_nou_rstn           ),
	.dsa_2_clk         (pe_1_0_dsa_2_clk          ),
	.dsa_2_rstn        (pe_1_0_dsa_2_rstn         ),
	.dispatcher_clk    (pe_1_0_dispatcher_clk     ),
	.dispatcher_rstn   (pe_1_0_dispatcher_rstn    ),
	.dsa_0_clk         (pe_1_0_dsa_0_clk          ),
	.dsa_0_rstn        (pe_1_0_dsa_0_rstn         ),
	.dsa_1_clk         (pe_1_0_dsa_1_clk          ),
	.dsa_1_rstn        (pe_1_0_dsa_1_rstn         ),
	.dsa_0_m_dsa_0_clk (pe_1_0_dsa_0_m_dsa_0_clk  ),
	.dsa_0_m_dsa_0_rstn(pe_1_0_dsa_0_m_dsa_0_rstn ),
	.dsa_1_m_dsa_1_clk (pe_1_0_dsa_1_m_dsa_1_clk  ),
	.dsa_1_m_dsa_1_rstn(pe_1_0_dsa_1_m_dsa_1_rstn ),
	.dsa_2_m_dsa_2_clk (pe_1_0_dsa_2_m_dsa_2_clk  ),
	.dsa_2_m_dsa_2_rstn(pe_1_0_dsa_2_m_dsa_2_rstn ),
	.mem_sub_sys_clk   (pe_1_0_mem_sub_sys_clk    ),
	.mem_sub_sys_rstn  (pe_1_0_mem_sub_sys_rstn   ),
	.myLocX            (pe_1_0_myLocX             ),
	.myLocY            (pe_1_0_myLocY             ),
	.myChipID          (pe_1_0_myChipID           ),
	.dat_W_out         (pe_1_0_to_pe_0_0_dat      ),
	.dat_vld_W_out     (pe_1_0_to_pe_0_0_dat_vld  ),
	.dat_yummy_W_in    (pe_0_0_to_pe_1_0_dat_yummy),
	.dat_W_in          (pe_0_0_to_pe_1_0_dat      ),
	.dat_vld_W_in      (pe_0_0_to_pe_1_0_dat_vld  ),
	.dat_yummy_W_out   (pe_1_0_to_pe_0_0_dat_yummy),
	.rsp_W_out         (pe_1_0_to_pe_0_0_rsp      ),
	.rsp_vld_W_out     (pe_1_0_to_pe_0_0_rsp_vld  ),
	.rsp_yummy_W_in    (pe_0_0_to_pe_1_0_rsp_yummy),
	.rsp_W_in          (pe_0_0_to_pe_1_0_rsp      ),
	.rsp_vld_W_in      (pe_0_0_to_pe_1_0_rsp_vld  ),
	.rsp_yummy_W_out   (pe_1_0_to_pe_0_0_rsp_yummy),
	.dat_E_out         (pe_1_0_dat_E_out          ),
	.dat_vld_E_out     (pe_1_0_dat_vld_E_out      ),
	.dat_yummy_E_in    (pe_1_0_dat_yummy_E_in     ),
	.dat_E_in          (pe_1_0_dat_E_in           ),
	.dat_vld_E_in      (pe_1_0_dat_vld_E_in       ),
	.dat_yummy_E_out   (pe_1_0_dat_yummy_E_out    ),
	.rsp_E_out         (pe_1_0_rsp_E_out          ),
	.rsp_vld_E_out     (pe_1_0_rsp_vld_E_out      ),
	.rsp_yummy_E_in    (pe_1_0_rsp_yummy_E_in     ),
	.rsp_E_in          (pe_1_0_rsp_E_in           ),
	.rsp_vld_E_in      (pe_1_0_rsp_vld_E_in       ),
	.rsp_yummy_E_out   (pe_1_0_rsp_yummy_E_out    ),
	.dat_N_out         (pe_1_0_to_pe_1_1_dat      ),
	.dat_vld_N_out     (pe_1_0_to_pe_1_1_dat_vld  ),
	.dat_yummy_N_in    (pe_1_1_to_pe_1_0_dat_yummy),
	.dat_N_in          (pe_1_1_to_pe_1_0_dat      ),
	.dat_vld_N_in      (pe_1_1_to_pe_1_0_dat_vld  ),
	.dat_yummy_N_out   (pe_1_0_to_pe_1_1_dat_yummy),
	.rsp_N_out         (pe_1_0_to_pe_1_1_rsp      ),
	.rsp_vld_N_out     (pe_1_0_to_pe_1_1_rsp_vld  ),
	.rsp_yummy_N_in    (pe_1_1_to_pe_1_0_rsp_yummy),
	.rsp_N_in          (pe_1_1_to_pe_1_0_rsp      ),
	.rsp_vld_N_in      (pe_1_1_to_pe_1_0_rsp_vld  ),
	.rsp_yummy_N_out   (pe_1_0_to_pe_1_1_rsp_yummy),
	.dat_S_out         (pe_1_0_dat_S_out          ),
	.dat_vld_S_out     (pe_1_0_dat_vld_S_out      ),
	.dat_yummy_S_in    (pe_1_0_dat_yummy_S_in     ),
	.dat_S_in          (pe_1_0_dat_S_in           ),
	.dat_vld_S_in      (pe_1_0_dat_vld_S_in       ),
	.dat_yummy_S_out   (pe_1_0_dat_yummy_S_out    ),
	.rsp_S_out         (pe_1_0_rsp_S_out          ),
	.rsp_vld_S_out     (pe_1_0_rsp_vld_S_out      ),
	.rsp_yummy_S_in    (pe_1_0_rsp_yummy_S_in     ),
	.rsp_S_in          (pe_1_0_rsp_S_in           ),
	.rsp_vld_S_in      (pe_1_0_rsp_vld_S_in       ),
	.rsp_yummy_S_out   (pe_1_0_rsp_yummy_S_out    ),
	.sys_clk           (pe_1_0_sys_clk            ),
	.sys_rstn          (pe_1_0_sys_rstn           ),
	.S_HOST_AXI_aclk   (pe_1_0_S_HOST_AXI_aclk    ),
	.S_HOST_AXI_araddr (pe_1_0_S_HOST_AXI_araddr  ),
	.S_HOST_AXI_arburst(pe_1_0_S_HOST_AXI_arburst ),
	.S_HOST_AXI_arcache(pe_1_0_S_HOST_AXI_arcache ),
	.S_HOST_AXI_aresetn(pe_1_0_S_HOST_AXI_aresetn ),
	.S_HOST_AXI_arid   (pe_1_0_S_HOST_AXI_arid    ),
	.S_HOST_AXI_arlen  (pe_1_0_S_HOST_AXI_arlen   ),
	.S_HOST_AXI_arlock (pe_1_0_S_HOST_AXI_arlock  ),
	.S_HOST_AXI_arprot (pe_1_0_S_HOST_AXI_arprot  ),
	.S_HOST_AXI_arqos  (pe_1_0_S_HOST_AXI_arqos   ),
	.S_HOST_AXI_arsize (pe_1_0_S_HOST_AXI_arsize  ),
	.S_HOST_AXI_arvalid(pe_1_0_S_HOST_AXI_arvalid ),
	.S_HOST_AXI_awaddr (pe_1_0_S_HOST_AXI_awaddr  ),
	.S_HOST_AXI_awburst(pe_1_0_S_HOST_AXI_awburst ),
	.S_HOST_AXI_awcache(pe_1_0_S_HOST_AXI_awcache ),
	.S_HOST_AXI_awid   (pe_1_0_S_HOST_AXI_awid    ),
	.S_HOST_AXI_awlen  (pe_1_0_S_HOST_AXI_awlen   ),
	.S_HOST_AXI_awlock (pe_1_0_S_HOST_AXI_awlock  ),
	.S_HOST_AXI_awprot (pe_1_0_S_HOST_AXI_awprot  ),
	.S_HOST_AXI_awqos  (pe_1_0_S_HOST_AXI_awqos   ),
	.S_HOST_AXI_awsize (pe_1_0_S_HOST_AXI_awsize  ),
	.S_HOST_AXI_awvalid(pe_1_0_S_HOST_AXI_awvalid ),
	.S_HOST_AXI_bready (pe_1_0_S_HOST_AXI_bready  ),
	.S_HOST_AXI_rready (pe_1_0_S_HOST_AXI_rready  ),
	.S_HOST_AXI_wdata  (pe_1_0_S_HOST_AXI_wdata   ),
	.S_HOST_AXI_wlast  (pe_1_0_S_HOST_AXI_wlast   ),
	.S_HOST_AXI_wstrb  (pe_1_0_S_HOST_AXI_wstrb   ),
	.S_HOST_AXI_wvalid (pe_1_0_S_HOST_AXI_wvalid  ),
	.S_HOST_AXI_arready(pe_1_0_S_HOST_AXI_arready ),
	.S_HOST_AXI_awready(pe_1_0_S_HOST_AXI_awready ),
	.S_HOST_AXI_bid    (pe_1_0_S_HOST_AXI_bid     ),
	.S_HOST_AXI_bresp  (pe_1_0_S_HOST_AXI_bresp   ),
	.S_HOST_AXI_bvalid (pe_1_0_S_HOST_AXI_bvalid  ),
	.S_HOST_AXI_rdata  (pe_1_0_S_HOST_AXI_rdata   ),
	.S_HOST_AXI_rid    (pe_1_0_S_HOST_AXI_rid     ),
	.S_HOST_AXI_rlast  (pe_1_0_S_HOST_AXI_rlast   ),
	.S_HOST_AXI_rresp  (pe_1_0_S_HOST_AXI_rresp   ),
	.S_HOST_AXI_rvalid (pe_1_0_S_HOST_AXI_rvalid  ),
	.S_HOST_AXI_wready (pe_1_0_S_HOST_AXI_wready  )
);
// @34 &ConnRule(r'^(?!pe_)', r'pe_1_0_');
// @35 &ConnRule(r'pe_1_0_(\w+)_W_in', r'pe_0_0_to_pe_1_0_\1');
// @36 &ConnRule(r'pe_1_0_(\w+)_W_out', r'pe_1_0_to_pe_0_0_\1');
// @37 &ConnRule(r'pe_1_0_(\w+)_N_in', r'pe_1_1_to_pe_1_0_\1');
// @38 &ConnRule(r'pe_1_0_(\w+)_N_out', r'pe_1_0_to_pe_1_1_\1');

// @40 &Force("nonport", "pe_1_0_myLocX")
// @41 &Force("nonport", "pe_1_0_myLocY")
// @42 &Force("nonport", "pe_1_0_myChipID")
assign pe_1_0_myLocX = 4'd1;
assign pe_1_0_myLocY = 4'd0;
assign pe_1_0_myChipID = 1'd0;

// &Instance("pe_top", "x_pe_0_1_pe_top"); @47
pe_top x_pe_0_1_pe_top (
	.regular_0_clk     (pe_0_1_regular_0_clk      ),
	.regular_0_rstn    (pe_0_1_regular_0_rstn     ),
	.regular_1_clk     (pe_0_1_regular_1_clk      ),
	.regular_1_rstn    (pe_0_1_regular_1_rstn     ),
	.nou_clk           (pe_0_1_nou_clk            ),
	.nou_rstn          (pe_0_1_nou_rstn           ),
	.dsa_2_clk         (pe_0_1_dsa_2_clk          ),
	.dsa_2_rstn        (pe_0_1_dsa_2_rstn         ),
	.dispatcher_clk    (pe_0_1_dispatcher_clk     ),
	.dispatcher_rstn   (pe_0_1_dispatcher_rstn    ),
	.dsa_0_clk         (pe_0_1_dsa_0_clk          ),
	.dsa_0_rstn        (pe_0_1_dsa_0_rstn         ),
	.dsa_1_clk         (pe_0_1_dsa_1_clk          ),
	.dsa_1_rstn        (pe_0_1_dsa_1_rstn         ),
	.dsa_0_m_dsa_0_clk (pe_0_1_dsa_0_m_dsa_0_clk  ),
	.dsa_0_m_dsa_0_rstn(pe_0_1_dsa_0_m_dsa_0_rstn ),
	.dsa_1_m_dsa_1_clk (pe_0_1_dsa_1_m_dsa_1_clk  ),
	.dsa_1_m_dsa_1_rstn(pe_0_1_dsa_1_m_dsa_1_rstn ),
	.dsa_2_m_dsa_2_clk (pe_0_1_dsa_2_m_dsa_2_clk  ),
	.dsa_2_m_dsa_2_rstn(pe_0_1_dsa_2_m_dsa_2_rstn ),
	.mem_sub_sys_clk   (pe_0_1_mem_sub_sys_clk    ),
	.mem_sub_sys_rstn  (pe_0_1_mem_sub_sys_rstn   ),
	.myLocX            (pe_0_1_myLocX             ),
	.myLocY            (pe_0_1_myLocY             ),
	.myChipID          (pe_0_1_myChipID           ),
	.dat_W_out         (pe_0_1_dat_W_out          ),
	.dat_vld_W_out     (pe_0_1_dat_vld_W_out      ),
	.dat_yummy_W_in    (pe_0_1_dat_yummy_W_in     ),
	.dat_W_in          (pe_0_1_dat_W_in           ),
	.dat_vld_W_in      (pe_0_1_dat_vld_W_in       ),
	.dat_yummy_W_out   (pe_0_1_dat_yummy_W_out    ),
	.rsp_W_out         (pe_0_1_rsp_W_out          ),
	.rsp_vld_W_out     (pe_0_1_rsp_vld_W_out      ),
	.rsp_yummy_W_in    (pe_0_1_rsp_yummy_W_in     ),
	.rsp_W_in          (pe_0_1_rsp_W_in           ),
	.rsp_vld_W_in      (pe_0_1_rsp_vld_W_in       ),
	.rsp_yummy_W_out   (pe_0_1_rsp_yummy_W_out    ),
	.dat_E_out         (pe_0_1_to_pe_1_1_dat      ),
	.dat_vld_E_out     (pe_0_1_to_pe_1_1_dat_vld  ),
	.dat_yummy_E_in    (pe_1_1_to_pe_0_1_dat_yummy),
	.dat_E_in          (pe_1_1_to_pe_0_1_dat      ),
	.dat_vld_E_in      (pe_1_1_to_pe_0_1_dat_vld  ),
	.dat_yummy_E_out   (pe_0_1_to_pe_1_1_dat_yummy),
	.rsp_E_out         (pe_0_1_to_pe_1_1_rsp      ),
	.rsp_vld_E_out     (pe_0_1_to_pe_1_1_rsp_vld  ),
	.rsp_yummy_E_in    (pe_1_1_to_pe_0_1_rsp_yummy),
	.rsp_E_in          (pe_1_1_to_pe_0_1_rsp      ),
	.rsp_vld_E_in      (pe_1_1_to_pe_0_1_rsp_vld  ),
	.rsp_yummy_E_out   (pe_0_1_to_pe_1_1_rsp_yummy),
	.dat_N_out         (pe_0_1_dat_N_out          ),
	.dat_vld_N_out     (pe_0_1_dat_vld_N_out      ),
	.dat_yummy_N_in    (pe_0_1_dat_yummy_N_in     ),
	.dat_N_in          (pe_0_1_dat_N_in           ),
	.dat_vld_N_in      (pe_0_1_dat_vld_N_in       ),
	.dat_yummy_N_out   (pe_0_1_dat_yummy_N_out    ),
	.rsp_N_out         (pe_0_1_rsp_N_out          ),
	.rsp_vld_N_out     (pe_0_1_rsp_vld_N_out      ),
	.rsp_yummy_N_in    (pe_0_1_rsp_yummy_N_in     ),
	.rsp_N_in          (pe_0_1_rsp_N_in           ),
	.rsp_vld_N_in      (pe_0_1_rsp_vld_N_in       ),
	.rsp_yummy_N_out   (pe_0_1_rsp_yummy_N_out    ),
	.dat_S_out         (pe_0_1_to_pe_0_0_dat      ),
	.dat_vld_S_out     (pe_0_1_to_pe_0_0_dat_vld  ),
	.dat_yummy_S_in    (pe_0_0_to_pe_0_1_dat_yummy),
	.dat_S_in          (pe_0_0_to_pe_0_1_dat      ),
	.dat_vld_S_in      (pe_0_0_to_pe_0_1_dat_vld  ),
	.dat_yummy_S_out   (pe_0_1_to_pe_0_0_dat_yummy),
	.rsp_S_out         (pe_0_1_to_pe_0_0_rsp      ),
	.rsp_vld_S_out     (pe_0_1_to_pe_0_0_rsp_vld  ),
	.rsp_yummy_S_in    (pe_0_0_to_pe_0_1_rsp_yummy),
	.rsp_S_in          (pe_0_0_to_pe_0_1_rsp      ),
	.rsp_vld_S_in      (pe_0_0_to_pe_0_1_rsp_vld  ),
	.rsp_yummy_S_out   (pe_0_1_to_pe_0_0_rsp_yummy),
	.sys_clk           (pe_0_1_sys_clk            ),
	.sys_rstn          (pe_0_1_sys_rstn           ),
	.S_HOST_AXI_aclk   (pe_0_1_S_HOST_AXI_aclk    ),
	.S_HOST_AXI_araddr (pe_0_1_S_HOST_AXI_araddr  ),
	.S_HOST_AXI_arburst(pe_0_1_S_HOST_AXI_arburst ),
	.S_HOST_AXI_arcache(pe_0_1_S_HOST_AXI_arcache ),
	.S_HOST_AXI_aresetn(pe_0_1_S_HOST_AXI_aresetn ),
	.S_HOST_AXI_arid   (pe_0_1_S_HOST_AXI_arid    ),
	.S_HOST_AXI_arlen  (pe_0_1_S_HOST_AXI_arlen   ),
	.S_HOST_AXI_arlock (pe_0_1_S_HOST_AXI_arlock  ),
	.S_HOST_AXI_arprot (pe_0_1_S_HOST_AXI_arprot  ),
	.S_HOST_AXI_arqos  (pe_0_1_S_HOST_AXI_arqos   ),
	.S_HOST_AXI_arsize (pe_0_1_S_HOST_AXI_arsize  ),
	.S_HOST_AXI_arvalid(pe_0_1_S_HOST_AXI_arvalid ),
	.S_HOST_AXI_awaddr (pe_0_1_S_HOST_AXI_awaddr  ),
	.S_HOST_AXI_awburst(pe_0_1_S_HOST_AXI_awburst ),
	.S_HOST_AXI_awcache(pe_0_1_S_HOST_AXI_awcache ),
	.S_HOST_AXI_awid   (pe_0_1_S_HOST_AXI_awid    ),
	.S_HOST_AXI_awlen  (pe_0_1_S_HOST_AXI_awlen   ),
	.S_HOST_AXI_awlock (pe_0_1_S_HOST_AXI_awlock  ),
	.S_HOST_AXI_awprot (pe_0_1_S_HOST_AXI_awprot  ),
	.S_HOST_AXI_awqos  (pe_0_1_S_HOST_AXI_awqos   ),
	.S_HOST_AXI_awsize (pe_0_1_S_HOST_AXI_awsize  ),
	.S_HOST_AXI_awvalid(pe_0_1_S_HOST_AXI_awvalid ),
	.S_HOST_AXI_bready (pe_0_1_S_HOST_AXI_bready  ),
	.S_HOST_AXI_rready (pe_0_1_S_HOST_AXI_rready  ),
	.S_HOST_AXI_wdata  (pe_0_1_S_HOST_AXI_wdata   ),
	.S_HOST_AXI_wlast  (pe_0_1_S_HOST_AXI_wlast   ),
	.S_HOST_AXI_wstrb  (pe_0_1_S_HOST_AXI_wstrb   ),
	.S_HOST_AXI_wvalid (pe_0_1_S_HOST_AXI_wvalid  ),
	.S_HOST_AXI_arready(pe_0_1_S_HOST_AXI_arready ),
	.S_HOST_AXI_awready(pe_0_1_S_HOST_AXI_awready ),
	.S_HOST_AXI_bid    (pe_0_1_S_HOST_AXI_bid     ),
	.S_HOST_AXI_bresp  (pe_0_1_S_HOST_AXI_bresp   ),
	.S_HOST_AXI_bvalid (pe_0_1_S_HOST_AXI_bvalid  ),
	.S_HOST_AXI_rdata  (pe_0_1_S_HOST_AXI_rdata   ),
	.S_HOST_AXI_rid    (pe_0_1_S_HOST_AXI_rid     ),
	.S_HOST_AXI_rlast  (pe_0_1_S_HOST_AXI_rlast   ),
	.S_HOST_AXI_rresp  (pe_0_1_S_HOST_AXI_rresp   ),
	.S_HOST_AXI_rvalid (pe_0_1_S_HOST_AXI_rvalid  ),
	.S_HOST_AXI_wready (pe_0_1_S_HOST_AXI_wready  )
);
// @48 &ConnRule(r'^(?!pe_)', r'pe_0_1_');
// @49 &ConnRule(r'pe_0_1_(\w+)_S_in', r'pe_0_0_to_pe_0_1_\1');
// @50 &ConnRule(r'pe_0_1_(\w+)_S_out', r'pe_0_1_to_pe_0_0_\1');
// @51 &ConnRule(r'pe_0_1_(\w+)_E_in', r'pe_1_1_to_pe_0_1_\1');
// @52 &ConnRule(r'pe_0_1_(\w+)_E_out', r'pe_0_1_to_pe_1_1_\1');

// @54 &Force("nonport", "pe_0_1_myLocX")
// @55 &Force("nonport", "pe_0_1_myLocY")
// @56 &Force("nonport", "pe_0_1_myChipID")
assign pe_0_1_myLocX = 4'd0;
assign pe_0_1_myLocY = 4'd1;
assign pe_0_1_myChipID = 1'd0;

// &Instance("pe_top", "x_pe_1_1_pe_top"); @61
pe_top x_pe_1_1_pe_top (
	.regular_0_clk     (pe_1_1_regular_0_clk      ),
	.regular_0_rstn    (pe_1_1_regular_0_rstn     ),
	.regular_1_clk     (pe_1_1_regular_1_clk      ),
	.regular_1_rstn    (pe_1_1_regular_1_rstn     ),
	.nou_clk           (pe_1_1_nou_clk            ),
	.nou_rstn          (pe_1_1_nou_rstn           ),
	.dsa_2_clk         (pe_1_1_dsa_2_clk          ),
	.dsa_2_rstn        (pe_1_1_dsa_2_rstn         ),
	.dispatcher_clk    (pe_1_1_dispatcher_clk     ),
	.dispatcher_rstn   (pe_1_1_dispatcher_rstn    ),
	.dsa_0_clk         (pe_1_1_dsa_0_clk          ),
	.dsa_0_rstn        (pe_1_1_dsa_0_rstn         ),
	.dsa_1_clk         (pe_1_1_dsa_1_clk          ),
	.dsa_1_rstn        (pe_1_1_dsa_1_rstn         ),
	.dsa_0_m_dsa_0_clk (pe_1_1_dsa_0_m_dsa_0_clk  ),
	.dsa_0_m_dsa_0_rstn(pe_1_1_dsa_0_m_dsa_0_rstn ),
	.dsa_1_m_dsa_1_clk (pe_1_1_dsa_1_m_dsa_1_clk  ),
	.dsa_1_m_dsa_1_rstn(pe_1_1_dsa_1_m_dsa_1_rstn ),
	.dsa_2_m_dsa_2_clk (pe_1_1_dsa_2_m_dsa_2_clk  ),
	.dsa_2_m_dsa_2_rstn(pe_1_1_dsa_2_m_dsa_2_rstn ),
	.mem_sub_sys_clk   (pe_1_1_mem_sub_sys_clk    ),
	.mem_sub_sys_rstn  (pe_1_1_mem_sub_sys_rstn   ),
	.myLocX            (pe_1_1_myLocX             ),
	.myLocY            (pe_1_1_myLocY             ),
	.myChipID          (pe_1_1_myChipID           ),
	.dat_W_out         (pe_1_1_to_pe_0_1_dat      ),
	.dat_vld_W_out     (pe_1_1_to_pe_0_1_dat_vld  ),
	.dat_yummy_W_in    (pe_0_1_to_pe_1_1_dat_yummy),
	.dat_W_in          (pe_0_1_to_pe_1_1_dat      ),
	.dat_vld_W_in      (pe_0_1_to_pe_1_1_dat_vld  ),
	.dat_yummy_W_out   (pe_1_1_to_pe_0_1_dat_yummy),
	.rsp_W_out         (pe_1_1_to_pe_0_1_rsp      ),
	.rsp_vld_W_out     (pe_1_1_to_pe_0_1_rsp_vld  ),
	.rsp_yummy_W_in    (pe_0_1_to_pe_1_1_rsp_yummy),
	.rsp_W_in          (pe_0_1_to_pe_1_1_rsp      ),
	.rsp_vld_W_in      (pe_0_1_to_pe_1_1_rsp_vld  ),
	.rsp_yummy_W_out   (pe_1_1_to_pe_0_1_rsp_yummy),
	.dat_E_out         (pe_1_1_dat_E_out          ),
	.dat_vld_E_out     (pe_1_1_dat_vld_E_out      ),
	.dat_yummy_E_in    (pe_1_1_dat_yummy_E_in     ),
	.dat_E_in          (pe_1_1_dat_E_in           ),
	.dat_vld_E_in      (pe_1_1_dat_vld_E_in       ),
	.dat_yummy_E_out   (pe_1_1_dat_yummy_E_out    ),
	.rsp_E_out         (pe_1_1_rsp_E_out          ),
	.rsp_vld_E_out     (pe_1_1_rsp_vld_E_out      ),
	.rsp_yummy_E_in    (pe_1_1_rsp_yummy_E_in     ),
	.rsp_E_in          (pe_1_1_rsp_E_in           ),
	.rsp_vld_E_in      (pe_1_1_rsp_vld_E_in       ),
	.rsp_yummy_E_out   (pe_1_1_rsp_yummy_E_out    ),
	.dat_N_out         (pe_1_1_dat_N_out          ),
	.dat_vld_N_out     (pe_1_1_dat_vld_N_out      ),
	.dat_yummy_N_in    (pe_1_1_dat_yummy_N_in     ),
	.dat_N_in          (pe_1_1_dat_N_in           ),
	.dat_vld_N_in      (pe_1_1_dat_vld_N_in       ),
	.dat_yummy_N_out   (pe_1_1_dat_yummy_N_out    ),
	.rsp_N_out         (pe_1_1_rsp_N_out          ),
	.rsp_vld_N_out     (pe_1_1_rsp_vld_N_out      ),
	.rsp_yummy_N_in    (pe_1_1_rsp_yummy_N_in     ),
	.rsp_N_in          (pe_1_1_rsp_N_in           ),
	.rsp_vld_N_in      (pe_1_1_rsp_vld_N_in       ),
	.rsp_yummy_N_out   (pe_1_1_rsp_yummy_N_out    ),
	.dat_S_out         (pe_1_1_to_pe_1_0_dat      ),
	.dat_vld_S_out     (pe_1_1_to_pe_1_0_dat_vld  ),
	.dat_yummy_S_in    (pe_1_0_to_pe_1_1_dat_yummy),
	.dat_S_in          (pe_1_0_to_pe_1_1_dat      ),
	.dat_vld_S_in      (pe_1_0_to_pe_1_1_dat_vld  ),
	.dat_yummy_S_out   (pe_1_1_to_pe_1_0_dat_yummy),
	.rsp_S_out         (pe_1_1_to_pe_1_0_rsp      ),
	.rsp_vld_S_out     (pe_1_1_to_pe_1_0_rsp_vld  ),
	.rsp_yummy_S_in    (pe_1_0_to_pe_1_1_rsp_yummy),
	.rsp_S_in          (pe_1_0_to_pe_1_1_rsp      ),
	.rsp_vld_S_in      (pe_1_0_to_pe_1_1_rsp_vld  ),
	.rsp_yummy_S_out   (pe_1_1_to_pe_1_0_rsp_yummy),
	.sys_clk           (pe_1_1_sys_clk            ),
	.sys_rstn          (pe_1_1_sys_rstn           ),
	.S_HOST_AXI_aclk   (pe_1_1_S_HOST_AXI_aclk    ),
	.S_HOST_AXI_araddr (pe_1_1_S_HOST_AXI_araddr  ),
	.S_HOST_AXI_arburst(pe_1_1_S_HOST_AXI_arburst ),
	.S_HOST_AXI_arcache(pe_1_1_S_HOST_AXI_arcache ),
	.S_HOST_AXI_aresetn(pe_1_1_S_HOST_AXI_aresetn ),
	.S_HOST_AXI_arid   (pe_1_1_S_HOST_AXI_arid    ),
	.S_HOST_AXI_arlen  (pe_1_1_S_HOST_AXI_arlen   ),
	.S_HOST_AXI_arlock (pe_1_1_S_HOST_AXI_arlock  ),
	.S_HOST_AXI_arprot (pe_1_1_S_HOST_AXI_arprot  ),
	.S_HOST_AXI_arqos  (pe_1_1_S_HOST_AXI_arqos   ),
	.S_HOST_AXI_arsize (pe_1_1_S_HOST_AXI_arsize  ),
	.S_HOST_AXI_arvalid(pe_1_1_S_HOST_AXI_arvalid ),
	.S_HOST_AXI_awaddr (pe_1_1_S_HOST_AXI_awaddr  ),
	.S_HOST_AXI_awburst(pe_1_1_S_HOST_AXI_awburst ),
	.S_HOST_AXI_awcache(pe_1_1_S_HOST_AXI_awcache ),
	.S_HOST_AXI_awid   (pe_1_1_S_HOST_AXI_awid    ),
	.S_HOST_AXI_awlen  (pe_1_1_S_HOST_AXI_awlen   ),
	.S_HOST_AXI_awlock (pe_1_1_S_HOST_AXI_awlock  ),
	.S_HOST_AXI_awprot (pe_1_1_S_HOST_AXI_awprot  ),
	.S_HOST_AXI_awqos  (pe_1_1_S_HOST_AXI_awqos   ),
	.S_HOST_AXI_awsize (pe_1_1_S_HOST_AXI_awsize  ),
	.S_HOST_AXI_awvalid(pe_1_1_S_HOST_AXI_awvalid ),
	.S_HOST_AXI_bready (pe_1_1_S_HOST_AXI_bready  ),
	.S_HOST_AXI_rready (pe_1_1_S_HOST_AXI_rready  ),
	.S_HOST_AXI_wdata  (pe_1_1_S_HOST_AXI_wdata   ),
	.S_HOST_AXI_wlast  (pe_1_1_S_HOST_AXI_wlast   ),
	.S_HOST_AXI_wstrb  (pe_1_1_S_HOST_AXI_wstrb   ),
	.S_HOST_AXI_wvalid (pe_1_1_S_HOST_AXI_wvalid  ),
	.S_HOST_AXI_arready(pe_1_1_S_HOST_AXI_arready ),
	.S_HOST_AXI_awready(pe_1_1_S_HOST_AXI_awready ),
	.S_HOST_AXI_bid    (pe_1_1_S_HOST_AXI_bid     ),
	.S_HOST_AXI_bresp  (pe_1_1_S_HOST_AXI_bresp   ),
	.S_HOST_AXI_bvalid (pe_1_1_S_HOST_AXI_bvalid  ),
	.S_HOST_AXI_rdata  (pe_1_1_S_HOST_AXI_rdata   ),
	.S_HOST_AXI_rid    (pe_1_1_S_HOST_AXI_rid     ),
	.S_HOST_AXI_rlast  (pe_1_1_S_HOST_AXI_rlast   ),
	.S_HOST_AXI_rresp  (pe_1_1_S_HOST_AXI_rresp   ),
	.S_HOST_AXI_rvalid (pe_1_1_S_HOST_AXI_rvalid  ),
	.S_HOST_AXI_wready (pe_1_1_S_HOST_AXI_wready  )
);
// @62 &ConnRule(r'^(?!pe_)', r'pe_1_1_');
// @63 &ConnRule(r'pe_1_1_(\w+)_W_in', r'pe_0_1_to_pe_1_1_\1');
// @64 &ConnRule(r'pe_1_1_(\w+)_W_out', r'pe_1_1_to_pe_0_1_\1');
// @65 &ConnRule(r'pe_1_1_(\w+)_S_in', r'pe_1_0_to_pe_1_1_\1');
// @66 &ConnRule(r'pe_1_1_(\w+)_S_out', r'pe_1_1_to_pe_1_0_\1');

// @68 &Force("nonport", "pe_1_1_myLocX")
// @69 &Force("nonport", "pe_1_1_myLocY")
// @70 &Force("nonport", "pe_1_1_myChipID")
assign pe_1_1_myLocX = 4'd1;
assign pe_1_1_myLocY = 4'd1;
assign pe_1_1_myChipID = 1'd0;


endmodule
