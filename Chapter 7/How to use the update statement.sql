-- How to use the update statement 
-- The "U" in CRUD


use [Chapter 7 - Sandpit];

-- First a simple update statement

select
	 [CustomerName]
	,left([CustomerName],CHARINDEX(' ',[CustomerName])) as Surname
from
	[dbo].[CustomerDemoTable]


update
	[CustomerDemoTable] 
set CustomerName = 	left([CustomerName],CHARINDEX(' ',[CustomerName])) 

select * from [dbo].[CustomerDemoTable]


-- 2: Complex

-- Slightly more complex update, but very common to use
-- We shall undo the previous update

update [dbo].[CustomerDemoTable]
  set [CustomerName] =  c3Cust.LastName + ' ' + c3cust.FirstName 
from 
	[dbo].[CustomerDemoTable] as cdt inner join
  	[Chapter 3 - Sales (Keyed) ].[dbo].[Customer] as c3Cust on cdt.CustomerKey = c3Cust.CustomerKey


select * from [dbo].[CustomerDemoTable]


