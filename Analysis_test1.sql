WITH temp_t AS (
SELECT 
		User_id
		,MIN(CAST(Date AS Date)) AS FirstServiceDate
		,MAX(CAST(Date AS Date)) AS LastServiceDate
		,DATEDIFF(day, MIN(CAST(Date AS Date)), MAX(CAST(Date AS Date))) AS ages
		,PERCENT_RANK() OVER(ORDER BY DATEDIFF(day, MIN(CAST(Date AS Date)), MAX(CAST(Date AS Date)))) AS quartile
FROM [Zalo_Test].[dbo].['Data for part_2$']
GROUP BY User_id
), segment AS (
	SELECT 
		User_id 
		,CASE WHEN ages <=31 THEN '1_month' ELSE 'more_than_1month' END AS segment
	FROM temp_t
), segment1 AS (
	SELECT 
		b.segment
		,a.Serviceid
		,COUNT(Serviceid) AS total_use
	FROM [Zalo_Test].[dbo].['Data for part_2$'] AS a
	JOIN segment AS b
		ON a.User_id = b.User_id
	GROUP BY b.segment, a.Serviceid
), tempt2 AS (
SELECT 
	User_id
	,ages
	,quartile
	,CASE WHEN quartile >= 0 AND quartile < 0.25 THEN 'group1'
		  WHEN quartile >= 0.25 AND quartile < 0.5 THEN 'group2'
		  WHEN quartile >= 0.5 AND quartile < 0.75 THEN 'group3'
		  WHEN quartile >= 0.75 THEN 'group4'
	END AS segment
FROM temp_t
), segment2 AS (
	SELECT 
		b.segment
		,a.Serviceid
		,COUNT(Serviceid) AS total_use
		,ROW_NUMBER() OVER(PARTITION BY b.segment ORDER BY COUNT(Serviceid) DESC) rank
	FROM [Zalo_Test].[dbo].['Data for part_2$'] AS a
	JOIN tempt2 AS b
		ON a.User_id = b.User_id
	GROUP BY b.segment, a.Serviceid
)
SELECT 
	segment 
	,Serviceid
	,total_use
	,rank
FROM segment2 
WHERE rank <=5
ORDER BY segment, rank
