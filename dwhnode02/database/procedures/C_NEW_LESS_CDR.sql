--
-- C_NEW_LESS_CDR  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.c_new_less_cdr  is
    vdate_key        varchar2(12);
begin

    select date_key into vdate_key 
    from date_dim
    where date_key = (select a.date_key from date_dim a where a.date_value = to_date (sysdate-1,'dd/mm/rrrr'));
    
insert into  c_narayanganj_less_cdr
select vdate_key,msisdn,count(msisdn) as pre_count
from
(
select msisdn, v387_chargingtime_key
from
(
select msisdn, v387_chargingtime_key
from(
select v372_callingpartynumber as msisdn,v387_chargingtime_key 
    from l3_voice a, zone_dim@dwh05todwh01 b
    where v387_chargingtime_key = (select a.date_key from date_dim a where a.date_value = to_date (sysdate-1,'dd/mm/rrrr'))-- in (select a.date_key from date_dim a where a.date_value between to_date ('06/04/2020','dd/mm/rrrr') and to_date ('17/04/2020','dd/mm/rrrr'))
    and b.cgi=a.v381_callingcellid
    and b.zila_code='67'
    group by v372_callingpartynumber,v387_chargingtime_key
    )
    
 union all
    select msisdn, v387_chargingtime_key
from(
select v373_calledpartynumber as msisdn,v387_chargingtime_key 
    from l3_voice a, zone_dim@dwh05todwh01 b
    where v387_chargingtime_key = (select a.date_key from date_dim a where a.date_value = to_date (sysdate-1,'dd/mm/rrrr'))--in (select a.date_key from date_dim a where a.date_value between to_date ('06/04/2020','dd/mm/rrrr') and to_date ('17/04/2020','dd/mm/rrrr'))
    and b.cgi=a.v383_calledcellid
    and b.zila_code='67'
    group by v373_calledpartynumber,v387_chargingtime_key
    )
)
)
where msisdn in (select msisdn from c_narayanganj_every_day_active)
group by msisdn
having count(msisdn)<5 ;
commit;
end;
/

