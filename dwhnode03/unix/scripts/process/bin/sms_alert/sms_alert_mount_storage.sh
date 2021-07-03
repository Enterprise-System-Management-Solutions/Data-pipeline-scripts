#!/bin/bash
used=$(df -Ph | grep '/dev/mapper/rhel-root' | awk {'print $5'})
max=90%
if [ ${used%?} -ge ${max%?} ]; then
DADDR=8801575326975
#DADDR2=8801521479511
text="node03_server_mount_point_storage_use_${used}_used_for_root"
TEXT2=$(echo $text | tr -d ' ')
curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_239&to=$DADDR&text=$TEXT2"
#curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_239&to=$DADDR2&text=$TEXT2"
fi

used=$(df -Ph | grep '/dev/mapper/rhel-data01' | awk {'print $5'})
max=90%
if [ ${used%?} -ge ${max%?} ]; then
DADDR=8801575326975
#DADDR2=8801521479511
text="node03_server_mount_point_storage_use_${used}_used_for_data01"
TEXT2=$(echo $text | tr -d ' ')
curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_239&to=$DADDR&text=$TEXT2"
#curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_239&to=$DADDR2&text=$TEXT2"
fi


used=$(df -Ph | grep '/dev/mapper/rhel-data02' | awk {'print $5'})
max=90%
if [ ${used%?} -ge ${max%?} ]; then
DADDR=8801575326975
#DADDR2=8801521479511
text="node03_server_mount_point_storage_use_${used}_used_for_data02"
TEXT2=$(echo $text | tr -d ' ')
curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_239&to=$DADDR&text=$TEXT2"
#curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_239&to=$DADDR2&text=$TEXT2"
fi

used=$(df -Ph | grep '/dev/mapper/rhel-data03' | awk {'print $5'})
max=90%
if [ ${used%?} -ge ${max%?} ]; then
DADDR=8801575326975
#DADDR2=8801521479511
text="node03_server_mount_point_storage_use_${used}_used_for_data03"
TEXT2=$(echo $text | tr -d ' ')
curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_239&to=$DADDR&text=$TEXT2"
#curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_239&to=$DADDR2&text=$TEXT2"
fi

used=$(df -Ph | grep '/dev/mapper/rhel-data04' | awk {'print $5'})
max=90%
if [ ${used%?} -ge ${max%?} ]; then
DADDR=8801575326975
#DADDR2=8801521479511
text="node03_server_mount_point_storage_use_${used}_used_for_data03"
TEXT2=$(echo $text | tr -d ' ')
curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_239&to=$DADDR&text=$TEXT2"
#curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_239&to=$DADDR2&text=$TEXT2"
fi

used=$(df -Ph | grep '/dev/mapper/rhel-data05' | awk {'print $5'})
max=90%
if [ ${used%?} -ge ${max%?} ]; then
DADDR=8801575326975
#DADDR2=8801521479511
text="node03_server_mount_point_storage_use_${used}_used_for_data03"
TEXT2=$(echo $text | tr -d ' ')
curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_239&to=$DADDR&text=$TEXT2"
#curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_239&to=$DADDR2&text=$TEXT2"
fi
