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

class ParamDB():

    def __init__(self):
        self.paramlib = ParamLib()
        self.header_list = []

    def headerScan(self, filep):
        print("Scanning "+filep+"...")
        self.header_list.append(os.path.basename(filep))
        ifdef_pattern = re.compile(r'^\s*`ifdef\s+(\w+)')
        ifndef_pattern = re.compile(r'^\s*`ifndef\s+(\w+)')
        elseif_pattern = re.compile(r'^\s*`else')
        endif_pattern = re.compile(r'^\s*`endif')
        #skip_df = df(index=["fifo", "cnt", "skip"], columns=["plcase"])
        #line_num = 0

        header_list = []
        ifdef_fifo = []
        ifdef_cnt = 0
        skip_next = False
        f = open(filep, "r")
        line = f.readline()
        while(line):
            #line_num += 1
            if not skip_next:
                header = self.param_parse(line)
                if header != None:
                    header_list.append(header)

            if ifdef_pattern.match(line):
                if len(ifdef_fifo) == 0 or (len(ifdef_fifo) == ifdef_cnt and ifdef_fifo[-1]):
                    if ((ifdef_pattern.match(line).group(1) in self.paramlib.lib.columns) and self.paramlib.getvalue(ifdef_pattern.match(line).group(1)) != "False"):
                        ifdef_fifo.append(True)
                        skip_next = False
                    else:
                        ifdef_fifo.append(False)
                        skip_next = True
                else:
                    skip_next = True
                ifdef_cnt += 1
            elif ifndef_pattern.match(line):
                if len(ifdef_fifo) == 0 or (len(ifdef_fifo) == ifdef_cnt and ifdef_fifo[-1]):
                    if ((ifndef_pattern.match(line).group(1) not in self.paramlib.lib.columns)):
                        ifdef_fifo.append(True)
                        skip_next = False
                    else:
                        ifdef_fifo.append(False)
                        skip_next = True
                else:
                    skip_next = True
                ifdef_cnt += 1
            elif elseif_pattern.match(line):
                if len(ifdef_fifo) == ifdef_cnt and not ifdef_fifo[-1]:
                    ifdef_fifo[-1] = True
                    skip_next = False
                else:
                    skip_next = True
            elif endif_pattern.match(line):
                if len(ifdef_fifo) == ifdef_cnt:
                    ifdef_fifo.pop()
                    skip_next = False
                else:
                    skip_next = True
                ifdef_cnt -= 1

            line = f.readline()

            #skip_df[line_num]=[len(ifdef_fifo), ifdef_cnt, skip_next]

        f.close()
        #skip_df.T.to_excel("debug.xlsx")
        return header_list

    def param_parse(self, line):
        header = None
        macro_pattern = re.compile(r'^\s*`define\s+(\w+)(\s+\S+)?')
        undef_pattern = re.compile(r'^\s*`undefine\s+(\w+)')
        comment_pattern = re.compile(r'^\s*\/\/')
        include_pattern = re.compile(r'^\s*`include\s+\"(\w+)\.h\"')
        if macro_pattern.match(line):
            param = macro_pattern.match(line).group(1)
            value = macro_pattern.match(line).group(2)
            if value == None:
                value = "True"
            else:
                value = value.replace(" ","")
            if param in self.paramlib.lib.columns:
                print("Warning!!! Param "+param+" redefined.\n")
                self.paramlib.update_value(param, value)
            else:
                self.paramlib.add(param, "macro", value)
        elif undef_pattern.match(line):
            param = macro_pattern.match(line).group(1)
            if param in self.paramlib.lib.columns:
                self.paramlib.update_value(param, "False")
            else:
                self.paramlib.add(param, "macro", "False")
        elif comment_pattern.match(line):
            pass
        elif include_pattern.match(line):
            header = include_pattern.match(line).group(1)+".h"
        else:
            pass

        return header
                
