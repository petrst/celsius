#!/bin/sh

GRAPH_PATH=/home/pi/celsius/server/www/static

BACK_COLOR=f6f6f6ff
GRID_COLOR=a6a6a6
FONT_COLOR=d00000

/opt/rrdtool-1.7.0/bin/rrdtool graph $GRAPH_PATH/temp.png -r \
DEF:a=/media/usb/celsius1.rrd:temp:AVERAGE:start=end-46h \
DEF:b=/media/usb/celsius2.rrd:temp:AVERAGE:start=end-46h \
DEF:c=/media/usb/celsius3.rrd:temp:AVERAGE:start=end-46h \
--title "LAST 24H" \
LINE1:a#ff0000 LINE1:b#00ff00 LINE1:c#0000ff -g  --border 0 -m 2 \
-c BACK#$BACK_COLOR -c CANVAS#$BACK_COLOR -c ARROW#$BACK_COLOR -c GRID#$GRID_COLOR -c MGRID#d0d6d6 -c AXIS#$GRID_COLOR -c FONT#$FONT_COLOR \
--disable-rrdtool-tag --x-grid DAY:1:HOUR:4:HOUR:4:0:%Hh00 --y-grid 2:1
logger -t celsius "New graph created: $?"

/opt/rrdtool-1.7.0/bin/rrdtool graph $GRAPH_PATH/temp7.png -r \
DEF:a=/media/usb/celsius1.rrd:temp:AVERAGE:start=end-7d \
DEF:b=/media/usb/celsius2.rrd:temp:AVERAGE:start=end-7d \
--title "LAST WEEK" \
LINE1:a#ff0000 LINE1:b#00ff00  -g --border 0 -m 2 \
-c BACK#f6f6f6 -c CANVAS#f6f6f6 -c ARROW#f6f6f6 -c GRID#d6d6d6 -c MGRID#b0b0b0 -c AXIS#d6d6d6 -c FONT#d0d0d0 \
--disable-rrdtool-tag --x-grid HOUR:8:DAY:1:DAY:1:86400:%A --y-grid 2:1 --start -1w --step 1h
logger -t celsius "New graph created: $?"


/opt/rrdtool-1.7.0/bin/rrdtool graph $GRAPH_PATH/temp1m.png -r \
DEF:a=/media/usb/celsius1.rrd:temp:AVERAGE:start=end-1mon \
DEF:b=/media/usb/celsius2.rrd:temp:AVERAGE:start=end-1mon \
--title "LAST MONTH" \
LINE1:a#ff0000 LINE1:b#00ff00  --slope-mode -g --border 0 -m 2 \
-c BACK#f6f6f6 -c CANVAS#f6f6f6 -c ARROW#f6f6f6 -c GRID#d6d6d6 -c MGRID#b0b0b0 -c AXIS#d6d6d6 -c FONT#d0d0d0 \
--disable-rrdtool-tag --x-grid DAY:1:WEEK:1:DAY:7:0:%d/%m --y-grid 2:1 --start -1mon
logger -t celsius "New graph created: $?"

# LAST YEAR - only external temperature shown
/opt/rrdtool-1.7.0/bin/rrdtool graph $GRAPH_PATH/temp1y.png -r \
DEF:a=/media/usb/celsius1.rrd:temp:MAX:start=end-1y \
DEF:b=/media/usb/celsius1.rrd:temp:AVERAGE:start=end-1y \
--title "LAST YEAR" \
LINE1:a#ff0000  LINE1:b#00ff00  --slope-mode -g --border 0 -m 2 \
-c BACK#f6f6f6 -c CANVAS#f6f6f6 -c ARROW#f6f6f6 -c GRID#d6d6d6 -c MGRID#b0b0b0 -c AXIS#d6d6d6 -c FONT#d0d0d0 \
--disable-rrdtool-tag --x-grid MONTH:1:MONTH:1:MONTH:1:3000000:%b --y-grid 2:1 --start -1y
logger -t celsius "New graph created: $?"

#rrdtool graph $GRAPH_PATH/temp_mini1.png -r \
#DEF:b=/media/usb/celsius1.rrd:temp:AVERAGE:start=end-7d \
#LINE1:b#000000 -g --border 0  \
#-c ARROW#000000 -c BACK#FFFFFF -c MGRID#000000 \
#--font AXIS:6:. -R mono \
#--disable-rrdtool-tag \
#--x-grid none --y-grid 1:1 -L 1 --start -1w \
#--full-size-mode -w 84 -h 48

