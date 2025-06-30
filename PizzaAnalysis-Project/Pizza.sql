select *
from pizza_sales

-- KPI
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales

SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS Average_Order_Value
FROM pizza_sales

SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales

SELECT COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizza_Per_Order
FROM pizza_sales

-- Daily and Monthly Trend
select *
from pizza_sales
-- Daily:
SELECT DATENAME(DW, order_date) AS Day_Name
		,COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
-- Monthly:
SELECT DATENAME(MONTH, order_date) AS Month_Name
		,COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Order DESC

-- % of Sales by Category and Size
select *
from pizza_sales

-- % by Cat:
SELECT pizza_category
		,SUM(total_price) AS Total_Sales
		,SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS PCT
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

-- % by Size:
SELECT pizza_size
		,CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales
		,CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER,order_date) = 1) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
WHERE DATEPART(QUARTER,order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC

-- Top 5 & Bottom 5
SELECT  TOP 5 pizza_name
		,SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

SELECT  TOP 5 pizza_name
		,SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

SELECT  TOP 5 pizza_name
		,SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

SELECT  TOP 5 pizza_name
		,COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Order DESC

