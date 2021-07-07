--
-- C_NEW_IDLE  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.c_new_idle is
    vdate_key        varchar2(12);
begin

    select date_key into vdate_key 
    from date_dim
    where date_key = (select a.date_key from date_dim a where a.date_value = to_date (sysdate-1,'dd/mm/rrrr'));
        
    insert into  c_narayanganj_new_idle
    select vdate_key,msisdn 
    from c_narayanganj_out_with_idle 
    where date_key=vdate_key
    and msisdn not in(select distinct msisdn from c_narayanganj_new_out where date_key=vdate_key);
end;
/

