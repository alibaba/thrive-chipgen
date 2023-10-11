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

#! /usr/bin/python3

# ****************************************************************************
#FILE NAME       : run_case
#AUTHOR          : Linyong Huang
#FUNCTION        : Top DV simulation
#Version	 : v0.1, 2022.4.27
#****************************************************************************** 

import os
import sys
import shutil
import argparse
import logging
import time
import subprocess

from util import PrintUtils

#===============================================================================
# Some environment variables used in script  
#===============================================================================
TESTCASE_PATH           = os.environ.get('TESTCASE_PATH')
WORKDIR_PATH            = os.environ.get('WORKDIR_PATH')
SWLIB_PATH              = os.environ.get('SWLIB_PATH')
ASMLIB_PATH             = os.environ.get('ASMLIB_PATH')
CLIB_PATH               = os.environ.get('CLIB_PATH')
SW_INCLUDE              = os.environ.get('SW_INCLUDE')
DV_TOP                  = os.environ.get('DV_TOP')
PRJ_ROOT                = os.environ.get('PRJ_ROOT')


#===============================================================================
# Parse arguments  
#===============================================================================
p = PrintUtils()

def OptParse():
    parser = argparse.ArgumentParser()
    parser.add_argument('-t', '--test', type=str, default=' ', help='testcase name')
    parser.add_argument('-s', '--sfx', type=str, default='0', help='suffix of case workdir')
    parser.add_argument('-tp', '--topology', type=int, nargs="+", default=[2,2], help='PE mesh topology')
    parser.add_argument('-nc', '--no_comp_c', action='store_true', help='no need to compile c/asm files')
    parser.add_argument('-nr', '--no_comp_rtl', action='store_true', help='no need to compile RTL')
    parser.add_argument('-ns', '--nosim', action='store_true', help='no need to run simv')
    parser.add_argument('--opt', action='store_true', help='optimize simulation speed, compile RTL only once')
    parser.add_argument('--update', action='store_true', help='update default workdir if needed')
    parser.add_argument('--nodump', action='store_true', help='no need to dump fsdb/vcd')
    parser.add_argument('--cov', action='store_true', help='coverage collection')
    parser.add_argument('-k', '--kpold', action='store_true', help='keep the old workdir for this case and create a new workdir for current run')
    parser.add_argument('-v', '--verilog', action='store_true', help='run verilog testcase')
    args = parser.parse_args()
    print('==> Options:',args)
    return args

class RunCase():
    
    def __init__(self, args):
        self.args = args

    def argsdefine(self):
        pass

    def parse_testcase(self):
        if self.args.verilog:
            pass
        else:
            if self.args.test == " ":
                p.printRed("ERROR: No testcase specified!!!\n")
                sys.exit()

            self.case_path = TESTCASE_PATH + self.args.test
            if not os.path.exists(self.case_path):
                p.printRed("ERROR: Testcase "+self.args.test+" does not exist!!!\n")
                sys.exit()
            else:
                p.printYellow('Running testcase '+self.args.test+'...\n')

    def parse_pe_topo(self):
        self.topology = self.args.topology
        self.pe_table = {}
        for x in range(self.topology[0]):
            for y in range(self.topology[1]):
                if os.path.exists(os.path.join(self.case_path, 'pe_%s_%s')%(x,y)):
                    self.pe_table['pe_%s_%s'%(x,y)] = True
                else:
                    self.pe_table['pe_%s_%s'%(x,y)] = False
        #print(self.pe_table)

    #Generate workdir to run simulation.
    def set_workdir(self):
        self.workdir = os.path.join(WORKDIR_PATH, 'd_%s_%s')%(self.args.test, self.args.sfx)
        self.parse_pe_topo()

        if not os.path.exists(self.workdir):	#workdir does not exist, create one
            os.mkdir(self.workdir)
            for i in range(self.topology[0]):
                for j in range(self.topology[1]):
                    os.mkdir(os.path.join(self.workdir, 'pe_%s_%s')%(i,j))
        elif self.args.kpold:	#keep the old workdir, create a new one with time tag
            time_tag = time.strftime('%M%S', time.localtime(time.time()))
            self.workdir = '%s_%s'%(self.workdir, time_tag)
            if not os.path.exists(self.workdir):
                os.mkdir(self.workdir)
            for i in range(self.topology[0]):
                for j in range(self.topology[1]):
                    os.mkdir(os.path.join(self.workdir, 'pe_%s_%s')%(i,j))
        else:
            if not self.args.no_comp_rtl:
                os.system('rm -rf ' + self.workdir+'/tb_simv*')
            if not self.args.no_comp_c:
                os.system('rm -rf ' + self.workdir+'/*.mem')

        if self.args.opt:
            self.default_dir = os.path.join(WORKDIR_PATH, 'default_workdir')
            if not os.path.exists(self.default_dir):
                os.mkdir(self.default_dir)
            if self.args.update:
                os.system("rm -rf "+self.default_dir+"/*")
        #print(self.workdir)

    def add_pe_template(self, pe_workdir):
        os.chdir(pe_workdir)
        template = open("rv_0.c", 'w+')
        template.write("#include \"func.h\"\n")
        template.write("\n")
        template.write("int main(){\n")
        template.write("\tfinish(PASS);\n")
        template.write("\treturn 0;\n")
        template.write("}\n")
        template.close()

    def subprocess_popen(self, statement):
        ps = subprocess.Popen(statement, shell=True, stdout=subprocess.PIPE)
        while ps.poll() is None:  
            if ps.wait() != 0:  
                p.printRed("Execution of command: {0} FAILED!".format(statement))
                sys.exit(1)
                return False
            else:
                return True

    def sw_compile(self):
        p.printYellow("\n==========================Current Task: compile asm and c files==============================\n")
        for x in range(self.topology[0]):
            for y in range(self.topology[1]):
                pe_workdir = os.path.join(self.workdir, "pe_%s_%s")%(x,y)
                pe_casedir = os.path.join(self.case_path, "pe_%s_%s")%(x,y)
                if self.pe_table['pe_%s_%s'%(x,y)]:
                    os.system('cp -r '+pe_casedir+'/* '+pe_workdir)  #copy all files in case dir to workdir
                else:
                    self.add_pe_template(pe_workdir)
                self.pe_comp(pe_casedir, pe_workdir)

    def pe_comp(self, case_dir, comp_dir):
        self.case_compl(case_dir, comp_dir)
        self.mem_file_gen(comp_dir)

    def case_compl(self, case_dir, comp_dir):
        os.system("cp "+SWLIB_PATH+"/*.lcf "+comp_dir)
        os.system("cp "+SWLIB_PATH+"/Makefile "+comp_dir)
        os.system("cp "+SWLIB_PATH+"/Srec2vmem "+comp_dir)
        os.system("cp "+ASMLIB_PATH+"/* "+comp_dir)
        os.system("cp "+CLIB_PATH+"/* "+comp_dir)
        os.chdir(comp_dir)

        for i in range(4):
            rv_file = "rv_"+str(i)
            lcf_file = "rv_"+str(i)+"_linker"
            rv_file_path = os.path.join(comp_dir, rv_file+".c")
            if os.path.exists(rv_file_path):
                make_cmd = "make -s all"+\
                            " CPU_ARCH_FLAG_0=e906f"+\
                            " CPU_ARCH_FLAG_1=nodsp"+\
                            " ENDIAN_MODE=little-endian"+\
                            " ASMINC="+ASMLIB_PATH+\
                            " CINC="+CLIB_PATH+\
                            " SW_INCLUDE="+SW_INCLUDE+\
                            " LINKFILE="+lcf_file+\
                            " FILE="+rv_file

                p.printYellow("Compiling regular rv"+str(i)+".c, make cmd: "+make_cmd+"\n")
                
                self.subprocess_popen(make_cmd)
        
    def mem_file_gen(self, comp_dir):
        os.system("cp "+DV_TOP+"/script/mem_gen.py "+comp_dir)
        os.chdir(comp_dir)
        # os.system("chmod 755 mem_gen.py")

        for i in range(4):
            pat_filename = "rv_%s"%(i)
            #print(pat_filename)
            if os.path.exists(os.path.join(comp_dir, pat_filename+".pat")):
                os.system("python3 mem_gen.py -et -dwt -f "+pat_filename)

        if os.path.exists(comp_dir+"/datagen.py"):
            os.system("python datagen.py")

        for i in range(4):
            pat_filename = "rv_%s"%(i)
            mem_file = "mem_%s_init.mem"%(i)
            if os.path.exists(os.path.join(comp_dir, pat_filename+".mem")):
                shutil.copy(pat_filename+".mem", comp_dir+"_"+mem_file)
        
    def rtl_compile(self):
        if self.args.opt:
            os.chdir(self.default_dir)
            if (not os.path.exists(self.default_dir+"/tb_simv") or self.args.update):
                p.printYellow("\n==========================Compiling verilog files ==============================\n")
                self.sim_sh(self.default_dir)
                os.system(self.vlog_cmd)
                os.system(self.elab_cmd)

            if not self.args.no_comp_rtl:
                os.system("cp -r "+self.default_dir+"/tb_simv "+self.workdir)
                os.system("cp -r "+self.default_dir+"/tb_simv.daidir "+self.workdir)
                os.system("cp -r "+self.default_dir+"/64 "+self.workdir)
                os.system("cp -r "+self.default_dir+"/csrc "+self.workdir)
                os.system("cp -r "+self.default_dir+"/vcs_lib "+self.workdir)
        else:
            os.chdir(self.workdir)
            if not self.args.no_comp_rtl:
                p.printYellow("\n==========================Compiling verilog files ==============================\n")
                self.sim_sh(self.workdir)
                os.system(self.vlog_cmd)
                os.system(self.elab_cmd)

    def sim_sh(self,workdir):
        shutil.copy(DV_TOP+"/script/synopsys_sim.setup", workdir)
        shutil.copy(DV_TOP+"/script/cm_hier.list", workdir)
        shutil.copy(DV_TOP+"/tb/tb.f", workdir)

        vlog_args = ""
        elab_args = ""
        #--------------vlogan---------------------
        vlog_args += "-full64"
        vlog_args += " -work xil_defaultlib"
        vlog_args += " -lca"
        vlog_args += " -sverilog"
        vlog_args += " +v2k"
        vlog_args += " -assert svaext"
        vlog_args += " -l compile.log"
        #vlog_args += " -timescale=1ps/1ps"
        #vlog_args += " -ntb_opts uvm"
        #vlog_args += " +define+UVM_NO_DEPRECATED+UVM_OBJECT_MUST_HAVE_CONSTRUCTO"
        vlog_args += " +define+VCS"
        vlog_args += " -kdb"
        vlog_args += " -debug_access"

        if self.args.nodump:
            vlog_args += " +define+NO_DUMP"

        vlog_filelist = " -f tb.f"

        self.vlog_cmd = "vlogan "+vlog_args+" "+vlog_filelist+" | tee vlogan.log"

        #---------------elaboration---------------------
        elab_args += " xil_defaultlib.tb_top"
        elab_args += " -full64"
        elab_args += " -o tb_simv"
        elab_args += " -licqueue"
        elab_args += " -l elaborate.log"
        elab_args += " +lint=TFIPC-L"
        elab_args += " -P /tools/synopsys/verdi/P-2019.06-SP2/share/PLI/VCS/linux64/novas.tab /tools/synopsys/verdi/P-2019.06-SP2/share/PLI/VCS/linux64/pli.a"
        if self.args.cov:
            elab_args += " -cm cond+fsm+tgl+branch+line"
            elab_args += " -cm_hier cm_hier.list"
            elab_args += " -cm_dir tb_simv"
            
        self.elab_cmd = "vcs "+elab_args
        
        #print("vlog_cmd: "+self.vlog_cmd)
        #print("elab_cmd: "+self.elab_cmd)

    def rtl_run(self):
        os.chdir(self.workdir)
        p.printYellow("Run vcs simulation...")
        #---------------simv---------------------
        simv_args  = " -l simulate.log"
        simv_args += " +UVM_VERBOSITY=UVM_LOW"
        if self.args.cov:
            simv_args += " -cm cond+fsm+tgl+branch+line"
            simv_args += " -cm_dir tb_simv"
        self.simv_cmd  = "./tb_simv "+simv_args
        #print("simv_cmd: "+self.simv_cmd)

        os.system(self.simv_cmd)

    def rtl_sim(self):
        if not self.args.no_comp_rtl:
            self.rtl_compile()
        if not self.args.nosim:
            self.rtl_run()

    def run(self):
        self.argsdefine()
        self.parse_testcase()
        self.set_workdir()
        if not self.args.no_comp_c:
            self.sw_compile()
        self.rtl_sim()

if __name__ == "__main__":
    args = OptParse()
    runcase = RunCase(args)
    runcase.run()
