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

#!/usr/bin/python3
import os
import argparse

def OptParse():
    parser = argparse.ArgumentParser()
    parser.add_argument('-top', '--top', type=str, default=' ', help='top module')
    parser.add_argument('-f', '--filelist', type=str, default='', help='path of filielist')
    parser.add_argument('--cdc', action="store_true", help='enable CDC check')
    parser.add_argument('--gui', action="store_true", help='run in gui-mode')
    args = parser.parse_args()
    print('==> Options:',args)
    return args

class RunSg():
    
    def __init__(self, args):
        self.args = args

    def argParse(self):
        assert os.path.exists(self.args.filelist), "Specified filelist doesn't exist.({0})".format(self.args.filelist)

    def tclGen(self):
        f = open("sg_shell.tcl", "w+")
        f.write("#sg_shell.tcl\n")
        f.write("\n")
        f.write("#Command option\n")
        f.write("set_option sort yes\n")
        f.write("set_option language_mode mixed\n")
        f.write("set_option enableSV09 yes\n")
        f.write("\n")
        f.write("#Read files\n")
        f.write("read_file -type sourcelist {}\n".format(self.args.filelist))
        f.write("set_option top {0}\n".format(self.args.top))
        f.write("\n")
        f.write("#Lint rtl\n")
        f.write("current_goal lint/lint_rtl -top {0}\n".format(self.args.top))
        f.write("run_goal\n")
        f.write("write_report moresimple > {0}_lint_rtl.rpt\n".format(self.args.top))
        if self.args.cdc:
            f.write("\n")
            f.write("#cdc setup\n")
            f.write("current_goal cdc/cdc_setup_check -top {0}\n".format(self.args.top))
            f.write("run_goal\n")
            f.write("write_report moresimple > {0}_cdc_setup.rpt\n".format(self.args.top))
            f.write("\n")
            f.write("#cdc verify struct\n")
            f.write("current_goal cdc/cdc_verify_struct -top {0}\n".format(self.args.top))
            f.write("run_goal\n")
            f.write("write_report moresimple > {0}_cdc_verify_struct.rpt\n".format(self.args.top))
            f.write("\n")
            f.write("#cdc verify\n")
            f.write("current_goal cdc/cdc_verify -top {0}\n".format(self.args.top))
            f.write("run_goal\n")
            f.write("write_report moresimple > {0}_cdc_verify.rpt\n".format(self.args.top))
            f.write("\n")
            f.write("#rdc verify struct\n")
            f.write("current_goal cdc/cdc_verify_struct -top {0}\n".format(self.args.top))
            f.write("run_goal\n")
            f.write("write_report moresimple > {0}_rdc_verify_struct.rpt\n".format(self.args.top))
        f.write("\n")
        f.write("save_project -force {0}.prj\n".format(self.args.top))
        if not self.args.gui:
            f.write("\n")
            f.write("exit -force\n")
        f.close()

    def runSg(self):
        if self.args.gui:
            os.system("spyglass -tcl sg_shell.tcl &")
        else:
            os.system("sg_shell -tcl sg_shell.tcl &")


if __name__ == "__main__":
    args = OptParse()
    run = RunSg(args)
    run.argParse()
    run.tclGen()
    run.runSg()

