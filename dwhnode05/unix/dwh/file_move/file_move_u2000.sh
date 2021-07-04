dt=`date  '+%Y%m%d'`

# ======= Move Alarm log =====

lock=/data04/ipdr_u2000/move_alarm_log  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data04/ipdr_u2000/NBI_FM/$dt

mv *.csv /data04/ipdr_u2000/alarm

chown -R dwhadmin:dwhadmin /data04/ipdr_u2000/alarm

rm -f $lock

fi
