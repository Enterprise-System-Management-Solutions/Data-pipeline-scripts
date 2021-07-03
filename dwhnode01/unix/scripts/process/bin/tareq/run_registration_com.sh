#!/bin/bash
##Auther: Tareq
## date : 02-Jan-2020
## purpose : to run the jobs for coping com files from source to target dir
##* */3 * * * sh /data02/scripts/process/bin/tareq/run_registration_com.sh >> /data02/scripts/process/log/file_registration_com.log
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

sh ./registration_com.sh com    $dt01
sleep 10
sh ./registration_com.sh com    $dt02
sleep 10
sh ./registration_com.sh com    $dt03
sleep 10
sh ./registration_com.sh com    $dt04
sleep 10
sh ./registration_com.sh com    $dt05
sleep 10
sh ./registration_com.sh com    $dt06
sleep 10
sh ./registration_com.sh com    $dt07
sleep 10
sh ./registration_com.sh com    $dt08
sleep 10
sh ./registration_com.sh com    $dt09
sleep 10
sh ./registration_com.sh com    $dt10
sleep 10
sh ./registration_com.sh com    $dt11
sleep 10
sh ./registration_com.sh com    $dt12
sleep 10
sh ./registration_com.sh com    $dt13
sleep 10
sh ./registration_com.sh com    $dt14
sleep 10
sh ./registration_com.sh com    $dt15
sleep 10
sh ./registration_com.sh com    $dt16
sleep 10
sh ./registration_com.sh com    $dt17
sleep 10
sh ./registration_com.sh com    $dt18
sleep 10
sh ./registration_com.sh com    $dt19
sleep 10
sh ./registration_com.sh com    $dt20
sleep 10
sh ./registration_com.sh com    $dt21
sleep 10
sh ./registration_com.sh com    $dt22
sleep 10
sh ./registration_com.sh com    $dt23
sleep 10
sh ./registration_com.sh com    $dt
