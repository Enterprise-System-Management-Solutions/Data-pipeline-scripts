cd /data02/scripts/process/bin/unit_offer/file_reg

dt=`date -d yesterday '+%Y%m%d'`

./fou_sb.sh $dt 
./fuo_dpm.sh $dt
./fuo_lt.sh $dt
./fuo_osa.sh $dt
./fuo_osd.sh $dt
./fuo_pn.sh $dt
./fuo_sat.sh $dt
./fuo_slct.sh $dt
./fuo_sm.sh $dt
./fuo_tabm.sh $dt
./fuo_tab.sh $dt
./fuo_tboi.sh $dt
./fuo_tpfu.sh $dt
./fuo_tsi.sh $dt
./fuo_wusa.sh $dt
