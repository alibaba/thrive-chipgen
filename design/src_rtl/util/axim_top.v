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

module axim_top #
	(
		parameter integer BURST_LENGTH_WIDTH  = 5,
		parameter integer BURST_SIZE_WIDTH  = 3,
		parameter integer AXI_ID_WIDTH	= 1,
		parameter integer AXI_ADDR_WIDTH	= 32,
		parameter integer AXI_DATA_WIDTH	= 1024
	)
	(
		input  wire [BURST_LENGTH_WIDTH-1:0] write_burst_length,
		input  wire [BURST_LENGTH_WIDTH-1:0] read_burst_length,
		input  wire [BURST_SIZE_WIDTH-1:0]   write_burst_size,
		input  wire [BURST_SIZE_WIDTH-1:0]   read_burst_size,
		input  wire read_enable,
		input  wire write_enable,
		//initiate write transfer
		input  wire init_write,
		//initiate read transfer
		input  wire init_read,
		input  wire [AXI_ADDR_WIDTH-1:0] write_start_address,
		input  wire [AXI_ADDR_WIDTH-1:0] read_start_address,
		input [AXI_DATA_WIDTH-1:0] write_data,
		output wire  tx_done,
		output wire  rx_done,
		output wire  error,
		input wire  aclk,
		input wire  aresetn,
		output wire [AXI_ID_WIDTH-1 : 0] awid,
		output wire [AXI_ADDR_WIDTH-1 : 0] awaddr,
		output wire [7 : 0] awlen,
		output wire [2 : 0] awsize,
		output wire [1 : 0] awburst,
		output wire  awlock,
		output wire [3 : 0] awcache,
		output wire [2 : 0] awprot,
		output wire [3 : 0] awqos,
		output wire  awvalid,
		input wire  awready,
		output wire [AXI_DATA_WIDTH-1 : 0] wdata,
		output wire [AXI_DATA_WIDTH/8-1 : 0] wstrb,
		output wire  wlast,
		output wire  wvalid,
		input wire  wready,
		input wire [AXI_ID_WIDTH-1 : 0] bid,
		input wire [1 : 0] bresp,
		input wire  bvalid,
		output wire  bready,
		output wire [AXI_ID_WIDTH-1 : 0] arid,
		output wire [AXI_ADDR_WIDTH-1 : 0] araddr,
		output wire [7 : 0] arlen,
		output wire [2 : 0] arsize,
		output wire [1 : 0] arburst,
		output wire  arlock,
		output wire [3 : 0] arcache,
		output wire [2 : 0] arprot,
		output wire [3 : 0] arqos,
		output wire  arvalid,
		input wire  arready,
		input wire [AXI_ID_WIDTH-1 : 0] rid,
		input wire [AXI_DATA_WIDTH-1 : 0] rdata,
		input wire [1 : 0] rresp,
		input wire  rlast,
		input wire  rvalid,
		output wire  rready
	);

    localparam integer TRANSACTIONS_NUM = BURST_LENGTH_WIDTH;
    localparam integer MASTER_LENGTH	= 12;
    localparam integer NO_BURSTS_REQ = 0;
    localparam integer DATA_BYTE_WIDTH = TRANSACTIONS_NUM+$clog2(AXI_DATA_WIDTH/8);
	localparam [1:0] IDLE = 2'b00;
	localparam [1:0] INIT_XFER = 2'b01;

	reg [AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awvalid;
	reg  	axi_wlast;
	reg  	axi_wvalid;
	reg  	axi_bready;
	reg [AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arvalid;
	reg  	axi_rready;
	reg [TRANSACTIONS_NUM : 0] 	write_index;
	reg [TRANSACTIONS_NUM : 0] 	read_index;
	wire [DATA_BYTE_WIDTH : 0] 	wburst_size_bytes;
	wire [DATA_BYTE_WIDTH : 0] 	rburst_size_bytes;
	reg [NO_BURSTS_REQ : 0] 	write_burst_counter;
	reg [NO_BURSTS_REQ : 0] 	read_burst_counter;
	reg  	start_single_burst_write;
	reg  	start_single_burst_read;
	reg  	writes_done;
	reg  	reads_done;
	reg  	error_reg;
	reg  	burst_write_active;
	reg  	burst_read_active;
	//Interface response error flags
	wire  	write_resp_error;
	wire  	read_resp_error;
	wire  	wnext;
	wire  	rnext;
	reg  	init_tx_ff;
	wire  	init_tx_pulse;
	reg  	init_rx_ff;
	wire  	init_rx_pulse;
	wire    init_tx_rx_pulse = init_rx_pulse | init_tx_pulse;

	assign awid	= 'b0;
	assign awaddr	= write_start_address/* + axi_awaddr*/;
	assign awlen	= write_burst_length;
	assign awsize	= write_burst_size;
	assign awburst	= 2'b01;
	assign awlock	= 1'b0;
	assign awcache	= 4'b0010;
	assign awprot	= 3'h0;
	assign awqos	= 4'h0;
	assign awvalid	= axi_awvalid;
	assign wdata	= write_data;
	assign wstrb	= {(AXI_DATA_WIDTH/8){1'b1}};
	assign wlast	= axi_wlast;
	assign wvalid	= axi_wvalid;
	assign bready	= axi_bready;
	assign arid	= 'b0;
	assign araddr	= read_start_address/* + axi_araddr*/;
	assign arlen	= read_burst_length;
	assign arsize	= read_burst_size;
	assign arburst	= 2'b01;
	assign arlock	= 1'b0;
	assign arcache	= 4'b0010;
	assign arprot	= 3'h0;
	assign arqos	= 4'h0;
	assign arvalid	= axi_arvalid;
	assign rready	= axi_rready;
	assign tx_done	= writes_done;
	assign rx_done	= reads_done;
	assign wburst_size_bytes	= ({1'b0,write_burst_length}+1) * (9'b1 << write_burst_size);
	assign rburst_size_bytes	= ({1'b0,read_burst_length}+1) * (9'b1 << read_burst_size);
	assign init_tx_pulse	= (!init_tx_ff) && init_write;
	assign init_rx_pulse	= (!init_rx_ff) && init_read;

	always @(posedge aclk)										      
	begin                                                                        
	  // Initiates AXI transaction delay    
	  if (aresetn == 0 )                                                   
	    begin                                                                    
	      init_tx_ff <= 1'b0;                                                   
	      init_rx_ff <= 1'b0;                                                   
	    end                                                                               
	  else                                                                       
	    begin  
	      init_tx_ff <= init_write;
	      init_rx_ff <= init_read;
	    end                                                                      
	end     

	//--------------------
	//Write Address Channel
	//--------------------
	always @(posedge aclk)                                   
	begin                                                                
	                                                                     
	  if (aresetn == 0)
	    begin                                                            
	      axi_awvalid <= 1'b0;                                           
	    end                                                              
	  else if(init_tx_pulse == 1'b1)
	      axi_awvalid <= 1'b0;                                           
	  else if (~axi_awvalid && start_single_burst_write)                 
	    begin                                                            
	      axi_awvalid <= 1'b1;                                           
	    end                                                              
	  else if (awready && axi_awvalid)                             
	    begin                                                            
	      axi_awvalid <= 1'b0;                                           
	    end                                                              
	  else                                                               
	    axi_awvalid <= axi_awvalid;                                      
	  end                                                                
	                                                                     
	always @(posedge aclk)                                         
	begin                                                                
	  if (aresetn == 0)
	    begin                                                            
	      axi_awaddr <= 'b0;                                             
	    end                                                              
	  else if(init_tx_pulse == 1'b1)
	      axi_awaddr <= 'b0;                                             
	  else if (awready && axi_awvalid)                             
	    begin                                                            
	      axi_awaddr <= axi_awaddr + wburst_size_bytes;                   
	    end                                                              
	  else                                                               
	    axi_awaddr <= axi_awaddr;                                        
	end                                                                

	//--------------------
	//Write Data Channel
	//--------------------
	assign wnext = wready & axi_wvalid & write_enable;                                   
	                                                                                  
	always @(posedge aclk)                                                      
	begin                                                                             
	  if (aresetn == 0)
	    begin                                                                         
	      axi_wvalid <= 1'b0;                                                         
	    end                                                                           
	  else if(init_tx_pulse == 1'b1)
	      axi_wvalid <= 1'b0;                                                         
	  else if (~axi_wvalid && start_single_burst_write)                               
	    begin                                                                         
	      axi_wvalid <= 1'b1;                                                         
	    end                                                                           
	  else if (wnext && axi_wlast)                                                    
	    axi_wvalid <= 1'b0;                                                           
	  else                                                                            
	    axi_wvalid <= axi_wvalid;                                                     
	end                                                                               
	                                                                                  
	always @(posedge aclk)                                                      
	begin                                                                             
	  if (aresetn == 0)
	    begin                                                                         
	      axi_wlast <= 1'b0;                                                          
	    end                                                                           
	    else if(init_tx_pulse == 1'b1)
	      axi_wlast <= 1'b0;                                                          
	  else if (((write_index == write_burst_length-1 && write_burst_length >= 2) && wnext) || (write_burst_length == 1 ))
	    begin                                                                         
	      axi_wlast <= 1'b1;                                                          
	    end
	  else if ((write_burst_length == 0) && ~axi_wvalid && start_single_burst_write)
	    begin
	  	axi_wlast <= 1'b1;
	    end                                                                      
	  else if (wnext)                                                                 
	    axi_wlast <= 1'b0;                                                            
	  else if (axi_wlast && write_burst_length == 1)                                   
	    axi_wlast <= 1'b0;                                                            
	  else                                                                            
	    axi_wlast <= axi_wlast;                                                       
	end                                                                               
	                                                                                  
	always @(posedge aclk)                                                      
	begin                                                                             
	  if (aresetn == 0)
	    begin                                                                         
	      write_index <= 0;                                                           
	    end                                                                           
	  else if(init_tx_pulse == 1'b1 || start_single_burst_write == 1'b1)
	      write_index <= 0;                                                           
	  else if (wnext && (write_index != write_burst_length))                         
	    begin                                                                         
	      write_index <= write_index + 1;                                             
	    end                                                                           
	  else                                                                            
	    write_index <= write_index;                                                   
	end                                                                               
	                                                                                    
	//----------------------------
	//Write Response Channel
	//----------------------------

	always @(posedge aclk)                                     
	begin                                                                 
	  if (aresetn == 0)
	    begin                                                             
	      axi_bready <= 1'b0;                                             
	    end                                                               
	  else if(init_tx_rx_pulse == 1'b1)
	      axi_bready <= 1'b0;                                             
	  else if (bvalid && ~axi_bready)                               
	    begin                                                             
	      axi_bready <= 1'b1;                                             
	    end                                                               
	  else if (axi_bready)                                                
	    begin                                                             
	      axi_bready <= 1'b0;                                             
	    end                                                               
	  else                                                                
	    axi_bready <= axi_bready;                                         
	end                                                                   
	                                                                      
	assign write_resp_error = axi_bready & bvalid & bresp[1]; 

	//----------------------------
	//Read Address Channel
	//----------------------------
	always @(posedge aclk)                                 
	begin                                                              
	                                                                   
	  if (aresetn == 0)
	    begin                                                          
	      axi_arvalid <= 1'b0;                                         
	    end                                                            
	  else if(init_rx_pulse == 1'b1 )
	      axi_arvalid <= 1'b0;                                         
	  else if (~axi_arvalid && start_single_burst_read)                
	    begin                                                          
	      axi_arvalid <= 1'b1;                                         
	    end                                                            
	  else if (arready && axi_arvalid)                           
	    begin                                                          
	      axi_arvalid <= 1'b0;                                         
	    end                                                            
	  else                                                             
	    axi_arvalid <= axi_arvalid;                                    
	end                                                                
	                                                                   
	always @(posedge aclk)                                       
	begin                                                              
	  if (aresetn == 0)
	    begin                                                          
	      axi_araddr <= 'b0;                                           
	    end                                                            
	  else if(init_rx_pulse == 1'b1)
	      axi_araddr <= 'b0;                                           
	  else if (arready && axi_arvalid)                           
	    begin                                                          
	      axi_araddr <= axi_araddr + rburst_size_bytes;                 
	    end                                                            
	  else                                                             
	    axi_araddr <= axi_araddr;                                      
	end                                                                

	//--------------------------------
	//Read Data (and Response) Channel
	//--------------------------------
	assign rnext = rvalid && axi_rready;                            
	                                                                      
	always @(posedge aclk)                                          
	begin                                                                 
	  if (aresetn == 0)
	    begin                                                             
	      read_index <= 0;                                                
	    end                                                               
	  else if (init_rx_pulse == 1'b1 || start_single_burst_read)
	      read_index <= 0;                                                
	  else if (rnext && (read_index != read_burst_length))              
	    begin                                                             
	      read_index <= read_index + 1;                                   
	    end                                                               
	  else                                                                
	    read_index <= read_index;                                         
	end                                                                   
	                                                                      
	always @(posedge aclk)                                          
	begin                                                                 
	  if (aresetn == 0)
	    begin                                                             
	      axi_rready <= 1'b0;                                             
	    end                                                               
	  else if(init_rx_pulse == 1'b1)
	      axi_rready <= 1'b0;                                             
	  else if (rvalid)                       
	    begin                                      
	    	if(read_enable) begin
	    	   if (rlast && axi_rready)          
	    	    begin                                  
	    	      axi_rready <= 1'b0;                  
	    	    end                                    
	    	   else                                    
	    	     begin                                 
	    	       axi_rready <= 1'b1;                 
	    	     end                                   
	  	 end
	  	 else begin
	    	      axi_rready <= 1'b0;                  
	  	 end
	    end                                        
	end                                            
	                                                                      
	assign read_resp_error = axi_rready & rvalid & rresp[1];  

	always @(posedge aclk)                                 
	begin                                                              
	  if (aresetn == 0)
	    begin                                                          
	      error_reg <= 1'b0;                                           
	    end                                                            
	  else if(init_tx_rx_pulse == 1'b1)
	      error_reg <= 1'b0;                                           
	  else if (write_resp_error || read_resp_error)   
	    begin                                                          
	      error_reg <= 1'b1;                                           
	    end                                                            
	  else                                                             
	    error_reg <= error_reg;                                        
	end                                                                

	always @(posedge aclk)                                                                              
	begin                                                                                                     
	  if (aresetn == 0)
	    begin                                                                                                 
	      write_burst_counter <= 'b0;                                                                         
	    end                                                                                                   
	  else if(init_tx_pulse == 1'b1)
	      write_burst_counter <= 'b0;                                                                         
	  else if (awready && axi_awvalid)                                                                  
	    begin                                                                                                 
	      if (write_burst_counter[NO_BURSTS_REQ] == 1'b0)                                                   
	        begin                                                                                             
	          write_burst_counter <= write_burst_counter + 1'b1;                                              
	        end                                                                                               
	    end                                                                                                   
	  else                                                                                                    
	    write_burst_counter <= write_burst_counter;                                                           
	end                                                                                                       
	                                                                                                          
	always @(posedge aclk)                                                                              
	begin                                                                                                     
	  if (aresetn == 0)
	    begin                                                                                                 
	      read_burst_counter <= 'b0;                                                                          
	    end                                                                                                   
	  else if(init_rx_pulse == 1'b1)
	      read_burst_counter <= 'b0;                                                                          
	  else if (arready && axi_arvalid)                                                                  
	    begin                                                                                                 
	      if (read_burst_counter[NO_BURSTS_REQ] == 1'b0)                                                    
	        begin                                                                                             
	          read_burst_counter <= read_burst_counter + 1'b1;                                                
	        end                                                                                               
	    end                                                                                                   
	  else                                                                                                    
	    read_burst_counter <= read_burst_counter;                                                             
	end                                                                                                       
	                                                                                                            
	//--------------------------------
	//Read Transaction FSM
	//--------------------------------
	reg [1:0] mst_exec_read_cur_state, mst_exec_read_next_state;
	reg reads_error;
	                                                                                                            
	always @(posedge aclk) begin    
	if (aresetn == 0) begin
		mst_exec_read_cur_state <= IDLE;                                                                          
	end                               
	else
		mst_exec_read_cur_state <= mst_exec_read_next_state;
	end

	always@(*) begin
		case(mst_exec_read_cur_state)
			IDLE: begin
				if(init_rx_pulse) begin
					mst_exec_read_next_state = INIT_XFER;
				end
				else
					mst_exec_read_next_state = IDLE;
			end
			INIT_XFER: begin
	            if(reads_done)  
	            	mst_exec_read_next_state = IDLE;                                                            
	            else                                                                                            
	                mst_exec_read_next_state = INIT_XFER;      
			end
			default:
					mst_exec_read_next_state = IDLE;
		endcase
	end//always

	always @ ( posedge aclk)                                                                            
	begin                                                                                                     
	  if (aresetn == 1'b0 )                                                                             
	    begin                                                                                                  
	      start_single_burst_read  <= 1'b0;                                                                   
	      reads_error <= 1'b0;   
	    end                                                                                                   
	  else                                                                                                    
	    begin                                                                                                 
	      case (mst_exec_read_cur_state)                                                                               
	        IDLE:                                                                                     
	            reads_error <= 1'b0;
	                                                                                                          
			INIT_XFER: begin                                                                                      
	            reads_error <= error_reg;
	            if (~axi_arvalid && ~burst_read_active && ~start_single_burst_read && ~reads_done)                         
	              begin                                                                                     
	                start_single_burst_read <= 1'b1;                                                        
	              end                                                                                       
	             else                                                                                         
	               begin                                                                                      
	                 start_single_burst_read <= 1'b0; //Negate to generate a pulse                            
	               end                                                                                        
	            end
	                                                                                                          
	        default :                                                                                         
	          	begin                                                                                           
	      	  	  start_single_burst_read  <= 1'b0;                                                                   
	      	  	  reads_error <= 1'b0;   
	          	end                                                                                             
	      endcase                                                                                             
	    end                                                                                                   
	end
	          
	//--------------------------------
	//Write Transaction FSM
	//--------------------------------
	reg [1:0] mst_exec_write_cur_state, mst_exec_write_next_state;
	reg writes_error;
	                                                                                                            
	always @(posedge aclk)   begin    
	if (aresetn == 0) begin
		mst_exec_write_cur_state <= IDLE;                                                                          
	end                               
	else
		mst_exec_write_cur_state <= mst_exec_write_next_state;
	end

	always@(*) begin
		case(mst_exec_write_cur_state)
			IDLE: begin
				if(init_tx_pulse) begin
					mst_exec_write_next_state = INIT_XFER;
				end
				else
					mst_exec_write_next_state = IDLE;
			end
			INIT_XFER: begin
	            if(writes_done)  
	            	mst_exec_write_next_state = IDLE;                                                            
	            else                                                                                            
	                mst_exec_write_next_state = INIT_XFER;      
			end
			default:
					mst_exec_write_next_state = IDLE;
		endcase
	end//always

	always @ ( posedge aclk)                                                                            
	begin                                                                                                     
	  if (aresetn == 1'b0 )                                                                             
	    begin                                                                                                 
	      start_single_burst_write  <= 1'b0;                                                                   
	      writes_error <= 1'b0;   
	    end                                                                                                   
	  else                                                                                                    
	    begin                                                                                                 
	      case (mst_exec_write_cur_state)                                                                               
	        IDLE:                                                                                     
	            writes_error <= 1'b0;
	                                                                                                          
			INIT_XFER: begin                                                                                      
	            writes_error <= error_reg;
	            if (~axi_arvalid && ~burst_write_active && ~start_single_burst_write && ~writes_done)                         
	              begin                                                                                     
	                start_single_burst_write <= 1'b1;                                                        
	              end                                                                                       
	             else                                                                                         
	               begin                                                                                      
	                 start_single_burst_write <= 1'b0; //Negate to generate a pulse                            
	               end                                                                                        
	            end  
	                                                                                                          
	        default :                                                                                         
	          	begin                                                                                           
	      	  	  start_single_burst_write  <= 1'b0;                                                                   
	      	  	  writes_error <= 1'b0;   
	          	end                                                                                             
	      endcase                                                                                             
	    end                                                                                                   
	end
                                                                                                              
    assign error = reads_error | writes_error;
                                                                                                              
    always @(posedge aclk)                                                                              
    begin                                                                                                     
      if (aresetn == 0)
        burst_write_active <= 1'b0;                                                                           
      else if(init_tx_pulse == 1'b1)
        burst_write_active <= 1'b0;                                                                           
      else if (start_single_burst_write)                                                                      
        burst_write_active <= 1'b1;                                                                           
      else if (bvalid && axi_bready)                                                                    
        burst_write_active <= 0;                                                                              
    end                                                                                                       
                                                                                                              
    always @(posedge aclk)                                                                              
    begin                                                                                                     
      if (aresetn == 0)
        writes_done <= 1'b0;                                                                                   
      else if(init_tx_pulse == 1'b1)
        writes_done <= 1'b0;                                                                                   
      else if (bvalid && (write_burst_counter[NO_BURSTS_REQ]) && axi_bready)                          
        writes_done <= 1'b1;                                                                                  
      else                                                                                                    
        writes_done <= writes_done;                                                                           
      end                                                                                                     
                                                                                                              
    always @(posedge aclk)                                                                              
    begin                                                                                                     
      if (aresetn == 0)
        burst_read_active <= 1'b0;                                                                            
      else if(init_rx_pulse == 1'b1)
        burst_read_active <= 1'b0;                                                                            
      else if (start_single_burst_read)                                                                       
        burst_read_active <= 1'b1;                                                                            
      else if (rvalid && axi_rready && rlast)                                                     
        burst_read_active <= 0;                                                                               
      end                                                                                                     
                                                                                                              
    always @(posedge aclk)                                                                              
    begin                                                                                                     
      if (aresetn == 0)
        reads_done <= 1'b0;                                                                                   
      else if(init_rx_pulse == 1'b1)
        reads_done <= 1'b0;                                                                                   
      else if (rvalid && axi_rready && (read_index == read_burst_length) && (read_burst_counter[NO_BURSTS_REQ]))
        reads_done <= 1'b1;                                                                                   
      else                                                                                                    
        reads_done <= reads_done;                                                                             
      end                                                                                                     

endmodule
