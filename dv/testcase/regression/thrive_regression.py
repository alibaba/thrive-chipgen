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
Used for THRIVE homo_2_1 project regression script
'''

import os
import subprocess
from os.path import exists
import getpass
import time

# "testcase name": "--vpu" # if vpu enabled
testcase_smoke = {
    "smoke_test": "--vpu",
}

testcase = {**testcase_smoke}

user_name = getpass.getuser()
os.system("killall -u {0} screen".format(user_name))
os.system("rm -rf *.log")
os.chdir("../../../")
os.system("rm -rf ./dv/workdir/default_workdir/")

# Compile RTL only
start_time = time.time()
for test in testcase_smoke:
    cmd = "screen -dmS {} csh -c '{}'"
    cmd_str = [
        "sleep 5",
        "source ./sourceme.csh",
        "cd ./dv/testcase/regression",
        "python $DV_TOP/script/run_case.py --opt --update -t {0} {1} --nosim --no_comp_c | tee {0}.log".format(test, testcase_smoke[test]),
        "exec csh"
    ]
    cmd = cmd.format(test, " && ".join(cmd_str))
    print(cmd)
    os.system(cmd)
    break # only compile once

class FileNotExistErr(Exception):
    pass

while True:
    try:
        if exists("./dv/workdir/default_workdir/tb_simv"):
            os.system("killall -u {0} screen".format(user_name))
            break
        else:
            raise FileNotExistErr
    except FileNotExistErr:
        if os.system("screen -ls | grep 'No Sockets found'") == 0: # process in screen finished or failed
            print("[\033[31mWARNING\033[0m] Compilation failed!")
            break
        print("Waiting for creating a shared simv...")
        for i in range(5):
            print('.', end='', flush=True)
            os.system("sleep 2")
        print("\n")
        continue

rtl_compile_end_time = time.time()

# Run regression
cmd_list = []
for test in testcase:
    print("\n-- {0} started...  --".format(test))
    cmd = "screen -dmS {} csh -c '{}'"
    cmd_str = [
        "sleep 5",
        "source ./sourceme.csh",
        "cd ./dv/testcase/regression",
        "python $DV_TOP/script/run_case.py --opt --nodump -t {0} {1} | tee {0}.log".format(test, testcase[test]),
        "exec csh"
    ]
    cmd = cmd.format(test, " && ".join(cmd_str))
    print(cmd)
    cmd_list.append(cmd)

for cmd in cmd_list:
    os.system(cmd)

# Finish Monitor
done = 0
while done < len(testcase):
    if os.system("screen -ls | grep 'No Sockets found'") == 0: # process in screen finished or failed
        print("[\033[31mWARNING\033[0m] Regression failed!")
        break

    for i in range(5):
        print('.', end='', flush=True)
        os.system("sleep 2")
    print("\n")

    done = 0
    for test in testcase:
        try:
            ret = subprocess.check_output(["grep", "-inr", "V C S   S i m u l a t i o n   R e p o r t", "./dv/testcase/regression/{0}.log".format(test)])
            done += 1
        except subprocess.CalledProcessError as err:
            print("test-{0} is still running...".format(test))

if done == len(testcase):
    print("==================================================================")
    print("                        All tests are done.")
    print("==================================================================")
    for test in testcase:
        try:
            ret = subprocess.check_output(["grep", "-inr", "Simulation finished successfully", "./dv/testcase/regression/{0}.log".format(test)])
            print("[\033[32mPASS\033[0m] Testcase {0} PASS. ".format(test))
        except subprocess.CalledProcessError as err:
            print("[\033[31mFAIL\033[0m] Testcase \033[31m{0}\033[0m FAIL!! ".format(test))
    os.system("killall -u {0} screen".format(user_name))

regression_end_time = time.time()

print("\n")
print("Total Time:       {}".format(regression_end_time-start_time))
print("Compilation Time: {}".format(rtl_compile_end_time-start_time))
print("Regression Time:  {}".format(regression_end_time-rtl_compile_end_time))
