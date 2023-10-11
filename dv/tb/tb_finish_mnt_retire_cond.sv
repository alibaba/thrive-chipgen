// Monitor No Inst Retired for pe_0_0_rv_0
reg [31:0] pe_0_0_rv_0_retire_inst_in_period;
reg [31:0] pe_0_0_rv_0_cycle_count;

always @(posedge clk or negedge sys_rstn)
begin
    if(!sys_rstn)
        pe_0_0_rv_0_cycle_count[31:0] <= 32'b1;
    else 
        pe_0_0_rv_0_cycle_count[31:0] <= pe_0_0_rv_0_cycle_count[31:0] + 1'b1;
end

`ifndef PCIE_TEST
always @(posedge clk or negedge sys_rstn)
begin
    if(!sys_rstn)
    begin
        pe_0_0_rv_0_retire_inst_in_period[31:0] <= 32'b0;
    end
    else if((pe_0_0_rv_0_cycle_count[31:0] % `LAST_CYCLE) == 0)
    begin
        if(pe_0_0_rv_0_retire_inst_in_period[31:0] == 0)
        begin
            $display("*************************************************************");
            $display("* Error: There is no instructions retired in the last %d cycles! *", `LAST_CYCLE);
            $display("*              Simulation Fail and Finished!                *");
            $display("*************************************************************");
            #10;
            FILE = $fopen("run_case.report","w");
            $fdisplay(FILE,"TEST FAIL");   
            $finish;
        end
        pe_0_0_rv_0_retire_inst_in_period[31:0] <= 32'b0;
    end
    else if(`PE_0_0_RV_0_AHB.biu_pad_retire)
        pe_0_0_rv_0_retire_inst_in_period[31:0] <= pe_0_0_rv_0_retire_inst_in_period[31:0] + 1'b1;
end
`endif
// Monitor No Inst Retired for pe_1_0_rv_0
reg [31:0] pe_1_0_rv_0_retire_inst_in_period;
reg [31:0] pe_1_0_rv_0_cycle_count;

always @(posedge clk or negedge sys_rstn)
begin
    if(!sys_rstn)
        pe_1_0_rv_0_cycle_count[31:0] <= 32'b1;
    else 
        pe_1_0_rv_0_cycle_count[31:0] <= pe_1_0_rv_0_cycle_count[31:0] + 1'b1;
end

`ifndef PCIE_TEST
always @(posedge clk or negedge sys_rstn)
begin
    if(!sys_rstn)
    begin
        pe_1_0_rv_0_retire_inst_in_period[31:0] <= 32'b0;
    end
    else if((pe_1_0_rv_0_cycle_count[31:0] % `LAST_CYCLE) == 0)
    begin
        if(pe_1_0_rv_0_retire_inst_in_period[31:0] == 0)
        begin
            $display("*************************************************************");
            $display("* Error: There is no instructions retired in the last %d cycles! *", `LAST_CYCLE);
            $display("*              Simulation Fail and Finished!                *");
            $display("*************************************************************");
            #10;
            FILE = $fopen("run_case.report","w");
            $fdisplay(FILE,"TEST FAIL");   
            $finish;
        end
        pe_1_0_rv_0_retire_inst_in_period[31:0] <= 32'b0;
    end
    else if(`PE_1_0_RV_0_AHB.biu_pad_retire)
        pe_1_0_rv_0_retire_inst_in_period[31:0] <= pe_1_0_rv_0_retire_inst_in_period[31:0] + 1'b1;
end
`endif
// Monitor No Inst Retired for pe_0_1_rv_0
reg [31:0] pe_0_1_rv_0_retire_inst_in_period;
reg [31:0] pe_0_1_rv_0_cycle_count;

always @(posedge clk or negedge sys_rstn)
begin
    if(!sys_rstn)
        pe_0_1_rv_0_cycle_count[31:0] <= 32'b1;
    else 
        pe_0_1_rv_0_cycle_count[31:0] <= pe_0_1_rv_0_cycle_count[31:0] + 1'b1;
end

`ifndef PCIE_TEST
always @(posedge clk or negedge sys_rstn)
begin
    if(!sys_rstn)
    begin
        pe_0_1_rv_0_retire_inst_in_period[31:0] <= 32'b0;
    end
    else if((pe_0_1_rv_0_cycle_count[31:0] % `LAST_CYCLE) == 0)
    begin
        if(pe_0_1_rv_0_retire_inst_in_period[31:0] == 0)
        begin
            $display("*************************************************************");
            $display("* Error: There is no instructions retired in the last %d cycles! *", `LAST_CYCLE);
            $display("*              Simulation Fail and Finished!                *");
            $display("*************************************************************");
            #10;
            FILE = $fopen("run_case.report","w");
            $fdisplay(FILE,"TEST FAIL");   
            $finish;
        end
        pe_0_1_rv_0_retire_inst_in_period[31:0] <= 32'b0;
    end
    else if(`PE_0_1_RV_0_AHB.biu_pad_retire)
        pe_0_1_rv_0_retire_inst_in_period[31:0] <= pe_0_1_rv_0_retire_inst_in_period[31:0] + 1'b1;
end
`endif
// Monitor No Inst Retired for pe_1_1_rv_0
reg [31:0] pe_1_1_rv_0_retire_inst_in_period;
reg [31:0] pe_1_1_rv_0_cycle_count;

always @(posedge clk or negedge sys_rstn)
begin
    if(!sys_rstn)
        pe_1_1_rv_0_cycle_count[31:0] <= 32'b1;
    else 
        pe_1_1_rv_0_cycle_count[31:0] <= pe_1_1_rv_0_cycle_count[31:0] + 1'b1;
end

`ifndef PCIE_TEST
always @(posedge clk or negedge sys_rstn)
begin
    if(!sys_rstn)
    begin
        pe_1_1_rv_0_retire_inst_in_period[31:0] <= 32'b0;
    end
    else if((pe_1_1_rv_0_cycle_count[31:0] % `LAST_CYCLE) == 0)
    begin
        if(pe_1_1_rv_0_retire_inst_in_period[31:0] == 0)
        begin
            $display("*************************************************************");
            $display("* Error: There is no instructions retired in the last %d cycles! *", `LAST_CYCLE);
            $display("*              Simulation Fail and Finished!                *");
            $display("*************************************************************");
            #10;
            FILE = $fopen("run_case.report","w");
            $fdisplay(FILE,"TEST FAIL");   
            $finish;
        end
        pe_1_1_rv_0_retire_inst_in_period[31:0] <= 32'b0;
    end
    else if(`PE_1_1_RV_0_AHB.biu_pad_retire)
        pe_1_1_rv_0_retire_inst_in_period[31:0] <= pe_1_1_rv_0_retire_inst_in_period[31:0] + 1'b1;
end
`endif
