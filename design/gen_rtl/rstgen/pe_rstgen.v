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

// &ModuleBeg; @16
module pe_rstgen (
	sys_rstn,
	sys_clk,
	sram_soft_rstn,
	mem_sub_sys_rstn,
	dispatcher_soft_rstn,
	dispatcher_clk,
	dispatcher_rstn,
	regular_0_soft_rstn,
	regular_0_clk,
	regular_0_rstn,
	regular_1_soft_rstn,
	regular_1_clk,
	regular_1_rstn,
	dsa_0_soft_rstn,
	dsa_0_clk,
	dsa_0_rstn,
	dsa_1_soft_rstn,
	dsa_1_clk,
	dsa_1_rstn,
	dsa_2_soft_rstn,
	dsa_2_clk,
	dsa_2_rstn,
	nou_soft_rstn,
	nou_clk,
	nou_rstn
);

// &Ports; @17
input   [0:0] sys_rstn;           
input   [0:0] sys_clk;            
input   [0:0] sram_soft_rstn;     
output  [0:0] mem_sub_sys_rstn;   
input   [0:0] dispatcher_soft_rstn;
input   [0:0] dispatcher_clk;     
output  [0:0] dispatcher_rstn;    
input   [0:0] regular_0_soft_rstn;
input   [0:0] regular_0_clk;      
output  [0:0] regular_0_rstn;     
input   [0:0] regular_1_soft_rstn;
input   [0:0] regular_1_clk;      
output  [0:0] regular_1_rstn;     
input   [0:0] dsa_0_soft_rstn;    
input   [0:0] dsa_0_clk;          
output  [0:0] dsa_0_rstn;         
input   [0:0] dsa_1_soft_rstn;    
input   [0:0] dsa_1_clk;          
output  [0:0] dsa_1_rstn;         
input   [0:0] dsa_2_soft_rstn;    
input   [0:0] dsa_2_clk;          
output  [0:0] dsa_2_rstn;         
input   [0:0] nou_soft_rstn;      
input   [0:0] nou_clk;            
output  [0:0] nou_rstn;           

wire    [0:0] sys_rstn_o;


// &Instance("async_rstgen", "x_sys_rstgen") @19
async_rstgen x_sys_rstgen (
	.rst_i     (sys_rstn  ),
	.soft_rst_i(1'b1      ),
	.clk_i     (sys_clk   ),
	.rst_n     (sys_rstn_o)
);
// @20 &Connect(
// @21     .clk_i(sys_clk),
// @22     .rst_i(sys_rstn),
// @23     .soft_rst_i(1'b1),
// @24     .rst_n(sys_rstn_o)
// @25 );

// &Instance("async_rstgen", "x_memsys_rstgen") @27
async_rstgen x_memsys_rstgen (
	.rst_i     (sys_rstn        ),
	.soft_rst_i(sram_soft_rstn  ),
	.clk_i     (sys_clk         ),
	.rst_n     (mem_sub_sys_rstn)
);
// @28 &Connect(
// @29     .clk_i(sys_clk),
// @30     .rst_i(sys_rstn),
// @31     .soft_rst_i(sram_soft_rstn),
// @32     .rst_n(mem_sub_sys_rstn)
// @33 );

// &Instance("async_rstgen", "x_dispatcher_rstgen") @35
async_rstgen x_dispatcher_rstgen (
	.rst_i     (sys_rstn_o          ),
	.soft_rst_i(dispatcher_soft_rstn),
	.clk_i     (dispatcher_clk      ),
	.rst_n     (dispatcher_rstn     )
);
// @36 &Connect(
// @37     .clk_i(dispatcher_clk),
// @38     .rst_i(sys_rstn_o),
// @39     .soft_rst_i(dispatcher_soft_rstn),
// @40     .rst_n(dispatcher_rstn)
// @41 );

// &Instance("async_rstgen", "x_regular_0_rstgen") @43
async_rstgen x_regular_0_rstgen (
	.rst_i     (sys_rstn_o         ),
	.soft_rst_i(regular_0_soft_rstn),
	.clk_i     (regular_0_clk      ),
	.rst_n     (regular_0_rstn     )
);
// @44 &Connect(
// @45     .clk_i(regular_0_clk),
// @46     .rst_i(sys_rstn_o),
// @47     .soft_rst_i(regular_0_soft_rstn),
// @48     .rst_n(regular_0_rstn)
// @49 );

// &Instance("async_rstgen", "x_regular_1_rstgen") @51
async_rstgen x_regular_1_rstgen (
	.rst_i     (sys_rstn_o         ),
	.soft_rst_i(regular_1_soft_rstn),
	.clk_i     (regular_1_clk      ),
	.rst_n     (regular_1_rstn     )
);
// @52 &Connect(
// @53     .clk_i(regular_1_clk),
// @54     .rst_i(sys_rstn_o),
// @55     .soft_rst_i(regular_1_soft_rstn),
// @56     .rst_n(regular_1_rstn)
// @57 );

// &Instance("async_rstgen", "x_dsa_0_rstgen") @59
async_rstgen x_dsa_0_rstgen (
	.rst_i     (sys_rstn_o     ),
	.soft_rst_i(dsa_0_soft_rstn),
	.clk_i     (dsa_0_clk      ),
	.rst_n     (dsa_0_rstn     )
);
// @60 &Connect(
// @61     .clk_i(dsa_0_clk),
// @62     .rst_i(sys_rstn_o),
// @63     .soft_rst_i(dsa_0_soft_rstn),
// @64     .rst_n(dsa_0_rstn)
// @65 );

// &Instance("async_rstgen", "x_dsa_1_rstgen") @67
async_rstgen x_dsa_1_rstgen (
	.rst_i     (sys_rstn_o     ),
	.soft_rst_i(dsa_1_soft_rstn),
	.clk_i     (dsa_1_clk      ),
	.rst_n     (dsa_1_rstn     )
);
// @68 &Connect(
// @69     .clk_i(dsa_1_clk),
// @70     .rst_i(sys_rstn_o),
// @71     .soft_rst_i(dsa_1_soft_rstn),
// @72     .rst_n(dsa_1_rstn)
// @73 );

// &Instance("async_rstgen", "x_dsa_2_rstgen") @75
async_rstgen x_dsa_2_rstgen (
	.rst_i     (sys_rstn_o     ),
	.soft_rst_i(dsa_2_soft_rstn),
	.clk_i     (dsa_2_clk      ),
	.rst_n     (dsa_2_rstn     )
);
// @76 &Connect(
// @77     .clk_i(dsa_2_clk),
// @78     .rst_i(sys_rstn_o),
// @79     .soft_rst_i(dsa_2_soft_rstn),
// @80     .rst_n(dsa_2_rstn)
// @81 );

// &Instance("async_rstgen", "x_nou_rstgen") @83
async_rstgen x_nou_rstgen (
	.rst_i     (sys_rstn_o   ),
	.soft_rst_i(nou_soft_rstn),
	.clk_i     (nou_clk      ),
	.rst_n     (nou_rstn     )
);
// @84 &Connect(
// @85     .clk_i(nou_clk),
// @86     .rst_i(sys_rstn_o),
// @87     .soft_rst_i(nou_soft_rstn),
// @88     .rst_n(nou_rstn)
// @89 );


endmodule
