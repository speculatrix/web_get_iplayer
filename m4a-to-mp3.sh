#!/bin/bash

INFILE="$1"

if [ "$INFILE" == "" ] ; then
	echo "no input file specified"
	exit 1
fi

if [ "$2" == "" ] ; then
	OUTFILE=`echo $INFILE | sed 's/m4a$/mp3/g'`
	echo "Info, output file name $OUTFILE was derived from input file name"
else
	OUTFILE="$2"
fi

if [ "$OUTFILE" == "" ] ; then
	echo "Error, OUTFILE blank"
	exit 1
fi

if [ "$INFILE" == "$OUTFILE" ] ; then
	echo "Error, INFILE '$INFILE' same as OUTFILE '$OUTFILE'"
	exit 1
fi

if [ ! -f "$INFILE" ] ; then
	echo "Error, input file doesn't exist"
	exit 1
fi

if [ -f "$OUTFILE" ] ; then
	echo "Error, output file already exists"
	exit 1
fi


#nice ffmpeg --enable-libfdk-aac --enable-nonfree -i "$INFILE" -ab 320k -map_metadata 0 "$OUTFILE"
#nice ffmpeg --enable-nonfree -i "$INFILE" -ab 320k -map_metadata 0 "$OUTFILE"
time nice ffmpeg  -loglevel warning -i "$INFILE" -ab 320k -map_metadata 0 "$OUTFILE"
errcode=$?

if [ $errcode -ne 0 ] ; then
	echo "ffmpeg returned error code $errcode"
fi

exit $errcode

# end m4a-to-mp3.sh
