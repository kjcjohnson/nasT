URL="/contact"
TEMPLATE_IN="views/contact.st"
TEMPLATE_IN="views/contact.st"
RENDER="./render.sh"
METHOD=$1
data_k=()
data_v=()

echo "$@"

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

#echo "URL: $URL"
#echo "METHOD: $METHOD"
#echo "KEYS: ${data_k[*]}"
#echo "VALUES: ${data_v[*]}"

###### DON'T EDIT ABOVE HERE ########
# unless you know what you're doing # 
#####################################

## Basic usage of this file:
##   database calls
##   webpage generation
##   calling the template processor
##
## Automagic variables:
##   $URL is the page url
##   $METHOD is the request method
##   $TEMPLATE_IN is the template before it is rendered
##   $TEMPLATE_OUT is the rendered html
##   $RENDER is the rendering tool
##   $data_k is an array of the get/post keys
##   $data_v is an array of the get/post values

####################################
## WHEN FINISHED
# To output to the client, echo to standard output
# Note that you must echo an HTTP header first.
# For your convenience, some common header files are available
# in ../headers/ :
#       HTTP200OK
#       HTTP404NOTFOUND
#
# To use just run
#   cat ../headers/HTTP200OK 
##
####################################

if [ "$METHOD" = "POST" ]
then
    echo "${data_v[*]}"
    echo "${data_k[*]}"
    #echo './db/table.sh create  "{data_v[1]}" "${data_v[2]}"'
    ./db/table.sh create "${data_v[0]}" "${data_v[1]}"
    if [ $? -eq 0 ]
    then
	msg='Successful :D'
    else
	./db/table.sh update "${data_v[0]}" "${data_v[1]}"	
	if [ $? -eq 0 ]
	then
	    msg='Successful :D, and good to see you again'
	else
	    msg='Not Successful :('
	fi
    fi
    cat ./headers/HTTP200OK
    $RENDER ./views/thanks.st ./views/thanks.html msg "$msg"
    cat ./views/thanks.html
    exit 0
else
    cat ./headers/HTTP200OK
    cat ./views/contact.html
fi
