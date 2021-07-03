#!/bin/bash
##Auther: Tareq
## date : 21-Dec-2019
## purpose : to run the jobs for coping all files from source to target dir
cd /data02/scripts/process/bin/file_registration/reg_to_process/backlog

#dt=`date -d '-2 days' '+%Y%m%d'`
#dt=`date -d yesterday '+%Y%m%d'`
##dt=`date  '+%Y%m%d%H'`
#dt=`date '+%Y%m%d'`
dt=$1
#dt="20200306"
echo $dt


./registration_sms_procc_backlog.sh sms ${dt}00
./registration_sms_procc_backlog.sh sms ${dt}01
./registration_sms_procc_backlog.sh sms ${dt}02
./registration_sms_procc_backlog.sh sms ${dt}03
./registration_sms_procc_backlog.sh sms ${dt}04
./registration_sms_procc_backlog.sh sms ${dt}05
./registration_sms_procc_backlog.sh sms ${dt}06
./registration_sms_procc_backlog.sh sms ${dt}07
./registration_sms_procc_backlog.sh sms ${dt}08
./registration_sms_procc_backlog.sh sms ${dt}09
./registration_sms_procc_backlog.sh sms ${dt}10
./registration_sms_procc_backlog.sh sms ${dt}11
./registration_sms_procc_backlog.sh sms ${dt}12
./registration_sms_procc_backlog.sh sms ${dt}13
./registration_sms_procc_backlog.sh sms ${dt}14
./registration_sms_procc_backlog.sh sms ${dt}15
./registration_sms_procc_backlog.sh sms ${dt}16
./registration_sms_procc_backlog.sh sms ${dt}17
./registration_sms_procc_backlog.sh sms ${dt}18
./registration_sms_procc_backlog.sh sms ${dt}19
./registration_sms_procc_backlog.sh sms ${dt}20
./registration_sms_procc_backlog.sh sms ${dt}21
./registration_sms_procc_backlog.sh sms ${dt}22
./registration_sms_procc_backlog.sh sms ${dt}23
