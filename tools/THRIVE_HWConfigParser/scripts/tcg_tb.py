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
Author: Zhe.Zhang
"""

from re import S
from mako.template import Template
from mako.lookup import TemplateLookup
from pe import *
from chip import *
import yaml
import os
import argparse

class RV:
    """
    RV class for mako template
    """
    def __init__(self):
        # rv name
        self.name = ""
        # num of xocc
        self.num_xocc = 0
        # width list of xocc cmd fifo
        self.cmd_width = []
        # width list of xocc rsp fifo
        self.rsp_width = []
    def __str__(self):
        return "RV name: {}\nNum of XoCC: {}\nCmd width: {}\nRsp wdith: {}".format(self.name,self.num_xocc,self.cmd_width,self.rsp_width)

def opt_parse():
    parser = argparse.ArgumentParser()
    parser.add_argument("--tb", action="store_true", help="generate testbench files")
    parser.add_argument("-c", "--config", type=str, default="../configs/2_1_thrive_homo", help="config files")
    parser.add_argument("-p", "--path", type=str, default="../../../dv/tb", help="mako template file path")
    args = parser.parse_args()
    return args

def delete_tmp_file(file_path="../../../design/src_rtl", suffix="v"):
    g = os.walk(file_path)
    for path, dir_list, file_list in g:
        for file_name in file_list:
            if file_name.endswith(".tmp." + suffix):
                try:
                    os.remove(os.path.join(path, file_name))
                except BaseException as e:
                    print(e)

def find_mako_template_path(file_path="../../../design/src_rtl", suffix="v"):
    """
    Traverse the *.mako.* file and return the list
    """
    g = os.walk(file_path)
    mako_paths = []
    for path, dir_list, file_list in g:
        for file_name in file_list:
            # the mako template file suffix could be *.mako.v/vp/h
            if file_name.endswith(".mako." + suffix):
                mako_paths.append(os.path.join(path, file_name))
    return mako_paths

# def gen_verilog_file(file_path, file_type="v", **kargs):
def gen_verilog_file(file_dir, file_name, gen_file_name, **kargs):
    """
    Generate .v/.vp/ files from mako template
    New file location doesn't change
    """
    lookup = TemplateLookup(directories=file_dir, module_directory="./tmp")
    tf = lookup.get_template(file_name)

    wf = open(os.path.join(file_dir, gen_file_name), "w")
    wf.write(tf.render(**kargs))
    wf.close()

class TBGen:
    def __init__(self, path, cfg):
        self.chip = None
        self.pe = []
        self.cfg = cfg
        self.path = path
    
    def parse(self):
        for path, dir_list, file_list in os.walk(self.cfg):
            for file_name in file_list:
                if file_name.startswith("thrive_pe"):
                    pe = PE()
                    pe.parse(os.path.join(path,file_name))
                    self.pe.append(pe)
                if file_name.startswith("thrive_chip"):
                    chip = Chip()
                    chip.parse(os.path.join(path,file_name))
                    self.chip = chip
    
    def gen(self):
        self.parse()

        # get mako template files
        mako_paths = find_mako_template_path(self.path, suffix="h")
        mako_paths.extend(find_mako_template_path(self.path, suffix="sv"))
        print(20*"-", "Mako Template Files", 20*"-")
        for f in mako_paths: print(f) 

        # generate .h for TestBench
        print(20*"-", "Generated Files", 20*"-")
        for f in mako_paths:
            file_dir, file_name = os.path.split(f)
            file_name_prefix = file_name.split(".")[0]
            if file_name_prefix == "tb_define":
                gen_file_name = "{}.h".format(file_name_prefix)
                gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name, chip=self.chip, pes=self.pe)
                print(">>>> ", os.path.join(file_dir, gen_file_name))
            if file_name_prefix in ["tb_printf", "tb_top", "tb_mem_init"]:
                gen_file_name = "{}.sv".format(file_name_prefix)
                gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name, chip=self.chip, pes=self.pe)
                print(">>>> ", os.path.join(file_dir, gen_file_name))
            if "tb_finish" in file_name_prefix:
                gen_file_name = "{}.sv".format(file_name_prefix) 
                gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name, chip=self.chip, pes=self.pe)
                print(">>>> ", os.path.join(file_dir, gen_file_name))

def main():
    args = opt_parse()
    tbgen = TBGen(path=args.path,cfg=args.config)
    if args.tb:
        tbgen.gen()

if __name__ == "__main__":
    main()