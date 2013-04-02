#!/bin/bash
# This script run at 00:00
# cut yesterday log and gzip the day before yesterday log files.
# yesterday logs to awstats
 
# The Nginx logs path
logs_path="/bktdisk/logs/"
date_dir=${logs_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")/$(date -d "yesterday" +"%d")/
gzip_date_dir=${logs_path}$(date -d "-2 day" +"%Y")/$(date -d "-2 day" +"%m")/$(date -d "-2 day" +"%d")/
 
mkdir -p $date_dir
mv ${logs_path}*access.log $date_dir
/bktdisk/local/nginx/sbin/nginx -s reopen
/usr/bin/gzip ${gzip_date_dir}*.log

