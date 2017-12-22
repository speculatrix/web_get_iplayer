#!/bin/bash
# flv-to-divx.sh is a script to convert FLVs, typically from BBC iplayer, 
# into a format that can be streamed over DLNA to a variety of devices 
# such as PS3s, Panasonic TVs, bluray players etc.
# the resulting divx's can be streamed with PMS and Twonky.


NEWREZ=""		# don't scale

#NEWREZ="1280x720"	# 720p

# panasonic TV divx compatible resolutions:
#NEWREZ="720x416"	# NTSC resolution
#NEWREZ="720x576"	# PAL resolution

if [ "$1" == "-s" ] ; then
	NEWREZ="$2"
	shift
	shift
fi


FFPMEGOPTSCALE=""
FNAMEADD=""
if [ "$NEWREZ" != "" ] ; then
	FFMPEGOPTSCALE="-s $NEWREZ"
	FNAMEADD="-$NEWREZ"
fi

INFILE="$1"

if [ "$INFILE" == "" ] ; then
	echo "no input file given"
	exit 1
fi

if [ "$2" == "" ] ; then
	OUTFILE=`echo "$INFILE" | sed -e "s/.flv\$/$FNAMEADD.avi/g"`
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

INTERMEDIATE="${OUTFILE%.*}.transcoding.avi"

# fixed quality: quality 4, audio 256k
time nice ffmpeg -i $INFILE -f avi -vcodec mpeg4 -qscale 4 -b:a 256k -vtag divx $FFMPEGOPTSCALE $INTERMEDIATE
errorcode=$?
# fixed bit rate: video 1280k, audio 320k
#nice ffmpeg -i $INFILE -f avi -vcodec mpeg4 -b:v 1280k -b:a 320k -vtag divx $FFMPEGOPTSCALE $INTERMEDIATE

mv $INTERMEDIATE $OUTFILE

if [ $errcode -ne 0 ] ; then
	echo "ffmpeg returned error code $errcode"
fi

exit $errcode

# end flv-to-divx.sh
