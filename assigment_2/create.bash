#!/bin/bash



read dept_code
read dept_name
read course_number
read course_name
read course_schedule
read -r course_start
read -r course_end
read course_hours
read course_size

filename=${dept_code^^}$course_number.crs

if test -f ./data/$filename; then
    echo "ERROR: course already exists"
else
    echo -e "${dept_code^^} $dept_name\n$course_name\n$course_schedule $course_start $course_end\n$course_hours\n$course_size" \
    > ./data/${dept_code^^}$course_number.crs

    echo "`date` CREATED: ${dept_code^^} $course_number $course_name" >> ./data/queries.log
fi


