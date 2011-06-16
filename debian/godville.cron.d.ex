#
# Regular cron jobs for the godville package
#
0 4	* * *	root	[ -x /usr/bin/godville_maintenance ] && /usr/bin/godville_maintenance
