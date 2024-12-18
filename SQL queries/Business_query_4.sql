SELECT 
    RankedCities.City_Name,
    RankedCities.TotalPassenger,
    CASE
        WHEN RankedCities.Rank_Desc <= 3 THEN 'Top 3'
        WHEN RankedCities.Rank_Asc <= 3 THEN 'Bottom 3'
        ELSE NULL
    END AS City_Category
FROM (
    SELECT 
        dc.city_name AS City_Name,
        SUM(mtnp.target_new_passengers) AS TotalPassenger,
        RANK() OVER (ORDER BY SUM(mtnp.target_new_passengers) DESC) AS Rank_Desc,
        RANK() OVER (ORDER BY SUM(mtnp.target_new_passengers) ASC) AS Rank_Asc
    FROM 
        trips_db.dim_city dc
    JOIN 
        targets_db.monthly_target_new_passengers mtnp 
    ON 
        dc.city_id = mtnp.city_id
    GROUP BY 
        dc.city_name
) AS RankedCities
WHERE 
    RankedCities.Rank_Desc <= 3 OR RankedCities.Rank_Asc <= 3
ORDER BY 
    City_Category, RankedCities.TotalPassenger DESC;
