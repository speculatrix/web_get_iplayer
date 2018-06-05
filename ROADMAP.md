# Road Map

Plans and history for this program



## Future Features

In chronological order

### Automatic favourite downloading
check for new programs matching your favourites and download them

### podcast generation
create rss feed/podcasts for different media types so you can take your
media with you easily



## Done

In reverse chonological order

### Favourites
you can add a brand to your favourites, and delete it. very crude so far, but it works OK.


### fix transcoding radio programs to copy the image file.
radio programs have, for unknown reason, quite different file name for media file from image file name.
this is done by recording the inode of the image file after download


### add status field to each queue entry
this helps with debugging as well as simply observing status


### add transcoding as a queued function
it used to be done during the cgi-bin page generation, but that was unsatisfactory for many reasons...
if web server died or timed out the output was truncated or corrupted.


### fix basic radio search and download
the API and json are quite different for radio from video


### complete re-write from the original perl
the original perl program grew from a quick hack, and I needed to learn Python

