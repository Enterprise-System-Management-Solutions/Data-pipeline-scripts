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
#dt="20200306"
echo $dt


./registration_voice_procc_backlog.sh voice ${dt}00
./registration_voice_procc_backlog.sh voice ${dt}01
./registration_voice_procc_backlog.sh voice ${dt}02
./registration_voice_procc_backlog.sh voice ${dt}03
./registration_voice_procc_backlog.sh voice ${dt}04
./registration_voice_procc_backlog.sh voice ${dt}05
./registration_voice_procc_backlog.sh voice ${dt}06
./registration_voice_procc_backlog.sh voice ${dt}07
./registration_voice_procc_backlog.sh voice ${dt}08
./registration_voice_procc_backlog.sh voice ${dt}09
./registration_voice_procc_backlog.sh voice ${dt}10
./registration_voice_procc_backlog.sh voice ${dt}11
./registration_voice_procc_backlog.sh voice ${dt}12
./registration_voice_procc_backlog.sh voice ${dt}13
./registration_voice_procc_backlog.sh voice ${dt}14
./registration_voice_procc_backlog.sh voice ${dt}15
./registration_voice_procc_backlog.sh voice ${dt}16
./registration_voice_procc_backlog.sh voice ${dt}17
./registration_voice_procc_backlog.sh voice ${dt}18
./registration_voice_procc_backlog.sh voice ${dt}19
./registration_voice_procc_backlog.sh voice ${dt}20
./registration_voice_procc_backlog.sh voice ${dt}21
./registration_voice_procc_backlog.sh voice ${dt}22
./registration_voice_procc_backlog.sh voice ${dt}23
