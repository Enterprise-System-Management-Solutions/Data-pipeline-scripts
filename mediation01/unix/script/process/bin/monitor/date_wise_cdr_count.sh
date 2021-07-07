dt=$1

cd /data02/cbs_dump/

#dt=$1

echo "----Start adj for ${dt}---"
ls *adj_${dt}0* |wc -l
ls *adj_${dt}1* |wc -l
ls *adj_${dt}2* |wc -l

echo "----Start cm for ${dt}---"
ls *cm_${dt}0* |wc -l
ls *cm_${dt}1* |wc -l
ls *cm_${dt}2* |wc -l

echo "----Start com for ${dt}---"
ls *com_${dt}0* |wc -l
ls *com_${dt}1* |wc -l
ls *com_${dt}2* |wc -l

echo "----Start data for ${dt}---"
ls -l *data_${dt}0* |wc -l
ls -l *data_${dt}1* |wc -l
ls -l *data_${dt}2* |wc -l

echo "----Start mon for ${dt}---"
ls *mon_${dt}0* |wc -l
ls *mon_${dt}1* |wc -l
ls *mon_${dt}2* |wc -l

echo "----Start sms for ${dt}---"
ls *sms_${dt}0* |wc -l
ls *sms_${dt}1* |wc -l
ls *sms_${dt}2* |wc -l

echo "----Start transfer for ${dt}---"
ls *transfer_${dt}* |wc -l

echo "----Start voice for ${dt}---"
ls *voice_${dt}0* |wc -l
ls *voice_${dt}1* |wc -l
ls *voice_${dt}2* |wc -l

echo "----Start vou for ${dt}---"
ls *vou_${dt}00* |wc -l
ls *vou_${dt}01* |wc -l
ls *vou_${dt}02* |wc -l
ls *vou_${dt}03* |wc -l
ls *vou_${dt}04* |wc -l
ls *vou_${dt}05* |wc -l
ls *vou_${dt}06* |wc -l
ls *vou_${dt}07* |wc -l
ls *vou_${dt}08* |wc -l
ls *vou_${dt}09* |wc -l
ls *vou_${dt}10* |wc -l
ls *vou_${dt}11* |wc -l
ls *vou_${dt}12* |wc -l
ls *vou_${dt}13* |wc -l
ls *vou_${dt}14* |wc -l
ls *vou_${dt}15* |wc -l
ls *vou_${dt}16* |wc -l
ls *vou_${dt}17* |wc -l
ls *vou_${dt}18* |wc -l
ls *vou_${dt}19* |wc -l
ls *vou_${dt}20* |wc -l
ls *vou_${dt}21* |wc -l
ls *vou_${dt}22* |wc -l
ls *vou_${dt}23* |wc -l

echo "-----end--------"

