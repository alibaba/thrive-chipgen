/* 
*Copyright (c) 2021, Alibaba Group;
*Licensed under the Apache License, Version 2.0 (the "License");
*you may not use this file except in compliance with the License.
*You may obtain a copy of the License at

*   http://www.apache.org/licenses/LICENSE-2.0

*Unless required by applicable law or agreed to in writing, software
*distributed under the License is distributed on an "AS IS" BASIS,
*WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*See the License for the specific language governing permissions and
*limitations under the License.
*/


#define SND_PKT_RID(local_tile_id, remote_tile_id, packet_id)   \
    ((long long)(packet_id & 0xffffffff))    <<  32  | \
    ((long long)(remote_tile_id & 0x3ff))    <<  14  | \
    ((long long)(local_tile_id & 0x3ff))     <<  4   | \
    (long long)0x2

#define SND_PKT(packet_data_size, packet_data_addr, packet_head_size, packet_head_addr) \
    ((long long)(packet_head_addr & 0x3ffc00))  >>10    <<  40  | \
    ((long long)(packet_head_size & 0xff))              <<  32  | \
    ((long long)(packet_data_addr & 0x3ffc00))  >>10    <<  10  | \
    ((long long)(packet_data_size & 0x3f))              <<  4   | \
    (long long)0x3

#define RCV_PKT_RID_RSP(local_tile_id, remote_tile_id, packet_id)   \
    ((long long)(packet_id & 0xffffffff)    <<  32)  | \
    ((long long)(remote_tile_id & 0x3ff)    <<  14)  | \
    ((long long)(local_tile_id & 0x3ff)     <<  4)   | \
    0x5

#define RCV_PKT_RSP(packet_data_size, packet_data_addr, packet_head_size, packet_head_addr) \
    ((long long)(packet_head_addr & 0xfff)  <<  40)  | \
    ((long long)(packet_head_size & 0xff)   <<  32)  | \
    ((long long)(packet_data_addr & 0xfff)  <<  10)  | \
    ((long long)(packet_data_size & 0x3f)   <<  4)   | \
    0x6

//#define RCV_PKT_RSP(packet_data_size, packet_data_addr, packet_head_size, packet_head_addr) \
    ((long long)(packet_head_addr & 0x3ffc00))  >>10    <<  40  | \
    ((long long)(packet_head_size & 0xff)   <<  32)  | \
    ((long long)(packet_data_addr & 0x3ffc00))  >>10    <<  10  | \
    ((long long)(packet_data_size & 0x3f)   <<  4)   | \
    0x6

#define SND_PKT_RSP(status, err_code, packet_id)    \
    ((long long)(packet_id & 0xffffffff)    << 32)  | \
    ((long long)(err_code & 0x1f)           << 5)   | \
    ((long long)(status & 0x1)              << 4)   | \
    (long long)0x2

