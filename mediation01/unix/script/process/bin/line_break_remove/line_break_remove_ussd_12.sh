#!/bin/bash
PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin'

#Author :       Tareq
#Date   :       20-20-2020
#line breake remove and add nweline for line end



lock=/data02/script/process/bin/LineBreak_remove_ussd_12  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data02/mfs/ussd/12

zdir=/data02/mfs/ussd/output
##=================remove new line====================##
rFILES=`ls -ltr rec*.unl | awk -F" " {'print $9'}`
for i in $rFILES
do
tr -s '\n' ' ' < "$i" > lbr_12_"$i" 
rm -f "$i"
done

##===================and (~) line=======================##
sFILES=`ls -ltr lbr*.unl | awk -F" " {'print $9'}`
for i in $sFILES
do
sed -i 's|20,1E|~20,1E|g' "$i"
#mv "$i" $zdir
done

##===================add new line =======================##
nFILES=`ls -ltr lbr*.unl | awk -F" " {'print $9'}`
for i in $nFILES
do
sed -i 's/~/\n/g' "$i"
mv "$i" $zdir
done
##========================End==========================##
rm -f $lock

fi
