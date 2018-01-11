-- Chapter 5 Project work (4)
-- Category performance over time (Time series) 

/*	-- Scenario --- 

	-- We are an online retailer, our CEO of wants a performance analysis of DAILY sales by
	-- product grouped by product category for the year 2013 , the CEO wants to see when the 
	-- product was first sold																				Paul **

	-- Our CEO has requested when was the product first stocked to be added to the summary as well			Student **
	-- do CSQ on [dbo].[ProductInventory] 


*/

-- Initial build up

	select
		 [OrderDate]
		,[ProductName]
		,sum([SalesAmount]) as TotalSales
	from
		[dbo].[OnlineSales] os inner join
		[dbo].[Product] prod on os.ProductKey = prod.ProductKey
	group by	 
		 [OrderDate]
		,[ProductName]
	order by
		 [OrderDate]
		,[ProductName]	

-- Add product categories 

	select
		 convert(date,[OrderDate]) as [Purchase date]
		,pc.ProductCategoryName
		,[ProductName]
		,sum([SalesAmount]) as TotalSales
	from
		[dbo].[OnlineSales] os inner join
		[dbo].[Product] prod on os.ProductKey = prod.ProductKey and
								year([OrderDate]) = 2013		inner join
		[dbo].[ProductSubcategory] psc on prod.ProductSubcategoryKey = psc.ProductSubcategoryKey inner join
		[dbo].[ProductCategory] pc on psc.ProductCategoryKey = pc.ProductCategoryKey
	group by	 
		 [OrderDate]
		,pc.ProductCategoryName
		,[ProductName]
	order by
		 [OrderDate]
		,pc.ProductCategoryName
		,[ProductName]	
	
-- Add product first sold using correlated sub query


	select
		 convert(date,[OrderDate]) as [Purchase date]
		,pc.ProductCategoryName
		,[ProductName]
		,(select min(cast(os1.[OrderDate] as date)) from [dbo].[OnlineSales] os1 where os1.ProductKey = os.ProductKey ) as [First sold date]
		,sum([SalesAmount]) as TotalSales
	from
		[dbo].[OnlineSales] os inner join
		[dbo].[Product] prod on os.ProductKey = prod.ProductKey and
								year([OrderDate]) = 2013		inner join
		[dbo].[ProductSubcategory] psc on prod.ProductSubcategoryKey = psc.ProductSubcategoryKey inner join
		[dbo].[ProductCategory] pc on psc.ProductCategoryKey = pc.ProductCategoryKey
	group by	 
		 [OrderDate]
		,pc.ProductCategoryName
		,[ProductName]
		,os.ProductKey
	order by
		 [OrderDate]
		,pc.ProductCategoryName
		,[ProductName]	




-- Prac work, item was first stocked 


 				    