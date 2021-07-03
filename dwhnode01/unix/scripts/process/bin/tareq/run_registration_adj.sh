#!/bin/bash
##Auther: Laila
## date : 02-Jan-2020
## purpose : to run the jobs for coping adj files from source to target dir
##* */3 * * * sh /data02/scripts/process/bin/tareq/run_registration_adj.sh >> /data02/scripts/process/log/file_registration_adj.log
cd /data02/scripts/process/bin/tareq

dt=`date -d yesterday '+%Y%m%d%H'`
#dt=`date -d '-12 day' '+%Y%m%d'`
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


sh ./registration_adj.sh adj    $dt01
sleep 10
sh ./registration_adj.sh adj    $dt02
sleep 10
sh ./registration_adj.sh adj    $dt03
sleep 10
sh ./registration_adj.sh adj    $dt04
sleep 10
sh ./registration_adj.sh adj    $dt05
sleep 10
sh ./registration_adj.sh adj    $dt06
sleep 10
sh ./registration_adj.sh adj    $dt07
sleep 10
sh ./registration_adj.sh adj    $dt08
sleep 10
sh ./registration_adj.sh adj    $dt09
sleep 10
sh ./registration_adj.sh adj    $dt10
sleep 10
sh ./registration_adj.sh adj    $dt11
sleep 10
sh ./registration_adj.sh adj    $dt12
sleep 10
sh ./registration_adj.sh adj    $dt13
sleep 10
sh ./registration_adj.sh adj    $dt14
sleep 10
sh ./registration_adj.sh adj    $dt15
sleep 10
sh ./registration_adj.sh adj    $dt16
sleep 10
sh ./registration_adj.sh adj    $dt17
sleep 10
sh ./registration_adj.sh adj    $dt18
sleep 10
sh ./registration_adj.sh adj    $dt19
sleep 10
sh ./registration_adj.sh adj    $dt20
sleep 10
sh ./registration_adj.sh adj    $dt21
sleep 10
sh ./registration_adj.sh adj    $dt22
sleep 10
sh ./registration_adj.sh adj    $dt23
sleep 10
sh ./registration_adj.sh adj    $dt
