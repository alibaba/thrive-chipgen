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

module spu_ctl 
(
    input wire clk, 
    input wire rstn,
    
    input wire spidr_vld,
    input wire sprr_vld,
    
    input wire retire_keep,

    output reg sel_od,
    output reg head_flt_vld,
    output reg data_flt_vld,
    input  wire od_vld,
    input  wire od_rdy,
  
    output reg rd_pb_en,
    input  wire pb_empty,

    output reg  start_read_sram,
    input  wire  read_sram_done,
    input  wire  read_sram_err,

    output reg  head_flt_timeout,
    output reg  data_flt_timeout,
    output reg  read_sram_timeout, 
    output reg  pkt_req_timeout, 
    output reg  read_sram_error, 
    output reg  miss_routing_req

);
    localparam IDLE     = 6'b000001,
               SPID     = 6'b000010,
               SHF      = 6'b000100,
               SDF      = 6'b001000,
               SDF_DONE = 6'b010000,
               ERROR    = 6'b100000;

    localparam PKT_REQ_DLY        = 32'd1000;
    localparam SND_FLT_DLY        = 32'd2000;
    localparam WR_BUF_LATENCY     = 2'd3;    // data is available and pb_empty is de-asserted after 3 cycles after wr_en is raised.

    wire       pkt_req_to;
    wire       snd_head_flt_to;
    wire       snd_data_flt_to;
    wire       clear_data_flt_to;
    wire       buf_data_arrived;

    reg [5:0]  spu_state, spu_state_nxt;
    reg [31:0] pkt_req_ticks;
    reg [31:0] snd_head_flt_ticks;
    reg [31:0] snd_data_flt_ticks;
    reg [31:0] clear_data_flt_ticks;
    reg [1:0]  write_buffer_ticks;

    reg  head_flt_timeout_nxt;
    reg  data_flt_timeout_nxt;
    reg  pkt_req_timeout_nxt;
    reg  read_sram_error_nxt;
    reg  miss_routing_req_nxt;

    assign pkt_req_to        = (pkt_req_ticks > PKT_REQ_DLY);
    assign snd_head_flt_to   = (snd_head_flt_ticks > SND_FLT_DLY);
    assign snd_data_flt_to   = (snd_data_flt_ticks > SND_FLT_DLY);
    assign clear_data_flt_to = (clear_data_flt_ticks > SND_FLT_DLY);
    assign buf_data_arrived  = (write_buffer_ticks == WR_BUF_LATENCY);

    // Combinational always block for the state machine and output
    always @(*)
    begin
        // assign default values
        spu_state_nxt = spu_state;
        start_read_sram = 1'b0;
        head_flt_vld    = 1'b0;
        data_flt_vld    = 1'b0;
        sel_od          = 1'b0;
        rd_pb_en        = 1'b0;
    
        head_flt_timeout_nxt = 1'b0;
        data_flt_timeout_nxt = 1'b0;
        pkt_req_timeout_nxt  = 1'b0;  
        read_sram_error_nxt  = 1'b0;
        miss_routing_req_nxt = 1'b0;


        case(spu_state)
        IDLE: begin
            if (spidr_vld) 
               spu_state_nxt = SPID; 
            else if (sprr_vld) begin
               spu_state_nxt = ERROR;
               miss_routing_req_nxt = 1'b1;
            end
        end
        SPID: begin
            if (sprr_vld)
                spu_state_nxt = SHF;
            else if (pkt_req_to) begin
                spu_state_nxt = ERROR;
                pkt_req_timeout_nxt = 1'b1;
            end
        end
        SHF: begin
            start_read_sram = 1'b1;
            head_flt_vld    = 1'b1;
            sel_od          = 1'b0;
            if (od_rdy)
                spu_state_nxt = SDF;
            else if (snd_head_flt_to) begin
                spu_state_nxt = ERROR;
                head_flt_timeout_nxt = 1'b1;
            end
        end
        SDF: begin
            sel_od         = 1'b1;
            data_flt_vld   = ~pb_empty;
            rd_pb_en       = od_vld & od_rdy;
            if (read_sram_done)
                spu_state_nxt = SDF_DONE;
            else if (read_sram_err | snd_data_flt_to) begin
                spu_state_nxt = ERROR;
                read_sram_error_nxt = read_sram_err;
                data_flt_timeout_nxt = snd_data_flt_to;
            end
        end
        SDF_DONE: begin
            sel_od         = 1'b1;
            data_flt_vld   = ~pb_empty;
            rd_pb_en       = od_vld & od_rdy;
            if (pb_empty && buf_data_arrived)
                spu_state_nxt = IDLE;
            else if (read_sram_err | clear_data_flt_to) begin
                spu_state_nxt = ERROR;
                read_sram_error_nxt = read_sram_error;
                data_flt_timeout_nxt = clear_data_flt_to;
            end
        end
        ERROR: begin
            if (retire_keep) begin
               spu_state_nxt = spu_state;
               head_flt_timeout_nxt = head_flt_timeout;
               data_flt_timeout_nxt = data_flt_timeout;
               pkt_req_timeout_nxt  = pkt_req_timeout;  
               read_sram_error_nxt  = read_sram_error;
               miss_routing_req_nxt = miss_routing_req;
            end
            else 
                spu_state_nxt = IDLE;
        end
        default: begin
        end
        endcase
    end

    // Flops Inference
    always @(posedge clk or negedge rstn)
    begin
        if (!rstn) begin
               spu_state <= IDLE;
               head_flt_timeout <= 1'b0;
               data_flt_timeout <= 1'b0;
               pkt_req_timeout  <= 1'b0;  
               read_sram_error  <= 1'b0;
               read_sram_timeout <= 1'b0;
               miss_routing_req  <= 1'b0;
        end
        else begin
               spu_state <= spu_state_nxt;
               head_flt_timeout <= head_flt_timeout_nxt;
               data_flt_timeout <= data_flt_timeout_nxt;
               pkt_req_timeout  <= pkt_req_timeout_nxt;  
               read_sram_error  <= read_sram_error_nxt;
               read_sram_timeout  <= 1'b0; //fixed to zero
               miss_routing_req   <= miss_routing_req_nxt;
        end
    end
 
    always @(posedge clk or negedge rstn)
    begin
        if (!rstn)
            pkt_req_ticks <= 0;
        else if (spu_state == SPID)
            pkt_req_ticks <= pkt_req_ticks + 1;
        else if (spu_state == IDLE)
            pkt_req_ticks <= 0;
    end
    
    always @(posedge clk or negedge rstn)
    begin
        if (!rstn)
            snd_head_flt_ticks <= 0;
        else if ((spu_state == SHF))
            snd_head_flt_ticks <= (od_vld & ~od_rdy) ? snd_head_flt_ticks + 1 : 0;
        else if (spu_state == IDLE)
            snd_head_flt_ticks <= 0;
    end

    always @(posedge clk or negedge rstn)
    begin
        if (!rstn)
            snd_data_flt_ticks <= 0;
        else if ((spu_state == SDF))
            snd_data_flt_ticks <= (od_vld & ~od_rdy) ? snd_data_flt_ticks + 1 : 0;
        else if (spu_state == IDLE)
            snd_data_flt_ticks <= 0;
    end

    always @(posedge clk or negedge rstn)
    begin
        if (!rstn)
            clear_data_flt_ticks <= 0;
        else if ((spu_state == SDF_DONE))
            clear_data_flt_ticks <= (od_vld & ~od_rdy) ? clear_data_flt_ticks + 1 : 0;
        else if (spu_state == IDLE)
            clear_data_flt_ticks <= 0;
    end

    always @(posedge clk or negedge rstn)
    begin
        if (!rstn)
            write_buffer_ticks <= 2'b0;
        else if (spu_state == SDF_DONE)
            write_buffer_ticks <= (pb_empty) ? write_buffer_ticks + 1'b1 : 1'b0;
        else
            write_buffer_ticks <= 2'b0;
    end
///////////////////////////////////////////////////////
// assertion
//////////////////////////////////////////////////////
`ifdef RTL_ASSERTION
    reg [31:0] rd_pkt_buf_cnt;
    always_ff @(posedge clk or negedge rstn) 
    begin
        if (!rstn)
            rd_pkt_buf_cnt <= 32'b0;
        else if (spu_state == SDF_DONE)
            rd_pkt_buf_cnt <= (rd_pb_en) ? rd_pkt_buf_cnt + 1'b1: rd_pkt_buf_cnt;
        else
            rd_pkt_buf_cnt <= 32'b0;
    end

    wire vld_buf_cnt; 
    assign vld_buf_cnt = (rd_pkt_buf_cnt <= (32'b1 << `NOU_PKT_BUF_SIZE_LOG2));
     sva_always #(1, "packet buffer count is invalid") u_assert_always_pb_cnt(.test_expr(vld_buf_cnt), .reset(~rstn), .clock(clk));

`endif

endmodule

