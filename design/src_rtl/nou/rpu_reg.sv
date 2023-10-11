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

module rpu_reg
(
    input  wire clk,
    input  wire rstn,

    // Input from ibd_decoder
    input logic lreg_vld,
    input logic [`NOU_TID_WIDTH-1:0] trans_id,
    input logic [`NOU_TILE_ID_WIDTH-1:0] local_tile_id,
    input logic [`NOU_TILE_ID_WIDTH-1:0] dst_tile_id,
    input logic [`NOU_PKT_ID_WIDTH-1:0] pkt_id,
    input logic [`NOU_PKT_HEADER_SZ_WIDTH-1:0] pkt_header_size,
    input logic [`NOU_PKT_DATA_SZ_WIDTH-1:0] pkt_data_size,
    input logic [`NOU_FLIT_SZ_WIDTH-1:0] pkt_flit_num,

    // Input from buffer unit
    input logic gnt_buf_vld,
    input logic gnt_buf_status,
    input logic [`NOU_PKT_HEADER_ADDR_WIDTH-1:0] header_buf_addr,
    input logic [`NOU_PKT_DATA_ADDR_WIDTH-1:0] data_buf_addr,

    // Output to or_encode/rcv_pkt_id_encode/rcv_pkt_encode/axi_write_master/buffer unit
    output logic [`NOU_TID_WIDTH-1:0] trans_id_q,
    output logic [`NOU_TILE_ID_WIDTH-1:0] local_tile_id_q,
    output logic [`NOU_TILE_ID_WIDTH-1:0] dst_tile_id_q,
    output logic [`NOU_PKT_ID_WIDTH-1:0] pkt_id_q,
    output logic [`NOU_PKT_HEADER_SZ_WIDTH-1:0] pkt_header_size_q,
    output logic [`NOU_PKT_DATA_SZ_WIDTH-1:0] pkt_data_size_q,
    output logic [`NOU_FLIT_SZ_WIDTH-1:0] pkt_flit_num_q,
    output logic [`NOU_PKT_HEADER_ADDR_WIDTH-1:0] header_buf_addr_q,
    output logic [`NOU_PKT_DATA_ADDR_WIDTH-1:0] data_buf_addr_q
);

    logic gnt_vld;

    assign gnt_vld = gnt_buf_vld & (gnt_buf_status == 0);

    dffr #(`NOU_TID_WIDTH) ff_trans_id (
        .clk(clk),
        .rn(rstn),
        .g(lreg_vld),
        .d(trans_id),
        .q(trans_id_q)
    ); 

    dffr #(`NOU_TILE_ID_WIDTH) ff_local_tile_id (
        .clk(clk),
        .rn(rstn),
        .g(lreg_vld),
        .d(local_tile_id),
        .q(local_tile_id_q)
    ); 

    dffr #(`NOU_TILE_ID_WIDTH) ff_dst_tile_id (
        .clk(clk),
        .rn(rstn),
        .g(lreg_vld),
        .d(dst_tile_id),
        .q(dst_tile_id_q)
    ); 

    dffr #(`NOU_PKT_ID_WIDTH) ff_pkt_id (
        .clk(clk),
        .rn(rstn),
        .g(lreg_vld),
        .d(pkt_id),
        .q(pkt_id_q)
    ); 

    dffr #(`NOU_PKT_HEADER_SZ_WIDTH) ff_pkt_header_size (
        .clk(clk),
        .rn(rstn),
        .g(lreg_vld),
        .d(pkt_header_size),
        .q(pkt_header_size_q)
    ); 

    dffr #(`NOU_PKT_DATA_SZ_WIDTH) ff_pkt_data_size (
        .clk(clk),
        .rn(rstn),
        .g(lreg_vld),
        .d(pkt_data_size),
        .q(pkt_data_size_q)
    ); 

    dffr #(`NOU_PKT_HEADER_ADDR_WIDTH) ff_header_buf_addr (
        .clk(clk),
        .rn(rstn),
        .g(gnt_vld),
        .d(header_buf_addr),
        .q(header_buf_addr_q)
    ); 

    dffr #(`NOU_PKT_DATA_ADDR_WIDTH) ff_data_buf_addr (
        .clk(clk),
        .rn(rstn),
        .g(gnt_vld),
        .d(data_buf_addr),
        .q(data_buf_addr_q)
    ); 

    dffr #(`NOU_FLIT_SZ_WIDTH) ff_pkt_flit_num (
        .clk(clk),
        .rn(rstn),
        .g(lreg_vld),
        .d(pkt_flit_num),
        .q(pkt_flit_num_q)
    ); 

//    logic [] trans_id_r;
//    logic [] local_tile_id_r;
//    logic [] dst_tile_id_r;
//    logic [] pkt_id_r;
//    logic [] pkt_header_size_r;
//    logic [] pkt_data_size_r;
//    logic [] pkt_flit_num_r;
//    logic [] header_buf_addr_r;
//    logic [] data_buf_addr_r;

//    always_ff @(posedge clk or posedge rst)
//    begin
//        if (rst) begin
//            trans_id_out <= 0;
//            local_tile_id_out <= 0;
//            dst_tile_id_out <= 0;
//            pkt_id_out <= 0;
//            pkt_header_size_out <= 0;
//            pkt_data_size_out <= 0;
//            pkt_flit_num_out <= 0;
//            header_buf_addr_out <= 0;
//            data_buf_addr_out <= 0;
//        end
//        else begin
//            if (lreg_vld) begin
//                trans_id_r <= trans_id;
//                local_tile_id_r <= local_tile_id;
//                dst_tile_id_r <= dst_tile_id;
//                pkt_id_r <= pkt_id;
//                pkt_header_size_r <= pkt_header_size;
//                pkt_data_size_r <= pkt_data_size;
//                pkt_flit_num_r <= pkt_flit_num;
//            end
//            if (gnt_buf_vld) begin
//                header_buf_addr_out <= header_buf_addr;
//                data_buf_addr_out <= data_buf_addr;
//            end
//        end
//    end

//    assign trans_id_out = trans_id_r;
//    assign local_tile_id_out = local_tile_id_r;
//    assign dst_tile_id_out = dst_tile_id_r;
//    assign pkt_id_out = pkt_id_r;
//    assign pkt_header_size_out = pkt_header_size_r;
//    assign pkt_data_size_out = pkt_data_size_r;
//    assign pkt_flit_num_out = pkt_flit_num_r;
//    assign header_buf_addr_out = header_buf_addr_r;
//    assign data_buf_addr_out = data_buf_addr_r;

endmodule
