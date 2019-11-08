#!/bin/bash

get_var()
{
    read rdept_code dept_name
    read course_name
    read course_schedule course_sdate course_edate
    read course_hours
    read course_enrollment
}
#prompt for course department code and course number
echo "Enter a course department code and number:"
read dept_code course_num
filename=${dept_code^^}$course_num.crs
#prompt user for the amount they want to change the enrollment by
echo "Enter an enrollment change amount:"
read enrollment_change

if test -f ./data/$filename; then
    get_var < ./data/$filename
    let new_enrollment=$course_enrollment+$enrollment_change
    echo "${dept_code^^} $dept_name" > ./data/$filename
    echo "$course_name" >> ./data/$filename
    echo "$course_schedule $course_sdate $course_edate" >> ./data/$filename
    echo "$course_hours" >> ./data/$filename
    echo "$new_enrollment" >> ./data/$filename

    echo "`date` ENROLLMENT: ${dept_code^^} $course_num $course_name changed by $enrollment_change" >> ./data/queries.log

else
    echo "ERROR: course not found"
fi
