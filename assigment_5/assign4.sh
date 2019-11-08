#!/bin/bash
#Noor Alaskari

readVar()
{ #this function will read the information from the file 
   read dept_code dept_name
   read course_name 
   read course_sched course_start course_end
   read course_hours
   read course_size
} 
# this will check the number of pram follow the correct formala
if [[ $# -ne 4 && $# -ne 6 ]]; then
    echo "Sorry you are missing parmters"
    exit 1

fi

data=$1 # set the $1 (first pram) to var called data
temp=$2  # set the $2 (seconed pram) to var called temp
date=$3   # set the $3 (third  pram) to var called date
output=$4   # set the $1 (forth  pram) to var called output
leftbrace="\\"$5  # set the $5 (fifth  pram) to var called leftbrace
rightbrace="\\"$6   # set the $6 (sixth pram) to var called data

ls -f $data |  while read file # wille loop will untill the all  files matchs  

do   
        if [[ $file =~ [A-Z]{2,3}[0-9]{4}.crs ]]; then # read only files that match this format 
        OrgDir=$PWD # set the origanal dirctory to a  var 
           readVar < $data/$file # read the information insid file to the function

           course_num=` echo $file | sed -r "s/[A-Z]{2,3}([0-9]{4}).crs/\1/g"` # get the course number for futher use 
    
          if [[ $course_size -gt 50 ]]; then  # if statment will acceprt filrs that have only course size  grater than 50 
                                              
            filename=${dept_code^^}${course_num}.warn #set the new file name 

            cat $temp > $filename   # putiing the information of template inside the new filename

            if [[ -d $OrgDir/$output ]]; then  # if statment make sure that the dirctory exist if not make one 
                mv $filename   $OrgDir/$output # move the new-file to the right dirctory  
                cd $OrgDir/$output # change the directory to go to outout
            else
                mkdir -p $OrgDir/$output
                mv $filename   $OrgDir/$output 
                cd $OrgDir/$output


            fi

            if [[ $# -ge 5 ]]; then   # if statemnet to make sure the number of pram is 5 or grater 

             #sed statment to edit the information in the temp
             sed -r -i -e "{  
                           s/${leftbrace}dept_code${rightbrace}/$dept_code/g
                           s/${leftbrace}dept_name$rightbrace/$dept_name/g
                           s/${leftbrace}course_name$rightbrace/$course_name/g
                           s/${leftbrace}course_hours$rightbrace/$course_hours/g
                           s/${leftbrace}num_students$rightbrace/$course_size/g
                           s/${leftbrace}course_num$rightbrace/$course_num/g
                           s-${leftbrace}course_start$rightbrace-$course_start-g
                           s-${leftbrace}course_end$rightbrace-$course_end-g
                           s-${leftbrace}date${rightbrace}-$date-g
                        }" $filename
                cd $OrgDir  # change the dirctory back to the origanl dirctory 
     else


            sed -r -i -e "{
                            s/\[\[dept_code\]\]/$dept_code/g
                            s/\[\[dept_name\]\]/$dept_name/g
                            s/\[\[course_name\]\]/$course_name/g
                            s/\[\[course_hours\]\]/$course_hours/g
                            s/\[\[num_students\]\]/$course_size/g
                            s/\[\[course_num\]\]/$course_num/g
                            s-\[\[course_start\]\]-$course_start-g
                            s-\[\[course_end\]\]-$course_end-g
                            s-\[\[date\]\]-$date-g

                      }" $filename

                      cd $OrgDir
          fi
       fi
fi
 done  
