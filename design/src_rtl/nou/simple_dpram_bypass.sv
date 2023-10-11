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

module simple_dpram_bypass
#(
    parameter MEMDEPTH = 32,
    parameter DATAWIDTH = 32,
    parameter ADDRWIDTH = $clog2(MEMDEPTH),
    parameter MEMORY_INIT_FILE = "none"
)
(
  Clk,
  WriteAddr,
  ReadAddr,
  DataIn,
  WriteEnable,
  ReadEnable,
  DataOut
);

input                     Clk;
input   [(ADDRWIDTH-1):0] WriteAddr;
input   [(ADDRWIDTH-1):0] ReadAddr;
input   [(DATAWIDTH-1):0] DataIn;
input                     WriteEnable;
input                     ReadEnable;
output  [(DATAWIDTH-1):0] DataOut; 

reg [(DATAWIDTH-1):0] mem [(MEMDEPTH-1):0];

initial begin
    if (MEMORY_INIT_FILE != "none")
        $readmemh(MEMORY_INIT_FILE, mem);
end

reg [(DATAWIDTH-1):0] rdata;
reg [(DATAWIDTH-1):0] DataIn_reg;

always @(posedge Clk)
begin
  if(ReadEnable)
    DataIn_reg <= DataIn;
end

always @(posedge Clk)
begin
  if(WriteEnable)
  begin
    mem[WriteAddr]  <= DataIn;
  end
  if(ReadEnable)
  begin
    rdata    <= mem[ReadAddr];
  end
end

assign DataOut = (WriteEnable & ReadEnable && (WriteAddr == ReadAddr)) ? DataIn_reg : rdata;

endmodule
