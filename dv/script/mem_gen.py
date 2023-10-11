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

#!/usr/bin/python3
import re
import os
import argparse

def OptParse():
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', '--pat_file', type=str, default=' ', help='')
    parser.add_argument('-et', '--endian_trans', action='store_true', help='transform endian')
    parser.add_argument('-dwt', '--data_width_trans', action='store_true', help='transform data width')
    parser.add_argument('--merge', action='store_true', help='')
    args = parser.parse_args()
    print('==> Options:',args)
    return args

def endian_transform_rvv(filename):
    pat_file = open(filename+'.pat', 'r');
    mem_file = open(filename+'.mem', 'w');
    lines = pat_file.readlines()
    line_n = 0

    for line in lines:
        chars = line.split()
        mem_file.write('@' + (str(hex(line_n))[2:]).zfill(8) + ' ');
        line_n = line_n + 1
        mem_file.write(chars[1][6:8] + chars[1][4:6] + chars[1][2:4] + chars[1][0:2]+'\n'); 
        mem_file.write('@' + (str(hex(line_n))[2:]).zfill(8) + ' ');
        line_n = line_n + 1
        mem_file.write(chars[2][6:8] + chars[2][4:6] + chars[2][2:4] + chars[2][0:2]+'\n'); 
        mem_file.write('@' + (str(hex(line_n))[2:]).zfill(8) + ' ');
        line_n = line_n + 1
        mem_file.write(chars[3][6:8] + chars[3][4:6] + chars[3][2:4] + chars[3][0:2]+'\n'); 
        mem_file.write('@' + (str(hex(line_n))[2:]).zfill(8) + ' ');
        line_n = line_n + 1
        mem_file.write(chars[4][6:8] + chars[4][4:6] + chars[4][2:4] + chars[4][0:2]+'\n'); 

    pat_file.close();
    mem_file.close();

def endian_transform_new(filename):
    pat_file = open(filename+'.pat', 'r');
    mem_file = open(filename+'.mem', 'w');
    lines = pat_file.readlines()
    line_n = 0

    for line in lines:
        chars = line.split()
        mem_file.write('@' + (str(hex(line_n))[2:]).zfill(8) + ' ');
        line_n = line_n + 1
        mem_file.write(chars[1][6:8] + chars[1][4:6] + chars[1][2:4] + chars[1][0:2]+'\n'); 
        mem_file.write('@' + (str(hex(line_n))[2:]).zfill(8) + ' ');
        line_n = line_n + 1
        mem_file.write(chars[2][6:8] + chars[2][4:6] + chars[2][2:4] + chars[2][0:2]+'\n'); 
        mem_file.write('@' + (str(hex(line_n))[2:]).zfill(8) + ' ');
        line_n = line_n + 1
        mem_file.write(chars[3][6:8] + chars[3][4:6] + chars[3][2:4] + chars[3][0:2]+'\n'); 
        mem_file.write('@' + (str(hex(line_n))[2:]).zfill(8) + ' ');
        line_n = line_n + 1
        mem_file.write(chars[4][6:8] + chars[4][4:6] + chars[4][2:4] + chars[4][0:2]+'\n'); 

    pat_file.close();
    mem_file.close();

def endian_transform(filename):
    pat_file = open(filename+'.pat', 'r');
    mem_file = open(filename+'.mem', 'w');
    lines = pat_file.readlines()

    #line = inst_lines[0]
    #chars = line.split()
    #print(line)
    #print(chars[0])
    #print(chars[1])
    #print(chars[1][0:2])
    #inst_mem_file.write(chars[0] + ' ');
    #inst_mem_file.write(chars[1][2:0] + chars[1][4:2] + chars[1][6:4] + chars[1][8:6]+'\n'); 
    for line in lines:
        chars = line.split()
        mem_file.write(chars[0] + ' ');
        mem_file.write(chars[1][6:8] + chars[1][4:6] + chars[1][2:4] + chars[1][0:2]+'\n'); 

    pat_file.close();
    mem_file.close();
#def data():
#    data_pat_file = open('data.pat', 'r');
#    data_mem_file = open('data.mem', 'w');
#    data_lines = data_pat_file.readlines()
#
#    for line in data_lines:
#        chars = line.split();
#        data_mem_file.write(chars[0] + ' ');
#        data_mem_file.write(chars[1][6:8] + chars[1][4:6] + chars[1][2:4] + chars[1][0:2]+'\n'); 
#
#    data_pat_file.close();
#    data_mem_file.close();
#
def _32to1024(filename):
    f = open(filename+'.mem', 'r');
    f2 = open(filename+'.tmem', 'w');
    write_line_num = 0
    write_line = []
   # line = 'null'
    line = f.readline()
    addr_pre = -2
    addr_cur = 0
    # read_next = 1: record current code, can read next code;
    # read_next = 0: miss one code, fill with '00000000' and do not read next code
    read_next = 0 
    while line:
        line_d = str.strip(line)
        chars = line_d.split()
        addr_cur = int(chars[0][1:],16)
        addr_pre += 1
        if addr_cur - addr_pre == 1:
            write_line.append(chars[1])
            read_next = 1
        else:
            write_line.append('00000000')
            read_next = 0
        for i in range(31): #31 = 1024/8/4 - 1
            if read_next:
                line = f.readline()
                line_d = str.strip(line)
                chars = line_d.split()
                if len(chars) != 0:
                    addr_cur = int(chars[0][1:],16)
                    addr_pre += 1
                    if addr_cur - addr_pre == 1:
                        read_next = 1
                        write_line.append(chars[1])
                    else:
                        write_line.append('00000000')
                        read_next = 0
                else:
                    write_line.append('00000000')
                    read_next = 1
            else:
                addr_pre += 1
                if addr_cur - addr_pre == 1:
                    write_line.append(chars[1])
                    read_next = 1
                else:
                    write_line.append('00000000')
                    read_next = 0

        f2.write("@"+str(hex(write_line_num))[2:]+' ')
        #print(write_line_num)
        for i in range(32):
            f2.write(write_line.pop())
        f2.write('\n')
        write_line = []
        write_line_num+=1
        if read_next:
            line = f.readline()


    f.close()
    f2.close()
    os.system('cp '+filename+'.tmem '+filename+'.mem ')

def _32to512(filename):
    f = open(filename+'.mem', 'r');
    f2 = open(filename+'.tmem', 'w');
    write_line_num = 0
    write_line = []
   # line = 'null'
    line = f.readline()
    addr_pre = -2
    addr_cur = 0
    # read_next = 1: record current code, can read next code;
    # read_next = 0: miss one code, fill with '00000000' and do not read next code
    read_next = 0 
    while line:
        line_d = str.strip(line)
        chars = line_d.split()
        addr_cur = int(chars[0][1:],16)
        addr_pre += 1
        if addr_cur - addr_pre == 1:
            write_line.append(chars[1])
            read_next = 1
        else:
            write_line.append('00000000')
            read_next = 0
        for i in range(15):
            if read_next:
                line = f.readline()
                line_d = str.strip(line)
                chars = line_d.split()
                if len(chars) != 0:
                    addr_cur = int(chars[0][1:],16)
                    addr_pre += 1
                    if addr_cur - addr_pre == 1:
                        read_next = 1
                        write_line.append(chars[1])
                    else:
                        write_line.append('00000000')
                        read_next = 0
                else:
                    write_line.append('00000000')
                    read_next = 1
            else:
                addr_pre += 1
                if addr_cur - addr_pre == 1:
                    write_line.append(chars[1])
                    read_next = 1
                else:
                    write_line.append('00000000')
                    read_next = 0

        f2.write("@"+str(hex(write_line_num))[2:]+' ')
        #print(write_line_num)
        for i in range(16):
            f2.write(write_line.pop())
        f2.write('\n')
        write_line = []
        write_line_num+=1
        if read_next:
            line = f.readline()


    f.close()
    f2.close()
    os.system('cp '+filename+'.tmem '+filename+'.mem ')

def merge_inst(file1, file2, fo):
    f1 = open(file1+'.mem', 'r')
    f2 = open(file2+'.mem', 'r')
    f = open('inst.mem', 'w')
    #write_line_num = int('c000', 16) #512bit uram, 2MB inst+data, 0xc000=(0x30_0000 >> 6)
    #write_line_num = int('c00', 16) #512bit uram, 2MB inst+data, 0xc000=(0x3_0000 >> 6)
    write_line_num = int('800', 16)    #1024bit uram, 192KB inst+data 0x800=(0x40000 >> 7)
    line = f1.readline()
    while line:
        f.writelines(line)
        line = f1.readline()
    line = f2.readline()
    while line:
        line_d = str.strip(line)
        chars = line_d.split()
        f.write('@'+str(hex(write_line_num))[2:]+' '+chars[1]+'\n')
        write_line_num+=1
        line = f2.readline()

    f1.close()
    f2.close()
    f.close()
    os.system('cp '+file1+'.mem'+' ori.'+file1+'.mem')
    os.system('cp inst.mem '+fo+'.mem ')

def main():
    args = OptParse()
    if args.endian_trans:
        endian_transform_new(args.pat_file)
    if args.data_width_trans:
        _32to1024(args.pat_file)
    if args.merge:
        merge_inst("rv_3", "vpu", "rv_3")

if __name__ == '__main__':
    main()

