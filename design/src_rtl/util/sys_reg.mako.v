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

`include "sys_cfg.h"

% if pes.type == "homo":
    % for pe_num,pe in enumerate(chip.pe):
        % for ind,mod in enumerate(pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas):
`define REG_${pe.name.upper()}_${mod.name.upper()}_SOFT_RST 32'h${'{:x}'.format(ind*4+pe_num*64)}
        % endfor
`define REG_${pe.name.upper()}_MEM_SOFT_RST 32'h${'{:x}'.format((ind+1)*4+pe_num*64)}
    % endfor
% elif pes.type == "hetero":
    % for pe in pes.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
`define REG_${pe.name.upper()}_${mod.name.upper()}_SOFT_RST 32'h${'{:x}'.format(ind*4+pe_num*64)}
        % endfor
`define REG_${pe.name.upper()}_MEM_SOFT_RST 32'h${'{:x}'.format((ind+1)*4+pe_num*64)}
    % endfor
% endif

module sys_reg #(
	parameter	AXI_ID_WIDTH = 4,
	parameter	AXI_ADDR_WIDTH = 32,
	parameter	AXI_DATA_WIDTH = 32
) (
    sys_clk,
    sys_rstn,
% if pes.type == "homo":
    % for pe in chip.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
    ${pe.name}_${mod.name}_soft_rstn,
        % endfor
    ${pe.name}_sram_soft_rstn,
    % endfor
% elif pes.type == "hetero":
    % for pe in pes.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
    ${pe.name}_${mod.name}_soft_rstn,
        % endfor
    ${pe.name}_sram_soft_rstn,
    % endfor
% endif
    axi_araddr, 
    axi_arburst, 
    axi_arcache, 
    axi_arid,   
    axi_arlen,  
    axi_arlock, 
    axi_arprot, 
    axi_arqos,  
    axi_arsize, 
    axi_arvalid, 
    axi_awaddr, 
    axi_awburst, 
    axi_awcache, 
    axi_awid,   
    axi_awlen,  
    axi_awlock, 
    axi_awprot, 
    axi_awqos,  
    axi_awsize, 
    axi_awvalid, 
    axi_bready, 
    axi_rready, 
    axi_wdata,  
    axi_wlast,  
    axi_wstrb,  
    axi_wvalid, 
    axi_arready, 
    axi_awready, 
    axi_bid,    
    axi_bresp,  
    axi_bvalid, 
    axi_rdata,  
    axi_rid,    
    axi_rlast,  
    axi_rresp,  
    axi_rvalid, 
    axi_wready 
);

	/*
	 * Clock & reset.
	 */
	input				sys_clk;
	input				sys_rstn;

    /*
     * reg related signal.
     */
% if pes.type == "homo":
    % for pe in chip.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
    output ${pe.name}_${mod.name}_soft_rstn;
        % endfor
    output ${pe.name}_sram_soft_rstn;
    % endfor
% elif pes.type == "hetero":
    % for pe in pes.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
    output ${pe.name}_${mod.name}_soft_rstn;
        % endfor
    output ${pe.name}_sram_soft_rstn;
    % endfor
% endif
    input   [AXI_ADDR_WIDTH-1:0]        axi_araddr; 
    input   [1   :0]                    axi_arburst; 
    input   [3   :0]                    axi_arcache; 
    input   [AXI_ID_WIDTH-1:0]          axi_arid;   
    input   [7   :0]                    axi_arlen;  
    input   [0   :0]                    axi_arlock; 
    input   [2   :0]                    axi_arprot; 
    input   [3   :0]                    axi_arqos;  
    input   [2   :0]                    axi_arsize; 
    input                               axi_arvalid; 
    input   [AXI_ADDR_WIDTH-1:0]        axi_awaddr; 
    input   [1   :0]                    axi_awburst; 
    input   [3   :0]                    axi_awcache; 
    input   [AXI_ID_WIDTH-1:0]          axi_awid;   
    input   [7   :0]                    axi_awlen;  
    input   [0   :0]                    axi_awlock; 
    input   [2   :0]                    axi_awprot; 
    input   [3   :0]                    axi_awqos;  
    input   [2   :0]                    axi_awsize; 
    input                               axi_awvalid; 
    input                               axi_bready; 
    input                               axi_rready; 
    input   [AXI_DATA_WIDTH-1:0]        axi_wdata;  
    input                               axi_wlast;  
    input   [(AXI_DATA_WIDTH/8)-1:0]    axi_wstrb;  
    input                               axi_wvalid; 
    output                              axi_arready; 
    output                              axi_awready; 
    output  [AXI_ID_WIDTH-1:0]          axi_bid;    
    output  [1   :0]                    axi_bresp;  
    output                              axi_bvalid; 
    output  [AXI_DATA_WIDTH-1:0]        axi_rdata;  
    output  [AXI_ID_WIDTH-1:0]          axi_rid;    
    output                              axi_rlast;  
    output  [1   :0]                    axi_rresp;  
    output                              axi_rvalid; 
    output                              axi_wready; 

    reg [31:0]      dummy_reg;
% if pes.type == "homo":
    % for pe in chip.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
    reg  ${pe.name}_${mod.name}_soft_rstn_reg;
        % endfor
    reg  ${pe.name}_sram_soft_rstn_reg;
    % endfor
% elif pes.type == "hetero":
    % for pe in pes.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
    reg  ${pe.name}_${mod.name}_soft_rstn_reg;
        % endfor
    reg  ${pe.name}_sram_soft_rstn_reg;
    % endfor
% endif

    /*
     * Read fsm.
     */
    localparam	R_IDLE = 2'b01,
                R_RESP = 2'b10;

    reg  [1:0]		        r_cur_state;
    reg  [1:0]		        r_nxt_state;
    reg			            ar_ready;
    reg			            r_valid;
    reg [AXI_ID_WIDTH-1:0]  r_id;

    /*
     * Read channel fsm.
     */
    always @(posedge sys_clk or negedge sys_rstn) begin
        if(!sys_rstn) begin
            r_cur_state <= '0;
        end else begin
            r_cur_state <= r_nxt_state;
        end
    end

    //always @(posedge sys_clk or negedge sys_rstn) begin
    always @(*) begin
	    if (~sys_rstn) begin
	        ar_ready <= '0;
	        r_valid  <= '0;
            r_id     <= '0;
	        r_nxt_state    <= R_IDLE;
	    end else begin
	        case (r_cur_state)

	        R_IDLE: begin
	    	    r_valid  <= 0;
	        	if (axi_arvalid) begin
	    	        ar_ready <= 1;
                    r_id     <= axi_arid;
	    	        r_nxt_state    <= R_RESP;
	    	    end
	        end

	        R_RESP: begin
	    	    ar_ready <= 0;
	    	    r_valid  <= 1;
	    	    if (axi_rready) begin
	    	        r_nxt_state    <= R_IDLE;
	    	    end else begin
	    	        r_nxt_state    <= R_RESP;
                end
	        end

            default: begin
                r_nxt_state <= R_IDLE;
	            ar_ready <= 'b0;
	            r_valid  <= 'b0;
                r_id     <= 'b0;
            end

	        endcase
	    end
    end

    /*
     * AXI Lite read signals.
     */
    assign axi_rid     = r_id;
    assign axi_arready = ar_ready;
    assign axi_rvalid  = r_valid;
    assign axi_rlast   = r_valid;
    assign axi_rresp   = 0;
    
    reg [AXI_DATA_WIDTH-1:0] axi_rdata_reg;

    always @(*) begin
        if (~sys_rstn) begin
            axi_rdata_reg <= 'h0;
        end
        else if (r_cur_state == R_RESP) begin
            case (axi_araddr)
% if pes.type == "homo":
    % for pe in chip.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
                `REG_${pe.name.upper()}_${mod.name.upper()}_SOFT_RST : axi_rdata_reg <= ${pe.name}_${mod.name}_soft_rstn_reg;
        % endfor
                `REG_${pe.name.upper()}_MEM_SOFT_RST        : axi_rdata_reg <= ${pe.name}_sram_soft_rstn_reg;
    % endfor
% elif pes.type == "hetero":
    % for pe in pes.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
                `REG_${pe.name.upper()}_${mod.name.upper()}_SOFT_RST : axi_rdata_reg <= ${pe.name}_${mod.name}_soft_rstn_reg;
        % endfor
                `REG_${pe.name.upper()}_MEM_SOFT_RST        : axi_rdata_reg <= ${pe.name}_sram_soft_rstn_reg;
    % endfor
% endif
                default: axi_rdata_reg <= 32'hbadca11;
            endcase
        end
    end

    assign axi_rdata = axi_rdata_reg;

    /*
     * Write fsm.
     */
    localparam  W_IDLE = 3'b001,
		        W_DATA = 3'b010,
		        W_RESP = 3'b100;

    reg  [2:0]		w_nxt_state;
    reg  [2:0]		w_cur_state;
    reg			    aw_ready;
    reg  [1:0]		aw_addr;
    reg			    w_ready;
    reg			    b_valid;
    reg [AXI_ID_WIDTH-1:0] b_id;

    always @(posedge sys_clk or negedge sys_rstn) begin
        if(!sys_rstn) begin
            w_cur_state <= '0;
        end else begin
            w_cur_state <= w_nxt_state;
        end
    end

//    always @(posedge sys_clk or negedge sys_rstn) begin
    always @(*) begin
	    if (~sys_rstn) begin
	        aw_ready <= 0;
	        aw_addr  <= 0;
	        w_ready  <= 0;
	        b_valid  <= 0;
            b_id     <= '0;
	        w_nxt_state    <= W_IDLE;
% if pes.type == "homo":
    % for pe in chip.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
            ${pe.name}_${mod.name}_soft_rstn_reg <= 1'b0;
        % endfor
            ${pe.name}_sram_soft_rstn_reg <= 1'b0;
    % endfor
% elif pes.type == "hetero":
    % for pe in pes.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
            ${pe.name}_${mod.name}_soft_rstn_reg <= 1'b0;
        % endfor
            ${pe.name}_sram_soft_rstn_reg <= 1'b0;
    % endfor
% endif
	    end else begin
	        case (w_cur_state)

	        W_IDLE: begin
	    	    w_ready  <= 0;
	        	if (axi_awvalid) begin
	    	        aw_addr  <= axi_awaddr[1:0];
	    	        aw_ready <= 1;
                    b_id     <= axi_awid;
	    	        w_nxt_state    <= W_DATA;
	    	    end
	        end

	        W_DATA: begin
	    	    aw_ready <= 0;
	    	    if (axi_wvalid) begin
	    	        w_ready <= 1;
	    	        b_valid <= 1;
	    	        w_nxt_state   <= W_RESP;
                    case (axi_awaddr)
% if pes.type == "homo":
    % for pe in chip.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
                        `REG_${pe.name.upper()}_${mod.name.upper()}_SOFT_RST : ${pe.name}_${mod.name}_soft_rstn_reg <= axi_wdata[0];
        % endfor
                        `REG_${pe.name.upper()}_MEM_SOFT_RST        : ${pe.name}_sram_soft_rstn_reg <= axi_wdata[0];
    % endfor
% elif pes.type == "hetero":
    % for pe in pes.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
                        `REG_${pe.name.upper()}_${mod.name.upper()}_SOFT_RST : ${pe.name}_${mod.name}_soft_rstn_reg <= axi_wdata[0];
        % endfor
                        `REG_${pe.name.upper()}_MEM_SOFT_RST        : ${pe.name}_sram_soft_rstn_reg <= axi_wdata[0];
    % endfor
% endif
                        default:  dummy_reg <= axi_wdata;
                    endcase
	    	    end
	        end

	        W_RESP: begin
	    	    if (axi_bready) begin
	    	        b_valid <= 0;
	    	        w_nxt_state   <= W_IDLE;
	    	    end
% if pes.type == "homo":
    % for pe in chip.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
                ${pe.name}_${mod.name}_soft_rstn_reg <= 1'b0;
        % endfor
                ${pe.name}_sram_soft_rstn_reg <= 1'b0;
    % endfor
% elif pes.type == "hetero":
    % for pe in pes.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
                ${pe.name}_${mod.name}_soft_rstn_reg <= 1'b0;
        % endfor
                ${pe.name}_sram_soft_rstn_reg <= 1'b0;
    % endfor
% endif
	        end

            default: begin
                w_nxt_state <= W_IDLE;
	            aw_ready <= 'b0;
	            aw_addr  <= 'b0;
	            w_ready  <= 'b0;
	            b_valid  <= 'b0;
                b_id     <= 'b0;
            end

	        endcase
	    end
    end

    /*
     * AXI Lite write signals.
     */
    assign axi_awready = aw_ready;
    assign axi_wready  = w_ready;
    assign axi_bvalid  = b_valid;
    assign axi_bresp   = 0;
    assign axi_bid     = b_id;

% if pes.type == "homo":
    % for pe in chip.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
    assign ${pe.name}_${mod.name}_soft_rstn = ~${pe.name}_${mod.name}_soft_rstn_reg;
        % endfor
    assign ${pe.name}_sram_soft_rstn = ~${pe.name}_sram_soft_rstn_reg;
    % endfor
% elif pes.type == "hetero":
    % for pe in pes.pe:
        % for mod in pes.pe.rvs.dispatcher+pes.pe.rvs.regular+pes.pe.dsas.dsas:
    assign ${pe.name}_${mod.name}_soft_rstn = ~${pe.name}_${mod.name}_soft_rstn_reg;
        % endfor
    assign ${pe.name}_sram_soft_rstn = ~${pe.name}_sram_soft_rstn_reg;
    % endfor
% endif

endmodule
