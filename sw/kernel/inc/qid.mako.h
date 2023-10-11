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

% if chip.type == "homogeneous":
<% pe = pes[0] %>\
    % for ind, rv in enumerate(pe.rvs.dispatcher + pe.rvs.regular):
        % for qid, dat in rv.qid_map.items():
#define RV_${ind}_QID_${qid} ${qid} // rv_${ind} (${rv.name}) to ${dat[1]}
        % endfor
    % endfor
% endif
% if chip.type == "heterogeneous":
    % for pe in pes:
        % for ind, rv in enumerate(pe.rvs.dispatcher + pe.rvs.regular):
            % for qid, dat in rv.qid_map.items():
#define ${pe.name.upper()}_RV_${ind}_QID_${qid} ${qid} // ${pe.name}_rv_${ind} (${rv.name}) to ${dat[1]}
            % endfor
        % endfor

    % endfor
% endif