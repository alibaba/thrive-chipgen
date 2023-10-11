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
name_list_pass = []
name_list_fail = []
for pe in chip.pe:
    name_list_pass.append(pe.name + "_rv_0_pass")
    name_list_fail.append(pe.name + "_rv_0_fail")
pass_cond = " && ".join([str(e) for e in name_list_pass])
fail_cond = " || ".join([str(e) for e in name_list_fail])
%>\

// Display Simulation Results
always @(posedge clk)
begin
    fork

% for pe in chip.pe:
       begin 
            @(${pe.name}_finish_flag == 1'b1);
            if(${pe.name}_rv_0_pass) begin
                $display("**********************************************");
                $display("*    ${pe.name.upper()} has finished successfully        *");
                $display("**********************************************");
                #10;
            end else if(${pe.name}_rv_0_fail) begin
                $display("**********************************************");
                $display("*    Error occured in ${pe.name.upper()}                 *");
                $display("**********************************************");
                #10;
            end
        end
% endfor

    join

    if (${pass_cond}) begin
        $display("**********************************************");
   	    $display("*    Simulation finished successfully        *");
   	    $display("**********************************************");
    end else begin
        $display("**********************************************");
   	    $display("*    Simulation finished with errors         *");
   	    $display("**********************************************");
    end

    $finish;
end
