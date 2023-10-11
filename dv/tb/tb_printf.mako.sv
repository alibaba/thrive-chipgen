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

<%
PE = "PE_0_0"
pe = "pe_0_0"
%>\
// Support ${PE} rv result display in tb env, only 1 PE (PE_0_0) is enabled
% for ind, _ in enumerate(pes[0].rvs.dispatcher + pes[0].rvs.regular):
// ${PE}_RV_${ind}
`define ${PE}_RV_${ind}_PRINT_READY  `${PE}_RV_${ind}.pad_biu_hready
reg  [31:0] ${pe}_rv_${ind}_print_addr;
reg  [1:0]  ${pe}_rv_${ind}_print_trans;
reg         ${pe}_rv_${ind}_print_write;
wire [31:0] ${pe}_rv_${ind}_print_wdata;

always @(posedge `${PE}_RV_${ind}_AHB.cpu_clk)
begin
    ${pe}_rv_${ind}_print_trans[1:0] <= `${PE}_RV_${ind}_AHB.biu_pad_htrans[1:0];
    ${pe}_rv_${ind}_print_addr[31:0] <= `${PE}_RV_${ind}_AHB.biu_pad_haddr[31:0];
    ${pe}_rv_${ind}_print_write      <= `${PE}_RV_${ind}_AHB.biu_pad_hwrite;
end

assign ${pe}_rv_${ind}_print_wdata[31:0] = `${PE}_RV_${ind}_AHB.biu_pad_hwdata[31:0];

always @(posedge `${PE}_RV_${ind}_AHB.cpu_clk)
begin
    if((${pe}_rv_${ind}_print_trans[1:0] == 2'b10) &&
       (${pe}_rv_${ind}_print_addr[31:0] == 32'hc00001f8) &&
       (${pe}_rv_${ind}_print_write))
    begin 
        force `${PE}_RV_${ind}_PRINT_READY = 1'b1;
        $write("%c", ${pe}_rv_${ind}_print_wdata[7:0]);
    end
    else
        release `${PE}_RV_${ind}_PRINT_READY;
end

% endfor

