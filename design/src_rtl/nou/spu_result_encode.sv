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

module spu_result_encode
(
    input wire [`NOU_SID_WIDTH-1:0]              sid,
    input wire [`NOU_PKT_ID_WIDTH-1:0]           pkt_id,
    input wire [`NOU_ERR_CODE_WIDTH-1:0]         rsp_err_code,
    
    input wire  pkt_result_ok,
    input wire  pkt_result_err,
    input wire  head_flt_rsp_to,
    input wire  data_flt_rsp_to,
    input wire  trans_id_mismatch, 
    input wire  tile_id_mismatch,

    input wire  snd_head_flt_timeout,
    input wire  snd_data_flt_timeout,
    input wire  read_sram_timeout, 
    input wire  miss_pkt_req, 
    input wire  read_sram_error, 
    input wire  miss_routing_req,

    output wire result_vld,
    output wire [`NOU_SID_WIDTH-1:0]          res_sid,
    output wire [`NOU_RSP_TYPE_ID_WIDTH-1:0]  res_type,
    output wire [`NOU_PKT_ID_WIDTH-1:0]       res_pkt_id,
    output wire                               res_status,
    output wire [`NOU_ERR_CODE_WIDTH-1:0]     res_err_code
);

    wire                            err_vld;
    wire [`NOU_ERR_CODE_WIDTH-1:0]  err_code;

    assign err_vld = head_flt_rsp_to        |
                     data_flt_rsp_to        |
                     trans_id_mismatch      |
                     tile_id_mismatch       |
                     snd_head_flt_timeout   |
                     snd_data_flt_timeout   | 
                     read_sram_timeout      |
                     miss_pkt_req           |
                     read_sram_error        |
                     miss_routing_req ;
    assign err_code = ({`NOU_ERR_CODE_WIDTH{miss_pkt_req}}         & 5'b00001) |
                      ({`NOU_ERR_CODE_WIDTH{miss_routing_req}}     & 5'b00010) |
                      ({`NOU_ERR_CODE_WIDTH{trans_id_mismatch}}    & 5'b00011) |
                      ({`NOU_ERR_CODE_WIDTH{tile_id_mismatch}}     & 5'b00100) |
                      ({`NOU_ERR_CODE_WIDTH{read_sram_error}}      & 5'b00101) |
                      ({`NOU_ERR_CODE_WIDTH{read_sram_timeout}}    & 5'b00110) |
                      ({`NOU_ERR_CODE_WIDTH{snd_head_flt_timeout}} & 5'b00111) |
                      ({`NOU_ERR_CODE_WIDTH{snd_data_flt_timeout}} & 5'b01000) |
                      ({`NOU_ERR_CODE_WIDTH{head_flt_rsp_to}}      & 5'b01001) |
                      ({`NOU_ERR_CODE_WIDTH{data_flt_rsp_to}}      & 5'b01010);


    assign result_vld = pkt_result_ok | pkt_result_err | err_vld;
    assign res_sid = sid;
    assign res_type = `SNT_PKT_RSP_TYPE;
    assign res_pkt_id   = pkt_id;
    assign res_status   = (pkt_result_ok) ? `RSP_STATUS_OK : `RSP_STATUS_ERR;
    assign res_err_code = (pkt_result_ok) ? {`NOU_ERR_CODE_WIDTH{1'b0}} : (pkt_result_err) ? rsp_err_code : err_code ; 

endmodule
