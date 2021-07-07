#Author :       Tareq
#Date   :       23-05-2020
#!/bin/bash

cd /tmp/

dt=`date -d yesterday  '+%d%m%Y'`
#zdir=/data01/ntmc_dir
zdir=/tmp
sshpass -p "LandRND@@BI" scp corona_333_ivr_$dt.csv corona_16263_ivr_$dt.csv root@192.168.61.253:$zdir
