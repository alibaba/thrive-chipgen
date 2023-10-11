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


from .data_type import *
import re
import sys
import os
from pandas import DataFrame as df

class ModPortDB():

    def __init__(self, filep, in_paramlib=None, scan=True, save=False):
        self.portlist = PortList()
        self.paramlib = ParamLib()
        self.mod_name = "None"
        if scan:
            self.header_list = self.moduleScan(filep)
#        self.check_portdw(in_paramlib)
        if save:
            self.save()

    def moduleScan(self, filep):
        print("Scaning "+filep+"...")
        include_pattern = re.compile(r'^\s*`include\s+\"(\w+)\.h\"')
        mod_begin_pattern = re.compile(r'^\s*module\s+(\w+)(\s+#)?\(?')
        param_pattern = re.compile(r'^\s*parameter\s+(\w+\s+)?(\w+)\s*=\s*(\w+)\s*.*')
        port_name_pattern = re.compile(r'^\s*(\w+)\s*,')
        port_pattern = re.compile(r'^\s*(input|output)\s+(?:wire|reg\s+)?\s*(\[.+\]\s+)?\s*(\w+)\s*,?')
        mod_claim_end_pattern = re.compile(r'^\s*\)\s*;.*')
        mod_end_pattern = re.compile(r'^\s*endmodule.*')
        line_num = 0
        in_mod_claim = 0
        mod_end = 0
        header_list = []

        f = open(filep, "r")
        line = f.readline()
        while(line and not mod_end):
            line_num += 1
            if mod_begin_pattern.match(line):
                self.mod_name =  mod_begin_pattern.match(line).group(1)
                in_mod_claim = 1
            elif include_pattern.match(line):
                header_list.append(include_pattern.match(line).group(1)+".h")
            elif param_pattern.match(line):
                param = param_pattern.match(line).group(2)
                value = param_pattern.match(line).group(3)
                self.paramlib.add(param, "parameter", value)
            elif port_name_pattern.match(line):
                #print(line)
                port = port_name_pattern.match(line).group(1)
                if port not in self.portlist.lib.columns:
                    self.portlist.add(port, "TBA", "TBA")
                else:
                    print("Warning!!! Port "+port+" Redefined.\n")
            elif port_pattern.match(line):
                #print(line, line_num)
                port = port_pattern.match(line).group(3)
                width_expr = port_pattern.match(line).group(2)
                if width_expr == None:
                    width_expr = "[0:0]"
                direction = port_pattern.match(line).group(1)
                if port not in self.portlist.lib.columns:
                    self.portlist.add(port, direction, width_expr)
                else:
                    if in_mod_claim:
                        print("Warning!!! Port "+port+" Redefined.\n")
                    else:
                        self.portlist.update(port, direction, width_expr)
            elif mod_claim_end_pattern.match(line):
                in_mod_claim = 0
            elif mod_end_pattern.match(line):
                mod_end = 1

            line = f.readline()

        f.close()
        
        return header_list

    def check_portdw(self, in_paramlib=None):
        if type(in_paramlib) == ParamLib:
            self.paramlib.add_lib(in_paramlib)  #TODO, no need to store paramDB in every module, can be saved
        self.portlist.checkdw(self.paramlib)

    def save(self):
        with pd.ExcelWriter(self.mod_name+".xlsx") as writer:
            self.portlist.lib.T.to_excel(excel_writer=writer, sheet_name="portlist")
            self.paramlib.lib.T.to_excel(excel_writer=writer, sheet_name="paramlib")
                
                
