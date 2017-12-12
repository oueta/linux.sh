#!/bin/bash
# Winstyle++ ping
if [ -z "$1" ]
  then
    echo "Usage: ./pinw.sh ip";
    exit 1;
fi
up=0;
down=0;
total=1;
while(true)
do
ping=`ping -c 1 -W 1 $1 | grep from | cut -d: -f2`
    if [ ! -z "$ping" ]; then
        up=$((up+1));
        echo -e "[`date +%H:%M:%S`] (total=$total; sent=$up; lost=$down)\e[32m Reply from $1:$ping \e[0m";
		sleep 1;
    else
        down=$((down+1));
        echo -e "[`date +%H:%M:%S`] (total=$total; sent=$up; lost=$down)\e[91m Request timed out.\e[0m";
    fi
total=$((total+1));
done
