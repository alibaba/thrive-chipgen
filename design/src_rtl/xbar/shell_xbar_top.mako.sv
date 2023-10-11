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

`include "axi/typedef.svh"
`include "axi/assign.svh"
`include "axi/xbar_define.h"
<%
import math
%>\
<%
sig_m_list = '''  input             {0}_AXI_aclk,
  input             {0}_AXI_aresetn,
  input             {0}_AXI_arready, 
  input             {0}_AXI_awready, 
  input   [{1:<4}:0]  {0}_AXI_bid,
  input   [1   :0]  {0}_AXI_bresp,
  input             {0}_AXI_bvalid, 
  input   [{2:<4}:0]  {0}_AXI_rdata,  
  input   [{1:<4}:0]  {0}_AXI_rid,    
  input             {0}_AXI_rlast,  
  input   [1   :0]  {0}_AXI_rresp,  
  input             {0}_AXI_rvalid, 
  input             {0}_AXI_wready, 
  output  [31  :0]  {0}_AXI_araddr, 
  output  [1   :0]  {0}_AXI_arburst, 
  output  [3   :0]  {0}_AXI_arcache, 
  output  [{1:<4}:0]  {0}_AXI_arid,   
  output  [7   :0]  {0}_AXI_arlen,  
  output  [0   :0]  {0}_AXI_arlock, 
  output  [2   :0]  {0}_AXI_arprot, 
  output  [3   :0]  {0}_AXI_arqos,  
  output  [2   :0]  {0}_AXI_arsize, 
  output            {0}_AXI_arvalid, 
  output  [31  :0]  {0}_AXI_awaddr, 
  output  [1   :0]  {0}_AXI_awburst, 
  output  [3   :0]  {0}_AXI_awcache, 
  output  [{1:<4}:0]  {0}_AXI_awid,   
  output  [7   :0]  {0}_AXI_awlen,  
  output  [0   :0]  {0}_AXI_awlock, 
  output  [2   :0]  {0}_AXI_awprot, 
  output  [3   :0]  {0}_AXI_awqos,  
  output  [2   :0]  {0}_AXI_awsize, 
  output            {0}_AXI_awvalid, 
  output            {0}_AXI_bready, 
  output            {0}_AXI_rready, 
  output  [{2:<4}:0]  {0}_AXI_wdata,  
  output            {0}_AXI_wlast,  
  output  [{3:<4}:0]  {0}_AXI_wstrb,  
  output            {0}_AXI_wvalid,'''
%>\
<%
sig_s_list = '''  input             {0}_AXI_aclk,   
  input   [31  :0]  {0}_AXI_araddr, 
  input   [1   :0]  {0}_AXI_arburst, 
  input   [3   :0]  {0}_AXI_arcache, 
  input             {0}_AXI_aresetn, 
  input   [{1:<4}:0]  {0}_AXI_arid,   
  input   [7   :0]  {0}_AXI_arlen,  
  input   [0   :0]  {0}_AXI_arlock, 
  input   [2   :0]  {0}_AXI_arprot, 
  input   [3   :0]  {0}_AXI_arqos,  
  input   [2   :0]  {0}_AXI_arsize, 
  input             {0}_AXI_arvalid, 
  input   [31  :0]  {0}_AXI_awaddr, 
  input   [1   :0]  {0}_AXI_awburst, 
  input   [3   :0]  {0}_AXI_awcache, 
  input   [{1:<4}:0]  {0}_AXI_awid,   
  input   [7   :0]  {0}_AXI_awlen,  
  input   [0   :0]  {0}_AXI_awlock, 
  input   [2   :0]  {0}_AXI_awprot, 
  input   [3   :0]  {0}_AXI_awqos,  
  input   [2   :0]  {0}_AXI_awsize, 
  input             {0}_AXI_awvalid, 
  input             {0}_AXI_bready, 
  input             {0}_AXI_rready, 
  input   [1023:0]  {0}_AXI_wdata,  
  input             {0}_AXI_wlast,  
  input   [127 :0]  {0}_AXI_wstrb,  
  input             {0}_AXI_wvalid, 
  output            {0}_AXI_arready, 
  output            {0}_AXI_awready, 
  output  [{1:<4}:0]  {0}_AXI_bid,    
  output  [1   :0]  {0}_AXI_bresp,  
  output            {0}_AXI_bvalid, 
  output  [1023:0]  {0}_AXI_rdata,  
  output  [{1:<4}:0]  {0}_AXI_rid,    
  output            {0}_AXI_rlast,  
  output  [1   :0]  {0}_AXI_rresp,  
  output            {0}_AXI_rvalid, 
  output            {0}_AXI_wready,'''
%>\

module shell_xbar_top(
${sig_s_list.format("HOST_S", 0)}
% for pe in chip.pe:
${sig_m_list.format("{}_M".format(pe.name), 3, 1023, 127)}
% endfor
${sig_m_list.format("sys_reg", 3, 31, 3).rstrip(",")}
);

  parameter int unsigned NumMasters        = 1; //can be configured with more masters
  parameter int unsigned NumSlaves         = ${len(chip.pe)+1}; //N pe + sysreg
  parameter int unsigned AxiIdWidthMasters = 4;
  parameter int unsigned AxiIdUsed         = 4;
  parameter int unsigned AxiDataWidth      = `AXI_XBAR_DATA_WIDTH;
  parameter int unsigned Pipeline          = 32'd1;
  parameter bit          EnAtop            = 1'b0;
  parameter bit EnExcl                     = 1'b0;   
  parameter bit UniqueIds                  = 1'b0;    

  // AXI configuration which is automatically derived.
  localparam int unsigned AxiIdWidthSlaves =  AxiIdWidthMasters + $clog2(NumMasters);
  localparam int unsigned AxiAddrWidth     =  `AXI_XBAR_ADDR_WIDTH;
  localparam int unsigned AxiStrbWidth     =  AxiDataWidth / 8;
  localparam int unsigned AxiUserWidth     =  1;

  localparam axi_pkg::xbar_cfg_t xbar_cfg = '{
    NoSlvPorts:         NumMasters,
    NoMstPorts:         NumSlaves,
    MaxMstTrans:        `MAX_MST_TRANS,
    MaxSlvTrans:        `MAX_SLV_TRANS,
    FallThrough:        1'b0,
    LatencyMode:        axi_pkg::CUT_ALL_AX,
    PipelineStages:     Pipeline,
    AxiIdWidthSlvPorts: AxiIdWidthMasters,
    AxiIdUsedSlvPorts:  AxiIdUsed,
    UniqueIds:          UniqueIds,
    AxiAddrWidth:       AxiAddrWidth,
    AxiDataWidth:       AxiDataWidth,
    NoAddrRules:        NumSlaves
  };

<%
SlvDwcPos = str(len(chip.pe)+1)
SlvDwcPos += "'b{}1".format(len(chip.pe)*"0")
%>\
  localparam SlvDwcPos = ${SlvDwcPos};

  function [xbar_cfg.NoMstPorts-1:0] [31:0] SlvDwcGen ();
    SlvDwcGen[0] = 32;
% for ind in range(len(chip.pe)):
    SlvDwcGen[${ind+1}] = 1024;
% endfor
  endfunction

  localparam [xbar_cfg.NoMstPorts-1:0] [31:0] SlvDwcDataWidth = SlvDwcGen();

  //-----------------------------------
  // Addess Map
  //-----------------------------------
  typedef axi_pkg::xbar_rule_32_t         rule_t; // Has to be the same width as axi addr
  function rule_t [xbar_cfg.NoAddrRules-1:0] addr_map_gen ();
% for ind, mem in enumerate(chip.addr_map):
    addr_map_gen[${ind}].idx = ${ind};  // ${mem["name"]}
    addr_map_gen[${ind}].start_addr = ${mem["start_addr"]}; 
    addr_map_gen[${ind}].end_addr = ${mem["end_addr"]}; 
%endfor
  endfunction

  localparam rule_t [xbar_cfg.NoAddrRules-1:0] AddrMap = addr_map_gen();

  //-----------------------------------
  // AXI Interface
  //-----------------------------------
  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AxiAddrWidth      ),
    .AXI_DATA_WIDTH ( AxiDataWidth      ),
    .AXI_ID_WIDTH   ( AxiIdWidthMasters ),
    .AXI_USER_WIDTH ( AxiUserWidth      )
  ) master [NumMasters-1:0] ();

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AxiAddrWidth     ),
    .AXI_DATA_WIDTH ( AxiDataWidth     ),
    .AXI_ID_WIDTH   ( AxiIdWidthSlaves ),
    .AXI_USER_WIDTH ( AxiUserWidth     )
  ) slave [NumSlaves-1:0] ();

  //-----------------------------------
  // AXI Interface Connection
  //-----------------------------------
  `AXI_MST_ASSIGN(master[0], HOST_S)

  `AXI_SLV_ASSIGN(slave[0], sys_reg)
% for ind, pe in enumerate(chip.pe):
  `AXI_SLV_ASSIGN(slave[${ind+1}], ${"{}_M".format(pe.name)})
% endfor

  //-----------------------------------
  // DUT
  //-----------------------------------
  axi_xbar_top #(
    .AXI_USER_WIDTH ( AxiUserWidth  ),
    .xbar_cfg       ( xbar_cfg        ),
    .SlvDwcPos      ( SlvDwcPos     ),
    .SlvDwcDataWidth( SlvDwcDataWidth ),
    .rule_t         ( rule_t          )
  ) i_xbar_top (
    .clk_i                  ( HOST_S_AXI_aclk     ),
    .rst_ni                 ( HOST_S_AXI_aresetn   ),
    .test_i                 ( 1'b0    ),
    .slv_ports              ( master  ),
    .mst_ports              ( slave   ),
    .addr_map_i             ( AddrMap )
  );

endmodule
