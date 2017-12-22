#!/bin/bash

INFILE="$1"

if [ "$INFILE" == "" ] ; then
	echo "no input file specified"
	exit 1
fi

OUTFILE=`echo $INFILE | sed 's/m4a$/mp3/g'`

if [ "$INFILE" == "$OUTFILE" ] ; then
	echo "name transformation failed, $INFILE to $OUTFILE"
	exit 1
fi

if [ "$OUTFILE" == "" ] ; then
	echo "name transformation failed, OUTFILE blank"
	exit 1
fi

if [ ! -f "$INFILE" ] ; then
	echo "input file doesn't exist"
	exit 1
fi

if [ -f "$OUTFILE" ] ; then
	echo "output file already exists"
	exit 1
fi


#nice ffmpeg --enable-libfdk-aac --enable-nonfree -i "$INFILE" -ab 320k -map_metadata 0 "$OUTFILE"
#nice ffmpeg --enable-nonfree -i "$INFILE" -ab 320k -map_metadata 0 "$OUTFILE"
errcode time nice ffmpeg  -loglevel warning -i "$INFILE" -ab 320k -map_metadata 0 "$OUTFILE"

if [ $errcode -ne 0 ] ; then
	echo "ffmpeg returned error code $errcode"
fi

