 --CTE to create a start/end week from the data provided
 WITH weekly_cohort AS (   
    SELECT *,
           DATE_TRUNC(subscription_start, WEEK) as start_week, --truncating the subscription start date to week
           DATE_TRUNC(subscription_end, WEEK) as end_week --truncating the subscription end date to week
    FROM `turing_data_analytics.subscriptions`
)

--main query to extract weekly users 
SELECT start_week,
       COUNT(user_pseudo_id) as total_users,
       --weekly cohort based on the number of weeks aparts
       SUM(CASE WHEN end_week > DATE_ADD(start_week,INTERVAL 1 WEEK) OR end_week IS NULL THEN 1 ELSE 0 END) AS week_1,
       SUM(CASE WHEN end_week > DATE_ADD(start_week,INTERVAL 2 WEEK) OR end_week IS NULL THEN 1 ELSE 0 END) AS week_2,
       SUM(CASE WHEN end_week > DATE_ADD(start_week,INTERVAL 3 WEEK) OR end_week IS NULL THEN 1 ELSE 0 END) AS week_3,
       SUM(CASE WHEN end_week > DATE_ADD(start_week,INTERVAL 4 WEEK) OR end_week IS NULL THEN 1 ELSE 0 END) AS week_4,
       SUM(CASE WHEN end_week > DATE_ADD(start_week,INTERVAL 5 WEEK) OR end_week IS NULL THEN 1 ELSE 0 END) AS week_5,
       SUM(CASE WHEN end_week > DATE_ADD(start_week,INTERVAL 6 WEEK) OR end_week IS NULL THEN 1 ELSE 0 END) AS week_6
FROM weekly_cohort
GROUP BY start_week
ORDER BY start_week


