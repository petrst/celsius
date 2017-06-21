#!/bin/bash

HOST=192.168.2.250

temp=$(ssh root@$HOST 'cat /sys/bus/w1/devices/28-000007dcdf59/w1_slave')

# find the 't=XXXXX' pattern and cut everything before 3rd character i.e. 't='
temp=$( echo $temp | grep  -E -o ".{0,0}t=.{0,5}" | cut -c 3-)
logger -t celsius "Temperature at $HOST is $temp"
