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

homo_2_2:
	python tcg.py --rv --config="../configs/2_2_thrive_homo/thrive_pe.yaml" --path="../../../design/src_rtl/cpu"
	python tcg.py --rvc --config="../configs/2_2_thrive_homo/thrive_pe.yaml"
	python tcg.py --xbar --config="../configs/2_2_thrive_homo/thrive_pe.yaml" --path="../../../design/src_rtl/xbar"
	python tcg.py --pe --config="../configs/2_2_thrive_homo/thrive_pe.yaml"
	python tcg.py --chip --config="../configs/2_2_thrive_homo/thrive_chip.yaml"
	python tcg_tb.py --tb --config="../configs/2_2_thrive_homo/" --path="../../../dv/tb"
	python tcg_sw.py --sw --config="../configs/2_2_thrive_homo/" --path="../../../sw"
	python tcg_tc.py --tc --config="../configs/2_2_thrive_homo" --path="../../../dv/testcase" --case_name="autogen_homo_2_2"
	cp ../configs/2_2_thrive_homo/thrive_chip.yaml ../../../dv/script/

demo:
	python tcg.py --rv --config="../configs/2_2_homo_demo/thrive_pe.yaml" --path="../../../design/src_rtl/cpu"	
	python tcg.py --rvc --config="../configs/2_2_homo_demo/thrive_pe.yaml"
	python tcg.py --xbar --config="../configs/2_2_homo_demo/thrive_pe.yaml" --path="../../../design/src_rtl/xbar"
	python tcg.py --pe --config="../configs/2_2_homo_demo/thrive_pe.yaml"
	python tcg.py --chip --config="../configs/2_2_homo_demo/thrive_chip.yaml"
	python tcg_tb.py --tb --config="../configs/2_2_homo_demo/" --path="../../../dv/tb"
	python tcg_sw.py --sw --config="../configs/2_2_homo_demo/" --path="../../../sw"
	python tcg_tc.py --tc --config="../configs/2_2_homo_demo" --path="../../../dv/testcase" --case_name="autogen_homo_2_2_demo"

hetero_tc:
	python tcg.py --rv --config="../configs/2_2_thrive_hetero_testchip" --path="../../../design/src_rtl/cpu"
	python tcg.py --rvc --config="../configs/2_2_thrive_hetero_testchip"
	python tcg.py --xbar --config="../configs/2_2_thrive_hetero_testchip" --path="../../../design/src_rtl/xbar"
	python tcg.py --pe --config="../configs/2_2_thrive_hetero_testchip"
	python tcg.py --chip --config="../configs/2_2_thrive_hetero_testchip/thrive_chip.yaml"
	python tcg_tb.py --tb --config="../configs/2_2_thrive_hetero_testchip/" --path="../../../dv/tb"
	python tcg_sw.py --sw --config="../configs/2_2_thrive_hetero_testchip/" --path="../../../sw"
	python tcg_tc.py --tc --config="../configs/2_2_thrive_hetero_testchip" --path="../../../dv/testcase" --case_name="autogen_hetero_tc"
	cp ../configs/2_2_thrive_hetero_testchip/thrive_chip.yaml ../../../dv/script/

homo_4_4:
	python tcg.py --rv --config="../configs/4_4_thrive_homo" --path="../../../design/src_rtl/cpu"
	python tcg.py --rvc --config="../configs/4_4_thrive_homo"
	python tcg.py --xbar --config="../configs/4_4_thrive_homo" --path="../../../design/src_rtl/xbar"
	python tcg.py --pe --config="../configs/4_4_thrive_homo"
	python tcg.py --chip --config="../configs/4_4_thrive_homo/thrive_chip.yaml"
	python tcg_tb.py --tb --config="../configs/4_4_thrive_homo/" --path="../../../dv/tb"
	python tcg_sw.py --sw --config="../configs/4_4_thrive_homo/" --path="../../../sw"
	python tcg_tc.py --tc --config="../configs/4_4_thrive_homo" --path="../../../dv/testcase" --case_name="autogen_homo_4_4"
	cp ../configs/4_4_thrive_homo/thrive_chip.yaml ../../../dv/script/

homo_9_9:
	python tcg.py --rv --config="../configs/9_9_thrive_homo" --path="../../../design/src_rtl/cpu"
	python tcg.py --rvc --config="../configs/9_9_thrive_homo"
	python tcg.py --xbar --config="../configs/9_9_thrive_homo" --path="../../../design/src_rtl/xbar"
	python tcg.py --pe --config="../configs/9_9_thrive_homo"
	python tcg.py --chip --config="../configs/9_9_thrive_homo/thrive_chip.yaml"
	python tcg_tb.py --tb --config="../configs/9_9_thrive_homo/" --path="../../../dv/tb"
	python tcg_sw.py --sw --config="../configs/9_9_thrive_homo/" --path="../../../sw"
	python tcg_tc.py --tc --config="../configs/9_9_thrive_homo" --path="../../../dv/testcase" --case_name="autogen_homo_9_9"
	cp ../configs/9_9_thrive_homo/thrive_chip.yaml ../../../dv/script/

