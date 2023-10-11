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

module fwft_fifo
#(
    parameter WIDTH = 512,
    parameter DEPTH = 4 
)

(
    input logic clk,
    input logic rstn,

    input logic rd_en,
    input logic wr_en,
    input logic [WIDTH-1:0] din,
    
    output logic full,
    output logic empty,
    output logic [WIDTH-1:0] dout
);

    logic [WIDTH-1:0] fifo_dout;
    logic fifo_empty;
    logic fifo_rd_en;

    ori_fifo #(.WIDTH(WIDTH), .DEPTH(DEPTH)) i_fifo (
        .clk (clk),
        .rstn (rstn),
        .rd_en_i (fifo_rd_en),
        .rd_data_o (fifo_dout),
        .empty_o (fifo_empty),
        .wr_en_i (wr_en),
        .wr_data_i (din),
        .full_o (full)
    );

    fwft_adapter #(.WIDTH(WIDTH)) i_fwft_adapter (
        .clk (clk),
        .rstn (rstn),
        .rd_en_i (rd_en),
        .fifo_empty_i (fifo_empty),
        .fifo_rd_en_o (fifo_rd_en),
        .fifo_dout_i (fifo_dout),
        .dout_o (dout),
        .empty_o (empty)
    );

endmodule
