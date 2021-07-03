#!/bin/bash
used=$(df -Ph | grep '/dev/mapper/rhel-data01' | awk {'print $5'})
max=80%
if [ ${used%?} -ge ${max%?} ]; then
DADDR=sender number
#DADDR2=sender number

text="node01_server_mount_point_storage_use_${used}_used_for_data01"
TEXT2=$(echo $text | tr -d ' ')
curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_240&to=$DADDR&text=$TEXT2"
#curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_240&to=$DADDR2&text=$TEXT2"
fi

used=$(df -Ph | grep '/dev/mapper/rhel-data02' | awk {'print $5'})
max=90%
if [ ${used%?} -ge ${max%?} ]; then
DADDR=sender number
#DADDR2=sender number

text="node01_server_mount_point_storage_use_${used}_used_for_data02"
TEXT2=$(echo $text | tr -d ' ')
curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_240&to=$DADDR&text=$TEXT2"
#curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_240&to=$DADDR2&text=$TEXT2"
fi

used=$(df -Ph | grep '/dev/mapper/dt03-dt3  ' | awk {'print $5'})
max=98%
if [ ${used%?} -ge ${max%?} ]; then
DADDR=sender number
#DADDR2=sender number

text="node01_server_mount_point_storage_use_${used}_used_for_data03"
TEXT2=$(echo $text | tr -d ' ')
curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_240&to=$DADDR&text=$TEXT2"
#curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_240&to=$DADDR2&text=$TEXT2"
fi
