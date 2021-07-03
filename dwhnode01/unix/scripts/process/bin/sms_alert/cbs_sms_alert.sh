cd /data01/cbs

RESULT=`find . -maxdepth 1 -type f -name "*.add" -mmin +1 -mmin -10 | xargs -r ls -l|wc -l`

if [ $RESULT -lt 1 ]; then
sleep 1m
RESULT2=`find . -maxdepth 1 -type f -name "*.add" -mmin +1 -mmin -10 | xargs -r ls -l|wc -l`
	if [ $RESULT2 -lt 1 ] ; then
		sleep 1m
		RESULT3=`find . -maxdepth 1 -type f -name "*.add" -mmin +1 -mmin -10 | xargs -r ls -l|wc -l`
			if [ $RESULT3 -lt 1 ] ; then
				sleep 1m
				RESULT4=`find . -maxdepth 1 -type f -name "*.add" -mmin +1 -mmin -10 | xargs -r ls -l|wc -l`
					if [ $RESULT4 -lt 1  ] ; then
						sleep 1m
						RESULT5=`find . -maxdepth 1 -type f -name "*.add" -mmin +1 -mmin -10 | xargs -r ls -l|wc -l`
							if [ $RESULT5 -lt 1 ] ; then
								DADDR=sender number
								#DADDR2=sender number
								text="cbs_cdr_not_coming_on_node01"
								TEXT2=$(echo $text | tr -d ' ')
								curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_240&to=$DADDR&text=$TEXT2"
							    
							else
								exit 2
							fi
					else
						exit 2
					fi
			else
			  exit 2
			 fi
	else
		exit 2
	fi
else
    exit 2
fi

