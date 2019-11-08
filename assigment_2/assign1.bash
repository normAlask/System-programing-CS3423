#!/bin/bash

echo ""> data/queries.log


go=0
while [ $go ]; do
echo "please enter your choice or CTRL-D"
echo "C - create a new course record"
echo "R - read an existing course record"
echo "U - update an existing course record"
echo "D - delete an existing course recor"
echo "E - update enrolled student count of existing course"
echo "T - show total course count"
    if ! read ans; then
        
        break
    fi 
    
    case "$ans" in
        [Cc])
            chmod u+x create.bash
            ./create.bash
        ;;
        [Rr])
            chmod u+x read.bash
            ./read.bash
        ;;
        [Uu])
            chmod u+x update.bash
             ./update.bash
        ;;
        [Dd])
            chmod u+x delete.bash
             ./delete.bash
        ;;
        [Ee])
            chmod u+x enroll.bash
             ./enroll.bash
        ;;
        [Tt])
            chmod u+x total.bash
           ./total.bash
        ;;
        
        *) echo "please enter one of the option from the list upove"
        ;;
    esac
done


