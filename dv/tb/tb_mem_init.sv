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

//------------------PE_0_0--------------------------
reg [DATA_WIDTH-1:0] pe_0_0_mem_0 [MEM_DEPTH-1:0];
reg [DATA_WIDTH-1:0] pe_0_0_mem_1 [MEM_DEPTH-1:0];
reg [DATA_WIDTH-1:0] pe_0_0_mem_2 [MEM_DEPTH-1:0];
reg [DATA_WIDTH-1:0] pe_0_0_mem_3 [MEM_DEPTH-1:0];

initial
begin
  $display("pe_0_0: Memory Initialization.");
  $readmemh("pe_0_0_mem_0_init.mem", pe_0_0_mem_0);
  $readmemh("pe_0_0_mem_1_init.mem", pe_0_0_mem_1);
  $readmemh("pe_0_0_mem_2_init.mem", pe_0_0_mem_2);
  $readmemh("pe_0_0_mem_3_init.mem", pe_0_0_mem_3);
end

generate 
    for (genvar i=0;i<DATA_WIDTH/WRAP_SIZE;i++) begin

initial begin

  for(integer j=0;j<MEM_DEPTH;j=j+1) begin
    `PE_0_0_DPSRAM_0.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^pe_0_0_mem_0[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:pe_0_0_mem_0[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
    `PE_0_0_DPSRAM_1.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^pe_0_0_mem_1[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:pe_0_0_mem_1[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
    `PE_0_0_DPSRAM_2.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^pe_0_0_mem_2[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:pe_0_0_mem_2[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
    `PE_0_0_DPSRAM_3.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^pe_0_0_mem_3[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:pe_0_0_mem_3[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
  end

end

end//gen for
endgenerate

//------------------PE_1_0--------------------------
reg [DATA_WIDTH-1:0] pe_1_0_mem_0 [MEM_DEPTH-1:0];
reg [DATA_WIDTH-1:0] pe_1_0_mem_1 [MEM_DEPTH-1:0];
reg [DATA_WIDTH-1:0] pe_1_0_mem_2 [MEM_DEPTH-1:0];
reg [DATA_WIDTH-1:0] pe_1_0_mem_3 [MEM_DEPTH-1:0];

initial
begin
  $display("pe_1_0: Memory Initialization.");
  $readmemh("pe_1_0_mem_0_init.mem", pe_1_0_mem_0);
  $readmemh("pe_1_0_mem_1_init.mem", pe_1_0_mem_1);
  $readmemh("pe_1_0_mem_2_init.mem", pe_1_0_mem_2);
  $readmemh("pe_1_0_mem_3_init.mem", pe_1_0_mem_3);
end

generate 
    for (genvar i=0;i<DATA_WIDTH/WRAP_SIZE;i++) begin

initial begin

  for(integer j=0;j<MEM_DEPTH;j=j+1) begin
    `PE_1_0_DPSRAM_0.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^pe_1_0_mem_0[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:pe_1_0_mem_0[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
    `PE_1_0_DPSRAM_1.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^pe_1_0_mem_1[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:pe_1_0_mem_1[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
    `PE_1_0_DPSRAM_2.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^pe_1_0_mem_2[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:pe_1_0_mem_2[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
    `PE_1_0_DPSRAM_3.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^pe_1_0_mem_3[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:pe_1_0_mem_3[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
  end

end

end//gen for
endgenerate

//------------------PE_0_1--------------------------
reg [DATA_WIDTH-1:0] pe_0_1_mem_0 [MEM_DEPTH-1:0];
reg [DATA_WIDTH-1:0] pe_0_1_mem_1 [MEM_DEPTH-1:0];
reg [DATA_WIDTH-1:0] pe_0_1_mem_2 [MEM_DEPTH-1:0];
reg [DATA_WIDTH-1:0] pe_0_1_mem_3 [MEM_DEPTH-1:0];

initial
begin
  $display("pe_0_1: Memory Initialization.");
  $readmemh("pe_0_1_mem_0_init.mem", pe_0_1_mem_0);
  $readmemh("pe_0_1_mem_1_init.mem", pe_0_1_mem_1);
  $readmemh("pe_0_1_mem_2_init.mem", pe_0_1_mem_2);
  $readmemh("pe_0_1_mem_3_init.mem", pe_0_1_mem_3);
end

generate 
    for (genvar i=0;i<DATA_WIDTH/WRAP_SIZE;i++) begin

initial begin

  for(integer j=0;j<MEM_DEPTH;j=j+1) begin
    `PE_0_1_DPSRAM_0.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^pe_0_1_mem_0[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:pe_0_1_mem_0[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
    `PE_0_1_DPSRAM_1.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^pe_0_1_mem_1[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:pe_0_1_mem_1[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
    `PE_0_1_DPSRAM_2.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^pe_0_1_mem_2[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:pe_0_1_mem_2[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
    `PE_0_1_DPSRAM_3.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^pe_0_1_mem_3[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:pe_0_1_mem_3[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
  end

end

end//gen for
endgenerate

//------------------PE_1_1--------------------------
reg [DATA_WIDTH-1:0] pe_1_1_mem_0 [MEM_DEPTH-1:0];
reg [DATA_WIDTH-1:0] pe_1_1_mem_1 [MEM_DEPTH-1:0];
reg [DATA_WIDTH-1:0] pe_1_1_mem_2 [MEM_DEPTH-1:0];
reg [DATA_WIDTH-1:0] pe_1_1_mem_3 [MEM_DEPTH-1:0];

initial
begin
  $display("pe_1_1: Memory Initialization.");
  $readmemh("pe_1_1_mem_0_init.mem", pe_1_1_mem_0);
  $readmemh("pe_1_1_mem_1_init.mem", pe_1_1_mem_1);
  $readmemh("pe_1_1_mem_2_init.mem", pe_1_1_mem_2);
  $readmemh("pe_1_1_mem_3_init.mem", pe_1_1_mem_3);
end

generate 
    for (genvar i=0;i<DATA_WIDTH/WRAP_SIZE;i++) begin

initial begin

  for(integer j=0;j<MEM_DEPTH;j=j+1) begin
    `PE_1_1_DPSRAM_0.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^pe_1_1_mem_0[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:pe_1_1_mem_0[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
    `PE_1_1_DPSRAM_1.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^pe_1_1_mem_1[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:pe_1_1_mem_1[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
    `PE_1_1_DPSRAM_2.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^pe_1_1_mem_2[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:pe_1_1_mem_2[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
    `PE_1_1_DPSRAM_3.RAM_INST[i].ram_instance.mem[j][WRAP_SIZE-1:0] = ((^pe_1_1_mem_3[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i]) === 1'bx ) ? {(WRAP_SIZE){1'b0}}:pe_1_1_mem_3[j][WRAP_SIZE*(i+1)-1:WRAP_SIZE*i];
  end

end

end//gen for
endgenerate

