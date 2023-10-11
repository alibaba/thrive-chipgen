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

module spu_reg 
(
    input  wire clk,
    input  wire rstn,

// SPIDR Interface
    input  wire                                   spidr_vld,
    input  wire [`NOU_SID_WIDTH-1:0]              spidr_sid,
    input  wire [`NOU_PKT_ID_WIDTH-1:0]           spidr_pkt_id,
    input  wire [`NOU_TILE_ID_WIDTH-1:0]          spidr_src_tile_id,
    input  wire [`NOU_TILE_ID_WIDTH-1:0]          spidr_dst_tile_id,

// SPRR Interface
    input  wire                                   sprr_vld,
    input  wire [`NOU_SID_WIDTH-1:0]              sprr_sid,
    input  wire [`NOU_PKT_HEADER_ADDR_WIDTH-1:0]  sprr_pkt_header_addr,
    input  wire [`NOU_PKT_HEADER_SZ_WIDTH-1:0]    sprr_pkt_header_sz,
    input  wire [`NOU_PKT_DATA_ADDR_WIDTH-1:0]    sprr_pkt_data_addr,
    input  wire [`NOU_PKT_DATA_SZ_WIDTH-1:0]      sprr_pkt_data_sz,

    output wire [`NOU_SID_WIDTH-1:0]              sid_q,
    output wire [`NOU_PKT_ID_WIDTH-1:0]           pkt_id_q,
    output wire [`NOU_TILE_ID_WIDTH-1:0]          src_tile_id_q, 
    output wire [`NOU_TILE_ID_WIDTH-1:0]          dst_tile_id_q,

    output wire [`NOU_PKT_HEADER_ADDR_WIDTH-1:0]  pkt_header_addr_q,
    output wire [`NOU_PKT_HEADER_SZ_WIDTH-1:0]    pkt_header_sz_q,
    output wire [`NOU_PKT_DATA_ADDR_WIDTH-1:0]    pkt_data_addr_q,
    output wire [`NOU_PKT_DATA_SZ_WIDTH-1:0]      pkt_data_sz_q,
    output wire  [`NOU_TID_WIDTH-1:0]              trans_id_q

);

/********** SIGNAL DECLARE **************/


    dffr #(`NOU_SID_WIDTH) ff_sid(
                           .clk(clk), 
                           .rn(rstn),
                           .g (spidr_vld),
                           .d (spidr_sid[`NOU_SID_WIDTH-1:0]),
                           .q (sid_q[`NOU_SID_WIDTH-1:0])
                           );
    
    dffr #(`NOU_PKT_ID_WIDTH) ff_pkt_id (
                                        .clk(clk),
                                        .rn(rstn),
                                        .g(spidr_vld),
                                        .d(spidr_pkt_id[`NOU_PKT_ID_WIDTH-1:0]),
                                        .q(pkt_id_q[`NOU_PKT_ID_WIDTH-1:0])
                                        );

    dffr #(`NOU_TILE_ID_WIDTH) ff_src_tile_id (
                                        .clk(clk),
                                        .rn(rstn),
                                        .g(spidr_vld),
                                        .d(spidr_src_tile_id[`NOU_TILE_ID_WIDTH-1:0]),
                                        .q(src_tile_id_q[`NOU_TILE_ID_WIDTH-1:0])
                                        );

    dffr #(`NOU_TILE_ID_WIDTH) ff_dst_tile_id (
                                        .clk(clk),
                                        .rn(rstn),
                                        .g(spidr_vld),
                                        .d(spidr_dst_tile_id[`NOU_TILE_ID_WIDTH-1:0]),
                                        .q(dst_tile_id_q[`NOU_TILE_ID_WIDTH-1:0])
                                        );


    dffr #(`NOU_PKT_HEADER_ADDR_WIDTH) ff_pkt_header_addr (
                                        .clk(clk),
                                        .rn(rstn),
                                        .g(sprr_vld),
                                        .d(sprr_pkt_header_addr[`NOU_PKT_HEADER_ADDR_WIDTH-1:0]),
                                        .q(pkt_header_addr_q[`NOU_PKT_HEADER_ADDR_WIDTH-1:0])
                                        );

    dffr #(`NOU_PKT_HEADER_SZ_WIDTH) ff_pkt_header_sz (
                                        .clk(clk),
                                        .rn(rstn),
                                        .g(sprr_vld),
                                        .d(sprr_pkt_header_sz[`NOU_PKT_HEADER_SZ_WIDTH-1:0]),
                                        .q(pkt_header_sz_q[`NOU_PKT_HEADER_SZ_WIDTH-1:0])
                                        );


    dffr #(`NOU_PKT_DATA_ADDR_WIDTH) ff_pkt_data_addr (
                                        .clk(clk),
                                        .rn(rstn),
                                        .g(sprr_vld),
                                        .d(sprr_pkt_data_addr[`NOU_PKT_DATA_ADDR_WIDTH-1:0]),
                                        .q(pkt_data_addr_q[`NOU_PKT_DATA_ADDR_WIDTH-1:0])
                                        );

    dffr #(`NOU_PKT_DATA_SZ_WIDTH) ff_pkt_data_sz (
                                        .clk(clk),
                                        .rn(rstn),
                                        .g(sprr_vld),
                                        .d(sprr_pkt_data_sz[`NOU_PKT_DATA_SZ_WIDTH-1:0]),
                                        .q(pkt_data_sz_q[`NOU_PKT_DATA_SZ_WIDTH-1:0])
                                        );

    reg [`NOU_TID_WIDTH-1:0] trans_id_reg;
    
    assign trans_id_q = trans_id_reg;
    always_ff @(posedge clk or negedge rstn)
    begin
        if (!rstn)
            trans_id_reg[`NOU_TID_WIDTH-1:0 ] <= {`NOU_TID_WIDTH{1'b0}};
        else if (sprr_vld == 1'b1)
             trans_id_reg[`NOU_TID_WIDTH-1:0 ] <=  trans_id_reg[`NOU_TID_WIDTH-1:0 ] + 1;
    end

///////////////////////////////////////////////////////
// assertion
//////////////////////////////////////////////////////
`ifdef RTL_ASSERTION
/*
    reg sid_mismatch;
   
    always_ff @(posedge clk or negedge rstn)
    begin
        if (!rstn)
            sid_mismatch <= 1'b0;
        else if (sprr_vld == 1'b1 && sprr_sid != sid_q)
            sid_mismatch <= 1'b1;
    end

    sva_always #(1, "packet sid not equal") u_assert_always_sid(.test_expr(~sid_mismatch), .reset(~rstn), .clock(clk));
*/
`endif
endmodule

