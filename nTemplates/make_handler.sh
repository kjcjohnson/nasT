#!/bin/bash

read name
cp ./nTemplates/handler_temp.sh ./handlers/$name.sh
sed -i "s/^URL=.*/URL=\"\/$name\"/g" ./handlers/$name.sh
sed -i "s/^TEMPLATE_IN=.*/TEMPLATE_IN=\"views\/$name.st\"/g" ./handlers/$name.sh
touch views/$name.st
sed -i "s/^TEMPLATE_OUT=.*/TEMPLATE_OUT=\"views\/$name\"/g" ./handlers/$name.sh
touch views/$name.html
