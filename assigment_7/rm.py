#!/usr/bin/env python3
import os
import sys
if not os.path.exists("rm_trash"): #makes data directory if doesn't exist
        os.makedirs("rm_trash")

for input in sys.argv:
    if input =='-r':
        print("hi")
