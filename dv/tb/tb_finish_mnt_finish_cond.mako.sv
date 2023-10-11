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
ind = 0
%>\
% for pe in chip.pe:
// Monitor Finish Condition for ${pe.name}_rv_${ind} 
reg ${pe.name}_rv_${ind}_pass;
reg ${pe.name}_rv_${ind}_fail;
reg ${pe.name}_finish_flag;

reg [31:0]  ${pe.name}_rv_${ind}_cpu_addr;
reg [1:0]   ${pe.name}_rv_${ind}_cpu_trans;
reg         ${pe.name}_rv_${ind}_cpu_write;
wire [31:0] ${pe.name}_rv_${ind}_cpu_wdata;

always @(posedge clk)
begin
    ${pe.name}_rv_${ind}_cpu_trans[1:0] <= `${pe.name.upper()}_RV_${ind}.biu_pad_htrans[1:0];
    ${pe.name}_rv_${ind}_cpu_addr[31:0] <= `${pe.name.upper()}_RV_${ind}.biu_pad_haddr[31:0];
    ${pe.name}_rv_${ind}_cpu_write      <= `${pe.name.upper()}_RV_${ind}.biu_pad_hwrite;
end

assign ${pe.name}_rv_${ind}_cpu_wdata[31:0] = `${pe.name.upper()}_RV_${ind}.biu_pad_hwdata[31:0];

always @(posedge clk or negedge sys_rstn)
begin
    if(!sys_rstn) 
    begin
        ${pe.name}_rv_${ind}_pass <= 1'b0;
        ${pe.name}_rv_${ind}_fail <= 1'b0;
        ${pe.name}_finish_flag <= 1'b0;
    end
    else if((${pe.name}_rv_${ind}_cpu_trans[1:0] == 2'b10) &&
            (${pe.name}_rv_${ind}_cpu_addr[31:0] == `MAILBOX_ADDR) &&
             ${pe.name}_rv_${ind}_cpu_write &&
            (${pe.name}_rv_${ind}_cpu_wdata[31:0] == `PASS_FLAG))
    begin
        ${pe.name}_rv_${ind}_pass <= 1'b1;
        ${pe.name}_finish_flag <= 1'b1;
    end
    else if((${pe.name}_rv_${ind}_cpu_trans[1:0] == 2'b10) &&
            (${pe.name}_rv_${ind}_cpu_addr[31:0] == `MAILBOX_ADDR) &&
             ${pe.name}_rv_${ind}_cpu_write &&
            (${pe.name}_rv_${ind}_cpu_wdata[31:0] == `FAIL_FLAG))
    begin
        ${pe.name}_rv_${ind}_fail <= 1'b1;
        ${pe.name}_finish_flag <= 1'b1;
    end
    else if((${pe.name}_rv_${ind}_cpu_trans[1:0] == 2'b10) &&
            (${pe.name}_rv_${ind}_cpu_addr[31:0] == `MAILBOX_ADDR) &&
             ${pe.name}_rv_${ind}_cpu_write)
    begin
        $write("%c", ${pe.name}_rv_${ind}_cpu_wdata[7:0]);
    end
end
% endfor
