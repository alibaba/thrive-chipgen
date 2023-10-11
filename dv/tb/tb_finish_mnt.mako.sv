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

///////////////////////////////////////////////////
// The Way to Control Finish Status
// 1. Global Max Simulation Time
// 2. Monitor No Inst Retired in Last Several Cycles 
// for each CPU
// 3. Monitor Finish Condition for each CPU
///////////////////////////////////////////////////

integer FILE;

// Global Max Simulation
initial
begin
    #`MAX_RUN_TIME;
    $display("**********************************************");
    $display("*   meeting max simulation time, stop!       *");
    $display("**********************************************");
    FILE = $fopen("run_case.report","w");
    $fdisplay(FILE,"TEST FAIL");   
    $finish;
end

`include "tb_finish_mnt_retire_cond.sv"

`include "tb_finish_mnt_finish_cond.sv"

`include "tb_finish_mnt_disp_res.sv"
