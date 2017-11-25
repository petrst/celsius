from syslog import syslog
import paho.mqtt.client as mqtt
from rrdtool import update as rrd_update

TOPIC="home/temp"
RRD_DB="/media/usb/celsius3.rrd"

def update_rrd(value):
    ret = rrd_update(RRD_DB, 'N:%s' % value);

def on_connect(client, userdata, flags, rc):
    syslog("Connected to MQTT broker with result code "+str(rc))
    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    client.subscribe(TOPIC)

def on_message(client, userdata, msg):
    update_rrd(msg.payload)

client=mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect("127.0.0.1", 1883, 60)
client.loop_forever()
