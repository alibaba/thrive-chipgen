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

module nou_fetch 
(
    input  wire clk,
    input  wire rstn,

    // XoCC Request Interface
    input  wire[`NOU_XOCC_CMD_WIDTH-1:0]    req_fifo_nou_data_f1,
    input  wire                             req_fifo_nou_empty_f0,
    output wire                             nou_req_fifo_rd_en_f0,

    output wire [1/*valid*/ + `NOU_SID_WIDTH + `NOU_XOCC_CMD_WIDTH + `NOU_UOV_SIZE - 1: 0]
                                            xrq_entry_output,
    output wire                             xrq_entry_output_valid,
    input wire                              decode_issue_ack_in
);

/********** SIGNAL DECLARE **************/

wire    xrq_is_full;
wire    xrq_is_almost_full;
wire    xrq_issue_ack_out;
wire    xrq_is_empty;

wire[1/*valid*/ + `NOU_SID_WIDTH + `NOU_XOCC_CMD_WIDTH + `NOU_UOV_SIZE - 1: 0]
        xrq_entry_input;
wire    xrq_entry_input_valid;
reg[`NOU_UOV_SIZE-1:0]      xrq_entry_input_unit_mask;

reg[`NOU_SID_WIDTH-1:0]     sid_allocation;


// Fetch controller
fetch_ctl 
u_fetch_ctl(
    .clk(clk),
    .rstn(rstn),

    .fifo_empty_f0(req_fifo_nou_empty_f0),
    .fifo_rd_en_f0(nou_req_fifo_rd_en_f0),

    .xrq_is_full(xrq_is_full),
    .xrq_is_almost_full(xrq_is_almost_full),

    .data_vld_f1(xrq_entry_input_valid)
);


// Predecode, using combinational always block
always @(*)
begin
    case(req_fifo_nou_data_f1[`NOU_REQ_TYPE_ID_WIDTH-1:0])
        `REQ_TYPE_GNT_BUF : 
        begin
            xrq_entry_input_unit_mask = xrq_entry_input_valid? `UNIT_MASK_TO_BRR : `UNIT_MASK_TO_IRR;
        end
        `REQ_TYPE_GNT_PKT_WL :
        begin
            xrq_entry_input_unit_mask = xrq_entry_input_valid? `UNIT_MASK_TO_PWRR : `UNIT_MASK_TO_IRR;
        end
        `REQ_TYPE_SND_PKT_RID :
        begin
            xrq_entry_input_unit_mask = xrq_entry_input_valid? `UNIT_MASK_TO_SPIDR : `UNIT_MASK_TO_IRR;
        end
        `REQ_TYPE_SND_PKT :
        begin
            xrq_entry_input_unit_mask = xrq_entry_input_valid? `UNIT_MASK_TO_SPRR : `UNIT_MASK_TO_IRR;
        end
        `REQ_TYPE_REL_BUF :
        begin
            xrq_entry_input_unit_mask = xrq_entry_input_valid? `UNIT_MASK_TO_BRR : `UNIT_MASK_TO_IRR;
        end
        `REQ_TYPE_REL_PKT_WL :
        begin
            xrq_entry_input_unit_mask = xrq_entry_input_valid? `UNIT_MASK_TO_PWRR : `UNIT_MASK_TO_IRR;
        end
        default : xrq_entry_input_unit_mask = `UNIT_MASK_TO_IRR;
    endcase
end


// Sequence ID (sid) allocation
// Note: Adjacent SPIDR and SPRR have the same sid
always @(posedge clk or negedge rstn)
begin
    if (!rstn)
    begin
        sid_allocation <= 1; // reset sid to 1 since RPU receive packet response gets sid of 0 (highest priority)
    end
    else if (xrq_entry_input_valid && xrq_entry_input_unit_mask != `UNIT_MASK_TO_SPIDR)
    begin
        sid_allocation <= sid_allocation + 1;
    end
    else
    begin
        sid_allocation <= sid_allocation;
    end
end


// Prepare input entry to XRQ: (vld, sid, rtype, rdata, um)
// Note the order of each field, e.g. vld is at entry[0] which is on the right end of xrq_entry_input
assign xrq_entry_input = {xrq_entry_input_unit_mask, req_fifo_nou_data_f1, sid_allocation, xrq_entry_input_valid};


// XoCC Request Queue (XRQ)
fifo_queue
#(
    .SINGLE_ENTRY_WIDTH_IN_BITS (1/*valid*/ + `NOU_SID_WIDTH + `NOU_XOCC_CMD_WIDTH + `NOU_UOV_SIZE),
    .QUEUE_PTR_WIDTH_IN_BITS (`NOU_XRQ_PTR_WIDTH)
)
u_xrq
(
    .clk_in(clk),
    .reset_in(rstn),

    .is_empty_out(xrq_is_empty),
    .is_full_out(xrq_is_full),
    .is_almost_full_out(xrq_is_almost_full),

    .request_in(xrq_entry_input),
    .request_valid_in(xrq_entry_input_valid),
    .issue_ack_out(xrq_issue_ack_out),

    .request_out(xrq_entry_output),
    .request_valid_out(xrq_entry_output_valid),
    .issue_ack_in(decode_issue_ack_in)
);


endmodule

