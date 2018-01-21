#!/bin/bash
function hasw1device {
  ls /sys/bus/w1/devices/*/w1_slave 2> /dev/null
  if [ $? -eq 0 ]
  then 
    echo "OK. Some 1-wire devices found."
    exit 0
  else
    echo "No 1-wire devices found."
    exit 1
  fi
}

hasw1device
