#!/bin/bash
sed -r -i.save "s/<date>/$(date "+%m")\/$(date "+%d")\/$(date "+%Y")/g" $1
sed -i -r -f script.sed $1 
