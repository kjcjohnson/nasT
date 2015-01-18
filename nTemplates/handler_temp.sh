URL="/home"
METHOD=$1
data_k=()
data_v=()

i=1;
for arg in "$@" 
do
    if [ $i -eq 1 ] 
    then
	i=$((i+1))
	continue;
    fi
    if [ $(($i % 2)) -eq 1 ]
    then
	data_v+=($arg);
    else
	data_k+=($arg);
    fi
    i=$((i+1))
done

echo "URL: $URL"
echo "METHOD: $METHOD"
echo "KEYS: ${data_k[*]}"
echo "VALUES: ${data_v[*]}"

###### DON'T EDIT ABOVE HERE ######
# unless you know what you're doing 

