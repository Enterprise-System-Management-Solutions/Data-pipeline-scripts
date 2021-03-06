
PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=dwhnode01
export ORACLE_UNQNAME=dwhdb01
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/data01/app/oraInventory
export ORACLE_SID=dwhdb01
export DATA_DIR=/data01/oradata

export PATH=/usr/sbin:/usr/local/bin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib


sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo off
SET head off
SET feedback off
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"
INSERT INTO TB_DW_CBS_REC_DAY(STATIS_DATE,SERIALNO,SUBSEQUENCE,TIMESTAMP,SERVICEKEY,CALLINGPARTYNUMBER,CALLEDPARTYNUMBER,CALLINGPARTYIMSI,CALLEDPARTYIMSI,DIALEDNUMBER,ORIGINALCALLEDPARTY,SERVICEFLOW,CALLFORWARDINDICATOR,CALLINGROAMINFO,CALLINGCELLID,CALLEDROAMINFO,CALLEDCELLID,TIMESTAMPOFSSP,TIMEZONEOFSSP,BEARERCAPABILITY,
RESERVED1,CHARGINGTIME,WAITDURATION,CALLDURATION,TERMINATIONREASON,CALLREFERENCENUMBER,IMEI,CHARGEDURATION,ACCESSPREFIX,ROUTINGPREFIX,REDIRECTINGPARTYID,BRANDID,SUBCOSID,CHARGINGPARTYNUMBER,CHARGEPARTYINDICATOR,PAYTYPE,BILLCYCLEID,CHARGINGTYPE,CALLTYPE,ROAMSTATE,
RESULTCODE,FPHPREFIX,CALLINGHOMECOUNTRYCODE,CALLINGHOMEAREANUMBER,CALLINGHOMENETWORKCODE,CALLINGROAMCOUNTRYCODE,CALLINGROAMAREANUMBER,CALLINGROAMNETWORKCODE,CALLEDHOMECOUNTRYCODE,CALLEDHOMEAREANUMBER,CALLEDHOMENETWORKCODE,CALLEDROAMCOUNTRYCODE,CALLEDROAMAREANUMBER,CALLEDROAMNETWORKCODE,PRODUCTID,SERVICETYPE,HOTLINEINDICATOR,HOMEZONEID,NPFLAG,NPPREFIX,
CALLINGGROUPNO,CALLEDGROUPNO,USERSTATE,SUBSCRIBERID,OPPOSENUMBERTYPE,SAMEBRANDPRE,CHARGEOFITEMSACCOUNTS,CHARGEOFDURATIONACCOUNTS,CHARGEOFFUNDACCOUNTS,CHARGEFROMPREPAID,PREPAIDBALANCE,CHARGEFROMPOSTPAID,POSTPAIDBALANCE,ACCOUNTID,ACCOUNTKEY,CURRENCYCODE,FNGROUP,ACCOUNTTYPE1,FEETYPE1,CHARGEAMOUNT1,
CURRENTACCTAMOUNT1,ACCOUNTTYPE2,FEETYPE2,CHARGEAMOUNT2,CURRENTACCTAMOUNT2,ACCOUNTTYPE3,FEETYPE3,CHARGEAMOUNT3,CURRENTACCTAMOUNT3,ACCOUNTTYPE4,FEETYPE4,CHARGEAMOUNT4,CURRENTACCTAMOUNT4,ACCOUNTTYPE5,FEETYPE5,CHARGEAMOUNT5,CURRENTACCTAMOUNT5,ACCOUNTTYPE6,FEETYPE6,CHARGEAMOUNT6,
CURRENTACCTAMOUNT6,ACCOUNTTYPE7,FEETYPE7,CHARGEAMOUNT7,CURRENTACCTAMOUNT7,ACCOUNTTYPE8,FEETYPE8,CHARGEAMOUNT8,CURRENTACCTAMOUNT8,ACCOUNTTYPE9,FEETYPE9,CHARGEAMOUNT9,CURRENTACCTAMOUNT9,ACCOUNTTYPE10,FEETYPE10,CHARGEAMOUNT10,CURRENTACCTAMOUNT10,BONUSVALIDITY1,BONUSVALIDITY2,BONUSVALIDITY3,
BONUSVALIDITY4,BONUSVALIDITY5,BONUSVALIDITY6,BONUSVALIDITY7,BONUSVALIDITY8,BONUSVALIDITY9,BONUSVALIDITY10,CALLINGVPNTOPGROUPNUMBER,CALLINGVPNGROUPNUMBER,CALLINGVPNSHORTNUMBER,CALLEDVPNTOPGROUPNUMBER,CALLEDVPNGROUPNUMBER,CALLEDVPNSHORTNUMBER,CALLINGNETWORKTYPE,CALLEDNETWORKTYPE,GROUPCALLTYPE,GROUPPAYFLAG,ONLINETYPE,RESERVED2,RESERVED3,
RESERVED4,RESERVED5,ADDTIONAINFO,STARTTIMEOFBILLCYCLE,SECONDCHARGINGPARTYNUMBER,SECONDCHARGINGPARTYPAYTYPE,SECONDCHARGINGPARTYBILLCYCLEID,CHARGEOFITEMSSECONDACCOUNTS,CHARGEOFDURATIONSECONDACCOUNTS,CHARGEOFFUNDSECONDACCOUNTS,CHARGEFROMSECONDPREPAIDACCOUNT,SECONDPREPAIDACCOUNTBALANCE,CHARGEFROMSECONDPOSTPAIDACCT,SECONDPOSTPAIDACCOUNTBALANCE,SECONDACCOUNTID,SECONDACCOUNTKEY,SECONDACCOUNTCURRENCYCODE,RESERVED6,SECONDACCOUNTTYPE1,SECONDFEETYPE1,
SECONDCHARGEAMOUNT1,SECONDCURRENTACCTAMOUNT1,SECONDACCOUNTTYPE2,SECONDFEETYPE2,SECONDCHARGEAMOUNT2,SECONDCURRENTACCTAMOUNT2,SECONDACCOUNTTYPE3,SECONDFEETYPE3,SECONDCHARGEAMOUNT3,SECONDCURRENTACCTAMOUNT3,SECONDACCOUNTTYPE4,SECONDFEETYPE4,SECONDCHARGEAMOUNT4,SECONDCURRENTACCTAMOUNT4,SECONDACCOUNTTYPE5,SECONDFEETYPE5,SECONDCHARGEAMOUNT5,SECONDCURRENTACCTAMOUNT5,SECONDBONUSVALIDITY1,SECONDBONUSVALIDITY2,
SECONDBONUSVALIDITY3,SECONDBONUSVALIDITY4,SECONDBONUSVALIDITY5,CALLINGCLUSTERNUMBER,CALLEDCLUSTERNUMBER,ORIGINALCALLINGPARTY,RESERVED7,RESERVED8,OPPOSITEPARTYNUMBER,RESERVED9,RESERVED10,RESERVED11,DIAMETERSESSIONID,STARTCOUNTRYGROUP,ENDCOUNTRYGROUP,RESERVED12,RESERVED13,RESERVED14,RESERVED15,RESERVED16,RESERVED17,
RESERVED18,RESERVED19,RESERVED20,DISCOUNTOFLASTEFFPRODUCT,SUBSCRIBERKEY,ACCUMULATIONCHANGE,USAGESERVICETYPE,SOURCESERIALNO,SOURCESUBSEQUENCE,ACCTBALCHGLIST,SUBSCRIBERTYPE,ORIGINCDRFILENAME,CURCDRLINENO,DDSDISCOUNTOFF,TAX,TAX2,TAX3,TAX4,SECONDSUBSCRIBERKEY,SECONDPRODUCTID,SETUPFEE,OPPOSETENANTID,PREFERAREACELLID,
FILE_FLAG,AREACODE,CARRIER_ID)
(SELECT STATIS_DATE,SERIALNO,SUBSEQUENCE,TIMESTAMP,SERVICEKEY,CALLINGPARTYNUMBER,CALLEDPARTYNUMBER,CALLINGPARTYIMSI,CALLEDPARTYIMSI,DIALEDNUMBER,ORIGINALCALLEDPARTY,SERVICEFLOW,CALLFORWARDINDICATOR,CALLINGROAMINFO,CALLINGCELLID,CALLEDROAMINFO,CALLEDCELLID,TIMESTAMPOFSSP,TIMEZONEOFSSP,BEARERCAPABILITY,
RESERVED1,CHARGINGTIME,WAITDURATION,CALLDURATION,TERMINATIONREASON,CALLREFERENCENUMBER,IMEI,CHARGEDURATION,ACCESSPREFIX,ROUTINGPREFIX,REDIRECTINGPARTYID,BRANDID,SUBCOSID,CHARGINGPARTYNUMBER,CHARGEPARTYINDICATOR,PAYTYPE,BILLCYCLEID,CHARGINGTYPE,CALLTYPE,ROAMSTATE,
RESULTCODE,FPHPREFIX,CALLINGHOMECOUNTRYCODE,CALLINGHOMEAREANUMBER,CALLINGHOMENETWORKCODE,CALLINGROAMCOUNTRYCODE,CALLINGROAMAREANUMBER,CALLINGROAMNETWORKCODE,CALLEDHOMECOUNTRYCODE,CALLEDHOMEAREANUMBER,CALLEDHOMENETWORKCODE,CALLEDROAMCOUNTRYCODE,CALLEDROAMAREANUMBER,CALLEDROAMNETWORKCODE,PRODUCTID,SERVICETYPE,HOTLINEINDICATOR,HOMEZONEID,NPFLAG,NPPREFIX,
CALLINGGROUPNO,CALLEDGROUPNO,USERSTATE,SUBSCRIBERID,OPPOSENUMBERTYPE,SAMEBRANDPRE,CHARGEOFITEMSACCOUNTS,CHARGEOFDURATIONACCOUNTS,CHARGEOFFUNDACCOUNTS,CHARGEFROMPREPAID,PREPAIDBALANCE,CHARGEFROMPOSTPAID,POSTPAIDBALANCE,ACCOUNTID,ACCOUNTKEY,CURRENCYCODE,FNGROUP,ACCOUNTTYPE1,FEETYPE1,CHARGEAMOUNT1,
CURRENTACCTAMOUNT1,ACCOUNTTYPE2,FEETYPE2,CHARGEAMOUNT2,CURRENTACCTAMOUNT2,ACCOUNTTYPE3,FEETYPE3,CHARGEAMOUNT3,CURRENTACCTAMOUNT3,ACCOUNTTYPE4,FEETYPE4,CHARGEAMOUNT4,CURRENTACCTAMOUNT4,ACCOUNTTYPE5,FEETYPE5,CHARGEAMOUNT5,CURRENTACCTAMOUNT5,ACCOUNTTYPE6,FEETYPE6,CHARGEAMOUNT6,
CURRENTACCTAMOUNT6,ACCOUNTTYPE7,FEETYPE7,CHARGEAMOUNT7,CURRENTACCTAMOUNT7,ACCOUNTTYPE8,FEETYPE8,CHARGEAMOUNT8,CURRENTACCTAMOUNT8,ACCOUNTTYPE9,FEETYPE9,CHARGEAMOUNT9,CURRENTACCTAMOUNT9,ACCOUNTTYPE10,FEETYPE10,CHARGEAMOUNT10,CURRENTACCTAMOUNT10,BONUSVALIDITY1,BONUSVALIDITY2,BONUSVALIDITY3,
BONUSVALIDITY4,BONUSVALIDITY5,BONUSVALIDITY6,BONUSVALIDITY7,BONUSVALIDITY8,BONUSVALIDITY9,BONUSVALIDITY10,CALLINGVPNTOPGROUPNUMBER,CALLINGVPNGROUPNUMBER,CALLINGVPNSHORTNUMBER,CALLEDVPNTOPGROUPNUMBER,CALLEDVPNGROUPNUMBER,CALLEDVPNSHORTNUMBER,CALLINGNETWORKTYPE,CALLEDNETWORKTYPE,GROUPCALLTYPE,GROUPPAYFLAG,ONLINETYPE,RESERVED2,RESERVED3,
RESERVED4,RESERVED5,ADDTIONAINFO,STARTTIMEOFBILLCYCLE,SECONDCHARGINGPARTYNUMBER,SECONDCHARGINGPARTYPAYTYPE,SECONDCHARGINGPARTYBILLCYCLEID,CHARGEOFITEMSSECONDACCOUNTS,CHARGEOFDURATIONSECONDACCOUNTS,CHARGEOFFUNDSECONDACCOUNTS,CHARGEFROMSECONDPREPAIDACCOUNT,SECONDPREPAIDACCOUNTBALANCE,CHARGEFROMSECONDPOSTPAIDACCT,SECONDPOSTPAIDACCOUNTBALANCE,SECONDACCOUNTID,SECONDACCOUNTKEY,SECONDACCOUNTCURRENCYCODE,RESERVED6,SECONDACCOUNTTYPE1,SECONDFEETYPE1,
SECONDCHARGEAMOUNT1,SECONDCURRENTACCTAMOUNT1,SECONDACCOUNTTYPE2,SECONDFEETYPE2,SECONDCHARGEAMOUNT2,SECONDCURRENTACCTAMOUNT2,SECONDACCOUNTTYPE3,SECONDFEETYPE3,SECONDCHARGEAMOUNT3,SECONDCURRENTACCTAMOUNT3,SECONDACCOUNTTYPE4,SECONDFEETYPE4,SECONDCHARGEAMOUNT4,SECONDCURRENTACCTAMOUNT4,SECONDACCOUNTTYPE5,SECONDFEETYPE5,SECONDCHARGEAMOUNT5,SECONDCURRENTACCTAMOUNT5,SECONDBONUSVALIDITY1,SECONDBONUSVALIDITY2,
SECONDBONUSVALIDITY3,SECONDBONUSVALIDITY4,SECONDBONUSVALIDITY5,CALLINGCLUSTERNUMBER,CALLEDCLUSTERNUMBER,ORIGINALCALLINGPARTY,RESERVED7,RESERVED8,OPPOSITEPARTYNUMBER,RESERVED9,RESERVED10,RESERVED11,DIAMETERSESSIONID,STARTCOUNTRYGROUP,ENDCOUNTRYGROUP,RESERVED12,RESERVED13,RESERVED14,RESERVED15,RESERVED16,RESERVED17,
RESERVED18,RESERVED19,RESERVED20,DISCOUNTOFLASTEFFPRODUCT,SUBSCRIBERKEY,ACCUMULATIONCHANGE,USAGESERVICETYPE,SOURCESERIALNO,SOURCESUBSEQUENCE,ACCTBALCHGLIST,SUBSCRIBERTYPE,ORIGINCDRFILENAME,CURCDRLINENO,DDSDISCOUNTOFF,TAX,TAX2,TAX3,TAX4,SECONDSUBSCRIBERKEY,SECONDPRODUCTID,SETUPFEE,OPPOSETENANTID,PREFERAREACELLID,
FILE_FLAG,AREACODE,CARRIER_ID FROM TB_DW_CBS_REC_DAY_EXT)
/
COMMIT
/
EXIT
EOF

echo "Inserted"


