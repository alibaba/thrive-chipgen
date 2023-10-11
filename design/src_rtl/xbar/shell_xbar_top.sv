`include "axi/typedef.svh"
`include "axi/assign.svh"
`include "axi/xbar_define.h"

module shell_xbar_top(
  input             HOST_S_AXI_aclk,   
  input   [31  :0]  HOST_S_AXI_araddr, 
  input   [1   :0]  HOST_S_AXI_arburst, 
  input   [3   :0]  HOST_S_AXI_arcache, 
  input             HOST_S_AXI_aresetn, 
  input   [0   :0]  HOST_S_AXI_arid,   
  input   [7   :0]  HOST_S_AXI_arlen,  
  input   [0   :0]  HOST_S_AXI_arlock, 
  input   [2   :0]  HOST_S_AXI_arprot, 
  input   [3   :0]  HOST_S_AXI_arqos,  
  input   [2   :0]  HOST_S_AXI_arsize, 
  input             HOST_S_AXI_arvalid, 
  input   [31  :0]  HOST_S_AXI_awaddr, 
  input   [1   :0]  HOST_S_AXI_awburst, 
  input   [3   :0]  HOST_S_AXI_awcache, 
  input   [0   :0]  HOST_S_AXI_awid,   
  input   [7   :0]  HOST_S_AXI_awlen,  
  input   [0   :0]  HOST_S_AXI_awlock, 
  input   [2   :0]  HOST_S_AXI_awprot, 
  input   [3   :0]  HOST_S_AXI_awqos,  
  input   [2   :0]  HOST_S_AXI_awsize, 
  input             HOST_S_AXI_awvalid, 
  input             HOST_S_AXI_bready, 
  input             HOST_S_AXI_rready, 
  input   [1023:0]  HOST_S_AXI_wdata,  
  input             HOST_S_AXI_wlast,  
  input   [127 :0]  HOST_S_AXI_wstrb,  
  input             HOST_S_AXI_wvalid, 
  output            HOST_S_AXI_arready, 
  output            HOST_S_AXI_awready, 
  output  [0   :0]  HOST_S_AXI_bid,    
  output  [1   :0]  HOST_S_AXI_bresp,  
  output            HOST_S_AXI_bvalid, 
  output  [1023:0]  HOST_S_AXI_rdata,  
  output  [0   :0]  HOST_S_AXI_rid,    
  output            HOST_S_AXI_rlast,  
  output  [1   :0]  HOST_S_AXI_rresp,  
  output            HOST_S_AXI_rvalid, 
  output            HOST_S_AXI_wready,
  input             pe_0_0_M_AXI_aclk,
  input             pe_0_0_M_AXI_aresetn,
  input             pe_0_0_M_AXI_arready, 
  input             pe_0_0_M_AXI_awready, 
  input   [3   :0]  pe_0_0_M_AXI_bid,
  input   [1   :0]  pe_0_0_M_AXI_bresp,
  input             pe_0_0_M_AXI_bvalid, 
  input   [1023:0]  pe_0_0_M_AXI_rdata,  
  input   [3   :0]  pe_0_0_M_AXI_rid,    
  input             pe_0_0_M_AXI_rlast,  
  input   [1   :0]  pe_0_0_M_AXI_rresp,  
  input             pe_0_0_M_AXI_rvalid, 
  input             pe_0_0_M_AXI_wready, 
  output  [31  :0]  pe_0_0_M_AXI_araddr, 
  output  [1   :0]  pe_0_0_M_AXI_arburst, 
  output  [3   :0]  pe_0_0_M_AXI_arcache, 
  output  [3   :0]  pe_0_0_M_AXI_arid,   
  output  [7   :0]  pe_0_0_M_AXI_arlen,  
  output  [0   :0]  pe_0_0_M_AXI_arlock, 
  output  [2   :0]  pe_0_0_M_AXI_arprot, 
  output  [3   :0]  pe_0_0_M_AXI_arqos,  
  output  [2   :0]  pe_0_0_M_AXI_arsize, 
  output            pe_0_0_M_AXI_arvalid, 
  output  [31  :0]  pe_0_0_M_AXI_awaddr, 
  output  [1   :0]  pe_0_0_M_AXI_awburst, 
  output  [3   :0]  pe_0_0_M_AXI_awcache, 
  output  [3   :0]  pe_0_0_M_AXI_awid,   
  output  [7   :0]  pe_0_0_M_AXI_awlen,  
  output  [0   :0]  pe_0_0_M_AXI_awlock, 
  output  [2   :0]  pe_0_0_M_AXI_awprot, 
  output  [3   :0]  pe_0_0_M_AXI_awqos,  
  output  [2   :0]  pe_0_0_M_AXI_awsize, 
  output            pe_0_0_M_AXI_awvalid, 
  output            pe_0_0_M_AXI_bready, 
  output            pe_0_0_M_AXI_rready, 
  output  [1023:0]  pe_0_0_M_AXI_wdata,  
  output            pe_0_0_M_AXI_wlast,  
  output  [127 :0]  pe_0_0_M_AXI_wstrb,  
  output            pe_0_0_M_AXI_wvalid,
  input             pe_1_0_M_AXI_aclk,
  input             pe_1_0_M_AXI_aresetn,
  input             pe_1_0_M_AXI_arready, 
  input             pe_1_0_M_AXI_awready, 
  input   [3   :0]  pe_1_0_M_AXI_bid,
  input   [1   :0]  pe_1_0_M_AXI_bresp,
  input             pe_1_0_M_AXI_bvalid, 
  input   [1023:0]  pe_1_0_M_AXI_rdata,  
  input   [3   :0]  pe_1_0_M_AXI_rid,    
  input             pe_1_0_M_AXI_rlast,  
  input   [1   :0]  pe_1_0_M_AXI_rresp,  
  input             pe_1_0_M_AXI_rvalid, 
  input             pe_1_0_M_AXI_wready, 
  output  [31  :0]  pe_1_0_M_AXI_araddr, 
  output  [1   :0]  pe_1_0_M_AXI_arburst, 
  output  [3   :0]  pe_1_0_M_AXI_arcache, 
  output  [3   :0]  pe_1_0_M_AXI_arid,   
  output  [7   :0]  pe_1_0_M_AXI_arlen,  
  output  [0   :0]  pe_1_0_M_AXI_arlock, 
  output  [2   :0]  pe_1_0_M_AXI_arprot, 
  output  [3   :0]  pe_1_0_M_AXI_arqos,  
  output  [2   :0]  pe_1_0_M_AXI_arsize, 
  output            pe_1_0_M_AXI_arvalid, 
  output  [31  :0]  pe_1_0_M_AXI_awaddr, 
  output  [1   :0]  pe_1_0_M_AXI_awburst, 
  output  [3   :0]  pe_1_0_M_AXI_awcache, 
  output  [3   :0]  pe_1_0_M_AXI_awid,   
  output  [7   :0]  pe_1_0_M_AXI_awlen,  
  output  [0   :0]  pe_1_0_M_AXI_awlock, 
  output  [2   :0]  pe_1_0_M_AXI_awprot, 
  output  [3   :0]  pe_1_0_M_AXI_awqos,  
  output  [2   :0]  pe_1_0_M_AXI_awsize, 
  output            pe_1_0_M_AXI_awvalid, 
  output            pe_1_0_M_AXI_bready, 
  output            pe_1_0_M_AXI_rready, 
  output  [1023:0]  pe_1_0_M_AXI_wdata,  
  output            pe_1_0_M_AXI_wlast,  
  output  [127 :0]  pe_1_0_M_AXI_wstrb,  
  output            pe_1_0_M_AXI_wvalid,
  input             pe_0_1_M_AXI_aclk,
  input             pe_0_1_M_AXI_aresetn,
  input             pe_0_1_M_AXI_arready, 
  input             pe_0_1_M_AXI_awready, 
  input   [3   :0]  pe_0_1_M_AXI_bid,
  input   [1   :0]  pe_0_1_M_AXI_bresp,
  input             pe_0_1_M_AXI_bvalid, 
  input   [1023:0]  pe_0_1_M_AXI_rdata,  
  input   [3   :0]  pe_0_1_M_AXI_rid,    
  input             pe_0_1_M_AXI_rlast,  
  input   [1   :0]  pe_0_1_M_AXI_rresp,  
  input             pe_0_1_M_AXI_rvalid, 
  input             pe_0_1_M_AXI_wready, 
  output  [31  :0]  pe_0_1_M_AXI_araddr, 
  output  [1   :0]  pe_0_1_M_AXI_arburst, 
  output  [3   :0]  pe_0_1_M_AXI_arcache, 
  output  [3   :0]  pe_0_1_M_AXI_arid,   
  output  [7   :0]  pe_0_1_M_AXI_arlen,  
  output  [0   :0]  pe_0_1_M_AXI_arlock, 
  output  [2   :0]  pe_0_1_M_AXI_arprot, 
  output  [3   :0]  pe_0_1_M_AXI_arqos,  
  output  [2   :0]  pe_0_1_M_AXI_arsize, 
  output            pe_0_1_M_AXI_arvalid, 
  output  [31  :0]  pe_0_1_M_AXI_awaddr, 
  output  [1   :0]  pe_0_1_M_AXI_awburst, 
  output  [3   :0]  pe_0_1_M_AXI_awcache, 
  output  [3   :0]  pe_0_1_M_AXI_awid,   
  output  [7   :0]  pe_0_1_M_AXI_awlen,  
  output  [0   :0]  pe_0_1_M_AXI_awlock, 
  output  [2   :0]  pe_0_1_M_AXI_awprot, 
  output  [3   :0]  pe_0_1_M_AXI_awqos,  
  output  [2   :0]  pe_0_1_M_AXI_awsize, 
  output            pe_0_1_M_AXI_awvalid, 
  output            pe_0_1_M_AXI_bready, 
  output            pe_0_1_M_AXI_rready, 
  output  [1023:0]  pe_0_1_M_AXI_wdata,  
  output            pe_0_1_M_AXI_wlast,  
  output  [127 :0]  pe_0_1_M_AXI_wstrb,  
  output            pe_0_1_M_AXI_wvalid,
  input             pe_1_1_M_AXI_aclk,
  input             pe_1_1_M_AXI_aresetn,
  input             pe_1_1_M_AXI_arready, 
  input             pe_1_1_M_AXI_awready, 
  input   [3   :0]  pe_1_1_M_AXI_bid,
  input   [1   :0]  pe_1_1_M_AXI_bresp,
  input             pe_1_1_M_AXI_bvalid, 
  input   [1023:0]  pe_1_1_M_AXI_rdata,  
  input   [3   :0]  pe_1_1_M_AXI_rid,    
  input             pe_1_1_M_AXI_rlast,  
  input   [1   :0]  pe_1_1_M_AXI_rresp,  
  input             pe_1_1_M_AXI_rvalid, 
  input             pe_1_1_M_AXI_wready, 
  output  [31  :0]  pe_1_1_M_AXI_araddr, 
  output  [1   :0]  pe_1_1_M_AXI_arburst, 
  output  [3   :0]  pe_1_1_M_AXI_arcache, 
  output  [3   :0]  pe_1_1_M_AXI_arid,   
  output  [7   :0]  pe_1_1_M_AXI_arlen,  
  output  [0   :0]  pe_1_1_M_AXI_arlock, 
  output  [2   :0]  pe_1_1_M_AXI_arprot, 
  output  [3   :0]  pe_1_1_M_AXI_arqos,  
  output  [2   :0]  pe_1_1_M_AXI_arsize, 
  output            pe_1_1_M_AXI_arvalid, 
  output  [31  :0]  pe_1_1_M_AXI_awaddr, 
  output  [1   :0]  pe_1_1_M_AXI_awburst, 
  output  [3   :0]  pe_1_1_M_AXI_awcache, 
  output  [3   :0]  pe_1_1_M_AXI_awid,   
  output  [7   :0]  pe_1_1_M_AXI_awlen,  
  output  [0   :0]  pe_1_1_M_AXI_awlock, 
  output  [2   :0]  pe_1_1_M_AXI_awprot, 
  output  [3   :0]  pe_1_1_M_AXI_awqos,  
  output  [2   :0]  pe_1_1_M_AXI_awsize, 
  output            pe_1_1_M_AXI_awvalid, 
  output            pe_1_1_M_AXI_bready, 
  output            pe_1_1_M_AXI_rready, 
  output  [1023:0]  pe_1_1_M_AXI_wdata,  
  output            pe_1_1_M_AXI_wlast,  
  output  [127 :0]  pe_1_1_M_AXI_wstrb,  
  output            pe_1_1_M_AXI_wvalid,
  input             sys_reg_AXI_aclk,
  input             sys_reg_AXI_aresetn,
  input             sys_reg_AXI_arready, 
  input             sys_reg_AXI_awready, 
  input   [3   :0]  sys_reg_AXI_bid,
  input   [1   :0]  sys_reg_AXI_bresp,
  input             sys_reg_AXI_bvalid, 
  input   [31  :0]  sys_reg_AXI_rdata,  
  input   [3   :0]  sys_reg_AXI_rid,    
  input             sys_reg_AXI_rlast,  
  input   [1   :0]  sys_reg_AXI_rresp,  
  input             sys_reg_AXI_rvalid, 
  input             sys_reg_AXI_wready, 
  output  [31  :0]  sys_reg_AXI_araddr, 
  output  [1   :0]  sys_reg_AXI_arburst, 
  output  [3   :0]  sys_reg_AXI_arcache, 
  output  [3   :0]  sys_reg_AXI_arid,   
  output  [7   :0]  sys_reg_AXI_arlen,  
  output  [0   :0]  sys_reg_AXI_arlock, 
  output  [2   :0]  sys_reg_AXI_arprot, 
  output  [3   :0]  sys_reg_AXI_arqos,  
  output  [2   :0]  sys_reg_AXI_arsize, 
  output            sys_reg_AXI_arvalid, 
  output  [31  :0]  sys_reg_AXI_awaddr, 
  output  [1   :0]  sys_reg_AXI_awburst, 
  output  [3   :0]  sys_reg_AXI_awcache, 
  output  [3   :0]  sys_reg_AXI_awid,   
  output  [7   :0]  sys_reg_AXI_awlen,  
  output  [0   :0]  sys_reg_AXI_awlock, 
  output  [2   :0]  sys_reg_AXI_awprot, 
  output  [3   :0]  sys_reg_AXI_awqos,  
  output  [2   :0]  sys_reg_AXI_awsize, 
  output            sys_reg_AXI_awvalid, 
  output            sys_reg_AXI_bready, 
  output            sys_reg_AXI_rready, 
  output  [31  :0]  sys_reg_AXI_wdata,  
  output            sys_reg_AXI_wlast,  
  output  [3   :0]  sys_reg_AXI_wstrb,  
  output            sys_reg_AXI_wvalid
);

  parameter int unsigned NumMasters        = 1; //can be configured with more masters
  parameter int unsigned NumSlaves         = 5; //N pe + sysreg
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

  localparam SlvDwcPos = 5'b00001;

  function [xbar_cfg.NoMstPorts-1:0] [31:0] SlvDwcGen ();
    SlvDwcGen[0] = 32;
    SlvDwcGen[1] = 1024;
    SlvDwcGen[2] = 1024;
    SlvDwcGen[3] = 1024;
    SlvDwcGen[4] = 1024;
  endfunction

  localparam [xbar_cfg.NoMstPorts-1:0] [31:0] SlvDwcDataWidth = SlvDwcGen();

  //-----------------------------------
  // Addess Map
  //-----------------------------------
  typedef axi_pkg::xbar_rule_32_t         rule_t; // Has to be the same width as axi addr
  function rule_t [xbar_cfg.NoAddrRules-1:0] addr_map_gen ();
    addr_map_gen[0].idx = 0;  // sys_reg
    addr_map_gen[0].start_addr = 32'hC000_0000; 
    addr_map_gen[0].end_addr = 32'hC010_0000; 
    addr_map_gen[1].idx = 1;  // pe_0_0
    addr_map_gen[1].start_addr = 32'h0000_0000; 
    addr_map_gen[1].end_addr = 32'h1000_0000; 
    addr_map_gen[2].idx = 2;  // pe_1_0
    addr_map_gen[2].start_addr = 32'h1000_0000; 
    addr_map_gen[2].end_addr = 32'h2000_0000; 
    addr_map_gen[3].idx = 3;  // pe_0_1
    addr_map_gen[3].start_addr = 32'h2000_0000; 
    addr_map_gen[3].end_addr = 32'h3000_0000; 
    addr_map_gen[4].idx = 4;  // pe_1_1
    addr_map_gen[4].start_addr = 32'h3000_0000; 
    addr_map_gen[4].end_addr = 32'h4000_0000; 
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
  `AXI_SLV_ASSIGN(slave[1], pe_0_0_M)
  `AXI_SLV_ASSIGN(slave[2], pe_1_0_M)
  `AXI_SLV_ASSIGN(slave[3], pe_0_1_M)
  `AXI_SLV_ASSIGN(slave[4], pe_1_1_M)

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
