#!/bin/sh
case "$1" in
    start)
		echo 'nginx starting...'
			/bktdisk/local/nginx/sbin/nginx
		echo 'spawn-fcgi starting...'
        	/bktdisk/local/spawn-fcgi/bin/spawn-fcgi -a 127.0.0.1 -p 9000 -u apache -g apache -f /bktdisk/local/php/bin/php-cgi -C 20
        ;;
    stop)
		echo 'nginx stopping...'
		killall nginx
		echo 'spawn-fcgi stopping...'
		killall php-cgi
        ;;
    restart)
		echo 'nginx stopping...'
		killall nginx
		echo 'spawn-fcgi stopping...'
		killall php-cgi
		sleep 1
		echo 'nginx starting...'
		/bktdisk/local/nginx/sbin/nginx
		echo 'spawn-fcgi starting...'
        	/bktdisk/local/spawn-fcgi/bin/spawn-fcgi -a 127.0.0.1 -p 9000 -u apache -g apache -f /bktdisk/local/php/bin/php-cgi -C 20

        ;;
    *)
        echo "Use: {start|stop|restart}"
esac
exit
