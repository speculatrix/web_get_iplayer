FROM debian
MAINTAINER Christian Ashby <docker@cashby.me.uk>
# Install OS package prerequisites and configure apache
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y screen apache2 python wget build-essential cron ffmpeg && \
    mkdir /var/lock/apache2 && \
    a2enmod cgi
# Install development prerequisites
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libssl-dev libhtml-parser-perl libhttp-cookies-perl libwww-perl libxml-simple-perl
# Install the rtmpdump package (TODO: need a -latest.tgz download ideally!)
WORKDIR /tmp
RUN wget http://rtmpdump.mplayerhq.hu/download/rtmpdump-2.3.tgz && \
    tar xvzf rtmpdump-2.3.tgz && \
    cd rtmpdump-* && make && make install && cd .. && rm -rf rtmpdump*
# Install the get_iplayer script and run it to ensure we have the appropriate cache set up in our ~
WORKDIR /usr/lib/cgi-bin
RUN wget https://raw.githubusercontent.com/get-iplayer/get_iplayer/master/get_iplayer && \
    chmod +x get_iplayer
# Install the web_get_iplayer script
COPY web_get_iplayer.py .
RUN chmod +x web_get_iplayer.py
# Configure the crontab entries for web_get_iplayer
COPY web_get_iplayer.cron.sh .
RUN chmod +x web_get_iplayer.cron.sh
COPY _etc_cron.d_web_get_iplayer /etc/cron.d/web_get_iplayer 
# Configure web_get_iplayer
WORKDIR /var/lib
RUN mkdir web_get_iplayer
WORKDIR /var/lib/web_get_iplayer
RUN chgrp 33 . && chmod g+ws . && \
    touch web_get_iplayer.settings && chgrp 33 web_get_iplayer.settings && chmod g+w web_get_iplayer.settings && \
    mkdir /home/iplayer && chgrp 33 /home/iplayer && chmod g+ws /home/iplayer && \
    touch /var/www/.swfinfo && chown 33:33 /var/www/.swfinfo && chmod g+w /var/www/.swfinfo && \
    mkdir /var/www/.get_iplayer && chgrp 33 /var/www/.get_iplayer && chmod g+ws /var/www/.get_iplayer && \
    chown 33:33 /var/www && \
    ln -s `which rtmpdump` /usr/lib/cgi-bin/rtmpdump
# Run get_iplayer for the first time
# And do some clean-up
CMD ["-m", "128"]
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_LOCK_DIR /var/lock/apache2

EXPOSE 80

USER 0
CMD service cron start && /usr/sbin/apache2 -DFOREGROUND

