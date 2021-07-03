#Author :       Tareq
#Date   :       03-12-2020
#cbs cdr manual move /data01/cbd to /data02/cbs_cdrs/$source

source=$1

dt=$2

lock=/data02/scripts/process/bin/cbs_${source}_cdr_manual_move  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data05/cbs
chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}00*.add
chmod 775 cbs_cdr_${source}_${dt}00*.add
mv cbs_cdr_${source}_${dt}00*.add  /data02/cbs_cdrs/$source 

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}01*.add
chmod 775 cbs_cdr_${source}_${dt}01*.add
mv cbs_cdr_${source}_${dt}01*.add  /data02/cbs_cdrs/$source 
 
chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}02*.add
chmod 775 cbs_cdr_${source}_${dt}02*.add
mv cbs_cdr_${source}_${dt}02*.add  /data02/cbs_cdrs/$source

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}03*.add
chmod 775 cbs_cdr_${source}_${dt}03*.add
mv cbs_cdr_${source}_${dt}03*.add  /data02/cbs_cdrs/$source 

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}04*.add
chmod 775 cbs_cdr_${source}_${dt}04*.add
mv cbs_cdr_${source}_${dt}04*.add  /data02/cbs_cdrs/$source 

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}05*.add
chmod 775 cbs_cdr_${source}_${dt}05*.add 
mv cbs_cdr_${source}_${dt}05*.add  /data02/cbs_cdrs/$source 

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}06*.add
chmod 775 cbs_cdr_${source}_${dt}06*.add
mv cbs_cdr_${source}_${dt}06*.add  /data02/cbs_cdrs/$source 

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}07*.add
chmod 775 cbs_cdr_${source}_${dt}07*.add
mv cbs_cdr_${source}_${dt}07*.add  /data02/cbs_cdrs/$source 

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}08*.add
chmod 775 cbs_cdr_${source}_${dt}08*.add
mv cbs_cdr_${source}_${dt}08*.add  /data02/cbs_cdrs/$source 

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}09*.add
chmod 775 cbs_cdr_${source}_${dt}09*.add
mv cbs_cdr_${source}_${dt}09*.add  /data02/cbs_cdrs/$source 

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}10*.add
chmod 775 cbs_cdr_${source}_${dt}10*.add
mv cbs_cdr_${source}_${dt}10*.add  /data02/cbs_cdrs/$source 

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}11*.add
chmod 775 cbs_cdr_${source}_${dt}11*.add 
mv cbs_cdr_${source}_${dt}11*.add  /data02/cbs_cdrs/$source 

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}12*.add
chmod 775 cbs_cdr_${source}_${dt}12*.add
mv cbs_cdr_${source}_${dt}12*.add  /data02/cbs_cdrs/$source  

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}13*.add
chmod 775 cbs_cdr_${source}_${dt}13*.add 
mv cbs_cdr_${source}_${dt}13*.add  /data02/cbs_cdrs/$source  

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}14*.add
chmod 775 cbs_cdr_${source}_${dt}14*.add
mv cbs_cdr_${source}_${dt}14*.add  /data02/cbs_cdrs/$source 

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}15*.add
chmod 775 cbs_cdr_${source}_${dt}15*.add
mv cbs_cdr_${source}_${dt}15*.add  /data02/cbs_cdrs/$source 

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}16*.add
chmod 775 cbs_cdr_${source}_${dt}16*.add
mv cbs_cdr_${source}_${dt}16*.add  /data02/cbs_cdrs/$source

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}17*.add
chmod 775 cbs_cdr_${source}_${dt}17*.add
mv cbs_cdr_${source}_${dt}17*.add  /data02/cbs_cdrs/$source 

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}18*.add
chmod 775 cbs_cdr_${source}_${dt}18*.add
mv cbs_cdr_${source}_${dt}18*.add  /data02/cbs_cdrs/$source 

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}19*.add
chmod 775 cbs_cdr_${source}_${dt}19*.add
mv cbs_cdr_${source}_${dt}19*.add  /data02/cbs_cdrs/$source 

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}20*.add
chmod 775 cbs_cdr_${source}_${dt}20*.add
mv cbs_cdr_${source}_${dt}20*.add  /data02/cbs_cdrs/$source 
 
chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}21*.add
chmod 775 cbs_cdr_${source}_${dt}21*.add 
mv cbs_cdr_${source}_${dt}21*.add  /data02/cbs_cdrs/$source 

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}22*.add
chmod 775 cbs_cdr_${source}_${dt}22*.add
mv cbs_cdr_${source}_${dt}22*.add  /data02/cbs_cdrs/$source

chown dwhadmin:dwhadmin cbs_cdr_${source}_${dt}23*.add
chmod 775 cbs_cdr_${source}_${dt}23*.add  
mv cbs_cdr_${source}_${dt}23*.add  /data02/cbs_cdrs/$source


rm -f $lock

fi
