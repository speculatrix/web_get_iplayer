# web_get_iplayer
a python wrapper to provide a web interface to get_iplayer

Put the web_get_iplayer.py in your CGI-BIN directory, make it executable,
and then access it via your web browser. It should tell you what to do,
e.g. what directories to create and what permissions to give them.

Note that if it doesn't run at all, run it at the command line to check
python has all the libraries it needs.

You also need to have the get_iplayer.pl script installed too, which you
get from https://sourceforge.net/projects/get-iplayer/


Then set up cron so as to call the wrapper script.
* Copy the _etc_cron.d_web_get_iplayer to /etc/cron.d
  and tweak it to suit your setup.
* Make web_get_iplayer.cron.sh executable.

These together run the download queue. You could change the cron tab to run
at night if your bandwidth is limited, and change the frequency at which it
runs.


In case of problems, check files in /var/lib/web_get_iplayer/


If you want to play the FLV files on other devices, the flv-to-divx.sh
script should be put in your /usr/local/bin and made executable



Known problems:
* sometimes programs don't show up in search but do on
  http://www.bbc.co.uk/iplayer and you have to copy the program ID
* audio/radio search is poor at finding programs; reverse engineering
  the http API is not trivial


How it works:
* the program uses the same web/http API as the android app for searching
* simple json files are used for the queue files
* a cron job runs the queue
