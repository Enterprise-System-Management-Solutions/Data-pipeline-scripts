#!/bin/bash
##Auther: Tareq
## date : 02-Jan-2020
## purpose : to run the jobs for coping cm files from source to target dir
##* */3 * * * sh /data02/scripts/process/bin/tareq/run_registration_cm.sh >> /data02/scripts/process/log/file_registration_cm.log
cd /data02/scripts/process/bin/tareq

#dt=`date -d yesterday '+%Y%m%d%H'`
dt=`date -d '-12 day' '+%Y%m%d'`
dt01=${dt}01
dt02=${dt}02
dt03=${dt}03
dt04=${dt}04
dt05=${dt}05
dt06=${dt}06
dt07=${dt}07
dt08=${dt}08
dt09=${dt}09
dt10=${dt}10
dt11=${dt}11
dt12=${dt}12
dt13=${dt}13
dt14=${dt}14
dt15=${dt}15
dt16=${dt}16
dt17=${dt}17
dt18=${dt}18
dt19=${dt}19
dt20=${dt}20
dt21=${dt}21
dt22=${dt}22
dt23=${dt}23

echo $dt


sh ./registration_cm.sh cm    $dt01
sleep 10
sh ./registration_cm.sh cm    $dt02
sleep 10
sh ./registration_cm.sh cm    $dt03
sleep 10
sh ./registration_cm.sh cm    $dt04
sleep 10
sh ./registration_cm.sh cm    $dt05
sleep 10
sh ./registration_cm.sh cm    $dt06
sleep 10
sh ./registration_cm.sh cm    $dt07
sleep 10
sh ./registration_cm.sh cm    $dt08
sleep 10
sh ./registration_cm.sh cm    $dt09
sleep 10
sh ./registration_cm.sh cm    $dt10
sleep 10
sh ./registration_cm.sh cm    $dt11
sleep 10
sh ./registration_cm.sh cm    $dt12
sleep 10
sh ./registration_cm.sh cm    $dt13
sleep 10
sh ./registration_cm.sh cm    $dt14
sleep 10
sh ./registration_cm.sh cm    $dt15
sleep 10
sh ./registration_cm.sh cm    $dt16
sleep 10
sh ./registration_cm.sh cm    $dt17
sleep 10
sh ./registration_cm.sh cm    $dt18
sleep 10
sh ./registration_cm.sh cm    $dt19
sleep 10
sh ./registration_cm.sh cm    $dt20
sleep 10
sh ./registration_cm.sh cm    $dt21
sleep 10
sh ./registration_cm.sh cm    $dt22
sleep 10
sh ./registration_cm.sh cm    $dt23
sleep 10
sh ./registration_cm.sh cm    $dt
