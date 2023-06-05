-- Top 3 serviceid are the most used
SELECT TOP 3
		Serviceid
		,COUNT(*) AS total_use
		,ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS rank
FROM [Zalo_Test].[dbo].['Data for part_2$']
GROUP BY Serviceid


-- Serviceids are usually used with the most used Serviceid
WITH top_service AS (
SELECT 
	*
FROM (SELECT
			Serviceid
			,COUNT(*) AS total_use
			,ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS rank
		FROM [Zalo_Test].[dbo].['Data for part_2$']
		GROUP BY Serviceid) AS q
WHERE rank =1
), total_users AS (
SELECT 
	DISTINCT a.User_id 
FROM [Zalo_Test].[dbo].['Data for part_2$'] AS a
JOIN top_service AS b
	ON a.Serviceid = b.Serviceid
)
SELECT TOP 3
	CONCAT('981', '-', Serviceid) AS crosssales_group
	,COUNT(*) AS total_uses
FROM [Zalo_Test].[dbo].['Data for part_2$']
WHERE User_id IN (SELECT User_id FROM total_users) AND Serviceid != 981
GROUP BY CONCAT('981', '-', Serviceid)
ORDER BY COUNT(*) DESC


-- Serviceids are usually used with the 2nd most used Serviceid
WITH top_service AS (
SELECT 
	*
FROM (SELECT
			Serviceid
			,COUNT(*) AS total_use
			,ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS rank
		FROM [Zalo_Test].[dbo].['Data for part_2$']
		GROUP BY Serviceid) AS q
WHERE rank =2
), total_users AS (
SELECT 
	DISTINCT a.User_id 
FROM [Zalo_Test].[dbo].['Data for part_2$'] AS a
JOIN top_service AS b
	ON a.Serviceid = b.Serviceid
)
SELECT TOP 3
	CONCAT('18', '-', Serviceid) AS crosssales_group
	,COUNT(*) AS total_uses
FROM [Zalo_Test].[dbo].['Data for part_2$']
WHERE User_id IN (SELECT User_id FROM total_users) AND Serviceid != 18
GROUP BY CONCAT('18', '-', Serviceid) 
ORDER BY COUNT(*) DESC

-- Serviceids are usually used with the 3rd most used Serviceid
WITH top_service AS (
SELECT 
	*
FROM (SELECT
			Serviceid
			,COUNT(*) AS total_use
			,ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS rank
		FROM [Zalo_Test].[dbo].['Data for part_2$']
		GROUP BY Serviceid) AS q
WHERE rank =3
), total_users AS (
SELECT 
	DISTINCT a.User_id 
FROM [Zalo_Test].[dbo].['Data for part_2$'] AS a
JOIN top_service AS b
	ON a.Serviceid = b.Serviceid
)
SELECT TOP 3
	CONCAT('667', '-', Serviceid) AS crosssales_group
	,COUNT(*) AS total_uses
FROM [Zalo_Test].[dbo].['Data for part_2$']
WHERE User_id IN (SELECT User_id FROM total_users) AND Serviceid != 667
GROUP BY CONCAT('667', '-', Serviceid) 
ORDER BY COUNT(*) DESC