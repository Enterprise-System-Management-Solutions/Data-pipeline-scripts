--
-- ZONE_DIM  (View) 
--
CREATE OR REPLACE FORCE VIEW DWH_USER.ZONE_DIM
(SITE_ID, SITE_NAME, LONGITUDE, LATITUDE, CELL_CODE, 
 CGI, LAC, CI, CELL_NAME, FULL_ADDRESS, 
 SHOW_ADDRESS, UPAZILA, DISTRICT, DIVISION, TECHNOLOGY, 
 COUNTRY, DIVISION_CODE, ZILA_CODE, UPAZILA_CODE, MONTH_KEY)
BEQUEATH DEFINER
AS 
SELECT SITE_ID,
          SITE_NAME,
          LONGITUDE,
          LATITUDE,
          CELL_CODE,
          CGI,
          LAC,
          CI,
          CELL_NAME,
          FULL_ADDRESS,
          SHOW_ADDRESS,
          UPAZILA,
          DISTRICT,
          DIVISION,
          TECHNOLOGY,
          COUNTRY,
          DIVISION_CODE,
          ZILA_CODE,
          UPAZILA_CODE,
          MONTH_KEY
     FROM (SELECT /*+ parallel(A,16)*/ SITE_ID,
                  SITE_NAME,
                  LONGITUDE,
                  LATITUDE,
                  CELL_CODE,
                  CGI,
                  LAC,
                  CI,
                  CELL_NAME,
                  FULL_ADDRESS,
                  SHOW_ADDRESS,
                  UPAZILA,
                  DISTRICT,
                  DIVISION,
                  TECHNOLOGY,
                  COUNTRY,
                  DIVISION_CODE,
                  ZILA_CODE,
                  UPAZILA_CODE,
                  MONTH_KEY,
                  DENSE_RANK () OVER (ORDER BY MONTH_KEY DESC)
                     AS TOP_MONTH_KEY
             FROM ZONE_DIM_FULL A)
    WHERE TOP_MONTH_KEY = 1;


