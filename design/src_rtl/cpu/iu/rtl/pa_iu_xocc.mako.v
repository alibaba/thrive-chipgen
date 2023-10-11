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

module ${rv.name}_pa_iu_xocc(
  cpurst_b,
  dsa_clk,
% for ind in range(rv.num_xocc):
  dsa_cmd_buffer_${ind},
% endfor
% for ind in range(rv.num_xocc):
  dsa_rsp_buffer_${ind},
% endfor
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
% for ind in range(rv.num_xocc):
input [${rv.rsp_width[ind]}-1:0] dsa_rsp_buffer_${ind};
% endfor
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
% for ind in range(rv.num_xocc):
output reg [${rv.cmd_width[ind]}-1:0] dsa_cmd_buffer_${ind};
% endfor
output  reg	[15 :0]  empty_cmd;            
output  reg	[15 :0]  full_rsp;             
output           iu_rtu_ex1_xocc_cmplt; 
output  [31 :0]  iu_rtu_ex1_xocc_data; 

% for ind in range(rv.num_xocc):
reg [${rv.cmd_width[ind]}-1:0] push_cmd_buffer_${ind};
% endfor
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
% for ind in range(rv.num_xocc):
wire [${rv.rsp_width[ind]}-1:0] pop_rsp_buffer_${ind};
% endfor
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
% for ind in range(rv.num_xocc):
reg [${rv.rsp_width[ind]}-1:0] dsa_rsp_buffer_${ind}_reg;
% endfor
reg  [15 :0]  rd_en_cmd_reg;            
reg  [15 :0]  wr_en_rsp_reg; 

% for ind in range(rv.num_xocc):
wire [${rv.cmd_width[ind]}-1:0] dsa_cmd_buffer_${ind}_net;
% endfor
wire  [15:0]   empty_cmd_net;
wire  [15:0]   full_rsp_net;

% for ind in range(rv.num_xocc):
always @(*) begin
    dsa_cmd_buffer_${ind} = dsa_cmd_buffer_${ind}_net;
    empty_cmd[${ind}] = empty_cmd_net[${ind}];
    full_rsp[${ind}] = full_rsp_net[${ind}];
    dsa_rsp_buffer_${ind}_reg = dsa_rsp_buffer_${ind};
    rd_en_cmd_reg[${ind}] = rd_en_cmd[${ind}];            
    wr_en_rsp_reg[${ind}] = wr_en_rsp[${ind}];
end
% endfor

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
% for ind in range(16):
    4'd${ind}:
    % if ind < rv.num_xocc:
      read_rsp_rd[31:0] = pop_rsp_buffer_${ind}[(field_id<<5)+31-:32];
    % else:
      read_rsp_rd[31:0] = 32'b0;
    % endif
% endfor
    default:
      read_rsp_rd[31:0] = 32'bx;
  endcase
end

// write_cmd
always @(posedge xocc_clk, negedge cpurst_b) begin
  if(~cpurst_b) begin
% for ind in range(rv.num_xocc):
    push_cmd_buffer_${ind} <= 'b0;
% endfor
  end
  else if(xocc_write_cmd_sel ) begin
    case(queue_id)
% for ind in range(rv.num_xocc):
      4'd${ind}:
        push_cmd_buffer_${ind}[(field_id<<5)+31-:32] <= xocc_rs1[31:0];
% endfor
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

% for ind in range(rv.num_xocc):
<%
    if rv.cmd_width[ind] == 32:
        fifo_cmd = "32x32"
    elif rv.cmd_width[ind] == 64:
        fifo_cmd = "32x2"
    elif rv.cmd_width[ind] == 96:
        fifo_cmd = "32x3"
    if rv.rsp_width[ind] == 32:
        fifo_rsp = "32x1"
    elif rv.rsp_width[ind] == 64:
        fifo_rsp = "32x2"
%>\
`ifdef XILINX_FPGA
async_cmd_fifo_${fifo_cmd} x_cmd_fifo_${ind} (
  .wr_clk(xocc_clk),
  .wr_rst(xocc_rst),
  .rd_clk(dsa_clk[${ind}]),
  .rd_rst(dsa_rst[${ind}]),
  .din(push_cmd_buffer_${ind}),
  .wr_en(wr_en_cmd[${ind}]),
  .rd_en(rd_en_cmd_reg[${ind}]),
  .dout(dsa_cmd_buffer_${ind}_net),
  .full(full_cmd[${ind}]),
  .almost_full(almost_full_cmd[${ind}]),
  .empty(empty_cmd_net[${ind}]),
  .almost_empty(almost_empty_cmd[${ind}])
);

async_rsp_fifo_${fifo_rsp} x_rsp_fifo_${ind} (
  .wr_clk(dsa_clk[${ind}]),
  .wr_rst(dsa_rst[${ind}]),
  .rd_clk(xocc_clk),
  .rd_rst(xocc_rst),
  .din(dsa_rsp_buffer_${ind}_reg),
  .wr_en(wr_en_rsp_reg[${ind}]),
  .rd_en(rd_en_rsp[${ind}]),
  .dout(pop_rsp_buffer_${ind}),
  .full(full_rsp_net[${ind}]),
  .almost_full(almost_full_rsp[${ind}]),
  .empty(empty_rsp[${ind}]),
  .almost_empty(almost_empty_rsp[${ind}])
);
`else
fwft_fifo #(
  .WIDTH(${rv.cmd_width[ind]}),
  .DEPTH(16)
) x_cmd_fifo_${ind}(
  .clk(xocc_clk),
  .rstn(cpurst_b),
  .rd_en(rd_en_cmd_reg[${ind}]),
  .wr_en(wr_en_cmd[${ind}]),
  .din(push_cmd_buffer_${ind}),
  .dout(dsa_cmd_buffer_${ind}_net),
  .full(full_cmd[${ind}]),
  .empty(empty_cmd_net[${ind}])
);

ori_fifo #(
  .WIDTH(${rv.rsp_width[ind]}),
  .DEPTH(16)
) x_rsp_fifo_${ind}(
  .clk(xocc_clk),
  .rstn(cpurst_b),
  .wr_data_i(dsa_rsp_buffer_${ind}_reg),
  .wr_en_i(wr_en_rsp_reg[${ind}]),
  .rd_en_i(rd_en_rsp[${ind}]),
  .rd_data_o(pop_rsp_buffer_${ind}),
  .full_o(full_rsp_net[${ind}]),
  .empty_o(empty_rsp[${ind}])
);
`endif

% endfor

assign full_cmd[15:${rv.num_xocc}] = 'h0;
assign almost_full_cmd[15:${rv.num_xocc}] = 'h0;

assign almost_empty_cmd[15:${rv.num_xocc}] = {(16-${rv.num_xocc}){1'b1}};
//assign full_rsp[15:${rv.num_xocc}] = 'h0;
assign almost_full_rsp[15:${rv.num_xocc}] = 'h0;
assign empty_rsp[15:${rv.num_xocc}] = {(16-${rv.num_xocc}){1'b1}};
assign almost_empty_rsp[15:${rv.num_xocc}] = {(16-${rv.num_xocc}){1'b1}};

always @(posedge xocc_clk or negedge cpurst_b) begin
  if(~cpurst_b) begin
	empty_cmd[15:${rv.num_xocc}] <= {(16-${rv.num_xocc}){1'b1}};
	full_rsp[15:${rv.num_xocc}] <= 'h0;
	end
    else begin
	empty_cmd[15:${rv.num_xocc}] <= {(16-${rv.num_xocc}){1'b1}};
	full_rsp[15:${rv.num_xocc}] <= 'h0;
    end
end

endmodule
