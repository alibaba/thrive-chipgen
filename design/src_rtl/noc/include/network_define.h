/*
Copyright (c) 2015 Princeton University
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Princeton University nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY PRINCETON UNIVERSITY "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL PRINCETON UNIVERSITY BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/////////////////////////////////////////////////////////////////////////////////////////////
// 511      96 95    64 63      46 45         40 39       32 31            20 19 10 9   0
// ---------------------------------------------------------------------------------------
// |          |        |          |             |           |                |     |     |
// | Reserved | Pkt ID | Reserved | Header Size | Data Size | Header Payload | src | dst |
// |          |        |          |             |           |                |     |     |
// ---------------------------------------------------------------------------------------
// src / dst struct
// 19      18 17  14 13  10
//  9       8  7   4  3   0
// -------------------------
// |         |      |      |
// | Chip ID | X ID | Y ID |
// |         |      |      |
// -------------------------
////////////////////////////////////////////////////////////////////////////////////////////////
`timescale 1ps/1ps

`ifndef NETWORK_DEFINE_H
`define NETWORK_DEFINE_H

`define    XY_WIDTH 4
`define    CHIP_ID_WIDTH 2 
`define    PAYLOAD_LEN 12 
`define    HALF_DATA_WIDTH 32

`define    OFF_CHIP_NODE_X 0
`define    OFF_CHIP_NODE_Y 0

`define    DATA_WIDTH 522 
`define    RSP_WIDTH 42
`define    TID_WIDTH 8
`define    TYPE_WIDTH 2
`define    DAT_DAT_WIDTH 512
`define    RSP_DAT_WIDTH 32

`define     DAT_BUF_CRED_BITS 6
`define     DAT_BUF_CRED_SIZE 32
`define     RSP_BUF_CRED_BITS 2
`define     RSP_BUF_CRED_SIZE 2
//whether the routing is based on chipid or x y position
//`define    ROUTING_CHIP_ID
`define    ROUTING_XY

//defines for different topology, only one should be active
//`define    NETWORK_TOPO_2D_MESH
//`define    NETWORK_TOPO_3D_MESH
`define    NETWORK_TOPO_XBAR
`endif
