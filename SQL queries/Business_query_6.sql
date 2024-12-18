SELECT 
    dc.city_name,
    dd.month_name,
    SUM(fps.repeat_passengers) AS repeat_passengers,
    SUM(fps.total_passengers) AS total_passengers,
    (SUM(fps.repeat_passengers) * 100.0 / SUM(fps.total_passengers)) AS repeat_passenger_rate
FROM 
    trips_db.fact_passenger_summary fps
JOIN 
    trips_db.dim_city dc 
ON 
    fps.city_id = dc.city_id
JOIN 
    trips_db.dim_date dd 
ON 
    fps.month = dd.start_of_month
GROUP BY 
    dc.city_name, dd.month_name
ORDER BY 
    repeat_passenger_rate DESC;