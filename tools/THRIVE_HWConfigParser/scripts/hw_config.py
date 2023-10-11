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
Script to generate Chip-level yaml configuration file.

Code copied from Haoran Li
(Source Code: http://gitlab.alibaba-inc.com/THRIVE/THRIVE-DSE/blob/master/scripts/gen_hw_config.py)
and modifed by Zhe Zhang
'''

from enum import Enum, auto


bytes_in_MB = 1024 ** 2

class pe_base_config:
    def __init__(self,
                 computeCapacityTensor=1024, 
                 computeCapacityVector=32, 
                 memSize=524288):
        self.computeCapacityTensor=computeCapacityTensor
        self.computeCapacityVector=computeCapacityVector
        self.memSize=memSize

class link_base_config:
    def __init__(self, bw=128, latency=1):
        self.bw=bw
        self.latency=latency
        self.direction='bi'

class memory_base_config:
    def __init__(self, memSize=0):
        self.memSize = memSize


##############################
## MESH
# PE0 - PE1 - PE2 - PE3
#  |     |     |     |
# PE4 - PE5 - PE6 - PE7
#  |     |     |     |
# PE8 - PE9 - PE10 - PE11
#  |     |     |     |
# PE12 - PE13 - PE14 - PE15
##############################
class noc_type(Enum):
    MESH=auto()
    THRIVE=auto()

class HWConfig:
    def __init__(self,global_pe_mesh_shape=(12,4),noc=noc_type.MESH,pe_local_memory_MB:float=16,pe_compute_capacity:int=1024):

        self.global_pe_mesh_shape = global_pe_mesh_shape
        self.pe_compute_compacity =pe_compute_capacity
        self.pe_local_memory_byte = int(pe_local_memory_MB * bytes_in_MB)  # MB
        self.noc = noc
        self.name = self.__str__()
    
    def __str__(self):
        global_pe_mesh_shape_str = ""
        for i in self.global_pe_mesh_shape:
            global_pe_mesh_shape_str += str(i) 
            global_pe_mesh_shape_str += "_"
            
        return "PEMesh" + global_pe_mesh_shape_str + str(self.pe_local_memory_byte / bytes_in_MB) + "MB_" + self.noc.name