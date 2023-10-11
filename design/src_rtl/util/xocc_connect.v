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

// &ModuleBeg; @1
module xocc_connect(
  clk,
  m_xocc_cmd_buffer,
  m_xocc_cmd_empty,
  m_xocc_cmd_rd_en,
  m_xocc_rsp_full,
  m_xocc_rsp_wr_en,
  rstn,
  s_xocc_cmd_buffer,
  s_xocc_cmd_empty,
  s_xocc_cmd_rd_en,
  s_xocc_rsp_full,
  s_xocc_rsp_wr_en,
  xocc_m_rsp_buffer,
  xocc_s_rsp_buffer
);

// &Ports; @2
input           clk;                  
input   [31:0]  m_xocc_cmd_buffer;    
input           m_xocc_cmd_empty;     
input           m_xocc_rsp_full;      
input           rstn;                 
input   [31:0]  s_xocc_cmd_buffer;    
input           s_xocc_cmd_empty;     
input           s_xocc_rsp_full;      
output          m_xocc_cmd_rd_en;     
output          m_xocc_rsp_wr_en;     
output          s_xocc_cmd_rd_en;     
output          s_xocc_rsp_wr_en;     
output  [31:0]  xocc_m_rsp_buffer;    
output  [31:0]  xocc_s_rsp_buffer;    

// &Regs; @3
reg     [31:0]  cmd_reg;              
reg             m_xocc_cmd_rd_en;     
reg             m_xocc_cmd_rd_en_reg; 
reg             m_xocc_rsp_wr_en;     
reg     [31:0]  rsp_reg;              
reg             s_xocc_cmd_rd_en;     
reg             s_xocc_cmd_rd_en_reg; 
reg             s_xocc_rsp_wr_en;     
reg     [31:0]  xocc_m_rsp_buffer;    
reg     [31:0]  xocc_m_rsp_buffer_reg; 
reg     [31:0]  xocc_s_rsp_buffer;    
reg     [31:0]  xocc_s_rsp_buffer_reg; 

// &Wires; @4
wire            clk;                  
wire    [31:0]  m_xocc_cmd_buffer;    
wire            m_xocc_cmd_empty;     
wire            m_xocc_rsp_full;      
wire            rstn;                 
wire    [31:0]  s_xocc_cmd_buffer;    
wire            s_xocc_cmd_empty;     
wire            s_xocc_rsp_full;      


    parameter CMD_WIDTH = 32;
    parameter RSP_WIDTH = 32;

    always@(posedge clk or negedge rstn) begin
        if(!rstn) begin
            m_xocc_cmd_rd_en_reg <= 1'b0;
            cmd_reg[CMD_WIDTH-1:0] <={CMD_WIDTH{1'b0}};
        end
        else if(~m_xocc_cmd_empty & ~m_xocc_cmd_rd_en_reg) begin
            m_xocc_cmd_rd_en_reg <= 1'b1;
            cmd_reg[CMD_WIDTH-1:0] <= m_xocc_cmd_buffer[CMD_WIDTH-1:0];
        end else begin
            m_xocc_cmd_rd_en_reg <= 1'b0;
            cmd_reg[CMD_WIDTH-1:0] <= cmd_reg[CMD_WIDTH-1:0];
        end
    end

    always@(posedge clk or negedge rstn) begin
        if(!rstn) begin
            s_xocc_rsp_wr_en <= 1'b0;
            xocc_s_rsp_buffer_reg[CMD_WIDTH-1:0] <={RSP_WIDTH{1'b0}};
        end
        else if(~s_xocc_rsp_full & m_xocc_cmd_rd_en_reg) begin
            s_xocc_rsp_wr_en <= 1'b1;
            xocc_s_rsp_buffer_reg[CMD_WIDTH-1:0] <= cmd_reg[CMD_WIDTH-1:0];
        end else begin
            s_xocc_rsp_wr_en <= 1'b0;
            xocc_s_rsp_buffer_reg[CMD_WIDTH-1:0] <= xocc_s_rsp_buffer_reg[CMD_WIDTH-1:0];
        end
    end

    always@(posedge clk or negedge rstn) begin
        if(!rstn) begin
            s_xocc_cmd_rd_en_reg <= 1'b0;
            rsp_reg[CMD_WIDTH-1:0] <={RSP_WIDTH{1'b0}};
        end
        else if(~s_xocc_cmd_empty & ~s_xocc_cmd_rd_en_reg) begin
            s_xocc_cmd_rd_en_reg <= 1'b1;
            rsp_reg[CMD_WIDTH-1:0] <= s_xocc_cmd_buffer[CMD_WIDTH-1:0];
        end else begin
            s_xocc_cmd_rd_en_reg <= 1'b0;
            rsp_reg[CMD_WIDTH-1:0] <= rsp_reg[CMD_WIDTH-1:0];
        end
    end

    always@(posedge clk or negedge rstn) begin
        if(!rstn) begin
            m_xocc_rsp_wr_en <= 1'b0;
            xocc_m_rsp_buffer_reg[CMD_WIDTH-1:0] <={RSP_WIDTH{1'b0}};
        end
        else if(~m_xocc_rsp_full & s_xocc_cmd_rd_en_reg) begin
            m_xocc_rsp_wr_en <= 1'b1;
            xocc_m_rsp_buffer_reg[CMD_WIDTH-1:0] <= rsp_reg[CMD_WIDTH-1:0];
        end else begin
            m_xocc_rsp_wr_en <= 1'b0;
            xocc_m_rsp_buffer_reg[CMD_WIDTH-1:0] <= xocc_m_rsp_buffer_reg[CMD_WIDTH-1:0];
        end
    end

    assign xocc_s_rsp_buffer[RSP_WIDTH-1:0] = xocc_s_rsp_buffer_reg[RSP_WIDTH-1:0];
    assign xocc_m_rsp_buffer[RSP_WIDTH-1:0] = xocc_m_rsp_buffer_reg[RSP_WIDTH-1:0];
    assign m_xocc_cmd_rd_en = m_xocc_cmd_rd_en_reg;
    assign s_xocc_cmd_rd_en = s_xocc_cmd_rd_en_reg;

// &ModuleEnd @70
endmodule


