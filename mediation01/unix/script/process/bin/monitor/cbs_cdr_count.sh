dt=`date --date="1 day ago" '+%Y%m%d'`
dt2=`date --date="1 day ago" '+%d/%m/%Y'`

cd /data02/cbs_dump/

#v1=`ls *adj_${dt}0*.add |wc -l`
#v2=`ls *adj_${dt}1*.add |wc -l`
#v3=`ls *adj_${dt}2*.add |wc -l`
v4=`ls *cm_${dt}0*.add |wc -l`
v5=`ls *cm_${dt}1*.add |wc -l`
v6=`ls *cm_${dt}2*.add |wc -l`
v7=`ls *com_${dt}0*.add |wc -l`
v8=`ls *com_${dt}1*.add |wc -l`
v9=`ls *com_${dt}2*.add |wc -l`
v10=`ls -l *data_${dt}0*.add |wc -l`
v11=`ls -l *data_${dt}1*.add |wc -l`
v12=`ls -l *data_${dt}2*.add |wc -l`
v13=`ls *mon_${dt}0*.add |wc -l`
v14=`ls *mon_${dt}1*.add |wc -l`
v15=`ls *mon_${dt}2*.add |wc -l`
v16=`ls *sms_${dt}0*.add |wc -l`
v17=`ls *sms_${dt}1*.add |wc -l`
v18=`ls *sms_${dt}2*.add |wc -l`
v19=`ls *transfer_${dt}*.add |wc -l`
v20=`ls *voice_${dt}0*.add |wc -l`
v21=`ls *voice_${dt}1*.add |wc -l`
v22=`ls *voice_${dt}2*.add |wc -l`
v23=`ls *vou_${dt}00*.add |wc -l`
v24=`ls *vou_${dt}01*.add |wc -l`
v25=`ls *vou_${dt}02*.add |wc -l`
v26=`ls *vou_${dt}03*.add |wc -l`
v27=`ls *vou_${dt}04*.add |wc -l`
v28=`ls *vou_${dt}05*.add |wc -l`
v29=`ls *vou_${dt}06*.add |wc -l`
v30=`ls *vou_${dt}07*.add |wc -l`
v31=`ls *vou_${dt}08*.add |wc -l`
v32=`ls *vou_${dt}09*.add |wc -l`
v33=`ls *vou_${dt}10*.add |wc -l`
v34=`ls *vou_${dt}11*.add |wc -l`
v35=`ls *vou_${dt}12*.add |wc -l`
v36=`ls *vou_${dt}13*.add |wc -l`
v37=`ls *vou_${dt}14*.add |wc -l`
v38=`ls *vou_${dt}15*.add |wc -l`
v39=`ls *vou_${dt}16*.add |wc -l`
v40=`ls *vou_${dt}17*.add |wc -l`
v41=`ls *vou_${dt}18*.add |wc -l`
v42=`ls *vou_${dt}19*.add |wc -l`
v43=`ls *vou_${dt}20*.add |wc -l`
v44=`ls *vou_${dt}21*.add |wc -l`
v45=`ls *vou_${dt}22*.add |wc -l`
v46=`ls *vou_${dt}23*.add |wc -l`
##adjust new##
v50=`ls *adj_${dt}00*.add |wc -l`
v51=`ls *adj_${dt}01*.add |wc -l`
v52=`ls *adj_${dt}02*.add |wc -l`
v53=`ls *adj_${dt}03*.add |wc -l`
v54=`ls *adj_${dt}04*.add |wc -l`
v55=`ls *adj_${dt}05*.add |wc -l`
v56=`ls *adj_${dt}06*.add |wc -l`
v57=`ls *adj_${dt}07*.add |wc -l`
v58=`ls *adj_${dt}08*.add |wc -l`
v59=`ls *adj_${dt}09*.add |wc -l`
v60=`ls *adj_${dt}10*.add |wc -l`
v61=`ls *adj_${dt}11*.add |wc -l`
v62=`ls *adj_${dt}12*.add |wc -l`
v63=`ls *adj_${dt}13*.add |wc -l`
v64=`ls *adj_${dt}14*.add |wc -l`
v65=`ls *adj_${dt}15*.add |wc -l`
v66=`ls *adj_${dt}16*.add |wc -l`
v67=`ls *adj_${dt}17*.add |wc -l`
v68=`ls *adj_${dt}18*.add |wc -l`
v69=`ls *adj_${dt}19*.add |wc -l`
v70=`ls *adj_${dt}20*.add |wc -l`
v71=`ls *adj_${dt}21*.add |wc -l`
v72=`ls *adj_${dt}22*.add |wc -l`
v73=`ls *adj_${dt}23*.add |wc -l`


#echo "${dt2}|adj|${v1}"
#echo "${dt2}|adj|${v2}"
#echo "${dt2}|adj|${v3}"
echo "${dt2}|cm|${v4}"
echo "${dt2}|cm|${v5}"
echo "${dt2}|cm|${v6}"
echo "${dt2}|com|${v7}"
echo "${dt2}|com|${v8}"
echo "${dt2}|com|${v9}"
echo "${dt2}|data|${v10}"
echo "${dt2}|data|${v11}"
echo "${dt2}|data|${v12}"
echo "${dt2}|mon|${v13}"
echo "${dt2}|mon|${v14}"
echo "${dt2}|mon|${v15}"
echo "${dt2}|sms|${v16}"
echo "${dt2}|sms|${v17}"
echo "${dt2}|sms|${v18}"
echo "${dt2}|transfer|${v19}"
echo "${dt2}|voice|${v20}"
echo "${dt2}|voice|${v21}"
echo "${dt2}|voice|${v22}"
echo "${dt2}|vou|${v23}"
echo "${dt2}|vou|${v24}"
echo "${dt2}|vou|${v25}"
echo "${dt2}|vou|${v26}"
echo "${dt2}|vou|${v27}"
echo "${dt2}|vou|${v28}"
echo "${dt2}|vou|${v29}"
echo "${dt2}|vou|${v30}"
echo "${dt2}|vou|${v31}"
echo "${dt2}|vou|${v32}"
echo "${dt2}|vou|${v33}"
echo "${dt2}|vou|${v34}"
echo "${dt2}|vou|${v35}"
echo "${dt2}|vou|${v36}"
echo "${dt2}|vou|${v37}"
echo "${dt2}|vou|${v38}"
echo "${dt2}|vou|${v39}"
echo "${dt2}|vou|${v40}"
echo "${dt2}|vou|${v41}"
echo "${dt2}|vou|${v42}"
echo "${dt2}|vou|${v43}"
echo "${dt2}|vou|${v44}"
echo "${dt2}|vou|${v45}"
echo "${dt2}|vou|${v46}"
echo "${dt2}|adj|${v50}"
echo "${dt2}|adj|${v51}"
echo "${dt2}|adj|${v52}"
echo "${dt2}|adj|${v53}"
echo "${dt2}|adj|${v54}"
echo "${dt2}|adj|${v55}"
echo "${dt2}|adj|${v56}"
echo "${dt2}|adj|${v57}"
echo "${dt2}|adj|${v58}"
echo "${dt2}|adj|${v59}"
echo "${dt2}|adj|${v60}"
echo "${dt2}|adj|${v61}"
echo "${dt2}|adj|${v62}"
echo "${dt2}|adj|${v63}"
echo "${dt2}|adj|${v64}"
echo "${dt2}|adj|${v65}"
echo "${dt2}|adj|${v66}"
echo "${dt2}|adj|${v67}"
echo "${dt2}|adj|${v68}"
echo "${dt2}|adj|${v69}"
echo "${dt2}|adj|${v70}"
echo "${dt2}|adj|${v71}"
echo "${dt2}|adj|${v72}"
echo "${dt2}|adj|${v73}"
