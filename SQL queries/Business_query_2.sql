SELECT
	dc.city_name,
    dd.month_name,
    COUNT(ft.trip_id) as actual_trips,
    tt.total_target_trips,
    CASE
		WHEN COUNT(ft.trip_id) > tt.total_target_trips THEN 'Above Target'
        ELSE 'Below Target'
    END AS performance_status,
    ((COUNT(ft.trip_id) - tt.total_target_trips) * 100.0 / tt.total_target_trips) AS percentage_difference
FROM 
    trips_db.fact_trips ft
JOIN 
    trips_db.dim_city dc 
ON 
    ft.city_id = dc.city_id
JOIN 
    trips_db.dim_date dd 
ON 
    ft.date = dd.date 
JOIN 
    targets_db.monthly_target_trips tt 
ON 
    ft.city_id = tt.city_id AND dd.start_of_month = tt.month  
GROUP BY 
    dc.city_name, dd.month_name, tt.total_target_trips
LIMIT 0, 1000;