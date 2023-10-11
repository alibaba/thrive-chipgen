`include "sys_cfg.h"

`define REG_DISPATCHER_RST_ADDR 32'h0
`define REG_DISPATCHER_PC  32'hc  
`define REG_REGULAR_0_RST_ADDR 32'h4
`define REG_REGULAR_0_PC  32'h10  
`define REG_REGULAR_1_RST_ADDR 32'h8
`define REG_REGULAR_1_PC  32'h14  

module axi_csr #(
	parameter	AXI_ID_WIDTH = 8,
	parameter	AXI_ADDR_WIDTH = 12,
	parameter	AXI_DATA_WIDTH = 32
) (
    aclk,
    arstn,
    dispatcher_pc,
    dispatcher_rst_addr,
    regular_0_pc,
    regular_0_rst_addr,
    regular_1_pc,
    regular_1_rst_addr,
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
	input				aclk;
	input				arstn;

    /*
     * reg related signal.
     */
    input   [31:0]      dispatcher_pc;
    output  [31:0]      dispatcher_rst_addr;
    input   [31:0]      regular_0_pc;
    output  [31:0]      regular_0_rst_addr;
    input   [31:0]      regular_1_pc;
    output  [31:0]      regular_1_rst_addr;

    input   [AXI_ADDR_WIDTH-1:0]  axi_araddr; 
    input   [1   :0]  axi_arburst; 
    input   [3   :0]  axi_arcache; 
    input   [AXI_ID_WIDTH-1:0]  axi_arid;   
    input   [7   :0]  axi_arlen;  
    input   [0   :0]  axi_arlock; 
    input   [2   :0]  axi_arprot; 
    input   [3   :0]  axi_arqos;  
    input   [2   :0]  axi_arsize; 
    input             axi_arvalid; 
    input   [AXI_ADDR_WIDTH-1:0]  axi_awaddr; 
    input   [1   :0]  axi_awburst; 
    input   [3   :0]  axi_awcache; 
    input   [AXI_ID_WIDTH-1:0]  axi_awid;   
    input   [7   :0]  axi_awlen;  
    input   [0   :0]  axi_awlock; 
    input   [2   :0]  axi_awprot; 
    input   [3   :0]  axi_awqos;  
    input   [2   :0]  axi_awsize; 
    input             axi_awvalid; 
    input             axi_bready; 
    input             axi_rready; 
    input   [AXI_DATA_WIDTH-1:0]  axi_wdata;  
    input             axi_wlast;  
    input   [(AXI_DATA_WIDTH/8)-1:0]  axi_wstrb;  
    input             axi_wvalid; 
    output            axi_arready; 
    output            axi_awready; 
    output  [AXI_ID_WIDTH-1:0]  axi_bid;    
    output  [1   :0]  axi_bresp;  
    output            axi_bvalid; 
    output  [AXI_DATA_WIDTH-1:0]  axi_rdata;  
    output  [AXI_ID_WIDTH-1:0]  axi_rid;    
    output            axi_rlast;  
    output  [1   :0]  axi_rresp;  
    output            axi_rvalid; 
    output            axi_wready; 

    reg [31:0]        dummy_reg;
    reg   [31:0]      dispatcher_rst_addr_reg;
    reg   [31:0]      regular_0_rst_addr_reg;
    reg   [31:0]      regular_1_rst_addr_reg;

    /*
     * Read fsm.
     */
    localparam	R_IDLE = 2'b01,
		        R_RESP = 2'b10;

    reg  [1:0]		r_cur_state;
    reg  [1:0]		r_nxt_state;
    reg			ar_ready;
    reg  [2:0]		ar_addr;
    reg			r_valid;
    reg [AXI_ID_WIDTH-1:0] r_id;

    /*
     * Read channel fsm.
     */
    always @(posedge aclk or negedge arstn) begin
        if(!arstn) begin
            r_cur_state <= '0;
        end else begin
            r_cur_state <= r_nxt_state;
        end
    end

    //always @(posedge aclk or negedge arstn) begin
    always @(*) begin
	if (~arstn) begin
	    ar_ready <= 'b0;
	    ar_addr  <= 'b0;
	    r_valid  <= 'b0;
        r_id     <= 'b0;
	    r_nxt_state    <= R_IDLE;
	end else begin
	    case (r_cur_state)

	    R_IDLE: begin
		    r_valid  <= 0;
	    	if (axi_arvalid) begin
		        ar_addr  <= axi_araddr[3:2];
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
	        ar_addr  <= 'b0;
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
//    assign axi_rdata   = csr_reg[ar_addr];
    assign axi_rresp   = 0;
    
    reg [AXI_DATA_WIDTH-1:0] axi_rdata_reg;

    always @(*) begin
        if (~arstn) begin
            axi_rdata_reg = 'h0;
        end
        else if (r_cur_state == R_RESP) begin
            case (axi_araddr)
                `REG_DISPATCHER_RST_ADDR: axi_rdata_reg = dispatcher_rst_addr_reg;
                `REG_DISPATCHER_PC: axi_rdata_reg = dispatcher_pc;
                `REG_REGULAR_0_RST_ADDR: axi_rdata_reg = regular_0_rst_addr_reg;
                `REG_REGULAR_0_PC: axi_rdata_reg = regular_0_pc;
                `REG_REGULAR_1_RST_ADDR: axi_rdata_reg = regular_1_rst_addr_reg;
                `REG_REGULAR_1_PC: axi_rdata_reg = regular_1_pc;
                default: axi_rdata_reg = 32'hefefefef;
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

    reg  [2:0]		        w_nxt_state;
    reg  [2:0]		        w_cur_state;
    reg			            aw_ready;
    reg  [1:0]		        aw_addr;
    reg			            w_ready;
    reg			            b_valid;
    reg [AXI_ID_WIDTH-1:0]  b_id;

    always @(posedge aclk or negedge arstn) begin
        if(!arstn) begin
            w_cur_state <= '0;
        end else begin
            w_cur_state <= w_nxt_state;
        end
    end

//    always @(posedge aclk or negedge arstn) begin
    always @(*) begin
	    if (~arstn) begin
	        aw_ready <= 'b0;
	        aw_addr  <= 'b0;
	        w_ready  <= 'b0;
	        b_valid  <= 'b0;
            b_id     <= 'b0;
	        w_nxt_state    <= W_IDLE;
            dispatcher_rst_addr_reg <= 32'h2000000;
            regular_0_rst_addr_reg <= 32'h2100000;
            regular_1_rst_addr_reg <= 32'h2200000;
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
                        `REG_DISPATCHER_RST_ADDR: dispatcher_rst_addr_reg <= axi_wdata;
                        `REG_REGULAR_0_RST_ADDR: regular_0_rst_addr_reg <= axi_wdata;
                        `REG_REGULAR_1_RST_ADDR: regular_1_rst_addr_reg <= axi_wdata;
                        default:  dummy_reg <= axi_wdata;
                    endcase
	    	    end
	        end

	        W_RESP: begin
	    	if (axi_bready) begin
	    	    b_valid <= 0;
	    	    w_nxt_state   <= W_IDLE;
	    	end
	        end

            default: begin
                w_nxt_state <= W_IDLE;
	            aw_ready <= 'b0;
	            aw_addr  <= 'b0;
	            w_ready  <= 'b0;
	            b_valid  <= 'b0;
                b_id     <= 'b0;
                dispatcher_rst_addr_reg <= dispatcher_rst_addr_reg;
                regular_0_rst_addr_reg <= regular_0_rst_addr_reg;
                regular_1_rst_addr_reg <= regular_1_rst_addr_reg;
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

    assign dispatcher_rst_addr = dispatcher_rst_addr_reg;
    assign regular_0_rst_addr = regular_0_rst_addr_reg;
    assign regular_1_rst_addr = regular_1_rst_addr_reg;

endmodule
