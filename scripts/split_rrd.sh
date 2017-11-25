rrdtool create $1 -b 7am -s 300 -r /media/usb/celsiusdb.rrd \
 DS:temp=$2:GAUGE:600:-50:50 \
 RRA:AVERAGE:0.5:1:576  \
 RRA:AVERAGE:0.5:12:168 \
 RRA:AVERAGE:0.5:72:120 \
 RRA:AVERAGE:0.5:288:3650 \
 RRA:MIN:0.5:72:120 \
 RRA:MAX:0.5:72:120 \
 RRA:MIN:0.5:288:3650 \
 RRA:MAX:0.5:288:3650 
