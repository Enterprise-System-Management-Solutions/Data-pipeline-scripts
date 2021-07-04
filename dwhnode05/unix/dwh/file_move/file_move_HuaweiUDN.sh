
cd /data01/udn

mv *.gz /data04/udn/

chown -R dwhadmin:dwhadmin /data04/udn/
find /data04/udn/ -type f -exec chmod 775 {} \;
