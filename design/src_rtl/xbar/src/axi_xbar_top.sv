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


module axi_xbar_top
#(
  parameter int unsigned AXI_USER_WIDTH         =  0,
  parameter axi_pkg::xbar_cfg_t xbar_cfg        = '0,
//  parameter axi_pkg::dwc_cfg_t dwc_cfg          = '{default:'0},
  parameter logic [xbar_cfg.NoSlvPorts-1:0] MstDwcPos = '0,
  parameter logic [xbar_cfg.NoMstPorts-1:0] SlvDwcPos = '0,
  parameter logic [xbar_cfg.NoSlvPorts-1:0] [31:0] MstDwcDataWidth = '0,
  parameter logic [xbar_cfg.NoMstPorts-1:0] [31:0] SlvDwcDataWidth = '0,
  parameter NUM_MST_DWC                         = $countones(MstDwcPos),
  parameter NUM_SLV_DWC                         = $countones(SlvDwcPos),
  parameter type rule_t                         = axi_pkg::xbar_rule_64_t
) (
  input  logic                                  clk_i,
  input  logic                                  rst_ni,
  input  logic                                  test_i,
  AXI_BUS.Slave                                 slv_ports [xbar_cfg.NoSlvPorts-1:0],
  AXI_BUS.Master                                mst_ports [xbar_cfg.NoMstPorts-1:0],
  input  rule_t [xbar_cfg.NoAddrRules-1:0]      addr_map_i
);

  AXI_BUS # (                                   
    .AXI_ADDR_WIDTH ( xbar_cfg.AxiAddrWidth ),
    .AXI_DATA_WIDTH ( xbar_cfg.AxiDataWidth ),
    .AXI_ID_WIDTH   ( xbar_cfg.AxiIdWidthSlvPorts ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH )
  ) xbar_slv_ports [xbar_cfg.NoSlvPorts-1:0] ();

  for (genvar i =0; i<xbar_cfg.NoSlvPorts; i++) begin: gen_mst_dwc
    if (MstDwcPos[i]) begin: gen_mst_dwc_inst
      AXI_BUS #(                                      
        .AXI_ADDR_WIDTH ( xbar_cfg.AxiAddrWidth ),
        .AXI_DATA_WIDTH ( xbar_cfg.AxiDataWidth),
        .AXI_ID_WIDTH   ( xbar_cfg.AxiIdWidthSlvPorts ),
        .AXI_USER_WIDTH ( AXI_USER_WIDTH )
      ) dwc_mst_ports ();

      axi_dw_converter_intf #(
        .AXI_ID_WIDTH(xbar_cfg.AxiIdWidthSlvPorts),
        .AXI_ADDR_WIDTH(xbar_cfg.AxiAddrWidth),
        .AXI_SLV_PORT_DATA_WIDTH(MstDwcDataWidth[i]),
        .AXI_MST_PORT_DATA_WIDTH(xbar_cfg.AxiDataWidth),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
      ) i_mst_dwc (
        .clk_i,
        .rst_ni,
        .slv(slv_ports[i]),
        .mst(dwc_mst_ports)
      );

      `AXI_ASSIGN(xbar_slv_ports[i], dwc_mst_ports)
    end
    else begin :gen_mst_port_through
      `AXI_ASSIGN(xbar_slv_ports[i], slv_ports[i])
    end
  end

  localparam int unsigned AxiIdWidthMstPorts =  xbar_cfg.AxiIdWidthSlvPorts + $clog2(xbar_cfg.NoSlvPorts);

  AXI_BUS # (                                   
    .AXI_ADDR_WIDTH ( xbar_cfg.AxiAddrWidth ),
    .AXI_DATA_WIDTH ( xbar_cfg.AxiDataWidth ),
    .AXI_ID_WIDTH   ( AxiIdWidthMstPorts ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH )
  ) xbar_mst_ports [xbar_cfg.NoMstPorts-1:0] ();

  for (genvar i =0; i<xbar_cfg.NoMstPorts; i++) begin: gen_slv_dwc
    if (SlvDwcPos[i]) begin: gen_slv_dwc_inst
      AXI_BUS #(                                      
        .AXI_ADDR_WIDTH ( xbar_cfg.AxiAddrWidth ),
        .AXI_DATA_WIDTH ( SlvDwcDataWidth[i]),
        .AXI_ID_WIDTH   ( AxiIdWidthMstPorts ),
        .AXI_USER_WIDTH ( AXI_USER_WIDTH )
      ) dwc_slv_ports ();

      axi_dw_converter_intf #(
        .AXI_ID_WIDTH(AxiIdWidthMstPorts),
        .AXI_ADDR_WIDTH(xbar_cfg.AxiAddrWidth),
        .AXI_MST_PORT_DATA_WIDTH(SlvDwcDataWidth[i]),
        .AXI_SLV_PORT_DATA_WIDTH(xbar_cfg.AxiDataWidth),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
      ) i_slv_dwc (
        .clk_i,
        .rst_ni,
        .slv(xbar_mst_ports[i]),
        .mst(dwc_slv_ports)
      );

      `AXI_ASSIGN(mst_ports[i], dwc_slv_ports)
    end
    else begin :gen_slv_port_through
      `AXI_ASSIGN(mst_ports[i], xbar_mst_ports[i])
    end
  end

//  for (genvar i =0; i<xbar_cfg.NoMstPorts; i++) begin: gen_slv_dwc_ports
//    if (dwc_cfg.SlvDwcPos[i]) begin
//      AXI_BUS #(                                      
//        .AXI_ADDR_WIDTH ( xbar_cfg.AxiAddrWidth ),
//        .AXI_DATA_WIDTH ( dwc_cfg.SlvDwcDataWidth[i] ),
//        .AXI_ID_WIDTH   ( xbar_cfg.AxiIdWidthSlvPorts ),
//        .AXI_USER_WIDTH ( AXI_USER_WIDTH )
//      ) dwc_slv_port[i] ();
//    end
//    else begin
//      AXI_BUS #(                                      
//        .AXI_ADDR_WIDTH ( xbar_cfg.AxiAddrWidth ),
//        .AXI_DATA_WIDTH ( xbar_cfg.AxiDataWidth ),
//        .AXI_ID_WIDTH   ( xbar_cfg.AxiIdWidthSlvPorts ),
//        .AXI_USER_WIDTH ( AXI_USER_WIDTH )
//      ) dwc_slv_port[i] ();
//    end
//  end

//  for (genvar i =0; i<xbar_cfg.NoSlvPorts; i++) begin: gen_mst_dwc
//    if (dwc_cfg.MstDwcPos[i]) begin
//      axi_dw_converter_intf #(
//        .AXI_ID_WIDTH(xbar_cfg.AxiIdWidthSlvPorts),
//        .AXI_ADDR_WIDTH(xbar_cfg.AxiAddrWidth),
//        .AXI_SLV_PORT_DATA_WIDTH(dwc_cfg.MstDwcDataWidth[i]),
//        .AXI_MST_PORT_DATA_WIDTH(xbar_cfg.AxiDataWidth),
//        .AXI_USER_WIDTH(AXI_USER_WIDTH)
//      ) i_mst_dwc (
//        .clk_i,
//        .rst_ni,
//        .slv(slv_ports[i]),
//        .mst(gen_mst_dwc_ports[i].dwc_mst_ports)
//      );
//    end
//  end

//  for (genvar i =0; i<xbar_cfg.NoMstPorts; i++) begin: gen_slv_dwc
//    if (dwc_cfg.SlvDwcPos[i]) begin
//      axi_dw_converter_intf #(
//        .AXI_ID_WIDTH(xbar_cfg.AxiIdWidthMstPorts),
//        .AXI_ADDR_WIDTH(xbar_cfg.AxiAddrWidth),
//        .AXI_SLV_PORT_DATA_WIDTH(dwc_cfg.SlvDwcDataWidth[i]),
//        .AXI_MST_PORT_DATA_WIDTH(xbar_cfg.AxiDataWidth),
//        .AXI_USER_WIDTH(AXI_USER_WIDTH)
//      ) i_slv_dwc (
//        .clk_i,
//        .rst_ni,
//        .slv(slv_ports[i]),
//        .mst(dwc_mst_ports[i])
//      );
//    end
//  end

//  for (genvar i =0; i<xbar_cfg.NoSlvPorts; i++) begin: gen_mst_con
//    if (dwc_cfg.MstDwcPos[i]) begin
//      `AXI_ASSIGN(xbar_slv_ports[i], gen_mst_dwc_ports[i].dwc_mst_ports)
//    end else begin
//      `AXI_ASSIGN(xbar_slv_ports[i], slv_ports[i])
//    end
//  end

  axi_xbar_intf #(
    .AXI_USER_WIDTH      (AXI_USER_WIDTH),
    .Cfg                 ( xbar_cfg   ),
    .ATOPS               ( 1'b0       ),
    .rule_t              ( rule_t     )
  ) i_xbar_dut (
    .clk_i                  ( clk_i     ),
    .rst_ni                 ( rst_ni   ),
    .test_i                 ( test_i    ),
    .slv_ports              ( xbar_slv_ports  ),
    .mst_ports              ( xbar_mst_ports   ),
    .addr_map_i             ( addr_map_i ),
    .en_default_mst_port_i  ( '0      ),
    .default_mst_port_i     ( '0      )
  );

endmodule
