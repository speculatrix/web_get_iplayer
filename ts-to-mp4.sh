#!/bin/bash

scale=""
if [ "$1" == "-s" ] ; then
	echo "scaling to $2"
	scale="-vf scale=$2"
	shift
	shift
fi

INFILE="$1"

if [ "$INFILE" == "" ] ; then
	echo "no input file specified"
	exit 1
fi

if [ "$2" == "" ] ; then
	OUTFILE=`echo $INFILE | sed 's/ts$/mp4/g'`
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


if [ "$scale" == "" ] ; then
	time nice ffmpeg -loglevel warning -i "$INFILE"		-c:a copy -c:v copy		"$OUTFILE"
	errcode=$?
else
	time nice ffmpeg -loglevel warning -i "$INFILE" $scale	-c:v libx264 -profile:v baseline "$OUTFILE"
	errcode=$?
fi

if [ $errcode -ne 0 ] ; then
	echo "ffmpeg returned error code $errcode"
fi

exit $errcode

# end ts-to-mp4.sh
