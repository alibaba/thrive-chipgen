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

`timescale 1 ns / 1 ps

module axi_uram #
(
    parameter MEMORY_INIT_FILE = "none", 
    // URAM latency
    parameter integer URAM_LATENCY = 5,
    // Maximum outstanding transactions
    parameter integer MAX_OUTSTANDING_TRANX = 16,
	// Width of ID for for write address, write data, read address and read data
	parameter integer C_S_AXI_ID_WIDTH	= 4,
	// Width of S_AXI data bus
	parameter integer C_S_AXI_DATA_WIDTH	= 1024,
	// Width of S_AXI address bus
	parameter integer C_S_AXI_ADDR_WIDTH	= 20
)(
    s_axi_aclk,
    s_axi_aresetn,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awlock,
    s_axi_awcache,
    s_axi_awprot,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arlock,
    s_axi_arcache,
    s_axi_arprot,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready
);

  input s_axi_aclk;
  input s_axi_aresetn;

  input [C_S_AXI_ID_WIDTH-1:0]s_axi_awid;
  input [C_S_AXI_ADDR_WIDTH-1:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input s_axi_awlock;
  input [3:0]s_axi_awcache;
  input [2:0]s_axi_awprot;
  input s_axi_awvalid;
  output s_axi_awready;
  input [C_S_AXI_DATA_WIDTH-1:0]s_axi_wdata;
  input [(C_S_AXI_DATA_WIDTH/8)-1:0]s_axi_wstrb;
  input s_axi_wlast;
  input s_axi_wvalid;
  output s_axi_wready;
  output [C_S_AXI_ID_WIDTH-1:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [C_S_AXI_ID_WIDTH-1:0]s_axi_arid;
  input [C_S_AXI_ADDR_WIDTH-1:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input s_axi_arlock;
  input [3:0]s_axi_arcache;
  input [2:0]s_axi_arprot;
  input s_axi_arvalid;
  output s_axi_arready;
  output [C_S_AXI_ID_WIDTH-1:0]s_axi_rid;
  output [C_S_AXI_DATA_WIDTH-1:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input s_axi_rready;

  localparam ENTRY_OFFSET_WIDTH=$clog2(C_S_AXI_DATA_WIDTH/8);
  localparam URAM_SIZE_IN_BIT=(2**C_S_AXI_ADDR_WIDTH)*8;

  wire ena;
  wire enb;
  wire [(C_S_AXI_DATA_WIDTH/8)-1:0] wea;
  wire [C_S_AXI_ADDR_WIDTH-1:0] addra;
  wire [C_S_AXI_ADDR_WIDTH-1:0] addrb;
  wire [C_S_AXI_DATA_WIDTH-1:0] dina;
  wire [C_S_AXI_DATA_WIDTH-1:0] doutb;

  reg [C_S_AXI_ADDR_WIDTH-1:0] waddr_reg;
  reg [C_S_AXI_DATA_WIDTH-1:0] wdata_reg;
  reg [(C_S_AXI_DATA_WIDTH/8)-1:0] wstrb_reg;
  reg [C_S_AXI_ID_WIDTH-1:0] wid_reg;
  reg [7:0] wcnt_reg;
  reg [2:0] wsize_reg;

  reg wr_bip; //burst in process
  reg wr_bts; //beat to send, means in the register stage there are write beat to send to uram
  reg wr_data_in_register_stage; // this signal is high means ther are data in register stage to send to uram
  reg bresp_stuck;

  reg rd_bip; //burst in process
  reg [C_S_AXI_ADDR_WIDTH-1:0] raddr_reg;
  reg [C_S_AXI_ID_WIDTH-1:0] rid_reg;
  reg [2:0] rsize_reg;
  reg [7:0] rcnt_reg;
  
  wire rd_info_wr;
  wire rd_data_wr;
  wire rd_info_rd;
  wire rd_data_rd;
  wire [8:0] rd_info_in;
  wire [8:0] rd_info_out;
  wire [C_S_AXI_DATA_WIDTH-1:0] rd_data_in;
  wire [C_S_AXI_DATA_WIDTH-1:0] rd_data_out;
  wire rd_info_almost_full;
  wire rd_data_almost_full;
  wire rd_info_empty;
  wire rd_data_empty;

  reg [URAM_LATENCY-1:0] stage_valid;
  reg [C_S_AXI_ID_WIDTH-1:0] stage_rid[0:URAM_LATENCY-1];
  reg stage_rlast[0:URAM_LATENCY-1];
  
  wire last_beat_sent_out;
  //wire data_exist_in_buffer;
  
  genvar i;

  //write channel interface signals
  wire        wr_cmd_rd;
  wire        wr_cmd_full;
  wire        wr_cmd_empty;
  wire [43:0] wr_cmd_in;
  wire [43:0] wr_cmd_out;

  wire                          wr_data_rd;
  wire [C_S_AXI_DATA_WIDTH-1:0] wr_data_out;
  wire [(C_S_AXI_DATA_WIDTH/8)-1:0] wr_wstrb_out;
  wire                          wr_data_full;
  wire                          wr_data_empty;
  wire [C_S_AXI_ID_WIDTH-1:0] awid;

  assign s_axi_bid = wid_reg;
  assign s_axi_rid = rd_info_out[C_S_AXI_ID_WIDTH-1:0];

  assign awid = {{(8-C_S_AXI_ID_WIDTH){1'b0}}, s_axi_awid};
  assign wr_cmd_in = {1'b0, s_axi_awsize, s_axi_awlen, awid, 1'b0, {(23 - C_S_AXI_ADDR_WIDTH){1'b0}}, s_axi_awaddr}; //TODO need to be modified when parameter change
  assign s_axi_awready = !wr_cmd_full;
  assign s_axi_wready = !wr_data_full;
  assign wr_cmd_rd = !wr_cmd_empty && !wr_data_empty && (wcnt_reg == 0) && (!wr_bip || s_axi_bready);
  assign wr_data_rd = wr_cmd_rd || (wr_bts && !wr_data_empty && (wcnt_reg != 0));

`ifdef XILINX_FPGA
  wcmd_fifo u_wr_cmd_fifo(
      .clk    (s_axi_aclk),
      .srst   (!s_axi_aresetn),
      .din    (wr_cmd_in),
      .wr_en  (s_axi_awvalid && s_axi_awready),
      .rd_en  (wr_cmd_rd),
      .dout   (wr_cmd_out),
      .full   (wr_cmd_full),
      .empty  (wr_cmd_empty)
  );
 
  wdata_fifo u_wr_data_fifo(
      .clk    (s_axi_aclk),
      .srst   (!s_axi_aresetn),
      .din    (s_axi_wdata),
      .wr_en  (s_axi_wvalid && s_axi_wready),
      .rd_en  (wr_data_rd),
      .dout   (wr_data_out),
      .full   (wr_data_full),
      .empty  (wr_data_empty)
  );
 
  wstrb_fifo u_wr_strb_fifo(
      .clk    (s_axi_aclk),
      .srst   (!s_axi_aresetn),
      .din    (s_axi_wstrb),
      .wr_en  (s_axi_wvalid && s_axi_wready),
      .rd_en  (wr_data_rd),
      .dout   (wr_wstrb_out),
      .full   (),
      .empty  ()
  );
`else
  fwft_fifo #(
      .WIDTH(44),
      .DEPTH(MAX_OUTSTANDING_TRANX)
  ) u_wr_cmd_fifo(
      .clk    (s_axi_aclk),
      .rstn   (s_axi_aresetn),
      .din    (wr_cmd_in),
      .wr_en  (s_axi_awvalid && s_axi_awready),
      .rd_en  (wr_cmd_rd),
      .dout   (wr_cmd_out),
      .full   (wr_cmd_full),
      .empty  (wr_cmd_empty)
  );

  fwft_fifo #(
      .WIDTH(C_S_AXI_DATA_WIDTH),
      .DEPTH(MAX_OUTSTANDING_TRANX)
  ) u_wr_data_fifo(
      .clk    (s_axi_aclk),
      .rstn   (s_axi_aresetn),
      .din    (s_axi_wdata),
      .wr_en  (s_axi_wvalid && s_axi_wready),
      .rd_en  (wr_data_rd),
      .dout   (wr_data_out),
      .full   (wr_data_full),
      .empty  (wr_data_empty)
  );
 
  fwft_fifo #(
      .WIDTH(C_S_AXI_DATA_WIDTH/8),
      .DEPTH(MAX_OUTSTANDING_TRANX)
  ) u_wr_strb_fifo(
      .clk    (s_axi_aclk),
      .rstn   (s_axi_aresetn),
      .din    (s_axi_wstrb),
      .wr_en  (s_axi_wvalid && s_axi_wready),
      .rd_en  (wr_data_rd),
      .dout   (wr_wstrb_out),
      .full   (),
      .empty  ()
  );
`endif
//write response channel interface signals
assign s_axi_bvalid = wr_bip && (((wcnt_reg == 0) && (wr_data_in_register_stage)) || bresp_stuck);
assign s_axi_bresp = 2'b00;

//buffer write address channel signals
always@(posedge s_axi_aclk)
begin
    if(wr_cmd_rd)
    begin
        wid_reg <= wr_cmd_out[24+C_S_AXI_ID_WIDTH-1:24];
        wsize_reg <= wr_cmd_out[42:40];
    end
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        wcnt_reg <= 0;
    else if(wr_cmd_rd)
        wcnt_reg <= wr_cmd_out[39:32];
    else if(wr_bts && (wcnt_reg != 0) && !wr_data_empty)
        wcnt_reg <= wcnt_reg - 1'b1;
end

always@(posedge s_axi_aclk)
begin
    if(wr_cmd_rd)
        waddr_reg <= wr_cmd_out[C_S_AXI_ADDR_WIDTH-1:0];
    else if(wr_bts && (wcnt_reg != 0) && (wr_data_in_register_stage))
        waddr_reg <= wsize_reg[0] ? (waddr_reg + 8'b10000000) : (waddr_reg + 7'b1000000);
end

always@(posedge s_axi_aclk)
begin
    if(wr_data_rd)
        wdata_reg <= wr_data_out[C_S_AXI_DATA_WIDTH-1:0];
        wstrb_reg <= wr_wstrb_out[C_S_AXI_DATA_WIDTH/8-1:0];
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        wr_bip <= 1'b0;
    else if(wr_cmd_rd)
        wr_bip <= 1'b1;
    else if((((wcnt_reg == 0) && (wr_data_in_register_stage)) || bresp_stuck) && s_axi_bready)
        wr_bip <= 1'b0;
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        bresp_stuck <= 1'b0;
    else if(s_axi_bvalid && (!s_axi_bready))
        bresp_stuck <= 1'b1;
    else if(s_axi_bready)
        bresp_stuck <= 1'b0;
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        wr_bts <= 1'b0;
    else if(wr_cmd_rd)
        wr_bts <= 1'b1;
    else if((wcnt_reg == 0)  && (wr_data_in_register_stage))
        wr_bts <= 1'b0;
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        wr_data_in_register_stage <= 1'b0;
    else 
        wr_data_in_register_stage <= wr_cmd_rd || wr_data_rd;
end

//control signals for uram porta
assign addra = waddr_reg;
assign ena = wr_bts && wr_data_in_register_stage;
assign dina = wdata_reg;
assign wea = wstrb_reg; 

//read channel interface signals
assign s_axi_arready = !rd_bip || last_beat_sent_out;
assign last_beat_sent_out = (rcnt_reg == 8'b0) && enb;

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        rd_bip <= 1'b0;
    else if(s_axi_arvalid && s_axi_arready)
        rd_bip <= 1'b1;
    else if(last_beat_sent_out)
        rd_bip <= 1'b0;
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        rcnt_reg <= 8'b0;
    else if(s_axi_arvalid && s_axi_arready)
        rcnt_reg <= s_axi_arlen;
    else if(enb && (rcnt_reg != 0))
        rcnt_reg <= rcnt_reg - 1'b1;
end

always@(posedge s_axi_aclk)
begin
    if(s_axi_arvalid && s_axi_arready)
    begin
        rid_reg   <= s_axi_arid;
        rsize_reg <= s_axi_arsize;
    end
end

always@(posedge s_axi_aclk)
begin
    if(s_axi_arvalid && s_axi_arready)
        raddr_reg <= s_axi_araddr;
    else if(enb && (rcnt_reg != 0))
        raddr_reg <= rsize_reg[0] ? (raddr_reg + 8'b10000000) : (raddr_reg + 7'b1000000); 
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        stage_valid[0] <= 1'b0;
    else
        stage_valid[0] <= enb;
end

always@(posedge s_axi_aclk)
begin
    stage_rlast[0] <= last_beat_sent_out;
    stage_rid[0] <= rid_reg;
end

generate 
    for(i=1;i<URAM_LATENCY;i=i+1)
    begin: gen_stage_record

        always@(posedge s_axi_aclk or negedge s_axi_aresetn)
        begin
            if(~s_axi_aresetn)
                stage_valid[i] <= 1'b0;
            else
                stage_valid[i] <= stage_valid[i-1];
        end

        always@(posedge s_axi_aclk)
        begin
            stage_rid[i] <= stage_rid[i-1];
            stage_rlast[i] <= stage_rlast[i-1];
        end

    end
endgenerate

`ifdef XILINX_FPGA
rinfo_fifo u_rd_info_fifo(
    .clk           (s_axi_aclk),
    .srst          (!s_axi_aresetn),
    .din           (rd_info_in),
    .wr_en         (rd_info_wr),
    .rd_en         (rd_info_rd),
    .dout          (rd_info_out),
    .prog_full     (rd_info_almost_full),
    .empty         (rd_info_empty)
);

rdata_fifo u_rd_data_fifo(
    .clk           (s_axi_aclk),
    .srst          (!s_axi_aresetn),
    .din           (rd_data_in),
    .wr_en         (rd_data_wr),
    .rd_en         (rd_data_rd),
    .dout          (rd_data_out),
    .prog_full     (rd_data_almost_full), //TODO: almost full means rdata_fifo only have 8 unused entry,its threshold must > parameter URAM_LATENCY
    .empty         (rd_data_empty)
);
`else
  fwft_fifo #(
      .WIDTH(9),
      .DEPTH(MAX_OUTSTANDING_TRANX)
  ) u_rd_info_fifo(
    .clk           (s_axi_aclk),
    .rstn          (s_axi_aresetn),
    .din           (rd_info_in),
    .wr_en         (rd_info_wr),
    .rd_en         (rd_info_rd),
    .dout          (rd_info_out),
    .full          (rd_info_almost_full),
    .empty         (rd_info_empty)
  );

  fwft_fifo #(
      .WIDTH(C_S_AXI_DATA_WIDTH),
      .DEPTH(MAX_OUTSTANDING_TRANX)
  ) u_rd_data_fifo(
    .clk           (s_axi_aclk),
    .rstn          (s_axi_aresetn),
    .din           (rd_data_in),
    .wr_en         (rd_data_wr),
    .rd_en         (rd_data_rd),
    .dout          (rd_data_out),
    .full          (rd_data_almost_full), //TODO: almost full means rdata_fifo only have 8 unused entry,its threshold must > parameter URAM_LATENCY
    .empty         (rd_data_empty)
  );
`endif
wire [C_S_AXI_ID_WIDTH-1:0] rid;

assign rid = {{(8-C_S_AXI_ID_WIDTH){1'b0}}, stage_rid[URAM_LATENCY-1]};
assign rd_info_wr = stage_valid[URAM_LATENCY-1]; 
assign rd_data_wr = stage_valid[URAM_LATENCY-1];
assign rd_info_in = {stage_rlast[URAM_LATENCY-1], rid}; //TODO: need to be modified when id width change
assign rd_data_in = doutb;
assign rd_info_rd = !rd_info_empty && s_axi_rready;
assign rd_data_rd = !rd_data_empty && s_axi_rready;

assign s_axi_rresp = 2'b00;
assign s_axi_rvalid = !rd_data_empty;
assign s_axi_rdata = rd_data_out;
assign s_axi_rlast = rd_info_out[8]; 

assign addrb = raddr_reg; 
assign enb   = rd_bip && !rd_data_almost_full;

`ifdef XILINX_FPGA
xpm_memory_sdpram #(
   .ADDR_WIDTH_A(C_S_AXI_ADDR_WIDTH-ENTRY_OFFSET_WIDTH),              // DECIMAL
   .ADDR_WIDTH_B(C_S_AXI_ADDR_WIDTH-ENTRY_OFFSET_WIDTH),              // DECIMAL
   .AUTO_SLEEP_TIME(0),           // DECIMAL
   .BYTE_WRITE_WIDTH_A(8),        // DECIMAL
   .CASCADE_HEIGHT(0),            // DECIMAL
   .CLOCKING_MODE("common_clock"),
   .ECC_MODE("no_ecc"),           // String
   .MEMORY_INIT_FILE(MEMORY_INIT_FILE),     // String
   .MEMORY_INIT_PARAM("0"),       // String
   .MEMORY_OPTIMIZATION("true"),  // String
   .MEMORY_PRIMITIVE("ultra"),    // String
   .MEMORY_SIZE(URAM_SIZE_IN_BIT),        // DECIMAL
   .MESSAGE_CONTROL(0),           // DECIMAL
   .READ_DATA_WIDTH_B(C_S_AXI_DATA_WIDTH),      // DECIMAL
   .READ_LATENCY_B(URAM_LATENCY),            // DECIMAL
   .READ_RESET_VALUE_B("0"),      // String
   .RST_MODE_A("SYNC"),           // String
   .RST_MODE_B("SYNC"),           // String
   .SIM_ASSERT_CHK(0),            // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
   .USE_EMBEDDED_CONSTRAINT(0),
   .USE_MEM_INIT(1),              // DECIMAL
   .WAKEUP_TIME("disable_sleep"), // String
   .WRITE_DATA_WIDTH_A(C_S_AXI_DATA_WIDTH),     // DECIMAL
   .WRITE_MODE_B("read_first")    // String
) xpm_memory_sdpram_inst (
   .dbiterrb(),                     // 1-bit output: Status signal to indicate double bit error occurrence
                                    // on the data output of port A.

   .doutb(doutb),                   // READ_DATA_WIDTH_A-bit output: Data output for port A read operations.
   .sbiterrb(),                     // 1-bit output: Status signal to indicate single bit error occurrence
                                    // on the data output of port A.

   .addra(addra[C_S_AXI_ADDR_WIDTH-1:ENTRY_OFFSET_WIDTH]),// ADDR_WIDTH_A-bit input: Address for port A write and read operations.
   .addrb(addrb[C_S_AXI_ADDR_WIDTH-1:ENTRY_OFFSET_WIDTH]),// ADDR_WIDTH_A-bit input: Address for port A write and read operations.
   .clka(s_axi_aclk),                     // 1-bit input: Clock signal for port A.
   .clkb(s_axi_aclk),                     // 1-bit input: Clock signal for port A.
   .dina(dina),                     // WRITE_DATA_WIDTH_A-bit input: Data input for port A write operations.
   .ena(ena),                       // 1-bit input: Memory enable signal for port A. Must be high on clock
                                    // cycles when read or write operations are initiated. Pipelined
                                    // internally.
   .enb(enb),                       // 1-bit input: Memory enable signal for port A. Must be high on clock
                                    // cycles when read or write operations are initiated. Pipelined
                                    // internally.

   .injectdbiterra(1'b0),           // 1-bit input: Controls double bit error injection on input data when
                                    // ECC enabled (Error injection capability is not available in
                                    // "decode_only" mode).

   .injectsbiterra(1'b0),           // 1-bit input: Controls single bit error injection on input data when
                                    // ECC enabled (Error injection capability is not available in
                                    // "decode_only" mode).

   .regceb(1'b1),                   // 1-bit input: Clock Enable for the last register stage on the output
                                    // data path.

   .rstb(!s_axi_aresetn),                     // 1-bit input: Reset signal for the final port B output register stage.
                                    // Synchronously resets output port douta to the value specified by
                                    // parameter READ_RESET_VALUE_B.

   .sleep(1'b0),                    // 1-bit input: sleep signal to enable the dynamic power saving feature.
   .wea(wea)                        // WRITE_DATA_WIDTH_A-bit input: Write enable vector for port A input
                                    // data port dina. 1 bit wide when word-wide writes are used. In
                                    // byte-wide write configurations, each bit controls the writing one
                                    // byte of dina to address addra. For example, to synchronously write
                                    // only bits [15-8] of dina when WRITE_DATA_WIDTH_A is 32, wea would be
                                    // 4'b0010.

);
`else
fpga_dpsram #(
  .DATA_WIDTH(C_S_AXI_DATA_WIDTH),
  .ADDR_WIDTH(C_S_AXI_ADDR_WIDTH-ENTRY_OFFSET_WIDTH)
) x_fpga_ram(
  .clka(s_axi_aclk),
  .addra(addra[C_S_AXI_ADDR_WIDTH-1:ENTRY_OFFSET_WIDTH]),
  .dina(dina),
  .wea(wea),
  .clkb(s_axi_aclk),
  .addrb(addrb[C_S_AXI_ADDR_WIDTH-1:ENTRY_OFFSET_WIDTH]),
  .web({(C_S_AXI_DATA_WIDTH/8){1'b0}}),
  .doutb(doutb)
);
`endif

//For debug:
(* keep = "true" *)reg [31:0] axi_waddr_cnt;
(* keep = "true" *)reg [31:0] axi_wdata_cnt;
(* keep = "true" *)reg [31:0] axi_wlast_cnt;
(* keep = "true" *)reg [31:0] axi_wresp_cnt;
(* keep = "true" *)reg [31:0] axi_raddr_cnt;
(* keep = "true" *)reg [31:0] axi_rresp_cnt;

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        axi_waddr_cnt <= 0;
    else if(s_axi_awvalid && s_axi_awready)
        axi_waddr_cnt <= axi_waddr_cnt + 1;
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        axi_wdata_cnt <= 0;
    else if(s_axi_wvalid && s_axi_wready)
        axi_wdata_cnt <= axi_wdata_cnt + 1;
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        axi_wlast_cnt <= 0;
    else if(s_axi_wvalid && s_axi_wready && s_axi_wlast)
        axi_wlast_cnt <= axi_wlast_cnt + 1;
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        axi_wresp_cnt <= 0;
    else if(s_axi_bvalid && s_axi_bready)
        axi_wresp_cnt <= axi_wresp_cnt + 1;
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        axi_raddr_cnt <= 0;
    else if(s_axi_arvalid && s_axi_arready)
        axi_raddr_cnt <= axi_raddr_cnt + 1;
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        axi_rresp_cnt <= 0;
    else if(s_axi_rvalid && s_axi_rready)
        axi_rresp_cnt <= axi_rresp_cnt + 1;
end

endmodule
