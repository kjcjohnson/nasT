#!/bin/bash
##ROUTES!!
##

#read the first line of the header
read line
method=`echo $line | grep -o -w 'GET\|POST\|PUT\|DELETE'`
fullurl=`echo $line | head -n 1 | cut -d " " -f 2`

#now leaf through the rest and look for content-length
while read line
do
    echo $line | grep -q "Content-Length:"
    if [ $? -eq 0 ]
    then
	cl=`echo $line | grep -o '[0-9]*'`
    fi
    #if we get a blank line, break
    echo $line | grep -q "^[[:space:]]*$"
    if [ $? = 0 ]
    then
	break
    fi
done

#if we are getting, then the params are in the URL
if [ "$method" = "GET" ] 
then
    params=`echo $fullurl | grep -o '?.*' | cut -c 2-` 
fi

#if we are posting, then the params are after the header
#  as $cl characters
if [ "$method" = "POST" ] 
then
    read -n $cl params
fi

#tokenize params into space-separated key=value pieces
string=`echo $params | tr '&' '\n'`

#separate keys and values and put them into separate arrays
keys=()
values=()
i=0
for x in $string
do
    keys[$i]=`echo $x | awk -F= '{print $1}'`
    values[$i]=`echo $x | awk -F= '{print $2}'`
    i+=1
done

#################################
## DO NOT EDIT ABOVE THIS LINE ##
#################################

## What we do here is case on the URL to find the appropriate handler

echo $fullurl | grep -q "^/static/"
if [ $? -eq 0 ]
then
    filename=`echo $fullurl | grep -o '^[^?]*'`
    cat headers/HTTP200OK ".$filename" > out_pipe
    exit
fi

./nTemplates/handler_temp.sh $method $keys $values > /tmp/nasTout

cat /tmp/nasTout > out_pipe



