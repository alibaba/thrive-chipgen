// *****************************************************************************
// FILE NAME       : tb_top.sv
// AUTHOR          : Linyong Huang
// FUNCTION        : top testbench
// *****************************************************************************
`timescale 1ps/1ps
`include "tb_define.h"

module tb_top();

// Reset Gen
`include "tb_reset.sv"

// Clock Gen
`include "tb_clock.sv"

// Mem Init
`include "tb_mem_init.sv"

// User Function
`include "tb_func.sv"

// DUT Init
thrive_top_wrapper dut (
    .pe_0_0_sys_clk (clk),
    .pe_0_0_sys_rstn (sys_rstn),
    .pe_1_0_sys_clk (clk),
    .pe_1_0_sys_rstn (sys_rstn),
    .pe_0_1_sys_clk (clk),
    .pe_0_1_sys_rstn (sys_rstn),
    .pe_1_1_sys_clk (clk),
    .pe_1_1_sys_rstn (sys_rstn)
);

// Finish Condition Control 
`include "tb_finish_mnt.sv"

endmodule
