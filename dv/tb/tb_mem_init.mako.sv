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

///////////////////////////////////////
// Memory Initialization  
///////////////////////////////////////
parameter WRAP_SIZE  = 8;
parameter DATA_WIDTH = 1024;
parameter ADDR_WIDTH = 13;  //1MB
parameter MEM_DEPTH  = 2**ADDR_WIDTH;

% for pe in chip.pe:
<% PE = pe.name.upper() %>\
//------------------${PE}--------------------------
    % for ind in range(4):
reg [DATA_WIDTH-1:0] ${pe.name}_mem_${ind} [MEM_DEPTH-1:0];
    % endfor

initial
begin
  $display("${pe.name}: Memory Initialization.");
    % for ind in range(4):
  $readmemh("${PE.lower()}_mem_${ind}_init.mem", ${pe.name}_mem_${ind});
    % endfor
end

generate 
    for (genvar i=0;i<DATA_WIDTH/WRAP_SIZE;i++) begin

initial begin

  for(integer j=0;j<MEM_DEPTH;j=j+1) begin
    % for ind in range(4):
    `${PE}_DPSRAM_${ind}.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^${pe.name}_mem_${ind}[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:${pe.name}_mem_${ind}[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
    % endfor
  end

end

end//gen for
endgenerate

% endfor
