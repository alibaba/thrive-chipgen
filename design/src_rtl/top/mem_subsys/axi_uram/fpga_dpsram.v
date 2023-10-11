/*Copyright 2020-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
module fpga_dpsram(
  clka,
  addra,
  dina,
  wea,
  douta,
  clkb,
  addrb,
  dinb,
  web,
  doutb
);

parameter DATA_WIDTH = 1024;
parameter WRAP_SIZE = 8;
parameter ADDR_WIDTH = 2;

input                       clka;
input   [(ADDR_WIDTH-1):0]   addra;
input   [(DATA_WIDTH-1):0]   dina;
input   [(DATA_WIDTH/8)-1:0] wea;
output  [(DATA_WIDTH-1):0]   douta; 
input                       clkb;
input   [(ADDR_WIDTH-1):0]   addrb;
input   [(DATA_WIDTH-1):0]   dinb;
input   [(DATA_WIDTH/8)-1:0] web;
output  [(DATA_WIDTH-1):0]   doutb; 

genvar i;
generate
  for(i=0; i<DATA_WIDTH/WRAP_SIZE; i=i+1) begin: RAM_INST
    fpga_uram #(WRAP_SIZE,ADDR_WIDTH) ram_instance(
      .PortAClk (clka),
      .PortAAddr(addra),
      .PortADataIn (dina[(i+1)*WRAP_SIZE-1:i*WRAP_SIZE]),
      .PortAWriteEnable(wea[i]),
      .PortADataOut(douta[(i+1)*WRAP_SIZE-1:i*WRAP_SIZE]),
      .PortBClk (clkb),
      .PortBAddr(addrb),
      .PortBDataIn (dinb[(i+1)*WRAP_SIZE-1:i*WRAP_SIZE]),
      .PortBWriteEnable(web[i]),
      .PortBDataOut(doutb[(i+1)*WRAP_SIZE-1:i*WRAP_SIZE])
    );
  end
endgenerate

endmodule
