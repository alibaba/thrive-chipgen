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


module nou_bu
(
    input wire clk,
    input wire rstn,

    // BRR Interface
    input  wire                                             brr_bu_vld,
    input  wire [`NOU_SID_WIDTH-1:0]                        brr_bu_sid,
    input  wire [`NOU_BUF_OP_TYPE_WIDTH-1:0]                brr_bu_op_type,
    input  wire [`NOU_BUF_ID_WIDTH-1:0]                     brr_bu_buf_id,
    input  wire [`NOU_BUF_ADDR_WIDTH-1:0]                   brr_bu_buf_addr,
    input  wire [`NOU_BUF_SZ_WIDTH-1:0]                     brr_bu_buf_size,
    input  wire [`NOU_BUF_RM_WIDTH-1:0]                     brr_bu_rm,

    // RPU Interface
    input  wire                                             rpu_bu_req_buf_vld,
    input  wire [`NOU_PKT_HEADER_SZ_WIDTH-1:0]              rpu_bu_req_buf_header_size,
    input  wire [`NOU_PKT_DATA_SZ_WIDTH-1:0]                rpu_bu_req_buf_data_size,
    output wire                                             bu_rpu_gnt_buf_vld,
    output wire                                             bu_rpu_gnt_buf_status,
    output wire [`NOU_PKT_HEADER_ADDR_WIDTH-1:0]            bu_rpu_header_buf_addr,
    output wire [`NOU_PKT_DATA_ADDR_WIDTH-1:0]              bu_rpu_data_buf_addr,
    output wire [`NOU_ERR_CODE_WIDTH-1:0]                   bu_rpu_gnt_buf_err_code,

    // BURR Interface
    input  wire                                             retire_burr_keep,
    output wire                                             burr_retire_vld,
    output wire [`NOU_SID_WIDTH-1:0]                        burr_retire_sid,
    output wire [`NOU_RSP_TYPE_ID_WIDTH-1:0]                burr_retire_rsp_type,
    output wire [`NOU_BUF_ID_WIDTH-1:0]                     burr_retire_buf_id,
    output wire                                             burr_retire_status,
    output wire [`NOU_ERR_CODE_WIDTH-1:0]                   burr_retire_err_code,
    output wire [`NOU_BUF_RM_WIDTH-1:0]                     burr_retire_rm
);

    localparam BUF_ID_WIDTH = 5;
    localparam BUF_SLOT_ENTRIES = 1 << BUF_ID_WIDTH;

    // Input, reset value, write enable, and output signals of buffer slots
    wire [BUF_SLOT_ENTRIES-1:0]             wr_en;
    wire [`NOU_BUF_SLOT_STATUS_WIDTH-1:0]   buf_slots_status_rst[BUF_SLOT_ENTRIES-1:0];
    wire [`NOU_BUF_SLOT_STATUS_WIDTH-1:0]   buf_slots_status_in[BUF_SLOT_ENTRIES-1:0];
    wire [`NOU_BUF_SLOT_STATUS_WIDTH-1:0]   buf_slots_status_q[BUF_SLOT_ENTRIES-1:0];
    wire [`NOU_BUF_ADDR_WIDTH-1:0]          buf_slots_addr_rst[BUF_SLOT_ENTRIES-1:0];
    wire [`NOU_BUF_ADDR_WIDTH-1:0]          buf_slots_addr_in[BUF_SLOT_ENTRIES-1:0];
    wire [`NOU_BUF_ADDR_WIDTH-1:0]          buf_slots_addr_q[BUF_SLOT_ENTRIES-1:0];
    wire [`NOU_BUF_SZ_WIDTH-1:0]            buf_slots_size_rst[BUF_SLOT_ENTRIES-1:0];
    wire [`NOU_BUF_SZ_WIDTH-1:0]            buf_slots_size_in[BUF_SLOT_ENTRIES-1:0];
    wire [`NOU_BUF_SZ_WIDTH-1:0]            buf_slots_size_q[BUF_SLOT_ENTRIES-1:0];

    // valid signals for granted header/data buffer slots with satisfied size
    wire [BUF_SLOT_ENTRIES-1:0]             slot_buf_granted_header_vld;
    wire [BUF_SLOT_ENTRIES-1:0]             slot_buf_granted_data_vld;

    // assigned header/data packet buffer slots through search
    wire [BUF_ID_WIDTH-1:0]                 assigned_header_pkt_buf_id;
    wire [BUF_ID_WIDTH-1:0]                 assigned_data_pkt_buf_id;
    wire                                    assigned_gnt_buf_success;

    wire                                    header_buf_is_found_out;
    wire                                    data_buf_is_found_out;


    assign assigned_gnt_buf_success = rpu_bu_req_buf_vld & header_buf_is_found_out & data_buf_is_found_out &
                                      (assigned_header_pkt_buf_id != assigned_data_pkt_buf_id);

    assign bu_rpu_gnt_buf_vld       = rpu_bu_req_buf_vld;
    assign bu_rpu_gnt_buf_status    = (~rpu_bu_req_buf_vld | assigned_gnt_buf_success) ?
                                      `RSP_STATUS_OK :
                                      `RSP_STATUS_ERR;
    assign bu_rpu_header_buf_addr   = (bu_rpu_gnt_buf_vld & assigned_gnt_buf_success) ?
                                      buf_slots_addr_q[assigned_header_pkt_buf_id] :
                                      {`NOU_BUF_ADDR_WIDTH{1'b0}};
    assign bu_rpu_data_buf_addr     = (bu_rpu_gnt_buf_vld & assigned_gnt_buf_success) ?
                                      buf_slots_addr_q[assigned_data_pkt_buf_id] :
                                      {`NOU_BUF_ADDR_WIDTH{1'b0}};
    assign bu_rpu_gnt_buf_err_code  = (~rpu_bu_req_buf_vld | assigned_gnt_buf_success) ?
                                      `NOU_ERR_CODE_WIDTH'd0 :
                                      `NOU_ERR_CODE_WIDTH'd1;

    // find a header buffer with forward scan
    find_first_one_index_forward
    #(
        .VECTOR_LENGTH      (BUF_SLOT_ENTRIES),
        .MAX_OUTPUT_WIDTH   (BUF_ID_WIDTH)
    )
    u_find_first_grant_one_index_forward
    (
        .vector_in           (slot_buf_granted_header_vld),
        .first_one_index_out (assigned_header_pkt_buf_id),
        .one_is_found_out    (header_buf_is_found_out)
    );

    // find a data buffer with backward scan
    find_first_one_index_backward
    #(
        .VECTOR_LENGTH      (BUF_SLOT_ENTRIES),
        .MAX_OUTPUT_WIDTH   (BUF_ID_WIDTH)
    )
    u_find_first_grant_one_index_backward
    (
        .vector_in           (slot_buf_granted_data_vld),
        .first_one_index_out (assigned_data_pkt_buf_id),
        .one_is_found_out    (data_buf_is_found_out)
    );

    genvar idx;
    generate
    for (idx = 0; idx < BUF_SLOT_ENTRIES; idx = idx + 1)
    begin
        assign slot_buf_granted_header_vld[idx] = (buf_slots_status_q[idx] == `NOU_BUF_SLOT_STATUS_BUF_GRANTED) &
                                                  (buf_slots_size_q[idx] >= 1); // header size <= 256 B < 1 KB
        assign slot_buf_granted_data_vld[idx]   = (buf_slots_status_q[idx] == `NOU_BUF_SLOT_STATUS_BUF_GRANTED) &
                                                  (buf_slots_size_q[idx] >= rpu_bu_req_buf_data_size);

        // If buffer request granted/assigned for packet and buffer slot is selected, change status to ASSIGNED
        // TODO: add grant buffer write to handle request from XoCC via BURR for full BU functionality
        assign wr_en[idx] = (assigned_gnt_buf_success &
                             (assigned_header_pkt_buf_id == idx | assigned_data_pkt_buf_id == idx));

        assign buf_slots_status_in[idx] = wr_en[idx] ? `NOU_BUF_SLOT_STATUS_PKT_ASSIGNED : `NOU_BUF_SLOT_STATUS_EMPTY;
        assign buf_slots_addr_in[idx]   = wr_en[idx] ? buf_slots_addr_q[idx] : `NOU_BUF_ADDR_WIDTH'b0;
        assign buf_slots_size_in[idx]   = wr_en[idx] ? buf_slots_size_q[idx] : `NOU_BUF_SZ_WIDTH'b0;

        // Add reset buffer slot values for HARDCODED granted buffers
        // For 32-entry buffer slots, the first 16 entries are 2KB small buffers for headers, the last 16 ones are 32KB
        // each for data
        if (idx >= 0 && idx < 16)
        begin
            assign buf_slots_status_rst[idx] = `NOU_BUF_SLOT_STATUS_BUF_GRANTED;
            assign buf_slots_addr_rst[idx]   = `NOU_BUF_ADDR_WIDTH'h500 + idx * 2;
            assign buf_slots_size_rst[idx]   = `NOU_BUF_SZ_WIDTH'd2;
        end
        else if (idx >=16 && idx < 32)
        begin
            assign buf_slots_status_rst[idx] = `NOU_BUF_SLOT_STATUS_BUF_GRANTED;
            assign buf_slots_addr_rst[idx]   = `NOU_BUF_ADDR_WIDTH'h520 + (idx-16)*`NOU_BUF_ADDR_WIDTH'h20;
            assign buf_slots_size_rst[idx]   = `NOU_BUF_SZ_WIDTH'd32;
        end
        else
        begin
            assign buf_slots_status_rst[idx] = `NOU_BUF_SLOT_STATUS_EMPTY;
            assign buf_slots_addr_rst[idx]   = `NOU_BUF_ADDR_WIDTH'd0;
            assign buf_slots_size_rst[idx]   = `NOU_BUF_SZ_WIDTH'd0;
        end
    end
    endgenerate

    // Buffer slots registers
    genvar i;
    generate
    for (i = 0; i < BUF_SLOT_ENTRIES; i = i + 1)
    begin
        bu_buf_slot u_buf_slot(
            .clk(clk),
            .rstn(rstn),

            .rst_buf_status(buf_slots_status_rst[i]),
            .rst_buf_addr(buf_slots_addr_rst[i]),
            .rst_buf_size(buf_slots_size_rst[i]),

            .buf_status(buf_slots_status_in[i]),
            .buf_addr(buf_slots_addr_in[i]),
            .buf_size(buf_slots_size_in[i]),

            .wr_en(wr_en[i]),

            .buf_status_q(buf_slots_status_q[i]),
            .buf_addr_q(buf_slots_addr_q[i]),
            .buf_size_q(buf_slots_size_q[i])
        );
    end
    endgenerate

    // TODO: re-connect wires for fully functional bu, fixed zeros for now
    bu_burr
    u_burr(
        .clk(clk),
        .rstn(rstn),

        .vld(1'b0),
        .retire_keep(retire_burr_keep),
        .sid(brr_bu_sid),
        .rtype(`NOU_RSP_TYPE_ID_WIDTH'd0),
        .buf_id(`NOU_BUF_ID_WIDTH'd0),
        .status(`RSP_STATUS_OK),
        .err_code(`NOU_ERR_CODE_WIDTH'd0),
        .rm(`NOU_BUF_RM_WIDTH'd0),

        .vld_q(burr_retire_vld),
        .sid_q(burr_retire_sid),
        .rtype_q(burr_retire_rsp_type),
        .buf_id_q(burr_retire_buf_id),
        .status_q(burr_retire_status),
        .err_code_q(burr_retire_err_code),
        .rm_q(burr_retire_rm)
    );

endmodule
