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

./registration_mon_procc_backlog.sh mon ${dt}00
./registration_mon_procc_backlog.sh mon ${dt}01
./registration_mon_procc_backlog.sh mon ${dt}02
./registration_mon_procc_backlog.sh mon ${dt}03
./registration_mon_procc_backlog.sh mon ${dt}04
./registration_mon_procc_backlog.sh mon ${dt}05
./registration_mon_procc_backlog.sh mon ${dt}06
./registration_mon_procc_backlog.sh mon ${dt}07
./registration_mon_procc_backlog.sh mon ${dt}08
./registration_mon_procc_backlog.sh mon ${dt}09
./registration_mon_procc_backlog.sh mon ${dt}10
./registration_mon_procc_backlog.sh mon ${dt}11
./registration_mon_procc_backlog.sh mon ${dt}12
./registration_mon_procc_backlog.sh mon ${dt}13
./registration_mon_procc_backlog.sh mon ${dt}14
./registration_mon_procc_backlog.sh mon ${dt}15
./registration_mon_procc_backlog.sh mon ${dt}16
./registration_mon_procc_backlog.sh mon ${dt}17
./registration_mon_procc_backlog.sh mon ${dt}18
./registration_mon_procc_backlog.sh mon ${dt}19
./registration_mon_procc_backlog.sh mon ${dt}20
./registration_mon_procc_backlog.sh mon ${dt}21
./registration_mon_procc_backlog.sh mon ${dt}22
./registration_mon_procc_backlog.sh mon ${dt}23
