from flask import Flask, render_template, send_file
from uptime import uptime
import sys
import logging
from subprocess import Popen,PIPE

class MyFlask(Flask):
    def get_send_file_max_age(self, name):
        if name.lower().endswith('.png'):
            return 60*10
        return flask.Flask.get_send_file_max_age(self, name)

app = MyFlask(__name__)

SENSOR_DEV = "/sys/bus/w1/devices/28-000007dcdf59/w1_slave"

def _read_temp():
  p1=Popen(["rrdtool","lastupdate", "/media/usb/temp1.rrd"],stdout=PIPE)
  p2=Popen(["awk", "NR>2 { print $2 }"], stdin=p1.stdout, stdout=PIPE)
  temp = p2.stdout.read()
  return float(temp.strip())

def read_temp():
  pass

def read_temperature(file):
  return 0.0
  tfile = open(file)
  text = tfile.read()
  tfile.close()
  lines = text.split("\n")
  if lines[0].find("YES") > 0:
    temp = float((lines[1].split(" ")[9])[2:])
    temp /= 1000
    return temp
  return ERROR_TEMP


def read_temperature2():
  with  open('/home/pi/celsius/var/actual_temp2') as fh:
    temp = fh.read()
    if temp.strip()=='U':
	return "--"
    else:
    	return "%.1f" % float(temp.strip())
  
def read_cputemp():
  with  open('/home/pi/celsius/var/cpu_temp') as fh:
    temp = fh.read()
    return float(temp.strip())
  


@app.route('/data')
def data():
    return send_file('data.csv')
    
@app.route('/')
def index():
    print "In method index()"
    return render_template('index.html', temperature=read_temperature2(), uptime=uptime(), cputemp=read_cputemp())

if __name__ == '__main__':
    print "Starting server ..."
    app.run(debug=True, host='0.0.0.0', port=8088)
