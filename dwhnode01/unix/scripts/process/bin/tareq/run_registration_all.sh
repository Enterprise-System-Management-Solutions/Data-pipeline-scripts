

#!/bin/bash


##Auther: khairul
## date : 21-Dec-2019
## purpose : to run the jobs for coping all files from source to target dir

cd /data02/scripts/process/bin

#dt=`date -d yesterday '+%Y%m%d%H'`
dt=`date -d '-12 day' '+%Y%m%d%H'`

echo $dt


sh ./registration_all_final.sh voice    $dtq
sleep 10
sh ./registration_all_final.sh vou      $dt
sleep 10 
sh ./registration_all_final.sh    adj      $dt
sleep 10
sh ./registration_all_final.sh      $dt
sleep 10
sh ./ registration_all_final.sh cm       $dt
sleep 10
sh ./registration_all.sh com      $dt
sleep 10
sh ./registration_all_final.sh data     $dt
sleep 10
sh ./registration_all_final.sh mon      $dt
sleep 10
sh ./registration_all.sh sms      $dt
sleep 10
sh ./registration_all.sh transfer $dt

