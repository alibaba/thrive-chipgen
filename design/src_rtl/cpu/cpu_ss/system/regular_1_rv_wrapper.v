`include "cpu_cfig.h"
`include "sys_cfg.h"
`include "xocc_define.h"

module regular_1_rv_wrapper (
    //XOCC signals start
    xocc_0_cmd_buffer,
    xocc_0_rsp_buffer,
    xocc_0_cmd_empty,
    xocc_0_rsp_full,
    xocc_0_cmd_rd_en,
    xocc_0_rsp_wr_en,
    xocc_0_clk,
    xocc_0_rst,
    xocc_1_cmd_buffer,
    xocc_1_rsp_buffer,
    xocc_1_cmd_empty,
    xocc_1_rsp_full,
    xocc_1_cmd_rd_en,
    xocc_1_rsp_wr_en,
    xocc_1_clk,
    xocc_1_rst,
    //XOCC signals end

    //axi master port 
    m_axi_awid,
    m_axi_awlen,
    m_axi_awsize,
    m_axi_awburst,
    m_axi_awcache,
    m_axi_awaddr,
    m_axi_awprot,
    m_axi_awqos,
    m_axi_awvalid,
    m_axi_awready,
    m_axi_awlock,
    m_axi_wdata,
    m_axi_wstrb,
    m_axi_wlast,
    m_axi_wvalid,
    m_axi_wready,
    m_axi_bid,
    m_axi_bresp,
    m_axi_bvalid,
    m_axi_bready,
    m_axi_arid,
    m_axi_arlen,
    m_axi_arsize,
    m_axi_arburst,
    m_axi_arprot,
    m_axi_arqos,
    m_axi_arcache,
    m_axi_arvalid,
    m_axi_araddr,
    m_axi_arlock,
    m_axi_arready,
    m_axi_rid,
    m_axi_rdata,
    m_axi_rresp,
    m_axi_rvalid,
    m_axi_rlast,
    m_axi_rready,
    
    //csr
    biu_pad_retire_pc,
    pad_cpu_rst_addr,
    
    i_pad_clk, 
    i_pad_rst_b         
);

input          	i_pad_clk;             
input          	i_pad_rst_b;           

output 	 [3:0]	m_axi_awid;
output 	 [7:0]	m_axi_awlen;
output 	 [2:0]	m_axi_awsize;
output 	 [1:0]	m_axi_awburst;
output 	 [3:0]	m_axi_awcache;
output 	 [31:0] m_axi_awaddr;  
output 	 [2:0]  m_axi_awprot;
output 	 	m_axi_awvalid;
input  		m_axi_awready;
output 	 	m_axi_awlock;
output 	 [31:0]	m_axi_wdata;
output 	 [3:0]	m_axi_wstrb;
output 	 	m_axi_wlast;
output 	 	m_axi_wvalid;
input  		m_axi_wready;
input  	[3:0]	m_axi_bid;
input  	[1:0]	m_axi_bresp;
input  		m_axi_bvalid;
output 	 	m_axi_bready;
output 	 [3:0]	m_axi_arid;
output 	 [7:0]	m_axi_arlen;
output 	 [2:0]	m_axi_arsize;
output 	 [1:0]	m_axi_arburst;
output 	 [2:0]	m_axi_arprot;
output 	 [3:0]	m_axi_arcache;
output 	 	m_axi_arvalid;
output 	 [31:0]	m_axi_araddr;
output 	 	m_axi_arlock;
input  		m_axi_arready;
input  	[3:0]	m_axi_rid;
input  	[31:0]	m_axi_rdata;
input  	[1:0]	m_axi_rresp;
input  		m_axi_rvalid;
input  		m_axi_rlast;
output 	 	m_axi_rready;
output 	 [3:0]  m_axi_arqos;
output 	 [3:0]  m_axi_awqos;

wire          	i_pad_clk;             
wire          	i_pad_rst_b;           
wire 	 [3:0]	m_axi_awid;
wire 	 [7:0]	m_axi_awlen;
wire 	 [2:0]	m_axi_awsize;
wire 	 [1:0]	m_axi_awburst;
wire 	 [3:0]	m_axi_awcache;
wire 	 [31:0] m_axi_awaddr;  
wire 	 [2:0]  m_axi_awprot;
wire 	 	m_axi_awvalid;
wire 		m_axi_awready;
wire 	 	m_axi_awlock;
wire 	 [31:0]	m_axi_wdata;
wire 	 [3:0]	m_axi_wstrb;
wire 	 	m_axi_wlast;
wire 	 	m_axi_wvalid;
wire 		m_axi_wready;
wire 	[3:0]	m_axi_bid;
wire 	[1:0]	m_axi_bresp;
wire 		m_axi_bvalid;
wire 	 	m_axi_bready;
wire 	 [3:0]	m_axi_arid;
wire 	 [7:0]	m_axi_arlen;
wire 	 [2:0]	m_axi_arsize;
wire 	 [1:0]	m_axi_arburst;
wire 	 [2:0]	m_axi_arprot;
wire 	 [3:0]	m_axi_arcache;
wire 	 	m_axi_arvalid;
wire 	 [31:0]	m_axi_araddr;
wire 	 	m_axi_arlock;
wire 		m_axi_arready;
wire 	[3:0]	m_axi_rid;
wire 	[31:0]	m_axi_rdata;
wire 	[1:0]	m_axi_rresp;
wire 		m_axi_rvalid;
wire 		m_axi_rlast;
wire 	 	m_axi_rready;
wire 	 [3:0]  m_axi_arqos;
wire 	 [3:0]  m_axi_awqos;

//XOCC signals
output	[32-1:0]	xocc_0_cmd_buffer;
input	[32-1:0]	xocc_0_rsp_buffer;
output	xocc_0_cmd_empty;
output	xocc_0_rsp_full;
input	xocc_0_cmd_rd_en;
input	xocc_0_rsp_wr_en;
input	xocc_0_clk;
input	xocc_0_rst;
output	[32-1:0]	xocc_1_cmd_buffer;
input	[32-1:0]	xocc_1_rsp_buffer;
output	xocc_1_cmd_empty;
output	xocc_1_rsp_full;
input	xocc_1_cmd_rd_en;
input	xocc_1_rsp_wr_en;
input	xocc_1_clk;
input	xocc_1_rst;

wire	[32-1:0]	xocc_0_cmd_buffer;
wire	[32-1:0]	xocc_0_rsp_buffer;
wire	xocc_0_cmd_empty;
wire	xocc_0_rsp_full;
wire	xocc_0_cmd_rd_en;
wire	xocc_0_rsp_wr_en;
wire	xocc_0_clk;
wire	xocc_0_rst;
wire	[32-1:0]	xocc_1_cmd_buffer;
wire	[32-1:0]	xocc_1_rsp_buffer;
wire	xocc_1_cmd_empty;
wire	xocc_1_rsp_full;
wire	xocc_1_cmd_rd_en;
wire	xocc_1_rsp_wr_en;
wire	xocc_1_clk;
wire	xocc_1_rst;

//CSR register
output  wire  [31:0]  biu_pad_retire_pc;   
input wire [31:0] pad_cpu_rst_addr;

wire    [31:0]  biu_pad_haddr;         
wire    [2 :0]  biu_pad_hburst;        
wire    [3 :0]  biu_pad_hprot;         
wire    [2 :0]  biu_pad_hsize;         
wire    [1 :0]  biu_pad_htrans;        
wire    [31:0]  biu_pad_hwdata;        
wire            biu_pad_hwrite;        
wire    [1 :0]  biu_pad_lpmd_b;        
wire    [31:0]  pad_biu_hrdata;        
wire            pad_biu_hready;        
wire    [1 :0]  pad_biu_hresp;         
wire            cpu_clk;               
wire [15-2:0]     full_rsp;
wire [15-2:0]     empty_cmd;

assign m_axi_arqos = 4'b0;
assign m_axi_awqos = 4'b0;

//***********************Instance cpu_sub_system_ahb****************************
regular_1_cpu_sub_system_ahb  x_regular_1_cpu_sub_system_ahb (
  .dsa_clk               ({{(16-2){1'b0}},xocc_1_clk,xocc_0_clk}),
  .dsa_cmd_buffer_0      (xocc_0_cmd_buffer     ),
  .dsa_cmd_buffer_1      (xocc_1_cmd_buffer     ),
  .dsa_rsp_buffer_0      (xocc_0_rsp_buffer     ),
  .dsa_rsp_buffer_1      (xocc_1_rsp_buffer     ),
  .dsa_rst               ({{(16-2){1'b0}},~xocc_1_rst,~xocc_0_rst}),
  .empty_cmd             ({empty_cmd,xocc_1_cmd_empty,xocc_0_cmd_empty}),
  .full_rsp              ({full_rsp,xocc_1_rsp_full,xocc_0_rsp_full}),
  .rd_en_cmd             ({{(16-2){1'b0}},xocc_1_cmd_rd_en,xocc_0_cmd_rd_en}),
  .wr_en_rsp             ({{(16-2){1'b0}},xocc_1_rsp_wr_en,xocc_0_rsp_wr_en}),
  .biu_pad_haddr        (biu_pad_haddr       ),
  .biu_pad_hburst       (biu_pad_hburst      ),
  .biu_pad_hprot        (biu_pad_hprot       ),
  .biu_pad_hsize        (biu_pad_hsize       ),
  .biu_pad_htrans       (biu_pad_htrans      ),
  .biu_pad_hwdata       (biu_pad_hwdata      ),
  .biu_pad_hwrite       (biu_pad_hwrite      ),
  .pad_biu_hrdata       (pad_biu_hrdata      ),
  .pad_biu_hready       (pad_biu_hready      ),
  .pad_biu_hresp        (pad_biu_hresp       ),
  .biu_pad_lpmd_b       (biu_pad_lpmd_b      ),
  .pad_biu_bigend_b     (1'b1                ),
  .pad_vic_int_vld      (32'b0     ),
  .pad_cpu_rst_addr     (pad_cpu_rst_addr    ),
  .biu_pad_retire_pc    (biu_pad_retire_pc   ),
  .pad_yy_dft_clk_rst_b	(1'b0),            
  .pad_yy_icg_scan_en	(1'b0),              
  .pad_yy_scan_enable	(1'b0),              
  .pad_yy_scan_mode		(1'b0),                
  .pad_yy_scan_rst_b	(1'b0),               
  .cpu_clk              (i_pad_clk           ),
  .pad_cpu_rst_b        (i_pad_rst_b         )
);

`ifdef XILINX_FPGA
cpu_sub_system_ahblite_axi_bridge  x_cpu_ahb2axi4(
  // AHB signals
  .s_ahb_hclk(i_pad_clk),              // input wire s_ahb_hclk
  .s_ahb_hresetn(pad_cpu_rst_b),        // input wire s_ahb_hresetn
  .s_ahb_hsel(1'b1),              // input wire s_ahb_hsel
  .s_ahb_haddr(biu_pad_haddr),            // input wire [31 : 0] s_ahb_haddr
  .s_ahb_hprot(biu_pad_hprot),            // input wire [3 : 0] s_ahb_hprot
  .s_ahb_htrans(biu_pad_htrans),          // input wire [1 : 0] s_ahb_htrans
  .s_ahb_hsize(biu_pad_hsize),            // input wire [2 : 0] s_ahb_hsize
  .s_ahb_hwrite(biu_pad_hwrite),          // input wire s_ahb_hwrite
  .s_ahb_hburst(biu_pad_hburst),          // input wire [2 : 0] s_ahb_hburst
  .s_ahb_hwdata(biu_pad_hwdata),          // input wire [31 : 0] s_ahb_hwdata
  .s_ahb_hready_out(pad_biu_hready),  // output wire s_ahb_hready_out
  .s_ahb_hready_in(pad_biu_hready),    // input wire s_ahb_hready_in 
  					 //In the case of single slave system where AHB multiplexer is
					 //not used, HREADY_OUT has to be looped back and connected to 
					 //the HREADY_IN port for correct system operation.
  .s_ahb_hrdata(pad_biu_hrdata),          // output wire [31 : 0] s_ahb_hrdata
  .s_ahb_hresp(pad_biu_hresp[0]),            // output wire s_ahb_hresp
  // axi master port 
  .m_axi_awid(m_axi_awid),              // output wire [3 : 0] m_axi_awid
  .m_axi_awlen(m_axi_awlen),            // output wire [7 : 0] m_axi_awlen
  .m_axi_awsize(m_axi_awsize),          // output wire [2 : 0] m_axi_awsize
  .m_axi_awburst(m_axi_awburst),        // output wire [1 : 0] m_axi_awburst
  .m_axi_awcache(m_axi_awcache),        // output wire [3 : 0] m_axi_awcache
  .m_axi_awaddr(m_axi_awaddr[31:0]),          // output wire [31 : 0] m_axi_awaddr
  .m_axi_awprot(m_axi_awprot),          // output wire [2 : 0] m_axi_awprot
  .m_axi_awvalid(m_axi_awvalid),        // output wire m_axi_awvalid
  .m_axi_awready(m_axi_awready),        // input wire m_axi_awready
  .m_axi_awlock(m_axi_awlock),          // output wire m_axi_awlock
  .m_axi_wdata(m_axi_wdata),            // output wire [31 : 0] m_axi_wdata
  .m_axi_wstrb(m_axi_wstrb),            // output wire [3 : 0] m_axi_wstrb
  .m_axi_wlast(m_axi_wlast),            // output wire m_axi_wlast
  .m_axi_wvalid(m_axi_wvalid),          // output wire m_axi_wvalid
  .m_axi_wready(m_axi_wready),          // input wire m_axi_wready
  .m_axi_bid(m_axi_bid),                // input wire [3 : 0] m_axi_bid
  .m_axi_bresp(m_axi_bresp),            // input wire [1 : 0] m_axi_bresp
  .m_axi_bvalid(m_axi_bvalid),          // input wire m_axi_bvalid
  .m_axi_bready(m_axi_bready),          // output wire m_axi_bready
  .m_axi_arid(m_axi_arid),              // output wire [3 : 0] m_axi_arid
  .m_axi_arlen(m_axi_arlen),            // output wire [7 : 0] m_axi_arlen
  .m_axi_arsize(m_axi_arsize),          // output wire [2 : 0] m_axi_arsize
  .m_axi_arburst(m_axi_arburst),        // output wire [1 : 0] m_axi_arburst
  .m_axi_arprot(m_axi_arprot),          // output wire [2 : 0] m_axi_arprot
  .m_axi_arcache(m_axi_arcache),        // output wire [3 : 0] m_axi_arcache
  .m_axi_arvalid(m_axi_arvalid),        // output wire m_axi_arvalid
  .m_axi_araddr(m_axi_araddr),          // output wire [31 : 0] m_axi_araddr
  .m_axi_arlock(m_axi_arlock),          // output wire m_axi_arlock
  .m_axi_arready(m_axi_arready),        // input wire m_axi_arready
  .m_axi_rid(m_axi_rid),                // input wire [3 : 0] m_axi_rid
  .m_axi_rdata(m_axi_rdata),            // input wire [31 : 0] m_axi_rdata
  .m_axi_rresp(m_axi_rresp),            // input wire [1 : 0] m_axi_rresp
  .m_axi_rvalid(m_axi_rvalid),          // input wire m_axi_rvalid
  .m_axi_rlast(m_axi_rlast),            // input wire m_axi_rlast
  .m_axi_rready(m_axi_rready)          // output wire m_axi_rready
);
`else
ahbl2axi_bridge #(
  .ID_WIDTH(`AXI_MASTER_ID_WIDTH),
  .ADDR_WIDTH(32),
  .DATA_WIDTH(32)
) x_cpu_ahb2axi4 (
   .clk(i_pad_clk),
   .rst_l(i_pad_rst_b),
   .bus_clk_en(1'b1),
   .scan_mode(1'b0),

   // AXI Write Channels
   .axi_awvalid(m_axi_awvalid),
   .axi_awready(m_axi_awready),
   .axi_awid(m_axi_awid),
   .axi_awaddr(m_axi_awaddr),
   .axi_awsize(m_axi_awsize),
   .axi_awprot(m_axi_awprot),
   .axi_awlen(m_axi_awlen),
   .axi_awburst(m_axi_awburst),

   .axi_wvalid(m_axi_wvalid),
   .axi_wready(m_axi_wready),
   .axi_wdata(m_axi_wdata),
   .axi_wstrb(m_axi_wstrb),
   .axi_wlast(m_axi_wlast),

   .axi_bvalid(m_axi_bvalid),
   .axi_bready(m_axi_bready),
   .axi_bresp(m_axi_bresp),
   .axi_bid(m_axi_bid),

   // AXI Read Channels
   .axi_arvalid(m_axi_arvalid),
   .axi_arready(m_axi_arready),
   .axi_arid(m_axi_arid),
   .axi_araddr(m_axi_araddr),
   .axi_arsize(m_axi_arsize),
   .axi_arprot(m_axi_arprot),
   .axi_arlen(m_axi_arlen),
   .axi_arburst(m_axi_arburst),

   .axi_rvalid(m_axi_rvalid),
   .axi_rready(m_axi_rready),
   .axi_rid(m_axi_rid),
   .axi_rdata(m_axi_rdata),
   .axi_rresp(m_axi_rresp),

    // AHB signals
   .ahb_haddr(biu_pad_haddr),
   .ahb_hburst(biu_pad_hburst),
   .ahb_hprot(biu_pad_hprot),
   .ahb_hsize(biu_pad_hsize),
   .ahb_htrans(biu_pad_htrans),
   .ahb_hwrite(biu_pad_hwrite),
   .ahb_hwdata(biu_pad_hwdata),

   .ahb_hrdata(pad_biu_hrdata),
   .ahb_hreadyout(pad_biu_hready),
   .ahb_hresp(pad_biu_hresp[0]),
   .ahb_hreadyin(pad_biu_hready),
   .ahb_hsel(1'b1)
);
`endif

assign pad_biu_hresp[1] = 1'b0;

endmodule


