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

./registration_data_procc_backlog.sh data ${dt}00
./registration_data_procc_backlog.sh data ${dt}01
./registration_data_procc_backlog.sh data ${dt}02
./registration_data_procc_backlog.sh data ${dt}03
./registration_data_procc_backlog.sh data ${dt}04
./registration_data_procc_backlog.sh data ${dt}05
./registration_data_procc_backlog.sh data ${dt}06
./registration_data_procc_backlog.sh data ${dt}07
./registration_data_procc_backlog.sh data ${dt}08
./registration_data_procc_backlog.sh data ${dt}09
./registration_data_procc_backlog.sh data ${dt}10
./registration_data_procc_backlog.sh data ${dt}11
./registration_data_procc_backlog.sh data ${dt}12
./registration_data_procc_backlog.sh data ${dt}13
./registration_data_procc_backlog.sh data ${dt}14
./registration_data_procc_backlog.sh data ${dt}15
./registration_data_procc_backlog.sh data ${dt}16
./registration_data_procc_backlog.sh data ${dt}17
./registration_data_procc_backlog.sh data ${dt}18
./registration_data_procc_backlog.sh data ${dt}19
./registration_data_procc_backlog.sh data ${dt}20
./registration_data_procc_backlog.sh data ${dt}21
./registration_data_procc_backlog.sh data ${dt}22
./registration_data_procc_backlog.sh data ${dt}23
