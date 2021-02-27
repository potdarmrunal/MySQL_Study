CREATE DATABASE SUPERSTORES;
USE SUPERSTORES;

-- 1. Write a query to display the Customer_Name and Customer Segment using alias name “Customer Name", "Customer Segment" from table Cust_dimen. 
	SELECT Customer_Name 'Customer Name', Customer_Segment 'Customer Segment' from cust_dimen; 
    
-- 2. Write a query to find all the details of the customer from the table cust_dimen order by desc. 
	SELECT * FROM cust_dimen ORDER BY cust_Id DESC;
    
-- 3. Write a query to get the Order ID, Order date from table orders_dimen where ‘Order Priority’ is high. 
	SELECT Order_Id, Order_Date FROM orders_dimen WHERE Order_Priority = "HIGH";
    
-- 4. Find the total and the average sales (display total_sales and avg_sales)
	SELECT SUM(Sales), AVG(Sales) from market_fact;
    
-- 5. Write a query to get the maximum and minimum sales from maket_fact table
	SELECT MAX(Sales), MIN(Sales) from market_fact;
    
-- 6.  Display the number of customers in each region in decreasing order of no_of_customers. The result should contain columns Region, no_of_customers.
	SELECT REGION ,COUNT(Cust_Id) AS "No_Of_Customers" FROM cust_dimen GROUP BY REGION ORDER BY COUNT(Cust_Id) DESC;
    
-- 7.  Find the region having maximum customers (display the region name and max(no_of_customers)
    SELECT REGION ,COUNT(Cust_Id) AS "No_Of_Customers" FROM cust_dimen GROUP BY REGION ORDER BY COUNT(Cust_Id) DESC LIMIT 1;
    
-- 8. Find all the customers from Atlantic region who have ever purchased ‘TABLES’ and the number of tables purchased (display the customer name, no_of_tables purchased) 
	SELECT Customer_Name , COUNT(*) AS num_of_table 
		FROM market_fact S , prod_dimen P, cust_dimen C
		WHERE C.Cust_id = S.Cust_id 
        AND P.Product_Sub_Category = 'Tables'
        AND C.Region = 'ATLANTIC'
        GROUP BY Customer_Name;
	
-- 9. Find all the customers from Ontario province who own Small Business. (display the customer name, no of small business owners)
	SELECT Customer_Name , COUNT(*) AS no_of_Small_Business 
    FROM cust_dimen 
    WHERE Customer_Segment = "SMALL BUSINESS" 
    AND Region = "ONTARIO"
    GROUP BY Customer_Name;
    
-- 10. Find the number and id of products sold in decreasing order of products sold (display product id, no_of_products sold) 
	SELECT Prod_id,COUNT(*) AS `no_of_products sold` FROM market_fact GROUP BY Prod_id 
    ORDER BY count(`no_of_products sold`) DESC;
    
-- 11. Display product Id and product sub category whose produt category belongs toFurniture OR Technlogy. The result should contain columns product id, productsub category. 
	SELECT Prod_id,Product_Sub_Category FROM prod_dimen 
    WHERE Product_Category='FURNITURE' OR Product_Category='TECHNOLOGY'
    GROUP BY Prod_id;
    
-- 12. Display the product categories in descending order of profits (display the product category wise profits i.e. product_category, profits)?
	SELECT Product_Category , Profit 
    FROM prod_dimen P, market_fact M
    WHERE P.Prod_id = M.Prod_id
    GROUP BY Product_Category ORDER BY Profit DESC;
    
-- 13.Display the product category, product sub-category and the profit within each subcategory in three columns.
	SELECT Product_Category, Product_Sub_Category, Profit
    FROM prod_dimen P, market_fact M
    WHERE P.Prod_id = M.Prod_id
    GROUP BY Product_Sub_Category;
    
    
-- 14.Display the order date, order quantity and the sales for the order. 
	SELECT Order_Date, Order_Quantity, Sales
    FROM orders_dimen O, market_fact M
    WHERE O.Ord_id = M.Ord_id;
    
-- 15.Display the names of the customers whose name contains the i) Second letter as ‘R’ ii) Fourth letter as ‘D’ 
	SELECT Customer_Name FROM cust_dimen 
    WHERE Customer_Name LIKE '_R%' AND Customer_Name LIKE '___D%';
    
-- 16.Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and their region where sales are between 1000 and 5000.
	SELECT C.Cust_id, Sales, Customer_Name, Region
    FROM cust_dimen C, market_fact M
    WHERE C.cust_id = M.cust_id
    AND Sales BETWEEN 1000 AND 5000;
    
-- 17.Write a SQL query to find the 3rd highest sales. 
	SELECT MIN(Sales) '3RD HIGHEST SALES' FROM 
    (SELECT Sales FROM market_fact ORDER BY Sales DESC LIMIT 3) as MINSales;
    
-- 18. Where is the least profitable product subcategory shipped the most? For the least profitable product sub-category, display the region-wise no_of_shipments and the 
-- profit made in each region in decreasing order of profits (i.e. region,no_of_shipments, profit_in_each_region)
	SELECT Region,COUNT(Ship_id) AS no_of_shipment,SUM(Profit) AS profit_in_each_region FROM 
	cust_dimen c,market_fact s,prod_dimen p
	WHERE c.Cust_id = s.Cust_id AND s.Prod_id = p.Prod_id
	GROUP BY Region
	ORDER BY profit_in_each_region ASC;