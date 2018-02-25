#!/bin/bash

HOST=192.168.2.250
SYSLOG_TAG=celsius
temp=$(ssh root@$HOST 'cat /sys/bus/w1/devices/28-000007dcdf59/w1_slave' 2>&1)
logger -t $SYSLOG_TAG "Received from $HOST: $temp"
if [[ -z "${temp// }" ]]; then
	logger -t $SYSLOG_TAG "Received empty string from $HOST. Will repeat in 1 sec"
	sleep 1
	temp=$(ssh root@$HOST 'cat /sys/bus/w1/devices/28-000007dcdf59/w1_slave')
	logger -t $SYSLOG_TAG "Received from $HOST: $temp"
fi
# find the 't=XXXXX' pattern and cut everything before 3rd character i.e. 't='
temp=$( echo $temp | grep  -E -o ".{0,0}t=.{0,5}" | cut -c 3-)
temp1=$( echo "scale=2; $temp / 1000.0" | bc)
logger -t $SYSLOG_TAG "Extracted value from $HOST: $temp1"
if [[ -z "${temp1// }" ]]; then
        temp1="U"
fi
echo "$temp1" > /home/pi/celsius/var/actual_temp
logger -t $SYSLOG_TAG "Temperature at $HOST is $temp1"
/opt/rrdtool-1.7.0/bin/rrdtool update /media/usb/celsius1.rrd N:$temp1

HOST=192.168.137.2
#temp=$(ssh pi@$HOST 'tail -n 2 /home/pi/actual_temp')

# find the 't=XXXXX' pattern and cut everything before 3rd character i.e. 't='
#temp=$(tail -n 2 /home/pi/actual_temp)
#temp=$( echo $temp | grep  -E -o ".{0,0}t=.{0,5}" | cut -c 3-)
#temp2=$( echo "scale=2; $temp / 1000.0" | bc)
#echo "$tempi2" > /home/pi/celsius/var/actual_temp2
#logger -t $SYSLOG_TAG "Temperature at $HOST is $temp2"



HOST=192.168.2.23
temp=$(ssh pi@$HOST 'cat /sys/bus/w1/devices/28-000007dd3a83/w1_slave' 2>&1)
logger -t $SYSLOG_TAG "Received from $HOST: $temp"
# find the 't=XXXXX' pattern and cut everything before 3rd character i.e. 't='
temp=$( echo $temp | grep  -E -o ".{0,0}t=.{0,5}" | cut -c 3-)
temp2=$( echo "scale=2; $temp / 1000.0" | bc)
if [[ ! -n "$temp2" ]]; then
  temp2="U"
fi
echo "$temp2" > /home/pi/celsius/var/actual_temp2
logger -t $SYSLOG_TAG "Temperature at $HOST is $temp2"
/opt/rrdtool-1.7.0/bin/rrdtool update /media/usb/celsius2.rrd N:$temp2

cpu_temp=$( cat /home/pi/celsius/var/cpu_temp)
/opt/rrdtool-1.7.0/bin/rrdtool update /media/usb/celsius4.rrd N:$cpu_temp
