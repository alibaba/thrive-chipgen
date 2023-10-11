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

`include "nou_define.h"

module rpu_ctl (
    input wire clk,
    input wire rstn,

    output logic start_aw,

    // Signals to/from or_encode
    input logic or_ready,
    output logic ob_rsp_vld,
    output logic [`NOU_TYPE_WIDTH-1:0] ob_rsp_type,
    output logic ob_rsp_status,
    output logic [`NOU_ERR_CODE_WIDTH-1:0] ob_rsp_err,

    // Signals that control packet buffer write
    input logic ib_vld,
    input logic [`NOU_TYPE_WIDTH-1:0] ib_type,
    input logic pb_full,
    input logic write_done,
    input logic write_err,
    output logic wr_en,
    output logic id_ready,

    // Signals to/from buffer unit / PWL
    input logic gnt_buf_vld,
    input logic gnt_buf_status,
    input logic [`NOU_ERR_CODE_WIDTH-1:0] err_code,
    input logic gnt_pkt_vld,
    input logic gnt_pkt_status,
    output logic chk_pkt_vld,
    output logic req_buf_vld,

    // Signals to/from rcv_pkt_rsp_bus
    input logic gnt_rcv_pkt_rsp,
    output logic rcv_pkt_id_vld,
    output logic rcv_pkt_vld,
    output logic sel_rcv_rsp
);

// Internal signal declaration
    parameter [2:0] IDLE            = 3'd0,
                    RCV_HEAD_FLIT   = 3'd1,
                    OB_HEAD_RSP     = 3'd2,
                    RCV_DATA_FLIT   = 3'd3,
                    RSP_RCV_PKT_ID  = 3'd4,
                    RSP_RCV_PKT     = 3'd5,
                    OB_DATA_RSP     = 3'd6,
                    ERROR           = 3'd7;

    localparam TICK_HOLD = 32'd11000;

    reg [2:0] state;
    reg [2:0] next;
    reg [2:0] last;

    logic [10:0] ob_head_rsp_tick;
    logic [10:0] ob_data_rsp_tick;
    logic [10:0] ib_data_flit_tick;
    logic [10:0] rsp_rcv_pkt_tick;

    wire buf_status_q;
    wire pkt_status_q;
    wire write_err_q;

    dffr ff_buf_failed (
        .clk(clk),
        .rn(rstn),
        .g(gnt_buf_vld),
        .d(gnt_buf_status),
        .q(buf_status_q)
    );

    dffr ff_pkt_failed (
        .clk(clk),
        .rn(rstn),
        .g(gnt_pkt_vld),
        .d(gnt_pkt_status),
        .q(pkt_status_q)
    );

    dffr ff_write_err (
        .clk(clk),
        .rn(rstn),
        .g(~|(state^RCV_DATA_FLIT)),
        .d(write_err),
        .q(write_err_q)
    );

// main code
    always @(posedge clk or negedge rstn)
    begin
        if (!rstn) begin
            state <= IDLE;
            last <= state;
        end
        else begin
            if (state != ERROR)
                last <= state;
            state <= next;
        end
    end

    always @(posedge clk or negedge rstn)
    begin 
        if (!rstn) begin
            ob_head_rsp_tick <= 0;
            ob_data_rsp_tick <= 0;
            ib_data_flit_tick <= 0;
            rsp_rcv_pkt_tick <= 0;
        end
        else if (((state == OB_HEAD_RSP) || (state == RCV_DATA_FLIT) || (state == RSP_RCV_PKT_ID) || (state == RSP_RCV_PKT) || (state == OB_DATA_RSP)) && (state != next) && (next != ERROR)) begin
            ob_head_rsp_tick <= 0;
            ob_data_rsp_tick <= 0;
            ib_data_flit_tick <= 0;
            rsp_rcv_pkt_tick <= 0;
        end
        else if ((state == OB_HEAD_RSP) && (state == next))
            ob_head_rsp_tick <= ob_head_rsp_tick + 1;
        else if ((state == RCV_DATA_FLIT) && (state == next))
            ib_data_flit_tick <= ib_data_flit_tick + 1;
        else if ((state == RSP_RCV_PKT_ID) && (state == next))
            rsp_rcv_pkt_tick <= rsp_rcv_pkt_tick + 1;
        else if ((state == RSP_RCV_PKT) && (state == next))
            rsp_rcv_pkt_tick <= rsp_rcv_pkt_tick + 1;
        else if ((state == OB_DATA_RSP) && (state == next))
            ob_data_rsp_tick <= ob_data_rsp_tick + 1;
        else if (state == IDLE) begin
            ob_head_rsp_tick <= 0;
            ob_data_rsp_tick <= 0;
            ib_data_flit_tick <= 0;
            rsp_rcv_pkt_tick <= 0;
        end
    end 

    always @*
    begin
        next = state;
        ob_rsp_vld = 0;
        ob_rsp_type = 0;
        ob_rsp_status = 0;
        ob_rsp_err = 0;
        wr_en = 0;
        id_ready = 0;
        chk_pkt_vld = 0;
        req_buf_vld = 0;
        sel_rcv_rsp = 0;
        rcv_pkt_id_vld = 0;
        rcv_pkt_vld = 0;

        case (state)
            IDLE: begin
                if (ib_vld && (ib_type == `HEAD_FLIT_TYPE)) next = RCV_HEAD_FLIT;

                id_ready = 1;
            end
            RCV_HEAD_FLIT: begin
                req_buf_vld = 1;
                chk_pkt_vld = 1;

                if (gnt_buf_vld && (gnt_buf_status == `RSP_STATUS_OK) && gnt_pkt_vld && (gnt_pkt_status == `RSP_STATUS_OK)) next = OB_HEAD_RSP;
                else if ((gnt_buf_vld && (gnt_buf_status == `RSP_STATUS_ERR)) || (gnt_pkt_vld && (gnt_pkt_status == `RSP_STATUS_ERR))) next = ERROR;
            end
            OB_HEAD_RSP: begin
                ob_rsp_vld = 1;
                ob_rsp_type = `HEAD_FLIT_TYPE;
                ob_rsp_status = `RSP_STATUS_OK;

                if (or_ready & ob_rsp_vld) next = RCV_DATA_FLIT;
                else if (ob_head_rsp_tick > TICK_HOLD) next = ERROR;
            end
            RCV_DATA_FLIT: begin
                if (ib_vld && (ib_type == `DATA_FLIT_TYPE) && (!pb_full)) begin
                    wr_en = 1;
                    id_ready = 1;
                end

                if (write_done) next = RSP_RCV_PKT_ID;
                else if (write_err || (ib_data_flit_tick > TICK_HOLD)) next = ERROR;
            end
            RSP_RCV_PKT_ID: begin
                rcv_pkt_id_vld = 1;
                sel_rcv_rsp = 0;

                if (gnt_rcv_pkt_rsp) next = RSP_RCV_PKT;
                else if (rsp_rcv_pkt_tick > TICK_HOLD) next = ERROR;
            end
            RSP_RCV_PKT: begin
                rcv_pkt_vld = 1;
                sel_rcv_rsp = 1;
                
                if (gnt_rcv_pkt_rsp) next = OB_DATA_RSP;
                else if (rsp_rcv_pkt_tick > TICK_HOLD) next = ERROR;
            end
            OB_DATA_RSP: begin
                ob_rsp_vld = 1;
                ob_rsp_type = `DATA_FLIT_TYPE;
                ob_rsp_status = `RSP_STATUS_OK;
                
                if (or_ready) next = IDLE;
                else if (ob_data_rsp_tick > TICK_HOLD) next = ERROR;
            end
            ERROR: begin
                ob_rsp_vld = 1;
                ob_rsp_status = `RSP_STATUS_ERR;
                if (last == RCV_HEAD_FLIT) begin
                    if (buf_status_q == 1) begin
                        ob_rsp_type = 0;
                        ob_rsp_err = `NO_BUF_AVAILABLE;
                    end
                    else if (pkt_status_q == 1) begin
                        ob_rsp_type = 0;
                        ob_rsp_err = `PKT_NOT_IN_PWL;
                    end
                end
                else if (last == OB_HEAD_RSP) begin
                    if (ob_head_rsp_tick > TICK_HOLD) begin
                        ob_rsp_type = 0;
                        ob_rsp_err = `TIME_OUT_OB_HEAD_RSP;
                    end
                end
                else if (last == RCV_DATA_FLIT) begin
                    if (write_err_q == 1) begin
                        ob_rsp_type = 1;
                        ob_rsp_err = `WRITE_SRAM_ERROR;
                    end
                    else if (ib_data_flit_tick > TICK_HOLD) begin
                        ob_rsp_type = 1;
                        ob_rsp_err = `TIME_OUT_IB_FLIT;
                    end
                end
                else if (last == RSP_RCV_PKT_ID) begin
                    if (rsp_rcv_pkt_tick > TICK_HOLD) begin
                        ob_rsp_type = 1;
                        ob_rsp_err = `TIME_OUT_RCV_PKT;
                    end
                end
                else if (last == OB_DATA_RSP) begin
                    if (ob_data_rsp_tick > TICK_HOLD) begin
                        ob_rsp_type = 1;
                        ob_rsp_err = `TIME_OUT_OB_DATA_RSP;
                    end
                end

                if (or_ready) next = IDLE;
            end
        endcase
    end

    assign start_aw = (next == RCV_DATA_FLIT) && (state != next);

endmodule
