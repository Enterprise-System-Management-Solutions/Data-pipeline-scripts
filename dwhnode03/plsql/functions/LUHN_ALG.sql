--
-- LUHN_ALG  (Function) 
--
CREATE OR REPLACE FUNCTION DWH_USER03.luhn_alg( in_val IN varchar2 ) RETURN varchar2 AS
   c_in_val VARCHAR2(20);
   c_sum  NUMBER(20) := 0; 
   int_val  NUMBER(20) := 0;
   i NUMBER(20) :=0;
   BEGIN
      c_in_val := substr(in_val,1,14);                
      i := LENGTH( c_in_val );
      
      WHILE i > 0 LOOP
         if ( MOD( i, 2 ) >0) then
         c_sum := c_sum + cast( SUBSTR(c_in_val, i, 1 ) as number );
         else
               int_val := cast( SUBSTR(c_in_val, i, 1 ) as number )*2;
                if ( length( to_char(int_val) ) > 1 ) then
                c_sum := c_sum + cast( substr(to_char(int_val),1,1) as number )+ cast( substr(to_char(int_val),2,1) as number) ;
                else
                c_sum := c_sum + int_val ; 
                end if ;   
         end if;
         i := i - 1;
      END LOOP; 
   RETURN c_in_val || (10-MOD( c_sum, 10 ));
END luhn_alg;
/

