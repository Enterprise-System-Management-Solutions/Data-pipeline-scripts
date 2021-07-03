#!/bin/bash
##Auther: Tareq
## date : 21-Dec-2019
## purpose : to run the jobs for coping all files from source to target dir
cd /data02/scripts/process/bin/file_registration/reg_to_process/backlog

#dt=`date -d '-2 days' '+%Y%m%d'`
##dt=`date -d yesterday '+%Y%m%d'`
##dt=`date  '+%Y%m%d%H'`
#dt=`date '+%Y%m%d'`
dt=$1
#dt="20200612"
echo $dt


./registration_transfer_procc_backlog.sh transfer ${dt}00
./registration_transfer_procc_backlog.sh transfer ${dt}01
./registration_transfer_procc_backlog.sh transfer ${dt}02
./registration_transfer_procc_backlog.sh transfer ${dt}03
./registration_transfer_procc_backlog.sh transfer ${dt}04
./registration_transfer_procc_backlog.sh transfer ${dt}05
./registration_transfer_procc_backlog.sh transfer ${dt}06
./registration_transfer_procc_backlog.sh transfer ${dt}07
./registration_transfer_procc_backlog.sh transfer ${dt}08
./registration_transfer_procc_backlog.sh transfer ${dt}09
./registration_transfer_procc_backlog.sh transfer ${dt}10
./registration_transfer_procc_backlog.sh transfer ${dt}11
./registration_transfer_procc_backlog.sh transfer ${dt}12
./registration_transfer_procc_backlog.sh transfer ${dt}13
./registration_transfer_procc_backlog.sh transfer ${dt}14
./registration_transfer_procc_backlog.sh transfer ${dt}15
./registration_transfer_procc_backlog.sh transfer ${dt}16
./registration_transfer_procc_backlog.sh transfer ${dt}17
./registration_transfer_procc_backlog.sh transfer ${dt}18
./registration_transfer_procc_backlog.sh transfer ${dt}19
./registration_transfer_procc_backlog.sh transfer ${dt}20
./registration_transfer_procc_backlog.sh transfer ${dt}21
./registration_transfer_procc_backlog.sh transfer ${dt}22
./registration_transfer_procc_backlog.sh transfer ${dt}23
