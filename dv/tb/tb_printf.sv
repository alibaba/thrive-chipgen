// Support PE_0_0 rv result display in tb env, only 1 PE (PE_0_0) is enabled
// PE_0_0_RV_0
`define PE_0_0_RV_0_PRINT_READY  `PE_0_0_RV_0.pad_biu_hready
reg  [31:0] pe_0_0_rv_0_print_addr;
reg  [1:0]  pe_0_0_rv_0_print_trans;
reg         pe_0_0_rv_0_print_write;
wire [31:0] pe_0_0_rv_0_print_wdata;

always @(posedge `PE_0_0_RV_0_AHB.cpu_clk)
begin
    pe_0_0_rv_0_print_trans[1:0] <= `PE_0_0_RV_0_AHB.biu_pad_htrans[1:0];
    pe_0_0_rv_0_print_addr[31:0] <= `PE_0_0_RV_0_AHB.biu_pad_haddr[31:0];
    pe_0_0_rv_0_print_write      <= `PE_0_0_RV_0_AHB.biu_pad_hwrite;
end

assign pe_0_0_rv_0_print_wdata[31:0] = `PE_0_0_RV_0_AHB.biu_pad_hwdata[31:0];

always @(posedge `PE_0_0_RV_0_AHB.cpu_clk)
begin
    if((pe_0_0_rv_0_print_trans[1:0] == 2'b10) &&
       (pe_0_0_rv_0_print_addr[31:0] == 32'hc00001f8) &&
       (pe_0_0_rv_0_print_write))
    begin 
        force `PE_0_0_RV_0_PRINT_READY = 1'b1;
        $write("%c", pe_0_0_rv_0_print_wdata[7:0]);
    end
    else
        release `PE_0_0_RV_0_PRINT_READY;
end

// PE_0_0_RV_1
`define PE_0_0_RV_1_PRINT_READY  `PE_0_0_RV_1.pad_biu_hready
reg  [31:0] pe_0_0_rv_1_print_addr;
reg  [1:0]  pe_0_0_rv_1_print_trans;
reg         pe_0_0_rv_1_print_write;
wire [31:0] pe_0_0_rv_1_print_wdata;

always @(posedge `PE_0_0_RV_1_AHB.cpu_clk)
begin
    pe_0_0_rv_1_print_trans[1:0] <= `PE_0_0_RV_1_AHB.biu_pad_htrans[1:0];
    pe_0_0_rv_1_print_addr[31:0] <= `PE_0_0_RV_1_AHB.biu_pad_haddr[31:0];
    pe_0_0_rv_1_print_write      <= `PE_0_0_RV_1_AHB.biu_pad_hwrite;
end

assign pe_0_0_rv_1_print_wdata[31:0] = `PE_0_0_RV_1_AHB.biu_pad_hwdata[31:0];

always @(posedge `PE_0_0_RV_1_AHB.cpu_clk)
begin
    if((pe_0_0_rv_1_print_trans[1:0] == 2'b10) &&
       (pe_0_0_rv_1_print_addr[31:0] == 32'hc00001f8) &&
       (pe_0_0_rv_1_print_write))
    begin 
        force `PE_0_0_RV_1_PRINT_READY = 1'b1;
        $write("%c", pe_0_0_rv_1_print_wdata[7:0]);
    end
    else
        release `PE_0_0_RV_1_PRINT_READY;
end

// PE_0_0_RV_2
`define PE_0_0_RV_2_PRINT_READY  `PE_0_0_RV_2.pad_biu_hready
reg  [31:0] pe_0_0_rv_2_print_addr;
reg  [1:0]  pe_0_0_rv_2_print_trans;
reg         pe_0_0_rv_2_print_write;
wire [31:0] pe_0_0_rv_2_print_wdata;

always @(posedge `PE_0_0_RV_2_AHB.cpu_clk)
begin
    pe_0_0_rv_2_print_trans[1:0] <= `PE_0_0_RV_2_AHB.biu_pad_htrans[1:0];
    pe_0_0_rv_2_print_addr[31:0] <= `PE_0_0_RV_2_AHB.biu_pad_haddr[31:0];
    pe_0_0_rv_2_print_write      <= `PE_0_0_RV_2_AHB.biu_pad_hwrite;
end

assign pe_0_0_rv_2_print_wdata[31:0] = `PE_0_0_RV_2_AHB.biu_pad_hwdata[31:0];

always @(posedge `PE_0_0_RV_2_AHB.cpu_clk)
begin
    if((pe_0_0_rv_2_print_trans[1:0] == 2'b10) &&
       (pe_0_0_rv_2_print_addr[31:0] == 32'hc00001f8) &&
       (pe_0_0_rv_2_print_write))
    begin 
        force `PE_0_0_RV_2_PRINT_READY = 1'b1;
        $write("%c", pe_0_0_rv_2_print_wdata[7:0]);
    end
    else
        release `PE_0_0_RV_2_PRINT_READY;
end


