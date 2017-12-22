# web_get_iplayer
a python wrapper to provide a web interface to get_iplayer


## Installation - part 0 - pre-requisites

* install python2 - on ubuntu 16.04, python3 is installed by default, so
```
sudo apt-get install python
```

on OpenSuse, you need to install python-odict for ordered dictionaries:
```
sudo zypper install python-odict
```

* install an http server that supports `cgi-bin`, e.g. apache2

* how to enable traditional cgi-bin behaviour in apache/httpd server for
  Debian or Ubuntu:

```
cd /etc/apache2/mods-enabled/
sudo ln -s ../mods-available/cgi.load
sudo apachectl restart
```

* download the get_iplayer program from
  `https://raw.githubusercontent.com/get-iplayer/get_iplayer/master/get_iplayer`
  and put it into the `cgi-bin` directory and make executable, and install
  perl and dependencies
* on Debian or Ubuntu:
```
cd /usr/lib/cgi-bin/
sudo wget https://raw.githubusercontent.com/get-iplayer/get_iplayer/master/get_iplayer
sudo chmod ugo+x get_iplayer
sudo apt-get install libcgi-pm-perl libhtml-html5-entities-perl libhtml-entities-numbered-perl libhtml-html5-parser-perl
```

* (optional) get the JW Player if you wish to be able to play FLV
  videos embedded in the web page - see instructions in Playback.


## Installation - part 1 - installing this web interface

* download the web_get_iplayer.py from
  `https://raw.githubusercontent.com/speculatrix/web_get_iplayer/master/web_get_iplayer.py`
  and put it into the `cgi-bin` directory and make executable
* on Debian or Ubuntu:

```
cd /usr/lib/cgi-bin/
sudo wget https://raw.githubusercontent.com/speculatrix/web_get_iplayer/master/web_get_iplayer.py
sudo chmod ugo+x web_get_iplayer.py
```

## Installation - part 2 - setting up the web interface's environment

Access the web interace with your web browser, e.g. http://localhost/cgi-bin/web_get_iplayer.py

The program analyses its environment and will tell you what to do,
e.g. what directories to create and what permissions to give them.

Note that if it doesn't run at all, run it at the command line as the httpd
user id to check python has all the libraries it needs, like this:
```
sudo -i -u www-data /usr/lib/cgi-bin/get_iplayer
```

## Installation - part 3 - the cron queue runner

Set up cron so as to call the wrapper script.

* start a root shell
* change directory to the `cgi-bin` directory
* get the wrapper script with this command:
```
wget https://raw.githubusercontent.com/speculatrix/web_get_iplayer/master/web_get_iplayer.cron.sh
```
* and make it executable
```
chmod ugo+x web_get_iplayer.cron.sh
```
* get the cron table file with
```
wget -O /etc/cron.d/web_get_iplayer https://raw.githubusercontent.com/speculatrix/web_get_iplayer/master/_etc_cron.d_web_get_iplayer
```
* tweak the `/etc/cron.d/web_get_iplayer` if your `cgi-bin` directory is different
* test it, on Debian/Ubuntu to check there are no errors:

```
sudo -i -u www-data /usr/lib/cgi-bin/web_get_iplayer.cron.sh
```
These together run the download queue. You could change the cron tab to run
at night if your bandwidth is cheaper then, or change the frequency at which it
runs if you want to allow your server to idle more.

In case of problems, check files in `/var/lib/web_get_iplayer/` which is where
all the queues and logs are kept.

## Installation with Docker - local installation

The Dockerfile included can be used to build a local version of the web_get_iplayer script on Debian Wheezy.

```
docker build -t {name} .
docker run -d --mount source={directory},target=/home/iplayer -p 10080:80 {name}
```
Where {name} is the name of the docker image you want to produce and {directory} is the destination for downloads.  The server will be available on http://localhost:10080

Optionally, also mount `/var/lib/web_get_iplayer` to get access to the iplayer logs from outside the container.

## Installation with Docker - from Docker hub

For convenience, there is also a version of the script [on Docker Hub](https://hub.docker.com/r/cscashby/web_get_iplayer/):
```
docker pull cscashby/web_get_iplayer
docker run -d --mount source={directory},target=/home/iplayer -p 10080:80 cscashby/web_get_iplayer
```
Where {directory} is the destination for downloads.  The server will be available on http://localhost:10080

Optionally, also mount `/var/lib/web_get_iplayer` to get access to the iplayer logs from outside the container.

## Playback

You should be able to play back the downloaded files with mplayer, vlc, ffplay etc.

If you want to use the embedded player to play .flv files, you need JWplayer.
In order to get this, you may need to register at www.jwplayer.com .

Usually, if you've registered correctly, the download page will be
https://dashboard.jwplayer.com/#/welcome

Download the jwplayer-*version*.zip file, make a note of the licence key.
Latest at: https://ssl.p.jwpcdn.com/player/download/jwplayer-7.12.8.zip
Unpack the zip file into your htdocs directory, so it appears as
http://example/jw-player-*version*/ and ensure the appropriate relative URI
is put into the configuration (Flv7Uri) along with the licence key string.


You can transcode the TS (video) and M4A (audio) files into other formats
to play on other devices; mp4 is a popular choice for video, mp3 for audio.
The UI offers this possibility, whereby it calls a transcode command.
Some useful scripts are provided for doing this, ts-to-mp4.sh and
m4a-to-mp3.sh . Download them and make them executable. A good place to put
them is /usr/local/bin, but you can configure their locations in the settings.

If you install the JWPlayer, then it can play .flv and .mp4 video files,
but also luckily .m4a audio files, without them needing to be transcoded,
which means you do everything in the browser.

In order to transcode, you need to install the ffmpeg tool. Note that on
openSuse you should install from the Packman repository because the default
openSuse version is missing the AAC codec. With Ubuntu, you may need to add
"-strict -2" to the ts-to-mp4.sh script in order to enable the AAC codec,
otherwise you'll see this error:
<code>    [aac @ 0xc16a40] The encoder 'aac' is experimental but experimental codecs are not enabled, add '-strict -2' if you want to use it.</code>


## Known problems and shortcomings

* sometimes programs don't show up in search but do on
  http://www.bbc.co.uk/iplayer and you have to copy the
  program ID manually into the download function
* audio/radio search is imperfect at finding programs; reverse engineering
  the http API is not trivial, and is a work in progress
* all the downloaded audio and video files live in the same directory
* there's no feature to move files into sub-directories


## How it works

* the program uses the same web/http API as the android app for searching
* simple json files are used for the queue files
* a cron job runs the queue
* the get_iplayer tool actually does the download, see
  https://github.com/get-iplayer/get_iplayer
* the program simply tabulates the files in the downloads directory

## Tips and Tricks

* Use `--pid-recursive-noclips --pid-recursive` at the end of the `download_args` setting to allow for pids of series and programmes - this will download multiple files.
