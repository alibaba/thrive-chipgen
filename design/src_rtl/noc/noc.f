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

-sverilog
+incdir+$DESIGN_SRC/noc/include
$DESIGN_SRC/noc/router/router_input_control.v
$DESIGN_SRC/noc/router/router_input_route_request_calc.v
$DESIGN_SRC/noc/router/router_input_top_16.v
$DESIGN_SRC/noc/router/router_input_top_4.v
$DESIGN_SRC/noc/router/router_output_control.v
$DESIGN_SRC/noc/router/router_output_datapath.v
$DESIGN_SRC/noc/router/router_output_top.v
$DESIGN_SRC/noc/router/router_rsp_input_top_16.v
$DESIGN_SRC/noc/router/router_rsp_input_top_4.v
$DESIGN_SRC/noc/router/router_top.v
$DESIGN_SRC/noc/router/network_input_blk_multi_out.v
$DESIGN_SRC/noc/router/space_avail_top.v
$DESIGN_SRC/noc/router/bus_compare_equal.v
$DESIGN_SRC/noc/router/flip_bus.v
$DESIGN_SRC/noc/router/net_dff.v
$DESIGN_SRC/noc/router/one_of_eight.v
$DESIGN_SRC/noc/router/one_of_five.v
$DESIGN_SRC/noc/router_intf_top.v
$DESIGN_SRC/noc/nou_out_interface_unit.sv
$DESIGN_SRC/noc/nou_in_interface_unit.sv
