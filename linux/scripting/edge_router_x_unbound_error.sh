#!/bin/bash
#Put the script in /config/scripts/post-config.d with execution rights
#Shutdown unbound service
service unbound stop
#Delete root.key
cd /var/lib/unbound && rm root.key
#Retrieving the file
wget ftp://FTP.INTERNIC.NET/domain/named.cache -O /var/lib/unbound/root.hints
#Start unbound service
service unbound start
