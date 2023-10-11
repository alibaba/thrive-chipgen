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

#include "func.h"
#include "xocc_asm.h"
#include "dsa.h"
#include "nou.h"
#include "nou_pkt.h"

#define SND_PKT_ID  ${tc["SND_PKT_ID"]}
#define RCV_PKT_ID  ${tc["RCV_PKT_ID"]}
#define LOCAL_PE_ID ${tc["LOCAL_PE_ID"]}
#define SND_PE_ID   ${tc["SND_PE_ID"]}
#define RCV_PE_ID   ${tc["RCV_PE_ID"]}

int main() {
    long long nou_xocc_cmd[] = {
        SND_PKT_RID(LOCAL_PE_ID, SND_PE_ID, SND_PKT_ID),
        SND_PKT(SND_PKT_DATA_SIZE, SND_PKT_DATA_ADDR, SND_PKT_HEADER_SIZE, SND_PKT_HEADER_ADDR)
    };

    long long nou_xocc_rsp[] = {
        SND_PKT_RSP(0, 0, SND_PKT_ID),
        RCV_PKT_RID_RSP(LOCAL_PE_ID, RCV_PE_ID, RCV_PKT_ID),
        RCV_PKT_RSP(RCV_PKT_DATA_SIZE, RCV_PKT_DATA_ADDR, RCV_PKT_HEADER_SIZE, RCV_PKT_HEADER_ADDR)
    };

    int cmd_num = sizeof(nou_xocc_cmd) / sizeof(long long); 
    int rsp_num = sizeof(nou_xocc_rsp) / sizeof(long long);
    long long rsp;
    unsigned int rsp_w0, rsp_w1;

    // Send packet
    for (int i=0; i<cmd_num; i++) {
        dispatcher_push_nou_cmd((unsigned int)(nou_xocc_cmd[i] & 0x00000000ffffffff),(unsigned int)((nou_xocc_cmd[i] & 0xffffffff00000000) >> 32));
    }

    int err_num = 0;
    for (int i=0; i<rsp_num ; i++) {
        dispatcher_pop_nou_rsp(&rsp_w0, &rsp_w1);
        rsp = ((long long)rsp_w1) << 32 | ((long long)rsp_w0);
        err_num += 1;
        for (int j=0; j<rsp_num; j++) {
            if (rsp == nou_xocc_rsp[j]) {
                err_num -= 1;
            }
        }
    }
    if (err_num != 0) finish(FAIL);

    // Self-check
    char *rcv_header_addr = RCV_PKT_HEADER_ADDR_SHIFTED;
    int *rcv_data_addr = RCV_PKT_DATA_ADDR_SHIFTED;

    char *golden_header_addr = GOLDEN_PKT_HEADER_ADDR;
    int *golden_data_addr = GOLDEN_PKT_DATA_ADDR;

    int rcv_header_byte = RCV_PKT_HEADER_SIZE + 1;
    int rcv_data_Kbyte = RCV_PKT_DATA_SIZE + 1;

    char golden_header, rcv_header;
    for (int i=0; i<(int)(rcv_header_byte*8/8); i++) {
        rcv_header = *rcv_header_addr;
        golden_header = *golden_header_addr;
        if (rcv_header != golden_header) finish(FAIL);
        rcv_header_addr += 1;
        golden_header_addr += 1;
    }

    int golden_data, rcv_data;
    for (int i=0; i<(int)(rcv_data_Kbyte*1024*8/32); i++) {
        rcv_data = *rcv_data_addr;
        golden_data = *golden_data_addr;
        if (rcv_data != golden_data) finish(FAIL);
        rcv_data_addr += 1;
        golden_data_addr += 1;
    }

    finish(PASS);
    return 0;
}
