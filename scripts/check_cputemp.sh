#!/bin/bash

GPIO_PORT=15
THRESHOLD_HI=43
THRESHOLD_LO=35
SYSLOG_TAG="cputemp"

GPIO_DEV=/sys/class/gpio/gpio$GPIO_PORT

typeset -i cputemp=$(cat /sys/class/thermal/thermal_zone0/temp)
((cputemp = cputemp / 1000))
logger t $SYSLOG_TAG "CPU temp = $cputemp"

if ! [ -e $GPIO_DEV ]	
then 
	echo "15" > /sys/class/gpio/export
fi


if ((cputemp > THRESHOLD_HI)); then 
	logger -t $SYSLOG_TAG "CPU temperature is HIGH"
	echo "out" > $GPIO_DEV/direction
	echo "1" > $GPIO_DEV/value
fi

if ((cputemp < THRESHOLD_LO)); then 
	logger -t $SYSLOG_TAG "CPU temperature is LOW"
	echo "out" > $GPIO_DEV/direction
	echo "0" > $GPIO_DEV/value
fi
