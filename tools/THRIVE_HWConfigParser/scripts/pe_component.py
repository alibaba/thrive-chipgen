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

class Link:
    def __init__(self, link):
        self.dst = link["dst"]
        self.index = link["index"]
        self.type = link["type"]
        self.width = link["width"] if "width" in link and link["width"] != None else 0
        self.port = link["port"] if "port" in link and link["port"] != None else 0
        self.mem = link["mem"] if "mem" in link and link["mem"] != None else 0
        if "qid" in link: self.qid = link["qid"]
    def __str__(self):
        f = "link: {}_{}, width: {}, dst: {}"
        return f.format(self.type, self.index, self.width, self.dst)
    def __repr__(self):
        return self.__str__()

class Core:
    def __init__(self, core):
        self.name = core["name"]
        self.link = []
        self.num_xocc = 0
        self.num_axi = 0
        self.xocc_link_hash = {}
        self.qid_map = {}
        for link in core["link"]:
            self.link.append(Link(link))
        self.cal_link_num()
        self.set_xocc_hash()
        self.cal_qid_map()
        if "toolchain" in core.keys():
            self.toolchain = core["toolchain"]

    def cal_qid_map(self):
        for link in self.link:
            if link.type == "xocc":
                self.qid_map[link.qid] = [link.width, link.dst]
    def cal_link_num(self):
        for link in self.link:
            if link.type == "xocc":
                self.num_xocc += 1
            if link.type == "axi":
                self.num_axi += 1
    def set_xocc_hash(self):
        ind = 0
        for link in self.link:
            if link.type == "xocc":
                self.xocc_link_hash[link.index] = ind
                ind += 1
    def __str__(self):
        print("Core name: " + self.name)
        for link in self.link:
            print(link)
        return ""
    def __repr__(self):
        return self.__str__()

class DSA:
    def __init__(self, dsa, module=""):
        self.name = dsa["name"]
        if module == "":
            self.module = self.name
        else:
            self.module = module
        self.link = []
        self.num_xocc = 0
        self.num_axi = 0
        self.xocc_link_ind_hash = {}
        self.xocc_link_dst_hash = {}
        for link in dsa["link"]:
            self.link.append(Link(link))
        self.cal_link_num()
        self.set_xocc_hash()
    def cal_link_num(self):
        for link in self.link:
            if link.type == "xocc":
                self.num_xocc += 1
        for link in self.link:
            if link.type == "axi":
                self.num_axi += 1
    def set_xocc_hash(self):
        ind = 0
        for link in self.link:
            if link.type == "xocc":
                self.xocc_link_ind_hash[link.index] = ind
                ind += 1
                self.xocc_link_dst_hash[link.index] = link.dst
    def __str__(self):
        print("DSA name: " + self.name)
        for link in self.link:
            print(link)
        return ""
    def __repr__(self):
        return self.__str__()
        
class NOU(DSA):
    def __init__(self):
        pass

class XBar:
    def __init__(self):
        # for VPerl Rule
        self.slave_link_map_r = {}
        # for VPerl Connect
        self.slave_link_map_c = {}
        self.master_link_map_r = {}
        self.master_link_map_c = {}

        # for XBar Gen
        self.slave_par = {}
        self.master_par = {}

        # for XBar Gen
        self.s_dw = {}
        self.m_dw = {}

        # num
        self.num_slave = 0
        self.num_master = 0

        self.name = ""

class Memory:
    def __init__(self, memory):
        self.size = memory["size"]
        self.type = memory["type"]
        self.bank_num = memory["bankNum"]
        self.index = memory["index"]
        if "memory_map" in memory.keys():
            self.memory_map = memory["memory_map"]
    def __str__(self):
        f = "{}_{}: {}, bank num: {}"
        return f.format(self.type, self.index, self.size, self.bank_num)
    def __repr__(self):
        return self.__str__()

class MemorySS:
    def __init__(self, memorys):
        self.mems = []
        self.addr_map = {}
        for mem in memorys:
            self.mems.append(Memory(mem))
        self.addr_map_gen()        

    def addr_map_gen(self):
        for mem in self.mems:
            if len(mem.memory_map) > 0:
                for mem_map in mem.memory_map:
                    self.addr_map[mem_map["name"]] = {"start_addr":mem_map["start_addr"], "end_addr":mem_map["end_addr"]}

    def __str__(self):
        print(">>>> Memory Subsystem")
        for mem in self.mem_ss: print(mem)
        return ""
    def __repr__(self):
        return self.__str__()

class RVCluster:
    def __init__(self, rvcluster):
        self.num = rvcluster["num"]
        self.config = rvcluster["config"]
        self.name = ""
        self.dispatcher = []
        self.regular = []
        if "dispatcher" in rvcluster:
            for dispatcher in rvcluster["dispatcher"]:
                self.dispatcher.append(Core(dispatcher))
        if "regular" in rvcluster:
            for regular in rvcluster["regular"]:
                self.regular.append(Core(regular))
    def __str__(self):
        print(">>>> RV Cluster")
        for dispatcher in self.dispatcher:
            print(dispatcher)
        for regular in self.regular:
            print(regular)
        return ""
    def __repr__(self):
        return self.__str__()

class DSACluster:
    def __init__(self, dsa):
        self.num = dsa["num"]
        self.config = dsa["config"]
        self.dsas = []
        self.init_dsa(dsa)
        
    def init_dsa(self, dsa):
        for dsa_type in dsa:
            if dsa_type not in ["num", "config"]:
                for dsa_inst in dsa[dsa_type]:
                    self.dsas.append(DSA(dsa_inst, dsa_type))
                    
    def __str__(self):
        print(">>>> DSA ")
        for dsa in self.dsas: print(dsa)
        return ""
