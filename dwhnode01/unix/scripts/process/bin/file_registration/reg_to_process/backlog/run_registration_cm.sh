#!/bin/bash
##Auther: Tareq
## date : 21-Dec-2019
## purpose : to run the jobs for coping all files from source to target dir
cd /data02/scripts/process/bin/file_registration/reg_to_process/backlog

#dt=`date -d '-2 days' '+%Y%m%d'`
dt=`date -d yesterday '+%Y%m%d'`
##dt=`date  '+%Y%m%d%H'`
#dt=`date '+%Y%m%d'`
##dt=$1
#dt="20200306"
echo $dt

./registration_cm_procc_backlog.sh cm ${dt}00
./registration_cm_procc_backlog.sh cm ${dt}01
./registration_cm_procc_backlog.sh cm ${dt}02
./registration_cm_procc_backlog.sh cm ${dt}03
./registration_cm_procc_backlog.sh cm ${dt}04
./registration_cm_procc_backlog.sh cm ${dt}05
./registration_cm_procc_backlog.sh cm ${dt}06
./registration_cm_procc_backlog.sh cm ${dt}07
./registration_cm_procc_backlog.sh cm ${dt}08
./registration_cm_procc_backlog.sh cm ${dt}09
./registration_cm_procc_backlog.sh cm ${dt}10
./registration_cm_procc_backlog.sh cm ${dt}11
./registration_cm_procc_backlog.sh cm ${dt}12
./registration_cm_procc_backlog.sh cm ${dt}13
./registration_cm_procc_backlog.sh cm ${dt}14
./registration_cm_procc_backlog.sh cm ${dt}15
./registration_cm_procc_backlog.sh cm ${dt}16
./registration_cm_procc_backlog.sh cm ${dt}17
./registration_cm_procc_backlog.sh cm ${dt}18
./registration_cm_procc_backlog.sh cm ${dt}19
./registration_cm_procc_backlog.sh cm ${dt}20
./registration_cm_procc_backlog.sh cm ${dt}21
./registration_cm_procc_backlog.sh cm ${dt}22
./registration_cm_procc_backlog.sh cm ${dt}23
