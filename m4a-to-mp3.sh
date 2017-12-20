#!/bin/bash

INFILE="$1"

if [ "$INFILE" == "" ] ; then
	echo "no input file specified"
	exit
fi

OUTFILE=`echo $INFILE | sed 's/m4a/mp3/g'`

if [ "$INFILE" == "$OUTFILE" ] ; then
	echo "name transformation failed, $INFILE to $OUTFILE"
fi

if [ "$OUTFILE" == "" ] ; then
	echo "name transformation failed, OUTFILE blank"
fi

if [ ! -f "$INFILE" ] ; then
	echo "input file doesn't exist"
fi

if [ -f "$OUTFILE" ] ; then
	echo "output file already exists"
fi


#nice ffmpeg --enable-libfdk-aac --enable-nonfree -i "$INFILE" -ab 320k -map_metadata 0 "$OUTFILE"
#nice ffmpeg --enable-nonfree -i "$INFILE" -ab 320k -map_metadata 0 "$OUTFILE"
time nice ffmpeg -i "$INFILE" -ab 320k -map_metadata 0 "$OUTFILE"


