-- Using case to discretise data

/*
	
 Discretization is puting data into buckets or bands for analysis
 this is a common data analysis function

 Scenario, the sales manager has requested a customer list with each customer and their age band 

 Banding rules are ...

			Age 19 - 32 = Gen Y
			Age 33 - 48 = Gen X
			Age 49 - 67 = Baby boomer
			Age 68 +    = Mature 

*/ 

	use [Chapter 3 - Sales (Keyed) ] ;

-- Foundation query

	select
		 [LastName]
		,[BirthDate]
	from
		[dbo].[Customer]

-- In order to calculate age, we need a baseline date to work with, this 
-- is provided using the GetDate() function

	select 
		 [LastName]
		,[BirthDate]
		,Getdate() as [Now]
	from
		[dbo].[Customer]


-- Calculate the age 

	select
		 [LastName]
		,[BirthDate]
		,cast(Getdate() as date) as [Now]
		,datediff(YEAR,[BirthDate],Getdate()) as Age
	from
		[dbo].[Customer]

-- Now setup the case logic

	select
	   [LastName]
	  ,[BirthDate]
	  ,Age
	  ,case
		when age between 19 and 32 then 'Gen - Y'
		when age between 33 and 48 then 'Gen - X'
		when age between 49 and 67 then 'Baby boomer'
       else
	    'Mature' 
	  end as AgeBand
	from
	(
		select
			 [LastName]
			,[BirthDate]
			,cast(Getdate() as date) TodaysDate
			,datediff(YEAR,[BirthDate],Getdate()) as Age
		from
			[dbo].[Customer]
	) as Ages

