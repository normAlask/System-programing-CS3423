#!/usr/bin/env python3
import sys
import os
import re
left, right, keys = "[[", "]]", ["dept_code", "dept_name", "course_name", "course_start", "course_end", "credit_hours", "num_students", "course_num", "date"]
if len(sys.argv) == 5 or len(sys.argv) == 7 and os.path.isdir(sys.argv[1]):
    if len(sys.argv) > 5: left, right = sys.argv[5], sys.argv[6]
    if not os.path.isdir(sys.argv[4]): os.mkdir(sys.argv[4])
    for files in os.listdir(sys.argv[1]):
        if re.match("[A-Z]{2,3}[0-9]{4}.crs", files):
            with open(sys.argv[1] + "/" + files, "r+") as crsFile:
                crsData = crsFile.readlines(); variableList = [crsData[0].split()[0], " ".join(crsData[0].split()[1:]), " ".join(crsData[1].split()), crsData[2].split()[1], crsData[2].split()[2], "".join(crsData[3].split()), "".join(crsData[4].split()), re.search("([0-9]{4})", crsFile.name).group(1), sys.argv[3]]
                if int(variableList[6]) > 50:
                    with open(sys.argv[4] + "/" + variableList[0] + variableList[-2] + ".warn", "w+") as outfile, open(sys.argv[2]) as template:
                        for line in template:
                            for count in range(9):
                                line = line.replace(left+keys[count]+right, variableList[count])
                            outfile.write(line)
# Author: Ariel Guerrero
# Assignment 5: More Scripting - Python Edition

