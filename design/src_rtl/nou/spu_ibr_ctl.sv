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

module spu_ibr_ctl 
(
    input wire clk, 
    input wire rstn,
   
    input retire_keep,

    input  wire ib_rsp_vld,
    output reg ib_rsp_rdy,

    input  wire[1:0]                    ib_rsp_type,
    input  wire[`NOU_TID_WIDTH-1:0]     ib_rsp_tid,
    input  wire[`NOU_TILE_ID_WIDTH-1:0] ib_rsp_dst_tile_id,
    input  wire                         ib_rsp_status,
     
    input  wire[`NOU_TID_WIDTH-1:0]     req_trans_id,
    input  wire[`NOU_TILE_ID_WIDTH-1:0] local_tile_id,

    output reg  pkt_result_ok,
    output reg  pkt_result_err,
    output reg  head_flt_rsp_to,
    output reg  data_flt_rsp_to,
    output reg  trans_id_mismatch, 
    output reg  tile_id_mismatch
);

    localparam IDLE        =  4'b0001,
               HEAD_RSP    =  4'b0010,
               DATA_RSP    =  4'b0100,
               RSP_ERR     =  4'b1000;
   
    localparam HEAD_FLIT_RSP = 2'd0,
               DATA_FLIT_RSP = 2'd1;     
            
    localparam DATA_RSP_DLY = 32'd100000;

    wire status_err;
    wire tile_id_mis; 
    wire  trans_id_mis; 

    reg [3:0]   ibr_state, ibr_state_nxt;
    reg [31:0]  data_rsp_ticks; 
    
    reg rsp_err_nxt;
    reg trans_id_mis_nxt;
    reg tile_id_mis_nxt;
    reg data_rsp_to_nxt;

    assign status_err = (ib_rsp_status == `RSP_STATUS_ERR);
    assign trans_id_mis = (ib_rsp_tid != req_trans_id);
    assign tile_id_mis = (ib_rsp_dst_tile_id != local_tile_id);
    assign data_rsp_timeout = (data_rsp_ticks > DATA_RSP_DLY);
    
    // Combinational always block for the state machine and output
    always @(*)
    begin
        // assign default values
        ibr_state_nxt     = ibr_state;
        ib_rsp_rdy        = 1'b0;
        pkt_result_ok     = 1'b0;
        
        rsp_err_nxt       = 1'b0;
        trans_id_mis_nxt  = 1'b0;
        tile_id_mis_nxt   = 1'b0;
        data_rsp_to_nxt   = 1'b0;

        case(ibr_state)
        IDLE: begin
            if (ib_rsp_vld && (ib_rsp_type == HEAD_FLIT_RSP)) begin
                ibr_state_nxt = HEAD_RSP;
                ib_rsp_rdy = 1'b1;
            end
        end
        HEAD_RSP: begin
             if (data_rsp_timeout || status_err || trans_id_mis || tile_id_mis) begin
                    ibr_state_nxt = RSP_ERR;
                    rsp_err_nxt = status_err;
                    trans_id_mis_nxt = trans_id_mis;
                    tile_id_mis_nxt = tile_id_mis;
                    data_rsp_to_nxt = data_rsp_timeout;
             end
             else if (ib_rsp_vld && (ib_rsp_type == DATA_FLIT_RSP)) begin
                ibr_state_nxt = DATA_RSP;
                ib_rsp_rdy = 1'b1;
             end
        end
        DATA_RSP: begin
             if (status_err || trans_id_mis || tile_id_mis) begin
                ibr_state_nxt = RSP_ERR;
                rsp_err_nxt = status_err;
                trans_id_mis_nxt = trans_id_mis;
                tile_id_mis_nxt = tile_id_mis;
             end
             else if (retire_keep)begin
                pkt_result_ok = 1'b1;
                ibr_state_nxt = DATA_RSP;
             end
             else begin
                pkt_result_ok = 1'b1;
                ibr_state_nxt = IDLE;
             end
        end
        RSP_ERR: begin
            if (retire_keep) begin
                rsp_err_nxt       = pkt_result_err;
                trans_id_mis_nxt  = trans_id_mismatch;
                tile_id_mis_nxt   = tile_id_mismatch;
                data_rsp_to_nxt   = data_flt_rsp_to;
            end
            else
                ibr_state_nxt = IDLE;
        end
        default: begin
        end
        endcase
    end

    // Flops Inference
    always @(posedge clk or negedge rstn)
    begin
        if (!rstn) begin
            ibr_state          <= IDLE;
            pkt_result_err     <= 1'b0;
            trans_id_mismatch  <= 1'b0;
            tile_id_mismatch   <= 1'b0;
            head_flt_rsp_to    <= 1'b0;
            data_flt_rsp_to    <= 1'b0;
        end
        else begin
            ibr_state         <= ibr_state_nxt;
            pkt_result_err    <= rsp_err_nxt;
            trans_id_mismatch <= trans_id_mis_nxt; 
            tile_id_mismatch  <= tile_id_mis_nxt;
            head_flt_rsp_to   <= 1'b0;   //fixed to zero
            data_flt_rsp_to   <= data_rsp_to_nxt;
        end

    end
    
    always @(posedge clk or negedge rstn)
    begin
        if (!rstn)
            data_rsp_ticks <= 0;
        else if (ibr_state == HEAD_RSP)
            data_rsp_ticks <= data_rsp_ticks + 1;
        else if (ibr_state == IDLE)
            data_rsp_ticks <= 0;
    end
endmodule

