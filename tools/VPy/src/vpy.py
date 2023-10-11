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


import sys
import re
import os
from os.path import exists
import argparse
from pandas import DataFrame as df
from VPy.src.data_type import *
from VPy.src.moduledb import ModPortDB
from VPy.src.instance import *
from VPy.src.paramdb import *

LIBPATH_DEPEND = os.environ.get("LIBPATH_DEPEND")

def OptParse():
    parser = argparse.ArgumentParser()
    parser.add_argument('-t', '--top', type=str, default=' ', help='top module')
    parser.add_argument('-s', '--save', action='store_true', help='save as xlsx')
    parser.add_argument('-c', '--clean', action='store_true', help='clean all generated verilog files')
    args = parser.parse_args()
    print('==> Options:',args)
    return args

class Vpy():

    def __init__(self, top, save=False):
        self.search_paths = LIBPATH_DEPEND.split()
        self.save = save
        self.top = top
        self.depend = {}
        self.modulelib = {}
        self.header_list= []    #list of scaned header
        self.filelist = []
        self.paramdb = ParamDB()   #FIXME
        self.build_depend()
        self.setup_paramdb()
        self.vpParse()
        self.writefl()

    def build_depend(self):
        print("Creating depending graph...")
        mod_path, _ =  self.find_module(self.top)
        mod_list, header_list = self.depend_parse(mod_path)
        self.depend[self.top] = mod_list
        self.header_list += header_list
        (unreg_mod, module, mod_path) = self.find_unregistered_module()
        while(unreg_mod):
            mod_list, header_list = self.depend_parse(mod_path)
            self.depend[module] = mod_list
            self.header_list += header_list
            (unreg_mod, module, mod_path) = self.find_unregistered_module()

        print("Depending graph has been generated:\n", self.depend)

    def find_unregistered_module(self):
        result = (False, "","")
        for module_list in self.depend.values():    
            for module in module_list:
                (mod_path, isvp) = self.find_module(module)
                if isvp and (module not in self.depend.keys()):
                    result = (True, module, mod_path)
                    break
                else:
                    result = (False, module, mod_path)
            else:
                continue
            break
        return result

    def find_module(self, module):
        #print("Searching "+module+" ...")
        for path in self.search_paths:
            modvp_path = os.path.join(path, module+".vp")
            modv_path = os.path.join(path, module+".v")
            modsv_path = os.path.join(path, module+".sv")
            if exists(modvp_path):
                #print("Find "+modvp_path)
                return (modvp_path, True)
            elif exists(modv_path):
                if module not in self.modulelib.keys():
                    mdb = ModPortDB(modv_path, save=self.save)
                    self.header_list += mdb.header_list
                    self.modulelib[module] = mdb
                #print("Find "+modv_path)
                return (modv_path, False)
            elif exists(modsv_path):
                if module not in self.modulelib.keys():
                    mdb = ModPortDB(modsv_path, save=self.save)
                    self.header_list += mdb.header_list
                    self.modulelib[module] = mdb
                #print("Find "+modsv_path)
                return (modsv_path, False)

        print("Warning!!! Module "+module+" cannot be found.")
        return (None, False)

    def find_header(self, header):
        #print("Searching header "+header+" ...")
        for path in self.search_paths:
            header_path = os.path.join(path, header)
            if exists(header_path):
                return header_path

    def isvp(self, module):
        return self.find_module(module)[-1]

    def depend_parse(self, mod_path):
        inst_pattern = re.compile(r'^\s*\&Instance\s*\(\s*\"(\w+)\"\s*,\s*\"(\w+)\"\s*\)') 
        inst_default_pattern = re.compile(r'^\s*\&Instance\s*\(\s*\"(\w+)\"\s*\)') 
        include_pattern = re.compile(r'^\s*`include\s+\"(\w+)\.h\"')
        mod_list = []
        header_list = []
        f = open(mod_path, 'r')
        line = f.readline()
        while(line):
            if inst_pattern.match(line):
                module = inst_pattern.match(line).group(1)
                if module not in mod_list:
                    mod_list.append(module)
            elif inst_default_pattern.match(line):
                module = inst_default_pattern.match(line).group(1)
                if module not in mod_list:
                    mod_list.append(module)
            elif include_pattern.match(line):
                header_list.append(include_pattern.match(line).group(1)+".h")
            else:
                pass

            line = f.readline()
        f.close()
        return (mod_list,header_list)

    def setup_paramdb(self):
        while(len(self.header_list)):
            for header in self.header_list:
                if header not in self.paramdb.header_list:
                    self.header_list += self.paramdb.headerScan(self.find_header(header))   #header in header
                    self.header_list.remove(header)    #remove already scanned header
                else:
                    self.header_list.remove(header)   
    
    def find_moduledb(self, module):
        return self.modulelib[module]

    def vpParse(self):
        for vpmod in reversed(self.depend.keys()):
            vp_path, _ = self.find_module(vpmod) 
            self.filelist.append(vp_path)
            vpparse = VPParse(vp_path, self.modulelib, save=self.save)
            self.modulelib[vpmod] = vpparse.moduledb       #update parsed vp module
            #print(self.modulelib)

    def writefl(self):
        f = open("vp.f", "w+")
        for vp in self.filelist:
            f.write(vp[:-1].replace("src_rtl", "gen_rtl")+"\n")
        f.close()

def clean():
    f = open("vp.f", 'r')
    line = f.readline()
    while(line):
        os.system('rm -rf '+line)
        line = f.readline()
    f.close()


if __name__ == "__main__":
    args = OptParse()
    if args.clean:
        clean()
    else:
        vpy = Vpy(args.top, save=args.save)
