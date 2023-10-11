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

module ori_fifo
#(
    parameter WIDTH = 512,
    parameter DEPTH = 16
)

(
    input logic clk,
    input logic rstn,

    input logic [WIDTH-1:0] wr_data_i,
    input logic wr_en_i,

    output logic [WIDTH-1:0] rd_data_o,
    input logic rd_en_i,

    output logic full_o,
    output logic empty_o
);
    localparam DW = (WIDTH < 1) ? 1 : WIDTH;
    localparam AW = (DEPTH < 1) ? 1 : $clog2(DEPTH);

    logic [AW:0] write_ptr;
    logic [AW:0] read_ptr;

    logic empty_int, full_or_empty;

    assign empty_int = (write_ptr[AW] == read_ptr[AW]);
    assign full_or_empty = (write_ptr[AW-1:0] == read_ptr[AW-1:0]);

    assign full_o = full_or_empty & !empty_int;
    assign empty_o = full_or_empty & empty_int;

    always @(posedge clk or negedge rstn)
    begin
        if (!rstn) begin
            read_ptr <= 0;
            write_ptr <= 0;
        end
        else begin
            if (wr_en_i)
                write_ptr <= write_ptr + 1;

            if (rd_en_i)
                read_ptr <= read_ptr + 1;
        end
    end

    simple_dpram_bypass
    #(
        .MEMDEPTH(DEPTH),
        .DATAWIDTH(DW)
    )
    fifo_ram
    (
        .Clk        	(clk),
        .WriteAddr      (write_ptr[AW-1:0]),
        .ReadAddr       (read_ptr[AW-1:0]),
        .DataIn     	(wr_data_i),
        .WriteEnable    (wr_en_i),
        .ReadEnable     (rd_en_i),
        .DataOut    	(rd_data_o)
    );

endmodule
