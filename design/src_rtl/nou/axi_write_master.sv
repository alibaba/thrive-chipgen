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
module axi_write_master
#(
    parameter USER_DATA_WIDTH = 64
)

(
    input wire clk, 
    input wire rstn, 

    input logic start_aw,
    output logic wr_done, 
    output logic wr_err, 

    input logic [`NOU_PKT_HEADER_ADDR_WIDTH-1:0] pkt_header_addr,
    input logic [`NOU_PKT_HEADER_SZ_WIDTH-1:0]   pkt_header_sz,
    input logic [`NOU_PKT_DATA_ADDR_WIDTH-1:0]   pkt_data_addr, 
    input logic [`NOU_PKT_DATA_SZ_WIDTH-1:0]     pkt_data_sz,
    
    input  logic                                 pb_empty,
    input  logic [`NOU_NOC_DATA_WIDTH-1:0]       data_flit,
    output logic                                 pb_rd_en, 

// NOU AXI Write Address Interface
    output logic [`NOU_AXI_ID_WIDTH-1:0]        axi_awid,
    output logic [`NOU_AXI_ADDR_WIDTH-1:0]      axi_awaddr,
    output logic [7:0]                          axi_awlen,
    output logic [2:0]                          axi_awsize,
    output logic [1:0]                          axi_awburst,
    output logic [0:0]                          axi_awlock,
    output logic [3:0]                          axi_awcache,
    output logic [2:0]                          axi_awprot,
    output logic [3:0]                          axi_awqos,
    output logic [3:0]                          axi_awregion,
    output logic [`NOU_AXI_USER_WIDTH-1:0]      axi_awuser,
    output logic                                axi_awvld,
    input  logic                                axi_awrdy,

// NOU AXI Write Data interface
    output logic [`NOU_AXI_DATA_WIDTH -1:0]     axi_wdata,
    output logic [63:0]                         axi_wstrb,
    output logic                                axi_wlast,
    output logic                                axi_wuser, 
    output logic                                axi_wvld,
    input  logic                                axi_wrdy,
    
// NOU AXI Write Response interface
    input logic [`NOU_AXI_ID_WIDTH-1:0]         axi_bid,
    input logic                                 axi_buser,
    input logic [1:0]                           axi_bresp,
    input logic                                 axi_bvld,
    output logic                                axi_brdy
);

    //parameter USER_DATA_WIDTH = 64;

// Internal signal declaration
    logic sel_pkt_addr;
    logic [`NOU_AXI_ADDR_WIDTH-1:0] pkt_addr_shift_left;
    logic sel_base_addr;
    logic sel_incr_addr;
    logic addr_vld;
    logic [7:0] inc_addr;
    logic [`NOU_AXI_ADDR_WIDTH-1:0] base_addr;
    logic [`NOU_AXI_ADDR_WIDTH-1:0] final_addr;
    logic [`NOU_AXI_ADDR_WIDTH-1:0] offset_addr;
    logic addr_gate;
    logic [`NOU_PKT_DATA_SZ_WIDTH+4-1:0] data_flit_num;
    logic [`NOU_PKT_HEADER_SZ_WIDTH+1-6-1:0] header_flit_num;
    logic [`NOU_PKT_DATA_SZ_WIDTH+1-1:0] pkt_data_full_size;
    logic [`NOU_PKT_DATA_SZ_WIDTH+1-1:0] pkt_data_origin_size;
    logic [`NOU_PKT_HEADER_SZ_WIDTH+1-1:0] pkt_header_full_size;
    logic [`NOU_PKT_HEADER_SZ_WIDTH+1-1:0] pkt_header_origin_size;


// main code
    assign addr_gate    = ~(axi_awvld & ~axi_awrdy);

    // header and data flit num calculation
    assign pkt_data_full_size = {1'b0, pkt_data_sz};
    assign pkt_data_origin_size = pkt_data_full_size + 1'b1;
    assign data_flit_num = {pkt_data_origin_size, {4{1'b0}}};

    assign pkt_header_full_size = {1'b0, pkt_header_sz};
    assign pkt_header_origin_size = pkt_header_full_size + 8'h40;
    assign header_flit_num = pkt_header_origin_size[`NOU_PKT_HEADER_SZ_WIDTH:6];

    // axi_awaddr calculation
    assign pkt_addr_shift_left = sel_pkt_addr ? {{(22-`NOU_PKT_DATA_ADDR_WIDTH){1'b0}}, pkt_data_addr, {10{1'b0}}} : {{(22-`NOU_PKT_HEADER_ADDR_WIDTH){1'b0}}, pkt_header_addr, {10{1'b0}}};
    assign inc_addr = sel_incr_addr ? 8'h40 : 8'h0;
    assign base_addr = sel_base_addr ? pkt_addr_shift_left : offset_addr;
    assign final_addr = inc_addr + base_addr;

    // AXI interface 
    assign axi_awid     = 4'b0001;
    assign axi_awaddr   = offset_addr + `SRAM_BASE_ADDR;
    assign axi_awlen    = 8'b00000000;
    assign axi_awsize   = 3'b110;
    assign axi_awburst  = 2'b01;
    assign axi_awlock   = 1'b0;
    assign axi_awcache  = 4'b0010;
    assign axi_awprot   = 3'b000;
    assign axi_awqos    = 4'b0000;
    assign axi_awregion = 4'b0000;
    assign axi_awuser   = 4'b0000;

    assign axi_wstrb    = 64'hffffffffffffffff;
    assign axi_wlast    = 1'b1;
    assign axi_wuser    = 1'b0;

    axi_aw_master_ctl i_axi_aw_master_ctl (
        .clk(clk),
        .rstn(rstn),

        .data_flit_num(data_flit_num),
        .header_flit_num(header_flit_num),
        .start_aw(start_aw),
        .axi_awrdy(axi_awrdy),
        .axi_awvld(axi_awvld),

        .sel_pkt_addr(sel_pkt_addr),
        .sel_incr_addr(sel_incr_addr),
        .sel_base_addr(sel_base_addr),
        .addr_valid(addr_vld)
    );

    axi_w_master_ctl i_axi_w_master_ctl (
        .data(data_flit),
        .empty(pb_empty),
        .rd_en(pb_rd_en),

        .axi_wdata(axi_wdata),
        .axi_wvld(axi_wvld),
        .axi_wrdy(axi_wrdy)
    );

    axi_b_slave_ctl i_axi_b_slave_ctl (
        .clk(clk),
        .rstn(rstn),

        .wr_done(wr_done),
        .wr_err(wr_err),

        .header_flit_num(header_flit_num),
        .data_flit_num(data_flit_num),

        .axi_bresp(axi_bresp),
        .axi_bvld(axi_bvld),
        .axi_brdy(axi_brdy)
    );

    dffr #(.W(`NOU_AXI_ADDR_WIDTH)) addr_reg (
        .clk(clk),
        .rn(rstn),
        .g(addr_gate),
        .d(final_addr),
        .q(offset_addr)
    );

    dffr addr_vld_reg (
        .clk(clk),
        .rn(rstn),
        .g(addr_gate),
        .d(addr_vld),
        .q(axi_awvld)
    );

endmodule
