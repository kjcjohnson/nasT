#!/bin/bash

read name
cp ./nTemplates/db_temp.sh ./db/$name.sh
sed -i "s/^DB=.*/DB=$name.txt/g" ./db/$name.sh
touch ./db/$name.txt
