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

//----------------------------------------------//
module dff
#(parameter W=1
)

(
    input wire          clk,
    input wire          g, 
    input wire [W-1:0]  d, 
    output reg [W-1:0]  q
);

    always_ff @(posedge clk)
    begin: dff_blk
        if (g == 1'b1)
            q[(W-1):0] <= d[(W-1):0];
    end

endmodule

//----------------------------------------------//
module dffr
#(parameter W=1,
            R = {W{1'b0}}
)

(
    input wire          clk,
    input wire          rn,
    input wire          g, 
    input wire [W-1:0]  d, 
    output reg [W-1:0]  q
);

    always_ff @(posedge clk or negedge rn)
    begin: dff_blk
        if (!rn)
            q[(W-1):0] <= R;
        else if (g == 1'b1)
            q[(W-1):0] <= d[(W-1):0];
    end

endmodule


