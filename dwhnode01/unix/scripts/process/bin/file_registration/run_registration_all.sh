#!/bin/bash


##Auther: khairul
## date : 21-Dec-2019
## purpose : to run the jobs for coping all files from source to target dir

###clear allzero size files

cd /data02/scripts/process/bin/file_registration



###clear allzero size files
./clear_zero_size_files.sh


#dt=`date -d yesterday '+%Y%m%d%H'`
dt=`date '+%Y'`
#dt="20200611"
#dt="2020"
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

