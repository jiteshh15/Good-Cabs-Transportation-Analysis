WITH CityRevenue AS (
    SELECT 
        city.city_name AS city_name,
        date.month_name AS month_name,
        SUM(trips.fare_amount) AS monthly_revenue,
        SUM(SUM(trips.fare_amount)) OVER (PARTITION BY city.city_name) AS total_city_revenue
    FROM 
        trips_db.fact_trips trips
    JOIN 
        trips_db.dim_city city ON trips.city_id = city.city_id
    JOIN 
        trips_db.dim_date date ON trips.date = date.date
    GROUP BY 
        city.city_name, date.month_name
),
CityMaxRevenue AS (
    SELECT 
        city_name,
        month_name AS highest_revenue_month,
        monthly_revenue AS revenue,
        ROUND((monthly_revenue * 100.0 / NULLIF(total_city_revenue, 0)), 2) AS percentage_contribution,
        RANK() OVER (PARTITION BY city_name ORDER BY monthly_revenue DESC) AS revenue_rank
    FROM 
        CityRevenue
)
SELECT 
    city_name,
    highest_revenue_month,
    revenue,
    percentage_contribution
FROM 
    CityMaxRevenue
WHERE 
    revenue_rank = 1
ORDER BY 
    city_name;
