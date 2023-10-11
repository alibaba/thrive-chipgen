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

`include "cpu_cfig.h"

module cpu_sub_system_ahb(
  //XOCC signals start
  dsa_clk,
  dsa_cmd_buffer_0,
  dsa_cmd_buffer_1,
  dsa_cmd_buffer_2,
  dsa_cmd_buffer_3,
  dsa_cmd_buffer_4,
  dsa_rsp_buffer_0,
  dsa_rsp_buffer_1,
  dsa_rsp_buffer_2,
  dsa_rsp_buffer_3,
  dsa_rsp_buffer_4,
  dsa_rst,
  empty_cmd,
  full_rsp,
  rd_en_cmd,
  wr_en_rsp,

  //system bus
  biu_pad_haddr,
  biu_pad_hburst,
  biu_pad_hprot,
  biu_pad_hsize,
  biu_pad_htrans,
  biu_pad_hwdata,
  biu_pad_hwrite,
  biu_pad_lpmd_b,
  pad_biu_bigend_b,
  pad_biu_hrdata,
  pad_biu_hready,
  pad_biu_hresp,

  //csr
  pad_cpu_rst_addr,
  biu_pad_retire_pc,

  pad_vic_int_vld,
  pad_yy_gate_clk_en_b,
  pad_yy_scan_mode,
  pg_reset_b,
  corec_pmu_sleep_out,
  pmu_corec_isolation,
  pmu_corec_sleep_in,
  cpu_clk,
  pad_cpu_rst_b,
  i_pad_jtg_tms_o,
  i_pad_jtg_tms_oe,
  pad_had_jtg_tclk,
  pad_had_jtg_tms_i,
  pad_had_jtg_trst_b
);

parameter CLICNUM = `EXT_INT_NUM;

input           cpu_clk;             
input           pad_biu_bigend_b;    
input   [31:0]  pad_biu_hrdata;      
input           pad_biu_hready;      
input   [1 :0]  pad_biu_hresp;       
input           pad_cpu_rst_b;       
 
input   [31:0]  pad_vic_int_vld;     
input           pad_yy_gate_clk_en_b; 
input           pad_yy_scan_mode;    
input           pg_reset_b;          
input           pmu_corec_isolation; 
input           pmu_corec_sleep_in;  
output  [31:0]  biu_pad_haddr;       
output  [2 :0]  biu_pad_hburst;      
output  [3 :0]  biu_pad_hprot;       
output  [2 :0]  biu_pad_hsize;       
output  [1 :0]  biu_pad_htrans;      
output  [31:0]  biu_pad_hwdata;      
output          biu_pad_hwrite;      
output  [1 :0]  biu_pad_lpmd_b;      
output          corec_pmu_sleep_out; 
 
//XOCC signals
output   wire	[`CMD_BIT_WIDTH_M0-1:0]  dsa_cmd_buffer_0;                
output   wire	[`CMD_BIT_WIDTH_M1-1:0]  dsa_cmd_buffer_1;                
output   wire	[`CMD_BIT_WIDTH_M2-1:0]  dsa_cmd_buffer_2;
output   wire	[`CMD_BIT_WIDTH_M3-1:0]  dsa_cmd_buffer_3;                
output   wire	[`CMD_BIT_WIDTH_M4-1:0]  dsa_cmd_buffer_4;
input    wire	[`RSP_BIT_WIDTH_M0-1:0]  dsa_rsp_buffer_0;                
input    wire	[`RSP_BIT_WIDTH_M1-1:0]  dsa_rsp_buffer_1;                
input    wire	[`RSP_BIT_WIDTH_M2-1:0]  dsa_rsp_buffer_2;                
input    wire	[`RSP_BIT_WIDTH_M3-1:0]  dsa_rsp_buffer_3;                
input    wire	[`RSP_BIT_WIDTH_M4-1:0]  dsa_rsp_buffer_4;                
output   wire	[15 :0]  empty_cmd;                       
output   wire	[15 :0]  full_rsp; 
input    wire	[15 :0]  rd_en_cmd;                       
input    wire	[15 :0]  wr_en_rsp;
input    wire	[15 :0]  dsa_clk;                         
input    wire	[15 :0]  dsa_rst;

//csr register
input wire [31:0] pad_cpu_rst_addr;
output wire    [31:0]  biu_pad_retire_pc;   

//jtag signal
input           pad_had_jtg_tclk;    
input           pad_had_jtg_trst_b; 
input           pad_had_jtg_tms_i;  
output          i_pad_jtg_tms_o;
output          i_pad_jtg_tms_oe; 
// &Regs; @24
reg     [1 :0]  biu_addr;            
reg     [1 :0]  biu_size;            
reg     [1 :0]  dahbl_addr;          
reg     [1 :0]  dahbl_size;          
reg     [1 :0]  iahbl_addr;          
reg     [1 :0]  iahbl_size;          
reg     [31:0]  pad_biu_hrdata_mux;  
reg     [63:0]  pad_cpu_sys_cnt;     
reg     [31:0]  pad_dahbl_hrdata_mux; 
reg     [31:0]  pad_iahbl_hrdata_mux; 

// &Wires; @25
wire    [31:0]  biu_pad_haddr;       
wire    [2 :0]  biu_pad_hburst;      
wire            biu_pad_hlock;       
wire    [3 :0]  biu_pad_hprot;       
wire    [2 :0]  biu_pad_hsize;       
wire    [1 :0]  biu_pad_htrans;      
wire    [31:0]  biu_pad_hwdata;      
wire            biu_pad_hwrite;      
wire    [1 :0]  biu_pad_lpmd_b;      
wire            biu_pad_retire;      
//wire    [31:0]  biu_pad_retire_pc;   
wire    [31:0]  biu_pad_wb_gpr_data; 
wire            biu_pad_wb_gpr_en;   
wire    [5 :0]  biu_pad_wb_gpr_index; 
wire    [31:0]  biu_pad_wb1_gpr_data; 
wire            biu_pad_wb1_gpr_en;   
wire    [5 :0]  biu_pad_wb1_gpr_index; 
wire            clk_en;              
wire    [31:0]  cp0_pad_mcause;      
wire    [31:0]  cp0_pad_mintstatus;  
wire    [31:0]  cp0_pad_mstatus;     
wire            cpu_clk;             
wire            cpu_pad_dfs_ack;     
wire            cpu_pad_lockup;      
wire    [1 :0]  cpu_pad_soft_rst;    
wire            cpu_rst;             
wire    [31:0]  dahbl_pad_haddr;     
wire    [2 :0]  dahbl_pad_hburst;    
wire            dahbl_pad_hlock;     
wire    [3 :0]  dahbl_pad_hprot;     
wire    [2 :0]  dahbl_pad_hsize;     
wire    [1 :0]  dahbl_pad_htrans;    
wire    [31:0]  dahbl_pad_hwdata;    
wire            dahbl_pad_hwrite;    
wire            had_pad_jtg_tms_o;   
wire            had_pad_jtg_tms_oe;  
wire            had_rst;             
wire            i_pad_jtg_tms;       
wire    [31:0]  iahbl_pad_haddr;     
wire    [2 :0]  iahbl_pad_hburst;    
wire            iahbl_pad_hlock;     
wire    [3 :0]  iahbl_pad_hprot;     
wire    [2 :0]  iahbl_pad_hsize;     
wire    [1 :0]  iahbl_pad_htrans;    
wire    [31:0]  iahbl_pad_hwdata;    
wire            iahbl_pad_hwrite;    
wire            lsu_pad_sc_pass;     
wire            pad_biu_bigend_b;    
wire    [31:0]  pad_biu_hrdata;      
wire            pad_biu_hready;      
wire    [1 :0]  pad_biu_hresp;       
wire            pad_biu_hresp_0;     
wire    [CLICNUM-1:0]  pad_clic_int_vld;    
wire            pad_cpu_dfs_req;     
wire            pad_cpu_ext_int_b;   
wire            pad_cpu_rst_b;       
wire    [31:0]  pad_dahbl_hrdata;    
wire            pad_dahbl_hready;    
wire    [1 :0]  pad_dahbl_hresp;     
wire            pad_dahbl_hresp_0;   
wire            pad_had_jtg_tclk;    
wire            pad_had_jtg_tms_i;   
wire            pad_had_jtg_trst_b;  
wire    [31:0]  pad_iahbl_hrdata;    
wire            pad_iahbl_hready;    
wire    [1 :0]  pad_iahbl_hresp;     
wire            pad_iahbl_hresp_0;   
wire            pad_sysio_dbgrq_b;   
wire    [31:0]  pad_vic_int_vld;     
wire            pad_yy_gate_clk_en_b; 
wire            pad_yy_scan_mode;    
wire            pg_reset_b;          
wire            rtu_pad_inst_split;  
`ifdef FPU
wire    [4 :0]  rtu_pad_wb_freg;     
`ifdef FPU_DOUBLE
wire    [63:0]  rtu_pad_wb_freg_data; 
`else
wire    [31:0]  rtu_pad_wb_freg_data; 
`endif
wire            rtu_pad_wb_freg_vld; 
`endif

//*********************** E906 *************************
assign pad_clic_int_vld[CLICNUM-1:0] = {{(CLICNUM-32){1'b0}},pad_vic_int_vld[31:0]};
assign pad_cpu_ext_int_b  =1'b1;

pa_cpu_top x_pa_cpu_top (  
  .biu_pad_haddr        (biu_pad_haddr       ),
  .biu_pad_hburst       (biu_pad_hburst      ),
  .biu_pad_hlock        (biu_pad_hlock       ),
  .biu_pad_hprot        (biu_pad_hprot       ),
  .biu_pad_hsize        (biu_pad_hsize       ),
  .biu_pad_htrans       (biu_pad_htrans      ),
  .biu_pad_hwdata       (biu_pad_hwdata      ),
  .biu_pad_hwrite       (biu_pad_hwrite      ),
  .clk_en               (clk_en              ),
  .cp0_pad_mcause       (cp0_pad_mcause      ),
  .cp0_pad_mintstatus   (cp0_pad_mintstatus  ),
  .cp0_pad_mstatus      (cp0_pad_mstatus     ),
  .cpu_pad_dfs_ack      (cpu_pad_dfs_ack     ),
  .cpu_pad_lockup       (cpu_pad_lockup      ),
  .cpu_pad_soft_rst     (cpu_pad_soft_rst    ),
  .dahbl_pad_haddr      (dahbl_pad_haddr     ),
  .dahbl_pad_hburst     (dahbl_pad_hburst    ),
  .dahbl_pad_hlock      (dahbl_pad_hlock     ),
  .dahbl_pad_hprot      (dahbl_pad_hprot     ),
  .dahbl_pad_hsize      (dahbl_pad_hsize     ),
  .dahbl_pad_htrans     (dahbl_pad_htrans    ),
  .dahbl_pad_hwdata     (dahbl_pad_hwdata    ),
  .dahbl_pad_hwrite     (dahbl_pad_hwrite    ),
  .dsa_clk              (dsa_clk             ),
  .dsa_cmd_buffer_0     (dsa_cmd_buffer_0    ),
  .dsa_cmd_buffer_1     (dsa_cmd_buffer_1    ),
  .dsa_cmd_buffer_2     (dsa_cmd_buffer_2    ),
  .dsa_cmd_buffer_3     (dsa_cmd_buffer_3    ),
  .dsa_cmd_buffer_4     (dsa_cmd_buffer_4    ),
  .dsa_rsp_buffer_0     (dsa_rsp_buffer_0    ),
  .dsa_rsp_buffer_1     (dsa_rsp_buffer_1    ),
  .dsa_rsp_buffer_2     (dsa_rsp_buffer_2    ),
  .dsa_rsp_buffer_3     (dsa_rsp_buffer_3    ),
  .dsa_rsp_buffer_4     (dsa_rsp_buffer_4    ),
  .dsa_rst              (dsa_rst             ),
  .empty_cmd            (empty_cmd           ),
  .full_rsp             (full_rsp            ),
  .iahbl_pad_haddr      (iahbl_pad_haddr     ),
  .iahbl_pad_hburst     (iahbl_pad_hburst    ),
  .iahbl_pad_hlock      (iahbl_pad_hlock     ),
  .iahbl_pad_hprot      (iahbl_pad_hprot     ),
  .iahbl_pad_hsize      (iahbl_pad_hsize     ),
  .iahbl_pad_htrans     (iahbl_pad_htrans    ),
  .iahbl_pad_hwdata     (iahbl_pad_hwdata    ),
  .iahbl_pad_hwrite     (iahbl_pad_hwrite    ),
  .pad_biu_hrdata       (pad_biu_hrdata_mux  ),
  .pad_biu_hready       (pad_biu_hready      ),
  .pad_biu_hresp        (pad_biu_hresp_0     ),
  //.pad_bmu_dahbl_base   (12'h200             ),
  .pad_bmu_dahbl_base   (12'hfff             ),
  .pad_bmu_dahbl_mask   (12'hff8             ),
  .pad_bmu_iahbl_base   (12'hfff             ),
  .pad_bmu_iahbl_mask   (12'hff8             ),
  .pad_cpu_sysmap_addr0      (20'h20000                ),
  .pad_cpu_sysmap_addr0_attr (3'b011                   ),
  .pad_cpu_sysmap_addr1      (20'h30000                ),
  .pad_cpu_sysmap_addr1_attr (3'b011                   ),
  .pad_cpu_sysmap_addr2      (20'h40000                ),
  .pad_cpu_sysmap_addr2_attr (3'b000                   ),
  .pad_cpu_sysmap_addr3      (20'h50000                ),
  .pad_cpu_sysmap_addr3_attr (3'b100                   ),
  .pad_cpu_sysmap_addr4      (20'h60000                ),
  .pad_cpu_sysmap_addr4_attr (3'b000                   ),
  .pad_cpu_sysmap_addr5      (20'h70000                ),
  .pad_cpu_sysmap_addr5_attr (3'b100                   ),
  .pad_cpu_sysmap_addr6      (20'he0000                ),
  .pad_cpu_sysmap_addr6_attr (3'b000                   ),
  .pad_cpu_sysmap_addr7      (20'hfffff                ),
  .pad_cpu_sysmap_addr7_attr (3'b100                   ),
  .pad_cpu_tcip_base         (32'he000_0000            ),
  .pad_clic_int_vld     (pad_clic_int_vld    ),
  .pad_cpu_dfs_req      (pad_cpu_dfs_req     ),
  .pad_cpu_ext_int_b    (pad_cpu_ext_int_b   ),
  .pad_cpu_nmi          (1'b0                ),
  .pad_cpu_rst_addr     (pad_cpu_rst_addr    ),
  .pad_cpu_rst_b        (cpu_rst             ),
  .pad_cpu_sys_cnt      (pad_cpu_sys_cnt     ),
  .pad_cpu_wakeup_event (1'b0                ),
  .pad_dahbl_hrdata     (pad_dahbl_hrdata_mux),
  .pad_dahbl_hready     (pad_dahbl_hready    ),
  .pad_dahbl_hresp      (pad_dahbl_hresp_0   ),
//  .pad_had_rst_b        (had_rst             ),
  .pad_iahbl_hrdata     (pad_iahbl_hrdata_mux),
  .pad_iahbl_hready     (pad_iahbl_hready    ),
  .pad_iahbl_hresp      (pad_iahbl_hresp_0   ),
//  .pad_sysio_dbgrq_b    (pad_sysio_dbgrq_b   ),
//  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b),
  .pad_yy_scan_mode     (pad_yy_scan_mode    ),
  .pll_core_cpuclk      (cpu_clk             ),
  .sys_apb_clk          (cpu_clk        ),
  .sys_apb_rst_b        (cpu_rst        ),
  .rd_en_cmd             (rd_en_cmd            ),
  .rtu_pad_inst_retire  (biu_pad_retire      ),
  .rtu_pad_inst_split   (rtu_pad_inst_split  ),
  .rtu_pad_retire_pc    (biu_pad_retire_pc   ),
  `ifdef FPU
  .rtu_pad_wb_freg      (rtu_pad_wb_freg     ),
  .rtu_pad_wb_freg_data (rtu_pad_wb_freg_data),
  .rtu_pad_wb_freg_vld  (rtu_pad_wb_freg_vld ),
  `endif
  .rtu_pad_wb0_data     (biu_pad_wb_gpr_data ),
  .rtu_pad_wb0_preg     (biu_pad_wb_gpr_index),
  .rtu_pad_wb0_vld      (biu_pad_wb_gpr_en   ),
  .rtu_pad_wb1_data     (biu_pad_wb1_gpr_data ),
  .rtu_pad_wb1_preg     (biu_pad_wb1_gpr_index),
  .rtu_pad_wb1_vld      (biu_pad_wb1_gpr_en   ),
  .sysio_pad_lpmd_b     (biu_pad_lpmd_b      ),
  .wr_en_rsp             (wr_en_rsp            )
);

assign pad_cpu_dfs_req = 0;
assign pad_sysio_dbgrq_b = 1;
assign clk_en = 1;

// sys cnt
always@(posedge cpu_clk or negedge pad_cpu_rst_b)
begin
  if (!pad_cpu_rst_b)
    pad_cpu_sys_cnt[63:0] <= 64'b0;
  else
    pad_cpu_sys_cnt[63:0] <= pad_cpu_sys_cnt[63:0] + 1'b1;
end

assign cpu_rst = pg_reset_b & (~cpu_pad_lockup) &  (~|cpu_pad_soft_rst);
assign had_rst = pg_reset_b & (~cpu_pad_soft_rst[1]);

assign i_pad_jtg_tms_o  = had_pad_jtg_tms_o;
assign i_pad_jtg_tms_oe = had_pad_jtg_tms_oe;

assign pad_biu_hresp_0 = pad_biu_hresp[0];

always@(posedge cpu_clk or negedge pg_reset_b)
begin
    if(!pg_reset_b) begin
      biu_size[1:0] <= 2'h2;
      biu_addr[1:0] <= 2'b0;
    end
    else if((biu_pad_htrans == 2) && (!biu_pad_hwrite) && pad_biu_hready) begin
      biu_size[1:0] <= biu_pad_hsize[1:0];
      biu_addr[1:0] <= biu_pad_haddr[1:0];
    end
end

always@(*)
begin
    case({biu_size[1:0],biu_addr[1:0]})
        4'b0000:pad_biu_hrdata_mux[31:0] = {24'h0,pad_biu_hrdata[7:0]};
        4'b0001:pad_biu_hrdata_mux[31:0] = {16'h0,pad_biu_hrdata[15:8],8'h0};
        4'b0010:pad_biu_hrdata_mux[31:0] = {8'h0,pad_biu_hrdata[23:16],16'h0};
        4'b0011:pad_biu_hrdata_mux[31:0] = {pad_biu_hrdata[31:24],24'h0};
        4'b0100: pad_biu_hrdata_mux[31:0] = {16'h0,pad_biu_hrdata[15:0]};
        4'b0110: pad_biu_hrdata_mux[31:0] = {pad_biu_hrdata[31:16],16'h0};
        4'b1000: pad_biu_hrdata_mux[31:0] = pad_biu_hrdata[31:0];
        default: pad_biu_hrdata_mux[31:0] = 32'h0;
    endcase
end

endmodule


