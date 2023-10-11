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

module find_first_one_index_forward
#(
    parameter VECTOR_LENGTH    = 8,
    parameter MAX_OUTPUT_WIDTH = 16
)
(
    input       [VECTOR_LENGTH    - 1 : 0]      vector_in,
    output reg  [MAX_OUTPUT_WIDTH - 1 : 0]      first_one_index_out,
    output reg                                  one_is_found_out
);

integer loop_index;

always@*
begin : Find_First_One
    first_one_index_out = {(MAX_OUTPUT_WIDTH){1'b0}};
    one_is_found_out = 1'b0;

    for(loop_index = 0; loop_index < VECTOR_LENGTH; loop_index = loop_index + 1)
    begin
        if(vector_in[loop_index])
        begin
            first_one_index_out = loop_index;
            one_is_found_out = 1'b1;
            disable Find_First_One; //TO exit the loop
        end
    end
end

endmodule

