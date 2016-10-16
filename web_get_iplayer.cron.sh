#!/bin/bash

OUTFILE=/var/lib/web_get_iplayer/web_get_iplayer.out

date >> $OUTFILE
/var/www/public/cgi-bin/web_get_iplayer.py -cron >> $OUTFILE 2>&1
echo "" >> $OUTFILE

