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

import random
import os

class oprand:
  def __init__(self, adr, uram_filename, round = 1):
    self.srambank = ( adr & 0x300000 ) >> 20
    #self.adr = (adr & 0xFFFC0) >> 6  #uram data width=512
    self.adr = (adr & 0xFFF80) >> 7  #uram data width=1024
    self.round = round
    self.data = []
    self.uram_filename = uram_filename
    for i in range(16*4*4*self.round):
    #   self.data.append(i) #
      self.data.append(random.randint(0,255))

  def format(self):
    s = ""
    for i in range(self.round*4):
      s += "@" + "{0:0{1}x}".format(self.adr + i, 3) + " "
      for j in range(16*4):
        s += "{0:0{1}x}".format(self.data[i*16*4 + j], 4) #uram data width=1024
        #s += "{0:0{1}x}".format(self.data[i*16*4 + j], 2) #uram data width=512
      s += "\n"
    return s

  def copy(self, ref):
    self.round = ref.round
    self.data = ref.data

  def modify(self):
    file_name = self.uram_filename[self.srambank]
    if os.path.exists(file_name):
      os.system("mv {0} {0}.bak".format(file_name))
      f = open("{}.bak".format(file_name), "r")
      fout = open(file_name, "w")
      write_or_not = 0
      for line in f:
        adr = int(line.split()[0].strip("@"), 16)
        if adr == self.adr:
          line = self.format()
          write_or_not = 1
          # print(line)
        if self.adr >= adr or adr >= self.adr + self.round*4:
          fout.write(line)
      if not write_or_not:
        line = self.format()
        # print(line)
        fout.write(line)
      f.close()
      fout.close()
    else:
      fout = open(file_name, "w")
      fout.write(self.format())

def main():
  uram_filename = ["rv_0.mem", "rv_1.mem", "rv_2.mem", "rv_3.mem"]

  # for each round, 16*16*16/8 = 512B
  SND_PKT_HEADER_ADDR = "0x2050000"
  SND_PKT_DATA_ADDR = "0x2060000"
  GOLDEN_PKT_HEADER_ADDR = "0x2380000"
  GOLDEN_PKT_DATA_ADDR = "0x2390000"

  # The dst PE rcv_seed should be same with snd_seed
  snd_seed = 886840 
  random.seed(snd_seed)
  snd_pkt_header = oprand(int(SND_PKT_HEADER_ADDR, 16), uram_filename, 1) # 212B, round = 1
  snd_pkt_data = oprand(int(SND_PKT_DATA_ADDR, 16), uram_filename, 2) # 1KB, round = 2

  # The rcv_seed should be same with src PE snd_seed
  rcv_seed = 647738 
  random.seed(rcv_seed)
  golden_header = oprand(int(GOLDEN_PKT_HEADER_ADDR, 16), uram_filename, 1) # 212B, round = 1
  golden_data = oprand(int(GOLDEN_PKT_DATA_ADDR, 16), uram_filename, 2) # 1KB, round = 2
  
  snd_pkt_header.modify()
  snd_pkt_data.modify()

  golden_header.modify()
  golden_data.modify()

if __name__ == "__main__":
    main()
