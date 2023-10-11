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


module async_rstgen(
    input rst_i,
    input soft_rst_i,
    input clk_i,
    output reg rst_n
);

wire rst;
assign rst = rst_i & soft_rst_i;

reg rst_ff;

always @(posedge clk_i or negedge rst) begin
    if (!rst) 
        {rst_n, rst_ff} <= 2'b0;
    else
        {rst_n, rst_ff} <= {rst_ff, 1'b1};
end

endmodule
