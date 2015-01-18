#!/bin/bash
#;;//This parses header

read line
method=`echo $line | grep -o -w 'GET\|POST\|PUT\|DELETE'`
fullurl=`echo $line | head -n 1 | cut -d " " -f 2`

while read line
do
    #echo $line
    echo $line | grep -q "Content-Length:"
    if [ $? -eq 0 ]
    then
	cl=`echo $line | grep -o '[0-9]*'`
    fi
    echo $line | grep -q "^[[:space:]]*$"
    if [ $? = 0 ]
    then
	#echo breaking
	break
    fi
done

#echo "ContentLength: $cl"

if [ "$method" = "GET" ] 
then
    params=`echo $fullurl | grep -o '?.*' | cut -c 2-` 
fi
if [ "$method" = "POST" ] 
then
    #echo POST
    read -n $cl params
    #echo $params
fi
#echo DONE
string=`echo $params | tr '&' '\n'`

keys=()
values=()
i=0
for x in $string
do
    keys[$i]=`echo $x | awk -F= '{print $1}'`
    values[$i]=`echo $x | awk -F= '{print $2}'`
    i+=1
done

#echo "${keys[*]}"

if [ "$method" = "GET" ]  
then 
    cat headers/HTTP200OK ../../testform.html > /tmp/f
fi
if [ "$method" = "POST" ] 
then
    echo "${values[*]}" > /tmp/file
    cat headers/HTTP200OK /tmp/file > /tmp/f
fi


