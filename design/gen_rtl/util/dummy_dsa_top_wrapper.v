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
module dummy_dsa_top_wrapper (
	rv_xocc_cmd_buffer,
	rv_xocc_cmd_empty,
	rv_xocc_rsp_full,
	rv_xocc_cmd_rd_en,
	rv_xocc_rsp_wr_en,
	rv_xocc_rsp_buffer,
	axi_aclk,
	axi_aresetn,
	axi_awid,
	axi_awaddr,
	axi_awlen,
	axi_awsize,
	axi_awburst,
	axi_awlock,
	axi_awcache,
	axi_awprot,
	axi_awqos,
	axi_awvalid,
	axi_awready,
	axi_wdata,
	axi_wstrb,
	axi_wlast,
	axi_wvalid,
	axi_wready,
	axi_bid,
	axi_bresp,
	axi_bvalid,
	axi_bready,
	axi_arid,
	axi_araddr,
	axi_arlen,
	axi_arsize,
	axi_arburst,
	axi_arlock,
	axi_arcache,
	axi_arprot,
	axi_arqos,
	axi_arvalid,
	axi_arready,
	axi_rid,
	axi_rdata,
	axi_rresp,
	axi_rlast,
	axi_rvalid,
	axi_rready
);


// &Ports; @18
input   [96-1:0]                           rv_xocc_cmd_buffer;
input   [0:0]                              rv_xocc_cmd_empty;
input   [0:0]                              rv_xocc_rsp_full; 
output  [0:0]                              rv_xocc_cmd_rd_en;
output  [0:0]                              rv_xocc_rsp_wr_en;
output  [32-1:0]                           rv_xocc_rsp_buffer;
input   [0:0]                              axi_aclk;         
input   [0:0]                              axi_aresetn;      
output  [`AXI_MASTER_ID_WIDTH-1:0]         axi_awid;         
output  [32-1:0]                           axi_awaddr;       
output  [7:0]                              axi_awlen;        
output  [2:0]                              axi_awsize;       
output  [1:0]                              axi_awburst;      
output  [0:0]                              axi_awlock;       
output  [3:0]                              axi_awcache;      
output  [2:0]                              axi_awprot;       
output  [3:0]                              axi_awqos;        
output  [0:0]                              axi_awvalid;      
input   [0:0]                              axi_awready;      
output  [1024-1:0]                         axi_wdata;        
output  [1024/8-1:0]                       axi_wstrb;        
output  [0:0]                              axi_wlast;        
output  [0:0]                              axi_wvalid;       
input   [0:0]                              axi_wready;       
input   [`AXI_MASTER_ID_WIDTH-1:0]         axi_bid;          
input   [1:0]                              axi_bresp;        
input   [0:0]                              axi_bvalid;       
output  [0:0]                              axi_bready;       
output  [`AXI_MASTER_ID_WIDTH-1:0]         axi_arid;         
output  [32-1:0]                           axi_araddr;       
output  [7:0]                              axi_arlen;        
output  [2:0]                              axi_arsize;       
output  [1:0]                              axi_arburst;      
output  [0:0]                              axi_arlock;       
output  [3:0]                              axi_arcache;      
output  [2:0]                              axi_arprot;       
output  [3:0]                              axi_arqos;        
output  [0:0]                              axi_arvalid;      
input   [0:0]                              axi_arready;      
input   [`AXI_MASTER_ID_WIDTH-1:0]         axi_rid;          
input   [1024-1:0]                         axi_rdata;        
input   [1:0]                              axi_rresp;        
input   [0:0]                              axi_rlast;        
input   [0:0]                              axi_rvalid;       
output  [0:0]                              axi_rready;       



// &Instance("dummy_dsa_top"); @20
dummy_dsa_top #(
	.AXI_ID_WIDTH(`AXI_MASTER_ID_WIDTH),
	.AXI_DATA_WIDTH(1024),
	.AXI_ADDR_WIDTH(32)
) x_dummy_dsa_top (
	.dsa_xocc_cmd_in   (rv_xocc_cmd_buffer),
	.dsa_cmd_fifo_empty(rv_xocc_cmd_empty ),
	.dsa_rsp_fifo_full (rv_xocc_rsp_full  ),
	.dsa_cmd_fifo_rd_en(rv_xocc_cmd_rd_en ),
	.dsa_rsp_fifo_wr_en(rv_xocc_rsp_wr_en ),
	.dsa_xocc_cmd_out  (rv_xocc_rsp_buffer),
	.axi_aclk          (axi_aclk          ),
	.axi_aresetn       (axi_aresetn       ),
	.axi_awid          (axi_awid          ),
	.axi_awaddr        (axi_awaddr        ),
	.axi_awlen         (axi_awlen         ),
	.axi_awsize        (axi_awsize        ),
	.axi_awburst       (axi_awburst       ),
	.axi_awlock        (axi_awlock        ),
	.axi_awcache       (axi_awcache       ),
	.axi_awprot        (axi_awprot        ),
	.axi_awqos         (axi_awqos         ),
	.axi_awvalid       (axi_awvalid       ),
	.axi_awready       (axi_awready       ),
	.axi_wdata         (axi_wdata         ),
	.axi_wstrb         (axi_wstrb         ),
	.axi_wlast         (axi_wlast         ),
	.axi_wvalid        (axi_wvalid        ),
	.axi_wready        (axi_wready        ),
	.axi_bid           (axi_bid           ),
	.axi_bresp         (axi_bresp         ),
	.axi_bvalid        (axi_bvalid        ),
	.axi_bready        (axi_bready        ),
	.axi_arid          (axi_arid          ),
	.axi_araddr        (axi_araddr        ),
	.axi_arlen         (axi_arlen         ),
	.axi_arsize        (axi_arsize        ),
	.axi_arburst       (axi_arburst       ),
	.axi_arlock        (axi_arlock        ),
	.axi_arcache       (axi_arcache       ),
	.axi_arprot        (axi_arprot        ),
	.axi_arqos         (axi_arqos         ),
	.axi_arvalid       (axi_arvalid       ),
	.axi_arready       (axi_arready       ),
	.axi_rid           (axi_rid           ),
	.axi_rdata         (axi_rdata         ),
	.axi_rresp         (axi_rresp         ),
	.axi_rlast         (axi_rlast         ),
	.axi_rvalid        (axi_rvalid        ),
	.axi_rready        (axi_rready        )
);
// @21 &ConnRule(r'dsa_(\w+)_fifo', r'rv_xocc_\1');
// @22 &Connect(
// @23     .dsa_xocc_cmd_in(rv_xocc_cmd_buffer),
// @24     .dsa_xocc_cmd_out(rv_xocc_rsp_buffer),
// @25 );
// @26 &Param(
// @27     .AXI_ID_WIDTH(`AXI_MASTER_ID_WIDTH),
// @28     .AXI_DATA_WIDTH(1024),
// @29     .AXI_ADDR_WIDTH(32)
// @30 );


endmodule
