-- How to use the insert statement 
-- The "C" in CRUD


insert into [dbo].[CustomerDemoTable]
(
	 [CustomerKey]
	,[CustomerName]
)
values
(
	20000 ,'Paul Scotchford'

) ,

(
	20010 ,'John Scotchford'

)

--	delete from [dbo].[CustomerDemoTable]
--  truncate table [dbo].[CustomerDemoTable]

--  select max([CustomerKey]) from [dbo].[CustomerDemoTable]

insert into [dbo].[CustomerDemoTable]
(
	 [CustomerKey]
	,[CustomerName]
)

select
	 distinct([CustomerKey])
	,[LastName] + ' ' + [FirstName]
from
	 [Chapter 3 - Sales (Keyed) ].[dbo].[Customer]


select * from [dbo].[CustomerDemoTable]

