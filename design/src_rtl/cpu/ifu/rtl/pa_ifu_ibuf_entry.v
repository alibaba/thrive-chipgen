/*Copyright 2020-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

// &ModuleBeg; @23
module pa_ifu_ibuf_entry(
  cp0_ifu_icg_en,
  cp0_yy_clk_en,
  cpurst_b,
  forever_cpuclk,
  ibuf_cpuclk,
  ibuf_create0_acc_err,
  ibuf_create0_halt_info,
  ibuf_create0_inst,
  ibuf_create0_pred_taken,
  ibuf_create1_acc_err,
  ibuf_create1_halt_info,
  ibuf_create1_inst,
  ibuf_create1_pred_taken,
  ibuf_create2_acc_err,
  ibuf_create2_halt_info,
  ibuf_create2_inst,
  ibuf_create2_pred_taken,
  ibuf_entry_acc_err,
  ibuf_entry_create0_data_en,
  ibuf_entry_create0_en,
  ibuf_entry_create1_data_en,
  ibuf_entry_create1_en,
  ibuf_entry_create2_data_en,
  ibuf_entry_create2_en,
  ibuf_entry_halt_info,
  ibuf_entry_inst,
  ibuf_entry_pred_taken,
  ibuf_entry_retire0_en,
  ibuf_entry_retire1_en,
  ibuf_entry_vld,
  ibuf_flush_en,
  pad_yy_icg_scan_en,
  vec_ibuf_warm_up
);

// &Ports; @24
input           cp0_ifu_icg_en;            
input           cp0_yy_clk_en;             
input           cpurst_b;                  
input           forever_cpuclk;            
input           ibuf_cpuclk;               
input           ibuf_create0_acc_err;      
input   [14:0]  ibuf_create0_halt_info;    
input   [15:0]  ibuf_create0_inst;         
input   [1 :0]  ibuf_create0_pred_taken;   
input           ibuf_create1_acc_err;      
input   [14:0]  ibuf_create1_halt_info;    
input   [15:0]  ibuf_create1_inst;         
input   [1 :0]  ibuf_create1_pred_taken;   
input           ibuf_create2_acc_err;      
input   [14:0]  ibuf_create2_halt_info;    
input   [15:0]  ibuf_create2_inst;         
input   [1 :0]  ibuf_create2_pred_taken;   
input           ibuf_entry_create0_data_en; 
input           ibuf_entry_create0_en;     
input           ibuf_entry_create1_data_en; 
input           ibuf_entry_create1_en;     
input           ibuf_entry_create2_data_en; 
input           ibuf_entry_create2_en;     
input           ibuf_entry_retire0_en;     
input           ibuf_entry_retire1_en;     
input           ibuf_flush_en;             
input           pad_yy_icg_scan_en;        
input           vec_ibuf_warm_up;          
output          ibuf_entry_acc_err;        
output  [14:0]  ibuf_entry_halt_info;      
output  [15:0]  ibuf_entry_inst;           
output  [1 :0]  ibuf_entry_pred_taken;     
output          ibuf_entry_vld;            

// &Regs; @25
reg             entry_acc_err;             
reg     [14:0]  entry_halt_info;           
reg     [15:0]  entry_inst;                
reg     [1 :0]  entry_pred_taken;          
reg             entry_vld;                 

// &Wires; @26
wire            cp0_ifu_icg_en;            
wire            cp0_yy_clk_en;             
wire            cpurst_b;                  
wire            entry_acc_err_upd;         
wire            entry_cpuclk;              
wire            entry_create;              
wire            entry_data_create;         
wire    [14:0]  entry_halt_info_upd;       
wire            entry_icg_create;          
wire            entry_icg_en;              
wire    [15:0]  entry_inst_upd;            
wire    [1 :0]  entry_pred_taken_upd;      
wire            entry_retire;              
wire            forever_cpuclk;            
wire            ibuf_cpuclk;               
wire            ibuf_create0_acc_err;      
wire    [14:0]  ibuf_create0_halt_info;    
wire    [15:0]  ibuf_create0_inst;         
wire    [1 :0]  ibuf_create0_pred_taken;   
wire            ibuf_create1_acc_err;      
wire    [14:0]  ibuf_create1_halt_info;    
wire    [15:0]  ibuf_create1_inst;         
wire    [1 :0]  ibuf_create1_pred_taken;   
wire            ibuf_create2_acc_err;      
wire    [14:0]  ibuf_create2_halt_info;    
wire    [15:0]  ibuf_create2_inst;         
wire    [1 :0]  ibuf_create2_pred_taken;   
wire            ibuf_entry_acc_err;        
wire            ibuf_entry_create0_data_en; 
wire            ibuf_entry_create0_en;     
wire            ibuf_entry_create1_data_en; 
wire            ibuf_entry_create1_en;     
wire            ibuf_entry_create2_data_en; 
wire            ibuf_entry_create2_en;     
wire    [14:0]  ibuf_entry_halt_info;      
wire    [15:0]  ibuf_entry_inst;           
wire    [1 :0]  ibuf_entry_pred_taken;     
wire            ibuf_entry_retire0_en;     
wire            ibuf_entry_retire1_en;     
wire            ibuf_entry_vld;            
wire            ibuf_flush_en;             
wire            pad_yy_icg_scan_en;        
wire            vec_ibuf_warm_up;          


//==========================================================
// Instruction Buffer Entry Module
// 1. Instance ICG cell 
// 2. Entry Content
//==========================================================

//------------------------------------------------
// 1. Instace ICG cell
//------------------------------------------------
assign entry_icg_create = ibuf_entry_create0_data_en 
                       | ibuf_entry_create1_data_en
                       | ibuf_entry_create2_data_en;
assign entry_icg_en = entry_icg_create | vec_ibuf_warm_up;
// &Instance("gated_clk_cell", "x_ibuf_data_icg_cell"); @41
gated_clk_cell  x_ibuf_data_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (entry_cpuclk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (entry_icg_en      ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @42
//          .external_en (1'b0), @43
//          .global_en   (cp0_yy_clk_en), @44
//          .module_en   (cp0_ifu_icg_en), @45
//          .local_en    (entry_icg_en), @46
//          .clk_out     (entry_cpuclk)); @47

//------------------------------------------------
// 2. Entry Content
// a. Entry Create and Retire Signal
// b. Entry Valid Signal
// c. Entry Instruction
//------------------------------------------------
// a. Entry Create and Retire Signal
assign entry_create  = ibuf_entry_create0_en | ibuf_entry_create1_en
                    | ibuf_entry_create2_en;
assign entry_data_create = ibuf_entry_create0_en 
                        | ibuf_entry_create1_en
                        | ibuf_entry_create2_en;
assign entry_retire  = ibuf_entry_retire0_en | ibuf_entry_retire1_en;

// b. Entry Valid Signal
always @(posedge ibuf_cpuclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    entry_vld <= 1'b0;
  else if(ibuf_flush_en)
    entry_vld <= 1'b0;
  else if(entry_create)
    entry_vld <= 1'b1;
  else if(entry_retire)
    entry_vld <= 1'b0;
  else
    entry_vld <= entry_vld;
end

// c. Entry Instruction
assign entry_inst_upd[15:0] = 
                     {16{ibuf_entry_create0_data_en}} & ibuf_create0_inst[15:0]
                   | {16{ibuf_entry_create1_data_en}} & ibuf_create1_inst[15:0] 
                   | {16{ibuf_entry_create2_data_en}} & ibuf_create2_inst[15:0];

always @(posedge entry_cpuclk)
begin
  if(entry_data_create | vec_ibuf_warm_up)
    entry_inst[15:0] <= entry_inst_upd[15:0];
  else
    entry_inst[15:0] <= entry_inst[15:0];
end

//==========================================================
// Instruction Predict Taken
//==========================================================
assign entry_pred_taken_upd[1:0] = 
                  {2{ibuf_entry_create0_data_en}} & ibuf_create0_pred_taken[1:0]
                | {2{ibuf_entry_create1_data_en}} & ibuf_create1_pred_taken[1:0]
                | {2{ibuf_entry_create2_data_en}} & ibuf_create2_pred_taken[1:0];

assign entry_halt_info_upd[`TDT_HINFO_WIDTH-1:0] = 
                  {`TDT_HINFO_WIDTH{ibuf_entry_create0_data_en}} & ibuf_create0_halt_info[`TDT_HINFO_WIDTH-1:0]
                | {`TDT_HINFO_WIDTH{ibuf_entry_create1_data_en}} & ibuf_create1_halt_info[`TDT_HINFO_WIDTH-1:0]
                | {`TDT_HINFO_WIDTH{ibuf_entry_create2_data_en}} & ibuf_create2_halt_info[`TDT_HINFO_WIDTH-1:0];

always @(posedge entry_cpuclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    entry_pred_taken[1:0] <= 2'b0;
  else if(entry_data_create)
    entry_pred_taken[1:0] <= entry_pred_taken_upd[1:0];
  else
    entry_pred_taken[1:0] <= entry_pred_taken[1:0];
end

always @(posedge entry_cpuclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    entry_halt_info[`TDT_HINFO_WIDTH-1:0] <= {`TDT_HINFO_WIDTH{1'b0}};
  else if(entry_data_create)
    entry_halt_info[`TDT_HINFO_WIDTH-1:0] <= entry_halt_info_upd[`TDT_HINFO_WIDTH-1:0];
  else
    entry_halt_info[`TDT_HINFO_WIDTH-1:0] <= entry_halt_info[`TDT_HINFO_WIDTH-1:0];
end

//==========================================================
// Instruction Bus Access Error
//==========================================================
assign entry_acc_err_upd = ibuf_entry_create0_data_en & ibuf_create0_acc_err
                        | ibuf_entry_create1_data_en & ibuf_create1_acc_err
                        | ibuf_entry_create2_data_en & ibuf_create2_acc_err;

always @(posedge entry_cpuclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    entry_acc_err <= 1'b0;
  else if(entry_data_create)
    entry_acc_err <= entry_acc_err_upd;
  else
    entry_acc_err <= entry_acc_err;
end

//==========================================================
// Rename for Output
//==========================================================

assign ibuf_entry_vld             = entry_vld;
assign ibuf_entry_inst[15:0]      = entry_inst[15:0];
assign ibuf_entry_pred_taken[1:0] = entry_pred_taken[1:0];
assign ibuf_entry_halt_info[`TDT_HINFO_WIDTH-1:0]  = entry_halt_info[`TDT_HINFO_WIDTH-1:0];
assign ibuf_entry_acc_err         = entry_acc_err;


// &ModuleEnd; @165
endmodule


