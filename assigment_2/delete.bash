#!/bin/bash

read -p "Enter the Department Code and number: " dept_code course_num
dept_code=${dept_code^^}

filename=${dept_code^^}${course_num}.crs

if [  -e "data/$filename" ]; then
    rm -r "data/$filename"
     echo "`date` DELETED: ${dept_code^^} $course_num $course_name" >> ./data/queries.log
         echo "$course_number was successfully deleted."


    else
        echo "ERROR: course not found"
        exit 1
        fi
