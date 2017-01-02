#/bin/bash
ffmpeg -i $1 -acodec copy -vcodec copy $2

