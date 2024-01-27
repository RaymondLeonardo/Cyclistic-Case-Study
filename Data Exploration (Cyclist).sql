-- DATA EXPLORATION

-- Cek jumlah null value di setiap kolom

SELECT 
	COUNT(*) - COUNT(ride_id) ride_id,
 	COUNT(*) - COUNT(rideable_type) rideable_type,
 	COUNT(*) - COUNT(started_at) started_at,
 	COUNT(*) - COUNT(ended_at) ended_at,
 	COUNT(*) - COUNT(start_station_name) start_station_name,
 	COUNT(*) - COUNT(start_station_id) start_station_id,
 	COUNT(*) - COUNT(end_station_name) end_station_name,
 	COUNT(*) - COUNT(end_station_id) end_station_id,
 	COUNT(*) - COUNT(start_lat) start_lat,
 	COUNT(*) - COUNT(start_lng) start_lng,
 	COUNT(*) - COUNT(end_lat) end_lat,
 	COUNT(*) - COUNT(end_lng) end_lng,
 	COUNT(*) - COUNT(member_casual) member_casual
FROM combined_data_2021;

-- Cek duplikat data

SELECT 
	COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM combined_data_2021;

-- Cek ride_id apakah semua 16 kata

SELECT 
	LENGTH(ride_id) AS length_ride_id, 
	COUNT(ride_id) AS no_of_rows
FROM combined_data_2021
GROUP BY length_ride_id;

-- Rideable bike (Ada 3 jenis bike)

SELECT
	DISTINCT rideable_type,
	COUNT(rideable_type) AS no_of_trips
FROM combined_data_2021
GROUP BY rideable_type;

-- started_at, ended_at

SELECT 
	started_at,
	ended_at
FROM combined_data_2021
LIMIT 10;

SELECT 
	COUNT(*) AS longer_than_a_day
FROM combined_data_2021
WHERE (
  EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
  EXTRACT(MINUTE FROM (ended_at - started_at)) +
  EXTRACT(SECOND FROM (ended_at - started_at)) / 60) >= 1440;  -- There are no trips that longer than a day
  
SELECT 
	COUNT(*) AS less_than_a_minute
FROM combined_data_2021
WHERE (
  EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
  EXTRACT(MINUTE FROM (ended_at - started_at)) +
  EXTRACT(SECOND FROM (ended_at - started_at)) / 60) <= 1;  -- There are 86115 trips that less than a minute
  
-- Cek missing atau null value di start_station_name atau start_station_id

SELECT 
	COUNT(ride_id) AS start_station_null_count          
FROM combined_data_2021
WHERE start_station_name IS NULL OR start_station_id IS NULL;  -- Terdapat 690809 null value di start_station

-- Cek missing atau null value di end_station_name atau end_station_id

SELECT 
	COUNT(ride_id) AS rows_with_null_end_station          
FROM combined_data_2021
WHERE end_station_name IS NULL OR end_station_id IS NULL;  -- Terdapat 739170 null value di end_station

-- Cek missing atau null value di end_lat atau end_lng

SELECT COUNT(ride_id) AS rows_with_null_end_loc
FROM combined_data_2021
WHERE end_lat IS NULL OR end_lng IS NULL;

-- Jumlah trip berdasarkan member_casual

SELECT 
	DISTINCT member_casual, 
	COUNT(member_casual) AS no_of_trips
FROM combined_data_2021
GROUP BY member_casual;