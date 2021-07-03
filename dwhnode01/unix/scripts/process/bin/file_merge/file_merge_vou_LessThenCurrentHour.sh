#Author :       Tareq
#Date   :       11-01-2021
#cbs_cdr_vou file_name column add and merge lessthen courrent hour
dt=`date  '+%Y%m%d'`

hour=`date  '+%Y%m%d%H'`

lock=/data02/scripts/process/bin/cbs_vou_file_merge_LsCurrentH  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data02/cbs_cdrs/vou/process_dir

	if [ ${dt}00 -lt $hour ];  then
		FILES=`ls -ltr *${dt}00*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}01 -lt $hour ];  then
		FILES=`ls -ltr *${dt}01*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}02 -lt $hour ];  then
		FILES=`ls -ltr *${dt}02*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}03 -lt $hour ];  then
		FILES=`ls -ltr *${dt}03*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}04 -lt $hour ];  then
		FILES=`ls -ltr *${dt}04*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}05 -lt $hour ];  then
		FILES=`ls -ltr *${dt}05*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}06 -lt $hour ];  then
		FILES=`ls -ltr *${dt}06*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}07 -lt $hour ];  then
		FILES=`ls -ltr *${dt}07*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}08 -lt $hour ];  then
		FILES=`ls -ltr *${dt}08*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}09 -lt $hour ];  then
		FILES=`ls -ltr *${dt}09*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}10 -lt $hour ];  then
		FILES=`ls -ltr *${dt}10*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}11 -lt $hour ];  then
		FILES=`ls -ltr *${dt}11*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}12 -lt $hour ];  then
		FILES=`ls -ltr *${dt}12*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}13 -lt $hour ];  then
		FILES=`ls -ltr *${dt}13*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}14 -lt $hour ];  then
		FILES=`ls -ltr *${dt}14*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}15 -lt $hour ];  then
		FILES=`ls -ltr *${dt}15*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}16 -lt $hour ];  then
		FILES=`ls -ltr *${dt}16*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}17 -lt $hour ];  then
		FILES=`ls -ltr *${dt}17*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}18 -lt $hour ];  then
		FILES=`ls -ltr *${dt}18*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi


	if [ ${dt}19 -lt $hour ];  then
		FILES=`ls -ltr *${dt}19*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}20 -lt $hour ];  then
		FILES=`ls -ltr *${dt}20*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi
	
	if [ ${dt}21 -lt $hour ];  then
		FILES=`ls -ltr *${dt}21*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}22 -lt $hour ];  then
		FILES=`ls -ltr *${dt}22*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
			done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi

	if [ ${dt}23 -lt $hour ];  then
		FILES=`ls -ltr *${dt}23*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

		RESULT=$?
			if [ $RESULT -eq 0 ]; then
			  rm -rf "$i"
			else
			  exit 2
			fi
		done


		sdt=`date '+%Y%m%d%H%M%S'`

		FILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
		for i in $FILES
		do
		cat $i >> cbs_cdr_vou_$sdt.add

		RESULT=$?
		if [ $RESULT -eq 0 ]; then
		  rm -rf "$i"
		else
		  exit 2
		fi
		done

		mv cbs_cdr_vou_$sdt.add /data02/cbs_cdrs/vou/merge_dir

	fi
rm -f $lock

fi

