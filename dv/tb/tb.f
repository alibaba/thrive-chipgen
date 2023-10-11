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

+incdir+$DV_TOP/tb/
-sverilog
$DV_TOP/tb/tb_top.sv
-f $DESIGN_SRC/src.f
-f $DESIGN_SRC/top/design_top/vp.f
-f $DESIGN_SRC/../../dv/script/mako_gen.filelist
