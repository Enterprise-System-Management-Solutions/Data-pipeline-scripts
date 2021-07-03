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
#dt="20200611"
echo $dt

./registration_com_procc_backlog.sh com ${dt}00
./registration_com_procc_backlog.sh com ${dt}01
./registration_com_procc_backlog.sh com ${dt}02
./registration_com_procc_backlog.sh com ${dt}03
./registration_com_procc_backlog.sh com ${dt}04
./registration_com_procc_backlog.sh com ${dt}05
./registration_com_procc_backlog.sh com ${dt}06
./registration_com_procc_backlog.sh com ${dt}07
./registration_com_procc_backlog.sh com ${dt}08
./registration_com_procc_backlog.sh com ${dt}09
./registration_com_procc_backlog.sh com ${dt}10
./registration_com_procc_backlog.sh com ${dt}11
./registration_com_procc_backlog.sh com ${dt}12
./registration_com_procc_backlog.sh com ${dt}13
./registration_com_procc_backlog.sh com ${dt}14
./registration_com_procc_backlog.sh com ${dt}15
./registration_com_procc_backlog.sh com ${dt}16
./registration_com_procc_backlog.sh com ${dt}17
./registration_com_procc_backlog.sh com ${dt}18
./registration_com_procc_backlog.sh com ${dt}19
./registration_com_procc_backlog.sh com ${dt}20
./registration_com_procc_backlog.sh com ${dt}21
./registration_com_procc_backlog.sh com ${dt}22
./registration_com_procc_backlog.sh com ${dt}23
