
if ps -ef | grep -v grep | grep  copy_cbs_run.sh ; then
        exit 0
else
        sh -x /data02/scripts/copy_cbs_run.sh
        exit 0
fi

