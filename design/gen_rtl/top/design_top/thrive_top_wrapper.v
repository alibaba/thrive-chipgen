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
module thrive_top_wrapper (
	pe_0_0_dsa_0_m_dsa_0_clk,
	pe_0_0_dsa_0_m_dsa_0_rstn,
	pe_0_0_dsa_1_m_dsa_1_clk,
	pe_0_0_dsa_1_m_dsa_1_rstn,
	pe_0_0_dsa_2_m_dsa_2_clk,
	pe_0_0_dsa_2_m_dsa_2_rstn,
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
	sys_clk,
	sys_rstn,
	pe_1_0_dsa_0_m_dsa_0_clk,
	pe_1_0_dsa_0_m_dsa_0_rstn,
	pe_1_0_dsa_1_m_dsa_1_clk,
	pe_1_0_dsa_1_m_dsa_1_rstn,
	pe_1_0_dsa_2_m_dsa_2_clk,
	pe_1_0_dsa_2_m_dsa_2_rstn,
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
	pe_0_1_dsa_0_m_dsa_0_clk,
	pe_0_1_dsa_0_m_dsa_0_rstn,
	pe_0_1_dsa_1_m_dsa_1_clk,
	pe_0_1_dsa_1_m_dsa_1_rstn,
	pe_0_1_dsa_2_m_dsa_2_clk,
	pe_0_1_dsa_2_m_dsa_2_rstn,
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
	pe_1_1_dsa_0_m_dsa_0_clk,
	pe_1_1_dsa_0_m_dsa_0_rstn,
	pe_1_1_dsa_1_m_dsa_1_clk,
	pe_1_1_dsa_1_m_dsa_1_rstn,
	pe_1_1_dsa_2_m_dsa_2_clk,
	pe_1_1_dsa_2_m_dsa_2_rstn,
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
	HOST_S_AXI_araddr,
	HOST_S_AXI_arburst,
	HOST_S_AXI_arcache,
	HOST_S_AXI_arid,
	HOST_S_AXI_arlen,
	HOST_S_AXI_arlock,
	HOST_S_AXI_arprot,
	HOST_S_AXI_arqos,
	HOST_S_AXI_arsize,
	HOST_S_AXI_arvalid,
	HOST_S_AXI_awaddr,
	HOST_S_AXI_awburst,
	HOST_S_AXI_awcache,
	HOST_S_AXI_awid,
	HOST_S_AXI_awlen,
	HOST_S_AXI_awlock,
	HOST_S_AXI_awprot,
	HOST_S_AXI_awqos,
	HOST_S_AXI_awsize,
	HOST_S_AXI_awvalid,
	HOST_S_AXI_bready,
	HOST_S_AXI_rready,
	HOST_S_AXI_wdata,
	HOST_S_AXI_wlast,
	HOST_S_AXI_wstrb,
	HOST_S_AXI_wvalid,
	HOST_S_AXI_arready,
	HOST_S_AXI_awready,
	HOST_S_AXI_bid,
	HOST_S_AXI_bresp,
	HOST_S_AXI_bvalid,
	HOST_S_AXI_rdata,
	HOST_S_AXI_rid,
	HOST_S_AXI_rlast,
	HOST_S_AXI_rresp,
	HOST_S_AXI_rvalid,
	HOST_S_AXI_wready
);

// &Ports; @17
input   [0:0]                      pe_0_0_dsa_0_m_dsa_0_clk;
input   [0:0]                      pe_0_0_dsa_0_m_dsa_0_rstn;
input   [0:0]                      pe_0_0_dsa_1_m_dsa_1_clk;
input   [0:0]                      pe_0_0_dsa_1_m_dsa_1_rstn;
input   [0:0]                      pe_0_0_dsa_2_m_dsa_2_clk;
input   [0:0]                      pe_0_0_dsa_2_m_dsa_2_rstn;
output  [`DATA_WIDTH-1:0]          pe_0_0_dat_W_out;        
output  [0:0]                      pe_0_0_dat_vld_W_out;    
input   [0:0]                      pe_0_0_dat_yummy_W_in;   
input   [`DATA_WIDTH-1:0]          pe_0_0_dat_W_in;         
input   [0:0]                      pe_0_0_dat_vld_W_in;     
output  [0:0]                      pe_0_0_dat_yummy_W_out;  
output  [`RSP_WIDTH-1:0]           pe_0_0_rsp_W_out;        
output  [0:0]                      pe_0_0_rsp_vld_W_out;    
input   [0:0]                      pe_0_0_rsp_yummy_W_in;   
input   [`RSP_WIDTH-1:0]           pe_0_0_rsp_W_in;         
input   [0:0]                      pe_0_0_rsp_vld_W_in;     
output  [0:0]                      pe_0_0_rsp_yummy_W_out;  
output  [`DATA_WIDTH-1:0]          pe_0_0_dat_S_out;        
output  [0:0]                      pe_0_0_dat_vld_S_out;    
input   [0:0]                      pe_0_0_dat_yummy_S_in;   
input   [`DATA_WIDTH-1:0]          pe_0_0_dat_S_in;         
input   [0:0]                      pe_0_0_dat_vld_S_in;     
output  [0:0]                      pe_0_0_dat_yummy_S_out;  
output  [`RSP_WIDTH-1:0]           pe_0_0_rsp_S_out;        
output  [0:0]                      pe_0_0_rsp_vld_S_out;    
input   [0:0]                      pe_0_0_rsp_yummy_S_in;   
input   [`RSP_WIDTH-1:0]           pe_0_0_rsp_S_in;         
input   [0:0]                      pe_0_0_rsp_vld_S_in;     
output  [0:0]                      pe_0_0_rsp_yummy_S_out;  
input   [0:0]                      pe_0_0_sys_clk;          
input   [0:0]                      pe_0_0_sys_rstn;         
input   [0:0]                      sys_clk;                 
input   [0:0]                      sys_rstn;                
input   [0:0]                      pe_1_0_dsa_0_m_dsa_0_clk;
input   [0:0]                      pe_1_0_dsa_0_m_dsa_0_rstn;
input   [0:0]                      pe_1_0_dsa_1_m_dsa_1_clk;
input   [0:0]                      pe_1_0_dsa_1_m_dsa_1_rstn;
input   [0:0]                      pe_1_0_dsa_2_m_dsa_2_clk;
input   [0:0]                      pe_1_0_dsa_2_m_dsa_2_rstn;
output  [`DATA_WIDTH-1:0]          pe_1_0_dat_E_out;        
output  [0:0]                      pe_1_0_dat_vld_E_out;    
input   [0:0]                      pe_1_0_dat_yummy_E_in;   
input   [`DATA_WIDTH-1:0]          pe_1_0_dat_E_in;         
input   [0:0]                      pe_1_0_dat_vld_E_in;     
output  [0:0]                      pe_1_0_dat_yummy_E_out;  
output  [`RSP_WIDTH-1:0]           pe_1_0_rsp_E_out;        
output  [0:0]                      pe_1_0_rsp_vld_E_out;    
input   [0:0]                      pe_1_0_rsp_yummy_E_in;   
input   [`RSP_WIDTH-1:0]           pe_1_0_rsp_E_in;         
input   [0:0]                      pe_1_0_rsp_vld_E_in;     
output  [0:0]                      pe_1_0_rsp_yummy_E_out;  
output  [`DATA_WIDTH-1:0]          pe_1_0_dat_S_out;        
output  [0:0]                      pe_1_0_dat_vld_S_out;    
input   [0:0]                      pe_1_0_dat_yummy_S_in;   
input   [`DATA_WIDTH-1:0]          pe_1_0_dat_S_in;         
input   [0:0]                      pe_1_0_dat_vld_S_in;     
output  [0:0]                      pe_1_0_dat_yummy_S_out;  
output  [`RSP_WIDTH-1:0]           pe_1_0_rsp_S_out;        
output  [0:0]                      pe_1_0_rsp_vld_S_out;    
input   [0:0]                      pe_1_0_rsp_yummy_S_in;   
input   [`RSP_WIDTH-1:0]           pe_1_0_rsp_S_in;         
input   [0:0]                      pe_1_0_rsp_vld_S_in;     
output  [0:0]                      pe_1_0_rsp_yummy_S_out;  
input   [0:0]                      pe_1_0_sys_clk;          
input   [0:0]                      pe_1_0_sys_rstn;         
input   [0:0]                      pe_0_1_dsa_0_m_dsa_0_clk;
input   [0:0]                      pe_0_1_dsa_0_m_dsa_0_rstn;
input   [0:0]                      pe_0_1_dsa_1_m_dsa_1_clk;
input   [0:0]                      pe_0_1_dsa_1_m_dsa_1_rstn;
input   [0:0]                      pe_0_1_dsa_2_m_dsa_2_clk;
input   [0:0]                      pe_0_1_dsa_2_m_dsa_2_rstn;
output  [`DATA_WIDTH-1:0]          pe_0_1_dat_W_out;        
output  [0:0]                      pe_0_1_dat_vld_W_out;    
input   [0:0]                      pe_0_1_dat_yummy_W_in;   
input   [`DATA_WIDTH-1:0]          pe_0_1_dat_W_in;         
input   [0:0]                      pe_0_1_dat_vld_W_in;     
output  [0:0]                      pe_0_1_dat_yummy_W_out;  
output  [`RSP_WIDTH-1:0]           pe_0_1_rsp_W_out;        
output  [0:0]                      pe_0_1_rsp_vld_W_out;    
input   [0:0]                      pe_0_1_rsp_yummy_W_in;   
input   [`RSP_WIDTH-1:0]           pe_0_1_rsp_W_in;         
input   [0:0]                      pe_0_1_rsp_vld_W_in;     
output  [0:0]                      pe_0_1_rsp_yummy_W_out;  
output  [`DATA_WIDTH-1:0]          pe_0_1_dat_N_out;        
output  [0:0]                      pe_0_1_dat_vld_N_out;    
input   [0:0]                      pe_0_1_dat_yummy_N_in;   
input   [`DATA_WIDTH-1:0]          pe_0_1_dat_N_in;         
input   [0:0]                      pe_0_1_dat_vld_N_in;     
output  [0:0]                      pe_0_1_dat_yummy_N_out;  
output  [`RSP_WIDTH-1:0]           pe_0_1_rsp_N_out;        
output  [0:0]                      pe_0_1_rsp_vld_N_out;    
input   [0:0]                      pe_0_1_rsp_yummy_N_in;   
input   [`RSP_WIDTH-1:0]           pe_0_1_rsp_N_in;         
input   [0:0]                      pe_0_1_rsp_vld_N_in;     
output  [0:0]                      pe_0_1_rsp_yummy_N_out;  
input   [0:0]                      pe_0_1_sys_clk;          
input   [0:0]                      pe_0_1_sys_rstn;         
input   [0:0]                      pe_1_1_dsa_0_m_dsa_0_clk;
input   [0:0]                      pe_1_1_dsa_0_m_dsa_0_rstn;
input   [0:0]                      pe_1_1_dsa_1_m_dsa_1_clk;
input   [0:0]                      pe_1_1_dsa_1_m_dsa_1_rstn;
input   [0:0]                      pe_1_1_dsa_2_m_dsa_2_clk;
input   [0:0]                      pe_1_1_dsa_2_m_dsa_2_rstn;
output  [`DATA_WIDTH-1:0]          pe_1_1_dat_E_out;        
output  [0:0]                      pe_1_1_dat_vld_E_out;    
input   [0:0]                      pe_1_1_dat_yummy_E_in;   
input   [`DATA_WIDTH-1:0]          pe_1_1_dat_E_in;         
input   [0:0]                      pe_1_1_dat_vld_E_in;     
output  [0:0]                      pe_1_1_dat_yummy_E_out;  
output  [`RSP_WIDTH-1:0]           pe_1_1_rsp_E_out;        
output  [0:0]                      pe_1_1_rsp_vld_E_out;    
input   [0:0]                      pe_1_1_rsp_yummy_E_in;   
input   [`RSP_WIDTH-1:0]           pe_1_1_rsp_E_in;         
input   [0:0]                      pe_1_1_rsp_vld_E_in;     
output  [0:0]                      pe_1_1_rsp_yummy_E_out;  
output  [`DATA_WIDTH-1:0]          pe_1_1_dat_N_out;        
output  [0:0]                      pe_1_1_dat_vld_N_out;    
input   [0:0]                      pe_1_1_dat_yummy_N_in;   
input   [`DATA_WIDTH-1:0]          pe_1_1_dat_N_in;         
input   [0:0]                      pe_1_1_dat_vld_N_in;     
output  [0:0]                      pe_1_1_dat_yummy_N_out;  
output  [`RSP_WIDTH-1:0]           pe_1_1_rsp_N_out;        
output  [0:0]                      pe_1_1_rsp_vld_N_out;    
input   [0:0]                      pe_1_1_rsp_yummy_N_in;   
input   [`RSP_WIDTH-1:0]           pe_1_1_rsp_N_in;         
input   [0:0]                      pe_1_1_rsp_vld_N_in;     
output  [0:0]                      pe_1_1_rsp_yummy_N_out;  
input   [0:0]                      pe_1_1_sys_clk;          
input   [0:0]                      pe_1_1_sys_rstn;         
input   [31:0]                     HOST_S_AXI_araddr;       
input   [1:0]                      HOST_S_AXI_arburst;      
input   [3:0]                      HOST_S_AXI_arcache;      
input   [0:0]                      HOST_S_AXI_arid;         
input   [7:0]                      HOST_S_AXI_arlen;        
input   [0:0]                      HOST_S_AXI_arlock;       
input   [2:0]                      HOST_S_AXI_arprot;       
input   [3:0]                      HOST_S_AXI_arqos;        
input   [2:0]                      HOST_S_AXI_arsize;       
input   [0:0]                      HOST_S_AXI_arvalid;      
input   [31:0]                     HOST_S_AXI_awaddr;       
input   [1:0]                      HOST_S_AXI_awburst;      
input   [3:0]                      HOST_S_AXI_awcache;      
input   [0:0]                      HOST_S_AXI_awid;         
input   [7:0]                      HOST_S_AXI_awlen;        
input   [0:0]                      HOST_S_AXI_awlock;       
input   [2:0]                      HOST_S_AXI_awprot;       
input   [3:0]                      HOST_S_AXI_awqos;        
input   [2:0]                      HOST_S_AXI_awsize;       
input   [0:0]                      HOST_S_AXI_awvalid;      
input   [0:0]                      HOST_S_AXI_bready;       
input   [0:0]                      HOST_S_AXI_rready;       
input   [1023:0]                   HOST_S_AXI_wdata;        
input   [0:0]                      HOST_S_AXI_wlast;        
input   [127:0]                    HOST_S_AXI_wstrb;        
input   [0:0]                      HOST_S_AXI_wvalid;       
output  [0:0]                      HOST_S_AXI_arready;      
output  [0:0]                      HOST_S_AXI_awready;      
output  [0:0]                      HOST_S_AXI_bid;          
output  [1:0]                      HOST_S_AXI_bresp;        
output  [0:0]                      HOST_S_AXI_bvalid;       
output  [1023:0]                   HOST_S_AXI_rdata;        
output  [0:0]                      HOST_S_AXI_rid;          
output  [0:0]                      HOST_S_AXI_rlast;        
output  [1:0]                      HOST_S_AXI_rresp;        
output  [0:0]                      HOST_S_AXI_rvalid;       
output  [0:0]                      HOST_S_AXI_wready;       

wire    [0:0]                           pe_0_0_dispatcher_clk;     
wire    [0:0]                           pe_0_0_dsa_1_clk;          
wire    [0:0]                           pe_0_0_dsa_0_clk;          
wire    [0:0]                           pe_0_0_dsa_2_clk;          
wire    [0:0]                           pe_0_0_regular_1_clk;      
wire    [0:0]                           pe_0_0_mem_sub_sys_clk;    
wire    [0:0]                           pe_0_0_nou_clk;            
wire    [0:0]                           pe_0_0_regular_0_clk;      
wire    [0:0]                           pe_0_0_mem_sub_sys_rstn;   
wire    [0:0]                           pe_0_0_regular_0_rstn;     
wire    [0:0]                           pe_0_0_dsa_2_rstn;         
wire    [0:0]                           pe_0_0_nou_rstn;           
wire    [0:0]                           pe_0_0_dispatcher_rstn;    
wire    [0:0]                           pe_0_0_dsa_1_rstn;         
wire    [0:0]                           pe_0_0_regular_1_rstn;     
wire    [0:0]                           pe_0_0_dsa_0_rstn;         
wire    [0:0]                           pe_1_0_nou_clk;            
wire    [0:0]                           pe_1_0_dsa_0_clk;          
wire    [0:0]                           pe_1_0_regular_1_clk;      
wire    [0:0]                           pe_1_0_dispatcher_clk;     
wire    [0:0]                           pe_1_0_mem_sub_sys_clk;    
wire    [0:0]                           pe_1_0_dsa_1_clk;          
wire    [0:0]                           pe_1_0_regular_0_clk;      
wire    [0:0]                           pe_1_0_dsa_2_clk;          
wire    [0:0]                           pe_1_0_regular_1_rstn;     
wire    [0:0]                           pe_1_0_regular_0_rstn;     
wire    [0:0]                           pe_1_0_mem_sub_sys_rstn;   
wire    [0:0]                           pe_1_0_dsa_0_rstn;         
wire    [0:0]                           pe_1_0_dispatcher_rstn;    
wire    [0:0]                           pe_1_0_dsa_1_rstn;         
wire    [0:0]                           pe_1_0_nou_rstn;           
wire    [0:0]                           pe_1_0_dsa_2_rstn;         
wire    [0:0]                           pe_0_1_dsa_1_clk;          
wire    [0:0]                           pe_0_1_dispatcher_clk;     
wire    [0:0]                           pe_0_1_dsa_2_clk;          
wire    [0:0]                           pe_0_1_regular_0_clk;      
wire    [0:0]                           pe_0_1_regular_1_clk;      
wire    [0:0]                           pe_0_1_dsa_0_clk;          
wire    [0:0]                           pe_0_1_mem_sub_sys_clk;    
wire    [0:0]                           pe_0_1_nou_clk;            
wire    [0:0]                           pe_0_1_mem_sub_sys_rstn;   
wire    [0:0]                           pe_0_1_nou_rstn;           
wire    [0:0]                           pe_0_1_dsa_2_rstn;         
wire    [0:0]                           pe_0_1_regular_0_rstn;     
wire    [0:0]                           pe_0_1_dsa_0_rstn;         
wire    [0:0]                           pe_0_1_regular_1_rstn;     
wire    [0:0]                           pe_0_1_dispatcher_rstn;    
wire    [0:0]                           pe_0_1_dsa_1_rstn;         
wire    [0:0]                           pe_1_1_dispatcher_clk;     
wire    [0:0]                           pe_1_1_dsa_1_clk;          
wire    [0:0]                           pe_1_1_regular_1_clk;      
wire    [0:0]                           pe_1_1_regular_0_clk;      
wire    [0:0]                           pe_1_1_dsa_0_clk;          
wire    [0:0]                           pe_1_1_mem_sub_sys_clk;    
wire    [0:0]                           pe_1_1_nou_clk;            
wire    [0:0]                           pe_1_1_dsa_2_clk;          
wire    [0:0]                           pe_1_1_mem_sub_sys_rstn;   
wire    [0:0]                           pe_1_1_nou_rstn;           
wire    [0:0]                           pe_1_1_dsa_0_rstn;         
wire    [0:0]                           pe_1_1_dispatcher_rstn;    
wire    [0:0]                           pe_1_1_dsa_2_rstn;         
wire    [0:0]                           pe_1_1_regular_0_rstn;     
wire    [0:0]                           pe_1_1_regular_1_rstn;     
wire    [0:0]                           pe_1_1_dsa_1_rstn;         
wire    [0:0]                           pe_1_0_M_AXI_wvalid;       
wire    [0:0]                           pe_0_1_M_AXI_bvalid;       
wire    [3:0]                           pe_0_0_M_AXI_arcache;      
wire    [`AXI_MASTER_ID_WIDTH-1:0]      pe_0_1_M_AXI_bid;          
wire    [0:0]                           pe_0_1_M_AXI_wready;       
wire    [0:0]                           pe_1_0_M_AXI_rvalid;       
wire    [31:0]                          pe_1_1_M_AXI_awaddr;       
wire    [2:0]                           pe_0_0_M_AXI_awprot;       
wire    [`AXI_MASTER_ID_WIDTH-1:0]      pe_0_0_M_AXI_bid;          
wire    [0:0]                           pe_1_1_M_AXI_rlast;        
wire    [2:0]                           pe_1_0_M_AXI_awprot;       
wire    [3:0]                           pe_1_0_M_AXI_awqos;        
wire    [0:0]                           pe_1_1_M_AXI_awlock;       
wire    [0:0]                           pe_0_0_M_AXI_arlock;       
wire    [0:0]                           pe_1_1_M_AXI_arlock;       
wire    [2:0]                           pe_0_1_M_AXI_awprot;       
wire    [2:0]                           pe_1_1_M_AXI_awprot;       
wire    [2:0]                           pe_1_0_M_AXI_awsize;       
wire    [1023:0]                        pe_0_1_M_AXI_rdata;        
wire    [2:0]                           pe_1_1_M_AXI_arsize;       
wire    [0:0]                           pe_0_1_M_AXI_wvalid;       
wire    [3:0]                           pe_0_1_M_AXI_arcache;      
wire    [2:0]                           pe_0_0_M_AXI_arsize;       
wire    [1:0]                           pe_0_1_M_AXI_awburst;      
wire    [1023:0]                        pe_0_0_M_AXI_wdata;        
wire    [0:0]                           pe_1_0_M_AXI_bvalid;       
wire    [2:0]                           pe_0_0_M_AXI_awsize;       
wire    [0:0]                           pe_1_1_M_AXI_rready;       
wire    [7:0]                           pe_0_0_M_AXI_arlen;        
wire    [0:0]                           pe_1_1_M_AXI_awready;      
wire    [2:0]                           pe_0_1_M_AXI_arsize;       
wire    [1:0]                           pe_1_1_M_AXI_rresp;        
wire    [0:0]                           pe_0_1_M_AXI_wlast;        
wire    [0:0]                           pe_1_0_M_AXI_arvalid;      
wire    [1023:0]                        pe_0_0_M_AXI_rdata;        
wire    [0:0]                           pe_1_0_M_AXI_wlast;        
wire    [1023:0]                        pe_1_1_M_AXI_rdata;        
wire    [`AXI_MASTER_ID_WIDTH-1:0]      pe_0_0_M_AXI_rid;          
wire    [1:0]                           pe_1_1_M_AXI_arburst;      
wire    [3:0]                           pe_1_1_M_AXI_awqos;        
wire    [0:0]                           pe_1_0_M_AXI_arlock;       
wire    [0:0]                           pe_0_1_M_AXI_arready;      
wire    [0:0]                           pe_1_0_M_AXI_rlast;        
wire    [`AXI_MASTER_ID_WIDTH-1:0]      pe_1_1_M_AXI_rid;          
wire    [0:0]                           pe_0_0_M_AXI_wlast;        
wire    [0:0]                           pe_0_1_M_AXI_arvalid;      
wire    [0:0]                           pe_1_1_M_AXI_wvalid;       
wire    [3:0]                           pe_1_0_M_AXI_arcache;      
wire    [3:0]                           pe_0_0_M_AXI_awcache;      
wire    [0:0]                           pe_0_0_M_AXI_bvalid;       
wire    [31:0]                          pe_0_0_M_AXI_awaddr;       
wire    [0:0]                           pe_1_0_M_AXI_awlock;       
wire    [0:0]                           pe_0_0_M_AXI_rready;       
wire    [0:0]                           pe_1_1_M_AXI_bvalid;       
wire    [2:0]                           pe_0_0_M_AXI_arprot;       
wire    [7:0]                           pe_0_1_M_AXI_arlen;        
wire    [1023:0]                        pe_1_0_M_AXI_wdata;        
wire    [0:0]                           pe_0_0_M_AXI_awvalid;      
wire    [0:0]                           pe_1_1_M_AXI_rvalid;       
wire    [7:0]                           pe_1_1_M_AXI_arlen;        
wire    [1:0]                           pe_0_1_M_AXI_rresp;        
wire    [1:0]                           pe_0_1_M_AXI_arburst;      
wire    [`AXI_MASTER_ID_WIDTH-1:0]      pe_1_0_M_AXI_awid;         
wire    [31:0]                          pe_0_1_M_AXI_araddr;       
wire    [0:0]                           pe_0_0_M_AXI_arvalid;      
wire    [0:0]                           pe_0_0_M_AXI_awready;      
wire    [127:0]                         pe_1_1_M_AXI_wstrb;        
wire    [0:0]                           pe_0_1_M_AXI_rlast;        
wire    [1:0]                           pe_0_0_M_AXI_arburst;      
wire    [0:0]                           pe_1_1_M_AXI_bready;       
wire    [0:0]                           pe_1_1_M_AXI_arready;      
wire    [0:0]                           pe_0_0_M_AXI_rvalid;       
wire    [31:0]                          pe_1_0_M_AXI_awaddr;       
wire    [3:0]                           pe_0_0_M_AXI_arqos;        
wire    [0:0]                           pe_0_1_M_AXI_awlock;       
wire    [1:0]                           pe_1_1_M_AXI_awburst;      
wire    [127:0]                         pe_0_0_M_AXI_wstrb;        
wire    [1:0]                           pe_1_0_M_AXI_arburst;      
wire    [31:0]                          pe_1_1_M_AXI_araddr;       
wire    [2:0]                           pe_1_1_M_AXI_awsize;       
wire    [0:0]                           pe_1_0_M_AXI_arready;      
wire    [0:0]                           pe_0_1_M_AXI_rready;       
wire    [2:0]                           pe_1_0_M_AXI_arsize;       
wire    [`AXI_MASTER_ID_WIDTH-1:0]      pe_1_0_M_AXI_bid;          
wire    [`AXI_MASTER_ID_WIDTH-1:0]      pe_1_0_M_AXI_rid;          
wire    [`AXI_MASTER_ID_WIDTH-1:0]      pe_1_1_M_AXI_bid;          
wire    [`AXI_MASTER_ID_WIDTH-1:0]      pe_0_1_M_AXI_arid;         
wire    [3:0]                           pe_1_0_M_AXI_arqos;        
wire    [7:0]                           pe_1_1_M_AXI_awlen;        
wire    [0:0]                           pe_0_1_M_AXI_bready;       
wire    [3:0]                           pe_0_1_M_AXI_arqos;        
wire    [7:0]                           pe_1_0_M_AXI_arlen;        
wire    [`AXI_MASTER_ID_WIDTH-1:0]      pe_1_1_M_AXI_arid;         
wire    [1:0]                           pe_0_0_M_AXI_rresp;        
wire    [0:0]                           pe_0_1_M_AXI_awvalid;      
wire    [0:0]                           pe_1_1_M_AXI_wready;       
wire    [0:0]                           pe_0_1_M_AXI_awready;      
wire    [0:0]                           pe_1_0_M_AXI_awvalid;      
wire    [0:0]                           pe_1_0_M_AXI_bready;       
wire    [1:0]                           pe_1_1_M_AXI_bresp;        
wire    [7:0]                           pe_0_0_M_AXI_awlen;        
wire    [0:0]                           pe_0_0_M_AXI_arready;      
wire    [0:0]                           pe_0_0_M_AXI_rlast;        
wire    [0:0]                           pe_0_0_M_AXI_bready;       
wire    [1:0]                           pe_1_0_M_AXI_rresp;        
wire    [31:0]                          pe_0_1_M_AXI_awaddr;       
wire    [1:0]                           pe_0_0_M_AXI_awburst;      
wire    [0:0]                           pe_1_1_M_AXI_arvalid;      
wire    [0:0]                           pe_0_0_M_AXI_wready;       
wire    [3:0]                           pe_0_1_M_AXI_awqos;        
wire    [`AXI_MASTER_ID_WIDTH-1:0]      pe_1_1_M_AXI_awid;         
wire    [1:0]                           pe_0_0_M_AXI_bresp;        
wire    [3:0]                           pe_1_1_M_AXI_awcache;      
wire    [1:0]                           pe_1_0_M_AXI_bresp;        
wire    [1:0]                           pe_1_0_M_AXI_awburst;      
wire    [1023:0]                        pe_1_1_M_AXI_wdata;        
wire    [0:0]                           pe_0_1_M_AXI_arlock;       
wire    [`AXI_MASTER_ID_WIDTH-1:0]      pe_0_0_M_AXI_awid;         
wire    [0:0]                           pe_0_0_M_AXI_wvalid;       
wire    [7:0]                           pe_1_0_M_AXI_awlen;        
wire    [`AXI_MASTER_ID_WIDTH-1:0]      pe_0_0_M_AXI_arid;         
wire    [0:0]                           pe_0_0_M_AXI_awlock;       
wire    [`AXI_MASTER_ID_WIDTH-1:0]      pe_0_1_M_AXI_awid;         
wire    [2:0]                           pe_0_1_M_AXI_awsize;       
wire    [127:0]                         pe_1_0_M_AXI_wstrb;        
wire    [3:0]                           pe_0_1_M_AXI_awcache;      
wire    [3:0]                           pe_0_0_M_AXI_awqos;        
wire    [2:0]                           pe_1_0_M_AXI_arprot;       
wire    [`AXI_MASTER_ID_WIDTH-1:0]      pe_0_1_M_AXI_rid;          
wire    [0:0]                           pe_1_0_M_AXI_rready;       
wire    [31:0]                          pe_0_0_M_AXI_araddr;       
wire    [0:0]                           pe_1_1_M_AXI_awvalid;      
wire    [0:0]                           pe_1_1_M_AXI_wlast;        
wire    [0:0]                           pe_1_0_M_AXI_wready;       
wire    [3:0]                           pe_1_1_M_AXI_arcache;      
wire    [3:0]                           pe_1_1_M_AXI_arqos;        
wire    [1023:0]                        pe_0_1_M_AXI_wdata;        
wire    [127:0]                         pe_0_1_M_AXI_wstrb;        
wire    [31:0]                          pe_1_0_M_AXI_araddr;       
wire    [7:0]                           pe_0_1_M_AXI_awlen;        
wire    [2:0]                           pe_1_1_M_AXI_arprot;       
wire    [0:0]                           pe_1_0_M_AXI_awready;      
wire    [1:0]                           pe_0_1_M_AXI_bresp;        
wire    [`AXI_MASTER_ID_WIDTH-1:0]      pe_1_0_M_AXI_arid;         
wire    [2:0]                           pe_0_1_M_AXI_arprot;       
wire    [1023:0]                        pe_1_0_M_AXI_rdata;        
wire    [0:0]                           pe_0_1_M_AXI_rvalid;       
wire    [3:0]                           pe_1_0_M_AXI_awcache;      
wire    [0:0]                           pe_0_0_dispatcher_soft_rstn;
wire    [0:0]                           pe_0_0_dsa_0_soft_rstn;    
wire    [0:0]                           pe_0_0_nou_soft_rstn;      
wire    [0:0]                           pe_0_0_dsa_2_soft_rstn;    
wire    [0:0]                           pe_0_0_sram_soft_rstn;     
wire    [0:0]                           pe_0_0_dsa_1_soft_rstn;    
wire    [0:0]                           pe_0_0_regular_1_soft_rstn;
wire    [0:0]                           pe_0_0_regular_0_soft_rstn;
wire    [0:0]                           pe_1_0_dsa_0_soft_rstn;    
wire    [0:0]                           pe_1_0_regular_1_soft_rstn;
wire    [0:0]                           pe_1_0_regular_0_soft_rstn;
wire    [0:0]                           pe_1_0_dispatcher_soft_rstn;
wire    [0:0]                           pe_1_0_sram_soft_rstn;     
wire    [0:0]                           pe_1_0_dsa_1_soft_rstn;    
wire    [0:0]                           pe_1_0_dsa_2_soft_rstn;    
wire    [0:0]                           pe_1_0_nou_soft_rstn;      
wire    [0:0]                           pe_0_1_dsa_1_soft_rstn;    
wire    [0:0]                           pe_0_1_dsa_2_soft_rstn;    
wire    [0:0]                           pe_0_1_sram_soft_rstn;     
wire    [0:0]                           pe_0_1_dispatcher_soft_rstn;
wire    [0:0]                           pe_0_1_nou_soft_rstn;      
wire    [0:0]                           pe_0_1_dsa_0_soft_rstn;    
wire    [0:0]                           pe_0_1_regular_1_soft_rstn;
wire    [0:0]                           pe_0_1_regular_0_soft_rstn;
wire    [0:0]                           pe_1_1_dsa_1_soft_rstn;    
wire    [0:0]                           pe_1_1_dsa_0_soft_rstn;    
wire    [0:0]                           pe_1_1_regular_0_soft_rstn;
wire    [0:0]                           pe_1_1_nou_soft_rstn;      
wire    [0:0]                           pe_1_1_sram_soft_rstn;     
wire    [0:0]                           pe_1_1_dispatcher_soft_rstn;
wire    [0:0]                           pe_1_1_regular_1_soft_rstn;
wire    [0:0]                           pe_1_1_dsa_2_soft_rstn;    
wire    [32-1:0]                        sys_reg_AXI_awaddr;        
wire    [4-1:0]                         sys_reg_AXI_rid;           
wire    [7:0]                           sys_reg_AXI_awlen;         
wire    [(32/8)-1:0]                    sys_reg_AXI_wstrb;         
wire    [0:0]                           sys_reg_AXI_rvalid;        
wire    [0:0]                           sys_reg_AXI_arlock;        
wire    [4-1:0]                         sys_reg_AXI_bid;           
wire    [1:0]                           sys_reg_AXI_rresp;         
wire    [0:0]                           sys_reg_AXI_awready;       
wire    [1:0]                           sys_reg_AXI_arburst;       
wire    [3:0]                           sys_reg_AXI_arcache;       
wire    [1:0]                           sys_reg_AXI_awburst;       
wire    [0:0]                           sys_reg_AXI_rlast;         
wire    [0:0]                           sys_reg_AXI_wvalid;        
wire    [4-1:0]                         sys_reg_AXI_awid;          
wire    [0:0]                           sys_reg_AXI_bready;        
wire    [1:0]                           sys_reg_AXI_bresp;         
wire    [3:0]                           sys_reg_AXI_arqos;         
wire    [2:0]                           sys_reg_AXI_awsize;        
wire    [0:0]                           sys_reg_AXI_bvalid;        
wire    [32-1:0]                        sys_reg_AXI_araddr;        
wire    [7:0]                           sys_reg_AXI_arlen;         
wire    [0:0]                           sys_reg_AXI_rready;        
wire    [0:0]                           sys_reg_AXI_wlast;         
wire    [2:0]                           sys_reg_AXI_awprot;        
wire    [0:0]                           sys_reg_AXI_wready;        
wire    [2:0]                           sys_reg_AXI_arsize;        
wire    [0:0]                           sys_reg_AXI_awvalid;       
wire    [0:0]                           sys_reg_AXI_awlock;        
wire    [32-1:0]                        sys_reg_AXI_wdata;         
wire    [0:0]                           sys_reg_AXI_arvalid;       
wire    [3:0]                           sys_reg_AXI_awqos;         
wire    [2:0]                           sys_reg_AXI_arprot;        
wire    [4-1:0]                         sys_reg_AXI_arid;          
wire    [0:0]                           sys_reg_AXI_arready;       
wire    [32-1:0]                        sys_reg_AXI_rdata;         
wire    [3:0]                           sys_reg_AXI_awcache;       


// &Instance("pe_array_top"); @19
pe_array_top x_pe_array_top (
	.pe_0_0_regular_0_clk     (pe_0_0_regular_0_clk     ),
	.pe_0_0_regular_0_rstn    (pe_0_0_regular_0_rstn    ),
	.pe_0_0_regular_1_clk     (pe_0_0_regular_1_clk     ),
	.pe_0_0_regular_1_rstn    (pe_0_0_regular_1_rstn    ),
	.pe_0_0_nou_clk           (pe_0_0_nou_clk           ),
	.pe_0_0_nou_rstn          (pe_0_0_nou_rstn          ),
	.pe_0_0_dsa_2_clk         (pe_0_0_dsa_2_clk         ),
	.pe_0_0_dsa_2_rstn        (pe_0_0_dsa_2_rstn        ),
	.pe_0_0_dispatcher_clk    (pe_0_0_dispatcher_clk    ),
	.pe_0_0_dispatcher_rstn   (pe_0_0_dispatcher_rstn   ),
	.pe_0_0_dsa_0_clk         (pe_0_0_dsa_0_clk         ),
	.pe_0_0_dsa_0_rstn        (pe_0_0_dsa_0_rstn        ),
	.pe_0_0_dsa_1_clk         (pe_0_0_dsa_1_clk         ),
	.pe_0_0_dsa_1_rstn        (pe_0_0_dsa_1_rstn        ),
	.pe_0_0_dsa_0_m_dsa_0_clk (pe_0_0_dsa_0_m_dsa_0_clk ),
	.pe_0_0_dsa_0_m_dsa_0_rstn(pe_0_0_dsa_0_m_dsa_0_rstn),
	.pe_0_0_dsa_1_m_dsa_1_clk (pe_0_0_dsa_1_m_dsa_1_clk ),
	.pe_0_0_dsa_1_m_dsa_1_rstn(pe_0_0_dsa_1_m_dsa_1_rstn),
	.pe_0_0_dsa_2_m_dsa_2_clk (pe_0_0_dsa_2_m_dsa_2_clk ),
	.pe_0_0_dsa_2_m_dsa_2_rstn(pe_0_0_dsa_2_m_dsa_2_rstn),
	.pe_0_0_mem_sub_sys_clk   (pe_0_0_mem_sub_sys_clk   ),
	.pe_0_0_mem_sub_sys_rstn  (pe_0_0_mem_sub_sys_rstn  ),
	.pe_0_0_dat_W_out         (pe_0_0_dat_W_out         ),
	.pe_0_0_dat_vld_W_out     (pe_0_0_dat_vld_W_out     ),
	.pe_0_0_dat_yummy_W_in    (pe_0_0_dat_yummy_W_in    ),
	.pe_0_0_dat_W_in          (pe_0_0_dat_W_in          ),
	.pe_0_0_dat_vld_W_in      (pe_0_0_dat_vld_W_in      ),
	.pe_0_0_dat_yummy_W_out   (pe_0_0_dat_yummy_W_out   ),
	.pe_0_0_rsp_W_out         (pe_0_0_rsp_W_out         ),
	.pe_0_0_rsp_vld_W_out     (pe_0_0_rsp_vld_W_out     ),
	.pe_0_0_rsp_yummy_W_in    (pe_0_0_rsp_yummy_W_in    ),
	.pe_0_0_rsp_W_in          (pe_0_0_rsp_W_in          ),
	.pe_0_0_rsp_vld_W_in      (pe_0_0_rsp_vld_W_in      ),
	.pe_0_0_rsp_yummy_W_out   (pe_0_0_rsp_yummy_W_out   ),
	.pe_0_0_dat_S_out         (pe_0_0_dat_S_out         ),
	.pe_0_0_dat_vld_S_out     (pe_0_0_dat_vld_S_out     ),
	.pe_0_0_dat_yummy_S_in    (pe_0_0_dat_yummy_S_in    ),
	.pe_0_0_dat_S_in          (pe_0_0_dat_S_in          ),
	.pe_0_0_dat_vld_S_in      (pe_0_0_dat_vld_S_in      ),
	.pe_0_0_dat_yummy_S_out   (pe_0_0_dat_yummy_S_out   ),
	.pe_0_0_rsp_S_out         (pe_0_0_rsp_S_out         ),
	.pe_0_0_rsp_vld_S_out     (pe_0_0_rsp_vld_S_out     ),
	.pe_0_0_rsp_yummy_S_in    (pe_0_0_rsp_yummy_S_in    ),
	.pe_0_0_rsp_S_in          (pe_0_0_rsp_S_in          ),
	.pe_0_0_rsp_vld_S_in      (pe_0_0_rsp_vld_S_in      ),
	.pe_0_0_rsp_yummy_S_out   (pe_0_0_rsp_yummy_S_out   ),
	.pe_0_0_sys_clk           (pe_0_0_sys_clk           ),
	.pe_0_0_sys_rstn          (pe_0_0_sys_rstn          ),
	.pe_0_0_S_HOST_AXI_aclk   (sys_clk                  ),
	.pe_0_0_S_HOST_AXI_araddr (pe_0_0_M_AXI_araddr      ),
	.pe_0_0_S_HOST_AXI_arburst(pe_0_0_M_AXI_arburst     ),
	.pe_0_0_S_HOST_AXI_arcache(pe_0_0_M_AXI_arcache     ),
	.pe_0_0_S_HOST_AXI_aresetn(sys_rstn                 ),
	.pe_0_0_S_HOST_AXI_arid   (pe_0_0_M_AXI_arid        ),
	.pe_0_0_S_HOST_AXI_arlen  (pe_0_0_M_AXI_arlen       ),
	.pe_0_0_S_HOST_AXI_arlock (pe_0_0_M_AXI_arlock      ),
	.pe_0_0_S_HOST_AXI_arprot (pe_0_0_M_AXI_arprot      ),
	.pe_0_0_S_HOST_AXI_arqos  (pe_0_0_M_AXI_arqos       ),
	.pe_0_0_S_HOST_AXI_arsize (pe_0_0_M_AXI_arsize      ),
	.pe_0_0_S_HOST_AXI_arvalid(pe_0_0_M_AXI_arvalid     ),
	.pe_0_0_S_HOST_AXI_awaddr (pe_0_0_M_AXI_awaddr      ),
	.pe_0_0_S_HOST_AXI_awburst(pe_0_0_M_AXI_awburst     ),
	.pe_0_0_S_HOST_AXI_awcache(pe_0_0_M_AXI_awcache     ),
	.pe_0_0_S_HOST_AXI_awid   (pe_0_0_M_AXI_awid        ),
	.pe_0_0_S_HOST_AXI_awlen  (pe_0_0_M_AXI_awlen       ),
	.pe_0_0_S_HOST_AXI_awlock (pe_0_0_M_AXI_awlock      ),
	.pe_0_0_S_HOST_AXI_awprot (pe_0_0_M_AXI_awprot      ),
	.pe_0_0_S_HOST_AXI_awqos  (pe_0_0_M_AXI_awqos       ),
	.pe_0_0_S_HOST_AXI_awsize (pe_0_0_M_AXI_awsize      ),
	.pe_0_0_S_HOST_AXI_awvalid(pe_0_0_M_AXI_awvalid     ),
	.pe_0_0_S_HOST_AXI_bready (pe_0_0_M_AXI_bready      ),
	.pe_0_0_S_HOST_AXI_rready (pe_0_0_M_AXI_rready      ),
	.pe_0_0_S_HOST_AXI_wdata  (pe_0_0_M_AXI_wdata       ),
	.pe_0_0_S_HOST_AXI_wlast  (pe_0_0_M_AXI_wlast       ),
	.pe_0_0_S_HOST_AXI_wstrb  (pe_0_0_M_AXI_wstrb       ),
	.pe_0_0_S_HOST_AXI_wvalid (pe_0_0_M_AXI_wvalid      ),
	.pe_0_0_S_HOST_AXI_arready(pe_0_0_M_AXI_arready     ),
	.pe_0_0_S_HOST_AXI_awready(pe_0_0_M_AXI_awready     ),
	.pe_0_0_S_HOST_AXI_bid    (pe_0_0_M_AXI_bid         ),
	.pe_0_0_S_HOST_AXI_bresp  (pe_0_0_M_AXI_bresp       ),
	.pe_0_0_S_HOST_AXI_bvalid (pe_0_0_M_AXI_bvalid      ),
	.pe_0_0_S_HOST_AXI_rdata  (pe_0_0_M_AXI_rdata       ),
	.pe_0_0_S_HOST_AXI_rid    (pe_0_0_M_AXI_rid         ),
	.pe_0_0_S_HOST_AXI_rlast  (pe_0_0_M_AXI_rlast       ),
	.pe_0_0_S_HOST_AXI_rresp  (pe_0_0_M_AXI_rresp       ),
	.pe_0_0_S_HOST_AXI_rvalid (pe_0_0_M_AXI_rvalid      ),
	.pe_0_0_S_HOST_AXI_wready (pe_0_0_M_AXI_wready      ),
	.pe_1_0_regular_0_clk     (pe_1_0_regular_0_clk     ),
	.pe_1_0_regular_0_rstn    (pe_1_0_regular_0_rstn    ),
	.pe_1_0_regular_1_clk     (pe_1_0_regular_1_clk     ),
	.pe_1_0_regular_1_rstn    (pe_1_0_regular_1_rstn    ),
	.pe_1_0_nou_clk           (pe_1_0_nou_clk           ),
	.pe_1_0_nou_rstn          (pe_1_0_nou_rstn          ),
	.pe_1_0_dsa_2_clk         (pe_1_0_dsa_2_clk         ),
	.pe_1_0_dsa_2_rstn        (pe_1_0_dsa_2_rstn        ),
	.pe_1_0_dispatcher_clk    (pe_1_0_dispatcher_clk    ),
	.pe_1_0_dispatcher_rstn   (pe_1_0_dispatcher_rstn   ),
	.pe_1_0_dsa_0_clk         (pe_1_0_dsa_0_clk         ),
	.pe_1_0_dsa_0_rstn        (pe_1_0_dsa_0_rstn        ),
	.pe_1_0_dsa_1_clk         (pe_1_0_dsa_1_clk         ),
	.pe_1_0_dsa_1_rstn        (pe_1_0_dsa_1_rstn        ),
	.pe_1_0_dsa_0_m_dsa_0_clk (pe_1_0_dsa_0_m_dsa_0_clk ),
	.pe_1_0_dsa_0_m_dsa_0_rstn(pe_1_0_dsa_0_m_dsa_0_rstn),
	.pe_1_0_dsa_1_m_dsa_1_clk (pe_1_0_dsa_1_m_dsa_1_clk ),
	.pe_1_0_dsa_1_m_dsa_1_rstn(pe_1_0_dsa_1_m_dsa_1_rstn),
	.pe_1_0_dsa_2_m_dsa_2_clk (pe_1_0_dsa_2_m_dsa_2_clk ),
	.pe_1_0_dsa_2_m_dsa_2_rstn(pe_1_0_dsa_2_m_dsa_2_rstn),
	.pe_1_0_mem_sub_sys_clk   (pe_1_0_mem_sub_sys_clk   ),
	.pe_1_0_mem_sub_sys_rstn  (pe_1_0_mem_sub_sys_rstn  ),
	.pe_1_0_dat_E_out         (pe_1_0_dat_E_out         ),
	.pe_1_0_dat_vld_E_out     (pe_1_0_dat_vld_E_out     ),
	.pe_1_0_dat_yummy_E_in    (pe_1_0_dat_yummy_E_in    ),
	.pe_1_0_dat_E_in          (pe_1_0_dat_E_in          ),
	.pe_1_0_dat_vld_E_in      (pe_1_0_dat_vld_E_in      ),
	.pe_1_0_dat_yummy_E_out   (pe_1_0_dat_yummy_E_out   ),
	.pe_1_0_rsp_E_out         (pe_1_0_rsp_E_out         ),
	.pe_1_0_rsp_vld_E_out     (pe_1_0_rsp_vld_E_out     ),
	.pe_1_0_rsp_yummy_E_in    (pe_1_0_rsp_yummy_E_in    ),
	.pe_1_0_rsp_E_in          (pe_1_0_rsp_E_in          ),
	.pe_1_0_rsp_vld_E_in      (pe_1_0_rsp_vld_E_in      ),
	.pe_1_0_rsp_yummy_E_out   (pe_1_0_rsp_yummy_E_out   ),
	.pe_1_0_dat_S_out         (pe_1_0_dat_S_out         ),
	.pe_1_0_dat_vld_S_out     (pe_1_0_dat_vld_S_out     ),
	.pe_1_0_dat_yummy_S_in    (pe_1_0_dat_yummy_S_in    ),
	.pe_1_0_dat_S_in          (pe_1_0_dat_S_in          ),
	.pe_1_0_dat_vld_S_in      (pe_1_0_dat_vld_S_in      ),
	.pe_1_0_dat_yummy_S_out   (pe_1_0_dat_yummy_S_out   ),
	.pe_1_0_rsp_S_out         (pe_1_0_rsp_S_out         ),
	.pe_1_0_rsp_vld_S_out     (pe_1_0_rsp_vld_S_out     ),
	.pe_1_0_rsp_yummy_S_in    (pe_1_0_rsp_yummy_S_in    ),
	.pe_1_0_rsp_S_in          (pe_1_0_rsp_S_in          ),
	.pe_1_0_rsp_vld_S_in      (pe_1_0_rsp_vld_S_in      ),
	.pe_1_0_rsp_yummy_S_out   (pe_1_0_rsp_yummy_S_out   ),
	.pe_1_0_sys_clk           (pe_1_0_sys_clk           ),
	.pe_1_0_sys_rstn          (pe_1_0_sys_rstn          ),
	.pe_1_0_S_HOST_AXI_aclk   (sys_clk                  ),
	.pe_1_0_S_HOST_AXI_araddr (pe_1_0_M_AXI_araddr      ),
	.pe_1_0_S_HOST_AXI_arburst(pe_1_0_M_AXI_arburst     ),
	.pe_1_0_S_HOST_AXI_arcache(pe_1_0_M_AXI_arcache     ),
	.pe_1_0_S_HOST_AXI_aresetn(sys_rstn                 ),
	.pe_1_0_S_HOST_AXI_arid   (pe_1_0_M_AXI_arid        ),
	.pe_1_0_S_HOST_AXI_arlen  (pe_1_0_M_AXI_arlen       ),
	.pe_1_0_S_HOST_AXI_arlock (pe_1_0_M_AXI_arlock      ),
	.pe_1_0_S_HOST_AXI_arprot (pe_1_0_M_AXI_arprot      ),
	.pe_1_0_S_HOST_AXI_arqos  (pe_1_0_M_AXI_arqos       ),
	.pe_1_0_S_HOST_AXI_arsize (pe_1_0_M_AXI_arsize      ),
	.pe_1_0_S_HOST_AXI_arvalid(pe_1_0_M_AXI_arvalid     ),
	.pe_1_0_S_HOST_AXI_awaddr (pe_1_0_M_AXI_awaddr      ),
	.pe_1_0_S_HOST_AXI_awburst(pe_1_0_M_AXI_awburst     ),
	.pe_1_0_S_HOST_AXI_awcache(pe_1_0_M_AXI_awcache     ),
	.pe_1_0_S_HOST_AXI_awid   (pe_1_0_M_AXI_awid        ),
	.pe_1_0_S_HOST_AXI_awlen  (pe_1_0_M_AXI_awlen       ),
	.pe_1_0_S_HOST_AXI_awlock (pe_1_0_M_AXI_awlock      ),
	.pe_1_0_S_HOST_AXI_awprot (pe_1_0_M_AXI_awprot      ),
	.pe_1_0_S_HOST_AXI_awqos  (pe_1_0_M_AXI_awqos       ),
	.pe_1_0_S_HOST_AXI_awsize (pe_1_0_M_AXI_awsize      ),
	.pe_1_0_S_HOST_AXI_awvalid(pe_1_0_M_AXI_awvalid     ),
	.pe_1_0_S_HOST_AXI_bready (pe_1_0_M_AXI_bready      ),
	.pe_1_0_S_HOST_AXI_rready (pe_1_0_M_AXI_rready      ),
	.pe_1_0_S_HOST_AXI_wdata  (pe_1_0_M_AXI_wdata       ),
	.pe_1_0_S_HOST_AXI_wlast  (pe_1_0_M_AXI_wlast       ),
	.pe_1_0_S_HOST_AXI_wstrb  (pe_1_0_M_AXI_wstrb       ),
	.pe_1_0_S_HOST_AXI_wvalid (pe_1_0_M_AXI_wvalid      ),
	.pe_1_0_S_HOST_AXI_arready(pe_1_0_M_AXI_arready     ),
	.pe_1_0_S_HOST_AXI_awready(pe_1_0_M_AXI_awready     ),
	.pe_1_0_S_HOST_AXI_bid    (pe_1_0_M_AXI_bid         ),
	.pe_1_0_S_HOST_AXI_bresp  (pe_1_0_M_AXI_bresp       ),
	.pe_1_0_S_HOST_AXI_bvalid (pe_1_0_M_AXI_bvalid      ),
	.pe_1_0_S_HOST_AXI_rdata  (pe_1_0_M_AXI_rdata       ),
	.pe_1_0_S_HOST_AXI_rid    (pe_1_0_M_AXI_rid         ),
	.pe_1_0_S_HOST_AXI_rlast  (pe_1_0_M_AXI_rlast       ),
	.pe_1_0_S_HOST_AXI_rresp  (pe_1_0_M_AXI_rresp       ),
	.pe_1_0_S_HOST_AXI_rvalid (pe_1_0_M_AXI_rvalid      ),
	.pe_1_0_S_HOST_AXI_wready (pe_1_0_M_AXI_wready      ),
	.pe_0_1_regular_0_clk     (pe_0_1_regular_0_clk     ),
	.pe_0_1_regular_0_rstn    (pe_0_1_regular_0_rstn    ),
	.pe_0_1_regular_1_clk     (pe_0_1_regular_1_clk     ),
	.pe_0_1_regular_1_rstn    (pe_0_1_regular_1_rstn    ),
	.pe_0_1_nou_clk           (pe_0_1_nou_clk           ),
	.pe_0_1_nou_rstn          (pe_0_1_nou_rstn          ),
	.pe_0_1_dsa_2_clk         (pe_0_1_dsa_2_clk         ),
	.pe_0_1_dsa_2_rstn        (pe_0_1_dsa_2_rstn        ),
	.pe_0_1_dispatcher_clk    (pe_0_1_dispatcher_clk    ),
	.pe_0_1_dispatcher_rstn   (pe_0_1_dispatcher_rstn   ),
	.pe_0_1_dsa_0_clk         (pe_0_1_dsa_0_clk         ),
	.pe_0_1_dsa_0_rstn        (pe_0_1_dsa_0_rstn        ),
	.pe_0_1_dsa_1_clk         (pe_0_1_dsa_1_clk         ),
	.pe_0_1_dsa_1_rstn        (pe_0_1_dsa_1_rstn        ),
	.pe_0_1_dsa_0_m_dsa_0_clk (pe_0_1_dsa_0_m_dsa_0_clk ),
	.pe_0_1_dsa_0_m_dsa_0_rstn(pe_0_1_dsa_0_m_dsa_0_rstn),
	.pe_0_1_dsa_1_m_dsa_1_clk (pe_0_1_dsa_1_m_dsa_1_clk ),
	.pe_0_1_dsa_1_m_dsa_1_rstn(pe_0_1_dsa_1_m_dsa_1_rstn),
	.pe_0_1_dsa_2_m_dsa_2_clk (pe_0_1_dsa_2_m_dsa_2_clk ),
	.pe_0_1_dsa_2_m_dsa_2_rstn(pe_0_1_dsa_2_m_dsa_2_rstn),
	.pe_0_1_mem_sub_sys_clk   (pe_0_1_mem_sub_sys_clk   ),
	.pe_0_1_mem_sub_sys_rstn  (pe_0_1_mem_sub_sys_rstn  ),
	.pe_0_1_dat_W_out         (pe_0_1_dat_W_out         ),
	.pe_0_1_dat_vld_W_out     (pe_0_1_dat_vld_W_out     ),
	.pe_0_1_dat_yummy_W_in    (pe_0_1_dat_yummy_W_in    ),
	.pe_0_1_dat_W_in          (pe_0_1_dat_W_in          ),
	.pe_0_1_dat_vld_W_in      (pe_0_1_dat_vld_W_in      ),
	.pe_0_1_dat_yummy_W_out   (pe_0_1_dat_yummy_W_out   ),
	.pe_0_1_rsp_W_out         (pe_0_1_rsp_W_out         ),
	.pe_0_1_rsp_vld_W_out     (pe_0_1_rsp_vld_W_out     ),
	.pe_0_1_rsp_yummy_W_in    (pe_0_1_rsp_yummy_W_in    ),
	.pe_0_1_rsp_W_in          (pe_0_1_rsp_W_in          ),
	.pe_0_1_rsp_vld_W_in      (pe_0_1_rsp_vld_W_in      ),
	.pe_0_1_rsp_yummy_W_out   (pe_0_1_rsp_yummy_W_out   ),
	.pe_0_1_dat_N_out         (pe_0_1_dat_N_out         ),
	.pe_0_1_dat_vld_N_out     (pe_0_1_dat_vld_N_out     ),
	.pe_0_1_dat_yummy_N_in    (pe_0_1_dat_yummy_N_in    ),
	.pe_0_1_dat_N_in          (pe_0_1_dat_N_in          ),
	.pe_0_1_dat_vld_N_in      (pe_0_1_dat_vld_N_in      ),
	.pe_0_1_dat_yummy_N_out   (pe_0_1_dat_yummy_N_out   ),
	.pe_0_1_rsp_N_out         (pe_0_1_rsp_N_out         ),
	.pe_0_1_rsp_vld_N_out     (pe_0_1_rsp_vld_N_out     ),
	.pe_0_1_rsp_yummy_N_in    (pe_0_1_rsp_yummy_N_in    ),
	.pe_0_1_rsp_N_in          (pe_0_1_rsp_N_in          ),
	.pe_0_1_rsp_vld_N_in      (pe_0_1_rsp_vld_N_in      ),
	.pe_0_1_rsp_yummy_N_out   (pe_0_1_rsp_yummy_N_out   ),
	.pe_0_1_sys_clk           (pe_0_1_sys_clk           ),
	.pe_0_1_sys_rstn          (pe_0_1_sys_rstn          ),
	.pe_0_1_S_HOST_AXI_aclk   (sys_clk                  ),
	.pe_0_1_S_HOST_AXI_araddr (pe_0_1_M_AXI_araddr      ),
	.pe_0_1_S_HOST_AXI_arburst(pe_0_1_M_AXI_arburst     ),
	.pe_0_1_S_HOST_AXI_arcache(pe_0_1_M_AXI_arcache     ),
	.pe_0_1_S_HOST_AXI_aresetn(sys_rstn                 ),
	.pe_0_1_S_HOST_AXI_arid   (pe_0_1_M_AXI_arid        ),
	.pe_0_1_S_HOST_AXI_arlen  (pe_0_1_M_AXI_arlen       ),
	.pe_0_1_S_HOST_AXI_arlock (pe_0_1_M_AXI_arlock      ),
	.pe_0_1_S_HOST_AXI_arprot (pe_0_1_M_AXI_arprot      ),
	.pe_0_1_S_HOST_AXI_arqos  (pe_0_1_M_AXI_arqos       ),
	.pe_0_1_S_HOST_AXI_arsize (pe_0_1_M_AXI_arsize      ),
	.pe_0_1_S_HOST_AXI_arvalid(pe_0_1_M_AXI_arvalid     ),
	.pe_0_1_S_HOST_AXI_awaddr (pe_0_1_M_AXI_awaddr      ),
	.pe_0_1_S_HOST_AXI_awburst(pe_0_1_M_AXI_awburst     ),
	.pe_0_1_S_HOST_AXI_awcache(pe_0_1_M_AXI_awcache     ),
	.pe_0_1_S_HOST_AXI_awid   (pe_0_1_M_AXI_awid        ),
	.pe_0_1_S_HOST_AXI_awlen  (pe_0_1_M_AXI_awlen       ),
	.pe_0_1_S_HOST_AXI_awlock (pe_0_1_M_AXI_awlock      ),
	.pe_0_1_S_HOST_AXI_awprot (pe_0_1_M_AXI_awprot      ),
	.pe_0_1_S_HOST_AXI_awqos  (pe_0_1_M_AXI_awqos       ),
	.pe_0_1_S_HOST_AXI_awsize (pe_0_1_M_AXI_awsize      ),
	.pe_0_1_S_HOST_AXI_awvalid(pe_0_1_M_AXI_awvalid     ),
	.pe_0_1_S_HOST_AXI_bready (pe_0_1_M_AXI_bready      ),
	.pe_0_1_S_HOST_AXI_rready (pe_0_1_M_AXI_rready      ),
	.pe_0_1_S_HOST_AXI_wdata  (pe_0_1_M_AXI_wdata       ),
	.pe_0_1_S_HOST_AXI_wlast  (pe_0_1_M_AXI_wlast       ),
	.pe_0_1_S_HOST_AXI_wstrb  (pe_0_1_M_AXI_wstrb       ),
	.pe_0_1_S_HOST_AXI_wvalid (pe_0_1_M_AXI_wvalid      ),
	.pe_0_1_S_HOST_AXI_arready(pe_0_1_M_AXI_arready     ),
	.pe_0_1_S_HOST_AXI_awready(pe_0_1_M_AXI_awready     ),
	.pe_0_1_S_HOST_AXI_bid    (pe_0_1_M_AXI_bid         ),
	.pe_0_1_S_HOST_AXI_bresp  (pe_0_1_M_AXI_bresp       ),
	.pe_0_1_S_HOST_AXI_bvalid (pe_0_1_M_AXI_bvalid      ),
	.pe_0_1_S_HOST_AXI_rdata  (pe_0_1_M_AXI_rdata       ),
	.pe_0_1_S_HOST_AXI_rid    (pe_0_1_M_AXI_rid         ),
	.pe_0_1_S_HOST_AXI_rlast  (pe_0_1_M_AXI_rlast       ),
	.pe_0_1_S_HOST_AXI_rresp  (pe_0_1_M_AXI_rresp       ),
	.pe_0_1_S_HOST_AXI_rvalid (pe_0_1_M_AXI_rvalid      ),
	.pe_0_1_S_HOST_AXI_wready (pe_0_1_M_AXI_wready      ),
	.pe_1_1_regular_0_clk     (pe_1_1_regular_0_clk     ),
	.pe_1_1_regular_0_rstn    (pe_1_1_regular_0_rstn    ),
	.pe_1_1_regular_1_clk     (pe_1_1_regular_1_clk     ),
	.pe_1_1_regular_1_rstn    (pe_1_1_regular_1_rstn    ),
	.pe_1_1_nou_clk           (pe_1_1_nou_clk           ),
	.pe_1_1_nou_rstn          (pe_1_1_nou_rstn          ),
	.pe_1_1_dsa_2_clk         (pe_1_1_dsa_2_clk         ),
	.pe_1_1_dsa_2_rstn        (pe_1_1_dsa_2_rstn        ),
	.pe_1_1_dispatcher_clk    (pe_1_1_dispatcher_clk    ),
	.pe_1_1_dispatcher_rstn   (pe_1_1_dispatcher_rstn   ),
	.pe_1_1_dsa_0_clk         (pe_1_1_dsa_0_clk         ),
	.pe_1_1_dsa_0_rstn        (pe_1_1_dsa_0_rstn        ),
	.pe_1_1_dsa_1_clk         (pe_1_1_dsa_1_clk         ),
	.pe_1_1_dsa_1_rstn        (pe_1_1_dsa_1_rstn        ),
	.pe_1_1_dsa_0_m_dsa_0_clk (pe_1_1_dsa_0_m_dsa_0_clk ),
	.pe_1_1_dsa_0_m_dsa_0_rstn(pe_1_1_dsa_0_m_dsa_0_rstn),
	.pe_1_1_dsa_1_m_dsa_1_clk (pe_1_1_dsa_1_m_dsa_1_clk ),
	.pe_1_1_dsa_1_m_dsa_1_rstn(pe_1_1_dsa_1_m_dsa_1_rstn),
	.pe_1_1_dsa_2_m_dsa_2_clk (pe_1_1_dsa_2_m_dsa_2_clk ),
	.pe_1_1_dsa_2_m_dsa_2_rstn(pe_1_1_dsa_2_m_dsa_2_rstn),
	.pe_1_1_mem_sub_sys_clk   (pe_1_1_mem_sub_sys_clk   ),
	.pe_1_1_mem_sub_sys_rstn  (pe_1_1_mem_sub_sys_rstn  ),
	.pe_1_1_dat_E_out         (pe_1_1_dat_E_out         ),
	.pe_1_1_dat_vld_E_out     (pe_1_1_dat_vld_E_out     ),
	.pe_1_1_dat_yummy_E_in    (pe_1_1_dat_yummy_E_in    ),
	.pe_1_1_dat_E_in          (pe_1_1_dat_E_in          ),
	.pe_1_1_dat_vld_E_in      (pe_1_1_dat_vld_E_in      ),
	.pe_1_1_dat_yummy_E_out   (pe_1_1_dat_yummy_E_out   ),
	.pe_1_1_rsp_E_out         (pe_1_1_rsp_E_out         ),
	.pe_1_1_rsp_vld_E_out     (pe_1_1_rsp_vld_E_out     ),
	.pe_1_1_rsp_yummy_E_in    (pe_1_1_rsp_yummy_E_in    ),
	.pe_1_1_rsp_E_in          (pe_1_1_rsp_E_in          ),
	.pe_1_1_rsp_vld_E_in      (pe_1_1_rsp_vld_E_in      ),
	.pe_1_1_rsp_yummy_E_out   (pe_1_1_rsp_yummy_E_out   ),
	.pe_1_1_dat_N_out         (pe_1_1_dat_N_out         ),
	.pe_1_1_dat_vld_N_out     (pe_1_1_dat_vld_N_out     ),
	.pe_1_1_dat_yummy_N_in    (pe_1_1_dat_yummy_N_in    ),
	.pe_1_1_dat_N_in          (pe_1_1_dat_N_in          ),
	.pe_1_1_dat_vld_N_in      (pe_1_1_dat_vld_N_in      ),
	.pe_1_1_dat_yummy_N_out   (pe_1_1_dat_yummy_N_out   ),
	.pe_1_1_rsp_N_out         (pe_1_1_rsp_N_out         ),
	.pe_1_1_rsp_vld_N_out     (pe_1_1_rsp_vld_N_out     ),
	.pe_1_1_rsp_yummy_N_in    (pe_1_1_rsp_yummy_N_in    ),
	.pe_1_1_rsp_N_in          (pe_1_1_rsp_N_in          ),
	.pe_1_1_rsp_vld_N_in      (pe_1_1_rsp_vld_N_in      ),
	.pe_1_1_rsp_yummy_N_out   (pe_1_1_rsp_yummy_N_out   ),
	.pe_1_1_sys_clk           (pe_1_1_sys_clk           ),
	.pe_1_1_sys_rstn          (pe_1_1_sys_rstn          ),
	.pe_1_1_S_HOST_AXI_aclk   (sys_clk                  ),
	.pe_1_1_S_HOST_AXI_araddr (pe_1_1_M_AXI_araddr      ),
	.pe_1_1_S_HOST_AXI_arburst(pe_1_1_M_AXI_arburst     ),
	.pe_1_1_S_HOST_AXI_arcache(pe_1_1_M_AXI_arcache     ),
	.pe_1_1_S_HOST_AXI_aresetn(sys_rstn                 ),
	.pe_1_1_S_HOST_AXI_arid   (pe_1_1_M_AXI_arid        ),
	.pe_1_1_S_HOST_AXI_arlen  (pe_1_1_M_AXI_arlen       ),
	.pe_1_1_S_HOST_AXI_arlock (pe_1_1_M_AXI_arlock      ),
	.pe_1_1_S_HOST_AXI_arprot (pe_1_1_M_AXI_arprot      ),
	.pe_1_1_S_HOST_AXI_arqos  (pe_1_1_M_AXI_arqos       ),
	.pe_1_1_S_HOST_AXI_arsize (pe_1_1_M_AXI_arsize      ),
	.pe_1_1_S_HOST_AXI_arvalid(pe_1_1_M_AXI_arvalid     ),
	.pe_1_1_S_HOST_AXI_awaddr (pe_1_1_M_AXI_awaddr      ),
	.pe_1_1_S_HOST_AXI_awburst(pe_1_1_M_AXI_awburst     ),
	.pe_1_1_S_HOST_AXI_awcache(pe_1_1_M_AXI_awcache     ),
	.pe_1_1_S_HOST_AXI_awid   (pe_1_1_M_AXI_awid        ),
	.pe_1_1_S_HOST_AXI_awlen  (pe_1_1_M_AXI_awlen       ),
	.pe_1_1_S_HOST_AXI_awlock (pe_1_1_M_AXI_awlock      ),
	.pe_1_1_S_HOST_AXI_awprot (pe_1_1_M_AXI_awprot      ),
	.pe_1_1_S_HOST_AXI_awqos  (pe_1_1_M_AXI_awqos       ),
	.pe_1_1_S_HOST_AXI_awsize (pe_1_1_M_AXI_awsize      ),
	.pe_1_1_S_HOST_AXI_awvalid(pe_1_1_M_AXI_awvalid     ),
	.pe_1_1_S_HOST_AXI_bready (pe_1_1_M_AXI_bready      ),
	.pe_1_1_S_HOST_AXI_rready (pe_1_1_M_AXI_rready      ),
	.pe_1_1_S_HOST_AXI_wdata  (pe_1_1_M_AXI_wdata       ),
	.pe_1_1_S_HOST_AXI_wlast  (pe_1_1_M_AXI_wlast       ),
	.pe_1_1_S_HOST_AXI_wstrb  (pe_1_1_M_AXI_wstrb       ),
	.pe_1_1_S_HOST_AXI_wvalid (pe_1_1_M_AXI_wvalid      ),
	.pe_1_1_S_HOST_AXI_arready(pe_1_1_M_AXI_arready     ),
	.pe_1_1_S_HOST_AXI_awready(pe_1_1_M_AXI_awready     ),
	.pe_1_1_S_HOST_AXI_bid    (pe_1_1_M_AXI_bid         ),
	.pe_1_1_S_HOST_AXI_bresp  (pe_1_1_M_AXI_bresp       ),
	.pe_1_1_S_HOST_AXI_bvalid (pe_1_1_M_AXI_bvalid      ),
	.pe_1_1_S_HOST_AXI_rdata  (pe_1_1_M_AXI_rdata       ),
	.pe_1_1_S_HOST_AXI_rid    (pe_1_1_M_AXI_rid         ),
	.pe_1_1_S_HOST_AXI_rlast  (pe_1_1_M_AXI_rlast       ),
	.pe_1_1_S_HOST_AXI_rresp  (pe_1_1_M_AXI_rresp       ),
	.pe_1_1_S_HOST_AXI_rvalid (pe_1_1_M_AXI_rvalid      ),
	.pe_1_1_S_HOST_AXI_wready (pe_1_1_M_AXI_wready      )
);
// @20 &ConnRule(r'retire_pc', r'pc');
// @21 &ConnRule(r'S_HOST', r'M');
// @22 &Connect(
// @23     .pe_0_0_S_HOST_AXI_aclk(sys_clk),
// @24     .pe_0_0_S_HOST_AXI_aresetn(sys_rstn),
// @25     .pe_1_0_S_HOST_AXI_aclk(sys_clk),
// @26     .pe_1_0_S_HOST_AXI_aresetn(sys_rstn),
// @27     .pe_0_1_S_HOST_AXI_aclk(sys_clk),
// @28     .pe_0_1_S_HOST_AXI_aresetn(sys_rstn),
// @29     .pe_1_1_S_HOST_AXI_aclk(sys_clk),
// @30     .pe_1_1_S_HOST_AXI_aresetn(sys_rstn),
// @31 );

// &Instance("pe_clkgen", "x_pe_0_0_clkgen"); @33
pe_clkgen x_pe_0_0_clkgen (
	.dispatcher_clk (pe_0_0_dispatcher_clk ),
	.regular_0_clk  (pe_0_0_regular_0_clk  ),
	.regular_1_clk  (pe_0_0_regular_1_clk  ),
	.dsa_0_clk      (pe_0_0_dsa_0_clk      ),
	.dsa_1_clk      (pe_0_0_dsa_1_clk      ),
	.dsa_2_clk      (pe_0_0_dsa_2_clk      ),
	.nou_clk        (pe_0_0_nou_clk        ),
	.mem_sub_sys_clk(pe_0_0_mem_sub_sys_clk),
	.sys_clk        (pe_0_0_sys_clk        ),
	.sys_rstn       (pe_0_0_sys_rstn       )
);
// @34 &ConnRule(r'^', r'pe_0_0_');

// &Instance("pe_rstgen", "x_pe_0_0_rstgen"); @36
pe_rstgen x_pe_0_0_rstgen (
	.sys_rstn            (pe_0_0_sys_rstn            ),
	.sys_clk             (pe_0_0_sys_clk             ),
	.sram_soft_rstn      (pe_0_0_sram_soft_rstn      ),
	.mem_sub_sys_rstn    (pe_0_0_mem_sub_sys_rstn    ),
	.dispatcher_soft_rstn(pe_0_0_dispatcher_soft_rstn),
	.dispatcher_clk      (pe_0_0_dispatcher_clk      ),
	.dispatcher_rstn     (pe_0_0_dispatcher_rstn     ),
	.regular_0_soft_rstn (pe_0_0_regular_0_soft_rstn ),
	.regular_0_clk       (pe_0_0_regular_0_clk       ),
	.regular_0_rstn      (pe_0_0_regular_0_rstn      ),
	.regular_1_soft_rstn (pe_0_0_regular_1_soft_rstn ),
	.regular_1_clk       (pe_0_0_regular_1_clk       ),
	.regular_1_rstn      (pe_0_0_regular_1_rstn      ),
	.dsa_0_soft_rstn     (pe_0_0_dsa_0_soft_rstn     ),
	.dsa_0_clk           (pe_0_0_dsa_0_clk           ),
	.dsa_0_rstn          (pe_0_0_dsa_0_rstn          ),
	.dsa_1_soft_rstn     (pe_0_0_dsa_1_soft_rstn     ),
	.dsa_1_clk           (pe_0_0_dsa_1_clk           ),
	.dsa_1_rstn          (pe_0_0_dsa_1_rstn          ),
	.dsa_2_soft_rstn     (pe_0_0_dsa_2_soft_rstn     ),
	.dsa_2_clk           (pe_0_0_dsa_2_clk           ),
	.dsa_2_rstn          (pe_0_0_dsa_2_rstn          ),
	.nou_soft_rstn       (pe_0_0_nou_soft_rstn       ),
	.nou_clk             (pe_0_0_nou_clk             ),
	.nou_rstn            (pe_0_0_nou_rstn            )
);
// @37 &ConnRule(r'^', r'pe_0_0_');

// &Instance("pe_clkgen", "x_pe_1_0_clkgen"); @39
pe_clkgen x_pe_1_0_clkgen (
	.dispatcher_clk (pe_1_0_dispatcher_clk ),
	.regular_0_clk  (pe_1_0_regular_0_clk  ),
	.regular_1_clk  (pe_1_0_regular_1_clk  ),
	.dsa_0_clk      (pe_1_0_dsa_0_clk      ),
	.dsa_1_clk      (pe_1_0_dsa_1_clk      ),
	.dsa_2_clk      (pe_1_0_dsa_2_clk      ),
	.nou_clk        (pe_1_0_nou_clk        ),
	.mem_sub_sys_clk(pe_1_0_mem_sub_sys_clk),
	.sys_clk        (pe_1_0_sys_clk        ),
	.sys_rstn       (pe_1_0_sys_rstn       )
);
// @40 &ConnRule(r'^', r'pe_1_0_');

// &Instance("pe_rstgen", "x_pe_1_0_rstgen"); @42
pe_rstgen x_pe_1_0_rstgen (
	.sys_rstn            (pe_1_0_sys_rstn            ),
	.sys_clk             (pe_1_0_sys_clk             ),
	.sram_soft_rstn      (pe_1_0_sram_soft_rstn      ),
	.mem_sub_sys_rstn    (pe_1_0_mem_sub_sys_rstn    ),
	.dispatcher_soft_rstn(pe_1_0_dispatcher_soft_rstn),
	.dispatcher_clk      (pe_1_0_dispatcher_clk      ),
	.dispatcher_rstn     (pe_1_0_dispatcher_rstn     ),
	.regular_0_soft_rstn (pe_1_0_regular_0_soft_rstn ),
	.regular_0_clk       (pe_1_0_regular_0_clk       ),
	.regular_0_rstn      (pe_1_0_regular_0_rstn      ),
	.regular_1_soft_rstn (pe_1_0_regular_1_soft_rstn ),
	.regular_1_clk       (pe_1_0_regular_1_clk       ),
	.regular_1_rstn      (pe_1_0_regular_1_rstn      ),
	.dsa_0_soft_rstn     (pe_1_0_dsa_0_soft_rstn     ),
	.dsa_0_clk           (pe_1_0_dsa_0_clk           ),
	.dsa_0_rstn          (pe_1_0_dsa_0_rstn          ),
	.dsa_1_soft_rstn     (pe_1_0_dsa_1_soft_rstn     ),
	.dsa_1_clk           (pe_1_0_dsa_1_clk           ),
	.dsa_1_rstn          (pe_1_0_dsa_1_rstn          ),
	.dsa_2_soft_rstn     (pe_1_0_dsa_2_soft_rstn     ),
	.dsa_2_clk           (pe_1_0_dsa_2_clk           ),
	.dsa_2_rstn          (pe_1_0_dsa_2_rstn          ),
	.nou_soft_rstn       (pe_1_0_nou_soft_rstn       ),
	.nou_clk             (pe_1_0_nou_clk             ),
	.nou_rstn            (pe_1_0_nou_rstn            )
);
// @43 &ConnRule(r'^', r'pe_1_0_');

// &Instance("pe_clkgen", "x_pe_0_1_clkgen"); @45
pe_clkgen x_pe_0_1_clkgen (
	.dispatcher_clk (pe_0_1_dispatcher_clk ),
	.regular_0_clk  (pe_0_1_regular_0_clk  ),
	.regular_1_clk  (pe_0_1_regular_1_clk  ),
	.dsa_0_clk      (pe_0_1_dsa_0_clk      ),
	.dsa_1_clk      (pe_0_1_dsa_1_clk      ),
	.dsa_2_clk      (pe_0_1_dsa_2_clk      ),
	.nou_clk        (pe_0_1_nou_clk        ),
	.mem_sub_sys_clk(pe_0_1_mem_sub_sys_clk),
	.sys_clk        (pe_0_1_sys_clk        ),
	.sys_rstn       (pe_0_1_sys_rstn       )
);
// @46 &ConnRule(r'^', r'pe_0_1_');

// &Instance("pe_rstgen", "x_pe_0_1_rstgen"); @48
pe_rstgen x_pe_0_1_rstgen (
	.sys_rstn            (pe_0_1_sys_rstn            ),
	.sys_clk             (pe_0_1_sys_clk             ),
	.sram_soft_rstn      (pe_0_1_sram_soft_rstn      ),
	.mem_sub_sys_rstn    (pe_0_1_mem_sub_sys_rstn    ),
	.dispatcher_soft_rstn(pe_0_1_dispatcher_soft_rstn),
	.dispatcher_clk      (pe_0_1_dispatcher_clk      ),
	.dispatcher_rstn     (pe_0_1_dispatcher_rstn     ),
	.regular_0_soft_rstn (pe_0_1_regular_0_soft_rstn ),
	.regular_0_clk       (pe_0_1_regular_0_clk       ),
	.regular_0_rstn      (pe_0_1_regular_0_rstn      ),
	.regular_1_soft_rstn (pe_0_1_regular_1_soft_rstn ),
	.regular_1_clk       (pe_0_1_regular_1_clk       ),
	.regular_1_rstn      (pe_0_1_regular_1_rstn      ),
	.dsa_0_soft_rstn     (pe_0_1_dsa_0_soft_rstn     ),
	.dsa_0_clk           (pe_0_1_dsa_0_clk           ),
	.dsa_0_rstn          (pe_0_1_dsa_0_rstn          ),
	.dsa_1_soft_rstn     (pe_0_1_dsa_1_soft_rstn     ),
	.dsa_1_clk           (pe_0_1_dsa_1_clk           ),
	.dsa_1_rstn          (pe_0_1_dsa_1_rstn          ),
	.dsa_2_soft_rstn     (pe_0_1_dsa_2_soft_rstn     ),
	.dsa_2_clk           (pe_0_1_dsa_2_clk           ),
	.dsa_2_rstn          (pe_0_1_dsa_2_rstn          ),
	.nou_soft_rstn       (pe_0_1_nou_soft_rstn       ),
	.nou_clk             (pe_0_1_nou_clk             ),
	.nou_rstn            (pe_0_1_nou_rstn            )
);
// @49 &ConnRule(r'^', r'pe_0_1_');

// &Instance("pe_clkgen", "x_pe_1_1_clkgen"); @51
pe_clkgen x_pe_1_1_clkgen (
	.dispatcher_clk (pe_1_1_dispatcher_clk ),
	.regular_0_clk  (pe_1_1_regular_0_clk  ),
	.regular_1_clk  (pe_1_1_regular_1_clk  ),
	.dsa_0_clk      (pe_1_1_dsa_0_clk      ),
	.dsa_1_clk      (pe_1_1_dsa_1_clk      ),
	.dsa_2_clk      (pe_1_1_dsa_2_clk      ),
	.nou_clk        (pe_1_1_nou_clk        ),
	.mem_sub_sys_clk(pe_1_1_mem_sub_sys_clk),
	.sys_clk        (pe_1_1_sys_clk        ),
	.sys_rstn       (pe_1_1_sys_rstn       )
);
// @52 &ConnRule(r'^', r'pe_1_1_');

// &Instance("pe_rstgen", "x_pe_1_1_rstgen"); @54
pe_rstgen x_pe_1_1_rstgen (
	.sys_rstn            (pe_1_1_sys_rstn            ),
	.sys_clk             (pe_1_1_sys_clk             ),
	.sram_soft_rstn      (pe_1_1_sram_soft_rstn      ),
	.mem_sub_sys_rstn    (pe_1_1_mem_sub_sys_rstn    ),
	.dispatcher_soft_rstn(pe_1_1_dispatcher_soft_rstn),
	.dispatcher_clk      (pe_1_1_dispatcher_clk      ),
	.dispatcher_rstn     (pe_1_1_dispatcher_rstn     ),
	.regular_0_soft_rstn (pe_1_1_regular_0_soft_rstn ),
	.regular_0_clk       (pe_1_1_regular_0_clk       ),
	.regular_0_rstn      (pe_1_1_regular_0_rstn      ),
	.regular_1_soft_rstn (pe_1_1_regular_1_soft_rstn ),
	.regular_1_clk       (pe_1_1_regular_1_clk       ),
	.regular_1_rstn      (pe_1_1_regular_1_rstn      ),
	.dsa_0_soft_rstn     (pe_1_1_dsa_0_soft_rstn     ),
	.dsa_0_clk           (pe_1_1_dsa_0_clk           ),
	.dsa_0_rstn          (pe_1_1_dsa_0_rstn          ),
	.dsa_1_soft_rstn     (pe_1_1_dsa_1_soft_rstn     ),
	.dsa_1_clk           (pe_1_1_dsa_1_clk           ),
	.dsa_1_rstn          (pe_1_1_dsa_1_rstn          ),
	.dsa_2_soft_rstn     (pe_1_1_dsa_2_soft_rstn     ),
	.dsa_2_clk           (pe_1_1_dsa_2_clk           ),
	.dsa_2_rstn          (pe_1_1_dsa_2_rstn          ),
	.nou_soft_rstn       (pe_1_1_nou_soft_rstn       ),
	.nou_clk             (pe_1_1_nou_clk             ),
	.nou_rstn            (pe_1_1_nou_rstn            )
);
// @55 &ConnRule(r'^', r'pe_1_1_');


// &Instance("sys_reg", "x_sys_reg"); @58
sys_reg x_sys_reg (
	.sys_clk                    (sys_clk                    ),
	.sys_rstn                   (sys_rstn                   ),
	.pe_0_0_dispatcher_soft_rstn(pe_0_0_dispatcher_soft_rstn),
	.pe_0_0_regular_0_soft_rstn (pe_0_0_regular_0_soft_rstn ),
	.pe_0_0_regular_1_soft_rstn (pe_0_0_regular_1_soft_rstn ),
	.pe_0_0_dsa_0_soft_rstn     (pe_0_0_dsa_0_soft_rstn     ),
	.pe_0_0_dsa_1_soft_rstn     (pe_0_0_dsa_1_soft_rstn     ),
	.pe_0_0_dsa_2_soft_rstn     (pe_0_0_dsa_2_soft_rstn     ),
	.pe_0_0_nou_soft_rstn       (pe_0_0_nou_soft_rstn       ),
	.pe_0_0_sram_soft_rstn      (pe_0_0_sram_soft_rstn      ),
	.pe_1_0_dispatcher_soft_rstn(pe_1_0_dispatcher_soft_rstn),
	.pe_1_0_regular_0_soft_rstn (pe_1_0_regular_0_soft_rstn ),
	.pe_1_0_regular_1_soft_rstn (pe_1_0_regular_1_soft_rstn ),
	.pe_1_0_dsa_0_soft_rstn     (pe_1_0_dsa_0_soft_rstn     ),
	.pe_1_0_dsa_1_soft_rstn     (pe_1_0_dsa_1_soft_rstn     ),
	.pe_1_0_dsa_2_soft_rstn     (pe_1_0_dsa_2_soft_rstn     ),
	.pe_1_0_nou_soft_rstn       (pe_1_0_nou_soft_rstn       ),
	.pe_1_0_sram_soft_rstn      (pe_1_0_sram_soft_rstn      ),
	.pe_0_1_dispatcher_soft_rstn(pe_0_1_dispatcher_soft_rstn),
	.pe_0_1_regular_0_soft_rstn (pe_0_1_regular_0_soft_rstn ),
	.pe_0_1_regular_1_soft_rstn (pe_0_1_regular_1_soft_rstn ),
	.pe_0_1_dsa_0_soft_rstn     (pe_0_1_dsa_0_soft_rstn     ),
	.pe_0_1_dsa_1_soft_rstn     (pe_0_1_dsa_1_soft_rstn     ),
	.pe_0_1_dsa_2_soft_rstn     (pe_0_1_dsa_2_soft_rstn     ),
	.pe_0_1_nou_soft_rstn       (pe_0_1_nou_soft_rstn       ),
	.pe_0_1_sram_soft_rstn      (pe_0_1_sram_soft_rstn      ),
	.pe_1_1_dispatcher_soft_rstn(pe_1_1_dispatcher_soft_rstn),
	.pe_1_1_regular_0_soft_rstn (pe_1_1_regular_0_soft_rstn ),
	.pe_1_1_regular_1_soft_rstn (pe_1_1_regular_1_soft_rstn ),
	.pe_1_1_dsa_0_soft_rstn     (pe_1_1_dsa_0_soft_rstn     ),
	.pe_1_1_dsa_1_soft_rstn     (pe_1_1_dsa_1_soft_rstn     ),
	.pe_1_1_dsa_2_soft_rstn     (pe_1_1_dsa_2_soft_rstn     ),
	.pe_1_1_nou_soft_rstn       (pe_1_1_nou_soft_rstn       ),
	.pe_1_1_sram_soft_rstn      (pe_1_1_sram_soft_rstn      ),
	.axi_araddr                 (sys_reg_AXI_araddr         ),
	.axi_arburst                (sys_reg_AXI_arburst        ),
	.axi_arcache                (sys_reg_AXI_arcache        ),
	.axi_arid                   (sys_reg_AXI_arid           ),
	.axi_arlen                  (sys_reg_AXI_arlen          ),
	.axi_arlock                 (sys_reg_AXI_arlock         ),
	.axi_arprot                 (sys_reg_AXI_arprot         ),
	.axi_arqos                  (sys_reg_AXI_arqos          ),
	.axi_arsize                 (sys_reg_AXI_arsize         ),
	.axi_arvalid                (sys_reg_AXI_arvalid        ),
	.axi_awaddr                 (sys_reg_AXI_awaddr         ),
	.axi_awburst                (sys_reg_AXI_awburst        ),
	.axi_awcache                (sys_reg_AXI_awcache        ),
	.axi_awid                   (sys_reg_AXI_awid           ),
	.axi_awlen                  (sys_reg_AXI_awlen          ),
	.axi_awlock                 (sys_reg_AXI_awlock         ),
	.axi_awprot                 (sys_reg_AXI_awprot         ),
	.axi_awqos                  (sys_reg_AXI_awqos          ),
	.axi_awsize                 (sys_reg_AXI_awsize         ),
	.axi_awvalid                (sys_reg_AXI_awvalid        ),
	.axi_bready                 (sys_reg_AXI_bready         ),
	.axi_rready                 (sys_reg_AXI_rready         ),
	.axi_wdata                  (sys_reg_AXI_wdata          ),
	.axi_wlast                  (sys_reg_AXI_wlast          ),
	.axi_wstrb                  (sys_reg_AXI_wstrb          ),
	.axi_wvalid                 (sys_reg_AXI_wvalid         ),
	.axi_arready                (sys_reg_AXI_arready        ),
	.axi_awready                (sys_reg_AXI_awready        ),
	.axi_bid                    (sys_reg_AXI_bid            ),
	.axi_bresp                  (sys_reg_AXI_bresp          ),
	.axi_bvalid                 (sys_reg_AXI_bvalid         ),
	.axi_rdata                  (sys_reg_AXI_rdata          ),
	.axi_rid                    (sys_reg_AXI_rid            ),
	.axi_rlast                  (sys_reg_AXI_rlast          ),
	.axi_rresp                  (sys_reg_AXI_rresp          ),
	.axi_rvalid                 (sys_reg_AXI_rvalid         ),
	.axi_wready                 (sys_reg_AXI_wready         )
);
// @59 &ConnRule(r'axi_', r'sys_reg_AXI_');

//&Instance("spi2axi_wrapper", "x_spi2axi_wrapper");
//&ConnRule(r'axi_', r'HOST_S_AXI_');

// &Instance("shell_xbar_top"); @64
shell_xbar_top x_shell_xbar_top (
	.HOST_S_AXI_aclk     (sys_clk             ),
	.HOST_S_AXI_araddr   (HOST_S_AXI_araddr   ),
	.HOST_S_AXI_arburst  (HOST_S_AXI_arburst  ),
	.HOST_S_AXI_arcache  (HOST_S_AXI_arcache  ),
	.HOST_S_AXI_aresetn  (sys_rstn            ),
	.HOST_S_AXI_arid     (HOST_S_AXI_arid     ),
	.HOST_S_AXI_arlen    (HOST_S_AXI_arlen    ),
	.HOST_S_AXI_arlock   (HOST_S_AXI_arlock   ),
	.HOST_S_AXI_arprot   (HOST_S_AXI_arprot   ),
	.HOST_S_AXI_arqos    (HOST_S_AXI_arqos    ),
	.HOST_S_AXI_arsize   (HOST_S_AXI_arsize   ),
	.HOST_S_AXI_arvalid  (HOST_S_AXI_arvalid  ),
	.HOST_S_AXI_awaddr   (HOST_S_AXI_awaddr   ),
	.HOST_S_AXI_awburst  (HOST_S_AXI_awburst  ),
	.HOST_S_AXI_awcache  (HOST_S_AXI_awcache  ),
	.HOST_S_AXI_awid     (HOST_S_AXI_awid     ),
	.HOST_S_AXI_awlen    (HOST_S_AXI_awlen    ),
	.HOST_S_AXI_awlock   (HOST_S_AXI_awlock   ),
	.HOST_S_AXI_awprot   (HOST_S_AXI_awprot   ),
	.HOST_S_AXI_awqos    (HOST_S_AXI_awqos    ),
	.HOST_S_AXI_awsize   (HOST_S_AXI_awsize   ),
	.HOST_S_AXI_awvalid  (HOST_S_AXI_awvalid  ),
	.HOST_S_AXI_bready   (HOST_S_AXI_bready   ),
	.HOST_S_AXI_rready   (HOST_S_AXI_rready   ),
	.HOST_S_AXI_wdata    (HOST_S_AXI_wdata    ),
	.HOST_S_AXI_wlast    (HOST_S_AXI_wlast    ),
	.HOST_S_AXI_wstrb    (HOST_S_AXI_wstrb    ),
	.HOST_S_AXI_wvalid   (HOST_S_AXI_wvalid   ),
	.HOST_S_AXI_arready  (HOST_S_AXI_arready  ),
	.HOST_S_AXI_awready  (HOST_S_AXI_awready  ),
	.HOST_S_AXI_bid      (HOST_S_AXI_bid      ),
	.HOST_S_AXI_bresp    (HOST_S_AXI_bresp    ),
	.HOST_S_AXI_bvalid   (HOST_S_AXI_bvalid   ),
	.HOST_S_AXI_rdata    (HOST_S_AXI_rdata    ),
	.HOST_S_AXI_rid      (HOST_S_AXI_rid      ),
	.HOST_S_AXI_rlast    (HOST_S_AXI_rlast    ),
	.HOST_S_AXI_rresp    (HOST_S_AXI_rresp    ),
	.HOST_S_AXI_rvalid   (HOST_S_AXI_rvalid   ),
	.HOST_S_AXI_wready   (HOST_S_AXI_wready   ),
	.pe_0_0_M_AXI_aclk   (sys_clk             ),
	.pe_0_0_M_AXI_aresetn(sys_rstn            ),
	.pe_0_0_M_AXI_arready(pe_0_0_M_AXI_arready),
	.pe_0_0_M_AXI_awready(pe_0_0_M_AXI_awready),
	.pe_0_0_M_AXI_bid    (pe_0_0_M_AXI_bid    ),
	.pe_0_0_M_AXI_bresp  (pe_0_0_M_AXI_bresp  ),
	.pe_0_0_M_AXI_bvalid (pe_0_0_M_AXI_bvalid ),
	.pe_0_0_M_AXI_rdata  (pe_0_0_M_AXI_rdata  ),
	.pe_0_0_M_AXI_rid    (pe_0_0_M_AXI_rid    ),
	.pe_0_0_M_AXI_rlast  (pe_0_0_M_AXI_rlast  ),
	.pe_0_0_M_AXI_rresp  (pe_0_0_M_AXI_rresp  ),
	.pe_0_0_M_AXI_rvalid (pe_0_0_M_AXI_rvalid ),
	.pe_0_0_M_AXI_wready (pe_0_0_M_AXI_wready ),
	.pe_0_0_M_AXI_araddr (pe_0_0_M_AXI_araddr ),
	.pe_0_0_M_AXI_arburst(pe_0_0_M_AXI_arburst),
	.pe_0_0_M_AXI_arcache(pe_0_0_M_AXI_arcache),
	.pe_0_0_M_AXI_arid   (pe_0_0_M_AXI_arid   ),
	.pe_0_0_M_AXI_arlen  (pe_0_0_M_AXI_arlen  ),
	.pe_0_0_M_AXI_arlock (pe_0_0_M_AXI_arlock ),
	.pe_0_0_M_AXI_arprot (pe_0_0_M_AXI_arprot ),
	.pe_0_0_M_AXI_arqos  (pe_0_0_M_AXI_arqos  ),
	.pe_0_0_M_AXI_arsize (pe_0_0_M_AXI_arsize ),
	.pe_0_0_M_AXI_arvalid(pe_0_0_M_AXI_arvalid),
	.pe_0_0_M_AXI_awaddr (pe_0_0_M_AXI_awaddr ),
	.pe_0_0_M_AXI_awburst(pe_0_0_M_AXI_awburst),
	.pe_0_0_M_AXI_awcache(pe_0_0_M_AXI_awcache),
	.pe_0_0_M_AXI_awid   (pe_0_0_M_AXI_awid   ),
	.pe_0_0_M_AXI_awlen  (pe_0_0_M_AXI_awlen  ),
	.pe_0_0_M_AXI_awlock (pe_0_0_M_AXI_awlock ),
	.pe_0_0_M_AXI_awprot (pe_0_0_M_AXI_awprot ),
	.pe_0_0_M_AXI_awqos  (pe_0_0_M_AXI_awqos  ),
	.pe_0_0_M_AXI_awsize (pe_0_0_M_AXI_awsize ),
	.pe_0_0_M_AXI_awvalid(pe_0_0_M_AXI_awvalid),
	.pe_0_0_M_AXI_bready (pe_0_0_M_AXI_bready ),
	.pe_0_0_M_AXI_rready (pe_0_0_M_AXI_rready ),
	.pe_0_0_M_AXI_wdata  (pe_0_0_M_AXI_wdata  ),
	.pe_0_0_M_AXI_wlast  (pe_0_0_M_AXI_wlast  ),
	.pe_0_0_M_AXI_wstrb  (pe_0_0_M_AXI_wstrb  ),
	.pe_0_0_M_AXI_wvalid (pe_0_0_M_AXI_wvalid ),
	.pe_1_0_M_AXI_aclk   (sys_clk             ),
	.pe_1_0_M_AXI_aresetn(sys_rstn            ),
	.pe_1_0_M_AXI_arready(pe_1_0_M_AXI_arready),
	.pe_1_0_M_AXI_awready(pe_1_0_M_AXI_awready),
	.pe_1_0_M_AXI_bid    (pe_1_0_M_AXI_bid    ),
	.pe_1_0_M_AXI_bresp  (pe_1_0_M_AXI_bresp  ),
	.pe_1_0_M_AXI_bvalid (pe_1_0_M_AXI_bvalid ),
	.pe_1_0_M_AXI_rdata  (pe_1_0_M_AXI_rdata  ),
	.pe_1_0_M_AXI_rid    (pe_1_0_M_AXI_rid    ),
	.pe_1_0_M_AXI_rlast  (pe_1_0_M_AXI_rlast  ),
	.pe_1_0_M_AXI_rresp  (pe_1_0_M_AXI_rresp  ),
	.pe_1_0_M_AXI_rvalid (pe_1_0_M_AXI_rvalid ),
	.pe_1_0_M_AXI_wready (pe_1_0_M_AXI_wready ),
	.pe_1_0_M_AXI_araddr (pe_1_0_M_AXI_araddr ),
	.pe_1_0_M_AXI_arburst(pe_1_0_M_AXI_arburst),
	.pe_1_0_M_AXI_arcache(pe_1_0_M_AXI_arcache),
	.pe_1_0_M_AXI_arid   (pe_1_0_M_AXI_arid   ),
	.pe_1_0_M_AXI_arlen  (pe_1_0_M_AXI_arlen  ),
	.pe_1_0_M_AXI_arlock (pe_1_0_M_AXI_arlock ),
	.pe_1_0_M_AXI_arprot (pe_1_0_M_AXI_arprot ),
	.pe_1_0_M_AXI_arqos  (pe_1_0_M_AXI_arqos  ),
	.pe_1_0_M_AXI_arsize (pe_1_0_M_AXI_arsize ),
	.pe_1_0_M_AXI_arvalid(pe_1_0_M_AXI_arvalid),
	.pe_1_0_M_AXI_awaddr (pe_1_0_M_AXI_awaddr ),
	.pe_1_0_M_AXI_awburst(pe_1_0_M_AXI_awburst),
	.pe_1_0_M_AXI_awcache(pe_1_0_M_AXI_awcache),
	.pe_1_0_M_AXI_awid   (pe_1_0_M_AXI_awid   ),
	.pe_1_0_M_AXI_awlen  (pe_1_0_M_AXI_awlen  ),
	.pe_1_0_M_AXI_awlock (pe_1_0_M_AXI_awlock ),
	.pe_1_0_M_AXI_awprot (pe_1_0_M_AXI_awprot ),
	.pe_1_0_M_AXI_awqos  (pe_1_0_M_AXI_awqos  ),
	.pe_1_0_M_AXI_awsize (pe_1_0_M_AXI_awsize ),
	.pe_1_0_M_AXI_awvalid(pe_1_0_M_AXI_awvalid),
	.pe_1_0_M_AXI_bready (pe_1_0_M_AXI_bready ),
	.pe_1_0_M_AXI_rready (pe_1_0_M_AXI_rready ),
	.pe_1_0_M_AXI_wdata  (pe_1_0_M_AXI_wdata  ),
	.pe_1_0_M_AXI_wlast  (pe_1_0_M_AXI_wlast  ),
	.pe_1_0_M_AXI_wstrb  (pe_1_0_M_AXI_wstrb  ),
	.pe_1_0_M_AXI_wvalid (pe_1_0_M_AXI_wvalid ),
	.pe_0_1_M_AXI_aclk   (sys_clk             ),
	.pe_0_1_M_AXI_aresetn(sys_rstn            ),
	.pe_0_1_M_AXI_arready(pe_0_1_M_AXI_arready),
	.pe_0_1_M_AXI_awready(pe_0_1_M_AXI_awready),
	.pe_0_1_M_AXI_bid    (pe_0_1_M_AXI_bid    ),
	.pe_0_1_M_AXI_bresp  (pe_0_1_M_AXI_bresp  ),
	.pe_0_1_M_AXI_bvalid (pe_0_1_M_AXI_bvalid ),
	.pe_0_1_M_AXI_rdata  (pe_0_1_M_AXI_rdata  ),
	.pe_0_1_M_AXI_rid    (pe_0_1_M_AXI_rid    ),
	.pe_0_1_M_AXI_rlast  (pe_0_1_M_AXI_rlast  ),
	.pe_0_1_M_AXI_rresp  (pe_0_1_M_AXI_rresp  ),
	.pe_0_1_M_AXI_rvalid (pe_0_1_M_AXI_rvalid ),
	.pe_0_1_M_AXI_wready (pe_0_1_M_AXI_wready ),
	.pe_0_1_M_AXI_araddr (pe_0_1_M_AXI_araddr ),
	.pe_0_1_M_AXI_arburst(pe_0_1_M_AXI_arburst),
	.pe_0_1_M_AXI_arcache(pe_0_1_M_AXI_arcache),
	.pe_0_1_M_AXI_arid   (pe_0_1_M_AXI_arid   ),
	.pe_0_1_M_AXI_arlen  (pe_0_1_M_AXI_arlen  ),
	.pe_0_1_M_AXI_arlock (pe_0_1_M_AXI_arlock ),
	.pe_0_1_M_AXI_arprot (pe_0_1_M_AXI_arprot ),
	.pe_0_1_M_AXI_arqos  (pe_0_1_M_AXI_arqos  ),
	.pe_0_1_M_AXI_arsize (pe_0_1_M_AXI_arsize ),
	.pe_0_1_M_AXI_arvalid(pe_0_1_M_AXI_arvalid),
	.pe_0_1_M_AXI_awaddr (pe_0_1_M_AXI_awaddr ),
	.pe_0_1_M_AXI_awburst(pe_0_1_M_AXI_awburst),
	.pe_0_1_M_AXI_awcache(pe_0_1_M_AXI_awcache),
	.pe_0_1_M_AXI_awid   (pe_0_1_M_AXI_awid   ),
	.pe_0_1_M_AXI_awlen  (pe_0_1_M_AXI_awlen  ),
	.pe_0_1_M_AXI_awlock (pe_0_1_M_AXI_awlock ),
	.pe_0_1_M_AXI_awprot (pe_0_1_M_AXI_awprot ),
	.pe_0_1_M_AXI_awqos  (pe_0_1_M_AXI_awqos  ),
	.pe_0_1_M_AXI_awsize (pe_0_1_M_AXI_awsize ),
	.pe_0_1_M_AXI_awvalid(pe_0_1_M_AXI_awvalid),
	.pe_0_1_M_AXI_bready (pe_0_1_M_AXI_bready ),
	.pe_0_1_M_AXI_rready (pe_0_1_M_AXI_rready ),
	.pe_0_1_M_AXI_wdata  (pe_0_1_M_AXI_wdata  ),
	.pe_0_1_M_AXI_wlast  (pe_0_1_M_AXI_wlast  ),
	.pe_0_1_M_AXI_wstrb  (pe_0_1_M_AXI_wstrb  ),
	.pe_0_1_M_AXI_wvalid (pe_0_1_M_AXI_wvalid ),
	.pe_1_1_M_AXI_aclk   (sys_clk             ),
	.pe_1_1_M_AXI_aresetn(sys_rstn            ),
	.pe_1_1_M_AXI_arready(pe_1_1_M_AXI_arready),
	.pe_1_1_M_AXI_awready(pe_1_1_M_AXI_awready),
	.pe_1_1_M_AXI_bid    (pe_1_1_M_AXI_bid    ),
	.pe_1_1_M_AXI_bresp  (pe_1_1_M_AXI_bresp  ),
	.pe_1_1_M_AXI_bvalid (pe_1_1_M_AXI_bvalid ),
	.pe_1_1_M_AXI_rdata  (pe_1_1_M_AXI_rdata  ),
	.pe_1_1_M_AXI_rid    (pe_1_1_M_AXI_rid    ),
	.pe_1_1_M_AXI_rlast  (pe_1_1_M_AXI_rlast  ),
	.pe_1_1_M_AXI_rresp  (pe_1_1_M_AXI_rresp  ),
	.pe_1_1_M_AXI_rvalid (pe_1_1_M_AXI_rvalid ),
	.pe_1_1_M_AXI_wready (pe_1_1_M_AXI_wready ),
	.pe_1_1_M_AXI_araddr (pe_1_1_M_AXI_araddr ),
	.pe_1_1_M_AXI_arburst(pe_1_1_M_AXI_arburst),
	.pe_1_1_M_AXI_arcache(pe_1_1_M_AXI_arcache),
	.pe_1_1_M_AXI_arid   (pe_1_1_M_AXI_arid   ),
	.pe_1_1_M_AXI_arlen  (pe_1_1_M_AXI_arlen  ),
	.pe_1_1_M_AXI_arlock (pe_1_1_M_AXI_arlock ),
	.pe_1_1_M_AXI_arprot (pe_1_1_M_AXI_arprot ),
	.pe_1_1_M_AXI_arqos  (pe_1_1_M_AXI_arqos  ),
	.pe_1_1_M_AXI_arsize (pe_1_1_M_AXI_arsize ),
	.pe_1_1_M_AXI_arvalid(pe_1_1_M_AXI_arvalid),
	.pe_1_1_M_AXI_awaddr (pe_1_1_M_AXI_awaddr ),
	.pe_1_1_M_AXI_awburst(pe_1_1_M_AXI_awburst),
	.pe_1_1_M_AXI_awcache(pe_1_1_M_AXI_awcache),
	.pe_1_1_M_AXI_awid   (pe_1_1_M_AXI_awid   ),
	.pe_1_1_M_AXI_awlen  (pe_1_1_M_AXI_awlen  ),
	.pe_1_1_M_AXI_awlock (pe_1_1_M_AXI_awlock ),
	.pe_1_1_M_AXI_awprot (pe_1_1_M_AXI_awprot ),
	.pe_1_1_M_AXI_awqos  (pe_1_1_M_AXI_awqos  ),
	.pe_1_1_M_AXI_awsize (pe_1_1_M_AXI_awsize ),
	.pe_1_1_M_AXI_awvalid(pe_1_1_M_AXI_awvalid),
	.pe_1_1_M_AXI_bready (pe_1_1_M_AXI_bready ),
	.pe_1_1_M_AXI_rready (pe_1_1_M_AXI_rready ),
	.pe_1_1_M_AXI_wdata  (pe_1_1_M_AXI_wdata  ),
	.pe_1_1_M_AXI_wlast  (pe_1_1_M_AXI_wlast  ),
	.pe_1_1_M_AXI_wstrb  (pe_1_1_M_AXI_wstrb  ),
	.pe_1_1_M_AXI_wvalid (pe_1_1_M_AXI_wvalid ),
	.sys_reg_AXI_aclk    (sys_clk             ),
	.sys_reg_AXI_aresetn (sys_rstn            ),
	.sys_reg_AXI_arready (sys_reg_AXI_arready ),
	.sys_reg_AXI_awready (sys_reg_AXI_awready ),
	.sys_reg_AXI_bid     (sys_reg_AXI_bid     ),
	.sys_reg_AXI_bresp   (sys_reg_AXI_bresp   ),
	.sys_reg_AXI_bvalid  (sys_reg_AXI_bvalid  ),
	.sys_reg_AXI_rdata   (sys_reg_AXI_rdata   ),
	.sys_reg_AXI_rid     (sys_reg_AXI_rid     ),
	.sys_reg_AXI_rlast   (sys_reg_AXI_rlast   ),
	.sys_reg_AXI_rresp   (sys_reg_AXI_rresp   ),
	.sys_reg_AXI_rvalid  (sys_reg_AXI_rvalid  ),
	.sys_reg_AXI_wready  (sys_reg_AXI_wready  ),
	.sys_reg_AXI_araddr  (sys_reg_AXI_araddr  ),
	.sys_reg_AXI_arburst (sys_reg_AXI_arburst ),
	.sys_reg_AXI_arcache (sys_reg_AXI_arcache ),
	.sys_reg_AXI_arid    (sys_reg_AXI_arid    ),
	.sys_reg_AXI_arlen   (sys_reg_AXI_arlen   ),
	.sys_reg_AXI_arlock  (sys_reg_AXI_arlock  ),
	.sys_reg_AXI_arprot  (sys_reg_AXI_arprot  ),
	.sys_reg_AXI_arqos   (sys_reg_AXI_arqos   ),
	.sys_reg_AXI_arsize  (sys_reg_AXI_arsize  ),
	.sys_reg_AXI_arvalid (sys_reg_AXI_arvalid ),
	.sys_reg_AXI_awaddr  (sys_reg_AXI_awaddr  ),
	.sys_reg_AXI_awburst (sys_reg_AXI_awburst ),
	.sys_reg_AXI_awcache (sys_reg_AXI_awcache ),
	.sys_reg_AXI_awid    (sys_reg_AXI_awid    ),
	.sys_reg_AXI_awlen   (sys_reg_AXI_awlen   ),
	.sys_reg_AXI_awlock  (sys_reg_AXI_awlock  ),
	.sys_reg_AXI_awprot  (sys_reg_AXI_awprot  ),
	.sys_reg_AXI_awqos   (sys_reg_AXI_awqos   ),
	.sys_reg_AXI_awsize  (sys_reg_AXI_awsize  ),
	.sys_reg_AXI_awvalid (sys_reg_AXI_awvalid ),
	.sys_reg_AXI_bready  (sys_reg_AXI_bready  ),
	.sys_reg_AXI_rready  (sys_reg_AXI_rready  ),
	.sys_reg_AXI_wdata   (sys_reg_AXI_wdata   ),
	.sys_reg_AXI_wlast   (sys_reg_AXI_wlast   ),
	.sys_reg_AXI_wstrb   (sys_reg_AXI_wstrb   ),
	.sys_reg_AXI_wvalid  (sys_reg_AXI_wvalid  )
);
// @65 &Connect(
// @66     .HOST_S_AXI_aclk(sys_clk),
// @67     .HOST_S_AXI_aresetn(sys_rstn),
// @68     .pe_0_0_M_AXI_aclk(sys_clk),
// @69     .pe_0_0_M_AXI_aresetn(sys_rstn),
// @70     .pe_1_0_M_AXI_aclk(sys_clk),
// @71     .pe_1_0_M_AXI_aresetn(sys_rstn),
// @72     .pe_0_1_M_AXI_aclk(sys_clk),
// @73     .pe_0_1_M_AXI_aresetn(sys_rstn),
// @74     .pe_1_1_M_AXI_aclk(sys_clk),
// @75     .pe_1_1_M_AXI_aresetn(sys_rstn),
// @76 	.sys_reg_AXI_aclk    (sys_clk    ),
// @77 	.sys_reg_AXI_aresetn (sys_rstn ),
// @78 );


endmodule
