#!/bin/bash
PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin'

d1=$1
d2=$2
d3=$3
d4=$4
d5=$5

cd /data02/scripts/process/bin/file_exp

d=`date`
echo " ${d}export start for ${d1}" >> /data02/scripts/process/bin/hadoop.log
./l2_adjustment_exp_manual.sh $d1
./l2_content_exp_manual.sh $d1
./l2_data_exp_manual.sh $d1
./l2_management_exp_manual.sh $d1
./l2_recharge_exp_manual.sh $d1
./l2_recurring_exp_manual.sh $d1
./l2_sms_exp_manual.sh $d1
./l2_transfer_exp_manual.sh $d1
./l2_voice_exp_manual.sh $d1
d=`date`
echo " ${d}export completed for ${d1}" >> /data02/scripts/process/bin/hadoop.log
sleep 15

./l2_adjustment_exp_manual.sh $d2
./l2_content_exp_manual.sh $d2
./l2_data_exp_manual.sh $d2
./l2_management_exp_manual.sh $d2
./l2_recharge_exp_manual.sh $d2
./l2_recurring_exp_manual.sh $d2
./l2_sms_exp_manual.sh $d2
./l2_transfer_exp_manual.sh $d2
./l2_voice_exp_manual.sh $d2
d=`date`
echo " ${d}export completed for ${d2}" >> /data02/scripts/process/bin/hadoop.log
sleep 1

./l2_adjustment_exp_manual.sh $d3
./l2_content_exp_manual.sh $d3
./l2_data_exp_manual.sh $d3
./l2_management_exp_manual.sh $d3
./l2_recharge_exp_manual.sh $d3
./l2_recurring_exp_manual.sh $d3
./l2_sms_exp_manual.sh $d3
./l2_transfer_exp_manual.sh $d3
./l2_voice_exp_manual.sh $d3
d=`date`
echo " ${d}export completed for ${d3}" >> /data02/scripts/process/bin/hadoop.log
sleep 1

./l2_adjustment_exp_manual.sh $d4
./l2_content_exp_manual.sh $d4
./l2_data_exp_manual.sh $d4
./l2_management_exp_manual.sh $d4
./l2_recharge_exp_manual.sh $d4
./l2_recurring_exp_manual.sh $d4
./l2_sms_exp_manual.sh $d4
./l2_transfer_exp_manual.sh $d4
./l2_voice_exp_manual.sh $d4
d=`date`
echo " ${d} export completed for ${d4}" >> /data02/scripts/process/bin/hadoop.log
sleep 1

./l2_adjustment_exp_manual.sh $d5
./l2_content_exp_manual.sh $d5
./l2_data_exp_manual.sh $d5
./l2_management_exp_manual.sh $d5
./l2_recharge_exp_manual.sh $d5
./l2_recurring_exp_manual.sh $d5
./l2_sms_exp_manual.sh $d5
./l2_transfer_exp_manual.sh $d5
./l2_voice_exp_manual.sh $d5
d=`date`
echo " ${d}export completed for ${d5}" >> /data02/scripts/process/bin/hadoop.log

cd /data02/l2_csv_export_dump/

sshpass -p "dwhadmin" scp *${d1}.csv *${d2}.csv *${d3}.csv *${d4}.csv *${d5}.csv dwhadmin@192.168.61.207:/data02/csv_export_dump/

d=`date`
echo " ${d} file transfer completed" >> /data02/scripts/process/bin/hadoop.log

 RESULT=$?
 if [ $RESULT -eq 0 ]; then
   rm -f *$d1.csv *$d2.csv *$d3.csv *$d4.csv *$d5.csv
 else
  	echo "transfer error code ${RESULT}"
	 exit 2
 fi

d=`date`
echo " ${d} load start in hadoop " >> /data02/scripts/process/bin/hadoop.log

sshpass -p 'root335' ssh -o StrictHostKeyChecking=no root@192.168.61.207 sh /data02/scripts/process/bin/loading_l2/cron_l2_load_manual_5days.sh ${d1} ${d2} ${d3} ${d4} ${d5}

 RESULT2=$?
 if [ $RESULT2 -eq 0 ]; then
	d=`date`
	echo " ${d} load end " >> /data02/scripts/process/bin/hadoop.log
 else
	d=`date`
	echo " ${d} hadoop load error $RESULT2 " >> /data02/scripts/process/bin/hadoop.log
	 exit 2
 fi