rsync -avhP root@210.65.10.38:/bktdisk/logs/bookteller.com.tw.access.log /var/www/awstats/wwwroot/awslogs/

rsync -avhP root@210.65.10.4:/bktdisk/dbbackup/booktellerdb/ /bktdisk/dbbackup/210.65.10.4/booktellerdb/

rsync -avhP root@210.65.10.4:/bktdisk/dbbackup/bktlibtwdb/ /bktdisk/dbbackup/210.65.10.4/bktlibtwdb/

rsync -avhP root@210.65.10.4:/bktdisk/dbbackup/booktellertwlive/ /bktdisk/dbbackup/210.65.10.4/booktellertwlive/
