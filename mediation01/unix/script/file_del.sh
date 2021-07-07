#Author Tareq
#!/bin/sh
#!/bin/bash

cd /data02/script/

##MSC processed row CDR
./file_del_all.sh /data01/msc/nokia_processed_msc_cdr
./file_del_all.sh /data01/msc/huawei_processed_msc_cdr
./file_del_all.sh /data01/msc/alu_processed_msc_cdr

##MSC converted CSV_dump
./file_del_all.sh /data01/msc/huawei_csv_msc_cdr_backup
./file_del_all.sh /data01/msc/alu_csv_msc_cdr_dump
./file_del_all.sh /data01/msc/nokia_csv_msc_cdr_dump
