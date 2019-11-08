#!/bin/bash


#the following function takes in the data from the file 
get_var () {
    read dept_code dept_name 
    read course_name
    read course_schedule course_sdate course_edate
    read course_hours
    read course_enrollment
    }

#this function is devoted to updating the third line of the file.
third_line()
{
   #third_ line < $uCourse_schedule $uCourse_sdate $uCourse_edate $course_schedule $course_sdate $course_edate
   #thinking about not passing in the last variables because i want to see if var variables are available here
    uCourse_schedule=$1
    uCourse_sdate=$2
    uCourse_edate=$3

   #The order will be uCourse_schedule uCourse_sdate uCourse_sDate
    
    if test -z "$uCourse_schedule";then
    #Checks to see if the course shedule is blank
        #O _ _
        if test -z "$uCourse_sdate";then
        #check to see if course date is blank
            #O O _
            if test -z "$uCourse_edate";then
            #check to see if the end date is blank
            #O O O
                echo "$course_schedule $course_sdate $course_edate" >> ./data/$filename
            else
            #This means that the user wants to change only the end date
            #O O U
                echo "$course_schedule $course_sdate $uCourse_edate" >> ./data/$filename
            fi
        else
        #this means that the user wants to change the start date
        #now I need to check to see if the user also wants to change the end date
            if test -z "$uCourse_edate"; then
            #this means that the user only wants to change the start date
                echo "$course_schedule $uCourse_sdate $course_edate" >> ./data/$filename
            else
            #this means that the user wants to change the start date and the end date
                #O U U
                echo "$course_schedule $uCourse_sdate $uCourse_edate" >> ./data/$filename
            fi
        fi
    else
    #this means that the user wants to change the coure schdeule
    #need to check if they want to change the start and end date
            if test -z "$uCourse_sdate"; then
            #this means that the user does not want to change the course start date
            #need to check to see if user wants to change the end date
                if test -z "$uCourse_edate"; then
                #this means that the user only wants to update the course schedule
                #update original original
                    echo "$uCourse_schedule $course_sdate $course_edate" >> ./data/$filename
                else
                #this means that the user want to change the schedule and the endate
                    echo "$uCourse_schedule $course_sdate $uCourse_edate" >> ./data/$filename
                fi
            else
            #this means that the user wants to change the course schedule and the start date
            #need to check if the user wants to update the end date
                if test -z "$uCourse_edate"; then
                #this means that the user wants to change the schedule and the start date only
                #update update original
                    echo "$uCourse_schedule $uCourse_sdate $course_edate" >> ./data/$filename
                else
                #This means that the user eants to change the schedule and the end date
                    echo "$uCourse_schedule $uCourse_sdate $uCourse_edate" >> ./data/$filename
                fi
            fi
        
    fi
}
#dept_name
#course_number
#file name is dept_code course_num .crs without the spaces

#making the change to at least have the prompt messages appear like assignment says
read -p "Department code:" uDept_code 
read -p "Department name:" uDept_name
read -p "Course number:" uCourse_number
read -p "Course name:" uCourse_name
read -p "Course meeting days:" uCourse_schedule
read -p "Course start date:" uCourse_sdate
read -p "Course end date:" uCourse_edate
read -p "Course credit hours:" uCourse_hours
read -p "Course enrollment" uCourse_enrollment

filename=${uDept_code^^}$uCourse_number.crs

if test -f ./data/$filename; then
    get_var < ./data/$filename

    #Check to see if the file exist first. If not display ERROR: course not found

    #now I have to worry about which variables are blank or not
    #I must have department code and course number

    #This if for the first line in command file
    #just need to check if dept name is blank
    if test -z "$uDept_name"; then
    #this means that the user does not want to update the dept name
        echo "$dept_code $dept_name" > ./data/$filename
    #this means the user does want to update dept name
    else
        echo "$dept_code $uDept_name" > ./data/$filename
    fi
    #-------------------------------------------------------------
    #second line of data file is course name
    #if the string is blank character then use original values
    if test -z "$uCourse_name"; then
        echo "$course_name" >> ./data/$filename
   #this means the user wants to change the course name
   else
        echo "$uCourse_name" >> ./data/$filename
    fi
    #-------------------------------------------------------------
    #third line will be the hardest 
    #third_line function will print the third line of the file it will be passed 6 variables 5 paramaters
    third_line "$uCourse_schedule" "$uCourse_sdate" "$uCourse_edate"
    #-----------------------------------------------------------------------------------------------------
    #fourth line of the data file is just course hours
    if test -z "$uCourse_hours"; then
        #this means to keep the original hours 
        echo "$course_hours" >> ./data/$filename
    else
        #this means to update the hours 
        echo "$uCourse_hours" >> ./data/$filename
    fi
    #-----------------------------------------------------------------------------------------------------
    #last line of the data file. Just need to check to see if course enrollment is updated
    if test -z "$uCourse_enrollment"; then
        #this means to keep original course enrollment
        echo "$course_enrollment" >> ./data/$filename
    else
        #this means to update the course enrollment
        echo "$uCourse_enrollment" >> ./data/$filename
    fi
    #------------------------------------------------------------------------------------------------------
    #this is the end of the file update system. Now I just need to updat the log to show the user updated the file and to supply the date

    #updating the log thing
    #need to check if the course name was changed if it was save the updated course name to the queries.log file
    if test -z "$uCourse_name"; then
    #this means the user wants to keep the original course_name
        echo "`date` UPDATED: ${dept_code^^} $uCourse_number $course_name" >> ./data/queries.log
    else
    #this means the user wants to update the course name
        echo "`date` UPDATED: ${dept_code^^} $uCourse_number $uCourse_name" >> ./data/queries.log
    fi
else
    echo "ERROR: course not found"
fi
