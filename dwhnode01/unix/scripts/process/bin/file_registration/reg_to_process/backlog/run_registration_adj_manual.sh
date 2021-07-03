#!/bin/bash

##Auther: Tareq
## date : 21-Dec-2019
## purpose : to run the jobs for coping all files from source to target dir
cd /data02/scripts/process/bin/file_registration/reg_to_process/backlog

#dt=`date -d '-2 days' '+%Y%m%d'`
#dt=`date -d yesterday '+%Y%m%d'`
#dt=`date  '+%Y%m%d%H'`
#dt=`date '+%Y%m%d'`
dt=$1
#dt="20200305"
echo $dt

./registration_adj_procc_backlog.sh adj ${dt}00
./registration_adj_procc_backlog.sh adj ${dt}01
./registration_adj_procc_backlog.sh adj ${dt}02
./registration_adj_procc_backlog.sh adj ${dt}03
./registration_adj_procc_backlog.sh adj ${dt}04
./registration_adj_procc_backlog.sh adj ${dt}05
./registration_adj_procc_backlog.sh adj ${dt}06
./registration_adj_procc_backlog.sh adj ${dt}07
./registration_adj_procc_backlog.sh adj ${dt}08
./registration_adj_procc_backlog.sh adj ${dt}09
./registration_adj_procc_backlog.sh adj ${dt}10
./registration_adj_procc_backlog.sh adj ${dt}11
./registration_adj_procc_backlog.sh adj ${dt}12
./registration_adj_procc_backlog.sh adj ${dt}13
./registration_adj_procc_backlog.sh adj ${dt}14
./registration_adj_procc_backlog.sh adj ${dt}15
./registration_adj_procc_backlog.sh adj ${dt}16
./registration_adj_procc_backlog.sh adj ${dt}17
./registration_adj_procc_backlog.sh adj ${dt}18
./registration_adj_procc_backlog.sh adj ${dt}19
./registration_adj_procc_backlog.sh adj ${dt}20
./registration_adj_procc_backlog.sh adj ${dt}21
./registration_adj_procc_backlog.sh adj ${dt}22
./registration_adj_procc_backlog.sh adj ${dt}23
