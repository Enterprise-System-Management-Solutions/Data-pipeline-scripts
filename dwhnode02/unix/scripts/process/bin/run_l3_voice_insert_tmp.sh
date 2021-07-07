#!/bin/bash
##Auther: Tareq 
## date :29-Jan-2020
## purpose : to run the jobs for L3 Insert from L3

#dt=`date '+%Y%m%d'`
#dt=`date -d yesterday '+%Y%m%d'`
dt='20200317'
cd /data02/scripts/process/bin/

./p_l2_to_l3_voice_tmp.sh $dt
