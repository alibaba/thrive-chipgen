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

from chip_component import *
import yaml

class Chip:
    def __init__(self):
        # pe
        self.pe = []
        self.memory = []
        self.link = []
        self.type = ""
    
    def parse(self, file_path=None):
        self.file_parse(file_path)
        self.pe_parse()
        self.memory_parse()
        self.link_parse()
        self.cal_noc_link()

    def cal_noc_link(self):
        for pe in self.pe:
            if pe.loc_x == 0:
                pe.noc_link.remove("W")
            if pe.loc_y == 0:
                pe.noc_link.remove("S")
            if pe.loc_x == self._chip["topology"][0] - 1:
                pe.noc_link.remove("E")
            if pe.loc_y == self._chip["topology"][1] - 1:
                pe.noc_link.remove("N")
            if "W" in pe.noc_link:
                pe.noc_link_map["W"] = "pe_{}_{}".format(pe.loc_x-1,pe.loc_y)
            if "S" in pe.noc_link:
                pe.noc_link_map["S"] = "pe_{}_{}".format(pe.loc_x,pe.loc_y-1)
            if "E" in pe.noc_link:
                pe.noc_link_map["E"] = "pe_{}_{}".format(pe.loc_x+1,pe.loc_y)
            if "N" in pe.noc_link:
                pe.noc_link_map["N"] = "pe_{}_{}".format(pe.loc_x,pe.loc_y+1)

    def file_parse(self, file_path=None):
        assert file_path != None, "No config file found!"
        self.file_path = file_path
        self._chip = self.load_yaml(file_path)
        self._pe = self._chip["pe"]
        self._mem = self._chip["memory"]
        self._link = self._chip["link"]
        self.type = self._chip["type"]
        self.topology = self._chip["topology"]
        self.addr_map = self._chip["memory_map"]
        
    def pe_parse(self, file_path=None):
        if self.file_path == "": self.file_parse(file_path)
        for _pe in self._pe:
            pe = ChipPE()
            pe.computeCapacityTensor = _pe["computeCapacityTensor"]
            pe.computeCapacityVector = _pe["computeCapacityVector"]
            pe.currentMem = _pe["currentMem"]
            pe.currentOpIndex = _pe["currentOpIndex"]
            pe.index = _pe["index"]
            pe.isBusy = _pe["isBusy"]
            pe.memSize = _pe["memSize"]
            pe.name = _pe["name"][7:]
            pe.type = self._chip["type"]
            if "x" in _pe: pe.loc_x = _pe["x"]
            if "y" in _pe: pe.loc_y = _pe["y"]
            self.pe.append(pe)
        
    def memory_parse(self, file_path=None):
        if self.file_path == "": self.file_parse(file_path)
        for _mem in self._mem:
            mem = ChipMem()
            mem.currentData = _mem["currentData"]
            mem.index = _mem["index"]
            mem.memSize = _mem["memSize"]
            self.memory.append(mem)

#    def addr_map_parse(self, file_path=None):
#        if self.file_path == "": self.file_parse(file_path)
#        for mem_map in mem.memory_map:
#            self.addr_map[mem_map["name"]] = {"start_addr":mem_map["start_addr"], "end_addr":mem_map["end_addr"]}
        
    def link_parse(self, file_path=None):
        if self.file_path == "": self.file_parse(file_path) 
        for _link in self._link:
            link = ChipLink()
            link.bandwidth = _link["bandwidth"]
            link.currentBandwidth = _link["currentBandwidth"]
            link.direction = _link["direction"]
            link.src = _link["src"]
            link.dst = _link["dst"]
            link.index = _link["index"]
            link.isBusy = _link["isBusy"]
            link.latency = _link["latency"]
            self.link.append(link)

    def load_yaml(self, file_path):
        yaml_file = open(file_path, "r")
        return yaml.load(yaml_file, Loader=yaml.FullLoader)

def main():
    chip = Chip()
    chip.parse("../configs/thrive_chip.yaml")

    print(100*"*")
    print(chip.pe)
    print(chip.pe[0])
    print(chip.pe[0].computeCapacityTensor)
    print(chip.pe[0].mem)
    print(chip.pe[0].reg)

if __name__ == "__main__":
    main()
