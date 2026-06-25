 select * from Blinkit_data

 select count(*) from Blinkit_data

 update Blinkit_data
 set Item_Fat_Content =
 case
 when Item_Fat_Content IN ('low fat','Lf') then 'Low Fat'
 when Item_Fat_Content = 'reg' then 'Regular'
 else Item_Fat_Content
 end

 select distinct(Item_Fat_Content) from Blinkit_data

 --total revenue
 select sum(total_sales) as Revenue
 from Blinkit_data

 -- total revenue in millions
 select concat(cast(sum(total_sales)/1000000 as decimal(10,2)),'M') as Revenue_In_Millions
 from Blinkit_data

 -- avg revenue per sale
 select concat(cast(avg(total_sales) as decimal(10,1)),'M') as Avg_Revenue
 from Blinkit_data


 --total count of different items sold
 select count(*) as no_of_items
 from Blinkit_data      --because every row in DB is a item bought


 -- avg ratings
 select cast(avg(Rating) as decimal(10,2)) as Avg_ratings
 from Blinkit_data


 -- total sales, avg sales, no.of items and avg ratings by fat content
 SELECT Item_Fat_Content,
		CONCAT(CAST(SUM(Total_Sales)/1000 AS DECIMAL(10,2)), 'K') AS Total_Sales_ByFatContent,
		CAST(AVG(Total_Sales) AS DECIMAL(10,2)) AS Avg_Sales_ByFatContent,
		COUNT(*) AS No_of_items_ByCatContent,
		CAST(AVG(Rating) AS DECIMAL (10,2)) AS Avg_Ratings_ByFatContent
 FROM Blinkit_data
 GROUP BY Item_Fat_Content
 ORDER BY Total_Sales_ByFatContent DESC




 --total sales, avg sales, number of items,avg rating and top 5 items by Item Type
 --IF you want to find lowest performing items just replace DESC with ASC
 --In MYSQL LIMIT 5 was there but here it is TOP 5
 SELECT 
	TOP 5 Item_Type,
	CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales_By_ItemType,
	CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales_By_ItemType,
	COUNT(*) AS No_Of_Items_ByItm_Type,
	CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Ratings_By_ItemType
FROM Blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales_By_ItemType DESC

--Q3.Fat content by outlet for Total Sales -(Compare total sales across different outlets segmented by fat content)
select Outlet_Location_Type,
		cast(sum(case when Item_Fat_Content = 'Low Fat' then Total_Sales else 0 end) as decimal(10,2)) as Low_Fat,
		cast(sum(case when Item_Fat_Content = 'Regular' then Total_Sales else 0 end)as decimal(10,2)) as Regular
from Blinkit_data
group by Outlet_Location_Type
order by Outlet_Location_Type
		
	

--Q.total sales by Outlest establishment year
SELECT
    Outlet_Establishment_Year,
    cast(SUM(Total_Sales) as decimal(10,2)) AS Total_Sales,
	cast(AVG(Total_Sales) as decimal(10,2)) AS Avg_Sales,
	COUNT(*) AS No_of_items,
	cast(AVG(Rating) as decimal(10,2)) AS Avg_Ratings_ByYear
FROM Blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year;

--Q. Percentage of sales by Outlet Size
SELECT 
    Outlet_Size, 
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS total_sales, 
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS overall_sales 
FROM 
    Blinkit_data 
GROUP BY 
    Outlet_Size 
ORDER BY 
    overall_sales DESC;


	--Q. Sales by outlet location type
	SELECT
    Outlet_Location_Type,
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
	CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS percentage ,
	CAST(AVG(Total_Sales) AS DECIMAL(10,2)) AS Avg_Sales,
    COUNT(*) AS No_of_items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Ratings_ByLocation
FROM 
    Blinkit_data
GROUP BY 
    Outlet_Location_Type
ORDER BY 
    Total_Sales DESC;


--Q. all metrices by outlet type
SELECT
    Outlet_Type,
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
	CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS percentage ,
	CAST(AVG(Total_Sales) AS DECIMAL(10,2)) AS Avg_Sales,
    COUNT(*) AS No_of_items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Ratings_ByLocation
FROM 
    Blinkit_data
GROUP BY 
    Outlet_Type
ORDER BY 
    Total_Sales DESC;










