SELECT 
    dc.city_name AS City_Name,
    COUNT(ft.trip_id) AS Total_trips, 
    ROUND(SUM(ft.fare_amount) / NULLIF(SUM(ft.distance_travelled_km), 0), 2) AS Avg_Fare_Per_KM,
    ROUND(SUM(ft.fare_amount) / COUNT(ft.trip_id), 2) AS Avg_fare_per_trip,  -- Average fare per trip
    ROUND(COUNT(ft.trip_id) * 100.0 / total_trips.total, 2) AS Percentage_Contribution_of_Total_Trips
FROM 
    dim_city dc
JOIN 
    fact_trips ft ON dc.city_id = ft.city_id
JOIN 
    (SELECT COUNT(*) AS total FROM fact_trips) total_trips  -- Total trips in the database
GROUP BY 
    dc.city_name, total_trips.total
ORDER BY 
    Total_trips DESC;
