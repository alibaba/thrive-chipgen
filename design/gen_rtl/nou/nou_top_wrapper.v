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

`include "nou_define.h"

// &ModuleBeg; @18
module nou_top_wrapper (
	nou_clk,
	nou_rstn,
	rv_xocc_cmd_buffer,
	rv_xocc_cmd_empty,
	rv_xocc_rsp_full,
	rv_xocc_cmd_rd_en,
	rv_xocc_rsp_wr_en,
	rv_xocc_rsp_buffer,
	nou_noc_data_valid,
	noc_nou_data_ready,
	nou_noc_data_tid,
	nou_noc_data_type,
	nou_noc_data,
	nou_noc_rsp_valid,
	noc_nou_rsp_ready,
	nou_noc_rsp_tid,
	nou_noc_rsp_type,
	nou_noc_rsp,
	noc_nou_data_valid,
	nou_noc_data_ready,
	noc_nou_data_tid,
	noc_nou_data_type,
	noc_nou_data,
	noc_nou_rsp_valid,
	nou_noc_rsp_ready,
	noc_nou_rsp_tid,
	noc_nou_rsp_type,
	noc_nou_rsp,
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

// &Ports; @19
input   [0:0]                             nou_clk;          
input   [0:0]                             nou_rstn;         
input   [`NOU_XOCC_CMD_WIDTH-1:0]         rv_xocc_cmd_buffer;
input   [0:0]                             rv_xocc_cmd_empty;
input   [0:0]                             rv_xocc_rsp_full; 
output  [0:0]                             rv_xocc_cmd_rd_en;
output  [0:0]                             rv_xocc_rsp_wr_en;
output  [`NOU_XOCC_CMD_WIDTH-1:0]         rv_xocc_rsp_buffer;
output  [0:0]                             nou_noc_data_valid;
input   [0:0]                             noc_nou_data_ready;
output  [`NOU_TID_WIDTH-1:0]              nou_noc_data_tid; 
output  [`NOU_TYPE_WIDTH-1:0]             nou_noc_data_type;
output  [`NOU_NOC_DATA_WIDTH-1:0]         nou_noc_data;     
output  [0:0]                             nou_noc_rsp_valid;
input   [0:0]                             noc_nou_rsp_ready;
output  [`NOU_TID_WIDTH-1:0]              nou_noc_rsp_tid;  
output  [`NOU_TYPE_WIDTH-1:0]             nou_noc_rsp_type; 
output  [`NOU_NOC_RSP_WIDTH-1:0]          nou_noc_rsp;      
input   [0:0]                             noc_nou_data_valid;
output  [0:0]                             nou_noc_data_ready;
input   [`NOU_TID_WIDTH-1:0]              noc_nou_data_tid; 
input   [`NOU_TYPE_WIDTH-1:0]             noc_nou_data_type;
input   [`NOU_NOC_DATA_WIDTH-1:0]         noc_nou_data;     
input   [0:0]                             noc_nou_rsp_valid;
output  [0:0]                             nou_noc_rsp_ready;
input   [`NOU_TID_WIDTH-1:0]              noc_nou_rsp_tid;  
input   [1:0]                             noc_nou_rsp_type; 
input   [`NOU_NOC_RSP_WIDTH-1:0]          noc_nou_rsp;      
output  [`NOU_AXI_ID_WIDTH-1:0]           axi_awid;         
output  [`NOU_AXI_ADDR_WIDTH-1:0]         axi_awaddr;       
output  [7:0]                             axi_awlen;        
output  [2:0]                             axi_awsize;       
output  [1:0]                             axi_awburst;      
output  [0:0]                             axi_awlock;       
output  [3:0]                             axi_awcache;      
output  [2:0]                             axi_awprot;       
output  [3:0]                             axi_awqos;        
output  [0:0]                             axi_awvalid;      
input   [0:0]                             axi_awready;      
output  [`NOU_AXI_DATA_WIDTH-1:0]         axi_wdata;        
output  [(`NOU_AXI_DATA_WIDTH/8)-1:0]     axi_wstrb;        
output  [0:0]                             axi_wlast;        
output  [0:0]                             axi_wvalid;       
input   [0:0]                             axi_wready;       
input   [`NOU_AXI_ID_WIDTH-1:0]           axi_bid;          
input   [1:0]                             axi_bresp;        
input   [0:0]                             axi_bvalid;       
output  [0:0]                             axi_bready;       
output  [`NOU_AXI_ID_WIDTH-1:0]           axi_arid;         
output  [`NOU_AXI_ADDR_WIDTH-1:0]         axi_araddr;       
output  [7:0]                             axi_arlen;        
output  [2:0]                             axi_arsize;       
output  [1:0]                             axi_arburst;      
output  [0:0]                             axi_arlock;       
output  [3:0]                             axi_arcache;      
output  [2:0]                             axi_arprot;       
output  [3:0]                             axi_arqos;        
output  [0:0]                             axi_arvalid;      
input   [0:0]                             axi_arready;      
input   [`NOU_AXI_ID_WIDTH-1:0]           axi_rid;          
input   [`NOU_AXI_DATA_WIDTH-1:0]         axi_rdata;        
input   [1:0]                             axi_rresp;        
input   [0:0]                             axi_rlast;        
input   [0:0]                             axi_rvalid;       
output  [0:0]                             axi_rready;       

wire    [3:0]    axi_awregion;
wire    [3:0]    axi_arregion;

// &Instance("nou_wrapper"); @20
nou_wrapper x_nou_wrapper (
	.nou_clk           (nou_clk           ),
	.nou_rstn          (nou_rstn          ),
	.dsa_xocc_cmd_in   (rv_xocc_cmd_buffer),
	.dsa_cmd_fifo_empty(rv_xocc_cmd_empty ),
	.dsa_rsp_fifo_full (rv_xocc_rsp_full  ),
	.dsa_cmd_fifo_rd_en(rv_xocc_cmd_rd_en ),
	.dsa_rsp_fifo_wr_en(rv_xocc_rsp_wr_en ),
	.dsa_xocc_cmd_out  (rv_xocc_rsp_buffer),
	.nou_noc_data_vld  (nou_noc_data_valid),
	.noc_nou_data_rdy  (noc_nou_data_ready),
	.nou_noc_data_tid  (nou_noc_data_tid  ),
	.nou_noc_data_type (nou_noc_data_type ),
	.nou_noc_data      (nou_noc_data      ),
	.nou_noc_rsp_vld   (nou_noc_rsp_valid ),
	.noc_nou_rsp_rdy   (noc_nou_rsp_ready ),
	.nou_noc_rsp_tid   (nou_noc_rsp_tid   ),
	.nou_noc_rsp_type  (nou_noc_rsp_type  ),
	.nou_noc_rsp       (nou_noc_rsp       ),
	.noc_nou_data_vld  (noc_nou_data_valid),
	.nou_noc_data_rdy  (nou_noc_data_ready),
	.noc_nou_data_tid  (noc_nou_data_tid  ),
	.noc_nou_data_type (noc_nou_data_type ),
	.noc_nou_data      (noc_nou_data      ),
	.noc_nou_rsp_vld   (noc_nou_rsp_valid ),
	.nou_noc_rsp_rdy   (nou_noc_rsp_ready ),
	.noc_nou_rsp_tid   (noc_nou_rsp_tid   ),
	.noc_nou_rsp_type  (noc_nou_rsp_type  ),
	.noc_nou_rsp       (noc_nou_rsp       ),
	.m_axi_awid        (axi_awid          ),
	.m_axi_awaddr      (axi_awaddr        ),
	.m_axi_awlen       (axi_awlen         ),
	.m_axi_awsize      (axi_awsize        ),
	.m_axi_awburst     (axi_awburst       ),
	.m_axi_awlock      (axi_awlock        ),
	.m_axi_awcache     (axi_awcache       ),
	.m_axi_awprot      (axi_awprot        ),
	.m_axi_awqos       (axi_awqos         ),
	.m_axi_awregion    (axi_awregion      ),
	.m_axi_awvalid     (axi_awvalid       ),
	.m_axi_awready     (axi_awready       ),
	.m_axi_wdata       (axi_wdata         ),
	.m_axi_wstrb       (axi_wstrb         ),
	.m_axi_wlast       (axi_wlast         ),
	.m_axi_wvalid      (axi_wvalid        ),
	.m_axi_wready      (axi_wready        ),
	.m_axi_bid         (axi_bid           ),
	.m_axi_bresp       (axi_bresp         ),
	.m_axi_bvalid      (axi_bvalid        ),
	.m_axi_bready      (axi_bready        ),
	.m_axi_arid        (axi_arid          ),
	.m_axi_araddr      (axi_araddr        ),
	.m_axi_arlen       (axi_arlen         ),
	.m_axi_arsize      (axi_arsize        ),
	.m_axi_arburst     (axi_arburst       ),
	.m_axi_arlock      (axi_arlock        ),
	.m_axi_arcache     (axi_arcache       ),
	.m_axi_arprot      (axi_arprot        ),
	.m_axi_arqos       (axi_arqos         ),
	.m_axi_arregion    (axi_arregion      ),
	.m_axi_arvalid     (axi_arvalid       ),
	.m_axi_arready     (axi_arready       ),
	.m_axi_rid         (axi_rid           ),
	.m_axi_rdata       (axi_rdata         ),
	.m_axi_rresp       (axi_rresp         ),
	.m_axi_rlast       (axi_rlast         ),
	.m_axi_rvalid      (axi_rvalid        ),
	.m_axi_rready      (axi_rready        )
);
// @21 &ConnRule(r'm_axi', r'axi');
// @22 &ConnRule(r'dsa_(\w+)_fifo', r'rv_xocc_\1');
// @23 &ConnRule(r'rdy', r'ready');
// @24 &ConnRule(r'vld', r'valid');
// @25 &Connect(
// @26     .dsa_xocc_cmd_in(rv_xocc_cmd_buffer),
// @27     .dsa_xocc_cmd_out(rv_xocc_rsp_buffer),
// @28     .nou_clk(nou_clk),
// @29     .nou_rstn(nou_rstn),
// @30 );
// @31 &Force("nonport", "axi_awregion")
// @32 &Force("nonport", "axi_arregion")


endmodule
