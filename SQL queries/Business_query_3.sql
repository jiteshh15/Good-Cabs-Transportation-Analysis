SELECT 
	dc.city_name as City_Name,
    ROUND(SUM(CASE WHEN t.trip_count = '2-Trips' THEN t.repeat_passenger_count ELSE 0 END) / SUM(t.repeat_passenger_count) * 100, 2) AS '2-Trips',
    ROUND(SUM(CASE WHEN t.trip_count = '3-Trips' THEN t.repeat_passenger_count ELSE 0 END) / SUM(t.repeat_passenger_count) * 100, 2) AS '3-Trips',
    ROUND(SUM(CASE WHEN t.trip_count = '4-Trips' THEN t.repeat_passenger_count ELSE 0 END) / SUM(t.repeat_passenger_count) * 100, 2) AS '4-Trips',
    ROUND(SUM(CASE WHEN t.trip_count = '5-Trips' THEN t.repeat_passenger_count ELSE 0 END) / SUM(t.repeat_passenger_count) * 100, 2) AS '5-Trips',
    ROUND(SUM(CASE WHEN t.trip_count = '6-Trips' THEN t.repeat_passenger_count ELSE 0 END) / SUM(t.repeat_passenger_count) * 100, 2) AS '6-Trips',
    ROUND(SUM(CASE WHEN t.trip_count = '7-Trips' THEN t.repeat_passenger_count ELSE 0 END) / SUM(t.repeat_passenger_count) * 100, 2) AS '7-Trips',
    ROUND(SUM(CASE WHEN t.trip_count = '8-Trips' THEN t.repeat_passenger_count ELSE 0 END) / SUM(t.repeat_passenger_count) * 100, 2) AS '8-Trips',
    ROUND(SUM(CASE WHEN t.trip_count = '9-Trips' THEN t.repeat_passenger_count ELSE 0 END) / SUM(t.repeat_passenger_count) * 100, 2) AS '9-Trips',
    ROUND(SUM(CASE WHEN t.trip_count = '10-Trips' THEN t.repeat_passenger_count ELSE 0 END) / SUM(t.repeat_passenger_count) * 100, 2) AS '10-Trips'
FROM 
    trips_db.dim_repeat_trip_distribution t
JOIN 
    trips_db.dim_city dc ON dc.city_id = t.city_id
GROUP BY 
    dc.city_name;    