
#dt=`date -d yesterday '+%Y%m%d'`
dt="$1"
# ======= Move Alarm log =====

lock=/data04/ipdr_u2000/move_alarm_log  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data04/ipdr_u2000/u2000_dir/NBI_FM/$dt

mv *.csv /data04/ipdr_u2000/alarm

chown -R dwhadmin:dwhadmin /data04/ipdr_u2000/alarm

rm -f $lock

fi
