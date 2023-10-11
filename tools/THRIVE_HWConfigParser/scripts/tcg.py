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
    parser.add_argument("--rm", action="store_true", help="delete generated mako files")
    parser.add_argument("--rv", action="store_true", help="generate rv files")
    parser.add_argument("--rvc", action="store_true", help="generate rvc vp files")
    parser.add_argument("--xbar", action="store_true", help="generate xbar vp files")
    parser.add_argument("--pe", action="store_true", help="generate rvc vp files")
    parser.add_argument("--chip", action="store_true", help="generate rvc vp files")
    parser.add_argument("-c", "--config", type=str, default="../configs/thrive_pe.yaml", help="config files")
    parser.add_argument("-p", "--path", type=str, default="../../../design/src_rtl", help="mako template file path")
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

class RVGen:
    def __init__(self, path, cfg):
        self.rv = []
        self.cfg = cfg
        self.path = path

        if os.path.isfile(self.cfg):
            self.type = "homo"
        elif os.path.isdir(self.cfg):
            self.type = "hetero"
    
    def parse(self):
        if self.type == "homo":
        # PE is homogeneous, all PE use same RV configuration
            self._parse_rv(self.cfg)
        elif self.type == "hetero":
        # PE is heterogeneous, PE use different RV configuration
            for path, dir_list, file_list in os.walk(self.cfg):
                for file_name in file_list:
                    if file_name.startswith("thrive_pe_"):
                        self._parse_rv(os.path.join(path,file_name))
    
    def _parse_rv(self, file_name):
        pe = PE()
        pe.parse(file_name)
        for rv in pe.rvs.dispatcher + pe.rvs.regular:
            _rv = RV()
            _rv.name = rv.name
            for _link in rv.link:
                if _link.type == "xocc":
                    _rv.num_xocc += 1
                    _rv.cmd_width.append(_link.width[0])
                    _rv.rsp_width.append(_link.width[1])
            self.rv.append(_rv) 

    def gen(self):
        # to get rv list
        self.parse() 

        # get mako template files
        mako_paths = find_mako_template_path(self.path) # [TODO] rv type
        print(20*"-", "Mako Template Files", 20*"-")
        for f in mako_paths: print(f) 

        # generate rv files for each rv
        for rv in self.rv:
            for f in mako_paths:
                # get rv name and rename the file name
                file_dir, file_name = os.path.split(f)
                file_name_prefix = file_name.split(".")[0]
                gen_file_name = "{}_{}.v".format(rv.name, file_name_prefix)
                # generate file
                gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name, rv=rv)
                print(">>>> ", os.path.join(file_dir, gen_file_name))

class RVCGen:
    def __init__(self, path, cfg):
        self.rvc = []
        self.cfg = cfg
        self.path = path

        if os.path.isfile(self.cfg):
            self.type = "homo"
        elif os.path.isdir(self.cfg):
            self.type = "hetero"

    def parse(self):
        if self.type == "homo":
        # PE is homogeneous, all PE use same PE configuration
            pe = PE()
            pe.parse(self.cfg)
            self.rvc.append(pe.rvs)
        elif self.type == "hetero":
        # PE is heterogeneous, PE use different RV configuration
            for path, dir_list, file_list in os.walk(self.cfg):
                for file_name in file_list:
                    if file_name.startswith("thrive_pe_"):
                        pe = PE()
                        pe.parse(os.path.join(path,file_name))
                        self.rvc.append(pe.rvs)

    def gen(self):
        self.parse()

        # get mako template files
        mako_paths = find_mako_template_path(self.path, suffix="vp")
        print(20*"-", "Mako Template Files", 20*"-")
        for f in mako_paths: print(f) 

        # generate .vp for rv cluster
        print(20*"-", "Generated Files", 20*"-")
        for f in mako_paths:
            # get name and rename the file name
            file_dir, file_name = os.path.split(f)
            file_name_prefix = file_name.split(".")[0]
            gen_file_name = "{}.vp".format(file_name_prefix)
            if file_name_prefix == "rv_cluster_top": # for rv_cluster
                if self.type == "homo":
                    gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name, rvc=self.rvc[0])
                    print(">>>> ", os.path.join(file_dir, gen_file_name))
                elif self.type == "hetero":
                    for rvc in self.rvc:
                        gen_file_name_hetero = "{}_{}".format(rvc.name,gen_file_name)
                        gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name_hetero, rvc=rvc)
                        print(">>>> ", os.path.join(file_dir, gen_file_name_hetero))

class PEGen:
    def __init__(self, path, cfg):
        self.dsas = None
        self.mem_ss = None
        self.noc = None
        self.xbar = None
        self.rvc = None
        self.cfg = cfg
        self.path = path
        self.pe = None

        if os.path.isfile(self.cfg):
            self.type = "homo"
        elif os.path.isdir(self.cfg):
            self.type = "hetero"

    def parse(self):
        if self.type == "homo":
        # PE is homogeneous, all PE use same PE configuration
            self.pe = PE()
            self.pe.parse(self.cfg)
            self.dsas = self.pe.dsas
            self.rvc = self.pe.rvs
            self.xbar = self.pe.xbar
        elif self.type == "hetero":
        # PE is heterogeneous, PE use different RV configuration
            self.pe = []
            self.rvc = []
            self.xbar = []
            for path, dir_list, file_list in os.walk(self.cfg):
                for file_name in file_list:
                    if file_name.startswith("thrive_pe_"):
                        pe = PE()
                        pe.parse(os.path.join(path,file_name))
                        self.dsas = pe.dsas
                        self.pe.append(pe)
                        self.rvc.append(pe.rvs)
                        self.xbar.append(pe.xbar)

    def gen(self):
        self.parse()
        # get mako template files
        mako_paths = find_mako_template_path(self.path, suffix="vp")
        mako_paths.extend(find_mako_template_path(self.path, suffix="v"))
        print(20*"-", "Mako Template Files", 20*"-")
        for f in mako_paths: print(f) 

        # generate .vp for PE Top
        print(20*"-", "Generated Files", 20*"-")
        for f in mako_paths:
            # get name and rename the file name
            file_dir, file_name = os.path.split(f)
            file_name_prefix = file_name.split(".")[0]
            if file_name_prefix == "pe_top":
                gen_file_name = "{}.vp".format(file_name_prefix)
                if self.type == "homo":
                    gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name, rvc=self.rvc, dsas=self.dsas, xbar=self.xbar)
                    print(">>>> ", os.path.join(file_dir, gen_file_name))
                elif self.type == "hetero":
                    for pe in self.pe:
                        gen_file_name_hetero = "{}_{}".format(pe.prefix,gen_file_name)
                        gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name_hetero, rvc=pe.rvs, dsas=pe.dsas, xbar=pe.xbar)
                        print(">>>> ", os.path.join(file_dir, gen_file_name_hetero))
            if file_name_prefix == "axi_csr":
                gen_file_name = "{}.v".format(file_name_prefix)
                if self.type == "homo":
                    gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name, rvc=self.rvc, dsas=self.dsas, xbar=self.xbar)
                    print(">>>> ", os.path.join(file_dir, gen_file_name))
                elif self.type == "hetero":
                    for pe in self.pe:
                        gen_file_name_hetero = "{}_{}".format(pe.prefix,gen_file_name)
                        gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name_hetero, rvc=pe.rvs, dsas=pe.dsas, xbar=pe.xbar)
                        print(">>>> ", os.path.join(file_dir, gen_file_name_hetero))
            if file_name_prefix == "pe_rstgen":
                gen_file_name = "{}.vp".format(file_name_prefix)
                if self.type == "homo":
                    gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name, rvc=self.rvc, dsas=self.dsas, xbar=self.xbar)
                    print(">>>> ", os.path.join(file_dir, gen_file_name))
                elif self.type == "hetero":
                    for pe in self.pe:
                        gen_file_name_hetero = "{}_{}".format(pe.prefix,gen_file_name)
                        gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name_hetero, rvc=pe.rvs, dsas=pe.dsas, xbar=pe.xbar)
                        print(">>>> ", os.path.join(file_dir, gen_file_name_hetero))
            if file_name_prefix == "pe_clkgen":
                gen_file_name = "{}.v".format(file_name_prefix)
                if self.type == "homo":
                    gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name, rvc=self.rvc, dsas=self.dsas, xbar=self.xbar)
                    print(">>>> ", os.path.join(file_dir, gen_file_name))
                elif self.type == "hetero":
                    for pe in self.pe:
                        gen_file_name_hetero = "{}_{}".format(pe.prefix,gen_file_name)
                        gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name_hetero, rvc=pe.rvs, dsas=pe.dsas, xbar=pe.xbar)
                        print(">>>> ", os.path.join(file_dir, gen_file_name_hetero))

class ChipGen:
    def __init__(self, path, cfg):
        self.chip = None
        self.path = path
        self.cfg = cfg

    def parse(self):
        self.chip = Chip()
        self.chip.parse(self.cfg)
        cfg_dir,cfg_file = os.path.split(self.cfg)
        if self.chip.type == "homogeneous":
            pe_cfg = os.path.join(cfg_dir, "thrive_pe.yaml")
        else:
            pe_cfg = cfg_dir
        self.pes = PEGen(self.path, pe_cfg)

    def gen(self):
        self.parse()
        self.pes.parse()
        mako_paths = find_mako_template_path(self.path, suffix="vp")
        mako_paths.extend(find_mako_template_path(self.path, suffix="v"))
        mako_paths.extend(find_mako_template_path(self.path, suffix="sv"))
        print(20*"-", "Mako Template Files", 20*"-")
        for f in mako_paths: print(f) 
        # generate .vp for rv cluster
        print(20*"-", "Generated Files", 20*"-")
        for f in mako_paths:
            # get name and rename the file name
            file_dir, file_name = os.path.split(f)
            file_name_prefix = file_name.split(".")[0]
            if file_name_prefix in ["pe_array_top", "thrive_top_wrapper"]:
                gen_file_name = "{}.vp".format(file_name_prefix)
                gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name, chip=self.chip)
                print(">>>> ", os.path.join(file_dir, gen_file_name))
            if file_name_prefix in ["sys_reg"]:
                gen_file_name = "{}.v".format(file_name_prefix)
                gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name, chip=self.chip, pes=self.pes)
                print(">>>> ", os.path.join(file_dir, gen_file_name))
            if file_name_prefix in ["shell_xbar_top"]:
                gen_file_name = "{}.sv".format(file_name_prefix)
                gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name, chip=self.chip)
                print(">>>> ", os.path.join(file_dir, gen_file_name))

class XBarGen:
    def __init__(self, path, cfg):
        self.chip = None
        self.path = path
        self.cfg = cfg
        self.pe = None
        self.xbar = None

        if os.path.isfile(self.cfg):
            self.type = "homo"
        elif os.path.isdir(self.cfg):
            self.type = "hetero"

    def parse(self):
        if self.type == "homo":
        # PE is homogeneous, all PE use same PE configuration
            self.pe = PE()
            self.pe.parse(self.cfg)
            self.xbar = self.pe.xbar
        elif self.type == "hetero":
        # PE is heterogeneous, PE use different RV configuration
            self.xbar = []
            self.pe = []
            for path, dir_list, file_list in os.walk(self.cfg):
                for file_name in file_list:
                    if file_name.startswith("thrive_pe_"):
                        pe = PE()
                        pe.parse(os.path.join(path,file_name))
                        self.pe.append(pe)
                        self.xbar.append(pe.xbar)

    def gen(self):
        self.parse()
        mako_paths = find_mako_template_path(self.path, suffix="v")
        mako_paths.extend(find_mako_template_path(self.path, suffix="sv"))
        print(20*"-", "Mako Template Files", 20*"-")
        for f in mako_paths: print(f) 

        print(20*"-", "Generated Files", 20*"-")
        for f in mako_paths:
            # get name and rename the file name
            file_dir, file_name = os.path.split(f)
            file_name_prefix = file_name.split(".")[0]
            if file_name_prefix in ["xbar_top_wrapper", "xbar_top"]:
                if file_name_prefix == "xbar_top_wrapper": 
                    gen_file_name = "{}.v".format(file_name_prefix)
                if file_name_prefix == "xbar_top": 
                    gen_file_name = "{}.sv".format(file_name_prefix) 
                if self.type == "homo":
                    gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name, xbar=self.xbar, mem_ss=self.pe.mem_ss)
                    print(">>>> ", os.path.join(file_dir, gen_file_name))
                elif self.type == "hetero":
                    for pe in self.pe:
                        gen_file_name_hetero = "{}_{}".format(pe.prefix,gen_file_name)
                        gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name_hetero, xbar=pe.xbar, mem_ss=pe.mem_ss)
                        print(">>>> ", os.path.join(file_dir, gen_file_name_hetero))

def main():
    args = opt_parse()
    rvgen = RVGen(path=args.path,cfg=args.config)
    rvcgen = RVCGen(path=args.path,cfg=args.config)
    pegen = PEGen(path=args.path,cfg=args.config)
    chipgen = ChipGen(path=args.path,cfg=args.config)
    xbargen = XBarGen(path=args.path,cfg=args.config)
    if args.rm:
        delete_tmp_file(file_path=args.path, suffix="v")
        delete_tmp_file(file_path=args.path, suffix="vp")
    if args.rv:
        rvgen.gen()
    if args.rvc:
        rvcgen.gen()
    if args.xbar:
        xbargen.gen()
    if args.pe:
        pegen.gen()
    if args.chip:
        chipgen.gen()

if __name__ == "__main__":
    main()
