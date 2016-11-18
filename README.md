# web_get_iplayer
a python wrapper to provide a web interface to get_iplayer


## Installation - part 0 - pre-requities

* install python
* install an http server that supports cgi-bin


## Installation - part 1 - the web interface

* start a root shell
* change to your cgi-bin directory, e.g.
  cd /var/www/cgi-bin
* fetch the program with
  wget https://raw.githubusercontent.com/speculatrix/web_get_iplayer/master/web_get_iplayer.py
* make executable
  chmod ugo+x web_get_iplayer.py

Then access with your web browser, e.g. http://localhost/cgi-bin/web_get_iplayer.py

You might have to enable traditional cgi-bin behaviour in your apache/httpd server.

The program analyses its environment and will tell you what to do,
e.g. what directories to create and what permissions to give them.

Note that if it doesn't run at all, run it at the command line to check
python has all the libraries it needs.


## Installation - part 2 - the cron queue runner

Set up cron so as to call the wrapper script.

* start a root shell
* change directory to the cgi-bin directory
* get the wrapper script with this command:
  wget https://raw.githubusercontent.com/speculatrix/web_get_iplayer/master/web_get_iplayer.cron.sh
* and make it executable
  chmod ugo+x web_get_iplayer.cron.sh 
* get the cron table file with
  wget -O /etc/cron.d/web_get_iplayer https://raw.githubusercontent.com/speculatrix/web_get_iplayer/master/_etc_cron.d_web_get_iplayer
* tweak the /etc/cron.d/web_get_iplayer if your cgi-bin directory is different

These together run the download queue. You could change the cron tab to run
at night if your bandwidth is cheaper then, or change the frequency at which it
runs if you want to allow your server to idle more. 

In case of problems, check files in /var/lib/web_get_iplayer/ which is where
all the queues and logs are kept.


## Playback

You should be able to play back the downloaded files with mplayer, vlc, ffplay etc.

If you want to use the embedded player, you need the JWplayer. Instructions on downloading and setting this up are coming soon.

If you want to play the FLV files on other devices, the flv-to-divx.sh
script should be put in your /usr/local/bin and made executable.



## Known problems

* sometimes programs don't show up in search but do on
  http://www.bbc.co.uk/iplayer and you have to copy the
  program ID manually into the download function
* audio/radio search is poor at finding programs; reverse engineering
  the http API is not trivial, and is a work in progress



**How it works**

* the program uses the same web/http API as the android app for searching
* simple json files are used for the queue files
* a cron job runs the queue
* the get_iplayer tool actually does the download, see
  https://github.com/get-iplayer/get_iplayer
* the program simply tabulates the files in the downloads directory



