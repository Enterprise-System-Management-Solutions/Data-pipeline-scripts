

#!/bin/bash


##Auther: Tareq
## date : 21-Dec-2019
## purpose : to run the jobs for coping all files from source to target dir

cd /data02/scripts/process/bin/file_registration

###dt=`date -d yesterday '+%Y%m%d'`
###dt=`date  '+%Y%m%d%H'`
#dt=`date '+%Y%m%d%H'`
#dt=$1
dt="20200404"
echo $dt

sleep 10
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}00
sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}01
sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}02
sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}03
sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}04
sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}05
sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}06
sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}07
sleep 10
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}08
sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}09
sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}10
sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}11
sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}12
sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}13
sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}14
sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}15
sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}16
sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}17
sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}18
sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}19
sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}20
sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}21
sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}22
sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_transfer_procc.sh transfer ${dt}23

