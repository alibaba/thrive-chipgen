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

'''
Author: Zhe Zhang
'''

import yaml
import argparse
import os
import copy
from pe_component import *

class PE:
    def __init__(self):
        # pe
        self._pe = 0
        self.type = ""
        self.name = ""
        self.prefix = ""
        
        # module
        self._disp = 0
        self._reg = 0
        self._mem = 0
        
        # cluster topology
        self._dsa = 0
        self._rv_cluster = 0
        
        self.rvs = 0
        self.dsas = 0
        self.mem_ss = 0

        self.xbar = XBar()
        
        self.file_path = ""
    
    def parse(self, file_path=None):
        self.file_parse(file_path)
        self.rvcluster_parse()
        self.dsa_parse()
        self.mem_parse()
        self.xbar_parse()
        self.ip_parse()
    
    # def change_rv_name(self):
    #     # used for heterogeneous PE, change each rv name with prefix
    #     self.rvs.name = self.name
    #     for rv in self.rvs.dispatcher + self.rvs.regular:
    #         rv.name = "{}_{}".format(self.name,rv.name)
        
    def file_parse(self, file_path=None):
        assert file_path != None, "No config file found!"
        self.file_path = file_path
        self._pe = self.load_yaml(file_path)

        self._disp = self._pe["dispatcher"]
        self._reg = self._pe["regular"]
        self._mem = self._pe["memory"]

        self._dsa = self._pe["dsa"]
        self._rv_cluster = self._pe["rvcluster"]

        if "type" in self._pe: 
            self.type = self._pe["type"]
        if "name" in self._pe: 
            self.name = self._pe["name"]
            self.prefix = self.name
        
    def rvcluster_parse(self, file_path=None):
        if self.file_path == "": self.file_parse(file_path)
        # rvcluster_disp = self._rv_cluster["dispatcher"]
        # rvcluster_reg = self._rv_cluster["regular"]
        self.rvs = RVCluster(self._rv_cluster)
        self.rvs.name = self.name
        
    def dsa_parse(self, file_path=None):
        if self.file_path == "": self.file_parse(file_path)
        self.dsas = DSACluster(self._dsa)

    def xbar_parse(self, file_path=None):
        if self.file_path == "": self.file_parse(file_path)
        self.xbar = XBar()
        self.xbar.name = self.name
        # DSA, slave
        for module in self.rvs.dispatcher + self.rvs.regular + self.dsas.dsas:
            ind = 0
            for link in module.link:
                if link.type == "axi":
                    str_ind = "_{}".format(ind) if module.num_axi > 1 else ""
                    link_index = "{:0>2d}".format(link.index)
                    # For Xbar Integrated into PE
                    self.xbar.slave_link_map_r[link_index] = "{}_m{}_axi".format(module.name, str_ind)
                    self.xbar.slave_link_map_c[link_index] = "{}".format(module.name)
                    # For Xbar Generation
                    str_addr_width = "S{}_AXI_ADDR_WIDTH".format(link_index)
                    str_data_width = "S{}_AXI_DATA_WIDTH".format(link_index)
                    self.xbar.slave_par[str_addr_width] = 32
                    self.xbar.slave_par[str_data_width] = link.width
                    self.xbar.s_dw[link.index] = [link.width, module.name]
                    ind += 1
                    self.xbar.num_slave += 1

        # Mem, master
        ind = 0
        for mem in self.mem_ss.mems:
            if mem.type == "scratchpad":
                for i in range(mem.bank_num):
                    str_ind = "_{}".format(ind) if mem.bank_num > 1 else ""
                    link_index = "{:0>2d}".format(i)
                    # For Xbar Integrated into PE
                    self.xbar.master_link_map_r[link_index] = "s{}_axi".format(str_ind)
                    self.xbar.master_link_map_c[link_index] = "mem_sub_sys"
                    # For Xbar Generation
                    str_addr_width = "M{}_AXI_ADDR_WIDTH".format(link_index)
                    str_data_width = "M{}_AXI_DATA_WIDTH".format(link_index)
                    self.xbar.master_par[str_addr_width] = 32 # [FIXME] Fixed Value
                    self.xbar.master_par[str_data_width] = 1024 # [FIXME] Fixed Value
                    self.xbar.m_dw[ind] = [1024, "{}_bank{}".format(mem.type, ind)]
                    ind += 1
                    self.xbar.num_master += 1
            if mem.type == "csr":
                link_index = "{:0>2d}".format(ind)
                self.xbar.master_link_map_r[link_index] = "csr_axi"
                self.xbar.master_link_map_c[link_index] = "sys"
                self.xbar.m_dw[ind] = [32, mem.type]
                ind += 1
                self.xbar.num_master += 1
        
    def mem_parse(self, file_path=None):
        if self.file_path == "": self.file_parse(file_path)
        self.mem_ss = MemorySS(self._mem)

    def ip_parse(self, file_path=None):
        if self.file_path == "": self.file_parse(file_path)
        pass
    
    def load_yaml(self, file_path):
        yaml_file = open(file_path, "r")
        return yaml.load(yaml_file, Loader=yaml.FullLoader)
    
    @property
    def raw_val(self):
        return self._pe
    @property
    def disp(self):
        return self._disp
    @property
    def reg(self):
        return self._reg
    @property
    def mem(self):
        return self._mem
    @property
    def rv_cluster(self):
        return self._rv_cluster
    @property
    def dsa_cluster(self):
        return self._dsa

def main():
    pe = PE()
    pe.parse("../configs/thrive_pe.yaml")
    print("-"*100)
    print(pe.rvs)
    print(pe.dsas)
    print(pe.mem_ss)

if __name__ == "__main__":
    main()
