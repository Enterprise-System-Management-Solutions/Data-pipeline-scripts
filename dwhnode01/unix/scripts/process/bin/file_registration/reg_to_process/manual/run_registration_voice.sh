

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

#sleep 10
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}00
#sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}01
#sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}02
#sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}03
#sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}04
#sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}05
#sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}06
#sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}07
#sleep 10
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}08
#sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}09
#sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}10
#sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}11
#sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}12
#sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}13
#sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}14
#sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}15
#sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}16
#sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}17
#sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}18
#sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}19
#sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}20
#sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}21
#sleep 10                                                                    
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}22
#sleep 10                                                                     
sh /data02/scripts/process/bin/file_registration/reg_to_process/registration_voice_procc.sh voice ${dt}23

