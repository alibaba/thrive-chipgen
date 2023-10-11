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
module axi_w_master_ctl
(
    input logic [`NOU_NOC_DATA_WIDTH-1:0] data,
    input logic empty,
    output logic rd_en, 

    output logic [`NOU_NOC_DATA_WIDTH-1:0] axi_wdata, 
    output logic axi_wvld,
    input logic axi_wrdy
);
    assign axi_wdata = data;
    assign axi_wvld = ~empty;
    assign rd_en = axi_wrdy;

endmodule
