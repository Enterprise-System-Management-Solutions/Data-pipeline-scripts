#!/bin/bash


##Auther: khairul
## date : 21-Dec-2019
## purpose : to run the jobs for coping all files from source to target dir

###clear allzero size files
find  /data02/cbs_cdrs/adj/merge_dir -type f -size 0 -print | xargs rm
find  /data02/cbs_cdrs/clr/merge_dir -type f -size 0 -print | xargs rm
find  /data02/cbs_cdrs/cm/merge_dir -type f -size 0 -print | xargs rm
find  /data02/cbs_cdrs/com/merge_dir -type f -size 0 -print | xargs rm
find  /data02/cbs_cdrs/data/merge_dir -type f -size 0 -print | xargs rm
find  /data02/cbs_cdrs/mon/merge_dir -type f -size 0 -print | xargs rm
find  /data02/cbs_cdrs/recharge/merge_dir  -type f -size 0 -print | xargs rm
find  /data02/cbs_cdrs/sms/merge_dir -type f -size 0 -print | xargs rm
find  /data02/cbs_cdrs/transfer/merge_dir  -type f -size 0 -print | xargs rm
find  /data02/cbs_cdrs/voice/merge_dir -type f -size 0 -print | xargs rm
find  /data02/cbs_cdrs/vou/merge_dir -type f -size 0 -print | xargs rm

####


cd /data02/scripts/process/bin/file_registration

#dt=`date -d yesterday '+%Y%m%d%H'`
dt=`date '+%Y%m%d%H'`
#dt="20200204"
echo $dt
sleep 10
sh /data02/scripts/process/bin/file_registration/registration_all_final_dump.sh vou $dt
sleep 10
sh /data02/scripts/process/bin/file_registration/registration_all_final_dump.sh  adj $dt
sleep 10
sh /data02/scripts/process/bin/file_registration/registration_all_final_dump.sh cm $dt
sleep 10
sh /data02/scripts/process/bin/file_registration/registration_all_final_dump.sh com $dt           
sleep 10
sh /data02/scripts/process/bin/file_registration/registration_all_final_dump.sh data $dt
sleep 10
sh /data02/scripts/process/bin/file_registration/registration_all_final_dump.sh mon $dt
sleep 10
sh /data02/scripts/process/bin/file_registration/registration_all_final_dump.sh sms $dt
sleep 10
sh /data02/scripts/process/bin/file_registration/registration_all_final_dump.sh transfer $dt
sleep 10
sh /data02/scripts/process/bin/file_registration/registration_all_final_dump.sh voice $dt

