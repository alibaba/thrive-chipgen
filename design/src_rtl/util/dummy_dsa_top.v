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

module dummy_dsa_top (
	dsa_xocc_cmd_in,
	dsa_cmd_fifo_empty,
	dsa_rsp_fifo_full,
	dsa_cmd_fifo_rd_en,
	dsa_rsp_fifo_wr_en,
	dsa_xocc_cmd_out,
	axi_aclk,
	axi_aresetn,
	axi_awid,
	axi_awaddr,
	axi_awlen,
	axi_awsize,
	axi_awburst,
	axi_awlock,
	axi_awcache,
	axi_awprot,
	axi_awqos,
	axi_awvalid,
	axi_awready,
	axi_wdata,
	axi_wstrb,
	axi_wlast,
	axi_wvalid,
	axi_wready,
	axi_bid,
	axi_bresp,
	axi_bvalid,
	axi_bready,
	axi_arid,
	axi_araddr,
	axi_arlen,
	axi_arsize,
	axi_arburst,
	axi_arlock,
	axi_arcache,
	axi_arprot,
	axi_arqos,
	axi_arvalid,
	axi_arready,
	axi_rid,
	axi_rdata,
	axi_rresp,
	axi_rlast,
	axi_rvalid,
	axi_rready
);


parameter DSA_CMD_WIDTH = 96;
parameter DSA_RSP_WIDTH = 32;

// Parameters of Axi Master Bus Interface axi
parameter integer AXI_BURST_LENGTH_WIDTH  = 8;		//width of AXI burst length
parameter integer AXI_BURST_SIZE_WIDTH  = 3;		//width of AXI burst size
parameter integer AXI_ID_WIDTH	= 1;
parameter integer AXI_ADDR_WIDTH	= 32;
parameter integer AXI_DATA_WIDTH	= 1024;

input   [DSA_CMD_WIDTH-1:0] dsa_xocc_cmd_in;
input   dsa_cmd_fifo_empty;
input   dsa_rsp_fifo_full;
output  dsa_cmd_fifo_rd_en;
output  dsa_rsp_fifo_wr_en;
output  [DSA_RSP_WIDTH-1:0] dsa_xocc_cmd_out;
input   [0:0]                     axi_aclk;  
input   [0:0]                     axi_aresetn;
output  [AXI_ID_WIDTH-1:0]        axi_awid;  
output  [AXI_ADDR_WIDTH-1:0]      axi_awaddr;
output  [7:0]                     axi_awlen; 
output  [2:0]                     axi_awsize;
output  [1:0]                     axi_awburst;
output  [0:0]                     axi_awlock;
output  [3:0]                     axi_awcache;
output  [2:0]                     axi_awprot;
output  [3:0]                     axi_awqos; 
output  [0:0]                     axi_awvalid;
input   [0:0]                     axi_awready;
output  [AXI_DATA_WIDTH-1:0]      axi_wdata; 
output  [AXI_DATA_WIDTH/8-1:0]    axi_wstrb; 
output  [0:0]                     axi_wlast; 
output  [0:0]                     axi_wvalid;
input   [0:0]                     axi_wready;
input   [AXI_ID_WIDTH-1:0]        axi_bid;   
input   [1:0]                     axi_bresp; 
input   [0:0]                     axi_bvalid;
output  [0:0]                     axi_bready;
output  [AXI_ID_WIDTH-1:0]        axi_arid;  
output  [AXI_ADDR_WIDTH-1:0]      axi_araddr;
output  [7:0]                     axi_arlen; 
output  [2:0]                     axi_arsize;
output  [1:0]                     axi_arburst;
output  [0:0]                     axi_arlock;
output  [3:0]                     axi_arcache;
output  [2:0]                     axi_arprot;
output  [3:0]                     axi_arqos; 
output  [0:0]                     axi_arvalid;
input   [0:0]                     axi_arready;
input   [AXI_ID_WIDTH-1:0]        axi_rid;   
input   [AXI_DATA_WIDTH-1:0]      axi_rdata; 
input   [1:0]                     axi_rresp; 
input   [0:0]                     axi_rlast; 
input   [0:0]                     axi_rvalid;
output  [0:0]                     axi_rready;

	reg rd_en, wr_en;
    reg hit_flag;
    reg init_tx;
    reg init_rx;

    wire tx_done;
    wire rx_done;
    wire axi_error;
    reg read_enable;
    reg write_enable;
    reg [AXI_DATA_WIDTH-1:0] write_data;
    reg [AXI_DATA_WIDTH-1:0] read_data;


    always@(posedge axi_aclk or negedge axi_aresetn) begin
		if(!axi_aresetn) begin
		    rd_en <= 'b0;
            hit_flag <= 1'b0;
		end
		else if(~dsa_cmd_fifo_empty & ~hit_flag) begin
		    rd_en <= 1'b1;
            hit_flag <= 1'b1;
        end else if (init_tx) begin
            hit_flag <= 1'b0;
		end else begin
			rd_en <= 'b0;
            hit_flag <= hit_flag;   //ensure transfer issued only once
		end
	end

    assign dsa_cmd_fifo_rd_en = rd_en;
    assign dsa_rsp_fifo_wr_en = 1'b0;
    assign dsa_xocc_cmd_out = 'b0;

    always@(posedge axi_aclk or negedge axi_aresetn) begin
		if(!axi_aresetn) begin
		    init_rx <= 'b0;
		end
		else if(rd_en) begin
		    init_rx <= 1'b1;
		end else begin
			init_rx <= 'b0;
		end
	end

    always@(posedge axi_aclk or negedge axi_aresetn) begin
		if(!axi_aresetn) begin
		    write_data <= 'b0;
		end
		else if(axi_wvalid & axi_wready) begin
		    write_data <= write_data + {64{8'b1}};
        end else if(hit_flag & init_tx) begin
            write_data <= read_data;
		end else begin
			write_data <= write_data;
		end
	end

    always@(posedge axi_aclk or negedge axi_aresetn) begin
		if(!axi_aresetn) begin
		    read_data <= 'b0;
		end
		else if(axi_rvalid & axi_rready) begin
		    read_data <= axi_rdata;
		end else begin
			read_data <= read_data;
		end
	end

    always@(posedge axi_aclk or negedge axi_aresetn) begin
		if(!axi_aresetn) begin
		    init_tx <= 'b0;
		end
		else if(hit_flag & rx_done) begin   //write after read
		    init_tx <= 1'b1;
		end else begin
			init_tx <= 'b0;
		end
	end

axim_top #(
	.BURST_LENGTH_WIDTH(AXI_BURST_LENGTH_WIDTH),
	.BURST_SIZE_WIDTH(AXI_BURST_SIZE_WIDTH),
	.AXI_ID_WIDTH(AXI_ID_WIDTH),
	.AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
	.AXI_DATA_WIDTH(AXI_DATA_WIDTH)
) x_axim_top (
	.write_burst_length (8'd7       ),
	.read_burst_length  (8'd0       ),
	.write_burst_size   (3'b110     ),
	.read_burst_size    (3'b110     ),
	.read_enable        (1'b1       ),
	.write_enable       (1'b1       ),
	.init_write         (init_tx    ),
	.init_read          (init_rx    ),
	.write_start_address(32'h2300000),
	.read_start_address (32'h2000000),
	.write_data         (write_data ),
	.tx_done            (axi_tx_done),
	.rx_done            (axi_rx_done),
	.error              (axi_error  ),
	.aclk               (axi_aclk   ),
	.aresetn            (axi_aresetn),
	.awid               (axi_awid   ),
	.awaddr             (axi_awaddr ),
	.awlen              (axi_awlen  ),
	.awsize             (axi_awsize ),
	.awburst            (axi_awburst),
	.awlock             (axi_awlock ),
	.awcache            (axi_awcache),
	.awprot             (axi_awprot ),
	.awqos              (axi_awqos  ),
	.awvalid            (axi_awvalid),
	.awready            (axi_awready),
	.wdata              (axi_wdata  ),
	.wstrb              (axi_wstrb  ),
	.wlast              (axi_wlast  ),
	.wvalid             (axi_wvalid ),
	.wready             (axi_wready ),
	.bid                (axi_bid    ),
	.bresp              (axi_bresp  ),
	.bvalid             (axi_bvalid ),
	.bready             (axi_bready ),
	.arid               (axi_arid   ),
	.araddr             (axi_araddr ),
	.arlen              (axi_arlen  ),
	.arsize             (axi_arsize ),
	.arburst            (axi_arburst),
	.arlock             (axi_arlock ),
	.arcache            (axi_arcache),
	.arprot             (axi_arprot ),
	.arqos              (axi_arqos  ),
	.arvalid            (axi_arvalid),
	.arready            (axi_arready),
	.rid                (axi_rid    ),
	.rdata              (axi_rdata  ),
	.rresp              (axi_rresp  ),
	.rlast              (axi_rlast  ),
	.rvalid             (axi_rvalid ),
	.rready             (axi_rready )
);

endmodule
