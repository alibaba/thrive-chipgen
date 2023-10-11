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


redPrint="\033[31m"
greenPrint = "\033[32m"
yellowPrint = "\033[33m"
bluePrint = "\033[34m"
yellowLinePrint = "\033[1;4;33m"
geenLinePrint = "\033[1;4;32m"
geenBackPrint = "\033[1;4;42m"
endPrint="\033[0m"
#red--echo -e "\033[31m${*}\033[0m"
#green -e "\033[32m${*}\033[0m"

class PrintUtils:
    #checklogger = LoggerUtils.createLogger(__name__, "log/checklogger.log")
    def printRed(self, str):
        print(redPrint+str+endPrint)

    def printGreen(self, str):
        print(greenPrint+str+endPrint)

    def printYellow(self, str):
        print(yellowPrint+str+endPrint)

    def printBlue(self, str):
        print(bluePrint+str+endPrint)

    def printYellowLine(self, str):
        print(yellowLinePrint+str+endPrint)

    def printLine(self, str):
        print(geenLinePrint+str+endPrint)

