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

module retire_ctl
(
    // Result Register Request
    input  wire                         irur_vld,
    input  wire [`NOU_SID_WIDTH-1:0]    irur_sid,
    input  wire                         burr_vld,
    input  wire [`NOU_SID_WIDTH-1:0]    burr_sid,
    input  wire                         pwur_vld,
    input  wire [`NOU_SID_WIDTH-1:0]    pwur_sid,
    input  wire                         spur_vld,
    input  wire [`NOU_SID_WIDTH-1:0]    spur_sid,
    input  wire                         rpu_rcv_pkt_rsp_vld,

    // Grant receive packet response for Receive Packet Unit
    output wire                         gnt_rcv_pkt_rsp,

    // RV Response FIFO Interface
    input  wire                         rsp_fifo_full,
    output wire                         rsp_fifo_wr_en,

    // Select signal
    output wire [2:0]                   or_sel,

    // Unit Output Signals
    output wire [`NOU_UOV_SIZE-1:0]                   out_unit_vec,

    // Keep signals
    output wire                         irur_keep,
    output wire                         burr_keep,
    output wire                         pwur_keep,
    output wire                         spur_keep
);

    localparam GRANT_IRUR = 3'b000;
    localparam GRANT_BURR = 3'b001;
    localparam GRANT_PWUR = 3'b010;
    localparam GRANT_SPUR = 3'b011;
    localparam GRANT_RPU  = 3'b100;
    localparam GRANT_NONE = 3'b111;

    /********** SIGNAL DECLARE **************/
    wire or0_less_than_or1;
    wire or0_less_than_or2;
    wire or0_less_than_or3;
    wire or1_less_than_or2;
    wire or1_less_than_or3;
    wire or2_less_than_or3;
    wire or0_sel;
    wire or1_sel;
    wire or2_sel;
    wire or3_sel;
    wire or4_sel;

    // Prioritize output request based on SID, the smaller, the higher priority
    assign or0_less_than_or1 = irur_sid[`NOU_SID_WIDTH-1:0] < burr_sid[`NOU_SID_WIDTH-1:0];
    assign or0_less_than_or2 = irur_sid[`NOU_SID_WIDTH-1:0] < pwur_sid[`NOU_SID_WIDTH-1:0];
    assign or0_less_than_or3 = irur_sid[`NOU_SID_WIDTH-1:0] < spur_sid[`NOU_SID_WIDTH-1:0];
    assign or1_less_than_or2 = burr_sid[`NOU_SID_WIDTH-1:0] < pwur_sid[`NOU_SID_WIDTH-1:0];
    assign or1_less_than_or3 = burr_sid[`NOU_SID_WIDTH-1:0] < spur_sid[`NOU_SID_WIDTH-1:0];
    assign or2_less_than_or3 = pwur_sid[`NOU_SID_WIDTH-1:0] < spur_sid[`NOU_SID_WIDTH-1:0];

    // If any other output is invalid, no need to compare SID
    assign or4_sel = ~rsp_fifo_full & rpu_rcv_pkt_rsp_vld;
    assign or0_sel = ~rsp_fifo_full & irur_vld & ~or4_sel &
                     (~burr_vld | or0_less_than_or1) &
                     (~pwur_vld | or0_less_than_or2) &
                     (~spur_vld | or0_less_than_or3);
    assign or1_sel = ~rsp_fifo_full & burr_vld & ~or4_sel &
                     (~irur_vld | ~or0_less_than_or1) &
                     (~pwur_vld |  or1_less_than_or2) &
                     (~spur_vld |  or1_less_than_or3);
    assign or2_sel = ~rsp_fifo_full & pwur_vld & ~or4_sel &
                     (~irur_vld | ~or0_less_than_or2) &
                     (~burr_vld | ~or1_less_than_or2) &
                     (~spur_vld |  or2_less_than_or3);
    assign or3_sel = ~rsp_fifo_full & spur_vld & ~or4_sel &
                     (~irur_vld | ~or0_less_than_or3) &
                     (~burr_vld | ~or1_less_than_or3) &
                     (~pwur_vld | ~or2_less_than_or3);

    assign or_sel[2:0] = or4_sel ? GRANT_RPU : (or0_sel ? GRANT_IRUR : (or1_sel ? GRANT_BURR : (or2_sel ? GRANT_PWUR : (or3_sel ? GRANT_SPUR : GRANT_NONE))));
    assign out_unit_vec[4:0] = or0_sel ? 5'b00001 : (or1_sel ? 5'b00010 : (or2_sel ? 5'b00100 : (or3_sel ? 5'b11000 : 5'b00000)));

    assign gnt_rcv_pkt_rsp = or4_sel;
    assign rsp_fifo_wr_en = ~rsp_fifo_full & (irur_vld | burr_vld | pwur_vld | spur_vld | rpu_rcv_pkt_rsp_vld);

    assign irur_keep = ~or0_sel & irur_vld;
    assign burr_keep = ~or1_sel & burr_vld;
    assign pwur_keep = ~or2_sel & pwur_vld;
    assign spur_keep = ~or3_sel & spur_vld;

endmodule
