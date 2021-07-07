PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin'
cd /data02/script/process/bin/monitor
#./cbs_cdr_count.sh > /data02/script/process/bin/monitor/exp_log/cbs_cdr_count.txt
./cdr_counts_253.sh > /data02/script/process/bin/monitor/exp_log/cbs_cdr_count.txt
sleep 1m
cd /data02/script/process/bin/monitor/exp_log
sshpass -p "dwhadmin" scp cbs_cdr_count.txt dwhadmin@192.168.61.202:/data02/scripts/process/bin/monitor/exp_log
