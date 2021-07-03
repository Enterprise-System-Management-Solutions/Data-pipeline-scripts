cd /data02/scripts/process/bin/loading_l1/
sh esms_cbs01_loader_adj.sh		 >> /data02/scripts/process/adj_load_log
sh esms_cbs01_loader_cm.sh        >> /data02/scripts/process/cm_load_log
sh esms_cbs01_loader_com.sh       >> /data02/scripts/process/com_load_log
sh esms_cbs01_loader_mon.sh       >> /data02/scripts/process/mon_load_log
sh esms_cbs01_loader.sh           >> /data02/scripts/process/data_load_log
sh esms_cbs01_loader_sms.sh       >> /data02/scripts/process/sms_load_log
sh esms_cbs01_loader_transfer.sh  >> /data02/scripts/process/transfer_load_log
sh esms_cbs01_loader_voice.sh     >> /data02/scripts/process/voice_load_log
sh esms_cbs01_loader_vou.sh       >> /data02/scripts/process/vou_load_log:
