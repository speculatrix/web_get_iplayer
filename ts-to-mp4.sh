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
	echo "no output file given"
	exit 1
fi

if [ ! -f "$1" ] ; then
	echo "input file doesn't exist"
	exit 1
fi

if [ -f "$2" ] ; then
	echo "output file already exists"
	exit 1
fi

if [ "$scale" == "" ] ; then
	errcode = time nice ffmpeg -loglevel warning -i "$INFILE"		-c:a copy -c:v copy		$2
else
	errcode = time nice ffmpeg -loglevel warning -i "$INFILE" $scale	-c:v libx264 -profile:v baseline $2
fi

if [ $errcode -ne 0 ] ; then
	echo "ffmpeg returned error code $errcode"
fi

return errcode
