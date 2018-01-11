-- What the heck is a union ?

use [Chapter 3 - Sales (Keyed) ];

-- First select is for suppliers with credit rating 1

select
	 sup.Name
	,avg([StandardPrice]) as AvgStdPrice
	,sup.CreditRating 
	,sup.ActiveFlag 
from
	[dbo].[ProductSupplier] ps inner join
	[dbo].[Supplier] sup on ps.SupplierKey = sup.SupplierKey and
											 sup.CreditRating = 1
group by
	 sup.Name
	,sup.CreditRating 
	,sup.ActiveFlag

UNION ALL

-- Second select is for suppliers with credit rating 4

select
	 sup.Name
	,avg([StandardPrice]) as AvgStdPrice
	,sup.CreditRating 
	,sup.ActiveFlag 
from
	[dbo].[ProductSupplier] ps inner join
	[dbo].[Supplier] sup on ps.SupplierKey = sup.SupplierKey and
											 sup.CreditRating = 4
group by
	 sup.Name
	,sup.CreditRating 
	,sup.ActiveFlag
