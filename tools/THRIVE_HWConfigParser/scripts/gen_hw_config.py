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
Script to generate THRIVE Chip-level yaml configuration file.

Code copied from Haoran Li
(Source Code: http://gitlab.alibaba-inc.com/THRIVE/THRIVE-DSE/blob/master/scripts/gen_hw_config.py)
and modifed by Zhe Zhang
'''

import yaml
import argparse
from hw_config import *
import os
import copy

parser = argparse.ArgumentParser()
parser.add_argument('--x', type=int, help='global pe mesh shape x', default=4)
parser.add_argument('--y', type=int, help='global pe mesh shape y ', default=4)
parser.add_argument('--outdir',
                    type=str,
                    help='output directory',
                    default='../configs')
parser.add_argument('--noc', type=str, help='NoC Type {MESH, THRIVE}', choices=['MESH','THRIVE'])
parser.add_argument('--mem_3d', action='store_true', help='Generate 3D Mem or not')

def build_hw_config(pe_mesh_shape=(), noc=noc_type.THRIVE, output_dir='./', mem_3d=False):
    """Generate hardware config file based on given parameters
    """
    assert (len(pe_mesh_shape) == 2), "PEMesh should be 2D."
    global_index = 0
    pe_config = pe_base_config()
    link_config = link_base_config()
    memory_config = memory_base_config()
    config = {'pe': [], 'link': [], 'memory': []}
    num_pes = 1
    for s in pe_mesh_shape:
        num_pes *= s
    print('pe_mesh_shape = ', pe_mesh_shape, ' num_pes = ', num_pes)
    for i in range(pe_mesh_shape[1]):
        for j in range(pe_mesh_shape[0]):
            pe = {
                'index': global_index,
                'computeCapacityTensor': pe_config.computeCapacityTensor,
                'computeCapacityVector': pe_config.computeCapacityVector,
                'memSize': pe_config.memSize,
                'currentMem': 0,
                'currentOpIndex': -1,
                'isBusy': False,
                'name': "thrive_pe_{}_{}".format(j,i),
                'type': "thrive_pe",
                'x': j,
                'y': i
            }
            config['pe'].append(pe)
            global_index += 1

    if noc == noc_type.MESH:
        for i in range(pe_mesh_shape[0]):
            for j in range(pe_mesh_shape[1]):
                pe_idx = i * pe_mesh_shape[1] + j
                if j < pe_mesh_shape[1] - 1:
                    link_h = {
                        'index': global_index,
                        'src': pe_idx,
                        'dst': pe_idx + 1,
                        'direction': link_config.direction,
                        'bandwidth': link_config.bw,
                        'latency': link_config.latency,
                        'currentBandwidth': 0.0,
                        'isBusy': False
                    }  # horizontal link
                    config['link'].append(link_h)
                    global_index += 1
                if i < pe_mesh_shape[0] - 1:
                    link_v = {
                        'index': global_index,
                        'src': pe_idx,
                        'dst': pe_idx + pe_mesh_shape[1],
                        'direction': link_config.direction,
                        'bandwidth': link_config.bw,
                        'latency': link_config.latency,
                        'currentBandwidth': 0.0,
                        'isBusy': False
                    }  # vertical link
                    config['link'].append(link_v)
                    global_index += 1
                if mem_3d:
                # option: link EVERY pe to dram
                    link_to_dram = {
                        'index': global_index,
                        'src': pe_idx,
                        'dst': -1,
                        'direction': link_config.direction,
                        'bandwidth': link_config.bw,
                        'latency': link_config.latency,
                        'currentBandwidth': 0.0,
                        'isBusy': False
                    }  # link to dram
                    config['link'].append(link_to_dram)
                    global_index += 1
    elif noc == noc_type.THRIVE:
        # n rows
        n = pe_mesh_shape[0]
        # m cols
        m = pe_mesh_shape[1]

        def add_link(src, dst, direction):
            link = {'index': 3, 'src': 0, 'dst': 2, 'direction': ''}
            newLink = copy.copy(link)
            newLink['src'] = src
            newLink['dst'] = dst
            newLink['direction'] = direction
            nonlocal global_index
            newLink['index'] = global_index
            config['link'].append(newLink)
            global_index += 1
            return 0

        def add_link_from_list(link_list, direction):
            for link_pair in link_list:
                (src, dst) = link_pair
                add_link(src, dst, direction)

        if n % 2 != 0:
            print('Error: # of rows must be even')
        if m % 2 != 0:
            print('Error: # of cols must be even')

        links_right2left_red = []
        src = [x * m + 1 for x in range(n)]
        dst = [x * m for x in range(n)]
        for i in range(n):
            links_right2left_red.append((src[i], dst[i]))

        links_left2right_red = []
        src = [x * m - 2 for x in range(1, n + 1)]
        dst = [x * m - 1 for x in range(1, n + 1)]
        for i in range(n):
            links_left2right_red.append((src[i], dst[i]))

        links_top2bottom_red = []
        src = [x for x in range(m)]
        dst = [x for x in range(m, 2 * m)]
        for i in range(m):
            links_top2bottom_red.append((src[i], dst[i]))

        links_bottom2top_red = []
        src = [(n - 1) * m + x for x in range(m)]
        dst = [(n - 2) * m + x for x in range(m)]
        for i in range(m):
            links_bottom2top_red.append((src[i], dst[i]))

        links_right2left_black = []
        for row in range(n):
            for src in range(m * row, m * (row + 1) - 2, 2):
                links_right2left_black.append((src, src + 2))

        links_left2right_black = []
        for row in range(n):
            for src in range(m * (row + 1) - 1, m * row + 1, -2):
                links_left2right_black.append((src, src - 2))

        links_top2bottom_black = []
        for col in range(m):
            for src in range(m + col, m * (n - 2) + col, 2 * m):
                links_top2bottom_black.append((src, src + 2 * m))

        links_bottom2top_black = []
        for col in range(m):
            for src in range(m * (n - 2) + col, m + col, -2 * m):
                links_bottom2top_black.append((src, src - 2 * m))

        add_link_from_list(links_right2left_red, "X")
        add_link_from_list(links_left2right_red, "X")
        add_link_from_list(links_top2bottom_red, "Y")
        add_link_from_list(links_bottom2top_red, "Y")

        add_link_from_list(links_right2left_black, "X")
        add_link_from_list(links_left2right_black, "X")
        add_link_from_list(links_top2bottom_black, "Y")
        add_link_from_list(links_bottom2top_black, "Y")

        for row in range(n):
            for col in range(m):
                pe_idx = row * m + col
                add_link(pe_idx, -1, 'Z')

    else:
        print("error: Unsupported NoC type")

    memory = {'index': -1, 'memSize': memory_config.memSize, 'currentData': []}
    config['memory'].append(memory)
    shape_str = ""
    for s in pe_mesh_shape:
        shape_str += str(s)
        shape_str += "_"
    hw_config_file_fir = shape_str + "_" + noc.name + ".yaml"
    with open(os.path.join(output_dir, hw_config_file_fir), 'w+') as file:
        yaml.dump(config, file)
        print("dumped hw config to ", hw_config_file_fir)
    return config


def main():
    args = parser.parse_args()
    pe_mesh_shape = (args.x, args.y)
    if args.noc == None:
        noc = noc_type["MESH"]
    else:
        noc = noc_type[args.noc]
    
    output_dir = args.outdir
    print(noc.name)
    config = build_hw_config(pe_mesh_shape, noc, output_dir, args.mem_3d)

    print('\n>>>>>> PE, total=', len(config['pe']))
    for pe in config['pe']:
        print(pe)
    print('\n>>>>>> Link, total=', len(config['link']))
    for link in config['link']:
        print(link)
    print('\n>>>>>> Memory, total=', len(config['memory']))
    for memory in config['memory']:
        print(memory)
    # print(construct_gpgpu_system())


if __name__ == "__main__":
    main()
