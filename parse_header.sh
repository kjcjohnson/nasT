#!/bin/bash
#;;//This parses header
#while read line
#do 
    
#done
read line
method=`echo $line | grep -o -w 'GET\|POST\|PUT\|DELETE'`
#echo Method: $method
fullurl=`echo $line | head -n 1 | cut -d " " -f 2`
#echo Fullurl: $fullurl
if [ "$method" = "GET" ] 
then
    #echo "GET"
    params=`echo $fullurl | grep -o '?.*' | cut -c 2-` 
fi
if [ "$method" = "POST" ] 
then
    #echo "POST"
    params=`tail -n 1 header.file`
fi

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

#echo ${keys[*]}
#echo ${values[*]}

cat headers/HTTP200OK ../../testform.html > /tmp/f

