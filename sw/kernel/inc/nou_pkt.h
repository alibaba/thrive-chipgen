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

#define SND_PKT_HEADER_ADDR             0x02050000
#define SND_PKT_DATA_ADDR               0x02060000

#define RCV_PKT_HEADER_ADDR             0x500       // (shifted left 10bit) -> 0x02140000
#define RCV_PKT_DATA_ADDR               0x700       // (shifted left 10bit) -> 0x021C0000

#define RCV_PKT_HEADER_ADDR_SHIFTED     (char *)0x02140000
#define RCV_PKT_DATA_ADDR_SHIFTED       (int *)0x021C0000

#define GOLDEN_PKT_HEADER_ADDR          (char *)0x02380000
#define GOLDEN_PKT_DATA_ADDR            (int *)0x02390000

#define SND_PKT_HEADER_SIZE             211 // 211 + 1 = 212B
#define SND_PKT_DATA_SIZE               0   // 0 + 1 = 1KB
#define RCV_PKT_HEADER_SIZE             211
#define RCV_PKT_DATA_SIZE               0
