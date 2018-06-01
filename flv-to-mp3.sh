#!/bin/bash

INFILE="$1"
if [ "$INFILE" == "" ] ; then
	echo "no input file specified"
	exit 1
fi


if [ "$2" == "" ] ; then
	OUTFILE=`echo $INFILE | sed 's/flv$/mp3/g'`
	echo "Info, output file name $OUTFILE was derived from input file name"
else
	OUTFILE="$2"
fi

if [ "$OUTFILE" == "" ] ; then
	echo "Error, no output file given"
	exit 1
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

# VBR averaging 224 kb/s allowing the range 190...250
nice ffmpeg -nostdin -i "$INFILE" -aq 1 transcoding.$OUTFILE
errcode=$?

# fixed rate 224 kb/s
#nice ffmpeg -nostdin -i "$INFILE" -c:v liblame -b:a 224k "transcoding.$OUTFILE"

# fixed rate 256 kb/s
#nice ffmpeg -nostdin -i "$INFILE" -c:v liblame -b:a 256k "transcoding.$OUTFILE"

if [ $errcode -eq 0 ] ; then
	mv transcoding.$OUTFILE $OUTFILE
fi

exit $errcode

# end flv-to-mp3.sh
