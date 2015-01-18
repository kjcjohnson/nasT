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

cat ../headers/HTTP200OK

echo "<html><head><title>nasT Test Page</title></head>"
echo "<body>"
echo "<h1>Welcome to nasT, a portable MVC webserver built only with UNIX utilities</h1>"
echo "<p>To get started, review the documentation.</p>"
echo "<hr/>"
echo "<h3>This was built by Aidan Coyle and Keith Johnson in about 24 hours. Good luck.</h3>"
echo "</body></html>"

