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

./registration_vou_procc_backlog.sh vou ${dt}00
./registration_vou_procc_backlog.sh vou ${dt}01
./registration_vou_procc_backlog.sh vou ${dt}02
./registration_vou_procc_backlog.sh vou ${dt}03
./registration_vou_procc_backlog.sh vou ${dt}04
./registration_vou_procc_backlog.sh vou ${dt}05
./registration_vou_procc_backlog.sh vou ${dt}06
./registration_vou_procc_backlog.sh vou ${dt}07
./registration_vou_procc_backlog.sh vou ${dt}08
./registration_vou_procc_backlog.sh vou ${dt}09
./registration_vou_procc_backlog.sh vou ${dt}10
./registration_vou_procc_backlog.sh vou ${dt}11
./registration_vou_procc_backlog.sh vou ${dt}12
./registration_vou_procc_backlog.sh vou ${dt}13
./registration_vou_procc_backlog.sh vou ${dt}14
./registration_vou_procc_backlog.sh vou ${dt}15
./registration_vou_procc_backlog.sh vou ${dt}16
./registration_vou_procc_backlog.sh vou ${dt}17
./registration_vou_procc_backlog.sh vou ${dt}18
./registration_vou_procc_backlog.sh vou ${dt}19
./registration_vou_procc_backlog.sh vou ${dt}20
./registration_vou_procc_backlog.sh vou ${dt}21
./registration_vou_procc_backlog.sh vou ${dt}22
./registration_vou_procc_backlog.sh vou ${dt}23
