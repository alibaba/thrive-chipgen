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

from pe import PE

class ChipPE(PE):
    def __init__(self):
        super().__init__()
        self.computeCapacityTensor = 0
        self.computeCapacityVector = 0
        self.currentMem = 0
        self.currentOpIndex = 0
        self.index = 0
        self.isBusy = 0
        self.memSize = 0
        self.name = ""
        self.type = ""
        self.loc_x = None
        self.loc_y = None
        self.noc_link = ["W", "E", "N", "S"]
        self.noc_link_map = {}
    def __str__(self):
        return "PE[{}] type: {}".format(self.index, self.type)

class ChipMem:
    def __init__(self):
        self.currentData = []
        self.index = 0
        self.memSize = 0
        self.type = 0

class ChipLink:
    def __init__(self):
        self.bandwidth = 0
        self.currentBandwidth = 0
        self.direction = ""
        self.dst = 0
        self.index = 0
        self.isBusy = 0
        self.latency = 0
        self.src = 0
