-- Queries to find KPI’s

-- Displaying all of the data from the database -- 
SELECT * FROM Superstore

-- To find the total revenue, rounded to two decimals  286,817.02
SELECT ROUND(SUM(Profit),2) AS Total_Profit
FROM Superstore

-- Since there are multiple items in same Order ID, we use distinct to find average money spent per order  57.26
SELECT ROUND(SUM(Profit) / COUNT(DISTINCT Order_ID),2) AS Average_profit_per_order
FROM Superstore

-- Total quantities sold  37,873
SELECT SUM(Quantity) AS Total_products_sold
FROM Superstore

-- To find the total number of orders placed  5,009
SELECT COUNT(DISTINCT Order_ID) AS Total_Orders
FROM Superstore

-- Average Quantity per order  7
SELECT SUM(Quantity)/COUNT(DISTINCT Order_ID) AS Average_quantity_per_order
FROM Superstore

--Other Queries

-- Finding total products sold per year 
SELECT YEAR(Order_Date) AS Year_Sold, SUM(Quantity) AS Total_Quantity
FROM Superstore
GROUP BY YEAR(Order_Date)
ORDER BY YEAR(Order_Date)

-- Profit per year, ordered by year in ascending order

SELECT DISTINCT YEAR(Order_date) AS Sales_year, ROUND(SUM(Profit),2) AS Profit_per_year
FROM Superstore
GROUP BY YEAR(Order_date)
ORDER BY YEAR(Order_date) ASC

-- Total profit per region over the past four years

SELECT Region, ROUND(SUM(Profit), 2) AS Total_profit
FROM Superstore
GROUP BY Region
ORDER BY Total_profit DESC

-- Finding total number of orders per day of the week, ordered by the day of the week using case 

SELECT DATENAME(weekday, Order_Date) as Day_of_order, COUNT(DISTINCT Order_ID) as Total_orders
FROM Superstore
GROUP BY DATENAME(weekday, Order_Date)
ORDER BY
	CASE DATENAME(weekday, Order_Date)
		WHEN 'Sunday' THEN 1
		WHEN 'Monday' THEN 2
		WHEN 'Tuesday' THEN 3
		WHEN 'Wednesday' THEN 4
		WHEN 'Thursday' THEN 5
		WHEN 'Friday' THEN 6
		WHEN 'Saturday' THEN 7
	END

-- Finding total monthly orders, ordered by the months using case -- 

SELECT DATENAME(MONTH, Order_Date) as Order_month, COUNT(DISTINCT Order_ID) as Total_orders
FROM Superstore
GROUP BY DATENAME(MONTH, Order_Date)
ORDER BY 
	CASE DATENAME(MONTH, Order_Date)
		WHEN 'January' THEN 1
		WHEN 'February' THEN 2
		WHEN 'March' THEN 3
		WHEN 'April' THEN 4
		WHEN 'May' THEN 5
		WHEN 'June' THEN 6
		WHEN 'July' THEN 7
		WHEN 'August' THEN 8
		WHEN 'September' THEN 9
		WHEN 'October' THEN 10
		WHEN 'November' THEN 11
		WHEN 'December' THEN 12
	END

-- Finding profit per category and percentage of total sales per category --

SELECT DISTINCT Category, ROUND(SUM(Profit),2) AS Profit, ROUND(SUM(Profit)*100 / (SELECT SUM(Profit)FROM Superstore),2) AS Percentage_of_total_sales
FROM Superstore
/* To filter it for specific month, use WHERE and add the where clause to before the percentage_of_total_sales
WHERE MONTH(Order_Date) = 1
*/
GROUP BY Category
ORDER BY Percentage_of_total_sales DESC

-- To find the top 5 subcategories (products) that make the highest profit

SELECT TOP 5 Sub_Category, ROUND(SUM(Profit), 2) AS Total_profit 
FROM Superstore
GROUP BY Sub_Category
ORDER BY Total_Profit DESC

-- Products that are purchased frequently

SELECT Product_Name, COUNT(Order_ID) AS Order_count
FROM Superstore
GROUP BY Product_Name
ORDER BY Order_count DESC

-- To find the number of customers in specific regions

SELECT Region, COUNT(Customer_ID) AS Number_customers
FROM Superstore
GROUP BY Region
ORDER BY Number_customers DESC

-- Top 10 Customers with the highest numbers of orders throughout the years

SELECT TOP 10 Customer_ID, COUNT(Order_ID) AS Total_orders, ROUND(SUM(Sales),2) AS Total_spent
FROM Superstore
GROUP BY Customer_ID
ORDER BY Total_orders DESC

-- Products that make the highest profit

SELECT Product_ID, Product_Name, SUM(Profit) AS Total_profit
FROM Superstore
GROUP BY Product_ID, Product_Name
ORDER BY Total_profit DESC


