rrdtool create celsiusdb.rrd -b 9am -s 300 \
 DS:temp1:GAUGE:600:-50:50 \
 DS:temp2:GAUGE:600:-50:50 \
 DS:temp3:GAUGE:600:-50:50 \
 DS:temp4:GAUGE:600:-50:50 \
 RRA:AVERAGE:0.5:1:576  \
 RRA:AVERAGE:0.5:12:168 \
 RRA:AVERAGE:0.5:72:120 \
 RRA:AVERAGE:0.5:288:3650 \
 RRA:MIN:0.5:72:120 \
 RRA:MAX:0.5:72:120 \
 RRA:MIN:0.5:288:3650 \
 RRA:MAX:0.5:288:3650 
