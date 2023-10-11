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

module regular_2_pa_iu_xocc(
  cpurst_b,
  dsa_clk,
  dsa_cmd_buffer_0,
  dsa_cmd_buffer_1,
  dsa_rsp_buffer_0,
  dsa_rsp_buffer_1,
  dsa_rst,
  empty_cmd,
  forever_cpuclk,
  full_rsp,
  idu_iu_ex1_inst_vld,
  idu_iu_ex1_xocc_sel,
  idu_xocc_ex1_func,
  idu_xocc_ex1_rs1,
  idu_xocc_ex1_rs2,
  idu_xocc_ex1_sub_func,
  iu_rtu_ex1_xocc_cmplt,
  iu_rtu_ex1_xocc_data,
  rd_en_cmd,
  wr_en_rsp
);

input            cpurst_b;             
input   [15 :0]  dsa_clk;    
input [32-1:0] dsa_rsp_buffer_0;
input [32-1:0] dsa_rsp_buffer_1;
input   [15 :0]  dsa_rst;              
input            forever_cpuclk;       
input            idu_iu_ex1_inst_vld;  
input            idu_iu_ex1_xocc_sel;  
input   [4  :0]  idu_xocc_ex1_func;    
input   [31 :0]  idu_xocc_ex1_rs1;     
input   [31 :0]  idu_xocc_ex1_rs2;     
input   [4  :0]  idu_xocc_ex1_sub_func; 
input   [15 :0]  rd_en_cmd;            
input   [15 :0]  wr_en_rsp;            
output reg [32-1:0] dsa_cmd_buffer_0;
output reg [96-1:0] dsa_cmd_buffer_1;
output  reg	[15 :0]  empty_cmd;            
output  reg	[15 :0]  full_rsp;             
output           iu_rtu_ex1_xocc_cmplt; 
output  [31 :0]  iu_rtu_ex1_xocc_data; 

reg [32-1:0] push_cmd_buffer_0;
reg [96-1:0] push_cmd_buffer_1;
reg     [15 :0]  rd_en_rsp;            
reg     [31 :0]  read_rsp_rd;          
reg     [15 :0]  wr_en_cmd;            

wire             cpurst_b;             
wire     [15 :0]  empty_rsp;            
wire    [7  :0]  field_id;             
wire             forever_cpuclk;       
wire	[15 :0]  full_cmd;             
wire             idu_iu_ex1_inst_vld;  
wire             idu_iu_ex1_xocc_sel;  
wire    [4  :0]  idu_xocc_ex1_func;    
wire    [31 :0]  idu_xocc_ex1_rs1;     
wire    [31 :0]  idu_xocc_ex1_rs2;     
wire    [4  :0]  idu_xocc_ex1_sub_func; 
wire             iu_rtu_ex1_xocc_cmplt; 
wire    [31 :0]  iu_rtu_ex1_xocc_data; 
wire    [31 :0]  pop_rdy_rd;           
wire [32-1:0] pop_rsp_buffer_0;
wire [32-1:0] pop_rsp_buffer_1;
wire    [31 :0]  pop_rsp_rd;           
wire    [31 :0]  push_cmd_rd;          
wire    [31 :0]  push_rdy_rd;          
wire    [3  :0]  queue_id;             
wire    [31 :0]  write_cmd_rd;         
wire             xocc_clk;             
wire             xocc_dly_sel;         
wire             xocc_norm_sel;        
wire             xocc_pop_rdy_sel;     
wire             xocc_pop_rsp_sel;     
wire             xocc_push_cmd_sel;    
wire             xocc_push_rdy_sel;    
wire             xocc_read_rsp_sel;    
wire    [31 :0]  xocc_res;             
wire    [31 :0]  xocc_rs1;             
wire    [31 :0]  xocc_rs2;             
wire             xocc_rst;             
wire             xocc_rst_n;           
wire    [4  :0]  xocc_sel;             
wire             xocc_write_cmd_sel;   


parameter QUEUE_WIDTH = 4; // bit width
parameter FIELD_WIDTH = 8; // bit width
reg [32-1:0] dsa_rsp_buffer_0_reg;
reg [32-1:0] dsa_rsp_buffer_1_reg;
reg  [15 :0]  rd_en_cmd_reg;            
reg  [15 :0]  wr_en_rsp_reg; 

wire [32-1:0] dsa_cmd_buffer_0_net;
wire [96-1:0] dsa_cmd_buffer_1_net;
wire  [15:0]   empty_cmd_net;
wire  [15:0]   full_rsp_net;

always @(*) begin
    dsa_cmd_buffer_0 = dsa_cmd_buffer_0_net;
    empty_cmd[0] = empty_cmd_net[0];
    full_rsp[0] = full_rsp_net[0];
    dsa_rsp_buffer_0_reg = dsa_rsp_buffer_0;
    rd_en_cmd_reg[0] = rd_en_cmd[0];            
    wr_en_rsp_reg[0] = wr_en_rsp[0];
end
always @(*) begin
    dsa_cmd_buffer_1 = dsa_cmd_buffer_1_net;
    empty_cmd[1] = empty_cmd_net[1];
    full_rsp[1] = full_rsp_net[1];
    dsa_rsp_buffer_1_reg = dsa_rsp_buffer_1;
    rd_en_cmd_reg[1] = rd_en_cmd[1];            
    wr_en_rsp_reg[1] = wr_en_rsp[1];
end

assign xocc_sel[4:0]            = idu_xocc_ex1_func[4:0] & {5{idu_iu_ex1_xocc_sel}};
assign xocc_rs1[31:0]           = idu_xocc_ex1_rs1[31:0];
assign xocc_rs2[31:0]           = idu_xocc_ex1_rs2[31:0];
assign queue_id[QUEUE_WIDTH-1:0]       = xocc_rs2[QUEUE_WIDTH-1:0];
assign field_id[FIELD_WIDTH-1:0]       = xocc_rs2[11:QUEUE_WIDTH];

assign xocc_norm_sel = xocc_sel[0];  
assign xocc_dly_sel = xocc_sel[1] & idu_iu_ex1_inst_vld;  

assign xocc_push_rdy_sel    = xocc_norm_sel & idu_xocc_ex1_sub_func[0];
assign xocc_pop_rdy_sel     = xocc_norm_sel & idu_xocc_ex1_sub_func[1];
assign xocc_read_rsp_sel    = xocc_norm_sel & idu_xocc_ex1_sub_func[2];
assign xocc_push_cmd_sel    = xocc_dly_sel & idu_xocc_ex1_sub_func[0];
assign xocc_write_cmd_sel   = xocc_dly_sel & idu_xocc_ex1_sub_func[1];
assign xocc_pop_rsp_sel     = xocc_dly_sel & idu_xocc_ex1_sub_func[2];

assign xocc_clk = forever_cpuclk;
assign xocc_rst_n = cpurst_b;
assign xocc_rst = ~cpurst_b;

// push_rdy
assign push_rdy_rd[31:0] = {31'b0,~full_cmd[queue_id]};

// pop_rdy
assign pop_rdy_rd[31:0] = {31'b0,~empty_rsp[queue_id]};

// read_rsp
always @(*) begin
  case(queue_id)
    4'd0:
      read_rsp_rd[31:0] = pop_rsp_buffer_0[(field_id<<5)+31-:32];
    4'd1:
      read_rsp_rd[31:0] = pop_rsp_buffer_1[(field_id<<5)+31-:32];
    4'd2:
      read_rsp_rd[31:0] = 32'b0;
    4'd3:
      read_rsp_rd[31:0] = 32'b0;
    4'd4:
      read_rsp_rd[31:0] = 32'b0;
    4'd5:
      read_rsp_rd[31:0] = 32'b0;
    4'd6:
      read_rsp_rd[31:0] = 32'b0;
    4'd7:
      read_rsp_rd[31:0] = 32'b0;
    4'd8:
      read_rsp_rd[31:0] = 32'b0;
    4'd9:
      read_rsp_rd[31:0] = 32'b0;
    4'd10:
      read_rsp_rd[31:0] = 32'b0;
    4'd11:
      read_rsp_rd[31:0] = 32'b0;
    4'd12:
      read_rsp_rd[31:0] = 32'b0;
    4'd13:
      read_rsp_rd[31:0] = 32'b0;
    4'd14:
      read_rsp_rd[31:0] = 32'b0;
    4'd15:
      read_rsp_rd[31:0] = 32'b0;
    default:
      read_rsp_rd[31:0] = 32'bx;
  endcase
end

// write_cmd
always @(posedge xocc_clk, negedge cpurst_b) begin
  if(~cpurst_b) begin
    push_cmd_buffer_0 <= 'b0;
    push_cmd_buffer_1 <= 'b0;
  end
  else if(xocc_write_cmd_sel ) begin
    case(queue_id)
      4'd0:
        push_cmd_buffer_0[(field_id<<5)+31-:32] <= xocc_rs1[31:0];
      4'd1:
        push_cmd_buffer_1[(field_id<<5)+31-:32] <= xocc_rs1[31:0];
    endcase
  end
end
assign write_cmd_rd[31:0] = 32'b1;

// push_cmd
always @(*) begin
  if(xocc_push_cmd_sel) begin
    case(queue_id)
      4'd0:  wr_en_cmd[15:0] = ~full_cmd[15:0] & 16'h1;
      4'd1:  wr_en_cmd[15:0] = ~full_cmd[15:0] & 16'h2;
      4'd2:  wr_en_cmd[15:0] = ~full_cmd[15:0] & 16'h4;
      4'd3:  wr_en_cmd[15:0] = ~full_cmd[15:0] & 16'h8;
      4'd4:  wr_en_cmd[15:0] = ~full_cmd[15:0] & 16'h10;
      4'd5:  wr_en_cmd[15:0] = ~full_cmd[15:0] & 16'h20;
      4'd6:  wr_en_cmd[15:0] = ~full_cmd[15:0] & 16'h40;
      4'd7:  wr_en_cmd[15:0] = ~full_cmd[15:0] & 16'h80;
      4'd8:  wr_en_cmd[15:0] = ~full_cmd[15:0] & 16'h100;
      4'd9:  wr_en_cmd[15:0] = ~full_cmd[15:0] & 16'h200;
      4'd10: wr_en_cmd[15:0] = ~full_cmd[15:0] & 16'h400;
      4'd11: wr_en_cmd[15:0] = ~full_cmd[15:0] & 16'h800;
      4'd12: wr_en_cmd[15:0] = ~full_cmd[15:0] & 16'h1000;
      4'd13: wr_en_cmd[15:0] = ~full_cmd[15:0] & 16'h2000;
      4'd14: wr_en_cmd[15:0] = ~full_cmd[15:0] & 16'h4000;
      4'd15: wr_en_cmd[15:0] = ~full_cmd[15:0] & 16'h8000;
    endcase
  end
  else begin
    wr_en_cmd[15:0] = 16'h0;
  end
end
assign push_cmd_rd[31:0] = {31'b0, ~full_cmd[queue_id]};

// pop_rsp
always @(*) begin
  if(xocc_pop_rsp_sel) begin
    case(queue_id)
      4'd0:  rd_en_rsp[15:0] = ~empty_rsp[15:0] & 16'h1;
      4'd1:  rd_en_rsp[15:0] = ~empty_rsp[15:0] & 16'h2;
      4'd2:  rd_en_rsp[15:0] = ~empty_rsp[15:0] & 16'h4;
      4'd3:  rd_en_rsp[15:0] = ~empty_rsp[15:0] & 16'h8;
      4'd4:  rd_en_rsp[15:0] = ~empty_rsp[15:0] & 16'h10;
      4'd5:  rd_en_rsp[15:0] = ~empty_rsp[15:0] & 16'h20;
      4'd6:  rd_en_rsp[15:0] = ~empty_rsp[15:0] & 16'h40;
      4'd7:  rd_en_rsp[15:0] = ~empty_rsp[15:0] & 16'h80;
      4'd8:  rd_en_rsp[15:0] = ~empty_rsp[15:0] & 16'h100;
      4'd9:  rd_en_rsp[15:0] = ~empty_rsp[15:0] & 16'h200;
      4'd10: rd_en_rsp[15:0] = ~empty_rsp[15:0] & 16'h400;
      4'd11: rd_en_rsp[15:0] = ~empty_rsp[15:0] & 16'h800;
      4'd12: rd_en_rsp[15:0] = ~empty_rsp[15:0] & 16'h1000;
      4'd13: rd_en_rsp[15:0] = ~empty_rsp[15:0] & 16'h2000;
      4'd14: rd_en_rsp[15:0] = ~empty_rsp[15:0] & 16'h4000;
      4'd15: rd_en_rsp[15:0] = ~empty_rsp[15:0] & 16'h8000;
    endcase
  end
  else begin
    rd_en_rsp[15:0] = 16'h0;
  end
end
assign pop_rsp_rd[31:0] = {31'b0, ~empty_rsp[queue_id]};

// xocc rd
assign xocc_res = ({32{xocc_push_rdy_sel}} & push_rdy_rd[31:0]) |
                  ({32{xocc_pop_rdy_sel}} & pop_rdy_rd[31:0]) |
                  ({32{xocc_write_cmd_sel}} & write_cmd_rd[31:0]) |
                  ({32{xocc_read_rsp_sel}} & read_rsp_rd[31:0]) |
                  ({32{xocc_push_cmd_sel}} & push_cmd_rd[31:0]) |
                  ({32{xocc_pop_rsp_sel}} & pop_rsp_rd[31:0]);

//==========================================================
//                   Output for RTU
//==========================================================
assign iu_rtu_ex1_xocc_cmplt      = idu_iu_ex1_inst_vld && |xocc_sel;
assign iu_rtu_ex1_xocc_data[31:0] = xocc_res[31:0];

wire [15:0]	almost_full_cmd;
wire [15:0]	almost_empty_cmd;
wire [15:0]	almost_full_rsp;
wire [15:0]	almost_empty_rsp;

`ifdef XILINX_FPGA
async_cmd_fifo_32x32 x_cmd_fifo_0 (
  .wr_clk(xocc_clk),
  .wr_rst(xocc_rst),
  .rd_clk(dsa_clk[0]),
  .rd_rst(dsa_rst[0]),
  .din(push_cmd_buffer_0),
  .wr_en(wr_en_cmd[0]),
  .rd_en(rd_en_cmd_reg[0]),
  .dout(dsa_cmd_buffer_0_net),
  .full(full_cmd[0]),
  .almost_full(almost_full_cmd[0]),
  .empty(empty_cmd_net[0]),
  .almost_empty(almost_empty_cmd[0])
);

async_rsp_fifo_32x1 x_rsp_fifo_0 (
  .wr_clk(dsa_clk[0]),
  .wr_rst(dsa_rst[0]),
  .rd_clk(xocc_clk),
  .rd_rst(xocc_rst),
  .din(dsa_rsp_buffer_0_reg),
  .wr_en(wr_en_rsp_reg[0]),
  .rd_en(rd_en_rsp[0]),
  .dout(pop_rsp_buffer_0),
  .full(full_rsp_net[0]),
  .almost_full(almost_full_rsp[0]),
  .empty(empty_rsp[0]),
  .almost_empty(almost_empty_rsp[0])
);
`else
fwft_fifo #(
  .WIDTH(32),
  .DEPTH(16)
) x_cmd_fifo_0(
  .clk(xocc_clk),
  .rstn(cpurst_b),
  .rd_en(rd_en_cmd_reg[0]),
  .wr_en(wr_en_cmd[0]),
  .din(push_cmd_buffer_0),
  .dout(dsa_cmd_buffer_0_net),
  .full(full_cmd[0]),
  .empty(empty_cmd_net[0])
);

ori_fifo #(
  .WIDTH(32),
  .DEPTH(16)
) x_rsp_fifo_0(
  .clk(xocc_clk),
  .rstn(cpurst_b),
  .wr_data_i(dsa_rsp_buffer_0_reg),
  .wr_en_i(wr_en_rsp_reg[0]),
  .rd_en_i(rd_en_rsp[0]),
  .rd_data_o(pop_rsp_buffer_0),
  .full_o(full_rsp_net[0]),
  .empty_o(empty_rsp[0])
);
`endif

`ifdef XILINX_FPGA
async_cmd_fifo_32x3 x_cmd_fifo_1 (
  .wr_clk(xocc_clk),
  .wr_rst(xocc_rst),
  .rd_clk(dsa_clk[1]),
  .rd_rst(dsa_rst[1]),
  .din(push_cmd_buffer_1),
  .wr_en(wr_en_cmd[1]),
  .rd_en(rd_en_cmd_reg[1]),
  .dout(dsa_cmd_buffer_1_net),
  .full(full_cmd[1]),
  .almost_full(almost_full_cmd[1]),
  .empty(empty_cmd_net[1]),
  .almost_empty(almost_empty_cmd[1])
);

async_rsp_fifo_32x1 x_rsp_fifo_1 (
  .wr_clk(dsa_clk[1]),
  .wr_rst(dsa_rst[1]),
  .rd_clk(xocc_clk),
  .rd_rst(xocc_rst),
  .din(dsa_rsp_buffer_1_reg),
  .wr_en(wr_en_rsp_reg[1]),
  .rd_en(rd_en_rsp[1]),
  .dout(pop_rsp_buffer_1),
  .full(full_rsp_net[1]),
  .almost_full(almost_full_rsp[1]),
  .empty(empty_rsp[1]),
  .almost_empty(almost_empty_rsp[1])
);
`else
fwft_fifo #(
  .WIDTH(96),
  .DEPTH(16)
) x_cmd_fifo_1(
  .clk(xocc_clk),
  .rstn(cpurst_b),
  .rd_en(rd_en_cmd_reg[1]),
  .wr_en(wr_en_cmd[1]),
  .din(push_cmd_buffer_1),
  .dout(dsa_cmd_buffer_1_net),
  .full(full_cmd[1]),
  .empty(empty_cmd_net[1])
);

ori_fifo #(
  .WIDTH(32),
  .DEPTH(16)
) x_rsp_fifo_1(
  .clk(xocc_clk),
  .rstn(cpurst_b),
  .wr_data_i(dsa_rsp_buffer_1_reg),
  .wr_en_i(wr_en_rsp_reg[1]),
  .rd_en_i(rd_en_rsp[1]),
  .rd_data_o(pop_rsp_buffer_1),
  .full_o(full_rsp_net[1]),
  .empty_o(empty_rsp[1])
);
`endif


assign full_cmd[15:2] = 'h0;
assign almost_full_cmd[15:2] = 'h0;

assign almost_empty_cmd[15:2] = {(16-2){1'b1}};
//assign full_rsp[15:2] = 'h0;
assign almost_full_rsp[15:2] = 'h0;
assign empty_rsp[15:2] = {(16-2){1'b1}};
assign almost_empty_rsp[15:2] = {(16-2){1'b1}};

always @(posedge xocc_clk or negedge cpurst_b) begin
  if(~cpurst_b) begin
	empty_cmd[15:2] <= {(16-2){1'b1}};
	full_rsp[15:2] <= 'h0;
	end
    else begin
	empty_cmd[15:2] <= {(16-2){1'b1}};
	full_rsp[15:2] <= 'h0;
    end
end

endmodule
