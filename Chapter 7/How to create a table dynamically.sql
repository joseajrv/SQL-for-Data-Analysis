-- How to create a database table dynamically from a query
-- Demo of Drop included


-- 1: Figure out your query then work out the , here I need a list of all bike sales 
--    that were not sold via a promotion i.e. No Discount


	select
	     ROW_NUMBER() over(ORDER BY year([OrderDate])) as SummaryId	
		,year([OrderDate])			 as SalesYear							
		,datepart(w,[OrderDate])	 as SalesWeek				
		,prod.ProductName
		,sum([SalesAmount])	as TotalSales			
		,round(avg([SalesAmount]),0)  as AverageSales
		,count([SalesAmount]) as SalesCount	
	from
		[dbo].[OnlineSales] os	inner join									-- For this data set all sales will have a promo key, hence inner join is ok to use
		[dbo].[Promotion]			 prom on os.PromotionKey = prom.PromotionKey and
															   prom.PromotionName='No Discount' inner join		
		[dbo].[Product]				 prod on os.ProductKey = prod.ProductKey inner join
		[dbo].[ProductSubcategory]	 psc on prod.ProductSubcategoryKey = psc.ProductSubcategoryKey inner join
		[dbo].[ProductCategory]	     pc on psc.ProductCategoryKey = pc.ProductCategoryKey and
																    pc.ProductCategoryName = 'Bikes'
	group by
		 year([OrderDate])	
		,datepart(w,[OrderDate])
		,prod.ProductName			
	order by
		1,2

	-- 2: add the datatyping, this saves the need to edit the table aftewards

	select
	     ROW_NUMBER() over(ORDER BY year([OrderDate])) as SummaryId	
		,year([OrderDate])			 as SalesYear							
		,datepart(w,[OrderDate])	 as SalesWeek				
		,prod.ProductName
		,cast(sum([SalesAmount]) as money)	as TotalSales			
		,cast(round(avg([SalesAmount]),0) as money)  as AverageSales	
		,count([SalesAmount]) as SalesCount	
	from
		[dbo].[OnlineSales] os	inner join									-- For this data set all sales will have a promo key, hence inner join is ok to use
		[dbo].[Promotion]			 prom on os.PromotionKey = prom.PromotionKey and
															   prom.PromotionName='No Discount' inner join		
		[dbo].[Product]				 prod on os.ProductKey = prod.ProductKey inner join
		[dbo].[ProductSubcategory]	 psc on prod.ProductSubcategoryKey = psc.ProductSubcategoryKey inner join
		[dbo].[ProductCategory]	     pc on psc.ProductCategoryKey = pc.ProductCategoryKey and
																pc.ProductCategoryName = 'Bikes'
	group by
		 year([OrderDate])	
		,datepart(w,[OrderDate])
		,prod.ProductName			
	order by
		1,2

-- 3: Now introduce the INTO clause which is like a big INSERT equivalent


	select
	     ROW_NUMBER() over(ORDER BY year([OrderDate])) as SummaryId	
		,year([OrderDate])			 as SalesYear							
		,datepart(w,[OrderDate])	 as SalesWeek				
		,prod.ProductName
		,cast(sum([SalesAmount]) as money)	as TotalSales			
		,cast(round(avg([SalesAmount]),0) as money)  as AverageSales	
		,count([SalesAmount]) as SalesCount	
	into
		[Chapter 7 - Sandpit].dbo.SalesByProductSummary
	from
		[dbo].[OnlineSales] os	inner join									-- For this data set all sales will have a promo key, hence inner join is ok to use
		[dbo].[Promotion]			 prom on os.PromotionKey = prom.PromotionKey and
															   prom.PromotionName='No Discount' inner join		
		[dbo].[Product]				 prod on os.ProductKey = prod.ProductKey inner join
		[dbo].[ProductSubcategory]	 psc on prod.ProductSubcategoryKey = psc.ProductSubcategoryKey inner join
		[dbo].[ProductCategory]		 pc on psc.ProductCategoryKey = pc.ProductCategoryKey and
																	pc.ProductCategoryName = 'Bikes'
	group by
		 year([OrderDate])	
		,datepart(w,[OrderDate])
		,prod.ProductName			
	order by
		1,2

--	drop table [Chapter 7 - Sandpit].[dbo].[SalesByProductSummary]



















	
-- 2: add the datatyping , shortcutting the extra work which would be needed by editing the table













-- 3: Now introduce the INTO clause which is like a big INSERT equivalent




