
find /tmp -type d -iname '*tomcat*' -mtime +1 -exec rm -rf {} +

#find /tmp -name "*tomcat*" -type d -mmin 4320 | xargs rm -rf
