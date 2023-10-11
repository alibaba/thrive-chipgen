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

//AXI base parameter
 `define NUMMASTER  12
 `define NUMSLAVE  5
 `define AXI_XBAR_ADDR_WIDTH  32
 `define AXI_XBAR_DATA_WIDTH  1024
 `define ID_WIDTH  4
//AXI feature
 `define MAX_MST_TRANS 10
 `define MAX_SLV_TRANS 6

 //Assign
 `define AXI_MST_IF_ASSIGN(dut_if, tb_if) \
    assign dut_if.aw_id = tb_if.awid; \
    assign dut_if.aw_addr = tb_if.awaddr; \
    assign dut_if.aw_len = tb_if.awlen; \
    assign dut_if.aw_size = tb_if.awsize; \
    assign dut_if.aw_burst = tb_if.awburst; \
    assign dut_if.aw_lock = 'b0; \
    assign dut_if.aw_cache = tb_if.awcache; \
    assign dut_if.aw_prot = tb_if.awprot; \
    assign dut_if.aw_qos = tb_if.awqos; \
    assign dut_if.aw_region = 'b0; \
    assign dut_if.aw_atop = 'b0; \
    assign dut_if.aw_user = 'b0; \
    assign dut_if.aw_valid = tb_if.awvalid; \
    assign tb_if.awready = dut_if.aw_ready; \
    assign dut_if.w_data = tb_if.wdata; \
    assign dut_if.w_strb = tb_if.wstrb; \
    assign dut_if.w_last = tb_if.wlast; \
    assign dut_if.w_user = 'b0; \
    assign dut_if.w_valid = tb_if.wvalid; \
    assign tb_if.wready = dut_if.w_ready; \
    assign tb_if.bid = dut_if.b_id; \
    assign tb_if.bresp = dut_if.b_resp; \
//    assign dut_if.b_user = 'b0; \
    assign tb_if.bvalid = dut_if.b_valid; \
    assign dut_if.b_ready = tb_if.bready; \
    assign dut_if.ar_id = tb_if.arid; \
    assign dut_if.ar_addr = tb_if.araddr; \
    assign dut_if.ar_len = tb_if.arlen; \
    assign dut_if.ar_size = tb_if.arsize; \
    assign dut_if.ar_burst = tb_if.arburst; \
    assign dut_if.ar_lock = 'b0; \
    assign dut_if.ar_cache = tb_if.arcache; \
    assign dut_if.ar_prot = tb_if.arprot; \
    assign dut_if.ar_qos = tb_if.arqos; \
    assign dut_if.ar_region = 'b0; \
    assign dut_if.ar_user = 'b0; \
    assign dut_if.ar_valid = tb_if.arvalid; \
    assign tb_if.arready = dut_if.ar_ready; \
    assign tb_if.rid = dut_if.r_id; \
    assign tb_if.rdata = dut_if.r_data; \
    assign tb_if.rresp = dut_if.r_resp; \
    assign tb_if.rlast = dut_if.r_last; \
//    assign tb_if.ruser = 'b0; \
    assign tb_if.rvalid = dut_if.r_valid; \
    assign dut_if.r_ready = tb_if.rready; 

 `define AXI_SLV_IF_ASSIGN(dut_if, tb_if) \
    assign tb_if.awid = dut_if.aw_id; \
    assign tb_if.awaddr = dut_if.aw_addr; \
    assign tb_if.awlen = dut_if.aw_len; \
    assign tb_if.awsize = dut_if.aw_size; \
    assign tb_if.awburst = dut_if.aw_burst; \
//    assign tb_if.awlock = dut_if.aw_lock; \
    assign tb_if.awcache = dut_if.aw_cache; \
    assign tb_if.awprot = dut_if.aw_prot; \
    assign tb_if.awqos = dut_if.aw_qos; \
//    assign tb_if.aw_region = 'b0; \
//    assign tb_if.aw_atop = 'b0; \
//    assign tb_if.awuser = dut_if.aw_user; \
    assign tb_if.awvalid = dut_if.aw_valid; \
    assign dut_if.aw_ready = tb_if.awready; \
    assign tb_if.wdata = dut_if.w_data; \
    assign tb_if.wstrb = dut_if.w_strb; \
    assign tb_if.wlast = dut_if.w_last; \
//    assign tb_if.wuser = dut_if.w_user; \
    assign tb_if.wvalid = dut_if.w_valid; \
    assign dut_if.w_ready = tb_if.wready; \
    assign dut_if.b_id = tb_if.bid; \
    assign dut_if.b_resp = tb_if.bresp; \
    assign dut_if.b_user = 'b0; \
    assign dut_if.b_valid = tb_if.bvalid; \
    assign tb_if.bready = dut_if.b_ready; \
    assign tb_if.arid = dut_if.ar_id; \
    assign tb_if.araddr = dut_if.ar_addr; \
    assign tb_if.arlen = dut_if.ar_len; \
    assign tb_if.arsize = dut_if.ar_size; \
    assign tb_if.arburst = dut_if.ar_burst; \
//    assign tb_if.arlock = dut_if.ar_lock; \
    assign tb_if.arcache = dut_if.ar_cache; \
    assign tb_if.arprot = dut_if.ar_prot; \
    assign tb_if.arqos = dut_if.ar_qos; \
//    assign tb_if.ar_region = 'b0; \
//    assign tb_if.aruser = dut_if.ar_user; \
    assign tb_if.arvalid = dut_if.ar_valid; \
    assign dut_if.ar_ready = tb_if.arready; \
    assign dut_if.r_id = tb_if.rid; \
    assign dut_if.r_data = tb_if.rdata; \
    assign dut_if.r_resp = tb_if.rresp; \
    assign dut_if.r_last = tb_if.rlast; \
    assign dut_if.r_user = 'b0; \
    assign dut_if.r_valid = tb_if.rvalid; \
    assign tb_if.rready = dut_if.r_ready; 

 `define AXI_MST_ASSIGN(xbar_if, port) \
    assign xbar_if.aw_id = port``_AXI_awid; \
    assign xbar_if.aw_addr = port``_AXI_awaddr; \
    assign xbar_if.aw_len = port``_AXI_awlen; \
    assign xbar_if.aw_size = port``_AXI_awsize; \
    assign xbar_if.aw_burst = port``_AXI_awburst; \
    assign xbar_if.aw_lock = 'b0; \
    assign xbar_if.aw_cache = port``_AXI_awcache; \
    assign xbar_if.aw_prot = port``_AXI_awprot; \
    assign xbar_if.aw_qos = port``_AXI_awqos; \
    assign xbar_if.aw_region = 'b0; \
    assign xbar_if.aw_atop = 'b0; \
    assign xbar_if.aw_user = 'b0; \
    assign xbar_if.aw_valid = port``_AXI_awvalid; \
    assign port``_AXI_awready = xbar_if.aw_ready; \
    assign xbar_if.w_data = port``_AXI_wdata; \
    assign xbar_if.w_strb = port``_AXI_wstrb; \
    assign xbar_if.w_last = port``_AXI_wlast; \
    assign xbar_if.w_user = 'b0; \
    assign xbar_if.w_valid = port``_AXI_wvalid; \
    assign port``_AXI_wready = xbar_if.w_ready; \
    assign port``_AXI_bid = xbar_if.b_id; \
    assign port``_AXI_bresp = xbar_if.b_resp; \
//    assign xbar_if.b_user = 'b0; \
    assign port``_AXI_bvalid = xbar_if.b_valid; \
    assign xbar_if.b_ready = port``_AXI_bready; \
    assign xbar_if.ar_id = port``_AXI_arid; \
    assign xbar_if.ar_addr = port``_AXI_araddr; \
    assign xbar_if.ar_len = port``_AXI_arlen; \
    assign xbar_if.ar_size = port``_AXI_arsize; \
    assign xbar_if.ar_burst = port``_AXI_arburst; \
    assign xbar_if.ar_lock = 'b0; \
    assign xbar_if.ar_cache = port``_AXI_arcache; \
    assign xbar_if.ar_prot = port``_AXI_arprot; \
    assign xbar_if.ar_qos = port``_AXI_arqos; \
    assign xbar_if.ar_region = 'b0; \
    assign xbar_if.ar_user = 'b0; \
    assign xbar_if.ar_valid = port``_AXI_arvalid; \
    assign port``_AXI_arready = xbar_if.ar_ready; \
    assign port``_AXI_rid = xbar_if.r_id; \
    assign port``_AXI_rdata = xbar_if.r_data; \
    assign port``_AXI_rresp = xbar_if.r_resp; \
    assign port``_AXI_rlast = xbar_if.r_last; \
//    assign port``_AXI_ruser = 'b0; \
    assign port``_AXI_rvalid = xbar_if.r_valid; \
    assign xbar_if.r_ready = port``_AXI_rready; 

 `define AXI_SLV_ASSIGN(xbar_if, port) \
    assign port``_AXI_awid = xbar_if.aw_id; \
    assign port``_AXI_awaddr = xbar_if.aw_addr; \
    assign port``_AXI_awlen = xbar_if.aw_len; \
    assign port``_AXI_awsize = xbar_if.aw_size; \
    assign port``_AXI_awburst = xbar_if.aw_burst; \
//    assign port``_AXI_awlock = xbar_if.aw_lock; \
    assign port``_AXI_awcache = xbar_if.aw_cache; \
    assign port``_AXI_awprot = xbar_if.aw_prot; \
    assign port``_AXI_awqos = xbar_if.aw_qos; \
//    assign port``_AXI_aw_region = 'b0; \
//    assign port``_AXI_aw_atop = 'b0; \
//    assign port``_AXI_awuser = xbar_if.aw_user; \
    assign port``_AXI_awvalid = xbar_if.aw_valid; \
    assign xbar_if.aw_ready = port``_AXI_awready; \
    assign port``_AXI_wdata = xbar_if.w_data; \
    assign port``_AXI_wstrb = xbar_if.w_strb; \
    assign port``_AXI_wlast = xbar_if.w_last; \
//    assign port``_AXI_wuser = xbar_if.w_user; \
    assign port``_AXI_wvalid = xbar_if.w_valid; \
    assign xbar_if.w_ready = port``_AXI_wready; \
    assign xbar_if.b_id = port``_AXI_bid; \
    assign xbar_if.b_resp = port``_AXI_bresp; \
    assign xbar_if.b_user = 'b0; \
    assign xbar_if.b_valid = port``_AXI_bvalid; \
    assign port``_AXI_bready = xbar_if.b_ready; \
    assign port``_AXI_arid = xbar_if.ar_id; \
    assign port``_AXI_araddr = xbar_if.ar_addr; \
    assign port``_AXI_arlen = xbar_if.ar_len; \
    assign port``_AXI_arsize = xbar_if.ar_size; \
    assign port``_AXI_arburst = xbar_if.ar_burst; \
//    assign port``_AXI_arlock = xbar_if.ar_lock; \
    assign port``_AXI_arcache = xbar_if.ar_cache; \
    assign port``_AXI_arprot = xbar_if.ar_prot; \
    assign port``_AXI_arqos = xbar_if.ar_qos; \
//    assign port``_AXI_ar_region = 'b0; \
//    assign port``_AXI_aruser = xbar_if.ar_user; \
    assign port``_AXI_arvalid = xbar_if.ar_valid; \
    assign xbar_if.ar_ready = port``_AXI_arready; \
    assign xbar_if.r_id = port``_AXI_rid; \
    assign xbar_if.r_data = port``_AXI_rdata; \
    assign xbar_if.r_resp = port``_AXI_rresp; \
    assign xbar_if.r_last = port``_AXI_rlast; \
    assign xbar_if.r_user = 'b0; \
    assign xbar_if.r_valid = port``_AXI_rvalid; \
    assign port``_AXI_rready = xbar_if.r_ready; 
