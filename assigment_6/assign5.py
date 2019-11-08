#!/usr/bin/env python3
#written by Noor Alaskari
#instructor: Dr. Sam Silvestro
#Date: 10/28/2019
import shutil
import os
import sys
import glob
import re
#check if the argumant passed to the program is either 5 or 7 other wise return Error 
if len(sys.argv) != 5 and len(sys.argv) != 7:
    print("Usage: " + sys.argv[0] + " <data directory> <template><date><output directory><optional replacement for leftsided double brackets><optional replacement for rightsided double brackets>")
sys.exit(1)

if not os.path.exists(sys.argv[1]): #makes data directory if doesn't exist
    os.makedirs(sys.argv[1])

if not os.path.exists(sys.argv[4]): #makes output directory if doesn't exist
   os.makedirs(sys.argv[4])

#check if argument passed, if 5 only then set [[ ]] as the left and rigth. other wise user decied 
if len(sys.argv)==5:
    left="[["
    right="]]"
else: 
    left=sys.argv[6]
    right=sys.argv[7]


#try if works then implement the functios otherwise return erroer 
try:
#search for the files in the dir that was specifed by the user that end with .crs 
    for flies in glob.glob(sys.argv[1] + "/*.crs"):
        with open(flies, "r") as here:#open rhe the files and read the informatin inside of the files and place them list
            read = here.readlines()
            dept_code = read[0].split()[0]#reading the department code
            dept_name =" ".join( read[0].split()[1:]) #reading the department Name
            course_name= read[1].replace("\n","")#replace the course name
            course_start= read[2].split()[1]
            course_end= read[2].split()[2]
            crdit_hourse= read[3].split()[0]
            people_num= read[4].replace("\n","")
            course_num=re.search("[0-9]{4}", flies).group(0)
            if int(people_num) > 50:#read the files that have student number larger than 50
                with open(sys.argv[4]+"/"+ course_num + ".warn","w+")as f:#open file and save it with .warn
                    with open(sys.argv[2] , "r") as temp:#
                         for line in temp:
                             replaced=line.replace(left+"dept_code"+right,dept_code)
                             replaced=replaced.replace(left+"dept_name"+right,dept_name)
                             replaced=replaced.replace(left+"course_name"+right,course_name)
                             replaced=replaced.replace(left+"course_start"+right,course_start)
                             replaced=replaced.replace(left+"course_end"+right,course_end)
                             replaced=replaced.replace(left+"num_students"+right,people_num)
                             replaced=replaced.replace(left+"course_num"+right,course_num)
                             replaced=replaced.replace(left+"credit_hours"+right,crdit_hourse)
                             replaced=replaced.replace(left+"date"+right,sys.argv[3])
                             f.write(replaced)


except IOError:
    print("IOError")
