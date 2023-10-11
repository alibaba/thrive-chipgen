# 
#Copyright (c) 2021, Alibaba Group;
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at

#   http://www.apache.org/licenses/LICENSE-2.0

#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.
#


## TOP path
setenv PRJ_ROOT `pwd`
setenv SW_PATH ${PRJ_ROOT}/sw/
setenv DV_TOP ${PRJ_ROOT}/dv/
setenv FPGA_TOP ${PRJ_ROOT}/fpga/
setenv DESIGN_TOP ${PRJ_ROOT}/design/
setenv DESIGN_SRC ${PRJ_ROOT}/design/src_rtl
setenv DESIGN_GEN ${PRJ_ROOT}/design/gen_rtl
setenv AXI_PATH ${DESIGN_SRC}/xbar/
setenv AXI_COMMON_CELL_PATH ${AXI_PATH}/common_cells
#setenv PYTHONPATH ${PYTHONPATH}:${PRJ_ROOT}/tools
setenv PYTHONPATH ${PRJ_ROOT}/tools

## DV path
setenv TESTCASE_PATH ${PRJ_ROOT}/dv/testcase/
setenv WORKDIR_PATH ${PRJ_ROOT}/dv/workdir/
setenv ASMLIB_PATH ${PRJ_ROOT}/sw/lib/asm_lib/
setenv CLIB_PATH ${PRJ_ROOT}/sw/lib/clib/
setenv SWLIB_PATH ${PRJ_ROOT}/sw/lib/
setenv SW_INCLUDE ${PRJ_ROOT}/sw/kernel/inc/

## gcc toolchain, an example
setenv TOOL_EXTENSION /local/riscv-toolchain/bin

## alias
alias run_case 'python ${DV_TOP}/script/run_case.py'
alias dwk   'cd ${WORKDIR_PATH}; ls -F'
alias dtc   'cd ${TESTCASE_PATH}; ls -F'
alias dtb   'cd ${DV_TOP}/tb/; ls -F'
alias dsc   'cd ${DV_TOP}/script/; ls -F'
alias dfp   'cd ${PRJ_ROOT}/fpga/; ls -F'
alias dtcl  'cd ${FPGA_TOP}/tcl/; ls -F'
alias dip  'cd ${FPGA_TOP}/ip_repo/; ls -F'
alias dprj  'cd ${FPGA_TOP}/prj_dir/; ls -F'
alias drt  'cd ${PRJ_ROOT}/; ls -F'
alias dsw  'cd ${PRJ_ROOT}/sw/; ls -F'
alias dd  'cd ${PRJ_ROOT}/design/; ls -F'
alias dsrc  'cd ${PRJ_ROOT}/design/src_rtl/; ls -F'
alias dgen  'cd ${PRJ_ROOT}/design/gen_rtl/; ls -F'
alias dt    'cd ${PRJ_ROOT}/design/src_rtl/top/; ls -F'
alias t 'unsetenv sg; setenv sg `pwd | perl -pe "if (/\bsrc_rtl\b/) {s/\bsrc_rtl\b/gen_rtl/;} elsif (/\bsrc_diag\b/) {s/\bsrc_diag\b/gen_diag/;} elsif (/\bgen_rtl\b/) {s/\bgen_rtl\b/src_rtl/;} else {s/\bgen_diag\b/src_diag/;}"`; cd $sg; pwd; ls -F'

alias vm 'python3 $PRJ_ROOT/tools/VPy/src/vpy.py -t '
alias vmt 'cd $DESIGN_TOP/src_rtl/top/design_top && vm thrive_top_wrapper' # generate thrive top
alias gen_fl 'cd $PRJ_ROOT/dv/script && python filelist_gen.py --file mako_gen.filelist --mako' # generate filelist for heterogenous RTL
alias run_regression 'dtc && cd regression && python3 thrive_regression.py'
alias rm_h 'cd ${PRJ_ROOT} && rm -f `find ./ -regex ".*pe_[0-9]_[0-9].*\.sv"` && rm -f `find ./ -regex ".*pe_[0-9]_[0-9].*\.v"` && rm -f `find ./ -regex ".*pe_[0-9]_[0-9].*\.vp"` && rm -f `find ./ -regex ".*pe_[0-9]_[0-9].*\.h"` && rm -rf ./dv/testcase/autogen_*'
alias vd 'verdi -ssf top_debug.vf &'

alias repo_clean 'rm_h; cd $PRJ_ROOT/tools/THRIVE_HWConfigParser/scripts && make homo_2_1 && vmt && cd ${PRJ_ROOT} && rm_h'

alias gen_homo_2_1 'rm_h; cd $PRJ_ROOT/tools/THRIVE_HWConfigParser/scripts && make homo_2_1 && vmt && gen_fl && run_case -t autogen_homo_2_1 --opt --update | tee run_homo_2_1.log'
alias gen_homo_2_2 'rm_h; cd $PRJ_ROOT/tools/THRIVE_HWConfigParser/scripts && make homo_2_2 && vmt && gen_fl && run_case -t autogen_homo_2_2 --opt --update -tp 2 2 | tee run_homo_2_2.log'
alias gen_homo_4_4 'rm_h; cd $PRJ_ROOT/tools/THRIVE_HWConfigParser/scripts && make homo_4_4 && vmt && gen_fl && run_case -t autogen_homo_4_4 --opt --update -tp 4 4 | tee run_homo_4_4.log'
alias gen_hetero_tc 'rm_h; cd $PRJ_ROOT/tools/THRIVE_HWConfigParser/scripts && make hetero_tc && vmt && gen_fl && run_case -t autogen_hetero_tc --opt --update -tp 2 2 | tee run_hetero_tc.log'
alias gen_homo_9_9 'rm_h; cd $PRJ_ROOT/tools/THRIVE_HWConfigParser/scripts && make homo_9_9 && vmt && gen_fl && run_case -t autogen_homo_9_9 --opt --update -tp 9 9 | tee run_homo_9_9.log'

setenv LIBPATH_DEPEND "$DESIGN_TOP/src_rtl/cpu     \
                       $DESIGN_SRC/cpu/cpu/rtl   \
                       $DESIGN_SRC/cpu/dtu/rtl      \
                       $DESIGN_SRC/cpu/idu/rtl      \
                       $DESIGN_SRC/cpu/tdt/rtl      \
                       $DESIGN_SRC/cpu/sysmap/rtl    \
                       $DESIGN_SRC/cpu/cpu_ss/system    \
                       $DESIGN_TOP/src_rtl/util     \
                       $DESIGN_TOP/src_rtl/clkgen     \
                       $DESIGN_TOP/src_rtl/rstgen     \
                       $DESIGN_TOP/src_rtl/include     \
                       $DESIGN_TOP/src_rtl/noc     \
                       $DESIGN_TOP/src_rtl/nou     \
                       $DESIGN_TOP/src_rtl/xbar     \
                       $DESIGN_TOP/src_rtl/top/rv_cluster     \
                       $DESIGN_TOP/src_rtl/top/design_top     \
                       $DESIGN_TOP/src_rtl/top/mem_subsys     \
                       $DESIGN_TOP/src_rtl/top/pe_top     \
                       $DESIGN_TOP/src_rtl/top/mem_subsys/axi_uram     \
                        "
## Set EDA Tool Path
### add EDA tool path here####
