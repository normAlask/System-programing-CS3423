#!/bin/bash

num1=$1
num2=$2
if [ $# -eq 0 ]; then
    read -p "Enter Num1:  " num1
    read -p "Enter num2:  " num2
    fi
    if [ $# -eq 1 ]; then
        read -p "Enter Num2:  " num2
        fi
     while [ $num2 -eq 0 ]; do
        read -p "Enter something thats not 0." num2
    done



go=0
while [ $go ]; do
    echo " enter what you what opration you want to do?"
    echo " A) sum"
    echo " b) product" 
    echo " c) diffrence" 
    echo " d) div" 
    echo " e) mod"
    echo " f) Power"
    if ! read ans; then
         # got EOF
          break
           fi
case "$ans" in    

 [Aa])let sum=$num1+$num2

echo "sum = $sum"
;;
[Bb])let prod=$num1*$num2
echo "product = $prod"
;;
[Cc])let diff=$num1-$num2
echo "the diff = $diff"
;;
 [Dd])let div=$num1/$num2

echo "div = $div"
;;
[Ee])let mod=$num1%$num2
echo "mod = $mod"
;;
[Ff])let power=$num1**$num2
echo "power = $power"
;;
*) echo "pick one of this option ubove"
esac
done

