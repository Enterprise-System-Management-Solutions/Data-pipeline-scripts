--
-- C_FIRST_IN_LAST_OUT_NEW  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.c_first_in_last_out_new is
 vdate_key        varchar2(12);
begin

    select date_key into vdate_key 
    from date_dim
    where date_key = (select a.date_key from date_dim a where a.date_value = to_date (sysdate-1,'DD/MM/RRRR'));
--------------------        
    insert into c_first_in
    select  vdate_key,z.msisdn,z.timestamp as first_call, z.upazila, z.district
    from
    (select x.timestamp, x.msisdn,x.v381_callingcellid, x.v383_calledcellid, x.upazila, x.district,rank() over (partition by x.msisdn order by x.timestamp) as last_key
    from
    (select r.timestamp, r.msisdn,r.v381_callingcellid, r.v383_calledcellid, r.upazila, r.district 
    from
    (select  q.msisdn, q.timestamp ,q.v381_callingcellid, q.v383_calledcellid, q.upazila,q.district,  rank() over (partition by q.msisdn order by q.timestamp ) as last_key
    from
    (select p.v372_callingpartynumber as msisdn, to_char(to_date(p.call_date,'YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') as timestamp , p.v381_callingcellid, p.v383_calledcellid, p.upazila,p.district
    from
    (select n.v372_callingpartynumber,n.date_value||n.v387_chargingtime_hour as call_date, n.v381_callingcellid, n.v383_calledcellid, m.upazila,m.district
    from zone_dim@dwh05todwh01 m,
    (select a.v381_callingcellid ,a.v372_callingpartynumber, to_char(b.date_value,'RRRRMMDD') as date_value,a.v387_chargingtime_hour,v383_calledcellid
    from l3_voice a, date_dim b, c_narayanganj_new_in c
    --FROM L2_VOICE_333@DWH05TODWH01 A, DATE_DIM B
    where v387_chargingtime_key  = (select a.date_key from date_dim a where a.date_value = to_date (sysdate-1,'DD/MM/RRRR'))--IN (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE BETWEEN TO_DATE ('06/04/2020','DD/MM/RRRR') AND TO_DATE ('17/04/2020','DD/MM/RRRR'))
    and a.v372_callingpartynumber =c.msisdn
    --AND C.STATUS='N'
    and c.date_key=vdate_key
    and a.v387_chargingtime_key=b.date_key
    group by a.v381_callingcellid ,a.v372_callingpartynumber,b.date_value,a.v387_chargingtime_hour,v383_calledcellid)n
    where m.cgi=n.v381_callingcellid
    and m.zila_code='67'
    group by  n.v372_callingpartynumber,n.date_value||n.v387_chargingtime_hour, n.v381_callingcellid, n.v383_calledcellid, m.upazila,m.district
    order by n.v372_callingpartynumber,m.district)p
    )q
    )r
    where last_key=1
    union all 
    select r.timestamp, r.msisdn,r.v381_callingcellid, r.v383_calledcellid, r.upazila, r.district 
    from
    (select  q.msisdn, q.timestamp ,q.v381_callingcellid, q.v383_calledcellid, q.upazila,q.district,  rank() over (partition by q.msisdn order by q.timestamp) as last_key
    from
    (select p.v373_calledpartynumber as msisdn, to_char(to_date(p.call_date,'YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') as timestamp , p.v381_callingcellid, p.v383_calledcellid, p.upazila,p.district
    from
    (select n.v373_calledpartynumber,n.date_value||n.v387_chargingtime_hour as call_date, n.v381_callingcellid, n.v383_calledcellid, m.upazila,m.district
    from zone_dim@dwh05todwh01 m,
    (select a.v381_callingcellid ,a.v373_calledpartynumber, to_char(b.date_value,'RRRRMMDD') as date_value,a.v387_chargingtime_hour,v383_calledcellid
    from l3_voice a, date_dim b, c_narayanganj_new_in c
    --FROM L2_VOICE_333@DWH05TODWH01 A, DATE_DIM B
    where v387_chargingtime_key  = (select a.date_key from date_dim a where a.date_value = to_date (sysdate-1,'DD/MM/RRRR'))--IN (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE BETWEEN TO_DATE ('06/04/2020','DD/MM/RRRR') AND TO_DATE ('17/04/2020','DD/MM/RRRR'))
    and a.v373_calledpartynumber =c.msisdn
    --AND C.STATUS='N'
    and c.date_key=vdate_key
    and a.v387_chargingtime_key=b.date_key
    group by a.v381_callingcellid ,a.v373_calledpartynumber,b.date_value,a.v387_chargingtime_hour,v383_calledcellid)n
    where m.cgi=n.v383_calledcellid
    and m.zila_code='67'
    group by  n.v373_calledpartynumber,n.date_value||n.v387_chargingtime_hour, n.v381_callingcellid, n.v383_calledcellid, m.upazila,m.district
    order by n.v373_calledpartynumber,m.district)p
    )q
    )r
    where last_key=1)x
    )z
    where last_key=1;
    commit;    
-------------------------        
    insert into c_last_out
    select  vdate_key,z.msisdn,z.timestamp as first_call, z.upazila, z.district
    from
    (select x.timestamp, x.msisdn,x.v381_callingcellid, x.v383_calledcellid, x.upazila, x.district,rank() over (partition by x.msisdn order by x.timestamp desc) as last_key
    from
    (select r.timestamp, r.msisdn,r.v381_callingcellid, r.v383_calledcellid, r.upazila, r.district 
    from
    (select  q.msisdn, q.timestamp ,q.v381_callingcellid, q.v383_calledcellid, q.upazila,q.district,  rank() over (partition by q.msisdn order by q.timestamp desc) as last_key
    from
    (select p.v372_callingpartynumber as msisdn, to_char(to_date(p.call_date,'YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') as timestamp , p.v381_callingcellid, p.v383_calledcellid, p.upazila,p.district
    from
    (select n.v372_callingpartynumber,n.date_value||n.v387_chargingtime_hour as call_date, n.v381_callingcellid, n.v383_calledcellid, m.upazila,m.district
    from zone_dim@dwh05todwh01 m,
    (select a.v381_callingcellid ,a.v372_callingpartynumber, to_char(b.date_value,'RRRRMMDD') as date_value,a.v387_chargingtime_hour,v383_calledcellid
    from l3_voice a, date_dim b, c_narayanganj_new_in c
    --FROM L2_VOICE_333@DWH05TODWH01 A, DATE_DIM B
    where v387_chargingtime_key  = (select a.date_key from date_dim a where a.date_value = to_date (sysdate-1,'DD/MM/RRRR'))--IN (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE BETWEEN TO_DATE ('06/04/2020','DD/MM/RRRR') AND TO_DATE ('17/04/2020','DD/MM/RRRR'))
    and a.v372_callingpartynumber =c.msisdn
    --AND C.STATUS='N'
    and c.date_key=vdate_key
    and a.v387_chargingtime_key=b.date_key
    group by a.v381_callingcellid ,a.v372_callingpartynumber,b.date_value,a.v387_chargingtime_hour,v383_calledcellid)n
    where m.cgi=n.v381_callingcellid
    and m.zila_code='67'
    group by  n.v372_callingpartynumber,n.date_value||n.v387_chargingtime_hour, n.v381_callingcellid, n.v383_calledcellid, m.upazila,m.district
    order by n.v372_callingpartynumber,m.district)p
    )q
    )r
    where last_key=1
    union all 
    select r.timestamp, r.msisdn,r.v381_callingcellid, r.v383_calledcellid, r.upazila, r.district 
    from
    (select  q.msisdn, q.timestamp ,q.v381_callingcellid, q.v383_calledcellid, q.upazila,q.district,  rank() over (partition by q.msisdn order by q.timestamp desc) as last_key
    from
    (select p.v373_calledpartynumber as msisdn, to_char(to_date(p.call_date,'YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') as timestamp , p.v381_callingcellid, p.v383_calledcellid, p.upazila,p.district
    from
    (select n.v373_calledpartynumber,n.date_value||n.v387_chargingtime_hour as call_date, n.v381_callingcellid, n.v383_calledcellid, m.upazila,m.district
    from zone_dim@dwh05todwh01 m,
    (select a.v381_callingcellid ,a.v373_calledpartynumber, to_char(b.date_value,'RRRRMMDD') as date_value,a.v387_chargingtime_hour,v383_calledcellid
    from l3_voice a, date_dim b, c_narayanganj_new_in c
    --FROM L2_VOICE_333@DWH05TODWH01 A, DATE_DIM B
    where v387_chargingtime_key  = (select a.date_key from date_dim a where a.date_value = to_date (sysdate-1,'DD/MM/RRRR'))--IN (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE BETWEEN TO_DATE ('06/04/2020','DD/MM/RRRR') AND TO_DATE ('17/04/2020','DD/MM/RRRR'))
    and a.v373_calledpartynumber =c.msisdn
    --AND C.STATUS='N'
    and c.date_key=vdate_key
    and a.v387_chargingtime_key=b.date_key
    group by a.v381_callingcellid ,a.v373_calledpartynumber,b.date_value,a.v387_chargingtime_hour,v383_calledcellid)n
    where m.cgi=n.v383_calledcellid
    and m.zila_code='67'    
    group by  n.v373_calledpartynumber,n.date_value||n.v387_chargingtime_hour, n.v381_callingcellid, n.v383_calledcellid, m.upazila,m.district
    order by n.v373_calledpartynumber,m.district)p
    )q
    )r
    where last_key=1)x
    )z
    where last_key=1;
    commit;

-----------------------

    insert into c_first_in_last_out( date_key,msisdn, first_call, last_call, upazila, district)
    select vdate_key,a.msisdn,min(a.first_call) as first_call ,max(b.last_call) as last_call,a.upazila, a.district
    from c_first_in a, c_last_out b
    where a.msisdn=b.msisdn
    and a.date_key=vdate_key
    and a.date_key=b.date_key
    group by  a.msisdn,a.upazila, a.district;
    commit;

   /* 
insert into c_first_in_last_out
select xx.msisdn,min(xx.first_call) as first_call,max(zz.last_call) as last_call, xx.upazila,xx.district
from
(select  z.msisdn,z.timestamp as first_call, z.upazila, z.district
from
(select x.timestamp, x.msisdn,x.v381_callingcellid, x.v383_calledcellid, x.upazila, x.district,rank() over (partition by x.msisdn order by x.timestamp) as last_key
from
(select r.timestamp, r.msisdn,r.v381_callingcellid, r.v383_calledcellid, r.upazila, r.district 
from
(select  q.msisdn, q.timestamp ,q.v381_callingcellid, q.v383_calledcellid, q.upazila,q.district,  rank() over (partition by q.msisdn order by q.timestamp ) as last_key
from
(select p.v372_callingpartynumber as msisdn, to_char(to_date(p.call_date,'YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') as timestamp , p.v381_callingcellid, p.v383_calledcellid, p.upazila,p.district
from
(select n.v372_callingpartynumber,n.date_value||n.v387_chargingtime_hour as call_date, n.v381_callingcellid, n.v383_calledcellid, m.upazila,m.district
from zone_dim@dwh05todwh01 m,
(select a.v381_callingcellid ,a.v372_callingpartynumber, to_char(b.date_value,'RRRRMMDD') as date_value,a.v387_chargingtime_hour,v383_calledcellid
from l3_voice a, date_dim b, c_narayanganj_new_in c
--FROM L2_VOICE_333@DWH05TODWH01 A, DATE_DIM B
where v387_chargingtime_key  = (select a.date_key from date_dim a where a.date_value = to_date (sysdate-1,'DD/MM/RRRR'))--IN (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE BETWEEN TO_DATE ('06/04/2020','DD/MM/RRRR') AND TO_DATE ('17/04/2020','DD/MM/RRRR'))
and a.v372_callingpartynumber =c.msisdn
--AND C.STATUS='N'
and a.v387_chargingtime_key=b.date_key
group by a.v381_callingcellid ,a.v372_callingpartynumber,b.date_value,a.v387_chargingtime_hour,v383_calledcellid)n
where m.cgi=n.v381_callingcellid
group by  n.v372_callingpartynumber,n.date_value||n.v387_chargingtime_hour, n.v381_callingcellid, n.v383_calledcellid, m.upazila,m.district
order by n.v372_callingpartynumber,m.district)p
)q
)r
where last_key=1
union all 
select r.timestamp, r.msisdn,r.v381_callingcellid, r.v383_calledcellid, r.upazila, r.district 
from
(select  q.msisdn, q.timestamp ,q.v381_callingcellid, q.v383_calledcellid, q.upazila,q.district,  rank() over (partition by q.msisdn order by q.timestamp) as last_key
from
(select p.v387_chargingtime_key as msisdn, to_char(to_date(p.call_date,'YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') as timestamp , p.v381_callingcellid, p.v383_calledcellid, p.upazila,p.district
from
(select n.v387_chargingtime_key,n.date_value||n.v387_chargingtime_hour as call_date, n.v381_callingcellid, n.v383_calledcellid, m.upazila,m.district
from zone_dim@dwh05todwh01 m,
(select a.v381_callingcellid ,a.v387_chargingtime_key, to_char(b.date_value,'RRRRMMDD') as date_value,a.v387_chargingtime_hour,v383_calledcellid
from l3_voice a, date_dim b, c_narayanganj_new_in c
--FROM L2_VOICE_333@DWH05TODWH01 A, DATE_DIM B
where v387_chargingtime_key  = (select a.date_key from date_dim a where a.date_value = to_date (sysdate-1,'DD/MM/RRRR'))--IN (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE BETWEEN TO_DATE ('06/04/2020','DD/MM/RRRR') AND TO_DATE ('17/04/2020','DD/MM/RRRR'))
and a.v387_chargingtime_key =c.msisdn
--AND C.STATUS='N'
and a.v387_chargingtime_key=b.date_key
group by a.v381_callingcellid ,a.v387_chargingtime_key,b.date_value,a.v387_chargingtime_hour,v383_calledcellid)n
where m.cgi=n.v383_calledcellid
group by  n.v387_chargingtime_key,n.date_value||n.v387_chargingtime_hour, n.v381_callingcellid, n.v383_calledcellid, m.upazila,m.district
order by n.v387_chargingtime_key,m.district)p
)q
)r
where last_key=1)x
)z
where last_key=1)xx,
(select  z.msisdn,z.timestamp as last_call, z.upazila, z.district
from
(select x.timestamp, x.msisdn,x.v381_callingcellid, x.v383_calledcellid, x.upazila, x.district,rank() over (partition by x.msisdn order by x.timestamp desc) as last_key
from
(select r.timestamp, r.msisdn,r.v381_callingcellid, r.v383_calledcellid, r.upazila, r.district 
from
(select  q.msisdn, q.timestamp ,q.v381_callingcellid, q.v383_calledcellid, q.upazila,q.district,  rank() over (partition by q.msisdn order by q.timestamp desc) as last_key
from
(select p.v372_callingpartynumber as msisdn, to_char(to_date(p.call_date,'YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') as timestamp , p.v381_callingcellid, p.v383_calledcellid, p.upazila,p.district
from
(select n.v372_callingpartynumber,n.date_value||n.v387_chargingtime_hour as call_date, n.v381_callingcellid, n.v383_calledcellid, m.upazila,m.district
from zone_dim@dwh05todwh01 m,
(select a.v381_callingcellid ,a.v372_callingpartynumber, to_char(b.date_value,'RRRRMMDD') as date_value,a.v387_chargingtime_hour,v383_calledcellid
from l3_voice a, date_dim b, c_narayanganj_new_in c
--FROM L2_VOICE_333@DWH05TODWH01 A, DATE_DIM B
where v387_chargingtime_key  = (select a.date_key from date_dim a where a.date_value = to_date (sysdate-1,'DD/MM/RRRR'))--IN (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE BETWEEN TO_DATE ('06/04/2020','DD/MM/RRRR') AND TO_DATE ('17/04/2020','DD/MM/RRRR'))
and a.v372_callingpartynumber =c.msisdn
--AND C.STATUS='N'
and a.v387_chargingtime_key=b.date_key
group by a.v381_callingcellid ,a.v372_callingpartynumber,b.date_value,a.v387_chargingtime_hour,v383_calledcellid)n
where m.cgi=n.v381_callingcellid
group by  n.v372_callingpartynumber,n.date_value||n.v387_chargingtime_hour, n.v381_callingcellid, n.v383_calledcellid, m.upazila,m.district
order by n.v372_callingpartynumber,m.district)p
)q
)r
where last_key=1
union all 
select r.timestamp, r.msisdn,r.v381_callingcellid, r.v383_calledcellid, r.upazila, r.district 
from
(select  q.msisdn, q.timestamp ,q.v381_callingcellid, q.v383_calledcellid, q.upazila,q.district,  rank() over (partition by q.msisdn order by q.timestamp desc) as last_key
from
(select p.v387_chargingtime_key as msisdn, to_char(to_date(p.call_date,'YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') as timestamp , p.v381_callingcellid, p.v383_calledcellid, p.upazila,p.district
from
(select n.v387_chargingtime_key,n.date_value||n.v387_chargingtime_hour as call_date, n.v381_callingcellid, n.v383_calledcellid, m.upazila,m.district
from zone_dim@dwh05todwh01 m,
(select a.v381_callingcellid ,a.v387_chargingtime_key, to_char(b.date_value,'RRRRMMDD') as date_value,a.v387_chargingtime_hour,v383_calledcellid
from l3_voice a, date_dim b, c_narayanganj_new_in c
--FROM L2_VOICE_333@DWH05TODWH01 A, DATE_DIM B
where v387_chargingtime_key  = (select a.date_key from date_dim a where a.date_value = to_date (sysdate-1,'DD/MM/RRRR'))--IN (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE BETWEEN TO_DATE ('06/04/2020','DD/MM/RRRR') AND TO_DATE ('17/04/2020','DD/MM/RRRR'))
and a.v387_chargingtime_key =c.msisdn
--AND C.STATUS='N'
and a.v387_chargingtime_key=b.date_key
group by a.v381_callingcellid ,a.v387_chargingtime_key,b.date_value,a.v387_chargingtime_hour,v383_calledcellid)n
where m.cgi=n.v383_calledcellid
group by  n.v387_chargingtime_key,n.date_value||n.v387_chargingtime_hour, n.v381_callingcellid, n.v383_calledcellid, m.upazila,m.district
order by n.v387_chargingtime_key,m.district)p
)q
)r
where last_key=1)x
)z
where last_key=1)zz
where xx.msisdn=zz.msisdn
group by xx.msisdn, xx.upazila,xx.district;
commit;
*/
end;
/

