`include "sys_cfg.h"

`define REG_PE_0_0_DISPATCHER_SOFT_RST 32'h0
`define REG_PE_0_0_REGULAR_0_SOFT_RST 32'h4
`define REG_PE_0_0_REGULAR_1_SOFT_RST 32'h8
`define REG_PE_0_0_DSA_0_SOFT_RST 32'hc
`define REG_PE_0_0_DSA_1_SOFT_RST 32'h10
`define REG_PE_0_0_DSA_2_SOFT_RST 32'h14
`define REG_PE_0_0_NOU_SOFT_RST 32'h18
`define REG_PE_0_0_MEM_SOFT_RST 32'h1c
`define REG_PE_1_0_DISPATCHER_SOFT_RST 32'h40
`define REG_PE_1_0_REGULAR_0_SOFT_RST 32'h44
`define REG_PE_1_0_REGULAR_1_SOFT_RST 32'h48
`define REG_PE_1_0_DSA_0_SOFT_RST 32'h4c
`define REG_PE_1_0_DSA_1_SOFT_RST 32'h50
`define REG_PE_1_0_DSA_2_SOFT_RST 32'h54
`define REG_PE_1_0_NOU_SOFT_RST 32'h58
`define REG_PE_1_0_MEM_SOFT_RST 32'h5c
`define REG_PE_0_1_DISPATCHER_SOFT_RST 32'h80
`define REG_PE_0_1_REGULAR_0_SOFT_RST 32'h84
`define REG_PE_0_1_REGULAR_1_SOFT_RST 32'h88
`define REG_PE_0_1_DSA_0_SOFT_RST 32'h8c
`define REG_PE_0_1_DSA_1_SOFT_RST 32'h90
`define REG_PE_0_1_DSA_2_SOFT_RST 32'h94
`define REG_PE_0_1_NOU_SOFT_RST 32'h98
`define REG_PE_0_1_MEM_SOFT_RST 32'h9c
`define REG_PE_1_1_DISPATCHER_SOFT_RST 32'hc0
`define REG_PE_1_1_REGULAR_0_SOFT_RST 32'hc4
`define REG_PE_1_1_REGULAR_1_SOFT_RST 32'hc8
`define REG_PE_1_1_DSA_0_SOFT_RST 32'hcc
`define REG_PE_1_1_DSA_1_SOFT_RST 32'hd0
`define REG_PE_1_1_DSA_2_SOFT_RST 32'hd4
`define REG_PE_1_1_NOU_SOFT_RST 32'hd8
`define REG_PE_1_1_MEM_SOFT_RST 32'hdc

module sys_reg #(
	parameter	AXI_ID_WIDTH = 4,
	parameter	AXI_ADDR_WIDTH = 32,
	parameter	AXI_DATA_WIDTH = 32
) (
    sys_clk,
    sys_rstn,
    pe_0_0_dispatcher_soft_rstn,
    pe_0_0_regular_0_soft_rstn,
    pe_0_0_regular_1_soft_rstn,
    pe_0_0_dsa_0_soft_rstn,
    pe_0_0_dsa_1_soft_rstn,
    pe_0_0_dsa_2_soft_rstn,
    pe_0_0_nou_soft_rstn,
    pe_0_0_sram_soft_rstn,
    pe_1_0_dispatcher_soft_rstn,
    pe_1_0_regular_0_soft_rstn,
    pe_1_0_regular_1_soft_rstn,
    pe_1_0_dsa_0_soft_rstn,
    pe_1_0_dsa_1_soft_rstn,
    pe_1_0_dsa_2_soft_rstn,
    pe_1_0_nou_soft_rstn,
    pe_1_0_sram_soft_rstn,
    pe_0_1_dispatcher_soft_rstn,
    pe_0_1_regular_0_soft_rstn,
    pe_0_1_regular_1_soft_rstn,
    pe_0_1_dsa_0_soft_rstn,
    pe_0_1_dsa_1_soft_rstn,
    pe_0_1_dsa_2_soft_rstn,
    pe_0_1_nou_soft_rstn,
    pe_0_1_sram_soft_rstn,
    pe_1_1_dispatcher_soft_rstn,
    pe_1_1_regular_0_soft_rstn,
    pe_1_1_regular_1_soft_rstn,
    pe_1_1_dsa_0_soft_rstn,
    pe_1_1_dsa_1_soft_rstn,
    pe_1_1_dsa_2_soft_rstn,
    pe_1_1_nou_soft_rstn,
    pe_1_1_sram_soft_rstn,
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
    output pe_0_0_dispatcher_soft_rstn;
    output pe_0_0_regular_0_soft_rstn;
    output pe_0_0_regular_1_soft_rstn;
    output pe_0_0_dsa_0_soft_rstn;
    output pe_0_0_dsa_1_soft_rstn;
    output pe_0_0_dsa_2_soft_rstn;
    output pe_0_0_nou_soft_rstn;
    output pe_0_0_sram_soft_rstn;
    output pe_1_0_dispatcher_soft_rstn;
    output pe_1_0_regular_0_soft_rstn;
    output pe_1_0_regular_1_soft_rstn;
    output pe_1_0_dsa_0_soft_rstn;
    output pe_1_0_dsa_1_soft_rstn;
    output pe_1_0_dsa_2_soft_rstn;
    output pe_1_0_nou_soft_rstn;
    output pe_1_0_sram_soft_rstn;
    output pe_0_1_dispatcher_soft_rstn;
    output pe_0_1_regular_0_soft_rstn;
    output pe_0_1_regular_1_soft_rstn;
    output pe_0_1_dsa_0_soft_rstn;
    output pe_0_1_dsa_1_soft_rstn;
    output pe_0_1_dsa_2_soft_rstn;
    output pe_0_1_nou_soft_rstn;
    output pe_0_1_sram_soft_rstn;
    output pe_1_1_dispatcher_soft_rstn;
    output pe_1_1_regular_0_soft_rstn;
    output pe_1_1_regular_1_soft_rstn;
    output pe_1_1_dsa_0_soft_rstn;
    output pe_1_1_dsa_1_soft_rstn;
    output pe_1_1_dsa_2_soft_rstn;
    output pe_1_1_nou_soft_rstn;
    output pe_1_1_sram_soft_rstn;
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
    reg  pe_0_0_dispatcher_soft_rstn_reg;
    reg  pe_0_0_regular_0_soft_rstn_reg;
    reg  pe_0_0_regular_1_soft_rstn_reg;
    reg  pe_0_0_dsa_0_soft_rstn_reg;
    reg  pe_0_0_dsa_1_soft_rstn_reg;
    reg  pe_0_0_dsa_2_soft_rstn_reg;
    reg  pe_0_0_nou_soft_rstn_reg;
    reg  pe_0_0_sram_soft_rstn_reg;
    reg  pe_1_0_dispatcher_soft_rstn_reg;
    reg  pe_1_0_regular_0_soft_rstn_reg;
    reg  pe_1_0_regular_1_soft_rstn_reg;
    reg  pe_1_0_dsa_0_soft_rstn_reg;
    reg  pe_1_0_dsa_1_soft_rstn_reg;
    reg  pe_1_0_dsa_2_soft_rstn_reg;
    reg  pe_1_0_nou_soft_rstn_reg;
    reg  pe_1_0_sram_soft_rstn_reg;
    reg  pe_0_1_dispatcher_soft_rstn_reg;
    reg  pe_0_1_regular_0_soft_rstn_reg;
    reg  pe_0_1_regular_1_soft_rstn_reg;
    reg  pe_0_1_dsa_0_soft_rstn_reg;
    reg  pe_0_1_dsa_1_soft_rstn_reg;
    reg  pe_0_1_dsa_2_soft_rstn_reg;
    reg  pe_0_1_nou_soft_rstn_reg;
    reg  pe_0_1_sram_soft_rstn_reg;
    reg  pe_1_1_dispatcher_soft_rstn_reg;
    reg  pe_1_1_regular_0_soft_rstn_reg;
    reg  pe_1_1_regular_1_soft_rstn_reg;
    reg  pe_1_1_dsa_0_soft_rstn_reg;
    reg  pe_1_1_dsa_1_soft_rstn_reg;
    reg  pe_1_1_dsa_2_soft_rstn_reg;
    reg  pe_1_1_nou_soft_rstn_reg;
    reg  pe_1_1_sram_soft_rstn_reg;

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
                `REG_PE_0_0_DISPATCHER_SOFT_RST : axi_rdata_reg <= pe_0_0_dispatcher_soft_rstn_reg;
                `REG_PE_0_0_REGULAR_0_SOFT_RST : axi_rdata_reg <= pe_0_0_regular_0_soft_rstn_reg;
                `REG_PE_0_0_REGULAR_1_SOFT_RST : axi_rdata_reg <= pe_0_0_regular_1_soft_rstn_reg;
                `REG_PE_0_0_DSA_0_SOFT_RST : axi_rdata_reg <= pe_0_0_dsa_0_soft_rstn_reg;
                `REG_PE_0_0_DSA_1_SOFT_RST : axi_rdata_reg <= pe_0_0_dsa_1_soft_rstn_reg;
                `REG_PE_0_0_DSA_2_SOFT_RST : axi_rdata_reg <= pe_0_0_dsa_2_soft_rstn_reg;
                `REG_PE_0_0_NOU_SOFT_RST : axi_rdata_reg <= pe_0_0_nou_soft_rstn_reg;
                `REG_PE_0_0_MEM_SOFT_RST        : axi_rdata_reg <= pe_0_0_sram_soft_rstn_reg;
                `REG_PE_1_0_DISPATCHER_SOFT_RST : axi_rdata_reg <= pe_1_0_dispatcher_soft_rstn_reg;
                `REG_PE_1_0_REGULAR_0_SOFT_RST : axi_rdata_reg <= pe_1_0_regular_0_soft_rstn_reg;
                `REG_PE_1_0_REGULAR_1_SOFT_RST : axi_rdata_reg <= pe_1_0_regular_1_soft_rstn_reg;
                `REG_PE_1_0_DSA_0_SOFT_RST : axi_rdata_reg <= pe_1_0_dsa_0_soft_rstn_reg;
                `REG_PE_1_0_DSA_1_SOFT_RST : axi_rdata_reg <= pe_1_0_dsa_1_soft_rstn_reg;
                `REG_PE_1_0_DSA_2_SOFT_RST : axi_rdata_reg <= pe_1_0_dsa_2_soft_rstn_reg;
                `REG_PE_1_0_NOU_SOFT_RST : axi_rdata_reg <= pe_1_0_nou_soft_rstn_reg;
                `REG_PE_1_0_MEM_SOFT_RST        : axi_rdata_reg <= pe_1_0_sram_soft_rstn_reg;
                `REG_PE_0_1_DISPATCHER_SOFT_RST : axi_rdata_reg <= pe_0_1_dispatcher_soft_rstn_reg;
                `REG_PE_0_1_REGULAR_0_SOFT_RST : axi_rdata_reg <= pe_0_1_regular_0_soft_rstn_reg;
                `REG_PE_0_1_REGULAR_1_SOFT_RST : axi_rdata_reg <= pe_0_1_regular_1_soft_rstn_reg;
                `REG_PE_0_1_DSA_0_SOFT_RST : axi_rdata_reg <= pe_0_1_dsa_0_soft_rstn_reg;
                `REG_PE_0_1_DSA_1_SOFT_RST : axi_rdata_reg <= pe_0_1_dsa_1_soft_rstn_reg;
                `REG_PE_0_1_DSA_2_SOFT_RST : axi_rdata_reg <= pe_0_1_dsa_2_soft_rstn_reg;
                `REG_PE_0_1_NOU_SOFT_RST : axi_rdata_reg <= pe_0_1_nou_soft_rstn_reg;
                `REG_PE_0_1_MEM_SOFT_RST        : axi_rdata_reg <= pe_0_1_sram_soft_rstn_reg;
                `REG_PE_1_1_DISPATCHER_SOFT_RST : axi_rdata_reg <= pe_1_1_dispatcher_soft_rstn_reg;
                `REG_PE_1_1_REGULAR_0_SOFT_RST : axi_rdata_reg <= pe_1_1_regular_0_soft_rstn_reg;
                `REG_PE_1_1_REGULAR_1_SOFT_RST : axi_rdata_reg <= pe_1_1_regular_1_soft_rstn_reg;
                `REG_PE_1_1_DSA_0_SOFT_RST : axi_rdata_reg <= pe_1_1_dsa_0_soft_rstn_reg;
                `REG_PE_1_1_DSA_1_SOFT_RST : axi_rdata_reg <= pe_1_1_dsa_1_soft_rstn_reg;
                `REG_PE_1_1_DSA_2_SOFT_RST : axi_rdata_reg <= pe_1_1_dsa_2_soft_rstn_reg;
                `REG_PE_1_1_NOU_SOFT_RST : axi_rdata_reg <= pe_1_1_nou_soft_rstn_reg;
                `REG_PE_1_1_MEM_SOFT_RST        : axi_rdata_reg <= pe_1_1_sram_soft_rstn_reg;
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
            pe_0_0_dispatcher_soft_rstn_reg <= 1'b0;
            pe_0_0_regular_0_soft_rstn_reg <= 1'b0;
            pe_0_0_regular_1_soft_rstn_reg <= 1'b0;
            pe_0_0_dsa_0_soft_rstn_reg <= 1'b0;
            pe_0_0_dsa_1_soft_rstn_reg <= 1'b0;
            pe_0_0_dsa_2_soft_rstn_reg <= 1'b0;
            pe_0_0_nou_soft_rstn_reg <= 1'b0;
            pe_0_0_sram_soft_rstn_reg <= 1'b0;
            pe_1_0_dispatcher_soft_rstn_reg <= 1'b0;
            pe_1_0_regular_0_soft_rstn_reg <= 1'b0;
            pe_1_0_regular_1_soft_rstn_reg <= 1'b0;
            pe_1_0_dsa_0_soft_rstn_reg <= 1'b0;
            pe_1_0_dsa_1_soft_rstn_reg <= 1'b0;
            pe_1_0_dsa_2_soft_rstn_reg <= 1'b0;
            pe_1_0_nou_soft_rstn_reg <= 1'b0;
            pe_1_0_sram_soft_rstn_reg <= 1'b0;
            pe_0_1_dispatcher_soft_rstn_reg <= 1'b0;
            pe_0_1_regular_0_soft_rstn_reg <= 1'b0;
            pe_0_1_regular_1_soft_rstn_reg <= 1'b0;
            pe_0_1_dsa_0_soft_rstn_reg <= 1'b0;
            pe_0_1_dsa_1_soft_rstn_reg <= 1'b0;
            pe_0_1_dsa_2_soft_rstn_reg <= 1'b0;
            pe_0_1_nou_soft_rstn_reg <= 1'b0;
            pe_0_1_sram_soft_rstn_reg <= 1'b0;
            pe_1_1_dispatcher_soft_rstn_reg <= 1'b0;
            pe_1_1_regular_0_soft_rstn_reg <= 1'b0;
            pe_1_1_regular_1_soft_rstn_reg <= 1'b0;
            pe_1_1_dsa_0_soft_rstn_reg <= 1'b0;
            pe_1_1_dsa_1_soft_rstn_reg <= 1'b0;
            pe_1_1_dsa_2_soft_rstn_reg <= 1'b0;
            pe_1_1_nou_soft_rstn_reg <= 1'b0;
            pe_1_1_sram_soft_rstn_reg <= 1'b0;
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
                        `REG_PE_0_0_DISPATCHER_SOFT_RST : pe_0_0_dispatcher_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_0_0_REGULAR_0_SOFT_RST : pe_0_0_regular_0_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_0_0_REGULAR_1_SOFT_RST : pe_0_0_regular_1_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_0_0_DSA_0_SOFT_RST : pe_0_0_dsa_0_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_0_0_DSA_1_SOFT_RST : pe_0_0_dsa_1_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_0_0_DSA_2_SOFT_RST : pe_0_0_dsa_2_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_0_0_NOU_SOFT_RST : pe_0_0_nou_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_0_0_MEM_SOFT_RST        : pe_0_0_sram_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_1_0_DISPATCHER_SOFT_RST : pe_1_0_dispatcher_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_1_0_REGULAR_0_SOFT_RST : pe_1_0_regular_0_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_1_0_REGULAR_1_SOFT_RST : pe_1_0_regular_1_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_1_0_DSA_0_SOFT_RST : pe_1_0_dsa_0_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_1_0_DSA_1_SOFT_RST : pe_1_0_dsa_1_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_1_0_DSA_2_SOFT_RST : pe_1_0_dsa_2_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_1_0_NOU_SOFT_RST : pe_1_0_nou_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_1_0_MEM_SOFT_RST        : pe_1_0_sram_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_0_1_DISPATCHER_SOFT_RST : pe_0_1_dispatcher_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_0_1_REGULAR_0_SOFT_RST : pe_0_1_regular_0_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_0_1_REGULAR_1_SOFT_RST : pe_0_1_regular_1_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_0_1_DSA_0_SOFT_RST : pe_0_1_dsa_0_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_0_1_DSA_1_SOFT_RST : pe_0_1_dsa_1_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_0_1_DSA_2_SOFT_RST : pe_0_1_dsa_2_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_0_1_NOU_SOFT_RST : pe_0_1_nou_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_0_1_MEM_SOFT_RST        : pe_0_1_sram_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_1_1_DISPATCHER_SOFT_RST : pe_1_1_dispatcher_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_1_1_REGULAR_0_SOFT_RST : pe_1_1_regular_0_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_1_1_REGULAR_1_SOFT_RST : pe_1_1_regular_1_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_1_1_DSA_0_SOFT_RST : pe_1_1_dsa_0_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_1_1_DSA_1_SOFT_RST : pe_1_1_dsa_1_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_1_1_DSA_2_SOFT_RST : pe_1_1_dsa_2_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_1_1_NOU_SOFT_RST : pe_1_1_nou_soft_rstn_reg <= axi_wdata[0];
                        `REG_PE_1_1_MEM_SOFT_RST        : pe_1_1_sram_soft_rstn_reg <= axi_wdata[0];
                        default:  dummy_reg <= axi_wdata;
                    endcase
	    	    end
	        end

	        W_RESP: begin
	    	    if (axi_bready) begin
	    	        b_valid <= 0;
	    	        w_nxt_state   <= W_IDLE;
	    	    end
                pe_0_0_dispatcher_soft_rstn_reg <= 1'b0;
                pe_0_0_regular_0_soft_rstn_reg <= 1'b0;
                pe_0_0_regular_1_soft_rstn_reg <= 1'b0;
                pe_0_0_dsa_0_soft_rstn_reg <= 1'b0;
                pe_0_0_dsa_1_soft_rstn_reg <= 1'b0;
                pe_0_0_dsa_2_soft_rstn_reg <= 1'b0;
                pe_0_0_nou_soft_rstn_reg <= 1'b0;
                pe_0_0_sram_soft_rstn_reg <= 1'b0;
                pe_1_0_dispatcher_soft_rstn_reg <= 1'b0;
                pe_1_0_regular_0_soft_rstn_reg <= 1'b0;
                pe_1_0_regular_1_soft_rstn_reg <= 1'b0;
                pe_1_0_dsa_0_soft_rstn_reg <= 1'b0;
                pe_1_0_dsa_1_soft_rstn_reg <= 1'b0;
                pe_1_0_dsa_2_soft_rstn_reg <= 1'b0;
                pe_1_0_nou_soft_rstn_reg <= 1'b0;
                pe_1_0_sram_soft_rstn_reg <= 1'b0;
                pe_0_1_dispatcher_soft_rstn_reg <= 1'b0;
                pe_0_1_regular_0_soft_rstn_reg <= 1'b0;
                pe_0_1_regular_1_soft_rstn_reg <= 1'b0;
                pe_0_1_dsa_0_soft_rstn_reg <= 1'b0;
                pe_0_1_dsa_1_soft_rstn_reg <= 1'b0;
                pe_0_1_dsa_2_soft_rstn_reg <= 1'b0;
                pe_0_1_nou_soft_rstn_reg <= 1'b0;
                pe_0_1_sram_soft_rstn_reg <= 1'b0;
                pe_1_1_dispatcher_soft_rstn_reg <= 1'b0;
                pe_1_1_regular_0_soft_rstn_reg <= 1'b0;
                pe_1_1_regular_1_soft_rstn_reg <= 1'b0;
                pe_1_1_dsa_0_soft_rstn_reg <= 1'b0;
                pe_1_1_dsa_1_soft_rstn_reg <= 1'b0;
                pe_1_1_dsa_2_soft_rstn_reg <= 1'b0;
                pe_1_1_nou_soft_rstn_reg <= 1'b0;
                pe_1_1_sram_soft_rstn_reg <= 1'b0;
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

    assign pe_0_0_dispatcher_soft_rstn = ~pe_0_0_dispatcher_soft_rstn_reg;
    assign pe_0_0_regular_0_soft_rstn = ~pe_0_0_regular_0_soft_rstn_reg;
    assign pe_0_0_regular_1_soft_rstn = ~pe_0_0_regular_1_soft_rstn_reg;
    assign pe_0_0_dsa_0_soft_rstn = ~pe_0_0_dsa_0_soft_rstn_reg;
    assign pe_0_0_dsa_1_soft_rstn = ~pe_0_0_dsa_1_soft_rstn_reg;
    assign pe_0_0_dsa_2_soft_rstn = ~pe_0_0_dsa_2_soft_rstn_reg;
    assign pe_0_0_nou_soft_rstn = ~pe_0_0_nou_soft_rstn_reg;
    assign pe_0_0_sram_soft_rstn = ~pe_0_0_sram_soft_rstn_reg;
    assign pe_1_0_dispatcher_soft_rstn = ~pe_1_0_dispatcher_soft_rstn_reg;
    assign pe_1_0_regular_0_soft_rstn = ~pe_1_0_regular_0_soft_rstn_reg;
    assign pe_1_0_regular_1_soft_rstn = ~pe_1_0_regular_1_soft_rstn_reg;
    assign pe_1_0_dsa_0_soft_rstn = ~pe_1_0_dsa_0_soft_rstn_reg;
    assign pe_1_0_dsa_1_soft_rstn = ~pe_1_0_dsa_1_soft_rstn_reg;
    assign pe_1_0_dsa_2_soft_rstn = ~pe_1_0_dsa_2_soft_rstn_reg;
    assign pe_1_0_nou_soft_rstn = ~pe_1_0_nou_soft_rstn_reg;
    assign pe_1_0_sram_soft_rstn = ~pe_1_0_sram_soft_rstn_reg;
    assign pe_0_1_dispatcher_soft_rstn = ~pe_0_1_dispatcher_soft_rstn_reg;
    assign pe_0_1_regular_0_soft_rstn = ~pe_0_1_regular_0_soft_rstn_reg;
    assign pe_0_1_regular_1_soft_rstn = ~pe_0_1_regular_1_soft_rstn_reg;
    assign pe_0_1_dsa_0_soft_rstn = ~pe_0_1_dsa_0_soft_rstn_reg;
    assign pe_0_1_dsa_1_soft_rstn = ~pe_0_1_dsa_1_soft_rstn_reg;
    assign pe_0_1_dsa_2_soft_rstn = ~pe_0_1_dsa_2_soft_rstn_reg;
    assign pe_0_1_nou_soft_rstn = ~pe_0_1_nou_soft_rstn_reg;
    assign pe_0_1_sram_soft_rstn = ~pe_0_1_sram_soft_rstn_reg;
    assign pe_1_1_dispatcher_soft_rstn = ~pe_1_1_dispatcher_soft_rstn_reg;
    assign pe_1_1_regular_0_soft_rstn = ~pe_1_1_regular_0_soft_rstn_reg;
    assign pe_1_1_regular_1_soft_rstn = ~pe_1_1_regular_1_soft_rstn_reg;
    assign pe_1_1_dsa_0_soft_rstn = ~pe_1_1_dsa_0_soft_rstn_reg;
    assign pe_1_1_dsa_1_soft_rstn = ~pe_1_1_dsa_1_soft_rstn_reg;
    assign pe_1_1_dsa_2_soft_rstn = ~pe_1_1_dsa_2_soft_rstn_reg;
    assign pe_1_1_nou_soft_rstn = ~pe_1_1_nou_soft_rstn_reg;
    assign pe_1_1_sram_soft_rstn = ~pe_1_1_sram_soft_rstn_reg;

endmodule
