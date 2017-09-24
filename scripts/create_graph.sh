#!/bin/sh

GRAPH_PATH=/home/pi/celsius/server/www/static

rrdtool graph $GRAPH_PATH/temp.png -r \
DEF:a=/media/usb/celsiusdb.rrd:temp1:AVERAGE:start=end-48h \
DEF:b=/media/usb/celsiusdb.rrd:temp2:AVERAGE:start=end-48h \
--title "LAST 24H" \
LINE1:a#ff0000 LINE1:b#00ff00 -g  --border 0 -m 2 \
-c BACK#f6f6f6 -c CANVAS#f6f6f6 -c ARROW#f6f6f6 -c GRID#d6d6d6 -c MGRID#d0d6d6 -c AXIS#d6d6d6 -c FONT#d0d0d0 \
--disable-rrdtool-tag --x-grid DAY:1:HOUR:4:HOUR:4:0:%Hh00 --y-grid 2:1

rrdtool graph $GRAPH_PATH/temp7.png -r \
DEF:a=/media/usb/celsiusdb.rrd:temp1:AVERAGE:start=end-7d \
DEF:b=/media/usb/celsiusdb.rrd:temp2:AVERAGE:start=end-7d \
--title "LAST WEEK" \
LINE1:a#ff0000 LINE1:b#00ff00  -g --border 0 -m 2 \
-c BACK#f6f6f6 -c CANVAS#f6f6f6 -c ARROW#f6f6f6 -c GRID#d6d6d6 -c MGRID#b0b0b0 -c AXIS#d6d6d6 -c FONT#d0d0d0 \
--disable-rrdtool-tag --x-grid HOUR:8:DAY:1:DAY:1:86400:%A --y-grid 2:1 --start -1w


rrdtool graph $GRAPH_PATH/temp1m.png -r \
DEF:a=/media/usb/celsiusdb.rrd:temp1:AVERAGE:start=end-1mon \
DEF:b=/media/usb/celsiusdb.rrd:temp2:AVERAGE:start=end-1mon \
--title "LAST MONTH" \
LINE1:a#ff0000 LINE1:b#00ff00  --slope-mode -g --border 0 -m 2 \
-c BACK#f6f6f6 -c CANVAS#f6f6f6 -c ARROW#f6f6f6 -c GRID#d6d6d6 -c MGRID#b0b0b0 -c AXIS#d6d6d6 -c FONT#d0d0d0 \
--disable-rrdtool-tag --x-grid DAY:1:WEEK:1:DAY:7:0:%d/%m --y-grid 2:1 --start -1mon

# LAST YEAR - only external temperature shown
rrdtool graph $GRAPH_PATH/temp1y.png -r \
DEF:a=/media/usb/celsiusdb.rrd:temp2:MAX:start=end-1y \
DEF:b=/media/usb/celsiusdb.rrd:temp2:AVERAGE:start=end-1y \
--title "LAST YEAR" \
LINE1:a#ff0000  LINE1:b#00ff00  --slope-mode -g --border 0 -m 2 \
-c BACK#f6f6f6 -c CANVAS#f6f6f6 -c ARROW#f6f6f6 -c GRID#d6d6d6 -c MGRID#b0b0b0 -c AXIS#d6d6d6 -c FONT#d0d0d0 \
--disable-rrdtool-tag --x-grid MONTH:1:MONTH:1:MONTH:1:3000000:%b --y-grid 2:1 --start -1y

#rrdtool graph $GRAPH_PATH/temp_mini1.png -r \
#DEF:b=/media/usb/celsiusdb.rrd:temp1:AVERAGE:start=end-7d \
#LINE1:b#000000 -g --border 0  \
#-c ARROW#000000 -c BACK#FFFFFF -c MGRID#000000 \
#--font AXIS:6:. -R mono \
#--disable-rrdtool-tag \
#--x-grid none --y-grid 1:1 -L 1 --start -1w \
#--full-size-mode -w 84 -h 48
