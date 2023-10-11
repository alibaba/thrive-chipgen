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

"""
Traverse the dir to find *.v and *.sv files and generate filelist 
for verification purpose

Author: Zhe Zhang
"""

import os
import argparse

DESIGN_TOP = os.environ.get('DESIGN_TOP')

def opt_parse():
    parser = argparse.ArgumentParser()
    parser.add_argument("-d", "--dir", type=str, default=DESIGN_TOP)
    parser.add_argument("-f", "--file", type=str, default="mako_gen.filelist")
    parser.add_argument("--mako", action="store_true", help="generate filelist for mako file generation")
    return parser.parse_args()

class Filelist():
    def __init__(self, path, file_name="thrive_top_wrapper_ASIC.filelist"):
        self.src_path = path
        self.gen_path = ""
        self.v_path = []
        self.sv_path = []
        self.h_path = []
        self.gen_file_name = file_name
        
    def gen(self, is_mako):
        self.find_file()
        self.filelist_gen(is_mako)

    def find_file(self):
        g = os.walk(self.src_path)
        for path, dir_list, file_list in g:
            for file_name in file_list:
                if file_name.endswith(".v"):
                    self.v_path.append(os.path.join(path, file_name))
                if file_name.endswith(".sv"):
                    self.sv_path.append(os.path.join(path, file_name))
                if file_name.endswith(".h"):
                    self.h_path.append(os.path.join(path, file_name))

    def filelist_gen(self, is_mako):
        wf = open(self.gen_path + self.gen_file_name, "w")
        for line in self.v_path + self.sv_path + self.h_path:
            if is_mako:
                # Find Mako Generated Heterogenous Filename, e.g., pe_0_0_*.v, pe_1_0_*.v
                if line.split("/")[-1][:3] == "pe_" and line.split("/")[-1][3] in "0123456789": 
                    wf.write(line + "\n")
                    
            else:
                wf.write(line + "\n")
        wf.close()

def main():
    args = opt_parse()
    filelist = Filelist(path=args.dir,file_name=args.file)
    filelist.gen(args.mako)

if __name__ == "__main__":
    main()