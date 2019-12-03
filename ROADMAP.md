# Road Map

Plans and history for this program



## Future Features

In no particular order

### Chromecast support

Having successfully implemented it in my TV Headend EPG tool
(https://github.com/speculatrix/tvh_epg) I will strongly consider
doing it here; however, it will need the transcoding features to
be massively improved so make them robust, so as to support the
codecs that Chromecast works with.


### Automatic favourite downloading
check for new programs matching your favourites and download them

### podcast generation
tidy up podcast generation. might be nicer to make it part of web_get_iplayer
instead of being an external program, then the podcasts are refreshed on 
demand instead of own cron?


### Sub directories
tell get_iplayer to download into sub director.
transcode things in sub directory


### improve the radio search function

The ibl API the BBC provide is not complete, e.g. searching for related
items does not work. Examining the iPlayer Radio app shows it uses the Nitro
API for some things.


## Done

In reverse chonological order

### Stop background get_iplayer

It is now possible to kill a running get_iplayer background process

### Sub directories
Fixed bug deleting items in sub directory.
Fixed bug allowing web browser to raw download from sub directory.

### podcast generation
found and adapted a tool which will generate podcast feeds for you.
can create rss feed/podcasts for different media types so you can take your
media with you easily


### Favourites
you can add a series or brand to your favourites, and delete it. very crude
so far, but it works OK. Fixed saving radio faves in July 2017.


### When transcoding radio programs, copy the image file.
radio programs have, for unknown reason, quite different file name for media
file from image file name.
this is done by recording the inode of the image file after download


### add status field to each queue entry
this helps with debugging as well as simply observing status


### add transcoding as a queued function
it used to be done during the cgi-bin page generation, but that was
unsatisfactory for many reasons...
if web server died or timed out the output was truncated or corrupted.


### fix basic radio search and download
the API and json are quite different for radio from video


### complete re-write from the original perl
the original perl program grew from a quick hack, and I needed to learn Python

