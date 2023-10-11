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

`include "network_define.h"
`include "xocc_define.h"

// &ModuleBeg; @19
module noc_wrapper (
	nou_clk,
	nou_rstn,
	myLocX,
	myLocY,
	myChipID,
	nou_noc_data_tid,
	nou_noc_data_type,
	nou_noc_data,
	nou_noc_data_valid,
	noc_nou_data_ready,
	noc_nou_data_tid,
	noc_nou_data_type,
	noc_nou_data,
	noc_nou_data_valid,
	nou_noc_data_ready,
	nou_noc_rsp_tid,
	nou_noc_rsp_type,
	nou_noc_rsp,
	nou_noc_rsp_valid,
	noc_nou_rsp_ready,
	noc_nou_rsp_tid,
	noc_nou_rsp_type,
	noc_nou_rsp,
	noc_nou_rsp_valid,
	nou_noc_rsp_ready,
	dat_W_out,
	dat_vld_W_out,
	dat_yummy_W_in,
	dat_W_in,
	dat_vld_W_in,
	dat_yummy_W_out,
	rsp_W_out,
	rsp_vld_W_out,
	rsp_yummy_W_in,
	rsp_W_in,
	rsp_vld_W_in,
	rsp_yummy_W_out,
	dat_E_out,
	dat_vld_E_out,
	dat_yummy_E_in,
	dat_E_in,
	dat_vld_E_in,
	dat_yummy_E_out,
	rsp_E_out,
	rsp_vld_E_out,
	rsp_yummy_E_in,
	rsp_E_in,
	rsp_vld_E_in,
	rsp_yummy_E_out,
	dat_N_out,
	dat_vld_N_out,
	dat_yummy_N_in,
	dat_N_in,
	dat_vld_N_in,
	dat_yummy_N_out,
	rsp_N_out,
	rsp_vld_N_out,
	rsp_yummy_N_in,
	rsp_N_in,
	rsp_vld_N_in,
	rsp_yummy_N_out,
	dat_S_out,
	dat_vld_S_out,
	dat_yummy_S_in,
	dat_S_in,
	dat_vld_S_in,
	dat_yummy_S_out,
	rsp_S_out,
	rsp_vld_S_out,
	rsp_yummy_S_in,
	rsp_S_in,
	rsp_vld_S_in,
	rsp_yummy_S_out
);

// &Ports; @20
input   [0:0]                    nou_clk;          
input   [0:0]                    nou_rstn;         
input   [`XY_WIDTH-1:0]          myLocX;           
input   [`XY_WIDTH-1:0]          myLocY;           
input   [`CHIP_ID_WIDTH-1:0]     myChipID;         
input   [`TID_WIDTH-1:0]         nou_noc_data_tid; 
input   [`TYPE_WIDTH-1:0]        nou_noc_data_type;
input   [`DAT_DAT_WIDTH-1:0]     nou_noc_data;     
input   [0:0]                    nou_noc_data_valid;
output  [0:0]                    noc_nou_data_ready;
output  [`TID_WIDTH-1:0]         noc_nou_data_tid; 
output  [`TYPE_WIDTH-1:0]        noc_nou_data_type;
output  [`DAT_DAT_WIDTH-1:0]     noc_nou_data;     
output  [0:0]                    noc_nou_data_valid;
input   [0:0]                    nou_noc_data_ready;
input   [`TID_WIDTH-1:0]         nou_noc_rsp_tid;  
input   [`TYPE_WIDTH-1:0]        nou_noc_rsp_type; 
input   [`RSP_DAT_WIDTH-1:0]     nou_noc_rsp;      
input   [0:0]                    nou_noc_rsp_valid;
output  [0:0]                    noc_nou_rsp_ready;
output  [`TID_WIDTH-1:0]         noc_nou_rsp_tid;  
output  [`TYPE_WIDTH-1:0]        noc_nou_rsp_type; 
output  [`RSP_DAT_WIDTH-1:0]     noc_nou_rsp;      
output  [0:0]                    noc_nou_rsp_valid;
input   [0:0]                    nou_noc_rsp_ready;
output  [`DATA_WIDTH-1:0]        dat_W_out;        
output  [0:0]                    dat_vld_W_out;    
input   [0:0]                    dat_yummy_W_in;   
input   [`DATA_WIDTH-1:0]        dat_W_in;         
input   [0:0]                    dat_vld_W_in;     
output  [0:0]                    dat_yummy_W_out;  
output  [`RSP_WIDTH-1:0]         rsp_W_out;        
output  [0:0]                    rsp_vld_W_out;    
input   [0:0]                    rsp_yummy_W_in;   
input   [`RSP_WIDTH-1:0]         rsp_W_in;         
input   [0:0]                    rsp_vld_W_in;     
output  [0:0]                    rsp_yummy_W_out;  
output  [`DATA_WIDTH-1:0]        dat_E_out;        
output  [0:0]                    dat_vld_E_out;    
input   [0:0]                    dat_yummy_E_in;   
input   [`DATA_WIDTH-1:0]        dat_E_in;         
input   [0:0]                    dat_vld_E_in;     
output  [0:0]                    dat_yummy_E_out;  
output  [`RSP_WIDTH-1:0]         rsp_E_out;        
output  [0:0]                    rsp_vld_E_out;    
input   [0:0]                    rsp_yummy_E_in;   
input   [`RSP_WIDTH-1:0]         rsp_E_in;         
input   [0:0]                    rsp_vld_E_in;     
output  [0:0]                    rsp_yummy_E_out;  
output  [`DATA_WIDTH-1:0]        dat_N_out;        
output  [0:0]                    dat_vld_N_out;    
input   [0:0]                    dat_yummy_N_in;   
input   [`DATA_WIDTH-1:0]        dat_N_in;         
input   [0:0]                    dat_vld_N_in;     
output  [0:0]                    dat_yummy_N_out;  
output  [`RSP_WIDTH-1:0]         rsp_N_out;        
output  [0:0]                    rsp_vld_N_out;    
input   [0:0]                    rsp_yummy_N_in;   
input   [`RSP_WIDTH-1:0]         rsp_N_in;         
input   [0:0]                    rsp_vld_N_in;     
output  [0:0]                    rsp_yummy_N_out;  
output  [`DATA_WIDTH-1:0]        dat_S_out;        
output  [0:0]                    dat_vld_S_out;    
input   [0:0]                    dat_yummy_S_in;   
input   [`DATA_WIDTH-1:0]        dat_S_in;         
input   [0:0]                    dat_vld_S_in;     
output  [0:0]                    dat_yummy_S_out;  
output  [`RSP_WIDTH-1:0]         rsp_S_out;        
output  [0:0]                    rsp_vld_S_out;    
input   [0:0]                    rsp_yummy_S_in;   
input   [`RSP_WIDTH-1:0]         rsp_S_in;         
input   [0:0]                    rsp_vld_S_in;     
output  [0:0]                    rsp_yummy_S_out;  



// &Instance("router_intf_top"); @22
router_intf_top x_router_intf_top (
	.clk                  (nou_clk           ),
	.rst                  (nou_rstn          ),
	.myLocX               (myLocX            ),
	.myLocY               (myLocY            ),
	.myChipID             (myChipID          ),
	.nou_router_data_tid  (nou_noc_data_tid  ),
	.nou_router_data_type (nou_noc_data_type ),
	.nou_router_data      (nou_noc_data      ),
	.nou_router_data_valid(nou_noc_data_valid),
	.router_nou_data_ready(noc_nou_data_ready),
	.router_nou_data_tid  (noc_nou_data_tid  ),
	.router_nou_data_type (noc_nou_data_type ),
	.router_nou_data      (noc_nou_data      ),
	.router_nou_data_valid(noc_nou_data_valid),
	.nou_router_data_ready(nou_noc_data_ready),
	.nou_router_rsp_tid   (nou_noc_rsp_tid   ),
	.nou_router_rsp_type  (nou_noc_rsp_type  ),
	.nou_router_rsp_data  (nou_noc_rsp       ),
	.nou_router_rsp_valid (nou_noc_rsp_valid ),
	.router_nou_rsp_ready (noc_nou_rsp_ready ),
	.router_nou_rsp_tid   (noc_nou_rsp_tid   ),
	.router_nou_rsp_type  (noc_nou_rsp_type  ),
	.router_nou_rsp_data  (noc_nou_rsp       ),
	.router_nou_rsp_valid (noc_nou_rsp_valid ),
	.nou_router_rsp_ready (nou_noc_rsp_ready ),
	.dat_W_out            (dat_W_out         ),
	.dat_vld_W_out        (dat_vld_W_out     ),
	.dat_yummy_W_in       (dat_yummy_W_in    ),
	.dat_W_in             (dat_W_in          ),
	.dat_vld_W_in         (dat_vld_W_in      ),
	.dat_yummy_W_out      (dat_yummy_W_out   ),
	.rsp_W_out            (rsp_W_out         ),
	.rsp_vld_W_out        (rsp_vld_W_out     ),
	.rsp_yummy_W_in       (rsp_yummy_W_in    ),
	.rsp_W_in             (rsp_W_in          ),
	.rsp_vld_W_in         (rsp_vld_W_in      ),
	.rsp_yummy_W_out      (rsp_yummy_W_out   ),
	.dat_E_out            (dat_E_out         ),
	.dat_vld_E_out        (dat_vld_E_out     ),
	.dat_yummy_E_in       (dat_yummy_E_in    ),
	.dat_E_in             (dat_E_in          ),
	.dat_vld_E_in         (dat_vld_E_in      ),
	.dat_yummy_E_out      (dat_yummy_E_out   ),
	.rsp_E_out            (rsp_E_out         ),
	.rsp_vld_E_out        (rsp_vld_E_out     ),
	.rsp_yummy_E_in       (rsp_yummy_E_in    ),
	.rsp_E_in             (rsp_E_in          ),
	.rsp_vld_E_in         (rsp_vld_E_in      ),
	.rsp_yummy_E_out      (rsp_yummy_E_out   ),
	.dat_N_out            (dat_N_out         ),
	.dat_vld_N_out        (dat_vld_N_out     ),
	.dat_yummy_N_in       (dat_yummy_N_in    ),
	.dat_N_in             (dat_N_in          ),
	.dat_vld_N_in         (dat_vld_N_in      ),
	.dat_yummy_N_out      (dat_yummy_N_out   ),
	.rsp_N_out            (rsp_N_out         ),
	.rsp_vld_N_out        (rsp_vld_N_out     ),
	.rsp_yummy_N_in       (rsp_yummy_N_in    ),
	.rsp_N_in             (rsp_N_in          ),
	.rsp_vld_N_in         (rsp_vld_N_in      ),
	.rsp_yummy_N_out      (rsp_yummy_N_out   ),
	.dat_S_out            (dat_S_out         ),
	.dat_vld_S_out        (dat_vld_S_out     ),
	.dat_yummy_S_in       (dat_yummy_S_in    ),
	.dat_S_in             (dat_S_in          ),
	.dat_vld_S_in         (dat_vld_S_in      ),
	.dat_yummy_S_out      (dat_yummy_S_out   ),
	.rsp_S_out            (rsp_S_out         ),
	.rsp_vld_S_out        (rsp_vld_S_out     ),
	.rsp_yummy_S_in       (rsp_yummy_S_in    ),
	.rsp_S_in             (rsp_S_in          ),
	.rsp_vld_S_in         (rsp_vld_S_in      ),
	.rsp_yummy_S_out      (rsp_yummy_S_out   )
);
// @23 &ConnRule(r'router_', r'noc_');
// @24 &ConnRule(r'rsp_data', r'rsp');
// @25 &Connect(
// @26     .clk (nou_clk),
// @27     .rst (nou_rstn),
// @28 );


endmodule
