#!/bin/bash
# make an RSS feed of all audio files

if [ "$1" != "" ] ; then
	RSSHOST="$1"
fi

# set this to the location where iplayer downloads everything
IDIR=/home/iplayer
RSSFILE=iplayer_radio_feed.rss.xml


# set this to where you downloaded the genRSS.py
# see https://github.com/speculatrix/genRSS
GENRSS=/usr/local/bin/genRSS.py

# have a guess at the URL
if [ "$RSSHOST" == "" ] ; then
	RSSHOST="http://"`hostname`"/iplayer/"
	echo "Set RSSHOST to $RSSHOST"
fi

# generate the RSS feed file
cd $IDIR
find . ! -path . -type d -printf '-d "%f" '	\
	| xargs $GENRSS -H "$RSSHOST" -e mp3 -t "iPlayer Radio" -p "iPlayer Radio" -o "$IDIR/$RSSFILE"


