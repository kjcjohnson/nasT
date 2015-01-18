#!/bin/bash
DB=./db/table.txt
KEY=$2
VAL=$3 

echo "$1"
echo "$KEY"
echo "$VAL"

case "$1" in
    create)
	grep -q ^$KEY$'\x1f' $DB
	if [ "$?" -eq "0" ]
	then
	    exit 1
	fi
	echo -e "$KEY\x1f $VAL" >> $DB
	;;
    update)
	grep -q ^$KEY$'\x1f' $DB
	if [ "$?" -eq "1" ]
	then
	    exit 1
	fi
	sed -i "s/^$KEY\x1f .*/$KEY\x1f $VAL/g" $DB
	;;
    read)
	grep -q ^$KEY$'\x1f' $DB
	if [ "$?" -eq "1" ]
	then
	    exit 1
	fi
	sed -n "s/^$KEY\x1f \(.*\)/\1/p" $DB
	;;
    delete)
	grep -q ^$KEY$'\x1f' $DB
	if [ "$?" -eq "1" ]
	then
	    exit 1
	fi
	sed -i "/^$KEY\x1f .*/d" $DB
	;;
    *)
	exit 1
	;;
esac
