while read line
do
    echo $line
    if [ -z "$line" ]
    then
       	echo "Done" > out_pipe
	exit 0
    fi
done
