#this Array set the string date to number so it can be compared later on
#Noor Alaskari 

BEGIN{
    Date["Jan"]=1;
    Date["Feb"]=2;
    Date["Mar"]=3;
    Date["Apr"]=4;
    Date["May"]=5;
    Date["Jun"]=6;
    Date["Jul"]=7;
    Date["Aug"]=8;
    Date["Sep"]=9;
    Date["Oct"]=10;
    Date["Nov"]=11;
    Date["Dec"]=12;
}

$1 ~ /[A-Za-z]{3}[0-9]{3}/{
    if(match(prev, $1)){
    }
    else{
        printf("User: %6s\n", $1)   
    }

    print("\t",$8,$9,$10)
    printf("\n")


    prev = $1}

$5 ~ /[A-Za-z]{3}[0-9]{2}/{
    Date[substr($5,1,3)] substr($5,4,5)

   if (firsTime < $5 && firsTime != $5) 
        { firsTime=$5; first=$0}
}
$5 ~ /[0-9]{2}:[0-9]{2}/ && $1~ /[A-Za-z]{3}[0-9]{3}/ {
   if ($5 > lstTime) { lstTime=$5; last = $0; }

}
END {
    print("earlist  Start Time: ")
    print first
   print("Latest  Start Time: ")
    print last

}
