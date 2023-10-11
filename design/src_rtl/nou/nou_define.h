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

`timescale 1ps/1ps

`ifndef NOU_DEFINE_H
`define NOU_DEFINE_H

`define NOU_XOCC_CMD_WIDTH                      64      // xocc command width
`define NOU_TID_WIDTH                           8       // transaction id width
`define NOU_TYPE_WIDTH                          2        // nou noc type width
`define NOU_NOC_DATA_WIDTH                     512       // nou noc data flit width
`define NOU_NOC_RSP_WIDTH                      32      // nou noc response

// Fetch/Decode:
`define NOU_XRQ_PTR_WIDTH                       3       // Num of entries in XRQ = 2^(XRQ_PTR_WIDTH)
`define NOU_UOV_SIZE                            5       // Unit Output Vector == Unit Mask Size
`define REQ_TYPE_GNT_BUF                        4'h0
`define REQ_TYPE_GNT_PKT_WL                     4'h1
`define REQ_TYPE_SND_PKT_RID                    4'h2
`define REQ_TYPE_SND_PKT                        4'h3
`define REQ_TYPE_REL_BUF                        4'h4
`define REQ_TYPE_REL_PKT_WL                     4'h5
`define UNIT_MASK_TO_IRR                        5'b00001
`define UNIT_MASK_TO_BRR                        5'b00010
`define UNIT_MASK_TO_PWRR                       5'b00100
`define UNIT_MASK_TO_SPIDR                      5'b01000
`define UNIT_MASK_TO_SPRR                       5'b10000
// End of Fetch/Decode

`define NOU_AXI_ID_WIDTH                        4
`define NOU_AXI_ADDR_WIDTH                      32
`define NOU_AXI_USER_WIDTH                      1
`define NOU_AXI_DATA_WIDTH                      512
`define NOU_AXI_DATA_BYTE_WIDTH                 64

`define NOU_SID_WIDTH                           9       // NOU Sequence ID
`define NOU_SID_WRAP                            8
`define NOU_SID_NOWRAP                          7:0

`define NOU_PKT_BUF_SIZE_LOG2                   4

`define NOU_PKT_ID_WIDTH                        32      // NOU Packet ID

`define NOU_WL_OP_TYPE_WIDTH                    1       // Whitelist op type width
`define NOU_WL_RM_WIDTH                         2       // NOU whitelist reclaim mode

`define NOU_TILE_ID_WIDTH                      10      // Tile/PE ID

`define NOU_FLIT_SZ_WIDTH                      12     // flit num

`define NOU_PKT_HEADER_ADDR_WIDTH              12     // packet header address, shifted right 10-bit
`define NOU_PKT_HEADER_SZ_WIDTH                8      // packet header size
`define NOU_PKT_DATA_ADDR_WIDTH                12     // packet data address, shifted right 10-bit
`define NOU_PKT_DATA_SZ_WIDTH                   6      // packet data size in KB.
`define NOU_PKT_FLIT_WIDTH                      12

`define NOU_REQ_TYPE_ID_WIDTH                   4      // request type id from XoCC
`define NOU_RSP_TYPE_ID_WIDTH                   4      // response type id to XoCC 
`define NOU_ERR_CODE_WIDTH                      5

`define NOU_BUF_OP_TYPE_WIDTH                   1       // buffer unit op type width
`define NOU_BUF_ID_WIDTH                        8       // NOU Buffer ID width
`define NOU_BUF_ADDR_WIDTH                      12      // NOU buffer address, shifted right 10 bits
`define NOU_BUF_SZ_WIDTH                        6       // NOU buffer size
`define NOU_BUF_RM_WIDTH                        2       // NOU buffer reclaim mode

`define NOU_BUF_SLOT_STATUS_WIDTH               2       // slot status width
`define NOU_BUF_SLOT_STATUS_EMPTY               2'b00   // slot is empty
`define NOU_BUF_SLOT_STATUS_BUF_GRANTED         2'b01   // slot is granted with a buffer
`define NOU_BUF_SLOT_STATUS_PKT_ASSIGNED        2'b10   // buffer in the slot is assigned to a packet

`define RSP_STATUS_OK                           1'b0
`define RSP_STATUS_ERR                          1'b1

`define HEAD_FLIT_TYPE                          2'b00
`define DATA_FLIT_TYPE                          2'b01

//nou response type to XoCC FIFO
`define GNT_BUF_RSP_TYPE                        4'b0000
`define GNT_WL_RSP_TYPE                         4'b0001
`define SNT_PKT_RSP_TYPE                        4'b0010
`define REL_BUF_RSP_TYPE                        4'b0011
`define REL_WL_RSP_TYPE                         4'b0100
`define RCV_PKT_RID_RSP_TYPE                    4'b0101
`define RCV_PKT_RSP_TYPE                        4'b0110
`define INV_REQ_RSP_TYPE                        4'b0111

// nou response err type
`define NO_BUF_AVAILABLE                        5'b10001
`define NO_BUF_BIG_ENOUGH                       5'b10010
`define PKT_NOT_IN_PWL                          5'b10011
`define WRITE_SRAM_ERROR                        5'b10111
`define TIME_OUT_OB_HEAD_RSP                    5'b10100
`define TIME_OUT_OB_DATA_RSP                    5'b10110
`define TIME_OUT_IB_FLIT                        5'b10101
`define TIME_OUT_RCV_PKT                        5'b11000

`define SRAM_BASE_ADDR                          32'h2000000
`endif
