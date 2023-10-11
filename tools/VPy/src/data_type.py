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


from pandas import DataFrame as df
import pandas as pd
import numpy as np
import re
import itertools
import sys

class ParamLib():

    def __init__(self, lib=None):
        if type(lib) == df:
            if lib.empty:
                self.lib=df(index=["type", "value"], columns=["placehodler"])
                self.remove_placehd()
            else:
                self.lib=lib
        elif lib == None:
            self.lib=df(index=["type", "value"], columns=["placehodler"])
            self.remove_placehd()
        else:
            self.lib=lib

    def add_lib(self, lib_i):
        for param in self.lib.columns:
            if param in lib_i.lib.columns:
                self.lib.rename(columns={param:param+"_old"}, inplace=True)
        self.lib = pd.concat([self.lib,lib_i.lib], axis=1)
        #print(self.lib)

    def add(self, param, p_type, p_value):
        item = pd.Series([p_type, p_value], name=param, index=self.lib.index)
        self.lib=pd.concat([self.lib, item], axis=1)

    def update_type(self, param, p_type):
        self.lib[param]["type"] = p_type

    def update_value(self, param, p_value):
        self.lib[param]["value"] = p_value

    def remove(self, param):
        self.lib.drop(param, axis=1, inplace=True)

    def getvalue(self, param):
        if re.match(r'`(\w+)', param):
            param = re.match(r'`(\w+)', param).group(1)
        if param not in self.lib.columns:
            print("Warning!!! Parameter "+param+" not defined yet. Default set to one.\n")
            value = "1"
        else:
            value = self.lib[param]["value"]
        return value
        
    def gettype(self, param):
        return self.lib[param]["type"]

    def save(self, path, sheet_name="paramlib"):
        self.lib.T.to_excel(path, sheet_name=sheet_name, encoding='utf-8')

    def remove_placehd(self):
        if "placehodler" in self.lib.columns:
            self.remove("placehodler")
        
class DataWidth():

    def __init__(self, width_expr):
        # pattern ():()
        pattern = re.compile(r'\[\s*(.+):(.+)\s*\]')
#        print(width_expr)
        self.msb = pattern.match(width_expr).group(1).replace(" ","")   #fetch MSB/LSB and remove space
        self.lsb = pattern.match(width_expr).group(2).replace(" ","")
        self.dw  = 1

    def update(self, width_expr):
        pattern = re.compile(r'\s*(.+):(.+)\s*')
        self.msb = pattern.match(width_expr).group(1).replace(" ","")   #fetch MSB/LSB and remove space
        self.lsb = pattern.match(width_expr).group(2).replace(" ","")

    def paramparse(self, expr, param_lib: ParamLib):
        operand = re.split(r'[\+\-\*\/]',expr)
        operands = []
        for opr in operand:
            bracket_l = ''
            bracket_r = ''
            if "(" in opr:
                bracket_l = '('
                opr=opr.replace("(","")
            if ")" in opr:
                bracket_r = ')'
                opr=opr.replace(")","")

            if opr.isdigit():
                opr_int = str(opr)
            else:
                opr_int = str(param_lib.getvalue(opr))

            operands.append(bracket_l+opr_int+bracket_r)

        r = re.compile(r'\+|\-|\*|\/',flags=re.I | re.X)
        ops = r.findall(expr)
        parse_expr = list(itertools.chain.from_iterable(zip(operands,ops)))+operands[-1:]
        #print(parse_expr)
        return ("".join(parse_expr))

    def cptwidth(self, param_lib: ParamLib):
        self.msb_int = int(eval(self.paramparse(self.msb, param_lib)))
        self.lsb_int = int(eval(self.paramparse(self.lsb, param_lib)))
        #self.lsb_int = 0
        self.dw = self.msb_int - self.lsb_int + 1 
        return ("["+str(self.msb_int)+":"+str(self.lsb_int)+"]")


class PortList():

    def __init__(self, lib=None):
        if type(lib) == df:
            if lib.empty:
                self.lib=df(index=["direction", "width_expr", "width"], columns=["placehodler"])
                self.remove_placehd()
            else:
                self.lib=lib
        elif lib == None:
            self.lib=df(index=["direction", "width_expr", "width"], columns=["placehodler"])
            self.remove_placehd()
        else:
            self.lib=lib

    def add_lib(self, lib_i):
        for port in self.lib.columns:
            if port in lib_i.lib.columns:
                self.lib.rename(columns={port:port+"_old"}, inplace=True)
        self.lib = pd.concat([self.lib,lib_i.lib], axis=1)
        #print(self.lib)

    def add(self, port, direction, width_expr):
#        item = pd.Series([direction, DataWidth(width_expr)], name=port, index=self.lib.index)
        item = pd.Series([direction, width_expr, width_expr], name=port, index=self.lib.index)
        self.lib=pd.concat([self.lib, item], axis=1)
        #print(port)

    def update(self, port, direction, width_expr):
        self.lib[port] = [direction, width_expr, width_expr]

    def updatedw(self, port, width):
        self.lib[port]["width"] = width

    def updatedwexpr(self, port, width_expr):
        self.lib[port]["width_expr"] = width_expr

    def updatedir(self, port, direction):
        self.lib[port]["direction"] = direction

    def remove(self, port):
        self.lib.drop(port, axis=1, inplace=True)

    def remove_placehd(self):
        if "placehodler" in self.lib.columns:
            self.remove("placehodler")

    def getdirection(self, port):
        return self.lib[port]["direction"]
        
    def getwidthexpr(self, port):
        return self.lib[port]["width_expr"]

    def getwidth(self, port):
        return self.lib[port]["width"]

    def getports(self):
        return self.lib.columns

    def checkdw(self, paramlib):
        if "placehodler" in self.lib.columns:
            self.remove("placehodler")
        for port in self.lib.columns:
            self.updatedw(port, DataWidth(self.lib[port]["width_expr"]).cptwidth(paramlib))

    def save(self, path, sheet_name="portlist"):
        self.lib.T.to_excel(path, sheet_name=sheet_name, encoding='utf-8')
        
def pattern_match(pattern, string):
    match = pattern.match(string)
    return match
 
