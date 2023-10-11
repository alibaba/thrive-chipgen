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
sig_m_list = '''  input             {0}{1}_AXI_aclk,
  input             {0}{1}_AXI_aresetn,
  input             {0}{1}_AXI_arready, 
  input             {0}{1}_AXI_awready, 
  input   [`AXI_SLAVE_ID_WIDTH-1   :0]  {0}{1}_AXI_bid,
  input   [1   :0]  {0}{1}_AXI_bresp,
  input             {0}{1}_AXI_bvalid, 
  input   [{2}:0]  {0}{1}_AXI_rdata,  
  input   [`AXI_SLAVE_ID_WIDTH-1   :0]  {0}{1}_AXI_rid,    
  input             {0}{1}_AXI_rlast,  
  input   [1   :0]  {0}{1}_AXI_rresp,  
  input             {0}{1}_AXI_rvalid, 
  input             {0}{1}_AXI_wready, 
  output  [31  :0]  {0}{1}_AXI_araddr, 
  output  [1   :0]  {0}{1}_AXI_arburst, 
  output  [3   :0]  {0}{1}_AXI_arcache, 
  output  [`AXI_SLAVE_ID_WIDTH-1   :0]  {0}{1}_AXI_arid,   
  output  [7   :0]  {0}{1}_AXI_arlen,  
  output  [0   :0]  {0}{1}_AXI_arlock, 
  output  [2   :0]  {0}{1}_AXI_arprot, 
  output  [3   :0]  {0}{1}_AXI_arqos,  
  output  [2   :0]  {0}{1}_AXI_arsize, 
  output            {0}{1}_AXI_arvalid, 
  output  [31  :0]  {0}{1}_AXI_awaddr, 
  output  [1   :0]  {0}{1}_AXI_awburst, 
  output  [3   :0]  {0}{1}_AXI_awcache, 
  output  [`AXI_SLAVE_ID_WIDTH-1   :0]  {0}{1}_AXI_awid,   
  output  [7   :0]  {0}{1}_AXI_awlen,  
  output  [0   :0]  {0}{1}_AXI_awlock, 
  output  [2   :0]  {0}{1}_AXI_awprot, 
  output  [3   :0]  {0}{1}_AXI_awqos,  
  output  [2   :0]  {0}{1}_AXI_awsize, 
  output            {0}{1}_AXI_awvalid, 
  output            {0}{1}_AXI_bready, 
  output            {0}{1}_AXI_rready, 
  output  [{2}:0]  {0}{1}_AXI_wdata,  
  output            {0}{1}_AXI_wlast,  
  output  [{3} :0]  {0}{1}_AXI_wstrb,  
  output            {0}{1}_AXI_wvalid,'''
%>\
<%
sig_s_list = '''  input             {0}{1}_AXI_aclk,   
  input   [31  :0]  {0}{1}_AXI_araddr, 
  input   [1   :0]  {0}{1}_AXI_arburst, 
  input   [3   :0]  {0}{1}_AXI_arcache, 
  input             {0}{1}_AXI_aresetn, 
  input   [`AXI_MASTER_ID_WIDTH-1   :0]  {0}{1}_AXI_arid,   
  input   [7   :0]  {0}{1}_AXI_arlen,  
  input   [0   :0]  {0}{1}_AXI_arlock, 
  input   [2   :0]  {0}{1}_AXI_arprot, 
  input   [3   :0]  {0}{1}_AXI_arqos,  
  input   [2   :0]  {0}{1}_AXI_arsize, 
  input             {0}{1}_AXI_arvalid, 
  input   [31  :0]  {0}{1}_AXI_awaddr, 
  input   [1   :0]  {0}{1}_AXI_awburst, 
  input   [3   :0]  {0}{1}_AXI_awcache, 
  input   [`AXI_MASTER_ID_WIDTH-1   :0]  {0}{1}_AXI_awid,   
  input   [7   :0]  {0}{1}_AXI_awlen,  
  input   [0   :0]  {0}{1}_AXI_awlock, 
  input   [2   :0]  {0}{1}_AXI_awprot, 
  input   [3   :0]  {0}{1}_AXI_awqos,  
  input   [2   :0]  {0}{1}_AXI_awsize, 
  input             {0}{1}_AXI_awvalid, 
  input             {0}{1}_AXI_bready, 
  input             {0}{1}_AXI_rready, 
  input   [{2}  :0]  {0}{1}_AXI_wdata,  
  input             {0}{1}_AXI_wlast,  
  input   [{3}   :0]  {0}{1}_AXI_wstrb,  
  input             {0}{1}_AXI_wvalid, 
  output            {0}{1}_AXI_arready, 
  output            {0}{1}_AXI_awready, 
  output  [`AXI_MASTER_ID_WIDTH-1   :0]  {0}{1}_AXI_bid,    
  output  [1   :0]  {0}{1}_AXI_bresp,  
  output            {0}{1}_AXI_bvalid, 
  output  [{2}  :0]  {0}{1}_AXI_rdata,  
  output  [`AXI_MASTER_ID_WIDTH-1   :0]  {0}{1}_AXI_rid,    
  output            {0}{1}_AXI_rlast,  
  output  [1   :0]  {0}{1}_AXI_rresp,  
  output            {0}{1}_AXI_rvalid, 
  output            {0}{1}_AXI_wready,'''
%>\

% if xbar.name:
module ${xbar.name}_xbar_top(
% else:
module xbar_top(
% endif
% for ind, dw in xbar.m_dw.items():
${sig_m_list.format("M", "{:0>2d}".format(ind), dw[0]-1, pow(2, int(math.log(dw[0],2)-3)) - 1)}
% endfor
${sig_s_list.format("S", "_HOST", 1023, 127)}
% for ind, dw in xbar.s_dw.items():
    % if ind == xbar.num_slave - 1:
${sig_s_list.format("S", "{:0>2d}".format(ind), dw[0]-1, pow(2, int(math.log(dw[0],2)-3)) - 1).rstrip(",")}
    % else:
${sig_s_list.format("S", "{:0>2d}".format(ind), dw[0]-1, pow(2, int(math.log(dw[0],2)-3)) - 1)}
    % endif
% endfor
);

  parameter int unsigned NumMasters        = ${xbar.num_slave+1};   //N+shell_axi
  parameter int unsigned NumSlaves         = ${xbar.num_master};
  parameter int unsigned AxiIdWidthMasters = `AXI_MASTER_ID_WIDTH;
  parameter int unsigned AxiIdUsed         = `AXI_MASTER_ID_WIDTH;
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
MstDwcPos = str(xbar.num_slave+1)
MstDwcPos += "'b"  
tmp = ""
tmp += "0"
for i, dw in xbar.s_dw.items():
    tmp += "0" if dw[0] == 1024 else "1"
MstDwcPos += tmp[::-1]

SlvDwcPos = str(xbar.num_master)
SlvDwcPos += "'b"
tmp = ""
for i, dw in xbar.m_dw.items():
    tmp += "0" if dw[0] == 1024 else "1"
SlvDwcPos += tmp[::-1]
%>\
  localparam MstDwcPos = ${MstDwcPos};
  localparam SlvDwcPos = ${SlvDwcPos};

  function [xbar_cfg.NoSlvPorts-1:0] [31:0] MstDwcGen ();
    MstDwcGen[0] = `AXI_XBAR_DATA_WIDTH;    //shell
% for ind, dw in xbar.s_dw.items():
    MstDwcGen[${ind+1}] = ${dw[0]}; // ${dw[1]}
% endfor
  endfunction

  function [xbar_cfg.NoMstPorts-1:0] [31:0] SlvDwcGen ();
% for ind, dw in xbar.m_dw.items():
    SlvDwcGen[${ind}] = ${dw[0]}; // ${dw[1]}
% endfor
  endfunction

  localparam [xbar_cfg.NoSlvPorts-1:0] [31:0] MstDwcDataWidth = MstDwcGen();
  localparam [xbar_cfg.NoMstPorts-1:0] [31:0] SlvDwcDataWidth = SlvDwcGen();

  //-----------------------------------
  // Addess Map
  //-----------------------------------
  typedef axi_pkg::xbar_rule_32_t         rule_t; // Has to be the same width as axi addr
  function rule_t [xbar_cfg.NoAddrRules-1:0] addr_map_gen ();
% for ind, mem in enumerate(mem_ss.addr_map.keys()):
    addr_map_gen[${ind}].idx = ${ind};  // ${mem}
    addr_map_gen[${ind}].start_addr = ${mem_ss.addr_map[mem]["start_addr"]}; 
    addr_map_gen[${ind}].end_addr = ${mem_ss.addr_map[mem]["end_addr"]}; 
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
    `AXI_MST_ASSIGN(master[0], S_HOST)
% for ind, _ in xbar.s_dw.items():
    `AXI_MST_ASSIGN(master[${ind+1}], S${"{:0>2d}".format(ind)})
% endfor

% for ind, _ in xbar.m_dw.items():
    `AXI_SLV_ASSIGN(slave[${ind}], M${"{:0>2d}".format(ind)})
% endfor

  //-----------------------------------
  // DUT
  //-----------------------------------
  axi_xbar_top #(
    .AXI_USER_WIDTH ( AxiUserWidth  ),
    .xbar_cfg       ( xbar_cfg        ),
    .MstDwcPos      ( MstDwcPos     ),
    .SlvDwcPos      ( SlvDwcPos     ),
    .MstDwcDataWidth( MstDwcDataWidth ),
    .SlvDwcDataWidth( SlvDwcDataWidth ),
    .rule_t         ( rule_t          )
  ) i_xbar_top (
    .clk_i                  ( M00_AXI_aclk     ),
    .rst_ni                 ( M00_AXI_aresetn   ),
    .test_i                 ( 1'b0    ),
    .slv_ports              ( master  ),
    .mst_ports              ( slave   ),
    .addr_map_i             ( AddrMap )
  );

endmodule
