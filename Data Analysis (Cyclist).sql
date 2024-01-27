-- DATA ANALYSIS

-- Bike types used by each member

SELECT
	member_casual,
	rideable_type,
	COUNT(*) AS no_of_trips
FROM cleaned_combined_data_2021
GROUP BY member_casual, rideable_type
ORDER BY member_casual, no_of_trips;

-- Total trips per month

SELECT 
	member_casual,
	month,
	COUNT(ride_id) AS no_of_trips
FROM cleaned_combined_data_2021
GROUP BY month, member_casual
ORDER BY member_casual;

-- Total trips per day of week

SELECT 
	member_casual,
	day_of_week,
	COUNT(ride_id) AS no_of_trips
FROM cleaned_combined_data_2021
GROUP BY day_of_week, member_casual
ORDER BY member_casual;

-- Average ride length per month

SELECT
	member_casual,
	month,
	AVG(ride_length) AS avg_ride_length
FROM cleaned_combined_data_2021
GROUP BY member_casual, month
ORDER BY avg_ride_length;

-- Average ride length per day of week

SELECT
	member_casual,
	day_of_week,
	AVG(ride_length) AS avg_ride_length
FROM cleaned_combined_data_2021
GROUP BY member_casual, day_of_week
ORDER BY avg_ride_length;