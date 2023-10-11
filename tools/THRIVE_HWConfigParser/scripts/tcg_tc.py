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
import random
import shutil

if os.environ.get('TESTCASE_PATH'): 
    TESTCASE_PATH = os.environ.get('TESTCASE_PATH')
else:
    TESTCASE_PATH = "../../../dv/testcase/"

# Self-define Testcase, this is an example of "homo_2_2_smoke_test_2"
TC = {
    "pe_0_0": {
        "SND_PKT_ID": "0x{:08X}".format(11111111),
        "RCV_PKT_ID": "0x{:08X}".format(44444444),
        "LOCAL_PE_ID": "0x0{:01X}{:01X}".format(0, 0),
        "SND_PE_ID": "0x0{:01X}{:01X}".format(1, 0),
        "RCV_PE_ID": "0x0{:01X}{:01X}".format(0, 1),
        "rv_0_xocc_cmd_width": 64,
        "rv_0_xocc_rsp_width": 64,
        "rv_0_nou_qid": 4,
        "snd_seed": 0,
        "rcv_seed": 3
    },
    "pe_1_0": {
        "SND_PKT_ID": "0x{:08X}".format(22222222),
        "RCV_PKT_ID": "0x{:08X}".format(11111111),
        "LOCAL_PE_ID": "0x0{:01X}{:01X}".format(1, 0),
        "SND_PE_ID": "0x0{:01X}{:01X}".format(1, 1),
        "RCV_PE_ID": "0x0{:01X}{:01X}".format(0, 0),
        "rv_0_xocc_cmd_width": 64,
        "rv_0_xocc_rsp_width": 64,
        "rv_0_nou_qid": 4,
        "snd_seed": 1,
        "rcv_seed": 0
    },
    "pe_1_1": {
        "SND_PKT_ID": "0x{:08X}".format(33333333),
        "RCV_PKT_ID": "0x{:08X}".format(22222222),
        "LOCAL_PE_ID": "0x0{:01X}{:01X}".format(1, 1),
        "SND_PE_ID": "0x0{:01X}{:01X}".format(0, 1),
        "RCV_PE_ID": "0x0{:01X}{:01X}".format(1, 0),
        "rv_0_xocc_cmd_width": 64,
        "rv_0_xocc_rsp_width": 64,
        "rv_0_nou_qid": 4,
        "snd_seed": 2,
        "rcv_seed": 1
    },
    "pe_0_1": {
        "SND_PKT_ID": "0x{:08X}".format(44444444),
        "RCV_PKT_ID": "0x{:08X}".format(33333333),
        "LOCAL_PE_ID": "0x0{:01X}{:01X}".format(0, 1),
        "SND_PE_ID": "0x0{:01X}{:01X}".format(0, 0),
        "RCV_PE_ID": "0x0{:01X}{:01X}".format(1, 1),
        "rv_0_xocc_cmd_width": 64,
        "rv_0_xocc_rsp_width": 64,
        "rv_0_nou_qid": 4,
        "snd_seed": 3,
        "rcv_seed": 2
    }
}

def opt_parse():
    parser = argparse.ArgumentParser()
    parser.add_argument("--tc", action="store_true", help="generate testcase files")
    parser.add_argument("-c", "--config", type=str, default="../configs/2_1_thrive_homo", help="config files")
    parser.add_argument("-p", "--path", type=str, default="../../../dv/testcase", help="mako template file path")
    parser.add_argument("--case_name", type=str, default="autogen_smoke_test", help="generate case name")
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

class TCGen:
    def __init__(self, path, cfg):
        self.chip = None
        self.pe = []
        self.cfg = cfg
        self.path = path
        self.tc = None
    
    def parse(self):
        for path, dir_list, file_list in os.walk(self.cfg):
            for file_name in file_list:
                if file_name.startswith("thrive_chip"):
                    chip = Chip()
                    chip.parse(os.path.join(path,file_name))
                    self.chip = chip
                if file_name.startswith("thrive_pe"):
                    pe = PE()
                    pe.parse(os.path.join(path,file_name))
                    self.pe.append(pe)

    def gen_par(self):
        '''
        Generate testcase packet parameters
        '''
        xocc_info = {}
        if self.chip.type == "homogeneous":
            pe = self.pe[0]
            for rv in pe.rvs.dispatcher:
                for link in rv.link:
                    if link.dst == "nou" and link.type == "xocc":
                        xocc_info["cmd_width"] = link.width[0]
                        xocc_info["rsp_width"] = link.width[1]
                        xocc_info["qid"] = link.qid
        else:
            for pe in self.pe:
                xocc_info[pe.name] = {}
                for rv in pe.rvs.dispatcher:
                    for link in rv.link:
                        if link.dst == "nou" and link.type == "xocc":
                            xocc_info[pe.name]["cmd_width"] = link.width[0]
                            xocc_info[pe.name]["rsp_width"] = link.width[1]
                            xocc_info[pe.name]["qid"] = link.qid

        pe_x_y = {}
        topology = self.chip.topology
        for x in range(topology[0]):
            for y in range(topology[1]):
                if x < topology[0]-1:
                    snd_pe_id_x = x+1; snd_pe_id_y = y
                elif x == topology[0]-1 and y < topology[1]-1:
                    snd_pe_id_x = 0; snd_pe_id_y = y+1
                else:
                    snd_pe_id_x = 0; snd_pe_id_y = 0

                if x > 0:
                    rcv_pe_id_x = x-1; rcv_pe_id_y = y
                elif x == 0 and y > 0:
                    rcv_pe_id_x = topology[0]-1; rcv_pe_id_y = y-1
                else:
                    rcv_pe_id_x = topology[0]-1; rcv_pe_id_y = topology[1]-1

                pe_name = "pe_{}_{}".format(x, y)
                pe_x_y[pe_name] = {
                    "SND_PKT_ID": "0x{:08X}".format(random.randint(0, 2**32-1)),
                    "RCV_PKT_ID": None,
                    "LOCAL_PE_ID": "0x0{:01X}{:01X}".format(x, y),
                    "SND_PE_ID": "0x0{:01X}{:01X}".format(snd_pe_id_x, snd_pe_id_y),
                    "RCV_PE_ID": "0x0{:01X}{:01X}".format(rcv_pe_id_x, rcv_pe_id_y),
                    "rv_0_xocc_cmd_width": xocc_info["cmd_width"] if self.chip.type == "homogeneous" else xocc_info[pe_name]["cmd_width"],
                    "rv_0_xocc_rsp_width": xocc_info["rsp_width"] if self.chip.type == "homogeneous" else xocc_info[pe_name]["rsp_width"],
                    "rv_0_nou_qid": xocc_info["qid"] if self.chip.type == "homogeneous" else xocc_info[pe_name]["qid"],
                    "snd_seed": random.randint(0, 2**20-1),
                    "rcv_seed": None
                }
            
        for x in range(topology[0]):
            for y in range(topology[1]):
                pe_name = "pe_{}_{}".format(x, y)
                for k,v in pe_x_y.items():
                    if pe_x_y[pe_name]["RCV_PE_ID"] == v["LOCAL_PE_ID"]:
                        pe_x_y[pe_name]["RCV_PKT_ID"] = v["SND_PKT_ID"]
                        pe_x_y[pe_name]["rcv_seed"] = v["snd_seed"]
        
        self.tc = pe_x_y

    def gen_file(self, testcase_info):
        # get mako template files
        mako_paths = find_mako_template_path(self.path, suffix="c")
        mako_paths.extend(find_mako_template_path(self.path, suffix="py"))
        for f in mako_paths:
            file_dir, file_name = os.path.split(f)
            file_name_prefix = file_name.split(".")[0]
            if file_name_prefix == "rv_0":
                gen_file_name = "{}.c".format(file_name_prefix)
                gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name, tc=testcase_info)
                print(">>>> generate ", os.path.join(file_dir, gen_file_name))
            if file_name_prefix == "datagen":
                gen_file_name = "{}.py".format(file_name_prefix)
                gen_verilog_file(file_dir=file_dir, file_name=file_name, gen_file_name=gen_file_name, tc=testcase_info)
                print(">>>> generate ", os.path.join(file_dir, gen_file_name))

    def copy_gen_file(self, src_dir, dst_dir):
        for path, dir_list, file_list in os.walk(src_dir):
            for file_name in file_list:
                if ".mako." not in file_name:
                    # only copy generated files, not mako files
                    shutil.copy(os.path.join(path, file_name), dst_dir)
                    print(">>>> copy {} to {}".format(os.path.join(path, file_name), dst_dir))

    def gen(self, case_name="autogen_smoke_test"):
        self.parse()
        self.gen_par()
        for k,v in self.tc.items():
            print(k)
            print(v)

        self.case_name = case_name
        self.case_path = os.path.join(TESTCASE_PATH + self.case_name)
        self.case_template = TESTCASE_PATH + "template"

        if os.path.exists(self.case_path):
            os.system("rm -rf " + self.case_path)

        os.mkdir(self.case_path)
        for x in range(self.chip.topology[0]):
            for y in range(self.chip.topology[1]):
                sub_dir_name = "pe_{}_{}".format(x, y)
                os.mkdir(os.path.join(self.case_path, sub_dir_name))
                self.gen_file(testcase_info=self.tc[sub_dir_name])
                # self.gen_file(testcase_info=TC[sub_dir_name]) # use self-define testcase
                self.copy_gen_file(src_dir=self.case_template, dst_dir=os.path.join(self.case_path, sub_dir_name))

def main():
    args = opt_parse()
    tcgen = TCGen(path=args.path,cfg=args.config)
    if args.tc:
        tcgen.gen(args.case_name)

if __name__ == "__main__":
    main()