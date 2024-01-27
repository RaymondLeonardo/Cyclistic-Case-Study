-- DATA CLEANING


DROP TABLE cleaned_combined_data_2021

CREATE TABLE IF NOT EXISTS cleaned_combined_data_2021 AS (
SELECT 
    a.ride_id, 
	rideable_type, 
	started_at, 
	ended_at, 
    ride_length,
    CASE EXTRACT(DOW FROM started_at) 
      WHEN 0 THEN 'SUN'
      WHEN 1 THEN 'MON'
      WHEN 2 THEN 'TUES'
      WHEN 3 THEN 'WED'
      WHEN 4 THEN 'THURS'
      WHEN 5 THEN 'FRI'
      WHEN 6 THEN 'SAT'    
    END AS day_of_week,
    CASE EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'JAN'
      WHEN 2 THEN 'FEB'
      WHEN 3 THEN 'MAR'
      WHEN 4 THEN 'APR'
      WHEN 5 THEN 'MAY'
      WHEN 6 THEN 'JUN'
      WHEN 7 THEN 'JUL'
      WHEN 8 THEN 'AUG'
      WHEN 9 THEN 'SEP'
      WHEN 10 THEN 'OCT'
      WHEN 11 THEN 'NOV'
      WHEN 12 THEN 'DEC'
    END AS month,
    start_station_name, 
	end_station_name, 
    start_lat, 
	start_lng, 
	end_lat, 
	end_lng, 
	member_casual
  FROM combined_data_2021 a
  JOIN (
    SELECT 
	  ride_id, (
      EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
      EXTRACT(MINUTE FROM (ended_at - started_at)) +
      EXTRACT(SECOND FROM (ended_at - started_at)) / 60) AS ride_length
    FROM combined_data_2021
  ) b 
  ON a.ride_id = b.ride_id
  WHERE 
    start_station_name IS NOT NULL AND
    end_station_name IS NOT NULL AND
    end_lat IS NOT NULL AND
    end_lng IS NOT NULL AND
    ride_length > 1 AND ride_length < 1440
);


ALTER TABLE cleaned_combined_data_2021
ADD PRIMARY KEY (ride_id);

SELECT count(*)
FROM cleaned_combined_data_2021