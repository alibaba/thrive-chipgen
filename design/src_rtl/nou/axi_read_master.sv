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
module axi_read_master
(
    input wire clk, 
    input wire rstn, 

    input  wire start_rd, 
    output wire rd_done, 
    output wire rd_err, 

    input wire [`NOU_PKT_HEADER_ADDR_WIDTH-1:0] pkt_header_addr,
    input wire [`NOU_PKT_HEADER_SZ_WIDTH-1:0]   pkt_header_sz,
    input wire [`NOU_PKT_DATA_ADDR_WIDTH-1:0]   pkt_data_addr, 
    input wire [`NOU_PKT_DATA_SZ_WIDTH-1:0]     pkt_data_sz,
    
    input  wire                                 pb_full,
    output wire                                 wr_pb_en, 
    output wire [`NOU_NOC_DATA_WIDTH-1:0]       data_flt,

// NOU AXI Read Address Interface
    output wire [`NOU_AXI_ID_WIDTH-1:0]        axi_arid,
    output wire [`NOU_AXI_ADDR_WIDTH-1:0]      axi_araddr,
    output wire [7:0]                          axi_arlen,
    output wire [2:0]                          axi_arsize,
    output wire [1:0]                          axi_arburst,
    output wire [0:0]                          axi_arlock,
    output wire [3:0]                          axi_arcache,
    output wire [2:0]                          axi_arprot,
    output wire [3:0]                          axi_arqos,
    output wire [3:0]                          axi_arregion,
    output wire [`NOU_AXI_USER_WIDTH-1:0]      axi_aruser,
    output wire                                axi_arvld,
    input  wire                                axi_arrdy,

// NOU AXI Read Data interface
    input  wire  [`NOU_AXI_ID_WIDTH-1:0]       axi_rid,
    input  wire  [`NOU_AXI_DATA_WIDTH-1:0]     axi_rdata,
    input  wire  [1:0]                         axi_rrsp,
    input  wire                                axi_rlast,
    input  wire                                axi_ruser, 
    input  wire                                axi_rvld,
    output wire                                axi_rrdy
);

    wire [`NOU_PKT_FLIT_WIDTH-1:0]    header_flits;
    wire [`NOU_PKT_FLIT_WIDTH-1:0]    data_flits; 
    wire [`NOU_PKT_FLIT_WIDTH-1:0]    addr_cnt;
    wire                              sel_pkt_addr;
    wire                              sel_incr_addr;
    wire                              sel_base_addr;
    wire                              addr_vld;
    wire                              plug_addr;
    wire                              rst_addr;
    wire                              plug_data;
    wire                              rst_data;
    wire [`NOU_PKT_FLIT_WIDTH-1:0]    data_cnt;
    wire [`NOU_PKT_HEADER_SZ_WIDTH : 0] ext_header_sz;
    wire [`NOU_AXI_ADDR_WIDTH-1:0]    axi_offset_addr; 

    assign axi_arid    = 4'b0000;  // ID to Inorder read request and response on the same channel
    assign axi_arlen   = 8'b0;     // The burst length is 1. 
    assign axi_arsize  = 3'b110;   // 64 Byte in a transfer
    assign axi_arburst = 2'b01;    // Incr 
    assign axi_arlock  = 1'b0;    // Normal access
    assign axi_arcache = 4'b0010;  // Normal non-cachable on bufferable
    assign axi_arprot  = 3'b000;   //data access, secure and unprivileged access
    assign axi_arqos   = 4'b0000;  // not participating in any QoS 
    assign axi_arregion = 4'b0000; // default value as the option is not implemented
    assign axi_aruser   = 4'b0000; // deault value
    
    assign ext_header_sz = {1'b0, pkt_header_sz};
    assign header_flits  = ((ext_header_sz + 8'h40) >> 6) ; // rounding up
    assign data_flits    = ({6'b0, pkt_data_sz} + 1'b1) << 4;
    
    assign data_flt      =  axi_rdata;     

    axi_read_addr_ctl u_addr_ctl(
        .clk(clk),
        .rstn(rstn),
        
        .start_rd(start_rd),
        .header_flit_num(header_flits),
        .data_flit_num(data_flits), 
        .addr_counter(addr_cnt),

        .axi_arrdy(axi_arrdy), 
        .axi_arvld(axi_arvld), 
        
        .addr_vld(addr_vld),
        .sel_pkt_addr(sel_pkt_addr),
        .sel_incr_addr(sel_incr_addr), 
        .sel_base_addr(sel_base_addr),
        .plug_one(plug_addr), 
        .rst_cnt(rst_addr)
    );
   
    axi_read_data_ctl u_data_ctl(
        .clk(clk),
        .rstn(rstn), 
        
        .header_flit_num(header_flits), 
        .data_flit_num(data_flits), 
        .data_counter(data_cnt), 
        .pb_full(pb_full), 
        .axi_rlast(axi_rlast), 
        .axi_rresp(axi_rrsp), 
        .axi_rvld(axi_rvld), 
        .axi_rrdy(axi_rrdy), 

        .pb_wr_en(wr_pb_en), 
        .rd_done(rd_done), 
        .rd_error(rd_err), 
        .plug_one(plug_data), 
        .rst_cnt(rst_data)
    );

    wire [`NOU_PKT_DATA_ADDR_WIDTH-1:0] pkt_addr = (sel_pkt_addr) ? pkt_data_addr : pkt_header_addr;
    wire [`NOU_AXI_ADDR_WIDTH-1:0]     base_addr = (sel_base_addr) ? {10'b0, pkt_addr} << 10 : axi_offset_addr;
    wire [`NOU_AXI_ADDR_WIDTH-1:0]     araddr_d =  base_addr + ((sel_incr_addr) ? 8'h40 : 8'h0);
    wire                               addr_gate = ~(axi_arvld & ~axi_arrdy); 
    assign axi_araddr = `SRAM_BASE_ADDR + axi_offset_addr;

    dffr #(`NOU_AXI_ADDR_WIDTH) ff_addr(
                                       .clk(clk),
                                       .rn(rstn),
                                       .g(addr_gate),
                                       .d(araddr_d), 
                                       .q(axi_offset_addr)
                                       );

   dffr #(1)                    ff_vld(
                                        .clk(clk), 
                                        .rn(rstn), 
                                        .g(addr_gate),
                                        .d(addr_vld),
                                        .q(axi_arvld)
                                       );

    reg[`NOU_PKT_FLIT_WIDTH-1:0] addr_counter_reg;
    always_ff @(posedge clk or negedge rstn)
    begin
        if (!rstn)
            addr_counter_reg <= `NOU_PKT_FLIT_WIDTH'b0;
        else begin
            if (rst_addr)
                addr_counter_reg <= `NOU_PKT_FLIT_WIDTH'b0;
            else if (plug_addr)
                addr_counter_reg <= addr_counter_reg + 1'b1;
        end
    end
    assign addr_cnt = addr_counter_reg;
   
    wire[`NOU_PKT_FLIT_WIDTH-1:0] data_counter_q;
    wire[`NOU_PKT_FLIT_WIDTH-1:0] data_counter_in = (rst_data)? `NOU_PKT_FLIT_WIDTH'b0 : (plug_data) ? data_counter_q+ 1'b1 : data_counter_q;
    dffr #(`NOU_PKT_FLIT_WIDTH) u_data_cnt(
            .clk(clk),
            .rn(rstn),
            .g(1'b1), 
            .d(data_counter_in), 
            .q(data_counter_q)
             );
    assign data_cnt = data_counter_q;

///////////////////////////////////////////////////////
// assertion
//////////////////////////////////////////////////////
`ifdef RTL_ASSERTION
    sva_never #(4, "rid is not zero") u_assert_never_rid(.test_expr(axi_rid), .reset(~rstn), .clock(clk));
`endif 
endmodule
