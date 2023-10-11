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
module pa_pmp_comp_hit(
  addr_match_mode,
  ifu_acc_addr,
  ifu_addr_ge_bottom,
  ifu_addr_ge_pmpaddr,
  lsu_4k_cross,
  lsu_acc_addr,
  lsu_addr_ge_bottom,
  lsu_addr_ge_pmpaddr,
  pmp_ifu_hit,
  pmp_lsu_hit,
  pmpaddr
);

// &Ports; @25
input   [1 :0]  addr_match_mode;     
input   [31:0]  ifu_acc_addr;        
input           ifu_addr_ge_bottom;  
input   [31:0]  lsu_acc_addr;        
input           lsu_addr_ge_bottom;  
input   [25:0]  pmpaddr;             
output          ifu_addr_ge_pmpaddr; 
output          lsu_4k_cross;        
output          lsu_addr_ge_pmpaddr; 
output          pmp_ifu_hit;         
output          pmp_lsu_hit;         

// &Regs; @26
reg     [31:0]  addr_mask;           
reg             pmp_ifu_hit;         
reg             pmp_lsu_hit;         

// &Wires; @27
wire    [1 :0]  addr_match_mode;     
wire    [31:0]  ifu_acc_addr;        
wire            ifu_addr_ge_bottom;  
wire            ifu_addr_ge_pmpaddr; 
wire            ifu_addr_ls_top;     
wire    [25:0]  ifu_comp_adder;      
wire            ifu_napot_addr_match; 
wire            ifu_tor_addr_match;  
wire            lsu_4k_cross;        
wire    [31:0]  lsu_acc_addr;        
wire            lsu_addr_ge_bottom;  
wire            lsu_addr_ge_pmpaddr; 
wire            lsu_addr_ls_top;     
wire    [25:0]  lsu_comp_adder;      
wire            lsu_napot_addr_match; 
wire            lsu_tor_addr_match;  
wire    [25:0]  pmpaddr;             


// &Force("bus","ifu_acc_addr",31,0); @29
// &Force("bus","lsu_acc_addr",31,0); @30
//==========================================================
//                Address Matching Logic
//==========================================================
//Compare access address by four address-matching mode,and 
//generate address hit information
// &CombBeg; @36
always @( ifu_tor_addr_match
       or addr_match_mode[1:0]
       or ifu_napot_addr_match)
begin
  case(addr_match_mode[1:0])
    2'b00:   pmp_ifu_hit = 1'b0;                 //OFF
    2'b01:   pmp_ifu_hit = ifu_tor_addr_match;   //TOR 
//    2'b10:   pmp_ifu_hit = ifu_na4_addr_match;   //NA4
    2'b11:   pmp_ifu_hit = ifu_napot_addr_match; //NAPOT
    default: pmp_ifu_hit = 1'b0; 
  endcase
// &CombEnd; @44
end

// &CombBeg; @46
always @( lsu_tor_addr_match
       or addr_match_mode[1:0]
       or lsu_napot_addr_match)
begin
  case(addr_match_mode[1:0])
    2'b00:   pmp_lsu_hit = 1'b0;                 //OFF
    2'b01:   pmp_lsu_hit = lsu_tor_addr_match;   //TOR 
//    2'b10:   pmp_lsu_hit = lsu_na4_addr_match;   //NA4
    2'b11:   pmp_lsu_hit = lsu_napot_addr_match; //NAPOT
    default: pmp_lsu_hit = 1'b0; 
  endcase
// &CombEnd; @54
end

// IFU
// 1. TOR mode : pmpaddr[i-1]<= addr < pmpaddr[i]
assign ifu_comp_adder[25:0] = {1'b0,ifu_acc_addr[31:7]} - {1'b0,pmpaddr[25:1]};
assign ifu_addr_ls_top      = ifu_comp_adder[25];
assign ifu_addr_ge_pmpaddr  = !ifu_comp_adder[25];
assign ifu_tor_addr_match   = ifu_addr_ge_bottom && ifu_addr_ls_top;

// 2. NAPOT : addr &addr_mask == pmpaddr & addr_mask
assign ifu_napot_addr_match = (addr_mask[31:7] & ifu_acc_addr[31:7]) == (addr_mask[31:7] & pmpaddr[25:1]);

// LSU
// 1. TOR mode : pmpaddr[i-1]<= addr < pmpaddr[i]
assign lsu_comp_adder[25:0] = {1'b0,lsu_acc_addr[31:7]} - {1'b0,pmpaddr[25:1]};
assign lsu_addr_ls_top      = lsu_comp_adder[25];
assign lsu_addr_ge_pmpaddr  = ~lsu_comp_adder[25];
assign lsu_tor_addr_match   = lsu_addr_ge_bottom && lsu_addr_ls_top;

// 2. NAPOT : addr & addr_mask == pmpaddr & addr_mask
assign lsu_napot_addr_match = (addr_mask[31:7] & lsu_acc_addr[31:7]) == (addr_mask[31:7] & pmpaddr[25:1]);

// dummy port
assign lsu_4k_cross   = 1'b0;

//----------------------------------------------------------
//Generate the address mask for the addr come from ifu or iu
//register the addr mask signal to avoid timing violation
//----------------------------------------------------------
// &CombBeg; @107
always @( pmpaddr[25:0])
begin
  casez(pmpaddr[25:0])
    26'b??_????_????_????_????_????_???0 : addr_mask[31:0] = 32'hffffff80; //128B
    26'b??_????_????_????_????_????_??01 : addr_mask[31:0] = 32'hffffff00; //256B
    26'b??_????_????_????_????_????_?011 : addr_mask[31:0] = 32'hfffffe00; //512B
    26'b??_????_????_????_????_????_0111 : addr_mask[31:0] = 32'hfffffc00; //1KB
    26'b??_????_????_????_????_???0_1111 : addr_mask[31:0] = 32'hfffff800; //2KB
    26'b??_????_????_????_????_??01_1111 : addr_mask[31:0] = 32'hfffff000; //4KB
    26'b??_????_????_????_????_?011_1111 : addr_mask[31:0] = 32'hffffe000; //8KB
    26'b??_????_????_????_????_0111_1111 : addr_mask[31:0] = 32'hffffc000; //16KB
    26'b??_????_????_????_???0_1111_1111 : addr_mask[31:0] = 32'hffff8000; //32KB
    26'b??_????_????_????_??01_1111_1111 : addr_mask[31:0] = 32'hffff0000; //64KB
    26'b??_????_????_????_?011_1111_1111 : addr_mask[31:0] = 32'hfffe0000; //128KB
    26'b??_????_????_????_0111_1111_1111 : addr_mask[31:0] = 32'hfffc0000; //256KB
    26'b??_????_????_???0_1111_1111_1111 : addr_mask[31:0] = 32'hfff80000; //512KB
    26'b??_????_????_??01_1111_1111_1111 : addr_mask[31:0] = 32'hfff00000; //1M
    26'b??_????_????_?011_1111_1111_1111 : addr_mask[31:0] = 32'hffe00000; //2M
    26'b??_????_????_0111_1111_1111_1111 : addr_mask[31:0] = 32'hffc00000; //4M
    26'b??_????_???0_1111_1111_1111_1111 : addr_mask[31:0] = 32'hff800000; //8M
    26'b??_????_??01_1111_1111_1111_1111 : addr_mask[31:0] = 32'hff000000; //16M
    26'b??_????_?011_1111_1111_1111_1111 : addr_mask[31:0] = 32'hfe000000; //32M
    26'b??_????_0111_1111_1111_1111_1111 : addr_mask[31:0] = 32'hfc000000; //64M
    26'b??_???0_1111_1111_1111_1111_1111 : addr_mask[31:0] = 32'hf8000000; //128M
    26'b??_??01_1111_1111_1111_1111_1111 : addr_mask[31:0] = 32'hf0000000; //256M
    26'b??_?011_1111_1111_1111_1111_1111 : addr_mask[31:0] = 32'he0000000; //512M
    26'b??_0111_1111_1111_1111_1111_1111 : addr_mask[31:0] = 32'hc0000000; //1G
    26'b?0_1111_1111_1111_1111_1111_1111 : addr_mask[31:0] = 32'h80000000; //2G
    26'b01_1111_1111_1111_1111_1111_1111 : addr_mask[31:0] = 32'h00000000; //4G
    default                              : addr_mask[31:0] = 32'b0;
  endcase
// &CombEnd; @137
end

// &ModuleEnd; @139
endmodule


