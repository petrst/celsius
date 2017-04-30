#!/bin/bash

GPIO_PORT=15

GPIO_DEV=/sys/class/gpio/gpio$GPIO_PORT

if ! [ -e $GPIO_DEV ]	
then 
	echo "15" > /sys/class/gpio/export
fi

echo "out" > $GPIO_DEV/direction

if [ "$1" == "on" ]; then 
	echo "1" > $GPIO_DEV/value
fi

if [ "$1" == "off" ]; then 
	echo "0" > $GPIO_DEV/value
fi
