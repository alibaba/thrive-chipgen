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

module fwft_adapter
#(
    parameter WIDTH = 512
)

(
    input logic clk,
    input logic rstn,
    input logic rd_en_i,
    input logic fifo_empty_i,
    output logic fifo_rd_en_o,
    input logic [WIDTH-1:0] fifo_dout_i,
    output logic [WIDTH-1:0] dout_o,
    output logic empty_o
);
    logic fifo_valid;
    logic middle_valid;
    logic dout_valid;
    logic [WIDTH-1:0] middle_dout;

    logic will_update_middle;
    logic will_update_dout;

    assign will_update_middle = fifo_valid && (middle_valid == will_update_dout);
    assign will_update_dout = (middle_valid || fifo_valid) && (rd_en_i || !dout_valid);
    assign fifo_rd_en_o = (!fifo_empty_i) && !(middle_valid && dout_valid && fifo_valid);
    assign empty_o = !dout_valid;

    always @(posedge clk or negedge rstn)
    begin
        if (!rstn) begin
            fifo_valid <= 0;
            middle_valid <= 0;
            dout_valid <= 0;
            dout_o <= 0;
            middle_dout <= 0;
        end
        else begin
            if (will_update_middle)
                middle_dout <= fifo_dout_i;
            
            if (will_update_dout)
                dout_o <= middle_valid ? middle_dout : fifo_dout_i;
            
            if (fifo_rd_en_o)
                fifo_valid <= 1;
            else if (will_update_middle || will_update_dout)
                fifo_valid <= 0;

            if (will_update_middle)
                middle_valid <= 1;
            else if (will_update_dout)
                middle_valid <= 0;
            
            if (will_update_dout)
                dout_valid <= 1;
            else if (rd_en_i)
                dout_valid <= 0;
        end
    end
endmodule
