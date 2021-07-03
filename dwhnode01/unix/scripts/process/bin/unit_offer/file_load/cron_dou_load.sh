cd /data02/scripts/process/bin/unit_offer/file_load
dt=`date -d yesterday '+%Y%m%d'`
./load_fuo_dpm.sh $dt
./load_fuo_lt.sh $dt
./load_fuo_osa.sh $dt
./load_fuo_osd.sh $dt
./load_fuo_pn.sh $dt
./load_fuo_sat.sh $dt
./load_fuo_sb.sh $dt
./load_fuo_slct.sh $dt
./load_fuo_sm.sh $dt
./load_fuo_tabm.sh $dt
./load_fuo_tab.sh $dt
./load_fuo_tboi.sh $dt
./load_fuo_tpfu.sh $dt
./load_fuo_tsi.sh $dt
./load_fuo_wusa.sh $dt

