#!/usr/bin/python

from datetime import timedelta

def uptime():
	with open('/proc/uptime', 'r') as f:
	    uptime_seconds = float(f.readline().split()[0])
	    return str(timedelta(seconds = uptime_seconds))

