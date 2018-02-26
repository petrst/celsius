#!/bin/bash
SYSLOG_TAG=celsius
temp=$(cat /sys/bus/w1/devices/28-000007dd3a83/w1_slave)
logger -t $SYSLOG_TAG "Raw temp: $temp"
if [[ -z "${temp// }" ]]; then
        logger -t $SYSLOG_TAG "Received empty string. Will repeat in 1 sec"
        sleep 1
        temp=$(cat /sys/bus/w1/devices/28-000007dd3a83/w1_slave)
        logger -t $SYSLOG_TAG "Received: $temp"
fi
# find the 't=XXXXX' pattern and cut everything before 3rd character i.e. 't='
temp=$( echo $temp | grep  -E -o ".{0,0}t=.{0,5}" | cut -c 3-)
temp1=$( echo "scale=2; $temp / 1000.0" | bc)
logger -t $SYSLOG_TAG "Extracted value: $temp1"
if [[ -z "${temp1// }" ]]; then
        temp1="U"
fi
mosquitto_pub -h 192.168.2.30 -t home/out -m $temp1
logger -t $SYSLOG_TAG "Temperature $temp1 sent to MQTT"
echo "home/out ${temp1} sent: $?"

cputemp=$(cat /sys/class/thermal/thermal_zone0/temp)
((cputemp = cputemp / 1000))


echo $cputemp
mosquitto_pub -h 192.168.2.30 -t home/rpitwo/cputemp -m $cputemp
echo "CPU temp sent: $?"

