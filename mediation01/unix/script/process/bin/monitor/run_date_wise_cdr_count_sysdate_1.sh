

cd /data02/script/process/bin/monitor
d=`date -d yesterday '+%Y%m%d'`


./date_wise_cdr_count.sh $d > $d.log
