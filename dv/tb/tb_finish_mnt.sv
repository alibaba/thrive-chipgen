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
