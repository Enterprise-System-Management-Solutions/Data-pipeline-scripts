cd /data01/card

chmod 775 *.unl

dt=`date -d"1 day ago" +%Y%m%d`

mv evcTRA$dt* /data02/card/evcTRA
mv evcREC$dt* /data02/card/evcREC

chown -R dwhadmin:dwhadmin /data02/card/evcTRA/
chown -R dwhadmin:dwhadmin /data02/card/evcREC/
