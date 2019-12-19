#!/usr/bin/env python3
import ntpath
import os
import sys
from builtins import open, list, str, dict
from os.path import expanduser

home = expanduser("~")

with open(home+"/rm_trash/.Database.txt","r") as database:
        lines = database.readlines()
        database = list()
        for Argument in sys.argv[1:]:
            for line in lines:
                first = line.split()[0]
                last = "".join(line.split()[1])
                FilesName = ntpath.basename(Argument)
                targetfile = home+"/rm_trash/"+ FilesName
                if targetfile == last:
                    os.rename(last,first)
                with open(home+"/rm_trash/.Database.txt", "w") as f:
                    for line in lines:
                        if line.strip("\n") != Argument+last:
                            f.write(line)
