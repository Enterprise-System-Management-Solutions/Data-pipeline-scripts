#dt=`date '+%Y%m%d'`
dt=`date -d yesterday '+%Y%m%d'`

cd /data02/scripts/process/bin/l3_insert
./l3_management_insert.sh $dt
