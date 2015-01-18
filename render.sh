#!/bin/bash
INFILE=$1
OUTFILE=$2

data_v=()
data_k=()

i=1;
for arg in "$@" 
do
    if [ $i -le 2 ] 
    then
	i=$((i+1))
	continue;
    fi
    if [ $(($i % 2)) -eq 0 ]
    then
	data_v+=($arg);
    else
	data_k+=($arg);
    fi
    i=$((i+1))
done

`cp $INFILE $OUTFILE`

for i in `seq 0 $((${#data_k[*]} - 1))`; 
do
    echo "[[$i]]> Looking for: ${data_k[$i]} to replace with: ${data_v[$i]}"
    sed -i "s/<%${data_k[$i]}%>/${data_v[$i]}/g" $OUTFILE
done 
