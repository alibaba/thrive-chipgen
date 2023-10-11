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

`include "network_define.h"

module router_intf_top (
	clk,
	rst,

    myLocX,
    myLocY,
    myChipID,
    //	Tile input/output DAT channel signals
	nou_router_data_tid,
	nou_router_data_type,
	nou_router_data,
	nou_router_data_valid,
	router_nou_data_ready,

	router_nou_data_tid,
	router_nou_data_type,
	router_nou_data,
	router_nou_data_valid,
	nou_router_data_ready,

    //	Tile input/output RSP channel signals
	nou_router_rsp_tid,
	nou_router_rsp_type,
	nou_router_rsp_data,
	nou_router_rsp_valid,
	router_nou_rsp_ready,

	router_nou_rsp_tid,
	router_nou_rsp_type,
	router_nou_rsp_data,
	router_nou_rsp_valid,
	nou_router_rsp_ready,

    //	Router W input/output signals
	dat_W_out,
	dat_vld_W_out,
	dat_yummy_W_in,

	dat_W_in,
	dat_vld_W_in,
	dat_yummy_W_out,

	rsp_W_out,
	rsp_vld_W_out,
	rsp_yummy_W_in,

	rsp_W_in,
	rsp_vld_W_in,
	rsp_yummy_W_out,

    //	Router E input/output signals
	dat_E_out,
	dat_vld_E_out,
	dat_yummy_E_in,

	dat_E_in,
	dat_vld_E_in,
	dat_yummy_E_out,

	rsp_E_out,
	rsp_vld_E_out,
	rsp_yummy_E_in,

	rsp_E_in,
	rsp_vld_E_in,
	rsp_yummy_E_out,

    //	Router N input/output signals
	dat_N_out,
	dat_vld_N_out,
	dat_yummy_N_in,

	dat_N_in,
	dat_vld_N_in,
	dat_yummy_N_out,

	rsp_N_out,
	rsp_vld_N_out,
	rsp_yummy_N_in,

	rsp_N_in,
	rsp_vld_N_in,
	rsp_yummy_N_out,

    //	Router S input/output signals
	dat_S_out,
	dat_vld_S_out,
	dat_yummy_S_in,

	dat_S_in,
	dat_vld_S_in,
	dat_yummy_S_out,

	rsp_S_out,
	rsp_vld_S_out,
	rsp_yummy_S_in,

	rsp_S_in,
	rsp_vld_S_in,
	rsp_yummy_S_out
);

    input  clk;
    input  rst;

    input [`XY_WIDTH-1:0] myLocX;		// this tile's position
    input [`XY_WIDTH-1:0] myLocY;
    input [`CHIP_ID_WIDTH-1:0] myChipID;

    // Tile input/output DAT channel signals
    input  [`TID_WIDTH-1:0]        nou_router_data_tid;
    input  [`TYPE_WIDTH-1:0]       nou_router_data_type;
    input  [`DAT_DAT_WIDTH-1:0]    nou_router_data;
    input                          nou_router_data_valid;
    output                         router_nou_data_ready;

    output  [`TID_WIDTH-1:0]       router_nou_data_tid;
    output  [`TYPE_WIDTH-1:0]      router_nou_data_type;
    output  [`DAT_DAT_WIDTH-1:0]   router_nou_data;
    output                         router_nou_data_valid;
    input                          nou_router_data_ready;

    // Tile input/output RSP channel signals
    input  [`TID_WIDTH-1:0]        nou_router_rsp_tid;
    input  [`TYPE_WIDTH-1:0]       nou_router_rsp_type;
    input  [`RSP_DAT_WIDTH-1:0]    nou_router_rsp_data;
    input                          nou_router_rsp_valid;
    output                         router_nou_rsp_ready;

    output  [`TID_WIDTH-1:0]       router_nou_rsp_tid;
    output  [`TYPE_WIDTH-1:0]      router_nou_rsp_type;
    output  [`RSP_DAT_WIDTH-1:0]   router_nou_rsp_data;
    output                         router_nou_rsp_valid;
    input                          nou_router_rsp_ready;

    // Router W input/output signals
    output  [`DATA_WIDTH-1:0] dat_W_out;
    output                    dat_vld_W_out;
    input                   dat_yummy_W_in;

    input  [`DATA_WIDTH-1:0] dat_W_in;
    input                    dat_vld_W_in;
    output                  dat_yummy_W_out;

    output  [`RSP_WIDTH-1:0]  rsp_W_out;
    output                    rsp_vld_W_out;
    input                   rsp_yummy_W_in;

    input  [`RSP_WIDTH-1:0]  rsp_W_in;
    input                    rsp_vld_W_in;
    output                  rsp_yummy_W_out;

    // Router E input/output signals
    output  [`DATA_WIDTH-1:0] dat_E_out;
    output                    dat_vld_E_out;
    input                   dat_yummy_E_in;

    input  [`DATA_WIDTH-1:0] dat_E_in;
    input                    dat_vld_E_in;
    output                  dat_yummy_E_out;

    output  [`RSP_WIDTH-1:0]  rsp_E_out;
    output                    rsp_vld_E_out;
    input                   rsp_yummy_E_in;

    input  [`RSP_WIDTH-1:0]  rsp_E_in;
    input                    rsp_vld_E_in;
    output                  rsp_yummy_E_out;

    // Router N input/output signals
    output  [`DATA_WIDTH-1:0] dat_N_out;
    output                    dat_vld_N_out;
    input                   dat_yummy_N_in;

    input  [`DATA_WIDTH-1:0] dat_N_in;
    input                    dat_vld_N_in;
    output                  dat_yummy_N_out;

    output  [`RSP_WIDTH-1:0]  rsp_N_out;
    output                    rsp_vld_N_out;
    input                   rsp_yummy_N_in;

    input  [`RSP_WIDTH-1:0]  rsp_N_in;
    input                    rsp_vld_N_in;
    output                  rsp_yummy_N_out;

    // Router S input/output signals
    output  [`DATA_WIDTH-1:0] dat_S_out;
    output                    dat_vld_S_out;
    input                   dat_yummy_S_in;

    input  [`DATA_WIDTH-1:0] dat_S_in;
    input                    dat_vld_S_in;
    output                  dat_yummy_S_out;

    output  [`RSP_WIDTH-1:0]  rsp_S_out;
    output                    rsp_vld_S_out;
    input                   rsp_yummy_S_in;

    input  [`RSP_WIDTH-1:0]  rsp_S_in;
    input                    rsp_vld_S_in;
    output                  rsp_yummy_S_out;
    
    wire [`DATA_WIDTH-1:0] dat_in;
    wire                   dat_vld_in;
    wire                   dat_yummy_in;

    wire [`DATA_WIDTH-1:0] dat_out;
    wire                   dat_vld_out;
    wire                   dat_yummy_out;

    wire [`RSP_WIDTH-1:0]  rsp_in;
    wire                   rsp_vld_in;
    wire                   rsp_yummy_in;

    wire [`RSP_WIDTH-1:0]  rsp_out;
    wire                   rsp_vld_out;
    wire                   rsp_yummy_out;
    
    nou_in_interface_unit 
    #(
        .WIDTH(`DATA_WIDTH), 
        .DAT_WIDTH(`DAT_DAT_WIDTH),
        .CRED_BITS(`DAT_BUF_CRED_BITS),
        .CRED_SIZE(`DAT_BUF_CRED_SIZE)
    ) 
    niiu_dat(
        .clk(clk),
        .rst(rst),

        .nou_niiu_tid(nou_router_data_tid),
        .nou_niiu_type(nou_router_data_type),
        .nou_niiu_data(nou_router_data),
        .nou_niiu_valid(nou_router_data_valid),
        .niiu_nou_ready(router_nou_data_ready),

        .niiu_router_data(dat_in),
        .niiu_router_valid(dat_vld_in),
        .router_niiu_yummy(dat_yummy_in)
    );

    nou_in_interface_unit 
    #(
        .WIDTH(`RSP_WIDTH), 
        .DAT_WIDTH(`RSP_DAT_WIDTH),
        .CRED_BITS(`RSP_BUF_CRED_BITS),
        .CRED_SIZE(`RSP_BUF_CRED_SIZE)
    )
    niiu_rsp(
        .clk(clk),
        .rst(rst),

        .nou_niiu_tid(nou_router_rsp_tid),
        .nou_niiu_type(nou_router_rsp_type),
        .nou_niiu_data(nou_router_rsp_data),
        .nou_niiu_valid(nou_router_rsp_valid),
        .niiu_nou_ready(router_nou_rsp_ready),

        .niiu_router_data(rsp_in),
        .niiu_router_valid(rsp_vld_in),
        .router_niiu_yummy(rsp_yummy_in)
    );
    
    nou_out_interface_unit
    #(
        .WIDTH(`DATA_WIDTH), 
        .DAT_WIDTH(`DAT_DAT_WIDTH)
    )
    noiu_dat(
        .clk(clk),
        .rst(rst),

        .noiu_nou_tid(router_nou_data_tid),
        .noiu_nou_type(router_nou_data_type),
        .noiu_nou_data(router_nou_data),
        .noiu_nou_valid(router_nou_data_valid),
        .nou_noiu_ready(nou_router_data_ready),

        .router_noiu_data(dat_out),
        .router_noiu_valid(dat_vld_out),
        .noiu_router_yummy(dat_yummy_out)
    );

    nou_out_interface_unit
    #(
        .WIDTH(`RSP_WIDTH),
        .DAT_WIDTH(`RSP_DAT_WIDTH)
    )
    noiu_rsp(
        .clk(clk),
        .rst(rst),

        .noiu_nou_tid(router_nou_rsp_tid),
        .noiu_nou_type(router_nou_rsp_type),
        .noiu_nou_data(router_nou_rsp_data),
        .noiu_nou_valid(router_nou_rsp_valid),
        .nou_noiu_ready(nou_router_rsp_ready),

        .router_noiu_data(rsp_out),
        .router_noiu_valid(rsp_vld_out),
        .noiu_router_yummy(rsp_yummy_out)
    );

    router_top i_router(
            .clk(clk),
		    .reset_in(rst),
		    .dataIn_N(dat_N_in),
		    .dataIn_E(dat_E_in),
		    .dataIn_S(dat_S_in),
		    .dataIn_W(dat_W_in),
		    .dataIn_P(dat_in),
		    .validIn_N(dat_vld_N_in),
		    .validIn_E(dat_vld_E_in),
		    .validIn_S(dat_vld_S_in),
		    .validIn_W(dat_vld_W_in),
		    .validIn_P(dat_vld_in),
		    .yummyIn_N(dat_yummy_N_in),
		    .yummyIn_E(dat_yummy_E_in),
		    .yummyIn_S(dat_yummy_S_in),
		    .yummyIn_W(dat_yummy_W_in),
		    .yummyIn_P(dat_yummy_out),
		    .myLocX(myLocX),
		    .myLocY(myLocY),
            .myChipID(myChipID),
		    .store_meter_partner_address_X(),
		    .store_meter_partner_address_Y(),
		    .ec_cfg(),
		    .dataOut_N(dat_N_out),
		    .dataOut_E(dat_E_out),
		    .dataOut_S(dat_S_out),
		    .dataOut_W(dat_W_out),
		    .dataOut_P(dat_out),
		    .validOut_N(dat_vld_N_out),
		    .validOut_E(dat_vld_E_out),
		    .validOut_S(dat_vld_S_out),
		    .validOut_W(dat_vld_W_out),
		    .validOut_P(dat_vld_out),
		    .yummyOut_N(dat_yummy_N_out),
		    .yummyOut_E(dat_yummy_E_out),
		    .yummyOut_S(dat_yummy_S_out),
		    .yummyOut_W(dat_yummy_W_out),
		    .yummyOut_P(dat_yummy_in),
		    .thanksIn_P(),
		    .external_interrupt(),
		    .store_meter_ack_partner(),
		    .store_meter_ack_non_partner(),
		    .ec_out(),

		    .rspIn_N(rsp_N_in),
		    .rspIn_E(rsp_E_in),
		    .rspIn_S(rsp_S_in),
		    .rspIn_W(rsp_W_in),
		    .rspIn_P(rsp_in),
		    .validRspIn_N(rsp_vld_N_in),
		    .validRspIn_E(rsp_vld_E_in),
		    .validRspIn_S(rsp_vld_S_in),
		    .validRspIn_W(rsp_vld_W_in),
		    .validRspIn_P(rsp_vld_in),
		    .yummyRspIn_N(rsp_yummy_N_in),
		    .yummyRspIn_E(rsp_yummy_E_in),
		    .yummyRspIn_S(rsp_yummy_S_in),
		    .yummyRspIn_W(rsp_yummy_W_in),
		    .yummyRspIn_P(rsp_yummy_out),
		    .rspOut_N(rsp_N_out),
		    .rspOut_E(rsp_E_out),
		    .rspOut_S(rsp_S_out),
		    .rspOut_W(rsp_W_out),
		    .rspOut_P(rsp_out),
		    .validRspOut_N(rsp_vld_N_out),
		    .validRspOut_E(rsp_vld_E_out),
		    .validRspOut_S(rsp_vld_S_out),
		    .validRspOut_W(rsp_vld_W_out),
		    .validRspOut_P(rsp_vld_out),
		    .yummyRspOut_N(rsp_yummy_N_out),
		    .yummyRspOut_E(rsp_yummy_E_out),
		    .yummyRspOut_S(rsp_yummy_S_out),
		    .yummyRspOut_W(rsp_yummy_W_out),
		    .yummyRspOut_P(rsp_yummy_in),
		    .thanksRspIn_P()
    );
    
endmodule
