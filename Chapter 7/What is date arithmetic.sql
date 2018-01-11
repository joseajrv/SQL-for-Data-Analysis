-- Date arithmetic
-- What is it ?

use [Chapter 4 - Insurance];

-- There are many functions for manipulating dates, a few that are used frequently are DateDiff() and DateAdd() 

-- 1: Using datediff() to return the number of months between two dates
--    In this example I wish to know the average months between when a claim event and claim paid dates in the insurance claims table

-- Foundation query

	select
		 [ClaimType]	
		,[claimeventdate]
		,[claimpaiddate]
	from
		[dbo].[MemberClaims] 
	where
		[claimstatus] = 'Paid'
	order by
		 [ClaimType]		

	-- Include a date diff to view the months between the 2 dates

	select
		 [ClaimType]	
		,[claimeventdate]
		,[claimpaiddate]
		,datediff(m,[claimeventdate],[claimpaiddate]) as MonthsBetween
	from
		[dbo].[MemberClaims] 
	where
		[claimstatus] = 'Paid'
	order by
		 [ClaimType]	

	-- Include a date diff to view the months between the 2 dates and
	-- run an analytic over the Months 

	select
		 [ClaimType]	
		,avg(datediff(m,[claimeventdate],[claimpaiddate])) as AvgMonthsFromEventToPaid
	from
		[dbo].[MemberClaims] 
	where
		[claimstatus] = 'Paid'
	group by
		 [ClaimType]	
	order by
		 [ClaimType]	

	-- 2: Using dateadd to manipulate a date
	--    In this example I wish 

	use [Chapter 3 - Sales (Keyed) ];

	select 
		 [FullDateAlternateKey]
		,dateadd(m,-12,[FullDateAlternateKey]) as Date12MonthsAgo
		,dateadd(m,12,[FullDateAlternateKey]) as Date12MonthsFuture
	from
		[dbo].[Calendar]