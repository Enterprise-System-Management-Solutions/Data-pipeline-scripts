

#!/bin/bash


##Auther: khairul
## date : 21-Dec-2019
## purpose : to run the jobs for coping all files from source to target dir

cd /data02/scripts/process/bin/file_registration

#dt=`date -d yesterday '+%Y%m%d%H'`
##dt=`date -d '-12 day' '+%Y%m%d%H'`

dt=2020010612

echo $dt
leep 10
sh ./run_registration_merge_file.sh vou $dt
sleep 10
sh ./run_registration_merge_file.sh  adj $dt
sleep 10
sh ./ run_registration_merge_file.sh cm $dt
sleep 10
sh ./run_registration_merge_file.sh com $dt           
sleep 10
sh ./run_registration_merge_file.sh data $dt
sleep 10
sh ./run_registration_merge_file.sh mon $dt
sleep 10
sh ./run_registration_merge_file.sh sms $dt
sleep 10
sh ./run_registration_merge_file.sh transfer $dt
sleep 10
sh ./run_registration_merge_file.sh clr $dt
sleep 10
sh ./run_registration_merge_file.sh recharge $dt
