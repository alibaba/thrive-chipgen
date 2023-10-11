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

// *                                                                           *
// * T-Head Confidential                                           *
// * -------------------------------                                           *
// * This file and all its contents are properties of C-Sky Microsystems. The  *
// * information contained herein is confidential and proprietary and is not   *
// * to be disclosed outside of C-Sky Microsystems except under a              *
// * Non-Disclosure Agreement (NDA).                                           *
// *                                                                           *
// *****************************************************************************
// FILE NAME       : dff.v
// AUTHOR          : Huang Linyong
// ORIGINAL TIME   : 2022.10.13
// FUNCTION        : 
// // RESET        : Async reset
// DFT             :
// DFP             :
// VERIFICATION    :
// RELEASE HISTORY :
// $Id:
// *****************************************************************************
`timescale 1ps/1ps

(* dont_touch = "yes" *) 
module dff1 #(parameter BITWIDTH = 1) (
	input  			clk,
	input  [BITWIDTH-1:0]	din,
	output reg [BITWIDTH-1:0]	dout
);

always @(posedge clk) begin
 	dout   <= din;
end

endmodule










