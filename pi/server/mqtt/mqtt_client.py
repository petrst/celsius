from syslog import syslog
import paho.mqtt.client as mqtt
from rrdtool import update as rrd_update



TOPIC="home/#"
RRD_DB="/media/usb/celsius3.rrd"

device_map= {
    "home/openelec/temp" : "/media/usb/celsius1.rrd",
    "home/out"           : "/media/usb/celsius2.rrd",
    "home/temp"          : "/media/usb/celsius3.rrd",
    "home/rpione/cputemp": "/media/usb/celsius4.rrd",
    "home/rpitwo/cputemp": "/media/usb/celsius5.rrd"
}

def update_rrd(rrdfile, value):
    ret = rrd_update(rrdfile, 'N:%s' % value)
    syslog("RRD error=",ret)

def on_connect(client, userdata, flags, rc):
    syslog("Connected to MQTT broker with result code "+str(rc))
    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    client.subscribe(TOPIC)

def on_message(client, userdata, msg):
    if msg.topic in device_map:
	syslog("Message in %s" % msg.topic)
        rrdfile = device_map[msg.topic]
	syslog("RRD file %s" % rrdfile)
    	update_rrd(rrdfile, msg.payload)
	syslog("RRD %s updated" % rrdfile)

client=mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect("127.0.0.1", 1883, 60)
client.loop_forever()
