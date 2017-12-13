#!/bin/bash
# pinw.sh
# winstyle++ ping
if [ -z "$1" ]
then
    echo "Usage: $0 ip"
    exit 1
fi
up=0
down=0
total=0
while(true)
do
    ping=`ping -c 1 -W 1 $1`
    ping_exit=$?
    total=$((total+1))
    ping=`echo "$ping" | grep ttl`
    if [ ! -z "$ping" ]
    then
        up=$((up+1))
        echo -e "[`date +%H:%M:%S`] (total=$total; sent=$up; lost=$down)\e[32m $ping \e[0m"
		sleep 1
    else
        if [ "$ping_exit" -eq "1" ]
        then
            down=$((down+1))
            echo -e "[`date +%H:%M:%S`] (total=$total; sent=$up; lost=$down)\e[91m Request timed out.\e[0m"
        else
            break
            exit $ping_exit
		fi
    fi
done
