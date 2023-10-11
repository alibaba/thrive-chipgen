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

// &ModuleBeg; @24
module pa_ifu_ibuf(
  cp0_ifu_icg_en,
  cp0_yy_clk_en,
  cpurst_b,
  ctrl_ibuf_pop_en,
  dtu_ifu_debug_inst,
  dtu_ifu_debug_inst_vld,
  dtu_ifu_halt_info_vld,
  forever_cpuclk,
  ibuf_ctrl_inst_fetch,
  ibuf_id_pred_hungry,
  ibuf_ipack_stall,
  ibuf_pred_stall,
  ibuf_top_id_stall,
  ibuf_top_vld_num,
  id_pred_ibuf_br_taken0,
  id_pred_ibuf_br_taken1,
  id_pred_ibuf_chgflw_vld0,
  id_pred_ibuf_halt_info0,
  id_pred_ibuf_halt_info1,
  idu_ifu_id_stall,
  idu_ifu_tail_vld,
  idu_ifu_tail_vld_gate,
  ifetch_ibuf_idle,
  ifetch_xx_not_busy,
  ifu_idu_id_expt_high,
  ifu_idu_id_expt_vld,
  ifu_idu_id_halt_info,
  ifu_idu_id_inst,
  ifu_idu_id_inst_vld,
  ifu_idu_id_pred_taken,
  ipack_ibuf_acc_err,
  ipack_ibuf_inst,
  ipack_ibuf_inst_all,
  ipack_ibuf_inst_empty,
  ipack_ibuf_inst_full,
  ipack_ibuf_inst_one,
  ipack_ibuf_inst_one_raw,
  ipack_ibuf_inst_two,
  ipack_ibuf_inst_vld,
  ipack_ibuf_inst_vld_raw,
  pad_yy_icg_scan_en,
  pcgen_ibuf_chgflw_vld,
  rtu_ifu_flush_fe,
  rtu_yy_xx_dbgon,
  rtu_yy_xx_expt_vld,
  rtu_yy_xx_tail_int_vld,
  vec_ibuf_warm_up
);

// &Ports; @25
input           cp0_ifu_icg_en;              
input           cp0_yy_clk_en;               
input           cpurst_b;                    
input           ctrl_ibuf_pop_en;            
input   [31:0]  dtu_ifu_debug_inst;          
input           dtu_ifu_debug_inst_vld;      
input           dtu_ifu_halt_info_vld;       
input           forever_cpuclk;              
input   [1 :0]  id_pred_ibuf_br_taken0;      
input   [1 :0]  id_pred_ibuf_br_taken1;      
input           id_pred_ibuf_chgflw_vld0;    
input   [14:0]  id_pred_ibuf_halt_info0;     
input   [14:0]  id_pred_ibuf_halt_info1;     
input           idu_ifu_id_stall;            
input           idu_ifu_tail_vld;            
input           idu_ifu_tail_vld_gate;       
input           ifetch_ibuf_idle;            
input           ifetch_xx_not_busy;          
input   [2 :0]  ipack_ibuf_acc_err;          
input   [47:0]  ipack_ibuf_inst;             
input           ipack_ibuf_inst_all;         
input           ipack_ibuf_inst_empty;       
input           ipack_ibuf_inst_full;        
input           ipack_ibuf_inst_one;         
input           ipack_ibuf_inst_one_raw;     
input           ipack_ibuf_inst_two;         
input           ipack_ibuf_inst_vld;         
input           ipack_ibuf_inst_vld_raw;     
input           pad_yy_icg_scan_en;          
input           pcgen_ibuf_chgflw_vld;       
input           rtu_ifu_flush_fe;            
input           rtu_yy_xx_dbgon;             
input           rtu_yy_xx_expt_vld;          
input           rtu_yy_xx_tail_int_vld;      
input           vec_ibuf_warm_up;            
output          ibuf_ctrl_inst_fetch;        
output          ibuf_id_pred_hungry;         
output          ibuf_ipack_stall;            
output          ibuf_pred_stall;             
output          ibuf_top_id_stall;           
output  [2 :0]  ibuf_top_vld_num;            
output          ifu_idu_id_expt_high;        
output          ifu_idu_id_expt_vld;         
output  [14:0]  ifu_idu_id_halt_info;        
output  [31:0]  ifu_idu_id_inst;             
output          ifu_idu_id_inst_vld;         
output  [1 :0]  ifu_idu_id_pred_taken;       

// &Regs; @26
reg     [5 :0]  pop0;                        
reg             pop0_acc_err;                
reg     [14:0]  pop0_halt_info;              
reg     [15:0]  pop0_inst;                   
reg     [1 :0]  pop0_pred_taken;             
reg     [5 :0]  pop0_shift;                  
reg             pop0_vld;                    
reg             pop1_acc_err;                
reg     [14:0]  pop1_halt_info;              
reg     [15:0]  pop1_inst;                   
reg     [1 :0]  pop1_pred_taken;             
reg             pop1_vld;                    
reg     [5 :0]  push0;                       
reg     [5 :0]  push0_shift;                 

// &Wires; @27
wire            cp0_ifu_icg_en;              
wire            cp0_yy_clk_en;               
wire            cpurst_b;                    
wire            ctrl_ibuf_pop_en;            
wire            dtu_create0_en;              
wire            dtu_create1_en;              
wire    [31:0]  dtu_ifu_debug_inst;          
wire            dtu_ifu_debug_inst_vld;      
wire            dtu_ifu_halt_info_vld;       
wire            entry0_acc_err;              
wire            entry0_create0_data_en;      
wire            entry0_create0_en;           
wire            entry0_create1_data_en;      
wire            entry0_create1_en;           
wire            entry0_create2_data_en;      
wire            entry0_create2_en;           
wire    [14:0]  entry0_halt_info;            
wire    [15:0]  entry0_inst;                 
wire    [1 :0]  entry0_pred_taken;           
wire            entry0_retire0_en;           
wire            entry0_retire1_en;           
wire            entry0_vld;                  
wire            entry1_acc_err;              
wire            entry1_create0_data_en;      
wire            entry1_create0_en;           
wire            entry1_create1_data_en;      
wire            entry1_create1_en;           
wire            entry1_create2_data_en;      
wire            entry1_create2_en;           
wire    [14:0]  entry1_halt_info;            
wire    [15:0]  entry1_inst;                 
wire    [1 :0]  entry1_pred_taken;           
wire            entry1_retire0_en;           
wire            entry1_retire1_en;           
wire            entry1_vld;                  
wire            entry2_acc_err;              
wire            entry2_create0_data_en;      
wire            entry2_create0_en;           
wire            entry2_create1_data_en;      
wire            entry2_create1_en;           
wire            entry2_create2_data_en;      
wire            entry2_create2_en;           
wire    [14:0]  entry2_halt_info;            
wire    [15:0]  entry2_inst;                 
wire    [1 :0]  entry2_pred_taken;           
wire            entry2_retire0_en;           
wire            entry2_retire1_en;           
wire            entry2_vld;                  
wire            entry3_acc_err;              
wire            entry3_create0_data_en;      
wire            entry3_create0_en;           
wire            entry3_create1_data_en;      
wire            entry3_create1_en;           
wire            entry3_create2_data_en;      
wire            entry3_create2_en;           
wire    [14:0]  entry3_halt_info;            
wire    [15:0]  entry3_inst;                 
wire    [1 :0]  entry3_pred_taken;           
wire            entry3_retire0_en;           
wire            entry3_retire1_en;           
wire            entry3_vld;                  
wire            entry4_acc_err;              
wire            entry4_create0_data_en;      
wire            entry4_create0_en;           
wire            entry4_create1_data_en;      
wire            entry4_create1_en;           
wire            entry4_create2_data_en;      
wire            entry4_create2_en;           
wire    [14:0]  entry4_halt_info;            
wire    [15:0]  entry4_inst;                 
wire    [1 :0]  entry4_pred_taken;           
wire            entry4_retire0_en;           
wire            entry4_retire1_en;           
wire            entry4_vld;                  
wire            entry5_acc_err;              
wire            entry5_create0_data_en;      
wire            entry5_create0_en;           
wire            entry5_create1_data_en;      
wire            entry5_create1_en;           
wire            entry5_create2_data_en;      
wire            entry5_create2_en;           
wire    [14:0]  entry5_halt_info;            
wire    [15:0]  entry5_inst;                 
wire    [1 :0]  entry5_pred_taken;           
wire            entry5_retire0_en;           
wire            entry5_retire1_en;           
wire            entry5_vld;                  
wire            forever_cpuclk;              
wire            ibuf_cpuclk;                 
wire            ibuf_create0_acc_err;        
wire            ibuf_create0_data_en;        
wire            ibuf_create0_en;             
wire    [14:0]  ibuf_create0_halt_info;      
wire    [15:0]  ibuf_create0_inst;           
wire    [1 :0]  ibuf_create0_pred_taken;     
wire            ibuf_create1_acc_err;        
wire            ibuf_create1_data_en;        
wire            ibuf_create1_en;             
wire    [14:0]  ibuf_create1_halt_info;      
wire    [15:0]  ibuf_create1_inst;           
wire    [1 :0]  ibuf_create1_pred_taken;     
wire            ibuf_create2_acc_err;        
wire            ibuf_create2_data_en;        
wire            ibuf_create2_en;             
wire    [14:0]  ibuf_create2_halt_info;      
wire    [15:0]  ibuf_create2_inst;           
wire    [1 :0]  ibuf_create2_pred_taken;     
wire            ibuf_ctrl_inst_fetch;        
wire            ibuf_empty;                  
wire            ibuf_entry_stall;            
wire            ibuf_fetch_empty;            
wire            ibuf_fetch_five;             
wire            ibuf_fetch_four;             
wire            ibuf_fetch_three;            
wire            ibuf_fetch_two;              
wire            ibuf_five_avalbe;            
wire            ibuf_flush_en;               
wire            ibuf_flush_en_gate;          
wire            ibuf_four_avalbe;            
wire            ibuf_full;                   
wire            ibuf_icg_en;                 
wire            ibuf_id_pred_hungry;         
wire            ibuf_inst32;                 
wire            ibuf_inst_32_vld;            
wire            ibuf_inst_fetch;             
wire            ibuf_ipack_stall;            
wire            ibuf_one_avalbe;             
wire            ibuf_pred_stall;             
wire            ibuf_retire0_en;             
wire            ibuf_retire0_en_vld;         
wire            ibuf_retire1_en;             
wire            ibuf_stall;                  
wire            ibuf_three_avalbe;           
wire            ibuf_top_id_stall;           
wire    [2 :0]  ibuf_top_vld_num;            
wire            ibuf_two_avalbe;             
wire    [2 :0]  ibuf_vld_num;                
wire    [1 :0]  id_pred_ibuf_br_taken0;      
wire    [1 :0]  id_pred_ibuf_br_taken1;      
wire            id_pred_ibuf_chgflw_vld0;    
wire    [14:0]  id_pred_ibuf_halt_info0;     
wire    [14:0]  id_pred_ibuf_halt_info1;     
wire            idu_ifu_id_stall;            
wire            idu_ifu_tail_vld;            
wire            idu_ifu_tail_vld_gate;       
wire            ifetch_ibuf_idle;            
wire            ifetch_xx_not_busy;          
wire            ifu_idu_id_expt_high;        
wire            ifu_idu_id_expt_vld;         
wire    [14:0]  ifu_idu_id_halt_info;        
wire    [31:0]  ifu_idu_id_inst;             
wire            ifu_idu_id_inst_vld;         
wire    [1 :0]  ifu_idu_id_pred_taken;       
wire            ipack_bypass_vld;            
wire            ipack_create0_data_en;       
wire            ipack_create0_en;            
wire            ipack_create1_data_en;       
wire            ipack_create1_en;            
wire            ipack_expt_high;             
wire    [2 :0]  ipack_ibuf_acc_err;          
wire    [47:0]  ipack_ibuf_inst;             
wire            ipack_ibuf_inst_all;         
wire            ipack_ibuf_inst_empty;       
wire            ipack_ibuf_inst_full;        
wire            ipack_ibuf_inst_one;         
wire            ipack_ibuf_inst_one_raw;     
wire            ipack_ibuf_inst_two;         
wire            ipack_ibuf_inst_vld;         
wire            ipack_ibuf_inst_vld_raw;     
wire            ipack_inst_32;               
wire            pad_yy_icg_scan_en;          
wire            pcgen_ibuf_chgflw_vld;       
wire            pop0_inst_32;                
wire    [5 :0]  pop1;                        
wire            pop_entry0_acc_err;          
wire            pop_entry0_create_acc_err;   
wire            pop_entry0_create_data_en;   
wire            pop_entry0_create_en;        
wire    [14:0]  pop_entry0_create_halt_info; 
wire    [15:0]  pop_entry0_create_inst;      
wire    [1 :0]  pop_entry0_create_pred_taken; 
wire    [14:0]  pop_entry0_halt_info;        
wire    [15:0]  pop_entry0_inst;             
wire    [1 :0]  pop_entry0_pred_taken;       
wire            pop_entry0_retire_en;        
wire            pop_entry0_vld;              
wire            pop_entry1_acc_err;          
wire            pop_entry1_create_acc_err;   
wire            pop_entry1_create_data_en;   
wire            pop_entry1_create_en;        
wire    [14:0]  pop_entry1_create_halt_info; 
wire    [15:0]  pop_entry1_create_inst;      
wire    [1 :0]  pop_entry1_create_pred_taken; 
wire    [14:0]  pop_entry1_halt_info;        
wire    [15:0]  pop_entry1_inst;             
wire    [1 :0]  pop_entry1_pred_taken;       
wire            pop_entry1_retire_en;        
wire            pop_entry1_vld;              
wire            pop_entry_acc_err;           
wire            pop_entry_expt_high;         
wire    [14:0]  pop_entry_halt_info;         
wire    [31:0]  pop_entry_inst;              
wire    [1 :0]  pop_entry_pred_taken;        
wire            pop_entry_vld;               
wire    [5 :0]  push0_bypass;                
wire    [5 :0]  push1;                       
wire    [5 :0]  push1_bypass;                
wire    [5 :0]  push2;                       
wire    [5 :0]  push2_bypass;                
wire            rtu_ifu_flush_fe;            
wire            rtu_yy_xx_dbgon;             
wire            rtu_yy_xx_expt_vld;          
wire            rtu_yy_xx_tail_int_vld;      
wire            vec_ibuf_warm_up;            


//==========================================================
// Instruction Buffer Module
// 1. Instance ICG cells
// 2. Instance I-Buffer Entries
// 3. I-Buffer Read Port
// 4. I-Buffer Write Port
// 5. Valid Instruction Generation
// 6. I-Buffer Pop Entry
//==========================================================

//------------------------------------------------
// 1. Instance ICG cells
//------------------------------------------------
assign ibuf_icg_en = ~ibuf_empty
                   | pop0_vld
                   | pop_entry_vld
                   | ibuf_flush_en_gate
                   | ipack_ibuf_inst_vld
                   | dtu_create0_en;
// &Instance("gated_clk_cell", "x_ifu_ibuf_icg_cell"); @48
gated_clk_cell  x_ifu_ibuf_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ibuf_cpuclk       ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ibuf_icg_en       ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @49
//          .external_en (1'b0), @50
//          .global_en   (cp0_yy_clk_en), @51
//          .module_en   (cp0_ifu_icg_en), @52
//          .local_en    (ibuf_icg_en), @53
//          .clk_out     (ibuf_cpuclk) @54
//         ); @55

//------------------------------------------------
// 2. Instance I-Buffer Entries
//------------------------------------------------
parameter ENTRY_NUM = 6;

// &ConnRule(s/ibuf_entry/entry0/); @62
// &Instance("pa_ifu_ibuf_entry","x_pa_ifu_ibuf_entry0"); @63
pa_ifu_ibuf_entry  x_pa_ifu_ibuf_entry0 (
  .cp0_ifu_icg_en             (cp0_ifu_icg_en            ),
  .cp0_yy_clk_en              (cp0_yy_clk_en             ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .ibuf_cpuclk                (ibuf_cpuclk               ),
  .ibuf_create0_acc_err       (ibuf_create0_acc_err      ),
  .ibuf_create0_halt_info     (ibuf_create0_halt_info    ),
  .ibuf_create0_inst          (ibuf_create0_inst         ),
  .ibuf_create0_pred_taken    (ibuf_create0_pred_taken   ),
  .ibuf_create1_acc_err       (ibuf_create1_acc_err      ),
  .ibuf_create1_halt_info     (ibuf_create1_halt_info    ),
  .ibuf_create1_inst          (ibuf_create1_inst         ),
  .ibuf_create1_pred_taken    (ibuf_create1_pred_taken   ),
  .ibuf_create2_acc_err       (ibuf_create2_acc_err      ),
  .ibuf_create2_halt_info     (ibuf_create2_halt_info    ),
  .ibuf_create2_inst          (ibuf_create2_inst         ),
  .ibuf_create2_pred_taken    (ibuf_create2_pred_taken   ),
  .ibuf_entry_acc_err         (entry0_acc_err            ),
  .ibuf_entry_create0_data_en (entry0_create0_data_en    ),
  .ibuf_entry_create0_en      (entry0_create0_en         ),
  .ibuf_entry_create1_data_en (entry0_create1_data_en    ),
  .ibuf_entry_create1_en      (entry0_create1_en         ),
  .ibuf_entry_create2_data_en (entry0_create2_data_en    ),
  .ibuf_entry_create2_en      (entry0_create2_en         ),
  .ibuf_entry_halt_info       (entry0_halt_info          ),
  .ibuf_entry_inst            (entry0_inst               ),
  .ibuf_entry_pred_taken      (entry0_pred_taken         ),
  .ibuf_entry_retire0_en      (entry0_retire0_en         ),
  .ibuf_entry_retire1_en      (entry0_retire1_en         ),
  .ibuf_entry_vld             (entry0_vld                ),
  .ibuf_flush_en              (ibuf_flush_en             ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .vec_ibuf_warm_up           (vec_ibuf_warm_up          )
);


// &ConnRule(s/ibuf_entry/entry1/); @65
// &Instance("pa_ifu_ibuf_entry","x_pa_ifu_ibuf_entry1"); @66
pa_ifu_ibuf_entry  x_pa_ifu_ibuf_entry1 (
  .cp0_ifu_icg_en             (cp0_ifu_icg_en            ),
  .cp0_yy_clk_en              (cp0_yy_clk_en             ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .ibuf_cpuclk                (ibuf_cpuclk               ),
  .ibuf_create0_acc_err       (ibuf_create0_acc_err      ),
  .ibuf_create0_halt_info     (ibuf_create0_halt_info    ),
  .ibuf_create0_inst          (ibuf_create0_inst         ),
  .ibuf_create0_pred_taken    (ibuf_create0_pred_taken   ),
  .ibuf_create1_acc_err       (ibuf_create1_acc_err      ),
  .ibuf_create1_halt_info     (ibuf_create1_halt_info    ),
  .ibuf_create1_inst          (ibuf_create1_inst         ),
  .ibuf_create1_pred_taken    (ibuf_create1_pred_taken   ),
  .ibuf_create2_acc_err       (ibuf_create2_acc_err      ),
  .ibuf_create2_halt_info     (ibuf_create2_halt_info    ),
  .ibuf_create2_inst          (ibuf_create2_inst         ),
  .ibuf_create2_pred_taken    (ibuf_create2_pred_taken   ),
  .ibuf_entry_acc_err         (entry1_acc_err            ),
  .ibuf_entry_create0_data_en (entry1_create0_data_en    ),
  .ibuf_entry_create0_en      (entry1_create0_en         ),
  .ibuf_entry_create1_data_en (entry1_create1_data_en    ),
  .ibuf_entry_create1_en      (entry1_create1_en         ),
  .ibuf_entry_create2_data_en (entry1_create2_data_en    ),
  .ibuf_entry_create2_en      (entry1_create2_en         ),
  .ibuf_entry_halt_info       (entry1_halt_info          ),
  .ibuf_entry_inst            (entry1_inst               ),
  .ibuf_entry_pred_taken      (entry1_pred_taken         ),
  .ibuf_entry_retire0_en      (entry1_retire0_en         ),
  .ibuf_entry_retire1_en      (entry1_retire1_en         ),
  .ibuf_entry_vld             (entry1_vld                ),
  .ibuf_flush_en              (ibuf_flush_en             ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .vec_ibuf_warm_up           (vec_ibuf_warm_up          )
);


// &ConnRule(s/ibuf_entry/entry2/); @68
// &Instance("pa_ifu_ibuf_entry","x_pa_ifu_ibuf_entry2"); @69
pa_ifu_ibuf_entry  x_pa_ifu_ibuf_entry2 (
  .cp0_ifu_icg_en             (cp0_ifu_icg_en            ),
  .cp0_yy_clk_en              (cp0_yy_clk_en             ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .ibuf_cpuclk                (ibuf_cpuclk               ),
  .ibuf_create0_acc_err       (ibuf_create0_acc_err      ),
  .ibuf_create0_halt_info     (ibuf_create0_halt_info    ),
  .ibuf_create0_inst          (ibuf_create0_inst         ),
  .ibuf_create0_pred_taken    (ibuf_create0_pred_taken   ),
  .ibuf_create1_acc_err       (ibuf_create1_acc_err      ),
  .ibuf_create1_halt_info     (ibuf_create1_halt_info    ),
  .ibuf_create1_inst          (ibuf_create1_inst         ),
  .ibuf_create1_pred_taken    (ibuf_create1_pred_taken   ),
  .ibuf_create2_acc_err       (ibuf_create2_acc_err      ),
  .ibuf_create2_halt_info     (ibuf_create2_halt_info    ),
  .ibuf_create2_inst          (ibuf_create2_inst         ),
  .ibuf_create2_pred_taken    (ibuf_create2_pred_taken   ),
  .ibuf_entry_acc_err         (entry2_acc_err            ),
  .ibuf_entry_create0_data_en (entry2_create0_data_en    ),
  .ibuf_entry_create0_en      (entry2_create0_en         ),
  .ibuf_entry_create1_data_en (entry2_create1_data_en    ),
  .ibuf_entry_create1_en      (entry2_create1_en         ),
  .ibuf_entry_create2_data_en (entry2_create2_data_en    ),
  .ibuf_entry_create2_en      (entry2_create2_en         ),
  .ibuf_entry_halt_info       (entry2_halt_info          ),
  .ibuf_entry_inst            (entry2_inst               ),
  .ibuf_entry_pred_taken      (entry2_pred_taken         ),
  .ibuf_entry_retire0_en      (entry2_retire0_en         ),
  .ibuf_entry_retire1_en      (entry2_retire1_en         ),
  .ibuf_entry_vld             (entry2_vld                ),
  .ibuf_flush_en              (ibuf_flush_en             ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .vec_ibuf_warm_up           (vec_ibuf_warm_up          )
);


// &ConnRule(s/ibuf_entry/entry3/); @71
// &Instance("pa_ifu_ibuf_entry","x_pa_ifu_ibuf_entry3"); @72
pa_ifu_ibuf_entry  x_pa_ifu_ibuf_entry3 (
  .cp0_ifu_icg_en             (cp0_ifu_icg_en            ),
  .cp0_yy_clk_en              (cp0_yy_clk_en             ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .ibuf_cpuclk                (ibuf_cpuclk               ),
  .ibuf_create0_acc_err       (ibuf_create0_acc_err      ),
  .ibuf_create0_halt_info     (ibuf_create0_halt_info    ),
  .ibuf_create0_inst          (ibuf_create0_inst         ),
  .ibuf_create0_pred_taken    (ibuf_create0_pred_taken   ),
  .ibuf_create1_acc_err       (ibuf_create1_acc_err      ),
  .ibuf_create1_halt_info     (ibuf_create1_halt_info    ),
  .ibuf_create1_inst          (ibuf_create1_inst         ),
  .ibuf_create1_pred_taken    (ibuf_create1_pred_taken   ),
  .ibuf_create2_acc_err       (ibuf_create2_acc_err      ),
  .ibuf_create2_halt_info     (ibuf_create2_halt_info    ),
  .ibuf_create2_inst          (ibuf_create2_inst         ),
  .ibuf_create2_pred_taken    (ibuf_create2_pred_taken   ),
  .ibuf_entry_acc_err         (entry3_acc_err            ),
  .ibuf_entry_create0_data_en (entry3_create0_data_en    ),
  .ibuf_entry_create0_en      (entry3_create0_en         ),
  .ibuf_entry_create1_data_en (entry3_create1_data_en    ),
  .ibuf_entry_create1_en      (entry3_create1_en         ),
  .ibuf_entry_create2_data_en (entry3_create2_data_en    ),
  .ibuf_entry_create2_en      (entry3_create2_en         ),
  .ibuf_entry_halt_info       (entry3_halt_info          ),
  .ibuf_entry_inst            (entry3_inst               ),
  .ibuf_entry_pred_taken      (entry3_pred_taken         ),
  .ibuf_entry_retire0_en      (entry3_retire0_en         ),
  .ibuf_entry_retire1_en      (entry3_retire1_en         ),
  .ibuf_entry_vld             (entry3_vld                ),
  .ibuf_flush_en              (ibuf_flush_en             ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .vec_ibuf_warm_up           (vec_ibuf_warm_up          )
);


// &ConnRule(s/ibuf_entry/entry4/); @74
// &Instance("pa_ifu_ibuf_entry","x_pa_ifu_ibuf_entry4"); @75
pa_ifu_ibuf_entry  x_pa_ifu_ibuf_entry4 (
  .cp0_ifu_icg_en             (cp0_ifu_icg_en            ),
  .cp0_yy_clk_en              (cp0_yy_clk_en             ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .ibuf_cpuclk                (ibuf_cpuclk               ),
  .ibuf_create0_acc_err       (ibuf_create0_acc_err      ),
  .ibuf_create0_halt_info     (ibuf_create0_halt_info    ),
  .ibuf_create0_inst          (ibuf_create0_inst         ),
  .ibuf_create0_pred_taken    (ibuf_create0_pred_taken   ),
  .ibuf_create1_acc_err       (ibuf_create1_acc_err      ),
  .ibuf_create1_halt_info     (ibuf_create1_halt_info    ),
  .ibuf_create1_inst          (ibuf_create1_inst         ),
  .ibuf_create1_pred_taken    (ibuf_create1_pred_taken   ),
  .ibuf_create2_acc_err       (ibuf_create2_acc_err      ),
  .ibuf_create2_halt_info     (ibuf_create2_halt_info    ),
  .ibuf_create2_inst          (ibuf_create2_inst         ),
  .ibuf_create2_pred_taken    (ibuf_create2_pred_taken   ),
  .ibuf_entry_acc_err         (entry4_acc_err            ),
  .ibuf_entry_create0_data_en (entry4_create0_data_en    ),
  .ibuf_entry_create0_en      (entry4_create0_en         ),
  .ibuf_entry_create1_data_en (entry4_create1_data_en    ),
  .ibuf_entry_create1_en      (entry4_create1_en         ),
  .ibuf_entry_create2_data_en (entry4_create2_data_en    ),
  .ibuf_entry_create2_en      (entry4_create2_en         ),
  .ibuf_entry_halt_info       (entry4_halt_info          ),
  .ibuf_entry_inst            (entry4_inst               ),
  .ibuf_entry_pred_taken      (entry4_pred_taken         ),
  .ibuf_entry_retire0_en      (entry4_retire0_en         ),
  .ibuf_entry_retire1_en      (entry4_retire1_en         ),
  .ibuf_entry_vld             (entry4_vld                ),
  .ibuf_flush_en              (ibuf_flush_en             ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .vec_ibuf_warm_up           (vec_ibuf_warm_up          )
);


// &ConnRule(s/ibuf_entry/entry5/); @77
// &Instance("pa_ifu_ibuf_entry","x_pa_ifu_ibuf_entry5"); @78
pa_ifu_ibuf_entry  x_pa_ifu_ibuf_entry5 (
  .cp0_ifu_icg_en             (cp0_ifu_icg_en            ),
  .cp0_yy_clk_en              (cp0_yy_clk_en             ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .ibuf_cpuclk                (ibuf_cpuclk               ),
  .ibuf_create0_acc_err       (ibuf_create0_acc_err      ),
  .ibuf_create0_halt_info     (ibuf_create0_halt_info    ),
  .ibuf_create0_inst          (ibuf_create0_inst         ),
  .ibuf_create0_pred_taken    (ibuf_create0_pred_taken   ),
  .ibuf_create1_acc_err       (ibuf_create1_acc_err      ),
  .ibuf_create1_halt_info     (ibuf_create1_halt_info    ),
  .ibuf_create1_inst          (ibuf_create1_inst         ),
  .ibuf_create1_pred_taken    (ibuf_create1_pred_taken   ),
  .ibuf_create2_acc_err       (ibuf_create2_acc_err      ),
  .ibuf_create2_halt_info     (ibuf_create2_halt_info    ),
  .ibuf_create2_inst          (ibuf_create2_inst         ),
  .ibuf_create2_pred_taken    (ibuf_create2_pred_taken   ),
  .ibuf_entry_acc_err         (entry5_acc_err            ),
  .ibuf_entry_create0_data_en (entry5_create0_data_en    ),
  .ibuf_entry_create0_en      (entry5_create0_en         ),
  .ibuf_entry_create1_data_en (entry5_create1_data_en    ),
  .ibuf_entry_create1_en      (entry5_create1_en         ),
  .ibuf_entry_create2_data_en (entry5_create2_data_en    ),
  .ibuf_entry_create2_en      (entry5_create2_en         ),
  .ibuf_entry_halt_info       (entry5_halt_info          ),
  .ibuf_entry_inst            (entry5_inst               ),
  .ibuf_entry_pred_taken      (entry5_pred_taken         ),
  .ibuf_entry_retire0_en      (entry5_retire0_en         ),
  .ibuf_entry_retire1_en      (entry5_retire1_en         ),
  .ibuf_entry_vld             (entry5_vld                ),
  .ibuf_flush_en              (ibuf_flush_en             ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .vec_ibuf_warm_up           (vec_ibuf_warm_up          )
);


//------------------------------------------------
// 3. I-Buffer Read Port
// a. Retire Information out of Instruction Buffer
//------------------------------------------------
// a. Retire Information out of Instruction Buffer
// The instruction will be retired in inst buf when
// it can be piped down to ID stage
assign ibuf_retire0_en = pop0_vld & ctrl_ibuf_pop_en;
assign ibuf_retire1_en = ibuf_inst32 & ctrl_ibuf_pop_en;

assign ibuf_retire0_en_vld = ibuf_retire0_en;
assign ibuf_inst_32_vld = ibuf_inst32;

assign ibuf_flush_en      = rtu_ifu_flush_fe | pcgen_ibuf_chgflw_vld | idu_ifu_tail_vld | rtu_yy_xx_tail_int_vld | rtu_yy_xx_expt_vld;
assign ibuf_flush_en_gate = rtu_ifu_flush_fe | pcgen_ibuf_chgflw_vld | idu_ifu_tail_vld_gate | rtu_yy_xx_tail_int_vld | rtu_yy_xx_expt_vld;

//pop0
always @(posedge ibuf_cpuclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    pop0[ENTRY_NUM-1:0] <= {{(ENTRY_NUM-1){1'b0}}, 1'b1};
  else if(ibuf_flush_en)
    pop0[ENTRY_NUM-1:0] <= pop0[ENTRY_NUM-1:0];
  else if(ibuf_retire0_en_vld)
    pop0[ENTRY_NUM-1:0] <= pop0_shift[ENTRY_NUM-1:0];
end

// &CombBeg; @107
always @( pop0[5:0]
       or ibuf_inst_32_vld)
begin
  if(ibuf_inst_32_vld)
    pop0_shift[ENTRY_NUM-1:0] = {pop0[ENTRY_NUM-3:0],
                                 pop0[ENTRY_NUM-1:ENTRY_NUM-2]};
  else
    pop0_shift[ENTRY_NUM-1:0] = {pop0[ENTRY_NUM-2:0],
                                 pop0[ENTRY_NUM-1]};
// &CombEnd; @114
end

//retire0
assign {entry5_retire0_en,
        entry4_retire0_en,
        entry3_retire0_en,
        entry2_retire0_en,
        entry1_retire0_en,
        entry0_retire0_en} = pop0[ENTRY_NUM-1:0] & {ENTRY_NUM{ibuf_retire0_en}};

//pop1
assign pop1[ENTRY_NUM-1:0] = {pop0[ENTRY_NUM-2:0],
                              pop0[ENTRY_NUM-1]};

//retire1
assign {entry5_retire1_en,
        entry4_retire1_en,
        entry3_retire1_en,
        entry2_retire1_en,
        entry1_retire1_en,
        entry0_retire1_en} = pop1[ENTRY_NUM-1:0] &
                             {ENTRY_NUM{ibuf_retire1_en}};

// &CombBeg; @137
always @( entry1_halt_info[14:0]
       or entry3_acc_err
       or entry1_vld
       or entry1_acc_err
       or entry2_inst[15:0]
       or entry5_inst[15:0]
       or entry4_acc_err
       or entry3_halt_info[14:0]
       or entry0_acc_err
       or entry4_pred_taken[1:0]
       or entry4_halt_info[14:0]
       or entry0_pred_taken[1:0]
       or entry5_acc_err
       or entry5_vld
       or entry2_halt_info[14:0]
       or entry4_inst[15:0]
       or entry2_vld
       or entry0_vld
       or entry5_halt_info[14:0]
       or entry1_inst[15:0]
       or entry3_vld
       or entry5_pred_taken[1:0]
       or entry4_vld
       or entry2_acc_err
       or entry3_inst[15:0]
       or pop0[5:0]
       or entry0_halt_info[14:0]
       or entry2_pred_taken[1:0]
       or entry3_pred_taken[1:0]
       or entry1_pred_taken[1:0]
       or entry0_inst[15:0])
begin
  case(pop0[ENTRY_NUM-1:0])
  6'b0001:
  begin
    pop0_vld          = entry0_vld;
    pop0_inst[15:0]   = entry0_inst[15:0];
    pop0_pred_taken[1:0] = entry0_pred_taken[1:0];
    pop0_halt_info[`TDT_HINFO_WIDTH-1:0]  = entry0_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop0_acc_err      = entry0_acc_err;
  end
  6'b0010:
  begin
    pop0_vld          = entry1_vld;
    pop0_inst[15:0]   = entry1_inst[15:0];
    pop0_pred_taken[1:0] = entry1_pred_taken[1:0];
    pop0_halt_info[`TDT_HINFO_WIDTH-1:0]  = entry1_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop0_acc_err      = entry1_acc_err;
  end
  6'b0100:
  begin
    pop0_vld          = entry2_vld;
    pop0_inst[15:0]   = entry2_inst[15:0];
    pop0_pred_taken[1:0] = entry2_pred_taken[1:0];
    pop0_halt_info[`TDT_HINFO_WIDTH-1:0]  = entry2_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop0_acc_err      = entry2_acc_err;
  end
  6'b1000:
  begin
    pop0_vld          = entry3_vld;
    pop0_inst[15:0]   = entry3_inst[15:0];
    pop0_pred_taken[1:0] = entry3_pred_taken[1:0];
    pop0_halt_info[`TDT_HINFO_WIDTH-1:0]  = entry3_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop0_acc_err      = entry3_acc_err;
  end
  6'b10000:
  begin
    pop0_vld          = entry4_vld;
    pop0_inst[15:0]   = entry4_inst[15:0];
    pop0_pred_taken[1:0] = entry4_pred_taken[1:0];
    pop0_halt_info[`TDT_HINFO_WIDTH-1:0]  = entry4_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop0_acc_err      = entry4_acc_err;
  end
  6'b100000:
  begin
    pop0_vld          = entry5_vld;
    pop0_inst[15:0]   = entry5_inst[15:0];
    pop0_pred_taken[1:0] = entry5_pred_taken[1:0];
    pop0_halt_info[`TDT_HINFO_WIDTH-1:0]  = entry5_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop0_acc_err      = entry5_acc_err;
  end
  default:
  begin
    pop0_vld          = 1'bx;
    pop0_inst[15:0]   = {16{1'bx}};
    pop0_pred_taken[1:0] = {2{1'bx}};
    pop0_halt_info[`TDT_HINFO_WIDTH-1:0] = {`TDT_HINFO_WIDTH{1'bx}};
    pop0_acc_err      = 1'bx;
  end
  endcase
// &CombEnd; @196
end

//The information which is index by pop1 pointer
// &CombBeg; @199
always @( entry1_halt_info[14:0]
       or entry3_acc_err
       or entry1_vld
       or entry1_acc_err
       or entry2_inst[15:0]
       or entry5_inst[15:0]
       or entry4_acc_err
       or entry3_halt_info[14:0]
       or entry0_acc_err
       or entry4_pred_taken[1:0]
       or entry4_halt_info[14:0]
       or entry0_pred_taken[1:0]
       or entry5_acc_err
       or entry5_vld
       or entry2_halt_info[14:0]
       or entry4_inst[15:0]
       or entry2_vld
       or entry0_vld
       or entry5_halt_info[14:0]
       or entry1_inst[15:0]
       or entry3_vld
       or entry5_pred_taken[1:0]
       or entry4_vld
       or entry2_acc_err
       or entry3_inst[15:0]
       or entry0_halt_info[14:0]
       or pop1[5:0]
       or entry2_pred_taken[1:0]
       or entry3_pred_taken[1:0]
       or entry1_pred_taken[1:0]
       or entry0_inst[15:0])
begin
  case(pop1[ENTRY_NUM-1:0])
  6'b0001:
  begin
    pop1_vld          = entry0_vld;
    pop1_inst[15:0]   = entry0_inst[15:0];
    pop1_pred_taken[1:0] = entry0_pred_taken[1:0];
    pop1_halt_info[`TDT_HINFO_WIDTH-1:0] = entry0_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop1_acc_err      = entry0_acc_err;
  end
  6'b0010:
  begin
    pop1_vld          = entry1_vld;
    pop1_inst[15:0]   = entry1_inst[15:0];
    pop1_pred_taken[1:0] = entry1_pred_taken[1:0];
    pop1_halt_info[`TDT_HINFO_WIDTH-1:0] = entry1_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop1_acc_err      = entry1_acc_err;
  end
  6'b0100:
  begin
    pop1_vld          = entry2_vld;
    pop1_inst[15:0]   = entry2_inst[15:0];
    pop1_pred_taken[1:0] = entry2_pred_taken[1:0];
    pop1_halt_info[`TDT_HINFO_WIDTH-1:0] = entry2_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop1_acc_err      = entry2_acc_err;
  end
  6'b1000:
  begin
    pop1_vld          = entry3_vld;
    pop1_inst[15:0]   = entry3_inst[15:0];
    pop1_pred_taken[1:0] = entry3_pred_taken[1:0];
    pop1_halt_info[`TDT_HINFO_WIDTH-1:0] = entry3_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop1_acc_err      = entry3_acc_err;
  end
  6'b10000:
  begin
    pop1_vld          = entry4_vld;
    pop1_inst[15:0]   = entry4_inst[15:0];
    pop1_pred_taken[1:0] = entry4_pred_taken[1:0];
    pop1_halt_info[`TDT_HINFO_WIDTH-1:0] = entry4_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop1_acc_err      = entry4_acc_err;
  end
  6'b100000:
  begin
    pop1_vld          = entry5_vld;
    pop1_inst[15:0]   = entry5_inst[15:0];
    pop1_pred_taken[1:0] = entry5_pred_taken[1:0];
    pop1_halt_info[`TDT_HINFO_WIDTH-1:0] = entry5_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop1_acc_err      = entry5_acc_err;
  end
  default:
  begin
    pop1_vld          = 1'bx;
    pop1_inst[15:0]   = {16{1'bx}};
    pop1_pred_taken[1:0] = {2{1'bx}};
    pop1_halt_info[`TDT_HINFO_WIDTH-1:0] = {`TDT_HINFO_WIDTH{1'bx}};
    pop1_acc_err      = 1'bx;
  end
  endcase
// &CombEnd; @258
end

//------------------------------------------------
// 4. I-Buffer Write Port
// a. Create Information into I-Buffer
// b. Generate Entry Create Signal for Each Entry 
// c. Generate Entry Create Instruction
//------------------------------------------------
// a. Create Information into I-Buffer
// the create0 signal
assign ipack_bypass_vld = ibuf_empty & ipack_ibuf_inst_vld;
assign ipack_create0_en = ipack_ibuf_inst_vld
                        & ~(ibuf_empty & 
                             (ipack_ibuf_inst_two & ~pop_entry_vld & ~idu_ifu_id_stall
                               | ipack_ibuf_inst_one & ~pop_entry_vld
                               | ipack_ibuf_inst_one & ~idu_ifu_id_stall
                               | ipack_inst_32 & ~ipack_ibuf_inst_all & ~pop_entry_vld
                               | ipack_inst_32 & ~ipack_ibuf_inst_all & ~idu_ifu_id_stall));

assign ipack_create0_data_en = ipack_ibuf_inst_vld_raw & ~ibuf_entry_stall
                            & (~ibuf_empty | pop_entry_vld | ipack_ibuf_inst_two);
assign dtu_create0_en   = rtu_yy_xx_dbgon & dtu_ifu_debug_inst_vld;

assign ibuf_create0_en  = ipack_create0_en | dtu_create0_en;
assign ibuf_create0_data_en  = ipack_create0_data_en | dtu_create0_en;

// &Force("bus", "dtu_ifu_debug_inst", 31, 0); @284
// the create1 signal
assign ipack_create1_en = ipack_ibuf_inst_vld & ~ipack_ibuf_inst_one
                        & (~ibuf_empty | idu_ifu_id_stall & pop_entry_vld);
assign ipack_create1_data_en = ipack_ibuf_inst_vld_raw & ~ibuf_entry_stall & ~ipack_ibuf_inst_one
                        & (~ibuf_empty | pop_entry_vld);
assign dtu_create1_en   = dtu_create0_en & dtu_ifu_debug_inst[1:0] == 2'b11;

assign ibuf_create1_en  = ipack_create1_en | dtu_create1_en;
assign ibuf_create1_data_en  = ipack_create1_data_en | dtu_create1_en;

// the create2 signal
assign ibuf_create2_en = ipack_ibuf_inst_vld & ipack_ibuf_inst_all 
                        & ~id_pred_ibuf_chgflw_vld0
                        & (~ibuf_empty | idu_ifu_id_stall & pop_entry_vld);
assign ibuf_create2_data_en = ipack_ibuf_inst_vld_raw & ~ibuf_entry_stall & ipack_ibuf_inst_all 
                        & ~id_pred_ibuf_chgflw_vld0
                        & (~ibuf_empty | pop_entry_vld);

// b. Generate Entry Create Signal for Each Entry 
//push0
always @(posedge ibuf_cpuclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    push0[ENTRY_NUM-1:0] <= {{(ENTRY_NUM-1){1'b0}}, 1'b1};
  else if(ibuf_flush_en)
    push0[ENTRY_NUM-1:0] <= pop0[ENTRY_NUM-1:0];
  else if(ibuf_create0_en)
    push0[ENTRY_NUM-1:0] <= push0_shift[ENTRY_NUM-1:0];
end

// &CombBeg; @315
always @( push0[5:0]
       or ibuf_create1_en
       or ibuf_create2_en)
begin
  if(ibuf_create2_en)
    push0_shift[ENTRY_NUM-1:0] = {push0[ENTRY_NUM-4:0],
                                  push0[ENTRY_NUM-1:ENTRY_NUM-3]};
  else if(ibuf_create1_en)
    push0_shift[ENTRY_NUM-1:0] = {push0[ENTRY_NUM-3:0],
                                  push0[ENTRY_NUM-1:ENTRY_NUM-2]};
  else
    push0_shift[ENTRY_NUM-1:0] = {push0[ENTRY_NUM-2:0],
                                  push0[ENTRY_NUM-1]};
// &CombEnd; @325
end

assign push0_bypass[ENTRY_NUM-1:0] = push0[ENTRY_NUM-1:0];

//create0
assign {entry5_create0_en,
        entry4_create0_en,
        entry3_create0_en,
        entry2_create0_en,
        entry1_create0_en,
        entry0_create0_en} = push0_bypass[ENTRY_NUM-1:0] &
                             {ENTRY_NUM{ibuf_create0_en}};

assign {entry5_create0_data_en,
        entry4_create0_data_en,
        entry3_create0_data_en,
        entry2_create0_data_en,
        entry1_create0_data_en,
        entry0_create0_data_en} = push0[ENTRY_NUM-1:0] &
                             {ENTRY_NUM{ibuf_create0_data_en}};

//push1
assign push1[ENTRY_NUM-1:0] = {push0[ENTRY_NUM-2:0],
                               push0[ENTRY_NUM-1]};

//push1
assign push1_bypass[ENTRY_NUM-1:0] = {push0_bypass[ENTRY_NUM-2:0],
                                      push0_bypass[ENTRY_NUM-1]};

//create1
assign {entry5_create1_en,
        entry4_create1_en,
        entry3_create1_en,
        entry2_create1_en,
        entry1_create1_en,
        entry0_create1_en} = push1_bypass[ENTRY_NUM-1:0] &
                             {ENTRY_NUM{ibuf_create1_en}};

assign {entry5_create1_data_en,
        entry4_create1_data_en,
        entry3_create1_data_en,
        entry2_create1_data_en,
        entry1_create1_data_en,
        entry0_create1_data_en} = push1[ENTRY_NUM-1:0] &
                             {ENTRY_NUM{ibuf_create1_data_en}};

//push2
assign push2[ENTRY_NUM-1:0] = {push0[ENTRY_NUM-3:0],
                               push0[ENTRY_NUM-1:ENTRY_NUM-2]};

//push2
assign push2_bypass[ENTRY_NUM-1:0] = {push0_bypass[ENTRY_NUM-3:0],
                                      push0_bypass[ENTRY_NUM-1:ENTRY_NUM-2]};

//create1
assign {entry5_create2_en,
        entry4_create2_en,
        entry3_create2_en,
        entry2_create2_en,
        entry1_create2_en,
        entry0_create2_en} = push2_bypass[ENTRY_NUM-1:0] &
                             {ENTRY_NUM{ibuf_create2_en}};

assign {entry5_create2_data_en,
        entry4_create2_data_en,
        entry3_create2_data_en,
        entry2_create2_data_en,
        entry1_create2_data_en,
        entry0_create2_data_en} = push2[ENTRY_NUM-1:0] &
                             {ENTRY_NUM{ibuf_create2_data_en}};

// c. Generate Entry Create Instruction
assign ipack_inst_32 = ipack_ibuf_inst[1:0] == 2'b11;
assign ibuf_create0_inst[15:0] = // create dtu low inst when dbg on
                                  rtu_yy_xx_dbgon ? dtu_ifu_debug_inst[15:0]
                                 // create ipack up inst when pop entry
                                 // empty and ipack full
                               : ipack_ibuf_inst_full & (~pop_entry_vld 
                                      | ~idu_ifu_id_stall & ibuf_empty)
                               ? ipack_ibuf_inst[47:32]
                                 // create ipack high inst when pop entry
                                 // empty and ipack first 16-bit
                               : ipack_ibuf_inst_two & ~ipack_inst_32 
                                   & (~pop_entry_vld | ~idu_ifu_id_stall & ibuf_empty)
                               ? ipack_ibuf_inst[31:16]
                               : ipack_ibuf_inst[15:0];
assign ibuf_create1_inst[15:0] = // create dtu high inst when dbg on
                                 rtu_yy_xx_dbgon ? dtu_ifu_debug_inst[31:16]
                               : ipack_ibuf_inst[31:16];
assign ibuf_create2_inst[15:0] = ipack_ibuf_inst[47:32];

assign ibuf_create0_pred_taken[1:0] = ipack_ibuf_inst_two
                                   & (~pop_entry_vld | ~idu_ifu_id_stall & ibuf_empty)
                                    ? id_pred_ibuf_br_taken1[1:0]
                                    : id_pred_ibuf_br_taken0[1:0];
assign ibuf_create1_pred_taken[1:0] = id_pred_ibuf_br_taken1[1:0];
assign ibuf_create2_pred_taken[1:0] = id_pred_ibuf_br_taken1[1:0];

assign ibuf_create0_halt_info[`TDT_HINFO_WIDTH-1:0]  = ipack_ibuf_inst_two
                                   & (~pop_entry_vld | ~idu_ifu_id_stall & ibuf_empty)
                                    ? id_pred_ibuf_halt_info1[`TDT_HINFO_WIDTH-1:0]
                                    : id_pred_ibuf_halt_info0[`TDT_HINFO_WIDTH-1:0];
assign ibuf_create1_halt_info[`TDT_HINFO_WIDTH-1:0]  = id_pred_ibuf_halt_info1[`TDT_HINFO_WIDTH-1:0];
assign ibuf_create2_halt_info[`TDT_HINFO_WIDTH-1:0]  = id_pred_ibuf_halt_info1[`TDT_HINFO_WIDTH-1:0];

assign ibuf_create0_acc_err    = ipack_ibuf_acc_err[0];
assign ibuf_create1_acc_err    = ipack_ibuf_acc_err[1];
assign ibuf_create2_acc_err    = ipack_ibuf_acc_err[2];

//------------------------------------------------
// 5. Valid Instruction Generation
// a. The I-Buffer status signal
// b. The Valid Instruction
//------------------------------------------------
// a. The I-Buffer status signal
//------------------------------------------------
assign ibuf_vld_num[2:0] = {2'b0, entry0_vld}
                         + {2'b0, entry1_vld}
                         + {2'b0, entry2_vld}
                         + {2'b0, entry3_vld}
                         + {2'b0, entry4_vld}
                         + {2'b0, entry5_vld};

assign ibuf_full         = ibuf_vld_num[2:0] == 3'b110; 
assign ibuf_one_avalbe   = ibuf_vld_num[2:0] == 3'b101; 
assign ibuf_two_avalbe   = ibuf_vld_num[2:0] == 3'b100; 
assign ibuf_three_avalbe = ibuf_vld_num[2:0] == 3'b011;       
assign ibuf_four_avalbe  = ibuf_vld_num[2:0] == 3'b010;       
assign ibuf_five_avalbe  = ibuf_vld_num[2:0] == 3'b001;       
//assign ibuf_empty        = ibuf_vld_num[2:0] == 3'b000;
assign ibuf_empty        = ~(entry0_vld | entry1_vld | entry2_vld
                          | entry3_vld | entry4_vld | entry5_vld);

assign ibuf_entry_stall = ibuf_full & ipack_ibuf_inst_vld_raw
                       | ibuf_one_avalbe & ipack_ibuf_inst_vld_raw
                          & ~ipack_ibuf_inst_one_raw
                       | ibuf_two_avalbe & ipack_ibuf_inst_full;
assign ibuf_stall       = ibuf_entry_stall | ~dtu_ifu_halt_info_vld & ipack_ibuf_inst_vld_raw;

assign ibuf_fetch_empty = ibuf_empty;
assign ibuf_fetch_five = ibuf_five_avalbe;
assign ibuf_fetch_four   = ibuf_four_avalbe
                          & ~(ipack_ibuf_inst_full
                          & ~ifetch_ibuf_idle);
assign ibuf_fetch_three = ibuf_three_avalbe 
                       & (ifetch_ibuf_idle
                        | ifetch_xx_not_busy & 
                           ~ipack_ibuf_inst_vld_raw);
assign ibuf_fetch_two   = ibuf_two_avalbe
                       & (ifetch_ibuf_idle
                          & ~ipack_ibuf_inst_full
                        | ifetch_xx_not_busy & 
                          ipack_ibuf_inst_empty);
assign ibuf_inst_fetch = ibuf_fetch_empty
                      | ibuf_fetch_five
                      | ibuf_fetch_four
                      | ibuf_fetch_three
                      | ibuf_fetch_two;
//assign ibuf_inst_fetch = 1'b1;

//------------------------------------------------
// b. The Valid Instruction
//------------------------------------------------
assign pop0_inst_32  = pop0_inst[1:0] == 2'b11;
assign ibuf_inst32   = pop0_vld & pop1_vld & pop0_inst_32;

// &Force("nonport", "pop1_pred_taken"); @491
// &Force("nonport", "pop1_halt_info"); @492

//------------------------------------------------
// 6. I-Buffer Pop Entry
//------------------------------------------------
// a. entry instance
//------------------------------------------------
// &ConnRule(s/ibuf_entry/pop_entry0/); @499
// &Instance("pa_ifu_ibuf_pop_entry","x_pa_ifu_ibuf_pop_entry0"); @500
pa_ifu_ibuf_pop_entry  x_pa_ifu_ibuf_pop_entry0 (
  .cp0_ifu_icg_en               (cp0_ifu_icg_en              ),
  .cp0_yy_clk_en                (cp0_yy_clk_en               ),
  .cpurst_b                     (cpurst_b                    ),
  .forever_cpuclk               (forever_cpuclk              ),
  .ibuf_cpuclk                  (ibuf_cpuclk                 ),
  .ibuf_entry_acc_err           (pop_entry0_acc_err          ),
  .ibuf_entry_create_acc_err    (pop_entry0_create_acc_err   ),
  .ibuf_entry_create_data_en    (pop_entry0_create_data_en   ),
  .ibuf_entry_create_en         (pop_entry0_create_en        ),
  .ibuf_entry_create_halt_info  (pop_entry0_create_halt_info ),
  .ibuf_entry_create_inst       (pop_entry0_create_inst      ),
  .ibuf_entry_create_pred_taken (pop_entry0_create_pred_taken),
  .ibuf_entry_halt_info         (pop_entry0_halt_info        ),
  .ibuf_entry_inst              (pop_entry0_inst             ),
  .ibuf_entry_pred_taken        (pop_entry0_pred_taken       ),
  .ibuf_entry_retire_en         (pop_entry0_retire_en        ),
  .ibuf_entry_vld               (pop_entry0_vld              ),
  .ibuf_flush_en                (ibuf_flush_en               ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          ),
  .vec_ibuf_warm_up             (vec_ibuf_warm_up            )
);


// &ConnRule(s/ibuf_entry/pop_entry1/); @502
// &Instance("pa_ifu_ibuf_pop_entry","x_pa_ifu_ibuf_pop_entry1"); @503
pa_ifu_ibuf_pop_entry  x_pa_ifu_ibuf_pop_entry1 (
  .cp0_ifu_icg_en               (cp0_ifu_icg_en              ),
  .cp0_yy_clk_en                (cp0_yy_clk_en               ),
  .cpurst_b                     (cpurst_b                    ),
  .forever_cpuclk               (forever_cpuclk              ),
  .ibuf_cpuclk                  (ibuf_cpuclk                 ),
  .ibuf_entry_acc_err           (pop_entry1_acc_err          ),
  .ibuf_entry_create_acc_err    (pop_entry1_create_acc_err   ),
  .ibuf_entry_create_data_en    (pop_entry1_create_data_en   ),
  .ibuf_entry_create_en         (pop_entry1_create_en        ),
  .ibuf_entry_create_halt_info  (pop_entry1_create_halt_info ),
  .ibuf_entry_create_inst       (pop_entry1_create_inst      ),
  .ibuf_entry_create_pred_taken (pop_entry1_create_pred_taken),
  .ibuf_entry_halt_info         (pop_entry1_halt_info        ),
  .ibuf_entry_inst              (pop_entry1_inst             ),
  .ibuf_entry_pred_taken        (pop_entry1_pred_taken       ),
  .ibuf_entry_retire_en         (pop_entry1_retire_en        ),
  .ibuf_entry_vld               (pop_entry1_vld              ),
  .ibuf_flush_en                (ibuf_flush_en               ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          ),
  .vec_ibuf_warm_up             (vec_ibuf_warm_up            )
);


//------------------------------------------------
// b. entry create
//------------------------------------------------
// create entry 0 when:
// 1. ibuf retire0 vld
// 2. ipack bypass vld and id stall
// 3. ipack bypass vld and pop entry inst vld
// 4. ipack bypass vld and ipack two inst vld
assign pop_entry0_create_en = ibuf_retire0_en
                           | ipack_bypass_vld & ~pop_entry_vld & idu_ifu_id_stall
                           | ipack_bypass_vld & ~pop_entry_vld & ipack_ibuf_inst_two
                           | ipack_bypass_vld & pop_entry_vld & ~idu_ifu_id_stall;
assign pop_entry0_create_data_en = pop0_vld | ipack_bypass_vld;

// create entry 1 when:
// 1. ibuf retire1 vld
// 2. ipack bypass vld and id stall and ipack inst 32
// 3. ipack bypass vld and pop entry vld and ipack inst 32
assign pop_entry1_create_en = ibuf_retire1_en
                           | ipack_bypass_vld & ipack_inst_32 & ~pop_entry_vld & idu_ifu_id_stall
                           | ipack_bypass_vld & ipack_inst_32 & pop_entry_vld & ~idu_ifu_id_stall;
assign pop_entry1_create_data_en = ibuf_inst32 | ipack_bypass_vld & ipack_inst_32;

// create content
// inst code
assign pop_entry0_create_inst[15:0] = pop0_vld ? pop0_inst[15:0]
                                    : idu_ifu_id_stall | pop_entry_vld
                                    ? ipack_ibuf_inst[15:0]
                                    : ipack_inst_32 ? ipack_ibuf_inst[47:32]
                                    : ipack_ibuf_inst[31:16];
assign pop_entry1_create_inst[15:0] = pop1_vld ? pop1_inst[15:0] : ipack_ibuf_inst[31:16];

// pred taken
assign pop_entry0_create_pred_taken[1:0] = pop0_vld ? pop0_pred_taken[1:0]
                                    : idu_ifu_id_stall | pop_entry_vld ? id_pred_ibuf_br_taken0[1:0]
                                    : id_pred_ibuf_br_taken1[1:0];
assign pop_entry1_create_pred_taken[1:0] = 2'b0;

// inst bkpt
assign pop_entry0_create_halt_info[`TDT_HINFO_WIDTH-1:0] = pop0_vld ? pop0_halt_info[`TDT_HINFO_WIDTH-1:0]
                                    : idu_ifu_id_stall | pop_entry_vld ? id_pred_ibuf_halt_info0[`TDT_HINFO_WIDTH-1:0]
                                    : id_pred_ibuf_halt_info1[`TDT_HINFO_WIDTH-1:0];
assign pop_entry1_create_halt_info[`TDT_HINFO_WIDTH-1:0] = {`TDT_HINFO_WIDTH{1'b0}};

// acc err
assign pop_entry0_create_acc_err = pop0_vld ? pop0_acc_err
                                 : idu_ifu_id_stall | pop_entry_vld ? ipack_ibuf_acc_err[0]
                                 : ipack_ibuf_acc_err[1];
assign pop_entry1_create_acc_err = pop1_vld ? pop1_acc_err : ipack_ibuf_acc_err[1];

// page fault

assign ipack_expt_high          = ipack_inst_32 & ~ipack_ibuf_acc_err[0] & ipack_ibuf_acc_err[1];

//------------------------------------------------
// c. entry retire
//------------------------------------------------
assign pop_entry0_retire_en = ctrl_ibuf_pop_en;
assign pop_entry1_retire_en = ctrl_ibuf_pop_en;

//------------------------------------------------
// d. entry output
//------------------------------------------------
assign pop_entry_vld             = pop_entry0_vld;
assign pop_entry_inst[31:0]      = {pop_entry1_inst[15:0], pop_entry0_inst[15:0]};
assign pop_entry_pred_taken[1:0] = pop_entry0_pred_taken[1:0] | pop_entry1_pred_taken[1:0]; 
assign pop_entry_halt_info[`TDT_HINFO_WIDTH-1:0]  = pop_entry0_halt_info[`TDT_HINFO_WIDTH-1:0] | pop_entry1_halt_info[`TDT_HINFO_WIDTH-1:0]; 
assign pop_entry_acc_err         = pop_entry0_acc_err | pop_entry1_vld & pop_entry1_acc_err;
assign pop_entry_expt_high       = ~pop_entry0_acc_err & pop_entry1_vld & pop_entry1_acc_err;
//==========================================================
// Rename for Output
//==========================================================

// Output to ctrl
assign ibuf_ctrl_inst_fetch = ibuf_inst_fetch & ~ibuf_stall;

// Output to ipack
assign ibuf_ipack_stall = ibuf_stall;

// Output to ipack
assign ibuf_pred_stall  = ibuf_stall;
assign ibuf_id_pred_hungry = ibuf_empty | ibuf_five_avalbe | ibuf_four_avalbe;

// Output to top
assign ibuf_top_vld_num[2:0] = ibuf_vld_num[2:0];
assign ibuf_top_id_stall     = idu_ifu_id_stall;
//assign ibuf_top_pop_entry_vld = pop_entry_vld;

// Output to IDU
assign ifu_idu_id_inst_vld   = pop_entry_vld | ipack_ibuf_inst_vld & dtu_ifu_halt_info_vld; 
assign ifu_idu_id_inst[31:0] = pop_entry_vld ? pop_entry_inst[31:0]
                                          : ipack_ibuf_inst[31:0];
assign ifu_idu_id_pred_taken[1:0] = pop_entry_vld ? pop_entry_pred_taken[1:0]
                                                  : id_pred_ibuf_br_taken0[1:0];
assign ifu_idu_id_halt_info[`TDT_HINFO_WIDTH-1:0]  = pop_entry_vld ? pop_entry_halt_info[`TDT_HINFO_WIDTH-1:0]
                                                  : id_pred_ibuf_halt_info0[`TDT_HINFO_WIDTH-1:0];
assign ifu_idu_id_expt_vld  = pop_entry_vld ? pop_entry_acc_err
                           : |ipack_ibuf_acc_err[1:0];
assign ifu_idu_id_expt_high = pop_entry_vld ? pop_entry_expt_high
                           : ipack_expt_high;
// &Force("outout", "ifu_idu_id_inst"); @612
// &Force("outout", "ifu_idu_id_inst_vld"); @613

// &ModuleEnd; @640
endmodule


