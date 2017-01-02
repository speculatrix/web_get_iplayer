#!/bin/bash
# the script should be called by cron or other schedular, and it drives
# the web_get_iplayer.py queue running process
# you need to customise it with the location of the web_get_iplayer.py
# script

OUTFILE=/var/lib/web_get_iplayer/web_get_iplayer.out

date >> $OUTFILE
/usr/lib/cgi-bin/web_get_iplayer.py -cron >> $OUTFILE 2>&1
echo "" >> $OUTFILE

