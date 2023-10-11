
// Display Simulation Results
always @(posedge clk)
begin
    fork

       begin 
            @(pe_0_0_finish_flag == 1'b1);
            if(pe_0_0_rv_0_pass) begin
                $display("**********************************************");
                $display("*    PE_0_0 has finished successfully        *");
                $display("**********************************************");
                #10;
            end else if(pe_0_0_rv_0_fail) begin
                $display("**********************************************");
                $display("*    Error occured in PE_0_0                 *");
                $display("**********************************************");
                #10;
            end
        end
       begin 
            @(pe_1_0_finish_flag == 1'b1);
            if(pe_1_0_rv_0_pass) begin
                $display("**********************************************");
                $display("*    PE_1_0 has finished successfully        *");
                $display("**********************************************");
                #10;
            end else if(pe_1_0_rv_0_fail) begin
                $display("**********************************************");
                $display("*    Error occured in PE_1_0                 *");
                $display("**********************************************");
                #10;
            end
        end
       begin 
            @(pe_0_1_finish_flag == 1'b1);
            if(pe_0_1_rv_0_pass) begin
                $display("**********************************************");
                $display("*    PE_0_1 has finished successfully        *");
                $display("**********************************************");
                #10;
            end else if(pe_0_1_rv_0_fail) begin
                $display("**********************************************");
                $display("*    Error occured in PE_0_1                 *");
                $display("**********************************************");
                #10;
            end
        end
       begin 
            @(pe_1_1_finish_flag == 1'b1);
            if(pe_1_1_rv_0_pass) begin
                $display("**********************************************");
                $display("*    PE_1_1 has finished successfully        *");
                $display("**********************************************");
                #10;
            end else if(pe_1_1_rv_0_fail) begin
                $display("**********************************************");
                $display("*    Error occured in PE_1_1                 *");
                $display("**********************************************");
                #10;
            end
        end

    join

    if (pe_0_0_rv_0_pass && pe_1_0_rv_0_pass && pe_0_1_rv_0_pass && pe_1_1_rv_0_pass) begin
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
