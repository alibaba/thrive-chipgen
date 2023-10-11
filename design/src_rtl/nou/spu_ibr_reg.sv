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

module spu_ibr_reg 
(
    input  wire clk,
    input  wire rstn,

    input  wire  ib_rsp_vld,
    input  wire [`NOU_TID_WIDTH-1:0]      ib_rsp_tid,
    input  wire [`NOU_NOC_RSP_WIDTH-1:0]  ib_rsp,

    output wire [`NOU_TID_WIDTH-1:0]      trans_id_q,
    output wire [`NOU_TILE_ID_WIDTH-1:0]  dst_tile_id_q,
    output wire                           rsp_status_q,
    output wire [`NOU_ERR_CODE_WIDTH-1:0] rsp_err_code_q
);

/********** SIGNAL DECLARE **************/
    wire [`NOU_TILE_ID_WIDTH-1:0]      dst_tile_id;
    wire                           rsp_status;
    wire [`NOU_ERR_CODE_WIDTH-1:0] rsp_err_code;

    assign dst_tile_id  = ib_rsp[9:0];
    assign rsp_status   = ib_rsp[10];
    assign rsp_err_code = ib_rsp[15:11];


    dffr #(`NOU_TID_WIDTH) ff_tid(
                              .clk(clk), 
                              .rn(rstn),
                              .g (ib_rsp_vld),
                              .d (ib_rsp_tid[`NOU_TID_WIDTH-1:0]),
                              .q (trans_id_q[`NOU_TID_WIDTH-1:0])
                              );
  
    dffr #(`NOU_TILE_ID_WIDTH) ff_tire_id(
                              .clk(clk),
                              .rn(rstn), 
                              .g(ib_rsp_vld),
                              .d(dst_tile_id),
                              .q(dst_tile_id_q)
                              );

    dffr ff_status(
                  .clk(clk),
                  .rn(rstn), 
                  .g(ib_rsp_vld), 
                  .d(rsp_status), 
                  .q(rsp_status_q)
                  );

    dffr #(`NOU_ERR_CODE_WIDTH) ff_err_code(
                                .clk(clk),
                                .rn(rstn), 
                                .g(ib_rsp_vld),
                                .d(rsp_err_code), 
                                .q(rsp_err_code_q)
                                );

endmodule

