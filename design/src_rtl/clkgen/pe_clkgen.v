module pe_clkgen(
    dispatcher_clk,
    regular_0_clk,
    regular_1_clk,
    dsa_0_clk,
    dsa_1_clk,
    dsa_2_clk,
    nou_clk,
    mem_sub_sys_clk,
    sys_clk,
    sys_rstn
);

output dispatcher_clk;
output regular_0_clk;
output regular_1_clk;
output dsa_0_clk;
output dsa_1_clk;
output dsa_2_clk;
output nou_clk;
output mem_sub_sys_clk;
input  sys_clk;
input  sys_rstn;

//TODO, PLL/MMCM required
assign dispatcher_clk = sys_clk;   
assign regular_0_clk = sys_clk;   
assign regular_1_clk = sys_clk;   
assign dsa_0_clk = sys_clk;   
assign dsa_1_clk = sys_clk;   
assign dsa_2_clk = sys_clk;   
assign nou_clk = sys_clk;   
assign mem_sub_sys_clk = sys_clk;

endmodule
