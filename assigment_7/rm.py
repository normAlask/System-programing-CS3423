#!/usr/bin/env python3
import os
import re
import sys
import ntpath
from builtins import str, IOError, open
from os.path import expanduser

home = expanduser("~")
TextTracker = open(home+"/rm_trash/"+".Database.txt","a+")

if not os.path.exists(home+"/rm_trash"):
        os.makedirs(home+"/rm_trash")

dashR = False
while "-r" in sys.argv:
    dashR = True
    sys.argv.remove("-r")
try:
    for Argument in sys.argv[1:]:
        Argument = re.sub("/+$","",Argument)
        FilesName = ntpath.basename(Argument)
        first = os.path.splitext(FilesName)[0]
        last = os.path.splitext(FilesName)[1]
        if os.path.isdir(Argument) and dashR == False:
            sys.stderr.write("rm.py: cannot remove:'"+Argument+"' Is a directory\n")
            continue
        counter = 1
        targetfile = home+"/rm_trash/" + FilesName
        while os.path.exists(targetfile):
            targetfile = home+"/rm_trash/" + first + "-" + str(counter) + last
            counter += 1
        os.rename(Argument, targetfile)
        TextTracker.write(os.path.abspath(Argument)+" "+ targetfile+"\n")
except IOError:
    sys.stderr.write("cannot remove '"+Argument+"': No such file or directory\n")
