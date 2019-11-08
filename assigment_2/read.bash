#!/bin/bash
function readVar()
{
    read dept_code dept_name
    read course_name
    read course_sched course_start course_end
    read course_hours
    read course_size
}


read -p "Enter the Department Code and number: " dept_code course_num


filename=${dept_code^^}${course_num}.crs 

if [ ! -e "data/$filename" ]; then
    echo "ERROR: course does not exists"
    exit 1

else 

      readVar < data/$filename

         echo " Course department: $dept_code $dept_name"
         echo " Course number: $course_num"
         echo " Course name: $course_name"
         echo " Scheduled days: $course_sched"
         echo " Course start: $course_start"
         echo " Course end: $course_end"
         echo " Credit hours: $course_hours"
         echo " Enrolled Students: $course_size"
    fi
