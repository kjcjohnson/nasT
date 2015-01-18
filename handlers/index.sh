URL="/"
TEMPLATE_IN="views/index.st"
TEMPLATE_OUT="views/index.html"
RENDER="./render.sh"
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

##Example
##  

cat headers/HTTP200OK
$RENDER $TEMPLATE_IN $TEMPLATE_OUT title nasT type MVC
cat $TEMPLATE_OUT
