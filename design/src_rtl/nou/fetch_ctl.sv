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

module fetch_ctl
(
    input wire      clk,
    input wire      rstn,

    input wire      fifo_empty_f0,
    output wire     fifo_rd_en_f0,

    input wire      xrq_is_full,
    input wire      xrq_is_almost_full,

    output wire     data_vld_f1
);

/********** SIGNAL DECLARE **************/

reg data_vld;

assign fifo_rd_en_f0 = ~fifo_empty_f0 & ~xrq_is_full & ~xrq_is_almost_full;
//assign data_vld_f1 = data_vld;
assign data_vld_f1 = ~fifo_empty_f0 & ~xrq_is_full & ~xrq_is_almost_full;

always @(posedge clk or negedge rstn)
begin
    if (!rstn)
    begin
        data_vld <= 1'b0;
    end
    else
    begin
        data_vld <= ~fifo_empty_f0 & ~xrq_is_full & ~xrq_is_almost_full;
    end
end

endmodule

