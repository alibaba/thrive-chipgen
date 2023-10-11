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

module pe_clkgen(
% for mod in rvc.dispatcher + rvc.regular + dsas.dsas:
    ${mod.name}_clk,
% endfor
    mem_sub_sys_clk,
    sys_clk,
    sys_rstn
);

% for mod in rvc.dispatcher + rvc.regular + dsas.dsas:
output ${mod.name}_clk;
% endfor
output mem_sub_sys_clk;
input  sys_clk;
input  sys_rstn;

//TODO, PLL/MMCM required
% for mod in rvc.dispatcher + rvc.regular + dsas.dsas:
assign ${mod.name}_clk = sys_clk;   
% endfor
assign mem_sub_sys_clk = sys_clk;

endmodule
