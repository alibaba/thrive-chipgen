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

// SPDX-License-Identifier: Apache-2.0
// Copyright 2019 Western Digital Corporation or its affiliates.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// all flops call the rvdff flop

module rvdff #( parameter WIDTH=1 )
   (
     input logic [WIDTH-1:0] din,
     input logic           clk,
     input logic                   rst_l,

     output logic [WIDTH-1:0] dout
     );

`ifdef CLOCKGATE
   always @(posedge tb_top.clk) begin
      #0 $strobe("CG: %0t %m din %x dout %x clk %b width %d",$time,din,dout,clk,WIDTH);
   end
`endif

   always_ff @(posedge clk or negedge rst_l) begin
      if (rst_l == 0)
        dout[WIDTH-1:0] <= 0;
      else
        dout[WIDTH-1:0] <= din[WIDTH-1:0];
   end


endmodule

// rvdff with 2:1 input mux to flop din iff sel==1
module rvdffs #( parameter WIDTH=1 )
   (
     input logic [WIDTH-1:0] din,
     input logic             en,
     input logic           clk,
     input logic                   rst_l,
     output logic [WIDTH-1:0] dout
     );

   rvdff #(WIDTH) dffs (.din((en) ? din[WIDTH-1:0] : dout[WIDTH-1:0]), .*);

endmodule

// rvdff with en and clear
module rvdffsc #( parameter WIDTH=1 )
   (
     input logic [WIDTH-1:0] din,
     input logic             en,
     input logic             clear,
     input logic           clk,
     input logic                   rst_l,
     output logic [WIDTH-1:0] dout
     );

   logic [WIDTH-1:0]          din_new;
   assign din_new = {WIDTH{~clear}} & (en ? din[WIDTH-1:0] : dout[WIDTH-1:0]);
   rvdff #(WIDTH) dffsc (.din(din_new[WIDTH-1:0]), .*);

endmodule

// versions with clock enables .clken to assist in RV_FPGA_OPTIMIZE
module rvdff_fpga #( parameter WIDTH=1 )
   (
     input logic [WIDTH-1:0] din,
     input logic           clk,
     input logic           clken,
     input logic           rawclk,
     input logic           rst_l,
     input logic           scan_mode,

     output logic [WIDTH-1:0] dout
     );

`ifdef RV_FPGA_OPTIMIZE
    rvdffs #(WIDTH) dffs (.clk(rawclk), .en(clken), .*);
`else
    rvdff #(WIDTH)  dff (.*);
`endif



endmodule

// rvdff with 2:1 input mux to flop din iff sel==1
module rvdffs_fpga #( parameter WIDTH=1 )
   (
     input logic [WIDTH-1:0] din,
     input logic             en,
     input logic           clk,
     input logic           clken,
     input logic           rawclk,
     input logic           rst_l,
     input logic           scan_mode,
     output logic [WIDTH-1:0] dout
     );

`ifdef RV_FPGA_OPTIMIZE
   rvdffs #(WIDTH)   dffs (.clk(rawclk), .en(clken & en), .*);
`else
   rvdffs #(WIDTH)   dffs (.*);
`endif

endmodule

// rvdff with en and clear
module rvdffsc_fpga #( parameter WIDTH=1 )
   (
     input logic [WIDTH-1:0] din,
     input logic             en,
     input logic             clear,
     input logic             clk,
     input logic             clken,
     input logic             rawclk,
     input logic             rst_l,
     input logic             scan_mode,
     output logic [WIDTH-1:0] dout
     );

`ifdef RV_FPGA_OPTIMIZE
   rvdffs  #(WIDTH)   dffs  (.clk(rawclk), .din(din[WIDTH-1:0] & {WIDTH{~clear}}),.en((en | clear) & clken), .*);
`else
   rvdffsc #(WIDTH)   dffsc (.*);
`endif

endmodule


module rvicg
  (
   input logic TE, E, CP,
   output Q
   );

   logic  en_ff;
   logic  enable;

   assign      enable = E | TE;

`ifdef VERILATOR
   always @(negedge CP) begin
      en_ff <= enable;
   end
`else
   always @(CP, enable) begin
      if(!CP)
        en_ff = enable;
   end
`endif
   assign Q = CP & en_ff;

endmodule

`ifndef RV_FPGA_OPTIMIZE
module rvclkhdr
  (
   input  logic en,
   input  logic clk,
   input  logic scan_mode,
   output logic l1clk
   );

   logic        TE;
   assign       TE = scan_mode;

   rvicg clkhdr ( .*, .E(en), .CP(clk), .Q(l1clk));

endmodule // rvclkhdr
`endif

module rvoclkhdr
  (
   input  logic en,
   input  logic clk,
   input  logic scan_mode,
   output logic l1clk
   );

   logic        TE;
   assign       TE = scan_mode;

`ifdef RV_FPGA_OPTIMIZE
   assign l1clk = clk;
`else
   rvicg rvclkhdr ( .*, .E(en), .CP(clk), .Q(l1clk));
`endif

endmodule

module rvdffe #( parameter WIDTH=1, parameter OVERRIDE=0 )
   (
     input  logic [WIDTH-1:0] din,
     input  logic           en,
     input  logic           clk,
     input  logic           rst_l,
     input  logic             scan_mode,
     output logic [WIDTH-1:0] dout
     );

   logic                      l1clk;


`ifndef PHYSICAL
   if (WIDTH >= 8 || OVERRIDE==1) begin: genblock
`endif

`ifdef RV_FPGA_OPTIMIZE
      rvdffs #(WIDTH) dff ( .* );
`else
      rvclkhdr clkhdr ( .* );
      rvdff #(WIDTH) dff (.*, .clk(l1clk));
`endif

`ifndef PHYSICAL
   end
   else
      $error("%m: rvdffe width must be >= 8");
`endif


endmodule // rvdffe
