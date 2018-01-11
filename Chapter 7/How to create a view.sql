-- How to create a view
--

-- drop view Top10Sales

create view Top10Sales as 
select
	 top(10) [TotalSales] 
			,[SalesYear]	
			,[SalesWeek]
			,[ProductName]
from
	[dbo].[SalesByProductSummary]
order by
	 [SalesYear]	
	,[SalesWeek]
	,[TotalSales] desc


select * from [dbo].[Top10Sales]