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
from .moduledb import ModPortDB

class ModInstDB(ModPortDB):

    def __init__(self, moduledb: ModPortDB, inst_name):
        self.portlist = PortList()
        self.portlist.lib = moduledb.portlist.lib.copy()
        self.paramlib = ParamLib()
        self.paramlib.lib = moduledb.paramlib.lib.copy()
        self.instparamlib = ParamLib()
#        self.value_assign = [] #port assigned to value
        self.mod_name = inst_name
        self.ori_mod_name = moduledb.mod_name
        self.add_instport()

    def add_instport(self):
        self.portlist.lib.loc["inst_port"] = self.portlist.getports()

    def get_instports(self):
        return self.portlist.lib.loc["inst_port"]

    def ConnRule(self, match_pattern, sub_pattern):
        inst_ports_list = list(self.get_instports())
        for i in range(len(inst_ports_list)):
            inst_port = re.sub(match_pattern,sub_pattern, inst_ports_list[i])
            #print(self.mod_name+" ConnRule: substitute "+inst_ports_list[i]," to "+inst_port)
            inst_ports_list[i] = inst_port

        self.portlist.lib.loc["inst_port"] = inst_ports_list

    def Connect(self, port, inst_port):
        self.portlist.lib[port]["inst_port"] = inst_port
#        if re.match(r"(\d+)?'(h|d|b)(\w+)", inst_port.strip()):
#            self.value_assign.append(port)

    def Param(self, param, value):
        self.paramlib.update_value(param, value)
        self.instparamlib.add(param, "parameter", value)
    
    def get_instport_port(self, inst_port):
        return self.portlist.lib.columns[list(self.portlist.lib.loc["inst_port",:]).index(inst_port)]

    def get_instport_dir(self, inst_port):
        return self.portlist.lib.iloc[0, list(self.portlist.lib.loc["inst_port",:]).index(inst_port)]

    def get_instport_width_expr(self, inst_port):
        return self.portlist.lib.iloc[1, list(self.portlist.lib.loc["inst_port",:]).index(inst_port)]

    def for_param_update(self): #update width expression with param assigned
        for param in self.paramlib.lib.columns:
            if param not in self.instparamlib.lib.columns:
#                self.instparamlib.add(param, "parameter", self.paramlib.getvalue(param))
                for port in self.portlist.lib.columns:
                    self.portlist.updatedwexpr(port, re.sub(param, self.paramlib.getvalue(param), self.portlist.getwidthexpr(port)))

        for param in self.instparamlib.lib.columns:
            for port in self.portlist.lib.columns:
                self.portlist.updatedwexpr(port, re.sub(param, self.instparamlib.getvalue(param), self.portlist.getwidthexpr(port)))

class VPParse():

    def __init__(self, file_path, modulelib, save=False):
        self.filep = file_path
        self.instlib = []
        self.forceport = {}
        self.paramlib = ParamLib()
        self.scan(modulelib)
        self.update_widthexpr_for_param()
        #self.checkdw()
        portlist, self.wirelist = self.getmoddb()
        self.moduledb = ModPortDB(file_path, scan=False)
        self.moduledb.portlist = portlist
        self.moduledb.paramlib = self.paramlib
        self.moduledb.mod_name = os.path.basename(file_path).split(".")[0]
        if save:
            self.save()
            self.moduledb.save()
        self.writeRTL()

    def scan(self, modulelib):
        print("Parsing "+self.filep+"...")
        comment_pattern = re.compile(r'^\s*\/\/')
        inst_pattern = re.compile(r'^\s*\&Instance\s*\(\s*\"(\w+)\"\s*,\s*\"(\w+)\"\s*\)')
        inst_default_pattern = re.compile(r'^\s*\&Instance\s*\(\s*\"(\w+)\"\s*\)') 
        conrule_pattern = re.compile(r'^\s*\&ConnRule\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)')
        conbeg_pattern = re.compile(r'^\s*\&Connect\s*\(')
        conport_pattern = re.compile(r'\s*\.(\w+)\s*\(\s*(\S+)\s*\)\s*,?')
        parambeg_pattern = re.compile(r'^\s*\&Param\s*\(')
        end_pattern = re.compile(r'^\s*\)')
        force_pattern = re.compile(r'&Force\s*\(\s*\"(\w+)\"\s*,\s*\"(\w+)\"\s*\)')
        endinst_pattern = re.compile(r'^\s*\&endInstance')
        param_claim_pattern = re.compile(r'^\s*parameter\s+(\w+\s+)?(\w+)\s*=\s*(\S+)\s*;')
        inside_connect = False
        inside_param = False
        inside_instance = False
        f = open(self.filep, "r")
        line = f.readline()
        while(line):
            if comment_pattern.match(line):
                pass
            elif inst_pattern.match(line):
                module = inst_pattern.match(line).group(1)
                inst_name = inst_pattern.match(line).group(2)
                instdb = ModInstDB(modulelib[module], inst_name)
                self.instlib.append(instdb)
                inside_instance = True
            elif inst_default_pattern.match(line):
                module = inst_default_pattern.match(line).group(1)
                inst_name = "x_"+module
                instdb = ModInstDB(modulelib[module], inst_name)
                self.instlib.append(instdb)
                inside_instance = True
            elif conrule_pattern.match(line):
                if len(self.instlib) == 0:
                    print("Warning!!! ConnRule before Instance.")
                rule_expr = "self.instlib[-1]."+conrule_pattern.match(line).group(0).replace(" ","")[1:]
                #print(rule_expr)
                eval(rule_expr) 
            elif conbeg_pattern.match(line):
                inside_connect = True
            elif parambeg_pattern.match(line):
                inside_param = True
            elif conport_pattern.match(line): 
                if inside_connect:
                    port = conport_pattern.match(line).group(1)
                    inst_port = conport_pattern.match(line).group(2)
                    self.instlib[-1].Connect(port, inst_port)
                elif inside_param:
                    param = conport_pattern.match(line).group(1)
                    value = conport_pattern.match(line).group(2)
                    self.instlib[-1].Param(param, value.strip())
                else:
                    print("Warning!!!Port/Param mapping out of box.\n")
            elif param_claim_pattern.match(line):
                param = param_claim_pattern.match(line).group(2)
                value = param_claim_pattern.match(line).group(3)
                self.paramlib.add(param, "parameter", value)
            elif end_pattern.match(line):
                if inside_connect:
                    inside_connect = False
                elif inside_param:
                    inside_param = False
                else:
                    print("Warning!!!Ambiguous end pattern.\n")
            elif force_pattern.match(line):
                direction = force_pattern.match(line).group(1)
                port = force_pattern.match(line).group(2)
                self.forceport[port] = direction
            else:
                pass #TODO

            line = f.readline()

        f.close()

    def checkdw(self):
        for instdb in self.instlib:
            instdb.check_portdw()       

    def update_widthexpr_for_param(self):
        for instdb in self.instlib:
            instdb.for_param_update()

    def clear_value_assign(self, lst):
        port_lst = []
        for inst_port in lst:
            if not re.match(r"(\d+)?'(h|d|b)(\w+)", inst_port.strip()):
                port_lst.append(inst_port)
        return port_lst

    def getmoddb(self):    #obtain moddb for this vpy module
        portlist = PortList()
        wirelist = PortList()
        for i in range(len(self.instlib)):
            inst_port_i = self.clear_value_assign(list(self.instlib[i].portlist.lib.loc["inst_port"]))
            for j in range(len(self.instlib)):
                if i != j:
                    inst_port_j = self.clear_value_assign(list(self.instlib[j].portlist.lib.loc["inst_port"]))
                    same_port = list(set(inst_port_i).intersection(inst_port_j))
                    for inst_port in same_port:
                        if self.instlib[i].get_instport_dir(inst_port) != self.instlib[j].get_instport_dir(inst_port) and inst_port not in wirelist.getports():
                            wirelist.add(inst_port,"wire", self.instlib[i].get_instport_width_expr(inst_port))
                            inst_port_i.remove(inst_port)
            for port in inst_port_i:
                if port not in portlist.lib.columns and port not in wirelist.getports():
                    portlist.add(port, self.instlib[i].get_instport_dir(port), self.instlib[i].get_instport_width_expr(port))

        for port in self.forceport.keys():
            if port not in portlist.getports():
                if not self.forceport[port] == "nonport":
                    width = wirelist.getwidthexpr(port)
                    portlist.add(port, self.forceport[port], width)
            else:
                if self.forceport[port] == "nonport":
                    wirelist.add(port, "wire", portlist.getwidthexpr(port))
                    portlist.remove(port)
                else:
                    portlist.updatedir(port, self.forceport[port])

        return portlist, wirelist
                            
    def writeRTL(self):
        #fo = open(os.path.basename(self.filep)[:-1], 'w+')
        fo = open(self.filep[:-1].replace("src_rtl", "gen_rtl"), 'w+')
        modbeg_pattern = re.compile(r'^\s*\&ModuleBeg')
        modend_pattern = re.compile(r'^\s*\&ModuleEnd')
        inst_pattern = re.compile(r'^\s*\&Instance\s*\(\s*\"(\w+)\"\s*,\s*\"(\w+)\"\s*\)')
        inst_default_pattern = re.compile(r'^\s*\&Instance\s*\(\s*\"(\w+)\"\s*\)') 
        conrule_pattern = re.compile(r'^\s*\&ConnRule\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)')
        conbeg_pattern = re.compile(r'^\s*\&Connect\s*\(')
        conport_pattern = re.compile(r'\s*\.(\w+)\s*\(\s*(\S+)\s*\)\s*,?')
        parambeg_pattern = re.compile(r'^\s*\&Param\s*\(')
        end_pattern = re.compile(r'^\s*\)')
        force_pattern = re.compile(r'^\s*&Force\s*\(\s*\"(\w+)\"\s*,\s*\"(\w+)\"\s*\)')
        ports_pattern = re.compile(r'^\s*&Ports;?')
        endinst_pattern = re.compile(r'^\s*\&endInstance')
        inside_connect = False
        inside_param = False
        inst_cnt = 0
        line_num = 0
        f = open(self.filep, "r")
        line = f.readline()
        while(line):
            line_num += 1
            if modbeg_pattern.match(line):
                fo.write(f"// {line.strip()} @{line_num}\n")
                fo.write("module "+self.moduledb.mod_name+" (\n")
                for i, port in enumerate(self.moduledb.portlist.lib.columns):
                    if i == len(self.moduledb.portlist.lib.columns) - 1:
                        fo.write(f"\t{port}\n")
                    else:
                        fo.write(f"\t{port},\n")
                fo.write(");\n")
                fo.write("\n")
            elif ports_pattern.match(line):
                fo.write(f"// {line.strip()} @{line_num}\n")
                max_widthexpr_width, max_port_width = self.getmaxwidth(self.moduledb.portlist)
                for port in self.moduledb.portlist.getports():
                    fo.write(f"{self.moduledb.portlist.getdirection(port):<8}{self.moduledb.portlist.getwidthexpr(port).strip().replace(' ',''):<{max_widthexpr_width+1}}{port.strip()+';':<{max_port_width}}\n")
                fo.write("\n")
                if not self.wirelist.lib.empty:
                    max_widthexpr_width, max_port_width = self.getmaxwidth(self.wirelist)
                    for wire in self.wirelist.getports():
                        #print(self.wirelist.lib[wire])
                        fo.write(f"wire    {self.wirelist.getwidthexpr(wire).strip().replace(' ',''):<{max_widthexpr_width+1}}{wire.strip()+';':<{max_port_width}}\n")
                fo.write("\n")
            elif inst_pattern.match(line) or inst_default_pattern.match(line):
                mod_name = self.instlib[inst_cnt].ori_mod_name
                inst_name = self.instlib[inst_cnt].mod_name
                fo.write(f"// {line.strip()} @{line_num}\n")
                if not self.instlib[inst_cnt].instparamlib.lib.empty:
                    fo.write(f"{mod_name} #(\n")
                    for i, param in enumerate(self.instlib[inst_cnt].instparamlib.lib.columns):
                        if i == len(self.instlib[inst_cnt].instparamlib.lib.columns) - 1:
                            fo.write(f"\t.{param}({self.instlib[inst_cnt].instparamlib.getvalue(param)})\n")
                        else:
                            fo.write(f"\t.{param}({self.instlib[inst_cnt].instparamlib.getvalue(param)}),\n")
                    fo.write(f") {inst_name} (\n")
                else:
                    fo.write(f"{mod_name} {inst_name} (\n")
                for i, port in enumerate(self.instlib[inst_cnt].portlist.lib.columns):
                    max_port_width = len(max(list(self.instlib[inst_cnt].portlist.lib.columns), key=len))
                    max_instport_width = len(max(list(self.instlib[inst_cnt].portlist.lib.loc["inst_port"]), key=len))
                    if i == len(self.instlib[inst_cnt].portlist.lib.columns) - 1:
                        fo.write(f'\t.{port:<{max_port_width}}({self.instlib[inst_cnt].portlist.lib[port]["inst_port"]:<{max_instport_width}})\n')
                    else:
                        fo.write(f'\t.{port:<{max_port_width}}({self.instlib[inst_cnt].portlist.lib[port]["inst_port"]:<{max_instport_width}}),\n')
                fo.write(");\n")
                inst_cnt += 1
            elif modend_pattern.match(line):
                fo.write("\n")
                fo.write("endmodule\n")
            elif conrule_pattern.match(line) or conbeg_pattern.match(line) or conport_pattern.match(line) or parambeg_pattern.match(line) or end_pattern.match(line) or endinst_pattern.match(line) or force_pattern.match(line):
                fo.write(f"// @{line_num} {line}")
            else:
                fo.write(line)

            line = f.readline()

        f.close()

        fo.close()

    def save(self):
        for instdb in self.instlib:
            instdb.save()

    def getmaxwidth(self, portlist):
        width_list = list(portlist.lib.loc["width_expr"])
        port_list = list(portlist.lib.columns)
        max_widthexpr_width = len(max(width_list, key=len))
        max_port_width = len(max(port_list, key=len))
        return max_widthexpr_width, max_port_width
